Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18FD0189FF4
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 16:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgCRPv7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 11:51:59 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:41014 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbgCRPv7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 11:51:59 -0400
X-Greylist: delayed 1012 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2020 11:51:58 EDT
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02IFQRMf028863;
        Wed, 18 Mar 2020 10:34:47 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by mx0b-00010702.pphosted.com with ESMTP id 2yu7hwjcrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 10:34:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAykSKwr58T8iQNylJE6wwJ/N1RIizJNMQ4maAnC4ZcD7vyWLiz6foxjx/ehIQgOkgZHjdKxVm8CGCd3RRplW+/d5ReDhPiO5BkkhBLKRCjIXCejMUVbpnqM/n75Unh3iKqxT87vtBk3D0rjs3C3JIrcdrrt3Qi4+3v5S1DOKmqMd50k8vrLEG5yXAMLg7BzvsWlhd/GRzi09SGL+KVy54qBTDkb32AbIHfbnWa+VfLylPtGw0z708l2fxgBOm8E+FXzSMbtkjaQvIpWsaBILQDeU2m8BD/k3rJDLWt7Fvhst+yFiQ4z2Jzg998v16hU+GV8z1bPuAdYbSd8I8fQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osOxW0xmv8CtKoj2CnKnys/o4ArDrwMoJtrdny7Tpgo=;
 b=aXmUQCZCnGG3WTmnYFShHVr76vHU5cMu2Qrq3dt5TEUNz+z6ewQx21ZzBtPX9p+FMGK8OScoVLXETerKAVJW4AA83p6DWFtfGb15OC0RykuCuYwbK6AisoO3SQ22Kb89rSwQGKQVdWWHPOwFhrBXiXhW6/QK/9uEhXlFvEjRCP5XF4NHFxKfXA5VSryVXBxNXPv9WCYnvydFiIDVLLoeU0o2w1iP2nmSKWEx2RB4A8ze82JxgYfr6zG3T8aT8lwMOywM9D+XKBuMOlphhB7kvUxBGURki5gPLu0C7A1dLeK/5l8UORkMRvhDBYBUQ5y3LGgUN0eIXQDSKEtFrThrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osOxW0xmv8CtKoj2CnKnys/o4ArDrwMoJtrdny7Tpgo=;
 b=C/FWHBlI4zF8EKYV99mQUjIDCM+Qbzmsp70JeUr1wE+fx9PLXWuKea52rNIDxkTPRrnY7QlsiMGxvn50voKqkX1aXlDWbNiHM6VDxrZpXh2vyVsK17VEZ4dmWR5+Jj8txCgTwWdA4cmqVo1J2W9g4zSNlPtq1zxsvuNe5TAwJic=
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3709.namprd04.prod.outlook.com
 (2603:10b6:803:48::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 15:34:45 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4%5]) with mapi id 15.20.2793.023; Wed, 18 Mar 2020
 15:34:45 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Michael Auchter <michael.auchter@ni.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: dac: ad5686: add support for AD5338R
Date:   Wed, 18 Mar 2020 10:34:32 -0500
Message-Id: <20200318153434.62833-1-michael.auchter@ni.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM3PR14CA0146.namprd14.prod.outlook.com
 (2603:10b6:0:53::30) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xaphan.phire.org (66.90.216.181) by DM3PR14CA0146.namprd14.prod.outlook.com (2603:10b6:0:53::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend Transport; Wed, 18 Mar 2020 15:34:44 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [66.90.216.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4ae5cf5-5921-4aec-3e55-08d7cb51e2c3
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3709:|SN4PR0401MB3709:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR0401MB37098F3BE0BCFD2AA9FF0DE087F70@SN4PR0401MB3709.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(66556008)(66476007)(8676002)(2906002)(81166006)(81156014)(66946007)(2616005)(36756003)(6506007)(44832011)(6512007)(6486002)(5660300002)(110136005)(478600001)(16526019)(316002)(52116002)(956004)(4326008)(8936002)(6666004)(26005)(186003)(1076003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3709;H:SN4PR0401MB3646.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrVhWC+nAhXHyoUyppmRQ79oFBB4HPG1RxqvmrYGj586snKdoTH2NMLvjwgZsR9HyH+CfSe4nT57bUw+kVgfkmtRmzajgfqSn7dRJsMCcXgdoxy655cxaJk+uZTFSrDNrDraM38S+OVCfO8NRaIFKnLNOEycaXEV0LXLHZ0TXBFaDfetYVzcGCOLs4g3/wWqaENaR2sATzrwVrfKmtKHo+vKTibVdRUUeIceoMmy87wsp2FeFd4+cXa64JGRMdOBtq7ktj99cE0P5WSh8nn1kXScHIxxVyR+mm34Y2voXY4dSIofnnPTuMrKbF6VodcwEr75KoKPR4248IIqChya/NUuV+c7pnlIJa1ldfBLiVm471wnJrc+YsVlsytRZp51JGU2CzIENQdjNc9Rgf7KGCmw68RDF1Vzb2Mk29BRt9n4yT+pMR8DotuVvnuyg++1
X-MS-Exchange-AntiSpam-MessageData: fhM908tVYGFUcnFPzgG0m5yhBaaDUaVXMWAgKNc1JD6nX5v6uogVvZJxOhv6rm7tv/48R9Bw8oQ1Mf5LbNmStmNL2pDDNeF0PKvwIV97Ir7lgk0+uz1ZAE8b09Ep42bs8C4bQouj4plYx+eErPn72A==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ae5cf5-5921-4aec-3e55-08d7cb51e2c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 15:34:45.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxfnBTqyvBi8acSEtZO+yaFVUS0q+GUBEpg5uR1huV0rjaRCUiduLaPNDRzpz/Nm51/WUWtGPgv2QbslJcP1VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3709
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_07:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003180073
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD5338R is a 10-bit DAC with 2 outputs and an internal 2.5V
reference (enabled by default). The register configuration is nearly
identical to the AD5696R DAC that's already supported by this driver,
with the channel selection bits being the only thing different.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 drivers/iio/dac/ad5686.c     | 13 +++++++++++++
 drivers/iio/dac/ad5686.h     |  1 +
 drivers/iio/dac/ad5696-i2c.c |  1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index e06b29c565b9..bbcac0e44837 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -210,6 +210,12 @@ static struct iio_chan_spec name[] = {				\
 		AD5868_CHANNEL(0, 0, bits, _shift),		\
 }
 
+#define DECLARE_AD5338R_CHANNELS(name, bits, _shift)		\
+static struct iio_chan_spec name[] = {				\
+		AD5868_CHANNEL(0, 1, bits, _shift),		\
+		AD5868_CHANNEL(1, 8, bits, _shift),		\
+}
+
 #define DECLARE_AD5686_CHANNELS(name, bits, _shift)		\
 static struct iio_chan_spec name[] = {				\
 		AD5868_CHANNEL(0, 1, bits, _shift),		\
@@ -262,6 +268,7 @@ DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
 DECLARE_AD5693_CHANNELS(ad5693_channels, 16, 0);
 DECLARE_AD5693_CHANNELS(ad5692r_channels, 14, 2);
 DECLARE_AD5693_CHANNELS(ad5691r_channels, 12, 4);
+DECLARE_AD5338R_CHANNELS(ad5338r_channels, 10, 6);
 
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 	[ID_AD5310R] = {
@@ -413,6 +420,12 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.num_channels = 4,
 		.regmap_type = AD5686_REGMAP,
 	},
+	[ID_AD5338R] = {
+		.channels = ad5338r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 2,
+		.regmap_type = AD5686_REGMAP,
+	},
 };
 
 int ad5686_probe(struct device *dev,
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 70a779939ddb..02eb196fcf0f 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -77,6 +77,7 @@ enum ad5686_supported_device_ids {
 	ID_AD5695R,
 	ID_AD5696,
 	ID_AD5696R,
+	ID_AD5338R,
 };
 
 enum ad5686_regmap_type {
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index ccf794caef43..f100a5fe4219 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -83,6 +83,7 @@ static const struct i2c_device_id ad5686_i2c_id[] = {
 	{"ad5695r", ID_AD5695R},
 	{"ad5696", ID_AD5696},
 	{"ad5696r", ID_AD5696R},
+	{"ad5338r", ID_AD5338R},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ad5686_i2c_id);
-- 
2.24.1

