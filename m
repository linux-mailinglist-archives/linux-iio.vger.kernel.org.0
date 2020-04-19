Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC531AFB8F
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 17:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgDSPE0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 11:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgDSPEZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Apr 2020 11:04:25 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF98722247;
        Sun, 19 Apr 2020 15:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587308665;
        bh=prZ0rDtRZSm7asevPa5WaeUgrvH3P5c2c42j8nljiZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mU740kmqaZbKfbFZwLCRLG6vqs0YHeEEfZNMrQGPXRJffO8Qj2xag96U5YL4ItoCR
         Cc2TdYp+++Sgaq8frB7fsm5Hra23OjV81FogQk5hDBOVRgRO6uuOBDXU/4RgdhVu5F
         iWR3BwRYi/SXJ+ckaVvtdvoSP/qCUmrEkQpzNRlc=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7/7] iio: light: vl6180: swap of.h for mod_devicetable.h and drop of_match_ptr
Date:   Sun, 19 Apr 2020 16:02:06 +0100
Message-Id: <20200419150206.43033-8-jic23@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200419150206.43033-1-jic23@kernel.org>
References: <20200419150206.43033-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Enables probing via ACPI PRP0001 route and removes an example of
an approach we no longer want people to copy.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/vl6180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index d9533a76b8f6..7e67d7b3bfb6 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -537,7 +537,7 @@ MODULE_DEVICE_TABLE(i2c, vl6180_id);
 static struct i2c_driver vl6180_driver = {
 	.driver = {
 		.name   = VL6180_DRV_NAME,
-		.of_match_table = of_match_ptr(vl6180_of_match),
+		.of_match_table = vl6180_of_match,
 	},
 	.probe  = vl6180_probe,
 	.id_table = vl6180_id,
-- 
2.26.1

