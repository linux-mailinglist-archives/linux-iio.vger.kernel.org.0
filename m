Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008981417B2
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 14:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgARNgW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 08:36:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgARNgV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 08:36:21 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C7224699;
        Sat, 18 Jan 2020 13:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579354581;
        bh=4X9blPnzHEqLk4oKpT+uWyPAfAqv5L65CDGHgzJ1JWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VZ9xCY0tUs8fns2Ke5c9jWUlebSrtqqAhKws/bTWTF3OgDGjcsdEHm7a+4vWHlUJy
         ud4DmOBNnTHghJLyYqxyKgdYpP9gDbJIetmQILreQZPdimR3aBB1r+RhQEo3lrvTY4
         ArFAosacrQIN7VQiwDBsG9DAn3qnVncJ/zMw+BvU=
Date:   Sat, 18 Jan 2020 13:36:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH 1/2] iio: imu: adis16480: Add support for ADIS16490
Message-ID: <20200118133617.3e14429a@archlinux>
In-Reply-To: <20200116131148.18149-1-alexandru.ardelean@analog.com>
References: <20200116131148.18149-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jan 2020 15:11:47 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Stefan Popa <stefan.popa@analog.com>
> 
> The ADIS16490 is part of the same family with ADIS16495 and ADIS16497,
> the main difference is the temperature, accelerometer and gyroscope
> scales.
> 
> Datasheet:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/adis16490.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git. Initially pushed out as testing
to let the autobuilders have a quick poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index f0ad7ce64861..dac87f1001fd 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -787,6 +787,7 @@ enum adis16480_variant {
>  	ADIS16480,
>  	ADIS16485,
>  	ADIS16488,
> +	ADIS16490,
>  	ADIS16495_1,
>  	ADIS16495_2,
>  	ADIS16495_3,
> @@ -878,6 +879,20 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.filter_freqs = adis16480_def_filter_freqs,
>  		.timeouts = &adis16485_timeouts,
>  	},
> +	[ADIS16490] = {
> +		.channels = adis16485_channels,
> +		.num_channels = ARRAY_SIZE(adis16485_channels),
> +		.gyro_max_val = 20000 << 16,
> +		.gyro_max_scale = IIO_DEGREE_TO_RAD(100),
> +		.accel_max_val = IIO_M_S_2_TO_G(16000 << 16),
> +		.accel_max_scale = 8,
> +		.temp_scale = 14285, /* 14.285 milli degree Celsius */
> +		.int_clk = 4250000,
> +		.max_dec_rate = 4250,
> +		.filter_freqs = adis16495_def_filter_freqs,
> +		.has_pps_clk_mode = true,
> +		.timeouts = &adis16495_timeouts,
> +	},
>  	[ADIS16495_1] = {
>  		.channels = adis16485_channels,
>  		.num_channels = ARRAY_SIZE(adis16485_channels),
> @@ -1341,6 +1356,7 @@ static const struct spi_device_id adis16480_ids[] = {
>  	{ "adis16480", ADIS16480 },
>  	{ "adis16485", ADIS16485 },
>  	{ "adis16488", ADIS16488 },
> +	{ "adis16490", ADIS16490 },
>  	{ "adis16495-1", ADIS16495_1 },
>  	{ "adis16495-2", ADIS16495_2 },
>  	{ "adis16495-3", ADIS16495_3 },
> @@ -1356,6 +1372,7 @@ static const struct of_device_id adis16480_of_match[] = {
>  	{ .compatible = "adi,adis16480" },
>  	{ .compatible = "adi,adis16485" },
>  	{ .compatible = "adi,adis16488" },
> +	{ .compatible = "adi,adis16490" },
>  	{ .compatible = "adi,adis16495-1" },
>  	{ .compatible = "adi,adis16495-2" },
>  	{ .compatible = "adi,adis16495-3" },

