Return-Path: <linux-iio+bounces-22426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A2B1E231
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F5918C742A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 06:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB57B2248B3;
	Fri,  8 Aug 2025 06:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amrtkOLW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12ED221577;
	Fri,  8 Aug 2025 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633938; cv=none; b=Vzb0g0E6fqkodoKFCCRXwgJ5ejUAu8JgFk6gdnuSZaXGqx/waa/UM06KW4JORQ1Yh1j+eLc8d1dMYqdNYt34eb4+oXpD3eH1FLO3tyTICi61YDtw+ISCxWa8h+rQ1GgXqBqrGyntvdSgbpLecap32YYu687DMr4jZ0kwUOZk084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633938; c=relaxed/simple;
	bh=g/2dbIbJffHx56OuJYTpFX5LlnI2qx1QGY7roDl7X34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKAtRvRL43pz+JSsyMFFgOpakUFxEw7OhPtqktZ9jQ4kNYmDE/ZwymJYEfQL5YTpjqUuyrBZ/2dCIdsX1p053ZHRzNcijmWPgA/VuU3iVpHThHIsVqKkSq1ursYd1ECkHpEGNJErIcp2N6rKNgqjnly9JWsxuMT0L+0rHRVXkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amrtkOLW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55b797ad392so2077463e87.3;
        Thu, 07 Aug 2025 23:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754633935; x=1755238735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KmV2G4ucO47ZdxuAW+q4Z7Y0bWmNgz0KQ5Pm/ypMGk=;
        b=amrtkOLWdi0Xhm/5AKQ3KY/VDwE4zXtjm51oYhBdxTxU6mwxJIPLetAOTzL/pyKaqB
         xi+AXicfaI5cZYijkcr4RRuA2Vwgl9bTWNQarXT6K7M+6pKBdThj0BIKbb6LqTMIrIDw
         S+BLGQBEIdwQ8uggFx8vQjd6dDCK6PwVjqW7s9cSjdklRDYXeWJvANuVEPZrf+95YN1a
         Q51qtsiTj+bYz9pZTkHGCE75sDzfagvDQW5xz6QUUjo80+mDRvtjisyPVpKDkk59bkGS
         hMjltlL0AaBvMY+r7qZzMzoB9+We3FEbj6dYEKIErLgP85B0gwiXxMnOHMJGvNGwz2Bi
         vwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754633935; x=1755238735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KmV2G4ucO47ZdxuAW+q4Z7Y0bWmNgz0KQ5Pm/ypMGk=;
        b=jYszYFtweVAqnwG+cVF6bBtXd1fPc9jN6HRJh7frsGqyf41fH3Cbe3sP/a6QBb9zxq
         tnk8S4rgR3+x6w2uS2+dO1KRhJ5uwWe6uKlI357JMSqMchOzcLF42oDcogvin/k0C2oy
         /s2hFUYUOLuslZJHLFwH6iqBGZ3bV96cxTA0cSOagA7qsOCQsEVcCRRHtwJqT51BWVTE
         4XYpLcYXX55BOmw6/j6iSNpGRVG4VDJbCNJEDiA3oRDj/+DVBP7MKn8rnfEzCeV/Hntz
         A1gIXnjHaPEYk4zAw8q8UGgp+IiHJxBxXMv5Fu/RiIn+jODgGuCKzBF4VHHUn6PzPa89
         02Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVf3zFlHyfPU2Mmh/S5Zg/GPaFYZPRTt7y7si6KSJo+jTGKq077Yl7FajkeweChiDcT0l4yzpjYQXSf@vger.kernel.org, AJvYcCWUpUIqZYL+P2aqlxAzPXmvg7Z4Prh5i1zXkINFRzCGCxU6HQo8IVc3D7GdKG49GuIQr+ov5zD3zt2T@vger.kernel.org, AJvYcCX3AODPqZqyelQZDQsh/fzzXjuQl2fYUsInvpNzUScc5giNa1Ze4LbDUESuV5t6dz86ATCff1IK7Jq13LNN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb86HWPFiR1WPYE//RaDzGP9A9/fNkjdFB4Smc0C87Fq/cy2LD
	PFiU5Q0b/TS8kP+49Zs4sw3g/XFCJGvYZaoVo6/kyS7GwLxwlLo4Rf/C
X-Gm-Gg: ASbGncusL1gnuZsl1rUodBupaX1hLgMImVD+WQs6MrO/3q3YxagfVDVxqskK5PoLr8t
	O5S0U8rzm9oPiRVUJBlfG8OGW3A1fpbj/HfeabosOYKvhBV3wgyYhPfw8OSNZYxwIw72FmDtBof
	9uhBtDuKZkzA4l/kFopkBo2BK5tq/Uk9HPTlf5+Mu9x18vuCueW0WKPa6BtxSwDB8jhyr2ByzyW
	DQtsHwQswGa1epreJEqwSBJJHNYgLLAaNB/QO0XJJPZkiZMtAic1l3msWo6PyM6yPgN8NuLlpX+
	sZcb3RrShHZESTkv+s1EW7feyEk6n+Gb9s5kdvCiDWX8rq7xhZWW25KRm/2C240SeMgFvYiwDcK
	5kXaLPKN9+Tv+odjc9bq7ZXcmZ6fyCtxA1YlItOB6jeWpxz0B0NhfLf3Io5xz3xwHJ1H/WaTgNy
	Z475baXw+aEa072Q==
X-Google-Smtp-Source: AGHT+IH6sezSHnQuyRwjddg3YVUrF4CLfKvD4jkZygglDI119XXXWf7gyjHbhsw5EkeF2L8utX18Rw==
X-Received: by 2002:a05:6512:32c3:b0:55a:4ca6:d72d with SMTP id 2adb3069b0e04-55cc012a274mr447439e87.30.1754633934700;
        Thu, 07 Aug 2025 23:18:54 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55ba8698372sm1395155e87.166.2025.08.07.23.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 23:18:52 -0700 (PDT)
Message-ID: <f65b50a7-58b8-41ab-9d7e-718dffbacfaa@gmail.com>
Date: Fri, 8 Aug 2025 09:18:52 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] iio: adc: ad7476: Support ROHM BD79105
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <da7e6b31a0f25106d7e2f56fb089c8fe71224654.1754559149.git.mazziesaccount@gmail.com>
 <CAHp75VfBvqzKR53qTbiGxE-JQdLOuA3+M-Z=9S6LTf0fGnwmvg@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75VfBvqzKR53qTbiGxE-JQdLOuA3+M-Z=9S6LTf0fGnwmvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/08/2025 00:28, Andy Shevchenko wrote:
> On Thu, Aug 7, 2025 at 11:35 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>> The ROHM BD79105 is a simple 16-bit ADC accessible via SPI*.
>>
>> The BD79105 has a CONVSTART pin, which must be set high to start the ADC
>> conversion. Unlike with the ad7091 and ad7091r which also have a
>> CONVSTART pin, the BD79105 requires that the pin must remain high also
>> for the duration of the SPI access.
>>
>> (*) Couple of words about the SPI. The BD79105 has pins named as
>> CONVSTART, SCLK, DIN and DOUT. For the curious reader, DIN is not SPI
>> ISO.
>>
>> DIN is a signal which can be used as a chip-select. When DIN is pulled
>> low, the ADC will output the completed measurement via DOUT as SCLK is
>> clocked. According to the data-sheet, the DIN can also be used for
>> daisy-chaining multiple ADCs. Furthermore, DOUT can be used also for a
>> 'data-ready' -IRQ. These modes aren't supported by this driver.
>>
>> Support reading ADC scale and data from the BD79105 using SPI, when DIN
>> is used as a chip-select.
> 
> ...
> 
>> +static void bd79105_convst_enable(struct ad7476_state *st)
>> +{
>> +       if (!st->convst_gpio)
>> +               return;
> 
> Still consider this unneeded churn. 3us delay is tolerable in almost
> any setup with this driver.

Very simple and 100% clear if (), which avoids uninterruptible 
busy-wait. I _really_ 100% disagree with you.

Luckily Nuno suggested a solution which I think will mitigate the need 
to fight over this. :)


>> +       gpiod_set_value(st->convst_gpio, 1);
>> +       /* Worst case, 2790 nS required for conversion */
> 
> nS --> ns (SI unit for seconds is 's')
> 
>> +       ndelay(2790);
>> +}
> 
> ...
> 
>> +       /*
>> +        * The BD79105 starts ADC data conversion when the CONVSTART line is
>> +        * set HIGH. The CONVSTART must be kept HIGH until the data has been
>> +        * read from the ADC.
> 
> Is this terminology in absolute levels of the pin or logical ones
> (that implied active-low)? If it's the latter, use active/inactive
> instead as the GPIO subsystem does.

Ah. This is electrical high. I have:
adi,conversion-start-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
in the DT. Open to suggestions how to make this more obvious. Thanks!

Yours,
	-- Matti

