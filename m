Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5570336B775
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbhDZRFG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235195AbhDZRFF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:05:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFF7F61077;
        Mon, 26 Apr 2021 17:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619456663;
        bh=hMrnruaS8RaqHRuRGs9ZkakrCCbkQdPm1xRdb710jXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfqODkUc0qNs/5GKa/ujsnq9RKD30PLBmjOvKmI+4+PyqAQbHzT5La8yj6aZ4bthq
         iymaLSZMSaRxpjdOIa5qPzkOMYuzJVQSO7EXrFkRsojRA8G1VEIvW23wwkFYTw58nS
         0YFrIe/zTX5a2uigUAdBOBp4K6/zxrx2PD/eZiviZf2X9i9csDkLSyywqi8p8cwiW4
         BBiJFbu/TGBmnXn3CV3LKXITYqO0Z8EZKYw7+zJhriJii04sCG9lARctLoEQRCP28o
         TPBitgKPmiziWQHKoF1yBiyZNck1Qrj4SSVA5ejjFHc8M4a7+P8oRGTM1BRuTU0uUt
         f1vGwPi9EixbQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 7/8] iio: position: hid-sensor-custom-intel-hinge: Drop duplicate parent setting.
Date:   Mon, 26 Apr 2021 18:02:50 +0100
Message-Id: <20210426170251.351957-8-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426170251.351957-1-jic23@kernel.org>
References: <20210426170251.351957-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

iio_dev.dev.parent is already set to the same value in
devm_iio_device_alloc()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index fd77e7ee87f3..738b5f4626ce 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -303,7 +303,6 @@ static int hid_hinge_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &hinge_info;
 	indio_dev->name = "hinge";
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.31.1

