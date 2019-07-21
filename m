Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B806F442
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2019 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGURHw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jul 2019 13:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfGURHw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jul 2019 13:07:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5635320823;
        Sun, 21 Jul 2019 17:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563728872;
        bh=R8Hr0tfNTH4upkVmsaqqbj5X8e5xKssG+gEwj3raiy0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PLTh6buooMC1I/m8/mRQ9O7vfqGhNPS4NTl4SEiK/97o7YZ/WYLPDn3KhqwYxXRfz
         7WuSWFuaKZLmDBX873MR7hNgBh05sPMFyZyKtipRIMrlgSpmLQRhSWzshhBB5B683V
         9mQ+Sm/KDBCW31OXbzItSA7uUN+1zAd+feyb+Emo=
Date:   Sun, 21 Jul 2019 18:07:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gustavo@embeddedor.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: sca3000: Fix a typo
Message-ID: <20190721180746.7564f406@archlinux>
In-Reply-To: <20190721105353.30504-1-christophe.jaillet@wanadoo.fr>
References: <20190721105353.30504-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Jul 2019 12:53:53 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> All #define are about SCA3000_... except the last one.
> Make it consistent.
> 
> s/SAC3000/SCA3000/
> 
> This #define is apparently unused up to now.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied to the togreg branch of iio.git and pushed out as testing to have
no actually effect whatsoever ;)

Thanks for tidying this up!

Jonathan


> ---
>  drivers/iio/accel/sca3000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 4964561595f5..537e9325bcc7 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -114,7 +114,7 @@
>  /* Currently unsupported */
>  #define SCA3000_MD_CTRL_AND_Y				BIT(3)
>  #define SCA3000_MD_CTRL_AND_X				BIT(4)
> -#define SAC3000_MD_CTRL_AND_Z				BIT(5)
> +#define SCA3000_MD_CTRL_AND_Z				BIT(5)
>  
>  /*
>   * Some control registers of complex access methods requiring this register to

