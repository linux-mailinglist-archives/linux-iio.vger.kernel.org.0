Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4133CC6DB
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 01:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhGQXkh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 19:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhGQXk3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Jul 2021 19:40:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1E2C061762;
        Sat, 17 Jul 2021 16:37:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a13so16488661wrf.10;
        Sat, 17 Jul 2021 16:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REQGLBJXt02T4HQW9YuEzMSqSjnRxM4DXHv1UWuNok0=;
        b=d12ID/+85BXhYp5lVxcM3+av/sgR1fUzvi31SIskiUqnbkoZYeOFeiRcMcoEYgztLz
         FwsxANXuvZ+IT5l9zr/eziTHJmqij97HqEZAUtNb1NTWYoJVLvn5jKvYccf1cJ0pZPEg
         Okgf3LPve3p+EXVZ86avEGkjxPsWI/Bg82ZVRjOkfYslrhCJaFvYoGRGy1nYef2zKp+Z
         bUS6ssLrMgOJIgYDOIYaxWgr8Bsnc2IlPl1g2kBuC1GT6sbZlGZcLwyAiSbXUbLbrSMK
         +gtz+p6TO24EXkceOVg3+3fkfiTlF+eKoro/sj++oLshKXC6gKZFuehJ0kFpDXA2AzeM
         Aaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REQGLBJXt02T4HQW9YuEzMSqSjnRxM4DXHv1UWuNok0=;
        b=bLfZJaaFz1TTCzkvaYq9WySBes2bQx85IlAXdsDa3MV5cKrd8MD6nz+FNou1ocgcAh
         wCF/lyev22vy2FGm5PZv6us6OCbnxvIltCA8Bmyfi40tsQUe4QWCuWdbwVJLkGEbmjdV
         dXXMRZyjVzvt66XEH+aivsAjuEwb8hoENZxxTP2J3/dvGJs2GGaM+vBDXzWNWOo3JL0O
         1llQlNnSDhTl7ReiSZKMKlOr4trklHLFZpg4jfiRzL+JZ4VOmtFpzFNYbn4RTvO7cCj0
         Ce1ZBSa7llwEEeMx+LTwIhe+V2Nh2+PUnAzeuHssa1Zy7tfvZ+jq1AxhWNJKyet7rb4T
         5DtA==
X-Gm-Message-State: AOAM5317uaRdnyGxll+2GjgkOT+1kKcxO1JmVBrdANrO9Z9G1ped5zSC
        dg/lxrZSsAnZQSMDxgV/uPwDfSfJnxE=
X-Google-Smtp-Source: ABdhPJyvf4zkAdXPasJYccDCqPa6lAGLKbFDFJmYoATC615OxyRHoI/KcyT2yzw3/QpGo/AYVELy+g==
X-Received: by 2002:a5d:59ad:: with SMTP id p13mr21145793wrr.139.1626565050573;
        Sat, 17 Jul 2021 16:37:30 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7602-4e00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:7602:4e00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id q7sm12347527wmq.33.2021.07.17.16.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 16:37:30 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, jic23@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] iio: adc: meson-saradc: Disable BL30 integration on G12A and newer SoCs
Date:   Sun, 18 Jul 2021 01:37:16 +0200
Message-Id: <20210717233718.332267-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717233718.332267-1-martin.blumenstingl@googlemail.com>
References: <20210717233718.332267-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

G12A and newer don't use the SAR ADC to read the SoC temperature from
within the firmware. Instead there's now a dedicated thermal sensor.
Disable the BL30 integration for G12A and newer SoCs to save a few CPU
cycles when reading samples.
Adding a separate struct meson_sar_adc_data is a good idea anyways
because starting with G12A there's some extra registers to read the
samples in a simplified way.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 66dc452d643a..e140db3e4016 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1104,6 +1104,14 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
 	.resolution = 12,
 };
 
+static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
+	.has_bl30_integration = false,
+	.clock_rate = 1200000,
+	.bandgap_reg = MESON_SAR_ADC_REG11,
+	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
+	.resolution = 12,
+};
+
 static const struct meson_sar_adc_data meson_sar_adc_meson8_data = {
 	.param = &meson_sar_adc_meson8_param,
 	.name = "meson-meson8-saradc",
@@ -1140,7 +1148,7 @@ static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
 };
 
 static const struct meson_sar_adc_data meson_sar_adc_g12a_data = {
-	.param = &meson_sar_adc_gxl_param,
+	.param = &meson_sar_adc_g12a_param,
 	.name = "meson-g12a-saradc",
 };
 
-- 
2.32.0

