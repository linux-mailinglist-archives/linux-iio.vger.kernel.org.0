Return-Path: <linux-iio+bounces-26307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57498C6BA59
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 21:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5B314ECB0D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 20:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05DA2DC774;
	Tue, 18 Nov 2025 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksvDlpGz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0EC1FF1B4
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763497993; cv=none; b=HL3IgsvERC1xjj8ZaPQE5UMTJcD/vfTfAn9yCP3NZbXdY0NNzuqXule6RWUhABIaUAwp6T03/0b26NOKY04A/aQh8bwDP0N7z5rCfuzDZ+Bh8RnPGx9c1HDva8k0NZ71BgV/TGq/w0ZqI13dvJcBIC6KEgKL36LXXY83KTvJjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763497993; c=relaxed/simple;
	bh=yljWoAcG5IkbRHmRnbvGG2eI73GQvwqe3YhwrWXFYmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHcg3rMM1FdaVQdGD+Ke7Ig5uVHdo5AU3gogdOsTh/REOWlNOUpoLVehnIMLJ6EJcimPzJSHA+ECm+1V3OlfqAkq3t66DeQZ8wa17H4z1FuIpu67Iw8koFrm7udmUJvNrZRTlXN2F2oFespHdQyiElDrqAnmVmOMFO+O7C0CO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ksvDlpGz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47755a7652eso40456605e9.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 12:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763497990; x=1764102790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6hQN/fjeqLIuFrSTHdt9MWmlCrRyVyGjWaJav0gqPM=;
        b=ksvDlpGzCBwE8V6pJb8XEdTsmBQll6O7AO+Qj3Uywx7TBsaCY900k2LZVQ9U3xSb7z
         ij0ifwzstu8GpwfmqwrRYEhj+8jNnrIEtDSHVZHOGtrXSiB4bSDdQKCBtaqAGaUquoCd
         mmzS5F1miy0UOpSnVLpkuSP/fHo3bZ84ENQa8UUK8zybeU8767OEfDN6V+1SxU/0CwsF
         2NcRhWobcW26fD70bXDcZ4CpVtD1JtzbKKHm+H1/YKiiZhHSu3EJTxuf/LCYD9S0VAE+
         gbOTBnLV2gP/5S70cGA95QYCAvjaKlwa9lBv54x8KAciou7d3iYRNLW0PqwKrxJcjJHE
         5Tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763497990; x=1764102790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6hQN/fjeqLIuFrSTHdt9MWmlCrRyVyGjWaJav0gqPM=;
        b=FhbPSNmqWlQYMeHC7T2royBBIv9tiRpkfjoS7z8U77JW8clxNCazmRsoYamX7nxriG
         5D3/Y6CVWn6vrOy0p6SCdaCkz4Y8NAsJhHV27cRUcn9JlkPHsStpXD0gXF/My4uET2K/
         QpF5AxitBpe8iSsC5Tr7xA0CnBqLkETdD+FZG0/w66vlR7uAt7zC7Eh5d1yInq0OxUi6
         g+RUIMhOPbAxMHwRer3i9sT9t2xFdOHkmtjfeQeLpk2yRz3SlbrankQNRYDzGKj1OTiL
         5fkMA3wPwgIf0wGJv9xCTWax41+a0/XAgJUKRg93qBJjaa+MTRvvNgVZjSKh0r/7dDpP
         SM9A==
X-Gm-Message-State: AOJu0YxNsju8X0MCHCKsRhCfpq1iS3wgM8Vmw6EF6QyFBX7vc7jsQLW7
	8qG9XvU+rkGztGlXTXL5ZAUsjS9k3dlA4AvkeF/k0pfMPT/IicTotLhTUW63LXAAfLg=
X-Gm-Gg: ASbGnctjFMsmuBoQH6yuXVESEh7e3JBPHXEEJLHh06n4KFp8X5bE+kp9SFlDrhtPMXg
	MkH096onCvVPlrGndlUw633Y+JRa3wqj4+f/6Ntf9yBau0741V6gScv50yowEo7bGfo7NNtLQDR
	QJzR8RoBy6rAhqettlSksDJJ+vZlV37+0JxqEPc8TtcV0Qq53h58nFik9GOH8EDcrRF2cx+yDH5
	GdgeKCc+HfkWbXVsiy9OKsiszKfCC6GhPSnsBnqh9PFg2Xjbzx3SvNXAFlMrFsyZRGUyvRYTXlX
	nxvz4eTSB9oSp/J64o5x4ttc1Qh/Rd9Rq1GE6fuDOn3u2H44ojR2/h+fnvaZpZ2OHGqkIYLww/t
	C6Fzj/d9SVvjgTAHAT0EMiJWIezlWQPs4Q6pRr/S7b2aJEgqHe+dKwJTQ9bDR6pqCWGFwc7sudj
	r5nVQY/xW1dxh09HZA272WJKu+CmqDjGM=
X-Google-Smtp-Source: AGHT+IFV+l1p/JM+xI+WrV9liWFTlq+vDk4DBdUHL+wCXviM2Zbyd/LGrB6EOwbksBaj4V5oLErQog==
X-Received: by 2002:a05:600c:3b19:b0:471:989:9d7b with SMTP id 5b1f17b1804b1-4778fe95fe2mr172428665e9.21.1763497989694;
        Tue, 18 Nov 2025 12:33:09 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:3006:e9fd:4de4:66f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10260adsm8397875e9.7.2025.11.18.12.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 12:33:09 -0800 (PST)
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
Subject: [PATCH v6 0/2] NXP SAR ADC IIO driver for s32g2/3 platforms
Date: Tue, 18 Nov 2025 21:33:03 +0100
Message-ID: <20251118203305.3834987-1-daniel.lezcano@linaro.org>
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


