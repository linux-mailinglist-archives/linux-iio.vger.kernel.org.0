Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9FD5571
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 11:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfJMJRq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 05:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbfJMJRq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 05:17:46 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1B4420659;
        Sun, 13 Oct 2019 09:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570958265;
        bh=JECmuRCuHq5fRgFVCXoMoJ282oNADMRbopeZTR+KVSo=;
        h=From:To:Cc:Subject:Date:From;
        b=pSrhF8GaET2awhaZNuiWptbsn8zn5qqBnbV1bxUn+7iM75ej0l7EoyNA78r4+pzCr
         AbF5YNs2T79XZcOXbCd2AOZsLpy4Y2afxq1xQJNNh6VvQzHmz6yXYL7fseQk6EYO6u
         C6WIn9y0HP2IX0RsXTicfMeIUntWBA0VXBUo6V5I=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH] iio:adc:stmpe-adc: Cleanup endian type of local variable
Date:   Sun, 13 Oct 2019 10:15:41 +0100
Message-Id: <20191013091541.1382009-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Nothing stops data being of type __be16, which fixes the warning:

CHECK   drivers/iio/adc/stmpe-adc.c
drivers/iio/adc/stmpe-adc.c:202:29: warning: cast to restricted __be16
drivers/iio/adc/stmpe-adc.c:202:29: warning: cast to restricted __be16
drivers/iio/adc/stmpe-adc.c:202:29: warning: cast to restricted __be16
drivers/iio/adc/stmpe-adc.c:202:29: warning: cast to restricted __be16

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Philippe Schenker <philippe.schenker@toradex.com>
---
 drivers/iio/adc/stmpe-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index bd72727fc417..0f88048ea48f 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -175,7 +175,7 @@ static int stmpe_read_raw(struct iio_dev *indio_dev,
 static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
 {
 	struct stmpe_adc *info = (struct stmpe_adc *)dev_id;
-	u16 data;
+	__be16 data;
 
 	if (info->channel <= STMPE_ADC_LAST_NR) {
 		int int_sta;
-- 
2.23.0

