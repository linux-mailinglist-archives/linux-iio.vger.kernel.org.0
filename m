Return-Path: <linux-iio+bounces-22453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E168EB1E939
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 15:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21B15A0EDA
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 13:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556B627E05E;
	Fri,  8 Aug 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnQmdluM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A39A27E04B;
	Fri,  8 Aug 2025 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659804; cv=none; b=R9OdKISomPjDqC6OHaUlanNwQMqIYhZ2mJIaw+oSXgw6H3VxxJwGcrDn4oz9LHmpcKvfnQiiiF/KyQmOQG9bL9pr2QeSlggjAaHaaG2y/7U8zqi8F27WStqsVlw+C0VZ08hIvWCrMTbuM45MvyszRf0JsRF9LBCkg4Y8yeh2RQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659804; c=relaxed/simple;
	bh=JqsBT8kxVG4Y6VR+PJMqNSKguUADLGMymL7/0TC0vlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cA3NP43LddM+x58TV4k/C5wAeggS+3fEGhTsnDZXGUvsEnJLPt5gtTD5qux6/9efA/VNyqcqhEZn7ehYa8sq+TtQ+BmDKfP1YnGFxS6rtefokMIXss5rLxFZgesFSHyWgsX7jtmoJbhBHu7ptXmjCLgjjF4rPgFtQM/WkdgIhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnQmdluM; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-33243562752so15254461fa.3;
        Fri, 08 Aug 2025 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754659800; x=1755264600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ukWaxOm7+Q7x1oCnPSznQeQZdoQjCmG1PbzKJVPZIg=;
        b=OnQmdluM9ooGDXDoX+lrN0R9Zhevqj+BFTFvpL564TYvCAM24Hm9lZTo6GROkUoqtQ
         k2JGRcu9cP9AoHYg1hHEFZnVDZdwVSpMZe7sryJTQ+uyIDXUcKVhOW6CtMSAGVULHLgQ
         vtXFM7z6L0Ib5+qq2KUKi70/iQMywux0nE5c1cThioZkZYkkgtGenS61UY7+OFx75MjS
         WO0sbckJlDWRHVLBziLb3zAr2rVucGVigNdoqWbBtRFnQC5lIUlOYuMYpfOrorVVI/uw
         LSKXRLzvK5laQsbfwRNaKqqLmr+W1gcqoxUNUVN0xT72J3/BopLcJWtmINSs3DP1sgzB
         LJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754659800; x=1755264600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ukWaxOm7+Q7x1oCnPSznQeQZdoQjCmG1PbzKJVPZIg=;
        b=mrOInZynUMvP25xHol9fuBTclijvjRsnKFqAB7Ye3SZZeeX2v2RPoW42kTjnQQnzFN
         Xeclptbkmq2shBrkmDz3lfEk+pLroP8rWMtx8rdFjQpBlOdYmml1YlSc7WG4kIDehDWt
         hTik9+gRuPVbmojZTJoSHdHX4MGcwR8OppRQGOAByldvTu15j+Iq8sxlH1UQu44FRntZ
         lOy9mVS9MuZ5wxof6xJ+GJI5SFxpqlJgF4bLdoQ2lYlwcWYrt2vQbClLBSuhXoA1h8ax
         jtYUJRrllCFcj7gGgIQ/UUpHfV+pWiFRJnukt/K1eR6sPxX/XxrzvLVIO1ZFyyI48uXS
         l4wg==
X-Forwarded-Encrypted: i=1; AJvYcCVyrznwGe3J/yU0B++il6UQlpvA2A1awVuDqR4KedPz6lU3XcEyXXCIfng+qPrvwBlztG/AcxLBU+UNYTQq@vger.kernel.org, AJvYcCWlHHOaTfLLavLjRBz1WwQDeFSYgP78GlBGihr5H9pGd4mr6T7W7x2vIcWeeys03LUQ30kYvS2cfnzJ@vger.kernel.org, AJvYcCWuOpq/ypqpRu0QunXn10Ul8LpPu7BKcZ4RsMEuUBEa0TTY90OSpyzPx4QkqkdhMkszhgFtKq6U+VOL@vger.kernel.org
X-Gm-Message-State: AOJu0YxdS/lOhkGvYlfTUOkt6tbsNz1htTtrEzvCvMqYE9Pft6zzup+x
	JYRHexX63O04Diuo7We/3zdKm+bhS0J+AAaHabGZ2mUQ16yJ3GhZfi/iyLuv0A==
X-Gm-Gg: ASbGncvE5YSjm/9Su7WCkuizSYmpXLtC1NU1qtLd5SN6YI8CPq7Xq8R5xaOdxHikTPF
	hZnZfn/oaKxJmKK93NO+j7oE8QguATuVyd8hooXDXxwl4hsSyjF0tkNk27pOMCtA5rvX3LCeiYl
	nzzSdMnp1lFOvHrSB8wG7cvamPe8XwbDmq7cTAWG9XrMZqFs4FFUMrzbucCRWmM4GhO91LuKIL9
	lxKk5BZ8wdkt9rbioFJdCL+AgOMUNCqWBrURMfOwb6xAnHSYMQ3ml2fg8CpJzL4UJboRAhpFUvE
	eMeWkUqodNzq0BSKj1eVwAwLtEaCJkNIoN1IcYE2LGnIZrT24UWbprMmPO67vT+0jsfyRy8Fk5D
	SDJvtQ1nF3Wq0GrZcj9oO/MwgMgGq32wjF42BLX2a2GGvCOWEVzN9JLQ/C1RSHBIgk+IhxepNU4
	uc6Js=
X-Google-Smtp-Source: AGHT+IGnVEHz2x7KszxqBnowaQifC0d3brGp2Mm1k/bgJTaibOBNdZDQB6pGiCRUPryrXaeg+0/gIA==
X-Received: by 2002:a05:6512:3408:b0:55b:5b33:bc09 with SMTP id 2adb3069b0e04-55cc012a3cemr972573e87.28.1754659800120;
        Fri, 08 Aug 2025 06:30:00 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cae595sm3048678e87.155.2025.08.08.06.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 06:29:59 -0700 (PDT)
Message-ID: <83a6949b-6e84-4a0d-9a95-a9f45f62e84e@gmail.com>
Date: Fri, 8 Aug 2025 16:29:58 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] iio: adc: ad7476: Drop convstart chan_spec
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
 <09bf5e7973c37413ada950741e6e09c375e37c57.1754559149.git.mazziesaccount@gmail.com>
 <CAHp75VcHR78Uwgo74n-i3a1sSfDxBwVKWihcnFp5x3d=puAySQ@mail.gmail.com>
 <13505077-fb36-4126-9767-fead98e01009@gmail.com>
 <CAHp75Vf7PbHPFuVjmK1xPMZxotc81S6FAQkgZ0ETNXSWozaUQw@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75Vf7PbHPFuVjmK1xPMZxotc81S6FAQkgZ0ETNXSWozaUQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/08/2025 15:52, Andy Shevchenko wrote:
> On Fri, Aug 8, 2025 at 7:38 AM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>> On 08/08/2025 00:16, Andy Shevchenko wrote:
>>> On Thu, Aug 7, 2025 at 11:35 AM Matti Vaittinen
>>> <mazziesaccount@gmail.com> wrote:
> 
> ...
> 
>>>> +       BUILD_BUG_ON(ARRAY_SIZE(st->channel) != ARRAY_SIZE(chip_info->channel));
>>>
>>> We have static_assert(). Why can't it be used?
>>
>> Don't know. Can you please enlighten me why one is preferred over the other?
> 
> Despite already made changes, I answer to this. The static_assert()
> has at least two benefits over BUILD_BUG_ON():
> - it can be declared in a global scope
> - it produces more condensed (to the point) error message
> 
> That's why in general it's preferable over BUILD_BUG_ON().

Thanks. It's always good to learn something new. One of the great things 
when working upstream :) (Although neither of those points seem to make 
a big difference here. Oh, and AFAIR, there was a variant of 
BUILD_BUG_ON which allows you to add a message(?))

Yours,
	-- Matti

