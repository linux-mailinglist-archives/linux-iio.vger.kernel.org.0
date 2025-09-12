Return-Path: <linux-iio+bounces-24014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D23B550D5
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 16:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDAD63B4566
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC6C2FE04F;
	Fri, 12 Sep 2025 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AIuSuuhz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95D2E172D
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686782; cv=none; b=GW7lpluZZQPeOjiDsriqwgKGZ9TNxLVk1iEWpdfYG3t4XSuBVf5HZxOZj/i+Cf/Nz5UsZTYGDUGXnpKm1SHwYPLsRTwvRAr4dUNZmRq9qj10bmaDOYy3i0rKVQ/Hk2aU0c9Xhqn96pLcTnSovEpzdV5+ksCASq2/J+3rhWKT8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686782; c=relaxed/simple;
	bh=hP65JmfhwJmWH6ux4J6yoXvAjKeM+s8/GCFzs+JAKbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gocuqb7fYebQMrD+bfm5bRnI3rHzOlNg34kVedjQl4NcngAeOU1wvETKj0SpSFrHUwC0Yczph1FlVPXBxPY6o04LAkr1It74UWaub0jaqzPNz+SvW1pn7m6/eUC4hjJCzmAQ8hwG0vyjDmsdhJMiB3fvYGSbNUbajfyDyjAL4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AIuSuuhz; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-31d7119322dso681937fac.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757686779; x=1758291579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SI0FVmuRZzP3RoX0Ughgr/ocMtvo4boFzev/pIdHsz4=;
        b=AIuSuuhz4gSbxhvodZlMvqtv786P1Y20sWucyvOtC2DOBVr2i7VGz9iNsEWGMr1EY3
         EvFfaCUQ395npQ+2NXfQ4qAnLvKJjIX0YSbHN6UZai7jdSjov0wkCFr8uG+we2UEOppL
         8Wh4W6T3G7RGSLQxc0MqgjCgxybN7Rk7XTA+JCCT6Gy4I78ON75hkmFEg/U00qRGe3mD
         n0imt0xhzHjuQEXNIC4+eSHq8SM5L9B32RMoCekkpqngU/7g4B/D3GGA0BFmt0AcXDHk
         24uQ3MQV1HCfbm4asrAiqyoZR74W/Pu63LRABiZKP8lZ5K2ienVXAYLBr9lfGLpnMYGm
         cmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686779; x=1758291579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SI0FVmuRZzP3RoX0Ughgr/ocMtvo4boFzev/pIdHsz4=;
        b=RDSAGQuQlraRO6Iv1N+YUJ+g8hx1lHAekq9z+58CnR2yUIBjJfU3944HeSIRrdocnl
         SDhCr6EYD0Crz7T5JglrJvDOjGUQXoS+LJHyNpWvN2kGbJL+CMbU3o9eGv5z3rwpxyDU
         zRK34m/WFk46OggcSJcOhm6bHmmk1plUv+BmGEzAKaegl24I6Kfh9TLv7LH3NQxoxBAW
         jQ0l6HVVKCQTTbp3QgLQ5yCk9beRGqNUdt6YU+0+QTkEjNv4Q0Kro0u3dVEZYn2x81b4
         MMK7Ytx5knUVivQnxW+RKkci6SoxBJtDDf/70QXfuiIsDFJ0fbrdXk4UZbfcwRywGMuG
         EF1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUO2QYgl2X6wWFPJ+64Jy6hnkUlaePK4RNMuPZSUmRY1FtYh+cd5T6/APKcC6TmoF/9uZHe9ZQNGm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygSYNpy07WAqxISPjbBV+9gk5MMlggHKeYdTSU1ZoelmcpoxWl
	nvdERIXnpRWAzes/xbX/lUqLR3K/3uml0Cmr0PXhcu7AUlaVYx+46k9zldIvvjFydLk=
X-Gm-Gg: ASbGncv/0XZZC1UCgd5OWDup5M1rPdf8pWbDMPHfz6Sy31uD9nGQGaNYri6qXIdhA9o
	9jc77MmHlXimNrtpLjkugZ+o5NDFuhGocBVtLP9CzmH2azHyf1nWqxZGFy8PjR77Hund5gl9uFP
	XOemcZD7IhjdUn1Zhjc9w8+Y9rHDS/rN8lqw0s5qROtug4GTQsw9dm3IURXRO77w8v1hdpzqfbS
	bY8KNwRitYRlyAm5RvIAWLetOH2PnSJmT/15yHEhwPiOmQeZehMZrgeQW6hLsN71I2/I/cWadA9
	/6K8zqRHUpn2HKIXkpWRVfrmXBV99ZMEdvFq2YF+lXgpX5auiRmep33M0cWXmeq/6fqGpyAHh0v
	2nZioL6p7x4fSxCfTqnzpdH6UULs4Xv0l/sJgSFTiK+FrYsSXOViS+k4nkP4aSFP/xArkgs7wGn
	o=
X-Google-Smtp-Source: AGHT+IGVtrygXnW497Sb9d68zHBUC2goMyzzb0ofpsi1eyzIw+EncMLcIzM6izO+GNjJkhrNIKAM1g==
X-Received: by 2002:a05:6870:63ac:b0:31a:e9e8:3018 with SMTP id 586e51a60fabf-32e54983c42mr1662429fac.5.1757686779053;
        Fri, 12 Sep 2025 07:19:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1? ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986ca64sm1034583a34.14.2025.09.12.07.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 07:19:38 -0700 (PDT)
Message-ID: <d5e53a9c-418c-4c33-bbf4-b7d49d523cf2@baylibre.com>
Date: Fri, 12 Sep 2025 09:19:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] iio: adc: ad7124: use guard(mutex) to simplify
 return paths
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
 <20250911-iio-adc-ad7124-add-filter-support-v2-3-b09f492416c7@baylibre.com>
 <CAHp75VdVUOxkKhiheujAK0gjk_GXGqQ0g=LhNDjZr-Of1gH=sQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75VdVUOxkKhiheujAK0gjk_GXGqQ0g=LhNDjZr-Of1gH=sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/11/25 11:39 PM, Andy Shevchenko wrote:
> On Fri, Sep 12, 2025 at 12:42 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Use guard(mutex) in a couple of functions to allow direct returns. This
>> simplifies the code a bit and will make later changes easier.
> 
> From this and the patch it's unclear if cleanup.h was already there or
> not. If not, this patch misses it, if yes, the commit message should
> be different.
> 

cleanup.h is already there. I'm not sure what would need to be different
in the commit message though.

