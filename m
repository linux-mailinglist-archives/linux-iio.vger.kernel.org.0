Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F4CF6D46
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 04:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfKKD1G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 22:27:06 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbfKKD1G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 22:27:06 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A38838B905A01154A088;
        Mon, 11 Nov 2019 11:27:02 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
 11:26:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <denis.ciocca@st.com>, <tglx@linutronix.de>,
        <alexios.zavras@intel.com>, <allison@lohutok.net>,
        <yuehaibing@huawei.com>, <linus.walleij@linaro.org>,
        <ladis@linux-mips.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] iio: st_accel: Fix unused variable warning
Date:   Mon, 11 Nov 2019 11:21:15 +0800
Message-ID: <20191111032115.3008-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20191101134741.25108-1-yuehaibing@huawei.com>
References: <20191101134741.25108-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

drivers/iio/accel/st_accel_core.c:1005:44: warning:
 mount_matrix_ext_info defined but not used [-Wunused-const-variable=]

Using stub helper while CONFIG_ACPI is disabled to fix it.

Suggested-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iio/accel/st_accel_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 7b83764..7320275 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -992,6 +992,7 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
 #define ST_ACCEL_TRIGGER_OPS NULL
 #endif
 
+#ifdef CONFIG_ACPI
 static const struct iio_mount_matrix *
 get_mount_matrix(const struct iio_dev *indio_dev,
 		 const struct iio_chan_spec *chan)
@@ -1012,7 +1013,6 @@ static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
 static int apply_acpi_orientation(struct iio_dev *indio_dev,
 				  struct iio_chan_spec *channels)
 {
-#ifdef CONFIG_ACPI
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	struct acpi_device *adev;
@@ -1140,10 +1140,14 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
 out:
 	kfree(buffer.pointer);
 	return ret;
+}
 #else /* !CONFIG_ACPI */
+static int apply_acpi_orientation(struct iio_dev *indio_dev,
+				  struct iio_chan_spec *channels)
+{
 	return 0;
-#endif
 }
+#endif
 
 /*
  * st_accel_get_settings() - get sensor settings from device name
-- 
2.7.4


