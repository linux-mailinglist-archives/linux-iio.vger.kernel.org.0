Return-Path: <linux-iio+bounces-22255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AFEB19BDE
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 09:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE0A3A9005
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 07:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D947E1DED63;
	Mon,  4 Aug 2025 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Mv5iLJ9g"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010003.outbound.protection.outlook.com [52.101.84.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF58F4A
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290823; cv=fail; b=IyBmPhl6TldIHHIx0M0wf7ki+9XWcMFSnMvWy4p6bWxlzNiLSQ8NfaJByK2AqEdno70QQlk/LmyVRh2DhcD95kEPBuDx9QLEohPvW/cdwbAyiJjf7rJnJBLpXeKh88/aV0CI4KAZvC1+T7R8Y0dRSU2ELphEOvRneXjiB3/UaAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290823; c=relaxed/simple;
	bh=vvaxHDOgXsN70kYrot0RlPLVHdttqELuNPN3SKt4zkQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LQ63IJ7Za6a6znsEyxTXVgUfrUlMncjqmoeQniLUsLW+PDmcDcUt4yytVVA5FjkaPKssqVLNGQsBpfAHaqtjEdcinEyfX5wCAWcNwQy3z2GSd+Uz5YXxtVhFW1id/DHm0oCCUNk6tBiIq6BEZEYizNBpCbP4P+uMKPQCRtvP2KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Mv5iLJ9g; arc=fail smtp.client-ip=52.101.84.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tk3kayD/ImS7RrJ3Ky4OhA+HYSPCjfbsiKLHqryIrOYCpB1TEuFU103EDzOVpFhB6LGjvh53ZncPjH88UJtB39s7DK0pQm7Lwij7Sq1zbsA7r+YVyu2gkRWOWrm2Kj5IBGMt7eyHz7MFI+/COMO/hojnMCIDCQ3oQUrur3jBhSj/VqTYIhtTQGtDbvql9V6HbYy1CgmXrcTuB2ROZ4Fv9CI13zIAr/U9zMNNhm5S8MpJ1tBfJJZgPV3wmGvVt0M5iAupqneXfOzXYET9XigifVCsOB4g8gNHfDNpYYeIYLeNnibaXml/z+g+0dlA5vRQBS+x/ObkPFF70caL5Rp8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OI2iDfgI768mMI8VbkDVd+Mc60IxfafobyTyn0PpnDQ=;
 b=iuJ88/+FEqWXWVWfj+NOocspUiq7zkCijcR67ef7NK8CGKgL3NpzyAGxKM7ENXQH2v3P066z8JnQp6ctu12JiQcEaI+4OsoXosa18Nn/LNNjjKTx/V/UNwuR6VCW/YYTHcs9Zcjus7yuEFBaJ4v+RJfaSEiE6Cy4yCUV7n8gLOEMVongfb7cf7SiFEFNcP24jTdezU2r79iSUw/xIs/9Gyycy2m9f8E8aK6WM5mjuIHWOqxAeDNAFs3s4SXlnsDwBA8QVlCpgRXBTKo84tWDYGToYVIya8X1+IdYHizyBi9wRssgQjscZQHspJw0qfJcC7zR8m8xfFcV3AFnOnqOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OI2iDfgI768mMI8VbkDVd+Mc60IxfafobyTyn0PpnDQ=;
 b=Mv5iLJ9gspRSo6jQPJbt+8u3nY4Jm+4YxE3EESpHocfZwROjGUTel+Aor3cFe0T3GJdLV+I+LMoFYuRprXn2W/xot9/wImZDsnzn6fec/qYGGLbrAEbpB4UDfojBPAcPx9cKSsHI78LO1/5mg8HTPMBGeulOo8UupTQP6N/itTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com (2603:10a6:20b:5a5::16)
 by DB4PR02MB9309.eurprd02.prod.outlook.com (2603:10a6:10:3ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Mon, 4 Aug
 2025 07:00:18 +0000
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::8927:53fe:9d2:cc22]) by AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::8927:53fe:9d2:cc22%3]) with mapi id 15.20.8989.013; Mon, 4 Aug 2025
 07:00:18 +0000
Message-ID: <442416b3-673b-4863-ae03-6de06e67b763@axis.com>
Date: Mon, 4 Aug 2025 09:00:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] iio: light: vcnl4000: Use a structure to make
 buffer arrangement explicit.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Abhash Jha <abhashkumarjha123@gmail.com>, Astrid Rost
 <astrid.rost@axis.com>, =?UTF-8?Q?M=C3=A5rten_Lindahl?=
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250802164436.515988-1-jic23@kernel.org>
 <20250802164436.515988-15-jic23@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?M=C3=A5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <20250802164436.515988-15-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0012.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::31) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|DB4PR02MB9309:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1e4dff-416d-498d-dbd4-08ddd324923c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW1kMndLN2ZHM3dEYTlmcnpsS3MyZERWK1ZWWnI5Zktkb3VLSHNSZXA4enhF?=
 =?utf-8?B?blFDc0pYcXk5QkJ1d3lubFdRQkNVVlJjcE5rVERMQWFmczc5aVdxY1JIaVB1?=
 =?utf-8?B?dUpnMVVQZ0tQZVFKOStJc0JydTdoSVhqa0o1emxBWXNZV0hveTUrbmtpUE9m?=
 =?utf-8?B?Nmc5OGxoampZdktwb092OGE2QUl6RUZHL2xGTGlKUDA0TTBlWGNtYW9WRkpC?=
 =?utf-8?B?U0JKQmE5RXNEMzVSTUxLbEN6ZHdtQ2xkaDhLWURYZnozT1FYVGkvY2dQMlpa?=
 =?utf-8?B?VTZaVm5KNHJlTTc5eEhrMUlncjBTZTJEcTZneFVoTk1EMWtmbGVRc25JVXpG?=
 =?utf-8?B?M0hlRkl1TFJnMFI1TWNqL3BJOEh2M2NFdnMzYmlVY21NMFZvUkFZanlwVkVr?=
 =?utf-8?B?WHZSb0p0ZXlqdmRxeGNZcktiOWtYSmlvTUM3dU1Jd1ZLMi9PZ0daTU1TTVBt?=
 =?utf-8?B?MkYwV0xiWTZWZHAzUFlqYU5iVURWMmNoNnV0Mnh0bzBKYnpXd3FIR2ZncU51?=
 =?utf-8?B?clRPanprdnFpcUpmNEpEVml0c3RUSTdWOTNhaEcwTmlTVm0raDZFb0RVSHMv?=
 =?utf-8?B?cEpGU05Tem5kYmtyTmFxbkY5aEZRNW9CQzExZEZ2dVZacEk4TWJqdTBsUU5i?=
 =?utf-8?B?MTZmMldkSFhONXVtUEF2WDZJaENuNVpyNCswaDR4WVphUHpoc2xhemVLeHNC?=
 =?utf-8?B?akxZb29BdGNjZHNrQ1c5UGNYeHoxdW0rdDRLRHVjeXZTODJvKytmZEc5TE1N?=
 =?utf-8?B?SGlhcSsranlGb3NrYndiOU1zZzBtcjdmeXlzUngvL09aQTJnazJnMkNUWU1T?=
 =?utf-8?B?Ry9ZeXZUbG1DaHhpWnBaSlM1bm9MeEI4UnZsbGJjeTV6LzZrSW5uc3NsVGI1?=
 =?utf-8?B?SklXQzlGelhJZzJzRkd1WXEvTmxadlEwV25tNi9WZG5oemtYNEJReVdqam9l?=
 =?utf-8?B?MVJjbVpVSHRlWENtYVVna04wQ3B1RXgzWGUrSmhuTi9kZ1cxTi8zVUY1ZTlC?=
 =?utf-8?B?dzRaYmRlRHVkQWZmcTNmSFdtb0hNNWlRWGgyOW1OdnpBRTdsQmhJSklLWDRp?=
 =?utf-8?B?bngxd3NWc1pTRmVYK3U2SmlGRnhkbXhqcmczUTBzUXVMZGxaMTBMbk5lWkdZ?=
 =?utf-8?B?UGk0VVBGWE5vQmJyZlczYnZVbWova2k1NUk1cHk2c3hBaHhYS2RUNW1PSUVF?=
 =?utf-8?B?ZXV2Ty9SYlljY2tJdXdacDVkYzNKSFJ3Q3JZMmtIWHVZWXhaUUlmTUxDTVNs?=
 =?utf-8?B?NGZrcTJlRFZnQ1cxbTZqa0VBNDVTVko2SUgwQTBzeDd1ejRjaHlsa0FKN2dJ?=
 =?utf-8?B?cHVXQUg0MDNwMGt6VGc3S0RuRnZwY3ZCOXVYK0t6UWdBSzRBK2R6azJoSlBH?=
 =?utf-8?B?NXBwRyt1UU4vZVQzUFBNY2Q3TWNVM0pXTzVuYlZCak9WNFJISSsvck5ZOUV0?=
 =?utf-8?B?bWZsWkhiVmdpSHBKV3VUbHVmei9RYnRnV2RZdFhpQTVLRll5Mjk4bXlRU21R?=
 =?utf-8?B?OWpPUWN1Y1dDSDhNb09LSzNSR09hQ2VLRUk3dE5jSmVYU0U5OVVON0FNOERY?=
 =?utf-8?B?ZytrYnk5Y3FZcXcwZC9CT1ZhVEdSQ0ZMZ0dCaklDcnRIaFFnNm1UN1VKRnpo?=
 =?utf-8?B?ZDZRMTlLVysyRVdiY092clZ5d0Q1UGxJTHhzQWxpd2QwcUhURSsrK0FyRXhp?=
 =?utf-8?B?cFgvY1Nvd2hlVjc1ZitFY0tPQTAxaE8rdDZpRDVGZUtTSURuTUVicTFkMmFp?=
 =?utf-8?B?UG5GenJLb05nTUk2Rm55TGJ3TkVQYWpXekYvaTRTQUhhWFFhbDhKNFN6UXly?=
 =?utf-8?B?RWQ3VWN0aXF4RjBIWFBCbmNUQXJUeFMyaEZmdnhFRmhEcUg1SVNPeGdCKzFp?=
 =?utf-8?B?M25DbmpWMzYxZHhiMENjZGprMXloUEFMT3FrNWJua05KSWhuby9nYm04c3hC?=
 =?utf-8?Q?7A/D9vVwwSM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0xGaUhzWDN4aG9UME5rUm1tc0tTM1h6ZGtVVGlYNFg0ejBHWkU4WGpxWUk2?=
 =?utf-8?B?Yi9QSkFSdjFGbmdyZFB6clIvR25vZ0Z2YUtna1h5ZDM5T2prQ2hMVzMzRWZu?=
 =?utf-8?B?M0lCUUxTVDNMd2EwdUg4L2NkRk1TMzVKYTJ0bHFOMHF0WkxpNHNwWmo4MW9j?=
 =?utf-8?B?ZXJjbTVDcmN4eUxtOGd2d0hxYUxkdHJHckNqdWJRQTBNVmZnbE43T3lNd1M5?=
 =?utf-8?B?blUyYTlEaTRhM1pYR1paMFFmeVc0MUNIZzhTaE1JZGhGWjhoMVMrRURZMCtk?=
 =?utf-8?B?enFJNzlRS2U1ZDVLODFjRFlnbWlRSzF0d1NNVHhtemxqL2dqU3duSWpsTmpT?=
 =?utf-8?B?djV3SWp5WERLYTQ0TkkzV2hMbDRCYWF0OXh1dUwxQjg3ZW1yYjFoeXltdEVa?=
 =?utf-8?B?RzJqSFE3amdxTHJ2WTRXS2JPaFFhVDVXeXNKbUh6QzVvLzBab0E3NW85SUtV?=
 =?utf-8?B?Qk5Xa1BraXFQeG1haGFuTWN0S3d0OFNGcyt2SE1HZEdlRVo5Sk5Ob25yQ0lE?=
 =?utf-8?B?MlFJOXhaUmg0SnVtNGZUUVU2MXJvOC93cjhGZmJ3VUJqVlRzNjNpbnE1ZjlQ?=
 =?utf-8?B?NGI2Y29DQWN5TEROdHJTMHVLdTBDS0QzdEdCYXc4aEdDYVR0bjZYRHlVUld2?=
 =?utf-8?B?enVJM3JmaUpETC94ZGphWXIzYmF2TkxXTWk3T2Vyd0tTSXVtZi96Qjh3eVo5?=
 =?utf-8?B?RUJpeUNsMmc0Z2ZEVHUwY2pPb1dOVGFDK0haOUd4QnNZMHp1K1B1NUliODRm?=
 =?utf-8?B?djdUdXUrUUltdnVlbFdNQ3NPTjdvekJIREJ1Vi9TWmFUMk9TUXB4TzFyajJa?=
 =?utf-8?B?VjU3OVNKNEROb256eVRiR3ZtYXdiUmFKYVMzT2ltN3NIWis4ZWlnRFc5dFpl?=
 =?utf-8?B?aTRQNjB1eHpnSjFqdCtKT0Zrb0x0N3puNW5IZ2ZjVzNPVEdIMnhndVdXQmI5?=
 =?utf-8?B?aXhRc3h1c3NJVERrWUZqZTlQQzBkd2tYZ1NOOWtobTRobk0yaitERDFtZ29M?=
 =?utf-8?B?MTVURmtiOVN2SlptN2RxTlo5RzBYcDZnVnZxNzgyOUFHSDNLM0l0ZEdhQjZQ?=
 =?utf-8?B?RnNHY0N3NDJIUytBZUlubCtwNm5PZ0dUTkwvR3laWnkrank3MUVzdkxGSlpl?=
 =?utf-8?B?K0FCUnFhaWNnWW5RWWlHVjlMVVRDa0FIMmE2a25xdzE0dHBsTTV5LzRkN3Nx?=
 =?utf-8?B?azFyb3lvN2lYRlVGb3hPemhmOHFwZmF4QjNPVVBRcjBLV1JzMXRHQTRnTVgw?=
 =?utf-8?B?NXpHQ0pVUDdWMUdDcmhoamd3bk9OVUZuS0FEU1VCQnJZR3daMjdrQWJyS3Nw?=
 =?utf-8?B?ditxVXZDaVh6VHZCQUxSNDQ1MXVLY29NU2xZS3lyYXJGaEp5bkVicGxDa3p5?=
 =?utf-8?B?QmlsSlRoc0hrZVd1TjZyUlMrNXRTMVo0bGxEZk9KQk9NUkZCZXc1dUdJMG9L?=
 =?utf-8?B?U3VOMG9QU2VYZ05lM25NbzVTQ0Ivc3dHa0ovcGhobDlQUWlPM0JDbCtUQTMv?=
 =?utf-8?B?c1BvYzcvMEhnNU5XMzBHWXlta2I4MnE5S0pXSllXYWV1d0NmRXdQQm9hZkxO?=
 =?utf-8?B?UGlaTnlycFBqUEcrcC9KRm9MbmJNeDVMNmJWZGFuOExNeTU2K0Y1Z0xYUkhZ?=
 =?utf-8?B?eENvM01RMmxlUjdVTjZKWW9DK1lFV0NJMzQ1UGN2WVg0d3Z1VWF3ajg2czZi?=
 =?utf-8?B?T2J3SlJWd3VGQ0ZKVkVwRXN5NThxSWNXTmdhaDV3alU5NHZoMzhobUg4a2p5?=
 =?utf-8?B?dS9URU9WSHh3L0RiclkzSEt2VVZhZmYzZUF6cjZIQ1VYbE5RUk9ScW5NOURw?=
 =?utf-8?B?VWJEaEFuNHk3WTVReEtlR1ZqRjAreDdDSDFWTy8wUWRtbHg5QUlKcW1XTVF2?=
 =?utf-8?B?QnB0R0s0QTlNRjdYbEUrTDFud0IxTStaV2MvTmNleFp4RWNNZmtuZkVMeTRh?=
 =?utf-8?B?dXQrS1ovTUYwTW5hb2E4SXllZXNEZTNtNTFwU2pLK2tPUWh2ZmRmOEc2VFpG?=
 =?utf-8?B?ZmE1Q2JrUGQ5TUMwUWFzMnNlb2c3bGlwdXRLa2piWkFDOEdudVdTeDNYazNK?=
 =?utf-8?B?RXVjMDhZVjB6UHU5YVdNZy9ZYTdBYkxTb3ptRDI5M2dLbWNHdHlIbk1GWXAx?=
 =?utf-8?Q?KsJhxp4ZiX+YwmTJLqziZYIK4?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1e4dff-416d-498d-dbd4-08ddd324923c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 07:00:18.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oABioeVMH54zs21laIUd/HJE3uyD6ZCVK2dCv+8TDzVQkKHUGi0nun2DC7w8N3zk/XiecTb7W0/95B9opjwWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB9309

Reviewed-by: Mårten Lindahl <marten.lindahl@axis.com>

Kind regards

Mårten

On 8/2/25 18:44, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Removes the need for comments to describe the buffer passed to
> iio_push_to_buffers_with_timestamp().
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Astrid Rost <astrid.rost@axis.com>
> Cc: Mårten Lindahl <marten.lindahl@axis.com>
> ---
>   drivers/iio/light/vcnl4000.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 90e7d4421abf..eccf690eae8c 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -1662,7 +1662,10 @@ static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
>   	struct iio_dev *indio_dev = pf->indio_dev;
>   	struct vcnl4000_data *data = iio_priv(indio_dev);
>   	const unsigned long *active_scan_mask = indio_dev->active_scan_mask;
> -	u16 buffer[8] __aligned(8) = {0}; /* 1x16-bit + naturally aligned ts */
> +	struct {
> +		u16 chan;
> +		aligned_s64 ts;
> +	} scan = { };
>   	bool data_read = false;
>   	unsigned long isr;
>   	int val = 0;
> @@ -1682,7 +1685,7 @@ static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
>   			if (ret < 0)
>   				goto end;
>   
> -			buffer[0] = val;
> +			scan.chan = val;
>   			data_read = true;
>   		}
>   	}
> @@ -1695,7 +1698,7 @@ static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
>   	if (!data_read)
>   		goto end;
>   
> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
>   					   iio_get_time_ns(indio_dev));
>   
>   end:

