Return-Path: <linux-iio+bounces-22910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 830D3B29C5F
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 10:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F081F7A9A79
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA042E8882;
	Mon, 18 Aug 2025 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="QhwY+IR4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6561448E0;
	Mon, 18 Aug 2025 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506142; cv=fail; b=hBSnJr+YYLl8fXrqotnQVSiFQ3GsQ1BZ6Xs6WXqTbDfiydSp1dbdTkZrJcS7DO9cc7Yf1v5RklKcCFp1ynis8rjCrwy0nj6G5qE/drwIG0b7b+D22ClRSQhsPlldKlW2e/LC8jAl4rjBdKQWyv8f42wl6bJcTE0kyfNjnkflizA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506142; c=relaxed/simple;
	bh=p2eHD3KDg0xr40Hwcokk4cKg7S9Iw9xqfbT+3jTx6X0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mDFqrRmPZJenrhJkRavmSUK+HhH+6SGf99zWSLXchUz12Rt4n4Sh+EESMoUPDXOJ8C5vDf9xTA4pmCDIH0MbjvvZKy9tl60HyR8Ed9Ruojrbdlz3ThbBN5Aeliqf8EAmjFQ3ROq5Q4UePe1JWTlhR7Xswm2+OYSZ3jHc6Uv4bRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=QhwY+IR4; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HMwGrC020885;
	Mon, 18 Aug 2025 08:35:23 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010036.outbound.protection.outlook.com [52.101.169.36])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48jgc0s4ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 08:35:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPYIHlE4U2zPmNy/I3oBi+EZj2NqWnu0eIAFLK11mirfxdHDotsahI+bOZnlrLMcnyF2zoKGRqZ81M6AY+hHaNEhhIWu3gpWhy8oGT3l3QC45f5eMA3iss2ndWIFoYEKYCIvaiR1fx1Wl9yYbRb07L0K2VbDfiBZO//CIPWkvSSKGDztlFuZ82P/e5elYaOefkPZTNvgKxJBiPqCoG6/SYOhzO8Nc9J3lLp+Os8UuoxuizGOF/s1fUmzewlmowSMNquuB08Z3cAxUcQWVT1xY1Cs0vK9LAND7liOetfjckZ4H30tSqaw5/d5wTWlD4D1x/O/tyyGMC/CWwYaAQv2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2eHD3KDg0xr40Hwcokk4cKg7S9Iw9xqfbT+3jTx6X0=;
 b=rtK4MEP6acqJlWSg83cnQX1NAGuGDTcIv/HkglG7OsJfEbrVaS0CSGpNQzaMzorynAgM7OtxeQYEk/IebVr2sQQ7Ss6AZfj+YLRwU5mMv8WHJq2D5MG8+7R5kJQUl3ENo69pZ6Sj5RU74fiIlwzQ93hX86xNxh6qY9pirqQ0Crdjvi3QgkWpXbntrUO4LiiuA7H55Gz8x9dV20FIiycEBUhh95obtDIpDyZ8QmQ9ZpbUAdhc/pC/ekZ2xvXeopW8QquWdEfU/YIUxS+THiUXsnekLnDrDNd4+FvVydb5WDgk5K4wf9oe6j5L/7yPUpApYJS7nf+AKpuf/nWJjAo+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2eHD3KDg0xr40Hwcokk4cKg7S9Iw9xqfbT+3jTx6X0=;
 b=QhwY+IR4NILwpzjEtpq1DAGB8k0TI49YB+yBvxOjDuknusL2wAwbnPi4lS1ApmD/ox35QIjdVeD4Lmq9XfTL2l4uulrtOeTllZ8NROV9jLNrI32anSlpkn9o+y0sHwD/1wuHL2+1HBJPVbOJohV8ssukgLiyfOIye06WKg3Pfwp7Xxw2vld5KfQhF8yUYCqxPQ0W7zpny9PdBydt4i98NR/vSW/Q9mzsFNrUhaw7ERssKDrUUjwpD7X0aeZvxj4m5WfFKlILQuDE+GU8cphZB9VIZoUj8NDdjq9R+Hiq4qTIGiHScF2bu5yht8rUPDHIztYKR+5z1umv0Y94tysRgA==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR2P281MB1496.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:35:14 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 08:35:14 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 1/9] dt-bindings: iio: imu: Add inv_icm45600
Thread-Topic: [PATCH v4 1/9] dt-bindings: iio: imu: Add inv_icm45600
Thread-Index: AQHcDPmDWnB/dCSpmk2sXcwiur1x2LRjaFiAgASzD7A=
Date: Mon, 18 Aug 2025 08:35:13 +0000
Message-ID:
 <FR2PPF4571F02BC369006E23C162813CA3A8C31A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250814-add_newport_driver-v4-0-4464b6600972@tdk.com>
 <20250814-add_newport_driver-v4-1-4464b6600972@tdk.com>
 <20250815-muscular-rigorous-dugong-55ea26@kuoka>
In-Reply-To: <20250815-muscular-rigorous-dugong-55ea26@kuoka>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR2P281MB1496:EE_
x-ms-office365-filtering-correlation-id: c376c33f-c372-463a-5adc-08ddde3226f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|366016|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3RoVW1MUW55Tm54dmltWWpuTDFCeVZabFEwNGVCeDYxeWxOUFhuSCt0REw4?=
 =?utf-8?B?Tzc1N0RVY0ZoSjM1d29jZ3pqRzlUK3BtVk1RV2ZDUU02TTdEY3VaNEI4Z09B?=
 =?utf-8?B?dG5zUkpBL1MzbTNXbld3eHczQ0RmREMyOVBjTWJnazM3Ny9hTTVZc04xSFVy?=
 =?utf-8?B?Rnl1cXdjeTlTc1BMa3lZRU9EaENLbUd6RlI3WE1pNzAvV1NWM1lTMFluaFV3?=
 =?utf-8?B?WDhQQktYOElrS2srZWFyM3VuZnFlc0F3OGZrNlNrZmJrcXdGSjE4eVJMYlpU?=
 =?utf-8?B?N3hJbXZSWDluZ0ZnSTY3SnhQeTlJYWdmWHVXZ0RKOVRNZFlxZCtWaUU5Nk9y?=
 =?utf-8?B?R0RkbXhqdTB5Y29qNDdFbFpQRjlCVnRNaHBwbzhlU2p6M3FiUXJ6YThwTC84?=
 =?utf-8?B?cm41VVRjbUtRNUlIZklpdHUrS00vTWdZVW9HUk15QmlEQ3Y0eXRPN2dCNFV2?=
 =?utf-8?B?MDFnWk1LYUZLdnNEbE5mbjI1YUdPbk92aXJRUTZzM2U3ajV0MHpvSXBKN2lN?=
 =?utf-8?B?WmZNSFVkdTBCY0wrR0c5bnRWeTN6aEMvUENQbFg2TW1USXVYOTI3TkErU1F0?=
 =?utf-8?B?OHNIei85YVdoWllLM2prWFhtQnBEMGs3VCtCdExCL3VDNW1kaDNQR1NtUGFM?=
 =?utf-8?B?Q3pqV2x3Mjh4RTFOS256aERIVEJFWitmZmFDTmhwM1ZiMXJQT2V3TGU0VDJs?=
 =?utf-8?B?M2ErRWRxd0FkY0NxTHdpcy9VdnQxV2xMd2FJWkFkWXUxREJCL1kvMmZxR1lK?=
 =?utf-8?B?LzRmRWwrT1NUT1NJaHdNSkVKY0QrbEZNNkdGcFlZTmd0c1VOdmZ0cW04YStm?=
 =?utf-8?B?aVJzWXRQZlBTTW9YdjBMQ0YxcHVQZWNQRHl1YWFwcUhZRWJRT2VlRlh5Z0Y5?=
 =?utf-8?B?M3YyY1oyYlE1cis5UCtEVlRvZ3RiUHJFT05oWDkwb2owYytrbm1wTHE3OENE?=
 =?utf-8?B?OFE1RUtEcHpTVU5qaXg3b05GcjYxUGZ5eWgwTFVuUzBoVnI2NDdoZUpqbi9p?=
 =?utf-8?B?bTI3U3ZvK3ZhMWdFR0NTZjJkSjkwamxRQTJsODVjMTFjRGU3UTIvczI5ZkZ3?=
 =?utf-8?B?ZDZKd2EwRmVLbm1NUVk4RFJwK2txd3BlV3luV2h4Kzd6TnVUWkVZQU5tSmFJ?=
 =?utf-8?B?QXQ1TVkxMDErMXVvMlZVRDZjSEpsdGZLaUhPL1A0TDVDUGl1RFZFY0ovcHYw?=
 =?utf-8?B?Sll6NWd2dmZGaC9HbWxSY1cxR2FUZy9UQjlUaG9mRTFzOTR0UUM2VEF2c0lT?=
 =?utf-8?B?THp4UytHQjR5TXQyT2lURHk3dExNc3UxYlkrSUhqWktPNklsNHYwWjdXK2hB?=
 =?utf-8?B?Y05sK2VwSUJLNkdCVEVIMk10YVlpV2pzd1BSc3F4N2xtQVFxRkhrM24vMnEx?=
 =?utf-8?B?eVBCejRZUGZjTmVHVWRPc3pub09MSlp3RVA3YVBtT3FZbmNBZW5yaXZCKzY5?=
 =?utf-8?B?SVVKY0tXOFYxS281R3hINmp3T2JTM25DMmcxRDl5SkRPa0x3ajJRWXNDU2hJ?=
 =?utf-8?B?M2FHRWdCVmV0MjZFM3JhU0ZkY3duUG45NStob3duNTRKUjFaUUhLNHgxUktm?=
 =?utf-8?B?SkRlZ2NNWE9pdmI1aDNYLzVLTGsxSVdPQVpVT3NJbUZUckJIaUlBWmIzdFBE?=
 =?utf-8?B?L256eUs2eTJqdEJOUUVLejd2WkZDTXpFc1ZuMGNJb1ViMU5hdCtxNHB6SU14?=
 =?utf-8?B?SHU0dnNLMmJiSCs1NS8zSGNqbkVGSUs3VCtKQ0kvVjlpM0hyMnZNQWU3amUy?=
 =?utf-8?B?NUV3TXM3OGtlQUQzTGttd2hFTlRXdGoyRzN1dUc3eENYWXY3UTYrQjlsRi9F?=
 =?utf-8?B?N3QrQkVDWG5xWFR6UEdEaWROUHNmbUJSenJYUkhzbk5mc3FLd0NXUmVBczVY?=
 =?utf-8?B?VXhyZ1h4ZnZ2NmZCeVUzN1JML0F4bUxYeTNwV2pVYUF4L0g5aVN6c3VYaFIv?=
 =?utf-8?B?eXpDWmUrV09tQTgyV3p6b3NhTjF1TWVoNWR6dUlLb2J1VkRpNGQ1VEVEMWFl?=
 =?utf-8?B?VU1teHVIOHIzRUNaU250UG0rRXBCT0hRSHpEdDFzc2FlbURzaFRBTU5LK1pW?=
 =?utf-8?Q?Lr7q3Y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3dJY0g2M0Rwc29IMjA2MFBDWEJnQ25jNWtybi90UjVOR2MrUkp0TTI5REQ1?=
 =?utf-8?B?OVJkSHEwNDRyT1ZyVTd2S1Q1NGJ3SG9lV0t4OW5PM21WNGNiSVNib0l1a1NJ?=
 =?utf-8?B?dm1USDhBL0lUbXJ2NjJYNFpMY2I3MG5IZy9URkovR3laNEFxeWdlMUlqSUF1?=
 =?utf-8?B?TUpPTG9XTGpiWGUvdERqWFJaWE40UFd5VGxkTldGeHZ3NW40aUhTNGNrbHBH?=
 =?utf-8?B?UnZkNG1OV1FZRmVFT3BDelFLVVJOUk4zUlVEak5Dekh6bUNndzJiRmRnS0dt?=
 =?utf-8?B?bmN2cS93aS9MT2VTTFFqb0JwcEpidnZITUQ1TXJYQmNXQXRZUERGbW5GMkZF?=
 =?utf-8?B?VENmQWlyWU9Qd21FaW82NVdjTkZjc0ptaUhIZzA1R0czbFkxbWNpS1NlcE9C?=
 =?utf-8?B?ditVUE84OUtCQXQ3aUkyZFh1dDZVYWd3UitNY0RmeGVWaVNTVms2Q1B3dzFZ?=
 =?utf-8?B?aFJXS3ltaWxPYTR5bXlLWEJrREN2SmNLK1FEQlc4Y2E4ODUzeFpPMlhYb3JC?=
 =?utf-8?B?N2JKNmxuQWFMMm1xSWlwZjNzSDZ4cVFsRkxqME9ZZFl4SXc2emVPNis5Z2dN?=
 =?utf-8?B?OTBNVUVjdVRuUWxlM3A5S2NuZmZRSFo4S0NvMXVuZzJoUVU5TnFzd3FzWUlI?=
 =?utf-8?B?UUhxVHlBQ0pjUHBkeEc0RTNlWitoT2MwMVFuRHUxVEwvR21KRUMrZHNaWHNv?=
 =?utf-8?B?N0lSTTZoTzczc2EyVllKK3N3S1J5Zmt5ZStaMzdDRzBaYjgxSkNuSHVVUUFW?=
 =?utf-8?B?SldQMjgvMXhCaEl3anRJbEx3V1E3VllYUkZVSzBHMkJKcDNrMmplbmRZVGIw?=
 =?utf-8?B?d3ZzS2w5dkE5THB1VDQ4bTA3blBzWndMalI2K1FhNHUzOTBFRXlzUE5mME13?=
 =?utf-8?B?N0x5RjUzSk81ckNEc0lWak9SdVV3b2xhMUJYSnRhd09TU05OTUs0bU80M3JL?=
 =?utf-8?B?Ylg1RmlNSW5OWXdXQjZpeUx4a0c1U014SlZrZVY1S0tLSVh3blpRMUVnRkps?=
 =?utf-8?B?OFdwN050NUZ5eHBYUlovVjMrakZ2UXV1Zlhray9GNUt1UkVqRjVyWnFNZVBC?=
 =?utf-8?B?S3ZqYnlwTlFuc3NadWpvTnM2emVwWnQ4bXVvWDRKU1N0M1ZOV3Y0azFJWkNX?=
 =?utf-8?B?VEswMVJ6SzIwcW5BVTNRbTBFSmFoRWlONXBRbllHYys3amRsSm56Ylp6SEJK?=
 =?utf-8?B?WE1nWGJXa2hLeEJQUDRkSk9DZUdHVlJ5dFd0cWJQNFhDZEdOeTJJdkFPVExp?=
 =?utf-8?B?cjFXbEhCZmQvUG0vQW1hNnYzbnJLcER2ajROUml4TEtZekMvUk9ienFsa1VO?=
 =?utf-8?B?SzNMU2I5Z0wwcDFaSm1JTlBnQWlSRGpRQWNJVVZ3cUU1TjE1V0hrN055N1lT?=
 =?utf-8?B?cHJPNjVXdHJiZ0xuYjAzMTBTUk5IeEVVN1YxQjU0UjNUOGc3clNVTmxha3FM?=
 =?utf-8?B?cEFnMEJHYmRKcWNUYTFNSTBqWldQV2NjZENrVjhmSktzRVZIUFV1bmtwUks0?=
 =?utf-8?B?SEptY0lzYjJTMUNvd0Nxbm5NZWZrcUw5Q3c0K01nY2VtOFY1UVUrL09LbStB?=
 =?utf-8?B?R29zNXRuWFkvYytMd016WHEzODdYTWVJSW1JVFd3a2ZraWNSOHZkbDFUZllH?=
 =?utf-8?B?eFZLYThWdUNudkFMTW9zSzNDbjlkVTJxcnM2T0dpOVpvK2E5Wlhrdi9nQXpN?=
 =?utf-8?B?SnhEaC80c1REWk9PYTQ2Q0pSZ0xXbFNCenYyZ25LS1l2MVFkOWpwaVRWL29J?=
 =?utf-8?B?OGYzaTBQNmh0L0w5aUNZMjZLK3pWTUEyeGdBejlrNjJLY2FiQ0VtMjB3U0M4?=
 =?utf-8?B?eHN0NGhOcGFQeHppekd3RnYremNqWGsyZDhidnNxc3NyejdQeksvUWNBYi9u?=
 =?utf-8?B?cS9MdzRML3Q0Ni8zYXdabndxTkRURStPVCtrWXYvcVNEY1Z0YXJ2K1RncUhV?=
 =?utf-8?B?NDZMcmNKV1lRWmNRb2NrSUlWK0lMbTRxZlZkSWt2cG9kTjRMSU96dnRZMjRG?=
 =?utf-8?B?WXlFQU9veXVjZXhxcU1qRGphVklHTEoxU0dET01KYU9mY1VJTnR2T2hyb1RI?=
 =?utf-8?B?WTlTUTM3OEtMcWxib1N2c3lMQ2JoRklRNnBwVGhTRy9UQUlGOVVxSWZLR2l5?=
 =?utf-8?Q?TZzdOpvYVg/qUUP6FwyPU7Zm6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c376c33f-c372-463a-5adc-08ddde3226f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 08:35:13.9197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExyBGf2tq95+hWrP3gVkXUInVveABhdKMZzpXXsqWz+9SbmJx7PclAWywefZQz9bMr00OwrNn61J1uiB76Y82A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1496
X-Proofpoint-GUID: Vtj6b4k0XmMh3P8aAxcsWhs2FzYCoSqe
X-Proofpoint-ORIG-GUID: Vtj6b4k0XmMh3P8aAxcsWhs2FzYCoSqe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxMyBTYWx0ZWRfX9pFluibx0izk
 XI4AT22MOYfiw7y7xB9wrhGfNeg/99X5oE71c4SVzn/EXLGfxTUCZ3P1yFakJGffHLgnhY4Tp4c
 fvoJHXhCLuCQOwoZPmTan4lCZXjNOqmqiW26hIyXRxqXkltncFFhESg7cZnRDZCbmu+uAobKa/c
 t3R6Iu95NWndJXWAgQ/n9epsmcIl/xCqizMv1qplIpEpkpU2W0rF1wn8Rqz/DavFSJUee0xTM53
 KcgSVl9Ohh8KD4X/A4mXv1nUYFbVHXAlrzghtNqIH5b2jexVXZGk/j5dte4EZTU6gKylS9Vg5fL
 W9tejij2dbgr1zX0M4NinCK/DdHM/ToswjOs6PMoe5fm+zSgClY18+3QvJ2oeje/Ztlbm8Lf1CS
 0jpkrf/+
X-Authority-Analysis: v=2.4 cv=T/SMT+KQ c=1 sm=1 tr=0 ts=68a2e5cb cx=c_pps
 a=oehsocVE3VAXCYM5p14S1A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8
 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=h0bf43BbbK2MusZfd4MA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160013

Pg0KPg0KPkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4gDQo+U2Vu
dDogRnJpZGF5LCBBdWd1c3QgMTUsIDIwMjUgMTA6NDcgQU0NCj5UbzogUmVtaSBCdWlzc29uIDxS
ZW1pLkJ1aXNzb25AdGRrLmNvbT4NCj5DYzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVs
Lm9yZz47IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IE51bm8gU8OhIDxu
dW5vLnNhQGFuYWxvZy5jb20+OyBBbmR5IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0
QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMS85XSBkdC1iaW5k
aW5nczogaWlvOiBpbXU6IEFkZCBpbnZfaWNtNDU2MDANCj4NCj5PbiBUaHUsIEF1ZyAxNCwgMjAy
NSBhdCAwODo1NzoxNUFNICswMDAwLCBSZW1pIEJ1aXNzb24gd3JvdGU6DQo+PiArICBpbnRlcnJ1
cHQtbmFtZXM6DQo+PiArICAgIG1pbkl0ZW1zOiAxDQo+PiArICAgIG1heEl0ZW1zOiAyDQo+PiAr
ICAgIGl0ZW1zOg0KPj4gKyAgICAgIGVudW06DQo+PiArICAgICAgICAtIElOVDENCj4+ICsgICAg
ICAgIC0gSU5UMg0KPj4gKyAgICBkZXNjcmlwdGlvbjogQ2hvb3NlIGNoaXAgaW50ZXJydXB0IHBp
biB0byBiZSB1c2VkIGFzIGludGVycnVwdCBpbnB1dC4NCj4NCj5OQUsNCj4NCj5Zb3UganVzdCBr
ZWVwIGlnbm9yaW5nIGFsbCBlbWFpbHMgYW5kIG5vdCByZXNwb25kaW5nLiBUaGF0J3Mgbm90IGhv
dyB0aGUNCj5wcm9jZXNzIHdvcmtzLg0KPg0KPkJlc3QgcmVnYXJkcywNCj5Lcnp5c3p0b2YNCkhl
bGxvIEtyenlzenRvZiwNClNvIHNvcnJ5IGZvciBtaXNzaW5nIHRoYXQgb25lIHNpbmNlIGZpcnN0
IHZlcnNpb24uDQpUaGFua3MgZm9yIHRoZSByZW1pbmRlciwgSSdsbCBmaXghDQo+DQo+DQo=

