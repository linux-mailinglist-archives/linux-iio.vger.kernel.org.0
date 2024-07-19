Return-Path: <linux-iio+bounces-7713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D85F937BB0
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 19:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9781C2166C
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E680146A8B;
	Fri, 19 Jul 2024 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VamGCtuX"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E351B13BC12;
	Fri, 19 Jul 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721410776; cv=none; b=bZ7n0bx2BZlDS+P6romUh4HhxnVVtJWWSXgQS3mym2/tj0s39yTCsS79nyyrU9XT2p1vmlE2pXuAFiuUMA0vMdfOU8s/o8eUcT2niKYLipqpWIxSNUBel2a9w3+bO46eU87rNT3nZ6DBl13RIR6WUVvmiKHEddT3u38VKeBXRjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721410776; c=relaxed/simple;
	bh=BTUAbqeygS4hB1nVNFGG+GYh6KfJxL5LqC6sD/btiNU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fj84QxWhhrDLd/0LfBKRfqc0C6iyaCSb8/pd/9riKkkbQcy3ZPjHjefvy5Eh000OXuh0C3TBrKsDQ0UoYAEqEXUeJFc7kn3YbiRcWgpzycDipxNGdc4IqVwxKL1cdjzmEUUJHKclvGiGfLAAe8igvAL/G1xRWaTdFJuSzoKxSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VamGCtuX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721410773; x=1752946773;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BTUAbqeygS4hB1nVNFGG+GYh6KfJxL5LqC6sD/btiNU=;
  b=VamGCtuXoWPyGGcpa16C8YZzsKDLm4UyMr5ZrxcYvjuoZPYr+b1bopZS
   PUDn8GlQcQy4StwV+kvn2DsmKkdVRqxtUWdTZ+kKVE/uHDSP5Q2Cju5Ld
   7ujcpeyKvCOVEJB6Dkz68GKmAbSlE8yrePC34v2I23CofYkAOf4N5G0js
   oC+Jkdv3Q1H6Pzcd1zYnt5K99xMQSgNyq75YlmSLaIROY9PwkvmoMzmiK
   BWklbCs6lqJrzCgUlJzeQrhddbuuOhrcH3muwGsYNexRMa3F8Hm1op8oa
   a3wtZUyBhLopazA0LFD6vgBNiRhZQqlRYe32mUeh6KL3rmL6TvavRtIE9
   A==;
X-CSE-ConnectionGUID: 4uEQqijeSImp7ZJVH2TiPg==
X-CSE-MsgGUID: am7mA3YCSnChKZ7881QKOA==
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="196870142"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2024 10:39:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jul 2024 10:39:03 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 19 Jul 2024 10:39:01 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>
CC: <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v1 0/2] adding support for Microchip PAC194X Power Monitor
Date: Fri, 19 Jul 2024 20:38:53 +0300
Message-ID: <20240719173855.53261-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

Adding support for Microchip PAC194X and PAC195X series of Power Monitor with
Accumulator chip family. This driver covers the following part numbers:
 - PAC1941, PAC1941_2, PAC1942, PAC1942_2, PAC1943, PAC1944
 - PAC1951, PAC1951_2, PAC1952, PAC1952_2, PAC1953, PAC1954


Differences related to previous patch:
v1:
- first version committed to review

Marius Cristea (2):
  dt-bindings: iio: adc: adding support for PAC194X
  iio: adc: adding support for PAC194X

 .../ABI/testing/sysfs-bus-iio-adc-pac1944     |    9 +
 .../bindings/iio/adc/microchip,pac1944.yaml   |  168 +
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/pac1944.c                     | 3528 +++++++++++++++++
 6 files changed, 3726 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
 create mode 100644 drivers/iio/adc/pac1944.c

-- 
2.43.0


