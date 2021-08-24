Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3567A3F5D6A
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 13:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhHXL4O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 07:56:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:20919 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbhHXL4O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 07:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629806131; x=1661342131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nvQXMiaPy2VuNQO50RLteRfILBr98vNnCM+YLfLiMik=;
  b=GXAI3+YUqRs7Sndc+mBBMy3orUyeGQEz9ik/h1vwaCazN9FgWcSxiMj1
   DPrG07NjYRqmiHfv4AxdfO2e6SMg+vd6ZDxoe4eTTQVVl7sucl63QMFoK
   AvdaaStsUoPQbKZD9nw+GhonlZ04wBcpYxBeAzPiTfqAGBpIiV4QrIgSA
   Vmj5z+eDPn/RcKFQsGaRqajg1MYXR5/Q4Z9IzY01uFdkK76KQMu60pZ3L
   eYz+GbZ+WkxeS8VmEeZcTn2O9zMNwyxXn5TdCy2hFzk5Y8q63919P2jhF
   C3AbjWJ/6Z6IZlMManjoOZvORmuJcNlBGytJlBsSjEDMBh3+Wf4kIi+kX
   Q==;
IronPort-SDR: 6nPG1Al6NEDaXSpPdGdoVRRm6Hi4pWaBvvs6si5FpIn+sJSk/P6n4jbLO1f2vgB4Edld59Va2K
 3LAgxeMLWOw/huylvtwDj8zSVrPfPqWTiZSSEdXv65nGffvxP0M7DSaPfSDa7lDPsyKVzfZZaF
 4pGLEkzzeYrORjjwTx5zgbEHQquYFEW4c+t/4y/eCXmwx6LzIY0Riq+eboTIjqkK8eNcu+Neto
 bj071yJsx50L34yivs1QsdYqbuqH9SmjnWBsPyanNgSGO3RkO1Ltyzvg0QuFkhSApEgrZNHxai
 JWtd9X7OFfQOW2j2sWwWN/aV
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="133408028"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2021 04:55:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 04:55:29 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 04:55:18 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 02/10] iio: adc: at91-sama5d2_adc: initialize hardware after clock is started
Date:   Tue, 24 Aug 2021 14:54:33 +0300
Message-ID: <20210824115441.681253-3-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824115441.681253-1-eugen.hristev@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
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
index ea5ca163d879..1f4d461c2c18 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1833,12 +1833,12 @@ static int at91_adc_probe(struct platform_device *pdev)
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

