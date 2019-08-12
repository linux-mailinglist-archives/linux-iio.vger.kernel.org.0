Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4279D8994F
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfHLJEU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 05:04:20 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15256 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727420AbfHLJEQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Aug 2019 05:04:16 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7C92fqx010313;
        Mon, 12 Aug 2019 05:03:55 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2051.outbound.protection.outlook.com [104.47.50.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u9qs7vuxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 05:03:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEtIMq8f/yFisZ8dQHZo+T2e6u6R1SsqicYh1bB0Hvoph9QVK53UzWOmHYe9OuVJIWMCdHWBEZgl2keG1SHxbU27gUL5I7s/rwsRMnyK9QZ80L3B4OpOrhvPwwPHqVUDtnqfsKH7ppS/ENNbySzzAN2xSzXntpMPVmZDYu+iQ7Rjr9dMFmGud91f30PaiBzIWrZ5U4kq0l4XwqGwq8IoPFeGUxGAm1ZFI4GgHFx1StNzJp0/nNB5DxoXOZHsfSOmBecuwp8MmavB8rXl9YYc2Ta+WITwE0tMsO7dfE+SlxT3Wg8lauU3NNqlyExU6Mh1yqCJ5rwuumnF5jjVbNsopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEoLPbN6YLqz89K0Hj0p9p7mRtRqxKbtleUMN9CALo0=;
 b=dfmfRH2tD53R6agIgaHheoZiXYkM9T6Uxbkj+l/Nl1FdMN3MGGItYp9TPzeMMI+HHmSVvmb8x1jGRniN0S1b7muH+mu+wH9dfTUsEUpG5qK6Oz7ug4Wqt/ptcXOj7yQUdBpCiKk/NTP2V7ITgg+FfrBHo7g78Qtnkwrig27y7MQpNRUd3mNbA/ylNhyea05ef+PJZkJ+7lQxDnz7sQbSDwL6BlWBY9URg+ruMq9uppPNXsfemsIollC88hlgDtcgsE/k99kZRdXAcoIk/xsoPfe+VC3N//jkGy/NDcIb47C74Q2VN3aTCyp0czD2JOK073WxLYzrZykqBUSQgHb1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEoLPbN6YLqz89K0Hj0p9p7mRtRqxKbtleUMN9CALo0=;
 b=bSd/Zjx9Xo9GBHsZkm/2SmyqrfgqfKpLNH5ynrALbO3dn+vz7V7fkEUfJIsiZ2BEacryqV95bxwOsWSc7q9F3Yfb4ZsOXwtlga/DdW2IUhizXW3wxbFfVJR62yiM6wTEUmi0b2XTFQyPy8V+ehb5c0Y+mqQO6VLKByDNTksVghs=
Received: from CY1PR03CA0024.namprd03.prod.outlook.com (2603:10b6:600::34) by
 CO2PR03MB2390.namprd03.prod.outlook.com (2603:10b6:102:16::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 09:03:53 +0000
Received: from CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by CY1PR03CA0024.outlook.office365.com
 (2603:10b6:600::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.16 via Frontend
 Transport; Mon, 12 Aug 2019 09:03:52 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT031.mail.protection.outlook.com (10.152.75.180) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Mon, 12 Aug 2019 09:03:51 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x7C93pr3009059
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 12 Aug 2019 02:03:51 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 12 Aug 2019 05:03:50 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 3/4] staging: iio: adc: ad7192: Add system calibration support
Date:   Mon, 12 Aug 2019 12:03:40 +0300
Message-ID: <20190812090341.27183-3-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190812090341.27183-1-mircea.caprioru@analog.com>
References: <20190812090341.27183-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(189003)(199004)(70206006)(8936002)(14444005)(50226002)(16586007)(4326008)(478600001)(8676002)(70586007)(107886003)(246002)(54906003)(106002)(36756003)(316002)(47776003)(305945005)(486006)(126002)(476003)(2616005)(11346002)(426003)(336012)(446003)(2351001)(186003)(26005)(76176011)(44832011)(51416003)(86362001)(7696005)(5660300002)(2906002)(48376002)(6916009)(50466002)(1076003)(356004)(6666004)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2390;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d95977d5-642e-4363-1bc6-08d71f03ff2d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:CO2PR03MB2390;
X-MS-TrafficTypeDiagnostic: CO2PR03MB2390:
X-Microsoft-Antispam-PRVS: <CO2PR03MB239014AD2EB994F297A31B5A81D30@CO2PR03MB2390.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 012792EC17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: YPgLr/2JrG6xVmENDOtX9QC5p+pNeYXO9O7P/q1jbEQu8z7WCOzkrJGxUIbwRJq6h02C5IveLZ4lvquNpZVnpBPGJXZHICcBY/es/n7TCCp+H6tXG+45YIWk74xHaxeFq8ABQ53MBOX+N+8Gzf4KM8rivqi2hFt7CsFHA8V4JGpQh5x0ZAtN0Viee8JW3VgLk7YrtCwjsiz6IN+Lvc6YaPlYlV2Xh+Jt6jdO7M9QznsQlFvxRyYFY1RXjNGXGklXjdkRK2/Q9pobDpliwpIxaNRKifk49Zpua5/nzE4ISuG6swV8rKv39UgNgEKqaDs2swkLGSRwwAvPNEMILoQAAhzu5KUsS8tP1Bf3TaNxGZodUAdgKpPx3PZie9H6VVnLhfM4kMagZwgl8qTQatHK5GhcGi8i5OtMQ2/MLPCNb90=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2019 09:03:51.7970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d95977d5-642e-4363-1bc6-08d71f03ff2d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2390
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120102
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

