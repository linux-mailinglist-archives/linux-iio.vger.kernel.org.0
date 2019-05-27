Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3AA2B5D4
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2019 14:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfE0M4h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 May 2019 08:56:37 -0400
Received: from mail-eopbgr690085.outbound.protection.outlook.com ([40.107.69.85]:18415
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfE0M4h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 May 2019 08:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UIne8oV6ctAJDfGI3Gf8dcmfomCDrrAEN7ww+V4D9g=;
 b=BDUgfMbnj83i3V393eH5f36JPGTLJu1I7HU7OgVzeNt38WKRi4qrmvqNkxsZpBU259xr0yty7XmExZW2TUti9tO0pOC/PHhwGrQabal+jE6bhPeh+De6/B6AUMZ5iXIpb0NcIxr8HYsrO91vvNvkpvagYIBA+CBXHKTQ5eotq44=
Received: from MWHPR03CA0020.namprd03.prod.outlook.com (2603:10b6:300:117::30)
 by BY2PR03MB555.namprd03.prod.outlook.com (2a01:111:e400:2c37::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.20; Mon, 27 May
 2019 12:56:33 +0000
Received: from SN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by MWHPR03CA0020.outlook.office365.com
 (2603:10b6:300:117::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.18 via Frontend
 Transport; Mon, 27 May 2019 12:56:32 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT026.mail.protection.outlook.com (10.152.72.97) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Mon, 27 May 2019 12:56:32 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4RCuVgo022618
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 27 May 2019 05:56:31 -0700
Received: from ben-Latitude-E6540.analog.com (10.50.1.100) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 27 May 2019 08:56:30 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 2/4] iio: adc: ad7606: Add software configuration
Date:   Mon, 27 May 2019 15:56:48 +0300
Message-ID: <20190527125650.2405-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527125650.2405-1-beniamin.bia@analog.com>
References: <20190527125650.2405-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(2980300002)(199004)(189003)(36756003)(4326008)(316002)(7636002)(7696005)(77096007)(50466002)(23676004)(246002)(14444005)(54906003)(76176011)(186003)(7416002)(5660300002)(26005)(486006)(6916009)(5820100001)(126002)(107886003)(44832011)(1076003)(2870700001)(6666004)(356004)(478600001)(72206003)(106002)(336012)(476003)(305945005)(86362001)(53416004)(47776003)(11346002)(446003)(2616005)(2906002)(50226002)(426003)(2351001)(70206006)(70586007)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB555;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b3e6ea8-edfd-4cf1-fc1c-08d6e2a2be6f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709054)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BY2PR03MB555;
X-MS-TrafficTypeDiagnostic: BY2PR03MB555:
X-Microsoft-Antispam-PRVS: <BY2PR03MB555FB485D4D8033B0EF66E2F01D0@BY2PR03MB555.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0050CEFE70
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: HCOTY/YSEQy5WZUOrtWhmVk0FXIlc4r5DQca5sUMOxoih6z2uTCx3Kw6M0E8Hv8QhR85R1sV5npGbUuvnGKNSz2JIwJD0MZH+pMXdOLEy8zdn/YfVr3GWcCvZEDxP4OVMNmjaikMeF70RrdVbMoq2Tx6chiMYr8qH0A/oaEeyL/3VL0pzSDIXBPNrz/aqK2PKwz8Cj0WRCaKU0Uw2jE+nvkBRokS1WJCv2Qt8Uwovxfkpt/9giuTEAF5/ExA4ST2x/sU3rmtTsYB/TvXW93AEXdmZoTt4a/NxNoh16V6kdjH3wGPYWp+6nqEnSPKbHF51fX+/i/jACkcA1VRVZPJHbJUwqQKauKJRQ5zOgQwVz60EUcTkcYNTYrxx1OpYYWNzKfNwevNsWuNMMjIRUvJuOzjBKpAq7lyuQBajaf7eq8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2019 12:56:32.2219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3e6ea8-edfd-4cf1-fc1c-08d6e2a2be6f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB555
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Because this driver will support multiple configurations for software,
the software configuration was made generic.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
Changes in v2:
-nothing changed

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

