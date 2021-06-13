Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79933A595A
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhFMPXW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 11:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231934AbhFMPXU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 11:23:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8934F61285;
        Sun, 13 Jun 2021 15:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623597679;
        bh=EmaCDSVuN2EoRAgJ0f5x0SnwmyPJnN+RJlYUj4Gez84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ApSagRJ7Rhhqq2ed2xs6eSsMeRoO9pL5r+A7DbGs/kMuxoaL47jK8uVi9rPeMwZKr
         si4VXiyHelaE6P8TxkJU/tHEjFloSZd/m9NI+5dbpUrXd++0SSSu4qLMA/vs7IFNlO
         pEOxotJyXlgUp6YR+4XBY1EzzGlXWlQoLp1355y1wle7JA4U8+YrI3r+cYP/8nfMkY
         uf2RucmVcdWGa9HWdR2hFm5FY6EolkaUUAwTWGqTZvierOAgogMYOSEamQMnoDPrRH
         Evu2B6bpPG17AqEJrCsGEC+LRTdZeHnHW6o6jbdNrqitE51KXP9luZZM5fu0To4qcf
         91YXGVPa3INFg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH RESEND 5/8] iio: magn: rm3100: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
Date:   Sun, 13 Jun 2021 16:22:58 +0100
Message-Id: <20210613152301.571002-6-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613152301.571002-1-jic23@kernel.org>
References: <20210613152301.571002-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add __aligned(8) to ensure the buffer passed to
iio_push_to_buffers_with_timestamp() is suitable for the naturally
aligned timestamp that will be inserted.

Here an explicit structure is not used, because this buffer is used in
a non-trivial way for data repacking.

Fixes: 121354b2eceb ("iio: magnetometer: Add driver support for PNI RM3100")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Song Qiang <songqiang1304521@gmail.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 4df5887fd04c..13914273c999 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -78,7 +78,8 @@ struct rm3100_data {
 	bool use_interrupt;
 	int conversion_time;
 	int scale;
-	u8 buffer[RM3100_SCAN_BYTES];
+	/* Ensure naturally aligned timestamp */
+	u8 buffer[RM3100_SCAN_BYTES] __aligned(8);
 	struct iio_trigger *drdy_trig;
 
 	/*
-- 
2.32.0

