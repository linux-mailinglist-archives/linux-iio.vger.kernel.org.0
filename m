Return-Path: <linux-iio+bounces-14300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3BEA0BE02
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 17:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0BFF7A447B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DC720F08C;
	Mon, 13 Jan 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zwQ0warO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CD1FBBEB
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786996; cv=none; b=Z54dVMwwwzDQKiVpd/rIC5Tb9HfOnRf6K30VfDj/cGuE04fJQKGTxFKRwOXRJ5SFmpwuD8NCq/GReyVIgLghcMr7ZDiHJ6XXkuT91iv+vYlD/DTyI/8jd/e4WEwGX+dmO4pMn5ZDI0W1e947Oe1gQREUC0kXQfD6g3zOJDi641U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786996; c=relaxed/simple;
	bh=5R8Z+Pn/PPnTY8jfLG97xqOJA6BxHCPtkA+ReHw86RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCbguEw7VzX6ZN3yjVAd6Z99NIpMz3WuHXe08Kyi2/I7UjC5bxg/Poc2hv/3Qi+5to4bXV5TQgU7a3X4WTk5vN2Ddt1OEI8vpaim5M+9/jD+gESap+QUisZkZ0G3M5Ut9WXPX3vtcJq52z46JHFHvBObewol7l0cdbh+M8+Qdtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zwQ0warO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4679eacf2c5so42979111cf.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 08:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736786991; x=1737391791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEuSOcdGgqmCGmEswksuVOiY36y/yqL1o3cjWspZHHA=;
        b=zwQ0warOnj9mgFPw3aL9Wv8mDRIVzMzf7iOuVtZtBKoQKpyB/5HSt+sicPIg9VNUVZ
         8dXMMgxT0QY/fveV4RQkRHvX53XCGdZTVH5TNUwZoelYNhN0EybBgthYJELR/gScvj59
         fiZemDg14/aAyxxDm/Jb6GtimBAE7znHvZ1mEPgDmpGLui0bl80pO3wtH2jqipKa+k04
         Ivc1MCAV9mTDh6kMZ2EBiULJZCZAYjPDXvwn6aeUJVRpnNzLPKpxys4Y8c4eejcKJHXt
         I4Wm/RCMZMgJiew1/NvPiQl+/Y6aodc3ap57B4Y0hEHKCIS1R6fULAnp8hvA5I/73iW9
         1xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736786991; x=1737391791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEuSOcdGgqmCGmEswksuVOiY36y/yqL1o3cjWspZHHA=;
        b=KuUT4H6QIoMOkNm4agrhx9Dw+dUsTYgiBy8P4aixNv+VF8CjZOd2B9AX4gU+nHooQH
         WgyyEoNXGzV0P4YCt67RprHIGdR6Rct7iI/w3B4OyJMN2XsiKyyOcEgdTvn77DuuWrY4
         WXMY0xSvzJCSPLoAU/EBvt9N3Q4B6oZmKvHus+ri0ED3ohM0MCeuK4jz/RtBJwRtXP9e
         vVgLjMoZoYfi6+Kri4b28sFBGDABLjes1ew9xK+9kJS44V+aDtKa2zcBbkCNd6OGvi25
         7JhrdJHazqAsaQIGSvXos9QWJLCeqNuV01cqQzmk9a7mmq8uTH0mDHcsLBFhwaY5OZg4
         nLFA==
X-Gm-Message-State: AOJu0YyCwckmhon+MWD4vk3S9KAy38GkiRV5oTFINDJh83SS8hR4eKsi
	Z9y654hFlYgjo37id/FJ/lW3tb9fiJKwS2MMDtXv0GKpS0tWEYX0ofUxV8yH8mw=
X-Gm-Gg: ASbGncvuzdXRSAS1Z1VxA9dR6oMcK9kpA7pgKGZI4JQ4bChOuv1jHSg/7ukVgaznx2p
	9947sCqStZAlN8PEq48okqXSUjsEipkaYn1DpxxAXtNXMeMjqDHZj0TknmiIz/aT0+GWR15Jztz
	AW2im//KV6MHOKLSatT2IBHImYq+gSeXPtbrZ3GX2Yn2sW2UlIHpB8yhNkW8FX+77YtXosf/Yxb
	0Lkkj9KY7P5JVoGBZGboNvEOP4UZGeonA8Nsw9tFiCxqjmexA2KbCVuzRKCnHKFC4Ud/mjkmoqY
	Coi64BGabbOn2Q4HWsxPHyqy
X-Google-Smtp-Source: AGHT+IFNSEcDX5l/rwUhlg71qHnodYMhIxIuQDqIrH7anGzKvOcHlAuLuuuOT0Tyfj5WaYZcTVlywA==
X-Received: by 2002:a05:622a:20d:b0:461:22f0:4f83 with SMTP id d75a77b69052e-46c71084227mr360867621cf.43.1736786991533;
        Mon, 13 Jan 2025 08:49:51 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873216e6sm43125471cf.2.2025.01.13.08.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 08:49:50 -0800 (PST)
Message-ID: <efba6746-47a6-484f-ade5-f1e17246ac68@baylibre.com>
Date: Mon, 13 Jan 2025 11:49:49 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: adc: ad4695: add offload-based oversampling
 support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250109-ad4695-oversampling-v2-0-a46ac487082c@baylibre.com>
 <20250109-ad4695-oversampling-v2-1-a46ac487082c@baylibre.com>
 <e3fd7f56675908a60d8ce6bcb6ad4f05b828e132.camel@gmail.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <e3fd7f56675908a60d8ce6bcb6ad4f05b828e132.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-01-13 09:35, Nuno Sá wrote:
> On Thu, 2025-01-09 at 13:47 -0500, Trevor Gamblin wrote:
>> Add support for the ad4695's oversampling feature when SPI offload is
>> available. This allows the ad4695 to set oversampling ratios on a
>> per-channel basis, raising the effective-number-of-bits from 16
>> (OSR == 1) to 17 (4), 18 (16), or 19 (64) for a given sample (i.e. one
>> full cycle through the auto-sequencer). The logic for reading and
>> writing sampling frequency for a given channel is also adjusted based on
>> the current oversampling ratio.
>>
>> The non-offload case isn't supported as there isn't a good way to
>> trigger the CNV pin in this mode. Support could be added in the future
>> if a use-case arises.
>>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
> LGTM, just one small thing inline... Either way:
>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>
>>   drivers/iio/adc/ad4695.c | 333 ++++++++++++++++++++++++++++++++++++++++++----
>> -
>>   1 file changed, 303 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
>> index c8cd73d19e86..0caaeaa310ed 100644
>> --- a/drivers/iio/adc/ad4695.c
>> +++ b/drivers/iio/adc/ad4695.c
>> @@ -79,6 +79,7 @@
>>   #define   AD4695_REG_CONFIG_IN_MODE			  BIT(6)
>>   #define   AD4695_REG_CONFIG_IN_PAIR			  GENMASK(5, 4)
>>   #define   AD4695_REG_CONFIG_IN_AINHIGHZ_EN		  BIT(3)
>> +#define   AD4695_REG_CONFIG_IN_OSR_SET			  GENMASK(1, 0)
>>   #define AD4695_REG_UPPER_IN(n)				(0x0040 | (2 * (n)))
>>   #define AD4695_REG_LOWER_IN(n)				(0x0060 | (2 * (n)))
>>   #define AD4695_REG_HYST_IN(n)				(0x0080 | (2 * (n)))
>> @@ -127,6 +128,7 @@ struct ad4695_channel_config {
>>   	bool bipolar;
>>   	enum ad4695_in_pair pin_pairing;
>>   	unsigned int common_mode_mv;
>> +	unsigned int oversampling_ratio;
>>   };
>>   
> ...
>
>> +
>> +static unsigned int ad4695_get_calibbias(int val, int val2, int osr)
>> +{
>> +	int val_calc, scale;
>> +
>> +	switch (osr) {
>> +	case 4:
>> +		scale = 4;
>> +		break;
>> +	case 16:
>> +		scale = 2;
>> +		break;
>> +	case 64:
>> +		scale = 1;
>> +		break;
>> +	default:
>> +		scale = 8;
>> +		break;
>> +	}
>> +
>> +	val = clamp_t(int, val, S32_MIN / 8, S32_MAX / 8);
>> +
> Why not clamp()? AFAICS, we have the same type on all the arguments. I also
> think clamp*() macros got the same improvements as min/max() ones which means
> that using the ones with explicit casts are not so often needed anymore. My
> understanding is also that those macros are not that encouraged as it's easy to
> go wrong with the casts.
I have no preference, this is just a recent habitual use of clamp_t(). If
clamp() is preferred I can send a v3. Or maybe Jonathan can tweak it 
when it is

eventually applied?

- Trevor

>
> - Nuno Sá

