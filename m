Return-Path: <linux-iio+bounces-9183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC5396D5EF
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 12:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08F91C2537A
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CAD199EA3;
	Thu,  5 Sep 2024 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="P7GUgRhZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013025.outbound.protection.outlook.com [52.101.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9C196446;
	Thu,  5 Sep 2024 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531732; cv=fail; b=meGIib124VZHks8HoZOC3Q8c8uXOpTjVqXp3dFpo0H4bWJUY5jSAPu+Hm7znFfi3LwauQltYHtMvzdOhWdPQgNmV/uhB40onnOGNVsx9SOXdE/ZVzRZFhJPQx6wB+uRMnPR7cmPU5K8ZFW/LhIs7WHiQe0dJWejjuSjeWdsoYzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531732; c=relaxed/simple;
	bh=e8bAGsPEtbX/2sH6fK0tNnQ7saNbqAcFJjOQWDkvMRE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=a9t4xW56pTDKTZaAVYJN2ArybQqnXZoKdcLdIg6p8+cn2w4h31nIItxDt/iHehalJHr6n3VSt3KXAFYKcy+QKmoJduiwArqTBUbhJ1c/JB+jNR1oOeg/HD2+uQYQSgvjz9UoSZnw7cJuEB4jqsOkCvaz5tNA+q4Wu4w4UJtn1P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=P7GUgRhZ; arc=fail smtp.client-ip=52.101.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5j50RCU2N4LXVhcSafwigD776bo3U13da10q5voG72DJnIgzpgqbHe0zBDcMjgqtiCqf3xrBnA95rA3VCLHiMIrhbXgJECD4So6UJSWpM8LGkTZlrwLIgOgcn1No5HBzOslvyXQRLSbe6KnoRGNd4O8gXEY8itB2lqtkYFvGOFmGmUenPbsoQXn0hYhyF23Iq8GC1WZxx7hHk6LAtS+Y4Ob4MYjgt6DwZfcvqv61rGUehKkJhOtapaon1GRjNkaQ6F6Ew8MkixoQv2Qn6vqMNb67ZuzarJXLWgwX+nSOO/869x+bKqeWPB9wTpqJs/MjNmAfsMPcjVpSQaQFIyU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbkL1a26yzpYje3aWdEy0vvOBuLiKI+l/UCjrbzCihk=;
 b=LbHL5fPmt4SCUcUalJLyq2Jzq6KXwG6YtVVPWKqI1L1ojSuN28uuGHGp8aj+GJDv1SWrpNcnOjdEv520tTKu2/9TKr3KBYRL82byWX4dqHA7ma0RzE8yDudCcEIUvIqfbieARzrk5vlbfnVCm10NcJm5FtrO6NxAidBJUFUJAdrVPrl+WVpZ/UeGmP5rdIwVrLErKEKX+w8qj6CzHqkwzmnGwOW/MAZ0qro4vhdxnD8JUEQZzGUFVZ73217cb/U7UfrbWtPZ38ZNfL4QVGEeJVfJBBvu2cxEmcpR9W7aRTsx3If7psUrUJ0W/2qSSACO4r+a1oO7MwceB1U+pH7LJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbkL1a26yzpYje3aWdEy0vvOBuLiKI+l/UCjrbzCihk=;
 b=P7GUgRhZDL0nNgPq6KMp4Gspv+Sv9Xscj4Wv5nkxrx+Rl84F+Nh4bsv+mv/pngaO7LQT8Xm5vOJJBRIeEWu5Xw0QTb7HvJHYx9bOnZes7KFO00ar4p8d3KF2hgkpBvWkVp6EcI7LGF21lRtnPWTziwl1abHxRLVixXocgGAehCU=
Received: from DU2PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:10:234::23)
 by AM9PR02MB7106.eurprd02.prod.outlook.com (2603:10a6:20b:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 10:22:05 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::c5) by DU2PR04CA0048.outlook.office365.com
 (2603:10a6:10:234::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 10:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 10:22:05 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 12:22:00 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 12:22:00 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Sep 2024 12:22:00 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 578B1126;
	Thu,  5 Sep 2024 12:22:00 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id 5465E22FBCF7; Thu,  5 Sep 2024 12:22:00 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Subject: [PATCH 0/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Date: Thu, 5 Sep 2024 12:20:44 +0200
Message-ID: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPyF2WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyML3cSUlPj8ghJjAwMjXRMDU1OjZMNEozRzcyWgjoKi1LTMCrBp0bG
 1tQBHAzRTXQAAAA==
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C3:EE_|AM9PR02MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e544dc-d3e8-4ca8-e6d0-08dccd94974f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1QyNXpiN2pTMkxHTWhBdjF3cUZDR2FuajJYbDN4bit1VXF4Qkpwa0QxMzhj?=
 =?utf-8?B?S09MZy9HcU5QbGFRRzQvWDMybTRIRy9Pcis4c3FGUnJnekg1RE1zd3FPYlZr?=
 =?utf-8?B?MWtwMVJxZ2czUzdFU1lPaStrNEVxSWltWWlOT242K05laHlrL1NyUDh3ZFpP?=
 =?utf-8?B?azNMUk1PWVcrZzdEcEl6aFdoVnFZMEFSVzlRU1VLTHZHdkhkb1h1TVNacWZH?=
 =?utf-8?B?bDM3aUd2aDhaQ09penArT1EyYVE2KzNaaGx4dFVOOEo1WkhicktGYXFvUVIz?=
 =?utf-8?B?OGcyeGJocjE5OWRrL0c2c0ZrNzY4Rll5c1I2dkNwMjJacXpSVDcybmlBcjRY?=
 =?utf-8?B?MUxiNzN1ZDVXbnc0bStyaW5yQjFQaXRlWk0wbHZseHdzaDZMeDdSQmNXUEdB?=
 =?utf-8?B?RHFMVjNVSHBLU1MvaEF4dEhSVTZPdmF4cmlOWkhIbFFmcG5CRUpER25oODN3?=
 =?utf-8?B?dW8wS2NzN2RZTnJnSmt4bHBCZnllYU1rYlFDbURPdEk0bFJQZDdCSkRYMzBp?=
 =?utf-8?B?LzczRWlSa2RaajNMbUVubEtWUGRzN2JkSTNMa3haelNhWVUxT0tLdEd3SUtL?=
 =?utf-8?B?SHpMaytKNUE4ckZYRzdCcm5oZ2hhNTlaSmdNS1dkWmN0TDdGTTAvMTQySkFJ?=
 =?utf-8?B?YWR4WnRPOXlRd3FMNlFjbEFCMTNjVmt1SytBTGZ0RU9sNkdybzdqMERobWdS?=
 =?utf-8?B?Rlg4SCtkL3dDNXJJaW1xV1dpMGxDaEhTRWIyNjV4QU9LUmRZYktRamxOam0v?=
 =?utf-8?B?WnFlMjF5T0FZNks0QUdyejkzZy8zQWQzS0tqRXVJYzZFWmlXMXJHMHFwWUht?=
 =?utf-8?B?bU5GZi80WVJ0YlA5Y0tTTmlEWWxFcnFvVUZxSmhOekFncEtRcUE3Vld4SXNG?=
 =?utf-8?B?REtlNjJyNXQyN3I2b0dkZ2VnTmhhN0E4Rzg4MFBRUjcvSDJMdDIzNnVyZFl5?=
 =?utf-8?B?dlNZNWIxOWZ0NjJNeEY5bDhLSGhmYzA3RmtVVEdTZkhROGVKbkozcU1OS2hS?=
 =?utf-8?B?eC9MNXNJK2tzL3RjUHJMQ2tDdktUVjRkd091dGcxbnpKcmcwc2lqTkxwdWZt?=
 =?utf-8?B?SStINkdDb25aQjkxMUwvY0xlMFNRMktIb3RuekdheENia2F4ZHloWEl2WFox?=
 =?utf-8?B?SVlmOGdXR1N3REp0Zjdaa2tVaDM4WDVpNTIweGwvN2VoRC95Wk5HQnpVeXlj?=
 =?utf-8?B?ZEN4MUNwZVZESHR4ajJPWVdVaGM4ZUlZOWg5dnREYWpyR05DMlduVCtCNUVJ?=
 =?utf-8?B?QVQ1K0kxcE1wSWZTMktNVi9WanlJRFNLbGZ6cmErc2dwQm54Z0I0RStOWUMy?=
 =?utf-8?B?MXpXR2RHUVczWG5VWDBoV3Q0WjRXbjhBem5JbjJoQkRIeVI2ZktxckhKMHpQ?=
 =?utf-8?B?clFqbG1ScmJrUW44UEljWFRtaG9VL0V6MU1lKzB1aWxxWkIxUXg1SXU1WnZW?=
 =?utf-8?B?R2NXNnQ2WEJTb3VpWjRxY0lBK0k4U1g3bldRbGFvdmFEZmkySkxlVmZkVklG?=
 =?utf-8?B?L3dpSkVhcTdXQXlsT3Z4dXd2eFBSZ2NTdE5SMWdsTUpGV2g3amwxdndKUXJu?=
 =?utf-8?B?ei9SY2NPa1JpQUROUzJXWTBYT0ZNcnMyRG1zc2xRMVhNd051MVlxZ3FNd0p6?=
 =?utf-8?B?T3ZpelhGMyt3Z0hqQnB2OTJud2RoVG1pVXkwa0xNM1NpemZEQkZNdEUwaUtK?=
 =?utf-8?B?VTN0Yjd2dFFMalRhU0l3dSt5ak5hRnBidzBlODB5dXpSRndIR1ZnNGorOXNE?=
 =?utf-8?B?VHYzL2xIZ1NRSVhsamZCbVcrK25Sc05QYWE2MnJzQjF1WFpxck9GRi94azR3?=
 =?utf-8?B?bUJFUXl0MXJKUDNBU3FWQnpvRUZnSWJZWGJFMHhJMjJuQkRab1l2OXZTNnRI?=
 =?utf-8?B?a0l3WUxZT1JzajBIWWptcjA1R3YrTEo3UHdvdVdaZzd6UVRkMDY4SHRsTlhi?=
 =?utf-8?Q?W7RGPJnx07x+clSXQAJun8NcEqkY3X69?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 10:22:05.6592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e544dc-d3e8-4ca8-e6d0-08dccd94974f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7106

TI's opt3002 light-to-digital sensor provides the functionality
of an optical power meter within a single device. It shares a lot of
similarities with their opt3001 model but has a wide spectral bandwidth,
ranging from 300 nm to 1000 nm.

This patch set adds support for the TI opt3002 by extending the opt3001
driver. In addition, a missing full-scale range value for the opt3001 is
added, resulting in higher precision when setting event trigger values.

See http://www.ti.com/product/OPT3002 for more information.

Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
---
Emil Gedenryd (3):
      iio: light: opt3001: add missing full-scale range value
      iio: light: opt3001: add support for TI's opt3002 light sensor
      dt-bindings: iio: light: opt3001: add compatible for opt3002

 .../devicetree/bindings/iio/light/ti,opt3001.yaml  |   1 +
 drivers/iio/light/Kconfig                          |   2 +-
 drivers/iio/light/opt3001.c                        | 203 +++++++++++++++++----
 3 files changed, 172 insertions(+), 34 deletions(-)
---
base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
change-id: 20240828-add_opt3002-40552c1a2f77

Best regards,
-- 
Emil Gedenryd <emil.gedenryd@axis.com>


