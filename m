Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72BE209C7
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2019 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfEPOcL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 May 2019 10:32:11 -0400
Received: from mail-eopbgr820040.outbound.protection.outlook.com ([40.107.82.40]:33952
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727302AbfEPOcK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 May 2019 10:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRhO/WneK8OkvT0vg1J+IkY22eEP8Ai6PE2L8A63r/k=;
 b=uhyEV/dQY8uo4yeEcs3lLbIysbkgQpOMJc9Pdq8C6oqu9Fch4D8eggc+NqB0X6oHBM/z1mdtmAbbuvpDpgICnEK5l7Jo+u+d39P3wSokkbk1Xrl6hZBYWF+zNOztdJdqUSknE3esNhvvvuCz8DYhWUMOFuCD/fhPaYiIDjpcqUw=
Received: from DM6PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:100::22)
 by BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.25; Thu, 16 May
 2019 14:32:05 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by DM6PR03CA0045.outlook.office365.com
 (2603:10b6:5:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Thu, 16 May 2019 14:32:05 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Thu, 16 May 2019 14:32:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4GEW3KM027706
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 16 May 2019 07:32:03 -0700
Received: from ben-Latitude-E6540.analog.com (10.50.1.133) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 16 May 2019 10:32:03 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 5/5] iio: adc: ad7606: Add debug mode for ad7616
Date:   Thu, 16 May 2019 17:32:08 +0300
Message-ID: <20190516143208.19294-5-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516143208.19294-1-beniamin.bia@analog.com>
References: <20190516143208.19294-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(189003)(199004)(77096007)(36756003)(186003)(7416002)(48376002)(26005)(50466002)(47776003)(476003)(8936002)(246002)(126002)(2616005)(2906002)(44832011)(1076003)(8676002)(486006)(7636002)(11346002)(305945005)(53416004)(6916009)(426003)(356004)(446003)(50226002)(336012)(5660300002)(2351001)(76176011)(14444005)(51416003)(7696005)(107886003)(70206006)(70586007)(316002)(4326008)(54906003)(106002)(86362001)(478600001)(16586007)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfeba55f-a1fa-4757-bd11-08d6da0b448e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BL2PR03MB545;
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-Microsoft-Antispam-PRVS: <BL2PR03MB545B471AEFA48984997DB4BF00A0@BL2PR03MB545.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 0039C6E5C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bKzjliGvFOZU7IxS/cX0B2L9ZRQetumQLRqM1mXNMXGU7+NrBPA7zpOeIu/W8LewiHQ2QfxyNGBYsBHDB4pCOKo3FKUNcr3f4Bg5w6iepD1NKh2H8vO28brznjwmcbUJj7eXICl4w4LF7uvYuc3zlcE8YFjMR93EVtI681BvBNjb91Q5gYa6x5UcdTjUw43j7C3CJaTx7px4E/umdm59PgHBDDy80C4ejAyqR98UJx3jY0Fp9FXhCGLMIvlzHuiI3v2VGZIA22tgi3kjxvy6cO6JFhDJsWgvEblTm5gkv2UnMiLzGAVG8aNxnywqZW+GxQ5gT2QxULEhq1DKnl/mhLYhYWPnuHoXg1bwhKORuVJqY06ZFC+29vbOVIom/mFPfMFfgaNvrH0j/QunKehPLH46etpIZk5mBsoaIFP2Nkc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2019 14:32:04.3820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfeba55f-a1fa-4757-bd11-08d6da0b448e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Support for register access was added for spi devices.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7606.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index f77df3efe43f..b03bdce4fd4e 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -134,6 +134,30 @@ static int ad7606_spi_write_mask(struct ad7606_state *st,
 	return ad7606_spi_reg_write(st, addr, readval);
 }
 
+static int ad7606_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	if (readval) {
+		ret = ad7606_spi_reg_read(st, reg);
+		if (ret < 0)
+			goto err_unlock;
+		*readval = ret;
+		ret = 0;
+	} else {
+		ret = ad7606_spi_reg_write(st, reg, writeval);
+	}
+err_unlock:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static int ad7606_read_samples(struct ad7606_state *st)
 {
 	unsigned int num = st->chip_info->num_channels;
@@ -645,6 +669,7 @@ static const struct iio_info ad7606_info_no_os_or_range = {
 static const struct iio_info ad7606_info_os_and_range = {
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
+	.debugfs_reg_access = &ad7606_reg_access,
 	.attrs = &ad7606_attribute_group_os_and_range,
 	.validate_trigger = &ad7606_validate_trigger,
 };
-- 
2.17.1

