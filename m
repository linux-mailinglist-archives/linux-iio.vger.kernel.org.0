Return-Path: <linux-iio+bounces-24017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CC7B55183
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 16:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868DD3A6785
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49C33164D1;
	Fri, 12 Sep 2025 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rsIoBwud"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01C3164C8
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687145; cv=none; b=EBPeeTPBNoYHrmvkvku3bLnh/h32SIrs8vdnk6xCHbsf/wuAzx92ArOaALGEROaOmD/ICTVhybp1ERfLnB8o8USAF75D0o70SWHwJLEoxDY/pFtQyjq0GWvv9VanXlZ4RLeHUYf5QbL5paMAWoJbYXojNSz4FghdIGA5pHlhjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687145; c=relaxed/simple;
	bh=ObQub0Fn7ODydg5DGf8K9+pxMyAg4npUNxDcfdTxVRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVfzk56BXn8sRWb1ujhuCBtFhuSPCItuMSJ988HQi8RxcdsskVa+4v2xyjpWUsnMF21QlxZffiURTcZP4KMEdPsOzT+xsLhTTOSQ2QyxeZ0u5CAtNGkFh2zLIeSdvnsfofY22TJ0aQQUWKa1Lp+LrNDVh6RnTuAz9k05Dc5IFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rsIoBwud; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7459d088020so985050a34.3
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757687142; x=1758291942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0+BU7GduzvivgLsJAA2dCFR38oEykasv0I1p1J9djc=;
        b=rsIoBwudzsQoXa83Vw3sn8MbAZfQYwBcUHlp1DMDJIUEom8nX2JFk6s7vQdt8nWo3h
         WOT2N4tJC4yWEQbw2FgnZWGmy/LWcG+J8it33H7wHl9eE9UU5vZwS553WyJiThmBABDP
         /+/RxSiGTfrzIfoQ5WNYdHkPoUtS0UDT3NTdPLQ318REY1FAdyFe1SVgOnRItURTPY3R
         +GLjcLr2FGH/FokSitt2eXYaYBKv1ZgxCrnzBMaCuH042ABqQRJygLIsSZl3Y1+1TaLO
         7ktyqjNJGhL9nzqhMC2/XlbnPKJIoBKG9d07StPaD0G6FLejMhgRfFcWN1bxMwiKD1Fl
         b8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687142; x=1758291942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0+BU7GduzvivgLsJAA2dCFR38oEykasv0I1p1J9djc=;
        b=ML9NTip/Q8GoxSRbkbb+mnrPwhcLv8BB63OIerItouyiPZqAyEie9QXRxcvYMxGBc6
         tsP/D/n5htcs5YTPM1kDg2grlxwLqmjIamlpTNscn98RTQr2VPvFiK0GySHUyDXEil2Z
         tlGhhd5yMC3PuMPlcwBhpW0UdMOKfQtI5s9bDSZBta4wiWinoFI7RubWMEHUbyxX9Lwz
         sB/xV6D99rYwDM1//nyDXfTH8G6FBw6/0lAY6uoUQUviKTZQXQp3kiIwyGJSOvuvrkFP
         cexZK8jev73SAhIBv18xc7Gbrmrz3X2k2/5iFPFuHpxapoXSKrZyRkztMGLyDEsUpflF
         poVA==
X-Forwarded-Encrypted: i=1; AJvYcCUo0lp5N6Dh7GpV0J/UnV4LSkVs4/7SyALM94PotNDtSOHZABliFsBCspl3gK2g58sHJ9CUSNaLc8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBBok3IbV6yGjo7LF6haLPVsP6nBj+UOhupK0sINbUtO+G33J2
	5saX+5UWc8iPL3sGFOh9OBNv7sxRqRdYbnm/TZeWr/gpBEPELgo6BVhNx+bns/6Lh2M=
X-Gm-Gg: ASbGnctlpIL73yDYhqZU4VmPHMASfyCQ52huZ/HzRZLKJnxtPNesqC2mV/6cjDMJQhT
	a2c38TmXdY09gU39Zvowzel3sx/q0FIe9PHn67TchYXArrmlVzRQ88EfKoRWSBoo8HYiUew/9hb
	HlVQKSz4CUihjsqbTBJv6tPJXe+2YQjUwMuCdMgEbvNV2axc33qGnNKWEymwtfSjAubh1vRyYHf
	ZJdZdL3aVDC6Lcls8VHEK6m139jn95l+YundekIAmMYtoSJyTmCPHAv8P9h+jgFLBOxWgm6Ayzs
	vzasyBrE0F4IMCDCPZS4q3G7Km4iq+c3W/9KWQQShUpv0RAADjV8Y4u6x8vd1v8JnVvLHG3jk4h
	jQe6PfF2JKkUvHbQ5+gULgFNawDNMgZhqmhYLMzdsnHQUmVY8/9p+bwtb6GC9eastoWZIcjpzVV
	4=
X-Google-Smtp-Source: AGHT+IHpKSZF4MQEZ+u/oC7k9WZoRds7vIivV2qRW4sbQwQlgWqoybEkVA4pca3nFzL2BSPAaioX+A==
X-Received: by 2002:a05:6830:6615:b0:745:a095:22a2 with SMTP id 46e09a7af769-75352d8e0c3mr1671283a34.7.1757687142583;
        Fri, 12 Sep 2025 07:25:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1? ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986ca64sm1037256a34.14.2025.09.12.07.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 07:25:42 -0700 (PDT)
Message-ID: <889408fb-e7c5-4a1e-be96-1f632e97469e@baylibre.com>
Date: Fri, 12 Sep 2025 09:25:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] iio: adc: ad7124: support fractional
 sampling_frequency
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
 <20250911-iio-adc-ad7124-add-filter-support-v2-4-b09f492416c7@baylibre.com>
 <CAHp75VdMSr400YokZfv8SAkt-M8kuw7gt4+eCBb68xt7ipKJbQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75VdMSr400YokZfv8SAkt-M8kuw7gt4+eCBb68xt7ipKJbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/11/25 11:45 PM, Andy Shevchenko wrote:
> On Fri, Sep 12, 2025 at 12:42 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Modify the attribute read/write functions for sampling_frequency and
>> filter_low_pass_3db_frequency to return fractional values.
>>
>> These ADCs support output data rates in the single digits, so being
>> able to specify fractional values is necessary to use all possible
>> sampling frequencies.
> 
> ...
> 
>>         factor = 32 * 4; /* N = 4 for default sinc4 filter. */
>> -       odr_sel_bits = clamp(DIV_ROUND_CLOSEST(fclk, odr * factor), 1, 2047);
>> +       odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor +
>> +                                              odr_micro * factor / MICRO);
> 
>> +       odr_sel_bits = clamp(odr_sel_bits, 1, 2047);
> 
> I would rather see this clamp() call to be the part of
> cfg.odr_sel_bits() assignment, otherwise the above line and this
> operate on the semantically (slightly) different data. So, the first
> line should use different variable name, or the second, like
> odr_sel_bits_clamped.

If we moved it, then we would unnecessarily clear the cfg.live bit
in cases where clamping changed the value.

In a later commit, this gets combined to a single assignment so
not much point in adding a 2nd variable temporarily.

> 
>>         if (odr_sel_bits != st->channels[channel].cfg.odr_sel_bits)
>>                 st->channels[channel].cfg.live = false;
>>
>> -       /* fADC = fCLK / (FS[10:0] x 32) */
>> -       st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits *
>> -                                                               factor);
>>         st->channels[channel].cfg.odr_sel_bits = odr_sel_bits;
> 
> 


