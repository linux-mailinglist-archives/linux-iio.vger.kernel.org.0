Return-Path: <linux-iio+bounces-18777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79785A9F18C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 14:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8524176898
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 12:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433AE264FB0;
	Mon, 28 Apr 2025 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VjEwuCi6"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3625D199EAD;
	Mon, 28 Apr 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845030; cv=fail; b=gwP/pwXEfVUzpUdQ6rmwbhlXP+YCxT0paFjZ8iKZXf7mJuFLQf/FIGWfEEcXgZoProL9mvFk3Q622gsNCqsf6q9QMMDYAT0h+rLGr/6jldjMHUFK9cdFfN5H2R2kywbTcEjEgYBvAT9eaKqiKoyeVYn4L9LRWRfa/dqCnugv3Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845030; c=relaxed/simple;
	bh=0wHyHTqusehnJjhgYYXoWPYnUPw//B6GepxtDaOkom4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQXk87XacUkxJvbSopXYVvI2Z1q97u/InlAcQdWHdHwGJsK1KswDPuq/TxxMU8U+Y4f+SgUGmm5euZRkTjMGCN2cbo7H3kgwu6MelWnQgyiuu1gxEDuUh4iNlcL2+DtsiJTE4YeBsMiEmeLq1rNlTVNzHDWHPU5wvvDhRNurxz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VjEwuCi6; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUb8d+LaXcGHqisXy+sEVSXq7ogGtVVm4e3ZJDiLHOJYlUklm8bXfJIFU6AxPenhcd4YwJ9/Z0/ixlazacCLlDpNQYm+5UlE3IEekLzAyWTO4YBENkBXLPPyHMFmjPc6+2jH7VYl7WdO+tsT1NN1mLDUfMMqMH8DwUWTXlpsqQSqVu05NeCcwD/LF6b7oY2JHLOh9de2TIMe7C6nlfIM2tbMhltWLsroD5q3q27KMXOOercDhsou0HtxcoCVYTrwLUxx5jAvvOnEkHweaz2IsRBTfhoBlmseACwa6gFTr1lMI+1ygOWCv8aIkOY2eFOJOuZA5KYN7c5HO46ShhTrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wHyHTqusehnJjhgYYXoWPYnUPw//B6GepxtDaOkom4=;
 b=DZjjvw0p66RGtTX91Lngg4W8t8UURoamDHzLD4Ix+2SK27VsZNSxOwhvJzVGC5DW+QjZuabJILHdb+oBJk+b6IoodBpxrgCTxNTZtlETcPL9GhyQJ1wgRqNAsNqvmlKrLKX86+yHx7sGYy7k1+tWIVBNvRQJuGlsfbVxmSXggbknq6sQ7BTCHyPTXovMzAth6GMz6oYFEe0W9lsJCKyoYCNt5IRQIU/ZHe32dq/hiNF8yyC00HBcbNF8VgvAxBBh/1dDZJrgyT7gRw2c9hpRJ0BVW9k4olYRElLtA8iEGnAvchr+a4cktLnqXOyLGL7osHV030tZzM2cFFPAoYmyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wHyHTqusehnJjhgYYXoWPYnUPw//B6GepxtDaOkom4=;
 b=VjEwuCi61vbdpdRU5qKdwXx+/MXQozCPphaZ5artuNbzkLaqGCipkn2px05vbr9GNjf950X2vvSn6m8Hvj7KAlOs90baLtcoBQdd6QNk5QLsWzETljr6SA/pDnCNKxnrZw4BttNf0xF3JwZrHHvYoamTtLolRWJ+y+ZATBXDingGsViJAyrfF/huT5PXZqwJh4wxN4lIoM4KZBmqkIzgUW7l+e3ddu7fgxUdZPA5HOkc+X5vAG8PeTVH2iLMayxs2KzvxfpNzz3bzib0sR50CDMuzG+s/51XGqj0vrcZETtyS0VCvQZ+1Mk1NYXynW4cF3q42V0No/PU+uv+vD/77A==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 12:57:05 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 12:57:05 +0000
From: <Victor.Duicu@microchip.com>
To: <jic23@kernel.org>
CC: <Marius.Cristea@microchip.com>, <andy@kernel.org>,
	<dlechner@baylibre.com>, <linux-iio@vger.kernel.org>, <nuno.sa@analog.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] iio: temperature: add support for MCP998X
Thread-Topic: [PATCH v1 2/2] iio: temperature: add support for MCP998X
Thread-Index: AQHbrgobzeBGETVwGUalvAKTnXO4a7OpvYoAgA9gdIA=
Date: Mon, 28 Apr 2025 12:57:05 +0000
Message-ID: <303fbf2f6c64241966009be59f68c1d2f8cdc786.camel@microchip.com>
References: <20250415132623.14913-1-victor.duicu@microchip.com>
					<20250415132623.14913-3-victor.duicu@microchip.com>
				 <20250418190757.2b007737@jic23-huawei>
In-Reply-To: <20250418190757.2b007737@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|DM4PR11MB5326:EE_
x-ms-office365-filtering-correlation-id: 01baad10-9bc7-4f84-a576-08dd86542d61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFZRdncySEtCdmttbjE1R0ZXbmhVOFBsVXVYTytTNmlucEtKT1FiUTI5UGJU?=
 =?utf-8?B?YXhDMlVlN2tvMi9GajJKamV1SXovZGtUbmY5RFZIUUh3UnpsdDNGd3luOWdB?=
 =?utf-8?B?Qm0xWFlVb2xLNTdtRWZxZWRQS3V5RDY0YVdXV1VhbzlxR0pkb1NlSmNwcFU5?=
 =?utf-8?B?TGdicjlrR25nWHUvMWlKdHc0ajdoWU0wM2R1eVlkaTFkdnBFMXRqNkZKUzhw?=
 =?utf-8?B?MTFwSXd3Mnd5QWhPaXBNQk10RVVIMjlzcGF2L2pCaU5MSGNMVE5kcHRMYmdj?=
 =?utf-8?B?eVU5bjdhTFlpKy92dWZHbjQ2MG1JSThZeklibW03dEdIdFAxTnluVmhac3Zo?=
 =?utf-8?B?SDdhdkpPSTdqc3NmVUU3S3FTcmRPVlpMODN6a3JJcjRMeVcxdDNmMDVUTE1m?=
 =?utf-8?B?ZTZ2ZjQ4R3hpcFVRN3EwMU5uUlljNDhzb3pIaTFCb2J1VjRzeU5CbWNMczVR?=
 =?utf-8?B?QXIwcGhaQS9PZ0U2UzlUK09Ta1NuMmN5RTFvQzNsSVdqVDZBZ2FUMUxOd2VF?=
 =?utf-8?B?bDM1TXkrNy9tVzBiR0xuN2piTkIza0tpVHcyZXd4bGc5NXVqN29WaWZRYjZQ?=
 =?utf-8?B?SmE2WGJMTDFuZXhsNHNDa2tnK0tMWW85c29TWmRmTkFieFR4ZmcvZmYzbzRv?=
 =?utf-8?B?ZWU0dE1CcjExSmN5ekxqVzRoODV5RmNIaDA5bWJBSG5wM3RkWVpzWlJmV3Fm?=
 =?utf-8?B?TDhXTGVOdDFIVDQreXZ1cXdWQVBBZzZtZDhEVUlYSkJad1JLUERDdndzRUN3?=
 =?utf-8?B?VnlIY0xQTjZ1dlhMb2RGWVNyckF6M3U1WHpzL29KTCs5ZWtSOFEydi9aYUFz?=
 =?utf-8?B?V3ZwUm9vR25Bd1o4QkRCOHdGdmg5ZzBqYTRhc1dUNGl2SitsTFZyRCtxY2NM?=
 =?utf-8?B?MG0rQjBPWXFRMkZJTFVBRXZRNnlETXJUbjRSQWxEWmtnNFdnMFBrNE05dkh1?=
 =?utf-8?B?b0pqSHhtNFNmYlEyNXQ1cDdKcjRXeDRIMWJiRWV4akJjbTV0THkrZ2FtYTdF?=
 =?utf-8?B?VXRhWm9Fa1I4UjR4Vy9FdmdzMTBnN0Rqai9RNERvMFVPQ0o2UEdWMzZpbnJ3?=
 =?utf-8?B?blZCL0ozRGVzUlk5dlRMSWNJZ3plK2NrMFBuSkNFdk9qcUhFeFVYYk1TSmFa?=
 =?utf-8?B?elgwbWhEV01FWHJhRkFkZmNXRjBaa3J3aFdhMUxPNGNscm16OVB2V0Vab1NP?=
 =?utf-8?B?eGtZbzlsd1puNHAzS0FYVkxrZE5qUFdLUktSWldUMFdkNnNZZTNPTGVrYkpk?=
 =?utf-8?B?RHl0VXRmNnE4ZjlBbHgwWjAzTXZndnhOdWs4UXgyQVJDamorNnBncmJSTVdN?=
 =?utf-8?B?UjFZWTFUdVcvTFJmL3N0SWdhbmpvNERsV1VRaTBab2hlSWs3MDJKY3lUZkJZ?=
 =?utf-8?B?Yk9wbEZyYnJRWU1kZzBEZTUrNC9WMlhTclFnMlgwS0JxT0FlRTRNbDk1cXpW?=
 =?utf-8?B?cmZVdHhhTGsvamNnemtWbXh6bXRuMVI1NnU5TFBZVDZnRFpDYzJQdWJYQzJp?=
 =?utf-8?B?N0tOODgrNStad3hKYVFUT1JBYklyYkZ1NkIyeHMrbjl6YStIdisxRzhnVTUw?=
 =?utf-8?B?RnU2WEFCaUhZeFJ3dlZrZmdoUjBZNkdiL0NRdFhxdlBUQjhuUlRmOTdXOW5L?=
 =?utf-8?B?eWdISEYxVGlwWHJkWFEzY3NQLzRGcG9qU2p2YzFYSWhEeUZMSnBmYXJCRkZv?=
 =?utf-8?B?S09sTFZQS2w2dFoxWXIzV3QxTUlwelpnSUZkTkFYbHdzWSszT0lKMWNJa2VV?=
 =?utf-8?B?ZldCbzRFeDdPblcvTnduQVNpU3Z4ZlBQTncvZEM4MjQ0cEdjLzBZT203d1p2?=
 =?utf-8?B?RUhCTDJuajhhaWxRcFVCVkJ3ZThkNTNTZ2h3Yk0zRkx4SGwrdVRDZlhNMFdJ?=
 =?utf-8?B?UkJucWUrcDRoSDhzZkJKUWp6eDBNWjhiRDIxU0tsZXhzYzM1M2lYYWxMcVl0?=
 =?utf-8?B?bm5naUg0bWhOdnI1WWNFV2doK3ZEUjc4bmsyeW5SOThuUEFzV0IxUml1UndV?=
 =?utf-8?B?N2dPMndzYVJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzlXVGtlTERkK0NZSHAvajNLVU9YNjhPRGJoYlZid3R6S0xsM1IrUmhUOThH?=
 =?utf-8?B?a1N6VmtoV0lUSXRudCtKR2xlUXRPOWxnSU9IZ0pVK2x3bG9ucXhZdUtJSFdo?=
 =?utf-8?B?WC9GbU5rMEVKemVDMFk0UHJKSzNqL25Wak9nb0twb21VSVlPcnFkWWNUdnJY?=
 =?utf-8?B?cktpMFlQeEIzUUtsazlTMjlvZThNSUpGbWloWGU5Y1VHcEUxdlJ2eG9CVzRr?=
 =?utf-8?B?N1BpZVoxMUZwRXREd29VYnNsTGtaaDNMMzIxSDI5eWhnQ2lZQnhkeHZXQVJi?=
 =?utf-8?B?cVBoQzR1aHBVY1RkMUVQdHZVdVNMVVl4WitXc1FRUGJMTUxsRXhxVFYxT2ZG?=
 =?utf-8?B?ZEt3N201UUZKdk96WW0xNGJUUTQxVjNmOUlCWURCNTZRMU0zU1plckdpZEN4?=
 =?utf-8?B?aWp1ZEhFMi84Kzl2Tk5IMndQVlBiRERLa3JiUnZCVk5leXFQU1QxWGVUL3dE?=
 =?utf-8?B?SXFsZTV5U0p3elVYWGY4dm1PV0h5SGJjS0tzbE9oOXdvbnZHb1I4QzFNZ1lV?=
 =?utf-8?B?MWtJcXc5SEVER0hqQVZ2V0JMZlM5Qk12bzBkdWtPNHFSSmxlcE9ZRVpTbnMy?=
 =?utf-8?B?RkRqVStINWg1MmllT3VFaFNyYXlPQjlndGk2V0tTY3N4UVFQRituRjBPK25C?=
 =?utf-8?B?cGxKTjZqMXlNcjRETGxzSnBlUlU3a3ByYTQ3YSt1UnNmTW5ERzZlWkRSQmZT?=
 =?utf-8?B?amVGMTJmUVdpcGhGTVpUbWdjUVMxOVZ5b1dKallITlVMRXdGSnA4alYvRUJI?=
 =?utf-8?B?alFMZzE3a3l6czhPbmhoR3pWTGV2M3Q3OXZlR3p1ZS8yU1RMeER3VEd4enF6?=
 =?utf-8?B?SzFzMW10OVRrN2xpbkE4cUJOOVpnVGllcWd2QmZ2aHExaUpQcUZJWUwyVXdM?=
 =?utf-8?B?cFZ3eGlzeVFFYU1LTGdqdTk1QlcxZ3V4eGpOS0FZaGRPT0NxQlJ1cXJkaHcz?=
 =?utf-8?B?STROcE9qWXRTYXM3Y3RWV2l2bnBtM2x5VFF4OWp4VUhKRHFpRjBMN1RBSStm?=
 =?utf-8?B?MVNNMWZPSm8xUjhxbVM5TEtkck83QVlkRTVTcWRDcEFtL3kyU1dVWXhtbFBa?=
 =?utf-8?B?dGllZ0hISVpGaGYvMnF5RlQrdllObm1aUkVPTFJOMlRoVXNnVDMxRU9pQjJm?=
 =?utf-8?B?L2p1b2JrdlhGbElseXJoL1FNbm1TWi9saFVCL2I4RUFjaUlQUWNEL1Z4VmRP?=
 =?utf-8?B?UVhocXpWc25FekNXTUdZVE4xajkxVDlYbTB0VE4vWTlxdm5DRmNxL1hqQ3JY?=
 =?utf-8?B?TkgzeFpocSs1SnBsZVMvMW44aTBSN3pETnFLT3RhbmdjRWJuc2RlNWs5cURK?=
 =?utf-8?B?ZFdJdVBHYzlla3MwN29YcXlIVU5CTFVEaW5QeWs0ZWlmU3dvK1RHUlFoMUx1?=
 =?utf-8?B?Ti9WeXhtL0VPbHNTRHRaalY5T2g4ck9JREozN0RaUjY2U083VVJzUEMvRjVY?=
 =?utf-8?B?dDlxU3dSdUxkWXZ1U0IrTHI5U3hXOGVjR1FLdlRwZHg0a2ZqZ1hIMzZSYUQ5?=
 =?utf-8?B?cU9ySVVPYXg5aEw0R3Zibi9qNnZ5Z3I3NnBQaHpLQnFYZnVvUjljR2VyKzJl?=
 =?utf-8?B?L0xoc0JDYmx1Mmh1NERLVWNmQzUzZ0VNbFc2YzZRbkoxcmNpS1hacUduc1lD?=
 =?utf-8?B?QzhGSm40dkFmN0VxMEZhejBnUVpVSlprWHFNdUVQSVJLaFpFbEZkVkpURkxG?=
 =?utf-8?B?cVVETlk0c29xekswUUVYN1FXQ3BldktFd3JPak9LK0ozV2F3TDQ3M0hGV1Ru?=
 =?utf-8?B?VmlsZDgyNFJMT1NXTlVqUUNsc3VDa1pjVmtIZUFrWXRKdkQwSEVFV0JGNXdN?=
 =?utf-8?B?RFNtWVJJcDNKeFhWOTZKREZYSTNyTjJEUzR2bFpZZklQMDh4OTRLR28yZUNs?=
 =?utf-8?B?MWxwbWw5L0lVKzdiUDYzUTdjNFRIVjhmaldzWXduOWpodE9zTGRra2VyTkZU?=
 =?utf-8?B?Mm9nQjk3UTJ4cTZmUDZHeUk3MWpsVEV2WHp6d3paQUM1aXpXQnZHMWs4VW13?=
 =?utf-8?B?dStldDBsaWQvSk9qbENIV2dOUHFzTXJEYndWam9uTEtXU2xoMS9qMXU0YnU2?=
 =?utf-8?B?T2c5SEFsb01Kakd2WFVkM2RJbFJTY1E0QXJwUGJkMjJFQ3d3QmlqMnd5UFpB?=
 =?utf-8?B?OHRUbWVLZGN3N3dyS3VzYjc4cUZ1Ym82VUltRm1UUDZsTkhscVBpdnVid0dN?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB760143AE18934CA97C9F1BFC9357AE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01baad10-9bc7-4f84-a576-08dd86542d61
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 12:57:05.2912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otnVRTsJ0e9bZKeXmfdn0idY2dP79EDIRY+yOjccDiIzEVernB9HB98FC/AqfmG+doByaAJlnW3xf4tWkaAPulckRTJgTSYXv5M3lpFreIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5326

T24gRnJpLCAyMDI1LTA0LTE4IGF0IDE5OjA3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwg
MTUgQXByIDIwMjUgMTY6MjY6MjMgKzAzMDANCj4gPHZpY3Rvci5kdWljdUBtaWNyb2NoaXAuY29t
PiB3cm90ZToNCj4gDQo+ID4gRnJvbTogVmljdG9yIER1aWN1IDx2aWN0b3IuZHVpY3VAbWljcm9j
aGlwLmNvbT4NCj4gPiANCj4gPiBUaGlzIGlzIHRoZSBkcml2ZXIgZm9yIE1pY3JvY2hpcCBNQ1A5
OThYLzMzIGFuZCBNQ1A5OThYRC8zM0QNCj4gPiBNdWx0aWNoYW5uZWwgQXV0b21vdGl2ZSBNb25p
dG9yIEZhbWlseS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaWN0b3IgRHVpY3UgPHZpY3Rv
ci5kdWljdUBtaWNyb2NoaXAuY29tPg0KPiANCg0KSGkgSm9uYXRoYW4sDQoNCj4gSGkgVmljdG9y
LA0KPiANCj4gVmFyaW91cyBjb21tZW50cyBpbmxpbmUsDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBK
b25hdGhhbg0KPiANCj4gPiAtLS0NCj4gPiDCoC4uLi90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8tdGVt
cGVyYXR1cmUtbWNwOTk4MiB8wqAgMTcgKw0KPiA+IMKgTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoCA3ICsNCj4gPiDCoGRyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL0tjb25maWfCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMCArDQo+ID4gwqBkcml2ZXJzL2lpby90ZW1wZXJhdHVy
ZS9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPiA+IMKgZHJp
dmVycy9paW8vdGVtcGVyYXR1cmUvbWNwOTk4Mi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
Nzk0DQo+ID4gKysrKysrKysrKysrKysrKysrDQo+ID4gwqA1IGZpbGVzIGNoYW5nZWQsIDgyOSBp
bnNlcnRpb25zKCspDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9BQkkv
dGVzdGluZy9zeXNmcy1idXMtaWlvLQ0KPiA+IHRlbXBlcmF0dXJlLW1jcDk5ODINCj4gPiDCoGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9tY3A5OTgyLmMNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlv
LXRlbXBlcmF0dXJlLQ0KPiA+IG1jcDk5ODIgYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5
c2ZzLWJ1cy1paW8tdGVtcGVyYXR1cmUtDQo+ID4gbWNwOTk4Mg0KPiA+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5kZTMzNjBmYjA1YmUNCj4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlv
LXRlbXBlcmF0dXJlLW1jcDk5ODINCj4gPiBAQCAtMCwwICsxLDE3IEBADQo+ID4gK1doYXQ6wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+ID4gL3N5cy9idXMvaWlvL2RldmljZXMvaWlv
OmRldmljZVgvcnVubmluZ19hdmVyYWdlX3dpbmRvdw0KPiANCj4gQXMgbGF0ZXIgaW4gcmV2aWV3
LCBJIHRoaW5rIHdlIGNhbiBjb250cm9sIHRoaXMgdmlhIHRoZSBsb3cgcGFzcw0KPiBmaWx0ZXIg
M2RCIHBvaW50DQo+IGFuZCB1c2Ugc3RhbmRhcmQgQUJJLg0KPiANCj4gDQo+ID4gDQouLi4NCg0K
PiBIbW0uwqAgQSBydW5uaW5nIGF2ZXJhZ2UgaXMgYSBsb3cgcGFzcyBmaWx0ZXIuwqAgQ2FuIHdl
IGNvbnRyb2wgdGhpcw0KPiBpbnN0ZWFkIHZpYQ0KPiBzdGFuZGFyZCBBQkkgYW5kIHRoZSAzZEIg
cG9pbnQ/wqAgVGFrZSBhIGxvb2sgYXQgdGhlIGZpbHRlciBBQkkgaW4NCj4gRG9jdW1lbnRhdGlv
bi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlvDQo+IA0KPiBDdXN0b20gQUJJIGlzIHJhcmVseSB1
c2VkIGluIHJlYWwgY2FzZXMgYmVjYXVzZSB0aGUgdG9vbHMgdGVuZCBub3QgdG8NCj4ga25vdyBh
Ym91dCBpdA0KPiBzbyB3ZSBhdm9pZCBpdCBpZiB3ZSBwb3NzaWJseSBjYW4uDQo+IA0KPiA+ICsN
Cj4gPiANCg0KDQpUaGUgbW92aW5nIGF2ZXJhZ2UgZmlsdGVyIGlzIHVzZWQgdG8gc21vb3RoIHRo
ZSB0ZW1wZXJhdHVyZSBzcGlrZXMuDQpUaGUgdXNlciBzaG91bGQgYmUgYWJsZSB0byBzZXQgdGhl
IHNpemUgb2YgdGhlIHdpbmRvdyB0bw0KYSBmZXcgdmFsdWVzOiAxKGRpc2FibGUgdGhlIGZpbHRl
ciksIDQgYW5kIDguDQpUaGUgdXNlciBkb2VzIG5vdCBoYXZlIGFjY2VzcyB0byB0aGUgZnJlcXVl
bmN5IHByb3BlcnRpZXMuDQoNCkJlc3QgUmVnYXJkcywNClZpY3Rvcg0KPiANCg0K

