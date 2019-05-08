Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC16518086
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2019 21:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfEHTgF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 15:36:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728132AbfEHTgE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 May 2019 15:36:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48JWNXW090564;
        Wed, 8 May 2019 15:35:40 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sc4j1tf7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 May 2019 15:35:39 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x48Dc5DA029662;
        Wed, 8 May 2019 13:39:49 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 2s92c40b32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 May 2019 13:39:49 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x48JZbLb5767586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 May 2019 19:35:37 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79971136051;
        Wed,  8 May 2019 19:35:37 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 038D513604F;
        Wed,  8 May 2019 19:35:36 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  8 May 2019 19:35:36 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 2/3] iio: dps310: Temperature measurement errata
Date:   Wed,  8 May 2019 14:35:27 -0500
Message-Id: <1557344128-690-3-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557344128-690-1-git-send-email-eajames@linux.ibm.com>
References: <1557344128-690-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905080119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Christopher Bostic <cbostic@linux.vnet.ibm.com>

Add a manufacturer's suggested workaround to deal with early revisions
of chip that don't indicate correct temperature. Readings can be in the
~60C range when they should be in the ~20's.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/iio/pressure/dps310.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 7afaa88..c42808e 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -221,6 +221,9 @@ static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
 	case DPS310_MEAS_CFG:
 	case DPS310_CFG_REG:
 	case DPS310_RESET:
+	case 0x0e:
+	case 0x0f:
+	case 0x62:
 		return true;
 	default:
 		return false;
@@ -237,6 +240,7 @@ static bool dps310_is_volatile_reg(struct device *dev, unsigned int reg)
 	case DPS310_TMP_B1:
 	case DPS310_TMP_B2:
 	case DPS310_MEAS_CFG:
+	case 0x32:
 		return true;
 	default:
 		return false;
@@ -314,7 +318,7 @@ static int dps310_read_raw(struct iio_dev *iio,
 	.writeable_reg = dps310_is_writeable_reg,
 	.volatile_reg = dps310_is_volatile_reg,
 	.cache_type = REGCACHE_RBTREE,
-	.max_register = 0x29,
+	.max_register = 0x62,
 };
 
 static const struct iio_info dps310_info = {
@@ -322,6 +326,47 @@ static int dps310_read_raw(struct iio_dev *iio,
 	.write_raw = dps310_write_raw,
 };
 
+/*
+ * Some verions of chip will read temperatures in the ~60C range when
+ * its actually ~20C. This is the manufacturer recommended workaround
+ * to correct the issue.
+ */
+static int dps310_temp_workaround(struct dps310_data *data)
+{
+	int r, reg;
+
+	r = regmap_read(data->regmap, 0x32, &reg);
+	if (r < 0)
+		return r;
+
+	/*
+	 * If bit 1 is set then the device is okay, and the workaround does not
+	 * need to be applied
+	 */
+	if (reg & BIT(1))
+		return 0;
+
+	r = regmap_write(data->regmap, 0x0e, 0xA5);
+	if (r < 0)
+		return r;
+
+	r = regmap_write(data->regmap, 0x0f, 0x96);
+	if (r < 0)
+		return r;
+
+	r = regmap_write(data->regmap, 0x62, 0x02);
+	if (r < 0)
+		return r;
+
+	r = regmap_write(data->regmap, 0x0e, 0x00);
+	if (r < 0)
+		return r;
+
+	r = regmap_write(data->regmap, 0x0f, 0x00);
+
+	return r;
+}
+
 static int dps310_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -383,6 +428,10 @@ static int dps310_probe(struct i2c_client *client,
 	if (r < 0)
 		goto err;
 
+	r = dps310_temp_workaround(data);
+	if (r < 0)
+		return r;
+
 	r = devm_iio_device_register(&client->dev, iio);
 	if (r)
 		goto err;
-- 
1.8.3.1

