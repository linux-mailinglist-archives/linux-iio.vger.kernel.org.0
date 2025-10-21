Return-Path: <linux-iio+bounces-25309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E4ABF53E2
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20B43B3416
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 08:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EC03054FB;
	Tue, 21 Oct 2025 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BGgr7ukz"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B979032143A;
	Tue, 21 Oct 2025 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035548; cv=none; b=bvKyppg2UMeVLGAMGvkrm+EE0vLopV+2U2e9diELzhKsaIkLP6Uw7nKgSatJRe4RfEzGGAgP67MnQKBmau6l6KvBNgYHNbbGz2kzgqlm7oPj3//IEjm85krOXA2nXcgcj8L60WxQjj+v8OKANu4EGOCw8o3ZYOVTX2w9Lf6yU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035548; c=relaxed/simple;
	bh=O7s5zys8WMbwKz7fcQlw9ommRaXCrMYh4+PsKEP37tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLA9jFN2NG2Ij9SFYkfQz9csf/kRmwaJN2R5JEWAjHsE1YD6agIpet5E3VFMF188huKOXp4JOWOjkEmf2gHl0aUjlkuwEKD3rGcLDosN6dP1Sq9KxtfliOtm+PK+i0DcIXJxJlo4+g31kmk/wTObiB8QtsFg909L4krMJ336BAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BGgr7ukz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761035542;
	bh=O7s5zys8WMbwKz7fcQlw9ommRaXCrMYh4+PsKEP37tw=;
	h=From:To:Cc:Subject:Date:From;
	b=BGgr7ukzBNqsrUQYpcwod5f+UTdg+AJEuK4tqjkoZhGmT8ixERBPKHDrDj5/oDEIs
	 SHHUxuo9HnAPZh7PpUSLEjiI9Ii7Otg76O/Bj6rvDkhXZjxWNnFyQZaGm/r3enXHkJ
	 Q7ZGglEIvpDbp9QNsf1mqgCePCmoUolyZ9eO32GTUiWT9ePNx2agkTPkf5ixzsz5Df
	 IO6DTbxoL2EMM0vH83/OfstxAQB1hPeHRNgUARJImejgjSCtAK37KTKcKAieN6tQ6L
	 MMfUBlxYCD1pkohL8au2AWsoQd+GIJgBMg7JgGv+wJoywUq+mqIQU+MpDrPI7BLL86
	 SetRqb6Z0xZfA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0234F17E013C;
	Tue, 21 Oct 2025 10:32:21 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	sre@kernel.org,
	krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	wenst@chromium.org,
	casey.connolly@linaro.org
Subject: [PATCH v7 00/10] SPMI: Implement sub-devices and migrate drivers
Date: Tue, 21 Oct 2025 10:32:09 +0200
Message-ID: <20251021083219.17382-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v7:
 - Added commit to cleanup redundant dev_name() in the pre-existing
   spmi_device_add() function
 - Added commit removing unneeded goto and improving spmi_device_add()
   readability by returning error in error path, and explicitly zero
   for success at the end.

Changes in v6:
 - Added commit to convert spmi.c to %pe error format and used
   %pe error format in spmi_subdevice code as wanted by Uwe Kleine-Konig

Changes in v5:
 - Changed dev_err to dev_err_probe in qcom-spmi-sdam (and done
   that even though I disagree - because I wanted this series to
   *exclusively* introduce the minimum required changes to
   migrate to the new API, but okay, whatever....!);
 - Added missing REGMAP dependency in Kconfig for qcom-spmi-sdam,
   phy-qcom-eusb2-repeater and qcom-coincell to resolve build
   issues when the already allowed COMPILE_TEST is enabled
   as pointed out by the test robot's randconfig builds.

Changes in v4:
 - Added selection of REGMAP_SPMI in Kconfig for qcom-coincell and
   for phy-qcom-eusb2-repeater to resolve undefined references when
   compiled with some randconfig

Changes in v3:
 - Fixed importing "SPMI" namespace in spmi-devres.c
 - Removed all instances of defensive programming, as pointed out by
   jic23 and Sebastian
 - Removed explicit casting as pointed out by jic23
 - Moved ida_free call to spmi_subdev_release() and simplified error
   handling in spmi_subdevice_alloc_and_add() as pointed out by jic23

Changes in v2:
 - Fixed missing `sparent` initialization in phy-qcom-eusb2-repeater
 - Changed val_bits to 8 in all Qualcomm drivers to ensure
   compatibility as suggested by Casey
 - Added struct device pointer in all conversion commits as suggested
   by Andy
 - Exported newly introduced functions with a new "SPMI" namespace
   and imported the same in all converted drivers as suggested by Andy
 - Added missing error checking for dev_set_name() call in spmi.c
   as suggested by Andy
 - Added comma to last entry of regmap_config as suggested by Andy

While adding support for newer MediaTek platforms, featuring complex
SPMI PMICs, I've seen that those SPMI-connected chips are internally
divided in various IP blocks, reachable in specific contiguous address
ranges... more or less like a MMIO, but over a slow SPMI bus instead.

I recalled that Qualcomm had something similar... and upon checking a
couple of devicetrees, yeah - indeed it's the same over there.

What I've seen then is a common pattern of reading the "reg" property
from devicetree in a struct member and then either
 A. Wrapping regmap_{read/write/etc}() calls in a function that adds
    the register base with "base + ..register", like it's done with
    writel()/readl() calls; or
 B. Doing the same as A. but without wrapper functions.

Even though that works just fine, in my opinion it's wrong.

The regmap API is way more complex than MMIO-only readl()/writel()
functions for multiple reasons (including supporting multiple busses
like SPMI, of course) - but everyone seemed to forget that regmap
can manage register base offsets transparently and automatically in
its API functions by simply adding a `reg_base` to the regmap_config
structure, which is used for initializing a `struct regmap`.

So, here we go: this series implements the software concept of an SPMI
Sub-Device (which, well, also reflects how Qualcomm and MediaTek's
actual hardware is laid out anyway).

               SPMI Controller
                     |                ______
                     |               /       Sub-Device 1
                     V              /
              SPMI Device (PMIC) ----------- Sub-Device 2
                                    \
                                     \______ Sub-Device 3

As per this implementation, an SPMI Sub-Device can be allocated/created
and added in any driver that implements a... well.. subdevice (!) with
an SPMI "main" device as its parent: this allows to create and finally
to correctly configure a regmap that is specific to the sub-device,
operating on its specific address range and reading, and writing, to
its registers with the regmap API taking care of adding the base address
of a sub-device's registers as per regmap API design.

All of the SPMI Sub-Devices are therefore added as children of the SPMI
Device (usually a PMIC), as communication depends on the PMIC's SPMI bus
to be available (and the PMIC to be up and running, of course).

Summarizing the dependency chain (which is obvious to whoever knows what
is going on with Qualcomm and/or MediaTek SPMI PMICs):
    "SPMI Sub-Device x...N" are children "SPMI Device"
    "SPMI Device" is a child of "SPMI Controller"

(that was just another way to say the same thing as the graph above anyway).

Along with the new SPMI Sub-Device registration functions, I have also
performed a conversion of some Qualcomm SPMI drivers and only where the
actual conversion was trivial.

I haven't included any conversion of more complex Qualcomm SPMI drivers
because I don't have the required bandwidth to do so (and besides, I think,
but haven't exactly verified, that some of those require SoCs that I don't
have for testing anyway).

AngeloGioacchino Del Regno (10):
  spmi: Print error status with %pe format
  spmi: Remove redundant dev_name() print in spmi_device_add()
  spmi: Remove unneeded goto in spmi_device_add() error path
  spmi: Implement spmi_subdevice_alloc_and_add() and devm variant
  nvmem: qcom-spmi-sdam: Migrate to devm_spmi_subdevice_alloc_and_add()
  power: reset: qcom-pon: Migrate to devm_spmi_subdevice_alloc_and_add()
  phy: qualcomm: eusb2-repeater: Migrate to
    devm_spmi_subdevice_alloc_and_add()
  misc: qcom-coincell: Migrate to devm_spmi_subdevice_alloc_and_add()
  iio: adc: qcom-spmi-iadc: Migrate to
    devm_spmi_subdevice_alloc_and_add()
  iio: adc: qcom-spmi-iadc: Remove regmap R/W wrapper functions

 drivers/iio/adc/qcom-spmi-iadc.c              | 109 ++++++++----------
 drivers/misc/Kconfig                          |   2 +
 drivers/misc/qcom-coincell.c                  |  38 ++++--
 drivers/nvmem/Kconfig                         |   1 +
 drivers/nvmem/qcom-spmi-sdam.c                |  36 ++++--
 drivers/phy/qualcomm/Kconfig                  |   2 +
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    |  53 ++++++---
 drivers/power/reset/qcom-pon.c                |  34 ++++--
 drivers/spmi/spmi-devres.c                    |  24 ++++
 drivers/spmi/spmi.c                           |  95 +++++++++++++--
 include/linux/spmi.h                          |  16 +++
 11 files changed, 289 insertions(+), 121 deletions(-)

-- 
2.51.1


