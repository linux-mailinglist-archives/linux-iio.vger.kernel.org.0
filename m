Return-Path: <linux-iio+bounces-3063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A03862B61
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 17:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43D0B20E64
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BF6175A1;
	Sun, 25 Feb 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="qeP8DZe8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091D616427
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876876; cv=fail; b=EVGQFLHG+9LA5nk+9Y3XHwTgjMdTtpTe9AnM+XwQ7AmcvvfKpnypBdSbzHVBhqRYmLUpxiFdULoESvc1xRE0y1dU1ySab0QKslSiNx8L3rw3jtIGD/OTDq05o7MpqbSH5qeomDz/sW0JB0bptIv/0maYOsv+3vNRF/xI4VS6f1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876876; c=relaxed/simple;
	bh=C+75DR0zcd0gip0+Ukf0w/K4XVI+FN2HC7bzTMnZKWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B5x8h3F4c+JG1KpHs/p/Q2+CQcYCIhySDK1P02nUnVtEW7O3fTZAyn2rCMiKPKAJQBA8ExBtROi7ETZFmZtubFj+MMWkwjBZGA9dBxfN09tOnOUEO4988rBvbNNIpr2SbAJKakoqTKg/O6AFCmIeFm5DoijgmwRmjdyTB89Ksv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=qeP8DZe8; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41PFo2cj018247;
	Sun, 25 Feb 2024 16:00:59 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2169.outbound.protection.outlook.com [104.47.23.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wf9tjrf3v-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 16:00:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AB9Jyp188umXrt9KLvgYCong2dIy2c4QyKTVgpx1ApMCMW4fjsto/oqd8yIvSGUwQCqhu4eDjT1B/uOzZoywlt56527fQCfX1244u9IqWvfKhNWfCYfIZk0Ue09kGihDjwBCBnwZyfyo781L6L9I1ZGzcVbkbR3+X6l3haIM3FSeo4dTvRjIJG0+SbE8Zyuw56d3rU/F6kJG+IEi7NsJS1FuntFYSVlSMATJLX4sfnz4yQrOdLUDmYxfsq8i1ZNurmZpziMCdh0sgvzZBw3lpEToztiEMHXtIY4bsUISXa0/Vc+o4GZcflXxPDwpGaS0qDlPWHDFfy1m6ZHz/Lz1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di+Z22lae+WiswI8QMc3LB6JuhyXGlF5VEy7sw2Mpt4=;
 b=OwlocDEH9fGfVYsvBAqbp3/+NHX7gqzXRbCmE9URoW9sOOUVYnZrk6c6aSq815DGNMv7T4TrtP27bvqx5u8C2q/jOfMWB0GApN89aWCcAOzcQwu2xmPDaYDoTfggxML25we7LfrpDPYU3ml6Tgq7lhElk/A71/DZOWrOQNLHQ5pp0xMI+LW2T/VNqIALRSLr5y8egOwEiwwKbuBSIeTHpUMTaN9M0kd1ierxA3cfpy6vTeCFqG3icGvmBJnCu3dmpPO01LiL6F1nb71AYbK8YkZQUFu8Kp/U/ei604yqwZtTPqzXYNvYIELHwJLDaoLL/i/MtOxJOYpjAaLCoTNLyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di+Z22lae+WiswI8QMc3LB6JuhyXGlF5VEy7sw2Mpt4=;
 b=qeP8DZe8ALFv8AB2wjJh/hNQdVxH5Fj0qYLBjBbYrcoIKrLoh5MR/t7hg3OFU4oj+islEXxjNuc24AC/QnZDWlZfeSvXCQuaEFxqDcDdpiNN4NzHdFsS+X5LSs+4S6Vv23sXVRM/Bjw+/HnD9EMlBBdPSPdVjLXm8ue2Il4G4+T2YT6d3hbMHewRzyAGCE6CVHJVCgMSQUqRvhH6kArwRDhxFKnZsS0I5gR32+VpTr4VRkOy3k9DVxk32C5ThscG0fbLw+/z5KoCXCkxST/0xvqvUZaFocRAkIfb7zqJ1tHBt34lczaTV46Rwx2MYrztTdjVZwPKWv8aiZPMRI37VQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYTP286MB3462.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Sun, 25 Feb
 2024 16:00:53 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f%4]) with mapi id 15.20.7316.018; Sun, 25 Feb 2024
 16:00:53 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 3/4] iio: imu: inv_mpu6050: add new interrupt handler for WoM events
Date: Sun, 25 Feb 2024 16:00:26 +0000
Message-Id: <20240225160027.200092-4-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240225160027.200092-1-inv.git-commit@tdk.com>
References: <20240225160027.200092-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::16) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYTP286MB3462:EE_
X-MS-Office365-Filtering-Correlation-Id: f056c358-bd1c-4f9a-6e6d-08dc361af1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FtFUL23U+JTmqRoJo4jYZSJIolF/PwbYWC/U94LdFusxPw1Y3mD7AfmVKF8jgQj0GvwxYlTDoHD9Ze9bewK+g+vrD63Z13se5jKnlFE8sgI5s/KP3kaOZaIFUqtlASFJrNWccswo629BlUxnL+UzxPTRRcR6XJzJ6kG+7Eu549i2yC8RN//OO7X0SpftPt6LPNuCxLMUCDjdWZLK+wuSaqzUDYn3rzXhjEfHIEY3ebeMqTF9teBUsbOcqv/eu7pdUxAL569Diu8HKMTvfT7lFxd5bn1lUOadZutsFVIeGvco+ud65Kb+UDmtkly+w3SE0MXeAutYYR32RwZllvQi+N2sIwQeCRwWo3YR7IKmWSmsA1JM+smf4x7XPjmb3ZrSWopTKpmVhc3HS2zgRTtPHXIC4cuoOJUD64Uhh9uEo2Vz54MU2ZBN4XBayf968fjpMXdERnE7gd1gGsDSZ1w0OCOls2CZiCax7csWbbqdcNd2OrlKtzBDVZEtcpbo9/opm4jvulcl3mrMwj5EK6YOBl68/BM8IHpccG1qJBOYmXhlPogk6l6weD+pFoZXf4i4YZw84NuBxIcU3RNn8rLSe4wyJ7LPNRa6cA4BKiSBV3xM13MliWsBUrbUP4NCjmdWYTA+3U6oOwhtlMzTZGoLPA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6FSYY584DOPFNc77tEXPRtfIpPzVSQRORfsuLfyLINZlliq/eTzIUOgAGvvk?=
 =?us-ascii?Q?Ic5AKOlLSgTTH78nse13nPUBsPoKFqF5S57ubIyTfHZke1mxZ9U2E/QjPcp4?=
 =?us-ascii?Q?9xDRUk3qYGvaM2uKturb89MHxJDM4sbu1j59jphuhajhfDdwfJ/zVt3GQ7Pb?=
 =?us-ascii?Q?OCMkA+L0dEcMA4YLqaTzXTzHqkopuJCdfeFr7R9pOCoCucjP/Agxtcxj3cSA?=
 =?us-ascii?Q?clXay5Q4ylzMAQbgAFbSwg+bbEF3nfquASZAXf4QhQFkgfmgcokE/tYU6k8/?=
 =?us-ascii?Q?FFQYlWwilmdrFZY+SYw2x6GQ697IilBsR94kPEbsdKCcYNwiJvyJ8GSuGESO?=
 =?us-ascii?Q?G/WS80D4eobB+AzULyUTyMTMZHEoFIkFVRkvNp5Vu9DyVafb+aCsSP/TFX6d?=
 =?us-ascii?Q?rBK97zyv2mbjkxPvMtwUoJnNxIolcMKPXNwmvn1h9E+nWlRc+z1IK2fx9M/i?=
 =?us-ascii?Q?Vt/ucp4qg+AqbFFIY/LlaaQZ167wM5iYo9sgpNhE3qMGEdGc/dJ1e+x3EbBi?=
 =?us-ascii?Q?HQCUWezBvCb88A3JH3Bg4Y8jGleGVVWgqmLdS8ST8hCyYsOVbTWzP+Bx96zx?=
 =?us-ascii?Q?NnbGdLJ4Kkes4WzA15Ryz+6Xph7qHpDleZD802RAbQ1/VuIf3JfOSU/E0Fu+?=
 =?us-ascii?Q?yhX0xLHzosm3ftz4LMfanYKNGfIYc1pk0xVSVoNZTO/OVMujfmr+RJkqJ9JG?=
 =?us-ascii?Q?yQHPPBBudTMWMwWTeenYTzsU++9S1LIwmOytTT1xgY5P4btojHQyzzNRcd8q?=
 =?us-ascii?Q?BMUrIdWge5sJiEEOZJ5x9cxPQ2axWn5GFLNgfRA8zxuoLD/vfPsZa+rDSfXJ?=
 =?us-ascii?Q?jmE9RdnkVglkSQ3bLgxvi8Ie6FYfmOZYLeuiHUs5cEf/i4EfxMs9GQEbVD6d?=
 =?us-ascii?Q?Bh3MZ1j/U7prFxDNd+AL2vr9UckY2Y2C7qoU1nEn6zKPxG8trTrCTnuaObrl?=
 =?us-ascii?Q?A+Haxrn1s8P8iKXVw9raErh1LYMHBA//MJmIsDOTYwwC0wtu7D8kXUXGP2+w?=
 =?us-ascii?Q?nEuttOdLnb7z/O4V6eFweFS8z9nJONA+2FS+V3AraxGxX42Q/JTQm5wdD2Ko?=
 =?us-ascii?Q?fYWjK0swQzX9FVGVm8nYbWsw+LDXFzXef//ziNNLsI0uC7yGZmIevzkPQa/c?=
 =?us-ascii?Q?4T5/oHho8fyAlGix4Bp1iOdledqNcFt74WJbiqEmhfFPizRPhJcg6sRFIkDD?=
 =?us-ascii?Q?SpuauRZQbZJ2rV8XaVM9VLKnEsasfUE0ppEx1lglGiatgvuw3OPaUfKY46O5?=
 =?us-ascii?Q?3FyYuwCWNUmtOTertnN62gEnP0iICF6qVPxW7KCNf5MQdcnYy11yb32Vs2rM?=
 =?us-ascii?Q?uCldtVrsHKcp/m0XDqxPnMc4F5ouBJCBGh+IG0QHuGZSrhMItoYB7oaYMz2X?=
 =?us-ascii?Q?i3a+2sh5UkSWWnZuJG6YAGaccMwQf7Q/hG0LjsIkW9Xiyq9yTlIgdyawoKcD?=
 =?us-ascii?Q?dJhm1gyP6z+ijlnszeKPf5E9nZ42wPj5Cy+dCUT/+rMRvDqXMooiQ0Nt/bBS?=
 =?us-ascii?Q?nqI3KsmdXD/4cHDEa3Yaavk5iRZqQqb6c7pv8fEQT+viaxstwgGaoa3VeUay?=
 =?us-ascii?Q?fSCbo88xXmAi7PIMLIRcLuMITzrnrRMS2EW3qAnU?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f056c358-bd1c-4f9a-6e6d-08dc361af1f6
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 16:00:53.7072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+aRQghEgDFyfhCaNzEs+PELyRCKE8S8aDig9ym4Gj9wShGmhoKsAwOwxEh/dpseclkByUhQThg4hU66tlHKoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3462
X-Proofpoint-GUID: uk93VNAGHrQt8q21wgjS3J4uO25UbRJv
X-Proofpoint-ORIG-GUID: uk93VNAGHrQt8q21wgjS3J4uO25UbRJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_18,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402250127

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add new interrupt handler for generating WoM event from int status
register bits. Launch from interrupt the trigger poll function for
data buffer.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 11 ----
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 56 +++++++++++++++++--
 3 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 519c1eee96ad..9be67cebbd49 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -184,6 +184,7 @@ struct inv_mpu6050_hw {
  *  @magn_orient:       magnetometer sensor chip orientation if available.
  *  @suspended_sensors:	sensors mask of sensors turned off for suspend
  *  @data:		read buffer used for bulk reads.
+ *  @it_timestamp:	interrupt timestamp.
  */
 struct inv_mpu6050_state {
 	struct mutex lock;
@@ -209,6 +210,7 @@ struct inv_mpu6050_state {
 	unsigned int suspended_sensors;
 	bool level_shifter;
 	u8 *data;
+	s64 it_timestamp;
 };
 
 /*register and associated bit definition*/
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 13da6f523ca2..e282378ee2ca 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -51,21 +51,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u32 fifo_period;
 	s64 timestamp;
 	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
-	int int_status;
 	size_t i, nb;
 
 	mutex_lock(&st->lock);
 
-	/* ack interrupt and check status */
-	result = regmap_read(st->map, st->reg->int_status, &int_status);
-	if (result) {
-		dev_err(regmap_get_device(st->map),
-			"failed to ack interrupt\n");
-		goto flush_fifo;
-	}
-	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))
-		goto end_session;
-
 	if (!(st->chip_config.accl_fifo_enable |
 		st->chip_config.gyro_fifo_enable |
 		st->chip_config.magn_fifo_enable))
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index ec2398a87f45..7ffbb9e7c100 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -6,6 +6,7 @@
 #include <linux/pm_runtime.h>
 
 #include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/events.h>
 
 #include "inv_mpu_iio.h"
 
@@ -223,6 +224,52 @@ static const struct iio_trigger_ops inv_mpu_trigger_ops = {
 	.set_trigger_state = &inv_mpu_data_rdy_trigger_set_state,
 };
 
+static irqreturn_t inv_mpu6050_interrupt_timestamp(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+
+	st->it_timestamp = iio_get_time_ns(indio_dev);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	unsigned int int_status = 0;
+	int result;
+
+	mutex_lock(&st->lock);
+
+	/* ack interrupt and check status */
+	result = regmap_read(st->map, st->reg->int_status, &int_status);
+	if (result) {
+		dev_err(regmap_get_device(st->map),
+			"failed to ack interrupt\n");
+		goto exit_unlock;
+	}
+
+	/* handle WoM event */
+	if (st->chip_config.wom_en && (int_status & INV_MPU6500_BIT_WOM_INT))
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_ACCEL, 0, IIO_EV_TYPE_MAG_ADAPTIVE,
+						    IIO_EV_DIR_RISING),
+				st->it_timestamp);
+
+exit_unlock:
+	mutex_unlock(&st->lock);
+
+	/* handle raw data interrupt */
+	if (int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT) {
+		indio_dev->pollfunc->timestamp = st->it_timestamp;
+		iio_trigger_poll_nested(st->trig);
+	}
+
+	return IRQ_HANDLED;
+}
+
 int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
 {
 	int ret;
@@ -235,11 +282,10 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
 	if (!st->trig)
 		return -ENOMEM;
 
-	ret = devm_request_irq(&indio_dev->dev, st->irq,
-			       &iio_trigger_generic_data_rdy_poll,
-			       irq_type,
-			       "inv_mpu",
-			       st->trig);
+	ret = devm_request_threaded_irq(&indio_dev->dev, st->irq,
+					&inv_mpu6050_interrupt_timestamp,
+					&inv_mpu6050_interrupt_handle,
+					irq_type, "inv_mpu", indio_dev);
 	if (ret)
 		return ret;
 
-- 
2.34.1


