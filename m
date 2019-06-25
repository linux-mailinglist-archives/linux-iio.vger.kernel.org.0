Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39B1A52633
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2019 10:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfFYIMg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jun 2019 04:12:36 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10602 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729235AbfFYIMf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jun 2019 04:12:35 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P87tcm022164;
        Tue, 25 Jun 2019 04:12:14 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2057.outbound.protection.outlook.com [104.47.49.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t9e63g86e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 04:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZXv5pRQeWsh0FbOjnJRyxG9f+ND+c3YPdQXFzMnyMM=;
 b=e9Yk7TXzt46Vgey7eWJu+uEAeH7LogP6Ab5k2bSawXdR8glMxiPL3iuEd7Z6LXuUAtm1Vu0pR2DFtPIfV4ZbIAnw85EFK4yn187kUrgSlX8d4/4UAg05TIryTc+4HXazApJu3de2ffDQcH983a8PhhIe+niXtqJBljvR9HWVhS0=
Received: from DM6PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:40::37) by
 BL2PR03MB547.namprd03.prod.outlook.com (2a01:111:e400:c23::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Tue, 25 Jun 2019 08:12:11 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by DM6PR03CA0024.outlook.office365.com
 (2603:10b6:5:40::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Tue, 25 Jun 2019 08:12:10 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Tue, 25 Jun 2019 08:12:09 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5P8C8tG022742
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 25 Jun 2019 01:12:08 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 25 Jun 2019 04:12:08 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V4 5/5] dt-bindings: iio: adc: Add buffered input property
Date:   Tue, 25 Jun 2019 11:11:28 +0300
Message-ID: <20190625081128.22190-5-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625081128.22190-1-mircea.caprioru@analog.com>
References: <20190625081128.22190-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(189003)(54534003)(199004)(478600001)(50226002)(8936002)(72206003)(86362001)(36756003)(2351001)(8676002)(5660300002)(2906002)(4326008)(107886003)(76176011)(1076003)(70586007)(2616005)(476003)(446003)(7696005)(51416003)(336012)(316002)(47776003)(426003)(44832011)(11346002)(70206006)(6916009)(16586007)(126002)(356004)(6666004)(26005)(246002)(48376002)(54906003)(305945005)(77096007)(50466002)(106002)(7636002)(186003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB547;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4410d80b-7e1a-42c1-c361-08d6f944d1fe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BL2PR03MB547;
X-MS-TrafficTypeDiagnostic: BL2PR03MB547:
X-Microsoft-Antispam-PRVS: <BL2PR03MB547BBD260DE52103F0FFE2F81E30@BL2PR03MB547.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wQie9TFlrbYcBEVbVo9MC6KEiObnMjITg//P1hMOSzGxrYynrjKeAfLs+BX/kHOvBCTKhe/1i2LFqn0KfXKQcwEoADdALJUcPtHcPOaZ7Rl/YuIj3fuh3f3TBXZFhiPfIPZxzY0tSFYnEymmuKLpoWPQ7BMdRMjNlJgKOJDlDoRyshYfbZhI8MK3mNkUN5XF3GMmbfKn3g0uWjrsU+mCQRdVWUIZyReC05N2ARjOahat5mpvkF+GaNMyu9wtjwPyNgZxO6P04boKMoEC/hF6jE+wOCnNdeDzZv/elqWyBKRReR7BQaq69po47cWhq7UhZs3iDE1V9/yVMrWo8kKzAmZzdHZGGrMDPckM7/x4qlBV03pDZNXQ/djb/4UWhHt5hAUB9nkrln4fayyg65PodhnnDRtFQAKYUUKkguZ7C9Q=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 08:12:09.2457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4410d80b-7e1a-42c1-c361-08d6f944d1fe
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB547
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250067
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds the buffered mode device tree property for positive and
negative inputs. Each option can be enabled independently.

In buffered mode, the input channel feeds into a high impedance input stage
of the buffer amplifier. Therefore, the input can tolerate significant
source impedances and is tailored for direct connection to external
resistive type sensors such as strain gages or RTDs.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---

Changelog v3:
- added this separate commit for adi,buffered-positive and negative
  properties

Changelog v4:
- nothing changed here

 .../devicetree/bindings/iio/adc/adi,ad7124.yaml       | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index 1b3d84d08609..cf494a08b837 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -100,6 +100,14 @@ patternProperties:
         description: see Documentation/devicetree/bindings/iio/adc/adc.txt
         type: boolean
 
+      adi,buffered-positive:
+        description: Enable buffered mode for positive input.
+        type: boolean
+
+      adi,buffered-negative:
+        description: Enable buffered mode for negative input.
+        type: boolean
+
     required:
       - reg
       - diff-channels
@@ -123,6 +131,7 @@ examples:
         reg = <0>;
         diff-channels = <0 1>;
         adi,reference-select = <0>;
+        adi,buffered-positive;
       };
 
       channel@1 {
@@ -130,6 +139,8 @@ examples:
         bipolar;
         diff-channels = <2 3>;
         adi,reference-select = <0>;
+        adi,buffered-positive;
+        adi,buffered-negative;
       };
 
       channel@2 {
-- 
2.17.1

