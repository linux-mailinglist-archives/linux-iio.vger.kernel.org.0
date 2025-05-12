Return-Path: <linux-iio+bounces-19462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70445AB3A3C
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 16:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E4B17C58D
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945571EBA14;
	Mon, 12 May 2025 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bw8UddU/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D21EC01D
	for <linux-iio@vger.kernel.org>; Mon, 12 May 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059332; cv=none; b=o8ZJjQZ5pA1etb9xygJTGsJAMIhFoipixqSNyf6jBcCBjyHTXDaxUTQAo5Svf8KBAaxBHf+b++a9cnT7J43Zc0qO+T0GjgyXqW3XOpenRTkrTtpGHlr222hKDVPDsx/gda+ccwAqJTPSEwW0RGJncd7uXVbJMskputpatUP4ZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059332; c=relaxed/simple;
	bh=nNU/RFz2rUbNl7nLf7Z8+rvRbBvzu5h/opPgTl9yzxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IFBl9DGA5+S7coCIiD4YHfbRcW19Rrol+criDHKasn8refRWCEkOvKeHYk3slAclns0WYtjdfJqSN7r1p/Nbw9/XwtfhwgQV9zlZfj+tFo+fc16rwxd72ub1jQtqXMyOpLicZM0vxO/uRkhsMy5MeRnoAp8OfJXbGryUP4EdIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bw8UddU/; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7302a769534so2990145a34.1
        for <linux-iio@vger.kernel.org>; Mon, 12 May 2025 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747059329; x=1747664129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ZkQGRREx70HQmMXnJ2JUFahkKh8y7M/M223iiroUNg=;
        b=bw8UddU/wc/Hi3X8dltpVwdE0zslMaZ6BZxCPfOevQSpYb4Joy0N1owoi+5k/um9aI
         U4oWu6+cdt2i+gWJInEiRFZQHMiv9lL2QCKq/BwsHTuIMvVCDjDSVXmSGrXqWRQJphH3
         tBIScIESt4qK1aHJ6u3JgeXJ4xUcgBGgCZ7I22+TJ5/zxoVaVWJ95IMlZgfjnHLlJttP
         3SMtexBUt77PkAPGk7oQibFHcWetavzBbH3xhfl1Jl3h2XM66Jl+6RUjsjb6ew4NPgHP
         7af8EBC/c/OGFx/1MMIIKBGfI46jQ+71XfXw1Ljy+dPrQLeTTSzt7u01BAhT3yTVQ6Ff
         ipkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747059329; x=1747664129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZkQGRREx70HQmMXnJ2JUFahkKh8y7M/M223iiroUNg=;
        b=TQkRfvFcyG/B/XyQ6xOAwKSvKpy+CmB7f9dWAPODCnyFgUjobqN0FQht+U0/2PGrFo
         TnPT7UZGPTlxdPU+Qw/2T/cYMoCVXQjMLvbaEuTT98IJyxAmdu1nANFkIqtvBYykCMhq
         kJfsIn/dskZX/tRJAKrXv+FeiASmRd4Pwb+UMfc3EolFCI8owoDtWBd50Ca/ia4uDXI7
         YJf7Zp4rjKD3L1dI76VV7iojPyXcDnmkpt7xm955xkY1T+vWGPuJmnrzfHTQquJvF1cj
         e+++HuUxVPAvQOxM0Ivk0vPcZbU38JVs6V2yzfVzjuMZ7mt3rPWKfTq4OMdETTXKX9fp
         Tsvg==
X-Forwarded-Encrypted: i=1; AJvYcCUxiwz0I4rAXWPRIKSSUNd8XAESmzNU51E1w96lxbwJ68zbBslIt3oeEI8GxCaKSu0ADBFPstKy84I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1EaphT37jRQHpJJ3mrXDpnzoMw6qQduFTSgOaW0kKkHlV3+y
	qiQQ4s9t0hVvG12tdf+ppWXfhQf0TpIi7PmOVbq71fWgCxVQIFXvmQEXjokLtdcL/9KNRv7ea4/
	b
X-Gm-Gg: ASbGncuKfMMJerSLG4zca0+czRdDtolpODd4mgHy4IsyRxgYjXqRZpi/PVTS/ooxezI
	5feERGu1mHeBWQSKIH53UQkInKKWq+acoNekZvO6WxpZk8mRKs2sl2NgOE9JuiigGcIwgdJThNT
	YLZthYXY85lySfPnEE21VR5bcPNz+A6E8jIPYIMt9TKMRisFrvQ2PUjrnB+tcFJTwHbHv89Dje2
	wHaZA/KvcaPW/VrUs7tZnM5T7Pv+84FvGRGQHmzGyKArG8sMXbPTp4Pvcz2kaxcgPsIOZNzhi92
	WTTOEa/zAA+YoXm5wNt54wXRa7t3jO/sIJ4+Fq/PGrdh7KuwZ5TqsxSYIjXSYNkjHlU92nGQKwG
	BMVSKNfTKXaOk7Ad4cGbRK+JRnjlq
X-Google-Smtp-Source: AGHT+IHCEnMxUGxiLvsEuMQ4xMc51y5Br4FOqLhzjMrNBPxOpyphbh4RrGySc1szYHqvL/h+260LuA==
X-Received: by 2002:a05:6830:6611:b0:72b:a465:d93c with SMTP id 46e09a7af769-73226b09920mr8559233a34.20.1747059328997;
        Mon, 12 May 2025 07:15:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314? ([2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264d78fbsm1563212a34.32.2025.05.12.07.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 07:15:27 -0700 (PDT)
Message-ID: <5f373faf-2ca4-405d-8709-2ec91a05f86d@baylibre.com>
Date: Mon, 12 May 2025 09:15:25 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] Documetation: ABI: add sinc1 and sinc5+pf1
 filter
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
 <20250509105019.8887-11-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250509105019.8887-11-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 5:50 AM, Antoniu Miclaus wrote:
> Add sinc1 and sinc5+pf1 filter types used for ad4080 device.
> 
> Add these two options into the filter_type available attribute.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index b8838cb92d38..2dfb74b5a990 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2275,6 +2275,8 @@ Description:
>  		Reading returns a list with the possible filter modes. Options
>  		for the attribute:
>  

Should also add:

		* "none" - Filter is disabled/bypassed.

> +		* "sinc1" - The digital sinc1 filter. Fast 1st
> +		  conversion time. Poor noise performance.
>  		* "sinc3" - The digital sinc3 filter. Moderate 1st
>  		  conversion time. Good noise performance.
>  		* "sinc4" - Sinc 4. Excellent noise performance. Long
> @@ -2290,6 +2292,7 @@ Description:
>  		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
>  		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
>  		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
> +		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/filter_type
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_type


