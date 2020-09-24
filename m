Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CDE277B23
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 23:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIXVgV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 17:36:21 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:22100 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725208AbgIXVgK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 17:36:10 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08OJiOD7028609;
        Thu, 24 Sep 2020 14:52:44 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-00010702.pphosted.com with ESMTP id 33nfgtqwcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 14:52:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWovgm8ZjK4LAaVGtG0Sotu5YuuNKITtH8UJso7OIX/HH87xe6U4t9jV3MgOkgoWsIU8P0/grOluoUvCo8O9xHOPQ0j6/f5h6Dw1A9q/PhqzGDtIM4hu6r6q6cZ75Lfn/KFCh4aFkWRBmpD335oZfSFN/HhbjyHxYOEaGFGHlSq00cummJADGxcRHDOzSErgU5rQEh15/eDK+bfV+R31i0BqKONJvhWuYz1RBT+KnEd4/vDR4MxmO6/8WLAhdKMF1TyYrIJGbHpxfNUaTZQ7pWOzeL6ImyDG8N7wtbrPJS3xJTxiK46yS2gkQPRiU7J2I0oUL4aqoGr0mGYCBb6Sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV0bTw73f024KkIdmE2ioCdcHT+Y7V7myNJybAH10lU=;
 b=PLuttCqL2/rQuXoJ5TO4nptO6KoeMOX7RquW4qGUk7hM6DxCX0rZpgVyNvJekRhrSQBYf6xmVzOdWNoom1KWxYA9JjUgBTVyPqaZGricHvXvz+2+8b7Oiv/mVa0GEEn6bg9Yi6TxAZNBL2Rq41o0Gf4ilqhFqzwWQzHXKN+To2KvdTMhZf3v8ls70egF+f4gEKKy2wXoJCbHKoy6RlzDINtpPaZZUPHiQ32fhFV9vTXYx7cJpV6Yh69ipJVCL1L06PKoc8M08cakFB6wSsxGHsfoosRiRvU7nHdk2uRdT/DlR7RbPIyo2bcaEfOV2gV2RjAFA/awq6DmBLSepD/b7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV0bTw73f024KkIdmE2ioCdcHT+Y7V7myNJybAH10lU=;
 b=j7hfbRBQwIDm+2qtKoLl6hDW/iU3d9BgVE7tJZ2NHjqKN0YNj+LwesOtK6W+U2JJ8XMaC48Og/Fh0f1JBl5UKaO0J4yoh7i3d800/ggwODfwtJrq9Lz5YF0oWp00SrfRSDjaaeR1kRUXGjZU7HvcU2d6AQSx2b9Oj4XyDDDBSWg=
Authentication-Results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3648.namprd04.prod.outlook.com
 (2603:10b6:803:46::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.24; Thu, 24 Sep
 2020 19:52:35 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3391.023; Thu, 24 Sep 2020
 19:52:35 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Michael Auchter <michael.auchter@ni.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] iio: dac: ad5686: add of_match_table
Date:   Thu, 24 Sep 2020 14:52:13 -0500
Message-Id: <20200924195215.49443-2-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200924195215.49443-1-michael.auchter@ni.com>
References: <20200924195215.49443-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR10CA0016.namprd10.prod.outlook.com (2603:10b6:4:2::26)
 To SN4PR0401MB3646.namprd04.prod.outlook.com (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xaphan.natinst.com (2605:a601:ab6f:2000:2739:a39e:9b12:ab20) by DM5PR10CA0016.namprd10.prod.outlook.com (2603:10b6:4:2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 19:52:34 +0000
X-Mailer: git-send-email 2.25.4
X-Originating-IP: [2605:a601:ab6f:2000:2739:a39e:9b12:ab20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a6fedcb-9ead-4416-ff7c-08d860c36206
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3648:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR0401MB3648F8DF36D4D7C2350FA00B87390@SN4PR0401MB3648.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCAvnKAJTOyrw9P4pnhfNDYDehRVXKAmRMln5qitscYJkmL/9DGOaEqx8l3y3lVCc6ZlW1bdVo1FqSbHktHKvHLanuODJSo1/B0Hx1OOdHebX7WvREyKmWzzf3lKEVHwycm5/QAY/WRPKD7Lm4PQpyBGDXocotz5bFinsLercsxESgl+Ec2homgIIEDjZO+5gE8LrhJA8qQEwvgw2zi2sL91nI1qL704H6dGjCULLFpgXsmvt19pe4L1akW2EU7qdeTZB5/+8E2Kea3Y3Di6VgmxkOqF10INNiahaGr1DtzLS2dgizWw5FPIZlH1A66dQyp7llDxbqqxbPXJH8z7HZ+BHA2Yg8V8Uwcv8wOuAot4tqf/JJn1Ngif8V00GiXD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(366004)(39860400002)(346002)(186003)(8676002)(8936002)(1076003)(5660300002)(44832011)(4326008)(316002)(6512007)(66476007)(66946007)(6486002)(66556008)(6666004)(110136005)(478600001)(2906002)(16526019)(2616005)(86362001)(6506007)(52116002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3UVBEUefJnzkZkLfW8FnyqpE6JUcD8FbZN8fyqeEbgJ0EUakxn24qw98LdBnoHduCGPOo7IkOepq1A2qKOf9hhDXMvueYny/IAHFT0vjzRgRN4Hs2x8Velii7HxyU37bDEaQB0zyTu0am0ErXm+J1kzbwbH8OysLdcmDnrOHw28Vztqs4S4N+zfind9g05Zq8rQy95kGKiX8il3lHXPWzvUMWCZHkz+050+UwXmYrXi6x/iz67fl0/hOrbJY0eohmYgAin4aNcIiR+lPtER2d1weknj/hXY/ZaPEmsnugpOXzetNdGTOwD6CzWu4EiWIwPdZ7Ez0yf9gw7SyYf0rizLormp70SHkEM/rdRtE956N1WteF6802gdAPTjJWByM1X6hSyEO2I1Q7J9rlfML8dPVFWqAm9GJwh/SI2JP45ULErj0JKUa1/hj8/4qlQhNFSAQado4a6vl2uZkYSrmoc1SLiilwAFVGbqG2Yg5GTpCWoQDhOESShsIQQdFu+S0IZcakNFO5YHIEVGlLZxLXBS+W5EyBpaeuNHb7kUPTWMC4LGIzOhQssAaMI+LhfaRpSK1fp5tgO1AqyLIXw/Ym6ktkvI0yXvy3mqtPuRkUG/Gu3giDOvvGOOEI+pEcu3ZoniMeSw1pi1One/IwzKbCEUa1WicqTtrzbuETauuCmHDyFCeaUT/ChdoEvATPFn4iyb8/klxmD1N0KNRWzwWlg==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6fedcb-9ead-4416-ff7c-08d860c36206
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:52:35.5538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IW0ct2JpKOmJkGn2C7GcudXFi6J5fhuZiZlpzbZ2atlpNgc2BgI7uc+JovlfClOSH8AtQYYs3CIWZ/2sr3Q8yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3648
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_14:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240143
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add of_match_table to this driver, so devices can be probed based on
device tree contents.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
Changes since v1:
- Drop of_match_ptr() use

 drivers/iio/dac/ad5696-i2c.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 89e7b063b7bb..a39eda7c02d2 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -88,9 +88,28 @@ static const struct i2c_device_id ad5686_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ad5686_i2c_id);
 
+static const struct of_device_id ad5686_of_match[] = {
+	{ .compatible = "adi,ad5311r" },
+	{ .compatible = "adi,ad5338r" },
+	{ .compatible = "adi,ad5671r" },
+	{ .compatible = "adi,ad5675r" },
+	{ .compatible = "adi,ad5691r" },
+	{ .compatible = "adi,ad5692r" },
+	{ .compatible = "adi,ad5693" },
+	{ .compatible = "adi,ad5693r" },
+	{ .compatible = "adi,ad5694" },
+	{ .compatible = "adi,ad5694r" },
+	{ .compatible = "adi,ad5695r" },
+	{ .compatible = "adi,ad5696" },
+	{ .compatible = "adi,ad5696r" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad5686_of_match);
+
 static struct i2c_driver ad5686_i2c_driver = {
 	.driver = {
 		.name = "ad5696",
+		.of_match_table = ad5686_of_match,
 	},
 	.probe = ad5686_i2c_probe,
 	.remove = ad5686_i2c_remove,
-- 
2.25.4

