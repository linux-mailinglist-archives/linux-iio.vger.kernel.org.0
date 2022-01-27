Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBEF49E923
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jan 2022 18:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244677AbiA0RgJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jan 2022 12:36:09 -0500
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:8812 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234612AbiA0RgI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jan 2022 12:36:08 -0500
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RCIlZN006794;
        Thu, 27 Jan 2022 12:35:50 -0500
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2054.outbound.protection.outlook.com [104.47.60.54])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3duu8kr833-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 12:35:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oV6CRc6CPdOJFtR5tp2ZgJUmOFWPuLU/Kxsvu+Sfh8TxnQNcPy3wD9X2AwmTHGxcbvZE27Zio+laoqQwqAzoB8VqVGwaQW2vatKC5Bgf07hW4koYKLSQ6VZe4b25RyPhMPYIi5hIwOBdJuzxgfFOSNmqHkrnHUO56xGjzEZCa6vvxV7KvZcvMpKXHWpbWVw/gZPuFwEFLPQbT6QUl2s8AiNZKBaKwXvrV44sc/riCiSpmWQ5LExwgUnZUTNEk1N3RqAKF6tSplVntjY7sGu/HaqBzbI5V5cmDQYWYNQyh8fxFksLvBkQBhk3YeoJd6QIusJBhVGMzNFpP6kOkipA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y8PISiJe/1qCQcj7yBIw4ZGWQZNokP3+Y0ppb1EQ7E=;
 b=CsEW18Dc9h62Lil/BX+WaiEDbStvgSQiaqrha0DLLClqRgsrPng2wzeqaD7x1JxODlM5F0UDEVw6zY+33o6f3JVNcqx+bucdVrKxJeG566WxwOH5szTQFghiRP4yvfeFqkZ2GW0AYu6/9yVx2KtmFgszZF9LjGEdTaC23OWyuKSG/+SKUpiS4pCNPG1xd9PN6DlYWH1LZN4HxVrHML6YPFrxzVhuknrpHjgu88/RxcR35NKBoCZHqun3uaGkMpb5Cxzz/mwwQP0F48o9ZvV8hFA6u99ax8o8eJPAjpc2hmhUcDVMMos+eRUlNHD0zCyMEdztmKMstZKpf4z3s2rBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y8PISiJe/1qCQcj7yBIw4ZGWQZNokP3+Y0ppb1EQ7E=;
 b=WuFep9spPCDqxko82a4SC9dVmg/ZmZz4TJN1ZHHnUliBOA54FpEfCdPMGX5kmYvz31xyoLFG93PZ9l1ThTZxTaaOALl3dAdIIVjciWHIDFJ0ReGRu3+HsOYbbiN/hdWMLlis1XqEpGCa1iN/1f/27jyy+ZcN08qdZfp7iWZYzI0=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YT2PR01MB9665.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 17:35:49 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.020; Thu, 27 Jan 2022
 17:35:49 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     linux-iio@vger.kernel.org
Cc:     anand.ashok.dumbre@xilinx.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, michal.simek@xilinx.com,
        manish.narani@xilinx.com, devicetree@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH v2 3/4] iio: adc: xilinx-ams: Fixed wrong sequencer register settings
Date:   Thu, 27 Jan 2022 11:34:49 -0600
Message-Id: <20220127173450.3684318-4-robert.hancock@calian.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127173450.3684318-1-robert.hancock@calian.com>
References: <20220127173450.3684318-1-robert.hancock@calian.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:33::16) To YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 592d5953-ee83-4eed-8247-08d9e1bb7533
X-MS-TrafficTypeDiagnostic: YT2PR01MB9665:EE_
X-Microsoft-Antispam-PRVS: <YT2PR01MB9665801FD104BB0DB1DE94D5EC219@YT2PR01MB9665.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVHpL6q4FJrC9i7W7zCI5MHLxt8WD7FshFXysDhlVMn7Sdzyg+XzML3emVe1mewP0i73DyorMmozPzkBjHOvr+htzqcwZly4KjXdc0q+8zMC20rQ+1Wp+blkp2UNA329hZqIBOhmyA0shW/z10ThBhe5xZZGfUgx7tv813FA3nHJDHfC3MmtVZdiJ/EjDDfhv2WJR+OtyuolIbOh2hTr29L/ifJVgzoq0ayuN66cuBGJo/vAZTOv9lIUvsVcMpW7/AH/LGoDE2qhsckjv1/gLqewsnIi9Xcph66bHE4jelhouvhjAYYiULMqPPo59NUtW7NTdaTBdPyEk9Qv27zA5ND4Oya6hbHvZFdQ4W5xj4tDLiqBIcQvCkK6PqviGpbvJJJYlbYtkXbjwr2XjikGHJvsd0HWTKEUu/Zukk5SFOyW5IT0Mk/6chd1huiZ2U1TCQGfSWccsAfXWJd4zDrl11Daw9LebsbLWPn15jmp9u1/9VcL4VSDTaE08FONCuwB4Augy/JlhK6f1YrlXMCfU0gI6tv8mdsfm1z9zR8zEkcRpbYnAC7L0qy+jT+CfmvoJjkNxIi6+7iTNeVBSrSKhOidsNketPcsZU8aoiQDyTcvIHW5fRDYCClkUpsMN5EwHWLOTx0ToAzBy6Yqa+M8blbkx4+U7VVZtcwaR5MkiQKcBCmbmZw+ZkVGLzo7JBgLp4EuRbyJvAlB9KtoBL+3ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(8676002)(86362001)(4326008)(6486002)(66946007)(66476007)(8936002)(44832011)(6916009)(5660300002)(2906002)(26005)(6512007)(54906003)(1076003)(186003)(2616005)(52116002)(316002)(36756003)(38100700002)(6506007)(38350700002)(508600001)(83380400001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1KohhPUGv4GGTiGSrwkaZgrNZQ0ZyJI3W7vnnGSjO3PmsrZD0dMWRzhSNdqC?=
 =?us-ascii?Q?LXBRZjGGCXu+BWaLLcBk4XG/nW3gXVpScSRQQfkxXppW1ihikAjE3PQ3GABo?=
 =?us-ascii?Q?q0OJLDA8skBjr622mp0MPxgdFyle35iAj4gX2bE+2tSv73cVj2sWpZa2SffW?=
 =?us-ascii?Q?JrOoMGzL9X6GUVBNb9yzVvCwvXyruDnbIYVYdhsyljFMi2JrORDUsP+MP13s?=
 =?us-ascii?Q?6hodVk5bQdU03XoMmxA2i4DCZYw7PUk1Di7CNaSJ3I+TRXACxNJIbiYOQEpg?=
 =?us-ascii?Q?QwXLOsxQVG53g1/4hppVGJh56ocYakkWempZeS/FzyZER7A3cZCwjfEu2bDw?=
 =?us-ascii?Q?99/3ZiiDSReAoySiAkMUww1wvOEQZJXKWpeYKyn9HTiF40/ox7vryTtQ94Oj?=
 =?us-ascii?Q?/rpQQQUgBFTHjzKvvHEbbku5OdkIG6V9Jm/1WsuKQMfc5J7ZNnJ+QaHSFP6i?=
 =?us-ascii?Q?rZotjEeSEP1c/6bBDSQy/GtA83qwWs8P6WC1LyGK4CMtU9023BzA6RkPt9ZT?=
 =?us-ascii?Q?hnBj6K7YMs+jcHRa7Hrx2J+xteCVN1XGrnybrd+z31wwWAT8rFKPT9dJhXZs?=
 =?us-ascii?Q?OoT0JY9U3X0m1uGRs398fevQkYc8i8Eacj0u0umPub9hiQeTHUMoplPNoMhQ?=
 =?us-ascii?Q?Rm8iAuFyB0TQxZ040uNLBThelVDF5l3ev7cr0ZrocLwPORs0VS6G/9cAKfHE?=
 =?us-ascii?Q?lC94l44MqYRRnrkVBnSB2K3CoxAoRLolXr8kdSSdNOl2VVm8BIKVtVSodgQk?=
 =?us-ascii?Q?/Gh60mTwY4bI/rAHe+tKXMP8EHJi910kmnsrNzM37WUtKyk7VxE2sjIrDlbQ?=
 =?us-ascii?Q?gZBamtJQ1dePNDzdJwG61WXS/bRPm5pcOe1vL+exotjYAdfziGwSqIjabns+?=
 =?us-ascii?Q?Gz/XC9C2fJNOUYS7Kww0stf3mclkCHMYo5mamSxDJJasHFL/9VGTBKEqUQNU?=
 =?us-ascii?Q?jFj/YSVb0wIQOk7Di+vrGwozgOsEZJt9gGfMHXtw0HpUhpRjLmHVtFiWEcyV?=
 =?us-ascii?Q?jBMbr0dTJkPjcqojhkkd87AFkllIEEO0Y6AAwc06Gij1rZny7BHlEtwStL7K?=
 =?us-ascii?Q?K2IAzFOpgkjSx43Mv6dLPvkK43HZMWxQ6A3MxXGk/j1BGKXLpO2PcL0VpqyX?=
 =?us-ascii?Q?tQ2uQE+d15ebiiW+PDIsaBIPJmzhkD+FYb7mL0xZRK128JlQRLt6t15BcwrO?=
 =?us-ascii?Q?ueztTOok5eHylG9TBCfHFYrw+wta7Chpgnpp7EQkCguQNY8tp1pcbDx4WVd9?=
 =?us-ascii?Q?GU6Xo8QgnXuD6/QUgqRBTnFrHcU7prfmDTbWSjFNLHrl/pajAEEURK3P0y8J?=
 =?us-ascii?Q?PV2SUqgC/HL/Mg99qRhpyABil1a2nnkKq8/HwqoOe19EwWcWvLtB5WlwSwge?=
 =?us-ascii?Q?4aOxQORsC3y0slaodkQ7fPBeEYgyYVzufRdxyG0ywD/tN/PyS2yIgA9NNDDy?=
 =?us-ascii?Q?Q5vqvuw/zgJAfIoeqGDifN5jXU0kLeXui1YimKH98zZvGibcAKqxpB5qgzg8?=
 =?us-ascii?Q?UOFl7Cu0m0RK7905S3u/9f8uQeKE+0wRc4UZzW//usiRJRyeal+ouT+XX5q4?=
 =?us-ascii?Q?UKXQ5Fx/wSZmGtu57GGXycWDn62Ectxve9gejfPJ5jEs5DsBxh+G5sYn9Y+T?=
 =?us-ascii?Q?p0Tcb0+3EWmW4xIXNsstj4uMECbGSup3v6OIQHgARg6H3CC+7Im62emQC6OQ?=
 =?us-ascii?Q?WOCV7JVItPR9rXkdSry7M1tU2cI=3D?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592d5953-ee83-4eed-8247-08d9e1bb7533
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:35:49.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNeF9Ay1jnQlXD923u+IkWzBllDOxyBijLpDIODN7aesLI0y+EWocDEr9G9Fu2yB89cWnPhTvPscORUjQRrzct6A6pPx7nhRoDONQDz5Lqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9665
X-Proofpoint-GUID: DzVmOJ_e_SeiDal8XxMaqZcrngxngce3
X-Proofpoint-ORIG-GUID: DzVmOJ_e_SeiDal8XxMaqZcrngxngce3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=846 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270102
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Register settings used for the sequencer configuration register
were incorrect, causing some inputs to not be read properly.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/iio/adc/xilinx-ams.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index b93864362dac..199027c93cdc 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -91,8 +91,8 @@
 
 #define AMS_CONF1_SEQ_MASK		GENMASK(15, 12)
 #define AMS_CONF1_SEQ_DEFAULT		FIELD_PREP(AMS_CONF1_SEQ_MASK, 0)
-#define AMS_CONF1_SEQ_CONTINUOUS	FIELD_PREP(AMS_CONF1_SEQ_MASK, 1)
-#define AMS_CONF1_SEQ_SINGLE_CHANNEL	FIELD_PREP(AMS_CONF1_SEQ_MASK, 2)
+#define AMS_CONF1_SEQ_CONTINUOUS	FIELD_PREP(AMS_CONF1_SEQ_MASK, 2)
+#define AMS_CONF1_SEQ_SINGLE_CHANNEL	FIELD_PREP(AMS_CONF1_SEQ_MASK, 3)
 
 #define AMS_REG_SEQ0_MASK		GENMASK(15, 0)
 #define AMS_REG_SEQ2_MASK		GENMASK(21, 16)
-- 
2.31.1

