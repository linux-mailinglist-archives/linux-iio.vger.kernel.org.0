Return-Path: <linux-iio+bounces-22645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC518B2436E
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 09:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA6588210F
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 07:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E692E9EAB;
	Wed, 13 Aug 2025 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XZMtCH69"
X-Original-To: linux-iio@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012056.outbound.protection.outlook.com [40.107.75.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BE82E92AC;
	Wed, 13 Aug 2025 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071774; cv=fail; b=AFItMbVJzapqeN5wpGN6SYsnVnsvK/q4SqqnutvS+qZxZDlSm7DFB8VI3rPXPFZ70DOE9lj8+FC85NfTNseRm3oSxIX3zhrqr4ZUtMUUzVxA0rwlAFutkRCmgM3N2ZlXsMaVFvlxtbzQuIzkBkCCeMadycq9SNmrAjP7ac0IfFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071774; c=relaxed/simple;
	bh=h9R3qNAHP29g3HcT9lJGbqP9iEFfSUJvMFStTWyM91c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aRIWVJ7DiIg44lYUiha5F92rRIfTiBEFPciiYv/ZlxqjBHxlbPOt5j89ZLdqq6cuZmx4PZyOWklCy4SYZVe0tasXAHkOnCri38XxymNPvRjVZbA2yPwAQLE3GnWxwutf7G1OAT1UwDI7OZGxKLsWWRIlrkJ/H+Iu7RWbxxy0RzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XZMtCH69; arc=fail smtp.client-ip=40.107.75.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqzrAqueIAjDSGYbvUCr/fKkbdtuu/kqVxomO3RItFAMNUdVQluc2drlSRRybslIqj/E35y43KlCLrQYoHL4plS3JR5FK1+73z6CLfRKkBF+LD5r0ID2UvOfugDznbRNMUhjwD5i7r0t6qNjEf2FVsG6aO3HG6qVybFEPGp5ITRQILZHvFXCCEvZoJ0qscSC1IdVSRpb7Uot6yE/n2+0bplWIrzfa8IQWGqKmMym/hD/G1HLbvRpVlPInXXNaqfI+Rw4yMxT1MukdS7AYY2iECB7RY0+rbbZWfXFY7VRtZzOiUSRhFfRHsGewz8+ijcjPQme9uVhdLiPHkWbGjaUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMQ0q4RjFe7Ym2MeaVWH+AqYCrPdurLbQIDCdiThtX4=;
 b=NgxxfRVISidCabNWTuDPyZO9+z+ZDpVGiUPx6Q2oxuZ8h+MPHvYwr+klklob+Iz9LwoGG7Hnndt5gDzRhAuZZE+p+Kf1OdjD04MbgtC/0T0B5THAnyfyoKn7DOSsPpkTiwBmPFUJSicNqMtk4ZlKYWK4nQjc5JlHvHGQWD3hMwsMmVIBTxnMHYnpY6VERllY5Gf4GBpSeLm9cXV4nFbqfAdURjHXVLkFW1ySqyQvHBaveuI1hYsGwQQT3+iCD8L8R87s0+1gmnwoOLzsI5Ar2+pfWAoeq4sjk6SBwuC79PU9B3GjBEBkAkjmZ7Altb9kSDewTYIIMgLOpgc9bqWuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMQ0q4RjFe7Ym2MeaVWH+AqYCrPdurLbQIDCdiThtX4=;
 b=XZMtCH69a2kCfX7U4wubJhakKcXCMqfBic3/wGMiqwPFAD14cLixsrpcRL8mv98kC6ieTgN0Qb36ebLN81/aQIzfbla2SgF9acoCY62gOk5sAr+i5izluBb1oRcS7b4nPpVlQHnyHTQfnneUtlLij8poxhHw3V9LWOtCTkCMz1oPR035SyICOKyeBT8AkYjyT10UrbqFQTQyZw66NebAPuQPV86HyNnCNF0IIDKtwY6mdUMF9QcGgdMVcx8UvE8FO6srs/p49hU/xYftbfX5XbJiSt0ViCt8lIJBXCfvgMt0mL1gqUxZx30haW614AeisV2WgTZoxtwT89kz6yczHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYSPR06MB7205.apcprd06.prod.outlook.com (2603:1096:405:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 07:56:08 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 07:56:08 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: o.rempel@pengutronix.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] iio: adc: ti-tsc2046: use us_to_ktime() where appropriate
Date: Wed, 13 Aug 2025 15:55:56 +0800
Message-Id: <20250813075556.466872-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYSPR06MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a253f1-8c1b-47e5-1523-08ddda3edccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ASfDP7DN6UIdGdsMje7QebektIYPbv8eM6r69J61xvWsX/3DnlKDLItHxGqz?=
 =?us-ascii?Q?3sWcJeHSgpLq8LAbIaz4wFhoJoNnooxI43Gy/8O6faeqwL5Gs4NVAeOCHe+B?=
 =?us-ascii?Q?WWtlKxqd4umibfbE+NIzBot7RB12Vpvfs+pzytTIvb7C5mqr5i45BWsG2D4z?=
 =?us-ascii?Q?9J4d8zNtJcPYYlyDhp1UH00pcNR34KwxrMkXhd6Kl6CqHCbOG0Zm/4Jsxnxd?=
 =?us-ascii?Q?Oo89JE7SuWPX58mCpCNI5ijHOngSFkLAx0q6MOYjgpgKVvX5g2FG1v5CLdZt?=
 =?us-ascii?Q?aJJELoqimOTv02KmSKXT+rh7QFGiQr2cerpQzPeMTborQnehFCT7cM6vFGZu?=
 =?us-ascii?Q?tRqhePFDquiaTPGzzorAtY1t1bKxi2j6R2P3BSvP3H4QAg9hcRsRzT4kRNE5?=
 =?us-ascii?Q?t2bC2USYS4azAtRna2j/bJinEOAMgdU5uY5zUDYu/1oLEXnBVibIt8urjhDh?=
 =?us-ascii?Q?1XaaUDxyukTUigq6bmHEGXe5ZdoYkRgqWN+svpE5Z6XjBmIolWKVRhbKxXFp?=
 =?us-ascii?Q?OPDnIvKH2czDWxuFHDBnLlJ+KCmLVUVV9paWa2P+BoOHGQX11nn6I6ZyAGO4?=
 =?us-ascii?Q?w3j3tNpZSH4Xwpz8dgg5bfISIqzDEGA4akxcrUEANn7na765Wy8zb1EhkSyc?=
 =?us-ascii?Q?W9LhZjhJDPYCXt4dYXVd/0mAtGtWw4/hy5/1woUUcWqU0NcGUWcPMI09rrwK?=
 =?us-ascii?Q?mJfHX915K1SidwFK/KkA547uGai4YdEYk1w1+ugpBgkAjt/W+5T0RYqLHPgP?=
 =?us-ascii?Q?iZJWxlY+m3ry/8YFX+Da4JHMPU678ts6fEWmsh11BHj45ANFVlfLbEXr2bSn?=
 =?us-ascii?Q?bVMJRB5hubIerSjhv2vTr0VIB6lGYOjr+t8FtENAS7LXJVJP8m5zz5VA8Q9T?=
 =?us-ascii?Q?1hNZ8vnVBwHNwv/9zXTW5sKH2V13tewXI6CA7OeGInuKChagX3NV2jojQJ7w?=
 =?us-ascii?Q?Ne1+tLQjqW2tt0D+mpXph9zzkWLtBPBm0mCxaEc46qwjLNJri9johAC6z47g?=
 =?us-ascii?Q?kAnwSvJ7Be/v0UefbJeDoAoZbtS8DSWmDakxNgwwdQxM1Sm2DiaZj3NKNJ3l?=
 =?us-ascii?Q?ML+AVylfECwGMgwgs4Jtztj7B+7wcHia9x+2FDv+ZiGXmQbizyYyL/qNUKeF?=
 =?us-ascii?Q?v79SysgYoHrjNj3/W6D8yQTS5oiXzZMKyhnr3CWC59s/ZrMf8n1YsID1dDkT?=
 =?us-ascii?Q?W9ZNJCzJbtnd3iukkvBhKVarJCfhE+LGZgeKVFEHqcEzA0xafP52KO3nJbi1?=
 =?us-ascii?Q?POkkJUCaeWHLRRjcksmLSAXUkdcvI73OJUR3UluUFHlIY2uDGPdwzt20R7bs?=
 =?us-ascii?Q?H3tlepYNNFPfDvoqhjwBUih9JyhfJ/V47K15pnY+RDPpVAkTT9OZ8lFENifI?=
 =?us-ascii?Q?d5HcKQn564haqdOGzt2bnGyv4gsfPKh2ke8/KeYTtNHI5HgoJyiYIwERyEYq?=
 =?us-ascii?Q?XOqWzPk2a+3ryeLCls+a5Hvl9jVk2Gg+hm8V0tZEJ08p0K4GRMgUfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XQ7MlhPPAgL+FEeeUk7gtEGVuwpTYBo9bD2u9qirBKYQyT2FAdibjvZ+7BKo?=
 =?us-ascii?Q?DUaIATXZsrAA+2pPa6afEXXOqxZUMpLVY2ZAa39c8k4GV3qvXNwVxvf7iUMn?=
 =?us-ascii?Q?swyrOWqN27tx1YJw4y9M9m1URIdO09G21pjBdHnuZTtGMZ3snPaavTr4dIhH?=
 =?us-ascii?Q?RC8HRSs0SNg28N53FpALas105TkGXOnKToLLjLqtaUYDkNmPJANKokJXlTGc?=
 =?us-ascii?Q?p/sGBudYwQO+Qr40kG78zjQWMtnjv/2qieswPuXk/0Emsf5ToG+AgE0m8Pxk?=
 =?us-ascii?Q?NG8dc9McZ4Pc1WMV2J/J7i5R2/iJcFf8Qx0OzJOIAux9BfaTVV1ojZJepnoA?=
 =?us-ascii?Q?LqBVJ9mpXjqHElXnVlI4bTam17lU776L5s2uCHCO0CuhSm0soVgNKj0uI/oD?=
 =?us-ascii?Q?5XMGWq18zLPTOcDSJhCd5YTR6PiUPSvnyvpCeYxUrcTa/ukHHecx3NB9L3E4?=
 =?us-ascii?Q?+TPq6hyiPjspWsoMk9UQnH6HCUph9AXwGa6cAM58bpTWjuV2jt/9eg5Ct2A5?=
 =?us-ascii?Q?vTwW+5FgjhUBogz7kRm+o1M3Nl6/O/BzGmGUzh9UfRnK/cM4t2vKgOYUezOt?=
 =?us-ascii?Q?IVhKMP+idQr7LLRf/q9zFzP1K444LJmkSlvVLAUzg2KIWBryNpTZHpxcRokX?=
 =?us-ascii?Q?1iZqNP3Qk9eB8OtIXWl0OdW4w/rqB+/aQ42J5T8XmcsKy8E/gcpHjjJBRmnN?=
 =?us-ascii?Q?Fon+Ix4PypWzH/PGaHE0K/gbn6AsRbcaMT62akNKSGloz6xZVpNhXVnWEcTd?=
 =?us-ascii?Q?gsDWq0ceEvNV2Z4xrBRt68uLl9Dy2j3N+ZsOhva0engCONVMZW1/PQFaQwnp?=
 =?us-ascii?Q?9GkuuGSd2QI1C9BToSv/njxhv0wLr6VaAj3pRyilCkQTLGwlCRBi+xGmeA1Y?=
 =?us-ascii?Q?LvmqXuoqN12RaRMiko5BsaoynadJrlL/cG0D+CUjGMtfFpyUh0d0n9xbhKZt?=
 =?us-ascii?Q?NH34ytBTa7bWOQiT4jFs2QImgEvs+cFuTmuPJ2wvlJeflK34jhGQgBn9rjb0?=
 =?us-ascii?Q?0tOLzGn+jXwWboI+GGW7dQz0ZO5bIomNXwcz2EKleRktDBvWisMzziYlzsPt?=
 =?us-ascii?Q?HYLHN1yL2ODBpLJ2psBKgX49hjxKe56703LQura8d6ujDNJ846+C1C3RudFc?=
 =?us-ascii?Q?UqYA9TBg2b2+Vqiu1rzzHLhtScHd8nFyYNjuET97freAiJkfQzbR4fEmHV03?=
 =?us-ascii?Q?kopmRVgLAkq8f26IXoxpe6eSMonFqeyzm7GpB4Lkn9MC22FrosRgIFFF0LWp?=
 =?us-ascii?Q?Fc1r8k5gjaP1hOVct/8f3X2AwSWVlx2NL/zic6AaPyOb24zZJv1CslwxNknv?=
 =?us-ascii?Q?mgAtvjXRNaxVkKMW9vZM+d+YULJ7uibmKIe3cK09eLscv26nUygU1cLiJmyo?=
 =?us-ascii?Q?svpb4AGEoTsU1aeS16dGeR4w6SdvJ2FCBFAxnN/r3R+ZyZNoYZe2il+iLvWa?=
 =?us-ascii?Q?ZM3baetzKFhRtZYlDx1nGpOkx390oJUFmoZvsPs6g4pvsF5Mz7c3l/AvdaGg?=
 =?us-ascii?Q?iNcy2sfx6VMvsyPIUvZK4xejXA8J+9Y3J9jGF6tdE2DRDFE3X1BeRjACWRyu?=
 =?us-ascii?Q?oRy6NiTiSkYg5/gAxcfp5oII2ooojeQl23QiOHbd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a253f1-8c1b-47e5-1523-08ddda3edccb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 07:56:08.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQDBV/PLk+tNlEWDLLxinN1wtDUc6nFFjR4fk5cx1cGfYzzI6NoLNVOv9ge256unDjR+rKgBYq9r8yjYbAZP6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7205

The scan_interval_us and time_per_scan_us are more suitable for 
using the us_to_ktime(). This can make the code more concise and
enhance readability. Therefore, replace ns_to_ktime() with us_to_ktime().

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/iio/adc/ti-tsc2046.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 74471f08662e..8eb717b11cff 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -535,8 +535,7 @@ static enum hrtimer_restart tsc2046_adc_timer(struct hrtimer *hrtimer)
 		if (priv->poll_cnt < TI_TSC2046_POLL_CNT) {
 			priv->poll_cnt++;
 			hrtimer_start(&priv->trig_timer,
-				      ns_to_ktime(priv->scan_interval_us *
-						  NSEC_PER_USEC),
+				      us_to_ktime(priv->scan_interval_us),
 				      HRTIMER_MODE_REL_SOFT);
 
 			if (priv->poll_cnt >= TI_TSC2046_MIN_POLL_CNT) {
@@ -605,8 +604,7 @@ static void tsc2046_adc_reenable_trigger(struct iio_trigger *trig)
 	 * many samples. Reduce the sample rate for default (touchscreen) use
 	 * case.
 	 */
-	tim = ns_to_ktime((priv->scan_interval_us - priv->time_per_scan_us) *
-			  NSEC_PER_USEC);
+	tim = us_to_ktime(priv->scan_interval_us - priv->time_per_scan_us);
 	hrtimer_start(&priv->trig_timer, tim, HRTIMER_MODE_REL_SOFT);
 }
 
-- 
2.34.1


