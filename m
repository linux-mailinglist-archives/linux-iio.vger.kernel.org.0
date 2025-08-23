Return-Path: <linux-iio+bounces-23169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A27B32AD6
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 18:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4265E6D44
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69182EACEE;
	Sat, 23 Aug 2025 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SD2dEGj6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0562E92C0
	for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965591; cv=none; b=AKplLGpwhyWRvg4SeWRJfi+X0FRzRrqBhG+ZNlM+8l+/ptLlUMVaTkKPxG5N/Qwz9WuIaOeK+KfODh4QFn6UWo0z+6THV8JaDjdGtTokvsS38uoVHzRrSFT6GjA3hlBFRsABsBp3dSvOrgiUpZvlApScOSIJUxoD3oxdaNcPc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965591; c=relaxed/simple;
	bh=RTjb+iVn+TsdR5py4kgHTkw66OYfI4TTybYyhR6vIxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnakwIpYpdxyf+VvkALV+lUVGNLOktfXhKVrjWnWJCFZoAuBBWWpStT5Yxco8znHkzp4vUq3TCvR1N0Pa7rXNlJ2fZzJ7Hr9zmPJLvIdcIO0sLA5/LDDoujMLtngyBqMgXjAKIpQxxlN31T1EiV0cKeALIpXI4CuSwHAmyP/cOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SD2dEGj6; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74381df8cf1so1004210a34.0
        for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2025 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755965587; x=1756570387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qSJXIx/Az+pQiYKBZLEErDNdCpixl/qOO1S4KvmcYg=;
        b=SD2dEGj6I/bkm8wsam5Ocpak+T3zPbOXZWavljpQm/Uj+ppPY/wHMzgdrh8hhnTmzr
         7m7iODT5FJnXof4ytniyd13reS2YCMKTSVfLVTsqz/6SKCCjLlIds2uD/bMX+RTT8D1O
         /CMtH4j7cLwCqVpYdmDDpfNkS17vTfJp4jl3HTXy+kLLNXdXDSyK3o92OVOCPtWYpR6b
         UkP+fqLqlup9hU/X4CW8Ftp2lG9VFh9C/PRKTZMzNpGKBxGEHVFoWLEXhuIj2QrCGKdm
         7+b9IVDSErk/naWKL3AX3NdcnVNFVlZgHwpoTv3mN9h18107HCqAIJ/dnhO2nZl0oAsS
         Vp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755965587; x=1756570387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qSJXIx/Az+pQiYKBZLEErDNdCpixl/qOO1S4KvmcYg=;
        b=LjDZbPNkB1xnFLSPmmHcjfOJeXhI/OA3cdt6+ptMgbBJga08ODVm9IYJR5ostubt7w
         hedOtr7pI8pz4OoX0MwYApJ/6SwEgQCK+CJ/Q8MB9bqC2GY056kpR/tkDZoIKQG5MoLp
         puoNEIa/GBXDM4LIDM8hYHBIsZmSr0AZE5yUUrJCFfn8kMxtQseWsqV282hNZRR3LoxB
         m+EV8ZwcDne1vvHEqX8uJCuOJNC5SkdaFQoL7+KxyD0Zs4+8elL5oiumbWUsLIOdnpI6
         N7uHRyNVE0Dz17R2UndZB6Cy2YzBrof/o6gckbY2+RsiSqE7OmYLtHV2TnEuR6tjU8iq
         f70A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6mdK2Vrb7gHc+lEEtfP4dHNBHswD8AbQi/L0U94e2V7gjwQ4ihe+0pes1cBH7sz2Q5B9vtx7FrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbTNRw3pfPOqsjMteHro44IqvtfZHeK1T/G+rruK/w/bR16umo
	Xt8I5wAYu7HAuK1B59HaqYstwa6NOfPoMHTI70Zh9nb2Nf/X5tPf2O9l5I5LFTM1rWnR9AZhG/4
	d9/Kg
X-Gm-Gg: ASbGncuyfdRQVuYGoG8ai8JCG1mEZhUgsUcchXzAQVvHPxOJW6qt0iSjEQZ8fiJbxb6
	0cGJENMkMqH1poI3QJviUE5dPY8PHNMZRI4D3Mz9tUyJw2jQ64MsB3uvWRXZQP4p2Bo+t1iNvqP
	lGGcfRbiB7y/negkPa/OvvWmg+fsLPBaV6PH66MLw4ohq6Y0FrFahTSoVY0ZafJju1Rzk2voSBp
	+5hhMrqfj+95KYsDdQYLIxSAVL0Kpa8F/1YkqtnEgfBqPbFjvawGguNpDwHkbiELNN15eDoBUXD
	S+i8z7/lbJZ12nj5KAdYwwaGHvt7urGxC9NegPN6BfppVlzHKVEegLdGQGLEcc/u3KWRrRR2/zo
	oBLFv4QgSh95vKI7eYpuLKy0fzK12ftPkzy/gkiUylThhrvYqHx1ba0snuqJpGEk0PPQDuCGc
X-Google-Smtp-Source: AGHT+IHi+cV4E+X1M0r2JR6jBROtlJPHA685XBWxXWqnrw1xyZGt7gGfo8sipwJMU4bNKZjw4ng8ZA==
X-Received: by 2002:a05:6830:f94:b0:744:f0db:a1a1 with SMTP id 46e09a7af769-74500a8b38fmr3364972a34.29.1755965587401;
        Sat, 23 Aug 2025 09:13:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4d25:af10:67ec:53d? ([2600:8803:e7e4:1d00:4d25:af10:67ec:53d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e26887csm663095a34.3.2025.08.23.09.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 09:13:07 -0700 (PDT)
Message-ID: <e61c2e01-cd8d-4193-afcf-5ddaef34300e@baylibre.com>
Date: Sat, 23 Aug 2025 11:13:06 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: Update xilinx-ams driver maintainers
To: Salih Erim <salih.erim@amd.com>, conall.ogriofa@amd.com, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, michal.simek@amd.com,
 krzk@kernel.org, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250820100519.2272509-1-salih.erim@amd.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250820100519.2272509-1-salih.erim@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/25 5:05 AM, Salih Erim wrote:
> Anand left AMD/Xilinx some time ago. Salih and Connall are new
> maintainers of xilinx-ams driver.
> 
> Signed-off-by: Salih Erim <salih.erim@amd.com>

Looks like you forgot to pick up all of the trailers from v1.

Also, there should be a changelog of what changed from v1 to
v2. Just rewording the commit message, I assume.



