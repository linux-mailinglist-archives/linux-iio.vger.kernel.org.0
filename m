Return-Path: <linux-iio+bounces-10037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CD498EF27
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 14:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7DF1F20FE1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD80717ADFA;
	Thu,  3 Oct 2024 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="rpsVljCS"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90177170853;
	Thu,  3 Oct 2024 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958193; cv=fail; b=OpINruh1Ic29HUQcxlNb7ayqr9Xk9S4LTerkD6HbZ1pQLd+rn7zuRi9C7TiLHbPKOfy0GfxnUUfbvtIOEIWBvcpVEYrYxsH3ZW8iPscfKGPDfV+3yLyXRPPG60V6ojMR0VpmQklMHy9XAxOf2N8h07G4Flk8hmzlPGuOySjeD7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958193; c=relaxed/simple;
	bh=9irxaHnFv2UpgpDc00MJVKNvSgpTu1IyNGZAHUTreDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kWcVsS5bSelLRzw/PJPQlH9scQPFBC89htJf0CLl1KSjQ5M7eqT9WroFgnGOWEj9C/jN7rlW+led+9V38VTWwFPjS5jT4KmjKp2iGWSnRNkn6sFCr1kX6B9Qjjkh0tpELQ0ZRix8L22V+28A9fn75YBlk5eNirN3sZSy1I5y8Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=rpsVljCS; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNexTiR+W02WBx5bMaY06Ft1Eea7QwnnICch4q2NX37eBbqzBH88vHULz+d878T8nCooO5PR/5mpzCVLvtGIJeMku0UfFQ+Pfe/HAK3GeWsmmJlQ3BxOx9xoHWgTghZ7k21Ud1bnXBYFRqyR+he1HLKRnFP19bJTuehd0Pdp0hWLkStWUz6VBzRuvQLGHM/U74KnvWI64crXU1+N9AZKr/RDMTi7NLoXz7cmt77vkLT4EDGyewPWbMtzY23Z8JrTnwLFPnboi3CA+8JnN5uAAQMMBEwMMuDhhe4HfARlOCiXHlkbz/oFAwgG5lXLI9knRYimpto+QXe9ox29OnaOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwU8dVVzfOYrhhZkIqBbni6UPpKR8xW8KS40/uNpvE4=;
 b=IqrEdVt8nDfhGI16+hywUV0FaKJl1bnoqzNKgyneMmYVGAIigtCvx6NQASZorJF3lHS7yFaEjNhMxxfwgk1U3GXGfgzWrST+vjEQfDL0fjDwQGAdcxwwQJqSydWoqa9V1issfucaJuluoAwa82ZZ1UUlLgOpw0OMcbnsTZz/fKt2but7SA1MJfimaseBl+f4EpXDu6T+MQmDTCWpfZ3lzraXqXNbvrcHB+o8/30N2v4XUDX7dtYuRRM5ZhY9g4NE2oMR0wLkB9N/aJauOLejYV1M2eInMP+ISvdVf4Odl3Vi3YaJc9kICnAqQ3fK7Ou616b7wRK5OdVA0FCSJvNvGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwU8dVVzfOYrhhZkIqBbni6UPpKR8xW8KS40/uNpvE4=;
 b=rpsVljCSHWYb10rUZVKuM/RHWD9+xpdEzm7H+oV4ZmAZzlGs+9+01x8rP7PPSl2QsvgPU1BqGDfbS1uyL1TX33zMtE4EgluPFQVnjX9mELoccReKLvv8RRVq/yh7pTAl4OZ83TdBggGMJOJZmI7co0vsnTRE2ZGK5jHJARP2EsM=
Received: from DUZPR01CA0225.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::22) by GV2PR02MB8673.eurprd02.prod.outlook.com
 (2603:10a6:150:78::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 12:23:04 +0000
Received: from DB3PEPF00008859.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::3d) by DUZPR01CA0225.outlook.office365.com
 (2603:10a6:10:4b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 12:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB3PEPF00008859.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 12:23:04 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 14:23:03 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 14:23:03 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 5788D3E9;
	Thu,  3 Oct 2024 14:23:03 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id 515892376CCA; Thu,  3 Oct 2024 14:23:03 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Date: Thu, 3 Oct 2024 14:22:16 +0200
Subject: [PATCH v4 1/2] dt-bindings: iio: light: opt3001: add compatible
 for opt3002
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241003-add_opt3002-v4-1-c550dc4591b4@axis.com>
References: <20241003-add_opt3002-v4-0-c550dc4591b4@axis.com>
In-Reply-To: <20241003-add_opt3002-v4-0-c550dc4591b4@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008859:EE_|GV2PR02MB8673:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aed882e-df96-4ffd-47db-08dce3a62183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aitLNlVzaklXNzBsQWNVVUpkMHk1TFhZeWJIV2RMbFFHWUJranRjaHpLaHo3?=
 =?utf-8?B?U3pwdDM1NTFyYTErWW1OcnVIWjlUWWd5L29nSlh3aFRpeEJxL01XOFNWMXZi?=
 =?utf-8?B?eElVR1FJak1XTmtybk1aYS9JQVFRNGhDY3lpMjdGU3FTSGFaU0k4OCt6cWhh?=
 =?utf-8?B?MkI4VDZHV3NRazFPK0V2MjJJcHk5Y2xQN3p2LzdFQ2pWWVVvNkpSa3pLTG8v?=
 =?utf-8?B?QitKM0h2bDdhQUU2KzNIZ3NENTJYcW9HRUJJVGNzbzFDMEorZ2t6d1lKWUV2?=
 =?utf-8?B?ZjZPbUp3cU1SZ1FnVlBadllZR0dnTWFCRkF0eG45YktXMUkySnRCQmlLZkpy?=
 =?utf-8?B?WXhTSTNiVWtxemJ5dkJEOHNZVGR6aDk0bnJ5cEVoK0k5Y1Qyd0tJR0FTZGZy?=
 =?utf-8?B?eHhRUm1YdUtNOXpJY3dNVW8zc1MrUFhqcHJSeUNDSmR3ZUJNTFhrcTJHN2N1?=
 =?utf-8?B?Vy94VWxMcTF1cTVqSDBSMmdKR3RtM25JZGVJQTdicW1TSllEMDIwL0piOFNs?=
 =?utf-8?B?aDdWckJocFhWTjJrOEV5b2tPb0tORXkwVnJGZE9DbmptVmpkZ2FkSHR0SHQ1?=
 =?utf-8?B?dHJ0VDRUNHcvczhmbmlKWDY0clV6dFFnZHlDczZMT25TU05vRFhrR0N1d3VC?=
 =?utf-8?B?Yk8wUFEvclZoUUZHOGlLODQ1YjBhdFBxakhiVHpoM0RiVjFjOHZwVm1ZY3ZV?=
 =?utf-8?B?RmpJRW0vYkpmemNLUkYwSUh2UHVxRkF0YzZsbGxRSE5JS0tCS2FXSXFHQmJV?=
 =?utf-8?B?cnB1bjA1bEdkdlVGcW1hWUs2SGNrUzdDeDUzMTB6MlZVWkI2eXBrM1FVeENm?=
 =?utf-8?B?bmtuVFdLaEhZMUxpTnB2TGdRRXV0alFpV0hyWk1VYTNPdGhDa0F4QlpNSk5Z?=
 =?utf-8?B?UDMxSFk1L0xRRnBac2RGUUZSTGhYejRRMjhhenBNMlE5am5RRDhMY0V0bHNw?=
 =?utf-8?B?ZjVSSExSYkp0ZFErTmNaL2I1NXF6SEYvcG42Q0dicXBZaHNPczJMaERMZ2o4?=
 =?utf-8?B?ZnhwSmNMRHNoRk9mSmozRHVoUVpkM2FhYnVpd0FaSGZrcmNydU5qdlkwMmhU?=
 =?utf-8?B?RVlwSDhqVEU1aFJOdFBDRDdveUZIdGxVZlVZS0ptdTJGNkNnTUdsT0E4cTZS?=
 =?utf-8?B?bXA2SE9lUjRZUlFvVWZIR1doM0g5UExON01pcnN1OEs3OE1UdlRlcmtGenN6?=
 =?utf-8?B?RjZyenpxMGs5MkdKeVk5S0JZNndBVnBjOFA0NHVxQkNPWjhFWXEvcnF2ZFVi?=
 =?utf-8?B?T3I3OEx3ZjJZK2NYQzZ6KzF2Q1cyWUtXUjRoblZ6WFlsOVFJT3JncG5ieTBx?=
 =?utf-8?B?K3NoYXFTZ3NJRWdTeFhubFN4Q3VoM3RMRnBxMTZmdHNpdTArelg1YktuNm93?=
 =?utf-8?B?bGVrdUttTDQ3b3gxUFZyUmhvYW1GZDI3ZkFQeE5PWnQ5V2ZuR2hVc1BTT1VM?=
 =?utf-8?B?a0ZZWW5odkJNL1lFV21JK0ZjL05hNjF2alpzb1JWdmRWYy9NN2J4d2xjR1Y2?=
 =?utf-8?B?dk9QeGlreFcrWDVXQ3VtaUlSZStiVTF0NzZNK3IwWTRmaVd0RHpScUZCQTd6?=
 =?utf-8?B?dG5YZnQrUWtqSGZkTHhnQ1BVak5ZaDJCZC9Sa2pvbTFSdTY2a29TMW9VbGhG?=
 =?utf-8?B?eVFoTkRMU2locVFSdzRKbGNBNFgzSTBxZ092dUVhWmg4SzJWZXZuUWQxWXkx?=
 =?utf-8?B?a29iM3BScFFBQnZOOHN5Z1c4bHdEWmwzZ2taSC9ha0dYUUdMQS91OEF1cUtM?=
 =?utf-8?B?dHEyODl3WUgzelkxekdGUXNuYSs4MnlpVWpBTnc3U1loMWhUY0JpL1F1QnJX?=
 =?utf-8?B?ai91SlE0UitxdE5QQk81SWZJT1JnK0c3SEV3NEFGOWQwcGt1b2dzWENkMyty?=
 =?utf-8?Q?46kNl3V1pBl9M?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 12:23:04.5470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aed882e-df96-4ffd-47db-08dce3a62183
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8673

The opt3002 is a Light-to-Digital Sensor by TI with support for wide-range
spectrum light. It shares most properties with their opt3001 model with
the exception of having a wide spectral bandwidth, ranging from 300 nm
to 1000 nm.

Add the compatible string of opt3002.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


