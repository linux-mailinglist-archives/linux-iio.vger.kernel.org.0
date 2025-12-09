Return-Path: <linux-iio+bounces-26971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB75ECB06B1
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 16:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17A51301295C
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E3C2FFDE2;
	Tue,  9 Dec 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="IXTw9Sci"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023091.outbound.protection.outlook.com [40.107.159.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54E2FF656;
	Tue,  9 Dec 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294757; cv=fail; b=CWnTqJsPvw6HsH8RYX51CgXubB8SBl1TpYH7Q3/xUZkuSorfZfKa0uKsiXv8nWeAGEYQdHdYNmfb1VP3/6/8HZYT4rOBNK6HPAYM/76ms9y7NPl41S4DhEjAAwQaevVGR6JiGvqLSITbyx6l9cVbFEtmXcUBosbcd27yL/qo/FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294757; c=relaxed/simple;
	bh=jkPs6SqrK8NnhO1muK1xSuEDEJAsN8Ta2d+qlPN0Zeg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EH7IHzWa09IF2M39rIgahSkpFg1DEoBCGEQoLHVB9rKkErAsx6xC1Cy+LSvKwJe/VeQnk9v2OZKCO6/iArJcQDkwyRF2o64naPyctdqAFeSU7zqm2XGPX4JkLCeIjWpyb4/bjZpwGyv5+yziY8/AxXU4ghWh2907jm7zTN2UMoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=IXTw9Sci; arc=fail smtp.client-ip=40.107.159.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+1LF7R+VXfaySWUGspGqFeY5b99L7qU6fFoKVyc7Yv4nA9huonBTD4oy8mIvXqqrPBLOhoay3qUVTMyy5kz80wLt3O84++NezmUGAke9kjoim86lJwIMYiNz13o/0XVl/Cu1vE3hVu7tnGXvJDyK/H29KQTIV8WkhK0SUaBH1LCYlD2KJFbjW391ebYjUIK2D3tFyUKFHJIm+ZJr+6aQ+GtcOIQrIVF/n1gJR5q2YdSW7k+PYEFZjhwa4YMvA6SFSUV493Fm6SiZpDv1wlGLiE/d/gPut6vGT+Iz9OIfzdXUu28Vo3i0yCITxwV9tD11SUpR7mBRrD3QqDmqendjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGByndXr/mPXHXuph9nQ5QHMDEgnJnQMcsA5oel2nXk=;
 b=xiJLeC3tNsHaIhqeWU516Zcg4KOloZpdavNBcHc3nVwpSeBqCpl54uFsBFghikEqCGjeIXRZIvmJEGrXZL2ta8JL+6Wbn1PZiVRqLxnzDEDQm0/K48VEG1yTnktpiwOjspxgjq8qOWYm0/btPF0iyEw5xpvi8isnkpwttlyJGlrFAi2qCzxT/lfXq14+w50E1c90Qr8h98LY4Fz1cWqqxmFAGJZF62ImQz5ZajiLlhWDtuG8kZyC19KZa4ULpjUBwi3eNU2TZs4DnX+o55IUxyRc5FY2EqvYRgPgFsgkY23q6xC3kW+V37KWTZqCM/jWdpmPzJcwcvhsg8EtuZbWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGByndXr/mPXHXuph9nQ5QHMDEgnJnQMcsA5oel2nXk=;
 b=IXTw9Sci4iLvfMBVviBrouVypaMGSDuA+d2i7AKl3QLe1KOSJsrYi4r10SFQILHFsdbgX4Luek+McBZ39W2BVpKkbIYN+bhgjBqxxFJuK+tA1UBAUW8BPnt3WSdjCdu4XufM530IBE9LqzWWEUaP5hBchTA6uQkhZ605RJJFF0Cl5kLaTIIxoGYXhBpBNIeP6nkevpw1Z7tmt1tZXaIt8NNuc0AcrsY4JOe47tbZYOnArSI9Ej5OU1qmZ2X+mV2cjU5KVHSsEEDmCaNdZvxlKFhLz0Uj4yHeaU6VEIW4pZ6ubw/OInjXQ5Rug4lwC2uQuLoTShhpHOG67wMgoI2CQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DBAPR06MB7047.eurprd06.prod.outlook.com (2603:10a6:10:1a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 15:39:11 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 15:39:10 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 09 Dec 2025 15:38:10 +0000
Subject: [PATCH v5 1/3] dt-bindings: adc: ad9467: add support for ad9211
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-add-ad9211-v5-1-8da056eb62e9@vaisala.com>
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
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765294730; l=1386;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=jkPs6SqrK8NnhO1muK1xSuEDEJAsN8Ta2d+qlPN0Zeg=;
 b=CN3hEwmVQ7KkWVsMppdoin7iEzWNrB+BS90y34VXEyJBX+78vn2mHjUBGCVo7qLVfGUfFZ+Cl
 mOc7Y+R+Ma9CFvMDn31dT0O/OMtlIcvCn+z9xrzGwggq/yHU85ML+Xb
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
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DBAPR06MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f54a5bc-0566-42c3-476a-08de37391926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUNJa0RGQXNxR0pNVE1xMHJ1Y2E4a216QU1Kckh1ZHpldlBYdVlNRjIxcEh0?=
 =?utf-8?B?STlacTY2U0o5YjcrWERRdjRyU3dGdEhGMDNORnhhbmV0bDBpd2sxTHEwckdQ?=
 =?utf-8?B?MEtQQUpEN05HZzJJTGJKUWRTZkFwejQwaFpFdVBwbHFxNjNFdFdQcWx3TFhJ?=
 =?utf-8?B?VGViVzBLbFNGUU1qMHQ0S2d2VDhpMU9YTFlDWmFST0cyU1ZpQ2lVbjdTejFi?=
 =?utf-8?B?dUc0WE92eHY4cnhUUGJXeHI1QjBkb3JKQzd4d1RjVVVna3YvQ3NBS2h3QW1R?=
 =?utf-8?B?L3pwbTEvM3EvYkd3S0NQVS9HVy9aZld6NE5mNk9xdndkeWZXeHYwTjllNXk1?=
 =?utf-8?B?WmhIR05nRlZVVFVCZERKdGl1ZkJOSGFTWFdGN3BZRjJJMkQ1Rkd3NHFMZU9k?=
 =?utf-8?B?QnA2QVM4VUVROTdyU0k1ckhGU1lSNHVOTytGbWdPb21SbTM4Yi94N2EvdUJi?=
 =?utf-8?B?REhUdDZTRExIeTZCUXNMVndtWFd2eXc4SnUvNUlLZDdZelpRMk5XSDdiRDBt?=
 =?utf-8?B?ZGYreEpPYzFKVkxPTkU3ZG1vbk9oRnRWcjFod1hsNXpRZ2JpSitNa0JaakpH?=
 =?utf-8?B?L01FOXBkeG52eFdXKzFWQmFleW9LRnVuMlg2ZDNrREs5d281WHgvZlhMSDN6?=
 =?utf-8?B?Q3VuN2hJajl4eFJPZ0VxeVU1QUFRME9EKzRPUERMbkx4RHJLWGdieHhQOXhR?=
 =?utf-8?B?QmxBR1MrMXAzWGQwRFQ2WnlzaVhPZlJETkxIV2t2ajZJQXBmNWliK1A0YkxO?=
 =?utf-8?B?bis5aFNYaEY4V1BUV2NOMmtaaGxPK3daY1BhY0tQeWUxc2hLa0RSSkhvL3RE?=
 =?utf-8?B?ZSs0a1dMaDAxRlB6bG1PR29BSmNlcE85Y3BOcFdGUXdrR1RLT1FGU284enpy?=
 =?utf-8?B?QXlWbmJVNm1rSEhjek4zNlRhNHFOQW9FRlNCWjVHdE9XcUphV3EyMlhPTmto?=
 =?utf-8?B?U2JyOFNKVHA1RERmKzVjNjdkT3dsV3hoenR6amlPQ1luSEk0Zi9IU2daRmFq?=
 =?utf-8?B?TXVsVlFrNzRwZ1JRWHZlMGxMdkZKV2ZRQk8zVTd4ZUoxZWx1Uld5VHJMaUMw?=
 =?utf-8?B?WTZGOGZ6dlhiaDljZFljUU4rTFdGY0dtWm5MU1ZMalp1WTFzOEtDSFVyWW9q?=
 =?utf-8?B?ZXpYdEpJbmUwS2prZ0pweVk4WGsvaDVRZll5MENTMUJDSmxCL0JiNDloVUwv?=
 =?utf-8?B?NGtnQU9xTDN5c3RGQ0ZtRnlrSEJHQlI1WTdMMWtORHE0aTEzZ3VHdGVKbzlj?=
 =?utf-8?B?Z1hSNmtJMlAyeEJtOVkwclIzWURzVTR6VEFvRXErV2lDRXhtVzV5OU05RW1q?=
 =?utf-8?B?TzM2VVhSeFVnRHpKMlpXdkFsdVMzeWdoRVdlS1RFR0pzRDZlaHZEQ21acDZN?=
 =?utf-8?B?NlhWR3F2U3kvcmszSlMyazR5cVJtUERFTzArZ1piTkFDaXNaeXovT2xrMjh1?=
 =?utf-8?B?SWM4WDIxOStCQ1N0c3JWZTFhQlVzVFJLdHFoMG1jN2xGdVUvUVNjdERYZGRm?=
 =?utf-8?B?QlB1YVVhVTc2Y2hzTjgyNlNUNzduSi9mOXFLUFFyNHZpVFVEcThpVCtFcUJ1?=
 =?utf-8?B?WGJBYm1NbTgxNEFvSzYwdHVLcHBxbDdlTVM2UUtHMHFxaDJlWjVIZUUwYlhj?=
 =?utf-8?B?UUQ1MHNWb2VGNE55dU04ckRjNGpZNzFYWWhwSm5DTW9VTHJRWDYvdEdrV3dD?=
 =?utf-8?B?dTdMTWRud2JkSmFwS3gwYkF6YThIVDRYRUFHSU51MkwzakM1Q3VKS2prRWhy?=
 =?utf-8?B?VGl4NG9jeFFwbzZXUEs2WTY0Z0hYSUpteWRZZ0VheXptV21QRGpvaTAzOVlw?=
 =?utf-8?B?WnJrZzhMcTlQaHY4MkZ4emR6OXlqL3Z2RkcvS09sZ2dqZCtnV3UvYUN3MnZD?=
 =?utf-8?B?MjJ0TnNYa3FPbmEzMU9CYkhxRk0xNXYyWkVSd21ySCtJbzBaUnhUaHNEZHFl?=
 =?utf-8?B?UDVkeTZMR210WVpyaFY1TThXSW45RlU1dDJwbUsvYUZGZkJORmxORGdmeDR3?=
 =?utf-8?B?cmlkQlJ4L2dkWkI4OWMvTHV3VEJqZ0t2UE1vYkR4ejJCUEN6QUVETy84TURh?=
 =?utf-8?Q?M+OzTU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1VlbFlWVi9tbWpqbnJCZzR3RUJId3pBbVgvajdFYitWaGFuZ2lyblpCMFg0?=
 =?utf-8?B?NmVuaExjK3JUUGhCak16YXFkT3ZoL0JTV09kaE5rdXcxOWh0T2h0WFkwZDls?=
 =?utf-8?B?Uy9sUDRsTjMva0VUcWQrNEdMY29BYTQ1RXVHMklxTmw4RForaGF6enBaK1A4?=
 =?utf-8?B?OCtkUG45WkZzaEEyZW43K0thVktkZ2o2VmV5M0pEN3hRS29QOWdtS0VkNzBB?=
 =?utf-8?B?T2d5a1lwTSsyaXlnZEdIbjNSUlhqRkJDeE9YRjZRSTlpNDBGRFk3TDlvTHNk?=
 =?utf-8?B?MGdoOTlIdGlaM0hsZXVjcHRvRXdBdnlqMzlzMXQ5dlprVzV3QWZLMzRsMFV1?=
 =?utf-8?B?T2ltQlh6THBKT3dLSURjcjdxUWVDcGRPdTZBYnNnamh6NDBBRTVram0xNnVU?=
 =?utf-8?B?MU1EUEhOVWFSREtTaVpzeW1laks1YWdWSjgzWjEyNXVGVGtIRUVIUUY2VHFS?=
 =?utf-8?B?UXZBOG82WDFraFM2eG5rUWtKcU5UN1NGVENSUytXVGxyKzgrdXc3M0l1TVRh?=
 =?utf-8?B?RTNXdFcwQk00YTJWaEZhRENOYTRaNWRTRmcxb2g0c3dYT1JUYXdSWXBJbVZ6?=
 =?utf-8?B?VWdJY01jZXhUaVM4ZUlOR3ZRVS9lQkVDVWUzbHRkZkgvUnFkcllwYkhFdGFr?=
 =?utf-8?B?and5TGRWdmNRZ0ZXNnc1UFpmc2Y0MjVJQmUrK3NGZFFIajYyeDJXYVllM2tG?=
 =?utf-8?B?NFNjSklBeFIvQUcwcTRITk95Mmp2S1ZyUVNkWUQyaXB4cTNkUzRYTnF6Wmo4?=
 =?utf-8?B?YktwUitWbXBIOGFvdU9qczYyOEJlNkt0bHdyV1YvM2h2eTU1N3lLM0hMMnJp?=
 =?utf-8?B?eldQV1JrZDk1dWkraGlkVVprZGRKQlZvM0d5V2hLOC9aMzdVTGRPYnQ5YlNi?=
 =?utf-8?B?N0cwazdhQ3pTNnNsQWpqNmV3cDVvRmpsc0xubEZxUnI0RUpad291RzdYWElM?=
 =?utf-8?B?TFVNcVBSd05MTnhmTmx4Y1R0RlNBeU5GZUpGek9WVGkyOEZLSzdqQ0FHS3hV?=
 =?utf-8?B?amFlSFhmOXBRNVB3OVZpbXhDbkdCS2NrNHZWSlhXWGtRNVV1SUdld2paTWVI?=
 =?utf-8?B?cjRmRjZZUHhTa1ZYZlJKamxqTlFRclZycmZaNDZkVEtwY2RVaEFSQVgrcVox?=
 =?utf-8?B?enE5UmVYMDJpbVBGeXdMWkFhSHFpR0Z3NWx0b01zazQrSys3eHFZV3R1Ni9U?=
 =?utf-8?B?UEpkL1RyZ2h6a2tscE00SFFpdlhubG80VkRZQU92TFkwMjhBL0VvZm9sbjhG?=
 =?utf-8?B?RCtITlBDNE5NSnV3NDc4ajhvRHRwSGFRQ3R3bEhnZHE4bmhReU5oemx1U21o?=
 =?utf-8?B?Y3VkTGZ5YkdjeCtzRHYwclBxOEJKUGMrNGQyZmdIK3JVSFdvbjFrYTdMdU9r?=
 =?utf-8?B?ZzZSYmVuRVpScVRMQkJibWY0TmpoZ0p1VGJsaEo2Ukpob1VZcVY1ZlcrOUZK?=
 =?utf-8?B?U1ZUUVlRNTdUMnhhSUhUYU4vZUNTVUpWVmc5ODFxSEplSzhDdUxaQTQ3NWdM?=
 =?utf-8?B?dTdBSnVwK1RoZFVpR1NwTjJkNSs0RjJDaHZNOTNDTGp4YnVocHY1STd0dUt6?=
 =?utf-8?B?WUVRam1RMnFVTXAybXozL0VsNlo4eTF6ck02bUZMY1RTRG83RElIcG9YR2cv?=
 =?utf-8?B?Uk9yNkFzR0Z2NjlyK1Bva3VtV2kycmdUYWtPbHlEU2hpQUszWFpVeDc5UWJC?=
 =?utf-8?B?Vzk4WlFEWXZsV2JKN0FCdG5mNU1KbyszaEpQUlNTeGpOekFNdVdVbUFOaGhW?=
 =?utf-8?B?Uzd2b3ZtL0k5QnpXTVhDTmxhWHNzMFFwdjM4eTdRYWsyRDcyNjBhTjlwbjM0?=
 =?utf-8?B?TS9LK0hEN2J3WURHOXFidzVuMDBVN051aFFxMjdwN2xMQ3BIWFVmL2JVQVRw?=
 =?utf-8?B?RzBIdzQzemxsOGphcHBmcnloZE9zNjlnbzFMaGlwcVlsOGQ3Ylp6MVFubGtU?=
 =?utf-8?B?TlRzZjZCYTdXNjhkVlE1Skk5UldzUTVzWk5uNXVpdDJPSDBnVWZxbFNNUWxD?=
 =?utf-8?B?RVhjMDFUS3p1T3JVQ3l2Qk1iOFROOExnQ2VMT3dkVlhFbzNvSkZ2ZjBmMSti?=
 =?utf-8?B?czRtVWhCQWVNRzczY0oyMndvRXY4ZHoyaHlDdE91dEJad3Z0V2UwanBPNXFK?=
 =?utf-8?B?WVBqNG5sbENldjI4TDhoMHVVcGVLdHhqL0Fpd3dERXpyVENTTk13YWQrMHA1?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f54a5bc-0566-42c3-476a-08de37391926
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:39:10.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zxncs3Ke11na6sZwNPW+PlpGqmWqmELVLCB3QMq9m1FDXgwx6DUW24HoUbrtr7zvD4d3RcUkXoARj8ZAELN1yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB7047

This device has e.g. different scaling values than currently
listed devices.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index 2606c0c5dfc61fd65cd0fb2015b3f659c2fc9e07..5acfb0eef4d5cf487adaa93ce5bda759bb4853c9 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -18,6 +18,7 @@ description: |
   All the parts support the register map described by Application Note AN-877
    https://www.analog.com/media/en/technical-documentation/application-notes/AN-877.pdf
 
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9265.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9434.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.pdf
@@ -25,6 +26,7 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,ad9211
       - adi,ad9265
       - adi,ad9434
       - adi,ad9467

-- 
2.47.3


