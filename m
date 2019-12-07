Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1471115BC1
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 10:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfLGJrb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 04:47:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfLGJrb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 04:47:31 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581DA2173E;
        Sat,  7 Dec 2019 09:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575712050;
        bh=x5JujE3i07d0bsKJYqzwCjDXd/iWs1aKugPrgag74oE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0GGXZdGJ0TwSAsThJX/bp6u7+w17/oj51v9UlSs+TxlcHmhNh2wg5C6dkcpyUuyVj
         GvUHF0FaRAesln52GtkByyHo3IjHRvCkC2pSyHfavNsU6MLIW5Ja3bM4INxTrUYBXq
         xjCuQrSRfBij2udy1rlH/CaR01jAG/20SZwc3iN4=
Date:   Sat, 7 Dec 2019 09:47:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: ad5592r: Drop surplus GPIO header
Message-ID: <20191207094726.79a4ea89@archlinux>
In-Reply-To: <6243735810a5a88677027e01189c86a2c69552b2.camel@analog.com>
References: <20191202085848.81573-1-linus.walleij@linaro.org>
        <6243735810a5a88677027e01189c86a2c69552b2.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Dec 2019 09:04:14 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2019-12-02 at 09:58 +0100, Linus Walleij wrote:
> > This driver uses all the modern GPIO APIs from
> > <linux/gpio/driver.h> and <linux/gpio/consumer.h> so
> > just drop the unused legacy header <linux/gpio.h>.
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
applied,

Thanks,

Jonathan

> 
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/iio/dac/ad5592r-base.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-
> > base.c
> > index 2d897e64c6a9..e2110113e884 100644
> > --- a/drivers/iio/dac/ad5592r-base.c
> > +++ b/drivers/iio/dac/ad5592r-base.c
> > @@ -15,7 +15,6 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/gpio/driver.h>
> > -#include <linux/gpio.h>
> >  #include <linux/property.h>
> >  
> >  #include <dt-bindings/iio/adi,ad5592r.h>  

