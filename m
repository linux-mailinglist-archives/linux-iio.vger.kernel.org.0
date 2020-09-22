Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CF327485D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 20:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIVSlj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 14:41:39 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:32194 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgIVSlj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 14:41:39 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08MITM3P020944;
        Tue, 22 Sep 2020 13:41:20 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-00010702.pphosted.com with ESMTP id 33nft7q5s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 13:41:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bdv1fx9e+lxqVFGzh8+rSZLX3u9Z+/9/RMnfGDJ5/Zr/2pHnLthRog965PlWeE47QiVe/8F9raONqwTYu5b3D+/mnWOeQY6Q81Ym7zs6GDiHbtOmBYjEkXyft9fdVsjeviek6CWa4ItREkh+2tfeys0oz5qHnhULZ4OPyWzU77nvs1XmpdARAKsTllk3QWSvP8KsV3yCTsvx2P9KqqyZ1xCfa4Nn5mNF91ODqpTJLh6Dv38x7s95874zZju2np+ehmhuYDq5mWVcBKTLPTjliAiyfPAAv6Al0pKcgPBysFajEN457bUX/Y5eUKYM1GOI0SpsWl4N67uUNttFDH8rmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIHl+v3bat++/mUP3XsmoEVCc75nDa21iWhIvhWvk/k=;
 b=n4Jlnx4hjnh1esVvDFsua+esCpMQos/cTPNd70QBxc21I9ik47SeRABiMmAc8ejXSk/1yf3BfTOLqVoT/4O0VS7ijSbBsx0XGoiuMMCbqIybFaoWI+Cx76lrZ5ixS8vufYmtGNFyR7FOnQQY+s+CoU//zJ95CD9iFkvSpfmBxNitUCczPeRnU5iW9SD7Xx6ldBdWAXWN4zwZke7oj1rt4AXwmB8fxCCCwqN8+wGcoUkbyfyaG4G1bYC0h6y+bqOCalf8WMRAGjZNQGDg6thqTTldtXhMdw8rwf16GM77VxtJAW/k9Qiy3qjc2A5/sU+oDzS5sDDbWSJ/ofHmwB1P7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIHl+v3bat++/mUP3XsmoEVCc75nDa21iWhIvhWvk/k=;
 b=mVQ/c78f7YUajOMq/X9Ku7BJ/slaABedgf8UCxNtU1CHlZpn8AWO98nbHHZhx4IZThZ6Adr26ot+XURXyy9/Gde/xvav6b93yssgoktwgubhNGLITn2KpC3yCKWewo0azrEgai2dhr45inCSQarX7/dkh5TNa5XTGa7qxVmkJ3o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB4909.namprd04.prod.outlook.com
 (2603:10b6:805:95::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 22 Sep
 2020 18:41:16 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3391.023; Tue, 22 Sep 2020
 18:41:16 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 1/3] iio: dac: ad5686: add support for AD5338R
Date:   Tue, 22 Sep 2020 13:40:10 -0500
Message-Id: <20200922184012.557622-1-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:805:ca::16) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab6f:2000:2739:a39e:9b12:ab20) by SN6PR16CA0039.namprd16.prod.outlook.com (2603:10b6:805:ca::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 22 Sep 2020 18:41:16 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2605:a601:ab6f:2000:2739:a39e:9b12:ab20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0025617-5daa-41be-1389-08d85f2716e1
X-MS-TrafficTypeDiagnostic: SN6PR04MB4909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB4909A986FA2275040FD587C4873B0@SN6PR04MB4909.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5w9dTtkHigEkuijTK6QpY4iVk29cfgqR0c6bdAAlUdMdiY0guVnAsu4vbZQVuXyjAI09TbJiWWjQCmTTMOV8p7zEHC3QV8Sdlcq+5BiQ/QxZtDxpADuOu7iAMWDIo936J4B7hjMayWt+bDD5bGvoaMrpISILi9EZcENuZ5dJmgWOg9+e7JGT884QRi3xT4hfopqmMjB5aHp3cHz2AlpX4QNemTVOMSUENgpKdxrI/1H9S+94510cwf8rdjvXLJSQOfVqcji7L9gSg3lSM6lhPFjwDWz6s25Wctb2P9hy4gU9PThvjxa3ZGSAtHqi1Z/JvbhVcp1qADev2EshW25J9ePagDcHfI7N4E3Ax8l8+lq51xP6B2YN+Q8ngXnsFP3oGha8A9Ft1EZ+KjmWfg316JlcO+Aa0W2/AEKVaCYx59UjiJ6NF4CdBPE5ljAZUuL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(346002)(376002)(366004)(52116002)(66946007)(6512007)(44832011)(66556008)(478600001)(186003)(6486002)(5660300002)(6666004)(2616005)(8676002)(2906002)(16526019)(4326008)(36756003)(6506007)(66476007)(8936002)(86362001)(69590400008)(1076003)(83380400001)(110136005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Z0Y6kunwlw1MYtISMTaIEOSnXY6AJDZ43Lui4L9SwaVB8AU+9wsxoaXU5VfRoj6FuLpqmTSU/gXsLcOaUPerhOmCcRlHqZmr/YqFnykZaWIEXMmFSxoDxnVG7n/ShfExaubgVP3qURp7iPg2vOwtbDDFD8/nBdt1ssqItFauCYMLctnnW2FcMu/6UOXSE1WgMWLcOhW0mp82FG7+9UMm9JwV+XmYIbTByeRlnnHEElvjPxtnlBefCNfyq1D+0yYAgVfUisnj5kYggqTi8TPGjWAjBx9ZIClDxM8kH/eE/BrqxEboopVy/ql5EOk0RNuvOIdbbgz7qNxRNYduCgE5O2tpbXZ+HPuMQySyhM9G4BQ+b0ESw5nfYvHIoJoQGah/bxUmvuVZhM9IGgcOcDVG5sVR4uuI5QhU7NMfrnwKr2GuKXRFRrEY79l78KDgy7Ugn0pdYCMn6vTFDp8KCHQoQQx+zjteLPeqp5j8YUMSmfMpOFw9tOzPyX7XKbwlPoE0xJe+5rojn3GF2CZNxrb1DO78cpfIsToKe6O28ds4bmKejUyJCVKWcZQDbrZOoKaGM8sEV5AcOQKMIqapLXGUQnaydomvGRXP/wF6t8q45HsDzdIKw1Gq3Xr0/FSRkFFrhv72kl6MhOjaallM5KzAq64nzKiWJR6nFjRCBusGsPE7vHdFmQysgMunsVIIoAWj+DtCs6UmkR/tqrAbl7brGw==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0025617-5daa-41be-1389-08d85f2716e1
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 18:41:16.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwpGI4meOcoESCPjmAGT6oXp+ixeai88LCKgN1U4fd4jSFt5fPMVVXMdTMwypggrs4OZ1pnHHSykqDaGfdf9iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4909
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_17:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 mlxscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220144
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD5338R is a 10-bit DAC with 2 outputs and an internal 2.5V
reference (enabled by default). The register configuration is nearly
identical to the AD5696R DAC that's already supported by this driver,
with the channel selection bits being the only thing different.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
Changes since v1:
- Keep things sorted by product name
- Update Kconfig description to list supported converters

 drivers/iio/dac/Kconfig      |  7 ++++---
 drivers/iio/dac/ad5686.c     | 13 +++++++++++++
 drivers/iio/dac/ad5686.h     |  1 +
 drivers/iio/dac/ad5696-i2c.c |  1 +
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index dae8d27e772d..6f6074a5d3db 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -141,9 +141,10 @@ config AD5696_I2C
 	depends on I2C
 	select AD5686
 	help
-	  Say yes here to build support for Analog Devices AD5671R, AD5675R,
-	  AD5694, AD5694R, AD5695R, AD5696, AD5696R Voltage Output Digital to
-	  Analog Converter.
+	  Say yes here to build support for Analog Devices AD5311R, AD5338R,
+	  AD5671R, AD5675R, AD5691R, AD5692R, AD5693, AD5693R, AD5694, AD5694R,
+	  AD5695R, AD5696, and AD5696R Digital to Analog converters.
+
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad5696.
 
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 56cf9344d187..382b3eb7ec06 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -210,6 +210,12 @@ static struct iio_chan_spec name[] = {				\
 		AD5868_CHANNEL(0, 0, bits, _shift),		\
 }
 
+#define DECLARE_AD5338_CHANNELS(name, bits, _shift)		\
+static struct iio_chan_spec name[] = {				\
+		AD5868_CHANNEL(0, 1, bits, _shift),		\
+		AD5868_CHANNEL(1, 8, bits, _shift),		\
+}
+
 #define DECLARE_AD5686_CHANNELS(name, bits, _shift)		\
 static struct iio_chan_spec name[] = {				\
 		AD5868_CHANNEL(0, 1, bits, _shift),		\
@@ -252,6 +258,7 @@ static struct iio_chan_spec name[] = {				\
 
 DECLARE_AD5693_CHANNELS(ad5310r_channels, 10, 2);
 DECLARE_AD5693_CHANNELS(ad5311r_channels, 10, 6);
+DECLARE_AD5338_CHANNELS(ad5338r_channels, 10, 6);
 DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
 DECLARE_AD5679_CHANNELS(ad5674r_channels, 12, 4);
 DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
@@ -276,6 +283,12 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.num_channels = 1,
 		.regmap_type = AD5693_REGMAP,
 	},
+	[ID_AD5338R] = {
+		.channels = ad5338r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 2,
+		.regmap_type = AD5686_REGMAP,
+	},
 	[ID_AD5671R] = {
 		.channels = ad5672_channels,
 		.int_vref_mv = 2500,
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 52009b5eef88..c714afa40adf 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -52,6 +52,7 @@
 enum ad5686_supported_device_ids {
 	ID_AD5310R,
 	ID_AD5311R,
+	ID_AD5338R,
 	ID_AD5671R,
 	ID_AD5672R,
 	ID_AD5674R,
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index ccf794caef43..89e7b063b7bb 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -72,6 +72,7 @@ static int ad5686_i2c_remove(struct i2c_client *i2c)
 
 static const struct i2c_device_id ad5686_i2c_id[] = {
 	{"ad5311r", ID_AD5311R},
+	{"ad5338r", ID_AD5338R},
 	{"ad5671r", ID_AD5671R},
 	{"ad5675r", ID_AD5675R},
 	{"ad5691r", ID_AD5691R},
-- 
2.25.1

