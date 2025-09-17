Return-Path: <linux-iio+bounces-24214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E5FB7F81D
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 15:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25AF174B5E
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD8C316180;
	Wed, 17 Sep 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MtnX+JJi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B239C1A76DE
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116316; cv=none; b=l91EmNONf2tHjGQjDcshVi0RdbF700HO7GfO4WFW+hp/XS5QDWHxw8GvpzNAAd9c3bDOA+diTb+C1nEfUxaSxzxaUM3bmc5GMFrD/tuApPUiMoZlC3REurGReaYqPqfE8FtfsXp9/mOO3RYi630aB6F1dy9MicBPb3bBQPuOG2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116316; c=relaxed/simple;
	bh=sJYHJM64s7yCzGaJIO+3tV93jJsBkJ8/PTbhnoAG2sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAMFvJKgSYYee55io1tcp0076L1Vh7o/YCB/wbzd2Pwl3dOFTTp5TEIxkOvz3pxj0IYDlN7xSeM5zxyQBykjpbquG9l3MlErUUv+qXItHBFDlbODkjTHt2vba0cCOo9SGE9deT5j7kLPqzX9OCOdbHT5BpUHlXoS+82UcPXGgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MtnX+JJi; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-74595f3852cso4696293a34.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758116314; x=1758721114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obA4cYWkPNV+su100KjarnANTV2mpGWwTyFWdt6Fifk=;
        b=MtnX+JJiRJijMvAEs9gY98VVkhENHsLZleCpBYKAo5PaFRsR2KtJHLgs2eLvnnkkz7
         wDlZ7rrtqRc1izBxdvtKJ0y1iJuNXoHUysjgTc95jd42+Qeg5MYDWIh7uX1DDtUgdaHf
         hDGRcisrH7REM+jqgisnDhb0U35p0GN/8yBKm6/e96or/ijjnksCOfn9Edsgx6TFSFoV
         4UO8769leghcNDSiLEGIXKbcux5zdcSwrp9+ANFGPBxaKPc8ZHiKq3KnhaCuAYEEKGUi
         UwAcEUgw40UprIohm7vbh9lsjdumP8QnoYGed6xbr+iBlTl5HzjhI8YPooB7k2tHCOUc
         hYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116314; x=1758721114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obA4cYWkPNV+su100KjarnANTV2mpGWwTyFWdt6Fifk=;
        b=LEuhcBMQW3VDJNXNBOJcnxIX+4kEa8LBwkoJR/7VP9x1l1//hfDG8VA28ElEH7bxUc
         Z9oljd1ZdiCA94EjFJnvShp+dx9unqOV5PvPFiCRA7SCDZhdiCv013SnCV4ZwJzpX5DZ
         xN5DmN7qZCHbHHfUVo9ehKzS69uRxu3oKCZo/jRGf5YpVnqfcRu1jIlthowNpX3i2exd
         zaOtrnGRVcNb3ANCYkbrE31fOVPluWd0cD0HpX4c4TZ5OsmtA1EKq8IreTMg7+/UtmeG
         jwai2i5nOp2pW7MGQT1Yket8qSEUEBi5VFbXj4ctYsVyS/rA23d5Mi1LoNfPO75B1u4W
         S3gw==
X-Forwarded-Encrypted: i=1; AJvYcCUmt/5RjQP8xeVYx/LuNPAG++qE49P9+Y4PkjPxRr6TxQqWb1W/phbNkMq3dg5QOUgZgjakB1/lRj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqS9tBjAavEoT+hjT3OKPvhZdgwGao+tlBNqKvjFZlr9af/wSE
	JUHH5Hmqu9nQxtgQCGf/YBj6cDTEd7UiB4uy9Ksx/1q5Tn4UPyrXyAO1vKX7cdI67aw=
X-Gm-Gg: ASbGncupauHOou+Epqh+pwqIw79E/jY0/CZcfvkpmNxsFpQv1nrimmiCr8Hg9W9sj24
	YvxdcKf+8c2gr1fE3NQW7kEWwokP0+WCjj58/THGUlJTiS6H2RnetBE5kKqsY6kZg92rrmjL73B
	R0AVqzwvT1f3HMBkI7Yl+/2FsqQz8S/oMGEFEZPRbgdqa2f2SmN3wIi+hB05NrVnhpldw6Fv+yc
	L4nt8TPQ+j49rH0af7mxn5HkBHNtSEb/qQEUuUhNkIrBE2fU3sFhS/8nU3z1LcBYbaF8d5wXAbN
	HKy6eMUO3CVs9hFC2dKUWIZtEBoHdRDRSERnchROkBx81351x5OWltAjMsTyL/1LIDqpOPmezoJ
	2Q5hZSOcqgYcrJz11RduPHOMrfsVfg7hYFbKKVJ17N8b+/AxYeD42Rauwg57scQ/uB50wI0HI
X-Google-Smtp-Source: AGHT+IEj9mD7877pzh3fZR9S0vPJyM0+cMMJjBWnSZ7FP3k/jIVrXWGyKsRrne5bWcBWpiwT7vMSRw==
X-Received: by 2002:a05:6830:d01:b0:757:9c0:e752 with SMTP id 46e09a7af769-76323df6ce5mr1187586a34.36.1758116313824;
        Wed, 17 Sep 2025 06:38:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:72c:cb37:521d:46e2? ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-75955bd9a38sm2640396a34.16.2025.09.17.06.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:38:31 -0700 (PDT)
Message-ID: <a86f859e-d70e-4444-a867-b54fc2ff01a8@baylibre.com>
Date: Wed, 17 Sep 2025 08:38:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add support for Microchip EMC1812
To: Marius.Cristea@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 jic23@kernel.org, nuno.sa@analog.com, conor+dt@kernel.org, andy@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
 <e9379a2f-be0e-4f8a-b464-df7382338107@baylibre.com>
 <5b46303db0c9efbd2c2adcba39b59082db82aa71.camel@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <5b46303db0c9efbd2c2adcba39b59082db82aa71.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 8:30 AM, Marius.Cristea@microchip.com wrote:
> Hi David,
> 
>>>
>>> Current version of driver does not support interrupts, events and
>>> data
>>> buffering.
>>>
>>> Differences related to previous patch:
>>
>> This is confusing. I think this version is v1, so there is
>> no previous patch. So why does this say "previous patch"?
>> Is this actually v2?
>>
> 
> No, this is the first patch. I put it there as a patch history and fill
> it up as the patch versioning progress.
> 
Got it. Next time, it would be better to not add the changelog
until v2. We are not used to seeing that in v1. :-)


