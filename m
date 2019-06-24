Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043AB5044A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2019 10:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfFXIJ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 04:09:59 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:36534 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbfFXIJ7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2019 04:09:59 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O88Ua3025097;
        Mon, 24 Jun 2019 04:09:38 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2056.outbound.protection.outlook.com [104.47.32.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t9h86cqst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 04:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vAb0V8G4Zhq9cQIZ2h83Qt5dk8v6JmrboSu//Ep3qc=;
 b=uI5nrCFvwWV+eCHjl1fXynnrs/tRe2p30uNgORS2R1SERSEh9fCz4Zmo+zS8CidpFd3OH1cv12GCiPWTEIZ23naDJyadVKrZOX1Vf13wtSmmHgMJgHIG0sPCbSo20XaebYmYEjxDGAp7ez5YVrnj97X892kIW+iPl+s0cnHdPkY=
Received: from BN6PR03CA0095.namprd03.prod.outlook.com (2603:10b6:405:6f::33)
 by DM2PR03MB558.namprd03.prod.outlook.com (2a01:111:e400:241d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Mon, 24 Jun
 2019 08:09:35 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BN6PR03CA0095.outlook.office365.com
 (2603:10b6:405:6f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Mon, 24 Jun 2019 08:09:35 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Mon, 24 Jun 2019 08:09:34 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5O89YeO019269
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 24 Jun 2019 01:09:34 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 24 Jun 2019 04:09:33 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V3 5/5] dt-bindings: iio: adc: Add buffered input property
Date:   Mon, 24 Jun 2019 11:08:45 +0300
Message-ID: <20190624080845.18537-5-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624080845.18537-1-mircea.caprioru@analog.com>
References: <20190624080845.18537-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(189003)(199004)(54534003)(4326008)(6916009)(50466002)(2351001)(107886003)(8936002)(50226002)(7636002)(54906003)(11346002)(426003)(446003)(8676002)(26005)(5660300002)(70586007)(356004)(1076003)(77096007)(6666004)(70206006)(106002)(2906002)(48376002)(44832011)(7696005)(76176011)(305945005)(51416003)(86362001)(16586007)(316002)(478600001)(47776003)(486006)(2616005)(186003)(126002)(72206003)(476003)(246002)(36756003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB558;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edd16a5d-d6ef-4153-fc09-08d6f87b4b40
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM2PR03MB558;
X-MS-TrafficTypeDiagnostic: DM2PR03MB558:
X-Microsoft-Antispam-PRVS: <DM2PR03MB5584AE9E665CAFF070D854D81E00@DM2PR03MB558.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-Forefront-PRVS: 007814487B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8iccR4QUWuGiiIvc1koNIOZgRI2No1CRvKWebvgTRwtt0z5oshZwKoIFcKsJD/pOjySiEK4o/Gj7fK+St7+TkocfZq6Orh3qVdZYLW47C7R9lzTlQh9MyXKS9AGhLSvwYwpvWjkqsCfujqn32lr8h+ZcTPf7FW+KSQEnUl7Bmx64PVxuFWApqBTiXGNZxNhsDjdA52EUjl7Gbua+Z4THzwS9nLQKCeURImKiIRLa/lzeYudXQkRdtUTrej6Cz2Pnwwi60LqX5etl8khCmeXlHlnjXkSvJfhfF1RwlrBfT0LhEKuMbhHwx95PUx/cAryXbf4wWXyrB10vZo9oURr464rvMvnupyw7DQAshW4HqZb1tWUTnHgQRB6sNDFh1iMjEt+meHicPR8E00KlxqsBL9YBDkyymuYkxNdJVnh6rIA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2019 08:09:34.5738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd16a5d-d6ef-4153-fc09-08d6f87b4b40
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB558
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240068
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

