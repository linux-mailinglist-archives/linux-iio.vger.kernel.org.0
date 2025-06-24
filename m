Return-Path: <linux-iio+bounces-20949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17430AE7069
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 22:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4311BC4054
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233502E92C1;
	Tue, 24 Jun 2025 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PisKpr7+"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB823BD1B;
	Tue, 24 Jun 2025 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750795996; cv=fail; b=oL2V30czdKslHO3lXB86CnGlPD+5ctExDijvcFZWaT4hv5aHwpU2lVJn9DxUPxZhJvz+X50rBJXsDfry2DXGka7pZrdvoAhHry5I7e7zDwXuz5YEAa4Gy4qNwBq/vOhubfdP05LYPiWzEfnb19vp0yNyoJD3FA3Dcog4EwjH+gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750795996; c=relaxed/simple;
	bh=hu2/I2XsGh3dG4+aOGDG75DkhO8SlmszMD51d0CBqZY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XzeoFjO62ln/sQYtA+6hgb34PvpD5y7xQcjc6kdQfmaD8sPMIOYAasb9jHG8P00WeZEAZyr1njWOQWtrLVqErOzc2wI9KX4vH80U1uwu99vLWAPi+j8QFB046lXCWD0X2jZhPslkbgBeIlUb7/NbFYU4h3Lc+rpeM/9R9IEDXAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PisKpr7+; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oN1qgx1VGhEzUURkUsr5XSG7RH5pagPxykajMV4xrvz8Gu7iVJAi5KoMEyQJkJTzPSdH3PLbxDBR+plol+Z5V5iNYxbnY7H1IsclUVZupAvkQ5jDOb/bBzeQWgYmG0sj3Ob5Y3lMfXYve7o4C9Hwko7BXAwFYwjxgogNCJNpugm8a//fjy2/8VglO2BqdmrFUlPuJ1Bb8FcCOBqA/b2tGNihcy5Lb28oWxlbgWEdZJm9JQvUQSTxp+eD5h1ZtivAdq+pvu90GdTSyuY9jzvPptiTMiuyE7IF2rQGzBw1vBzyAC3+2I6UH1rZWP9dLDCVpEmuD+0bY2X9oT4D4rIOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdLi1Wp2CpHpNQIPmvttD5hcy/EWHFYYdyE+CrelEzM=;
 b=aR9YpWktnIG/AVsp22aiBRJbW//Bsp30dK9ep5doM8+M3ntdbFZDm2tVk78Uryfw0Un7LdiDnbNSg6dXwcHxmdCyga+98hcgJ66MnEQ4zlx/PpUp1cMPbfKiqTrOurzI68xOLjEjTH2vz201yyCBeOfEHNTOe7LxrwNghW7ig5sfzH1gpkE6op7gxEvsxWdXOw7AQfgg6K9IuduZN0QC+1FSuCQqUgFWX22AGzplbrlsRPVmU88DZ1o1vOlYd/f8BCi7VFkDz+1IlU89t3/+xYbEpoEU655mJxbsI9BO9uxFpS+Vo9el1EAto3l8EXQlcyAOY0MEcqjZ4l+08cTsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdLi1Wp2CpHpNQIPmvttD5hcy/EWHFYYdyE+CrelEzM=;
 b=PisKpr7+20CznAOLqPT6l45fGWFyx8Ofp/B3ZOCyzahHir4dk2VM3hCkM4eVLBol5RV+a1zKfui/jsKbhsfYFTaEuH6jN0ARiDmt90rFJPX6ubKMHsEgXgEbzZHInFHQNlGhI9zvqMmiDRcXUUSoKMDG0wxQm70KE7n9vn6NoFKjel4WeCMmkNj58lOJF4ZAgF/TNZVn22C1yZjBSSf8w8HbIDa8FTVXkgMEFrS/poFa6Rx9iSrxKCEQpNumTLnMRwCt59qoZ7QE8kfx0Un1c6HKsF7ITPGmQAkjUawQXcr19egtuj02jTX6ZnPMrhbY9MEbKCTk3xDMt9IiwMt2Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11458.eurprd04.prod.outlook.com (2603:10a6:10:5d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 20:13:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 20:13:13 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: iio: adc: nxp,lpc3220-adc: allow clocks property
Date: Tue, 24 Jun 2025 16:13:02 -0400
Message-Id: <20250624201302.2515391-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0162.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11458:EE_
X-MS-Office365-Filtering-Correlation-Id: f23d54e4-da6e-465b-9b46-08ddb35b8bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Un1VGibdi0lE3e1hmm5EFYyP+cRFGRn0mc/B1dYU1nJrJBBz7SHBhTrhULci?=
 =?us-ascii?Q?Z8coEAkOO9lU5FkyJAYDh7SO3t3AAeXl8X2dpOQry+8NJQbrOjatekoXK1ae?=
 =?us-ascii?Q?C8xh2Wmatfe63T1nc2BLJDm4zOuvQbcS1AEMxGNfi38LaJP1+Y3176EvSu15?=
 =?us-ascii?Q?PlYfH/Umm6zDlU6rGLAPsdPrCaZAf3WA6IGstE0BVfF2EeaZ9zDbga2JzIxz?=
 =?us-ascii?Q?Xofh+sTf3nkRPjK0Frg5FxdM/IvSiXpFRD0p6hC675ycwYvLq/h/BHlCNo5G?=
 =?us-ascii?Q?RN9ggtAvdRcDKJqSpTp9Yk4X66yHwl1rjuYH0KSXM+enLGN6A6ShLX9Zkf6U?=
 =?us-ascii?Q?v5jjI/Xe2GF27ZEvDsTu011dpLedBSoV6A399Cix1EDhUrUpPp7+To9bpOfz?=
 =?us-ascii?Q?m8Nn53LNznx5hSho4elx8297RpbOCFC9P1YCQ+/MBPiGcB3KcMcv7gT9SH+C?=
 =?us-ascii?Q?vP8Iwapo1xL6JELhyuF3eHzhdb2N/IX5YU4ssPmhmxzE1VCcBQfz6iQc3OVh?=
 =?us-ascii?Q?xzZZ7qUbC0O8tUwvcJ27OzL1DPHxR3g54CVvVvH+gyNcfCuqmI28Z7ZnH2p/?=
 =?us-ascii?Q?m29hJcF3cpxK6gllfZ5J7R7miSXJwrrGMcXbXQJSdAQsmLfqGPdn4lgi5ols?=
 =?us-ascii?Q?9EqOFMAn8WZgfJW+jAKi1BCZkzL2onzznHA8umLfkXvgjgVZh3bC+/GhqwTL?=
 =?us-ascii?Q?i4unruowe/GMJGeZ+C/KA1TWOhGHwQ1xVEmr0+Hd2hx52su7nS87nK0zJxD5?=
 =?us-ascii?Q?/80Rd5jCfJzuGW3tlqO4rTqObf+S8HGqRhp3YCVgvSgjRVYQQ71YUdkwrm5S?=
 =?us-ascii?Q?n2ZkGaz0rI+AEld5OIMapd0TkEy24JtWJY5MtTdpfAdLPdJT4ViHwppIG3GC?=
 =?us-ascii?Q?hA0CX0lJ2JmHL1MMsT/zWllESlY5YQuBymIpHOWP1Aj3I1RcdGrMIkxIwTWA?=
 =?us-ascii?Q?BMi2nA5k8edwy8yp38f+pnZ93qusb4byz41R+Pm99qVJFhe+/m6+ygeTMMKK?=
 =?us-ascii?Q?qPXnXEEt6KqFqG77TxfvB0REJq1l7UPkbuNfHLlV2bUUl2nLUvRsRWqa74T2?=
 =?us-ascii?Q?8VUZo1eJnLQQOb2XzvxxLk6l54k3dH1L9cnLt5D76TS/uiAIV/tilAZI2TNL?=
 =?us-ascii?Q?uclJRdWphiQkJE7FAzN/wkvBHZmTopNP4LRg8mpVInpYgACecEdhMAARNVau?=
 =?us-ascii?Q?89wcRHq0EmtuumQP/UHa09SvrJjOsbx8Jevk7B4Xx6kDrVTOAri2Ju3ORQsn?=
 =?us-ascii?Q?LXXIE/VQimywn8hJKxWH4STmxBCyJlPHLfCsSXHACaCktMD1JOnm/H59jD8L?=
 =?us-ascii?Q?2h5pQSWUXjhuaoIGUfoKDu7vYsk4mNed0q1VjecBeCwWW2W9YN2Vs02ONr6r?=
 =?us-ascii?Q?ug7Fg1VaGc1+naIZZMi4fgrI8iXcIbZEdWOH1UDUsvAyePtXFlQwH8/ogPXN?=
 =?us-ascii?Q?B1YqQt9oUSiBU3U7/t8MygDis0RJItdBFb4cBKnRo6puPSzp+1MqPXcNW/XD?=
 =?us-ascii?Q?F7bZw+eBhtT0EaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ykAGcCy5dEvvq9TlBQjkSePTOvEc0d4fYtnPhxk9plxHoQlUP6zeOTOTIwD?=
 =?us-ascii?Q?Qo7osxi2dpDA4WPxISDnzk+ADyP7KrleKNcIjdp5q0WeruiMtBgdN/B17O2w?=
 =?us-ascii?Q?Pu2Vj9aLNCHTfSw5AT0GuCsSmuL8MMykSUdzqFDfxq2UwIrMKruKnxzPu2V0?=
 =?us-ascii?Q?luDzVC7khmj3yO4sNZHR+6IdCYhf3fX8GW4D4eSGbl803+iv/vc5Ih3OXZJe?=
 =?us-ascii?Q?WVwjVddl0uHedt3pGGq4tsM2Hd+c6Ohiwx1NR2WfsdyrsKnq0TC6iPyw+cUp?=
 =?us-ascii?Q?5R6aWvRVs0zSxWTIVVY5ljTi2ORlwgsbpKA+OeySysJo1dg7WLpwmL6PGyp0?=
 =?us-ascii?Q?nC4NFCFctIhEs9+MNRYouEyoUWkLFWClJMwP03wpCHaWK8WILAS5iM+gcNCq?=
 =?us-ascii?Q?YElUGcaAlEZjoPzyBJnVvJ4WFXqFuWN2Ewvt40ojnfkl03oCNWrRnoWxoSUF?=
 =?us-ascii?Q?I2jgrhHNlP1+wCXfraJ30vLJFFb36YAKRIxFVvSLrZ9HPIbq2z7nyUtNqQqX?=
 =?us-ascii?Q?XYUdS20eD4PlJDkThhNhWUV9kOVoC4FeV335NeuvU32VaFQAN30UpPlcOM4U?=
 =?us-ascii?Q?jmLE6Xy6sI8saVK51xD0qVxgciPQqbzDbyWQt0gYNoRpCjEVm7uXg6b8GSDg?=
 =?us-ascii?Q?nvuZqAqu3VyGG4lxiDVxoivT75gh2TqBesoTqJHLlI3XdPBOxASHSlH0Oimn?=
 =?us-ascii?Q?V3ySbW9hbKBl1mbylrG8hmWBU41KZXdC1S3NEJRUBluzMeXtYTcKIarztxBy?=
 =?us-ascii?Q?qgWJgyBFd8YFyMslQkJ2BsLEa8qBOzwkcK009MQ8PFumbPZ0TbJJuvNrgQPI?=
 =?us-ascii?Q?qtXy7q8ROWzkt7jQnfZ5b9tyKs8ALOLRPGFC4RsMRqbTOjGxr2T6aTuHYIIM?=
 =?us-ascii?Q?qT7IPZiwZOEEH+RJIgXPUKiFZyiLs4V75SQFjeuYP9lpnSubhITHfq4R/vCR?=
 =?us-ascii?Q?01wW3TlMJ3DMsJeEB77wHf5SvhEAOcor4zMiWiIvWyjx1D2ccMVn74f3t0q9?=
 =?us-ascii?Q?bX7XpOIJGV9/Y3MvudSjcdBcAt5qOYXcnhmKek0/knSnlekhvHEDpvt8KNb0?=
 =?us-ascii?Q?uwHO9+vIHTW48iTWH19m6AXQxzd1NqAVPL/mCSuqN/uF6OHJi+QwFdOsP8dx?=
 =?us-ascii?Q?3UUojUN2q2ABD3tjGrBbrwUS4ZTMLxS4xPreKnrhP4X/VC8Jv8O9GRFf75Dp?=
 =?us-ascii?Q?pT5k22v6moVOo0rd4w3p9qIizgPs8ITWTGBCOjvKg9v0WaIVB6Wv/LfH8UmP?=
 =?us-ascii?Q?c3TgdAcdjyU8zjvvsLGUz30/UsKSYhLG20hqK13p3UzIB6jrDK4QhoC3UhUa?=
 =?us-ascii?Q?4IG69lFB8LOGSJBACsWOmYIQ8cOiCUS9xIiyklwThCwPmlz+t7ei5V84uhB4?=
 =?us-ascii?Q?xkJLdkcpJ4bqk1ddgQfF9tPLAy5ldvN213CcM+jTWBAnp9AJnsNCZ5fTkRYR?=
 =?us-ascii?Q?p4sky8asmr5yLFy9wb2IerptryLZfnzhckPj8CsH8gWW6Cy9A4FvpgWftJYl?=
 =?us-ascii?Q?ECKYaAt7DUDVCkUpw0ZAnc6MrPmcUbwW6RtbO0JibYC/yPi9ASIeskt7Cak2?=
 =?us-ascii?Q?w/Oj/xYoka5UfEHrTdqx7mjzZaBqWyWQmUe8cFap?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23d54e4-da6e-465b-9b46-08ddb35b8bfc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 20:13:13.1553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbQf/OpXmUnkDqmYziCo1fZKHUA/sO1RTw9/scs/iuewwaG0y3JhXBP+kWw5E2BkG2VTo28H2+cxWiewaepzIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11458

Allow clocks property to fix below CHECK_DTB warning:
  arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dtb: adc@40048000 (nxp,lpc3220-adc): 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml
index 2c5032be83bd0..fd815ab30df12 100644
--- a/Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml
@@ -22,6 +22,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   vref-supply: true
 
   "#io-channel-cells":
-- 
2.34.1


