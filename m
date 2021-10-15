Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BAC42EF57
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 13:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbhJOLKI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 07:10:08 -0400
Received: from mail-eopbgr1300118.outbound.protection.outlook.com ([40.107.130.118]:14625
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238226AbhJOLKC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 Oct 2021 07:10:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YARs6/J4dqSKCIFb9J5lK2q2tHk7KiGYR0dWUFc0s/cvdH78Ipw2q5M26ISesMscdNdeAr7uzD+pH0YKupmP1kDAO0ScfgZmofI+ZXVbJJ3DGWWXRFFvFJjC0TTZIxoiyKsR8LQbxsZIF30Y+soHy3ozvPpDJ+lFim7gZxk5O9YY7+65uB1qSzmffB3XUDef6As+ZQrDbUiXoRPr5+Wi4wHJVxlqr0VgnpSnb22//FdMLP8JCx9DbykFgLrXSWdRVbsUGVpdt/IifN8NTj6ZqdcuivLKy1PPwBBpHggY7em8LPRfqcfUyRAOEwsJ4Xaq3mrlUnk38hqdlNBWrPADjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXRdiggmXPaF8kQtcBHRO4KmV4NOu/gRUg2qvrt+2eo=;
 b=POqSeo3qrwy6OJWYO6DIbK59JG5JxSKX6sifui2ywgWM+TUt/7RlA3D0lXworHUPFdZIkDvYSwqYummAEYnjU2a3AoT30ZwGdO3by+yoxO6qYJV/v7pEpu0T6fxV2XHuI21n9j3IkbiyTKnH2IzvqViakAHkIxxnI6oRDuhfT9WTLv2VOoxrTfhEyObJICCOfAtv8ISCKkKApdt9gdH86YD19SP+yPDYBUF5yWOtTCX7oQOYv86ftBGnmTlQeixjOaBWkI27sGNTOfVQyJLUJZTiN3v6PC67iWpFhGwkid+MBpMAoJiKkIRHkpnNdWzLJeG1cQbyTJ4nhUBYH8nqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXRdiggmXPaF8kQtcBHRO4KmV4NOu/gRUg2qvrt+2eo=;
 b=nM9DCbdTkX9XrNIy6QWqOW8vw5uc44LCST96kFEj9afBT5vPvhwLpu9DmdD7//tXHi5xxsW35jkfYrlQ5fl2j28cfYXI+edBlNL94+YqewcQLkjtSSCW9mXJtXEyxPQO+1BCE6okoXmmUCOKcxosB6gINyKFErex1skGNX3HYrs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3212.apcprd06.prod.outlook.com (2603:1096:100:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 11:07:54 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 11:07:54 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH V2 2/5] hid-picolcd: replace snprintf in show functions with sysfs_emit
Date:   Fri, 15 Oct 2021 04:07:29 -0700
Message-Id: <1634296054-6971-3-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634296054-6971-1-git-send-email-wangqing@vivo.com>
References: <1634296054-6971-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0172.apcprd02.prod.outlook.com (2603:1096:201:1f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 11:07:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7e3b05a-c958-43a1-72c8-08d98fcc0952
X-MS-TrafficTypeDiagnostic: SL2PR06MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB32125C58C07D737BB954B6FABDB99@SL2PR06MB3212.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJ20n5GKvsTcCjlxO4AK1JK2GviYIG8t5D8gtTcWeiD2xL5RQ0lf6q5xFs0U1C/FamhSisysSY45oosvVi+JktI1c8GvWaIwghu0ZwUaEQD3OqOdnA8fdMzfBeVGwcLDjL/EWfX1aUf1M6IzVZ5Nh+F99taxpP1F6PyiMplVV75+yjjbpRFuhO1lzI/EIQNdG9bZJNP2MY6awVorYYbfFIoq30onSR0e7zBuBMjUK0Xp+7kvSXw3IybY6Y+1AuIvihYCg/N7PpdQEVweHbfXiagMBnr+jIaGHwdv503N544IFP34Wxvbkv3bvgbALgaYEWIn5tMTqPdL4TYgDkEsaYHYG1MLE+1bl4zDHhDQqK0NBwWg/5SennpvojLYvWeCj+uOMEYbaRrVU0/mHl5GL6oz+NzQYRixlFv6lwV8SXr/zd4epd7Em02wUq/JejGraijJePN9utIv9dsZTKOQixzbdlXYqBi2DcPyvCHdW7HL1iOFvpUbKzXmGfjTY9VqjmAJO7+rbNXI5wDnurD2PKH0MNDIfc4G9RrPapgYKe/RN3STqvhsAcZb6/6g3CbB+PE6siPVGsQPu5yz025gw63CqeXyuDmE1xzfkMjZMO10cmWg3/428P98LJQO/4UAFXlLrF404Kr7xZvlD1ZNbTru9tF8KUC/SAukdx+11DKLj0vaoF/HMotAKKwbRS/k+ZCqTse1NLZoe028Lc7Dew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(2616005)(6506007)(110136005)(316002)(107886003)(86362001)(4326008)(5660300002)(2906002)(6486002)(26005)(52116002)(8676002)(8936002)(6512007)(186003)(38350700002)(38100700002)(83380400001)(6666004)(66946007)(66574015)(36756003)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkF5ZzI1Q0NkaDFpbVJqNWJYcFNYOHlUdWd3S3d3REhuenpmTHFUSWdHM0FU?=
 =?utf-8?B?YmVxQ3RtZldaWHBiYmozVDRPU3FGamFMSEFuTFNsb2xEZXRxaGpicFpNcGJS?=
 =?utf-8?B?MnlBNkxpMmUvQVVrK3NGS0ZoS0lRbmtNcXRkc01KVzJST2hLaVh5K2lrenZR?=
 =?utf-8?B?MFlyNm9uTlQ5enJ0ZzlpbXhFS05zZ2M5WG9FWUtUN1BFMmhmVVRuQzdxdGdI?=
 =?utf-8?B?NGpqSmhBUzVZR05YQVNHRFVKNks0Q1dXR3BVNHdvdXFmVm1oVitsRHJqbHlV?=
 =?utf-8?B?bHY2U2Vockl0NnNMcy9McUF0RlFvSDcvZHIrdzdDZlRsbEh2WU9rRlpGcndV?=
 =?utf-8?B?TzBpOUNidDllbWVtNGUvaGtLWHhBU1BRcnF5RU5FNklPNC84aDFCaGRQdU45?=
 =?utf-8?B?VU9JSkRteTNyYXhnRWRHb0dFVmlzSEZOUEtiNlk3TmVyaXVtVFM1K3dPdFlo?=
 =?utf-8?B?ZmVxZEtUaVd3THpXYm1BcTNzOUF5bkpZODNUWCs5ZUV3aGlTSE5DZ3dyYU05?=
 =?utf-8?B?bFYwWjA0NXVaY1FaVC91ZHJyaDlnY0JOV09hMGNKdXBCMkRvNG90QjlFdmhq?=
 =?utf-8?B?RlZRU3ZjTUpmWlFwTkZ5amNoK1VraHcyYS9EWFAyQ242dElrclBTcEcwSU9i?=
 =?utf-8?B?S3FUL0pDaHd2T0cyWkpDeE5aOWVQK2dlUVdRclBleWFNNDd4V0lwYjhmbG5i?=
 =?utf-8?B?NG9FMkE1QWlVc1MzUFE5bnZVMEdwS2dLQjFtZjFLdmtZVnkrcnFGZHpmNFQx?=
 =?utf-8?B?ZXFaazRFU0NLOTJXY1B6TXltU1RzdGZCNXVkM2pTU01BeXIveEdFWFJCZFhi?=
 =?utf-8?B?Q1QyMlZKMUpKZ29GVXF4RUN4c1l2VVNxdFFVc2Nnc3BFaXZGVURkQUNZcVE0?=
 =?utf-8?B?NWQvekk3S0xVekd4QmRMMG03emd6QmZpMm9DQlNlWnY4YTdUb25EaHJFKzNM?=
 =?utf-8?B?eS92YjBkei9UWmFZdS9TeXBab2ROK1o5L2xnQ0lab2o1aHFXQ1ZyVHdacnBi?=
 =?utf-8?B?Y01oWHVvd1pBMFJjZzBKSmR2MmR1NW5LRTFCSXlyNG1XUTVqaXhOeCszNWRH?=
 =?utf-8?B?QkoxdFFwWkZtbUptRVNkUmV6c1VjZ291eXdRQXlzek11aDArMGJ3cWkveG1U?=
 =?utf-8?B?WmF4VytSOVI4VU53ekhVZEpPZE1yWWVkMThTQmdsc3A0YWNYcUgvNE4xRkZi?=
 =?utf-8?B?aUpyL0xKVHVFYzBNNzVPeElUdE9ZcHRLNEFobHBucVMrM3g3ajlscHNNeEVM?=
 =?utf-8?B?dmxIUjQ2cEJSVStDVnlkT2IrM2JUMjRUQ2txTWhUeFV1Rm0rbEhaT1RnYzFm?=
 =?utf-8?B?MklSOVluRHQzbVFPN0JtY0FDaG80M2tQZWZOMTNIeG1DME1xS1dtZUxJRG9O?=
 =?utf-8?B?dGtSL3V2SW1BOHZvc09RYjBmSzBNQ1RuU01ITDNZZmpvaGZWckE3dDZtN3hO?=
 =?utf-8?B?TEhmQ2JFZGkvWUY0Q0txVXoxamZrS3FiQjhFaXFtM21scTBNNHhJZ0hKVlNU?=
 =?utf-8?B?YlpBci93a2JyUnY5eFIxQXF3V2k4cjJGSFhJLzlPelJlNnpJU2FZUUVaR2ow?=
 =?utf-8?B?c2FLdm5QZXVWTm8ySXE1VFNyQnNSbGl5Z1VGNDlkS1dOMDlCUFlQZVRtdE1r?=
 =?utf-8?B?YnlUdG1ia0hyUTNicThpMmttOE1wUkdhQ0VqcVcwQ1F2eEtFSEd5V2R1ZGZo?=
 =?utf-8?B?bThLbVFmWDFVeDBBRU92ektKNjA1Y0dZcGhsWTFRakJ4MzVwbjE0VEp1KzFM?=
 =?utf-8?Q?eLhqBXA0DxbojV9E4dBJiNlZ1xQfvDp6sPtKpcu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e3b05a-c958-43a1-72c8-08d98fcc0952
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 11:07:54.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8w86TBZ5JAFPXzvRMXnufWN6SvGt/foYQnr/9ufMEv3WhD5JTf1yq54NpRJ16D1FN8hVRHU/Q78FPzj6IRYBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3212
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

show() should not use snprintf() when formatting the value to be returned 
to user space, snprintf() returns the length the resulting string and 
scnprintf() returns the number of bytes printed into the buffer.

Fix the coccicheck warnings:
WARNING: use scnprintf or sprintf.

Use sysfs_emit() instead of scnprintf() makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
Acked-by: Bruno Prémont <bonbons@linux-vserver.org>
---
 drivers/hid/hid-picolcd_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index bbda231..fa46fb6 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -256,9 +256,9 @@ static ssize_t picolcd_operation_mode_show(struct device *dev,
 	struct picolcd_data *data = dev_get_drvdata(dev);
 
 	if (data->status & PICOLCD_BOOTLOADER)
-		return snprintf(buf, PAGE_SIZE, "[bootloader] lcd\n");
+		return sysfs_emit(buf, "[bootloader] lcd\n");
 	else
-		return snprintf(buf, PAGE_SIZE, "bootloader [lcd]\n");
+		return sysfs_emit(buf, "bootloader [lcd]\n");
 }
 
 static ssize_t picolcd_operation_mode_store(struct device *dev,
@@ -301,7 +301,7 @@ static ssize_t picolcd_operation_mode_delay_show(struct device *dev,
 {
 	struct picolcd_data *data = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%hu\n", data->opmode_delay);
+	return sysfs_emit(buf, "%hu\n", data->opmode_delay);
 }
 
 static ssize_t picolcd_operation_mode_delay_store(struct device *dev,
-- 
2.7.4

