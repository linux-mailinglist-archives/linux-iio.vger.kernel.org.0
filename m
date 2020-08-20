Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A1A24B107
	for <lists+linux-iio@lfdr.de>; Thu, 20 Aug 2020 10:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgHTIbg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Aug 2020 04:31:36 -0400
Received: from mail-bn8nam11on2048.outbound.protection.outlook.com ([40.107.236.48]:6817
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbgHTIbe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Aug 2020 04:31:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPhQ2FgGNS65rmv39he/tB7A5UQPdVwv13frmgsifVQ4qu56QJdg8Al97UzvDGJcwRz3lYs6z/m9W1C4EPyo4U4iCU5/bkGfZFgJY4oNLrk7rcU5Ap/wlRQMj6Olrguh6rE1cKI9cYoFCQl6j9Bf4S8t20EPcHSc8v9BmACHdl+eBCWh4UB6Kd2iE4E2XuJSBHgjYlldzbt4qs5D4hzam8XC6maqYNwZpNhBR1pcFkiTXprqUwsnqlmVQmJSRDfVZZZfXF+GanfN3MA8lLAxFVfcmOUKDniQB27duUe3hXHE+bUlrs8Yft5XYVaa9yL4PIXQ3IeGMxKwArUBcGHLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V2es0Anfz+eC2uZbriqy6jOeJ12Hq5a3VwcieB39H4=;
 b=iCIqnhQyZ4Jko59qg3BzK1ATuLR3snzeLQbapvrVFNeh+jdYdcRyPIutb8uEmJZ/yZdz0dJszEBHoiBJxjPamrNgmP09uxgwjHOvLHOcuQWNHWSH4ff8y9z7+W4+ZEtSG1/peVslEIWiZHIDOy3wj98zKSejuqS7JggZCxLIioFjya/2g7uSptBj73a8zdbzrujVr9Oy9BE5ExFiOv+WCkXzwP+qOPZBaYWFXGSqQQsl9opFpLZrsJhul01MrAB4dP8tTW5AOa56yuVgMFKjtxktlyQvqyPzFlrsniZrcvDr9WHVtnCD6YWQJ4Jl/HL7NC4QJ8Xswh464yTJ+WhWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V2es0Anfz+eC2uZbriqy6jOeJ12Hq5a3VwcieB39H4=;
 b=ZPxYklGa1qn3IXtiriAqOqXUJxPXC8SGiJhIlfQzOvhEeSc22yrbOwpq/3ulCGSZz81ZVngP/hcZ0bHitTarCRoK8EINyE/HyC2XtHPUK9RE2hs1b2nSgo7SvtFHsxRA6Zw6ilZJx2M8vEcbc8lMar8mWC6YcaJRMZwwZ1Tn/L4=
Received: from DM3PR11CA0009.namprd11.prod.outlook.com (2603:10b6:0:54::19) by
 DM6PR02MB4042.namprd02.prod.outlook.com (2603:10b6:5:96::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16; Thu, 20 Aug 2020 08:31:30 +0000
Received: from CY1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::48) by DM3PR11CA0009.outlook.office365.com
 (2603:10b6:0:54::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Thu, 20 Aug 2020 08:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT054.mail.protection.outlook.com (10.152.74.100) with Microsoft SMTP
 Server id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 08:31:30
 +0000
Received: from [149.199.38.66] (port=51266 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1k8fyX-0002EY-LW; Thu, 20 Aug 2020 01:31:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1k8fys-0007iK-BP; Thu, 20 Aug 2020 01:31:30 -0700
Received: from [172.19.2.102] (helo=xsjanandash50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1k8fym-0007hr-Hm; Thu, 20 Aug 2020 01:31:24 -0700
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, michal.simek@xilinx.com, git@xilinx.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH] iio: Fixed IIO_VAL_FRACTIONAL calcuation for negative values
Date:   Thu, 20 Aug 2020 01:31:22 -0700
Message-Id: <1597912282-31254-1-git-send-email-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 03e25842-8734-4377-b613-08d844e37053
X-MS-TrafficTypeDiagnostic: DM6PR02MB4042:
X-Microsoft-Antispam-PRVS: <DM6PR02MB404218FE371DCCA3A177EBCBA95A0@DM6PR02MB4042.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: taqfh1Wm03lt7+gjo9YWyJqwuMQ7V0mKt8PjbKvBDvzLlMHUmsiIla1Li0G/9UBMc9PDJHu6f/7+cb90S1I74Q7aSUIT1XzqRo360LMYmIpQDmV2cSD8PdMtVwYZouZEvSntWbrUcY5JpgVXqAcLx0+/4ieqDWyHo5tcoyWjCrIBg5LNePiqHudCKHLDOEKp/YyWryT5CrEgUqIh8XkV/ZtBl2UoqKc4vqSmP8PMDj+UZZB40QYF/UHkgevv+VhqtuMC5YZvd7B++7Me2zK3n2JdgWV20ti2GyHItDTLlOxrAepWwbGalALXUTcG6Dgtq07aJsFwJQGGFeEeGFwbN3pTyCttekkGbfVCtiuvJppbRkEChST+Dc4npgePXs9nvdb6snMAll6DDpFo9i3ktQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(396003)(136003)(39860400002)(346002)(46966005)(81166007)(356005)(36756003)(426003)(70206006)(5660300002)(2906002)(70586007)(7696005)(82310400002)(336012)(26005)(107886003)(186003)(9786002)(316002)(82740400003)(47076004)(8676002)(2616005)(478600001)(8936002)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 08:31:30.5629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e25842-8734-4377-b613-08d844e37053
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4042
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch fixes IIO_VAL_FRACTIONAL calculation for negative
values where the exponent is 0.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 drivers/iio/industrialio-core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-cor=
e.c
index f72c2dc..cd43b17 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -554,6 +554,7 @@ static ssize_t __iio_format_value(char *buf, size_t len=
, unsigned int type,
 {
        unsigned long long tmp;
        int tmp0, tmp1;
+       s64 tmp2;
        bool scale_db =3D false;

        switch (type) {
@@ -576,10 +577,13 @@ static ssize_t __iio_format_value(char *buf, size_t l=
en, unsigned int type,
                else
                        return snprintf(buf, len, "%d.%09u", vals[0], vals[=
1]);
        case IIO_VAL_FRACTIONAL:
-               tmp =3D div_s64((s64)vals[0] * 1000000000LL, vals[1]);
+               tmp2 =3D div_s64((s64)vals[0] * 1000000000LL, vals[1]);
                tmp1 =3D vals[1];
-               tmp0 =3D (int)div_s64_rem(tmp, 1000000000, &tmp1);
-               return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+               tmp0 =3D (int)div_s64_rem(tmp2, 1000000000, &tmp1);
+               if ((tmp2 < 0) && (tmp0 =3D=3D 0))
+                       return snprintf(buf, len, "-%d.%09u", tmp0, abs(tmp=
1));
+               else
+                       return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1=
));
        case IIO_VAL_FRACTIONAL_LOG2:
                tmp =3D shift_right((s64)vals[0] * 1000000000LL, vals[1]);
                tmp0 =3D (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
