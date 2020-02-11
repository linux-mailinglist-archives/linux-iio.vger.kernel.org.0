Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C52B6158D06
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 11:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgBKK4d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 05:56:33 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60260 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727884AbgBKK4d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Feb 2020 05:56:33 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BAuKJR011415;
        Tue, 11 Feb 2020 11:56:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=cV1Wais5QMnCi8AYrjauwcQtc7x8Akg7kC3DCHNTrfI=;
 b=cKJVTis8lYfFtJmiAwNtEstgu8ZuVu2qme2/jqgNfi7pG9/H8KjgeBt4JOPrcc/790wY
 ijOpUeKHTdkXZiW4s2GpQ5TARF1uFND/zPKxeJVMfGH/ryd4E4nglrEkvomKjcIfQ8uk
 NpGvOdYh0TnLxQYM7CLRDaaaz6ajHx3kv3l4loO3SAabEbPQEctkz8x6EQLXSmPLbPCv
 WwGQUUXgqs/50JLQEHG9Ho8g5q+ouF1s7IdkRvtR033cAT0Cpqu59gjz81I910V1mZ2x
 mBA1tHHsuktI3Gbi2QXPZE6za+GsD7erMLutX7W/4mdOMHvDKiNhlqVYISlpZIpGqecx PQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ud9m85f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 11:56:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7594100050;
        Tue, 11 Feb 2020 11:56:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 96D282AEAB8;
        Tue, 11 Feb 2020 11:56:20 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb 2020 11:56:20
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <vilhelm.gray@gmail.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <benjamin.gaignard@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] counter: stm32-timer-cnt: remove iio headers
Date:   Tue, 11 Feb 2020 11:56:06 +0100
Message-ID: <1581418566-31954-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_03:2020-02-10,2020-02-11 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The stm32-timer-cnt driver doesn't use the iio interface. The iio headers
aren't relevant and can be removed as reported by William in [1].
With this change, mod_devicetable.h needs to be added to define the
'of_device_id' struct.

[1] https://lkml.org/lkml/2020/2/10/1516

Reported-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Note this applies on top of:
- "counter: stm32-timer-cnt: add power management support"
---
 drivers/counter/stm32-timer-cnt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 50496f4..ef2a974 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -8,9 +8,8 @@
  *
  */
 #include <linux/counter.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/types.h>
 #include <linux/mfd/stm32-timers.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
-- 
2.7.4

