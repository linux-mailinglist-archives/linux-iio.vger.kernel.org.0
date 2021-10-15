Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58AD42EF5D
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 13:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbhJOLKT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 07:10:19 -0400
Received: from mail-eopbgr1300118.outbound.protection.outlook.com ([40.107.130.118]:14625
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238316AbhJOLKN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 Oct 2021 07:10:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPbjLRMqWmZZmVmOpea0HSWzHCaXjOSVGmp69vuIjtsPdgeiJ//GBNo6YfZh/hefJ3eLej616dQs+222384YO6NniHkQh6gTzh9bK2l9CE73YVfKDcLGhqgnXnC33U6aB3W4Ww/Srg/kwirK37NP5umjlAb3jUwgASaHJpVDurz1pTh7k9PV8AgkmBNd4Tr0YM12c0arjfKMmUAKUysVIFw8nmjKPybdUJBnQgEmkK0au+p0q7Sm/ITTnxKxxSVVqtLIvsstS6uWsC7A7bRPUhfxA5xKRxCQV7hQdt1WsMa6i7Ijq8h1WaaJX75NDBagrg8jfdiYEgQMcLT0E6ylXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Bw4yTLLsH0XYih1jVc0KaepZMLLwjcCakk7F+Sy/Wc=;
 b=DW/yc6WLc+arfRAAVH53bWtmydx7Mr0rjbKvuNXTnVYZXxes5hoGtks5oUW6kC6w0CW7SDlGhZ4OTFk66aoV1/Gs6MRF4wJEYrsomIDvbkAMETxOVCXg/O1dkKNKO5U2wnWjIVZ82rX4tw0KnHfBSYwjjO2yb6vcm+lKWa5Qgx3tnAAHu/Urx4m5W0d4+gIuyHBZR/Mkv1GcHdIsQzrrvMnaBH7jf000ZrnknyMzIdqyi8GxLPMvGDgmdjXzoWKZiJiFCaaxOmBYI2MByBmNOI5KZY5Tm0zItPrLO5p+3Elko4qjZkZm19CjVb3C46WBf3HQ9652D6RLw5EAz9OkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Bw4yTLLsH0XYih1jVc0KaepZMLLwjcCakk7F+Sy/Wc=;
 b=X6MrGfw+qqRwu4PpmKWXGn6VMYqRfx8pVxO5Or6yIgUCphUV7cQ7gELomkUNRfSix2RvdqyzD3OsZQLZ0IGg97QEbj4xVeOAZjAPoS8CrvXWdOlE5ZJbnbD/H21Bqm4AB1kVHF5Xho3ez9I1+h+/bcxiGMBeEury99UHgM8ZRuM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3212.apcprd06.prod.outlook.com (2603:1096:100:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 11:07:58 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 11:07:58 +0000
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
Subject: [PATCH V2 4/5] hid-sensor: replace snprintf in show functions with sysfs_emit
Date:   Fri, 15 Oct 2021 04:07:31 -0700
Message-Id: <1634296054-6971-5-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634296054-6971-1-git-send-email-wangqing@vivo.com>
References: <1634296054-6971-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0172.apcprd02.prod.outlook.com (2603:1096:201:1f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 11:07:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cec318e1-ea92-490c-a232-08d98fcc0ba0
X-MS-TrafficTypeDiagnostic: SL2PR06MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB321294C5029076343DCD89E3BDB99@SL2PR06MB3212.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvW61PqNl7Hhr+M8qP8JVh72cqGPPCGMnhdvPV6nsPuTQQjyOscP87F98KDMC9z2t9v0g+nLId8uyl7wokmtq90mbW4GbXSsDUL0MIOPn62arZrOy5UNWXKc2q6pMCALQHvdO8rEdlGhK0orwtehLAqGRVodMLBGAo3HQ+pV1ZpqCsePF8Y5qZlJKfRiS2OlEtzisAo+aaVs0cpa3EjovThlL/6cGeN1y5hK4mX4KhAb0zFSsyw0eP/OI5wsRBRTjWUAfrirclKYsEdmKj2SkM8pbm/ZbKW3Uemsl4qHeB4E/rWF6lLckbue5RXO9ee1B6XKAFZQNbiyOw/LDfr2u/GOpq9X7nUejq1FP7Z3CgF7QmBEtf1SoiwvjbmltwbphhlLNwL+jRSU0Gy+uot6xe7wShFfyhbCqrLrEC5vxqHHBqFgCm57L0SGw3RJfL5spkziowxvph2u4s9p/eaCy178PSMkas/kK1sI9stFliJWrHsQ/79sC/F+oyKtrLujFmT8UbBLJzvOi5ZFxxjUqen8exRU7zjgXtexrngku1MN9Sw7aRRYeK//79y6BVZ3umsPtF142klq6HvXi1DROPnclMkj2TkXf+7qB209vuyOPNQrGWdiwY9XVhcSwxZRHjJAqdKyUIvsAaLID5YZQQYS8Ei5UWbjBSSy7drfO4XIOBDzODFvbwbExYNvadqh3RA9OGdNC3h6KSR9lWdEAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(2616005)(6506007)(110136005)(316002)(107886003)(86362001)(4326008)(5660300002)(2906002)(6486002)(26005)(52116002)(8676002)(8936002)(6512007)(186003)(38350700002)(38100700002)(83380400001)(6666004)(66946007)(36756003)(4744005)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uiI+LLg1mAsxVz9CvMxjumoE7JsfwbYzWVBRs/hizT2+PmShV9Q23L3t9kZ7?=
 =?us-ascii?Q?jlYubh0Il7GV5422ZXQRiaAFh4bLrveEl4b0sflhHL17UTdiP0EqDcfpUKEv?=
 =?us-ascii?Q?EgBnEq9kxXZSD9l1af7OH7r+X+3D1euWNjdOLHWbx77ENeZWCtDbI1PDeYPP?=
 =?us-ascii?Q?XmJCobwH4fIMf/Aaq6SBHL+WpSeEiJ01Vd+R5z0dJfliceHkDESMERJuSSDH?=
 =?us-ascii?Q?G95TNSQfvJZNPMY9B7KwJvZBLgnPdJoh+xCXSIjvfLohE4WaG+cwgMPL9wqt?=
 =?us-ascii?Q?RzRbstCSvzuprTGGrjuI554DiwYRbha/4tz+/jqv+FfTNh8ASBdKd3DwKGzL?=
 =?us-ascii?Q?CP8j9cywetdYzbduP4LzZYimSCDrXUZXUsn4HkEbVXVh9w1rmRZq56Kxllc/?=
 =?us-ascii?Q?3/T5g89rrDsyga1Ji8Asm2yxHSdRz3zguqC11grs++Wykt91xy7UPXUI2dBk?=
 =?us-ascii?Q?5wlOxuKdz8lVQgPEREzQ3ZcQi+CISIDEVYhQbb1mbmHu2RU9OFNnnkrXTy4K?=
 =?us-ascii?Q?nvHwIp32uUEOnwz6r+DWwmOK4pHjuacQMUC2u9Ay+ghZBj0BeZaTbDz9Kfyv?=
 =?us-ascii?Q?w2LUQmONgGQH6F3/Hrhju8qjJzhrzAIiy1iaiJ7cSwMWPxiNaiCT3G7e3F2P?=
 =?us-ascii?Q?nC+V2FRp2rxh8dtlflw/xwyWkjP9ybPp8Ci36ck+3aWfyLxr3MZ5CWWHGaYj?=
 =?us-ascii?Q?QeYVsZQ4zYZ4igerNfoNQV0jct3EVdWAKVtyXQlaTTMnG/vF1i8gLTnuFZvd?=
 =?us-ascii?Q?FccujcdewIG3KaW40rJmYQmq8/YD59K9PGQQPGEiQU8McyKnpFN+rgyn3LPq?=
 =?us-ascii?Q?Cl0XHbdv0BAilCQIT4VrVAl33CmGybRde6WaTtZV1GqYIBdhU5FblupwTAUH?=
 =?us-ascii?Q?zbJJz4iN2VsqCz/37AMMR+ms6v2QpPSiJjtbPbLoEtq9e88QWWmnEgA8m9Y0?=
 =?us-ascii?Q?taPkKXqB1zkgW6/VBdkRzEUxFhmo63H6PVAqPEJW/243NTa1+oNzRg0bdAQ5?=
 =?us-ascii?Q?NZbvELaRkAHUvNeRJuUnbEi7zV6ZsLaVpvYjhojPzqNRRcJ0nDnV/ZD6mPUc?=
 =?us-ascii?Q?EzfL5yRIYnJF8drxC7CH971VqQ37PJte2C3pXp82Kfy9WgQgQzrJmVaejK/8?=
 =?us-ascii?Q?n9OZ4AQB+i3XYNnPM5yfMHef6X/9uzN3aUik7t3PAW5N198HIpQJ7iJw1SLR?=
 =?us-ascii?Q?3zOvg4VMcIjP3weiY7D1ecX8rYJGfTLJJPlAmlfQn8ufYX/osXvk8vobPQ9O?=
 =?us-ascii?Q?FhJdoUvFm1XQGCBnqbm8lkTToTz2oQI6cPSFlmvzncA4lW1M4GJh0C69VYpV?=
 =?us-ascii?Q?DcWZ6CFaHIGcTewqz0r9jrSa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec318e1-ea92-490c-a232-08d98fcc0ba0
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 11:07:58.2641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xt61lWOQNmJyOIxNILAMb7NP8COyz2a+xqeIkTuL5XPCGMzAsW9IIeZ5hsGnMDRddlCzdHbNQyyjH6Fl8JEGDw==
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
---
 drivers/hid/hid-sensor-custom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 32c2306..a46481d6 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -371,7 +371,7 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 				     sizeof(struct hid_custom_usage_desc),
 				     usage_id_cmp);
 		if (usage_desc)
-			return snprintf(buf, PAGE_SIZE, "%s\n",
+			return sysfs_emit(buf, "%s\n",
 					usage_desc->desc);
 		else
 			return sprintf(buf, "not-specified\n");
-- 
2.7.4

