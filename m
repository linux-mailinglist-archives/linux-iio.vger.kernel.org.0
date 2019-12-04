Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26F9112377
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2019 08:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfLDHSm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Dec 2019 02:18:42 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39482 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbfLDHSl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Dec 2019 02:18:41 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB47Hu5o023703;
        Wed, 4 Dec 2019 02:18:18 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wkk57tvg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 02:18:17 -0500
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xB47IHMe002532;
        Wed, 4 Dec 2019 02:18:17 -0500
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2055.outbound.protection.outlook.com [104.47.41.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wkk57tvfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 02:18:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbIb9FJ52voLO8HRFOc8ukAHcG0X9yY6dbcciqTs9qfRF1IspBKJgMC7mSBDa2yrsLoEWRzI122Nuab7RMpME71F9kLB4dImdxnceImgpTtca+CRpe/xD2N94a2CkBeucrco0uWG0IT5kqnH2UFcAonkm1vN3aXCdVLP6XHVYV5RXIuZ22XEJCNrKvnGIy5uzz/h4cS5IOIgmvYGBXYYHb+mCHkgebMHG3Bzre/Zsn+9+YrpZlP7cu32QAZyFeyFERQFMDxSgidZJOHAeMsFYrAiObbSOgG+aSpS1MzTZJAXa6z394WxBuMtni1SNWPnQKt4rUTF3wcsL1Q0exkVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJa4tNGNsMudrI2PYwiMwR72qp3OSswN2/tCtkc2F3I=;
 b=eNxSOsiV72UCrNoUaN8gBKkD5t5cbvbdasbruMSvtrji0rPRbQkpp3kRvElBPaXqHD2jOW+pqnJRUgJ/xq6ebthic2yhCCvpns6E+K9HLfqo0azpf7GR5Y09+U0L+KRKrBlZzH76/m8lxV8Gla7sqigkSbD6Xo17c0JsoFhKt1mZHxVq4SjN7eeWpHj8CVHwLfNLUmvwL/5G9okZKDQA3oXs5DwT+VYWz5hMcT2luzWaYqEiXcT0zWf2QKf2I/D7EA6TII++lfADXVmhU9O7YrMDTPeJ51dKONVNS8jm8VwCnDNbvVRZQIjYLg9kdf76ZXTTP6uJH0TIJiKe2by5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJa4tNGNsMudrI2PYwiMwR72qp3OSswN2/tCtkc2F3I=;
 b=dzZSCvMWzMPitJVgTibqsZa13U2r9LZKkCrqFXu289238EdgJDMtouMfk3HMIfJ3MuZW+11tRFhsqF8yYICiY1nYJTR93JwZ8cWZWqXCsbZosq7GfdEvaEryzJcO4MhaZylLJGmzW6OpZAcID6q3EqrOqVKyMUC4PsNLDEZ0W6o=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5175.namprd03.prod.outlook.com (20.180.4.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 07:18:15 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 07:18:15 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v4] dt-bindings: iio: accel: add binding documentation for
 ADIS16240
Thread-Topic: [PATCH v4] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
Thread-Index: AQHVob2/Uuv8Me0otU+pOQKTkzIOdqeYolyAgALkwgCACa2sAIADeAIAgAADpwCAAPJnAA==
Date:   Wed, 4 Dec 2019 07:18:15 +0000
Message-ID: <c725b1b1475148ded6168667fa0227bc18de0854.camel@analog.com>
References: <20191123051927.5016-1-rodrigorsdc@gmail.com>
         <20191123114119.7b0c3447@archlinux>
         <a55b9c576eded8c91a985aabbba89180561ab156.camel@analog.com>
         <20191201114032.1a972dda@archlinux> <20191203163850.GN1998@sirena.org.uk>
         <20191203165154.00005793@Huawei.com>
In-Reply-To: <20191203165154.00005793@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91c52bb7-6976-43c4-0070-08d7788a2115
x-ms-traffictypediagnostic: CH2PR03MB5175:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5175A227D230BEBD3A9C3458F95D0@CH2PR03MB5175.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(66556008)(66946007)(66446008)(76116006)(66476007)(102836004)(26005)(478600001)(91956017)(14454004)(2616005)(71190400001)(7736002)(110136005)(11346002)(14444005)(229853002)(256004)(7416002)(36756003)(99286004)(186003)(316002)(54906003)(76176011)(446003)(305945005)(64756008)(6506007)(71200400001)(3846002)(118296001)(8936002)(86362001)(6512007)(4326008)(2906002)(6246003)(6116002)(6486002)(6436002)(81166006)(25786009)(8676002)(5660300002)(2501003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5175;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yCUbokOfSV9D8hmnnlN7e9YvcfaPg4cJJHsOprEFe8KVUF9zFSgdXnkPqbHtznqt0Kj0qs1DzgZLKAOEcbpjySAIOa3g9Bzm4e7eCBaKiwGpCza+Iyt/nueJTUQX0xIlwczaMj+j4HmJUNipbwCpri2mhKyJo9mBaDfhZrjtOAQ2VD2+R/w7A+1pWmvtYEa4KhE3NFcI9Pkq6r/mrWdByRtez9dmJgpaf0TJwFluuUpeXF0NC0fYkfGrcRKQWDOvf4ViES68wfmO3rI9mT5IBrs492YdRkhFyCWVlXJBX/xbV2tWdBtHRKZ5UFG2jokTZSuacDyImMpt06yHsFQpXvM5GElrH+2ZnWq8ihx8+jG/nI8hEiU1UaFPiwXE1wJ3IvR36GqAvxSIvEFxmBcyU2uajDQTOuXGEHJ8GggP97Lwb81LHVr1JfY7apWg8r1T
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A7949AA1201024DADF66D7201F6A553@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c52bb7-6976-43c4-0070-08d7788a2115
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 07:18:15.0724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ashQjf9xw+jcqUsOqovcXxlpPbV3Jd2sk1iGnVvR64gjkkYlcqiSIy9XK3T6zWR32ec9EwVo5Ake3k+Xx7NLDZclVTIUfphfDC9SRzPny/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5175
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_01:2019-12-04,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTAzIGF0IDE2OjUxICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsIDMgRGVjIDIwMTkgMTY6Mzg6NTAgKzAwMDANCj4gTWFyayBCcm93biA8YnJv
b25pZUBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+ID4gT24gU3VuLCBEZWMgMDEsIDIwMTkgYXQg
MTE6NDA6MzJBTSArMDAwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gPiANCj4gPiA+ICtD
QyBNYXJrIGFzIHdlIHByb2JhYmx5IG5lZWQgYSBtb3JlIGdlbmVyYWwgdmlldyBwb2ludCBvbg0K
PiA+ID4gdGhlIHF1ZXN0aW9uIG9mIHdoZXRoZXIgU1BJIG1vZGUgc2hvdWxkIGJlIGVuZm9yY2Vk
IGJ5IGJpbmRpbmcNCj4gPiA+IG9yIGluIHRoZSBkcml2ZXIuICANCj4gPiANCj4gPiBOb3Qgc3Vy
ZSBJIHNlZSB0aGUgcXVlc3Rpb24gaGVyZSwgSSB0aGluayBJIHdhcyBtaXNzaW5nIGEgYml0IG9m
DQo+ID4gdGhlIGNvbnZlcnNhdGlvbj8gIEl0J3MgcGVyZmVjdGx5IGZpbmUgZm9yIGEgZHJpdmVy
IHRvIHNwZWNpZnkgYQ0KPiA+IG1vZGUsIGlmIHRoZSBoYXJkd2FyZSBhbHdheXMgdXNlcyBzb21l
IHVudXN1YWwgbW9kZSB0aGVuIHRoZXJlJ3MNCj4gPiBubyBzZW5zZSBpbiBmb3JjaW5nIGV2ZXJ5
IHNpbmdsZSBEVCB0byBzZXQgdGhlIHNhbWUgbW9kZS4gIE9uIHRoZQ0KPiA+IG90aGVyIGhhbmQg
aWYgdGhlcmUncyBzb21lIGNvbmZpZ3VyYXRpb24gZm9yIHRoZSBkcml2ZXIgdGhhdCB3YXMNCj4g
PiBoYW5kbGluZyBzb21lIGJvYXJkIHNwZWNpZmljIGNvbmZpZ3VyYXRpb24gdGhhdCB0aGVyZSdz
IGFscmVhZHkNCj4gPiBzb21lIGdlbmVyaWMgU1BJIHN1cHBvcnQgZm9yIHNldHRpbmcgdGhlbiBp
dCBzZWVtcyBvZGQgdG8gaGF2ZSBhDQo+ID4gY3VzdG9tIGRyaXZlciBzcGVjaWZpYyBjb25maWd1
cmF0aW9uIG1lY2hhbmlzbS4NCj4gPiANCj4gDQo+IElmIHRoZSBkcml2ZXIgcGlja3MgYSBtb2Rl
IGJlY2F1c2UgdGhhdCdzIHdoYXQgaXQgc2F5cyBvbiB0aGUgZGF0YXNoZWV0DQo+IGl0IHByZXZl
bnRzIG9kZCBib2FyZCBjb25maWd1cmF0aW9ucyBmcm9tIHdvcmtpbmcuICBUaGUgcXVlc3Rpb24N
Cj4gYmVjb21lcyB3aGV0aGVyIGl0IG1ha2VzIHNlbnNlIGluIGdlbmVyYWwgdG8gYXNzdW1lIHRo
b3NlIG9kZCBib2FyZA0KPiBjb25kaXRpb25zIGRvbid0IGV4aXN0IHVudGlsIHdlIGFjdHVhbGx5
IGhhdmUgb25lLCBvciB0byBhc3N1bWUgdGhhdA0KPiB0aGV5IG1pZ2h0IGFuZCBwdXNoIHRoZSBi
dXJkZW4gb24gdG8gYWxsIERUIGZpbGVzLg0KPiANCj4gVHJhZGl0aW9uYWxseSBpbiBJSU8gYXQg
bGVhc3Qgd2UndmUgbW9zdGx5IHRha2VuIHRoZSB2aWV3IHRoZSBEVA0KPiBzaG91bGQgYmUgcmln
aHQgYW5kIGNvbXBsZXRlIGFuZCBoYWQgYmluZGluZ3Mgc3RhdGUgd2hhdCBub3JtYWwNCj4gcGFy
YW1ldGVycyBtdXN0IGJlIGZvciBpdCB0byB3b3JrIChhc3N1bWluZyBubyBpbnZlcnRlcnMgZXRj
KQ0KPiANCj4gSWYgd2UgZW5jb2RlIGl0IGluIHRoZSBkcml2ZXIsIGFuZCB3ZSBsYXRlciBtZWV0
IHN1Y2ggYSBib2FyZCB3ZQ0KPiBlbmQgdXAgd2l0aCBhIGN1c3RvbSBkYW5jZSB0byBxdWVyeSB0
aGUgRFQgcGFyYW1ldGVycyBhZ2FpbiBhbmQNCj4gb25seSBvdmVycmlkZSBpZiBwcmVzZW50Lg0K
PiANCj4gV2UgY2FuJ3QgcmVseSBvbiB0aGUgY29yZSBTUEkgaGFuZGxpbmcgYmVjYXVzZSBJIGRv
bid0IHRoaW5rDQo+IHRoZXJlIGlzIGFueSBtZWFucyBvZiBzcGVjaWZ5aW5nIGEgZGVmYXVsdC4N
Cj4gDQo+IFdlIGNhbiBhZG9wdCB0aGUgdmlldyB0aGF0IGluIGdlbmVyYWwgdGhlc2Ugd2VpcmQg
Ym9hcmRzIHdpdGggaW52ZXJ0ZXJzDQo+IGFyZSB3ZWlyZCBhbmQganVzdCBoYW5kbGUgdGhlbSB3
aGVuIHRoZXkgb2NjdXIuICBTb3VuZHMgbGlrZSB0aGF0IGlzIHlvdXINCj4gcHJlZmVyZW5jZSwg
YXQgbGVhc3QgZm9yIG5ldyBwYXJ0cy4NCj4gDQo+IEZvciBvbGQgb25lcyB3ZSBoYXZlIG5vIGlk
ZWEgaWYgdGhlcmUgYXJlIGJvYXJkcyBvdXQgdGhlcmUgdXNpbmcNCj4gdGhlbSB3aXRoIGludmVy
dGVycyBzbyBlYXNpZXN0IGlzIHByb2JhYmx5IHRvIGp1c3QgY2Fycnkgb24gcHV0dGluZyB0aGVt
DQo+IGluIHRoZSBEVCBiaW5kaW5ncy4NCg0KVGhlcmUgbWlnaHQgYmUgYSBmZXcgb3RoZXIgb3B0
aW9ucywgd2hpY2ggd291bGQgcmVxdWlyZSBzb21lIFNQSSBPRiBjaGFuZ2UuDQoNCk9uZSBleGFt
cGxlIChmb3Igc3BpLWNwaGEpOg0KICAgICAgICBpZiAob2ZfcHJvcGVydHlfcmVhZF91MzIobmMs
ICJzcGktY3BoYSIsICZ0bXApID09IDApIHsNCiAgICAgICAgICAgICAgICBzcGktPm1vZGUgfD0g
U1BJX0NQSEFfT1ZFUlJJREU7DQogICAgICAgICAgICAgICAgaWYgKHRtcCkNCiAgICAgICAgICAg
ICAgICAgICAgc3BpLT5tb2RlIHw9IFNQSV9DUEhBOw0KICAgICAgICB9IGVsc2UgDQogICAgICAg
ICAgICAgaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChuYywgInNwaS1jcGhhIikpDQogICAgICAg
ICAgICAgICAgICAgIHNwaS0+bW9kZSB8PSBTUElfQ1BIQTsNCg0KT3IgYW5vdGhlciBvcHRpb24g
Y291bGQgYmU6DQogICAgICAgIGlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobmMsICJzcGktY3Bo
YS1vdmVycmlkZSIpKSB7DQogICAgICAgICAgICAgICAgc3BpLT5tb2RlIHw9IFNQSV9DUEhBX09W
RVJSSURFOw0KICAgICAgICBpZg0KKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChuYywgInNwaS1jcGhh
IikpDQogICAgICAgICAgICAgICAgc3BpLT5tb2RlIHw9IFNQSV9DUEhBOw0KDQoNCk5hdHVyYWxs
eSwgdGhpcyB3b3VsZCByZXF1aXJlIHRoYXQgc3BpX3NldHVwKCkgY2hlY2tzIFNQSV9DUEhBX09W
RVJSSURFIGFuZA0KZG9lc24ndCBzZXQgU1BJX0NQSEEgaWYgU1BJX0NQSEFfT1ZFUlJJREUgaXMg
c2V0LiANCg0KT3IgbWF5YmUsIGEgbW9yZSBjb21wbGV0ZSBzb2x1dGlvbiB3b3VsZCBiZSBhbiAi
c3BpLW1vZGUtY29udiIgZHJpdmVyLg0KU2ltaWxhciB0byB0aGUgZml4ZWQtZmFjdG9yLWNsb2Nr
IGNsayBkcml2ZXIsIHdoaWNoIGp1c3QgZG9lcyBhIGNvbXB1dGF0aW9uDQpiYXNlZCBvbiB2YWx1
ZXMgZnJvbSB0aGUgRFQuDQoNClRvIHRlbGwgdGhlIHRydXRoLCB0aGlzIHdvdWxkIGJlIGEgZ3Jl
YXQgaWRlYSwgYmVjYXVzZSB3ZSBoYXZlIHNvbWV0aGluZw0KbGlrZSBhIHBhc3NpdmUgMy13aXJl
LXRvLTQtd2lyZSBIREwgY29udmVydGVyLiBUaGlzIHJlcXVpcmVzIHRoYXQgdGhlDQpkcml2ZXIg
YmUgY29uZmlndXJlZCBpbiAzLXdpcmUgbW9kZSwgdGhlIFNQSSBjb250cm9sbGVyIGluIG5vcm1h
bCA0LXdpcmUuDQpUaGF0J3MgYmVjYXVzZSB0aGUgU1BJIGZyYW1ld29yayBkb2VzIGEgdmFsaWRh
dGlvbiBvZiB0aGUgc3VwcG9ydGVkIG1vZGVzDQooZm9yIHRoZSBTUEkgY29udHJvbGxlcikgYW5k
IGludmFsaWRhdGVzIHdoYXQgdGhlIGRldmljZSB3YW50cyAod2hpY2ggaXMNCnZlcnkgcmVhc29u
YWJsZSkuDQoNCkFuICJzcGktbW9kZS1jb252IiBkcml2ZXIgd291bGQgYWxzbyBoYW5kbGUgdGhp
cyAzLXdpcmUtNC13aXJlIGRhbmNlLCBhbmQNCnRoZSBsZXZlbCBpbnZlcnNpb25zLCBhbmQgb3Ro
ZXIgKHNpbWlsYXIpIHRoaW5ncy4NCg0KVGhvdWdodHM/DQpBbGV4DQoNCj4gDQo+IEpvbmF0aGFu
DQo+IA0KPiANCg==
