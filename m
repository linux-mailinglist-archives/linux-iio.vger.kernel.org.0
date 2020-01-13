Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B223139348
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 15:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgAMOOy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 09:14:54 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18614 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbgAMOOx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 09:14:53 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DEADAL022811;
        Mon, 13 Jan 2020 09:14:35 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xfbvb4cuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 09:14:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4Nb3HSiNQabqXNB5yPDVTrOKQizDEkZ3QgwD8vQPAcsb8kK15wOBIAYdvqN8T/3c0jaoULbu1PIwsS34NUmXVFVjEgwaeQjwQ+n8u5VCKJughCGy2Eui7R+T5vSUaTHSrGPzzYH0H7gQ+/cw+jdU0g8NJKriw8y0KKASI/M7IF8qnYBf3sNYRR8/ww8Esh0mM28J0SwIrIRi3cd/unMv24T5Fy05zW9pdZz4t2SIDQw/l/gFuMrYxCVhLSsKU1YU7eRhoJmjseYPdv+J2krI6j29d61HdiAs2RSMNjTqyWo8UEPMeQfmS34fMNT/hYzPmbOFpP9IlVhEdQ843n8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL/jo2PNXj/RQlPLGvGkCqfhOMGgRw8D/AqnzZW5MGU=;
 b=bedbumN4GnyoovHuO4WqeGbTchiEd0CDqi+UunyWpn0RH4BY8xMHOpOWy0Z8GRd8wqR2aAsD2i3mYMtgEUvC/eSwQ5GU4q0/DeAszwuTZMwoRVHD1luo2ydMP5CGOH/bbMB3OvSQtOWdzmQQquPHyL/rEvfVMnIB6JOsvikkpfd199HfbB+Qrug7889hbky07nhEn0WmcQwsWXWKCeLgjgMakDOD8CthenM0eTgZATO0Uz/K5qSJgAY8Qy7dE9x6qDhBtLW1qMP8GySgzdQ6LopTkH7fpYOTtiUIVORjt4q4TEyUPkblXIsNjjKK72zGfVpT9yfb/ziat9xTPS2viA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL/jo2PNXj/RQlPLGvGkCqfhOMGgRw8D/AqnzZW5MGU=;
 b=Cm7ER3KV4gPK+iDnbMhETq3jIvv8Xobh8V/WnRLoLDhAGSjx3PNH5ruiq5xsuh+nVjEFVolye4a90dc47l94JitZyMovkmtCj2oAifmwznB3p3pVoKM5jmye2kB/K1206ddpoRaG7NRggAs5wCoJWIO7J3tdE0YzKnEIM2EAetE=
Received: from DM6PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:100::49)
 by BN6PR03MB2993.namprd03.prod.outlook.com (2603:10b6:404:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Mon, 13 Jan
 2020 14:14:32 +0000
Received: from CY1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by DM6PR03CA0072.outlook.office365.com
 (2603:10b6:5:100::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Mon, 13 Jan 2020 14:14:32 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT026.mail.protection.outlook.com (10.152.75.157) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Mon, 13 Jan 2020 14:14:31 +0000
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id 00DEEU0l031504
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 13 Jan 2020 06:14:31 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 13 Jan 2020 06:14:29 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 13 Jan 2020 06:14:28 -0800
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00DEECCW005491;
        Mon, 13 Jan 2020 09:14:24 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 3/3] MAINTAINERS: add entry for hmc425a driver.
Date:   Mon, 13 Jan 2020 16:15:55 +0200
Message-ID: <20200113141555.16117-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113141555.16117-1-beniamin.bia@analog.com>
References: <20200113141555.16117-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(70586007)(4744005)(70206006)(1076003)(2616005)(316002)(44832011)(2906002)(8936002)(966005)(36756003)(356004)(6666004)(5660300002)(7636002)(6916009)(7416002)(426003)(336012)(7696005)(26005)(107886003)(8676002)(54906003)(4326008)(246002)(86362001)(186003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2993;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c0a0699-0665-4f16-8d11-08d79832e8f0
X-MS-TrafficTypeDiagnostic: BN6PR03MB2993:
X-Microsoft-Antispam-PRVS: <BN6PR03MB299340404947EC39D2919B62F0350@BN6PR03MB2993.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 028166BF91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPYSWhwh5Dzr63saNbp3736hu8QKjrxlixMoc1LrfnI+l5wTXz5WxzGb1Zt++wgDwMnfiqco98/boGFua5G7VKK7wHtkykufydxyV6NfdeWVn6cO+v1CGEISrDx5b8gCzbZGXGxO7FKSGYOJDXNdV2RoRPyKwr0Ga5/3rfcz7pgivBZ6G5ua5kznzqjgrdBH8Mcuw8mjUn3t3dPEr0vFPk7o1YUjytyBClEMmxeyymJ7kSM4zD7NqGCXUW5JFtkbhcqr2Fby+y2A44ZaVOI/phWHYgTwPEwIPHLmTCfm1hIMIO3pbMnL4SBJnxjHjuVSSEtB2/6UmCbKF5+c7/FUUyQsMQgIONdMEJmlf4j9y0KCzIe2Gc76P6oMeZsIpjQJ9UgREhgJUdjTj3pDTBCsxDe0Nm7hEUWh0+Mt3owPVnECD263FfB1Boxwx3HvlvUHxbmBSeuwxGhEMuUFZP5KlCVBc39RFEbRS6uqlVviSuk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 14:14:31.8648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0a0699-0665-4f16-8d11-08d79832e8f0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2993
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_04:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=1 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=967 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130117
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Beniamin Bia and Michael Hennerich as maintainers for HMC425A
attenuator.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec05a06d7ddb..9ae436d67edf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1057,6 +1057,15 @@ F:	drivers/iio/adc/ltc249*
 X:	drivers/iio/*/adjd*
 F:	drivers/staging/iio/*/ad*
 
+ANALOG DEVICES INC HMC425A DRIVER
+M:	Beniamin Bia <beniamin.bia@analog.com>
+M:	Michael Hennerich <michael.hennerich@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/amplifiers/hmc425a.c
+F:	Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
+
 ANALOGBITS PLL LIBRARIES
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 S:	Supported
-- 
2.17.1

