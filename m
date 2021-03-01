Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016E03280FE
	for <lists+linux-iio@lfdr.de>; Mon,  1 Mar 2021 15:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbhCAOet (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Mar 2021 09:34:49 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:6980 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbhCAOen (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Mar 2021 09:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614609284; x=1646145284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6IiNCOoah0IUygkXHMD+xB58pCnqs4cFYRvYVZObytk=;
  b=QNsftVxyqab7M/img2+itxDUGsEhezYtixdSs5ntDYkVa5b5dpsisRc/
   7acCowxJ3FRBOZEFtSGQsA+FD7B0uX4BJXbWhfzmy0nqfc3a4ulMUJSWc
   l4RVHzu9W/VZB7c1PNeNmljYKs2sgmAZViJAOCTe5TmpIzh4mgkCNrazR
   +wJD7DWSEa95ul2KZ21dzHZIjdlmmkvZfvuf+yBqXDjke1R/74wMBxuBu
   Fuk2VmDQaOdXv2w7Aba0YU63L+smuQicukIIRQ2POuvdHBIrTYfkJpEeo
   EGlfoO1WZGCElUGSQQ+Ok/4YLHhPOQAUwNGlBgcHdm4/IOh99wDhQBTdZ
   Q==;
IronPort-SDR: 3oxJEOSOEbA66qtjvLAuFeCFi5IbyQ+x9t2/yFNd6j7AEKRsHtp/XTXR2QMJlJvjOcj3ZuVxHy
 JLAGM6SvaJ0fciUhOiuqaNOIe06Lck/b4s0p0NnectWv+Bt/0+XeARz2gFcpcdYtefsrclwfvg
 xzgzO5Fte2lFqC1PS7ZTgPy1GmDuhb8YI76Do/b+q2X9CFaZSgqxhRlJzfwnj4DyzUmihR+LsW
 lw0AIEFG4oUOVIPpNM0cZ72/UwJdQ2TgvpsIN0gKdzEG0BgYVPJep7NERLZd8dAY9lO5bZ/zOZ
 SBs=
X-IronPort-AV: E=Sophos;i="5.81,215,1610434800"; 
   d="scan'208";a="110995229"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2021 07:33:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 07:33:22 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 1 Mar 2021 07:33:18 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 2/4] iio: adc: at91-sama5d2: initialize hardware after clock is started
Date:   Mon, 1 Mar 2021 16:32:54 +0200
Message-ID: <20210301143256.16502-3-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210301143256.16502-1-eugen.hristev@microchip.com>
References: <20210301143256.16502-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The hw_init hardware init call must happen after the clock is prepared and
enabled. Otherwise, writing to the registers might lead to a block or
external abort.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index a7826f097b95..63325f037f09 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1832,12 +1832,12 @@ static int at91_adc_probe(struct platform_device *pdev)
 		goto vref_disable;
 	}
 
-	at91_adc_hw_init(indio_dev);
-
 	ret = clk_prepare_enable(st->per_clk);
 	if (ret)
 		goto vref_disable;
 
+	at91_adc_hw_init(indio_dev);
+
 	platform_set_drvdata(pdev, indio_dev);
 
 	ret = at91_adc_buffer_and_trigger_init(&pdev->dev, indio_dev);
-- 
2.25.1

