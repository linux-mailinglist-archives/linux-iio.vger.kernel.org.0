Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94277A122C
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 02:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjIOALB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Sep 2023 20:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjIOALA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Sep 2023 20:11:00 -0400
Received: from mx0d-0054df01.pphosted.com (mx0d-0054df01.pphosted.com [67.231.150.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BCACC7
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 17:10:56 -0700 (PDT)
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EKYfv1029572;
        Thu, 14 Sep 2023 20:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        selector2; bh=cvV3SGr7NUMuNzU4pa0q6hbI5Yc6SyPV7dc0PcqUuT0=; b=LI
        EEtC+bgiN4lP+JLW42WadGpszQmVFYuQMgHTLGwnJetyi/pVuEvggW2Y8lXjBLcO
        53V8M1POD4lgP+Z/Bb0Vz6UV4NkydvOVFXSiM54PzM2synVwZA5Hxwe/MY5YwDu8
        /hMCnBidgPBtfRWzz6T1fUYGYok8Q2n2kyGovJrXsGkHcK8ZP/LKiAhNinh0AfKL
        f68gAeyapG0c5Dx0i2/zaLqSQjIqOUDyvTpDV7z6SkmJVMEpe+aOZOP1VmSP/yVT
        eVxAOhAV+zYAn9oCaWgOR26D3F4G+clDjsF4uUkWpNwz+ttRNdvA0JCsBGc2aTuF
        gtlytTO+EhctmmyA+uaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        selector1; bh=cvV3SGr7NUMuNzU4pa0q6hbI5Yc6SyPV7dc0PcqUuT0=; b=mH
        zDRia4IReiaemm3UB8VOqNhtqke0r+lIZhtR7sFMVq59blHMs3vAWEWKC1T7G2me
        sBXNHeJk0OW1lisdvcgCO6Yc1COLHlhRY2SrS1Nm8rV1bDCvTv2Q9oFv7Ph/7yZT
        suTDwAKTVPvHdHbPnre2nn+/spsC3prJ817GJPOp/B1DlhdYuSMhUanWUS73Ttn+
        i3HBTNH1JC2nO/gg7g9ipmTW1X10VMvcLOcJwXsbd5fcYH5QlUaOehq8vyMsXFXE
        YLQyuOgUqbvF6EYGs4sCb+LFC5PUUtkOIhDX4ThWmWeZkO/e7bbbIf6j9x0D13tx
        8Q6wQ0bh67C/Gx15oH5g==
Received: from can01-yt3-obe.outbound.protection.outlook.com (mail-yt3can01lp2171.outbound.protection.outlook.com [104.47.75.171])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3t2ybea4rt-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 20:10:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpQnAgD7FGOww5JhPW7688UoJ83B9hpf9U3ooVcOczEreRKL2pBErxuqiObyKYxPTvdrR0l0LWWLQia4tbjy0x6cSg0x5d4oiHvlOoVbjWY/uX3F24n0ixznC48ASTfUCe/CAZJP8Gw0I/hGXKY1QcycKKKJPeWbj847Iye7tiVKIh6TnEbeO8r7pMv01mYZLHjfDPBRwAu/Zd2iZhzj2pZK4eYy3GL3m8EjKyXm0awzp1yloKGnJIWDXeSjwCR50xoAIG+gR0mXzWAL9ZZoaxcYCs0R4k/BcbNnUKl8PDnZEna7DhUkp/vJWHha5LtYMUq29fLv/4X5QCkMpThJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvV3SGr7NUMuNzU4pa0q6hbI5Yc6SyPV7dc0PcqUuT0=;
 b=VgHhMbpQcZgzNWBFqzhmyv1FlZNY1Ifa5MEDR6MHoFA1bw1bv1yOTPmY9AujShHycnLTBAc3/yeRm0j18/yyLEwDV25VN64Yiv0GOsJEnnpiHK5arJFcWTpDF2IluMqQvHjGbM2eUXoN+t7UxtiWkAgtNTeRZs3GrHfiN+I6a4qPhTGgl6Rr0DjGKE0pWVukkX5ulL04Kq9OoLkdmJlWKoPzsvDBptUmT7H5OgnwjsYRrO4BRqamM17VvVZuGoCi1Y50bh3twtQIese0O0W/+BJRHoghAuFK9ugl/Owm+UHxjDZZUfXdfTB9hYfTv/hoF2cbHM9DjnkgdDtEQ2W8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::6)
 by YQBPR0101MB8912.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 00:10:34 +0000
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec]) by YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec%3]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 00:10:34 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@amd.com>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH v2 2/2] iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale
Date:   Thu, 14 Sep 2023 18:10:19 -0600
Message-ID: <20230915001019.2862964-3-robert.hancock@calian.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915001019.2862964-1-robert.hancock@calian.com>
References: <20230915001019.2862964-1-robert.hancock@calian.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::32)
 To YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB8838:EE_|YQBPR0101MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e9e651-1a4f-4bcf-3464-08dbb5802ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQPb1j3/qcC8meKJBg4l9qb6Nvzli7gBPA1nLMGDHHjdQGB+YOp4SQ3/m9iJbMaN+lP6APvctviyg8VaAm45FN2XwLHhy5t0t1abyTKbE1qXMjGJRjHzVCPLPvV3SM7ZBOczFynChiGq571j5nSsXeMuuUjaK1o4rRDiAdjCA5XMKl+Nya218C/K2DTmODWNDTDNxF6ndjRfyN4mljFz3rzeGg7LWo1OGTK7wYV2JRJ9jtRWnefv/aa0lTFsamCyEpeMSCM9GzHoLMQx7bvxw4sG+4UXn9whEOkJx7ueC1Zofej8/By9becpPN3RRr25AlXps2zXii5Y/hzZNjNgzdJDH2hBszkji7zrA+9qPBUuJP6uTvjBLZH6B8Qk0JAiA7xKl8MuCBjCJtpOylCHoX+mpribEcArkrO+8KqwwZyI4UoJLqN9aVv3V3Ttu4IWClz5qK3oa7sBuqhiiAqjcexiGTTjZmb0hbgZD1nwT74Hcl68rVTCpiUVWTPrUJhX6/SVl8fBd+NU/h3ZPMXVQ7U2KjVT95s9swVlaLDwhZkDd5ec5bP9CPOQDWJo1l/tleIA3xAfJOq84kuyrj1hozJusmYyaCzUQilMnizHXqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(186009)(1800799009)(451199024)(41300700001)(1076003)(107886003)(2616005)(26005)(6506007)(6512007)(966005)(478600001)(52116002)(6486002)(36756003)(6666004)(38100700002)(38350700002)(66946007)(86362001)(66556008)(316002)(66476007)(54906003)(6916009)(83380400001)(2906002)(5660300002)(4326008)(8936002)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8E1d3NvQ1cXkTpGtoOzD3UVknk/M8yQOgwvlWyNpV7wdhlpw3PzFoMW5o2Fd?=
 =?us-ascii?Q?CeLpT7Z2w6clCpwz0aZPkHmz8PAi0U2FyQesqri1sIIej0Blvb9N9L+J5sg6?=
 =?us-ascii?Q?LKqA7+yLmjdi3vdRksc589g5BQbQKFQ009acb/NqIEfro5/Bi09IWGiFxDxV?=
 =?us-ascii?Q?449cUPD8DHlvIleBqNpQGjghNPwhxUfCqpqcOpQAEcsxkAp4Fny+XRqwcx4r?=
 =?us-ascii?Q?E+Pc7j2dlGEtZYLbUCULDeCcA/xmmSPg6VTGW4dsiX6aEBxRX77NMYlgSXgL?=
 =?us-ascii?Q?Q2YOgzEy0ovFyKqTq6dSjDgGBDSZKsw1C3H6ZLDkVYXVILXionNfNRtAG+f+?=
 =?us-ascii?Q?1WW2Cinp0vPYV/mpoJXLazXYn2btA15hOP4UtY8UqstAbtk0/hau5ac/euyN?=
 =?us-ascii?Q?nfStIKk1CgFdq/5GZnYvajw2WaJtF9RH6z5/ClAp9YcnYMTpdr6Vf2vkqubQ?=
 =?us-ascii?Q?sepYpXdiUvBV6B8+aapvDldLBAolOozVCsrYhzw8vE/ybccHvYJ3A9CR3vaf?=
 =?us-ascii?Q?n/8GofG185WxayuKupvCsahx1FdubBgYH7nywh3aHVmt9zHu8KXymJsOaswa?=
 =?us-ascii?Q?B1gaY7M1MFu4k2zLVRka6QYaBGRax3M+iFO0yXp9OIf5xu1IvKuFdIabqt3I?=
 =?us-ascii?Q?1QGYHffb8TqcBctUL84IgoIB0NHGDaC8Jbnb9omZqnxfizgEINTyE66DL57S?=
 =?us-ascii?Q?qM/ViWa3jDFcmX/0EX2XT78FqGFPDzdJfsHIExlUQWOzmLNJ7TD69th8M203?=
 =?us-ascii?Q?djs4f29Ym5OOym7O/d+BPBMfrH4Ru/b2u93jHXSvebFG2mClSELn9mTcuWqs?=
 =?us-ascii?Q?PbRZ0r31q9HgRVKMUi7km8Ctao8Q4PFE5rnq58sHzNehZtGTtwt/Bqt1XYAD?=
 =?us-ascii?Q?MK06XWfgjCIeuDO9anJa8KG4jGqS7wMNQOz2iJ3w4jEXC/p1gU3rVHYvPbC7?=
 =?us-ascii?Q?DGaZVj3+QWiy521/sqUUKQWHFF0XGHwTor64oXtZEU5dz66bJTTC/tCSQlP0?=
 =?us-ascii?Q?pe+WFTWtx7nW0ta6rB2IZGFvs5U38FdPZW29BhpDJK/LRcjC9b+IEOFe4ciF?=
 =?us-ascii?Q?8ILHDXmc9uzzQS7jBEDMx0fcsApuo+BvG4WlRrdb7kGTeODVLNtozbDbA/y/?=
 =?us-ascii?Q?3x/kdTgQlvik/I95UQYyGtq7T7x55TzNW7KIktMz65CQ9wxSn0l7gfsJf7pF?=
 =?us-ascii?Q?d3N6fQjjwGl2EDdXLPKKvIAoZqAGCs+c1QKhLwn1TqPojbJL/bLYGk4q8cL0?=
 =?us-ascii?Q?3oBvQNDa3bpIlIiAjQ1xP5+TYRPHskNEBPfrk8+ckzlatmaZdLGbQZcwmBDF?=
 =?us-ascii?Q?guzITPH2VGyOuo2ChkYTP4KFVaKhQMNmcPq/3AQrsW0Z0+2g7yJPmOc92kL5?=
 =?us-ascii?Q?g3Xe3/jNL4ujqp9FsePUgN4Zw/7AgIs0SJscmhXWcthmpDN8uO8/1vtcFk6U?=
 =?us-ascii?Q?Ex9Q6SAPHarQSCMCUOnN+vLyuNnLDzA6VaaL2cxchSR0d0R8TNnlailrYlsC?=
 =?us-ascii?Q?YA2jCdNES9VcZVnOr1/z+fRNhwUbrNqtMbgOIndmvZPe3j+JCUKLLvYkV31E?=
 =?us-ascii?Q?lQgS1qZmdGy5883AmBQRcP4U92n9gWdptXIK+/lMmwc3UtqWFJ/latomTebu?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eqFJYTgJw2q/bHE5eZisiW8nqGPRReFg5eaLYo0qfjDAkwkmhKuebPxLLH/5KENb9aEtF0cY6uWGq28e2Crd/vzYDv4pm81hf8bAHMkiRp/TRg9NHlBq5hHsXDnp5unEE1DeakOar8CLpzUQJW6lPA/hVoYBJQD5vOsYTS2bOHlRC8wcNpODIoW9B/V7CdYwrla2ve111eUPnlyb9f2SrOht28X+fM91mWTL6mUcMrQc2AKWzbktILbIywIEeg0lO1+ZQ3CQCtmMrMYiN2OdWfqrtwrwLpEOoVGJapc4MYmgKX2ar8qMOls0jn73EnU5p1M6AR612hCwK4/yv5r/FqkLMPGmfFQhs7180laBx1Yk8fndTzM0fsObGmYSxZn8+c7T98/SjMucezHe/9gwB94J5I0kIBg1xa8rVVL8Yx+NxA2LFbc7XuHX1gBL0K5o4riEOzQoJqtI1FSALbAKDCUfy0ECHkS7jgD5fCcmfhObSQTqVvZdeCVsOhqRkK3TlACpx/lh3zJv6Az4ZSdP8NtESf+1n8Hh8o4pOS1e+HElyuIr8b71LEVxEbE2ws303OHppfo01jCup/H/rzabXvoAIB0Tt2mWIOnCWhH8sG07JZ/14jT8aM/EwBlRo8bdzF2QMQs1lTkALrn56CYhuGFyXiJLsPvnFGxwYCsA3347UbEtSbWhqRlq07IxfWmsR5efxOmI4mGoA8Pwfo/cS4D1xReEUMOVGK3d6VSLdA8c3/1wTdzib1m8zD9EVX+WWJ06mcwQTmURaa4lpkOThpw+238ChMHpY5GoyWOS4vQ3fufEkUdxqj0h+q1t1IUjWxxXv6GX7W2WoNnCWGTOJejV4AYxYbvsQFT+bRl9UuX9yPLr+YGfJFaVI0Od5v70ipnBp1IQzkVDcX+vHEa4IxewNx/sweGNR4RK+6GHs28=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e9e651-1a4f-4bcf-3464-08dbb5802ea4
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 00:10:34.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOP+DVOvr/oYOXY4Y+HJPANVPNqwtS0/c4PYP2I+A29GWxIfbcCTdir6IRqgjOIr0LcF2JLCsxqTUxFnPCb1pbEcx2BeWW3V0OdEL8axe+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8912
X-Proofpoint-ORIG-GUID: JIYgE0Grw_-Hg5L1-lzkPBBODYo7McBT
X-Proofpoint-GUID: JIYgE0Grw_-Hg5L1-lzkPBBODYo7McBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver was previously using offset and scale values for the
temperature sensor readings which were only valid for 7-series devices.
Add per-device-type values for offset and scale and set them appropriately
for each device type.

Note that the values used for the UltraScale family are for UltraScale+
(i.e. the SYSMONE4 primitive) using the internal reference, as that seems
to be the most common configuration and the device tree values Xilinx's
device tree generator produces don't seem to give us anything to tell us
which configuration is used. However, the differences within the UltraScale
family seem fairly minor and it's closer than using the 7-series values
instead in any case.

Fixes: c2b7720a7905 ("iio: xilinx-xadc: Add basic support for Ultrascale System Monitor")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 17 ++++++++++++++---
 drivers/iio/adc/xilinx-xadc.h      |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index d4d0d184a172..564c0cad0fc7 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -456,6 +456,9 @@ static const struct xadc_ops xadc_zynq_ops = {
 	.interrupt_handler = xadc_zynq_interrupt_handler,
 	.update_alarm = xadc_zynq_update_alarm,
 	.type = XADC_TYPE_S7,
+	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
+	.temp_scale = 503975,
+	.temp_offset = 273150,
 };
 
 static const unsigned int xadc_axi_reg_offsets[] = {
@@ -566,6 +569,9 @@ static const struct xadc_ops xadc_7s_axi_ops = {
 	.interrupt_handler = xadc_axi_interrupt_handler,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_S7,
+	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
+	.temp_scale = 503975,
+	.temp_offset = 273150,
 };
 
 static const struct xadc_ops xadc_us_axi_ops = {
@@ -577,6 +583,12 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.interrupt_handler = xadc_axi_interrupt_handler,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_US,
+	/**
+	 * Values below are for UltraScale+ (SYSMONE4) using internal reference.
+	 * See https://docs.xilinx.com/v/u/en-US/ug580-ultrascale-sysmon
+	 */
+	.temp_scale = 509314,
+	.temp_offset = 280231,
 };
 
 static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
@@ -945,8 +957,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 			*val2 = bits;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		case IIO_TEMP:
-			/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
-			*val = 503975;
+			*val = xadc->ops->temp_scale;
 			*val2 = bits;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
@@ -954,7 +965,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 		}
 	case IIO_CHAN_INFO_OFFSET:
 		/* Only the temperature channel has an offset */
-		*val = -((273150 << bits) / 503975);
+		*val = -((xadc->ops->temp_offset << bits) / xadc->ops->temp_scale);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = xadc_read_samplerate(xadc);
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 7d78ce698967..3036f4d613ff 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -85,6 +85,8 @@ struct xadc_ops {
 
 	unsigned int flags;
 	enum xadc_type type;
+	int temp_scale;
+	int temp_offset;
 };
 
 static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,
-- 
2.41.0

