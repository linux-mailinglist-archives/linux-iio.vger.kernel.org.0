Return-Path: <linux-iio+bounces-27787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1D8D1FE7F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E02A3054494
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2213A0E8C;
	Wed, 14 Jan 2026 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="xMACEwn6"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021141.outbound.protection.outlook.com [52.101.70.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF913A0E8A;
	Wed, 14 Jan 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404731; cv=fail; b=MV6KkbzAm1Y//TlbfKk0vtOuLx+PtUdiPz+8hNyrvxbV7mntMZfutpW/1Dy3mzEKuCEkNE1C6syodVQWykXyqvNdyTrRgdfumpUEKk1X7uj/IZ9VHVQZe5e/lmw7lgs7pq/ff11ZYCC76nzaOmPY9bN17xqw9k5dDjc8m3WntIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404731; c=relaxed/simple;
	bh=CpmxZhGAE5Y3NJWSYInKkj9TrCqT/6Iwpo7VZxZzdxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WMdR/EroJ6ByRYzqNRJ2ce+m+dOqu41HoaxOP8q+k7E7PWnGQ5BA+SPxR7AXG1XgKktNek8OK2KA3mGNyu88zccp2h8cRokpa4cjTrfruORSKvXk+w7IYXW+EThyhOOn7aBNpFLI+4RdTW0DsCiJVbk76AqqtSUb67730WP41No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=xMACEwn6; arc=fail smtp.client-ip=52.101.70.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXO2ESV5GBY1mZpHdGm0UDHRzelLE1Cs+mb23sVEvslFRStOFVEQEIfajV1Cw2mYY/2shJwVv3bx/NIlqekltCS+qyt7OWqF9tH8IAOho7T6otRTSWKQR3muSzLEG6wARDt3aM9LXCvnXx/TlLN10spKuAaIoJu3um838scMBPS76PDOUsPD6GG5/wYd9EZhEHc+y/Xi0hZfsAeo/1m4Q4dnj7C7Qf2jdzDF2bBLG6jRa1R/rTPL4vtEWBNUNj9xP/sQk7OyQX7/ZN9w1WpMseZFFfrnu9yGyPRzK5IGwwXNM9ySTrbCp0k59scN4nzJoTcGeJTVsPsK7Pn7I6HwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wZKE/peenD5k/jY8VHbvcVGLsj/p/6ZHVzanJnRDJo=;
 b=H7HV6WskjmILYROIiO9j2/mXP5gPIWn8wqvtbAJr970xfpGijMH2iKB2hgL0M64ufaxO1bV3WDeljhRDg0gIw8P4PmtOZbZ8gR/CMS3RuFcxGc/pKjaUiexTWKPNJe93F7SVIN/paMUnGcmO+UZEO9ix1Jth1u1/JfP33+lJROceTqFMmjUpFDLYaI6nvyFiwShSYKqkF3Neaue8R3TQHtumDhYa8AS0UEGt4AHZwGV55ApL1bYbzf81P1US444HJ6NSwOJnEc7+TnV2FA2vp0FVNDB3mD35pK1ejeoKdyOfXxkb9hbpv/uw1zEh0tLBA3PoMre3wPO2l0BeDw840A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wZKE/peenD5k/jY8VHbvcVGLsj/p/6ZHVzanJnRDJo=;
 b=xMACEwn6jaiuUZHI75AIUR0GAgKE8wp3eqgBLSNxdBfMXqTp1K8PlH68+UYlouspJ33tfrTC7lurYWrg4jV258/4XnyHajPu6auj7pjKpo+mQ+IopZ88yrls8avU/r0wEfQVjI/ZGIiDQsot6sTiVkVqyOQ4kef+aQHCGLNSGdCRHIKg84lY2Fm4/SHMZN4WzsPQo0q3qQP2kSVD2SkNHQ5vcUj7JG9/lgA1MagwxlEORifKZ7O2a1azol18xcw9/GugolJNf/OSeadV3PCQdEEtLDK9GHPO0veDyqVdixsa0n7b/yL4Q0NjZEYeapXhpCll2oLGUU75NWK3gG+Bag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PAXPR06MB7694.eurprd06.prod.outlook.com (2603:10a6:102:dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:32:05 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 15:32:05 +0000
Message-ID: <7ac7033a-2273-4556-a605-1ea0200665a9@vaisala.com>
Date: Wed, 14 Jan 2026 17:32:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] iio: adc: ad9467: Support alternative backends
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
 <0ad12e16e3fffb4b72a460d7f2b2e627a781b93b.camel@gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <0ad12e16e3fffb4b72a460d7f2b2e627a781b93b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00007574.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3ed) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PAXPR06MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 792025ce-cb1c-44f3-b4ce-08de53821297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ME84NUJ3UG9VTkw5UTdrQ3JjanE5QlVRVEY5d2hTWXFxbFpvWjNuVmV1ZFF5?=
 =?utf-8?B?SkFaclNkOUhvREZib2UxN1g1bnpsblZwMW9Gd29RN2FCOU5YNEduREdDelpx?=
 =?utf-8?B?c01jNVFnSFo2SjVBdSs5OUVXUXNkQ2FCeGZWb2xXcDYzeEFseG1Qb01jMFlK?=
 =?utf-8?B?SnhWcFpCSndkR3Y4a3VLNHRZeHM5ei9peklObEU0S3VKNytpaE1FalhGaWNk?=
 =?utf-8?B?QlFoV3ZBanE1bTRPL3NudHRvemtnejhFVkI3WWVGcEhrMURtNkpxd3ducVVZ?=
 =?utf-8?B?WjdxWEFudWhCS1ZzMmJ1MmdrMDRpRUhwdHRIUStOTXVhWDBGeGZaQ3prWFhw?=
 =?utf-8?B?a3JmYmM0S0tYNkhheWQyWGZHK0xWcEt3MTFuU0Zoc3lRN0ppTlZqMzh6K011?=
 =?utf-8?B?dXJ6NEpoSFZFYlNUcGxvQkRweVBxMkNvRkVmNzI0VzFIK25XNitzNjZrM01Z?=
 =?utf-8?B?eElQeUYwRTNVR010U3JXclZqV0l0R25id2NxRWlZblNlRUNBdWsvY1JoOUpk?=
 =?utf-8?B?QXNFUElUMGJiWGZnWjNwMFdIYW5PNG51ZkJCQWM1Wno2TXZLU2xVbmpieDVU?=
 =?utf-8?B?VmJvM2x4MXEzMDI5NGJtR3FjUURoL2RFUy9odU5MSjBWYjRNWkxqaktvQ3Zy?=
 =?utf-8?B?c2hFZnJoYVlvNHpPTkk3enBZekdmOU1Jc1hFd2hFd1Zoa0xqQ1hvU3NCZlVp?=
 =?utf-8?B?dHhaM1BJSEc5Mm5lTTJsK3JobDlZdWFIekRFSVZRc2JkU0lkMUhTT3B3cmV1?=
 =?utf-8?B?VkVReENMWUkyVHBqSTQyVUtzWTNMUzZ5ZFNzZ1NWRUVUMU00MitqalhTajNs?=
 =?utf-8?B?bkkyYXN1Nldzblprd3k4NXlIcjVhZVdPWC95YXdNcEJWOEpGZ0Z0Q2ZTdTRC?=
 =?utf-8?B?aXlOc2R0ekY5cUlETmJtUUs1NXRUdEJ4a1FjcDh0M1VHMk1GNXc2UWIxNlQ1?=
 =?utf-8?B?YnQ1ZkFtUGo4dXNVZE1VUndlOHZGU2kzVWxVUzVqUC9IckJmSEVLaTcxeEkx?=
 =?utf-8?B?UWgrMmdUWkVOOHJGaG9zeWg2aGVJNEM3Z08ydUpPK2hOQThCZ3RQVHk0ak5x?=
 =?utf-8?B?MHFzSFF6bmkrZi9mOXAzMlkxdGNKd1hnWUhxUml0Q3FKaXhDa1dHR2liYkli?=
 =?utf-8?B?U29mdXExbWU1TUJ5K0ZJeG1aQzNFTUgvNEFoV3pFdW9JZGtQWVg3OTBic0Y0?=
 =?utf-8?B?UGJLZDJ4NVVoWUlXbjczYkZid0J0NVFBZ2tTbWZnYzBWeGE4cjdxTUZsZDdm?=
 =?utf-8?B?aVR3QXlzOGlhSC9uM28zR1BGR2Rxd29CMFZjYUpMK04yVm4rYlQwYWFxQjhV?=
 =?utf-8?B?SytzREkzNm91cGF0VjNYakJpUGpsaWxLL29tbGRBRlNvaHRjYzhqUlRldzEy?=
 =?utf-8?B?N3g5OFd5S2QweGdBdHFiTHV1THBhaVlvNWhQTFZ5dWpMRW5yWUkrOW1xUkQr?=
 =?utf-8?B?TnNWWXBFKzEvWHA3TXEvQmdxcWRDUVo2WWtXV1VOakMxL0ZXY200dlVDNDFx?=
 =?utf-8?B?OHZUU0hlNFhjdTZteHdjWjMxUVVCSjdpRWZRUS9pMTJWdVpjc0ZiUVVwaGdw?=
 =?utf-8?B?R1dpMnExWERTVUhMYmZVeFArNCtVT3VQL1BoUnVHUWkzczlFYldkNWNNQ3Vo?=
 =?utf-8?B?KzYzd00xd2ZLejBSbmt5a3FFYitPTmpKb0JhQk1NdjVJUC8vYjdScnZhSzk3?=
 =?utf-8?B?RGJrWDlDZkRUWkk1d0g1K3NGRTQwQXNDMFp2QzBtUUx6azFDNGNqNVMxcU1G?=
 =?utf-8?B?YlhVbnhVZlcrSkx0Y3Yxemk1a2hReWIxdnI5MzFaT0RtSlRzQktMR25BNW5k?=
 =?utf-8?B?dW5GV3FSODFGNUEzazF0Y2IrbTVkNjI1UUlaWGhNTXlCWGw3aHRNL2tkZ3kx?=
 =?utf-8?B?QWpCZEV6ejdDVTFBQW5VM2dXTzJ3N0R1Qm1QMFF1eFBIbVJGSzV2V00wTEtj?=
 =?utf-8?B?a091SDI1ZDFta3BBOEczVlQ1R20rZEpJRXg2Y3hmbTBxVUx2OXhXY0NhSjhD?=
 =?utf-8?B?aXJyNHhaUTRYdGdmdnFwNXdSQmFKY09vNDVwZEdiY1VzdUcvVmZLRU1LUnZk?=
 =?utf-8?B?RXA5VlhqVG5MZUw3VWtKWDg5ZW1zTXFhVTVEVkdxS25rb1QxWGlpdEorV0pl?=
 =?utf-8?Q?qHPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aysvWlU3ZEt1NHNMRXJtRzBkaE5ESWt5MzNQSWwwNi8wV1ExQTlwb2hQTzQ4?=
 =?utf-8?B?b29BdjdlK2ZQRTdzSDlKNXRnRnBHMnhuRTZkNnQ1MXlaajNGeGN3cVd5dUtL?=
 =?utf-8?B?L3Y0WGVzclhCMU9tKytPZXoxdVVGOVk5amY4ZS9veHR1WllFSkkvN0Z6Qjlk?=
 =?utf-8?B?S08zQnNzM3NBTzhSeGlsTVExT3Rqd3FtOWxBZ2J0dmZrZjV6TC9EVzc5dSs2?=
 =?utf-8?B?ZnI2eldoaDFsSjg5bGd5ZVlIQXNWZk02TUM5cEQyeWl4VzNGdlVOczdEMTFz?=
 =?utf-8?B?Y1B2dDJUS1IvdEQ1Yi9OL1FVRTNIS1cyNGxWQmpPbkQ3YVN2SGE0UUlwVGx0?=
 =?utf-8?B?VFk2N05YZGhYTzJGL2R1eFNpMmkzczB3dUYyQW5DVitJRjl3dVNHV0svc1BN?=
 =?utf-8?B?T0F6eU40b0xxalhjSFZIVjV1Wnl3TWx3Q0djazVzOTNyeXFkWXVyU3FjbmJT?=
 =?utf-8?B?NTdlcXJkbGoxZytndXpqSmdEMkkzaFkxYjhNcnJ4ZDE1Vy9GcmxqRFpNdG9K?=
 =?utf-8?B?RGlJamEvb1BFRTRacFM5bGwrbGNWMmdKNkY1N0s1Q2VFSStMeUxaSGJTdHVP?=
 =?utf-8?B?TGVIWkFjOXZyZ0l2VVRzRjlJMk5heTM1YkFESlRFNFBWTy9WdkNMNzFDODJt?=
 =?utf-8?B?ckVSbzBjVktUMUZERFJVQ1FYSmNJV3hWY0NKYS9SblF3VFBFTVl4NXN2eVpv?=
 =?utf-8?B?cC9HR3JnZDBCbTg4cnhPbWhRK3Q0WHNDdHdKSU5LRnNjc3JjeHdPN25mQ0F4?=
 =?utf-8?B?bzFFTnUwT1lrd3hpcUU3blZtTU9nQ3JMcVdKN0RPRjZ2eFhHazJZU1loQ0dh?=
 =?utf-8?B?SG5SWG5XNVVtSkF0ekVCNGFyMTdwZmIyOUthU3BCdExQcUZhd3U3SmNYcUJq?=
 =?utf-8?B?NmV1RXNac2pEQ3dkVFZydTEyYzliZ3FDajNSZnlxRFB2ZkQ0Z2gzeUdFY3E4?=
 =?utf-8?B?ajFzYVV3M3R6WmhRL3hnRkw3RmM4RVdnSU9qd2piRTNSeUFlTlduQ1RpN2Jp?=
 =?utf-8?B?WTU5a3B0WWR4RHVMVU15S1RHS3ozSDQ2bnZOejlzSUVab0xqdzI4WHoxdXl3?=
 =?utf-8?B?b0JsbEU2YUxTSzJiRlJKY3FyeW5kcVBVTks3bFhDWkVkVXNhTFVDN2xEeHZj?=
 =?utf-8?B?Qk04OGdjazNqbVd5LzRsYk4vNzBFcFJFRFhkN2JBeFRZZ0t0VWpmRkVVOEdx?=
 =?utf-8?B?cEFLdEU2QzZ4UDNUWTZ6TjhjeTR5R1MrQWlMelRvTmN1eXQ4cHVEU1dZSis5?=
 =?utf-8?B?RWt1U1dvM2NKdlhpZGRVZ1RiUFJNdWVob0dCcGJsY25sN0c1M1NYelZXQTB0?=
 =?utf-8?B?c2FvM3dCRm5lbE52N0NzWHVkdTRxV0cxektuZFI1TUFYTkV4ditnWUFZb3BV?=
 =?utf-8?B?aE5kRzdYcnptd1ZEQ09ORUo0clVMT2FpWFo1cHB0dVpQK0VGSzBob1hkYjhj?=
 =?utf-8?B?L1F2b21FOGhaS21IL3c3bTJaaWpVL2l3Zy84WFpTbTd3L0YvWmo2WlBtZFBS?=
 =?utf-8?B?MDJrRmUrWTRzSmJMQVBWbXZncVRnWEdjU1gxcG9OTktVUzNNTmo4L1NLZ0xk?=
 =?utf-8?B?WGFGOFhZWm95RE4zRDd3MlZFUmdIUm9NQ0VyLzl1QW51K3VXVkVUOVk1THo2?=
 =?utf-8?B?QjRKV3h5UFlRUUlSZlQxTEZrMnJRZjg4eHgxVzRvTzRpMkVER1pTa0xtNkFR?=
 =?utf-8?B?bERWeVBESG14aUlVdUJPZ3pTbjllTjY5cGo4UUFYeWdOU1puL01DS09qRE1G?=
 =?utf-8?B?c0FCT0krM0tRLzllUnozVGZXdUljR2RvSUJka3pwdmRZVUtocjNRRi9jeFhU?=
 =?utf-8?B?WEl4dTdYWVhERVJrNlM0V2xidDl1bHcwTnhRTEhMeXRHaDB5K08vV0dEOVNL?=
 =?utf-8?B?bzV4cUZoSzR0WHJrYjFtNWRjZ1FEelNZMlUyMEZCL2YwRE9GUHBLZmpnRXdi?=
 =?utf-8?B?TWZSbkxrVnZWaUxaT1J1ZlJrOUxmek1IUkdBQktTU3M5TFNKcW9zQkFzS3ZS?=
 =?utf-8?B?b1lMcGs2eVlQektFc1M5WXl6RHV0akxXRHVSWTJ4alprWktCQzF5djlOSjFl?=
 =?utf-8?B?a21mUTNZYXd3b1pFWUZXVFMySXZpV2lpR1d5Vkc2aHpQd2w2VXFGaXJoM2pL?=
 =?utf-8?B?MmxkN29GNTBhdHU2WEU5bmdSUHJHcEtQcW9uRlNKdVVUcTFnZmhvWjJkUGho?=
 =?utf-8?B?cGNYOU0zVEx0ZGVVVmZlbVpjZXlSTDNvNGdweldXbnFjRXFkS2dtKzBtckpm?=
 =?utf-8?B?dnBlOUxhOU1DaDdESjlJbHNGR0lyaXM0VXhWb0ZGR3kyM004b2J3M3ZrVUNm?=
 =?utf-8?B?OTVhd3Bqenk4SVZ0cElzU05XS2hSOWcwRnRFZlZ4Tzd6bG1NTmFjemx5SU0r?=
 =?utf-8?Q?fzGrLDB5zESq4ljM=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792025ce-cb1c-44f3-b4ce-08de53821297
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:32:05.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8nWCoX390Z31qk/SlCYA6QhAs6v06HH0sAUZbIov6zAfB0WAw9pTmgaGc2o9MbEdRoV9DIgwHyq1LOBsgSrmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7694

Hi Nuno,

On 14/01/2026 15:32, Nuno Sá wrote:
> On Wed, 2026-01-14 at 10:45 +0000, Tomas Melin wrote:
>> To facilitate backends with different set of features, add support
>> for defining capabilites provided by the backend. These capabilites
>> typically extend beyond a single operation and are therefore not
>> directly linked to if a single function call is implemented or not.
>> Furthermore, the capabilites determine if a certain set of operations
>> should be attempted, or skipped by the frontend. This way
>> the frontend driver can work with a minimalistic set of features and
>> still have the device in fully functional state.
>>
>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
>> ---
> 
> Hi Tomas,
> 
>> Changes in v3:
>> - Reduce set of capabilities to only include calibration. The other
>>   ones propsed in V2 can be seen as subset of calibration, or single
>>   operation failing with opnotsupported
> 
> As stated in my patch comment. Using opnotsupported for buffers defeats
> the CAPS idea.
Please check my other reply, to me adding cap for a 1:1 mapping of a
operation seems like duplicating the information. But of course, this
can be viewed from different angles and it is also possible to look at
it like that.

> 
> 
> But more importantly, how are your usecase supposed to work with this
> series? I'm not seeing any new backend being added as part of the series.
> Point is, if we are adding all of this, I would expect your usecase to
> have fully upstream support. If I'm not missing nothing, we would at least
> need a dummy backend providing stubs for enable()/disable()
My usecase adds simplistic backend support and registers to the
framework via an related driver. So that use case works with that
approach. I think it is better to assume there is always some entity
that can take on the role of being backend, rather than adding a dummy
backend. Adding the capabilities are defining role here, as having that
allows for customer integrations with backends that differ but are of no
interest for the mainline.

Thanks,
Tomas






> 
> - Nuno Sá


