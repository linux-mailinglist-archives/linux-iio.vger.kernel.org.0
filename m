Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FD53FDA63
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 15:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244987AbhIAMcH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 08:32:07 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:27514 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244835AbhIAMb1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 08:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630499430; x=1662035430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nvQXMiaPy2VuNQO50RLteRfILBr98vNnCM+YLfLiMik=;
  b=LxyQlsFU+Rl2Ad8awFvlI1sVRy0yEmyg9akreFM5PSRbW/Yy7W/7TzU8
   TLIsA/PDC/ydObircD/pNQ+eZ/u2RWuHOIfwk0hC8FowyX04IWP67UXAz
   kjpoi+WBiqICOD2pNpSsQisXI9FWuiU9ZLePVeHENYZX7haCq0WcLgQrC
   uyMEmxxOqNa1spy/Hqs32tv75MGxzyLcSwbzyfTDcw93i7c5D+s0TE7B4
   MX1by2LuKHVc+iDs3KPxF+Ga+tKy4j3mJZihhHAdvvlaBS4pEfIhXGSd3
   l9ZaWObZgkoLsoUrnoWISaVb64qUg8AIkyZKVtivqfg9q9F3Npa8L9F37
   g==;
IronPort-SDR: Uu0EX652MzeqXyQGEdYEzS7Fs1FFfmCDPKxBJU4FaiZ9dbvU7f76M5J7Fk9MviVcyCEnZ02B6f
 MEuc3zNdd38A+xWzq6X216eTHvL43nyFJLONA1yUJ72cA68puRyO93Q2f9Hcf/LcQDEvc+NRdv
 6WQcB54QPA/I4gKGME3A+jaZe8l7bEMWcHsl9mrtstJkegdLZeegabLWcK/KXpo5yLMpQtItnE
 IdqkU/YAUgHcy2swVKhwT9sA4RlsiLHoa1fGgojRjOjMfinu1JXFvAjgVQUs8GRNBBXPUfir1W
 k4qB8W6v5CSNvBSDGHMgluL8
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="130318340"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 05:30:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 05:30:29 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Sep 2021 05:30:27 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v3 02/10] iio: adc: at91-sama5d2_adc: initialize hardware after clock is started
Date:   Wed, 1 Sep 2021 15:30:05 +0300
Message-ID: <20210901123013.329792-3-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210901123013.329792-1-eugen.hristev@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
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

