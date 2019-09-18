Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1145AB6303
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 14:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfIRMXC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 08:23:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43984 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726941AbfIRMXB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 08:23:01 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8ICLfKJ027959;
        Wed, 18 Sep 2019 14:22:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=LGMEcDX91zZnE3TyD/A9U4RClm8f/2smtj92YAYq+2o=;
 b=0K6bwiVHEwKLgTOJwkIYgMkN+54fiRzj4hvD9GdFbfe344+RAFN0oQmhhL/QWhUtErXh
 wNr/ZTCSXKfjy/PEBovS5zlOzy5P+CoDyrzs75hoOCqTI8yhp/QDTJODYe8vDifQA393
 LQcHMr81M3HHFDJ+M6e26dB9SYaVrudeLYAzwzU+ubT1j9jPRX4vAnnVo9zmt+T9Nnyi
 4ClYCJ/+CffzDxyiOnggSmBaAgCenoYQkmj/7nN1QwKP9mp5q39aRZIQQc1IVRUqviAI
 iJZc3/Yp5G0l4Sows3HEW38r49o10dUOkwAAvYQ3WSRL01rfr7fivmoWTk7ZmcU7S4ea +w== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2v37kmc3mq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 18 Sep 2019 14:22:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1289023;
        Wed, 18 Sep 2019 12:22:51 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 713392C5B2F;
        Wed, 18 Sep 2019 14:22:50 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 18 Sep
 2019 14:22:50 +0200
Received: from localhost (10.48.1.232) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 18 Sep 2019 14:22:49 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <vilhelm.gray@gmail.com>
CC:     <jic23@kernel.org>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] counter: stm32-lptimer-cnt: fix a kernel-doc warning
Date:   Wed, 18 Sep 2019 14:22:41 +0200
Message-ID: <1568809361-26157-1-git-send-email-fabrice.gasnier@st.com>
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

Fix the following warnings when documentation is built:
drivers/counter/stm32-lptimer-cnt.c:354: warning: cannot understand
function prototype: 'enum stm32_lptim_cnt_function'

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/counter/stm32-lptimer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index bbc930a..28b6364 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -347,7 +347,7 @@ static const struct iio_chan_spec stm32_lptim_cnt_channels = {
 };
 
 /**
- * stm32_lptim_cnt_function - enumerates stm32 LPTimer counter & encoder modes
+ * enum stm32_lptim_cnt_function - enumerates LPTimer counter & encoder modes
  * @STM32_LPTIM_COUNTER_INCREASE: up count on IN1 rising, falling or both edges
  * @STM32_LPTIM_ENCODER_BOTH_EDGE: count on both edges (IN1 & IN2 quadrature)
  */
-- 
2.7.4

