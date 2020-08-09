Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6BF23FEAA
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 16:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgHIOHH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 10:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgHIOHH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 10:07:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17293206E9;
        Sun,  9 Aug 2020 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596982026;
        bh=UYU/xFGpXCKIgoPl8PZr1JCwYSgjuX6jwd7DhXZgdWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ENx3xTKv2SV4di5186qD+ppwnO5LPzA76E3SLeAsR+d2aJtPk6GPxktlzmOrCE4At
         tZkuNCQHLJzTq1Ee1jOqlwBrx8XLf088t41w2JlDfduxu7OYOh2p/8F76uasOzbxPy
         PxjzuYujZSPjqzwnbk0VH2ciJaUOyIRzvcMT8A28=
Date:   Sun, 9 Aug 2020 15:07:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: Re: [PATCH v2 4/5] iio:adc:ti-adc128s052: drop of_match_ptr
 protection
Message-ID: <20200809150703.01c0b806@archlinux>
In-Reply-To: <CAHp75Vfh5PjaMLkAL_N6UCVFttSe+qF_pZ75bqo8jinSDXmqug@mail.gmail.com>
References: <20200721171444.825099-1-jic23@kernel.org>
        <20200721171444.825099-5-jic23@kernel.org>
        <CAHp75Vfh5PjaMLkAL_N6UCVFttSe+qF_pZ75bqo8jinSDXmqug@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jul 2020 21:32:03 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jul 21, 2020 at 8:16 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > There is no real advantage in having these protections and
> > for parts that do not have an explicit ACPI ID, it prevents the
> > use of PRP0001. I'm trying to clear this out of IIO in general
> > to avoid copying in new drivers.
> >
> > Include mod_devicetable.h as we are using of_device_id in here so
> > including that header is best practice.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied,

Thanks,

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> > ---
> >  v1->v2
> >  * Mention that some parts of valid IDs, so we are interesting in
> >    enabling PRP0001 option for those that don't.
> >
> >  drivers/iio/adc/ti-adc128s052.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> > index e86f55ce093f..3143f35a6509 100644
> > --- a/drivers/iio/adc/ti-adc128s052.c
> > +++ b/drivers/iio/adc/ti-adc128s052.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/err.h>
> >  #include <linux/spi/spi.h>
> >  #include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/property.h>
> >  #include <linux/regulator/consumer.h>
> > @@ -220,7 +221,7 @@ MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
> >  static struct spi_driver adc128_driver = {
> >         .driver = {
> >                 .name = "adc128s052",
> > -               .of_match_table = of_match_ptr(adc128_of_match),
> > +               .of_match_table = adc128_of_match,
> >                 .acpi_match_table = ACPI_PTR(adc128_acpi_match),
> >         },
> >         .probe = adc128_probe,
> > --
> > 2.27.0
> >  
> 
> 

