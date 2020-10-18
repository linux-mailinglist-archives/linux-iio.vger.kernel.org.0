Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F182916E0
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 12:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgJRKHi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 06:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgJRKHi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 06:07:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0993621582;
        Sun, 18 Oct 2020 10:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603015658;
        bh=wIiA9KBDcc136KGq4f/BMgcBH20BwV1jX2a9QCEH+uw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pufOCh9Lhfwp+boIkjf7lnup05nEyglSaMVcpi5nrWVcWPlxyt06Z25c4wqDjPtSw
         WtwAA6D2IC66P5MMXjRxtebomvVCyPopbAFurz76ZrsTJRy3UGj5EbdX1tMxeW6jlt
         3jI75MAxOjA0D9BBP0MsArqiEtXRYK/yDIlNUY+4=
Date:   Sun, 18 Oct 2020 11:07:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        chun-hung.wu@mediatek.com, alexandru.ardelean@analog.com,
        pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de
Subject: Re: [PATCH] iio: adc: mediatek: fix unset field
Message-ID: <20201018110738.36e3de38@archlinux>
In-Reply-To: <61fe6278-a628-820c-6bbd-eeac51b1e7c3@gmail.com>
References: <20201012194618.2170970-1-fparent@baylibre.com>
        <61fe6278-a628-820c-6bbd-eeac51b1e7c3@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Oct 2020 17:37:12 +0200
Matthias Brugger <matthias.bgg@gmail.com> wrote:

> On 12/10/2020 21:46, Fabien Parent wrote:
> > dev_comp field is used in a couple of places but it is never set. This
> > results in kernel oops when dereferencing a NULL pointer. Set the
> > `dev_comp` field correctly in the probe function.
> > 
> > Fixes: 6d97024dce23 ("iio: adc: mediatek: mt6577-auxadc, add mt6765 support")
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>  
> 
> Ouch.
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> > ---
> >   drivers/iio/adc/mt6577_auxadc.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> > index ac415cb089cd..7bd48377cd79 100644
> > --- a/drivers/iio/adc/mt6577_auxadc.c
> > +++ b/drivers/iio/adc/mt6577_auxadc.c
> > @@ -276,6 +276,8 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
> >   		goto err_disable_clk;
> >   	}
> >   
> > +	adc_dev->dev_comp = of_device_get_match_data(&pdev->dev);
> > +

Could we switch this to device_get_match_data(&pdev->dev)?

Whilst is unlikely this driver will used in a platform using ACPI, there
is nothing inside the driver itself preventing this (which is good as no
reason to do so!)   My main motivation for this is to reduce the chances
of cut and paste of the of_* functions in future driver.

Also switch the headers to linux/property.h and linux/mod_devicetable.h 
to more tightly reflect what we are using in the driver.

Thanks,

Jonathan

> >   	mutex_init(&adc_dev->lock);
> >   
> >   	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
> >   

