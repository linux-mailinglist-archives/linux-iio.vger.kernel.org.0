Return-Path: <linux-iio+bounces-23788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C96B45D40
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88321899B94
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 15:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4151931D747;
	Fri,  5 Sep 2025 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X7bUHk8V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223831D730
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087894; cv=none; b=OaqJn174/9BgndoKkoz0LmYVcuXnHxcgY7SwUZ2aZUOJgxAYJykA/llnrx3FA729xpudbWsnjheRpxIxqxVQ/8uRt+hJHKwWjfnX57QbePcVQu1KHl9Bvb30bdxRcKn/rZV493hIGT0E3B3U1J5/KDcspc3p6OhOF4RWQdwIxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087894; c=relaxed/simple;
	bh=E8gTYe4rdieLWPQkDOppzga+QAy6TJXq5sXPX8D4iLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lePAzTYW3GFIMO8kIuRtF6fv6jxoekapy4rzj+VnLLTMOJ83tSNVqRYIThUYW+nSyLYH5V8iUwBm8yi/jI2lamb2u2TDAmsLqsdw0lql5i4C6Zpe1u1N6jzQ9yKJwnwx1hOJKr11TJXtk6UfYKv4hRUqczaX1xx9Sw9qsxXNpg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X7bUHk8V; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74a61973bedso366612a34.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757087891; x=1757692691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okqAphQFAtVDj3yK13V3wwuL5TGbfaSDJRAJ+VrpgdY=;
        b=X7bUHk8V99heBChAbjz3NUEMJNxPoE4Df0tWmNdysa6fNZ1cagNUuLGyWhNdgSRtsa
         zm9rDhW2/P7ocZ6N4o4Xo0rwf22FglZ/U7YXaNMEHi8VZ69CLHix5hL/5mpOqlDzMfPm
         2WeYRs96NYu2DFFRvOs4HGMW8h71mrsqA0qPP71EK+0SvETbN95Tea8XIC7Zzvec7bIN
         eSG/5gXqAPpGmGEiJs1+jttd4FVyO1wQU1e5jubXc+wOGkmUuEEu2pQuM5SVZw4ze0zn
         t/CppOiMW18J061ldUAsXA/OxIlRMqUoncdEhbYcHRNJr0Aq8FYhlM5mXlf0ACbAyF+/
         FDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087891; x=1757692691;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okqAphQFAtVDj3yK13V3wwuL5TGbfaSDJRAJ+VrpgdY=;
        b=StZY1d73wx2jHMnpiyXVlRy5IxJKDmjpmS3EEv8BHLYWjRO3bCEWA48OPMUWOfFnFP
         A/t3fbP5bTrEig8RaWiDOKyLFDEvFIXAiWQ5jZUHi9gCjQoQDR6S5hTHnW7ULNteIJHN
         k2+S8tBcKeqPUeVn3r182zs/w0IefMqliEFgMJ2XjvFDMiybHKHXeRzBuAmBhvKNZhfx
         xAgeymUIT00uk79pCJLZVPQXfbzAvuuG4++BtV55Pw4BRX9W+XatYsHE6kyzLk3l0CLC
         hWRUFajY4qr6fdMIJR93CeFQJP6QYYs039AfsiN3kagzw+BskAL0OaEHlsF7D96aWLao
         +Yhg==
X-Forwarded-Encrypted: i=1; AJvYcCXxIr9V/wmkko13krBuXYZYHPCDxd9QBBSqU4OXUi2jh2TyK9QxN3nz8oMh4eJwYUP9GzJqu4Hr53g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy40+8EZnwdkOGeamAzbCh6uipQWRj42eoW9jKRpHSvZGRulspk
	SK1m1IkGA902avuiMcOA72ztb6tzVVKnQEmUfxZ5pwq65z3oleaI9rWUHxj2Qr3H07E=
X-Gm-Gg: ASbGncuXzeDjXBXQ0IsnumWfJC7Hj/u1VEkR+kWvBeS2M/TeBKXNNKgS+GVskP+SLWE
	JCOX42YcJfVNo3+Qqt2TpRVvynDHDMUMHLanpF+c4YbY7fI5ocVHgoN4/Dw2zPeco656cC9C1ij
	jKl9f3U/gI4RTXBG71g2XsxN8PBC+nMgNYOoXhqvuFiQ9FAkjSUW+bqwW8AetqvzaOS8IX47MCR
	kcfRQ4VGSq8woVx5r7fNCoNCoY1oS+vALx2HAiKGjBNHdBtAarB7hhxp9VIBsmjCTCholz2aStK
	v+vD8lyz9UcnwKXwN5mEnNTIbyAFYR5pu0q27/PwGggGxLRCsrUWH/pAPmhoucNnk8Qhv4ie9jW
	1TEA3v6xl3mqQUxNCwhu99ReER67z448ncx7w0E3xVurKXw4zSxswIyagzVlUdEnmSvUVl67QXG
	SjS3opvm3seyTh6yTGzA==
X-Google-Smtp-Source: AGHT+IGtwO8oNsqdFGOx/5x+5eMUSW2ncUl1wsFw1yfcP7rnW5htRq13/ka0TAevKCuzZiGPNUvZcg==
X-Received: by 2002:a05:6830:6c15:b0:74a:2aa:45c7 with SMTP id 46e09a7af769-74a02aa46fcmr823591a34.35.1757087890892;
        Fri, 05 Sep 2025 08:58:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74a158941bdsm248646a34.2.2025.09.05.08.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:58:09 -0700 (PDT)
Message-ID: <e8e2a0b2-dcd2-43b9-9901-52cdfbd82b88@baylibre.com>
Date: Fri, 5 Sep 2025 10:58:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: iio: Remove location attribute
To: Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org
Cc: tzungbi@kernel.org, linux-iio@vger.kernel.org
References: <20250903190102.1647098-1-gwendal@chromium.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250903190102.1647098-1-gwendal@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/25 2:01 PM, Gwendal Grignou wrote:
> The cros-ec specific |location| attribute has been superseded by the
> generic |label| attribute.
> 
> Fixes: 7cbb6681d7e5 ("iio: common: cros_ec_sensors: Add label attribute")
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-cros-ec | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> index adf24c40126f0..9e39262437979 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> @@ -7,16 +7,6 @@ Description:
>                  corresponding calibration offsets can be read from `*_calibbias`
>                  entries.
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/location
> -Date:		July 2015
> -KernelVersion:	4.7
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		This attribute returns a string with the physical location where
> -                the motion sensor is placed. For example, in a laptop a motion
> -                sensor can be located on the base or on the lid. Current valid
> -		values are 'base' and 'lid'.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/id
>  Date:		September 2017
>  KernelVersion:	4.14

Not sure what the policy is on removing ABI, but moving this to
Documentation/ABI/obsolete/ to let people know that this attribute should
no longer be used in new code might be more sensible.

