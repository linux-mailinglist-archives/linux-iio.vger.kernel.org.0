Return-Path: <linux-iio+bounces-16482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16203A55263
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 18:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF5B3A596B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF049256C68;
	Thu,  6 Mar 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RPjby2AJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012012.outbound.protection.outlook.com [52.101.71.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A323DE85;
	Thu,  6 Mar 2025 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280926; cv=fail; b=Ps/KUzl07jsmZ+Bd0+xuIEqgqrTPXDXXc1z9WFoZnsBarzAjLp0TgAo61Tgw9hmNOwu5l+lemsfkDhp9a11bqm1xrcvu/Dx722OPYwLjDenni1F4d26c+ghBwKLbwKhSC3ndM8XHkX8C3tuq5odrhLs7ADIuNQTA1Omkp7ByMTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280926; c=relaxed/simple;
	bh=RdPo/oxmJ2gmLlSqBeL/u/IkRc6zJExZcGbDFu1njGo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bRv/k7rBQEonhn10tT6AAKtvRM6BiKHFeOtAaQSEIZTCcxkFipBnygD6ez5kd81Mv7bE88voiEEVlnq4y/Rxm+OfyFKQmGoVYWJvo/VqvN9V+De0IyNxT8ui1Wi7Or7b/fY3bXh3C0Ffxg4otPidtCnBfaiTiR0b4IDZxZS6auY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RPjby2AJ; arc=fail smtp.client-ip=52.101.71.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyfxSvQO7y6kk9Bvk3RfXSJRk/SlkjSnVytZGtmgx0PgiisBHlIfIw7nppzOOYw9Wlhnpro/37SvViNvmJ6IIY2tKvr8FpXowITWi38Q/oo2t52SUgjbpFoO977aHFTFXBvnVHIyC/RTVq39kZb5WXLJkTk9gvIGzJZVTGLVgQ4enVFHmzUYeCxbpHk24Xu6OB8A5N2E+p43Y8gFTBxCIrFFu1VP3irzf2PEhzmtLzRH/IeRYTV2AIAToAy6BVrh6GqwCqDMq5DyPfo/jqEX3qw/Ot1+DlTbNRiIqzFC8TGUsPJK6VOz6faZVVM1ZAb8vY/ZWDXstp06d5JIvOyECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpp1JZWM2DX/jOLOfjHcog4jdemKJK35vA3L1o0J/W0=;
 b=J10dTQeilUHCrgM1vWWgJPWeEJW3PFLXuaNibbCMUADa56tQC6ylm57xel+quTGM8Xw1vc9LoxEzcFWBgsIihiD3iQWWU33WxM4lbCsVCCERUpH/uRK+fRU/WU0u4VlMHjsK8IgYYUpM+dsPU9OtkUrgds93lDCarWvAmVw3yuATz4d8JUMNstdacSXfBuRlY+ZCspdEnFyFpI9QoGqPXBLrUuHTR+JgtYvmQCBMbUXAIufH2tkG18hlOfUcMB7v/ZUYoDoYs4FIjBUuwvSpjdkJ6R9U3A79aVFm7duEVTVoTStj/WOsaWWN7APqrkQMGafhpkF3dwGznbx1ojs3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpp1JZWM2DX/jOLOfjHcog4jdemKJK35vA3L1o0J/W0=;
 b=RPjby2AJIn4afrjxghv0mEFUfxtiBp86/ARIHdf+uENe7RBHs9utmeSCzaCP4iOXK9uj2VuXqNS/CpbLW9dRmO/NuQBLHEczJKCTPTckhk613+BzvmeNlDtOs7vPMo1V7jceQ+m7nEttVrbV+zeXVe+zzEsh9ZJzszKsXPSYQKentdv+e3HS4WXbwWyjRFAHhd7MX5VAVnWYOsNF5z474FOPd9Tj+Np3NCZ0aL+O4oORPdJcbeVzl0pnj7GWdE0SXi+U8zo+hq3D/qhYK+EVW4k91VFq2Ps3miGvfoLm/wgRzWxkfJdYflGbZ6pdC8tdWnjUStdhwVccuIMMwyOpTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9179.eurprd04.prod.outlook.com (2603:10a6:10:2f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 17:08:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:08:39 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH] dt-bindings: iio: adc: Add i.MX94 and i.MX95 support
Date: Thu,  6 Mar 2025 12:08:25 -0500
Message-Id: <20250306170825.239933-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0366.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: d33f4376-1cb4-415c-d71e-08dd5cd18a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xdCdZc25mS7o0tb3AIOT8oaHi56lIk2AvMAd7jO2E+vGTCsUi64hUl8WfxR8?=
 =?us-ascii?Q?NRZLzFTCp406p3q80pIUwQa6mhfeAs782K8XMKtd6yKf3J3FdnXXqvLt0ARK?=
 =?us-ascii?Q?yagvucJ/6oGJoHHxhcCVghlvjBO95IIMy1FDmEwj7qJyb2lrSJCVyVlgLzn2?=
 =?us-ascii?Q?GdVDIRiBlSuLTZo2XnS34bGZQnV0B/nX8q1MNt125xy/N3aJtE7udq3he0bn?=
 =?us-ascii?Q?+UXeUn7Gn/UB+Y/epij4uX0IBDtNkCIuXgdNGC5mC/CWOKDlgNvdxbQRadq7?=
 =?us-ascii?Q?D8OPoku/tQRgfIDgDockQvNJ+qojt55SOcQZhRZ3ROFqwNKeSctz89VsQkB2?=
 =?us-ascii?Q?bUveIfNRkvnms6Tk+lA+2QXRue3HKpHwE5LJgDQjXnU/UtT2cw6f1yvcceGh?=
 =?us-ascii?Q?4jtkLqqazP3jws+a6UQt7Mux7XbnSdsiqBGP+rjMnssBKrND3DrD/YUVl93L?=
 =?us-ascii?Q?7U0gxxrhv83z1gULYrqqD4o3ocQO5mT4PusVd8JIb0JUyWDPEsUjjKbbKQ14?=
 =?us-ascii?Q?h5iNkJb3DevUUt+XcEdoOXSI68OuDRVtO378M2aIq3YDYlEAoavuup4pu1Zf?=
 =?us-ascii?Q?vNE0gVzATpLbrEvOSY3/xQDxUnh1IX1LKXtQ4WOM/1QQ81KIPHUhP8965kkx?=
 =?us-ascii?Q?nEiRuwKeY/zCy1JZ4b6jmCVvaqFxT6Nvaq0WcMaPH1K18uZelkc6BRYYqEcC?=
 =?us-ascii?Q?J0nfEzW5auQjSck05Fz3A+9OxCSdHVcSkXR/MJ9Gdfdp3+pCZiSupaoEb5XZ?=
 =?us-ascii?Q?W8opIIfNQMFQGCLF6cFXDW/Y3Lc6vJdyfWtXKqHpKEp/D/rElEcM+rAn21tg?=
 =?us-ascii?Q?pLMxD1uRiS9ns/kRMhGu6YagFCVi/YzHOXpBUD0pf7vavCj3VnZ8wVbPDgLL?=
 =?us-ascii?Q?VubBbmJB/XY2Jy/oDFRJRyzNmYRcIMu9S+qtfWVrRlSihXptcBEX1I2TGEqd?=
 =?us-ascii?Q?YKP5r8kGZsiiYB/H4Di4h48kpTHbdbio7RKuGTNG4HoWDTibthyagrha+8cw?=
 =?us-ascii?Q?T+fzvDQLGKk3sCjNtQi3JUZZ2OycjHtxPEQnUEwv1aGRK1tBZRRXvp2gZ+pI?=
 =?us-ascii?Q?1y4NNytaTvIlt2pD3+HOZK750S4ddN9pqxsAaBsAc4yNQWoTkTmo7PRlgjT+?=
 =?us-ascii?Q?b5U07BxAhAwlRalZ30S0fvEh7N6+ES/+sV5FptVTzxK6q4a5Toa4UadYIYNJ?=
 =?us-ascii?Q?7XrpyuR610MhMDRopF53GlFpTl+WvuchNrlWiVBjWKCAzWR5UYbMV3Md+htL?=
 =?us-ascii?Q?5xm54uCDrCod4ggI1nvAk+5woLNNrVlMGzO7FCzfeOEk3Mq02CqR2ygtT96k?=
 =?us-ascii?Q?WPzaaUMgfW0efzaI2KeIPs+/vCy7McjTa/sxuAN3zQCKb+mAFidmROb/BVdl?=
 =?us-ascii?Q?18O3IvV1+lPIQNrCAVHsQ46JkqHI2XwbvExx3e4XwYdNO+KSTIZaE27q1C30?=
 =?us-ascii?Q?q7NzCXPnx2O7hr2T/QhQksuqSQUl7jxKCsq6q5MS8lXPUWedK1G1Zw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Av4n/zUfoWKAbNgTBIvGD3U0V4hFoBAjymS6Gp2uJ5Y+7Aud/95YjA5hl1t?=
 =?us-ascii?Q?+uofxJkKktEZ6BdoBjFJFvLw/Pc04axnLRykf96zjQKuClQS+3rWs9Hg/p6d?=
 =?us-ascii?Q?+2XczNk61G4C/WmktKVNm1f3Kg4m7PaGRzBU8TFX6YCzIaWf6Dtk+eUkvaE8?=
 =?us-ascii?Q?uOjcFSb5bMddoYLB54Udf9whCMDOUOVqcp/tGo5B6hZVquMtJQOJRHFK4c/2?=
 =?us-ascii?Q?9lr27LMnNOgHxB1vgCF35WijRqQRB46WMjZ5aXCYLun7lMtNeFzISFyPepLh?=
 =?us-ascii?Q?G9yJGTBMjfI4l7GNc1LP83WOPq8w0ksJt668tHBXmZpObYx6meDETzUgdgWQ?=
 =?us-ascii?Q?UFakz740D135FuIaGHbHJRl60/euwcccNRLFVOdnuMVO5lngKquJQggoSd/4?=
 =?us-ascii?Q?RbFXJJuhKqI8TTr90op55dtUT3zL6HNIqp2w7tdRUG56r6D7VFEEvFFOhIZg?=
 =?us-ascii?Q?pQC5gYB1BSQGSL1SWMXmrkU3+yU4qmC1MxPsCmBmGE27FjPDKEFfZG0Smhkx?=
 =?us-ascii?Q?HisNP5YZlUxFDjfJgYFGizcuKbL8eHrZ8hWD9S7cqIS02s/XtzG0PjP8A+VD?=
 =?us-ascii?Q?BLqKeoZIlkWYy03KvgHgLxkhrz57yswdg0DAsvZhfsuGJxk5P0j6ypxpgcZX?=
 =?us-ascii?Q?vpCqPQ0hWcPa4qvm4+lJzaIBv9b8V5MMSIdl7/OJEStg+ZPWVu42onSkptUU?=
 =?us-ascii?Q?B/veCrcc5BRTHtzhvd1WkU9qblo4T0pyX4vg/kem3/ep1HE4H0SI+84EkjuM?=
 =?us-ascii?Q?PVlQu0LctzEetF/P0+L9tBqBOwuo+MPRBi1FO6YmW/6Ne6cJvpV3AemcAd9D?=
 =?us-ascii?Q?M61Wd6HX7DV4M9auioLmtI/kwhozW/j2Q5CA1ZSrfUaeLibKieXDVDZZ9Ay1?=
 =?us-ascii?Q?Q4ECclfiu9tsG7cY5FzvkTBPjR2z4+fuQ0Ae/5eUbWe0IxdPxEBCs6OGcUKp?=
 =?us-ascii?Q?QZpa/RdfG3P9OfMKjOsfC4oH83AGBtGrL8Xqo2HjgJ8z75jGiDIZhQBCFkXm?=
 =?us-ascii?Q?mm3c4c++pX2NzDtOkNfVt24WQ3202/SDiQ46YX5RzWlP8zDjYG1X2AOvn6q4?=
 =?us-ascii?Q?poct1hsnpVulM+OXzuHhfs03AzLtDZLBjjes9onRrz7tUrVpHOT1bX/SJeea?=
 =?us-ascii?Q?F+aUnBk/c1w4Eg5RM4kY98SmuI8l/XwHAvwfz6Ls2EUkrRZou0BqmL8K1kTG?=
 =?us-ascii?Q?NUZYr1tbTxZP67rBntIVnTpGScEN4dNqb09Igh9ribRMNTOzu1wZafgdFJL1?=
 =?us-ascii?Q?ai/dVB8n1PTOeKj+TutjqtE1Rh4brKkDtrZ4wjIFiDMDki5lP923n7KC+zhE?=
 =?us-ascii?Q?gF307JWklrWcaolldqq2MLPRuF91jX2haI+oxTReJwV5b7FpQ5ayMReqQEWM?=
 =?us-ascii?Q?5CKE4alKeBHcAkGTmHvJAIFmiP1Oh69yeEMP/M4eLxL9X0R1ewgJL51CXmn+?=
 =?us-ascii?Q?ZDsFAfdiMUBuInSsU+hCbS2RRFBTO3Hrm63qdRrL7A75KeyYJc1J8i+ZZUPq?=
 =?us-ascii?Q?76gRcAE8jXPHskEsOCP54KurkyA8XUA5PTTkbAqBArVKW2VeDyQvG+CMEbVG?=
 =?us-ascii?Q?2F8bAXDb+TpI6HI2SL6TopQ4V8uwH88A70Vyonvf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33f4376-1cb4-415c-d71e-08dd5cd18a09
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:08:39.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIdl92l8GAusJWrhezWBJDIlRq2yikQ72LFtL8sc+JU0LOHLCme+BohA5W8eGOCkyS4VM7iD5BkAI9BipTad+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9179

Add compatible string "nxp,imx94-adc" and "nxp,imx95-adc", which is
backward compatible with i.MX93. Set it to fall back to "nxp,imx93-adc".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/iio/adc/nxp,imx93-adc.yaml       | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
index dfc3f512918f6..c2e5ff418920c 100644
--- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
@@ -19,7 +19,14 @@ description:
 
 properties:
   compatible:
-    const: nxp,imx93-adc
+    oneOf:
+      - enum:
+          - nxp,imx93-adc
+      - items:
+          - enum:
+              - nxp,imx94-adc
+              - nxp,imx95-adc
+          - const: nxp,imx93-adc
 
   reg:
     maxItems: 1
-- 
2.34.1


