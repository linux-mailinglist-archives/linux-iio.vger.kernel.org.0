Return-Path: <linux-iio+bounces-26984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346CCB175C
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 01:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6134230AECA3
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 00:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1748182D2;
	Wed, 10 Dec 2025 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o2mVzEiK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E06FC5
	for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765324930; cv=none; b=ls+ZB/0Rh5jXBtzHfU5T0+F0NuZDZ3+udp/m45pEaW/wttwmy8JVPIuEMr9x52u4JoV62jSBFZGjKxjazX3L5Hx1bppu02D10uV0fvP2PfEjsE7br0aDtPL3LV8M9UjJ1dKL621CypgSGgJd0zJGImkQkmunSFG0UP2/16ZdyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765324930; c=relaxed/simple;
	bh=XBETjClpZtzYEHwW4MMmqqNrYdl+mNXjJ9Nw2T/r6ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHe5vvQDKi0S2ehAuSnviUfoLphi+bUHqlDrUd39dorwmEFG9qY0sx4BAJDa8psDDEdbl8fByPJ6e4RN9nsLXe7yv84DzTHRREN6uWgqc4Pd3gYY3yGbh4WGHMXw9M22TjA0+mHYryrjrPWQl3+J5KQe3yInvOqQAYkKZ23/3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o2mVzEiK; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4557f0e5e60so506746b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 09 Dec 2025 16:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765324927; x=1765929727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTbKv1vVkKrPnK5tPm0Gi9Pxe85hhjzLCItkx/m3ECs=;
        b=o2mVzEiKtLvParW8MIt+HyguZ8r4uGUCDt2dduQDFXE0LzWQFw0gjui02HG+4IhNkl
         409BV5nvOa059qM61XKZKJ3HYts1U5KAyamuSlkpSV9yNn4wvEQXYGy1/mum7Xhz91O/
         r9NOFOAbwP5vNLpNzyyJTdS/bzJBbL2hlTCK2jtXzSswH+ZgcZjuiSbDpKUFOAVwUqpg
         jC+ESX4b7NsnY3XGW+Y+O6d2S9jP+84wQs8eL6YXcLA0ohvAJZ8UfQuatIeurd78LrNf
         VQotZNh1RJHZD/xZY7Sq/iOzval7WeNL8woxmotj5rgRBzLzkfrkQ6D6JRNGqCUVMnqh
         NMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765324927; x=1765929727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTbKv1vVkKrPnK5tPm0Gi9Pxe85hhjzLCItkx/m3ECs=;
        b=oUQrMoVf72oFqnEmn+xwDh3zJRhNJIoybZqgdqqMS2onA6ImOTdXq+i2Ewa91S4ZYw
         TwOQAeuoMFMzndXyWneXwIIpvp2N14R/0tjTi1aL3/2s5ptm5EjccmiYJ1gcrJaJdAI0
         DaDJmE4QzXEO4iRXYosEDdQe0ov47Qji8yIqNqJL+LO1aZRrJy8KnTuUWK255c6t1PFV
         DxnrsH7VTFL66sMSo2VNcXRhx+993Tbdj1CE16q1Hx9ZufZd+C5iZxDeGbuljCniN+Qx
         7Ux4AIadoAsxrVTWjPh7wxAy156zMFA72wX2d+s3Nj3sv8XR1l9uGp4avN4GSqYC6S39
         nn0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYIBo7C3m0qaWSQAI3T/ixXm3ig5DYPeKPk7t4lbrIi1HKmlnmBlldA9M6E5Bk1Wg69thKdXwihAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4KSpV0CynEE0+EQLmZz/h/M/UcCxQU31EO2nIxf2rP8KNtkoA
	5i12fPawDlX4tsXQ/cpsUMOjSObn4CGl1y+t+VeQkO+rwH+uZUuswiDnO3u0T/rU0JM=
X-Gm-Gg: ASbGnctPjfGwh1yBNMEtMM7Hlrp5QzU93uJlRqV9k1ukeX0saQDWCtSghEvLymEqcn0
	jREc+FS2596+bhF9/dxQKoeUQdohkG410OWU9rZk/DLrrqyw75CXRuI43c1sF1d/izZMdN5VK09
	E8zZSw6uLQtl2zJFcuOYO/cPrX8vLgoXQQzQUyKf24oYFFjDBGLpQxHk77CjlbfxVwQbpJTwDRo
	mNXN0tyERU68HFD24cDBtYExV/EJs3RwgoJISgn5wCqw73FR/Rqb7Y2JyVuMUdJDjX/Kr5Ef6AH
	YxAaXLN1mgJvQh1xkIuW5ZYyIjA7/kN3Sn26/GFJ5rLw8uEYX0Cf9UD71E2M351ZFaK8oDkZvt+
	rqvd2l4m+rXEEtWP81+I43g8AvKEf1lKVDvsGAiql5tnABxoxwfqd5aEvZgXmrMUqA8SZvGFO/t
	qNc2me2AQ17VXDiQQn5ncM+BvooCv9FFVqwAcidS7kpI1joaeHuuWKynpgTNwt
X-Google-Smtp-Source: AGHT+IGelHO7cGCcA6PiEhLrrcOt3bTb3YgxI0Xmgu0mriW2zt4R+0Laragye1p41eo80Tns9fCO7g==
X-Received: by 2002:a05:6808:3989:b0:450:d773:ad1e with SMTP id 5614622812f47-45586960a3bmr393107b6e.66.1765324927565;
        Tue, 09 Dec 2025 16:02:07 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1635:b560:bfdd:f758? ([2600:8803:e7e4:500:1635:b560:bfdd:f758])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4537f6bc9d5sm8556424b6e.0.2025.12.09.16.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 16:02:05 -0800 (PST)
Message-ID: <2aca99a6-9541-4cd4-933e-815ceaabe365@baylibre.com>
Date: Tue, 9 Dec 2025 18:02:03 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] spi: axi-spi-engine: support
 SPI_MULTI_LANE_MODE_STRIPE
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-4-34e05791de83@baylibre.com>
 <aS79ex5Konr_EeMA@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aS79ex5Konr_EeMA@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 8:53 AM, Andy Shevchenko wrote:
> On Mon, Dec 01, 2025 at 08:20:42PM -0600, David Lechner wrote:
>> Add support for SPI_MULTI_LANE_MODE_STRIPE to the AXI SPI engine driver.
>>
>> The v2.0.0 version of the AXI SPI Engine IP core supports multiple
>> lanes. This can be used with SPI_MULTI_LANE_MODE_STRIPE to support
>> reading from simultaneous sampling ADCs that have a separate SDO line
>> for each analog channel. This allows reading all channels at the same
>> time to increase throughput.
> 
> ...
> 
>> +static u8 spi_engine_all_lane_flags(struct spi_device *spi)
>> +{
>> +	u8 flags = 0;
> 
>> +	int i;
> 
> Why signed?

Because it is conventional.

> 
>> +	for (i = 0; i < spi->num_data_lanes; i++)
>> +		flags |= BIT(spi->data_lanes[i]);
>> +
>> +	return flags;
>> +}
> 
> ...
> 
>>  static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
>> -	struct spi_transfer *xfer)
>> +				struct spi_transfer *xfer, u32 num_lanes)
> 
> Side note: this bool parameter makes code harder to follow. And now we have
> pointers and integers/booleans to be interleaved. Perhaps reconsider the order
> of the parameters (and ideally get rid of boolean by making two distinct
> functions?).

There would be significant code duplication if we split this
which would make it error prone.

Perhaps a bit unusual parameter ordering according to data type,
but they are grouped logically, so I think it is OK. `dry` affects
what is written to `p` and `num_lanes` supplements `xfer`.

> 
> ...
> 
>>  	version = readl(spi_engine->base + ADI_AXI_REG_VERSION);
>> -	if (ADI_AXI_PCORE_VER_MAJOR(version) != 1) {
>> +	if (ADI_AXI_PCORE_VER_MAJOR(version) > 2) {
> 
> But this includes v0 as well!

I think it is OK. There was never a version 0 released, nor
is one expected.

> 
>>  	}
> 


