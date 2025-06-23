Return-Path: <linux-iio+bounces-20902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67DCAE3EDF
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 14:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B64D7A86F8
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC1E24C06A;
	Mon, 23 Jun 2025 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p7C/I3vr"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BBE24BBFD;
	Mon, 23 Jun 2025 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680036; cv=none; b=ECwNs4FNG/i8zCLS4EE0okMe40sGGTjXKrcOXu33AHDRVQj9ycpoXIpevz/TyVRHZIC+zKDYqtn3q071kgble2JURzDsLVMXl5WLr7eYUD9sd0KTuyCrSHu1vlWLH+kTMqQIPWHzw6c8AmNhsw7UCzLl3mY55Lq2PpNemyvpcf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680036; c=relaxed/simple;
	bh=vqC7/dRRuxXVceTiV50u4w8iI0r3/QlUaKmPz+SGA8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QoyFtmsy67hlVTUzFrcIyaNjL1R04Wzyjc0iLRcTVPt+MrDXEbbxc5YbEbDLsdcBNePoLfdW3ATxTcUpN4WUVTJvXRglWwHv34oBCHUkjeKxfLwXvVkbjQvoQtKBSrTyhXWs2un40oM3XnG8vxvP+1JGWQX4yAZ8Lm3D114YYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p7C/I3vr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680032;
	bh=vqC7/dRRuxXVceTiV50u4w8iI0r3/QlUaKmPz+SGA8Q=;
	h=From:To:Cc:Subject:Date:From;
	b=p7C/I3vr2J3F3BOlwxg1ReMlMIP9LHJ6TB/fgQvphplPRizhTXKZDJtcP2Mwzcmf3
	 h9M3+4IrjTZxRdz4nVhhYEAKACsUEqPWkfNvKEwi0bmbTh1KgEwyZR9scW5Mqiw7ZH
	 7N098cIHQkV4UDetR2Z+YtYRJFNc97QZ7dB+bPm1ME6vNMf9IX30b1nv3E2nKrW9rn
	 3GodcVlcpNxmn4UD3GFhsq70OUDN50JyXi4xqdLLlJjh0R0gz3K6BtpCkn6DO/5yga
	 I9iFYvNPPPJDTyKktmr45wjDANsIvHYaygX48fIAj/Kk2p7PG60C6CHi8qWk8qIFHn
	 I/VwwdipEFaXw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CACA417E0342;
	Mon, 23 Jun 2025 14:00:31 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 0/5] iio: Add support for MT6363/6373 Auxiliary ADC
Date: Mon, 23 Jun 2025 14:00:23 +0200
Message-ID: <20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the Auxiliary ADC IP found on the new
MediaTek MT6363 and MT6373 PMICs, found on board designs featuring
the MT8196 Chromebook SoC or the MT6991 Dimensity 9400 Smartphone SoC.

AngeloGioacchino Del Regno (5):
  dt-bindings: iio: adc: mt6359: Add bindings for MT6363 PMIC AuxADC
  dt-bindings: iio: adc: mt6359: Add bindings for MT6373 PMIC AuxADC
  iio: adc: mt6359: Add ready register index and mask to channel data
  iio: adc: mt6359: Add support for MediaTek MT6363 PMIC AUXADC
  iio: adc: mt6359: Add support for MediaTek MT6373 PMIC AUXADC

 .../iio/adc/mediatek,mt6359-auxadc.yaml       |   2 +
 drivers/iio/adc/mt6359-auxadc.c               | 401 ++++++++++++++----
 .../iio/adc/mediatek,mt6363-auxadc.h          |  24 ++
 .../iio/adc/mediatek,mt6373-auxadc.h          |  19 +
 4 files changed, 374 insertions(+), 72 deletions(-)
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6363-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h

-- 
2.49.0


