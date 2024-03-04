Return-Path: <linux-iio+bounces-3311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A0A86FFDE
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 12:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81FAEB24306
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 11:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB5438FA9;
	Mon,  4 Mar 2024 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="IfABDnFV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21539867
	for <linux-iio@vger.kernel.org>; Mon,  4 Mar 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550565; cv=fail; b=fgm4gYRRf1ua4d1fXXsbeQTTr5l3KSRwJABISeJBqDbEmmB2s4+o4cd5uEOtQVA4TpOanzHXFovs1mycx4g+q4TFGFKWNsTX+K/KvErD2hPGTxX7OlRFqmNA/UP7WCVw2wW3kkUrnQH2lHdM11qI5PVb42SRKi3K+AGU3v/slgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550565; c=relaxed/simple;
	bh=DHt/55ulFDXFs1Lu6YYiyCdNqxyBRlIfaWzmFgE3I2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zr50sed4rxhO2DLULYbn/7jCglwUawpYqlVzERFGSxWu/Axoe4PQ3iEwRKNOG5135r+8ahofgfrXRLZhBpdwTgpF2ZfhrkzZXAxaD5n4wHwzPj3mCbpdgDNPiOykKmmBHww3VqD4YRbYyUR3vqougZZ5VVwfN4E36uRptdufrS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=IfABDnFV; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4248EbWW022235;
	Mon, 4 Mar 2024 10:50:38 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2168.outbound.protection.outlook.com [104.47.11.168])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wktfy96yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 10:50:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoNE0bUkidGnOyheIdrpqN49KOM5Rx4jBoRs6oOv+cM3rW6C68WpJ7i03LZLsvb6RYmfgYNiKxWBsVYhrcp09B2fJIv7Zi/a6e/oE/ohAK0EbFtid7/3nNGM4512HgpaU5mV0AftEqM2ng9/bu6q9Afn05Okpr566jTxLVyhBf+exB7DTAFpipCeTt4jGYmc6NWTStJUXk7r4Te264F2jhHb/tiJM9jm5nj6B0FybxLTUwZWBkXrHPcqHlBePscyq99xPudGOZVT3V9kOHk2sHgveYnbkGSCShD0o/gIjMYHgeyuWGELhbqalgrkqOsTkFmTximJTAs6wWwC++AP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHt/55ulFDXFs1Lu6YYiyCdNqxyBRlIfaWzmFgE3I2o=;
 b=j/OgZ2Jcp4Pqovdj3X/4mU4KMQIYlEDhxztDLdHNlIz0X2tY+yg5elByJL9hA+hls/WpodixvieNIOZE717h5CczW31sqRo0VjSzJD4PZt4mz3fAki+sApU/ChDjP072QV9Xqlu2uuHuz0mJcTNd2tGVU3ysRgaIZx1vnj0cIiicljd7yv9uwhPM6UJftFAABjHYlr6oeUdhWUyfVhM8wv4frpcNrfnvj8AWiNs2qO+2w20JaA5Osi0Ex8IkjWoesC37rKoaP2z+56QDBT5sB1Oh8wAy/aAx4+pY6/yTV/96oWtYr6JZO8WibKPIjl5FPmRkckrRETDkAt6aIJlr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHt/55ulFDXFs1Lu6YYiyCdNqxyBRlIfaWzmFgE3I2o=;
 b=IfABDnFV3R0GDT3ZbdR01olrqnfSWWRSdKu1C29+y5QQwNmpoqTc1VIueAZf/JbY8pY4CVuLPGWwvmCEMR8GrWHS6O2ZfxfyaypFlmVUTIOtXdPXUpl3yZfPz8Zdw7TmDX5kH3l6Pmhl06JVAFZPN5l/F3PjGtx3S5HeCOds6Z1ag7UmRJoxmY3AEfIObeBVAUHZwFqLPYCL2H//eHTfX3OkQhKrwd/vkRol11D3RZFrYri8bJp43s9V+qKQSvTPa6B8CNvJwb7FZ8gaDsaXLI+lBVGQe4M2rIDuH4mjvEGZ8vFxfJtqK4V5qCTqKHfMmvXeLCAMfOmWuoT8gAPaQw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEUP281MB3633.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 10:50:26 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 10:50:25 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/4] Add WoM feature as an IIO event
Thread-Topic: [PATCH 0/4] Add WoM feature as an IIO event
Thread-Index: AQHaaAPRyvLMbq4l+Eiuh19FBAU+KrEmRAAAgAEtpR0=
Date: Mon, 4 Mar 2024 10:50:25 +0000
Message-ID: 
 <FR3P281MB17579D0F295C8C99E7C7A5A0CE232@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240225160027.200092-1-inv.git-commit@tdk.com>
 <20240303164410.6b7cb206@jic23-huawei>
In-Reply-To: <20240303164410.6b7cb206@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEUP281MB3633:EE_
x-ms-office365-filtering-correlation-id: 7c742115-72c5-401c-f3d4-08dc3c38e62f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8akmvcM32q7g2KINzAyq2g1UrkI5ItJBUEpjffwqRfaM1ej0o0Rf6ApGOSZm3eTt3pcSigzqbf9KjF46b+fHoOri7kG2MtMKdFD0S2YJSZ9JqdXO4UrJvmJDG2FNrIZ6RvkqzM2+T0AQkNPeI5+425xZoO1epTZ8eVLHKaau4XGZCx3o//Ui3O0fJw4jBQqLrINtUetCio1egBOURHGQkr1GpqM2MWVw7EvLIEuSt/gx2uvSwIHCHHCVFvNP3BrrM2d2mdlJSU833XHu+MTR4zO7pV4AFJAfvCu8nowx1x0fw55UVw2ssgWHNnLNByCHyFDJzyui5iCbSD+m368I//MgjPM4pfVqhhuWnj5Bs733shDz60nNoERYRX/NzIJ00BPP6rt/YxKUJscamzrVw4P2a0hcxPp+hWUKRU4ROs/FO9oUjuCU+J+tIbj4+yMZAlHkqAW0ZN31Mfg7DDQTVQqZNSWEjNZQpDzJHr9AfhNVIMRTkbC3mFva7ju5bzxWdmQL4NpzH3uOOuOeg1zJUOX5fvJlFxWAfCSHiv1MWjPEc+2jIXwEApkgdGuGKqdsfms7XWux94XX3+VbM856MvOd/dpG4IxfkWUczwRB6vLlrzcEfS92Qt/X6PTCJe0vsstsmiiHz7mQACoMw4LUvIUMKUgw9pOHBjjBDwHnI0YdSMRTG61KK0GtVAEbCqKIofgk7orl/MsBbSUdqwPXjO0A6rj5l/v4f7WsMMwKQmc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z3piakFVUmQveEkwTkx3aGVMU0k0bmtscFlSZ3UwTm9CbEFRaXZ1R1ZwZTY0?=
 =?utf-8?B?RnZKT0N6VFYrc1d0MFB5RktvaE1oRGpQYmFGaWZlU0Fnb0tvaENrM3pUMVF6?=
 =?utf-8?B?b2hQeURGSGc3dG1EaXVqcVRYVXN6L0tjVnB6Ymk2NEJxSmlubDdDeWNGcUFF?=
 =?utf-8?B?NmV5QnpJanFyTlJhVjBnUkE3eUJwalUxY2F4bHdiLzlCYXdPNUU3bU9FemZK?=
 =?utf-8?B?WnRNNzBVdjd6VlJBTTZOWU1UWUFocXE4d3p4UlZmMDU5OHBKNzlWSS92OXEz?=
 =?utf-8?B?ejV0ellzUmVkUS9BQlM0VVV2K3BoN0l0M3pibEpaZDBBNDNJVm81eG1qMDlU?=
 =?utf-8?B?WUduZUg5NW11ZE9FMUtNcHpVa2FEdEMrRzVWU1QyMWNhVUR3MWFwZWNveENC?=
 =?utf-8?B?emJTY2pTQW0veU45RzJMVS92bTN2ZkptalJJdFBkRWJ1ek1heWNXQzhnSmda?=
 =?utf-8?B?UVk1T3NGWTZmSE9VVGNQL2l2b1ozMGpNOURkb3RKN2VaVDUvdXlnMEh5aFlz?=
 =?utf-8?B?T3BhWHg3Qk45R0lkUm9oMHE1cnVWd3RQdks2MERHMFVtTW9UTkVJWGxvZ3Ju?=
 =?utf-8?B?VWZBbFptVDdXR0l1NXdXSndGVTdORXI2VU51d1ZsTmJORDVWSTFkWnhWRmkw?=
 =?utf-8?B?Vjl5Z1pVdGVlaCt3NXhWajRtdDRMTlVSUENQc09FQlBlZW5SakxsQ3JOb3Y2?=
 =?utf-8?B?RzdCVmhRa2Q4emMxc3RCVE41UTUrb3I5dmt1SFpTWW5oSVcwVlQrRlNhKzFk?=
 =?utf-8?B?clBGQ1VWdlA5dU0xbVp2WGNYQ1piSE9nOTZsTlVuM0NWREpYT2p5eUZ3Z2hL?=
 =?utf-8?B?R0h6bWtWNkFzNnk2QktoNmFvREZzRHpER2tmbDJDUkdZeGJXMm5nVHh4a2lx?=
 =?utf-8?B?Z0JZZWJqWmVJUWdRcGVxNHFXQ1lXZ0xud0lRRkpReEpxQ3BkSDRrT0dLSFY1?=
 =?utf-8?B?M3JPWVMzTVFLdk44akdVTkNOTDZTZFhkNmh0UVg1TmpNMUluYml2SmEvWDk3?=
 =?utf-8?B?UzU3YzRTZVBRWSttdFkzU3pQYkIrOXlydFI2OVgyNnV1WnhmOEo5cmUxWVFh?=
 =?utf-8?B?TCtmelF2VC93Z21YREVtY1ZkYWxaSi85b1p3ZlEwOFNUdkFDd1hMazVOS3Az?=
 =?utf-8?B?aHl3eTQ3ZUgvUU04cHFGWURRM0FLeUgvVFV1d0VjM1oycTFtNXpiRVBvSXNn?=
 =?utf-8?B?cGdBc1ZWeS9sdVp4WGlBRHJyTGJnWDF0enQyczd3cUVkL3dpVDByUk5Rb3BF?=
 =?utf-8?B?N2JxM0NielNLZFVIWWJzb1JJdWRBbWsrbkJtblorRWd2U0FINERHNGNua3dy?=
 =?utf-8?B?VHQ2NlF4OHNMeTNRRkpPS3RzS3pvb3Vqb3F2dkJGQ0VWajFpaEtJblVUUFZD?=
 =?utf-8?B?aVVPVlVhNmdHMWpPRG9zcEs5VjViWUV5S2dmaDkzZmR6ZEQveDN1SlBtekVw?=
 =?utf-8?B?R0g1WHg0TnJtcFdNbFFOSVRVdlZQN0dhUGlDY0RjcDdjeElJK25LKzlxV0pJ?=
 =?utf-8?B?V0M0SGlDQ0xCSHhNQjNNQjlrbmpvbmpzNVJGdXJnWjkyQzdHZVdWSHYzRWNT?=
 =?utf-8?B?NWFGVHo0YUNpM1hBdUJEdFdSRjIvek9IK2tSUFI0K0hqekNsdEh2TDhUWUJX?=
 =?utf-8?B?ZkErWVZONDRhQWw2emNNUkFFcU9MaHdJWlZ6cnNxUVAwanpOSFdYQmxTZHMz?=
 =?utf-8?B?T2hXL0VIYWhlWHRsMzNhMC92L01wdW9yaUNuaE5RdEJNQzZoUEZCeVVEaGNh?=
 =?utf-8?B?RmZiY1JXbjhoQTNtTjduMzlpTjM0TVZscDdmU1ZmeEw3aVNkUU4zZnloUXRv?=
 =?utf-8?B?UFBCd2VqS2hxQkdaQ1dyYnVmSkx3YXJ0V0dWZndRQ3FkUEVweEpkbW85K2Rx?=
 =?utf-8?B?K0I5MnFZSERhNndaVTNESkF6emZYUFNjcHBlZ1lmS2g2bDNSdWVqU2ZNcE40?=
 =?utf-8?B?K0VITi9WSmk3NUwwUFBxTURGbmRNYXJSdVNacml6NHUyMXZvb0lua3ZtblpY?=
 =?utf-8?B?ZEhvalBNQzkxV1RMK0xyeDA1QllTZDB2SmJ5UGlDQ3NZSVd5ZENjOXV2TzBP?=
 =?utf-8?B?WmV4MUtkbEhONU1WN2dnN011UzYveHpkNnRwWWRMamFidVlYVGxHTlEyYTBH?=
 =?utf-8?B?QStzeDloS2x2MnlxOERNeGJmUHZPRWRNRzJPS2h6Q201NUVZNVlWenhaNlhX?=
 =?utf-8?B?N1E9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c742115-72c5-401c-f3d4-08dc3c38e62f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 10:50:25.7212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlEN8V/1OkD/BhyQ9rX3zrStUePZOZapZ02kb38WNXg7Gi6YjtQE5o3rqDhQvMkKqq6pXLsr9eR2oO3Hk709HrVwy6fC89Ofp/PCB/DznbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3633
X-Proofpoint-ORIG-GUID: czpaLe8ZsM10BgeDqd1zeDKsAifn8pbo
X-Proofpoint-GUID: czpaLe8ZsM10BgeDqd1zeDKsAifn8pbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_06,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040081

SGkgSm9uYXRoYW4sCgppdCBtYWtlcyBzZW5zZSBpbmRlZWQsIHVzaW5nIGEgdmFsdWUgaW4gbS9z
MiBwZXIgc2Vjb25kIGFuZCBjb21wdXRpbmcgdGhlIGNvcnJlc3BvbmRpbmcgdGhyZXNob2xkIGJh
c2VkIG9uIHRoZSBzYW1wbGluZyBmcmVxdWVuY3kuIEp1c3QgdGhhdCB0aGlzIHdpbGwgYmUgYSBj
aGVjayBhZ2FpbnN0IHRoZSBhYnNvbHV0ZSB2YWx1ZSBvZiBhY2NlbCwgbm8gc2lnbiBzdXBwb3J0
ZWQuIFRoYXQncyB3aHkgSSB3YXMgdGhpbmtpbmcgYWJvdXQgbWFnbml0dWRlIG1vcmUgdGhhbiB0
aHJlc2hvbGQuCgpJdCB3aWxsIGVmZmVjdGl2ZWx5IGJlIG1vcmUgY29tcGxleCB0byBoYW5kbGUg
YmVjYXVzZSBpdCB3aWxsIGRlcGVuZCBvbiB0aGUgc2FtcGxpbmcgZnJlcXVlbmN5IGFuZCB3aWxs
IHJlcXVpcmUgdG8gYWRhcHQgdGhlIHRocmVzaG9sZCB2YWx1ZSB3aGVuIGNoYW5naW5nIHNhbXBs
aW5nIGZyZXF1ZW5jeS4KCkkgd2lsbCByZXdvcmsgdGhpcyBzZXJpZXMgdG8gc3dpdGNoIHRvIFJP
QyBpbnN0ZWFkLgoKVGhhbmtzLApKQgoKCkZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtl
cm5lbC5vcmc+ClNlbnQ6IFN1bmRheSwgTWFyY2ggMywgMjAyNCAxNzo0NApUbzogSU5WIEdpdCBD
b21taXQgPElOVi5naXQtY29tbWl0QHRkay5jb20+CkNjOiBsYXJzQG1ldGFmb28uZGUgPGxhcnNA
bWV0YWZvby5kZT47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWlpb0B2Z2VyLmtl
cm5lbC5vcmc+OyBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxKZWFuLUJhcHRpc3RlLk1hbmV5cm9s
QHRkay5jb20+ClN1YmplY3Q6IFJlOiBbUEFUQ0ggMC80XSBBZGQgV29NIGZlYXR1cmUgYXMgYW4g
SUlPIGV2ZW50IArCoApPbiBTdW4sIDI1IEZlYiAyMDI0IDE2OuKAijAwOuKAijIzICswMDAwIGlu
di7igIpnaXQtY29tbWl0QOKAinRkay7igIpjb20gd3JvdGU6ID4gRnJvbTogSmVhbi1CYXB0aXN0
ZSBNYW5leXJvbCA8amVhbi1iYXB0aXN0ZS7igIptYW5leXJvbEDigIp0ZGsu4oCKY29tPiA+ID4g
QWRkIFdvTSAoV2FrZS1vbi1Nb3Rpb24pIGZlYXR1cmUgZm9yIGFsbCBjaGlwcyBzdXBwb3J0aW5n
IGl0ID4gKGFsbCBleGNlcHQgTVBVLTYwMDAvNjA1MC85MTUwKS7igIogClpqUWNtUVJZRnBmcHRC
YW5uZXJTdGFydApUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXIgClRoaXMg
bWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4gCsKgClpqUWNtUVJZ
RnBmcHRCYW5uZXJFbmQKT24gU3VuLCAyNSBGZWIgMjAyNCAxNjowMDoyMyArMDAwMAppbnYuZ2l0
LWNvbW1pdEB0ZGsuY29tIHdyb3RlOgoKPiBGcm9tOiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxq
ZWFuLWJhcHRpc3RlLm1hbmV5cm9sQHRkay5jb20+Cj4gCj4gQWRkIFdvTSAoV2FrZS1vbi1Nb3Rp
b24pIGZlYXR1cmUgZm9yIGFsbCBjaGlwcyBzdXBwb3J0aW5nIGl0Cj4gKGFsbCBleGNlcHQgTVBV
LTYwMDAvNjA1MC85MTUwKS4gV29NIGNvbXBhcmVzIHRoZSBtYWduaXR1ZGUgb2YKPiB0aGUgY3Vy
cmVudCBhY2NlbCBzYW1wbGUgd2l0aCB0aGUgcHJldmlvdXMgb25lIGFnYWluc3QgYSB0aHJlc2hv
bGQKPiBhbmQgcmV0dXJucyBhbiBpbnRlcnJ1cHQgZXZlbnQgaWYgdGhlIHZhbHVlIGlzIGhpZ2hl
ci4KPiAKPiBSZXBvcnQgV29NIGFzIGFuIGFjY2VsIG1hZ19hZGFwdGl2ZV9yaXNpbmcgSUlPIGV2
ZW50LCBhZGQgc3lzdGVtCj4gd2FrZXVwIGZ1bmN0aW9uYWxpdHkgaWYgV29NIGlzIG9uIGFuZCBw
dXQgdGhlIGNoaXAgaW4gbG93LXBvd2VyCj4gbW9kZSB3aGVuIHRoZSBzeXN0ZW0gaXMgc3VzcGVu
ZGVkLiBXb00gdGhyZXNob2xkIHZhbHVlIGlzIGluIFNJCj4gdW5pdHMgc2luY2UgdGhlIGNoaXAg
aXMgdXNpbmcgYW4gYWJzb2x1dGUgdmFsdWUgaW4gbWcuCgoKQWRhcHRpdmUgdGhyZXNob2xkcyBh
cmUgbm9ybWFsbHkgdXNlZCB3aGVuIGEgdGhyZXNob2xkIGlzIGJhc2VkIG9uCnNvbWUgb2Zmc2V0
IGZvcm0gYSBoZWF2aWx5IGZpbHRlcmVkIHZlcnNpb24gb2YgdGhlIHNhbWUgY2hhbm5lbCAob2Z0
ZW4Kd2l0aCBmaWx0ZXIgcmVzZXRzIGFuZCBvdGhlciBuYXN0aW5lc3MpICBJdCdzIGFuIG9ic2N1
cmUgaGFjayB3ZSBhZGRlZApiZWNhdXNlIHdlIGNvdWxkbid0IHJlYWxseSBnZXQgdGhlc2UgdG8g
Zml0IHdpdGggYW5vdGhlciBzY2hlbWUuClRoaXMgc2VlbXMgc2ltcGxlciB0aGFuIHRoYXQgZnJv
bSB5b3VyIGRlc2NyaXB0aW9uLgoKQXMgaXQncyBqdXN0IGFnYWluc3QgdGhlIHByZXZpb3VzIHJl
YWRpbmcgYW5kIEkgYXNzdW1lIHRoZSBjaGlwCmlzIGluIGEgc2VsZiBjbG9ja2luZyBtb2RlIGR1
cmluZyB0aGlzLCBpdCBtaWdodCBiZSBtb3JlIGFwcHJvcHJpYXRlCnRvIHVzZSBhIFJhdGUgb2Yg
Q2hhbmdlIEV2ZW50IChST0MpLiAgVGhlcmUgYXJlIHJlZmVyZW5jZXMgdG8KdGhpcyBiZWluZyBh
IHRocmVzaG9sZCBvbiBoaWdocGFzc2VkIHNhbXBsZSwgc28gSSBndWVzcyB0aGVyZSBtaWdodApi
ZSBzb21lIGZpbHRlcmluZyB0byBtYWtlIHRoaXMgbWVzc2llcj8gCgpUaGUgY29udHJvbCBvZiBh
IHJvYyB0aHJlc2hvbGQgd2lsbCBiZSBhIGxpdHRsZSBtb3JlIGNvbXBsZXggYXMKeW91J2xsIG5l
ZWQgdG8gdGFrZSBpbnRvIGFjY291bnQgdGhlIHNhbXBsaW5nIGZyZXF1ZW5jeS4KQWR2YW50YWdl
IGlzIHlvdSBlbmQgdXAgd2l0aCBzb21ldGhpbmcgZWFzaWx5IGh1bWFuIHVuZGVyc3RhbmRhYmxl
LgoKQSBodW1hbiBkb2Vzbid0IHdhbnQgdG8gaGF2ZSB0byBmaWd1cmUgb3V0IHdoYXQgdGhlIHJp
Z2h0IHZhbHVlCmlzIGZvciB0aGUgcGFydGljdWxhciBmcmVxdWVuY3kgdGhleSBhcmUgc2FtcGxp
bmcgYXQuCgpKb25hdGhhbgoKPiAKPiAKPiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sICg0KToKPiAg
IGlpbzogaW11OiBpbnZfbXB1NjA1MDogYWRkIFdvTSAoV2FrZS1vbi1Nb3Rpb24pIHNlbnNvcgo+
ICAgaWlvOiBpbXU6IGludl9tcHU2MDUwOiBhZGQgV29NIGV2ZW50IGluc2lkZSBhY2NlbCBjaGFu
bmVscwo+ICAgaWlvOiBpbXU6IGludl9tcHU2MDUwOiBhZGQgbmV3IGludGVycnVwdCBoYW5kbGVy
IGZvciBXb00gZXZlbnRzCj4gICBpaW86IGltdTogaW52X21wdTYwNTA6IGFkZCBXb00gc3VzcGVu
ZCB3YWtldXAgd2l0aCBsb3ctcG93ZXIgbW9kZQo+IAo+ICBkcml2ZXJzL2lpby9pbXUvaW52X21w
dTYwNTAvaW52X21wdV9jb3JlLmMgICAgfCA1MjMgKysrKysrKysrKysrKysrLS0tCj4gIGRyaXZl
cnMvaWlvL2ltdS9pbnZfbXB1NjA1MC9pbnZfbXB1X2lpby5oICAgICB8ICAzMyArLQo+ICBkcml2
ZXJzL2lpby9pbXUvaW52X21wdTYwNTAvaW52X21wdV9yaW5nLmMgICAgfCAgMTcgKy0KPiAgZHJp
dmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfdHJpZ2dlci5jIHwgIDcwICsrLQo+ICA0
IGZpbGVzIGNoYW5nZWQsIDU0MSBpbnNlcnRpb25zKCspLCAxMDIgZGVsZXRpb25zKC0pCj4gCgo=

