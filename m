Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06EAD209BB
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2019 16:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfEPOby (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 May 2019 10:31:54 -0400
Received: from mail-eopbgr720082.outbound.protection.outlook.com ([40.107.72.82]:58404
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726739AbfEPOby (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 May 2019 10:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SGi4KzXxybIE2deu2WtQJI7ZoGuqAfdrEzycFR5+SU=;
 b=IRiN6M2+r4Z5qg2iWpXszVb3idjm6PfVAaTw3Y+LzbS3rSagpelVsottg8DCZATKrPau3ZWrC3C7l9y40rDrvBr6edhBZpjEBthpnSAJkv7E9c7+Uaun9BcDiMyWVtUg/pxFR0397Lxujc/O1wL9zAlL7NNmi8FtPJXPGPBBxrE=
Received: from MWHPR03CA0053.namprd03.prod.outlook.com (2603:10b6:301:3b::42)
 by BN3PR03MB2260.namprd03.prod.outlook.com (2a01:111:e400:7bb9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.24; Thu, 16 May
 2019 14:31:46 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by MWHPR03CA0053.outlook.office365.com
 (2603:10b6:301:3b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Thu, 16 May 2019 14:31:45 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Thu, 16 May 2019 14:31:45 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4GEVihC027556
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 16 May 2019 07:31:44 -0700
Received: from ben-Latitude-E6540.analog.com (10.50.1.133) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 16 May 2019 10:31:44 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 2/5] iio: adc: ad7606: Add software configuration
Date:   Thu, 16 May 2019 17:32:05 +0300
Message-ID: <20190516143208.19294-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516143208.19294-1-beniamin.bia@analog.com>
References: <20190516143208.19294-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(189003)(199004)(2616005)(446003)(426003)(36756003)(476003)(126002)(7416002)(486006)(11346002)(186003)(26005)(2351001)(76176011)(7636002)(6916009)(47776003)(86362001)(336012)(2906002)(7696005)(23676004)(246002)(8936002)(478600001)(5820100001)(72206003)(50466002)(77096007)(2870700001)(44832011)(53416004)(8676002)(70206006)(106002)(6666004)(54906003)(70586007)(14444005)(356004)(107886003)(1076003)(316002)(4326008)(5660300002)(50226002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2260;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bf7b98c-f5ec-4b19-7bdd-08d6da0b38df
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BN3PR03MB2260;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2260:
X-Microsoft-Antispam-PRVS: <BN3PR03MB22607F41D4954991C4F73FEAF00A0@BN3PR03MB2260.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0039C6E5C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: cP135MHxXNkn4i3XsCLSFOX/JdUsMsKDntD/9YRDhKRtiQe3judiZ0dUOosGlmNTA/aW1QQpV8q0yBIP4/MwK2VAamF636EdCM6Zo5unuSEWJ2wyuZ4UkONS6pZO2VSM9p54hThoVAwNfoFnAWZENKwBhAhH7aIyIQ9H6124klyT1lt6wCDZayhlUgSzsaa7n5wUDmYS8SDJjE1If15ZMKIw1804cZzxeic0tKhhJERTHuKSJGqijAcBoSOvo0/42hRMsZ/uZ+4L1kVcYCHA3QQPTnAG/ZprekgCMLyxlZNj4qlr7GAqJRqKOkcsyl2A2B6jGKTR9ozK6nUUSMAeXXpTtr3tnAdV+8S5SIVv8JjQitfg/iQ5GfiP2kc82ikTtP3TTeceGk9hGjpS8VaOqn7f8KL5Onwox8Ew7KTLJcA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2019 14:31:45.2018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf7b98c-f5ec-4b19-7bdd-08d6da0b38df
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2260
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Because this driver will support multiple configurations for software,
the software configuration was made generic.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7606.c | 40 +++++++++++++++++++++++++++++++++++++---
 drivers/iio/adc/ad7606.h |  2 ++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index c66ff22f32d2..aba0fd123a51 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -140,7 +140,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 			   int *val2,
 			   long m)
 {
-	int ret;
+	int ret, ch = 0;
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	switch (m) {
@@ -157,8 +157,10 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 		*val = (short)ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
+		if (st->sw_mode_en)
+			ch = chan->address;
 		*val = 0;
-		*val2 = st->scale_avail[st->range[0]];
+		*val2 = st->scale_avail[st->range[ch]];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
@@ -233,7 +235,9 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		mutex_lock(&st->lock);
 		i = find_closest(val2, st->scale_avail, st->num_scales);
-		ret = st->write_scale(indio_dev, chan->address, i);
+		if (st->sw_mode_en)
+			ch = chan->address;
+		ret = st->write_scale(indio_dev, ch, i);
 		if (ret < 0) {
 			mutex_unlock(&st->lock);
 			return ret;
@@ -616,6 +620,36 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
+	if (st->chip_info->sw_mode_config)
+		st->sw_mode_en = device_property_present(st->dev,
+							 "adi,sw-mode");
+
+	if (st->sw_mode_en) {
+		/* After reset, in software mode, ±10 V is set by default */
+		memset32(st->range, 2, ARRAY_SIZE(st->range));
+		indio_dev->info = &ad7606_info_os_and_range;
+
+		/*
+		 * In software mode, the range gpio has no longer its function.
+		 * Instead, the scale can be configured individually for each
+		 * channel from the range registers.
+		 */
+		if (st->chip_info->write_scale_sw)
+			st->write_scale = st->chip_info->write_scale_sw;
+
+		/*
+		 * In software mode, the oversampling is no longer configured
+		 * with GPIO pins. Instead, the oversampling can be configured
+		 * in configuratiion register.
+		 */
+		if (st->chip_info->write_os_sw)
+			st->write_os = st->chip_info->write_os_sw;
+
+		ret = st->chip_info->sw_mode_config(indio_dev);
+		if (ret < 0)
+			return ret;
+	}
+
 	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 					  indio_dev->name, indio_dev->id);
 	if (!st->trig)
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 143c30163df9..d8a509c2c428 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -43,6 +43,7 @@ struct ad7606_chip_info {
  * @range		voltage range selection, selects which scale to apply
  * @oversampling	oversampling selection
  * @base_address	address from where to read data in parallel operation
+ * @sw_mode_en		software mode enabled
  * @scale_avail		pointer to the array which stores the available scales
  * @num_scales		number of elements stored in the scale_avail array
  * @oversampling_avail	pointer to the array which stores the available
@@ -71,6 +72,7 @@ struct ad7606_state {
 	unsigned int			range[16];
 	unsigned int			oversampling;
 	void __iomem			*base_address;
+	bool				sw_mode_en;
 	const unsigned int		*scale_avail;
 	unsigned int			num_scales;
 	const unsigned int		*oversampling_avail;
-- 
2.17.1

