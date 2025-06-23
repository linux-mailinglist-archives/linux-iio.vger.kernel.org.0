Return-Path: <linux-iio+bounces-20912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95199AE41A3
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 15:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CC016958D
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DF724DD1F;
	Mon, 23 Jun 2025 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="or8tcm2H"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F591F1522;
	Mon, 23 Jun 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684079; cv=fail; b=J2u/1E4k9Xpcv5BiEEcHB8UEYaxMl7MaMolLyfpysyQ3U7iyjnrG0m4jlodbt2h0E4m7Gi2TjEu/AJNy3d2AEgs0e6EaPPbl3c4MiHv+wMLt4Lvj//ODKeMmZQgkpK931HdmtMLRcgz8SI30UUmB8ienNcyeoKLIpE+zZCCyEwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684079; c=relaxed/simple;
	bh=LgtSLJdOllkhzLKjFz0MGTBAkZtKaV4LZIQohT2iae4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eVTJ/j/9Yp7hK6EVfyxYQp1TBIZBwfw3B6/i+LMWK1cb02B7f3Zw5MfsIy+UgFeQ0b9Jii+4/31BLb/Mh7NTriKa9Th95s7ut5fDjIpvUuknFPEPrUGw1CIyQ2xu5t4Cq8F7iZA1ypwNHVk37v0ZU5p8U54/iOo9E4Qa+61AA+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=or8tcm2H; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWNFh301fW1QaazYnCTLVoTQVB02TLpi6UR5hyPIvVcJrp7wRr9aKEsuTtoMKaa/z6Mr1yJFKJd9nB0hv/ippRe1gv+w1BGXdPZU2+/vizO1CCSymrO9tfLLVD5NOIbOhNg+pGiOV+hjkKHRCXmtVISfu7DYKPd3Bl5XojffsWFUkQtiK3HSm5XkCgXk/dpZuBbpYGDmQX2RlllojbmDxyOLsbneMqKsiYprIsI9XrGcviazzo8KdgtH8Dn24/YBLDffNJmxcLJq0ILRNmzevcs+7ZsNIxIfxgpKozfrHIhAxdkXs1Ch2I8RdTtMb3/W3AIAljQ0gBVY/wwRcEZAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgtSLJdOllkhzLKjFz0MGTBAkZtKaV4LZIQohT2iae4=;
 b=MQ7E3ij1/FEixBKK1Im2I8/uHjVSXr2HKLusxszIRP0MA0j1XxQ/aLuFAonVFCPlOJNckjJ+VxDg3RCgnbem2NjltC3z4zSb6DiIwFE6FrRowa38/suEXIONNfpFipPbSzKO0dkMC0pka+67SV6cKtaKB4bpkIRdcd+G8HLFZpGk1AkBaIVIw6DV2GqALR1Y5fpNbReO+fTXc3yN80S4PzTRyeDKDeDgOnRiR6MkMNWxwr3aGd0kGh/Kxdy6HosvnqksBe+bD4Fudb8YBEHkrSAR4/zcXnVPCrD9qG/Y0mrTT+NH3PcVyiwp2x+sd+dpbbu8FTN3GGdek5rTaAN82A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgtSLJdOllkhzLKjFz0MGTBAkZtKaV4LZIQohT2iae4=;
 b=or8tcm2H18lpA8f7Thamaj0texg2cY5MPAa3AqxtfQfYTvt9JGE1UpdP+ogboDAjwRD0milMF3cesiz56BkvhxpCXFQ4US1zDc35jeSJuf97hK29cX/NilNRsP7absYv95JEKIrSSyJq9MWSp+ks5qy/w5cpFy63/5hD+hs6q7tEpfwiHj2tcna/tFD6YRLbhTh2AdJT5h7aPc9ACorS1+QcOkv/Rd6H8GmtysUWLG6uCmJPHia72gJhp/2QOuuv+GrH2MNVjdOatUImV7QAcWrXbXS19E/kQclo8FfekU3LvxeIGQTIMpksdRdXM8ANzom+vnh0dq8ojGiAPLw6zg==
Received: from SN6PR11MB2702.namprd11.prod.outlook.com (2603:10b6:805:60::15)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 13:07:54 +0000
Received: from SN6PR11MB2702.namprd11.prod.outlook.com
 ([fe80::bd80:c5bb:d983:16a9]) by SN6PR11MB2702.namprd11.prod.outlook.com
 ([fe80::bd80:c5bb:d983:16a9%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 13:07:54 +0000
From: <Victor.Duicu@microchip.com>
To: <conor@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<jic23@kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <Marius.Cristea@microchip.com>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Thread-Topic: [PATCH v3 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Thread-Index: AQHb3GNteAYgfxyO/0qXLktRvBtYqLQBKWaAgA+degA=
Date: Mon, 23 Jun 2025 13:07:53 +0000
Message-ID: <8c80baf4616dbec339f3108690046e1dc43e24ae.camel@microchip.com>
References: <20250613130207.8560-1-victor.duicu@microchip.com>
	 <20250613130207.8560-2-victor.duicu@microchip.com>
	 <20250613-undergo-reviving-a97dca8f3b69@spud>
In-Reply-To: <20250613-undergo-reviving-a97dca8f3b69@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB2702:EE_|PH7PR11MB7720:EE_
x-ms-office365-filtering-correlation-id: 4812ae20-49b6-4ee9-0989-08ddb256f732
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eVJDS2JlNGVrRGlNc29yYXdtVElNaU9DWjI4VURDVEIwd2ZIVWIrbUFZWUZk?=
 =?utf-8?B?ekZsWWtWQ2lZdTNXS0RIZHRNMTFwSStPUDNiM09aaXVKaytHZTg5UTYvdUVh?=
 =?utf-8?B?NE42OUl6NTVyMUpvMzJRbFZhb2hFTTg5bVd2b0FQT1JRMDUvMzR0a2JsQTdJ?=
 =?utf-8?B?c2ZscXpWNWFxTUl0SWtDbTlsa2RCaTB1Q21LYWh5K3NyV3FGQmthOERhdWtl?=
 =?utf-8?B?T1pYNE5VOGRFeEZqbkR0N3ZpclJRZ2s0MEIwWisraFZ0L1JvUmlRTVN3ODVL?=
 =?utf-8?B?allveFBrMmVJZFZvcWV1Z0ZOUzlSMm5YM1pRa1ZIcjVITjZFZWF6L2JSM3lS?=
 =?utf-8?B?OW1HU3Y1NTJJVnRTTjh6aGJEU1NGdUhlNDBENkJycVRCS3FmQldtbTdFNnlO?=
 =?utf-8?B?eXBmeG11NCt3VXhmRWZiUVllc2tzZ3lwL1ozSUVHVzZYaWxFeFNjZjRTenJJ?=
 =?utf-8?B?ZE9NWlNYUS82S1pyU1diM2U5blBycjVaQ1pOeXVUdEpuaitOTnVaWmpQY2tt?=
 =?utf-8?B?T0NIQUVqbHlUeGY2cUJlRXVKKzNuTTFScUx2MGZDMG5pdmFIcUppamZvVWRK?=
 =?utf-8?B?ZzNSNUpRdjVkTXdXS25CcFRaRWpEL25MZm1BL01CblpZdjlVaVptNkR1MVJ5?=
 =?utf-8?B?U1UzZHFvSGF6cTgvcnVDemh4ODdJTnE0Mm9SbTM3R3dVM2gxWTFFaXhVZHZQ?=
 =?utf-8?B?ZjlzaGxBc0YvV2tQcnBWTTJiRFZDamYwRGRtQlY4bTFGd09xWjBFWUtpdFhE?=
 =?utf-8?B?NTkrSEN3c1hxWkJpWkpSbHJnOVh0Znd3NzBpS1FxVm5DdHVSWUhDdEM2M1do?=
 =?utf-8?B?ZXRobGMxTWRndGlnWXdMcmpSSWJmZUI1T25LK2dVeTJRR0dPT1ZPL0h1TmJo?=
 =?utf-8?B?SnF1TFdPOVJ1N3htUk9NbTVtUUhYcHlLWWlLMUdHYmRkVThUd1VkMGg3QTkw?=
 =?utf-8?B?bllnTVpSRlFQOWYxVmJaeldQUFRWQ1hnZkE4dThSMlZrQ1Y0UTU2QTEyczRz?=
 =?utf-8?B?Um5qV1ZOT1FqZnJYZ0x0Mjh5R21xczhHeHhCeVFoYWZYNSswcGhrZE1MOVVT?=
 =?utf-8?B?NC85eWlWT1BnUmJmRENPWjl6UDZxbExqUmkxN0JxV0Nzc2pybEc0TXFJcC9G?=
 =?utf-8?B?end4eWtuRlBWOXFsck5CcS9EOHQzSVhZWSsyeVVpSHgvT3ZQb3Z6dGEwTDgy?=
 =?utf-8?B?WHE1UDA1NmpFdThIOHMwSytjVzNuNzFZT3pSdGVOWDV2dE9YMURpbmJKR2hz?=
 =?utf-8?B?OWVVSmhKVENHN0NqWEY5SmhMQkpEYzRyLy9HVm56N0R0cGo5My9CRytXdWxR?=
 =?utf-8?B?aW9PLytkOU85N2pWeFVuVUhRT0NXREFWYzY0eVVtRkFDNHFyN0JhQUN4L2di?=
 =?utf-8?B?UTViempzWGhKdW1iWHlvZGx6ZXoxd1BLTHFUbnAzR01qU2FkRDlaSjRjalJm?=
 =?utf-8?B?QzRoeGdUTllXMitaNFl4VjYzd2REU2pFb1NOYjhhWC80cncySlhpQkx6bXR1?=
 =?utf-8?B?QXVzbC9zUDVjNXRIOW9FdzlDbTJ2dm41a0pQbmdRVUVSNk1jQkcwVDRPcmpC?=
 =?utf-8?B?TGh1VzhQZmo4MGh6REd5ZElGWEtRc2hWY0s0R3dPUzh6QlpSM0FaaEpMZ2h4?=
 =?utf-8?B?aGpUSmFCcDNrbGoxQ01vbDNEK3BEYzUwbU4yTmt0cEphdXBOS3dnYWtzS2xC?=
 =?utf-8?B?eTUvRWkrSkNxVG5VbmkwUTNOUmVlQU5VUTlHVWh5SDJza2V1bGQ4b21TajMy?=
 =?utf-8?B?SllabzR5a3FiaEFZOXRtUTdjVUF2YWwyZXh5SmN3SisyMDFablVSSTY4aVJE?=
 =?utf-8?B?M09tYXdjd0wvemtrT1JWQlBEVFlVU3FoR0NXTFFrMVhnTUlpY2V6RVkwb0NY?=
 =?utf-8?B?bWl0cC9icmtXQkwwUkZlU0tsN01JcEJXL21DOWNOTkdrd2RqTjVnS0JtK3pr?=
 =?utf-8?B?TEg4T0RtckRjL0pCeEdIR3JzQXBIMzJwTWw4T0tIb2VQT3lFZGl4K3J6VTF5?=
 =?utf-8?Q?8awglZnEF5n/PQLuLM1Cv/qJMOCdKY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVR6cjQwMXRqc2djM1IwYytsUDB4cUcvS1NVbkR2dlFJWU81T3hnS1JLUEdz?=
 =?utf-8?B?QzlUSHFlQVRzQktqVDE5K1JRQmhvdXNvSDIrOC8rdlJKRXVLL04vZWJDQUZQ?=
 =?utf-8?B?WlgyMDRIZm1adFN2RUZQZDFrcDRIZVBBbytMcllYTlY1MTluckxnaUEzWXEv?=
 =?utf-8?B?Q0xGWUs2OTllR1lxWjFvWGkzRmMxYmdRYWFSUStsWElJODM0SXJHUnFOc09Y?=
 =?utf-8?B?ckdoL0RXODR2aWhOL3dSUU5Zd3dVVVhkdW05cFRMVERJVnVxaFZhRDNKYm5X?=
 =?utf-8?B?Z0lhd1B3M0NBOXI5U21hQi84Y3ZyQXRWUnFQbGYzc2FKdVY3cUZGQjJNclk1?=
 =?utf-8?B?dnFYa3VnRjlHMXFHcStvL2sySm5sTVRMSHpYbnhZTFlQY042UDJyRURHK3k4?=
 =?utf-8?B?d2JkSUZEcnVqeGsyTGttNWlwM2ZYSXgzNG0xM3dGRUVQSHBpdUJoQ1ArN3dq?=
 =?utf-8?B?eml4WmpFbUI4dmxCY29RNW9CUTNBeDNjYzhITmsxVzVsZU9hRlFKTlBwYy9X?=
 =?utf-8?B?RWhTOW1UR1JRMVpMUkxJOTFWQkNONzNmTHk3M3Jtdmdic1kxSGNLbkgyRC8r?=
 =?utf-8?B?SGhrYWM4K0luSkdIY1dmWVltSjVuczRaTE9pMFFxeE8xeEFTbS9ZRWdrS005?=
 =?utf-8?B?dHZ2L2NEbG5Cek4yQ2dRWXgxWVZ4NkFBRVFJS0dFTGdMVEwyOGVLL0JHMy9z?=
 =?utf-8?B?c3kwemhVSTZ6TjRxTzMyQjFEc0ZwQTN0Nlcyd0xvNTk3dzYzMUVpUFFtcDZ4?=
 =?utf-8?B?aG9ldlRGaFFWczIrYi9wY1NHeUV1ZURORW0yNW82ZlV4eWdqZXp0RmducjZ6?=
 =?utf-8?B?Sk02enM5V3pUY1NHTENQZlZLdjk0V2pqOXladm9OSm9zQzJhN3l1Umd2a0d4?=
 =?utf-8?B?VlJUQVRyejl5STdqYjVZL29wZkZXNVNPcUw5STdWMmxvYUd2MmZxU08vWWhG?=
 =?utf-8?B?aStzaE9pOTBZNWpWdGF0WTE0L1pXVGNvYjhDK053QzdRVUtZQUg1MnJYSjR4?=
 =?utf-8?B?azRWNmI1OVlVSjN5R2I1eThIeHlMa0cycCtGTzlQUzQ4VnFXM2lIMWw5TTVn?=
 =?utf-8?B?T2xXYUdUMmVzUnRaaHI0YzFBOGJtdDZvZWw2MVZLRUI0UERxMk83UTJwVXVz?=
 =?utf-8?B?TzdzOGdEUVM4UGhzUHlUMXF1cVlxQ2R2cGxCNVFOeU83OThQcTViSmZERlhj?=
 =?utf-8?B?K3ZkaWJLblNMSVlsQ1ZuR1lNekZCZTJEb1ZhQzB0eFovRHFSbThUTVNlUDRp?=
 =?utf-8?B?d0dudlNyZEZmL1h6LzFidHRBQjVuOTBqVlBQZWhtKzVXa1BucWhnQS9sSlZB?=
 =?utf-8?B?aDIwdDlvMGZyaEZoRVZxalpxZmxCQ1FJQXhack1lMXpVZmpwVnhjY3NHbDVh?=
 =?utf-8?B?aXE2VlREOFNzTFZLWnRBYldKQUFHQ1lwT05IanJyNGEyY2JvenFHUmFPKzVK?=
 =?utf-8?B?emQ0REllcE1jY2RiNTNwQmYzU3JtbGQ0OWFXUitvTU9vNThVekQwbVVXNUUz?=
 =?utf-8?B?VUQ4WTVocmgvanhaMFNIV041a1RqNThyQkU2VFh3aEZNaW1DTGppSFJvU3h2?=
 =?utf-8?B?QXJhVFV0SU5tZXVQWXdubStqTkljQjlFNTNuaDNZOGZySThDYzd2R3RCNm5n?=
 =?utf-8?B?MWtac2o3WVdYdEMrUkpLdjNsZVp6V0l1MncyZjNsY0g3MzVOdTEwM3M5cldh?=
 =?utf-8?B?RjZGNmhjb0dKZnRiQWdaLy9IczlPVW91NUpsWXBLSnVKZmJrbWl1YjY5dmhp?=
 =?utf-8?B?ZmUwdXE0aitFRWNxVjk2RWtob1pXMG5CQ21OK3VZYW11Mnk4U0RUWDlBcDhI?=
 =?utf-8?B?RVhETm1BVnBvOU9iT1BCdjd6Y0RUWlRCdk1hQWllbmM2QjIwMWRydDF5bnl0?=
 =?utf-8?B?c3BGWll1UlhpT2RzZFhtY29TZWI1RHhMOVBEbS9US3BDY2VCc2VxM25zWXN6?=
 =?utf-8?B?R2VSTU1vb05DaHhJTlVwdHl0S1RKaHhzVlFaanVsMTF5b0lLY0s5OXlnMjRy?=
 =?utf-8?B?SHF4aFZrZEZrT0c4dW1pbGl0WkVZQUdTamgyeE1iV3JJZkVHZ05iZ1RaQ1Fh?=
 =?utf-8?B?WVExWkwwVENxbXNPTWFWTmw0S1lSY211SHhGcGhLaFhCR0JydmxGOEtDK005?=
 =?utf-8?B?Sk1hYjNkRnlmVE16bUtZZm5UekdsdTQyeHc3ODFNV0xOOHpWZVVXTjNneE9q?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06437192015A5441B0E4D1A652274557@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4812ae20-49b6-4ee9-0989-08ddb256f732
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 13:07:53.9848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUdaBpqyajIxx43pAs67QeRAFGKgRMma0gnxGjLnA9fc7I4djpKep3FdPA/53seAIjL++Zayo5QOoRi5zyk8MnAdP22yOJbfBIOFMNsNDNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720

T24gRnJpLCAyMDI1LTA2LTEzIGF0IDE1OjQwICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIEZyaSwgSnVuIDEzLCAyMDI1IGF0IDA0OjAyOjA2UE0gKzAzMDAsDQo+IHZpY3Rvci5kdWlj
dUBtaWNyb2NoaXAuY29twqB3cm90ZToNCj4gPiBGcm9tOiBWaWN0b3IgRHVpY3UgPHZpY3Rvci5k
dWljdUBtaWNyb2NoaXAuY29tPg0KPiA+IA0KDQpIaSBDb25vciwNCg0KPiA+IFRoaXMgaXMgdGhl
IGRldmljZXRyZWUgc2NoZW1hIGZvciBNaWNyb2NoaXAgTUNQOTk4WC8zMyBhbmQNCj4gPiBNQ1A5
OThYRC8zM0QgQXV0b21vdGl2ZSBUZW1wZXJhdHVyZSBNb25pdG9yIEZhbWlseS4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBWaWN0b3IgRHVpY3UgPHZpY3Rvci5kdWljdUBtaWNyb2NoaXAuY29t
Pg0KPiA+IC0tLQ0KPiA+IMKgLi4uL2lpby90ZW1wZXJhdHVyZS9taWNyb2NoaXAsbWNwOTk4Mi55
YW1swqDCoMKgIHwgMjExDQo+ID4gKysrKysrKysrKysrKysrKysrDQo+ID4gwqAxIGZpbGUgY2hh
bmdlZCwgMjExIGluc2VydGlvbnMoKykNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vdGVtcGVyYXR1cmUvbWljcm9jaGlw
LG1jcDk5ODINCj4gPiAueWFtbA0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vdGVtcGVyYXR1cmUvbWljcm9jaGlwLG1jcDk5
DQo+ID4gODIueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lp
by90ZW1wZXJhdHVyZS9taWNyb2NoaXAsbWNwOTkNCj4gPiA4Mi55YW1sDQo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmVjOTM5ZDQ2MzYxMg0KPiA+IC0t
LSAvZGV2L251bGwNCj4gPiArKysNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9paW8vdGVtcGVyYXR1cmUvbWljcm9jaGlwLG1jcDk5DQo+ID4gODIueWFtbA0KPiA+IEBA
IC0wLDAgKzEsMjExIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4w
IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiANCj4gPiArDQo+ID4gK8KgIG1pY3JvY2hpcCxyZXNpc3Rh
bmNlLWNvbXAtY2gxLTItZW5hYmxlOg0KPiA+ICvCoMKgwqAgZGVzY3JpcHRpb246DQo+ID4gK8Kg
wqDCoMKgwqAgRW5hYmxlIHJlc2lzdGFuY2UgZXJyb3IgY29ycmVjdGlvbihSRUMpIGZvciBleHRl
cm5hbA0KPiA+IGNoYW5uZWxzIDEgYW5kIDIuDQo+ID4gK8KgwqDCoMKgwqAgVGhlIGNoaXAgaW50
ZXJuYWwgaGFyZHdhcmUgY291bnRlcmJhbGFuY2VzIHRoZSBwYXJhc2l0aWMNCj4gPiByZXNpc3Rh
bmNlIGluDQo+ID4gK8KgwqDCoMKgwqAgc2VyaWVzIHdpdGggdGhlIGV4dGVybmFsIGRpb2Rlcy4g
VGhlIGNvbXBlbnNhdGlvbiBjYW4gYmUNCj4gPiBhY3RpdmF0ZWQgb3INCj4gPiArwqDCoMKgwqDC
oCBkaXNhYmxlZCBpbiBoYXJkd2FyZSBmb3IgYm90aCBjaGFubmVscyAxIGFuZCAyIGF0IHRoZSBz
YW1lDQo+ID4gdGltZS4NCj4gPiArwqDCoMKgIHR5cGU6IGJvb2xlYW4NCj4gDQo+IE9uIHRoZSBw
cmV2aW91cyB2ZXJzaW9uIEkgb2JqZWN0ZWQgdG8gdGhpcyB3b3JkaW5nIGZvciB0aGUgcHJvcGVy
dHksDQo+IHdoZXJlIGl0IGlzIGJlaW5nIHVzZWQgYXMgYW4gZW5hYmxlLCBhbmQgaW5zdGVhZCBz
YWlkIHRoYXQgaXQgc2hvdWxkDQo+IGluZGljYXRlIHRoZSBwcmVzZW5jZSBvZiB0aGUgcGFyYXNp
dGljIHJlc2lzdGFuY2UuIERpZCBJIG1pc3Mgc29tZQ0KPiBzb3J0DQo+IG9mIG5ldyBqdXN0aWZp
Y2F0aW9uIGZvciBpdCBzdGlsbCB0YWxraW5nIGFib3V0IGJlaW5nIGFuIGVuYWJsZT8NCj4gDQoN
Ck15IGFwb2xvZ2llcywgSSBmb3Jnb3QgdG8gbW9kaWZ5IHRoZSBuYW1lIG9mIHRoZSB2YXJpYWJs
ZS4NCkkgd2lsbCBjaGFuZ2UgdGhlIHZhcmlhYmxlcyB0byBzb21ldGhpbmcgbGlrZToNCg0KbWlj
cm9jaGlwLHBhcmFzaXRpYy1yZXMtb24tY2hhbm5lbDEtMjoNCmRlc2NyaXB0aW9uOg0KSW5kaWNh
dGVzIHRoYXQgdGhlIGNoaXAgYW5kIHRoZSBkaW9kZXMvdHJhbnNpc3RvcnMgYXJlIHN1ZmZpY2ll
bnRseSBmYXINCmFwYXJ0IHRoYXQgYSBwYXJhc2l0aWMgcmVzaXN0YW5jZSBpcyBhZGRlZCB0byB0
aGUgd2lyZXMsIHdoaWNoIGNhbg0KYWZmZWN0IHRoZSBtZWFzdXJlbWVudHMuIER1ZSB0byB0aGUg
YW50aS1wYXJhbGxlbCBkaW9kZSBjb25uZWN0aW9ucywNCmNoYW5uZWxzIDEgYW5kIDIgYXJlIGFm
ZmVjdGVkIHRvZ2V0aGVyLg0KDQo+IA0KPiA+ICvCoCBtaWNyb2NoaXAscmVzaXN0YW5jZS1jb21w
LWNoMy00LWVuYWJsZToNCj4gPiArwqDCoMKgIGRlc2NyaXB0aW9uOg0KPiA+ICvCoMKgwqDCoMKg
IEVuYWJsZSByZXNpc3RhbmNlIGVycm9yIGNvcnJlY3Rpb24oUkVDKSBmb3IgZXh0ZXJuYWwNCj4g
PiBjaGFubmVscyAzIGFuZCA0Lg0KPiA+ICvCoMKgwqDCoMKgIFRoZSBjaGlwIGludGVybmFsIGhh
cmR3YXJlIGNvdW50ZXJiYWxhbmNlcyB0aGUgcGFyYXNpdGljDQo+ID4gcmVzaXN0YW5jZSBpbg0K
PiA+ICvCoMKgwqDCoMKgIHNlcmllcyB3aXRoIHRoZSBleHRlcm5hbCBkaW9kZXMuIFRoZSBjb21w
ZW5zYXRpb24gY2FuIGJlDQo+ID4gYWN0aXZhdGVkIG9yDQo+ID4gK8KgwqDCoMKgwqAgZGlzYWJs
ZWQgaW4gaGFyZHdhcmUgZm9yIGJvdGggY2hhbm5lbHMgMyBhbmQgNCBhdCB0aGUgc2FtZQ0KPiA+
IHRpbWUuDQo+ID4gK8KgwqDCoCB0eXBlOiBib29sZWFuDQo+IA0KV2l0aCBLaW5kIFJlZ2FyZHMs
DQpWaWN0b3IgRHVpY3UNCg0KPiBDaGVlcnMsDQo+IENvbm9yLg0K

