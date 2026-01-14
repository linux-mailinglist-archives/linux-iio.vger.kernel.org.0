Return-Path: <linux-iio+bounces-27724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5A7D1D89F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67BA5300D155
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479C7387376;
	Wed, 14 Jan 2026 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HYNmUVKC"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFE218AAD;
	Wed, 14 Jan 2026 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382871; cv=none; b=DwNDuvPgaoDUWHo5g21vYQyCAvQDFwzoMklGDBAyJO43fGf1olpZcSXPcQ2GdSt9EivEkN6/LpywIZ2WlVrTbKy7w5GuhOu9cbTtlivnfVTaUhF/racrSQ8/EQn1nm/l48M78N17uoN2eiOpCfWd46TvU6whgY/pkBsNqPlRqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382871; c=relaxed/simple;
	bh=XtUJiuVIwg/5kGbgUuXB+lEzMt+s3zrFy2/bmJ+YGyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTLwd/fTtwTZtBGU1ZUZXLZT5efVBZis0GOcxWDQNY3+xfTDTCBvVQWCiCgfqNDnxMqTtgDumYD0nuzlZ0wwrY63HTF8ux0tM3lABf+3kVKCMboPXL7ttH52UedNvX3vAQ9LYHDcsLDWzDDPU3MlELF4IdVTwqe6Mi5/Z8Blmek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HYNmUVKC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768382867;
	bh=XtUJiuVIwg/5kGbgUuXB+lEzMt+s3zrFy2/bmJ+YGyE=;
	h=From:To:Cc:Subject:Date:From;
	b=HYNmUVKCn8xgcXuzM2wtm2VoVoWg9BsLM5/WyJdwUJY4AAiVDO0OFi3oeKcygvHSg
	 YNcqJWkG/zl+qKVSLG4sY+Fn/JKp2Yc4E6YuaMHUhVg9FjFdCD9SeuI+pAOPc4ORZ+
	 gDcIR3D5YfUmt6PqTf56oF+yUXeNqQQStphFbEF/WG4+x/P+TtKpsGWO4MWgdQgRmW
	 KayRtTn5hu3TE/QaJIQ/6+EZ+nHVVMaQui28nm7Z9knCtKRz9N9QZ7NQdODxyh64QG
	 dP3n5riKIpPw/V2vxVAEjvzI/gq02qNHQMLLvIT3uK5MOeIK6oaI4z+7aqKuS1Kuv6
	 07tKKSauTSzNg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C671E17E13C3;
	Wed, 14 Jan 2026 10:27:46 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	neil.armstrong@linaro.org,
	sre@kernel.org,
	sboyd@kernel.org,
	angelogioacchino.delregno@collabora.com,
	krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com,
	quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com,
	abelvesa@kernel.org,
	luca.weiss@fairphone.com,
	konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com,
	krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v8 00/10] SPMI: Implement sub-devices and migrate drivers
Date: Wed, 14 Jan 2026 10:27:32 +0100
Message-ID: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v8:
 - Renamed *res to *sub_sdev in devm_spmi_subdevice_remove() (Andy)
 - Changed kerneldoc wording to "error pointer" for function
   spmi_subdevice_alloc_and_add() (Andy)
 - Shuffled around some assignments in spmi_subdevice_alloc_and_add() (Andy)
 - Used device_property_read_u32() instead of of_property_read_u32()
   in all of the migrated drivers (Andy)
 - Changed .max_register field in all of the migrated drivers from
   0x100 to 0xff (Andy)
 - Kept `sta1` declaration in reversed xmas tree order in function
   iadc_poll_wait_eoc() of qcom-spmi-iadc.c (Andy)

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
  spmi: Remove redundant dev_name() print in spmi_device_add()
  spmi: Print error status with %pe format
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
 drivers/nvmem/qcom-spmi-sdam.c                |  38 ++++--
 drivers/phy/qualcomm/Kconfig                  |   2 +
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    |  55 +++++----
 drivers/power/reset/qcom-pon.c                |  33 ++++--
 drivers/spmi/spmi-devres.c                    |  24 ++++
 drivers/spmi/spmi.c                           |  95 +++++++++++++--
 include/linux/spmi.h                          |  16 +++
 11 files changed, 290 insertions(+), 123 deletions(-)

-- 
2.52.0


