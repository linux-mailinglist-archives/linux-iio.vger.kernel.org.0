Return-Path: <linux-iio+bounces-26323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A310C70C0D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 20:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1A86A2938B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 19:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C59315D43;
	Wed, 19 Nov 2025 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDPfqYaX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB6C2E5D2A
	for <linux-iio@vger.kernel.org>; Wed, 19 Nov 2025 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579764; cv=none; b=DBRdmXhqjPs0lXH4IUBUWEzuNYnPiJVhl/w185ZPZ/jDVlSZPi8dqv3zmPxBvl0NK6ur/b3hGzK3TnmyS1kqvNkR8TOXp8wyZYZ1ClD6dmKBz0ZPrKPn5ny3FsL49p9g1BGCMsk/Lc6ALxFoQJzF2sgpJp5ifhagkqnvvewGWRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579764; c=relaxed/simple;
	bh=PyqxDeLWnklxDLea4lMZHNmW8+0PYRict1QhyG/l/1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTqpr86k8ceG5A1PvZhkrTUHdLU4+0Bwo9xSSf6mhfrxyUvHj48YJPA1erTwo0pPLlV7h0iBFWlRJ44yRdQa9XHM5uY4TKxJ+U1asfL8b/xSLPVuH7cBrkGwgqw1xlUllzMBmTSa9XWj79BKKeMoyV5baiVTM5pEmyHPR0u7aRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HDPfqYaX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso1158125e9.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Nov 2025 11:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763579749; x=1764184549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C6OuqeJZhvGMHSS4ImkZHuubYYQPzVP1/U0T2ymBBBY=;
        b=HDPfqYaXbqS08Y/WCNCa/sD12fo5tc9BhHb6kugKLr3bc459tqqQAIUch8tHnFUedS
         cPiY6EMsl4jz4+PAASuO8uEn7jNuXOSbZYSIjtQFzqhdqpbdl/Sucbgr7BhSIN84rmM1
         PnqrQm7N4y7P0A+44Mxh+gXFNsEJino6fJwaQVQJxu7ZXg1azCHg7YfjMxqC8Ptv6IQR
         xcOSe+fdb1yf31+zv8GLJ340iUcjw+OavXEvlK0Xqk/7N4Do8zA4ZgIYeNWtMwGRiKfD
         npGn2ONKzsNoeYx6Z0KDsjM79nxM1sCAqhvqkd+R5AfKu9McA12i+LFPneQgp58IgMis
         wNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763579749; x=1764184549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6OuqeJZhvGMHSS4ImkZHuubYYQPzVP1/U0T2ymBBBY=;
        b=tkwSoBSKmrGZe+CDwoe7CqX/4poNpnwCDxkTrLXdFaZ5P7H9qYX9u/Am6wL4qh99lP
         CZ9AtxXTxAsg7FkpBHgKVv8tj/zmicK8Qda8OlUoo2Hx/8NtPkrh6YFa2XPtsG5iN67q
         UV3PKm9kgtYvjoDFARNlPUJRKRNgDP/LrHuHJRm/KntAjfAcYP7pHqPxlbcXLrqJIf3A
         gOprsQ2BXkYvyW1RSUdPwoIi6zDK9CC+u07UOfmxZx03tne9KtTfGoz6+qT+wuNT3TOk
         XIegKrK0bnyBWS0Me4sVblh5DVWxdwLvVwNUFk5FwJ2zUGMdROOsO/1Am4BbVTYOCWDF
         C8mw==
X-Gm-Message-State: AOJu0YxQ1x2ibA9nW2CgPZBwc/oSxq3+adSZ/sQWNbBe9XzLoqWqNFzz
	czHfHvLwu9tLL7J79j6xp94n27zPaO6W5vOFvK4aiNirXi0rWy/VpLPm5iVngS6s5vA=
X-Gm-Gg: ASbGncuGoCNOwYfF7oBldk+ESloRmbyuTs2UGyujqsvt/WxWisyiDIYO/IfYfPX8Yqz
	wmrOmJB2lPI6q4pICRJOgrYyfwcGOxku31JIjmGwIszK1W+HbVU3rmoFjq9eNXZyxa6s3tTzTBR
	nXAp3XiwdFnY62XgSV2pcwQ7hU+EH5ML3wLs8MlAZrrlOxc5zhq+g80J8ICDhFthHcurcM457lw
	+9hamRGqkazCdUiF/SPGQvZSe5UCsAA2pfAg3FrriMcOm6xbJMOaAoi/FSZXwuSZK2JivyKzAfZ
	6yo2IAdLl/BK/r8pRQUZLOQ8m11YBsVcVTo8vJ2RceNvpOPXaWGSYDnexuy79+QpawxaXLKnOD7
	0Zzn8uO/pOz6QC3LSoiQPGz24wOPedr6cge+ccBuLcGKpQfUUnSkSPRepgHHFQXC6pYKlnDTCFx
	Z1Vns3w4xz0DKn7hiv2H1ld6YhqFu/9yc=
X-Google-Smtp-Source: AGHT+IE/w2b8gSMCy9bUs8RTliLQAWBb9m76KMY755BVK1VHoNHvgJujjZcMR9OFxrqWVtJ6+6St/Q==
X-Received: by 2002:a05:600c:154d:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-477b8953efdmr3897565e9.10.1763579749139;
        Wed, 19 Nov 2025 11:15:49 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd9061sm788246f8f.41.2025.11.19.11.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:15:48 -0800 (PST)
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
Subject: [PATCH v7 0/2] NXP SAR ADC IIO driver for s32g2/3 platforms
Date: Wed, 19 Nov 2025 20:15:43 +0100
Message-ID: <20251119191545.46053-1-daniel.lezcano@linaro.org>
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
 drivers/iio/adc/nxp-sar-adc.c                 | 1015 +++++++++++++++++
 4 files changed, 1091 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
 create mode 100644 drivers/iio/adc/nxp-sar-adc.c

-- 
2.43.0


