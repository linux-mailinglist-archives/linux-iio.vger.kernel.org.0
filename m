Return-Path: <linux-iio+bounces-9616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FAA97A49C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 16:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8848B1F29044
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C62158874;
	Mon, 16 Sep 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="qNlyetGk"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013029.outbound.protection.outlook.com [52.101.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A1D15854A;
	Mon, 16 Sep 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498666; cv=fail; b=a9WuW6iebKMzb6fajtWcu10yCZtTZdCx8ZMFeYCc3qBv7G444FAjd2/VJwiek0JhvRqP7Xw8PVTB8nR4NiatIPGPVZpE7qFDwh8n/XOm59fLBLbVtcrLD/+FTETpBCifDXPSYpM0Nb7vgEKxo4keP2dcgjYuc+6thooLWU6kvb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498666; c=relaxed/simple;
	bh=kN7XJWOhir0lDzlnOM3MXSRCqy76IrHmZRMvMFxpIVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ra5nIHYH0Aq6c4nvR+qE4qxFsqkJOJa57S9DN/I3U3ddFP11uXi3k+A8bPn2Jcq1MTQ2hyfZCVcRPVzlHYe9VS9lk+2r9lXVqkVHF1LAOwwMAu49YTQ2eawqg58tjuUA6hP8z8LPH+qnkF/cXdIy141HDo3WrKjqo6d8VxK6sis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=qNlyetGk; arc=fail smtp.client-ip=52.101.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anzWpbEuC5y0TwXQuJuQuYv+NTs5oG0bBUiMHPj8GqE+Y3u8lZSIK3rH4BdnJ7ocAZMFtj78DLXv2Dc5912fhBQq9NWZ85/wkHa4l+Gz7OZYZoELvfEwx2Zjl3Y2//sr4pBvTHB3TWumcNKK6gOYMdcDR1BWuPLWBRy1KgmyuqERK5byaqGVBBV6tN2J3tjRr62C6HUtbem3hInIus95GQnTWUHUYEKlY3+PffQvgIzP7fSokaN6CJcfJd4tJK+uR+FqR/W60vqxZFOoFtetpHLRnX7HXL6SmBIxn0A2hFXreEPqVBdThA8WsRGtGjwQNVNkTjvSQU9v3mhNpx2ckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKZb30QSeG1aXMqTv+y/06EvS+uTSAi4qt1ctZg/1zM=;
 b=T9W37eQWh24x2PDOi4lowhTp7UQUXb4iMNZtNKLYabQcBfhrld7M9XnBBxKNXkzroy4aGd16enjPKcqg3vuOvRTTtBlYKgo/NPY5KArUjzCCzVNZpVICyYZSQsi7WbDI2wXGmV0iGa/wDSRvwntp05fljNCvrknS3mkbh90ssadV2J1ieVK00J1vunDGNQD9l031gJQhU2BRG34T4XUzV6gtBSJ7M+NWSF7SNvADIOIwaMh5FTUwhtVt67Xfw45ORgl8bgFKhoX8KAw0kAGgyzN4fu+45RDT+BTOGTc8qjccklkYDRJmiXDFtDADf/iyipsj+RwekOlVIlb7Mm2Wlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKZb30QSeG1aXMqTv+y/06EvS+uTSAi4qt1ctZg/1zM=;
 b=qNlyetGkOASX4kBkZUtYB7i2uywkfYrI502lLCeBRNw7LGkzchNX1qmwyUQRB3jhpGmyGOEM0BJ8U46BeONfND/edtNfzhRlCJU3HY/C4RjFS5hZAH+dqS+1MRcFm5sRSez/nqdCwd3Xf1h65JTKZXyWep2Jl+5SHSS07kMHJNw=
Received: from AS9PR06CA0681.eurprd06.prod.outlook.com (2603:10a6:20b:49c::26)
 by VI1PR02MB6269.eurprd02.prod.outlook.com (2603:10a6:800:19f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 14:57:40 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:20b:49c:cafe::d2) by AS9PR06CA0681.outlook.office365.com
 (2603:10a6:20b:49c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 14:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 14:57:40 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 16:57:37 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 16:57:37 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Sep 2024 16:57:37 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 5194F10B;
	Mon, 16 Sep 2024 16:57:37 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id 4EC7522FBD56; Mon, 16 Sep 2024 16:57:37 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Date: Mon, 16 Sep 2024 16:56:38 +0200
Subject: [PATCH v3 2/3] dt-bindings: iio: light: opt3001: add compatible
 for opt3002
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240916-add_opt3002-v3-2-984b190cd68c@axis.com>
References: <20240916-add_opt3002-v3-0-984b190cd68c@axis.com>
In-Reply-To: <20240916-add_opt3002-v3-0-984b190cd68c@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DE:EE_|VI1PR02MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7c0c58-6d20-4516-bd43-08dcd65fe950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzFlNnlqd2hiekFJMHNrYlZaV0N2cnduOFZRdld4b0V4bERabEtHam5kVzhR?=
 =?utf-8?B?Q0ZrL1hHWkx1VTJMMm1QZUxIQ00xb0VMVldhcFU1eExWWG5CdDJFcGt1TDlp?=
 =?utf-8?B?L29Fdk96SGVxdUNhOGtkOE44anJLVEhTSjBHTVpjYzZQRW5ad2hvZHJ0WEtC?=
 =?utf-8?B?dEp2blRvaWF2WCtTYXlON3NPdmNTZmd3SVYveEVZWXltdmRHYTBmZnp4TVM1?=
 =?utf-8?B?NU1UR3oyK1duMFQ0SThMcmp5RVBiVUV2TUg1Z01SaUlrbHVMbHVvRXZ6eXVT?=
 =?utf-8?B?RHIxdGRBMnV1Q2RCN0JyYkhweFZ6N3NLL1ovOWVJbGdBbnVlTDd5SWM1RTRO?=
 =?utf-8?B?ZGFpUHdieVBsb1BaUFdWUEExMmhSdEVJK09yd2ZFczV0c2ZITFlLM0hDT2FF?=
 =?utf-8?B?anBnUUtZZm1YN3lBNWpHRlJDRVQwdjYxeVFLemFLTWczd2FzQjV5WEZPemt2?=
 =?utf-8?B?MHEwT0tPR3JSbUQ0VDlReU5JVE9VYnA4WkpDZSt2bGZFS2xGMHN2Q3dxSCt4?=
 =?utf-8?B?ZHJ3VFZnNkR0RTNITlNUMXBQWjE5OHpodEtNQVFDaDB4NkVwdTVOaktsLzVN?=
 =?utf-8?B?UGRvd1VjMkZiTVN2UENDVGFkYTUzcWNIWE9JRzVBL3YyZlhZQkR1d2lSclhD?=
 =?utf-8?B?WGdQN0NMWUVQTjhzcWR4VStZV3J3TDhCbDE3ZTZMTU9tZE1QbnYrYTB0b0tu?=
 =?utf-8?B?MEVqZmRIQ3VhU3BzT2Z5RnlEWEFzMzJSdFNHMjAwaURHcVdhWjZxNHVWd28r?=
 =?utf-8?B?emNnU0hvOUdOQ3lLS3VHT2RKaXlGSDlmZXcxa1duNkZ4dHN4N25JcXkrcWJR?=
 =?utf-8?B?U2VuNEowUEIwVkhmN1pYR1VKMGVlQVBZaWJiQ1RpWkROUGhEa3Qvd0dlNFo1?=
 =?utf-8?B?OHp5RTY5OFpkY0V6cEFCTHBZeHJJTlk5eXc3TnY2OUxFdURwN3VjcVR5c2JS?=
 =?utf-8?B?TmF5ckdpVXBFWTM5akR3QkJSQzBRK3JoaWtQbWdRWVROOS9pU2pnRzVvNEZC?=
 =?utf-8?B?dzlld09TSjVNcjdLOWxqZkcrWUNBUTE3VzhWT2htWkxrSVRyK09OMWJIdzBl?=
 =?utf-8?B?dFlTWUp2YVZrYm5iRHQyajFtdHoycFJOS3RzbnE0S2s0V3NEZ2wxQlhaZGw2?=
 =?utf-8?B?c004aWEvU2tqY0pIS29FK09vQnhNSC9teEFmMjJ6NG1NQVI5ZVJwam5DUzkz?=
 =?utf-8?B?cDRIVEl4MXFYVGc3YW4yZVN6NmRnTGhTZ1ZpcUdBS2Y3WGVmR3ZxRnVJSHlX?=
 =?utf-8?B?aWdEUEdwVkFCNFBPQ3dhcExXcGVUZEhjWG5HWERSU2dWVUgwYjgwQTZ0QWNY?=
 =?utf-8?B?Rk8xeVRGc3p2TUFRMnhBZmJlb3NKaUJwd3A4ZDRUQjg3UVd5UmtzK1ZucHJ1?=
 =?utf-8?B?aUJWOUh1UDlHeVk4TUJBL2JJVXUvdk9QeERBK045MUlueVY2KzQ2dUU3NGZ5?=
 =?utf-8?B?cHpjVlZTczN4YXN0RnM5SVVKaE80NE5kbHVGeUF1OWxwc21lUjlBWExMVEJL?=
 =?utf-8?B?aUE3REZqUHNsQk9CTnpLNGgvQ2RTb1JuekxoNHV0QjFndE9kWFBxQ1RScGZl?=
 =?utf-8?B?dWttcERuT0R1WGpsVEhvS25jV0FuVVYzV2kwRE9PSlpLayt5ajF6aEIzeUhR?=
 =?utf-8?B?Q0o5eGJ1em5rcG5oVXZ4UkZwOHhpN1orRU9kVksrVEVEYmpaWjJVbEVpOEFP?=
 =?utf-8?B?NUFoeWIvL1FsWmJudUlrSEFTbHZPaWVYemtGK3M2SHlxNzBIT3psMlFFUU1J?=
 =?utf-8?B?Q2g3USs5RDJVK3N6bk5KdU5GcFErbGhVamZXcWJpWUV2Z3JHdGs5TUl3NmM1?=
 =?utf-8?B?NW42dXhrZkFqR0ppa05tZmw1SC9pdnhPa2ZSQUpwZHB5akQ2T3FWWkFhWUlO?=
 =?utf-8?B?K3FFYkcvNTFtQS9XT1I3Uzg2cEdOcEUzK1VBRFp4Y2pCbWFUenhiSDZST2Fz?=
 =?utf-8?Q?Cx82AuF8NX/CI0XvxVCoJ0OPhVNh+s17?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:57:40.3762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7c0c58-6d20-4516-bd43-08dcd65fe950
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6269

The opt3002 is a Light-to-Digital Sensor by TI with support for wide-range
spectrum light. It shares most properties with their opt3001 model with
the exception of having a wide spectral bandwidth, ranging from 300 nm
to 1000 nm.

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


