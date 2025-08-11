Return-Path: <linux-iio+bounces-22593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E81FDB2147D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 20:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1051A21436
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820F52D47F1;
	Mon, 11 Aug 2025 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hJgB0Dma"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0842405E1
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937368; cv=none; b=q3cR9Cb4yI2vTt6h35EGEeA40fiKbc9nv0tdA8XMXCgj8eE2wX4Kc9HKoOCmCPgT+77y5pWZrZxJOSsAhOtRnKyBfhfaOAE4ppthjSvshDGEF+axVBONFC4jcuiG0goJr7vTVmsGhaJGHEHg8vDpHXK4+k7sXwhUz+CHJdnOv9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937368; c=relaxed/simple;
	bh=XNSMCIXjxXtqZRnUvufsmxXRqZNJHsj3L5JF+ouSJWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AA/AE9eJevFgYjtNKGMZLUdBrjVH5S7RlsyGd5W0y1JlnfCZe59A8nO4fSFORC23kfV39Fy+i7P14Kfi9l7tIPIMoPny16l2m+husjcVn4wvJTSzG2bDIf8hGq7GbmW5HYAQ03LXrmmjTXm7FzXS1O5kzXb2cNVrHcSbeIns1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hJgB0Dma; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30b776f0805so2797041fac.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754937366; x=1755542166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wscbWMXa5scHtPrYPKIx62T0BNW+TnnhjB8S16oe40=;
        b=hJgB0DmaDYe6doJ1hEy6sHY3tqP9QOg65aglhSoLD2eT8whjtuSnW/dVOBveqAekVs
         926L3f0SOLkAE+EgpQ3pzbAmy4sEHRQQxN6E6k9yB4vnbYM/cV5LQ1QtHgt/mMTM8RVL
         xjfWTx7GSD30S40mXWi/UXkl4NOrLLcjjHymqYm+YTH7A1zMxXXR/CQht71m1cMkfCXK
         GPfi84nNOLSDFQO6bixcJ0YuDR7jQ2CyIMItPl2dH0BLYZlSnUhFwqBufzAesinERBgP
         8fmLHws9+ozJv8dXZIf7eUhbLZ3Lm9x4rW79P1IXvcuD6s3W2f9tm3+MAjaX83vsKdyQ
         7UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754937366; x=1755542166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wscbWMXa5scHtPrYPKIx62T0BNW+TnnhjB8S16oe40=;
        b=a1oXC4ATK02tvbzfEMIiSW4rNNZnO5sEFGH4l1ot7XJJfoXJgHNVdv8F4Sev/u5nzt
         HCyOyPqokg0nQ2F71ZmpeKpWQUa/Me275kCA8mGvtOVEUX4zA5IS5W+vCBx4oXCRcq2a
         l0+pepWOEpbpi8w9rs2MyKZ3G3vZM6T1QBA7ht+OzV9hzIh8tTWitoI57u6akDuPNN0B
         ewkZVCR+XhfxxpYdx/F0Of5YeVAXyDYfT95/f7iWHqElC3VEe0Pz8xvMojAdu813vfFX
         uwdUWnphcfAH7m4n0oOYC8ODaNFKGCMr//DTDi5R747g2Dc4hTlYHB6T/LtoEBatzPPa
         rHkg==
X-Forwarded-Encrypted: i=1; AJvYcCXIegDHw7zjLzbgjBZr4ia/Wfo523sfeJOKzqsQMBOWcoq/UbmB8m+OmGTF+Vn2yjLniNIudHKp3Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vWpKGJShbHkN+37fsgHab+v7hOjHi82XQoYLLG2wDMz7UFde
	ElugagITuDJp+yP8NlJ+0jtxldcxEp2kYuCyrcgI6ihZ5STSYwUzlndQNnU81xQ2ygdGV08hHMp
	CBvoS
X-Gm-Gg: ASbGncsSVKPqycnVEinkFCwS8OHlOTMGt9U7it1sAl6lgk80Ftuz9CmMIlpntVIWZJs
	315iZgmFtOOcMjI2ahU3smHxQ+UcjroAv86Sv0B8Raz0SBwffh6I3ppALrHQQ4SINzPCc7TOFwi
	ZuRRVRUPsnIOAPJWe8vm8B06ZpQUJBehdZGhsraFr6skrz40zX1LTQ1iArN4BF54QDY56PaB0PS
	fXg3RqiLe0zVYHrNFVJRz1V6ML+KJ+i37SkTC2USRfjfgEaRKMjQjWdZaADsdPYW/bsYXWKzxeX
	hkHLVd3e2Cmst6m1lgBnm48MS+6PUOwZ3yKKsGHv+lOm2uYWvFbgpslVHh2F/E/AC/DUcY6FwT/
	SUi8q6Ok3nXSXD0Zs3FdTmlVQQdx0s3JyOdnkwsTX9ohbV2LPh0d3TUuRe7d8/kW3P4D9pm7a+E
	s=
X-Google-Smtp-Source: AGHT+IFmgYDkvyD74oRpPYxeAdpURjFp5SEQa8kGJxZR6Hjam00BBjwvdb7SYljNT+sXhxIKUmg08Q==
X-Received: by 2002:a05:6870:15d2:b0:308:fc2b:b7b with SMTP id 586e51a60fabf-30c211b631cmr6598236fac.44.1754937365830;
        Mon, 11 Aug 2025 11:36:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4a4f:fe55:51b4:b5ba? ([2600:8803:e7e4:1d00:4a4f:fe55:51b4:b5ba])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74303b9af1dsm3841123a34.38.2025.08.11.11.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 11:36:05 -0700 (PDT)
Message-ID: <fbe6c762-d71a-4654-bd58-01063a036ff5@baylibre.com>
Date: Mon, 11 Aug 2025 13:36:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: ad5791: drop unused member of struct
 ad5791_state
To: nuno.sa@analog.com, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
References: <20250811-ad5791-drop-unused-v1-1-3412fbf3ba36@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250811-ad5791-drop-unused-v1-1-3412fbf3ba36@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/25 11:13 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> The regulator pointers reg_vdd and reg_vss are no longer used. So drop
> them.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


