Return-Path: <linux-iio+bounces-23087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0351B2F09F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 10:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D00AA1D0C
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790862EA15B;
	Thu, 21 Aug 2025 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TZKOjngk"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013051.outbound.protection.outlook.com [52.101.127.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03D2E8E12;
	Thu, 21 Aug 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763693; cv=fail; b=Ox9DaKX+SGRRUxXPbYjGS2pDY0a/6bvxbpUuFG3RV8sJOqo1Y6wfhmFG5toViM2qmZzCuLHzCSXYrmcAKZBh4Rn1RTIXOthXK1tLCBlx26LvUPsz4K9m2K76N6u80nKbmeVs7F0Wtlnfou09cIOPixgpXRXbavGrXowPys2U6T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763693; c=relaxed/simple;
	bh=+n2ylkXnb/PALJXfhOjH1hrPKZFEBYzBFYVOO6d6EXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZPsMD5lnlyIbukqLpaMaSsmfo9HNW3MEa0V5bdo1FEU9HgdU3spjuQVpv6qdBU7NyJiu4u/A0KxbH5gI0qIpEWIE6G1IxH7vGL/VR/lPsEGOA8nUORJLMzgREWotZgmCyqYr5nwpZBWEQvyfdwVkacaTCBBKudrnzm33nCzHfk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TZKOjngk; arc=fail smtp.client-ip=52.101.127.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDnXU6rC54Jn7RF1Zte5G12AvFW288l2Wp1BdjFa3f7XwXy0vP0RTYlK9XeSVmj2gg33mYdH83wgtHgddi43VQJwJ52g632EJyLz0fV1cLqjAJpLa+ugtjWUW3PMHSkY40J3CRN0MH5e5oxX/Qeum1weFtUMYDkyc1na0GTdiBC6dN6AZaeicigIZLz5TbctGQ6QyKj8k2GxFHC6rOYLJegExkKcpdaXNsUxCvXIqpI5UwpQymPoIaJ/nuBXJDzYFL1aRyEnhMpJfU5T0G06owxxj7OKhXiUtQZaOs2cElDAopBNTf/azsDRXV5COWy/WnvrbcP0HKFuAopiUChdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4XZ9p9uCtj6xAwAdFNj4cIdWTmz5HNx7FhXnbvHZ0c=;
 b=NqnrnqVVuC+rSXNyXv9qeOMT7IiC8QXQCug8YiMHO0ViqGl4WGqIJU3yBo/hj/JIiOVkpmRkOq3aarUGMnuWinObey0rD8ze7Qbia3qJQeDyyUHXTbgQ7kyT/VbENwetrtm0Ili2eO9HAFBrzHDJrhNG/2E5lf91ql1Ix03QNoLpaFHGjq1dxBDBHQ7ABmy6UsFHAslUwG5E0+DzbjpdLdnZiurqkatb53vGEfBLcHSVY03zgrIcnD1YiGTBALrJYDsjly+JVVsD789hckiuXwsZo+VT/OfcwfslHncVsyLip+AAdZ8mmDA/KN9d45TeyNAWCGYloGiTONgCE86QaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4XZ9p9uCtj6xAwAdFNj4cIdWTmz5HNx7FhXnbvHZ0c=;
 b=TZKOjngkiqnsEU7OuI753KsddWU3ctFdoPbv0HXiq5c/dGCDVgDcKZWrctOZwFNy1dkJ22gS6iLhD/SI4MJseU997FXRvW8O1hIKTmUSvh/gLLYK6ATHttKspVzSD0UI+0AippHoTs1LPf3DCQUEdZ2ygmArDdkyMh/f1mOc2jEV4Zu9eF9FgOtWO9ijX9ucd8CUuyTz0EKy40dJPbIjsc4FZgP1flWSwm9C7EZJSjYWL64cM85JVq979ZopB7rvYxvZ+5EAW1Z6YNEWPbrTXaCXcy8G0RQrEkdcntcIf5pqlFR6UI+af12SCrwChofDcSgZDq+60faIUqw2rM/71g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB6488.apcprd06.prod.outlook.com (2603:1096:101:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 08:08:09 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 08:08:09 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 5/7] iio: light: Remove dev_err_probe() if error is -ENOMEM
Date: Thu, 21 Aug 2025 16:06:49 +0800
Message-Id: <20250821080723.525379-6-zhao.xichao@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ad6cabdc-c501-44ed-6296-08dde089ddbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7FNhtnocMMHyVpswXi0E7vzLmjexylZm63FvyENB0n+rR8+zyB+FJ6E8QyQY?=
 =?us-ascii?Q?b3A76KzJeHoQZnGeivLmOFdnXz2Z+aeB9+w+MxTKiXgGbq+X3FkPUURjKvfB?=
 =?us-ascii?Q?SsrIEjrSI5WqJp32n/H1vGZyp+HdwBLjbM4JgxBkczdwq95+wQNbdUHAz66h?=
 =?us-ascii?Q?3Ijq8sUKn2PlhiPwXwrLSBgFvh1rZXQlpPcYNUMwOJxb3ejUBiY9z4WbJR8h?=
 =?us-ascii?Q?m/NmBnI1kFwrYXOXGcsiagPbM9gqfewywjAF2MwSqrmywXWEkXtCv07GAopk?=
 =?us-ascii?Q?ey2TkXyaldoD16+7ZGaioWGLdyYMkluDZQslXnyyZsy9PN5GH3JLS2VDaLbu?=
 =?us-ascii?Q?OOFR15+NehjX+2+9Y796BlclrhOxSlsTgCmP35VFw7CT1JhNwahLkUaF+pxE?=
 =?us-ascii?Q?itd/1wyP9yZE/bTlgs4DXGF1SspjaevJ9Lh9mxbjq/MRtsnxCOgSlsaYmxtn?=
 =?us-ascii?Q?SL0TGvzBDTVmOGMbK8s1B25OWV3RvAG4dPmjsrqtCuuQG+oaD5pJilmYijxx?=
 =?us-ascii?Q?yIaUpfXMVHHw1cDwtwFz6wDkV9uTvAt3bE59ni10m7Q+NicRZOgwyNGMsODZ?=
 =?us-ascii?Q?es5LTbQQk0YPEnfIEjZFlNs3IkFqz+MLFB9vdSyL40eLOSj1wyPpnk8ctEHr?=
 =?us-ascii?Q?U0Gh4hF4uIb1usiFF9aeVFAAJq8B7UR9n2WEhUqNTLwbbAla0dx9+z1/1twt?=
 =?us-ascii?Q?mmkTmLRJpV9McXeK7mVhiv2C/11GV9k2vWN/BaizE3L6sSFumR6w1AEnpcLc?=
 =?us-ascii?Q?i4AOSEHQ5wAzK7PdkT8kcN0wHhYHqAanuOUWEVNZJ4kcO3crDKWPT/NTSK5z?=
 =?us-ascii?Q?5708C5ruwtIn7zfTwRA3GA7fKDkjbB6pl4kFB4p6OtXOmMcIoNQRR88SvJR7?=
 =?us-ascii?Q?MLweVZAcg3zsdAEQEzQsQe4PVbhofYskPAisFa5kDWH3AD8TsMF5PKwum6tB?=
 =?us-ascii?Q?82+r7z2U3uLDOT1FGVkQnAboogwG20O19fECr7ex+pfhhdAVJnawValS8r4y?=
 =?us-ascii?Q?LWsYDfKTxuALnEfxgvu+ObRbJjt7C3SoBtiqtZ7ZMpT+85jMgkO73kG5J8X5?=
 =?us-ascii?Q?dakyc6QqZVvb45TInJU7q6l7DMElsEmsMgifD9OxoirkT/4hgDc3KnvS1QjM?=
 =?us-ascii?Q?3xwm3XOd1iQgTnl6c+ba7U/Maba2fnpIDK1G+fFvBqg+sccqLTbUbx1IgU7L?=
 =?us-ascii?Q?KZXjBhFW6uaSZmIjtnERt7SiIKOs/U9pdcEJcCvAAkQh6r1ch07WT1RSbbxg?=
 =?us-ascii?Q?3XHMtagAKhWY8S8hKLTrO8eNYPPsziGw7MjRZ0nQ19SdLcQNGaD/bA3XmZqC?=
 =?us-ascii?Q?96isZZiGOrWNCFNsjEHtK0i2Q4qUdSTLdBwyJXoon6QXGumvKKvyQkwi7whV?=
 =?us-ascii?Q?SfgEJ+nPu/bOqp4m2S5mvPOmtrIYCbiUNP4r88hBjkSjdFE48qU6VP8pT01v?=
 =?us-ascii?Q?tjHO2KTGfXe5abAZgu1KVo4IchRZQ6FD43/nIJVDTKGkC8FtppWaUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lcWa3LcsAzuFWpF2u5de4xus3zuo73r1vKLJilcyeduX7Y3rHjYPMFUs2N6n?=
 =?us-ascii?Q?qvwJaENEMDNaCW3aC3c2/TxUFtbib4Zv7nxchoK6kYG300+I0bxPrmebZBBT?=
 =?us-ascii?Q?xj7Ob9uYhPud6OotMVinqu+kNbQn5IAFAAM9OEdqoC4TeefrZRtCD4XzAKEl?=
 =?us-ascii?Q?KduUeWk9p/BRTYl5E7BStBCPO9glJs/ZrTERRyIGrsQN2HJuWRjl6YgI/0Nc?=
 =?us-ascii?Q?hPzLlKh5ioNm31pBhcNL8cbkF32WHf8DMbHiDfNF6Bg8K+TZGNHIJrP3Monw?=
 =?us-ascii?Q?gTRZA/3bAYD+9GVenLV9+qH14xZ8vBzuNBJ0+B8sX6yPIuflpcVoOg3YD7sK?=
 =?us-ascii?Q?KMcKE1guzHKdvA90PyGA54NSJ9aI3MfyZfVHMBYZDLuGFXL8jI8ayrO8nqFE?=
 =?us-ascii?Q?BRLgqi0RXlllkKbAnFqjEtAeI0aCJBVzJvJIIVD/bBXX4asCbzii6kQdH1Vg?=
 =?us-ascii?Q?NF8IrIypm2kFKRvLAYdi+Qfx6mHxsN90C56SuR39b7r/9MdM4Wk1+GDWFW6S?=
 =?us-ascii?Q?7vIeuf4217krTsH3lQCR1RxbMb9O7ZRffUS6W5aheBaQEwfR9QREtZmC1ILA?=
 =?us-ascii?Q?BM6Tlp9lSNpGDPUKQlo2PXLScwYGJpaq+s4Nr/wVUUC88g6T9/wei6nQffvB?=
 =?us-ascii?Q?IcXopT4UmMvxSUY5p2v3PX689mpJ08JJy5VXoCewqJWrUxgDThjyvw1+8MLA?=
 =?us-ascii?Q?VR7dzc5zIR8IoQEDFlATz405oHmb4gT8pltTmoP+0dp5OUqWnYPlD1qsUTPj?=
 =?us-ascii?Q?hWq28WIPVFW+SRj77wGVBGrZYXXOuUcZZALx6jwE0YtMbPQ/j/KIMoztjWOY?=
 =?us-ascii?Q?c3IhlaMD73LtO0ssoIecH1BaXKNcMs13RHUdhNZqYx4FPDn7Ky1zJZfLDlar?=
 =?us-ascii?Q?jQQPyc5TEycRTS/BLaZHbJTfETGkZGJVbuJtupFQEUM4RBsCRfueLgA7JJiD?=
 =?us-ascii?Q?0qrfneJR9WS4c5yi08OBDrKIbAZOuuRbgpdWmIgWk2B3df/cO6xXL1toyPTn?=
 =?us-ascii?Q?hk9pkLqneA/G8+IDFWKs2Q8wVnmb14IHU9seMzZ7iVe6ee9Kugob/916QwmN?=
 =?us-ascii?Q?EuybQX+/PJX5O7jRLTWnjtCa2ifCMzNDzcCU8HlSTZArGOs+XgQsggwfhDFm?=
 =?us-ascii?Q?8DJd0HUD4DSvJ5eh6etff00qCGGFds1P9IybsZzoKWZ602YCzyIS2p5GZcD5?=
 =?us-ascii?Q?wLUvdc5NK/8z6OItEJyCYstiHRvVhP3Y/NygS7CjSI5J7xMBzYuPyh4pBqeX?=
 =?us-ascii?Q?NXHCjJ2E+RGCgssslu6onYNHxTxdV+gTUQsL3gQiUTO1fYZbuCJQ/PBPjSgx?=
 =?us-ascii?Q?ESKRnCOu1Oko5do08wxAnz6DVfmM0rY1caBPezscqbFDIEKx1uKuwCu0xEC8?=
 =?us-ascii?Q?ekirwc0p0568JZ7g+qJVVNVQAGiBUHU/v+40IhFfViKdknh31hF1xxWyBDP3?=
 =?us-ascii?Q?OU32eVMlBvO8IGkyL5RDHnrLDfPTDY5TEqGDYUu29uaA4c/Oqjf8f1O3obAZ?=
 =?us-ascii?Q?zjF0l3qSZ2MIqwbt76q4kjHaTzo1sq+h4xf9xtcOARhloPLTdb+zo3nNipKM?=
 =?us-ascii?Q?HR3b2jITnj3MS5thBRXRiUpvSPg8Ss1FyFRck28N?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6cabdc-c501-44ed-6296-08dde089ddbd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:08:09.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WcpupbPdjOookKtVXDQnDRSMoEF1r6JpoSyVAxWN9peqZsx3DJuW3Lc2gnx8z71GTd4/C2kLtHihLATQCCCeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6488

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/iio/light/opt4060.c  | 2 +-
 drivers/iio/light/veml6040.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index 566f1bb8fe2a..e96687700c91 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -1212,7 +1212,7 @@ static int opt4060_setup_trigger(struct opt4060_chip *chip, struct iio_dev *idev
 	name = devm_kasprintf(chip->dev, GFP_KERNEL, "%s-opt4060",
 			      dev_name(chip->dev));
 	if (!name)
-		return dev_err_probe(chip->dev, -ENOMEM, "Failed to alloc chip name\n");
+		return -ENOMEM;
 
 	ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL, opt4060_irq_thread,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
diff --git a/drivers/iio/light/veml6040.c b/drivers/iio/light/veml6040.c
index 71a594b2ec85..f563f9f0ee67 100644
--- a/drivers/iio/light/veml6040.c
+++ b/drivers/iio/light/veml6040.c
@@ -219,8 +219,7 @@ static int veml6040_probe(struct i2c_client *client)
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
-		return dev_err_probe(dev, -ENOMEM,
-				     "IIO device allocation failed\n");
+		return -ENOMEM;
 
 	regmap = devm_regmap_init_i2c(client, &veml6040_regmap_config);
 	if (IS_ERR(regmap))
-- 
2.34.1


