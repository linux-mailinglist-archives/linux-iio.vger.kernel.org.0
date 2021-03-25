Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC468349917
	for <lists+linux-iio@lfdr.de>; Thu, 25 Mar 2021 19:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCYSHm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 14:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhCYSHP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Mar 2021 14:07:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02FB161A24;
        Thu, 25 Mar 2021 18:07:13 +0000 (UTC)
Date:   Thu, 25 Mar 2021 18:07:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@deviqon.com
Subject: Re: [PATCH] iio: adc: Kconfig: make AD9467 depend on ADI_AXI_ADC
 symbol
Message-ID: <20210325180716.5f966c21@jic23-huawei>
In-Reply-To: <c0220f77-da29-56a0-d528-90cafc0b391b@infradead.org>
References: <20210324182746.9337-1-aardelean@deviqon.com>
        <c0220f77-da29-56a0-d528-90cafc0b391b@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 11:45:14 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 3/24/21 11:27 AM, Alexandru Ardelean wrote:
> > Because a dependency on HAS_IOMEM and OF was added for the ADI AXI ADC
> > driver, this makes the AD9467 driver have some build/dependency issues
> > when OF is disabled (typically on ACPI archs like x86).
> > 
> > This is because the selection of the AD9467 enforces the ADI_AXI_ADC symbol
> > which is blocked by the OF (and potentially HAS_IOMEM) being disabled.
> > 
> > To fix this, we make the AD9467 driver depend on the ADI_AXI_ADC symbol.
> > The AD9467 driver cannot operate on it's own. It requires the ADI AXI ADC
> > driver to stream data (or some similar IIO interface).
> > 
> > So, the fix here is to make the AD9467 symbol depend on the ADI_AXI_ADC
> > symbol. At some point this could become it's own subgroup of high-speed
> > ADCs.
> > 
> > Fixes: be24c65e9fa24 ("iio: adc: adi-axi-adc: add proper Kconfig dependencies")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>  
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Applied to the fixes-togreg branch of iio.git.

I'll do a pull request to Greg sometime in next few days for that
branch.


thanks,

Jonathan

> 
> Thanks.
> 
> > ---
> > 
> > Apologies for this being too late.
> > I made the patch but forgot it in a local tree.
> > 
> > Related to discussion:
> >    https://lkml.org/lkml/2021/3/18/1007
> > 
> >  drivers/iio/adc/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index e0667c4b3c08..dda0f1e37ec1 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -249,7 +249,7 @@ config AD799X
> >  config AD9467
> >  	tristate "Analog Devices AD9467 High Speed ADC driver"
> >  	depends on SPI
> > -	select ADI_AXI_ADC
> > +	depends on ADI_AXI_ADC
> >  	help
> >  	  Say yes here to build support for Analog Devices:
> >  	  * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
> >   
> 
> 

