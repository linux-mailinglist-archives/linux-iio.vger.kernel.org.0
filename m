Return-Path: <linux-iio+bounces-26921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 513E3CABD20
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 03:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3912530014EE
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 02:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D0127C162;
	Mon,  8 Dec 2025 02:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWAXEjjV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED223271A9A
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159713; cv=none; b=mJw5UkzE8wjFYMXvSEilVg0dFOp6StYUMyvnFJ1J4d2pkAwPherbFRBOngecz10N+t5E0mXoV9bgDBHxMF0erGiIzEX9hWrtzelcTXQB3GAwn6be5F/9wyY/+ak5Jvb9AjVfzrr9pUk2ct6gSPNV90TdXSGp8IOhQ0SyuDa/LZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159713; c=relaxed/simple;
	bh=lDMZlyGpfKoNlcpX/KNXYEPBdphrdQ+AgXY2BAOf90k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jscfSJopOXtJ0KNz1bSMLvtzX07zZosyKriOuLdqS3l6qnukcMqR29iZerfxBLPplL9n5zj679irrlj0JGGmDpol/VOOPCitVzjlYw2HRg8NdQLCkWTxHsitaAUeVjj8W1eaUNWPrHBlcLxxtHZJOxSQh+W0XQdBuG6ijjaEUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sWAXEjjV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477632b0621so28911485e9.2
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 18:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765159708; x=1765764508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQVDsw5CFyLP82ZzGOYdPw8Cm9WDVlU4PGocuZAdxs4=;
        b=sWAXEjjV5Ba5rSRzavGYRAji/eQMi7Xd/XXp5C8MIekAsK0KU02WgcqiUunut5/Ut7
         BrtmHs0aV5nLWaIUvR9VV00E6N8GvoJTgVP3GCt3nbOThvaswxlUbh3UJu0IQyc4Wjms
         t2dkB1xUkn8mOPHYnfulTpCzDDB42HEyHU+1/JNzk1/FgScmge5ArWrUcTH/lOyYqUD/
         ipVWteN/ks37+LLUZvIyjvlRHXyJIyPxSldA8X9pSdUoQpFO/od5BsBTfRfInHz+yr/Y
         5Si4qByo79gNQNtEhcsbnE2dp95RxivZtjU/pKB6Z8j2sEBbDSKr8EB7HR6oom724yVh
         60BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159708; x=1765764508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQVDsw5CFyLP82ZzGOYdPw8Cm9WDVlU4PGocuZAdxs4=;
        b=PBGXzHBGQRE7K6EwaCnKKHccwFQQxXvE7B/G9QasA1A3ZP3wIb5WsnLV2u69puydEa
         Tl6oXbKf5PWx218b7y0gn/4aiiNZYA0VNH+Se+/98kpIoWKH51rlV+a2EW7XpWDvjMbR
         /TwmqODx9TDTNBJAmKJn+TWdYzhq8uIwjte5h7X6pfmvvjy32bt0emljNeH+7P/pxDBZ
         5KXGVmh7miYA3jXNVBjwtJkefpPwuEkCBMeI34JRfHViiC5feHTAdTR6rxOvc5KL0mNh
         OMYzUL5uxmpVNtGhP6SOX/LtY4s8INY4mACdSZ2NDpDvaQ4oLeSr3SlI/MPUSLWjYHFA
         EmBA==
X-Gm-Message-State: AOJu0Yz/F4rlsTLm8fP7bOTABq3nHLY/nbzTDdJs2sfBbfxYndS5uNWK
	R7Ab4XEVffl4PbKgKVXj8Q0D16wiwmpWxi6gfq9F93m3mawB/jlmgVbU3bH9c/BXMi8=
X-Gm-Gg: ASbGncv7sVHc7qvDoKTezNE1TuP1dTNZkwsJnBpUnrvcLBGXz1ig7jYla2wt6B2jrFM
	OuAh6U4EH1wuiKJ2BJn68rnYNtr9Lo34Tl8WSMa46/8vYvcVB7EISe8oO3QDho0qjUpPqu/Q+9a
	W53/vcoQfhaQaC/YwDtqvtZUptuK2RotEkkLlJNS/SvNv7WsuHo9rOSrUEo4iR8TGbOT64hPsNO
	Jsi7zS0Cyn3Cky16b7DS3Y9Un9SqNpwR4GTzyPzpvnkXucXg3FXj0sRIiJ2g/yYCpPWitEySazu
	kIHyai7pptpw0mVw/cUTMowcqOOyP98P4kXpFZTetNJRh387ulMGYkapaKN8Xym3H/7HNy2HcIB
	XRU9bOvifpIbI9wHx9O3XW3iJ8cnYVGAKjl8SqQcVVNNLlEyHZ9zMncLXK58R+ooDBSf9eJW28y
	o/gSw0NG8OC3dwu0UcFIV8z3uLL80BzBPVOdJ2WLPBbg==
X-Google-Smtp-Source: AGHT+IEEjQHIk3qlCN97fl7KvdS7yROUmdPOTP9Zl6kIHp4RtE3GVgVm+zJkfOdjk2ZrxrVBK+KoGQ==
X-Received: by 2002:a05:600c:528a:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-47939e49135mr65708325e9.33.1765159708465;
        Sun, 07 Dec 2025 18:08:28 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbff352sm22647813f8f.17.2025.12.07.18.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:08:27 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	s32@nxp.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	vkoul@kernel.org
Subject: [PATCH v9 0/2] NXP SAR ADC IIO driver for s32g2/3 platforms
Date: Mon,  8 Dec 2025 03:08:17 +0100
Message-ID: <20251208020819.3063506-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G2 and S32G3 platforms have a couple of successive
approximation register (SAR) ADCs with eight channels and 12-bit
resolution. These changes provide the driver support for these ADCs
and the bindings describing them.

The driver is derived from the BSP driver version. It has been partly
rewritten to conform to upstream criteria.

https://github.com/nxp-auto-linux/linux/blob/release/bsp44.0-6.6.85-rt/drivers/iio/adc/s32cc_adc.c

After the V1 posting there were some discussions around the DMA code
to be converted to use the IIO DMA API [1]. Unfortunately this one is
not yet fully implemented and merged in the framework to support the
cyclic DMA. The current DMA code in the driver has been used in
production since several years and even if I agree it can be improved
with a dedicated IIO DMA API in the future, IMO, it sounds reasonable
to keep it as is until the IIO DMA API supporting the cyclic DMA is
merged. I'll be glad to convert the driver code if such an API exists
and allows to remove code inside the driver.

[1] https://lore.kernel.org/all/c30bb4b6328d15a9c213c0fa64b909035dc7bf40.camel@gmail.com/
[2] https://lore.kernel.org/all/aRyBKH4KOQ1L8lA4@black.igk.intel.com/

Changelog:
	* V9:
	  ** Jonathan Cameron **
	  - Fixed comment to be close to the 80 chars length
	  - Replaced goto statement with a block condition to comply with cleanup.h

	* V8:
	  ** Andy Shevchenko **
	  - Fixed a sentence in the changelog
	  - Moved dev_name() to the upper line for a better line length
	  - Unified messages by starting with a capital letter everywhere
	  - Changed 'dma' -> 'DMA'
	  - Used DEFINE_SIMPLE_DEV_PM_OPS() instead of deprecated macros
	  - Fixed pm_ptr() -> pm_sleep_ptr()

	* V7:
	  ** Andy Shevchenko **
	  - Moved paragraph closer to the tags in the changelog
	  - Used Originally-by which is more adequate
	  - Removed unneeded modulo conversion in macro
	  - Fixed the consistency of the style by lowercasing the hexa value
	  - Rename a timeout macro and remove another one
	  - Clarified a comment when getting the power state of the ADC
	  - Added a comment to clarify the clock is fast and suitable in atomic context
	  - Uppercased the 'adc' words
	  - Added a TODO to use field_get() when available
	  - Removed unneeded explicit casting
	  - Replaced a more readable version with raw ? 0 : 1
	  - Folded return value check with wait_for_completion_interruptible()
	  - Fixed comment "8 bits" --> "8-bit"
	  - Fixed typo in comment
	  - Fixed comment "iio_push_to_buffers_with_ts()"
	  - Clarified why not using a pointer to a mask
	  - Removed unneeded blank line
	  - Removed duplicate error code in message
	  - Initialized the spin lock before requesting the interrupt
	  - One lined declaration in suspend/resume callbacks
	  - Added trailing comma in structure initialization

	* V6:
	  ** Vinod Koul **
	  - Dynamically allocate/release the channel at enable/disable

	  ** Jonathan Cameron **
	  - Reached out Vinod to clarify the buffer life cycle
	  - Inverted more intuitive variable initialization
	  - Updated comment with "iio_push_to_buffers_with_ts"

	  ** Andy Shevchenko **
	  - Removed unused NXP_SAR_ADC_IIO_BUFF_SZ macro
	  - Removed "<litteral>U" annotation
	  - Checked the buffer is a byte buffer
	  - Investigated callback routine vs residue and updated the changelog
	    the conclusions [2]

	* V5:
	  - Rebased against v6.18-rc1

	  ** Jonathan Cameron **
	  - Replace DRIVER_NAME macro with its literal string
	  - Used FIELD_MODIFY() wherever it is possible
	  - Complied with the 80 chars convention
	  - Combined two variables in a single line declaration
	  - Removed the 'remove' function as it is useless
	  - Changed s32g2_sar_adc_data structure indentation / format

	* V4:
	  ** Christophe Jaillet **
	  - Used dmam_alloc_coherent() instead of dma_alloc_coherent()

	* V3:
	  ** Jonathan Cameron **
	  - Removed specific IIO_SYSFS_TRIGGER dependency in Kconfig
	  - Fixed headers
	  - Avoided macro generic names
	  - Used IIO_DECLARE_BUFFER_WITH_TS
	  - Documented buffer and buffer_chan
	  - Fixed single line comment
	  - Commented why channel 32 is the timestamp
	  - Renamed __<prefixed> functions
	  - Factored out the raw read function to prevent nested goto in the switch
	  - Returned -EINVAL instead of break
	  - Removed explict pointer cast
	  - Used iio_push_to_buffers_with_ts variant
	  - Fixed ordering operations in postenable / predisable
	  - Return IRQ_HANDLED even if there is an error in the isr
	  - Fixed devm_add_action_or_reset() to return directly
	  - Used sizeof(*var) instead of sizeof(struct myvar)
	  - Used model name instead of dev_name()
	  - Used dev_err_probe() in any case in the probe function
	  - Fixed indentation

	  ** David Lechner **
	  - Kept alphabetical order in Makefile
	  - Changed explicit GPL-2.0-only
	  - Removed clock name in when calling devm_clk_get_enabled()

	  ** Andriy Shevchenko **
	  - Fixed headers ordering and added the missing ones
	  - Fixed constant numeric format
	  - Ran pahole and consolidated the nxp_sar_adc structure
	  - Fixed semi-column in comments and typos
	  - Fixed indentation
	  - Moved data assignment before iio_dev allocation

	* V2:
	  - Massaged the cover letter changelog to explain the DMA
	  ** Andriy Shevchenko **
	  - Added missing headers and use proper header for of.h
	  - Changed macro offset zero to be consistent
	  - Remove macros REG_ADC_MCR_NRSMPL_* as they are unused
	  - Changed delays macro under the form 100000 => 100 * USEC_PER_MSEC
	  - Replaced PAGE_SIZE by a NXP_PAGE_SIZE = SZ_4K macro
	  - Replaced read_poll_timeout() by readl_poll_timeout()
	  - Changed error pattern "error first"
	  - Replaced variable type 'int' to 'unsigned int'
	  - Fixed bug right instead of left shift, use BIT(channel)
	  - Returned directly from switch-case
	  - Used guard(spinlock_irqsave)()
	  - One liner function call
	  - Remove redundant {}
	  - Write default values litterals instead of temporary variables
	  - Changed variable name vref -> vref_mV
	  - Removed unneeded error message
	  - Used dev_err_probe() consistently
	  - Removed successful driver probe message
	  - Removed redundant blank line

	  ** Nuno Sa **
	  - Replaced of_device_get_match_data() by device_get_match_data()
	  - Removed iio_device_unregister() because devm_iio_device_register() is used
	  - Removed "/* sentinel */" comment
	  - Removed CONFIG_PM_SLEEP defiries

	  ** Krzysztof Kozlowski / David Lechner **
	  - Removed clock-names in DT bindings
	  - Fixed minItems by maxItems

	* V1:
	  - Initial post

Daniel Lezcano (2):
  dt-bindings: iio: adc: Add the NXP SAR ADC for s32g2/3 platforms
  iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms

 .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml   |   63 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/nxp-sar-adc.c                 | 1016 +++++++++++++++++
 4 files changed, 1092 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
 create mode 100644 drivers/iio/adc/nxp-sar-adc.c

-- 
2.43.0


