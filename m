Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2FC397061
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jun 2021 11:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhFAJbE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Jun 2021 05:31:04 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:62046 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233237AbhFAJbD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Jun 2021 05:31:03 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1519T0c3004102;
        Tue, 1 Jun 2021 02:29:00 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-0064b401.pphosted.com with ESMTP id 38w5p40btp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 02:29:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRTXxSoBdF739jOe1ETNkqMTkJEdVUexhW8Sl1XMhHfYtJ4tDMBWuiLAnoV+oEZoRQxGjmifFfl6mUojAzPGfgykVGNt4t3WukWAxaeSpK6RpNhqCaM4/8esrC7unNp+huEKchofi31kszxWUMC/KPMjBGC8gvM8UEw8L5Tv8e77/zNHeY/VHAIWUvf+R/LSAj5JQVfR35a2aRyHM1sjvOiorHqYSwp/XpMjBNyycQ7I39X/Vbgfgui+hBbnqixsPu6r9a0pDNJaxRKQ1uZaCVeUvjavRd9+Z2XWfl9KpfxcfTTPKWcIsSfuIsrPdEnqxdyoardFyoWwAbfBF8OlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uCop9Fd9R6kU3rj497oKXbjQnWPD2WS2iOncyfNSNo=;
 b=OsbeV0pkFfbQMoi8pZrItXwfoxy3gcG7x8BuAKVQqToKly9L9nnu0y0op38mfR5yLUB318AVw7xEj6GLIWztxcYn6CkMYlHOoOUCTKwDT1VbFqhxktmv801CG+FNbHXgPB8a+G4lRSvSHhfzd1sKsk/Jt1SsmEzUXCTYiA5c9E7zMn2sLRATRLD/k+FaZe/68GbZWFZpwHbuj5P3ND2BMNHVrfBnRyxNruREdXyyJy07u++gr/FKlyx+fVP7x7SIiuUCsHgJUw2uGc3OiEz0aduCsyTKIYLp5LHJeyfuixwqDY42WjrQBPEvZ3NGh7xcKFd+Wnag1E6CQS4ekv6PZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uCop9Fd9R6kU3rj497oKXbjQnWPD2WS2iOncyfNSNo=;
 b=FrQKjsyh3CE3towZNFXcORtq1R53X+DvsQKuJEEU6eYb7sB1xnsPySFDYgSygVm4Jj+J9QwbMNVbkHMNviHVL6jyxvLIGfdYryTek0DVOaOuI7J9g1UhHsUSSk+bwp1pqNbnH/CS3xw2xPix6pCGIlmu7EZNhS5ouyLHQNRdel0=
Authentication-Results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=windriver.com;
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB4805.namprd11.prod.outlook.com (2603:10b6:510:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 09:28:57 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49%9]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 09:28:57 +0000
From:   Meng.Li@windriver.com
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        pmeerw@pmeerw.net, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        meng.li@windriver.com
Subject: [PATCH] driver: adc: ltc2497: return directly after reading the adc conversion value
Date:   Tue,  1 Jun 2021 17:28:05 +0800
Message-Id: <20210601092805.18385-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0302CA0023.apcprd03.prod.outlook.com
 (2603:1096:202::33) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HK2PR0302CA0023.apcprd03.prod.outlook.com (2603:1096:202::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.11 via Frontend Transport; Tue, 1 Jun 2021 09:28:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cecaae6e-946d-4547-a35e-08d924dfae2c
X-MS-TrafficTypeDiagnostic: PH0PR11MB4805:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB4805DD4EDE401D77C9FC10A4F13E9@PH0PR11MB4805.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+wK6WhByoZhXgqUTJAbgJxP2cL9uxZ2W9tG1f2ZeN/iVlUaq5HYIld5H1/zvJpE8mBRz8G8PFKx6O3Xmb8ZtpD3ZDuXZV354c9etTOq6cFXIqeWyteKaPWDZJA6Uf0rd33GzQ82txWvYs5pYV9p1h5L1mYcNSuYdant+S3PpAlJWXbiK6uZUUNHpIfCIyVwFzzlfuZjhx4zeZg18Jtc5hrLLlS9UY1cowwRYa2SJhzKoKlP///oRrz1P5I4LRMuxoZZgFO6He9ZxpVCO4K5i3xqqTZVJiLe73nCqc3yDu5URigzD6QhP/EuAqe2fu8IWm2nuKIa0hvJFEYxOgaP9/8UxyPO3LPnWeQaSKxup3Exl6eRGt2BS6MBV/s4UykHCrnWuNS5y4kUTfVNt8juTnu3J3KQa61teLEXn9NmCtf/zrcyhCjjX6NWk9/5fjUGqn13m6m1hZl+KPMn4d2GGGSEwGhWyJt9GQYXvUyjsPKLHlHIaHfsGL6Y2b1CR69RVYZLHph6As+7Ucfrh7R8uRQCa2rQ7mPRcv5MBM4tu/tA5SBkWkwECjDHOIrirLlGmH+r+LCqi9Bj6rlDW3HgTS51Orj7ZBxoxFw+cBqMKBStBN5xK7DV2Gvj4GvaKEar23eJ1QV9F/43OxKwVPCr8lCwBrBa7eVm0hdUwJpu1mc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(136003)(366004)(376002)(16526019)(83380400001)(36756003)(5660300002)(186003)(26005)(107886003)(38350700002)(52116002)(9686003)(38100700002)(66556008)(2906002)(66476007)(66946007)(8936002)(6486002)(6512007)(4326008)(6666004)(6506007)(1076003)(8676002)(86362001)(316002)(956004)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tMKMbqQn0/JusCQK4L9PUy8GWwOubyxXmdtLL1TtLnRT2qTP0fkilbhJi+iQ?=
 =?us-ascii?Q?mk8SUA6/TrrOrRQFpevXiAsNgPAZn5BgArV3D3C+0t+baSrsfNIwHiF3J8Je?=
 =?us-ascii?Q?b7sDLbhRNy44OY0Ge4I1DCPogSxTKjQ+jDpv8jW20Qr/NlrGA7CPdLLGl/Az?=
 =?us-ascii?Q?bsz3EhULluSpZfR5W/rb97y0fGk5DPUU77GY0TtWn4Jo6IYazKDdzv7WkEXn?=
 =?us-ascii?Q?XPrRLVR+VPYO8WpESnZwFitPxq2RAd02i6aksH9R5VM9fbX27t4nU3oDnM/e?=
 =?us-ascii?Q?K6jM8aaxoL5mQjkGcC42we3zy99Nm45WJNZIUZvSnlmTr5P4jk2aWSZ4J8h4?=
 =?us-ascii?Q?d5pGUV1+l5lXnrutE+WsC6NvYJyve2iDcqaf8Anbu+NCr7kNxxpazFRqDBe/?=
 =?us-ascii?Q?6U6Le6pUWA70/5Jm68i9a+Jf4EcOwPPvMss9uiX2sAY0v18Avri5Vq8iWKIm?=
 =?us-ascii?Q?nmBB6kIO8jbPoAK658uU5ZytUPFiE8VcwsRY+ALP/MA+ZOaWRdtqr1qwf/Wn?=
 =?us-ascii?Q?RWCWdcjx3EQ3ICKm3ivM3o+mAj/e2z2Y5RHxVd+mX5H5RLyS9lMFHkQSbjEh?=
 =?us-ascii?Q?HcVCxVx3V48j78E9Y+XIj++LhfrsvjhXgsmZzgrsYCMe7v7h+7iLiWeIgqXZ?=
 =?us-ascii?Q?qdcN56O40ucq0WDP3JGHr/MQ48cGM5ZLldnxK8sLwHtOK1qObfJMlKOpHk/e?=
 =?us-ascii?Q?xWsjYGwzoiZAXZyJ6W42Wy8Z5C3EYZBZk1Ck1qRt5/ShSrthZf6fem45w08W?=
 =?us-ascii?Q?hDzWP0JnuTEZkLNY0FvgBezJgFIpqGIGth55I3wEIbFyhocSJlh5jGA5oZef?=
 =?us-ascii?Q?6BcDuj3zQI5CTcGUERWG7Yg2FucuYtnGgW4UJfM3w7OMuANWmWw3S5BEtPLI?=
 =?us-ascii?Q?kYq45m3PLRPYrqIj18GtgApRRfkDYf+cUIOBjo470M1NqwnG/PytnkNoBNR2?=
 =?us-ascii?Q?q4UWEj706kDZrPm6k5dKa4ofYIcTLTNhsoKEbA5EBfGsiB+DDR2RDOn2qZgJ?=
 =?us-ascii?Q?lKFL/ZLbLm9mKhta5950yKE3dKrLwXkCf9qNQxoyoCAmseJUM/V68mX1Hbds?=
 =?us-ascii?Q?2xhb5dfSjSvLGtH4MqfA61EuAhOKB8D9il8lEHYnhTLQArkIa+A1G5RZzrlx?=
 =?us-ascii?Q?TovTJhjvMpKQg+liocPtp5qx3IzHIUqWhgJpah/TFaTcjYBEvEIsR+353C3b?=
 =?us-ascii?Q?Bc8FM1R2Vg6GrJlSe7drcyRY3ngCxfAo9QTmEukis1l3g+NDMRNWrjQnG7xH?=
 =?us-ascii?Q?akLjKF6Tdfz2aHfWgZuX9WqjbCKUBQaO+kkK4R+oaSV2HH0oYh4CkTnfgu+T?=
 =?us-ascii?Q?hvY/+y5P1sBmj58GllGS6TqH?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecaae6e-946d-4547-a35e-08d924dfae2c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 09:28:57.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/xcuWf7ukI90SHbks8u+Go3NMd4MUdnjhEKLzn0wJN+Cil963XEzm1kBt0tV3xe0A65GUJPFvtQZ0z8ItZ7eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
X-Proofpoint-GUID: RnLDYRHi8P25SgqfNUiP31A4gGEJtlJ6
X-Proofpoint-ORIG-GUID: RnLDYRHi8P25SgqfNUiP31A4gGEJtlJ6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_05:2021-05-31,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010063
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Meng Li <Meng.Li@windriver.com>

When read adc conversion value with below command:
cat /sys/.../iio:device0/in_voltage0-voltage1_raw
There is an error reported as below:
ltc2497 0-0014: i2c transfer failed: -EREMOTEIO
This i2c transfer issue is introduced by commit 69548b7c2c4f ("iio:
adc: ltc2497: split protocol independent part in a separate module").
When extract the common code into ltc2497-core.c, it change the
code logic of function ltc2497core_read(). With wrong reading
sequence, the action of enable adc channel is sent to chip again
during adc channel is in conversion status. In this way, there is
no ack from chip, and then cause i2c transfer failed.
In order to keep the code logic is the same with original ideal,
it is need to return direct after reading the adc conversion value.

v2:
According to ltc2497 datasheet, the max value of conversion time is
149.9 ms. So, add 20% to the 150msecs so that there is enough time
for data conversion.

Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol independent part in a separate module ")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/iio/adc/ltc2497.c | 2 ++
 drivers/iio/adc/ltc2497.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 1adddf5a88a9..fd5a66860a47 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -41,6 +41,8 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 		}
 
 		*val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);
+
+		return ret;
 	}
 
 	ret = i2c_smbus_write_byte(st->client,
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index d0b42dd6b8ad..e451930837d8 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -2,7 +2,7 @@
 
 #define LTC2497_ENABLE			0xA0
 #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
-#define LTC2497_CONVERSION_TIME_MS	150ULL
+#define LTC2497_CONVERSION_TIME_MS	180ULL
 
 struct ltc2497core_driverdata {
 	struct regulator *ref;
-- 
2.17.1

