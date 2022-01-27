Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF4149E91C
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jan 2022 18:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244641AbiA0RgB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jan 2022 12:36:01 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:45707 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231680AbiA0RgB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jan 2022 12:36:01 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RCOsjV001451;
        Thu, 27 Jan 2022 12:35:47 -0500
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2053.outbound.protection.outlook.com [104.47.60.53])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3duu31r74n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 12:35:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPJQBUq5ixYnVIypSvpgUZ8W4aoFyHoisV9QLPlyzxJJsbSEY4gGsyv5DwAztqGNvt8aoPxmbeN51HBr5Ijsit7MLoGxu2DLiDyf2iGtx5djfAcwKfAa3NCZlpGgPk57bws+YyQuSzoSQQnL/GyNCwntxS63/mF3lg9kG6dIa3M4n1YQB7CtBu7mizd2kPY89DYVnIq2uuygFMtdwOqRN4C+BDsZvJ5gQbW0UGRcZFe5QNzX801Fjr8+9p04cdlqjN+RrRnDXeMVwu9UVsIc5PLeyb14RWv7/6YawmausEaJQIsMyZicU118SJLGewk9vI+Gi0XaYNIiTuRch5+r3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ch6JKD/FY8sFseDtjkgvtNV1HMRET1+BlqUeafeeaU=;
 b=L/9nfnwt95TxYsCLZoclnvd+QSfVo9u6TBt9QZcpVhSs5vA/9mDmY947KW6IbbGUrHALctVVYPM0TiS+8v4rVOX2HhZHKBJVBygdJ0dY5mmp9aM+7GHWKqUTywuq77dIXxrneTBRDaFXbQNEWXnJbm4mkGmu7+VnfCn0r+prrbglRF9prre+87H0Xil4LBnGFPCRuwWN3pnddd5M94U6RjDGtVfreiymd3qdVgrFoWF9JqsrM4XQ20teKKIFWy/3j1t/lMNNPAux3aVjdElBhyLoOgG2Y5MfLxxrqOHRb1ABIRkyfmDSgurmO2Jq7J7ecFtJA/RfIRyYJtHhHCAsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ch6JKD/FY8sFseDtjkgvtNV1HMRET1+BlqUeafeeaU=;
 b=brKQhCJxJZ/w4kbcauv1jfuWfisiM97USnbZYg9f9D9CHAmQ5dK3O0OYv9us3XySLvxkX6Y8vHTU5nC35n3XqmBjEL2cTGBXMm0myx+l++niGr/05poGXuOmHhE1SOgva+iHlyTJr8JtcMRDg0eM0FitsleAEyLZEVZjy9v/qKw=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YT2PR01MB9665.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 17:35:46 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.020; Thu, 27 Jan 2022
 17:35:46 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     linux-iio@vger.kernel.org
Cc:     anand.ashok.dumbre@xilinx.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, michal.simek@xilinx.com,
        manish.narani@xilinx.com, devicetree@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH v2 0/4] Xilinx AMS fixes
Date:   Thu, 27 Jan 2022 11:34:46 -0600
Message-Id: <20220127173450.3684318-1-robert.hancock@calian.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:33::16) To YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fed4d17-a7dc-4a7e-0673-08d9e1bb7365
X-MS-TrafficTypeDiagnostic: YT2PR01MB9665:EE_
X-Microsoft-Antispam-PRVS: <YT2PR01MB96650506EEB6596F737C3D38EC219@YT2PR01MB9665.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nk8KqGx5Vo6P/DsB8/SKrdguDgZQW02uW6+CT6tA8P264OsuSDu3qksRNPsKfFfhsGVqPt1CPCJnb7EM0457o/QgwmVLTOnIgLkZ7c3072SflsVVagBXuVfA0KewO1tUYdu3AWBESdrRRAmWW0/KhU31IS5Rpv+NBUaccvWw/P0Q41IM3jji/EBdejgJbCauYKGc4cbjPoNzKyo7TmO5Dedo7w03dWIlIhLV4TWesVvQZOo3m3PPnb6tjU5njAv+Qfebp7yDLn0/74Tb01dpvJv3xe8Fr6GryJsxZRTeNFe2ZiiB2pFGKTaPldXFvEKQV0HfbX6rkrb/Mtf3K0iNkf0q/YHrIdL7tY0ejNCBOVCQ0vLIYGxoEZOqJQ6nOyfdwVTH/3uD02/bWnW0SGLEitRPTOTzeFPEnbsVFMsrhQHXrLsvXJIfL6b7cwntzQdrVEeQcfzfSpRyDN5In3ynEwnQUF8ZSfNkyvQ1eEIrBBMSBioj4hNkgIptrdbj/YOxlz3eOpoATHih7jbOMAUEWq+pSnAFvQ4kGeQfrF6/A3sW9mQsGbKcNnMBp3X+lFgQNbT/U1hyZ4Ih6H1M8XbYXhP6PeAj9Ax1aLhkmmzRbXRR/u8TtmgyYkGN6A0rWDyW9PVr2FNWgl8P7NQDiZ2nin2LKnQWwyYjzIkbb2ZNVBOuf6APtYIXmQkDR+7xfqgr6qTXlEsV9Lp7LRKLrHKw3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(8676002)(86362001)(4326008)(6486002)(66946007)(66476007)(8936002)(4744005)(44832011)(6916009)(5660300002)(2906002)(107886003)(26005)(6512007)(1076003)(186003)(2616005)(52116002)(316002)(36756003)(38100700002)(6506007)(38350700002)(508600001)(83380400001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pDqfyePs/TrXIVD20aEchlxRuvS2kdj/+CQPDxHlYbbcuvN3Vxuqs+vdWTcy?=
 =?us-ascii?Q?Gt949czzgKaNRCxI6dTR1wHC3VVycZAZnQvCyGKjywUryzP+Wtn/XphvSNu1?=
 =?us-ascii?Q?+GDCgEpO2VT/EYrWccyHcF51xMB0VZ4eBYhQ8Qty+Ud9ZkauAGs9y5UpMZdE?=
 =?us-ascii?Q?In2whbMfL3WG0+eKuXpAVuLRtJk4A5icEnXVZpVT1hXOZ6leGPZNFnpXoMkY?=
 =?us-ascii?Q?yZ9WnqHo9MGSMEyq1EBMbarw0EZUBfoNCsd7hmq8kuqiQ4Pp71N8+PKaTFz5?=
 =?us-ascii?Q?1Y0M3fG6o56gFPT5asRB2/g+m62q0C6E72DEPIb7/MleWeU7P46WenMqOTTk?=
 =?us-ascii?Q?hSzvG8JEcaZY98qIt5kY6iIuEal5OjUK3GWlrE5F2Jd5zl5nkL6LwDRRCvmC?=
 =?us-ascii?Q?dGh9ItpbOVlAMPU4V3NFpOrQh34JMSrvAfUkJ0nWH42JtpBGtGfW+8VRXOR5?=
 =?us-ascii?Q?nDt7+kKp1REfmVeUprDQRctHXEmLOSvbHvUym/+yYSJtz/oV2nyEjUhVkxY/?=
 =?us-ascii?Q?1jV2EcPufFRPXvkLq68dNlts3OWiBrhOaeq3MH7xKlHCPTsJ600xbnUkUk8n?=
 =?us-ascii?Q?5/N52HPBcXetpdtNxVjwZsAwv133c3tYRB6r8xoVu5aTobtf4nvTYlf9kpo0?=
 =?us-ascii?Q?wFZdQwQInoWM5U1WTrxGOnHU1xdfHLuX0TH/R8ObEytter65g5xu5P4+y/D9?=
 =?us-ascii?Q?YTCPjHP/uAYi5tufuB6gL2TeDBDZUFZFpcBODlwnL8hoofH6amhZ09VFpYoz?=
 =?us-ascii?Q?jTBIVPG1RQzjxjGGtA8t4CSUn4XYO/kk8M+thyYajvHFBAmONfV5+1dMwesz?=
 =?us-ascii?Q?HMOHBHNu7ATsbYMx4opeeEi4ipFgKNHPi17pdEdyRup8GMvc0N9+eRDCHmjG?=
 =?us-ascii?Q?cSYlxl2FG9bSvUiVGC0qfktIsAQCnDaaBFVtKrfuGLx/EiWN4t7gI9w5UbP2?=
 =?us-ascii?Q?kEPAm2xPU7wM31iXnQgkOWMIlOH2AhJVBcLyZE4Sm7NX4jazfWcrKou9LrrS?=
 =?us-ascii?Q?xniwjYTyOAvsino7htbKVryeGTyeTEp2D6J1opl3GsT+KRAkNaay4FfAVAhq?=
 =?us-ascii?Q?o2kxZ+CSxSa0sw8Y7jdRICcul1p3EPlam76VIFmpJBMYeA5uf4cOM+oeaovc?=
 =?us-ascii?Q?nFNA/olqfF/MMaZNo7btpcZCuaY9FpWVMl23CBpelzHsgJ4cDkpfQkxUEOMG?=
 =?us-ascii?Q?pZaiMWNLIvWYrh9mf+64tEZxqfkC3ol2VKmlNECl015tz52qiwJ2NGNdsj+U?=
 =?us-ascii?Q?bjZfmXsOEZ7IX6m3YNQhXdcklO+rDr2/hTY46HslEF49mOChVg7jq5HqDfr0?=
 =?us-ascii?Q?WQ3iIMxcjc53LlURg/JIzo8lZHNLDp0zQu4BsN+TObrbUzvanJ4kR4etnHcY?=
 =?us-ascii?Q?XHzg0gWdL7+wQuLdxA1iIdYRlTA6UToIHaNY1K5hbTEwzF2AobnN1PPFMhqR?=
 =?us-ascii?Q?lQ2WwQE73SsxFAph8UE+5Roqb8WryIPnbVuF/TkQXDOu7FB0FYrZpnCp2BSy?=
 =?us-ascii?Q?5NBpHZ3NDUH4HbSj9gSsFqF/81jytW55eGfbrsCXs2/xccYsbokvlcohi6vo?=
 =?us-ascii?Q?kYJHLjXSjZGamUHwF7prwGDGlUarIz9hqLxyxP4sBb8QY4m2slwH8Bu2zAw3?=
 =?us-ascii?Q?9fZMX0uHPEaqRVLFMkys5sn2MPd8cwqIK4W7CyvyaQQCUKKCOPdUqYERoAdZ?=
 =?us-ascii?Q?LN+K8UJkX1yIzVPOJpDBZUfLDZM=3D?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fed4d17-a7dc-4a7e-0673-08d9e1bb7365
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:35:46.2645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xufCm1hyP1oO3NdrblnlKh+cDqxy+KaWrcvSWe90CefbuaNo2tU42Yyjezpdm2zkVH3r/AG73S9HcE+2fc51reuqP8b7C9W5MBQ0poFwAk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9665
X-Proofpoint-ORIG-GUID: LgdCLKoXHDOvdUQDSno3etOobavoExv0
X-Proofpoint-GUID: LgdCLKoXHDOvdUQDSno3etOobavoExv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 mlxlogscore=472
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270102
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Various fixes for the Xilinx AMS driver.

Changes since v1:
-drop addition to ZynqMP device tree, will be submitted elsewhere
-add patch to fix DT binding to add missing clock entry

Robert Hancock (4):
  dt-bindings: iio: adc: zynqmp_ams: Add clock entry
  iio: adc: xilinx-ams: Fixed missing PS channels
  iio: adc: xilinx-ams: Fixed wrong sequencer register settings
  iio: adc: xilinx-ams: Fix single channel switching sequence

 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml         |  8 ++++++++
 drivers/iio/adc/xilinx-ams.c                      | 15 +++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.31.1

