Return-Path: <linux-iio+bounces-26970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAE5CB06AB
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 16:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59B96301AF67
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD692FF675;
	Tue,  9 Dec 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="d3Q0mmgi"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023085.outbound.protection.outlook.com [52.101.72.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476ED24A047;
	Tue,  9 Dec 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294750; cv=fail; b=P3dCyXTU8hr6tHhcR7Hj/HMSoc8zG5a+1jsxjfg4YBWBWlJTd8FtfsbmeRRzl/Vd75b1agJSYSJBmwz9WxTzmDht2jW5lweyoYyQoTaf8F4GN2UBhE6fjnTSeQ0pYXrgrtqUPi6NJEa2k22XNlpcb/1LsQT5f4kpiHWLcnf84aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294750; c=relaxed/simple;
	bh=rx43Kic18MYe2iZlSH1eEQWf+qgn4vWngsPLGBg4uGc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=jAyU8GjYAB0hiDsmkqsVBAfoCIh6y0rWysNVYirdE2Jy/rSDKOjVYkxnVPk0aBDNRwgwvvgSlbwRAQwSJZY99HKvSoYgKp/C5N8lzgbrVfzk2II02kZHobAEQX9yiJpFyYHbhr0CaEPy1xK8jdj6a+kh33nuqriT0bjkPeSWsJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=d3Q0mmgi; arc=fail smtp.client-ip=52.101.72.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyFrQwLpYZ6LGVYsLXxdaZdpLV7dbB956YK8LE+8Iy8tnu8Z8yZFI/E9DLD3uN4YezZYKSYHo8qp3R9RVPhcAfSFQRLaRRFKaWka98AZVyB9JaNyZ3ueo7KQOv3K3oMlNzHasdqkxO8tPR/7PttWWV3RreKhDIniWgsFJPaW78o2tq15EFtWwhCLrhZ/mdnTrVri8dCoH+bHtnURqRQWdeAQFmpuir/kVXHEDh6S43gDjsyKM3WPIUW434/UxeUJXFwpAMw8jAhuMOAKQb7lNYqmpVYobgZ3tt4sAvEVfw5F2Lw0vcTDczYGxemokbVthyu+g5NYhR0yP7+UVQg3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7CIUSpJ1yoLKhSDu3AWh9ByLzDh/dNVRyVw3h34jQg=;
 b=c31iigkYTV1zu/UNqF6djv5xlE8Z1I3h6YSXISPEk0NSQkWL1A9pNd+pQFr8X4F09cck19IDZwpF3/Znp9rTq9Rrentwxdh6ZlWo1WELzOg+Pc+bSvWRudY2DsqNW6q9eWkEOIx6uIyHGdVqtTGXCYrJSsg1em7MQRbTClRc4TRk27Jo1+ytcfCMeILDa7JgTTPqo6t8IhCeGPXG9WZRz8De0eloN6iQwHkFZ/7O2z/Kp2Ia+eF4f9yhxql4bnjbOO0+kPdyJiVDbj7tJiCPUrJrIFqbsvD9zCv0qShxFo3hK58OCouxXT0xQxOtKv3NjgiQ4XUGBvnxwLoxfuc6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7CIUSpJ1yoLKhSDu3AWh9ByLzDh/dNVRyVw3h34jQg=;
 b=d3Q0mmgi6Yh3oQVQSzyOY8xmWrUO43p8pX7UwdzNlggAk9gHOnMgjuQL5ytdQ9++yARiQ2W4xQyve9r36gf2fy44ctYT59ro2/qfoj+W67vZBBLv4m62/8cqojgLAnpwoLN6vmOIRIfcTrvjL07G2xuBZkafXBbE0bIxYWaw04VHDQxTHSRkI0cEpsnlpT08aydyK+fsjNjgYBB+DLvzaykAa/6DRoNk/+lVKsMy4wxdBFIaqvRvBHxvk9kJGnmjh+Yv/XiUNiiuonYSacTXcRhKLTupriZbZKWfpCRSgnXFx/ZijegAStl+58cIk4X7TAsd+UXGlLAEzBw2ks+bCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PR3PR06MB6667.eurprd06.prod.outlook.com (2603:10a6:102:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Tue, 9 Dec
 2025 15:39:01 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 15:39:01 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v5 0/3] iio: adc: ad9467: add support for ad9211
Date: Tue, 09 Dec 2025 15:38:09 +0000
Message-Id: <20251209-add-ad9211-v5-0-8da056eb62e9@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGFCOGkC/23PwYrCMBDG8VeRnM2SmSZNx5PvIXsIyWQNrFYaC
 Yr03Xf01NI95PAN/P6Ql6o8Fa7qsHupiVupZbzKcPudiudw/WFdkmyFBh2g6XRISR4hgB7Ip0i
 dszA4JeA2cS6PT+z0Lftc6n2cnp92g/f130wDbTR4w+S5Txng2EKp4Td8xfGi3qGGS2xXGAUHc
 D1k8p7ZbXG3xMMKd4KjJflIDgTRbrFdYlphK9gggs/WABKu8TzPf0x+TZ9dAQAA
X-Change-ID: 20251203-add-ad9211-897dc9354185
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765294730; l=1841;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=rx43Kic18MYe2iZlSH1eEQWf+qgn4vWngsPLGBg4uGc=;
 b=J9wFeg+fa178ZUrmLJsK1C1RjJRU/WDS4oci/Qq0aoccbd4ipiPx5929hjLs0XjLr69n6q5SU
 3uQnXj0YSKVC973rqsOJsFV89HBtTanLNCpGAWVFKQRrvAjvbDAie8U
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
X-MS-Office365-Filtering-Correlation-Id: 0a408d0d-0508-45c4-84e4-08de3739135d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MERFMTBlUkh2MHIxM3Q3Mk41enNUQmo0S2w3MVdoL0RmakNUckluZWZOaE5j?=
 =?utf-8?B?aEJHWCt3d0dqcys4TExlelJRNkh3T3VnUWlVMzJrbTYvSFRON3E0MWJZQlRQ?=
 =?utf-8?B?a0llT2duWjhXL3FHUmlXT0V1aTJrVkRIR2x6dkhGRGZBTG00SDIyb0VxNHRM?=
 =?utf-8?B?N01MMmpMMml5aXp3ZlkyeVc2NHo1SVkwd3RmMFBEc2Q3VTFlSHJVRHRGazRi?=
 =?utf-8?B?WlB4R09qeDJhUzE1ZWlkZ016Q25FZS9OWFQ3Mmh1cjBpTFdIRm5JNjdkSDAr?=
 =?utf-8?B?bENBSXRQeE9hdkd0OTd4S2JFajh4WTFDaXp6NkR2RjQ2S05zek04Y3JsY2NM?=
 =?utf-8?B?ajk2TThYdU5xQTRNSnIvYWdZMFdMWFdsQUZVeUJSK0duV3hRQmVuS1QvUDJK?=
 =?utf-8?B?VGx0OHR1TWo3OTRmbTJlQUdmWlRBR1M1QnpSUGRjUVNXbkpzVVF1NFFjaG9R?=
 =?utf-8?B?WUpHTnZNY3I3Y09OTm92R2tHVFRGNkZVcTQ4N1BMUi9KZTBadFlJMVFPbEpm?=
 =?utf-8?B?d0RiM01RclBDbVJBZjVtSzNoVnlLVjdaQmowbDd1NjhEUW9jQTBiM0JWTDBK?=
 =?utf-8?B?TTUzeW9uQ0JtS1pJdjhURVQ1MWdVQzVZcENramFCTDNhd0dybDg4OVdYRFRj?=
 =?utf-8?B?S245bHU1T0VNUDIvL0dEZzZOMTdROC9WamJDbVptZVdSV3ZSQkVrQmppOUdx?=
 =?utf-8?B?QU9pK256MTF4TTRCZVRibFNEMlZkazN5ai9CeDBnVVhTQTU1cnRxNjVyR2l1?=
 =?utf-8?B?d0owRVZjZGp3ZFBVSG0xYTVUMnhNOHNTeUZ5WTRXdDM5Z2JjeHBZbVFmRTJp?=
 =?utf-8?B?dlh5UTYyR3NOWTE0KzBnN1VydkVQV0lmY0FNWDlrZ0kwNWZaL2Z5MEM0NW1R?=
 =?utf-8?B?M0plbnhEdFBvUlJ4T0pmTXJmSFNBa0ZTb2RFeG5zeTRpWVRNN0NPb3JibFp6?=
 =?utf-8?B?OG5lRi85S1ZoUEx4MTF4YmNHa3pJMlNsdTZxMTRQRDhqdmlVU2k3dUhuckN5?=
 =?utf-8?B?SVpXTnRsaGpUOGF3L3pmZDdJR093ZWd6YlZMdXNrTHVlUFpxU0RKSC9Kajhh?=
 =?utf-8?B?S240UWZZbzZyYlBldHUvNFZOT2c3VFJidjlPNFJZejFtb1VQaVNEdkYzSTZa?=
 =?utf-8?B?cG52OUI2WXlLQS83Y3Nac25ITFBrQjBHVWdtQXBIVmwvY2hNNTRrbzNYc0Qz?=
 =?utf-8?B?T1JObmtwWnJpUEVUbDRPNWF3ZER5T0ZyL1RodnQ3TlBGbjRmZFRMQ0hoTkwr?=
 =?utf-8?B?czF3WG5lLzJGWFhUbUF4VU4vall1Z0wyY29ndUROQzVLeThSVkR3bXBSR0hH?=
 =?utf-8?B?UTNtZEFvcGtoL3l4dWp0OFdXdzR2bjRlc3ArTkUyMFhCT3BVZzRnQWVTMEo2?=
 =?utf-8?B?N0ZhYnRwMjIvY1RINDBJd2FIV3d1d3lweVd3V2NrTDRMWGRqckJTWEJVZlQ0?=
 =?utf-8?B?NjcyZVpRYkRFaFRnUTBkTERodlV1bGJ3Zk5ISkxiSVZsNGVETHdMd0NnQzRW?=
 =?utf-8?B?d1FQOGwzYWxQUE14VzNMNTNINUh4TVp5MWRYRS95c056YUFZQVZ1WjlpYTRn?=
 =?utf-8?B?T0hpZ2U4bXJuUkFaM1JiWHNsTEx4RDhvcm1wVTZ4ci94Z2hWNjBwcDcrUmow?=
 =?utf-8?B?VWV6YlI0d0o3RjY0azdQaDNYWGMxaWxzcU8zZGxVY29wem5wbWNLbVlxeFpq?=
 =?utf-8?B?RGV1THN0bFc3T0VMakZJMWZ5dCtmeXV2YXIzdDJjRnpUdTY3dlJEU1JmZVRy?=
 =?utf-8?B?ZVhkbkFNQ0l6Rml4VkJhSFFCbk8xRzZQYjlIQkZuaUN5dUx0Z3RHWFM4TVZi?=
 =?utf-8?B?VlZ3YUZtV0R0WTVLVHR3Sm5jajZZZkpuK3RtdFRNTDBBVWppdU5aY2NzdkNZ?=
 =?utf-8?B?MUZ0OVZBT0tDb2Uwamtwd2NXbk9CVnAzZHZUdk9CUUlyYWp1dXBHenFFazZW?=
 =?utf-8?B?RkI5a25ybG84eWtTWmU5TVV2Ymw2TXJOVGZwVFFlUTJJTjZDb1V3cC82Yml6?=
 =?utf-8?B?VDE0ek1ZaVk1cm5vVDNuVEVOYzdQZ3kxYU83a0F2SDJsamlIQ1RuZE1jWFVO?=
 =?utf-8?Q?+Vo0Ji?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlQ5emh2cDM3YURJekNwb3drQTk5a1NtalNPR2dVVncxK0dBSm05V29odzNj?=
 =?utf-8?B?ODhaMTRLRzBzWkR3YU9JTk1BU2pVZFFxeEt3cHoxTERjRmg0Z0Z4WEc2QWg0?=
 =?utf-8?B?SUxHeVlFN2hhd2MzcHhCMllkTVBLdUZxM28weGd1UWVhKzRDMWVLODF2Y2Vr?=
 =?utf-8?B?dlYzZFpxMnJXenVORmtQSmdaZUhIVkVpVW5SZ0czTThiZ2Fxd1U0U0xKd1Zi?=
 =?utf-8?B?UGZJbmt6TlMxeFluRW9wMCs1OGY2QUU3cy9pWS9RRVhmdW1qWmxCZFk1bm1E?=
 =?utf-8?B?S0JiUk5CenVLN0xiVXRzeUlSa3I4dXVhMFE5dG4wNWp6bVRVSktzMjFlVXZL?=
 =?utf-8?B?cUlsa01SMlhwLzZXcy9aTHBGd0ZWY1JaU0pRdXZCV1hHQlR4YjJFektmRXZh?=
 =?utf-8?B?b2g1TkFlbjlKZFVNRWZBVDFpamlKaXJ0OU9Zc3UwVHpYU0NDOG5jaGtrOWMw?=
 =?utf-8?B?QzdxSTdsNGl2RHlFanVoY0hIMDBLcjVmMVROSWxHSXA0VkJMSVpXYlMxOUk3?=
 =?utf-8?B?WGRROW9sd3B0UTd5amsvd3hVdGlObStxd0xteFRsTndDdUdzaXdBSjhXZUE4?=
 =?utf-8?B?REd6ZWhxSkFPdmhScFQ4V3NqTEpuM3FyWjZVd0ltaWZ2ZldiQTZYWktnU2E4?=
 =?utf-8?B?VHExSXhrVXNraHQyb0hNeXJqNnZZd1J0eUdpV0RwRTg3b0FYZzVSU2RlOUdl?=
 =?utf-8?B?ZXpkRlpsUEZWai9EL1NKWDBzSHdsL2YvT2VIbGtoT0k4ejBORHZ4anJaOENL?=
 =?utf-8?B?d09BblpkWDNZem4rSUVBamdUb0g0OFBkaUJsbSsxb1ZSQ3RiZkdWdktZT3Nv?=
 =?utf-8?B?c1pDcUF2NUlCL0NKZXFMRnE4UDNhNkpOM0pxVDA2T09oZy9uc0pxdGpHUmJv?=
 =?utf-8?B?QTM4WmtNMC9HalFqZ1h3Qm1odzhpT0VqcFBiK1IvUVVTa3MwbS9WWEduUnJj?=
 =?utf-8?B?YlNsTkJEV3JDU2F4VnU1T0xKN2w2VXIrNm5ySU9qRnNha3dSQnF2UmY0ai84?=
 =?utf-8?B?VitxKzMrZHRwNURBZTlWQm1sYkJFak00ZzFUblVMLzh1S1NkekRSRTlBTGlr?=
 =?utf-8?B?c0hObExmVG85QkRFSjJrS1lvTVFyM1lVdTlUejJHRERmZWwxQ0FjczJZSjJm?=
 =?utf-8?B?akhzZXp3UEM0VDJCcnQ4RWlEbjFyZnFlM05qaFdVS1ZGSWJsbU5DZ0NGbE50?=
 =?utf-8?B?eDFZM0NJOFl3YkhqeWZwallna01UcjdURmxjTFFnT3VKRTg1MkxWSFlvc1gv?=
 =?utf-8?B?cU9TVXlKZWZET1V4Y2dFTFBzbVEwYXM5NUdvZ09aRHdGUnRMcFJBQkp6V0tw?=
 =?utf-8?B?c29BdnlJOE42dGs3ekt5NXFlaHZzVVJ1QlFjM1RCelQ4a1NBTHJJdWlWZkZI?=
 =?utf-8?B?c1Nyd0FITnJrYnp4ZDA5dlZINzh3OEZ3YU55cmthNFRyRlB4VWZxMmduUmZ4?=
 =?utf-8?B?WXR5NHFCVHpiUm1jdkdmdVFMOHhCRE8ySEJLOHNiUldiUHlHTDRaejhFQ1h6?=
 =?utf-8?B?UkIrUE5jNWdLQU52alVJMzY3NVpTVng2cG9XeEFkTW9FRFVuZ05kN0xqUCsx?=
 =?utf-8?B?RC9NYnlDdkdmT1FTY3FqdHdZS0twcThKTlIzNURNdnVQbm5ST0U5VWY4OGty?=
 =?utf-8?B?dFZPMmdhMGlvMElPT1NHRGZ0QU1HeU5LR0grbFlTZ09XRW51M1NsOWZkZHpB?=
 =?utf-8?B?NWlRSkNSME9pOXVjMkxFNlNoZWhwSHpyR05KdHVUNmZhMUgvZ29lcFJNZGRP?=
 =?utf-8?B?bHM2NVJaanVTZXFBRW5VRnp3UVJMVmh4Mk04Q2FiNDNWcGM0Z1hmUHA5ZSsz?=
 =?utf-8?B?amxnT1hma3kxNGc3UDZ5TTdwSlJuckM2bkJWZWlhYXJ4V1U2RVpNTjd5VjZu?=
 =?utf-8?B?UHRFOThSTENUZ0c1Nkd0NUdVSUhxYWZWMEJyd0xURXdYMW8weVJ4Wk41SW9D?=
 =?utf-8?B?Z3FKa1dGbEx5NlNDUUNqdkw1R0Q2cHRtRmo0SnVJYVcrUDV3UEhBTzRyL21S?=
 =?utf-8?B?R2RTNnpiaExGbWpqTmlXRU1PQUJKZnRmbzZWSnNCMTZlbVo4WlJXU3RMdmNM?=
 =?utf-8?B?VHE3WnlaeExUaW95TjJoaUlPUmdtVkFIdGRySUpQdmdEVjN4bm41RGgvWkFi?=
 =?utf-8?B?b1lXaW1nWG9kNmVxcW9ncjI0YUpWTEV0S0xkOGU1N0RqQlZReTRUOWxrSm5x?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a408d0d-0508-45c4-84e4-08de3739135d
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:39:01.1517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ltCSET+iY2m5aZJyH/XUN5QDbYEWotQ7XHmqcDG1TEWr1XHI95ZwaIatRNXTM6C0tz8j3lkLEzpGN3y7lWS+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6667

This series adds support for the ad9211, a variant of the already
supported devices.

Example usage:

$ cat name 
ad9211
$ cat in_voltage_scale_available 
0.957031 0.976562 0.996093 1.015625 1.035156 1.054687 1.074218
1.093750 1.113281 1.132812 1.152343 1.162109 1.171875 1.181640
1.191406 1.201171 1.220703 1.240234 1.259765 1.279296 1.298828
1.318359 1.337890 1.357421 1.376953 1.396484 1.416015 1.425781
1.435546 1.445312 1.455078 1.464843

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Changes in v5:
- Sort header includes by group
- Link to v4: https://lore.kernel.org/r/20251209-add-ad9211-v4-0-02217f401292@vaisala.com

Changes in v4:
- Add commit which sorts headers includes
- Drop array_size.h patch
- Link to v3: https://lore.kernel.org/r/20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com

Changes in v3:
- Add Cleanup kernel.h in favor of array_size.h patch
- Drop redundant empty line
- Amend commit messages
- Link to v2: https://lore.kernel.org/r/20251204-add-ad9211-v2-0-a1561f977ee5@vaisala.com

Changes in v2:
- Use HZ_PER_MHZ
- Update commit message texts.
- Link to v1: https://lore.kernel.org/r/20251203-add-ad9211-v1-0-170e97e6df11@vaisala.com

---
Tomas Melin (3):
      dt-bindings: adc: ad9467: add support for ad9211
      iio: adc: ad9467: sort header includes
      iio: adc: ad9467: add support for ad9211

 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |  2 +
 drivers/iio/adc/ad9467.c                           | 61 ++++++++++++++++++----
 2 files changed, 53 insertions(+), 10 deletions(-)
---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20251203-add-ad9211-897dc9354185

Best regards,
-- 
Tomas Melin <tomas.melin@vaisala.com>


