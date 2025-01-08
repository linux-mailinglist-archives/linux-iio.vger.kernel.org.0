Return-Path: <linux-iio+bounces-14038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09733A0669E
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 21:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DD23A29A7
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 20:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32CD20370C;
	Wed,  8 Jan 2025 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DxPoT0xD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE700202F79
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369466; cv=none; b=dj9X+jvCLtweP3eJz8f4BpSKtk4pO34mOMW46xKMiKWAcOty2ebLxPSEbetD2tOZcl2D64ikpFMl3j4fovUbszCnO3wLyYvMoaNj8Y2xnucYS5EY9dZrtp3tRiDoxT2/A770nizeDguao27PYE99soLcSWF/b8h/3PbZwBtv634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369466; c=relaxed/simple;
	bh=WKZ1BuUm1EmScmmUGKT0MeG4AzBX2mKkg+cwaryD/lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4jcbVAcgqBcZ5ffrepFo/V6gXdmLcakzcZnlIOMkcI7mHTNKlIIViLEiL4Ahy6Pop+LXRmZS9J8BD8m4EMjyOyR2EV6bILpZ4P1fOLZv7zFeUSe84nbyZP08YrfS0OlvCR8wQO+xGak6XHQ3+5koVWSRPX7aWffttozLL5z9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DxPoT0xD; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ebb2d8dac4so106801b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 12:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736369463; x=1736974263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWbuF2G1loosOw720BZIG+vRN/ryb0Ud5BRHooh3+9A=;
        b=DxPoT0xD6ZxtW8A+P2LawM0hTV8ddnoapZMllBdMd9Si+f8C7kMqax3HAt1AaZ7CQm
         5j17f+Ngkb/fQ/2MYm6YKT7WmI2K0JZkcZ3pkczfIbheCuxMJ6uclFbTH5KrTCsP8bb4
         FrQlOktwiOTUdFV/yHW7cmIFlQVxNWESsZeIRBaiOzmtDLMJE04wAJWO/W3Mr2/nWcEb
         t4Z1w/pboPHQnVFhUV9YrqipR64SrKXMTsN3Ji6aEBWFtQ2orovVFeBDJ/80Zke1FN+A
         c/AgiDT+Ny8xcm6O0BdRxEzQsohR+ltF09KfocgMP0IX6WXK7ubp1wM9eAaRkxjVl0DC
         5GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736369463; x=1736974263;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWbuF2G1loosOw720BZIG+vRN/ryb0Ud5BRHooh3+9A=;
        b=uj52XGWPUcwXRMjfDTBbAX8mtqhvLLdk6INFhByy7Kip6VRMXiRNovjO1R/usgwu1d
         wwYir536oKCfepRE/3MoPkNmuxmrQLk6zHS5jei1zTnfPSzHEZguIpYJECKNDQQNMUN0
         slcjJJqC2xGjfBXKyNG5TlgT344V42uJpCFzQinMeiwHEYPzHsHmUgYO1eRaWiJwFrpZ
         iW+jszsNN439NBB2SbkF7JZHpVmkzp8OQGEbloRNX2eltfIC0C+MipJpW9iy7rl7o7dL
         1zwl0Ees5alR6LGw5Rc0GzAmqfT1fFv3k1479VKGOaxaoAhIS6cR1txrw5rkwlhFliiM
         8THw==
X-Forwarded-Encrypted: i=1; AJvYcCUz6RjZpy1fTKW+cRWRQJJFCYjYqUgv8S6JqKkFLOThE5ZLjxmBhjUUWcXP/fQzbwrkiCzFEaljPH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhD/Cdt2e6qHVcCgZNQAeDXMSiUyInB64r4/o+euvlzST7jnSj
	eunJyq/NaGPJxRdszGvmS4b8kDxt/sUDcXlBep92jlWq8szKJtHUYJk6rhPuqs8=
X-Gm-Gg: ASbGncsQh66UGildxLbt4ooWwV5KWXpfO2jd6FsMfvCXxGngQizQSp1CoD8PBI3Xfm9
	JXFz4MqpibDkGakQ4ficS5VQHUjH5CNjKZtDq6o8Ym6AAvqOwrZiZOw51qLRwX3tF+3PU3srFer
	bGc183+ccTYSZFKOinoqy0x7ASjnB53GllUSvlIK/sh1SBSBp01T2hNPUbZe9/mWUyAIl+RN25Y
	qpgAxkIkiZbsBtBIosPV07DMBG2hdA/zYpDwWGmHPUp+t4gBz073hee4CKejyJOj4N+tt7JezQL
	dOOWnfXWBijsFYymqw==
X-Google-Smtp-Source: AGHT+IGJNB/BGaNMM1p2uS0XdOJ/LN3dqSlS4O49P+ZXdesrx1NuxNWEmE7q9YgDuwKHwyb3LHKR6Q==
X-Received: by 2002:a05:6808:e82:b0:3ea:3320:385b with SMTP id 5614622812f47-3ef2ec86dffmr2518390b6e.19.1736369462825;
        Wed, 08 Jan 2025 12:51:02 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece2693da6sm12048520b6e.37.2025.01.08.12.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 12:51:02 -0800 (PST)
Message-ID: <f4b036e5-ed01-423e-8211-b6b24931a27a@baylibre.com>
Date: Wed, 8 Jan 2025 14:51:00 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] iio: dac: ad3552r-hs: clear reset status flag
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
 <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-2-2dac02f04638@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-2-2dac02f04638@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 11:29 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Clear reset status flag, to keep error status register
> clean after reset (ad3552r manual, rev B table 38).
> 
> Reset error flag was left to 1, so debugging registers, the
> "Error Status Register" was dirty (0x01). It is important
> to clear this bit, so if there is any reset event over normal
> working mode, it is possible to detect it.

Do we need to do the same for ad3552r.c as well? Separate patch of course.

> 
> Fixes: 0b4d9fe58be8 ("iio: dac: ad3552r: add high-speed platform driver")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


