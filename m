Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB601EB6C8
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 09:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgFBHuz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 03:50:55 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55296 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbgFBHuz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 03:50:55 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0527nXOu010001;
        Tue, 2 Jun 2020 03:50:25 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-00128a01.pphosted.com with ESMTP id 31bhb69rkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 03:50:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMjT39ZKX8AOvGmjBdmG1N83oKD+eJYSp1HziMe03TDppC6LhrUxpFExZ6h5qLZ0W1GCZc2B7Fbnpbm1mCFmhct/MwL19V4fkyn4MsJzcrWBd0j3EHiNz4Bb27nqmoStcI2GuCiuU48NjOZTQordQicQKIQYWW6yS1v6rCn9+ykduYpESeVavUKm2+MHZvSiwd5BkGwRVEhccH4AgKvN6ZcYSq/3RtPE9aCjhwj7othavtsoAdxvhq00rxtUP65drwGnZLRPehQXboHt+X/Mz84e4X9W6Nb2+DD1JAcJOXpqKjL2JHoSYyeTL3uwpd3SNoXQ6BE2ZlFvOc+M/RCgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcwqP+OGTHkxrj/o3N2o9M+O5bMPkJD9aEvicfXjw3s=;
 b=GJ2Zn8trEqm3pyFYy7eztD5F2f1RS32fJAsd5Sv6RDaNAy8qxrn62POpluswBkuF+yefBxkSngvkfBHj0beRX0crT8r/2SmcPPj0GDGFJcoEaVkhHh0s0Oml+3vKrRSWnd4xPKo+ly8PAwCBtVGjDeSifNHxrkf/16tCd/IibWnNrxAAafU2VxgQEjzLJIjoM1bjJDgLTEizGN2KsIsW7EnK9lt5hhIbGLfwuiMmFQfVEKcirq7MmCdneopZgm6COMVBAiIiKleO5sd+n4QmKG6Rn/u65XXi5woKQcGmGliuNg8dOD3IZNjyBMm5DzDS83p3M0AuiXtkGbZvsYqraQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcwqP+OGTHkxrj/o3N2o9M+O5bMPkJD9aEvicfXjw3s=;
 b=tOvBGNJWtq7JOhOMODgNBZpmukZt/mrdz3RUC8P/AIZrgfCWhHq5dX5UGMC4J9ZZDaso0vl3kCt5Yk/+lTG86SfZPXS5zFBgvNKBFc9BoEQLoAYNplrjPRw81oAAfOgmTUH1TUAhhP/vnABFeRdJepBlJtvjxdXhYMXvAgJMq8o=
Received: from BYAPR03MB4407.namprd03.prod.outlook.com (2603:10b6:a03:c5::24)
 by BYAPR03MB3749.namprd03.prod.outlook.com (2603:10b6:a03:6b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Tue, 2 Jun
 2020 07:50:23 +0000
Received: from BYAPR03MB4407.namprd03.prod.outlook.com
 ([fe80::18cb:6059:b74f:73a0]) by BYAPR03MB4407.namprd03.prod.outlook.com
 ([fe80::18cb:6059:b74f:73a0%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 07:50:23 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "songqiang1304521@gmail.com" <songqiang1304521@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 3/3] iio: remove
 iio_triggered_buffer_postenable()/iio_triggered_buffer_predisable()
Thread-Topic: [PATCH v2 3/3] iio: remove
 iio_triggered_buffer_postenable()/iio_triggered_buffer_predisable()
Thread-Index: AQHWMosiebcsgWLmWUu0dbt01y27SqjCXn4AgAKhWwA=
Date:   Tue, 2 Jun 2020 07:50:23 +0000
Message-ID: <a0253d719a4390f65668789e5fc182ec19355f17.camel@analog.com>
References: <20200525113855.178821-1-alexandru.ardelean@analog.com>
         <20200525113855.178821-3-alexandru.ardelean@analog.com>
         <20200531164020.765822dc@archlinux>
In-Reply-To: <20200531164020.765822dc@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c79c2cc9-7d49-46ae-1966-08d806c99b42
x-ms-traffictypediagnostic: BYAPR03MB3749:
x-microsoft-antispam-prvs: <BYAPR03MB374961A58268B8BFA2C495A5F98B0@BYAPR03MB3749.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cgc+0JY56S7488bKQVJWpDSLtmiSnuJli2cenqnUiwOjcbiGC5cIT9HFNuhQmkxcIDl3OIDzY1ji7RFPnyRCW3WN+MaQ8XOEywP4sZLwyKM0ymjRGXJy4HS+HRwJGBPARwUB1e1mVYWV7SS7zSkNJkTTEVaWYzJJ1X5NGe8m/CsTFppjBUnagHwLy1Da9Q4u7t3MPDfgfCE6c1b7lDAjbmy7gTYQoxC2yQ28pQV349PRnmQBBtTekwpukCyVE0XfIzdjzXIIVlI0nEldnUgSOlLZ7WLYnzDRvkVxy6REwfVYn+0DArYqvl2xyb0erRjdY8w6HEa66bGkA+nCEcP4CA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4407.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(376002)(39860400002)(346002)(6486002)(2616005)(2906002)(4326008)(8936002)(8676002)(6512007)(83380400001)(5660300002)(26005)(186003)(54906003)(478600001)(71200400001)(316002)(6916009)(86362001)(6506007)(66446008)(66476007)(7416002)(66946007)(66556008)(36756003)(64756008)(76116006)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: oEW8YEntt5qLDIcJb79MlDCyXfmrUupeSiYE1vJT/MyC/qMXktbU6CpLYFcTXZ5A5YWjUH0BCDW6qkphOzLGazryKTRYEzUY8PcarhGO+nyB7lg5I2qV1WPnHNl081PS1ph3Sd5yyhE+EhVMgrmByBA1Eat8YLa6oVWOi2sZL8T6UVi9YO3XO4VfJFslKrqmUiFq25TDYOmbCh9u1VF+ZG/GZZSrtfb8fNgdDJeD9qKZPuu5XXacXAPWruA5wsQUM5C6GHanOg67IK96oNkCyHjoCa0DWOQ11Xn8rKP06TtYDcKG7N3DTuyF7+vMMFqNCENiTL1kdHs4QPeYyUev+xAagdkIBHNqz+mnQtS8I2INoXX0VULG0UUJo6BjmEiQohhDsmkuuTOt1VMND99UlejRZxJaA1XDBsIcMvdJkvYhnNUgNehg3Jpl4iJcJykvQsAoNyL/YT1LqtKc0ErlezkwHNcK/uO1ilhPTiogB3UnqWNzuZQwidZoD6+2NtWT
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AEA0E43D6FBD04BB3B4240009B8EA1D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79c2cc9-7d49-46ae-1966-08d806c99b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 07:50:23.1541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsdBnzoKdBbQEvbSd68j+6xk7T2E3bxZzNbn1096V+uoQuq7FtnNrpfccPnwPa88V3VnAOewS+AXPcpZEX6iYOPH/k21zBhDaRSxnQuoNHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3749
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_08:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0
 cotscore=-2147483648 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020050
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA1LTMxIGF0IDE2OjQwICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBNb24sIDI1IE1heSAyMDIwIDE0OjM4OjU1ICswMzAwDQo+IEFsZXhhbmRydSBBcmRl
bGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBGcm9t
OiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gPiANCj4gPiBUaGlzIHBh
dGNoIHNob3VsZCBiZSBzcXVhc2hlZCBpbnRvIHRoZSBmaXJzdCBvbmUsIGFzIHRoZSBmaXJzdCBv
bmUgaXMNCj4gPiBicmVha2luZyB0aGUgYnVpbGQgKGludGVudGlvbmFsbHkpIHRvIG1ha2UgdGhl
IElJTyBjb3JlIGZpbGVzIGVhc2llciB0bw0KPiA+IHJldmlldy4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29t
Pg0KPiA+IC0tLQ0KPiANCj4gRnJpZW5kIHBva2UuICBWZXJzaW9uIGxvZz8NCg0KVmVyc2lvbiBs
b2cgaXMgaW4gdGhlIGZpcnN0IHBhdGNoLg0KSSB3YXMgd29uZGVyaW5nIGlmIEkgb21pdHRlZCBp
dC4NClNlZW1zLCB0aGlzIHRpbWUgSSBkaWRuJ3QuIEJ1dCBJIGFkbWl0LCBpdCBwcm9iYWJseSB3
b3VsZCBoYXZlIGJlZW4gYmV0dGVyDQpoZXJlLg0KDQo+IA0KPiBPdGhlciB0aGFuIHRoZSB3aXN0
ZnVsIGNvbW1lbnQgYmVsb3cgKHdoaWNoIEknbSBub3QgZXhwZWN0aW5nIHlvdSB0bw0KPiBkbyBh
bnl0aGluZyBhYm91dCBidHchKSB3aG9sZSBzZXJpZXMgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+
IFRoZXNlIGFyZSBvYnZpb3VzbHkgbm8gZnVuY3Rpb25hbCBjaGFuZ2VzIChJIHRoaW5rKSBzbyBp
dCdzIG9ubHkgcmVhbGx5DQo+IHBhdGNoIDIgdGhhdA0KPiBjb3VsZCBkbyB3aXRoIG1vcmUgZXll
cyBhbmQgYWNrcy4NCj4gDQo+IEZhciBhcyBJIGNhbiB0ZWxsIHRoYXQgY2FzZSBpcyBmaW5lIGFz
IHdlbGwgYmVjYXVzZSBvZiB0aGUgcHJvdGVjdGlvbnMNCj4gb24gYmVpbmcgaW4gdGhlIHJpZ2h0
IG1vZGUsIGJ1dCBtb3JlIGV5ZXMgb24gdGhhdCB3b3VsZCBiZSBncmVhdC4NCj4gDQo+IFNvIGFz
c3VtaW5nIHRoYXQncyBmaW5lLCB3aGF0IGNvbW1pdCBtZXNzYWdlIGRvIHlvdSB3YW50IG1lIHRv
IHVzZSBmb3INCj4gdGhlIGZ1c2VkIHNpbmdsZSBwYXRjaD8NCg0KQ29tbWl0IG1lc3NhZ2Utd2lz
ZTogSSB0aGluayB0aGUgbWVzc2FnZSBpbiB0aGUgZmlyc3QgY29tbWl0IHdvdWxkIGJlDQptb3N0
bHkgc3VmZmljaWVudC4NCk5vIGlkZWEgd2hhdCBvdGhlciBkZXNjcmlwdGlvbiB3b3VsZCBiZSBu
ZWVkZWQuDQoNClNvLCBtYXliZSBzb21ldGhpbmcgbGlrZToNCg0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQWxs
IGRldmljZXMgdXNpbmcgYSB0cmlnZ2VyZWQgYnVmZmVyIG5lZWQgdG8gYXR0YWNoIGFuZCBkZXRh
Y2ggdGhlIHRyaWdnZXINCnRvIHRoZSBkZXZpY2UgaW4gb3JkZXIgdG8gcHJvcGVybHkgd29yay4g
SW5zdGVhZCBvZiBkb2luZyB0aGlzIGluIGVhY2ggYW5kDQpldmVyeSBkcml2ZXIgYnkgaGFuZCBt
b3ZlIHRoaXMgaW50byB0aGUgY29yZS4NCg0KQXQgdGhpcyBwb2ludCBpbiB0aW1lLCBhbGwgZHJp
dmVycyBzaG91bGQgaGF2ZSBiZWVuIHJlc29sdmVkIHRvDQphdHRhY2gvZGV0YWNoIHRoZSBwb2xs
LWZ1bmN0aW9uIGluIHRoZSBzYW1lIG9yZGVyLg0KDQpUaGlzIHBhdGNoIHJlbW92ZXMgYWxsIGV4
cGxpY2l0IGNhbGxzIG9mIGlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3RlbmFibGUoKQ0KJiBpaW9f
dHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKCkgaW4gYWxsIGRyaXZlcnMsIHNpbmNlIHRoZSBj
b3JlIGhhbmRsZXMNCm5vdyB0aGUgcG9sbGZ1bmMgYXR0YWNoL2RldGFjaC4NCg0KVGhlIG1vcmUg
cGVjdWxpYXIgY2hhbmdlIGlzIGZvciB0aGUgJ2F0OTEtc2FtYTVkMl9hZGMnIGRyaXZlciwgc2lu
Y2UgaXQncw0Kbm90IG9idmlvdXMgdGhhdCByZW1vdmluZyB0aGUgaG9va3MgZG9lc24ndCBicmVh
ayBhbnl0aGluZyoqDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCioqIGZvciB0aGUgY29tbWVudCBhYm91dCAn
YXQ5MS1zYW1hNWQyX2FkYycsIHdlIHJlYWxseSBkbyBuZWVkIHRvIGdldCBzb21lDQp0ZXN0aW5n
OyBvdGhlcndpc2UgdGhpcyByaXNrcyBicmVha2luZyBpdC4NCg0KDQo+IA0KPiBUaGFua3MsDQo+
IA0KPiBKb25hdGhhbg0KPiANCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fdHJpZ2dlcl9v
cHMgYXRsYXNfaW50ZXJydXB0X3RyaWdnZXJfb3BzID0gew0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lpby9kdW1teS9paW9fc2ltcGxlX2R1bW15X2J1ZmZlci5jDQo+ID4gYi9kcml2ZXJzL2lp
by9kdW1teS9paW9fc2ltcGxlX2R1bW15X2J1ZmZlci5jDQo+ID4gaW5kZXggMTc2MDZlY2E0MmI0
Li44ZTEzYzUzZDQzNjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vZHVtbXkvaWlvX3Np
bXBsZV9kdW1teV9idWZmZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2R1bW15L2lpb19zaW1w
bGVfZHVtbXlfYnVmZmVyLmMNCj4gPiBAQCAtOTksMjAgKzk5LDYgQEAgc3RhdGljIGlycXJldHVy
bl90IGlpb19zaW1wbGVfZHVtbXlfdHJpZ2dlcl9oKGludA0KPiA+IGlycSwgdm9pZCAqcCkNCj4g
PiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fYnVmZmVyX3NldHVwX29w
cw0KPiA+IGlpb19zaW1wbGVfZHVtbXlfYnVmZmVyX3NldHVwX29wcyA9IHsNCj4gPiAtCS8qDQo+
ID4gLQkgKiBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wb3N0ZW5hYmxlOg0KPiA+IC0JICogR2VuZXJp
YyBmdW5jdGlvbiB0aGF0IHNpbXBseSBhdHRhY2hlcyB0aGUgcG9sbGZ1bmMgdG8gdGhlDQo+ID4g
dHJpZ2dlci4NCj4gPiAtCSAqIFJlcGxhY2UgdGhpcyB0byBtZXNzIHdpdGggaGFyZHdhcmUgc3Rh
dGUgYmVmb3JlIHdlIGF0dGFjaCB0aGUNCj4gPiAtCSAqIHRyaWdnZXIuDQo+ID4gLQkgKi8NCj4g
PiAtCS5wb3N0ZW5hYmxlID0gJmlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3RlbmFibGUsDQo+ID4g
LQkvKg0KPiA+IC0JICogaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZToNCj4gPiAtCSAq
IEdlbmVyaWMgZnVuY3Rpb24gdGhhdCBzaW1wbGUgZGV0YWNoZXMgdGhlIHBvbGxmdW5jIGZyb20g
dGhlDQo+ID4gdHJpZ2dlci4NCj4gPiAtCSAqIFJlcGxhY2UgdGhpcyB0byBwdXQgaGFyZHdhcmUg
c3RhdGUgYmFjayBhZ2FpbiBhZnRlciB0aGUgdHJpZ2dlcg0KPiA+IGlzDQo+ID4gLQkgKiBkZXRh
Y2hlZCBidXQgYmVmb3JlIHVzZXJzcGFjZSBrbm93cyB3ZSBoYXZlIGRpc2FibGVkIHRoZSByaW5n
Lg0KPiA+IC0JICovDQo+ID4gLQkucHJlZGlzYWJsZSA9ICZpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9w
cmVkaXNhYmxlLA0KPiA+ICB9Ow0KPiA+ICANCj4gSG1tLiBHdWVzcyB3ZSBzaG91bGQgcHJvYmFi
bHkgJ2ludmVudCcgYSByZWFzb24gdG8gaWxsdXN0cmF0ZSB0aGUgYnVmZXINCj4gb3BzIGluIHRo
ZSBkdW1teSBleGFtcGxlLiAgQW55b25lIGZlZWxpbmcgY3JlYXRpdmU/DQo=
