Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4D08B1AD
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 09:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfHMH4W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 03:56:22 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20868 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728044AbfHMH4S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2019 03:56:18 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7D7rf1I025313;
        Tue, 13 Aug 2019 03:55:57 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u9tu6q730-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 03:55:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1tvGj4kBcWGtui5Bk63voCspeGEgdUN/JG5OPMMz9YBz9khR+veVnGRo5I7iueQ11yD8jD/8/e69MX8sWMmpieEvfm/ltWB2WHUwmmerZjVUB/NCkLUc8+KCZFpiizAE6wErVKdjlucXTfTzguXuRrGhXHcw0UBqoS7uYeCVRC9b6V9jV0h5nO5bEgsQAJ8p7cjB+1O3x/U79XeUrMszERCO3gn5eqBUrEIlAL6E8qNzzvoX6xKuOfOdcUZVxNDYyvI/jQ/1sna54H92jezc8efb3U9L+puQukmC8sjx5I7/wPR/hvfApKsKYH8J0uVlf+Ynth+iMvYW0NZ2Yp8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp6JG+dH5rwYbvwVOUH7VzBEcr+M2ZRvEKnu8WvRV+M=;
 b=WFUjXWbxS78lLbQej4pNvZYTHtJZWR6+sPqXkKa4CK4W5ZO0eKF8IUuzgs0Vkf2bMoPhM/bUnnMhk10pGcyyaZ995swk8s9gnmCXogHLe0OTfgn3+NpZfEUidjGvULUnN8OyasYAQtEJtbI60VvTyEuJKNW4514TNsGJTHMz8frXqrisAl8rFON4kHTdONlSzObB1w8630uoGUDV3kFBVBV3M8fNKR5spfoK3BZlJYtnky0HGUbuVe1p/wkB8VNyywT7L5bFa6kW27JW/i9HDfZGyUDjNgX9U0oDjK6vpk638EfPmxx1Gnkpg2H/BlANHFKZi4s+p42RKVCvM/c+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp6JG+dH5rwYbvwVOUH7VzBEcr+M2ZRvEKnu8WvRV+M=;
 b=7Elh/vO7T7ogY5rxiSTG57t/KO59kWlp2XHQr0lZg00zbSDDPXSLS2ugN1LN6KjxRO+7ezpXsLd6CSJ/hWVQFa2BIiQjMv/SGAVr/C1PUQFFC93JjYJMGHfayvv5EGvPldfRvoF7uRUasiAVli9oexanDXFn4rhi01S41iY/fzc=
Received: from BN6PR03CA0058.namprd03.prod.outlook.com (2603:10b6:404:4c::20)
 by BL0PR03MB3987.namprd03.prod.outlook.com (2603:10b6:208:66::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.20; Tue, 13 Aug
 2019 07:55:55 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN6PR03CA0058.outlook.office365.com
 (2603:10b6:404:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Tue, 13 Aug 2019 07:55:55 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Tue, 13 Aug 2019 07:55:54 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x7D7tpWk016023
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 13 Aug 2019 00:55:51 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 13 Aug 2019 03:55:53 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V2 3/4] staging: iio: adc: ad7192: Add system calibration support
Date:   Tue, 13 Aug 2019 10:55:43 +0300
Message-ID: <20190813075544.9122-3-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813075544.9122-1-mircea.caprioru@analog.com>
References: <20190813075544.9122-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(189003)(199004)(54534003)(476003)(8936002)(336012)(26005)(48376002)(50226002)(186003)(86362001)(76176011)(50466002)(70206006)(51416003)(70586007)(7696005)(1076003)(2351001)(11346002)(47776003)(486006)(446003)(44832011)(2616005)(126002)(6916009)(2906002)(426003)(478600001)(6666004)(36756003)(356004)(8676002)(246002)(106002)(14444005)(54906003)(7636002)(305945005)(5660300002)(316002)(16586007)(107886003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR03MB3987;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6e5b314-397f-4e38-6da5-08d71fc3ab28
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BL0PR03MB3987;
X-MS-TrafficTypeDiagnostic: BL0PR03MB3987:
X-Microsoft-Antispam-PRVS: <BL0PR03MB3987E115ECD1461ADDFF2B7481D20@BL0PR03MB3987.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 01283822F8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: BmUOvg6pyrYW0B15gXTsY00pT0lPbKayfeboBfIjmtvfFwqTUqTrShmeW/aKoZnVK7dkGiKeJeP0vmbBF3eXVtDpGBAtrI8zpSs9HtM64xI/43I1FX7wnnEvsXnyZTpzWnz78cHWDMVdTkHwc4DX1pNKtdaAkG8OqE27KLYYKM8tAkHYMN/siGzWE9g4AjfgFiXPEdaklnDjJBi1kfkxd/tZTudyLaKFsKjUUfxJ6hq5R2sR5/zaX81MesgFOXF5KI9E3xXEm57SOKsX/3rpV2csbgZWmuSzNay0UeMIcFDhhlv38mTuIVYwpuBQLZqWf7wbgQQzipFd0Jo/vbiKkZ0XIVG2088Y67FD/dwjJA+gV/vwf8QMxgMvWhcfshrV5ZlBVDWmmcfWBu7TguSFaPIJ68Dd/RbLJiydpryFKGw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 07:55:54.5840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e5b314-397f-4e38-6da5-08d71fc3ab28
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR03MB3987
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130087
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch will add a system calibration attribute for each channel. Using
this option the user will have the ability to calibrate each channel for
zero scale and full scale. It uses the iio_chan_spec_ext_info and IIO_ENUM
to implement the functionality.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
Changelog V2:
- no changes here

 drivers/staging/iio/adc/ad7192.c | 55 +++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index d58ce08f3693..731072830f30 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -155,6 +155,11 @@
  * The DOUT/RDY output must also be wired to an interrupt capable GPIO.
  */
 
+enum {
+   AD7192_SYSCALIB_ZERO_SCALE,
+   AD7192_SYSCALIB_FULL_SCALE,
+};
+
 struct ad7192_state {
 	struct regulator		*avdd;
 	struct regulator		*dvdd;
@@ -169,10 +174,56 @@ struct ad7192_state {
 	u8				devid;
 	u8				clock_sel;
 	struct mutex			lock;	/* protect sensor state */
+	u8				syscalib_mode[8];
 
 	struct ad_sigma_delta		sd;
 };
 
+static const char * const ad7192_syscalib_modes[] = {
+	[AD7192_SYSCALIB_ZERO_SCALE] = "zero_scale",
+	[AD7192_SYSCALIB_FULL_SCALE] = "full_scale",
+};
+
+static int ad7192_set_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    unsigned int mode)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->syscalib_mode[chan->channel] = mode;
+
+	if (mode == AD7192_SYSCALIB_ZERO_SCALE)
+		ret = ad_sd_calibrate(&st->sd, AD7192_MODE_CAL_SYS_ZERO,
+				      chan->address);
+	else
+		ret = ad_sd_calibrate(&st->sd, AD7192_MODE_CAL_SYS_FULL,
+				      chan->address);
+
+	return ret;
+}
+
+static int ad7192_get_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+
+	return st->syscalib_mode[chan->channel];
+}
+
+static const struct iio_enum ad7192_syscalib_mode_enum = {
+	.items = ad7192_syscalib_modes,
+	.num_items = ARRAY_SIZE(ad7192_syscalib_modes),
+	.set = ad7192_set_syscalib_mode,
+	.get = ad7192_get_syscalib_mode
+};
+
+static const struct iio_chan_spec_ext_info ad7192_calibsys_ext_info[] = {
+	IIO_ENUM("system_calibration", IIO_SEPARATE, &ad7192_syscalib_mode_enum),
+	IIO_ENUM_AVAILABLE("system_calibration", &ad7192_syscalib_mode_enum),
+	{}
+};
+
 static struct ad7192_state *ad_sigma_delta_to_ad7192(struct ad_sigma_delta *sd)
 {
 	return container_of(sd, struct ad7192_state, sd);
@@ -769,9 +820,11 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
 		*chan = channels[i];
 		chan->info_mask_shared_by_all |=
 			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY);
-		if (chan->type != IIO_TEMP)
+		if (chan->type != IIO_TEMP) {
 			chan->info_mask_shared_by_type_available |=
 				BIT(IIO_CHAN_INFO_SCALE);
+			chan->ext_info = ad7192_calibsys_ext_info;
+		}
 		chan++;
 	}
 
-- 
2.17.1

