Return-Path: <linux-iio+bounces-5487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862708D489D
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 11:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3133B1F24481
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830D874043;
	Thu, 30 May 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4IOp5nkE"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22B16F30E;
	Thu, 30 May 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061667; cv=none; b=L+zZVYvPb2vQOaRu6YInFeGTfGVuI5/ePLDm7dEgXY+A80YRX9ZWrydj5pYkhL3oDhFMsiX5pHn83bMo4jACnFUPpo+ArLnCnT5B1NhaeH4eVD6uY4nXUhcvexfHWLntWbCa8m7AAsywJv0dw2CVIcgg48aiB5mgttJNv/4xr0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061667; c=relaxed/simple;
	bh=8ZQGTCGcyaej3NAULCSUI7HXuYKHb/3VdfI4eWGwi3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UOiAmlBPs+gr32XmT91A+tXnt76SjxgTUC4E6i3poJ3s7Fw1iAnqJL9E+NK5TRk5B7U4SPFOmnVTTz+AgPVyiSTsPxijVQQytU4tkutt0B6dsKQ+WKjYI/l012umeaQAspw4xg4jmbzueQ56EI4UsS3Ny4upXAIJeJSLRG8S9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4IOp5nkE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717061663;
	bh=8ZQGTCGcyaej3NAULCSUI7HXuYKHb/3VdfI4eWGwi3k=;
	h=From:To:Cc:Subject:Date:From;
	b=4IOp5nkEGFtLNSOZG0xMpT8cqoH5Sf5dX+TlDIk/7s2JkAVhbtHaQrPuXewcNhh0w
	 kn+E+QTCioX1cHuXpdOxBOY3saNvT444FLkSUaKnFsD2u73MrbjF3cV/Eyq0PjG8sy
	 PQqOI0z7U6rqRZP9myveNpu1H9b9oXYUpIB4REIgNOGjYIE1NcLNMtmKhSHHlitmC9
	 NYYicYZGYBwC1Qapst0KOgN19AMMsYKDNvQiKGY65HA3JzsPHmo3nxPkxEmy0qeZMw
	 yrllIsYMOio5xKx9V0B9D5dQMlRL8YRD/A3ib05c5EhGfkju73C5rVuJ6pp7djqMhX
	 rvVlZl45PqByw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4E7FB3782196;
	Thu, 30 May 2024 09:34:22 +0000 (UTC)
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
	kernel@collabora.com
Subject: [PATCH v1 0/4] MediaTek MT6357/8/9 PMIC Auxiliary ADC support
Date: Thu, 30 May 2024 11:34:06 +0200
Message-ID: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the Auxiliary ADC IP found on the MediaTek
MT635(x) PMICs, including MT6357, 6358 and 6359, exposing various ADC
channels for accessory detection (usually, on 3.5mm jack), battery
voltage, PMIC temperature, PMIC-integrated voltage regulators, and
others, depending on the PMIC model.

AngeloGioacchino Del Regno (4):
  dt-bindings: iio: adc: Add MediaTek MT6359 PMIC AUXADC
  iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC
  mfd: mt6397-core: Add support for AUXADCs on MT6357/58/59 PMICs
  arm64: dts: mediatek: Add ADC node on MT6357, MT6358, MT6359 PMICs

 .../iio/adc/mediatek,mt6359-auxadc.yaml       |  43 ++
 arch/arm64/boot/dts/mediatek/mt6357.dtsi      |   5 +
 arch/arm64/boot/dts/mediatek/mt6358.dtsi      |   5 +
 arch/arm64/boot/dts/mediatek/mt6359.dtsi      |   5 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/mt6359-auxadc.c               | 598 ++++++++++++++++++
 drivers/mfd/mt6397-core.c                     |  10 +
 .../iio/adc/mediatek,mt6357-auxadc.h          |  21 +
 .../iio/adc/mediatek,mt6358-auxadc.h          |  22 +
 .../iio/adc/mediatek,mt6359-auxadc.h          |  22 +
 11 files changed, 744 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
 create mode 100644 drivers/iio/adc/mt6359-auxadc.c
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h

-- 
2.45.1


