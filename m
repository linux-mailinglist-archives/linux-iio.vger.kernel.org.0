Return-Path: <linux-iio+bounces-22956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18089B2B202
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 22:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BD94E2941
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473BD20110B;
	Mon, 18 Aug 2025 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DAk7kDl8"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72BF510;
	Mon, 18 Aug 2025 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547235; cv=fail; b=ZbETf7ijBFtf52dMdDj0D24bwzjjMcxy//uifiiPNSSAvg2D0Ks243zv184Mnef/dXexhU8bfFfIk2OYiXhnDrD7l5+6RcA4eZxlE0jzWy1jPBv30XCM58KUvcvNRAW5WnPdHJQe3IXtleKHBFKnSB/KZIsRPwF2CSq1XpPdnRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547235; c=relaxed/simple;
	bh=lHNO2h+E6sM4OsEdeemMy/UslKyxg2MMcnuSgLLvqts=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nRDR2P8YH6gnPe6N4iSdrpjL1teGaRHy023K6mH0HgcFuD40xrmaienRtTYbXZMD6/4i2F+tJkX24OzkTLzjYZcwa9UFShaYOPcECvYM1Pr18wOhU0HJBshfzXiIm2q9nMSWQs6fVIBHwP3wrf15IexEFeoG0xedqEn8ahnblVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DAk7kDl8; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaHCNDCHZktqbCf2ElHHhYEDerz98URr6APQw5De3msFM+oedpIROb9RKMgLhf+CpRv0LTZuODf+avZR5evUsGySS0xDai0m74iSUkKJjdZ8juReJIBxUENCQpP7JP+L5JVl4BNLKZ2PlbiXIhAf881mZC6SQjfqbX46mBwrDLyOI9DJxBh/6Vj1M/iOHDIOOyeIDjJ8gWFjB19EvMm+EweBlcIpNmsyWVZtGqvUuhNVXvRvfXLeT4ftaiNIlTimcGGU6Ek+WEc3dEAsoiRlKmUL0nkZSBsyWm5QXkWp4t77LQlIGFWCtmUKpsjlO3MaR3oYGhkJ8prFtjBqJ03BEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8VEL7xUUigzgW+6tU7BL/RlrEdBP29pMT2NduFfLNs=;
 b=fPYIo9RKjSbcVimNP4UOhLRyGdc2tJEr53FNt9YRxxIk2PBosGCBxmVvow2yrPXnnp1OTccoeyEX9CZ5Pj9XOoNzyo60tPsalaeEVUU26kII1tI52qS6WbsNnkxFqNzm/Llon2EAsnVqTfXO/D1s9/oXMnzhtoG5LuYiCu6CrD87N+V7avCwGg882P+NrpK+Y/LfQoyWhvWR2XKnn4Y2B8k3zcsiy2uuU+V5ZaYNu58L7r6JXE090R5MrtSGwojNPh3cljFKvHON/YyByBIPvi8/mOtusH/UYXrbq5n0rB1mXFbOYn9aL/looC4YzQj9yVa2LMDdhnv2jqqVYyvsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8VEL7xUUigzgW+6tU7BL/RlrEdBP29pMT2NduFfLNs=;
 b=DAk7kDl88raHzv8WI2/4mobi781PDbT4l3xwsl7U6p1FSngpQlsURDK1T8E5UJTkPUTfgEIpcmrDi8RQuRvv4kvprxBh7TRk53TfnP5Hh7fYIXKcsXvQsF7EAUhLiyo4QCbmwJ6v3X8AtF2l0/NlSJobkEZmRZTpFbmMlN6Ep7bU23sc21YLzWbZ1WKboehPfaSSFGdSv3QslIhDIRKR+RowCQIvaTqKlcTS9ZDMC6YEzR9QM2Pic7S+41epMDdElppZNvXkMqK7u+BQ7dloIATerYPaXgCbW8W9mwtN8wLitkpO5eHsRObj7Hj8nkugp5z4RrPqpZdsAWN/Yrg3Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:00:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:00:29 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: iio: adc: max1238: Add #io-channel-cells property
Date: Mon, 18 Aug 2025 16:00:13 -0400
Message-Id: <20250818200014.3700738-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF000132E5.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: f4070af2-f484-45fe-503f-08ddde91e163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8iN9wvWvUKab9y+zM0pFE6ggoMbe1SgYrGbNKZzQu71IcGP4t2Gldlh/Fscu?=
 =?us-ascii?Q?BMTl3P3PCnZEjxAREPfKVBjRTr8y+Gl2+OsXZ78odYHSAvFjGI+o88nuwYgj?=
 =?us-ascii?Q?neSRnU7rSjWVcpDgBZAwfvAU4UpwzZ05teziE13CIy612Y5JaDpfHqxlcYKz?=
 =?us-ascii?Q?fVLELvwTuLom0nNiuttEdGaznmj2WDx841Jeuht8ZvG8VxE0MbF7jFRFcojn?=
 =?us-ascii?Q?PQGwdH0eAw/a+iCsW4Hlda3KdICHZ5VHi2AKRkEKTdnoCidqCUEp2q8pMLqi?=
 =?us-ascii?Q?2NtwzgqpDg7sB7p64qzmU/AEEQB3gWYFGuLuGfB1El7p2pIyDGdeBpJNCykN?=
 =?us-ascii?Q?LlZ0eee+mmespA8ii7yHtiNkM75ixIUwVvbtRceA57Lq600qxFg1vVbIE/wY?=
 =?us-ascii?Q?dXYWC6QEcygoJjq0VjEFWSR72BVst811DdvLSBZCsa1CBeZpWTK6QVXEIVA4?=
 =?us-ascii?Q?fbm3oWTjIQVtrJ8cCLTZ6iq/xdlMAPotARWBSAWGMcruFm+w1cR7zGn7SOHx?=
 =?us-ascii?Q?QQXF+nvaKBvnAxdyL3XjPiYxiijGKrFPTQ47yKmrqG8F1I+8Npl8LYHOwRAM?=
 =?us-ascii?Q?3rzZGmVY7g7OM5HQqCEJGu0XfJXqlK9txS7Z/dHrHdarDZbkQc25wRb6KLtc?=
 =?us-ascii?Q?Bz7mL9RxiYbGM8hzdoTd611CYXnnmFEjeaBDMubisLv1jJyC1lFde5pU1yxt?=
 =?us-ascii?Q?g9tZlaEN9j7CjaiyAMHu13YnUzLKTq3C19WPkCPdaaX3RFq9MtvnLZUTVYQJ?=
 =?us-ascii?Q?U38wLv40zEBLwC+zIA270fK2Chf5TkdqrIek+MJ2pXK64c/29PFiWJ3FULPp?=
 =?us-ascii?Q?7uR42deZc+dTfa0IE2AAqvI1ex4Lk4YOUdgSKm0oaoIYtDS3AK4beH/L8MUJ?=
 =?us-ascii?Q?d4Z/goRYKk7OXTianrh1Nx/ze8BB0SSoBa29MYbXTfC/4em4muBnOqUwe/8w?=
 =?us-ascii?Q?w/RBYJLRAldqIB3UEPumZQtppd6C+a9HR/FQdlKoYfcVV19POjE8lbq+Pdp/?=
 =?us-ascii?Q?WPCsuRzWogXDBOYakStv4x/25kiDh1R0YaPNdBN7O4po1gOdc65qYDr98/Qa?=
 =?us-ascii?Q?xi4r1it3R2DeoABI9RzWnYjKq5EecQx62Ir2OoDA4zIkJV/tRGvZT3hUHAEY?=
 =?us-ascii?Q?bu/iAvLWpzzo8lBkgus+9H6RDAxj1DW7B3F3sIwNauknbOFfMoNrapbblpzf?=
 =?us-ascii?Q?1L2KNhUltakEh8pSA/fgxpSTJ5cOyU8ewFVX7dL7YZzBPQ7vKvu/D2vONO89?=
 =?us-ascii?Q?Ht4UJEl4XPBdAvtNnQlBmcRZTb3ZxsG2lqOkdSyh/c5EDapNnt8uwsiGneMi?=
 =?us-ascii?Q?hB8SngianfXhIEo3A3CDqCopahyiFIy/Y9+Lv2W+haJtxVqs16vGRfMOMgGh?=
 =?us-ascii?Q?d9gzp/I6RDxYUdioYgRvri1ALFgdSigGFsrZVsC70HXsqjXfWwPw3h0vr1Mr?=
 =?us-ascii?Q?eWiWuPX/FuUe0LXST5f9CHfzzEQBf1IC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PhkVhscZIi9SZcEgQ/rOa6qqR0gBuAUsjWZtngP2R7kBF6IiLc3YZq+wt1/X?=
 =?us-ascii?Q?MkbAd4yRgPdJGySw3Xa2eaxirrHQiQQayPLUnhu4EY8+/EwH1pjHNaPHSie6?=
 =?us-ascii?Q?OY//s2iBKj4kbWLYVtG/Hv4B2uJRrcuRSzJaGEZH77sDDye9cF9p2PjaCzsw?=
 =?us-ascii?Q?SFypMnDhVKl341cHpDZDhyJzqgJA8b2e5uA9gN2Yq/2vaabLXqA1U6tZsT5m?=
 =?us-ascii?Q?C6Q4dQZ9u7pFK0j5BQ711HuhzLUQOM0WT2yr7Dp65bayFu+KJ5Pp4G8JvNPk?=
 =?us-ascii?Q?G2VgF0FUPzvxSaj6omeB0toxnYPO1oC+fR+QxMCJ2mpPb2RNnFmNGMk4IWLt?=
 =?us-ascii?Q?7lkBPxe1OUYu+13xcfND5/r+RgMaZ1T+VN9tl35w4nE8jgzTAFYsuzZpVuWZ?=
 =?us-ascii?Q?SdzpZNCzPiUsFF+yCuwGrAdpkINTgwRVFwVDtiVL4SaM0c7nKKx0LX3bu3H7?=
 =?us-ascii?Q?lEkR+gQ5YqkY0S8gfn9VR9kVDCFzesTlGJPV6XRWb5oaMe/s+67feQtLezdS?=
 =?us-ascii?Q?i0m/N2sa69Y7vmsMmAUn07iGmUbNvX0bmKNoteBBI41uKbz4aILRwP5wMmC2?=
 =?us-ascii?Q?AIV7bU7AFnxjnXzwmwY6x52ZS74h7x2vBtQVPc//CNHx4NcgO1yuf5BwcCVU?=
 =?us-ascii?Q?SSyoDFrHq4c7SVIhXHnRFOluuSJ5RyybeP9ZZ4NxoN4QdqBd1wt29GYmWhA0?=
 =?us-ascii?Q?ExJBq5KARsVIVe+kIQ+yPf5+H0dX9HWoomizsZp1m2blmo1eIwAlQ5siDu7P?=
 =?us-ascii?Q?6tleVibtumP1DsfiZqiTV+pM0/BFhUQNqdWqInB/dKaaFEPXoqCIrWUTF/wT?=
 =?us-ascii?Q?qBomyU0XFANh3wVcdea+x+tpbVHih8jget2jPaua5MIyZXZlJCvOTSWqX2uX?=
 =?us-ascii?Q?4OyAWDzJ76uZd/JgeH4xlo+1zKeE/eVSOAVowZcCT32LBcJVIIT9C8EBLW3B?=
 =?us-ascii?Q?27ylVxf7cHIGBmwi7CCPNEEPZo0R1/kyyoDhsRjMKlABatKKnH7a6V3ysNtl?=
 =?us-ascii?Q?tt5lBR6rZjOXpAfhugqaqjYmYxV2yvH2r6anzxGZ3pahrDEbNho47A8nCne8?=
 =?us-ascii?Q?c/zRDNOjjWiSbl/ILl9WJ3ykpWqrCzr4Zs830XYqVo+F1lOQkJ6md40mr7cT?=
 =?us-ascii?Q?PZ4/LpmltX3TXMrDxTBzeV87NT6RLbKIUfMvaBXWdXoQE26VCimkJmMp4vXI?=
 =?us-ascii?Q?CQkZzHqp+wJk241Fie5Kr5pAQhzV8A9lfL+DfTeqBXMDqs6ZvRKJ7kecEBiD?=
 =?us-ascii?Q?O5r9JSGzUn49c3P0LZ571yZVm1awWQ/YD55fYmlV4HffAR7pXbmk39QAAwHy?=
 =?us-ascii?Q?eioBBtCsr7HKzsxxWP4LIDgW2YqUg46sir4kgJ6pJLj33oP1MsQaHgOeH7h9?=
 =?us-ascii?Q?3IFuCaNYyJzKvif/K36S++QsC7YvpcuchcVhzWyxj+qiJ7dj1d09I7bdpSPi?=
 =?us-ascii?Q?Xd9H/PMG8smbcyg916+jzqNxZq2HXXxSAhjZKF0ZKJQLF8mvnk1M5ZUGJgV0?=
 =?us-ascii?Q?JexGpvkqR5FmUDIliH1krBhHmfCIoMd2o7z2Oc5iLLMyrI5fT+7eMqsJ0EbI?=
 =?us-ascii?Q?B4xDYDSeXDtMmdS9L5AIlJzRsC6mxIMlytkOuUDI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4070af2-f484-45fe-503f-08ddde91e163
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:00:29.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nyt6DuvBoLQ4a/PE1S04auLomlFrO4ONDUcU2o6eRwRJKMKfET4z5cy89t1MsfIDlNqt/Cp7mU15WxG9t5EgPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8247

Add #io-channel-cells property because it is multi-channel ADC.

Fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: adc@35 (maxim,max1239): '#io-channel-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/maxim,max1238.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
index 60d7b34e3286f..ae3c89393f1a3 100644
--- a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
@@ -53,6 +53,9 @@ properties:
   reg:
     maxItems: 1
 
+  "#io-channel-cells":
+    const: 1
+
   vcc-supply: true
   vref-supply:
     description: Optional external reference.  If not supplied, internal
-- 
2.34.1


