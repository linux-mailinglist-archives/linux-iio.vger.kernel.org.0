Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C97132757
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2020 14:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgAGNOw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Jan 2020 08:14:52 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:42188 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726937AbgAGNOw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jan 2020 08:14:52 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007D4oRM004440;
        Tue, 7 Jan 2020 08:14:32 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xawstxjsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 08:14:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeevS0UdG24n95AqYNw/2IvsR1y8BxfZLR1gaXxHrxwntWqFX7l+iC3r4RMqALmQW6thvlN+VSzqMDLVW2WhybXv1sZUGXcuAmHnzSOdyHgg70rivDNqBa9Iz3M/DAmXZBMFv/Y5m+Ruz6EPTpzpyj5GMy2U+X0bB9EctBzmh+BkEZfTYh53qazqr4XgD4lB2TzUdxDxvYvYbXX7iQ57MKLawIKto0szXv70lTs6H1rfgXJPFVT5B9Zywjc3IB7i9uV1cm8imOXO+8/9ab15J6XPYLN5jZvR33hBCL7lnMVa9jLmCzgC7UdU6MoVEiKbO+nerFcQH73ULGlz+LWBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohdjSubfuKJzy0ho+q3GNCS+KZlRUqCGky5qlUPniQs=;
 b=YteAvBicv1/FadBBi/y58oyVyNsFhl2e06Wfaz5Z020Qoy3Cj62DPht+S3CuWSDBuBgqBfio38+YEB8I+APMMcv73+zIMjpusEEVroAPyk2u0JOKnSfOnfSSm9v/m8tgsVQZg+YqAnSPqapZM/qnpmPOH8eA3VrTxQLZ3l/cusThuMs1w9K70GLvTPuELbnaIOXqo/rQXAnZAczOEA6810s9hdxdjngtjp98kqh+Wwg9OVohRHLqMXNcysqk3DNCCrtMZwVlzrPTpte0Eif53KitT4JwQhildVOKDibFzWu9ZYupND6+wmQ4vuBV+OIEsx368zjIIULIY/ZLt3KPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohdjSubfuKJzy0ho+q3GNCS+KZlRUqCGky5qlUPniQs=;
 b=Bx55O99t+iAonMIJqsevBE4sKG3OmvAeZK0E6F/bmPxaSyN9NPgz7+o74fzcJ3E5zzrfNSUS7CRPGUI8QbpCiwmowxbX/S5FUueoPQvB6Aa4IPdx8I6fG54j9OptWDOXgnSGYFkgioc2fb43g0GBL85VwGEAdTa3Y2rBaTXH3Xk=
Received: from BN6PR03CA0094.namprd03.prod.outlook.com (2603:10b6:405:6f::32)
 by DM5PR03MB3017.namprd03.prod.outlook.com (2603:10b6:3:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.15; Tue, 7 Jan
 2020 13:14:31 +0000
Received: from CY1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BN6PR03CA0094.outlook.office365.com
 (2603:10b6:405:6f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10 via Frontend
 Transport; Tue, 7 Jan 2020 13:14:30 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT059.mail.protection.outlook.com (10.152.74.211) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Tue, 7 Jan 2020 13:14:30 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id 007DEIxo030797
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 7 Jan 2020 05:14:18 -0800
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 7 Jan 2020
 08:14:28 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 7 Jan 2020 08:14:28 -0500
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 007DEIei000913;
        Tue, 7 Jan 2020 08:14:19 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH] iio: frequency: adf4371: Fix divide by zero exception bug
Date:   Tue, 7 Jan 2020 15:15:59 +0200
Message-ID: <20200107131559.17772-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(8676002)(36756003)(26005)(8936002)(246002)(2906002)(86362001)(6666004)(356004)(7636002)(6916009)(4326008)(1076003)(5660300002)(2616005)(478600001)(426003)(316002)(54906003)(44832011)(70206006)(70586007)(7696005)(186003)(107886003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3017;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffa6c55e-526c-4e79-e0a9-08d7937387af
X-MS-TrafficTypeDiagnostic: DM5PR03MB3017:
X-Microsoft-Antispam-PRVS: <DM5PR03MB30176899F74A72D3D80655EBF03F0@DM5PR03MB3017.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 027578BB13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWbLDLLScjXYY0WMhl91LzxJyMHJhP+UyFeQXsXej6MrTbWP1O0ZZJF+ED681Lad0Fnr558WeXz39lSpm3w35mVfaPHWwMYfAp+yNSVmIfU1dHGJQK5bKOCoYdvtERgPcSUAhL2JZw//fEwkZKZ/R3Ko0W/IzI4vOUbJjPG9KSscIHhuNoGr9MmkglgboHl2TFxoW4u9JVIn0tacCONcxt6i7+srgXQa85tTT794jhe2IImL0fgICzg6X1aCW0BHhNSbWiDHaFsCXZ5JznbiX+U6YYAhs0W60/fnkAJPKgoTuGOU2KZgxQph15G6k/RivdKOfHSWqn0VaP6Fw/7mYSC2vnAklrwTadLBCrX/SM1mum9ZEul38UHeOsKMV8VWNyyN8rLtXdgLhOyM2ULOZOcJ4JuZAhOhk8v9cng/yZ3CqxDR0c0JZG2raAak+2Qx
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 13:14:30.1826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa6c55e-526c-4e79-e0a9-08d7937387af
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3017
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_03:2020-01-06,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 clxscore=1011 suspectscore=1 spamscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070109
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

During initialization adf4371_pll_fract_n_get_rate() is called on all
output channels to determine if the device was setup. In this case
mod2 is zero which can cause a divide by zero exception.
Return before that can happen.

Fixes: 7f699bd149134 ("iio: frequency: adf4371: Add support for ADF4371 PLL")
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/frequency/adf4371.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index e2a599b912e5..c21462238314 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -191,6 +191,9 @@ static unsigned long long adf4371_pll_fract_n_get_rate(struct adf4371_state *st,
 	unsigned long long val, tmp;
 	unsigned int ref_div_sel;
 
+	if (st->mod2 == 0)
+		return 0;
+
 	val = (((u64)st->integer * ADF4371_MODULUS1) + st->fract1) * st->fpfd;
 	tmp = (u64)st->fract2 * st->fpfd;
 	do_div(tmp, st->mod2);
-- 
2.17.1

