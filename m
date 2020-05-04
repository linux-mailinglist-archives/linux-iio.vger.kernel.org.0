Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463C41C394D
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgEDM1i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 08:27:38 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:28209 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgEDM1h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2020 08:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1588595257; x=1620131257;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mIBKFgnpnVnht/iih3cOICr37FcOxbVSITnimd4Oj6o=;
  b=EMALdretEaMJh2U8ozwUefVkewetaQIhRcyCTNLzidHqXaZmJ5rkW9+r
   kcnymn9MHsnnVDsNYhKn7BElDLkcspnjX680MVlkN5Wg59YSarBlxQEjg
   I/W7ND88ZRV2sdrBvmnY84dbFH87uQ0WZC/YQCqI0BhSsGTUZfEtkzo3R
   C/mZJ99p1NIejX94lZIAeTuSm+AWIxkHXDQq1Q6rlpOWW+ExEQNRlSvQK
   JxuTWv/9TpmUG+QevuM3xV+LeD0RoVNU0irFjRNSddhylgdWwQZVG/q9J
   cEXNsquQmVBzJxQ8deTbFJKzP9ZH0T4w5dBIn9v29qv5y+dkV3Uh74jqO
   w==;
IronPort-SDR: DVRHN56bTAgKuObYLg/NUEdw+8uZZy66ivQBjbVlXqcbH4SL1IxtWkkOJt+agkt/9RY8/cp+wk
 7yuF2vmzgQW/RgjDoPEykzN//jUJdEM50RZxT8jgGx/sBUCmAFIXszqZ9AUe7v3XqwgJxWjHTd
 qhD2JGVOuID2YMfwKvPEuwo7ozNpY3MPissiP+A+KsL4rxnVNe49Wpdq7w69HSz1zCGRHWxDuY
 k7dhyKfdKgLvM0Mbzd01hsbSjkcgFK369/olvZYNRRwjUOKHy/ZfzeifrapQ1YcdQpKctGqnpH
 Av8=
X-IronPort-AV: E=Sophos;i="5.73,352,1583218800"; 
   d="scan'208";a="72323819"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 May 2020 05:27:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 May 2020 05:27:36 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 4 May 2020 05:27:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCmR0giGa4IpTWSFOE4BWl0z0T/F/VMxTU2NRVfWD9hwtt41rXqsZpSwtf1MPXqLtJCMphFM4pUBjgn7Ftr8bGFTbhRATJXp1w5zS4/fevvKqP57RzSRLFrkz5RC2oOYS6BrI2B2DuQerXO7nBY3ImR9p5bt51Tc7xHHY7EROsj+bynzoxaXlz/6ORz2NAnbFowzFfpHGbOlCtbx89pftblHCgwqd4Vz4QMPLXr71GW9G9FKIsHBPay4ZYoLmg3aYU+PCFQONXXPEedvv/ZZEq4eRHRoKRGPRQrb9KkRlsgcCH+jDvhsDtncGME/HGins9BfU4ziAHExBL+/AwMtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIBKFgnpnVnht/iih3cOICr37FcOxbVSITnimd4Oj6o=;
 b=l+nHTGye3n8gGe86LcNi49MFkriDV6kCQP8odN86Rux5EcHdcz2+QL2d26WPaInWPey0goco/dHOeL2xSrN+Hch6X7WnbL/hxXVoxaTcSrxqBc9aNMmvTUjYK2zTGx+TowRfeFv4xXp/shl5or9YXX9dzemTFx8rg09EriQM0og31o9c0krhTccKZpSMjRqQJu1CAwXEiOhu0853YBn+9NrhVj+Y64LCWzEprYPjG0rItJgS/CS/r+zwhH9p5itN7hb3JrgDC3EnN3BpEVLOsuDU0UQgzf9Fj8ehYp11CSuQgezDzjnybqwqxheCmomryU0oB4ldjjTgY9TLfK0Xpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIBKFgnpnVnht/iih3cOICr37FcOxbVSITnimd4Oj6o=;
 b=DVRe6o2U0Fay+IVUDBi7F4SkqJAgKPyKMHzY+O2JYS9osT91ZMWNK2nyG2wXyEEobZedExS/sl8jEoy0rTqNu70TnwU7s5i61f0L8qTvB4U6wcTkYwHcZjHkjv/vPW5Ynonc9IEI7d5jGhKjjD21qZWuWq5bLOhgxRKAkyJ0KqI=
Received: from CY4PR11MB1605.namprd11.prod.outlook.com (2603:10b6:910:10::22)
 by CY4PR11MB2023.namprd11.prod.outlook.com (2603:10b6:903:30::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 12:27:34 +0000
Received: from CY4PR11MB1605.namprd11.prod.outlook.com
 ([fe80::7c42:c3d3:aaa:88b]) by CY4PR11MB1605.namprd11.prod.outlook.com
 ([fe80::7c42:c3d3:aaa:88b%12]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 12:27:34 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandru.ardelean@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [RFC PATCH] iio: __iio_update_buffers: Update mode before
 preenable/after postdisable
Thread-Topic: [RFC PATCH] iio: __iio_update_buffers: Update mode before
 preenable/after postdisable
Thread-Index: AQHWHsjeKE5QM+3ps0uLCt3MtXdmgaiRWQYAgAaIK4A=
Date:   Mon, 4 May 2020 12:27:33 +0000
Message-ID: <dbd7fba9-ad26-fb8f-7a71-55b75951409f@microchip.com>
References: <20200430082455.1628-1-alexandru.ardelean@analog.com>
 <0096231b-eda4-7685-3411-3de467618c25@microchip.com>
In-Reply-To: <0096231b-eda4-7685-3411-3de467618c25@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.133.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f16a77cd-b421-465b-7f60-08d7f02685d6
x-ms-traffictypediagnostic: CY4PR11MB2023:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB202317697737A90BEF9782D1E8A60@CY4PR11MB2023.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JvIoCiPEqaXdthEcg3oVIHnKsyCeLpufwOj4FxjRHo6LjDAi4xe6HegJIcpCINS6nTBm2WB45QbAGgI29rlURQjbBvu2BxsqKscwdGldJZlLowkb8ExFR+cODvcUPlT4haXyv0t5YVFFzFGXWP2W8xXZjWHeCGo56SPRcmPQO3Bc5DBvIY506s9dkWDKa4nPGqOwjL7t3W+MubfTQePvQcx+DDDpMAgPuU/2vH0NYn8GADNY5TMpXXZSsvD0guTxb91sFk1SruGtqmtGBWUPtjojhWqhKT2Zey/P1v35ypbNB7pNRiyCtGMQkhTQ59/F37CoZ/MBcT0jAisqNwasIiluPA7iAILXZW0RRFgsx6fMwNScvN6k8hwGnuT4qkWJPHP/ek/H4jp6ywWYBQOxe8TAaWcpx8c6Nt3GY8Yxbi4OMVqnQX6Y6l5KlzdeWHlyBXfARG6ZrxZull70cOF1Jv9pECLHcXhaXc7cjBcFmud/BKrM9Pv8kPnMR1nEOKC3ydO7xXdCrtBNBxzrwYRFnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(478600001)(6486002)(91956017)(5660300002)(36756003)(15650500001)(76116006)(66556008)(66946007)(64756008)(66476007)(71200400001)(2616005)(8936002)(8676002)(66446008)(26005)(53546011)(6506007)(186003)(86362001)(966005)(2906002)(110136005)(4326008)(54906003)(31686004)(316002)(31696002)(107886003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VbhjNX/5p5W6bAQ9jt/jFJKYTomONynZhZIfvJb4VhgSk7M/EooE5gETcg8PwPHdfZajK/DbTY0WrJTVdqneREHkYinGcz1MFHeH95hoRT16+LiGMVV7MqeS03Q5Qiau1BLDCNzvyZ8UfM06JbvZKVKjNvUt4Zle6mVpcWVQinTrM9ug0XhvyhixQO7P9MpGFAXKdQQLIKzHAXHPNptHvqHerfo6zHXZ5tE10PQjaJwqUuFyAsyqejLy6y1FPj8oOSY49Xs+fwYZn+m1rvGiSO0454eq9RWhbPJ3ZWc79MN1Hew5jcWER+/+e3Ay0ZzHzDNe8EA66oePVTpYCMR3xuMPTBtv4BohMfPOYgGeMLObVOIEakumQFhgNsGa5RXGPhD5fWn6w501uUQzLSebVdScp+k3CNZdKe4bii38YhExPCppAtpfef89uIw3uBCKBBzYjEQjv6g5TMqDtL6xFhXsGmZ28hiZyCWLZlNDwq1cFr2OEKn/pra3P32qN3LioSAvK1Owk2Z9OkAh5CICqtu9s/+Q3BniTOwQeXy7zDwG9t1kRzSh8kEOz8qnpSP0qctqJrBx8tcgItZrGmM6sDu/rFd/MNaG7xmqvNArATMzgSj+Vho2LGLKMBpxTL2dQXTS4P+paoKGio+GGUZI+UqNy36u3ZzAa7ByPm3zsaEfsf30dVrNPG9VeKqKkVLcifz9rQKBCuc2faaFGOc+vALXuNzDGH6bgR0mWI37Su/1xqTwy7wI8+AGlWFLj3V2v0OO1yFTeI5koP+CmKnRXKTIHnM7y9sHiEEjFOhm6CY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BD618C9FF08734F81366DE087288476@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f16a77cd-b421-465b-7f60-08d7f02685d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 12:27:34.0095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkb8biwdJB6D6Hgs/h+Gs2f4oH4GPxA2aEVE8Wuim3Hi7hHhVD09xIO1KQ4wAtQ+/z6ZTuqfxqAL7FfX7qMTOJWImLlLnQC+m0GYyzGnZS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2023
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMzAuMDQuMjAyMCAxMTo0MiwgRXVnZW4gSHJpc3RldiAtIE0xODI4MiB3cm90ZToNCj4gT24g
MzAuMDQuMjAyMCAxMToyNCwgQWxleGFuZHJ1IEFyZGVsZWFuIHdyb3RlOg0KPj4gRnJvbTogTGFy
cy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+Pg0KPj4gSXQgaXMgY2xlYXIgdGhh
dCB3ZSB0cmFuc2l0aW9uIHRvIElORElPX0RJUkVDVF9NT0RFIHdoZW4gZGlzYWJsaW5nIHRoZQ0K
Pj4gYnVmZmVyKHMpIGFuZCBpdCBpcyBhbHNvIGNsZWFyIHRoYXQgd2UgdHJhbnNpdGlvbiBmcm9t
IElORElPX0RJUkVDVF9NT0RFDQo+PiB3aGVuIGVuYWJsaW5nIHRoZSBidWZmZXIocykuIFNvIGxl
YXZpbmcgdGhlIGN1cnJlbnRtb2RlIGZpZWxkDQo+PiBJTkRJT19ESVJFQ1RfTU9ERSB1bnRpbCBh
ZnRlciB0aGUgcHJlZW5hYmxlKCkgY2FsbGJhY2sgYW5kIHVwZGF0aW5nIGl0IHRvDQo+PiBJTkRJ
T19ESVJFQ1RfTU9ERSBiZWZvcmUgdGhlIHBvc3RkaXNhYmxlKCkgY2FsbGJhY2sgZG9lc24ndCBh
ZGQgYWRkaXRpb25hbA0KPj4gdmFsdWUuIE9uIHRoZSBvdGhlciBoYW5kIHNvbWUgZHJpdmVycyB3
aWxsIG5lZWQgdG8gcGVyZm9ybSBkaWZmZXJlbnQNCj4+IGFjdGlvbnMgZGVwZW5kaW5nIG9uIHdo
aWNoIG1vZGUgdGhlIGRldmljZSBpcyBnb2luZyB0byBvcGVyYXRlIGluL3dhcw0KPj4gb3BlcmF0
aW5nIGluLg0KPj4NCj4+IE1vdmluZyB0aGUgdXBkYXRlIG9mIGN1cnJlbnRtb2RlIGJlZm9yZSBw
cmVlbmFibGUoKSBhbmQgYWZ0ZXIgcG9zdGRpc2FibGUoKQ0KPj4gZW5hYmxlcyB1cyB0byBoYXZl
IGRyaXZlcnMgd2hpY2ggcGVyZm9ybSBtb2RlIGRlcGVuZGVudCBhY3Rpb25zIGluIHRob3NlDQo+
PiBjYWxsYmFja3MuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxs
YXJzQG1ldGFmb28uZGU+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFs
ZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPj4gLS0tDQo+Pg0KPj4gVGhpcyBwYXRjaCBp
cyBhbHNvIGEgVjIgb2YgdGhpcyBvbGRlciBwYXRjaCBmcm9tIGEgd2hpbGUgYWdvOg0KPj4gICAg
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaWlvLzE0MzE1MjU4OTEtMTkyODUtNS1naXQt
c2VuZC1lbWFpbC1sYXJzQG1ldGFmb28uZGUvDQo+Pg0KPj4gSG93ZXZlciwgaW4gdGhpcyByZWNl
bnQgY29udGV4dCwgaXQgY29tZXMgdG8gZml4IHRoaXM6DQo+PiAgICBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1paW8vYjlhYjY3NjQ4OWRlMzU3NTk4NGRhYzU2MTBmY2YwNWZkODc0MmEz
OC5jYW1lbEBhbmFsb2cuY29tL1QvI21jMDkyODRjOGY3OTI1MGI5MmE1MmZkNWI4ZDFmNTQxZDFj
MDJjMGMwDQo+Pg0KPj4gQXQgdGhpcyBwb2ludCwgSSBkb24ndCBoYXZlIGEgY2xlYXIgaWRlYSBp
ZiB0aGlzIGFwcHJvYWNoIGlzIGdvb2Qgb3INCj4+IG5vdDsgc2luY2UgdGhlIG1vdGl2YXRpb24g
aXMgdG8gZml4IHRoZSBhdDkxIGFkYy4NCj4+IEhlbmNlIHRoZSBSRkMuDQo+Pg0KPj4gU29tZSBl
eGNlcnB0IGZyb20gdGhlIEFUOTEgZGlzY3Vzc2lvbjoNCj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+IEkgZGVj
aWRlZCB0byBkbyBhIGJpdCBvZiBzaGVsbCBtYWdpYyBmb3IgdGhpczoNCj4+DQo+PiBnZXRfZmls
ZXMoKSB7DQo+PiBnaXQgZ3JlcCAtdyBpaW9fYnVmZmVyX3NldHVwX29wcyAgfCBncmVwIGRyaXZl
cnMgfCBjdXQgLWQ6IC1mMSB8IHNvcnQgfCB1bmlxDQo+PiB9DQo+Pg0KPj4gZm9yIGZpbGUgaW4g
JChnZXRfZmlsZXMpIDsgZG8NCj4+ICAgICAgIGlmIGdyZXAgLXEgY3VycmVudG1vZGUgJGZpbGUg
OyB0aGVuDQo+PiAgICAgICAgICAgZWNobyAkZmlsZQ0KPj4gICAgICAgZmkNCj4+IGRvbmUNCj4+
DQo+PiBJdCBmaW5kcyA0IGRyaXZlcnMuDQo+PiBUaG91Z2gsIGBnZXRfZmlsZXMoKWAgd2lsbCBy
ZXR1cm4gNTYgZmlsZXMuDQo+Pg0KPj4gZHJpdmVycy9paW8vYWNjZWwvYm1jMTUwLWFjY2VsLWNv
cmUuYw0KPj4gZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYw0KPj4gZHJpdmVycy9p
aW8vYWRjL3N0bTMyLWRmc2RtLWFkYy5jDQo+PiBkcml2ZXJzL2lpby9tYWduZXRvbWV0ZXIvcm0z
MTAwLWNvcmUuYw0KPj4NCj4+IFRoZSBybTMxMDAgZHJpdmVyIGRvZXNuJ3QgZG8gYW55IGNoZWNr
cyBpbiB0aGUgc2V0dXBfb3BzIGZvciAnY3VycmVudG1vZGUnIGFzDQo+PiBmYXIgYXMgSSBjb3Vs
ZCBzZWUuDQo+Pg0KPj4gU28sIExhcnMnIHBhdGNoIGNvdWxkIHdvcmsgbmljZWx5IHRvIGZpeCB0
aGlzIGN1cnJlbnQgY2FzZSBhbmQgbm90IGJyZWFrIG90aGVycy4NCj4+DQo+PiBTZW1hbnRpY2Fs
bHkgdGhvdWdoLCBpdCB3b3VsZCBzb3VuZCBuaWNlciB0byBoYXZlIGEgJ25leHRtb2RlJyBwYXJh
bWV0ZXINCj4+IHNvbWV3aGVyZTsgbWF5YmUgb24gdGhlIHNldHVwX29wcyhpbmRpb19kZXYsIG5l
eHRtb2RlKT8NCj4+IFRob3VnaCwgb25seSB0aG9zZSAzIGRyaXZlcnMgd291bGQgcmVhbGx5IGV2
ZXIgdXNlIGl0OyBzbyBkb2luZyBpdCBsaWtlIHRoYXQNCj4+IHNvdW5kcyBsaWtlIG92ZXJraWxs
Lg0KPj4NCj4+IFNvLCB3ZSdyZSBsZWZ0IHdpdGggTGFycycgcGF0Y2ggb3Igd2UgY291bGQgYWRk
IGFuICdpbmRpb19kZXYtPm5leHRtb2RlJyBmaWVsZCwNCj4+IHRoYXQgbWF5IGJlIHVzZWQgaW4g
anVzdCB0aGVzZSAzIGRyaXZlcnMgW3doaWNoIGFnYWluOiBzb3VuZHMgb3ZlcmtpbGwgYXQgdGhp
cw0KPj4gcG9pbnQgaW4gdGltZV0uDQo+Pg0KPj4gQWx0ZXJuYXRpdmVseSwgdGhpcyAnaW5kaW9f
ZGV2LT5jdXJyZW50bW9kZScgY291bGQgYmUgcmVtb3ZlZCBmcm9tIGFsbCB0aGVzZSAzDQo+PiBk
cml2ZXJzIHNvbWVob3cuIEJ1dCB0aGF0IG5lZWRzIHRlc3RpbmcgYW5kIGEgdGhvcm91Z2ggdW5k
ZXJzdGFuZGluZyBvZiBhbGwgMw0KPj4gZHJpdmVycyBhbmQgd2hhdCB0aGV5J3JlIGRvaW5nLCB0
byBkbyBwcm9wZXJseS4NCj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IEhpIEFsZXgsDQo+IA0KPiBUaGFu
a3MgZm9yIGZpbmRpbmcgdGhpcy4gSSB3aWxsIHRlc3QgdGhpcyB3aXRoIHRoZSBhdDkxLXNhbWE1
ZDJfYWRjDQo+IGRyaXZlciBvbiBKb25hdGhhbidzIHRlc3RpbmcgYnJhbmNoLiBJIHdpbGwgbGV0
IHlvdSBrbm93IG9mIHRoZSByZXN1bHRzLg0KPiANCj4gRXVnZW4NCg0KSGksDQoNCkZvciBzYW1h
NWQyLXhwbGFpbmVkLCBodyB0cmlnZ2VyIHRlc3RpbmcsIGF0OTEtc2FtYTVkMl9hZGMgZHJpdmVy
LA0KVGVzdGVkLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+
DQoNCkkgZGlkIG5vdCBnZXQgbXkgaGFuZHMgb24gdGhlIHRvdWNoc2NyZWVuIHlldCwgYnV0IGhv
cGVmdWxseSBzb29uLg0KDQpUaGFua3MgYWdhaW4sDQpFdWdlbg0KPiANCj4+DQo+PiAgICBkcml2
ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMgfCA4ICsrKy0tLS0tDQo+PiAgICAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMgYi9kcml2ZXJzL2lpby9pbmR1
c3RyaWFsaW8tYnVmZmVyLmMNCj4+IGluZGV4IDMwYWY4YWY4ZjMxMi4uZWZjYzQ0YjYyOTQ2IDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+PiArKysg
Yi9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMNCj4+IEBAIC05ODksNiArOTg5LDcg
QEAgc3RhdGljIGludCBpaW9fZW5hYmxlX2J1ZmZlcnMoc3RydWN0IGlpb19kZXYgKmluZGlvX2Rl
diwNCj4+ICAgICAgICAgICBpbmRpb19kZXYtPmFjdGl2ZV9zY2FuX21hc2sgPSBjb25maWctPnNj
YW5fbWFzazsNCj4+ICAgICAgICAgICBpbmRpb19kZXYtPnNjYW5fdGltZXN0YW1wID0gY29uZmln
LT5zY2FuX3RpbWVzdGFtcDsNCj4+ICAgICAgICAgICBpbmRpb19kZXYtPnNjYW5fYnl0ZXMgPSBj
b25maWctPnNjYW5fYnl0ZXM7DQo+PiArICAgICAgIGluZGlvX2Rldi0+Y3VycmVudG1vZGUgPSBj
b25maWctPm1vZGU7DQo+Pg0KPj4gICAgICAgICAgIGlpb191cGRhdGVfZGVtdXgoaW5kaW9fZGV2
KTsNCj4+DQo+PiBAQCAtMTAyNCw4ICsxMDI1LDYgQEAgc3RhdGljIGludCBpaW9fZW5hYmxlX2J1
ZmZlcnMoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZ290byBlcnJfZGlzYWJsZV9idWZmZXJzOw0KPj4gICAgICAgICAgIH0NCj4+DQo+PiAt
ICAgICAgIGluZGlvX2Rldi0+Y3VycmVudG1vZGUgPSBjb25maWctPm1vZGU7DQo+PiAtDQo+PiAg
ICAgICAgICAgaWYgKGluZGlvX2Rldi0+c2V0dXBfb3BzLT5wb3N0ZW5hYmxlKSB7DQo+PiAgICAg
ICAgICAgICAgICAgICByZXQgPSBpbmRpb19kZXYtPnNldHVwX29wcy0+cG9zdGVuYWJsZShpbmRp
b19kZXYpOw0KPj4gICAgICAgICAgICAgICAgICAgaWYgKHJldCkgew0KPj4gQEAgLTEwNDIsMTAg
KzEwNDEsMTAgQEAgc3RhdGljIGludCBpaW9fZW5hYmxlX2J1ZmZlcnMoc3RydWN0IGlpb19kZXYg
KmluZGlvX2RldiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYnVmZmVyX2xpc3QpDQo+PiAgICAgICAgICAgICAgICAgICBpaW9fYnVmZmVyX2Rpc2Fi
bGUoYnVmZmVyLCBpbmRpb19kZXYpOw0KPj4gICAgZXJyX3J1bl9wb3N0ZGlzYWJsZToNCj4+IC0g
ICAgICAgaW5kaW9fZGV2LT5jdXJyZW50bW9kZSA9IElORElPX0RJUkVDVF9NT0RFOw0KPj4gICAg
ICAgICAgIGlmIChpbmRpb19kZXYtPnNldHVwX29wcy0+cG9zdGRpc2FibGUpDQo+PiAgICAgICAg
ICAgICAgICAgICBpbmRpb19kZXYtPnNldHVwX29wcy0+cG9zdGRpc2FibGUoaW5kaW9fZGV2KTsN
Cj4+ICAgIGVycl91bmRvX2NvbmZpZzoNCj4+ICsgICAgICAgaW5kaW9fZGV2LT5jdXJyZW50bW9k
ZSA9IElORElPX0RJUkVDVF9NT0RFOw0KPj4gICAgICAgICAgIGluZGlvX2Rldi0+YWN0aXZlX3Nj
YW5fbWFzayA9IE5VTEw7DQo+Pg0KPj4gICAgICAgICAgIHJldHVybiByZXQ7DQo+PiBAQCAtMTA4
MCw4ICsxMDc5LDYgQEAgc3RhdGljIGludCBpaW9fZGlzYWJsZV9idWZmZXJzKHN0cnVjdCBpaW9f
ZGV2ICppbmRpb19kZXYpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHJldDI7
DQo+PiAgICAgICAgICAgfQ0KPj4NCj4+IC0gICAgICAgaW5kaW9fZGV2LT5jdXJyZW50bW9kZSA9
IElORElPX0RJUkVDVF9NT0RFOw0KPj4gLQ0KPj4gICAgICAgICAgIGlmIChpbmRpb19kZXYtPnNl
dHVwX29wcy0+cG9zdGRpc2FibGUpIHsNCj4+ICAgICAgICAgICAgICAgICAgIHJldDIgPSBpbmRp
b19kZXYtPnNldHVwX29wcy0+cG9zdGRpc2FibGUoaW5kaW9fZGV2KTsNCj4+ICAgICAgICAgICAg
ICAgICAgIGlmIChyZXQyICYmICFyZXQpDQo+PiBAQCAtMTA5MCw2ICsxMDg3LDcgQEAgc3RhdGlj
IGludCBpaW9fZGlzYWJsZV9idWZmZXJzKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+Pg0K
Pj4gICAgICAgICAgIGlpb19mcmVlX3NjYW5fbWFzayhpbmRpb19kZXYsIGluZGlvX2Rldi0+YWN0
aXZlX3NjYW5fbWFzayk7DQo+PiAgICAgICAgICAgaW5kaW9fZGV2LT5hY3RpdmVfc2Nhbl9tYXNr
ID0gTlVMTDsNCj4+ICsgICAgICAgaW5kaW9fZGV2LT5jdXJyZW50bW9kZSA9IElORElPX0RJUkVD
VF9NT0RFOw0KPj4NCj4+ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gICAgfQ0KPj4gLS0NCj4+
IDIuMTcuMQ0KPj4NCj4gDQoNCg==
