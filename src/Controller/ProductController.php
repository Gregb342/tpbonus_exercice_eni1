<?php

namespace App\Controller;

use App\Entity\Product;
use App\Form\ProductType;
use App\Repository\ProductRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Validator\Constraints\Date;

/**
 * TPBonus - Tp symfony réalisé dans le cadre de la formation
 * DWWM de l'école ENI - 2023
 * @author Gregoire Bouteillier
 */
class ProductController extends AbstractController
{
    // Affichage de la liste de tout les produits
    #[Route('/Produits', name: 'app_main_products')]
    public function allProducts(ProductRepository $productRepository): Response
    {
       // $products = $productRepository->findBy([], ['label' => 'ASC'], 10, 0);
       // requete avec tri par ordre alphabétique et limité aux dix premiers résultats
        $products = $productRepository->findAll();

        return $this->render('product/allProducts.html.twig', [
            'products' => $products
            ]);
    }

    // affichage d'un seul produit
    #[Route('/Produit/{id}', name:'app_main_productById')]
    public function productById($id, ProductRepository $productRepository): Response
    {
        $product = $productRepository->find($id);

        if (!$product) {
            throw $this->createNotFoundException(
                'No product found for id '.$id
            );
        }

        return $this->render('product/product.html.twig', [
            'product'=>$product
        ]);
    }

    // creation d'un nouveau produit
    #[Route('/NouveauProduit', name: 'app_main_addProduct')]
    public function addProduct(
                    Request $request,
                    EntityManagerInterface $entityManager
                    ): Response
    {
        $product = new Product();
        $product->setDateAdd(new \DateTime()); // penser à générer la date du jour pour le champ date afin qu'il soit non-null

        $productForm = $this->createForm(ProductType::class, $product);
        $productForm->handleRequest($request);

        if ($productForm->isSubmitted() && $productForm->isValid()){

            $entityManager->persist($product);
            $entityManager->flush();
            $this->addFlash('bg-success', 'Le produit a bien été ajouté.');
            return $this->redirectToRoute('app_main_addProduct');

        }

        return $this->render('product/newProduct.html.twig', [
            'productForm' => $productForm->createView()
        ]);
    }

    // Editer un produit
    #[Route('/EditerProduit/{id}', name: 'app_main_editProduct')]
    public function editProduct(
        $id,
        ProductRepository $productRepository,
        EntityManagerInterface $entityManager,
        Request $request,
    ): Response {
        $product = $productRepository->find($id);

        if (!$product) {
            throw $this->createNotFoundException('No product found for id ' . $id);
        }

        $product->setDateEdit(new \DateTime());

        $productForm = $this->createForm(ProductType::class, $product);
        $productForm->handleRequest($request);

        if ($productForm->isSubmitted() && $productForm->isValid()) {
            $entityManager->persist($product);
            $entityManager->flush();
            $this->addFlash('bg-success', 'Le produit a bien été modifié.');
            // Redirection vers la page du produit
            return $this->redirectToRoute('app_main_productById', ['id' => $product->getId()]);
        }

        // Affichage le formulaire d'édition du produit
        return $this->render('product/editProduct.html.twig', [
            'product' => $product,
            'productForm' => $productForm->createView(),
        ]);
    }

    // Supprimer un produit
    #[Route('/SupprimerProduit/{id}', name: 'app_main_deleteProduct')]
    public function deleteProduct(
            $id,
            ProductRepository $productRepository,
            EntityManagerInterface $entityManager
            ): Response
    {
        $product = $productRepository->find($id);

        if (!$product) {
            throw $this->createNotFoundException(
                'No product found for id '.$id
            );

        } else {

            $entityManager->remove($product);
            $entityManager->flush();
            $this->addFlash('bg-danger', 'Le produit a bien été supprimé.');
        }

        return $this->redirectToRoute('app_main_products');
    }


}
