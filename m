Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5D84D4D
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2019 15:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbfHGNcs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Aug 2019 09:32:48 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3390 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388390AbfHGNcq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Aug 2019 09:32:46 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77DS0Jo029504;
        Wed, 7 Aug 2019 09:32:08 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2055.outbound.protection.outlook.com [104.47.49.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u7bcx3bdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 09:32:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvUI4sCSwP00qTGAe6g9wb1SM29aid0zsynatv7hMpS76J0UHH/ksjHSjFdRa9E3h6a3BvwpU9UkITZwlGJW5Hqhxd3XdSrvAyaQoQmCaLU6eLc9Oz1l+mAbSUjOwSSSWnZtYaX+ebDPH35hY2kzOwjaxvcUFE3TfmIvFcEjc1ANflnjsWoTMUrawYrEdBe1FRQTr7nYqCqtY3uQNB6JvjfPT7lBEGo7Lx1PymjLDqn852BKE3YJrscNY2lh/Pa0lMhpsS6tYzuHxZPDh51Y2hrtytThRgq8Suux4ECBLrr7Jnfmv96GugBCHPOgwXUW0hhjtvlSHyB6mtwcKPAiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzUsn6l388YzL6ZIOqa+iLPYsO9aW4QGiq3j+MSBH4M=;
 b=AvLZKYAuU1O75+sZoT2O0z2EbUlSPlK2qdlyhDyefzN08UcrvfldzjiS2MgIKOzcgaMA2UWUZQVNtVnU1qgPEA/+q0HHvtyjcOND8fyiUQpae6Ep5UybAWZnuYRgjQHbx9mNNeL8fU3OFSTl6M4ZQkqGc3ehgpuKq/YYWMEeYRxAq0w47iX1aeA0/n8nnDjEAyqsmIVEoNOzi3GHUvgRXS+tXmhA2oBliEpEpcifzwAhcAlyXhE6UbKrt/VYZPRnrSudkSphnDjzSMOdOpAXfIY/MmmE9zXgEoYT8UgLFca4tSPpZyaiJX3/Et01cMwairr3mb3kZLaRxh0CvGcHMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzUsn6l388YzL6ZIOqa+iLPYsO9aW4QGiq3j+MSBH4M=;
 b=PgZusNeTlcumgKhIFpG7TVWj3YorOgYFMMkc366wnF1ELy8pvbZa4MQ7PGD5LBnEtmCShdMfV4sdzT7xRwHxGbTXWZ9CnGq73poxHe8SpUTjEeRlAGV8VKiD44yaB1Qb56gP/wQtM7ZpDR/mYMZHKeZlMOx2GLWOQJjlSiElnn0=
Received: from BN6PR03CA0083.namprd03.prod.outlook.com (2603:10b6:405:6f::21)
 by DM5PR03MB2681.namprd03.prod.outlook.com (2603:10b6:3:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.17; Wed, 7 Aug
 2019 13:32:05 +0000
Received: from SN1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN6PR03CA0083.outlook.office365.com
 (2603:10b6:405:6f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Wed, 7 Aug 2019 13:32:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT013.mail.protection.outlook.com (10.152.72.98) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Wed, 7 Aug 2019 13:32:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x77DW1v0029042
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 7 Aug 2019 06:32:01 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Aug 2019 09:32:03 -0400
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
Subject: [PATCH v2 4/4] dt-bindings: iio: adc: Add AD7606B ADC documentation
Date:   Wed, 7 Aug 2019 16:31:37 +0300
Message-ID: <20190807133137.11185-4-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807133137.11185-1-beniamin.bia@analog.com>
References: <20190807133137.11185-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(189003)(199004)(186003)(26005)(426003)(6916009)(336012)(8676002)(2906002)(4326008)(966005)(7416002)(106002)(2351001)(5660300002)(14444005)(16586007)(1076003)(54906003)(44832011)(7696005)(70206006)(76176011)(47776003)(8936002)(70586007)(305945005)(51416003)(6306002)(2616005)(126002)(476003)(11346002)(446003)(86362001)(486006)(246002)(36756003)(316002)(48376002)(478600001)(50466002)(6666004)(356004)(7636002)(107886003)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2681;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1a1783f-908b-4091-d9a7-08d71b3ba332
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM5PR03MB2681;
X-MS-TrafficTypeDiagnostic: DM5PR03MB2681:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <DM5PR03MB268157E2A9DF5A12EC215CA6F0D40@DM5PR03MB2681.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 01221E3973
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 05od7/1TmUlTDP6OAUHD3uDw/WlaiBJT5DBISk0+kolzdDyG0rld1tP3kcS8iBj1a6yIHLn17IMAMG4d/x2+PAqjvORtwD6L/mK8/rZgqbPWiG2tH5OWbKHwJ/EruSM8fRiOXZCO91Vq/X9bIWJB3Gafohg0TQC1FjQZ/gsMhVEwdsEuwZbE8qTq37EAO9DFT7uaH4p2l7+rB7yT3cRa2C4CK0liQZ3z43tzw/Cj9+DIwSyYJAXieoECRU3KRGuti/OsOowhXj1mkA2nD0yedATtlaK4N3iPj1Z6Dq2BEFClJI9NxtbGuVmY+WDGRqYpWoDnzY9g4a2SzJLqsRR98x+4UVAEx7RXFUYcgbavt3V5jyDp+gaaCjmKbdJB3AILBS+kRw6XzlADe7m5xBz96EMfSlEq8OPUoq3YBg4aYiM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2019 13:32:04.4158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a1783f-908b-4091-d9a7-08d71b3ba332
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2681
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070147
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Documentation for AD7606B Analog to Digital Converter and software
mode was added.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v2:
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

