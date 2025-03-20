Return-Path: <linux-iio+bounces-17158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE7FA6AF55
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 21:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F30A7A9E5C
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 20:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B4622A4E4;
	Thu, 20 Mar 2025 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kpt3j7rE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5D22A4E1
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503387; cv=none; b=ucoOC7rgIr/T+D1F95vEuZFgWKLYXVFDnvX1gSQ55Am2Dmjb1fPPWOVI6eMj6FcA2nRIXn3QYH8Guwa0kh5+0vtrTfBcuGRvtwczDiDZMEgI0nef3aSVa1Z4oFtU5zuIw0Z4I6wbIIZ2n8sMe9N1OSkT1/9Li+LOULHoL3Nmrhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503387; c=relaxed/simple;
	bh=FpuegLmU5tbQxu4BeI6waAfSkfTSY0kMV2xhhNvEvm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTpCf9VVPkKciJVk70im7zoxjRdtec5tHYfhGUs/GbGtdq0CMJ8GkLfDaLkjVsG4mXI0NW/StE+mQoGQvc/645XwrR0rbvbc6NjObxeus4M2p7GCFdCm6HKXAwlgNvYbmP/pY/oHdQaBoe6Bk20hwF9tec+VcB7yPctTG1/YrZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kpt3j7rE; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3fbc00143d6so745564b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742503384; x=1743108184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JndwPcEu40LTfcktnqoRyV1fHHjivjql1RHGUu6ZCpk=;
        b=kpt3j7rETHSFaFIAO+I3sKZH9baiTJ5sqT8BYFy9kuZK+aH3yKsmd0DyDmcGgKTPYJ
         KkNijPHk+4eHa5efJIqGDD2eo0DEUix7af5hcRSHd4fkJ15BA/aosl/JPemddTIAe92u
         PKEQoIuZVt1ZOtuNb51CqAX0qehMaYl6h5QEOg5COFuI3Hf0nc1NZooTTMXwJjDFSTJN
         DDZJ0gRa4admAOtzuTPqJ/yqhm6dIpy+jRBZECQKXHw8vlteVEY3SE3ssi+36r6Q/gTD
         on3h96wteoecb+X5oKEYNYbHEfZ/g2w/DlPsvzFiNkXGPPry7X5vbeX27AOADvx1KQi2
         xtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742503384; x=1743108184;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JndwPcEu40LTfcktnqoRyV1fHHjivjql1RHGUu6ZCpk=;
        b=by8X+V48/3dni9XQu0s2HPi/0NEgApTOGdsnuIHC2yBE7Sx1KXTasAO+BeHhDKaCIS
         c/KUoWdCooIwc4xETTbbXmnTrGyEAWLv5q6c5HKoxaSAfNGaOFVNcWwIHFCAIvIYTI3i
         ogwYCPnYykJ3yT0P3QhnPXBkdV/CdcOoeuRZmq9lEFk3TxGr7a89I1AegluYpg5Byfqq
         lazUEKiHNulqBYQldE3M1bJ5NLuT8dY8UIvGgdWJFW09sR14y72LhbI0sVMpYzzBYE5T
         d8V3/ty+sT7/uXldKOLui50usx+Kf9RtGL0LnMcdiHDfSFa28TMND9O3Ybftuh77Ulkv
         lq8w==
X-Forwarded-Encrypted: i=1; AJvYcCV2AO+nDzDES/G3Hi9iVeLxeQfb/QaufD1uV2R/K4T6HMD5blWL52Qe/yH2qzy0uzMnHdi5kE8PdUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTlvFMfGOiQF5bMrpgZn5l1Yw3cRQ3TTv4Q3mxNE2WOWGG+R0X
	ELODaGLyiohJAB/THenfePgg63VSJrZ98Rd68p2dlfpxw5BlZGO0oZM/S15dWoE=
X-Gm-Gg: ASbGncv217cpOVCuxRkTWOkqMlgK7oHhEMKm7VN5EQmIP1lxlcsx1IWLFea71uddGo9
	v/Iup0SKI1jQtjRwleZGlvGYCu1QN8V8GL/RuE9LwzYGxkLQ5c1SY4IRuBS+TfJqff+ec0xlGYR
	Xzj6AS5FMuCgzUenSj6gMUBVlXLHqA6h2RkdKPkY1UuyNYvNwJCe4ir/dwDBlKI4BJWffU+FooF
	JxRj2EVbj/CoQF0HT3LHdFZNcDccYM9BF4cQeAkTVx0efFHjPMVhG4r62RbrCouO3VMvUa+CB4u
	rc1a5Zxy6gpeNpJoUuhC5EjjgnM2EuNJdiTqIgj3ATZARakHra/ar8nzacESpv8U1ybrss5auOk
	0pRG3Yg==
X-Google-Smtp-Source: AGHT+IGrPQlyXSXYBY7u+saxCR6isREiortDVdrxVss20iMydrEK8XXm7gPitUstCTe1G0rs6K8I/Q==
X-Received: by 2002:a05:6808:178d:b0:3fa:cf11:1493 with SMTP id 5614622812f47-3febf70afbfmr451429b6e.1.1742503383804;
        Thu, 20 Mar 2025 13:43:03 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf6dce65sm62432b6e.14.2025.03.20.13.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 13:43:02 -0700 (PDT)
Message-ID: <4fb5329f-be34-4d98-b34e-2da4e035f44c@baylibre.com>
Date: Thu, 20 Mar 2025 15:43:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] iio: adc: ad400: Set transfer bits_per_word to
 have data in CPU endianness
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
 <930560a0d0ca7af597d4ad901422bc9ba3fc6a79.1742394806.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <930560a0d0ca7af597d4ad901422bc9ba3fc6a79.1742394806.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:57 AM, Marcelo Schmitt wrote:
> When SPI `bits_per_word` is not set, SPI transfers default 8-bit word size
> and ADC data gets stored in big-endian format in memory. Because of that,
> the IIO driver requests ADC data to be rearranged from BE to CPU
> endianness. However, with `bits_per_word` set to the number of ADC
> precision bits, transfers use larger word sizes that get stored in
> 'in-memory wordsizes' and can be read in CPU endianness.
> 
> Use proper `bits_per_word` size for SPI transfers thus saving the driver
> from requesting endianness conversions. With that, shifting the buffer
> data is also no longer needed. This change has no impact on IIO device
> functionality.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

This is a breaking change. Some SPI controllers, like RPi can only do 8-bit
transfers, so this driver would stop working on those platforms. Also, if
anyone made software already that depended on the big-endian ordering without
checking the scan_type attribute, it would break that software.

I would leave this as-is (drop this patch) and just make it:

	.endianness = _offl ? IIO_CPU : IIO_BE,

in the next patch.

