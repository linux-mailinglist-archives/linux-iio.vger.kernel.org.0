Return-Path: <linux-iio+bounces-23772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A954CB457E5
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 14:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B12165EA7
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 12:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7251E34F47E;
	Fri,  5 Sep 2025 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dSQkG08t"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768634DCD2;
	Fri,  5 Sep 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075400; cv=fail; b=h6Tgv8AL3olLw4N9sTjW7oSRspr8KTf8TmNiQVVAqjOJ2Hno7WQNv6JMV/GzHQddLq2S42oXj1oVnIJCdKm5YipsUpXlU5uOn12cUNBI5E4vvcUM7zPJwKnExdDqEU2+3YT0aCOKIgrMDzgwjoruKmaHZv9z9WPwSbuSGqlK998=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075400; c=relaxed/simple;
	bh=l4IxSk1EHKV9qRGHYGdd4UX4QYLQFKuLVqxtpLQTZ7A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XblSFEnsp2Vwcpuc3L0S7mEA5Y1IF6U4r9d3s94mWeV9XWjBJBtb32ewtBWGhNzWl60mHU0/a0zkIGYOo4lOFLunhb7XWL2+Q+Wiwg1mgGiIfNAPZsBfhuAOqjaaOh8IvMB2OQHyi2jwFhcFG+Yj7aikphie6HO023YIfir89xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dSQkG08t; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYBdk0mMmrdEm0uPOkray2tCTY+0VrxWhJxOShXh/3xwl/kmbXsizsN6qDzKjIzIpA4YQ7Bk5tnRJbHEY0ot6s0TzrR0uTVN9W1d5T3AbRkVkj/rSKtJjpph2IrWfOWp40oOHuZujpzlxktI30OxJ76bm8AsSuqK0AoxpuKyNs5TVHhEOpalJ1kzB1oM/X/iDYPvyI1GTuHRVSlTH9xXX6C7AUJaax69SQPgL5GEHu7DtKDRKXPj2W0U01KLD7ogEoV1g6y+BdvdOZQii5eAqe6N0SfIE4W6On49e92Rn9pSw12xplyDvYRykw13RW4iTu+w4pcappHE+3/TogeNvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cwXjDj4UmK0g+Vl4dOlFdBm5py6I1IsztMTKEVXbCg=;
 b=LZy4YQe6vwmkCVX8FQqG0h2fvVaiQN0jR0fKqWeD3Ki4kE2NWO/seyB6ubcI+zNSIypZxcysA+Swf5O1DZOfWsFLxfx/sLSiJKTirmW4eLlRf8d7lyfsGMcVsj+eEG/Swikb2oxTVJiHhYXXaoJIIxPmMglRn+laba4g8FqrLyITsRxEFy9+eXoEyClAj9/KOTE/faVBcVkGQnK7XSyJStck1ujlmXcbfcn83h1KW7ZesMQd+Ct7nQfnoPdvF7gp/nMgHOg/Do653e8zl8w/mGOSvTbCYv22ZKJKSfx3UZ9ZQzKUGj9dJ0MONQX+e7DgW19mEc6MDgzb5I0HxCBLvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cwXjDj4UmK0g+Vl4dOlFdBm5py6I1IsztMTKEVXbCg=;
 b=dSQkG08tgaC9Wy2PIqcupjOtpB8NqZPmZ8Npm6QVQUbB3cZiVQHyq9sW39wioZ4gx1+xSMHR6kd3gNbDk1rE6Wad2HFRoMK2UDKmAmHr9eC5UzgIQJ/V+eM2cAv18Zqs+6T3/pjbMAT+iLmGMCiBs7KeMVekRowqx7DJks/OLtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 12:29:55 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 12:29:55 +0000
Message-ID: <5f21169b-39b8-4fcd-b7d7-e5bcb1885549@amd.com>
Date: Fri, 5 Sep 2025 14:29:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: iio: xilinx: Add Documentation for
 Sysmon
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Salih Erim <salih.erim@amd.com>,
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 Anish Kadamathikuttiyil Karthikeyan Pillai
 <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>,
 Andy Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
References: <cover.1757061697.git.michal.simek@amd.com>
 <610690b9cc4ab3854b56df550b688b4cc72a5653.1757061697.git.michal.simek@amd.com>
 <20250905123006.000031a9@huawei.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250905123006.000031a9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0050.namprd17.prod.outlook.com
 (2603:10b6:510:325::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: d2635a7a-9bcd-4514-464b-08ddec77eb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGlRM1Z2d1JQUTVsS1daOExoSmVGQ2R2dHlVckJheWJObzdEdEJ1T29HMG0r?=
 =?utf-8?B?L1lrY2VpMk9ka0gyM3dlSVQ4WW9Oc2F5b2tsbnJyRHFRSm14MU5FREhGb2xq?=
 =?utf-8?B?OGhrdW5vM2xndWNKOExhWmNtbWZXeW5LR3ZVTDZ6OVN2eHRNWkF6cmZzL3hz?=
 =?utf-8?B?REVvZ3UxWGsrZEtCdzByc3RMdFVFRUN4V3N3V2o1NUxBUXYwVHZVZm1lWmZW?=
 =?utf-8?B?WVFyb0liNU11NU1NQWxiNURtMTNTK0s4elJZQkRTOWsrWGdWakVVZzlBVTYx?=
 =?utf-8?B?OXhoOHlkc0RyWUdTWTNIMW5uY1Nld3M3QmdqUDE0SGREWHdJOVBLUlJPMXlT?=
 =?utf-8?B?eTN0Ti85b2RZSFRFUTlqU2ZsWkZsMmNYY1BkYzVEaURNK2s0a09pcTZiNjNL?=
 =?utf-8?B?bUFOQWV4bkNQRDB0TGJiZmp1QTZTWGFzQVlKQkl1Yk80K3YzcGpvR2VMTzBL?=
 =?utf-8?B?VUVyd1EzYUNWU1lXbkxoVDdES1N1SDlhWnFqV002ZlRqT3VJcU5zeE5ESTNv?=
 =?utf-8?B?Z2RqU0ozR1hUdEZ0bjBBUVZlbmxtWmVHNXNxVmJ5akVJZ05ETTI4d1hXcGlx?=
 =?utf-8?B?dVhNUGlSVEN6WVErMkN6SEF1WVpibE9vWFV5L25Fb1ZMYmxZSmRFS0pWZms1?=
 =?utf-8?B?Ujg1cGUxZy90ODZKaXNKWHJGMzFKZjBoa1BndjVmYmxVbUFmZk5qUHdCWWFn?=
 =?utf-8?B?dlVDRXBxZ0NOd3d5RXQwbUNzQzVFNzk0Y2VNaHhBN01mUkd4bWtjTzBCRjlk?=
 =?utf-8?B?WnN3VWZVSjhDUTM3bW54cGQ0c3dOY1NkNVdwTHh2R2hlTDV6N2lmbjEyaWY3?=
 =?utf-8?B?YWpJa2JWWis2RXd6YkROcTlvSXgySjd3VzN1c1FwWldXeG5KNW1zQWZUV2tl?=
 =?utf-8?B?WnRIcDlCbU9OaXY5dk10akZZZm80bmZQdXByVzhKaENWZUsxZ3BuY0ZDVEo1?=
 =?utf-8?B?NEJWMDRINkY2Z0x1N1EwZGN4ODcvRnBGK1MrTU8vY1Z0Z3kzTUIrbHd6a2hR?=
 =?utf-8?B?R21EczFMTkhqOE5jS0RSRVdLZCtUYW1hcTlHYktGa2lEL2VTdUZWVEZwSTVM?=
 =?utf-8?B?ZjBuNkNubUJRS3Btc0ZMVTVnN2UyemROODdtZGVIR2IvOHJEMmlhbzFPZGJh?=
 =?utf-8?B?a1hwd1NadTh3OFdEZm9Rck42dUtBN2h0c2ZNdkpSYnd3R2NDWlc5UzJCQ0Na?=
 =?utf-8?B?ZzRmaHNmWTZFQzk2aS9pYTlsZGhaOVpZaHc2djlPL1lHdDdNYW5YSDBxZC8v?=
 =?utf-8?B?RTRTckJhQnJCMnlMOElDRFVOY2ZsNFdZUUh2d0dRT2Q4MEJRVUVaMnc2ZTcz?=
 =?utf-8?B?VkNWTmgzV2ZXSTcycVMxY1daazVka1BzK25Jb1RNUXFkREY5ZTBManBmZ054?=
 =?utf-8?B?b0kybjlsWUtUTCtTYUtmS0kvcGNWR0JBY0VTYXgxVkJRMXFEQkxvWGViZ0g2?=
 =?utf-8?B?NVVWT3MvenV5d3MraWNBb2VXMmpTUFpLbzBZdVNVYmJoaTZnd21JZ045SU44?=
 =?utf-8?B?ODNPVG43aU84K2FhUXBVVEMvYkdoRFZmUmJUNU0zc25OeE9LL09WSFZwb1pt?=
 =?utf-8?B?ZjlkaTZpYkpwZkFsS1hyZk1lQUcydUVJTTN2MVBUbUVpQ054dS9RZ0lTY1pk?=
 =?utf-8?B?SlRsQjVDWFN1NXIwT1l4emU3UzFWMjFjV05FYWY2U01LOUQ4MS9RWkFRc2hO?=
 =?utf-8?B?bmwrbzRVZDF1aEpuVFNVa2k4RkNDOGJxQTlnL2k1T3pMb3BNWi9XOGFTMmlw?=
 =?utf-8?B?aFFxWWQ4RkhpUDNRRHpaOXRLZyt5UU4rSnc5TXUrYVhLZ0kxclF5WjlibkZk?=
 =?utf-8?B?QzFKZitaN3ZrNUMwNlRvNlJOaGNTZTE3Q242Qm0rWll3V0J0K0VwdGs2LzVM?=
 =?utf-8?Q?U2C/a8lbmJh23?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmQ5eFA5WVVOMTR5MDFTVWJRV0RuaDNoV21ST1hGbDBEQVpDaENaemFTd2pH?=
 =?utf-8?B?WWVGRG1NcXJwMVpCRVZQS3pBZHRIT0RIV1JJQVErcTB6VkNhTElFN1RONUdH?=
 =?utf-8?B?MUl6VjYra3FGNWUzcDYzSisyd2puaGJrcWFlT1hkbFpLL3dCNFJlZS9zcDBy?=
 =?utf-8?B?dXU5RDM3SEZ3TW5GRitrOEQwaDgyVzRiZmIzSHFHMUpLNnVkRVB1Nlp6TGJs?=
 =?utf-8?B?UGs1aUF2SlA1U3BWU3ExdTNPcTc3L0xGeXBjcGtGN2hQZ3VQS2diaVA1WTVT?=
 =?utf-8?B?VmFQeUR5NXNYTmJzMHFJajJqZ2YvL1V4dWEyZEZoMEQ3TmFzR2gvQjMvZkxU?=
 =?utf-8?B?aTg5bzVLcTdSNm5OdGJiQm8wVWUvVGo4K2xuT3lvVFhKaTArYzlNSDJRRisy?=
 =?utf-8?B?Z2dDNVNmTE9YQ3NaTnJHYUxYajUvQmVtL0NxOU5SNktsbzBJVnk5dmo2RFpw?=
 =?utf-8?B?NlFVY3ppVWtQVUNJVmtDVXJIdkRYY3Y5bUV5UEg2L1NHMSs3RkkweVJzbU1Z?=
 =?utf-8?B?MW1RV25vT2lWalpUT0h4Tm9LcWNTM1V1NnVTdzJUK3paaStqb0daazl4OUpk?=
 =?utf-8?B?NnF3SHF6ZWZwQVNMUlhmd0RrQkxFckdnYVNvdDc1cUluTjUzSkVRK3BmaFVL?=
 =?utf-8?B?MVVoOHFsQ2ZsQzFFZGdlOWlkWTFmNEVNd1JlN1I5T1JFMmRuVWZsUFJ5aUE0?=
 =?utf-8?B?dWNtVDRBWHVrVHFVNnlqd2lOcW45aTZCcExYSzhSbDZXc3ZxWWJ0L0t1TGFv?=
 =?utf-8?B?VmsyL0pQQVRhNDAwUGNGbzk1QjdOT25mWkpLc1RxbTJLMGpZNGNEeDZLSUNJ?=
 =?utf-8?B?cDI1OVpET2tETS9GTDV0eWNPM1Z4dG9namFmYVRrcm5sK096am9XOEM3L1lm?=
 =?utf-8?B?czlpazdGdG5rN1JwQTNDUlRrSlpvQ09QaVpldmNSZVVTUWF4c0czcm5MLzR1?=
 =?utf-8?B?a0NIdUZ6SmJCdnJWQmtsUlJsNDh0SHFIWHdqSnVIUGNOR3E0ekh5Mll0OFJk?=
 =?utf-8?B?QTVrOWJDK2djSW9BL3hIejNZTDg3aHl3U3pLRXlIZEh1TldYOU40eXN2d3Nm?=
 =?utf-8?B?Y3crSDlubFlrTzJWQTgya1A5cEpoQ3VTdks3WUlTQk4xc05BREpiV1Blb2Ey?=
 =?utf-8?B?cE5lUHNWZVNGdG9QUVlnc09KNTU2bVRnL2IzeVloYWlrL2R3dC9jYldCL0M0?=
 =?utf-8?B?NlpiY2Y5M1NUUnhHcm9sQ2dQaHprUXcwR3djTEI2MDdCdEpLMSsxWDZnTytF?=
 =?utf-8?B?dmFiRFcvV3ZrdHRROFB0YTRMNjVjekxpRjh2dDNtZ2wxNi84aUQ3OHBocXZK?=
 =?utf-8?B?amtWanczdUVZc1ZMcWxtSDZVekhQYXk2Y3BBUkVmem9VMGZJYmdvU09FVHRW?=
 =?utf-8?B?Lzl0dW8wZmVVNGpVS0Zpc0xEbnl1WVhQR1g3cFR5NGpmREZLNUpvOERiVzY1?=
 =?utf-8?B?UHpmbVZvR0VJV3RVaExBT0owQWsxSDhmbWpZVjlYbHRMeXc2WnBKOCtzM0Q5?=
 =?utf-8?B?MEhnYTlKb2hVS0p2T1lpK1ExTXhRMCswVzY1Ny81bXlTSW54YSttd2JjTEsz?=
 =?utf-8?B?bmZQWEUwTkVBL1UzT0EzTkJGYzVCd3BFYld5cUlrOXNyMTJJVjluVDRmQ2Y5?=
 =?utf-8?B?ZUZKZk9aWHE3b1RoMncvbVgwY1BZNFYzYUZTYkNNNGgyRUQrRVZkeVR2QkxX?=
 =?utf-8?B?bXlxSTVlU0dJWEV4ZGxQTmVNeEVyMnlyOUd5WC8xUVpQMm1CNm1hOHFMQ2dm?=
 =?utf-8?B?Vm5Vdm1idmxNQ0JCK0NQTXc5ZE1WeDlINTZPRVpaZkwwM1BDSVByV2hON0tu?=
 =?utf-8?B?L2VmbjQ1OVhTT2lTSkxOMGFzWUhyc2o0enlpMjZXOXZYOW1rcHl6UjlHRnFZ?=
 =?utf-8?B?Vm5UREVySHV1ZXB6VmY5RHVuZmhrd1lrbmhZMjIrV3R4bk5Ia2RLZEFIdGQx?=
 =?utf-8?B?Mk94YzFadVNtNWhRNzhXZGNNMXMyY3d3djhGQzcyeFFHWXpCMW8zVXpMWmt4?=
 =?utf-8?B?QUMvVE1WQ3ZRNGZjMGhKNFF5YUpDb1haSERMa1lYY3grZHpTMmRsZm93MXlz?=
 =?utf-8?B?dWZaak1ieUl0MlBsWGJVWUd4MzVRdW9uYmQ1c2lmTTdTSmVxM29weHM5cG9F?=
 =?utf-8?Q?DXhbCLt0KW7YGol/yPEEx+0U1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2635a7a-9bcd-4514-464b-08ddec77eb41
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 12:29:55.1769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrGFPUJFM/8g13J80+OhBtMepnr29cr6buekESOBWMSFT0zBiS08RceSmxQhL/gH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254



On 9/5/25 13:30, Jonathan Cameron wrote:
> On Fri, 5 Sep 2025 10:41:44 +0200
> Michal Simek <michal.simek@amd.com> wrote:
> 
>> From: Salih Erim <salih.erim@amd.com>
>>
>> Add devicetree documentation for Xilinx Sysmon IP which is used for
>> internal chip monitoring on Xilinx Versal SOCs.
>>
>> Co-developed-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
>> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
>> Co-developed-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>
>> Signed-off-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>
>> Signed-off-by: Salih Erim <salih.erim@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   .../bindings/iio/adc/xlnx,versal-sysmon.yaml  | 235 ++++++++++++++++++
>>   1 file changed, 235 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
>> new file mode 100644
>> index 000000000000..a768395cade7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
>> @@ -0,0 +1,235 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/xlnx,versal-sysmon.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx Versal Sysmon
>> +
>> +maintainers:
>> +  - Salih Erim <salih.erim@amd.com>
>> +
>> +description:
>> +  The Xilinx Sysmon provides on-chip monitoring and control for the supply
>> +  voltages and temperatures across the chip. Since there are only 160 supply
>> +  voltage registers and 184 measurement points, there is no constant mapping
>> +  of supply voltage registers and the measurement points. User has to select
>> +  the voltages to monitor in design tool. Depending on the selection, a voltage
>> +  supply gets mapped to one of the supply registers. So, this mapping information
>> +  is provided via description which contain the information of name of
>> +   the supply enabled and the supply register it maps to.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: xlnx,versal-sysmon
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: Sysmon Registers.
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description: Interrupt line for Sysmon.
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +  '#io-channel-cells':
>> +    const: 0
>> +
>> +  xlnx,hbm:
>> +    type: boolean
>> +    description:
>> +      Exists if node refers to a HBM (High Bandwidth Memory) SLR (Super Logic Region).
>> +
>> +  xlnx,nodeid:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      PLM specified sysmon node id.
>> +
>> +  xlnx,numaiechannels:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 64
>> +    description:
>> +      Total number of sysmon satellites close to AI Engine exposed as channels.
> 
> Feels like some use - would make this easier to parse.  xlnx,num-aie-channels.
> Similar to the next one. How is this related to the number of child nodes?

it is number of childs below. They can be calculated to get this number.

> 
> 
>> +
>> +  xlnx,numchannels:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 160
>> +    description:
>> +      Number of supply channels enabled in the design.
> 
> Given you have subnodes called supplyxxx why is a count
> of those needed or is this not counting those?

possible.


> 
>> +
>> +patternProperties:
>> +  "^supply@([0-9]{1,2}|1[0-5][0-9])$":
>> +    type: object
>> +    description:
>> +      Represents the supplies configured in the design.
>> +
>> +    properties:
>> +      reg:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        minimum: 0
>> +        maximum: 159
>> +        description:
>> +          The supply number associated with the voltage.
>> +
>> +      xlnx,name:
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        description:
>> +          Name of the supply enabled
> 
> Would the generic property "label" be useable here?

label should be fine.


> 
>> +
>> +      xlnx,bipolar:
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +        description:
>> +          If the supply has a bipolar type and the output will be signed.
> 
> This is very generic.  We have it described for ADC channels already in
> bindings/iio/adc/adc.yaml.  Why can't we use that here?

no issue with it.
And likely
Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
should deprecated it and start to use new one.



> That binding does rely on matching against 'channel' for node names though.
> Where a 'type of channel' has been relevant IIRC we've always added
> a separate property rather than using the child node name.

Is this related to supply/temp channel name?

I think one issue with the binding is that current schema allows to define
supply@1  and also temp@1
but both of them have reg = <1> which is not allowed (duplicate unit-address).

Salih: What does this reg value means? Is it physical address where that sensor 
is placed?

> 
>> +
>> +    required:
>> +      - reg
>> +      - xlnx,name
>> +
>> +    additionalProperties: false
>> +
>> +  "^temp@([1-9]|[1-5][0-9]|6[0-4])$":
>> +    type: object
>> +    description:
>> +      Represents the sysmon temperature satellites.
>> +
>> +    properties:
>> +      reg:
>> +        minimum: 1
>> +        maximum: 64
>> +        description:
>> +          The sysmon temperature satellite number.
>> +
>> +      xlnx,aie-temp:
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +        description:
>> +          If present it indicates the temperature satellite is in
>> +          close proximity with AI Engine
> 
> This one seems unusual.  I guess it makes a configuration difference
> of some type.  I'll look at the code to see if that answers the question.

it is supposed to be identify location of this sensor.

> 
>> +
>> +      xlnx,name:
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        description:
>> +          Name of temperature satellite exposed
> 
> As above. label tends to get used for things like this.

no issue with this.
>> +
>> +    required:
>> +      - reg
>> +      - xlnx,name
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - xlnx,numchannels
>> +
>> +additionalProperties: false
> 
Thanks,
Michal

