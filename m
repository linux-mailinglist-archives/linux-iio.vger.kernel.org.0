Return-Path: <linux-iio+bounces-27182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D27CCD1BD
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 19:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E43C3304248F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 18:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDF03328ED;
	Thu, 18 Dec 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htbWsZoB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA923321D4
	for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070522; cv=none; b=icw2OhykuSEeArh1mSHH+xX7pRdJtKdYjdMRb99MRBMWN0EIOpiDr+EE/nHEHXmmOdaChW89Je5xRl7zFXZSGMnl8s2r7DMAEQrJ+dONB7KLsnAoE5mJnZlTmtHuT/LFTkhefXfWcVXhmHtvyS1Z+ri/1B1Nbyzj2B1EXfPgCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070522; c=relaxed/simple;
	bh=dG9BHkSmtvEZ5opsdi0zlbOpuH7wYROee/KrGE0p6dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPvjnZlFqmb/jtSptOQVzoFTjMdiHODPAwnZpqqMgM6Wh0Hqk3qdFTJeP2GeJUM4ozKCKDh6U30xN5/jK0ZmHH/UhSrM65T2ik2RN6B2x79cRQQNXV2QumUlmIezsdXdBy6tPygtWS/ZsoHWRVaMaJTx0FmdSnpzhrj/ozINoAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htbWsZoB; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-29f30233d8aso9889035ad.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 07:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766070520; x=1766675320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oM5Ed6yAJlRPec6L55p1WAYPdXfYMa3dip7n7XOXSAQ=;
        b=htbWsZoBmbHM1FC1mr9AJBZqLpH2MQjZMEHfN43EdYNGp6nxYCbNPb1qT86ayDja3A
         zqLySKkRTp7mt3sZdAI0mczu3USSLSshdcm2uf0dlhuedIHWAo2fKasH3bL64V3IWmDA
         xRO0REDCbzn9NF2nCoeH/zOaf2PCa4OGK1+vwuubD67K7AdF8LNGVwhwn5YweNvY65pj
         awEm3x5ZJvRQIJ+UeFrJ7fPaQfnoIQVdPTOmOPllGAWbCpxJ3TMmvl3iGoYUy0/Jl0aF
         14cmckXModEUo0iFHrftR8/9CspusSS4pddw2Mz/3grP15W2Mc3Fw60Xfuf9PqHvUq25
         zpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766070520; x=1766675320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oM5Ed6yAJlRPec6L55p1WAYPdXfYMa3dip7n7XOXSAQ=;
        b=eg32fNxjmeXGHZQvI5O6bkYh1VBoIB6n4VFYMYIWkf7Sbq8TxQQYffwXm3FLojLd6x
         9A+gHuSXr0jjvFula8WaoXsra2+CaT8uKMgzcSk0vQaI9Xq4m/q/w1JfLf9EVirlWuRb
         NALuRnre7DeWdHhMDGlfZWKrET7zfVXKqPkUh9VRBW/oQ5xTQj3msmid8pP0Mr/SU8IF
         P7FaoUziOzOyJ8xEQp+lrvmZPTG1vn4i/ESY/BaxEnF7m3quV+rOvaJjptL5hb28vVG6
         mPe5OocuxPTXu/bUCqwAAOZpHYYLuEv9LMN2W4K4S+SXYjT8fsn9QvHG8VHlwRI7v1Jq
         +yrA==
X-Forwarded-Encrypted: i=1; AJvYcCXCkvUlpm7P6BCUw9dKIZC/vSU6PJuTTgrz9FDVmVXJm0erM1HuD0NcP1T55gKSt9ivU99xeDQykE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hHoxv8e6wrVdEM6+ZtN8hgJFFaC4BkUd8yhXSNqDJ/FAobuF
	0ehy+sGqFWScsbmoMD11uBh7Fo6TKY4sclHiKy3LFI7vcSl6jfIN4ANl
X-Gm-Gg: AY/fxX5XrUTPtIyi4flNSVB4Uaja8UCuZa7uLdS0UXpM8xlZEZi4++6xNCWILVFSxHV
	9rdGBJRKhqwiK4qKjrLUq6dw3eBL1AMd7FNlzPXoM8nS+BBhG0ALJRDCzErEjKeCl/9iAZUsXsU
	OuaGuTQVl36Y6R49YV0ZXwae+YAU/h+9vZuZMP3mTviSIFmEW08+Uj8CfHZZOJ85Lz5+V0tAhdY
	aKQDAKvmz3zrxh8aRxCCKEXgaHPyLEsr7CZ+LEIKjgXR0xPU1oHs1bDuTAVh5kbUiNHdsp8Bjfz
	Q/J7NSWzDYgoMC/57GAVjlijo0TzvmLuBunMa1i5OsZiJLOTKYCR9DYXU1OzvPBGxjs5l8Q+D5l
	Xu5Lg3hQu1UKEK7hVm4fiGP47i3VkY+mCwcAzXscLUXmfdetGAGehgvoDMcJk0lWUO70Z1IEVkj
	osXvoLvNcVl1OI1rLmGnU=
X-Google-Smtp-Source: AGHT+IE5702B//DpNe7SVJNLHPzYCxreGWqKSPdmhrv3HDBuK4Aix1Q2FMXA4yfLvlCympXY/u37Sg==
X-Received: by 2002:a05:7300:7b16:b0:2a4:3f9c:9af8 with SMTP id 5a478bee46e88-2ac2f870512mr15965864eec.9.1766070519867;
        Thu, 18 Dec 2025 07:08:39 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b04e58d04asm5133994eec.2.2025.12.18.07.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:08:39 -0800 (PST)
Date: Thu, 18 Dec 2025 12:10:19 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 5/5] staging: iio: ad9832: add sysfs documentation
Message-ID: <aUQZW3XBusWl3TU4@debian-BULLSEYE-live-builder-AMD64>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
 <20251215190806.11003-6-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215190806.11003-6-tomasborquez13@gmail.com>

On 12/15, Tomas Borquez wrote:
> Add sysfs ABI documentation for the AD9832/AD9835 Direct Digital
> Synthesizer chips, documenting frequency, phase, output control,
> and pin control attributes.
> 
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
> ---
>  .../Documentation/sysfs-bus-iio-dds-ad9832    | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-dds-ad9832
> 
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-dds-ad9832 b/drivers/staging/iio/Documentation/sysfs-bus-iio-dds-ad9832
> new file mode 100644
> index 0000000000..5ceea57917
> --- /dev/null
> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-dds-ad9832
> @@ -0,0 +1,41 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent0_frequencyY
To be more generic, I think we could use a capital letter for the channel number
too and avoid the symbol postfix in the this attribute's name.
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_frequency

> +KernelVersion:	6.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +    Frequency in Hz for frequency register Y (0-1). The active
> +    frequency register is selected via out_altcurrent0_frequency_symbol.
Maybe, if we can keep only the 'Frequency in Hz for frequency channel Y.' part
of the description, this is something that could actually go into sysfs-bus-iio
when the driver graduates. Though, the 'register is selected via
out_altcurrent0_frequency_symbol' part is trickier since it seems to be design
specific. 

What if we do something like
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_frequency_symbolZ
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+    Frequency in Hz for symbol Z of frequency Y channel. The active
+    frequency symbol is selected via out_altcurrentY_frequency_symbol.
?

Same thoughts about out_altcurrent0_phaseY.

