Return-Path: <linux-iio+bounces-3020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB17986267B
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 18:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81661282932
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DD7481B8;
	Sat, 24 Feb 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="lE+ARnPF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8A41C6D;
	Sat, 24 Feb 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708797069; cv=fail; b=Zn8uSUhSessPFwpaSiCeMgiVn2a2UAQvHDSStxOZQEPuUiXQgT9AaLRUCwudJ0PzrGuH6xJwAHU2J7FjwueuZ8LCxtO/vt2XqCVVbhHNRAUcQHeEb61AjWs/SzYYr18P49TFiFe41bXVEZn2+hKqqnZzRZuDftg8/LUvBM+RpZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708797069; c=relaxed/simple;
	bh=uAVIADSMdttYyXaWQt4z1Xw7Y2T+R11QbXkDlmtpAGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XBJUOl2AGe9W0/u+89Ht3OodsSnZX+ErC+IcGxvlEAosD1YvTw0mvYQ5uy1aS2MUPB6RQ/BVr8shLyswc3UrfpwrkB/Q5ikdPxuSPyL6gtfMi74R7Mx47qUO5yQNAYhS/2148fiKNLpS2g6sxutnreA0tv1gxrIDZAtszmJJrR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=lE+ARnPF; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41OHU1cH002167;
	Sat, 24 Feb 2024 17:50:34 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2168.outbound.protection.outlook.com [104.47.11.168])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wf9tjr5p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 17:50:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gehJ4JGwsU4DpAhYZ97bfDqlKora6f0pq5BOSfCowM8KsDBnjrFEz0nTMha0pD/G6v07GmrWXzMjU9ZspD0bz3ir5juM6nWfP/bHK1tg/jcGwwuG8vkL7OSULfmuRxckdDbD8goKuVqw7Az8IV7rPA0UtUKJEJT/9g0adB1kaiMr0WqW+dgu6+T6DRoqUhqDOjzeY7zuJ8QjaDpzoxuxsyg0Q3OycvjURM0ODVrK3lXuWHeUMwBUgwVL3plSe8muOHRtgIJseOAxmXtoftt0heSFAg08coadCJcc3OaIk7y2r2+Em0kyowRxmmZ6S6+GhsDo0wCKV/Hf+w7FhXmpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAVIADSMdttYyXaWQt4z1Xw7Y2T+R11QbXkDlmtpAGo=;
 b=mhO2u1HUIatAtcDzWTzevX3rzYxiTEbUX7r2RA3zl6XqF6WyUcTdKIC5MGHXZgqfnHOTLZFHndBrHwrlKhGyu0jyRqpYw4Xz1NyLY7w5XTGKnbauT/IRW784X6Q45MyuNJ4z2j6KMw4VRlWBmaQerxhS/LWE4e7djdhX93dzvJa4HKDyTZTuLmBL8arB+3TbGF1GqqT6Lqq7v8Owt2ciLCMrkcKEoJJoyecO7rrnjRfM2da+0EPODzROQeZoJcgI13RQGTs8vv3hE7fGzsSXd1KEwOBiYE6yWhbnTLRpliodSC8dfenLjVZXFEkCYOKQtsloVdstrM1mQOwUX+fFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAVIADSMdttYyXaWQt4z1Xw7Y2T+R11QbXkDlmtpAGo=;
 b=lE+ARnPFXG3rG6paoCoD4LXE5HMfpH/uCijwq27woAwBhrXQ69rAkgsRL7MyHz8S+T7jTzmf8XXGFpctCK/an7TQYlpVpy18ZE3tq5DYRODAv2i1uaBdPcvd/Pb6/zY73i6YDMW133kH89Ae3v9RP82JIpx+plPtNHaTK0bjptEKsl/aQeZEdK/E75MneO9mPHpqOS57MWRW1ZUfai3bF6B5ux5CAm2Nr87RCvUvxemGgh2vfbIjn/5FXmVzcXfgaZ3Tzm68nHWX5MVNvEXt5WC1duA+VdjWssFUHGKRXkO6SL80f4BiefCrKlmoqTH/Gjqh6nU1KYixTDMYT+zaMQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB2814.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:3a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Sat, 24 Feb
 2024 17:50:27 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::62a6:a782:3c39:50d3]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::62a6:a782:3c39:50d3%4]) with mapi id 15.20.7316.032; Sat, 24 Feb 2024
 17:50:26 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        INV Git Commit
	<INV.git-commit@tdk.com>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: fix frequency setting when chip
 is off
Thread-Topic: [PATCH v2] iio: imu: inv_mpu6050: fix frequency setting when
 chip is off
Thread-Index: AQHaY0sS6w3NOlI4gEu4oAtM+N2QdLEZtKMAgAAVhqU=
Date: Sat, 24 Feb 2024 17:50:26 +0000
Message-ID: 
 <FR3P281MB1757A98D6B0EC6B48526C849CE542@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240219154741.90601-1-inv.git-commit@tdk.com>
 <20240224162208.02d28bcd@jic23-huawei>
In-Reply-To: <20240224162208.02d28bcd@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR2P281MB2814:EE_
x-ms-office365-filtering-correlation-id: 970a2ced-ed33-4130-5ddf-08dc35611539
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /5kQ1a4eisculrpXl84CKaqhGABrkcO+AKDAAvINathg26LwETiGWU5euoQ3ia3JUDwFGTIBHVFfHMJSXtMWQ37dqP75Ygz62GFrpuXDQZzpW94GrXDtJvAjJ08NN3t7uRcEIIe9kCpdqjqv7w85rqQPpIiFwX+5QA1n/jC5pU5XBzU1swAPGmOOtPe2v18rHrs2SPo3F1OsKyYeGQ6/79vZY9zuNoY4q7WpXrMPhx9ROpkMzUq0VBeBB8WtX53qfxQWfS1RcDg3swhO3cezZqfKwK5Dc7hRyIso4f22zgBFa+19zr4Szt62YuZSqzS4HTByHhiqDC9g4MBz+tDRSi4alvfgYjEuMbDLeHqI2UGHaET4JVop7OhIpbvR3a/YvcIzZLv7/inRrMrYicSu5TLYU7Jby8fEHDH00ngwPPX67ZkjDTAbDAVtTn3mmMHn/iYeZf9X1NxxtloSGBJ5cuq4OV0aGYXLx+aA3sFieD+6pvSnK2FzpEe3RPEgT76Hh3Ol7p0VQqsb8FGvkAXYgby2C5RaH2HHHqDg3Zn17NT90jftV1kSVhYMi+CKwkIQTA32/ML+W+MNfkxtjZMV/IbFFw58f5eb8m4iQuOosFF4TBrRL6apwdlCgb7ScG3cFtQe6qJygC0GkMoKNl4XLA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009)(3613699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MWRoV1hOU1lKbGZiVnJ4dGZ6bGlTZEpac3d6VGM0U2ZOTUFPcTBFeUhTUkhs?=
 =?utf-8?B?YXM1UHV4emJwMVpxeEJ5clVzZ29CdEFFU01HVlEzZ3JQeFpQTWRTRHlpak83?=
 =?utf-8?B?b3R5QlRXVFJiMjNUdXZvS1BmM3gzdERBK05JZFk4RDJVeWh1L0w5UWVJNU9a?=
 =?utf-8?B?MDI1SjBUMFZqc1R3ZmZxY3UxMFM0TVU5VWZhVUlUVEJyRjh1ZHRBVE5EMExO?=
 =?utf-8?B?SXY5WVE3dTQ4NTgwc3BrL1Q2Ymh3R1FyemRZbGRGZ01tZGh0N01wK3hZMlBG?=
 =?utf-8?B?aGFjQnExLzF2VVV5a1FjbzNlZDM2MG5lUVVFVWFZQzIxVjJBVFBxaDJpOFUw?=
 =?utf-8?B?dE1KNGdwLy9kbkxPemtVYmZJeFJab2x6VnVNalRpRjJlOUtsb3lMMzV0ekZN?=
 =?utf-8?B?MUU3Y1FOaCtnWENlK3hlTUVLbjAxZDBJa0V3a015L3BqalpOK1BvTmdoRmhz?=
 =?utf-8?B?QWV5cUVKcGhtSXB2aHFNd0tMK05RNERRbzNHOEt5bHM0UG9SOEdRYnVNSzlt?=
 =?utf-8?B?Y21FMzVHazhaU3ZKZnVkYTcwMXV1d2Mxc0tMWm9uMWw4RzhPVDFRMVU2UXpP?=
 =?utf-8?B?Wkdueno3MjBySG91Nm1yL0RLYjlCNk1vYURKWk1DcTlha1NabmRNQUl5Z0VR?=
 =?utf-8?B?bWpTSG12VmVrSFF1TzNYWDdqN2lkM29FYVF5MzBZZUE4d2h0NlgxK2pBbkdP?=
 =?utf-8?B?MWFyc1pNNHc3djJqemdUTktHNWNWLzNzSjZiVStRbEFKMzBQTEtXUGttamxl?=
 =?utf-8?B?RlB2eVBNWEQrUlpGNmlGd3pHQWxDa0ZvbnJjR1pKSzJ5TGdERVRQMHBmei9l?=
 =?utf-8?B?ZS95REVkcnZCWWVYNmdKajg0TlhTWjdoMmVzanllWTVnVzJyNzJuZlJjKzN1?=
 =?utf-8?B?TmgvdjFpTDEvS0w2RUt2NWdxcWpwLzFsWFhETFZXMm1XYTY2VE5mejYvSThG?=
 =?utf-8?B?RlczT3VKVEYwSDdLbWdGMGRSdnlydnhDRFBXdXR0SkMyejdoSFlHZDVsMnZW?=
 =?utf-8?B?cmZaYW54WlR6ZVFVNE9VT0ZxMm1lbUxkKzdoOGlpbTlMYnRHSDJYMkJoZnpH?=
 =?utf-8?B?MjVPSkZIWjBnQ0x5WWc1dHJ2RDlBRHlPS2JhbE9FdXJQeXVvRm1aS1Zmcm5N?=
 =?utf-8?B?YU5vcU1BSVgyTitqbUlEY2V3aW85QmdSa3VHaC83R0FqaHFWdU0vY0RqU3ZZ?=
 =?utf-8?B?aXFXMjM1M3ZSNi9Ma3o5aDVhM29DbDQ5eDd1eE9Yb1o3akhNUStubjFveDlU?=
 =?utf-8?B?dkswSnVWN0xDVXMyRWl4VVBhcXZaUitTNmMzRFp5djhScStBUnBESHdjckQv?=
 =?utf-8?B?N205SVhlOGhmTDFVeGdockNvSWhvNG1DTXg4NmNTdXgxa2V6ZWdQdGhaZ04w?=
 =?utf-8?B?eTVOR0dGc2h5KzZsam15dkFPN1l5N3dZWHJmQUhjTFZJMHBxa3Q5TkFYS3VT?=
 =?utf-8?B?aUI4YVZhWXB5alhZMTBHaE5HOU9KNTFCOVgvazJ1TWdUSmliODNkeG1KV0Ur?=
 =?utf-8?B?UW1NWU14d09JL0xGbmhXVUduTVNKUW5QMEZSQmVuc2VrTllIK05PZXhyd1Ra?=
 =?utf-8?B?cmsxT1B1STdKZ0tTYk44bzRrRlk5Q0dLN0tCbmdIZTFncmZzc1JTVDZQUVN1?=
 =?utf-8?B?SlJYY0c2VDN3U3I3RitQLzdBQWR6WHhyTFRkaGwxVFg1YkpNYWZGSzY5M2pJ?=
 =?utf-8?B?R0NKemtvdEtsRHRYL0h5RWdaSDhIRnJ3UlFPOWFQdDR3OGxQazlSeVoxUHR2?=
 =?utf-8?B?bjY0alZCcHR3UmRCenl3WU1KRGptOUR6TVYrVzRNdDRCdFFpeUFEOFpySDNI?=
 =?utf-8?B?amRhdWRsS2ppMWM2SEk2bFRCdDRMUzJjWHRTdWtuY1RPSm9laFdvSTBFaHJt?=
 =?utf-8?B?WnZ5N1FiYzBoTG9zV0Q4SHFCQkVyUUo1ckgybXdPTHA3M1BQdEo4QzR4ZmV0?=
 =?utf-8?B?Z0dDcWNhREJxSTVJVG9QTndhcnprM3Z6UDE2KzhqTVFNZVRIa2NDaCs4K1V0?=
 =?utf-8?B?a1JZdFlEU29NZlJnT2NYMVBjVnpMMDBSVlRJVUNtTmI1SS9RL3lXTlRuMG1y?=
 =?utf-8?B?a1pBaHc5ell2dUwzZjBCanl4QVNpYUJTS0FWYldpTmp0N3g1YTl0V280OEky?=
 =?utf-8?B?T0tqeG1DbVRGMmJpTkp5QVM4QlpEbkdWYnFLdjlhcHdUeklWWGNOR2hROEps?=
 =?utf-8?B?WXJuNnhXc2x0MkVDVXBYOFZQeVB2bWZ0NS9mM1ZYcktLQzBaUEdod3ZqOU1l?=
 =?utf-8?B?ZWxLTmk2NG5mTUgrUjhlOWs1T1hnPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 970a2ced-ed33-4130-5ddf-08dc35611539
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2024 17:50:26.3697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CywXLzU4Q+oA3wcX5ubCjRTBE9o8kUWwIph8H8vWlEMXVS+QMHIMslXmbbRi03A/IxD740NVyKaDLzzPkWanL0PLrl8orVbnthsy25xfZcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2814
X-Proofpoint-GUID: pOgjrgWTyxPGV_2T9BE477ogKd1rfdc9
X-Proofpoint-ORIG-GUID: pOgjrgWTyxPGV_2T9BE477ogKd1rfdc9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_13,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402240149

SGVsbG8gSm9uYXRoYW4sCgp0aGUgcHJvYmxlbSBjb21lcyBmcm9tIHRoZSBmaWZvIHJhdGUgc2V0
dGluZyBjb2RlIHRoYXQgaXMgbm93IHVzaW5nIHRoZXNlIHN0YXRlcyB0byBjb21wdXRlIGlmIEZJ
Rk8gaXMgb246CmZpZm9fb24gPSBzdC0+Y2hpcF9jb25maWcuYWNjbF9maWZvX2VuYWJsZSB8fAog
ICAgICAgICAgc3QtPmNoaXBfY29uZmlnLmd5cm9fZmlmb19lbmFibGUgfHwKICAgICAgICAgIHN0
LT5jaGlwX2NvbmZpZy5tYWduX2ZpZm9fZW5hYmxlOwpyZXN1bHQgPSBpbnZfc2Vuc29yc190aW1l
c3RhbXBfdXBkYXRlX29kcigmc3QtPnRpbWVzdGFtcCwgZmlmb19wZXJpb2QsIGZpZm9fb24pOwpp
ZiAocmVzdWx0KQogICAgICAgIGdvdG8gZmlmb19yYXRlX2ZhaWxfdW5sb2NrOwoKSXQgd2FzIG5v
dCB0aGUgY2FzZSBiZWZvcmUgdXNpbmcgdGhlIGludl9zZW5zb3JzX3RpbWVzdGFtcCBtb2R1bGUu
CgpJZiB3ZSBkb24ndCBzZXQgdGhlc2Ugc3RhdGVzIGJhY2sgdG8gZmFsc2UsIGl0IGlzIG5vdCBw
b3NzaWJsZSB0byBjaGFuZ2UgZnJlcXVlbmN5IG1vcmUgdGhhbiAxIHRpbWUuIFRoaXMgcmVzdHJp
Y3Rpb24gY29tZXMgZnJvbSBpbnZfc2Vuc29yc190aW1lc3RhbXAgbW9kdWxlIHRoYXQgaXMgbm90
IGFibGUgdG8gaGFuZGxlIGFjY3VyYXRlbHkgbW9yZSB0aGFuIDEgZnJlcXVlbmN5IGNoYW5nZSB3
aGVuIHNlbnNvciBGSUZPIGlzIG9uLiBUaGlzIHJlc3RyaWN0aW9uIG9idmlvdXNseSBkb2Vzbid0
IGV4aXN0IHdoZW4gRklGTyBpcyBvZmYuCgpUaGFua3MsCkpCCgoKRnJvbTogSm9uYXRoYW4gQ2Ft
ZXJvbiA8amljMjNAa2VybmVsLm9yZz4KU2VudDogU2F0dXJkYXksIEZlYnJ1YXJ5IDI0LCAyMDI0
IDE3OjIyClRvOiBJTlYgR2l0IENvbW1pdCA8SU5WLmdpdC1jb21taXRAdGRrLmNvbT4KQ2M6IGxh
cnNAbWV0YWZvby5kZSA8bGFyc0BtZXRhZm9vLmRlPjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9y
ZyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgPHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc+OyBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxKZWFuLUJhcHRp
c3RlLk1hbmV5cm9sQHRkay5jb20+ClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGlpbzogaW11OiBp
bnZfbXB1NjA1MDogZml4IGZyZXF1ZW5jeSBzZXR0aW5nIHdoZW4gY2hpcCBpcyBvZmYgCsKgCk9u
IE1vbiwgMTkgRmViIDIwMjQgMTU64oCKNDc64oCKNDEgKzAwMDAgaW52LuKAimdpdC1jb21taXRA
4oCKdGRrLuKAimNvbSB3cm90ZTogPiBGcm9tOiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxqZWFu
LWJhcHRpc3RlLuKAim1hbmV5cm9sQOKAinRkay7igIpjb20+ID4gPiBUcmFjayBjb3JyZWN0bHkg
RklGTyBzdGF0ZSBhbmQgYXBwbHkgT0RSIGNoYW5nZSBiZWZvcmUgc3RhcnRpbmcgPiB0aGUgY2hp
cC4gV2l0aG91dCB0aGUgZml4LCAKWmpRY21RUllGcGZwdEJhbm5lclN0YXJ0ClRoaXMgTWVzc2Fn
ZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlciAKVGhpcyBtZXNzYWdlIGNhbWUgZnJvbSBvdXRz
aWRlIHlvdXIgb3JnYW5pemF0aW9uLiAKwqAKWmpRY21RUllGcGZwdEJhbm5lckVuZApPbiBNb24s
IDE5IEZlYiAyMDI0IDE1OjQ3OjQxICswMDAwCmludi5naXQtY29tbWl0QHRkay5jb20gd3JvdGU6
Cgo+IEZyb206IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgPGplYW4tYmFwdGlzdGUubWFuZXlyb2xA
dGRrLmNvbT4KPiAKPiBUcmFjayBjb3JyZWN0bHkgRklGTyBzdGF0ZSBhbmQgYXBwbHkgT0RSIGNo
YW5nZSBiZWZvcmUgc3RhcnRpbmcKPiB0aGUgY2hpcC4gV2l0aG91dCB0aGUgZml4LCB5b3UgY2Fu
bm90IGNoYW5nZSBPRFIgbW9yZSB0aGFuIDEgdGltZQo+IHdoZW4gZGF0YSBidWZmZXJpbmcgaXMg
b2ZmLgoKSGkgSmVhbi1CYXB0aXN0ZS4KCkkgdGhpbmsgdGhpcyBwYXRjaCBuZWVkcyBhIGxpdHRs
ZSBtb3JlIGV4cGxhbmF0aW9uLgoxKSBXaHkgaGFzIHN0YXRlIGNoYW5nZWQgc3VjaCB0aGF0IHdl
IG5lZWQgdG8gdXBkYXRlIHRoZXNlIGNhY2hlZCB2YWx1ZXM/CjIpIFdoYXQgZG9lcyB0aGF0IGhh
dmUgdG8gZG8gd2l0aCBPRFIgLSBvciBpcyB0aGlzIHR3byB1bnJlbGF0ZWQgZml4ZXM/CgpJJ20g
c3VyZSB0aGUgZml4IGlzIHJpZ2h0IC0gSSBqdXN0IGRvbid0IGZ1bGx5IHVuZGVyc3RhbmQgdGhl
IGlzc3VlcyEKPiAKPiBGaXhlczogMTExZTFhYmQwMDQ1ICgiaWlvOiBpbXU6IGludl9tcHU2MDUw
OiB1c2UgdGhlIGNvbW1vbiBpbnZfc2Vuc29ycyB0aW1lc3RhbXAgbW9kdWxlIikKPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZwo+IFNpZ25lZC1vZmYtYnk6IEplYW4tQmFwdGlzdGUgTWFuZXly
b2wgPGplYW4tYmFwdGlzdGUubWFuZXlyb2xAdGRrLmNvbT4KPiAtLS0KPiBWMjogYWRkIG1pc3Np
bmcgc3RhYmxlIHRhZwo+IAo+ICBkcml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAvaW52X21wdV90
cmlnZ2VyLmMgfCA1ICsrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPiAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfdHJpZ2dl
ci5jIGIvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfdHJpZ2dlci5jCj4gaW5k
ZXggNjc2NzA0ZjkxNTFmLi5lNmU2ZTk0NDUyYTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9paW8v
aW11L2ludl9tcHU2MDUwL2ludl9tcHVfdHJpZ2dlci5jCj4gKysrIGIvZHJpdmVycy9paW8vaW11
L2ludl9tcHU2MDUwL2ludl9tcHVfdHJpZ2dlci5jCj4gQEAgLTExMSw2ICsxMTEsNyBAQCBpbnQg
aW52X21wdTYwNTBfcHJlcGFyZV9maWZvKHN0cnVjdCBpbnZfbXB1NjA1MF9zdGF0ZSAqc3QsIGJv
b2wgZW5hYmxlKQo+ICAJaWYgKGVuYWJsZSkgewo+ICAJCS8qIHJlc2V0IHRpbWVzdGFtcGluZyAq
Lwo+ICAJCWludl9zZW5zb3JzX3RpbWVzdGFtcF9yZXNldCgmc3QtPnRpbWVzdGFtcCk7Cj4gKwkJ
aW52X3NlbnNvcnNfdGltZXN0YW1wX2FwcGx5X29kcigmc3QtPnRpbWVzdGFtcCwgMCwgMCwgMCk7
Cj4gIAkJLyogcmVzZXQgRklGTyAqLwo+ICAJCWQgPSBzdC0+Y2hpcF9jb25maWcudXNlcl9jdHJs
IHwgSU5WX01QVTYwNTBfQklUX0ZJRk9fUlNUOwo+ICAJCXJldCA9IHJlZ21hcF93cml0ZShzdC0+
bWFwLCBzdC0+cmVnLT51c2VyX2N0cmwsIGQpOwo+IEBAIC0xODQsNiArMTg1LDEwIEBAIHN0YXRp
YyBpbnQgaW52X21wdTYwNTBfc2V0X2VuYWJsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LCBi
b29sIGVuYWJsZSkKPiAgCQlpZiAocmVzdWx0KQo+ICAJCQlnb3RvIGVycm9yX3Bvd2VyX29mZjsK
PiAgCX0gZWxzZSB7Cj4gKwkJc3QtPmNoaXBfY29uZmlnLmd5cm9fZmlmb19lbmFibGUgPSAwOwo+
ICsJCXN0LT5jaGlwX2NvbmZpZy5hY2NsX2ZpZm9fZW5hYmxlID0gMDsKPiArCQlzdC0+Y2hpcF9j
b25maWcudGVtcF9maWZvX2VuYWJsZSA9IDA7Cj4gKwkJc3QtPmNoaXBfY29uZmlnLm1hZ25fZmlm
b19lbmFibGUgPSAwOwpJIHRoaW5rIHRoZSB3cml0ZSB0byBhY3R1YWxseSBkbyB0aGlzIGlzIGlu
IHByZXBhcmVfZmlmbyBhbmQgaXQncyBub3QKY29uZGl0aW9uYWwgb24gdGhlc2UsIHNvIHdoeSBk
byB3ZSBjYXJlPwoKQXJlIHRoZXNlIGVmZmVjdGl2ZWx5IHBhaXJlZCB3aXRoIGludl9zY2FuX3F1
ZXJ5IGluIHRoZSBlbmFibGUgcGF0aD8KCgo+ICAJCXJlc3VsdCA9IGludl9tcHU2MDUwX3ByZXBh
cmVfZmlmbyhzdCwgZmFsc2UpOwo+ICAJCWlmIChyZXN1bHQpCj4gIAkJCWdvdG8gZXJyb3JfcG93
ZXJfb2ZmOwo+IC0tCj4gMi4zNC4xCj4gCgo=

