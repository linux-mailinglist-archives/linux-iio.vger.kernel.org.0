Return-Path: <linux-iio+bounces-15154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72844A2D464
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 08:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADC83AB3D6
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 07:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D5C1ACED2;
	Sat,  8 Feb 2025 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="r+tSjbGj"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713031AF0A4;
	Sat,  8 Feb 2025 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738998443; cv=fail; b=FACv7KMK0kk7gB4pXO2xIx0TjxfChWuf8qEefReS03tMWIbEXRlzU2bIhA8nwUDhpKaFYJG9DXfvv3pB/txGbw+XY98L2yve+tgG4HIGVo+wGku8B53vAIgseg5Y1+MYlOa/jGIas1cXfbaG9Mfd5maOdVqS7nM8Pr+A1Cgtdqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738998443; c=relaxed/simple;
	bh=zBfrBh2k/LXq6tVa1Uto1RaOKF9X2MDirxpqRja5mwg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NjLDM4dn4tJ7F2RGq/UkwKSVh71SxM+oo6RV9+3wDTuoWxbGbJagsktY62RB2ErtN16kO7TMVpW/qk8MJXlBeq/DhPJAOIaJ0frew/g3dPVE3GigacUzFE2buMaUkheh/arqN3h5QBokZ/bWecLVoxFZDfY3F6o4APfS5WF4L8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=r+tSjbGj; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vobAHILmO31Iy49b9Y1MmAUF8NPKn6ltepfL8UHfTqxP76sQGALueDVxMGtpiamIFcn7gYvQ4A2P/4YnEcfj4mWDVjr/URPQF9tBFpCA3LBtlkSzR+9u8AIuhPmC7JTGGXK8MMfw0ev14GgnOSGaLUSYL+lyvRS5aoMu7mM4Qt4i+8zGRQM1s2mQzDWPP4Cc34EmaDXM6XCXFjAe7j9gHzWQc0+5pt5qFbZ68amCDrlx3etKjJDIigl3ZFbsL1mNd8XQfrhSpBCB7Z5e7BD7oor1B2xQrEgJnh5/spFxrDhRXGCvGKDbUFAoDbxkX7FjDAk0/E41RDQ9vB+ICKnoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtGSzaCYtN641CGhGQl07UnmBcTXkXx7GJsNCxPTh6g=;
 b=wWmFRZ110AgbtuNKNUGUP9V2N2PP2RUME1/8Z9bLYYgCRYIZIXPXxTaBeS/ViWXBzZ1F/UJrREhtjCga7lgN/pNqJpsNnr17lhJdaiVvaK1X9TxEEndPiMSEi1XUoBrqKY0iUIJ1A9BBmhmi6xJjka1k3g5qlEGonKqgm+CRv3ZZAgHCAV/4BSAsWY/zOHJCcsTJbXDqZEBjfOPM8gkGlEDPRE+XvCetgLzEAmqZQkt5m+RpZU3uBdmgaT7g5utbMXsrAirzqsP5BYNEAF8app2obthOhyncwh35MPMdx/DA+Xyxq9jUJFr60IzKfnAJaCI4wONfeQ9+urVTPtXPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtGSzaCYtN641CGhGQl07UnmBcTXkXx7GJsNCxPTh6g=;
 b=r+tSjbGjgnfSgA4yKnboKdxkDRvbQii8p6fzmzlm8hDOLt4JwbCt27LRxQA5ethcafxiw1itIzldm1dxqVTcHK9Cog+nHzB8mPzNKprma3n1Tsdw2Ct0CYBX4jBrc9AIhxwLVMifRHrbPVIrbuBkUL0Phqd8jEG/3lgaT0XkCTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14) by DB9PR02MB9995.eurprd02.prod.outlook.com
 (2603:10a6:10:45d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 07:07:17 +0000
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::e014:24e9:48ef:92e9]) by VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::e014:24e9:48ef:92e9%3]) with mapi id 15.20.8422.010; Sat, 8 Feb 2025
 07:07:16 +0000
Message-ID: <21dd4902-7d24-6d1a-1144-2dfd7cabe9e2@axis.com>
Date: Sat, 8 Feb 2025 15:07:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/3] dt-bindings: iio: chemical: sensirion,senxx: Add yaml
 description
To: Conor Dooley <conor@kernel.org>, Hermes Zhang <Hermes.Zhang@axis.com>
Cc: jic23@kernel.org, robh@kernel.org, lars@metafoo.de, krzk+dt@kernel.org,
 Conor Dooley <conor+dt@kernel.org>, kernel@axis.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
 <20250206061521.2546108-3-Hermes.Zhang@axis.com>
 <20250206-italics-reproduce-35d554c38751@spud>
From: Hermes Zhang <chenhuiz@axis.com>
In-Reply-To: <20250206-italics-reproduce-35d554c38751@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 VI0PR02MB10536.eurprd02.prod.outlook.com (2603:10a6:800:1b9::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR02MB10536:EE_|DB9PR02MB9995:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b97b2b-298f-466d-d427-08dd480f3832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTNEbEFLWnQ5YlI2bFpIaEd0cTRORmw3ZjE2UHVyZkhqOEdBbnFjUnJ5SmhU?=
 =?utf-8?B?eGV5QUpzdFJSRFhzdUxQRjNsV2NCVHNWdlA5aTV6TUtyTHZWWUd3OUlDZTRT?=
 =?utf-8?B?K3grSWdvWmdaZkFvcXNsZ0VqUFN1dUlnYU5KM1BDVVhNVG5GTHhvM2FxVk82?=
 =?utf-8?B?bWRPdGo4aThxVXdQSVRIWmxmWXBKQm02cXU2VUNoeHF0QWxLeTJZVVUzVHAy?=
 =?utf-8?B?bFNRN1JkR3VKWFdDZjBLNjIyVlJrbnBGTXVzcExrZHZURWwrOXdhemRUNHN3?=
 =?utf-8?B?a0w5OWhYN0Z1SFlHd042SElqeHpySXlha1FFZitsdVVTcWZRTnYweWY3OHEv?=
 =?utf-8?B?NnpPZ0xuaXBCS2dKL0V3bktoY3RuZzdhdnYzUVp5YmRHTTBKYmdHNHU1eXky?=
 =?utf-8?B?cXZEdmlxUkRma3ZmdTcvVlhlQmtKMU42ZWpoZ1JtY2tDeithdlZOTzJaU21n?=
 =?utf-8?B?RjgyemVQc2tjVGRNZ0FxN0Y3bS9PVmRhZTg0UHlOL0lRaUdPTWtkYzF6QkI5?=
 =?utf-8?B?TXBBZlpreElPL2lBQXNELzNEdnFjZ1o3Z2NxclJad3hkNzRBUUVwbWMzRXlB?=
 =?utf-8?B?dVkxdGx3cjljc25VN0IyUy9peVF5dFg5YTRQbGdQL0NrYXorK1U1U2NJL0t4?=
 =?utf-8?B?STNWWkZGZ2ZCUk0zRmdpSHBzalp3MTNVQTk0ZVlkdUJvWEpncURZdFRoOHFJ?=
 =?utf-8?B?dnZIUnM4UkU4ckVzOU9BOG1MekZudFo4NlAxTDFmbm1wZzhCbkgrbU5UVG42?=
 =?utf-8?B?bjJETXlRUmRyZmhUK2dZQUdqOHpVVTNFeWJRU3BTaWJJSTNwb0lIcTBYSGgv?=
 =?utf-8?B?c0FCd21seHV6cHZrMHNtclN6d2JlTUtZNG5BemJSRGFOeVBtUWh2WHU4RGJo?=
 =?utf-8?B?eVRHb1pTaGRSR1BjZUZPVUplMXYwcFpsbXozREVMa3RpYi9CcnR3Z0VEMFph?=
 =?utf-8?B?cFFkRTQ4QUN2V2RTcVliRjU3Q1NyckVUc3BrVk9vRmhqbHJpb3RZZXh2SUQr?=
 =?utf-8?B?QThxMXVZZExzUmRCRjJnZ3VTUXlkYlJkK3l1Vi9OeGlzdThBWjRMdXA0U0VF?=
 =?utf-8?B?NmVkUVBnUDVvNVZxMnVaOENkbG9uZHlUZ0Fzdi9BTERjejlDaVpGUDVVYkVn?=
 =?utf-8?B?Q3JIdHB6UUwwZ0ROaUVFWVZINUhFbWxlZlpPclBnbmgzVEJXNmRnRlV1Q0tJ?=
 =?utf-8?B?L3NMR0dOR1Bvb3VSdm05QVVvV2dWTUxVS0cxcENwUlpGS0U3cmJQM3RmMzJp?=
 =?utf-8?B?YnlMY0tXWjE1czVRd1lPampuTFRPdTFFejRZWG45bHVDWTdpd3dWRjR6SmRm?=
 =?utf-8?B?VERsSW1TR2ZsdDVKL1ozMGlwU0dHWDhPVkVUQ3I4cWdBYy9kRUlrbDloT01t?=
 =?utf-8?B?cTFqK1p6SGxwSVBNTHlYbVYyUTZib2JLZHZ2VGdlNFZiZmhLMEF2b0MzRHZO?=
 =?utf-8?B?SXlOalYvVFVoOGZERUV6TDcwTUNobm5KS3pMcVlidnJKVVpDS2MwZ2RIajlv?=
 =?utf-8?B?cERSaDVKblJ3ck5kakxNbk9TbGI2MS9iVGd3UzBGSWNkU2MxU0Z5bDNWWDBQ?=
 =?utf-8?B?eVJOanI5U1krUXN0RWpRVDh0QVM3em8zcEF3aW9USUl1b2R4UTRwdHVFMFFF?=
 =?utf-8?B?aUgvZHFpdVYrM1k4OUpyNmxYUkNxNGVtc3VZc29pbGFEbzF3bFo0cW5rVXlu?=
 =?utf-8?B?REx3Y1B4MnFJQS9rb2grazFhV1RKTGtXcVJjQ0pjSDYxQzFydTFGOWNsYUxh?=
 =?utf-8?B?T0xhUW5QN1FZNnQxejM1UEF5em4yM3ZLMWlGUjRodXpJUTdmQXh4SnJKS1Zr?=
 =?utf-8?B?RGlLajJOSVBLRUN0MXNBUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10536.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXBSWnRvaVN5emNCODQxR3g4NG9NL1IvbmlZNllsT0x1UnY4RE1sZklLOWZt?=
 =?utf-8?B?dElhQ2VCZE4ySEMwR01QSDdNaFR5RldMRzRkbFpyU2wyZ0hmblllWUFVdFQr?=
 =?utf-8?B?OHhMcXF6a1laZUwzU0UrVWp4dkJhZVYvUWdmMm1CNExPOWNGeHBVajNlNVpj?=
 =?utf-8?B?MGI4azFYWmFLS1BVSTVza1NTR1NiZWUxVlJ4NndBV3pVN3N4enp5UjllV1VI?=
 =?utf-8?B?K3ZOOEdGbTVBbVNCYllKOWZUT2FaU1ZKNG9YTVRxc3ltVXVwaXRsMjI4dm9u?=
 =?utf-8?B?VUtVWHBzem9kSytaWmtGd2dneWtDYm91dlNuUTZDd0ZYb1dNSjRYb1JTZkRm?=
 =?utf-8?B?c1p2bjAwRHkzZGh2Z20wS3lETSt4R0NsbWdrY1dqSUhIY0hqandRWVR4eG1G?=
 =?utf-8?B?QldHWGNoTHlRNVp6SGM2N2dlbTliazRuUzIvdTdUYUh1Nk9ZcnZGVWE2Ti9u?=
 =?utf-8?B?MWFYWW1uTUZ1am90enBEbTlNV0ZYaHhIWUdKQk8wQzJHVkRiT2lQOWt3b3VQ?=
 =?utf-8?B?S0hGQ2RMcEpSQjAyTEpYclo3VHZFcnArOFpTTkpXcm94MVZwdGhuZ2h5R3Zj?=
 =?utf-8?B?c1VBVDlwaytSVXd2QUU1VEtJUGFaTHJ3dDR5TTc1bmo1VGswMVVSdmhZbDRZ?=
 =?utf-8?B?QzZDcFR1V0FXZTFEd0UxVWVqU3hrd2tDRnZ5Nit5NXhlVEowK3JqNEVsTlZ6?=
 =?utf-8?B?QnhETkRGZktvcEpFWVFzWFhwdUFhcnVMQStyU24zN0NpNSt6STVUNWZicFBa?=
 =?utf-8?B?V1JpV3Yvd0JpdEtuRzEvdm1MZkVBWW1LWmgveFBSRkJIY09jdEtnQVBPZmZo?=
 =?utf-8?B?blJWMjM2VEZQc1hmQ0ErT0xKQ2F2Vlo3N01qVXlrU3Jabm5lK21RRXNNSmZU?=
 =?utf-8?B?bEFqRkpJbUpHcGJKSExWM2JSckFYSDRCeVdISmlCaTkyODBqSEV2bTlsZVhY?=
 =?utf-8?B?WmRvb3NqckUxeGRxV1JIS0ltWHhzM0h5VEFIYWpOR2pPemw0VFVoTnE4aTdp?=
 =?utf-8?B?aVJDUjA2NCtRaXlXZ1RiVkpub2hoZERHdUQ1Rm95RUVQTWdoNE96K2ZLL0Nr?=
 =?utf-8?B?R3BLOFRJd1JnNU00ODJoZzlKb0F0OTRadGhWL2RoMWMrUGlKbmhDS09iRVln?=
 =?utf-8?B?Qlk1eWE3Z1JEdnQvcjVvNVFkZDgrQ29OY1AzWGRJZkJSNS9zSTdhOUFmSndQ?=
 =?utf-8?B?Z29zMEI2VGVaNkZ2QmZ2dEhOenBUemEyT0tnbmFFa0NUMmw0NVRJYkZXaW1j?=
 =?utf-8?B?aHZjNGNoQ3BkQlptM0U1S2ZIdG5TdkNFMldSZnlUYXhCMDZDU0lTY1NjVnJ2?=
 =?utf-8?B?TDVjSWhhQUhzVXI4cjZYM3JReXQ5NW1WdC8ySENuOG5LaXpSWWRNOERTTDdE?=
 =?utf-8?B?Zmp2VUQrWXdkZ3hHSVBIL016ZWJIQlJORGNobGkrTml0bzZwTURrN254cGtz?=
 =?utf-8?B?SkVxUVRvdVhvb0UxRWlwNGFtSnRyaW5uLzh3SzViTDJ3eTdGN0tlOWRYaW01?=
 =?utf-8?B?a3hZSWZpMS9FcFo4L1d0c1dRZVk0MFFZSDR1V2lMOEpvSXAydkdUTmtIV0dW?=
 =?utf-8?B?R3ZtTGRHa0tiSUZoZDkxbnlVTFNXcGpObEliUlB6ZnNYSTIvUHZNTlFPTkJJ?=
 =?utf-8?B?MWNjdEFGaCtwT2xqTVphNTVkL1h3T0F1cU1HU1hxMW5IN2RkZXplRDVEVXlK?=
 =?utf-8?B?djVkMFI5clJVSzl4dEtBQ2NjUGxzZG5WV1d1dVR5eGlqUVBQSjE2QmV5VUxv?=
 =?utf-8?B?alhZUmJOYnNtSzV1UHliek4velgrQlF3MTBQMnhwZjN2WUlYbFR5NjdmLzF2?=
 =?utf-8?B?UldxT29wSHVQK2EvcElGZ0tOUDhyNnA1aHNGWVJwcnpoZmRvU0pFUk9mbDd0?=
 =?utf-8?B?TFJHbkZob2lkYWdONDMxNGcwQTZhZk5FNFphWThpWHJFeGF3d2FONnliUWRj?=
 =?utf-8?B?SlNoQnBnTHZOOEU2cGI2ZTJrWEE2WkV0Mk9PY0xxNHh6UEYxOC83eHNvOUhm?=
 =?utf-8?B?U2V3VXdBOVFhZW1IQ09yRGJCNWtSZTBVNzhZZ1pCZk5tWnVLb0RZc0xaVXRl?=
 =?utf-8?B?bFIvRngrZXBOaFo1YXN4MlAvc1hpRFpKRnNONDBDYTR3UjNWWnBOWmNiZWNC?=
 =?utf-8?Q?eKtDcZgu2LzWVGCBSEcy4QJuy?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b97b2b-298f-466d-d427-08dd480f3832
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10536.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 07:07:16.5865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3MJFRTUpwrxMUGfsC1dC3lgD6VnSvrFwLS0X04hHkHeY7ZcJwn8JR8rF2MtTYrcTDc1KTN1zILsy6Qkv1w/Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9995

Hi,

On 2025/2/7 2:20, Conor Dooley wrote:
> diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.yaml
> new file mode 100644
> index 000000000000..4d998eabe441
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.yaml
> filename matching a compatible please.
So sensirion,sen66.yaml?
> +  https://sensirion.com/media/documents/6791EFA0/62A1F68F/Sensirion_Datasheet_Environmental_Node_SEN5x.pdf
> +  https://sensirion.com/media/documents/FAFC548D/6731FFFA/Sensirion_Datasheet_SEN6x.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,sen50
> +      - sensirion,sen54
> +      - sensirion,sen55
> +      - sensirion,sen60
> +      - sensirion,sen65
> +      - sensirion,sen66
> I'd like a note in the commit message as to how all of these devices are
> different please.
Sure, will fix in v2.
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
> No supplies needed for this device? Seems like you would need at least
> one, no?

You mean the vdd-supply? The chip require a e.g. 3.3v VDD, but in our 
HW, we have no gpio/regulator to control it, connect directly by the HW, 
should I still need to have one vdd-supply here?


Best Regards,

Hermes


