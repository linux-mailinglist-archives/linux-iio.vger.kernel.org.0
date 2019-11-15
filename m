Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5398FDF81
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 14:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfKON5c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 08:57:32 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:33776 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbfKON5b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 08:57:31 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFDm2Ap000883;
        Fri, 15 Nov 2019 08:57:05 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w7prg200r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 08:57:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/0KGkJ0DjGIhRj5Q2VUqgLhUR8PRj2WWI8pZUvFrECUFHwHl7sTNWUYmc5FY02rPpoCsisYG4vlLwyYAHurbpCkFg8bu3bqn6tzrnD7A6/7Ed36M5Eqp7g3v28r9L4shdXOKXfrLw1DAPWzRHhfn3TNxg6giIvEkUnXIHXo3+cJxplHADxzWVcrsFs5iOI4apnJIFQpeWaSMvO/NvXmFNK+6PzUM/bTzqJ4HKvaUhGA7bXtz1VzIK/G38RftDTTwLFT6TTVnmBFesn8pOe6iHCjmng9k52WkO4Umcljl51NX0dJyy/7Gx1uzQ1H9XYx9PcSwg+gM/d87zJ1imN6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0vzK/qgF7I7l4GXj3CMMNUnGg2gI5RHY1JdLyJDCaw=;
 b=lmbpt6eu3Kckv+eLraoq6VWHk3umytzcY3ybP0Uhq/1eVy7RbkXg1UjX+DHn1sf2rkR8iBdPwY4JQDImuGILKCkZE2Gl7ykdPaemDZTMAohavVy1BIJtWNxCzWAqtfq6ePR6+SK6Wr66PDEZww3HztUM4t2TYarDxirt5FnquusbZRa2XSgt9gsuSOXbXhhOtCGLzcmE2oO8lZNAffW7lx3et/j8G+1Nd+s0Mmv+fljRblDjhWasYIEBMT+dGIRh8jfrBY7y0wtCKV3VkVWzgh+kv4bdMta8NMmx9oDyIB1npUIY2N7sl8T+DU4vs4FQhYu4uUgasL5Ux8eXcsoLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0vzK/qgF7I7l4GXj3CMMNUnGg2gI5RHY1JdLyJDCaw=;
 b=ckM6OXTiTsHrA5NTdywxGZtgZkKSP/0w7iZPbad3+XLKFnQ7Lue317O/nn4ToN4v0dpfVI/81fCvtyk8zQ2sIo+tkPi4bx9HYxyN0B/Qj7ZJmF8dYcWcJdhcgQYJkz+yohs8IsWsIyhPGHpBBUHX9JeyMCszghupj7zXRQMdOTU=
Received: from BN3PR03CA0057.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::17) by BN6PR03MB2740.namprd03.prod.outlook.com
 (2603:10b6:404:5b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.28; Fri, 15 Nov
 2019 13:57:03 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BN3PR03CA0057.outlook.office365.com
 (2a01:111:e400:7a4d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Fri, 15 Nov 2019 13:57:03 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Fri, 15 Nov 2019 13:57:03 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAFDuslW003086
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 15 Nov 2019 05:56:54 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Nov 2019 08:57:02 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v5 4/4] MAINTAINERS: add entry for AD7091R5 driver
Date:   Fri, 15 Nov 2019 15:57:23 +0200
Message-ID: <20191115135723.12219-4-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115135723.12219-1-beniamin.bia@analog.com>
References: <20191115135723.12219-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(486006)(106002)(107886003)(48376002)(7416002)(126002)(44832011)(16586007)(47776003)(5660300002)(8676002)(50226002)(8936002)(336012)(316002)(356004)(6666004)(246002)(7636002)(305945005)(26005)(186003)(6916009)(6306002)(478600001)(70586007)(36756003)(54906003)(70206006)(966005)(2351001)(76176011)(426003)(446003)(1076003)(50466002)(7696005)(4744005)(2906002)(4326008)(11346002)(476003)(51416003)(86362001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2740;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f394538d-e087-4a7a-9ddc-08d769d3b175
X-MS-TrafficTypeDiagnostic: BN6PR03MB2740:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BN6PR03MB274046FF416A469EC37E7F1AF0700@BN6PR03MB2740.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 02229A4115
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BhPCSYCS70yMvfqHFw9CABCbnBqu38Yx3OlVZN0LeHvzbwLp4KEYaRJbxSZSjk07eR0bkIGPOi/ei8TeO0zG0spgfgSabOz8pgpOOREtHg5uKjBULPiDXr6lnEq1EJa7vZqk/qab8fhKso4r9abiFxa6N9MIDJZc3/BPBoq/RbkKO7LcZwCv4fp6i7upL6MplCNiieemwn8VkYyIMgcgeBHAbtsoB9AIF+90FHVvHJOg3MioJ3yvney5r9JkYawaPrMhVz4XETH+OOy9+mp2+c+nG+VUWrX35Ut4hJpkH9gupi/fbVlICTsogbaOrcgE0PlY1C+ZE5J6HwGBHKxWdMTtz8501dml+rQIfDbfiBIYNok4y+9fHF1Lb449sFsBpGu19N67dPYb7zyNKaFWf2pOwS7uaIwd0dq0S9yxx5RirTjp6wh1WWEhQEzBviXe46dwlPqnomvNKsziCU2EqIOOV316R5OAec1aDZV0Lg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 13:57:03.1905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f394538d-e087-4a7a-9ddc-08d769d3b175
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2740
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 mlxlogscore=999 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150126
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Beniamin Bia as a maintainer for AD7091R5 ADC.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v5:
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

