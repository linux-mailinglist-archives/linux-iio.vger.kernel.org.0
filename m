Return-Path: <linux-iio+bounces-27188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE96FCCF917
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 12:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2F193018610
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4333126AF;
	Fri, 19 Dec 2025 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Ldsa8lNb"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023076.outbound.protection.outlook.com [52.101.72.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174530FF04;
	Fri, 19 Dec 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766143589; cv=fail; b=b0JPFSB2XaQTnoxx+VNbeeWKOJiKDR1C3wbdylDsrd5Q/vAg9nYEqa3tOlFXmd60C0nj53rr9UlZN25lwGb+P2m859ctUoh94FwJIbWIuInDplYF/6xrzSiig7r2hbLwq11WbrZUGpBaLdvk1hoATgMqQ5gIjwktT05YQnVxCko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766143589; c=relaxed/simple;
	bh=ECp+5EVy9PEATWFYM+LDOM9C5IoRIyfLbGfZ50LaxOA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EPHwg0BPBX/sfhQK9VbodFdfmS93PTFnQlA9WKqGr2mOztH9kCAMJ96KQE5QhPHn1jGENjYvYp/spbSBW4fhGSN4VvVG53LolVUqs4GX2iwhlnmOaHMU1DWYpA3vAHqrBlmscvwuVj8fDi0pygTi3ipYjlphSBOaaoWPVYz29So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Ldsa8lNb; arc=fail smtp.client-ip=52.101.72.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNxQnAwG3dpc6hxRkXoUexz6n0Sq24c+vYibXrfVNruCOib04djTInT3Qu9T76704GAhn4jmVZvGsYHDXeVr3crzgNru8Tkq6BhRjX0qJCJpk/vnD0GL3vjeZ3qoyUfagTnJmKAicRfqkMviwgWJu22VKiD0DG421utvXqfwaiPPde1PaLi4gMHcPYlraVPzQgNMVADnchsCwOokJZJhRJcDPKpeKMRRLc0wwYn8eM0ENOD+kTdfoZ9eXME8m4cAof0PpNaCU6kVNztScvxbf2u8j3RgmY+kAb/tqL2CEZ1kntMRj5HdfS9JzQ7ByAWBu888tKdtoRSoA/RTe0Vjew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58UT6wVdfG/yHesScaYOyWirMKJnbBpGb2nYSpKaiUg=;
 b=HFMFcM8Pbgj5AYUYwb48VazrQtV8Gkuy7mowRZRFOOZR33iY4QF9fTHkvotNT2yt6YEqXesbvBpMM7S6wTnuYNwoub/d/AXmkk6eccmOGLJeiEp3/ELBbivTrK74dnAg2drMIQM2JNOUERBh3JpDNPvALm6pP+ubaVeJa8MldkCyalQf2BzuId1KCpskzznyRJwN93T6+gZdPJQhq6KZkIH10X5rDAy9eZ93EUyA3nP3RmcgkLWEjW09v9R+9blPhiPLRUx9F7lxhYRne59NtPQwbpLVkKBibMIwIN2lF1Ga3nngee+7iKbcpFzCZOX6vVhr3EwTaYm097gdrFJmoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58UT6wVdfG/yHesScaYOyWirMKJnbBpGb2nYSpKaiUg=;
 b=Ldsa8lNbdz9E7KCcD9/lGZypnzx442McNt7urXliM6D8DO3C0MD7bYGyDpzku0AvtT5zMTJfSmO5/1ZmcF9ZytMbyePSz4I6ZVokYvsP9RfcfGVczK50zOvu+e1YI3p3uE/G7LXr1kpQMKhzSbeJ+QhDvfBJfqESg9HCaRl3j47XHWiJvZV18ot4bEPciiLNKS/LG2PF+N8VU1IecL7kQQjFvkXgKYgdWR0gn77bS3ztG+Hnl5GMXHu4uiPUxkcWaCC0wxhSQRydpJlVxa0qAAQHKqjernkeViMpmzEy8nFWybhEN6/vdtvKWFzM4Sx2a8kmJjVshW0xBKZ+4U+/Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PA1PR06MB9114.eurprd06.prod.outlook.com (2603:10a6:102:454::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 11:26:23 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 11:26:23 +0000
Message-ID: <df70028b-49a5-4004-a534-e1451d581dda@vaisala.com>
Date: Fri, 19 Dec 2025 13:25:17 +0200
User-Agent: Mozilla Thunderbird
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
 <2a265681ad73bebf1ad7aeea418fb9399b8350cf.camel@gmail.com>
 <d2cfd1bb-0bc0-47c0-a68a-3967cd64878c@vaisala.com>
 <c3ed08159082c15f8804c6963b4422bbbf2039ab.camel@gmail.com>
 <5fa44e46-2d94-47dd-8429-9748aa28f908@vaisala.com>
 <055f9c79ab40a8a72e69b7c9cfa2a64292377f5e.camel@gmail.com>
Content-Language: en-US
In-Reply-To: <055f9c79ab40a8a72e69b7c9cfa2a64292377f5e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF00007A8C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::61c) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PA1PR06MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: d00edfee-24a5-4291-0e87-08de3ef170bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WC9lZC9XVytTV3NUVklZQzY4d3A1bk90bThjYVBPemVuaGpPd3N5Ymh2YmFE?=
 =?utf-8?B?MmRPWHIwR3NTU0hGVTFLVjJMNFpmNGtGNERGMTA3MXh2TnlKMkR3VG90RURD?=
 =?utf-8?B?cEIvaHlVQ29WNUl0UnVlblA3M0JOWmtzbHVpbk9FL2MvYzhEQlYyUmF3TjJF?=
 =?utf-8?B?b3VScjJIZVdQa3JZcmJmejdvTWpSb21CN2xWcXRKdkFMcFNuYlRLWVc1cExk?=
 =?utf-8?B?bGlEMU9YbEtLRVRJQ0ZCa2xvcnBkOG91b291eXJOYUM5N3BjbytlR3BBNnhE?=
 =?utf-8?B?elk2aEVEUGlOMVJvQW9HSGR3QWZUSm0rdmF1ekRLVlF6WHZtOU9kbXh0OTNY?=
 =?utf-8?B?eTI4RjUwaCtrR3dMYmpxdVdUTk9yek1yMVNhRnhxN05BaStrVFBSYnEzV3Jp?=
 =?utf-8?B?RU5JdUZWTWxsR3dqYTJQV21uZHNNVk9Mblk4anJtdlQyUU15VGNOS1RkbTNs?=
 =?utf-8?B?elNuTzdnaFBpZ0VNOCtzQTZZd1RYYmNtTjd6dytscnBaZk82ZzhoV3Y3N2o1?=
 =?utf-8?B?amxZMWJVdGJWT3VFY2p1MHZ2NzdOM25Cd3RkWmNSZFRob0xKTzNEMmJXbkVG?=
 =?utf-8?B?Q1VDZjJXdmNNVE9jRDI1em1IVHI3YkhxbDErSGYrcWgrcnFTalV0ZTVXTHJ6?=
 =?utf-8?B?V0pKa2NoL1d5OThCMDNpRnJrdStDYzBhcjZVN2ZSK09yTTUrOGVmMEdmaFY0?=
 =?utf-8?B?cTVneGtIRTAwYzllK2dQTkY1RWtUMUQ4Z3N1dlI0WVo5ZkdwTzcraFltYkc5?=
 =?utf-8?B?RTdTTVFJQUluSXh0TDVycllpRTZJYUxvbzhXT2hGRTF1QW9wTDdhWld6TnRP?=
 =?utf-8?B?UWJOdWdZUFhSNEpVVTlGUWRqNDcvbS9WU202ZTA3cno4eXFSUDQ0NS80eE1S?=
 =?utf-8?B?T1lObFcxSjN6RzVPLzJtKzVGeURMVzhxakk5MjVsUzRGU1IyWEh0bE9SRlVF?=
 =?utf-8?B?T2dmcld5ZWIxNVRhbXAvVDcvdU02N3U4bWJ4N2I2Mlh6Sm1wdUhoTnJzWkpN?=
 =?utf-8?B?V0s3ZmVsVVU5dUEweVNIVGdmZzZhc05YZDFxMnUxT0N1bDN2enFTVi83QkZm?=
 =?utf-8?B?eFJTWVp5SEluKzNiWU1HUjIrUmZDWEN2SGJCQ3VoSCt0YU5UUXFqT1ZjZldt?=
 =?utf-8?B?T09HdncveUUzeXIzdUIyL1dBcWROczlZdk0wdUZOS0ZndStvdHFZTTJ2L1Fy?=
 =?utf-8?B?bE1xNnZnUDdxSGZjL1VXd0w5RkhzbzRrU2x5YS9aVERwOVhLNDdFN0pPTzRN?=
 =?utf-8?B?WlVYekphaUZINzUzNEpJUmRiellhSjlNSldDblJJTEQ1OEEvY1hIbzhBdndH?=
 =?utf-8?B?dmpQdStYNDJrZC9na1pORk5kTnhOcGttTjNkRGt1SkVXK0xYWkFwK2o0cUoz?=
 =?utf-8?B?eUhrYjVNeXA2a3RkZ01GT0xqcUdaeFdyNGVXazQyaHdjVWlUWGpkMTVLQmVm?=
 =?utf-8?B?OEVpbHZnREE0eDV2UURwWTVkMEU4akMrKyt0TFU4QW5DMUgzYXMySjluaGNH?=
 =?utf-8?B?aTlXWWphQkxiVXI2VGFvNDR1UklDaWRmNFpUQXdPRm90NitsMjU2ajViczYx?=
 =?utf-8?B?RDVWdCs2eTg5a1VJWi9ZTWhiWGpBclplMGcyV2pKRXhqK0hsZTVnM0VvVjdY?=
 =?utf-8?B?bjNwRHNDcTQyR3ZEU1dKbmZEU2NkU3hPWEJLSmgrV1N3MTlBcGZ0MUlwNXhB?=
 =?utf-8?B?Z2xXczcvWWZxR0lvUERPeGNIWXlMeHpBaFlnV2RvT0N5OVFlUWVKRytlUFcx?=
 =?utf-8?B?VXk0OUNBaWQ2YkdmSkVScVp0RGZJLytNMTZpdWN0NlFyNXorMkk4VjMzeEJ1?=
 =?utf-8?B?MVpFYldHelNub2ZNajd5RXdveVE4bnhYa3MwWHM4Y3JHZHBMUThLUTN5MDYz?=
 =?utf-8?B?Q3NjektvYzNOMSs4ZlVxT3JCUThzMjVzYXk4bGtSRElXc3FDNjEwWW0vOHFV?=
 =?utf-8?Q?d6KPUhWBcwyqUjAeD8lJxfvw1Vo8J6PL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3VvK3U2S095REpYOE4xMmdhZUNLdm10Z3hyYXMwSVBGYlZuVXdHa2NPdU5F?=
 =?utf-8?B?WUIrMW9wb2dvY2NIbDUxVk93MEZiQmZESVlJZUFqSktoVTgzVlFJSEw5N3dq?=
 =?utf-8?B?VVZOSWQ0V0VJUVpENU1SN1NKcUx5T3YwVU1RcUdQSy84Y29QNzRuTVk0NHdp?=
 =?utf-8?B?bjVudnpRUWZ4Y2l1RURDTlRMdEtldVFXRVVSdVMrc040S3lYU1dJUFN0YS9n?=
 =?utf-8?B?cFZIM0ZhUks4SGlLUTJhWUVaQzBNWU5ZZ1VMUWpkLzFpcWFaYUttVUllclF3?=
 =?utf-8?B?UVYxR1FMRkxEaFM5YVlyL3pUTjkyTzN4QmQza2J1RU5RUWk5aDFjS2VwRTFB?=
 =?utf-8?B?eWxhaDVhWVkxZFNqZkt0amFaVEpoSmM2UlduMjFyMGs3MFh4ZU1pM2VyT2xi?=
 =?utf-8?B?SVJJSmVaR0xNU0M1TW9nVGY4QXJ1dDRPd2VhTnY2RWd2RE9IUzVybjJEYUhk?=
 =?utf-8?B?eU90czIzbVo3VEdMYnlBMUZ3VnNUa2FvdzNNRWdlMjhkd2NvQ0NleU53WGpj?=
 =?utf-8?B?K2FtZTBSQjhLbUlZM3JVZk43MXBGUVdOK1J0Q1dMdXlhS25tZFVsdmtnRTU3?=
 =?utf-8?B?VklRYnZybVlsK3dEN1QxdVRtdkVtTzg0bnZ4RytCOG1YNjRZRzhKM2NrMzM5?=
 =?utf-8?B?dnoxVVZnVHBwMVlmSW56T0lMb0pWajN2YS9sT1JZRjNYZG5NK0FIRTZxT2xl?=
 =?utf-8?B?MlpXS3hSL1VKRlc4U3pLK2FvRGRIVmljTjE5NzloZEcrRFNzZEpyVmh0L1F6?=
 =?utf-8?B?ZlN2SUNjajlXMHMwZFg2VXJpWWNIdXlsTHVnQXZKbS9kL21JbUlSN1dENlZV?=
 =?utf-8?B?Z1R3RjhxVkhkaHB3SS9WeS95QlpRbitaRGRYRzFuK3psc2IySDRCT25TQzlG?=
 =?utf-8?B?UTJEdit1YUZWakw5a1RLZGlNSGx5TlRsNVlzZS9GcUZNNTVpc3F2dnRFTWlD?=
 =?utf-8?B?azhiM21yM053c0NUMWJoYTRPc1JFOXFJRFpraW1Dck9QcFhyaWx2ZTBYL2ZU?=
 =?utf-8?B?VEhwSEtpTEE1b2RJQ3U4RG03eFJjYXBXWjEzanJyTHE3bktNUzVMQ0VtdkpL?=
 =?utf-8?B?Wk5TY3RpRWh5NU5qeUgvOWR4VlBkRnNDSUNvT3lEY1Y5T0tlQXp1RHJwUGxH?=
 =?utf-8?B?cDJNMElvUThoNFVyVEZxZ09WMC9wSm5TMyt0dDdvZUlBS1V2MWpvcVNleERV?=
 =?utf-8?B?MXVQZFR2d1BMdnVnWkl2bi9XZXdMVDkweGdUakdKeHVaUkdESHlxRlhqQkNs?=
 =?utf-8?B?SmFWTWJzZnNwRnhOaFZWbWtvV3RJSTZWa2YzY2tVMG9KL0JsQmxrR2tEU0h4?=
 =?utf-8?B?MWJ1TWVPdlY2bGkrakUwRzRDUDlLVWRydGxjeXhSS1dDSEI2dmd5dVE0SmJ1?=
 =?utf-8?B?NkdrL3RnZ083c0ZwUTZMWFppL1QyWHRaQ1ZNNTFieXFzSDZDRE9PdjhiekdE?=
 =?utf-8?B?bGtLYUV6UmFwcEUzSUc2NlBneER1b1l2M3lXM0NtVi83K05tUUNXVWR0azEw?=
 =?utf-8?B?cnFTdFYrdmRsZjFUL21rcXF6RGlqUTBLSWlZOTVxUzZjRXJqT3A4eWZBWmxH?=
 =?utf-8?B?djU1OWozNXJ6MmhhYmFySmdQQ3VFZGZJMzh5UDdPSkx4bndiZExrZVZDWWR0?=
 =?utf-8?B?OFNFbjVlTkg1SkdMK2o2UlVWV25UM1A3Z2RSc0dQcGtlUm5RU3hudmxIclhI?=
 =?utf-8?B?OXJHZ2V3VytuOU5RdGljZ0kxYmU1V3c2cCtjZ0N3bjBkdFZrU2JXZXFWUzlJ?=
 =?utf-8?B?SDdRdlNrK00yVGdBYUFvOEU2UkphbXZYOGlFaVhXTVdDb1Q3RXg1MjlYTmZi?=
 =?utf-8?B?SHNLS2lPTWxqcUtpaWowNkwrK2lGV0krUUdMT3Z4SjBSaWpkMi82QmZGeC82?=
 =?utf-8?B?L1FubXR3bXhKMy8reXgzL3FVOGkzbHg0T2s2UDJqb3FxVml6bTlZaHdKSE5Z?=
 =?utf-8?B?UE1pUlBiQ3VULzZrYWgrNENzYXBHVUEyOW9UNTI1Wkxvc0dZVENMR0cyVlFF?=
 =?utf-8?B?amVlYTA2eXdLZENUVW0ydDZxaFhlUFhpMFFMYXNTaS9TN1JPek56MDdUektp?=
 =?utf-8?B?WHZjaWtoaXdSY3Y4WWZUT1FxUlYrZnhmK3o2ODVPYytvRktFOXMvWGtRa0hJ?=
 =?utf-8?B?cXROQUJ6QW9ZdWM2YWsxQ1RoQXZvdlgxVkRseVMyWmNYa1k3dUFtTm9mN010?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00edfee-24a5-4291-0e87-08de3ef170bc
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 11:26:23.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcKhxOLABtANGI+b/xPYtnE5WW3WoBimNiOfZfqsNrBAcZtg9O+4imLUWqiLTYYlWVsOd0+KCZCJoVh/rm/E3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9114

Hi,

On 18/12/2025 15:41, Nuno Sá wrote:
> On Wed, 2025-12-17 at 13:44 +0200, Tomas Melin wrote:
>> [resend, I think there was some problem with my first reply]
>>
>> Hi,
>>
>> On 17/12/2025 11:26, Nuno Sá wrote:
>>> On Tue, 2025-12-16 at 15:39 +0000, Tomas Melin wrote:
> 
> The above is indeed cumbersome. I guess dummy is not what we would need but something
> like a fixed-backend that would implement all the ops in a dummy way. But that does not
> make much sense and doesn't really scale.
> 
> I think my main complain is also that then we should add a devm_backend_get_optional() to make
> the intent clear but unfortunately this driver is not the best candidate for that.
> 
> Anyways, I still don't love the idea of just ignoring it (given that some HW is indeed present)
> but yeah. Not going to nack it either.

Good that you still see the optional backend as feasible. I will tune
the implementation in next version according to discussion in our other
thread and other possible feeback that comes up. I'm confident we can
find a solution that will work out nicely.

Thanks,
Tomas


> 
> - Nuno Sá
> 


