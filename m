Return-Path: <linux-iio+bounces-7831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7B93A9C5
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 01:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDEF51C20A73
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 23:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EF114900E;
	Tue, 23 Jul 2024 23:20:42 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00174802.pphosted.com (mx0b-00174802.pphosted.com [148.163.137.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008813BAD5
	for <linux-iio@vger.kernel.org>; Tue, 23 Jul 2024 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721776842; cv=fail; b=nZmH9I3M0ZFBi1Dd4ICPkcJBQnt/BvVuOpDOE0hvvrYB6oW8qE9Dif1dAMNfsIUPLKIcKNy2LWtlWYcSbIrKv04Czv9IQ+yCaCjMFKfMpB/r8cpYYBIzprv3PBZAEIUgVMTK8//dPl33p3l2yax4HPl6lXollP32jlTkgfaBvsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721776842; c=relaxed/simple;
	bh=YVWStPnO7cs21TpVRScTBLWxSq16t/vopxPW1BTniSM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m6D+StDCRXPY1/B0zIvEGPmrO7j3jbeWxY6bXCU9Jr8pQFyaPCkBbjJIjipkEn6rfjcFa5hy2EmAVFhH+W6NiZqLGxpY9IKJQUPXAqfZjjToYISHZ3H14vEs8+ND8jcgDxs/V7j2I/r3Z2YiNb+CUyodGmrM1MDe00sjxbL0Smk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=heilatech.com; spf=pass smtp.mailfrom=heilatech.com; arc=fail smtp.client-ip=148.163.137.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=heilatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heilatech.com
Received: from pps.filterd (m0172410.ppops.net [127.0.0.1])
	by mx0b-00174802.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NEGnph030049
	for <linux-iio@vger.kernel.org>; Tue, 23 Jul 2024 18:07:22 -0500
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012055.outbound.protection.outlook.com [40.93.14.55])
	by mx0b-00174802.pphosted.com (PPS) with ESMTPS id 40hw1p4v74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 23 Jul 2024 18:07:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LH8jw3QiracLEn9yAcgc1eIy4yWJ2GJA9EW+P6qwKAS/lbEYhkoCIKvIy3GyAMeZ1g0pQESrDFyaeFb8Ual/yN5wfwUELTzFNplkvRl+Gb9EWLoCNHc7kEXtu5KCSWxC2Aaw1VqBeg/D6zGy+DPn/8E5W6baeBsrJNwlqiA3bgGnpjpiq/GXJqwgMyEyXjMZzKLPyhRVyDnftafjemHhZ75GPYncFlcQJQ0kisZWBQ6Xfjst0fjCe5wjLTv3Si/U54O0oYANdjwocQw+6xbElYSPAd0/nIJ88dxN8wNtObsDzhYX6wFlKG4rz75ybm7hgCAy0s7q3RcKArSypWONgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVWStPnO7cs21TpVRScTBLWxSq16t/vopxPW1BTniSM=;
 b=y71pFVH/JbboYfaVg9OsRkQH2g5QJ8GpXKl9Jax4YzMjQZZ47uzkyVJmRykynJOF+HJ0lO18DR538iwGL+5p6QowtU1wjx1Tc/ZJz3MuaaAo711RBt52G3HNAG4wLcHkERhgIeyInYSuuDUE8d2pDLf8cWawiCnr7DkHcsyUyovREgbTlSoUYcn6+POnwG4K3jWWg0vgDYHyHiklPb0+ZPyvF+qCKUL137euDNPhujFeSKfxq1zT2/yUGCm20KLLPi7V7mUhYlDt7GCVm6XeX3023dmKxSZo0mO4lSY7DFoDaFw+TYcvN+ahUGu+/2jpJ8jwCSuxMiAPuqD7mhAJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heilatech.com; dmarc=pass action=none
 header.from=heilatech.com; dkim=pass header.d=heilatech.com; arc=none
Received: from SA0PR01MB6170.prod.exchangelabs.com (2603:10b6:806:ec::14) by
 CH0PR01MB7061.prod.exchangelabs.com (2603:10b6:610:100::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Tue, 23 Jul 2024 23:07:20 +0000
Received: from SA0PR01MB6170.prod.exchangelabs.com
 ([fe80::560d:33aa:15dc:408d]) by SA0PR01MB6170.prod.exchangelabs.com
 ([fe80::560d:33aa:15dc:408d%7]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 23:07:19 +0000
From: Akash Borde <Akash.Borde@heilatech.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Emily Guthrie <Emily.Guthrie@heilatech.com>,
        Erika Silva
	<Erika.Silva@heilatech.com>,
        Bart Oegema <bart.oegema@heilatech.com>
Subject: [ti-dac5571] Checking compatibility of TI DAC with kernel driver
Thread-Topic: [ti-dac5571] Checking compatibility of TI DAC with kernel driver
Thread-Index: AQHa3VURec03RAbWv0OAfFXOC/6ogA==
Date: Tue, 23 Jul 2024 23:07:19 +0000
Message-ID: <1261F7BA-D202-4BED-ADB4-87EB75E2C068@heilatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR01MB6170:EE_|CH0PR01MB7061:EE_
x-ms-office365-filtering-correlation-id: d3ae2e73-c8c7-4c2b-2529-08dcab6c3401
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzR4bHZGMkR2dERFTXBWeldtQnZnRDR6bS8xRGpEWTYvMjNFbFV1VU5sb2Zm?=
 =?utf-8?B?a0kxVkpWTEZwejBJYTdiUWhGK3B4NVdBYi9qTTJua0lBbzRKSmU5UWdRL1BZ?=
 =?utf-8?B?WTJWTUYrWHpKcitqQzhwcW9RRDgyeUJLaXlOckN1RFBvbXhEVFc5NUFiV2Ux?=
 =?utf-8?B?eEc2TTF6ckNBbFNFUUF0bW1WQ0JXTnROSHA4WHBsYkhhZ3Qwa3p6WitrREQ1?=
 =?utf-8?B?MGg3MUtSMXNHNlBJL3d6UDZxTENYQjF6Y2xZRm1VbzVtdGxzU04yZUVvRW5y?=
 =?utf-8?B?ZCtVajBSanljcjdWT205MlhkMUhUQ3h3MkE5R2JMM3FuTGh1cWU4eHBsckQ3?=
 =?utf-8?B?d2w2bm13eUFRL3ZOdFdpaXZvMFNFOEVDemZLcWVqbVpwUENJN3NKMURRZStZ?=
 =?utf-8?B?M3puMWZSUmN0VDBqbFpnRVM4Vlh1em02STZoc290NGRXNVVNS2NNQnZFcmtS?=
 =?utf-8?B?cGNDekZFMU5PREFPS2JPU2dGVnJHZ2VMc0xjS25sNi9BWXExSEJVY08rd0pp?=
 =?utf-8?B?MnFJdFQ5cjNucFhndTlsZ1V6N2d0Ly9lQzRONm0ybzVPVFJVVmhOakJ3L2k1?=
 =?utf-8?B?eDlaKzkrbnlCU3FNa21tYnFkcm9oMTBxR1hHZU9CVDZmZkovZUQrUGRmQ3F0?=
 =?utf-8?B?RTBsMVE2ZHlLY3g2Snh3N0FWNzgwYUE4ME5XaWw2N3VSNnFHOUNDV3U1dlBC?=
 =?utf-8?B?cmFpU2hQTGdPZjFXUkNzVlhIRkFYM01qdGVxTkE4cHViVjVxWll2RW9NbnB0?=
 =?utf-8?B?Q3dqd01XblJuSE1BUlN5MUlBNU03Z2VROFA0RWxrZXlKUTg0bU5CTG9ZY1Jl?=
 =?utf-8?B?QW5zTy9PRTFYRW8rVThxbUZDMGVQc09mZk12SVRYcmMrZlhma1ZMU2tKeDdG?=
 =?utf-8?B?M3RkdEN4V1pPWUk0QmI5Qlk0aWxBK2JBLzhRa2tPM0NLcnhQM1BPeFEwMUlJ?=
 =?utf-8?B?S0xKRUhvK0FrOG15MTk5WWxIMUFlQmt6bHhaaWxuVDczVEtCT3h0ZGszTkZv?=
 =?utf-8?B?TGduWjEydmMzYUhIK2kzcytkNE9yNXFjVXhvSWl5cWxkVFFpdlo2UU14N3pr?=
 =?utf-8?B?K2x4Y1UyWElpb2NqdlNkYTFLT3lCWlQ5NXozcDlNaytPcVJvVEk0RFFucVdP?=
 =?utf-8?B?WHVqRnk0ZEEyVDZ0Y2E2c1FvV0hiQU5aTVFTQlNDZU9sMnRvMDdrbktBN2Zm?=
 =?utf-8?B?VGZFVWovK2U1MnJ3blQ0cVJlYXNMeXdFQ3BRMThKNDFsa25tbk1hVWxlOWs2?=
 =?utf-8?B?d0MycGM1R0xuVEc2MTU4R0J3cjQwTVhHV3RJdnpFdzhiU3pjcEN6NzlLdE54?=
 =?utf-8?B?WEExODB4RmFVUzdKbllHR3pORzZpVVBEOXMxR1czUGJodXpHbGh5MVJ0M1RI?=
 =?utf-8?B?UDBIVDY4aWJRRjBNTFBna0o1ckpGWUlRU3FtdDdnTWoyVW1HYkVJODlDZ0d3?=
 =?utf-8?B?ZitHYUF2a044R3JleFUrbkNsbmJOT2lMU2MzSHpFWEtHRnBPaDI2UWpzYUNh?=
 =?utf-8?B?Vmk0ZHlvVjlNRG5kQTM3Ty82NUpxeThEckIyMVpPR2VMTlRZSFY3R1UveUkz?=
 =?utf-8?B?MWJDZldJVGxOUjNENmRxbDM1d2dvdVhVdzRRdFZHdGtSMHZ1Q1JHU0VFZWpK?=
 =?utf-8?B?eFhneVJRRXk1ZE5pdGw1bTU0a2sxVnNLOFp6aFNhSHlrSFRUUFlla1l3Y1ZR?=
 =?utf-8?B?SDJMNzFXM0kxdGp3clB3Mzlzayt2TGFSK0U0U3dYUThHc21iWXdrdlVwYkFB?=
 =?utf-8?B?b1ZHdDVIdTk2VHEzcFlhTm5qbDJYd2ZjZFZnbnlFNmQzbzI0NEYvcURnUlZm?=
 =?utf-8?Q?VToWxF0Hh7QHYIqKLEQjgnFqZ3efF5VDu6TqU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6170.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1ZSQWRkY2FDWmNCcThYOEljTlBqTzlSd1VwMjNFTVdlb24xT09saEhtdmZN?=
 =?utf-8?B?WUR0VUxIS1hzZG1WZUR0SmZWZTZ0WDBzMlpkT2EyZGcycDJ1R21ZL1ZDdWxn?=
 =?utf-8?B?WnhsaXRvWlpOSmJvZ1lLYjNsS3V3K1ZJdmFFY0ZUa2h0UmdzdURVNEZZVjlX?=
 =?utf-8?B?aXlXclpMQk0ycjJHbHlXbk5LRG5UZUprZ0FCaTFvR3VZMDhFVGVobWwvOEFV?=
 =?utf-8?B?Y2U3U1dpQ3VueWFDdEpnczhTZTVqUm5ScXU1WkprTlM1d09vRS92Y2Z1NkYv?=
 =?utf-8?B?dHp2M0tUVUFZait5WEF1eVdCUWkzSjJGSlNlWk5xTjVYVHZmVW1FK0Y4NmVn?=
 =?utf-8?B?aDlTa0FUbUtXK21CVGVsc1pTSFN2c3pHeHhzdWd4cnlqdHc3L1JqbkRnOHdi?=
 =?utf-8?B?bzlMem4xa2lZQ0pHSjRNZWwvZ1lCc0RNRGY4NTlvREFhd0p1clFkMVJCSmVv?=
 =?utf-8?B?QlFVRzJudWphUnFGOFVLMjJVMUJwR01PM1A2eDhIQXFHdXl1VkZvU0JHK2I4?=
 =?utf-8?B?QXBRZUhHMEZzRjZSeHdnY1cyZWh5L1QyQ1pVWUVBS0xRSERKWlIrNi9Sdi9Q?=
 =?utf-8?B?TzdUOWJJcEpPSjJLKzdFSVh2N2M3VUdLdzYxdVBMcWg1NXQ1bTAyaG1MeGVo?=
 =?utf-8?B?cmE2WnJsUUtLTjhrd0lucjdqZTlOWVBDVXdHRVd0c3M3Ujk3QlFyNTYwVVly?=
 =?utf-8?B?V2J5NU82Z2dKaXVWRlhsRStZMDZwZjBvdmJRbUhRWmJXVWhXVjQvelV0Sm9y?=
 =?utf-8?B?K3p0b1N1aTBWYmE1SzZ3V3FyV0hhQTRXUi9uTDhWRFBPeUU1ZXFnaWx5OWZo?=
 =?utf-8?B?Q1dmOWhKUThVVVU5OFVwU3BSbWVwZ2xTSU1jcXEza29jSDU1RjNQZzJTK3p3?=
 =?utf-8?B?c3owbzVSeHZhM0FxYXZ3NUcwT1FodUdLdXhCaTFISEt1ZmlXOTZLVmJxVHlY?=
 =?utf-8?B?Mlp1RWwxWUhtYjNYZ2hvdE5nUkVjTzUxNGlkVTI2RS9hd2o3MnAyWHB0UjYx?=
 =?utf-8?B?UGxiT0ZrWG1jeUZjTjkxUkIzUE82bUZrNjVJa1pldy9TbUdlY3BHMms1Nkti?=
 =?utf-8?B?VlQ0akExRWFPbGRidzFSbjF5VUR6SWxMKzJPRk0xRlJZWk1Bc3poK1JuajNX?=
 =?utf-8?B?L25GeXB5STFDcXlnZzh6SXRUbjJIa2VNSXp3RTRGSlN0UjZHVG1iTzM0M0p3?=
 =?utf-8?B?elh5QW9IbVFsRU9xeW1wWFNCc0tzNTVSbHR0TnVBd0lMMGd0dVlCbWxvNi9u?=
 =?utf-8?B?SVlMQkh5Zkt2Q1V1QVBsUWpJY1R6MTBOSTFMVmpUM254YnBta2VBdkhBTkJM?=
 =?utf-8?B?OFpka2FUaXhQY0QwRU80SkVDV0NqbURWTGpJNUdqalVCRFRKWGMwelVIbGtM?=
 =?utf-8?B?UFlvOWRXQ3hFSkdvTnNzL1dsRE13MHV2RC85MjB2N3NvZzFOT0FLL0NYazVO?=
 =?utf-8?B?aDJnbFNFWGhPYjJldGExYSs0Zk9QMG9Yb0o3Z0duM2ZvQ0EvQytkN2paL0dr?=
 =?utf-8?B?WWxwUURqTUNNL1NLcGthWDBDTUN0UUZiTGRGV3VuWXVsUDdXSG5MV0FpRVp0?=
 =?utf-8?B?SDRrWmhhcVpjdE8yUXFYUzNRNGxaL1d3KytOaUF6MENqK3lQOGpLSjBsQkMy?=
 =?utf-8?B?U1NpeHFEeCtXUVFnTU1wcHBFNExZZFIwNmhlVk1jeDVFL0w0OVUzK05Md2lM?=
 =?utf-8?B?aXNvaHFxVEJYWGl6U1pEMmNtTzBRL1BDSnRWV2piY3Fxd1RYSk1yQ3FHZlQ4?=
 =?utf-8?B?UjhCWWx5YkVWQytsR3o5Z2dlcnF5aUVBQkdOeDRBaGFrSzhxNmx3U0tkdGtx?=
 =?utf-8?B?ZEdEYnFTemhOeWhxRytTRmFCMmw2RENhMHpWYzNJR3hwQmNkSDVRay9NTVJ4?=
 =?utf-8?B?R3A1OWZScWxaWDJoU1R0SnVDY043R3FJSDBubmk1QTZmaXIvQlZ5d2x5aUk1?=
 =?utf-8?B?Zm1ya0oyeGxOYmFUM0tEYmRGYjRhY2hlL2RvMURkUXBESi9tekdsNVRBUkNT?=
 =?utf-8?B?L3owSjV6bXMvYTNFc25JVEZrN2RXRGNwNWorSnduVE1RWjErSWxBbVNlekNT?=
 =?utf-8?B?VUFaUlVVWjlVZmUvbjVMVm5RTHNTOHVxdGxjQ0IwK1puOEU0OVVnSFdENzJW?=
 =?utf-8?B?S3RZdlRScUpKK3U3S0w2aVJ5Y3F4OTZ5akJIa1k1SGR5azNpRnFWaDdUUTVx?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D32B138FF9735549BAB1684753CF7434@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: heilatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6170.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ae2e73-c8c7-4c2b-2529-08dcab6c3401
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 23:07:19.6655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d2d3f03-286e-4643-8f5b-10565608e5f8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 161NFC89SCmFhNivrA9cex5OyV6zCkcQxIExmoPSQpmPCeoVCYHaplV14Sds7YX+ktZiV70m4VnfljWd7soXckZXnznPZVSTMMyahfCF8Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7061
X-Authority-Analysis: v=2.4 cv=EbiaQ+mC c=1 sm=1 tr=0 ts=66a037aa cx=c_pps a=uLgqAjDAh1BxMpLoLcdK2Q==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=iPDCyfAhTBcA:10 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=jiqXDrDkAAAA:8 a=zesCDFQrFD2TfHMYfIcA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=aeg5Gbbo78KNqacMgKqU:22 a=f0JD9i-elTk4OLjlH16K:22
X-Proofpoint-GUID: 22k9xIlr9KXxHJMHZ430XUUQr2sQEH-1
X-Proofpoint-ORIG-GUID: 22k9xIlr9KXxHJMHZ430XUUQr2sQEH-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_15,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011 mlxlogscore=947
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2407110000
 definitions=main-2407230162

SGksDQoNCkknZCBsaWtlIHRvIHNlZSBpZiB0aGUgVEkgREFDODU2MyBpcyBwb3RlbnRpYWxseSBj
b21wYXRpYmxlIHdpdGggdGhpcyBleGlzdGluZyBkZXZpY2UgZHJpdmVyIGluIHRoZSBtYWluIGJy
YW5jaCBvZiB0aGUga2VybmVsLg0KDQpUaGlzIGlzIHRoZSBwYXJ0IEknbSBldmFsdWF0aW5nIGZv
ciBteSBib2FyZDogaHR0cHM6Ly93d3cudGkuY29tL2xpdC9kcy9zeW1saW5rL2RhYzg1NjMucGRm
IA0KSGVyZSBpcyB0aGUgbW9zdCBzaW1pbGFyIGtlcm5lbCBkcml2ZXIgSSBjb3VsZCBmaW5kOiBo
dHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvZHJpdmVycy9paW8v
ZGFjL3RpLWRhYzU1NzEuYw0KDQpJIHNlZSB2ZXJ5IHNpbWlsYXIgREFDcyBpbiB0aGUgY29tcGF0
aWJsZSBsaXN0IG9mIHRoaXMgZHJpdmVyLCBidXQgbm90IHRoZSBleGFjdCBwYXJ0IG51bWJlciBm
YW1pbHkgdGhhdCBJJ20gbG9va2luZyBmb3IuDQpJcyB0aGVyZSBhIHdheSB0byB2ZXJpZnkgYSBE
QUMgb3IgZmFtaWx5IG9mIERBQ3MnIGNvbXBhdGliaWxpdHkgd2l0aCBleGlzdGluZyBkcml2ZXJz
Pw0KDQpUaGFua3MhDQoNCkFrYXNoIEJvcmRlIHwgRW1iZWRkZWQgU3lzdGVtcyB8IEhlaWxhIFRl
Y2hub2xvZ2llcw0KaHR0cHM6Ly9oZWlsYXRlY2guY29tLw0KDQo=

