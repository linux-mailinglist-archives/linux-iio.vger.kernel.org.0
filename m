Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC9F1946C2
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 19:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgCZSrR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 14:47:17 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:62396 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbgCZSrR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 14:47:17 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QIihQb003131;
        Thu, 26 Mar 2020 14:47:14 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywfj702pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 14:47:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9IHyxXDnuRDS0hHLX4ORjiKpbwBVsdkijhebD/P3T9ok+O8CIHza0hjaAXRShaQfU9XI4O0q8UREBqM3ktbKA7jQsnjDM8G9kkpL2zpiQC9p+mzvp8VL/yDNyNwtNQWGR5/MMSWwFKXQANhAo1/E5mFlGqIqG0+7Cm75iOe6gr5nx0uVm4jVGnyPwSkerNhvuECZeQjI1fQHMlEvcWIzokMaobL1e7hqeGGJXIQ2KDcRJkbwvEk2hU6l3nuMBvlmp71ihIis3aUAlIew0Seaaxuh05KpKdLw5q5osSVYMYjdkbgbAs1ECbBm7ZJeyGTSg1mQORlPsjv2gA0z+IX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE0XDXQ/qwUWwjGrG+S8ko/4royFT6s4csSl4jxBhcw=;
 b=oMjdf6lfkibGGGTBCsytYq7ckg/b6QOJLzQSZdq3B6PqF6zWyvNL44z+a3yjX5jJtK3GjKSY2dcAQy2SglTrv7Y1nc91hkzUkii8BWS+pBPXKsTkxbWvBbA1NQADhwZ+1moGBY8XZqoy41pfxihXmsUBWWOktJCRHym9w/J9gv8OXEqNe5EopNoDa0n+wszYCBHlQgr6Zx3r2WGvn9F/AHlkyleuoGl3oAMLsypz7ZHn4hQfS8pMPNTojtOZ/WU8G362t2Yv2ZQdUWlNUP9Ou7WowsmPqRMPUyVnDNmrnHLqKogCUivUqZuwWTcV7ammikWIAtyfcR2CrSz+tFN5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE0XDXQ/qwUWwjGrG+S8ko/4royFT6s4csSl4jxBhcw=;
 b=Su0KyDi2h2DE4DyMOSFNlnj5CNrlWS+3NSrwCcvt3m7ulBN8Xu2iMxCY0VjKXXKfR96MoeCRLKSbc76bbAiJkDRFdOsDgRWHl80LmqTmzlcSsegFqsZsnN1uWP/8VnyOwuJjoIa0haItrDn0x7QA1esqcnG4IBdAv/BDz/BCjjE=
Received: from DM5PR03MB3402.namprd03.prod.outlook.com (2603:10b6:4:3d::15) by
 DM5PR03MB2475.namprd03.prod.outlook.com (2603:10b6:3:75::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Thu, 26 Mar 2020 18:47:12 +0000
Received: from DM5PR03MB3402.namprd03.prod.outlook.com
 ([fe80::5129:7d63:e7b1:1230]) by DM5PR03MB3402.namprd03.prod.outlook.com
 ([fe80::5129:7d63:e7b1:1230%4]) with mapi id 15.20.2835.017; Thu, 26 Mar 2020
 18:47:12 +0000
From:   "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
To:     Nishant Malpani <nish.malpani25@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [RFC] IIO Driver for GSoC 2020
Thread-Topic: [RFC] IIO Driver for GSoC 2020
Thread-Index: AQHWA5TNZUcR5C6i606M2rRMqLH3MKhbNijA
Date:   Thu, 26 Mar 2020 18:47:12 +0000
Message-ID: <DM5PR03MB34022FB01C7CB075EC725C4B9CCF0@DM5PR03MB3402.namprd03.prod.outlook.com>
References: <147e6ea7-5022-e131-8cec-14fa22278703@gmail.com>
In-Reply-To: <147e6ea7-5022-e131-8cec-14fa22278703@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWkdKdloyUmhibHhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MVE15WXpjek4yUm1MVFptT1RJdE1URmxZUzFoWkdGaExUQXdNak14?=
 =?utf-8?B?TldZMU9HVm1NbHhoYldVdGRHVnpkRnd6TW1NM016ZGxNUzAyWmpreUxURXha?=
 =?utf-8?B?V0V0WVdSaFlTMHdNREl6TVRWbU5UaGxaakppYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?RTRPRGtpSUhROUlqRXpNakk1TnpJeU1ETXdOakUzTmpJeU15SWdhRDBpWWsx?=
 =?utf-8?B?eVVGb3dlblZ5Vm1wamFVRlVTbmMyTVRSNVlWSXJSR2xaUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlJXOURRVUZFWmtOQ0x6RnVaMUJYUVZOMlZFeFhabmxGWVVaWFN6?=
 =?utf-8?B?bE5kRm92U1ZKdlZsbEVRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUkdGQlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGamJGTXZWbEZCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKb1FVZFJRV0ZSUW1aQlNFMUJXbEZDYWtGSVZVRmpaMEpzUVVZNFFX?=
 =?utf-8?B?TkJRbmxCUnpoQllXZENiRUZIVFVGa1FVSjZRVVk0UVZwblFtaEJSM2RCWTNk?=
 =?utf-8?B?Q2JFRkdPRUZhWjBKMlFVaE5RV0ZSUWpCQlIydEJaR2RDYkVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhSVUZhUVVKd1FVWTRRV04zUW14QlIwMUJaRkZD?=
 =?utf-8?B?ZVVGSFZVRllkMEozUVVoSlFXSjNRbkZCUjFWQldYZENNRUZJVFVGWWQwSXdR?=
 =?utf-8?B?VWRyUVZwUlFubEJSRVZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV1ZGQ2EwRkhhMEZZZDBKNlFV?=
 =?utf-8?B?ZFZRVmwzUWpGQlNFbEJXbEZDWmtGSVFVRmpaMEoyUVVkdlFWcFJRbXBCU0ZG?=
 =?utf-8?B?QlkzZENaa0ZJVVVGaFVVSnNRVWhKUVUxblFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUU5UFNJdlBqd3ZiV1Yw?=
 =?utf-8?Q?YT4=3D?=
x-dg-rorf: true
x-originating-ip: [188.27.132.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2496ce1f-2a8d-4982-fb45-08d7d1b618a1
x-ms-traffictypediagnostic: DM5PR03MB2475:
x-microsoft-antispam-prvs: <DM5PR03MB2475983427297302B8CD82049CCF0@DM5PR03MB2475.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(478600001)(966005)(7696005)(9686003)(55016002)(6506007)(8676002)(8936002)(53546011)(81166006)(81156014)(2906002)(33656002)(52536014)(110136005)(186003)(71200400001)(26005)(76116006)(66446008)(66476007)(316002)(64756008)(5660300002)(66556008)(86362001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2475;H:DM5PR03MB3402.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OrfDdLga3NYLszco4qUV/M9VeBdjbNNQv5mrWWKRzFxIafPOxJpOZM+RR8UDP9ZgmN3KDWuteV/SZItwitamMK5D3p4GNT/LuVPdTaYq6s8Ho2gdRRVlrzwupIbLXu1zGjey/Ecgm6N2im80/AllPqinaR7d3RIC2VDiZQFSJkg/C5+mD2HSFRmwCtVgqRazwPasibPkLeMbw8Xwu4j8b7VZPbVMOer3S+QNdKJZiDpWoXXGTxakyb8TvjyaYZ0cwi9k2wCELy/Z7xOYMIfXTwHChV7jBfP5UyVocw64m3xHbIsFcTFHZJ6AEC6QJrSst04RSaq723ndxEhz6b1XVHGHpBFt0hHXg+eMcPqbeOcsiZbroMi5qo8rWepFiXvK1C7Qc8Z30YX8EtTtPv7BCe1W8pBqYFU7maMFUvrtnhQbsjDjjtw2yGjD2QasrkxUj5g/mrn0uwrcQMku4iEsZlPeWWqpHGIqeSXjxKvJH9bEpgGJF3+6qTAr0Rt2TokfJetp/jrzWTC+MtrWcFOXJQ==
x-ms-exchange-antispam-messagedata: NBdQoD8NkVI5D+FQ9cCzQiokkaVWyCO0PEq1D1piSqSxsUv4hTvQe/yy4A1Gr0TZljtcL9ufygoGrVH0ZGWi3DGcah5FMohx2MtIe6aJaBl130zepXLuw3+PxTynQB34yJflOux9Et6cHVAMfjS4jw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2496ce1f-2a8d-4982-fb45-08d7d1b618a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 18:47:12.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vVgnpmzlKGtT/Nsws4bcC2vAOI2Ryug2SWnWm+eYyCHInn5CGExzxMzOt9bEhiFl6xf27vEDUo2wa60qjfAvuvXQmR98UsRsV++FMAQoJM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2475
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_10:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1011 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260140
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgTmlzaGFudCwNCg0KQW4gSUlPIGRyaXZlciBmb3IgQURYUlMyOTAgaXMgYSB2ZXJ5IGdvb2Qg
cHJvcG9zYWwuIEdvIGFoZWFkIGFuZCBzdWJtaXQgeW91ciBhcHBsaWNhdGlvbi4NCg0KVGhhbmtz
LA0KRHJhZ29zIA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTmlzaGFudCBN
YWxwYW5pIDxuaXNoLm1hbHBhbmkyNUBnbWFpbC5jb20+IA0KU2VudDogVGh1cnNkYXksIE1hcmNo
IDI2LCAyMDIwIDc6MzQgUE0NClRvOiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnDQpDYzogQm9n
ZGFuLCBEcmFnb3MgPERyYWdvcy5Cb2dkYW5AYW5hbG9nLmNvbT4NClN1YmplY3Q6IFtSRkNdIElJ
TyBEcml2ZXIgZm9yIEdTb0MgMjAyMA0KDQpbRXh0ZXJuYWxdDQoNCkhlbGxvIElJTywNCg0KVGhl
IHByb2plY3QgcHJvcG9zYWwgZm9yIEdTb0MgMjAyMCB1bmRlciBUaGUgTGludXggRm91bmRhdGlv
biBbMV0gbXVzdCBpbmNsdWRlIGEgQW5hbG9nIERldmljZXMsIEluYy4ncyBjb21wb25lbnQgZm9y
IHdoaWNoIGEgbm92ZWwgZHJpdmVyIGlzIHRvIGJlIGltcGxlbWVudGVkLiBNeSBzZWFyY2ggZm9y
IGEgcHJvc3BlY3RpdmUgZGV2aWNlIGhhcyBjdWxtaW5hdGVkIHRvIGNvbnNpZGVyIEFEWFJTMjkw
IEd5cm9zY29wZS4gQWJvdXQgQURYUlMyOTA6DQoNCi0gVWx0cmEtbG93IE5vaXNlLCBEdWFsLUF4
aXMgKFBpdGNoIGFuZCBSb2xsKSBNRU1TIEd5cm9zY29wZQ0KLSAiUmVjb21tZW5kZWQgZm9yIE5l
dyBEZXNpZ25zIiBwaGFzZQ0KLSBTUEkgZGlnaXRhbCBvdXRwdXQNCi0gRGF0YXNoZWV0IGluIFsy
XQ0KLSBQcm9kdWN0IG92ZXJ2aWV3IGluIFszXQ0KDQpUaGUgZXhpc3RlbmNlIG9mIGFueSBjb21w
YXRpYmxlIGRyaXZlcnMgZm9yIHRoZSBhYm92ZSBjb21wb25lbnQgd2FzIGxvb2tlZCBmb3IgaW4g
QW5hbG9nIERldmljZSwgSW5jLidzIHBhZ2UgdGhhdCBsaXN0cyBhbGwgZHJpdmVycyBbNF0gYW5k
IHRoZWlyIGtlcm5lbCB0cmVlIFs1XSBhbmQgdGhlIExpbnV4IEtlcm5lbCBEcml2ZXIgZGF0YWJh
c2UgKExLRERiKS4gSXQgd2FzIGZvdW5kIHRvIGJlIHZvaWQgYW5kIGVyZ28gbXkgZGVjaXNpb24g
dG8gY2hvb3NlIHRoZSBhZm9yZW1lbnRpb25lZCBjb21wb25lbnQuDQoNCklzIHRoZXJlIGFueSBv
dGhlciBmYWN0b3IgSSBzaG91bGQgY29uc2lkZXIgYmVmb3JlIGNob29zaW5nIGEgY29tcG9uZW50
IHRvIG1ha2UgYSBkcml2ZXIgZm9yPyBEbyBJIGdvIGFoZWFkIHdpdGggQURYUlMyOTAgZ3lyb3Nj
b3BlIGluIG15IHByb3Bvc2FsPyBJZiB5ZXMsIGFyZSB0aGVyZSBhbnkgcmVjb21tZW5kYXRpb25z
L3N1Z2dlc3Rpb25zIHlvdSdkIGxpa2UgdG8gcHJvdmlkZSBmb3IgYSBiZWdpbm5lciBpbmR1bGdp
bmcgaW4gbWFraW5nIGEga2VybmVsIGRyaXZlciBmb3Igc3VjaCBhIGNvbXBvbmVudD8NCg0KVGhh
bmsgeW91IGZvciB5b3VyIHRpbWUuDQoNCldpdGggcmVnYXJkcywNCk5pc2hhbnQgTWFscGFuaQ0K
DQpbMV0gaHR0cHM6Ly93aWtpLmxpbnV4Zm91bmRhdGlvbi5vcmcvZ3NvYy8yMDIwLWdzb2MtaWlv
LWRyaXZlcg0KWzJdDQpodHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3RlY2huaWNhbC1k
b2N1bWVudGF0aW9uL2RhdGEtc2hlZXRzL0FEWFJTMjkwLnBkZg0KWzNdIGh0dHBzOi8vd3d3LmFu
YWxvZy5jb20vZW4vcHJvZHVjdHMvYWR4cnMyOTAuaHRtbCNwcm9kdWN0LW92ZXJ2aWV3DQpbNF0g
aHR0cHM6Ly93aWtpLmFuYWxvZy5jb20vcmVzb3VyY2VzL3Rvb2xzLXNvZnR3YXJlL2xpbnV4LWRy
aXZlcnMtYWxsDQpbNV0gaHR0cHM6Ly9naXRodWIuY29tL2FuYWxvZ2RldmljZXNpbmMvbGludXgN
Cg==
