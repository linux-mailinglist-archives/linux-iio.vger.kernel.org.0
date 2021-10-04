Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AFB42095A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Oct 2021 12:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhJDKhv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 4 Oct 2021 06:37:51 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56397 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhJDKhs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2021 06:37:48 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 062311C000C;
        Mon,  4 Oct 2021 10:35:57 +0000 (UTC)
Date:   Mon, 4 Oct 2021 12:35:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [bug report] iio: adc: max1027: Use the EOC IRQ when populated
 for single reads
Message-ID: <20211004123556.38a1e1b3@xps13>
In-Reply-To: <20211004101701.GA22161@kili>
References: <20211004101701.GA22161@kili>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

dan.carpenter@oracle.com wrote on Mon, 4 Oct 2021 13:17:01 +0300:

> Hello Miquel Raynal,
> 
> The patch 54f14be01e17: "iio: adc: max1027: Use the EOC IRQ when
> populated for single reads" from Sep 21, 2021, leads to the following
> Smatch static checker warning:
> 
> 	drivers/iio/adc/max1027.c:289 max1027_wait_eoc()
> 	info: return a literal instead of 'ret'
> 
> drivers/iio/adc/max1027.c
>     278 static int max1027_wait_eoc(struct iio_dev *indio_dev)
>     279 {
>     280         struct max1027_state *st = iio_priv(indio_dev);
>     281         unsigned int conversion_time = MAX1027_CONVERSION_UDELAY;
>     282         int ret;
>     283 
>     284         if (st->spi->irq) {
>     285                 ret = wait_for_completion_timeout(&st->complete,
>     286                                                   msecs_to_jiffies(1000));
>     287                 reinit_completion(&st->complete);
>     288                 if (!ret)
> --> 289                         return ret;  
> 
> wait_for_completion_timeout() returns zero if it times out.  Should this
> be return an error code?  Otherwise we could just delete the "ret"
> variable and return 0 below.

I received this bug report, indeed this should use

			if (!ret)
				return -ETIMEDOUT;

Can you fix it directly? Do you want a fixup! patch to apply and
squash? Or a perhaps a regular patch?

> 
>     290         } else {
>     291                 if (indio_dev->active_scan_mask)
>     292                         conversion_time *= hweight32(*indio_dev->active_scan_mask);
>     293 
>     294                 usleep_range(conversion_time, conversion_time * 2);
>     295         }
>     296 
>     297         return 0;
>     298 }
> 
> regards,
> dan carpenter


Thanks,
Miquèl
