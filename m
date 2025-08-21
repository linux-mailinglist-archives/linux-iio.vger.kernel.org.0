Return-Path: <linux-iio+bounces-23089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD99B2F0A8
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 10:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC50600330
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 08:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA402EA73A;
	Thu, 21 Aug 2025 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hIFFNFcp"
X-Original-To: linux-iio@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012050.outbound.protection.outlook.com [40.107.75.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8DA2EA464;
	Thu, 21 Aug 2025 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763713; cv=fail; b=YtMIkT87pt8Yu3PUruJlO4B+HVDNGBUhvXmu+LQUMxJf5PkO3nRB+WjgEH8UVQjFsZwcCydAHQ48ZKpkZosZsJZFR2dteRZEWW/sLw+2q4SJ6eD+EKx7f5vujRITdr6pzMtUSp3gqBCKIZlMwtxpG6FYQf0ediPRLVbFZPMhopY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763713; c=relaxed/simple;
	bh=hKJc1NMPNvDJDLK13nOhOJMIuH2Fjbrl/2aQBNMff6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XCv+zJWLPHF6CUooheHHkV3axaJHwk9QW09EfOgdsVsUXU5+DTnIzIGGkulZSJHINbFG4jV+/LlS5LAM3IqGh5AIuD/cQnyorjtOc4y825ctrodCUh7oBAeJiWxtMRKx/sGxKIXE4huKc79P0M+nFEx6Q8Wr8z1Mu9Jqpv+A92I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hIFFNFcp; arc=fail smtp.client-ip=40.107.75.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRy8iih2Y5I39LvmRVyNCWEnbYLNUXvykLC7oIkfx4EA+0SwuA8/HWXUb3xYotcCxzSTRO8jpwre//mtis8ES/5h+OWXPXenMm7B+ZsBRXLpUriUZKDKoglyjZ1n0L2jRj2meS0lzlv+ni8y7MtWqldQAZOSI+jagESH3c7Z1XnEuSkBkHRkRy+6kcn40ZbGkf3TNN2tMas8XKWYdcVLrI9TVDTeBSHJgQbNI/M/zL3SwWrD+ops7TfLVf5c6gPbRF6F9G6Y95NzeqxDaithBZ6GNA8Nj6nkBdCrEm+F3RrmTnupU075VyhXPnWca79Mhp++h/d3Hjgf4IcmRU/C3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwoHHtqJSWPeUmB7dzhXKMb6OC2/qvpzZEmYjZrW/eY=;
 b=NdwFxYqI9hNuWekhYuBvVyuNTvijWFeQde+HSgC5gH+25QSB2okwnC7JDUvTeDkM/fCT1vsSay8ZHveRop9A+te3KkqTtK5oSUHwW5vQAgHNo7Z6DHvpShjapFx9tVe6ocn8wKgK5/z+vDLFWbZIEvyS/3dSVxD31Avq9HyRp9h6xxFZzxxF8RaySE5TKwxeNqE4uj/WoR2kfUAS9J3I45Hk5GJxrSiLX5ytSaOJVXI8deSK+BwqMKhdhlHndYNARWL6aNAIgkMgAmJNb27ni6F8Zz4eXqM1xNFyLNTxav3lsi/y1B5EryL56eGt3TzABztuknKP7biaL7UCA4xBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwoHHtqJSWPeUmB7dzhXKMb6OC2/qvpzZEmYjZrW/eY=;
 b=hIFFNFcp0ojolZ+6yTMyIQCSOe9r2ruyV6lffVq7WK27ddu6HU4Dlt+AXHnv2yaY45e6ejnxYa9ddLRfXtPj2Ulr6mMp4Cl3Y68u2UAFTRiqNRPD3nWbNqhMbnep9GMDp2j6sJVh10E3Tl0ESwE+QsOPVchkQ1eHmlfkzLfIE/gDgOuBABjn4y4lqOSnNLkODAS853uVB/KFV81aNTjoyi+OOMrXcQo5qoBQ3FMh6GN/nt8n8uaEIcW5JzVG9YFrCsKOGpl1XGj8IZEkCge12EVNpBi1CesvXulRnkbzITYJnxPI7OBg/TRSeaqFFqS0YJvk1EYl/LyYCscVZwbuJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by PS1PPF8B633BB92.apcprd06.prod.outlook.com (2603:1096:308::25b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 21 Aug
 2025 08:08:26 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 08:08:26 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Crt Mori <cmo@melexis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:MELEXIS MLX90635 DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 7/7] iio: temperature: mlx90635: Remove dev_err_probe() if error is -ENOMEM
Date: Thu, 21 Aug 2025 16:06:51 +0800
Message-Id: <20250821080723.525379-8-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821080723.525379-1-zhao.xichao@vivo.com>
References: <20250821080723.525379-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::9) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|PS1PPF8B633BB92:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e13888-7784-43a1-2afe-08dde089e7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S9KHxBWi5Bb9GACCkT67bl9m6PEqvwgFT55O298tHjaZL+zI0gpPPeDZIgU2?=
 =?us-ascii?Q?3yEp1PJGjzV8zMtfTWo9rLTWCLrjd+Zcg2j8v2usggyGEfAUNiLUDI5N4f3q?=
 =?us-ascii?Q?o8MatstSljOmMOzJ2r6uwXMaK6o/lA4vJJ0gxkH+zFjbd20f2NCupS80+/eV?=
 =?us-ascii?Q?0VFFtoF5RykhnEYyxxZSYnY78SRmSRXhylhRdm87giNO9GfCmcnJ/B+avSdd?=
 =?us-ascii?Q?2W+ptDn84lkcdzTWzeRiaq/lDFgvMaMRft8jRnxZRRHgBe3IcfwTa2cAlhi0?=
 =?us-ascii?Q?4Ka+3IF0G8bgmiVXLJuaxYth5yY640/JfVuHS9V2zDwXKCIYv8w8JpBq0oZR?=
 =?us-ascii?Q?qP7VQV5F3JHvhOB9b795JItGC6D9N9IqtTCUYm+yKU/CZ5o4YxaFWUjBIdbV?=
 =?us-ascii?Q?SRaB9TbK7QR39zr3r9O1CuVHComhYwDHoGDCDuP/y3f8nf94fLQkSpyXAIMA?=
 =?us-ascii?Q?EwKnRTungkhAY5+0TuDXwN5U5yvC6JxTHDXZFdnwFwCoQDA8yWzSP1zp89t4?=
 =?us-ascii?Q?zYxcF6sHxywMEbzrInsxEZ1rlgnpK4ufCqmWBBdv/JhSzwNrrDRhAA8eeOyb?=
 =?us-ascii?Q?Veu2YJ/YA31ZfiuIpfxYgESiMhm9iFhJKilj7lEvnlowJ+nTNihXVpkLRC0I?=
 =?us-ascii?Q?5Bpo3A8lIIzfo8/SkGOti1q/NlY+HODHprqvkx+MZAVJ0T9k1QEqTzv4u1dN?=
 =?us-ascii?Q?Whu1ubmLz+6G0Xp5M8+5mYUo/DvIVMRrvEFTzYd/NtInMlenM3K6DNlciil2?=
 =?us-ascii?Q?JPnFMttbExm7DJXJx0AeotwzfkldKFjfItffUhRAad+SxYpul59VnBlECFAl?=
 =?us-ascii?Q?ivqvxJETiwjQ3VauKYHnQbt4HYwmJXDlIr3ZRgisD/+fc05od9VYQfvw1+Tq?=
 =?us-ascii?Q?fQ88C7UxAE0iMPVaeS9JrdBaV4ktcJq6mc408qSR0egXL/UUxEgN5wGEarCz?=
 =?us-ascii?Q?ef0eg7zGAQF42IcT9tDPfRft5ybv0djoEZYEdyNg9Z4I0grgJn+j7N3LeBr5?=
 =?us-ascii?Q?J5zkf8nlkAEBzusNQtesl6BmryeFlxHuo5NW/G4yCS1dfBXQQmY517BfgLZM?=
 =?us-ascii?Q?qhgp/7GRhGRVLq3AgH1qa6gTGI5zgml7wpN35AZs49JKkO/44fkJn0fEN9iN?=
 =?us-ascii?Q?XgnwlaQ/7Y97FGNkszaG+BirkBDFcOtCplxk8V16zzp442LDHvz/LBkX9Kcg?=
 =?us-ascii?Q?dnHn7sEJmy99n7EJi79YTxfn1qwR2ayzvXHITCNBdYBUtqJd6+U9AK9BCoJZ?=
 =?us-ascii?Q?joMMsBAHYJvkSQ5+Iewf3rJKqgof3+z6Nyp4YRPVqxSDN/aLzL4RzCNOJudW?=
 =?us-ascii?Q?+I/Y6UWB6qSXsHbR0npS92FXa4w7mwV643Sci/Dxf8MjWtdWTHnhoM9b1l3/?=
 =?us-ascii?Q?c2wxNZqiKB7P/C3Qctr6oSBBlJ58Pdl/3SdHUns5Sqt1joIM3dCAh27JKtlC?=
 =?us-ascii?Q?DKmd+gKFRxT2buH6UoaNbrLtMNDMQzH/KM13LT3B/WmsnzFoAL8J+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F7EivGgxz6UylUN0OMpKo+P5i33fEeLczku2GoEFFroia6JxSCQcr6zMgeJd?=
 =?us-ascii?Q?n4KzRod91gMvqd+ksp3MXpKUfl1XvnB/SNZY8ul3n9BBxDlKlLA4tHJVUgnG?=
 =?us-ascii?Q?WXsBde2WFRRGvqHOkq2sbBEhVedLLGmBKaAAllFMv8CHmxm8N4LUPb07jmCH?=
 =?us-ascii?Q?muFj4EeIECgdJZDd/JBFHaSbe2SnAiFgMQWEwPnekyHwrnqS3XKF0w2H4tGU?=
 =?us-ascii?Q?PyPOT48/iaq3UY1QjqETXeBlmw9rDrOKxxw/AmRWOYMZszvpLzF8Gq52Wg3k?=
 =?us-ascii?Q?E/8xq9mZh9E0LiasPuHmJa5fmZrgsTnFYNHHQn9pyEwUMVtTOFJm5XpRvJEf?=
 =?us-ascii?Q?3gbDRLJ60VXFWYWYLm7jy19Kv/l74/zyytWk6XRz+hkszLS3M3FhRdHFjmht?=
 =?us-ascii?Q?NI9tFa01OoNaGWuMmwz3EVDphuIudMl6EfsnUXSl3fNSFp1QhmLxS9KaEX2w?=
 =?us-ascii?Q?pSomIvAX067y7jOh1Yyi/7u7jkWAbhf+IVgNrUKDZ8BBLo0Xm6mO39ld9VTY?=
 =?us-ascii?Q?8+dpDfyds6c/hr2bWTqfFkwNxhj+7EdVPvgQ82fJYRmx23HsBCyYhCnnAvVv?=
 =?us-ascii?Q?77h6IIEbfal4Jsk5sS4r3X/mDNiIRenNXNk+/lJ9RwXN63jqJC96Vy9o+lPi?=
 =?us-ascii?Q?SzpWV6PH3wlwL9htIkJ+XBQ0nxbxUH8HIcOn9WnaaX0jW9kovlXOOUIKx8ff?=
 =?us-ascii?Q?FI6YarJXq+c6Q0snLwdEwDz/vV+GWCgU+lUTWAVYB4t+wq38kOi6P+MTHJ+T?=
 =?us-ascii?Q?FDPTf3ApBBmXkMZ2wMgVr8qWgCJlzfacQZhSPYK7QP7mCxEQ+t+Au0wtdZYF?=
 =?us-ascii?Q?5gOz8T3nYqN3y+expknBYnI/UOsbT8K5zZsoanga0a87c8qDaoK8LC1c60/X?=
 =?us-ascii?Q?VJqv9Mn4EApecQaV4P/XabRY+xX4VQ9FLoTaa5qmoo647HPgRZ3cNyamvObw?=
 =?us-ascii?Q?AJxws7JS+KkPBy90aGvUKA6rdY9xVvO6vxsdbRgseXN29koRA4AlOMxK1nEb?=
 =?us-ascii?Q?qvetrDHv0RX9dcgPzP+j0hWp/uOyW7r15VbkNl5cQDLFyIUKNsea3sGReAl/?=
 =?us-ascii?Q?kYWCjJXVvR0lGwLsXYP0rspO84NUyMe6/wWVAblq61gferCNRAqeb6cgzg+a?=
 =?us-ascii?Q?k0Q14GU9IE08PiEQrHgTMuBHNu94Iopj9BEPQPODA00V3WkUK0YW4S8NrhTj?=
 =?us-ascii?Q?bjSkurwi/NcUBl3nwsy1i68tNRD3vpeHGo71d/X6L99Et4wzkvQhj48z3rxf?=
 =?us-ascii?Q?yflko8Oe8YMGZmpM9VbIQ29dFCg2VRsfPugFtRuVOF9apY0fgsfiOPd824bz?=
 =?us-ascii?Q?YQJLq3nYonBKKu2I0N5w1bU3rZ8Y4CJnuS88nsPkFd7Irq2lxG8KOqbX6kao?=
 =?us-ascii?Q?wn8jzn4XyJkhRBMRXuRAunMg/mSWt/HLckKBgJTMz/3JgwjV70sDjOlstmWG?=
 =?us-ascii?Q?jrL2lYzKNtduZC2axxH7LPDSieW6gIwsNo3cn/p4JvIrS9+DVX1D41vDa5Wd?=
 =?us-ascii?Q?8XBmIVcltQ/I7ejll9YgMCi+Snkrk1uOKo5e7jeXc5f/Rsg3aM1q7Ttv3cd4?=
 =?us-ascii?Q?7TQkisSvfJeswo5aP89tPb7LHB+GNjQI43YY8Jsv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e13888-7784-43a1-2afe-08dde089e7bd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:08:26.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kFrAwiWpsxDse9E4T50Crl9ZnO1fGMGbZ6CHUtk3UIt4y79dog/nwBD4gUT0xu8m1MPEH3rUXAJIcGQFYMMbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF8B633BB92

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/iio/temperature/mlx90635.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
index f7f88498ba0e..6d386d887855 100644
--- a/drivers/iio/temperature/mlx90635.c
+++ b/drivers/iio/temperature/mlx90635.c
@@ -939,7 +939,7 @@ static int mlx90635_probe(struct i2c_client *client)
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mlx90635));
 	if (!indio_dev)
-		return dev_err_probe(&client->dev, -ENOMEM, "failed to allocate device\n");
+		return -ENOMEM;
 
 	regmap = devm_regmap_init_i2c(client, &mlx90635_regmap);
 	if (IS_ERR(regmap))
-- 
2.34.1


