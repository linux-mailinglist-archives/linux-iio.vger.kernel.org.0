Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0B8108EB0
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2019 14:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKYNVQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Nov 2019 08:21:16 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:38800 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbfKYNVP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2019 08:21:15 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAPDIBi0024763;
        Mon, 25 Nov 2019 08:20:51 -0500
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2059.outbound.protection.outlook.com [104.47.41.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wf298cu8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Nov 2019 08:20:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr+ErfLSlmfcUBTdRJUigQ9YzoVR7l3axZk2ZWMnamqmIeOMwUpZSSKpE5j3LYhkeeftmFEWGNhSTi8VklqzLK2UNoss3pm0JcJ6vhtsaUFFqSRD00giKs9eZ0RwdkT7A0HWLSAZHyuEQwb9iTH6Y3SAAhNFx7Xyv8k2D0EziYHAhUOSDyewEG34l9OLGUsiWrT43mOY20y64UP6U+wtFfCVQi+nLAcYgEk1mSr+J5FYLRFR9P7oR2/WZ24JooP1RhVEr+FNq5Z4YmTaGOYAmdB8QX0oWoO0sLAuXrXjyFMltbxf8nHKoRMZZZ/+Ik2jXCfXgWrMFKoy+0x8BP8MMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU52xc6e+Pqi1E0W0Xam1pauAF7pfskJtvSXjpx5bHI=;
 b=JLbgKyyY6nsbRkPDmf35bY4Z4UFIdsD/cnmAGrOtVuBcBX3C46bFCG1+RAz8MLN7HhjZFjkg03WkiI2BBZnUbal1ArgUGGMqv0rYA/wBdwQwKU5D3MSTH3KmwsVaX2eamQ14JwKptQzvC4Y+Obd5U2i4wuY/ZkiPDoTl+onWMr5pfV7Xsqi9XW2GGXsK1xMO+K/XSGCyZkAIcQTPgwpommtffGwe3m2fQy3DZjH2wZu4FvbfKggct+RRPMSNtv7PZ4oOU66ACZeFhxDoiF/v7AjirD2Iyk6h7TxtK/FD3dWajdMovkLBltfiGH93zK4WlhgapSbYZYPc/l6QI0y8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=pmeerw.net smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU52xc6e+Pqi1E0W0Xam1pauAF7pfskJtvSXjpx5bHI=;
 b=hy6GZGUWSoNWlqGkyg/gZUcUkhU6BMp9lAeXsZEn7wA3nBCxalEwaUZ66Yqlq7uzFbhxpsbgwctkQYFvEZaXmneOtKQ3BxF/oGWWO/HgYla4DS8f3gp3Rr9xiosHY6VUlUmdGNXal/TpHRrAbxgYqnckO4oVPN34yXdHAg+2xGQ=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by BY5PR03MB5249.namprd03.prod.outlook.com (2603:10b6:a03:21b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Mon, 25 Nov
 2019 13:20:49 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Mon, 25 Nov 2019 13:20:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 25 Nov 2019 13:20:49 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAPDKdTc001240
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 25 Nov 2019 05:20:39 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 25 Nov 2019 08:20:48 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2] iio: adc: ad7887: Cleanup channel assignment
Date:   Mon, 25 Nov 2019 15:21:37 +0200
Message-ID: <20191125132137.4753-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(189003)(199004)(2616005)(36756003)(336012)(426003)(2351001)(86362001)(4326008)(6916009)(54906003)(7696005)(316002)(16586007)(106002)(51416003)(305945005)(6666004)(356004)(107886003)(44832011)(70206006)(70586007)(7636002)(5660300002)(478600001)(50466002)(48376002)(26005)(186003)(8676002)(50226002)(246002)(8936002)(2906002)(1076003)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5249;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b0698ef-9b40-4b49-b245-08d771aa49c9
X-MS-TrafficTypeDiagnostic: BY5PR03MB5249:
X-Microsoft-Antispam-PRVS: <BY5PR03MB5249FBA391E94F531FBF3FBDF04A0@BY5PR03MB5249.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0232B30BBC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urU4mZdZlxr+wrLh0PjUz1SumUAA/dthP2s3khM2hgVFtz6+qCKujRx30ZhLc5iJQwjOzaz5sGstos8oM6qgd0cocVvMJWzSQYZDzaXJycMstBEqFCgFcJA1AK0MlpcTP/Il2cxoE2hEVnh75Zcp+mwsbHbCN2tOdc6oDBGTtZnsBomL8fnYYCtTWaNy8n0t1lpOMvUqFjrSRLbsRZIMyDYDF+JZMdFYxxLQayl8yCgrjULvpbx6XCJN4siM0nXAb9QbpApzk7RWTKFmc8HxvvedPwzArYrXEcy7CzXHObBFuuZn1BwMf5bcGjRv8nGoMNl4uJn6aSc4A0U3CCA1K29aW/fOOqT+Ar6tyEb8svM3qRrz1gSU28T1XmCnIYJr2zaHtfyAcm4X/nmaTbBNv5rP7RpH6CkZoXXQkShy4ywYE903N2NOLUW3EqttDZpm
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 13:20:49.2108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0698ef-9b40-4b49-b245-08d771aa49c9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5249
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_03:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=1 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911250122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The channels specification assignment in chip info was simplified.
This patch makes supporting other devices by this driver easier.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v2:
-separate iio_chan_spec for dual mode

 drivers/iio/adc/ad7887.c | 82 +++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 6223043e432b..c6a3428e950a 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -43,11 +43,17 @@ enum ad7887_channels {
 /**
  * struct ad7887_chip_info - chip specifc information
  * @int_vref_mv:	the internal reference voltage
- * @channel:		channel specification
+ * @channels:		channels specification
+ * @num_channels:	number of channels
+ * @dual_channels:	channels specification in dual mode
+ * @num_dual_channels:	number of channels in dual mode
  */
 struct ad7887_chip_info {
 	u16				int_vref_mv;
-	struct iio_chan_spec		channel[3];
+	const struct iio_chan_spec	*channels;
+	unsigned int			num_channels;
+	const struct iio_chan_spec	*dual_channels;
+	unsigned int			num_dual_channels;
 };
 
 struct ad7887_state {
@@ -183,45 +189,43 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
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
+	AD7887_CHANNEL(0),
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct iio_chan_spec ad7887_dual_channels[] = {
+	AD7887_CHANNEL(0),
+	AD7887_CHANNEL(1),
+	IIO_CHAN_SOFT_TIMESTAMP(2),
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
+		.dual_channels = ad7887_dual_channels,
+		.num_dual_channels = ARRAY_SIZE(ad7887_dual_channels),
 		.int_vref_mv = 2500,
 	},
 };
@@ -306,11 +310,11 @@ static int ad7887_probe(struct spi_device *spi)
 		spi_message_init(&st->msg[AD7887_CH1]);
 		spi_message_add_tail(&st->xfer[3], &st->msg[AD7887_CH1]);
 
-		indio_dev->channels = st->chip_info->channel;
-		indio_dev->num_channels = 3;
+		indio_dev->channels = st->chip_info->dual_channels;
+		indio_dev->num_channels = st->chip_info->num_dual_channels;
 	} else {
-		indio_dev->channels = &st->chip_info->channel[1];
-		indio_dev->num_channels = 2;
+		indio_dev->channels = st->chip_info->channels;
+		indio_dev->num_channels = st->chip_info->num_channels;
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-- 
2.17.1

