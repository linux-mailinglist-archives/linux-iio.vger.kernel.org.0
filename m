Return-Path: <linux-iio+bounces-23084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C56AB2F094
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 10:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B35A06A06
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 08:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6CD2EA154;
	Thu, 21 Aug 2025 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lu+ae9gY"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012019.outbound.protection.outlook.com [52.101.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C12E9ECA;
	Thu, 21 Aug 2025 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763678; cv=fail; b=YnT6qhzmVXc8h54Ye9r+KF920yj/VUpHsjyQki3MCW9dnYk6jgg/r2RK36wrgLRxN5Eff3iVpoHNY3dvwzpSgiRW9a9H+GTesJaP7k5awAP8qWBwIYLvrw27CMsW3b4nyKH5zB/0j4CV24dqbaPjjvT1PSkm49ncRWUKbP9TTdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763678; c=relaxed/simple;
	bh=d0Vp+wkLermpqFRGyiOpgLQ3UskCe8yGcYsYy7sPpeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dQWZXYRXynagB2JJ9UJBEwspRGwVde0QsCKLnNd2QwlceyaSjBDhbT/HDXCNRmybtIMtdq3WRpF8gH9p+nxfMUbG2BY7S+9W3+HjsO6crkakotnB4E6c0s/xkMkn6G3BTeOl3Y+kpS3G8KHQpfnLSQovy+WZlorOEbxBh669Ako=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lu+ae9gY; arc=fail smtp.client-ip=52.101.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkw7XGUdOdD67J9cGxNQBjycuKfuQ1mBWu6/54OWTyn1bLYj1BvWcyMc4eiNjed/AGLghc5pw8cNGzC1TqohfO1ReR5e5VT0wbvXXa7JcsQNF0yagV1v+8mUfxSE4f13zY74+gmKrgNVOnI0K1K5yG48H90a0f1kewETiklqUAkclP31qSXHDwfCcppTodFN02/nkXg+/WbkYWs0tXO474oxjGiQluT9LCs69FiJA1JnSrQlD55AoxP5WZ+JAWXSvNi63hzdXZSuCYl4dZ5H5Kdimoqg7kaBkO2lt7maxxJlzxQmn2thzQQYgvKiviTB+lgqgphC5B/C39xGycOzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPeu0HIjXzSXwd+LOkycFV4PB7bnX8w0e1QLN5HAG6A=;
 b=xWbEJ1bL/OKNjQEvRyM/kvR5sHmE7CnDYwef/WbMNDT+jTDWs5Qw+JAH80y7S/gFTSOaJECMLcyso5wvdcBbgzY8rAoQYKAfIvwys6hkwTuDf8eJ0x5oOwUE4ogG42frTtz0orjr2vdjshbzqMk2rG9y5yfxM84dpWApDp+VBKrkpbLqbSr3N3weKk8RzhiivqrO7QsarDD4C6ZIqOcJo7yTFMobXDY7CePAAglcCMvrnBPcbikbL9p2E3m6+y3qBBatha6Lc/vd64WRazCL+FgtWLQaWFF1Qj27X681h4BaYG+UaPB17yt4gDvJlowS7NJRtM5832l/2vAAh/g2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPeu0HIjXzSXwd+LOkycFV4PB7bnX8w0e1QLN5HAG6A=;
 b=lu+ae9gYEh0QYu/g+xlofT82bctuO8fHUsW80STc3GwqGdz35+SPfSbFzqm6IY0TjNqLYfFKh5VZXkwQGrUj0gHTar+P+UQXot2G4pw4Y03ZSfiU6fsbP9FZleF56R1N8JwpeFtPYVoRtftILGThOawicPwBbeXKkXRALMw9s4BTqwy+QQ9pdvhMRQs9+OjMsg37VawHsvnydT9X6cjaNrK2TUr7liB6IXTl2N/+Bo2BP6GZmiawTd2OW6Q/Cm50L0ndpQ2NM+uqw8ujb7iCVhZ4Q1F3Tx55VtNYp25YAVFjyXHJt0pdHR7+qPT2pds04oBeK0NCSJUhz+K/WzArow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB6488.apcprd06.prod.outlook.com (2603:1096:101:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 08:07:54 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 08:07:54 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Gustavo Silva <gustavograzs@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 3/7] iio: chemical: Remove dev_err_probe() if error is -ENOMEM
Date: Thu, 21 Aug 2025 16:06:47 +0800
Message-Id: <20250821080723.525379-4-zhao.xichao@vivo.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 963a5cca-f5df-4613-7238-08dde089d4b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rzG7hNGQgk4F8y0AyCmwpp+KSNX5z2XLAeBtiYc8J3U3tB9Jp8BEUX55VkrE?=
 =?us-ascii?Q?NL6VLwz+osZBCWtNs76R+z5wIWxGcsLsxUvz2UooQb1Y12LVDv7nc1/49kRW?=
 =?us-ascii?Q?R6c15pmlULS/2RM2tNxm31gBXKV6UB06oQ6ELxxNyJj5q3sqaa4W3FZi2+vb?=
 =?us-ascii?Q?jgwUO2ELfldK+CljJ3tMtJp5A9RFgFua7aNnnfmibd9Hf+yw6H2Rmpv0qoV+?=
 =?us-ascii?Q?ZuOiwIQ1LtvOdfhB3OxvQBpsd6hOqNg9dKiVap8tnIxpMG+WQ6n0x58OGnHj?=
 =?us-ascii?Q?kJtVXqQE4Cr6WgFuZDOnJMvyzWeALICD1V/epwCv8TLCfDrrq/BzZBJGXFDH?=
 =?us-ascii?Q?AgIPqEVsFUHI5bLTuoIRauMnb/pa95EaRChQLxHagU7/Qwu3GukDjluuMTSM?=
 =?us-ascii?Q?Z6NGewYa+oBpR2HoHA2ezud1Ao1FE//g+r5KuiSFvuGRZrOhFAEsVsUTlRvh?=
 =?us-ascii?Q?RPMFHfOn31zFjXM/2tGLSJBPPWjYXJDyHiVjDQPO7XqHtwbe+ZSck6x0W+ec?=
 =?us-ascii?Q?SEYpCVyClQ3rBzeNcYR3wtcubEJe0g5ICnNYLVrLzE3FbkZ/qjk8jp99UcVp?=
 =?us-ascii?Q?Kbizf4nFCqJo4HkcihfMdv3qtTJVNzLF43wTsiAj3Qy8mniMysQWx96rYRJI?=
 =?us-ascii?Q?ROc3KK5MbYMpzxhqQxK5NMlHVDw4ur/IUVEpXQZd6bvRYcMAKR8Mhp8ij0jY?=
 =?us-ascii?Q?qQLs1i0ENjuY+iCDaV9YGEQThB0ALF2UqgPWYv2bErWyFsQB39hFd9fRNvx+?=
 =?us-ascii?Q?yld74/ZYlIKmFDSdJ1jrgzmUxixdP+LK7HEb30tw09qP+FA6NEUIiH6QcuXB?=
 =?us-ascii?Q?3ddrlhtLkvsFIXLdcWwFvuYeg9Rpqz99pNMvkAN7/tYHbq4ywFr+kIAwwt6h?=
 =?us-ascii?Q?86Lrk3qIOCsFp/FSOlaE1r0T7EKc/lr/LJcsPfy8NRuE+R+TUUDIqYNe7uYD?=
 =?us-ascii?Q?1GLmxGBj2jbIdQLFPE78a9dYt4NcTY324/nkZD+HwNL7llQi53wiMYC3eUjG?=
 =?us-ascii?Q?UMb/UyAZsvcCWHBFTGcXQKy427NmOFRH3aPUz004VqrTwtYXascex0dYUvt/?=
 =?us-ascii?Q?POM4O4zkQ+AYifd2PlNMmBtBQjSRfDsD6D02LUBrCBirOMI4diLtdhrXnCOJ?=
 =?us-ascii?Q?kwVHzFHXItxR3q6mepjHHpiKAz0PRGENGIFrr8vXbPhqUz0K2ujNFBgICC1U?=
 =?us-ascii?Q?UMaeO7Tx/qvP7heLCuh0EYTMA9h/dNLd4n+8edwGTfRhYVGHdpoclBh891zt?=
 =?us-ascii?Q?IepOsPTCeohDN7u4YyOMkARhqnnKpHYj2ezXeK06phLh/IDpXHDA3BWcaJhO?=
 =?us-ascii?Q?rsVAeOP4GeZqYonTKNqqsaA0AFgHi6HR1TYya/rdl36VGlq8ntUvcvYnUn1B?=
 =?us-ascii?Q?22kuBSFoUKj9f5N8/DbXMI5mJHg2yym9xpzAKxZ6es2YeZC2kFueXARkVHtC?=
 =?us-ascii?Q?VfSq9ynWTUNyjezHYaoAHziF95RKvgQOeSjA/HfXRi7Qx/mEqhzDng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qT+lVYzqDW00+EMeMWjSEPgBIbN5G6BccvjuPDKFjh5EUwNevlwvYrdcAR0K?=
 =?us-ascii?Q?s9G4v1JMWDLrYToYGpBkibOI/sv3lqIHwQNN9o6LfiZHH/tIroiPILGR4AQz?=
 =?us-ascii?Q?PAkkAwJA+qXCoJhHVkM2JAbYedW3S7sR8T2k5C+/DPxvg36DZM0J4vshWs5H?=
 =?us-ascii?Q?D9JLN9y2PONLq8VwogtU/bapD2XEM+YKpioua/SH1uK96rhkFdWIngJ9dOyt?=
 =?us-ascii?Q?DDHSrUkAuOMMD79xk4DqlzIju3w/hxK3XVkAT6ZqhNjTyd+J48QCSUcsU9WV?=
 =?us-ascii?Q?U+7Lg4CYCg+CBX9z8POx6exYW+6LBqvqfFj0DzMy2M6ZAhZFzdmEbfLwkNp2?=
 =?us-ascii?Q?sDz4CuwtmdQPpM8gf99L/EkKh3JvTUNfV0J3LV7CkVgeXU2FjXzsU7r6Oqqk?=
 =?us-ascii?Q?ZpcCdQNvWoF2DCOaoK7i0FQnCe+tD7cuTXUchsamM9dTOMSN9G1iEEy5BvaM?=
 =?us-ascii?Q?0s3cOpDZqdrH/CFrZ2ulxOb/zEK8xm/7TYk4iKJTBSDzFeVN2G4Ma5xZ7KBW?=
 =?us-ascii?Q?YRCe55orCKPnJp5ZdTrxUTKaU4mSmQG11BAmirrEBASvdEEmiTyKbSudfhg4?=
 =?us-ascii?Q?qUtagOQdbWiC6BIW1AEpGaPX4iCv+swk9F5efaLxuK0Q+7N8f9gBifZ19eXe?=
 =?us-ascii?Q?waN65M+h+ZEcjkRTKxSA6DWOvMJrrGKnV89J49XXM82LUurQJsNi2IPbotJg?=
 =?us-ascii?Q?NMdohOe2XMi8pG/Xe78x+SEnUKlxL8n7957/jfkP3IqnHT3xtgIIsuVxRAv4?=
 =?us-ascii?Q?ZdKJC5qyAGb3OnBxsA8ruwrnuB1Q6MJlaGLmVwTT6YujqeNO3xxNhzihWBtR?=
 =?us-ascii?Q?RYIVMRNlc8xnEuVEdC71cLn7R1ClfiG3ZKnuCvXg3FBbBimQ1mj/OcxIffl2?=
 =?us-ascii?Q?r9dKn42mAJ4okK0vJ72l+FYK+C+LC9RkjQS4X2E1Pxe7WwPBd6QVibz+R7+0?=
 =?us-ascii?Q?aE7MIGRpU/NaSx5ljmLkDt+4VMdxYaPVvWNXrNPlA+3aydAbYucEyorVtg4S?=
 =?us-ascii?Q?TVMzJp9cxMYkKc2/SvNd8qL34o/7I+uvNMa1fThxEmAHGtYDE8z3gy4bPjTH?=
 =?us-ascii?Q?pTJTunT3WQoZ5xgZ1zN7eqALva2HR/N34Q4+74sgYvKbcOUYtWDTyl+nidDS?=
 =?us-ascii?Q?V1p1zHRkP/8jRuTVS25c8y1Q+HPtX7lInT07LsLYUlEcc7k70NwqhH7JIndx?=
 =?us-ascii?Q?vXqeiEvb0JQpROY4BXTbvleOd3o241JOmc8UG6tK/2JUI0expjcBckWbZd73?=
 =?us-ascii?Q?WSLKLvEZk1cHQEbHtevvCFVjEZrhZz5g2pqgp5hCt8KwCBaX/uRMexb6MXYo?=
 =?us-ascii?Q?O+YydYFpeIcCO2EgM5oERnNBfmRZXKYL+4KAPPymuxqKpAfwMlwzalZqzxIg?=
 =?us-ascii?Q?IoeYdWS7tVyBm9ZVZuSbIrofgOPhd0gcwSzTbwR1OnBbeF5tuj4ZExlkMcpJ?=
 =?us-ascii?Q?Pwxfeae94f0KMOvO8S2YifwOZ9DB+1/NgKLWRin8C+zZSTyJm3IKtBsPL+Vs?=
 =?us-ascii?Q?WSaT72SRus/QSTJ7PPyfneAFmNPJzIaZMcolNS7om0NZRXCa9aJKWRCY0IvY?=
 =?us-ascii?Q?U8oyo+xlihk4ExdTE3iI0TXR7x7o5b7iW3rJvv/P?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963a5cca-f5df-4613-7238-08dde089d4b8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:07:54.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Aq01NJjaY0VnDE4Wqc8d5O9eX7niN2upsPjq2CZtW18MBribDXOxbzNCfj7+j4MNdF5r+UEt2T+siRW1NNz0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6488

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/iio/chemical/ens160_core.c | 3 +--
 drivers/iio/chemical/scd30_core.c  | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index 6cec60074827..86bde4a91bf7 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -305,8 +305,7 @@ static int ens160_setup_trigger(struct iio_dev *indio_dev, int irq)
 	trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
 				      iio_device_id(indio_dev));
 	if (!trig)
-		return dev_err_probe(dev, -ENOMEM,
-				     "failed to allocate trigger\n");
+		return -ENOMEM;
 
 	trig->ops = &ens160_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 5df1926cd5d9..a665fcb78806 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -635,7 +635,7 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
 	trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
 				      iio_device_id(indio_dev));
 	if (!trig)
-		return dev_err_probe(dev, -ENOMEM, "failed to allocate trigger\n");
+		return -ENOMEM;
 
 	trig->ops = &scd30_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
-- 
2.34.1


