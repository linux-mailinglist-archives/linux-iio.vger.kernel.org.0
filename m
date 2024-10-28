Return-Path: <linux-iio+bounces-11529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5999B3D48
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 23:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49BE1F23084
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 22:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B7A20124E;
	Mon, 28 Oct 2024 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="Qn0/X6xO";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="GeUJPRDY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D11EE026;
	Mon, 28 Oct 2024 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.34.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152414; cv=none; b=HOoDGQYycqJrcjJDVgfJ2cLB3K4GFGTHws8vLy2HuZRqNc2Zq4RDtSsxFtNY9qhBlLvtD4ARDFMb6FUcZJCksuCEdK0u+txoCNzBY3eRayHTl6nVVCrDYpjStrzWgOPx3ZgGpSvDifTyvTxSYox3DoHlplGmrlrwKXcmVMkA0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152414; c=relaxed/simple;
	bh=jfWQ+74Cn3YzM41SNakv42pmgAuveMyk8e6tyTlA21g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ax9g12JX+3d9OG5wWQzmCBkh2JeqDXmEq4w5EvDGVUmIOP8iCBhUFImoS9kfG1F34LyxHCQtFQdtDuaeWw9DYXm7GPBwEgPVNCK8FKAlve0mt1H8Mq4e3creL/UReNTPP4NLknGiIrsaajoDuQCtcQKMdcGeKV628QOPiZ1BXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=Qn0/X6xO; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=GeUJPRDY; arc=none smtp.client-ip=195.201.34.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
	by kernel-space.org (OpenSMTPD) with ESMTP id c62766c0;
	Mon, 28 Oct 2024 21:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=from
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=s1; bh=iBu2nqJ+7pcNkwlePiJrM
	6dCpbk=; b=Qn0/X6xOdWL2VthQBsdt7N/s0tJweJfv6LS1Yff8g1DIGWa7mdL25
	2gIm3qa55tZMLeY7Ey4STrwu/LyqnVtAjqbRJmKsbuqjnE1Ga1zNsPsFN0kLh83J
	EpJL6uIDXuwqi3+zaFIoxaZB19SftCYrtJBaafC9AN9pX8wTx6082Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=from
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; q=dns; s=s1; b=W3qGHfxGFXjn9f2
	WjrfAC5DKQAcBi1/tPCeijuY6yflHZNliWDAgABkovCz0f6Rnzo5HhZkb3eizHWI
	gOZciQhCRc6Uw/Ac6V6RXwnTVR2axCYsSWDuU3zxr28zld8HO4Uz4DjVuEt6smck
	1IqREc5eUPyA1V7cCJMaJf6ANBP0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1730151471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aPml767mYe37WptDJOb/jG1/QTjLd7xBx2l8yEbtWIc=;
	b=GeUJPRDYKRscLOFh+psNkm1khPYVTUi+wi/lTUZZP+teKt0Bj65AGBfat5jc7F2vKuofmu
	X/hdfKjHDIYcSyXZHdcPjwvdcYD0Z9fj27GJVibDvWmolxDspuyu+9MiWVFHqGm4zYAYbr
	opimS96t+rL7NBziacEHJ+r3fUns64o=
Received: from [127.0.1.1] (host-95-245-34-85.retail.telecomitalia.it [95.245.34.85])
	by kernel-space.org (OpenSMTPD) with ESMTPSA id dce36722 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 21:37:51 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v9 0/8] iio: add support for the ad3552r AXI DAC IP
Date: Mon, 28 Oct 2024 22:45:27 +0100
Message-Id: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPcFIGcC/x3NQQqDMBBG4avIrB2I0RDTq0gX0Uz1hxIlESuId
 zd0+W3euyhLgmR6VRclOZCxxgJXVzQtPs7CCMWkle4apXv+YePxyz60xujE/gQfioGVd8k74sw
 2TI1rO2WsdVQ6W5IPzv9jeN/3A9lKpBxzAAAA
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1

Purpose is to add ad3552r AXI DAC (fpga-based) support.

The "ad3552r" AXI IP, a variant of the generic "DAC" AXI IP,
has been created to reach the maximum speed (33MUPS) supported
from the ad3552r. To obtain the maximum transfer rate, a custom
IP core module has been implemented with a QSPI interface with
DDR (Double Data Rate) mode.

The design is actually using the DAC backend since the register
map is the same of the generic DAC IP, except for some customized
bitfields. For this reason, a new "compatible" has been added
in adi-axi-dac.c.

Also, backend has been extended with all the needed functions
for this use case, keeping the names gneric.

The following patch is actually applying to linux-iio/testing.

---
Changes in v2:
- use unsigned int on bus_reg_read/write
- add a compatible in axi-dac backend for the ad3552r DAC IP
- minor code alignment fixes
- fix a return value not checked
- change devicetree structure setting ad3552r-axi as a backend
  subnode
- add synchronous_mode_available in the ABI doc

Changes in v3:
- changing AXI backend approach using a dac ip compatible
- fdt bindings updates accordingly
- fdt, ad3552r device must be a subnode of the backend
- allow probe of child devices
- passing QSPI bus access function by platform data
- move synchronous mode as a fdt parameter
- reorganizing defines in proper patches
- fix make dt_binding_check errors
- fix ad3552r maximum SPI speed
- fix samplerate calulcation
- minor code style fixes

Changes in v4:
- fix Kconfig
- fix backend documentation
- driver renamed to a more gneric "high speed" (ad3552r-hs)
- restyled axi-dac register names
- removed synchronous support, dead code
  (could be added in the future with David sugestions if needed)
- renaming backend buffer enable/disable calls
- using model_data in common code
- using devm_add_action_or_reset
- minor code style fixes

Changes in v5:
- patch 2/11 set before fix of ADI_DAC_R1_MODE patch
- fix dt binding check error
- patch 4/11 removed
- fix stream enable/disable call names
- fix axi-dac clock names
- fix axi-dac platform device unregistering
- minor code style fixes

Changes in v6:
- remove patches (fixes) already accepted
- move platform data include in drivers/iio/dac dir
- minor notes added to commit description
- fix axi-dac platform child-device creation
- minor code style fixes

Changes in v7:
- add per channel offset and scale
- change dac clock rate considering always buffering and DDR 
- fix axi-dac fdt property conditionals 
- fix getting clocks from high-speed driver, with a NULL as fallback
- fix missing dma buffer free callback
- minor code style fixes

Changes in v8:
- getting sclk from platform data
- fix axi-dac yaml bindings
- fix reset logic to active-low
- remove dev_err_probe messages from gain/offset calc
- minor code style fixes

Changes in v9:
- add locking to axi dac reg_read/write
- fix dac Kconfig to have a separate common library
- minor code style fixes

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>

---
Angelo Dureghello (8):
      dt-bindings: iio: dac: ad3552r: add iio backend support
      dt-bindings: iio: dac: adi-axi-dac: add ad3552r axi variant
      iio: backend: extend features
      iio: dac: adi-axi-dac: extend features
      iio: dac: ad3552r: changes to use FIELD_PREP
      iio: dac: ad3552r: extract common code (no changes in behavior intended)
      iio: dac: ad3552r: add high-speed platform driver
      iio: dac: adi-axi-dac: add registering of child fdt node

 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |   7 +
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |  69 ++-
 drivers/iio/dac/Kconfig                            |  19 +
 drivers/iio/dac/Makefile                           |   2 +
 drivers/iio/dac/ad3552r-common.c                   | 249 +++++++++
 drivers/iio/dac/ad3552r-hs.c                       | 529 +++++++++++++++++++
 drivers/iio/dac/ad3552r-hs.h                       |  19 +
 drivers/iio/dac/ad3552r.c                          | 557 +++------------------
 drivers/iio/dac/ad3552r.h                          | 228 +++++++++
 drivers/iio/dac/adi-axi-dac.c                      | 312 +++++++++++-
 drivers/iio/industrialio-backend.c                 |  78 +++
 include/linux/iio/backend.h                        |  17 +
 12 files changed, 1585 insertions(+), 501 deletions(-)
---
base-commit: e469c6c036907dec25c3979f527a102e44d6f9b8
change-id: 20241028-wip-bl-ad3552r-axi-v0-iio-testing-7dc193405779

Best regards,
-- 
Angelo Dureghello <angelo@kernel-space.org>


