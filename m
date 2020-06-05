Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FD21EFF05
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jun 2020 19:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgFEReX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Jun 2020 13:34:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39126 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgFERd5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jun 2020 13:33:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id AFFDA2A5089
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 5/7] iio: adc: exynos: Use input_device_enabled()
Date:   Fri,  5 Jun 2020 19:33:33 +0200
Message-Id: <20200605173335.13753-6-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605173335.13753-1-andrzej.p@collabora.com>
References: <20200604072853.GP89269@dtor-ws>
 <20200605173335.13753-1-andrzej.p@collabora.com>
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
index 22131a677445..294715bafe25 100644
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
+	mutex_lock(&info->input->mutex);
+	cont = input_device_enabled(info->input);
+	mutex_unlock(&info->input->mutex);
+	while (cont) {
 		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
 		if (ret == -ETIMEDOUT)
 			break;
@@ -651,6 +654,10 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
 		input_sync(info->input);
 
 		usleep_range(1000, 1100);
+
+		mutex_lock(&info->input->mutex);
+		cont = input_device_enabled(info->input);
+		mutex_unlock(&info->input->mutex);
 	}
 
 	writel(0, ADC_V1_CLRINTPNDNUP(info->regs));
-- 
2.17.1

