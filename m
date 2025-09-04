Return-Path: <linux-iio+bounces-23718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C821AB43E5A
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 16:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC98D3B306B
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E151DE89A;
	Thu,  4 Sep 2025 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lqwssEzK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAFD19D081
	for <linux-iio@vger.kernel.org>; Thu,  4 Sep 2025 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995323; cv=none; b=d+7nNLRphu44jczZ93x2HnodPXb64ybn6/7EM+a+SF7kyhPnuFhXdfMfFLUketlOBR2h7gHTDE7QgZ0yAhlsbO3kK1WpxXUtTk7+mwWDynHjBSEHyLfeBV0bY4udjzDRGiI0YRlIcEo17PK6vjKiMWn3eMx1/wkM2wL8gSbdFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995323; c=relaxed/simple;
	bh=JUVIhjsLdfiCVR7aTSBrg6qWnvr8Z1sIuOVbEZ1Yyj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yd/+PN7fVgvPZrlZPrhiAiVibgOHafr6NITyqp6rRVobQc/X3DaGWGLi6qtuhcFlZs91/W86IHv3gAhBkjh29o0j2pWyT1tgRb9ltLbpjnkhQgtfPwYCUeUqh5/qtWncNI2XEO4T2lbKm9NCpF17d68VI4WciAr6tcdIkjmGXtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lqwssEzK; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-31d6aa3e73fso730876fac.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Sep 2025 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756995320; x=1757600120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4anAvI6zTkpm38DA6jxPpN7MX7YPUcpKLf5CSNRTAAY=;
        b=lqwssEzKVna+NjfwQNVLyWW/JMI9KBRDDNy6zcLgkzdWZW+Av4pLeunyajGWBza2IJ
         I+HLZ9zrDRPXeDRFPBTBnjGhUe3b2CA4KSn1ogEBskQkFQbvm93hCPd2d+lDIE92+jS9
         ky0Ivqye9k1Ju+CKmZnmborzsWaP0KC+SbvgTo0+PdpJG0sMHyUuNBGMZeitg4d9LKzq
         CrriTLvkREk9jfM2gsxTasT0SBCn4FbFEbYBAHtmysBihgpv886jLLPvt2xQFplOoHgH
         1CDVqgxeXhfw85CGNVHlKSVhgHfBVnd1IjS4jiz3ViikzXgc9Eb19omt4mUr4tKkMw7N
         wmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756995320; x=1757600120;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4anAvI6zTkpm38DA6jxPpN7MX7YPUcpKLf5CSNRTAAY=;
        b=ElPTV/3Nm8yq8i0xG0FgAtCB0v75BQagRFRAXhEwZAvdYXQw0CLaTRivfwgcdhTNOz
         hhyR8ulRX+FKCyfpuqkqZxXR/ScPqzb16OKr/L+eD7AkE1j77dR0xW5N+wzllinVNtjX
         LERCl+BTjoZo6hfU7/6gkqlMgju6MemC16QOmoq9JHcXKPOpxpceLkmro4W3gSzDQlcr
         oaJtSTa/XJmJmTaFrAh8NgtmWOR4e1/bFIJ4p/8VoeSQ8kBd97/XeHIk2/R3A8JRhfAJ
         ssyNpqELPuBrxF0eOP5MRQPmbAR6uSZ52rErLmLDcYSyYc9bLl1kp0PZ7T6+de6+7bC2
         Hg/w==
X-Forwarded-Encrypted: i=1; AJvYcCUudpN/KHbC/sK/wHLg+FZaAgziaE6WiBSTIxUfKWgzKuOO/8ete+qXXft7LSveOlgU8V7I1IWNm5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWpcKXB1Ua6rWuRRXb8WXGYVFZoUpLTdhXxrrr0+9ZsVmdqjA3
	VsI4RAMdqdmSjLuZvsJJqH0wRVqaMoR/QuKexw7ww/Be/gUdxRezcnpUj5iTsmQ6Sq8=
X-Gm-Gg: ASbGncuupT2+IVEU6q4TbIomt59qutlpHya03fNoMgLX1IQmTYKZJJPjU7UO//4DrQl
	2DBSScAj42VUnzzQji1X857mQldQ+mEK4Rm+AkfgAQKu0bE3M8XerNrsJBf1erSnRdFj+0L8xUT
	KiNseDcJN0PBoutJGQDxcvrlDd0pGCaBWBvXS7x+udbed70VcnbHkohtQQoJsdTyDHQN0ECaEQ6
	fa0J0GQV7mRJAkzn48E+pS24fygEyhDQjHCS5+AnUxBsgW7PvNXEf0aGJARuqG3wkP9inJJtC0D
	Ftkk6om4HJhEtvwHk43TfPjeVT0cwdwfqj0QsXzRLtI2Bwez2ik4XbM8mtyvVouwNKeQy08KtFc
	9mq0OwjocSXQBAos9mveNLkBB1Aw56Ljlab5AgBVo+5IYcM/p+Dh8zBdcJHmTqxJ80YIu9zhfci
	s=
X-Google-Smtp-Source: AGHT+IGRYO6SnExFlsmIJCjeNxDbRtF2TQVIicSprf2/RUZ5NXsJCPkFpy0op4VxPZC8Wzpgm0M8Kg==
X-Received: by 2002:a05:6870:1582:b0:315:60a6:c28f with SMTP id 586e51a60fabf-31963098d63mr10467732fac.3.1756995320259;
        Thu, 04 Sep 2025 07:15:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a178:aa1c:68f0:444a? ([2600:8803:e7e4:1d00:a178:aa1c:68f0:444a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745743b393dsm3113630a34.35.2025.09.04.07.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 07:15:19 -0700 (PDT)
Message-ID: <0a64efe5-9b07-4188-be30-54f268e862bf@baylibre.com>
Date: Thu, 4 Sep 2025 09:15:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7124: fix sample rate for multi-channel use
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v1-1-f8d4c920a699@baylibre.com>
 <20250901165751.305d0a68@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250901165751.305d0a68@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 10:57 AM, Jonathan Cameron wrote:
> On Thu, 28 Aug 2025 11:42:28 -0500
> David Lechner <dlechner@baylibre.com> wrote:

...

>> @@ -261,8 +263,12 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
>>  	 * fCLK is the master clock frequency
>>  	 * FS[10:0] are the bits in the filter register
>>  	 * FS[10:0] can have a value from 1 to 2047
>> +	 * When multiple channels in the sequencer or the SINGLE_CYCLE bit is
> This sentence doesn't read. Maybe something with a few more words like.
> 
> 	 * When multiple channels are enabled in the sequencer, the
> 	 * SINGLE_CYCLE bit is set or when certain filter modes are enabled,...
> 
>> +	 * or when certain filter modes are enabled, there is an extra factor
>> +	 * of (4 + AVG - 1) to allow for settling time.

	 * When multiple channels are enabled in the sequencer, the SINGLE_CYCLE
	 * bit is set, or when a fast settling filter mode is enabled on any
	 * channel, there is an extra factor of (4 + AVG - 1) to allow for
	 * settling time. We ensure that at least one of these is always true so
	 * that we always use the same factor.

>>  	 */
>> -	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * 32);
>> +	factor = 32 * (4 + avg - 1);
>> +	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor);
> 
> 


