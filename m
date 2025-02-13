Return-Path: <linux-iio+bounces-15491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CD9A348B5
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 16:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D14216112E
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04E31CDA3F;
	Thu, 13 Feb 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEHQRma0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E9152532;
	Thu, 13 Feb 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462354; cv=none; b=O50KfH16jsDi9xaLtNutCeaTNKYrjbIZpOe2V1SALPF1ZEFvKS75aa9A6wSMTVvO7tKraK9lRvlnQnj5HBpOlCxs/gxMA3NTVdYe/3gZWsVbpixTyVjOV6q+Sz189S02DfEprPNcQ+T1PnP0bkRVZ+oqEhd2WX10DZ2un8O0Cfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462354; c=relaxed/simple;
	bh=jhNefGtsRWXyhnxG+bgW4pvnMHzaSA4ko0O4FWE8Lp8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=grgAoPXmAq9G2qZP8928JqxIjDR3kZX3sbtrCwyN3Uoe6JUsnyowBmCtSFLHVbZ3SSXSrNiyODuXqaZ+93OwoGGxPQoPfFMl7murnX6DYcDt1llkosVCAnTlBIOdTUiC8MgwsBkHqvi6efKxa72kMnxGqhOmF4Y89Qf9fq0/vO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEHQRma0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6631CC4CED1;
	Thu, 13 Feb 2025 15:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739462354;
	bh=jhNefGtsRWXyhnxG+bgW4pvnMHzaSA4ko0O4FWE8Lp8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZEHQRma01gw+Qyo9YZZLw6S9xt+9nwhj2+sR/54HPKZYiHpRI+K4RMoMNxh5ADfBd
	 8jHh5+zhT21n+fAWngs0kXilDBUKI1DyGb0vf4DpXWj72kQLtOdCblgUEGLARDL0Ik
	 bse6xYa+6/uPJRCCFYjF90JOch67MwjHvDha3fLlu0828wUYJB7SDiEW8fiUGV84Q2
	 XcbddIQC+qJRoNoEI1Km81B4JftRfRLu2Krh/5rsgROOKeISJLhUSOOfz9gdqylMCS
	 26ehjAOFFpqay+P4gbv3yv+05wt5nkHTLtbBT4965WvGzPGoJhvh0FiIeFLdq/c1gL
	 r5V56n7Agy9kA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA10C021A4;
	Thu, 13 Feb 2025 15:59:14 +0000 (UTC)
From: Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org>
Subject: [PATCH v4 0/2] Support for TI ADS7128 and ADS7138 ADCs
Date: Thu, 13 Feb 2025 16:58:56 +0100
Message-Id: <20250213-adc_ml-v4-0-66b68f8fdb8c@softing.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMAWrmcC/2XM3wqCMBTH8VeJXbfYztzUrnqPiNg/dZAuNhmF+
 O5NISm8/B3O5zuhaIOzEZ0PEwo2uej8kEdxPCDdyaG12Jm8ERAoKAXA0uh7/8CGalsJW3EFGuX
 nZ7CNe62h6y3vzsXRh/faTXS57hKJYoJJKeoGLFVK00v0zeiG9qR9j5ZIgi/kBAjbIGRYSV6XQ
 hDNar6H7BeKDbIMqSHKsKJiUsI/nOf5A4mGyXsQAQAA
X-Change-ID: 20241122-adc_ml-d1ce86e85b2c
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tobias Sperling <tobias.sperling@softing.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739462353; l=3437;
 i=tobias.sperling@softing.com; s=20241122; h=from:subject:message-id;
 bh=jhNefGtsRWXyhnxG+bgW4pvnMHzaSA4ko0O4FWE8Lp8=;
 b=B3z1r3JT8BOwrbjqgQHDiTpNwRX4k7kpMRgT340opHRRc/PdyFaaou2pXeCZ7WNTV4i3guKAr
 jUc15Bon+6RDLBG9MQsEkvlFx9fWcPhZ6j3HE6rH+De+VE6qvtXTq/e
X-Developer-Key: i=tobias.sperling@softing.com; a=ed25519;
 pk=v7hgaMHsrA9ul4UXkBVUuwusS9PF3uHW/CC+gABI65E=
X-Endpoint-Received: by B4 Relay for tobias.sperling@softing.com/20241122
 with auth_id=281
X-Original-From: Tobias Sperling <tobias.sperling@softing.com>
Reply-To: tobias.sperling@softing.com

This patch series adds support for Texas Instruments ADS7128 and
ADS7138, which are 12-bit, 8 channel analog-to-digital converters (ADCs)
with build-in digital window comparator (DWC), using the I2C interface.

The driver exposes the interfaces to read the raw values, as well as the
minimum and maximum value for each channel. In addition several settings
can be configured, like the DWC, sampling frequency or an averaging
filter/oversampling. Interrupts triggered by the DWC, if configured, are
then exposed as IIO events.

ADS7128 differs in the addition of further hardware features, like a
root-mean-square (RMS) and a zero-crossing-detect (ZCD) module, which
are not yet supported by the driver.

Regarding the I2C interface the chips using opcodes to define the way
how the registeres are accessed, like single or multiple register(s)
read/write or setting/clearing only bits.

---
Changes in v4:
- dt-bindings: make avdd-supply mandatory.
- Replace wildcard names with ads7138 or ADS7138 respectively.
- Improve code style (add comments, indentation, placing of brackets,
  helper struct for dev)
- Rename _setclear_bit() and use it for single writes.
- Use DEFINE_RUNTIME_DEV_PM_OPS.
- Make avdd mandatory and verify it's not a stub.
- Link to v3: https://lore.kernel.org/r/20250206-adc_ml-v3-0-1d0bd3483aa2@softing.com

Changes in v3:
- Make interrupt optional.
- Replace SET_RUNTIME_PM_OPS() with RUNTIME_PM_OPS() to prevent warning.
- Rework read_avail for sampling frequency to show each frequency only
  once.
- Use IIO_CHAN_INFO_PEAK and IIO_CHAN_INFO_TROUGH instead of ext_info.
- Link to v2: https://lore.kernel.org/r/20250203-adc_ml-v2-0-8a597660c395@softing.com

Changes in v2:
- Improved commit messages.
- dt-bindings: drop info about what driver supports, make 'avdd-supply'
  optional.
- General rework of driver regarding indentation and code style.
- General code improvements to make code shorter and improve
  readability, like remove 'goto's, order of declarations, ...
- Use kernel macros and functions, like FIELD_*, guard(), ...
- Rework i2c functions to return 0 in case of success and use
  i2c_master_send() if possible.
- Use struct for chip data instead of enum.
- Add comment to what the lock is used for and make sure it's used in
  these cases.
- Use read_avail of iio_info and extend to return also the available
  values for OSR.
- Rework to only accept values of the availability list.
- Use devm_* if possible and therefore drop 'remove' callback.
- Rebase to kernel 6.13 and adjust to API changes.
- Link to v1:
  https://lore.kernel.org/r/20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com

Changes in v1 (to patch series without b4):
- dt-bindings: Extended description

Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>

---
Tobias Sperling (2):
      dt-bindings: iio: adc: Introduce ADS7138
      iio: adc: Add driver for ADS7128 / ADS7138

 .../devicetree/bindings/iio/adc/ti,ads7138.yaml    |  63 ++
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads7138.c                       | 749 +++++++++++++++++++++
 4 files changed, 823 insertions(+)
---
base-commit: 05dbaf8dd8bf537d4b4eb3115ab42a5fb40ff1f5
change-id: 20241122-adc_ml-d1ce86e85b2c

Best regards,
-- 
Tobias Sperling <tobias.sperling@softing.com>



