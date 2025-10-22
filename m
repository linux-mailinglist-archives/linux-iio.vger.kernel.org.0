Return-Path: <linux-iio+bounces-25351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC03BFD767
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 19:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97E53B56F4
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EB534DB76;
	Wed, 22 Oct 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dh5FAWp7"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9B2D47FE;
	Wed, 22 Oct 2025 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151336; cv=fail; b=Pj9kLw9E0BQvHiH+XYQtRAnJLUNIm/18G4AeNLFVmnHXbBEPSHQA4ILKfcvDqPGhyMaAMJVYkm/SUpOV16otIxSpu340Yus8TfI6xaMtKLtkQAUy6OfNHNhgiwxWliLKd7zCZPaJ2qBV9Lmj7UGiwi9IKAeXHu/zM8Zo+IW5Pr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151336; c=relaxed/simple;
	bh=RC4ew+WvZkeGu2BMzGEOkfBGSkc7Vh9rwBduTJAU8XU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eENMCM5QioCVpg7S6J934p09XpQkLq/PszaVNU0Y8uTa+UkJ9rcEqYFkfE5FpBQNJtGo6GJkpEKjshXeeZhCxFptYNHIdrdVwkv00LX/HLCONngA34JEtIZe1lvUUsf0/n6AMuHgxJDpwPUZYtOdqjF7WaB4QnElIbfhfFjl6Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dh5FAWp7; arc=fail smtp.client-ip=52.101.72.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJWe+/NV9X1zrY3zdw2P2z2shEE0lz/i2EoJyRPy2knzXnp4AaYqFpYD/ivA1l9kvnEgEl+dwoWNt78206iNMhfpJXIzMJ1dNhZd+lKQDOQ+pOCL/kfSfY98CRpQq1sGRwpOF5pCTbLsieLq3hF522T1dW4ohD+wXGqAtUmggg/I1yXML8uq7478kI8KGHv/KKiaIYiQYSyAQJpTKpuXMNPoSHFTQ0d6Jja5CWp7aPDbLMOSsb2oD48zl58vBtUwn6lxTw9XDLkDWXyfhFegw7E84wxB/l2dijA9CPhnfKCQrMLKBaR6/RFvuGeLfuf/MDVIIq/XVI8gvH7UlaXPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JE2t5O0K1tFrzQNQrYa2fkQ2y/rC1VpK3U7dkX8777E=;
 b=BrGOiXntt/E1B5cPNAr5mYixAKfH8gUWW7bGHVlrkeMqWObX29FMMjbeyAqFVDrSVAm2m/WQ7xQ9Xc56SaDjQulEU+4KM5ZIoJ2BcTfeYkR+1VPSMA/z18aPZzq8ikf6L0eQsQYbblnzpuOppCFdWYiUojv7LVZuq9PQFM3YS7YxESU48U6kGDR/AP8CgJDxyc92k/7H+YN5KOsbyiISMk2i2RaFiEVeP98TcCL4L34SJM37UVHViaj4NpeuNXfxn+ynypD3RQ3KSgJGOoGb0IZkgwfE/4jSPbGoX9+a5fAZdkCpP1OGjMaNBsIjsFGY4hbOqRE6lzi+R5DL28N4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE2t5O0K1tFrzQNQrYa2fkQ2y/rC1VpK3U7dkX8777E=;
 b=dh5FAWp7MmXKYSUpWr4gNOjaLXr8sBf06TFxIIeiGHMEmP0hPiI+pY2v5u+gkO9CODNfkJeAYQ4lqpTaAAuAbwuG32tdJcydLD6nFJpkeMvgTCiVMjIZQD+5sn8ixSr520dq7waOlOFdlW9r9RjYfh7s4rfsLVFACPQHMisTrnukwtEXMexSHB6BRt4tIs9gjl1eEz2px1tbCNavMzNQBRvs+clp01TJGmdtKrQMhwYAM02/lxtoSH6Vr5VqDXmXt56ZHTe8HZkBw9PHb/ONyFlILpA2xaCIfBXiQgarft25MWtqnPvPQq9B6wMOmZsborGBY0OlGNZUIcSArLMmBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VE1PR04MB7293.eurprd04.prod.outlook.com (2603:10a6:800:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.15; Wed, 22 Oct
 2025 16:42:11 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:42:11 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: iio: pressure: Remove vdd-supply and vddio-supply from required list
Date: Wed, 22 Oct 2025 12:41:51 -0400
Message-Id: <20251022164154.2994517-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VE1PR04MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: db8b825e-b91e-4142-afac-08de1189f287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|366016|376014|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L3C4ACPnqQNC98cYpTIKldV6+oMvi7zIzmS+HywnayNBLnbWo9bwH4lqnFZI?=
 =?us-ascii?Q?2t6GvRFuJbgR5zlRFZKLUXpeZaV9MTgyIa9c+V4X52qu9znmZTkFlhPLRkW1?=
 =?us-ascii?Q?EPBm821bZVWq1jAi+WZCEAxOLv9a7P1ITMHepoJjLtuOrn4jEPcQGQNg2eJs?=
 =?us-ascii?Q?XwBLDK6EG41ZHU1uLXS0978LfCaPfnzJf0jY4FBGXcvgmBYYZcjqtaOxkNsI?=
 =?us-ascii?Q?gE+WF2QdYD4VVtMy82sERMy0WSaaFXesgYmvEclGc0GFEDAu6OQttLBzOW51?=
 =?us-ascii?Q?1+lO0S7orUyDag19lx7gJirXlqWEuVjl9Clu6VgsHhuLJWU1ZSBAG5jE2b9X?=
 =?us-ascii?Q?6FGqoxiZ2YMlh2QbdqP/Da4JE9xMjAXz0XYQf/77EdlmS0I+PPgAgaz9CyTJ?=
 =?us-ascii?Q?tR7d6cRisKOiVfgX+DIZMumGk8A4uWd4piGv2IowZMFXx+XuJ4achYt4TnZt?=
 =?us-ascii?Q?0U6c5pK9hbqxIazTkAqRQfmFP6ISyPeIs9Huqb3WFziv+GHn7u7IJX32CUyo?=
 =?us-ascii?Q?qSGHm5BfbsiSlTAKF7RbrRo7C9o/1VOTBeRVujvyTahOVmbnpTG27PCGr0gm?=
 =?us-ascii?Q?zY9H6dfN11JBlktewrVRjGlpC5ECo66d040nh/SZyF7I693hDy4HM44f3m65?=
 =?us-ascii?Q?xWutMFmdvDUvwAlyQQ1A/sQ7/x+43W2smz5AyzHKvYG7SOcPRwGt5rPjY6cV?=
 =?us-ascii?Q?H0ARnPybH8zvyWZ4ytVv893l3YxVCyZUJ88vtKQgBGg84Ji5yspjfzeWW8U0?=
 =?us-ascii?Q?Wcd2zbn6gTbvjU4B3Ua2IxYVNTah/ryzKVdvZB+jE4B/8DbGDSgv5Q2dcjUK?=
 =?us-ascii?Q?zXAvYikwMoSczT90lO6R35UQoFPSnSY29h8JwlRHBFKc2JBSrKDZIuuimrCI?=
 =?us-ascii?Q?cNgywJPpQemkmE4FBjZg8AXBzmDR8s3M+w9B7MkvnXqM/d5vYKhvOr9u8Eh2?=
 =?us-ascii?Q?tji3zoX44wrBaR/zUf4UHoH4qCedEvHXn8WulKcOczrgOhNYZPsSiM+W7BTa?=
 =?us-ascii?Q?Pvc6tK3BbI/OmBBBwIppin0MumsXx+MMEhBuqRsJjiw4EsVZCs2Fq21P5dUT?=
 =?us-ascii?Q?CT4KsADVQj6+NQ7TWb1lBprpFMWTDoF55SWVLR6kXMWc5R9uc/keYVy64BQj?=
 =?us-ascii?Q?qUA5aHVLJZ0sjb9jlKTWcLMtqckvSmOiwkomHx1f6BuHyf6n98IM9TykOkt+?=
 =?us-ascii?Q?H3bC0aTTU9cDkBd9LVWVJfwHXaiVfH/iPyVhIq7mXsYNP19yoLJ14bZzA/Be?=
 =?us-ascii?Q?RWsknxbM7ycJ21Q1c0E/bT5lrLMkT7aHdcNI6mO4vg+DiP2hC0jufAjEUHgs?=
 =?us-ascii?Q?+quhC0p8OQmWd+GarNY6tTbZ00LErvIjI18K9PQd6lhrq8r7BG/jhYHjLerB?=
 =?us-ascii?Q?6CO/G2229CcU4YR6Ni1yEBRHxz4rnG43nnH3+9UFsvv6Dv0J/EJzd8+7x8kT?=
 =?us-ascii?Q?ktfWuGyjQO5RVufRZAWgqln6uPb1L2NeB8rV9OesYrJGQJCktxmZ7SFJzGyb?=
 =?us-ascii?Q?VeRAbwipGxCHLcA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(366016)(376014)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CULSUvHD48akCqDM0ghv1jSqruQEGrtAkX3Z89Zk8XPXtHe6eitW2r17alxC?=
 =?us-ascii?Q?s3M4pYPs8FrjsmHhyZfqMK6zY/TLGqfxIeZZF2bxsZl4piiFA1VnIqdFHB3a?=
 =?us-ascii?Q?BOAd6fiLRFnsa/etDAY8nodH9lKVtn+iXoXYQCyhF4lqJb2KxxtmxpSY438d?=
 =?us-ascii?Q?CH6eZNWmKG3oqBAMIPkKYmcw7Gm1P33QQd2RNvMQOmIxhqBocjHJU2hpMqK6?=
 =?us-ascii?Q?+UPU2BOPaSy0ZN0AhhYKkukc6NzcITbr/s+krvmogd9XtXoINT47amywVn/9?=
 =?us-ascii?Q?LUz9iNTvty5z7JsvY+Yf/ZenYEdMDhddhxRssWmu2uSqCIA8bc90aMsqgZiU?=
 =?us-ascii?Q?sziJMLpkfX7k0rrY8L5MxJvQwgq5RIG1Fw/HgvDxFWn5pcDEHlSBxaU4oWmE?=
 =?us-ascii?Q?IL9d6IzBAJy92p73d3QFBSc/tkm+DEL4NhFMSWfYS19zNeEIQV3BCX2IAzpw?=
 =?us-ascii?Q?8ZbpmPeqchhcqKHcxhJ3Rs5aMhV1v5WUC+SXS1vXRfypLCG0IZIdLyYyuUbD?=
 =?us-ascii?Q?oJz8+T89MTepBVSaGYGdvHw8PRL9YnuZGIgGCudYQU8TLJzNZrYox9WIkfHL?=
 =?us-ascii?Q?dhn+lIgyIjRvIDnwzNmuqrV6OvVtx7+uo8MtGPvzg5IqAl2jyt8+PDdmFJij?=
 =?us-ascii?Q?5/IpNzTGxpRsgWPQ67hwFGs5wtERfdrYhsFR13GTOzSFw2W6pKkOwrnumXLR?=
 =?us-ascii?Q?i0X/RU+ARwvFWRdlhiSKQdWPPndKW9tLIfEVl7M/Oir86vypYMO8rt0Wks+F?=
 =?us-ascii?Q?V274i9MEMs3GRVLaimI425+tcTVfSSQd7pyUYqOp/SM7AbuhmjuTGIijSIMz?=
 =?us-ascii?Q?Ve/xPNQiGE5YWmaqzRZq38xbd0R8bU5BDQaP0wofkskVFpwmpyYlckryd0Op?=
 =?us-ascii?Q?vhSCcHBzOvfWSt2ePS6tpSLLycWH15+IoWfJNZg0ImXBYMFKH96FG8qDWbHN?=
 =?us-ascii?Q?iCXzXcxapGERZ4RilL6yvQKJpoV/+BX7LZn40Ggn2AxJoyBYP2EDLF/qbMTS?=
 =?us-ascii?Q?5blj+8WqHyEqHhwKNCY8jH6+whBHlB17NhMFpG0+e7XJPd5H76Lb8WfOm9/m?=
 =?us-ascii?Q?RUPrNWkWzZ4iC5QjXqY+9Fwn+zGKM40eRNrGTfRPIlY80Tbp+JWXPlLW+OzB?=
 =?us-ascii?Q?vkedTZ0TOaIgWtikbzPFL2iTZE4UO511QUUq32D+X5fNhg/LkPOlcV8OtsOz?=
 =?us-ascii?Q?qDQTFK5H1/RVqw6j/Pkd9Wkyjj/Jbz4e+4rtoBUIz57TJ3ozywSkIsNqT3NI?=
 =?us-ascii?Q?PPxOgf56Lzsvj1Nsfnr1e0WrM5T+KJUjrCEvzHlBYKWJTYL6oKIuERlGTDKf?=
 =?us-ascii?Q?DMXyatpXGW8zTWGORoE6g4gCsRzl5bPmtVh9NnyUoru+Y0Y+Hbh8EifUAMer?=
 =?us-ascii?Q?49JWVOroZiAbCMCYyWE9/pxSfKEPELVDIckhO7X3krS0oDINL8Jf6KQ6xe2+?=
 =?us-ascii?Q?SxRWB7V+zTm9kQbqWvnDpuDAD6jNn9fdBhLSbWgp31Jlpz8usA+pmTyJvr5P?=
 =?us-ascii?Q?kThnQx6Myk/m3TlTk/2yXGNaBOizZ6Qz+7OTZ5okHhqxckDI4uyUpkWE0Kmo?=
 =?us-ascii?Q?/jf0p3fuRsACpYVfcPY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8b825e-b91e-4142-afac-08de1189f287
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:42:11.5606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFH5lNQ4TF+5OO51/gXg5EOTICV/k6f9YZTbPffqiotTzP7Tx1s94lxaq/3oSh6t9rinBa5/2Xb6mbmhFxDDyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7293

Some board designs connect vdd and vddio to the system power supply. Remove
these properties from the required list and make them optional, since
drivers/iio/pressure/mpl3115.c does not use them.

Fix below CHECK_DTBS warnings:
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: pressure-sensor@60 (fsl,mpl3115): 'vdd-supply' is a required property
        from schema $id: http://devicetree.org/schemas/iio/pressure/fsl,mpl3115.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
index 2933c2e10695e..04703a01cf7af 100644
--- a/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
@@ -47,8 +47,6 @@ properties:
 required:
   - compatible
   - reg
-  - vdd-supply
-  - vddio-supply
 
 additionalProperties: false
 
-- 
2.34.1


