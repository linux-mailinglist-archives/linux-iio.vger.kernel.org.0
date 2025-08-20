Return-Path: <linux-iio+bounces-23048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4D3B2DC94
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B0C16ADE8
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 12:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF12311C3C;
	Wed, 20 Aug 2025 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2xVRuAkm"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F84B311C16;
	Wed, 20 Aug 2025 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693078; cv=fail; b=A0aBhVjCOEillk/eOnzwQO69dVuf+y7lhDlVX/2as19nVAcR4nQAK2pCwTwYDA9SPxXK5rikPrnrbycBn/BwIf1hTpz2S10AH0YyBbdy5Bv4RHCa1RL64mDkYW14RM0Sb7oWevJaZAVEE66QgpjTMF9FKAZSwXUkRE26CK9U8ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693078; c=relaxed/simple;
	bh=NMmbJb/F3sf3+NQNJylqMBwtUArrt96lR9vpnC8BoeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NEe6Bq/lB7H1ZvI/2QQmtvkLFJucEWZEP5IM5NpJjZBriwdG0I8gc4M+Oe9iEQqZB/cym+HuIMZdpT31+RJJMhSelCkWH14pfkwvChl10f+HbTjyPNE0Jp4oUc6gWTCiH9ph8rzMYjyP8+atFO56sz4/ocic2xkITY/2AiL0/x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2xVRuAkm; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V94H9L7SvoFi3dxOt7bJRmId29x2kz1FcMv1YHcozkJ5I887dEqHKZqBCrD1ai7A3PJ+k2+EHQWCY0HQeRcbH5n3a1khMv2J4lkAcTmn6l5Qq6lo/+nNSDoYIQQ7BvNl/EQ4TY3gOwl4u9Ojz0KiGJKZXbSOxAL9ASKn+7GOBsj1NfIDy08lv6la9U/XBjcelIU+aSgQkIJ0ef6qua/jd6O785KAkmbPQgma5YLc+P8CxGFyYO3yAQYfmQCit4ohfP8QptpHQ+XN7ixmrqM++rEUJNwrBFfOFUnzhwgHvlRcxN68lB/D/PI1JOJKImHhQuo0ibuwjbo6yW6tQ/rIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMmbJb/F3sf3+NQNJylqMBwtUArrt96lR9vpnC8BoeA=;
 b=OsDmYbY8GzYxpjaQK8x52f0Gb0+4xVOQZFzH9YGupPRG0WA3T7yUAqisSY2IKarnfh8hdIMMuIB813aI32+UeLFzqEWys6iDRJyy3LDlprn6E4pUlufFL7slSxbB8/oiXK7KKGi/v0ysubXps+jxnTgjxc057G+p7dRLX8BNzxuxelFmYQkUMW8DS0XiMKDS6ef+Sqi5RerObTXC5oq4bH8yZRzbG3nENVmYrnP58CUzmXjhe9q0oiGPiHU9LadJujzSlORhTkSyUhvRWNra27myc9MHFp8+A2jcpf3jRt2ChT9COh5UUUFRppdCqOTMWW23mn8a+yGnQsYlziuKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMmbJb/F3sf3+NQNJylqMBwtUArrt96lR9vpnC8BoeA=;
 b=2xVRuAkmp594jf++Ltut+Ja8HtIjf8hSC30xMsioMqLErNiu8OziKvPzKwt5y9KCzQjS5Hlw7rctpJWAf8qiab/w5Cf1a5vR7J6lDuT6CvSlVYA/Wl5gczLtZ/3h9J8Y6Ev9wgU614VxGUEw6VcI1qkhHwtjFsJ20yj5tv7uNOo=
Received: from MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 12:31:12 +0000
Received: from MN2PR12MB4223.namprd12.prod.outlook.com
 ([fe80::76e1:d6f4:2e56:e813]) by MN2PR12MB4223.namprd12.prod.outlook.com
 ([fe80::76e1:d6f4:2e56:e813%7]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 12:31:12 +0000
From: "O'Griofa, Conall" <conall.ogriofa@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Anand Ashok Dumbre
	<anand.ashok.dumbre@xilinx.com>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Andy Shevchenko <andy@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, David Lechner
	<dlechner@baylibre.com>, Manish Narani <manish.narani@xilinx.com>,
	=?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Subject: RE: [PATCH] iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK
Thread-Topic: [PATCH] iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK
Thread-Index: AQHcEc5PO2M1kUNsM0mFkeX76rFsUQ==
Date: Wed, 20 Aug 2025 12:31:12 +0000
Message-ID:
 <MN2PR12MB4223B775F240DFD91C6131138B33A@MN2PR12MB4223.namprd12.prod.outlook.com>
References: <20250715003058.2035656-1-sean.anderson@linux.dev>
In-Reply-To: <20250715003058.2035656-1-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=651d3a75-41ca-44c3-b8b2-92e7948e4251;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2025-08-20T12:30:13Z;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4223:EE_|SJ0PR12MB7005:EE_
x-ms-office365-filtering-correlation-id: 4145a0ad-cc06-4ddf-2e38-08dddfe572d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UU91SUpSQ0V6c1I5b2Zqa1lpVDdlaGpKNWhTSUNxR3ZDNGdWWU05N0VuRmx6?=
 =?utf-8?B?ZzJlYWtEUUZkQ3hJVkliZzdDdVpOUWExeUNqdFZlcUxORnBRREpUaXlGODh5?=
 =?utf-8?B?amRnRXcwY0lCSElHaHBtYkdSN1dIeUFuanBwU205TUxNNkRXZlhNMUE3REpw?=
 =?utf-8?B?Tk0zaW5PVWRYRm1SdUJ5a3RRQW0rbWdNSkx0UlhrTDVqckt6eXRzdGJ1WlBX?=
 =?utf-8?B?RGF5SnlZb1l1emhwNTcyMlFZenZZaVRBeTJQWkZJQ3F3OEdGWlNmYk5Oc2Fv?=
 =?utf-8?B?QkNBeHlIOW1zbDh2dk1pdDh0Q0pCbUkzbHFtL0xNb1licmtaZk9VdVJIaEkr?=
 =?utf-8?B?WUZyMm9BZmtzQ0ttN2FyVFJIRnZ4eDc2T3dFRjZEWk9Kd251eUw1NkFpMzlC?=
 =?utf-8?B?ekxHNGl4eC9vMFVPK1ZJZ01iRjZ1eDhYQ3dEelBVZ2RrYUZnODlLVUh5akM2?=
 =?utf-8?B?dDFLRVEwMjRZYVBhVXd6eitJRjRUTmViRFlhblFUQ3g0M0s3N3pZYXVsTTJP?=
 =?utf-8?B?Uzc0ajBhSnExbENqcFpSVXg0OU83MWpjNWtzb3lSeGMxRjB0bHRJRGl3Tk41?=
 =?utf-8?B?MHZpcUZPR0twWHBpN2wyYllZMkRRaUttZHRMK3doaGNJOEZ3Nk5uNE5zWVhR?=
 =?utf-8?B?ellUTHExam1xOTZWN0lVOVVJL3IrRHVlYkVMa2tzVjFEYm9mbk50Z0hFV0NU?=
 =?utf-8?B?RmZEdGIvQVI3R2Qva09kL3ZvNkdPMkdXeko2aWF6QUd1R3kwU2s4SGtDQXd4?=
 =?utf-8?B?d2MrZ1pMQ2pJOU1qSmdTbDNLaXpFQmx1emowRzFHeUdFZjFyWURybmRUVGZU?=
 =?utf-8?B?amRLTWVMc2phVGhINC9oLzM3d2REYkNvNnFITEFBY1lNUmE4bEcvRXQ2UUtQ?=
 =?utf-8?B?My9tcFcyNjZxTGVuZHdBR2hzL1hTTUJpdS9peVBaaEYvdlV4MW9JMkVvNk53?=
 =?utf-8?B?Ny9SQWZDNFF5OWlJUU9mNlpqTG9IZVUzaC9OanpnY250QUFzTTR2TzlJQ0Zt?=
 =?utf-8?B?SG5vcUNEUGpibjhaZFlRR0k3akpzVnRyMlVNU2NIS2pUTjNRd3pwdFZqL25j?=
 =?utf-8?B?TnYycmhmeFkxdVQ2TjJQaTRWdVBZTDFyRGloNGVOUnRnVXZweDY5bVl4eEd6?=
 =?utf-8?B?M0gwbzlrSjJRMHFGRzdIcmJuM3l5a0pMekY3Y0thWUpvNHdleWlSL21KZDY5?=
 =?utf-8?B?elNPTUczS1JGNFVMc2N3Q20xeVExbUJWeEtRY2MxZWh5aEJ1Rmh4ak9NRFZM?=
 =?utf-8?B?NXlyZ2xESGFRV2pLQmFzdmJncEZPTzJ4ak5LNjVjdFYrakkwNm54OG9zQ3BQ?=
 =?utf-8?B?VzlpMldaWWU5YTBLaVEzTHNCWTJocVdrYXVBWEdMK1NRMTlpTkdIV0FoTHc0?=
 =?utf-8?B?SkFQY09mL1hGRlFmNG5PMHZFU2lzQUt1N1FBeWhiNE5qQlBpMXBkQVhYMTQ0?=
 =?utf-8?B?emNscHpkZW1zUFNMN2tPRUp1S0JFdjE2bGVWWHoxRVMrU3YxY2psU3RrZVRm?=
 =?utf-8?B?NEs1WVp5Y2kyWllsSHVDOTBockVEQ1NyRFZscVMrSUdUZ3VVSlpVdmMrMUgy?=
 =?utf-8?B?K252MFd2LzkxWVRPckNaSmRIQTlBKy9XUENsSjZjdmx6alRaR2NxekxxL29h?=
 =?utf-8?B?NE5XMmJiTmg3UHlTRWxBN3dCbW9rVXJHbGs2Z2NYU1J3WndoQ2d2YjE5QXdD?=
 =?utf-8?B?YjRZMWQzSEdZRjFjL2dHWW12UHFyV0N1b0d6a2lRSzZPdTZyTEsxMFpKZFB2?=
 =?utf-8?B?bkhlOGJ1M1Q5a2lpRVUxdjBGelRQN25vdTVGem1OV3RLeU9ES1R3dzFoQnFD?=
 =?utf-8?B?ZjRrMnhLWDd5RHMxRmJKQTltL1RwNC9pVUY5YTlsY0VGbXA2MHVrcHE0Zkpm?=
 =?utf-8?B?Q2ZkTjBIdnhSWEJXTlhOYXdQYkUyemt1MDdwbmtuT1VCTzNTWHc4Ykc0VzBq?=
 =?utf-8?B?WGw3QXVqdWZrM0xJd2NVeGVlM2hqSWFDcmpNNDF2VjV3V2pwR1c2aThSSE4x?=
 =?utf-8?B?MVkxSEdGc2Z3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4223.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1VyUDRrNG82S0NrdmdYYnNXNk1oK3hRQUVZc05xMVdEckNya2pDVnFxM1dB?=
 =?utf-8?B?TzYxdFBXWW5kWWFUbEh3blFoandaMyt2eGZsNXhrb21WZDkrRXVLMU9rY2Jj?=
 =?utf-8?B?aHpSS05PV3AySksxRk9qVFNoMFdlaDc5SncwcEJMc0s4dVBweUdTUmhRcW41?=
 =?utf-8?B?UGs4a1N4UWtlU203ejNSaHdTR1ZhYmFjVmhRU29ubHhmc3hYbDlRV1QrRWIx?=
 =?utf-8?B?MDNzK2RLMk9lbm05Sno0cWVuL1kzOUpoY2V1MWg0azVRUzNHZ0tQUTRtSjdB?=
 =?utf-8?B?aUFRL0xRQ01vR0g1cVRHVHdvdEFOYloxMzdiWE5tTTRvbC9yTVpyL2g2OXkz?=
 =?utf-8?B?YUgwQ1JyMHcwenVvaEVQNnZZR3hob2lYcGZ0UytzMWFyY0psZURaQ2JlVWFm?=
 =?utf-8?B?SFA2SHExMDlzbWllcXJaVnp6M2FoaGtKR1M3Mk5kTXkrZXNQY0M5NFg0NXhs?=
 =?utf-8?B?YjlvaUVjSzNBT08zVjVrODB4RjRWWVN5a3U1OFV2R1h0ZWwrMFNsanJlTFFX?=
 =?utf-8?B?QUlSWWJaWk41SWVHc293OUdSQllLYitWQ2hIQjRTeVhISk1senZUK2tOWGZT?=
 =?utf-8?B?M3VENGtkN295R09IM28rRWJRaVppdjVaMG1LWmgzQjlacUZwVDBnWFB1SHEx?=
 =?utf-8?B?dFBYQkhDTllLcEVoOGRORVBOUHhBeE9LMmV2RUhSNU43T1NQWEJONzJ3dCtr?=
 =?utf-8?B?Ynp6d2d3bGFrbVd5UW5uSURVY2lTM2ExWHRyZU1aVUo3WHp5N2gvRHJNeTR5?=
 =?utf-8?B?VVBnZWJnL0p0dElYZTVlOTRtLzh2enNiME91bGhsVjRhM2dMN2pSRDZ6M3Jx?=
 =?utf-8?B?R2M0eWJTc0pIMmM4RXpZelcvZ2ZjdFVHd2ZuSmdkazQ0ckhDYll2T2Q3dHEz?=
 =?utf-8?B?VmhsaTVyUU1TeHoyVVZXRnpjTGIvbitCVVFCUGp2UjM3VkxLNGE0OVdZUDhv?=
 =?utf-8?B?SGlTREkzdUlvZWJ1WTZPSGtCS3JiUXJkTWR4WUhpVHhNc3cvK2xDNkFmVm9l?=
 =?utf-8?B?REI5b2YwbWF4YktWKzY0ZStCYTVxVVdmYzNqcE90bVMzcjVhdW1jejhaYjV6?=
 =?utf-8?B?aEJDUTd0S2V0VWpZbS8vT2NvOXl2eXpxUENzcE1oRFpaQjRYRVRzYndLcGJx?=
 =?utf-8?B?L25yNEFFbG15T0tkdE85b2ZkMG9PUFZ6WHdFdGNieTdGcGlvUmVMUkMwRDMz?=
 =?utf-8?B?ay8vN2ZXbWk0dDhVNHdRTEdqeStPdmJLTlBFOFJJRlMzN3VaYW96dVMwNFAz?=
 =?utf-8?B?V0hWYjM5bWM2SXE1ODdWMDdBL2hCVFNhQ0VFeGdSeHZOWHZ3NSsvd0R6VzJj?=
 =?utf-8?B?WWw4NFRKbEpXM0ZjL05BNDV2V1hxbGVwM25ld0pLb1I3QklZOFNOOGpHOUJB?=
 =?utf-8?B?TUZ3NjNRbEhIbTVlRTdaQ0pPMWtnUVljQ2hENUsrZU5sNVZpcEk5MGMxeVZX?=
 =?utf-8?B?RTA3VzhpbnJJRWJmOVBHOWdzdFBySmk2VzBXRG5rSUVFcTIraG90TUpZekkr?=
 =?utf-8?B?ZVlTcjlXOG5GZnJiZUlDY1R4Tm9Rbk1pV2JJZUxMVVM3WjNLYVJzVTBRdFZB?=
 =?utf-8?B?NXA4ckVXL1d4MWs1OFR2TnhaWkFUWURuOCtqeUNQMFM3RTBZNnlTSDAyZ2tr?=
 =?utf-8?B?VzArTFhhVUVYQWlEOUJpYnNaelFwV0JEby9FN05vQ0ZvVE0rMnpOSDFUZm5J?=
 =?utf-8?B?K0N4RmdDOTJpLzVtOWh5SWtmZ003RFRscGJXelJibk1nUzhWeThSZmtJdjYr?=
 =?utf-8?B?T0g2NkRtL0o3YjE1N2RTWTRGamNBWktQN1hvVXBGeHRBNGZ0U09ReVBpWldl?=
 =?utf-8?B?ZUM0SVQ5V0NYRHdsWC9kYUpsQ0NsMDNRdFFvRGRnMlFKclh0T1N3STZJeVJM?=
 =?utf-8?B?ck1OZm1VS2NGNTIxK205OHZDNFprNHBVNys3cHZMRmNSdFpxZFA1KzBtalM2?=
 =?utf-8?B?bDV3c2c5cUI5Skc1eUw2aTlkODhnM2UvZkFpcG82dDhsVVh5TSsrNFBOVVFk?=
 =?utf-8?B?VXpQRk9hZEZWRjV6cUJuSzM1WStCb2N2L0xZRmd2V3BsMmRPTm1ab3FkU2F5?=
 =?utf-8?B?K3VwVzdsVm5kbURYWUM2aEV1VlkxNWU2WVFmR21PZTl6NnhFVHBQc2VMek5J?=
 =?utf-8?Q?1AGI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4223.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4145a0ad-cc06-4ddf-2e38-08dddfe572d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 12:31:12.2809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zPQj4eZKeL0wOlYpGJBx5rc802qA0l8zkaStWwFNSC/Gs4Jj5dr168X8xM4Qd4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005

SGksDQoNCkdvb2Qgc3BvdCwgdGhhbmtzIGFnYWluIQ0KDQpDaGVlcnMsDQpDb25hbGwuDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2VhbiBBbmRlcnNvbiA8c2Vhbi5h
bmRlcnNvbkBsaW51eC5kZXY+DQo+IFNlbnQ6IDE1IEp1bHkgMjAyNSAwMTozMQ0KPiBUbzogQW5h
bmQgQXNob2sgRHVtYnJlIDxhbmFuZC5hc2hvay5kdW1icmVAeGlsaW54LmNvbT47IEpvbmF0aGFu
IENhbWVyb24NCj4gPGppYzIzQGtlcm5lbC5vcmc+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
DQo+IENjOiBBbmR5IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IFNpbWVrLA0KPiBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBEYXZpZA0KPiBMZWNobmVyIDxk
bGVjaG5lckBiYXlsaWJyZS5jb20+OyBNYW5pc2ggTmFyYW5pIDxtYW5pc2gubmFyYW5pQHhpbGlu
eC5jb20+Ow0KPiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPjsgU2VhbiBBbmRlcnNvbiA8
c2Vhbi5hbmRlcnNvbkBsaW51eC5kZXY+DQo+IFN1YmplY3Q6IFtQQVRDSF0gaWlvOiB4aWxpbngt
YW1zOiBGaXggQU1TX0FMQVJNX1RIUl9ESVJFQ1RfTUFTSw0KPiANCj4gQU1TX0FMQVJNX1RIUl9E
SVJFQ1RfTUFTSyBzaG91bGQgYmUgYml0IDAsIG5vdCBiaXQgMS4gVGhpcyB3b3VsZCBjYXVzZQ0K
PiBoeXN0ZXJlc2lzIHRvIGJlIGVuYWJsZWQgd2l0aCBhIGxvd2VyIHRocmVzaG9sZCBvZiAtMjhD
LiBUaGUgdGVtcGVyYXR1cmUgYWxhcm0NCj4gd291bGQgbmV2ZXIgZGVhc3NlcnQgZXZlbiBpZiB0
aGUgdGVtcGVyYXR1cmUgZHJvcHBlZCBiZWxvdyB0aGUgdXBwZXIgdGhyZXNob2xkLg0KPiANCj4g
Rml4ZXM6IGQ1YzcwNjI3YTc5NCAoImlpbzogYWRjOiBBZGQgWGlsaW54IEFNUyBkcml2ZXIiKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQGxpbnV4LmRldj4N
Cj4gLS0tDQo+IA0KPiAgZHJpdmVycy9paW8vYWRjL3hpbGlueC1hbXMuYyB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaWlvL2FkYy94aWxpbngtYW1zLmMgYi9kcml2ZXJzL2lpby9hZGMveGls
aW54LWFtcy5jIGluZGV4DQo+IDc2ZGQwMzQzZjVmNy4uNTUyMTkwZGQwZTZlIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2lpby9hZGMveGlsaW54LWFtcy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2Fk
Yy94aWxpbngtYW1zLmMNCj4gQEAgLTExOCw3ICsxMTgsNyBAQA0KPiAgI2RlZmluZSBBTVNfQUxB
Uk1fVEhSRVNIT0xEX09GRl8xMAkweDEwDQo+ICAjZGVmaW5lIEFNU19BTEFSTV9USFJFU0hPTERf
T0ZGXzIwCTB4MjANCj4gDQo+IC0jZGVmaW5lIEFNU19BTEFSTV9USFJfRElSRUNUX01BU0sJQklU
KDEpDQo+ICsjZGVmaW5lIEFNU19BTEFSTV9USFJfRElSRUNUX01BU0sJQklUKDApDQo+ICAjZGVm
aW5lIEFNU19BTEFSTV9USFJfTUlOCQkweDAwMDANCj4gICNkZWZpbmUgQU1TX0FMQVJNX1RIUl9N
QVgJCShCSVQoMTYpIC0gMSkNCj4gDQo+IC0tDQo+IDIuMzUuMS4xMzIwLmdjNDUyNjk1Mzg3LmRp
cnR5DQoNClJldmlld2VkLWJ5OiBPJ0dyaW9mYSwgQ29uYWxsIDxjb25hbGwub2dyaW9mYUBhbWQu
Y29tPg0K

