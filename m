Return-Path: <linux-iio+bounces-22109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A3B13DAA
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 16:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEE017A061
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A4C26FDA5;
	Mon, 28 Jul 2025 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fo2RM2mc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE6263F5F;
	Mon, 28 Jul 2025 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714276; cv=none; b=QNS8+3KwXoayb33GO/pEMlu5P4E7/1fH7UHOGu6keAodUrUTKq1nroZKoAK7RzyqTBu6kO7OaAT5P7eRS7DNw25B6PAiSFWhy3iaS3jCl2zotdK3g9DVYAkzx+miJa+ffafiwaaDhtxT8AWDdkNowe9uTY29c5bTzq1uymIww+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714276; c=relaxed/simple;
	bh=YMNkAdfSnpybMoSu3nas3zKS2+bfNtLNz/RZJ32Z1OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICPoWgbLEeMktPt1KW8a98t5ybPW3QZnR6e9HqiCpVP12nyY/P9u/A8KtYmDvk1U0uByrLY8AlywDZWAd+WnM6Jg+UtrryzEP1DoC0src6C2zSmlpY0jxYrCbYLMtaTOCHN1YJHR7dNqPLeWXFkbGAE1Kh68EmGHiRFXD4V3fU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fo2RM2mc; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5315acf37b6so1686587e0c.2;
        Mon, 28 Jul 2025 07:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753714274; x=1754319074; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ykcVTDfyqleDLnWkxo8GtSsNTgqCVqgO9KSgQDHfHEA=;
        b=Fo2RM2mcQQQtfxEBVH0ozlJKx/xWn3IYPnCQxOg3R6r99gT5JfSeNTw9lYmRl1g1Uw
         as4fBd6JQgI5Mq3YCDmS2ba/K+1vJJ4Cv5q7Ij14M6Zhajh7ijw+4oZBBtyGHqVqac8R
         vfyWN7vEEOPLzPGdih1WXSFDoS3rJVyzIz9oQlNQFetFa6hyM99b0L2COEJ1kZanW+ln
         N6pnoHUTj+40mtrb7300J/WNmXIZZwcUK2O4bdYKsYivyIvXzYNWmYb/DExCcdS6Ha4k
         w2ZtqqOx8fGketZ83tf4Z90AzNRGfMGvI3Bsd5WpcVYpezS0DBRg5482mz61g/1ugc93
         4m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753714274; x=1754319074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykcVTDfyqleDLnWkxo8GtSsNTgqCVqgO9KSgQDHfHEA=;
        b=qOPBp+I72p79mUYTMLQbAimCtB1oZ9mzY8UOPg33oAxQEOCRRDDPbZUWl/Cop8KmYf
         zz6Al4LRvfA86f2zy1LC0duh+QcpIalVFgDpU/wCA5VOGZU4am4jPYpEMZvABtwX+RS/
         f1/bvpXheEXBe4JrWgCKvkAWa3M+ilBOAkVvQvqR058xOVwMQS2GSX5i/M+WGSpN1doy
         jgFnRFvDz0uEmU3R/rah8OPyjdcROb0qkHhnQSN6l48NDQc9plmqkFzSaOvrXGxhIumb
         uocKcFDuanibVlIKhiIfuakNdIQIqdHccsJcRJy5EtoCtSoqZsfKgpZrrs4YVIiLvsAn
         xq8A==
X-Forwarded-Encrypted: i=1; AJvYcCUFqdjEhsSXUX8H6Cmc5kN+p8xDCaClX5KA/kpzD+LcgqAYWeABw+hEmj4taLAh+B6DZIIF8PhthZFK@vger.kernel.org, AJvYcCVp5dgUButtuN97v4F8mu8BTHJE1uU1aJwfJ9hDG3zS2dj5n2BbPNRliA3H/J6Vve82vn6U1TS5goVoKNP1@vger.kernel.org, AJvYcCWp5unnccvkQvC6LeSskVVIxCRomCSuWcEnKUY/VQRwObgwoi16Gwn5bvSabbjsQautt+7WM6cSpI5k@vger.kernel.org
X-Gm-Message-State: AOJu0YzSwWgrlBXN/QBl3SvJ+qX7ngtzVZZEPoGIlXEkQWT2S3YHAdW2
	OpzJrd7J15wUaJPUkM/51ODkt7F2PWInZpUx/mzk+vVOOvSU94px2Nhk
X-Gm-Gg: ASbGncu+ickkG6fa4OKa1HGhT6yVQ4K3qpt+YhAKr1dba4Wm5O3/nu3bz2XA0tc3A2R
	A+/FjBMUXFSSaWeYp4YWPkGBkpZUotGtc0btXsj7betG0o0Q039rJ9uTP+QI4FlnYnpp0h0cyOB
	nyfgNQ1fVR+DWjUoV2MzYJYRwWmciO/564ShFB+3wBax5FiNnm/uAVwBUbDht2uNWug/O8AHwMb
	PmNopbWT0pGyN/vQuul0JI5wCBF8ZwPalt3DqeifU5CKPPOsxHsNQ6zDWHC8mUBFXvMf6ZWXrCC
	SCzd3oO4MLbwxk8AItXLQ8P9p0v8cwIH17coyKjhl5I0+FnXsSj8QSytF66NtnvDBfmBowl3NYA
	FqL4CPTLqTqfx7MWRQRmyZ/U=
X-Google-Smtp-Source: AGHT+IHHYK2+megbvRbd3rAUtT0UkE14DkFGQlSeCmnxbzV3RePQ+PdCSvBsisz1dyJLv5C7ZOYe5g==
X-Received: by 2002:a05:6122:8290:b0:534:3644:a4e9 with SMTP id 71dfb90a1353d-538db5280f7mr4032184e0c.3.1753714273575;
        Mon, 28 Jul 2025 07:51:13 -0700 (PDT)
Received: from nsa ([45.144.113.55])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-538e2858d8csm1459302e0c.25.2025.07.28.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:51:13 -0700 (PDT)
Date: Mon, 28 Jul 2025 15:51:25 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ramona Nechita <ramona.nechita@analog.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: adi-axi-adc: Add support for ad777x
Message-ID: <jnwhdddmz3voorm7ywsxlax336leapxh4nhfwivvp7mjnrdi3e@f5v3ygkpwrjs>
References: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
 <20250728134340.3644-3-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728134340.3644-3-Ioana.Risteiu@analog.com>

On Mon, Jul 28, 2025 at 04:43:34PM +0300, Ioana Risteiu wrote:
> Add new compatible string and corresponding iio_backend_ops for AD777x
> axi family.
> 
> Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
> ---
>  drivers/iio/adc/adi-axi-adc.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 2d86bb0e08a7..c4b8ec6d9397 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -670,6 +670,25 @@ static const struct iio_backend_info axi_ad408x = {
>  	.ops = &adi_ad408x_ops,
>  };
>  
> +static const struct iio_backend_ops adi_ad777x_ops = {
> +	.enable = axi_adc_enable,
> +	.disable = axi_adc_disable,
> +	.chan_enable = axi_adc_chan_enable,
> +	.chan_disable = axi_adc_chan_disable,
> +	.request_buffer = axi_adc_request_buffer,
> +	.free_buffer = axi_adc_free_buffer,
> +	.data_sample_trigger = axi_adc_data_sample_trigger,
> +	.chan_status = axi_adc_chan_status,
> +	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
> +	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
> +	.num_lanes_set = axi_adc_num_lanes_set,
> +};

Hmm looking at the above I wonder about the specific compatible? We
could add one if we want to have more strict validation on the possible 'num_lanes' passed
into axi_adc_num_lanes_set().

- Nuno Sá

> +
> +static const struct iio_backend_info axi_ad777x = {
> +	.name = "axi-ad777x",
> +	.ops = &adi_ad777x_ops,
> +};
> +
>  static int adi_axi_adc_probe(struct platform_device *pdev)
>  {
>  	struct adi_axi_adc_state *st;
> @@ -790,12 +809,18 @@ static const struct axi_adc_info adi_axi_ad408x = {
>  	.backend_info = &axi_ad408x,
>  };
>  
> +static const struct axi_adc_info adi_axi_ad777x = {
> +	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
> +	.backend_info = &axi_ad777x,
> +};
> +
>  /* Match table for of_platform binding */
>  static const struct of_device_id adi_axi_adc_of_match[] = {
>  	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
>  	{ .compatible = "adi,axi-ad408x", .data = &adi_axi_ad408x },
>  	{ .compatible = "adi,axi-ad485x", .data = &adi_axi_ad485x },
>  	{ .compatible = "adi,axi-ad7606x", .data = &adc_ad7606 },
> +	{ .compatible = "adi,axi-ad777x", .data = &adi_axi_ad777x},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);
> -- 
> 2.47.2
> 

