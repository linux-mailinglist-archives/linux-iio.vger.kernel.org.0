Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA8014795C
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2020 09:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgAXI0o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jan 2020 03:26:44 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37382 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgAXI0o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jan 2020 03:26:44 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00O8OTl2014122;
        Fri, 24 Jan 2020 09:26:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=3JYauW1ZnMoc3P4fm4vLggKu8VcPTT/FhM8tD56QD7Q=;
 b=bBs5zpcroZYlUe3fzeRIsQQ1gXtFsdFgq9HGnU5Qghc627kb+6mSZOljVJt9Yz3fZiTg
 Hxt7SFgdwq8eVBFEp1TomOLUNcKRTralUEt9kuN+WdhX/Iy6PuW4MRs8Wy4J1gP51ISc
 pqnBfmpfs59QYoyJ+FBkHkK6W+rMGhCg38Tqv7XVXf+BVFEgDoNSfOBl+ywieQASo20N
 dM8lXnTsyKmbEoFxB6XeMYjQgEBx+qW7yoB8H6c70M/r1MiflBKxlcBdIJLslNfv3X2T
 inqPSFfEFn//Nj4XAJh4orjlXmJs15OQvebp8cRqRp06N4qDqeSKWHW+GhYsxRHtV4ec PQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkrc5erw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jan 2020 09:26:19 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A92B100034;
        Fri, 24 Jan 2020 09:26:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3203A20EB92;
        Fri, 24 Jan 2020 09:26:15 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jan 2020 09:26:14
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] iio: adc: stm32-adc: fix runtime autosuspend delay when slow polling
Date:   Fri, 24 Jan 2020 09:26:09 +0100
Message-ID: <1579854369-7972-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_02:2020-01-24,2020-01-24 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the ADC is runtime suspended and starting a conversion, the stm32-adc
driver calls pm_runtime_get_sync() that gets cascaded to the parent
(e.g. runtime resume of stm32-adc-core driver). This also kicks the
autosuspend delay (e.g. 2s) of the parent.
Once the ADC is active, calling pm_runtime_get_sync() again (upon a new
capture) won't kick the autosuspend delay for the parent (stm32-adc-core
driver) as already active.

Currently, this makes the stm32-adc-core driver go in suspend state
every 2s when doing slow polling. As an example, doing a capture, e.g.
cat in_voltageY_raw at a 0.2s rate, the auto suspend delay for the parent
isn't refreshed. Once it expires, the parent immediately falls into
runtime suspended state, in between two captures, as soon as the child
driver falls into runtime suspend state:
- e.g. after 2s, + child calls pm_runtime_put_autosuspend() + 100ms
  autosuspend delay of the child.
- stm32-adc-core switches off regulators, clocks and so on.
- They get switched on back again 100ms later in this example (at 2.2s).

So, add an explicit call to pm_runtime_mark_last_busy() for the parent
driver (stm32-adc-core), synchronously with the child driver (stm32-adc),
to avoid this.

Fixes: 9bdbb1139ca1 ("iio: adc: stm32-adc: add power management support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 3b291d7..670157e 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1157,6 +1157,7 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 
 	stm32_adc_conv_irq_disable(adc);
 
+	pm_runtime_mark_last_busy(dev->parent);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
@@ -1278,6 +1279,7 @@ static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
 	adc->num_conv = bitmap_weight(scan_mask, indio_dev->masklength);
 
 	ret = stm32_adc_conf_scan_seq(indio_dev, scan_mask);
+	pm_runtime_mark_last_busy(dev->parent);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
@@ -1329,6 +1331,7 @@ static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
 	else
 		*readval = stm32_adc_readl(adc, reg);
 
+	pm_runtime_mark_last_busy(dev->parent);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
@@ -1451,6 +1454,7 @@ static int __stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 err_clr_trig:
 	stm32_adc_set_trig(indio_dev, NULL);
 err_pm_put:
+	pm_runtime_mark_last_busy(dev->parent);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
@@ -1487,6 +1491,7 @@ static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 	if (stm32_adc_set_trig(indio_dev, NULL))
 		dev_err(&indio_dev->dev, "Can't clear trigger\n");
 
+	pm_runtime_mark_last_busy(dev->parent);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 }
@@ -1874,6 +1879,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		goto err_hw_stop;
 	}
 
+	pm_runtime_mark_last_busy(dev->parent);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
-- 
2.7.4

