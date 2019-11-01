Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8061BEC406
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 14:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKANt0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 09:49:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5691 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbfKANt0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 1 Nov 2019 09:49:26 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A904FF0927A7025CDCA6;
        Fri,  1 Nov 2019 21:49:10 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 21:49:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <denis.ciocca@st.com>,
        <yuehaibing@huawei.com>, <rfontana@redhat.com>,
        <tglx@linutronix.de>, <heiko.stuebner@bq.com>,
        <rjones@gateworks.com>, <drake@endlessm.com>,
        <colin.king@canonical.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] iio: st_accel: Fix unused variable warning
Date:   Fri, 1 Nov 2019 21:47:41 +0800
Message-ID: <20191101134741.25108-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
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

Move it to ifdef to mute this warning.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iio/accel/st_accel_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 2e37f8a..bba0717 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1002,10 +1002,12 @@ get_mount_matrix(const struct iio_dev *indio_dev,
 	return adata->mount_matrix;
 }
 
+#ifdef CONFIG_ACPI
 static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),
 	{ },
 };
+#endif
 
 /* Read ST-specific _ONT orientation data from ACPI and generate an
  * appropriate mount matrix.
-- 
2.7.4


