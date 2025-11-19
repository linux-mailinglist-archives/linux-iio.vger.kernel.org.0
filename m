Return-Path: <linux-iio+bounces-26326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6A9C714AD
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 23:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DECD234EB8D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 22:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848F3191D1;
	Wed, 19 Nov 2025 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y3Y1PMKN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71E25BEE7
	for <linux-iio@vger.kernel.org>; Wed, 19 Nov 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763591956; cv=none; b=YybdLa1qIRTDl3+F8v4xBgiufiS0oI7DXjHKfdri+r0TBcs/LFLaNE2/NmCsfvUCSijwKUjw7v8czZa7JRgq4b/lCA8x2AdTAOlq0Tt5zRJxSgW9pTJ29qyvbRcsEqHtb/gR/5Bt+MgjF85tZPF49D5zyMSlIdmYF1KWAi43qJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763591956; c=relaxed/simple;
	bh=qxW/aVcWFy9yYpfSBFwdgiLyeYeDJFfC/PRSKYszLwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNnUYMe5uQLOLaoXnevDrlIr8JHvskq55PfC6ystUlClRJd0YEGgj9Lfa87y5jfRCh/QK4aE8TbwWzpdAcOvzU1eGzipmJZs0C0v0nI5wtmbCGK3lj8D8yZlsda3F5SNKaoB7voAwHLQclLol1gj/82UiS8RxjQf3IUv4hLVLXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y3Y1PMKN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42bb288c1bfso142946f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Nov 2025 14:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763591952; x=1764196752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rO3jG86F0dMbqPDGuzv70vuhyM6PVQCQjUR/rmasITE=;
        b=y3Y1PMKNtYuRnspb6KhkUnemOA1hce3RoA+XU2P5xLWRRIHE0uV5W/m1gQvdLl7qaA
         BNKe47mSpAQ3ppl0mwBrNcINSvQo1NW3bS5TD5uU5SWrh8JMZkLP/WyPwO4kujxDa/P7
         6PnoCzt423thvoqnd53XKzeWUdpm53e3zVXHekGCODMGlPoOPaagkRJSc2KAhQSvSgc/
         PaXjYU2yZGmjKZa7aLwDHju9u88xCI/DHaRiYJbhRFyWUKdKX0iZZnQXip6xyutwZDhJ
         Q5M5eZ7imKW5x7Mdf7LC//VLVA6R29ApkUZl2o0E0dCKAgPLq5JXUbVG+DzqOat24U9j
         jGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763591952; x=1764196752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO3jG86F0dMbqPDGuzv70vuhyM6PVQCQjUR/rmasITE=;
        b=NG7sIOwAG9Ir8skmn2qXHgMsIV4o/5rFGSrFM077vRGb8nJ661WnYF0ZlErLMzbNjp
         gneY6Io7jVcXeinU5IeUHcGWyXlNPLeeOLBRbu+wPBL8wTPYJapj5A0KvTfOZZcMDRNo
         o/ebUy+oAwUjT66OdaKZ1fK0nTZ+ibaw5Ny/TlB/PJTtBShJisKS1F5bqsy6jD7D2pjI
         ZkBLQeEk8B7MBZCkzZiE0YgMtA2RuvFjeqefVPACUN073rKDay7mnSVuok7ZMjPfPlVG
         NfYy1nqCyWfv/RCn+2YmBuD3xz65p0nbydSDasRaqH/NJ092AnD/gBcLiU8LmmsLg3NY
         iILw==
X-Gm-Message-State: AOJu0Yx4QWFVjvrAqL6TzkE77bxBtfrG+lgGhW4atg2o8iSo8l82URnG
	/RptgRr1p60i1+fzj2AB2GYgrtl2UdyUdLk1qZT0zp+PKnr0CmbFNT0TuR8uDsagwx4=
X-Gm-Gg: ASbGncvpkPSnc1J0D8kaCqLWi04Ltlyj6hRIfb6ZF/iYrGJ2+AHoKC7bE1ALZmVO8nM
	txSTnMw7ahPYS1RZbXeSl4qj7e8rDYs47PDVcyYwZAbWRKMxnYBcEnxKZf1j/u1sJfGuFNurv7x
	RBqv+qw2Jb2+M+VhHf9PlFL3nKeKvpKy2Z4WF2ZY7Kl17Jp5cifnvHTPAyG8tOiFInwFlHbA0Ux
	3gFjra+F+dpN5bCJwGJXZts3yaSrK/GMlkEcnTFZxlqVCt6e+6OTqGMeY3fGWasblvU2BQ4eWW/
	DfY5dOP1LWhXBp7tG4D0bfXGWUm49AdhZvl3cJKl4o9J/mux8h7l+1JEjQxN0MUlBWvFGpDDYo7
	1T4CLva4Fy0Erd0zZ2WlTFOpmSTE9R8WOMb71rrcKjCvWPxgStCaefU+7+2a7wVmbVEAR1awHCp
	ztuS25v2/RIRLq7WXlbIWuFXaGQbGewiD2ifNujmYN9w==
X-Google-Smtp-Source: AGHT+IGRM3zSZ4y4pE5DaA136Xb1RTTE1W6RdwYcRCI59hdibMyDEFCAIovtcxs2/qZa9kac9Mou5A==
X-Received: by 2002:a05:6000:2681:b0:425:7e45:a4df with SMTP id ffacd0b85a97d-42cb9a204cbmr391626f8f.11.1763591951186;
        Wed, 19 Nov 2025 14:39:11 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa41d2sm1569760f8f.22.2025.11.19.14.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 14:39:10 -0800 (PST)
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
Subject: [PATCH v8 0/2] NXP SAR ADC IIO driver for s32g2/3 platforms
Date: Wed, 19 Nov 2025 23:39:03 +0100
Message-ID: <20251119223905.107065-1-daniel.lezcano@linaro.org>
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
 drivers/iio/adc/nxp-sar-adc.c                 | 1017 +++++++++++++++++
 4 files changed, 1093 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
 create mode 100644 drivers/iio/adc/nxp-sar-adc.c

-- 
2.43.0


