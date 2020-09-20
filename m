Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8DB271395
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 13:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgITL2d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 07:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgITL2d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 07:28:33 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C9A820EDD;
        Sun, 20 Sep 2020 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600601313;
        bh=z73AgK2yfgNYXkFZdruydRBLaEMHDZNllP71Srw8ugY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZOirp5c4ZFjiY1uyJESkNFD+8++UcVihYOid3PIqc/UGJWA2HYyZykVtnm6Lk/cE
         QyIDNeOuMi8SB/6/MK4AFDlY5D97mvdJdZvRNiCZ5ScY5bX2pifCQdM/HXBDkNr26q
         fh6HR4RVYcLf/Hd2XMnPw+VmloMDS1TM/ZmLNd1k=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 7/8] iio:adc:ti-ads124s08: Fix buffer being too long.
Date:   Sun, 20 Sep 2020 12:27:41 +0100
Message-Id: <20200920112742.170751-8-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920112742.170751-1-jic23@kernel.org>
References: <20200920112742.170751-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The buffer is expressed as a u32 array, yet the extra space for
the s64 timestamp was expressed as sizeof(s64)/sizeof(u16).
This will result in 2 extra u32 elements.
Fix by dividing by sizeof(u32).

Fixes: e717f8c6dfec ("iio: adc: Add the TI ads124s08 ADC code")
Cc: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Jonathan Cameron<Jonathan.Cameron@huawei.com>
---
v4: New patch

 drivers/iio/adc/ti-ads124s08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 4b4fbe33930c..eff4f9a9898e 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -269,7 +269,7 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ads124s_private *priv = iio_priv(indio_dev);
-	u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u16)];
+	u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u32)];
 	int scan_index, j = 0;
 	int ret;
 
-- 
2.28.0

