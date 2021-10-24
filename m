Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C357C4387CE
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 11:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhJXJTK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 05:19:10 -0400
Received: from mail-eopbgr140127.outbound.protection.outlook.com ([40.107.14.127]:14414
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229463AbhJXJTI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 05:19:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fT/tTiTD7YxN934woC9q4XsVhFOB5d3FpBxNmsGHTqN4fyHxsSCVUA08F+pixfAgkbFHSe1AodveYqxVrRc3XN8TVDwbtUKnXTtmGCp8of30MyDkV+MFUTJ45lGwxLoKqnggV5E1SoELli3bFZ/s8qTvy0T/7lMxY75CjVrK/1RprjC16VGcr/K+rgufe6DGw6g4CTCjakk0a3XOm3/Vcz0iFF8hUrqt4uVRllEFhNNpMgy1VcxU3mHhvgNqel4ZyjvowVaUBMudQeVOh6FimqSKBVzmRhCNvPDGvsbegYTHDr8rO3B8j1e6P2beNvp4NNmErco2ZhuFKs1O9xrqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uXCVUjsi9lkmHiBfMKGZ6RDlx5elpWV5r6clrOavR8=;
 b=PC1D64JVb9uqppBcyxGdOx2d8REd8w9F1lCkPmTQIQHmXksLWD85ZwxKSi9DoTOIxocAhiH5+qPVHXJpPcT8Y2svut/eWe9rA+pr2+zsSuJfkxyboYN6eYPNG22sOQTktWfgYOcI9XN6CZKiRlNKHaofyNDc3/x2DB1gln1crssYbkCCI+lrw/tPY7oq14ZiOL5ycE0xF+GyfWtcT0WYg6/jL6/+GATrXQ+MPE/Pfx4b7Vx8tzykUlHevRvkRUE8CWnbsRXK/1/Eoe6m6l8F1AkMtoxakcWTWj94GV7Np76bKB5DA4bBvN0XCIJdqBvDfPOA+zigmynix28Lj47M/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uXCVUjsi9lkmHiBfMKGZ6RDlx5elpWV5r6clrOavR8=;
 b=g1Kzi+eoCedVFbqk2HJ00e/kNnpmWle9E435fW9zDTMaHgpOOieLVLO6E49tBFGMPa5AXiJzVzJu48Fgw9OesBBG+HTQEtgf/o1Mv9GmGww9jYvVwu/waypQ3MS7Td3pqebetU/qyRgUkgcvEE1LV4Fk8J4rG016G8mz4K7FClw=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andy.shevchenko@gmail.com, andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v7 1/2] iio: core: Introduce IIO_VAL_INT_64.
Date:   Sun, 24 Oct 2021 12:16:26 +0300
Message-Id: <20211024091627.28031-2-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
References: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0035.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::15) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a89df43-7956-412e-b52d-08d996ceffe8
X-MS-TrafficTypeDiagnostic: AM5PR04MB3011:
X-Microsoft-Antispam-PRVS: <AM5PR04MB30115A864244A9A950067FD8E6829@AM5PR04MB3011.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhaOlNKSdyeYe+N0+hDrUraiP44iKFJdrLyliDNIHJdbrGrMQOXCCLTg2WVKmnAoZit/P7UA46ggcRZHMASwOwvysIm2nS0bcVMStlAt9x532UeJr35egfgXig7cSsF+D62q4msMB/EMKcQZEUGO3jk56TDZFsbMdwa5hMvzg3fqlhxi2whEmugOu6BAvA0VwpktDV1TaJdR0bLJTlim1QLBSsicy3AoUucusUGNNp+y1PkM5QsFFb4SM0kClZz+4vJjuHDat+0hx6xca9Reo6va+wRyARs1uw7NXLzQlcGa2Nm4mdu/v6iHYBR1msa6iyL/56QUlaIcDpGr5M93kdhOMIlA9r0x6aoDdX+4mULXD0Go0ulKlWojr5PBhorrhEsRvbVmTUnu1nRGgTLpwSpbkREpsak9r5ibaAOfQjpUNsj2iAp6Hf5yHtRTFXwIpNMaLrkB6RGl4s2O5jiNw9vP/HjjC+BTJchpy3/tY4X9aYMoFX7Ivbdfy5dOAutaSWx6GO5CLwVpUSgq3Yf569IQiq99DEsjgumJPDsJT47687asmcELUtqr4HiXirjDWhwvSBTpMC9bxFkE+UEwuL+DPxa/N7yBq+nF6z0QNoiIRthfDAU+l6LykVFhlA3kvVct5ZsF60bqLpXd49FHwCekDyytv4PXTt+GI8cZ3mmh7ERcCKXyci3PEcJ7ysToGMaQP6lWBO8XUJTpf4Md4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39830400003)(38100700002)(26005)(66556008)(5660300002)(2616005)(66476007)(38350700002)(42186006)(66946007)(36756003)(55236004)(86362001)(316002)(44832011)(107886003)(4326008)(508600001)(2906002)(1076003)(186003)(8936002)(8676002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2SQGq3BXW5HoPva7vZ9PFTMK/lwH2j9PMv9KvCo0Rx3PGeowh88676GRdPII?=
 =?us-ascii?Q?Qr3fl5poum2tsD6UO3zgaZLyCBgh7C9vZ5Fh3QAU28HqRyPvbvHlxTgsOfoL?=
 =?us-ascii?Q?O/wvn01JmYxwsMSM4iu8ePVWUIGJ8RvOJfxZUZd3P0+HLUvzhjOQhNhXl71H?=
 =?us-ascii?Q?P9a1CUyKM9KRNBRZl7Pt9+7r7DjJVDaCZdLLuQpWdG2M0eUJBsw3Ep6g/e8k?=
 =?us-ascii?Q?Y0Mq4RlPR5lvkVVf/4CquZ+uEwAX408T7hhg0AGVN5/PkLxc3/m++A6gEqfP?=
 =?us-ascii?Q?61spzrkpR17vcTV2S2Ho88mj1tTkLbUhOtfidGyULBntNRwzvTIdOwxtUrnY?=
 =?us-ascii?Q?y80YJXPSGqS54bPc3QCX0eoc/JPY3RODcBDI/d17MpuOrQhvoz2Pu6htvZri?=
 =?us-ascii?Q?PaoxsLRxfxN7p0FqTQWqBDGAI1xoYxazyM7GUEiJPYigON4eLW/8goAqQq3P?=
 =?us-ascii?Q?Z3C9my3tSz1LdfYfbnhYWMrww85+VgZqLOkJZBSOdBMz4M4q49wpwqeQORoI?=
 =?us-ascii?Q?3/VCHoXb5/bCTyiCI7gW8EGLW6q854sXdIEj8No8cl1uypZRnweVcUQbHVFE?=
 =?us-ascii?Q?EBLTyH/9TggFrzUFDvuoGOBL01T1pqmb06Ikv6BzLoN+7fHPmJKiyY0/ngpi?=
 =?us-ascii?Q?fj5h5zCYfTkJ19zy2gLkJ42hBiOEyzGcB3ffqY6S/bXiB2aLCJAVbnIBFgcT?=
 =?us-ascii?Q?DW1buukDjlylPJvsk1C0Nhm0YN0Lb3Cdg58594jVGlTG+moVzbwHmejUg1Yy?=
 =?us-ascii?Q?G7BGpWJXRumzyDu1I7o9kxQf+J/dtwIq1WxURWUS55rcKQ7Kas6xDfS2LUtk?=
 =?us-ascii?Q?zw9anXwYjws/+DeBLmveAs/anYL3gknIUELhRapyQ1UPHsmHEKcT/rlHoIzP?=
 =?us-ascii?Q?k1nR/1WLoNy2XCw/VpywCwguxVFOIELCf3tiHkn+x1D1+GZKWuXiTiz7JPNG?=
 =?us-ascii?Q?GKPfjlmpJMFJK6finynz+LEgt6MeAwQtIuRb1rA1j+kTGrUDdh7kQHoDNioL?=
 =?us-ascii?Q?166wninqdB1SJbcZ60L3UzI1f2jHZmxFkMsKYeM4bu7nSe2XKzjmB5UpMnMv?=
 =?us-ascii?Q?LXgnLxLDGrbV6wDSQEfERatp0QPE8ZEUmG5AiBz4E/BMz1xqGvu8JSQ/9jBX?=
 =?us-ascii?Q?QEw/E4eL93comhiogPsnWccz/dBfSb/mB9JmKZwNp8DGc//7gIF+OYjF7nGD?=
 =?us-ascii?Q?KL7onNXPPnLml2AcqFVoOA+Unz/IAd9qsijD0n2Gsshv5gYRkctw8/mzibkP?=
 =?us-ascii?Q?0E+S53FlGs8Q9EPF3ONyciN9z755fl5/n9TvPQrOnmrE7ozAk6dRtNBIisqZ?=
 =?us-ascii?Q?iXhf4Lg1dHzPmB62jUuWt4DH?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a89df43-7956-412e-b52d-08d996ceffe8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 09:16:45.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOkxzpPpwKep8k/aryAM/+Qzj+RxB8IHbH63xweUUTSgMeryPzjtjB1kFqvuWgld79GantQooH2SuMzu6pBlxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3011
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce IIO_VAL_INT_64 to read 64-bit value for
channel attribute. Val is used as lower 32 bits.

Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
---
 drivers/iio/industrialio-core.c | 3 +++
 include/linux/iio/types.h       | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6d2175eb7af2..49e42d04ea16 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -702,6 +702,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 	}
 	case IIO_VAL_CHAR:
 		return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
+	case IIO_VAL_INT_64:
+		tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
+		return sysfs_emit_at(buf, offset, "%lld", tmp2);
 	default:
 		return 0;
 	}
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 84b3f8175cc6..bb6578a5ee28 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -24,6 +24,7 @@ enum iio_event_info {
 #define IIO_VAL_INT_PLUS_NANO 3
 #define IIO_VAL_INT_PLUS_MICRO_DB 4
 #define IIO_VAL_INT_MULTIPLE 5
+#define IIO_VAL_INT_64 6 /* 64-bit data, val is lower 32 bits) */
 #define IIO_VAL_FRACTIONAL 10
 #define IIO_VAL_FRACTIONAL_LOG2 11
 #define IIO_VAL_CHAR 12
-- 
2.17.1

