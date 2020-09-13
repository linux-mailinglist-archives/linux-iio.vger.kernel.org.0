Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E8267FA8
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgIMNXZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 09:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgIMNXU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 09:23:20 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B761A217BA;
        Sun, 13 Sep 2020 13:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600003400;
        bh=R+VVRIk6l5/l6g7174w37YKlgtuyfIO0RSzMT5FXTIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RnG6BUFwF0yWoEWPGJT5TP7mgyWKobRwGJThw865NZA7nGdUvSRd0SUoKd8kkF+d9
         WjjL8jlAQlmVZcuPUKb2AfLiDsTMMr/RjZDPtOXMvXzQuSkohVQHxnjenHVvaGM0Si
         nUsrzrxoLitY1F3M2vGlQmlT8XF1nm2PiI95Npd4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3] iio:imu:adis16400: Sort out missing kernel doc.
Date:   Sun, 13 Sep 2020 14:21:13 +0100
Message-Id: <20200913132115.800131-2-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913132115.800131-1-jic23@kernel.org>
References: <20200913132115.800131-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'd like to be enable W=1 for all IIO builds as it catches real issues as well
as more minor documentation issues such as this (also good to fix though!)

drivers/iio/imu/adis16400.c:183: warning: Function parameter or member 'avail_scan_mask' not described in 'adis16400_state'

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16400.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 1ebe3e50d3e6..140cfc65ee8c 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -173,6 +173,8 @@ struct adis16400_chip_info {
  * @variant:	chip variant info
  * @filt_int:	integer part of requested filter frequency
  * @adis:	adis device
+ * @avail_scan_mask:	NULL terminated array of bitmaps of channels
+ *			that must be enabled together
  **/
 struct adis16400_state {
 	struct adis16400_chip_info	*variant;
-- 
2.28.0

