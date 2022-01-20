Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826DA49454A
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jan 2022 02:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345541AbiATBDf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jan 2022 20:03:35 -0500
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:63622 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343635AbiATBDc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jan 2022 20:03:32 -0500
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K0VdmY010083;
        Wed, 19 Jan 2022 20:03:03 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2057.outbound.protection.outlook.com [104.47.61.57])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dprrpg6d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 20:03:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/dTbgVlVUsMVQnh51gY+81FsJ8ns+faIP/LNCFnpd7nkZrp3cS8uLquMLQDjatK6rtU4Oz9hVJr+F+xqrseMgbii1tAZr5ph/frd/dwQV/Yd4r8fQ1D0dhB1zxWqkf720mBNgC/FmDBoYAvEHvCBsAdeifKcTa3C3IAEWZSqJHk3uDdupi42VDdOxWoPzDSc9aXc0js8IaBDTOr86xQzGOe4s2UtdmJeCRa8g2eYwTP+awLLdqLkAeZd8Uk7cUcXu5FFLnm5crN6Lgvnk3lVxgsG2fR/OgQaFshLFQ9KQCw3EjVzGfKL0vRwYzGiipZviNfNE1nqzM3Xb2t73rMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fB66quH2nV7CUAm3/KsokulfFN6L1HYF7xjuLqSRfOc=;
 b=Jxf3hm6PYDE/SArPLlZUfqbSvL6d4HTaf6so13znST9cNhUJfEJee+hsUcGMvsDmzKsGeO8vh5YneHby5DpgQklOYnUWrLf7/68INGa6u4GX4uKsfoV/vPervbdI1MkUxrkCLYw+g9qCwjGHLI7h1UGmuzcgEb7LhhA8pW2OBlpG4DYef2YAHEKNTKLc+kKTiZRlvOF6et/juoTyLib4TFmNreYpAQdjC4tQmIsH9Lw9nExtOyVW3U2cdOl+cldL3iks79umI5S7jIyk/VE+xssO3WKoCX3SP8AQBELft9z2ZDRU8i4AudxJt1FT3FRjEZYBwFK0fsBx710xgMFtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fB66quH2nV7CUAm3/KsokulfFN6L1HYF7xjuLqSRfOc=;
 b=10qvUbD5gnOKdz8qtT9b4Wbsj3ND5Z40iaU4s7DI+8Aqv6YraOBRk8I0puYQObN27CwwhQSjiTmh40z6KtoFbbztetw7ZxYmi3QrdBAYtk9tYluLTi5jgjbNqrQ2D4Wcw0s3KYqZIwJRCdK/nUOjU0M0oKlTogVIcZ7qXVH3x40=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YTOPR0101MB1065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:20::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 01:03:02 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 01:03:02 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     linux-iio@vger.kernel.org
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com,
        anand.ashok.dumbre@xilinx.com, jic23@kernel.org, lars@metafoo.de,
        manish.narani@xilinx.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH 1/4] arm64: dts: zynqmp: add AMS driver to device tree
Date:   Wed, 19 Jan 2022 19:02:43 -0600
Message-Id: <20220120010246.3794962-2-robert.hancock@calian.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220120010246.3794962-1-robert.hancock@calian.com>
References: <20220120010246.3794962-1-robert.hancock@calian.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:610:4c::18) To YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fbefcc9-e5ce-450b-241b-08d9dbb09b7f
X-MS-TrafficTypeDiagnostic: YTOPR0101MB1065:EE_
X-Microsoft-Antispam-PRVS: <YTOPR0101MB106562E489EE6F42E6826D49EC5A9@YTOPR0101MB1065.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFt2BQgv2sn9ZqGMEHf3ecUM1bTzpQB8UixZ63AhrNMbEo9VWOYUrhQB3j9ynUBXyVkTIZHY6xmOhS4n6lDR1O9P6oQai7ayUIYhKgdogcVrUTX0luFle4ZOK12CugFbU1196pLoO2U8jQNOmJtsOReReXQF+EEwwn6aZj5dLAEVoW2qkJ/iRp1LrAbb2OxiJHZr0M6KiSNFbHbpMGqYiVlVxFowgpJehybMrcMraznzJeKlEp94/IYUrVQ3Zv6tC+3Vskx7a/C2t9Sk9YDTokK83KTt9rVYat4kb1CcZcS6NVembqCXIs+hxDvtXNqmcGQ4FjNe446V8boorZDTNQPEy1aAk70UaDTJvhz1Gc1o80AOnP97lufZXMyAt6beOOcDe1lTqcZLn0F5MfjQqxP3JgXnTnYbkm1yz+TVYsUX4k4D7CXneNrD2/BT4+tLk19NAH9lj55uw/myPDs3Up829K2NdYbaVUHGWrILW4Z4ZtWgQsNwSnvFM1TX9ixXkdj6PbZNJqlxtU4pyqnHTozquMRoDcKhf0PJW9I9liMIjYbLORM6ksUtmq7OsuRp7g60bZj/oslyO9KYG+Y5aUcvzDEkO0+YIIHQD5X3zkX6jWv+Xz7SKNsw3CQSS2+Y05YsWOpfmFrhFXoQD9hO/wLq/ymRJaw4q5x+hBvxP83chLTOGMVmU3J3hjnnqLg6V5GzvPpbh5i/Vk1vJcGWPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(44832011)(4326008)(2906002)(66946007)(66476007)(66556008)(316002)(6916009)(1076003)(6512007)(38350700002)(26005)(36756003)(6506007)(6666004)(38100700002)(52116002)(5660300002)(83380400001)(6486002)(107886003)(86362001)(508600001)(8676002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2J3R+TB/wnPFQX5llLt6eySZzkncYdSfIXHf8yQbirC+WPvJ8FYJtJQKBbz?=
 =?us-ascii?Q?6zIgFw3l5/4eh8NiO2ZHNx9VhGrgoIfSFh5FLaMf5TuIOcuTmPclSNheoOLJ?=
 =?us-ascii?Q?1ufFJgoxc0MEyhtrT2VpkM9p/O5fvgKKCQ6p6SPGmIMQUd2Ae3xW5YvQ10bP?=
 =?us-ascii?Q?RVsDID8oc8zgi07IAo3m+OJAc+CEFfHBxnZHuOYqCQU61iFO6196PJEQsTgn?=
 =?us-ascii?Q?3QjFuByijXEFegoiOLhPEp2XRMML35TzcBbPetyWQZiBprDT4AAsLzCBA6/g?=
 =?us-ascii?Q?ypVMkesTBLsqqBgoHmvMjgRWkMEYLA6XH5l+GoQMFv7K/nmRISpYtlvlmLX2?=
 =?us-ascii?Q?c5gzwzId4LzV1QH4joAnbAjBLEXoAfsCwy+l1Cpw/IW4hMuodKwAESFMVwXx?=
 =?us-ascii?Q?e9sdvUcHeKJ5GSBB7lOXu9D5e7n4cldluuPTrfVIR3qyqreNNS4vobVlUdjd?=
 =?us-ascii?Q?OHlTCqKmLKesGXLO2lZXs8ojlSjo9rSGJkk73+Xio380Xat71WQq9+r520tP?=
 =?us-ascii?Q?JTCZRzpjkwYjkHhzPY4lIhoau/Cq7udNP/ubVDxlEFc+2keX4LJZcJivnepu?=
 =?us-ascii?Q?2s0CRSuxnEy1XJDL3pAcBQccJWzAvMPG7JWq4lKbIgCD6VxTKqR8aWhulzJ+?=
 =?us-ascii?Q?Pl3ODc0mf6GQe7SIrZIf1iXcBrQvQOwCKmxzXstZPezPJKxnr3fJabgbhPnN?=
 =?us-ascii?Q?d6zT1flsx9HTlGD5YS1vPOAmYgWHXMejOHCQk54Rt2QlJDkIswSeivvLGnKB?=
 =?us-ascii?Q?s0zXQdKRaEtOyq5htH0ewNa1MfEDi1sDbApEs/2saaewVnURQ0N/jCyuHO56?=
 =?us-ascii?Q?sfNlzcmJoD0Sdn2gWfQUt1gK8H1/wnXt7i49SnOujBjISmLnY0YXKGqafWsr?=
 =?us-ascii?Q?JZu15UmBg50XZr+DxdFtEaGbT1zLAY4Jl/4etZqa15VLH5tDNqMnNCboEu+w?=
 =?us-ascii?Q?xh6v/bmyVC0ooz8lMAG+dCVrS9VpWCTohJr0BOu5yvBo3c+vhuW+vnpCcAv3?=
 =?us-ascii?Q?DkmWODyfrLEJeTTVfQRqe3tKcEaq0xEnTvej58j4AV3lJs89Tp/OoaIJpRic?=
 =?us-ascii?Q?r4bfCArvPLh3L3GzVBAOHLtK55SmyS0tphuQjLeMpfOyy1IhM5rYqjzPAAX6?=
 =?us-ascii?Q?fyd6a0uUUfy083jsmF+PQvMES2H+l8sT050F7E2bysaFzM6HcQ7icbA6zVlU?=
 =?us-ascii?Q?WQg/GUWrpbDp1AajBl8/oLLK5ywWCTYJXQJL6VoF78BCxq2TPKxWjApJyVaG?=
 =?us-ascii?Q?pocp0IF17IrL5uYF0gCsEqlhAWs5xj1CirIaKEvGtK2ZikJ+Udpata1/OIS7?=
 =?us-ascii?Q?LGj1E+blZ9eMvT9xxIb35Jl+tTWpeROkfNNt6RXkD93z/Gue1qk/YCN104S6?=
 =?us-ascii?Q?vnvZUEeFZcuO5sigBZnKtOLb0XuO4YEuFWk7tuxmrTxMHwpox/ofuXKIwu9R?=
 =?us-ascii?Q?3OtAj/brqb76y0k3KTbr6AQAn99DWSzcfeq+fBRolPwo513vwGaMe0uNvCUs?=
 =?us-ascii?Q?0o9pMvraCqeIKbkG/shoM0ZC4fDp/lIlAmdmme43uJJfE+wr/RjupQzKQY7P?=
 =?us-ascii?Q?Z2bFghS1rviTzQmqdpESYFCQix8CvNeX0+GemFHz8oDxGow4bEr6Odibsb+H?=
 =?us-ascii?Q?Bv8USuvKdWQoBZ3x6imAeB2Vu/hIwqSEWKTaikNiH9IFsUdw8DMCxpWxoWsT?=
 =?us-ascii?Q?jmXpTa+5Jo8dJfkVYLJitvE0LnQ=3D?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbefcc9-e5ce-450b-241b-08d9dbb09b7f
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 01:03:02.0569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwfwkZW73V/9ztehgXuOX9d4p33Ea1a46OPM5IkVwXMePZkupQ5M2LuH1gsXjFZN+MKZRsPPbr6otdo5d0Myh2JAng3XKsvCgkHSufdBCYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1065
X-Proofpoint-ORIG-GUID: kdce35B3AVHrTg3LjpMR8BXf1hI11FNJ
X-Proofpoint-GUID: kdce35B3AVHrTg3LjpMR8BXf1hI11FNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=727 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200004
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add an entry to the ZynqMP device tree to support the AMS device which
now has a driver in mainline.

Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  4 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 26 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 1e0b1bca7c94..108592104a1b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -239,6 +239,10 @@ &lpd_watchdog {
 	clocks = <&zynqmp_clk LPD_WDT>;
 };
 
+&xilinx_ams {
+	clocks = <&zynqmp_clk AMS_REF>;
+};
+
 &zynqmp_dpdma {
 	clocks = <&zynqmp_clk DPDMA_REF>;
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 74e66443e4ce..d1fe1e5b46c1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -878,6 +878,32 @@ lpd_watchdog: watchdog@ff150000 {
 			timeout-sec = <10>;
 		};
 
+		xilinx_ams: ams@ffa50000 {
+			compatible = "xlnx,zynqmp-ams";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 56 4>;
+			reg = <0x0 0xffa50000 0x0 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#io-channel-cells = <1>;
+			ranges = <0 0 0xffa50800 0x800>;
+
+			ams_ps: ams_ps@0 {
+				compatible = "xlnx,zynqmp-ams-ps";
+				status = "disabled";
+				reg = <0x0 0x400>;
+			};
+
+			ams_pl: ams_pl@400 {
+				compatible = "xlnx,zynqmp-ams-pl";
+				status = "disabled";
+				reg = <0x400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		zynqmp_dpdma: dma-controller@fd4c0000 {
 			compatible = "xlnx,zynqmp-dpdma";
 			status = "disabled";
-- 
2.31.1

