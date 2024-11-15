Return-Path: <linux-iio+bounces-12332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C08B09CF620
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 21:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE026B356AD
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 20:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDE51F4730;
	Fri, 15 Nov 2024 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gK1eFXU+"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0111EBFED;
	Fri, 15 Nov 2024 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702264; cv=fail; b=S2megN3T02UFR8V4nPYuVClsTcGTmvZLBkUF3Q8pRSBztNRpDLgLUP6xf387sKSJ3qPlh7nh1Z0Zf5CUwwUEDKK9QdBwOMt1wSawPw4X5y2f7L82kmM2Ve5ZUC57vs82hRdM2WuNfuC9TSggiE7RfwZwU4AmJ767DmvK7d69vs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702264; c=relaxed/simple;
	bh=ovQbKQDu3F4ca9647wIP0dmC0whevpKxesrCD86l3mk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D6cUfq7N8oZxuaZyM5vz85Q8GOVWgz1euB6JqP0ZI7NmuAoCszcZ01KHKtUs0jZmI+kvuVRNCmUtvQ8yfmOR02aPLSVmJRHfzsc6HTLsjrNmpVOamF/mPt27mxfh5A8JNzUjgRDI8C7heOO+QjWQ2d0Xebr2zz/o5aQuznmMUys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gK1eFXU+; arc=fail smtp.client-ip=40.107.104.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTX9pBCl/DF95g4ZGxRGLlf1I9pCHaYVltPRs5teMRy40ZGk9ydw2C9haWzv2JOdRMgZXt+yq1H9MY/qtdQCea3df3mcXTGDWZiqiw8GTw9T3nmu6sH+WjU+BRpYRGjLoy6nJURYXj4XSos5b0ZIAo991BbHfC7FV15Z2odecoMipp/Kh6XFN/RBkgMUn/bd41xjieblE4H1npgwYI8i7i6TbtSmchfXh1KF/tn8d2eykWmpkJR96O23+FwuFKrookj5QndgQvVE81rYwBUqjhKRHkaKifb4mOaO1HAZhunU+eh4BOsBgodk4LGrCON/1R2LFGnR+4eCvrZ0X9gmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSj8cZbQIyv59p59G1UsipdYINYDVBGITa7eo8RrfiU=;
 b=TBQbF2/smONAs/Lyr3vfVu0lxln1dIG81xFz3BuezQnlTgF7YcJzhkWAl3ZlG3EC2FgT0+P6cvzZhO5L+mONo4vwVJpk/rzh8MDl79xGPZkPsorSaUxSajje6p1npzCBwW1DIlKGEvuK7mgZHbrMo9dj7s2nQ5yCNMhcAv4Y34kdw1uXzGZDvQKqZ8NZmHqOgPVS8/H2ILTGF4O3PyDWaQaSckR+5PJi1pTjwAE/n6pMF80RqlN1WUi8n++j7kKIzGyBKgzNjFYm/zlomIg4WN4KE8EyyB5fHot/vvjEugmt0maf9jucr3+JuagGhIjjneOMri0P8VnOG+rk6i9VSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSj8cZbQIyv59p59G1UsipdYINYDVBGITa7eo8RrfiU=;
 b=gK1eFXU+I2z5tOOjL2motrFqXK1hY7q9Nv7W3jdB+Yz+/yCuh3opg/v2gtXsb/wBuCHiFP2NmO8kW9PiT36FaENLnPh06JZOIFfFirCKMsdqsWDh+9YgUpfBNdnL7tE1lKRh1u3AhiT8LxBMYREOctlED17yF5wFdRWb0uqmQNsPu6tRwJDHA9vqynAPT9oNFekzfx7O5izge6Dj2Sy3L3FYHiQZTkWP6n/NqV0WIZyGeybMFP2NeyXM6L3O8SLIkyd2wUTlmTAM/poUmKYDyNEc4yj24Jmg1ylna8VHK9Lfq6vT4N/4bjspOdA7Ut0CfLua3boLxoNJSRHLubjfJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8231.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 20:24:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 20:24:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 15 Nov 2024 15:23:58 -0500
Subject: [PATCH v2 2/4] dt-bindings: iio: accel: fxls8962af: add compatible
 string 'nxp,fxls8974cf'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-fxls-v2-2-95f3df9228ed@nxp.com>
References: <20241115-fxls-v2-0-95f3df9228ed@nxp.com>
In-Reply-To: <20241115-fxls-v2-0-95f3df9228ed@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Han Xu <han.xu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731702250; l=1207;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=f08XsdRgxw2WjTeoyVGAv7yjkwFTODaXkdmnGf3J2RE=;
 b=IBMQLmPd+Oi5ONG5MF/eLt+fm8RmwJ5FoXYLTqbhka+lhP7TpfZet8toHScOYVJ6m3BH7IpAq
 zXxP6AwnLcHAQl2X6ryylpSIHXExuKJYYX5nXDrhws86Ztlt7pASjnQ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:a03:60::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f392a82-1337-4547-b8b6-08dd05b37c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVpETGJUbld2UjAvZWlVank0d3l6NXpsdVQrcTU3anNvVGJJSFZhUG9CZVd3?=
 =?utf-8?B?TW5tRWJlRW5oaEd4SUJEWkhmYWtyWEN4MzYwVElsdGxKb013MmxERkc4c3kw?=
 =?utf-8?B?ZkR5Vys3VW9xS2U2bGdkdnRFaE9nZXFrKzRIVWhERWx3QjJ2cEVQd0JRS3Vv?=
 =?utf-8?B?ekc4YVIyamtMWHB5NCszZUY5dm1QeEZzQ0RGdzdHbGRZaFVCRVFKL0pYRFZj?=
 =?utf-8?B?NERnYXh5cWNXS2M5aTJjUkdiSWRBRjNYSGdYMmlIN3BEd204Y0VIbDJ3ZDRs?=
 =?utf-8?B?VjZ2cWEyQmxHYXF3NXkxWm0vbTBRck5GTS85aEg5aW92UmRJY1ByYnJ5WnRJ?=
 =?utf-8?B?Vjl3aXRsam43REhaTkZQeFdCZFo2NHhBNEF2VXd0UklJNStINkZBb016eXlw?=
 =?utf-8?B?REJrajhOTVpXbk8zTGZXRHUrT1hNWW50Z1ZkUFlxWTM5SEZQblRrNmM3emJE?=
 =?utf-8?B?UGw2cjBicFp0aWcvZExlN21rY1p1RkZDaUVmdmJJVXppN0d3eWNEdEJraWw2?=
 =?utf-8?B?Y0d6OHloMi8vM0dhWURORHNlR2h3aDd2d2lncFlYeC9INi85K2luS0FWZEkx?=
 =?utf-8?B?ZjNwMGhWQlNrMDNlc213aG13MW9NNTYyOVRGYkZTNEFURURLY3V1dEluOFAw?=
 =?utf-8?B?Q0NQdzVLV0c5OFVCMjFJeXlFc2VmcktVdzFvWFpsdDhIamZZUWsycm9scnpB?=
 =?utf-8?B?Um00eGs4RHZ3WkJYUGkwWE96dEIzTGhLYUxZYjZYbnZ6SDhQQjl6NmRXNXU4?=
 =?utf-8?B?bW1pNUNGdDRYTGl6dmFFQ1gxQjdhMXozaG40UDNiekJTOURVRlY0Vmx5NHZ5?=
 =?utf-8?B?V0NwSmZyblF4SDlLWEZGekN1TWxvc2wyVWxiaDhkbUhkSmtEU2ZSSU95V0hr?=
 =?utf-8?B?bjFDb3hpdk10RjB3RG95ai9ITzd2RWxpbURzbVpTc0JqbThoQVR6OXFvdzhk?=
 =?utf-8?B?TTU2UE03eU1EOXY2S1J6Z0l1UnkwZEQvMjFIb2kycUZVbE5VVnA4QWNoNTZq?=
 =?utf-8?B?Ym5Nd1pBWmo4U1RWUFZjbFJSTDVCQzlwRGtGRDNEdFI1bG1sOXZlUnpBVFcy?=
 =?utf-8?B?MCtwK2hWeFNpbWszUFNzQlo4WjRmTFJIQ2VYQTdWc0c4dFAzTTlBRUFFSzVL?=
 =?utf-8?B?SE1DQXQydVpFVkNVK1BGVU5jOThDZU84NWhwTkZMUGtyZkpad2dmcnJGTkhR?=
 =?utf-8?B?Z0x5bEhqOWExMVNDWnhvUFVHMHM3NmZqU1V3dm1BTWtYaVFpc0p0bnpQbW96?=
 =?utf-8?B?MjcrY3BzaEtRM3U5aXRsTnlIRzVaMUdRbFNZRmZlS2VmeW9zSjhaMGNnZjhr?=
 =?utf-8?B?VlV1UE9XU0xPdFVxQ0xTL09zYmozQ3ZnRVNsOUIxdWF0cmhQYS9MZjdZMkJF?=
 =?utf-8?B?Mm0xS3ZFZU5wNTlkVEJSS0JhTGhjZGpmOWZCNkJ2ZzhLdXJPVXpVakpSQndw?=
 =?utf-8?B?U2x2SU04K0VVc0NQNk1xZC9oOE9FeHpPZnJtMUpZQmpHUUI0UGZWeW02bER6?=
 =?utf-8?B?TGltdlg3Lzl6ZUtpYUlwRGRXNVdWT014enRRNmJFRUYrVVZGWWdBME0rbXFv?=
 =?utf-8?B?dDlkNGF6QkhXdWd1cTZ2L2loUlpGdWpWRTZuT3hFbFZ5WjVBYzkyZ1MvMnpy?=
 =?utf-8?B?YXdXTlVGdCtTd1lUYkJreFVhc0VHVG9tZzN1T01LeGp4clF1ajVaS2xpbFpH?=
 =?utf-8?B?WEVvdFFJRnVYYUV5VjBjTGlNc0xDR2F0NGtiV29FV1ZsMURBN0UzK2RpQitL?=
 =?utf-8?B?YUQ3V0RsU3dwamVDYU1DeUJSVDNUakpXdllFSjFlWEQyTHlWQUZvdDZWd2cy?=
 =?utf-8?B?bVlVUnk1ekpiVGNXSlpGcVJxTXFvZkZpdVZnSHYyT2JodWhmSXlEcThLUVMw?=
 =?utf-8?Q?HUOfShIFMSzTP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUFFcFVkUHU1OThDTlQrbVdRZ21LRGFTMWd0cTFXcDJ0MnF4cnNVMkZBa0tT?=
 =?utf-8?B?dUpPSkY1dGFLVHVpY1dnR3BvcGtpZElHK05UT2lYUzArQldVb1o1UWZHaVE3?=
 =?utf-8?B?M0RYSHAvQXVTc2tSck1sdHk1ZElCckJBRHJIa3dtUVFTckZ3dnR1RGduWldJ?=
 =?utf-8?B?NDFidmsvUUFuRVNNM2ZZUlQxZjYyZkxURXlOZFg5Um5lMWwvbnZONmpKMDJX?=
 =?utf-8?B?YmNEbHFXZHlYMUcyV0pDU25wdFNpY2VWaTQvcFJwTDhkMFVWS2kybmhFNFkx?=
 =?utf-8?B?ZnBUdnRIaEFBUmdKVDJRQ0dFdXZPQlZLNVpoaUJSK2ZlWTVzQVNhQ0RSTndB?=
 =?utf-8?B?NHduM1R4M1dvUER5SGIzK2l3WTZpNmlzZE44bkpnYVNtaXBDOUtyUFVNSGJ3?=
 =?utf-8?B?MEdsWEVRenExRSsrK0JEWGdhV2s4c3RxdnIwRG9Va0tPNUpnMmJIOTBUSEw2?=
 =?utf-8?B?cUFhVnpxc1ZBbmx2WXVJOWFidFBKc1JOU0pKejN1V2xtbUJScktVNTExcmZT?=
 =?utf-8?B?QTRSVDNyTG4rUkk2N1l1Y2w5bjVYWldTelU4clB4aENHek5uYng1Wm5URGZJ?=
 =?utf-8?B?N2svSXhMMjc1Wld5OGxxUjZzMlloa0VXdmlNV0MwUHE4dlkzWEgvMDZ3ck1J?=
 =?utf-8?B?TEVFVDRGSkxKODd5ci9LcFFpQksrRzYvaUR5WHNsNGRPZEpnY2U1TWFDV255?=
 =?utf-8?B?bElpeURiekN1aU9MR3lUUitxcE51MmRmbSt5YXpyWVBXekNvUHIzWGxYZnhD?=
 =?utf-8?B?Uk5SNGYrM2l4QmZaRzNaMldYNXUvZ3dGWXpmek5LRmVVQmkrM2JJZVZ6OWVU?=
 =?utf-8?B?QzFzS3NYWTZ1NHUxM0xSOHYrRisyNkgvWlZ6YWxVK3hFbEhQUElpYTFpWHRv?=
 =?utf-8?B?blhoK3hOOHd5M2YrTTZZU1JVeDNhM3ZISUNKUjFNa09DeXRjbEtDRHY3cG9S?=
 =?utf-8?B?ZjFLTlZDMGgvNTJ2SmpPK3BQalh6anpYSnlrNFIxd1JFUy9lNlBsb01RdDJ3?=
 =?utf-8?B?RUlZa0ZOT00vQXB5dlFYcnlTRzRJcFRwWXRGRElDRWN4WFFNYml0UzI3K1hT?=
 =?utf-8?B?cHM1eEY0WmhCUTRjSm83c0FueTIvWHNYLzVXUjRoOTNNemMwQ0ZaVjEwNzRJ?=
 =?utf-8?B?LzJ6emtkQU9vZ3B3clVSc3JCa3Z2a2ZZY2UyblZrdVgwZEZyTVEyYk9QWXZs?=
 =?utf-8?B?R21OWXZvUDJBdEd6R0hab3d2Zlc0S0V6enZwb1lCSVcxaGdCa0QvWGsxTUNC?=
 =?utf-8?B?YmpERlJYZ1FaT21pSGpkd1NIWThra0kxQ2U3SnFHRVljaGNBaGpPaW1QMU5J?=
 =?utf-8?B?dEpRdmgvTTlIMDNRVnRnNGVDU0x1WjZDYmtIRkRxT3JiSkJUbEhNS2daREMv?=
 =?utf-8?B?dmU5L2pRbVZRbER4NjloR0x5ZFM3Vm1GNmlrMGpXOXBSWHMzdTM0S3lFMzRU?=
 =?utf-8?B?cjk1VFBDdGlvMURSK21QdGdTQWV0S1BmZ0FtV21oWkdDWS9nZXBJajFDcTRz?=
 =?utf-8?B?ZS9RQVAvZS9MT3JRQ3krTWNGSUdaUTZSRk52dVUvaWl4ZVlZWXFCdXRhSk5I?=
 =?utf-8?B?VTl5TnAxWUdEc3J0Zmh4WGN6ZjBJcVRCWXNRSkNadDNDallBUUtaaWQzL3ZW?=
 =?utf-8?B?VkNDdDdnRFNvZGhSajlpWlEvN0FvbjJ2OUNlekM3bmk0Z2p1OTI4R0VxeDdz?=
 =?utf-8?B?MmNDRkxLdlQ1ZitjWS9JUndWa2dCaDdRUC9PNU9jNUZWU3MzOEgydGorRmVY?=
 =?utf-8?B?MEpxS1NHMXhLZlRJUEptK0cvTEVGNDk5dkR4S29MREsxOXFlL3RwZDIya3ZB?=
 =?utf-8?B?UjdRS2o3RkVBR1U1cmhVTEhrcHhJZG42ZWxVZXZXZHlSZG9DTFJIRnhyY0VE?=
 =?utf-8?B?Z3ZzU3MwK3hhVUZxMmI5OERYdkg5Y29oQmVDUjV3a0thZEZrMGFldml1dDRv?=
 =?utf-8?B?VkdKOUd4djBkSXl5c3J2MWVLZEh2MFpMa01JbW10b2hhOWJhTjg0dFVkZTh4?=
 =?utf-8?B?R0Fmd0pxKzAvWHFIaE1IcGVyMXRKSnhPd3JrckpwT3cwTmxjZHIrMkxtS1R3?=
 =?utf-8?B?ZDNtcHA0MTlUNjhBcGcydDlEenpvRWVJWkdFN2J3TlV4bmdiVnlRSFc5WGdZ?=
 =?utf-8?Q?j/wGo8QzaLIOhmMPfjtqmiZpY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f392a82-1337-4547-b8b6-08dd05b37c91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 20:24:20.4477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1z73zzk59oG/Uo9P8Rw97YA2l8mK0WzpiT9456O0zirsR3po1oijpI2/dSO+2spdals+3U9WRrnTg7GCXM/AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8231

From: Han Xu <han.xu@nxp.com>

Add 'nxp,fxls8974cf' compatible for the FXLS8974CF sensor, falling back to
'nxp,fxls8962af' as the only difference is the ID.

Signed-off-by: Han Xu <han.xu@nxp.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
index a5c882bd7d06e..2d99e3811da07 100644
--- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -15,6 +15,7 @@ description: |
     https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
     https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
     https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
+    https://www.nxp.com/docs/en/data-sheet/FXLS8974CF.pdf
 
 properties:
   compatible:
@@ -25,6 +26,7 @@ properties:
       - items:
           - enum:
               - nxp,fxls8967af
+              - nxp,fxls8974cf
           - const: nxp,fxls8962af
 
   reg:

-- 
2.34.1


