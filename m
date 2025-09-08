Return-Path: <linux-iio+bounces-23885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B00DB492D5
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 17:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D0116B4F4
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 15:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C341830AD18;
	Mon,  8 Sep 2025 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="imTi9JSl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7D30DEB6
	for <linux-iio@vger.kernel.org>; Mon,  8 Sep 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344630; cv=none; b=k8ke4hMngAKl0neppn3A/xZs8vhug8+KZHgefgkEc8rpcIEWwCpQi8spghhzt0M/crCupLoMOJx+eNmW/w9qOiy9/2cX5Op4BHCi/vyQmS+RLuqHEJtirrZ49AFv6QSWdxyovrn/GlKsy3nY+ToH6z95XNXqbo6/pDU0CVHwy+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344630; c=relaxed/simple;
	bh=Ey910SudTgpYwRJt3r93dbAhFoKHfLFcZseyC1yyMm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwrKilkzcTXDFt57XD4pWvvmBAlB2K+KUk/GqKu2JJf8k2vr021YdI01qQZzJl2Kf56kkEdQLStX/Ghk7zpbfxVQyXBn/cE0tpDs81mCnoBjphkWZHmceibqxNILbgru65M/nnYhKMqgXCEKDOSZEPQBlQD7HdLc1xiAKtGhObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=imTi9JSl; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-319c2a87a5aso1626667fac.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Sep 2025 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757344627; x=1757949427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oChNwab4y0BvafrCmZfguVZuMlkh+/x8QHfxe4nJNqk=;
        b=imTi9JSlPGUMxH0jZMHQeqwl5Bk/y+ZhY8YVXcCGtYZFfEVhUvexCPb9IUf4ANhjkM
         thyz21agVhJYT7C8z1ioBwv50SKXAxkv9fz0hpbLR+dlR1G7pgxHbwSmPKdpY6BLjQcX
         2+n6NUc39DhE5Eb/Y2bOh6N++1VaqpAgeeMuuKZGBuzR39RGQnUXV5O6ccPwcBer903K
         R0qiYHOIEIBYPfUh1sZAc5KQ/LeF65emuNkXwe14KJ0CNBHqGM9gao3S6oOtLD3Al3H5
         AkwOiBMUa73oWJHUyoln13hAVeLrweuNMvVZL+AmddhDEgUrrh/p+kE2PKlbFTai/qw/
         pGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757344627; x=1757949427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oChNwab4y0BvafrCmZfguVZuMlkh+/x8QHfxe4nJNqk=;
        b=d/rNZ/uYQw9+cnjYN9lBv4PqfANfTka8IaAxoGGGmlPGUgLTLvpDzZxPDPf1FvgZZj
         Ri8wlFXmNgpiVagaoBoRND8n33zcNrOtsUu3Xb+woomWnWpFniij2r1owVfGMevG+p24
         cuPwfMy6m1YMEyyKKMObQ943YBPG/jgYhdY0gOaBJghujfgpA4bFvGqXdwNkKnehN0Qb
         GQMr2GqX+aTyKQlXjKETwSskm/5CTvmjRMdtu2pKypHvzjWxf7HWkbEJL+cdmbsJz4J4
         zTKs0UN7C6uPlvfXJdwxyzHBVDc2rSAOiC09257Wot/z4gkH3d1YsL0zl5lL5MdiZ0sA
         Wd3g==
X-Forwarded-Encrypted: i=1; AJvYcCWBul5UQ5a4KU85jMwnDJiD3gp11xau38Cuoi5l7UHG1OiVFupBOsPsX/m1eL8OI+kXFmqPD6q/xIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0VEmLs1w/KWMhgkBWBXaRTOpV5Jan5kMU4q3KUvdh/hx9Vjy1
	LaUNDM7OPDQ9Ydq/2CWIO+nYh7ZMoMY1UguDD15lB2De7N98ULY6rErJ16fRYvC5t5U=
X-Gm-Gg: ASbGncu/EF4O4qslS8wnOsrom6l2iNKohMeNozE0Xqn2kRrfkf89q1NnfMCQU+mufRh
	lW3sdEwG+iStLWO1hvxBjPBVDGDuflRGTGkMybtTseuOzdUlbMsIAk1I2D5xA/MBp81/8jBajud
	4uL4WVeN4iyG8D+tw017QPR/jR9Ss88bTGEklO8qN+x6YeUVi59ISz6bmwmXyCg8INH+I3B0jqA
	nokZoO+7Dmu6PZk0elJvubxRTV0IYiPpLtJK5AHynF1qYYyhJ8m0mwDSD7fA1z8FqothZISfuIX
	fXoNPw+9oD2tGjIIDq24v1pHeUFx7E43xiL1ZPSc8zld0EcCyqrpH512hsIY9B5yMP5/J8E0BGN
	3Npbe1/+Sbw/Fc4FmeB5Z3+1Gfh9IgacZaEDkKzuAO8nbJsk2UG2FopCXQ0ywuxAEy2NJYH0JDV
	o=
X-Google-Smtp-Source: AGHT+IEv3uU9WTJh/czvFIeBV7WL0z68MTpIl41dfDTZnQ82IX2066fCpwkGkeMuhMlUQi17voCSwg==
X-Received: by 2002:a05:6870:5ba9:b0:319:ca39:4d24 with SMTP id 586e51a60fabf-32262d8be95mr3171559fac.13.1757344627511;
        Mon, 08 Sep 2025 08:17:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c856:f3d3:de1a:6f93? ([2600:8803:e7e4:1d00:c856:f3d3:de1a:6f93])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-31d7119337dsm5334049fac.5.2025.09.08.08.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:17:07 -0700 (PDT)
Message-ID: <0505896b-02b5-465e-adc4-4404d8e657c1@baylibre.com>
Date: Mon, 8 Sep 2025 10:17:06 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: adc: ad7124: fix sample rate for multi-channel
 use
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250905-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v3-1-702ff014ec61@baylibre.com>
 <20250907110013.266c2da2@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250907110013.266c2da2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/25 5:00 AM, Jonathan Cameron wrote:
> On Fri, 05 Sep 2025 12:33:34 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 

...

> Given you replied to Andy's indentation comment on v2 and that seemed
> reasonable to me + the other change is a simplification for now I think
> this is ready to go.
> 
> Given the whole ABI / fixes tag point I'm going to apply it to the
> 'slow' path and taking via testing/togreg for the next merge windows.
> 
> Applied to togreg and pushed out as testing for 0-day to take a look.

With fresh eyes, I spotted a few minor mistakes...


>> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
>> index c6435327d431e5f4ba28aa3332ec6eb90da7c83d..70f458e3ccc12db884dda9003abcffdf48989e5e 100644
>> --- a/drivers/iio/adc/ad7124.c
>> +++ b/drivers/iio/adc/ad7124.c
>> @@ -93,10 +93,13 @@
>>  #define AD7124_CONFIG_PGA		GENMASK(2, 0)
>>  
>>  /* AD7124_FILTER_X */
>> -#define AD7124_FILTER_FS		GENMASK(10, 0)
>>  #define AD7124_FILTER_FILTER		GENMASK(23, 21)
>>  #define AD7124_FILTER_FILTER_SINC4		0
>>  #define AD7124_FILTER_FILTER_SINC3		2

>> +#define AD7124_FILTER_FILTER_SINC4_SINC1	4
>> +#define AD7124_FILTER_FILTER_SINC3_SINC1	5

Adding these two lines should be deferred to a later patch.

>> +#define AD7124_FILTER_SINGLE_CYCLE	BIT(16)
>> +#define AD7124_FILTER_FS		GENMASK(10, 0)
>>  
>>  #define AD7124_MAX_CONFIGS	8
>>  #define AD7124_MAX_CHANNELS	16
>> @@ -285,18 +288,20 @@ static u32 ad7124_get_fclk_hz(struct ad7124_state *st)
>>  
>>  static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel, unsigned int odr)
>>  {
>> -	unsigned int fclk, odr_sel_bits;
>> +	unsigned int fclk, factor, odr_sel_bits;
>>  
>>  	fclk = ad7124_get_fclk_hz(st);
>>  
>>  	/*
>> -	 * FS[10:0] = fCLK / (fADC x 32) where:
>> +	 * FS[10:0] = fCLK / (fADC x 32 * N) where:
>>  	 * fADC is the output data rate
>>  	 * fCLK is the master clock frequency
>> +	 * N is number of conversions per sample (depends of filter type)

typo: s/depends of/depends on/

>>  	 * FS[10:0] are the bits in the filter register
>>  	 * FS[10:0] can have a value from 1 to 2047
>>  	 */

