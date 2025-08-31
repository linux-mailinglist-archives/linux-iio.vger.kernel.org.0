Return-Path: <linux-iio+bounces-23518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3EB3D234
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEAC37A1325
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4DF23BD1B;
	Sun, 31 Aug 2025 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezvDM4AZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C41E502
	for <linux-iio@vger.kernel.org>; Sun, 31 Aug 2025 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637309; cv=none; b=j09etpDw4W7i18DndBh0dm8gBSy0ncsb22EG8vVxLwAKaW+1n8mwE2nC5ObXiyn72MPXKHo/MwWc0RhdExuaSLxavD2toO5q4sA0uS9U4n3ll43lVhUZMOrODTD6MSjCjD76z4oj0WTvEMSWECPHNPqSiIbCCD8gCRNzRnurAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637309; c=relaxed/simple;
	bh=xbZgwQDmbBMHezLzHgzhWuMVe0mib8q80dgAd1hNzKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WB4BF/SE6Wtl4/D73jLKQrvRMeqVKIi/WOSO/OfR8DszrQLAwJJdZhY+c1HWzZFlqW+uek5AtaT78Iwe6GSZVgQWedMFHCDCYmYT3F5gW4mSK1fC8hgLvOl+GiAwrDusIy0hOO22lNN0bJDEXK+j/gFaGL5LJIwhfpCqRmOJNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezvDM4AZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C3EC4CEED;
	Sun, 31 Aug 2025 10:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756637309;
	bh=xbZgwQDmbBMHezLzHgzhWuMVe0mib8q80dgAd1hNzKg=;
	h=From:To:Cc:Subject:Date:From;
	b=ezvDM4AZ6XNBACTO2qTR0GDRPvRSSh8Bwm651J9HLkXXa5G104RnumF/kdtzePV2T
	 OH5MH8T0LH5MmBkn110C/bEqK3RNhJT4OhNMRqj5TA65eyaN8qsnd4INgxQknGHj+L
	 YJm2dc/uTrwVE3zXOvwU+RmOW4yk8xWVC3QnxkPMO8OFE4Fm5Yum46id5p6oEzH/NJ
	 w7OhcNevGTbo43l+5SFr9nn6sBsM+8OsxtTWrW2SiHEMq/8ddSf8UWsf3w9p02+G8m
	 mWtkXFcDfshuB5XXYqd07Selt6zG78IbUQNkL4pmEGJS86NCsrDyUu/r/S4eUmOKkv
	 lMFCuHpNOssXw==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v5 0/6] iio: processed channel handling fixes + Intel Dollar Cove TI PMIC ADC driver
Date: Sun, 31 Aug 2025 12:48:19 +0200
Message-ID: <20250831104825.15097-1-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

Here is v5 of my patch-set to add an IIO driver for the Intel Dollar Cove
TI PMIC ADC. This has turned more into a series with fixes / changes
to iio_convert_raw_to_processed() and iio_read_channel_processed_scale(),
with the new driver tagged on as the last patch :)

Changes in v5:
- Do not put case foo: val = x; break; statements on a single line
- Use IIO_UNIT_TEST module-namespace for iio_multiply_value()
- iio_read_channel_processed_scale(): Use pval + pval2 local variables for
  better readability
- Consistenly use s / ms / ųs for seconds in comments
- Various other small (comment) style fixups
- Add Andy's Reviewed-by to all patches

Changes in v4:
- 2 new bug-fixes for iio_convert_raw_to_processed()
- Factor the bugfixed code multiply a s64 and an iio (type, val, val2)
  triplet out of iio_convert_raw_to_processed() into a new
  iio_multiply_value() helper
- Add a KUnit test for iio_multiply_value()
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
  iio: test: Add KUnit tests for iio_multiply_value()
  iio: adc: Add Intel Dollar Cove TI PMIC ADC driver

 drivers/iio/adc/Kconfig              |  11 +
 drivers/iio/adc/Makefile             |   1 +
 drivers/iio/adc/intel_dc_ti_adc.c    | 328 +++++++++++++++++++++++++++
 drivers/iio/inkern.c                 |  81 ++++---
 drivers/iio/test/Kconfig             |  12 +
 drivers/iio/test/Makefile            |   1 +
 drivers/iio/test/iio-test-multiply.c | 212 +++++++++++++++++
 include/linux/iio/consumer.h         |  18 ++
 8 files changed, 629 insertions(+), 35 deletions(-)
 create mode 100644 drivers/iio/adc/intel_dc_ti_adc.c
 create mode 100644 drivers/iio/test/iio-test-multiply.c

-- 
2.51.0

