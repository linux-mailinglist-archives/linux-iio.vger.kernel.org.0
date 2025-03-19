Return-Path: <linux-iio+bounces-17129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060F9A69AB0
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 22:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872DB3A2CF2
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 21:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F8820FA98;
	Wed, 19 Mar 2025 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="eW+jD81P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A29190470;
	Wed, 19 Mar 2025 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418915; cv=fail; b=EPuWQ4M/lzgxudkxcWSXIStMQ2hVh0lEZWLrUHlrCd501WVB+9LuFiOSKPGih82tVaSuOMxgaIFQJ7MiMDJSNP5fNADAmAxvC6kGrkJDRQ93KB9heH1kPo2ENnbwTHXmeTKEYKSmHtdTK52IxkngDaWVW5N/wBaMh26jE0AJWZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418915; c=relaxed/simple;
	bh=Xyiwo+TK/bN7Y1NUDTofYFedLNfC6oHj/kPbH0P+ePY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qPgLLvhoYtpai31MuXC3T5gQRlcBdoR7mmIngTxTtconhZINGZ6AOp2guAO6ss5Oa5q+w3z6fJnJTRPRw8MZ1ZcWS8V4pow/wjBvN4vCEJNLyhCEfOMoRFaRjHzwa3Mq2F5hW7dSaViAiIvYslHMcQqOo6tSH5UMyvjs3oWo4Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=eW+jD81P; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JKuJXS014218;
	Wed, 19 Mar 2025 21:06:49 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazlp17012054.outbound.protection.outlook.com [40.93.78.54])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 45d2wkktd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 21:06:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj40pD67iK3QgN95y8xDvwgD7F1Y/4yuITr1QPc0lnjKqS7WOOdFNoouEzgWUhWiBhHlo9/fBuxUkFgSdO1SqYjJe5g4XhmZVKTwlucpEJbnTS3RY1ESvJZHV8vgPt69TheS4JBVA7vGMzNcAENbCd8OTSrbcngcycWjxnfoSzK3ySqtL1SEtCp/9tLtmAG+jiY7X5eXCRvBYF/myxNqXsPYbmsV1LXlfIhLpFhvXxFKfheHBjsIJiCQDtqfRdR2bbs/oGi5fgPCteJDlKFDgSueDt1AOBda7uryHt7BuyfWZ3s0ikvqKKU25SXbVgwkzaqXDEvYu2I8heEoKZ9KUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9XCeriU/Qr5PhuWBB5JKOvwARVAX+uBZiDBqmJg2tI=;
 b=C7BWBNiaRbSac4rQAsb3sGDO/jstiup7uY3zfjgQaJUQVeDjDyGuBNZyy2hbSI/5P4LlRi1xF2/4js7Ak55Lv77Pz06cpGJSzxDkpOBBo/9J6liJvqF8tHR0LzFA3d4nhVFN7NLR4IWoaE3K/iqZFNtfdm2iQUW7sLEM6fxz4607lLsZ2UgJhWR8FtUBBJvYNCIzeerp9u4WaLVegnusYDXmQcGuzUNgnqil69TlW4XREkkZudl2hWEx/0m0R49Sl4586oTPoxR7Mn7vO4wYZDc3Lcu088yGS3QnQEXUJ2efY6nnbwLhAuZnr+1R3yW1VpNx+xL25jauSEhNTCT1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9XCeriU/Qr5PhuWBB5JKOvwARVAX+uBZiDBqmJg2tI=;
 b=eW+jD81PxFW896oj0fVQsYtDKYAZ3OFT2HszIJp7X2KzqQAlX0czwkUpyzTvIHiLqID9WsEpZllt6MQmMGhf8dB1P0EZl/BPlGbhiFAAvE2HNY6IeJBMQIykGoML5m8wjLyL5g7q0uP2PiyU3gGdV3f7TQQyVzYWQj3hvcsnA1TpFo3LiknnywU58WzEWH4xvJSq4JiQWQ6jsH02b8arAsMW9asL4VJ7qvBjELGxhHN2VLeUk5l7Ep04/SlLcGwQVBQS2HYKZsODOVEIgQ7rNcMz+9nde3wl9bI0ulr31/dAZ779MY+2x5SL/UeXwQL3shX7uGnvgCWYvV91ReHdPA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEZP281MB2549.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 21:06:42 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 21:06:41 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Jean-Baptiste Maneyrol via B4 Relay
	<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup functionality for
 Wake-on-Motion
Thread-Topic: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup functionality for
 Wake-on-Motion
Thread-Index: AQHbg9lX2uvVWSTYyEGDMQJusxdmZbNThDYAgBqodzSABnjIAIAGd3Pz
Date: Wed, 19 Mar 2025 21:06:41 +0000
Message-ID:
 <FR3P281MB175775CD8CDB29D7ACE8B544CED92@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com>
	<20250220-losd-3-inv-icm42600-add-wom-support-v1-2-9b937f986954@tdk.com>
	<20250222162224.60059025@jic23-huawei>
	<FR3P281MB17577B5BAF4C31E0C48F8504CED12@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <20250315181758.2aaaf10e@jic23-huawei>
In-Reply-To: <20250315181758.2aaaf10e@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEZP281MB2549:EE_
x-ms-office365-filtering-correlation-id: 947ff270-ce05-421c-25cf-08dd6729f284
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?B6JgDfq5ZyxwRkVFTiuYdxxnFZBLDOemU/DMpS7fnq2WIxrCm/ewZCAmOM?=
 =?iso-8859-1?Q?k2RYLM0Z6zhraMxlTAXCjXrs0XRSKGQBMvoCDbYN+11ftXbdj4+BpWAYsw?=
 =?iso-8859-1?Q?v3D5l0BTztAYbOFscoC3sFuW+xm/ONV+YJ91Cs6hOVe/dip/IcfRO5qZo4?=
 =?iso-8859-1?Q?O5iKorP1Pjr3EHQTYOAoN+ONS+NF5GRyY9DdoVD1MMx9SMtR9+pcDtHLbx?=
 =?iso-8859-1?Q?sIis0i8vb5jQ+6boeweMvhX+rMFa/YT9UBbdMe3/zXNekfEwKz/AL3zXUU?=
 =?iso-8859-1?Q?NPBv8s9Jn3lJiHVAmvi/bkUvVzUPeHzhqtbsjU8HzWCKev+5BoxqFCzc7x?=
 =?iso-8859-1?Q?77EsjNs7FTFsQn6KOjdE5SCOxrQ6Oh/MmbQHDQwRmviP4igfY31oGnNybH?=
 =?iso-8859-1?Q?wnj7CbkaFetOJSw9KJWCev+VnW9iF1irLOe3885ITA7UMjCq4E/8XaZvdT?=
 =?iso-8859-1?Q?uhdYCtPMDc1EOp2VIqKqvhmJH0X5Bwzid9dw6VjzV0ZBYPevLdclboDaOt?=
 =?iso-8859-1?Q?0yyWb1cC0G6hsu6nffEw2LyTsdUslq+71Hq7OL0epBAj4xDRj3cPvp573H?=
 =?iso-8859-1?Q?3gMxNIB97qQ7MVVQkwRyIUAmW79ilOCtLmjJKyFXMgmBfWLJo6g/y8ZTvu?=
 =?iso-8859-1?Q?wHUcVfHJNOiQNZ1252D7iXmS61FEE0Ji+wzlT6cwl9X5W9cysVqHADP0Pe?=
 =?iso-8859-1?Q?BgWqy9Lfh8Jynh/xUxgTJiHsfJnLDfUKV3SY96v9lkOTAt5t1aM2jg/9/N?=
 =?iso-8859-1?Q?dlPtU04FSSsOhHy5waV6gbPb4bMCQmgIBAzO8IzzpeJhhRZb89jdNLjjEi?=
 =?iso-8859-1?Q?hPXTJK4X8wZ5jpRP/2mQumyV5Qz20nGQEZU9poCoIpwHLwra7HwaoedyO5?=
 =?iso-8859-1?Q?K3qTspBeEPJq7gD3nnxpd1Hu6I+tcH0hcX6bnrEp6F/IAzl0iUi6zw9Wm0?=
 =?iso-8859-1?Q?XmJNeS85rzkEII1F5+eaJqbiMGrVbf+kKJJRQo/iDDNbT1Xi2Uq3xnmIzS?=
 =?iso-8859-1?Q?utMog0M/vh+cOWmiaArtLcyu+/SllKHcHQVajCx4bBO59rTzv44epeH/Ph?=
 =?iso-8859-1?Q?4R73XdNn7O/N34Z59c09GyqlLgQJCiArbNSllcCejBhqo1r/DU+iOBajK4?=
 =?iso-8859-1?Q?oEcKfT/w5Aq+0Cd03+3MOru77yH84hLmTYYVRjjucpLYOlQ4HtwBonuOd8?=
 =?iso-8859-1?Q?nFg1rSXAgKwOnYis5TtVtIvmaxk/N7WvxOdsfS+Mcl0ly0e+zq21bPAR/N?=
 =?iso-8859-1?Q?NonRmbCuiVEbeeZ4l+OjvXVaAGMnINZInpEZJWW9nlB2B3YGNPgzVzw6zW?=
 =?iso-8859-1?Q?bFAICq1ne+C0vLf/+/s4i2kgqFvGgIxenGKgLtcEv93CdVp+eL2aVIodX3?=
 =?iso-8859-1?Q?vNE33c2ASXKVKxCqP75s6o4WDyGDeXACW/mraPN4ecI3hU4vMytoFeV81d?=
 =?iso-8859-1?Q?hAAOoSjD8MVacDoIZgmqar1VAKtEOIFLGvsqJx2YRjIn8wJxFdbHISp3tw?=
 =?iso-8859-1?Q?uwWwUyGu08E12fuE+g4k5ZvdU5bvFgCSBt1t3sCl/RO4bPU8WzQHXV8aNr?=
 =?iso-8859-1?Q?7J2BxHEsJf/e3Va7dynydrz1O7vf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?F3O19YnfntsxmZ0qsxBvRououiKn3ZetUVeXrmv8j9GoNcknb/HLAUxiAH?=
 =?iso-8859-1?Q?QT7UcJv0h1ADDmg5IRKnefupLv17uJVJjqrFQCAMTTXN7KX0E23jwb9Rhb?=
 =?iso-8859-1?Q?vHwok2gvjGkQbSXJrlHF9ZeOfuTu2xnN7Ivd808FP7upcrNNcFs1CIqxE2?=
 =?iso-8859-1?Q?s8e4CCEfWuKIFhcsLrXzy4tJdO/fw8H+8g0RAsgYVb9MDfNMKXpwFjBIqt?=
 =?iso-8859-1?Q?oo3qnFzglR+EC4KWcb9WSo5DqnAfgCh61ZHkRmdTRaFAi38b47KsgXgSlL?=
 =?iso-8859-1?Q?W7bKRaTnZ6DszlkH83rH/XeYHLOSgGg+Sbmg02h17MnhPXL/v0hb0Ct14E?=
 =?iso-8859-1?Q?b5HaSy8S+O01Khmo/Ea8OrbqXLKA443FbkBb9UqCYMiCyjvYf6ZfKtx2y2?=
 =?iso-8859-1?Q?LQjw682IgTXzDXLs6T4mudD+WBq+G9kBo5AWr3hKyBLU1D7gQBf2uBOiKu?=
 =?iso-8859-1?Q?zQLbBM47+emRt3dTprXmss+F6xsARZBrksJFAN1d/6voCU+6GhaT104ZQN?=
 =?iso-8859-1?Q?20vkpf4zTNXQa8Oa9yIszkfRYCYqY9oWRFhb/GVzaZipo7+xf+Z6ojhsJF?=
 =?iso-8859-1?Q?iE6oIWeGru0hCuIJae+WjNPuGCZJtqlxHjalRvnMR/QmJyWMyNnGyMPSv7?=
 =?iso-8859-1?Q?TgILUkUr8nJdInN423cv7/9SAsIFrVigpq5fzUQ3kc7YrlS8YFvBYZhxFO?=
 =?iso-8859-1?Q?FB/eMPXeYObhZ/jhvp1S9OhkvpNKAH6QScmm7A52SltTPd9/UjU7ulmHvK?=
 =?iso-8859-1?Q?hkHZdWxe0lMy9qJ7jtEMHpMR+6Fn2tejmE8Toch1I+pyYzgTDKaXOqu+Tz?=
 =?iso-8859-1?Q?16finsZQIcUd0fiK/ONFeh5mnmX6mlGDjJYVwSgyPwPy0UX5Cyjs3qoK89?=
 =?iso-8859-1?Q?Qr9gMgo6pF0oDlQbwtGn8jdUu2NAIabvGWM3QbizYu11XM2FVWba7DMBHx?=
 =?iso-8859-1?Q?NJ+dOeWj3lo3wQyAQKsgXIt/fxq8OAAoSuAuxbyZOsMPogUDOwFkV7p7r3?=
 =?iso-8859-1?Q?13xwP4Y0rH3uqVZHinVHV9gQVLLplUetm8afBuRWSNtxyw1eYcyI2aINNS?=
 =?iso-8859-1?Q?okwQiEiAWe8L4wj98wHwRconWC6tS3VKOMS3UXmno12ZBxPtSYbQE3+3KX?=
 =?iso-8859-1?Q?rGFCmwqg2/sdmOQr56EH2UN8g5++XqTw0stbFgTIGAFQua5l2cezcR0x1E?=
 =?iso-8859-1?Q?DoH5H4ONCie32oAl7vKpUwIPi0AVdNrNNPSLxrPqgG+KMK5Whu+yFBpljj?=
 =?iso-8859-1?Q?XgYM1/rDnETjx1uH3MHgGs2kUsDOeybYA2hKJeBaxAcvBzx8jJSs2B8vqc?=
 =?iso-8859-1?Q?0rujBD6myIeD3t+ban+KasyuM6fhebR9KxmSGpVBSCBl8NKfpaHlHZtK+W?=
 =?iso-8859-1?Q?jClvTZjOsh0jv/34B8hhXsyGlYPEyRwLnj1BtcBxTtFbEPU0ueQ5rA2w6n?=
 =?iso-8859-1?Q?VzNy+60reg+N9vZiW/He3TtoIPpxKD6k7CS4PZeFecs2KZA/jj16rXChdd?=
 =?iso-8859-1?Q?PY/3i7tyiwjBoxlIdAIRN4R+/93Q/gMngPT+qvP3swY4PZngjlf5u259o8?=
 =?iso-8859-1?Q?0BOqNMUjt0vrzEZw62hiF+KyY5U38C6OlapeIiVLwOnxQ9+pOkoRgoYoXa?=
 =?iso-8859-1?Q?MrSei0ZXaeh3OmIpFLBdW6YbCh6PtVyrEamXBNZ3sLz8F72+X7jhRRFCPA?=
 =?iso-8859-1?Q?1qJFSf0j6KdUi7HodaPaWV1hgNrJ9SIfZiXzOFbKMhT5/K91RrWG3z90ei?=
 =?iso-8859-1?Q?2+dQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 947ff270-ce05-421c-25cf-08dd6729f284
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 21:06:41.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tcO7HS7fcfaS2A0pfzau/zdUdjw8D++Jx9d/txOm2X9hnryhlKRbecYRq1AMCIV5YMzoEQ51QuRPFvfP5caNjMGP7vHrOLqCSgfuoPDvnbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2549
X-Proofpoint-GUID: 9aJV-UTQUpIKZFnT32k_VxBkbRks40US
X-Proofpoint-ORIG-GUID: 9aJV-UTQUpIKZFnT32k_VxBkbRks40US
X-Authority-Analysis: v=2.4 cv=KJ9aDEFo c=1 sm=1 tr=0 ts=67db31e8 cx=c_pps a=w5n1bf+9uxWZZxVc/eFLww==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=YvLPLKCeur-NU4o4lZ8A:9 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_07,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190141

Hello Jonathan,=0A=
=0A=
I understand the issue, but using spi->irq for getting interrupt is somethi=
ng we are already doing inside the driver. I agree we need to fix that, but=
 I would prefer fixing it after adding WoM support.=0A=
=0A=
Is that OK for you? Or do I need to fix getting the right interrupt first?=
=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Saturday, March 15, 2025 19:17=0A=
To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Cc:=A0Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.t=
dk.com@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; linux-iio@vger.ke=
rnel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-k=
ernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup functionality=
 for Wake-on-Motion=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Tue, 11 Mar 2025 15:31:44 +0000=0A=
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:=0A=
=0A=
> Hello Jonathan,=0A=
> =0A=
> still sorry for not being able to reply in-line.=0A=
> =0A=
> No problem for all changes, except handling the 2 interrupt lines. Curren=
tly our driver only supports INT1 and cannot work with INT2, and this is no=
t related to Wake-on-Motion feature. This is something we could add in anot=
her series, and I prefer to have a dedicated series for that.=0A=
=0A=
You should check it isn't INT2 that you are getting via spi->irq etc.=0A=
Absolutely fine to reject that in the driver but you need to be=0A=
sure you have what you think you do and the spi->irq etc don't=0A=
provide that surety - they just give you the first one in the=0A=
dt-binding.=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
> =0A=
> For the mutex rework, I will delete them. This is something we can also d=
o in another dedicated patch not inside this series.=0A=
> =0A=
> Is that OK for you?=0A=
> =0A=
> Thanks,=0A=
> JB=0A=
> =0A=
> ________________________________________=0A=
> From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
> Sent:=A0Saturday, February 22, 2025 17:22=0A=
> To:=A0Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol=
.tdk.com@kernel.org>=0A=
> Cc:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Lars-Peter=
 Clausen <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kerne=
l.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
> Subject:=A0Re: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup functionali=
ty for Wake-on-Motion=0A=
> =A0=0A=
> This Message Is From an External Sender=0A=
> This message came from outside your organization.=0A=
> =A0=0A=
> On Thu, 20 Feb 2025 21:52:07 +0100=0A=
> Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.c=
om@kernel.org> wrote:=0A=
> =0A=
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> > =0A=
> > When Wake-on-Motion is on, enable system wakeup and keep chip on for=0A=
> > waking up system with interrupt.=0A=
> > =0A=
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com> =
=A0=0A=
> Hi Jean-Baptiste,=0A=
> =0A=
> A few comments inline.=0A=
> =0A=
> > ---=0A=
> > =A0drivers/iio/imu/inv_icm42600/inv_icm42600.h =A0 =A0 =A0 | =A02 +=0A=
> > =A0drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | =A03 +=0A=
> > =A0drivers/iio/imu/inv_icm42600/inv_icm42600_core.c =A0| 89 +++++++++++=
++++--------=0A=
> > =A03 files changed, 63 insertions(+), 31 deletions(-)=0A=
> > =0A=
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/=
imu/inv_icm42600/inv_icm42600.h=0A=
> > index 8dfbeaf1c768d7d25cb58ecf9804446f3cbbd465..baf1dcd714800e84ccd21dc=
1d1e486849c77a9ae 100644=0A=
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
> > @@ -151,6 +151,7 @@ struct inv_icm42600_apex {=0A=
> > =A0 * =A0@map:		regmap pointer.=0A=
> > =A0 * =A0@vdd_supply:	VDD voltage regulator for the chip.=0A=
> > =A0 * =A0@vddio_supply:	I/O voltage regulator for the chip.=0A=
> > + * =A0@irq:		chip irq. =A0=0A=
> =0A=
> Maybe say a little on what the variable is used for. It's not otherwise=
=0A=
> obvious why we need it. =A0Also, does this chip really only have one irq =
line?=0A=
> Looks like there are two. So the drivers should be fixed to cope with the=
=0A=
> only one wired being irq2 =A0unless I've found the wrong datasheet which =
is=0A=
> certainly possible.=0A=
> =0A=
> =0A=
> > =A0 * =A0@orientation:	sensor chip orientation relative to main hardwar=
e.=0A=
> > =A0 * =A0@conf:		chip sensors configurations.=0A=
> > =A0 * =A0@suspended:		suspended sensors configuration.=0A=
> > @@ -168,6 +169,7 @@ struct inv_icm42600_state {=0A=
> > =A0	struct regmap *map;=0A=
> > =A0	struct regulator *vdd_supply;=0A=
> > =A0	struct regulator *vddio_supply;=0A=
> > +	int irq;=0A=
> > =A0	struct iio_mount_matrix orientation;=0A=
> > =A0	struct inv_icm42600_conf conf;=0A=
> > =A0	struct inv_icm42600_suspended suspended;=0A=
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/driver=
s/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> > index 8ce2276b3edc61cc1ea26810198dd0057054ec48..4240e8c576f4d07af5434e9=
a91dfda532f87ffb9 100644=0A=
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> > @@ -1149,6 +1149,9 @@ struct iio_dev *inv_icm42600_accel_init(struct in=
v_icm42600_state *st)=0A=
> > =A0	if (ret)=0A=
> > =A0		return ERR_PTR(ret);=0A=
> > =A0=0A=
> > +	/* accel events are wakeup capable */=0A=
> > +	device_set_wakeup_capable(&indio_dev->dev, true);=0A=
> > +=0A=
> > =A0	return indio_dev;=0A=
> > =A0}=0A=
> > =A0=0A=
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> > index c0fd2770d66f02d1965fa07f819fd2db9a1d6bd2..f94bda5dc094d6cc85e3fac=
bd480b830bfbaa3f9 100644=0A=
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> > @@ -751,6 +751,7 @@ int inv_icm42600_core_probe(struct regmap *regmap, =
int chip, int irq,=0A=
> > =A0	mutex_init(&st->lock);=0A=
> > =A0	st->chip =3D chip;=0A=
> > =A0	st->map =3D regmap;=0A=
> > +	st->irq =3D irq;=0A=
> > =A0=0A=
> > =A0	ret =3D iio_read_mount_matrix(dev, &st->orientation);=0A=
> > =A0	if (ret) {=0A=
> > @@ -829,44 +830,56 @@ EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, "II=
O_ICM42600");=0A=
> > =A0static int inv_icm42600_suspend(struct device *dev)=0A=
> > =A0{=0A=
> > =A0	struct inv_icm42600_state *st =3D dev_get_drvdata(dev);=0A=
> > +	struct device *accel_dev;=0A=
> > +	bool wakeup;=0A=
> > +	int accel_conf;=0A=
> > =A0	int ret;=0A=
> > =A0=0A=
> > -	mutex_lock(&st->lock);=0A=
> > +	guard(mutex)(&st->lock); =A0=0A=
> =0A=
> As below. Pull these guard changes out as a precursor patch. That will ma=
ke=0A=
> it easier to spot the real changes here.=0A=
> =0A=
> > =A0=0A=
> > =A0	st->suspended.gyro =3D st->conf.gyro.mode;=0A=
> > =A0	st->suspended.accel =3D st->conf.accel.mode;=0A=
> > =A0	st->suspended.temp =3D st->conf.temp_en;=0A=
> > -	if (pm_runtime_suspended(dev)) {=0A=
> > -		ret =3D 0;=0A=
> > -		goto out_unlock;=0A=
> > -	}=0A=
> > +	if (pm_runtime_suspended(dev))=0A=
> > +		return 0;=0A=
> > =A0=0A=
> > =A0	/* disable FIFO data streaming */=0A=
> > =A0	if (st->fifo.on) {=0A=
> > =A0		ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,=0A=
> > =A0				 =A0 INV_ICM42600_FIFO_CONFIG_BYPASS);=0A=
> > =A0		if (ret)=0A=
> > -			goto out_unlock;=0A=
> > +			return ret;=0A=
> > =A0	}=0A=
> > =A0=0A=
> > -	/* disable APEX features */=0A=
> > -	if (st->apex.wom.enable) {=0A=
> > -		ret =3D inv_icm42600_set_wom(st, false);=0A=
> > -		if (ret)=0A=
> > -			goto out_unlock;=0A=
> > +	/* keep chip on and wake-up capable if APEX and wakeup on */=0A=
> > +	accel_dev =3D &st->indio_accel->dev;=0A=
> > +	wakeup =3D (st->apex.on && device_may_wakeup(accel_dev)) ? true : fal=
se;=0A=
> > +=0A=
> > +	if (!wakeup) {=0A=
> > +		/* disable APEX features and accel if wakeup disabled */=0A=
> > +		if (st->apex.wom.enable) {=0A=
> > +			ret =3D inv_icm42600_set_wom(st, false);=0A=
> > +			if (ret)=0A=
> > +				return ret;=0A=
> > +		}=0A=
> > +		accel_conf =3D INV_ICM42600_SENSOR_MODE_OFF;=0A=
> > +	} else {=0A=
> > +		/* keep accel on and setup irq for wakeup */=0A=
> > +		accel_conf =3D st->conf.accel.mode;=0A=
> > +		enable_irq_wake(st->irq);=0A=
> > +		disable_irq(st->irq);=0A=
> > =A0	}=0A=
> > =A0=0A=
> > =A0	ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF=
,=0A=
> > -					 INV_ICM42600_SENSOR_MODE_OFF, false,=0A=
> > -					 NULL);=0A=
> > +					 accel_conf, false, NULL);=0A=
> > =A0	if (ret)=0A=
> > -		goto out_unlock;=0A=
> > +		return ret;=0A=
> > =A0=0A=
> > -	regulator_disable(st->vddio_supply);=0A=
> > +	/* disable vddio regulator if chip is sleeping */=0A=
> > +	if (!wakeup)=0A=
> > +		regulator_disable(st->vddio_supply);=0A=
> > =A0=0A=
> > -out_unlock:=0A=
> > -	mutex_unlock(&st->lock);=0A=
> > -	return ret;=0A=
> > +	return 0;=0A=
> > =A0}=0A=
> > =A0=0A=
> > =A0/*=0A=
> > @@ -878,13 +891,25 @@ static int inv_icm42600_resume(struct device *dev=
)=0A=
> > =A0	struct inv_icm42600_state *st =3D dev_get_drvdata(dev);=0A=
> > =A0	struct inv_icm42600_sensor_state *gyro_st =3D iio_priv(st->indio_gy=
ro);=0A=
> > =A0	struct inv_icm42600_sensor_state *accel_st =3D iio_priv(st->indio_a=
ccel);=0A=
> > +	struct device *accel_dev;=0A=
> > +	bool wakeup;=0A=
> > =A0	int ret;=0A=
> > =A0=0A=
> > -	mutex_lock(&st->lock);=0A=
> > +	guard(mutex)(&st->lock); =A0=0A=
> =0A=
> Good change. =A0But separate patch as not related to most of what is goin=
g on here.=0A=
> =0A=
> =0A=
> > =A0=0A=
> > -	ret =3D inv_icm42600_enable_regulator_vddio(st);=0A=
> > -	if (ret)=0A=
> > -		goto out_unlock;=0A=
> > +	/* check wakeup capability */=0A=
> > +	accel_dev =3D &st->indio_accel->dev;=0A=
> > +	wakeup =3D (st->apex.on && device_may_wakeup(accel_dev)) ? true : fal=
se;=0A=
> > +=0A=
> > +	/* restore vddio if cut off or irq state */=0A=
> > +	if (!wakeup) {=0A=
> > +		ret =3D inv_icm42600_enable_regulator_vddio(st);=0A=
> > +		if (ret)=0A=
> > +			return ret;=0A=
> > +	} else {=0A=
> > +		enable_irq(st->irq);=0A=
> > +		disable_irq_wake(st->irq);=0A=
> > +	}=0A=
> > =A0=0A=
> > =A0	pm_runtime_disable(dev);=0A=
> > =A0	pm_runtime_set_active(dev);=0A=
> > @@ -895,13 +920,15 @@ static int inv_icm42600_resume(struct device *dev=
)=0A=
> > =A0					 st->suspended.accel,=0A=
> > =A0					 st->suspended.temp, NULL);=0A=
> > =A0	if (ret)=0A=
> > -		goto out_unlock;=0A=
> > +		return ret;=0A=
> > =A0=0A=
> > -	/* restore APEX features */=0A=
> > -	if (st->apex.wom.enable) {=0A=
> > -		ret =3D inv_icm42600_set_wom(st, true);=0A=
> > -		if (ret)=0A=
> > -			goto out_unlock;=0A=
> > +	/* restore APEX features if disabled */=0A=
> > +	if (!wakeup) {=0A=
> > +		if (st->apex.wom.enable) {=0A=
> > +			ret =3D inv_icm42600_set_wom(st, true);=0A=
> > +			if (ret)=0A=
> > +				return ret;=0A=
> > +		}=0A=
> > =A0	}=0A=
> > =A0=0A=
> > =A0	/* restore FIFO data streaming */=0A=
> > @@ -910,11 +937,11 @@ static int inv_icm42600_resume(struct device *dev=
)=0A=
> > =A0		inv_sensors_timestamp_reset(&accel_st->ts);=0A=
> > =A0		ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,=0A=
> > =A0				 =A0 INV_ICM42600_FIFO_CONFIG_STREAM);=0A=
> > +		if (ret)=0A=
> > +			return ret;=0A=
> > =A0	}=0A=
> > =A0=0A=
> > -out_unlock:=0A=
> > -	mutex_unlock(&st->lock);=0A=
> > -	return ret;=0A=
> > +	return 0;=0A=
> > =A0}=0A=
> > =A0=0A=
> > =A0/* Runtime suspend will turn off sensors that are enabled by iio dev=
ices. */=0A=
> > =A0 =0A=
> =0A=
=0A=

