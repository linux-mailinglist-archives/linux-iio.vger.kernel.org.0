Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84342147BE
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgGDRc5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgGDRc5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:32:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D039C20748;
        Sat,  4 Jul 2020 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593883976;
        bh=2fg3p6oB2BjEktCm8zrLlxgSbit6BkBA3aiOdM8LjwA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ElNfsyqsM0AuXWtV+f0yQJWjBioMpsrX3m5cTNeYJoGuwu47Pd6TPhFr/MDJBRUNJ
         vdpVwzIavog/Bs/FHf5WTS0UD/UGLHF1EzSbkdUPvP7gjj9vzSRiRX0e28NBFETq2I
         mOV4KJhiio0w9DyP+FpbHq6q6SqyltE/V80GZ0rg=
Date:   Sat, 4 Jul 2020 18:32:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Phil Reid <preid@electromag.com.au>
Cc:     linux-iio@vger.kernel.org, alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 21/23] iio:adc:ti-tlc4541: Drop CONFIG_OF and
 of_match_ptr protections.
Message-ID: <20200704183252.2570afe4@archlinux>
In-Reply-To: <ba126f3c-b1f8-0d21-c95a-bda1573b047e@electromag.com.au>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-22-jic23@kernel.org>
        <ba126f3c-b1f8-0d21-c95a-bda1573b047e@electromag.com.au>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Jun 2020 07:43:55 +0800
Phil Reid <preid@electromag.com.au> wrote:

> On 28/06/2020 20:36, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > These stop us using ACPI PRP0001 to instantiate the device.
> > I am slowly clearly out use of these in IIO to avoid this being coppied
> > into new drivers.
> > 
> > Here I also included mod_devicetable.h as we are using of_match_id
> > which is defined in there and hence it is best practice to include
> > it directly.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Phil Reid <preid@electromag.com.au>  
> 
> Reviewed-by: Phil Reid <preid@electromag.com.au>

Applied,

Thanks,

Jonathan

> 
> > ---
> >   drivers/iio/adc/ti-tlc4541.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
> > index 432238246519..53359a2e5bea 100644
> > --- a/drivers/iio/adc/ti-tlc4541.c
> > +++ b/drivers/iio/adc/ti-tlc4541.c
> > @@ -24,6 +24,7 @@
> >   #include <linux/iio/triggered_buffer.h>
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> >   #include <linux/regulator/consumer.h>
> >   #include <linux/slab.h>
> >   #include <linux/spi/spi.h>
> > @@ -235,14 +236,12 @@ static int tlc4541_remove(struct spi_device *spi)
> >   	return 0;
> >   }
> >   
> > -#ifdef CONFIG_OF
> >   static const struct of_device_id tlc4541_dt_ids[] = {
> >   	{ .compatible = "ti,tlc3541", },
> >   	{ .compatible = "ti,tlc4541", },
> >   	{}
> >   };
> >   MODULE_DEVICE_TABLE(of, tlc4541_dt_ids);
> > -#endif
> >   
> >   static const struct spi_device_id tlc4541_id[] = {
> >   	{"tlc3541", TLC3541},
> > @@ -254,7 +253,7 @@ MODULE_DEVICE_TABLE(spi, tlc4541_id);
> >   static struct spi_driver tlc4541_driver = {
> >   	.driver = {
> >   		.name   = "tlc4541",
> > -		.of_match_table = of_match_ptr(tlc4541_dt_ids),
> > +		.of_match_table = tlc4541_dt_ids,
> >   	},
> >   	.probe          = tlc4541_probe,
> >   	.remove         = tlc4541_remove,
> >   
> 

