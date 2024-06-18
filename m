Return-Path: <linux-iio+bounces-6514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2474790D860
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 18:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE22B27C6F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF329405CC;
	Tue, 18 Jun 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Q4OKTXH0"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2013.outbound.protection.outlook.com [40.92.20.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004654A35;
	Tue, 18 Jun 2024 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725032; cv=fail; b=BYCoOrCD0bdpIG37FJGAFwlftARcISWPGvg5WskjpClJQF+ISbGHaRnPylznRSGygLj5e80aa2vc68BndMGNg5lUiCJDs2f1qqLDww01ez8ZdAmyBp7mpUMrD1H4mhQsDA9fsOGWlUh/0H7NR1QBFCAWkJoabXJphJ9ORbPMOf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725032; c=relaxed/simple;
	bh=PnUBaf0/l4t9kl991tMovirhQt5uzqCDSDVv4t0VxLI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sKRFTpPb+GF9Np1DExs79dTow1KSclOW70tZRv3cxsXrjL928vh+kPatIZc7YKRCVAIdkcTZoG3tTucFV/AJtowmTZCCkMVcg+l7FZ/mWkf6c+DEiIaEvXdLfKimM7S2EpGvnObB+FKLmXrg6icSy+efpzOkvHUTgD7BVM+kr8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Q4OKTXH0; arc=fail smtp.client-ip=40.92.20.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nk01VPdQzqMyymXMv15rcAzoJ8QZmCn2dBdk/OysAOdtDOM3SHyZXH7qH7T+t8+0u8kwzMRJh/GSqJYJbJX6YXiRwQJ6i5Lwik3UkpdaL3q0nKqGvawVD0E6diVxaqfh7Zwu+glYCXanQXren6CXzDBW+THnGE4SDSEVRMkHqFHIMGLvgbU/D+s4PcJPVVQwibMiYax6ilCOC1uGGlHvmNPvP3WzrM/q5QFfNfXe0H2aOqe7Runjo8evjBHW0yq+iD3U50IyI1wvtAJbTsWYAQ9vobI3pLchKwXO1tagc5EjfFEIf3jHES2h0kRX1K79T55aGq1ivmSDnH5wytU2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7ohIHyt7kvKjjOt4LPOYz4zRFjwwtmYuSrDvt+JDVY=;
 b=VDUMgJBpGucXFA07kaSyJTF7fHz+BJdQ2+GtFn5Ye3n56rsEPLAzDxC3Hs11PGD46abFdHxMSxtfQqNAXZy5HQXNXa3iSYsYGeFxJqU/GLaZH8bnVImW3bNOn8tJh7lYMUd0DYK3u1ROvRjvs+QC21A7auI1NpMhX7zl9tAO98rqQw0g6uq1BI2EsgR18nNMuLFk9QeYWISEYfjvlTdYTSRvJ2+feNomSIO/H//QhNVRNePXd3MXO+NK0rlJsdW4WzKddDkeomJxOhwE0Iz9HMyTKzNhG+l4dVqbVPWz0mZr41Dj76UHuOrAljkIVXrVPpfgioCf33tdYxdbPuSHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7ohIHyt7kvKjjOt4LPOYz4zRFjwwtmYuSrDvt+JDVY=;
 b=Q4OKTXH0qMTx9iJDLpDwEkuBCYgM+01jHqf3yT/kzgX9AR/lETpFjBDKtxuwaOUpPhp5TCPG0dKur5vjFUnR/S8v5mjeplzMjQEOnuKb95X5iNs64G7F5wHleO/4pHtlA4b4nRtPloRcuh/tVu5l9en9UQbdSPXfwWNaOMGOOyDkdez7gBRsPYNt77QKLeDZphjI57RfvtxjJTZT/3WqaD83I/+l++pBr8lHVVLx0IqjP3znk3GZ9CUIDTEF7RWOWCK0UVzJyAqx2xdlkLTfP3f0ZIe/YTEj0kVbLN1FQZIJ20cQCB4hgehrNI750OOmaglb60TX3VAhEJMZYGhNqg==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 15:37:08 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:37:08 +0000
Message-ID:
 <SN7PR12MB81015183CA729E84E18ABAB4A4CE2@SN7PR12MB8101.namprd12.prod.outlook.com>
Date: Tue, 18 Jun 2024 23:36:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dt-bindings:iio:proximity: Add hx9023s binding
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
References: <20240616-add-tyhx-hx9023s-sensor-driver-v5-0-ebaf280bbf0e@outlook.com>
 <SN7PR12MB810142C58543160AB45D07B3A4CC2@SN7PR12MB8101.namprd12.prod.outlook.com>
 <2146cc14-dd70-4f49-9667-1564fc6a37dc@kernel.org>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@outlook.com>
In-Reply-To: <2146cc14-dd70-4f49-9667-1564fc6a37dc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [C/ppFAaBCWZ4x/5BD2PfHj9S13KqPD3wSRNIFBZ71Pd1JSKPDayfTPBAHmGds+gL]
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <2c045d33-e3b3-4aa8-8377-4f5e84f77382@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 00314d01-b3df-4953-10f7-08dc8fac837b
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|440099025|3412199022;
X-Microsoft-Antispam-Message-Info:
	ZKEX9iDbJoM8/TLZvz/5U6OiLBZAzRyRqZH0DWWHhr89JRX0C+0zrfB4GbPXPBftJA8aY1iOA0erYf/lwBSNf9g+FbDB6lxPXCRDayCxsVxKN1neKwOWseZUdkEESEm5gqyGmeITO9PJBh03X5JTCsUsH/QAJM25OftgyIWWKoRVhzMI4HjnqtJxNO/Bq5iqMWpBks6ryJ02vlyxDN8lyHmR/1HaN1DRt9X+g5b+gEBmkx812oJt+N/gujFKgTbvEGKo00n9rQkENUZFO6cWJ+wP8P0xbwCDPv2q9id4AjKvLdL6i9e7aa5SWo0KeBHgtyESXHvhb2I61levyYvec9kfcgIli73D0jmZW0Q0LCDH1AhR3khKllTeKc0u8NNwxaBcPWLfmOqe3Vz2cjCPfrfHJqY6rpxFjsrEJ8nCKfYcmjPG0QmLRx+IVQvEshF8uS1oFLS55S5IkFne2r84P8eDr3MVYeOfc3OIZNYOcgwKmzR3cli4kmXzKktiCSLnHZG9oNwZgIyFQ8Lfs7nva07oR+gBMfhGkM5HTKWkKESR6owzhzIDQWZrnpvYOo2M
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cy85dHJHZWF4cW1GTWx0RkttVVp2UEhKYlRoV0Z4NjJVSDdObVBKU3ZtWlVJ?=
 =?utf-8?B?NWJkaVBoanNBdS9SZmdTczhXTFlrOEN1cjJ5bTRpQmRHVzBadVA0UnNDWENU?=
 =?utf-8?B?WXBWRzNpQ3hrbUFac0s3SnhqdU9QTDNKZUVWMnVUckpveVBMNFptYVZueFh6?=
 =?utf-8?B?dlJ2NG5Zc0tYdVlkVTFSQ3NNQ2dvSW9KeUI2QmNoMnFuNmZzUU05WDltZkI2?=
 =?utf-8?B?OVhLcXdUSDhlM2RhQnhxNkQ4VnFwem1CY1JnenVBZnh1OGdBV2h0Qi83Um5v?=
 =?utf-8?B?RUhGbUVMMUM3Q2NTKzAzRFVyVk5Kd1U3b2ZrK1U5YUVZb2VlTUJBcXdqOEtW?=
 =?utf-8?B?NU9uVWtUZit2b0xWNk1WbDg5aHVSVGhkUmI4VHFCZmM1NHZJeDkzejM1TUhI?=
 =?utf-8?B?VjNnaGJ2Nm16Q0s3VGlmc01vcmVjeWJpVXp0QkRPaDFnVTl2UTRjczU3OEo2?=
 =?utf-8?B?TFNhUjhPUXpmNU9QSlZhOVZqK25tNGs3TGpTcmRRdmJkUis0M05iRnYvYUJT?=
 =?utf-8?B?TmhOcFlyQncveEVHMnpDTHhreFYzakE2U3pSeW9LUG5oRG4yZVgzVXo0QjJN?=
 =?utf-8?B?V2JaMjlMenJvbVBqRVBkWG1vTWpSMTNEeDNXcGJFMjFYNnVmOFFsVEVjRjJQ?=
 =?utf-8?B?Y2RkbnB5SGZaVEpPaFJaMkdaSDlTZVlqN21IcHVBYUFyaS9WQjBDeXFNWE5q?=
 =?utf-8?B?dHlFbWdnRVZBUnl3RUg4dUFoR0c5aWNCY1k1bDNjVDJwZjcyT2pFOGc1Rm11?=
 =?utf-8?B?TUxIWW1ETVM1VVpqcktEdmEvdWxYdXdrby9QU0VGMC9PTlNEMGxubnF3MmUx?=
 =?utf-8?B?ekNySlBWc09LRm9FNGYvUjlULzh5Z0U1cXd1eEcvdEdCWkh0dHRoMmhxeHRr?=
 =?utf-8?B?RVF6WTdMNi9xVERQV3VWTUlINGsyMEg0cTZpWXZCaThIUjlOekJUSjlEbFBO?=
 =?utf-8?B?TmlXL3kyNlh5akdHOS9aYzBjWmg1Vis5eGx3OGRoMUhxcW1nSmFJNnVxYi9S?=
 =?utf-8?B?UktvZW1udkVxQzVYTWU3dEtwVVp6VWZpZGNYUW1KNDdBNlNnN2NHU2RxRzl5?=
 =?utf-8?B?K1FOZlpiNjVhb0VMZmFpV1FxdEVGVVkwWUVzbk1Oc1g4bXI5b21uSmhuRlNO?=
 =?utf-8?B?em1Md2M1blBXWGxWdTBnNVdhMGE5ZkRTc1JIdG8xUWRqWlNxUUhuVXlaMnA5?=
 =?utf-8?B?OFpLU0s2T0tZUmx6SWhrNElVem5FUVVMOW83MHE5YkxWZGppclVwbVZyWitt?=
 =?utf-8?B?dTJBVEowRVJPYlRVbTZIQ0ZsSUpQc056Qys4NERYRk5uQUZrK1VZVGVmZHRV?=
 =?utf-8?B?VXpTWkVsT1QxZkc0V2ZHT1l4aUVNN2wxQVdWQjhaNXJMYWpOSXlzQmlHU2lV?=
 =?utf-8?B?cVpuVTI0R1R2bDBwWFdGNEM1L3pvYlBZVy9wQ2hIenJvMXhEd2djaUtlNkh5?=
 =?utf-8?B?WTI3YjNtWW4rNVQ0OVVWd3M4QWc2UEF4bnJ1ODZISTBQaWpkbXZBTEphN1Ns?=
 =?utf-8?B?Vm4zK1AwM3p4WkFmbHN5TzcyTnd2UTVla0c1dmVqdG43azdvQkRuU2VnOXNY?=
 =?utf-8?B?clpvVGUyZFo3MCs0d1ZoOFd1RGhHcEFHeDZRODJsWlo2ZlpycFpJdytvZEFj?=
 =?utf-8?B?Z1NteUFhVUhxQlN3RWtHQS9XaHFMWndrYmt3VHc4YUhIekNDWHdKdml2S0tK?=
 =?utf-8?B?SWtpRVV2ZGhpSExsV0owaXI1clF2a3RMQjlaYXdScmxWQkVSNUhuNGYvbUUw?=
 =?utf-8?Q?jkwc/OCUlbbZ0lo2TcZ6ZR2eW6kfZXgfr3OduYb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00314d01-b3df-4953-10f7-08dc8fac837b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:37:08.6371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791


在 2024/6/16 15:42, Krzysztof Kozlowski 写道:
> On 16/06/2024 09:36, Yasin Lee wrote:
>> From: Yasin Lee <yasin.lee.x@gmail.com>
>>
>> A capacitive proximity sensor
> Not much improved. No changelog, no responses to previous comments.
>
> I already asked TWICE. So this is third time. Respond to each comment
> and acknowledge that you are going to implement it.
>
> Then write full changelog in patch changelog (so under ---) or in cover
> letter (not present here) saying what changed.
>
> NAK, because you keep ignoring same comments given over and over.
>
> Best regards,
> Krzysztof
>
Hi Krzysztof,

I apologize for the oversight. I am currently working on addressing each 
of the previous comments individually.
I will ensure that all the comments are addressed in detail and will 
include a comprehensive changelog in the cover letter for the next 
version (v6).
Thank you for your patience and guidance.

Best regards,
Yasin Lee


