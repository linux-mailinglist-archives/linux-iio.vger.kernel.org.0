Return-Path: <linux-iio+bounces-8461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DDD9519C9
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 13:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C945B21D9A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E164B1AED20;
	Wed, 14 Aug 2024 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="APUagR1o"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4501E33D8;
	Wed, 14 Aug 2024 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723634542; cv=fail; b=jngty+NJDwMXkiC7e2rwoXiuwc7xqgp+QkTpc8/ZPp7dtHe7QPpGJwofWC17gWXQrC0V52+4u8yLecXYie3QHz5QwwubPzajO1OJTkMjvFokcB9haCjtBEKTDF5JCWokqt06bAjKu0iwqJ+mkaMoq8KdzEoVKcMYpB1ujtm3bjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723634542; c=relaxed/simple;
	bh=ECFv0Ln3D3cXEKKONciuddQhDNETb/hHQZheRGj0KVE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g650XHejZ0OVGuNzAr4eiKk7AYwcVEBR1C5WC8A9eJhK2H7W1kIThm1ISwMlXUR4EyTc73708/Icyw98963KUKqdcYS8mZ8MZbo6cUIlhPiJ4A48H6g86Jg0YFNrbJgSmu+Qd7EgR/fqjFgt11ktOW9yxWt1oB1LTA2u5Q0z6vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=APUagR1o; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tbg6d0kzGjXYUlLsI74uHa+/PrAvvNo6NW89Mqni6hngryvahQjs3zRg8Tosi6+GhiRoMV0dmw+FTIT/Zj+xOYIWgMcvVKGrTGG9GDEH+HJNMnMj3zJA5P66be1eoHyc4g9jx5BRiFoD96YT6TWfuz+KV/MEImzF5xFdpk1sbzBaiY0RnLlkeIIh7faZVdLB1I4LmERfvItfpXCRWxRwKfOz4Fmq9oIGLxdeFggvA673arT7uG8XonPrje4shNWt4xc2yXDNZKDZaIGVoRaejH4UKjJKEzqNoWl0CAcT9scYSe1aO62wVgoF61amnpXR5X2kbN9cO4PH9zjsZn13LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECFv0Ln3D3cXEKKONciuddQhDNETb/hHQZheRGj0KVE=;
 b=MAxHg+wCTJXsu7R4eGEOaPp684Amn+bkeUXPGD6YbHb03rm1pgM6kGJeeusHjqzRWa5rAbtxyPxGE7XULCDXrm/l4zuv2O+m9R2U3YZG+4QhLom/hW+9ZWvnByubB7KyKyabRxaFotrS5QVckqlV0oUkQZkwwsSWLgkMC7fNW28KhU3hSpuK0sSp08RtHh9m8afNovpkfFUlPKtO3jjm9Is0mlATW23PkSzWtdOttjAwV2dHsThEpaDojSHf5jQPy5fEz+7619OdpxHss8PQwfV7tFCbAljgAWXWxmpIN4tMVkZBhkgjPWn88Nz62LuCNoTSXMUoYjobA6WLyUx4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECFv0Ln3D3cXEKKONciuddQhDNETb/hHQZheRGj0KVE=;
 b=APUagR1ol33Sqhif4kv/ObVlwPhxpvuLODf0WJKtaAlO3PkIqqy6Ze6YeyDB0zOTZpM03gpuggvmkmuO+ASsZq6IMUS09vPkm+Jbk2EkhkAWKQoH8fcm+BJRHoR3uVhIxFk4foxhbce3uXlVGFxHq93Vhv9bgguFWhr0FuG8K26tkixsOa6v6BNSetbYT2L+pXE9jkhnYJKixFouGEwpaIUCd3iYOrUDwPSv8LUI28SZtlKM92zdWJtWS9ALMiaGfh7RLqsUL3HTTDSb1xBr2MCvG1PBXrbWNgMyropuMkARmIDCoJy2eNLvPBYjKX8ViZXU4eIMOdhFrHJRrDdHSQ==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by GV1PR10MB8006.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 11:22:14 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 11:22:14 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "dima.fedrau@gmail.com"
	<dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
	<Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
	<Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: RE: [PATCH v2 2/2] iio: imu: smi240: imu driver
Thread-Topic: [PATCH v2 2/2] iio: imu: smi240: imu driver
Thread-Index: AQHa6k2uA9cl/09kzkKzfXi0qtLeGbIgcW+AgAR0C2CAAHlagIABJmnA
Date: Wed, 14 Aug 2024 11:22:14 +0000
Message-ID:
 <AM8PR10MB47218D483B63C0CE88BD64FDCD872@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
 <20240809111635.106588-3-Jianping.Shen@de.bosch.com>
 <561b467a-58aa-471c-8ea6-cd6ef927c287@kernel.org>
 <AM8PR10MB47217665274B9848EB21FA65CD862@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <7181442b-574e-4fab-94c0-e3282ac2d16d@kernel.org>
In-Reply-To: <7181442b-574e-4fab-94c0-e3282ac2d16d@kernel.org>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|GV1PR10MB8006:EE_
x-ms-office365-filtering-correlation-id: 82f9922e-03b8-4099-b8e3-08dcbc535972
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVRuL0ZmU2ZkN2ZaRmI3OVNLeXVhNGlUVWIyVlhudW16emVOSkpNNTNRcUpH?=
 =?utf-8?B?VC9udzJ3YklBL3Y4SXpONTNQOHpqeTJyMVhrMEZxSk1PTUc0V2FtbWRka3RX?=
 =?utf-8?B?SzF0Zm9scWdMRkhBZC93dStGTUF3YVdsQkdud3YxQ055T0p6VDJ5dW8ybFlZ?=
 =?utf-8?B?Zkd0SzlEb1FONGVySEJOR0prZ2FlVnc3ejZ1cHpoT3B5SW9TMTMxcXFLK24w?=
 =?utf-8?B?NUsvSlZKbFVITzJYMWE2Y0xUV2R2S2dwUHBYT0cvYVhwVDBGUHdqVG5OUjlr?=
 =?utf-8?B?L1VCZ3ROdmVZZndncDBmcm01aEROcnVIdzFZNkRuY1hpZ21YeC9HOGN4ckpG?=
 =?utf-8?B?RFBDdTVVV3g2MlpMUEFKSDZ6R1djVmVpVUpXSVJBY0hQaHdyN1hYbEV4ZzBh?=
 =?utf-8?B?TDE5R3RqL2F5aXVqWmxiRDJTaEZSbnZlMFprUCtsVW9vUnplZHdHYlJWZWk1?=
 =?utf-8?B?N00wblNSbnV6T2ZsRDlqenlxRFhqTUhnSjhWRXpkQnhkSDA4UUZlSlRUTVRM?=
 =?utf-8?B?NWpSdkREYzJJemJoTER1b25DY1hZQnRVV0V6UStlWkQ2dEN6b1ZpcTVlaXBh?=
 =?utf-8?B?UitMWHJ0SGp3UHpjeFFsaVc2bkN0YUJpczNhbmo1c296bDN2R0VBRUlXODJp?=
 =?utf-8?B?WnllamhwelRiSlRUbkRoYVArK1BUVmVGUGgrRytkeWpkckNsRDdxZEJ1NTJi?=
 =?utf-8?B?aUlhTmVNNnc3dVlMVk1OOEg5Q0hyWkZFN082OVNBUTk5ZVRMR2hlZ3ZhRWQ5?=
 =?utf-8?B?dVN0Lzd4dG5IL2doKy9PZ2liMHVqNGNnekJmSFpGM09VZXdkYnFNcVh0MGJ0?=
 =?utf-8?B?UURkbjhYWUlsMlF2dHZKcUxVeEYrTTVob2c5UTk2NGxweEtDQkZ5cUJ4WnF4?=
 =?utf-8?B?N2o2UTAyUFVXOEg3SWx3Nld1VmFEQ2ZCY3RPTmcrVDNoWFRocDRwdXEva1dN?=
 =?utf-8?B?Tk82V2lMT3FEQlVvd1p0ZFBhVTBVVzFSZjYxM1V0enlrN3BlZVM4dHNUektK?=
 =?utf-8?B?d0tCZC9ZaWlQMElBMGNraWJwWnFJN1ErUmgvUlRWYjdJa1NHY1dtZHNFeTRy?=
 =?utf-8?B?NDYxQ2hLaW1nc0RIWGFrYkFxcTVJSXZhOENiSDQ1c3kxell2cFQxd0tuYW1Z?=
 =?utf-8?B?a0JSTDdXNFliQnBJVnBnWmVVWFJKNmtLYThTUkxGL0ZROGlNRk9zeTc4R2ZF?=
 =?utf-8?B?Y1JXYVJlWGRlU1BmWlVtc0VCVjNzTDY1OG5lZVV5Mmo4YVNXMk9rM2I0NzZB?=
 =?utf-8?B?M2pGU1FPS05lNTdVUTM5eG4zWkt6Z1N6QVR6dWlLTkZBa3R5TlBoSlpTZUVa?=
 =?utf-8?B?SXVXMXIwZlQrSisyWitmYkZsMUVYWW9sYmNXRTBkbUhrakRtc1M5ZlZuK0w4?=
 =?utf-8?B?NTBDbTlyYXcxTm5YeVhLZnlPcjB5SU9jakFIZ0Y0Zk1IOUxzSUYvWWhXa3d4?=
 =?utf-8?B?WkNudGpsNWJRVzIvayswU2Z0eFhpUGh2RDBaK0FVWmF5cWRieTh4RmhWVnJQ?=
 =?utf-8?B?WEFWZDhOTTFwOUFrb2M2d0RDekp5cVFBR3ZnWHVMR1d3NDdhTDhXcmh5YjRJ?=
 =?utf-8?B?RTBucmtMYTlTSWZMYldKZUl3RjJQdVJkcS9yNU04dEJPc2EwUHQ0S2JDQXht?=
 =?utf-8?B?NXdtTy9QWEI0anczK00vMWFnczMya1o0SklsdHVIQVpueHRCNVhnVkpTd2E3?=
 =?utf-8?B?RHNYN0pkWXZIOXAwWWdJMDByb3B5L296WkNHSUNQMkFGK2hwOFhMb2xBQWNM?=
 =?utf-8?B?ak1IRnNzYzh4U1hsK04vbStPMlh1ZDhaRmYrNEJ5d3FsTGNFbFlVaExQR0k3?=
 =?utf-8?B?NWtPaXkrNWhGZ2tqVzYySjVFVjUyOUJPVmFqWG52Z0QxVnVabzFDc1lUSm1V?=
 =?utf-8?B?T05yZnNkQTVtOTJ3WGlNYkRUVnk4Q3pMVmtSQ0wra0g3MFdDeFBETXNzblpH?=
 =?utf-8?Q?Thq6lhoVpyk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGR4QlgybDNLZHRjRk5WMFdPSVRacDF5TlB4eFBZSkcvNzhlRjY3NWd0bktF?=
 =?utf-8?B?TThLdnFhQUg5cXBVRWJWS3BBUlZQcVlSWUF6RkdodjRramNVRHlFNnR2aXFL?=
 =?utf-8?B?MzVQaUZJRFl1VmwxaHpObG5qaHdnNTVyNjhKZ1poVFRvSFNDSnlFSUlabGJl?=
 =?utf-8?B?aWNNQ3crcVZwNC91Qjl6QzVkM1dRcHV6aHh1Qk9qeExDa2xYOXQ1Q1FIRTk3?=
 =?utf-8?B?aW14ZGc2OE5xc0praGtObFBSZUhzYWphR3VXcmFrVFRaSHlscEFLLzBPYlBz?=
 =?utf-8?B?dlk2S2VEczhnak9ZREsvcWh4L2krYTVvMitSUDlJT2s0aFN4S09CODk4b24y?=
 =?utf-8?B?VmhtUTN0ME1qL0QybUZwY1FnOHJKZHhMNVFxeHJLclE5SElvMVNYeFRINmRY?=
 =?utf-8?B?VTU3SzdldHhuRnBVM0tjSUlaRUxwdmhWTzhOTURJT05rNys4d0FNZ01iUE83?=
 =?utf-8?B?T29HbXJWWllLYlp3QmtiOXhSVzJNVi9NWGNyNHB4Z2RLZ0M2NkxKRHhhcGI1?=
 =?utf-8?B?K0RLSitUSkpzRGM1VFpXRlRUYmxLLzVaVldZOTh4VVphR0hYZmhneG1QeS9J?=
 =?utf-8?B?cmJtSi9CK204c1FETjFYWmp0dlNjYTZNT1BFZ1h2WmVvb0h5bTVYVmlFSGdK?=
 =?utf-8?B?ZFVEVktBbmE1ZWdCeVEvYzIzMmdseGc2RHJxSWJzc29mSHZ6Y2w4UzZOUkd1?=
 =?utf-8?B?S0RaMWlzTE1YQzFsZWhGVGhXTkcwMHVrUXJ3aTFGNUcrQ256SHN4TWwvUVBi?=
 =?utf-8?B?QlhVcHNQeHBHZ1FQTXlJQisxSm5SSS9GRkR3YWljbzM4d1haVDA4SkRnVUpZ?=
 =?utf-8?B?cjRvSUZaeWt0RFdBYUIyUFYrZEJNK1ZrUDJ0aWoxdFdmMU1WQ1VsTEVIUDNW?=
 =?utf-8?B?clpCaFZSSmR4N1BMRzRibHF4aDFJeFk4SVRsWUhJdCthcGd4L0hNS1gvL3lF?=
 =?utf-8?B?WE1uZS9QNGd1V256ZXRJeVowYmEvc2dqV2llU0RwREI1QnkrSVR3enZrc25H?=
 =?utf-8?B?anNiTC80UjQ5QkRuYXdha20ycVNrMmp0cHgwUTNrZ0hxUGpGR3F3V2ZBUFJ3?=
 =?utf-8?B?Rk80ZTJHdmFJMnA2YzBsUGhESDRNaEMyRnpEWGNRdXJpVDlYTTBjNWJpcHB4?=
 =?utf-8?B?YXN6aStjK2F3TWVoS1BJNmo2a1FCTnlhT2ZqSDRkVkhiQjZ6SFllS1Y2TU9O?=
 =?utf-8?B?THF4ZHRCYWRFd1hCSS9lYzBHRm9md04wbEZPK0t3akhadElrRGZTNUhYbWR4?=
 =?utf-8?B?VVpJOCtIaXpXOWs4N3VwcmhndWsreFdKalRYYUQ3MnJ2NmhIWG00K3pTeU5D?=
 =?utf-8?B?aTBMOEdDdlYyWEdFQmxlMmNNNmRHckdxamdmUFl6aEx2ZUJMVW1FNDR4SXZM?=
 =?utf-8?B?eXZpckJLdFVwQ3pkdDV4VTBTQytSeXhxRDlUUVlqSk85MHJpR0FXZnRTemNs?=
 =?utf-8?B?OG0vZFFSVXpiRWpaclJJWEg5WkQ2c0t4Ym1uR2dXODBSYUI1bEg1cWZPUHRI?=
 =?utf-8?B?WXdKdmh2YW9OUFhCYTlPTFpaZ1ZQanAvUFBMOU0zM2FOV3p3TDVBU1YxOW5D?=
 =?utf-8?B?aEdIaUgrQ2dRTzlzWWl3WmY1M00wWTZmNG1XMmlqWDVqNnN2bnhRYThkNTY2?=
 =?utf-8?B?TFF4L0REMk5DdUFIbExDOE5RYTJYVXNZZHM1UnJTRGlnc21ibWJ1SUJTMHFl?=
 =?utf-8?B?MVp2M0kraEpsZ3NHc2x3M3N1VUVsZWtaY2VpVXRLVWxLSWtzc25VTjQwQXJS?=
 =?utf-8?B?cWM4RDA4Vkh5VXZqSVVJRW9zOE1ZMytSbml1Qys5R3YvR0hOVWV5QUVZbkxx?=
 =?utf-8?B?bjNESW12MG9rcnFzUWloWFNXcThWeFo3c1R3WkdEUWRReCtHRWZXaVk4Kys0?=
 =?utf-8?B?UUtGdlNxeml0TFN6a01ialp6R1Nab2ZjREZibjRycGhxZFN1QzJFdFVwRzdj?=
 =?utf-8?B?K25saS95RkVGWHVMWGlPdzQxeTE0b1FYbVZyN3VJR2tvZUFFOXVsbnN5U2tB?=
 =?utf-8?B?T1hKSFZqOFc4dndsd0hZbndWcFZPaGE1QmlncEtWaElOYTZuUE14Z3A1TVNi?=
 =?utf-8?B?NklwZFY0R2x0UkhtUHdlVXhSOEI2ZVBRQ0xxYnM0U1J6NTMyRHVRNWVuUjY5?=
 =?utf-8?Q?RuqU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f9922e-03b8-4099-b8e3-08dcbc535972
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 11:22:14.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eR6SmSc04CupeWxgAUCyst6yZ/ZYSDtHGzRMq0RJki+P/B3UzXii7kfJ9h19PXLsdwTPi6HsglrWTGr/z0UMsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8006

Pg0KPk9uIDEzLzA4LzIwMjQgMTE6NDEsIFNoZW4gSmlhbnBpbmcgKE1FLVNFL0VBRDIpIHdyb3Rl
Og0KPj4+ICtFWFBPUlRfU1lNQk9MX0dQTChzbWkyNDBfY29yZV9wcm9iZSk7DQo+Pj4gKw0KPj4+
ICtNT0RVTEVfQVVUSE9SKCJNYXJrdXMgTG9jaG1hbm4gPG1hcmt1cy5sb2NobWFubkBkZS5ib3Nj
aC5jb20+Iik7DQo+Pj4gK01PRFVMRV9BVVRIT1IoIlN0ZWZhbiBHdXRtYW5uIDxzdGVmYW4uZ3V0
bWFubkBkZS5ib3NjaC5jb20+Iik7DQo+Pj4gK01PRFVMRV9ERVNDUklQVElPTigiQm9zY2ggU01J
MjQwIGRyaXZlciIpOyBNT0RVTEVfTElDRU5TRSgiRHVhbA0KPj4+ICtCU0QvR1BMIik7DQo+Pg0K
Pj4gSG0/IEhvdyBtYW55IG1vZHVsZXMgZG8geW91IGhhdmUgaGVyZT8gV2hhdCBhcmUgdGhlaXIg
bmFtZXM/DQo+Pg0KPj4gV2UgaGF2ZSBvbmUgbW9kdWxlLCBuYW1lZCAgIkJvc2NoIFNNSTI0MCBk
cml2ZXIiLiBBbnkgcHJvYmxlbSBoZXJlPw0KPg0KPlRoYXQncyBub3QgdGhlIG5hbWUgb2YgdGhl
IG1vZHVsZS4gVGhhdCdzIGRlc2NyaXB0aW9uLiBXaGF0IGlzIHRoZSBtb2R1bGUgZmlsZW5hbWUN
Cj4oZmlsZW5hbWU9bmFtZSEpPw0KPg0KPkZpeCB5b3VyIHF1b3RpbmcsIGJlY2F1c2UgeW91IG1p
c3JlcHJlc2VudCBwZW9wbGUncyBjb21tZW50cy4NCg0KU29ycnkgdG8gZ2l2ZSB5b3UgdGhpcyBm
ZWVsaW5nLCBObywgd2Ugd2UgZG9uJ3Qgd2FudCB0byBzaWxlbmNlIHlvdSB0byBhdm9pZCB3b3Jr
LiAgSnVzdCBkbyBub3QgdW5kZXJzdGFuZCB0aGUgbW9kdWxlIG5hbWUgY29ycmVjdGx5Lg0KDQpm
aWxlbmFtZSB5b3UgbWVhbiB0aGUga28gZmlsZW5hbWUgY29ycmVjdCA/ICBXZSBoYXZlIG9ubHkg
c21pMjQwLmtvIGFzIG91dHB1dC4gVGhlcmVmb3JlIGp1c3Qgb25lIG1vZHVsZSBhbmQgd2Ugc2hh
bGwgcHV0IE1PRFVMRV8qIG9ubHkgaW4gb25lIHNvdXJjZSBmaWxlIHJpZ2h0LiANClNoYWxsIHdl
IHB1dCBpbiBzbWkyNDBfY29yZS5jIG9yIHNtaTI0MF9zcGkuYyA/DQoNCkJlc3QgcmVnYXJkcywN
CkppYW5waW5nIFNoZW4NCg==

