Return-Path: <linux-iio+bounces-911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3391E812C9B
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 11:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12C01F21A84
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65393BB23;
	Thu, 14 Dec 2023 10:14:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081B0BD;
	Thu, 14 Dec 2023 02:14:19 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SrSpz4b1nz6J9fR;
	Thu, 14 Dec 2023 18:13:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C39D61400CA;
	Thu, 14 Dec 2023 18:14:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 10:14:17 +0000
Date: Thu, 14 Dec 2023 10:14:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Michael Hennerich
	<michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, <linux-kernel@vger.kernel.org>, Stefan Popa
	<stefan.popa@analog.com>
Subject: Re: [PATCH v2 3/3] iio: adc: ad7380: new driver for AD7380 ADCs
Message-ID: <20231214101415.0000060c@Huawei.com>
In-Reply-To: <20231213-ad7380-mainline-v2-3-cd32150d84a3@baylibre.com>
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
	<20231213-ad7380-mainline-v2-3-cd32150d84a3@baylibre.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 13 Dec 2023 05:21:20 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new driver for the AD7380 family ADCs.
> 
> The driver currently implements basic support for the AD7380, AD7381,
> AD7383, and AD7384 2-channel differential ADCs. Support for additional
> single-ended and 4-channel chips that use the same register map as well
> as additional features of the chip will be added in future patches.
> 
> Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Just one additional comment.  I 'might' sort both this an Nuno's comment
if Mark is fine with the SPI and no on else has review comments.
Feel free to send a v3 though if you like ;)


> +/* fully differential */
> +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7380_channels, 16);
> +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7381_channels, 14);
> +/* pseudo differential */
> +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7383_channels, 16);
> +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7384_channels, 14);
> +
> +/* Since this is simultaneous sampling, we don't allow individual channels. */
> +static const unsigned long ad7380_2_channel_scan_masks[] = {
> +	GENMASK(2, 0), /* both ADC channels and soft timestamp */
> +	GENMASK(1, 0), /* both ADC channels, no timestamp */

https://elixir.bootlin.com/linux/v6.7-rc5/source/include/linux/iio/iio.h#L567
See the comment (added recently!)

Also, if I remember how this works correctly there is no need to include
the timestamp in the mask.  We do special handling for it to avoid having to double
the number of provided masks.  The details being that it uses
iio_scan_el_ts_store rather than iio_scan_el_Store.

So as you have it I think you'll always end up with the first entry
and that will include a bonus bit that isn't a problem as it will match
anyway.

So just have the second entry and 0.

Jonathan

> +	0
> +};

