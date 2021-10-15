Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4121C42EF53
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 13:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbhJOLKC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 07:10:02 -0400
Received: from mail-eopbgr1300118.outbound.protection.outlook.com ([40.107.130.118]:14625
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238235AbhJOLKB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 Oct 2021 07:10:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPJd60d6GNABTUOKGou6wA/88ISaOO+AkfHyXQjCLqwTOecWKC2sqlf72swDm0jvT3DDCnkPWhZoJJe9HVZkaE7nEhrKgvinEZ4KIhv9HS5h/lvew2boDI7QZ5t7TxZCNQeSRkXwWNm3Ub+tBKblMMet5VLCtO/VowZ3AkUufd/1cYmUMEbaR18O2/C8Q5YTgnMkn+5kNXEwvhshsioNMiDWOZnXvJeqNuLgLbwA1bSDE6a/ds0lYifh4JBbAw46dSq0Buf1ZbYW+kb9YqWiqpj/TmwR+f7zg0i6vgsjzpG5b9DK0pS4DdJKyllCK8ooV8YDgwl7S31/0EY0/544uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P6jGKUJd02VtL2cYBHjUPwk/UcDG5wsCZhY8YShl6Q=;
 b=WULylvvybvVi48qwvbnCcKZIwXs03Yph82LbqaMKFEfFVo9A+lwhbv2OePBco9Vw9vF1g8uPcWTuTlccNfqgbdR4gHpLxK2GDNkOK/aswSEOaCrM9oYi3RmgvicRGSQTKjFOEsO6t3Lsar45FWYnuac6uEojBJxxVyC83OdG/MiX+hMV81nFFhO3AXapKP/A31BRmvR96mtffRZBkl9MhUNjBniIoq4/+wq0txduiGTN4tiwvq7TH0gf4mSJ3QyN4jJUR4MV/M5dJzei2jBJqYr4tCIzqzbUPcDPyen83/DOQbK8re8O/LBk14+SVNvV7pNMxOVxYolPQScj5Ul3Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P6jGKUJd02VtL2cYBHjUPwk/UcDG5wsCZhY8YShl6Q=;
 b=EXw65qJE9azB6oXFaHyEB7k4/W1s0Q6H+a+TkkZDe2ZOKyPFB4G5NmN4uVR0GN3N0ag6uMhnb+fCm+Ocitj2wNCfQhCtiDFDiBMzu7YqIVp4Hy5Xjclu6IYBgb33Xp34nRJN5V3EsiGI1feOQkG+QTWKxAwYzea42Jyym1m+CJU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3212.apcprd06.prod.outlook.com (2603:1096:100:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 11:07:52 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 11:07:52 +0000
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
Subject: [PATCH V2 1/5] hid-lenovo: replace snprintf in show functions with sysfs_emit
Date:   Fri, 15 Oct 2021 04:07:28 -0700
Message-Id: <1634296054-6971-2-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634296054-6971-1-git-send-email-wangqing@vivo.com>
References: <1634296054-6971-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0172.apcprd02.prod.outlook.com (2603:1096:201:1f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 11:07:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fc0249c-5ca3-4d65-2c4e-08d98fcc081d
X-MS-TrafficTypeDiagnostic: SL2PR06MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB32127CB30DF7115E82B7F7C7BDB99@SL2PR06MB3212.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kCBZd3K4CqiAB/HbZP1ZcdLQdBb1YWEAoNf+0G4DJ8wxGqAFJCM6OkMkFZhiTLXLYBaVlYPyhk1HC/gj/BhilVuvfILIryVbibcwEgu3dvAz5RllSGzirpvofJfoGll6PpMtfl//ktZXneBhBiDdn6dB3FwLtBj4xuFTD3XdmgtAla5CDEsP+d1rpK+3EIf8S4oxOR4e6oS1QarnXQCRN0vK1tk4AD/ybPnuo07FDU5gVDe9gqR4MfmJXHToivIJDqTiq3emaeHSVBUQkLMSJJlmTnHAhr5wW7gK95WfR9ESSTmXKM4RmujoKpXlfUd9sFDQ1BKZQEeMd6i3BJDECwuGra4dzfs1QKcmsI1NZooiTt15gKlLgWC0/0sWH9FN83L6PbfKsgiKmFuCfZiSsqZS7elyNm6yBwTHDHAb251kEQ1wiFIN6WnYMFTc4q9mrJyBuxtPnuUZOfpYMYE6c6xX4pmNlxoyB78eYwWQZLf9DXArioXJLgUZKMA0VU0LDiEh2/jW1zsveJ0c9kQO7uwMwxm/UOt+31u8z8e4CEYFnI5KlVDGLdWb51KjlPGcDg8+/SA8KFwKjXRq5CrhEVXV+4TIcOAXiQBtg68ylMKgB2ncAWvd3uICq2lvm7bAAcV8eWml7qL1DFeK9irdkEWeqhonN6CDaKJQ3KxEIMmt5ktBOeHxlRSRK9B/dOIgY5zJgepAcFWjoluoPrxJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(2616005)(6506007)(110136005)(316002)(107886003)(86362001)(4326008)(5660300002)(2906002)(6486002)(26005)(52116002)(8676002)(8936002)(6512007)(186003)(38350700002)(38100700002)(83380400001)(6666004)(66946007)(36756003)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?27dZtgo87zN2D0eC/wQVoiOdh9gSGB37VGIi2Cc7TyerQh4MOg3El1ofA39Q?=
 =?us-ascii?Q?CGdWqlSMnbSVH7YAPJcdNUmXqWHt/RpMBxekwGv9JqEmKzb88y/1OfT0MG92?=
 =?us-ascii?Q?w0R89p07LINq0sbEj/dA9Q5r0RHbWTzqs2y68j1M6t2VrMsHDvRlnbrNJSgt?=
 =?us-ascii?Q?x8BFsgJTFL+hbWvCENyHR9SUjz3BEQ2m/bAPY8RpQUh4sUSqUhUJAbo9uSna?=
 =?us-ascii?Q?q0hCtYekOq4S99YxK/TssW9a1dALGuYgyqx8z2uJG+4sX3qSCeLi2kWuojlI?=
 =?us-ascii?Q?YIs5Fy+MVp+Af1UzvWFQmknjfFXoxSZrS7PC49j815Btq12Zv0eozO2SNMmk?=
 =?us-ascii?Q?mtD3FpFKaDRA8TGQlSekNPctXY+xmJ4b51IMIJ+JiGWNuyiMyWvNErIw9ai+?=
 =?us-ascii?Q?s6UnRJQC96yjI6uiwM3QE2kqmET+UtPtBaJgxKI3ZszbBxvO2rwPNWfCJUWd?=
 =?us-ascii?Q?swG6igpHhaSdfnVOkV0t52bUMlw0DPmoZbUKirAQGb0ma/tx3nq19L4G0zUY?=
 =?us-ascii?Q?H3yFmdcqd/IM45uYUOIXeK/8HRdAeJyLQCEsmwvZZrA2bEC4aEZWSCd1d8fG?=
 =?us-ascii?Q?61ggAtBLEmgcyKGve00vbRQkZpLh2zAUPkODDhoW2E59vFr3r6HheZ7ApS7p?=
 =?us-ascii?Q?E5fRjPU2YhmF4n7M6bMS3TDYy0rTM2SkxpnpRYLCcD87xtxCqKS1O6TLIlW8?=
 =?us-ascii?Q?U0Bj3Ew9m2b40BMc8LPJSi+ppkmupBQ0c8Xdd2Q4W8RlP1RRTnMYO/KoxABN?=
 =?us-ascii?Q?H/YdZOvQR8MnbP825fyV0RB3oCbd2dpYS+BaZJcZZPVbl16c/kTbBtB+t89t?=
 =?us-ascii?Q?8iN/aR2qaPaxBxpf4lNv/wx7Z/ZlDsKITctHM6MyoPHT9Mz1/ft/C0Vrmiji?=
 =?us-ascii?Q?oRy6+vmp8gxpU5O32UewUxHOpH8cuEbrWUmztcB0bvTHYiVLxixbNKO+IjeD?=
 =?us-ascii?Q?dO0LVf7VQ1jSntPYcwYT1eMqHUrIjOvvvO9RELrzash4K0qnm/BC82vJDna5?=
 =?us-ascii?Q?+8dUxz7YhD4N/oyHkQ8iN+Q0oJqSC6EtUkyiN7XCSsAKhxzsGnSEA7vaBnqd?=
 =?us-ascii?Q?wuZS4+3l0ifgy9DUo9LYpuKl70lxEdMT9wtEKLQtEsjTXSDTUstWaW5ki14b?=
 =?us-ascii?Q?JyITrZzZOMDtPcfxLKQ3ANd5cyY/2aNfdcJ7XkNuP+s7FZhDnrS3JqjjGPJG?=
 =?us-ascii?Q?geidC2OjVHjyNfzMLm8BxHuzzQ1awq+zXekVs1prVgMt/tWkXJhDYkHAksdv?=
 =?us-ascii?Q?bO5TDKfcK/vNU7HYrTAOWi6ioGTAbUT9ESlRwWwnYxYYeAX9f7pUyMW4VFza?=
 =?us-ascii?Q?g/nFgwhObSKPfuGjHa8LbDCY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc0249c-5ca3-4d65-2c4e-08d98fcc081d
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 11:07:52.3285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xf476o5mdiF9CpfcFyBbdLGgr5112tyXjSGO4FrywaIUpAtHD1XLJlm+bON18wRrFqR2JdJWiOtNvWDbdLSJIA==
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
 drivers/hid/hid-lenovo.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 93b1f93..086a7ae 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -400,7 +400,7 @@ static ssize_t attr_fn_lock_show(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data->fn_lock);
+	return sysfs_emit(buf, "%u\n", data->fn_lock);
 }
 
 static ssize_t attr_fn_lock_store(struct device *dev,
@@ -442,7 +442,7 @@ static ssize_t attr_sensitivity_show_cptkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 		cptkbd_data->sensitivity);
 }
 
@@ -603,7 +603,7 @@ static ssize_t attr_press_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->press_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->press_to_select);
 }
 
 static ssize_t attr_press_to_select_store_tpkbd(struct device *dev,
@@ -633,7 +633,7 @@ static ssize_t attr_dragging_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->dragging);
+	return sysfs_emit(buf, "%u\n", data_pointer->dragging);
 }
 
 static ssize_t attr_dragging_store_tpkbd(struct device *dev,
@@ -663,7 +663,7 @@ static ssize_t attr_release_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->release_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->release_to_select);
 }
 
 static ssize_t attr_release_to_select_store_tpkbd(struct device *dev,
@@ -693,7 +693,7 @@ static ssize_t attr_select_right_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->select_right);
+	return sysfs_emit(buf, "%u\n", data_pointer->select_right);
 }
 
 static ssize_t attr_select_right_store_tpkbd(struct device *dev,
@@ -723,7 +723,7 @@ static ssize_t attr_sensitivity_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 		data_pointer->sensitivity);
 }
 
@@ -752,7 +752,7 @@ static ssize_t attr_press_speed_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 		data_pointer->press_speed);
 }
 
-- 
2.7.4

