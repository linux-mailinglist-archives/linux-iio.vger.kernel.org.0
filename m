Return-Path: <linux-iio+bounces-21795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C9DB0BE2D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 09:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA1D7A6446
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 07:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169972853EE;
	Mon, 21 Jul 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q7KURRWR"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654EA1DE4E0;
	Mon, 21 Jul 2025 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084543; cv=none; b=g+++sLqTddGbelgAuaojANeMD23K+KacXWGY9j6Z5kNE5vcpIInU2ljpyxdRy39678NDaJGc4f/6yGFAVxqi0JkWSKFQFKIXFyYWIZHyRLaHnT2YxGv28ThdIyTKwhhMEpbyHO4FMMN3YbDmKcu2NKA1x6IkxkdctEfC3F7BhoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084543; c=relaxed/simple;
	bh=GrfETabKicOHH6Ijk0RwGdn2FVB1Ymrye6zylz3rMCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DS4ZoqiT2tv4K0l/O/fT42zveuOELmyVf1biT7xon7H3rydP0uKjsqTTL/6wxhu1KO52lk0Pc92XhExIb0PD7pv85HwrwkigifqR0pe5Bxzb/1U7/zrIPDZkKU+8NNEoHHyeZn/L/u+z3ydPKqpLr+Z+EttL3p7fIWdB+rlY9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q7KURRWR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753084539;
	bh=GrfETabKicOHH6Ijk0RwGdn2FVB1Ymrye6zylz3rMCE=;
	h=From:To:Cc:Subject:Date:From;
	b=Q7KURRWR6robrgIITwu3GCAk3m5+egkqi2QIT4ZjN3WMH6sOuf9DlGL1VzKRLx6fS
	 W8jJ3Znb2/tuWPSBA2/83SbOsSeKdq2AM4SDWoy3N6bN1qyQFPdhz+aWULAqo4nKiz
	 3BxGeEvulcTBKrd082qhDNNcfbUUTG1Od7Mmh81+LI9AoA69J9vZVqNpO1HgBmDGyl
	 AaQXVRueoLqqCM9z9VpKX47sM9LmO3F2J0BmCFORiaIS1CjXfZXVaD691C9Tvd2Aq+
	 dV6p7n3MK+ib43LIHTM7lmTZkLuHhQWFKUKDl0TLAC98NLgqnyGNUiHRA2EcFsDA8q
	 gMWzrRCS3BCjw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3B30F17E0F43;
	Mon, 21 Jul 2025 09:55:38 +0200 (CEST)
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
	wenst@chromium.org
Subject: [PATCH v1 0/7] SPMI: Implement sub-devices and migrate drivers
Date: Mon, 21 Jul 2025 09:55:18 +0200
Message-ID: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

AngeloGioacchino Del Regno (7):
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
 drivers/misc/qcom-coincell.c                  |  37 ++++--
 drivers/nvmem/qcom-spmi-sdam.c                |  41 +++++--
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    |  45 +++++---
 drivers/power/reset/qcom-pon.c                |  33 ++++--
 drivers/spmi/spmi-devres.c                    |  23 ++++
 drivers/spmi/spmi.c                           |  75 ++++++++++++
 include/linux/spmi.h                          |  16 +++
 8 files changed, 272 insertions(+), 107 deletions(-)

-- 
2.50.1


