Return-Path: <linux-iio+bounces-17985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC9A86879
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 23:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FE41B67390
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 21:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E9729DB7F;
	Fri, 11 Apr 2025 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bto2CHuv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B929CB28
	for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407904; cv=none; b=q5uq+Kn/SEGrZ7L0WLFrAvavaHc/Sfelo8QKqEIe7G9qhiJbr9qK5pMBZbEG6y7Qqk8ieKv0z0cdR4OSaObPbGQl0mstDZL1EJoIVozp1txsMD7RzWtt3y/6tkgGAGUzbYImEbPd2XkLxWKq4OxfACwDLae8LoedZ/r6nUDP410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407904; c=relaxed/simple;
	bh=JhEtLQYxJUYf6hS4yrM6mRaFZC5s56CpaPGv53UDIbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nq92YeyL6b1/3Jwv8Dzbrbd5SP3iGftw8lLmDmYGQpJS64LyvAZrqLW//hH4s17bejOndG0FLWpernYBAWvBnYRepIOWnxyIj9jAQQpDMC2fBOM9ENdfSjmbusV5cnAnKwmBWCn81Sh+sHRs4/MADMKE6luw0TJYLJbAz0/wfpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bto2CHuv; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-601c469cce3so682712eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744407898; x=1745012698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qxKGBsMkMzJ2BNc5R5UbHVjtuUaRbTsxJED20d0p+M=;
        b=Bto2CHuvKd0fx2uKL1m5U1rT9d+ppNeZpZnnvrVgxo1Cxx5TpoTWxstoo3z/WDgRYm
         PRAq5qlhA3vLQDmK0zu3F4cz4LrcyvhicHjd4VLWeb0r9/nBHDzTerJH919aAQGgvfTn
         PugZh8FHrb9rY9vcRGCPmDO/O54FvY6P6yxij6pfdTMQv5k8C00Hpg8VVCA2YdyWNnPi
         13AveBl3pXGtd01jb8fST5eIZpnIskcqrilnxZBOHjCEa9/yg8IEviHZAQk/K90jPHl9
         e5E5EQJIE/han4nrocNdfO7j/QTHKEh9nX5JvWI5ibrCuCZ6+3pgals5xscdFC0Am2GD
         7DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744407898; x=1745012698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qxKGBsMkMzJ2BNc5R5UbHVjtuUaRbTsxJED20d0p+M=;
        b=pQeKb4sFi9ftqc/gu/eIA2KMfXuA7pQgsEbhx5DsCREw9wpWb0d7M3RsyonAYH2Dbl
         VrmBi3Fw2SzUOctIDaWdMVASePeNu+w19jtaTpKraX1J3aHBmi3pv46kK/IqxStPzgQ7
         BacHcfBG7I6yQ9q2IctOP4uL143EKm34xHnvfOpNrONe8HfCJeCz2cxqrcGgzW2CCKzh
         sjCG8TbRL+bOBsYfM7B+luzIECp5vvjbAgd6QGXb7B1nUtL59ZHvMHUalLrNBf3S65cS
         MtKJ1yhWGxQ1Ja3yP0MAly3gpEBaNbfthaWQP3owqZqHuAzgMQFmexmqTHH0TV1K00eJ
         a2OA==
X-Forwarded-Encrypted: i=1; AJvYcCURLXjMw8KhaPhy4qrJ3eo/0snOiH/cp6Suk/rozfU1trm6R2PVzmv2y916/fCQkGi4UkkmaQnvTQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSHDMFe4LYhXuFR3I3pbb0sqztuHRteyr8ZFyUxNwGXNG4JgJ
	vbpEcrVsRDUDXnWndw23TTRoN4Iv/IQiby7OO5VQr+Sr2H/Bd9nfynFZ07FFtSoQk49YMg+GKfZ
	V/yw=
X-Gm-Gg: ASbGncstnQCv/16733SUExN/6cH9u0Yyf8YEmXzrvPR71wldBVjLz8UDxxYQcWLN8dW
	SJB69NTs/kFx7uVkB96nLIVi+g8IdOKmzVnu89ezOrlz1dtRzGgnXdn/lZd/LPUwYtv+NzdyIlK
	5Meqzo1d6GqyZRoHEcTas3H22lpx4I1vvrq5sR4qsMZRiJDkIuVuK9wicW6vrjw77h576ayAo9R
	2yGMeFUYbCg0sCTU8CWnBwU22iX6+b0JnVK+LNVVH+SE9eqm5G9KCDLWG/4QDyUJpcEI+scVVfv
	Nr4Hr83w61XzdetidBZzqLROOZFOoKTlMcvnJM9uO5U8OVu+ALwLsF1ZBYY9Yi+Usppdd2HRBXl
	zRw==
X-Google-Smtp-Source: AGHT+IHXy3+92TRvDVV1gjmxCyi/zce38/vLVqmGl0gMcBYh4Q0YmYalGIFle2vzEHSzGH1qCGI38A==
X-Received: by 2002:a05:6820:1514:b0:604:117:1a5d with SMTP id 006d021491bc7-6046f5c8a59mr2387896eaf.7.1744407898203;
        Fri, 11 Apr 2025 14:44:58 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6045f5b28dfsm1015069eaf.37.2025.04.11.14.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 14:44:56 -0700 (PDT)
Message-ID: <bbdbf4ff-662e-459b-a31f-bc58e738a51f@baylibre.com>
Date: Fri, 11 Apr 2025 16:44:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/14] iio: adc: ad7768-1: add regulator to control VCM
 output
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
 <7753dcd690f07f855100fc28e7b8ae746082de1c.1744325346.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7753dcd690f07f855100fc28e7b8ae746082de1c.1744325346.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 10:57 AM, Jonathan Santos wrote:
> The VCM output voltage can be used as a common-mode voltage within the
> amplifier preconditioning circuits external to the AD7768-1.
> 
> This change allows the user to configure VCM output using the regulator
> framework.
> 
> Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

...

> +static int ad7768_vcm_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret, val;
> +
> +	if (!indio_dev)
> +		return -EINVAL;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);

If we put iio_device_release_direct(indio_dev); here, we can avoid
the goto.

> +	if (ret)
> +		goto err_release;
> +
> +	ret = FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val) != AD7768_VCM_OFF;
> +err_release:
> +	iio_device_release_direct(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int ad7768_set_voltage_sel(struct regulator_dev *rdev,
> +				  unsigned int selector)
> +{
> +	unsigned int regval = AD7768_REG_ANALOG2_VCM(selector + 1);
> +	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!indio_dev)
> +		return -EINVAL;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +				 AD7768_REG_ANALOG2_VCM_MSK, regval);
> +	iio_device_release_direct(indio_dev);
> +	st->vcm_output_sel = selector;

Do we still want to make this assignment if there is an error?

> +
> +	return ret;
> +}
> +
> +static int ad7768_get_voltage_sel(struct regulator_dev *rdev)
> +{
> +	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret, val;
> +
> +	if (!indio_dev)
> +		return -EINVAL;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
> +	if (ret)
> +		goto err_release;

Can rearrange to avoid goto here too.

> +
> +	val = FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val);
> +	ret = clamp(val, 1, (int)rdev->desc->n_voltages) - 1;
> +err_release:
> +	iio_device_release_direct(indio_dev);
> +
> +	return ret;
> +}
> +

...

> +static int ad7768_register_regulators(struct device *dev, struct ad7768_state *st,
> +				      struct iio_dev *indio_dev)
> +{
> +	struct regulator_config config = {
> +		.dev = dev,
> +		.driver_data = indio_dev,
> +	};
> +	int ret;
> +
> +	/* Disable the regulator before registering it */
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +				 AD7768_REG_ANALOG2_VCM_MSK, AD7768_VCM_OFF);
> +	if (ret)
> +		return -EINVAL;

Why not return ret; ?

> +
> +	st->vcm_rdev = devm_regulator_register(dev, &vcm_desc, &config);
> +	if (IS_ERR(st->vcm_rdev))
> +		return dev_err_probe(dev, PTR_ERR(st->vcm_rdev),
> +				     "failed to register VCM regulator\n");
> +
> +	return 0;
> +}
> +

