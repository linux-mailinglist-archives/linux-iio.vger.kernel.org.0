Return-Path: <linux-iio+bounces-18912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04831AA53BE
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 20:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD729A2666
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F8B26562D;
	Wed, 30 Apr 2025 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kTPTEtlx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A941C6FE0
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038020; cv=none; b=ZcL3JlTHGBumAGsakliHAEH//ZRuxlrgla/Kbei0evLUBM017uVMXfuwIcHSiemWVNhjOPYog2OssaXOVjGQc7yvqS5sOro/00kfQPLDh3tzYjY7k1wCxMT+Zz4djaa606zOLbo7dz/1ISUkrOcaFRPAXb/wAT20wewXsqkiKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038020; c=relaxed/simple;
	bh=nvBULGbN7c+mQ9lJkUnAGdBDY74gyxKHw/37B/Drwe4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jx+KNrooHfnIK4b2fdYmgmL8vjiHdm9G0pM2kl4jRAHD+Xj0v+FMQxFvrnknmGH33K5zupTsPTRvwAtLInfcpg++KQwLOErh8sy1JyzauynbkYKVrG9EZsHftJyeP354AO9u69XTwmkyg3FJgQvSuruoQZBobh8W+L4uyRDDot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kTPTEtlx; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72a4793d4e2so84112a34.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746038018; x=1746642818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bhh7Yy/ML2gRa+hVqpAWpNr84ikftSdkLJWeAvX4C2I=;
        b=kTPTEtlxgS+c2o1ZOeWyZ7bIJ82T5Obia2zwW5HTjcNMXxgvvtpvVOJy+DL2b2UZ9/
         o5Sp0B/Bhq3cXXOk0zVeilPqjzBjOgFhU8i104lybOHYxJlGQl6/drbHxvK5flLjtCOV
         SswRIm9aCWkRyZYDlFId+QspXpyVQ45620PZdhNCTnIudVn+SMS2RPJnrMU4jwQv3gyn
         Gb/r6W7kbB4TP4VatM19Vaj8h7wRjFY5UuzQF4/opFeJR43BoI1odBi2tla5+rNe3NmR
         e2rgmHpwlGctMAqZ7OUiVwwncORQw6fkYo40KmEnW+59Vmfa+wWXyQ7B8/GBB5xnC+yb
         rgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746038018; x=1746642818;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhh7Yy/ML2gRa+hVqpAWpNr84ikftSdkLJWeAvX4C2I=;
        b=aaidFeNpieg26BSMyVm5z/R8xph7BHlaae6os80cqJtk33B9fT6eFPZiYVcP7rFa2Y
         r1op18UaTwnGQYfoggEMoSc3AIKTSSwGDUbvQ379z3dgT+MHkqbefQbD9ZD9Rttk7YcE
         wsmgni4MioPLSog8Au0LjE72fYVcGNe4d9mtcrBvUQFfu/WnTG1s//HjBxGK6/9URjUf
         hKuuDAau3ixPWEgHKs1gk+KHtd4jVrYm9ixlHcA8naiRtb8mn5zfwSM3jUd6BwJaVz9q
         XObUrrL/HltHDZhjTEXXA7oxiYx91M1l/w4uytWfS/T/gfxv4VR306K0Qcp+xtcv2Tgd
         GwNQ==
X-Gm-Message-State: AOJu0YxY3WvNW+LIODTo6BWULoTkojdHnSkPqAkNd0uIpKDFO1+Nn1Tb
	iSLTHHYm8PixCFTbVj6atLQnnbTZD5ecBafWQT4Y1c36jDgOYbZU71kZYxFyctU=
X-Gm-Gg: ASbGncsU/rn1PxMY3DlbBtEoOJseZODQVPQLhlcacpX75Qg4hIiPmCr+uVuRPeQ2VQJ
	29iR7Bk38BIsFs24++NAB9FqsUHakhxTazCNcUnFxvTyzoji6iAIfvaCrsOvUREnif9jcGd3Q/h
	RITlsMECKyr1HzNa/KsDFcD30RtSN1Yz4gArLDw0S28yUlkcK0om3W4mAM5FSewgXNOaJmMVmPx
	swN9ZfhVjtNQYmWqFu1HdNdlrrHgvdm/KfA5a3JeNBq43rquD+fec7RvyQMc8xU8iqUKdvnZPem
	4421LXu36LvZ8HjIg8Bs/pz2wSU0HtUtAlOzIX9m8fe5QE19lzeHRs7eywJxwmcacZ5ch45R+g5
	BCwz29FdT+XrisXGHQMtC4EAScA==
X-Google-Smtp-Source: AGHT+IHbIjYVljXLsdKYQQWRQpAy+l9KRVU1cV2K69m6KCRFTLwRAoGzT6npWbnEi3pF5FVxdEM+oQ==
X-Received: by 2002:a05:6830:2aa2:b0:72c:320b:fc8c with SMTP id 46e09a7af769-731c0a7c762mr3169245a34.21.1746038017706;
        Wed, 30 Apr 2025 11:33:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:359a:f1e:f988:206a? ([2600:8803:e7e4:1d00:359a:f1e:f988:206a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7308b312cb2sm992682a34.60.2025.04.30.11.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 11:33:37 -0700 (PDT)
Message-ID: <b4598086-e188-4dca-b060-0dd82fc79c02@baylibre.com>
Date: Wed, 30 Apr 2025 13:33:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] iio: adc: ad7606: add offset and phase calibration
 support
From: David Lechner <dlechner@baylibre.com>
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-3-eb4d4821b172@baylibre.com>
 <d273fa78cb3986da5249bd800dd25c4c0bcfde7e.camel@gmail.com>
 <9c02b2bd-dabf-4818-8adf-83c9127946d1@baylibre.com>
Content-Language: en-US
In-Reply-To: <9c02b2bd-dabf-4818-8adf-83c9127946d1@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/30/25 11:14 AM, David Lechner wrote:
> On 4/30/25 10:36 AM, Nuno Sá wrote:
>> On Tue, 2025-04-29 at 15:06 +0200, Angelo Dureghello wrote:
>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>
>>>

...

>>> +
>>> +	val += start_val;
>>
>> Shouldn't this be val -= start_val?
>>
>> I also don't think we have any strict rules in the ABI for units for these kind
>> of interfaces so using "raw" values is easier. But FWIW, I think we could have
>> this in mv (would naturally depend on scale) 
>>
>> - Nuno Sá
>>
> 
> From testing, it seems to be working as expected for me, so I think this is
> correct. The register value is not signed. 0x80 is no offset.
> 

Heh, you are actually quite right. Even though it working correctly, it is
because the value that gets written to the register is val & 0xFF, so adding
or subtracting here basically has the same effect. But subtracting is the more
logical way to do it. (I tested it that way too just to be 100% sure.)

