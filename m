Return-Path: <linux-iio+bounces-23581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9688CB3E654
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 15:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD023AE169
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 13:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97D633A012;
	Mon,  1 Sep 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="M34FEFa1"
X-Original-To: linux-iio@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013015.outbound.protection.outlook.com [40.107.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBCC3176EB;
	Mon,  1 Sep 2025 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735066; cv=fail; b=FuzwiaPdu3TzbhMSvmAR4gV84Iq6wLFnBdfQW8NXZaS9eVzrho37OI2l3dNPVRuTcJMTsUPV2UmWmTMndCKMJULfUtQP8MNSU8zl9NT8Vx5xQIJKTnKjTp0ItoQIqrLORQ410b9hZpyFzhP43QWIM+3KAAPB+HhGwVGrLxAHHOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735066; c=relaxed/simple;
	bh=sx7QDcSpwIj9rNekWyGa58RWY2lbJGP+qFFxRukCqfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d7FeqRpLBWz9iyKZV65DIh6YB1l/hrZqbdZan7t07SP0UOWLlbemoHKXllFCGE5Qtr0bufNNO+KtbuRsMXUrIBXBY0lkTyNyf7mQz6BDD+FbRcEG/iG34SZs6gGf6ic6dd8K7oL3hY5ZmYfvtWxiKe2U9CXA+IBLgWYu5to2TEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=M34FEFa1; arc=fail smtp.client-ip=40.107.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVy4OezpLR8XcvNG+xMkzh1iVz3/pnAWkKNtusSxdNuQ7eS+9otB9yNGE70ZAe8vq076ZhGUCabQ3j0yrtu9BgVB65lJJ64JiqOg05PMouYsWW9ObosGH68l+j1fVeo8ux4uSqWUJRxKeIGmKg6aqlAyQ36Nfz6FcX/o9OafgBV3kwWsLmOShAa2pVsq4BQCNTBmnDpuXBiv2/osjnE21EG93OqNU5c02PlhqhRCKQ8Bbja1LbgFL9+rzamzpcanXjfLAlJC6+7EEdUVQHISx78ppzJ7xQNUEG2RJlqfccEt1qZDO7GTDl6UX4XPmf1a18fYR/wyNQ1+laGTSr78AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reE0YGEQe3fiOkCWlb30GQO0HWkxCCYmdZKr7S6PPIc=;
 b=l5zJQIYRJ7Sj3GD7PDfA1onC+MJRJTvhjZABJ0DJOFyZJn4Ql7+RrEp3kISAJpyrpV3hG1551EVHkh2fKua6EBdJy7YTuyUTTV2o1B/K4uXx27V3z+NPvMjNolURGNPs5i454q6aE5MM0sz1t6Oa8wppcYwlkZ58XdAKyQj+MkA+CDlpend+qtSPsWHyEqwPHQHDaSExr+zQZP4vi3SwfVkMZIJCbTxKdCjEQg15P54qUNTqPGw8N7EQ5q1/f6Uj0ou/ALUyH++mlAScYcr24i+7Ij8v07xp9Y1Q0zYiTnNwZlX47R6qv+3HqEFM2PT1MwJj0YuWGPKVkLwhDBtkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reE0YGEQe3fiOkCWlb30GQO0HWkxCCYmdZKr7S6PPIc=;
 b=M34FEFa1Br9JIqlQe7GRY6XvH801BFipqwSIWeRh8rnsttPBBXbhbuCaOBQsekojmIRCSIdwElhFQmyHN1bEFj1HpZxx2LJmNxcryXAD9ZSU4x8gWdXjD6iuaaEWeB9sRuoujd3Ngc0Dv4i8dcD3IGWJlHtTIri6NXkvygad4GmvODae1KNfJWR4veEswCc0jtY87rwCKjiLYsRfxqL1tW7Bof+21EYRB8ifzmVJljp6nhyykFilZTO5vfXNAYjaExQDIlJDD5zcUkaH4SaorQ0ZReLzKmejWlCQs90vOzqx4/ncmfgwGwE4Q7VEnikj985ZA+LK56DMsTExd+KzWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5742.apcprd06.prod.outlook.com (2603:1096:101:ba::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.26; Mon, 1 Sep 2025 13:57:40 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 13:57:40 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2 1/2] iio: dac: ad5360: use int type to store negative error codes
Date: Mon,  1 Sep 2025 21:57:25 +0800
Message-Id: <20250901135726.17601-2-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901135726.17601-1-rongqianfeng@vivo.com>
References: <20250901135726.17601-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::18) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2aa95b-bffa-4260-e00e-08dde95f841d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r0g987KzT4zIzViJZJuy9SaugdEYjxJHUqyERwuodpQ4dirTTezB99zAfcXv?=
 =?us-ascii?Q?+xadKr2o5DGDI51FF4t8dqCgjXkK6NKR2M4gMWR92gLrNk5CIZ2cx4SyBgpe?=
 =?us-ascii?Q?Eap+W6e9KANzgFrrX99hyeJx/4adw8G7LzuSybCdc3GJF82qo1YHpmRnjdkm?=
 =?us-ascii?Q?qr77WTufyuBPhd4PhN+RBVAnY4I+SN9jLNP5RjfRorJRqBYyCflxF/16fIhk?=
 =?us-ascii?Q?tQiavz/WrXlzTg+YyphczQmMIoofjnh5+2B/mEbpsYKZUacEKaDx1M0Eq26t?=
 =?us-ascii?Q?243l/RKX8arGo/8NOYBkaX3H7hXogc3eMmf+b2BLLa5rA9ba9StYf4ANcdYC?=
 =?us-ascii?Q?Fonqutauv9rJ5O1jZQevbSYbEi6NOdsf0hNc2L7902+KKnxWqaunCjEo08OC?=
 =?us-ascii?Q?G7bv28Ji4PAFidehdzgC3PpUKnRzhaMXyVMvSYs4uncTMcinA1roqvd35Qvy?=
 =?us-ascii?Q?fBlVStDljJNbziLkF5Y8P4gOa/iA1h4HhPI3oKBDmpYrVZqwBsSX5a4Mlxdg?=
 =?us-ascii?Q?0PLnZP6s2DsYZB2L9PmrF17g6vV2vDbFr2bAHi7iWvCXec5cmk8pjgCrFC/2?=
 =?us-ascii?Q?MDekeaFtOlnvU3aVEipG6LiiejD3Fi/wNvqkiIdpldivvHtYDVjCAR9HVOvF?=
 =?us-ascii?Q?Bu+Ui2/BvwVYx4u3UMV4NGaTn6rjHC0xpSqdqSzNlGbZglLznScYd0TQsnic?=
 =?us-ascii?Q?1n1eLJUifWhkIzCpWG+H9F4AS2bIsQ6jm7IT1U/4FOmsCpd8vxlobp6lfS8J?=
 =?us-ascii?Q?wjJbbDCxJ9+1tPs54zr+FpVq4srNDoMNufCZYpzc9TVYt025yzqUNsoUVB+h?=
 =?us-ascii?Q?y850L51NexQzvXM3fZfPZ8zz5JHGbxxXR4o+LAm8oWgWKcOXXgmqWNRQ5LpU?=
 =?us-ascii?Q?3fj0+fNTqnrxESBNUeWnavyYULMk9sRe2XoRk46NQTCFLfDpXxMz8FvsqNY+?=
 =?us-ascii?Q?v3ryo0Mjlvfe6gNYKT918WCESvo5S4ZmESw4EkkmbepflFmk5/OB/UcxxJN4?=
 =?us-ascii?Q?wrbrxDVbGXCRWcL4BVNHOxNcRfw+5aaKeXHuOt5TxDbPNQH8iPjyWsPyS83p?=
 =?us-ascii?Q?Dk62ogNyZY+U7jKWZ4TgPbeYU7sEaZpU8bNNc16W3m8w3xGqfR6JjDpncO0o?=
 =?us-ascii?Q?y6soHkT+BuJCKJFgOaFtEt4tzAFXQPBWCxmYh2/6CDSFAmolFv8jOhG1WYUc?=
 =?us-ascii?Q?Q2Vo994OflxF5CJCsCbml1XKp3JScwFIpefePAX4P3/FejpmsMCVnCwk4vyd?=
 =?us-ascii?Q?4n+T9j1a50qoyKDH/GgsK7o9HioLAqquA3Tg7r7o44PzOLQKB2LSIG7/coS/?=
 =?us-ascii?Q?hEVG0m40y/gv6pHQYNwjrCes/dFIex8NEBfCVxqoxOnt+qqi60uD0iqzJmSH?=
 =?us-ascii?Q?AD4NrLnkafOBYxqXLHAiXXcr2PqxpaesRYXRHt0plAgrDYslQxZo9FpT7AtY?=
 =?us-ascii?Q?MW6dFcjTzBxvsSEgtptyFXNBJyzYaigNQuxmy/yUpiN8bUUJ/PMndg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MX3vAWlg4T8QU1kFgzw/47GveaW5EqAzUcsFoNqNvfE6H1BEI4ioQcz0oleR?=
 =?us-ascii?Q?spdhhUmZm6/rtDyqeb2vKvfqIg4/GXMvWCdx02COx0mJ0dyFwfDvVY1mNSjh?=
 =?us-ascii?Q?Xi6W1uT9+XRSwHVpnNQij7UwgZVKBkNasqRGEVrc9MG7AZMs/yHqLT42AyPC?=
 =?us-ascii?Q?nmeYogxBspa7VVAig0ZW+nSBKOBfgcci9s7xmOzdyIUWizPY6hPakA7Tih9e?=
 =?us-ascii?Q?smve+lzDKq+QXAUzoAvuZ7WtlBwK1yVGtBgSN3z20fV0AMAta0MbTom5pSmI?=
 =?us-ascii?Q?xOzhbo05IlykB4snyM1c2b+GJtkCIe+Mk6qeomtTUOgQC3PO6/fusDhdxzEt?=
 =?us-ascii?Q?yze6MTRCtUslRF062rKv2OFnE6wxPYqddeWKE3CVdY9jeqdWOffz6kN05ja5?=
 =?us-ascii?Q?LX1SFr6DQKHsscNc2CdBX5jUVkNI6y1zpkO4Tmk8JcDplmlX6L2n5hny7uP5?=
 =?us-ascii?Q?etntR6/xtKjECfg3bWFEIRAPvwQDLsesdE9eYgkq6KTY7vLQUkig6lslOeK0?=
 =?us-ascii?Q?h/YF+gBMrqy7l/GW1dpl2VXXKSd9Xd5VRol8UHZPVFMhK9MClVm3gGyFPlMT?=
 =?us-ascii?Q?n9IXWVFiLF/xGgw/Y7f1F0+BlVuBQayS74cNf5MbG6vEGbhefSa+7Nok/9Rw?=
 =?us-ascii?Q?Tuc6t8vx/UtyigNhIRRV3mf1SNmwwcz3/K7rBQ8uq7YnNzmqp+ZxGVljBW9d?=
 =?us-ascii?Q?rM6X/oxlPpZsHNATokLb+LZhDp+o8iD6JhqzdIjdS0k8PCROqct0oJu/XrUF?=
 =?us-ascii?Q?HbDvcYxVlznOWsOaIEkC0DZ1vGOEBLbqFc9bjsboy3J5I03w1mI17QMKc0zA?=
 =?us-ascii?Q?ZDRn5xBIGUYTmzagwg1GI0kzFyvYSSqoh6xvmoBJJgiTwTW+FJHo6I0qsIuu?=
 =?us-ascii?Q?Mq9/dJEd0uXELs4uASIEkPzR6GLNzcp/Gy+mtLpxMRqJi7pQnGWuxGPWkfgT?=
 =?us-ascii?Q?SmXotJSfymbKECnsZnP8jbCkzm8r48p7xPxSn55FGzmDp/05dD0tRppnRpnw?=
 =?us-ascii?Q?C8Cy8w0cHwYPYZMN/d00kAs2ezAjwgKIjG6rJhPPaplCHDqI3jrDw81PAZf1?=
 =?us-ascii?Q?E/t3LCzZ9bnzYmJYWNIOfreI3b5vnjVat8ayEcI4q1Ch0ei17+UIiRsGbJGm?=
 =?us-ascii?Q?Rsm2vx8nsLSdrnQBkIdRLPwoVW1E67XhF3tMHVoGQfdGdxVGXzk57vokb74j?=
 =?us-ascii?Q?eRB+3T4yOZBHKY5sHThy+6M2k2+7/wkL5mdK4M8TUWmxUalO4MZQVEuMUdJ7?=
 =?us-ascii?Q?gBgEe7e+h/bGvOgkmCQ2FE7ZqdRSFZ6DPWHjDVwjP0E/8kjw4ZbP0mmac5Kn?=
 =?us-ascii?Q?zwOea/MysoKtZZSqa6qzBn/7hkk1oU4ulR3ed8FJU1Ocj3J2zbgmW/Ux+gzr?=
 =?us-ascii?Q?/XTxEZHqF4BzKoNI/hMOLYxPKu5J2tH4Ps1HxmBPVzRd3FNfce4Ux9ER67Ae?=
 =?us-ascii?Q?gYl242PLmt0meMfaVPgdHU81dpVoTaWaTBbFCv9xcuGNjlWkqaTLyl2KckMq?=
 =?us-ascii?Q?XGeqDz427RRIP+mNUM3cPjluW74HXRgb/GfQEGyez+MW224+etRQ2w/+9Zgc?=
 =?us-ascii?Q?IjUEVr5Mr1yY4MBmkTG8qK17QHi3qy+UlbiX5SdC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2aa95b-bffa-4260-e00e-08dde95f841d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:57:40.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKhvnCtAAT7G1Q3ti08WBC8wH0e4Yo/FsOE+ks4igt/CbE4KRestUtqpF/vkUKkpugowOaSGE7mN7CmyrAZ4Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5742

Change the 'ret' variable in ad5360_update_ctrl() from unsigned int to
int, as it needs to store either negative error codes or zero returned
by ad5360_write_unlocked().

Fixes: a3e2940c24d3 ("staging:iio:dac: Add AD5360 driver")
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/iio/dac/ad5360.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index a57b0a093112..8271849b1c83 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -262,7 +262,7 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	unsigned int clr)
 {
 	struct ad5360_state *st = iio_priv(indio_dev);
-	unsigned int ret;
+	int ret;
 
 	mutex_lock(&st->lock);
 
-- 
2.34.1


