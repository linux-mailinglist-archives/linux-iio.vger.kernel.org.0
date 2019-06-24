Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4108151B15
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2019 21:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfFXTAy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 15:00:54 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:52242 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727014AbfFXTAy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2019 15:00:54 -0400
X-Greylist: delayed 13714 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2019 15:00:52 EDT
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OEwF7E011278;
        Mon, 24 Jun 2019 11:11:46 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2059.outbound.protection.outlook.com [104.47.41.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2t9e37ecjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 11:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3/zpiXDFuWHWdfqeOJQsM73tB1qPBmjulD0aDXV9nQ=;
 b=D2hxx5AGkji8pAPUE7YhVTAyt8MiDtdRi5tfzQzd3ftjElI2r8SOOAdtXjmAdYf+Ae9dOabfJApCs+SZSG26FxDS51fhGBDY3hXbUsow/KCTtWhFkPgUIwn6+mOkQKnmDEFgGBLX3kGmbx0tv6mn8tZEPaK0AsEDwhIy00WuCQM=
Received: from MWHPR03CA0020.namprd03.prod.outlook.com (2603:10b6:300:117::30)
 by BLUPR03MB549.namprd03.prod.outlook.com (2a01:111:e400:880::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.13; Mon, 24 Jun
 2019 15:11:44 +0000
Received: from SN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by MWHPR03CA0020.outlook.office365.com
 (2603:10b6:300:117::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Mon, 24 Jun 2019 15:11:44 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT063.mail.protection.outlook.com (10.152.72.213) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Mon, 24 Jun 2019 15:11:43 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5OFBfs5010081
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 24 Jun 2019 08:11:41 -0700
Received: from linux.ad.analog.com (10.32.226.41) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 24 Jun 2019
 11:11:41 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 1/4] dt-bindings: iio: frequency: Use dt-schema for clock-names
Date:   Mon, 24 Jun 2019 18:11:37 +0300
Message-ID: <1561389097-26075-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(2980300002)(199004)(189003)(51416003)(4744005)(476003)(426003)(36756003)(2906002)(16586007)(126002)(50466002)(70586007)(2616005)(70206006)(186003)(5660300002)(336012)(106002)(110136005)(54906003)(44832011)(48376002)(486006)(316002)(6666004)(356004)(72206003)(478600001)(7416002)(7696005)(8936002)(4326008)(47776003)(8676002)(50226002)(7636002)(246002)(305945005)(77096007)(26005)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB549;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 026178c4-5672-48af-b8c5-08d6f8b64485
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BLUPR03MB549;
X-MS-TrafficTypeDiagnostic: BLUPR03MB549:
X-Microsoft-Antispam-PRVS: <BLUPR03MB549A7F542545801DDB7DE9F9DE00@BLUPR03MB549.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 007814487B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: YrE5tGuUGmgHnSlaKpOJuTInXW/2YDLHVyi/hBkzGian0fU1eSJouVTAD2xlUFuLApq5cyIo+IYY3LH5hGcTKVxiOgjQntM9JU+mhDYDYaXyQqxeGPPpRKSe50CxDCg7GTO2dVA88fDBbAGuEvjpoB+xOvZLiTwXDXoKuYZBLpD3R7ooZ0q40qGCeLGKJSDknNjslPFT3C+mIM2hI4R34+vSVYWTQEoQs/PjdBRKlHtluOsPv8E+l3KWS88ZxFwxhpJZjeDwc8cY9MGk72QE6R33Jjpvk6Y+jt6wP4KKr22xR/38qLxDrbUE/rFqmVZybmQyN06uAjW2mIRaQ0mvLVwkzmh8+B/XTckgSg2Qo+Ri+T1vSS4pssZRH7oyxLJmvMKwVTq8UHiz+cdTfNWWK7cNzgj/4ytumMvOWkZ/khE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2019 15:11:43.1900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026178c4-5672-48af-b8c5-08d6f8b64485
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB549
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dt-schema can be used for clock-names property.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 Documentation/devicetree/bindings/iio/frequency/adf4371.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index d7adf074..8a2a8f6 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -27,9 +27,8 @@ properties:
     maxItems: 1
 
   clock-names:
-    description:
-      Must be "clkin"
-    maxItems: 1
+    items:
+      - clkin
 
 required:
   - compatible
-- 
2.7.4

