Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C958E267F51
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 13:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgIML1z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 07:27:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgIML1x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 07:27:53 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A8A721548;
        Sun, 13 Sep 2020 11:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599996472;
        bh=i44iWjmiFOWFt/sKHH5NFuPr0TaL4K3RkMpsdV8EhA8=;
        h=From:To:Cc:Subject:Date:From;
        b=rAyonOCp0WpiVXlKgmCikvstish6il6jKK/Nn2/RMKteIsrToBIqEg5A4NaWMgAIL
         3JQEfkdVb7NPsjAoTPSQmwOTedVyw6AMmrCJM56Yq50n/lcA2+iYIaJK5I9Zcrk6kQ
         iymnBtTR+Hdw6gG0jytpWPKHSdM687ILY3Pj92HY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] iio:magn:hmc5843: Fix passing true where iio_shared_by enum required.
Date:   Sun, 13 Sep 2020 12:25:46 +0100
Message-Id: <20200913112546.715624-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

So it's obvious that the code is wrong in passing true, but I'm assuming
that will actually evaluate to 1 and hence IIO_SHARED_BY_TYPE.
The documentation however has this attribute as IIO_SHARED_BY_ALL.
My current assumption is the documentation is wrong.
If anyone knows otherwise please shout out!

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: 7247645f6865 ("iio: hmc5843: Move hmc5843 out of staging")
Cc: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/iio/magnetometer/hmc5843_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index 1474ba63babe..780faea61d82 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -245,7 +245,7 @@ static const struct iio_enum hmc5843_meas_conf_enum = {
 };
 
 static const struct iio_chan_spec_ext_info hmc5843_ext_info[] = {
-	IIO_ENUM("meas_conf", true, &hmc5843_meas_conf_enum),
+	IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5843_meas_conf_enum),
 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
 	{ }
@@ -259,7 +259,7 @@ static const struct iio_enum hmc5983_meas_conf_enum = {
 };
 
 static const struct iio_chan_spec_ext_info hmc5983_ext_info[] = {
-	IIO_ENUM("meas_conf", true, &hmc5983_meas_conf_enum),
+	IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5983_meas_conf_enum),
 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
 	{ }
-- 
2.28.0

