Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA14FDD66
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 13:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKOMXn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 07:23:43 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:43910 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727196AbfKOMXn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 07:23:43 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFCDTqU015446;
        Fri, 15 Nov 2019 07:23:16 -0500
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2056.outbound.protection.outlook.com [104.47.32.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w7prkhfx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 07:23:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i819LWIKYNeHJ1c0I/R0Du6DinKRK+IvBmgIgaphyXQVv/15z3OfDx08N+K4p1kYpacb1KBPQtil/Q2AZ5aQdU6KZoJ4KpK7/Yte5bb5EmVlFGxweZlyi01xzJ65DJeGlizq7LjEDZO/y65Eotmp2r6h+bj9yJy7ion8UaDOyVAI0j8NLGVFo2sDiQHZv8nLXBxBHQxzfbWqcg1iJ/pf3hQI5rCOliptb2kwGfQq91p9N2KaoRLWYf/c6002bf3ffbN5dhFksWRDeCRN7WKN5AhUZPfTCxQyechogNtou6OEuT1khA+6qd0OAdZQgMDX0ouMaziWSPWhH1eqpmze6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzzAsV+iER8v9btEd2lE1Gt713KOHX0TsX7HabVHVck=;
 b=NdVOPMLdrSaK8EYfe91J5unO6jU8UDvAD/6kPpaIGhHgS9xGGvFI8MYsHZvhAM42MGxA7a5z8/EDzp3XudMgo167xANVJRlZu/V+ulf4a/rgByL1X70fGgVXcmGLQVHBXrJVDuVgUbjKdTz/YZutoWNoXyilT37RhPhQQ30nd0IVF7Vzk9b/WObBUVFuN6MXRp0722l5rjtFlRhHgUruCNztzgU1GlaU1Llq5gLsEN42R3EiCOb9p3hTKIIbVzf6OhVVLbS2YpZiS1+Xo2u78S9y1uktW12obW9lex5ODoWFxIR+Io2jteaoT6z3GVmo+JBKpDK2+H0wM9cx1zng6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzzAsV+iER8v9btEd2lE1Gt713KOHX0TsX7HabVHVck=;
 b=4qzn64M+rQLK2pxYcQVkiL3wi/z20+RUmpvoumVavYG/WwGGioV0NgTHn7RhFk9mHCHPweDet2kYPLUNa0B5BNLlB5DQuTV1VWLoRL1RiY3FqLCdsKB8WD7xz5tU37X9G2Wl3qfPG5XbzCjvN6DJqs9Ubyo3tZvcDUlIfJv3XQ0=
Received: from BN6PR03CA0084.namprd03.prod.outlook.com (2603:10b6:405:6f::22)
 by MWHPR03MB3005.namprd03.prod.outlook.com (2603:10b6:300:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24; Fri, 15 Nov
 2019 12:23:12 +0000
Received: from BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN6PR03CA0084.outlook.office365.com
 (2603:10b6:405:6f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Fri, 15 Nov 2019 12:23:11 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT058.mail.protection.outlook.com (10.152.76.176) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Fri, 15 Nov 2019 12:23:11 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xAFCNBTP031812
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 15 Nov 2019 04:23:11 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Nov 2019 07:23:11 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v4 4/4] MAINTAINERS: add entry for AD7091R5 driver
Date:   Fri, 15 Nov 2019 14:23:16 +0200
Message-ID: <20191115122316.20893-4-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115122316.20893-1-beniamin.bia@analog.com>
References: <20191115122316.20893-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(189003)(199004)(476003)(5660300002)(44832011)(50466002)(305945005)(7636002)(966005)(356004)(478600001)(8936002)(2616005)(47776003)(246002)(2351001)(126002)(6916009)(486006)(70586007)(50226002)(76176011)(4326008)(7696005)(51416003)(4744005)(70206006)(107886003)(1076003)(86362001)(106002)(8676002)(36756003)(48376002)(26005)(186003)(7416002)(2906002)(16586007)(426003)(6306002)(316002)(446003)(11346002)(54906003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3005;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b04df5da-a437-46b9-c78b-08d769c694ee
X-MS-TrafficTypeDiagnostic: MWHPR03MB3005:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <MWHPR03MB3005F2077531697B228BD967F0700@MWHPR03MB3005.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 02229A4115
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m25TT8G0jt9REbEOPI61CWb2AadSv870DezOaeRbA0yY7FmY+mgu3AroMd8lnfX/0yE4gdiiuErI9WKqy5tKDWN+srvBvCjXGolARCdgGswc99PBXvj5ttfSA3OSCZ1ZPya4Pa6rzHuiZOyoEQvQ43yAlGSfJCdLQ7/x7iSZoe3AAHP3culWSUTNdxuHc1A6SBzM/n2StvTPcafNgUJUH6jT8SJOjAv5l8cSvqZInoHDaV2siiiMUpoGistGs3JLniF5Mxh3wbUHkdQPeiU8tnZXqtrxvMjr/NzOnpsFkVltUw8A9RrcViC5HzYRb//oZbRm5jq7Z0090/Mmmi9RDfXfBmm/A1kILBfTDLydGhACVcUeA1HSgCK6kOEIDxyBldKxJDQJ/H9QntOKzZa9+XrbOiupC7kyTztBXjjJb4TTvA4niT9P54d6VH1LG4xKTYuOItdbaL5VWK7w0bn7dWIh1/KNrgPnBODoxxcIy3A=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 12:23:11.8761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04df5da-a437-46b9-c78b-08d769c694ee
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3005
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_03:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=1 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Beniamin Bia as a maintainer for AD7091R5 ADC.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v4:
-nothing changed

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e01d0f0b0e5..7f1e4b88688f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -893,6 +893,14 @@ S:	Supported
 F:	drivers/iio/dac/ad5758.c
 F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 
+ANALOG DEVICES INC AD7091R5 DRIVER
+M:	Beniamin Bia <beniamin.bia@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/adc/ad7091r5.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
+
 ANALOG DEVICES INC AD7124 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

