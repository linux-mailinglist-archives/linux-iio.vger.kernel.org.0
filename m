Return-Path: <linux-iio+bounces-23088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE2FB2F0A6
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 10:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3727D5E6055
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 08:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3A32EA463;
	Thu, 21 Aug 2025 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aKslJv8Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012050.outbound.protection.outlook.com [40.107.75.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C126F443;
	Thu, 21 Aug 2025 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763711; cv=fail; b=EWIdK13uymW3Mk+oB106JJYjJNNLVATbwinmv/AQ8m2b5Jn/Meqx1RCP9/QIm3J3lIhDaydoVXd0kLySrZaUaKCOwEhjubzE+tpmBkjOJWUck3oYkk+5RefQAMAOVTmy2OY+nyIEQ532/XB3091HVYbHP0//roAd66VozCtOD10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763711; c=relaxed/simple;
	bh=nOHWoPyjgmymKSo3ybX/c/3grRmG8nVMLUb+Qfjh0/M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W8Q0t4i+SDp5Oh7FXnbj01/DgOde5wCQv2H9+D1h8StofK4VUF7CHxqxwpGnP8hJ4/WlUBej/3xLmk1360WJvYJG3/pF07ZmNWNjY7dn5Zq8xKuLVXdahpgsHPNQP2vqRfSs15S8MfuG/I05rXarpF/GVNTiZM9RVlxNFRRbXCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aKslJv8Y; arc=fail smtp.client-ip=40.107.75.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0bNfoudFPzcrZKu010uMNcASpUo2MpK9UkTxHW1wc0PTsqlR+5mV+fQpjn/bcBoPww77rwuENlfGRapIubFDw2ry+HvjY4h1O1/xh59XmaWT+vVwraWe7PDfSi2m2FUiqsLjnzVtgzeAVEBmLvuG/KxUzg/bgVWAkosYe02IPwT+/b4l1gklDmcCaCwRxxBthAx+9V52/y+tsqCe7GX4+ATPEomhrSIFs7TgpuxETFvsfMkvL4KpIaoBwS3TCkGaikduJENFERSY1cP+wdddOvu56KXJztMifAd4wSBtVqlFCds+99N0ZlOLGFHpozNjB4i1iuZwb48RxSxfjmqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILOpS/XHWKmiUMsEOMaAQ8aJs0yvL0f7K9Y94ZX5TW4=;
 b=EYaq+ZuQIiwg2oSBgwGxM8WrVLNuFCgtcJpZzlOIAh142Gnqn1ya/fnpp5IozBp6lXIGlcnBPH4AQjF8iuJwDCM89zLBLqTuBvSATVwNUkidjnZQNt3gmwWJ+p/1+oQDxHZqHCtghHVnK9WyZgFwbaIo/9ggYkH6aHuL2cu+M7KJwblfP8ldaYrQurPTbWffuazI20yPoiSM/xsSfxmGg8ksuirSGCEso5NYUTTxip2ULZ7z9hCA/bb06zBB0P/dgUmRULwDBt8lVWMMpYxRrv3MfuEK5VMhFD/+fOMJpUYFuZkbcFTSZYNA9A+OH9PeJbrfATxgYgvfiF6IFexHJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILOpS/XHWKmiUMsEOMaAQ8aJs0yvL0f7K9Y94ZX5TW4=;
 b=aKslJv8YC2XiaQY15dM2t90vbvsC1R9Wdur38wDvZzkXg67BPthaqk19E2k1/RGhJaB19a1nlGf94D28aqdqV/BzZODvhNKcCTS/+XrKMrcw3/A4jWJPwYHsFgS8hKLjg4BaesKX3/4dLGw7kLNJuDEJ1O3BRHZ7MihVlW0lNvheLxypoi7wZjf3NQPXy8aJbDrio0yYY5dWEJOjlN0r/zAsMvRS2R4WT3O1UacIsVzyY3zW54owUj7FBEbBQzQKFXk1JnzKMl/GtRPwRUDCK0Dts55oVREyTGPD8AsgH5fKv1n1X8xr95cqItaJlu6uqO4UkZPJ/xjfw6zXcoI9wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by PS1PPF8B633BB92.apcprd06.prod.outlook.com (2603:1096:308::25b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 21 Aug
 2025 08:08:24 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 08:08:24 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/7] iio: proximity: Remove dev_err_probe() if error is -ENOMEM
Date: Thu, 21 Aug 2025 16:06:50 +0800
Message-Id: <20250821080723.525379-7-zhao.xichao@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8c02d8d2-c521-4355-3006-08dde089e6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pvf+72q7MTHV/LMnM/D5S74TU0Tt4X8ZdehzLtmFISZ1KX87Ue1AipiFFQFF?=
 =?us-ascii?Q?WaHf1BDQSg9+0gVCKvA94DJjP3mSrqevMJa3FjNVNZVTmvkNssHZuhBaQFov?=
 =?us-ascii?Q?ZbCZZnvSWY0dDHDkhNpczmq7m9vcPzfKLx0xidAd4pjzqRirXwtx7vi0hlB7?=
 =?us-ascii?Q?CGjiw0lmClLn/Z8kz0+8vwoSjE8uj+zRCDSvUhNTdfbqEuLtQL9rpKLSelyX?=
 =?us-ascii?Q?eTKioa4G2UtZRwsIBHQxDsF9Vbm42fHi5FIAiwKhtn8P1VVQ5XVZz6kUrsHF?=
 =?us-ascii?Q?bPaJ1P0cSSfTU3WqPT0pQpI9B1E+RnKeOuCFkHRdUammQYD47/OjKYD3CBUa?=
 =?us-ascii?Q?MNRCaIZCdoTk1xZNW+VnuKE57VuZHNOpnubcHmrlD4HHMUYh0nkpwHak5Rmf?=
 =?us-ascii?Q?TmR9AFIIDNfSXIhrg+obmxyhrx5WYEus82KvIz9M77jf14FkTNbEKEkDzAvL?=
 =?us-ascii?Q?1JoD7JPad6VaKSXx/pGC5kKbUB3gYmjRLIpGDrpEB4BGKvOYSOzO1BOkusFg?=
 =?us-ascii?Q?Gw81IlDUjO1eQk04opGyoD4ExUCiln0LPiWe5XOO938Un5L4n5Zy+e/Tlq5q?=
 =?us-ascii?Q?pNEByHPgFErs1dU161O5Qo31+lsiA50M4EPW2LcbYNDStXNkYhwvsRMe2YSu?=
 =?us-ascii?Q?ksolB4H5rGFnccBU3e/9yYiF23syE2mabD2AA0TCWwMmZaV26skd0+QgVnre?=
 =?us-ascii?Q?gFDfxo80ubw2fxTz3+zHYcp9xih9P8Z7uXR+5SMbFaqRsCnEOXPqaBFMZxlI?=
 =?us-ascii?Q?Zvj6LjTHcvT3tz1xlnlWdQktRHCnhlPKCOBVnx6yfBqQHz/JU8u+Y1eRfH97?=
 =?us-ascii?Q?wXdeZGu6DVHoHXMhgcK5+5xZ+UUXHcKQjzsVqEYagOZ+giMZpU7bUDzLicnN?=
 =?us-ascii?Q?MgtBpcccYyXc+rpksT13xAUeVXdQJB61fLziwdDTu7vYLF6UtNXkJxome2M5?=
 =?us-ascii?Q?w8Llv4Nq7fMmesUNphIXixBUPXGD8meU9QcNsrw3b9uYRhh7pyUmn5TBYvro?=
 =?us-ascii?Q?qM3nUowKZkhOkvexPcMhcA3LKbbQ393+pClyBbFTPvTBOu/ynvVX8s5zT4Zi?=
 =?us-ascii?Q?FRL7qV3JVtpJ/iJcKy4Qqdx+5JHEntCfokgXAf2wF+K1+WM9qy4glXIOh7S8?=
 =?us-ascii?Q?Q6NB0/PhplfC308OMh/CY0EkdnkUBZnm+zgAU6SBzMamWgpllb6vJxKKRm5G?=
 =?us-ascii?Q?Gj+IF0if+NTsgwMSjaRvzZiV1xnDfd2pUDZNQOuJeIRdFYfZOIf7KKSbjcKb?=
 =?us-ascii?Q?OHWJNJOP//rs7c5wZl1iT49tQ2ciLfcvQfZ5OS5UiQ6FQEQKINDPKE1iQJbv?=
 =?us-ascii?Q?Cwu9Ie1pO3eJyL9N7VroQsBSlX7M8MjUgAxilFp/5hDDYgu20wVCSU0XHErp?=
 =?us-ascii?Q?tHC9MlC1RCsgxYt4lAZQ8QaIAAj4fvqz9Z+pB917EuDiAoDf0JVHv7Y3v8h3?=
 =?us-ascii?Q?WyPktNTlscmjT4hb92LSXN8EJyFqHELpqpTfcT08EVLn+IfZYqLusCunWhdC?=
 =?us-ascii?Q?8no9bDnG5BexIyk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0LtaxXsk8gLZ9UOYk+xGrl6PEnJ80gcKBBc061ZTBOGyDaDUD564/k5piylX?=
 =?us-ascii?Q?FY/OjJPO7AP0mbIUKoaz+ykupFHq5Sj3QqunrIHpVI47lPdabfardA3hodYw?=
 =?us-ascii?Q?oRWHtgkzKv5arO5vfYvPECbb4AmjBh8wOD5351T75/9FGzYDRoWtPMzE6ASj?=
 =?us-ascii?Q?gqYDC1MsV4zuzxiwELwhTMlRDw31zJyUtWEN81LA6/1GFZ4CsyQ5wARRMQ0R?=
 =?us-ascii?Q?jicBwTJy1DmpQDi8jpyWjke66ELIBcIeDSiBA4y8EZg4ujlXIG5T0lNw/a0q?=
 =?us-ascii?Q?Wv4KOW83YQ6CtAUWUPH6xkM6Z4okdOl/tfmunQ033ztDmxqi4UvjAMevCLws?=
 =?us-ascii?Q?vBCvj0xnQ512Y+UFxv20RDHauBQA5WPRbHX9mPNrvGmydNtYWudsRh3BVJDm?=
 =?us-ascii?Q?2loHa77q8gb5MILZhDQtQUZQILPC1Kci9f5iuMKFXvTvHRbPe7/DsbgWl6A8?=
 =?us-ascii?Q?W8CDhn7X+k3ei1c4zx1GP+ZGPmfK4sT9OE3SFQ0Sql/cZvRlC12jiJrMVcuX?=
 =?us-ascii?Q?sjKpiz59aClK4xqABFYRwv9dKmXI6Af56BkQD9TfpOaqMf/lU/5fzGovMFgJ?=
 =?us-ascii?Q?qwTXlkD5N33aU9Qt6zkVHmkih1DG2i5V9vacro3FqZuwCEB0BrDKV7z0Gb8h?=
 =?us-ascii?Q?5f+AMWMXV5h/gNkrdDUYbfq7+nJVW8MLj00TIhK6auFe8U421+cuSNZNkc3m?=
 =?us-ascii?Q?1WjGgfCNeUiYhxVGc8ItPXkrj37Fx8dy3JEZSd0jpJBbMYqq2K3/oLzcO1A/?=
 =?us-ascii?Q?DT5pn2PQrkT8H+RCDpLoT6nYBxuqMTZYNSUDK86TPDqyS69QDsgiYveaJt1E?=
 =?us-ascii?Q?hjWbzi8LZ+2aj6qN5gVU6+1rsJ4ahUAFvo5PhPXcy3tGAbCIzFvQELJZtsbl?=
 =?us-ascii?Q?UlejGyk7MqWOCK5O7aTGs5wS4xq4SepPOXQZfFMSK/iyfWJeET7fXkyyXPEp?=
 =?us-ascii?Q?iw5loSwh3FLJviPQzjFs9i8hRBsYenrdJpyGyiD5ESiFFfTqdEYytK5KTVZM?=
 =?us-ascii?Q?gJo9EvE2fmV/KMEKjdSHYT6FYrve1zRzYRPojWdJXJEFzl62UoDN7OA1ffgo?=
 =?us-ascii?Q?B2ZOcCOEUcmr8e2geVgtJ92IjkNDQI5NQzkVv+PToKO0TtKPOsh1ImDC7oiq?=
 =?us-ascii?Q?GRRcBQSGYmxAY7lnxLRqx+zc20oXDTLcghHQobir3l2AbVoYkD6O8k/BqnX5?=
 =?us-ascii?Q?8MeYUrHuq+iw70AtcwKJxPbumr3sXNMYEvJvvGcjD5eh0pK2OZpv0qZ61/Wk?=
 =?us-ascii?Q?QP9Spe/VXI5WviWZwr8+jpfjBQWmjabAs+Zrsye10xKwvHV4FfIK7x2RwQg7?=
 =?us-ascii?Q?EuAjaxFixbhNlNqFgHneT2SFXK7JtGEIFthwuvdryeiNFnJFRWJ8YA6FL4gx?=
 =?us-ascii?Q?HL7shNVcJJlmUGo4i3p6cLAeInjS7RPEsXbr+RdJBzG8gRgkYriDLLsYntt9?=
 =?us-ascii?Q?xx1qv5JGEwpGPd6SOe7ytodCT+JBNqm92d805rJPNMQ6uLvf2gevI2czKbt1?=
 =?us-ascii?Q?mOmNh81s6PQtEkGcWPPjT/o2Df+oOPcL6UjwREz2zPsFMMoETy1jaS4080vS?=
 =?us-ascii?Q?PScJpAZgPjAzUWYT7GbDcMjnUcyJJJezIUt+0sRq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c02d8d2-c521-4355-3006-08dde089e6a2
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:08:24.2445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHWVMK4KvthL9iETEb8q2UDuvt2gRjlcxQJtzShnVYtdhoK3BZ7+32gFaGDdVfKLbR2dVIK5htZVZwS0c0U+Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF8B633BB92

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/iio/proximity/d3323aa.c | 3 +--
 drivers/iio/proximity/hx9023s.c | 3 +--
 drivers/iio/proximity/irsd200.c | 6 ++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/d3323aa.c b/drivers/iio/proximity/d3323aa.c
index d4c3dbea9bb0..30821f583454 100644
--- a/drivers/iio/proximity/d3323aa.c
+++ b/drivers/iio/proximity/d3323aa.c
@@ -722,8 +722,7 @@ static int d3323aa_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
-		return dev_err_probe(dev, -ENOMEM,
-				     "Could not allocate iio device\n");
+		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
 	data->dev = dev;
diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 33781c314728..2918dfc0df54 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1141,8 +1141,7 @@ static int hx9023s_probe(struct i2c_client *client)
 						    indio_dev->name,
 						    iio_device_id(indio_dev));
 		if (!data->trig)
-			return dev_err_probe(dev, -ENOMEM,
-					     "iio trigger alloc failed\n");
+			return -ENOMEM;
 
 		data->trig->ops = &hx9023s_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index 253e4aef22fb..65af31d43453 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -862,8 +862,7 @@ static int irsd200_probe(struct i2c_client *client)
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
-		return dev_err_probe(&client->dev, -ENOMEM,
-				     "Could not allocate iio device\n");
+		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
 	data->dev = &client->dev;
@@ -916,8 +915,7 @@ static int irsd200_probe(struct i2c_client *client)
 	trigger = devm_iio_trigger_alloc(data->dev, "%s-dev%d", indio_dev->name,
 					 iio_device_id(indio_dev));
 	if (!trigger)
-		return dev_err_probe(data->dev, -ENOMEM,
-				     "Could not allocate iio trigger\n");
+		return -ENOMEM;
 
 	trigger->ops = &irsd200_trigger_ops;
 	iio_trigger_set_drvdata(trigger, data);
-- 
2.34.1


