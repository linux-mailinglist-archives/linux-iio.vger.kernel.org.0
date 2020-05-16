Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FA1D6134
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 15:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgEPNJG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 09:09:06 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:51926 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbgEPNJF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 May 2020 09:09:05 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04GCxkiM027393;
        Sat, 16 May 2020 09:08:50 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-00128a01.pphosted.com with ESMTP id 312a16rxr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 May 2020 09:08:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGP6d8/mQN2cACE/jEqIJq7wRtaNGCtndnKPiWQPGBsKjTNfKC+AIMs7tyQYQyZi8G/1BRLU0KQpxg3aQVmid4gqvFv6Y0DSSbq1bMg6Z+V4Xu6eNIlRJ/4dBshdNl8O9q19kcYXA/C9EkmZsOwwt0HW7luW+2bSvoFGYQYgW4QDmbYO734h1xymJiSF45o4OaC6s1u2Ygs3Ykw31ag+GKRthm9Myajv+JeUNWpelkbXVj/V2Oz1m915hBhoujaAzyUk0bkQAeQfmSN9Tm8IjmuhI9Leho4eJn3g/yKnivlzXE926q7TFyetb16fIrKYsGhfDDg12sqdzN2qX1Ryjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hY1zpy62gTxRfQVqMJujCwWNvbKh7YC+YHKp1C8YYo=;
 b=ZMz7WEjp42sgKpLPnz9RnRNa0sxIrXZpc765ujWT52Mp1XXyCrHJch2YYIXemw8y3A03sq+yadRaMWIrdth2ncpl5s2AnDW3iKOBk0+TuexQpOUMKgPqz+fxlCCqXJogYxn/IHip70dZB74iyWuDZ82OUZ0x4D/Jg57Ov6BuM+Az+z1Yb3DsqRjRCBwjWuN3BOmwdYIvDdyzipq5wVtPrhhvhnnBtsT9/3MmrJsa9epZjCh4w5wGgxyJrU8l0mFoNiUXcc5/9qoXQsVGkW7cH2bDcTpTHe4WjXlsyC4hiiCGB2uya/zn5VkwP752cVB03xEI7feVFslAb2sdjrJukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hY1zpy62gTxRfQVqMJujCwWNvbKh7YC+YHKp1C8YYo=;
 b=HWGiuV+abuAUprbe9owihjtRzZ3w2lWSjhT0q8IkNH1NLCGlihtYZH/PZchjGK86Wp9viOzmDjrt9vT8tgpCEP6+ikUsoP9yyfWlU05fipSVYEOGD4i6yrogwRBdLtqoQ/g/mW1AXING17L34MVq+d7lWcoh3ktnjTRcfB4m2Hg=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3996.namprd03.prod.outlook.com (2603:10b6:5:e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20; Sat, 16 May 2020 13:08:47 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.2979.033; Sat, 16 May 2020
 13:08:47 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
Thread-Topic: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
Thread-Index: AQHWJUAdPxP6vzcVf0GdP2M4m7Jctaifc8QAgAGoDQCAAZjjAIAAAUIAgAAoyACAAAXVAIAACUqAgAAQVwCAAFPeAIAAsBSAgAa5nQA=
Date:   Sat, 16 May 2020 13:08:46 +0000
Message-ID: <9e88fd9640ccd9a8d1e3a45a4e328797a7d3a9bf.camel@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
         <a9a47e84-b933-cca6-dcfb-d97a51c8bdd4@metafoo.de>
         <20200510110958.29046a18@archlinux>
         <8c5d9ef5ed4ea9037c5459daa2044d1cd7c5db7a.camel@analog.com>
         <c88b17c3-a9d6-e755-04e8-bc9f225e2a3b@metafoo.de>
         <554fe46f0cdd1cafb313f534c0edd93f5686b806.camel@analog.com>
         <7d2c8174e345bf8e241d48de65066d2606143503.camel@analog.com>
         <9ae7e69b-f4ce-dd2b-d70b-2aac66b19814@metafoo.de>
         <04fda2eb89244dd2bf8e024d4b4405eceffd016c.camel@analog.com>
         <fb6cc3f4-b133-4ba4-a8fb-84349355ebc3@metafoo.de>
         <a85270a78093c78cf90d7503f1652da66b6dd28b.camel@analog.com>
In-Reply-To: <a85270a78093c78cf90d7503f1652da66b6dd28b.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48858f36-0554-4793-54a1-08d7f99a44c5
x-ms-traffictypediagnostic: DM6PR03MB3996:
x-microsoft-antispam-prvs: <DM6PR03MB3996BA419AB47BEAC732764BF9BA0@DM6PR03MB3996.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 040513D301
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLGCJIVdYwhs8Cfql+tInV0uC2qwXQHl0GWIDLPuo6tVfuYyALGvjuCXM8QI6a+Hw7ANoKtZ22zoIXHueM+fWfTgnAh5FFr1EXh4+04h1nF66Mf0b76yDLI31BNbputsVUWKvdk7lNrYaNCxnWEfj282AZBkWvPEinBbLM5V2tu+UeW6lA2StTzqi/uTga8WF1wbAMMh9R16vJ8VEnl8PqO//HC1y2cZ+A2bMdTM+PgdB3ssCqcs40C5f0dpX3qTQub44yoDK53vAHJxHBtiAJvX6Dv5Ifw6/y7+YSi8WdLTl7kbsbD6pSsxrQ8LpfJApMNRpt/0Y5vsvKX8iIg2Ll/q5JXCSRsdT2HUgTsJSnEO70OBYPNIVl9EhGhLKWlnfqmOmTCLmvKnEpsGMtGFmsi/CiuoOwdQ0KwyBJsOPQhr3D+Q8jcFlLH3KQMMONAd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(39860400002)(136003)(396003)(110136005)(4326008)(86362001)(54906003)(316002)(36756003)(186003)(5660300002)(53546011)(6512007)(6486002)(6506007)(8936002)(71200400001)(66446008)(26005)(478600001)(8676002)(2906002)(76116006)(64756008)(91956017)(66946007)(66556008)(2616005)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: AUDTnTyjb1DhZyqo0LjB5a8veyHhIfZKze8lvxpyJmQDPSFog6fisqj3QPHTTXRwVffDyAT6NvfIik8VqpbatJlkUWbjiIRiKVmj5Ma6z+Ud6m0GJqWMgEDrmzKQeHuh1wvAn4EsynvLYwvMF7TSHD+ZgFFd7tsyWQ6pW+juRIq+Ktl/oiL95VNfVfd4jncOU86HciPfjTLlu6/SEulbtSAi3+979qgtutY0SGFSLODiCgOTD+nH79UY+PPvUPYwB6gFfk35cj3/HpbFaNjPgfDJ/0K1kIR9OOXHc5J50LyZByWV+eye9IDnJrWrrvMDyaYE15AQvN39rXODMOKUrKELktTqpmBl45+9RR6h0nDNdHlnwt+xTWI8SA5lou+YtpFsK32f86/Bna3OurI3g4r+0cUrYM/n7xNAHbDm0znoy1ZqcyOrXuMgQBMbfhN3wKOu7dA1O68xNAVAK20vnjBHdC0e+2F5cRw2SnW466gwcT8sPFQZtTW8S9eSzZCX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B7E6E4044589F47B707BAF9F04DDDCB@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48858f36-0554-4793-54a1-08d7f99a44c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2020 13:08:46.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epqAZxyGzyWcWOZ/VrHIHZTmYPyf84c/1KRaDqBeiB+gpUD3MoaQ6upQhEah5AwPIyhD0PYZgrwIoiR5J0P9sIqWRmzUJsb/j3lcu/ym0GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3996
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-16_08:2020-05-15,2020-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005160116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTA1LTEyIGF0IDA2OjI2ICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdy
b3RlOg0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIDIwMjAtMDUtMTEgYXQgMjE6NTYgKzAy
MDAsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToNCj4gPiBbRXh0ZXJuYWxdDQo+ID4gDQo+ID4g
T24gNS8xMS8yMCA0OjU2IFBNLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3RlOg0KPiA+ID4gT24g
TW9uLCAyMDIwLTA1LTExIGF0IDE1OjU4ICswMjAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3JvdGU6
DQo+ID4gPiA+IFtFeHRlcm5hbF0NCj4gPiA+ID4gDQo+ID4gPiA+IE9uIDUvMTEvMjAgMzoyNCBQ
TSwgQXJkZWxlYW4sIEFsZXhhbmRydSB3cm90ZToNCj4gPiA+ID4gPiBPbiBNb24sIDIwMjAtMDUt
MTEgYXQgMTM6MDMgKzAwMDAsIEFyZGVsZWFuLCBBbGV4YW5kcnUgd3JvdGU6DQo+ID4gPiA+ID4g
PiBbRXh0ZXJuYWxdDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIE1vbiwgMjAyMC0wNS0x
MSBhdCAxMjozNyArMDIwMCwgTGFycy1QZXRlciBDbGF1c2VuIHdyb3RlOg0KPiA+ID4gPiA+ID4g
PiBbRXh0ZXJuYWxdDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBPbiA1LzExLzIwIDEy
OjMzIFBNLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IE9uIFN1
biwgMjAyMC0wNS0xMCBhdCAxMTowOSArMDEwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4g
PiA+ID4gPiA+ID4gPiA+IFtFeHRlcm5hbF0NCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiA+ID4gT24gU2F0LCA5IE1heSAyMDIwIDEwOjUyOjE0ICswMjAwDQo+ID4gPiA+ID4gPiA+
ID4gPiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4gd3JvdGU6DQo+ID4gPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gT24gNS84LzIwIDM6NTMgUE0sIEFsZXhh
bmRydSBBcmRlbGVhbiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBbLi4uXQ0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IFdoYXQgSSBkb24ndCBsaWtlLCBpcyB0aGF0IGlpbzpkZXZpY2UzIGhh
cyBpaW86YnVmZmVyMzowDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKHRvDQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gMykuDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBpcyBiZWNhdXNlIHRoZSAn
YnVmZmVyLT5kZXYucGFyZW50ID0gJmluZGlvX2Rldi0NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ZGV2Jy4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBCdXQgSSBkbyBmZWVsIHRoaXMgaXMgY29ycmVj
dC4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTbywgbm93IEkgZG9uJ3Qga25vdyB3aGV0aGVyIHRv
IGxlYXZlIGl0IGxpa2UgdGhhdCBvcg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHN5bWxpbmsgdG8N
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBzaG9ydGVyDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdmVy
c2lvbnMgbGlrZSAnaWlvOmJ1ZmZlcjM6WScgLT4gJ2lpbzpkZXZpY2UzL2J1ZmZlclknLg0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IFRoZSByZWFzb24gZm9yIG5hbWluZyB0aGUgSUlPIGJ1ZmZlciBk
ZXZpY2VzIHRvDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gJ2lpbzpidWZmZXJYOlknDQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBtb3N0bHkgdG8gbWFrZSB0
aGUgbmFtZXMgdW5pcXVlLiBJdCB3b3VsZCBoYXZlIGxvb2tlZA0KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IHdlaXJkDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBkbw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICcvZGV2L2J1ZmZlcjEnIGlmIEkgd291bGQgaGF2
ZSBuYW1lZCB0aGUgYnVmZmVyIGRldmljZXMNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAnYnVmZmVy
WCcuDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU28sIG5v
dyBJJ20gdGhpbmtpbmcgb2Ygd2hldGhlciBhbGwgdGhpcyBpcyBhY2NlcHRhYmxlLg0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IE9yIHdoYXQgaXMgYWNjZXB0YWJsZT8NCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBTaG91bGQgSSBzeW1saW5rICdpaW86ZGV2aWNlMy9paW86YnVmZmVyMzowJyAtPg0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ICdpaW86ZGV2aWNlMy9idWZmZXIwJz8NCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBXaGF0IGVsc2Ugc2hvdWxkIEkgY29uc2lkZXIgbW92aW5nIGZvcndhcmQ/DQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gV2hhdCBtZWFucyBmb3J3YXJkPw0KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IFdoZXJlIGRpZCBJIGxlYXZlIG15IGJlZXI/DQo+ID4gPiA+ID4gPiA+ID4gPiA+IExvb2tp
bmcgYXQgaG93IHRoZSAvZGV2LyBkZXZpY2VzIGFyZSBuYW1lZCBJIHRoaW5rIHdlIGNhbg0KPiA+
ID4gPiA+ID4gPiA+ID4gPiBwcm92aWRlDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGENCj4gPiA+ID4g
PiA+ID4gPiA+ID4gbmFtZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiB0aGF0IGlzIGRpZmZlcmVudCBm
cm9tIHRoZSBkZXZfbmFtZSgpIG9mIHRoZSBkZXZpY2UuIEhhdmUgYQ0KPiA+ID4gPiA+ID4gPiA+
ID4gPiBsb29rDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGF0DQo+ID4gPiA+ID4gPiA+ID4gPiA+IGRl
dmljZV9nZXRfZGV2bm9kZSgpIGluIGRyaXZlcnMvYmFzZS9jb3JlLmMuIFdlIHNob3VsZCBiZQ0K
PiA+ID4gPiA+ID4gPiA+ID4gPiBhYmxlDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHRvDQo+ID4gPiA+
ID4gPiA+ID4gPiA+IHByb3ZpZGUgdGhlIG5hbWUgZm9yIHRoZSBjaGFyZGV2IHRocm91Z2ggdGhl
IGRldm5vZGUoKQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiBjYWxsYmFjay4NCj4gPiA+ID4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+IFdoaWxlIHdlIGFyZSBhdCB0aGlzLCBkbyB3ZSB3
YW50IHRvIG1vdmUgdGhlIG5ldyBkZXZpY2VzDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGludG8NCj4g
PiA+ID4gPiA+ID4gPiA+ID4gYW4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gaWlvDQo+ID4gPiA+ID4g
PiA+ID4gPiA+IHN1YmZvbGRlcj8gU28gaWlvL2J1ZmZlcjA6MCBpbnN0ZWFkIG9mIGlpbzpidWZm
ZXIwOjA/DQo+ID4gPiA+ID4gPiA+ID4gPiBQb3NzaWJseSBvbiB0aGUgZm9sZGVyLiAgSSBjYW4n
dCBmb3IgdGhlIGxpZmUgb2YgbWUgcmVtZW1iZXINCj4gPiA+ID4gPiA+ID4gPiA+IHdoeQ0KPiA+
ID4gPiA+ID4gPiA+ID4gSQ0KPiA+ID4gPiA+ID4gPiA+ID4gZGVjaWRlZA0KPiA+ID4gPiA+ID4g
PiA+ID4gbm90IHRvIGRvIHRoYXQgdGhlIGZpcnN0IHRpbWUgYXJvdW5kIC0gSSdsbCBsZWF2ZSBp
dCBhdCB0aGUNCj4gPiA+ID4gPiA+ID4gPiA+IG15c3RlcmlvdXMgIml0IG1heSB0dXJuIG91dCB0
byBiZSBoYXJkZXIgdGhhbiB5b3UnZCB0aGluay4uLiINCj4gPiA+ID4gPiA+ID4gPiA+IEhvcGVm
dWxseSBub3QgOykNCj4gPiA+ID4gPiA+ID4gPiBJIHdhcyBhbHNvIHRoaW5raW5nIGFib3V0IHRo
ZSAvZGV2L2lpbyBzdWJmb2xkZXIgd2hpbGUgZG9pbmcNCj4gPiA+ID4gPiA+ID4gPiB0aGlzLg0K
PiA+ID4gPiA+ID4gPiA+IEkgY2FuIGNvcHkgdGhhdCBmcm9tIC9kZXYvaW5wdXQNCj4gPiA+ID4g
PiA+ID4gPiBUaGV5IHNlZW0gdG8gZG8gaXQgYWxyZWFkeS4NCj4gPiA+ID4gPiA+ID4gPiBJIGRv
bid0IGtub3cgaG93IGRpZmZpY3VsdCBpdCB3b3VsZCBiZS4gQnV0IGl0IGxvb2tzIGxpa2UgYSBn
b29kDQo+ID4gPiA+ID4gPiA+ID4gcHJlY2VkZW50Lg0KPiA+ID4gPiA+ID4gPiBBbGwgeW91IGhh
dmUgdG8gZG8gaXMgcmV0dXJuICJpaW8vLi4uIiBmcm9tIHRoZSBkZXZub2RlKCkNCj4gPiA+ID4g
PiA+ID4gY2FsbGJhY2suDQo+ID4gPiA+ID4gPiBJIGFkbWl0IEkgZGlkIG5vdCBsb29rIGNsb3Nl
bHkgaW50byBkcml2ZXJzL2lucHV0L2lucHV0LmMgYmVmb3JlDQo+ID4gPiA+ID4gPiBtZW50aW9u
aW5nDQo+ID4gPiA+ID4gPiB0aGlzDQo+ID4gPiA+ID4gPiBhcyBhcyBnb29kIHByZWNlZGVudC4N
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQnV0LCBJIGxvb2tzIGxpa2UgL2Rldi9pbnBwdXQg
aXMgYSBjbGFzcy4NCj4gPiA+ID4gPiA+IFdoaWxlIElJTyBkZXZpY2VzIGFyZSBhIGJ1c190eXBl
IGRldmljZXMuDQo+ID4gPiA+ID4gPiBTaG91bGQgd2Ugc3RhcnQgaW1wbGVtZW50aW5nIGFuIElJ
TyBjbGFzcz8gb3I/DQo+ID4gPiA+ID4gV2hhdCBJIHNob3VsZCBoYXZlIGhpZ2hsaWdodGVkIFti
ZWZvcmVdIHdpdGggdGhpcywgaXMgdGhhdCB0aGVyZSBpcyBubw0KPiA+ID4gPiA+IGRldm5vZGUo
KQ0KPiA+ID4gPiA+IGNhbGxiYWNrIGZvciB0aGUgYnVzX3R5cGUgW3R5cGVdLg0KPiA+ID4gPiBC
dXQgdGhlcmUgaXMgb25lIGluIGRldmljZV90eXBlIDopDQo+ID4gPiBNYW55IHRoYW5rcyA6KQ0K
PiA+ID4gVGhhdCB3b3JrZWQgbmljZWx5Lg0KPiA+ID4gDQo+ID4gPiBJIG5vdyBoYXZlOg0KPiA+
ID4gDQo+ID4gPiByb290QGFuYWxvZzp+IyBscyAvZGV2L2lpby8qDQo+ID4gPiAvZGV2L2lpby9p
aW86ZGV2aWNlMCAgL2Rldi9paW8vaWlvOmRldmljZTENCj4gPiA+IA0KPiA+ID4gL2Rldi9paW8v
ZGV2aWNlMzoNCj4gPiA+IGJ1ZmZlcjAgIGJ1ZmZlcjEgIGJ1ZmZlcjIgIGJ1ZmZlcjMNCj4gPiA+
IA0KPiA+ID4gL2Rldi9paW8vZGV2aWNlNDoNCj4gPiA+IGJ1ZmZlcjANCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBJdCBsb29rcyBsaWtlIEkgY2FuIHNoaWZ0IHRoZXNlIGFyb3VuZCBhcyBuZWVkZWQu
DQo+ID4gPiBUaGlzIGlzIGp1c3QgYW4gZXhwZXJpbWVudC4NCj4gPiA+IEkgbWFuYWdlZCB0byBt
b3ZlIHRoZSBpaW8gZGV2aWNlcyB1bmRlciAvZGV2L2lpbywgdGhvdWdoIHByb2JhYmx5IHRoZSBJ
SU8NCj4gPiA+IGRldmljZXMgd2lsbCBzdGlsbCBiZSBhcm91bmQgYXMgL2Rldi9paW86ZGV2aWNl
WCBmb3IgbGVnYWN5IHJlYXNvbnMuDQo+ID4gPiANCj4gPiA+IFR3byB0aGluZ3MgcmVtYWluIHVu
cmVzb2x2ZWQuDQo+ID4gPiAxLiBUaGUgbmFtZSBvZiB0aGUgSUlPIGJ1ZmZlciBkZXZpY2UuDQo+
ID4gPiANCj4gPiA+IHJvb3RAYW5hbG9nOi9zeXMvYnVzL2lpby9kZXZpY2VzIyBscyBpaW9cOmRl
dmljZTMvDQo+ID4gPiBidWZmZXIgICAgICAgICAgaW5fdm9sdGFnZTBfdGVzdF9tb2RlICAgICAg
ICAgICBuYW1lDQo+ID4gPiBldmVudHMgICAgICAgICAgaW5fdm9sdGFnZTFfdGVzdF9tb2RlICAg
ICAgICAgICBvZl9ub2RlDQo+ID4gPiBpaW86YnVmZmVyOjM6MCAgaW5fdm9sdGFnZV9zYW1wbGlu
Z19mcmVxdWVuY3kgICBwb3dlcg0KPiA+ID4gaWlvOmJ1ZmZlcjozOjEgIGluX3ZvbHRhZ2Vfc2Nh
bGUgICAgICAgICAgICAgICAgc2Nhbl9lbGVtZW50cw0KPiA+ID4gaWlvOmJ1ZmZlcjozOjIgIGlu
X3ZvbHRhZ2Vfc2NhbGVfYXZhaWxhYmxlICAgICAgc3Vic3lzdGVtDQo+ID4gPiBpaW86YnVmZmVy
OjM6MyAgaW5fdm9sdGFnZV90ZXN0X21vZGVfYXZhaWxhYmxlICB1ZXZlbnQNCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiBSaWdodCBub3csIGVhY2ggYnVmZmVyIGRldmljZSBpcyBuYW1lZCAnaWlvOmJ1
ZmZlcjpYOlknLg0KPiA+ID4gT25lIHN1Z2dlc3R0aW9uIHdhcyAgJ2lpbzpkZXZpY2VYOmJ1ZmZl
clknDQo+ID4gPiBJJ20gc3VzcGVjdGluZyB0aGUgbGF0dGVyIGlzIHByZWZlcnJlZCBhcyB3aGVu
IHlvdSBzb3J0IHRoZSBmb2xkZXJzLA0KPiA+ID4gYnVmZmVycw0KPiA+ID4gY29tZSByaWdodCBh
ZnRlciB0aGUgaWlvOmRldmljZVggZm9sZGVycyBpbiAvc3lzL2J1cy9paW8vZGV2aWNlcy4NCj4g
PiA+IA0KPiA+ID4gSSBkb24ndCBmZWVsIGl0IG1hdHRlcnMgbXVjaCB0aGUgZGV2aWNlIG5hbWUg
b2YgdGhlIElJTyBidWZmZXIgaWYgd2UNCj4gPiA+IHN5bWxpbmsNCj4gPiA+IGl0DQo+ID4gPiB0
byBhIHNob3J0ZXIgZm9ybS4NCj4gPiA+ICAgDQo+ID4gPiBJJ20gZ3Vlc3NpbmcsIHdlIHN5bWxp
bmsgdGhlc2UgZGV2aWNlcyB0byBzaG9ydC1oYW5kICdidWZmZXJZJyBmb2xkZXJzIGluDQo+ID4g
PiBlYWNoDQo+ID4gPiAnaWlvOmRldmljZVgnPw0KPiA+IA0KPiA+IEkgdGhpbmsgdGhhdCB3b3Vs
ZCBiZSBhIGJpdCBleGNlc3NpdmUuIE9ubHkgZm9yIHRoZSBsZWdhY3kgYnVmZmVyIHdlIA0KPiA+
IG5lZWQgdG8gaGF2ZSBhIHN5bWxpbmsuDQo+ID4gDQo+ID4gPiBbLi4uXQ0KPiA+ID4gMi4gSSBr
bm93IHRoaXMgaXMgW3N0aWxsXSBzdHVwaWQgbm93OyBidXQgYW55IHN1Z2dlc3Rpb25zIG9uZSBo
b3cgdG8NCj4gPiA+IHN5bWxpbmsNCj4gPiA+IC9kZXYvaWlvOmRldmljZTMgLT4gL2Rldi9paW8v
ZGV2aWNlMy9idWZmZXIwID8NCj4gPiA+IA0KPiA+IERvZXMgbm90IHNlZW0gdG8gYmUgcG9zc2li
bGUuIFVzZXJzcGFjZSB3aWxsIGhhdmUgdG8gdGFrZSBjYXJlIG9mIGl0LiANCj4gPiBUaGlzIG1l
YW5zIHdlIG5lZWQgdG8ga2VlcCBsZWdhY3kgZGV2aWNlcyBpbiAvZGV2LyBhbmQgb25seSBuZXcg
YnVmZmVycyANCj4gPiBpbiAvZGV2L2lpby8uDQo+IA0KPiBPbmUgdGhvdWdodCBhYm91dCB0aGlz
LCB3YXMgdGhhdCB3ZSBrZWVwIHRoZSBjaGFyZGV2IGZvciB0aGUgSUlPIGRldmljZSBmb3INCj4g
dGhpcy4NCj4gaS5lLiAgL2Rldi9paW86ZGV2aWNlWCBhbmQgL2Rldi9paW8vZGV2aWNlWC9idWZm
ZXIwIG9wZW4gdGhlIHNhbWUgYnVmZmVyLg0KPiBUaGlzIG1lYW5zIHRoYXQgZm9yIGEgZGV2aWNl
IHdpdGggNCBidWZmZXJzLCB5b3UgZ2V0IDUgY2hhcmRldnMuDQo+IFRoaXMgYWxzbyBzZWVtcyBh
IGJpdCBtdWNoL2V4Y2Vzc2l2ZS4gTWF5YmUgYWxzbyBpbiB0ZXJtcyBvZiBzb3VyY2UtY29kZS4N
Cj4gSXQgd291bGQgYXQgbGVhc3QgbWVhbiBub3QgbW92aW5nIHRoZSBldmVudC1vbmx5IGNoYXJk
ZXYgdG8gJ2luZHVzdHJpYWxpby0NCj4gZXZlbnQuYycsIE9SIG1vdmUgaXQsIGFuZCBoYXZlIHRo
ZSBzYW1lIGNoYXJkZXYgaW4gMyBwbGFjZXMgWydpbmR1c3RyaWFsaW8tDQo+IGV2ZW50LmMnLCAn
aW5kdXN0cmlhbGlvLWJ1ZmZlci5jJyAmICdpbmR1c3RyaWFsaW8tYnVmZmVyLmMnDQo+IA0KPiBN
YXliZSB0aGlzIHNvcnQtb2YgbWFrZXMgc2Vuc2UgdG8gaGF2ZSBmb3IgYSBmZXcgeWVhcnMva2Vy
bmVsLXJldmlzaW9ucyB1bnRpbA0KPiB0aGluZ3MgY2xlYW4tdXAuDQo+IA0KPiBJIGd1ZXNzIGF0
IHRoaXMgcG9pbnQsIHRoZSBtYWludGFpbmVyIHNob3VsZCBoYXZlIHRoZSBmaW5hbCBzYXkgYWJv
dXQgdGhpcy4NCg0KQW5vdGhlciAnY29tcHJvbWlzZScgaWRlYSwgaXMgdGhhdCB3ZSBtYWtlIHRo
aXMgJy9kZXYvaWlvL2RldmljZVgvYnVmZmVyWScgdGhpbmcNCmEgZmVhdHVyZSBmb3IgbmV3IGRl
dmljZXMsIGFuZCBsZWF2ZSAnL2Rldi9paW86ZGV2aWNlWCcgZGV2aWNlcyBbZm9yIGJ1ZmZlcnNd
IGENCnRoaW5nIGZvciBjdXJyZW50IGRldmljZXMuDQpJdCB3b3VsZCBtZWFuIGFkZGluZyBhICdu
ZXcnIGlpb19kZXZpY2VfYXR0YWNoX2J1ZmZlcigpOyBubyBpZGVhIG9uIGEgbmFtZSBbZm9yDQp0
aGlzIHlldF0uDQoNCk92ZXIgdGltZSwgcGVvcGxlIGNhbiBjb252ZXJ0IGV4aXN0aW5nIGRyaXZl
cnMgdG8gdGhlIG5ldyBJSU8tYnVmZmVyIGZvcm1hdCwgaWYNCnRoZXkgd2FudCB0by4gVGhhdCBh
bHNvIGdpdmVzIHRoZW0gYSBiaXQgYmV0dGVyIGNvbnRyb2wgb3ZlciBzeW1saW5raW5nDQonL2Rl
di9paW86ZGV2aWNlWCcgLT4gJy9kZXYvaWlvL2RldmljZVgvYnVmZmVyWScgW29yIHN5bWxpbmtp
bmcgaW4gcmV2ZXJzZSBpZg0KdGhleSB3YW50IHRvXS4NCg0KVGhhdCBtYXkgY3JlYXRlIGNvbmZ1
c2lvbiBJIGd1ZXNzIGR1cmluZyBhIHRyYW5zaXRpb24gcGVyaW9kLg0KQW5kIGl0IHdvdWxkIFtp
ZGVhbGx5XSBoYXZlIGEgbWVjaGFuaXNtIFtwcmVmZXJhYmx5IGF0IGJ1aWxkL2NvbXBpbGUgdGlt
ZV0gdG8NCm5vdGlmeSB1c2VycyB0byB1c2UgdGhlIG5ldyBJSU8gYnVmZmVyIG1lY2hhbmlzbSBb
dnMgdGhlIG9sZCBvbmVdIHdoZW4gYWRkaW5nDQpuZXcgZHJpdmVycy4NCk90aGVyd2lzZSwgdGhl
cmUncyB0aGUgcmlzayBvZiBwZW9wbGUgY29weWluZyB0aGUgb2xkIElJTyBidWZmZXIgbWVjaGFu
aXNtLg0KVGhpcyBjYW4gYmUgYnJvdWdodC11cCBhdCByZXZpZXcsIGJ1dCDCr1xfKOODhClfL8Kv
IDsgaXQgY2FuIGJlIGFubm95aW5nLg0KDQoNCj4gDQo+ID4gDQo=
