Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7625C1CD404
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 10:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgEKIeE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 04:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgEKIeE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 May 2020 04:34:04 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D2120720;
        Mon, 11 May 2020 08:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589186043;
        bh=HK8Ij0xiNrB/Gl8FM5rFEArqdCz320rGYDH4m1F1yqo=;
        h=From:To:Cc:Subject:Date:From;
        b=VaCZI3/hNdtc35fu2VhsYjcpUUQrspf1hVeygY0z3HbMsD0jF7bNNgLEbKdMOXshM
         p0r/wmmO4EZRVgfAV6HDb9GVBnLgtYb3O8Z9hbnDSCSrGmzPd6gSF3P9wsqYIO7Olb
         xdC0yU09Tsp0pZ4YNvsOR42tbAdYaqmlI0ePseOQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH] iio: adc: exynos: Simplify Exynos7-specific init
Date:   Mon, 11 May 2020 10:33:48 +0200
Message-Id: <20200511083348.7577-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Exynos7-specific code bits in ADC driver do not play with PHY:
the field exynos_adc_data.needs_adc_phy is not set in exynos7_adc_data
instance.  Therefore the initialization code does not have to check if
it is true.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Only build tested.
---
 drivers/iio/adc/exynos_adc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 22131a677445..219c8eb32d16 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -449,9 +449,6 @@ static void exynos_adc_exynos7_init_hw(struct exynos_adc *info)
 {
 	u32 con1, con2;
 
-	if (info->data->needs_adc_phy)
-		regmap_write(info->pmu_map, info->data->phy_offset, 1);
-
 	con1 = ADC_V2_CON1_SOFT_RESET;
 	writel(con1, ADC_V2_CON1(info->regs));
 
-- 
2.17.1

