Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735BC15525
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2019 22:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEFU7B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 May 2019 16:59:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726521AbfEFU7A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2019 16:59:00 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46KwNX4001162
        for <linux-iio@vger.kernel.org>; Mon, 6 May 2019 16:58:59 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sat10wtkp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Mon, 06 May 2019 16:58:58 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-iio@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 6 May 2019 21:58:58 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 21:58:55 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46KwsEN34930820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 20:58:54 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9463DAC05E;
        Mon,  6 May 2019 20:58:54 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7748AC059;
        Mon,  6 May 2019 20:58:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.3.116.186])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 May 2019 20:58:53 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/3] iio: dps310: Temperature measurement errata
Date:   Mon,  6 May 2019 20:58:34 +0000
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557176315-29401-1-git-send-email-eajames@linux.ibm.com>
References: <1557176315-29401-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19050620-0064-0000-0000-000003D9FFF7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011062; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01199563; UDB=6.00629333; IPR=6.00980439;
 MB=3.00026761; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-06 20:58:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050620-0065-0000-0000-00003D5D5770
Message-Id: <1557176315-29401-3-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060165
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
index 21d5dcb..3e03685 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -214,6 +214,9 @@ static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
 	case DPS310_MEAS_CFG:
 	case DPS310_CFG_REG:
 	case DPS310_RESET:
+	case 0x0e:
+	case 0x0f:
+	case 0x62:
 		return true;
 	default:
 		return false;
@@ -230,6 +233,7 @@ static bool dps310_is_volatile_reg(struct device *dev, unsigned int reg)
 	case DPS310_TMP_B1:
 	case DPS310_TMP_B2:
 	case DPS310_MEAS_CFG:
+	case 0x32:
 		return true;
 	default:
 		return false;
@@ -311,7 +315,7 @@ static const struct regmap_config dps310_regmap_config = {
 	.writeable_reg = dps310_is_writeable_reg,
 	.volatile_reg = dps310_is_volatile_reg,
 	.cache_type = REGCACHE_RBTREE,
-	.max_register = 0x29,
+	.max_register = 0x62,
 };
 
 static const struct iio_info dps310_info = {
@@ -319,6 +323,47 @@ static const struct iio_info dps310_info = {
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
@@ -380,6 +425,10 @@ static int dps310_probe(struct i2c_client *client,
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
2.7.4

