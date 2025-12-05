Return-Path: <linux-iio+bounces-26781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9EECA6F45
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 10:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D90383427174
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 08:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961CC2F8BC3;
	Fri,  5 Dec 2025 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="OMHhyBkV"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020140.outbound.protection.outlook.com [52.101.84.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96EB340281;
	Fri,  5 Dec 2025 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764921585; cv=fail; b=I2LWGVpFK5vbum89jqPBP1SsepoKhKrpSpMpHTjuBwQsGkJ3Ht0EjA58/CbZXxAkda6A81nsMMwL2zLZQsVoYL5NCw2DSN3IqRdfY8lR+jgnUseyAjbgmwNBWrRJ4yXgr9BaiQpCCkc/cRyqGIZxE1HrIV3tQykmGt45uAuIy4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764921585; c=relaxed/simple;
	bh=+D4P8aXANHCQPT4ebVlqMilAl2youmVA4SREjiVRRKo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SOoY1myYLh/TnF5xaxX5EJnXxIELbHCUHVQjPaRFXWvR2cEjmjqFzqNlSKiefz7aq+OVnkuuFUee82CjmrSj5MMUDB9l9f9lrWsL6YDSizMGxWfGKS1KG8gxEkA1zggPOMxvI+0gHVf1b6XV0F3Pz91ttejFEYo4M95qLpNYWck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=OMHhyBkV; arc=fail smtp.client-ip=52.101.84.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inamnu40CIkos3cqLZCebrP7hOdwUJokcyQXMLDg4eCOTsT16Hqt1yiq4msRHFjguzFDJszaxafT2EHlHk6VhhdT+8G+fTYJhCjpMKsIGkSeb+NsrMqHIyCHzlEavswyFDPcvy2y0Xc3Z+UrK7zwM8vVX5UlCcSX5OZ331WUPOBGdFJYgLfeYsx/gW7rLrMlmUpasXdsVKfMTHPb/hnaK+5EhnfjPuw+UzYLdHycZXynzHKUogpi4qZdwJLYk5obrmunQaLlwV9G7qON8q/BPLuKpYeYBf/BIB/UjNclN+IJbhUJHHfrT7qmDLNE3cTGHc1G8EgIE3qktYuGHppo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8cob4157SVpJrkscjdobJFDDvSz6Mrg1fXggvQ1ayA=;
 b=SHtGfMIU+SZY9rXODGQoJKUr4WF8w0kflVNEXe9TihfT4pY4WtJKQ+SXa3Ef4UEhm1EksYE4tlDhsJD+L5gSKspzfSh0sWr08sX8JdwsxtQCb6a9xUMx0XZOmD3aRgsFykJEFM/YepePiy1p0/h1vZ4W6FxkDhifSXqPN0Y19a7xeIEeFVomCyQprW9tWeYRdbxVFOyEJfpN7dovpxMIJmkELRPAMldYogC1s5i3iHOy2dgYz9ajGnwqZeJVoJt1PNRfnQ9QBqhCNA3q08o9lAv3VXZVN+bkCc3dwKU6n/kEpdWi+kmq2OYcqSKYhopoCPFHrWtb9vRc5+Ft6XPPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8cob4157SVpJrkscjdobJFDDvSz6Mrg1fXggvQ1ayA=;
 b=OMHhyBkVbhm0SbL/hBuLI/NyrTF2yUnp3vOJG8lPC6atKend9nc0ajTXONX/vCm1MxTPHwCQgxVT6VeKaIJ3ad5bTMLw6SpT95yM/M8pCRGOXNKLYAUnaFM/pVkwYxn5SAM/YxppmOS/v7adhJF65L/xNCehvbRM7E2frJikcHH4gib/uVORYqaydu8DuSP1pdZlHwVa+tSZU5QhKrwUL4GPnRo2KnopOnNdF33wV4tGL8HkZC4eTnxybJpc8UF3bsnuvoig/Fq+4uG3gcrXUSe0/AFqdt9WNByMkrpSyuAzApUia5VELwHvq33R9mP1NmunMu/CwD0AGRnGABWPNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AM9PR06MB7956.eurprd06.prod.outlook.com (2603:10a6:20b:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 5 Dec
 2025 07:59:20 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Fri, 5 Dec 2025
 07:59:20 +0000
Message-ID: <49465e36-882c-41c2-a8bb-3c2e87bcdfd7@vaisala.com>
Date: Fri, 5 Dec 2025 09:58:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] Docs: iio: Add AD4134
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, andy@kernel.org, Michael.Hennerich@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
 <69b230190abb4cd76ad9eb25e2bde51caaa23d9a.1764708608.git.marcelo.schmitt@analog.com>
 <19d5c51d-41f3-446a-aced-5be2fe6ec0d2@vaisala.com>
 <aTGpgEFew2vP1CTG@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <aTGpgEFew2vP1CTG@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: GV3PEPF00002BA8.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:1a) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AM9PR06MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 818e2f08-0722-4834-63fc-08de33d43251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bW1QOUFaWVllMHB4ZGp3RmN1Z002Q0RHT25yRUxtZDQxVUJUNVU5OUNoaXBy?=
 =?utf-8?B?UW96SXprZmtTV0xHOEYrS2dWTEVyUDdCaU4rbi9kT0hGWWRhVWZiOHdJYnRE?=
 =?utf-8?B?YlBvVkZYSGkxSFhNeUJjTFBkbE01V3FoWUZaT3N5M0RpZXZDeGo1U3BpY1lI?=
 =?utf-8?B?cTBLaFRzaG5DUDVrYnM3ejBrOXFQZG82UllkM1NJa3V2NSs3N1MxVERqTW5B?=
 =?utf-8?B?ejZWTnBZVW9MWG5rNVhpMXhOeXZPeDN2dFA5TUk0UXdKWm9MMkNjVk1UWVRu?=
 =?utf-8?B?bWVnSUFRcjdUWnZjYVloaXlpcjRESUtwamYwRkoxeFFaTXRkMWRNMjBuWE1Q?=
 =?utf-8?B?MnNTaHpUeHpkM2QzTXpuL0M3NmVqcnBveDdTVUM3WEdTMjI5cy9tekg4ZkpO?=
 =?utf-8?B?NlgvNWRoRmk2dkZpQTd4MGlDU0g3bXJTYUxtMXhoSHI5MVMwWmxJSi9UQmpF?=
 =?utf-8?B?aFhUSEFURDhwTTZXQ1ozSFM4TTlBekVNY2RqT0R2ZkJCa0xXTEhObXBreXM1?=
 =?utf-8?B?anpKaXBNK1RkZ01PekpjOWtMSWRBMSs1QWwvd2JXQ2lpeVI1S00vdFk2VGdq?=
 =?utf-8?B?SmZ3azUrdjE3ZzVCUjl2RThZSEtHZHdYNE0wbFBmS1JOTFIwWllndEVrdnFz?=
 =?utf-8?B?T2piNWluVnhraTdzVWxxSmI1OEFOTFNGOUF1RWp4VWptbDlYQml5SkVMSVA1?=
 =?utf-8?B?VkJNZ3dvd1ZnTkMyZTJQanM3eUd2N0RaQmgwVEYyN2x2WUNFUWZ4RTB0TlZB?=
 =?utf-8?B?cDRwd1JNZ1NvUW05dmJuOGNSSnE2QVNsWlArRmRXNVA2U0JvcHRLNzZwOE5T?=
 =?utf-8?B?eXBUSno0VzNzbE54L0ZQVGJkNURmSEVFdkRneXdqdGFkNkZNV1lza2t6K09t?=
 =?utf-8?B?WitMT0hycituMGRWYkRFOTM2ckNOdnZXZXp4ckdKbWxHcEIzeHVwbVNyZlhT?=
 =?utf-8?B?Q3Z3c0UxRG1oUFJ2T3Z2Q3dwZ3Jxb3p5MEVVdXc4b2FJakJhZEdncXJOZ1Vt?=
 =?utf-8?B?V2lMSTQ1UGMybjBiVVo5dFYwTjc5cFBncS9TZFJocjBkcHN4WVpXdHNCYSsz?=
 =?utf-8?B?UHBUY2dicmd5WHJNRnMvYjlJdGJLWUJjQ2dCQjhxcHFzUzRzb2lGbjIrT0dP?=
 =?utf-8?B?TXN1Mlo0c2FIYnQ2dXFoelplOStJSmxmT3JsSUl4WlVycTNXN29CL0FKZHB6?=
 =?utf-8?B?ZzdjcVVNcHRhbTJDekxNQWdsQlFScEg0N2V3NjlwZG53Z3NKOEg5VTI4NzFS?=
 =?utf-8?B?b1J2dTRHdUxva1c0Y29Ma1J2cEVLbURFcnZyVEdDd2doaG5vV0ZkTHgyM2hK?=
 =?utf-8?B?WDJoM1FaMTFOOU9JaWxySGpwYUxqdjhSaFZGeFhLM0NUYzZVRksvR01QbWRO?=
 =?utf-8?B?WGRYaXlDeHJ4QkIrcno5OFp6bTk4WUYyMDRiK2pSWXJYU1RzdCtpbDRvTGNH?=
 =?utf-8?B?Vk5hNWQ5SjZBWnBkYlIwbkZxSldxL2JCWm02UHVzeExQQlF2Q3ppYnR0RXYv?=
 =?utf-8?B?Z1JLbmFOdC9DNjFhSGoxT0hkZE9iUUY5Y291bUpENU9VYndRK1BqYkhjV25B?=
 =?utf-8?B?WnQ2QVhOR2lqaUNrL3FqQ3BPRTVGc0ltZUFHZzB5OGRZR1VoMmVydmVzY2Vj?=
 =?utf-8?B?Um93SlpyeGZFNDNwakZkT0htdTkzcVVweWhEcXNUOW40bCtiTzlYVGY1SVRt?=
 =?utf-8?B?M2lkNzB0YWdhV3p3dGRRK3lzZWdiV3Q4ZGV5RVV2VXZoNkdvN001MityNlF5?=
 =?utf-8?B?eTRaZmxsRk5BU1JVanZjdURtR1ZBNi80WFdCRUloZkJiZ1FTbDVKekNsbGhr?=
 =?utf-8?B?ZmowMVpaNjArNXlDZG8rSlB4R1JLU2RkbitGUXZ3WVNMd05VTyt1K0V5a2lx?=
 =?utf-8?B?bk84MGNtSGhHb3JxUTFUSlU1eVI1ZTNCdDVwZFpuVjNRdmtBY09pWHZ4amZk?=
 =?utf-8?Q?C5ujcjOCGFWsHrplOS0lJJu53iD9+3G7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnpVR0tmVUhZRHJ1dVFYSFJCM3hZcCt5NmRJRUt5R1h4dFVlTzFMZDhYVVdC?=
 =?utf-8?B?N3N2WjZjS1VXcnU4dVQrRkQrd2hqZnUrVHk3TTM1Sittc3FySkFzQU50SmI4?=
 =?utf-8?B?aGt2bDJRQzdCNmxWK1RTYlJqNG9XaEE4TW5Fb29SUE43YjhJQkM2bysrZzhv?=
 =?utf-8?B?c3d0TTBPRFRhQ2dDek4yNGdCTm50QmoxZUpuVnZpT2xNTjdTOFNBeGNxWWR3?=
 =?utf-8?B?dkNHVE5FVHlpR2I3Szk3eFJNMjlEMUN0TE84Vk1PUTVXeG56dmtQYjh0NmN0?=
 =?utf-8?B?M2xwSllncHI2RlBDOXpCRXRLSGlNcEMvUXRlbklTcXdEN3MwWk1nYWhlMG44?=
 =?utf-8?B?M2xSNUZZOVlReXJ5WXRSUGI2U1lKaE5YVDQxajNUSVdwd3hIcmZsa3Q5b0pT?=
 =?utf-8?B?WlQwV2dVS0ptZVB1OXVYcmE4TmZkZTY1OHQ5ZTJzOTkwSktESlRvUVcwOUti?=
 =?utf-8?B?SjBGeExIMjIxcXVha2lqTG9mVENJektnMEpDYjZCaGFUeXYvMW40K25YS3Vy?=
 =?utf-8?B?UnBHSXp1aHBNcncxNDlTU1lKSzV2T0hJTlFyNmRidWpLazE0YVk0aWZBU2hC?=
 =?utf-8?B?NGJVN1NQRjV2Rys1am9TM2ZKdVJtWGswWmdPNThLYnY1MlZYUmZxUFlrVXUv?=
 =?utf-8?B?bG03N3JVZG41TEZDZldvYTU3K3NYS21JQUI3T3ZsRWtSUC9GWDBGSGNKMmJO?=
 =?utf-8?B?NHhHYzlqb3hKU0ZCWldZOFVYSFNkYlhZQm5vcDM4aFhISWoxYytmSEUrSFov?=
 =?utf-8?B?ajYxZHBNeVZtNzJKYmRKMTAyUWZDc1ZYazcyQVhtV2Rpc1VJYXNNMkE2UDZm?=
 =?utf-8?B?YXFJeU54dnpPaWRnbGxRcDFCOFNHeWg5MHhiSklodmd1WXVhSnIzWG9nbVNC?=
 =?utf-8?B?Zzg4STlBYmpxWTRudzZRVDlNSUREbHVRTVpOY2hXUWlQOUhwcWdCbThXa1RL?=
 =?utf-8?B?c1dNWk4vUFhUTDZyZUxSbHVORU1vcnc2bEVDWGlWQTBiWEh5Wk5xbDNaUG94?=
 =?utf-8?B?NC9EN2x3Vy9CSTdWYUUwdmJLVHJISmlJbStpUlhidksrYXBDVi9MTzRVOUVy?=
 =?utf-8?B?NHZLNVRiaFBjTG1lM2dXV2VMYlFKa05CWDJrTDFKL0V3K2hUcDVZbGdBdC85?=
 =?utf-8?B?NjBlQi9qREdmNUhOMUpiSUFaNmNRZjI4WmpGYnprTVhsOG55c2NSbXpUaGxJ?=
 =?utf-8?B?My9xM05UL0RuZm5ndnV1R04yd0ppRVR0LzYwTGE3eUZ2d0h3S2lFbER3bXVR?=
 =?utf-8?B?SzdOUUdXWUNFVmhCTm1VMVJTNVpEYkFwRXF1eTBackNyWjR2VFNNODlsZWQ0?=
 =?utf-8?B?WWhkQ1ZqQVc5Rlh5dGcyZStvTnlaenBWbW9uQVJST1gvQjJEL3JYeGFhMzdh?=
 =?utf-8?B?NGJnTmlPa0MrQ2VENTl2aENGd1BUQUROMGpxYWRYaGdQYjk4Tk5GTXRXZ0VT?=
 =?utf-8?B?ZkNsRHVna0xmRWtubzJsZG9sTUdMUlVWWkhTcTJPaGVqOExBT0lzMHYyOWFF?=
 =?utf-8?B?SXJoUm5BeDdHQ0l5K0Y2YUw2dUpQY3p1cVR0TFh5SzRGb1ZnUnVMa0tSMjN1?=
 =?utf-8?B?clMyNkxMZnI5UTQ5Y0t1elpXVURROXYrRkNBSTNTRTNKU09yeXdUM0orc09S?=
 =?utf-8?B?M0FPbnlDb3lndlhuSXJYZHBpd3ZIbEpWNnl2cHdtYm8vYzM1eFo4Q0VNNWh3?=
 =?utf-8?B?ZjdVQXhPWmdMZ0ZGeDVyVEtVdkRvUXRMZjlrV0p6QjBDd3B5RXh2YWNGV0lu?=
 =?utf-8?B?UVNCRHJGM1p5MmQvajJCS1dTOGErU2t3TGFoaDRxV3NrcVBnWUhBMVFRNXE0?=
 =?utf-8?B?akEwdk1IUVBTNzhoNmx0TEtiOS9HYWljVzQ2UE1IZ0NpcGdpZDBFdVkra0JY?=
 =?utf-8?B?citLMHZ2ZHJGNTZMd0c2WHBIYkNqbjdNV1VMa3N5VzFhUGJzdXpxYlgrTThJ?=
 =?utf-8?B?Z1JVd2IwTHNWdEFMQ2Y2VkpOa3ZFMGhGNGZYN1M0K2N6OTJwY3VSRWJ0a05j?=
 =?utf-8?B?dDgzMEs2WU9uSnBkaklybzMvUTlmUWZqdnJQMEZIYVV4anhJaXMyRVB0Wk5U?=
 =?utf-8?B?TCtNSy9abWNqVXZRVUhHcW83OUFadEZyTUpIdWtudUlwejZ6akFjdXJzNVg2?=
 =?utf-8?B?REJNVmFXdnhybWJld2R5SEZraTNGRXZERWJGbUNRaFg4M0xpWXMzOGZRazl0?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818e2f08-0722-4834-63fc-08de33d43251
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 07:59:20.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbPuMP20dLDsy0/pBKmDglwLrXt11OtNyZ5/0ciA2T85snmonUYUOx4ihmJfJkAHFVYVxP4OKpU5c6+aHzSESg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7956

Hi,

On 04/12/2025 17:32, Marcelo Schmitt wrote:
> On 12/03, Tomas Melin wrote:
>> Hi,
>>
>> On 02/12/2025 22:55, Marcelo Schmitt wrote:
>>> Add initial documentation for the ad4134 IIO driver.
>>
>> I wonder is there some information in here that is not readily available
>> in the device datasheet? After all, isn't idea with this file to
>> document peculiarities that are not easily found elsewhere?
> 
> You are correct, these docs are mostly from data sheet info.
> The main idea of having the doc is to make clear what peripheral connection
> schema is currently supported.
> Because AD4134 is both flexible and somewhat extensible in the way it can be
> connected to the host, we could have different wiring configurations, for
> example

Thanks for your explanation. My humble opinion is that it would be
enough to mention in the commit message for the driver being added, or
in the device-tree bindings that basic I/O mode is only configuration
that is currently supported.

Thanks,
Tomas


> 
>                                                               +-------------+
>   +----------------------+                                    |  DATA HOST  |
>   |       AD4134         |                                    |             |
>   |                      |                                    |             |
>   |Data interface  DOUT0 |----------------------------------->| GPI0        |
>   |for ADC data    DOUT1 |----------------------------------->| GPI1        |
>   |read back       DOUT2 |----------------------------------->| GPI2        |
>   |                DOUT3 |----------------------------------->| GPI3        |
>   |                DCLK  |<--------------+        +---------->| GPI4        |
>   |                ODR   |<------------+ |        | +-------->| GPI5        |
>   |                      |             | |        | | +------>| GPI6        |
>   |                      |             | |        | | | +---->| GPI7        |
>   | SPI interface   CS   |<-------+    | +--------|-|-|-|-----| DCLK        |
>   | for register    SCLK |<-----+ |    |          | | | |     |             |
>   | access          SDI  |<---+ | |    |          | | | |     | TRIGGER     |
>   |                 SDO  |--+ | | |    |          | | | |     +-------------+
>   +----------------------+  | | | |    +----------|-|-|-|---------+
>                             | | | +---------------+ | | |
>                             | | +-------------------+ | |
>                             | +-----------------------+ |
>                             +---------------------------+
> 
> or even with two devices [1].
> [1]: https://lore.kernel.org/linux-iio/aRIIDTUR5Pyz1Rxi@debian-BULLSEYE-live-builder-AMD64/
> 
> That is not a current use case but it could be possible. I think it's likely we
> will need extra software to support those cases and, when we get to that, we
> would be adding more diagrams to this doc. Still, no strong opinion, we can
> alternatively add the doc only when we get to those more complex cases.
> I'll follow reviewers' preferences if you or anybody else express any.
> 
> Best regards,
> Marcelo


