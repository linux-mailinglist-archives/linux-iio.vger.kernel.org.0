Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DD61CDB1D
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 15:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgEKNZH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 09:25:07 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31678 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgEKNZH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 May 2020 09:25:07 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BDNRNQ025164;
        Mon, 11 May 2020 09:24:53 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 30wse5n5p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 09:24:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFTeoNoaJJKoA/Ag0CoKGmFWJLhqlQ58dFxurzIZlYT0o1XMmOEbodV/bBNMjgR8wMpR4zsStVpUqb+IVLctb/HM+xUkGv2j34gFCgNX2MnfG5KCwStn+cXtWKB2j8ZpMmIgtVf5ZdMoWlwBNYmYurbHVrG/BsPxxXDk0b39/xQdWaZJWkZ283VO4ogljLreoH2jE8KkmnnhYO6Ed17eLkG6rISefc79G8LNwQMOGAkg4keM5yld0zh87dlipsPdJZvuJ9ZB2e5278pBiH2Y81Qd/nus7gLqOJy1d5QlhBsZFw9/cQxunMf0kvP6TJtTahIGXNRytj4+BhsWncl/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MVCEFXSCfAqeKttMtDf0sXi/1ceCKMXI5O17mxfv6Y=;
 b=B5plO8VWEaWHc661jZxAQwWZSC0f37BLOiy+3ItjkzDIyqDf2KTB0yXVvfjCx5urZls9YTVMB9EuzH9TYBaWGPr96nzH/QOldIQ0EyhiPoYmhdF+61oyYywzHft/3rRCtEZ6SblrW9KIGlKVICE/Wa6nZzJOydC3Dg9U0e29ODT0ruMVrFpggxOtG3vkNK2g/+tVACztl/FJPa1QcYtfcRuICgS6qn3uPNt7v0VjcmPB4Van99Tcj/WrJujIky+0Y/Drre/cRPpCq3XOREnSmSCDX4bSWFE5MDVaFq0VU2+tz+NRE7nvfOw0TdBA5DLzG02r21sXgO3W6bWKeW6kwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MVCEFXSCfAqeKttMtDf0sXi/1ceCKMXI5O17mxfv6Y=;
 b=cN7ngzRm2J5p+kj59TeulXUjJ90UapEUpHIrpnmTLUG4zFkHm8aa6mzyZ3MBhD8kJiwBjAH1gnhpRvum9PCWDvPY2Wx0L6k1dNu5FlzZXK6Yn4E6B4btZJEUh0oKqn63gnVjlc+lbjWRUnV4joye6k8cJvD1YJgYbP1Ixo0SG7A=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4347.namprd03.prod.outlook.com (2603:10b6:5:110::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 13:24:47 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 13:24:47 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
Thread-Topic: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
Thread-Index: AQHWJUAdPxP6vzcVf0GdP2M4m7Jctaifc8QAgAGoDQCAAZjjAIAAAUIAgAAoyACAAAXVAA==
Date:   Mon, 11 May 2020 13:24:47 +0000
Message-ID: <7d2c8174e345bf8e241d48de65066d2606143503.camel@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
         <a9a47e84-b933-cca6-dcfb-d97a51c8bdd4@metafoo.de>
         <20200510110958.29046a18@archlinux>
         <8c5d9ef5ed4ea9037c5459daa2044d1cd7c5db7a.camel@analog.com>
         <c88b17c3-a9d6-e755-04e8-bc9f225e2a3b@metafoo.de>
         <554fe46f0cdd1cafb313f534c0edd93f5686b806.camel@analog.com>
In-Reply-To: <554fe46f0cdd1cafb313f534c0edd93f5686b806.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 729bf7cb-45c9-4db0-2bbf-08d7f5aead36
x-ms-traffictypediagnostic: DM6PR03MB4347:
x-microsoft-antispam-prvs: <DM6PR03MB434784971A195B8999DB0BE3F9A10@DM6PR03MB4347.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +/WByI0t7DfNFwluJZoknC5IFXjvayjATSQH5oXJEBxCU2BnBp6w5hOLWPeksSrTWNUIh35ueFN8gniJfZb08+gxnzizWx7LcDc4jwYYhCZ/gMGOFzYe69rAheXj/pMw1YCQn7zMen+nc4TijA4JUp+P4OHnlGSQ175b4l8D7vgJtvOqowCojmD4c7KvkXhl2WSFGbCT5nWK7nRSyzwdHHoujZr96tt2EqHp2vbU+w18gz9xCB+8+DtqDmhJQcNeoB9bZ46HM+yFHJxRwW30kBzZ5nrXFfJ+mJHOScu2P/kc2+9Xq62xPiKSXT4LkYs3ZC1DtRjc2F9Ut6Ecxmr4rEGdI/c5bqWFVDjumipRCO0XOTiDch609nflxgmDRQlBa7pyttj3lY1+FGOMFljP12sPSWSmEWjzt9RQpJtvyH6SjN7D4jgQXsj40nRuhiW1OTNJSVAEw7MBFzeripN5Z3LHFtpiFUhF5gtyfn5L48PNRmRJoLIiUt7n4/ORlxXVRerqX9tzHJsOCdBvdK001w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(366004)(376002)(39860400002)(136003)(33430700001)(4326008)(5660300002)(8936002)(478600001)(66476007)(66946007)(64756008)(33440700001)(66446008)(36756003)(91956017)(66556008)(76116006)(71200400001)(54906003)(2616005)(6486002)(110136005)(6512007)(6506007)(86362001)(316002)(53546011)(8676002)(2906002)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: aLp3MH/tBZmMC1mErLXG3SEy1PesXnnvaCw2YA83pgW4MoQvh6xu+1yNOZZ7fRK36+tHVNc0YEoARU5wio0PaV2/1dB8ixvS/8bomrM1Lw+FS2EyGPeDnxaQulSfWSgulVzR4ejr7Y2jw7BeuswbZi+k5Ou8uA2Lq2f24GiQUUzuV8P+wvhAx5Zk5NdPafcFPs8KL6iAurX6bzsoKwxJ5tNl9DM7/u3rLj649lQsWd/hWOD1dYB322Kwg1PBVX3Uii8JK48cadRiDzWi5b03xlW/DGKviOtIgd3gKsOyCKHFlCm9fD8lpzN3P3OxbOvm63MoLnLfdwkL7pdlC7iN1vajcZzYjJYmd/elIj3O0JkxYb+9ywQFQQi7B98ClOKcyjcst2Qh56lCfe1j23ew8GhdbwdxlWBLEcGOfz3rpcEUaV7rivTMFI6suSQiPquros58b3geWp08yps3M57LGhnJwcWDXI+xBiBzeP0efw8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A575A187A4CA44CA5FED6F40C71A951@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729bf7cb-45c9-4db0-2bbf-08d7f5aead36
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 13:24:47.4887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fzS23zVyw/75ztq3QUR7U1lnWI+p81iqBs8MHkCLJRYp1mc/83G+4yDQZ6bfCCgSnMGSr/v34WgXcQdwdfuYDzJNXGT+wIQPzOAHgBZQdKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4347
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_05:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110110
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTA1LTExIGF0IDEzOjAzICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdy
b3RlOg0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIDIwMjAtMDUtMTEgYXQgMTI6MzcgKzAy
MDAsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToNCj4gPiBbRXh0ZXJuYWxdDQo+ID4gDQo+ID4g
T24gNS8xMS8yMCAxMjozMyBQTSwgQXJkZWxlYW4sIEFsZXhhbmRydSB3cm90ZToNCj4gPiA+IE9u
IFN1biwgMjAyMC0wNS0xMCBhdCAxMTowOSArMDEwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToN
Cj4gPiA+ID4gW0V4dGVybmFsXQ0KPiA+ID4gPiANCj4gPiA+ID4gT24gU2F0LCA5IE1heSAyMDIw
IDEwOjUyOjE0ICswMjAwDQo+ID4gPiA+IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9v
LmRlPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+ID4gT24gNS84LzIwIDM6NTMgUE0sIEFsZXhh
bmRydSBBcmRlbGVhbiB3cm90ZToNCj4gPiA+ID4gPiA+IFsuLi5dDQo+ID4gPiA+ID4gPiBXaGF0
IEkgZG9uJ3QgbGlrZSwgaXMgdGhhdCBpaW86ZGV2aWNlMyBoYXMgaWlvOmJ1ZmZlcjM6MCAodG8g
MykuDQo+ID4gPiA+ID4gPiBUaGlzIGlzIGJlY2F1c2UgdGhlICdidWZmZXItPmRldi5wYXJlbnQg
PSAmaW5kaW9fZGV2LT5kZXYnLg0KPiA+ID4gPiA+ID4gQnV0IEkgZG8gZmVlbCB0aGlzIGlzIGNv
cnJlY3QuDQo+ID4gPiA+ID4gPiBTbywgbm93IEkgZG9uJ3Qga25vdyB3aGV0aGVyIHRvIGxlYXZl
IGl0IGxpa2UgdGhhdCBvciBzeW1saW5rIHRvDQo+ID4gPiA+ID4gPiBzaG9ydGVyDQo+ID4gPiA+
ID4gPiB2ZXJzaW9ucyBsaWtlICdpaW86YnVmZmVyMzpZJyAtPiAnaWlvOmRldmljZTMvYnVmZmVy
WScuDQo+ID4gPiA+ID4gPiBUaGUgcmVhc29uIGZvciBuYW1pbmcgdGhlIElJTyBidWZmZXIgZGV2
aWNlcyB0byAnaWlvOmJ1ZmZlclg6WScgaXMNCj4gPiA+ID4gPiA+IG1vc3RseSB0byBtYWtlIHRo
ZSBuYW1lcyB1bmlxdWUuIEl0IHdvdWxkIGhhdmUgbG9va2VkIHdlaXJkIHRvIGRvDQo+ID4gPiA+
ID4gPiAnL2Rldi9idWZmZXIxJyBpZiBJIHdvdWxkIGhhdmUgbmFtZWQgdGhlIGJ1ZmZlciBkZXZp
Y2VzICdidWZmZXJYJy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU28sIG5vdyBJJ20gdGhp
bmtpbmcgb2Ygd2hldGhlciBhbGwgdGhpcyBpcyBhY2NlcHRhYmxlLg0KPiA+ID4gPiA+ID4gT3Ig
d2hhdCBpcyBhY2NlcHRhYmxlPw0KPiA+ID4gPiA+ID4gU2hvdWxkIEkgc3ltbGluayAnaWlvOmRl
dmljZTMvaWlvOmJ1ZmZlcjM6MCcgLT4NCj4gPiA+ID4gPiA+ICdpaW86ZGV2aWNlMy9idWZmZXIw
Jz8NCj4gPiA+ID4gPiA+IFdoYXQgZWxzZSBzaG91bGQgSSBjb25zaWRlciBtb3ZpbmcgZm9yd2Fy
ZD8NCj4gPiA+ID4gPiA+IFdoYXQgbWVhbnMgZm9yd2FyZD8NCj4gPiA+ID4gPiA+IFdoZXJlIGRp
ZCBJIGxlYXZlIG15IGJlZXI/DQo+ID4gPiA+ID4gTG9va2luZyBhdCBob3cgdGhlIC9kZXYvIGRl
dmljZXMgYXJlIG5hbWVkIEkgdGhpbmsgd2UgY2FuIHByb3ZpZGUgYQ0KPiA+ID4gPiA+IG5hbWUN
Cj4gPiA+ID4gPiB0aGF0IGlzIGRpZmZlcmVudCBmcm9tIHRoZSBkZXZfbmFtZSgpIG9mIHRoZSBk
ZXZpY2UuIEhhdmUgYSBsb29rIGF0DQo+ID4gPiA+ID4gZGV2aWNlX2dldF9kZXZub2RlKCkgaW4g
ZHJpdmVycy9iYXNlL2NvcmUuYy4gV2Ugc2hvdWxkIGJlIGFibGUgdG8NCj4gPiA+ID4gPiBwcm92
aWRlIHRoZSBuYW1lIGZvciB0aGUgY2hhcmRldiB0aHJvdWdoIHRoZSBkZXZub2RlKCkgY2FsbGJh
Y2suDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2hpbGUgd2UgYXJlIGF0IHRoaXMsIGRvIHdlIHdh
bnQgdG8gbW92ZSB0aGUgbmV3IGRldmljZXMgaW50byBhbiBpaW8NCj4gPiA+ID4gPiBzdWJmb2xk
ZXI/IFNvIGlpby9idWZmZXIwOjAgaW5zdGVhZCBvZiBpaW86YnVmZmVyMDowPw0KPiA+ID4gPiBQ
b3NzaWJseSBvbiB0aGUgZm9sZGVyLiAgSSBjYW4ndCBmb3IgdGhlIGxpZmUgb2YgbWUgcmVtZW1i
ZXIgd2h5IEkNCj4gPiA+ID4gZGVjaWRlZA0KPiA+ID4gPiBub3QgdG8gZG8gdGhhdCB0aGUgZmly
c3QgdGltZSBhcm91bmQgLSBJJ2xsIGxlYXZlIGl0IGF0IHRoZQ0KPiA+ID4gPiBteXN0ZXJpb3Vz
ICJpdCBtYXkgdHVybiBvdXQgdG8gYmUgaGFyZGVyIHRoYW4geW91J2QgdGhpbmsuLi4iDQo+ID4g
PiA+IEhvcGVmdWxseSBub3QgOykNCj4gPiA+IEkgd2FzIGFsc28gdGhpbmtpbmcgYWJvdXQgdGhl
IC9kZXYvaWlvIHN1YmZvbGRlciB3aGlsZSBkb2luZyB0aGlzLg0KPiA+ID4gSSBjYW4gY29weSB0
aGF0IGZyb20gL2Rldi9pbnB1dA0KPiA+ID4gVGhleSBzZWVtIHRvIGRvIGl0IGFscmVhZHkuDQo+
ID4gPiBJIGRvbid0IGtub3cgaG93IGRpZmZpY3VsdCBpdCB3b3VsZCBiZS4gQnV0IGl0IGxvb2tz
IGxpa2UgYSBnb29kDQo+ID4gPiBwcmVjZWRlbnQuDQo+ID4gDQo+ID4gQWxsIHlvdSBoYXZlIHRv
IGRvIGlzIHJldHVybiAiaWlvLy4uLiIgZnJvbSB0aGUgZGV2bm9kZSgpIGNhbGxiYWNrLg0KPiAN
Cj4gSSBhZG1pdCBJIGRpZCBub3QgbG9vayBjbG9zZWx5IGludG8gZHJpdmVycy9pbnB1dC9pbnB1
dC5jIGJlZm9yZSBtZW50aW9uaW5nDQo+IHRoaXMNCj4gYXMgYXMgZ29vZCBwcmVjZWRlbnQuDQo+
IA0KPiBCdXQsIEkgbG9va3MgbGlrZSAvZGV2L2lucHB1dCBpcyBhIGNsYXNzLg0KPiBXaGlsZSBJ
SU8gZGV2aWNlcyBhcmUgYSBidXNfdHlwZSBkZXZpY2VzLg0KPiBTaG91bGQgd2Ugc3RhcnQgaW1w
bGVtZW50aW5nIGFuIElJTyBjbGFzcz8gb3I/DQoNCldoYXQgSSBzaG91bGQgaGF2ZSBoaWdobGln
aHRlZCBbYmVmb3JlXSB3aXRoIHRoaXMsIGlzIHRoYXQgdGhlcmUgaXMgbm8gZGV2bm9kZSgpDQpj
YWxsYmFjayBmb3IgdGhlIGJ1c190eXBlIFt0eXBlXS4NCg0KPiANCj4gDQo+ID4gPiBNeSBjb25j
ZXJuIHJlZ2FyZGluZyBnb2luZyB0byB1c2Ugc3R1ZmYgZnJvbSBjb3JlIFtsaWtlDQo+ID4gPiBk
ZXZpY2VfZ2V0X2Rldm5vZGUoKV0gaXMNCj4gPiA+IHRoYXQgaXQgc2VlbXMgdG8gYnlwYXNzIHNv
bWUgbGF5ZXJzIG9mIGtlcm5lbC4NCj4gPiA+IElmIEkgZG8gJ2dpdCBncmVwIGRldmljZV9nZXRf
ZGV2bm9kZScsIEkgZ2V0Og0KPiA+ID4gDQo+ID4gPiBkcml2ZXJzL2Jhc2UvY29yZS5jOiAgICAg
ICAgICAgIG5hbWUgPSBkZXZpY2VfZ2V0X2Rldm5vZGUoZGV2LCAmbW9kZSwNCj4gPiA+ICZ1aWQs
DQo+ID4gPiAmZ2lkLCAmdG1wKTsNCj4gPiA+IGRyaXZlcnMvYmFzZS9jb3JlLmM6ICogZGV2aWNl
X2dldF9kZXZub2RlIC0gcGF0aCBvZiBkZXZpY2Ugbm9kZSBmaWxlDQo+ID4gPiBkcml2ZXJzL2Jh
c2UvY29yZS5jOmNvbnN0IGNoYXIgKmRldmljZV9nZXRfZGV2bm9kZShzdHJ1Y3QgZGV2aWNlICpk
ZXYsDQo+ID4gPiBkcml2ZXJzL2Jhc2UvZGV2dG1wZnMuYzogICAgICAgIHJlcS5uYW1lID0gZGV2
aWNlX2dldF9kZXZub2RlKGRldiwNCj4gPiA+ICZyZXEubW9kZSwNCj4gPiA+ICZyZXEudWlkLCAm
cmVxLmdpZCwgJnRtcCk7DQo+ID4gPiBkcml2ZXJzL2Jhc2UvZGV2dG1wZnMuYzogICAgICAgIHJl
cS5uYW1lID0gZGV2aWNlX2dldF9kZXZub2RlKGRldiwgTlVMTCwNCj4gPiA+IE5VTEwsDQo+ID4g
PiBOVUxMLCAmdG1wKTsNCj4gPiA+IGluY2x1ZGUvbGludXgvZGV2aWNlLmg6ZXh0ZXJuIGNvbnN0
IGNoYXIgKmRldmljZV9nZXRfZGV2bm9kZShzdHJ1Y3QgZGV2aWNlDQo+ID4gPiAqZGV2LA0KPiA+
ID4gKEVORCkNCj4gPiA+IA0KPiA+ID4gU28sIGJhc2ljYWxseSwgbW9zdCB1c2VzIG9mIGRldmlj
ZV9nZXRfZGV2bm9kZSgpIGFyZSBpbiBjb3JlIGNvZGUsIGFuZCBJDQo+ID4gPiBmZWVsDQo+ID4g
PiB0aGF0IHRoaXMgbWF5IGJlIHNhbmN0aW9uZWQgc29tZXdoZXJlIGJ5IHNvbWUgY29yZSBwZW9w
bGUsIGlmIEkgZG8gaXQuDQo+ID4gPiBJIGNvdWxkIGJlIHdyb25nLCBidXQgaWYgeW91IGRpc2Fn
cmVlLCBJJ2xsIHRha2UgeW91ciB3b3JkIGZvciBpdC4NCj4gPiBZb3UgYXJlIG5vdCBzdXBwb3Nl
ZCB0byB1c2UgdGhlIGZ1bmN0aW9uIGl0c2VsZiwgeW91IHNob3VsZCBpbXBsZW1lbnQgDQo+ID4g
dGhlIGRldm5vZGUoKSBjYWxsYmFjayBmb3IgdGhlIElJTyBidXMsIHdoaWNoIGlzIHRoZW4gdXNl
ZCBieSB0aGUgY29yZSANCj4gPiBkZXZpY2VfZ2V0X2Rldm5vZGUoKSBmdW5jdGlvbi4NCj4gPiAN
Cg==
