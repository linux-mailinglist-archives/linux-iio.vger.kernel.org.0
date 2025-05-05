Return-Path: <linux-iio+bounces-19102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1B7AA94F6
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320E1177877
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A55125A2C4;
	Mon,  5 May 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ITE/oXWQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA92561DC
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453455; cv=none; b=LjZ9kagSQoUV2TbEFQNWvIywQuRqNv2V7HHjKwsRB95UmcNOPwpWupB6lnFz+l4H/nBPi9NfnK1s4dF1/KBPt/o+yH4YWlRhvK/8OL+cteVFungky4mLaD+UiPa9H2/rUVjOqpPZEQb6xF78Z35IqxfxYV9xkx3y0ciwRhGya2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453455; c=relaxed/simple;
	bh=7c3MlvjxM4l0czXUSwKHbOv6lkRvNqp8kskIe/50s3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkYsg10P8yJU8JiDJgBuIQQEAKjgSUxuACIxrDyTNLdyPS7nwN6pqvx9nwUTeEOEVYUOdpM0sVlZnrPxc2JJTFQe6t47iEca0ugkt6h3EW/L2JEkVt/3ax5DyWAwCxnKhsyArDCWiN/c002Zn+xV5EIhO301UwIQzQkKrtFm9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ITE/oXWQ; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2d4e91512b4so2642822fac.1
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 06:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746453451; x=1747058251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=deLqCQ0R/IhrB6rCh2mYQyRMGHfxP9fVsJMdPdrYT2I=;
        b=ITE/oXWQoCKcD04YnRmm0y/ozT5zLxpejlIdyT0VXeQOaDc7Fnu+WunO2CKDuH/t5M
         f4GsZbP6bGXAxX7ZCoSTpi9iXLeukyuEb0s4RjQsCMAa3p+PdiKZ0Ni9G1QTwdRd1xu6
         XaAkLTVdIZiYPZDrFAl18IJJzUvkJcIC3jgmRno1RUkDTszgJRKfjGrsZk2Eti+rkEFy
         DZPteZlhx2XcAV4pASL6NvUi49D7jRCvjOvZmK8xJC2vxLKIhxntDIsvh5RRd2kUWQCM
         B7exYcMbTb49bEbCUIkmUjKsLxDbjRWAE42fUs8pXmChu5TltEh0QUOweEz+0S5d5HdH
         zekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746453451; x=1747058251;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deLqCQ0R/IhrB6rCh2mYQyRMGHfxP9fVsJMdPdrYT2I=;
        b=kUW/38oUU/8QxxAWHfc0FQIT4OUYOcq+PEPamOFjVy8PX31hB4w68c6SeiabXgXJMK
         rmzIgEj1mdPhA6W+rAjWOs+GdAb9xJAU/FVnfYMWK6pMDOHL9gpQlisDWDs9woFFZi/g
         sXE01c3MynVHOoV1yg091YZQ/tJuty5t5zar6fcB48E2p/yYXGoNuEybL8AlVJWn/7pC
         jME3DffpR/OeJS5r2Y6mY5EmmIgqyxF/8jUrK5txZoFacuDTJsgbFB58gDv9H2IRJZDh
         3Hn4HECjMnhN5PAAo1vQLLYxkPJDrWn8Dy7QqJ/KWFMIj4vM7wxEVL12uegsKkpp+CIL
         cVgw==
X-Forwarded-Encrypted: i=1; AJvYcCXo7IDDUQDB/9xZgYICZf6ZW5HiYkxo5NRQzALXzm8RPnAljbUqC6rbgCRCOQyTDQiu2dzW5Gj1wVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOmAap/2D70tHsc1j5ukMFmgTG0e9SqA717cEnBS6GnHnoF9QG
	wVGJhW2++lBTwLtKPOHo5I6jAca5ckJykD/kvSImsKFCaqIU7KrPn7yv8oWhLII=
X-Gm-Gg: ASbGncs5tHY8y/JHDSEfR2LxRTUE7+bksCIj9EuLXY5bDH34rNGhm85H6OLDxFTDVHp
	L/XoABLp0mz03KIuPdbQ6JEyP4fCxaol3Rue7KQXLrZTlZRFOku8xVILPp7zgW5KPVPjjxo8y1S
	NQQ6Ql8thurZj1VSfFtEIF/tWBzUs/JMopo/owt8xSqflGq8XHkjGW/J4coYnOw8xz9Gbqk6YQB
	CuSeqWSzecGwzVBRpcogboeMCielcYttgsg7y91erdGFuv1d6JJ8U6VHmyeJQmCSYFXwmGOATO4
	no8NoM+5yqlQ60R4GwAXvJ6pBxW8Alb3EPnHnYmfxN8trZf++6EcVp6zhBKZsPGWDJcj/cKxq+K
	YEkRMcAsxCgg00Gg=
X-Google-Smtp-Source: AGHT+IHHUXBWiUip20M4q/7ydDt9/FNBxTFin43+HmguhLrufCWOOz5GxdItgIHeHNntNVMA6GjqFw==
X-Received: by 2002:a05:6870:e995:b0:2c1:c821:c836 with SMTP id 586e51a60fabf-2dae83e5b54mr3766890fac.22.1746453451065;
        Mon, 05 May 2025 06:57:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2151:6806:9b7:545d? ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2daa0e5099fsm1976029fac.1.2025.05.05.06.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 06:57:30 -0700 (PDT)
Message-ID: <efe160b5-5d91-4892-a0d6-ef73116fe071@baylibre.com>
Date: Mon, 5 May 2025 08:57:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7606: explicit timestamp alignment
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250428-iio-adc-ad7606-fix-buffer-alignment-v1-1-88dfc57e5df0@baylibre.com>
 <d7f00a8c9d4da6f780c1ec067be2702fa0e60ea1.camel@gmail.com>
 <20250504155544.60fe3464@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250504155544.60fe3464@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/4/25 9:55 AM, Jonathan Cameron wrote:
> On Tue, 29 Apr 2025 14:01:54 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
>> On Mon, 2025-04-28 at 21:17 -0500, David Lechner wrote:
>>> Use struct with aligned_s64 timestamp to make timestamp alignment
>>> explicit. Technically, what we have works because for all known
>>> architectures, IIO_DMA_MINALIGN is a multiple of __alignof__(s64).
>>> But this way, we don't have to make people read the comments to know
>>> why there are extra elements in each buffer.
>>>
>>> ---  
>>
>> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> Applied to the togreg branch of iio.git and pushed out as testing
> for all the normal reasons.
> 
Not sure how we all managed to this, but this is missing:

Signed-off-by: David Lechner <dlechner@baylibre.com>


