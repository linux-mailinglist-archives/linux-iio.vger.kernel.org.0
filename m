Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004C2214C43
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jul 2020 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgGEL7k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jul 2020 07:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGEL7j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Jul 2020 07:59:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B676920708;
        Sun,  5 Jul 2020 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593950379;
        bh=jbRIrixoWn2wn5oaON87KKkPJd5FmrO9b7ka7N4hgrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANj26gvSSKhAJ6k+Pnrg6oJP4v0rt8rdFOz/5D7I6wlHQKJeTVj+5OGSsz6xJuOQt
         5trO/iUy3WPHHsh2DOuSjRBR8XpWJFNIz8JSxaBZ8lRlFTB/HsYm2XGdoSd0UZ6uk/
         SAO3o8UXeiBHbaO1CgPjfj/S/bqPnn3JhNxTnASM=
Date:   Sun, 5 Jul 2020 12:59:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Michael.Hennerich@analog.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, giuliano.belinassi@usp.br,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7780: Fix a resource handling path in
 'ad7780_probe()'
Message-ID: <20200705125935.025cfa12@archlinux>
In-Reply-To: <20200518022129.xkcuw4yxotnll7ym@renatolg>
References: <20200517095953.278950-1-christophe.jaillet@wanadoo.fr>
        <20200518022129.xkcuw4yxotnll7ym@renatolg>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 May 2020 23:21:29 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> Acked-by: Renato Lui Geh <renatogeh@gmail.com>
> 
> On 05/17, Christophe JAILLET wrote:
> >If 'ad7780_init_gpios()' fails, we must not release some resources that
> >have not been allocated yet. Return directly instead.
> >
> >Fixes: 5bb30e7daf00 ("staging: iio: ad7780: move regulator to after GPIO init")
> >Fixes: 9085daa4abcc ("staging: iio: ad7780: add gain & filter gpio support")
> >Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> >---
> > drivers/iio/adc/ad7780.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
> >index f47606ebbbbe..b33fe6c3907e 100644
> >--- a/drivers/iio/adc/ad7780.c
> >+++ b/drivers/iio/adc/ad7780.c
> >@@ -329,7 +329,7 @@ static int ad7780_probe(struct spi_device *spi)
> >
> > 	ret = ad7780_init_gpios(&spi->dev, st);
> > 	if (ret)
> >-		goto error_cleanup_buffer_and_trigger;
> >+		return ret;
> >
> > 	st->reg = devm_regulator_get(&spi->dev, "avdd");
> > 	if (IS_ERR(st->reg))
> >-- 
> >2.25.1
> >  

