Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB8155CEFF
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbiF0UB1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 16:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbiF0UBZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 16:01:25 -0400
X-Greylist: delayed 1598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 13:01:25 PDT
Received: from mx0a-00328301.pphosted.com (mx0a-00328301.pphosted.com [148.163.145.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B531C918
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 13:01:24 -0700 (PDT)
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RIumQ6028299;
        Mon, 27 Jun 2022 12:34:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=8PKUjAnGivRWfoohJkgr9GUpf3pfr+Prurui4UM6e+M=;
 b=U820/yL1ylrxynyZss1s3iUlNDfOmIUbDhTTlEL7yvAKQADRJpPiHfkRqXKCVZ/9Lvri
 IWrW713UleeGCIdLE9s82AUPNWrPzBYLw5CkeZGufm9DTuFzUEtrwJ3mjkLkSnyViAep
 mzkHGm17jDZLwngjlvZ/Y9s8+NU7GmejYkVBjc4hRgOAhE0NW3w/wOFwsciEC+2tOpdS
 /iTN2fQmZMWO0kKKUz8KWbH5y7ydHsELWagfEhrnOe94EUGT3oY+tpqVXyQeRZDDzo+P
 HoMhzvhUd+0lDGxaZVkk8fKM7ewlTeuz7Ksd7kE6qe9SfejJ8PBvlnJ+mpkRv1rYiVOl VA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00328301.pphosted.com (PPS) with ESMTPS id 3gwwun139e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 12:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvRmiTuiiyXnRmneR0G4YoK9RySHHOmoYOjfApnFonAss9CIOQMj5ewyFC+0hIQmx36TD6AS8DRkHiRcieVNa3mGxJE5i704ziYwMuq21tgBbBv6Gt5thKpg1hMnX4mEzFRJtRBUxu7Gns6lQJZopCgQIXEZjKesKVQE7f/AfEDNN3rt5Z+OSRMTgyGDESsJ9V5ZDPCytOEhOtKPdjUE25z32vSUohEqnKYZwdawp87cWqhi69Es3cfw09vZa7s52xSfLxIv7RFyr+2s9NN77WuLvitTvzgGVAjiHfHxHn3CEVy9JcD31LzYrsIoqguUHxefvjoyYAvz71JpQIs+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PKUjAnGivRWfoohJkgr9GUpf3pfr+Prurui4UM6e+M=;
 b=NiwqyWU4++v5c2Ya1cS3SDsk0YUX8iU06CZuMvn7/RXPLPH2K6SjX+JJdctHbfVx94n9Yd76kJE1+4ERly5XWCcg2CtDjWVV8Xk1a/94Y3yoXxnkWNcF1DbeIQqV3jTwafesUGfkVER2CfkN0x2RUWVD1+T4pRQ0Y2FQyIE2BjaD1hV2X/R8DO2cYSq03x3I1tKw7uJJWbXQ5mAiH87f6M2Y17lDaK1DQYsPEqY09kYZZmJeGWmoNDdtBdvUUMgIio3OK7JDoqoN4KCbJjMjrGvGT3VsczVOH8vJ9TTOzqrvI7ZPZKxugO2c1uZUAeE0BpJfXmpXEth2Ihcq65uicg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PKUjAnGivRWfoohJkgr9GUpf3pfr+Prurui4UM6e+M=;
 b=hSHtp0Mh2MFGvycZrVAu18W/UuSybi+nTAbM9NXVpd9Mi5TvC+4hssDARUuegjPhY4+1osj222jhdEW3wU76eoIZMpBSviywWCjTO+tGi7PZptf7/oMuSUIo3DOqfBvqAWOkt1MJw3EGcwELgBUvM6NJABSjfiBLyd6J4LD22nE=
Received: from BYAPR12MB4759.namprd12.prod.outlook.com (2603:10b6:a03:9d::16)
 by DM4PR12MB5392.namprd12.prod.outlook.com (2603:10b6:5:39f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Mon, 27 Jun
 2022 19:34:22 +0000
Received: from BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::64f5:a6bb:b5aa:ce61]) by BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::64f5:a6bb:b5aa:ce61%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 19:34:22 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Fawzi Khaber <fawzi.khaber@tdk.com>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: fix iio_format_avail_range() printing for none IIO_VAL_INT
Date:   Mon, 27 Jun 2022 21:34:02 +0200
Message-Id: <20220627193402.21553-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0479.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::35) To BYAPR12MB4759.namprd12.prod.outlook.com
 (2603:10b6:a03:9d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 861da4a6-472c-47b0-c1b9-08da58740916
X-MS-TrafficTypeDiagnostic: DM4PR12MB5392:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csD3Rh1HBBvaaQYJJnQhN1lcJRHeLGrNrY/4p6ZhHwPjWQ3/NErD/4Z3sE0tSq1GF/z1hLntARuyjA0dj6eKE02IupcfJNWYGCZX+fkEkzg4MPgi1Rl/9LdWWSyjfx/ha/42V+s8jZJvX82nh2du4xc53z8L5KVF0RUniXRZpo0BegrHH1ddMpTWphBevII6Ngt1eMvhpjlKs+tRTGRRlLXfaPkL9gdFQNi5G3cuHy5g4bEaLFQ4lk/F8HavUbrOfycr0AssCX7IbvlnYN+ouNHJKF4KBDsxpX/C6byEnW5EvJKwc0/JzYpT1u3SH5KVKXrwhFVeNmD7Oc/p2Z+D6dkuOlkFkdZNB7ur+tYwEJDEQhYWqRZsTuIYVnkuj9poCLY4ZDn7ws/DPPMMlijqojjZmUFJggsGrw0/0U6HJfpcgjvv1pJv+LnEn2og2h48il9+SogAkkX22hmgqzkCwAl8fppjg5DdqsKAlmNqr1AwCgup+8NowbaBIXGpfFY248oA8lTKQcXPHVXcYXb8obk+CTjGHeKFKNGVS/YYy33HqIZrcvaP0Pta8TtND/S470BOSRn9t4o1/DrNrs0TdZDtcQSvmYQVqzH3UAd8BMTBN1m9Qhxdss4HU38scN95RWOFasY5Vym6JzEP1z4G1DrlP1+mq1N8P8u66ucXKl8fqi5Z4W4IDenHi3HbPfsWspAKNq4GJ1bsippzZw9+oZmxkoEn5ju2QQd4V7ClH8rklpcRXYqnmQ2gNGoIQsqQYnczP53yNZfyXBHFfle/waKX4lIYLGNvRIEBshczEWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4759.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(376002)(136003)(346002)(8676002)(86362001)(6666004)(36756003)(41300700001)(4326008)(83380400001)(316002)(52116002)(6506007)(54906003)(6512007)(6486002)(38100700002)(8936002)(478600001)(66556008)(38350700002)(186003)(26005)(5660300002)(1076003)(2616005)(66946007)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BESbL/RdU5I7fAKZ08Vx41BGiZ2l5oy74q0Rog9cwCyowA7vQnUMQzt/Ezwq?=
 =?us-ascii?Q?zkk7mC7JYjxYygcxdG4MyjBv11oIAoJE6maCd5EvhNAkcYV8Hp18JuQRrsZC?=
 =?us-ascii?Q?ed1qOHkfsf55+CFRb75FniNO2xxfikLyCNvpBAL/KxgiuSoF/Emf0hXp+OQt?=
 =?us-ascii?Q?+mpPXsUCFmhoECJjTlt9QX/6aW7Qs6or2qAFZYz3O3k8fRuOdvcISQctMY9N?=
 =?us-ascii?Q?pxusM1PWt87DIkkhxu191ReysiwAQzGFhGbqYmb5GzE7XNCEprCI9ayVucF/?=
 =?us-ascii?Q?4VLakoAv5x1UdRsL6D9X3YdsSuFHbvg91OJmPR/4KzYy0iziYxahbP7h8Vbp?=
 =?us-ascii?Q?0gSCXUgKVTyxtG6bDXuEd6046Wnf4S21ZWh0yvDSB/gsTR0rqcPy+xgkej71?=
 =?us-ascii?Q?jAoIo2GHMq+lmo842atfwDLLx6Hs/LAV60dauTv3y/Nni4cTSamjW9l4EO4P?=
 =?us-ascii?Q?UKNpyS58jNPH+zBeVgxNEEuG/Fy3Y3XS9jqdih5LJdRnrWUdE7zoBAMH852G?=
 =?us-ascii?Q?2DBiF/HCaGwSovylv6H6j1naYK693IoahW5TLJ7qEJeDsy+VePLfkKANH3Gg?=
 =?us-ascii?Q?Rxa+EgSicPW5nrJmZq1L6zMxjzAJYuZGGObz4sM6+OE763dYPCcrr87vwyFe?=
 =?us-ascii?Q?oLJ/g1vA1KnZMvRQvrX1/nJD/qB5R3k0WaWR3J8Oy8N1ll9fsGur8i2G6FfD?=
 =?us-ascii?Q?p8D6nRdBks+ShYlLzgAUKJnQu51cjQO5tvnA1xlGSmgAmgQkqvAMQLrnGWRX?=
 =?us-ascii?Q?7OhlaDMHtlvvByjtxcuaB9fWNz0PY8WaBSkq3yCpWULP+Zu54wnKXUekYMHf?=
 =?us-ascii?Q?qd2+1XqkVUB3foetzOjbJ+MNAjqpfuqPPc6+5XwmeoCdKWs7BHFsdOs67qnM?=
 =?us-ascii?Q?iAE+JYMLtbqOc0riDhCaMAMDfs2DlMtuhB/TP64vkOT79f8DQYuW7Enk5+m7?=
 =?us-ascii?Q?bFPfzJw4lOUI6cPU/x4AHWAc/tCZL7ZWtS3gT77G8Rub++D60cdSHlTVjc93?=
 =?us-ascii?Q?DMT0ZEXORqsyvbuCA3RHkAsqyzg4G8whkIiRthlriRhuUZJPqVSbkWZS+py6?=
 =?us-ascii?Q?J3g32ktWddGLxBoM9zl1+RGZkJk4wUkYTAGLlCne88sJiyNSgyI61o7KCbWV?=
 =?us-ascii?Q?ZEvG3AiraoOOeszB6ZU3e6LrZn2xq08YkjOqje5CKVlAiDboPITPjJB2VB5v?=
 =?us-ascii?Q?LDpfVJoMhkz/UTkqvXUEQ7F3wVjJsQT6cgegudOvKnKzr9ReJU9C0jXGSbK/?=
 =?us-ascii?Q?753YOab9U0m889asLZHF38nMfUaNX09kGmEhvT6lUb0V0NGue5WL3M9a+hKv?=
 =?us-ascii?Q?nM+/1mhIlwIUQPKgr4RW5S4aTZ2P1QSwO1/Ot+tvM43FVV1cYXf7DdGzDQr/?=
 =?us-ascii?Q?YqseAebx/qK7CDQ56ugYVUiZ3ocQdGu+mjlcs53JaHt/Y03B2LwlWeKRzu3H?=
 =?us-ascii?Q?ChZPPBYqgFR2PjU1YueDug/4qpLY3g/S/8qap8DctxCISEistyidnrSTc7X/?=
 =?us-ascii?Q?cUMzEtbY0M4Ba55VcB8y7yl/witYn30C7mIGGiB5/Vej98ZAdo4xstXRSlSJ?=
 =?us-ascii?Q?3MeoIW6F5mKcqJSVN3sttxECvuOHy00eX8n4PD7aPXFNrmm15Ba8x+NCyjak?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861da4a6-472c-47b0-c1b9-08da58740916
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 19:34:22.0470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7Kok9/679NcZ6avC0HqB7EB4iGP3VRdnKq3vms1ok4EURafWCb68m1VKoLuFteE9j/q1NrFXy0R8jGvRMast3bC8K/H58ZGBcaidnGKH4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5392
X-Proofpoint-ORIG-GUID: 11SIMWh2lmgoiOBPDlh4qqWsjjGhJ04s
X-Proofpoint-GUID: 11SIMWh2lmgoiOBPDlh4qqWsjjGhJ04s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206270079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Fawzi Khaber <fawzi.khaber@tdk.com>

iio_format_avail_range() should print range as follow [min, step, max], so
the function was previously calling iio_format_list() with length = 3,
length variable refers to the array size of values not the number of
elements. In case of non IIO_VAL_INT values each element has integer part
and decimal part. With length = 3 this would cause premature end of loop
and result in printing only one element.

Signed-off-by: Fawzi Khaber <fawzi.khaber@tdk.com>
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/industrialio-core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 358b909298c0..0f4dbda3b9d3 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -812,7 +812,23 @@ static ssize_t iio_format_avail_list(char *buf, const int *vals,
 
 static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
 {
-	return iio_format_list(buf, vals, type, 3, "[", "]");
+	int length;
+
+	/*
+	 * length refers to the array size , not the number of elements.
+	 * The purpose is to print the range [min , step ,max] so length should
+	 * be 3 in case of int, and 6 for other types.
+	 */
+	switch (type) {
+	case IIO_VAL_INT:
+		length = 3;
+		break;
+	default:
+		length = 6;
+		break;
+	}
+
+	return iio_format_list(buf, vals, type, length, "[", "]");
 }
 
 static ssize_t iio_read_channel_info_avail(struct device *dev,
-- 
2.17.1

