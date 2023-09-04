<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * TPBonus - Tp symfony réalisé dans le cadre de la formation
 * DWWM de l'école ENI - 2023
 * @author Gregoire Bouteillier
 */
class MainController extends AbstractController
{
    #[Route('/', name: 'app_main_home')]
    public function home(): Response
    {
        return $this->render('main/home.html.twig');
    }

/*    #[Route('/Produit/{id}', name: 'app_main_productById')]
    public function productById($id): Response
    {
        return $this->render('main/products/product.html.twig', [
            'id' => $id
        ]);
    }
*/
}
