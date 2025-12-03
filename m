Return-Path: <linux-iio+bounces-26674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDF8C9EF80
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 13:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA5C9348BB4
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7272F5A1F;
	Wed,  3 Dec 2025 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="tLpbMCKh"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021103.outbound.protection.outlook.com [40.107.130.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEF02F12BA;
	Wed,  3 Dec 2025 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764764480; cv=fail; b=Ut1dZfVgXBvonHt0ljRsd5vb4uRY2Ve28VTfqIkVWCWZu1ifJmu/HBqEGw+gIiQDdt2aku0HipILPEjnpfeKV/IZsoTVyirnPhTaN507ssztWbilTcFzhgF8NgaU+ZM/DTFD39fVDGypWzkjgsh4i+pfFvhbrPBJRSra6Lfac14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764764480; c=relaxed/simple;
	bh=7YaUbNrqrmGOfCF0fhc8XC0Qpbd0Ij9ZF1ZLWj8KJNg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZbzOY+wRHYuKpJzGeL5mG0FKUlP1GKjRQTVTjGa5XJfY1GO2DcZEl2jeP/g8XwXFIYcESLGegHf7gcTtMPqbNmkNwHnx4eZEaBTWBnW/dGjVb09wb/ls9ijlgA3qicAYOJMlqjP/dk1PDvyGE89ezdXiTWiU0ymCg1riAztROME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=tLpbMCKh; arc=fail smtp.client-ip=40.107.130.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oa2kNKjhdOyfZcupvmxStISbX2YPRIJ0HBIcpMuHnC67GGPrcOGmwpv86in1Wm4Cp94aRgUZQVlj4SzA0y4DF8qemfqCz6lDHMbVaLyopE1pxDNTZDL3hpB3D1xaIVo7FEf6fAwOapZeTfa/4+Am9HVaA0y68CaAzcAHLacANf8r4ehMm8JWEcJuwby4AO0R46YeP7BvNn5o+XMbZJy0A4Aws9ummrsNu6vJFaNz46pfg/ygRK4ceerpo6Iu98hMjKgiA/gjffTnhnmufsGe2YjPfIsRlgPqRATvTGwBx4CptNn3cjMVefO1SQxo3+c+sxpzrPDxVoAsDN/JDLWGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvfNMWQ9MifolhHnZehj3pszvgu1Klz94jYGSE53j8g=;
 b=yQM/DyoCFjy/Gn0rs1IfIhgXKR+yc57gT60KyERB2vw82pD5iT8sX9YhNw8E0F1qPu624fF1zRwujEUGtYZ7bqh8HCTS6UINwUvgJPaNFQROaMwfu+Ha+KpSs0dzNyJboUQbHgA3JEc8PkgZe5OUU3ga6sZ3K40PrKG1uTpAsrlGoq6ogjDfq7T+3Qe7whKM0H25/w0wpFsVTSEddr694YFOpy96LAVltsXhkhe2ttn83NHfGIgk2wS0OwOJMfk9+mvXj01ujsThWBwmZRWJOrxJHtwfBciG/7T7+2asYwbEJz41i6UAlaoXx5fT78H4bZKuMVdDWNgJU36FMdmoZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvfNMWQ9MifolhHnZehj3pszvgu1Klz94jYGSE53j8g=;
 b=tLpbMCKhFMUrD1wXNpd0ozROF73QK0tJf/EQFYSwsYJOz+5By1Ai8MTf3uifqwvzNxnp6o6vQ9k6BaXVaw0vaK4fdLaDtyyzWBgy3EUD6Y4Unry90k12T5MSUSFOYdoeKwbhA4kFfjcZOx2SYf+xRHY6YCYFrwcDHiCjhPXKWsm2Jq3I/lTdqsvEOyVGD3RfkxG8E60rvo0fL3k36Q7cmNosZ4Mt8ppbB2bdRU/kqcsf0b1+IykytH8HncujZU99GSxVTmz2qAnIMfukbSrMHmbtRqHaLWmLO9HNqCE9ouWbX99ICu/4Gr0QfbNURtIYNU1EAy80ZcCdstWaIJnUeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DB9PR06MB7257.eurprd06.prod.outlook.com (2603:10a6:10:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 12:21:04 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 12:21:04 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Wed, 03 Dec 2025 12:20:34 +0000
Subject: [PATCH 2/2] iio: adc: ad9467: add support for ad9211
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-add-ad9211-v1-2-170e97e6df11@vaisala.com>
References: <20251203-add-ad9211-v1-0-170e97e6df11@vaisala.com>
In-Reply-To: <20251203-add-ad9211-v1-0-170e97e6df11@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764764462; l=4391;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=7YaUbNrqrmGOfCF0fhc8XC0Qpbd0Ij9ZF1ZLWj8KJNg=;
 b=IoqwFXSjeNXZDHjmYssKGt5NchbSgBJf1p0Ffxn1bAxMWJqkdwpM4EHcn+7eN4TsGFiWDuxTp
 IZ0/9oNvpDSARezr9IY3CH+/yuAdlxi9Zs4DRFRTPolGluIQ6MvZkV1
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVZP280CA0072.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::15) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DB9PR06MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8fff2e-fca8-4164-5433-08de32666e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dllkU0RlclpZUGMxQzBRR3FmaWdoZm1mdy9PTWFDNE52NjF4a3BBbm5DdkZR?=
 =?utf-8?B?eG9KUkFpM1dLb1RoMmZVcjdRR3NxbGlxY3lscHd4K3Q1cWlUUHFpUmJ6VEFw?=
 =?utf-8?B?dkJqOGdzK2gzVDh4MG1obDgrM0dxSVBOT2Rocnk4SjFhV01nLzJobzQ3cFZZ?=
 =?utf-8?B?RFE3bXJIUzluUDViRTI4cUh5QUZabWdkeVJYRUF2SE1yWkpmdVRobzJ6RlJE?=
 =?utf-8?B?L2ZkaXcrMVJQZ0tDRDQrLzQyc2xQSjB6ak50ZXJkQ05rRnNOWG5WVHJFOStQ?=
 =?utf-8?B?UkN3YWNyRFV3eXlHUGozMTIvRi9Vd2FXaG44MlVZSFhRbUdvWVoraEhvUVBi?=
 =?utf-8?B?SE9xSVB0aGVIbEFrbndjZlB5NWR5dUNoS21DQVRtLzJHcFkrb1R3dlFiMDRy?=
 =?utf-8?B?djRoVGs5WTJvVWh4VVc4MnZHbnpObWt3S3hoSVMvQXQwYTFYRXA3VWUwNkpj?=
 =?utf-8?B?eWoxb3Q1TUNvbzcrSll6ZjBMTW1CSkxJT09DQ1ExMnNZTUQ0aUI4NWpSOEF1?=
 =?utf-8?B?NVV3YXJ6aHdJZHUzOGpVTlVHbkFCNlJHZmQ4Y05mN1pPbkFGbWp3ZWZWcUo1?=
 =?utf-8?B?cmVINTU2OVBaeElBYU5CSDNLUGxqaWhZZHN6ZnFoTWswcU5aSkFoK0tkN1Jz?=
 =?utf-8?B?aVZ0ZW9jOHRTaFp0NXJXRnloTktsVGFJNkdIUUlNbFFkYU1jMVJkeTR6MG1V?=
 =?utf-8?B?WEtXbVVWVTNBTVhQaERLWGMzTm5oM0FnakExRUJmY1NaWWFUL3hTS1ppTmRK?=
 =?utf-8?B?aWZVS3pWYWkwQy85SkxnM3dEMUlzUHM0OGh2UDVtQ012ZnpiaHBRSmJua1JC?=
 =?utf-8?B?aDlzZGlmdWk0WSttaUlHWFRjbUx6UEV0QzJDV2VtWTV3enJzbDNXNzdOQ1ZR?=
 =?utf-8?B?YmxESWZBalozNGtmSlJ6Tnl6S1pNWGVoL0dHQVBtbG85Y1o4YnVRUS9MbnlS?=
 =?utf-8?B?ZlRodjd3QnZqWDlTV1N1RjFNdnhvYVI0cHFMaG15OXhDa1VMVW5mQ2dydlQr?=
 =?utf-8?B?VFFNZjVNTWFuRm9uRGFVUWZPZ3lJZTVOa0xuc3oxWDE3dndJRWhabDFyN2po?=
 =?utf-8?B?dVdsTUVWR2FCOWFzVkVQdElMTzZZUmxhTUhUOXlxZzhYcExXQlA0cHk0c0NH?=
 =?utf-8?B?ZUpkVGxtNDNHdnpqUUFhWU1zNE9CSnJ4NzNmNlVFY2ErZjJZVCs0dkt3S2Y3?=
 =?utf-8?B?czBmMFZDVnRON2FRWVBuNTlKWjM2LzhkWkZ5L2I2Um1EZHVGVU56OUhJOUpi?=
 =?utf-8?B?QlZhL29KMjlIVzJWL1NTNUl1S0M5ajRuWFNGcG9TUW02MFVRcjVuRHRleTRK?=
 =?utf-8?B?WnZGQlJkMFNxM05weTN5L2xLNHNZUm9LNWUwazBWbFZBSHhKaDRoS1R3UXhl?=
 =?utf-8?B?ZkN1S0VCNGFUR0g3ak5hOGgvUWI1TjBvV2lOWWNhVHpuTXA1RWpxZjg5OFd1?=
 =?utf-8?B?ZnE3SzFaSkZUSmRYczZoMUxHdllZcTlQS2c2VGJTdTljY3I4MllDcU5JQk1h?=
 =?utf-8?B?bGZNNWgxQXBiMkxMaXovVTNaTGNiS2ZSL09ncDU0dmtHRlRQOFpKOHM0czZW?=
 =?utf-8?B?MGlxb1Z5WG5VR2FwL2RTSzBhUWJ1TzVKM25ocE9Xc1J5TVFSQmNleTl3b0dP?=
 =?utf-8?B?V2ZxUURhTjdYUUVTbzQybXk3b0dLdS8yZ0hKT0JiWDJrZkZ3Sk56bnJxZGlG?=
 =?utf-8?B?N05DSUhxRjA5ank0ay9GSXlwa3E2TDV0VmF0SCtyQXZMVFhpVE9qTjFZeUJ0?=
 =?utf-8?B?T0w5VUIwY01wdkVxa1JoRml3WXgzUjVTOTFtTmFmNmpTTWJaSm5WbDlaY3dN?=
 =?utf-8?B?MzFXTXovcVpnYjNyemxnT2NvM1JXbzY4ZldOaEVDRmF3aEhET0FZRzJwa25x?=
 =?utf-8?B?ME1xZEpyWkpjVmJlT1RCR3p2MHl6MytlN3FlTEUwa0ZUMjRRa0N2VjN5T3gr?=
 =?utf-8?B?L0x2N0JSOHZ4c3ByQU91Zk1mSklpRzNkV0FjTmVJZVZIODBsUkVoeUJVbFh2?=
 =?utf-8?B?Y3FnNjFYemUyaEdrVVRXdk5KN2RGejhNNDFrUGxJOXJpSHlPNlJXaU9EdVB2?=
 =?utf-8?Q?hqe+2f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmlZWGdLV0NTUjRpaTFmZC9uZzN6RHRYTUErYnF1QnNWa0ZrUERVeEZYeE51?=
 =?utf-8?B?M1c0alJjd3U0S01qa0MydnpYeEpUaDAvQUdoanJIdW1vOFdrMVVlUmVoYk9a?=
 =?utf-8?B?OFFzUUd6U1kzWDN4bk5iS2dnMlZ4YSs2cGJLYk1qUFVhUVR3OW9DUTFERUI2?=
 =?utf-8?B?VzlxdHl3U1BITHBKcWFyb2Q0aEdDM1MwRXdNckFHbWlCd2J5SUdLU0V1dEFW?=
 =?utf-8?B?NHcvRHR0bzJyQjFiRStGTlF6RkhKc1BHVlZXVFY5UDN1dDBwSEJqNk1Dd28v?=
 =?utf-8?B?bm55NFBiKzk5cU1EdmFnV2ZUaG5zWmpKUnUzOFIvc1JseEdFM2s1VGQrcnhp?=
 =?utf-8?B?a3Z2akxTaFNNanVGSGFNbmVJRkRBbTdqRW00Wkg1YnVhdmkxYzhJNllOcnU1?=
 =?utf-8?B?SzRHajNkMHEzbGhDQ3ZiOXUzeERzWVE2dmxTbWxXYThxUE5WMVZ2Y0VGdXYr?=
 =?utf-8?B?NFpXbDR0Zmk2elJSVkphdnFqZHE0WTZPbitwTmdkZkhVOEx4V0NYamlmWjV3?=
 =?utf-8?B?VEJzTDMyaVR4ZDVtNXpSM2NaaGNVWWZ5YzdUY2oreVUrbk5idU9UbklpR1Vs?=
 =?utf-8?B?OTBhMlhVallobTVkZlhQOURuc0ZYL2RtNy9mNnByRThZOGl0OS83TFhUcGxk?=
 =?utf-8?B?MWk1OEhROUduamtvRkx6NkZNdHNxenpPK2U4d0JlZkt2YjM0a1ZPQnJaZGFY?=
 =?utf-8?B?ZWVjVGV2MytSQ2MycW15bjhlVEYrY011ZjdCUm9zdnNvaUpIZkZwVUFzTUln?=
 =?utf-8?B?S1J5Y2FLdWp4SUlPMFZpQmMrZGl6azNDUTNmZDh5TGZsNjhQay9RVzE3Q3NM?=
 =?utf-8?B?NXh2L0Y1VDh1RFhTdGFGbUZZbHZUY01pcHVmS2k0QnRSS25QWkJMNG5jY3RZ?=
 =?utf-8?B?MnR6dnQ4T2NlM2l1VDdiTC9LMkdXSk4xaVMxeS9KUGtSMHB2L2hZUDBCQ1JU?=
 =?utf-8?B?V0hhYkpNNW9sbTlWeDMraTdZTFk5NUJhWktSQjFTaHRQOGR5RTUyNkVEa0JV?=
 =?utf-8?B?SDhJb1lnQkYyOFdqZFJaSUxhb0VrRG85cjlwTGw1NTVMN2sxZXRBTllEMXRu?=
 =?utf-8?B?MERtdzBORFVEb3l1RWtRRjc4SytHKzY2V3J2LzN1S2ZhYURKdmhWcEVMazMv?=
 =?utf-8?B?dFY3VkZBR3lZazlrL2VTUlRGTjEyRmZzWkI2NE4vbDlHOWlQMVkxNEJXWWhN?=
 =?utf-8?B?SWJDQUtUemprbFM4RmVOOFdmVjRHZk9RclhzK3djY3RsOWgxMXdENEpsWDFy?=
 =?utf-8?B?amJ1ZDUzMFRQMUNjUDhRNG9xcHRCVnF4Qi8rcEhZYjVhckxWc2pSTFFZVUYw?=
 =?utf-8?B?dmxYd0tXMXovZ1NDd0UyMlJlNHZoOW5waktQOE93U040ekYwb25zeVJVRFh0?=
 =?utf-8?B?ZFJBRFBhQWZKNHVxZEk4MEFuWGZ4TkdNNHNQZVVXdHY0cmZBQ0RVZFNCdGFa?=
 =?utf-8?B?dWRJQ2kyUldWckhPaUN0RHZtMGhFRmMxMzVVSkNvVHgwVHVNQk12aGVBb2Vy?=
 =?utf-8?B?NE8zN2ZGTkVjdCt2ZXNySytHdVVyYWJNZXo1ODMzaEVFbS9TQkZOUVk5ak1q?=
 =?utf-8?B?MWphby91Q3BEQkxCUUtqVWplQ3R2TUgra20xaENlWUpWU1lLWURDcmRMbmNY?=
 =?utf-8?B?cnN1S1FRVUs2SW5TSHpHVHJOMERna2R3cG9jTmNiQzFJVUEyRFk0bkZWRHJT?=
 =?utf-8?B?S21JYWdEYXBKNVYyb2ZVRVVJYVcvQ1h6cWxPMisxUlZzcjRzMUFDQ290TEhN?=
 =?utf-8?B?ZFlOQmt6aGViODFQRU9pV3FBS3hVSVF5WE5ZZ01tT3p2UG5zK1ljc1lPT3Iz?=
 =?utf-8?B?ZEtnNXBLMVVjNGhENm0wUE04ckVsZU9tTW9aRVg2TkhkY00rYTFTS2tGY09E?=
 =?utf-8?B?emVnOHdBUG82MGpNWFlkZ0J2OEJjMW9XMHhQdkIzakVJZ0lIMFY0RHZuMXR6?=
 =?utf-8?B?OWVWRW91WnVZSXdCVFRlaGNpNUoxWkdFRTBYV1B1MjlTd0ZVOXI4V1dIQ0Mw?=
 =?utf-8?B?eTlrNUIxb21vWHpsSjRrR044OStmN05seWdZdGN1SERuajM1bHJUdnlWNDVv?=
 =?utf-8?B?UXYvTkJMdWJxTStxek0rTkhobjJZNVh0dEtQY1hBdXpjMFFFQjNUYVNrNENY?=
 =?utf-8?B?azRrbXBZZXhndDArY2Rmbm82NVY4TW8yOVdTWEhwQ25XejBkbU8zVS9xZG9u?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8fff2e-fca8-4164-5433-08de32666e01
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:21:04.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIVN29ngjLLpAh52fWm835Stnp3m9ZMuMNanGAzjkYMxJdmuWuDoEJ8POqVczAtrRlv8jTXGiZgv5zspr9jrNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7257

The AD9211 is a 10-bit monolithic sampling analog-to-digital
converter optimized for high performance, low power, and ease
of use. The product operates at up to a 300 MSPS conversion
rate and is optimized for outstanding dynamic performance
in wideband carrier and broadband systems.

The scale table implemented here is not an exact match with the
datasheet as the table presented there is missing some information.
The reference presents these values as being linear,
but that does not add up. There is information missing in the table.
Implemented scale table matches values at the middle and at the ends,
smoothing the curve towards middle and end.
Impact on end result from deviation in scale factor affects only software
using it for scaling. All the possible hw-settings are also available with
this implementation.

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f7a9f46ea0dc405e25f312197df4b2131871b4bc..13c8eff5bc103ba6161dcd92b928c5fd96b57b97 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -81,6 +81,14 @@
 /* AN877_ADC_REG_OUTPUT_DELAY */
 #define AN877_ADC_DCO_DELAY_ENABLE		0x80
 
+/*
+ * Analog Devices AD9211 10-Bit, 200/250/300 MSPS ADC
+ */
+
+#define CHIPID_AD9211			0x06
+#define AD9211_DEF_OUTPUT_MODE		0x00
+#define AD9211_REG_VREF_MASK		GENMASK(4, 0)
+
 /*
  * Analog Devices AD9265 16-Bit, 125/105/80 MSPS ADC
  */
@@ -234,6 +242,17 @@ static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return 0;
 }
 
+static const unsigned int ad9211_scale_table[][2] = {
+	{980, 0x10}, {1000, 0x11}, {1020, 0x12}, {1040, 0x13},
+	{1060, 0x14}, {1080, 0x15}, {1100, 0x16}, {1120, 0x17},
+	{1140, 0x18}, {1160, 0x19}, {1180, 0x1A}, {1190, 0x1B},
+	{1200, 0x1C}, {1210, 0x1D}, {1220, 0x1E}, {1230, 0x1F},
+	{1250, 0x0}, {1270, 0x1}, {1290, 0x2}, {1310, 0x3},
+	{1330, 0x4}, {1350, 0x5}, {1370, 0x6}, {1390, 0x7},
+	{1410, 0x8}, {1430, 0x9}, {1450, 0xA}, {1460, 0xB},
+	{1470, 0xC}, {1480, 0xD}, {1490, 0xE}, {1500, 0xF},
+};
+
 static const unsigned int ad9265_scale_table[][2] = {
 	{1250, 0x00}, {1500, 0x40}, {1750, 0x80}, {2000, 0xC0},
 };
@@ -297,6 +316,10 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
 	},								\
 }
 
+static const struct iio_chan_spec ad9211_channels[] = {
+	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 10, 's'),
+};
+
 static const struct iio_chan_spec ad9434_channels[] = {
 	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
 };
@@ -369,6 +392,23 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
 	.num_lanes = 6,
 };
 
+static const struct ad9467_chip_info ad9211_chip_tbl = {
+	.name = "ad9211",
+	.id = CHIPID_AD9211,
+	.max_rate = 300000000UL,
+	.scale_table = ad9211_scale_table,
+	.num_scales = ARRAY_SIZE(ad9211_scale_table),
+	.channels = ad9211_channels,
+	.num_channels = ARRAY_SIZE(ad9211_channels),
+	.test_points = AD9647_MAX_TEST_POINTS,
+	.test_mask = GENMASK(AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE,
+			     AN877_ADC_TESTMODE_OFF),
+	.test_mask_len = AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE + 1,
+	.default_output_mode = AD9211_DEF_OUTPUT_MODE,
+	.vref_mask = AD9211_REG_VREF_MASK,
+	.has_dco = true,
+};
+
 static const struct ad9467_chip_info ad9265_chip_tbl = {
 	.name = "ad9265",
 	.id = CHIPID_AD9265,
@@ -1264,6 +1304,7 @@ static int ad9467_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad9467_of_match[] = {
+	{ .compatible = "adi,ad9211", .data = &ad9211_chip_tbl, },
 	{ .compatible = "adi,ad9265", .data = &ad9265_chip_tbl, },
 	{ .compatible = "adi,ad9434", .data = &ad9434_chip_tbl, },
 	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl, },
@@ -1275,6 +1316,7 @@ static const struct of_device_id ad9467_of_match[] = {
 MODULE_DEVICE_TABLE(of, ad9467_of_match);
 
 static const struct spi_device_id ad9467_ids[] = {
+	{ "ad9211", (kernel_ulong_t)&ad9211_chip_tbl },
 	{ "ad9265", (kernel_ulong_t)&ad9265_chip_tbl },
 	{ "ad9434", (kernel_ulong_t)&ad9434_chip_tbl },
 	{ "ad9467", (kernel_ulong_t)&ad9467_chip_tbl },

-- 
2.47.3


