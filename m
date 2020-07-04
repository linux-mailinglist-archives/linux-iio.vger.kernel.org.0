Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF169214789
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 18:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgGDQt7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 12:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgGDQt6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 12:49:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9539020826;
        Sat,  4 Jul 2020 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593881398;
        bh=pyT+Oe5Ok23mcBzoH5DXYwxVgIf5lU8ZzMVfPUfvIpU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N/ctb//pEb5j/PDiaedxucy1MWKQp+aZml6bS3d4Nfz0yQLsRBE+ItXD2LqPZTQvL
         sE7lL3Q9IbdzW1hS9GyQdl354QmHXdi9jkAfKSMWUhx7/pwNZcLmNdcVgFG4Fg2ssN
         GU2yfb7mgsMc+heaUNOs0Sq0wPHkDWE+mzKiwOoU=
Date:   Sat, 4 Jul 2020 17:49:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/23] iio:adc:lpc32xx: Drop of_match_ptr protection
Message-ID: <20200704174954.38f5e40b@archlinux>
In-Reply-To: <CAHp75Vdxjb2ZR3HVVnfQpTpa=Ts2ToFJ-qG9NkXV7E9pcSx7JQ@mail.gmail.com>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-2-jic23@kernel.org>
        <CAHp75Vdxjb2ZR3HVVnfQpTpa=Ts2ToFJ-qG9NkXV7E9pcSx7JQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 30 Jun 2020 10:01:29 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Whilst is unlikely anyone will be using this part with an ACPI PRP0001
> > based binding any time soon, we are getting a lot of cut and pasting
> > of this pattern so I am looking to remove it entirely from IIO.
> >
> > In this case CONFIG_OF protections also removed and
> > mod_devicetable.h include added given direct use of struct of_device_id.
> >  
> 
> Yes, it also fixes indirect inclusion of of.h.
> LGTM!
> 
Thanks, added RB as per cover letter reply.

Applied to the togreg branch of iio.git and pushed out as testing to
see if I missed anything.

Thanks,

Jonathan

> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/adc/lpc32xx_adc.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> > index bc2712a48844..b56ce15255cf 100644
> > --- a/drivers/iio/adc/lpc32xx_adc.c
> > +++ b/drivers/iio/adc/lpc32xx_adc.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > +#include <linux/mod_devicetable.h>  
> 
> 
> >  #include <linux/platform_device.h>
> >  #include <linux/regulator/consumer.h>
> >
> > @@ -209,19 +210,17 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > -#ifdef CONFIG_OF
> >  static const struct of_device_id lpc32xx_adc_match[] = {
> >         { .compatible = "nxp,lpc3220-adc" },
> >         {},
> >  };
> >  MODULE_DEVICE_TABLE(of, lpc32xx_adc_match);
> > -#endif
> >
> >  static struct platform_driver lpc32xx_adc_driver = {
> >         .probe          = lpc32xx_adc_probe,
> >         .driver         = {
> >                 .name   = LPC32XXAD_NAME,
> > -               .of_match_table = of_match_ptr(lpc32xx_adc_match),
> > +               .of_match_table = lpc32xx_adc_match,
> >         },
> >  };
> >
> > --
> > 2.27.0
> >  
> 
> 

