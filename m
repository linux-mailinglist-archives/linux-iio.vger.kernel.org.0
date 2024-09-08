Return-Path: <linux-iio+bounces-9332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AF097086E
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 17:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058B91F218DA
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 15:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F44167296;
	Sun,  8 Sep 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XILgvEbv"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9766134AC;
	Sun,  8 Sep 2024 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725810048; cv=none; b=mwR2A4f5GIYinD1ga40ZcnkDcPze492LsccmgOYPVDkfn9ACKm5U8tFixBhvJTCkgM/kolPr2J5W+3e2yfMhN9ix3VtQ6Qvdc14ZcMotFjtMAwMy68iY3uhrZ6VyEjLot+I8po3i+jgCbTvLng8jzdV/PR0f1r8z2vHSuGAiOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725810048; c=relaxed/simple;
	bh=g25NVEPkLYfQKiBQT41BXUY41SwfOzr/KnSecEgtyZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEysMrLmda03m1KPFUHBM31+sj8Jk0qNg1XVHW4GXQQFhU3Dl40kvmnnkdofLzv+xNw5kGFxTSg5x51JACBAKxxeEMbd8hS9soDrQZ2Q9yuY2FaxhaU4igpKuOVLXOoTk0gMWMgutJL/zWiLFsX0RkCXGoCDHzm/UYRrcoSqpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XILgvEbv; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nK1qs6CH2OcVznK1qs0yP5; Sun, 08 Sep 2024 17:40:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725810043;
	bh=FwZvZLmaerUCdXxSG0fc+ZRB7XAjK/XuKX5y8QgnPCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XILgvEbvugzYhWWlI9DF9C3M5IzX1ebALuzSZuLViNOp+t2gcYiwLY0orI7QiIq5p
	 XkkOiPRFZDK1qW871r1ti1tqTudoIUg+cV8+8nejN/kzgoQA0l5Dpn19Hp1NoWQ8Os
	 wETVprcZ/s9KSCMVKGLaAaT0fvPQEV1L4bVsR470wsCtH2vP1O72uzhTfYZ3oyw2UU
	 slnWminUDKLBxdjH6wwz3wfUVy3TcClVR2zqOVoOnypGI2EDGAxS0wwiua+ZFtBbnV
	 vJjLxmnzkUifJzy0/DbltLFF8RkOAJ3phKUTelptCq3YBUNqNvEU1oaJXRQOHR2z9B
	 W7NDn5tt+Hnrw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 08 Sep 2024 17:40:43 +0200
X-ME-IP: 90.11.132.44
Message-ID: <2e2f0626-b9aa-4230-9396-d241615db8f9@wanadoo.fr>
Date: Sun, 8 Sep 2024 17:40:42 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] iio: backend adi-axi-dac: extend features
To: adureghello@baylibre.com
Cc: Michael.Hennerich@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jic23@kernel.org,
 krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 olivier.moysan@foss.st.com, robh@kernel.org
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-3-87d669674c00@baylibre.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-3-87d669674c00@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/09/2024 à 17:17, Angelo Dureghello a écrit :
> From: Angelo Dureghello <adureghello-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> 
> Extend DAC backend with new features required for the AXI driver
> version for the ad3552r DAC. Mainly, a new compatible string has
> been added to support a DAC IP very similar to the generic DAC IP
> but with some customizations to work with the ad3552r.
> 
> Then, a serie of generic functions has been added to match with
> ad3552r needs. Function names has been kept generic as much as
> possible, to allow re-utilization from other frontend drivers.

Hi,

...

> +static int axi_dac_read_raw(struct iio_backend *back,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		*val = clk_get_rate(devm_clk_get(st->dev, 0));

Having a devm_clk_get() in such a place is really unusual.
Is it correct?

This look like a memory leak to me.

> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +		/*
> +		 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know
> +		 * the data size. So keeping data size control here only,
> +		 * since data size is mandatory for to the current transfer.

"... for to ..." sounds strange to my *non*-native English ears.

> +		 * DDR state handled separately by specific backend calls,
> +		 * generally all raw register writes are SDR.
> +		 */
> +		if (data_size == 1)
> +			ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
> +					      AXI_DAC_SYMB_8B);
> +		else
> +			ret = regmap_clear_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
> +						AXI_DAC_SYMB_8B);
> +		if (ret)
> +			return ret;

...

> @@ -556,10 +792,12 @@ static int axi_dac_probe(struct platform_device *pdev)
>   	if (!st)
>   		return -ENOMEM;
>   
> -	expected_ver = device_get_match_data(&pdev->dev);
> -	if (!expected_ver)
> +	info = device_get_match_data(&pdev->dev);
> +	if (!info)

writing:
	st->info = device_get_match_data(&pdev->dev);
	if (!st->info)

would save the 'info' variable and a few lines of code without loosing 
(IMHO) readability.

CJ

>   		return -ENODEV;
>   
> +	st->info = info;
> +
>   	clk = devm_clk_get_enabled(&pdev->dev, NULL);
>   	if (IS_ERR(clk))
>   		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> @@ -588,12 +826,13 @@ static int axi_dac_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(*expected_ver)) {
> +	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=
> +		ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
>   		dev_err(&pdev->dev,
>   			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
> -			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
> -			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
> -			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
> +			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
> +			ADI_AXI_PCORE_VER_MINOR(st->info->version),
> +			ADI_AXI_PCORE_VER_PATCH(st->info->version),
>   			ADI_AXI_PCORE_VER_MAJOR(ver),
>   			ADI_AXI_PCORE_VER_MINOR(ver),
>   			ADI_AXI_PCORE_VER_PATCH(ver));
> @@ -631,10 +870,18 @@ static int axi_dac_probe(struct platform_device *pdev)
>   	return 0;
>   }

...


