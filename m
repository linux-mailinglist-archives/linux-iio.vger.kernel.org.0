Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336606C94B
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2019 08:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfGRG2L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 02:28:11 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26822 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbfGRG2L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 02:28:11 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6I6OdZe018641;
        Thu, 18 Jul 2019 02:28:06 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tsf0g66vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 02:28:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOXQflhPpfXEDEPM9avkvoHH3ZiVw7/UdoZ+DnzKhkMIDtVptFeGOx7HH0eWoieKRbbiIgHse2VBtYdJ9pUOhS8+L8R/PY2K+U5EZnA4oSzP6YD+wz6kJd9u9aMfO9it8RgceVtrNswho/KOaucifNulXjQnshBrK+IWlSbPlA1KzRtTeq0pF/j2+mjzSh863WNo6v9fIzyCUGpBJ7WfMi2t0HnYU/7rxJpk6A7op1AfRXwYUQQcaUQcwTmgQ010wIs1QV1jBR+P362ks1xmZJ1KSnXfwliI2fgWeyUjUwt9idd38qcSwXmmXkWgTAWrgs5rJRMJcep2Wy19Nf3O/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8XhzroSSOOsgVr8dl7Oi/JwMT/LDbaBl6kO3iAECSk=;
 b=aoaS4tImTTXYQkrJab5Ghphz1a0Nq69kBZ0prDRbMmuYgfidLF16Rfsp4ZBrGqdDBbx59pn3Wd9fRZ2lZIZZfSfv7xK5UbOYGvJk7DrTtvNGGmxdzciF31D/p2KG6UL4WRqrLDb0e95Lc2nlYTv/jetLYqEhh0vyUBsgkhNmHxPLaLcvG79gkdBXvYqrqVUGPOQxT5H7x/yir63CRO/C0z2FqIO7qMLJ8eimpuC7CBX6d4FmrGXRgQ3WtQvNFklGxc3E1vZKoK4glQgzYyow+Q/WA2aLJChvFxZoRJPc3D4UKajFE3p8SyzjCghxHXu/triiD4z9YqgJfbV++6yuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8XhzroSSOOsgVr8dl7Oi/JwMT/LDbaBl6kO3iAECSk=;
 b=TxTfiUOGri63YPG5nZ0oxKzoWtpvKglLHs9EjBvrbkxfqZYlMDbBSBlIgv1M3ctyrgZGgh95+Nj/TrQw8Z1EwlVx0swi2H7ld/Rd+zYpG8GITeI/7RU3ByqqbIEekk+WAi6wZNmMOSZpwLNtspYyubN0MSWNEiicOhPXcHUktJw=
Received: from MWHPR03CA0018.namprd03.prod.outlook.com (2603:10b6:300:117::28)
 by BYAPR03MB4710.namprd03.prod.outlook.com (2603:10b6:a03:131::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14; Thu, 18 Jul
 2019 06:28:04 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by MWHPR03CA0018.outlook.office365.com
 (2603:10b6:300:117::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.11 via Frontend
 Transport; Thu, 18 Jul 2019 06:28:04 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Thu, 18 Jul 2019 06:28:03 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6I6S29c015272
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 17 Jul 2019 23:28:02 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 18 Jul 2019 02:28:02 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 2/5] iio: adc: ad7606: Move spi dependent features to spi file
Date:   Thu, 18 Jul 2019 09:27:31 +0300
Message-ID: <20190718062734.17306-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718062734.17306-1-beniamin.bia@analog.com>
References: <20190718062734.17306-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(136003)(39860400002)(396003)(346002)(2980300002)(199004)(189003)(316002)(426003)(16586007)(2616005)(26005)(186003)(11346002)(446003)(54906003)(44832011)(5660300002)(2906002)(2351001)(106002)(336012)(70586007)(6916009)(486006)(70206006)(14444005)(7636002)(476003)(47776003)(36756003)(356004)(126002)(6666004)(8936002)(50466002)(1076003)(48376002)(107886003)(76176011)(51416003)(7696005)(8676002)(246002)(305945005)(50226002)(86362001)(4326008)(478600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4710;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60dd3c86-2a2c-47dc-f083-08d70b49167d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BYAPR03MB4710;
X-MS-TrafficTypeDiagnostic: BYAPR03MB4710:
X-Microsoft-Antispam-PRVS: <BYAPR03MB471056B504DED4FF8CF3BD5FF0C80@BYAPR03MB4710.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 01026E1310
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: o/bjtuzhu39YJOmdBjA1LBcxTfNhfptjwTZsOMuUS2XqQMrC8mwWGOMJWH4fGB7wcKhGRAYDSafB8Ivt/dqUVkCl342zpFyi4ZlpoXC/kF23MGlz2oyqRlCrncUkoe15lXZIpjiVQJUjuep8ZdsKwrOYRSxaYozKfu2qtGAYtCiyF+SvY+sfQ8ePt/eAEwI1wOZCIPra10+RQy2QZfJUvYkT+bPI2dX1WX1CtNEYWAeGHtKEzBb2iS7Dbx7j0nmPc3ev+YNEWM9+CJW6ZpFBfssYErlqJf3G3Tu+g51vUMqU5LtnyK+DiQiFzuJGdwmJvEzgpk/mh+QBencvGMtGD+cOAO1LWvwvMZ5Gi4TjPz7uzMPLbHQN8uow6YhD4YVQ6FlStTup2a8GZ7sWQRGIQhuhMn1Etwzap6MZdJD0scg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2019 06:28:03.1833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60dd3c86-2a2c-47dc-f083-08d70b49167d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4710
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=907 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Because software mode and register access are only available in spi, they
were moved in spi file and are accessbile via bops structure.
The write_os/scale will be overwritten by sw_mode_config function.
This patch was made in order to support devices in software mode without
making the driver dependent to spi and increase the abstraction of the
core.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
Changes in v2:
-nothing changed

 drivers/iio/adc/ad7606.c | 20 ++------------------
 drivers/iio/adc/ad7606.h | 12 +++---------
 2 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index a49dc106a21c..9eec3db01a17 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -597,7 +597,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
-	if (st->chip_info->sw_mode_config)
+	if (st->bops->sw_mode_config)
 		st->sw_mode_en = device_property_present(st->dev,
 							 "adi,sw-mode");
 
@@ -606,23 +606,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		memset32(st->range, 2, ARRAY_SIZE(st->range));
 		indio_dev->info = &ad7606_info_os_and_range;
 
-		/*
-		 * In software mode, the range gpio has no longer its function.
-		 * Instead, the scale can be configured individually for each
-		 * channel from the range registers.
-		 */
-		if (st->chip_info->write_scale_sw)
-			st->write_scale = st->chip_info->write_scale_sw;
-
-		/*
-		 * In software mode, the oversampling is no longer configured
-		 * with GPIO pins. Instead, the oversampling can be configured
-		 * in configuratiion register.
-		 */
-		if (st->chip_info->write_os_sw)
-			st->write_os = st->chip_info->write_os_sw;
-
-		ret = st->chip_info->sw_mode_config(indio_dev);
+		ret = st->bops->sw_mode_config(indio_dev);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index d547e88f4c9d..a6aac33aa33c 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -39,12 +39,6 @@
  *			oversampling ratios.
  * @oversampling_num	number of elements stored in oversampling_avail array
  * @os_req_reset	some devices require a reset to update oversampling
- * @write_scale_sw	pointer to the function which writes the scale via spi
-			in software mode
- * @write_os_sw		pointer to the function which writes the os via spi
-			in software mode
- * @sw_mode_config:	pointer to a function which configured the device
- *			for software mode
  */
 struct ad7606_chip_info {
 	const struct iio_chan_spec	*channels;
@@ -52,9 +46,6 @@ struct ad7606_chip_info {
 	const unsigned int		*oversampling_avail;
 	unsigned int			oversampling_num;
 	bool				os_req_reset;
-	int (*write_scale_sw)(struct iio_dev *indio_dev, int ch, int val);
-	int (*write_os_sw)(struct iio_dev *indio_dev, int val);
-	int (*sw_mode_config)(struct iio_dev *indio_dev);
 };
 
 /**
@@ -124,10 +115,13 @@ struct ad7606_state {
 /**
  * struct ad7606_bus_ops - driver bus operations
  * @read_block		function pointer for reading blocks of data
+ * @sw_mode_config:	pointer to a function which configured the device
+ *			for software mode
  */
 struct ad7606_bus_ops {
 	/* more methods added in future? */
 	int (*read_block)(struct device *dev, int num, void *data);
+	int (*sw_mode_config)(struct iio_dev *indio_dev);
 };
 
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
-- 
2.17.1

