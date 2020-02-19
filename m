Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24B5164735
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 15:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgBSOkf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 09:40:35 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:10906 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgBSOke (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 09:40:34 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JEandV007777;
        Wed, 19 Feb 2020 06:40:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=hLl3QPIq8SlVoRBagJpbEy83IJ5j7nGjeIIwQjYLbv4=;
 b=WEM8fsuUM335Ua0AtDJ1BRz2fXlVP7wWUbH8EaxOysXtmK7hzoq5hFwl2wF47DOWbm7F
 l6uxobLtxSc8QtdQOQw0Scb1W4TZ4TzFFKRb1GHpPIqprOQqODHA8qqTg8cwDXYWZuYH
 fmdrKcBjYxO5irLx5gioTqo6yaHSUsPW2oFUXVfcg58WZWcl3S4OBJHwyWuOEwhFEyaa
 MTlbQGCpE8SwYHiujQEOUvDXzHIxbXBzgpbEG7OPXOXL4dOcxXGYMYCtnYw+PududtO4
 6Km9NVYmSzLvDezheu5QDO4HlqDP3KPz0eLqcyxSZQmfsS/7x3GFr2JQHXFCYYtQXYTF cw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0b-00328301.pphosted.com with ESMTP id 2y8uc908h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 06:40:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URXycUyyzUbM74FR1MTBd44sb5f7sJFuEmjLXfAHJ6I3oSUtBn1QuiPCxGp5jZm6q0Sv8iVDEe4s+kTgUdbc39x6ORIoFz5TQCv+V7xam46gDg14FcX1rdIbaj/ZDqfnhlanDxr1t477ZJIfEg4TpYjo5YXAK4TIWPObvk8GCUvFQYR+mu6cF0lfWaG05w/TnaabnpQTjgHbu9BcxNbtUYe4VS+50kTcb2+1idEqnvcYWmo7vQ2wa5qoiQYK7joFTsr7bMDxKegAVEgnc6BoJUVj9nlWIjpBrzZ+k0fPdoPaiSjLNJQyszvFIxlM66cHjpxuBfUkSnaa1GWHyBQJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLl3QPIq8SlVoRBagJpbEy83IJ5j7nGjeIIwQjYLbv4=;
 b=jIeY+izFF4TZl0yQMIu0GR/SHa/dD6x7+dgBKOTkQrJUITOf9Q7srpy4UcddIYlPO4YaqTNhqaLHhuRJd1r6RnHGmW4RESX+dlU0ug09AGplCMWxnxzrpHo/+7nc3glqWStQJZ1cXU/zGa5SEYDNtQvMEiB1gakRzwfZMtF7EGR0F7ACQ7cn7IfzPLVcWXIB8JFlK5/Oy3k5WlAA41ih+qS1c+BaoB8IAoVfBLfOcWqLL35ZRTQxS4IU+1b6ZJ4pVYHbxzzNSR1dnnlcz6Qsh1x1rfHhYYJ9HpSu3nLABtox5IH7+gJNJoh9tdOuAhPg9J0v9tbaLLkHcPMuEBoGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLl3QPIq8SlVoRBagJpbEy83IJ5j7nGjeIIwQjYLbv4=;
 b=XFTopTSUoWrn2dK1s5Qbr+vqyMDZCLZEuL7bnX4W4Ox+u+0ySq7yB+jLefMjpgiEMFlvQyyCZQ9GrANrJV6+JgqsrinXgHDHxnnfp9Mv2VMAwgFRRaUzjzGauz/8m6AHROeZhtESH8QD451vVy+EbgNsiPPJRuFa/08JP1ukstc=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB3878.namprd12.prod.outlook.com (52.132.245.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 14:40:29 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 14:40:29 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 01/13] iio: imu: inv_mpu6050: enable i2c aux mux bypass only once
Date:   Wed, 19 Feb 2020 15:39:46 +0100
Message-Id: <20200219143958.3548-2-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219143958.3548-1-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 14:40:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c732267-2607-4c6e-4859-08d7b549aa5c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB38785ED90358CC7935512054C4100@CH2PR12MB3878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39850400004)(136003)(366004)(189003)(199004)(2906002)(5660300002)(7696005)(36756003)(16526019)(6666004)(81166006)(26005)(956004)(2616005)(52116002)(186003)(1076003)(81156014)(8936002)(86362001)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(107886003)(478600001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3878;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdbXtPbWimmj+K+iRNrRV7496fFY+1eaghldQINSlCLFLoNxiwj6kNJeSJimbzXEbR34FgTDRO9WPr5tAswan8e2qtS5ycuwy1XL7Pz6Jto7TRGMQIeR1JkLvCvI7RtAZrCpMd3+pMkun+12kcYwVlRxkpMQnRlCTT32VHqeqQShFUp5kpxC50HKfSaC84Ife0i9D8c59U5NETKa7KbgDwxGarjiCNO88jq4LtxwNUTvF9fsKD81OPeRHvUqbrt0jvTz/neYKtwA/S2eR2hElpk/JpdVtmqx3V+q84UStWbzoAWHQD/vOQYwiDF1tLzE+blJZ5mwHAz4xcvcxe72bMgGQp1G3ls8W7cYmiRBQTFMrngsV1AwUH91MQK58Hut7HXvAzkFxTmb0puZGFzU+Pv0kRoxc+5qoqfAK3ZdAhwszZNda8OAoB7sruHzHGUP
X-MS-Exchange-AntiSpam-MessageData: D/VJqPdRHKwZ9NXFXsX9IoIf0a2/zgxl7byLQvFz4B3od4iHnoD2ggyL0lcP4s4eTOObd27IXXHZgWI6eLkZC6URlycl71mKpcYlhGe65iEj+JREza1sFjXn2VfO7YahfhGC137hmqSVCJLos8+KRg==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c732267-2607-4c6e-4859-08d7b549aa5c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:40:29.5103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YggF4C4wkJUjoAcqbJCh+BT8NTzLDBaHx1heuYWPRLejxPWNxJyoyVV8MsVqyMXPuTUAGUVlNel0p21oFyinqdYe6ax+Yx/1h9mpgBfDdhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3878
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190113
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

i2c auxiliary mux is done by analog switches. You do not need to
set them for every i2c transfer.
Just set i2c bypass bit at init and do noting in i2c de/select.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 71 +++++++++--------------
 1 file changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 1363d3776523..24df880248f2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -20,38 +20,6 @@ static const struct regmap_config inv_mpu_regmap_config = {
 
 static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
 {
-	struct iio_dev *indio_dev = i2c_mux_priv(muxc);
-	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&st->lock);
-
-	ret = inv_mpu6050_set_power_itg(st, true);
-	if (ret)
-		goto error_unlock;
-
-	ret = regmap_write(st->map, st->reg->int_pin_cfg,
-			   st->irq_mask | INV_MPU6050_BIT_BYPASS_EN);
-
-error_unlock:
-	mutex_unlock(&st->lock);
-
-	return ret;
-}
-
-static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
-{
-	struct iio_dev *indio_dev = i2c_mux_priv(muxc);
-	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->lock);
-
-	/* It doesn't really matter if any of the calls fail */
-	regmap_write(st->map, st->reg->int_pin_cfg, st->irq_mask);
-	inv_mpu6050_set_power_itg(st, false);
-
-	mutex_unlock(&st->lock);
-
 	return 0;
 }
 
@@ -79,19 +47,20 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
 	}
 }
 
-/*
- * MPU9xxx magnetometer support requires to disable i2c auxiliary bus support.
- * To ensure backward compatibility with existing setups, do not disable
- * i2c auxiliary bus if it used.
- * Check for i2c-gate node in devicetree and set magnetometer disabled.
- * Only MPU6500 is supported by ACPI, no need to check.
- */
-static int inv_mpu_magn_disable(struct iio_dev *indio_dev)
+static int inv_mpu_i2c_aux_setup(struct iio_dev *indio_dev)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
 	struct device_node *mux_node;
+	int ret;
 
+	/*
+	 * MPU9xxx magnetometer support requires to disable i2c auxiliary bus.
+	 * To ensure backward compatibility with existing setups, do not disable
+	 * i2c auxiliary bus if it used.
+	 * Check for i2c-gate node in devicetree and set magnetometer disabled.
+	 * Only MPU6500 is supported by ACPI, no need to check.
+	 */
 	switch (st->chip_type) {
 	case INV_MPU9150:
 	case INV_MPU9250:
@@ -107,7 +76,24 @@ static int inv_mpu_magn_disable(struct iio_dev *indio_dev)
 		break;
 	}
 
+	/* enable i2c bypass when using i2c auxiliary bus */
+	if (inv_mpu_i2c_aux_bus(dev)) {
+		ret = inv_mpu6050_set_power_itg(st, true);
+		if (ret)
+			return ret;
+		ret = regmap_write(st->map, st->reg->int_pin_cfg,
+				   st->irq_mask | INV_MPU6050_BIT_BYPASS_EN);
+		if (ret)
+			goto error;
+		ret = inv_mpu6050_set_power_itg(st, false);
+		if (ret)
+			goto error;
+	}
+
 	return 0;
+error:
+	inv_mpu6050_set_power_itg(st, false);
+	return ret;
 }
 
 /**
@@ -151,7 +137,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 	}
 
 	result = inv_mpu_core_probe(regmap, client->irq, name,
-				    inv_mpu_magn_disable, chip_type);
+				    inv_mpu_i2c_aux_setup, chip_type);
 	if (result < 0)
 		return result;
 
@@ -160,8 +146,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 		/* declare i2c auxiliary bus */
 		st->muxc = i2c_mux_alloc(client->adapter, &client->dev,
 					 1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
-					 inv_mpu6050_select_bypass,
-					 inv_mpu6050_deselect_bypass);
+					 inv_mpu6050_select_bypass, NULL);
 		if (!st->muxc)
 			return -ENOMEM;
 		st->muxc->priv = dev_get_drvdata(&client->dev);
-- 
2.17.1

