Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB211A734C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 08:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405760AbgDNGHh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 02:07:37 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:26168 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405711AbgDNGHf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 02:07:35 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03E64XXO025247;
        Tue, 14 Apr 2020 02:07:21 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0b-00128a01.pphosted.com with ESMTP id 30bah6qmet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Apr 2020 02:07:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIjzhk+Ei+uaKlUBmXDLQQhsAGUgGL2hyFaC9l8ScCl75JDNy88ckwJiHqi/sJPRjRMVY7M0Ud2I9BbWK8BYMFjNxc0bzgC8E1I4u1rAjSfCtlFm8yy/+LCpMZMAYdXI+/91aPuDD6FQkKm/H8K95f0KBPjVd+Mv7XYlbEWSz75UPPba2Dg4Fe2Sdz/GC0mIg1jAapoM9pvgVQ0q62yUSitvlqP6Inrhy7JZiEDRpeZSX/MRPb4nhIFfQNESqv7pA9klLAWe8mfDeGQ5XqoRJDj/pz1RZIvAfz26wHgIYN4lHqkEAoQBCUYIR7p27exU/eLk7WCNQ+atu2zEYSkB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBk+KuYJBJnaAsfzgTG9qxN2i9Gj1NBqwkbMZxVy0xE=;
 b=VewaIXRZ3ZZVp38Qgg4CiaxGuUWofJnXRH7DPUDOvKSi7FRv8vOqmUWNBTKRvTpEZOxXd6B1ocPT9sh8LpVezNrcjf5k8vqrBAAy4eIZUVX/lCeOEHrfzrRZWlA2mjyh/WIi/FKrVL9JbhWzS8mwo5FlEkDikIctgoFZ8p3N4p7LvSgqCUmJuPhnSfkl9+id9JY17/wtjyu99wbCipSRkfjof+xhmuWAzBn/54Sq7hYOsefrbR73SVa6JPkEIfZSYfX5197r3H5rioRsALjyUO0cFrt2kCPKxyrM52RQVm3flzbfnpSMt31EV5HFm70m1vyHhxVaiQ51Dutekb6xIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBk+KuYJBJnaAsfzgTG9qxN2i9Gj1NBqwkbMZxVy0xE=;
 b=fi214NeIunmoZlKTPS91eYCFPsMf4VDoW7r/4wiV6uw5zhVmep8SRhz/eYXvDWKhj34qDaJ5ZIvm+AqEASEZmWqnafav+BBQ8duzZdswogrnEXP5NJb5ITR27UTt/Wac5bwxztMrI0ovwDvF8qDQkTeb/wFzrh3f7VkNr8daXuA=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3577.namprd03.prod.outlook.com (2603:10b6:5:aa::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 06:07:19 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2900.026; Tue, 14 Apr 2020
 06:07:19 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v3 1/5] iio: core: register buffer fileops only if buffer
 present
Thread-Topic: [PATCH v3 1/5] iio: core: register buffer fileops only if buffer
 present
Thread-Index: AQHWD0KnO2OJL38DS0W/y8nQFzbZ0Kh3NyMAgADkKACAAAwWAA==
Date:   Tue, 14 Apr 2020 06:07:19 +0000
Message-ID: <c7120e71c7d0811eebab59186e262bd294763a67.camel@analog.com>
References: <20200410141729.82834-1-alexandru.ardelean@analog.com>
         <20200410141729.82834-2-alexandru.ardelean@analog.com>
         <20200413164726.5e5e2efd@archlinux>
         <17b4c332f285cf3cbc6ad6f7ce2960740c055a35.camel@analog.com>
In-Reply-To: <17b4c332f285cf3cbc6ad6f7ce2960740c055a35.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d068aed-3bf1-4696-4325-08d7e03a16fc
x-ms-traffictypediagnostic: DM6PR03MB3577:
x-microsoft-antispam-prvs: <DM6PR03MB35774485ACA5CD357A6D1606F9DA0@DM6PR03MB3577.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(36756003)(6512007)(2906002)(6506007)(54906003)(76116006)(91956017)(66946007)(26005)(316002)(66446008)(64756008)(66556008)(66476007)(478600001)(5660300002)(86362001)(186003)(6486002)(8936002)(71200400001)(81156014)(6916009)(2616005)(8676002)(4326008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RoJHegMBiSllah9DC/g+a2C3NYFofQYelMPyX8LS3hmKslGrbaf41OhQHv6HinxrFwLmP3cYEQX9gIVog2I5vQMDs3kdTBsixkycLJ/n4SHP58k7ydpbsgMPXTM5bTUhGIOg+lFiAbCYt+JNeiffBAvomDBHNGed2/yP5Ptsgwg/TrcM5lfqCs/Hu03E/P4dtr9DjPysmqNTxuwxLC1eIC5JqbL8mLEr00llP3lzgirk17jmNUqYFMvy7i6jLLtOAZHgXn1qJLnG92E1LEH4FNOexUuwrioAgv9le/ag2zR0mv3qUWK+W43tN1Adr6nIKcj4B+33nIOB1v9ymvH2TgKdjSeLmo3x/eBUJTs6K7lc8Bam9HonrZ2q57h2cW81UH4Dy/OpbvNke5PRDg+drtOSaFMAwyCfuHIpyGg7ZuoUeSSe9BCT0fb0rn1xp6Hf
x-ms-exchange-antispam-messagedata: sAFgn+EyZi6CRgyG2yQM6NlEhwXB6fZmZcHsXkUlyD21ns5qQEj7aN4+OleyyYjkjE8M2NdpDGPXNdiX5jvbbTz1l5q85QsFJf3jszg7PpE7wrZO0RT4vEptaH6n2Td+Uk/ooLwuoyXG8a81nIGibQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B6CE3A5F12A06478DB1BD999F513F8C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d068aed-3bf1-4696-4325-08d7e03a16fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 06:07:19.3151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9qeS82Yr1T3CZT39zwfSM1fSU5/X265Zwgbb4v/hfr9a0TEUIUiS3gWG5HzDsaDbUyG0FUfs7a3U3q1M8wygzsrrMrzjeWdwfrEfVmJQow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3577
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_01:2020-04-13,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140048
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTE0IGF0IDA1OjIwICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdy
b3RlOg0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIDIwMjAtMDQtMTMgYXQgMTY6NDcgKzAx
MDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4gW0V4dGVybmFsXQ0KPiA+IA0KPiA+IE9u
IEZyaSwgMTAgQXByIDIwMjAgMTc6MTc6MjUgKzAzMDANCj4gPiBBbGV4YW5kcnUgQXJkZWxlYW4g
PGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiANCj4gPiA+IFRoZSBp
bnRlbnQgaXMgdG8gbG9jYWxpemUgYWxsIGJ1ZmZlciBvcHMgaW50byB0aGUgaW5kdXN0cmlhbGlv
LWJ1ZmZlci5jDQo+ID4gPiBmaWxlLCB0byBiZSBhYmxlIHRvIGFkZCBzdXBwb3J0IGZvciBtdWx0
aXBsZSBidWZmZXJzIHBlciBJSU8gZGV2aWNlLg0KPiA+ID4gDQo+ID4gPiBXZSBzdGlsbCBuZWVk
IHRvIGFsbG9jYXRlIGEgY2hhcmRldiBpbiBfX2lpb19kZXZpY2VfcmVnaXN0ZXIoKSB0byBiZSBh
YmxlDQo+ID4gPiB0byBwYXNzIGV2ZW50IGlvY3RsIGNvbW1hbmRzLiBTbywgaWYgdGhlIElJTyBk
ZXZpY2UgaGFzIG5vIGJ1ZmZlciwgd2UNCj4gPiA+IGNyZWF0ZSB0aGUgbGVnYWN5IGNoYXJkZXYg
Zm9yIHRoZSBldmVudCBpb2N0bCgpIGNvbW1hbmQuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+
ID4gDQo+ID4gV2hpbHN0IHdlIGFyZSBoZXJlLCBjYW4gd2UgYXZvaWQgYWxsb2NhdGluZyB0aGUg
Y2hhcmRldiBhdCBhbGwgaWYNCj4gPiB3ZSBoYXZlIG5laXRoZXIgYnVmZmVyIHN1cHBvcnQsIG5v
ciBldmVudHM/ICBTbyBkb24ndCBhZGQgdGhlIGNocmRldiB0byB0aGUNCj4gPiBkZXZpY2UuDQo+
IA0KPiBUaGF0IHNob3VsZCBoYXBwZW4gYWZ0ZXIgcGF0Y2ggNS81Lg0KPiBJZiB0aGVyZSBhcmVu
J3QgYW55IGJ1ZmZlcnMsIGFuZCAnaW5kaW9fZGV2LT5ldmVudF9pbnRlcmZhY2UnIGlzIE5VTEws
IG5vDQo+IGNoYXJkZXYgc2hvdWxkIGV4aXN0Lg0KPiANCj4gTWF5YmUgSSBjYW4gcmVkdWNlIHRo
aXMsIGdpdmVuIHRoZSBmYWN0IHRoYXQgdGhpcyBnb2VzIGF3YXkgaW50byBmaWxlcyBsYXRlci4N
Cj4gSSBkaWQgdGhpbmdzIGluIHZlcnktc21hbGwgaW5jcmVtZW50YWwgc3RlcHMgdGhhdCBJIGxh
dGVyIHNxdWFzaGVkLg0KPiANCj4gVGhpcyBwYXRjaCBraW5kIG9mIGhpZ2hsaWdodHMgYW4gaW50
ZXJtZWRpYXRlIHN0ZXAgdG93YXJkcyB0aGUgZmluYWwgcmV3b3JrDQo+IFttb3ZpbmcgY2hhcmRl
dnMgaW50byBmaWxlc10NCg0Kb2guLi4NCnNpbGx5IG1lDQp3ZSBjYW4gY2hlY2sgaWYgJ2luZGlv
X2Rldi0+ZXZlbnRfaW50ZXJmYWNlJyBpcyBOVUxMIGhlcmUgYXMgd2VsbA0KDQoNCj4gDQo+ID4g
VGhhdCBjb3ZlcnMgcXVpdGUgYSB3aWRlIHJhbmdlIG9mIHNsb3cgZGV2aWNlcyBhbmQgaXMgYSBu
aWNlIGluY2lkZW50YWwNCj4gPiBpbXByb3ZlbWVudCAodG8gYmUgaG9uZXN0IEknZCBmb3Jnb3R0
ZW4gd2UgYWN0dWFsbHkgY3JlYXRlZCBhIGNoYXJkZXYNCj4gPiBpbiB0aG9zZSBjaXJjdW1zdGFu
Y2UgOigNCj4gPiANCj4gPiBKb25hdGhhbg0KPiA+IA0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVy
cy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYyB8IDE0ICsrKysrKysrKysrKystDQo+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMgYi9kcml2ZXJz
L2lpby9pbmR1c3RyaWFsaW8tDQo+ID4gPiBjb3JlLmMNCj4gPiA+IGluZGV4IDE1N2Q5NWEyNGZh
YS4uYzhjMDc0NjAyNzA5IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9paW8vaW5kdXN0cmlh
bGlvLWNvcmUuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYw0K
PiA+ID4gQEAgLTE3MDcsNiArMTcwNywxNSBAQCBzdGF0aWMgaW50IGlpb19jaGVja191bmlxdWVf
c2Nhbl9pbmRleChzdHJ1Y3QNCj4gPiA+IGlpb19kZXYNCj4gPiA+ICppbmRpb19kZXYpDQo+ID4g
PiAgDQo+ID4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fYnVmZmVyX3NldHVwX29wcyBub29w
X3Jpbmdfc2V0dXBfb3BzOw0KPiA+ID4gIA0KPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZmls
ZV9vcGVyYXRpb25zIGlpb19ldmVudF9maWxlb3BzID0gew0KPiA+ID4gKwkucmVsZWFzZSA9IGlp
b19jaHJkZXZfcmVsZWFzZSwNCj4gPiA+ICsJLm9wZW4gPSBpaW9fY2hyZGV2X29wZW4sDQo+ID4g
PiArCS5vd25lciA9IFRISVNfTU9EVUxFLA0KPiA+ID4gKwkubGxzZWVrID0gbm9vcF9sbHNlZWss
DQo+ID4gPiArCS51bmxvY2tlZF9pb2N0bCA9IGlpb19pb2N0bCwNCj4gPiA+ICsJLmNvbXBhdF9p
b2N0bCA9IGNvbXBhdF9wdHJfaW9jdGwsDQo+ID4gPiArfTsNCj4gPiA+ICsNCj4gPiA+ICBpbnQg
X19paW9fZGV2aWNlX3JlZ2lzdGVyKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsIHN0cnVjdCBt
b2R1bGUNCj4gPiA+ICp0aGlzX21vZCkNCj4gPiA+ICB7DQo+ID4gPiAgCWludCByZXQ7DQo+ID4g
PiBAQCAtMTc1Nyw3ICsxNzY2LDEwIEBAIGludCBfX2lpb19kZXZpY2VfcmVnaXN0ZXIoc3RydWN0
IGlpb19kZXYNCj4gPiA+ICppbmRpb19kZXYsDQo+ID4gPiBzdHJ1Y3QgbW9kdWxlICp0aGlzX21v
ZCkNCj4gPiA+ICAJCWluZGlvX2Rldi0+c2V0dXBfb3BzID09IE5VTEwpDQo+ID4gPiAgCQlpbmRp
b19kZXYtPnNldHVwX29wcyA9ICZub29wX3Jpbmdfc2V0dXBfb3BzOw0KPiA+ID4gIA0KPiA+ID4g
LQljZGV2X2luaXQoJmluZGlvX2Rldi0+Y2hyZGV2LCAmaWlvX2J1ZmZlcl9maWxlb3BzKTsNCj4g
PiA+ICsJaWYgKGluZGlvX2Rldi0+YnVmZmVyKQ0KPiA+ID4gKwkJY2Rldl9pbml0KCZpbmRpb19k
ZXYtPmNocmRldiwgJmlpb19idWZmZXJfZmlsZW9wcyk7DQo+ID4gPiArCWVsc2UNCj4gPiA+ICsJ
CWNkZXZfaW5pdCgmaW5kaW9fZGV2LT5jaHJkZXYsICZpaW9fZXZlbnRfZmlsZW9wcyk7DQo+ID4g
PiAgDQo+ID4gPiAgCWluZGlvX2Rldi0+Y2hyZGV2Lm93bmVyID0gdGhpc19tb2Q7DQo+ID4gPiAg
DQo=
