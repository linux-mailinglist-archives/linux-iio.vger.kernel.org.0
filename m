Return-Path: <linux-iio+bounces-9184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EC396D5F1
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 12:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CCD1F20F56
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10402199FAE;
	Thu,  5 Sep 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="dsu9ug5D"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F71198E84;
	Thu,  5 Sep 2024 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531732; cv=fail; b=skZFvEexANQjgRU4kLtacuWD/O1jcjnYEyHVRRhjdrQLZ6GqhrSa6E0kOqbmxe1i+juSlZdwVp6mAwa7u0FBr4aRNqIpG8ITvBw8J5LaIo3/jXspEYZnLlvWj65I2RP0FEWmxJQT8dbhZmlvqyrUTLZpP7ovlkf6YgU6ZIQK9DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531732; c=relaxed/simple;
	bh=PqYmVbvOJjIxE/mAg1WOvj/StJBFjkky58zhTw68axo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DIVFdHzY7/ENCr2oLHswU62nq9lNxGAm/CerjyPAAgPSmbu7FIVWLQY9bKFbUzjUPbgYnbY1dhNzFR2GZcTtvCsPAcqgUEznjtQhoGbEmThQgbyGb2Ps3NtPQnxP3Q4flg5bfHEeaOd51Ro3vqioPzgjN7z9cYSqLiEh0PKseD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=dsu9ug5D; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUuLgsWF0RH0l60LxiGEhTN1R8sHH7nlm6rv6ini4/M0nyMyZyQZSXLClorTv53/ym+yEHnzCY9NKUUtw3lwBfNfUnkoTQUOSF32WsxVI/Xv40L2QTIHyj5gFZzr7kM3UabqZ3nMt4twPpWhBP0UZ201Og1QceYr8PpqUk0scAt/Qz/H7CDfPS5IRhLasUZuZGbpu7Cp8YwuZdvEBTfpphGdw8rzI49yKN1pNDl8DWiN/rNwqHqy0Bhb7Bh+LdtBCAHoTlYdmrHmjONTUz24yijwirsvRTkFmO3qDumO59LESO3YZ739SDmATq7Wo6JfibayJPzZ7NXlEzZ8V80/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sg6/CdlXmuw8dHFGDmiG/XCQx3ATVLvzpe8lXIcpsww=;
 b=Sd2XaDEsqg+g5TqogccPAmnVtHSMiF+B2MkTC9KyIzDf8ei/tIuIdfPjCNrf8t/zAgFid6B53g/bUmHu2QqpAW4jrBreycuvhyjeoo7IZev8VY6z4U3jGSApB4R5zqkX0ePyUldT+vGjC+EAkLQmd01hurRzI6/w7k3Q1jmpt3XuCCWZFQWCXfLRim9AMF5EXAhWpPNVf4KP9du1xOHs0N3GayKw4SLJLiwZbSBEUCzpGzWItS8P5pmZwM4VmaA+WPUr3b2Hn2vDuTaGxFSG1AJycy6zCQTZb+5+0nTOGtbiqfk9dREI/SK5barbmqWfjta7KzXvj8n71vx/vMVnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg6/CdlXmuw8dHFGDmiG/XCQx3ATVLvzpe8lXIcpsww=;
 b=dsu9ug5Da2phMyQi13UasZHn3z46ZStZu8sVqIxiOoVlyBGL3L9IsM85/DaeAWCzZ/8mvKKUdtuHoO0/RB9aJPbNqvhVCMAdys1v3C0MgtfV1Hj/7ot0rREAHumCxviBK/s3Rt65z4cOsm2sAiNxwtTLHkptJd3CR+QApf3x6II=
Received: from DU2PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:10:234::23)
 by GV1PR02MB8561.eurprd02.prod.outlook.com (2603:10a6:150:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 10:22:04 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::23) by DU2PR04CA0048.outlook.office365.com
 (2603:10a6:10:234::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 10:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 10:22:02 +0000
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
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 5BC3C49C;
	Thu,  5 Sep 2024 12:22:00 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id 59BC82312A73; Thu,  5 Sep 2024 12:22:00 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Date: Thu, 5 Sep 2024 12:20:47 +0200
Subject: [PATCH 3/3] dt-bindings: iio: light: opt3001: add compatible for
 opt3002
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-add_opt3002-v1-3-a5ae21b924fb@axis.com>
References: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
In-Reply-To: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C3:EE_|GV1PR02MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b951a5-1794-4254-d225-08dccd9495b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXorTnlKazZjQUFadUlXb3hsYjdDd28wM2hTL2FJM3Q4MThzd0V5VHc3RnV5?=
 =?utf-8?B?dys4UU1kbU15MHc5NTBXQjhTQ1hManFManFVL3dBY0hUeDBMdnFaakxWUU1z?=
 =?utf-8?B?eVNLR2xCR0daK0QxbDdOaE5qTEF2OTNHYXRIOXh2VkRMaXVzYkVYSDVUaXdV?=
 =?utf-8?B?aFJYMGtKdU5JKzVJNnV6Qk5rQk5KTkp5Rk11ZnRZNFNURGNFQ0ZCcFpzYXhh?=
 =?utf-8?B?M3VERDdFcEphTUdXWVBjdmlzUDhJY2lnU2hiSENpQlpqSjhFQVFkUlNmU0l0?=
 =?utf-8?B?L3UwenNhekZpVlF1Mm1KalEwbnZONXlBUENvT21HNkNQVmFkUzlyYVByelVJ?=
 =?utf-8?B?R21IVkg5eUtLS1FxWGtaS01aYzJqWE9HZ0ptSEpORlhhTFJYdUlaTDlWSnE0?=
 =?utf-8?B?ek9jcVYvcWl6MXpOc21obFpHN0tzRm1YbG0ybVZkbVNWYXJkOEpHeU9nRlVE?=
 =?utf-8?B?dWpaaGgyVGh5Nm9nTEl2UHVKVHF4TEp6UWJvcXMrMnBmYWx3NGU5UU9JSUdq?=
 =?utf-8?B?N0VTMzMwUytuSzl2cnRReTlHMEFCOVNKNFBvMlQyTUM2YnViVmNwM2RaQzVL?=
 =?utf-8?B?M3lvRHp1b3pjeXRtanFkMVR1cDJFV3FaR1gwSTNlc1MyUVFHaWFqRVNsMTho?=
 =?utf-8?B?WjR5RFJVMDNTM3ZwU0pyVWszcnQzWmtMaDE1MnRBUDkzMndmQkVzU0ZEczFm?=
 =?utf-8?B?S3pIalZnNWI1QjVOOXpQTlgvTDBCL1JDblJTMmtaNnJTaFZlS2tGR0Nud0M3?=
 =?utf-8?B?R3pXZW96cVliOXJ3NWg0dVZIdmRTcjBEcElzb0JEblpuWHVHMDRwdmRUbi9M?=
 =?utf-8?B?UEJPU0RZcDRFUFpmdjEwQTQ4dWtuek1yV29iYmhQa0NRbVRKWTNBNC9OTDAr?=
 =?utf-8?B?OEZNZnRXMTQxLytDeVVVbTdvelQ3VWFFWnlwMjVYQlRYcGwzUHVBMzBTS3lN?=
 =?utf-8?B?RlEycEVjVmRPdU9oRjRETHJOaThTTDRRUkVJR3BLTmV5TWNkK3IwUCtPM0JK?=
 =?utf-8?B?NnhacjRjaVBvWGxlak85RlZCc1EzUVdTd1QrZU5sOVdyeXk0NitCSlF1Q2F5?=
 =?utf-8?B?Yk85SDdjajE0ZktlVmdacnZWSUdoanZoS3VRZjZ1ZHd2aE80SklBb29zd1Nt?=
 =?utf-8?B?TUxSWUgvQ1I5Q2dNbUlPTVRVNHltNzBkWlN2QzQ3bnBGbXROZUZpU1hldSts?=
 =?utf-8?B?RGlvcTdrSUFkcktxWUxzOExHV0N3TnNjblNaVkVhTTZESXZRNUNBeDlKQk1u?=
 =?utf-8?B?cVkxcEFSb2VaUEhsL01wQzQ0Wkxld3M2KzlsZ05VRTV0dTVoVmNwVlpqQnZw?=
 =?utf-8?B?MWpidFFXNWVobUs4WitaYjB5QzVlVHRKQVFOcitOc1dxWW9jaDZ0bVNoRzB2?=
 =?utf-8?B?SEQzSzNRUWFCa3FwdVowdC9DK1gvUmxYdGwyMmsxaXBBZmJXMXRvU2MxdHp6?=
 =?utf-8?B?LzFtYlNzRmUrMnQ1b3c4SzhKVVRDc0kxRVNaczlHM2FDWEQ4OGJTNjYzemdl?=
 =?utf-8?B?VE5JVTRTZGpONi8veXZFT2ZvTW1xNHI1L0pRWU5vVnpDQ3VsSnFlZ0pRMGhn?=
 =?utf-8?B?TzNCL2dib0o5YWNGZm8zZlFmNFNHSG9HUm40UVRUdmUwODU2N1YrSXgySGhV?=
 =?utf-8?B?ZWsyelRBejlzdG9qaUtqVjArdUU1S21tM0wxWmZSY1h0a0ozNWhFYTRMWXl1?=
 =?utf-8?B?M01scU5vQnYrN2pzNzBKenhRMStqaHptRlJzZldObHVRYldWWTIxVFBDdDRI?=
 =?utf-8?B?T0RORTd2WjRWTmRzQmRHblR6bXhPNUlFNjdMWXVFeG4rUys3NS9kbStKWmc2?=
 =?utf-8?B?eU1MS1hqYjV5SUdzZEhibjZJanczbGxNcWZSd1Nxd2E3c1JWckJocFdQVnBs?=
 =?utf-8?B?Z1NNSWhkZTdHNGF2QmdwZEp4dXN0RkFOQXluTk5NV1BqeUpVeFF0Ty9sQTdl?=
 =?utf-8?Q?VyHlh7XJBdH21Yze6fyHXbjHO9A6J1s3?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 10:22:02.9717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b951a5-1794-4254-d225-08dccd9495b5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8561

OPT3002 is a Light-to-Digital Sensor by TI with support for wide-range
spectrum light.
Add the compatible string of opt3002 to the existing list.

Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
---
 Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
index 441e9343fc97..7a48a06968ca 100644
--- a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
+++ b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
@@ -16,6 +16,7 @@ description: |
 properties:
   compatible:
     const: ti,opt3001
+    const: ti,opt3002
 
   reg:
     maxItems: 1

-- 
2.39.2


