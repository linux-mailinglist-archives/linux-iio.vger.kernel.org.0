Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6A9277B10
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 23:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIXVcW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 17:32:22 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:1216 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725208AbgIXVcW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 17:32:22 -0400
X-Greylist: delayed 5960 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 17:32:21 EDT
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08OJhBT1015042;
        Thu, 24 Sep 2020 14:52:42 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-00010702.pphosted.com with ESMTP id 33ne10qxqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 14:52:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfvLD9Cx/eKrWud6xga2swdrdyaFVoWz/VSwmE1ThVmycsYRpQBtrdLr4zikunKefH3yLSTZFndq9GTflheqdvQI4+JwoMu7eEZsp4L7yGzSvFJ92bZ4W/yUzSwhAuenKqnoxg+hU/aZmT/C++rKKwPYDfb/tY1Mehlm1Kz8K5L9n1Y2N4UpAy7QG2zJ4gq0n6lfv3NCPaR8zUQrO6klk5i3CNlJLhAzaJLdS+islyuPyozYyD4+CAt4H0WJpU5RzMP+JW+dTqF5NYU708N6pM+dn6J5Cv/pgw3RF8oMII8Jo+4ctXznmJFDwhaLtwkp3hxtSa7BvgPr3az6EyzcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cTgkeKp3f62t9ovkxen92HLHSwPALUXdGmuYTpKzaY=;
 b=g0jzfnW+xuUliqJ+PqwGcbTRbJoaLlrfaCl5oQkt8AyiEdXyArvqnZQbbH+J4q4aRaPwuIEVIQ3S5mkAHDXtdsJxUq0uga640yNv21mbgmtX4ZRozWXqSlC4LiTC5i1rjBoncA6Lk0+32Xq5l1+Lf3qzq0Ta6/wAsdGmtrpb6/KjCLvVdLMYpY1eeNR6ApvfFRyAFlg3ap1WZRneex2U6sKDKo2LfvV7l4xVL7PWIXGLDAGHiQqDUHwAzHXR5bIYa/oApurlUeXuTOlN+m4YCKPOSkSr1Q01C8Flg9Yhn67E/hdvzbpwru3RE+nDQKXzhflhW0phcZ6wCTULuOOhag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cTgkeKp3f62t9ovkxen92HLHSwPALUXdGmuYTpKzaY=;
 b=lIJ4dNaDNdLezPaGiSwx4OKKC9KDpneUCQ1piogA4Drkbs+yTzNnesuTn99hYlBkMwBIcUoRXahlqU/0roLqdnGkjny+EdUR1w2Oosy2cmNrA9crwMtx4oCQMqF+siB4rBZW9y89TTe22+STFwrpHoSwiqxJiFl4LrDE83JNeGA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3648.namprd04.prod.outlook.com
 (2603:10b6:803:46::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.24; Thu, 24 Sep
 2020 19:52:32 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3391.023; Thu, 24 Sep 2020
 19:52:32 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 1/3] iio: dac: ad5686: add support for AD5338R
Date:   Thu, 24 Sep 2020 14:52:12 -0500
Message-Id: <20200924195215.49443-1-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR10CA0016.namprd10.prod.outlook.com (2603:10b6:4:2::26)
 To SN4PR0401MB3646.namprd04.prod.outlook.com (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xaphan.natinst.com (2605:a601:ab6f:2000:2739:a39e:9b12:ab20) by DM5PR10CA0016.namprd10.prod.outlook.com (2603:10b6:4:2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 19:52:31 +0000
X-Mailer: git-send-email 2.25.4
X-Originating-IP: [2605:a601:ab6f:2000:2739:a39e:9b12:ab20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25781db1-88e4-4b7e-907b-08d860c36023
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3648:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR0401MB3648E1570DD54119854DAF8487390@SN4PR0401MB3648.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6gjCEa9/bk286WMWmURmjmZHjSXyiUvDyCGstLTtyzFkh/4hU0tZXaZscV6kNeaX/qMJYHCcUCFFK2RjobEIsY0KdDciLz0KXK74hq87RGIs//n4bIJLKXawEuGEw2WLWKrMcbg3v/ZZPwpYlWoXI6zoQS0HHD53swOTuc5rBfq9Ecb9YOAIDhh5MDn+rUt3wryykta0VJvq0HFoNZwA8PtXO7gUQP2m429KTUcIftunaaY2VBUTnk9xMTRyXYn+SImCblZrNNQOwez9YikS33FJYEKmTtU5DBL+trylZSdS4qFHcgK6CW2L3RuO7SRLDIlcZFZyy2dCcK78v/4kwxpjrDI6eV1LrskGTfc2vjJBsARSpeCMLV1yNh0et0iH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(366004)(39860400002)(346002)(186003)(8676002)(8936002)(1076003)(5660300002)(44832011)(4326008)(316002)(6512007)(66476007)(66946007)(6486002)(66556008)(6666004)(110136005)(478600001)(2906002)(16526019)(2616005)(86362001)(6506007)(52116002)(83380400001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8FHkm1/CgqM9PSBKDGUo1JNrjwC3rTAsA0VHpcENZQpaLIjl1Xee3yXBqA5XJeGvg5j6zrnOusLZ3C0SQdfsC0K31LOpgEsvdbCxiTOfJ5OlGuQajLYNr0r8g9Y94k93Wt4kxcj/5oxg2snIPwOxyDd3V74+XTu2BpEav+/at45Q2I5lfe3TT7Rph2ib7F2o8+8BEJEvsSsFC3vqlNmcDkQcP5rJ1Gvk/IsMUWVwjGiHSO0yO2lIOLgWpHEda+eAuceYRvPqimtgdPLQt2czSxk7zr4pF8LKum8tDX39WoYnBa2jAXUG9fhCHXkzl9xgG0Ki6JVTJqfllcQTtZGFFLqf5sGF8jLp7AtcbTWOHnmyJXjISuvaBik+1mrSmfYoZoeZdd5qtMPz21wuRLpWoCSZMnn3iR63X2MJGqQz7Bo/e9uf9jB61Ah0G92wWiXjLj2mnC2m9R/z3eDAC4OzZZtm/4zh7Mcby9gluC+Ls3bGE55JJMnF4+SwK51WGkBNvlTaEsCGrAx+yNNZGSrgo611i0zYa11FD3LD/K9ni50djZU/aCP11IUf3zGSsOPABH9rGwfOWfwfiqJZB3Sd3uCM5pKZmJ+rWeGBePTgtT4mVjWdXsS3mJxkChDBSJ1ou/xPLEqTbYASVGBICEkCwphjHqJl4ZsbJi7Fi6ibEDO9tzJKxx3mNj6WLwsRELB2M5lIh+iWIbN7CUlksw0opQ==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25781db1-88e4-4b7e-907b-08d860c36023
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:52:32.3206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG/tm1Xzp5CSuvuBVOQ9v7YzazlHNBLOUeWcHWW//P27y+ma9chu7KNqLcoyBupnBkRmTFB8K6DRKctuzAbBLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3648
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_14:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 phishscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009240143
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
2.25.4

