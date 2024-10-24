Return-Path: <linux-iio+bounces-11049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0DC9AD97B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 03:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96061F223F3
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 01:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0ED8614E;
	Thu, 24 Oct 2024 01:56:34 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3928054279;
	Thu, 24 Oct 2024 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729734994; cv=none; b=nR8OlbjK6f72XseHYuRP1/jOIN7zEhp2/8EYlyyBGXA9+itdq4e1hAqptXJ/YybEkwFNOUY5u0+nGeWXvm58QdO7OJ9cEf+Q4Mi8XVqtCgMoHpMp+h8voqdbbsui+YRdEovql7qBgBts/BCv9kjSm/UmU04+L7oQhnvigVttqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729734994; c=relaxed/simple;
	bh=nJ8ZqssvyW3xRNy1LX11lkBVaBZM5V1pRTl0vH9i13M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t6bvEoljHjNN+raOk71FplHt6waLqqGHWYWBa4kKMegeASjAjMPMkW2kHKOU0Pwg7aA+jkpgZYAT1akjg0Dw9TZKEC/mgJGS9Y8sZufMJKMihtQS1oXA525jecRVZK1KOo8nJbf9yKcAAEV992Ibas3v1hLPfBJO7zgs8KoEGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XYprl5ljjz2FbTk;
	Thu, 24 Oct 2024 09:55:03 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id C1C841A0188;
	Thu, 24 Oct 2024 09:56:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Oct
 2024 09:56:27 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <nuno.sa@analog.com>,
	<javier.carrasco.cruz@gmail.com>, <sunke@kylinos.cn>,
	<conor.dooley@microchip.com>, <anshulusr@gmail.com>, <ruanjinjie@huawei.com>,
	<kimseer.paller@analog.com>, <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <noname.nuno@gmail.com>
Subject: [PATCH v2] iio: dac: Kconfig: Fix build error for ltc2664
Date: Thu, 24 Oct 2024 09:55:53 +0800
Message-ID: <20241024015553.1111253-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)

If REGMAP_SPI is n and LTC2664 is y, the following build error occurs:

	riscv64-unknown-linux-gnu-ld: drivers/iio/dac/ltc2664.o: in function `ltc2664_probe':
	ltc2664.c:(.text+0x714): undefined reference to `__devm_regmap_init_spi'

Select REGMAP_SPI instead of REGMAP for LTC2664 to fix it.

Fixes: 4cc2fc445d2e ("iio: dac: ltc2664: Add driver for LTC2664 and LTC2672")
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Select REGMAP_SPI instead of REGMAP.
- Update the commit subject.
- Add Reviewed-by.
---
 drivers/iio/dac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 45e337c6d256..9f5d5ebb8653 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -380,7 +380,7 @@ config LTC2632
 config LTC2664
 	tristate "Analog Devices LTC2664 and LTC2672 DAC SPI driver"
 	depends on SPI
-	select REGMAP
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices
 	  LTC2664 and LTC2672 converters (DAC).
-- 
2.34.1


