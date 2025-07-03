Return-Path: <linux-iio+bounces-21298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4716DAF76E1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF5B188F9AE
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655B413D8A4;
	Thu,  3 Jul 2025 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R0L2jmeC"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C8126C03;
	Thu,  3 Jul 2025 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551913; cv=none; b=Ruo8XWLVQGR9eFZxc2Kpd5LjpMFe/9c8DZqXhth3FPVLMrPRwIXPh+ftrIOIX4PyD8xkCgA/0qJqCp05E/AaB01N+m/cWYH1/uESTTvdy0M9GS8TLPDKqGeacStKAhhKl8hdgN7fiL4JsR6pqR+bxsKXL4xT4FBcUO1gGcfFOhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551913; c=relaxed/simple;
	bh=qNbhqJeNbhpXv1o7b2f0VNuXEeUdtZei3EuXHU8wbYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sUvNQxktRIM+pqlrgtdJSDXTXsadF70UHzHl5nlaZDLHj+Ot5DIgdTvp5zv9b+6MVxlNqYdTaUyC4ZCprbR1mZaq631X9rePUAk8qHLOID5RDSTmZAHJAz53dbTkxKZo/zeysBTgaSMth6nKE4goauQg68LEu6En8vALqE3wkPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R0L2jmeC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751551909;
	bh=qNbhqJeNbhpXv1o7b2f0VNuXEeUdtZei3EuXHU8wbYQ=;
	h=From:To:Cc:Subject:Date:From;
	b=R0L2jmeCjUngw0SFHUg0wwmWulgTkrFrxcdEncCutPv1i3/RPMT8zWCNkNNKBuvJG
	 MdS4h6KXRPdfkdeTY5la2J9B06iuyf+P1NNTGClZomMHumPJpPovZmpsIbSd9Jut5a
	 z9TfarWMf0DSx6yV4eU69w9Jxt/3k2yynOg1/WU+urfzm0hbCTqk4v1ZL+GGxP7hLQ
	 GiL1FIUYEQOUkgJE550cvzks1+uvodw8Ml5KdALXURNkxH3OtFOZWM8jR5nuBWmG3c
	 QTFqUrtvsBEnzY2NEwt3rYI/ck2DBWD8n6s/0Nb0s2OqUHpmxAUPvVHDkEs8QIBG4e
	 2gnb9GfBSvzaQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6C06917E0676;
	Thu,  3 Jul 2025 16:11:48 +0200 (CEST)
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
Subject: [PATCH v2 0/6] iio: Add support for MT6363/6373 Auxiliary ADC
Date: Thu,  3 Jul 2025 16:11:40 +0200
Message-ID: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Added error checks to all regmap r/w operations
 - Moved adc_vref addition to different commit
 - Various other fixes

This series adds support for the Auxiliary ADC IP found on the new
MediaTek MT6363 and MT6373 PMICs, found on board designs featuring
the MT8196 Chromebook SoC or the MT6991 Dimensity 9400 Smartphone SoC.

AngeloGioacchino Del Regno (6):
  dt-bindings: iio: adc: mt6359: Add MT6363 PMIC AuxADC
  dt-bindings: iio: adc: mt6359: Add MT6373 PMIC AuxADC
  iio: adc: mt6359: Add ready register index and mask to channel data
  iio: adc: mt6359: Move reference voltage to platform data
  iio: adc: mt6359: Add support for MediaTek MT6363 PMIC AUXADC
  iio: adc: mt6359: Add support for MediaTek MT6373 PMIC AUXADC

 .../iio/adc/mediatek,mt6359-auxadc.yaml       |   2 +
 drivers/iio/adc/mt6359-auxadc.c               | 440 +++++++++++++++---
 .../iio/adc/mediatek,mt6363-auxadc.h          |  24 +
 .../iio/adc/mediatek,mt6373-auxadc.h          |  19 +
 4 files changed, 416 insertions(+), 69 deletions(-)
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6363-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h

-- 
2.49.0


