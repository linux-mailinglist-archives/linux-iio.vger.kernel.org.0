Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9AA1278D3
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2019 11:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLTKHp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Dec 2019 05:07:45 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4642 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727235AbfLTKHo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Dec 2019 05:07:44 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBKA74vs002717;
        Fri, 20 Dec 2019 05:07:41 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00128a01.pphosted.com with ESMTP id 2x0b85jtub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Dec 2019 05:07:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWFm1CASuh6gmzrny8ZG/qLMYyY0MTRzwbf1WK//C4y7MIMSOsjF2TathJVkjqZrMrxsA19JDLNf4TsCpDNnFNk1nDjJ3fRn79g9Rp3nUvid4rO7SgDLL6s+HTuhxBV7k4AC3Owz693pieBdWc+/GEdrwJHaiKGUw7TAdUoK11dFSdbOg91tHkVEXlFraCD5PMM/Wo54miqAiu0G9MEw1HlYomS8Hil6WS6gCBqM8P/F/wieMAaWWyIT2MeIOamwo2tyjzSHlEk6CUMWXj+vUIi5gGtImCrE89KDX+uKmRkkPXg8K0Jgi8U19G7Lah83OzsJllv+a/Z3wt/tBEpKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5cbR+puhsgRINa+NErcKYosDNK4IaY0vtxRPGVwDl4=;
 b=LIlDxzUkKh7sutU94s8z/9M7wXj33IG422I95k0pl1CUDXU/mMLda7AzOaPYEDw82AUomV2ip2cE0AiwAj1KN/APNbs5DL9i3lXtRevk4mb4jGnaZYShcGZv8/m9Bsp9S5RkYpVdyd156M4qko86Br8ylB/L56L3Qk0yZU/3HNzbBiPI314DDiEZd6Yp9Ae9lmmSKEz6flMFlzZMO2+C3mI7YhgVd1Yi0aCAgnYkADjOfNBbLXqyvWKEnN49ZsxPhoarHhnEaJbFIrEK9EXeWAlqw6k5NW2rOhBLVz+sMhe1cOk3U59Yrgw/giNN4ngS8xBYdkxtpZeBTKt5RbsCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5cbR+puhsgRINa+NErcKYosDNK4IaY0vtxRPGVwDl4=;
 b=ndZZl735JkQ8lEIw8RPRloiOKnVcVCPZzz+1SORbqZ6HfFDMAm2hjrJxBSrXEkQVlKzeQNHZE0ED053aarhvrpn1uOmDQkHYHagiUzgXBcSpgZ0D0M797xiHowdM9gvv6luKrPLXK80o/XuHT8phI+x5v3e7jlkpoDtx3DLDVDg=
Received: from BN6PR03CA0074.namprd03.prod.outlook.com (2603:10b6:405:6f::12)
 by CO2PR03MB2325.namprd03.prod.outlook.com (2603:10b6:102:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.16; Fri, 20 Dec
 2019 10:07:40 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BN6PR03CA0074.outlook.office365.com
 (2603:10b6:405:6f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Fri, 20 Dec 2019 10:07:39 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Fri, 20 Dec 2019 10:07:39 +0000
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBKA7cXM023754
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 20 Dec 2019 02:07:38 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 20 Dec
 2019 05:07:37 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 20 Dec 2019 05:07:37 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBKA7YvL027824;
        Fri, 20 Dec 2019 05:07:34 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH] iio: adc: ad7124: Fix DT channel configuration
Date:   Fri, 20 Dec 2019 12:07:19 +0200
Message-ID: <20191220100719.15171-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(7696005)(44832011)(356004)(6666004)(336012)(110136005)(36756003)(26005)(426003)(186003)(54906003)(316002)(1076003)(246002)(8676002)(8936002)(478600001)(2906002)(4326008)(7636002)(86362001)(5660300002)(107886003)(70206006)(70586007)(2616005)(334744003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2325;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a30da4b2-34c5-4a17-0817-08d78534721a
X-MS-TrafficTypeDiagnostic: CO2PR03MB2325:
X-Microsoft-Antispam-PRVS: <CO2PR03MB23252165D07A354FEE0AD28B902D0@CO2PR03MB2325.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 025796F161
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rG7eQ30JwVTElxJKNuW1dx2Zo2gNwMpmFJgs8R1PozfnobkoWz+m5XhaCJ0Hla03+3Zmu3SzoD1YVMbL2hd9BoVdtzlvcLkp47dAxG0xJ+PYVBsTO+iWz8KTwmdfjg/6o8Wt6Qwv9k5azfXjXCWjA5v/Vke9AVSSBSOD6HZVs7HQ2nT3qQDYtUa7qO9nFAfno2aCSi442JoS9Rtfj4LN1/lu1sET3Y/klThN2t+rsVVNhkAQhITwfQt52WPagjKZiKJavVELHJBLpydIuiX++3dUc9lcsUfKoTp9YKML6bh6ykxnR61bMWDWFqX0jQkgkBjsa7Hwg05f7lk9iXEi8d3OYeFG91RDOrFvbGtuEzhggax3NPoVstTQs/Nhx88aQjrMG7TyLioYBNbrEbHQB5Yh9HsaFLp5lcgsOaLnBdUBVsx+MVtmEPsUk11binGHFrVv8XUGtN4qygZiVK+4lP3a92yDj7V1+GMKNm8MX5o04t8iVHxNMTJelxbKJu7/
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 10:07:39.4275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a30da4b2-34c5-4a17-0817-08d78534721a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2325
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_01:2019-12-17,2019-12-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912200082
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch fixes device tree channel configuration.

ad7124 driver reads channels configuration from the device tree.
It expects to find channel specifications as child nodes.
Before this patch ad7124 driver assumed that the child nodes are parsed
by for_each_available_child_of_node in the order 0,1,2,3...

This is wrong and the real order of the children can be seen by running:
dtc -I fs /sys/firmware/devicetree/base on the machine.

For example, running this on an rpi 3B+ yields the real
children order: 4,2,0,7,5,3,1,6

Before this patch the driver assigned the channel configuration
like this:
        - 0 <- 4
        - 1 <- 2
        - 2 <- 0
        ........
For example, the symptoms can be observed by connecting the 4th channel
to a 1V tension and then reading the in_voltage0-voltage19_raw sysfs
(multiplied of course by the scale) one would see that channel 0
measures 1V and channel 4 measures only noise.

Now the driver uses the reg property of each child in order to
correctly identify to which channel the parsed configuration
belongs to.

Fixes b3af341bbd966: ("iio: adc: Add ad7124 support")
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7124.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index e24d141d3c74..ed37d2b2b3b3 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -495,13 +495,11 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 		st->channel_config[channel].buf_negative =
 			of_property_read_bool(child, "adi,buffered-negative");
 
-		*chan = ad7124_channel_template;
-		chan->address = channel;
-		chan->scan_index = channel;
-		chan->channel = ain[0];
-		chan->channel2 = ain[1];
-
-		chan++;
+		chan[channel] = ad7124_channel_template;
+		chan[channel].address = channel;
+		chan[channel].scan_index = channel;
+		chan[channel].channel = ain[0];
+		chan[channel].channel2 = ain[1];
 	}
 
 	return 0;
-- 
2.20.1

