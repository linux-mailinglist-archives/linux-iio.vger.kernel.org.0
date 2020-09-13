Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8A0267F71
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 14:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgIMMMx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 08:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgIMMMu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 08:12:50 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFFD52158C;
        Sun, 13 Sep 2020 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599999169;
        bh=D6yMZ+uJ22L3iAq168nmQRPRcFSwdEtBQuMq7xUAYpM=;
        h=From:To:Cc:Subject:Date:From;
        b=PHf2x2OJDmgkrUservyd2VGZotfeaZUZFI9FKDGRTyWmNwNWtoWq/M0A6GwSyoC8R
         0rb6i7CdD80JUpW45WM2QXcVX8ybsEqPDxioQdUu8CePJJnInh4toqmiyAT7t3/Fka
         3nS/Q9NSyIzZomJEDSOJgnGSOibVGOVKK2megerE=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH] iio:accel:bma180: Fix use of true when should be iio_shared_by enum
Date:   Sun, 13 Sep 2020 13:12:27 +0100
Message-Id: <20200913121227.764626-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given a value of 1 corresponds to IIO_SHARE_BY_TYPE I have replaced
it with that.  Should cause no functional change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/iio/accel/bma180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 448faed001fd..6b74c2b04c15 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -673,7 +673,7 @@ static const struct iio_chan_spec_ext_info bma023_ext_info[] = {
 };
 
 static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
-	IIO_ENUM("power_mode", true, &bma180_power_mode_enum),
+	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE, &bma180_power_mode_enum),
 	IIO_ENUM_AVAILABLE("power_mode", &bma180_power_mode_enum),
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma180_accel_get_mount_matrix),
 	{ }
-- 
2.28.0

