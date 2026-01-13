Return-Path: <linux-iio+bounces-27661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7C8D171B4
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 08:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B67C63031988
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 07:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEE1217722;
	Tue, 13 Jan 2026 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="uLU88VPk"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021123.outbound.protection.outlook.com [52.101.65.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE5830BF4E;
	Tue, 13 Jan 2026 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290482; cv=fail; b=Sc1K/r13MAH9haUwRqrLBtqxxwakDKOXE4rMfNto53WAVn61G8I1vDb3ZOTA09WfgrBr3qQpoH1WoPFjGsMfaplUyoLgKHSYA4fWR2Rpe4toqNUqg+dd9ngCU12Xp7ktP7y8Uuj1y7vrd4pkIIldIfR2t9qDUfGvSDwAGsA6I04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290482; c=relaxed/simple;
	bh=n6ZwPqdL+xe7efRcKx/iSTiHcXbJ+Xwbu3k6eIe9pck=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WTwXzIGZhjH8YNeoeLZmAvyfBNaEwD2svrqpSJVwNpMheZen1/nsp8Gz/wJc7oN0+JfWLyxl1VlyFcaDDQb3qt5V2hvNz5e+VBWAwxpta9KeQqtxq6Pzhu9f/3e1uJqIdHc7SobRL3oIcFy1XJtT41Hzk/YCmQg900RJ5J72xGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=uLU88VPk; arc=fail smtp.client-ip=52.101.65.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBgV9REcPE9zQ/U20zBgbe0JB23NjGUXgejM+tekTXIPQlZrMLyTtBF1P6NghYTHB066LmjMx7zTyKigTQcMJGfsnLyxlBYwgQ+lL691bwheAE2IkiPrdtPMUVgViCgA97Xk4KFWTNRs1vCnZUoHl+Shld7bgZ+OThqSOeBcavC7/tYQ+wAGNV+JIRHyDOKh4aERkSp9GE84/r3uVK+e0yzD0sQETjkgX5LrR63t1xcx/NuGwY+BCSS/t9J/dSVxTcGv8Te3CTcWQjU+XyT4bajIqFZtj7RBVkWTxLtuvYfgbl5VMa3dfqPFaaAyeIEaVZ9URLnrkfDEWqj3to90uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pK54KWr4zc5us9KuXGgRo75cN6evKknzpGq5QfPO37w=;
 b=hIN7p0IiTFhllKVy4Vl40z+zQiYNJg/Zu5/Blb0BVI+ZM2uXkYcZbNMKm2DkF9nmCh7emnCuU1qa+K4vuOThZbh4c9ptEUda3WDVA7jt9IQrzVViaG5Vrc+d1OI/7UlmYkmcLtlMlXFrTsZFyXPwz/U1XSrrPINcES3MsTIKv1i18R047gHGI7KoePeOIs9QTmP4swoMWJmIi3x+4AjGPt5paaXhBD7n0ULoBDF1jYu4iQfBJS8YXJWLdVwgyOdVnwn3PC2CdwvP1MeOrovPwmILeEeb7P7XBsbviDt+HKEebtoj1zwavEvvT60kZKet36nmLFzpKr6mKSFPgLZh8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK54KWr4zc5us9KuXGgRo75cN6evKknzpGq5QfPO37w=;
 b=uLU88VPkG5qXwcQcz4Xm/eT4MTm+lBY+wLXFuYoBdXOIhy1QdVX64q4HO752AJeR5Lk83Yai/rm2jxCPUL5h68hPlA8jwu5JLbsnmXcdaeYibEnin1yfueqwXxkjbbvdPpP9wzqDf+NzK6wVxcNqekQp3nMeZj2TDJbx6e2KDUbBwlgbh9rk9tOvhh0RFKNRwnfZevlwHIl4cv5rHiImMcaT5tH98JhUHBMJyFaXRX60d3NDD7OUgqCzOnbjC5cOT1Peo2XELHgz1Mbz5k7+oRR/61jcmgwLbJ7fvC0APpgg8gSseYrVg7zngm1X6Y72eWmFHrz4cs9ML3rLDl8O8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PAXPR06MB8223.eurprd06.prod.outlook.com (2603:10a6:102:19b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 07:47:48 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 07:47:48 +0000
Message-ID: <51085acb-91c9-43ad-8f7e-94f1e9c995ed@vaisala.com>
Date: Tue, 13 Jan 2026 09:47:46 +0200
User-Agent: Mozilla Thunderbird
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
 <20251221200014.29af7df8@jic23-huawei>
 <356a75b0-dc3e-4d10-a827-1af3b4ab638f@vaisala.com>
 <997f9d13f44031170a4518abf23ee6806d526054.camel@gmail.com>
 <20260111114109.28b01266@jic23-huawei>
 <d36d38b2ae691371c653927fcba310bc525e0aac.camel@gmail.com>
Content-Language: en-US
In-Reply-To: <d36d38b2ae691371c653927fcba310bc525e0aac.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0033.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::26) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PAXPR06MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: cffcae49-72a8-48ce-3d5f-08de52780c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3d2SFczUmxoQTdNUlZ6Z2FLZnBhdTlPNVQwdU5TTkZnaHhGNHdVOUZWK09a?=
 =?utf-8?B?TGVZcVZrTVk3MWMrdXc0NjR1K3pPaHl5UU0zZlh1TUZzSHZJaVA5ZWU4aTRx?=
 =?utf-8?B?WUtHYzhQb2lQbEhsOFpHeFNVQ0I4N1hKdzVlQ1lZQWZqQW0yQS9BOFNXUnhp?=
 =?utf-8?B?OHBVLzZ4UExpVW5wZkNENEZhNktkRFhYVENqTldGR1ZsbnR1L1Y2c0ZrM0Jp?=
 =?utf-8?B?RzhzNEZGUUJGMnNJb0dOdENlUHB2cCtaanpJSnU3VnhvSElEOEZYOVI5eE0v?=
 =?utf-8?B?L3A3QXBPaCsvMHpTbDh5OHRTNFdLU2loSytRRXZueVYyNlZKKzZ0UGVSdDRX?=
 =?utf-8?B?eG1laU9sMjdnZUF2d2FLVDNveG10Ym5KbnpEZ1BtTm5wYmVtQVJaQmMveFFS?=
 =?utf-8?B?QU9WbzdzU0F1MG1Hb3NZbndvSXRPTHJTak40bjg2cGU0RVowRUI1OUZuQWdN?=
 =?utf-8?B?M2dpN2htcjdlNVM3Sk4zMXdiWm9hd3hCOUN2blNaYTVYdHNzTmlMSUNOdjMw?=
 =?utf-8?B?bHdHNURKcTVYejFWaytDc2Z0bS9pVDFxU2ZJMXFSWGNZdU1DU3JSdlVPSGdn?=
 =?utf-8?B?OFlNU21zcXZWUTFzdnlrcFc3ODdoTW5idFBnQ0ZRdmVnVnlubU85ckU2Rmwy?=
 =?utf-8?B?ZjhvWlM3T083VVRhSmpmNWJrUi9xd0VzVUFuendFUGQ1MjNDZm1NbVA3Mzdo?=
 =?utf-8?B?Yi9MYzdCOTgyTHVLWkU2TzdHZnR5ZTQwSmtzaDFUTE5yR2xXbFBSNmsxbDVH?=
 =?utf-8?B?YTJnVDJXb0NXKzRuTVBEOVBIT3o4K1RnMURkUmxYc0c2S1dONXNWaWlSeFg3?=
 =?utf-8?B?NFlodkkzdlY2cFVTUEp5dzVpdUxPNGtzaktWTkp5VkVOdFpEN2lCT1JOK0w1?=
 =?utf-8?B?YUFiVXNpUzcvdnZsRmorT0k4cWhCUVZvZGJRWlozMTMrVVprWjV0TkdKOU9Y?=
 =?utf-8?B?Nm9hTUo0azJyZkFuNzN4YTJ4LzZWdkxOMitwYWI5QjhLS1pZeDlTbHR1WnRu?=
 =?utf-8?B?SC94SjV3SGlDbUowMGlaYlVmaUVmbExCNWhhUThrc1JYNmsyQm9rWVF1V21T?=
 =?utf-8?B?akxQSFRqNExGOHA5ZWNhNGpaYmFxVHZrWktyMUZiZTRaODdYc0h5SGMxWjdZ?=
 =?utf-8?B?MndCcWs5bzdXTTdaWDlISXNkbHhGNlhaTjVuU3JBYk5ib1VnQUt4MVJ6Rlh1?=
 =?utf-8?B?YzByZlJORTVFeTcrOU8rby9GZFJlU2pPdFdqbjArdFlFaGpoVzNSWVI1OFBX?=
 =?utf-8?B?Y0lvS2NGYkoyT3ZSdjVycE4xNGJXSCtneGdDcnloL0dsL3A5Mi9lMVlNM3BQ?=
 =?utf-8?B?T2tiMFpSeWgzUEgrOXFMeFNiYjNObEFQQmpzSjQ5SkdYYTNFQllhb0lSbU11?=
 =?utf-8?B?a3VhV2tYaTBjODhTTFljUStpa3VnYzFxcC95NmhSMm1TZkVkdmI2aEhNckIy?=
 =?utf-8?B?K0s0ZzJUYTJuSlptSnRRQWhGaGt2Yko4MllMam9rV0NORmZlaHJ0TzUzTE1j?=
 =?utf-8?B?cFVsdkwrQWRiTFV2bjJiL1ZwMDRQN0lLVDNSOHRTZnV3WDNCOGtmVTFOMlNN?=
 =?utf-8?B?MWhvN2U5T25VdlQ2QjZ2dG44Qi9CSlNHVmxKQUpQVE8vblhSdnBGZjhBclRm?=
 =?utf-8?B?eGZMVmRJZ2RMbHNEaXdHSWxTMlRFTCs5VU5VY3pFWWlwdXJJUUg3cUFmTWNB?=
 =?utf-8?B?R2ZzNHU1SFJjSE05dkMwZmpNUUN3d0dHNS9obzBQQU1STTI0dkpObGMxV3BL?=
 =?utf-8?B?ckZmK0pxM1BrbUJpRFFtTzZtKzJCc25EMnJvRjNWTVNiaWUvOW5yK28xazZY?=
 =?utf-8?B?S05weVozM1M5UThjeXVMSDI3MFVsaUNzbk9BNDloYzRsRDlpK05TVXU0cEVP?=
 =?utf-8?B?ZTY1bjgyZlpPK3VLbTJOZ3VKeXBPcVE5YWUvT0pCalBQU0Y3Z0dXYm1TMTk1?=
 =?utf-8?Q?rEsHq+zwX72mEPeXRStE4AmDy87/De7y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mit2c1prWEtYSUFYRytjTW1VYVJnUXBFaXNRVTRBQjZPcEdmV25TYmxrNkFh?=
 =?utf-8?B?WFlhT0VkVmR2OEJoUlh6QzZUSDdmeWxxTytRbHdLWWxzSWRVNzlvbG9oK0hm?=
 =?utf-8?B?WkFhVjVrTWVBbFEzQ0Rpa1hxdER4a09XbndXSWpqTFJsZXVraXpqdkJZRTRN?=
 =?utf-8?B?eittdDRvNUlhYVk4N0RIWWtiOWNoVE9aZkV6Wi9FMGFPamZoeTVHanBNQTJy?=
 =?utf-8?B?Smc5M1NYVmU3UmZJVUFEMXRkcGNsbHRYem1Rb1QxNS8xdTFGbVczc3hJTUVk?=
 =?utf-8?B?OFFqTmhoNy9zRitBbnJRYTMyT01qbUpROWc2OUtpckErUk51Q2VsWkhtYjVu?=
 =?utf-8?B?cVVNYm4vWU5mWnJ1bE9zWUdWR1laMVJBazdCTWcwL1luVkZiV1c5K3d6SzJv?=
 =?utf-8?B?NHFidlBZWkV2QXhybkdvWFpZR1JqVi9ub1JSUGJ4dHVjT0lPY3g3OUhvTXhO?=
 =?utf-8?B?UlpQMHl3R2p6ZHNkeWI4UVFaWHN0UWtlOGVCUjNQQWxjMW1MY2l5aGl1M3dp?=
 =?utf-8?B?WWU4NGNsWVVFckhVejF0WU9RaVJnbkhocDJQOTdqSks3V3VqakZjb0dHcnpm?=
 =?utf-8?B?MGZYRjQ5Y0xWT0FrZVZhaFBpLzVlOEE3cHYwajZFSnRvZCtSOEdjNnNCV0Vj?=
 =?utf-8?B?eXJNZ3JVTERwSmZSK09kQTBKNWR5U3pWZnNZbjdxSVh5anI3NnYxdTRGdEMz?=
 =?utf-8?B?cmlLa1hPL3NVdkZNSmE0UnVvUS9JSlpyT0RlR1crZ3Ryb3QyeE13djhtNllv?=
 =?utf-8?B?YVpIY0xPV2txN3ZrdjJKV0ptQkFBY2F4eWlRWVNCYzVka29MTlZycGpwSml0?=
 =?utf-8?B?c0dwV242blRVSjJxdXhnMzcxdDdWTzBJUW9NOVpONnlXSnFvWlZ4QTFrdytk?=
 =?utf-8?B?aEFtSXdabGc5WUJ0NlA1Y0pwNlRpR1ZBa2ZCRkx5K0swRVU2Q0pyL0pSb1cz?=
 =?utf-8?B?aWk3VUI5R2E4V1p0M3dsaUJ4YVFFbXBIOGRMRVhLRERra1BsRnRMQXhRbHFv?=
 =?utf-8?B?VGJCQk1veFFqTUpWb1FxSVZPc2tVNWdFaDRHVkhvRno2M0JsaVBhSlJKUCs3?=
 =?utf-8?B?SGx2NC82djFZNllzdFVvWTNxU0lRckJjN005WTNIWGFTY1d6L0ZFbDBtNU5l?=
 =?utf-8?B?aHplM1BWQWZkejBlbDRmM0d4U3g1K0kzeTUwdldJRXdzeVQyQ2V0dlZlbndP?=
 =?utf-8?B?dGJkeEM0azd5SkNxb2dHK012cmE1RkE3OFVKaDd2dmJSUlZza2FJUThHd3BM?=
 =?utf-8?B?bjNOc0xYT3VEUlQyVUx4ZzRtN3lGNnhyUDE2alNPRVNzSUNhaDBFQ1dQdDRn?=
 =?utf-8?B?bUE4UDFlcXNmSVZWMXZUTnlzK2I4VjRVaU12a001M3hOZ3VVWGtIYlZhVlJR?=
 =?utf-8?B?N0Z3cE9FUTcvblBoNUVCM2RsQmo3K05NcUlONnNJb2U1eXNvenZnWXE1eFYx?=
 =?utf-8?B?VlN1RlgrVWlrUHZHMFJtR2g0T1ZGZFdGUWdNQzdZclJ3OU5PZGJMb04xcmNl?=
 =?utf-8?B?R0lWaXNsRStIb0twTVZmYzE3dG5tNE9VQllFaUR3eDhZSkNNdzA4YVFjd2xS?=
 =?utf-8?B?cTE2UEpZbkNtN1pNbFVXeTU4SUVYSXdadklHd1NCMTNZRzNmNkNoZmpsQTln?=
 =?utf-8?B?WkQ3MEhpSlBLak13WFlna1hJcHVzckQ0L2Q4aE9jcTRwbFV1cnl5V0l4R1NJ?=
 =?utf-8?B?c3E3bzZISFlNanhZZGUxSEtWd2ZUM2E2c25KY1NyRlB4S1A4SmlLSUtLRytm?=
 =?utf-8?B?SHM5VkJoNFBWamVhaml3ZzBzMHFod254eFBBZ3BiWnIrVm1MMlNUeGdxNUVX?=
 =?utf-8?B?WjdXdXZ6b3JjZ0tPNzBOVDNBZ1R4eXlZckg5dlgreUtmeWFZKzhxUk5qeTJT?=
 =?utf-8?B?c2EwTk9GcVFTSS9lb0pBS2YrSzNHeHNhT2V5eDlzY1RjOUQ5cFdGMG1kYnBX?=
 =?utf-8?B?N0JjRGdaYW5TbDFXQ0JxUTJ1U3dyYkZiekhpdHpaZ0RTa0V5SFUwZXRRTlV0?=
 =?utf-8?B?T3VwNXV3VXdhNjhmTmZ6OW8vc2RMTTQyVjRmcFU4aElndXZOU3pKR1F6dG1l?=
 =?utf-8?B?R1FFZ0ZRUjR6eTQycjlaN3ZPbHZkNzl2Mk9RbGpTdWMrR1hoUjNrVlE5d3Vn?=
 =?utf-8?B?V0pmd3dleEFiNjlEemRvTnZHK0JrMmh0bTIzbTZlOGlvOVNXcGV6UEc5Nkw5?=
 =?utf-8?B?a2RweWxVK3g5YkxsVTBDSlpHWUh5ek9QSzJNQ1BRMVA2UkpiSlp2eTRJY1NR?=
 =?utf-8?B?QjRHQXorVTZYWElmT2wvS0xJakhac0QySlY5SFVTVFF0YUtybUx2a1ErSURo?=
 =?utf-8?B?RmlpYVI5NTBnOEFjQzFyWWxya0dlWFBIQWFXeTVsTVFYWGxwM0I4eW5rVFp0?=
 =?utf-8?Q?0Eh/PlSagZNa55Ak=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffcae49-72a8-48ce-3d5f-08de52780c04
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:47:48.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3RIJt9hxZVJAV8BZj+5mQ6nvn91P5AX+AsKXiev56iOMeo5CJ5ufhAjk4Fw6U1WPGKrbvryX0JkdYQY4MTpJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8223

Hi,

On 12/01/2026 15:21, Nuno Sá wrote:
> On Sun, 2026-01-11 at 11:41 +0000, Jonathan Cameron wrote:
>> On Mon, 05 Jan 2026 14:57:02 +0000
>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>
>>> On Mon, 2026-01-05 at 13:06 +0200, Tomas Melin wrote:
>>>> Hi,
>>>>
>>>> On 21/12/2025 22:00, Jonathan Cameron wrote:  
>>>>> On Tue, 16 Dec 2025 11:40:06 +0000
>>>>> Tomas Melin <tomas.melin@vaisala.com> wrote:
>>>>>   
>>>>>> Not all users can or want to use the device with an iio-backend.
>>>>>> For these users, let the driver work in standalone mode, not coupled
>>>>>> to the backend or the services it provides.
>>>>>>
>>>>>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>  
>>>>> Hi Tomas,
>>>>>   
>>>>>>  static int ad9467_probe(struct spi_device *spi)
>>>>>> @@ -1352,21 +1361,25 @@ static int ad9467_probe(struct spi_device *spi)
>>>>>>  	indio_dev->channels = st->info->channels;
>>>>>>  	indio_dev->num_channels = st->info->num_channels;
>>>>>>  
>>>>>> +	/* Using a backend is optional */  
>>>>>
>>>>> I'll largely defer to Nuno on the backend aspects but I would like a
>>>>> lot more than a statement that it is optional in this comment.
>>>>> At least something about where the data goes and what a real system
>>>>> that didn't provide a backend would look like etc.  
>>>>
>>>> Having the backend as optional is about flexibility to incorporate these
>>>> devices as fits best with the system. The current backend approach is
>>>> pretty much dictated with how the ADI default backend is implemented.
>>>> These devices are fully configurable via SPI interface so the backend
>>>> doesn't necessarily need to be anything fancy or even configurable.
>>>>
>>>> So there is atleast two use cases that promote the optional iio-backend
>>>> approach
>>>>  - simple backend that is not configurable, no need for a dedicated
>>>> driver. The backend (FPGA) sits and waits for data and handles it when
>>>> it arrives  
>>>
>>> Agree on the above. Ideally we could have some dummy backend for the above but
>>> it is not really easy/maintainable to have it.
>>
>> When we say the backend needs no driver, where does the data end up?
>> Is the idea that it goes into some processing pipeline and sent to
>> some external path that we have no visibility of? i.e. We configure the
>> data capture in Linux but never see the data?
> 
> Yes, that's also my assumption about Tomas's usecase.

The data becomes available to user space but there is currently no
immediate need or natural place to create a separate instance to
function as a backend device.

But that being said, I'm leaning towards thinking that perhaps a
minimalistic backend should always be registered after all. That would
keep the idea of the backend always existing intact.
But since the backend can be missing a lot of the features defined for
the current ADI backend, capability handling would need to be added to
the backend framework to make it functional.

Looking into how this could be achieved with reasonable impact, I have
tried to identify capabilities that we could add for starters, and then
have the frontend behave differently depending on what features are present.

Something like this (added to backend_info),
.caps = IIO_BACKEND_CAP_TEST_PATTERNS |  --> backend patterns are avail.
	IIO_BACKEND_CAP_BUFFERING |  --> backend has buffering cap.
	IIO_BACKEND_CAP_CALIBRATION, --> backend supports calibration

If you think this seems reasonable, I can implement something like this
and post a new version for comments.

Thanks,
Tomas



> 
> - Nuno Sá


