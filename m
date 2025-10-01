Return-Path: <linux-iio+bounces-24626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0D3BB08A9
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 15:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14E919451D3
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D8729A31C;
	Wed,  1 Oct 2025 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="oVnxHalh"
X-Original-To: linux-iio@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010022.outbound.protection.outlook.com [52.101.228.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB32ECD3A;
	Wed,  1 Oct 2025 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325981; cv=fail; b=qV0bPYxIB80BYWCpf8bxj0iPtWZe+j80e58c3456+CNoUeiusV48ejeGsYs1YHSAu8RyVxf/m4qFXx9G1nGH6GjMAkTb7LulZf7jX/81VQuwmj/kD0RGRU83bsKWSDy+ZZs9tldTek+8v5YsNmPn1A1v3aJUb0xqYWHB+H957Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325981; c=relaxed/simple;
	bh=PWviNDSx7u/MXKq/pw8qLQLIM8NsjIMpji56ZDyBlCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p5lGzSik1hpLq106OwVvNv22/7gS1fIkBXTZuuMfXc02eSZKbeZmETW22rsm+mZ9poMy5PjzVHz3HNSgCjf4bK1IfDA9LROMkKrbCanuGjbFCs0V3EbcRqf59Ot2Pw5Icx6ScO2vUGuvJm+pKLbA1A/AlRY9nCLDzO9ZyvAKJyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=oVnxHalh; arc=fail smtp.client-ip=52.101.228.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHKyS4CKNImAYH85Z8me+Qn2G4kvGURr87l+UYbExmRhv4m3p3o23dsd5JvqZ1Cy0q6I8jtdAtmpPkg5/iBLLs3ASl9uuhoUokVkUMBIMxaRyOAVugH5r7eBnlcQU1iQGcKIVJTMM9rpVEzKiO+ftGNjkNNx8XgRwL6gaHpCdCj/FPRxgFWjWZxrE4IH2HCnYPVDCCX1HUhoMFXZWtXm0PjQ2PlYMEdKbqYHMJ4LwFU8fpLXRrhQsk9SXUdumjBskTBY+6m8mWEbCjecu9kdpCvx4k7JlMGXLn9fitpEJshtYJU+fx2vWWyCe7yaStMvZRlPp7u1MLDYB1DFFswahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWviNDSx7u/MXKq/pw8qLQLIM8NsjIMpji56ZDyBlCc=;
 b=HE4ve8a3SBwRGh7DAUm2l61pFExal1xa/ogKpjoqzueRCvIvTTINqZZzrakwfqOX6FzR7gsKip6slUtkcCWy7knSQbvrLgh5Xej2vxCwQv+AhhSYO5pnux95aeoyiyAFXigHqNILrdV9uGH457zBq3gAq4okdaSAzpWGfPkNY32q1KYeCgSUAWuQXeH0uXION17nypAx3WsImosnmpLK66K0I7V66a9IcsuZd7rr+620NA8VBZ1HmuMpDuTUud0lDnCcqvo/p9J070AlTfL2fmMmHtXTIaNn7Vm8eLrtuZ5xAjvUq5qYNw8iXJrcI0Cjwdqhe2KNwrxYpsfCWv8cRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWviNDSx7u/MXKq/pw8qLQLIM8NsjIMpji56ZDyBlCc=;
 b=oVnxHalh7yOOb5/QzhM24QqO9DKQ0uiVnQJ713KZmYauAzWPK76ovCrW1g/nevCgcrgTx0uq16ASWIE6pL21fO/RaQex1z6cN+5MuTscsIP0VDiuCl9DXOouP/j2aqVR3jufvzVy1t27uZJljxYLBkSO/L6LYPYTGSxXcnpSJew=
Received: from TYWPR01MB8805.jpnprd01.prod.outlook.com (2603:1096:400:16b::10)
 by OS3PR01MB7382.jpnprd01.prod.outlook.com (2603:1096:604:148::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 13:39:33 +0000
Received: from TYWPR01MB8805.jpnprd01.prod.outlook.com
 ([fe80::6f4b:7755:832e:177b]) by TYWPR01MB8805.jpnprd01.prod.outlook.com
 ([fe80::6f4b:7755:832e:177b%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 13:39:33 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: geert <geert@linux-m68k.org>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/7] clk: renesas: r9a09g077: Add ADC modules clock
Thread-Topic: [PATCH v3 1/7] clk: renesas: r9a09g077: Add ADC modules clock
Thread-Index: AQHcMs5KLWKHeXILEUynndtXtH90DrStSwIAgAAAg1A=
Date: Wed, 1 Oct 2025 13:39:33 +0000
Message-ID:
 <TYWPR01MB8805135447EAAFABC00B3A7A85E6A@TYWPR01MB8805.jpnprd01.prod.outlook.com>
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251001122326.4024391-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <CAMuHMdUA5r519G=OQM66wSig9r2dDP4y1NTH8zOZCTLb5m2Tew@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUA5r519G=OQM66wSig9r2dDP4y1NTH8zOZCTLb5m2Tew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8805:EE_|OS3PR01MB7382:EE_
x-ms-office365-filtering-correlation-id: c852d466-8444-4156-90a3-08de00eff490
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?ME51c284NTJEd2xWOU43c2xnSjNKMUorQ2RmWXJVb1ZWR0FpNzNuRVREb3Vn?=
 =?utf-8?B?QzZuSWQ0dm1VVnJsNm83dWk0TlFTdVR1d1FyTFA2TlV4a1MrclV6R3psMHkx?=
 =?utf-8?B?azAzeENNM29hR29oTXUyeEJ6emZOMWZvRUVOMjFiTHA1eHQ5a0F5bVVRU2tL?=
 =?utf-8?B?V3VRVWdUV1VUNlRpWk1odUZseTQ0Y3cyblBIcFM0T0ZacXNsNDVJMWlUMjFh?=
 =?utf-8?B?MnJFOFNBeHpwd29SRnNnKytheHRubXBBQjJLVEg3S0VwdnhBNjQzUVBqV3hL?=
 =?utf-8?B?V3U3UGVqM0hxSlMxRXg0MVIyYWYyM3dia1VvVHJ0TzJrN0dhcnRSenpRQzYw?=
 =?utf-8?B?VkNyczcrSWp5eHF6djFMS3VUczZkWmtLWVlZMDN3bnlFK3ZpV1MyWDg5TzZo?=
 =?utf-8?B?NUc0d2pSY0JRMldUL05PNGhMUjdVNXdtU0ZBWmpadXQ4WWJLWGtaL3F3ZXl1?=
 =?utf-8?B?V1JYQjZpWFdXRUthcjcyakxtNTdaRVpUTHFpS3A3UFQwTUxqSk9pWm02S29B?=
 =?utf-8?B?bWpJTWxnZlYvRm1lMVhSSDVDMnZsSkw0LzJlWU14ZTF1ZDZ6Vnh1S09uRVBY?=
 =?utf-8?B?Vkh0K210ZGV2d1JNSXc0dklxZXcrOXN0S0VxaTg4THY4eVBqOEFHNFZ4akdz?=
 =?utf-8?B?YkRNTW5JUHRDK2c4dkRpOXBKTk5RWXV1RWRxWTFBVnU1My9YUWZWQmRtU09W?=
 =?utf-8?B?b3IvOVBPdHhOMzhVcWxRUWZ2N0YxblJlVEtKbG95d1ExOGlJTlY0eEtleTB0?=
 =?utf-8?B?L3Z6bk95cjFiWlk2NVpERFkrMkcxam1nWWZCek5GQ0hCZDBQNjF4OVNoUXNw?=
 =?utf-8?B?ZkVKNlVoT2tNVGpmcExFQTZ6ME1XbktscExnekE0YTRtTkVZblZBVzFvUGhD?=
 =?utf-8?B?UldIc29WREJZbE1JZGlWUy9QVW5DOHlESTdxNmlZWE1lb0NKdCtJb1BLZUlO?=
 =?utf-8?B?S3ZaUHRLK1dLS0cvblRnNU5oMGN6dzZyRnVDUHVNb1ZucEVGNU1zQUVpOUsx?=
 =?utf-8?B?bzVhbGdHby8zaE5adFJJZk9WaTdVYUppaE1nR24yVzVUMGN6NUN2MnFVNGha?=
 =?utf-8?B?MEg1RU1aeTJYOXpFY2xUNHp1bEhEQVJQL25DbEE5aFJLbEorYUlrVlkvRUFO?=
 =?utf-8?B?a09jQXM4Tkt1RkMwTjhkYitmWXM3cWJPWGg4c1MxTi9rYmUvUEhYRG55M29w?=
 =?utf-8?B?eU1NeklqSzlnUVJmRVpER09OdWZiWXRzRlZNTEtscWVSaFMrNk1CRExISVlx?=
 =?utf-8?B?dVRnUisxUnpaTXBCZTAzalhNQldmcDdnV0o4Q1V5TlFsclhSR3M0U0dZVlc4?=
 =?utf-8?B?WXNGODlXTThFWklUdkRWeDBCNnFzQnFtbXZOTTVVMldoczlwcWZaVmx2Zytw?=
 =?utf-8?B?SUdxdnZrRW1XZmF3QWNyak5EaEJ4Mk9uUXNHamFxOGRDdGJaQUdPWVRleHFh?=
 =?utf-8?B?R1pnMThJQ0J5aGxyOGpPRENpMVBmMDk5d1lyOWhKdFcrUjJ2eC9EY2hJL1Fa?=
 =?utf-8?B?Vmo0TXMyUlVlZGpDc2gzVkhqc1Z3b1JlWk9CNjQ5eWdoRkwwMEpEMUJlRHNF?=
 =?utf-8?B?VEUya3ZTd1BwQVpMbUxvdW9yZUIxaW9rempzS2RRelM0WkFEamM0dHJpTGVD?=
 =?utf-8?B?YTUyYkFUbUUwTEhtSXVRdFJaNDFIYUZTNHNQOG85djdkVDI4YjBlTy9KTzJQ?=
 =?utf-8?B?WWdCUWJ2TmhRL21CRTN0bmN4Qzc4SGsyL2NFU01TZWxCSUgxSElVREV2eDI1?=
 =?utf-8?B?cDZBdDl1NlB4cTdlek5pejRsaWlJQzhjQkYvUTlpTmJZdGpBN0dEWGkwNFlj?=
 =?utf-8?B?OFBVVG1HMVVlVUF5QkwyeVpTNS80ZFNyby9pU0hvQ0tGRVp0bjFDQWw0eDhK?=
 =?utf-8?B?R09zTHdNMXlPaVJBVVNEWngzVE9sQVg5U1MzN3FlYUNXcFQyaTlVVURFRmVm?=
 =?utf-8?B?WWE5YWtoUVZkaDg0VC9DaDh1TGVOSytVdml1c1B2b0RuckFtRFQzWmtnWFZE?=
 =?utf-8?B?NTIrQ0VFVmlQUDVCcmpFTWJQMlRYN3UxbEJWLzVSemFCcVluQXdtbXJySm9B?=
 =?utf-8?Q?opSCDA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8805.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nk14b3JUNEtSSk1tdDNucEg3dUh5anM4djl5NDVOMDY1bGdEMlNEMzBLRFgv?=
 =?utf-8?B?bG5EZUtUWEhwUmdmanpGYysyOUc5ZTIvMlpZOTRPOVV4RjAwMHpjSjFsb3oy?=
 =?utf-8?B?SEtPNzc2MnM4bEFPTEFTTDdENldJVHl0K0ZIa1ovSGFFLzdXaVcrWG5RWUt3?=
 =?utf-8?B?dlp2U3hzb3ZJMTBXUlhyeWhWd1BpRXJrY0JLb0hFZm5MS3VyVkhZcnVLV1lU?=
 =?utf-8?B?MEZQc1I2OE1SblkySnphNFQxV0tVUHhjelJlZUQzWGxEeWx4SEQ2MlZacTVB?=
 =?utf-8?B?NlpwQWhRM3daR0dUMTh3Ym9CL1pmNS9NajYxVlZWZU1XQm5Yb2Y4WUFyTWND?=
 =?utf-8?B?cDlrczh2S01aR1ZRandEQUk1b0kzbnRMQ2VIcHZ4UUd2YmRad0dqeWNuRDNK?=
 =?utf-8?B?bWhTWWZON1ZVWkxlVDd3UC83VkdiS0lFckF2U0p4ZHBZZ2U2ZE5uR05IeU9O?=
 =?utf-8?B?eWFFRmVNRHFldFJ2QlU3dGlhRmt3WXBVRXdJUC9Qck4xSW5IZk81Mjc3T2VJ?=
 =?utf-8?B?L0RhTk9KVllReXNZelVLTlFJRmFibklpZStncDZldXRtMitRaDdRaVAxMjB5?=
 =?utf-8?B?VE1wbDRyTjZ1RndEUVZ2MVVOZUtST3hKUzYrTXpaZUhiNTUwK0w3WUFWMHpX?=
 =?utf-8?B?ZlF3OS8vK0I5VStYZ0xFZTNBOG5GYnU0YUtSbncrekx3OElPNjRHaUhFeFdl?=
 =?utf-8?B?dGxleU5uWkdZV0JUVlArRThCNEk1RE53b0h2RDc4Z0owaFA5TCtsbG9tdElM?=
 =?utf-8?B?QzJOZFhuZkl5Y3NadWFhRkJLcmZ5OWNCcWdvdFgzQkFCbW1XL3dEYzZHR0ZV?=
 =?utf-8?B?dnk1Nm00QzZOTmZ6TnV5R3RlckdST3hZbE4zaGFhZWw4Qy9nNWJ3N1VxWi9K?=
 =?utf-8?B?OHZLamNiL0NlcGo1NFg4bUJTSWYyLzhMTDk2ekpyVlhCbG1CWEhuVGsvRkRX?=
 =?utf-8?B?c3k1eGxVN01kZ29mZ1Nnek4ySDJFNW8xSW1FTlYxbUxTOXlkZDZQcDBzMUtD?=
 =?utf-8?B?WklmWGNDOGNaalhwQWFpUndjQkQ5WWtWMmxjNnZrbGljQXJnRVNCWU82bEpX?=
 =?utf-8?B?WmdFbkxuQUIvbXlCcU1qVExxYTBsT3BKdFhSSFpyV3VhMmhDeUZ2dUgwVTdJ?=
 =?utf-8?B?aUdZQmxoeUphTEpNNmU2cThYQlVyOUNxT2RYaUhXNld2Z3NNbmFaS043bWZV?=
 =?utf-8?B?b0trWHkyQWhVa250cnpGTVVGNU9TMDd4VS94enRLQTI5VWRlQlBkTkU5ZFdJ?=
 =?utf-8?B?YkZMTTF4UUtwWWlKV0dFMFFYN21QMmtUUlhCUENCTlJQVUQyQ2pXRVI0c3dz?=
 =?utf-8?B?dFRVeHpHT28wR1NNRTRvNzVlWlFtNDFXR2VyTXNlMGhYcXdjWkUzenRnVjBG?=
 =?utf-8?B?czVDaDYwT1R4VjI0MldzWURYT3JQMWF3WWRvOXNVZS8zODBxaW1yaHp1aDQz?=
 =?utf-8?B?OWlTOGhCbFV5a0ZOTlFEK2M4bm92NGk4VjNxamNCN1FZbysxL0RSTmRMNzlU?=
 =?utf-8?B?M01yMWRZOWZ1Z1FQN1ZkVlhxV09RRUhVYlM4bm9LcVY0MDlUbmQyL3Y5aVQ0?=
 =?utf-8?B?eVllMFI3VkE5ZFNBNDk4YVJTTVlXcHgzanpkVFpLMy9aZGNMRXJ1TFlvbVdy?=
 =?utf-8?B?UDFrSGlRdmpJVUVSVnh2YVc1K0F0V0hsTEN3ZlBVMHBFVUZZaS9SUm8wVzR2?=
 =?utf-8?B?UnJRWnFTUVlLY29HSi9lWWpLdzlTa01ma0ZOWFNpNzRBaitVK2FFT0NtRG1Y?=
 =?utf-8?B?OFBPZmovMHo4MmNXZnVQamRtaVBiRVJkSXhqZkdkYS9GQWZWRVAySUFWRkp6?=
 =?utf-8?B?ako0ZkpHSjVWbVNlaC9yd3JOWWtndi90OTU2d0ZQOWhndm85SzRsSGpUL2Zy?=
 =?utf-8?B?M1hWS05adzYwSlpBMURTTnd0am9DbEtNWkNrM1lsNVNWR3NQaTdsUHl1MHU4?=
 =?utf-8?B?NGJpWEN5cTAxbzBRYnZSMTJqMDZtblc5SWJqMnNjeTdYUzBjOGg4WHpIVWF0?=
 =?utf-8?B?dXdtYmFjOFdCamhtQ3ZpcjNlazhmRFVUQnRGcmoxUXRMeENHWnVVUDU5bGNY?=
 =?utf-8?B?bFBzSFg1b2E2WEkxK3o0STJEMnNJM3VKVU1iL0tXMUtIVCt5NG1EZ1VjM0Y5?=
 =?utf-8?B?MTdSSzdaUnRNUzNpbkdRQmZ0WHNGOG4rOVZzM2FNMzBDTXgvSEdNUlNDWlJl?=
 =?utf-8?Q?L5DtA13a9BBeKkVa0BlDRuI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8805.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c852d466-8444-4156-90a3-08de00eff490
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 13:39:33.2933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvVEPCZhzak/7gzhXQy7k1AbQQG29/YcOLLk1nMj2K3Y26eIiOG6CVyRQ9jjGmlVkIRVNQhBLJ3Pr4g5qLRxJk2rt1QXBwUlrsv/bywAz1w0pUt3h0wj29Ejmprsiofk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7382

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9l
dmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDEs
IDIwMjUgNDozNiBQTQ0KPiBUbzogQ29zbWluLUdhYnJpZWwgVGFuaXNsYXYgPGNvc21pbi1nYWJy
aWVsLnRhbmlzbGF2LnhhQHJlbmVzYXMuY29tPg0KPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8amlj
MjNAa2VybmVsLm9yZz47IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IE51
bm8gU8OhDQo+IDxudW5vLnNhQGFuYWxvZy5jb20+OyBBbmR5IFNoZXZjaGVua28gPGFuZHlAa2Vy
bmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4gS296
bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5l
bC5vcmc+OyBHZWVydCBVeXR0ZXJob2V2ZW4NCj4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsg
bWFnbnVzLmRhbW0gPG1hZ251cy5kYW1tQGdtYWlsLmNvbT47IGxpbnV4LWlpb0B2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiByZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjMgMS83XSBjbGs6IHJlbmVzYXM6IHI5YTA5ZzA3NzogQWRkIEFEQyBtb2R1
bGVzIGNsb2NrDQo+IA0KPiBIaSBDb3NtaW4sDQo+IA0KPiBPbiBXZWQsIDEgT2N0IDIwMjUgYXQg
MTQ6MjQsIENvc21pbiBUYW5pc2xhdg0KPiA8Y29zbWluLWdhYnJpZWwudGFuaXNsYXYueGFAcmVu
ZXNhcy5jb20+IHdyb3RlOg0KPiA+IFJlbmVzYXMgUlovVDJIIChSOUEwOUcwNzcpIGFuZCBSWi9O
MkggKFI5QTA5RzA4NykgU29DcyBoYXZlIHRocmVlIDEyYml0DQo+ID4gQURDIHBlcmlwaGVyYWxz
LCBlYWNoIHdpdGggaXRzIG93biBwZXJpcGhlcmFsIGNsb2NrLg0KPiA+DQo+ID4gRm9yIGNvbnZl
cnNpb24sIHRoZXkgdXNlIHRoZSBQQ0xLTCBjbG9jay4NCj4gPg0KPiA+IEFkZCB0aGVpciBjbG9j
a3MgdG8gdGhlIGxpc3Qgb2YgbW9kdWxlIGNsb2Nrcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IENvc21pbiBUYW5pc2xhdiA8Y29zbWluLWdhYnJpZWwudGFuaXNsYXYueGFAcmVuZXNhcy5jb20+
DQo+ID4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlk
ZXIuYmU+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiBBcyBJIGhhdmUgYWxy
ZWFkeSBxdWV1ZWQgdjEgaW4gcmVuZXNhcy1jbGstZm9yLXY2LjE5LCB0aGVyZSBpcyBubw0KPiBu
ZWVkIHRvIHJlc2VuZCBpdC4NCj4gDQoNClRoYW5rcyBHZWVydCwgc29ycnkgYWJvdXQgdGhhdC4g
SSdsbCBvbWl0IGFscmVhZHkgcXVldWVkIHBhdGNoZXMgZnJvbQ0Kbm93IG9uLg0KDQo+IEdye29l
dGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+
IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25k
IGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNh
dGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQN
Cj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVy
IiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=

