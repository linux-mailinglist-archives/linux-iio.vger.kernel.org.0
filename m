Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F8DA575B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2019 15:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfIBNJm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Sep 2019 09:09:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62904 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729844AbfIBNJl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Sep 2019 09:09:41 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82D9K23025679;
        Mon, 2 Sep 2019 09:09:20 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2050.outbound.protection.outlook.com [104.47.48.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uqjrab78s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 09:09:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKuCoyo0mCQO5b0Aas2zxB/KJ//33g0Sqy7ICcCvBw4I8cwSMYadsEs3TPMoEdDp6ThgOllNlj1NomubHx9d3w+s6zRN69o41l9naAKbYR9RRvg+I3Np0KdqixflGxk/gJfqa20n2qmAlU/ioWmAD3fmdnXauCywi9eJRkyginGVsYwPnppRZEb1gWrWzNQG/xWUFMOT6ZzhUxWZnhF9UEu39T3jGHyYZ4Ij5n2DxU++mX57n1g67f+/Cp3C2MJ6S1+X0nUd/C/PdZsOYty2lzT/ds/WPGl2uMpzhP3oIIeH8vzXqh+Q6XT7cD1snFJAXcVeTnfN1YzIAKeO4g+lkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6skLiWlEVitDs4Ban8ZjA0Xpm3/tfnOe/pHQRgSkZDA=;
 b=XVWogF0n+4TDfuqqNse/j+fMtwSNVvzUzWefP9nwkpFBZk0UQkdDIKNzoZRQURcdq0jmyaiT+BGpW4fLmZGcnO22IY6Jrh8jwOfTmU+At0LTYFAhef4xPq1QAsF3tSAYQXq3HFba+RqcnJHN7a2e5ICcCTjuOjNI29nx8P6gJ/9dKE6SEl1eEterHZUA9V4Bii3ZIneNLBoEfAta5T9DRw/XjHn0tm7gPZ8UXxHCTmt/UKHPZiT1tC+L3L81pOh3ZoUdxifaodayzUa/Gwuj2iI7cbo3wIfjizsehQBVnRIb8WVPjcJ/23c8eRnQgeXMulsDZ1MxzPvie9BcRALqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6skLiWlEVitDs4Ban8ZjA0Xpm3/tfnOe/pHQRgSkZDA=;
 b=zDiYdW6/gNtBhrCwQOFi6TlkwC/rPuZBljW6c5tD1PI2nHMIylDBeo5BRcF47t3O/e/foMa/BndXYG6FqtmvgFMmd7HYDVV2eIVzK9ZHHiCGz3oZ3o1VYGgS1zB9gejpXUWRWsgpJIBi5mzg/M6Ki5Qi6/PQUqyvnTnsJMBNlcs=
Received: from DM5PR03CA0057.namprd03.prod.outlook.com (2603:10b6:4:3b::46) by
 MN2PR03MB4816.namprd03.prod.outlook.com (2603:10b6:208:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.20; Mon, 2 Sep
 2019 13:08:44 +0000
Received: from BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by DM5PR03CA0057.outlook.office365.com
 (2603:10b6:4:3b::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.16 via Frontend
 Transport; Mon, 2 Sep 2019 13:08:43 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT019.mail.protection.outlook.com (10.152.77.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2220.16
 via Frontend Transport; Mon, 2 Sep 2019 13:08:43 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x82D8hGS027158
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 2 Sep 2019 06:08:43 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.107) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 2 Sep 2019 09:08:42 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V4 3/4] staging: iio: adc: ad7192: Add system calibration support
Date:   Mon, 2 Sep 2019 16:08:30 +0300
Message-ID: <20190902130831.23057-3-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190902130831.23057-1-mircea.caprioru@analog.com>
References: <20190902130831.23057-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(2980300002)(199004)(189003)(54534003)(47776003)(305945005)(126002)(2616005)(70586007)(44832011)(246002)(486006)(476003)(1076003)(51416003)(7696005)(36756003)(5660300002)(76176011)(70206006)(336012)(86362001)(50226002)(426003)(186003)(4326008)(54906003)(7636002)(26005)(446003)(2906002)(316002)(356004)(6666004)(16586007)(50466002)(8936002)(8676002)(48376002)(478600001)(107886003)(106002)(6916009)(14444005)(11346002)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4816;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbfddf1b-11e0-48c2-530c-08d72fa6ae8f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:MN2PR03MB4816;
X-MS-TrafficTypeDiagnostic: MN2PR03MB4816:
X-Microsoft-Antispam-PRVS: <MN2PR03MB48169BB749F4DAD4BA8260EA81BE0@MN2PR03MB4816.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01480965DA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: fgxPbBxGfZ91luHNBreh65Q2ihFMzWcTHV3C58kaOXz74n6adekf5sK2HE14koMvsd5jsOhAW9X46NcOcZyv3x3n+Qfpxrk5CjmczN5dK/KDeo4g0YQUTwgvl/A7mNhYa/aouSrjkXkxzUrFfFzTZN5YVlYfdhpn4XKXvisy+0QWMBmsaGFKx5ymUDGuJ+iKAI7MI8b7YdzUrXkCSMf4XgcoTWyqOn7Ar87w5VmiRF12Cs9QkdMzs8WmTXmTpnpB875pLDgIMm6NV5BPWei7Nf90yD9/zMOe4Gc8KhNV0cN5S8EOZvm0IqQAS7cPB//7mrIjb+epg4fcJcPnFWwJy3evTgp4VIBW4rVFa1lmug+VKqkXV1H/PAyb34AgnBqiJtCi92JsYl9GsmqCeLzw/eRhCNb8MFvhmmj0bWBOiwI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2019 13:08:43.4708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfddf1b-11e0-48c2-530c-08d72fa6ae8f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4816
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_04:2019-08-29,2019-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0 suspectscore=1
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909020148
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

Changelog V3:
- no changes here

Changelog V4:
- add an attribute to start the system calibration
- the mode attribute does not trigger the calibration
- added ABI documentation

 .../ABI/testing/sysfs-bus-iio-adc-ad7192      | 24 ++++++
 drivers/staging/iio/adc/ad7192.c              | 79 ++++++++++++++++++-
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
index 74a2873045bf..7627d3be08f5 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
@@ -13,3 +13,27 @@ Description:
 		need to minimize the system current consumption.
 		Reading gives the state of the bridge switch.
 		Writing '1' enables the bridge switch.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Initiates the system calibration procedure. This is done on a
+		single channel at a time. Write '1' to start the calibration.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns a list with the possible calibration modes.
+		There are two available options:
+		"zero_scale" - calibrate to zero scale
+		"full_scale" - calibrate to full scale
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Sets up the calibration mode used in the system calibration
+		procedure. Reading returns the current calibration mode.
+		Writing sets the system calibration mode.
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index d58ce08f3693..c5106d98c9b3 100644
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
@@ -169,10 +174,80 @@ struct ad7192_state {
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
+
+	st->syscalib_mode[chan->channel] = mode;
+
+	return 0;
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
+static ssize_t ad7192_write_syscalib(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     const char *buf, size_t len)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+	bool sys_calib;
+	int ret, temp;
+
+	ret = strtobool(buf, &sys_calib);
+	if (ret)
+		return ret;
+
+	temp = st->syscalib_mode[chan->channel];
+	if (sys_calib) {
+		if (temp == AD7192_SYSCALIB_ZERO_SCALE)
+			ret = ad_sd_calibrate(&st->sd, AD7192_MODE_CAL_SYS_ZERO,
+					      chan->address);
+		else
+			ret = ad_sd_calibrate(&st->sd, AD7192_MODE_CAL_SYS_FULL,
+					      chan->address);
+	}
+
+	return ret ? ret : len;
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
+	{
+		.name = "sys_calibration",
+		.write = ad7192_write_syscalib,
+		.shared = IIO_SEPARATE,
+	},
+	IIO_ENUM("sys_calibration_mode", IIO_SEPARATE,
+		 &ad7192_syscalib_mode_enum),
+	IIO_ENUM_AVAILABLE("sys_calibration_mode", &ad7192_syscalib_mode_enum),
+	{}
+};
+
 static struct ad7192_state *ad_sigma_delta_to_ad7192(struct ad_sigma_delta *sd)
 {
 	return container_of(sd, struct ad7192_state, sd);
@@ -769,9 +844,11 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
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

