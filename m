Return-Path: <linux-iio+bounces-18810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B73F5AA00E5
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 05:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A881B62FD9
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 03:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B95205E25;
	Tue, 29 Apr 2025 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0ah69S/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341CF1876
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898631; cv=none; b=DsanjgOyjLImj3Pk+MRO1FuSss1E8idiTMVYAQHSeo8Y/sjEhcpygBoC6YxehunZV157kIqySyc4SlRbULL5Humw2CGwIXHfDWg1JL5TzwDOrtF8V7/XBFK++fBoShNWoeM5sY8pQipWoKnZEniHXjFgFf4wtSU7lYV1GLQlgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898631; c=relaxed/simple;
	bh=k+XsAlcoijiCQ5MjqhpLbKI2RmlnWSNUTsejv4Dnir4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYgOQB5n5i1DUgSkdMPBcCEq/y/ZIrYo+RUHPuzig/RokMMb9DukElAbyByHtwoZshMuE1ABzMRTAkwGA1tNtlIBooiX+m/IBT+zM8i2XEEgjjWUWuiko5A49qNDQlqMzfgESRnRWMSy16kfoLA+OGua/oGHP9enSI9vtEI/TXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0ah69S/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5499614d3d2so5863390e87.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 20:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898628; x=1746503428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8YQz3EMOHiIGxLm1u/LQRPsitLmo7P294OrqAxT1bU=;
        b=g0ah69S/xk1LB/YH5lgAzhh7tsEWPJVhujve7Rsqnk4gCb3Nxv3snagTVDqVKz0XvV
         SQmpxryCVSUGp1Wf5Y6AZKXd1hbpEttg1fk2q1OhpxVDKAEKkJ9bUYZzAxi838n7c1ef
         iNLjvgHWe/DCcmViWpKf/HIBtLw9gaKwjkRyaauqKGKgj2Tl0AV6xdScrpX0S6/n0ueZ
         ZjcJOxvgbabDUHmOI/zPPuqPzGjG6cZX2M5ZBKdxp7tP/BgJTrVj6qK8Zm2hKbitckyI
         Y2Vu35vPbwZhIz+Tqg8TJ+vJvCD8rk9TS3jWVdPDrAKDDgluvs8BVgGtWGjmOFkCLTF3
         XKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898628; x=1746503428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8YQz3EMOHiIGxLm1u/LQRPsitLmo7P294OrqAxT1bU=;
        b=OMw4JNHil+W0NUk5UlGMDkRM+84zuMSU1+BqQg0UTLHtN0gXPsNa2yS83LwKNX1jWP
         w0OCEKaoa/pl9HgvDzEqRkZIXkx9PFQCzTgFxPNLnv8CU6h5N/BEPD2IR4fBNe6AXhy5
         kv7kAksMDKTdNTO0pM31T2L45KlIDpcxRszlfklAmy31NHrtRbpv+nwAULuKgatCqUTk
         RmTUmJjyphJU1h8wyQWdmvYdrKtw1v7bis0jszQXTdbB13hSrMtMFFB0pYjnypFjzw3h
         qse1bGO36uo4NtqARPwHynZd8uJaGpkHKEtI3p3ufS8QWCOtEC/WiPRMWWA38BuReeMu
         vXzA==
X-Forwarded-Encrypted: i=1; AJvYcCXEJFOOEG3E4EGDFP4d328Gu5K28GeNJZfsLh3yQIbjXaZFMO29d4CZJ6srC+nSArk2dqYwgphFvIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3mCosw8MLl/0+bR1zo5sXjwDXoBRAwawrag4nGM7YTrvOx1cc
	d5tmtmGibyY4dOG4swUV/Msec2HpnApf3/9wo/2JDoHtiZoiKXCDQTB+jQ==
X-Gm-Gg: ASbGncsGu+KXVZpBywIysXx5l5tZKpIssOuotoeRxWHXph6L0qhtQvMsNQm4E7tRfzN
	C47jYajqtFkwpDAYog8lQPxHGSnl1DuYdK7e2qbJUazVp8mmhzpakPAcRV7hfvXctZMp3Tz4CYU
	9juPIhGuyUgMh0xscjqWM67vazzCF8NPmWHgHQRc79PNv12IDqCXQ/pHjiDt1OMHs+PokP5FDXW
	ibgCgtLgC8aWFMyeau4fazdGcfmww7hQMm4fPRZnmfcqsE5e8gwx3mCx8YSBEpx/smd50zUgNhX
	/Nm+GGVstWwwNZWQEj66+VbVAasTrfMynbsxeDaeAiyavGay6pXNdWGbuCuX35Dba1AObgzn+O5
	lF/50pntzoXFC7RhfT39RiA==
X-Google-Smtp-Source: AGHT+IFMxNxNG0vOTTzGqNgwtundXfES5ovvJXQiTeE93Ue53/SMPNCLvOUsPpSgvQY1BUe5qQfmmA==
X-Received: by 2002:a05:6512:3407:b0:54d:69a3:6109 with SMTP id 2adb3069b0e04-54e9daeaae1mr538710e87.8.1745898627916;
        Mon, 28 Apr 2025 20:50:27 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cb26eccsm1773181e87.2.2025.04.28.20.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 20:50:26 -0700 (PDT)
Message-ID: <d76b01c2-a08e-419c-93bf-92395ea75251@gmail.com>
Date: Tue, 29 Apr 2025 06:50:24 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: max1363 : Warnings from iio_sanity_check_avail_scan_masks()
To: Fabio Estevam <festevam@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <CAOMZO5BXp38RMt5vQQWnZBQDzpN+SYB6NVU3c-Krk3po+2Zv7A@mail.gmail.com>
 <20250426160009.161b9f08@jic23-huawei>
 <de99d175-a571-43a0-b254-606ba03948aa@gmail.com>
 <CAOMZO5CtU8_4gp4gM_DYj-6PCTROT5N1jRqb9-6PMq9PxOy1bw@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAOMZO5CtU8_4gp4gM_DYj-6PCTROT5N1jRqb9-6PMq9PxOy1bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/04/2025 22:04, Fabio Estevam wrote:
> Hi Matti,
> 
> On Mon, Apr 28, 2025 at 2:38 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
> 
>> I believe it'd be more informative if we printed the actual bit masks -
>> but I am not sure if we know the size of the mask. If we keep printing
>> the indexes, then we might want to add brackets [] to indicate the value
>> is an index? How about:
>>
>> "available_scan_masks: mask[8] subset of mask[0]. Never used"
>>
>> instead of:
>> available_scan_mask 8 subset of 0. Never used
>>
>> Would that be more obvious?
> 
> I still find the "Never used" part a bit cryptic. What exactly is never used?

When user wants to enable some channels, the IIO core scans the 
available_scan_masks -array in order to find a supported configuration 
which meets the requirements. IIO core does this scanning in the order, 
and stops when first suitable mask is found from the available_scan_masks.

This means that if we have a mask which is a subset of a mask which is 
earlier in the array, this latter mask will never be used because the 
earlier one (the superset) will always be found first and picked by the 
IIO core.

Eg, if mask[0] consists of bits
0,3,5,7

and mask[1] consists of bits
0,5

- then if user wants to enable channels 0 or 5 (or 0 and 5) - the 
mask[0] will always be picked by the IIO core because it fulfills the 
needs. This means IIO will always enable channels 0,3,5 and 7 - and 
never use the smaller configuration of only channels 0 and 5.

Hence, the ordering of the masks matters, and this check (and print) was 
added.

I hope this clarifies.

Yours,
	-- Matti

