Return-Path: <linux-iio+bounces-27668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8115D18A64
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 13:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D9CB3045CD8
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3543138E5EC;
	Tue, 13 Jan 2026 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ZlYgXSRy"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020096.outbound.protection.outlook.com [52.101.84.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1876838E5CA;
	Tue, 13 Jan 2026 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306388; cv=fail; b=WrDT28xVjWcxaLaU8kgXqqPfWcaOYkdRbgnJUWlEdyLgGcv53L4NCZPkPk1hSkg5Tda3g26kwM+wEG9NwPfB/jBEq03I9TGQbaAmWgNOKyFGhswQG+MacEWwUyDJkKQZ0a1S1/HOOSEQ6lDgPpipNmLzP405a+rS9q63Z9vAwsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306388; c=relaxed/simple;
	bh=/HZcbYWB6bVqFAEBi9w2CKjjxMUaYMBIN7m23Qdpml4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EAuFcHozo52fp4F3eMmuHTY02xxPDlGf1AHuwmqFXr4af0IMdhT2RdC8/EH12S8IVV6+FcCi2SePqjNBYtXXzpQGdQikH0ncbqhnihDSiAQAXHiSk8S2Mxji9sTaKpCnctznvMnDIsq8LCxktfaJ+g8B7WVByJL02sUh0xpAcfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ZlYgXSRy; arc=fail smtp.client-ip=52.101.84.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JExVydOuGeJCH8JmrNVkVYUmMd2t0L+C9wn4zgbuLgr61CxZOPF00W84MCC9mJrMXRPoB46fmnKQiW3/C49QCz1okAqN1op3FrAmgihmElkUUZ8wX9XImj5dFoU0xOibB0qau/dD3hCpkHoQjYHL+h+1E8k2NytW+hrtrfb+zAaODhxvTufvg0oARq1UtQ4oy93aeEVspAEPiBke/ZiYjcaYg1dJr0D+Sej2ZuX7/FlUjrKmh4XCa39/nhFWLOtJ0s/WyC3N2/ja1zvj5hhoOMzvZ2xdDC1y0NcmRJBS4yIRPN/sDi6Ps77RLrduPpQSlQTtwMTh4SjXDXE7QoZNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3hWUH6oSfe72vLouICPe7yktgYiEa5cEzjUuBzsZRU=;
 b=DCC/h79tje/A0bLVgg4V2yCsMkx1h3QQUrDgYuT22sYjNoPDFPcJGzx3SSjiIYCDLtCnv7XnM9taB8H2CmXW//rkaWRPI53qRjrRbRnRqX1b8YUCBFc/gE4h7ZRf/nIKXp4o2ZGkf5LW38QlkW6U42cmD86Qz3zVBvMKi2LU7Hs6IzYYuX2jLzSh42cyD/ItJGd4wuUnHHf41RwhpUwO1BSCt0Qt4JU2DVS0lko3/4DeDjE8ICWv3wKNjYXWDm/WZPCRR3xYRlAEVzcSB1NQ4RatOtN5P5DMqlkSTNEZsp0Uht4iTh0sEKljqhugiSL/RlQAV34F//eCW3VVJWTXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3hWUH6oSfe72vLouICPe7yktgYiEa5cEzjUuBzsZRU=;
 b=ZlYgXSRy58xccbR6XzH08+RXZRNsI5O1Jq/hkb1qe3nbmcllgiMWT7j/IrWZk3Gx2IyIhAskAzJsZVOycKoqvnntLJJtLJ06u1mtizA2vLKgSIc5CtdKOBQU7knjfP9p7FQYxwvXLwq9i+Nm8WlvPNoTRDToxaeF6t8iRLT5WKifexIDVphelyqgB+V60GxwBcp5qXbMjy7dVofiUrXNPFPt+ntv34xvfuCmK9zj0ypARv7TtXK6FycXJ5TiswCjdRCk3osuUzL5IDge0eeWYHFnXjX6b7VjnD72vYhbRnOzszoQVPnwal3fftE44m3QVandUrHhqUsFN6xZ5aZ6+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DUZPR06MB8963.eurprd06.prod.outlook.com (2603:10a6:10:4d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 12:13:00 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 12:13:00 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 13 Jan 2026 12:12:47 +0000
Subject: [PATCH v2 1/3] iio: adc: ad9467: include two's complement in
 default mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-b4-ad9467-optional-backend-v2-1-0a27e7e72f41@vaisala.com>
References: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
In-Reply-To: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768306378; l=4993;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=/HZcbYWB6bVqFAEBi9w2CKjjxMUaYMBIN7m23Qdpml4=;
 b=Njm/bag52ccATpT07dM5LujWoFFLlEJtaaglxiOmOBh+wx+5Dg4UsNNqsvCV7gWhadI1f6hpN
 dl6MCtYG+kRCmd09bVPo5V7UCrwGLz0qduc/iAz+INl521Q3o5JrZiH
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVX0EPF0005F6A1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::129) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DUZPR06MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1ab48a-f7c9-41c2-74b4-08de529d17fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnkvZ2xkRlRKYWw3eUVNOGtWcS9ac0kzem1JRlFhbTYzWVZMM1FTRDlPWGNN?=
 =?utf-8?B?MDByc1pjVlF0enByclF2K3ZWcHJUdy9INm5CODdCdUNKd3dhSTFIS0ZKL01C?=
 =?utf-8?B?SXRweTBTY3FZSE1WNFFSU2RKUGZTdCtwdStPcEFsZUpuYUp2L3A3anlDNzlr?=
 =?utf-8?B?K2VkN1BscEp5K2MvcEtkWmxJNEJ4bTh5MHZmYm0yNzZTN2x5K1lvSk1LUFdP?=
 =?utf-8?B?TkJZLzZZOFd2VDBWVWp2czJoNHIrWTExL09OZ2lqZDY1bXc3aW5wbHh0L1Nn?=
 =?utf-8?B?amdycC9tK1pVNmFPK2l5M0hBVnFqcnJJYjBxNW9Ga3QwUUZLd0szRjMyK0Ji?=
 =?utf-8?B?SmFlblA5enJHUzFHZW50eW8ySFNlVmxEeUxBa0taODhxTTFKWDBlTExhWXNR?=
 =?utf-8?B?RG9yYmdpVENTL0diV1I2UEJlSWhGUFpJVHFQdy9TOGpKSlNySjFNQ3RVKy9L?=
 =?utf-8?B?UTBRNnByOEtmaUlGVm83Z09TOE5yczg0NlVkK2xRay9uU1g4Uyt6d1pXTktK?=
 =?utf-8?B?TWVTbFI1QnBuMDVqb0hoS054c2Z4c25BRWhIdkx1ZW1iSjl0L1BzeEFJNll1?=
 =?utf-8?B?VDV4MUEwRmR6VE5uWjJuV2RmTDcreC9aY0Q2WlVkb0UwVDh4MDlKS012M1Rx?=
 =?utf-8?B?VCtrZjlSWTJwVktTM2RqNXlFN0ZsYXpIZWJIQkxjeWxHQVRhRU5jdTNaTFdL?=
 =?utf-8?B?cTJtdWU3SGs5OU93emtqck04b2ZWTmJqZU1EcS9WekJkZ0lUYUFyUkVaUFJ3?=
 =?utf-8?B?L09tVVZCZU1PM0EvZ1R2aWdiTTFhR0dPVldsUE83WVh0dTU2U2l4MiswQ00w?=
 =?utf-8?B?ckl1RlFKMWRBRHhFdytwM0dGRTlSdS93b0lnOW03ejhvQ1plNGhUY2F2ZWJT?=
 =?utf-8?B?enplU09QOWtqd3dZaEt6UnpIdUo0RTM3Vyt6UmNaekNKUWVySWlTRXNjd0FF?=
 =?utf-8?B?cUEwVGhqY0h6aml5Q1dTTVlEdm9XTlVnV01RUmx2SmZCZ0NoL2YrME1VMUVM?=
 =?utf-8?B?cTd3NjBEaHZ4a3FXRS9pMHdNVmZYeElmZ3R0THpuN0NGMjFDR1RZVWtpb1Uy?=
 =?utf-8?B?bFJycGEwL01hRXZIZVNSL3ovSEFYanlvQ3Z1OFdXekZkQ3hoT1Npcnc5OHZF?=
 =?utf-8?B?NVUxU2xBL3lvNTNNT1BmZk5tRkZsWUZJS21KWjhmMlc3dHpOSDRMUkozVzdi?=
 =?utf-8?B?MlZIQ0lFdldaMWxnYnpJYzZKRkUyUjZqTWE5SWMxTW5YQmQwS0ZRcE5VU1NQ?=
 =?utf-8?B?My9aN3JwRTRmZDNLNk44UC8yWWh5alczeWRrQ1JmZHBSNHRvNE9ZMWU0OHBJ?=
 =?utf-8?B?RnljVHJ4VXhTQ3dmOWhsUm5TNTJzZW9nZzNhcHRDWmJGaW5KRmxTcUkwQ1A5?=
 =?utf-8?B?Z20rOU1tcFhQUkxvOFdQanJSOGFvdkt0YWlYUzhmc29zUVVyZnZ0TXF3K1p4?=
 =?utf-8?B?NWQ5VmJIVE1mZHVwNmNHOGs5QWlyZ2hpcnFiNHZLUmtkTmFxbG9LN1ZQb3ll?=
 =?utf-8?B?N3NkZWh6TnB0Ym9ITnQ0c1dHYTA3c3g3cCszWlhFTkY3KzFTa21IM2dPdG1N?=
 =?utf-8?B?N0txSDllNUdRZCtCRDdocjdhYUpiQUxldUdoOHU5YXEwVXprc05BaHV4Y052?=
 =?utf-8?B?RkJGZGx1U081U3dsbmpmODhsQThnZThQUWhOZFJkeGN4ckYzM1BsSkl5bmRR?=
 =?utf-8?B?QWV6ejhBMHorejJLOTdDaXpkNnFFRXZ2K1phU0g5aDNNOHZDMGdNMFlzLysz?=
 =?utf-8?B?cWJDZlVvcVRRa2dNZkZOclVwZ2NHSHR5Q3RvZFhBL0dNYjNwWmwyWUV5RHFJ?=
 =?utf-8?B?eE0rVzVRcUR1RXJXZzhZYjc1WUU5cE1jZldyakN5LzhYMGI0WGE4VnVLUncw?=
 =?utf-8?B?US8wWDlWR1czb2czZWNvWDFGS2NIblNMTjJvdlVadm40OGRHZzZJb2RzSEEv?=
 =?utf-8?B?eHE3cnpNN2VaWGgraGRtZ0tVQitiWHlNcVB3NndpNWgrazFWajFRK2NRYnpK?=
 =?utf-8?B?c3R3ejJ2L0N2cHYvckVNYjVIWTlHdUV4VjY4ZjdpcVFqTnFucXhlQmNLekE1?=
 =?utf-8?Q?jqYGpb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUxEOEx1QVFsMk1SRDhjakk5MzRKMmQyR2dFMmkxcGphNTBTSUp0YmtxQkQv?=
 =?utf-8?B?cWIrQXJDU1c0dE4weklqNHpadnA4L3Y4ZVM1SXEwM3JPNzZzSDRaZmlMc1Ru?=
 =?utf-8?B?OC9pNXpPNTJYYzQweUFuU3ExT3dkcHZqU3QySG1xcHNmZXA0MkpjS1ZyclhK?=
 =?utf-8?B?d3lMeUVWbFI1SG44R2xsSWF4dmJlNEZJY0lNQXBYTFdPMkNBWEw4S2tHdTcx?=
 =?utf-8?B?Rkc3YXlqN0YxcnJjbTkzT1d2TFp3MFc1YVVhcDBVSTZOeXVXcWpidmlhQURC?=
 =?utf-8?B?bytnbGVwWkN4d2EvbE01NEc4YnhHRzRyN0FQZzduVm1vMVg1S0t5V2dwTFR5?=
 =?utf-8?B?UHVxc2RtTXFNVHFyT2pTWXBOVW0vMGNBU0liNDFEY0hsK1JlRDlpOGhIYjI4?=
 =?utf-8?B?ZEwrWWRraXRNQ1ZkMU9JTDNwbXhvTEs1MW9Ld3hmUDhGdERobGs4SXhpWE9U?=
 =?utf-8?B?b0ZjSG9ScFlFS1B2N1RCeHppamMwZUdySytXNjBNclRnWS9MVjlVNkgxdmtE?=
 =?utf-8?B?aHZkZmtDN1V0Qk1Ra1g1ZS9USFk0WVo5U0RLOW5pSHpIM0o4SHJDZVozUFBh?=
 =?utf-8?B?Y2piOHN6a1lEeWpkaEg3UG9DbCtnUUNuVEFaV1JFT2ZTNVBHMytkem4ra1Ry?=
 =?utf-8?B?UTM5aVdubXkyS0xrcUlzSHVtUktDNXZuc1ZLcmJsNGJZZGNkZ05oZi9KaFZv?=
 =?utf-8?B?RnpqTTlFNFhXMWhzR3NZQjUyUHp0SnJjWUhuNUN2ZVlpYXlKQ2pGTDNBb0lv?=
 =?utf-8?B?aDJ4R0J2Z0FKdHl1cG91SlVjN054NjFKdGJzNjN0ZUNlMVlJZHV3ZmNWa1Ez?=
 =?utf-8?B?Y0dKQjRkc2VRL2o5UWptWnExclEwaWZVUUlaY1NjNWtxY0NSZ3NzeG5BNStl?=
 =?utf-8?B?WlNOTytWblZyRTJJTHNsYzkrOWplM0xsRmh2Vmt4TTRzZDg2ekRkNlU5MDlp?=
 =?utf-8?B?NC85Wm9iTFFuYk1lbWcxTnJGbUltWFJzSUVteEVRVnBDK0tUK09lbFErcGpr?=
 =?utf-8?B?ZlFiUC9NcTVzTEVrNFVoWXRoQ1pOTUNjZ0VaZWJCL0FiSjVVb1VMUUhybjVo?=
 =?utf-8?B?b1JpZ1MrV0JucDIrWnlXK2VhOFBBTDFFd2tpbi8wdURtekRUaCtIckUwOUZJ?=
 =?utf-8?B?cGppSXF1RFBBQjUxQmtwSE13cUQ2ZFVMTVNpTzJXVDJ0WHIvaG1QRkFZSG9Y?=
 =?utf-8?B?UEU5TE1kR0pJckdxUTFabDZOSjZ4OUVPcUFQMzhiVUtMMlBIbGkxeHc5ZnBl?=
 =?utf-8?B?TTBMWEFVQ25rbTBsdzFlYm5JWTlZUmhmRFlYdnpwcng4VHMxYzk5alNlVDVw?=
 =?utf-8?B?Z0lLeFRlQ2VqYmZ4VktNbVlYN2ZQWDE0RGhRK0IvcHZNS2g4TjZZeXYwbGMw?=
 =?utf-8?B?VlF3bzNDVGVIa0tkR0JKTFd4TG55TUozN1p5MWdFYjhNeWhNMTZQU3NVT1Iz?=
 =?utf-8?B?YkFxZWRsTENFaXNsOWd4Q0R2aWRGUzJmSWZvYURJN1NFc3lIN045TWhtbjBK?=
 =?utf-8?B?bkdFWE1lSmFlemNHQVF6c1Y5K0xtQjEycDd3SjJraWMxUEN4WDZpVk1oc1NR?=
 =?utf-8?B?S09samYwSDNhQm1aZVFETGFsb1dWaTFXWEQvcGZyZy9rUDllQ1RtcExBemR6?=
 =?utf-8?B?WEttanhxNE4wMUhIaGJzeGczbXFKdldqUnhmMHBUL0tLVnRZdUdha25yTWp6?=
 =?utf-8?B?UHErZUcrZHVSU0gxZ1VBdzN0OFA3OWZUZHFIYkVpSjZIdC80UEE3Nk84RWJC?=
 =?utf-8?B?Snk4eFZQakx0QzN5ZEdZZTVoaGJ2bFV4ZmdTcmwyaWs3RklWVWdJS0RsRzZF?=
 =?utf-8?B?QWxlTG01aDBPTjA5THpkT0NzUHRpZVF2THZycnlPYW54TGpHUTlXRmJDdnpF?=
 =?utf-8?B?V3NqdVNlbmlMdnRURVBrMFQ5TWJRaDBrMlhrOHJudGRodjNFZnZLd21LdjVm?=
 =?utf-8?B?ajFOMEVRYnlSVlg1R1RtdkV1b0JBb29zSC8xNEZFU1dpY3dqK0g0bXZLay85?=
 =?utf-8?B?RmRjL01jaTdOY1BOSTUxK21MdFBiZGZWLzJMemc3VTMxNUkzZVJxYzJiOHJG?=
 =?utf-8?B?eTNhNWczQTYzOVAxWjRxMS9QZlcwUi9GR1Y4bmFPZ3hzSWhxSXlPMEJzaUZB?=
 =?utf-8?B?azRoa2s1SGVtcFo3TFRySVNncmM1cVZGUWRnQzN4QnlZSTJ4cWY1U1NXVU9P?=
 =?utf-8?B?Q2k3amJBSmIwTUdlK0RHWXorbEttbUdWZVM0clNFL1FhS1BuM01vQnQ5MmlO?=
 =?utf-8?B?eHd5QTJNazhKelpwNU5uWHhnRkpDRWs0MXY0cExzU3RpQWVCeVNYN1k2ZVNV?=
 =?utf-8?B?RHVxOUlOdjNGTjBGVzliZXAyUmpjQmtJTzlRNmR1UE82Z3dleDM5Q3p4VEpz?=
 =?utf-8?Q?thb1DBiAAI5V5G/o=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1ab48a-f7c9-41c2-74b4-08de529d17fd
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 12:12:59.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KduCyPTyc6EcVkuJbVu3xj8bsyuTc41j1+Ne10zFTrSMp5wU6lmDYsTrpnc9m5PcLGB7dIv8P/T/Z5Cy6newGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8963

All supported drivers currently implicitly use two's complement mode.
Make this clear by declaring two's complement in the default
output mode. Calibration mode uses offset binary, so change the output
mode only when running the calibration or other test mode.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 59c3fa3bcc9b0b8b36b78c3b54fd7977cae23496..9cfe66425d4e91e215cccc40e24a92c5e99e9b87 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -5,6 +5,7 @@
  * Copyright 2012-2020 Analog Devices Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
@@ -72,6 +73,7 @@
 #define AN877_ADC_OUTPUT_MODE_OFFSET_BINARY	0x0
 #define AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT	0x1
 #define AN877_ADC_OUTPUT_MODE_GRAY_CODE		0x2
+#define AN877_ADC_OUTPUT_MODE_MASK		GENMASK(1, 0)
 
 /* AN877_ADC_REG_OUTPUT_PHASE */
 #define AN877_ADC_OUTPUT_EVEN_ODD_MODE_EN	0x20
@@ -85,7 +87,7 @@
  */
 
 #define CHIPID_AD9211			0x06
-#define AD9211_DEF_OUTPUT_MODE		0x00
+#define AD9211_DEF_OUTPUT_MODE		0x01
 #define AD9211_REG_VREF_MASK		GENMASK(4, 0)
 
 /*
@@ -93,7 +95,7 @@
  */
 
 #define CHIPID_AD9265			0x64
-#define AD9265_DEF_OUTPUT_MODE		0x40
+#define AD9265_DEF_OUTPUT_MODE		0x41
 #define AD9265_REG_VREF_MASK		0xC0
 
 /*
@@ -101,7 +103,7 @@
  */
 
 #define CHIPID_AD9434			0x6A
-#define AD9434_DEF_OUTPUT_MODE		0x00
+#define AD9434_DEF_OUTPUT_MODE		0x01
 #define AD9434_REG_VREF_MASK		0xC0
 
 /*
@@ -109,7 +111,7 @@
  */
 
 #define CHIPID_AD9467			0x50
-#define AD9467_DEF_OUTPUT_MODE		0x08
+#define AD9467_DEF_OUTPUT_MODE		0x09
 #define AD9467_REG_VREF_MASK		0x0F
 
 /*
@@ -117,6 +119,7 @@
  */
 
 #define CHIPID_AD9643			0x82
+#define AD9643_DEF_OUTPUT_MODE		0x01
 #define AD9643_REG_VREF_MASK		0x1F
 
 /*
@@ -124,6 +127,7 @@
  */
 
 #define CHIPID_AD9652                   0xC1
+#define AD9652_DEF_OUTPUT_MODE		0x01
 #define AD9652_REG_VREF_MASK            0xC0
 
 /*
@@ -131,6 +135,7 @@
  */
 
 #define CHIPID_AD9649			0x6F
+#define AD9649_DEF_OUTPUT_MODE		0x01
 #define AD9649_TEST_POINTS		8
 
 #define AD9647_MAX_TEST_POINTS		32
@@ -461,6 +466,7 @@ static const struct ad9467_chip_info ad9643_chip_tbl = {
 	.test_mask = BIT(AN877_ADC_TESTMODE_RAMP) |
 		GENMASK(AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY, AN877_ADC_TESTMODE_OFF),
 	.test_mask_len = AN877_ADC_TESTMODE_RAMP + 1,
+	.default_output_mode = AD9643_DEF_OUTPUT_MODE,
 	.vref_mask = AD9643_REG_VREF_MASK,
 	.has_dco = true,
 	.has_dco_invert = true,
@@ -479,6 +485,7 @@ static const struct ad9467_chip_info ad9649_chip_tbl = {
 	.test_mask = GENMASK(AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY,
 			     AN877_ADC_TESTMODE_OFF),
 	.test_mask_len = AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY + 1,
+	.default_output_mode = AD9649_DEF_OUTPUT_MODE,
 	.has_dco = true,
 	.has_dco_invert = true,
 	.dco_en = AN877_ADC_DCO_DELAY_ENABLE,
@@ -496,6 +503,7 @@ static const struct ad9467_chip_info ad9652_chip_tbl = {
 	.test_mask = GENMASK(AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE,
 			     AN877_ADC_TESTMODE_OFF),
 	.test_mask_len = AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE + 1,
+	.default_output_mode = AD9652_DEF_OUTPUT_MODE,
 	.vref_mask = AD9652_REG_VREF_MASK,
 	.has_dco = true,
 };
@@ -671,10 +679,14 @@ static int ad9467_backend_testmode_off(struct ad9467_state *st,
 
 static int ad9647_calibrate_prepare(struct ad9467_state *st)
 {
+	unsigned int cmode;
 	unsigned int c;
 	int ret;
 
-	ret = ad9467_outputmode_set(st, st->info->default_output_mode);
+	cmode = st->info->default_output_mode;
+	FIELD_MODIFY(AN877_ADC_OUTPUT_MODE_MASK, &cmode,
+		     AN877_ADC_OUTPUT_MODE_OFFSET_BINARY);
+	ret = ad9467_outputmode_set(st, cmode);
 	if (ret)
 		return ret;
 
@@ -778,7 +790,7 @@ static int ad9647_calibrate_stop(struct ad9467_state *st)
 			return ret;
 	}
 
-	mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+	mode = st->info->default_output_mode;
 	return ad9467_outputmode_set(st, mode);
 }
 
@@ -1174,12 +1186,17 @@ static ssize_t ad9467_chan_test_mode_write(struct file *file,
 		if (ret)
 			return ret;
 
-		out_mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+		out_mode = st->info->default_output_mode;
 		ret = ad9467_outputmode_set(st, out_mode);
 		if (ret)
 			return ret;
 	} else {
-		ret = ad9467_outputmode_set(st, st->info->default_output_mode);
+		unsigned int cmode;
+
+		cmode = st->info->default_output_mode;
+		FIELD_MODIFY(AN877_ADC_OUTPUT_MODE_MASK, &cmode,
+			     AN877_ADC_OUTPUT_MODE_OFFSET_BINARY);
+		ret = ad9467_outputmode_set(st, cmode);
 		if (ret)
 			return ret;
 

-- 
2.47.3


