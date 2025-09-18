Return-Path: <linux-iio+bounces-24255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9895EB852D7
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 16:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5293BC553
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1F331195D;
	Thu, 18 Sep 2025 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADPGgY/O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F630FC3C
	for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204525; cv=none; b=P3FGOhbtvrp+El/85vul973wPYKYHi7xeC8IfOaQsmflvM5Ht2tYbPLYmTK8QvbV3Q2FScFLbkeY4dc/sQLcEkFJhelgkCZ7FXBjaL6Vrr8BX5/qI90+12ioq5SWnhQagatKUsEba79iOq3/WU4M437V8uCPzrQJHV27Arq5ymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204525; c=relaxed/simple;
	bh=lSnptP6fN/pLUqMZp6nJ4V8xc65Uw/ftY6R0OvBqZhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVfnBszdhIIC2u+Fk2vXA5tL7gexXu+UFMIts+gzSA2jAZFxZdN0dfF/OLJgyFrFXTanhKZ2rHpaH/uR9qhAYnmbwSWLe+GGZoNrOc19oRurfHWN+H7QgCWRUC8+PbqHAx+UbaewWut8mAEtm0G0H35KaZmJLz6CscZHGf1V0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ADPGgY/O; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so7820405e9.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758204522; x=1758809322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z56yE3RhN98804tu3UJs8TFzZt1QW6pC6iU/RNTk30Q=;
        b=ADPGgY/O3d7Ayf80+XfBBUf6gknNdspaauC37Mbhmy7SS7B0IfYwiKxfjgMonxY19e
         feKqHqTN6lmUli3/GebPtzufu2v1ZNd2vUwGgIsplAoa+ucNRjxuHeXWqwayVLSZk5lj
         uZZn1s7vzZJYULcv5zXKiSZs5/8ybtcYe2jBN2qKJWz9pd/nR177Sv3zHrlgqrfxgsoQ
         xFLHR2XdFUMgDTKEIUrOCUTrVYPQm+T66XbgrTti4ue+4//1193OPETRanYok5LbUq6P
         kaA61G6hCSLyvbuOxxYVMQwbCHBjvbljcFoUPvJEQWYACSqXgR7zF0KwTDs45MRLT0ui
         5MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204522; x=1758809322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z56yE3RhN98804tu3UJs8TFzZt1QW6pC6iU/RNTk30Q=;
        b=wAleMnjva4Ku/RVyKdFlIna1oS94zhzd+vSTHrB/OcTxp4pWI6JTE+umQYeqHwRdpa
         SlvVuUilSzv495yBz3fWQT5cPTLhnn3XRZygB7eZSrSeh1cJw9+qbTTS16GFmA443u7u
         z9tJfGl71sdlssyt+aniDyQJKpuJbrb/n+Znxpmi/Lv4zfsysPHfMKkmbPivCQ6zgrHR
         Ao/BVpZXRgyUCCx18QBrTGq3uqkRabxq2Oy2FovbQv2jMm+W5+yAgRj7CbFQtuviEQbl
         BCFCDsLhp1mk/hEpLvMH/+B6YRmBxVcOn5XjOQfy7xfXwdsrcUCwr6I9x85yn7VBtcuX
         sK1w==
X-Gm-Message-State: AOJu0YxPc9UQTqWFk62uC8avgicBd/RbDDe/DoXQJ8wBD2mTUhZSy4df
	RLZ9mzDrkwLs04sPM7dkDzgzGvVTMahgJXdQI437Lf9F5JSm7oh1FDEoUlIg57pJRQ0=
X-Gm-Gg: ASbGncvUk7VMtMMuQkZSIm3J4Y+Wivl33lh25Z+yILG99ICm44FOPQsPUuKrbbGikQt
	je2HD++JpSoIcz79SZ3XfS3dxw3IRFsuGNtixIDPfQBSPUYURwChAhal6oA1Not2j9CGjDgAoyf
	T6/zM1cT0b3IZso1BeenuPduxCigx1guoJdZVya31aiFFT4J7pE7HaUVrMk/2M+IVBT0zABDMfu
	5KvD+R02BnwjwaB0tGRY+8s98jY0i4cD2zTr3khR16+6ywePGpYPp3El+heD9ATwTEaTUPEGcfE
	4yAjaRwWXhpRPlkHyWXa7AJ9TW9FnbjH8pp6H63sHSReBdONSknT2fMONOEJEupyCd+K6J9U5El
	OyOswrIjlMqcAPR+GutUhHfA9qFjxsfos34vscbHmNUSG9iplkmNTb5GNokla3KQF47kkDrlxvJ
	6/iXNDDsvce3HdsLK+va2W
X-Google-Smtp-Source: AGHT+IGkVygzuWQOBFP8MPnBERmac2GiMM8U2DkJGQ87TuQtchhlHOXF1i1UYPhRV/h5760ATIh9bA==
X-Received: by 2002:a05:600c:c0d7:b0:45b:9b9f:88cb with SMTP id 5b1f17b1804b1-464fdf4425emr30646335e9.16.1758204521996;
        Thu, 18 Sep 2025 07:08:41 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-464f5a2850csm42597235e9.19.2025.09.18.07.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 07:08:41 -0700 (PDT)
Message-ID: <32937382-ad81-4e9b-92d7-798dafea64c1@linaro.org>
Date: Thu, 18 Sep 2025 16:08:40 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250916202605.2152129-1-daniel.lezcano@linaro.org>
 <20250916202605.2152129-3-daniel.lezcano@linaro.org>
 <f4e52440-fa96-486b-9c50-828fdbbe27eb@wanadoo.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <f4e52440-fa96-486b-9c50-828fdbbe27eb@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Christophe,

On 16/09/2025 22:53, Christophe JAILLET wrote:

[ ... ]

>> +static int nxp_sar_adc_dma_probe(struct device *dev, struct 
>> nxp_sar_adc *info)
>> +{
>> +    struct device *dev_dma;
>> +    u8 *rx_buf;
>> +
>> +    info->dma_chan = devm_dma_request_chan(dev, "rx");
>> +    if (IS_ERR(info->dma_chan))
>> +        return PTR_ERR(info->dma_chan);
>> +
>> +    dev_dma = info->dma_chan->device->dev;
>> +    rx_buf = dma_alloc_coherent(dev_dma, NXP_SAR_ADC_DMA_BUFF_SZ,
>> +                    &info->rx_dma_buf, GFP_KERNEL);
> 
> maybe dmam_alloc_coherent() for the managed version?
> This would save some LoC.

Ok, thanks for the suggestion, I'll do the change.





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

