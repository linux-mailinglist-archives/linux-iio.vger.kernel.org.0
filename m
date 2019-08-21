Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C179197C5C
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 16:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfHUOSU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Aug 2019 10:18:20 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9914 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728464AbfHUOSU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Aug 2019 10:18:20 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LEHPUe021538;
        Wed, 21 Aug 2019 10:17:42 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2058.outbound.protection.outlook.com [104.47.40.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ugmauhvsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 10:17:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6NV8fAnL8M1/Kxx5GN9tL7L3OYJf9c+DxgnczmYSgfc6HkcvAZi0sAQXK+GXGF7oHFnCb6t6ssIgpaXk8/Wg/J8dBkFBKhmQifZz0/xeM12To1EgPBreg3asvnZrZhC8s+8/z4EdKrzazVL425Lbi1PgHwV8r7PhMJafjRBTPTt274afBTlqWK+sCtmgiIClk4sKrvXrHcNLrhjnd7przORoK6lvPjgdTQSymI+H2hm5dkFZpJ3tOSC7nnr/Upl80IB1+gEM9i5NpeFUlkRuYcPe5w11+JK0BDDkFXa0dC2SO+RtLU7XQfQ9BXEPlsVq5Did1eoZxKx3wkKjrYV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep5VYcGssnJCHHcEmIYUJS7gSfX3qChUr/09TkVeU0U=;
 b=M6RrudiSU36IwwcG37VTBbH81fhUYE/pITf/H/mLyj/Rc4SZZfimpm5klULG8c6Iuh8mM58eNCHIA5Z3ImbaP28xZxHgh9HS2rV5HApGaQOdh5VKxcjpT5V0ljtFpyc2CbfyLiHoZQyQ6M8UyquILZUT5sCIPRecTxZ+QrspKoHQIKRsdx6j9L+0s2g1yvIGhoTxezhBgw++CJU4TCQkXHx81n2FadAfsUA6YzFrsitw2Ibz8Cxm3BBwvont1g5ETAVWK2h7Pw/M9i8fb9EdtMd27uQLbH6QOHyJh2H7EHVkbYRJQs19Z3FlDHGByIklCnmSfLU3P4f4zHz8G5P0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep5VYcGssnJCHHcEmIYUJS7gSfX3qChUr/09TkVeU0U=;
 b=rc/KZaRBWzb9HlFnaXiX1wWTEFldszxLK4qG7zUPpmM0T6rrHQHS0rwMAvJILyHuVUFK6j1cqTrwL6stFQr1PGHjOOYhBOPfgR+K1L7UlSUbgU47wsPzCk9lG8pw2euZcZvydKafxpP4idGscWQqZjkzpKAlDvI/UeVjzBj2vJs=
Received: from BL0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:2d::17)
 by SN2PR03MB2158.namprd03.prod.outlook.com (2603:10b6:804:c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Wed, 21 Aug
 2019 14:16:59 +0000
Received: from SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BL0PR03CA0004.outlook.office365.com
 (2603:10b6:208:2d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.14 via Frontend
 Transport; Wed, 21 Aug 2019 14:16:59 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT048.mail.protection.outlook.com (10.152.72.202) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2178.16
 via Frontend Transport; Wed, 21 Aug 2019 14:16:58 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x7LEGsMl005652
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 21 Aug 2019 07:16:54 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 21 Aug 2019 10:16:57 -0400
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
Subject: [PATCH v3 2/4] MAINTAINERS: Add Beniamin Bia for AD7606 driver
Date:   Wed, 21 Aug 2019 17:16:54 +0300
Message-ID: <20190821141656.4815-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821141656.4815-1-beniamin.bia@analog.com>
References: <20190821141656.4815-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(2980300002)(199004)(189003)(6306002)(76176011)(36756003)(478600001)(426003)(7636002)(106002)(305945005)(446003)(11346002)(7416002)(4744005)(70586007)(476003)(126002)(4326008)(107886003)(6916009)(2351001)(47776003)(54906003)(246002)(336012)(8936002)(50466002)(48376002)(44832011)(2616005)(70206006)(16586007)(8676002)(86362001)(51416003)(316002)(1076003)(186003)(50226002)(966005)(486006)(26005)(356004)(5660300002)(2906002)(6666004)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2158;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 179df5ca-6ac0-495b-3e4c-08d726423ac4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:SN2PR03MB2158;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2158:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <SN2PR03MB2158BBE36DB2111FB96ABB19F0AA0@SN2PR03MB2158.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0136C1DDA4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 4sbr/5Kx6dMWwFbK3qIjrUETSZHhYSso5q04aU24eiQhFqQh81YGQsmhoObFYsolhGwyOAI5w0Phh+iTrnlgEri4XFFniu9jEu/H2HvxjS6FKBPdO9NegGTxqAXgbJQUnq87DSUTx07m4uuWqgMpIX1Sb6nRowfn1fwPJptCRLyR36w/zhE7u41Cm1KwFtaAj1naSFSIot9mWEbeoVcaH+UHoPxhpzBAo85rhyBU4tBMo79sbC0Lpx8Cg2ssPHy8uYpQca2918jkhPjVaFR3HqXzRT7bo2ah98hpMguT3e5UPEVe3RtZrKIJ6pjwa0E6FKKIrdYHfiriZxgQbYnw29VUmZc4HX2ayalfXsb1cPgacLjstmUTaaYVUuV6j0X1vo2sM4luvthHK3pAGEUtvKmrjWBi7ZreiW93BmrEODo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2019 14:16:58.4184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 179df5ca-6ac0-495b-3e4c-08d726423ac4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2158
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210156
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Beniamin Bia as maintainer for AD7606 driver.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v3:
-nothing changed

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad498428b38c..052d7a8591fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -895,6 +895,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
 
 ANALOG DEVICES INC AD7606 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
+M:	Beniamin Bia <beniamin.bia@analog.com>
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
-- 
2.17.1

