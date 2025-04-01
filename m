Return-Path: <linux-iio+bounces-17515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00FEA780B1
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 18:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49433A5298
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F4520D500;
	Tue,  1 Apr 2025 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MACl2xXx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DE204693
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525529; cv=none; b=dgmWpFVlMfJSkNkplkW2jFYcJymRGwhakH7tf5PqMBCk1hwGIvIDpOZI53l+xzYWw9r6jVyecQbMWJs21NIMm/AARBX5D60oM9iBqtWSf1Gak5+clKfoto8BvhHMKRWCYcROQFAM6925kEhTxT1p+qn1HqY413f+yxG0fl14yAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525529; c=relaxed/simple;
	bh=L/QUB900bn4/5qxSQgXevW35Ho7xDBeu2EqGEEQtfrg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pYDjGjFI6owzbbeXtzFN7+9mUQiapMaLpbQLDN5KCoRV738wE7fluvvqHgpFad72pLNC0aCDUV1pE5IkGw28q7UiuFubCZr5hVnDzxEaou3G3zjn+1RsbMtq2Kk50qG8SrqFZwF3mivL/2r00cD9sLCQrhztF/1ndgDeXytLuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MACl2xXx; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c7b2c14455so3382931fac.2
        for <linux-iio@vger.kernel.org>; Tue, 01 Apr 2025 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743525527; x=1744130327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vn5wscEL3RLQT1/gL56P3oGMeI2WM/NBihFUEPIxOCo=;
        b=MACl2xXxoVtGErHozFr5CJb9eqqbVUZ/dvBEwvg8G3c69v05Q/fPITlDwnJPfpfV8+
         rfMB4z52zAXCGJC+jh8z1WZK0MHalEw/Dcr8uHEm/DBBELQTD20WvB8hAz51Zj4UeFw4
         eAaTuhDmsx+MdayDPaN46ux1pZIwyFIIdLQ2kukOAb4MPAXQtp/hrQwlEWTxraC1Sm+i
         Y4vBU+Q/B3kGfxTvMFk0nB/YJ62fzf/TKePlrQIxNpvuY88BiMPIU0OLS/1QSZaxgFKJ
         WV/If6czgmUyJqFBlsC6IZNVrdYqUNXEqX3pZKJABCSEbR2xMpQi0djgjupBwCuCRtuw
         YHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525527; x=1744130327;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn5wscEL3RLQT1/gL56P3oGMeI2WM/NBihFUEPIxOCo=;
        b=k3PYDR+KhE0n9sIKMWVbf4DQs8tNZXfjFr+BiHI73VIuOiAxGiAIj7pn0DTKaXQ0BD
         QJkyQpwO4IAvK+DmKS4S5otK8l16vido/uehfww44lJ4mrMMRQGM1RDzOljYACX/0m4v
         orIWUm2fklWKNiENDQXYcuXuV4nfujqNLS2x+WogtI6SnJSu6dedxgaA/fka/4qk26An
         98HtR4XprUNuT72s3YunH8oYpJb/hkaJ5IThAVlAPnGCICmWR0Gd7nExhpgb3DlBtzUb
         jTdVHQfyoM2SvP9Vp5xar3trpqbAc5hq9rkqiAE19S8HvDfC0OAN1rJFvYYWsFdBMsdN
         1ORw==
X-Forwarded-Encrypted: i=1; AJvYcCVTvMQMjyPrheqG/CRa82Pm82iiHucKxmYyZGna75jtiEVsyejiTL/9kWwEXLuWm5ZIRsJ2VNBoWJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4w1yAXwErRo6e8chjsCYR6mZ5iPemUSmE80t3ToCia4IxG531
	QYsyFSsDsTa/+ke3lBn4WWUkGPpgomL5l/DnVULvo2j8aryfC/1Ys9vxY/XJvPU=
X-Gm-Gg: ASbGncuQKHhun4tE/TAknmJPSM00JfPHDQ6ipD2IyI8hRszUwjqsRnq+jIBewPAVeVw
	5tvKJmexEYdt6lMM8e6UnaDIpE5W2z+XqgjaewCSENOz+tDRfhex4PzwcNv4hTBCghAQz8oEuwq
	MviZNYqqFFb0WVM4/UUpdYSQfqGw0MuRqHLmaK/lvRdqk77+sjun4sObbAWKmZ4ZnS/mmtx1xhi
	IbmJWq0hzJI7xMMAog/Pz1P7YoqjP9Wswe32D4C9lMhBdA5/QTyz+kXYlGdxGF2C6wE4uHCywgo
	Ws9861LWLhCJ7QnmwEZYRiWkq/nXNdfJuGd7LA+J7RCeHdpxk9lEWyQYtXfBaqelCWl5yGeVEhm
	1k43j7g==
X-Google-Smtp-Source: AGHT+IHU9FmD92LPJ3uip+4pws/5mX50Amq6nNJFvx9VLdxVBV3Kz6b76Gzjd/YUI+o3AWOY0Nu22Q==
X-Received: by 2002:a05:6871:69c6:b0:297:2719:deb6 with SMTP id 586e51a60fabf-2cbcf477394mr7400077fac.1.1743525527071;
        Tue, 01 Apr 2025 09:38:47 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c86a856e16sm2378333fac.37.2025.04.01.09.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 09:38:46 -0700 (PDT)
Message-ID: <6b9cce5c-6d4b-4be8-ba11-74b3471e358d@baylibre.com>
Date: Tue, 1 Apr 2025 11:38:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/17] iio: adc: ad7768-1: convert driver to use regmap
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
 brgl@bgdev.pl, lgirdwood@gmail.com, broonie@kernel.org,
 marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <b0c7976d4bc817b7056ef40e3ce870b42e8a2d80.1741268122.git.Jonathan.Santos@analog.com>
 <c72e422c-1ad0-4314-8171-1c3830f63fa5@baylibre.com>
Content-Language: en-US
In-Reply-To: <c72e422c-1ad0-4314-8171-1c3830f63fa5@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/25 11:31 AM, David Lechner wrote:
> On 3/6/25 3:02 PM, Jonathan Santos wrote:
>> Convert the AD7768-1 driver to use the regmap API for register
>> access. This change simplifies and standardizes register interactions,
>> reducing code duplication and improving maintainability.
>>
>> Create two regmap configurations, one for 8-bit register values and
>> other for 24-bit register values.
>>
>> Since we are using regmap now, define the remaining registers from 0x32
>> to 0x34.
>>
>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
>> ---
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
>> +static const struct regmap_range ad7768_regmap_rd_ranges[] = {
>> +	regmap_reg_range(AD7768_REG_CHIP_TYPE, AD7768_REG_DIG_DIAG_ENABLE),
> 
> Technically, there are a few holes in here where registers are not defined
> so we could split this up in to a few ranges to only include registers that
> actually contain a useful value.
> 
>> +	regmap_reg_range(AD7768_REG_MASTER_STATUS, AD7768_REG_COEFF_CONTROL),
>> +	regmap_reg_range(AD7768_REG_ACCESS_KEY, AD7768_REG_ACCESS_KEY),
>> +};
>>  

Also just realized we can drop the AD7768_RD_FLAG_MSK and AD7768_WR_FLAG_MSK
macro definitions in this patch.

