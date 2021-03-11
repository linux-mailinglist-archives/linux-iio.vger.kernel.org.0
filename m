Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E878336D3C
	for <lists+linux-iio@lfdr.de>; Thu, 11 Mar 2021 08:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCKHqh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Mar 2021 02:46:37 -0500
Received: from mail-eopbgr80108.outbound.protection.outlook.com ([40.107.8.108]:13198
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229830AbhCKHqd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 11 Mar 2021 02:46:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrCweKaPW27poK2jTyu4FXqvqAwJJRCPtdyfb1PWITH9xd+EInZhm+7F31T5Y41BilTob2ReeFGbOT2ZUqhIzy/hT1jI9KeXH1KX1dleyjoiGakjbOW9avgyK4/w0ZYaCfiv1BwuLnM4j5tSL66oeadk72F/8gMdqyNyZ25NUF/7dxO7xovLHRiEdAKpaSkjFhYUE9/USPYuPfS/4O+FWsgrrDFeLqg77UJuxsT5GvsgS7dr27gACtA2f+Q8nQntgwBkgq/5aW7YaNuGV5Pg4+8y0JlOmpEc8U/qNWyp2YVerHcSH49FCGEr543WAKrr5vL2C9n3/TMx0PFsSqGK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rILLvZZecSuXUAcNIEL4xIH4XE8XVJ/lnU7wybfFzI=;
 b=EioibhtVYpFm3St9xAYwuAuRgxRCrGIZLuu/sq239Ssk67JbCzuSyvDTMZ7VaQA20IRXSAE2BaaZri4U8MLv6t/t5IYiJEwO8JSdiMnxi37Fqfq/GTWP8Zeynbt5jx9e9OLqkQ+8XV2IYmF5QetCoGQ+kz9Zf0ZNPEWdFJa0niJNuggG56s8Jsp43ZYHr7AC+XgWaFvJgxdBboWH1Q5islxdZuOva2L+9imdUc2Xlu+J5ySqv5Aix8oY8eKGkQgQOppqB/O0Mp2+lt2cWoEHH6RS83w+vhhq9VMJFuTMa73FkJCJ/96bMrFOTZKCnnEdgS/IfdoKI8SDNf+afkLhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rILLvZZecSuXUAcNIEL4xIH4XE8XVJ/lnU7wybfFzI=;
 b=1FsbHqGG1FyuhrkPpZg3KKL/Mog1he2yxenHG+G1pTEegkL8AGpnE5btS1e1Y40cmAONjAqFQMWnkj1nUag86EkkXpqzBr/g5sOCUWl0N2nJriAhkhhy9ZIhg1mxgnxKSE7+2IwvOn8Y5c4ICsKntM2/PmiDzy/W1s8VWAKBt9Y=
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com (2603:10a6:10:70::20)
 by DB8PR06MB6569.eurprd06.prod.outlook.com (2603:10a6:10:12c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Thu, 11 Mar
 2021 07:46:30 +0000
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee]) by DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee%3]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 07:46:30 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        TERTYCHNYI Grygorii <grygorii.tertychnyi@leica-geosystems.com>,
        ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: RE: [PATCH 2/2] iio:magnetometer: Support for ST magnetic sensors
Thread-Topic: [PATCH 2/2] iio:magnetometer: Support for ST magnetic sensors
Thread-Index: AQHXEY326UZ0Cu1CykqJoIq0rGttQqp3LDqAgARXp4CAAu2xIA==
Date:   Thu, 11 Mar 2021 07:46:29 +0000
Message-ID: <DB7PR06MB4571380406FB0CECCDB9D1F5D7909@DB7PR06MB4571.eurprd06.prod.outlook.com>
References: <20210305070536.2880-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210305070536.2880-2-Qing-wu.Li@leica-geosystems.com.cn>
 <20210306164217.2d8166da@archlinux>
 <CAHp75VdBRtpkA5zmpEZ+gdP=RwYaoTsyDBqvvO2w67T6-6kqMw@mail.gmail.com>
In-Reply-To: <CAHp75VdBRtpkA5zmpEZ+gdP=RwYaoTsyDBqvvO2w67T6-6kqMw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=leica-geosystems.com.cn;
x-originating-ip: [140.207.15.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9e40132-0f49-487b-83ff-08d8e461c888
x-ms-traffictypediagnostic: DB8PR06MB6569:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR06MB6569AD53E4147565ED1D6F00D7909@DB8PR06MB6569.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AXuHmEoZtLKtO5wIq5xr02GLqWNrEDyvT3FDf11WwVSjhWj6g1Ldpp3mxg8BCsGzxoWuNGJoFNZ+Qrp6/sRQtMpUrSO3Pah/BJXzLOBML1fwZHefUWLa7ygjnYQhfLsdeVUNDUfAxyRGXxjKzIbjpkGlW0UeSpy3TIHDijohN5L+PcOH9EmB+Q140L+SSOLaEhPL0VLuGQtVVap+EY0Uf5cnTB2Di0+EtNyvhmT0MflYkM7mxI36Oh7jUHN8CJUbr82OIdxFS3Ymi+xA9tXp7n4fxRf5R3VfE2jjjHsaD0wH1hGWiFeDOWi1keGuapWhCCZJaY1epizUhWOj8KF4VXBGbY5Ws6rjLRE7uJ4DLJr3UwejwRILMLaUFuEsRIHiF6UkfsGYANDc8c7JorbQuyrTw4IOEV/Vq5jCQc3ys1LYa8HLD+ER03ytvZ+081CrnKfRmYom7BwaGZw0/OcSoJIPbWzP9obhvjpm/M5hPyqt8rzkEEREFWfNgBjlbjRNYqmqkc/DNFyA71yIjQZx0O8uFsN83qXWrayBnzlomf4mbpoq4AKDVkQetjKkK2lO5uGYDtL4ypcFvsZyJsESWxrMTi1h2TNBnbQrhPA3nxU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR06MB4571.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(52536014)(26005)(15974865002)(7416002)(54906003)(83380400001)(66556008)(66446008)(66476007)(64756008)(7696005)(6506007)(53546011)(45080400002)(76116006)(8936002)(8676002)(86362001)(316002)(186003)(71200400001)(33656002)(4326008)(2906002)(110136005)(66946007)(9686003)(55016002)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SEpJSlUzKzZibXFjdkRGT2lwbXBRKzQrbnhSRmFRQ0dpL2lJK3RWdDRFRTRu?=
 =?utf-8?B?ZmNCMDNJaWtXaHcwcWxHNEpCVkJlUCszMUdPZmFZcUErUnB1M3JuWTdzN0V2?=
 =?utf-8?B?eU9RcjdyZkVidzFMeTJuQWxLZG1EeitIUitTRkN0aFhhS2U4NXY1WjdqS2lh?=
 =?utf-8?B?TSsrVWM3bkQwa1IxRlZjMnlSVDJvcFh2V2ZZS3lGQ0dDNWphaXRFQzF1d1ZL?=
 =?utf-8?B?TCsxMUN3RDRkd2JnYXYzMFN0NmU5WldrdVdTNzBSajkycnV2WllTZmlmSjJY?=
 =?utf-8?B?Y2lEYndIQ1lsREN2aWMvNUtsR2E3SGJqZ3A5bDVNVHNoVFRxclVQaU5MYWJD?=
 =?utf-8?B?L29GWTRURktxMzMvSENTZldBSUUxYjNNc2poWG5FTlR3TEdmVDIwVDVUenYy?=
 =?utf-8?B?RUJpSkVhOUNELzdEVTA4aEFvdWNvMDFxcE9RRlJaUWtUcGZNZHRJUUY0aCth?=
 =?utf-8?B?d3g3QWtoMzhxTGF4QW1rR0lxWjRPUU5EOXBPeDZGdExaUmYzT0xCdFAvY3Jm?=
 =?utf-8?B?YXNhSitHU0QwZ1Izd0I0bjJ0MTRGaGwwajcvSmM1MFhyY1Q3NEUwU0pKb3BE?=
 =?utf-8?B?Nkh6dWI3QnhzcEo0eWdJVHd3OWl4bEo5Y0N6eEJVTzYyWnYwUUJZOWRCakJN?=
 =?utf-8?B?K3NrVndSdUxSM1B5eFBnTVNVcUg0ZnZKcUdubVlWSzRzS0dLMkxGd0xQbXRq?=
 =?utf-8?B?RXVWNzhpWUo0a3ozYStVSHJKdFNFakVZTUZqM00xODJCZG1HUERyOFhyTXNJ?=
 =?utf-8?B?QUdtdmZWUUc1OUp1QlViMW9vQlJZTUd4S1JiZ1lDT001NElTQVlrZlFkSlo4?=
 =?utf-8?B?WXI4MHdEN2hzcTVNM3RjdndDQlRKU241WitzY0MvR1FSQWpCR2N0QU5nU2lu?=
 =?utf-8?B?MnJ3MzB6S1dkZEJBWnFuL2NKbXB5aFdYVGZCdVNSZ09vNVVDbHVKdFlPdzRE?=
 =?utf-8?B?KzYxM2Q0djh0Y3RRVjNBRFg2SWwxNE5HS2ZDVTMwMXo2cnhJQ0FGOWZMdlRt?=
 =?utf-8?B?eXp5VzgvbUxKcDNBV1I4cGIzNzFEVlBpanhKdGV1TkR2aTh6TG9GL1VTRERj?=
 =?utf-8?B?RVhNZXBDaWtzVUFPN1JKdW52YkxrbS9MdkpUbG1WMlEyZmFSV2YvNGVRKzN2?=
 =?utf-8?B?enFmYzNmMDNrWkZJeWZrUXhraHNLRCtkREJQdmVyYlc2N2FPRlJkcVBVZ081?=
 =?utf-8?B?RnkwUUNWdkQvcXlVckZhenF1UEhVcTkwTmd2RGFqbjhuSHBNVFBlcVVMSmda?=
 =?utf-8?B?b2xoNTc4cEZuRDBjZDlqR1JYTGJNRjJNeS9ubGFDU1BuRURDcitwZmNVRG5a?=
 =?utf-8?B?a1JnK3V5UU9PWDQ2Y2tYS0M2cXpHWlQvcFNwSTh2blVUaFNNV0RhUkpKQWlz?=
 =?utf-8?B?SVp6Sm94V3Q5bUgwZWgrbWhCRjAwS1JSdGNzcWZ6RWo3K1dqcU52elpqSnpO?=
 =?utf-8?B?WVl6bHBUYUw5RE1RQ3dRM1F1aE50OU1OVVRHeXppanZrM0g1WEVITVAwNEJ6?=
 =?utf-8?B?MUpFVGxmYjQvM2xLRno5aWh5YWFGTnVXcmFBNDBJMDdMS0lxZDZBSHlIVzBL?=
 =?utf-8?B?MVppb1VUL3ZCdkszMkZXYlBsTGlkSDFMeDZSTzFFeWVMSWJKajJabnpkNlJl?=
 =?utf-8?B?SXk0aWZrcFNKdXlETzBESkpZaGFjMWpYTmVkaTJnUkduK2xSQWU3eHhrdkF6?=
 =?utf-8?B?Q3BtZ3hpR2dOUlBlR3NMVUs0SVJvTWN2Vnd3ZURIMWJlMjVEb1dqN0hwNXNm?=
 =?utf-8?Q?G3u97qVbUKWbU0miD4Nc1xomVmeAyREyz/Lo4i+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR06MB4571.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e40132-0f49-487b-83ff-08d8e461c888
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 07:46:29.9586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RgkGNsDJMn1vmqO9nXq5ql/kVEpslg1e2sJdekz6aN4P6hrOjCs2KowbZN6Qm76e89GF7sVNwo7ab8cusFGRC5ZFQma8g+UGdhAZd4JGFVYD+9o2EdMc0stc70jziblE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6569
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGlucHV0LCBJIGp1c3QgZXh0ZW5kIHRo
ZSBleGlzdGluZyBkcml2ZXIgaW4gcGF0Y2ggVjIgZm9yIHRoZSBzZXJzb3IuDQoNCg0KDQpCZXN0
IFJlZ2FyZHMNCg0KKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
Kg0KTGkgUWluZ3d1IChUZXJyeSkNClNlbmlvciBFbWJlZGRlZCBTb2Z0d2FyZSBFbmdpbmVlciAN
CkxlaWNhIEdlb3N5c3RlbXMoU2hhbmdoYWkpQ28uLExpbWl0ZWQNCihUZWwpOiArODYgMjEgNjEw
NjEwMzYNCihGQVgpOiArODYgMjEgNjEwNjEwMDgNCihNb2JpbGUpOiArODYgMTg3IDAxODUgOTYw
MA0KRS1tYWlsOiBRaW5nLXd1LkxpQGxlaWNhLWdlb3N5c3RlbXMuY29tLmNuDQpIdHRwOiB3d3cu
bGVpY2EtZ2Vvc3lzdGVtcy5jb20uY24NCioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFuZHkg
U2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBN
YXJjaCA5LCAyMDIxIDc6MDEgUE0NClRvOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwu
b3JnPg0KQ2M6IExJIFFpbmd3dSA8cWluZy13dS5saUBsZWljYS1nZW9zeXN0ZW1zLmNvbS5jbj47
IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPjsgUGV0ZXIgTWVlcndhbGQgPHBt
ZWVyd0BwbWVlcncubmV0PjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IERlbmlz
IENpb2NjYSA8ZGVuaXMuY2lvY2NhQHN0LmNvbT47IGxpbnV4LWlpbyA8bGludXgtaWlvQHZnZXIu
a2VybmVsLm9yZz47IGRldmljZXRyZWUgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgTGlu
dXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFRF
UlRZQ0hOWUkgR3J5Z29yaWkgPGdyeWdvcmlpLnRlcnR5Y2hueWlAbGVpY2EtZ2Vvc3lzdGVtcy5j
b20+OyBaSElaSElLSU4gQW5kcmV5IDxhbmRyZXkuemhpemhpa2luQGxlaWNhLWdlb3N5c3RlbXMu
Y29tPjsgTG9yZW56byBCaWFuY29uaSA8bG9yZW56by5iaWFuY29uaUByZWRoYXQuY29tPg0KU3Vi
amVjdDogUmU6IFtQQVRDSCAyLzJdIGlpbzptYWduZXRvbWV0ZXI6IFN1cHBvcnQgZm9yIFNUIG1h
Z25ldGljIHNlbnNvcnMNCg0KVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZp
Y2UgMzY1IGluc3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywg
b3BlbmluZyBhdHRhY2htZW50cywgb3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4NCg0KDQpPbiBT
YXQsIE1hciA2LCAyMDIxIGF0IDY6NDQgUE0gSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVs
Lm9yZz4gd3JvdGU6DQo+IE9uIEZyaSwgIDUgTWFyIDIwMjEgMDc6MDU6MzYgKzAwMDANCj4gTEkg
UWluZ3d1IDxRaW5nLXd1LkxpQGxlaWNhLWdlb3N5c3RlbXMuY29tLmNuPiB3cm90ZToNCj4NCj4g
PiBBZGQgc3VwcG9ydCBmb3IgU1RNaWNyb2VsZWN0cm9uaWNzIGRpZ2l0YWwgbWFnbmV0aWMgc2Vu
c29ycywgDQo+ID4gTFNNMzAzQUgsTFNNMzAzQUdSLExJUzJNREwsSVNNMzAzREFDLElJUzJNREMu
DQo+ID4NCj4gPiBUaGUgcGF0Y2ggdGVzdGVkIHdpdGggSUlTMk1EQyBpbnN0cnVtZW50Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogTEkgUWluZ3d1IDxRaW5nLXd1LkxpQGxlaWNhLWdlb3N5c3Rl
bXMuY29tLmNuPg0KPg0KPiBIaSwNCj4NCj4gR2l2ZW4gdGhhdCBhdCBsZWFzdCB0d28gcGFydHMg
aW4gaGVyZSBpcyBzdXBwb3J0ZWQgYnkgdGhlIGV4aXN0aW5nIA0KPiBkcml2ZXIgaW4gaWlvL21h
Z25ldG9tZXRlcnMvc3RfbWFnbl8qLmMgKGxzbTMwM2FncikgY2FuIHlvdSBjb25maXJtIA0KPiB0
aGF0IGl0IGRvZXNuJ3QgbWFrZSBzZW5zZSB0byBzaW1wbHkgZXh0ZW5kIHRoYXQgZHJpdmVyIHRv
IHN1cHBvcnQgdGhlIA0KPiBvdGhlciBwYXJ0cz8gIFRoaXMgaXMgcGFydGljdWxhcmx5IHRydWUg
d2hlbiB0aGUgV0hPIEFNIEkgcmVnaXN0ZXIgDQo+IHJlYWRzIDB4NDAgZm9yIGFsbCB0aGVzZSBw
YXJ0cy4NCj4NCj4gSSd2ZSBkb25lIGEgZmFpcmx5IHN1cGVyZmljaWFsIHJldmlldyB3aGlsc3Qg
aGVyZSwgYnV0IHBsZWFzZSBjaGVjayANCj4geW91IGNhbid0IGp1c3QgYWRkIHRoZSByZWxldmFu
dCBlbnRyaWVzIHRvIHRoZSBleGlzdGluZyBkcml2ZXIuDQoNCkkgZXZlbiBoYWRuJ3QgbG9va2Vk
IGludG8gdGhlIGNvZGUgYmVjYXVzZSB0aGlzIG9uZSBuZWVkcyBhIHZlcnkgZ29vZCBqdXN0aWZp
Y2F0aW9uIHdoeSBpdCdzIGEgbmV3IGRyaXZlciByYXRoZXIgdGhhbiBleHRlbnNpb24gb2YgdGhl
IGV4aXN0aW5nIG9uZS4NCg0KLS0NCldpdGggQmVzdCBSZWdhcmRzLA0KQW5keSBTaGV2Y2hlbmtv
DQo=
