Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D4497C53
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 16:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfHUORs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Aug 2019 10:17:48 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:7912 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728981AbfHUORs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Aug 2019 10:17:48 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LEFt4X026159;
        Wed, 21 Aug 2019 10:17:11 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2055.outbound.protection.outlook.com [104.47.33.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ug3mac2wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 10:17:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQk6rVYfCOHb9kYWYp2ZohlBOJjFXWOrE6piCCBu9pjGzWdad5dUjGMRoFK9VmvJXEqcNDmIXrrPe3i5uNmggathcu9u3lZ2k7NGyClg0/1krgzMHE6iVKzfhKbi49GQz65XQjfI91owsYwS2T9XsoeE5ggLNyRz22Jdw8m/7qxdwiHjtMCQseW5BywheX/9KzfbW5FaqL/vjkWyZXs4XbwryfboJo6VoK/pEvRNsJ5DofUlEBc1FYf6uUMxFVAUfZb3Ed6FlY2CKREnLwzxm0qpZKrkNLJ/tfNIEQku22AXivWWE6c8Iuobm64C4dSDdYw+L1wpWbTyw+xmOUxdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh9sSZWrstr07mS0w9mNVsQBVCj7BgAlH0eJ4glJsM8=;
 b=n1K1aHikKuTEuLPo/ZzXOoVF7wbKSj9rWirIYh+dzwh4mXA8TD3HS61eG3dtAIt9M084gu0ejQG2HujX+YUdlooIstccJzeoBkbltZmApTpqSzOadQ3Jkp0QJaitMhXzhgY4SFZoZWJKn44QEPrBKgR8l7brq9rcvIJSQnDHhchS5Bd70YCHFfeEVm2rcY0BFxuiAQ7QOpeEc7Dwe8iyuO0+3088unKJR93KjEhEVAPJNJFbJMRJzDWVkEGet8nf/Deo59K4Eok+P0MyzngMj+MFhihbqBQKTG72oIxdMd+Hkx70IvuE96F0CREdwUt2sOQxAMqGfxjrvgIG4B4N1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh9sSZWrstr07mS0w9mNVsQBVCj7BgAlH0eJ4glJsM8=;
 b=WV7qnMpia10DBoYixEw8PugnngaZxQ6wP7j8b/zXo/wss7UbAQXRoez5Xk1KsUIbIQyeb/vV6YXpc1bMPRfSPi7Vdymw1bIP5TOHHYgTDGL0QLw/FKVAA6oaly8JjwgZcZCo9kYBUphzFG6v4h1Fms1HEeV3ueeVjv10dUwhhIg=
Received: from CY4PR03CA0088.namprd03.prod.outlook.com (2603:10b6:910:4d::29)
 by DM5PR03MB2553.namprd03.prod.outlook.com (2603:10b6:3:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Wed, 21 Aug
 2019 14:17:08 +0000
Received: from BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by CY4PR03CA0088.outlook.office365.com
 (2603:10b6:910:4d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.16 via Frontend
 Transport; Wed, 21 Aug 2019 14:17:08 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT010.mail.protection.outlook.com (10.152.77.53) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2178.16
 via Frontend Transport; Wed, 21 Aug 2019 14:17:08 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x7LEH4YD005682
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 21 Aug 2019 07:17:04 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 21 Aug 2019 10:17:07 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v3 4/4] dt-bindings: iio: adc: Add AD7606B ADC documentation
Date:   Wed, 21 Aug 2019 17:16:56 +0300
Message-ID: <20190821141656.4815-4-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821141656.4815-1-beniamin.bia@analog.com>
References: <20190821141656.4815-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(199004)(189003)(44832011)(305945005)(54906003)(106002)(2616005)(2351001)(486006)(476003)(446003)(51416003)(7696005)(11346002)(316002)(126002)(107886003)(14444005)(1076003)(4326008)(186003)(5660300002)(26005)(6666004)(356004)(70586007)(966005)(70206006)(76176011)(336012)(426003)(16586007)(36756003)(8936002)(86362001)(50466002)(48376002)(47776003)(6916009)(50226002)(2906002)(8676002)(7636002)(7416002)(478600001)(6306002)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2553;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 469d2330-1e7a-4c9e-f8d0-08d72642401e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM5PR03MB2553;
X-MS-TrafficTypeDiagnostic: DM5PR03MB2553:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <DM5PR03MB2553E35A76F48E93A5B44A70F0AA0@DM5PR03MB2553.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0136C1DDA4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: f95nOJpPZ9ImLLRkPOjiy7WdOGiBcEkd5puhsiDBU0+NMUQqD27aSTej2Hd2Z/XVz4XqgpI0dJ9MUOT+173lK4aKQp5WDCx0UEym0EKy7bhj3FBP++wZrQl/5zistpBCv/3OmsR8X3YRcNEmEH53hbWAK5VFHMW2WnvhEsx6+xF/W+Ag0cYQd1TGW2lGeWJdrRgDBMOrEZvYsnf5d9JzmzrPQN8LxfRr4kGqGmNAl6KFijetjWgkeZaL5kIxXb7lKez9N5Slj8hYtUCFJwQsesg2QKcY7OxkdUg7O69LflrchSHzfVxlY2VE+WU6TjDTbcTjjS9x/JYftHVUXJodQcrPAjgma//DSiHbDCqkrKAR8VNCboW3zrAkoVlvGaeQuO9Qyu12x3O4eHHNUCFgI2c3Czk4XToddfxXb5XLZZk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2019 14:17:08.0622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 469d2330-1e7a-4c9e-f8d0-08d72642401e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2553
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210156
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Documentation for AD7606B Analog to Digital Converter and software
mode was added.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v3:
-nothing changed

 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 509dbe9c84d2..2afe31747a70 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -13,6 +13,7 @@ maintainers:
 description: |
   Analog Devices AD7606 Simultaneous Sampling ADC
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606_7606-6_7606-4.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7606B.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7616.pdf
 
 properties:
@@ -22,6 +23,7 @@ properties:
       - adi,ad7606-8
       - adi,ad7606-6
       - adi,ad7606-4
+      - adi,ad7606b
       - adi,ad7616
 
   reg:
@@ -87,7 +89,7 @@ properties:
 
   adi,sw-mode:
     description:
-      Software mode of operation, so far available only for ad7616.
+      Software mode of operation, so far available only for ad7616 and ad7606B.
       It is enabled when all three oversampling mode pins are connected to
       high level. The device is configured by the corresponding registers. If the
       adi,oversampling-ratio-gpios property is defined, then the driver will set the
-- 
2.17.1

