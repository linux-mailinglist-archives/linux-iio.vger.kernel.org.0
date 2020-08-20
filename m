Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DC424C515
	for <lists+linux-iio@lfdr.de>; Thu, 20 Aug 2020 20:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHTSKD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Aug 2020 14:10:03 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:43232
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbgHTSKC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Aug 2020 14:10:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKM75xdjPOBxoyxZZCUbhCpQYgOhIDvQaScb/O94ICE5Flb3Gu657NFyTD+RofmnyzUM3tqzgRh69YHMf4ajtM+DNZVWGIQppwCRUuEb3iTQ2qk7o9HRbtlNOVO/HXqgbAh4BEtab1grmLt5ILOYbz/urFzoXpACrwdyHIWtriNkGY+hMxXl8KBlvvlcGYNn5+GMfRx3XL6rOGS2anUWJgTMgoXnpZClDU5RHgA/bGB50fmChc9rkfju0c8x0RfD13k45A5Tvwvcef4KIPLdsW3//RHwKvhv6XWbTyi/OouHJLoyl6G94L+iEl60B+YSLrNWfzs63rtVJOj1pK79wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V2es0Anfz+eC2uZbriqy6jOeJ12Hq5a3VwcieB39H4=;
 b=IITf3mS8dGv0rUxgV8vlIxnnNr3xHRqDeHaWjavsCysUuTk2DDmnGjOVDpX448Cmnb8Bvst4na4wBJd2ZytTGuL7NVczTBv/iqH2+JSD3Tkdq0ERn/3ResxvMApWFvmXQfaCzfohauaWEU55AoHAzJEwMGCQOg1iFVxZZgc8sHOiVmqcKvRwV/2rj9+UUB1m0+xrOWX6e0M4Xqsp6OIzfkk69g/FgoSjGNFLsIQYjOw5uqBRgUyPJ8X3JonWAF/Ncqwv/+ZnKDe1wuzict/AaRrOyyyK58hqiFbySTP8yInQstydgZDC5+DKuYLI+GGiRYtFhyYT9a6qIjvrF0L+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V2es0Anfz+eC2uZbriqy6jOeJ12Hq5a3VwcieB39H4=;
 b=BER7hRPH39Q7zEmeNtiiMahT7GRWcMM5et9rQXmEOF0CaKow7RjeazPWiR8PmE7zihFpByPH4HBC9Cq3594RRGG8d3z+2hGPUKF6fibXtyULDfx1hz60N8l1zG8OoNhMOH9zHxXxr7/WJulx0YEht491Ew2uDRUzJAZsRe98fXk=
Received: from SA0PR11CA0065.namprd11.prod.outlook.com (2603:10b6:806:d2::10)
 by BYAPR02MB5223.namprd02.prod.outlook.com (2603:10b6:a03:67::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 18:09:58 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d2:cafe::a9) by SA0PR11CA0065.outlook.office365.com
 (2603:10b6:806:d2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 18:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 18:09:58
 +0000
Received: from [149.199.38.66] (port=33806 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1k8p0K-0002ZE-Tx; Thu, 20 Aug 2020 11:09:36 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1k8p0g-0007u3-8G; Thu, 20 Aug 2020 11:09:58 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07KI9uO5014545;
        Thu, 20 Aug 2020 11:09:56 -0700
Received: from [172.19.2.102] (helo=xsjanandash50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1k8p0e-0007ty-2y; Thu, 20 Aug 2020 11:09:56 -0700
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, michal.simek@xilinx.com, git@xilinx.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     anandash@xilinx.com,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH] iio: Fixed IIO_VAL_FRACTIONAL calcuation for negative values
Date:   Thu, 20 Aug 2020 11:09:44 -0700
Message-Id: <1597946984-25844-1-git-send-email-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a28ec4d3-64f8-498c-0c2d-08d845343fe5
X-MS-TrafficTypeDiagnostic: BYAPR02MB5223:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5223E17A8688243180F824A4A95A0@BYAPR02MB5223.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2c/znD0h5VT1LDLEIrI1Dspp8wjD0DRQLpC1d4VfebpQB3/LMBloo/ilJ2r4iF2eNwd+rEQWW+q+4sXPmpy7pZcwV5r4OCjmpmmwLaH00TcDeRrizbNX9UQ+ABHGkmuA0s0S5WmFijUSbqSVdTAUO+g6LgXhLsPjtvap7DB9O1Oq7Aq5jLs4OMMjGc3sb0gJpgE6BzIviXP45Jm7ut2MteVZ8fddVSBi8Hmvv1aisk8ujkWFtae0DyJSVJ6M6gw85rYfH3xNMipwlqrOqPye5RbdaEpRvU0d+M5NPcgyXWMpoIi0n9O3c3udJFlTXN87Gg57svWGdfrTaBC+yftPVhxPibB7sT96o3EUcvYWRFKILkYvex9pxDH4jFU69Aswgf4YMk8Mn6NMoUqqz2TsQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(376002)(39860400002)(346002)(396003)(46966005)(5660300002)(8936002)(47076004)(70586007)(8676002)(4326008)(81166007)(70206006)(9786002)(426003)(336012)(356005)(83380400001)(82740400003)(2906002)(82310400002)(2616005)(107886003)(478600001)(186003)(316002)(26005)(7696005)(6666004)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:09:58.5426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a28ec4d3-64f8-498c-0c2d-08d845343fe5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5223
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
