Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50197E8A06
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2019 14:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388923AbfJ2Nwk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Oct 2019 09:52:40 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46200 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388294AbfJ2Nwk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2019 09:52:40 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TDlsPq024029;
        Tue, 29 Oct 2019 09:52:14 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2059.outbound.protection.outlook.com [104.47.32.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vvk26f4s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 09:52:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQpD3Y2Tgme/Bnx+fJWRA+Tw7LQibR6xqBdeQg6ZMfAqKvnf45ov8Nv3YjIFKWONNJ/EGqhR8fNjrjTWXev1bzD6t2iBgH+hdecZqk0nykh1PnE2bixFeP3MjckZsAze8veU12OAUGAfZptUf+kwklfdgHKBrvj/flLNMFt4ccIGlLtCNTcD41MMAevwB8jU668WgfEj+1alJFwKd0VNolYe8fIWQWBAjPCN8HCcpBFnyeCp90BwgwTX8wOIOzh3Se2mtXh5CWiN8NQu/zrMCUACC0MbcAgceJw8w9tEUZrvn21ZTwWDYPKJKj2Vm85bIJPcE7Tl+1ycSCcc+FgT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hDD8b0bGRPVx8DUhOmfebYAy7xhfl7NFy8y6rLjG6g=;
 b=nS8DLo8oUAJEyD925xXxI//QYTQJlbGipxNsoQg4onEkCPFkp9fw1pgkL4K3/3i/V/0HXP7vcnMaHnSGHmED2l3VTYPjnrL54BWixHWL2FR1F3dD4n+EwOQomPIoIQj4Tluj2zIj19BUY4qCAtuGUofz+fG+NOnOAv1/PTnlJdbfcmhAjJz+J2iWAl01pmua1PVrItBBGX6HBr4uXmRXBi8CBmGqaPkMVClcUSBzXQkK4hfBCXjQhXE4mdMfY6ZzVLMHsewNhd/IbSVxweCl8ubC58GGe/Ej1EX4yAASZwr8ubX8+VziA3UpVEvWXNYNmUm5imA5e+FBtFaG/XB9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hDD8b0bGRPVx8DUhOmfebYAy7xhfl7NFy8y6rLjG6g=;
 b=EeCNSq8ZAonicKPJ/VNyKWlTb8zb6LZooATrpN3pvSierSbOxeRhI3sao3Xr4mo2oxZOggcC7q+g4TOymw7et0da3+v7LaEM6gOavmnt6Ya/9LycXsDy569a1KvH7xxeRooEOc8ZoGKJMejFlFJ50tP6pSoid2nRsolpVQD6qKk=
Received: from DM3PR03CA0015.namprd03.prod.outlook.com (2603:10b6:0:50::25) by
 SN6PR03MB4413.namprd03.prod.outlook.com (2603:10b6:805:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Tue, 29 Oct
 2019 13:52:12 +0000
Received: from BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM3PR03CA0015.outlook.office365.com
 (2603:10b6:0:50::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.25 via Frontend
 Transport; Tue, 29 Oct 2019 13:52:12 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT041.mail.protection.outlook.com (10.152.77.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Tue, 29 Oct 2019 13:52:12 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9TDq4Qs031817
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 29 Oct 2019 06:52:04 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 29 Oct 2019 09:52:10 -0400
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
Subject: [PATCH v2 4/4] MAINTAINERS: add entry for AD7091R5 driver
Date:   Tue, 29 Oct 2019 18:52:24 +0200
Message-ID: <20191029165224.11164-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029162928.9720-1-beniamin.bia@analog.com>
References: <20191029162928.9720-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(199004)(189003)(48376002)(54906003)(478600001)(8676002)(2351001)(106002)(8936002)(246002)(2906002)(47776003)(6306002)(107886003)(50226002)(86362001)(70206006)(70586007)(4326008)(6666004)(966005)(11346002)(76176011)(486006)(446003)(2616005)(6916009)(126002)(51416003)(1076003)(7416002)(26005)(7636002)(4744005)(476003)(186003)(305945005)(316002)(16586007)(50466002)(426003)(5660300002)(36756003)(336012)(356004)(7696005)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB4413;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 134b07c1-e0d2-4c8e-4d52-08d75c7732e8
X-MS-TrafficTypeDiagnostic: SN6PR03MB4413:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <SN6PR03MB441396D05D161CAE935C911AF0610@SN6PR03MB4413.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7XIdFSmIiu5Wgpfg+Qpq2yZXgvW3ehqdO7VzFgU0kiWfsQsu48DQ+EhZUFTrEe6r4AO6Zmj+eDMab+J3EuzpJbGl7iUZxJZkVayCHDk4Mu4bITZyHFCVuj35OmnN3cWd5lWEAm/PMCA9ACVPMbP3L3Lh0/vn9aYdl6ldkQQEdW7Muy0WnDCpIfAFTcaDlsMlBG4qRBh0qMBYGVd3smXQT6WhWWHL2tRAl8cZNyfDZ6xvnru6fFQWSbogz8G/T5+iRLfDI3vWQc+kOSIviHUD9y36cM8vUG5rT2ydj/cSzxS6WDBpE87DufRFinnIKUOPX754jsnOeqnwVG230bUqBJYVMpFhi/QsoOGkMQdK7JEiesSmAWdaFLYegh5fRBK/N7QvTepBhj8kdJi8dJl0nfmFj+qs065FKgvBf+DHBhJH+wrc12Ubkx2krxyGBZzR6k9xS0WEy7XPEqpVmtfRgT5lfgmoDw2F0tTSDT6Pfs=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 13:52:12.0562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 134b07c1-e0d2-4c8e-4d52-08d75c7732e8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4413
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_04:2019-10-28,2019-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=1 clxscore=1015 mlxlogscore=999 impostorscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290136
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Beniamin Bia as a maintainer for AD7091R5 ADC.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v2:
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

