Return-Path: <linux-iio+bounces-16810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B597A60A76
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 08:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47646189F8A2
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C5F188722;
	Fri, 14 Mar 2025 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hy20dZ12"
X-Original-To: linux-iio@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668B98632B;
	Fri, 14 Mar 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938914; cv=none; b=rwMJ5CMjPqvLOJ4ZAtYdBBgEtJhFK3cexXhJT8Cl6aQVUvoI83vnpoPf1K6zH2l/9DddTk1Bv3GQj1Ha4Yo2oycMxRm8CcdQ2NUdUsQFObS7OtmegbK37rW/x9LZrUElMXR4yERuGkkTj/aS8qkViGBHtGzc1Rl7ojjki+oqOuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938914; c=relaxed/simple;
	bh=GQ9oEWF3jKsUH3Bk0sYyk/YC7PEh//u90VNBcdbv9xQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tQlfp6ENkp9l5JxxHpXmcmK/2+CA9ttGHXJdGa00udhnepwaUp8u73vN6yZr2rgM4JlMtLLnUminW1EbhE2BDUdA7tfiJX4o/yM4gU5Z6dbv8kaxWf7kjHEazlWGTPPqdKV3uEYC2JONH7vT5Keux8guqD/MJplc6XnQrH0iyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hy20dZ12; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a3654fac00a911f08eb9c36241bbb6fb-20250314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QB5LQt7bpy+JzNLqAPOMyuAUrCHcw7EYGy1OQwsiSpg=;
	b=hy20dZ12n6HxyTDC8HNU+Izo+m6Fm3uMa6gjFBmAdBPOgjyXiWR+v/mGLvKcYRrjGMuRKhlzzufy+npPEK/z6ZZ3lGfzjiBPYE6MLBZZOe7rBk6g9yNZ/sw2F8pnHmuTbLMPiHYxpnrmy0qZFQebLukqZcn0Uut0U1f/tQarTiY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:6b762402-57f0-4d3d-8270-952e89173559,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:a8be55c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a3654fac00a911f08eb9c36241bbb6fb-20250314
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <lu.tang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1887658453; Fri, 14 Mar 2025 15:55:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Mar 2025 15:55:02 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Mar 2025 15:55:01 +0800
From: Lu.Tang <Lu.Tang@mediatek.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Stephen Boyd
	<sboyd@kernel.org>, Chen Zhong <chen.zhong@mediatek.com>, Sen Chu
	<shen.chu@mediatek.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-gpio@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Lu.Tang
	<Lu.Tang@mediatek.com>
Subject: [PATCH 0/5] Add PMIC and SPMI driver for mt8196
Date: Fri, 14 Mar 2025 15:32:26 +0800
Message-ID: <20250314073307.25092-1-Lu.Tang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series is based on linux-next.

Changes in v0:
- Modify SPMI driver for mt8196
- Add SPMI PMIC mfd driver
- Add PMIC regulator driver for mt8196

*** BLURB HERE ***

Lu.Tang (5):
  pmic: mediatek: Add pmic auxadc driver
  pmic: mediatek: Add pmic regulator driver
  pmic: mediatek: Add spmi pmic mfd driver
  spmi: mediatek: modify spmi dirver for mt8196
  dt-bindings: pmic: mediatek: Add pmic documents

 .../iio/adc/mediatek,spmi-pmic-auxadc.yaml    |   31 +
 .../bindings/input/mediatek,pmic-keys.yaml    |    1 +
 .../bindings/mfd/mediatek,mt6685.yaml         |   50 +
 .../bindings/mfd/mediatek,spmi-pmic.yaml      |  173 +++
 .../pinctrl/mediatek,mt65xx-pinctrl.yaml      |    1 +
 drivers/iio/adc/Kconfig                       |   10 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/mtk-spmi-pmic-adc.c           |  576 +++++++++
 drivers/mfd/Kconfig                           |   26 +
 drivers/mfd/Makefile                          |    2 +
 drivers/mfd/mt6685-core.c                     |   83 ++
 drivers/mfd/mtk-spmi-pmic.c                   |  518 ++++++++
 drivers/regulator/Kconfig                     |   34 +
 drivers/regulator/Makefile                    |    3 +
 drivers/regulator/mt6316-regulator.c          |  381 ++++++
 drivers/regulator/mt6363-regulator.c          | 1106 +++++++++++++++++
 drivers/regulator/mt6373-regulator.c          |  826 ++++++++++++
 drivers/spmi/spmi-mtk-pmif.c                  | 1040 +++++++++++++++-
 include/linux/mfd/mt6363/core.h               |  134 ++
 include/linux/mfd/mt6363/registers.h          |  168 +++
 include/linux/mfd/mt6373/core.h               |   94 ++
 include/linux/mfd/mt6373/registers.h          |   53 +
 include/linux/regulator/mt6316-regulator.h    |   48 +
 include/linux/regulator/mt6363-regulator.h    |  424 +++++++
 include/linux/regulator/mt6373-regulator.h    |  318 +++++
 25 files changed, 6037 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,spmi-pmic-auxadc.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6685.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.yaml
 create mode 100644 drivers/iio/adc/mtk-spmi-pmic-adc.c
 create mode 100644 drivers/mfd/mt6685-core.c
 create mode 100644 drivers/mfd/mtk-spmi-pmic.c
 create mode 100644 drivers/regulator/mt6316-regulator.c
 create mode 100644 drivers/regulator/mt6363-regulator.c
 create mode 100644 drivers/regulator/mt6373-regulator.c
 create mode 100644 include/linux/mfd/mt6363/core.h
 create mode 100644 include/linux/mfd/mt6363/registers.h
 create mode 100644 include/linux/mfd/mt6373/core.h
 create mode 100644 include/linux/mfd/mt6373/registers.h
 create mode 100644 include/linux/regulator/mt6316-regulator.h
 create mode 100644 include/linux/regulator/mt6363-regulator.h
 create mode 100644 include/linux/regulator/mt6373-regulator.h

-- 
2.46.0


