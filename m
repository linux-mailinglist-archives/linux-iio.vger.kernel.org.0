Return-Path: <linux-iio+bounces-22613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E13CB22195
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 10:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DA4188A5C8
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060742E11A5;
	Tue, 12 Aug 2025 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TYoqUCRE"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D022D2E2826
	for <linux-iio@vger.kernel.org>; Tue, 12 Aug 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987861; cv=fail; b=RpRQXh8s+HS0oPVJxMub7TQsLvj7gzW1KnhqG/5LaQBPYrdsIrQrIM56mxR7JHUBojJynf2VheSbeLRJwqjjZ6nSH15f/0gB5LzszNfohdIVv0AHUjfZRfTeN6HjI+HuYJllE55Ah/cNlCkfRVFo2Cwj8pUgCV/4Bot1AFfC/C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987861; c=relaxed/simple;
	bh=k2jBIJZynT7l2fTIgyUidcZgBsNliPzHXFU8UjRVJhg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DckArqrSDBNCMx8tHXFAIGQ2INZiS9l4LAJd154e0ris40f6yhJTCWx0THGV0VZmkW4eJjDt6/JR2zmZ+5/W+8s5ATPSFMU7JOCT3ALWNscIdRIE0a+TV8bsqA3YjZJO2oOmzHKRTGUV3DnQXW8TkiE9mUZkKUQS9hPNISdvV40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TYoqUCRE; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfHYomGmCMGw5uoM6LemYuzW9P2L4zxIQlvi7saSSmcz2ex/3lkBBCBEozgDPVD2bkOEeQXoXge/dy1YTprQY9b8nccCS+iwaQtFnTaisjGg8XB9jKEOrBbr/atdWEcyVdettG3M4RQIoFAOUt9bBy72dKnjYhjleOBUP7PSqerv57QCtYq1EcVZ5yCIuC0v1z1KToBA7qPGcc2IFlufsk0sqniRKAxuPYoe4PDbT7wIeI9gXmzr1ap1HFRIf9uDtZcCNyA+Wav/DTGNl3fVh8QznhpZwpC6T8IL0IOjo00NPtx+d1ootlxPChaM87lcxlxGLOBuxUO5/ouzKNrf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2jBIJZynT7l2fTIgyUidcZgBsNliPzHXFU8UjRVJhg=;
 b=pRhK8EeyRs2xzpqdCJsAt+HCdzmYCiB+ff8cBC7z5ddFcRFytTnCI16aAZ/GlZQkKi7aZOGgUJfjMRWnAz23hx/eQ1RWvSEWTNoaRlVgoDMhwPDks4+4KLfbz4HXGfBkxUiq42qU2Vska0QFpA8x145RVT+oTCf91vtfrtoONMGs06t3CU29KWg9TgmhgQeE1tt5qSk8NOTfQ3tJRZhfN2vqxmXkfVGNQInibo05eUr0+Sr65c3HGqtftrCxc0iSFaoV5EHT+lPdXtGM6eIZ65JKBstUNxod29hSkaIMB+eEtALEX5fRIscNf6IDVSBc4CJYeArmvnzspcGg944Ivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2jBIJZynT7l2fTIgyUidcZgBsNliPzHXFU8UjRVJhg=;
 b=TYoqUCRE2xxXYIOBzK5zAHFDvXP5Agxt7yZbK0cGrvwbGCeIpxce0KSYehlEgPfy9mtGHYEMjHhm931dKqGrW5mqGm1AgmJXVhc6n/2qUdp+X2Zzi5w+/KwgS5jqke5MQkkhTyfbgkliI/Wm3UMdLAxVZOvXQhkUI2ReiOFIUTRp46HMPxmGGbZffv7LBojWmMz57zhzkkrOYg7kK3McNaHZXwCBlKVNyv8kG25BK+Cr+p4wNxawJyXID8waMKnjEeUhhKI6OB/OJA3jESIuMYfvfKgm0IU3gxt9WtJmS9n+m6YrnuGkXp2ekwv+FDIlIv46MiXN+lKGWX7P0e+awQ==
Received: from PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 08:36:54 +0000
Received: from PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::39d2:ae29:6e3f:1b6a]) by PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::39d2:ae29:6e3f:1b6a%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 08:36:54 +0000
From: <Marius.Cristea@microchip.com>
To: <aleksandar.gerasimovski@belden.com>, <rene.straub@belden.com>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio/adc/pac1934: fix channel disable configuration
Thread-Topic: [PATCH] iio/adc/pac1934: fix channel disable configuration
Thread-Index: AQHcCsElso5ZT4py/kmcgp18+uDZ8rResv4A
Date: Tue, 12 Aug 2025 08:36:54 +0000
Message-ID: <316dbe51678760e8af0a9f5f101f74e01de9ebd0.camel@microchip.com>
References: <20250811130904.2481790-1-aleksandar.gerasimovski@belden.com>
In-Reply-To: <20250811130904.2481790-1-aleksandar.gerasimovski@belden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6005:EE_|CY8PR11MB7393:EE_
x-ms-office365-filtering-correlation-id: 5a5f2a38-ba0e-4269-6a32-08ddd97b6493
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2NvM3FoN3JvMWp5VW1jdUhyQVlJa2tyNGhER2JTZVN5MHhFSW82K1k2NHAz?=
 =?utf-8?B?aU1SL2JmaFM5ZER4d0RqeWFOVU1BMFVkb2dqYzZXdW5uVGlwR3d0NGVEdy9C?=
 =?utf-8?B?clFuY2JQa1NFUzVYWkdBOHk2NlhyT2VmV2pqdC8xcEw3VXRQTTRLczNWYlg0?=
 =?utf-8?B?VXp4RlBacHFkVyt1c1plT1Q0NHFIZTlSOFpNby9UNGNNTC85TnNHTGlzV3Jh?=
 =?utf-8?B?T0xYT0xwUUF0Q1ZFZjRydE5WUGlUVE1SN3IrRWtnb2pIMllJWGNiL1UxV0kv?=
 =?utf-8?B?TEJnVW9DRTI3RGMvaE11WWxBVWtkTzFGTGxKZ2Fkc1MvVkZPY2diaHZrTDZ6?=
 =?utf-8?B?V2t2Y0VLbG5YWFUwSEJ6TTR0blJXK0IwZy9ydXVGUFl2eVN2SEpSdmt1VkJ1?=
 =?utf-8?B?WmJGWW5pUDRGOWxpM2NVRGVnUzFHNmlyYnRlRmNaTWhOTVgwbThGNjRZeVBF?=
 =?utf-8?B?NWRhV1JFdmpuNDVtMTVOOWJ5aDE0dWZvVk1FWjdacm5xSllKeHNhM3U1dzJ1?=
 =?utf-8?B?bjZNdTVtZVd6NElYVDJXY29CUHptYS9hdUtLMVVoRm9mME5nWkZxQ2tWVERE?=
 =?utf-8?B?RnRGT3pZRkZFSlA5dFBWcWllYjhNMS8wVXo3RExkUmt4ZDFnRnRMZFpLamx4?=
 =?utf-8?B?ZFZRZEwyZVNVL3d6aVBXd290YlhQMzVhdG0xVzdxZ3pHSHpuclRyZDdFZE1J?=
 =?utf-8?B?TXBHejlVQWxGb1BHd1R2S2VpdjBJTjhEWTh1QlphSlp5WFJONGZsMm5peVRm?=
 =?utf-8?B?cWQzSlV4KzZSWFVZTUdxdEl2bTVSMHhSSWtQd1RXaXVpMXZTZ1lKNWt6M1hT?=
 =?utf-8?B?SFVoOEVUalV0Tk9iODlZSjZlbmRBRjlOVStJc1dkWFljMUtobEx1azBGUlQ5?=
 =?utf-8?B?Y014bXFZQ3RoVkRQeklCSjhkZWg1TFdTUE5DNlREc2JsQ0hXelAvVkZ6Rm9a?=
 =?utf-8?B?ZTJEYjRySloza1pSU2VnNk9nTXZPMHlXTnpydG5uK21CUzFVZjd6Z2lMQWFk?=
 =?utf-8?B?N1RaVEVxUi9qSHlENFJRVDNuVlY5YVBOOC9VQllVUmhsQkRNaStlUG5DbGlE?=
 =?utf-8?B?eDVSYnRINFFsanZla0cwQm9WZnNmc3lLRVhSNVVxZDZpTHpVMFZ1QjAyMnpB?=
 =?utf-8?B?MldidXRUQ2xXWjlwR1o4aHVmcDNiZ1hpblJBT1ZxcVVpVWVia0RCRUhybFh0?=
 =?utf-8?B?QTg0enFOUEdDQjdVMHFPcm5MNnFJODFhMWpRbWxNNGF5Sk9zSTh5ZksvRG1a?=
 =?utf-8?B?UzE3V0wxOWVOaUQ1TWQ0NU8rbkdCS1Q1cG1ya0dQckhsbng3aE5FN3FwQlhV?=
 =?utf-8?B?ZDNLT0tadXhSNnhYWGJiMEtsSVJ0NDBKTEVsVnlmRGk3dmpjUFcwRHBRMmVW?=
 =?utf-8?B?cHpMVGpnYWhJZEhYYTdBV2txblE3b056KzlDSUlsWVFNcml4a2I2OFl4YmVX?=
 =?utf-8?B?d3U5VE55dU9ubXpzV1FKWWdOSllreVA0Vk1EWWV0R0lUTVNTU2Z5THBHUFRG?=
 =?utf-8?B?TEc3eGN5N3NtVUVRbTlxcDhYMFhrSDRBV0QyMW44aUtGeFB2bFpsTk5vRFQr?=
 =?utf-8?B?UmtJSjVhUXo2M0o4OU9ZQ09pSHF3SlA4MTZqL3c0dkU5YWsxNUxBQk56UDVN?=
 =?utf-8?B?dVJPdER6NlloOTAyZHd1d3FxTUdHbWRmYlR6UU5qYzlScEE2U0w1KzB5YVlr?=
 =?utf-8?B?V1RNd3FVSEllZjVOZXZSOXV1YWJNVkJZckh6WEdhZUNDVnY0L1JSNGhlcXpk?=
 =?utf-8?B?OEs0b3RIODU0Uis3ZkRzYU4zRWhqc1RMZ1dVUWZWRHV0SGUxUE9EMldOUHBa?=
 =?utf-8?B?WnR3MWpaSG9YcGdjRVB1c0ROVVZvdjNYd3lNTzdsOUdiWk0rbUxTOXozaTF2?=
 =?utf-8?B?K2JiYU04TFFwZWZaVExIMlhjVCtmTkFHeU1mU1Y5eHY2WGFKaVdmSTl1QVJp?=
 =?utf-8?B?WjlNdmgrSnhUaE56bzZsS001T21SSXRhWkVrSCthN25KQzhpbkFBaEMvbEt6?=
 =?utf-8?B?TnVweVJUQ25BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eE5Jang2bGxTYzlwN1NTMnpJbm82Ky82VDhjcmtTUDhxd0JJajNPV1pBYUwx?=
 =?utf-8?B?ZGNjSlNlaGZUd1pRNDYrWmY5NzlkS2dNSUJUUWJtUnZuVFo3V2dqSEFJcjNK?=
 =?utf-8?B?cXkzQkl5QlU1UmRMKzRUMnhuS2lDRlFaUWdsZ2o0Vnh4SGloby9jNk9sL1VP?=
 =?utf-8?B?SjRPdWQ2aGlGaW9DWGhGRFlWWGl6WnlUVG4zZzBqb3A3R3ZZRnZhRnkrcjd5?=
 =?utf-8?B?eTVwaDdoQ1JPRWh3VFBxWHBZcXpwbW9JbEk4aDdyL1lGRnVBN0pVOHRBblVH?=
 =?utf-8?B?Umd3MTNOVVZEU25JSUFIOXNXenN1TFRzK1drek13ZlIxb3Q2U0hvMkUvcmFH?=
 =?utf-8?B?cFZGdXU5SzU2K0EyRStuenVxWWJET2hNZGNUM1BMek9TSmdaZVZ6UWxhWGNL?=
 =?utf-8?B?VzUrcG8yV3lEcEpOMlo2MUMweERqb3NoeHN5WG5DZGdYanZpTFZQZUpjY1ZS?=
 =?utf-8?B?WVVLQStUUzI2cG81aFd3Qnh1NGJTckJiZ3pmNzBVeEhOUVFvOTNKRDZGcVo1?=
 =?utf-8?B?d3VPRDZkVUs0eGdJeFRpOElsNkdTSERKK1RJc3dBcGVjSU52UTVtNlBCaHZD?=
 =?utf-8?B?ZG5CeWdWQUhaQ1pHN2dFd2s3UmdSajlRYXBXUlFVMnBtcWYwTlZwQ3c2K3dP?=
 =?utf-8?B?bTg2UjdlMEttdXkyWFhXMHpMOW5SeHF5N3VsRnRocTh0Z0MveWU1a1E0S3N5?=
 =?utf-8?B?WlQvWXl1VGZjVDZwUGRUVEpMRG1URWdkSFpWSjZWTy80bjNkOUk5SCtJYk4r?=
 =?utf-8?B?aFBzL1FvdUg3Y1pJamM3SFlsb1JUWXhyWEpZUkRMeVduVG13bzFmZzNYVEUv?=
 =?utf-8?B?OEFVa0VkeXIvclNEWnJ5eGxOenRrZFJnVmdWcnIxWmM3NzhwdmM1eklubXVV?=
 =?utf-8?B?SysvQ1FoZ2NXaWJRcEx0QmFQMmxORWxyNXFxNXY2VFdvUWhINXFIc0VsMVFB?=
 =?utf-8?B?T3R5OFNjdktjREsrZG9mYUpnY3lHOUpld2R5UVJweWRUalRoMjNlR0QrYlcw?=
 =?utf-8?B?VzdmSWRwTDFJMW9YNU95eEVyaXQxdWRIS2pYelBUSjVqRVRUcmViVHFpZWY5?=
 =?utf-8?B?V1BTekdSRlVseG8vekxXU3VTVTcvcUxQaExjaGNLUDEyanArdlc4Q3MyeEgx?=
 =?utf-8?B?RXg2WmJUL29pZkthbnNIR1Q3L0dmbXRTaWt1KzdqWStqWDdlWnVNUlBWUFdt?=
 =?utf-8?B?dXMzck9Nblp2ZGMraFdEYnY2RGZMdjJ0K0FFTE1raDlzL1ZNL011WjQ4T3FC?=
 =?utf-8?B?aVh0MGEwNlhLd2xTdFBSakt0aDFXcmE5SEtEMkJxVGgwcjVOaEZsN1BqOE04?=
 =?utf-8?B?SnpBZ0JNVUFFWUJYWHFIVElKSnhFNGtsSVNkNjFOVTg0QkMyamlMSU8zQWR1?=
 =?utf-8?B?OVBqZjVnd0E1S2xtSFQ3bUpRckZrNXpmc2VNRHY1bGtOUzY1S1Y4Zmw1SDBS?=
 =?utf-8?B?U0M0MzZieFJ0aVZmZHdEWjJoZU12WmZVQ1FST2dvMlFqOEY5M0toZ2R1dVU0?=
 =?utf-8?B?T3NpbDVaWitoZXVGYTRMc2xMcVlyQStvUnJ5ZVI5U3RBTWFUdWhoZCtIcWdr?=
 =?utf-8?B?R1lPalRKQ01ieThKbXdVOG8ySUVtTk50ZnY3M3g0RXBzSFE0ZUwreEhrR2M1?=
 =?utf-8?B?Z2pZK1VNdmhrYm1sN3hrem1nQVlwN0Ezb1lJa0lDRUE3SVViSnVabUN0ck5t?=
 =?utf-8?B?RTdpcHJjTHpaaHJtWnpWbHZVRlMvZFg1VDl0Sk5EWC9lTTNoaW1saU51bmNi?=
 =?utf-8?B?ZkZ6MCtWeFAzSDdydFJJMzFKZGRReUt6Q2FiWk90Y2lFYmtDZUZqUGRYSE1V?=
 =?utf-8?B?WXRxOExXNDNVWnVMMFZ2ckVDL0ZQUXBEdVlOeW1Qc0xQS2xEQVMzTENMdjRV?=
 =?utf-8?B?SUt5WHBHV0wvUWtLeDcvUStnbWJqMGQ3ZU9sbmZGR0FTMXU2NzZhaEx6b1hE?=
 =?utf-8?B?WS9ab0t4OTZvUFo1MGdTVnZQM2diakN2ZkRoc0tOWldCUlhSV2QvNHUvMmhH?=
 =?utf-8?B?NUxYUlB0UDd6Qys1Y3ZlN3FzNUJwZXMvQWlsMGZMMGdYdmV5Tlk1VmQzMHpz?=
 =?utf-8?B?Q2lBWXk3WTZzdnJtRngyWlNJbDd5L2RrTGlZYXluNWQ1MndxWTE3UUFUT01D?=
 =?utf-8?B?R25FVFZLV0xac3NPUS9Qc1B3eU9pZGVYZXJCSmdjdzNTSFhONUNNZnhFSnZL?=
 =?utf-8?Q?P4BNHcBbBlZt4ph25AiHHO0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD70EE914DBB764F8DA472DDD9A3D77E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5f2a38-ba0e-4269-6a32-08ddd97b6493
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 08:36:54.8001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgdkoBpSP5n8UMI7ocaNViqEYLq2wtm/o8aUfwoOc3m0VuaBOjnkSQQr9qxC8JvokDyR5Wz4fT8+F1Gcr7th7GAcHBWTvU+dM/txX9pU40A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393

SGksCgogICBUaGFuayB5b3UgZm9yIGZpbmRpbmcgYW5kIGZpeGluZyB0aGUgYnVnLgoKCgpSZXZp
ZXdlZC1ieTogTWFyaXVzIENyaXN0ZWEgPG1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5jb20+CgoK
CgoKT24gTW9uLCAyMDI1LTA4LTExIGF0IDEzOjA5ICswMDAwLCBBbGVrc2FuZGFyIEdlcmFzaW1v
dnNraSB3cm90ZToKPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+IAo+IFRo
ZXJlIGFyZSB0d28gcHJvYmxlbXMgd2l0aCB0aGUgY2hpcCBjb25maWd1cmF0aW9uIGluIHRoaXMg
ZHJpdmVyOgo+IC0gRmlyc3QsIGlzIHRoYXQgd3JpdGluZyAxMiBieXRlcyAoQVJSQVlfU0laRShy
ZWdzKSkgd291bGQgYW55aG93Cj4gwqAgbGVhZCB0byBhIGNvbmZpZyBvdmVyZmxvdyBkdWUgdG8g
SFcgYXV0byBpbmNyZW1lbnQgaW1wbGVtZW50YXRpb24KPiDCoCBpbiB0aGUgY2hpcC4KPiAtIFNl
Y29uZCwgdGhlIGkyY19zbWJ1c193cml0ZV9ibG9ja19kYXRhIHdyaXRlIGVuZHMgdXAgaW4gd3Jp
dGluZwo+IMKgIHVuZXhwZWN0ZWQgdmFsdWUgdG8gdGhlIGNoYW5uZWxfZGlzIHJlZ2lzdGVyLCB0
aGlzIGlzIGJlY2F1c2UKPiDCoCB0aGUgc21idXMgc2l6ZSB0aGF0IGlzIDB4MDMgaW4gdGhpcyBj
YXNlIGdldHMgd3JpdHRlbiB0byB0aGUKPiDCoCByZWdpc3Rlci4gVGhlIFBBQzE5MzEvMi8zLzQg
ZGF0YSBzaGVldCBkb2VzIG5vdCByZWFsbHkgc3BlY2lmeQo+IMKgIHRoYXQgYmxvY2sgd3JpdGUg
aXMgaW5kZWVkIHN1cHBvcnRlZC4KPiAKPiBUaGlzIHByb2JsZW0gaXMgcHJvYmFibHkgbm90IHZp
c2libGUgb24gUEFDMTkzNCB2ZXJzaW9uIHdoZXJlIGFsbAo+IGNoYW5uZWxzIGFyZSB1c2VkIGFz
IHRoZSBjaGlwIGlzIHByb3Blcmx5IGNvbmZpZ3VyZWQgYnkgbHVjaywKPiBidXQgaW4gb3VyIGNh
c2Ugd2hlbnVzaW5nIFBBQzE5MzEgdGhpcyBsZWFkcyB0byBub25mdW5jdGlvbmFsIGRldmljZS4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBSZW5lIFN0cmF1YiA8cmVuZS5zdHJhdWJAYmVsZGVuLmNvbT4K
PiBTaWduZWQtb2ZmLWJ5OiBBbGVrc2FuZGFyIEdlcmFzaW1vdnNraQo+IDxhbGVrc2FuZGFyLmdl
cmFzaW1vdnNraUBiZWxkZW4uY29tPgo+IC0tLQo+IMKgZHJpdmVycy9paW8vYWRjL3BhYzE5MzQu
YyB8IDIwICsrKysrKysrKysrKysrKysrKy0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRj
L3BhYzE5MzQuYyBiL2RyaXZlcnMvaWlvL2FkYy9wYWMxOTM0LmMKPiBpbmRleCAwOWZlODhlYjNm
YjAuLjJlNDQyZTQ2ZjY3OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvcGFjMTkzNC5j
Cj4gKysrIGIvZHJpdmVycy9paW8vYWRjL3BhYzE5MzQuYwo+IEBAIC04OCw2ICs4OCw3IEBACj4g
wqAjZGVmaW5lIFBBQzE5MzRfVlBPV0VSXzNfQUREUsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgMHgxOQo+IMKgI2RlZmluZSBQQUMxOTM0X1ZQT1dFUl80X0FERFLCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MUEKPiDCoCNkZWZpbmUgUEFDMTkzNF9SRUZSRVNI
X1ZfUkVHX0FERFLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgxRgo+ICsjZGVmaW5lIFBBQzE5
MzRfU0xPV19SRUdfQUREUsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgyMAo+
IMKgI2RlZmluZSBQQUMxOTM0X0NUUkxfU1RBVF9SRUdTX0FERFLCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDB4MUMKPiDCoCNkZWZpbmUgUEFDMTkzNF9QSURfUkVHX0FERFLCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhGRAo+IMKgI2RlZmluZSBQQUMxOTM0X01JRF9SRUdfQURE
UsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweEZFCj4gQEAgLTEyNjUsOCAr
MTI2NiwyMyBAQCBzdGF0aWMgaW50IHBhYzE5MzRfY2hpcF9jb25maWd1cmUoc3RydWN0Cj4gcGFj
MTkzNF9jaGlwX2luZm8gKmluZm8pCj4gwqDCoMKgwqDCoMKgwqAgLyogbm8gU0xPVyB0cmlnZ2Vy
ZWQgUkVGUkVTSCwgY2xlYXIgUE9SICovCj4gwqDCoMKgwqDCoMKgwqAgcmVnc1tQQUMxOTM0X1NM
T1dfUkVHX09GRl0gPSAwOwo+IAo+IC3CoMKgwqDCoMKgwqAgcmV0ID3CoCBpMmNfc21idXNfd3Jp
dGVfYmxvY2tfZGF0YShjbGllbnQsCj4gUEFDMTkzNF9DVFJMX1NUQVRfUkVHU19BRERSLAo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBUlJBWV9TSVpFKHJlZ3MpLCAodTgKPiAqKXJlZ3MpOwo+
ICvCoMKgwqDCoMKgwqAgLyoKPiArwqDCoMKgwqDCoMKgwqAgKiBXcml0ZSB0aGUgdGhyZWUgYnl0
ZXMgc2VxdWVudGlhbGx5LCBhcyB0aGUgZGV2aWNlIGRvZXMgbm90Cj4gc3VwcG9ydAo+ICvCoMKg
wqDCoMKgwqDCoCAqIGJsb2NrIHdyaXRlLgo+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDC
oMKgwqAgcmV0ID0gaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0YShjbGllbnQsCj4gUEFDMTkzNF9D
VFJMX1NUQVRfUkVHU19BRERSLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gcmVnc1tQQUMxOTM0
X0NIQU5ORUxfRElTX1JFR19PRkZdKTsKPiArwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPiArCj4gK8KgwqDCoMKgwqDCoCBy
ZXQgPSBpMmNfc21idXNfd3JpdGVfYnl0ZV9kYXRhKGNsaWVudCwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBQQUMxOTM0X0NUUkxfU1RBVF9SRUdTX0FERFIgKwo+IFBBQzE5MzRfTkVHX1BXUl9SRUdf
T0ZGLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gcmVnc1tQQUMxOTM0X05FR19QV1JfUkVHX09G
Rl0pOwo+ICvCoMKgwqDCoMKgwqAgaWYgKHJldCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gcmV0Owo+ICsKPiArwqDCoMKgwqDCoMKgIHJldCA9IGkyY19zbWJ1c193cml0
ZV9ieXRlX2RhdGEoY2xpZW50LAo+IFBBQzE5MzRfU0xPV19SRUdfQUREUiwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZWdzW1BBQzE5MzRfU0xPV19SRUdfT0ZGXSk7Cj4gwqDCoMKgwqDCoMKgwqAg
aWYgKHJldCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPiAK
PiAtLQo+IDIuMzQuMQo+IAo+IAo+ICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgo+ICoKPiBESVNDTEFJTUVSOgo+IFBy
aXZpbGVnZWQgYW5kL29yIENvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBtYXkgYmUgY29udGFpbmVk
IGluIHRoaXMKPiBtZXNzYWdlLiBJZiB5b3UgYXJlIG5vdCB0aGUgYWRkcmVzc2VlIG9mIHRoaXMg
bWVzc2FnZSwgeW91IG1heSBub3QKPiBjb3B5LCB1c2Ugb3IgZGVsaXZlciB0aGlzIG1lc3NhZ2Ug
dG8gYW55b25lLiBJbiBzdWNoIGV2ZW50LCB5b3UKPiBzaG91bGQgZGVzdHJveSB0aGUgbWVzc2Fn
ZSBhbmQga2luZGx5IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5IGUtCj4gbWFpbC4gSXQgaXMg
dW5kZXJzdG9vZCB0aGF0IG9waW5pb25zIG9yIGNvbmNsdXNpb25zIHRoYXQgZG8gbm90Cj4gcmVs
YXRlIHRvIHRoZSBvZmZpY2lhbCBidXNpbmVzcyBvZiB0aGUgY29tcGFueSBhcmUgbmVpdGhlciBn
aXZlbiBub3IKPiBlbmRvcnNlZCBieSB0aGUgY29tcGFueS4gVGhhbmsgWW91Lgo=

