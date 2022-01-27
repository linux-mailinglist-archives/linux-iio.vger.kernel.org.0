Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0140649E91F
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jan 2022 18:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244675AbiA0RgC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jan 2022 12:36:02 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:7622 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236618AbiA0RgB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jan 2022 12:36:01 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RCOsjW001451;
        Thu, 27 Jan 2022 12:35:48 -0500
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2053.outbound.protection.outlook.com [104.47.60.53])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3duu31r74n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 12:35:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnpR+M3lZBiB9dLK+4v/FZl2n3T5QCu74NLVBb4BmSweLu4D4WRs+/ahjwqH8tdz4E89rMMN0yCS/x3N0RPRh9GxIJ0XRdCcuQkjK1DGzhpxtUFFrl9jQD8/Mabyma3k2cIEPW/v4ZZlajzrOl/9P0aAPYAgI8zrSPOJ7K2x9GynaOK2EhsMNarag1O6/hdiDAellhz65iRf+G5VzzoulG9RjMOwEKeOk+XPfhxNYeF1JHBNInk4EUkrbsV93ArSxNSBVNvD9k9mXZuHmVOrs8ZAZD0k3wjnNbamstxxQDbsYcrjzjmqlNJQtaV66MWSn5zPnBnm41+/Ap2vm2EelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcsjyxWh/DTTaKXBl2LFs2VaWIoIILa84jHZaP7Mfps=;
 b=GARBXxSBOq4ql9hMYdyGCBOohZQh1GifujHXZnOWs9YRMAKHUMD137Qoaj78t8cMOLdo1pPthXDPUsrkZPMXJ/SELPU5FJJJJlbDGGs3NnO105tK7kgNO33En36EqMizvJofDKy8nk3v4TcKK5ZqOJxF28neJePvtcwouFOh8OG/mF4mmGm/OT+N8Q6ogesyBW/HDOPmZO73YGtikKR5mXuXCwUyWIevbMrR1weGDEotXfUrfiEtVFF19VOwb4Ei/ujKs+eVstzPEX7cvF1o9gflf5GY4NRG9xfmEVrLw4fyTRl+XVQY/L2uHz4X523/F5d8M5wDb6513tscjjMuGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcsjyxWh/DTTaKXBl2LFs2VaWIoIILa84jHZaP7Mfps=;
 b=B7cL9X6ArUYu+BzhPVCqbWw7amQuaQfFJYrntIL/nuiH5XPDiLMm5UblBgwINU80vC/Om9t5WgVEGj2b9dTTZlwwlNGnuHhHWJBaa3r4hwOrwfg0TL971AvRpzV+mUSTlYJKpUzQhEmxcLFNYL+8yFtHDrJx4CNVu5TxTfbHetc=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YT2PR01MB9665.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 17:35:47 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.020; Thu, 27 Jan 2022
 17:35:47 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     linux-iio@vger.kernel.org
Cc:     anand.ashok.dumbre@xilinx.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, michal.simek@xilinx.com,
        manish.narani@xilinx.com, devicetree@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: zynqmp_ams: Add clock entry
Date:   Thu, 27 Jan 2022 11:34:47 -0600
Message-Id: <20220127173450.3684318-2-robert.hancock@calian.com>
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
X-MS-Office365-Filtering-Correlation-Id: be077b24-29bd-4a49-5881-08d9e1bb7402
X-MS-TrafficTypeDiagnostic: YT2PR01MB9665:EE_
X-Microsoft-Antispam-PRVS: <YT2PR01MB966583D764A4C8BE4B4BAF89EC219@YT2PR01MB9665.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1L/Ig7WcVZhMKUtXVlmhA8TIwqsv5GGaYdKkMHjC50OXQ01DdaMZphS6iRQ/rqDDYIGijPZyaIvfNGAZA8wq/0+qKPOkHmetWmPX4J9C4dCNQWgzMFVNFNEtZyOHoFqLWMdlDiuB4gus4xum5X1JrCD/ot1AdQ+Cdm1qaZUxyjR4b8QN6VF2tyYQ8YOD3xknVT+b3uS8AJZfCaRz13GQTFVjMYKFRd5f4Xd4JeJ0odnxhmYAXeTsjSSbN0xelReYUk5Q3fLTrbNmAWj6dS6jAbqwQ7++dr3GyRJDXc01akC44RIE26M1fRu4r4REW9E/InYRodWmtFlerJ8qKXVBqPOJU/VTPhd3uYSJyowfK8Mu8MBeIr7d3rwKXlvVcDKTMyE2/1O57FhEUR2Djf3bZkaDBg17j9sf1VCduAw8jVbQytYksf9SNUlmmF0edkDJQwC/OLIZNMdIpA9NQ9q/dCDatgWCUFar3k8+thHTi4rbBM6uqWHVhgx4J/VSYvE9mSiYuvSpoMu1LG+10RQT9yDlpM8fJyzYW//6nKW8sciTah55DRgR6IjjfqiP5/fjxJ/M9wryV25C8wd+e1EzE9yU1zUJkCuUKwKkBZf6Arlff+EKlO/wLDgZnB+VhVOMBVQF1yjvqT3tUYIXd3uSt363zPC5l8/HjH3sdn3ZNyb5qohRyqab6X+ubCvAglQH9bEx2DlOggJrPju3E+OFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(8676002)(86362001)(4326008)(6486002)(66946007)(66476007)(8936002)(44832011)(6916009)(5660300002)(2906002)(107886003)(26005)(6512007)(1076003)(186003)(2616005)(52116002)(316002)(36756003)(38100700002)(6506007)(38350700002)(508600001)(83380400001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fU1rooAhkOdbWpvKqFXzcdvcTdnSmahW03HvFB4aQp1VveAqgsiWLxR+1lFC?=
 =?us-ascii?Q?lQQcs8xAJxyidG5XkmoZ7zZgtJ3dRxuziU6n5ce/UIeHKZhtXdGiEWMbe8Sv?=
 =?us-ascii?Q?8gkyWJcjSHc8fiHSUPtS9YaQUPDhkmoi8QOj4hDHXsJ6yck9lNJz6ql9frpi?=
 =?us-ascii?Q?0wU9SoIe3HGFMfF9Z5NPGMKTZLcW3PB1HPftbAvpnh9wDPVNR/6BzaW1fsUT?=
 =?us-ascii?Q?lpIPH5zpxDy1EaqsMDqQd/Gtxob0BmmANF1zQvW1JiTTeh4uneu3UXh6cKeG?=
 =?us-ascii?Q?MBQJQF/Lxn+wQ5VjyN3tgSG8q3DLflp93fhCfC+vwSxxH686bXFDgZy7GF1b?=
 =?us-ascii?Q?Osg/fPv0AGb59RlcPzl7fMfjQwZRhWimjXDFBY18R476RA2LYTkzAtrFexCa?=
 =?us-ascii?Q?PAfiv9Df+PkOnkbo1vnxSqb2kba2ZXlgDc9aul+8gGnvL1pURYApQ5nAeEvC?=
 =?us-ascii?Q?osihy6vT38G9uLrFDbieokPbz7hCcjYTHJZ8rh1IU5DgCRKaBGFYGrF/O21B?=
 =?us-ascii?Q?qNVOsaPtCqvZ5nsdKxwbZviniOOR4evC8VY5SvYYXw/EWh4+uG3OYVh/+9S5?=
 =?us-ascii?Q?WDeXT42z3FZkpDQlUsvTVbNnZgOSecoZXAaELwvt++ia+XpqFgYxjhoiwpr+?=
 =?us-ascii?Q?LhquUxOumNX4/GIWHAgUelfJQ8NhragcCSgh/cxGuArNAVahxMIPgGvRAMjY?=
 =?us-ascii?Q?WPwhCLUgsdrU9acee7Jf9yn7ye2jXGOOrmLn7i7mjZb9J+noHM0/KPTccTst?=
 =?us-ascii?Q?S8BlqjavEzP6bqLcX6Du9o4GbRCG//PIX9tj3aZgzqb7WrQKNVHqWXpB0nuH?=
 =?us-ascii?Q?5b2dTBDF+EVaY9BbLiW+L6dy0d+E1kOeylzDaJWHJWAufFRNDfu4MM40lxOO?=
 =?us-ascii?Q?LFk2oWM7ash5m9au97TKNfWj1UJIY0ZiSsldl//grllQkIL3yQUg4pEFUECF?=
 =?us-ascii?Q?yOUxe9EatSSofz2TjrsZcxMxC4v585qsoz9cV9nRN/7vWRcL5IKB7OdzJb9t?=
 =?us-ascii?Q?5wRcZQmr0zJQz9c9pJU5zTHFhHJJsc41P1WoPNPXinjM9FlCHeIoIULxTNyU?=
 =?us-ascii?Q?g3KrvHmagKtFXQqOJYd/89WHpsteRAVq1ebUy+H+bm/u/DmB5Ce/phNISHCS?=
 =?us-ascii?Q?T7xNqDatmm2vE9aI58AHePRIawEJsZlS7adtf69nDzyTp32Tr4/aj/9ynxLS?=
 =?us-ascii?Q?k5UBu3XNarbxyqf82LNwCXtTncD5nFVEoMnbRT8CTx2D525LZN2QZVnrb4l+?=
 =?us-ascii?Q?PetzdSHLjnUm6ZfiW2Xlh+VmSEfnceH7cTdPwgDnX31/hJNHoEjbHr9eu2RG?=
 =?us-ascii?Q?OA2g3aumgMFju5K3w7wIkMPH9OLXOhKrUHQZ2CIXmBDJdrutnbt0FyF+yCM3?=
 =?us-ascii?Q?CI99n+v/99QVlcaXYZH5ZsXAmMiS75HxjaGg7W4wm9SDIgQSLF8lfE9bXmO3?=
 =?us-ascii?Q?MOvuNmDCHVoicC6qsGspbP1skX2NOVKQvh2QFmyvwE1TSDIJpBeSwUYVHP3X?=
 =?us-ascii?Q?IarZl2oIQolBwC0kH2WLq3aEq8sJLMUOsAxGraRVnEEy/pputXf1nxo+0uw7?=
 =?us-ascii?Q?ZcVesSOXCboBvOpPigQLoYxmYqal3dM57uqGsdnrd8873eodnh8W2gm9Tl5I?=
 =?us-ascii?Q?qKzRyA+kAuGbMr8ll3+08VbG7U3HbXTcdVSgFEtuhJfGxeyZ4G79NtEPhjZD?=
 =?us-ascii?Q?XGIg5UWDuJLBCWdYZfi25zlJuOA=3D?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be077b24-29bd-4a49-5881-08d9e1bb7402
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:35:47.2330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXwVQIV5hbOm80BLSoVUDEZPOqa/xjl7TYDOoPrPLZ0FKcb9JmIpe9jDOzIYHedP7QFVDiuD6ZX/M/GvNzKNC083DZJ3m9uD4JDKj7vJTNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9665
X-Proofpoint-ORIG-GUID: NuuTzdrnnvgwbG6n_7BuLR7TsHW2aHWz
X-Proofpoint-GUID: NuuTzdrnnvgwbG6n_7BuLR7TsHW2aHWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 mlxlogscore=676
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270102
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AMS driver DT binding was missing the clock entry, which is actually
mandatory according to the driver implementation. Add this in.

Fixes: 39dd2d1e251d ("dt-bindings: iio: adc: Add Xilinx AMS binding documentation")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 .../devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
index 87992db389b2..3698b4b0900f 100644
--- a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
@@ -92,6 +92,10 @@ properties:
     description: AMS Controller register space
     maxItems: 1
 
+  clocks:
+    items:
+      - description: AMS reference clock
+
   ranges:
     description:
       Maps the child address space for PS and/or PL.
@@ -181,12 +185,15 @@ properties:
 required:
   - compatible
   - reg
+  - clocks
   - ranges
 
 additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
+
     bus {
         #address-cells = <2>;
         #size-cells = <2>;
@@ -196,6 +203,7 @@ examples:
             interrupt-parent = <&gic>;
             interrupts = <0 56 4>;
             reg = <0x0 0xffa50000 0x0 0x800>;
+            clocks = <&zynqmp_clk AMS_REF>;
             #address-cells = <1>;
             #size-cells = <1>;
             #io-channel-cells = <1>;
-- 
2.31.1

