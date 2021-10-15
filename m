Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2D942E948
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 08:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhJOGup (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 02:50:45 -0400
Received: from mail-eopbgr1300134.outbound.protection.outlook.com ([40.107.130.134]:6071
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232515AbhJOGuo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 Oct 2021 02:50:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKLewdm6gE9yuPcpSMVyYbBcp17DQfxFS8bpiLkuYlQvVbO9q9SVVSlVlL+XwFaBbPrCVjhA4AUlpn6098fQxCQuuI68f5Kg5l0Do4b8Zo3fSoYEjp/Hop2VYfQi84aIW0rZQ2j3arPRc6mhftGLkxNc/I+fkZTBY3alD3cq70bSbERFusoa6+Be0jQf7jx8LJvDjdyTpUTe6Vrnank3qaI6nIEc1BMWdcIkIftcrDo6MiUAX+Cd56XOhK/BWJMZR032jzkBAvOEokyhmCryNd4tyfnB9j4hWC9xMnk7Prv4Pj4l7eKiNrQgaNMi4Urg9xP1QkYSmaZNMO2wyXThxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykhkXsKlaSZPhOmqNY3VnF8H8YkSgK+vgXkToHLnWrw=;
 b=UwudHLhVlUjTZFoFebhHRu0o/jqZTsuu81oAcO4vsCClBaOp6RWtIe7lwHaZWrt+0nFog17GNMNsROXXhBqhvMK+PER6JbN7OXoJeCuJFhFjFbXkmiwCJS2hW7YCOqsEuDScscPVVBrUC8XRxf5TotE3a+Gbb0xHlcWsiwZIkPj1Jxk2l9d1P63/rPF8bPpyX1x4DowDjsUZEOO9t2WNyBDZus3KOK18iaKMmrrtUm9kX1C2HLDmh1T2hjWAExDj00Ek3wIed+XbPjOUu5Av5tbl4zrDMMFCeGEqIcrpeG25bxNxGL8PWpL70d9QhVpzErKlVMzr/yPFUUDzFW3OiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykhkXsKlaSZPhOmqNY3VnF8H8YkSgK+vgXkToHLnWrw=;
 b=qIklP6wcoal9FuNelng2lCWxtbfcSn+YZkqqM0MIYTsapuqPorh23N9mJOiV5/uGX+FXvnaBcGYLG2XYNg3eNfOe3tp/evrEzytmzdOIebReZZCFchKUSuSAq7Sy3bngx6PSM4UN0MIgCtUlBNwSe4yRjxMu/qWmPDZJzlk4Hp0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3388.apcprd06.prod.outlook.com (2603:1096:100:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 06:48:36 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 06:48:36 +0000
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
Subject: [PATCH] hid: replace snprintf in show functions with sysfs_emit
Date:   Thu, 14 Oct 2021 23:48:26 -0700
Message-Id: <1634280506-4477-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:d0::13) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HKAPR04CA0003.apcprd04.prod.outlook.com (2603:1096:203:d0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4587.19 via Frontend Transport; Fri, 15 Oct 2021 06:48:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7133885e-27e0-4468-af84-08d98fa7cfbc
X-MS-TrafficTypeDiagnostic: SL2PR06MB3388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3388DD9EFC8B786F9FC9EC0CBDB99@SL2PR06MB3388.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TaxDtGkgwbCsjgpvfTaRmiccIrONIJ/lvnhTU8TJh3WWVeyh5GwgzYOv88uh/sE5/ywYicrjkQJIgKO4RowpvBsWqTp1dlE1P1SwcIh8HeeRUopgJmejZpwCGjN0vyeIoc78/JEMJJOP+laeghmEOdW0B1xuSwshu4jLhHsrt7wmA2/Zt+IfosRKS7BBX+SWGY3i5XdbbITRVt46mvAh7Izi+IdOlK/RzUt7ZEhY90fzwTyDrhGnrAriOizjzzZntDy74lkVSx/kC+v41AVojye3KatpllBIg3vGlBAc/ihdxDM6cnKKRo2eFlgD1o8B1ZjJ0Xkn39qjLw3esmsPiVX3NKs09p0ukjxj2ZmIeGFzbaV0CHzP0+ECl/uxmoyd7A+VVczPrF20A36yV8KEKuKHuFzpsqGGhBo1Zx+g0V4MfNxRYZ41Cb8NyTquXEgCCh9+hKwaxtMQzKNxyxEqvfat5RUK3jmFtKpiqsvuUZ9eSu4HvkqgA4JRAjlShJnoGe2F2Amo52NMR8ZIfEtKKiXi0+HHSJoZv8PAy5QJv+j/L993tlYT5XFHjtf+WAwPigQOwZkXAT31KqBoCI++4HD41GmJNxBKeP0dO11jYDm6Xfv11Yob2DR0lKg6zUeNPl+J9JnWSu/7Zi/+gejbqzHZEiqi1nvwsyzw6b/KrHwWPmQDtbkFE6AWw6pjIsYOHu5UZTp1EXohTmVhywUlGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(2616005)(316002)(2906002)(26005)(107886003)(8676002)(66556008)(83380400001)(186003)(66946007)(6486002)(956004)(508600001)(36756003)(4326008)(66476007)(6666004)(6506007)(8936002)(110136005)(30864003)(5660300002)(86362001)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QdNsDlY2bAHprfsxrK68HW7G8SP+H0IypDFLu8ZUUeNm84VSCYA3y/GipL4r?=
 =?us-ascii?Q?V8UMylAoQa1wUcKZwN0kbBtrzUwg4hwOfVNVaamVHcD4kumBgLSUlx4H/6P4?=
 =?us-ascii?Q?+sRkfSXYUACH2tZqtKnx5+aFYmGV4DE0IaIAnH6z243jSlKGdHwylqXyqKDe?=
 =?us-ascii?Q?Rh61eT7UfA2M5eDFyOKMzKZSyUlMQWzNH4Ay6JNKQpl7QJVWLeM2wFtiNYsY?=
 =?us-ascii?Q?u0p9nIa8i366zsP0yEiJVasNIBtXZ95CW8BkIGosD+F/wD4Wg9/RzapCicRp?=
 =?us-ascii?Q?JaklQmQFjoQuGXdsn51Qp8UByBkmo24ag1P7N/zMOpY3KGIy+J0LejdU8liZ?=
 =?us-ascii?Q?J3LX1WrAniH80aMebHz3EIPpgqx5TWAFVGDk3YGKEo4ShDpi0M/1NakmgdLP?=
 =?us-ascii?Q?IlXY/WTLW0Wmu2X6JjpQINExbgCcfjehCeAgHEZ3h4wOdjL1MxyR0y8C26qj?=
 =?us-ascii?Q?YcjOYnw6DAXIo/zBTJzYqfeAyd66ZLtLpjcP52+Il+bpJaGVvkmV1nVSxWpm?=
 =?us-ascii?Q?e4sDEwvrJQrNU81YznJ1e1tbvbjgVMwbEKHaZb5CdZCwAA1Cy1HHqdjmL5he?=
 =?us-ascii?Q?cQAdBNU78i1o5ZOWio0Dvt+QjBldUP4tmqxMh++9SSYojwc/ymT/uSWUONsI?=
 =?us-ascii?Q?nzRzRGwND84shFcnlun/CY6Fz83ZtY04HznfDRZqWpDHlcA4bygDJxNyFRrB?=
 =?us-ascii?Q?Jlt3rhrJXAHwjcdM6Z1bTcS8dd1QFf6CN9rycoCnbAMMSi2cVB1ovZ3dZfvP?=
 =?us-ascii?Q?lD9yh9tPq2mnGlC31GK44Xip7N3SHAJR7iku/BE/ahEVLQSGb6/KR2O/+hTB?=
 =?us-ascii?Q?fYLemg7vmHoLcx6BFtnYskTPHU4TmYiPVdM7Mq6ko/dQOQjNwsJ/kQ2cN07g?=
 =?us-ascii?Q?Mhnt1Bej4RFgNyvNLdmlYA7FNu3UFlu/JuTcfBWLnmBDxb0A/V3FCTxO4I2Y?=
 =?us-ascii?Q?VO/OWeIqstViJNsEzFugNC1ANptvEO+LsCR81eEtlVRQnGap+3gKGHugij3k?=
 =?us-ascii?Q?Huy3wiBtkKhqFKWdYTlYM+MSy/0o/O+74WxbPVerzMMt+Cq1RYlNpIaR13yT?=
 =?us-ascii?Q?P9YB7KUaQZ4UdwH+6lyzy28j3Abd6amLFqnkCzj1xViit7v8guX5ssptjEuv?=
 =?us-ascii?Q?K/VsjkbbHzvW3LBLTwOz9764AizHXZygr8HZRRdy80q41k4k/F8GmauwZoUI?=
 =?us-ascii?Q?zBm81jgI6CtwtNANU9JcBxQIsR5W1EtMqk2x+WEajNeE/ucbInV/r+IP/gjW?=
 =?us-ascii?Q?JL/GzG4wxMkdSoAVXh/CIMxS0ivqHLlAvSQf/TWvl1wYxN30Cp4d9SLY56y8?=
 =?us-ascii?Q?FSLzxljaGqxp04MNbbzpxSVO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7133885e-27e0-4468-af84-08d98fa7cfbc
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:48:35.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYx771MVW2WYE5gPP23YSdI2LGBc9QHmJeWdZn1Uz2/I1boD/2u8Z0END87CXgKr2uUgXZ4O86gOdSxGjtS9pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3388
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

show() must not use snprintf() when formatting the value to be
returned to user space.

Fix the coccicheck warnings:
WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/hid/hid-lenovo.c          | 16 ++++++++--------
 drivers/hid/hid-picolcd_core.c    |  6 +++---
 drivers/hid/hid-roccat-isku.c     |  2 +-
 drivers/hid/hid-roccat-kone.c     | 12 ++++++------
 drivers/hid/hid-roccat-koneplus.c |  4 ++--
 drivers/hid/hid-roccat-kovaplus.c | 10 +++++-----
 drivers/hid/hid-roccat-pyra.c     |  6 +++---
 drivers/hid/hid-sensor-custom.c   |  2 +-
 drivers/hid/hid-sony.c            |  6 +++---
 9 files changed, 32 insertions(+), 32 deletions(-)

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
diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index ce5f225..58eb4b0 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -63,7 +63,7 @@ static ssize_t isku_sysfs_show_actual_profile(struct device *dev,
 {
 	struct isku_device *isku =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", isku->actual_profile);
+	return sysfs_emit(buf, "%d\n", isku->actual_profile);
 }
 
 static ssize_t isku_sysfs_set_actual_profile(struct device *dev,
diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 1ca6448..66a7625 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -403,7 +403,7 @@ static ssize_t kone_sysfs_show_actual_profile(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->actual_profile);
+	return sysfs_emit(buf, "%d\n", kone->actual_profile);
 }
 static DEVICE_ATTR(actual_profile, 0440, kone_sysfs_show_actual_profile, NULL);
 
@@ -412,7 +412,7 @@ static ssize_t kone_sysfs_show_actual_dpi(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->actual_dpi);
+	return sysfs_emit(buf, "%d\n", kone->actual_dpi);
 }
 static DEVICE_ATTR(actual_dpi, 0440, kone_sysfs_show_actual_dpi, NULL);
 
@@ -435,7 +435,7 @@ static ssize_t kone_sysfs_show_weight(struct device *dev,
 
 	if (retval)
 		return retval;
-	return snprintf(buf, PAGE_SIZE, "%d\n", weight);
+	return sysfs_emit(buf, "%d\n", weight);
 }
 static DEVICE_ATTR(weight, 0440, kone_sysfs_show_weight, NULL);
 
@@ -444,7 +444,7 @@ static ssize_t kone_sysfs_show_firmware_version(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->firmware_version);
+	return sysfs_emit(buf, "%d\n", kone->firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440, kone_sysfs_show_firmware_version,
 		   NULL);
@@ -454,7 +454,7 @@ static ssize_t kone_sysfs_show_tcu(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->settings.tcu);
+	return sysfs_emit(buf, "%d\n", kone->settings.tcu);
 }
 
 static int kone_tcu_command(struct usb_device *usb_dev, int number)
@@ -556,7 +556,7 @@ static ssize_t kone_sysfs_show_startup_profile(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->settings.startup_profile);
+	return sysfs_emit(buf, "%d\n", kone->settings.startup_profile);
 }
 
 static ssize_t kone_sysfs_set_startup_profile(struct device *dev,
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 0316edf..9c39b17 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -244,7 +244,7 @@ static ssize_t koneplus_sysfs_show_actual_profile(struct device *dev,
 {
 	struct koneplus_device *koneplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", koneplus->actual_profile);
+	return sysfs_emit(buf, "%d\n", koneplus->actual_profile);
 }
 
 static ssize_t koneplus_sysfs_set_actual_profile(struct device *dev,
@@ -311,7 +311,7 @@ static ssize_t koneplus_sysfs_show_firmware_version(struct device *dev,
 			&info, KONEPLUS_SIZE_INFO);
 	mutex_unlock(&koneplus->koneplus_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+	return sysfs_emit(buf, "%d\n", info.firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440,
 		   koneplus_sysfs_show_firmware_version, NULL);
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 9600128..17581c4 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -274,7 +274,7 @@ static ssize_t kovaplus_sysfs_show_actual_profile(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_profile);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_profile);
 }
 
 static ssize_t kovaplus_sysfs_set_actual_profile(struct device *dev,
@@ -327,7 +327,7 @@ static ssize_t kovaplus_sysfs_show_actual_cpi(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_cpi);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_cpi);
 }
 static DEVICE_ATTR(actual_cpi, 0440, kovaplus_sysfs_show_actual_cpi, NULL);
 
@@ -336,7 +336,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_x(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_x_sensitivity);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_x_sensitivity);
 }
 static DEVICE_ATTR(actual_sensitivity_x, 0440,
 		   kovaplus_sysfs_show_actual_sensitivity_x, NULL);
@@ -346,7 +346,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_y(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_y_sensitivity);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_y_sensitivity);
 }
 static DEVICE_ATTR(actual_sensitivity_y, 0440,
 		   kovaplus_sysfs_show_actual_sensitivity_y, NULL);
@@ -367,7 +367,7 @@ static ssize_t kovaplus_sysfs_show_firmware_version(struct device *dev,
 			&info, KOVAPLUS_SIZE_INFO);
 	mutex_unlock(&kovaplus->kovaplus_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+	return sysfs_emit(buf, "%d\n", info.firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440,
 		   kovaplus_sysfs_show_firmware_version, NULL);
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 989927d..9cfa003 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -286,7 +286,7 @@ static ssize_t pyra_sysfs_show_actual_cpi(struct device *dev,
 {
 	struct pyra_device *pyra =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", pyra->actual_cpi);
+	return sysfs_emit(buf, "%d\n", pyra->actual_cpi);
 }
 static DEVICE_ATTR(actual_cpi, 0440, pyra_sysfs_show_actual_cpi, NULL);
 
@@ -303,7 +303,7 @@ static ssize_t pyra_sysfs_show_actual_profile(struct device *dev,
 			&settings, PYRA_SIZE_SETTINGS);
 	mutex_unlock(&pyra->pyra_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", settings.startup_profile);
+	return sysfs_emit(buf, "%d\n", settings.startup_profile);
 }
 static DEVICE_ATTR(actual_profile, 0440, pyra_sysfs_show_actual_profile, NULL);
 static DEVICE_ATTR(startup_profile, 0440, pyra_sysfs_show_actual_profile, NULL);
@@ -324,7 +324,7 @@ static ssize_t pyra_sysfs_show_firmware_version(struct device *dev,
 			&info, PYRA_SIZE_INFO);
 	mutex_unlock(&pyra->pyra_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+	return sysfs_emit(buf, "%d\n", info.firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440, pyra_sysfs_show_firmware_version,
 		   NULL);
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
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b3722c5..709595e 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -696,7 +696,7 @@ static ssize_t ds4_show_poll_interval(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%i\n", sc->ds4_bt_poll_interval);
+	return sysfs_emit(buf, "%i\n", sc->ds4_bt_poll_interval);
 }
 
 static ssize_t ds4_store_poll_interval(struct device *dev,
@@ -733,7 +733,7 @@ static ssize_t sony_show_firmware_version(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n", sc->fw_version);
+	return sysfs_emit(buf, "0x%04x\n", sc->fw_version);
 }
 
 static DEVICE_ATTR(firmware_version, 0444, sony_show_firmware_version, NULL);
@@ -745,7 +745,7 @@ static ssize_t sony_show_hardware_version(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n", sc->hw_version);
+	return sysfs_emit(buf, "0x%04x\n", sc->hw_version);
 }
 
 static DEVICE_ATTR(hardware_version, 0444, sony_show_hardware_version, NULL);
-- 
2.7.4

