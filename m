Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5311EF596
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2019 07:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfKEGml (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Nov 2019 01:42:41 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:37170 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbfKEGml (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2019 01:42:41 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA56YHNK032497;
        Tue, 5 Nov 2019 01:42:09 -0500
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2055.outbound.protection.outlook.com [104.47.48.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a9ykpr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 01:42:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzXIBxPMyxvoAa+/9ethWgHHKPbHL8vv3RBHplTE+x6WJrm89ozgsWj3UpBFDsP+9aT6xqo0OfFwHsYLbp54D9Tro8vNmLiKao55Ilv7Xh3/pqdoEYzzhyw22ga0fzvZ9/J1xtp9AwSlBLJHfxRYGIK3GB6b3kK3jpfzdkB4yElBNwcHXSmNEbWWkkRgI3wXtOswHuEur0Gm+w01jG3tX2yPELsk60oFAyjrTVkwhDhwUXKBLYjRVDuybU07YSWY5q4QybvKVN2pgWSfs/U/FGaaeFgp2HddUW79boQZh8u/PZpmq5x764DGjfP0fQGOlkRsJXDAIYoRdwltAMyGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Nzsj8DhK5OzZ3qy6HBsZZdr4uSq/j5y0hWXX/DjQxA=;
 b=cRygnnwyWl0yPA4dRouu8XuIsCZkyyThdfPBviKQm59/awCa5JjB/920DUg86CjKrBBLGYkfF9qJP06yERspeUXnJ4CFsdBv6pm0LVtVjLn2uWdQlecypR/UdPp8re9apqGaUjR/fyip/pnfz01hmotzmzh/ujw32oaoWo/PWlFPhSpr/O27y/doI/eTYeV6UhEqbhnYned8wWl/yfUmOVWWJl0ZpUEHZTTP/QWzDRCpnMANVjPMzoA7OfJCP0+Ox/sSyTznAbTFSgerhiEzWq8UHCt1DCqPH1NZzwrg4zO1HCZik9MTjugn8uvBA2ufhTfCsT+oa1ifRBpmL53hZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Nzsj8DhK5OzZ3qy6HBsZZdr4uSq/j5y0hWXX/DjQxA=;
 b=ljGlBm/ntgdrgjzzN0z2e/BubTZYCGhA8m+KKkkKsQNXWo6lZedyCQjFIBDTOBLjZ/mX/x4QT4Q8OfUeeoqncsfcceHHL+FkCjdhFwdRBLR0vzQRI7YMzNCNAkX6Sr6TWO91/Rh0XVoLPZlpKR19AdJXRby7QJs5w3pq7EYpyGc=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5175.namprd03.prod.outlook.com (20.180.4.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 06:42:06 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 06:42:06 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "marcus.folkesson@gmail.com" <marcus.folkesson@gmail.com>,
        "kent@minoris.se" <kent@minoris.se>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: dac: Migrate LTC1660 documentation to
 yaml
Thread-Topic: [PATCH] dt-bindings: iio: dac: Migrate LTC1660 documentation to
 yaml
Thread-Index: AQHVkzalNPk4IifWQ0mCU1TYqa7gMqd8IgwA
Date:   Tue, 5 Nov 2019 06:42:06 +0000
Message-ID: <00785b238251ad5b2eb3268693bae357a0a94c1b.camel@analog.com>
References: <20191104174036.3535-1-marcus.folkesson@gmail.com>
In-Reply-To: <20191104174036.3535-1-marcus.folkesson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75639a71-4436-409e-d306-08d761bb4641
x-ms-traffictypediagnostic: CH2PR03MB5175:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <CH2PR03MB517551834FE5C693ADF0BE48F97E0@CH2PR03MB5175.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(14444005)(6436002)(256004)(8676002)(81156014)(6116002)(476003)(86362001)(11346002)(14454004)(446003)(4326008)(36756003)(6306002)(229853002)(6512007)(6486002)(2201001)(478600001)(26005)(3846002)(66066001)(2501003)(486006)(2616005)(118296001)(5660300002)(6506007)(316002)(7736002)(7416002)(99286004)(2906002)(54906003)(186003)(6246003)(81166006)(966005)(110136005)(8936002)(76116006)(66446008)(91956017)(71200400001)(76176011)(71190400001)(305945005)(66946007)(64756008)(66476007)(66556008)(25786009)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5175;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkT79ZXGP83T0JkbVpPrkdaUraZfGzBHB/H8fBbMTLkx4ljz8xQjxqmLSBoBWbJpJ2LO9W2TifIWdK6hUH7Z+8X0nAjaGMrxn+uvuniX8zXrTqlifLW8evz8wqZ6jT9w3cjfJEEogsmLcevFUsPvZ8XCzLwx6mTxv1zW8fe7AddUv0O5nEtQ6QasZd3Dfu6YCJDId7JqNQoriExXtbfecz6QVByZHbUEvo0oPiiKCpRAbyBuHhwsk80Tew9wqbIesgzlDGvBTr25W7dXmJUu0HO9l23Cjrjxk/VYdJrIPG0mLIKhBY+o6YzGcHRn/Nw7YC1I4GOFMHBOZSXnqPSHB94rsdvS/5uIIoLp5cU8O8umaLI+gvrqhf/uby2qM1pXgNsi36qebZ1Qw549+ykSSFugcqAb1rkgqEFriEnUgC29ARJlRKejxmd1d6H2UVPqRnXyM1fhMNUEwCdbiNm8QNlZEpOE9iQmgjm3E56FtmI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9357E54F3DA8F3468DF27908ED761822@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75639a71-4436-409e-d306-08d761bb4641
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 06:42:06.0537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9BbAb32Xc3EHTej3Kc5vk01hY3Ws9mn1P9tRNZgPDnGDHvG6uLgzePIML2UN6aLLzVvVsQ8l7ZJbT/P4cphuLDv/5ivqqPP5v/MPVbZrns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5175
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_02:2019-11-04,2019-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911050052
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTExLTA0IGF0IDE4OjQwICswMTAwLCBNYXJjdXMgRm9sa2Vzc29uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBSZXdyaXRlIGJpbmRpbmdzIHRvIHVzZSBqc29uLXNjaGVt
YSB2b2NhYnVsYXJ5Lg0KDQpIZXksDQoNCk92ZXJhbGwgbG9va3MgZ29vZC4NCg0KQSBmZXcgY29t
bWVudHMgaW5saW5lLg0KUm9iIG1heSBhZGQgbW9yZS4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TWFyY3VzIEZvbGtlc3NvbiA8bWFyY3VzLmZvbGtlc3NvbkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAg
Li4uL2JpbmRpbmdzL2lpby9kYWMvbGx0YyxsdGMxNjYwLnlhbWwgICAgICAgIHwgNTQgKysrKysr
KysrKysrKysrKysrKw0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2RhYy9sdGMxNjYw
LnR4dCAgIHwgMjEgLS0tLS0tLS0NCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAyICstDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDU1IGluc2VydGlvbnMo
KyksIDIyIGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZGFjL2xsdGMsbHRjMTY2MC55YW1sDQo+ICBkZWxl
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9kYWMv
bHRjMTY2MC50eHQNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaWlvL2RhYy9sbHRjLGx0YzE2NjAueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9paW8vZGFjL2xsdGMsbHRjMTY2MC55YW1sDQo+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uMWYzMTM2YmZmZmNkDQo+IC0tLSAvZGV2
L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9kYWMv
bGx0YyxsdGMxNjYwLnlhbWwNCj4gQEAgLTAsMCArMSw1NCBAQA0KPiArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMA0KPiArIyBDb3B5cmlnaHQgMjAxOSBNYXJjdXMgRm9sa2Vzc29u
IDxtYXJjdXMuZm9sa2Vzc29uQGdtYWlsLmNvbT4NCj4gKyVZQU1MIDEuMg0KPiArLS0tDQo+ICsk
aWQ6ICJodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9iaW5kaW5ncy9paW8vZGFjL2xsdGMs
bHRjMTY2MC55YW1sIyINCj4gKyRzY2hlbWE6ICJodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1z
Y2hlbWFzL2NvcmUueWFtbCMiDQo+ICsNCj4gK3RpdGxlOiBMaW5lYXIgVGVjaG5vbG9neSBNaWNy
b3Bvd2VyIG9jdGFsIDgtQml0IGFuZCAxMC1CaXQgREFDcw0KPiArDQo+ICttYWludGFpbmVyczoN
Cj4gKyAgLSBNYXJjdXMgRm9sa2Vzc29uIDxtYXJjdXMuZm9sa2Vzc29uQGdtYWlsLmNvbT4NCj4g
Kw0KPiArZGVzY3JpcHRpb246IHwNCj4gKyAgQmluZGluZ3MgZm9yIHRoZSBMaW5lYXIgVGVjaG5v
bG9neSBNaWNyb3Bvd2VyIG9jdGFsIDgtQml0IGFuZCAxMC1CaXQNCj4gREFDLg0KPiArICBEYXRh
c2hlZXQgY2FuIGJlIGZvdW5kIGhlcmU6IA0KPiBodHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlh
L2VuL3RlY2huaWNhbC1kb2N1bWVudGF0aW9uL2RhdGEtc2hlZXRzLzE2NjU2MGZhLnBkZg0KPiAr
DQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0KPiArICAgIGVudW06DQo+ICsgICAg
ICAtIGxsdGMsbHRjMTY2MA0KPiArICAgICAgLSBsbHRjLGx0YzE2NjUNCj4gKw0KPiArICByZWc6
DQo+ICsgICAgZGVzY3JpcHRpb246IFNQSSBjaGlwIHNlbGVjdCBudW1iZXIgZm9yIHRoZSBkZXZp
Y2UNCg0KWW91IGNhbiByZW1vdmUgZGVzY3JpcHRpb24uDQpJdCdzIGEgc3RhbmRhcmQgcHJvcGVy
dHkuDQoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIHNwaS1tYXgtZnJlcXVlbmN5Og0K
PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsgICAgICBEZWZpbml0aW9uIGFzIHBlciBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS0NCj4gYnVzLnR4dC4NCj4gKyAgICBt
YXhpbXVtOiA1MDAwMDAwDQo+ICsgICAgbWF4SXRlbXM6IDENCg0KSSB0aGluayB5b3UgY2FuIHBy
b2JhYmx5IHJlbW92ZSBgc3BpLW1heC1mcmVxdWVuY3lgIGZyb20gaGVyZS4NCkl0J3MgZG9jdW1l
bnRlZCBpbiB0aGUgYmFzZSBTUEkgc2NoZW1hLg0KDQo+ICsNCj4gKyAgdnJlZi1zdXBwbHk6DQo+
ICsgICAgZGVzY3JpcHRpb246IFBoYW5kbGUgdG8gdGhlIGV4dGVybmFsIHJlZmVyZW5jZSB2b2x0
YWdlIHN1cHBseS4NCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICtyZXF1aXJlZDoNCj4gKyAg
LSBjb21wYXRpYmxlDQo+ICsgIC0gcmVnDQo+ICsgIC0gdnJlZi1zdXBwbHkNCj4gKw0KPiArZXhh
bXBsZXM6DQo+ICsgIC0gfA0KPiArICAgIHNwaSB7DQo+ICsgICAgICAjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCj4gKyAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiArICANCj4gKyAgICAgIGRhY0Aw
IHsNCj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJsbHRjLGx0YzE2NjAiOw0KPiArICAgICAgICBy
ZWcgPSA8MD47DQo+ICsgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDUwMDAwMDA+Ow0KPiAr
ICAgICAgICB2cmVmLXN1cHBseSA9IDwmdnJlZl9yZWc+Ow0KPiArICAgICAgfTsNCj4gKyAgICB9
Ow0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9k
YWMvbHRjMTY2MC50eHQNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlv
L2RhYy9sdGMxNjYwLnR4dA0KPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggYzVi
NWYyMmQ2YzY0Li4wMDAwMDAwMDAwMDANCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2lpby9kYWMvbHRjMTY2MC50eHQNCj4gKysrIC9kZXYvbnVsbA0KPiBAQCAtMSwy
MSArMCwwIEBADQo+IC0qIExpbmVhciBUZWNobm9sb2d5IE1pY3JvcG93ZXIgb2N0YWwgOC1CaXQg
YW5kIDEwLUJpdCBEQUNzDQo+IC0NCj4gLVJlcXVpcmVkIHByb3BlcnRpZXM6DQo+IC0gLSBjb21w
YXRpYmxlOiBNdXN0IGJlIG9uZSBvZiB0aGUgZm9sbG93aW5nOg0KPiAtCQkibGx0YyxsdGMxNjYw
Ig0KPiAtCQkibGx0YyxsdGMxNjY1Ig0KPiAtIC0gcmVnOiBTUEkgY2hpcCBzZWxlY3QgbnVtYmVy
IGZvciB0aGUgZGV2aWNlDQo+IC0gLSB2cmVmLXN1cHBseTogUGhhbmRsZSB0byB0aGUgdm9sdGFn
ZSByZWZlcmVuY2Ugc3VwcGx5DQo+IC0NCj4gLVJlY29tbWVuZGVkIHByb3BlcnRpZXM6DQo+IC0g
LSBzcGktbWF4LWZyZXF1ZW5jeTogRGVmaW5pdGlvbiBhcyBwZXINCj4gLQkgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktYnVzLnR4dC4NCj4gLQkgTWF4IGZyZXF1ZW5j
eSBmb3IgdGhpcyBjaGlwIGlzIDUgTUh6Lg0KPiAtDQo+IC1FeGFtcGxlOg0KPiAtZGFjQDAgew0K
PiAtCWNvbXBhdGlibGUgPSAibGx0YyxsdGMxNjYwIjsNCj4gLQlyZWcgPSA8MD47DQo+IC0Jc3Bp
LW1heC1mcmVxdWVuY3kgPSA8NTAwMDAwMD47DQo+IC0JdnJlZi1zdXBwbHkgPSA8JnZyZWZfcmVn
PjsNCj4gLX07DQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGlu
ZGV4IGZiY2NjOWQ0NTBmZi4uMjM0OTdkNzEzMjk4IDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVS
Uw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtOTYxOSw3ICs5NjE5LDcgQEAgTFRDMTY2MCBE
QUMgRFJJVkVSDQo+ICBNOglNYXJjdXMgRm9sa2Vzc29uIDxtYXJjdXMuZm9sa2Vzc29uQGdtYWls
LmNvbT4NCj4gIEw6CWxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gIFM6CU1haW50YWluZWQN
Cj4gLUY6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZGFjL2x0YzE2NjAu
dHh0DQo+ICtGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2RhYy9sbHRj
LGx0YzE2NjAueWFtbA0KPiAgRjoJZHJpdmVycy9paW8vZGFjL2x0YzE2NjAuYw0KPiAgDQo+ICBM
VEM0MjYxIEhBUkRXQVJFIE1PTklUT1IgRFJJVkVSDQo=
