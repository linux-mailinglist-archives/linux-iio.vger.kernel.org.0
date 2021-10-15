Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5848842EF5F
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 13:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbhJOLK3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 07:10:29 -0400
Received: from mail-eopbgr1300118.outbound.protection.outlook.com ([40.107.130.118]:14625
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238322AbhJOLKU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 Oct 2021 07:10:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lN7RDoO9ij2fUEPQbS53jGmikJZx9cW7xYlhSz+iay8d5OYgSRnVA9qomf0+kS2KigOdEztbF5qkUsLRcMGjTUm3SubU/UmQKK9tsi3cblelfezlSA65DgZM6/uIUWa1B4sNL7IPsMUjKCFEgJrhofOzuV9RFbyQuxNH+c8KvoSmy8JNZCpWUBA5dwGj04ZrKu9EQThlC0nciNJ5aFhdaXl0oh9coZNCnkx6jjnrx9GTvu0g4u+SnLUHbbYVrz6QrAxC/u14R6Y0aPVCqTK9dskf9k2mOc/rQdV+pFyd2FWmlKp8LkECIq+ltpgfkYAiyGMSizHE3gl4G5Y2qs5Ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cy6B4AhVgYgyaErCxKv69mv2q/sFNND0VpFvBhPXoMo=;
 b=GgoIF87btidOQcxoUpunjs3cOQkb42X77dBA3BJapwDchM+Zqjv8+ogKWHKvBzz0Um1L5fr08za2dyTnfIup2YXyZI6Kq/BFU/zJWpyREhhDoL6hTfK+7UExf5b6n7f5t6kqVDvQH4VFsQDSRtaVkVVlEdqLguWcZQ6xH8y35u3opdoVrDDl/1rO5OmbdfmJmwLojeBzDK8Wm4JGa53AZTMqR1iQ0CcgkPU8D+AM6LEdrDuQcFpvoKoKqUh9XMS/6yuQ2pc5qq/ewIbQUY6Rk6MGkPUuJ1Bt5kB5gtd/AR7re0mxhKuyFIArd1SuC4cvClrGT/w9DQNvQ/NFuTqs7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy6B4AhVgYgyaErCxKv69mv2q/sFNND0VpFvBhPXoMo=;
 b=hR1S01bxgIVNHDjAKhWFDsB6u9ORc18J3LFXQ23IF7RyH3FDuEGpqfyuSpBXRSUeVDU9/bXhB/mPz2H840CFLMjKsfLPyEMs0uTnOggn/rmAzP0vMGOGBluFtP7OLo2lTbgfmObFT1R/8Q0CgX7MPqEbKE2LBI4xMYpaLDYF0Xs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3212.apcprd06.prod.outlook.com (2603:1096:100:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 11:08:00 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 11:08:00 +0000
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
Subject: [PATCH V2 5/5] hid-sony: replace snprintf in show functions with sysfs_emit
Date:   Fri, 15 Oct 2021 04:07:32 -0700
Message-Id: <1634296054-6971-6-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634296054-6971-1-git-send-email-wangqing@vivo.com>
References: <1634296054-6971-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0172.apcprd02.prod.outlook.com (2603:1096:201:1f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 11:07:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61d2bf6f-1ed3-4e5c-7760-08d98fcc0cdc
X-MS-TrafficTypeDiagnostic: SL2PR06MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3212AD6F8A94837BE856EFFBBDB99@SL2PR06MB3212.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1xLs2QrbJFeT1cuSczgmRcMOeOXenS+AxNF1H/WD0+Iic7HcPmMEgPQWRG5FR1p4ehCzgN+6ewuXb/mlnQHQgjjEi23WAy5/g0KL1Z28MhUhyjbHwhtfUPUQGxhw1TpG2zRfb545aWfiRrmTirlQX/dTblAtOgfTTogSM+gLNvp3hrfv1zlPJLh2JC6bicC3tp+LCVDQ6qL+M338YechThjlrKbUnieUbEkHKrIGF/Cx/DMxCoGY+0rW+AdIZ3VB+qWCVsdveeZ8NSA+5ipL/+yaModYKXCBQL0HjAY5wcSK/iXGJgbpMMBqCh2mpYYlM9iBkH8zzc4/7idNDRJ96OUfZuquJ5sQUAc92q4pRQ17Y5cH4R/F4bbckU4FJJuuqg/CzJcpKmZg4mo8BdrNBUmK/DuEDXGgsjIzKLH/3JsXfP8PNtBMM28r5kg+Yq4x6ZhUF9bp70+yRuBb/Lu2NclyQ+cv0I28bTlZ9zsWl058CgVC3GAOAnz6DdqpaJKp1gr6YpqwDoanGGXcyDYf7yI2/GR9a0R00nINSUmzghmGQoOzdadNiQgq621jAvFofG27itptWieCSceBc3S/K7kwuZ6M8e6RbdkFz7GR5lLzZwYSdOCUICAUodhaKtk6s/njHuXTy5uz6s5IKrSPPkLkCYNKa0bxOpIGMqERAs57RLjm7Pyg/zsHPWbEGMvuZpCjNdCXVNzMkjZ7lyxFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(2616005)(6506007)(110136005)(316002)(107886003)(86362001)(4326008)(5660300002)(2906002)(6486002)(26005)(52116002)(8676002)(8936002)(6512007)(186003)(38350700002)(38100700002)(83380400001)(6666004)(66946007)(36756003)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nsP8zqNqZdq0+9NLffu9C7Eq0QbYeVmGIsi91vR9AAruadtNld002Fra8zhM?=
 =?us-ascii?Q?kiIa8RPQPud0nqKVXCLaG/7d1Wrxecb+6d+Vgn4dCDKl80Z6knHtfFDnbm3C?=
 =?us-ascii?Q?t5uwFq7sZ4yvP+zE7g8L7XFu8bKthYIT3Zf0sXegNqZKjFaGAfnJucuvhSi5?=
 =?us-ascii?Q?qzxzt9sBADlFuevkMLoYyoPcWVxV23OFaKd/N6ewj3l3MVWICJXdrZo+vNGE?=
 =?us-ascii?Q?qUtg9S1VWCzHRBemiZY8V10HwPGMaIPSVzu7wbjE1JL60oqMI+XQKkOKg9TD?=
 =?us-ascii?Q?WqacdZfunhoRbBHEBRIxNlLICYzuRBDqz5l36d4p5PGS4YnNU+rz4ATYv1Rl?=
 =?us-ascii?Q?IaXD4NJkhD987eT9alzRMvccWLoDCC4Q2j+2DkIAWA+q1NjVveN11XFNhSRd?=
 =?us-ascii?Q?JVJVxw6YveyrGSWWQ1R1VYlqvIfA5SbqxSY4d5F1oWlyapTSHhDyVtsgHnII?=
 =?us-ascii?Q?lsBu58fnzuSErRZTRnpSHbN9R1ceSBVBHoQ7G3KY9F6CL2CT0dR2K5jroj2F?=
 =?us-ascii?Q?kqC2bGNBpX6VmInKSqxPYWBThECZsgJGpBfIw2XFOrICF3uqKDUw4RPPkplC?=
 =?us-ascii?Q?pN1APTqT867TAHPoNI2F2loV0NZgg+T79z9q4goKRJuA0Xh6+kjrvkeQHMNH?=
 =?us-ascii?Q?IYxrgmL+vvfFaRMBCDBSd8e4nRlNgypep9UiiHnTHzB9Klx5OSCYEDHFa0Xy?=
 =?us-ascii?Q?Nh+x2nhJDPG7/gyGZitQAdLicKsSL08MZ0424Be7Mf/w3fK0BAZOchUQPnfZ?=
 =?us-ascii?Q?KFUhDINQH5jjOVmdhggAHThJV35dP/+z9XUtzHSKfjHjvEzw+5cBCS5dkx7W?=
 =?us-ascii?Q?u5XTEadqP3bOUI/gvvMHFXqcSUaPtbE0cVbR3y5lTn4Kf3E0mIUKWWQ7U2kE?=
 =?us-ascii?Q?HPHantKrsuynMhclnC2s3/lo1WmnQLQ0vGeVjkuPIs8P/srOoA8dsCAPlwv1?=
 =?us-ascii?Q?qn5s2RahaJ3R0SixdkWePo3zldnHNz28KaBI3ClEIrrXghSOBsCdun+1a1Xe?=
 =?us-ascii?Q?VI4yjYYOjXrgNwlGNuKwoFM88cZNhqvCVrY5ahlezdnVcLdx3NQZfOzhyNlV?=
 =?us-ascii?Q?5m5DEoqKhsAn7vXFylR3C+EzKyVEo7m31w2PLDA8ZX1RN+Wgh/vY49lGQu+6?=
 =?us-ascii?Q?whQMjDFsO/z/CLBJIa8kTuZZsDSdAcL2Z27vFQHGyzflR1vxyRCQYX+fPNyN?=
 =?us-ascii?Q?wf7US7NPKz+PAVmYgvbZmvG0iyVGPeSzPLBR0I/yAqzGLPbrbxNMvD4HtKwt?=
 =?us-ascii?Q?zCfnsTkD6nZKe6YdUN2/1nSjWdjiJ6qUlrV6JNkf6AP0YneFwejYqLvPsBhM?=
 =?us-ascii?Q?ea0NMfsxv+A1zOP+EGe8hL5R?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d2bf6f-1ed3-4e5c-7760-08d98fcc0cdc
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 11:08:00.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQn9ifR7itmGGZg5Q+6If6wVSn75fiSCZ0bjpmfRd6A/Ne81K57GGJBdH7Evg27nJY8fQ0RQu9CYY3R7F3udhg==
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
 drivers/hid/hid-sony.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d1b107d..55423db 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -707,7 +707,7 @@ static ssize_t ds4_show_poll_interval(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%i\n", sc->ds4_bt_poll_interval);
+	return sysfs_emit(buf, "%i\n", sc->ds4_bt_poll_interval);
 }
 
 static ssize_t ds4_store_poll_interval(struct device *dev,
@@ -744,7 +744,7 @@ static ssize_t sony_show_firmware_version(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n", sc->fw_version);
+	return sysfs_emit(buf, "0x%04x\n", sc->fw_version);
 }
 
 static DEVICE_ATTR(firmware_version, 0444, sony_show_firmware_version, NULL);
@@ -756,7 +756,7 @@ static ssize_t sony_show_hardware_version(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n", sc->hw_version);
+	return sysfs_emit(buf, "0x%04x\n", sc->hw_version);
 }
 
 static DEVICE_ATTR(hardware_version, 0444, sony_show_hardware_version, NULL);
-- 
2.7.4

