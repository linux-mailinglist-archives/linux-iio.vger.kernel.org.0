Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422483FB397
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 12:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhH3KIM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 06:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236284AbhH3KIJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 06:08:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02DF2610A8;
        Mon, 30 Aug 2021 10:07:13 +0000 (UTC)
Date:   Mon, 30 Aug 2021 11:10:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/16] iio: adc: max1027: Lower conversion time
Message-ID: <20210830111026.2952addf@jic23-huawei>
In-Reply-To: <20210818111139.330636-5-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-5-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Aug 2021 13:11:27 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> When only a few channels are requested, the core will request all of
> them as long as ->available_scan_masks is present, thus reducing the
> impact of any driver side optimization to avoid converting the unneeded
> channels.
> 
> Do not share this bitmap with the core, which is optional anyway.

As mentioned in previous patch - do share it with the core, but update
it to include the masks you now support.

As a side note, you should have done this in previous patch anyway
given that patch is effectively a noop with out it. (assuming it was
a good thing to do at all which I'm not sure it is!)

Jonathan

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/adc/max1027.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 8ab660f596b5..d79dabf20567 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -457,7 +457,6 @@ static int max1027_probe(struct spi_device *spi)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = st->info->channels;
>  	indio_dev->num_channels = st->info->num_channels;
> -	indio_dev->available_scan_masks = st->info->available_scan_masks;
>  
>  	st->buffer = devm_kmalloc_array(&indio_dev->dev,
>  				  indio_dev->num_channels, 2,

