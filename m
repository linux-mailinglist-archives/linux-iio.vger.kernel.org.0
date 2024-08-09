Return-Path: <linux-iio+bounces-8369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E4994D250
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 16:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AA41F23937
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1650196455;
	Fri,  9 Aug 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="F37FGskT"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3100156676;
	Fri,  9 Aug 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214399; cv=none; b=Y3buqakBwuik6qfLaq+BYDUSXFYP6olssuPxZSWSxei3XMgLSAXmHnxksxSfbAK1BlUnQu++pT6svV8epAJiH0Y1ZxEgtGiSYAWJZL0jhhY0su9OryDvNjKe8OXeG2mUwVNc1m9iXWDmtleWHfb28E95IJv0CG8SHaab1Qspzu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214399; c=relaxed/simple;
	bh=8eJnSf+WzgK/g/GHQkGpnjWagYrg//HOUOW4nYKbG3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbiCIFQIWvH/BEXnY1NNvE/Sypdnr5xoNNhwaouaZz+go4KaR+Tgaml/BAcHHKPo9Afma8FO5qvW2TwC/JLuXX2QsbCtPceWAKVLZs6m0i0KlM/opfd0qDScPUiFQtcdZerfu82VpBHyLw9O4HoUMdjcTc2w4HLm6zi0JpegmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=F37FGskT; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id cQdfsPE1NEQ85cQdfsE7xu; Fri, 09 Aug 2024 16:30:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723213844;
	bh=QquEDRsc4XE1jvfUtvrYehdl3AqPbLD0343ayILx//A=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=F37FGskTklVOb3g1pk481ccM+eUk76018/FVrzTMBiPTw5NV7jYxJV7AR/ckwe+35
	 ExW4zk/CGW7IOzXdaOoQqkwGEg7mSu8FAVAz41VLdoVdBkygic9OTY4ESD98aaPf6J
	 yJSUO6fkcLXR04v08Khu9MmvocJwvI0VAeWrogpPzXG/zzUmIdnotf8dq03zepMQpE
	 vcgHrA1kxF8Id4L+gOCQHHwG9pZa6wrClOfP9HQlsawekraVYUeZxRWcsCfS7lqTpF
	 neQGaIS9RyPwtpGou7r99/6bAy0LRHwugMD/viTdqMrkNYf/y4X/wzXIBr9EL9WHmB
	 X6eI63n5p8RJA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 09 Aug 2024 16:30:44 +0200
X-ME-IP: 90.11.132.44
Message-ID: <37357b8a-1995-473d-a6fb-168fc38e0641@wanadoo.fr>
Date: Fri, 9 Aug 2024 16:30:42 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add support for ad4113
To: devnull+dumitru.ceclan.analog.com@kernel.org
Cc: Michael.Hennerich@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dumitru.ceclan@analog.com, jic23@kernel.org,
 krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, mitrutzceclan@gmail.com, robh@kernel.org
References: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
 <20240809-ad4113-v2-2-2a70c101a1f4@analog.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240809-ad4113-v2-2-2a70c101a1f4@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/08/2024 à 12:33, Dumitru Ceclan via B4 Relay a écrit :
> From: Dumitru Ceclan <dumitru.ceclan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> 
> This commit adds support for the AD4113 ADC.
> The AD4113 is a low power, low noise, 16-bit, Σ-Δ analog-to-digital
> converter (ADC) that integrates an analog front end (AFE) for four
> fully differential or eight single-ended inputs.
> 
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/iio/adc/ad7173.c | 36 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index a854f2d30174..3ac09d326472 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -3,7 +3,7 @@
>    * AD717x and AD411x family SPI ADC driver
>    *
>    * Supported devices:
> - *  AD4111/AD4112/AD4114/AD4115/AD4116
> + *  AD4111/AD4112/AD4113/AD4114/AD4115/AD4116
>    *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
>    *  AD7175-8/AD7176-2/AD7177-2
>    *
> @@ -84,6 +84,7 @@
>   #define AD4111_ID			AD7173_ID
>   #define AD4112_ID			AD7173_ID
>   #define AD4114_ID			AD7173_ID
> +#define AD4113_ID			0x31D0

Nitpick: others are in lowercase --> 0x31d0

>   #define AD4116_ID			0x34d0
>   #define AD4115_ID			0x38d0
>   #define AD7175_8_ID			0x3cd0

Other than that, is there any reason to have this "random" order for 
these defines?

CJ





