Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13AF7A0FD6
	for <lists+linux-iio@lfdr.de>; Thu, 14 Sep 2023 23:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjINV1Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Sep 2023 17:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINV1Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Sep 2023 17:27:24 -0400
X-Greylist: delayed 117 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 14:27:20 PDT
Received: from mx0d-0054df01.pphosted.com (mx0d-0054df01.pphosted.com [67.231.150.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B001FD2
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 14:27:20 -0700 (PDT)
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EKVLYj008627;
        Thu, 14 Sep 2023 17:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=selector2; bh=eCoGjYgrIeqmiUMqBeQl
        7atQYUm6D6BADyYUFCNwRE0=; b=AosCwAwou09yMObJu0z2d4ywF9DWIfK/Wv3y
        8YuU+7l2Pzij0lvLY3go3Q8wbA3dmyIgYBUay06kjUqs0ynBkJfNVtZcFDsj1jJO
        8QwrxuUMuniOYn5DfTwfa76wGL+vP2vykrO/41CJEQJoIb/8ZJ/Xflb2IwYJaZa0
        4MOR+B4SnLVZxnx9MdwgI2Q/Tx7Mtg6tZQsFt2RKoU9sI6wLKAFmRJ4SZEFmE9Bm
        hIxnlQ5OJpXGk4CPysViFiHI3dMcEQ1IgfgZjAe0J4Q+47z1RSbjh67m/Ip1PF3o
        b2Hq1XS+lqlbTQKqKYqF5YLlC0+P/EuPy9UcawUZuuE3qFTH4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=selector1; bh=eCoGjYgrIeqmiUMqBeQl
        7atQYUm6D6BADyYUFCNwRE0=; b=XCPxuIxwAdZAXRUlVH/+uiV0SNukkGxFSKs3
        GHpW0RGkOk/eGUpfdF08wjwIDVGCJ4wZSib61zdd0/ZNGPF6gk2mzMAYdZ738PAZ
        1HNGYQwvLhIwmATdXHvZ/ermpTR+WxGGBWaxUer5w2niQwM3YhsGQ3PKWbLGVwXO
        x7FPtuj1oV31NLWKHc+Nm9Ht7IWeISBJmZR2kKtvMe2fTZPAaij4mEHIyvJbO4xE
        FOntMLNikaO0lP0XZDCn4+RmBKY8uk0lvWYskQilkkrW0SGoAdGqfy+wuSJuyIKC
        UasfgV4PgZCPzJGhBq4eMmiJGnFW2j+T0KgAfym1k1QwnWI0hw==
Received: from can01-yqb-obe.outbound.protection.outlook.com (mail-yqbcan01lp2240.outbound.protection.outlook.com [104.47.75.240])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3t2ybea1v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:24:53 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJK5db+EKIT+UcErXq61atdNJ+ZkWZ/BemrZ9/YsqSf37U4k+Vr416IIW13V6wfaQvPl+6pJrJOJ+W2zRLKxo1X0GJf6+cMCcI4g9OGzXw1j5LCKANQAo4y+34qCJ1ReFCwzx1FA51qIZp+4lI4ZrEe7N+y3s+9TNh73GaZtOwwkqEDtdXF7/l8lpFlCl4ff6xyqioEmZ4mhuF4EB1M+jUcJ7P0/e/2JPl787qinxzEdgkOf1o4sUreRs8Sk7R6BGnngwODVSAuYbZEbxBOdAoJUFSHKmEIOTVWoPledjDPktH2rDF02g7kOG64z2s3M2xEscbl5DuTvRWpaKoFEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCoGjYgrIeqmiUMqBeQl7atQYUm6D6BADyYUFCNwRE0=;
 b=IibG0a0WdLmMuybybYMs0LoVVosGFzEj3GUf7UW0zhaR5Dd7OCyO7oHVdIF2VxHRWDky9xw5MG+LMuHHv6otDQonHJKeWbBCX72JKD4hjO0HmSOeCgjqLtRqKW32iOoaFYDSKxy4fbD1na7leALDmZCHYWAUf+Yew+3ZfWc9CYlwwHy8v0YRvROZvS91EuWYocuyevFAFUup8DnF0+Fre3jPHOitXYnE//qo2Mc/BhzWksrOAyjrXP/b4xUCO/1h35vjXFif7+MvUfLOSufUyTDK6Jut2SPdW9LwQIfph5xLjmFEqjlp3d7saR19HXEXiYx1v+iN7fRoIlpx/QIbhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::6)
 by YT3PR01MB5551.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:64::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 21:24:52 +0000
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec]) by YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec%3]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 21:24:52 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@amd.com>,
        Anand Ashok Dumbre <anandash@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH 0/2] Xilinx XADC fixes
Date:   Thu, 14 Sep 2023 15:24:30 -0600
Message-ID: <20230914212432.2842010-1-robert.hancock@calian.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0122.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::7) To YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:b9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB8838:EE_|YT3PR01MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 28474e54-2e7a-4f3f-9345-08dbb569084a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAk6v+rTwKofBops0g0uvMNFSqTxrM5Nj8jUaKC09UYKF86RN+8bJJ3iLRsU8VbT/9jV5o2Wc3LSZqibzICgQ2xuv4TilyAH8ayt2h8JepjLFI9qwZRyhjX0XelvNgI8GAmu3QbBDsc9G5Q90adu7fPvOeurJuU0MC4vC4L+FTgF5LGQSvl6vmq4uIVvvImqW+GaRQmCW44glSiBIgFz5OiqQUZcZ4hPkGhdXxaz97NU0xllhc/I5MOcSQNx6k/plmqoTBlzITEveTCfECqAWY1fC4/SI9DO98eSm79mH0gubnWdn4cNiU0PTzDW9e5mqE0+LtKOL1E0wS0qtSNrFBEiBAUG83dh2jMTvgSt8aJbCqbhd0E0UXvPlvMM9dlHTr/ZgFzYC8mKse2DQSS35gMOjbSSpvgrxIMqiRkZ9eo4RtP1Hn/XNndS5TexJZqtaHDsC/ZtCnQA43MQLKggyDH5UfQLlEZsBaEaAM+3JBUTT/RwJ0uXVkW6E047KBlOf5oTsUA13SZskYiJifn/zQ8xfliEDmWj7fLwPagxND0EtQippbnyNp2GUDeXYgemXkjFmMEg2xm2CL1MI3IgIYv852hcK57VaelvhthNhSzhkDdng7OV6sKdxTHsJx11
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(1800799009)(451199024)(186009)(54906003)(6666004)(66946007)(66476007)(66556008)(52116002)(44832011)(6506007)(6486002)(41300700001)(6512007)(316002)(6916009)(478600001)(2616005)(4326008)(8676002)(1076003)(107886003)(8936002)(26005)(5660300002)(36756003)(38100700002)(38350700002)(2906002)(4744005)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ojj/inyywcdV4bX2GhiSsKCWQezbQ25bx3dcMzQp8USiEvW3QeehG5lgpLZJ?=
 =?us-ascii?Q?2sIcgxS/Z3QhbIykg1a9gU+ajKZFZGOTnQsX135stdDj0uq/bVveQYjXOTX0?=
 =?us-ascii?Q?t/aIdEPbLOXKUJNDvu7cB30pihGflhGZxZ3ksAanA7uTZPH79jvhAwxzQzfE?=
 =?us-ascii?Q?hvfmqVXaFNmrOz68LIHje0wklh468XD8PyD0fQEvZmoKd2rqaw7hiTkZ3ZBs?=
 =?us-ascii?Q?0OKtv+zblCGoDsAPtDVCvvsP/5h3/h534IdEIrBfmBhIngnNKl0Bw8PzCLnY?=
 =?us-ascii?Q?n27+PtgfRcuCQG090Agr7V0gnv9tOpZ0OoC+NWD9HAze+Fr4vKKAHyzlgtda?=
 =?us-ascii?Q?Nl5v4Jg/tti4scEjjW3RQHIUORVpv2w9MTqRCMGWDpgKoasKWDigT8IKe3Ra?=
 =?us-ascii?Q?EVZFtD9y+oTPSW0zxeGXsQuhjnue/ECh561g63so3vBs3PHjlUyBRcpnJkUm?=
 =?us-ascii?Q?IdqfgO1bGGxTohEMm0wE+gKTwWVbwRydz2ganIkIOBsbZ2c4Q0RjhtN2tjbo?=
 =?us-ascii?Q?D/v1eCJB+FcYcUthiodwXPuvxBbcZeqPaa7ClLLobS69YhZo8y/J+oIEp4Ze?=
 =?us-ascii?Q?47DsBoav1d+nidu6NjyV1G1dngpX18KhRYRwel4UT27J1HoSkoQC2rQffJat?=
 =?us-ascii?Q?5wzIPXT2ae8ujutujq2Y7sWwpKZXc5WJZdiOZnJdLjcPLBXVtqEJq6ONfg4H?=
 =?us-ascii?Q?uxyJRkBpDihxMc/CeSQQ55ZmdJ4ag+RzVVBTZhXbph78HtZGkZtlmDdbMDh/?=
 =?us-ascii?Q?DwLdo1bsjJ7RVjhRDrzPmigMx5XS+YIFXBCTCjHxP/nour/RxXRw//SnbEM8?=
 =?us-ascii?Q?+I0HEGo6KoGdDHXdti3oSYjbpmUwzKmLQzwgNHQ40ufP2UZnzuvk1rEHKTAf?=
 =?us-ascii?Q?ipLOGgDowouCVPbGru2L4qTsptD+bVGwqlWZ37bMWEBs0UVtVlEAdOigWpTD?=
 =?us-ascii?Q?um0o4i55x8bsf4DrQkMA+9vpk3cjUA/lQ9/j0Y2W6SPFPbQaf9JGlyxRiwH+?=
 =?us-ascii?Q?v+gglKdel3RnCsE2u8kB8mj5y+IoqbncKCVT5QjQE5Hs4GystISYi1f9AzhY?=
 =?us-ascii?Q?GjAWfG3+BxNUuokAvWHvqnJ7X86cTVD5U77VchLv4cT1B3BdmC0y/TSUhjC/?=
 =?us-ascii?Q?Fp3O/QEwKpFpNAiNGBPOsnyMj+ziCAGpU0egNaPtI7sT3owznxSXnSFnVXQI?=
 =?us-ascii?Q?Yq9eE1X7tFQL7vHbbCJ2cJKy4aULBSAt+tK5zcoF69d02uopbsiCxldosoqk?=
 =?us-ascii?Q?dXatNGnOCPhphJq1hUIGdrdQ9so+rgkIbbIbSAtnOwIlTX2t6tRlvIxWaOpI?=
 =?us-ascii?Q?IoKUwUSf0FSCdZA3bmnaNEmSATYkLwXuzr0VxqHZiC2O3Fl0NuPPzJ6EYuUS?=
 =?us-ascii?Q?oY7eThlVemwyyOVRETKKqnwu4KA3HiQgPAKYusVGisjnt234vyVCFJL8Fu1C?=
 =?us-ascii?Q?uuhdHCI72dm7JnrVzkVGvzR+3cmCwV0Gw3M7TH4LIyUl6nAQQVIPb7JjJeKa?=
 =?us-ascii?Q?c0XGHUT4pebCpbgDG6itwJ10k+JGoHGSSuT90Wno9TqdsyAXKt6OraIAdIhH?=
 =?us-ascii?Q?aU2nGjDkgwYF1BWbUFwPxIZdna0MilxLnFJxRlgsmZlFb9TM2TdyoH++gGF8?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BcXvWcQi89iK6F+QACIP11el3r3/3t4qu2Xu/RnyqEVgesEXseE0DKh7tmtf?=
 =?us-ascii?Q?4gTJEoYG5JlhOH8jJMBLcHy5XIISBRK+e9jigylz2d2cPXH3kbOGvwV5Kluz?=
 =?us-ascii?Q?NwyqUWbVYrtIhWrLOHrPb/2MSVACX52BSwua4kRi/OKMnGRrHU52hnLmechO?=
 =?us-ascii?Q?GAbUVvnQkUiSD3Wsvyt4ooyLN+LvtIRlxvdSnRHyqPlMVjUKr7thCwFbS6tl?=
 =?us-ascii?Q?NE4hIzR550i97nOJnG3+08HMDTni9H1ml+b++EK6nGwk9gMmyx26fMtZFUet?=
 =?us-ascii?Q?1SIWYYuMAEJC3mQ7OMpPZS6LQC/dFdIUfh2lKsbfVxr9eS3G4X38VEuhYekZ?=
 =?us-ascii?Q?EVi3hsGNCtUg5AhXrc7BX0oUtXD+4cfBZJvCe5CxGHILNh3F7/aA2NcYbGMp?=
 =?us-ascii?Q?Ma3MFY//sJr1isEgDcTsnJN/7SS4tjui4nsx9+dunUchdU0TnPQqrgylcQZK?=
 =?us-ascii?Q?YPElmu430S3z9Fl98yYiI7wFfoBeYjzIs0hDE6CSX8/u3jbW96DsNca6ZkPP?=
 =?us-ascii?Q?Pg56TtB2HC4YN+oLn7eLhR0zOSBXUJnCRLVUMSSMBGIBEv74KgbJn5Jhl8j0?=
 =?us-ascii?Q?kSwjqKim+RsBJbK7rEP6JQsGnf41Cpx5+2MiiRWdk5yHBZKNFojfVNEn5xEn?=
 =?us-ascii?Q?0Laxq7UZBGRo7PmFdcRoDxDDwiTQlEMGNJzlWwdtLVes1sVkYqO1158ZenB8?=
 =?us-ascii?Q?ITLfmACVNotensCuy7iQ0HlaLNItXajOZpqTSAsy1xQjtJXtmNiFVyj1pKUN?=
 =?us-ascii?Q?pxCGksLjrUADgIVFAcbesNSQF/WASvLT2tWHSsUDkoGu5/qoou7HbfgPaJbf?=
 =?us-ascii?Q?FiAr+w/y3faGa8jCENPmWXR5LX2/gV2V1axF51p0O0F2TS6TiGvH9GwTqNr1?=
 =?us-ascii?Q?RmjUVEKhgsl6+WOG2x0sl29BSNbFcST4oDPa22kTSKrCn1WWjVP8XLMeyJsp?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28474e54-2e7a-4f3f-9345-08dbb569084a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 21:24:52.0565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYB/is7LSpem3jnYf50mGXilR4chLA7eqqdZsHHR8LV77KfXaH8KAvQurTqWGeTlzj6zcbROclGPAOVKbLV2Jnb+Xzx3RBN1WzYYPYrVxuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5551
X-Proofpoint-ORIG-GUID: YeDgb7-PkayOdzzyHUZvvpheIiVHNhbq
X-Proofpoint-GUID: YeDgb7-PkayOdzzyHUZvvpheIiVHNhbq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes for a couple of issues in the Xilinx XADC driver: one where
preconfigured temperature/voltage thresholds were being clobbered and
potentially breaking overtemperature shutdown, and another for inaccurate
temperature readings on UltraScale family devices.

Robert Hancock (2):
  iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature
    thresholds
  iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale

 drivers/iio/adc/xilinx-xadc-core.c | 33 +++++++++++++-----------------
 drivers/iio/adc/xilinx-xadc.h      |  2 ++
 2 files changed, 16 insertions(+), 19 deletions(-)

-- 
2.41.0

