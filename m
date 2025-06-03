Return-Path: <linux-iio+bounces-20193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B32FACCAA2
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFC016C9E3
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819FC23C8A3;
	Tue,  3 Jun 2025 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rSAkDT1f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689523BF91
	for <linux-iio@vger.kernel.org>; Tue,  3 Jun 2025 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966059; cv=none; b=XR2ckIp2HGDTYk7B4KweF2OErU4r6C6Hys/ZqzVjbza//ph3X4CNI2Pm/4HPOrc8OjE4acZny36+09648wwU0nZbPPfVLdpMR32egeykTfT4uLnjTmpfMioRCAE6j5wJT3CJZfprKfVCZ8wY5K5cPrAms/uaQ3LgJ7xBoYpcvao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966059; c=relaxed/simple;
	bh=d8LbqEyst8cvUKr/LsyztWuaAYGUaquy+2asHx15vu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=issNCctt7WPd6FLX79IxzIf4Y23Zny4MznDKlGQn9qN+1sxc4QG2Qq2zMa7NkkofK38qdJCY9cjDdBxFjSV8RVWFJkDMs7XgVsbi5ygmNZrahW+AZtcY303jx3mUVl6nf9B82Wnxc/wV3Dg8b/IdYoCZnYFnecS+Ee4nbrTj20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rSAkDT1f; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4080548891fso874061b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Jun 2025 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748966056; x=1749570856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fx5Rr5jbdiStY9Aqz3LJKXnxg+ihqi3Ek0WW5lhs2ok=;
        b=rSAkDT1fPtjbakyC3VyAsNXUrz1Sg0VmtO8LmfbLqs1KbCuxmFza0kR/RwcN68bO6j
         6JS0IcE+in2zvFxj0CM2hZLCbNrwSFNat/e0CqlBn8cddZam6fG5S78vx0ktM47kzWs2
         +GBGPIQv1mgGMRK7tP9whUDgMk58gy3mhjrIBz4MfR3dQK+P9PXbf73n6T5jejk6QkiI
         xQAk+1GZQdgV3CdiY/3Ou5z1lZIAOVHIbtu0A5flTnM4anqJbWosR60Ikq3rpaoqMKEo
         wYsrDhbOpFlzNMRhvT+oi4AewqPW2Y7gY3WTaSbrzMJ7Ib4eO2a6RH2agMA2QES7oS7d
         zXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748966056; x=1749570856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fx5Rr5jbdiStY9Aqz3LJKXnxg+ihqi3Ek0WW5lhs2ok=;
        b=HZK3gNr1k1t5TAyrHxa7visLq77Cg23AOiVY7cliSe+HgtgOhRrmVF1xzUvkbglEei
         8npWjf7cBhbdCEC+6nXlmd+ExgPolVtjOGqTQJ32AQWgmuqgUN3IyBgG0Cu51KtaU94l
         CwQssD3R+apVPxxAsd56PdBWnjBFNnzx+996BtAjvyDHYkIUzLn4SKrinCoTkM/PCFeY
         Yx4nI6BYoKZPIxNWUtiBVI64YxIxyAmTIavewpn3fh1IvRA5DphtgSaet90httc8bR9v
         owMzt5NzdcqO6FmN1tS8H0MjL6GM6K1PCCyMvFc0XSTSSjKMVr+PSik0wJagSDoPOxSV
         bo7A==
X-Gm-Message-State: AOJu0YzJ2oklVnHlnLVpP3SDoT8rRT6RsQlHUdAsLZ/Mg1yNz2ZdbF+U
	FkpjxPdBsrKguCqmPn/ea6OVALJpoahnCu0gtaFLJnLTq9pOTEmVtWYWFArtXndxk2Y=
X-Gm-Gg: ASbGncsehLbWpwInRiDX0zQBd8FvsqDp0SKJvBa7HYjR9/stj4cZLSEFWO10EfjC+FV
	CreyyG142JL31JlLhEW50xbuQ8hYBqDRjnW9v2Yi/Fp+7rESXaEoLTtcfNTaQj4x4TSNUThMeYK
	VWCPgZstFSyEhuUvpUhIfsbDfF3wTzgBSVuHem2f3Q92b8CwiikUh6/NSQCmKW99UBU6PwCevlj
	OBxzsh0C8sYdKVKKBwUCuA+LdwlEBQaTqCR6X2HkJg4L4b0IE1yqy2FiBX1AlFH71LLbybpdKuV
	tgJckrVaTxwufG0BrQw+l2BXecBqCYNipOTIv5rwoLJvIR5jm35KfarINAVpRIX1ZFrHd1CZMlI
	vMyyy8/BfY6eLqzQ5/pX9cAsh6A==
X-Google-Smtp-Source: AGHT+IFh+M9lz1wYyJZlEaVy+QsNEEdyv6Adf/+TFZtl9p6GJcw+6tYXszpK6tavI0ANelqx6tZv4g==
X-Received: by 2002:a05:6808:1b8d:b0:403:3c95:34d6 with SMTP id 5614622812f47-4067949ec7amr10871846b6e.0.1748966056531;
        Tue, 03 Jun 2025 08:54:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:e835:af77:41c:3a1f? ([2600:8803:e7e4:1d00:e835:af77:41c:3a1f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40678bf36f3sm1866546b6e.7.2025.06.03.08.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 08:54:15 -0700 (PDT)
Message-ID: <2a94cbb1-a80c-4895-aecf-ddf310bedb53@baylibre.com>
Date: Tue, 3 Jun 2025 10:54:13 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/6] Documentation: ABI: IIO: add new convdelay
 documentation
To: Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250603-wip-bl-ad7606-calibration-v8-0-2371e7108f32@baylibre.com>
 <20250603-wip-bl-ad7606-calibration-v8-1-2371e7108f32@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250603-wip-bl-ad7606-calibration-v8-1-2371e7108f32@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 9:36 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add new IIO "convdelay" documentation.
> 
> The ad7606 implements a phase calibation feature, in nanoseconds.
> Being this a time delay, using the convdelay suffix.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index ef52c427a015cf47bb9847782e13afbee01e9f31..7e59cbd5acb85fd0909c1d56f9d76a84933d418a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -559,6 +559,30 @@ Description:
>  		- a small discrete set of values like "0 2 4 6 8"
>  		- a range specified as "[min step max]"
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_convdelay
> +KernelVersion:	6.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Delay of start of conversion from common reference point shared
> +		by all channels. Can be writable when used to compensate for
> +		delay variation introduced by external filters feeding a
> +		simultaneous sampling ADC.
> +
> +		E.g., for the ad7606 ADC series, this value is intended as a
> +		configurable time delay in seconds, to correct delay introduced
> +		by an optional external filtering circuit.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_convdelay_available
> +KernelVersion:	6.16

Forgot to change these to 6.17?

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Available values of convdelay. Maybe expressed as:
> +
> +		- a range specified as "[min step max]"
> +
> +		If shared across all channels, <type>_convdelay_available
> +		is used.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
> 


