Return-Path: <linux-iio+bounces-26634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79A9C9BDB5
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 15:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E333A756C
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F821F5437;
	Tue,  2 Dec 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="sADgoCs/"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021086.outbound.protection.outlook.com [52.101.65.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B519A288;
	Tue,  2 Dec 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764687141; cv=fail; b=MO4kH4GH/3wQmoSOQWNzsOrbDZCiTdP+NaT0TRHwOdfVDJd850b+AtPXcSqtO1V6uGaGLv3YwwCKcysandKdHzWI1uJSnKE7NgCBjb2aDvWu1agD2sbRWOgCdKgMESWdIAVakpew07UJw6WOPt4vS2nxc+ZJbTYTt9cY3ulWrrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764687141; c=relaxed/simple;
	bh=23Vz0RPFxi3dbO++5mjNfgdKCPZY3iuCPk6KSGlT63I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uLflVEyiDmw3H6cnKiAmGpWpvGnERf3rQvn4BoWcZgE8PCyZy+JNiK8ikdBZSBfSvOpP1jA8CByOci4wXg0SzwA8hJvQsKlZqaVjQVx9vd452TP/odH2ZoHNMuMwkY2otrJiDWtVWy1ISUn9D27xqSl6xgPvwKYNAPYMeUCmVZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=sADgoCs/; arc=fail smtp.client-ip=52.101.65.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHZN2kAA97OUriBKeqHPer+9d67/WjmbUAn/rS+OrBz8N0JFTpAhN7AtRRm/7+R6IvOnqBQQzo4FM7wFF20FJ/ig7dMCElBwDw0nz5IO+tLClVgBOaLKO9O9Jypr08a2YmofWHvhA/YF0CVSaRmaegCpIDXYjXFVvSs0Fn5MuUJ5/kV/p7gRLLL/soJAbwlgqAchnb4lKIhuu0McIsXR6kgq4gcjhieAr/vNJiXR8hUterIufoX2RtJ7wvrbhHdEvYPdHVnZc+A6sCAfPimZJYTCWQ1EHy4FFlU5KcYtxCooT8a9KwvYDJr37jkMKGLPazJ7TZjtE8R1n4FYmOdB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR6+J/SLv7jzabYMMPcYhTak6xRSEK10IW1BP4NYhII=;
 b=P/4igsB8em4iH2sZ7kIysNtKJYZofFnzQDFRaJFJuVCWFR/WSeqZ3M1zvceUJDl/+aiLtP8lU5zF4nA6iqcKhBcjcSsNPhM5g6WzanlV/tJJXGxuQwwB/w+LXfIDCcM+hWXebZieAD1QD2kqvkfVayv3FBKQSwUjaxV9QBRJ/+gQruGKjY5kdhlP/RAAvfExGkgfPPsx12xl9It3lMc5SxQIhqNLmxS45xK0wRkkmMJmfd4PruDODFOVedSBa0gr7fWkYgDOQELY+2oM9asVxw35cDnRb1EEacXumx25bt5ilBXq+PcgpZjb7THrq674MKr0uORWyoEJnc5OkESq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR6+J/SLv7jzabYMMPcYhTak6xRSEK10IW1BP4NYhII=;
 b=sADgoCs/EATwKHx1dQK8gWnhwHMA5PhTBufOFDV01JUsRb42OYEl+/P3kO3UwPZ+UuN9c4cyctgezB6X2hxRp6Xps5xiIm52KX0GRtqmrBp/gqymf8pWzJF4kes/G7kZ19MkuDoL7pRpcOVT8LbAOyHOnzudItfYq2F1rbdaPXB891v6U3JAjeFcHwCtW1w41QohSvRBvooMiq6H0EcLzkLjizUebejzt9XzykRjZGedT2BA7seSXYbvhAthucFHRd3/1bJ/Cxf2Iy5rbtnG38rp214cmF++IFNbAF8oG237wiDL/69eojP6JP3Zs61A93be/VXAhxcif/DYJvt56A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DBAPR06MB6951.eurprd06.prod.outlook.com (2603:10a6:10:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 14:52:11 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 14:52:11 +0000
Message-ID: <8edcbe15-b3cf-4259-9d07-87c07f1f400e@vaisala.com>
Date: Tue, 2 Dec 2025 16:52:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: support write/read offset
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
 <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
 <5d343af235c499382bd2eac987357e857865b457.camel@gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <5d343af235c499382bd2eac987357e857865b457.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR0102CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::17) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DBAPR06MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: f40d25cb-4446-4594-f339-08de31b25fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1V5cHg4UlYzZVh0WjBVU0pBcFVZay8veG96SUtKQ2xlRVFPRnJxN2dhcFpU?=
 =?utf-8?B?dkFlNTJGeDBDTG9HcGtGQytpOXFrazZGUTlEUG5tU2xSK21nNHg5NGJKMWJE?=
 =?utf-8?B?bnpOazVLaWtoSmlqeXQ4WWhyL0tFMGVsSkp6V2FTck45NlRIbFZVa05Ha1VI?=
 =?utf-8?B?cE5ZZnhvMHlpSldVQVgwdlkwY2lpKzBhYU85ckNWWE5jemtsN3JLVXIxZmZD?=
 =?utf-8?B?VnJCY2RHZ2NkUVlBRVVxbUVXOVFXUjV6S0g3OEs0UHVYbFRObkdYN1E4cFhp?=
 =?utf-8?B?TFUvWnkrdUlwMFNUS0cvOE1hR3NkdWg4bWZuVFUvT3MyQWs3b2tWSVZMV3FY?=
 =?utf-8?B?Mmlid0hrTldnUW9mV0VyL3JMclFWblNVSVVzVDdUeEtmbkJjLytqbk5LSE10?=
 =?utf-8?B?b2NPcnRuK1lod1RxQTBzRTNSMnlWVkFiM3RrVmRqQzN3Q3VuMndySGExU1lq?=
 =?utf-8?B?blJZN0RWTjU0TUFRNHp2Ykkyekk2ZitBakp0WXVWNThySjlYcXM5ekxiSHhU?=
 =?utf-8?B?YnFGM3FnWDJac3g3NFIyT2lJUnNYWG9YLzFUeFhuSXk1ajk0b0Fxb2dTS3lh?=
 =?utf-8?B?d1ZmT0Z6NjdKMGlBTDBoLzdEaFlMVVYrM1ltSVo1am5QVktCZS8xbEs5T0JU?=
 =?utf-8?B?SHJVOG1sazlhdjNPK1lNTEtwRjRldmVzOEpxNnl2MVNEaWFBemxxc1c0bk41?=
 =?utf-8?B?Y1g1NnNja0NSWGZLSWRGZnl6RkNoSUt5SS9BcUdQRHdIQURHMEFTMVF1TUtn?=
 =?utf-8?B?eTRqSm5BUVBDclBwaTZRYm5Xdk9IdVVpNmx0YzA5TU44VEFoQzVTT3dQbXFU?=
 =?utf-8?B?V0ptbWxxRnJlVlFHRmFoZEFMNG9ISzQvcmxRTnRsMEFBWHBHbklLbm1VZzVV?=
 =?utf-8?B?MWZhbUo3MG5XK1BiSVEvbjk4VjlweEI4SzB4b2c1VXNyNVIyZDFzWEIyTWY4?=
 =?utf-8?B?YUFHL1VTYlROUEVxSm40NzdoOGJjVzQwWkxpR3ozVTBBMEhiRk9ZWWpxa3VX?=
 =?utf-8?B?eTBSc3NzTFhqcnB3MlFuc29xMlVsU1ZiWW1IUXZ0QWFDVVBDUkkzTVRFaUVm?=
 =?utf-8?B?eEg3TFNHTkpCMEVJRWdyaFRiMlVHQUluSzhWOVRqZG5WWGEwaUF6ZkxuUEps?=
 =?utf-8?B?TStNNnU5RFNTcHVHYzZGZW0wWkF4bFY1VXFJSndqUFpxNUVhdWV2enljUVJT?=
 =?utf-8?B?UnBIUjdKQzRlbW9pYU43Z3g5azIwK0ZyNjdrV25DUWlkdjZ0cEoxNkY2bEV3?=
 =?utf-8?B?MUp5QktTR3YrVS8xUEF1a1FUMndqU0hESmVOdmwvb3NseENZdXJ3cmRZWDd4?=
 =?utf-8?B?NTVFcWVXdERURjEwNGM2Vm5KbVl1MHhEVEJ1bXZFdjNlOTFsdWFyZ05mS3pI?=
 =?utf-8?B?N1VBY3REMmNTdkZyb1k1ZVlDcTlJN1lVaFVQUG1xUHM1ME11dlBlcWFOdTRw?=
 =?utf-8?B?TDM1V1VaSzkvOGNXcmREUVo2cEZVR08rSFN5cTZ4VWRwa0pZRW9yRFNHUGE4?=
 =?utf-8?B?KzJJZkFsQXhJWlJRT1FEUDI4NXNtbWlEUjNrTUZwVkZZMlhvVlg1M0E2SUx4?=
 =?utf-8?B?QTNyWXZRRkttazFBdExlTlVPcjJNUCtXWFRPWC9FUVdMZVpUS0ZoWG84amY3?=
 =?utf-8?B?Z1hZZE90T1RZUjYzSVFlZjhNNnJzV3ZSVUFPRFh6S2x2ZUxEMUJ3QWtNdFV0?=
 =?utf-8?B?V2hWd2Q3bDkrT3FtTHh3YUhQUXMzY0ZLQ1k5VlhmZ3V0OURxdmNRdG9mS2xN?=
 =?utf-8?B?di9rTXFqT2pBUG51V3FpNENsOHBFRGlFUTZCM2M5V2FRcUIraEIvdER0QXZG?=
 =?utf-8?B?ZTJMVGEweGx1RU55ck9DVEl4UjBONDRmaHpMSFpLcXpTS09PK3hrYTRDQ3pw?=
 =?utf-8?B?dnN2UTE0d0svN0VLK2pEelhqKzJkcFlqZ004YS9RQ3lRNFBUMFk0VStaemxK?=
 =?utf-8?Q?csaCKCXY/E4apQlJ+ups29Hfil66HvWJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1hlV1Y0Si8xOUZTeDNyVFVrOGkwTVZvb0haSGhrZGxhTDZpY05aS01jODlm?=
 =?utf-8?B?eE1oZ29zUUMweTZKUmJpcmloRWVVU042MlNpbSs5VFVMSUlYOWplbm1KRTRr?=
 =?utf-8?B?VzZnSmNjaW5ucWFsd2JNQS9pYklwRTdBQmp4ZTh2YUdDKzdmUHhNMWZRYmFD?=
 =?utf-8?B?cWtkbncvTmlrZkQvZjgwZzJ4VzhFTCtBSm1Dby9IVlFSQUhNd3VWTFdueWRM?=
 =?utf-8?B?UHpkZXcveWw5cmh4dTlpL2NTWFl5SE9RcDlUVFBTbmlVTDNraTNmZ2hWdkZR?=
 =?utf-8?B?dUIwaWlieVRXbkdHYVpFYUNmT3FnMC82NlA4OFV4cUplS2FTYmliSmxVMXI0?=
 =?utf-8?B?YkVBWGFaa05ncFU4dmFmODhvYVVhN3R0TEpEV3RwMktWbVNOOGw0TjdxemQ3?=
 =?utf-8?B?TWhYODZQeWlBRi8wUTVBSDg5Tk4rRXcvZFZBbnNHMjBtNVRVU3pYL3dEdXRu?=
 =?utf-8?B?WnVsczVjK0dYS0FhVml6cENhREFIZzZ6d1Q0ZFBZVmtYUXg1MlYra0JROGxt?=
 =?utf-8?B?TllrM3czdTBHN0lDVlpxMHMxb0ZnbGNXOVpVTlpORmVZME94b3dRNVlreHFm?=
 =?utf-8?B?Y0k5S3N4cmdITUdFdnhTU2xxYm5RYkU5SFhCS0N4dTNOc0pDL1NTSHkyRStJ?=
 =?utf-8?B?TklSb2ZSeHpvQVpkRVFlMnppb2djZEZwQnlNVFVxdXRTNkRGT0xNMlBtNXBQ?=
 =?utf-8?B?Unl5Z1JNTWFSVGRaZ2lzdkVKTUpHL3dXK1NZWkZZU1Q1WWsxTnN3SHc4OWJq?=
 =?utf-8?B?amxXdXFBa08zVWx3K2FOQmd1UlhlVDJzYzZ1bDhWMjYrb3ZhSnBqdzI3UG5O?=
 =?utf-8?B?NHBPc1kzeDdqYUJBY2NoSm9ITHhFa0NHVjZhVHBvZWgrSElDZldCeTd5WlNO?=
 =?utf-8?B?NFA4Sm0vOWxDUE8yWXFORTkzNlA0WVhhanBFOExRTXJ3ODVnbUhMRGI0UVNT?=
 =?utf-8?B?V1o1UzlzUWVYY1ZnclhSUm85UTZkbVVVd3FCOGM0UUNrQ2hMT2NCejR4UVVM?=
 =?utf-8?B?ZUVCQkpwcml0ZS84LzFmUWdNdmtGeVdJenduWkE3WTREVjBuUXpHVTZTNkpx?=
 =?utf-8?B?ekVnNVN1NEh5UStLZUZZNGU1NU5waWIxNm5GVFpLQXRWcy9pa1lUdDBXL2lY?=
 =?utf-8?B?SzZ3MTErL1lpajQ1NHFROUJzbmRneTBOUCtVMGFYTTVXYkVxWmJqRTExQmRU?=
 =?utf-8?B?YU9SZytqSXlybzYveFlWZWVDNEVqU3d6Q29WQWp3bXM5S1kvR0lIT0FiMHpR?=
 =?utf-8?B?RmcrS2JtMytlRnhIRlJIekRCQ1c4RFM5WWlQL3B4bE5BT2lUaDFuWUFmdXZv?=
 =?utf-8?B?dmYwNHlnNFFac3JUUkx4dTF2aDY0THl4Vk1SM2crSXFwWlpjcktMbi9paEtx?=
 =?utf-8?B?SkYyMVpPOHVwcFd0R1N1Znhmd25aYjlUT2lzMmJvZjBwa1RsUEJYMmc5L2Fn?=
 =?utf-8?B?OWhaVzJVTlc0UHJUVHlzeUt1cHF3N2Eya1ZHZVppQm1tVWhIZkowSitlYXIr?=
 =?utf-8?B?amd3WDNjZEJ3Q3dXRHM0aHdYVGd2UjA3bkhkN0UwVE9VVmxlTHd1VVJhdzBO?=
 =?utf-8?B?U2hxeFRkc1BJNDRXWGxqVXl4ZWR4dE1VaWNwWHFhZUtYQTRHY2ptRFhLakNt?=
 =?utf-8?B?dTI2Nk0zU2VLbWhSS1FXQ3N1OXdIOElUTHFHZU9QcEhWZ09LdEtJcUFIdWIz?=
 =?utf-8?B?VHZKV1R5eHA1UXVQb29XZ090RXhUbFhvT3hUNGloRUV2dmg3ckM0ZXd5am1C?=
 =?utf-8?B?anZ3VU9ldThkcCtiTkJNR0hzNmROOFk3WlNUR1hNYWZMTUtrNXZYaHE5cGE0?=
 =?utf-8?B?SjVSNFEzbzU3eHJhQWFadHNMZnVObDJSWXN4NzZTNlBQUFhkVmowaUg5Nmdp?=
 =?utf-8?B?UWlYWEVlN2FGdDdRK2t6SnU3U2hBaE52UG00eENNRDAwbUdyUWxHcDNSeC9a?=
 =?utf-8?B?c3RVMVJGMXphc0FRRVQ5R3IrZGZmeGZCNHpCRC9BYStDVEIrakIvUFRmamJV?=
 =?utf-8?B?dUZUaUNlWjBKaktOeVJRWkhlT1NRa0F0R1pFK1BsL01SL0ZiVkFHQ3N0WHc2?=
 =?utf-8?B?ckhLbDZJYnUvb0xWdGV4Q1dvSTd4M2IzdktNSnk4WUVrWTk2SWFFbEhGVUVz?=
 =?utf-8?B?ZWN2OW05dGs3TkVuRlZrUHY1MGl2VXczbUFJTWdnYWZqeXRYSk9EWGJURXhZ?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40d25cb-4446-4594-f339-08de31b25fd1
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 14:52:11.6253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QYEKWUg1F8B2zzWKzh7/PqHwvo+iQhAoERTucSIz9+o8QNsnGDa/QGnIjz85Kkxo9dQQd/7/lLeEoos2FnuCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6951

Hi,

On 02/12/2025 15:47, Nuno Sá wrote:
> On Tue, 2025-12-02 at 12:53 +0000, Tomas Melin wrote:

>>  static const struct iio_chan_spec ad9434_channels[] = {
>> -	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
>> +	{
>> +		.type = IIO_VOLTAGE,
>> +		.indexed = 1,
>> +		.channel = 0,
>> +		.info_mask_shared_by_type =
>> +		BIT(IIO_CHAN_INFO_SCALE) |
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>> +		BIT(IIO_CHAN_INFO_CALIBBIAS),
>> +		.info_mask_shared_by_type_available =
>> +		BIT(IIO_CHAN_INFO_SCALE) |
>> +		BIT(IIO_CHAN_INFO_CALIBBIAS),
> 
> Odd style for info_mask_shared_by_type_available and info_mask_shared_by_type. Seems we have
> more line breaks than needed.
> 
Looking at existing code, there seems to many different ways to indent
these kind of lines. Can you please provide your preferred style?


> 
>> +		.scan_index = 0,
>> +		.scan_type = {
>> +			.sign = 's',
>> +			.realbits = 12,
>> +			.storagebits = 16,
>> +		},
>> +	},
>>  };
>>  
>>  static const struct iio_chan_spec ad9467_channels[] = {
>> @@ -367,6 +389,7 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
>>  	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
>>  	.vref_mask = AD9434_REG_VREF_MASK,
>>  	.num_lanes = 6,
>> +	.offset_range = ad9434_offset_range,
>>  };
>>  
>>  static const struct ad9467_chip_info ad9265_chip_tbl = {
>> @@ -499,6 +522,33 @@ static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
>>  	return -EINVAL;
>>  }
>>  
>> +static int ad9467_get_offset(struct ad9467_state *st, int *val)
>> +{
>> +	int ret;
>> +
>> +	ret = ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
>> +	if (ret < 0)
>> +		return ret;
>> +	*val = ret;
>> +
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +static int ad9467_set_offset(struct ad9467_state *st, int val)
>> +{
>> +	int ret;
>> +
>> +	if (val < st->info->offset_range[0] || val > st->info->offset_range[2])
>> +		return -EINVAL;
>> +
>> +	ret = ad9467_spi_write(st, AN877_ADC_REG_OFFSET, val);
>> +	if (ret < 0)
>> +		return ret;
>> +	/* Sync registers */
> 
> I think this is not what David meant by adding a comment. IMHO, the comment as-is does not
> bring any added value.
The sync operation is needed in several places and is not commented in
other locations either. Do you prefer no comment or even more elaborate
comment for this particular sync operation?

Thanks,
Tomas


> 
> - Nuno Sá
> 


