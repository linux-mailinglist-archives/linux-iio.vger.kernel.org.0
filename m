Return-Path: <linux-iio+bounces-10964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8859B9AC16D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 10:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC66E1F216FA
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4F215746B;
	Wed, 23 Oct 2024 08:23:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79957155352;
	Wed, 23 Oct 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671831; cv=none; b=WNwo8bzJbULOS++eLzKVozuhNmU+nS/NNlBNgU8EM1HSBPF/LlCHPn/6ZS8KQ/iT4SGEERSyR3PR81vLJNjw/t15GcmSnJMLvyk1LKCDNrd5uXoLtR85rQ6XlZJoGOrYwX//IDBss/9fig0hPZJjppmy9fNY6lghJ53Tl76uDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671831; c=relaxed/simple;
	bh=TQTfw0UeYW9xpwG5wkbPFmdf8GfS0d5AhNkJFfYr3S0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ibGDU+0Uzji4/w5ryG/6g6lBVMCZUmLuBPU8cZOlpvlzwm6DoyUh73bqNE3RDrtSTjZDOm1Dz/AAkrNpjZIQtgbRZ2gpC56Rd2YakJddlf9Na5onbH0dcnq3zQrOizPNwerKaH/kflozlUJfPjGo+MzYRErPOchHQyrDNo6VgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XYMTw4jRXzyTb0;
	Wed, 23 Oct 2024 16:22:12 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 1090A140360;
	Wed, 23 Oct 2024 16:23:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 23 Oct
 2024 16:23:43 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<javier.carrasco.cruz@gmail.com>, <nuno.sa@analog.com>,
	<conor.dooley@microchip.com>, <michael.hennerich@analog.com>,
	<anshulusr@gmail.com>, <sunke@kylinos.cn>, <kimseer.paller@analog.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] iio: Fix build error for ltc2664
Date: Wed, 23 Oct 2024 16:23:09 +0800
Message-ID: <20241023082309.1002917-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200008.china.huawei.com (7.202.181.35)

If REGMAP_SPI is n and LTC2664 is y, the following build error occurs:

	riscv64-unknown-linux-gnu-ld: drivers/iio/dac/ltc2664.o: in function `ltc2664_probe':
	ltc2664.c:(.text+0x714): undefined reference to `__devm_regmap_init_spi'

Select REGMAP_SPI for LTC2664 to fix it.

Fixes: 4cc2fc445d2e ("iio: dac: ltc2664: Add driver for LTC2664 and LTC2672")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/iio/dac/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 45e337c6d256..ae6d04c758d1 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -381,6 +381,7 @@ config LTC2664
 	tristate "Analog Devices LTC2664 and LTC2672 DAC SPI driver"
 	depends on SPI
 	select REGMAP
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices
 	  LTC2664 and LTC2672 converters (DAC).
-- 
2.34.1


