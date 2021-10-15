Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544FF42EF5A
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 13:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbhJOLKN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 07:10:13 -0400
Received: from mail-eopbgr1300118.outbound.protection.outlook.com ([40.107.130.118]:14625
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238317AbhJOLKG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 Oct 2021 07:10:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdHQzjg5uZKtQ8Yh0T02eCZ5dWwOKkEC9U3Y/Nu2Vd5Tdns3WZKRbauKABmnydbyr5tncfTlEiHaUL7x5r+9hatc/QhII1KIlVCJgvFZUt0RAJzeaMy/RoIUli0HDYFHbWZdmrkBygE7p8jjHK2MXx8u/Uae0JM5DWo2TMc2OJ8GXC2YsN6J1qQp3gse5v7vuQIe1AGE8pEtqxb4L4g56eGE3/FBTjJeLTPQwgGIK7gU6Zm4dWx+H8q9nFqH7iDxE7XQIxbd89Sw5s2RCCOiISLh7ycwGvBNjGq2NMiJIKj1GakoxCCuN8FLLZq5+KKfsEkzM2NYP94XOGGn0r2MJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIEHJkcjYXVLKCspgsKai63ai8lD/+2pZOGdWaOS9co=;
 b=KByujjSQbB9b7/fQJiby4qn1MuajkJVxPjtBzIEaXdUxryJVOe4Efom5rv9hM0bKVdx58OU5ax5+fnNzW7uftgsjTXzQRBbMN/J9QLFNfocRncX0Q2z2wiMW1dZvQhokltW/nEZRj44ccvO2cD+Gjge44wAgYg1QBHX75kbjkya9Cn1VMwJP9uc4EKnUAgmaFd81nWu+TLuczOMiJ9ccYz85YC0zuJecTa1Qdu1k0rJ3ppZpuaQS4TxyHsDXe6eQ6AbG2WI3WefDIqLqenVzChXeenBydiQJPIazs4DLWv+ZpOaIBgcN51OQOGSG/jAiNAkFsNh+iIfkMYYetU6JIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIEHJkcjYXVLKCspgsKai63ai8lD/+2pZOGdWaOS9co=;
 b=gAupGPdhjMiOy5J3UYr8T/nph5CNIZn9Ot90Kk2QulM2jxXcre29ysTIJTpQuqotldzvXqHcDaRezyRwOcEJrPMn79y/LiQ/G5kwlGtMEnliRK1yoq/i1VhEgUEXD5xCWqG3mS9towIy0zjjwk1ARxY4EqcNvvZHMzPqEdkrnNA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3212.apcprd06.prod.outlook.com (2603:1096:100:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 11:07:56 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 11:07:56 +0000
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
Subject: [PATCH V2 3/5] hid-roccat: replace snprintf in show functions with sysfs_emit
Date:   Fri, 15 Oct 2021 04:07:30 -0700
Message-Id: <1634296054-6971-4-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634296054-6971-1-git-send-email-wangqing@vivo.com>
References: <1634296054-6971-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0172.apcprd02.prod.outlook.com (2603:1096:201:1f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 11:07:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a1c7ca1-c84a-4ab4-e55b-08d98fcc0a7c
X-MS-TrafficTypeDiagnostic: SL2PR06MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3212262F12FF26981C9FA779BDB99@SL2PR06MB3212.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YN37jt/U02PzHt550Qu4JaY30CV+edbS05a/N7r4fMCIZqUD834gAz6hdu8OVSS1rMn3B6LHdkDS9lM/A4VMaRpYwZAizRSsFxIz9BdFDSRXKcPlFH8/90hIWrawIm899UbCyrixHatYYXgkcb9DZvH1D4d1zwBZ22DxGtrchRPuecZ6efeLSqDg1xvF5FLH3TfQSsmZ40w3nY9YBjIAB4/v3TyibE4eWx5KShuygZdHEOia0yMb2FfzQni+8FBdg1CkBnk0J+XxLK7PnkSbAQ3mX2KVR6sXSIGgcPLqkX0CZu5RIVefznFq2dG9T+HOzhEZazh9K7blcYbXemToG0NtTYb4jKilrqK5Pudt+TepTI90no+zNB4hf0N1J9j+7AyX9YbbgNhrHWkJHCNVM4YJsZCJF3WYzjleY+dtV8eAaQHOgey1zimgmR3X167bCrOF6Bvvm1S5IuQbmxLsR8PabDPn05stXIqGcn5PVqvP1Hiv128dVVoSp5cu0qMejBHXrioJctHkdbiP181Gt4NrloeTE2SaZ0iYxqt0S3UgF3kBRRM5SnKRsqaTA54nXKAuigdYgAvpV4FTKdAJog6ph0JSU1WflRCDPcWTTtGqu8z7DwqwTki2NArf8YU6fwYXFTH5Mh/bi0QwuKvxrnNJ7tfjb7uMtvKtc+/u4I0f4pLtyas+EvqIK2GJ3yv57g35Xr9U1G1T8GnDwyAdrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(2616005)(6506007)(110136005)(316002)(107886003)(86362001)(4326008)(5660300002)(2906002)(6486002)(26005)(52116002)(8676002)(8936002)(6512007)(186003)(38350700002)(38100700002)(83380400001)(6666004)(66946007)(36756003)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tNMdoHXQbfXIHBxbi5VqU/xUnE/gAgl8aIC8vXiXMNAURflervtIrtWRAr8K?=
 =?us-ascii?Q?tQxgOmYgukviVOZi11M/jX4biqWRvPZLA1FR5FIO1bb8br6/yfOo3Tb82hmf?=
 =?us-ascii?Q?C9tpIYEebH3fVcSC/qjIH2VYz35mx839hWYiNTAUkh79glFV//Sg9KUH40Y/?=
 =?us-ascii?Q?J1xGC1XNf6TkzwP3iltkicT/iv16sR3CKdATvIA6RDBo9uEhXHOCFwbIWgjI?=
 =?us-ascii?Q?3pjneBeB2uoelxu/8epU2xO1FGIXC4qOLsdETsjEhVk3De1S5Ek450YF7qsH?=
 =?us-ascii?Q?YRXwOKlajBosMIuFJlldOpEwV/0nllyyzqBTs5EL9u8+nVC/ELREj89Be6oa?=
 =?us-ascii?Q?cI7l4xUu24N2MiP+AJc/Vu1FDhhg5qVxC09qr9M3ekJ0+gPlcgQ0WEwECEK2?=
 =?us-ascii?Q?VYaspha5PWAf0B6Hw9mnsW+DmWcKdozjYJVusY3qS6EVmjKSOs9NZ5zTxe0N?=
 =?us-ascii?Q?Qrf9mUn2Sos0XCcoo8E/MHQcK1gB2fgZIUTtH4/RejIzZsn6bELAc8nYLlph?=
 =?us-ascii?Q?3evUw9pMKCHRANmCVkEY32N6bvmSBQtMHwuA5bxbopchEUpX3DtYu00s14av?=
 =?us-ascii?Q?kuNZIf6Frj++c88v7UjxvovyVsuuCXcvTlP1fpqqegPf4DCsZgRaNCQXDXT+?=
 =?us-ascii?Q?/sFM9r5cSgsyZzNX0lpY/c5nDGjmegmK2F4ZEzn11dOgVsSFlE4fl0ACMj6E?=
 =?us-ascii?Q?id473GweXr00PlL4H+XdXDKGNYGhndMmbJsAd8csMTySngMPIgdxzK8g1lyN?=
 =?us-ascii?Q?7OjRbHzPs2rXPs3Izs6pYgh57gZc5CPVrAwfvSTmxwbAbAaDkQprXVcq6ZMW?=
 =?us-ascii?Q?hSMParxcaai0G0pZmEsqaXyKFqmKYvyDNPhnDXaF0dfJahjYP5KtbWoBPB9U?=
 =?us-ascii?Q?4LFnHoxDYVSFbf5M4KJDgqEfi4MDG5phwFNDRE/KsA+tI5geJgZLIv9sotZl?=
 =?us-ascii?Q?KqUbFcTe+fnYE8XoDiM7IxJYaDam4NvoAujx5doMrjLN9CYf47/fN9UkyCdG?=
 =?us-ascii?Q?HfeAMmr5UKiIpTVjV6VC5BzcL+4wGJqrMwpV/1c9emvDvtWkn+y8ZX69hTXN?=
 =?us-ascii?Q?iH6enElifYS+x6IUa5YUG394fzEVB7p5a+Vbmcf9pNdw1yifWX7XI47p92b1?=
 =?us-ascii?Q?TOhAmAm+e6SHTsDX2fjb5gzkrHF3+rOA2IJcwQgp+lcmveu73IFwua05KmGS?=
 =?us-ascii?Q?9EwcZXGakILWxFbtTfFOR51gf7ooYw7tJFcjZ1rgXztahPHOgzUevZG4bOPV?=
 =?us-ascii?Q?jT4IBTpRgOqo8J4+3KlBqnPDdwJoGGXCk+Z6DyOF8DpXUsn7e5kXAYjlpMj+?=
 =?us-ascii?Q?8G3/7VsBVj0Cumeh5rnDmFeh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1c7ca1-c84a-4ab4-e55b-08d98fcc0a7c
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 11:07:56.2722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ji8Nc3wq3NOlbUMD8tW4zTd71X+Ry5Hnimi9tSLWnVp6dXEc+sSh31l8FjlCm4rMgeKTfY+Gnxe3ATJNgrhsvQ==
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
 drivers/hid/hid-roccat-isku.c     |  2 +-
 drivers/hid/hid-roccat-kone.c     | 12 ++++++------
 drivers/hid/hid-roccat-koneplus.c |  4 ++--
 drivers/hid/hid-roccat-kovaplus.c | 10 +++++-----
 drivers/hid/hid-roccat-pyra.c     |  6 +++---
 5 files changed, 17 insertions(+), 17 deletions(-)

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
index ea17abc..e53d005 100644
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
-- 
2.7.4

