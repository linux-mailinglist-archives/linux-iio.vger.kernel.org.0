Return-Path: <linux-iio+bounces-22582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F93B21114
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 18:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719BB1882D53
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89691A9FBF;
	Mon, 11 Aug 2025 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iij5QlBI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3E1A9F84
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927702; cv=none; b=AL7b5CJTvCiDLYZGAchTg/do+7x9imBomhQ7vjw3DyR4UerWlu3o7WuJ017/JmFattzd1wz2DYzrheLj0pg85TMr35Lt2YS8WPtnwiJJiqfU1Y0V+oLax7fTZyH9pngrMr8emi3MgyXWXbv9NfVfXoSIWJsX69HGlGB2d5/6bro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927702; c=relaxed/simple;
	bh=d9OwUPRCRpUnmxvzhMT3RpFm7p+Oy4lMIRc4bzqXouw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PytD0Zd7xMtd4o8WRhE/itfh/3yKayuKApyHZ8906TICf1gayssItMOJY63S7ki99jwLQ3nlF9hG9Qh6BNiFd5nBzjDuJrDHthahS7aY0H9kavFsgGDQo5OqgckFZrAyE+jsuOWSkhz3LvoY3iO+IBB80/YkWbow9yxCdpo1vSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iij5QlBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6320AC4CEED;
	Mon, 11 Aug 2025 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927702;
	bh=d9OwUPRCRpUnmxvzhMT3RpFm7p+Oy4lMIRc4bzqXouw=;
	h=From:To:Cc:Subject:Date:From;
	b=iij5QlBINqvTF/5VkqhXEXHC0buhzlv49PjHg//RLts2VBhZC8P2o0esfc7BAq2aX
	 6H+aQIdkWLMbdqv89wayD8A7of/XkBXpUF75rUkewROoCWdwv7RkbNYXvhvWdwr1N/
	 1PvZh/6VqVS5u/Y5alUJcQ3ddPtf5XHUxmY6fuVwQWfgtRx8s9hDDJZr8+7klh6n4B
	 OXW5a6n7FULpPNrSygHakK3zcjhcsiGnXBgN9z6vSxXMzbEc1um3c6nb9Gm5/3cfQh
	 gK5fVUZ0+AbNsBxPq0vII9AMx15aVxRQVWXgDjsUxwFN5PBAUtZJcALAWGefG+zRv9
	 48cmtCJxa1BXg==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 0/6] iio: processed channel handling fixes + Intel Dollar Cove TI PMIC ADC driver
Date: Mon, 11 Aug 2025 17:54:47 +0200
Message-ID: <20250811155453.31525-1-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

Here is v4 of my patch to add an IIO driver for the Intel Dollar Cove TI
PMIC ADC. This has turned more into a series with fixes / changes
to iio_convert_raw_to_processed() and iio_read_channel_processed_scale(),
with the new driver tagged on as the last patch :)

Changes in v4:
- 2 new bug-fixes for iio_convert_raw_to_processed()
- Factor the bugfixed code multiply a s64 and an iio (type, val, val2)
  triplet out of iio_convert_raw_to_processed() into a new
  iio_multiply_value() helper
- Add a kunit test for iio_multiply_value()
- Redo the "Improve iio_read_channel_processed_scale() precision"
  patch using the iio_multiply_value() helper

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


Hans de Goede (6):
  iio: consumers: Fix handling of negative channel scale in
    iio_convert_raw_to_processed()
  iio: consumers: Fix offset handling in iio_convert_raw_to_processed()
  iio: consumers: Add an iio_multiply_value() helper function
  iio: Improve iio_read_channel_processed_scale() precision
  iio: test: Add kunit tests for iio_multiply_value()
  iio: adc: Add Intel Dollar Cove TI PMIC ADC driver

 drivers/iio/adc/Kconfig              |  11 +
 drivers/iio/adc/Makefile             |   1 +
 drivers/iio/adc/intel_dc_ti_adc.c    | 327 +++++++++++++++++++++++++++
 drivers/iio/inkern.c                 |  77 ++++---
 drivers/iio/test/Kconfig             |  12 +
 drivers/iio/test/Makefile            |   1 +
 drivers/iio/test/iio-test-multiply.c | 209 +++++++++++++++++
 include/linux/iio/consumer.h         |  18 ++
 8 files changed, 621 insertions(+), 35 deletions(-)
 create mode 100644 drivers/iio/adc/intel_dc_ti_adc.c
 create mode 100644 drivers/iio/test/iio-test-multiply.c

-- 
2.49.0


