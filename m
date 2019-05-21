Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C0245DE
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2019 04:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfEUCNw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 22:13:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727192AbfEUCNv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 22:13:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L26ZRB016648
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2019 22:13:51 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sm6uear4w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2019 22:13:51 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-iio@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 21 May 2019 03:13:50 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 May 2019 03:13:48 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4L2Dlvx20775178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 02:13:47 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 745827805E;
        Tue, 21 May 2019 02:13:47 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFBA67805C;
        Tue, 21 May 2019 02:13:46 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 May 2019 02:13:46 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v4 2/3] iio: dps310: Temperature measurement errata
Date:   Mon, 20 May 2019 21:13:33 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558404814-26078-1-git-send-email-eajames@linux.ibm.com>
References: <1558404814-26078-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19052102-8235-0000-0000-00000E99D865
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011134; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01206296; UDB=6.00633418; IPR=6.00987257;
 MB=3.00026978; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-21 02:13:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052102-8236-0000-0000-000045A57227
Message-Id: <1558404814-26078-3-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210011
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
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/dps310.c | 52 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 9acfccb..a093e3a 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -53,7 +53,6 @@
 #define DPS310_RESET		0x0c
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
-#define DPS310_COEF_SRC		0x28
 
 /* Make sure sleep time is <= 20ms for usleep_range */
 #define DPS310_POLL_SLEEP_US(t)		min(20000, (t) / 8)
@@ -234,6 +233,10 @@ static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
 	case DPS310_MEAS_CFG:
 	case DPS310_CFG_REG:
 	case DPS310_RESET:
+	/* No documentation available on the registers below */
+	case 0x0e:
+	case 0x0f:
+	case 0x62:
 		return true;
 	default:
 		return false;
@@ -250,6 +253,7 @@ static bool dps310_is_volatile_reg(struct device *dev, unsigned int reg)
 	case DPS310_TMP_B1:
 	case DPS310_TMP_B2:
 	case DPS310_MEAS_CFG:
+	case 0x32:	/* No documentation available on this register */
 		return true;
 	default:
 		return false;
@@ -360,7 +364,7 @@ static void dps310_reset(void *action_data)
 	.writeable_reg = dps310_is_writeable_reg,
 	.volatile_reg = dps310_is_volatile_reg,
 	.cache_type = REGCACHE_RBTREE,
-	.max_register = DPS310_COEF_SRC,
+	.max_register = 0x62, /* No documentation available on this register */
 };
 
 static const struct iio_info dps310_info = {
@@ -368,6 +372,46 @@ static void dps310_reset(void *action_data)
 	.write_raw = dps310_write_raw,
 };
 
+/*
+ * Some verions of chip will read temperatures in the ~60C range when
+ * its actually ~20C. This is the manufacturer recommended workaround
+ * to correct the issue. The registers used below are undocumented.
+ */
+static int dps310_temp_workaround(struct dps310_data *data)
+{
+	int rc;
+	int reg;
+
+	rc = regmap_read(data->regmap, 0x32, &reg);
+	if (rc < 0)
+		return rc;
+
+	/*
+	 * If bit 1 is set then the device is okay, and the workaround does not
+	 * need to be applied
+	 */
+	if (reg & BIT(1))
+		return 0;
+
+	rc = regmap_write(data->regmap, 0x0e, 0xA5);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_write(data->regmap, 0x0f, 0x96);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_write(data->regmap, 0x62, 0x02);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_write(data->regmap, 0x0e, 0x00);
+	if (rc < 0)
+		return rc;
+
+	return regmap_write(data->regmap, 0x0f, 0x00);
+}
+
 static int dps310_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -439,6 +483,10 @@ static int dps310_probe(struct i2c_client *client,
 	if (rc < 0)
 		return rc;
 
+	rc = dps310_temp_workaround(data);
+	if (rc < 0)
+		return rc;
+
 	rc = devm_iio_device_register(&client->dev, iio);
 	if (rc)
 		return rc;
-- 
1.8.3.1

