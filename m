Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828A91D56A9
	for <lists+linux-iio@lfdr.de>; Fri, 15 May 2020 18:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgEOQw2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbgEOQw2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 May 2020 12:52:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4E7C061A0C;
        Fri, 15 May 2020 09:52:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id C9C712A333A
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 4/7] iio: adc: exynos: Use input_device_enabled()
Date:   Fri, 15 May 2020 18:52:10 +0200
Message-Id: <20200515165210.28813-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515164943.28480-1-andrzej.p@collabora.com>
References: <20200515164943.28480-1-andrzej.p@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A new helper is available, so use it. Inspecting 'users' member of
input_dev requires taking device's mutex.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/iio/adc/exynos_adc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 22131a677445..1253d94089a7 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -630,10 +630,13 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
 	struct exynos_adc *info = dev_id;
 	struct iio_dev *dev = dev_get_drvdata(info->dev);
 	u32 x, y;
-	bool pressed;
+	bool pressed, cont;
 	int ret;
 
-	while (info->input->users) {
+	mutex_lock(&info->input);
+	cont = input_device_enabled(info->input);
+	mutex_unlock(&info->input);
+	while (cont) {
 		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
 		if (ret == -ETIMEDOUT)
 			break;
@@ -651,6 +654,10 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
 		input_sync(info->input);
 
 		usleep_range(1000, 1100);
+
+		mutex_lock(&info->input);
+		cont = input_device_enabled(info->input);
+		mutex_unlock(&info->input);
 	}
 
 	writel(0, ADC_V1_CLRINTPNDNUP(info->regs));
-- 
2.17.1

