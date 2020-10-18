Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFF7291721
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 13:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgJRLRT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 07:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgJRLRS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 07:17:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C1EF20897;
        Sun, 18 Oct 2020 11:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603019838;
        bh=2x9QQQ+p1QGXLCTHordyTRu3qNwmtssCrze1nGajCK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XSjUDOXVDx+BO8bAYfQCPknrDT1V5XQRE03XKcdroFVKpJ4LyesI2alzYGutbivAb
         g3iNGxegVuNJi6xy+oVsReHXngOnFGJJHl+99a1FosgZuEwjbfWq7ObpqURQIhyInM
         fR0LwOPf/mXEVEvJOHN5svg4P4UIKNPI1NYR5FB0=
Date:   Sun, 18 Oct 2020 12:17:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        alexandru.ardelean@analog.com, linus.walleij@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com
Subject: Re: [PATCH v2] iio: proximity: as3935 change of_property_read to
 device_property_read
Message-ID: <20201018121712.0393cab9@archlinux>
In-Reply-To: <20201018031732.GA27204@ubuntu>
References: <20201018031732.GA27204@ubuntu>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Oct 2020 08:47:32 +0530
Vaishnav M A <vaishnav@beagleboard.org> wrote:

A very similar change was made recently in
00fa493b9989 ("iio:proximity:as3935: Drop of_match_ptr and use generic fw accessors")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=00fa493b99894b930e431c05a9dba294c5189120

Review follows for reference as I wrote it before remembering the above!

> replace the of_property_read_u32 for reading
> the ams,tuning-capacitor-pf, ams,nflwdth properties with
> device_property_read_u32, allows the driver to get the properties
> information using the more generic device_property_* helpers and opens
> the possibility of passing the properties during platform instantiation
> of the device by a suitably populated struct property_entry

Please format this to aid readability.

Replace of_property_read_u32() with device_property_read_u32,
when reading the ams,tuning-capacitor-pf and ams,nflwdth properties.
This opens up the possibility of passing the properties during platform
instantiation of the device by a suitable populated struct property_entry.


As in your other patch, please add the header property.h.

> 
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> ---
>  v2:
> 	- fix commit message
>  drivers/iio/proximity/as3935.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index c339e7339ec8..7e47ddf89a56 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -355,7 +355,6 @@ static int as3935_probe(struct spi_device *spi)
>  	struct iio_dev *indio_dev;
>  	struct iio_trigger *trig;
>  	struct as3935_state *st;
> -	struct device_node *np = spi->dev.of_node;
>  	int ret;
>  
>  	/* Be sure lightning event interrupt is specified */
> @@ -374,7 +373,7 @@ static int as3935_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, indio_dev);
>  	mutex_init(&st->lock);
>  
> -	ret = of_property_read_u32(np,
> +	ret = device_property_read_u32(&spi->dev,
>  			"ams,tuning-capacitor-pf", &st->tune_cap);
>  	if (ret) {
>  		st->tune_cap = 0;
> @@ -390,7 +389,7 @@ static int as3935_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	}
>  
> -	ret = of_property_read_u32(np,
> +	ret = device_property_read_u32(&spi->dev,
>  			"ams,nflwdth", &st->nflwdth_reg);
>  	if (!ret && st->nflwdth_reg > AS3935_NFLWDTH_MASK) {
>  		dev_err(&spi->dev,

