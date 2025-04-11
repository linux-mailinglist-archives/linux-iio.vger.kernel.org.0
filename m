Return-Path: <linux-iio+bounces-17980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A568A86812
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 23:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471729A2E8A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B106629614A;
	Fri, 11 Apr 2025 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C5CGA81+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D020C02E
	for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406324; cv=none; b=GbfICgAS14+Fk9+IciXqVinEiwWruddckvXWLviYEcY3lpmVv5ZJi6DWBUfeZ+wzgvUF6SGzeosm9ww2YNJy6gZTBJ7kcqZe79eCTucApWnvI8jKXMfFy//4/qGL4Nw6IzXUbawtt72Yd662oXn5e/5H/2CQDMsdGMoucEjf1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406324; c=relaxed/simple;
	bh=rag+QXq4vWakUy9sDsqwNJhEerW8S3rA/5RcjaDWrNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYP1IptKwHUfHf1j0tpuMvlK5BcBRHOlCO7pfTVth2Hp/jwOJc8ccEGpKerD8Zu02+ypOMb9/w4Ri1NvKbNTmHe5OrszjLaU1navq9s1JRdftlIvW6pDbmsHC+r3uPMdJRaouW0aa3kyFdS0Ey/J4v/Ukl4U1YibJv5XOZjUF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C5CGA81+; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72bceb93f2fso1852205a34.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744406320; x=1745011120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sorNIy6LIPWEsa+dR7etTvE5w/Ir6yxO/CI3OrQDhzY=;
        b=C5CGA81+q7th0x0t1dHgFf6HR9f7cGqpZZGqgSPJyc3iuxoHHsHxemOLXPNIvBMRM6
         PvaHf9BVFZ/lzHwUtJzqfR23LfQZInmXbwXehW37JJOuRG8fykb9HAsuPAbwQHSQcUKK
         8Z1VvzTOuJIaT5d328xtRA9PzOqgp4665CZARAA3xLIORLDtT6JJwG2YGpOu5mKK4gFN
         UHzyq/p+1Pry9IiwvJvYP/RaKc9wyAVz+BRvHLGWMSoFLHrdJ0cVBzsVX9GskU+MWTDF
         lGRRZynNvGW/nncDWhFcDpEY/Vmp2hsEsL86re3WPEBiiw9s23jl5R+GkgQyioohaYDB
         doXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744406320; x=1745011120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sorNIy6LIPWEsa+dR7etTvE5w/Ir6yxO/CI3OrQDhzY=;
        b=mhSoQz1ewOxbc9FoH/HC4oW2bI6YMbQIF5lktIUU00LbbWTO0wsEFzYoDFMfSM8d7h
         tDzM+bpDkyxMjj/T9L+knwhZOimqPiv8QaE3i3WxM4XU7wejPwbLzuJ2717zfiX6vS59
         r0NjBl6WzSUXyk1XaAw4cbZ4MFneLFCGPc9rsBDvhVgyVNudTIJg3DQrtGTquhcu3EuR
         axZ0cShBcHHti0h5kXPpYEKG7Qcm+X2/JWWgVTbPtVNILPLDJ69VYSAplxnH9x08sRlS
         ZZv9ran7qPOpC1Lnj38q4mTkbNpznzHfLj+/loXfBSMvssA0lld8y0T/NzB08UzZnI+X
         mAlg==
X-Forwarded-Encrypted: i=1; AJvYcCVe24GY24ix67a9BAtButAGJ0MWifFm9SnHxVjnlbD+RW0N0kfGppwPxNs1H2y0KZug34zQkEdM6bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuqQhT+lXrcKpCjPkRlakq8caiKkyubqDBAFuumBHGX+QvaCyB
	FBFLufnzm3nghhk7yToFXnIdECQaLqhLDenZ3ycJ7605oquLPYYiFKvfMCm8zBs=
X-Gm-Gg: ASbGncvlVV6EN3VkBZSqKK/oCJUGjYU3lynqSHaK5Fk77xnkg9JZaCNY8EOJzw+/UgM
	x4c634pkBbNztCPf9YV/fTpyk55r1XDQFYrkZ55cV+I0LFQ58fq+beslGCTRMuWXsPui1zhK+8j
	Eq3KUBpCjN4DUnWbmdR+tmlw2e26RJyeXoUB7lUTJVAFW+BClrKxS7Vnm4mVkoNbsoxV1VQErCb
	+LMgGsnqny3Zn4wP3II4QHRjUJDb8hxyXWRvbz0PGHZy1afPyMLR6J8+rVs3jUrlp3Hqe/9HgNa
	mvi1h2w35WXEzTy+1B/wUaENds0GZuh0Z9TNpVZB6oe4y0Ij+/jHLhNDGKiLagvLG+wVkxVhLM9
	Jpw==
X-Google-Smtp-Source: AGHT+IEQ7gV6ZTG0Y504SCL7jpKeuLLtLbDwYjcmeg4BjGRNRDE++XVtQ96KcNIUD2IdTct72Q7wAQ==
X-Received: by 2002:a05:6830:6407:b0:72b:2513:ad54 with SMTP id 46e09a7af769-72e7c173715mr5591645a34.10.1744406320668;
        Fri, 11 Apr 2025 14:18:40 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73e67444sm1082695a34.63.2025.04.11.14.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 14:18:40 -0700 (PDT)
Message-ID: <4460df06-6da1-4b23-8789-82945e90a09c@baylibre.com>
Date: Fri, 11 Apr 2025 16:18:39 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] dt-bindings: iio: imu: Add inv_icm45600 documentation
To: remi.buisson@tdk.com, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
 <20250411-add_newport_driver-v1-7-15082160b019@tdk.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250411-add_newport_driver-v1-7-15082160b019@tdk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 8:28 AM, Remi Buisson via B4 Relay wrote:
> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Document the ICM-456xxx devices devicetree bindings.
> Describe custom sysfs API for controlling the power modes.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
> ---

IMHO, it is more logical to have the dt-bindings patch first in the series
before the code that uses it.

>  .../ABI/testing/sysfs-bus-iio-inv_icm45600         |  37 ++++++
>  .../bindings/iio/imu/invensense,icm45600.yaml      | 136 +++++++++++++++++++++
>  2 files changed, 173 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600 b/Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600
> new file mode 100644
> index 0000000000000000000000000000000000000000..8d2d9b68ad9e35fe0d6c157e984afc327eab92ec
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600


ABI documentation is separate from dt-bindings and needs to go in a
different patch.

Also, it looks like /sys/.../iio:deviceX/in_accelY_power_mode is
already a standard attribute in Documentation/ABI/testing/sysfs-bus-iio
so we could add to that instead of creating a new file.

And there is Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600
that has the same attribute essentially. So it would be good to
delete this file and consolidate everything in the main file.

> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..51455f0b5cb90abdd823f154e45891ad364296e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
> @@ -0,0 +1,136 @@

...

> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#

Since this can be connected to different buses, I don't think we want
to always ref this. It gets included implicitly for all child nodes on a
spi controller node anyway.


