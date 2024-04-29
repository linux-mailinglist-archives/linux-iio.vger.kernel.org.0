Return-Path: <linux-iio+bounces-4613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3418B516B
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 08:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03401C212B1
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 06:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B0A10A3B;
	Mon, 29 Apr 2024 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XOnUFC5j"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3BDDB1
	for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372154; cv=fail; b=HDRIi2S8NmeELjvDRCS/A1IM4h9ITW6Y2rNPHCDFuinpuNob7SrSeMoNG8WOzUcH8K5tqVx5LlROjmgt/Dd13F8kygGE6oszq2gNgBqWKA/u0HNKo0oFpXnlpg5ZhLYZqj6Tw/2uCjOqB9I7N0Gto+1ihYhPNR3sl7OentEJqm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372154; c=relaxed/simple;
	bh=2ZrKp8KPUUIJA8XoFshYxfRVy8a1qDrGRsK852HF/kw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DYtONJlOn6T/7lrMxGBAM6XPl0sZ63nwe9tDADHduWh6Sv1qV0/CQ02xAjIsZJYzyq0mipsM1OJJUgMRGtuWYGe5jTd0r1PRc6A2ioMZIHJHRbseJdKIZijomRztIAquFWD/0pxU6EiijVOgimmDaUS8aXmZbUj/fzG5qSqJnsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XOnUFC5j; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko0WQiEWx3nsw4UU78YJ4evo1or8qQhB83+4Yv2kdKX7yEHgj6s9UOf+xOkvg8Y6hi0v8R2n2YPWLH/rh49x38CT8XF3SPRZOuFH4xcoRP0OQOZVWD1dZ2eLS6YsLNmdf92sC8EkgWKM1NsxgZnw6QIKESP6H2fgCk6bB2VLePbCPEo54JyPFRn0YRoaN4QZqKugf767fAXpHIciO5MoskRDXydVxG774WDNYak+ah8yU8Ibvm6t5foP5hwKlmL3+9LTH+B1oWbY7Gn/unxEGAR4ids2OwZUyw0Kh08jxPVNfLY7c4bQ0VFfssgDEtLLTan+BwVFHjhu9qbswZmp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAVQopQf3CcLiXVpZMYbdmg5LCZUX+ZhpMrlmfeYLTA=;
 b=BLpvaXEzm/IedwjOZK2uIal0/EmxHpR3/abPiITvi35Y8fVqh2lAzUotxVrmKqoGcZqLWktGI6Y2N8EFNVB91wA6QP1DIk/dxjptN2yqP4tPIffGPuRu7wGV1nDgFiUaDH1j/Wtm7Z7R+5ix1K2JJtO2RljrCxHtZVsQ+oKkE1/0SY+R/3dxYbNmz3iRxFru36upN+IyYbU2FkPS45czBZMQIwB0PwzX/PmoqAWhrikL02v7QCWKbqms0CAO9tbYk9axPEYD7anaNlPTyPqVUFDGyaszTlzrHCS9omIfIP1xrOVc7+5XZW4Y9reWdxXnQyRsGzAS3Wp1BFreh0udgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAVQopQf3CcLiXVpZMYbdmg5LCZUX+ZhpMrlmfeYLTA=;
 b=XOnUFC5jvvR8nYyJzOWmVtTJantHxTDU+V7uQdCLbrCbgEDEJW4YzGdf2fVkNlVHf/aGFklIGuUlRDqpdCz4UWK+azsrRBZ9SFFxFLWkHzToweEZwLV8VGl+xsiM36/p+04jnfDzTsG0fd6ruzaACvP44/ouF/jeeVIZTGcJip0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 06:29:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:29:10 +0000
Message-ID: <03a2d7e2-7feb-4b36-bd48-7a83a75cf118@amd.com>
Date: Mon, 29 Apr 2024 08:28:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: xilinx-ams: Use
 device_for_each_child_node_scoped()
To: Jonathan Cameron <jic23@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Pedro Mariano <pedro.mariano@usp.br>, anand.ashok.dumbre@xilinx.com,
 Roberto Bolgheroni <robertobolgheroni@usp.br>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240424225302.47004-1-pedro.mariano@usp.br>
 <ZizBndYiU5GVUtmQ@debian-BULLSEYE-live-builder-AMD64>
 <20240428171725.5c24b858@jic23-huawei>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240428171725.5c24b858@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0227.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f1b59d-c3f8-46f3-2b7b-08dc6815adb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjhIQXB5blpFSXE4TUdrY0l4YXZLbktVVkRoQ3FKQ3BnRllvdUF2Q2NxenpO?=
 =?utf-8?B?ZVNRSm80WkpMaHpmaFNnZmZYUThzUjIrUnV1ZThkWGlRa1J1dkZOWDA1Mmdx?=
 =?utf-8?B?bGdhZ1J6cjhkY1JxamtKRVZGMG5rM1VLSHZWMWJYMElVYktDRWt6UkVBVWcr?=
 =?utf-8?B?T2lLby9CV1p1dkVVekhjQ3BRYmc5K2JtR0U3Sk1GSUIzUjV0Kys3aFY2cjV5?=
 =?utf-8?B?eHF1ckJzTERkN25Zb2dhNDNhNjVoYlh0ekl2THlyWWx3WnRyR2xXeXVSNkFX?=
 =?utf-8?B?MEFkSnBJakZzUndZTUkwRDg4MWRCSDhJMVhBekZiYUd0ck90RkRJOTR4ZFRz?=
 =?utf-8?B?T1hFRkV4ZWJtQkRFMGlCVkRwQlZCK3B1bVhlU29CTjN5cUcxWnBDMVZlL1lP?=
 =?utf-8?B?RGd2eUs2NFc0VUtMbmR2VUlTeWVlSjFXS21hTVI1b3Z5OFIwd2NFYVlCQUZF?=
 =?utf-8?B?Uk1OUHFoN3A4UTZ6K25Mczc1UnpwbDEzU0ZYNmYrZHFUN0ExQ2pEeGtpKzgy?=
 =?utf-8?B?RFk0TmJ6RFRpWGFBbGYvZXdiRS91WlVxR2p6YURVRloyUjJoZ1VwbFUxc1E4?=
 =?utf-8?B?Zkl5Zm5OYW5wVmk1Uk9UQ045VXUvdUVCNW1adWY4M0lQK1MrYVc1dmpWKzl0?=
 =?utf-8?B?TXpzL0RuSFdMRUVtYkdJcGY2MHU2K0FpQXgzNkwvY0x5MFRqVjdzNE9DMXlY?=
 =?utf-8?B?bzhpTVRFdTFZbmxFbmt3Nmw3dFB6anU1Z0c2UFcyMkE3NG1qYlFNNlRMeEJl?=
 =?utf-8?B?UWlLckk5VjY0SzRqOU5Tc01PUXRBRGswaHBWMzZ0N2UxNWo2VEVDQWVveGlK?=
 =?utf-8?B?Tjg2TElmVmljclJOOS9YYS9YY3V3UFpDd2hXZWtxYktBSHJFdDZOTkxxTHRP?=
 =?utf-8?B?V2U5MGZnZEdDV1VFU29DWFdwK2ZDQlZ3NG5scllhNkx1VHp3aldHbFg0by9y?=
 =?utf-8?B?UHIwWlBwRzZuemZaOHBGNkhSbzZYd2ltUHI3NGptWERKYVE0NGI2bktuSDA5?=
 =?utf-8?B?S3pQRzRTK3V0eUk0YWdnWXpvR0RseFBHbVk4YmowT2ZNWU9ObDZ3Nk9jRDMw?=
 =?utf-8?B?cEFXa0pPRUgxZmxjM2ZEelBVYk1RRXNZT0pKQjBtNXRoVXkzVk1IdWZ2TDRm?=
 =?utf-8?B?U0JLcExYZUlLRnp0WFkzZW9VTUltWHZjcDZxT2oyaElEQ2ZFLzgxa3NBRWZC?=
 =?utf-8?B?YnpLT3dtVnNzaGFqWE1yaktXMC9jb0J0alVVTGhuSjJIYU1MVWlxa3RtS0wy?=
 =?utf-8?B?ZGI1RHNYeEVGZVRnZWIxaFhiNDF1TWVLdlM0MWZTb3FpbEdMZXBhdGRwblln?=
 =?utf-8?B?L0pwY3NlZ1daVmZ3OWZtUHQyc2hmVGxtVm5uNy9FdnBRQnFwUG5kMVRwd2Va?=
 =?utf-8?B?UlVEd3dybkYvNjVPcnoyZzhUejd5akEzK1U1NTVNLzhJVzUyTjhGaDNRVnht?=
 =?utf-8?B?ellPZlg0Nld4MWJyeWo1aXd4SFVCdC9oN2UyNlVWTTJwZEkrbDBSSVl0eDZn?=
 =?utf-8?B?NDIxRG5CVVZZcXM2UUpHcFkvVU5FM0ZsaHpRYVhrdlh5MHozeWVqVXRRdTcy?=
 =?utf-8?B?dXlxMmNhSDV1ZFA5N2NncHNFUEpGWHpqSi9tc0U4cjJPNEFxaWZQbCtrSDBh?=
 =?utf-8?B?SGZXYVBodWJhVHNweVpQd2dWbFJEakpTVjBtNWFUdjJjalNScnNiYUtVMkhP?=
 =?utf-8?B?N0JQVy9pM0k1Z3Jla0ZGUDM4RnVBSmVNcXloQ3NkeGdGTyszYlJjTy9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlppdUJQUTNUbTY0L1Y3WkFtaFhXYzRuMUNKYlZ1RHVCdmJOb0dMTGRLQXBU?=
 =?utf-8?B?U1g1THdsb2FDdEhTNVd3VDZSNFQrdHYvVk9EMjgzT0hwYXM1bVBKK3lNdVhh?=
 =?utf-8?B?a0E0MmwxNDVqaUxXTkJMNy93cTF3elFtdFprRGxIc0xkdXp5S2N4ZkdGTE9U?=
 =?utf-8?B?STNPUS9PNVdsa0JBd0Q4RTlaOFR4K2t1MWVHYXZ1aDBEclNYTWlPK1lKWThk?=
 =?utf-8?B?cnNjYlF0d3Z1SVNmSkhZTVROc0ZiMkJaWVVyVi9SK3hmMVI5T1pwcUtnTWNI?=
 =?utf-8?B?VjRvYytFejRFcE9aVTdKY0ZlcE9sY1lwVTUrL2FuZWptM0NOT2VBa0RQeDVz?=
 =?utf-8?B?R3dXcE9zRnZndndDTzY3bWJGckpZb2l4T3FqOFNQbmFXNnM1UWhOMnZBQkk1?=
 =?utf-8?B?bnFoWkMrRGh6Ym9kV3ZVWnJkQ3pEMzRyWStQaDdiRE8vckUrMmUxR0pzT2dF?=
 =?utf-8?B?c3ByZjhodTR4SVZHUTZmWHRHU0kxWWxmMXd2TmhPdXRaNHpaSmw0MnExeFkz?=
 =?utf-8?B?MmRLUk0yaFlpS0svYkt1TFljVFNJYmpxa3pudnhONGJvVjhDY2tPMTNtVkpv?=
 =?utf-8?B?cWlTNWdNZmlMa3duZzgvSkdrdEpRU002bDNrakRsaHV5SEMyU2srQlU1eEpE?=
 =?utf-8?B?QmNEeFZVWGs1ZG1nTXZJMDE4REtLOUQxZHUrYkZtbHpkVlZ3cHRSeUtrNjJj?=
 =?utf-8?B?N0MxdnVhZHBYOXV2UGVyVjFzWERwZGR3a01GQTdjZHByZTcvaVAxRDN2N0E1?=
 =?utf-8?B?Z1lGSkhxMHJ1elVzRzlpVTdpVExhU0xGZ2xzWVJ2MzV4WHErU3hzNm9maGpX?=
 =?utf-8?B?SC95STZCWUZLdmczUDROVFNpSk1LUTRwL09FSnA2WUYvNUVSUXh6NHZJRzNm?=
 =?utf-8?B?c2RmdUpvYlFCeU1IS0xORjllN2UrcjVMOGMxMm9vcFdDcDJWWnB6bVMzTDNo?=
 =?utf-8?B?cFFqaktrTW91dFdHMEljOGp4dlJCeTRMRlNmOUFkZ29SejNRYkt4bnpJK3Bm?=
 =?utf-8?B?WjVpejdZY09xZ0paNU5Fb1l5NGhTZE1oZWI5Uy9QNmlHVHNzdmdESlNiZzdO?=
 =?utf-8?B?bEFhR3F4enBjTlh1djM5RVR6NWw4cVcvR1BKMkJlRjlNdFZUakE4ME5KSnJJ?=
 =?utf-8?B?ZHQreEFPRW9uVlppOU9NWnYvcWZZVEtVSlIwZlVmMlFFcGhla01ZQmRlTm5D?=
 =?utf-8?B?NC9BQ3RHa2xYWFVsQkZiakJIeGNzZjQxK0g1NERpSkh6ZzhiVjV6eGplZGZS?=
 =?utf-8?B?UjcrZ3QzV1dDR09xb3pGUHd5c1pWWG42elpGcE5FOUtsMFcwMlZkQmNyQ3Rk?=
 =?utf-8?B?UGJjY2s3dFAvWjlkSGZKcG9xTUtCRFdZRUlLT1ozNWdLbFQxL1BvSXduVzJO?=
 =?utf-8?B?Z0QrR0pVNG1rVm5jREZNcnlkV0NHbkduNU9oSWNCMVlKRGxzU0ROVUk0U01F?=
 =?utf-8?B?Mm5GUzNHRFJROVppN21wQ3BHbko4aFVBVGxTM2lqbEFRTjBNcDVIUWZoVVBo?=
 =?utf-8?B?YVNGWlFBMmNsaEpHN3pLWDNGRDdPeG9ST0Y1T0ZsS1dCam1SSjZPY2ZCZDJO?=
 =?utf-8?B?OFE1MDJBSklhT2NEeTFnTmhTdC83b0JlMURmRXlFcC8zZGtBUFlWcHoyZmY1?=
 =?utf-8?B?a2VjZXdkUW5HK0JwNDZXeURRTTAvejQ3OEkrdWFqbG83bWZHb01vQm13WHFm?=
 =?utf-8?B?WkphOVlRSG81clVpUlJWQWJSVk9sTExMK0loSTJlSXJPQU9jNnpYWkN5UGJx?=
 =?utf-8?B?MEhBaHBMNys4b3doNzF5T0ozYkxiVGVQL3pKN1plOGNla1I4Z0hSTk0reXRC?=
 =?utf-8?B?eWo5TTkzZzBsWk8rTUt3L2dETlZQOFpJZ1BCN0E3aFFQZEhUa21wZHp6Rkh3?=
 =?utf-8?B?STFNa2lVbFRUR3VaRGRkdTRqZE1pZWFkUHlDeG1aNmJOUjZpb1BudWdSeVho?=
 =?utf-8?B?ZFF3ZGF0cEplemJZQ2lXdWdtbmhSQmNRWnBmUitiSkJLUWxDV0kvenhabmFx?=
 =?utf-8?B?YUluSTZpcGUvY2hSZDVGZFJoMnVsblJCTlNrd251SnVpTTcxcTlhNVI1Mkkv?=
 =?utf-8?B?M1RnZ2NET2VwdTc4VUZFSmVGekN1dlo3TGhxWWZRVmZ5NUNES1JLU1FWZ2xp?=
 =?utf-8?Q?srd7QlR/zcYGsopf6wOEnvOdR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f1b59d-c3f8-46f3-2b7b-08dc6815adb4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:29:10.0172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMXe1pY5fDenW8TOuRy10o1INlYP155dr0LK4UEOJDyMw8hTe04agnN827QB4gDj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239



On 4/28/24 18:17, Jonathan Cameron wrote:
> On Sat, 27 Apr 2024 06:13:01 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
>> Hi Pedro, Roberto,
>>
>> Patch looks overall good except for the _scoped() function name and arguments,
>> must have been miss-typed or miss-copied somehow.
>> Comment inline.
>>
>> Regards,
>> Marcelo
>>
>> On 04/24, Pedro Mariano wrote:
>>> Using device_for_each_child_node_scoped instead of
>>> device_for_each_child_node automatically releases the handle on early exit
>>> which reduces the chance of bugs that cause resource leaks.
>>>
>>> Co-developed-by: Roberto Bolgheroni <robertobolgheroni@usp.br>
>>> Signed-off-by: Roberto Bolgheroni <robertobolgheroni@usp.br>
>>> Signed-off-by: Pedro Mariano <pedro.mariano@usp.br>
>>> ---
>>>   drivers/iio/adc/xilinx-ams.c | 7 ++-----
>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
>>> index f0b71a122..7f5571d9d 100644
>>> --- a/drivers/iio/adc/xilinx-ams.c
>>> +++ b/drivers/iio/adc/xilinx-ams.c
>>> @@ -1261,7 +1261,6 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>>>   	struct ams *ams = iio_priv(indio_dev);
>>>   	struct iio_chan_spec *ams_channels, *dev_channels;
>>>   	struct device *dev = indio_dev->dev.parent;
>>> -	struct fwnode_handle *child = NULL;
>>>   	struct fwnode_handle *fwnode = dev_fwnode(dev);
>>>   	size_t ams_size;
>>>   	int ret, ch_cnt = 0, i, rising_off, falling_off;
>>> @@ -1283,13 +1282,11 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>>>   		num_channels += ret;
>>>   	}
>>>   
>>> -	fwnode_for_each_child_node(fwnode, child) {
>>> +	fwnode_for_each_child_node_scoped(fwnode, child) {
>> should be
>> 	device_for_each_child_node_scoped(dev, child) {
> 
> Yes, we didn't bother with a fwnode specific version of this macro because they
> aren't nearly as common.  I'm not sure why this driver didn't always use the
> device form or why it needs the fwnode_device_is_available()
> I suspect this dates back to some confusion on why there were _available variants.
> 
> Chances are this driver only cares about DT and in that case the callback used is

That's correct. We are using this driver on DT system.

Thanks,
Michal

