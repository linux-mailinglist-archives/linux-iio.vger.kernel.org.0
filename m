Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45BAE138EFB
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 11:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgAMK1Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 05:27:24 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:13040 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727014AbgAMK1X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 05:27:23 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DAQDkx022959;
        Mon, 13 Jan 2020 05:27:21 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xf90ev3b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 05:27:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfZ2cXNOOtXzKYpa1sEHwFGK23xcqjNs4AfeV+bNoiC6qYqCijL0DvsA/HBFBilntxf8Ev6+5JIE9YXi0Z8ga2In1TS2k0uoj3GHHU+Y74qjFb6GecnuXSCGrZPw3YeFcbXloKCTl7wzWoEllvdKAETcgbCmsjcOKTAMo4/oMig3cLGirX4KecXUaH6Bzw9MPrV7HVpq/5d8/FQq358XUyktQpr2Huuu0ou1HXoGOPfVRImQEOK5S8dJON3NzpUqrxganJmpgYjvgA7+Ne0AUf7o4xjtuwwnejyJC53wxW3p9QYF+LGD3fmFxCwDzVh+JkF87LABvTLU6tHnOKfCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZAFhRT+vGLHsksBZcnEMi2XKXRyydyH/++tGU98TnA=;
 b=YSAZqRJU8Y44zZtZtGBaEI/ey4Wbbioyzj4uRxnYoIJ/yqm+mVbYA6rs1Q9VA5hUGRQbswxbFy3HVvU7oXNBSUmRq2qAU5S4FDknxWK5PAwk5T2GH3I7DUE4BGEDXmY9b7DwxmASv5T14L/Td2HZp+bAOSBxe9XqDLq6Gh4zEX4Zg6CkCQ5Hse0kg0AGlj1bwzR/VToLkEPokBmGBOKEU5+YzH96xt+6Pzoc/CFT2un6SW7lTRWnDhXjiwJVDsOlwfaQ7vRO0YmrB+voaBOEiESE2W1oRfC+DPMHJwnEXt2CAcyxQZAtQvB4LX6yGo8HKgOa4CC+vxV7AhtGIHZsMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZAFhRT+vGLHsksBZcnEMi2XKXRyydyH/++tGU98TnA=;
 b=3MJED2R8ReItcXu+mTg5zYrwWoUZEfnQUjutCQL6kgZ0E+JrjliwtfLfmIhKdNemn0zW8dEADz7fnsrl2S6A8g6AoDCcxhfCtijAAvF/tfh8fYVPWLqHm/nuSegwG67DKorb8f/qSBQSZnCREq8IaEYu0a1rAtKf05RtiviEef4=
Received: from BYAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:a02:a8::16)
 by DM6PR03MB3771.namprd03.prod.outlook.com (2603:10b6:5:4e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Mon, 13 Jan
 2020 10:27:11 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BYAPR03CA0003.outlook.office365.com
 (2603:10b6:a02:a8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Mon, 13 Jan 2020 10:27:11 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Mon, 13 Jan 2020 10:27:11 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id 00DAQwf0021628
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 13 Jan 2020 02:26:58 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 13 Jan
 2020 05:27:09 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 13 Jan 2020 02:27:08 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00DAR3HR000879;
        Mon, 13 Jan 2020 05:27:06 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 2/2 V3] iio: adc: ad7124: Set IRQ type to falling
Date:   Mon, 13 Jan 2020 12:26:53 +0200
Message-ID: <20200113102653.20900-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113102653.20900-1-alexandru.tachici@analog.com>
References: <20200111112317.1cf2d878@archlinux>
 <20200113102653.20900-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(1076003)(316002)(44832011)(2906002)(8936002)(110136005)(36756003)(2616005)(7636002)(70206006)(70586007)(356004)(6666004)(5660300002)(426003)(336012)(4326008)(107886003)(246002)(8676002)(54906003)(186003)(26005)(86362001)(7696005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3771;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 396c97ef-4407-408f-112f-08d798132666
X-MS-TrafficTypeDiagnostic: DM6PR03MB3771:
X-Microsoft-Antispam-PRVS: <DM6PR03MB37713EE1C1D68E888725A20B90350@DM6PR03MB3771.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 028166BF91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75Yc7LbP5owHWdnNvzEN3av1xp1AURoBGnyA6F9spXvo5kFYUfIu7QJ2SGuo8NaEVnutjlr09icVaKuhfyxmBBp9opiTwtcyGZDKCrCdrd2WXCSmS7Nxxvq/iUCjes3CVYJLh81GlCtVEhqEMKgae38HLgR8bchMV5S7sBCySN8wxVkeJfRwGbtmDm4QI7VWwtVifa5Vff8P6xoAvZhpzfBWaaVLIclAQEXoVik/4sddvEjfjcqLyo/u2jVicQ8s0nee4mts55KMzPXZwMKOvnD7xq+VYFy2/KGYjCwWGOtIEMKcJKyHMj7IO15uJS1yAbklWOKMUIFdVwebT/1BVskvVW+12jXpd+4Vr3nxTTdJRpJ6cH/Q8N/G9K1YVTVh2IP+fqdgR/LwrsMT1Ey7PWXt0KO3Dbw8lvE/z/8KgVVguSYMJzfeOT4KBHjbpjg9
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 10:27:11.0747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 396c97ef-4407-408f-112f-08d798132666
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3771
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_02:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 mlxlogscore=856 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001130089
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Ad7124 data-sheet specifies that the falling edge
of the DOUT line should be used for an interrupt.
The current irq flag (IRQF_TRIGGER_LOW) used will
cause unwanted behaviour. When enabling the interrupt
it will fire once because the DOUT line is already low.
This will make the driver to read an unfinished conversion
from the chip.

This patch sets the irq type to the one specified in
the data-sheet.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7124.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 9531d8a6cb27..9113f6d36ad4 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -223,7 +223,7 @@ static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
 	.addr_shift = 0,
 	.read_mask = BIT(6),
 	.data_reg = AD7124_DATA,
-	.irq_flags = IRQF_TRIGGER_LOW,
+	.irq_flags = IRQF_TRIGGER_FALLING,
 };
 
 static int ad7124_set_channel_odr(struct ad7124_state *st,
-- 
2.20.1

