Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6889EB62FD
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 14:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfIRMWo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 08:22:44 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59834 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728915AbfIRMWo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 08:22:44 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8IBxCbN020861;
        Wed, 18 Sep 2019 14:22:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=RebjsdANV2RzBT+nKVyZPCTFFvdkml0nlo0oKVk0ci8=;
 b=oipJ2ouUjUahB3dmJ4OqaGkvNR6lRCvhtpKxSkkUoeCN5vsRw1HNa1L1WuBo/QBdIVqS
 HMlU74EipnCxVFIksMwBCCxnMxWQ7RrY1gyIzU0Yri1MuCcC/3OH5KSbp8Wd1+FpSf57
 ovlemkzcYOBffmOiVS0nijuG1kUiYaS9GteEst8NbasI0Mg8Xwlz3A/D6NILOrRvx8Cc
 MXEYu7rziBf4sQTs4U2nvwoA5HR4JK0v5ZIF91rzbIwNgvVZqrFZzQtS76er1epe96Fx
 BLWutbYImcqD6p4SF8nihNqCvuvF3vvMkVxPB447o3D/fDWOoI4YO7tz210/6LSqHbEw 3w== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2v37kh456y-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 18 Sep 2019 14:22:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9C42B4C;
        Wed, 18 Sep 2019 12:22:29 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D8E3E2C5B2F;
        Wed, 18 Sep 2019 14:22:28 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 18 Sep
 2019 14:22:28 +0200
Received: from localhost (10.48.1.232) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 18 Sep 2019 14:22:28 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <vilhelm.gray@gmail.com>
CC:     <jic23@kernel.org>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] counter: stm32-timer-cnt: fix a kernel-doc warning
Date:   Wed, 18 Sep 2019 14:22:03 +0200
Message-ID: <1568809323-26079-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.1.232]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_07:2019-09-17,2019-09-18 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix the following warning when documentation is built:
drivers/counter/stm32-timer-cnt.c:37: warning: cannot understand function
prototype: 'enum stm32_count_function'

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/counter/stm32-timer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 644ba18..e425dd1 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -28,7 +28,7 @@ struct stm32_timer_cnt {
 };
 
 /**
- * stm32_count_function - enumerates stm32 timer counter encoder modes
+ * enum stm32_count_function - enumerates stm32 timer counter encoder modes
  * @STM32_COUNT_SLAVE_MODE_DISABLED: counts on internal clock when CEN=1
  * @STM32_COUNT_ENCODER_MODE_1: counts TI1FP1 edges, depending on TI2FP2 level
  * @STM32_COUNT_ENCODER_MODE_2: counts TI2FP2 edges, depending on TI1FP1 level
-- 
2.7.4

