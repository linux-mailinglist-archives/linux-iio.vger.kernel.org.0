Return-Path: <linux-iio+bounces-16450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6448AA54092
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 03:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840A81722B3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 02:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0818C930;
	Thu,  6 Mar 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="IP/Qb4Yj"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2014.outbound.protection.outlook.com [40.92.47.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0012315C14B;
	Thu,  6 Mar 2025 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227596; cv=fail; b=HZtn/gwZqXdxbUP++I2zXcqsfiev87WPrC9uBrqxTVLo/OBdwsGk1/q7fSCsNNLE+/YdIc/SyF9/wxenbTupteKkhbTznTlgkM2UQdrC7tghFoHd9f/OdQi27ITESjk38Trr/A84wHOMj0Tr8GbeKaHrbbdZmydjvL7yMWr8iTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227596; c=relaxed/simple;
	bh=qMOCcyhnydupSHT+TSvDEgKXc8l49hDYtXKWgI7vt4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K7ocaRRxOc397UAniWoIxBkcfyDWLWqevzeYXT5ajKmxJrxDhE57G985SuYRcEcJbffnKVcwzswvEwIt8Qsrh4wzgM7oljmNscMcSezzQDDlD7SR12oANoZ2aQLseyDZ74IV8bZYv65VgliImMUvzkgV6EbTVNcWqBmSrjEW220=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=IP/Qb4Yj; arc=fail smtp.client-ip=40.92.47.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0cCUB4JZdpW2URpoAY5+QCHVOw/+8gf2X+LmJZmh1yTmqe/7S7kMzn11PrM0TRGUpbFlMql8XQYI8bs9oQgspiaZZcbJKSuWV+DzAzKVw1qj0QRPvIcmTA9mBikyjWaa6b31VC6pLFYcLlk7LYT01Gv6Z72zOmcC4MNfbGiElLNfxsCllkRBX8c2i2+E2OGCvW3R9/Z66VaDs59vIyjobG2BM8LPvgq1oWejgOLirbzChGV0yAdadBfwmNOT8N1Af1yt+5ZF/0pMCqJ5fDi8+cuCfpiOG30FWcb80jPXJWFpit5qs7497ECM/hwvPaAFg1v75vA3JbhXd0XL212DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGS+q91RgzjJg/RfmihrRbRmaQ+BceYMD0+fdl0eSso=;
 b=c6xWLbldnb6XNk3XHMKMoBUlqLCy2Z4Ov1tQMFnd+Fy5f6i2eXmSAyDXXPut3/zvwFLrCQP+1kpfdybi00FE58bGwaZ9etrzYR0t1eJt6WgtnmWXgoyDY5jbzSl1v821HbehGyT5HlaqoSptIjEk+KJwQvgUB7qHwoFMrt9Rhic/UOGGpowad1aB7slsgSxToNafMfHPgky1w+X9/OXy/5bM3P5ltglVgxIKzAZ14Gcs4XeFL0IE7kCqa5xIUPn1iBPe6MdEXy2HncCxjSwyAH8jigX8gPtI3UJhFzCKI0UOa4NzhvQvn8rAeA2k3iYRevXMmarEBFlph+L6BNvYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGS+q91RgzjJg/RfmihrRbRmaQ+BceYMD0+fdl0eSso=;
 b=IP/Qb4YjLKSxNfbSnU2qscfh/H35LaVCSJtupcW68tEFidYq9O8P7Y8TCoIyAXbbE2bBDX2M7Ku0tGLKL4bk3AHrVDkNW7AwC2zRfhJCFC2NykLnOeZHFCwRRanQMSf1deh3edgz9kT1ETL8zGZhSjZ3YxJdL54VT2GJX0d7tlgT5R+5Xxvo6PBlH/bYT8A0M73TWKONTbMNjn0hyn2FZcXawTjuUxsEevjx26U2l+ATo6dlUI6lsiU7sVxc0Z8W7WfJcJIli8Rr9kTYlqWxl397jp8sn1C0snbHE+mkGWdJaiOMaU+O5/Lno+HTlcVhrdNDjjf0Q8lgsjrzGO7gRg==
Received: from DM6PR19MB3722.namprd19.prod.outlook.com (2603:10b6:5:205::25)
 by PH0PR19MB4876.namprd19.prod.outlook.com (2603:10b6:510:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 02:19:50 +0000
Received: from DM6PR19MB3722.namprd19.prod.outlook.com
 ([fe80::bcae:8341:5687:fb8c]) by DM6PR19MB3722.namprd19.prod.outlook.com
 ([fe80::bcae:8341:5687:fb8c%4]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 02:19:50 +0000
Date: Wed, 5 Mar 2025 20:19:43 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
	andre.przywara@arm.com, lee@kernel.org, sre@kernel.org,
	lars@metafoo.de
Subject: Re: [PATCH 0/2] Fix Regression with AXP20X for 6.13-rc1
Message-ID:
 <DM6PR19MB372230C8D4D32FB780357C99A5CA2@DM6PR19MB3722.namprd19.prod.outlook.com>
References: <20241210224859.58917-1-macroalpha82@gmail.com>
 <20241211215826.06162190@jic23-huawei>
 <67606b09.050a0220.3905d.5bc7@mx.google.com>
 <CAGb2v64vn-h02Bn2AKftphpNNcx9h9K3pKvdjuANsDhwiqbsrQ@mail.gmail.com>
 <67c743e3.050a0220.327e31.55b3@mx.google.com>
 <20250304232913.020056fa@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304232913.020056fa@jic23-huawei>
X-ClientProxiedBy: MN2PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:208:120::39) To DM6PR19MB3722.namprd19.prod.outlook.com
 (2603:10b6:5:205::25)
X-Microsoft-Original-Message-ID: <Z8kGP0yGh5Rmr68V@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR19MB3722:EE_|PH0PR19MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: 0263caf6-0b9f-4601-c8b6-08dd5c555eea
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|6090799003|19110799003|5072599009|7092599003|15080799006|440099028|3412199025|10035399004|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkQ4U1l0OHpIR0E3dTU5SkxDVFVHdVh6STFMU2tNeVNjY2JrVUc4WDV4ajM1?=
 =?utf-8?B?L1JxQTVXdkU0bmZBeWRBNTViNzNaVHpwbS9yTzQ3MlN4STIzTnZYbzBBbnBo?=
 =?utf-8?B?TnRPVVFoYXRHTmhQQ0Y5VmxMNG9Hd2ZIMDlWVHVzL2VoeE1aZkFlS3dOS0g4?=
 =?utf-8?B?NEI1bG9KbS9idEw4YXdlbmZxYUNCOXVsWDZtVW5aVVFtTjhOVndtUTJJTkxF?=
 =?utf-8?B?cGtTcSszYnZjNEtNbW5sSC84dC9LbGU3ZG51TzhaMEU3WEtpNW1vZEVEUUFL?=
 =?utf-8?B?a1ZjT0NkcFZETlNMbzZOT2NDTGV6MFlzM0Q2dTEzcE5VbjZ3eGZNMWx1a2xB?=
 =?utf-8?B?SllQMXB0bkwzcEZlVTBFZnRDN1dxeUdRSmlkMGh2Vzc1b3VYY01TcEJpVXhj?=
 =?utf-8?B?d0Zoeit0QTlxbDg0WkNwNFdGdmNUenRDblUzR1hOMXUxdGZSc2dMei9YSjhL?=
 =?utf-8?B?dkxWK3lBcWdrTU54NUl5QXNtT2xLRXc2STRaZzdjOXh2dzZySUd4ejlKaTlo?=
 =?utf-8?B?QS93VThwd2xtYzluVkNwUE5BWldCeUVLaCt4eXVtVEc3NVdJc1I3UlZGVzRS?=
 =?utf-8?B?YkdpNGRjdkxxamVSQnQxUzFCaUZKclBiU2lTR01PTGQ0bDBRTmxqZUdrZnZN?=
 =?utf-8?B?ZjhPSHVTWnV6WitPWHhwbFJOVndwb242WThxdTRyaDR0ZE9LTXJtbVNLT2I4?=
 =?utf-8?B?Z1ZnN3FTa3E3cnh0RmFzSk95aytyY1VScFBXMHg0aW01L3VwaTFrS204dWpm?=
 =?utf-8?B?SFllV0Y3dHhTdUl3aHN1cDdPc3pseitGUW1LanVLMk5uSzZibjZGNnEyOXMr?=
 =?utf-8?B?SGJCell4aWI2YXpZMDIrZzFlcjQ5MUFlUFRkMWVBTUsySzZhbjdHVjZuTEtO?=
 =?utf-8?B?LytRNVQ3UE5yUkx2blhCVWI3MDRQT2ZBS21YQWoxV25RZFl4dU04QnRPaTBL?=
 =?utf-8?B?SkgyNm5TYm1WWnZqRmRzTmZ6d2NBMUxleWlZTC9zYXZhRzlJVDk1T0g0U0xH?=
 =?utf-8?B?ZldZSFVGM1N2Uks2c2Y0eFRJcU9OS2wvRnBqbEtBYUxVUFJWMWRpaW9CV1dS?=
 =?utf-8?B?UUZHUVB2YzlYMGJNZXdUbktpTWQyRFRaS1Z5S3JBTWJwM0ZFV2c5QTlnYXBJ?=
 =?utf-8?B?QS9OUmR0TWFzUzIzN1FQRlE0aVhSZ0R1dHp5T0xvTG9seG1QVXpSY3I0WjZs?=
 =?utf-8?B?enM5MS94TlRMTTR1bExaTjYxRUFjV3RCMWdiNDF3eUlPOEZUZzdFVm1URXVE?=
 =?utf-8?B?eUYwOXFvMG9idGFyc2ZTTDlxMCt0aE9vQXFoVnV1RW90ZVNSdCs3T1czKzU1?=
 =?utf-8?B?RkkxQlpKRHVxS1YyYlFTbVFjVFlMY0xXTTRNU1lQMFZNMDJCSFhQK3RYa3Vz?=
 =?utf-8?B?RzRKa0diZ01uMm1WMXJDaUUrZ0NFWWRtMm1Udm8zWnVDS0NmZ2poRTF2cEtQ?=
 =?utf-8?B?cUk3blZtZlNjanlqUU8xTFg5SDIrWlRhSUFHbTVRUysvNFQybU54a1JZRUx3?=
 =?utf-8?B?MnhobjQxSldEdU5nL1YvUDJxUVV6T1BmczZoUkZkbmlLQ09FUVFNazZsUWRm?=
 =?utf-8?Q?w02gz6Ath5/BJtJU1rVtqqOfNXNlaJKK4VA3eYayrRDV3M?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE13MkhMQXY3dUtocTRYb0lnd1RTTURkaG85cm9BTjFLN285Z2pqUWlNUG5Z?=
 =?utf-8?B?WUZKdHFiZjVnY2YyTGp1NnNoYllHK2ZTcDBNNDdUNnNFNnBYOHdKRzJPdnVl?=
 =?utf-8?B?Q1pmUXJsTFRhZzgwNTBFRjZSZklleUlkR0pKSzlpeGM0NFg3eEdWUE9NQ05D?=
 =?utf-8?B?NUZxUkhEbHZJOGk0Q1BEb1JJMTJPQlVLMGpSOGNaSWpXSDNlbVJwNnczTU5K?=
 =?utf-8?B?dzExTXl1UE05Rk8xYjB4RTcvRVVxZ3pEM3pSVkVFbVk1bm1Jby9reUhzQnQx?=
 =?utf-8?B?YkZxUkxSbzV2Zy9OSGhrSzJYYmZPOGFSVENqR1dMUUg3VFVzT3JGM0dqRzJn?=
 =?utf-8?B?UVFWOE5tb28yUXRwUmRCMmgxb0xDYW92T2YwY1RYem9jbmNIWlVSYnBMc1du?=
 =?utf-8?B?eVBHL0FWQ0Uxd3g2Q2llcUM2bUhNYlpOck9CWmtXNTNraWIyNW0yb2xKVDIy?=
 =?utf-8?B?WXJicjdoL0NEaDE0MUZSak1LcVAzcFU1eXdvb2ZwQysrUEgzRlFZZUdkRC9n?=
 =?utf-8?B?NXkzdkcyakZkeDhJNHFHaCtlRGVZY0tidnVhcVJEaHpMclBqaXJZTmoyMDUr?=
 =?utf-8?B?UnNsVGV0aDJvQkh4TDNaRHFLcU9FN3RMQmQrenFVNkZteUxjdUxiYWFCUVcz?=
 =?utf-8?B?OEg1OENWQmMydWdJT0RyZzRtZVQrMlA3SGNzYStBSXJoN21KemRuc3cwZkt1?=
 =?utf-8?B?ZGtJNk9uSE5hMmN3b0pRVkV0dTZjN3ZLN3FUVENJMGxHN2hsV2l4bVhJeDkx?=
 =?utf-8?B?TnRQeDVJb1FwdXNnT2xFSE9OOW1mZ0dQNisrUXVRVXFxdWJsSlBVRUFkSGJi?=
 =?utf-8?B?bXpsWXRIL20valhYekc2bHFobDcyZ0hpanR2MUZnNExqTHhGdElIVUQxd21j?=
 =?utf-8?B?ZStOTjd0QkkrcVI5TVRTV2dHUmh5bUhtdU1jN2tVTWsvSEtxNVdKWmtSU08y?=
 =?utf-8?B?RW9GaU5XUGZuaC8rSUQ4emZPaW9SNjRKOXpPNHJWcDZKY3FuOERXT1V1QWZm?=
 =?utf-8?B?UE5oc3ZFT3JjWkdERkJnVzVhbm4yUzVwaEIrOExMTVRKYVc1dW1ITUtsSXkv?=
 =?utf-8?B?b3kwNGNaRzA5MzA4bzRUY3loMmhYZVQ4SkRXRkJTMWJNcHlERU9RNTdLWVVH?=
 =?utf-8?B?QlNJMUF4ajJFNFBqZDVYMGhpVEdWOUdKdmhXcXY2TGhvUFhBVlBsK1VhZ0Ew?=
 =?utf-8?B?Y3I1RUI4S2MySXZWOU8zbDY2c3ZwNldIQVIrZTlzYTM0ZGE4cVNGM2dKWW95?=
 =?utf-8?B?QlF4MEJjREF1eG9jNUpNTGswY2dzZWNCb1Qrb1RBQkc3dkJVSkc4MloxbnR3?=
 =?utf-8?B?ZWJUTTVDQmxvT3d6OUt1M2djSXY2VHhjY1lmSitxbWpZTHZnOWVTUU85ZjlH?=
 =?utf-8?B?YU15a0t2VjYzVE1ueWRXajdsM2YxRDNWUFd6bzRNT2szNlRNcEVvMDRBR1Fi?=
 =?utf-8?B?dld1UmhPSFdnazJLKzF0K0dGaFE1YXZiRTFGcThKL091Rk9zUUNQenNld1Yr?=
 =?utf-8?B?NXVqNTBOYVVjMmNvbThabFZIeDVnYUFLaXBvMVczZ0ZRYzR6aTY1TGhxQXJY?=
 =?utf-8?B?YXNFZTNzbm4wbTNSWE9EVUNkSElJcFdOZXh0L29VZ2gvVEUvYnVQVGdUVXE1?=
 =?utf-8?B?ZTgrZGs4bDc1WDlQM0dZRHZyRmE4SnBWS0NXMnY1SExKNnBuNTRSOGhvOHYr?=
 =?utf-8?B?U2FWUTFOYlpXcm5oL0Y0OUNDb0ZORmY0bzExUnA3VXhMNzF4OUF5RVJ3PT0=?=
X-OriginatorOrg: sct-15-20-7741-18-msonline-outlook-c907d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0263caf6-0b9f-4601-c8b6-08dd5c555eea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3722.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 02:19:49.9672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4876

On Tue, Mar 04, 2025 at 11:29:13PM +0000, Jonathan Cameron wrote:
> On Tue, 4 Mar 2025 12:18:10 -0600
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > On Tue, Dec 17, 2024 at 02:04:37AM +0800, Chen-Yu Tsai wrote:
> > > On Tue, Dec 17, 2024 at 2:01 AM Chris Morgan <macroalpha82@gmail.com> wrote:  
> > > >
> > > > On Wed, Dec 11, 2024 at 09:58:26PM +0000, Jonathan Cameron wrote:  
> > > > > On Tue, 10 Dec 2024 16:48:57 -0600
> > > > > Chris Morgan <macroalpha82@gmail.com> wrote:
> > > > >  
> > > > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > > >
> > > > > > After performing a git bisect, I identified a commit that broke the
> > > > > > battery and charger driver for my AXP717 PMIC. This was caused by
> > > > > > commit e37ec3218870 ("mfd: axp20x: Allow multiple regulators").
> > > > > >
> > > > > > After digging into it, it appears when mfd_add_devices was called with
> > > > > > a platform ID of PLATFORM_DEVID_NONE, the devm_iio_channel_get() call
> > > > > > made by the various AXP20X power drivers would not be able to generate
> > > > > > a dev_name(dev) for some reason, and the iio_channel_get() call used in
> > > > > > the devm_ helper would fall back to making a iio_channel_get_sys()
> > > > > > call. After the platform ID was updated, now iio_channel_get() is no
> > > > > > longer falling back to iio_channel_get_sys(). At least this is my
> > > > > > limited understanding of what happened.  
> > > > >
> > > > > The dev_name(dev) not getting a name doesn't sound quite right to me.
> > > > >
> > > > > Time to look at the ancient creaking ghost that is the iio_map handling.
> > > > >
> > > > > struct iio_channel *iio_channel_get(struct device *dev,
> > > > >                                   const char *channel_name)
> > > > > {
> > > > >       const char *name = dev ? dev_name(dev) : NULL;
> > > > >       struct iio_channel *channel;
> > > > >
> > > > >       if (dev) {
> > > > >               channel = fwnode_iio_channel_get_by_name(dev_fwnode(dev),
> > > > >                                                        channel_name);
> > > > >               if (!IS_ERR(channel) || PTR_ERR(channel) != -ENODEV)
> > > > >                       return channel;
> > > > >       }
> > > > >
> > > > >       return iio_channel_get_sys(name, channel_name);
> > > > > }
> > > > > EXPORT_SYMBOL_GPL(iio_channel_get);
> > > > >
> > > > > We didn't invent the relevant phandle stuff in DT via the patch you point at
> > > > > so all that matters is what gets passed to that iio_channel_get_sys()
> > > > >
> > > > > So key here is that dev should be set, so we are passing dev_name(dev) into
> > > > > iio_channel_get_sys()
> > > > > I'm guessing that changed...
> > > > >
> > > > > Ah.  The iio_maps in
> > > > > https://elixir.bootlin.com/linux/v6.12.4/source/drivers/iio/adc/axp20x_adc.c#L158
> > > > > are our problem. Those hardcode the consumer_dev name. The fix just changed
> > > > > those names. Back when this infrastructure was written we were in the world of
> > > > > board files, so everything was hard coded in them - or in an MFD like this
> > > > > it was treated as a singleton device.
> > > > >
> > > > > So as to how to fix it... Assuming the new device names are the same for all
> > > > > the mfd parts that make up each pmic, then you should be able to figure out the
> > > > >  extra the number and build the channel maps to allow you to find the numbered
> > > > > devices.  
> > > >
> > > > Is there a way to figure out the device number at runtime? The issue is
> > > > each time the device attempts to probe and fails, the device number
> > > > increments, making it a "hitting a moving target" problem.  
> > > 
> > > The ADC device is a mfd cell or child device of the PMIC mfd device.
> > > So you should be able to use dev->parent to get it directly? We do
> > > that at least for the regulator driver.  
> > 
> > Sorry to dig up such an old thread. I'm taking a look at this one again
> > and can confirm passing pdev->dev.parent to devm_iio_channel_get() is
> > insufficient to get the driver to find the correct ADC channel. Would
> > there be another/better way to do this other than the
> > devm_iio_channel_get_sys() as proposed? Or should we be walking the
> > parent somehow looking for the named ADC channel on each child device
> > (which would also require a new symbol most likely)?
> 
> Hi Chris
> 
> From what I recall the point was to get the number from pdev->dev.parent
> rather than simply passing it to the devm_iio_channel_get() call.
> 
> That should allow building of channel maps that provide the correct
> device name to allow the provider to be found.
> 
> Jonathan

I don't suppose you have a few more tips, do you? I'm still kind of
lost. I was able to crawl the parent node until I gathered the correct
device struct pointer of the adc device, but even passing it to the
devm_iio_channel_get() still doesn't work. I'm thinking that maybe it's
because devm_iio_channel_get() then calls iio_channel_get() which then
calls fwnode_iio_channel_get_by_name() which then calls
__fwnode_iio_channel_get_by_name() which fails because there is no 
"io-channel-names" property in the device tree (because the driver hard
codes the channel names). Now a call to iio_channel_get_sys() would
work for me in this case, but I'm starting to wonder how it might work
if we had more than one PMIC (which is the whole point of what the
original fix and revert was trying to solve) so we might have to figure
out a more elegant solution..

Thank you,
Chris

> 
> > 
> > Thank you,
> > Chris
> > 
> > > 
> > > ChenYu
> > >   
> > > > Thank you,
> > > > Chris
> > > >  
> > > > >
> > > > > That's a lot lighter change than moving over to DT based phandles for all this.
> > > > > (which is the modern way to handle it).
> > > > >
> > > > > As a cheeky check, just edit those maps to whatever IDs you have and see
> > > > > if it works.  Probably not an upstreamable solution but will confirm we have
> > > > > it correct.
> > > > >
> > > > > Your patch works because we allow for some fuzzy matching (I can't remember
> > > > > why) that doesn't use the consumer device name.
> > > > > That works as long as there is only one instance.  I'm guessing all this
> > > > > mess came about because someone has a board with two of these devices. On such
> > > > > a board we need the precise matching including the device name.
> > > > >
> > > > > Jonathan
> > > > >  
> > > > > >
> > > > > > To fix this, I added a new devm_ helper of devm_iio_channel_get_sys()
> > > > > > that directly calls iio_channel_get_sys(), and I updated all the
> > > > > > affected drivers with the new routine. I then no longer experienced
> > > > > > any issues with the drivers on my devices.
> > > > > >
> > > > > > Chris Morgan (2):
> > > > > >   iio: core: Add devm_ API for iio_channel_get_sys
> > > > > >   power: supply: axp20x: Use devm_iio_channel_get_sys() for iio chans
> > > > > >
> > > > > >  drivers/iio/inkern.c                    | 18 ++++++++++++++++++
> > > > > >  drivers/power/supply/axp20x_ac_power.c  |  4 ++--
> > > > > >  drivers/power/supply/axp20x_battery.c   | 16 ++++++++--------
> > > > > >  drivers/power/supply/axp20x_usb_power.c |  6 +++---
> > > > > >  include/linux/iio/consumer.h            | 20 ++++++++++++++++++++
> > > > > >  5 files changed, 51 insertions(+), 13 deletions(-)
> > > > > >  
> > > > >  
> > 
> 

