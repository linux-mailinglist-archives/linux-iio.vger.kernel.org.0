Return-Path: <linux-iio+bounces-26972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FD7CB06C6
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 16:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B480309B4C1
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCAF2FFF8E;
	Tue,  9 Dec 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="s2moXkCJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020123.outbound.protection.outlook.com [52.101.84.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B732FFDE2;
	Tue,  9 Dec 2025 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294766; cv=fail; b=N3LBO72YW44Ta4W+tW7TcMpsm4gI2Q5kFYeNfSN0VhJPV9mQeiz6HcYd79kCY0YJpSfpqbC5AE6mmQTKnmIT5/R1ieACSDKJcOO5tNwu/KQA9Zy7unyxAoPJeohgk78Kvd0kKw6rxNm7QOEtqlZGbCTPSf2ZpHXf5GLJWDzmpfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294766; c=relaxed/simple;
	bh=SF4+pEXaa3Pe2fhKDKcOUKEBh1dk1V+NyM3yde4Z7m8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=q9ohHqRKYaDa8CC2Rlsr6XXRwYu1Ba3e/klXp/JLLiU3FQ5Az6Qw11NhbgeId+mRpi2EkZATEQbpETcFjq24lCi9BdNYvxplGiJoflUxR4/CUHXaLfjQ2E9W8tX46Sl9QsnS9HOzHOBdujXv1eNkkW7q7+Ap7xhVfZlWWT3pWQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=s2moXkCJ; arc=fail smtp.client-ip=52.101.84.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1mg+t8FPLKDrIIcTZkOzgUauUPXOAR2SOUmHA+N6WmQ7F/Dos2YVBBvzcEJUjnoVbxmiBCWzQvhHd6YONK0a6GslOVUL+3PWCQ9SCjWG9hnCM+blt6q4Fu9RtX5Pcd/ElanP8S+84YxFEWqT2uyJUeqq16TZLb9Yh0rt8lYG7KcBBLLyjJTUFSXHHAdDfNmZLhp6r8mK3EozjEmcgFdXBHqiWVVKs9Tc5HXUXn5BdJtQNYeVjfvqepsPMCMhRVrB/IfmCzTGZshrXI9lukB+wu7UxrP9ktlSl3A4DnfhxQv+cYLF0ZuV7umzTb3V5KPLL9ThKdzxGCpn3FwbD6zTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USfBu1B8CeSWuJRB0wSt1yH2KCZ3XJ2OO7+bwSu1DSk=;
 b=i7j0vE+amOriFoIiGo5gZPFCnQ/z0GjaRw+K4SE9f28AwaGNYgfo2z+rhhduzt09vdVK05DEuAsuE7TrTzpNodeAFC+ZJ8FbMbINL5t0p17KtRUK0Zy/aRDk0XTGXZF8isidNOYYJrLSqNqJ6qOoudfAhKQxqSsuJmqvfvybBc72BSLkfB6IPBRAuXIp97eSS0wdOkP4K/AZIRDYhH3pOcxuQmfIO1IGM3Jql/9FR+hSfHox5JolJR5pEQ7NmHtYi27VgNjJW6MMJULsdVzxTyN8ClAvx/sPHxDlp7rxQs1eYgteU6Td4yQVi6JQ7ySGANpJ2DhkWg9IzhE1cnsNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USfBu1B8CeSWuJRB0wSt1yH2KCZ3XJ2OO7+bwSu1DSk=;
 b=s2moXkCJxN2/ijxUIFQO5R2L3Ybxjek6u4+Y/v+lG+742CDLTXbDBTskf/6N8yknS7hFGw5SCDUmFhfbv9V9hC6RH4LeobqIsnSAe7mO1Y3CxVP8JE6LRlBzsBQL1blXdwf8zALUSsyurtE9PTOqtm2grdKzZSP153RNFtsbV0BNYm6V+zNji2UelmLdqYJQkit95TLCFJXwMifCj47duWODpbJR8WqCCiavAXBx8IKOhhpjPoOEFtqpzKQqqF/23UB58dkcSeWE9xAX8i/YmwF77i2/AVTJXdwU5IfPNZuObSPrzvytC+5BtJ6hXl4d1vWWiZ4vij58RBoUpr+tVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PR3PR06MB6667.eurprd06.prod.outlook.com (2603:10a6:102:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Tue, 9 Dec
 2025 15:39:19 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 15:39:19 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 09 Dec 2025 15:38:11 +0000
Subject: [PATCH v5 2/3] iio: adc: ad9467: sort header includes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-add-ad9211-v5-2-8da056eb62e9@vaisala.com>
References: <20251209-add-ad9211-v5-0-8da056eb62e9@vaisala.com>
In-Reply-To: <20251209-add-ad9211-v5-0-8da056eb62e9@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765294730; l=1328;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=SF4+pEXaa3Pe2fhKDKcOUKEBh1dk1V+NyM3yde4Z7m8=;
 b=7EF6O9Gfs1DHHkwrlEHr0Gdz5+XvO1EALcVfn/vLBcWL8Ar2c99uTatI0aJ1gMxXEoikN8Mk5
 6Bx+e46ycqTBPHvZrjRkZCpstliVGiy5sCqgUXIGPOjudpVaFtNFR+t
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF0000366F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::38f) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PR3PR06MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b026f0e-ef5c-41cc-25cf-08de37391e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGdqVGxsT003WHBFR1U0SEpoNXpjSE9XTnB3Y1BscWtkQWc5bTdoM3h2MENO?=
 =?utf-8?B?eExGQ21lZlhCaE1PNTJHYU1aU25EaFcwbVZNdmpuS0NoT0tSYlMwM0puKzdy?=
 =?utf-8?B?M2l5TjVzVGNSclVwbzNOQ25VTDh3cDBWNC9kaTMwMSt3T3BkZkJUakxyajJN?=
 =?utf-8?B?K0ZKZmF4aHY5eFJzUm5iNTBGZnZ0b1VyREhwRzZTeDdWYURVNzlxOXV1UHpy?=
 =?utf-8?B?R3YyS3hzT3JoOUhqaVB4MUVuaDJaVStBYktpOHVBVkoxRmNjdU13Y200UlhP?=
 =?utf-8?B?Y2N5ZHVTYmxCZUNLY1gxbzQzUktHdW4rQnZ5NHNwNWRYUk5sWk52RnBLeXla?=
 =?utf-8?B?N294dG5vSytac1ZhakVDb2VGcEQ1MnZDZ1lOeUxkTStKakRkSzdyMVM4SXha?=
 =?utf-8?B?c1RCWStuUXNJdWRLZ2JOSitRWlpQQ1pQMWFBY2c4ZkRqWEk4dDZoYUJ4cGNO?=
 =?utf-8?B?MS9PTnF3akVwZ2NDbEFMcGN3NytMTUR0Qm5qU3NIYVVLYzR1RjdtcCtsSGhL?=
 =?utf-8?B?ZVN4VDlPeTdWZ0d5b0pyZVdsc2NhZVNFSldOOHh2STFSazVYNlBVUzdwQjc3?=
 =?utf-8?B?WEd6RXFLRVhBUXlWWlhCeDJ1M1RYdktCRVR6RjdVY3NEZHgwL3Fsb3Y1R0Nk?=
 =?utf-8?B?dFVnbUdXa016SHI2bXRUS3FNankyNDNGVDJnbFRpcWc5b1MzbmRJams4TW9J?=
 =?utf-8?B?ZGVVNWRNdGZ5KzlnL0dhMnBScDBHYVBMc2YzNzJjV3hoMTlzNTkyaTZabFE3?=
 =?utf-8?B?cm5uaFp6d1d2SHdZRUZiVDVqWExnUUdMVlRvSkxGUE9IVjFJbVpYeFNnQnFp?=
 =?utf-8?B?VXFvd2pJSCs0Rmt4bmgyQU5hQTBwY0tSaHJKTW1vQmt0TTRUWGtHNldnQWlz?=
 =?utf-8?B?UEtwMVlTMWZsYTEzNEE4azQyWXhzNnN5dW1JckdMcU1ERjF0U0dRWStWS3ll?=
 =?utf-8?B?TWcvckMrbEZGUlBvcGx2QnkraWI2NXRieEdDSjRRcGU2aDNlcmMyVzhCZkVq?=
 =?utf-8?B?OUVFc1pmc0NIUDhNZ2xMbWdWUnFsMU5VVE5FditMQlAxS3ZOTDFFZng3K0VV?=
 =?utf-8?B?cTR4cWs4akx1cnVLOVZKZVF4YU42bGt2b0NxUHEzSWx6S09FaWpPL0hjbTU1?=
 =?utf-8?B?WGl3b3EyaDduWXgxaFArNEFFNjNKeWdOcmdIdHlnRHBvZXdEeEVYRnFaRU5P?=
 =?utf-8?B?REZaMStObG9ya0I5QzY4eGw0dEJ1YTh0bHB1cHArLzI0MEd5WWZlTGpCZnoz?=
 =?utf-8?B?VjkyL21IK0tRQTFnKzJ0ZW9yaEM3UjRvZFQ2Wlc3YlI4WmxUYTgzOUpYZjNy?=
 =?utf-8?B?dC9YV0ZwMHZ5elF1bWVPMWtSMnVSOHJyRndwbVkxUUZCYXE2YkwzaWQrTSs4?=
 =?utf-8?B?WG1HdDZvR21TeDBGQklrSkV6OXpRKzJ5bW45S09lNFZEbDFJeVU0YXVtbGV4?=
 =?utf-8?B?a1NKTHVlWWEwSEFYYkJoWDE3Y1JPazF1ZHRpUmVrYU9DOHlSSmxHMW9QL2V1?=
 =?utf-8?B?QTVmSHQxcm9HOGt0UVROQWdKOEVwVVRCc1ZxWVhuWHBsVktEbjVZWm04cDBB?=
 =?utf-8?B?Rkg0ekRiVnlPWmV6cnlvSW45UDJjUzQvZk5WNytRQkFNMnJKZDVqakdrUjht?=
 =?utf-8?B?djVSUWo4bkNPU1FnZHl0ZnY0WlRmaEE4bWtkNVRhN3NBWTJjNHFsNUNYTW5D?=
 =?utf-8?B?OEk2S3lycCs0bXdqOUxNd3lydnBiQ3NRRGx1emhxNzA1RTN2MVZ1alBYRU9k?=
 =?utf-8?B?TzloV05PZ0s5ZFFQWktRMFp6SnRCOVlyRkV0Z3hzc3RQaElvWkVEK1ZiL1VC?=
 =?utf-8?B?RjhaSnI4NnkyaFVPQUpFVmlmaElCbEhzUEpWSjN2S0I4WWxRSkZTaFhsVkpF?=
 =?utf-8?B?SXo4LzFQWWNzSWdTT1c1S3lhdE50MzR3QWhHRU1VWFZ0b01KdFRlaTZWM2tS?=
 =?utf-8?B?VGhCWWJTejZGeFdtS2xGenBmY3ZreGFodk5XZFVPbjJsNndjRjhaaEcrU2dW?=
 =?utf-8?B?ZFoxSk5MNm9RSUk3Q2sxcWQwcTNDdzRyZElPMVh4TCtmbzJ6dlJLTjZ1K1Rw?=
 =?utf-8?Q?ijNZmy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0ZCekdYa1QrUlNwZnlPV3lPcnBQVHNSci9HcUg1RysxUEZ0Q2VsTm9kK09v?=
 =?utf-8?B?VGs3SmJXU0JFSjNLRDQvV3cySUw0aWI4c0MvZW8xQkpaalNuRE9aMlowWHpQ?=
 =?utf-8?B?MFJLL3JkUW92NDdVTlFnclZDRFZVcGtNTzkxbkE5WURBYU1DWEpRSE12cVRh?=
 =?utf-8?B?YTVBVFZFcVFwSmR1NnFaUWprdzlYNzhoNmdTZjVpOEpzTkszUFJtd0VDQmVF?=
 =?utf-8?B?dkprSjBjaTdMWitIeWtWYlliM2JJbXJJQ3EyV1dyRHJXcnJ6MFJsSDJMOE1m?=
 =?utf-8?B?aE54VHN0cjhzdit6d1BkYUlXUk1LYnRDUUdId0NMa3hSL1orRjZSdmJpTEVh?=
 =?utf-8?B?YXoycXVPYWJjVGVnV1VsRkVKSFZadEdQL2Z6MXhSVTRselhpRXozL0F0Y1Zx?=
 =?utf-8?B?OVB0cUZkSVdCU3dtNE5UOFZBelpidE12bTRLVytWVFpqZklublJSbVFkNjQ3?=
 =?utf-8?B?UUs5VytMTlFXNDhwa29NS3BwSkEzN3dUbkxuRUN4b2NYUndnQ2U5bEZ2TElK?=
 =?utf-8?B?MG1PdU9OeDJvRUp2UmwrcUFobnY4cVdzOG5wVUpoeGx2QWZSeTdiNnR5SUxS?=
 =?utf-8?B?Y3JIbFVNSW5nNzNhcnhxd29IbUlwSVNCNjUzQlZEY3A4UVdzWFdMaC81cHpD?=
 =?utf-8?B?KzlKR2swZXFCMFoxZGp4U3ZYRFVnMnpBdWd5MXQ1b29ydUdHOW9YSUtCbHgy?=
 =?utf-8?B?MWl2SDl2NTdvYW9nSUsyUG41eUdrT1ZHWWFJRjJNbkpDVVhiUkx6NGlNNkpX?=
 =?utf-8?B?OHEvblMxVUg3Tkk1eHNJREtXcVdjVXlncm1CN1BLaVlKWmRibEYzbmZ3T0d2?=
 =?utf-8?B?TU93REhBNmJhenJua1R0Z3Q2dDZ5bzRJTlpkQkI5WjZRdzNEZVUyRkU0dzB0?=
 =?utf-8?B?bElQME1idXNTV0pRTlg3NkZJbitHRUk0VDVsZURNTTA1QjNuTW5PRTVveUNy?=
 =?utf-8?B?RURXdW1ESFhpU2w5UXNIQ3FQSUs4MnNXSVZMMEJaYnRGWG0relZoeFFBSVNl?=
 =?utf-8?B?emFHWmE5R2RZeWM4eVptQjU2dFBGMWdzaHRLS0JkOW5NMDZVMG4zTWs0aVFU?=
 =?utf-8?B?Yno0bkFUWUpxUDhUWFErM2NiNWtOZjRKRnM1WUxxQno4WGpxRXd5eXpUdWpG?=
 =?utf-8?B?ZXZGeXRLNElKcXlyM3d4bWFBRDlHdTZSSlFQUm54cGtOYW5KbkJiY1czLyt4?=
 =?utf-8?B?L2hVMS9ZQk92alN2VnVNakJzRVhnU2lENUJmbG1vQlVneGkrUlFFaUdnd3BC?=
 =?utf-8?B?bUx6M25iQ2YwaVZXWENWVUovaDRJQi81NXhCYVJ0Vk1VVGdBVGxJaFB0a2lD?=
 =?utf-8?B?QmpGdzFxTmxHc2dGUnZ5MzNQR0RySU5MVVRLZFlLWU9JdGd4M295cVFEYUoz?=
 =?utf-8?B?cE9DOG0xRytCNnJOMFdadmZXY0dzRWNlaDhkd0JxZ1BCTVhCTi9Xdk02M2Q3?=
 =?utf-8?B?Njk0MVUyeHNzQjRkUW5qOHRFN0FRNGVqSzBxVUNuZmtDcVBScHRndGxtTG41?=
 =?utf-8?B?VGM0TENNb2hIdzJmc3FWNTVkOExEc04xYTd5Sm01YjJVbDFUVWxWdkNFQ2ph?=
 =?utf-8?B?aGlTd1gwVVE0NExsN1N0bXp1QnZRL3gwRHdhdDJHOUxCYUtENG56MkJCM2pi?=
 =?utf-8?B?UmFxR0c5bG51eEpRbXJuaDdqTHBteFVsazBtbmZGZnU4bU83VlhtTnNSY3Jh?=
 =?utf-8?B?S09xTG9WRURXeVcyNXNnT3c5NzJuK0V4UEh6eVNBMHZGSGZiQ2RmOHR3RENn?=
 =?utf-8?B?YXhVRWY4T2NZenk0bGhDbWExRzdZNDRwMUlvd2hzbGZJQ2VRNjI4Y1pPdC9u?=
 =?utf-8?B?K2VxWkpxNUdoWEZMYkVwRlFQSUx4Z2pOVFQ2K1BNR3hSMVFzUkl4ZGZPNFRJ?=
 =?utf-8?B?dzQvaHRFbU15K0JrNE5pWSt1b0VvWmp1ekxVUnFqNElucDg5VWZrNXhBRndl?=
 =?utf-8?B?QXI5NnZSK2VjR1k2Y3RjeGFTQmNiWTFHNng2SHo0OVQxTHNrc2xyVVdMU09W?=
 =?utf-8?B?eDNPSnVudndyWXB5UkFSdi95OStkZ29ydnl5ZEExRm5TcFU0Uit2OUtVaGt2?=
 =?utf-8?B?T1Nsc2RrbjhoWVJ3di9MMWR5QlBsakpwWmdyMUw2clZrclRFWlhYdFEwTHg4?=
 =?utf-8?B?a1dRTUZiZjBlbzdzNjZISFdCNFhSdFovVGU5WVgzeFBpYmFBQ2lRdWM4bTRL?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b026f0e-ef5c-41cc-25cf-08de37391e36
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:39:19.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68Gb5GZdZhbDkb0xssLHa21zSwQMRMpsifufXB8bh09oQJh1mzQ9u14iUIKIH+Vyddyjb0uZ7T5FdtMobK23Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6667

Include headers in ascending order.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f7a9f46ea0dc405e25f312197df4b2131871b4bc..54d0c500cfb6d2ed8ab664c7f0641ee531007fef 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -8,26 +8,24 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
+#include <linux/clk.h>
 #include <linux/debugfs.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/spi/spi.h>
-#include <linux/seq_file.h>
 #include <linux/err.h>
-#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
-
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
 
 #include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include <linux/clk.h>
-
 /*
  * ADI High-Speed ADC common spi interface registers
  * See Application-Note AN-877:

-- 
2.47.3


