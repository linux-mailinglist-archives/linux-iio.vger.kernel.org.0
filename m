Return-Path: <linux-iio+bounces-17148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3327BA6A6E6
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 14:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5357AA812
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46141DF25D;
	Thu, 20 Mar 2025 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bJynYEbo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6C33CA
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476403; cv=none; b=eSxkRISrspiVn0DWsq2uHcwoGNq5KmDGLLHKSc/J7a8I2+Mbb3sr0ogtlQfInLDqyu6h46uxdywEsb557H+pMqtSW6lMUO6VzxymyOBWJCekRvvSz2j3UseuRBi1Gub51TDrFXa/WM+45G2Lvc83597Iv/3R5iqRWvmEtWjgz3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476403; c=relaxed/simple;
	bh=XZm5F3XNZhIwlOrdjUlExuCp7zU1bFU/Qi3fHM4Ybu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVYaeCdCqgwFeRxh3S42+U6kj3YfBjtFMkWI0DCLPz+/fK/uKnQfkTzPEh2UHm+WpKIsLq8zXaCa37IArh2Hz1JcMOcN8doic5auR9cLPjp6iK/7863S8ij2Nb+xMJPpQZ+JVTPmBYS/tpoQlUxlXEpEjFIVPBOheQrl7MO7CMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bJynYEbo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso7077735e9.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1742476399; x=1743081199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v48XcGCXr1VN5yM2ip52zsfw94KneamZu91HpkgNdOA=;
        b=bJynYEborPNxyyxkfAcZegZLTX6DSa2gAahRl0TW9qp4p05vedyj7FA7GHPSQjHiyK
         JzBU7eEZlcgCco7hScEnFP8UpRO6K4/yCCNtIuBEMbIWODv4Cb6yDBViWaGsUvBrr2/w
         iv0pQloteQEUtiS8Ee0YDiGRCsrjZhepVMN8aR6cuh3PXI+BcKaUqq3pQztvT1esqJNv
         T7qVkmn4cm2UbzigvDULTp5TYpTr8L7pQol5ZPVAjIoneuRU28XXObra+QK1EtK0akmz
         Kx+NSHb0Uz/VxJpe9QsmYRaHMLDYSLVOVHlVNXGPspLI2cL0oXrYL8aio10M2ATwRx31
         +mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742476399; x=1743081199;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v48XcGCXr1VN5yM2ip52zsfw94KneamZu91HpkgNdOA=;
        b=Nc74igwoIABk4C4EXzljrhWgU/VFBJZC/C8OcGDVVP+Tq7UaERkbK8CrZLkK+yxCAJ
         OwKlzUR3VEd3khxxB25rGgiaPy0d6J4t//7UCR2B+TF43JFQDX9bDAAet308FeHjXsEQ
         iD7FfvsRcAzlEbGMfDEs9bw0oCzIb7yMpEiAjBW/yhxL5DdyiXJl1awbjyCO9+B0G1RG
         C7qZOxxWgrDEoLR7jSmuDGoIjRt3F9poUEFx6EBKaylJFiQrQahH5Nrpr2ylZGx1TXAt
         6ARoG/UnwgoCX3i/j2b/3DAO7VmiZyJ1Oxou0ViXpp93vuKsIS8VBhhd/ktz6vIzPNDD
         oz7A==
X-Forwarded-Encrypted: i=1; AJvYcCVF06EMZ97TAF5TvO9BcxHiomyqWH9w2X1fzgoWEcdTaJ6r28lA9BA+hkRhstJEiczAMi496zP7sIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxxcr7E/c6Skg6WpzfSu6NnjvIUqGNRME8PjX2DmbkxMDUpiUe
	WsczzUry1JHu8dKY5NU9RbeHPqgt6AxxPu2PryrT4oQmYqMtVtdNJxeaTnfNLgA=
X-Gm-Gg: ASbGncuIVbLAXFGIv++fqqPwBZ5SwuNqrnDpFx+Fi4aHCqEJdkhkOQ8DW0MoVGMG3xS
	WNyZP7OUyxkTKTChn2Pc8bkpRkxEzOqd7HOA4QF6OA1xW/N7w8vbNqOwteYogOQV6SlkBY2dYyl
	5FptCOCXU6B29M4mzyzDECxl57uhmKo2cGARrPr2RYJ/YdmUtXopfe029o+qzQYcq9vVeHMwSeh
	VKA+NjLRr0bKc33T81/vu0lqSfus5W0ItgcHYp37WFUwtQPKlSvE0f3ycbqLuJmRTlSqtPcIvHK
	vLjIXiA+lmop8oLLODy6bipbc26tM7w8o2l0l1E3OsruBibqLzXBSw==
X-Google-Smtp-Source: AGHT+IEl5veUunthB+o/ItpiVJl8NBc233c3fSE4ra0y5VSm79bnxcvguGhe+n8pCn3Yf22GVAAyvw==
X-Received: by 2002:a5d:59ae:0:b0:398:9e96:e798 with SMTP id ffacd0b85a97d-399795a8cb5mr4010723f8f.13.1742476398470;
        Thu, 20 Mar 2025 06:13:18 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3978ef9a23bsm19575491f8f.15.2025.03.20.06.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 06:13:17 -0700 (PDT)
Message-ID: <d55ed22b-7a13-4037-9a11-1a65040f8a7c@tuxon.dev>
Date: Thu, 20 Mar 2025 15:13:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/8] iio: adc: rzg2l_adc: Use adc-helpers
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <cover.1742457420.git.mazziesaccount@gmail.com>
 <9a3a11561dbd3d5023da2da05cf2190793738242.1742457420.git.mazziesaccount@gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <9a3a11561dbd3d5023da2da05cf2190793738242.1742457420.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20.03.2025 10:21, Matti Vaittinen wrote:
> The new devm_iio_adc_device_alloc_chaninfo_se() -helper is intended to
> help drivers avoid open-coding the for_each_node -loop for getting the
> channel IDs. The helper provides standard way to detect the ADC channel
> nodes (by the node name), and a standard way to convert the "reg"
> -properties to channel identification numbers, used in the struct
> iio_chan_spec. Furthermore, the helper can optionally check the found
> channel IDs are smaller than given maximum. This is useful for callers
> which later use the IDs for example for indexing a channel data array.
> 
> The original driver treated all found child nodes as channel nodes. The
> new helper requires channel nodes to be named channel[@N]. This should
> help avoid problems with devices which may contain also other but ADC
> child nodes. Quick grep from arch/* with the rzg2l_adc's compatible
> string didn't reveal any in-tree .dts with channel nodes named
> otherwise. Also, same grep shows all the .dts seem to have channel IDs
> between 0..num of channels.
> 
> Use the new helper.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

