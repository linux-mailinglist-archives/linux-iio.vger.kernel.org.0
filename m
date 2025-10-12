Return-Path: <linux-iio+bounces-25007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7382EBD0A09
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 20:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB79718932CB
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 18:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7DE2F0689;
	Sun, 12 Oct 2025 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krOIPd4f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9375809;
	Sun, 12 Oct 2025 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760294488; cv=none; b=OU+wXTuElifw4g9KppFVpnqcBKbV1THoVvRRRtY0QljIaL8ozV6bsiIBgJ3jVIKpNzl3jP5yiknzq7J7so3a8jrLxGKfQRiFnYVXK1FU6fkkWRZ/AFCVZZrY+i6H+uXyFAE3KQR4kMeXxlKP5FgpV2ONO7Ek/Rz6SWsrx5Pljfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760294488; c=relaxed/simple;
	bh=PoUFRD1yzrjYJCi3ArphUQMDmoTrK9yIQsCtPXBJOks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMJCV/GKkRbcHc6ojUOeMzve3NAhRzJ/0gO4oCf3xmhz8ab+MvrsNXmivATvE3pQ5pvF4OPufTKQu9ECXXxINKEInbuDiaSkxPqWE3bOmAiR6woDeptLBlxJTs4WBz/eUVR3KLoc/E6LWxyeWCmqT6J52v1MnvwuWT4Q55IaKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krOIPd4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDB7C4CEE7;
	Sun, 12 Oct 2025 18:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760294487;
	bh=PoUFRD1yzrjYJCi3ArphUQMDmoTrK9yIQsCtPXBJOks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=krOIPd4f4lyc27ACoYSnNCwCsujV1k6HK7G8mhBaU8D+fmiS+vu7emBKFtr+9Q9gQ
	 C5MHEabrspBaERkLsNUHpszwwGT6gCzCUyzIx+8e461sNDdO5fJ2uVkuG8+1LJuH9P
	 2fTucsdyNWjDEe7GzmpyKNGUWLzzIL7VsDshJNDQK+Y5U/XanapgdNbYb/gfmzB8N/
	 /CIm+68VaDiByKwhKevpvQm7I+1PvR8tKHp+MagE/hj6T0CplhxbH1hGe30WYxED42
	 T2RI7qfx7r8s+Z1H615AF9JCEMMtfuVSOa4SbmUo4Mk51H11xzd+60HO8HwUsoWeY2
	 ziBIH32MkxkWw==
Date: Sun, 12 Oct 2025 19:41:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Jens Reidel <adrian@mainlining.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 3/6] thermal/drivers/generic-adc: Register as IIO
 device
Message-ID: <20251012194114.094a61a3@jic23-huawei>
In-Reply-To: <20251010-bat-temp-adc-v1-3-d51ec895dac6@fairphone.com>
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
	<20251010-bat-temp-adc-v1-3-d51ec895dac6@fairphone.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Oct 2025 13:22:01 +0200
Luca Weiss <luca.weiss@fairphone.com> wrote:

> Register an IIO channel to allow reading the temperature using the IIO
> interface.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Just one question below.

>  static int gadc_thermal_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct gadc_thermal_info *gti;
> +	struct iio_dev *indio_dev;
> +	struct gadc_iio *data;
>  	int ret;
>  
>  	if (!dev->of_node) {
> @@ -153,6 +192,23 @@ static int gadc_thermal_probe(struct platform_device *pdev)
>  
>  	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
>  
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->gti = gti;
> +
> +	indio_dev->name = pdev->name;
what does this end up as?

obviously we don't really care what name the user space interface we
aren't using advertises but this should be something part number like.

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &gadc_adc_info;
> +	indio_dev->channels = gadc_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(gadc_adc_channels);
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register IIO device\n");
> +
>  	return 0;
>  }
>  
> 


