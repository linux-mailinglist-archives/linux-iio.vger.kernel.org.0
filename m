Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C28A613DB28
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2020 14:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgAPNJ4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jan 2020 08:09:56 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58886 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbgAPNJz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jan 2020 08:09:55 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GD8dof013797;
        Thu, 16 Jan 2020 08:09:54 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xfc59nf6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 08:09:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xdct7HAg3MUs8gej2nDmF1XTehyzCgX7638d/Bnca2Kv6WY3k1raQevrgL6bqIEayXpsWwPND8QuNmjFRIl9elB4ZM5hHibiR7UjouwjOSWHNAl0ow9Kldamr57pdMwnGvIl7ZIo7rRV+oiYw/LyNiG2/BM4x42BQvAS1coB1tN98hR+zwFCvXwf87ZOeBrLFcqd78NWorQvvb6h6dTd7mpeanbVmsrYeMQi9zZexgYiLRl1dGOoKwAQyz9QPT83mMql0taUyxKwFki7FURKzG9a2yD5C9kpbgsLlk0eukT8rNxCOtSq98Ltd/dh3QgMlcpAcqj3H412Ubmz+/HQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtQ/R/w2qwYuBOwJ0UBXdtnyQVtOjHccD/KnldTm/l8=;
 b=Kr5JrYdGqcGNs/DlOdeClHFLgygzs/P9uZmqDFo51QhPg+4bNX3JCr6vZDfkWg4qAbuGcqo5/nql92h4FZlXMN6V3Zb9hJcpd1vrD5RnELxcJx3aTuTPXPUd4j8+YSI5FNvsK5BeDmAHAAis/B8Rew5N5vCZKZPN/eMNJFzdjyaQr/MIUbgzKreAA0gc3F94v8qsO7RkB5YeT5z45gsUNIMaHpBwXQ9TiviqnuYRpKdQ19wnfQwde6GvLemjsl7XMXhMBe71HKUbumKCtujX4N8sceWMJNBksUK9ZUnTPaz4qHdX8CD2dH9QBEA/3VYkKpuLqZEinrA+5sMqPpRp6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtQ/R/w2qwYuBOwJ0UBXdtnyQVtOjHccD/KnldTm/l8=;
 b=ZqHWdo/cSUXzrbiJpRmzEl69rrZuWFt+pZ9TynQULsp+hoxjkX2nXv67xTBLXeSk95+Kd5zEyIea0pGc/5TXQHnMQqgeC+uz9sWWLyJyqoT50/pAasgJvPHSqesyh0UrwGrrZ1wQ7vZUe3uu/qwYGpG0r0qBwELybttWyG5kCGU=
Received: from MWHPR03CA0006.namprd03.prod.outlook.com (2603:10b6:300:117::16)
 by DM6PR03MB3611.namprd03.prod.outlook.com (2603:10b6:5:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13; Thu, 16 Jan
 2020 13:09:52 +0000
Received: from CY1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by MWHPR03CA0006.outlook.office365.com
 (2603:10b6:300:117::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Thu, 16 Jan 2020 13:09:51 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT054.mail.protection.outlook.com (10.152.74.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2644.19
 via Frontend Transport; Thu, 16 Jan 2020 13:09:51 +0000
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id 00GD9b4X022001
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 16 Jan 2020 05:09:38 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 16 Jan
 2020 05:09:47 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 16 Jan 2020 05:09:47 -0800
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00GD9gVB024849;
        Thu, 16 Jan 2020 08:09:43 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] iio: imu: adis16480: Add support for ADIS16490
Date:   Thu, 16 Jan 2020 15:11:47 +0200
Message-ID: <20200116131148.18149-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(36756003)(2616005)(478600001)(5660300002)(44832011)(336012)(186003)(2906002)(26005)(426003)(7696005)(54906003)(316002)(70206006)(107886003)(8676002)(70586007)(966005)(7636002)(110136005)(4326008)(246002)(8936002)(86362001)(1076003)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3611;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9493908-03f1-4472-a69b-08d79a855f15
X-MS-TrafficTypeDiagnostic: DM6PR03MB3611:
X-Microsoft-Antispam-PRVS: <DM6PR03MB3611992AA5DC00F1DB83C1D0F9360@DM6PR03MB3611.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Osad2H8n7ISHJk6z2x8aeMj9n11uiQ/U0heRcgPJjejKKlVNbG48SGGoAX/cCStlpSnDQVH0gpoxku8gXtxWKtjdXGrmZUws4KWN8NJYopxAgU1IWomrl3fyT4kLuxBGBh0fGTIWhvQpWc20eWvccOreEbO+TFQuBzkn9w+EBiKNgFZ8M9TlqtZEWcVttK1bmFz2N8jBZEFMxfmwsVATQS8m89Jk+hVyb6JZDwa33OZAEqoXejmbcAbs6sUfNdyDW5NiJMslloix0pocGJ/+D4B0WiswWBxxbxv/YANlE55+C4B/NY+hj+qg4UISDJByBz3+uzmMdKkCMdSoOxMGPzGbS1GI6QQDasC5DSM2T0Htv65y9pCSoqVMU0NeneTXn42IDnziK29lRjpEmDw5+5jMjXs1q/ukVOKoZHxK+VBmCldNT+JUtE1INjyQgrTQPaQs/Zjo4MTI5LoC4y3h+ppEy/OMyoXwaNGBA5Ztqv4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 13:09:51.1355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9493908-03f1-4472-a69b-08d79a855f15
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3611
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_04:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001160111
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

The ADIS16490 is part of the same family with ADIS16495 and ADIS16497,
the main difference is the temperature, accelerometer and gyroscope
scales.

Datasheet:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/adis16490.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16480.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index f0ad7ce64861..dac87f1001fd 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -787,6 +787,7 @@ enum adis16480_variant {
 	ADIS16480,
 	ADIS16485,
 	ADIS16488,
+	ADIS16490,
 	ADIS16495_1,
 	ADIS16495_2,
 	ADIS16495_3,
@@ -878,6 +879,20 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.filter_freqs = adis16480_def_filter_freqs,
 		.timeouts = &adis16485_timeouts,
 	},
+	[ADIS16490] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = 20000 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(100),
+		.accel_max_val = IIO_M_S_2_TO_G(16000 << 16),
+		.accel_max_scale = 8,
+		.temp_scale = 14285, /* 14.285 milli degree Celsius */
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
+		.timeouts = &adis16495_timeouts,
+	},
 	[ADIS16495_1] = {
 		.channels = adis16485_channels,
 		.num_channels = ARRAY_SIZE(adis16485_channels),
@@ -1341,6 +1356,7 @@ static const struct spi_device_id adis16480_ids[] = {
 	{ "adis16480", ADIS16480 },
 	{ "adis16485", ADIS16485 },
 	{ "adis16488", ADIS16488 },
+	{ "adis16490", ADIS16490 },
 	{ "adis16495-1", ADIS16495_1 },
 	{ "adis16495-2", ADIS16495_2 },
 	{ "adis16495-3", ADIS16495_3 },
@@ -1356,6 +1372,7 @@ static const struct of_device_id adis16480_of_match[] = {
 	{ .compatible = "adi,adis16480" },
 	{ .compatible = "adi,adis16485" },
 	{ .compatible = "adi,adis16488" },
+	{ .compatible = "adi,adis16490" },
 	{ .compatible = "adi,adis16495-1" },
 	{ .compatible = "adi,adis16495-2" },
 	{ .compatible = "adi,adis16495-3" },
-- 
2.20.1

