<?php

namespace App\Controller;

use App\Entity\Category;
use App\Entity\Product;
use App\Form\CategoryType;
use App\Form\ProductType;
use App\Repository\CategoryRepository;
use App\Repository\ProductRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * TPBonus - Tp symfony réalisé dans le cadre de la formation
 * DWWM de l'école ENI - 2023
 * @author Gregoire Bouteillier
 */
class CategoryController extends AbstractController
{

    // Affichage de la liste de toutes les catégories
    #[Route('/Categories', name: 'app_categories')]
    public function allProducts(CategoryRepository $categoryRepository): Response
    {

        $categories = $categoryRepository->findAll();

        return $this->render('category/allCategories.html.twig', [
            'categories' => $categories
        ]);
    }

    // creation d'un nouveau produit
    #[Route('/NouvelleCategorie', name: 'app_main_addCategory')]
    public function addCategory(
        Request $request,
        EntityManagerInterface $entityManager
    ): Response
    {
        $category = new Category();

        $categoryForm = $this->createForm(CategoryType::class, $category);
        $categoryForm->handleRequest($request);

        if ($categoryForm->isSubmitted() && $categoryForm->isValid()){

            $entityManager->persist($category);
            $entityManager->flush();
            $this->addFlash('bg-success', 'La catégorie a bien été ajoutée.');
            return $this->redirectToRoute('app_categories');

        }

        return $this->render('category/newCategory.html.twig', [
            'productForm' => $categoryForm->createView()
        ]);
    }
}
