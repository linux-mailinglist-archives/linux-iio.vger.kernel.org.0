Return-Path: <linux-iio+bounces-23726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B246B446C0
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 21:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD231BC8678
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 19:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D68277030;
	Thu,  4 Sep 2025 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aKv8YI0Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CBB272E71
	for <linux-iio@vger.kernel.org>; Thu,  4 Sep 2025 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015622; cv=none; b=HImWBGbz2Brf0jD2+h8yCiDqFkeNpzCohMcvPhWg6hKTUGil1CXzjPtvU5qaniOxNStep2eAEWHiA5IT5USpKEwZbMDXS21V50SziPBTqeMjl9BNesiKqzExUQBa83BUnasoNN6r7uCClOhIC5IJS3BmC28TJ/iuNjC4WFbHTBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015622; c=relaxed/simple;
	bh=fBjqFXU8KSE6oNfNfCuHGg0jP8OoSyKM469VWseXGxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RX6+aLyGUd7f/nGq5M4gub9wV692oPtsrLl9vNVrQoFLsnOXp8y/wy8eoT2DLOLBbQ2LNgz1jCbg6tEbtGNZaFWH6z3lk4LI9RvJ5By+HgaXg7VR8HmLK8x4e0fgi2DEagcPvGIjB3FtYwCJd7wjOwWXoNaLT2URXD3wyP5DbFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aKv8YI0Q; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-31d6e39817fso1814198fac.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Sep 2025 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757015619; x=1757620419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycqTB6thnqwhb8b/SV8IvlspkQDNTFgpikundNYbTBE=;
        b=aKv8YI0QWlRvtvHPcY37//scbXPhhR0mlDD9ecBgwcVubi3Z8UTXWGXJ1seO/DJwA7
         1TCRur06rHayBL5w/YJtS03hdY6xzuzmALsHRRQcn9bdepjYPiFVzSxPOrvtCJC8DEcb
         MvhA/Qr1wCBqnMQkJ6R2n2bIvg+IfmcMQ0y13hXgrV4lipy5Wg8J94ox2Um+7/bV7JIE
         wjfJi8QKxvfnf5GWmNoi1+9i+Y4kwhV0OeEzniwWDlkmtzOGOIoyTtkA8IcA7Jd6gfWL
         yVsrjcx1k9PKsgLyzsDFBmqkIH6sxAjL1nkemoC2efvb+FaJ8ckIrGyaaQLncRk6M6N2
         K4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757015619; x=1757620419;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycqTB6thnqwhb8b/SV8IvlspkQDNTFgpikundNYbTBE=;
        b=gLFdp+7fhf1ioEVDT6ZHMBTZWOzeOJQhcLZb0WTkwhqok6TUIeWpgm/WvONVuUzGW1
         afkyibb2y344M15oxQ80VjBvZFVoeX9ZQ74xVAaTZ/R5fnWPQiQxY5iMJ6+U1u+Dd+oU
         Pt39YcBVImYiSh0Lvx72tHphXTWvEMBGLxJjkwOUcrZvEw2YQ89KioZZIEV7Cl5tLUcZ
         KzANxwnDnlA6wQ5jxY6LLcDnZDD9JogGsryJTM5LrSdygfBdTXcBAwD5eDJ2cNC6nhdW
         cG+fXS5YovFKIkDKOkkfYSTAVqAx+GKVF4/p6RuYUzDFHz/3HjhUiJf+FpoEDHgCnNHg
         H9Dg==
X-Gm-Message-State: AOJu0YyQgA58clxzHJD0QgHq2QHqcNTHgdLev7Hkzi1QbzxTLWA+OPrf
	OsbBRNi+hMCjeaf1N7IYqY4UPZw916Mfk36BMRSKL7uHwzY0xxVrmdPSMqABWa+jC7q4qt4dtkD
	Dq4Ub
X-Gm-Gg: ASbGncuFNtrvUzTEwDgrCMYtdJBF2l8rVk/QPWXYLMMGl0DTlvC/fcGkXm7hJ8MN3dY
	phYJN4X1IlWbQysMPkOGFfgVtMdXGte/d7GyB+oJuWkBeZFJnkvM3ugyNziCp/atX+0pXs5MOtu
	5Blh9HHtmXM1WgCdtXh2KQEwARK5M3+7noKwMm2J0IgvLnS1Eh6R2cyIT07ZVtghGJ1QjAoq5zw
	OTsytAwtmfiwK98AukPumqg3qXCI4rO6hh9hDBL/eCE0GEc7lwmaz8No/zSJhVfu06/icw+5Ikh
	QvrbDSaHtAqheWV2Be2p+gqOjd+zNpp1SLBvPe0ZpDKPFzX5M2ROA+ixEt+sFC59cFeM9Ag9kai
	ndOfmU0+pi9Xih2Toknt+j9t0Ov8l6LEV2sKr+c/BggJ5Nkgvuj/XM3WW9MxLjsHQWR22mS10om
	Y=
X-Google-Smtp-Source: AGHT+IFwyubfgv5poWj9WA8rdnupYn5EFdHy40gVluAmFGy+k3jo+vFXnyG+qPRFeM1YEV/SGQn+GA==
X-Received: by 2002:a05:6870:d293:b0:315:a160:ec6c with SMTP id 586e51a60fabf-319630c80eamr11849895fac.14.1757015619486;
        Thu, 04 Sep 2025 12:53:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a178:aa1c:68f0:444a? ([2600:8803:e7e4:1d00:a178:aa1c:68f0:444a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74647c1c2f9sm966799a34.1.2025.09.04.12.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 12:53:39 -0700 (PDT)
Message-ID: <1ae7994c-4943-4a91-aea0-218c5bd331b2@baylibre.com>
Date: Thu, 4 Sep 2025 14:53:38 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad7124: fix sample rate for multi-channel
 use
To: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v2-1-bbf2f0d997ea@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250904-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v2-1-bbf2f0d997ea@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 11:19 AM, David Lechner wrote:
> Change how the FS[10:0] field of the FILTER register is calculated to
> get consistent sample rates when only one channel is enabled vs when
> multiple channels are enabled in a buffered read.
> 
> By default, the AD7124 allows larger sampling frequencies when only one
> channel is enabled. It assumes that you will discard the first sample or
> so to allow for settling time and then no additional settling time is
> needed between samples because there is no multiplexing due to only one
> channel being enabled. The conversion formula to convert between the
> sampling frequency and the FS[10:0] field is:
> 
>     fADC = fCLK / (FS[10:0] x 32)
> 
> which is what the driver has been using.
> 
> On the other hand, when multiple channels are enabled, there is
> additional settling time needed when switching between channels so the
> calculation to convert between becomes:
> 
>     fADC = fCLK / (FS[10:0] x 32 x (4 + AVG - 1))
> 
Additional testing on top of this patch while implementing filter types has
shown that this formula is actually not what we will need in the future.
Rather, we will need a whole series of undocumented formulas that depends
on the filter type.

I will send a v3 that drops all of the AVG stuff.


