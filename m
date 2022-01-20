Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29FE494547
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jan 2022 02:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345461AbiATBDc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jan 2022 20:03:32 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:21235 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240710AbiATBDb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jan 2022 20:03:31 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K0cFJn000808;
        Wed, 19 Jan 2022 20:03:02 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2057.outbound.protection.outlook.com [104.47.61.57])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dpmt68b91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 20:03:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5Z+8hheELUcU9iSyFEO9R8TOr9RuwxwUBNuvTEkwqqAza6DT/eN4Uve8R5/BvT/OBZGUYDWBto7Ir7wddY2RK6Z/t9boOsNYZG9KZ9/gzoYL69ZJ+OHOEs8OJxSaptWU2iME8R8GFQpELAm31i8fFrF0OK5JRyacdBf0OHY5eXwu8+1/sz9HnL7MVZgN4kymOjzQKpy4zVZiJsR8jLnBnMCNCVfSUwQ+InjZEIogAR8NlxjXzB9JYQrHFcoFZEup36vdPOoKJGlD899pR5I4O7tVXyxYzE3/85ygeKVWZo6C9E0ghc/aBaibZcUy6N6uRE3qpYpPb+1WeBgd++ZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzYeSJfwr8PoELI42vPZmcdCQ/o4jJuejVgnJYlMvRY=;
 b=CIBCahG6vEpthygM2OFKZkJBVlHu8b6X2bjfOIEoYt2RsLmRpts92WB3P7QoEi/NOLwAmZfHxMYWhoLlxGeBH4IFm7fLXJeC4Ho68x0WSgcaHzbAGA5xFd06NKWpXfPqLvBtziMTA2QqYLj3rzwf0063wa0SmShLQERWwzg4PeE2wpVPUR8rVhsbP+v4lKEukAtqHsUcqSTwhFL06O0hjYk93KQufTv/CuqR41jufaDLNtMUduePrTk80Kgc/+dzb1JqxcwRFddKHqmBtSQtSvFppM081TRg2jsaF2roUafnALkXxNEZj6inVkFa0UOiYUID392d78HZCd3qt0oK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzYeSJfwr8PoELI42vPZmcdCQ/o4jJuejVgnJYlMvRY=;
 b=Z+67fT8vWwp9tZMnAmiKne3aJR237i5N1bWP5l/P3x0hE3MOVDxmzRKcNFmOYB2OMmTbgqco6CPBhZIeZFol2xiSFVY8P4wUx9sIgi4iMrMLGF530mLuJ3BKodoDHW2xxx9fGghttAcJ5s73pPPk1K/YbIBzEl5tw6TLnYPzdF4=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YTOPR0101MB1065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:20::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 01:03:00 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 01:03:00 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     linux-iio@vger.kernel.org
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com,
        anand.ashok.dumbre@xilinx.com, jic23@kernel.org, lars@metafoo.de,
        manish.narani@xilinx.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH 0/4] Xilinx AMS fixes
Date:   Wed, 19 Jan 2022 19:02:42 -0600
Message-Id: <20220120010246.3794962-1-robert.hancock@calian.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:610:4c::18) To YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40506be3-9fc6-4782-f0d9-08d9dbb09a92
X-MS-TrafficTypeDiagnostic: YTOPR0101MB1065:EE_
X-Microsoft-Antispam-PRVS: <YTOPR0101MB106543D05DB17A3953A79D14EC5A9@YTOPR0101MB1065.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMl/xfFZDGHcMiYGoS4q+LZzpC2zutMTmvtXV6C+y1RuAujXyy3IZEEFtBDrfSvIheSSg1kHGaTgyIimfT/4nYuCWYLhr+FJVnZA8/sqFR7XGwhBiCBso5mUhzeGYfWA719rfBluXtgVC5vvgjI3PGmldbd/XXbZp+1ibvZkpH/aFJVxwGYzO7ywKwwhwPtdQXw6cL6JNQKdvRKIj4q1Ku8DMt1aLFO5Tl5k4qf0P7Qa7BscoWKiwhDWLyx7p9lHY0pfN+BMZxcNs2UsUTORo7KyzeZ1YzEa1nwrN5NMEJGirE8QLzAAfp1hYZ4v6t4fwm57V1bYE5mBlC8UXSAc3f4QASM26OzwHldtly+3AFYxnE1tFNIvsYuHps3HhuRCAdwkiF0fRFLmNdVOW2/0S8jMNIRpK5/Si5dL45W32v5hOpXVMgc5axTWhRGxg4mvcBVRImPDAPx+t3kGGloqwF4+wcf9jwMI/kA6lrHAS0Q7NaGo8PPMlkXrp6wFdx8jvlsrYClhW5mTDpafiTv7qmbtzcHEOxwNtGsNZPuvK18smE/TafS4FXEMthm0X9GTu7mdKKJeM1OHEN7w+jrVLaumzHU8mvgE4Ik3mvPRF4VjXgTVCYvb4l6JBo/sdIRwT+u4cfIBm7XiYGR4x0MdH8HXYzjexkMK6N/S+Vmz1lQF7M+wlIExmHjg9MszVeyDFI7xehbAtyXAqEsJ8ggukg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(44832011)(4326008)(2906002)(66946007)(66476007)(66556008)(316002)(6916009)(1076003)(6512007)(4744005)(38350700002)(26005)(36756003)(6506007)(6666004)(38100700002)(52116002)(5660300002)(83380400001)(6486002)(107886003)(86362001)(508600001)(8676002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jj5MMdjFiV+8psfBK33qvheEE8Is4A5SVaSdCzCp9vEAVXgc4Oc8Bs68Xczm?=
 =?us-ascii?Q?rBw1ogNUga44e14I7ijx2zLt/9UTVh1xrfJ0dx0nhNmhB7OZki8rjWxGAwOe?=
 =?us-ascii?Q?nE0ao8t+2qccqcCvBmgZbRXeFY2n5ZswOLd/H8MgnfSvO2ZDK01E6FRzVNXX?=
 =?us-ascii?Q?J5mlb2M2JIIJXbsUZDGozHOCnQCpukv/pl6CxFVmo9WJuSHZtxhIGYzQcGs2?=
 =?us-ascii?Q?uygyWQoNaQ1rEhpYWPmm3cM0umRhVpRCdzxy3o/87YCgsJZ2n9QdOn3om3Dd?=
 =?us-ascii?Q?/CPaIYJCTAGgMtX8atoM7NSvee/Sa/d9mkY5NZhfYOu2OwWkh69p1I+aClpv?=
 =?us-ascii?Q?xFLAsR67cljXMbsxDNyPcRfVjPbU6E41PJ923pATDTASdgKm520C0W4j4W2H?=
 =?us-ascii?Q?qSlkZUCKYKWXCE9dYk/Lges9yQuCAr6z2UBwfUpU7EZCZ1FVCECu7xN1vXhV?=
 =?us-ascii?Q?vfXZ2XOVASWkPvBJsdegNH9GQGVquOKfLqpui0POd8viv7Lw0aJod9+QnY2c?=
 =?us-ascii?Q?dN5PzPZXHuk/lz+GXHkPKDlWJJyncekJ0SbrmYCYwLgmOEY3JPry2ueAtx+z?=
 =?us-ascii?Q?nnVn1bmFTy+zYVWdcqembYjrshlZHaM5aYou3kvpSBXf4HuZ9v6Idr1SmHFP?=
 =?us-ascii?Q?lRzNU4OUMZNxL78KjccrHXI9y3uiEUZGJP66n8pOwbHfhwz878WoKVfz9H3h?=
 =?us-ascii?Q?U7PFZpOmJEG9gatF4s+smL9X3Jy/fi3rSgHV7fNUjbCFZc8swLN+OQk/87Vc?=
 =?us-ascii?Q?zjUxDx9F4QwTC+HNLMVQDjLpdeaFPBJ0M39yHaz7e/sVUZRhAdag4i7ys51Y?=
 =?us-ascii?Q?NhrbrRM4q74RbSxz7jRGqphkCpEhiVKethdWD4jmzWxzDGXOXXqEtpUI6Snb?=
 =?us-ascii?Q?VQyqn/bar/xYeaYdFseA/maKWfJFvzuuXB4Rre5k71TKxjYKXn3Tv5zWRc8t?=
 =?us-ascii?Q?OSJIGHRzJWqB84vdwF77PyoEX6kIjbVdw9+E45FHwY3vYwXb0eaaQi9hryfG?=
 =?us-ascii?Q?fkCsyTUFc9lsOabSpBTYoAuSN87WMP/UncnWwUzFJTAR4zCipxd6vC9FilLL?=
 =?us-ascii?Q?u1lpd7wHZ75yiUqRGnSU6dMdC+KdUjJTArJPPromATCHAQqjlIJn0a0hWBtF?=
 =?us-ascii?Q?CO9PHAr2xdn0SD33zt9S5sFYmSlwMNEeU0hcGFSQ1cxcqb5qHNsBEHmlHrkV?=
 =?us-ascii?Q?uWrOsPpuFpFPMiNZ1GTMCTVvAhgcMQiiFb5VSZifcu2xM2Fi5Kl94zmk4OGD?=
 =?us-ascii?Q?unHlwXo89u3kzFHVk0a7juGbNwotYYhkuysZ2rSXMrNlJ1lBuGNphhmvo279?=
 =?us-ascii?Q?wPSAe1zcHDLYmzzIxUUUZKZX4SFK21bHal6jBevtf9SRIYzDEGPhPsWRfGm8?=
 =?us-ascii?Q?oPsCwvpjNqR/WTtVc2YP7ghmgLczTNfCWwbN+O5Cr0ofTOA5jsKujodTzT1W?=
 =?us-ascii?Q?EmUoO9hs3cIHCIS46PdCfdbEdElqpkMhISfRXd3kSuXD5o4+y7t8sL7/LUiV?=
 =?us-ascii?Q?9nKUY87HveV5Ak2JyqbjyxxRXb6XHmUCmoFB/eDRM7QvXa750+j/ooe3lkw/?=
 =?us-ascii?Q?0V7mUj8dqXdxnslPv/LHJirQ0MtVs1L6GXyRY/l/zd1bTDxcwZcwB9B4hzvu?=
 =?us-ascii?Q?oD0KZisQC5hOaPy58V96wV0qM03tfMNoqepDxsG8sksy6c5O7nonYJFZDanX?=
 =?us-ascii?Q?yKHs2A=3D=3D?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40506be3-9fc6-4782-f0d9-08d9dbb09a92
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 01:03:00.6964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KFJWW+kuBPzex0DaVNZJDIHadSyNFnpqMGtAl5/eOm+bmCRV1Rb+41ALWO6Ggfi6+l/Ocr4wbzlso4AbwNvjg6sRZ3j6Jdq++5SC6flvIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1065
X-Proofpoint-GUID: drAP0TDSf0TqlH8SKNBeDpt5YKviUjkh
X-Proofpoint-ORIG-GUID: drAP0TDSf0TqlH8SKNBeDpt5YKviUjkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=422 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201200004
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Various fixes for the Xilinx AMS driver, and addition of the required
references in the ZynqMP device tree files to use it.

Robert Hancock (4):
  arm64: dts: zynqmp: add AMS driver to device tree
  iio: adc: xilinx-ams: Fixed missing PS channels
  iio: adc: xilinx-ams: Fixed wrong sequencer register settings
  iio: adc: xilinx-ams: Fix single channel switching sequence

 .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  4 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 26 +++++++++++++++++++
 drivers/iio/adc/xilinx-ams.c                  | 15 ++++++++---
 3 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.31.1

