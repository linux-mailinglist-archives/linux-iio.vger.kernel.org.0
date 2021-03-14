Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA2B33A772
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhCNSST (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233985AbhCNSRz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5822C64EE5;
        Sun, 14 Mar 2021 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745875;
        bh=AA8WgY6NQs/eth2FowL4Scb9ngP3IDGt2y4nrdig4N0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRS8rTRsSH58HApPMwWbFvoN0RWlWLEIRzl30B6/0gTleUXo8MCdSOWTY/uft0qeE
         euGoSTP9aYDh7d02m6xd+tDI0/ruOEo4tl+yyBJnncfrxr5o36t0KUnB8iankErXUN
         79xkyCfwmTDcQ7mPGhTpzlnYPt6V1tSg4A0OrXWWWPIEg4rXS2v027ymosavPSSHtR
         feg94g899GGvI1jbrvtBO+TI9EHQq5dfoQBJpNkk+de3vz8l/fVErn6gFG/M9TqPK1
         +S0fpe3rpSxXV7u4QC4GseoUl9cvGyX9HKs1ZF+Sub7fiyAltuMiCM6lZhSrSi4daL
         5rUCyo420Nvlg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 16/24] staging:iio:cdc:ad7150: Drop unnecessary block comments.
Date:   Sun, 14 Mar 2021 18:15:03 +0000
Message-Id: <20210314181511.531414-17-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These have a habit of not getting updated with driver reorganizations
and don't add much info so drop them.

Also fix a minor comment syntax issue.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-17-jic23@kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7150.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 1bfa71d7ca1d..67af39f80650 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -17,9 +17,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
-/*
- * AD7150 registers definition
- */
 
 #define AD7150_STATUS_REG		0
 #define   AD7150_STATUS_OUT1		BIT(3)
@@ -89,10 +86,6 @@ struct ad7150_chip_info {
 	enum iio_event_direction dir;
 };
 
-/*
- * sysfs nodes
- */
-
 static const u8 ad7150_addresses[][6] = {
 	{ AD7150_CH1_DATA_HIGH_REG, AD7150_CH1_AVG_HIGH_REG,
 	  AD7150_CH1_SETUP_REG, AD7150_CH1_THR_HOLD_H_REG,
@@ -172,8 +165,7 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-/* state_lock should be held to ensure consistent state*/
-
+/* state_lock should be held to ensure consistent state */
 static int ad7150_write_event_params(struct iio_dev *indio_dev,
 				     unsigned int chan,
 				     enum iio_event_type type,
-- 
2.30.2

