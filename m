Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3271B6EF5
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 09:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgDXH1I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 03:27:08 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:38636 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725898AbgDXH1I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 03:27:08 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O7PmOM017688;
        Fri, 24 Apr 2020 03:26:48 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0b-00128a01.pphosted.com with ESMTP id 30fuabuvn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 03:26:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vr3ZpFakgSq/vmfhxUW3mQrfcnBHeBrAGXF3teSexDY+98+5vp9wv/GOUyOa4BjyLr8BRtdimMoYYuszqe/MTW8Xg4c0jPGdX1UCPgjkJ2K9SvalgFoc2hVn7vG5J3D9quuh9WwA2ZhgHymXn0dm4F8F2HZu5km0WsRWhdGauoqCVDajnOPnuE4AXsQafwIJ50PkVJVWjyZE6ViylbAubw0HeJ9cIxlaD2YQncg+nz2sopcEWa8ghoPB0nYuI95lf7MrhvVRVwpNHtYfdtIOkuBGEw9Mv+Bq3o44YZbwMg5NYBFjICItUh+gCe37cV6iC7drbIIws2nCNNn4uU1trA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffntaDELXEgoacyDMS1+90zE/M3c8c75FDY4snA5InQ=;
 b=IBzWqpVzbRfruUCV88YTDy6juowbJAc5micXdpG8oqJ9apy/EXm8Tmt13J2tmP0J9FoZVsBIlD8ainLUJujYODTHmNDTBnxEgGGrPPQ8C8DpGw9KDKZRKiIvZb25e/gIjb45hnp2fb+32hsNRoA2LJFB3tX2Oay2K9jI68VdL5rX7D9suyVY4RIuBRIfBQnYYO6+fd7NpRl00nuTxZ1l8HvGKXNc+Y9AGph3VQbGsDmH5mwgNGxnLb/Kt86xPo9HXUr9/OwcBHgo2hb8i5ooTdNOght4paTUucVlbdIzsovwyWVW+wtHZmgG+xIduoiCa+ciOHbGwWvpDigQWtG+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffntaDELXEgoacyDMS1+90zE/M3c8c75FDY4snA5InQ=;
 b=6HZPb3J4I/CAwgCEHcSEgHTL+ZhrjM8Rr3DDeSJO93RT67SWnhuvCQcVeWu1oOh3/c7KJx+qgSBXtmy9M41NyEkyVTiH7WzHKaeGRHU8DOLjCFzYq8LcHOtGoSTQ8/YfGG5WUicgnzbmjHTKTEcoPOa35YXVMDi234gDeUCYLdI=
Received: from CY4PR03MB3350.namprd03.prod.outlook.com (2603:10b6:910:55::24)
 by CY4PR03MB3142.namprd03.prod.outlook.com (2603:10b6:910:59::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 07:26:46 +0000
Received: from CY4PR03MB3350.namprd03.prod.outlook.com
 ([fe80::e483:8557:31ac:d59b]) by CY4PR03MB3350.namprd03.prod.outlook.com
 ([fe80::e483:8557:31ac:d59b%4]) with mapi id 15.20.2921.027; Fri, 24 Apr 2020
 07:26:46 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: iio: adi,ltc2983: Add missing quotes on
 dependencies
Thread-Topic: [PATCH] dt-bindings: iio: adi,ltc2983: Add missing quotes on
 dependencies
Thread-Index: AQHWGYCuTE7t3bwNvkijkigcF+rUqaiH4BwQ
Date:   Fri, 24 Apr 2020 07:26:46 +0000
Message-ID: <CY4PR03MB33502FFA293BB3F068A488B299D00@CY4PR03MB3350.namprd03.prod.outlook.com>
References: <20200423150523.23984-1-robh@kernel.org>
In-Reply-To: <20200423150523.23984-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpqSmlOamt5TlRVdE9EVm1ZeTB4TVdWaExUaGhOVEl0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHWXlZalk1TWpVM0xUZzFabU10TVRGbFlTMDRZ?=
 =?utf-8?B?VFV5TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTWpFeU5p?=
 =?utf-8?B?SWdkRDBpTVRNeU16SXhPRFk0TURRNE5qYzNOVFk1SWlCb1BTSm9SeTloU1Zw?=
 =?utf-8?B?TlNFZzNTRmhLVGpGYVZtRnVRVmRET0hSaVRrMDlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVUkNkV2MyTVVOU2NsZEJXSGhWU2l0TFVITkdielZtUmxGdU5H?=
 =?utf-8?B?OHJkMWRxYTBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVFYxUjBSWFFVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-originating-ip: [2001:a61:24cc:eb01:701a:32:5e81:fad2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77979db1-8342-46f6-f285-08d7e820d897
x-ms-traffictypediagnostic: CY4PR03MB3142:
x-microsoft-antispam-prvs: <CY4PR03MB3142ED283F62891AE921026399D00@CY4PR03MB3142.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3350.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(71200400001)(478600001)(4326008)(110136005)(55016002)(7696005)(9686003)(53546011)(6506007)(316002)(33656002)(5660300002)(2906002)(54906003)(186003)(8676002)(86362001)(8936002)(81156014)(66556008)(66476007)(66446008)(64756008)(66946007)(52536014)(76116006)(142933001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZVPaMykddGXk5exDZHm+XbQ6GsjmlKpWFGJ/K/gf9ylNI+N50tB9mZmYV1vXwJKn4v0XjXLCF4iO+pzOz+q6iGCA5WdqFeEkvM738yaXbhQfjHSstMN6Y2IYOmtUvkFd7BriTT1HtrYj7ZoqB6aerU1TLxEYe8zuXNzjTR+U4cXsl6TpdDNFYzVM0Mtydwz/Ub4f3lrvhW27HrimmPGMsKsbrhhYmADt/t+Zj2B+MYkm3XNpHNc2wJToit6cfsNhWiq6u3En1UvFV5TcP9RySXqW8UJ5XuTl2uqaMd3vLEhzzmUpPi8fx/iSZhCnPjsnHOyIJjpkcBlY3ufTcDrHR5YlRhNFw83pqX/tpx8gKA/gDxqH/ILaFyhJS2lQym4P+QTmsVt99CkIfebbHTt0ESw5d0duzjXddUGjiePUra6JK6u07R9Gy+XNQtWXqd/GTwFOl8P/w9fq7cC+jt8rtuKFCU4hx+rKubeu6dOWFio7Ja3IfpxEEYdiAxCyr2SR
x-ms-exchange-antispam-messagedata: vgWpvKDEFwUcyWiF1M8SoXBvq9VDWhuACwN5RJXRgCxnhvRC5nJjhmaU8sx1+Ldo3+vCtgABWHJ6wC8sR5MA2BEN2NQOqcRnxvZJtaCDKtdyfP8B6oyXoi4vPBS9lQGfYgeKN3nCtHlA50I28FAnQDOFmu6LnVe68j7oLPAdQLt9Vv+A/JnP9TtrVHivNHdpMkoZLi2hpFK76qxzueJD/A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77979db1-8342-46f6-f285-08d7e820d897
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 07:26:46.5439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGVLSXeVwuHVV4opKZReUH0r16fHWedhXA9b2OrHkxl3yMhanr9volBbL6DdwV0PHijhGxXOLdSvA70efNlX6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3142
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_02:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240056
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQo+IEZyb206IGxpbnV4LWlpby1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWlpby1vd25l
ckB2Z2VyLmtlcm5lbC5vcmc+DQo+IE9uIEJlaGFsZiBPZiBSb2IgSGVycmluZw0KPiBTZW50OiBE
b25uZXJzdGFnLCAyMy4gQXByaWwgMjAyMCAxNzowNQ0KPiBUbzogZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gQ2M6IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+OyBKb25hdGhhbiBD
YW1lcm9uDQo+IDxqaWMyM0BrZXJuZWwub3JnPjsgSGFydG11dCBLbmFhY2sgPGtuYWFjay5oQGdt
eC5kZT47IExhcnMtUGV0ZXINCj4gQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPjsgUGV0ZXIgTWVl
cndhbGQtU3RhZGxlcg0KPiA8cG1lZXJ3QHBtZWVydy5uZXQ+OyBsaW51eC1paW9Admdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF0gZHQtYmluZGluZ3M6IGlpbzogYWRpLGx0YzI5ODM6
IEFkZCBtaXNzaW5nIHF1b3RlcyBvbg0KPiBkZXBlbmRlbmNpZXMNCj4gDQo+IFdpdGggdGhlIGJy
YWNrZXRlZCBsaXN0IGZvcm0sIGFueSBzdHJpbmdzIHdpdGggY29tbWFzIGhhdmUgdG8gYmUgcXVv
dGVkDQo+IG9yIHRoZXkgYXJlIHNlcGFyYXRlZC4NCj4gDQo+IEZpeGVzOiAzOTg2YTE0ODcwY2Ig
KCJkdC1iaW5kaW5nczogaWlvOiBBZGQgbHRjMjk4MyBkb2N1bWVudGF0aW9uIikNCj4gQ2M6ICJO
dW5vIFPDoSIgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gQ2M6IEpvbmF0aGFuIENhbWVyb24gPGpp
YzIzQGtlcm5lbC5vcmc+DQo+IENjOiBIYXJ0bXV0IEtuYWFjayA8a25hYWNrLmhAZ214LmRlPg0K
PiBDYzogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+IENjOiBQZXRlciBN
ZWVyd2FsZC1TdGFkbGVyIDxwbWVlcndAcG1lZXJ3Lm5ldD4NCj4gQ2M6IGxpbnV4LWlpb0B2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz4NCj4gLS0tDQoNCkFja2VkLWJ5OiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0KDQo+
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vdGVtcGVyYXR1cmUvYWRpLGx0YzI5ODMueWFt
bCAgICAgIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9paW8vdGVtcGVyYXR1cmUvYWRpLGx0YzI5ODMueWFtbA0KPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vdGVtcGVyYXR1cmUvYWRpLGx0YzI5ODMueWFt
bA0KPiBpbmRleCA4ZmI0NmRlNjY0MWQuLjA0ZGE1YzQ4YTVlOSAxMDA2NDQNCj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby90ZW1wZXJhdHVyZS9hZGksbHRjMjk4
My55YW1sDQo+ICsrKw0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8v
dGVtcGVyYXR1cmUvYWRpLGx0YzI5ODMueWFtbA0KPiBAQCAtMjYwLDcgKzI2MCw3IEBAIHBhdHRl
cm5Qcm9wZXJ0aWVzOg0KPiAgICAgICAgLSBhZGkscnNlbnNlLWhhbmRsZQ0KPiANCj4gICAgICBk
ZXBlbmRlbmNpZXM6DQo+IC0gICAgICBhZGksY3VycmVudC1yb3RhdGU6IFsgYWRpLHJzZW5zZS1z
aGFyZSBdDQo+ICsgICAgICBhZGksY3VycmVudC1yb3RhdGU6IFsgImFkaSxyc2Vuc2Utc2hhcmUi
IF0NCj4gDQo+ICAgICJedGhlcm1pc3RvckAiOg0KPiAgICAgIHR5cGU6IG9iamVjdA0KPiBAQCAt
MzQ5LDcgKzM0OSw3IEBAIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiAgICAgICAgLSBhZGkscnNlbnNl
LWhhbmRsZQ0KPiANCj4gICAgICBkZXBlbmRlbmNpZXM6DQo+IC0gICAgICBhZGksY3VycmVudC1y
b3RhdGU6IFsgYWRpLHJzZW5zZS1zaGFyZSBdDQo+ICsgICAgICBhZGksY3VycmVudC1yb3RhdGU6
IFsgImFkaSxyc2Vuc2Utc2hhcmUiIF0NCj4gDQo+ICAgICJeYWRjQCI6DQo+ICAgICAgdHlwZTog
b2JqZWN0DQo+IC0tDQo+IDIuMjAuMQ0KDQo=
