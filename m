Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F9F1DE041
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 08:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgEVG4T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 02:56:19 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61248 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728390AbgEVG4S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 02:56:18 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04M6lIcE026832;
        Fri, 22 May 2020 02:56:17 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 312d364vk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 May 2020 02:56:17 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04M6uGwp020352
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 22 May 2020 02:56:16 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 02:56:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 02:56:14 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 22 May 2020 02:56:14 -0400
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04M6uB79024790;
        Fri, 22 May 2020 02:56:12 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lorenzo.bianconi83@gmail.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: humidity: hts221: remove usage of iio_priv_to_dev()
Date:   Fri, 22 May 2020 09:56:16 +0300
Message-ID: <20200522065616.10901-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_02:2020-05-21,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0 cotscore=-2147483648
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1011 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We may want to get rid of the iio_priv_to_dev() helper. That's a bit
uncertain at this point. The reason is that we will hide some of the
members of the iio_dev structure (to prevent drivers from accessing them
directly), and that will also mean hiding the implementation of the
iio_priv_to_dev() helper inside the IIO core.

Hiding the implementation of iio_priv_to_dev() implies that some fast-paths
may not be fast anymore, so a general idea is to try to get rid of the
iio_priv_to_dev() altogether.

For this driver, removing the iio_priv_to_dev() helper means passing the
iio_dev object on hts221_allocate_buffers() & hts221_allocate_trigger().

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/humidity/hts221.h        | 4 ++--
 drivers/iio/humidity/hts221_buffer.c | 7 +++----
 drivers/iio/humidity/hts221_core.c   | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
index 7d6771f7cf47..569146910885 100644
--- a/drivers/iio/humidity/hts221.h
+++ b/drivers/iio/humidity/hts221.h
@@ -46,7 +46,7 @@ extern const struct dev_pm_ops hts221_pm_ops;
 int hts221_probe(struct device *dev, int irq, const char *name,
 		 struct regmap *regmap);
 int hts221_set_enable(struct hts221_hw *hw, bool enable);
-int hts221_allocate_buffers(struct hts221_hw *hw);
-int hts221_allocate_trigger(struct hts221_hw *hw);
+int hts221_allocate_buffers(struct hts221_hw *hw, struct iio_dev *iio_dev);
+int hts221_allocate_trigger(struct hts221_hw *hw, struct iio_dev *iio_dev);
 
 #endif /* HTS221_H */
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 9fb3f33614d4..48d469eeb0e6 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -72,10 +72,9 @@ static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-int hts221_allocate_trigger(struct hts221_hw *hw)
+int hts221_allocate_trigger(struct hts221_hw *hw, struct iio_dev *iio_dev)
 {
 	struct st_sensors_platform_data *pdata = dev_get_platdata(hw->dev);
-	struct iio_dev *iio_dev = iio_priv_to_dev(hw);
 	bool irq_active_low = false, open_drain = false;
 	unsigned long irq_type;
 	int err;
@@ -190,9 +189,9 @@ static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-int hts221_allocate_buffers(struct hts221_hw *hw)
+int hts221_allocate_buffers(struct hts221_hw *hw, struct iio_dev *iio_dev)
 {
-	return devm_iio_triggered_buffer_setup(hw->dev, iio_priv_to_dev(hw),
+	return devm_iio_triggered_buffer_setup(hw->dev, iio_dev,
 					NULL, hts221_buffer_handler_thread,
 					&hts221_buffer_ops);
 }
diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 9003671f14fb..77dfa65df841 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -621,11 +621,11 @@ int hts221_probe(struct device *dev, int irq, const char *name,
 	}
 
 	if (hw->irq > 0) {
-		err = hts221_allocate_buffers(hw);
+		err = hts221_allocate_buffers(hw, iio_dev);
 		if (err < 0)
 			return err;
 
-		err = hts221_allocate_trigger(hw);
+		err = hts221_allocate_trigger(hw, iio_dev);
 		if (err)
 			return err;
 	}
-- 
2.25.1

