Return-Path: <linux-iio+bounces-23582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD50B3E657
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 15:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526C2188E5D0
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F3433CE9B;
	Mon,  1 Sep 2025 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="X4qlYzqH"
X-Original-To: linux-iio@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013015.outbound.protection.outlook.com [40.107.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77D133A011;
	Mon,  1 Sep 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735068; cv=fail; b=S3GK1RpPwkGn+HIWJAOepf3zBV/aFPGhg5RVEQD9aH7W4FWe24eyWsQiaGtYVy7O/w6OiEUzOdm4nrVji4AJ3//X7zY1YVtxQLkpDlA3YN1QtvgmajY5+DUJHCHL3WhIFMOk/jnBkyzQpaQYVob98ISuKSL0hQK3x8tnxxUmZ8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735068; c=relaxed/simple;
	bh=xo6s9mzCxvHMTGTqZwzE09FRzlg5h0H2+WXsyaURg2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPVGznDmeH9OniABUfTBvwXZElkgP6eH4SZIhog36t6aNSZ1eNY+nQAZg4VsUccfuvTNrNUm/BPekfQpYpVLLW0uZY1hSZv75DOsEuEiWwtpOjkfq+Vs0/aBn+kPFtUn6JkF+WzOiagsky8UIVpPGNP2XcwdZALvseuy1yWDoyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=X4qlYzqH; arc=fail smtp.client-ip=40.107.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkzakLXYaMJzk/zhuoWLhjBRzUMPTq4jnMYrDrC9dEfctoAB3aVaHFcbstIkv41V5J5jFhvdsr8aWav8IeB9CCVQ2u/EcQbtczNFFx2GVNGU75E4yUho/3YWfAY6/vZJYrXC7F117NPXaIxF0X7fS/fSfPy9HFbUnSVZE6OG9GuJIfcKKOmJjAhEwFZRh0CTIZTsXsBRnF+dyMSFeXFbjz4zNyv3qKGjUHp0hW6ewHMBhqUgbbFwyqThg3DnxOZT809oyPoDhEhir+tXUUYW9F9utXMwt+HtC6D1xnvC7RLJp2IszdwI+9YYDfQswSiPSMkCavoCTC38j5oi4BikdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laA6qmqjTZJMsDUs8WbdMM5hXzi9ikYCn/H4/I1JV6A=;
 b=mmi4EwBRCZcNqWGrWIB7bmxxBg1WFPd/SiJl3q72SJ/M554sCqkOKHlxAXjurTNDPNfJYL3K7K1ZaXjM7zqXPJMJNtQJjYDP2lZVR79XDJuKJL1b/6Nxc6hgFilsbsAKM+SbeErF5zrEsoaa2e2kcuRSu6fD8ug7JNfX+hScn1YIBuwJBEmWn333tXa1rtX4Z3VJ9OPEwauWAw1YCGFMrDt2d+d+8M3mDdzVNTzddY+lDrokB5In+Y1YAs8OOHX9c4KGvhofLN1m0ExlLUBiYq7sp+jL3aMwiV0pyKXxQsSgfcF45SHenZG6+ZJDzJb0dnDjV6AIVGg81h8KDXL8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laA6qmqjTZJMsDUs8WbdMM5hXzi9ikYCn/H4/I1JV6A=;
 b=X4qlYzqH69r09XPZnuYJDaqC1viFVRB5J/S5OGRxkp2BgHkPocmcXUhDNsviI0KZP6QSbj2hoYAHBj96mFIhwrwwEZMJFLLIL4bFNbQhz5EQ0LJ3oB4Cm1kygViDy699nPRsJrsyl1FUpLICuw05oR7VMw7NLfyXdXG21NPkv3/uYkG9xne6dLTo1WDmZhEde/LhQXyjQmMefBsJNxr3Yr2zdCoRKO8GgxVmdUQbbdAUiahJ8cdSe8oPduasxNRihPO1cnpuvJ43ys4cWt68XflAfrLU6YWWujU21FTibRocO0Fz6xash2g7/PIpeDzUExCKLIpJFiBh7X8Uc85tQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5742.apcprd06.prod.outlook.com (2603:1096:101:ba::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.26; Mon, 1 Sep 2025 13:57:43 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 13:57:43 +0000
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
Subject: [PATCH v2 2/2] iio: dac: ad5421: use int type to store negative error codes
Date: Mon,  1 Sep 2025 21:57:26 +0800
Message-Id: <20250901135726.17601-3-rongqianfeng@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9c2b0da8-afe5-491c-909f-08dde95f85d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2W93XrAlk9evdaQkiM21NXm+qU/IQhjBaTOMbqVa1ukMIYnjtnwGhfXyKeFt?=
 =?us-ascii?Q?3MuM0BDOzZoIben/r5n68fxC5qUALgZ0jLaS4buXIr7i06G46QIC6ef1Zp1X?=
 =?us-ascii?Q?H6uPTjcD9ocn6GVWeaVdENzybO7kjAzJUy0DhpvcscC/wOlqIV0K9biwQxrn?=
 =?us-ascii?Q?uMVRRjeUFod6CQIX5dfZA3gyb7vEDLv2dJzVL6IC7XsET360XnElzE9cP0ef?=
 =?us-ascii?Q?sSgDPGLgvt0mKLOUkYfim2MYtgRixLR58S9Oip0+ejDEMnjyyr/me0FT2rBD?=
 =?us-ascii?Q?yg5DPxyBDNy4t3lE4yseceZAcCJkvUd6Gcres99zHt1vClScJcAwOWPXSvNQ?=
 =?us-ascii?Q?wOCN6Y2oLAKMvJtSsTToYmOufEZzCQ3KJyNjRWHGhZiDVshgZ25+Kbnmw6z7?=
 =?us-ascii?Q?VnDF2op4gXDHxrjhKhzEkLg+Xi8wJqQFWK4bBwt/So6obbUiPgBcfed5uqF4?=
 =?us-ascii?Q?O1hW1nrVu2knB/v4du/6gemMGgNfm+/r9d+VMye7cgUafAzxCU+nzt65FE5B?=
 =?us-ascii?Q?bxL4bgNW+gAWX19KAwk9TPlwtf6VcYp7Yl4+oS3KzcwU2JhdE3a9P/mZLqgY?=
 =?us-ascii?Q?Blb2C+BODytBpq/wZRFfqAbDLhxOYZktgypWRZDzttnR76eNXklUufuG7RcH?=
 =?us-ascii?Q?9L8UHO7m2ZLeFjYOyqgnkKxcCU0M2NXMQpaGhlgHbL2oO9S4+g9vNn5ZrQlt?=
 =?us-ascii?Q?F8md2IR0D6krixHLYdKOT3A/Ibag5De8Fsqbn83D28Fu/yiBVMqAEjk0u3lI?=
 =?us-ascii?Q?h62Y0hVLxU4gP8VwdCjt6D6aDetPnS0Zk/nwUmKOwbFPs8LbZYiEWP0IBteg?=
 =?us-ascii?Q?Cli+4SM7Sdoq37al6tBrPLWOOta7+Mi9BVQJrFCZTDcXOZt7jpMAeW0m9Klf?=
 =?us-ascii?Q?eYukO4U3HrZ6VGJESYtE4QqHpBcUdR+0kDmvlCZR/RSdsKvEQKWcPIT0kfO9?=
 =?us-ascii?Q?IXmuiKe73JQJxXH0D2d8lm0RmwpY4AOkyI0AYw8E7y5yAba/5lfPGs7UCTnr?=
 =?us-ascii?Q?eOok9+Dbb/ZBs/PUc36PRXPpNBtQjwR6D4y25GK6rsWmHhGWGluYa/vUBR9y?=
 =?us-ascii?Q?SJkoWOwck9/Wiy/9eflV7nrFh3jUVMt8jZ1FrQwS75STtKwh+JtlWi271Ewf?=
 =?us-ascii?Q?D2c4t0vLxYKotozBOYAkRT/d/3ICvJPSjLWfVps7zaBiI45NuKAHNK8COV43?=
 =?us-ascii?Q?0OKcOOqPsXg5xj4z0vXfQFTyndradatxH0T3y8mm0+Cq7VwaSJ+NCpg5XVqw?=
 =?us-ascii?Q?zv7vY2/ebmlWSVLfWzuXLlq5x+frQJpr1WqVMKztI1NOTVmuLGX4gtdAxL/i?=
 =?us-ascii?Q?x6xk6FHvD8eCT8vgI27wtTlnhJzoxqw1iEWg5tHzj3ddoQ7k5GnBJC8/Tx4w?=
 =?us-ascii?Q?bI5/1qhU3u2gIG2+wS0mxRkquRTrZ6O6OAlCOFkXu9I39zaj40n4Xz07r5nJ?=
 =?us-ascii?Q?jtojatj+AZrrrTPpHMqwY20ZipirHKFEUoPS59ZZbBRn3XjXDOhuzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7GBieOuS+eXGZKdDNjbH23b/kpPXaeaUBBJgVOpNSTCpUJTESltyqtwncrxM?=
 =?us-ascii?Q?cma0nZ+ekBN6QYeqhP4kyM/KLCGY2mfaevQ6ZODIwmw2udouQtB0iPsPnFdU?=
 =?us-ascii?Q?yv7HJw6X3SzGfZ0tJxdxm6VEb7J7kfPi2IkkqFtBJ7hSzUl85gjYvJU8KwUM?=
 =?us-ascii?Q?fTWUGxYRiNG76dXuZWY8vUJMNK/sRUw8M9DUJG6kBA4pntTbEMKDg+jJ/4ZK?=
 =?us-ascii?Q?rtBxrsrXbwfF5KUHp7rTvcyzEsPltz4DZPmEtHjpGDqxswyEdcxzD1jbYmlb?=
 =?us-ascii?Q?sX81liiRrAaFrAaMGobHzSWeJ1ErVwYjGMTpI+sIU+3I3w8aX45Ge+05mfvE?=
 =?us-ascii?Q?tkK7cIOZjNM8ptXEzj8tBqVL1uD4Vbt9yvnWz6dLOhH2VQq8Zjl2uBQm4ZwU?=
 =?us-ascii?Q?CigCCYycbrokklhI/5bMJ1+/fZZsbM2Es6T5flpovO4cMCUFU71ZkUc6ZH57?=
 =?us-ascii?Q?YL6kB4ggMOlRCCGkHGm8lkOIgylNsRedgNMwsT2N89BG7iwaIAAEIS4YHakV?=
 =?us-ascii?Q?TYGtwemnC5wFI7bPJEnjno09ac2D8rEa9GVh8nAMiNQXl49fpZsrNHyXHWDL?=
 =?us-ascii?Q?gHVZjh6E+i6Q1oJV3Yov3Y4Ja+ldddhB/W6XTWZW97EA32Kg0geKC8I3X4HN?=
 =?us-ascii?Q?BSIpQgM6YMQmOTqeMFHug+jsTN5IPE0OjXc2cGdrqf1HNucfwYo2iyoqq2NR?=
 =?us-ascii?Q?Grq88R5bVDvroVPobuOwfdM4nDmlZX/+saUHOolH/B+zgpwgm8mee9s3yLfq?=
 =?us-ascii?Q?u89P2/Uo7xfV0hbdN5VoKcuPSXr1jOlQ3y4XrlSpJJ7Vuo9IFiKLDKh3LyZ7?=
 =?us-ascii?Q?9UoHWd8gVa4C43Jm36NpkggSMhdNcD8AaYWSIP7UaT2lzFPMwQgK7MH/a4J7?=
 =?us-ascii?Q?I3EJpWpXAMJ2j2FnYUGnE6qdGjZvAS421E2W1is+h1AxwXdNKC+pTNkFgHdw?=
 =?us-ascii?Q?KVT42pU/CwSWKolQV64w4Cg4AKhuA+igQ4yEKQDQhp6LU+v3VVVskCcjUp5U?=
 =?us-ascii?Q?ahinP0UN/dx9edbjb6pUiWbDdOTgLXXN6ZMM3jGzS0E5VASJjQEFUfvEonul?=
 =?us-ascii?Q?B1cNOVZVJa8cTcyZ6r0qx89azrsywhed1d34n5yrzIZZwcgAq1HG2ErPgkn2?=
 =?us-ascii?Q?LbSJdQXEkW+LIZO8TSO0tUNTLoBi7FESsI2flcu/joGy/ScKJWrkK4UmjVai?=
 =?us-ascii?Q?Blw1vDxesPxb0Hx5h9Yuj9gH/Rha+GG0tqLJRhH2JgtcjhzNKfFCkH0TXg4k?=
 =?us-ascii?Q?4p4MSGsk3RKZT80PO1P3zMGt8bSpjoNL30+DX9fW62WxMbANPuuOWbFRYH/g?=
 =?us-ascii?Q?ce7j/ph7wUN6rnWwnD04x3R2GBQlarmdiYPig3QBhDcgp0lRrkOlETe3yARG?=
 =?us-ascii?Q?K6G9ZwH2k6Ol6NvUttpM+uv95jr30e0ZE7L2LmhIV9slY9R5QTlx01560FbJ?=
 =?us-ascii?Q?RIiXKwA82ONBmhoxz/Ew305gpoAa6Fj43RQDhkilYAYJEX8vwwGi2kXFnwfp?=
 =?us-ascii?Q?7zayJfLxkf/iXjvd6j5N4hGxdel6R1VaGcuNuoZt8IlRaihJuDiBfrlNw061?=
 =?us-ascii?Q?Et5wd0sCMpyb2Grl/xQ7ZQBL3TDIjM/oSd3stEG4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2b0da8-afe5-491c-909f-08dde95f85d8
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:57:43.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXhyIJLtxy0CoVwpeFT0XUZCEFPhqBhgY6T7cdw4pno424+flEvqY1ybal1SnKi/4yBz58eD5MhNXjtl2aGIvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5742

Change the 'ret' variable in ad5421_update_ctrl() from unsigned int to
int, as it needs to store either negative error codes or zero returned
by ad5421_write_unlocked().

Fixes: 5691b23489db ("staging:iio:dac: Add AD5421 driver")
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/iio/dac/ad5421.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 1462ee640b16..d9d7031c4432 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -186,7 +186,7 @@ static int ad5421_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	unsigned int clr)
 {
 	struct ad5421_state *st = iio_priv(indio_dev);
-	unsigned int ret;
+	int ret;
 
 	mutex_lock(&st->lock);
 
-- 
2.34.1


