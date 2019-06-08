Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96BFD39F49
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 13:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfFHLzf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 07:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfFHLzf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 07:55:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA00C214AE;
        Sat,  8 Jun 2019 11:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994934;
        bh=F6qhJyzp+hpUv2sORpYggFf/Ny8xu1gIsJ0ENP514b0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=09qiwXFGhaa0dUCKYNylcQjOmR+PZj6LLK6kzr2MTogPnwnqDJrPaCx8UDHx1Lwx5
         anuhyP2nWsxCDj5938enn1xIWXRQNmwTkpx3rSeHz960Q2W2l/jrwTHVlsrTVfSgvL
         0EKfyn+xGi2R6rlkcc/CCV9rThV12vyKN0KJ6yEU=
Date:   Sat, 8 Jun 2019 12:55:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Fabio Estevam <festevam@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        preid@electromag.com.au
Subject: Re: [PATCH v2] staging: iio: adt7316: Fix build errors when GPIOLIB
 is not set
Message-ID: <20190608125529.6aa5c0a7@archlinux>
In-Reply-To: <7edb325e-9af8-8ae8-d26e-da75c0252284@infradead.org>
References: <20190606020532.4864-1-festevam@gmail.com>
        <7edb325e-9af8-8ae8-d26e-da75c0252284@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 Jun 2019 20:24:09 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 6/5/19 7:05 PM, Fabio Estevam wrote:
> > On x86_64 when GPIOLIB is not set the following build errors
> > are seen:
> > 
> > drivers/staging/iio/addac/adt7316.c:947:3: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]
> > drivers/staging/iio/addac/adt7316.c:1805:2: error: implicit declaration of function 'irqd_get_trigger_type' [-Werror=implicit-function-declaration]
> > 
> > These functions are provided by the <linux/gpio/consumer.h>
> > and <linux/irq.h> headers, so include them to fix these
> > build errors.
> > 
> > While at it, remove <linux/gpio.h> as this driver is a GPIO
> > consumer and not a GPIO driver.
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>  
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Applied to the fixes-togreg branch of iio.git.

thanks,

Jonathan

> 
> Thanks.
> 
> > ---
> > Changes since v1:
> > - Remove <linux/gpio.h> - Phil
> > 
> >  drivers/staging/iio/addac/adt7316.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> > index 37ce563cb0e1..9cb3d0e42c38 100644
> > --- a/drivers/staging/iio/addac/adt7316.c
> > +++ b/drivers/staging/iio/addac/adt7316.c
> > @@ -6,7 +6,8 @@
> >   */
> >  
> >  #include <linux/interrupt.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/irq.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> >   
> 
> 

