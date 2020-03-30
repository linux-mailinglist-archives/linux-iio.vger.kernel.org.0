Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD1197E2B
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 16:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgC3OQP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 10:16:15 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12400 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727359AbgC3OQO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 10:16:14 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UE9epx014221;
        Mon, 30 Mar 2020 10:16:12 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e6eu1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 10:16:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBXEQ5hafVpx3ts3IdXdffef8mBl7W4AwdhGk5xQWKpa3PEIw5du9sKehi5YLSAHaDtPxhqIJvJfirs6TM8+v+G333sXYCEqDLCVcUjrINEtzzNzYHJN+j0lja5aIZKkj9I0NAtkY6x8DM04hd3XLW9rBLlDD+GD6dn76gGc2xg4eXh7sP0oPr9n3H6u9dgXEqQHCekSS5iOkrfMc5L2cwlPc2Zqjx/d4K2KuuHcXCFRUX8EXTVtURih4brnkC/VYPcmJTm5ct0jKQTplhwWuyhpgaeBH1iO24MRSAaPz4UwwdiV6CVcMBcsTjJf7D41jEaTB6sXhZS1kIsSmssiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On8VJ391a3k/R6dkxwyu/6mmX0+rrG0Z8lTd8ehXqeQ=;
 b=lOU65C+1YtXsoHOe4/VPpsTt35ADSS9dlFu0tyTfrvyg6U5zZd9DUfdGYjVk8Jb63cQ8v4hx6YSjxmck1fD0V2FkxqzN5kjxRW/94agssQSC3ByDHna6gvUbFDPw09HMKwVyj9wG4gaon4nq0Yq3hpjINHEP5ZTH98+q7046PIulVKvSviRk2aPgZ3AoESLAK4z+bc0wAPmCLYHTSjpsn4N5b4MBazS9j9xTP9FE2aYuePUxMkIxVYQO4iHTOh9WSUlLW0ZAgIi24N0ucAb6CfrYAWOer3AqJbHxDA/2ApzYFK2WfeakRUz2E377la0XqNda0tuMChhQRbsg3qUzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On8VJ391a3k/R6dkxwyu/6mmX0+rrG0Z8lTd8ehXqeQ=;
 b=QJ+0TFufJstbA1NlmU4sC/dXzLEZFtMXQpjRXNepVhyfH2MYM0d+r8anLw6QRPqPlDVxYv5f5J3y9VjhGlHajkGhQAaPLVZ50CgzrFQZDjLbqKPDUzTFwGSWZ7L22k8DfeuR6xhu9CBkkf9f6XD9FTFuXk02Rp0ePVPMwbZ4R1M=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4377.namprd03.prod.outlook.com (2603:10b6:5:112::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Mon, 30 Mar
 2020 14:16:10 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 14:16:10 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Csomortani, Istvan" <Istvan.Csomortani@analog.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Grozav, Andrei" <Andrei.Grozav@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Nagy, Laszlo" <Laszlo.Nagy@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Costina, Adrian" <Adrian.Costina@analog.com>
Subject: Re: [PATCH v13 8/8] dt-bindings: iio: adc: add bindings doc for
 AD9467 ADC
Thread-Topic: [PATCH v13 8/8] dt-bindings: iio: adc: add bindings doc for
 AD9467 ADC
Thread-Index: AQHWAeLaFJHA9/JyBEWQMKe2keio2KhbPK4AgAANywCABBjAgIAByTeAgAALToA=
Date:   Mon, 30 Mar 2020 14:16:10 +0000
Message-ID: <82bd25c6c05089897986699f9d1f1ee999b16093.camel@analog.com>
References: <20200324134636.64643-1-alexandru.ardelean@analog.com>
         <20200324134636.64643-9-alexandru.ardelean@analog.com>
         <20200326185616.GA2673@bogus>
         <17a99874285734496a97d271dda7368b40e88255.camel@analog.com>
         <20200329111915.0a3211bb@archlinux> <20200330143541.189ba0ad@archlinux>
In-Reply-To: <20200330143541.189ba0ad@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c579a546-027f-42ca-4fba-08d7d4b4e599
x-ms-traffictypediagnostic: DM6PR03MB4377:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB43771E198885A8E326017AD9F9CB0@DM6PR03MB4377.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(2616005)(66946007)(6486002)(6512007)(36756003)(107886003)(2906002)(6916009)(5660300002)(186003)(26005)(8676002)(8936002)(66556008)(4326008)(81166006)(71200400001)(64756008)(478600001)(91956017)(6506007)(54906003)(76116006)(316002)(66446008)(81156014)(66476007)(86362001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vIKWGebuMBgF1TapbYP7wUNeQCjBFN8xAfCEe/cZ4fY+GVJ5kFICOjhhTQJPylb3RoQCMb2WStv5u7y9N2xBBT+b4/MEmgyCWE2o7vatkhJTX7n00wvHpsQPtcTuOiiAIEoAHE3B8bNPm8EOVt1tcK7UilHpTREbsEbg89xNkipBvbPw7k8q+JxG79BiTMKtCRQ48UIAAcrtpw0GRG8CNnZnY+KJaeFk5oAgxjhChOuHtjEr2BMVo8tMW6EFMlXOhNnMIDez85WWLfTbf4wtaGCxzoFLkthASBFK52I+j/k8jr8r3GOkQ5JOEz/stvc37XFInfB8oJpEsbzFUWXTommCRyj4y3n5D7kipEVaq0s/qmux2ZkIsPCixEapkLE/9tvWLcS1qdRyXyWYhVEG9cxnaQPVKr1OAZtuXUhqK8t+OARtIJgh1yC7NuWtSOkg
x-ms-exchange-antispam-messagedata: 29WkoaAlndcSB78Vc+1BjDY3iYkzVQJ5yhREH9vCdfg8X/NRnzPxQ3UtJbHEx/oA+6NaEylzYtAd6nsZTQGgVH4uQpdC94I7yBl60z/mIj8t8meNN2LdZ4JlHkgvuT+14Ls2A+akXv1oSPqy4vdYYw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A02F01966F042A47AE02F202D6294F7B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c579a546-027f-42ca-4fba-08d7d4b4e599
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 14:16:10.5357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hewziet+7qdl1uDMRrryNVcc31qyQAM2wTZm9xpIwr+7YdXf8JKxWZJ15X+Rjjj08ssJZQBYgHd1gQ/G7FcvXRt1c02mxB9Qn3ocXWBChDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-30_01:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003300135
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTMwIGF0IDE0OjM1ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBTdW4sIDI5IE1hciAyMDIwIDExOjE5OjE1ICswMTAwDQo+IEpvbmF0aGFuIENhbWVy
b24gPGppYzIzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gPiBPbiBUaHUsIDI2IE1hciAyMDIw
IDE5OjQ1OjM5ICswMDAwDQo+ID4gIkFyZGVsZWFuLCBBbGV4YW5kcnUiIDxhbGV4YW5kcnUuQXJk
ZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBPbiBUaHUsIDIwMjAtMDMtMjYg
YXQgMTI6NTYgLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOiAgDQo+ID4gPiA+IE9uIFR1ZSwgMjQg
TWFyIDIwMjAgMTU6NDY6MzYgKzAyMDAsIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZTogICAgDQo+
ID4gPiA+ID4gVGhpcyBjaGFuZ2UgYWRkcyB0aGUgYmluZGluZyBkb2MgZm9yIHRoZSBBRDk0Njcg
QURDLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRl
bGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4g
PiA+ID4gIC4uLi9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDk0NjcueWFtbCAgICAgICAgICB8IDY1
DQo+ID4gPiA+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNjUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiA+
ID4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9hZGksYWQ5NDY3
LnlhbWwNCj4gPiA+ID4gPiAgICAgDQo+ID4gPiA+IA0KPiA+ID4gPiBQbGVhc2UgYWRkIEFja2Vk
LWJ5L1Jldmlld2VkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5nIG5ldyB2ZXJzaW9ucy4gSG93ZXZlciwN
Cj4gPiA+ID4gdGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0byBhZGQg
dGhlIHRhZ3MuIFRoZSB1cHN0cmVhbQ0KPiA+ID4gPiBtYWludGFpbmVyIHdpbGwgZG8gdGhhdCBm
b3IgYWNrcyByZWNlaXZlZCBvbiB0aGUgdmVyc2lvbiB0aGV5IGFwcGx5Lg0KPiA+ID4gPiANCj4g
PiA+ID4gSWYgYSB0YWcgd2FzIG5vdCBhZGRlZCBvbiBwdXJwb3NlLCBwbGVhc2Ugc3RhdGUgd2h5
IGFuZCB3aGF0DQo+ID4gPiA+IGNoYW5nZWQuICAgIA0KPiA+ID4gDQo+ID4gPiBNeSBiYWQuIEFw
b2xvZ2llcyBmb3IgdGhhdC4NCj4gPiA+IE5vIGlkZWEgaG93IEkgbWlzc2VkIGFkZGluZyB0aGlz
LiBFc3BlY2lhbGx5IHNpbmNlIEkgYWxyZWFkeSBrbm93IHRoYXQgSQ0KPiA+ID4gc2hvdWxkDQo+
ID4gPiBhZGQgaXQuDQo+ID4gPiANCj4gPiA+IEkgZ3Vlc3MgSSBnb3QgbWl4ZWQgdXAgd2l0aCB0
b28gbWFueSBicmFuY2hlcyBhbmQgbm90IHBheWluZyBhdHRlbnRpb24uICANCj4gPiBGaXhlZCB0
aGUgbWlzc2luZyB0YWcgZnJvbSBSb2IgYW5kIHdob2xlIHNlcmllcyBhcHBsaWVkIHRvIHRoZSB0
b2dyZWcgYnJhbmNoDQo+ID4gb2YNCj4gPiBpaW8uZ2l0LiAgUHVzaGVkIG91dCBhcyB0ZXN0aW5n
IGZvciB0aGUgYXV0b2J1aWxkZXJzIHRvIHBva2UgYXQgaXQuDQo+ID4gDQo+ID4gRXhwb3Npbmcg
dGhlIGRtYSBidWZmZXIgc3R1ZmYgdG8gdGhlIGF1dG9idWlsZGVycyBpcyBncmVhdC4gU28gZmFy
IHRoZSBvbmx5DQo+ID4gaXNzdWUgd2FzIHRoYXQgcGF0Y2ggSSB0b29rIHllc3RlcmRheSB3aGVy
ZSB3ZSBuZWVkIHRvIHJldGhpbmsgdGhpbmdzLg0KPiA+IEhvd2V2ZXIsIHRoYXQncyBqdXN0IG15
IHNhbml0eSBjaGVjayBsb2NhbCBidWlsZCBzbyBJJ20gc3VyZSB3ZSBicm9rZQ0KPiA+IHNvbWUg
b2JzY3VyZSBhcmNoaXRlY3R1cmUgOikNCj4gDQo+IDAtZGF5IGZvdW5kIHNvbWUgaXNzdWVzIGlu
IHRoZSBzZXJpZXMuLiAgTm90ZSBJIHRoaW5rIHRoaXMgaXMgdGhlIGxpc3QgdGhhdA0KPiBoYXNu
J3QgYmVlbiBodW1hbiBzYW5pdHkgY2hlY2tlZCB5ZXQgc28gY2FuIGJlICdpbnRlcmVzdGluZycu
DQo+IA0KPiBkcml2ZXJzL2lpby9hZGMvYWQ5NDY3LmM6Mjg4OjEzOiB3YXJuaW5nOiBDaGVja2lu
ZyBpZiB1bnNpZ25lZCBleHByZXNzaW9uDQo+ICdyX2NsaycgaXMgbGVzcyB0aGFuIHplcm8uIFt1
bnNpZ25lZExlc3NUaGFuWmVyb10NCj4gcl9jbGsgPSBjbG9ja19yb3VuZF9yYXRlIHRoYXQgY2Fu
IGluZGVlZCByZXR1cm4gYSBuZWdhdGl2ZSAobG9uZykNCj4gSSd2ZSBkcm9wcGVkIHRoZSB1bnNp
Z25lZCBnaXZlbiB3ZSBjaGVjayBmb3IgbmVnYXRpdmUgc28gdGhpcyBzaG91bGQgYmUgc2FmZS4N
Cj4gDQo+IGRyaXZlcnMvaWlvL2FkYy9hZDk0NjcuYzozODE6Nzogd2FybmluZzogVmFyaWFibGUg
J3JldCcgaXMgYXNzaWduZWQgYSB2YWx1ZQ0KPiB0aGF0IGlzIG5ldmVyIHVzZWQuIFt1bnJlYWRW
YXJpYWJsZV0NCj4gTWlzc2luZyBlcnJvciBjaGVjay4gSSd2ZSBhZGRlZCBpdC4gUGxlYXNlIHNh
bml0eSBjaGVjayBpbiB0aGUgdGVzdGluZyBicmFuY2guDQo+IA0KPiANCj4gZHJpdmVycy9paW8v
YWRjL2FkaS1heGktYWRjLmM6MTU4OjE4OiB3YXJuaW5nOiBUaGUgc2NvcGUgb2YgdGhlIHZhcmlh
YmxlDQo+ICdjdHJsJyBjYW4gYmUgcmVkdWNlZC4gW3ZhcmlhYmxlU2NvcGVdDQo+IFRoaXMgb25l
IGlzIHNpbGx5LiAgU3VyZSB5b3UgY291bGQgcmVkdWNlIHRoZSBzY29wZSwgYnV0IHRoZXJlIGlz
IGxpdHRsZSByaXNrDQo+IGluIG5vdCBkb2luZyBzbyBnaXZlbiBhbGwgdGhlDQo+IGZ1bmN0aW9u
IGNvbnRhaW5zIGlzIG9uZSBsb29wLg0KPiANCj4gZHJpdmVycy9paW8vYWRjL2FkaS1heGktYWRj
LmM6MzU0OjMyOiB3YXJuaW5nOiBSZWR1bmRhbnQgYXNzaWdubWVudCBvZiAnY29udicNCj4gdG8g
aXRzZWxmLiBbc2VsZkFzc2lnbm1lbnRdDQo+IFRoaXMgb25lIGlzIHJlYWwuIEZpeGVkIHVwLiBj
b252ID0gY29udiA9IHN0LT4uLi4NCk9vcHMuDQpNYXkgaGF2ZSBiZWVuIGNvcHkgKyBwYXN0ZSBl
cnIuDQoNCj4gDQo+IGRyaXZlcnMvaWlvL2FkYy9hZGktYXhpLWFkYy5jOjM1NTo5OiB3YXJuaW5n
OiBUaGUgc2NvcGUgb2YgdGhlIHZhcmlhYmxlICdyZXQnDQo+IGNhbiBiZSByZWR1Y2VkLiBbdmFy
aWFibGVTY29wZV0NCj4gQWdhaW4sIHNvbWV3aGF0IHNpbGx5LiANCj4gDQo+IFNvIEkndmUgaWdu
b3JlZCAyIG9mIHRoZW0uICBXZSAnY291bGQnIGZpeCB0aGVzZSBidXQgdW50aWwgSSBnZXQgdGhl
IGZlZWxpbmcNCj4gdGhlIGtlcm5lbCBjb2Rpbmcgc3R5bGUgaGFzIGFjdHVhbGx5IGNoYW5nZWQg
dG8gc3BlY2lmeSB0aGlzIHJhdGhlciB0aGFuIGl0DQo+IGJlaW5nIGEgbWF0dGVyIG9mIHRhc3Rl
IEknbSBub3QgcGFydGljdWxhcmx5IGluY2xpbmVkIHRvIGRvIHNvLg0KDQpUaGFua3MgZm9yIHRh
a2luZyBjYXJlIG9mIHRoZW0uDQpUaGUgc2NvcGUgcmVkdWN0aW9uIHdhcm5pbmdzIGFyZSBnZXR0
aW5nIGEgYml0IHBvcHVsYXIgd2l0aCBzdGF0aWMtY2hlY2tlcnMuDQpMZXQncyBzZWUgaG93IHRo
YXQgZXZvbHZlcyBsYXRlci4gSSBmZWVsIHRoZXkgbWlnaHQgYmUgY29taW5nIGFsb25nIHRoZSBz
YW1lIHdheQ0KYXMgY2hlY2twYXRjaCBzdHVmZi4NCg0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBK
b25hdGhhbg0KPiANCj4gPiBUaGFua3MsDQo+ID4gDQo+ID4gSm9uYXRoYW4NCj4gPiANCj4gPiAN
Cg==
