Return-Path: <linux-iio+bounces-6349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4E490B1D0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437EA1F2A7A5
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1481ABCD0;
	Mon, 17 Jun 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJbAJPpx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634819AD49;
	Mon, 17 Jun 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631540; cv=none; b=Jokus6dFrYo+C0YeX8K5YJirOuHVH7LMGmL2e4JmtRmGpeBXwH8vzJ0TL+bLPvP43rw84gQvSoXZ0xt8Ud2/RubIMQk9QlkJdMkDy2arCMg4FMOtf/oSYMAd0GQ6gzo0TPCOrI7kwBuOxAXV/WVMJIkV0J0vIi2/UlXpnrmqgSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631540; c=relaxed/simple;
	bh=l5KIxW9tSxs9hwohlpIcpXrzo4OHvuyBSWhUwUYJpvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZsEhki13xSoPQ4AY4TpFdVUH/ewlsh6H1t8Gvh7wjWMmr5SSvImsDr7t65vp+FqJKVUtWNk/gIbdg6Pu2Pd038dXfQJyepbAKo+5n0ZMZPqvWhVglZpN4hsw624VjZXYE/hzrnCAn1Ai+a/qUbTDFkFP4erM+xrShfsLugZLzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJbAJPpx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57c8353d8d0so5748179a12.1;
        Mon, 17 Jun 2024 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718631537; x=1719236337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYha8UNNTCmht5xsvtGn2gi+rlWYNYEcH/Eqsj2LtLg=;
        b=JJbAJPpxunVdUKQGBSOT1vAIp1XGgNefHRQe5+EsDROFGqlIw8Uo2PI6KiyDLPw9fn
         Ute73xNtyCFcydhklUeyC56tdInceq+HhGKuBcuaoONxXjsQvpZ5J6V4g0MpMPs1bxzq
         2xxBaoMuSBZLB6l6T7GxDRTm1WerMwyk5OYVYGic4PuAz43oFVyKwJG4jt9aU/jOgDVZ
         LWE+//dXfGfCcf7tw+PndFHmi4IFY5VrpD3hbpyPVmcbsqwvSmX78jHcEZeAB0tPX9qV
         Ex7YIubHey/tWw17lsWKT41P6hHRANIrSNH1nQbi7W7xA2BQXYIReZGV4BwTNux8Iq3o
         7dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631537; x=1719236337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYha8UNNTCmht5xsvtGn2gi+rlWYNYEcH/Eqsj2LtLg=;
        b=tDDbekzqPcl8hLdmXrEN4jDnvgV4nGhvJL8QZlB4d/0Y0WlNfeduMn2JLlt3U0hA0a
         ROFhll8HSYH1OgEijdP0xDzWHyMvefNgU7Uq16tZFQv9tBQGL7kfzY7mpZUu8KkY4C4A
         3uA8w1tJl7EoTIDMe+fUeVY+DOr6lreOTJoyERf3Cwp7Tt14sNAEbz8REkvaqJ19Hh5C
         UPckOL0upeyJ+zjBKupbPl4dBJmPQ4/U+LN5s9bJyPpACqLFe00QfSnkpnC1oPpeOvET
         VF8n63zAqQ0TJ/FXCilA7ZVid3MTKEInEy39+ynsqI8zfQQyk8Qu7cu+SmH/iU3Df7dD
         VmBw==
X-Forwarded-Encrypted: i=1; AJvYcCWk1B1EliEkSRPO5xYORZRhFYI2cULOmbFWdR9Xo1y2HaeLX65pRiIl48yTmRfrqXqXvy23IUgigr/VOzxRbyl/svFWPxhxt5oplZNiBEtO22D+1wqLaGddAJEuQcO8BOBII0eQCGTq
X-Gm-Message-State: AOJu0Ywq1nw1lSozA3YpWVwBftP8YvOy8S1jScsV0wHBaSCtkZDEamLz
	RaaYdbWA/85m3bNHXcj9gk/+IS4dqTuC3jqU5b66KSw6nEanhaLG
X-Google-Smtp-Source: AGHT+IFRRTVspRO+pLi4bjTp9SYGVDHOOYTwKiSfplredXYS8hfK3TpfHd82Jbond1G4PXSuHlIpuw==
X-Received: by 2002:a50:9541:0:b0:57c:c3e8:e6fe with SMTP id 4fb4d7f45d1cf-57cc3e8eb9dmr5679175a12.36.1718631536852;
        Mon, 17 Jun 2024 06:38:56 -0700 (PDT)
Received: from [10.76.84.188] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da371sm6400212a12.24.2024.06.17.06.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 06:38:56 -0700 (PDT)
Message-ID: <2d47aeef-5ee0-4e6f-a408-ba5d737d2c5a@gmail.com>
Date: Mon, 17 Jun 2024 16:38:36 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
 <20240612-iio-adc-ref-supply-refactor-v2-1-fa622e7354e9@baylibre.com>
 <20240615130858.22043725@jic23-huawei>
 <dbf947a3-3d3b-4686-a707-a813b6a4ce5a@gmail.com>
 <CAMknhBFJ01Xu69Arvd3S=dbADGFmzaYKm2XBtw_CtnjtYwnnew@mail.gmail.com>
Content-Language: en-US
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <CAMknhBFJ01Xu69Arvd3S=dbADGFmzaYKm2XBtw_CtnjtYwnnew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.06.2024 16:22, David Lechner wrote:
> On Mon, Jun 17, 2024 at 4:35 AM Alisa-Dariana Roman
> <alisadariana@gmail.com> wrote:
>>
>> On 15.06.2024 15:08, Jonathan Cameron wrote:
>>> On Wed, 12 Jun 2024 16:03:05 -0500
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>
>>>> This makes use of the new devm_regulator_get_enable_read_voltage()
>>>> function to reduce boilerplate code.
>>>>
>>>> Error messages have changed slightly since there are now fewer places
>>>> where we print an error. The rest of the logic of selecting which
>>>> supply to use as the reference voltage remains the same.
>>>>
>>>> Also 1000 is replaced by MILLI in a few places for consistency.
>>>>
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>
>>> Complicated bit of code, but seems correct.
>>> However, it crossed with Alisa-Dariana switching adding a
>>> struct device *dev = &spi->dev to probe() that I picked up earlier
>>> today.
>>>
>>> I could unwind that but given Alisa-Dariana has a number of
>>> other patches on this driver in flight, I'd like the two of you
>>> to work out the best resolution between you.  Maybe easiest option
>>> is that Alisa-Dariana sends this a first patch of the next
>>> series I should pick up.
>>>
>>> Thanks,
>>>
>>> Jonathan
>> I will add this patch to my series and send it shortly.
>>
>> Kind regards,
>> Alisa-Dariana Roman.
> 
> Great, thanks!

Just one quick question:

I am getting two such warnings when running the checkpatch script:

WARNING: else is not generally useful after a break or return
#1335: FILE: ./drivers/iio/adc/ad7192.c:1335:
+		return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
+	} else {

Should I switch the last two branches to get rid of the warnings or just 
ignore them?


