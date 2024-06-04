Return-Path: <linux-iio+bounces-5751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 248B18FB232
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 14:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E799B233C5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F073146010;
	Tue,  4 Jun 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4InVuIeo"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600B62A8D0;
	Tue,  4 Jun 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504217; cv=none; b=ZMY/ZPcxUownH8J54PlpRuc0M6o5sI3duxsJZnMYZuiH8CzFWBhkuZ8f+/p8xeJR1EbiGRca8NGuiLCKhT930Uzst+9+lKlRZsQ5bDtx1unDlLz7Opdag/gN6cHBACDEOYCfASQ0Jhi+rGp1abTvfyTqdSeha0Y887tv/KUeQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504217; c=relaxed/simple;
	bh=ZUDxZH6b1ygH/V49EHxPNI3d82Oqfct1eSSEha90afY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGd+MlS8Pc3FlDBp7fD094pP2tGDRg7QpPop8HOeSFz/QXC6h2MnwpqOmvEHNbbp9N4p9mm/1bxHZ1qQ887VWdPEwknAaAPgfD4J0Kk4b0DaZdgcbCSUQT9BExzA16jw8b9/8495E+uN+LwFOxWZnKPgs5J4sftB+TU/36OLdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4InVuIeo; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717504214;
	bh=ZUDxZH6b1ygH/V49EHxPNI3d82Oqfct1eSSEha90afY=;
	h=From:To:Cc:Subject:Date:From;
	b=4InVuIeo8s72ZzYmxD4Df+dgx53nCkCjPMrV5VNIIGgCgrEsDrjRO/RLEdW511728
	 z5nopx+bTObSHkaUxrQDo+Mjh99rapR9uAo09Apb2LLyhj7ZgRt/u22iFdYSIXrm1D
	 Goer3FOMW4waeOrG0ju2YdQ9GfAVdNGBQefItg4qnZZ4NMei3V0yaziQvKCET47+nB
	 yUq3MdghJAMaO4RYRuxFZBmdL4GtijZDcaCD9eGIm/1PwfQX7JSQU4L3Hf3C2V5k34
	 exVVOPT+Kqj1lyJ5os1cReibIjuUq8NKD0+RSKNbBEqNAJVxBAzmjyWAZUHsdyrnh3
	 6PH9rugdkBHHg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F0058378214D;
	Tue,  4 Jun 2024 12:30:12 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lee@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	marius.cristea@microchip.com,
	marcelo.schmitt@analog.com,
	fr0st61te@gmail.com,
	mitrutzceclan@gmail.com,
	mike.looijmans@topic.nl,
	marcus.folkesson@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	andy.shevchenko@gmail.com,
	kernel@collabora.com
Subject: [PATCH v2 0/5] MediaTek MT6357/8/9 PMIC Auxiliary ADC support
Date: Tue,  4 Jun 2024 14:30:03 +0200
Message-ID: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Dropped 'mfd: mt6397-core: Add support for AUXADCs on MT6357/58/59 PMICs'
   as Lee J already applied it;
 - Added patch to describe the ADC subnode in the MT6357 MFD binding
   and moved the example node from mediatek,mt6359-auxadc.yaml to
   mediatek,mt6357.yaml
 - Added 8-bits {s8,u8}_fract to math.h
 - Addressed reviewer comments on mt6359-auxadc driver

AngeloGioacchino Del Regno (5):
  dt-bindings: iio: adc: Add MediaTek MT6359 PMIC AUXADC
  dt-bindings: mfd: mediatek,mt6357: Describe Auxiliary ADC subdev
  math.h: Add unsigned 8 bits fractional numbers type
  iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC
  arm64: dts: mediatek: Add ADC node on MT6357, MT6358, MT6359 PMICs

 .../iio/adc/mediatek,mt6359-auxadc.yaml       |  33 +
 .../bindings/mfd/mediatek,mt6357.yaml         |  10 +
 arch/arm64/boot/dts/mediatek/mt6357.dtsi      |   5 +
 arch/arm64/boot/dts/mediatek/mt6358.dtsi      |   5 +
 arch/arm64/boot/dts/mediatek/mt6359.dtsi      |   5 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/mt6359-auxadc.c               | 606 ++++++++++++++++++
 .../iio/adc/mediatek,mt6357-auxadc.h          |  21 +
 .../iio/adc/mediatek,mt6358-auxadc.h          |  22 +
 .../iio/adc/mediatek,mt6359-auxadc.h          |  22 +
 include/linux/math.h                          |   2 +
 12 files changed, 744 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
 create mode 100644 drivers/iio/adc/mt6359-auxadc.c
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h

-- 
2.45.1


