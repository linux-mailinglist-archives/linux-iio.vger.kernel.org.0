Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADF02FF415
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 20:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbhAUTQm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 14:16:42 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58244 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbhAUTQ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 14:16:26 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10LJEWfN073438;
        Thu, 21 Jan 2021 13:14:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611256472;
        bh=cKP+KafvdKMdHwP7uKPhFADhSJd5TNUUdhxLiZpDyNA=;
        h=From:To:CC:Subject:Date;
        b=jHG4aGE6Cn9Mr5fLuNa7FzdxrTtdQQnmC+aXYWZVyXLpwcQIgbGvQ6azxfBVjcNCx
         pvtwxuMKHC4M+BBUbL1g0ns0oBpsy7TXC5MSqB0BzPQYkfpt6pvMO8NIq3Oxfmlmtm
         9KhAwmugAQ5o1XvMc3ddrFOHiqM29sklGtMFxu2s=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10LJEWRS094760
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Jan 2021 13:14:32 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 Jan 2021 13:14:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 Jan 2021 13:14:32 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10LJEVck004174;
        Thu, 21 Jan 2021 13:14:32 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] iio:adc:ti-ads124s08: Fix start stop conversion command
Date:   Thu, 21 Jan 2021 13:14:30 -0600
Message-ID: <20210121191431.12057-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix start and stop conversion commands.  The proper command is not be
sent.

Fixes: ("e717f8c6dfec iio: adc: Add the TI ads124s08 ADC code")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/iio/adc/ti-ads124s08.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index b4a128b19188..f05d4e0e1c9d 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -237,7 +237,7 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 
-		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
+		ret = ads124s_write_cmd(indio_dev, ADS124S08_CMD_START);
 		if (ret) {
 			dev_err(&priv->spi->dev, "Start conversions failed\n");
 			goto out;
@@ -251,7 +251,7 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
 
 		*val = ret;
 
-		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
+		ret = ads124s_write_cmd(indio_dev, ADS124S08_CMD_STOP);
 		if (ret) {
 			dev_err(&priv->spi->dev, "Stop conversions failed\n");
 			goto out;
-- 
2.29.2

