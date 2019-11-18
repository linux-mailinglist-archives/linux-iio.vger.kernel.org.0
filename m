Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17CE31007DF
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2019 16:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKRPJa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Nov 2019 10:09:30 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:17840 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726703AbfKRPJa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Nov 2019 10:09:30 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAIF8o1W024336;
        Mon, 18 Nov 2019 10:08:50 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2052.outbound.protection.outlook.com [104.47.36.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wbg0jcs0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 10:08:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqUSOEWUmpvK42TMsXAF0qsyHdmoHvW86lWZjfnn6gQp+HSey6Gf7D9wqNvxiHvBALYFbN8RmlRAAnXNlR+YQ+f8BY4GGoLweLq0NlXt/Cnz9JzBXACG/ss/JbYAWhXXrEhTNuvZgwq0cECgUvFI/klDEOAtayO20Qyi3cTj2ARAQN1IUN8TNm3ti+Uc47WCFjBjNk+bjBl68IQxi4rB+UbmwmqFzVHGHeP5P/yoQvZYg3GYLfVn4oq9OUuuXC8LCyxlO0aHkEJTrceeAIrICGUO5Lo5ZJAsHCJHRElNkcDkjHguazUaTcGJ/6Yig0krPvfa+0rVRtAsVKXTlgKf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnZZZEb+rU3kVr/mFGvdDYUliEm1vO6M16wohem6ivY=;
 b=dSLVqdmwhZa+XVwp+s1OwTPnih+9zSO65xj5IEqykKe2pu9J9l/vN7jJwn28fSsEMzxb9S0W9f5NYDWU1Sr+2KyrBytw43pcBlpv11VoHFxV8pHh8A125OQ2LXbfYdy1c/tEwBWcw8e1X0XJvBSRnaLI7A53Cq/uPLJ9qSKes0G2tUJnWpPDkTu9O5zoPMd7eRV0+eZ0+6tLr/dMOERm/Csp0/AvgoiPxE76VHSdVyGRxnvfWaL7x0SNXO2f0VR+53COQ+LTiDCRUgCyo8BsmcdYonIXdOP9JjCmz6MkKn+nRZYiSsaIL+eEFJDS5Hpss+cn3KfOVMKDox1fqYhcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=pmeerw.net smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnZZZEb+rU3kVr/mFGvdDYUliEm1vO6M16wohem6ivY=;
 b=2qCqWksD5nawPANdprbC4ELq6fh1y06O8rkfgPBqnVaDMo/g9EjFQIUeqUrAXmTAOVvCOUN8iC/RXKRlkQiwcMXFuxsgZX40XjA5KUEgYCSB4xbo6GVi/id7+IW1aoAgRDy4SVCbYt/UVjVPKuseT51Tk1z3lPy0e1BIQOwKwIc=
Received: from BN3PR03CA0108.namprd03.prod.outlook.com (2603:10b6:400:4::26)
 by BN6PR03MB2578.namprd03.prod.outlook.com (2603:10b6:404:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22; Mon, 18 Nov
 2019 15:08:49 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BN3PR03CA0108.outlook.office365.com
 (2603:10b6:400:4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Mon, 18 Nov 2019 15:08:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Mon, 18 Nov 2019 15:08:48 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAIF8d42013836
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 18 Nov 2019 07:08:39 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Nov 2019 10:08:47 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH] iio: adc: ad7887: Cleanup channel assignment
Date:   Mon, 18 Nov 2019 17:09:27 +0200
Message-ID: <20191118150927.19411-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(126002)(476003)(44832011)(86362001)(106002)(6916009)(246002)(6666004)(54906003)(356004)(51416003)(316002)(305945005)(2351001)(7696005)(7636002)(107886003)(2616005)(5660300002)(486006)(426003)(336012)(16586007)(4326008)(478600001)(70586007)(70206006)(47776003)(186003)(48376002)(2906002)(36756003)(8936002)(26005)(8676002)(50226002)(1076003)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2578;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21de69ce-7ed8-40a6-64ac-08d76c39370a
X-MS-TrafficTypeDiagnostic: BN6PR03MB2578:
X-Microsoft-Antispam-PRVS: <BN6PR03MB25784A52CFB7589C8046ADDCF04D0@BN6PR03MB2578.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0225B0D5BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KeCoRwU1Wmq6MIK5ozOovVv+Zwid05gbUi4kyY+Zj8H+t1shcTd3gG5LcIHV92h/sQMoIRhO16ywXV0DQyH1YkVKqECUkv4HbXGFQoopAItzmoy/LDPzePrjopC6Uc7Zr5j5skj1bhTt21/gcpabrfkwFNhj+kqh8pF+n7yDgeBet5Pn0e0PiOIjvYxo631u//Lfwx6wFh6FPqPZMcj48lwCqlQQlzxRWux3z5MmhjLaAx/D6r5ag5Mpf1PQ44Df+Id4XSp9YbKI49YzOsPKMugkAQuvXX0bXUmLf9PwnopsbbOkC/clIOTKgXQO5ymMpsx75oEH2vFmB6CW8ZM/zPfIWutQ5IbSqnRtXzEaaiDtIAsNXKf1Egmn1FIMKnHPOeohMyGxaMzq7aZLqOPZ36GLZz4nMvhXaOdHmAoz/Vm1ZwoXSPEf/j5nRaJov8ro
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 15:08:48.8097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21de69ce-7ed8-40a6-64ac-08d76c39370a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2578
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_03:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=1 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911180138
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The channels specification assignment in chip info was simplified.
This patch makes supporting other devices by this driver easier.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7887.c | 71 ++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 6223043e432b..65d1338d9392 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -43,11 +43,12 @@ enum ad7887_channels {
 /**
  * struct ad7887_chip_info - chip specifc information
  * @int_vref_mv:	the internal reference voltage
- * @channel:		channel specification
+ * @channels:		channels specification
  */
 struct ad7887_chip_info {
 	u16				int_vref_mv;
-	struct iio_chan_spec		channel[3];
+	const struct iio_chan_spec	*channels;
+	unsigned int			num_channels;
 };
 
 struct ad7887_state {
@@ -183,45 +184,36 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+#define AD7887_CHANNEL(x) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.channel = (x), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.address = (x), \
+	.scan_index = (x), \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 12, \
+		.storagebits = 16, \
+		.shift = 0, \
+		.endianness = IIO_BE, \
+	}, \
+}
+
+static const struct iio_chan_spec ad7887_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+	AD7887_CHANNEL(0),
+	AD7887_CHANNEL(1),
+};
 
 static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
 	/*
 	 * More devices added in future
 	 */
 	[ID_AD7887] = {
-		.channel[0] = {
-			.type = IIO_VOLTAGE,
-			.indexed = 1,
-			.channel = 1,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
-			.address = 1,
-			.scan_index = 1,
-			.scan_type = {
-				.sign = 'u',
-				.realbits = 12,
-				.storagebits = 16,
-				.shift = 0,
-				.endianness = IIO_BE,
-			},
-		},
-		.channel[1] = {
-			.type = IIO_VOLTAGE,
-			.indexed = 1,
-			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
-			.address = 0,
-			.scan_index = 0,
-			.scan_type = {
-				.sign = 'u',
-				.realbits = 12,
-				.storagebits = 16,
-				.shift = 0,
-				.endianness = IIO_BE,
-			},
-		},
-		.channel[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
+		.channels = ad7887_channels,
+		.num_channels = ARRAY_SIZE(ad7887_channels),
 		.int_vref_mv = 2500,
 	},
 };
@@ -284,6 +276,9 @@ static int ad7887_probe(struct spi_device *spi)
 	spi_message_init(&st->msg[AD7887_CH0]);
 	spi_message_add_tail(&st->xfer[0], &st->msg[AD7887_CH0]);
 
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
+
 	if (pdata && pdata->en_dual) {
 		st->tx_cmd_buf[2] = AD7887_CH_AIN1 | mode;
 
@@ -305,12 +300,8 @@ static int ad7887_probe(struct spi_device *spi)
 
 		spi_message_init(&st->msg[AD7887_CH1]);
 		spi_message_add_tail(&st->xfer[3], &st->msg[AD7887_CH1]);
-
-		indio_dev->channels = st->chip_info->channel;
-		indio_dev->num_channels = 3;
 	} else {
-		indio_dev->channels = &st->chip_info->channel[1];
-		indio_dev->num_channels = 2;
+		indio_dev->num_channels = st->chip_info->num_channels - 1;
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-- 
2.17.1

