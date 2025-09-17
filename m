Return-Path: <linux-iio+bounces-24213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D039B7F652
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 15:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE2F4A7105
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 13:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC2D30BF5A;
	Wed, 17 Sep 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tot1BX7i"
X-Original-To: linux-iio@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DB12EAB89;
	Wed, 17 Sep 2025 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115813; cv=fail; b=cIS+0vI3WRrk2mOZIGUlV6LRNgUz35zxqd2bVGd4EbBwBXatwGSfWcUfhVILTZpNrawLRRJ174eIvU4pgnc++JOPjvKwU61WFN0wfeO7sutFdMj5K7t2T16RWm7aUjSguBnsWXPgxnPhp/D+gIAJKll9fyUOJSmcddjWQYh1XcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115813; c=relaxed/simple;
	bh=hUBk6MTm643+Tc3moor4R5ysasEhTLgn+Tfr15GKya4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ceO0tFc/pyKgkA07IRrPO+hoy4zWrgqM1ukcS3AzKW1s2O04YhvIAS1+4lYuS/W0hbGrILBWB0nWpF4McLEG2wqRnigvQc4tughU17A1EqsU7lUPdzv84hemcGYO2zyU+3kN7vEXWxrnUzL2HRElA5uYFcKJd7Xfr+0bkmWUCOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tot1BX7i; arc=fail smtp.client-ip=52.101.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0LNOCnsjQNL+cxr8qFY6DlBM9FeGzabvR3v+Tr26k+cpT+w5BpGyDv/WlCy32mGZ5TaHeQmVKqL+6PT4SPwxvamDpKjtoEtgEkbvrxh0cR1oU5Dnn/1t9qgUMmZCt1O1cf8hSFrWRUjqwROU0PTnqETXTFKh5lLgRshgLUooqj72oWEQDvVu5O6LJTpFuH6FU2vykoe0M763QmQD8Dy+55oCDVnECNtb5z41PIqx8LKFSJfPkkXgoxs2nZb7WVo4e0e63fqOx0VUYEUA5ynL70hasNd+VZt5k2/g3hoFwtaANA1UP2suD6a1nOC2xa4PIcR5dgdFOPP6dBjSWEL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUBk6MTm643+Tc3moor4R5ysasEhTLgn+Tfr15GKya4=;
 b=lPcYQFn6oMHq3rQzXeZeaJeiLqHoImZ/dr4K5PgQ4mrqqQ5nesaE+N76bBRx9MAn0y++K4k8H8Hd93vt+j5WSabHDVo+KwNz5qtjqkYYu3Xk62ltqfm0mahAQH7Dr61GwOQG6s7m8uIlxaVGo9CaV9oc/v+c0D7jSWIqiJ+UKvB9MomvBLdM82ZpixTN0dPwaLspmvtd/ylE3DKzDKmPBkZ5Hrx3fPCWIyBDtx8+W8uZ5CTU0E11nBUwKg4oVRUC9pczBUr3+d7MQvR2gFw8vkxX1pJX1cyWTksHAdmMIKwUM5wWFoVjITYEvk9gsgIwe0yD4TTBBBVUQLAFvZbWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUBk6MTm643+Tc3moor4R5ysasEhTLgn+Tfr15GKya4=;
 b=tot1BX7iaa/DqlCuUKSjrized0Zxah1Xo+4WKMNjiBNvOHO8I0l4hHfR6C6kWD0/8KYaMmajso/dqwXd5pUtiC2zzHZYjxLzBoAds91Rll+TV6sTZ8C8RU5DkydgqpxqIfjr1OEXKwShhxTO7Q/hTIdr7E+A41k8JkDdi63o+/q6eEnvasq02mRPGSluJxbr3RyrFvysvUBFhq3i3er78tkSWzXnGHYHohFJXkTiRwBvtGMGX+wVMS/ChJn/U/9SjUSV3THCjVYO6Y2Tj3THDAmqvNq2R/o5AvsbEqTAJ8omLhRD7qm7PpCCNvb+w73dBa2RV9jMmZGxiqR9GKp5ag==
Received: from PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
 by SA1PR11MB8858.namprd11.prod.outlook.com (2603:10b6:806:46a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 13:30:08 +0000
Received: from PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::4f64:b0b5:4ed2:39ae]) by PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::4f64:b0b5:4ed2:39ae%2]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 13:30:07 +0000
From: <Marius.Cristea@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <jic23@kernel.org>,
	<nuno.sa@analog.com>, <dlechner@baylibre.com>, <conor+dt@kernel.org>,
	<andy@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/2] Add support for Microchip EMC1812
Thread-Topic: [PATCH 0/2] Add support for Microchip EMC1812
Thread-Index: AQHcJ83I7JlWojZXD0qSt55n2ZNIxLSXXVeAgAABaQA=
Date: Wed, 17 Sep 2025 13:30:07 +0000
Message-ID: <5b46303db0c9efbd2c2adcba39b59082db82aa71.camel@microchip.com>
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
	 <e9379a2f-be0e-4f8a-b464-df7382338107@baylibre.com>
In-Reply-To: <e9379a2f-be0e-4f8a-b464-df7382338107@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6005:EE_|SA1PR11MB8858:EE_
x-ms-office365-filtering-correlation-id: 7ddaa311-45b7-4ea6-c319-08ddf5ee51a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nmo0WmsrWnRjZXhCV3dWQjhIeG16K3NMeHpQeW8rZGh6VXROdmdvclZCQ3Yz?=
 =?utf-8?B?N1ZyeXE5WjYya2dZTUIxd3RVYkZPVS9MeUs4NjY4NFIyY3VDWWJsTG9zRVlW?=
 =?utf-8?B?bi9MT1VxTXRmUEgwT01zS0tSRFNrbzlBZ3Ywd2ZoeG0zYTFZQlFUZjB4ZHhN?=
 =?utf-8?B?c3RaS1YxTUN3M0E4T2VyTnBrS3R5cUdPamNERUliUDdTU1NDNXBLa1UvNnda?=
 =?utf-8?B?aTh3am80bnc3MGprUGo3aHdLbmppRnY4QndIR00rMWF2MG5wWnlJamV0Qjcw?=
 =?utf-8?B?bVphcWcvYTNKTEM5MFF3anpjLzhPem5rODM0YkNsR3dtaytvaWtmaEVkeTdU?=
 =?utf-8?B?L3Irc1B1MzJLQVAwS1llbGZZeFpYR3oveEQxdVFhcGxQTXJ2bjhzaWJRMk9Y?=
 =?utf-8?B?YlRtYTJMcnNkQXlsbHUyWFFZclJLUU1xaVhrbWttdTNtS2FUdzN5amJzOVVY?=
 =?utf-8?B?N25ybE81bXhlVmdUeUY5a2pZV2dwTHljNlUvQ2ZRNmIxYmFaVU5IdkQ2alk2?=
 =?utf-8?B?UE9YcGt3Y004enBQWFBIYWxzK0dCcnZEMmI3UzF4cSttQUtuNUtzTldVNndY?=
 =?utf-8?B?NkZpc2tiV2NUTCsxR2RQN282M1FSNm9xTGVnbE5EZ2llc2syc2FGdmcraG1I?=
 =?utf-8?B?K29oQmNWMy9GcGtJSzVYTDZPVWlYSllyZnJ6V0VtNFlrc0YrKy8yUTFrVXNE?=
 =?utf-8?B?NUpCcURickt1M0l0c0tubDREcnArOW5yRkJPVXhSWTRZYkdRL1g4UEhhTWxs?=
 =?utf-8?B?SlZvRUg0c1Z0aEp0MHFCaU9tRngyWTR6NENjUDBxa1hnSzZLdnpxN3QwdmVN?=
 =?utf-8?B?c0VYbGV1NnRSdnBvUFRVcE1oQkxNcXgvQjRhd0VxekxvREh1RzdmV0NqL0Er?=
 =?utf-8?B?UlNBUTZJS3VoSlNmb3Mxa1B1eE1RS0ZJeDN2WFdKQ0hEZDZZQlp5S2ZZdjRG?=
 =?utf-8?B?VDJrSXJud05YYWNSSEQ5eG9VNzA1LzM2SU1vVWp5MklDRjFqcDN6NVZRYjF0?=
 =?utf-8?B?anVBRXJDNTQvTlBWcDVKVXJIQTVwUmlsVU9LQVlBcTM0NEo3SDYvTnpvbVBG?=
 =?utf-8?B?TUx3RGJCMzZlUGZJTXNZQXZoMmFSRTlyQ0ZCYXRJZHZENis2eE5yVDVIbU01?=
 =?utf-8?B?b2ZVQUpkU21oNm1FSnVZczM3cWNEdktMVXUxZXpja3o2L1NvUGwrSFNtTk5K?=
 =?utf-8?B?NzBsY3loNkxmRWJQR2hIS3Q3WVZrT050V05BTHNaeW81UUI2RkJES0ZuUnVG?=
 =?utf-8?B?eVErbDN2Z3Fab05ELzBzT2xnSThzNWRCYTFYYlZvZ2U1RHdSQ3FLYzkySzd3?=
 =?utf-8?B?UWdtVFc2UjhIU2ZKNjB0UHRyR0JWRzJnMTFvWlJ1TUEwM2pmTm4wNnJ4ZVEz?=
 =?utf-8?B?NlBoV0VxbGh1T1dzK3ViakkyYU9lRERVWG9xajF4U2NHanYxUCsveGJBU2VD?=
 =?utf-8?B?NW82STU3Mk5OTW5hS1hjWjFydzhrNG9uSyt0cDI2dnpBYTdJVUphbE5ldkVu?=
 =?utf-8?B?WXRCdG5xV2VGT1VLU2NRbzNUck1HaTg2SFVqVmx2Zms2OVRYSXRXNHdueUoz?=
 =?utf-8?B?QVpWL1p1V25meVY4WWpSZENreGxmdmRNN2JyMXdhNWZ4c2JoOHRjbktxYUdL?=
 =?utf-8?B?LzMyVzROSVd6bVR3bENROTY2am85c2QwVHMvd2YrWWpTVFhiTFpsSVdLZkxT?=
 =?utf-8?B?MXJmeERMR2ZwZ1dKSFNkMXNRZ2dVUkh2ZVR0SUZBR3loZkg5TVMxQ3psK0Zh?=
 =?utf-8?B?NjkzZ05FbVhoa1UveVkwOG85RDlFMndaR2k4L3BPc0lOM0ZGbFpxMkoyZVI2?=
 =?utf-8?B?anZUNVFPb3pvOW0rL2dUUFlXY1U0ZXJsZTNZZXFGd3Y0UlRmaFBGa3RnL3NI?=
 =?utf-8?B?UFFUNk1kK3M5VkhGdkt0a3lzc1FSU0s3VStEZUVUQnlOdkR5MXI4WjNNelIx?=
 =?utf-8?B?bVMvVnpnSHZ1VjdmVVRQOERmWWRsNmswTHpTK0xXTmQ4ajVIbmZmYmlORUZW?=
 =?utf-8?B?M3V0ckhPWXlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlkwZk5RRUhiNzdERFFCSGZ2aUFHeU5PeDkwanJ6NUlGMHV6eUdraUVReGpx?=
 =?utf-8?B?U1RZNDFWUFIvWENGL2kyYWE2T0lkR25COVI5UzRZNXdEVS94eDlaa292K0pK?=
 =?utf-8?B?c0VBS2lSbFdNZ0h6T213U2VaWmNCQU8rTXAvS2wzMVJEdmdCZ3IxSmtnVjdz?=
 =?utf-8?B?S2hHWVZxbjFMY1lOUks2amloOUN6aXJ1eWlBSkpZWFFraFBuT2RRcmlGcGQ5?=
 =?utf-8?B?YllHMCtZand4V2NJUGczS0RSWEFNZHBVVFNNenBGRjYzSWZPSmdqSkNrWWJn?=
 =?utf-8?B?NVhWTUNPUE5aVUcxUnVhY2h0UUVYSVIyODFkNWRJc3J2L2RFcWpJK3RCOHN5?=
 =?utf-8?B?TkxWUFRhemdzMkZiRms1Qm4wWWV1aXZJVTRDWHhleDlSU3BaWVN5c1QvaWRu?=
 =?utf-8?B?YlRpVU5MdUJVbVdsd0Z5Z2hGdUJVMEF2aFp4Uzh3amtuZGh4a0hGaEJSeDNX?=
 =?utf-8?B?c3R4SXJTREQ4a3pDRjNvUEhLbXlOL1pnd3F2Vm9SZU5rU2IyK0psNmxNdG5N?=
 =?utf-8?B?dWdsbHdESHQ4SksrM3Z4OERiRGZNWWJnY3N5ajcvRCtPQUVnNklkRTdMa1Vl?=
 =?utf-8?B?aWhwRkduMUZkLzh3YjVlUnlvamltSG05c2k4aWNzd0tWQjZDbUxuUlJFRkFn?=
 =?utf-8?B?bGpVMlVmUTkrV2RaZHp3NDNFcHN0OXJObi9XeDkwTWFqU2lxeWNDOE4vbjlO?=
 =?utf-8?B?NWZFclZGS2Y5SlR0M044c1NsS3ZwL1RiaUZWeEVtUkRIbXgyZDk0TVpNK3Ro?=
 =?utf-8?B?MFNVL1VvODNFeDhkRCs3YU4wdDJXNzcrN0oyRjNXelFPdjZsSUQyUm9yYTRV?=
 =?utf-8?B?dityZ0NnVkFZWThrNTNiTHBFaE56WVc3UEU1NG4vajIycXRkcWNodlZ5MnJN?=
 =?utf-8?B?L3ZqZXlLUFA4SmFGMXBhc1MyeGlyY081VEY0Ky9TU254clFvS1I3bW9zUE1I?=
 =?utf-8?B?bXBKTDhxbEZHb1N1S1EzM2NhazFqSTh5RXcvcUhQaDc2YTVaWGdLY0hXeUZI?=
 =?utf-8?B?Y2piT3YxRW96b0RnNTZRWnBsK2dLdmYvMFN3SG5CMmJpYmkxZkMzSnE1OHlK?=
 =?utf-8?B?TWJmUjBYMzhoUlZ5eW8rRGo2RnZyVlNHMTV3SWhmbWtJaW1sUXh1bVlnMHJq?=
 =?utf-8?B?YVVFdjlqQlI4UFhpUUcrRTdwOWhuMnZFMUpoNGRxdDQ2c0lvQ0dzS1QydlRM?=
 =?utf-8?B?dWg3RkdSd2NVblA4a2xKM2dSQlRlWExuVHR5ckE1RmJDVVBSaVJHdjBkM2pB?=
 =?utf-8?B?ays0SWw3aEQ4NWdXb2lqZ2NjSWp6dFNmWTRma0t3T1pERnZWVDA1aHJITWZr?=
 =?utf-8?B?dkFnOTNXcld0ZTYweE1SRmQzNHVTbEoybUw2QWtwbTh2enZQMWtoWXpKL2tU?=
 =?utf-8?B?bVdybURaRTBrNGdDaTJXRkpXa2RqYXNwWFU2akhOY1h2a0R1SEE0aWRhNEY0?=
 =?utf-8?B?YkRuK0t4dytaSmVqL3Z0cGdZUSttK0ZyL2tGMGRMMWJpUWR6RVRRczVTbmdo?=
 =?utf-8?B?eW5lcUJNQXBCTmJBNHdBUG5QUTlDeFgveG0xazBpWUJEN1RDbG1pRlkyZmtZ?=
 =?utf-8?B?a0NDTkFPSE9MajM2MWtYQ1dUZm5GUktvWTY2VCsyTk5JMWpVNjV3N0F1VUta?=
 =?utf-8?B?cjNtWjdmUDZoVXhVS0N3ZjcveHlYMU5uS2cxTXNRSkJMT2ZCNXpnak0yQXFF?=
 =?utf-8?B?WmE4bE5ZeU1XM2kzK2ZUTXZWTDR0YmJHMlkyWklQK29oNGowbncvem5uc24w?=
 =?utf-8?B?WUdibWhPSnNsL3c5YWpPYlJGTlhMUGVxTUpMVW5oN2xuUUZRUFE2ZGlsdVdp?=
 =?utf-8?B?ZGhPQ2ZZT1g5aG5ZWGNmdnQwUU1FN0lTcEdjU1cxbUM1dGhFNXIyRzZjUjVY?=
 =?utf-8?B?dnJPc3V5SnVKZnFsRHIxZmZOQmZyT1VzRTRIY3BlMGpXUURkOVBiUVg4SFdw?=
 =?utf-8?B?VTVCUng0KzJaTHZiQ2RSaGtaWVJDVTlsOHlmdzBTN2d0a0JFNzZIM2l3ZmQ5?=
 =?utf-8?B?dkEwWlhqeCtKbXViMmNQSFRsY3pNcy9YSWNNbStabm5NNnYrY2lGeGtNUnpN?=
 =?utf-8?B?RjNRcWt0bFFRUytkN21JQi9Vd2o1YVNJYjhRT1dMVTNPMkVQV0dubEZ6U01i?=
 =?utf-8?B?L2dpVHZZUW11MWpFSzUvcDZUb0V3bjZtMUhzdkYzSExnU1ErSjAzM0NiK0Qw?=
 =?utf-8?Q?biE2DCwQaZyb4ZfZj8gokRQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CE7EA148509DA4BB84B184E253225EC@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddaa311-45b7-4ea6-c319-08ddf5ee51a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 13:30:07.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gGto3dJBSbBjpdSTx2MWFeHu1A4JQLAURHhpva+JLIUcmCPlkognlpbSowK0Pkynxj3WdjRF8JJGwFF8DyNkrFj3BTj1T/5Ap8e7k+PXc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8858

SGkgRGF2aWQsCgo+ID4gCj4gPiBDdXJyZW50IHZlcnNpb24gb2YgZHJpdmVyIGRvZXMgbm90IHN1
cHBvcnQgaW50ZXJydXB0cywgZXZlbnRzIGFuZAo+ID4gZGF0YQo+ID4gYnVmZmVyaW5nLgo+ID4g
Cj4gPiBEaWZmZXJlbmNlcyByZWxhdGVkIHRvIHByZXZpb3VzIHBhdGNoOgo+IAo+IFRoaXMgaXMg
Y29uZnVzaW5nLiBJIHRoaW5rIHRoaXMgdmVyc2lvbiBpcyB2MSwgc28gdGhlcmUgaXMKPiBubyBw
cmV2aW91cyBwYXRjaC4gU28gd2h5IGRvZXMgdGhpcyBzYXkgInByZXZpb3VzIHBhdGNoIj8KPiBJ
cyB0aGlzIGFjdHVhbGx5IHYyPwo+IAoKTm8sIHRoaXMgaXMgdGhlIGZpcnN0IHBhdGNoLiBJIHB1
dCBpdCB0aGVyZSBhcyBhIHBhdGNoIGhpc3RvcnkgYW5kIGZpbGwKaXQgdXAgYXMgdGhlIHBhdGNo
IHZlcnNpb25pbmcgcHJvZ3Jlc3MuCgo+ID4gCj4gPiB2MToKPiA+IC0gaW5pdGlhbCB2ZXJzaW9u
Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFA
bWljcm9jaGlwLmNvbT4KPiA+IC0tLQo+ID4gTWFyaXVzIENyaXN0ZWEgKDIpOgo+ID4gwqDCoMKg
wqDCoCBkdC1iaW5kaW5nczogaWlvOiB0ZW1wZXJhdHVyZTogYWRkIHN1cHBvcnQgZm9yIEVNQzE4
MTIKPiA+IMKgwqDCoMKgwqAgaWlvOiB0ZW1wZXJhdHVyZTogYWRkIHN1cHBvcnQgZm9yIEVNQzE4
MTIKPiA+IAo+ID4gwqAuLi4vaWlvL3RlbXBlcmF0dXJlL21pY3JvY2hpcCxlbWMxODEyLnlhbWzC
oMKgwqDCoMKgwqDCoMKgIHwgMjIzICsrKysrKwo+ID4gwqBNQUlOVEFJTkVSU8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoCA3ICsKPiA+IMKgZHJpdmVycy9paW8vdGVtcGVyYXR1cmUvS2NvbmZp
Z8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMCArCj4gPiDCoGRy
aXZlcnMvaWlvL3RlbXBlcmF0dXJlL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgIDEgKwo+ID4gwqBkcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9lbWMxODEy
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNzkyCj4gPiArKysrKysrKysr
KysrKysrKysrKysKPiA+IMKgNSBmaWxlcyBjaGFuZ2VkLCAxMDMzIGluc2VydGlvbnMoKykKPiA+
IC0tLQo+ID4gYmFzZS1jb21taXQ6IDE5MjcyYjM3YWE0ZjgzY2E1MmJkZjljMTZkNWQ4MWJkZDEz
NTQ0OTQKPiA+IGNoYW5nZS1pZDogMjAyNTA4MDUtaWlvLWVtYzE4MTItZTY2NjE4M2IwN2I1Cj4g
PiAKPiA+IEJlc3QgcmVnYXJkcywKCkJlc3QgcmVnYXJkcywKTWFyaXVzCg==

