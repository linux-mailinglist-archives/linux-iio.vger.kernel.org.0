Return-Path: <linux-iio+bounces-6466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC85D90C956
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DC71C23149
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4EF15F3E8;
	Tue, 18 Jun 2024 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdKxIzOJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E9F15EFD5
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706308; cv=none; b=Lv+ukQQT8Ke6EDKifgUThwR+PBvC5VayJIrETJWscTo/XR6IyhZAOCjjeW8QtGD4lBJT880Y2GxCsdTQBGgY2VJXOGsv4On7N13g8iGUh5lIIz0VYTWoRLfFUBhxn5FvkJKBvk8rYijsC1avPcB9R3ZdnHMro7p69SUs0XIcBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706308; c=relaxed/simple;
	bh=LqK8v8L6085Sefypgf1V3diltFl9sECNHVEvbocsyUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLr7DzPlcH1nfknnhaTdajL//Bs7zb6H4+f6Tri7wNuyajx7hT+LVOgnGDy/41b8kFu6UshqfNAvhrnbX5HctxuNNswxRZfyG3oQH4df0ojH4E8NM/JXRXYfWHDPwvg++bb142KDRIhWYohj5Gl2TxHXaWNlLJ/G+1wLa7eGs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdKxIzOJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e724bc466fso62996691fa.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718706304; x=1719311104; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6eO5TUpK8rT/f3c3WcP+sjjePLm+0H56buqyYkDvJss=;
        b=RdKxIzOJWgCSbeH/GM4xnJemyiZdv9ubIqKBMU41TMZoRKwu/ra1xtIqhCfa+jtZOx
         fTWx4eu5gjUNghGQRnWDmty3AWprLnZSACrPzp3kuoDO7V9khZv5o/DUuvs3cAqwJ+mm
         vhMpPp8MqMNUjTczLdr3VOzlOM7xWMM7lgoHWIcSCIGRdX0CnTrOukOiyjDNelLH66Vw
         UgcXHvc6m8gIARRu6lzEbObMDIvCP8+xMbE+QIEaEk3bO7YHVjahB5dbGIeDTaRU4DDN
         cGYLzPQsEpQmOVWxXNONlEZo+irXVATgLKrS29obzsuPJhMgwOje5LF6WFZ30tr6rEOg
         u4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718706304; x=1719311104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eO5TUpK8rT/f3c3WcP+sjjePLm+0H56buqyYkDvJss=;
        b=UBLMP4BdttQ/G1zdbuh1TI2qU+GKoPInoRI+gbjbavf/MkN2I0n0zuOQsbFNxPUrIu
         juQ/e8hh+LyPW6UY+r6YgY0GwjIpOXICCJ6kAZlJl8M67TC8ejetPsdCjLlkz19Juoa6
         na8Vz97W2s9i6CUX4G74tJw66LxH2gHK7lqDtFDhQ9nkHWcP+0aW26p81YE2y8px6d+i
         lrdqQJpaXMub1GrCBpm3wmmcTB/VKjLLSKga5hAUg01jIDo/jfdPcv1plAYg4T7z3mWl
         8qq8FjNfbGMDmFvpbdJNZ2Hu5BlRat0mbANgs/juYhxmywYGrULR4T5ATloDyKP1N3SM
         xCpg==
X-Forwarded-Encrypted: i=1; AJvYcCXyxDyuSRZqaJ/n3gDwLwHGvo3/oftvraJKBHyWH7UKhlGLtAYlS0zxejme0QN/XzarkjCfA5JYFIe2QAeNDSvkTQ0iOAj8xCQp
X-Gm-Message-State: AOJu0Yx8cvG0q42GrLntH/7Z2ZNVq3IMiPDWADv0HD5ruhDa1fcmAAYd
	Yybolpm0gIF1lWGaLPqmjSB63s4YkVciWZWznrX8E4jrSD5rxd6tow+UYm2j9wE=
X-Google-Smtp-Source: AGHT+IEiuZRNVMN76y6yOjWtf+3j+4HWW8RylKCvG8GARgK6ahHJIkTtS4MoJIzqIS0COIpvqo83xQ==
X-Received: by 2002:a2e:9807:0:b0:2eb:d7f0:5edd with SMTP id 38308e7fff4ca-2ec0e5d15femr93327051fa.27.1718706304083;
        Tue, 18 Jun 2024 03:25:04 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a64bsm185126885e9.46.2024.06.18.03.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:25:03 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:25:01 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v2] dt-bindings: drop stale Anson Huang from maintainers
Message-ID: <ZnFgfbFmHhP7wLPM@linaro.org>
References: <20240617065828.9531-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617065828.9531-1-krzysztof.kozlowski@linaro.org>

On 24-06-17 08:58:28, Krzysztof Kozlowski wrote:
> Emails to Anson Huang bounce:
> 
>   Diagnostic-Code: smtp; 550 5.4.1 Recipient address rejected: Access denied.
> 
> Add IMX platform maintainers for bindings which would become orphaned.
> 
> Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Acked-by: Peng Fan <peng.fan@nxp.com>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # for I2C
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 
Acked-by: Abel Vesa <abel.vesa@linaro.org>

