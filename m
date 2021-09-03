Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12ED400116
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhICOMn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 10:12:43 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16370 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231164AbhICOMn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 10:12:43 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1838xGPc008730;
        Fri, 3 Sep 2021 10:11:32 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3augp61ck1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 10:11:32 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 183EBUaC040545
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Sep 2021 10:11:31 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Fri, 3 Sep 2021
 07:11:29 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Fri, 3 Sep 2021 07:11:29 -0700
Received: from nsa.ad.analog.com ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 183EBOFC024311;
        Fri, 3 Sep 2021 10:11:26 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH 2/5] iio: adis: handle devices that cannot unmask the drdy pin
Date:   Fri, 3 Sep 2021 16:14:20 +0200
Message-ID: <20210903141423.517028-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903141423.517028-1-nuno.sa@analog.com>
References: <20210903141423.517028-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: YhQ0vyR5-_DP23dG2tgTN3pBwNcpeVs_
X-Proofpoint-ORIG-GUID: YhQ0vyR5-_DP23dG2tgTN3pBwNcpeVs_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_05,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030088
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some devices can't mask/unmask the data ready pin and in those cases
each driver was just calling '{dis}enable_irq()' to control the trigger
state. This change, moves that handling into the library by introducing
a new boolean in the data structure that tells the library that the
device cannot unmask the pin.

On top of controlling the trigger state, we can also use this flag to
automatically request the IRQ with 'IRQF_NO_AUTOEN' in case it is set.
So far, all users of the library want to start operation with IRQs/DRDY
pin disabled so it should be fairly safe to do this inside the library.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis.c         | 15 ++++++++++++++-
 drivers/iio/imu/adis_trigger.c |  4 ++++
 include/linux/iio/imu/adis.h   |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index d4e692b187cd..cb0d66bf6561 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -286,6 +286,13 @@ int adis_enable_irq(struct adis *adis, bool enable)
 	if (adis->data->enable_irq) {
 		ret = adis->data->enable_irq(adis, enable);
 		goto out_unlock;
+	} else if (adis->data->unmasked_drdy) {
+		if (enable)
+			enable_irq(adis->spi->irq);
+		else
+			disable_irq(adis->spi->irq);
+
+		goto out_unlock;
 	}
 
 	ret = __adis_read_reg_16(adis, adis->data->msc_ctrl_reg, &msc);
@@ -430,7 +437,13 @@ int __adis_initial_startup(struct adis *adis)
 	if (ret)
 		return ret;
 
-	adis_enable_irq(adis, false);
+	/*
+	 * don't bother calling this if we can't unmask the IRQ as in this case
+	 * the IRQ is most likely not yet requested and we will request it
+	 * with 'IRQF_NO_AUTOEN' anyways.
+	 */
+	if (!adis->data->unmasked_drdy)
+		adis_enable_irq(adis, false);
 
 	if (!adis->data->prod_id_reg)
 		return 0;
diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index 48eedc29b28a..c461bd1e8e69 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -30,6 +30,10 @@ static const struct iio_trigger_ops adis_trigger_ops = {
 static int adis_validate_irq_flag(struct adis *adis)
 {
 	unsigned long direction = adis->irq_flag & IRQF_TRIGGER_MASK;
+
+	/* We cannot mask the interrupt so ensure it's not enabled at request */
+	if (adis->data->unmasked_drdy)
+		adis->irq_flag |= IRQF_NO_AUTOEN;
 	/*
 	 * Typically this devices have data ready either on the rising edge or
 	 * on the falling edge of the data ready pin. This checks enforces that
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index cf49997d5903..7c02f5292eea 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -49,6 +49,7 @@ struct adis_timeout {
  * @status_error_mask: Bitmask of errors supported by the device
  * @timeouts: Chip specific delays
  * @enable_irq: Hook for ADIS devices that have a special IRQ enable/disable
+ * @unmasked_drdy: True for devices that cannot mask/unmask the data ready pin
  * @has_paging: True if ADIS device has paged registers
  * @burst_reg_cmd:	Register command that triggers burst
  * @burst_len:		Burst size in the SPI RX buffer. If @burst_max_len is defined,
@@ -78,6 +79,7 @@ struct adis_data {
 	unsigned int status_error_mask;
 
 	int (*enable_irq)(struct adis *adis, bool enable);
+	bool unmasked_drdy;
 
 	bool has_paging;
 
-- 
2.33.0

