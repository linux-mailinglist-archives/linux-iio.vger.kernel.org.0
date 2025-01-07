Return-Path: <linux-iio+bounces-14002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4630BA04DA5
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 00:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58D63A4C08
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 23:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C1F1F37DD;
	Tue,  7 Jan 2025 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yC4ZVrcc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564321E5729
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 23:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293092; cv=none; b=lnZNrj5uOlDHbqAIW54+C1d+0MD0GN2zTqxhW+cbqk0WkCit5XnGGWmxWmDv6QKzUOCvrLepIvebNWl+jYX9WtLDsGDTR17cD8hdBNmc2i2GngTNPdkDvFpx8SjJKLB98OZToRbLpFMRMwx0sdawm5alQm8mpuR1QiFzHKHCUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293092; c=relaxed/simple;
	bh=t+jQDpkgCKebrVTpcMnkw0BVHS+fn5Y1AyLfitucK8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRqplgAQNx1Z5lLg/YivEiK27VrE0d68y68zAQWvzJnh6Upsk0IejUW03WAHBfKmh2qyVshQ7cWAjEvh5UTnFcCTEMNaRVO7J+KBaOg4AxO+GGCjr4h1K86cwyrZOHK+yQpNDSCzaDX0Elq0lJ3aVdLdWfI9XBspORGg6izZ6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yC4ZVrcc; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71fbb0d035dso8894240a34.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 15:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736293088; x=1736897888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kN9z2gPqSLSokK5UvGcGTdpubahvaq0exd2QIM7Xpv4=;
        b=yC4ZVrccI9wAfkghWFSpZPVTE4QCIPNkDLW4Bs1g5KcvpK7adhgCg9xLXYYm5tUi1i
         BYJDR25zaZAXAUTd/aNYwMyR3lRbENvopZoGfV5N6cbKlO/oKDrlRV++FmBdBpiabrvg
         scIV7eQbJ0AduncYbuvK4tad+8z1AcwEyyFi5jkmUs+muGzX2/NnJuCSNoTygfR8HujP
         eLAxfvpZd7ELP8oEXMqDltSNMkDwBZIU5Ca0gCFJlty09eRQlItwTTb4fPcTFcoJOyZ3
         H644i/AsgcbejBeuKRFsKXgvKvHlAx00jIEQZCqjNvS6x6eQer/Ez0FN2MCFB57mwmjU
         XTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293088; x=1736897888;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kN9z2gPqSLSokK5UvGcGTdpubahvaq0exd2QIM7Xpv4=;
        b=grcYfyrbjSRUzvPRrLvMM8KcCGF7Bj54plRU6CyLn1wBrLWa9O53uFmKIxeYQBLjHs
         2y3l0oXDefH9e93yMfj/nWeEFs+R/Cmyev57nVEeLdSdcKrXzzC8ImAoHfm2N/vB3y/V
         GtoTh0XqOjdE8aYlDclsCNHbRfaKdayXVw4BfyCzE8DQBAJc5D168z958Uytb2Joy+di
         uAIZCegGLixKuX/mNUpf2Sv3nhcb1GTDwQOhhYs/9zYxQqip1WOdFYiPdSB1qPKghgKK
         go19l9qP3inOeSyIWsnElT9u0aC/RXpJCwz/DIOnyOX+XdJRdKmZbYUDdXAKkQAVmyX2
         4g9w==
X-Forwarded-Encrypted: i=1; AJvYcCU2GeKQiGF/Tor7GSD+BOU9SwMEGXXrP4tk/rNx43mrT/VU8iYuSy2QevTrBHuozojHWHzqcsKRkik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1uLPARHoQqhoZiqko7/6C6ZkPZEIh5rcqERdeeFxK7VC1UqNt
	dn+pkQKSSjJ6jytS3JUJNUu5/eUW4ZPV8xAQvt5Qt9jLbtXgB4Eyw3RLggoQTemeSVEL5EPbOJM
	C
X-Gm-Gg: ASbGncvsbEyPd3uLACHed1ZCIrO904tR33A1Cf3SlHuDhaSCGN75HXcRDjgeJPuy2Ah
	je3TWJlxhqeYfQA9QMFopVOjYER1mk397P5EXrYT+oBQQW5yjvxWheE9wpwVW/2tLVbcD7v4+0Y
	s/ZX67SmsuR6dFwVD4kdPvUY8OGI99FEWNJ8wsxbMXOcbhi5jAO7l/rrSPOTA93iaG+gjFdaTvO
	5QyMWnBdFRNE4Lc598k/sZ7Vds/v0nxEkR0LpcwFzib11SJCq2cb44LA2DltPoJe9gLVKBJnuhN
	bPCly9+xm6ZUIRkygw==
X-Google-Smtp-Source: AGHT+IG08bAb9+zT5FWQOG/nOvAGuQxNh3r8n9rpT23HDcPsiR0PXsHYnG7wM6biQqnr4WCfZ6InIA==
X-Received: by 2002:a05:6830:d10:b0:71d:eb02:baed with SMTP id 46e09a7af769-721e2e2dc7emr550408a34.8.1736293088514;
        Tue, 07 Jan 2025 15:38:08 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc97dc9bdsm10621511a34.35.2025.01.07.15.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:38:07 -0800 (PST)
Message-ID: <8601da92-1f08-40e3-9b39-f9b99dbc1507@baylibre.com>
Date: Tue, 7 Jan 2025 17:38:06 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/15] Documentation: ABI: add wideband filter type to
 sysfs-bus-iio
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <40707fa904ba7b1659554747ff7520139dd6f94e.1736201898.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <40707fa904ba7b1659554747ff7520139dd6f94e.1736201898.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:24 AM, Jonathan Santos wrote:
> The Wideband Low Ripple FIR filter is used for AD7768-1 Driver.
> Document wideband filter option into filter_type_avaialable

s/avaialable/available/

> attribute.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index f83bd6829285..c4c21a7bfba1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2291,6 +2291,8 @@ Description:
>  		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
>  		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
>  		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
> +		* "wideband" - FIR filter with wideband low ripple passband

I think "fir" would be a more specific filter type name than "wideband". (i.e.
there are wikipedia pages for sinc and FIR filters, but not one for "wideband"
filters)

> +		  and sharp transition band.
>  
>  What:		/sys/.../events/in_proximity_thresh_either_runningperiod
>  KernelVersion:	6.6


