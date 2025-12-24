Return-Path: <linux-iio+bounces-27350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F2ACDC01E
	for <lists+linux-iio@lfdr.de>; Wed, 24 Dec 2025 11:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 562EC304B018
	for <lists+linux-iio@lfdr.de>; Wed, 24 Dec 2025 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B56A2F5A12;
	Wed, 24 Dec 2025 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/A17Q7O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F22C21DA
	for <linux-iio@vger.kernel.org>; Wed, 24 Dec 2025 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766572308; cv=none; b=gMmsLj/DwP6Sn5zQaFFda9F1GklXbewvgLJ1WKWQODchQCJyShk1OqLkqkg+pgCJjtdECVYltk72OvXfU+SMcg737Hjp6pXX8oE3zgug8rp81w5xavVGvo1oTV85G8DqY68HmE/cBWZa9AoZ5N7Q3ZENSzLAokYZRdPYDd9/Yx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766572308; c=relaxed/simple;
	bh=KbS5MXORWFyPjx+694FafZDbGmj4V/7Z1w1/lMhBCtQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NZac1Jgrgadn5tT3H1NKakHg6eDPc+6qVEJHPoFkfK6T9y8MsWkmTIEYPLHEaxoUExiQbryB0SFBwN01bElJXSyq38DDLGPnoiyJ3UV+nByKoSNkRaZjQVrbqhoGD8eMwEnbiGdNN+3xOFfkAH6TqQqf/qh1/tC9fzzw1R2QBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D/A17Q7O; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477632b0621so36741155e9.2
        for <linux-iio@vger.kernel.org>; Wed, 24 Dec 2025 02:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766572305; x=1767177105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NGvVXc6XRtW083k97DwRyq5Ot6z1uiIkusA7Y0o7vYE=;
        b=D/A17Q7OkASOnm9CX7ShPVxAFWFLcU+GFJvTWdHrLISt79YnRERSQVjKdM0VkGIk9C
         6XjOsCOG3xBjWijAdz04cBtIbSobW6oR/V7ltxKc1E0cZqe3nH2Yh6YdiK9Fv30FGnSB
         ZyfmNDBAy1fIcaaqE7w1hLtPqFvwxpyVp8QTc7BErkHkrd8wVqxEOHZNDRYHOZPIG1vB
         4Ca5CW7yVOlaosZ5OnizJnPKUj+sCtyiezQNWyjKl6UXPtwxFHMIx5RzozIeODvPFfZw
         PmJxP8+jEhMUj2VaUV7B75rMdM5rO3kImoyc0/mOE4i7UljBIZF/pB2/ahpkrUw6OZv6
         tHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766572305; x=1767177105;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGvVXc6XRtW083k97DwRyq5Ot6z1uiIkusA7Y0o7vYE=;
        b=mcWEGRF+bkg05h+/d78C4HPhwCvaFdwrvIL/8ooromDX3ZPDkFID2GQk2PoC2rUVxS
         Aa92JKgJJfGY0lIRqR/p8TFiv0bTz8oUFG+2ax1sfB7dN4tZjDp0T0kB57QyH5iekdF/
         gC3xMvwrr2DqMu8zZSJyIZrICJuIjndeIMsR+JJmn+85fY8dp/HsYLXaB0E1kxqP+kp9
         fdh6NtWxO1yegB2vPiVVuQjHVL4pFTPiBl4L5//eqPO/K20QdMu2VHIuH7ej3DiCLKIZ
         okVF+uJT62AjVXDBBZH6sTQ3moaby5qmISzkIhfixRHovVN72rzpusjhmnKn15qo1lDo
         10Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUSZGk97BpSforMiNClsMpRochptJ2ETEYmmgDy0NuYmFRwzUehYjfCKPb5l4j/TrADX7JHWQKUFKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8PaJFDzxC1TLei39jwTc4p1w3qDR1xNqUHOsV4I7bEi6qupe6
	PPrZT8m5yTpW/5gya+LxxqKYt32RzrczYa3p2/sxKalkDC7yLOkg5R/MeL15QUJn8G0=
X-Gm-Gg: AY/fxX52dflu+69VDyv0FIaERnCoLQsX6A2qlye98lqqY9+19DFN8exGT/zPQfU4Gbn
	EkaXOxC+m55CsQsurd8EACFOHOLNqSCXhHmJQ2uAc8XBC00gOmQbumI9w1yDp7cXW8yMXGOkEaz
	0ye4nZw2gQauqIKHC+Ebh7a27kJET/zor9RBK65wibJFj5D8YqoS4pXPjrvmZazUo1TMl5J0Od6
	yZTFoal8DbQ6RwsJzWT9lwNRFNpVULARBU4x2UFJZzreGtyW8N2y6oA5XnoZ6a8HBcUNKIZfoCF
	2Ua3S+9jblK0hy5NGFUDBURQwzqCUDTcwmDV9vesYeIjHbZk/9sxWGPOGSGzss+N9ucReplaRY1
	XEM3Vkivk7gSrLurlV8CyiAVdxMLJxXdnBQD+ADYewSFwFT90OITTrDH16lFZEsKCL8liWhp1d6
	R3yU6bbotpvrdaXekXiAySnbR68068+/zpHCuJKbd1sXB/QpqnEubwZ3ptGhuDztQ=
X-Google-Smtp-Source: AGHT+IEWg/RUixNFNrIjz2E21BwwqgTPPKMIzXlp5ri1vLdu3iXnrkhH+lyNgKNAD180VuQXvv1noQ==
X-Received: by 2002:a05:600c:1394:b0:47d:3ead:7440 with SMTP id 5b1f17b1804b1-47d3ed097f8mr12130835e9.32.1766572303894;
        Wed, 24 Dec 2025 02:31:43 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:ecac:6a8e:204a:6b4? ([2a05:6e02:1041:c10:ecac:6a8e:204a:6b4])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be3a9687dsm142348025e9.3.2025.12.24.02.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 02:31:42 -0800 (PST)
Message-ID: <fbe8b18d-4934-404a-a699-9a13ce8f145d@linaro.org>
Date: Wed, 24 Dec 2025 11:31:41 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add the System Timer Module counter
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org
Cc: s32@nxp.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org
References: <20251217075000.2592966-1-daniel.lezcano@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217075000.2592966-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi William,

just a heads up about these changes.

Thanks

  -- Daniel

On 12/17/25 08:49, Daniel Lezcano wrote:
> The NXP S32 family provides a System Timer Module (STM), a 32-bit
> free-running counter clocked from a peripheral clock. The STM includes
> a prescaler and one or more compare channels generating optional
> interrupts. When used as a generic hardware counter, only the main
> free-running counter is required, while the compare channels are
> typically unused.
> 
> On S32G2 devices, the STM is exposed as a simple counter block that
> can operate continuously and be shared across subsystems such as the
> Linux kernel, firmware components running on Cortex-M7 cores, or other
> co-processors. The counter can be read atomically and provides a
> stable timestamp source to correlate events occurring in different
> execution contexts.
> 
> The Linux kernel controls the STM through a memory-mapped interface,
> configuring the prescaler, enabling or disabling the counter, and
> accounting for wrap-arounds. Other subsystems access the counter in
> read-only mode, making it a shared timestamp reference across the
> platform.
> 
> This driver adds support for the STM when used as a counter on S32G2
> platforms. The device is described in the device tree using the
> following compatible:
> 
> compatible = "nxp,s32g2-stm-cnt";
> 
> The driver exposes basic counter functionality: start, stop, reset,
> prescaler configuration, and overflow handling.
> 
> Changelog:
> 	* v3
> 	  - Fixed compatible typo "nxp,s32g2-stm" to "nxp,s32g2-stm-cnt"
> 
> 	* v2
> 	  - Added Rob's tag
> 	  ** kbuild
> 	  - Reordered alphabetically the headers
> 	  - Added bitfield.h header
> 	  - Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
> 
> Daniel Lezcano (3):
>    counters: Reorder the Makefile
>    dt-bindings: counter: Add NXP System Timer Module Counter
>    counter: Add STM based counter
> 
>   .../bindings/counter/nxp,s32g2-stm-cnt.yaml   |  64 +++
>   drivers/counter/Kconfig                       |  10 +
>   drivers/counter/Makefile                      |  21 +-
>   drivers/counter/nxp-stm-cnt.c                 | 386 ++++++++++++++++++
>   4 files changed, 472 insertions(+), 9 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/counter/nxp,s32g2-stm-cnt.yaml
>   create mode 100644 drivers/counter/nxp-stm-cnt.c
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

