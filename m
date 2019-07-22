Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFD66F9C4
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 08:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfGVG43 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 02:56:29 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40151 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfGVG43 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 02:56:29 -0400
Received: from [192.168.1.110] ([77.2.59.209]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQMm9-1i2I7Z2eBN-00MOVt; Mon, 22 Jul 2019 08:55:56 +0200
Subject: Re: [PATCH] iio: sca3000: Fix a typo
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gustavo@embeddedor.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190721105353.30504-1-christophe.jaillet@wanadoo.fr>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <0d698979-d0da-5225-6dc3-e2ddebb31279@metux.net>
Date:   Mon, 22 Jul 2019 08:55:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190721105353.30504-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jbeW2KE7dRGinHyZMgpPz8HUGa+WPHCRWrb39H5ZnK53XYC+xG0
 oEDKFlxKLjhX2jJ+E4j2QFm57yuYhw6ThBxjJHsZkFcfIJr3194KtHE3Y5AoAxyRyu5KoFx
 AH1gt1Ui1CHgKOjh+gaSDz8WkLVanfP4AygsCG4g0XpszQiprt7h6m33YWH2JFpWBNlYtS3
 SRFBsJ6e1PKj7RMdiYHcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KCwfldBYtuE=:B2E4He/sYzPrOa2E+sZCOD
 LYt9aqxGZ+QDSD/Y/SW0Hc7X3T6VxXSAZQnDsPhoNaFIZxmtFhUN9EOaV6/ydOxD0S5arTkgE
 aK7taMBwo0Cu5PHJAxhTLmZSJre4x5Gf63CRNPy6rBYEdG6qY11vNmqUY5LMEGI4ayXuFmNHz
 DW08a7XFqNaivRt+2UI/c6+/KVeArkwjBNaSwLpd0pPUe/pwn9lq190nYtH9TTLZKXovRj5Cb
 jK2d8L9L2nXN0nmFT4QgcJ7Vdi5kEI3VFiQ/r0vS3BfKuX+5MTXUhYdRGXsAwQMuSrNojfJDx
 NzrHYzq39NZKFrpqJb+8SyMP8t02Kdx2d9LM+UNEiTNSxWXGIu935INeGMqDBaHMNx38GCSVO
 z945k3iH+826NyPFbkywvIKU501Bxms6KwpnPMcB6JQpeY35K5ZVr71uGxPO0WP6VkAca9Njb
 c2sWlXEXY/4XN3lcjP7t5OlK+6RigqavipsJ7NTNKf5THUelPLhrLE/ecou5eUxtthcydDn3Z
 nnLn2vajeLRC85V9cp9Bljc4S2c/TbFh8B/gCGY2jQ3mj9MtcPopI854/Y7Bgd8ezkFcAnuWz
 U9MremWNxI2/7yeOMj1H4GLGUZgO34gh+0oJ3mmWg0hQeC1GfWwY2FCvyrIajFoM00XhL7B5M
 QJYm194D9fhkGrJ2uUuP4dJ+0DC5TFB3Bs6OWmVz6yZucerRZGbBgFl7nog5Bj5gPneAHKkR5
 G3IvO6n6YInFJDAlqHpDD3IyUakKVS+0SeDzJermyNwQ3cshnbx67NSbq8w=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 21.07.19 12:53, Christophe JAILLET wrote:
> All #define are about SCA3000_... except the last one.
> Make it consistent.
> 
> s/SAC3000/SCA3000/
> 
> This #define is apparently unused up to now.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/iio/accel/sca3000.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 4964561595f5..537e9325bcc7 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -114,7 +114,7 @@
>   /* Currently unsupported */
>   #define SCA3000_MD_CTRL_AND_Y				BIT(3)
>   #define SCA3000_MD_CTRL_AND_X				BIT(4)
> -#define SAC3000_MD_CTRL_AND_Z				BIT(5)
> +#define SCA3000_MD_CTRL_AND_Z				BIT(5)
>   
>   /*
>    * Some control registers of complex access methods requiring this register to
> 
Reviewed-By: Enrico Weigelt <info@metux.net>

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
