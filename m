Return-Path: <linux-iio+bounces-15105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38843A2BDB3
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 09:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6057A28A3
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 08:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939D71991CF;
	Fri,  7 Feb 2025 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n3+LO/Uk"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26C52417F5;
	Fri,  7 Feb 2025 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738916371; cv=fail; b=hA93TxBHt6TMliDuleKuurIRt9W6ga3wOmzdDI5/Dotbo+tVTw6QwQXHOnR2rzehG0YtHHHm5VEG3+nAfckjTvRvrJaeVJVSDwk4+mF5OK5SySpCf3wwjfc7BiB0+wfECB07uMoez6T+ZnHL5zc7JUKPT4g+thkY9T/9LkVMNXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738916371; c=relaxed/simple;
	bh=kzkEiji8UgR7lZGn/li7sND7H6lWZPonCgLQBF8QoKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qUtktFp/AP72xAdgMBZkkqbe/XM/MLdMzZxrh0CngciA3KP9iXMlHCP2HDsEGnuPBsl7DqBBeqkzO90vKm4UzutPcIjrffY9d/eoMU5qHo9tQ6w8Gn3pAFABPLcxo8C4P8EMOHrMhN9XMUwJzyXUV5ySCQoAzE8otViOUqXH8pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n3+LO/Uk; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsDwQXU0c8A+gaQDxjzFa3KiPMzJ183xTiFw812cw/iJwprryEyIv47ap7LhE7dHrMwKF5vxiNaZXuI+24a4ucdapa8ioP+0tDS5CsI1n6UIq7UIqudmuShD0aAyVTzufptZsq7/Q3UQsUqLsllwjH8an78+wk/iV0pOsusVZ0eKSqs55+yGru+BsWymssnjctY46pgEI/4/iScgywRGfLV96AGiemZvivFYZbVU0eoD741siUCCTGgPO/DOiiMEGSdr3DWcKslIEoOSssBdbswsrHl4gHcu5blbsbsOOMHunu77nQ1ZmcS6vASv9000JCvfCEAKzJEN/MZO/bnEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzkEiji8UgR7lZGn/li7sND7H6lWZPonCgLQBF8QoKY=;
 b=x4VCEEPMAyFmYtrB7YTw4ZEAAceaPNER7Zz+FIz3Jn8pz8zsPFrf3lL5OTxOf+v3OvNWALiVi2rYqlhmzqh4XibX2KcNlh5ZfTeJicAChxlbzgyTNTdFTLnaooFg0XV24tJy6qAMQwxs93pUVKjoK+wH+wyLrgm9ZJxu6Pz/uP5ljyjrOYV1pekxHih/YZWCi5FE2DYm5xxiHIRksd9bdpoFkUPJiETn4yJbExvrRQ6jxoSRE2BS7rleoyA0roMEjjivs6aRot0xuW1FAh2aoddnVrrUS+30h+FdyelHyEFMHRacZ1WlTPlyo+brzRogIejREw4id6/el2ZTUmEXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzkEiji8UgR7lZGn/li7sND7H6lWZPonCgLQBF8QoKY=;
 b=n3+LO/UkbpMMb1C1VL2aRcM4lJfYaPXitJVIQG5TlH6wOyvsWNwsmQfRrDER+t3CrousuBGKH4nRtHFym5AWM2gGK7r5wTIj6qGpI+7blkFbt9QSoCPtkF2EFRsI7yTisvcvtrXN9JpwxPXeVbzrm9RsziASBPqkIvrQbvxJWulTwZePbMODg7rtB7zITbvIN6uLVDG8VyQx0oWLsgQGoXH+KG+GHmzvGgLTUQtcFTz05PLWQkfgZQvYUWbEYBiUWpR5Zmtd1m0pH42BFB/rBv3Q9PHQ/c4N1OO/hLG1Jn1fGq4XzHJlv3nf3UH/MxMiPrFBQn6wty/HJ2FaMPpq2g==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 08:19:25 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 08:19:25 +0000
From: <Dharma.B@microchip.com>
To: <csokas.bence@prolan.hu>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kamel.bouhara@bootlin.com>, <wbg@kernel.org>
Subject: Re: [PATCH v3 2/2] counter: microchip-tcb-capture: Add capture
 extensions for registers RA-RC
Thread-Topic: [PATCH v3 2/2] counter: microchip-tcb-capture: Add capture
 extensions for registers RA-RC
Thread-Index: AQHbeTj/A+MmMW6bDkue5fHpPDsxVw==
Date: Fri, 7 Feb 2025 08:19:25 +0000
Message-ID: <37bf1294-a9c4-4a6b-9e5a-b8bc54ed87e9@microchip.com>
References: <20250205104957.95236-1-csokas.bence@prolan.hu>
 <20250205104957.95236-3-csokas.bence@prolan.hu>
In-Reply-To: <20250205104957.95236-3-csokas.bence@prolan.hu>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|PH7PR11MB7595:EE_
x-ms-office365-filtering-correlation-id: 2263538e-ae27-4c73-ae1f-08dd4750225a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mkk3NzUxbUJrS1VoWjlYZ015RkpPVlRoWTZSencwOHQvV1hXWEVBS3R3WVF3?=
 =?utf-8?B?OFZ1dWZNVDhqa2FEOE40MHQ1b1haaVEzbjBsdTcxTC81VldKNXdSSzBWUVpt?=
 =?utf-8?B?bENTd0dra0szL0dtb1ljUDRLWVAxY1VJWjRuUHI0bGNQM2QyUkkzSy9jcG0z?=
 =?utf-8?B?RGNtblFkbUR4VEFtY0VkanlYRmxKaXZxTjY3MmxEdU43UENmeE9KTXNpMVRl?=
 =?utf-8?B?aC9iZExqTWx2SXdMc1NJWVhjRmpLRllpd1hyRDZIcWhoWi9YbGhQSUM4bmls?=
 =?utf-8?B?VWUybTZOcHo5TXg4N0RFK2l0U1UwdlJNWmRxdVRwS3haMU1SclM0dXJUWm5z?=
 =?utf-8?B?d2NaOFRUeENFMUxCQTdrZjh5YlhkSjJwTzlERjlVc0QwOFpzZnZ1WU15dVNk?=
 =?utf-8?B?OFRuU1BQVmNqTU1taG0vV1dOVUk5N2Z6R1IwREFGaW1xUk9NbjlQQXBROCtO?=
 =?utf-8?B?UWVwdjVUeklQajhZVitsL2hMakE5UVJSTi8rL2k3aDNLYnhKNnlRV2VXN1pu?=
 =?utf-8?B?cVlaeDhsS01kTlFJQzFkMGVhMERxeUFzb1dzOXd0OEtFTHpwUnpQZ25BdzJD?=
 =?utf-8?B?ci9pMlRFcGF3ZWVJcWtPdHhFYWdNdUF2MEpaTmMrWUNyR2xxUG5EczROd0Vx?=
 =?utf-8?B?WWRTejY0WHllMmNacy9RSmNmUGhuOGcyQmNoTHRsb0ZzWmUvcjM4bWNvWDNs?=
 =?utf-8?B?TDNPOXhBZkxheHZkdVdZWnEzSDhGOFZiNDJxM2RMaVZXRGNmODh6QkRNODhY?=
 =?utf-8?B?T0EwSnlGY2VRK1drTXYzU2dya0hJbWVqMEhwTiswOGN1VXVweFlrQ2JSL3Z1?=
 =?utf-8?B?dDdzdWRVdWlYWG9LbjY4bUVQSHUrSnhLZXFORVB2NnFjdW1OS2xjdnJkaGFk?=
 =?utf-8?B?NUlZV1VlMGwvOWtEcjErT0gxZlZONmxhQ2wxdFo1cmxNZFBFdUR2UEtYdlQ1?=
 =?utf-8?B?MmJnZHZVaFFMN3kxbitRVXZWZGwvbzA4S3lEK1ByV2k4QTZUV25CcHhXOGdP?=
 =?utf-8?B?clVjL0orREVNbUg2Z3hCU2RKOUNkM3N2U29US09HeVJjK2ZNMUFlQW9pZDlT?=
 =?utf-8?B?eHphcExTck9TRWdNZ21xbGtXNzRFZFFDKzV0OWR4dVRQZkJSK0FCM1dIWkFI?=
 =?utf-8?B?bEt6SDVlakxzRjRQUmdCYjFJbEZ1QUlZYlNHenhUUzh6RW9FTFhiWHZVUktY?=
 =?utf-8?B?ZTRXUnFXbXFKK3VJUTZEYU9tVUsySEMvMFJqdWcwK0FmVUhLQmpaUlZlQzVn?=
 =?utf-8?B?cFRRV3FrcG4veW43dmw2TXlWMm04eUhkcmJMZ1h3c2VOMjh6UzIzWWYvZDZN?=
 =?utf-8?B?V0RQZGtqc1VMQVB6RlJVU1VlWFBZdU9wNVR3L0lwbUJIRUlQWHBqSHJRd1dj?=
 =?utf-8?B?dVVNdWJnelFwTWtlQ0M1Y3hUQlBLeWJpTEIwUFVxRWpQWkIyamwrV2dXT0l6?=
 =?utf-8?B?eHcxQjM5aUdaV08wb2hORkY1OXdkZjdHV3VoM1BPMHBDa1YzWGZSMGNSdUpS?=
 =?utf-8?B?bUJYWDAvbmFucFZNOTJ1YjNjRG1WRHdmRXFDTjkwQms0Sk1qd0Mvb0dUS3hv?=
 =?utf-8?B?NE5lRnZ0Ynl3SGpIcmdKY3FBSFlodUMwMkxiNG1lVHlwcTkxVk1TMldJVWdZ?=
 =?utf-8?B?YzF3WXdJdEQrVU9Pc0lQQWR5Rnh6S29QandYeVdTeFVZb1Q4Vk1Kb0dxc0Z1?=
 =?utf-8?B?ZStUdlFRcVBmYzNMMXV1czlRWG53bDdMZDdoRG03c2k5bXRRdEhkaTFseWUr?=
 =?utf-8?B?cjVudWZ6M05DRHQ0MzRZQ1h5UlZPdWNLbnlCTmZNK2xPaHYvVklaUWZRN09u?=
 =?utf-8?B?ejh4MWFQaXZIeVFpc2JXaS9KSlhiQjdzODBNOTkrNE1scjdGVzNZMWFvdmFP?=
 =?utf-8?B?WHNYdm9uYjFNV3p1SldlSTBDdFBxY1oxaXk2bU1lL1FpK0owMlpXa3Z3ZFdE?=
 =?utf-8?Q?a2Elt8FCAAh5uOy6CL7XCW6D8xUdfmKt?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHJVeEtVR0JIZUVsR3EwUlRReE02aG9tbWtwNllYME1QLzJIN3F3SmV3QjZE?=
 =?utf-8?B?c2M1SWlOYjV0RStHcTRPcmlsSUxFaWRMcmN2SHVNQlhGL0dvNm9acWRjTk9M?=
 =?utf-8?B?bTlMd09aTS85d0YrWFNTMWpCRU1GZ2d6N2R4QXF1K2NGRUVKQmM0d3EvQk1L?=
 =?utf-8?B?eDNRenViTHlxd1ptRXdla1FuVkVsSjUxMkh4RzNPMG9zMldtd3pOd0pFNElX?=
 =?utf-8?B?NEdDTVZGbjVRQllUdnlDUUtmQWdDanZGNzZNQ3NyTGdjSG9US1lpTDR1R0hQ?=
 =?utf-8?B?MitIdTc1eFhwY3U4bjVKSjI3ZWROams5Mkt1TFJxTnR3RVFmampxYTFCYmlU?=
 =?utf-8?B?STlDbFFVa1dpaHNkWDdUVUZ3N005NDh3OCtHenlYWWlXODBjVVBacWIzTk5s?=
 =?utf-8?B?OEs4dW1udzRlTXNIZXRpdk5qQkd1a1FzT1ljM1ViVmZDWkh3cndLR2xOOVBa?=
 =?utf-8?B?UFZGWjkvWUgramhTeE9jMmFEaEl0K0Vta2EwT3RiNk04b0pWdGVIVkRud2F2?=
 =?utf-8?B?Z3B1WVU4WXh1Tjk4eW1pZ2I1TG4ySDJTVWZGNDZtNlpSNU5kRHU4Nzk4b29Z?=
 =?utf-8?B?Q200Rzd2ZW1NVERXazUyLy9uV2JXQWoyRWJadUxrRTVSN2JtZ25aamtXSHFU?=
 =?utf-8?B?b3AwQ1FiNzhEamh6T2lnY2NBK1dKdXUzV3pSZGR4dFVPSlpIMXpOR2g2cmVO?=
 =?utf-8?B?T1FIVm9Oc3NHYWsvM0FJdE4venc1cXJwUm40bkpRNGFBUXNSaWRxVVpUTmpQ?=
 =?utf-8?B?cE1vbHltbUVSUkV0NjBkck1DaHg4NlNrbktmcVVGTGdFUk1nZTIwYklNT0Fk?=
 =?utf-8?B?bkVraTVHREsySDZZU2JaeWlIb1NXb2pwdEdTQi92a0ozbDRQTE1NeFFrb0pH?=
 =?utf-8?B?TUZoL2UrUm0vU3k5SG5rMHN2N1pXdnQ2OVVyalJYZTVpbnBQRSs5Y3hhQ00z?=
 =?utf-8?B?MkgvTEdBU0xLNE4ydXh1RXQrbk9ycDBjODVidmYxM0RPRnc4UitWTno0UkNR?=
 =?utf-8?B?QW1SSi8xbjRrMFZ1L0ZjaEU1MUxrK2dZQmVZV3hQTDlrdFRuVjFmYjFYeXM3?=
 =?utf-8?B?b2dhYkVGODVKUmZQRGNKWm5YZWhtL1JnVmNFeno5cmM3OGRrY1R6SHd5bWVr?=
 =?utf-8?B?MDhCWDBvK3E1bzNEYU5NdmxtYlRIdXRtQXBMd3Mzc3hNL1E1SWxqRmx2anpU?=
 =?utf-8?B?MGtnY2lsT1A4ZWI4UmVtdndyMzNhZXNWRnVpUEFKUmp0VVJ5RUF1TTBaanl1?=
 =?utf-8?B?dWpvNGkyOWZPVG0yWkxBTWo5RTlqOUFvWFM0SW9SQnI5TzhoRFBLQ0pITGd2?=
 =?utf-8?B?SDdlbWpNY3BYL3Y5RHhPR3ZyRUtWckFHTDJOM1Q0NVNFRy94ckRSTGdXdjRI?=
 =?utf-8?B?cVpXeXlwZVhnREFobFRZUjlIODF3R3hYV2FSbDZiTElvSlI5QU9BZ1BtdTk4?=
 =?utf-8?B?WEdIMDRCMUFqMnBUQ2cyRHlNMmRSY0NTd2RKVUN2OU9zTGlrbDY2TXhRUmJr?=
 =?utf-8?B?UXdyTWl1S1BnY3NDU0hEUUJpWmRJQVZHeU9leWN1VnkyVkVsdHcwOW1tSGZE?=
 =?utf-8?B?ek02MWlCekNhRVRYSi81TkJGQ0tuamRWNzJibWluMW1lVHZzQnVGS2cyd1NF?=
 =?utf-8?B?T09ad01qZmY1aU1pa1RQRnBaSncwWlo5SlQ3TEtJd1ZPNVhEOERRYzlaMWxy?=
 =?utf-8?B?YVJqRjAyTzdVTmZrRGtNNVdUQlRaVWJMUm10RG85YnFKdm5Vd0hGWGNwTlN0?=
 =?utf-8?B?ZVoyK21BMkFuNlRpT0wra2x5ZWhFK3h6NmU2OWtSL3RpazBSYkMvYW1idFBy?=
 =?utf-8?B?TDBHN3BKaFQyaVpoS0lXTlgxcjlhZXpuVjJiQS81WDZhaVpqZ2xDdVYzT083?=
 =?utf-8?B?Zk9NQjFLWmVIeVVXc1c3TjhCMWhsbDNqaFVoaGIxZjgvVEZzTlc1KzdCdkFS?=
 =?utf-8?B?ZnBLYUMrR2VxcEs3MEp3YWJZeFhKQUovTmxOSE1Ud1hqVW5WRCtCdS83c2Yx?=
 =?utf-8?B?RkQweUdVMXNtSW5QNWJoNEFnY1BkSGNPWW5aejgzL29MNXgwU2hNVWpIakVz?=
 =?utf-8?B?VE0zK21QeTJXVzJLbkgvTTllVXlsS3dUUytBczJwRXkwa1FIYWFuZVRxVi9M?=
 =?utf-8?Q?31pnHpbcoTp/mzOOw5yBYaiMu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55B8A0F79E394648A717C5CA1F980F2A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2263538e-ae27-4c73-ae1f-08dd4750225a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 08:19:25.5521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: feKB9n1jj5fol46/3cpppbOVQqMNKsG1e9/MXRwCJaMQsvyJleWd5k4GDYvBpHvW1nCnaNr/osM9EStEqGnb6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595

SGkgQmVuY2UsDQoNCk9uIDA1LzAyLzI1IDQ6MTkgcG0sIEJlbmNlIENzw7Nrw6FzIHdyb3RlOg0K
PiBUQ0IgaGFyZHdhcmUgaXMgY2FwYWJsZSBvZiBjYXB0dXJpbmcgdGhlIHRpbWVyIHZhbHVlIHRv
IHJlZ2lzdGVycyBSQSBhbmQNCj4gUkIuIE9uIHRvcCwgaXQgaXMgY2FwYWJsZSBvZiB0cmlnZ2Vy
aW5nIG9uIGNvbXBhcmUgYWdhaW5zdCBhIHRoaXJkDQo+IHJlZ2lzdGVyLCBSQy4gQWRkIHRoZXNl
IHJlZ2lzdGVycyBhcyBleHRlbnNpb25zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmVuY2UgQ3PD
s2vDoXMgPGNzb2thcy5iZW5jZUBwcm9sYW4uaHU+DQo+IC0tLQ0KPiANCj4gTm90ZXM6DQo+ICAg
ICAgQ2hhbmdlcyBpbiB2MjoNCj4gICAgICAqIEFkZCBJUlFzDQo+ICAgICAgQ2hhbmdlcyBpbiB2
MzoNCj4gICAgICAqIE1vdmUgSVJRcyB0byBwcmV2aW91cyBwYXRjaA0KPiANCj4gICBkcml2ZXJz
L2NvdW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0dXJlLmMgfCA1OCArKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2NvdW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0dXJlLmMgYi9kcml2ZXJz
L2NvdW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0dXJlLmMNCj4gaW5kZXggZmVmNGJiNjliNDg2Li4x
NDQ1YWM1MTJjNTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY291bnRlci9taWNyb2NoaXAtdGNi
LWNhcHR1cmUuYw0KPiArKysgYi9kcml2ZXJzL2NvdW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0dXJl
LmMNCj4gQEAgLTI1Myw2ICsyNTMsNjIgQEAgc3RhdGljIGludCBtY2hwX3RjX2NvdW50X3JlYWQo
c3RydWN0IGNvdW50ZXJfZGV2aWNlICpjb3VudGVyLA0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+
ICAgDQo+ICtzdGF0aWMgaW50IG1jaHBfdGNfY291bnRfY2FwX3JlYWQoc3RydWN0IGNvdW50ZXJf
ZGV2aWNlICpjb3VudGVyLA0KPiArCQkJCSAgc3RydWN0IGNvdW50ZXJfY291bnQgKmNvdW50LCBz
aXplX3QgaWR4LCB1NjQgKnZhbCkNCg0KVGhlIHJlZ2lzdGVycyBSQS9CL0MgYXJlIDMyIGJpdCBy
ZWdpc3RlcnMsIGhlbmNlIHVzZSBvZiB1NjQgaXMgdW5uZWNlc3NhcnkuDQoNCj4gK3sNCj4gKwlz
dHJ1Y3QgbWNocF90Y19kYXRhICpjb25zdCBwcml2ID0gY291bnRlcl9wcml2KGNvdW50ZXIpOw0K
PiArCXUzMiBjbnQ7DQo+ICsNCj4gKwlzd2l0Y2ggKGlkeCkgew0KPiArCWNhc2UgMDoNCj4gKwkJ
cmVnbWFwX3JlYWQocHJpdi0+cmVnbWFwLCBBVE1FTF9UQ19SRUcocHJpdi0+Y2hhbm5lbFswXSwg
UkEpLCAmY250KTsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSAxOg0KPiArCQlyZWdtYXBfcmVhZChw
cml2LT5yZWdtYXAsIEFUTUVMX1RDX1JFRyhwcml2LT5jaGFubmVsWzBdLCBSQiksICZjbnQpOw0K
PiArCQlicmVhazsNCj4gKwljYXNlIDI6DQo+ICsJCXJlZ21hcF9yZWFkKHByaXYtPnJlZ21hcCwg
QVRNRUxfVENfUkVHKHByaXYtPmNoYW5uZWxbMF0sIFJDKSwgJmNudCk7DQo+ICsJCWJyZWFrOw0K
PiArCWRlZmF1bHQ6DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0NCg0KVGhlIHJlZ21hcF9y
ZWFkKCkgcmV0dXJucyBhbiBlcnJvciBjb2RlLCB3aGljaCBpcyBjdXJyZW50bHkgaWdub3JlZC4g
SWYgDQpyZWdtYXBfcmVhZCgpIGZhaWxzLCBjbnQgcmVtYWlucyB1bmluaXRpYWxpemVkLCBwb3Rl
bnRpYWxseSByZXR1cm5pbmcgDQpnYXJiYWdlIGRhdGEuDQoNCj4gKwkqdmFsID0gY250Ow0KPiAr
DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgbWNocF90Y19jb3VudF9j
YXBfd3JpdGUoc3RydWN0IGNvdW50ZXJfZGV2aWNlICpjb3VudGVyLA0KPiArCQkJCSAgIHN0cnVj
dCBjb3VudGVyX2NvdW50ICpjb3VudCwgc2l6ZV90IGlkeCwgdTY0IHZhbCkNCg0KZGl0dG8NCg0K
PiArew0KPiArCXN0cnVjdCBtY2hwX3RjX2RhdGEgKmNvbnN0IHByaXYgPSBjb3VudGVyX3ByaXYo
Y291bnRlcik7DQo+ICsNCj4gKwlpZiAodmFsID4gVTMyX01BWCkNCj4gKwkJcmV0dXJuIC1FUkFO
R0U7DQo+ICsNCj4gKwlzd2l0Y2ggKGlkeCkgew0KPiArCWNhc2UgMDoNCj4gKwkJcmVnbWFwX3dy
aXRlKHByaXYtPnJlZ21hcCwgQVRNRUxfVENfUkVHKHByaXYtPmNoYW5uZWxbMF0sIFJBKSwgdmFs
KTsNCg0KZGl0dG8NCg0KPiArCQlicmVhazsNCj4gKwljYXNlIDE6DQo+ICsJCXJlZ21hcF93cml0
ZShwcml2LT5yZWdtYXAsIEFUTUVMX1RDX1JFRyhwcml2LT5jaGFubmVsWzBdLCBSQiksIHZhbCk7
DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgMjoNCj4gKwkJcmVnbWFwX3dyaXRlKHByaXYtPnJlZ21h
cCwgQVRNRUxfVENfUkVHKHByaXYtPmNoYW5uZWxbMF0sIFJDKSwgdmFsKTsNCj4gKwkJYnJlYWs7
DQo+ICsJZGVmYXVsdDoNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+ICsJcmV0
dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBERUZJTkVfQ09VTlRFUl9BUlJBWV9DQVBUVVJF
KG1jaHBfdGNfY250X2NhcF9hcnJheSwgMyk7DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3QgY291bnRl
cl9jb21wIG1jaHBfdGNfY291bnRfZXh0W10gPSB7DQo+ICsJQ09VTlRFUl9DT01QX0FSUkFZX0NB
UFRVUkUobWNocF90Y19jb3VudF9jYXBfcmVhZCwgbWNocF90Y19jb3VudF9jYXBfd3JpdGUsDQo+
ICsJCQkJICAgbWNocF90Y19jbnRfY2FwX2FycmF5KSwNCj4gK307DQo+ICsNCj4gICBzdGF0aWMg
c3RydWN0IGNvdW50ZXJfY291bnQgbWNocF90Y19jb3VudHNbXSA9IHsNCj4gICAJew0KPiAgIAkJ
LmlkID0gMCwNCj4gQEAgLTI2MSw2ICszMTcsOCBAQCBzdGF0aWMgc3RydWN0IGNvdW50ZXJfY291
bnQgbWNocF90Y19jb3VudHNbXSA9IHsNCj4gICAJCS5udW1fZnVuY3Rpb25zID0gQVJSQVlfU0la
RShtY2hwX3RjX2NvdW50X2Z1bmN0aW9ucyksDQo+ICAgCQkuc3luYXBzZXMgPSBtY2hwX3RjX2Nv
dW50X3N5bmFwc2VzLA0KPiAgIAkJLm51bV9zeW5hcHNlcyA9IEFSUkFZX1NJWkUobWNocF90Y19j
b3VudF9zeW5hcHNlcyksDQo+ICsJCS5leHQgPSBtY2hwX3RjX2NvdW50X2V4dCwNCj4gKwkJLm51
bV9leHQgPSBBUlJBWV9TSVpFKG1jaHBfdGNfY291bnRfZXh0KSwNCj4gICAJfSwNCj4gICB9Ow0K
PiAgIA0KDQoNCi0tIA0KV2l0aCBCZXN0IFJlZ2FyZHMsDQpEaGFybWEgQi4NCg==

