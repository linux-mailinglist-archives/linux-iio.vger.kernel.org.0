Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5621610510A
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2019 12:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKULGG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Nov 2019 06:06:06 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18266 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726165AbfKULGG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Nov 2019 06:06:06 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALAvIQV026272;
        Thu, 21 Nov 2019 12:05:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=OhtREXLEPovh2INiG1vnuC84uK8FvPx6VEk4u0CcrrM=;
 b=ZHUKQT94E35jxMTuPiidNnBVxL/JQIz201SOvqDXW+5gHxaLHD7wpsLYRz++NhPZNO5t
 hkIzAOc3Xq8LPuW2Ep1pZkmZYhtlyArGlAJaOlWXUpRN38jvaCu2lepcqcVkCWw/9awu
 sqHDlDPVBgTohnFIhqjZOWM68FX7Q8iKFxilmtpBrlgz0OcaHdWtzebYiKiKoc+ShRae
 wqBrca3fvSwJv5ucqLzG8cKYibvqAeR2NCH4IYAbqGXdi9t8+sjC0a786wEQQD1RNxqv
 s1JHnrb003BWfXJrqkrjiuiQALlOGSrHVkOny9nl7WNv+A7uNpE9CEOd6RCrTcgZldIE SA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wa9upbaaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 12:05:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31E7710002A;
        Thu, 21 Nov 2019 12:05:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 197332BA32B;
        Thu, 21 Nov 2019 12:05:40 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Nov 2019 12:05:39
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] iio: trigger: stm32-timer: remove unnecessary update event
Date:   Thu, 21 Nov 2019 12:05:17 +0100
Message-ID: <1574334317-30014-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_02:2019-11-21,2019-11-21 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is no need to explicitly generate update event to update
timer master mode.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index a5dfe65..2e0d32a 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -297,9 +297,6 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
 			     strlen(master_mode_table[i]))) {
 			regmap_update_bits(priv->regmap, TIM_CR2, mask,
 					   i << shift);
-			/* Make sure that registers are updated */
-			regmap_update_bits(priv->regmap, TIM_EGR,
-					   TIM_EGR_UG, TIM_EGR_UG);
 			return len;
 		}
 	}
-- 
2.7.4

