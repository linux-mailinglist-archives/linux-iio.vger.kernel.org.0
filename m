Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72262DEECB
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 16:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfJUOHT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 10:07:19 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:19410 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728098AbfJUOHT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 10:07:19 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9LE31KR000487;
        Mon, 21 Oct 2019 10:06:29 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2052.outbound.protection.outlook.com [104.47.33.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vqv8akt3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 10:06:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxAwjfXbsKsGNjUmf/Xc+cAx3NiIn2unxqFA3Yfc0KZt8Yzl36OJ440YDn/g5pJY1vSPD7f9kWU4rloM6Pb0Pqns5uFeIYQP7RzJ6koeEk65Ro1PXWs1Dj2aqYIHStoXnmRSp9qiUnKGGOAo9q3FVvGanVKbVlPc3v1WGhHpnq4ipUt+OHSVMlBP3ggyyOHlGY0sV/YXimQl6/u5X2khVJdLQQfVjyyR3mNjWTVuGyEKvL0EJCzliYEROrR+f6ICHbVMzVK+RPL/sybRvyRzQyOj62Qh7d3g1OwTU9rKvsUin/FF8xHkSWfFub22bl/FMDVoNHqHxQ7zywwWnB4eJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84bgcNDK4gm60A+wcL4TAAWpl70oA/CilePQmCoZguE=;
 b=Gs3WDnp/w4wF/2Xirm0thskCiFzOIhSvBgl+lJnls3ewF0Qeyw0trtKPYYFc3rUEAZb2SFbIhTgnmMu2rGjlJvscUcxGOS5svzDKgBanD4H2d1bSQHQl/NBuMZtrX2tAjavMbYjZe+SLwslEUox265CVEbT0uS9kznP3fl59uPKh3a0/tlkLxr7suln1Ap6K5RUIEhSufihzoYxsTrKA5DMJxBbRMqNcvRr3RWCdqY0zoD6lOn1hKGLxHZurREz1Gp9CPxulJePwU+5/5gqLF+cozwMi7GxvIwUotp5bAEqYEAKBIxnugCcdjyxDQO97c05QNuKOq9oTsbFdJzxBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84bgcNDK4gm60A+wcL4TAAWpl70oA/CilePQmCoZguE=;
 b=W5Wz9/PaXVMmLgahgNQjcQ7/AJLKLwTpqo0GYpri/Zr0dtXch8Ad0/yYFG59kxNG92QYy+MyZXw0+ZDoW8+n+8rrcb5EzgDTnqSS8RSZvQevuTrYwVa/fGR/4R+FjaHmyF5l51LpeCjusV4ICSw6ulJQY0d+4PHwT/VsmmhacsU=
Received: from MWHPR03CA0017.namprd03.prod.outlook.com (2603:10b6:300:117::27)
 by CY4PR03MB2695.namprd03.prod.outlook.com (2603:10b6:903:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Mon, 21 Oct
 2019 14:06:28 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by MWHPR03CA0017.outlook.office365.com
 (2603:10b6:300:117::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.21 via Frontend
 Transport; Mon, 21 Oct 2019 14:06:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Mon, 21 Oct 2019 14:06:27 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9LE6KMr013315
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 21 Oct 2019 07:06:20 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 21 Oct 2019 10:06:26 -0400
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
Subject: [PATCH 4/4] MAINTAINERS: add entry for AD7091R5 driver
Date:   Mon, 21 Oct 2019 20:06:08 +0300
Message-ID: <20191021170608.26412-4-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021170608.26412-1-beniamin.bia@analog.com>
References: <20191021170608.26412-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(189003)(199004)(106002)(316002)(8936002)(48376002)(8676002)(246002)(2906002)(5660300002)(4744005)(76176011)(26005)(50466002)(356004)(6666004)(7696005)(51416003)(1076003)(11346002)(86362001)(446003)(44832011)(54906003)(186003)(336012)(50226002)(16586007)(426003)(2616005)(126002)(476003)(486006)(6916009)(4326008)(6306002)(107886003)(47776003)(36756003)(70586007)(70206006)(7636002)(966005)(2351001)(7416002)(478600001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2695;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2a81c24-8299-4bdc-bc19-08d7562fddaa
X-MS-TrafficTypeDiagnostic: CY4PR03MB2695:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <CY4PR03MB26958F2D106A4720AC278B4FF0690@CY4PR03MB2695.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0197AFBD92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JthcmkJu5xOaIt69rjiqgnBHzmqWOswsrTN2oi8gcobX5k9RzVgLe5e8CoFANhBJVb4WL46ZzzmJv6yvRmmmAdJ8Tivo0LWFBAkR46tCddTeHUPtA9Q0sVNqJ2N4b43g3MkdRCWmfyNRoWS8gEYysYcCreV+MdBoIMbLZEJpGs0FvJ8Sc7h/V1P86smYKjQrHTBsWNPd5e+G0mcR9vMnZ1WbT9n/67v6LPd3j9RfWQqMEQCbO1ut0bZSVeY2tzUpJmy9sCeSp34z68PTSXcn2W5Q19A0Neolntsp/vsAWkzWfVXHCc9k3Ti4cfYLnjRSXI+/THaZc4ONR1WKIExXzHdH/Rx5h31PUUaCBWN7NS6d6nmwYW3uUYSpi6c/54uOim6lywXqy4dhq7AP7tX25TvXgB/KqswZTJ95vjEEIFKqd/S1kyJ20ZvEYPdOnRf8k1x+JN60LKm+FvIoTEwrmq68C4MYpJKzBEdOSMOAKAs=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 14:06:27.7219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a81c24-8299-4bdc-bc19-08d7562fddaa
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2695
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_04:2019-10-21,2019-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=1 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910210133
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Beniamin Bia as a maintainer for AD7091R5 ADC.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
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

