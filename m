Return-Path: <linux-iio+bounces-23904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D032FB4FE9F
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 16:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F051B24842
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8D233A038;
	Tue,  9 Sep 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ElpAUPfg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8388334718
	for <linux-iio@vger.kernel.org>; Tue,  9 Sep 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426601; cv=none; b=rfPjYVJq25vG16D9pbkACfn58NtJhUv0ULdy/AxMRLNLPNzs0uuL1nUYajM3fXx21cr8kjAjw4GOygF45AXEU04SX98zdpDxwbM9fyRGjuyTPc6xM4+RRi3MbwaryUPd1kBryYBQ2Nw0jnI68xcglfIp0jFd5MUun8ITljAQOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426601; c=relaxed/simple;
	bh=q45CxhQhD0f4Z1JjVjqiatYI0JZBd8Wv+yGFW41DUnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jic6BKP/v99EbHbbuU50nP8JYgZx2SkMGmV3bRpoyLGjEupubGKxR2NzwMQVRfoZGSIz2feyZPCLnuI2C4NppcYL/tvdM0kVrg949gik4qqcCpSp5WdvP+91Isb+jUoJDFDSfSbmlzpDERUlgKmZNdSm7w02q8h4DJBMQduTAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ElpAUPfg; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74526ca7d64so4717658a34.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Sep 2025 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757426598; x=1758031398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+Ty4Uw7gGeDTrt6VENR+8GGLY9kK+eZiE7VvFqZl0w=;
        b=ElpAUPfg8H0rQCQBhmOm4tawRQUVCZBM9kyOgQ6B/1AHs08XLLQBU3bb6RtYSou13S
         oedr1SzopfT3Q62Gvfajj3gBwJyiuPUaYxW+AHaxh3qyn1ASM+LATePnkkPGiNIIIOpg
         cFpXAg2amvj3nPI33GnJJIuxzTl0WeTJ6jBdgSB/t9UySgd4S1iTbjb0X0MjDjdPyEOS
         N2dCvLqi/iowLxBu0v4x+PiwD8mkZyZJmtWaPVHyORTV6j9PLL83j2aUWllXpIkjUnqQ
         gPMqlVdjn/OqQ9C6h+aRMVXLZQO9nJHP/SOUweouQEm0q/1gqL2ww6GpPD+UN/+DZZzt
         AdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426598; x=1758031398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+Ty4Uw7gGeDTrt6VENR+8GGLY9kK+eZiE7VvFqZl0w=;
        b=eWEXTglIs0D4gFyD4AU6oqaaZWdyd0cZnyKQRGJ1Yst960CA4TBgrgl9Xv5MKYE1Fv
         sdQned7JFgelxB2gtl2p5cybmxcp/SGLrcSz12pbrCJrBOUZL+o3Wbd96cYbftS0JBPn
         BtkODQsB88xA/WDx7tvXA5YVYmDEQHBxEAfdJPiiGDVYvYym+zg5RMLkycE9nhMxy70e
         oAoQAzL63z0A1wN63eYOIllyW5qstECHF9kIMRE3LehVqwHIijB9SfB7Im1CkotSb3Z4
         nHFHy92kp/vEFZ97F8+cskDD0mNun9IGlDiMBMUq2YVDZL8e74sgxQoQz5JHilowlVfz
         LGZA==
X-Gm-Message-State: AOJu0Yy45n3eVXzIHEx+0xGcvuez4vGGjU2H1ZP5p7+6jwpLi0uvXffv
	x1TKi5TFJXbe86rbNSw5rw2EMBgL3SxdHzbv7BFbOdROMsusJSLYIx4uh29knPxhuhw=
X-Gm-Gg: ASbGncuorft9PS553E6oIyfFhKobuXQZh8em9KdzB5INeULJ+tSmV8MtQId39Efu/CZ
	Ewqr7Mv8puGFPlZnMYsLyxN05OyZ9NrA/Vtw4obBzCwKjxHz+faFywMF82a95Ttv1wdDVx4ik5/
	/sG8hKpin0v37UOprDYn1wJTuiSOOvqwPYVNIk4XjpZKwF8BpFVhJ6PZ0NNUAAw1cuyskUixAWl
	bGqe72WXYMBC+cJbGCdaN877rAE0TVoLznlXjy3HQVmsUhQJTSW0N8NH7jdNyexxxr6GFNr6hMN
	gsh9U6/N2LoB/LK6UaYe6dfZ/SoZhf25s2KctSUpc9bjikCQoESbxlvcOjXlfmhiVfDHEfcXgVK
	WhKNyezoRsVSFw5u547pjCagwQpOmSRH2jXkqw6IYsx6w+Nx9f25vyiZ2DYsrOuZfFmukzZNwB9
	Cz6oQ6fTQ=
X-Google-Smtp-Source: AGHT+IGBODO1pzDIKXSlNVnZ1VymhDBL90KIRXoVOSdBF5kuyeZU2GyRm2nEjTxrDqEYWt0BWjhcgQ==
X-Received: by 2002:a05:6830:6ab4:b0:743:968b:3440 with SMTP id 46e09a7af769-74c75e4fe75mr5174495a34.20.1757426597538;
        Tue, 09 Sep 2025 07:03:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3bc0:a377:2a07:2a0? ([2600:8803:e7e4:1d00:3bc0:a377:2a07:2a0])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6218ac3645dsm1067679eaf.8.2025.09.09.07.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 07:03:16 -0700 (PDT)
Message-ID: <0cdc56d2-091c-4d60-851e-788beec5e3d6@baylibre.com>
Date: Tue, 9 Sep 2025 09:03:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] iio: imu: inv_icm42600: use guard() to release
 mutexes
To: Sean Nyekjaer <sean@geanix.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, rafael@kernel.org,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250909-icm42pmreg-v4-0-2bf763662c5c@geanix.com>
 <20250909-icm42pmreg-v4-5-2bf763662c5c@geanix.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250909-icm42pmreg-v4-5-2bf763662c5c@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 2:11 AM, Sean Nyekjaer wrote:
> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> for cleaner and safer mutex handling.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

(I wouldn't mind seeing the "obvious" reference counting comments
removed either).

