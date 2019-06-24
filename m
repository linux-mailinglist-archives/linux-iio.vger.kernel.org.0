Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E896510D6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2019 17:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbfFXPk6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 11:40:58 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41362 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfFXPk6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2019 11:40:58 -0400
X-Greylist: delayed 1649 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2019 11:40:57 EDT
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OEw7ec031348;
        Mon, 24 Jun 2019 11:12:52 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2053.outbound.protection.outlook.com [104.47.33.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t9h86dvcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 11:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfbZVwc58P46CMiOnoHvfUklNQgir3M9/ioiILpOHhc=;
 b=toPvrm4aD70oSS21YABqzAKXmNMWjvo2crmWL8Sysv31L25v4jxmSa23cbIM7uez7ahS2KxYvYhEm2H3y10XS61Q/bRMI0Xl/2i3A3hMpZ5QcEWmAnodiabobODSrv+QcDbeGEvUSayA0mrC1e4WoZ3F+EcX2g/pWUkLOjexJ+c=
Received: from CY4PR03CA0106.namprd03.prod.outlook.com (2603:10b6:910:4d::47)
 by BN3PR03MB2258.namprd03.prod.outlook.com (2a01:111:e400:7bbf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.15; Mon, 24 Jun
 2019 15:12:50 +0000
Received: from BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by CY4PR03CA0106.outlook.office365.com
 (2603:10b6:910:4d::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Mon, 24 Jun 2019 15:12:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT038.mail.protection.outlook.com (10.152.77.25) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Mon, 24 Jun 2019 15:12:49 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5OFCj1f004362
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 24 Jun 2019 08:12:45 -0700
Received: from linux.ad.analog.com (10.32.226.41) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 24 Jun 2019
 11:12:45 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 3/4] dt-bindings: iio: frequency: Add ADF4372 PLL documentation
Date:   Mon, 24 Jun 2019 18:12:42 +0300
Message-ID: <1561389162-26291-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(199004)(189003)(8676002)(50466002)(8936002)(48376002)(72206003)(7696005)(6306002)(50226002)(51416003)(966005)(356004)(6666004)(77096007)(316002)(16586007)(47776003)(5660300002)(186003)(26005)(486006)(53376002)(107886003)(7636002)(305945005)(476003)(126002)(2906002)(246002)(426003)(44832011)(7416002)(2616005)(110136005)(54906003)(36756003)(4326008)(70586007)(70206006)(336012)(106002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2258;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58e8e926-f94d-4c40-57d0-08d6f8b66bef
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN3PR03MB2258;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2258:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <BN3PR03MB225856D795DE6AA853CACDDD9DE00@BN3PR03MB2258.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 007814487B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: eQunBQt36pVOkQIuJ9889Oqz04yldQPJbMy/pNSGCvLxb0uuHYsbxaaWskVHasM2oK2mt3kLmFmUsIbZJoKHqzlpijuwRWEKscfkktgVNEH5YjpgiX2vA5Vn6ECYHUGVXP7HeFCmJtOcN/hg/35URZlBAl7Hw4yTw0dM1z+KJpSg5RVjabV6LQ0VaT7c0XD3PTFd0VpGDSibCD/FWyA9bGRbYCYIM3m0sULXBXpj5Q0zLlFZ34XXAk13o485mgD0J2AOFX6L7XkLFYESq8cAEWxSt1ToW/nbSgABKmV5kGvZRS0U85KsTHYGbVvlp4LHZ5UAyuVkpD4BbvJgqSry2HA3L2xKIApHLL7IwmQVSQw45HwduMsVfVVw/WvGUSq4WIyvSBH3EBBeIZWBvAuahRmgvHB0vQzRQJoqrhs8Qd8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2019 15:12:49.5945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e8e926-f94d-4c40-57d0-08d6f8b66bef
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2258
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document support for ADF4372 SPI Wideband Synthesizer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 Documentation/devicetree/bindings/iio/frequency/adf4371.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index 8a2a8f6..a268a9d 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -4,19 +4,21 @@
 $id: http://devicetree.org/schemas/iio/frequency/adf4371.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices ADF4371 Wideband Synthesizer
+title: Analog Devices ADF4371/ADF4372 Wideband Synthesizers
 
 maintainers:
   - Popa Stefan <stefan.popa@analog.com>
 
 description: |
-  Analog Devices ADF4371 SPI Wideband Synthesizer
+  Analog Devices ADF4371/ADF4372 SPI Wideband Synthesizers
   https://www.analog.com/media/en/technical-documentation/data-sheets/adf4371.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adf4372.pdf
 
 properties:
   compatible:
     enum:
       - adi,adf4371
+      - adi,adf4372
 
   reg:
     maxItems: 1
-- 
2.7.4

