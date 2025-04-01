Return-Path: <linux-iio+bounces-17516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1C0A780FC
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 19:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E395A3AE960
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E85620DD49;
	Tue,  1 Apr 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KBREUhl5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A57E1DEFDC
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526967; cv=none; b=n3KzRHsMsebkpJx98Ijt8dxXe0ul5/ViahjsycpCtkfWJeV0J70AAjG3gRlkIBYP7e/KMV7O1vwDbKRH7m12dvLGRFjml6ah3kFqfNZhU3ex+mBbmFpsOO6hF0PRBckv4ORsKuN+7cZoEqBiC/wIkaTkN6W01MzT5MvuXIYeEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526967; c=relaxed/simple;
	bh=+yY04wqEFOM+ZYrFth/D5yZY/advkKXOD7JuGCcg5LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cz+NnCVq/t5yb3yNtwg0Wj+XzKjAP7zkBv/usE54zSMy7GSOHZCcz/IJ8lfZavIy/uNQIHaen8h7VnjM5sEgCA04sPEhNZux7oA9RJfMsnLpAi4iUlQx5QJkVlMluw0Dx6mFfuCWlNO/wQYvbCP4bGWQN9SJJD4DA+rvlWSR3G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KBREUhl5; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2c6f27599abso1726582fac.2
        for <linux-iio@vger.kernel.org>; Tue, 01 Apr 2025 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743526963; x=1744131763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhYpDMqUMYzUiHimtNWCc62ZJOtzgSZhsmk4Mla9PsE=;
        b=KBREUhl5LAl3P9+FDvqzWoQ1Y3//h14hlYYTWUf/A0i5onADIoTAjGvzILaZywpe3q
         JQC/V0uBjqpC2nfHtAf4kEcO/QPfCaE+q78PdszU4saGxrXveVbiTrcFefvDwjcLlALj
         osBel5ebQ4XjtnC/OJBY+UNwfCk3tGFPO7IThVVFhR8eWeld3TMUf58lewTdMi4QCzf/
         gCanSIlmg0rK/KQu60Q0VwVkWLBSDU/75WkMpi6RO9NpN0IFpATNzacxBn1DiIMbyMkt
         skK1K4N4bR6jfgzqY2AqxRVRvkEZ2zc54/9hcBVlnAYejQPn6GrMfA6iGhrlLz2+4Y3u
         cjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743526963; x=1744131763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhYpDMqUMYzUiHimtNWCc62ZJOtzgSZhsmk4Mla9PsE=;
        b=Q6LGofFmh5cubuKqjRPIJ0GuQ4N5Cpkf0jpsymZlq2ieP0G0B/6yFKLbWA09zGqAPK
         n3irzS17MU5Ly/kfBEnVtHlvInGah/V67BoEt2gmltA3PoaLxXaVcf1axT9B9oICb+1l
         Q6RypxESr+l15cOlyMdrpnL72ORfb6tpOsPJF8q0UwoyakxRYLdeWNEixxOtOES4Athw
         OeYuLZCH3mjHaZpjioPJ3VO1xeYl1sWc2ccB12/F18rA83Qgbq8GsT7TldaNymf3M4ZN
         Nb9ryLyP3EPUISR+ib6wyCpfy6RMtRPEJitsOuugWBY5NsnyN+I67JXKEW682zRAV8ud
         HhEw==
X-Forwarded-Encrypted: i=1; AJvYcCXF8lXRrrW4GsPQXTyXJzm4Ky6s9xPt4pOvjyfuJisRM/CO8XolNWqP2nDRF406OY0ojLreHem0aVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyefvndfTZHtOOamLw0JxJ6caETVPJS315iOlK43F41KrfC82dQ
	OHufPsfGz4bbX8hK8dEsJA3xk2TMix+OleKwPCvWXfVZ+B/R/4jtgqDB5b82Y/w=
X-Gm-Gg: ASbGncu3KCQEP6wuPwnMnWR0darWCLept3YcYehTpZVk4n1xo91ECRruNBdu+5szEON
	okjYQmcUaT/7eqTMLBpruoCQWGcpvQv5z1AJY3yuYfxAEVC9/cDfqMPIoBduhbYbMbWXhaaAzbq
	PIS16GXuu2glSrx3Hqm3wsNOYWXMPo8QpBcoUST6QDNftnJkkjk6k7zFWxEoqC55Ppt3AYw33gZ
	adXEU7lhyxrg75BEyAHs34m/90Mlbij7Bio0d5y2SIHMIOFzNAhCEjzQei+8nflsu+Eh2M6xNlC
	myQK1aAw3hkVpjfDiXuRUqvkxl6Xm3CmBLlcrSizZcxMH00E6DrccMz8AGsw9GMkHd03VnZ2pB9
	PLFPmCQ==
X-Google-Smtp-Source: AGHT+IGTSq0pqqFQI3H0pT8LDtKLGZr8SAjBhx6TdK6GcdGs7Cr91zaRzfary3Xt+Dp2mNKM4qbHyg==
X-Received: by 2002:a05:6870:548d:b0:2c1:62ba:cd7c with SMTP id 586e51a60fabf-2cbcf51167fmr7167818fac.15.1743526963436;
        Tue, 01 Apr 2025 10:02:43 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c86a4034e3sm2397020fac.9.2025.04.01.10.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 10:02:41 -0700 (PDT)
Message-ID: <c5858d5d-687a-46f1-8447-e9c9d802f87f@baylibre.com>
Date: Tue, 1 Apr 2025 12:02:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/17] iio: adc: ad7768-1: add support for
 Synchronization over SPI
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
 brgl@bgdev.pl, lgirdwood@gmail.com, broonie@kernel.org,
 marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <65bc11611c40d66858fb2ce5c1bbaf7e790a9f8f.1741268122.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <65bc11611c40d66858fb2ce5c1bbaf7e790a9f8f.1741268122.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 3:03 PM, Jonathan Santos wrote:
> The synchronization method using GPIO requires the generated pulse to be
> truly synchronous with the base MCLK signal. When it is not possible to
> do that in hardware, the datasheet recommends using synchronization over
> SPI, where the generated pulse is already synchronous with MCLK. This
> requires the SYNC_OUT pin to be connected to SYNC_IN pin.
> 
> Use trigger-sources property to enable device synchronization over SPI.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
...

> +static int ad7768_setup_spi_sync(struct device *dev, struct ad7768_state *st)
> +{
> +	struct fwnode_reference_args args;
> +	int ret;
> +
> +	ret = fwnode_property_get_reference_args(dev_fwnode(dev),
> +						 "trigger-sources",
> +						 "#trigger-source-cells",
> +						 0, 0, &args);

As in the DT binding patch, we may need to allow an arg here to be
able to tell the difference between /SYNC_OUT and /DRDY triggers.

Also, in reviews on previous versions of this series, Jonathan and
Conor both mentioned that it would be sensible to allow omitting
the trigger-sources property when /SYNC_OUT is connected to /SYNC_IN
if you want to consider that.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get trigger-sources reference\n");
> +
> +	/*
> +	 * Currently, the driver supports SPI-based synchronization only for
> +	 * single-device setups, where the device's own SYNC_OUT is looped back
> +	 * to its SYNC_IN. Only enable this feature if the trigger-sources
> +	 * references the current device.
> +	 */
> +	st->en_spi_sync = args.fwnode->dev == dev;
> +	fwnode_handle_put(args.fwnode);
> +
> +	return st->en_spi_sync ? 0 : -EOPNOTSUPP;
> +}

