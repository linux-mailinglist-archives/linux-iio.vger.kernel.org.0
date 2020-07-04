Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F8214756
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 18:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGDQZU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 12:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGDQZU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 12:25:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D455206B6;
        Sat,  4 Jul 2020 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593879919;
        bh=d9wAKSTFHHfxUvA3cee6eoc0gwiwFmyHySjzcuoinZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fPm54MQVRkUW/71xgv1U7kehxg5oPGZW1FMgemryS9ozx/rw3vEHBvXo22MZS23n3
         CBHXZVfLDJAq+FPTMyxC0QsyivVzLj/sRSpPWhekXVZclLtj8OCnUlZTjFJGU5Py6Y
         KlKwDag1SZSR/rO7FVrpwh1ZA5C4AKTia/zuUCg8=
Date:   Sat, 4 Jul 2020 17:25:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, tomislav.denis@avl.com, ak@it-klinger.de,
        lukas@wunner.de, sergiu.cuciurean@analog.com,
        andriy.shevchenko@linux.intel.com, christophe.jaillet@wanadoo.fr,
        gregory.clement@bootlin.com, alexandre.belloni@bootlin.com,
        sre@kernel.org, matt.ranostay@konsulko.com, hslester96@gmail.com,
        chris.lesiak@licor.com, alexandru.ardelean@analog.com,
        dannenberg@ti.com, dpfrey@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: drivers/iio
Message-ID: <20200704172513.03815356@archlinux>
In-Reply-To: <20200703223124.16081-1-grandmaster@al2klimov.de>
References: <20200703223124.16081-1-grandmaster@al2klimov.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  4 Jul 2020 00:31:24 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 

I did a quick click through of the resulting links. 

> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index b938f07eed64..612cecbf8e7e 100644
> --- a/drivers/iio/humidity/si7020.c
> +++ b/drivers/iio/humidity/si7020.c
> @@ -13,7 +13,7 @@
>   *
>   * Data Sheets:
>   *   Si7013: http://www.silabs.com/Support%20Documents/TechnicalDocs/Si7013.pdf
> - *   Si7020: http://www.silabs.com/Support%20Documents/TechnicalDocs/Si7020.pdf
> + *   Si7020: https://www.silabs.com/Support%20Documents/TechnicalDocs/Si7020.pdf
>   *   Si7021: http://www.silabs.com/Support%20Documents/TechnicalDocs/Si7021.pdf
The original and new link don't actually work. 

Seems they have changed the doc name. Not sure what the A20 reflects but there
doesn't seem to be any other variant of each of these.

https://www.silabs.com/documents/public/data-sheets/Si7013-A20.pdf
https://www.silabs.com/documents/public/data-sheets/Si7020-A20.pdf
https://www.silabs.com/documents/public/data-sheets/Si7021-A20.pdf



>   */
>  
> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index 4d220c835c75..172fc9df1140 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -8,7 +8,7 @@
>   *
>   * Datasheets:
>   *  - http://www.intersil.com/content/dam/Intersil/documents/isl2/isl29028.pdf
> - *  - http://www.intersil.com/content/dam/Intersil/documents/isl2/isl29030.pdf
> + *  - https://www.intersil.com/content/dam/Intersil/documents/isl2/isl29030.pdf

I'm not getting anywhere with this link.  Given intersil seems to have
be bought be renesas

https://www.renesas.com/eu/en/www/doc/datasheet/isl29028a.pdf (not 100% sure this is
compatible with the non a version.

Not finding anything on the isl29030 so probably best to just drop that reference.


>   */
>  
>  #include <linux/module.h>

The rest seem fine.  Thanks for doing this.

Jonathan
