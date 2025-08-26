Return-Path: <linux-iio+bounces-23302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E13AFB36D6C
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 17:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2391896CC0
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E6126AA91;
	Tue, 26 Aug 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="coB0yhpF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0801267B12
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221076; cv=none; b=hqLmmsNOT8gv0e89Z7eyqhE72IaTm2M5kCh4Oy5rloqCbXzW5JeKekol5wdxredlbHQiJVfJeMalXaN8oJk74Uao85jAYiTi0HMTZKV/l2vCZ4vjUgUmcHKgjJJcsd4Cg2pmAZCIrjz4exo6hzAnW7M15MskwXSYk5lNAv7Zmy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221076; c=relaxed/simple;
	bh=bmG0z1HOhbjPckrji2ukzQh8cHrzhC38DcEeXeKZCBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bE69DaVjI4DVbGZZk+3bzZfp/ffI0HbCKW004QO7u09tFsv5REZQqxJvLmt2ee2MIe6A9LKQAHlaj71amRDtZSMOAZ/z01S0xYSrkTZTEcR0P8u4qyFo0+Fo7hjB262jvaJVf+YESE6EJuFOstNgstSxkBSLz4YhVKbVMky/6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=coB0yhpF; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30cce50dfb4so5350150fac.0
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756221071; x=1756825871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLrgdFzlBPbDYpPHO34xWxrjl479AfkvLq/ffp8ncz4=;
        b=coB0yhpFGSMHHG9xDJO5qN7a40tnTqfJP7Io6QU1NmaQP0+fSw/39GJcwwCTkMh/SJ
         ZqCLnJoxGR3TznokxxAxiqJ95Pu7eAG7Ue104avddGF4oPACkHcW0PHy81c12qAWVqEQ
         vVyThwKBb2zzCL9Tw+zcY9/eVdorr2oTjplg7UbHckJXbasIJp2aebq8XDozM3xShXCx
         cdALq5eMpw76k72mSAvcuuUZJ1zMIeImjvBg+n0EWku7H6hFCc7kB1du7NJ7BJzR3r1a
         Evk/5VAvx7r5vMZWG6AkY2A4Q99F8rqYBJO4BSwJo64MuHLBPwjZ9zfYLi5SYJog0vc7
         iyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756221071; x=1756825871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLrgdFzlBPbDYpPHO34xWxrjl479AfkvLq/ffp8ncz4=;
        b=ummylNud8Tlwfi6tMrjzLOwWvweOi8OQ0HIHAziaOlNV28Ue60eez74Bh8tMx0CnEb
         yNnkkIoF/bYBUA0IYQ3NTCzeGwe5KjDPcuIFFRFFlwqhen0y0aa3FLxqZkV0hnASoJ8I
         v/ItJYbtMt+50R/u/fvxJkhhzNnPU5ROPjKP7NftYAcIqZcRLU9xALncOvh6X4rpuacU
         Wa5xDsrTICDfGjan2V7fSmJoe9Yvr43Am7Ih9U6/MLlrtQ2Xtte/JjeGg87YvZb1CnMS
         htU7G7ICe9rDRVLlZNZQGjXP0F9Nr9BP5mx+3+Iry2G3e98vzYM8KPoNlt/2NMuOfQLh
         KaYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX50SJalYhF1A75dU/AWaiuBAOL+Yg2jEnk2idpnADiNSbQg9WL3ZLurV81J+Xu3nZoIFkorbmHcEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylGj2CQ7rIggX4bPRMSMshTdlig8sAzyFUn2J9uFj63BBRFk3v
	qOy2d5Pss6OfR68aS/9puyPpB8jEr1M/D8vMEO/fM43R4nxHYFTeXWrIlZtVHMyrofo=
X-Gm-Gg: ASbGnct/2tmkBttEccPhBPSiO5zMweCXO2Jb/mMnp9/jlyOmpHLuArGBj6228yq2mB5
	g0L/TCPHCuY336CyzC5sgPBwmfVpJvRxrLBg592OitUeQcsaykBPuyB7fmDigPi0D1b8s6eyeaU
	gUQesw5wYBsEwvNaBVO68ZhghZ1AK+QPgNyDlupy4Teopdyl0WlIuuuAw6L4RYW9g6HtXOu9NZV
	JLu5Xx7P49PJgw5RLiMPW7etJKlbYarAtBJIOwBl8VJ2ETBmRPkA1BSl15m0aT4yP2Dlrbk6Jf5
	6slQmjfa09ferg4r4kdYhTnJnIG67NTIbtCxQ94f5WDHpXxMItcU04/W1hoVkdAU5L0JCcOXuUg
	bN1OydyMfK/krA0XX30wXFOflGADu8KF8+f9zqX3uLg2dGeG2mmoZV7kg9Nng312WkyCXMo/C5C
	U=
X-Google-Smtp-Source: AGHT+IHPLPVoTYuyWUPPqegkgvkKkErW94mqeIgVxNaivppxvK7+bTtUe3engtClxePal6B2UlZO9g==
X-Received: by 2002:a05:6870:32d4:b0:302:5dba:5ae0 with SMTP id 586e51a60fabf-314dcb65a74mr7496856fac.20.1756221070609;
        Tue, 26 Aug 2025 08:11:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb? ([2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e4738b8sm2368838a34.32.2025.08.26.08.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 08:11:10 -0700 (PDT)
Message-ID: <181dafaa-ec04-43cd-b0a4-208da8cd89e9@baylibre.com>
Date: Tue, 26 Aug 2025 10:11:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: adc: ad7124: add clock output support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
 <20250825-iio-adc-ad7124-proper-clock-support-v2-4-4dcff9db6b35@baylibre.com>
 <CAHp75VeAMNp8gARndVRnh3EwrTb65MNFXL7pCThR+Ghd_+yHDw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75VeAMNp8gARndVRnh3EwrTb65MNFXL7pCThR+Ghd_+yHDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/26/25 3:13 AM, Andy Shevchenko wrote:
> On Tue, Aug 26, 2025 at 1:55 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Add support for the AD7124's internal clock output. If the #clock-cells
>> property is present, turn on the internal clock output during probe.
>>
>> If both the clocks and #clock-names properties are present (not allowed
>> by devicetree bindings), assume that an external clock is being used so
>> that we don't accidentally have two outputs fighting each other.
> 
> ...
> 
>>  static const int ad7124_master_clk_freq_hz[3] = {
>> -       [AD7124_LOW_POWER] = 76800,
>> -       [AD7124_MID_POWER] = 153600,
>> -       [AD7124_FULL_POWER] = 614400,
>> +       [AD7124_LOW_POWER] = AD7124_INT_CLK_HZ / 8,
>> +       [AD7124_MID_POWER] = AD7124_INT_CLK_HZ / 4,
>> +       [AD7124_FULL_POWER] = AD7124_INT_CLK_HZ,
> 
> Perhaps / 1 ?

Seems redundant.

> 
>>  };
> 
> ...
> 
>> +               const char *name __free(kfree) = kasprintf(GFP_KERNEL, "%s-clk",
>> +                       fwnode_get_name(dev_fwnode(dev)));
> 
> What's wrong with the %pfwP specifier?

I didn't know about it.

> 
>> +               if (!name)
>> +                       return -ENOMEM;
> 


