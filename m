Return-Path: <linux-iio+bounces-23041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12741B2DADC
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 13:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D8E5C3CA3
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2975F2E3702;
	Wed, 20 Aug 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pUvlE7I6"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED02DCC03;
	Wed, 20 Aug 2025 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689092; cv=fail; b=oZ6BpYmKFdr6MOwmCjSK5I3ECTmNH/zjqQx7/8fpaRqeAazcTSSqRtFgdidgXDx+QxWrwoSj2PnyqD6ch4QkRwOnmNRtO//GnBUxJ8m4r/mKbb6e39p6PtotBb5FAfA3gLTX5b2QoTiydsXl27pnPr+RP1z2r+oj9a5uMxq4lBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689092; c=relaxed/simple;
	bh=dm8a5fpq9aykBvG20B3P2JQBKH9VuG6WGE0hDWyUG54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O1HbOLefjD51csnnxYHWLPNqmiZpYzajkW6Nah05+Cxa++R1Td0ohe+sMdySYpi0BKPVXR+VUWNdjWXiwWXch0ZAtT4HR9HGw6N4J9wiV6MYq6IJTzbV8yI12elf7Vjg0RHXBJq+0kP7CR1qpozw6oLQ1CDZMA5RKV3/fRj4Qqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pUvlE7I6; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOBuCSawDfKUMjXa64bMPThvkJo95AacwHkRu/QTUg4x9hOCwgcwZr/rJH9WZl9RqEWTynVmH7VzchF38cYOJ7x9XCIPQs22o/LGhN5+kNv9sZRaXqrLJBHUjUD31xyX23G3jbkadYoCvhgjwfUW4mPWQe1dUBFnvEPIpP4QI65sBUkE2XLtkBMM5+3KkVd9jEpo9NF87bVuTpPlPnES9tdX73/3WTvgxi9WKlNy9LsHogG9/+HP5fiU8ShLUc66REAYTjS1UKBHdVH7PyRmSMczizJ01h9BuHwAUWfXrRjAM0EgqeBQ1VM9LzM+vMZKlyy1oqUS7Lnyi7dbRtgt0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm8a5fpq9aykBvG20B3P2JQBKH9VuG6WGE0hDWyUG54=;
 b=Hk8UAlEYRQ8izX07tSTe18ndToD03j92xqq64bzLKZvYHfFVGpDt09zQx/L3IB17NRS15P+lg7pINXHHvxGloG62b869opS9Phd3TG3qETsvGSLAaqQocgHZfPkSPlQd5DlvXADuaDIUe2WwA+wlinbkX/GcC8kb2ZLBLPfxb9zA68QA7b0hHUc05Le2kN7FnBCovMPSh4ffsERh0r/GWoP40dUpbl3/40NM9Ek3XBXlIa5qo7mNWXUG4yPlPidEWiyyE5jiQQxWees7fzjdU58lt7Umecai2ua34xk5I5WbFlL4XIBvYxTi+lU99v0ehBvHXyokM+X521H6J5vshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm8a5fpq9aykBvG20B3P2JQBKH9VuG6WGE0hDWyUG54=;
 b=pUvlE7I67TjQ6OBT7IFIKzlgnqdacRdUq6ZxyhuFf5uCpOZ+fxrGeFV0Pi97pz35J2Ge42HRUg3sRH8wtBEKZegGPvepom64P1Lw0z8iJa0Dpt0hyxxR5jIH5BXMg7ZmR5p+rp7S3ULFAmrkxDA45Z8U+7IQ+tcU5tcvcDrfew8=
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 11:24:47 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 11:24:47 +0000
From: "Erim, Salih" <Salih.Erim@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Jonathan Cameron
	<jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"O'Griofa, Conall" <conall.ogriofa@amd.com>, "Erim, Salih"
	<Salih.Erim@amd.com>
CC: Andy Shevchenko <andy@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, David Lechner
	<dlechner@baylibre.com>, Manish Narani <manish.narani@xilinx.com>,
	=?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Subject: RE: [PATCH] iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK
Thread-Topic: [PATCH] iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK
Thread-Index: AQHb9SAh4AVkjW3DPEmAeYY0TWIEwLRrn3ag
Date: Wed, 20 Aug 2025 11:24:47 +0000
Message-ID:
 <IA1PR12MB7736715664F30AF3D2C7F48B9F33A@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <20250715003058.2035656-1-sean.anderson@linux.dev>
In-Reply-To: <20250715003058.2035656-1-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=21b629ad-bf11-4051-aded-fabda6d6ae8c;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2025-08-20T11:24:42Z;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7736:EE_|IA0PPF64A94D5DF:EE_
x-ms-office365-filtering-correlation-id: 9386c32d-409d-4e7f-d479-08dddfdc2b7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkxCbjNxSmlkZHhyV3hPT29RSnpnTHIwM281M3dnQ1BINE5wWi9PODg2c3RK?=
 =?utf-8?B?VWk5WUJFOE5wdmt1d2ZKZUNIREpKUEt1YVpBZ2Q4eWJNNVNyQnZtU1drY2lW?=
 =?utf-8?B?UlpUTEdtNGhocFgrclNtY0JEdURYcjQwRzR3ZVhzdCtaTEhYUmZKWGFOOE5M?=
 =?utf-8?B?djVvdy9Geit5aTBSdFlmd3JTOWJuWjFuQzhoWnNVNHRyd1NIOUJRSFBVMHds?=
 =?utf-8?B?V1lOTEhPaDV5dytMV3ZrRS9UQzM0RHROUzNOOFJ4dnZWYUdmd0JUOUVmMjZP?=
 =?utf-8?B?MENXeUo0dkpDQXd5MVN2YUlDZHMyK24rRHFSUm9PL3IyWWtwUCs1U2FJL1k4?=
 =?utf-8?B?SThrSmhDQ0dmRHQvbUxTM2FBNGIvYXBJVHV0dnBwU3I0OVlqS29GQmVDMEhH?=
 =?utf-8?B?MWMraytjUDBiZTc1Wm1lMGtpVWxNWklWSStaT3FKN1NTMEY1cTR1Y2gvLzVw?=
 =?utf-8?B?ZmZoRUw3eGtmZHc0cjQwNlJ5TmIrRkh1RlpqUGZJZ3BSSzE1SVRDcHV3WkNR?=
 =?utf-8?B?YmM0S0lWQVVYaUhJNnVzbDVHS0tUay8xYzB2cVdkTWRUL1ExdUJxWm5RTDY4?=
 =?utf-8?B?WVVncC91Q0o3amRaaGxyaEY0NW96bEkyT0pFRkMyN1VSbDA2SDNIQ1Y2MzR0?=
 =?utf-8?B?N0xiWGZsSnh3WVNXYW9pTVhIZmxUOHBLcHF1Y1RNT1ZIRzNIODV1V2d2c0dp?=
 =?utf-8?B?dnJjKzhtRFhXMVJWOHZGeEsyQS8xWC9tQWNWOStiNzlDbWdUV2RmdjF0dkVi?=
 =?utf-8?B?Zmpxem11eEVxS2J5ZTNmeUZyQUNaaVNCN3oxaXRUMktEN0hyNFJzZjFkTENW?=
 =?utf-8?B?MzJKUTlWMjBxNHRQUjdtWnA1dGFPWWlhS2FQTlQzQnl3QVd6dGhseG1NT1Vp?=
 =?utf-8?B?c1dCTHRzYW5tSkdYNEVsQXdjTEM5bVZCS2FIUVFiUkxjVlpOYWhDSmV0Y3Iy?=
 =?utf-8?B?ZkNuYU1KZG1RZjhqcU95RXNhbE4yejVRRjlUb2xBNE5JRS9UQUoxSlhRLzh3?=
 =?utf-8?B?Yi9MbFZiUDJ4U1FNbjdnQVVXUUo3djlnU2NwRUpuekw2WHZuc1dUS0FWWGtt?=
 =?utf-8?B?bTB5Sll3S0dYVkZHV1o4QVRXWWhteXdOTk8yU0Y0OEVpVDJOM3FNTms0bE5k?=
 =?utf-8?B?amw3UVZyeXo4UGI1blhiUXFxNjV6M1gveE9JM1hZaFY1aEVCaVUvZVliVDUy?=
 =?utf-8?B?QWpHVHlrbkpVZFM2MUNzQkNHR2c5K0ZvemMxaFZTVXd2LzFyVVhNMFdIWkpm?=
 =?utf-8?B?blg3dkt6UUxWc2sycXhXUnJHL1hiUWJVdmh5eTZtUHcweS9randXZEFJaTBZ?=
 =?utf-8?B?MFhMUG9yRWVZbWMvRVJJWGo4MmgrVWk2NHhLQm5DUzVRTDhCRU0ralc2OGs2?=
 =?utf-8?B?ejBOMisyOGtaS1BtSTdrWEhFM2FzN01YbTlrcnFxbVV3cEZ4QW9OTjB2d1Zo?=
 =?utf-8?B?U3BPVVpPM20yQnVTVnhuTjNFZjU3cGprNmQ4enVCbnNXL2RxN3BSUnpxUUFh?=
 =?utf-8?B?WkdjVnFNZm1QUy82ZVVNTVdNR2VlMGVWaC9Pek9VRE1XdDl2WTdBeW1rblU1?=
 =?utf-8?B?bFVIWWNHUHBxazZVY2xVcFNnWWpOWUdsbVVndlFKZWdZNFNEWTVycVdqdE04?=
 =?utf-8?B?VTVYVTdDMFZSZmx5RmJib3ZuRXN1MjB5d2JIL0tNVkFhYVZ0TzNUT2lycXp6?=
 =?utf-8?B?dW5hSEp4NzdxTWFaTG1vVXBHL0hQZ2lwV1h6WWFDdmRHeG1qejBwU1ZTbnRH?=
 =?utf-8?B?WGtTSTlZcGFOMzhxcDhSSVN3SlVsbjJyVm5wU2hrL3FHVXI1a3EvbER0UDlT?=
 =?utf-8?B?RVVZaHA5MVdxTytxQmZBSndRd0REZmZKZ21GdEVoQkJIYTI4RTVEUUNqRy9a?=
 =?utf-8?B?OU1CY3FpWUZQWjZ1VmIrUVE3YWtoUnFzVVFEM1VId0s3eDhhSGJiWGQrdGhW?=
 =?utf-8?B?ZnBGUVdRUUhPN0pZZGIwbWlhSDZScFdMUnNnNHJkZ3FOU2pteEVDTlhjblI0?=
 =?utf-8?B?Q0JNbFRGQWFBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkpXK2Jhcnc5Rzd0VnRXQlZDeXBxcFVSQXBLT0xQM29NUHFKQ0tPcXhQcWRL?=
 =?utf-8?B?UHc3SkZPWWh3VHJ6eFg5TG93QkhrVHdCaklvSUQ4b2hGUlc4Q0lsY1JwM1p1?=
 =?utf-8?B?YTQ1cHhvMjVBaXEyUGRjSjZDck9JRnRhWUZoUXZUTkd6NEx3VEF0a0tMTjZF?=
 =?utf-8?B?OHM2dGszYkY0cEdWYjVkWE5pUkRiQlgyb2VCOTE1aEZtZHRyMU01WmZjUlZV?=
 =?utf-8?B?ZE51SnBMUFpsZU5CTDRSdkJDQ2dQZHZ6ZFR1RUg1T1BOYW40Qm10LzY2WW1k?=
 =?utf-8?B?aWZZK2pKeFFyeDBVbC9FNFYrVnhsc0c1dHh6RzJqYWRDNGFGcEVib1BWNUhw?=
 =?utf-8?B?TVpOTjRxMzlJaFllNHV5NjFyTHpCR2pacm5JS0xJYnM3SHVZcWpXayt6a2Fh?=
 =?utf-8?B?OCt0ODFMcnpxVzJISFk4RWJ5cFJ2M0pXcjY5cTF2YTBEMW93Y2haZ0laQmtY?=
 =?utf-8?B?aHdwYmxaZDBJUVI5ODRhNFBGZjNkcGRVV2NPbW1NZ2hkZlo5S25DMUphd1Iy?=
 =?utf-8?B?WHVyQnoweWRCN1Q1L2dsK0dZTFZYTTFlV29mTVZxY05nYVovS2dEQ0xFN1Nl?=
 =?utf-8?B?WTc4dnE5RnNvZ0RCU0JFUC9QckpMTE4zLzIyTmRLdVprbVI2Ni9aUDBNcEtu?=
 =?utf-8?B?aTNoWmhXVG5wNWRoQVAxL1hGMzFnelhZVk83d3dGZmExeFU1Zm5yL2RqQlg4?=
 =?utf-8?B?UFAwa1Z2ZGQzTHVXSDZWYi9TMjcvVTFmc0doTW4yQVJ5M1ZKV3hZeU8vQkZy?=
 =?utf-8?B?SzRBNUxXOE80ZjZOb294WmRzckp4WU9Sb2VtTWZwRGhDeHFNcTU0M3hyOFVQ?=
 =?utf-8?B?U0FKbU9Qa3l4R0lHKzRXVWZySGhIOEVkNFUxa3NEUjVsL2N4WVFrSlZSNDVB?=
 =?utf-8?B?YTRxekpjRVcvcThOaXNBRDl1MjNYYkRDWStJbVR4aDYvNHIzK0V0eWJ1NUJR?=
 =?utf-8?B?WndIYStIV2FJL1B3aSs1L2VIK1ZkNGZpem5iaWNrdkprdTJOcHJmem9TckUv?=
 =?utf-8?B?TWdicFRHQ2FZTDZ6VnZjK2Z4RDgzZGt3MVFacEN5a0t6QWhHWWdMSjFtcEpO?=
 =?utf-8?B?TEJUTEFrUmwrRjNyNDIxWlhZbnc2N0FhYkNiTkljU0NsREtRcVdHbkZQYUJw?=
 =?utf-8?B?NjVMbFdRaDhJSzhzeGQ3aGNoZzFQVlhtYzlJbVR4bk1xZ3VscjNGZkhxenN5?=
 =?utf-8?B?c3lvMHNWRWt1and6WXJaSmxnMjE5WHE2Y2pVb0hzeXlTcDlJWUUxaE8zeFEr?=
 =?utf-8?B?U3hOQXR1V1p5b1ZJS09jbGNGT0U2T0RHUXZ4VndleUhyTjE3K2txTUJlSVNP?=
 =?utf-8?B?dGhpbWVSRWdwRzFTeFhITU5LZERiUllKcnVyNWI1ZVZmTTZ3ODk3Lzh3MFRC?=
 =?utf-8?B?cDEwUlVJZ0h1WHJBSFNJbTljTEtoS1NBUTRuSDJacHNVbDBFbGJLVlRSZTFK?=
 =?utf-8?B?UWpvdnJHZHN3WHNiRkFrbUZrNld3UmpwcVAxVW0xL3JxTzd6T1RUUmRjdTlW?=
 =?utf-8?B?bDNRSXVWLytkZUFHU1NUeW53QTBQdmhFdWlZQVhiL2RndnlJdEdlcUtMOHFp?=
 =?utf-8?B?MWlVcXNIVTJYVUlsZ3pBeWttNFF5bTRsRXJzdTh0UFhoR2RWRmpEV1ZUSGJU?=
 =?utf-8?B?dmhnOUkwQWtBaFlpV3JSUFEyTk9ORG1FVzV0Q0pYWm8yQmdiaUthbGtHVUww?=
 =?utf-8?B?MDVvMjh0Tm55Sjkyc015TVJuUGVmbmFYalR4V2Jmb2RDUW43MkZibC8vd25o?=
 =?utf-8?B?VGtER2JRZ1E3V0ZjeFdGVW40ekdhVXBNaDEvUzRUcXRrMVVoUG1PZm54amhG?=
 =?utf-8?B?bGgzRzFuUFE4NkdRb2t0cTdOOXRaU0NQZnY4a2UzUUJaM21lVVRycGZlYnBP?=
 =?utf-8?B?aGtLeldWZE5VS0pRQ1NSM3pZTUkzTXNYYlNuYlFrTjhWSzlNL2puRlkvdWFR?=
 =?utf-8?B?cklHSkp3OEdKNDJCT1k2bHRteTJ1NTd5U0k4ZVhYWkMyWFNsMlAxaHU2bEgw?=
 =?utf-8?B?UjNwZzJiLzNEQy9vR1RHQk4ydEUvNHpmb05KMkxpcHhwVEUyS2hFME1iblRx?=
 =?utf-8?B?WWFWV29nRTZmVmprVy9menZsQjZWendrNitLYTZLOFpRREl4SnFqWExHNTVw?=
 =?utf-8?Q?jIIE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9386c32d-409d-4e7f-d479-08dddfdc2b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 11:24:47.1793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80V1Pi2BE/CdJye/cHNWK9P1sROofn2ljnRbT+VS5g9M/V6LLEFS8umUCGEwlzdw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF

SGkgU2VhbiwNCg0KVGhhbmtzIGZvciBpdC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQGxpbnV4LmRldj4NCj4gU2Vu
dDogVHVlc2RheSwgSnVseSAxNSwgMjAyNSAxOjMxIEFNDQo+IFRvOiBBbmFuZCBBc2hvayBEdW1i
cmUgPGFuYW5kLmFzaG9rLmR1bWJyZUB4aWxpbnguY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8
amljMjNAa2VybmVsLm9yZz47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEFuZHkg
U2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgU2ltZWssDQo+IE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IERhdmlkDQo+IExlY2huZXIgPGRsZWNobmVyQGJheWxp
YnJlLmNvbT47IE1hbmlzaCBOYXJhbmkgPG1hbmlzaC5uYXJhbmlAeGlsaW54LmNvbT47DQo+IE51
bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+OyBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29u
QGxpbnV4LmRldj4NCj4gU3ViamVjdDogW1BBVENIXSBpaW86IHhpbGlueC1hbXM6IEZpeCBBTVNf
QUxBUk1fVEhSX0RJUkVDVF9NQVNLDQo+IA0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2lu
YXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4g
b3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+IA0K
PiANCj4gQU1TX0FMQVJNX1RIUl9ESVJFQ1RfTUFTSyBzaG91bGQgYmUgYml0IDAsIG5vdCBiaXQg
MS4gVGhpcyB3b3VsZCBjYXVzZQ0KPiBoeXN0ZXJlc2lzIHRvIGJlIGVuYWJsZWQgd2l0aCBhIGxv
d2VyIHRocmVzaG9sZCBvZiAtMjhDLiBUaGUgdGVtcGVyYXR1cmUgYWxhcm0NCj4gd291bGQgbmV2
ZXIgZGVhc3NlcnQgZXZlbiBpZiB0aGUgdGVtcGVyYXR1cmUgZHJvcHBlZCBiZWxvdyB0aGUgdXBw
ZXIgdGhyZXNob2xkLg0KPiANCj4gRml4ZXM6IGQ1YzcwNjI3YTc5NCAoImlpbzogYWRjOiBBZGQg
WGlsaW54IEFNUyBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIEFuZGVyc29uIDxzZWFu
LmFuZGVyc29uQGxpbnV4LmRldj4NCj4gLS0tDQo+IA0KPiAgZHJpdmVycy9paW8vYWRjL3hpbGlu
eC1hbXMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy94aWxpbngtYW1zLmMg
Yi9kcml2ZXJzL2lpby9hZGMveGlsaW54LWFtcy5jIGluZGV4DQo+IDc2ZGQwMzQzZjVmNy4uNTUy
MTkwZGQwZTZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMveGlsaW54LWFtcy5jDQo+
ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy94aWxpbngtYW1zLmMNCj4gQEAgLTExOCw3ICsxMTgsNyBA
QA0KPiAgI2RlZmluZSBBTVNfQUxBUk1fVEhSRVNIT0xEX09GRl8xMCAgICAgMHgxMA0KPiAgI2Rl
ZmluZSBBTVNfQUxBUk1fVEhSRVNIT0xEX09GRl8yMCAgICAgMHgyMA0KPiANCj4gLSNkZWZpbmUg
QU1TX0FMQVJNX1RIUl9ESVJFQ1RfTUFTSyAgICAgIEJJVCgxKQ0KPiArI2RlZmluZSBBTVNfQUxB
Uk1fVEhSX0RJUkVDVF9NQVNLICAgICAgQklUKDApDQo+ICAjZGVmaW5lIEFNU19BTEFSTV9USFJf
TUlOICAgICAgICAgICAgICAweDAwMDANCj4gICNkZWZpbmUgQU1TX0FMQVJNX1RIUl9NQVggICAg
ICAgICAgICAgIChCSVQoMTYpIC0gMSkNCj4gDQo+IC0tDQo+IDIuMzUuMS4xMzIwLmdjNDUyNjk1
Mzg3LmRpcnR5DQo+IA0KDQoNClRlc3RlZC1ieTogRXJpbSwgU2FsaWggPFNhbGloLkVyaW1AYW1k
LmNvbT4NCkFja2VkLWJ5OiBFcmltLCBTYWxpaCA8U2FsaWguRXJpbUBhbWQuY29tPg0KDQo=

