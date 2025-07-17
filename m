Return-Path: <linux-iio+bounces-21758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D90EB09700
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 00:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3844E269F
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 22:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C3923ABB7;
	Thu, 17 Jul 2025 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lPRmMcDm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C738B226541
	for <linux-iio@vger.kernel.org>; Thu, 17 Jul 2025 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792430; cv=none; b=iQib2uUcXQUxNjkqb84094LhvACI1/68l5pomsmPg9w/OMj8vHiFVpugU2LjSpIwU3d8Ss7a8DTgDTz/EoarriOx+R23SR86liJ5k6xHoYky19bwAv6HlnnTtmnLzwmLEpYzgz4T8bKZ8jTJR6wDmE4QPo5a7pNBNYNJ9g2X7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792430; c=relaxed/simple;
	bh=scrt+gOK/kbGk6Sv6A2noeo+XoEO2tdSaff8iaiSZio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lob0ib9SoWgYdLJ+ccMv7ZohbmZzDE53aZ6Go8UD9edZhoW/O9SI9eEYUQkNrNd7++IgYhUQNcG1FuHOEoZTe5/yVJCM9Xl1WjCgQwvOJbd7JJgdj1a/rvRhhCcX7dDnKyfTjbAjaGfwBL19v/0cS00hqWUCTflNzOvCk7avEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lPRmMcDm; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-41b4ebb15e2so879752b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 17 Jul 2025 15:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752792427; x=1753397227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+7a8sDmsJOF6CnYwk1liq/YAJocYNKqXfcnLeyvtqak=;
        b=lPRmMcDmsuyvOBfPBsy4zSrUnJQmBqr5Zu44FFZ2V3bHi0Zl74zVJDjhUzC2Xyh1qh
         KRpElvCmgUpK3+fP32GdixwdM89rN4v32JPW01bxd5gJc76PIavpYqqhX3DEMBQwAZ+L
         mCguDaEeidcw3ZA00FGXCTn87ERqtM28LFfLLBNBBU7tmYoxNJGfzfY0e38ASW7julYG
         HUbaTCg8T2rZ/hGJQMqbMxvTJlmwMpLb9XcomqgdprLoE6DdQRAksiNfnT61DxGSG/wU
         hcmWlu16BNmmhpcBgcu5a4O4rL4Rf+7yz+f16KWKWYCLJYb02wShJbyjNWsAa/2lnMEF
         Wngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752792427; x=1753397227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7a8sDmsJOF6CnYwk1liq/YAJocYNKqXfcnLeyvtqak=;
        b=OCKwz61FfGEEvqeLJfPhlwUWRZWLJPAQzuJVEI24p4227WQQIlTZaUZU786qMbxhJk
         X/IoKSmfbcrvTSucamT7TjM/L3gVE7MQEEp9INUP6I0OKtk7K9sunbxgqS087WWdbUpO
         53H+6NED0iBS3VyrXpEB4SfLRFK4JjAJa0GAe2RDIlnyR6As87+PfKMhtETHAOypTsML
         xQ/W2dnhVD9ojX9WgLo+agt1smWGBMRQPZ1XKfS46pYGlztI/JwGEjSMihf3feHH+nRS
         I6z+ZrwOMs9Iskt02y0xSBylgRGm7jn+6bSHZJYtJRERz//0CKWqXBEg1MlgxmvwKj12
         xc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwMniryyhhFV8MJcxQZ1NJXR9JIHmYEW22zGw0Uxs6FQ2H0bdKRZ+JUCR+yj1Qm3jPqmqdYqlDjvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxViS+I7JVI0jqZpeh5VkxPpTKneL/MfYuvrLOE22+uwv+z3p56
	oP/4+VvyT/wUxGXZiCTy7KpEORbHS6jKU6wl3o4s8f5iMW51FXxPZGaEv2dc+0OPmUk=
X-Gm-Gg: ASbGncuVDi9RL+HIzSCc6Wqx/11VxxV2ir30IuOJxFiyZ042PYRIrMnT7ZgNKJ/zPVs
	U+jS0I9l4i52OdvjFFYjZBz67CQ5X9/s7emIxcfpQPd1KnC4DPfab3Prw/H3FzmVmbqRI15+8tj
	nJDcQTA5uApO1aTtJDuWn5qBaqFqbycTgbu6lgPIRHjAD99kZmMdiz1UsGdKFUPCJPlcbirDk2R
	C4ukfdzQjxNKtWhTqWQoItQ5dk3BuueVLqDeAmHjfWEvkvdCwpSPo6fl6IfeO47ck7s+zWbGAWa
	YJ0Z44WKfNlUUozzjQYUq9V8EdMyPljon2b8E8Rvfl+bZ7JX7xc3cK9z7PALKkIsXi1nuGUPMau
	2WLKIDFXL+ubQ1I7iCtFnxEpRUZBlL2n6aBOMfY4z8/K5No5n05bnCvJhryrx/GxvvJOtkgea
X-Google-Smtp-Source: AGHT+IHa/+JsaAXuw6L0+Fke+E5C6yqkH/eYphW34HhHpWtknSJEsFWO4B5ebVdCb0FjvbmX0FgLtw==
X-Received: by 2002:a05:6808:2007:b0:406:701b:254c with SMTP id 5614622812f47-41e4778e803mr3683437b6e.39.1752792426543;
        Thu, 17 Jul 2025 15:47:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:b499:5ccf:3f5:ecec? ([2600:8803:e7e4:1d00:b499:5ccf:3f5:ecec])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd10c0ea6sm14231b6e.1.2025.07.17.15.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 15:47:05 -0700 (PDT)
Message-ID: <240f464a-5f99-4bef-a811-3bbc083e7f20@baylibre.com>
Date: Thu, 17 Jul 2025 17:47:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: trivial-devices: Add Garmin lidar-lite-v3
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 ~lkcamp/patches@lists.sr.ht
References: <8f4b72bb-3c5f-4137-a4f9-5ce94631d3c1@baylibre.com>
 <20250717223153.159878-1-rodrigo.gobbi.7@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250717223153.159878-1-rodrigo.gobbi.7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 5:24 PM, Rodrigo Gobbi wrote:
>> As a general rule of thumb, using the driver as justification for
>> dt-bindings is never a good reason. The bindings describe the hardware,
>> not the driver.
> 
> Looks like I`ve failed to double-check the datasheet here, sorry for that,
> I`ll try to remember that in future occasions.
> 
>> Assuming I found the correct datasheet [1], I see a power enable pin
>> and a mode control pin, so I would say that this isn't a trivial device.
>> Therefore this will need it's own new file. We could at least add
>> power-gpios and power-supply properties. How to handle the mode pin
>> isn't so clear to me though, so might omit that for now.
> 
> Agree, actually, I was wondering here if the lidar-lite-v2 ref that I`ve found
> when adding the grmn,lidar-lite-v3 is actually a trivial. 
> It was originally added as trivial over txt file at [1] and then converted to yaml but
> it looks like it is also not a trivial considering some refs at [2] and [3] (not official docs).
> At those refs, I can see the same enable/mode pins.
> 
> Should we also move that out of trivial in a dedicated binding or should we keep as is
> considering those docs are not official/device is very old?
> Tks and regards!
> 
> [1] https://github.com/torvalds/linux/commit/12280bd3d5d7e1ba1dd60ba0bd4412f4056fc028
> [2] https://www.electrokit.com/upload/product/41013/41013964/lidarlite2DS.pdf
> [3] https://www.14core.com/wp-content/uploads/2017/03/LIDAR-Lite-v2-Datasheet.pdf
> 

I only looked at [3], but it looks reliable enough. It also looks (at a
quick glance) pin-compatible with v3, so I would make v3 have a fallback
compatible string to v2. And yeah, put both in the same file since they
are pretty much the same hardware.


