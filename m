Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A561A7A9B
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 14:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440035AbgDNMWt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 08:22:49 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:40185 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440031AbgDNMWs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 08:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1586866967; x=1618402967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yZhZu3Yw8d2fTjKDYWHyka/eeaxi09dz7wD87IiRzqs=;
  b=QYBxqwdKaHrV9Yod/B11rb8tU5PMCk3NUCAR11tNEKpDQwP6B+rg4djx
   2En4bqjorhfWw3UXnHFVh2RITXuIPnj/7qvcF8/8AaNeuPWqob3HqkEhQ
   5vv0yPd9PuqQG3YbrED8oM5hEbvP45QTy3sHufTmvqX3jUU+FTXyw6Oms
   1ydaEZWaP24tpkCMn+NHqFq0lP1w3dp4Q7XQt83QunSebtD6aU3LmT9fv
   /bp6X7FBYButDZwC/1A4H4xLl1hjq6yHsE0Rbd3WwtOeyF2as11ztXWpb
   aWbjNAhuAqIJQVf/MIyjCjpf5AK/LjAhU4at/UNAScPDc9IjYT3psSZk6
   Q==;
IronPort-SDR: zZ1MmLsD2jAugCsCPhMwbhPwEzbCdBftSOb5cnzVDb1C6Wsqi4dLxNiTIJxDppITUCw3bEMgep
 v+Vj0jBZqG4qvrtpECZGG9adtVgvrf//Bh8LFlBoAvRuW8fKY3/6KUlcCXusFwlS68UGFZYvPX
 i58T3QXGDx+RCJ0u54JL40yAFt1PqcuDrh+V5/pt833+HTq6ZVXDBBIaiINLioveJ/khvI7hRQ
 gK1OJFpfkL6DmTrbl+9IF4HsjgFmXd1lGrpAHdLPKW4cgds70WhxW4dYl3dNyvF2aXJU2DnuJs
 9PY=
X-IronPort-AV: E=Sophos;i="5.72,382,1580799600"; 
   d="scan'208";a="9073660"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Apr 2020 05:22:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Apr 2020 05:22:46 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 14 Apr 2020 05:22:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXhqA30l2pUB9D/r67s+kMi6rghRZcx7+UgKwl3paRK5AUykOnyHMFL0kRHa6a3BU0pa3P1AJog9taYTv1Gb8I1FUF1wrGGKpV0pvMg093Jm4hF+NknFaFbkn/6T33oWAWVLPU5jN19girXjYAhk/G5DAcMbSelQTqJHoeDSIdUaG6QS9qYaehGmA197I1FcZH9WvmytAucj05D3LgUhzjGEAwMJ5PLZ6MKE8mL698TreEKEwuWIOPBPuriMfXT9395knSA9LkrZ301Jin5vJdQTJfhuBIk3TkvoPqSjyMQZ8QCDdB2Wr++VYTFzw8/5eT1wMTHBtvOwiJL8tTF+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZhZu3Yw8d2fTjKDYWHyka/eeaxi09dz7wD87IiRzqs=;
 b=cttHSGxhovUsTyGmRVgnf6ijpkKymolN1pn+fy+xB9kdkJwlRskZjA+XTQVzo96kSvDjVo63XZlVPr6mAfuft0YJBVclZ1rC4Ztb5QJp1hNCNshwqDEaYCUlOdNw5VxNSTpuTc8Fx/blXnmgb7+6wcY3C7V3/tZfkr/gSgsX0xsmTzuaZOO1R2KbBd1oNEX9MlhR/5DEk3U5Fl9lmTCCzvcPmDbYvdPcNzMf6PtCWVrernrqutQZmPjuQDK5h620z6DdzbAxPtUJBapRwecBzE8ZXpof2pGyZiI2NLq7GjrAsl5IhJpt26KdQmH+GqenSNFUKWHgyuQNUfVk3xgk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZhZu3Yw8d2fTjKDYWHyka/eeaxi09dz7wD87IiRzqs=;
 b=gOlCKiWI+tzckmYXy/b70tERYkK0qsWnjb47zCuv0hFFDHAUxMjELZ1UIoiqqtXgeGAP3lg2MMACmjJ+wSUQt8UDaNRTQwDH4K1dUsOYLmgvNaD83sLEE/jhOb9cJ1P4Wdi3/xQWohFEJmyDMKx3VThDJw9BxUpwVAQ4MwsQsHs=
Received: from CY4PR11MB1605.namprd11.prod.outlook.com (2603:10b6:910:10::22)
 by CY4PR11MB1575.namprd11.prod.outlook.com (2603:10b6:910:10::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 12:22:45 +0000
Received: from CY4PR11MB1605.namprd11.prod.outlook.com
 ([fe80::7c42:c3d3:aaa:88b]) by CY4PR11MB1605.namprd11.prod.outlook.com
 ([fe80::7c42:c3d3:aaa:88b%12]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 12:22:45 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <alexandru.ardelean@analog.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH v2 1/2] iio: at91-sama5d2_adc: split
 at91_adc_current_chan_is_touch() helper
Thread-Topic: [PATCH v2 1/2] iio: at91-sama5d2_adc: split
 at91_adc_current_chan_is_touch() helper
Thread-Index: AQHV8gB3ISKFiu2vJ0SQVLw/xGJ2m6h3h5YAgAFDNIA=
Date:   Tue, 14 Apr 2020 12:22:45 +0000
Message-ID: <9315e9a7-0703-b119-ca32-69f0c2fcc7de@microchip.com>
References: <20200304084219.20810-1-alexandru.ardelean@analog.com>
 <20200413180556.20638f3b@archlinux>
In-Reply-To: <20200413180556.20638f3b@archlinux>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-originating-ip: [86.120.188.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0194f1e4-1195-41b8-f4ff-08d7e06e8972
x-ms-traffictypediagnostic: CY4PR11MB1575:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB15757365386572A4350CDDA6E8DA0@CY4PR11MB1575.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(396003)(376002)(366004)(39840400004)(346002)(81156014)(8936002)(2906002)(966005)(54906003)(6512007)(4326008)(53546011)(8676002)(71200400001)(107886003)(316002)(6486002)(6506007)(478600001)(110136005)(76116006)(91956017)(5660300002)(186003)(86362001)(66476007)(26005)(36756003)(2616005)(66556008)(64756008)(66946007)(66446008)(31696002)(31686004)(309714004);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ARp8NWJuj1RGanL8KQ9k8uVlujH/dBVTFlzlX86lq3qcf0ZUjWwlEbYxkt5Zg6x4zwJX0KAr4OHkZkr9CdRcobwaJLj1gq8G4QwizWbdo3UgMJCxbdMQZmV5nHxTQPOTtNtBKHFI2SRYmkh67EP/CSsG0E4FjbRQnwOKyqm9Yh5ZCxaEZBWxvl5avEZU8E28jZnCYaym0TSxUrOJ7yDq5fbfYkc3ZkDUpPYte7Ru2K9kADqTK/VDMP/vHfefNejInbyLHgaV0gVfI1yeZkKBl82IGmofm2QcePTyqgmKKVsnkBMhLEMH919xFPsjO7Nq8CHZxdPMMh9RonyboteHbODcNzvuWZ0dinR8AEk7y1cgvIW1lc4GJnl1cgZFyISHOU87jntF3UsMPkoC4LL2e2fG3NM8fpXMGQ5mZVKX06RNq8MoS4z28wk9W2VycpoT3n8FNMRDdZc6885fZcfmQlNKpUV+/V95yWdoc2ZfISzo6StJpsvekefdLsIADQaEzVXjsaXqH122LrOUDWNMJEF0akxdmaDcNahFz2htOMmVP4jR0yXtsvvMIOfNj16h
x-ms-exchange-antispam-messagedata: MIKmMms/WE7LAtOrjt4D2+7DThAFbCukdS2qMOAMFT88t+x4Iw2PKEnoGGZJRsXXIifz71EK2tjB7m95ukTRyCUkEKkDQ78UP5n6V+Djv3nlazFRToTf8L1H4qo6ir1Hfa4ABQHvmLtI/NVIzy4QfA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8492A23634214E40AEFB16EE553D7CE2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0194f1e4-1195-41b8-f4ff-08d7e06e8972
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 12:22:45.0972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xu8ynMoLaBizO9jx/VB5jAWiyz4y1y+SWDwBLTv0eLIei/wxWpXrHftcktkizD7zXRMVa8OchIGxXbXn0iijnpMK01UmMDgHFufIeqj4bAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1575
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMTMuMDQuMjAyMCAyMDowNSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gV2VkLCA0
IE1hciAyMDIwIDEwOjQyOjE4ICswMjAwDQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1
LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4+IFRoaXMgY2hhbmdlIG1vdmVzIHRo
ZSBsb2dpYyB0byBjaGVjayBpZiB0aGUgY3VycmVudCBjaGFubmVsIGlzIHRoZQ0KPj4gdG91Y2hz
Y3JlZW4gY2hhbm5lbCB0byBhIHNlcGFyYXRlIGhlbHBlci4NCj4+IFRoaXMgcmVkdWNlcyBzb21l
IGNvZGUgZHVwbGljYXRpb24sIGJ1dCB0aGUgbWFpbiBpbnRlbnQgaXMgdG8gcmUtdXNlIHRoaXMN
Cj4+IGluIHRoZSBuZXh0IHBhdGNoZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1
IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gRXVnZW4gLyBMdWRv
dmljLA0KPiANCj4gSGF2ZSB5b3UgaGFkIGEgY2hhbmNlIHRvIGxvb2sgYXQgdGhpcyBzZXJpZXM/
DQoNCkhpIEpvbmF0aGFuLA0KDQpEb2VzIHRoZSBwYXRjaCBhcHBseSBjb3JyZWN0bHkgZm9yIHlv
dSA/DQpJIHdpbGwgdHJ5IHRvIHRlc3QgaXQgLCBpZiBJIG1hbmFnZSB0byBhcHBseSBpdC4NCkkg
Y2FuIG9ubHkgdGVzdCB0aGUgQURDIHRob3VnaCBiZWNhdXNlIGF0IHRoaXMgbW9tZW50IEkgZG8g
bm90IGhhdmUgYSANCnRvdWNoc2NyZWVuIGF0IGRpc3Bvc2FsLg0KDQpNZWFud2hpbGUsIHRoZSBj
b2RlIGxvb2tzIGdvb2QgZm9yIG1lLA0KDQpSZXZpZXdlZC1ieTogRXVnZW4gSHJpc3RldiA8ZXVn
ZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KDQpCeSB0aGUgd2F5LCBJIGRvIG5vdCBrbm93IGlm
IG15IHR3byBwZW5kaW5nIHBhdGNoZXMgb24gdGhpcyBkcml2ZXIgd2lsbCANCmNvbmZsaWN0IG9y
IG5vdC4NCg0KRXVnZW4NCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+PiAt
LS0NCj4+DQo+PiBUaGlzIHBhdGNoc2V0IGNvbnRpbnVlcyBkaXNjdXNzaW9uOg0KPj4gICAgIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlpby8yMDE5MTAyMzA4MjUwOC4xNzU4My0xLWFs
ZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tLw0KPj4gQXBvbG9naWVzIGZvciB0aGUgZGVsYXku
DQo+Pg0KPj4gQ2hhbmdlbG9nIHYxIC0+IHYyOg0KPj4gKiBhZGRlZCBwYXRjaCAnaWlvOiBhdDkx
LXNhbWE1ZDJfYWRjOiBzcGxpdCBhdDkxX2FkY19jdXJyZW50X2NoYW5faXNfdG91Y2goKQ0KPj4g
ICAgaGVscGVyJw0KPj4gKiByZW5hbWVkIGF0OTFfYWRjX2J1ZmZlcl9wb3N0ZW5hYmxlKCkgLT4g
YXQ5MV9hZGNfYnVmZmVyX3ByZWVuYWJsZSgpDQo+PiAgICAtIGF0OTFfYWRjX2J1ZmZlcl9wb3N0
ZW5hYmxlKCkgLSBub3cganVzdCBjYWxscw0KPj4gICAgICBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9w
b3N0ZW5hYmxlKCkgaWYgdGhlIGNoYW5uZWwgaXNuJ3QgdGhlIHRvdWNoc2NyZWVuDQo+PiAgICAg
IGNoYW5uZWwNCj4+ICogcmVuYW1lZCBhdDkxX2FkY19idWZmZXJfcHJlZGlzYWJsZSgpIC0+IGF0
OTFfYWRjX2J1ZmZlcl9wb3N0ZGlzYWJsZSgpDQo+PiAgICAtIGF0OTFfYWRjX2J1ZmZlcl9wcmVk
aXNhYmxlKCkgLSBub3cganVzdCBjYWxscw0KPj4gICAgICBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9w
cmVkaXNhYmxlKCkgaWYgdGhlIGNoYW5uZWwgaXNuJ3QgdGhlIHRvdWNoc2NyZWVuDQo+PiAgICAg
IGNoYW5uZWwNCj4+DQo+PiAgIGRyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgfCAz
MSArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIGIvZHJpdmVycy9paW8vYWRjL2F0OTEtc2Ft
YTVkMl9hZGMuYw0KPj4gaW5kZXggYTVjNzc3MTIyN2Q1Li5mMmE3NGM0N2M3NjggMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+PiArKysgYi9kcml2
ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+PiBAQCAtODczLDE4ICs4NzMsMjQgQEAg
c3RhdGljIGludCBhdDkxX2FkY19kbWFfc3RhcnQoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikN
Cj4+ICAgICAgICByZXR1cm4gMDsNCj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgYm9vbCBhdDkxX2Fk
Y19jdXJyZW50X2NoYW5faXNfdG91Y2goc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4+ICt7
DQo+PiArICAgICBzdHJ1Y3QgYXQ5MV9hZGNfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2
KTsNCj4+ICsNCj4+ICsgICAgIHJldHVybiAhIWJpdG1hcF9zdWJzZXQoaW5kaW9fZGV2LT5hY3Rp
dmVfc2Nhbl9tYXNrLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAmc3QtPnRvdWNo
X3N0LmNoYW5uZWxzX2JpdG1hc2ssDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFU
OTFfU0FNQTVEMl9NQVhfQ0hBTl9JRFggKyAxKTsNCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyBp
bnQgYXQ5MV9hZGNfYnVmZmVyX3Bvc3RlbmFibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikN
Cj4+ICAgew0KPj4gICAgICAgIGludCByZXQ7DQo+PiAgICAgICAgc3RydWN0IGF0OTFfYWRjX3N0
YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+Pg0KPj4gICAgICAgIC8qIGNoZWNrIGlm
IHdlIGFyZSBlbmFibGluZyB0cmlnZ2VyZWQgYnVmZmVyIG9yIHRoZSB0b3VjaHNjcmVlbiAqLw0K
Pj4gLSAgICAgaWYgKGJpdG1hcF9zdWJzZXQoaW5kaW9fZGV2LT5hY3RpdmVfc2Nhbl9tYXNrLA0K
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgJnN0LT50b3VjaF9zdC5jaGFubmVsc19iaXRtYXNr
LA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgQVQ5MV9TQU1BNUQyX01BWF9DSEFOX0lEWCAr
IDEpKSB7DQo+PiAtICAgICAgICAgICAgIC8qIHRvdWNoc2NyZWVuIGVuYWJsaW5nICovDQo+PiAr
ICAgICBpZiAoYXQ5MV9hZGNfY3VycmVudF9jaGFuX2lzX3RvdWNoKGluZGlvX2RldikpDQo+PiAg
ICAgICAgICAgICAgICByZXR1cm4gYXQ5MV9hZGNfY29uZmlndXJlX3RvdWNoKHN0LCB0cnVlKTsN
Cj4+IC0gICAgIH0NCj4+ICsNCj4+ICAgICAgICAvKiBpZiB3ZSBhcmUgbm90IGluIHRyaWdnZXJl
ZCBtb2RlLCB3ZSBjYW5ub3QgZW5hYmxlIHRoZSBidWZmZXIuICovDQo+PiAgICAgICAgaWYgKCEo
aW5kaW9fZGV2LT5jdXJyZW50bW9kZSAmIElORElPX0FMTF9UUklHR0VSRURfTU9ERVMpKQ0KPj4g
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiBAQCAtOTA2LDEyICs5MTIsOSBAQCBz
dGF0aWMgaW50IGF0OTFfYWRjX2J1ZmZlcl9wcmVkaXNhYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRp
b19kZXYpDQo+PiAgICAgICAgdTggYml0Ow0KPj4NCj4+ICAgICAgICAvKiBjaGVjayBpZiB3ZSBh
cmUgZGlzYWJsaW5nIHRyaWdnZXJlZCBidWZmZXIgb3IgdGhlIHRvdWNoc2NyZWVuICovDQo+PiAt
ICAgICBpZiAoYml0bWFwX3N1YnNldChpbmRpb19kZXYtPmFjdGl2ZV9zY2FuX21hc2ssDQo+PiAt
ICAgICAgICAgICAgICAgICAgICAgICAmc3QtPnRvdWNoX3N0LmNoYW5uZWxzX2JpdG1hc2ssDQo+
PiAtICAgICAgICAgICAgICAgICAgICAgICBBVDkxX1NBTUE1RDJfTUFYX0NIQU5fSURYICsgMSkp
IHsNCj4+IC0gICAgICAgICAgICAgLyogdG91Y2hzY3JlZW4gZGlzYWJsZSAqLw0KPj4gKyAgICAg
aWYgKGF0OTFfYWRjX2N1cnJlbnRfY2hhbl9pc190b3VjaChpbmRpb19kZXYpKQ0KPj4gICAgICAg
ICAgICAgICAgcmV0dXJuIGF0OTFfYWRjX2NvbmZpZ3VyZV90b3VjaChzdCwgZmFsc2UpOw0KPj4g
LSAgICAgfQ0KPj4gKw0KPj4gICAgICAgIC8qIGlmIHdlIGFyZSBub3QgaW4gdHJpZ2dlcmVkIG1v
ZGUsIG5vdGhpbmcgdG8gZG8gaGVyZSAqLw0KPj4gICAgICAgIGlmICghKGluZGlvX2Rldi0+Y3Vy
cmVudG1vZGUgJiBJTkRJT19BTExfVFJJR0dFUkVEX01PREVTKSkNCj4+ICAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KPj4gQEAgLTE4ODYsMTQgKzE4ODksMTAgQEAgc3RhdGljIF9fbWF5
YmVfdW51c2VkIGludCBhdDkxX2FkY19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPj4gICAg
ICAgICAgICAgICAgcmV0dXJuIDA7DQo+Pg0KPj4gICAgICAgIC8qIGNoZWNrIGlmIHdlIGFyZSBl
bmFibGluZyB0cmlnZ2VyZWQgYnVmZmVyIG9yIHRoZSB0b3VjaHNjcmVlbiAqLw0KPj4gLSAgICAg
aWYgKGJpdG1hcF9zdWJzZXQoaW5kaW9fZGV2LT5hY3RpdmVfc2Nhbl9tYXNrLA0KPj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgJnN0LT50b3VjaF9zdC5jaGFubmVsc19iaXRtYXNrLA0KPj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgQVQ5MV9TQU1BNUQyX01BWF9DSEFOX0lEWCArIDEpKSB7DQo+
PiAtICAgICAgICAgICAgIC8qIHRvdWNoc2NyZWVuIGVuYWJsaW5nICovDQo+PiArICAgICBpZiAo
YXQ5MV9hZGNfY3VycmVudF9jaGFuX2lzX3RvdWNoKGluZGlvX2RldikpDQo+PiAgICAgICAgICAg
ICAgICByZXR1cm4gYXQ5MV9hZGNfY29uZmlndXJlX3RvdWNoKHN0LCB0cnVlKTsNCj4+IC0gICAg
IH0gZWxzZSB7DQo+PiArICAgICBlbHNlDQo+PiAgICAgICAgICAgICAgICByZXR1cm4gYXQ5MV9h
ZGNfY29uZmlndXJlX3RyaWdnZXIoc3QtPnRyaWcsIHRydWUpOw0KPj4gLSAgICAgfQ0KPj4NCj4+
ICAgICAgICAvKiBub3QgbmVlZGVkIGJ1dCBtb3JlIGV4cGxpY2l0ICovDQo+PiAgICAgICAgcmV0
dXJuIDA7DQo+IA0KDQo=
