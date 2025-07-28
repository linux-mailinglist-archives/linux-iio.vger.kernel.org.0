Return-Path: <linux-iio+bounces-22082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42836B13451
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 07:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D7F18950C4
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 05:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B421FF33;
	Mon, 28 Jul 2025 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fx8REQ1l"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8881ACA;
	Mon, 28 Jul 2025 05:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682092; cv=fail; b=P8HnQoOSOpp/t/JvvLsKMqoODeH3gHKSqwK+MyZfrXEwZHGtPAGF7uud9YJl2cRFw/gXriUM5+/dwXSw80AoNz82fp7S4b3BY2uKsNmRVHBSEwxqAqIC9mutUX7pN4+OpHle4wCYRvneliXM+SzZNExaCMJ/xo9MXtiyTPtyFPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682092; c=relaxed/simple;
	bh=wSoQIpFMBk2yCxsV8JHrVCXnzqXkhUvsM37M7StUXOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W4PZQ3+/PDNvY0WNMnLefwXkY6PLEDkusj1EKkWXaqyt+028yVEj7iH/78Y7QwyaTT0Vv35KXkwCOw3D52iiyrL5wt/2BCc6Ixm6dlWlNpp2HpzyVN/8vEcwAcdkeAuAzTYjbP4iuZ6IQB/+BYYT5YDr1+pMmeIUyoif4hOnFPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fx8REQ1l; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ty4rSXE/taWadZGTx/aEOoZosNgfE51c3H6JeRVXRQVKj8cysC6gbdSPFQyWJBTHBnp1PVHdJF26TjZB8w5IVOku4ESZxlNvRTpvwADz4F5TeueVpIUDRM89yyVUc9NSJchyHx46/gANEyXsZANMNTyUV9yASLO+Yfs9dA29F9qYCrLab5AqdGc4t0T2FIWWHAZ2i3p3bVLLB5kZ8paHM/3lIjVmtChyKhb5AsGMNvzBWTMd5JtrvhxY1n634/VdXiQMt4tEIW17PYcebakPg5enCmZuZUQnyDYpJpW54wsT89C9WLzljW9nCmj4/2uQdrWzfIF73/GQeUlkjkfoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRWIl4WTUcpg5usnpECUWWp5hY4BfDRJQBenxLHUQP8=;
 b=NHzmzrWiwFI0eISTwUlAxifFmLHYHyN/AeblGYN55tcxcGPZgUtLb1CRbQJfosxDRWG9ocCMzH95fiNI6KeFWahSxDA0VcdlkkDiL+E0yjOgGJA0WZA1Eyo4Fh9/7aqak8hJyLUSdKS9wlwDknwVv4lk4tAeZakmWppeA8R73xPxz9CBiEAHe5VxEP27j0zJocDEoytG3wh1nDbz7JxME5jYvF+jehE45PCxqUmA1G9IMzhqpgdIDKtITShaQzIydshWIS1E3MisxsRHXBPhXE1idnKkRsV9Jt0pXSDFA1kHF0SyjxvXPyE3myWtmjpsHh16ajyPelHbacwjS5a2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRWIl4WTUcpg5usnpECUWWp5hY4BfDRJQBenxLHUQP8=;
 b=fx8REQ1lXvpvHRa2DEbD4ccnYWqQJL4yU1jFhW+vGvaM434B3U3D8DgXXSBGocPjVfbPTPxHWw+fsC5KNEmd1LH5078rtgF6zNadFK/AtRLzuTGPceE3TM9x3b1hkmfpAQahvrQd/SlhjvpQL5bXu0GX/IgZkeGuAoyEANLGsj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 05:54:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 05:54:48 +0000
Message-ID: <69a99252-4f1e-4197-8914-a6fc1c6c7027@amd.com>
Date: Mon, 28 Jul 2025 07:54:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: xilinx-ams: Unmask interrupts after updating alarms
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, Salih Erim <salih.erim@amd.com>,
 "O'Griofa, Conall" <conall.ogriofa@amd.com>,
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 linux-arm-kernel@lists.infradead.org, Andy Shevchenko <andy@kernel.org>,
 Manish Narani <manish.narani@xilinx.com>, linux-kernel@vger.kernel.org
References: <20250715002847.2035228-1-sean.anderson@linux.dev>
 <20250724163219.0098ced6@jic23-huawei>
 <3a77d5db-eeb4-43df-9de0-e6bafea4d9ea@amd.com>
 <20250727164336.385dda93@jic23-huawei>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250727164336.385dda93@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bcfe08-a443-4544-12d0-08ddcd9b429a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzE3QWpsN1dINUVPTXlTT1NhQkVQeUFDd2pzaWRRQkRUcHVvUzhab0JCZ094?=
 =?utf-8?B?S3dRaGJQb3dTbHc0eVluNm15K0syOS9ydCtRSVpoc1oyVms3NlBNdEVBblFT?=
 =?utf-8?B?bnVqUHJwY1plTW4vOW5BMnRaS2I2TDJyWHN2Y3hQSitDOEpNTmMxVlpsSk91?=
 =?utf-8?B?ckNaYkFxeEkvQ3dsVWtpOW5HN1ZKUFdWRzJxeVhVcGtBN1lzUWxET2FBTGp3?=
 =?utf-8?B?cldvYWJyQnZUcjdnOGs4dkxBcjhuN2hIZ0lZRzBQakpsM1AyT0xUZFdlVDIw?=
 =?utf-8?B?Y1lKM3VvVXZqSDc3bEthdFdJeWN3UVlKUC9aRTNRT0VQdFV0WVMvc0M2MHVn?=
 =?utf-8?B?WDd6RENERXlRM1VPOU91S1F5RzRoaGViS3R2K0kxSC9CWmorQXAxaVlQLzZD?=
 =?utf-8?B?K0hPcFZrbEg1bi9MMjZCd1R0OThZTkFReGdHbkMzTUhSN0lmem9OQUhZMGhF?=
 =?utf-8?B?d1BqZGhDa1ZRUVgzUkVjNFFjWmlLWkIydHRyVXBWVCtCd0FXQzNTbmlGWGY0?=
 =?utf-8?B?VnVJcHZJQWJCQXNFRFBHMFEwM0RhMDZNcVM4VWVaT2JBbzFoVGxncW1MTyt6?=
 =?utf-8?B?NGZQOGVnMWM4Ny9SQXZRd2l0dUdzazhCUGRXZlNBOHFsRHNOcDJOMEVFZUdJ?=
 =?utf-8?B?SHF6QmdwaGI5WmhPKzROdDZlZDBRQTZyUmRpcmZ6dUxDOFdXZklsUTZ4cGJW?=
 =?utf-8?B?MzJ3SUhodlZnUlNyeGRNOVoxV1lHeUltYnpOZU1vTUx0R2RDN2pqRmVxSWlB?=
 =?utf-8?B?bnVteGhlaTgvTXpJQUN3R3pabXM4UTdxR2FsMzFCOWhMVmlrOXZFRlZXNmo4?=
 =?utf-8?B?MDJmay9hOTZjOVUwWFlCTFFVeXd3WkZ2YVU3c1pxNEZjai9YVjBaUUR0cWh4?=
 =?utf-8?B?c3ZpYUMvRjdBUCtQQnFWNmRWRzhhSk5CUVhERGZOcWFsYUovdG1vTHJCT1ZR?=
 =?utf-8?B?MGpJTFE4Q0U0eENmazZ0R3ZQYk9CaWVZb2ozMjJWRU5aOVFQVzdrSkJjazFU?=
 =?utf-8?B?djk1MzhHQUUybXl6MUVsclp2OXB1b1hUT2VDQVc1NXlnekw2R0pmVGx3Vm1M?=
 =?utf-8?B?Y21ReFh5dnZCU25wWnJUeUY4Tkpyc2ZzVlR3NFdneU9ZbXFTOFRkQmxkRWV6?=
 =?utf-8?B?Y2tVN3Zncm4wb1RKQTh4bDRiaDhVSXRCeDVsd3lwaTBzNzhiRnRHcUFsTzls?=
 =?utf-8?B?LzhtQStzYm1nT0djdGVONnp3N2JiVWs5TnNUbnA4d0NjeDJBL3hmVjU2UmNr?=
 =?utf-8?B?WkU3MFZVK21wOThJclRtRDVRNlpYNEdpMkpmVFBXZFYrcWdaZHJLWmpRZklL?=
 =?utf-8?B?VGNrekRyeDd1WGd5SVdnTmNLQUFicndxa3Q5NjNZdmZKYTBkRmN2eFFsNUZW?=
 =?utf-8?B?UkY3RkxJWVhJczZnVXV6SnZMd0d2czVZWndJdm9ad2x4MDJTZFJ3SEpLajVW?=
 =?utf-8?B?R04wTUhLeFhpMjBzZ050NHNTZ3ZiZ0xFY25sQU9EY3V6MzJZblZhZUpxVTU3?=
 =?utf-8?B?VUplR2h5Zys2bGdweGpqanJ5Ylc5YjlsQS9SZGh4NEQ1ZlM0czR3TWhYcTNn?=
 =?utf-8?B?am1idDN6SzZWTWp4MVJJaXdpa3dpRlA1bG56QmdnR28wd29RM091ZVJkak1N?=
 =?utf-8?B?dzZuejF2cDJ3WXJsZTZXanBxbGZxK0g5aEkxL24yRE9ZTnpuWHJkbGtmVDNO?=
 =?utf-8?B?bGlMOUQyd0krL2UrVTZTYWlzTXliZ0hPbDRnd2M0ajJPRFN3dmxZQmxmVzVY?=
 =?utf-8?B?eUR0cjRITEpReDNhcVN4SHMwUWFBQjEvUzhOaTlhMWp0WHU4SW02N3cxNTRm?=
 =?utf-8?B?WFJIUndYVm93NlRIUGFZSDc5eWc4RWFKaVo1QjNsMnhjWkFZM2tFcHVmQzBa?=
 =?utf-8?B?S0JzUXpENU5jTGc0WEJsMU1xcnBpM3hkRVN5MGcwUUZkakE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVYvUHNuMjl5RVpZa1dMTllVd1FiQ2JVUG9iSmlJbnR0WGNCeDBrU3N0cGZv?=
 =?utf-8?B?RFdHamhjd1VXWWwwSDBJZkl5THpCMTdTM0hjcnNZRWdaMlZUc2FXdzhSVU0r?=
 =?utf-8?B?YjZPbzE4V3c0WDF3MnRZb3RpcWVrOWxZNnRneDJjNVlPSFkxc2F4VUpKbEpj?=
 =?utf-8?B?UjBJQVdrenNLTjVvV3RjYllJUURUMjBLdjcvck9VV3FDMmxDaGd2cGZQbjlp?=
 =?utf-8?B?NjJwUkRQbU83OC9WYUJCSENmZ1NPZS94b2pzRTdjaDlFU3BLL3BRVDdIdWd3?=
 =?utf-8?B?ejFGTE5KRzRtSHlGMmhWaEFwMjcva1V1WTcwUWlzeW9yRVZKMUFUM3REZG5j?=
 =?utf-8?B?WDNab0o2OVRaNG5HdUUwMTgxWHkrai9oQmNaRFVMWjZvRnk2dGdUVXBiZ3JJ?=
 =?utf-8?B?L1p5YzB5bnVOcDQ5V1k1UTFtcFFCb2NvanRhaGlzSU95d1VINDBsYXRydkN5?=
 =?utf-8?B?UFE0T3hiZjg0akNqVWRSQnhpcWVNbm9URWpscnhXb2lQVnhMKzFWK0RyenFB?=
 =?utf-8?B?U0lNeGM1N1duU0FESzdIZFFQd09tMU5UYlR1a0xDUDExaTNOMzJpTFZNYU4w?=
 =?utf-8?B?VUt1NlFoWFhQckE3cEVla0h2aXQ0bVgxSE1rV1Z1UldNbWc0RFRnSFRJMzNT?=
 =?utf-8?B?WWxGNEhwOXVvMG1QSXVsUmNMakhyakQyQk9MemZjZTJ6a2hzSkNEcHJQUFVF?=
 =?utf-8?B?OVVyd2txRmExbXN3YTg3Yk9oYmxweFluUEphYlBCczNUWlozM1Vrc2w1U09N?=
 =?utf-8?B?Wk80dHQwQ1lEQkNhOTNSdWVGYmEvK0VraytqSksyeXdmQUJZM1JteDNXdndV?=
 =?utf-8?B?S20xUGl3bkpieEExZEEvMjBscTY2ZVovQ1dRdHZBUGdvNXdUTVhNSzE3cGtq?=
 =?utf-8?B?S2d2Njdnd0dPVFdnMG5ndlJQclEyNHdmSzgvNzFrdnpWV2ZXeGxSMEMwVG9F?=
 =?utf-8?B?aVR0M0JvcEdKb1hkTlMxVUdnLytqdEUyWWF3ZHU2NlBlUXorN3puUkR0TTlq?=
 =?utf-8?B?Q2tFL1FNL3ovcWxSazExVTdUbVp4MTRBZVphSnJ2MXlNamVTYXIvZlJUc1FJ?=
 =?utf-8?B?QjhPOWcyVjArTmF5S0VPT1o2Tk00K2RlVTQ3UXhCQkhIbmppRUZGZ000NjFT?=
 =?utf-8?B?RmhtbVhGQ2dVUDFITExxMWRpeHNpT2xqdzcvOFZ1UFg4ai9TRGFkWlZobEc5?=
 =?utf-8?B?Y3pxYkdkbHQ4Q1QyWERnMTI2bnRpK2d1SGNhTGh0QU5wcm9Ocmg4RUNHYkZS?=
 =?utf-8?B?MmcwY1N4TE9LM1FyQmVtdmZENVcwL01sUjVsanVNQk4ycUpTT1RUK2I0Vy9k?=
 =?utf-8?B?SnlZWGs2MndnVHBtUWdSdFhwcDJNMUVjRWVkZGtIdG9LdG00R2ZFOFgrR2NB?=
 =?utf-8?B?b3hQd0R0YytJL2pYZnFIRi9NT3FlUXFTNlVrekFLdVpXMWdML2NJeXZSenlR?=
 =?utf-8?B?NEFNRGZvdUE1Tm1ZcW5ncDJWM29DY1FwTEVEUmM0bCtrem1zMzhEcnZzYTNI?=
 =?utf-8?B?VmRqb2lGd21tTk5sc2xMekRNT1ZnUG5Da3hwY3pmK25CZHc5WG5JZTN4OTNG?=
 =?utf-8?B?TDVoc3BUdGkxREdLcEVqTnQzK0lxVW5ES3Q2SWJVZFh6Q2tmY0JzandEdHUy?=
 =?utf-8?B?TXFZOXJmaFRySWdFRHlORVhXSXVUbHBDQ092TjlkWm5ibVB1OUVCQllBbEtw?=
 =?utf-8?B?dmVUU29iem51czVzZGFPYWpvcHJpd016N2lzN1VWSk9MNGxuK3BrdG9kdjA3?=
 =?utf-8?B?V2hHNlFWNkhkTWJEeDZVNE5aSlNMZGxtdXk2TkFxR0JpRklwaXUwdFZ2L25F?=
 =?utf-8?B?UGZOWjltb3NoY3NuVytrdUJBbUdGRmtGMmpIcFRCM3psTE96Y0xCcmE5TmxW?=
 =?utf-8?B?bkhjMDF3b2cxMFV4OUN5dGIvSFdPYU9TWnRpbHFGOHhpUVhsN21ycmNrVnZW?=
 =?utf-8?B?aGVkbTJWUnoyaUtqdFl5RktDNHlkejJ5bXpXQ250UkpuRjRhOC9XRUxtYkVi?=
 =?utf-8?B?UVdGOEZxc3k5d1g1Rk5QUVNSK3pyRDR3cTlWQW12TzJxMUJXdVJpZUIrR0Y0?=
 =?utf-8?B?RnRYZHVLenQrclJoaDlxK3BwUEFQcUZqS3dNa1BlOHFWTEh1emtTek5DMVhY?=
 =?utf-8?Q?uEV6KY16w3Ci8fWqBQ1fHvu9A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bcfe08-a443-4544-12d0-08ddcd9b429a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 05:54:48.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgZhi1cqzXU5La5zD7JCiPPzXi315lhuBr0J105OpenKqwwWUQv5OxscOzzL9005
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130



On 7/27/25 17:43, Jonathan Cameron wrote:
> On Fri, 25 Jul 2025 06:47:16 +0200
> Michal Simek <michal.simek@amd.com> wrote:
> 
>> On 7/24/25 17:32, Jonathan Cameron wrote:
>>> On Mon, 14 Jul 2025 20:28:47 -0400
>>> Sean Anderson <sean.anderson@linux.dev> wrote:
>>>    
>>>> To convert level-triggered alarms into edge-triggered IIO events, alarms
>>>> are masked when they are triggered. To ensure we catch subsequent
>>>> alarms, we then periodically poll to see if the alarm is still active.
>>>> If it isn't, we unmask it. Active but masked alarms are stored in
>>>> current_masked_alarm.
>>>>
>>>> If an active alarm is disabled, it will remain set in
>>>> current_masked_alarm until ams_unmask_worker clears it. If the alarm is
>>>> re-enabled before ams_unmask_worker runs, then it will never be cleared
>>>> from current_masked_alarm. This will prevent the alarm event from being
>>>> pushed even if the alarm is still active.
>>>>
>>>> Fix this by recalculating current_masked_alarm immediately when enabling
>>>> or disabling alarms.
>>>>
>>>> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
>>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>>> ---
>>> Anand?
>>>
>>> This seems fine to me, but I'm not that familiar with the hardware or driver.
>>
>> Anand left some time ago. Salih or Conall should be able to provide some input.
>>
>> Thanks,
>> Michal
>>
> 
> Hi Michal,
> 
> Thanks for letting me know.  Would be good to have a MAINTAINERS update patch
> to remove Anand + ideally add someone else.  If not to mark it orphaned
> (will still be covered by the top level IIO entry).

Salih: Can you please send a patch for it?

It is also covered my fragment that's why you don't need to explicitly add me there.

Thanks,
Michal




