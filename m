Return-Path: <linux-iio+bounces-22076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D69B131F3
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 23:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4A6176D0B
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 21:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF54422173A;
	Sun, 27 Jul 2025 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBJPXZ8t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D75B155326
	for <linux-iio@vger.kernel.org>; Sun, 27 Jul 2025 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753650408; cv=none; b=D68jfSCs7hrg87PphApJqjkHGFy/FArKx8NVYACiapPCxclz/9L0mSsTenR9bBr8f3FfdtFn3nPgwX/kYj0XBLao9nIoDDeTh8kJPCkBiptkEg43HDUnZ6Bcja3gAL+1Ntd+3hzYtBHu4ZrD36PpTnaWRbQCbiru2S9+LH8k9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753650408; c=relaxed/simple;
	bh=Mvu/BJAXADbangO5S+we1SYC6JUsrULTj5SSm3NdC3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qI/DQSxqtWKTxya3I08WwS46r46N9wUBw7U8dmVrFfsPWq9HCarfpGML/REZ6TGhIxubD3EkpNw3wl+OUr7B4I+oMjAKSy0bFLWGKaekHCwr+MplS3Y9Bf4lv4cEfZujTQR6ASnSZ12HwmWAY7n6KHmeydR26mkkaR2QEVLkHIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBJPXZ8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CEFC4CEEB;
	Sun, 27 Jul 2025 21:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753650408;
	bh=Mvu/BJAXADbangO5S+we1SYC6JUsrULTj5SSm3NdC3k=;
	h=From:To:Cc:Subject:Date:From;
	b=kBJPXZ8tZ0n5tB+OK0SspHpKXQetOKP78YGNqhXpXlBezfa9C//D68yRThTCEOjWF
	 xQ5YxuuJLePPLeCrDkof+yYbVv/RR1XnUa7rvDyp2bKKaJQxgdMhpofpIuXKasXZQ4
	 syLE4yGTXLdRsheykneeKMYCEBPB6LtGRzengO6S3Co1BeD/EjtEqmCeBoApb3ODv9
	 tznM/Ypi/qxIIdSm5MUkNDx8XcDUqTr+//uRnlDryx8QtB67CaytJEm+OP9SGjFj/b
	 IiaPuMnaUUILmGGqJNTOtHgd0rXdl92HC2F0Kokv2rS27SWzYn0CyuDlB3FMVaeGTO
	 HfYKjT/3Nt+IA==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 0/2] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
Date: Sun, 27 Jul 2025 23:06:37 +0200
Message-ID: <20250727210639.196351-1-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here is v3 of my patch to add an IIO driver for the Intel Dollar Cove TI
PMIC ADC.

Changes in v3:
- "iio: Improve iio_read_channel_processed_scale() precision"
  - Use div_s64() instead of div_u64() to fix -1.0 - 0.0 range
  - Directly return IIO_VAL_INT from valid cases and drop the final
    return ret after the switch-case
- "iio: adc: Add Intel Dollar Cove TI PMIC ADC driver"
  - Use new more compact DC_TI_ADC_DATA_REG_CH(x) macro
  - Use regmap_set_bits() regmap_clear_bits() where applicable
  - Use regmap_bulk_read() + be16_to_cpu() to read ADC value
  - Use sign_extend32() for vbat_zse and vbat_ge reading in probe()

Changes in v2:
- Add new "iio: Improve iio_read_channel_processed_scale() precision"
  patch to the series
- Add IIO_CHAN_INFO_SCALE and provide ADC scale info for Vbat
- Add IIO_CHAN_INFO_PROCESSED which applies calibration and
  scaling for the VBat channel
- Address some other small review remarks

Regards,

Hans


Hans de Goede (2):
  iio: Improve iio_read_channel_processed_scale() precision
  iio: adc: Add Intel Dollar Cove TI PMIC ADC driver

 drivers/iio/adc/Kconfig           |  11 +
 drivers/iio/adc/Makefile          |   1 +
 drivers/iio/adc/intel_dc_ti_adc.c | 327 ++++++++++++++++++++++++++++++
 drivers/iio/inkern.c              |  24 ++-
 4 files changed, 359 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iio/adc/intel_dc_ti_adc.c

-- 
2.49.0


