Return-Path: <linux-iio+bounces-8651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E56959E73
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D8287539
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BF8199FA5;
	Wed, 21 Aug 2024 13:16:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138C161306;
	Wed, 21 Aug 2024 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246182; cv=none; b=HBUSRYbtrI1j35ngiUB5QKjHNgVDvQwq7yVQt3sS5foAhtNaREYIVdaWFqDVHFnyY3z1UyPFY1O73jDSg8SyuF2z3rw0+tHeo8Jc3oQTf9pUkCCvbbT9vYJ1OSNUgNsvJkIw0+SILFX9f6Vamo2ZVNTJLo9ytdFmDmeDPdcd7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246182; c=relaxed/simple;
	bh=rSsEPj472Z50NdhT8fqh6VPhfjm2gpjv92pCAdQR/fw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrawKM3k49KEwJ8KvjmpC32+5/3sSvYnl4WV4jZCWBhS/rYkHw1GnM8WBI7TaBMngewvFWCZ4T8zJq0Ui/QOuwy26KRgbWmeuihc6walJ2WAzK3pENEojsPheAKmYeQDoXjxAz67KfxH0K3+Ll6mNZt77uqxDXxCbSk0u+HzkMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wpmw6069yz6FH2r;
	Wed, 21 Aug 2024 21:12:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BFBE3140517;
	Wed, 21 Aug 2024 21:16:16 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 14:16:16 +0100
Date: Wed, 21 Aug 2024 14:16:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio: adc: ad4695: implement calibration support
Message-ID: <20240821141615.00006ebe@Huawei.com>
In-Reply-To: <20240820-ad4695-gain-offset-v1-2-c8f6e3b47551@baylibre.com>
References: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
	<20240820-ad4695-gain-offset-v1-2-c8f6e3b47551@baylibre.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 20 Aug 2024 10:58:36 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The AD4695 has a calibration feature that allows the user to compensate
> for variations in the analog front end. This implements this feature in
> the driver using the standard `calibgain` and `calibbias` attributes.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Hi David,

Whilst some of the messy value manipulation is unavoidable
(oh for signed integer zero!), I wonder if we can at least
move one case into the core.

See below.

> +
> +static int ad4695_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ad4695_state *st = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		switch (mask) {
> +		case IIO_CHAN_INFO_CALIBSCALE:
> +			switch (chan->type) {
> +			case IIO_VOLTAGE:
> +				if (val < 0 || val2 < 0)
> +					reg_val = 0;
> +				else if (val > 1)
> +					reg_val = U16_MAX;
> +				else
> +					reg_val = (val * (1 << 16) +
> +						   mul_u64_u32_div(val2, 1 << 16,
> +								   MICRO)) / 2;
Maybe worth extending iio_write_channel_info() to handle
IIO_VAL_FRACTIONAL_LOG2()?
It'll look much like this and you'll need to provide write_raw_get_fmt()
so the core know what to do with the value formatting.

I don't really like the mixture here between the read path being able
to rely on the core code to deal with the /2^X and the write path not.
> +
> +				return regmap_write(st->regmap16,
> +					AD4695_REG_GAIN_IN(chan->scan_index),
> +					reg_val);
> +			default:
> +				return -EINVAL;




