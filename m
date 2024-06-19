Return-Path: <linux-iio+bounces-6558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B6B90E5F5
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 10:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE692827BE
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD6A7E785;
	Wed, 19 Jun 2024 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fJuIosMd"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2096.outbound.protection.outlook.com [40.92.40.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417979DC7;
	Wed, 19 Jun 2024 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786314; cv=fail; b=P1SUdyNtHa2fjq6H9G6lj0iX9jT5zLZHt2YGMUzC7kSN3NiESx9gCC59+vAAmfrDjFt9WMpyZiVkFNPN2FZA80PMl0OdqfUfPfxLwcHPAvAZx+I38iPgjqa2wezOgmhEWUi8OhSxz9FRj+4XVgkjGvtwCZfg3vkIOBg5cT4C9sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786314; c=relaxed/simple;
	bh=juIUf25ENGymwa22Y2iCTQTmXSKb/KTrSexMDqW1igE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDIr02fMuETeJ8KGGzNbvXRMyVfiMRaaGp2cKjRmLuGj60M+8kk79STg31+DLZfvVwqUkKgatTkLxsXkR9OHLZi/6EQ2U+oU4iJhz/Fs44uY7DBuES/fJ/l4HyHpozRF6T1pNGZkhVdBklPJC7ZdVtG3O8wGb1Z7m+XKfSrKoKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fJuIosMd; arc=fail smtp.client-ip=40.92.40.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd2TXTNDEjbtRW1ipzqm8TG9FkkjtiWYdJGIvqtgrPAW7DLIPV0oDX4vynDcWaT7tX1Fzrn0PxZmt6fa0AejET7/oyqN+ntJIQvTVrobW1iR1noDPQPJgf7FloA2PNbUy6R47q7duqh2fHEYzv+k+u7a8Lu76NPPmAodMbYx1fIhrfH5fv6k6bSBvvskoeoAzkz0gA2TX7N+jPKGpssENQPHGwFpZ8NbLS4rhSdUHWQLUJ/IxgRU3d05scJqiUOBxrSBx2DWvOXkBDUxn7JhYjcPkm2x6ypfNW6QsiGKNZToXVJZ6pEMJa9U+2Z0l++nfIfTfH5oDY1g9pjPgI77og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS09dsmzHCJ5ZmcSVcLmVWMHx3eqo3JMgxx1usRj0oA=;
 b=dU/HjXSVB0vu2rD9Ld59oSzJQavjJL+Y6Nj7OUlZDfqOmfQomv/am86rDKVTNXnINf3nZeGnk0m0vnX7eB2nK3NTRs3e45UCSFcQ1cxOCvUA6pVYEh0MZkrlW+JCkAnV0AyLo67n43wdhd7/MEjksGGdOFZ/y+D88pe2pda+4+6fthk/LfAXifMD+OVIjiHvqzGCihqsR4uO5kWn79/2alEzNHw0u1XyaMcPkuSmjXKYnbPrIVTu7Jj8rdb3QlB8svqk2PwYgiKA47eX/6Vzjvg6cSq6Pexwlh4esoWsRnrxf9GiYG2fZxFR9VA9EdMfx8Cm3O+q32quNmHhfG7p9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS09dsmzHCJ5ZmcSVcLmVWMHx3eqo3JMgxx1usRj0oA=;
 b=fJuIosMdeGd6FqlZ1UoPmSHi5sfGSfwrxlFJNov30YXr2iMo9Xh6+7/fyNa+6bfCVe14s10JkAEepiSFDJJ8kITsXWyXvBmXS3RymMQ2N1R1zmTsas4/ThtOowX3O4E37Zlwa/8dfU4fihmMruz62AFSP1RYS9yu0JLiLDHM12UVKBbhrjWgXzgEQc+/YvcaHWJzfE+xH+JOUklTyqPXRYW5/BCGZfWCHJGzkLnlaCq/DmqgXjOcAY0q2DXQJIHeoUnOjnpYHb9BXNsgGljKOdPRctOgLvy9MXTyjP7WIPM8Tn9tSmDQKkDTLgTwL64n+WRmSbtaJrqP+Xe4ajO0vw==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 08:38:30 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 08:38:30 +0000
Message-ID:
 <SN7PR12MB81011220B1A9F28B70B9B7CEA4CF2@SN7PR12MB8101.namprd12.prod.outlook.com>
Date: Wed, 19 Jun 2024 16:38:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] dt-bindings:iio:proximity: Add hx9031as binding
To: Krzysztof Kozlowski <krzk@kernel.org>, jic23@kernel.org
Cc: andy.shevchenko@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org,
 u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
References: <20240511170143.7ca6a410@jic23-huawei>
 <20240514202540.341103-1-yasin.lee.x@outlook.com>
 <SN7PR12MB81012845A114E1FE7C49DFC3A4E32@SN7PR12MB8101.namprd12.prod.outlook.com>
 <29fa61c3-f7c7-4769-a5eb-75783086cb9f@kernel.org>
 <18b7ea5a-ea10-47b6-9d86-9dcec50e5f9e@kernel.org>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@outlook.com>
In-Reply-To: <18b7ea5a-ea10-47b6-9d86-9dcec50e5f9e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [fBo805CRIdFoEaZXH1fjxkUvFha2CMEFzbEyi1uh0ZQK8IZLcosT/CZXkGB+0ekB]
X-ClientProxiedBy: SG2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:3:17::19) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <249f82e7-ac1d-4ea4-8ea6-454cc6c4338c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 931ee3dc-af76-41d2-3a20-08dc903b320f
X-MS-Exchange-SLBlob-MailProps:
	=?utf-8?B?RnVjbjJMY043SWZITFdGTkRsQ1AwNzAraGZVbGgvbWUwcDBkOWpuamYyMjFT?=
 =?utf-8?B?bUQ5NjcvVUVORTRMQlkvUkQzenkzRDNGVTNXZmVNNm9KdGpwZ0pmNlBWSVRt?=
 =?utf-8?B?bVNYMG5aM1lUTit6R2l2ajdhWG1BTGRLSVB0YUJqTW55NzNJVEVlZ2lRMG01?=
 =?utf-8?B?K0t5MEc2S2hlWkFLK2ZzS3VyNU1jK045NlNNZTlRUFpoOGE2RjRwNms4WEZL?=
 =?utf-8?B?RWtQR29wTkx6VUlDQlYvTGs4dHlTVUVRSzlGcWs5RUtMTW82WGhSMGkzc3JQ?=
 =?utf-8?B?M2UyaEF5VkNpb0QwUFVhZFRvUmFmaHVrZ0RuQk82QjFYNGZHb2pDMVgvMGRl?=
 =?utf-8?B?WHIxQnQwMzBTc1o2WEMvT0lpYlBJQTZiSzF4TmdqUlZTc1RkeXZLZXpVMnpj?=
 =?utf-8?B?V0pDSzFTSWQrR1RCTEN0VVQvY2xCYjBCaGdkTFdhQlJ5eVFmQytYUUw5SU5u?=
 =?utf-8?B?SXE3TUx3OThDa3ZPc2pSTG4vU1FyU1NkanBiaGpvSmZtZGI4WDJ2T2JuQmU4?=
 =?utf-8?B?blEvTWFYWERJTVhORjROZzFMbEttR2dIcVBmZlR5a00xWlhNdEJZQnBwdXJn?=
 =?utf-8?B?ejBXdEUyWGNWdkkzZWtwZ3lqdUJsc2RZc0JpanJEWFpnSG03dkRnZFBNUzYx?=
 =?utf-8?B?alUwRENRSXBxdlVVWHFRam0vZElHUlhsMXFQN2lIRVVmdmt0dW5DQVEzVVNm?=
 =?utf-8?B?QmRJdXQ2blQxQ3crdmR5SE1LYXZobFZiR3RWN0YvZHFka0h0Y1JIQ3YzemJZ?=
 =?utf-8?B?bll3cndnb3VGQitkNjN5NEcrZWZRNUhZdG5OckE0UXVSaFdnYUJHc1JMaVlD?=
 =?utf-8?B?LzE5cXlGMWNJa0VYOEM4K0FJSGFnSzk2VWFwbS9vMEtOSHc1TWhVQzgya3c5?=
 =?utf-8?B?SHRnMFc5eG9DMSt4WE1pblhvV1BnTFB4aWhZSVhockE3cmM0Qk11TDFycytu?=
 =?utf-8?B?eC9STVRzc2xMZmdsdVBTcHQ2dW10bGlidkpWVFV1bVdzUWNqMW15TUxMbVZQ?=
 =?utf-8?B?WUY0NWVDME1OMTIvTC95eVRYLzRMZ1ovczFBL2lSMmlKMGZyejlIT0h0MzE3?=
 =?utf-8?B?TEFnekM1VHE0N0NaK09NUUlRTWRYaHRMek9ZMnlOSmhrYnBSTkliTmNaU0l4?=
 =?utf-8?B?cGJ5dE95dTlYRy9paERKRlIzQTRYTk1TQys2M3NHait5alo0UXFDYnJNMUk2?=
 =?utf-8?B?UEttWlFlWDlZSVh3bm95RFpKMVI0MlNLcU13THo2TlZQZUtpODVEeGxZWHBp?=
 =?utf-8?Q?eKq8+agJVXAgZLOTScVCxjKuCw=3D?=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|1602099009|440099025|3412199022|4302099010;
X-Microsoft-Antispam-Message-Info:
	nhI7caO9TSghCou5DHGZsRwCU+2XKRsGrbe/vLjcUhue5UE5WPM190leLlY5CdMkPPufez0xmxDkgXW5H/LCX3tTONBFa/plTbiTItysy26n2GJzpSWgxQ8iJy2DBGJeO9Djb1cXrTKHlBlQlLhnSczwfVcFhAjNFOZbx/V1y9iguCOi4DDZfJbzUVaZOjXYabw2MjWw1FuqPaUYRJ+9zYhTWOv9thzW1T6fIggryu7k/cS6mm/+NJdQn1gtLD+PlAvrBT349DG8KRt2npdtatkIFIjhV2/dZUxebvNaQtRLO1yAuNGVLSJSE9KV/K7nL7/NJt5xU4peLQmw/EjSqnI5EuSnL+GEt7K1wk5DnxXbZe5oocHzbYpFwpWnr2go+0uYXnPMjKToaC5999nYopMUHuusTUScQ6uBWQdiQDPIYGa/0+1KNPb5m/nYO4cjojkat//c50W+iyMn3o7l8W7AyIiqcrJTM5VFqKSghsN/GkQw4ajz5Z9HXKdZgf5ayjXDOv83BF9QqXIJJDVDN1wKy3gvvFLVf0ahjCtN/KEHpG6PHxWR7EghvkL6TQknGMsn+3lnKrka/J0XwYUwi8LdgRvP8sRSIO8RevoyYHgHknkc9D3zDOQd2fxUac6EYwN5nD+h98ixqoDe52DrLZnc0YZWymm1Rih7Ktng2nx5Q0KufrAg96yRiVP3VEEoS+7SiPFXJJ7w8tgJExhxeQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWh1cUlMd0JIRExEdkZlWW5HNG1DUHlTT2dJeFN3TjBqalBsTGNDc2lIbFBC?=
 =?utf-8?B?b2NiUzFlNlFFWnNpdjlxeldLTmNrVnQ5TzkzTzlUSUJwL0RtNXVuTWhtVjhF?=
 =?utf-8?B?RTBNL0VGVTFlSTdmMW95ak5KS1Y0ajVEbGhmck9NOGF0N0tlMm8xZ0VCM1Qy?=
 =?utf-8?B?MTIxVkZVa2FUTU9kYUU4NXYvRWpwL2lWU3B6aElHaG1yOUkrb2FETlhMd0t1?=
 =?utf-8?B?WnpXQ2lpN0FIaWIzTHJVMHQyTVFUdUwwL1JFUXZuUjFSdEhNQzJZcHZRVkFF?=
 =?utf-8?B?NjFyZEpKREFtbGJvQmpteHBaYlJIVjRGWFNYVnN6c0ppUWZSRkRtM1U2bXk2?=
 =?utf-8?B?d2dPWXUzalQyQVVIdUUwU3kxMmxzSXpPWmVoZ2NTcW1Tc1Ixa2pCSWdWa084?=
 =?utf-8?B?czNITlorQ0lxN25qbTF2blBTSTlzTXRPMnNzWTM4S3A0Q1pWTEJyQkpERkw5?=
 =?utf-8?B?Q2ZZWHVxWlY0eUVncTQ5WlFPZjJ4cExXdlc5T3hKM2Uyd3JlVThLQ0lwRTFq?=
 =?utf-8?B?TnFHS1Qxc2pyOHhrRytuMzViZFptdzVaTVh0UmRVeWl5QitYODYzNkVQTTY0?=
 =?utf-8?B?OHpmQkdrdE8vVG4za0lRRldLY2N0czRhQVFIUmRlaGRUM1ZLVXVkTWgyOUFI?=
 =?utf-8?B?cHo0RU51MmZuOEd0OU9RU1RrR3BYa2F0TkF1Q2dERXlzcnY3ZVhZMmpKcE9l?=
 =?utf-8?B?QmdQeDZNblQvOFZDSC9MaExwZTBVNktod0NLbU5rMHpEZ2VibXFUdTlZTDRp?=
 =?utf-8?B?VnZNTExScUI2Z2tNN2hoR2ZISVdhdWJTcWsxNTRtS2wxempFR3lKMWRiZzdO?=
 =?utf-8?B?WFU5OHFLUThERE5pVkFSZ2FUcnJYckZJWmwxOWNrZU15OGJqVmlRdVUzbzV4?=
 =?utf-8?B?dDAwa0hSU2lZVzdDdTRhOE9OVFZ1Q21Jb29ZNHlReXNhU2JJLzJwelBzallm?=
 =?utf-8?B?OHRKa0FiYUFzbGgvbVdzQWtmZmFaZmllcmRITmJ1eW54cGcxWjRJbUZKOVpV?=
 =?utf-8?B?WHFBQjR5b0EvUU1SNHF5S21ianFRbmowOU5xM1ltWGFraXlsaTJGdVN1TVJ3?=
 =?utf-8?B?YUlBc2dCR1pZS0Zjck9kcXc3bGxoamoxMUlwM0Z5dExwbk96Z0t5SHZ2NEc4?=
 =?utf-8?B?b3Bqa004aEZaTFRqeGRPN0crdmNTT0h3Q2ZTVmlxcFBjTFZPKytVQmhZMEtR?=
 =?utf-8?B?Y3JVbFFPeXJTNXQ2cTFGWlRQanZ4MVFtZ3NIcENmVWY2cjlSMExkUHBvaW1Q?=
 =?utf-8?B?OUJiZjE1eVFYNGNkd2oxb0xYRHUzTElWVjJ0b3llbHJsdWtUVkZIeUFlWjRX?=
 =?utf-8?B?Ykg3cThNQjhxaTlMZFpZYTQyOExsT0ZXVEpOc0ZnU0JpNXRBZjNmamlMK1B4?=
 =?utf-8?B?TWZ2eTZ3Skh3T05kQ2daUEtQR01kQWZuT0dJaU95Y3dmVWdVUStHSERud081?=
 =?utf-8?B?cGh6QTNsQjNCM1JhWGdCWjFtb0RsQmRGS3hRNWkrcWs4VmJFUmR4YU1uc3lU?=
 =?utf-8?B?blV3M01PZ0FSTDM3TGh4SmpRYVNBdERJNlpFMkd0SEE3OWxrQUdoNlB2N0Zq?=
 =?utf-8?B?QVQxVnIxaDdqTG5ieGV6ZEszMlRsNm9lVDVVaFFYRU1hdFROUFlsMjNlRXpy?=
 =?utf-8?B?V09BNVNDV2VreWI5MnlWbmxwOHduZkx1NWxYUmh1ODFYNG9BVWM4QTF0NE9N?=
 =?utf-8?B?Mmk1RTNxNWJwNkRqMXlTNWxySmhJMGN1bXNKb2JxdWVwdkROblI4T05McE1X?=
 =?utf-8?Q?s7DmQR861XVR4RpYkFojEURvw0VGeByC7WimUeG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931ee3dc-af76-41d2-3a20-08dc903b320f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 08:38:30.0334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033

Dear Krzysztof,

Thank you for your valuable feedback. I have made the following changes 
based on your suggestions, as shown inline.

Best regards,
Yasin Lee


On 2024/6/16 15:47, Krzysztof Kozlowski wrote:
> On 15/05/2024 10:06, Krzysztof Kozlowski wrote:
>> On 14/05/2024 22:25, Yasin Lee wrote:
>>> From: Yasin Lee <yasin.lee.x@gmail.com>
>>>
>>> A capacitive proximity sensor with 5 channels
>>>
>>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>> Do not attach (thread) your patchsets to some other threads (unrelated
>> or older versions). This buries them deep in the mailbox and might
>> interfere with applying entire sets.
> Did you implement this?


 From v5 onwards, I used the b4 tool to ensure the patch threading is 
correct.


>> A nit, subject: drop second/last, redundant "bindings". The
>> "dt-bindings" prefix is already stating that these are bindings.
>> See also:
>> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> Did you implement this?
>
>> Subject: missing spaces. See  `git log --oneline -- DIRECTORY_OR_FILE`
>> on the directory your patch is touching.
> Did you implement this?
>

In subsequent versions , the subject line as below:

dt-bindings: iio: proximity: Add TYHX HX9023S


>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC. It might happen, that command when run on an older
>> kernel, gives you outdated entries. Therefore please be sure you base
>> your patches on recent Linux kernel.
>>
>> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
>> people, so fix your workflow. Tools might also fail if you work on some
>> ancient tree (don't, instead use mainline), work on fork of kernel
>> (don't, instead use mainline) or you ignore some maintainers (really
>> don't). Just use b4 and everything should be fine, although remember
>> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
>>
>> You missed at least devicetree list (maybe more), so this won't be
>> tested by automated tooling. Performing review on untested code might be
>> a waste of time, thus I will skip this patch entirely till you follow
>> the process allowing the patch to be tested.
>>
>> Please kindly resend and include all necessary To/Cc entries.
> Did you implement this?
>

I used the latest Linux kernel and b4 tool to generate the correct 
maintainers and Cc list after V4.


>> Limited review follows.
>>
>>> ---
>>>   .../bindings/iio/proximity/tyhx,hx9031as.yaml | 60 +++++++++++++++++++
>>>   .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>>>   2 files changed, 62 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9031as.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9031as.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9031as.yaml
>>> new file mode 100644
>>> index 000000000000..62a71c0c4d04
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9031as.yaml
>>> @@ -0,0 +1,60 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9031as.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Tyhx's HX9031AS capacitive proximity sensor
>>> +
>>> +maintainers:
>>> +  - Yasin Lee <yasin.lee.x@gmail.com>
>>> +
>>> +description: |
>>> +  Tyhx's HX9031AS proximity sensor.
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/iio/iio.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: tyhx,hx9031as
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    description:
>>> +      Generated by device to announce preceding read request has finished
>>> +      and data is available or that a close/far proximity event has happened.
>>> +    maxItems: 1
>>> +
>>> +  vdd-supply:
>>> +    description: Main power supply
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    i2c {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +      hx9031as@2a {
>> Node names should be generic. See also an explanation and list of
>> examples (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> Did you implement this?


The node name has been changed to "proximity" to comply with the device 
tree specification.


>
>>
>>> +        compatible = "tyhx,hx9031as";
>>> +        reg = <0x2a>;
>>> +        interrupt-parent = <&pio>;
>>> +        interrupts = <16 IRQ_TYPE_EDGE_FALLING 16 0>;
>>> +        vdd-supply = <&pp3300_a>;
>>> +        status = "okay";
>> Drop
> Did you implement this?


I have removed the "status" line and all unnecessary blank lines.


>>> +      };
>>> +    };
>>> +
>>> +
>>> +
>>> +
>>> +
>>> +
>> Drop useless blank lines...
> Did you implement this?
>

I have removed  all unnecessary blank lines.


> Best regards,
> Krzysztof
>

