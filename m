Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF40ACBC5
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfIHJZE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 05:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbfIHJZE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 05:25:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 663E520863;
        Sun,  8 Sep 2019 09:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567934703;
        bh=PCTAy83waN3ZgE9Lk46050Vd0yttrDaO/Vn+ZQT+h+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YSKEmhtTLs+xsDKKy+f3CokAyyeMnOktDvQHiJwmlxpczkT5JazPpu+TUCdsF/Jq5
         +tdNOVQdP185EAVZ4H42WOS9GRNnKqieWtoBLDs1F+uEmKsnLFFH58gc8EvrP+GKjD
         F85oWwxbK9oqbXGWqVVl8ZmQx3SLVLQjC2ySc4uU=
Date:   Sun, 8 Sep 2019 10:24:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: accel: adxl372: Fix/remove limitation for FIFO
 samples
Message-ID: <20190908102458.7ef6f1ed@archlinux>
In-Reply-To: <1567502287-10199-1-git-send-email-stefan.popa@analog.com>
References: <1567502287-10199-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Sep 2019 12:18:07 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Currently, the driver sets the FIFO_SAMPLES register with the number of
> sample sets (maximum of 170 for 3 axis data, 256 for 2-axis and 512 for
> single axis). However, the FIFO_SAMPLES register should store the number
> of samples, regardless of how the FIFO format is configured.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

This st->watermark field is also used to provide the hwfifo_watermark
sysfs attribute value.   That value should be 'sets' not individual
samples.  I'm not sure that's the case here.  Note this also effects
the max and min values which will change depending on which channels
are enabled.

I've just checked the docs and watermark is clearly stated to be in
scans but the hwfifo_watermark is not.   Which is unfortunate if
there are drivers interpreting it as being in samples as a result.

I haven't looked yet to see what other drivers have this interpreted
as...

Gah.

Jonathan


> ---
>  drivers/iio/accel/adxl372.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 055227cb..adec37b 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -805,15 +805,6 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
>  	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
>  	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
>  					  indio_dev->masklength);
> -	/*
> -	 * The 512 FIFO samples can be allotted in several ways, such as:
> -	 * 170 sample sets of concurrent 3-axis data
> -	 * 256 sample sets of concurrent 2-axis data (user selectable)
> -	 * 512 sample sets of single-axis data
> -	 */
> -	if ((st->watermark * st->fifo_set_size) > ADXL372_FIFO_SIZE)
> -		st->watermark = (ADXL372_FIFO_SIZE  / st->fifo_set_size);
> -
>  	st->fifo_mode = ADXL372_FIFO_STREAMED;
>  
>  	ret = adxl372_configure_fifo(st);

