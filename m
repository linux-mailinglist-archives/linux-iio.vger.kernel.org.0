Return-Path: <linux-iio+bounces-10916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3E89A9ABC
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 09:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7DC280EEB
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 07:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E2214901B;
	Tue, 22 Oct 2024 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="QHHHDDXo"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8F13B280;
	Tue, 22 Oct 2024 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581415; cv=fail; b=ELkoQ39ibWj+6iaf4tVb1v5SZ3CGgtjVeedue80Khm4ttef+F9iD0qUO3C2deeLVjP4Up/OVdSWw9yY9KKxvPekXGoL8iWP3dPnpNb1DhJc9Q+fLsGGhx4Bak8jJblrSVMezhoxZB3TcxwkRFLlCMuBdc4zSPfpEukOh4uA6Yp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581415; c=relaxed/simple;
	bh=CXNgvlwb+QCcDezmhpzlfvCOFnPGJno9q7tbkhCJ2jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KIZ0UUALwt+SQZdWuclSYb8BFDFHAi9W4aatIup+v2EkKhkXLoVYYhvQVp+yZv4ljYqdbNMxrWqfxxEBEMmOKq02mt7iJ6PZdkFp5iPAcj+HS3FL+kz1qAQBh0jJVTq1JEdUZR/hAvmLvWR1svr9MjEyPEcu4LI8U6JYKXdpdJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=QHHHDDXo; arc=fail smtp.client-ip=40.107.104.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/UrknTu+p1DPcEacHlgtMS7wMXlMQjDJEnarHfyynJVo/enia9A1tqoTZ14HvFduoX5g3tYheGRvJhSc2LMQgsPxI6tToVMeJa8cXgXXfgbSjHtjxRfcJ186WVyPh+BAMFYdBVJZd0B0bkfw7Ef+3zpC/O+i4eTVSf6bnboTqEbqG0H/o+Y4nA/lxJncWVhuQTtrcrx+BL/1yByZ8oCRJO5zCG6ucz7oVHH2JiCXiGZcm3l1mfDcYce2zvXrCmlwwvyLkcUbafEIuusPAA4/p+0Uns83nuQ8FaiLiJqm4n5v7IbSCWmr1fiIJ676aCVpNbfpAG9Ab4ndkSHnPkT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXNgvlwb+QCcDezmhpzlfvCOFnPGJno9q7tbkhCJ2jc=;
 b=blzFGMx0ueLED3go3EOy18yS6uspPzkG5EjVqkJMITR+ddkTcGjwBZTZKgwpUmmLcth3cmnmAK+efTmqWV3PFOEZclQE0bBtzn+RKVSKpgYPN6AXWU/nIJ+fKCIcdwmW6XWnQCPS+x821T4yX4pZGUqqSd/NQy5q/YKR5bC1Avz7e2Ueb+moBt2e80bwuierzZgtUcwtvmnumHOSP9I31/0Uk/uFutNJm6Okwr5TpMX9cDP1rhqhr7jpY5U5NIiXMj4J9Gh/oUVG/A9aKY0Hf+zL5c3ezEpzz7mOvAddwS91C+Vk9dfMS1QFv7a5f/qhnvKxBDk99L4HtJGhUMZdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXNgvlwb+QCcDezmhpzlfvCOFnPGJno9q7tbkhCJ2jc=;
 b=QHHHDDXo1DNDPasmh9wnqdgmDUksto540lCZIlRwkeCUyxQ8/+n9Xp5b6pPNNbpjvfluwdokWPP9WyRAU8XUdlC70iGPaofwy8sK4gDSqdy0W7eoA8rnYFJqsEEvQNGWIG8e7Z0SK5RAAKjbowOCDNf9dea9/WX9Vx7VdyS1554=
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15)
 by PAXPR02MB8197.eurprd02.prod.outlook.com (2603:10a6:102:240::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 07:16:48 +0000
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa]) by AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 07:16:48 +0000
From: Emil Gedenryd <Emil.Gedenryd@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
	<Kernel@axis.com>
Subject: Re: [PATCH v4 2/2] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Topic: [PATCH v4 2/2] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Index:
 AQHbFY8HuXJEWWs0RkmgVD58ZYYY2rJ5uMQAgAEugICABWagAIAA4L0AgAIYDQCAAo/4AIALzFEAgADWCQA=
Date: Tue, 22 Oct 2024 07:16:47 +0000
Message-ID: <3af72a433e575c0085b20c5c420b2ab242ec50ea.camel@axis.com>
References: <20241003-add_opt3002-v4-0-c550dc4591b4@axis.com>
	 <20241003-add_opt3002-v4-2-c550dc4591b4@axis.com>
	 <20241006141624.3fa5bf34@jic23-huawei>
	 <b40d22b5bdf487b40207e676d35a0507c47cbb26.camel@axis.com>
	 <20241010184742.1747bfe2@jic23-huawei>
	 <fab164228b4d567a147cd8d93150e687c6db0c70.camel@axis.com>
	 <20241012161040.1506a7a4@jic23-huawei>
	 <9e93042237c3c9815d7b1be5ba85be61239b76e8.camel@axis.com>
	 <20241021192836.1b1fe68d@jic23-huawei>
In-Reply-To: <20241021192836.1b1fe68d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR02MB5784:EE_|PAXPR02MB8197:EE_
x-ms-office365-filtering-correlation-id: 0d7129b6-4a5f-4e79-3da3-08dcf2697e0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NW9jNWNvaFk4YkV3bnhsaWo5R1g5UWRvNkRLM2R4Tm9OcmhXVDFCcFp3N1Z2?=
 =?utf-8?B?T01IMjhzMHhqeHZ5V0FLNUE3ZDlsZmZjK0FpU0pUeEYyNWN5SC9tOWhpM0Nx?=
 =?utf-8?B?cEFBVW9NTnN4cHpsU2ZhV0ZwM0dHMXlKRXRrOUptd0kvVnRKYXRHcDFUQld4?=
 =?utf-8?B?Z2QrL3JWT1J0VDltN0pFajFqZVl1TGY5R1YxZWdNWHRaaEdRbGlLUTdxMndD?=
 =?utf-8?B?R1hXc3pNblJXMVZOdUNHSXVncTFQVFNaYmdtdlNwSEhyaXhlSmhmdkpLT01t?=
 =?utf-8?B?U3h1TmxoamMvc2tjTExaMlZvNTc4blJGMDcxVGNoS0lWZ0NZamtFRU13clB6?=
 =?utf-8?B?TC9FSmRaajZEdVNmcUZwWUxUNHVJRHlaT0RsYmdkS3JpSGE5VWZPZlBIYjRh?=
 =?utf-8?B?N0kzNVFTVjJ0bHVnL0pVUE1YV2oyNTZWQVM5aGpiYlR3WXUwbXAveDZUWFBk?=
 =?utf-8?B?SitGSU1ENGRMMkJLNE5lNXlXb3B6RCtEVUJNcUhRNEhkTGIrSjV6UFBWRG9J?=
 =?utf-8?B?U0dPckRJT25nQmFjaFJIVEJ6T3dRdVdvRktIaUg5Rk1BS2RGS0d4dEVxRTJX?=
 =?utf-8?B?YncvNFpuWnpsR0t5NlplMFpNUXNZKzUrRDJjVzJEcmpQTmtQK3hBNUhsdjUz?=
 =?utf-8?B?YUk4cVBRL1NlTXVGeGY4WTh2QWUyaHlqa2lRek5zMDZSdVZhQ2lZRHljVXNw?=
 =?utf-8?B?YmVqVm5wRFpiZjVnKzJpOERHSXBGS3llbUQ3QUFzdm9hUS85SjczVHpBOUtH?=
 =?utf-8?B?MnlIdVNNbTRxakhaaSs4NEREeS8rL2ZubkE3UmwvNC9KWHMrUytZMWNGckhE?=
 =?utf-8?B?SnBMM3ovVUR6cVJGV1NvM0NybHlTNyt3b1FxQ0FFN2RqOXZhTHlnWUJOR1BT?=
 =?utf-8?B?VzVDREZoUklwVnlWaS9KZnUwTGppRHZBYVlIdk9Ja1FaWFNHR3lnTm9FdVcv?=
 =?utf-8?B?bkw1OTVMaTJ3V2NJTHJkR3NZSVVwUjRCUEhnL0pxcThWVUE2MG9ycUpvN2J1?=
 =?utf-8?B?ejJVVlkzeVJyeDM3b0x6Tzl4TnlISXhtYy93SzdLclZ5dC9FRUlOSDFLWDc1?=
 =?utf-8?B?TUdEUi9jNzVKdHNUQ3RGOEhmb3B2a3p1aHNxbzNmSytxQWdPOXNWd0xmU2xL?=
 =?utf-8?B?dGc4L1R4SUdJalNBTlRQalhCWXJlZ05NMVV3UnljeWNtTUdxcisycFg1VHFN?=
 =?utf-8?B?ZGxmWi96WDJWWmExSzE1REFEeE56V2RqYlJPZko5bWthS2lLMTdGY2U0bmVC?=
 =?utf-8?B?VFhtOWUrZUVKYytKK0JjK2FVVEQ3ZXdWcmxyaExTY1NmVG92MTFSenRQTi9y?=
 =?utf-8?B?ZGJXVmJFR0tsYnlUTS82MDlHOGtiVWx6Vmg3Si90am02cjhvUXg5MG1qR2l2?=
 =?utf-8?B?L2VCVm1kbmpJbTVMZXJwYmFpY1hHODFlVlZUVjN1RUZsMVptQnN2VmtZSTRK?=
 =?utf-8?B?aHN3T0FJaEkxelRrVDJuVjcvTjhUZmdjbzEyUUluK2ViR1dGbHlZbnRRdXlG?=
 =?utf-8?B?VVhYVDJiL1MxOUpBVXZGbUtrQWNRQkJ0bVROSUQ4NzBNN2JPOUplU1cwb2dr?=
 =?utf-8?B?MzBVRHNYeHREQVN0aEVJRWtQZjlDNVltZjd3NGpWaTRRRXdlTVdCbWtWTzlz?=
 =?utf-8?B?SHBlOU5HWkI4eGlmWXFEbHRGWG01Mkw1T0VGM3o2bmRudVU0MGJrV1JLRUwz?=
 =?utf-8?B?Y2RqVWk2TzNRWGZFSHRMRkJWcjNtcHhJWTh4ZmRwalgxM3NWWE1ycllERnJC?=
 =?utf-8?B?WldjM2lWVXczVHJzdXgwd2FGUVF2WFMwYmw5ZGY0ZFJEcSsvQkpTaml2NEww?=
 =?utf-8?B?SktVVUo2SWplWHpYemVwZld2S2doUWhIaFgwMDV5SkNidTdYRmNHcWlSQUYy?=
 =?utf-8?Q?CvQpUAa8060bd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB5784.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkpwRi9wQzlKdVczRGR6SVovVHVYVXg1RkR0TEhRMUJmOHRlRXY3UG8zdXVM?=
 =?utf-8?B?SGdjR0Y3bEt1dkhqWkxhLzJYWTFqMGhZZWtWRW1JZFFpZlFnZkt5czZvUXVU?=
 =?utf-8?B?RmdxSGVIN2c3WXdDZ1VjN3NvcE1tUkxqVGpPZTlTNThCSElBT0JzdHlxUlRq?=
 =?utf-8?B?QVd5NldJZUJNVmlhSnlwRTI2dnUvbEhyMytKazNnNmFuQnRSOFVBeHk2NGI4?=
 =?utf-8?B?cWZGYUdmR21yb01jRlp1K0JUcFRnaC9NWmJMZzI5OHRHSkVxSGsxcCtaYXZo?=
 =?utf-8?B?dzNnTFJPQkxGWDR1bU5Xb0pBT0lHemZ2WCtEUlI2eDg3YXN4ZUtPdTRxVXNn?=
 =?utf-8?B?NE9tazFwZEUveVhzM2FZbmlxWWtMRHExRTRoUTRjMXJRVlVFd3orUVhQN1hx?=
 =?utf-8?B?Mm9qMlZTZE9BWEFEZ1hibW1kRHZ0aGY5Qm9RSnlHYitSSFZ2NDBVOCt0SlRn?=
 =?utf-8?B?NUZPSGE4bWxPZTEydjlLV2lWWGdmZlBuOHVVNWVSTU15MVpqRjdSRTFCSzNl?=
 =?utf-8?B?a01wZ1NsdXp4L3F3QkZCNG1DYmZhMmpIVHdBWC94UDFQL3ZiQThJRFYzcUZu?=
 =?utf-8?B?QkVCRVZmTUpTalRGelpORnhkVmxWdC9xeDM5RjBIdk9kWFZucWtqNnRqMS9k?=
 =?utf-8?B?R1Y2WWVENHlCU3ZVdVZxRDM3TlZJTFlhK1kzREV4enVuOG02RThlMzZNejBH?=
 =?utf-8?B?V0ptSVNJZkk3UzdrM1RIeEVoUnhVKzQvWjN2NHZsSFR1ZDE4SU9UUm9UNUM3?=
 =?utf-8?B?V2kxM1NDY1A3YXZDNVMwMGNlSUR4UjZKT2sxdTJVRkdiRkRKeS9CRkVQYW9l?=
 =?utf-8?B?RVRycEV2eEZjcFAwdHYrM1dHZVpMMG1OdDZYNzF6VVhNYUxaQm93VGx3L2k5?=
 =?utf-8?B?WVZPQmFtay9ZN0xGTVd3VmNmcDhBQWRkWFpkd1oyYW1sUWNtekV2eSs1UnFO?=
 =?utf-8?B?cktyNHlWZGRIdDhvVFY4YWpZQlBPOTFHRmQwK25yYmdJeGEzb05xSUFiWDFm?=
 =?utf-8?B?cmNURHFBajEyNnNVY0lqaHI1aUtsQlp1ZDUxbnFzMlNYQUlRc3h1Nk1MNjJr?=
 =?utf-8?B?TmRFZEt2MzEveS8zd2VlRjhOc1JBVWRkdE1BZE55SGEveWhRM3RPeHl4VEJ5?=
 =?utf-8?B?Qml6dmhvcS9oZGwwOFJjSjRIb3N2RDZJSjdGRlBMNXRncDM5NnRpZnY4dk5Q?=
 =?utf-8?B?UlN5aFd4SWd4c1ZnTjRCMnRXMzZFbFErczFsN3ZoQ2xxeVpsdzJBVFdwcXFE?=
 =?utf-8?B?TFAwWE8rd0UvemlYT1JSOENvNmpTM2tsR2IyRmsxUGt3SytXMmNMUHBWcmZF?=
 =?utf-8?B?ZmNGNXhETjNLOFJZM0tyak9MMWZvRWNTdERmWDZvSnZPa3FxZFFzWGZQZEZl?=
 =?utf-8?B?VStVVTl3YW9HTXArWFlSNUtmSkVWYnpqSEdKU1YxUVZXL1dWZ2RDeWxmbWVp?=
 =?utf-8?B?SjJEaGt6eE50ZzBsUkRpZ2JMSm52OHN5VkVsMFBwTjVqNkNETnQ5NG9od2F2?=
 =?utf-8?B?RDRBYU1pTklTVlFFckEzUFV6RWZRMjRFbkgyWG1keXNjVUExUWxRekZMa0Zw?=
 =?utf-8?B?bEx2Mk4ycm5oMkdKTlZvTUxtS0luZDhBbVphZEVvVTZESXkzVzdEWko4aWg5?=
 =?utf-8?B?SU9zYnFDNll0NHkwTUxqRC92bzBSTzVUa1NiOUNrTVRScnRRSkQ0b0NES0VP?=
 =?utf-8?B?a21qQlFXdlRJSzZCa09YcXo3enZrQ3pzdnNlUzJZZnU2RTBSanByMnp5N3VT?=
 =?utf-8?B?eVdIQWVYaHdlaU9UOUFXN1dNaDh5WkxtNFg1NG1GcUhYZ1MyK1NVMG9yN3No?=
 =?utf-8?B?endtSHdTZURrWVpkQVlxaFRNSE9IZjRjY1NYNFNXS2FjUTQ2RURpSXRxZ3oy?=
 =?utf-8?B?NHlpanVSSGVZYTAvc0RyOVdiZ1NmTllRSXYzbXJ6dHJIVXJlZHM2OVBvUjM4?=
 =?utf-8?B?NzUwalUya29JcVloaGZqTmJKM1NGNzVlbHBDN01KVXdsUXhKb1NwT3c1b0VY?=
 =?utf-8?B?VmdrRklvTzBKZzhQQ080a29aZUZLcTlVMFFIWUtOZWV3NWFkWkExSnFzOGpN?=
 =?utf-8?B?N081MXpzRzRjZDhUMUV1aWVHeTZZSEsxTzBqT1ZRSjdzK3NyczdlRytNU3Yv?=
 =?utf-8?Q?rgCMW0Mhjc6jQ3oIfDaEmz+8C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BDA9EE448C25C46A1DB023EA2D2C0F8@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB5784.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7129b6-4a5f-4e79-3da3-08dcf2697e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 07:16:47.9859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IXHxapkoQSFHbc6loWXRJW8UFjwgq9Yp8QZXeM4q6N7owbWkNPgmmS+tmRCs5Vjb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB8197

T24gTW9uLCAyMDI0LTEwLTIxIGF0IDE5OjI4ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBNb24sIDE0IE9jdCAyMDI0IDA2OjE4OjI5ICswMDAwDQo+IEVtaWwgR2VkZW5yeWQg
PEVtaWwuR2VkZW5yeWRAYXhpcy5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBTYXQsIDIwMjQtMTAt
MTIgYXQgMTY6MTAgKzAxMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4gPiBPbiBGcmks
IDExIE9jdCAyMDI0IDA3OjEyOjA1ICswMDAwDQo+ID4gPiBFbWlsIEdlZGVucnlkIDxFbWlsLkdl
ZGVucnlkQGF4aXMuY29tPiB3cm90ZToNCj4gPiA+ICAgDQo+ID4gPiA+IE9uIFRodSwgMjAyNC0x
MC0xMCBhdCAxODo0NyArMDEwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZTogIA0KPiA+ID4gPiA+
IE9uIE1vbiwgNyBPY3QgMjAyNCAwNzoxOTowNiArMDAwMA0KPiA+ID4gPiA+IEVtaWwgR2VkZW5y
eWQgPEVtaWwuR2VkZW5yeWRAYXhpcy5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ICAgICANCj4gPiA+
ID4gPiA+IE9uIFN1biwgMjAyNC0xMC0wNiBhdCAxNDoxNiArMDEwMCwgSm9uYXRoYW4gQ2FtZXJv
biB3cm90ZTogICAgDQo+ID4gPiA+ID4gPiA+IE9uIFRodSwgMyBPY3QgMjAyNCAxNDoyMjoxNyAr
MDIwMA0KPiA+ID4gPiA+ID4gPiBFbWlsIEdlZGVucnlkIDxlbWlsLmdlZGVucnlkQGF4aXMuY29t
PiB3cm90ZTogICAgICANCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiArc3RydWN0
IG9wdDMwMDFfY2hpcF9pbmZvIHsNCj4gPiA+ID4gPiA+ID4gPiArCWNvbnN0IHN0cnVjdCBpaW9f
Y2hhbl9zcGVjICgqY2hhbm5lbHMpWzJdOw0KPiA+ID4gPiA+ID4gPiA+ICsJZW51bSBpaW9fY2hh
bl90eXBlIGNoYW5fdHlwZTsNCj4gPiA+ID4gPiA+ID4gPiArCWludCBudW1fY2hhbm5lbHM7DQo+
ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ICsJY29uc3Qgc3RydWN0IG9wdDMwMDFf
c2NhbGUgKCpzY2FsZXMpWzEyXTsgICAgICANCj4gPiA+ID4gPiA+ID4gVGhpcyBkb2Vzbid0IGNv
bXBpbGUgZm9yIG1lIGFzIG9uZSBvZiB0aGUgdHdvIG9wdGlvbnMgb25seQ0KPiA+ID4gPiA+ID4g
PiBoYXMgMTEgZW50cmllcy4gIFlvdSBjb3VsZCBlaXRoZXIgZm9yY2UgdGhlbSB0byBiZSAxMg0K
PiA+ID4gPiA+ID4gPiBlbnRyaWVzIGVhY2ggb3IgdXNlIGEgcG9pbnRlciB3aXRob3V0IHRoZSBz
aXplIGFuZA0KPiA+ID4gPiA+ID4gPiBhZGQgYSBudW1fc2NhbGVzIGVudHJ5IGluIGhlcmUuDQo+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBKb25hdGhhbiAgICAgIA0KPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiBIaSBKb25hdGhhbiwNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQXJl
IHlvdSBidWlsZGluZyBvbiB0b3Agb2YgdGhlIHBhdGNoIHRoYXQgd2FzIGFjY2VwdGVkIGluIGVh
cmxpZXIgdmVyc2lvbnMgb2YgdGhpcw0KPiA+ID4gPiA+ID4gcGF0Y2ggc2V0PyBUaGF0IHBhdGNo
IGFkZHMgdGhlIHR3ZWxmdGggbWlzc2luZyBzY2FsZSB2YWx1ZSBmb3IgdGhlIG9wdDMwMDEuDQo+
ID4gPiA+ID4gPiBTZWU6wqBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA5MTYtYWRk
X29wdDMwMDItdjMtMS05ODRiMTkwY2Q2OGNAYXhpcy5jb20vDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IFNob3VsZCBJIGhhdmUgYWRkZWQgc29tZSB0YWcgdG8gaGlnaGxpZ2h0IHRoZSBkZXBl
bmRlbmN5IGZvciB0aGlzIHZlcnNpb24gb2YgdGhlDQo+ID4gPiA+ID4gPiBwYXRjaCBzZXQ/ICAg
IA0KPiA+ID4gPiA+IEFoLiAgWWVzLCBJIHdhcyBoYWxmIGFzbGVlcC4NCj4gPiA+ID4gPiBUaGV5
IGFyZSBnb2luZyB2aWEgZGlmZmVyZW50IGJyYW5jaGVzIChzbG93IGFuZCBmYXN0KSBzbyBJJ2xs
IGhhdmUgdG8NCj4gPiA+ID4gPiBzaXQgb24gdGhpcyBzZXJpZXMgdW50aWwgYWZ0ZXIgdGhhdCBm
aXggaXMgaW4gdGhlIHVwc3RyZWFtIGZvciB0aGUgdG9ncmVnDQo+ID4gPiA+ID4gYnJhbmNoIG9m
IGlpby5naXQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSWYgSSBzZWVtIHRvIGhhdmUgbG9zdCBp
dCBhZnRlciB0aGF0IGlzIHRoZSBjYXNlIGZlZWwgZnJlZSB0byBnaXZlIG1lIGEgcG9rZS4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBKb25hdGhhbg0KPiA+ID4gPiA+ICAgICANCj4gPiA+ID4gSGks
DQo+ID4gPiA+IA0KPiA+ID4gPiBObyB3b3JyaWVzLiBKdXN0IHRvIGNsYXJpZnksIGRvIHlvdSBt
ZWFuIHNpdCBvbiBpdCBhcyB0aGF0IHlvdSB3aWxsIGNvbnRpbnVlIHJldmlld2luZw0KPiA+ID4g
PiB0aGUgY29kZSBhZnRlciB0aGUgZml4IGlzIGluIHVwc3RyZWFtLCBvciBzaG91bGQgSSBjb25z
aWRlciB0aGlzIHBhdGNoIHRvIGJlIGFwcHJvdmVkPyAgDQo+ID4gPiBBc3N1bWluZyBub3Qgb3Ro
ZXIgcmV2aWV3IGNvbWVzIGluLCBJIGNvbnNpZGVyIHRoaXMgcmVhZHkgdG8gZ28uICANCj4gPiAN
Cj4gPiBHcmVhdCwgdGhhbmsgeW91IQ0KPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gQWxzbywgZG8g
eW91IGhhdmUgYW4gYXBwcm94aW1hdGlvbiBvZiB3aGF0IHRpbWUgZnJhbWUgd2UncmUgdGFsa2lu
ZyBhYm91dD8gIA0KPiA+ID4gMiB3ZWVrcyBtb3N0IGxpa2VseS4NCj4gPiA+IA0KPiA+ID4gSSd2
ZSBqdXN0IHNlbnQgR3JlZyBLSCBhIHB1bGwgcmVxdWVzdCB3aXRoIHRoZSBmaXggaW4gaXQuIEhl
IHdpbGwgaG9wZWZ1bGx5DQo+ID4gPiBwaWNrIHRoYXQgdXAgYW5kIHRoZW4gc2VuZCBhIHB1bGwg
cmVxdWVzdCBvbiB0byBMaW51cy4gIFRoZW4gd2Ugd2FpdCBmb3IgdGhlDQo+ID4gPiBuZXh0IHJj
IGFmdGVyIHRoYXQgYXQgd2hpY2ggcG9pbnQgR3JlZyB3aWxsIHByb2JhYmx5IHB1bGwgaXQgaW50
byBjaGFyLW1pc2MtbmV4dCBvcg0KPiA+ID4gSSBjYW4gYWx3YXlzIG1lcmdlIGl0IGludG8gbXkg
dG9ncmVnIGJyYW5jaCBvbmNlIGl0IGlzIGluIGEgcmVsZWFzZSBjYW5kaWRhdGUgb2YNCj4gPiA+
IExpbnVzJyB0cmVlLg0KPiA+ID4gDQo+ID4gPiBJbiBwYXJhbGxlbCB3aXRoIHRoYXQgSSdsbCBw
cm9iYWJseSBkbyBhIHB1bGwgcmVxdWVzdCBmb3Igd2hhdCBpcyBhbHJlYWR5IGluIHRoZQ0KPiA+
ID4gdG9ncmVnIHRyZWUgdG8gZ2V0IGEgbG90IG9mIHN0dWZmIGluIGNoYXItbWlzYy1uZXh0IGZv
ciB0aGUgbmV4dCBjeWNsZS4gVGhhdCBtYWtlcw0KPiA+ID4gdGhlIGhpc3RvcnkgYSBsaXR0bGUg
Y2xlYW5lciBhcyBJIGNhbiBmYXN0IGZvcndhcmQgbXkgdHJlZSBhbmQgZW5kIHVwIHdpdGgNCj4g
PiA+IHdoYXRldmVyIGlzIGluIGNoYXItbWlzYy1uZXh0IChob3BlZnVsbHkgaW5jbHVkaW5nIHRo
aXMpLg0KPiA+ID4gDQo+ID4gPiBBbnlob3csIGEgYml0IG9mIHRyZWUganVnZ2xpbmcgZm9yIG1l
LCBidXQgd2UgaGF2ZSBwbGVudHkgb2YgdGltZSBhcyByYzMgd2lsbCBwcm9iYWJseQ0KPiA+ID4g
YmUgb3V0IHRvbW9ycm93IGFuZCBpdCBub3JtYWxseSBnb2VzIHRvIHJjNyBhdCBvbmUgcmMgYSB3
ZWVrICANCj4gPiANCj4gPiBUaGFuayB5b3UgZm9yIHRoZSBpbmZvcm1hdGlvbiBhbmQgZm9yIHRo
ZSBoZWxwIGR1cmluZyB0aGUgcmV2aWV3IHByb2Nlc3MgZm9yIHRoaXMgcGF0Y2guDQo+ID4gQmVz
dCByZWdhcmRzLA0KPiA+IEVtaWwNCj4gDQo+IEFwcGxpZWQgdG8gdGhlIHRvZ3JlZyBicmFuY2gg
b2YgaWlvLmdpdCBhbmQgcHVzaGVkIG91dCBpbml0aWFsbHkgYXMgdGVzdGluZyB0bw0KPiBsZXQg
dGhlIGJ1aWxkIGJvdHMgc2VlIGlmIHRoZXkgY2FuIGZpbmQgYW55dGhpbmcgd2UgbWlzc2VkLg0K
PiANCj4gSSdsbCBwdXNoIGl0IG91dCBmb3IgbGludXgtbmV4dCB0byBwaWNrIHVwIGluIGEgZmV3
IGRheXMuDQo+IA0KPiBKb25hdGhhbg0KDQpIaSBKb25hdGhhbiwgdGhhbmsgeW91IGZvciB0aGUg
dXBkYXRlIQ0KQmVzdCByZWdhcmRzLA0KRW1pbA0KDQo+IA0KPiA+ID4gDQo+ID4gPiBUaGFua3Ms
DQo+ID4gPiANCj4gPiA+IEpvbmF0aGFuICANCj4gPiA+ID4gQmVzdCBSZWdhcmRzLA0KPiA+ID4g
PiBFbWlsIA0KPiA+ID4gPiAgIA0KPiA+ID4gICANCj4gPiANCj4gDQoNCg==

