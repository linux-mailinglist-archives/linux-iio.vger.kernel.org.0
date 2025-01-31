Return-Path: <linux-iio+bounces-14764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229EAA2427B
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 19:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE031883853
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 18:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734D61F0E28;
	Fri, 31 Jan 2025 18:18:55 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7251C1386C9;
	Fri, 31 Jan 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738347535; cv=none; b=HpoTRg66WgrAlA7KX01yragiRXNA1AskDrYDYoGBCUEZdRbX/CoMQCa/IIQFKiWokztZt0miTLJGglGSrrhXudlU2nfl7CHH5cX2SZ75oRM7oFMpy2kEdIsSKvjaJEidNcoDPjO95UctrNx9bmAGtofyF91yiGmSKF/3H5LeM+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738347535; c=relaxed/simple;
	bh=dskuolPKupTwvryUFCMQnFh6VVqyxehDH0iWHT5oTuo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTkbYwl21BEvxqYE0TZFkTbuNIZ5OfaK8wY6er2zJsonHPCowhLbwIWFMe2BWGuDwU+52Vo1JRoKGhd+n2z+atrbPIWF7IlXkPu43z/BEgoEPg0ldIYwzDFXaG6ou/4aV1XfkC47DpWLht42PBmmW58Gm0Tnn72gF548YjtTxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yl3zN4NWmz6K8L9;
	Sat,  1 Feb 2025 02:18:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CCE1C140520;
	Sat,  1 Feb 2025 02:18:50 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 19:18:50 +0100
Date: Fri, 31 Jan 2025 18:18:48 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Esteban Blanc <eblanc@baylibre.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] iio: adc: ad4030: add averaging support
Message-ID: <20250131181848.00003c67@huawei.com>
In-Reply-To: <20250130-eblanc-ad4630_v1-v3-3-052e8c2d897d@baylibre.com>
References: <20250130-eblanc-ad4630_v1-v3-0-052e8c2d897d@baylibre.com>
	<20250130-eblanc-ad4630_v1-v3-3-052e8c2d897d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 30 Jan 2025 12:08:27 +0100
Esteban Blanc <eblanc@baylibre.com> wrote:

> This add support for the averaging mode of AD4030 using oversampling IIO
> attribute
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
A couple of comments inline. The one about the gpio wiggling
is just me venting at silly hardware, so feel free to ignore that!
Other one is a trivial 'nice to have' for formatting.

Jonathan

>  
> +static const int ad4030_average_modes[] = {
> +	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384,
> +	32768, 65536
> +};
Groups of 8 often best option for lists like this. Make it easy to see how
many there are.

> @@ -498,9 +538,11 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
>  static int ad4030_conversion(struct iio_dev *indio_dev)
>  {
>  	struct ad4030_state *st = iio_priv(indio_dev);
> -	const struct iio_scan_type scan_type = indio_dev->channels->scan_type;
> -	unsigned char diff_realbytes = BITS_TO_BYTES(scan_type.realbits);
> +	unsigned char diff_realbytes =
> +		BITS_TO_BYTES(st->current_scan_type->realbits);
>  	unsigned int bytes_to_read;
> +	unsigned long cnv_nb = BIT(st->avg_log2);
> +	unsigned int i;
>  	int ret;
>  
>  	/* Number of bytes for one differential channel */
> @@ -511,10 +553,12 @@ static int ad4030_conversion(struct iio_dev *indio_dev)
>  	/* Mulitiply by the number of hardware channels */
>  	bytes_to_read *= st->chip->num_voltage_inputs;
>  
> -	gpiod_set_value_cansleep(st->cnv_gpio, 1);
> -	ndelay(AD4030_TCNVH_NS);
> -	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> -	ndelay(st->chip->tcyc_ns);
> +	for (i = 0; i < cnv_nb; i++) {
> +		gpiod_set_value_cansleep(st->cnv_gpio, 1);
> +		ndelay(AD4030_TCNVH_NS);
> +		gpiod_set_value_cansleep(st->cnv_gpio, 0);
> +		ndelay(st->chip->tcyc_ns);
Hmm. This is a bit nasty. To actually use this in anger
and get decent performance I guess a PWM with appropriate
functionality to do the right length pull train is the
way to go.

oh well, nothing wrong with this as a solution beyond it
likely taking much longer than needed!

> +	}


