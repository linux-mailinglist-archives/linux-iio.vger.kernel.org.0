Return-Path: <linux-iio+bounces-26386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C43C7D3D3
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 17:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A02784E357A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 16:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA88298CCF;
	Sat, 22 Nov 2025 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvtBHX8n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955C1D63D1
	for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763828225; cv=none; b=SV8CDrlHVm3T2RrCQ0yeW12RS4aCN9nhMLEDavlUhzHanmCEBmrrecs1adD2/o1LH3MoI6R3q/1Xmp/P0LeArgQkp6IqYA4YgfF7Ffkx/c16GdAA8IJqkftP4cMVRa8ddXoCH/jn7HR4EUZ0btzOk3YalDPmEIUrnKkvbXqXzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763828225; c=relaxed/simple;
	bh=28nhX5qBK/EMgb8p7XB7XvfaaP3czOWJ70NkxxEkAUQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OQw21xYdnX/vmC5hQz5nTw9caqBqbeErqKf1XbAj7CY868+aTAb5N7DFhp9p75WZIMQ+OH+WtXEv9R5GdPvA2N1Q0Nbsd2KyHETMLH/aAChXOrD/wHcFGpAHdSClmt7eGsAiP/fzY6gTwJBqBtM+g+AStVYaUncxhoEk/Zh5ujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dvtBHX8n; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47789cd2083so17658255e9.2
        for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 08:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763828221; x=1764433021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8238r8hv3VKKpL8whZJvFhSGdhCRb7nrzwRpOpkDtKc=;
        b=dvtBHX8nGXgdlGh+x7QENEZwLSMB1PKDsQP5X1mTgAe+Y4WHzXVBlP9iuxybcevozL
         mmRWJmDKF3m26tFrckD4EYkiLViRBQKVCcFxW13Wj0zkd75JTT+Eo0ajBTNpXisv91gK
         I6xxBwO10WdWpH+oJkldmd6hYzhrARc9x174RiU2Dazlm4Hh5fOXGYEqldMWU7SchnX1
         M7CRy3gvWfKUsr+jXz/MMD27VbgeeQ6bKvT7m/Hmz/yj91khFgEO/MKhCJFkxYzLdnIw
         UNx1ZNaYzCdnJg7GLP1Ts8BMfSZB7oioDUjWOjFmEO3f2BNj1y+nB785IME7KJy5fid7
         CApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763828221; x=1764433021;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8238r8hv3VKKpL8whZJvFhSGdhCRb7nrzwRpOpkDtKc=;
        b=ng4DSfuScXnFvhnUAFYI21dYa9r6AWuEdZMPkXXQHvx2yskPotL07bEhBrjp1+NLbB
         QzHRPKZYj7KeoPhUZJxkacbKKJQxAGlpk0LDhjqaYGVWwtwjkqFFKGO+ZzX/bHHat9R7
         oDdtKWSMju08FGKBktQ0BeatYizjrHJfWivT/aonznCa9xLMZLLXhHCJdE/nDfGQrzDI
         zMyvgHiwws+8PlQTa/E4hmrpsPK5E//96yFhula1El3vgdVgnSYZpy1M/d4OEoNAZ0Xw
         MH4RoPQ0S0TZxjl0czFdSKxauQ01UiV9yu2kyKZgLcgq/T1kNP32/A3HuQ4o38HIM5vY
         GLkA==
X-Gm-Message-State: AOJu0Yw3Cbpp7vf6tdSq8Lg7CVzzOnwx3Q4bP3Y8o49migfgs1/OZzSi
	Ay2ES/5x96BVJLGTaaq42lCkLhjgG3BUNGRUNQvK8W5D5eDDMbY4wwOX2kFk5aydgS0=
X-Gm-Gg: ASbGnctLmxumwcooXasIsOaAx10D3j7fKAZzd9EcimbJ/VShSePWAu+T1ZpN+oJ3eR5
	kHPjE3SatAIMu7cr2r571+VMPygXEjsu6NtAPi7hz817Ey3KpqRGcb6td7bEmTJ1eSExEYI1n61
	AMyV2aFA6w6xZhvfG68glhFcSMp411VwIKlP0LDVHeWc+QiZu5/n/DDbVJ1/3tDyqo39UGy4Ts6
	ARm7HEQDv1/9FKnYUCfOGdNalbI5cHuEA3+dPQti36OX2EiGIx0sYwtwpB+yplxX9T3pMldzqAc
	X5WRam2CIvDlZHEx26p6Eq8UrTVKoPNhwqd+qFXvbxRD7orxpSbeiM1qapZbgT4owSGhUu7VoPZ
	j8VI388yXAm+6ViQByYD7DOFmahFtDvbmZsuNA40QEIu6Ocmx67cdUyKi3M3ZgQdwkm24pwbQ/w
	yPWXYBBpFxy+eCBgjXNo/RlcaKB0n0CNbqTJ5T9Mr7jlOCIEzAE0ILwDQDdSonmEfqF3BnJk+0J
	n0l
X-Google-Smtp-Source: AGHT+IH0Dr7arZdMYxdjBeEYLbl1nPIKH4f6XRrOXu3cgfl5u/wHYevGFWNjbHCCXa31yqyjtnDYDA==
X-Received: by 2002:a05:600c:3b01:b0:477:54cd:200a with SMTP id 5b1f17b1804b1-477c110325dmr49001975e9.6.1763828221217;
        Sat, 22 Nov 2025 08:17:01 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477a9de46cdsm106307725e9.8.2025.11.22.08.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 08:17:00 -0800 (PST)
Message-ID: <1dcf3278-7552-4b52-91d2-e8e711f8b230@linaro.org>
Date: Sat, 22 Nov 2025 17:16:59 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] NXP SAR ADC IIO driver for s32g2/3 platforms
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com, vkoul@kernel.org
References: <20251119223905.107065-1-daniel.lezcano@linaro.org>
Content-Language: en-US
In-Reply-To: <20251119223905.107065-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Johnathan,

I believe I took all comments into account.

Can this series be considered to be merged ?

Thanks

   -- Daniel

On 11/19/25 23:39, Daniel Lezcano wrote:
> The S32G2 and S32G3 platforms have a couple of successive
> approximation register (SAR) ADCs with eight channels and 12-bit
> resolution. These changes provide the driver support for these ADCs
> and the bindings describing them.
> 
> The driver is derived from the BSP driver version. It has been partly
> rewritten to conform to upstream criteria.
> 
> https://github.com/nxp-auto-linux/linux/blob/release/bsp44.0-6.6.85-rt/drivers/iio/adc/s32cc_adc.c
> 
> After the V1 posting there were some discussions around the DMA code
> to be converted to use the IIO DMA API [1]. Unfortunately this one is
> not yet fully implemented and merged in the framework to support the
> cyclic DMA. The current DMA code in the driver has been used in
> production since several years and even if I agree it can be improved
> with a dedicated IIO DMA API in the future, IMO, it sounds reasonable
> to keep it as is until the IIO DMA API supporting the cyclic DMA is
> merged. I'll be glad to convert the driver code if such an API exists
> and allows to remove code inside the driver.
> 
> [1] https://lore.kernel.org/all/c30bb4b6328d15a9c213c0fa64b909035dc7bf40.camel@gmail.com/
> [2] https://lore.kernel.org/all/aRyBKH4KOQ1L8lA4@black.igk.intel.com/
> 
> Changelog:
> 	* V8:
> 	  ** Andy Shevchenko **
> 	  - Fixed a sentence in the changelog
> 	  - Moved dev_name() to the upper line for a better line length
> 	  - Unified messages by starting with a capital letter everywhere
> 	  - Changed 'dma' -> 'DMA'
> 	  - Used DEFINE_SIMPLE_DEV_PM_OPS() instead of deprecated macros
> 	  - Fixed pm_ptr() -> pm_sleep_ptr()
> 
> 	* V7:
> 	  ** Andy Shevchenko **
> 	  - Moved paragraph closer to the tags in the changelog
> 	  - Used Originally-by which is more adequate
> 	  - Removed unneeded modulo conversion in macro
> 	  - Fixed the consistency of the style by lowercasing the hexa value
> 	  - Rename a timeout macro and remove another one
> 	  - Clarified a comment when getting the power state of the ADC
> 	  - Added a comment to clarify the clock is fast and suitable in atomic context
> 	  - Uppercased the 'adc' words
> 	  - Added a TODO to use field_get() when available
> 	  - Removed unneeded explicit casting
> 	  - Replaced a more readable version with raw ? 0 : 1
> 	  - Folded return value check with wait_for_completion_interruptible()
> 	  - Fixed comment "8 bits" --> "8-bit"
> 	  - Fixed typo in comment
> 	  - Fixed comment "iio_push_to_buffers_with_ts()"
> 	  - Clarified why not using a pointer to a mask
> 	  - Removed unneeded blank line
> 	  - Removed duplicate error code in message
> 	  - Initialized the spin lock before requesting the interrupt
> 	  - One lined declaration in suspend/resume callbacks
> 	  - Added trailing comma in structure initialization
> 
> 	* V6:
> 	  ** Vinod Koul **
> 	  - Dynamically allocate/release the channel at enable/disable
> 
> 	  ** Jonathan Cameron **
> 	  - Reached out Vinod to clarify the buffer life cycle
> 	  - Inverted more intuitive variable initialization
> 	  - Updated comment with "iio_push_to_buffers_with_ts"
> 
> 	  ** Andy Shevchenko **
> 	  - Removed unused NXP_SAR_ADC_IIO_BUFF_SZ macro
> 	  - Removed "<litteral>U" annotation
> 	  - Checked the buffer is a byte buffer
> 	  - Investigated callback routine vs residue and updated the changelog
> 	    the conclusions [2]
> 
> 	* V5:
> 	  - Rebased against v6.18-rc1
> 
> 	  ** Jonathan Cameron **
> 	  - Replace DRIVER_NAME macro with its literal string
> 	  - Used FIELD_MODIFY() wherever it is possible
> 	  - Complied with the 80 chars convention
> 	  - Combined two variables in a single line declaration
> 	  - Removed the 'remove' function as it is useless
> 	  - Changed s32g2_sar_adc_data structure indentation / format
> 
> 	* V4:
> 	  ** Christophe Jaillet **
> 	  - Used dmam_alloc_coherent() instead of dma_alloc_coherent()
> 
> 	* V3:
> 	  ** Jonathan Cameron **
> 	  - Removed specific IIO_SYSFS_TRIGGER dependency in Kconfig
> 	  - Fixed headers
> 	  - Avoided macro generic names
> 	  - Used IIO_DECLARE_BUFFER_WITH_TS
> 	  - Documented buffer and buffer_chan
> 	  - Fixed single line comment
> 	  - Commented why channel 32 is the timestamp
> 	  - Renamed __<prefixed> functions
> 	  - Factored out the raw read function to prevent nested goto in the switch
> 	  - Returned -EINVAL instead of break
> 	  - Removed explict pointer cast
> 	  - Used iio_push_to_buffers_with_ts variant
> 	  - Fixed ordering operations in postenable / predisable
> 	  - Return IRQ_HANDLED even if there is an error in the isr
> 	  - Fixed devm_add_action_or_reset() to return directly
> 	  - Used sizeof(*var) instead of sizeof(struct myvar)
> 	  - Used model name instead of dev_name()
> 	  - Used dev_err_probe() in any case in the probe function
> 	  - Fixed indentation
> 
> 	  ** David Lechner **
> 	  - Kept alphabetical order in Makefile
> 	  - Changed explicit GPL-2.0-only
> 	  - Removed clock name in when calling devm_clk_get_enabled()
> 
> 	  ** Andriy Shevchenko **
> 	  - Fixed headers ordering and added the missing ones
> 	  - Fixed constant numeric format
> 	  - Ran pahole and consolidated the nxp_sar_adc structure
> 	  - Fixed semi-column in comments and typos
> 	  - Fixed indentation
> 	  - Moved data assignment before iio_dev allocation
> 
> 	* V2:
> 	  - Massaged the cover letter changelog to explain the DMA
> 	  ** Andriy Shevchenko **
> 	  - Added missing headers and use proper header for of.h
> 	  - Changed macro offset zero to be consistent
> 	  - Remove macros REG_ADC_MCR_NRSMPL_* as they are unused
> 	  - Changed delays macro under the form 100000 => 100 * USEC_PER_MSEC
> 	  - Replaced PAGE_SIZE by a NXP_PAGE_SIZE = SZ_4K macro
> 	  - Replaced read_poll_timeout() by readl_poll_timeout()
> 	  - Changed error pattern "error first"
> 	  - Replaced variable type 'int' to 'unsigned int'
> 	  - Fixed bug right instead of left shift, use BIT(channel)
> 	  - Returned directly from switch-case
> 	  - Used guard(spinlock_irqsave)()
> 	  - One liner function call
> 	  - Remove redundant {}
> 	  - Write default values litterals instead of temporary variables
> 	  - Changed variable name vref -> vref_mV
> 	  - Removed unneeded error message
> 	  - Used dev_err_probe() consistently
> 	  - Removed successful driver probe message
> 	  - Removed redundant blank line
> 
> 	  ** Nuno Sa **
> 	  - Replaced of_device_get_match_data() by device_get_match_data()
> 	  - Removed iio_device_unregister() because devm_iio_device_register() is used
> 	  - Removed "/* sentinel */" comment
> 	  - Removed CONFIG_PM_SLEEP defiries
> 
> 	  ** Krzysztof Kozlowski / David Lechner **
> 	  - Removed clock-names in DT bindings
> 	  - Fixed minItems by maxItems
> 
> 	* V1:
> 	  - Initial post
> 
> Daniel Lezcano (2):
>    dt-bindings: iio: adc: Add the NXP SAR ADC for s32g2/3 platforms
>    iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms
> 
>   .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml   |   63 +
>   drivers/iio/adc/Kconfig                       |   12 +
>   drivers/iio/adc/Makefile                      |    1 +
>   drivers/iio/adc/nxp-sar-adc.c                 | 1017 +++++++++++++++++
>   4 files changed, 1093 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
>   create mode 100644 drivers/iio/adc/nxp-sar-adc.c
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

