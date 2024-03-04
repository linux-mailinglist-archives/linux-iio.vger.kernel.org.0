Return-Path: <linux-iio+bounces-3312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDD3870003
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 12:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0571F263F6
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 11:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A80383B6;
	Mon,  4 Mar 2024 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="TV0ggVM8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B923B287
	for <linux-iio@vger.kernel.org>; Mon,  4 Mar 2024 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550736; cv=fail; b=hEj/dxisUByOV3BJhPMXR5mjId5zKE6rhgNnVjHMWC80h4+UEpo3EGpOqGLVC5Fa9EpuG8GLZ/IPciGnSJbw95OzWtL76hZUHiMGpXJbZOLztMDpm6UIbq5+Cavzvgpek2uHSzdcpqR6EY95ePFRnSyc9QGvf8rdb5xRyktuv10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550736; c=relaxed/simple;
	bh=aSIRJ/8JAuLgbsa7JfTwesS0iOeaEJZeF1f8exlzBEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PjDyjXu1hWxGuS1TQobKgiYzP+L8vaLFDBSe/Oc9DwJNOP5ZkAbdXjUzHV6RfenB4UDHVWSzN211O+WkbpLCNoK6twl/wvBaT2nk125ek+KQpWd8rj4TsRoxrY6N5+9kd1a33IK4uErr8gSZKOvV+sAJ0vnSjNo1bhLMNhf7RvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=TV0ggVM8; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4248Exil026672;
	Mon, 4 Mar 2024 11:11:58 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2169.outbound.protection.outlook.com [104.47.7.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wkwfjh5vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 11:11:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1J/Qui5jke8S7F8qaJ3k0r+kb868HcSCo6o8+ru3+Pu/9dwrpeIbOGxzfnV5k0gt7byU7tjudPOIWUNr6oa6lFwmmI6+0RFgQqT/Labt1xD2uv9V8U4+pkj8+TFfmgf5/szPxZsG9E/GYAhKdxYPyoBZGMLf5gV9iIPyGNBS+DvnWCoqN+n2I+a8ll9wGbWiGmWnfbmj5sqN8lviWeRv/IzxqsldoIfKCev1jySjQ7K6yd9Qa0dZZ65n52T1tNrf55vXURpv3awHeWyIcX5u+vzpDej96axNNMWTDdwjmM1F01hOxyWGkk+kgzWwsus6ko3xg32w5feg7hRS9rCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSIRJ/8JAuLgbsa7JfTwesS0iOeaEJZeF1f8exlzBEg=;
 b=nyG9FER+gZMR0XxLuL5SLHkUIIVXYOLlFmWbk1CZuXu3rlZxxykumJOHHdb4i6Iv/ufkRFYhdPjV9eUhXVi73GvOvt4JkTfCLPGNz0hZM+kkkyE/PWqd4kWYUKorHl1bSUrRsasqjnUyjM0mTVYLvPakX/ZFdsBDcRmpErLmSEiADUffk6MurThCopQKQQicn1YCOGbNzKdzFeIa6ju1mntfugK3EGcyG1Xx+xlqSA1zUv1LIQC2VJRYRFemr13pNrNvJzn0Kd0MPAcXU89wf5mCQx1O65ImVgZcAUwHzlSosIfDLDGA/m5xVZ9uiCv8ZhIHX7Y4NH//C7H5VtPYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSIRJ/8JAuLgbsa7JfTwesS0iOeaEJZeF1f8exlzBEg=;
 b=TV0ggVM874YoZoiMcpQFhj+u5e09sAoBDW5nP0lUxI8cH2OOSNLD7kxAGzzrGG4u1ah3h6zpRizlr6M+1l65LIXjYoZXrNsdT6j+ASYHnDZAqtKd386tlmOMLeUqlibcw582X1n5RPrZV3TUz/kttyPKj9za6MJhiOI7rbCkDm929pQS4WOUFfbaOggdAjmgtJT7Ao6e1A2+3wnaPOdSXtB43rAtY/CGivsJupLsK7l+d+O6e8Fa0lZ+D4T85Llm/2Ia8p/C/6DU/lGapNSqdLyckoV7TxnisQZPQ7amk353fxg6eqJQuKoHWKefzyvJuTQEUwbooZ0Qk03qS5gwhA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEZP281MB3169.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 11:11:54 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 11:11:54 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/4] iio: imu: inv_mpu6050: add new interrupt handler for
 WoM events
Thread-Topic: [PATCH 3/4] iio: imu: inv_mpu6050: add new interrupt handler for
 WoM events
Thread-Index: AQHaaAPd132Yh22S/02iXfpOs2+PgrEmS0eAgAEt+E4=
Date: Mon, 4 Mar 2024 11:11:53 +0000
Message-ID: 
 <FR3P281MB1757BE6895EF363ED0ABAE74CE232@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240225160027.200092-1-inv.git-commit@tdk.com>
	<20240225160027.200092-4-inv.git-commit@tdk.com>
 <20240303171013.110eddee@jic23-huawei>
In-Reply-To: <20240303171013.110eddee@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEZP281MB3169:EE_
x-ms-office365-filtering-correlation-id: 05a603fe-f942-4e94-3aee-08dc3c3be603
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 oqFArqg7PLVSGXnHoaD17HVauYurmuhWpoQkPExu1p7aIaao87OgIK7y3RyBzEHJHxN+ymULXvWvesx2pqZ4ILnAB4Opujfjvnq/d3FC1ft3R66PsMRueVgdB7kCnldm4rbTqPh4n/+3GWTp3mQ2iEix6vT7BmITuA7P4zB+UXe0sYFwPFQWwth2LVju9boH1O93L1P1hoyr4FG7xdGgmWX21sagYCJdw2ZLEeBR15JlaD8097rI7NWRNv6qeSIcaeKUgFCiYaXlsyiYtpu9+Ls+HIqFfPMG/lpB5yp72pqKR1SKOobFNQW1W9U4jrRUZH6Dcu5YKPJsfuA2av5EFTuz0YtvQ87MxXIQI8xeZTU1n05KFZZn1+JBMCZHl1wkm4GeGKcTOkGg2tKuTq++jgbrBkdH+/5W2skj76oN82iq21vsrTQ/te6oqVP4RH6Q4v8HDe/0gyXHlHYm/DRpvNRtbvjalXSD0mE1WHY1fYUqVDbD/7aj9BycBJJADNlP06FzcnTkSW8ajGdDv/nYvszTY9FDmmvJb8Q2lXxR0jyemGv7odkVLfx0E0O3cNQe+7TBjlT15iVl6LN0ErBIETJPh1+kxvIZaulM3GVnUdV7byASBfpMOkj0e9eH5nQEKC73mc1SyOmpBzCs+/mkGtSjcNlYiVrWbsGnjDNBCbkQ7XlxqXm29qmLjkoo6WYaaXwHA4K8+guRCwj6e6Y7vBNiuHimtTpzRdgn2yfLjygPh+xeTO6zbDf7NZ3LFb8+
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(3613699003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S2NIMkhtZ3lFTW1jbVFFZ1FqV1NPOVJ5VFJzZ2F5ald1WUlRbnUxeTBRUkZ0?=
 =?utf-8?B?T1Fxbnc5eUdrd1VJcnR2TGx6QzhrWDVYbjBiM29JSEx4d1FPOFQzb3BMa05F?=
 =?utf-8?B?ak1VcU9UWkdhN28zZlB5eDVBMDk2Q1dnRXlUdFRKSEpjaWFVSHM4cUdZVFUr?=
 =?utf-8?B?QjhQQVp6NktBeEdvTEkxYlUvSzI2elgzQU1iaWxid3ZoTFZKU2cxamxwWDVT?=
 =?utf-8?B?VG04SWVoZ3lNQVRoYWh2QXB2OGRydFhSZVVadnBxT2Q3dUoyVEh1ZHFod2l6?=
 =?utf-8?B?TVpwbHk2OTM3VVdyRVRoRERFQ2NMQnNHYU55a05FMldUeTVwMVMycHJwNHRC?=
 =?utf-8?B?dStyLzdRMnFxMUZuUTdFL242U1hRUzFoRVgrczIwWmR1SHYxbVBpTURla3ZS?=
 =?utf-8?B?bHRJb2xKQTVJRk44VTZFaUpDMFRCa1N2QzBqcCtnMGFSeitsUm1iT2c3cHk4?=
 =?utf-8?B?ME8yMGRhaWxRQkUzN1J5ek12MEhib1JxeDdlMnlHVFRLTUJFY1ZZMGdDSjYw?=
 =?utf-8?B?YnM3T0VDRVlUcUdjaVF3emFjdCtjc0F6WW9ZN3duOVJuNHo3dEJ0Q1h0YkpL?=
 =?utf-8?B?VzlPTmNZY2cxYWN5dDQ5c2NpYmVONmJ5T2dhZzlkVy8xUzVERUtod3RzeEpQ?=
 =?utf-8?B?Y1BpVjZNbEZuRFFlMllsQkw2MjBTYUdxQ29GekRvWFpQVnFCR3hoWWN6b2Zu?=
 =?utf-8?B?MVp1aVdOaDh3R1Zab3lGZkl2cER4ZFJKMkxGWGtFaWY4STlDZXlYK3lDMVJF?=
 =?utf-8?B?ekdDdWpEWFhjU3RvTGZtRHNjK2FSMyt3Q3k1MVpsSUlNN0tieUJXenBIUkQ2?=
 =?utf-8?B?cDdUdmV5UUZuMXVRWjB1c1RiTnE2MHhLdFpLM21MS0lTdXBCd1Z4YXJlWGNx?=
 =?utf-8?B?MlRybk1Jdm5obGpsRjRGNExOdUtGYk5TZ3FTaDluQkJWb3VIMkVtclRBaW1T?=
 =?utf-8?B?L1RuNjkvRUhXcVh4MUhNNThqV2FQSElNbWdHSkd1K2h6S2oyTks0TUhHODVU?=
 =?utf-8?B?N1poMHRyTTJvZWFSVEJKVnpNQThsbHVxQXM1Q1cxWkNKQlVoL3h1ZXVLV3I5?=
 =?utf-8?B?L0pJaEd2ZUFrSEJJUU5IbHpFTVV3dGswNWRjTTVOMy9ZK0pzdkphbysvMmwr?=
 =?utf-8?B?L2xlUUwzVGE2cXk4bVhBenpwRUQrSXlhTktjNE9MMkxTckIzOEIramxxdTFZ?=
 =?utf-8?B?UFVtTEtscEJyK0tqS3JPenFLc2RIRVFwelFtU2Z5a014VlJwSE9rNlZhUGtF?=
 =?utf-8?B?Njh2NFhDZzgzVFlQYmdOREc3MnF2bmJTOThqZnhOb05pOHRqWnFCcjdQQkZS?=
 =?utf-8?B?anU1S0RXeTk0TzhPWEhYU0FWYys1NER3bFd6cmNObm5FSlRENWlqUVRpaW5M?=
 =?utf-8?B?Q0FNMUw4bWpsN2l4cVdqMEtWSW95cy9jdW83dkVCdFFpeXVjbG1MOHNBRzBz?=
 =?utf-8?B?SWduaTU0c3haZ3p1NTgwejZSN1V4K2ZidzlxZ3ZkWkV6Zzg5NHM0UWdmMjVa?=
 =?utf-8?B?VERWR3dhblhhY2g3MFFGZ0JOOUZvRkdoU3loRk5lYmxjRVFrRjhubHo4cTdZ?=
 =?utf-8?B?ZThZVGR3VnpNWVhWaTVkR3NhNDRCdUhSYlZ1NzVVeWFua3Nmek5RbUJEWkdZ?=
 =?utf-8?B?ZXFBaS9IZ3VIYnVqdUhuQTJDZmZMZGNncEtDcks5REFjTmMvMUQ2VERYWUNn?=
 =?utf-8?B?cysyNXN0a1F5bkpjbEVac284LytaK2krbyt6M2d1VjNvYndNczNuNE5MRER3?=
 =?utf-8?B?dUhSK2FDTWNNMDZSU3hzNHFENUVpaWNNUFJaamFaZnV4WjN2VExuZ2p0dFJQ?=
 =?utf-8?B?Yjc3TTJqemxYL0MrSW1wRVVkVXkxRkV6NGF1SG85VW1IKzNodUVlVllwVU5q?=
 =?utf-8?B?cG41RDZpNWRVVGZNWEFyVktkSEt4Q0t4c2wwcUM3Mk8rQzMrcUN1MFR5aE9Q?=
 =?utf-8?B?WHlHckpNdmZ4aXdVdmRTTDIwN3dIVnEyWktLVEt2dE5uYUVScDhGQWpMMkxr?=
 =?utf-8?B?eXR2YTViYzNYM3pSUzNKNG5FYkx6QnVQK0xhd3RENFIvd3JEbFZJZk53SW9J?=
 =?utf-8?B?ZE1OM25GRDdKcnJIS3oySDJiMndXaytuQ1ZaOEh5SkJmQUQxcVRXb3FEOGNw?=
 =?utf-8?B?aEpFTmlrNHNwZHVHeGszU3pxQ0EvalJuQTY0TGxZSEoxQUtTMTVTVkY3U20z?=
 =?utf-8?B?QVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a603fe-f942-4e94-3aee-08dc3c3be603
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 11:11:53.9350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyYAXAY/Q6jt3iEsq3/02BYWcNyzeltbCag4hOAJ7G8HUMO1pRkPOetPhtLXiC1ldq77XBA7ij+AY5QRYGCg3Jl41lsKa15yIguo61zhVd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3169
X-Proofpoint-GUID: gB-v0j_15URhHX6hczw593GA-eArMel5
X-Proofpoint-ORIG-GUID: gB-v0j_15URhHX6hczw593GA-eArMel5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_06,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403040084

PkZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+Cj5TZW50OiBTdW5kYXks
IE1hcmNoIDMsIDIwMjQgMTg6MTAKPlRvOiBJTlYgR2l0IENvbW1pdCA8SU5WLmdpdC1jb21taXRA
dGRrLmNvbT4KPkNjOiBsYXJzQG1ldGFmb28uZGUgPGxhcnNAbWV0YWZvby5kZT47IGxpbnV4LWlp
b0B2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBKZWFuLUJhcHRp
c3RlIE1hbmV5cm9sIDxKZWFuLUJhcHRpc3RlLk1hbmV5cm9sQHRkay5jb20+Cj5TdWJqZWN0OiBS
ZTogW1BBVENIIDMvNF0gaWlvOiBpbXU6IGludl9tcHU2MDUwOiBhZGQgbmV3IGludGVycnVwdCBo
YW5kbGVyIGZvciBXb00gZXZlbnRzIAo+wqAKPk9uIFN1biwgMjUgRmViIDIwMjQgMTY64oCKMDA6
4oCKMjYgKzAwMDAgaW52LuKAimdpdC1jb21taXRA4oCKdGRrLuKAimNvbSB3cm90ZTogPiBGcm9t
OiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxqZWFuLWJhcHRpc3RlLuKAim1hbmV5cm9sQOKAinRk
ay7igIpjb20+ID4gPiBBZGQgbmV3IGludGVycnVwdCBoYW5kbGVyIGZvciBnZW5lcmF0aW5nIFdv
TSBldmVudCBmcm9tIGludCBzdGF0dXMgPiByZWdpc3RlciBiaXRzLiBMYXVuY2ggCj5aalFjbVFS
WUZwZnB0QmFubmVyU3RhcnQKPlRoaXMgTWVzc2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRl
ciAKPlRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4gCj7C
oAo+WmpRY21RUllGcGZwdEJhbm5lckVuZAo+T24gU3VuLCAyNSBGZWIgMjAyNCAxNjowMDoyNiAr
MDAwMAo+aW52LmdpdC1jb21taXRAdGRrLmNvbSB3cm90ZToKPgo+PiBGcm9tOiBKZWFuLUJhcHRp
c3RlIE1hbmV5cm9sIDxqZWFuLWJhcHRpc3RlLm1hbmV5cm9sQHRkay5jb20+Cj4+IAo+PiBBZGQg
bmV3IGludGVycnVwdCBoYW5kbGVyIGZvciBnZW5lcmF0aW5nIFdvTSBldmVudCBmcm9tIGludCBz
dGF0dXMKPj4gcmVnaXN0ZXIgYml0cy4gTGF1bmNoIGZyb20gaW50ZXJydXB0IHRoZSB0cmlnZ2Vy
IHBvbGwgZnVuY3Rpb24gZm9yCj4+IGRhdGEgYnVmZmVyLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTog
SmVhbi1CYXB0aXN0ZSBNYW5leXJvbCA8amVhbi1iYXB0aXN0ZS5tYW5leXJvbEB0ZGsuY29tPgo+
PiAtLS0KPj4gIGRyaXZlcnMvaWlvL2ltdS9pbnZfbXB1NjA1MC9pbnZfbXB1X2lpby5oICAgICB8
ICAyICsKPj4gIGRyaXZlcnMvaWlvL2ltdS9pbnZfbXB1NjA1MC9pbnZfbXB1X3JpbmcuYyAgICB8
IDExIC0tLS0KPj4gIGRyaXZlcnMvaWlvL2ltdS9pbnZfbXB1NjA1MC9pbnZfbXB1X3RyaWdnZXIu
YyB8IDU2ICsrKysrKysrKysrKysrKysrLS0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgNTMgaW5zZXJ0
aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8v
aW11L2ludl9tcHU2MDUwL2ludl9tcHVfaWlvLmggYi9kcml2ZXJzL2lpby9pbXUvaW52X21wdTYw
NTAvaW52X21wdV9paW8uaAo+PiBpbmRleCA1MTljMWVlZTk2YWQuLjliZTY3Y2ViYmQ0OSAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfaWlvLmgKPj4g
KysrIGIvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfaWlvLmgKPj4gQEAgLTE4
NCw2ICsxODQsNyBAQCBzdHJ1Y3QgaW52X21wdTYwNTBfaHcgewo+PiAgICogIEBtYWduX29yaWVu
dDogICAgICAgbWFnbmV0b21ldGVyIHNlbnNvciBjaGlwIG9yaWVudGF0aW9uIGlmIGF2YWlsYWJs
ZS4KPj4gICAqICBAc3VzcGVuZGVkX3NlbnNvcnM6CXNlbnNvcnMgbWFzayBvZiBzZW5zb3JzIHR1
cm5lZCBvZmYgZm9yIHN1c3BlbmQKPj4gICAqICBAZGF0YToJCXJlYWQgYnVmZmVyIHVzZWQgZm9y
IGJ1bGsgcmVhZHMuCj4+ICsgKiAgQGl0X3RpbWVzdGFtcDoJaW50ZXJydXB0IHRpbWVzdGFtcC4K
Pj4gICAqLwo+PiAgc3RydWN0IGludl9tcHU2MDUwX3N0YXRlIHsKPj4gIAlzdHJ1Y3QgbXV0ZXgg
bG9jazsKPj4gQEAgLTIwOSw2ICsyMTAsNyBAQCBzdHJ1Y3QgaW52X21wdTYwNTBfc3RhdGUgewo+
PiAgCXVuc2lnbmVkIGludCBzdXNwZW5kZWRfc2Vuc29yczsKPj4gIAlib29sIGxldmVsX3NoaWZ0
ZXI7Cj4+ICAJdTggKmRhdGE7Cj4+ICsJczY0IGl0X3RpbWVzdGFtcDsKPj4gIH07Cj4+ICAKPj4g
IC8qcmVnaXN0ZXIgYW5kIGFzc29jaWF0ZWQgYml0IGRlZmluaXRpb24qLwo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfcmluZy5jIGIvZHJpdmVycy9p
aW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfcmluZy5jCj4+IGluZGV4IDEzZGE2ZjUyM2NhMi4u
ZTI4MjM3OGVlMmNhIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAv
aW52X21wdV9yaW5nLmMKPj4gKysrIGIvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9t
cHVfcmluZy5jCj4+IEBAIC01MSwyMSArNTEsMTAgQEAgaXJxcmV0dXJuX3QgaW52X21wdTYwNTBf
cmVhZF9maWZvKGludCBpcnEsIHZvaWQgKnApCj4+ICAJdTMyIGZpZm9fcGVyaW9kOwo+PiAgCXM2
NCB0aW1lc3RhbXA7Cj4+ICAJdTggZGF0YVtJTlZfTVBVNjA1MF9PVVRQVVRfREFUQV9TSVpFXTsK
Pj4gLQlpbnQgaW50X3N0YXR1czsKPj4gIAlzaXplX3QgaSwgbmI7Cj4+ICAKPj4gIAltdXRleF9s
b2NrKCZzdC0+bG9jayk7Cj4+ICAKPj4gLQkvKiBhY2sgaW50ZXJydXB0IGFuZCBjaGVjayBzdGF0
dXMgKi8KPj4gLQlyZXN1bHQgPSByZWdtYXBfcmVhZChzdC0+bWFwLCBzdC0+cmVnLT5pbnRfc3Rh
dHVzLCAmaW50X3N0YXR1cyk7Cj4+IC0JaWYgKHJlc3VsdCkgewo+PiAtCQlkZXZfZXJyKHJlZ21h
cF9nZXRfZGV2aWNlKHN0LT5tYXApLAo+PiAtCQkJImZhaWxlZCB0byBhY2sgaW50ZXJydXB0XG4i
KTsKPj4gLQkJZ290byBmbHVzaF9maWZvOwo+PiAtCX0KPj4gLQlpZiAoIShpbnRfc3RhdHVzICYg
SU5WX01QVTYwNTBfQklUX1JBV19EQVRBX1JEWV9JTlQpKQo+PiAtCQlnb3RvIGVuZF9zZXNzaW9u
Owo+PiAtCj4+ICAJaWYgKCEoc3QtPmNoaXBfY29uZmlnLmFjY2xfZmlmb19lbmFibGUgfAo+PiAg
CQlzdC0+Y2hpcF9jb25maWcuZ3lyb19maWZvX2VuYWJsZSB8Cj4+ICAJCXN0LT5jaGlwX2NvbmZp
Zy5tYWduX2ZpZm9fZW5hYmxlKSkKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9pbnZf
bXB1NjA1MC9pbnZfbXB1X3RyaWdnZXIuYyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfbXB1NjA1MC9p
bnZfbXB1X3RyaWdnZXIuYwo+PiBpbmRleCBlYzIzOThhODdmNDUuLjdmZmJiOWU3YzEwMCAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfdHJpZ2dlci5j
Cj4+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfbXB1NjA1MC9pbnZfbXB1X3RyaWdnZXIuYwo+
PiBAQCAtNiw2ICs2LDcgQEAKPj4gICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+Cj4+ICAK
Pj4gICNpbmNsdWRlIDxsaW51eC9paW8vY29tbW9uL2ludl9zZW5zb3JzX3RpbWVzdGFtcC5oPgo+
PiArI2luY2x1ZGUgPGxpbnV4L2lpby9ldmVudHMuaD4KPj4gIAo+PiAgI2luY2x1ZGUgImludl9t
cHVfaWlvLmgiCj4+ICAKPj4gQEAgLTIyMyw2ICsyMjQsNTIgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBpaW9fdHJpZ2dlcl9vcHMgaW52X21wdV90cmlnZ2VyX29wcyA9IHsKPj4gIAkuc2V0X3RyaWdn
ZXJfc3RhdGUgPSAmaW52X21wdV9kYXRhX3JkeV90cmlnZ2VyX3NldF9zdGF0ZSwKPj4gIH07Cj4+
ICAKPj4gK3N0YXRpYyBpcnFyZXR1cm5fdCBpbnZfbXB1NjA1MF9pbnRlcnJ1cHRfdGltZXN0YW1w
KGludCBpcnEsIHZvaWQgKnApCj4+ICt7Cj4+ICsJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9
IHA7Cj4+ICsJc3RydWN0IGludl9tcHU2MDUwX3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rl
dik7Cj4+ICsKPj4gKwlzdC0+aXRfdGltZXN0YW1wID0gaWlvX2dldF90aW1lX25zKGluZGlvX2Rl
dik7Cj4+ICsKPj4gKwlyZXR1cm4gSVJRX1dBS0VfVEhSRUFEOwo+Cj5JIHRoaW5rIHlvdSBjYW4g
dXNlIGlpb19wb2xsZnVuY19zdG9yZV90aW1lKCkuCgpUaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQg
aW50ZXJydXB0IGNhbiBoYXBwZW4gd2l0aG91dCBidWZmZXIvdHJpZ2dlciBvbiwgd2hlbiBvbmx5
IFdvTSBpcyBvbi4KSW4gbXkgdW5kZXJzdGFuZGluZywgcG9sbCBmdW5jdGlvbiBpcyBub3QgYXR0
YWNoZWQgd2hlbiBidWZmZXIgaXMgb2ZmIGFuZCBwb2xsIGZ1bmN0aW9uIGlzIE5VTEwuCgo+Cj4+
ICt9Cj4+ICsKPj4gK3N0YXRpYyBpcnFyZXR1cm5fdCBpbnZfbXB1NjA1MF9pbnRlcnJ1cHRfaGFu
ZGxlKGludCBpcnEsIHZvaWQgKnApCj4+ICt7Cj4+ICsJc3RydWN0IGlpb19kZXYgKmluZGlvX2Rl
diA9IHA7Cj4+ICsJc3RydWN0IGludl9tcHU2MDUwX3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlv
X2Rldik7Cj4+ICsJdW5zaWduZWQgaW50IGludF9zdGF0dXMgPSAwOwo+PiArCWludCByZXN1bHQ7
Cj4+ICsKPj4gKwltdXRleF9sb2NrKCZzdC0+bG9jayk7Cj4+ICsKPj4gKwkvKiBhY2sgaW50ZXJy
dXB0IGFuZCBjaGVjayBzdGF0dXMgKi8KPj4gKwlyZXN1bHQgPSByZWdtYXBfcmVhZChzdC0+bWFw
LCBzdC0+cmVnLT5pbnRfc3RhdHVzLCAmaW50X3N0YXR1cyk7Cj4+ICsJaWYgKHJlc3VsdCkgewo+
PiArCQlkZXZfZXJyKHJlZ21hcF9nZXRfZGV2aWNlKHN0LT5tYXApLAo+PiArCQkJImZhaWxlZCB0
byBhY2sgaW50ZXJydXB0XG4iKTsKPj4gKwkJZ290byBleGl0X3VubG9jazsKPj4gKwl9Cj4+ICsK
Pj4gKwkvKiBoYW5kbGUgV29NIGV2ZW50ICovCj4+ICsJaWYgKHN0LT5jaGlwX2NvbmZpZy53b21f
ZW4gJiYgKGludF9zdGF0dXMgJiBJTlZfTVBVNjUwMF9CSVRfV09NX0lOVCkpCj4+ICsJCWlpb19w
dXNoX2V2ZW50KGluZGlvX2RldiwKPj4gKwkJCSAgICAgICBJSU9fVU5NT0RfRVZFTlRfQ09ERShJ
SU9fQUNDRUwsIDAsIElJT19FVl9UWVBFX01BR19BREFQVElWRSwKPj4gKwkJCQkJCSAgICBJSU9f
RVZfRElSX1JJU0lORyksCj5NYXliZSBzaG91bGQgYmUgbW9kaWZpZWQuCj4KPkhtbS4gSXMgdGhp
cyBtYWduaXR1ZGUgb2YgdGhlIG92ZXJhbGwgYWNjZWxlcmF0aW9uIG9yIGlzIGl0IGEgcGVyIGNo
YW5uZWwgdGhpbmc/Cj4KPklmIGl0J3Mgb3ZlcmFsbCB0aGVuIHdlIG5lZWQgdG8ga25vdyBob3cg
dGhleSBhcmUgY29tYmluZWQgdG8gZGVzY3JpYmUgdGhpcyByaWdodC4KPklmIGl0J3MgYW4gWCBv
ciBZIG9yIFogdGhpbmcgd2UgZG8gaGF2ZSBhIG1vZGlmaWVyIGZvciB0aGF0IHRob3VnaCBJIGtp
bmQgb2YKPnJlZ3JldCBhZGRpbmcgdGhhdCBhbmQgd2lzaCBub3cgd2UnZCBqdXN0IGFsd2F5cyBy
ZXBvcnRlZCAzIGV2ZW50cy4KPihwcm9ibGVtIHdpdGggdGhvc2UgWF9PUl9ZX09SX1ogbW9kaWZp
ZXJzIGlzIHRoZXkgZG9uJ3QgZ2VuZXJhbGl6ZSB3ZWxsKQo+CgpUaGlzIGFuIE9SIG9mIHRoZSAz
IGF4ZXMuIFdlIGNhbiB1c2UgWF9PUl9ZX09SX1ogdGhlbi4KCj4+ICsJCQkJc3QtPml0X3RpbWVz
dGFtcCk7Cj4+ICsKPj4gK2V4aXRfdW5sb2NrOgo+PiArCW11dGV4X3VubG9jaygmc3QtPmxvY2sp
Owo+PiArCj4+ICsJLyogaGFuZGxlIHJhdyBkYXRhIGludGVycnVwdCAqLwo+PiArCWlmIChpbnRf
c3RhdHVzICYgSU5WX01QVTYwNTBfQklUX1JBV19EQVRBX1JEWV9JTlQpIHsKPj4gKwkJaW5kaW9f
ZGV2LT5wb2xsZnVuYy0+dGltZXN0YW1wID0gc3QtPml0X3RpbWVzdGFtcDsKPgo+QXMgYWJvdmUs
IHdoeSBub3QgdXNlIHRoZSBzdGFuZGFyZCBmdW5jdGlvbiBmb3IgdGhpcy4KPkkgZG9uJ3QgdGhp
bmsgYW55dGhpbmcgd2lsbCBoYXZlIGNsZWFyZWQgaXQuCgpXZSBuZWVkIHRvIHVzZSB0aGUgdGlt
ZXN0YW1wIHRha2VuIGluIHRoZSBoYXJkIGludGVycnVwdCBoYW5kbGVyLCB0aGF0J3Mgd2h5IEkg
YW0gbm90IGNhbGxpbmcgaWlvX3BvbGxmdW5jX3N0b3JlX3RpbWUgaGVyZS4KQW5kIEkgYW0gbm90
IGNhbGxpbmcgaXQgaW4gdGhlIGhhcmQgaGFuZGxlciBiZWNhdXNlIGluIG15IHVuZGVyc3RhbmRp
bmcgcG9sbCBmdW5jdGlvbiBpcyBub3QgYXR0YWNoZWQgd2hlbiBidWZmZXIgaXMgb2ZmLgoKPgo+
PiArCQlpaW9fdHJpZ2dlcl9wb2xsX25lc3RlZChzdC0+dHJpZyk7Cj4+ICsJfQo+PiArCj4+ICsJ
cmV0dXJuIElSUV9IQU5ETEVEOwo+PiArfQo+PiArCj4+ICBpbnQgaW52X21wdTYwNTBfcHJvYmVf
dHJpZ2dlcihzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LCBpbnQgaXJxX3R5cGUpCj4+ICB7Cj4+
ICAJaW50IHJldDsKPj4gQEAgLTIzNSwxMSArMjgyLDEwIEBAIGludCBpbnZfbXB1NjA1MF9wcm9i
ZV90cmlnZ2VyKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsIGludCBpcnFfdHlwZSkKPj4gIAlp
ZiAoIXN0LT50cmlnKQo+PiAgCQlyZXR1cm4gLUVOT01FTTsKPj4gIAo+PiAtCXJldCA9IGRldm1f
cmVxdWVzdF9pcnEoJmluZGlvX2Rldi0+ZGV2LCBzdC0+aXJxLAo+PiAtCQkJICAgICAgICZpaW9f
dHJpZ2dlcl9nZW5lcmljX2RhdGFfcmR5X3BvbGwsCj4+IC0JCQkgICAgICAgaXJxX3R5cGUsCj4+
IC0JCQkgICAgICAgImludl9tcHUiLAo+PiAtCQkJICAgICAgIHN0LT50cmlnKTsKPj4gKwlyZXQg
PSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKCZpbmRpb19kZXYtPmRldiwgc3QtPmlycSwKPj4g
KwkJCQkJJmludl9tcHU2MDUwX2ludGVycnVwdF90aW1lc3RhbXAsCj4+ICsJCQkJCSZpbnZfbXB1
NjA1MF9pbnRlcnJ1cHRfaGFuZGxlLAo+PiArCQkJCQlpcnFfdHlwZSwgImludl9tcHUiLCBpbmRp
b19kZXYpOwo+PiAgCWlmIChyZXQpCj4+ICAJCXJldHVybiByZXQ7Cj4+ICAKPg==

