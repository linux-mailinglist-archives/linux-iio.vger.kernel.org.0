Return-Path: <linux-iio+bounces-9490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E504F977CB1
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 11:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543A4287157
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696411D86D4;
	Fri, 13 Sep 2024 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="HfHNTMvB"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7861D7E5C;
	Fri, 13 Sep 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221456; cv=fail; b=iGFnpYXi+nAjRV4KmMFvY2qjIKFascXtroXB0qKdJ8GaKJoj/gCfK3PB/2HNhFA0aE5rrItTdjPudtCr6zc22KSGN/EjIWXV/jPSuYxG9wkCowDjwPpIORq0F5Eejrvr3rmNuu4Mq554D4H4AflK3SKw06g8vr/jwdZ7C8TyE0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221456; c=relaxed/simple;
	bh=M0UnoOHRx95iVf+2P5gVJS/5zwelZ4YxJSY4dc2wyNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Z8xz9l0J9io9ssCpexQORNYpsnqiEuuWvFmouy9260K3wCJthvQp1llFU2uUl6NPQSMOv6HGsdqWbL3u2eEXMH1zwp9QfEghQCnX7UvdcxJyjp4jYT+qVqGsf9gcDI9crnTHPW+F1T9KxOisZ2YyXpmOeKlAfymXsjflJnV+x/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=HfHNTMvB; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtRMgw+aUwrVqcTh4a9nFthbpB+gNEW6GKdXNrLoszzbv/5veWxlk1UWmXVxEp0QNnu3OqoGf+EuRYnr0T6afMoBmIjHKTMRhRONb9MVQ3Kcj5eDMMUsC59CVZQSKVKI1ucUz/aG2gq1ahdT9Q074ASr/LjEoEx+jk1HOB6AZX991DR6N9ucAZLnzlac+rJrL8ucTz9btExmWvq7+70TahOnw1QHhKptSqLhHF4JMomYjLolsOpU6nXw7f7VQnKxp6iLaJT4lEDnOXphVEca5jnclbuhLYHMAlw99Kkf0SKalspc0Tootq9/RtvcsrPSDiEPOQWDNaPjZvaxSenG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRdsqO/jwDv/bXZ4gNFo59wg4CaWRjYLQXOu+aoKz28=;
 b=Mq2pUz4xheT/tEQfz1MjZ2G8h3zuxsi8ScOtsSswzjWhlHtKVYaT1A1jkOp+OcjYirrMCXQc7wmDuDifYByoBZ+u3liWSPZFMZJWsTRb6yNCpitOQzLfh93ym6GygyV5gMPJtv1oxTgN9xSFmRLHAExyTYO1EIr+xQiY7fKOcT7lgdov0QxMF4e2fLo3ZFiy5Mk0D2MFkCyJxV/Ad0/ix4Osr9bJxgiOQLhzwj2Kzd4H4+py7SCwXRuc/vjtZoWl7iXIJ+JKcOliNZanWOG2JUeuON94Joe/SYxTNWbGygr+4WP62CWNTnxrLVYBRJy/QuFX1MHMmyUrklWcc/sPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRdsqO/jwDv/bXZ4gNFo59wg4CaWRjYLQXOu+aoKz28=;
 b=HfHNTMvBTsikY8FVt1bu5EO2DfbXS7M5mdrmYoPgmaa3JsNYRUqhBuPsBOtz9FrOVs706Z3turC1WwKI9QMLHqPvOubT/Ei3KDllJ959/FxRNcfoETLLflilMXu1Q1TrAK8DDPJAr6hWDS5zWvStpgWamremBRR8e+ynLgaEauw=
Received: from DBBPR09CA0019.eurprd09.prod.outlook.com (2603:10a6:10:c0::31)
 by PAXPR02MB7885.eurprd02.prod.outlook.com (2603:10a6:102:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Fri, 13 Sep
 2024 09:57:28 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:c0:cafe::aa) by DBBPR09CA0019.outlook.office365.com
 (2603:10a6:10:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27 via Frontend
 Transport; Fri, 13 Sep 2024 09:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:57:25 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 11:57:22 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 11:57:22 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 11:57:22 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 009C1F4;
	Fri, 13 Sep 2024 11:57:22 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id F234F230ECAA; Fri, 13 Sep 2024 11:57:21 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Date: Fri, 13 Sep 2024 11:57:03 +0200
Subject: [PATCH v2 2/3] dt-bindings: iio: light: opt3001: add compatible
 for opt3002
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240913-add_opt3002-v2-2-69e04f840360@axis.com>
References: <20240913-add_opt3002-v2-0-69e04f840360@axis.com>
In-Reply-To: <20240913-add_opt3002-v2-0-69e04f840360@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|PAXPR02MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 999ae0e3-f502-442d-c62a-08dcd3da782a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEc2TzdOeWw1U05tc25JL1hlMUVxQ1lySXdhY1FjRVBldTBnRWFkd0cvaXR1?=
 =?utf-8?B?aEk3TTVESjNJWGJmTlJBcGl6VnlCUzgyaDB4QWpyL2pRb2c5dDNxLzcyclp0?=
 =?utf-8?B?dnpPOUlhQTlFQjIxZjVHMnBBekF1REJqNFdiUHRZNmFNd2VlSWsrc3YyTU90?=
 =?utf-8?B?UWFLc0RIMjFYMy96MzBBNjBUTStxNEF1dGRnc0tsOUhXb0M1NE0waWpOMTha?=
 =?utf-8?B?QWt5T01aOVZsOHQ4QXRCZXIrZ1lkU2xPSnl4MmozNkRSQzloK0RlbGJaM2dR?=
 =?utf-8?B?VWhBVDY0SjI4MGE3TlpGWFh4cFpRUUNjcVRXUG00OWRTQS9UNHVoNHNJRitG?=
 =?utf-8?B?bVBRUmpuRy9xU2MzVXVnNGt1bWlMc3RVd2c0UHkvK2hJSEJYWmVMR2dzSCty?=
 =?utf-8?B?aWVyWWxZenppUlZXRjc1Z21IQ25aZEtHZEJLcEZQbFBodXVKall0TjNSalB5?=
 =?utf-8?B?UERmK3l2OG5BcXh4YWp2eldab2cySTl2Mnd2cGJDNHpUT1lHQ2cyQytFZGMy?=
 =?utf-8?B?WnliMGV6Q2FLNjd5ZWdPZnMxVUFxVjZ6MTZmSHI3bEpJaXlxQm11V1hOZlow?=
 =?utf-8?B?U3lqaGVPTm1LQzZ1ZDNBaGpjNldsTjRQWVZ3YXFQNEFONUZWZFVWQjNZdnlE?=
 =?utf-8?B?MlFUWWtlcnorWnloOWFDczhrMCthWjFTV0pydTVXa3ltUlNQL3BHa1pGNURv?=
 =?utf-8?B?U2ZjOWhrRnpqVVhLNkxWd2p5bDQzVXlFZko2V05URzlTQXJPdFpiOGxic0ha?=
 =?utf-8?B?STg4aWdld3lyeTVQd1F3cW1nVk9mRG95MDFIcXRXSnBRQjkxVXVBTFNpeGti?=
 =?utf-8?B?Qy8weG00Z0hjVHlsWU54TjNxblRnQkxtSEVaOWVLY3VBK1ZyYS9JWGhrYS94?=
 =?utf-8?B?SDBFQkNtdkUzMTIxVk9EN0lBZFc1dWY2N3lBZHZ1SXE4UVorQTl1NFk1NTRx?=
 =?utf-8?B?SGEyREFzN1J2YzRYaEphTXNuRGxyYzlIMW9OblU4c0hmYU00Zm1YaXBqZG5M?=
 =?utf-8?B?Z2hSQTNwVW1SMjMyejRwNU5zUFJlaVJLN3JzTGFFVS9uakNWaFpVRU5ubUtn?=
 =?utf-8?B?RVBsYm15WEZFZ0x5R3BYcjBZK04vbmMwS2hnMlFMSU1CeDRkeGJUSHpXUllk?=
 =?utf-8?B?UDlzZGxMbFNZVXF2QmxkSXYwK0xHYWpJR1poNmY1RGpLSFMwZERKbUNoT1hp?=
 =?utf-8?B?QmZpSnJ5MjlybnhMeWp6VGFlQlB1OWxmU1lEUTFDbHgrVWRMMzhKcjR3MEJx?=
 =?utf-8?B?MjVWa0ZtTTg4bGRHRThuN2RlSG9qQ2ZPYVEzVjI5aDl5a2k0VGFZVkUwdDBq?=
 =?utf-8?B?dU80MDdVRXFjQTB6dTh2R0hmaEx0cnhzTkt6M1dKM1R0dFB6WnNReVlieHRT?=
 =?utf-8?B?eEpkRlpGNk1HRjlnaEUvNXVad3pqM2E4dDR0RmxVNDF5bU1qUVVsZ085NGp1?=
 =?utf-8?B?OEJZczFVWmNObnpXczRxZ3lzY2ZmSGJKZ25MbTF6a1d4eTZXZXNQd25LZ1JU?=
 =?utf-8?B?VTlVSk9KN3V2dkpVZzQ5MmFFUWxZZmNaSjZhemFjdHR5amxKRFhzUitzRVJY?=
 =?utf-8?B?NG9ORisvaVNyb3JPbTNzZTNNaE5wbXRCeDJiclBFRnF1cVkwMjZTOXYxbExx?=
 =?utf-8?B?VEV6cG4yWFlOZFlQcDBYdVdaRytsVzJtSklKdVVoMG1ZK0lBVHg3VXIxRTZm?=
 =?utf-8?B?M3pQY2FXdE9HSWZpTjh4NmlJYWp6N3ZjcEppWENENnM4cEs2VGpwNTJhSVd2?=
 =?utf-8?B?L0RQbEZnc0FqME9EZFdNVndud1d5bS9FRGRZZE5UWDVyRCtEVFBYa2ZIQ1g1?=
 =?utf-8?B?WWZnTjZSMGRhM0ROd2N0U0dISGVzYzRzZzNkclJSNzE4enFvZWU3bm1DaTh5?=
 =?utf-8?B?bXZQN3FDSitnRW13YWNoV0J0SE91L0JiVzI5SHdJeWFxYXBjRzdLbnN2WWJ4?=
 =?utf-8?Q?94m417FFgY3R31QEj0IuACyC2JipccWU?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:57:25.1386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999ae0e3-f502-442d-c62a-08dcd3da782a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7885

OPT3002 is a Light-to-Digital Sensor by TI with support for wide-range
spectrum light.

Add the compatible string of opt3002.

Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
---
 Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
index 441e9343fc97..67ca8d08256a 100644
--- a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
+++ b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
@@ -15,7 +15,9 @@ description: |
 
 properties:
   compatible:
-    const: ti,opt3001
+    enum:
+      - ti,opt3001
+      - ti,opt3002
 
   reg:
     maxItems: 1

-- 
2.39.2


