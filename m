Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0AF1D3103
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 15:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgENNRy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 09:17:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:59964 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727893AbgENNRy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 09:17:54 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04ED9Xa5020333;
        Thu, 14 May 2020 09:17:42 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3100x5yeb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 09:17:41 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04EDHdDF034599
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 14 May 2020 09:17:40 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 06:17:39 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 06:17:22 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 14 May 2020 06:17:38 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04EDHUal017033;
        Thu, 14 May 2020 09:17:35 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
CC:     <ludovic.desroches@microchip.com>, <eugen.hristev@microchip.com>,
        <jic23@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <ak@it-klinger.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/8] iio: at91-sama5d2_adc: pass ref to IIO device via param for int function
Date:   Thu, 14 May 2020 16:17:04 +0300
Message-ID: <20200514131710.84201-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514131710.84201-1-alexandru.ardelean@analog.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_03:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140117
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since there will be some changes to how iio_priv_to_dev() is implemented,
it could be that the helper becomes a bit slower, as it will be hidden away
in the IIO core.

For this driver, the IIO device can be passed directly as a parameter to
the at91_adc_no_pen_detect_interrupt() function, thus making it immune to
the change of iio_priv_to_dev().
The function gets called in an interrupt context.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 9abbbdcc7420..822b8782acba 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1275,10 +1275,9 @@ static void at91_adc_pen_detect_interrupt(struct at91_adc_state *st)
 	st->touch_st.touching = true;
 }
 
-static void at91_adc_no_pen_detect_interrupt(struct at91_adc_state *st)
+static void at91_adc_no_pen_detect_interrupt(struct iio_dev *indio_dev,
+					     struct at91_adc_state *st)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(st);
-
 	at91_adc_writel(st, AT91_SAMA5D2_TRGR,
 			AT91_SAMA5D2_TRGR_TRGMOD_NO_TRIGGER);
 	at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_NOPEN |
@@ -1318,7 +1317,7 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 		at91_adc_pen_detect_interrupt(st);
 	} else if ((status & AT91_SAMA5D2_IER_NOPEN)) {
 		/* nopen detected IRQ */
-		at91_adc_no_pen_detect_interrupt(st);
+		at91_adc_no_pen_detect_interrupt(indio, st);
 	} else if ((status & AT91_SAMA5D2_ISR_PENS) &&
 		   ((status & rdy_mask) == rdy_mask)) {
 		/* periodic trigger IRQ - during pen sense */
-- 
2.17.1

