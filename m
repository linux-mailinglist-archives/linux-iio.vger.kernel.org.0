Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3D81C907A
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 16:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgEGOnh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 10:43:37 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:38060 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727797AbgEGOnc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 10:43:32 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047EfNHW007275;
        Thu, 7 May 2020 07:43:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=IOHOvLupLHGO/eT7yFbBKakOdBLzPKmB/GYgdC4b4Zw=;
 b=gfDcJnwF2AgYp8TJbyQcZ22oRRcsQ2sjcl6mhcmSFkeFtv7QSMZqnf6HKaIL92vplbSB
 FnwI3wEmAo9qHw8gcNC40uOQu0ShUB53xiH0g53qxjQEgNWyhZ5ykSINC7rNMw/R1jyE
 /PUnvUMNg9sMwRjFyGJxwUfV8b8jTdpldvR7ZyZLFN85i4P9G8SDQZE2y+JJmrQsd5E1
 4/WkUMBkqyUrVT4Qc/wqd0DyczrA9vQ7J2bBYwWfPyayPOMzTfvtdlDteDfOelRfNEiq
 JxA4f3c4UwtxJrpJfyKxmt2iFVEU/jzVJpFfatgZcnVkfzPxkeNY8Q7rzcoy42wxMnk+ EQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00328301.pphosted.com with ESMTP id 30sfwdjs8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:43:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKwMNi4MXWdL2XIkcn8P1ya9auByPbIVPKEjmnYAaTjc4gUaB2PRCmzeuWkOIlHFKkrEZHlFdTurYvc4klYPk7u41sxGY24c0t0BINWVlZqNBJLfQ9ocN6nEPOh9F8POpz3FnqdtDWMt/aZk0FUNwGQbGrAJCpN9iLZfFCHI+85Wbz2HoFD5bDcfJE4vZZouKuEl6M+Vq7b8ewCeCr1luB009Twdvic1r2IRxZqfC85qN+HcmZeyQBZDYwmhApVhFBGv4D7waVj0RgXeA42+yz45pA8mfNbHV+UNju3SIzWxZZ+ziqVV/QjxSv2OOcCng4OpyFjzBpploeR3YbmDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOHOvLupLHGO/eT7yFbBKakOdBLzPKmB/GYgdC4b4Zw=;
 b=SSRxeSfcAWdJHy2yhCMkFm1YyR7JXKh8HKhX2hod0/ZH5P7WvlnW9lvHkXFKmmfpbjYE3MDZZsCUvo4li9MJSc6zWFdeH2BdQnTr6JDs9f1xVQNxXfEivldlBToGkOwfjLav+NiJP0RsL+eDqJwSwCdb0UcPBhVqnoG8SlnSn25Zziytw8fYgZGQ5yb0ZMSlZUo7b+cuvxmaY4zusH5oXydHEJUCRYs90GVOMZesUbzLokuEUWL2H3JrGJuhZzOCGmDnfOcXrsqQ4jl9abZxE5u8HVefcpHVQenjQi2orIg43TnkzpMmemQDv97QLTFTfQ05SYaxyTrSNIwDad3Rqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOHOvLupLHGO/eT7yFbBKakOdBLzPKmB/GYgdC4b4Zw=;
 b=Zd5EpjjtJULQTw5qtGrY+nArbuu2WZcDlwlkJ48VY+E0uKfqQArl+5mEYQR02or6v0wEi3F+OzFAXporzHrCRicZorIH3ym/mNod0ASig6BeUOoM0Ybe5RQpit+zft/XGeEw8d0Gi4UDI32eKU+Z4zdNz7+Bt7N0SG2E3aUQye4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 7 May
 2020 14:43:25 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 14:43:25 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 10/12] iio: imu: inv_icm42600: add accurate timestamping
Date:   Thu,  7 May 2020 16:42:20 +0200
Message-Id: <20200507144222.20989-11-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507144222.20989-1-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 14:43:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4c10859-9b64-46f8-765b-08d7f294ff75
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB450194C16BA75889C65B73B8C4A50@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:199;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgGJ/m+ekSLx8Eaw+S/FemnCiBehtKG7iJQxQI7cq+eKmLZvHo6NY8spRi/Xmdbn+VB9UwBLxxmxFbSQq4bvyH4uZ116yz1F7C+hN8v3Mzte8z7gsxebDPuReN7CvwjwocA20xM5edWAa/N0JxoFvEu4sQrxg6qfTuSDbyTnbrF2K2dOM8z94VoZRORW/D4q0DLnqvEJeMpovQXebY+r1T6wAOSu4VI4oucMrlm9WYoax43rI1ga/9NM52KQ+1DwImUIGBdb8E0SdYbhYGhyi0TWylX5aeAW4m7JNlsx5k0ACOLDZdOAAa3NNS2OO3jHTIEIPxpr7oAJiyhZy7K9qYzbqgcokaUpFRfgFPm/mEutI2Fc96TJI2dkFiMmTzU0MdJfDaPAc5ATEI88vBegECtsZzvI9VKDcCgfhPi9y8X9Aypp48/qdvFqoWnl+uqbzhvK3JuAp0r+2gOSihyXTAs/kRPc6X5HJIBoFiwTi60bOXd9lgk4mIKKE6T1OEHiJogdHmaIWb7Li86WKE5hwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(396003)(39850400004)(366004)(33430700001)(30864003)(107886003)(4326008)(8676002)(6486002)(2906002)(316002)(5660300002)(8936002)(1076003)(26005)(7696005)(33440700001)(66946007)(956004)(66476007)(52116002)(2616005)(86362001)(186003)(83320400001)(83280400001)(83310400001)(83290400001)(16526019)(478600001)(36756003)(66556008)(83300400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BDaUFnv4JeGQm+HPXzGb5MCysx++BUs9ewy30nlmYLyySMhIgP+jXe/zKz8tWgJ15fCp7pSyh6sCD1CDzLERnjUFtJB+xNAYqfhsnjPKxZKAn1uK0blklwicCL+wMPUXRJboRwQivENISrI3znbw2/p48fOU2fnyXgsZqyKMbc/3u0Kb8BH3m4lHRAhSaINEoFuzozs3OYskHMB87jjCdUi1Np0svuXZo0f2LFvsm4+3bOrdd6IWVs8oorYcJlKjvoNNya3zFjRQC0xOKG1wmvtzZhYbT9ac61+upIPTHCeYCvQM1OgeEK1A3uCNQhKd+sP4XDvoHEBfzsZWnp4/i/tAncDz/CohvH8uJUqt97uB4yeaqXsFoR/AlPgx/6qhBiQFWJfACkqdxwA0YpuYc20OEU2BcnRYEtw8VbI4BSnCWIyvuIxTC4Dh2eqUTgtmxmabCVsP4WeHZz7wk32+veftxVe1bKSmzMbWDW4sxK7/eZ4deOWYaB4xgeee8tKkzrectZiDhqvYAJwAcRVy2jArv8Q4Jd4TVxpTl1Q7BnzzkmzPJl7Txcs7vh72K+t69xtZqUmNzMO2XhluPiVQDaYU96T+1Q5px+r8NfaxN8gP4IkvJxgLEasroFvqWtl4X/K7f8s7l7kSr86sYPSfZvQ59bNGM2ofILzdldEhlOEeG+kdFqcqpeso1KZ3x9CSnzr4lu00qPv4K7Tka63Wbzzs0Ds6J4gfB0uwrnG1KKL/asQ/0XVng93pwWdJ+Tk3GVHf4zTOm5h7owKRIJNHFFP+D5/MiSA+sz/VCGU6FGM=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c10859-9b64-46f8-765b-08d7f294ff75
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 14:43:25.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkVD0QM6Nlcr/2FV2GzWwdaO8OfsAZ28fj2XzlSgzbYBJTPjoq0Pyv0YJRjM/zr9AP6sa4KsE6YHOuwZ9S5upLs2L8Ud30XzYl2j3hicjTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_09:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a timestamp channel with processed value that returns full
precision 20 bits timestamp.

Add a timestamping mechanism for buffer that provides accurate
event timestamps when using watermark. This mechanism estimates
device internal clock by comparing FIFO interrupts delta time and
corresponding device elapsed time computed by parsing FIFO data.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/Makefile         |   1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  10 +-
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c |  32 ++-
 .../imu/inv_icm42600/inv_icm42600_buffer.c    |  28 +-
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |   6 +
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  |  32 ++-
 .../imu/inv_icm42600/inv_icm42600_timestamp.c | 246 ++++++++++++++++++
 .../imu/inv_icm42600/inv_icm42600_timestamp.h |  82 ++++++
 8 files changed, 421 insertions(+), 16 deletions(-)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h

diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_icm42600/Makefile
index d6732118010c..1197b545a682 100644
--- a/drivers/iio/imu/inv_icm42600/Makefile
+++ b/drivers/iio/imu/inv_icm42600/Makefile
@@ -7,6 +7,7 @@ inv-icm42600-y += inv_icm42600_accel.o
 inv-icm42600-y += inv_icm42600_temp.o
 inv-icm42600-y += inv_icm42600_trigger.o
 inv-icm42600-y += inv_icm42600_buffer.o
+inv-icm42600-y += inv_icm42600_timestamp.o
 
 obj-$(CONFIG_INV_ICM42600_I2C) += inv-icm42600-i2c.o
 inv-icm42600-i2c-y += inv_icm42600_i2c.o
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 947ca4dd245b..e15eddafe009 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -16,6 +16,7 @@
 #include <linux/iio/trigger.h>
 
 #include "inv_icm42600_buffer.h"
+#include "inv_icm42600_timestamp.h"
 
 enum inv_icm42600_chip {
 	INV_CHIP_ICM42600,
@@ -127,6 +128,7 @@ struct inv_icm42600_suspended {
  *  @indio_accel:	accelerometer IIO device.
  *  @trigger:		device internal interrupt trigger
  *  @fifo:		FIFO management structure.
+ *  @timestamp:		timestamp management structure.
  */
 struct inv_icm42600_state {
 	struct mutex lock;
@@ -142,6 +144,10 @@ struct inv_icm42600_state {
 	struct iio_dev *indio_accel;
 	struct iio_trigger *trigger;
 	struct inv_icm42600_fifo fifo;
+	struct {
+		struct inv_icm42600_timestamp gyro;
+		struct inv_icm42600_timestamp accel;
+	} timestamp;
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
@@ -382,11 +388,11 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 
 int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
 
-int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev, int64_t ts);
+int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev);
 
 int inv_icm42600_accel_init(struct inv_icm42600_state *st);
 
-int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev, int64_t ts);
+int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);
 
 int inv_icm42600_trigger_init(struct inv_icm42600_state *st, int irq,
 			      int irq_type);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 4206be54d057..ac140c824c03 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -17,6 +17,7 @@
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
 #include "inv_icm42600_buffer.h"
+#include "inv_icm42600_timestamp.h"
 
 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
 	{								\
@@ -66,7 +67,7 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 	INV_ICM42600_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42600_ACCEL_SCAN_Z,
 				inv_icm42600_accel_ext_infos),
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP),
-	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_ACCEL_SCAN_TIMESTAMP),
+	INV_ICM42600_TIMESTAMP_CHAN(INV_ICM42600_ACCEL_SCAN_TIMESTAMP),
 };
 
 /* IIO buffer data */
@@ -94,14 +95,20 @@ static irqreturn_t inv_icm42600_accel_handler(int irq, void *_data)
 	struct iio_poll_func *pf = _data;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = &st->timestamp.accel;
 	const size_t fifo_nb = st->fifo.nb.total;
+	const size_t accel_nb = st->fifo.nb.accel;
+	const uint32_t fifo_period = st->fifo.period;
 	int ret;
 
 	/* exit if no sample */
 	if (fifo_nb == 0)
 		goto out;
 
-	ret = inv_icm42600_accel_parse_fifo(indio_dev, pf->timestamp);
+	inv_icm42600_timestamp_interrupt(ts, fifo_period, fifo_nb, accel_nb,
+					 pf->timestamp);
+
+	ret = inv_icm42600_accel_parse_fifo(indio_dev);
 	if (ret)
 		dev_err(regmap_get_device(st->map), "accel fifo error %d\n",
 			ret);
@@ -143,6 +150,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write and FIFO watermark */
+	inv_icm42600_timestamp_apply_odr(&st->timestamp.accel, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 	if (ret)
 		goto out_unlock;
@@ -347,6 +355,7 @@ static int inv_icm42600_accel_write_odr(struct inv_icm42600_state *st,
 	mutex_lock(&st->lock);
 	conf.odr = inv_icm42600_accel_odr_conv[idx / 2];
 	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
+	inv_icm42600_timestamp_update_odr(&st->timestamp.accel, conf.odr);
 	inv_icm42600_buffer_update_fifo_period(st);
 	inv_icm42600_buffer_update_watermark(st);
 	mutex_unlock(&st->lock);
@@ -502,6 +511,9 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
 	case IIO_TEMP:
 		return inv_icm42600_temp_read_raw(indio_dev, chan, val, val2,
 						  mask);
+	case IIO_TIMESTAMP:
+		return inv_icm42600_timestamp_read_raw(indio_dev, chan, val,
+						       val2, mask);
 	default:
 		return -EINVAL;
 	}
@@ -694,13 +706,18 @@ int inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	return devm_iio_device_register(dev, st->indio_accel);
 }
 
-int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev, int64_t ts)
+int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = &st->timestamp.accel;
+	const size_t fifo_nb = st->fifo.nb.total;
 	const size_t accel_nb = st->fifo.nb.accel;
+	const uint32_t fifo_period = st->fifo.period;
 	ssize_t i, size;
+	unsigned int no;
 	const void *accel, *gyro, *temp, *timestamp;
 	unsigned int odr;
+	int64_t ts_val;
 	struct inv_icm42600_accel_buffer buffer;
 
 	/* exit if no accel sample */
@@ -708,7 +725,7 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev, int64_t ts)
 		return 0;
 
 	/* parse all fifo packets */
-	for (i = 0; i < st->fifo.count; i += size) {
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
 		size = inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
 				&accel, &gyro, &temp, &timestamp, &odr);
 		dev_dbg(regmap_get_device(st->map), "accel packet size = %zd\n",
@@ -721,9 +738,14 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev, int64_t ts)
 			dev_dbg(regmap_get_device(st->map), "skip accel data\n");
 			continue;
 		}
+		/* update odr */
+		if (odr & INV_ICM42600_SENSOR_ACCEL)
+			inv_icm42600_timestamp_apply_odr(ts, fifo_period,
+							 fifo_nb, no);
 		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
 		memcpy(&buffer.temp, temp, sizeof(buffer.temp));
-		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts);
+		ts_val = inv_icm42600_timestamp_get(ts);
+		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
 	}
 
 	return 0;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index b428abdc92ee..bea4c9810da7 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -15,6 +15,7 @@
 #include <linux/iio/trigger_consumer.h>
 
 #include "inv_icm42600.h"
+#include "inv_icm42600_timestamp.h"
 #include "inv_icm42600_buffer.h"
 
 void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *st)
@@ -194,14 +195,17 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	unsigned int *watermark;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int sleep = 0;
+	struct inv_icm42600_timestamp *ts;
 	int ret;
 
 	if (indio_dev == st->indio_gyro) {
 		sensor = INV_ICM42600_SENSOR_GYRO;
 		watermark = &st->fifo.watermark.gyro;
+		ts = &st->timestamp.gyro;
 	} else if (indio_dev == st->indio_accel) {
 		sensor = INV_ICM42600_SENSOR_ACCEL;
 		watermark = &st->fifo.watermark.accel;
+		ts = &st->timestamp.accel;
 	} else {
 		return -EINVAL;
 	}
@@ -223,6 +227,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	else
 		ret = inv_icm42600_set_accel_conf(st, &conf, &sleep);
 
+	inv_icm42600_timestamp_reset(ts);
+
 out_unlock:
 	mutex_unlock(&st->lock);
 	if (sleep)
@@ -316,11 +322,25 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 	if (st->fifo.nb.total == 0)
 		return 0;
 
-	ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro, ts_gyro);
-	if (ret)
-		return ret;
+	if (st->fifo.nb.gyro > 0) {
+		inv_icm42600_timestamp_interrupt(&st->timestamp.gyro,
+					     st->fifo.period, st->fifo.nb.total,
+					     st->fifo.nb.gyro, ts_gyro);
+		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
+		if (ret)
+			return ret;
+	}
 
-	return inv_icm42600_accel_parse_fifo(st->indio_accel, ts_accel);
+	if (st->fifo.nb.accel > 0) {
+		inv_icm42600_timestamp_interrupt(&st->timestamp.accel,
+					     st->fifo.period, st->fifo.nb.total,
+					     st->fifo.nb.accel, ts_accel);
+		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
 }
 
 int inv_icm42600_buffer_init(struct inv_icm42600_state *st)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 689089065ff9..563c4348de01 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -15,6 +15,7 @@
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_buffer.h"
+#include "inv_icm42600_timestamp.h"
 
 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] = {
 	{
@@ -516,6 +517,11 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 	if (ret)
 		return ret;
 
+	/* initialize timestamping */
+	ret = inv_icm42600_timestamp_init(st);
+	if (ret)
+		return ret;
+
 	/* setup FIFO buffer */
 	ret = inv_icm42600_buffer_init(st);
 	if (ret)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index dafb104abc77..1245588170bd 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -17,6 +17,7 @@
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
 #include "inv_icm42600_buffer.h"
+#include "inv_icm42600_timestamp.h"
 
 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)		\
 	{								\
@@ -66,7 +67,7 @@ static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
 	INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_SCAN_Z,
 			       inv_icm42600_gyro_ext_infos),
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_GYRO_SCAN_TEMP),
-	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_GYRO_SCAN_TIMESTAMP),
+	INV_ICM42600_TIMESTAMP_CHAN(INV_ICM42600_GYRO_SCAN_TIMESTAMP),
 };
 
 /* IIO buffer data */
@@ -94,14 +95,20 @@ static irqreturn_t inv_icm42600_gyro_handler(int irq, void *_data)
 	struct iio_poll_func *pf = _data;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = &st->timestamp.gyro;
 	const size_t fifo_nb = st->fifo.nb.total;
+	const size_t gyro_nb = st->fifo.nb.gyro;
+	const uint32_t fifo_period = st->fifo.period;
 	int ret;
 
 	/* exit if no sample */
 	if (fifo_nb == 0)
 		goto out;
 
-	ret = inv_icm42600_gyro_parse_fifo(indio_dev, pf->timestamp);
+	inv_icm42600_timestamp_interrupt(ts, fifo_period, fifo_nb, gyro_nb,
+					 pf->timestamp);
+
+	ret = inv_icm42600_gyro_parse_fifo(indio_dev);
 	if (ret)
 		dev_err(regmap_get_device(st->map), "gyro fifo error %d\n",
 			ret);
@@ -143,6 +150,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write and FIFO watermark */
+	inv_icm42600_timestamp_apply_odr(&st->timestamp.gyro, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 	if (ret)
 		goto out_unlock;
@@ -359,6 +367,7 @@ static int inv_icm42600_gyro_write_odr(struct inv_icm42600_state *st,
 	mutex_lock(&st->lock);
 	conf.odr = inv_icm42600_gyro_odr_conv[idx / 2];
 	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
+	inv_icm42600_timestamp_update_odr(&st->timestamp.gyro, conf.odr);
 	inv_icm42600_buffer_update_fifo_period(st);
 	inv_icm42600_buffer_update_watermark(st);
 	mutex_unlock(&st->lock);
@@ -514,6 +523,9 @@ static int inv_icm42600_gyro_read_raw(struct iio_dev *indio_dev,
 	case IIO_TEMP:
 		return inv_icm42600_temp_read_raw(indio_dev, chan, val, val2,
 						  mask);
+	case IIO_TIMESTAMP:
+		return inv_icm42600_timestamp_read_raw(indio_dev, chan, val,
+						       val2, mask);
 	default:
 		return -EINVAL;
 	}
@@ -706,13 +718,18 @@ int inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	return devm_iio_device_register(dev, st->indio_gyro);
 }
 
-int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev, int64_t ts)
+int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = &st->timestamp.gyro;
+	const size_t fifo_nb = st->fifo.nb.total;
 	const size_t gyro_nb = st->fifo.nb.gyro;
+	const uint32_t fifo_period = st->fifo.period;
 	ssize_t i, size;
+	unsigned int no;
 	const void *accel, *gyro, *temp, *timestamp;
 	unsigned int odr;
+	int64_t ts_val;
 	struct inv_icm42600_gyro_buffer buffer;
 
 	/* exit if no gyro sample */
@@ -720,7 +737,7 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev, int64_t ts)
 		return 0;
 
 	/* parse all fifo packets */
-	for (i = 0; i < st->fifo.count; i += size) {
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
 		size = inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
 				&accel, &gyro, &temp, &timestamp, &odr);
 		dev_dbg(regmap_get_device(st->map), "gyro packet size = %zd\n",
@@ -733,9 +750,14 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev, int64_t ts)
 			dev_dbg(regmap_get_device(st->map), "skip gyro data\n");
 			continue;
 		}
+		/* update odr */
+		if (odr & INV_ICM42600_SENSOR_GYRO)
+			inv_icm42600_timestamp_apply_odr(ts, fifo_period,
+							 fifo_nb, no);
 		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
 		memcpy(&buffer.temp, temp, sizeof(buffer.temp));
-		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts);
+		ts_val = inv_icm42600_timestamp_get(ts);
+		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
 	}
 
 	return 0;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
new file mode 100644
index 000000000000..79cf777e2e84
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/math64.h>
+#include <linux/iio/iio.h>
+
+#include "inv_icm42600.h"
+#include "inv_icm42600_timestamp.h"
+
+/* internal chip period is 32kHz, 31250ns */
+#define INV_ICM42600_TIMESTAMP_PERIOD		31250
+/* allow a jitter of +/- 2% */
+#define INV_ICM42600_TIMESTAMP_JITTER		2
+/* compute min and max periods accepted */
+#define INV_ICM42600_TIMESTAMP_MIN_PERIOD(_p)		\
+	(((_p) * (100 - INV_ICM42600_TIMESTAMP_JITTER)) / 100)
+#define INV_ICM42600_TIMESTAMP_MAX_PERIOD(_p)		\
+	(((_p) * (100 + INV_ICM42600_TIMESTAMP_JITTER)) / 100)
+
+static void inv_update_acc(struct inv_icm42600_timestamp_acc *acc, uint32_t val)
+{
+	uint64_t sum = 0;
+	size_t i;
+
+	acc->values[acc->idx++] = val;
+	if (acc->idx >= ARRAY_SIZE(acc->values))
+		acc->idx = 0;
+
+	for (i = 0; i < ARRAY_SIZE(acc->values); ++i) {
+		if (acc->values[i] == 0)
+			break;
+		sum += acc->values[i];
+	}
+
+	acc->val = div_u64(sum, i);
+}
+
+static int inv_icm42600_timestamp_read(struct inv_icm42600_state *st,
+				       uint32_t *ts)
+{
+	struct device *dev = regmap_get_device(st->map);
+	__le32 raw;
+	int ret;
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&st->lock);
+
+	ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
+			   INV_ICM42600_SIGNAL_PATH_RESET_TMST_STROBE);
+	if (ret)
+		goto exit;
+
+	/* Read timestamp value 3 registers little-endian */
+	raw = 0;
+	ret = regmap_bulk_read(st->map, INV_ICM42600_REG_TMSTVAL, &raw, 3);
+	if (ret)
+		goto exit;
+
+	*ts = (uint32_t)le32_to_cpu(raw);
+exit:
+	mutex_unlock(&st->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+int inv_icm42600_timestamp_read_raw(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    int *val, int *val2, long mask)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	uint32_t ts;
+	int ret;
+
+	if (chan->type != IIO_TIMESTAMP)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = inv_icm42600_timestamp_read(st, &ts);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		*val = ts * 1000;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static void inv_icm42600_init_ts(struct inv_icm42600_timestamp *ts,
+				 struct device *dev, uint32_t period)
+{
+	/* initial odr for sensor is 1kHz */
+	const uint32_t default_period = 1000000;
+
+	ts->dev = dev;
+	ts->mult = default_period / INV_ICM42600_TIMESTAMP_PERIOD;
+	ts->new_mult = period / INV_ICM42600_TIMESTAMP_PERIOD;
+	ts->period = default_period;
+
+	/* use theoretical value for chip period */
+	inv_update_acc(&ts->chip_period, INV_ICM42600_TIMESTAMP_PERIOD);
+}
+
+int inv_icm42600_timestamp_init(struct inv_icm42600_state *st)
+{
+	unsigned int val;
+
+	inv_icm42600_init_ts(&st->timestamp.gyro, regmap_get_device(st->map),
+			     inv_icm42600_odr_to_period(st->conf.gyro.odr));
+	inv_icm42600_init_ts(&st->timestamp.accel, regmap_get_device(st->map),
+			     inv_icm42600_odr_to_period(st->conf.accel.odr));
+
+	/* enable timestamp register */
+	val = INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN |
+	      INV_ICM42600_TMST_CONFIG_TMST_EN;
+	return regmap_update_bits(st->map, INV_ICM42600_REG_TMST_CONFIG,
+				  INV_ICM42600_TMST_CONFIG_MASK, val);
+}
+
+void inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
+				       int odr)
+{
+	uint32_t period;
+
+	period = inv_icm42600_odr_to_period(odr);
+	ts->new_mult = period / INV_ICM42600_TIMESTAMP_PERIOD;
+	dev_dbg(ts->dev, "ts new mult: %u\n", ts->new_mult);
+}
+
+static bool inv_validate_period(uint32_t period, uint32_t mult)
+{
+	const uint32_t chip_period = INV_ICM42600_TIMESTAMP_PERIOD;
+	uint32_t period_min, period_max;
+
+	/* check that time interval between interrupts is acceptable */
+	period_min = INV_ICM42600_TIMESTAMP_MIN_PERIOD(chip_period) * mult;
+	period_max = INV_ICM42600_TIMESTAMP_MAX_PERIOD(chip_period) * mult;
+	if (period > period_min && period < period_max)
+		return true;
+	else
+		return false;
+}
+
+static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,
+				    uint32_t mult, uint32_t period)
+{
+	uint32_t new_chip_period;
+
+	if (!inv_validate_period(period, mult))
+		return false;
+
+	/* update chip internal period estimation */
+	new_chip_period = period / mult;
+	inv_update_acc(&ts->chip_period, new_chip_period);
+
+	dev_dbg(ts->dev, "ts chip period: %u - val %u\n", new_chip_period,
+		ts->chip_period.val);
+
+	return true;
+}
+
+void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
+				      uint32_t fifo_period, size_t fifo_nb,
+				      size_t sensor_nb, int64_t timestamp)
+{
+	struct inv_icm42600_timestamp_interval *it;
+	int64_t delta, interval;
+	const uint32_t fifo_mult = fifo_period / INV_ICM42600_TIMESTAMP_PERIOD;
+	uint32_t period = ts->period;
+	int32_t m;
+	bool valid = false;
+
+	if (fifo_nb == 0)
+		return;
+
+	/* update interrupt timestamp and compute chip and sensor periods */
+	it = &ts->it;
+	it->lo = it->up;
+	it->up = timestamp;
+	delta = it->up - it->lo;
+	dev_dbg(ts->dev, "ts it: %lld - %lld - %lld\n", it->lo, it->up, delta);
+	if (it->lo != 0) {
+		period = div_s64(delta, fifo_nb);
+		valid = inv_compute_chip_period(ts, fifo_mult, period);
+		if (valid)
+			ts->period = ts->mult * ts->chip_period.val;
+	}
+
+	/* no previous data, compute theoritical value from interrupt */
+	if (ts->timestamp == 0) {
+		interval = (int64_t)ts->period * (int64_t)sensor_nb;
+		ts->timestamp = it->up - interval;
+		dev_dbg(ts->dev, "ts start: %lld\n", ts->timestamp);
+		return;
+	}
+
+	/* if interrupt interval is valid, sync with interrupt timestamp */
+	if (valid) {
+		/* compute real fifo_period */
+		fifo_period = fifo_mult * ts->chip_period.val;
+		delta = it->lo - ts->timestamp;
+		while (delta >= (fifo_period * 3 / 2))
+			delta -= fifo_period;
+		/* compute maximal adjustment value */
+		m = INV_ICM42600_TIMESTAMP_MAX_PERIOD(ts->period) - ts->period;
+		if (delta > m)
+			delta = m;
+		else if (delta < -m)
+			delta = -m;
+		dev_dbg(ts->dev, "ts adj: %lld\n", delta);
+		ts->timestamp += delta;
+	}
+}
+
+void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
+				      uint32_t fifo_period, size_t fifo_nb,
+				      unsigned int fifo_no)
+{
+	int64_t interval;
+	uint32_t fifo_mult;
+
+	ts->mult = ts->new_mult;
+	ts->period = ts->mult * ts->chip_period.val;
+	dev_dbg(ts->dev, "ts mult: %u\n", ts->mult);
+
+	if (ts->timestamp != 0) {
+		/* compute real fifo period */
+		fifo_mult = fifo_period / INV_ICM42600_TIMESTAMP_PERIOD;
+		fifo_period = fifo_mult * ts->chip_period.val;
+		/* compute timestamp from current interrupt after ODR change */
+		interval = (int64_t)(fifo_nb - fifo_no) * (int64_t)fifo_period;
+		ts->timestamp = ts->it.up - interval;
+		dev_dbg(ts->dev, "ts new: %lld\n", ts->timestamp);
+	}
+}
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
new file mode 100644
index 000000000000..c865e1a9a7c8
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#ifndef INV_ICM42600_TIMESTAMP_H_
+#define INV_ICM42600_TIMESTAMP_H_
+
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+
+struct inv_icm42600_state;
+
+struct inv_icm42600_timestamp_interval {
+	int64_t lo;
+	int64_t up;
+};
+
+struct inv_icm42600_timestamp_acc {
+	uint32_t val;
+	size_t idx;
+	uint32_t values[32];
+};
+
+struct inv_icm42600_timestamp {
+	struct device *dev;
+	struct inv_icm42600_timestamp_interval it;
+	int64_t timestamp;
+	uint32_t mult;
+	uint32_t new_mult;
+	uint32_t period;
+	struct inv_icm42600_timestamp_acc chip_period;
+};
+
+#define INV_ICM42600_TIMESTAMP_CHAN(_index)				\
+	{								\
+		.type = IIO_TIMESTAMP,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
+		.scan_index = _index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 64,					\
+			.storagebits = 64,				\
+		},							\
+	}
+
+int inv_icm42600_timestamp_read_raw(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    int *val, int *val2, long mask);
+
+int inv_icm42600_timestamp_init(struct inv_icm42600_state *st);
+
+void inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
+				       int odr);
+
+void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
+				      uint32_t fifo_period, size_t fifo_nb,
+				      size_t sensor_nb, int64_t timestamp);
+
+static inline int64_t
+inv_icm42600_timestamp_get(struct inv_icm42600_timestamp *ts)
+{
+	ts->timestamp += ts->period;
+	dev_dbg(ts->dev, "ts: %lld\n", ts->timestamp);
+
+	return ts->timestamp;
+}
+
+void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
+				      uint32_t fifo_period, size_t fifo_nb,
+				      unsigned int fifo_no);
+
+static inline void
+inv_icm42600_timestamp_reset(struct inv_icm42600_timestamp *ts)
+{
+	const struct inv_icm42600_timestamp_interval interval_init = {0LL, 0LL};
+
+	ts->it = interval_init;
+	ts->timestamp = 0;
+}
+
+#endif
-- 
2.17.1

