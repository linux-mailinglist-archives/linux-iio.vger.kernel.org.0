Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C02077F455
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2019 12:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392000AbfHBKEZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Aug 2019 06:04:25 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:44198 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391927AbfHBKEZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Aug 2019 06:04:25 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72A2Q7Y016079;
        Fri, 2 Aug 2019 06:03:41 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u3vjx3wb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 06:03:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUFRjYtJeAXyFE2+pi9iNJzCch5HUqJiIRB3GSzOylHahum0Xq2x8WnD9gZdbeYIgCxIhm4hk02EyJ9VmMOm307072rwmk2ylacuFY/J4lR/xJqc9VQ55ymynv1cQY7Nzj+w8txRrPrh7YqG25/uyLmtxEB+65EG+LDVybAUL3Jm83wo8P56xRFdnEcMGtkEd+uJKlrrAsXGnZc5xx0tQXX3q1xfnQCrjv57FL4U+PRp/RbxBXSyhjE3RyBK0vSQPPSW1SXufn04dlDLQfzQmp5gkOuAzgRJLVQBZotcnjqhcuioop7PfFFk2s4l0XykugNtc4lsUDtMWQODDIRTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GQvgKnWudeg7pa12x9iU/vW0nLNy4M8vHLuzwgWGd8=;
 b=GeBchfxbmP/5ZiO4GJYcx3/yNJGDqYdqEA+qjAQkpFUp8gXTJ/oyyGbJeJIqEu8WpBCORVqgiGhXQ7l7dUVYgDm8IaZUL4EM6yRjdfNcWriR4ytbafJPRQpIIlAdf2/8FGrcax11t94rck0UCFChFFhw+Zx8H4x/7HYdPmFS8yEeHFdhffZq0RCIsDPvkNKzxmU6oJmUQR3XqJ5AFrGvw9Da/scWkDM9tm1d29FB3/T8zzIA6Tdlj4A5h+ioaJWcqkeZtrtxWkyKg90PtqmkgftBDGB1jbJ0dMUtMDMz8kFZkWE1KZyQAXBuT/tfpHbNfDo+y3GPz+QleAHrDPItmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GQvgKnWudeg7pa12x9iU/vW0nLNy4M8vHLuzwgWGd8=;
 b=T9qHyHp4wIhLunEjtPDBd4ZMmPLYqPeT74ZmZKietyB0PQNCxLWoBrW7d7fVwCHVOLf15u7S87Jpu8ZYj3zSK6ga4YY/8PBWXa3TSshbLY70Iwsoyk4pRboPUtxyyPcCxLbitAnbJFsgBJjk3zYLY6xKf3dWCJOtILql2znuIeI=
Received: from BN3PR03CA0101.namprd03.prod.outlook.com (2603:10b6:400:4::19)
 by CY4PR03MB2807.namprd03.prod.outlook.com (2603:10b6:903:130::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.14; Fri, 2 Aug
 2019 10:03:39 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BN3PR03CA0101.outlook.office365.com
 (2603:10b6:400:4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.14 via Frontend
 Transport; Fri, 2 Aug 2019 10:03:38 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Fri, 2 Aug 2019 10:03:38 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x72A3cWA025310
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 2 Aug 2019 03:03:38 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 2 Aug 2019 06:03:37 -0400
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
Subject: [PATCH 2/4] MAINTAINERS: Add Beniamin Bia for AD7606 driver
Date:   Fri, 2 Aug 2019 13:03:02 +0300
Message-ID: <20190802100304.15899-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802100304.15899-1-beniamin.bia@analog.com>
References: <20190802100304.15899-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39850400004)(2980300002)(189003)(199004)(107886003)(50466002)(16586007)(2906002)(966005)(8936002)(70586007)(54906003)(47776003)(36756003)(7636002)(126002)(336012)(478600001)(106002)(305945005)(70206006)(1076003)(356004)(316002)(11346002)(4744005)(5660300002)(6916009)(186003)(4326008)(446003)(76176011)(426003)(7416002)(50226002)(7696005)(86362001)(476003)(246002)(2351001)(44832011)(51416003)(6306002)(8676002)(26005)(486006)(2616005)(6666004)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2807;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84ba5a29-432c-4c3a-fcdb-08d71730b0d6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CY4PR03MB2807;
X-MS-TrafficTypeDiagnostic: CY4PR03MB2807:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <CY4PR03MB2807118966A34384E61B3985F0D90@CY4PR03MB2807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 011787B9DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: DeKyz6kxyN7hpeUb+3tvsZ2rAOiYxXaZ5ux+0JYwdeXnTj0fffXXALD9FTjXdHcwaiOKTldjA8j1oLzHk2XcZnMfaInYdO1jo5//PQNxU0QgpDrgWjjdRJYRaPUOwtSM77rnStHRPj9BMOmPLPtxG7mr6K5qD+WdMaXnj1t0TYGcSiG2/qhzDDy7lzNsbqBoN0oyKRsoEG4NeaumSVC7EnbwPrtU0UtfjHX2WF5WHY1f2WySgokPgvB8bN75z9S8v+UptTyNYoyUTZNqGL+vlgtBKggNBsFjN+jqj+bkdU+ua8UyZ9HhwE6cIDXN6Mp2Tk3U8w9SiTnfJH707o0tMv//5JsZH2KWtpfYndYYvacv92rroLmWn4IIqDdJgb114Xf7FZb7IXt18v4td4ZP/8Vo285CQ90ibJoRJDlP+y0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2019 10:03:38.7962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ba5a29-432c-4c3a-fcdb-08d71730b0d6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2807
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Beniamin Bia as maintainer for AD7606 driver.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
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

