Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9FC21796B
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jul 2020 22:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGGUct (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Jul 2020 16:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgGGUct (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Jul 2020 16:32:49 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB5A1206E2;
        Tue,  7 Jul 2020 20:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594153968;
        bh=DrzqLGF6QFROiwzqbUYKc3iu/qiXbTrui7uMt0T8AMc=;
        h=From:To:Cc:Subject:Date:From;
        b=ysXjgbngAPcMsCA4nlesVfwBT239hOLzH1ZZDyZTbQcTpqArGeXAwizV2ZLVD6uWp
         UxquUwdwG88mCjH1XHqaXy1+WkrMBi3yZra4x6HyTDKz7VIN5D1jeDT4H4k8i5B72r
         oy/se8aR27LkAKLhpfWED4LWk1CdTdJGeDp5iYCA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio:accel:bma180: Fix the shared by parameter for an enum
Date:   Tue,  7 Jul 2020 21:30:44 +0100
Message-Id: <20200707203044.369103-1-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This takes an enum, not a boolean. Discovered via warning when doing
a W=1 build.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: fdadbce0da4 ("iio: add Bosch BMA180 acceleration sensor driver")
---
 drivers/iio/accel/bma180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 5b7a467c7b27..3246a5ef7360 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -673,7 +673,7 @@ static const struct iio_chan_spec_ext_info bma023_ext_info[] = {
 };
 
 static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
-	IIO_ENUM("power_mode", true, &bma180_power_mode_enum),
+	IIO_ENUM("power_mode", IIO_SHARED_BY_ALL, &bma180_power_mode_enum),
 	IIO_ENUM_AVAILABLE("power_mode", &bma180_power_mode_enum),
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma180_accel_get_mount_matrix),
 	{ }
-- 
2.27.0

