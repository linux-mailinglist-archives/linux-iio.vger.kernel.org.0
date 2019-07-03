Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698115E4D3
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2019 15:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfGCNHC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 09:07:02 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44794 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbfGCNHC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2019 09:07:02 -0400
X-Greylist: delayed 5383 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jul 2019 09:07:01 EDT
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63BYYRL007295;
        Wed, 3 Jul 2019 07:37:31 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2054.outbound.protection.outlook.com [104.47.33.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tg45rb98h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 07:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfMPqIX0f6Huqbgzl87JFL+yDj3DDJogxED+r263rE0=;
 b=4k9IOkHr5811lCDwK5CN2rc8Gp/wWTV7Lbjtn4dz7xyB+mXT4gmtxtqyZXUrqh05IODC8IC96pv+961StIHsT7h3ZZIXmw6kQ3Jqk+kgKFKRf/+q3n52vCP5LCxnGgEbOEaDdfArNcm/ZjY6aE1XZqA96U7JPJKCaurTNaaHvSs=
Received: from MWHPR03CA0018.namprd03.prod.outlook.com (2603:10b6:300:117::28)
 by BN6PR03MB3268.namprd03.prod.outlook.com (2603:10b6:405:42::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20; Wed, 3 Jul
 2019 11:37:29 +0000
Received: from BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by MWHPR03CA0018.outlook.office365.com
 (2603:10b6:300:117::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.20 via Frontend
 Transport; Wed, 3 Jul 2019 11:37:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT054.mail.protection.outlook.com (10.152.77.107) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Wed, 3 Jul 2019 11:37:28 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x63BbRPE016738
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 3 Jul 2019 04:37:27 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 3 Jul 2019 07:37:27 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 2/5] iio: adc: ad7606: Move spi dependent features to spi file
Date:   Wed, 3 Jul 2019 17:36:45 +0300
Message-ID: <20190703143648.24402-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703143648.24402-1-beniamin.bia@analog.com>
References: <20190703143648.24402-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(2980300002)(199004)(189003)(50226002)(7636002)(305945005)(8936002)(8676002)(246002)(7696005)(316002)(54906003)(50466002)(86362001)(51416003)(16586007)(2906002)(106002)(4326008)(77096007)(76176011)(6916009)(6666004)(5660300002)(26005)(486006)(356004)(478600001)(47776003)(476003)(186003)(2616005)(126002)(72206003)(446003)(426003)(14444005)(107886003)(70206006)(11346002)(44832011)(36756003)(70586007)(1076003)(336012)(2351001)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3268;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c2a7b21-111e-4763-f41b-08d6ffaad3bf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN6PR03MB3268;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3268:
X-Microsoft-Antispam-PRVS: <BN6PR03MB32686720B91394AA92BB831DF0FB0@BN6PR03MB3268.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 00872B689F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: dsU6VmfL7Nmp+kFPchlo6+NKhryxtwMw9jpGCgeANGWvsLw+CUa8COvoZQHzFsUyjIoZWRrtULvx5k2Vqj3h1eWctS4i1o1my3HuKV0zJRLQz1juFUtLtIqDNvHpPmQNay/lnNaup68rXmb5kHBwpuQab5eES+P0bno1uBH3ff9pzTpH5K8y4EstH74gE2us306SZZvLv2Y9jMZrl+NBKnA+29MPu45zql6MyscyMFOboSfSSXZEsUldgMGGZjGXnbrjniJm9OsCKfmX35bn1e+F3ML1ACDZd+QJTtz5JxOqyT40vpvnvyGTqOJjeXheLdo6TeliV7nxJCNZ9eeZhgf0k27lK7OYUEPv9vaF5/dMFkJ+wG2gFO0A9SWW/XP1o9bJ6jTtISrI02Jgym8bfH2L+mJcZq8okIyyHvauZ9s=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2019 11:37:28.0588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2a7b21-111e-4763-f41b-08d6ffaad3bf
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3268
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=929 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030140
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
---
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

