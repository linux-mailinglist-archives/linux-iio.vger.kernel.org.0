Return-Path: <linux-iio+bounces-8718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D47295D4D9
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B0F1C2199E
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699319049A;
	Fri, 23 Aug 2024 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DkgLm68Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D718BBB6
	for <linux-iio@vger.kernel.org>; Fri, 23 Aug 2024 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436244; cv=none; b=IsCQ0rGFr2C1ZWlsCrrlKGX/M69eVoyMaRThncUG1/vRdGejCDU1uzdXbGo8ccqPrIu0BB6Q54r1CZjYe31Nww0yvoCJYY3aeGeoRJzBU11HXVQ+gPxmj+mcYm/qIFpH82VcCgrO73KhZzIYZgTi3FTAe3p6cty4JE0n0BYAknQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436244; c=relaxed/simple;
	bh=WUyzJ9RLzKLS23Zwiy2U3eJ/4NjpZ8Dgh8hCXrMko0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irXjm//6BlJt0aB1g64xkAuqOhSdVDSdwCO5AdR9ym6sv3SU0kbDgzBf+b6iZ4lUtV30NGKDt/8h26VMh9PfnI8/6R3X2bTlIZB1ihHucc/sn7yMhzBE28ti26/fONxQ6hCodSB8rtLWfQsPx4s2qIuVXw223eOtzD2Mryms3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DkgLm68Q; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-709346604a7so1853706a34.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Aug 2024 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724436242; x=1725041042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCQS3DXdl0f8z4sgR9LVNvCbxixtPmDAEn66rBmMtuc=;
        b=DkgLm68QegSPnmk5f3rFoUZZd4Eiqb+s4BBqHW+7927ZKb+6RlfWUZff6oaXh1YvqA
         Gy3duJrSIana67r7k0kI0F1Wf0GEqEc5e8dANth+kP8g9je/UP7VZ6AfFeHuQk7WoVPr
         6yh8GvzFwFOJj9DfbDX0/9OPC4Zrrlg/ft+yThE3bsmAPLFwUO1Mg30PAPvufDr6VVw8
         VtM5QJiAVsd1wheVgpXtlqUgotAGUsT54VAmQHZMraMuEbdTOAgaqXoZXwAU97D+ZYwl
         HtdlfmrfAk7PIXgR0WGB9Ylz9OkQ4Y91xuvYiVsF5wo3kZ7Bz/jBbgl98iu3CBu5Ri7i
         47rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724436242; x=1725041042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCQS3DXdl0f8z4sgR9LVNvCbxixtPmDAEn66rBmMtuc=;
        b=BtC32kSI1G9uy+hKKI7Lb6XUjPavLKCKnqdB6RYpwLQDOAdOCzGoinb9loNbHSs5Ii
         He3VnWEaIHzFHTWTK+RomOLidLkQeD4EezfQ5WHNdTFFp9BGs4wKXBjxttXZalNVTTAB
         yPtMnS1uAlXnYCsDG0ykNHvJTuPoa34Dg8ALgcFmxQD9fuY2VlLdZfw04nI+v7KAmJ02
         bOxYRcsbHIcf/tmS12vXG9NTcPpi3nOTR831Z49x7dyPkzOGOPazd3B4pIcmLFYjWwwT
         VoQbNHY3J2pGxn9ZytZ4ycRLlHGw1T/7v2TmOlRV7mCpuJyeqac2gtp6i9hqbCWXkqH2
         2SCg==
X-Gm-Message-State: AOJu0YweKteeJ5UlnuejogA41kOIKwQvQBbEE0Dxx8OGtT6934Rmkjlf
	APnvkkH8/l6qwwHPYIsmv37R1PXniDSui4JsJUzg4jQZ5grZMamyx13YAorxIXY=
X-Google-Smtp-Source: AGHT+IG+4VjesQO0U4bzGJWWiKqATbDZrExKqcLFpjCOsTYwHuqBc2PbTksTfSPvFt0Q7bEW/1nT2w==
X-Received: by 2002:a05:6808:1914:b0:3dc:14dd:c455 with SMTP id 5614622812f47-3de2a88f420mr3074421b6e.19.1724436241784;
        Fri, 23 Aug 2024 11:04:01 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de22555608sm802967b6e.20.2024.08.23.11.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 11:04:01 -0700 (PDT)
Message-ID: <bf12e626-d052-421f-a7e7-ec52577d3297@baylibre.com>
Date: Fri, 23 Aug 2024 13:04:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] iio: adc: ad7606: add support for AD7606C-{16,18}
 parts
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com,
 gstols@baylibre.com, Mark Brown <broonie@kernel.org>
References: <20240819064721.91494-1-aardelean@baylibre.com>
 <20240819064721.91494-8-aardelean@baylibre.com>
 <3c4edf41-fd3b-4258-9b9e-a81b25568403@baylibre.com>
 <CA+GgBR9H66u0mB-cQt_6tT2kh9TCW0Bm_BiHEUyVGvmGHBGEJg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CA+GgBR9H66u0mB-cQt_6tT2kh9TCW0Bm_BiHEUyVGvmGHBGEJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/23/24 10:54 AM, Alexandru Ardelean wrote:
> On Mon, Aug 19, 2024 at 6:33 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 8/19/24 1:47 AM, Alexandru Ardelean wrote:
>>> The AD7606C-16 and AD7606C-18 are pretty similar with the AD7606B.
>>> The main difference between AD7606C-16 & AD7606C-18 is the precision in
>>> bits (16 vs 18).
>>> Because of that, some scales need to be defined for the 18-bit variants, as
>>> they need to be computed against 2**18 (vs 2**16 for the 16 bit-variants).
>>>
>>> Because the AD7606C-16,18 also supports bipolar & differential channels,
>>> for SW-mode, the default range of 10 V or ±10V should be set at probe.
>>> On reset, the default range (in the registers) is set to value 0x3 which
>>> corresponds to '±10 V single-ended range', regardless of bipolar or
>>> differential configuration.
>>>
>>> Aside from the scale/ranges, the AD7606C-16 is similar to the AD7606B.
>>>
>>> And the AD7606C-18 variant offers 18-bit precision. The unfortunate effect
>>> of this 18-bit sample size, is that there is no simple/neat way to get the
>>> samples into a 32-bit array without having to do a home-brewed bit-buffer.
>>> The ADC must read all samples (from all 8 channels) in order to get the
>>> N-th sample (this could be reworked to do up-to-N-th sample for scan-direct).
>>> There doesn't seem to be any quick-trick to be usable to pad the samples
>>> up to at least 24 bits.
>>> Even the optional status-header is 8-bits, which would mean 26-bits of data
>>> per sample.
>>> That means that when using a simple SPI controller (which can usually read
>>> 8 bit multiples) a simple bit-buffer trick is required.
>>>
>> Maybe it would be better to just use .bits_per_word = 18 for the 18-bit
>> ADC and not worry about "simple" SPI controller support for that one?
>>
> 
> +cc Mark Brown for some input on the SPI stuff
> 
> I'm generally fine with choosing to not support SPI controllers that
> can't do padding to 16/32 bit arrays
> 
> But, at the same time: would it be an interesting topic to implement
> (in the SPI framework) some SW implementation for padding a series of
> 18-bit samples to 32-bit arrays?
> (Similarly, this could work for 10-15 bit samples into 16 bit arrays).
> 
> Apologies if this is already implemented and I missed it.
> 
> But if there isn't such a functionality (padding done in SW inside the
> SPI framework), then I could probably spin-up a proposal.
> I think that the functionality could be spun-up in a separate
> patch-set/discussion; and this patchset would just go with
> "bits_per_word = 18".
> 
> It could be done as a new field in the "struct spi_transfer", or
> something else like "spi_pad_rx_to_nbits(struct spi_device *)"
> Or other suggestions welcome
> 
> Thanks
> Alex

Seems like it would be tricky to do something in the core code to
emulate "odd" sized words in general since what is permissible
likely depends on how the individual peripheral works. For example,

total_bits = xfer->bits_per_word * (xfer->len  /
	roundup_pow_of_two(BITS_TO_BYTES(xfer->bits_per_word)))

If total_bits % 8 != 0, then there will be extra trailing
clock cycles that could be problematic on some peripherals
but not others.

And there are other incompatibilities to consider, like this
could not be used with a peripheral that have the CS_WORD flag
set (highly unlikely, but still something to consider if we
are integrating this into the core).

But if you want to look into it more, another use case for this
could be SPI TFT displays. There are a number of these that use
9-bit data words. Right now emulation is handled in the peripheral
driver code. For example, see mipi_dbi_spi1e_transfer() and
fbtft_write_reg8_bus9().


