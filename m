Return-Path: <linux-iio+bounces-26618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81443C9B05D
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 11:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AF944E3C49
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764F30BB94;
	Tue,  2 Dec 2025 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="x1bEamW1"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023107.outbound.protection.outlook.com [52.101.83.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7063027702E;
	Tue,  2 Dec 2025 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764669823; cv=fail; b=YENY41mmDW5z1+7nVpqxHGl5DVHRII7vAvcIyVCYDS3VFwBqbPcNztVtqajij3YZbXE6dcgOH5ZmasVGk6C5bUdZBwjGEEm7yVcIrnvaX4A99GSTX7Gr7LfCwkDUbbQpw4dLg7QrxglqY26b4NCW6jM8fNWRZGb1psEL07CXrYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764669823; c=relaxed/simple;
	bh=enWgY99fjuMlDmHwNdr7y539QON+1JH0+3VAsmM+3nc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RVyU7QOaRUQ/kIzaL+Z+y0eeHywbuWAkcYkYhD6OO+hkGXKtJP/BsXjRPPWXuBqn5GCwRVaL32N6y0pQjODMD3cML15cO2qrztuikOjBUiJFynodP1MpY1Egtr6ejyDIRl1BUnRaVfq58ArplU+WHqbIQKLjorlEo05/cV9WtaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=x1bEamW1; arc=fail smtp.client-ip=52.101.83.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEJIzjW/uc8R4AxA78TtMhpEDuDVALeY4l6wirnTYE914EHMC7Svqz9TA35yAS2O/a+wBjDUmeX0BtjXjG/oPTT2qUJiR5vh4tpuhaFSXHpcboNSFwwg36TLye8XkCsncwSwbFNVYgjVSrg6diFErnA5Atl910wfVB5y5bA5RZ2tZTJtbih88s68Wx72QYVLWVWvtM2pz0Gv1iBLwDHh8icEgmNw9O8RfiZK0TxW+HPDNZBt5HABjUBF1cFgyjYE4X7bIvv3kvDgwXmGWtb3pFBmAu7smixtoizvSyT19Yw/5jf8BOyaNaykIDRTOHXcNwX9XQaGBzY5M+7OnG7CXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaeQQ6ehspRvBOOchx3nRpcwUs7Ikfuowg578hzWO6g=;
 b=OyI7z2vg+ashssrNNaaQh3tkA+y6X4f+mPY5pGtNddlJGCaVXVRWm1/2xLLXb86pkDIQfggpWQEunnpjoNO9QjJPQXlLLOPqJ8znp0lg4hV3VRfmXgPW4fXYndn2SwY+e+W//jahePEtt4YOUjArmA8G8L74k0sgWUhTZs3W1K4CxDD5e1YbxludPC2ymzxx1yzVCXtefYXiMtekFdr2RLvNnVk6tJIqhWY8TA+wvbFdPXphbjLFwLzN/yi3YZmXtQpPSH5VTUouw4sMGwWC3Fut+TfQaibnUulYkkUDqaBNI8LiJdtFT9L76zX9xKyMmiJ98fR/Ee0ZiPTauZz8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaeQQ6ehspRvBOOchx3nRpcwUs7Ikfuowg578hzWO6g=;
 b=x1bEamW1aUeCmEqbtkvQirNf4K8kvGbveUf6rB+CgVHmmuxZaxk7B/4J+MGkKmPH6FVNnQ6gAgBY/F6Lc9m4JmXefuO5voWFk+UJ0NAv9xNcqw0Za7QLT/N+865Wrxwme93oYTmKurwM1SBQtwXoe6TfRc9kiWbLO7M+DIFh4R7PRewLlm2Xl1s0j8srorXlgU4Zat8I3c3Tia5xsz/9F4bW6swPlEhOm5T9W3AVyX9XOpxTe5cmtX+X/Zq1ALpHuF9scot6FHrEJxZ3TXXU30Gf84a8w0JtulWSgtajPBD8HjL4pi9e69m3aDYt+5E3cqWTwWJDavNAVpMnDIBM/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VI1PR06MB8688.eurprd06.prod.outlook.com (2603:10a6:800:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 10:03:31 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 10:03:31 +0000
Message-ID: <44a38485-ce29-45c8-8892-5000abb8d44e@vaisala.com>
Date: Tue, 2 Dec 2025 12:03:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad9467: support write/read offset
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251201-ad9434-fixes-v1-0-54a9ca2ac514@vaisala.com>
 <20251201-ad9434-fixes-v1-2-54a9ca2ac514@vaisala.com>
 <CAHp75VdaYR5S7MmVEMBH1e6g-0bQim_d7m48=X2ybpf3hBAfTA@mail.gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <CAHp75VdaYR5S7MmVEMBH1e6g-0bQim_d7m48=X2ybpf3hBAfTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF0001A32E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::695) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VI1PR06MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5ecc7a-b5b6-434b-f304-08de318a0c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW1VT3YrYVIxQmNRZmdqVGF2RE5keE5CQVQ4ZDZ1S1R2ZzJ5MmRJL3FCTmNF?=
 =?utf-8?B?UWlJdGdoNzBKb3lDdS9PU3VsK2NwUndOdXpmaUUrUlJiRkNZSGJjOTlZODRO?=
 =?utf-8?B?b3BkaitsU01PTmlZbStIZnp1dXd2anlQR1d6RlZDY1VYOUpha25paVBDdVpQ?=
 =?utf-8?B?b2ZRNk9oQ1pldHdiYWhKQmNUNXlMbTdielRDLzM5TDFzdDV5QVErNGcyb3Fs?=
 =?utf-8?B?K1k5c21OZ1lHK0JvOS9UZ29zYjBsNHJHVDUvZUoyOGRRR2JrZ3FNY2pzajAy?=
 =?utf-8?B?QzNkNUpncnJ3SlBBTHBHdFNnSy8wR0R6dzR2M1R2TG9Rb0NtdTRQQWxId0lo?=
 =?utf-8?B?VDIvMGhaT3lRTHpFQU1Ha3YvWjZSbW01NG5jVEZOblhqQ1BEK2ltZFNuMlAz?=
 =?utf-8?B?dDBTK2N5MzFtODFOQVR4Z1p0V0ttSXpNd05UTlpvb3A3aEZrOTZKTXVsZjBG?=
 =?utf-8?B?Rk10dVB3ZVpaMDl2VzNIaTRDMmFPOWorTmVETGVPcFgzT0RMcGZvM21QSDFF?=
 =?utf-8?B?K05YR0NtQnJZTFkxMzZTa1ppLzk2WG1tcjk3dHkyUk9QUmNBQUZZVFdmbjgz?=
 =?utf-8?B?akM5T3ViR3JwZEoxSTY1U294U09jL3ZsbVR4MzRBR3NoN2xzZUUvWi9ZZ1dk?=
 =?utf-8?B?Q0FPRUM1NE54QUpMUzZRcEN2c1REN3dKVFRnSk5taE5CQWZYbm1CVlpvWWpP?=
 =?utf-8?B?L2NtN0lySk45WGVjemlRTnVSRWo1RHBySEZEczMrbjlmMnE2WUE1L0p5V2po?=
 =?utf-8?B?TGlkSks3TDEyVXdvM2pDbG5lODNLQ0VISURrOEJicWlUNmdOUDBLRkp6enk2?=
 =?utf-8?B?dmV3U3lRSWhxMmlCdXBkMTkzUjg0bmo5RzQ4YjZHQ2dLMWtSRUZaYUgyV3p3?=
 =?utf-8?B?anFxdkQxNFUzL01vSlo5N1hYbzdlVy9RNy91aVJYVzJjRStXMlVzTUZ4RzdX?=
 =?utf-8?B?eGgwdUN6eEFVS0ord2lzcUpHUUt6L1h5YW5ISVR6aXdmVmlIenVQd2J4Tkk1?=
 =?utf-8?B?RGJQUEh6dGkyL0ljcUFPQ3VnWm1LRExoNXNGdlRZZFROU0pKN3VXVFAwSWZY?=
 =?utf-8?B?TUlhaGlTV0M3aTNYQmZpeGFqTllJYzFYL1ZJeHVSMHB6Qlp1TUs3aVhXVFg2?=
 =?utf-8?B?T3B4RytxTUo3VlhiYWtYcVBmTFVFVmZsb1h3eHhjRTR2QlRIZ1ZxRjJjTTJq?=
 =?utf-8?B?YzB5NDdNVGNvSDhhVS9qdDNjT3VKRDN5UDJseUs0MStNakdVT083MUVCa2tx?=
 =?utf-8?B?cWZPNFF3dUM5MFlKdkU3SHRuNWV2Uklqak9vU2hPMStoRHEvemc3eGhqRzdJ?=
 =?utf-8?B?TnlpZTgzM0dkVTlUdjFpeWNPTEJ5TXJlQ3VDaElPNVc0U2F5akhCQUJnTkVa?=
 =?utf-8?B?Q2kwODFVM3J5eXZhWERWSmJ1eFAwOG5QVVdhOUczWGxGR241enpiU21FeVRk?=
 =?utf-8?B?eHhkdFkreSt4N3Y4NHpReDBsS0tEME5WOUJRUWNYeDA4eUdxNTV5bmp6QXpL?=
 =?utf-8?B?TWFXSHZueDd0VHhPSjRZN0Z3dWlGMUxzRmpPM0hKKzB3Wk9GSnZCZ1dLWTZx?=
 =?utf-8?B?ZW02WEJYUFNxVXJPbDZzdDJiVXN5MmVQZllBTC91bWo2THFEeXRBZnd2a0Jm?=
 =?utf-8?B?WVhkTnkyOHR2UnN0R3N0Zk9hVktReU1uV0N5ZXpRM0RSWU9VSkNzSTc0VDZn?=
 =?utf-8?B?b0ZiZlBnb1JoZ2tzM2ZRUkVEN0JZRXpjTk1SN0NmaVNiVGJhTnl4U2dLNEQ4?=
 =?utf-8?B?M1NBRlk1SUJORFBJSENEUTBQVXluUHRkNTZSdjczMm5DMHNWQWh2N3lQQitl?=
 =?utf-8?B?RmN4cHhHYStzcitUeEJ6anYra3ExRExRamRnL1pCb0s4ejEvLzZtY0JyUmhO?=
 =?utf-8?B?OUZ6SXo4MUJBc2dmd3hNZFhoS0ROMGRuR3MzMUJFd3VEZnVaZWRDa1hQVXlC?=
 =?utf-8?Q?3FvtU8ZHQIq46K5yCyGKqVoZnUK21/DX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWlveTQ3NHYxNTcxckUyRWZwZTlVZmpKdlc4dE1YQzBzejU5UWUzTHIva2lp?=
 =?utf-8?B?cHBRaURGM09TUDIzQkRkTDhuSWVCWTVwMXJpQStoOHRrbHl1Y05zSkQvTDlu?=
 =?utf-8?B?TlphTld5S0NINUtjdWZ0eGVGR1dUY0dGM25xOFNnRlJraDcxSE1ZMUlpUHc5?=
 =?utf-8?B?Zm1tMlhiUmNCTk1zTjIvOW92OFp6eVZyZ1BjQWswaUVNekZrTk5sa0o1OGYw?=
 =?utf-8?B?L0czM0plTUVucUtCNU5CcEtIYUR1aE9YTW16bkNkbW9JbUt2MzhmeTY2L2N2?=
 =?utf-8?B?bEVsaGpGL2FWZmtWTks5cFBaRjF4VGl5OVVvK1R4enRVVDJNRUo5bXVaY2da?=
 =?utf-8?B?RjUxUktxR0hVTUhuQTBMNi9XM05MMFp4akxsS1JUaFdUWk9TbEY2M0phaCtj?=
 =?utf-8?B?VGczZklXUFJEa2IzcXNIK3UwWHhFcFRicUJzSEd6UjA2RnYvSm9DcU9vbTYz?=
 =?utf-8?B?a2Q0MFVFTmRGWmxQN0N2ZUhScXFJMGhLQTl5emRmbHBUSXFnTE02ZjZjNVdT?=
 =?utf-8?B?aDNRTGNLRXdKWjhMbk4xaG9vVm1tUDBRRWNtNzc5Um1WanFPeWs2a3htTC9a?=
 =?utf-8?B?dmdhYTllZis3L3NoMzgvRENQRnV4YzEvSHk3YVNVcTVWcS9oOG5ldjhNT253?=
 =?utf-8?B?U1NzZldhWmxiRGNwK2VoMzVhUTg1eWkzaEZnL1hEZmhlN2pVSXBTMDA0ang0?=
 =?utf-8?B?a2p0OVVlVmJ5Ky9yR2lTMTRRWTNxcG9hWUdzNVBCRzhJZmFOUVFlc2VxMGRY?=
 =?utf-8?B?Wkg1Qy9qY21WcXNuRGpDVmFSNXkxQU9hdjN4Q2hwRU1xWFZvWDFKcmlHVkMw?=
 =?utf-8?B?dVU4WmtOMXhxU01nT2swUENLbHN3c2FOREM0VWJjSGtsY0dvNlEzVnJ3YUhU?=
 =?utf-8?B?Y0dEcnhDdXRYQTZVOWt6R0RLcHh5QzJUQnFYbzlSQ3RFc0VtVnRIMDg5ZU9I?=
 =?utf-8?B?bnVSWS9MQmp3aVdzdS9lc3BVamQxSkxhUVpYdnA4UzBCd1YzQzl6MzUvQ2d4?=
 =?utf-8?B?cC9ZcGVzWFNKOGZmbFpNQkhJSmgxNUxtTzk0VmZBQkUwT3BydWI1NThIRFA4?=
 =?utf-8?B?ckNNdGNKQzlHMUJHVFhYWnJVSkhScnZ6VzRXUU82dERheGhnbDQ3U3NiTzNv?=
 =?utf-8?B?c3VJT09RcFY2V2MrNCt3cTRtWkRYUWk3c3lGZ3B6eDJmT3VEck9uMy9Id2FE?=
 =?utf-8?B?L0xrRzRuVHM4dzlQNXZYMXVEWWx6MVE2bUppTVh2Y1J6cVQxTGdqWXk2KzdY?=
 =?utf-8?B?SUFlV25qc1NZQUhYeTEzOTlEdk1RaVVzdWNSeGJHYXFudHYwTC82R01wYS9a?=
 =?utf-8?B?Y0h1OWk1RXh5UGN4TERRczEvMk1nZlBicjVMK242ZWd3cnlSUExFd0JtMDVa?=
 =?utf-8?B?b1FjUFpLaGd6a2s5M1NPeWR4Tnh6MTVETm5JdlBUNEZEVE5ib3pIcEp1b3FN?=
 =?utf-8?B?d3NZZGF4dFFtd21KMERPbVNCcmhlYmR4alg4TzM3RExzVysvbGZ3dWM3VHJy?=
 =?utf-8?B?bXpuNW0zaXFwNWpCeGFNQlg3VUgyRTFUd0VSMGlJVU9yajB5cXF6MmhMNmIv?=
 =?utf-8?B?TnNpdURzbWplR3dTV0xWa2RGYzFWYmhvdUxYY3N6SmJ5aFhQZzQ4SEtNcEY1?=
 =?utf-8?B?djJxakNQT1Q3ZHhqckFHVlpLNkdBdkJtWnQ3eDdYUjhLRWtjSlpoUjE4cnBF?=
 =?utf-8?B?L0l6U01XQ29RQ09pNnNYblZ3Yk1YSEdIbkxGbUtqbS9MeklHdXl0V1JFaWd3?=
 =?utf-8?B?VXJqZFYxbTBEUDlLR3JPNms4SmtDL05PSjV4UlNuZlFNYTVtM0F6MzBHVkc1?=
 =?utf-8?B?cHBkL2wrYU84M0JtbThSZnFaWUpVV1g0M3hRN1JBQmxBbFI4c0ptNGhmWHFv?=
 =?utf-8?B?bXgrVmREWXdkZVFaTzIyWTdMRFdZQ3BEVmNnZVZVSlVLTDE3V0JWTktoRFhP?=
 =?utf-8?B?QjgwWlFYOEZNVzhoc1dxT3puSnArQVBZK3F2OUkwbnUvdEhmTTFkRkVJNHNt?=
 =?utf-8?B?aU4xbWpCd2tVSDVLWnFzQS9zRUJBWXlNc2tWVUpxQjRqaVozeW8wV2pGRmZ4?=
 =?utf-8?B?MkVjeTdqVTNWMWpJN1hXSVNOYm8rMlFJWHhpYVVOQnpkUkhmaWVJM1U2Y1RZ?=
 =?utf-8?B?ZS93dmJmSjNEZmZBWUIrWU93Um1zenBoZWw3c0R4YXRLNTFpWi9mcHQyNXVR?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5ecc7a-b5b6-434b-f304-08de318a0c3a
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:03:31.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4RJ+8SEaK0T9ieiCQlbQTGI5NLZviga2CWhQRTywAwEc6rXcfssrl+nVS4NuFjj3fc2iChmurjydAVHMlCvKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB8688

Hi Andy,

On 01/12/2025 15:59, Andy Shevchenko wrote:
> On Mon, Dec 1, 2025 at 2:00 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
>>
>> Support configuring output offset value. Among the devices
>> currently supported by this driver, this setting is specific to
>> ad9434.
> 
> ...
> 
>> +#define AD9434_CHAN(_chan, avai_mask, _si, _bits, _sign)               \
>> +{                                                                      \
>> +       .type = IIO_VOLTAGE,                                            \
>> +       .indexed = 1,                                                   \
>> +       .channel = _chan,                                               \
>> +       .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |          \
>> +               BIT(IIO_CHAN_INFO_SAMP_FREQ) |                          \
>> +               BIT(IIO_CHAN_INFO_OFFSET),                              \
>> +       .info_mask_shared_by_type_available = avai_mask,                \
> 
> Okay, this macro uses parameterized avai_mask (which should be spelled
> correctly and probably in parentheses, but it's not the point) and
> it's being called only once. Why can't we just embed it for now?

Sure, I'm ok with embedding if that is preferred.


> 
> 
>> +       .scan_index = _si,                                              \
>> +       .scan_type = {                                                  \
>> +               .sign = _sign,                                          \
>> +               .realbits = _bits,                                      \
>> +               .storagebits = 16,                                      \
>> +       },                                                              \
>> +}
> 
> Also, looking at the existing macro below, I think you should have a
> common, parameterised macro and then 3 different on top of it for this
> case, and for the existing two.
> 
> Does it make sense?
Keeping this and embedding the ad9434 declaration.

> 
>>  #define AD9467_CHAN(_chan, avai_mask, _si, _bits, _sign)               \
> 
> ...
> 
>>  static const struct iio_chan_spec ad9434_channels[] = {
>> -       AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
>> +       AD9434_CHAN(0, BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
>> +                   0, 12, 's'),
>>  };
> 
> Also the first and third parameters are identical in all cases, can we
> for now just make them using a single parameter?
> 
> ...
> 
>> +static int ad9467_get_offset(struct ad9467_state *st, int *val)
>> +{
>> +       *val = ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
>> +       if (*val < 0)
>> +               return *val;
> 
> The standard pattern is to avoid polluting the output in case of known
> errors. Hence
> 
>    int ret;
> 
>        ret = ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
>        if (ret < 0)
>                return ret;
> 
>        *val = ret;
ok, will change to this format.

> 
>> +       return IIO_VAL_INT;
>> +}
> 
> 
> ...
> 
>> +       if (val < st->info->offset_range[0] || val > st->info->offset_range[2])
>> +               return -EINVAL;
> 
> Wondering if at some point we can switch to in_range(). And we perhaps
> need a new generic macro to supply start/end instead of start/size.
Atleast drop-in usage of in_range() does not seems feasible?

Thanks,
Tomas


> 


