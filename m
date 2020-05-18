Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D53E1D72FF
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 10:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgERIce (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 04:32:34 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:7340 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727075AbgERIcd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 04:32:33 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04I8Tc9Z014680;
        Mon, 18 May 2020 04:32:14 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0b-00128a01.pphosted.com with ESMTP id 313ca0h7wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 04:32:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c79YWHvnB51Vr3X8l9gUqHk/PLCf4XAAGMTcDBKbWJXNbps4I65u3GH0R7MhQTdQgyg+BrOFV59IQyXICZl8wqT6qen5fcXqrhIv8HUFpkMskaB9weN0pQgv34A57cykCR0DU+NXiZrWz5MD8KbnwQ7txuUqVhHbEePxtRGsDs33TAGBflzPjmCeqyoENcgplHH8t80EUOvhhQrVIxwv/FEAMiQ8e5HJe7+jnmd8dOTTi+vGkcW6ntwGABkPfFSZMSjk2vghLqDQwGKRd+DoGwPcLX2Ggeb2vwd4s8lJflNaLAZcPTb4w8rra8gZ4Ra03jhYch7wBRuaRmwzBulU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OWym3pZhKX9DjO94+9ky8/RS5aMQBt3sCj1e4fXWDI=;
 b=lzOkB3fT0dyTe95YR7u1PT7Yz17OHHL+wZteCL3EVn7zoiNFKeD2vZ32WBqmQ3R115YAX4pqrwAHCKfcp56sUlWXamcCukRTSBRH2wS8YLxpW2efGZOP9wl+vqAlWm1qFpLCJiMONtN+rTqotMvDkIi/Itf8SdHlKWy4LPqZ395fMJ2CTVlNw5a+QxT75Wj4dSM7mWmHe2Jd1JjxyjM+iFH+I5LCbSErhwE5kbNBmTLs3hKVR4KrBj5K3FsVgwJINK+FiCI9GXDNdDSmt82yesE1kc9QfrW1nwXKw2mQi5ClXJHdvDy9T3ro2vwLs/UuOgs/y3KVQVmyr0i5z8fe4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OWym3pZhKX9DjO94+9ky8/RS5aMQBt3sCj1e4fXWDI=;
 b=lg548RzVrE/UY81LZJ6mOT4UAEbPliuDeZDkCPQ41cKIGoabzCjXSbJgyD/eSPxBYEOumSfjq+4heR0cnBm7YscOkut1UvJy6yBfzyWfkwvUBrAcc95VlJDR+fZ6KHNFvBkM4N5dL1/j4DKoUXii+1Ehb0YSor2+VX9PGBWZpG0=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4635.namprd03.prod.outlook.com (2603:10b6:5:15d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Mon, 18 May
 2020 08:32:12 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 08:32:12 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "ak@it-klinger.de" <ak@it-klinger.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/8] iio: at91_adc: pass ref to IIO device via param
 for int function
Thread-Topic: [PATCH v2 3/8] iio: at91_adc: pass ref to IIO device via param
 for int function
Thread-Index: AQHWKfIbMZtFzYSRw02DR0rPoi4Ajqiq9/SAgAKRzAA=
Date:   Mon, 18 May 2020 08:32:11 +0000
Message-ID: <99993df0dce7f7561e9659985265d6c1f5839208.camel@analog.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
         <20200514131710.84201-4-alexandru.ardelean@analog.com>
         <20200516181749.243c9515@archlinux>
In-Reply-To: <20200516181749.243c9515@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c72f8cf-48f5-4a6d-755c-08d7fb05f63d
x-ms-traffictypediagnostic: DM6PR03MB4635:
x-microsoft-antispam-prvs: <DM6PR03MB4635111A0019A8DA1DC71A0AF9B80@DM6PR03MB4635.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IbhnqQWfpQvncB9jOW4KEAQaG9Nu6zlIbP8L6sn5wwc0J8vcZqPSVWk9m8LKdUeBj5KKrPLK2OcWP773wreRJ3bXyduNGvdQog2gyWf3f9EJbGFK4vWPJJGb641H43y7L0LEfXeRl8IG4QLRqWidfETs0cIHbJZL5IBAtkoHTElpF6zbqfJsrx5DxOUd19Bwioz+fEfswhKWawE0OqtCQaySopKrv5O9r3OTmcj76TEdjo1FyowmItLB1w1IP8JhD0hFXBq8PTLukpk+DAwguXCYLga1dFN5MMYSABrJ60CUDGB6FlMFQ+r52uuDDjNkXDd0C043pMHf5B47Jl4saEBP/cSctpxnwzUhbjS/AQowBMLtEhzkZ1upNX/rKRoDfDIpfPxgbIsmGqeM9IIUCaQiqe1GlB3fwLANdbVrn24LL5t3NIkBjwXWjbNeiNom
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(39860400002)(346002)(376002)(8676002)(478600001)(6506007)(186003)(6512007)(66446008)(64756008)(66556008)(8936002)(6916009)(26005)(66476007)(86362001)(36756003)(66946007)(5660300002)(54906003)(2906002)(2616005)(4326008)(91956017)(7416002)(71200400001)(76116006)(316002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 87A/NcRrfy54lXDV0O4VuMevKjtUJqF8Xq9n0aSod9XMoMKpoZFXzd4f3C/b+dCZIB9Zd7NoELMQjDn4wm6pbZkl0XjNoBAwXg4jwf1X5PyE2WmBsYKrblxwd9RhdudScTFh/c6PzhiNL2nmx5AbucwjjGjCKn6DcuXTt7MXbN2hfTfMniArV0Ot+n1ASjZlo9mTkuGkBlvCSwAS60SEYAD+UpwwKlvLaEYgN/ZZtB+UhTcQZ2B5SpKPOlMrChVx3ORmZdCsseEnOWkyZEAmbEqRLhTcY4J1POes7SQEbLGj242+KVSDxPwHViX9nzYFZgSaYyTK48bbQWtikeh/LtkPYkzV1Nwx6d4b/HfUBdv8rrTs71WEF+BkJyNB87BBwW+c11gD6q1NfFQlri6AEMERC4V3FkdZpEG/U17EkC76JOYTLYmh1MK05Fn/zp+OV5x6df2s3BEqqOwu04sxlu3pnUJc4CEAYRlSQJ66IB8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EB7D248FB59784192EBA145EDAE02D5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c72f8cf-48f5-4a6d-755c-08d7fb05f63d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 08:32:11.9216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nj+rH+bwdNhlERhnmz9wNQ4vBRVXEAYf8Nid+g409qo/ka2stilLyH/nQuzML6b4Ll5yRWhf/f1udd3SEb3JEez8KpEEcBA6PgxJFZAyfv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4635
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_03:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 cotscore=-2147483648 clxscore=1015 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180078
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTA1LTE2IGF0IDE4OjE3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUaHUsIDE0IE1heSAyMDIwIDE2OjE3OjA1ICswMzAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBTaW5jZSB0aGVyZSB3aWxsIGJlIHNvbWUgY2hhbmdlcyB0byBob3cgaWlv
X3ByaXZfdG9fZGV2KCkgaXMgaW1wbGVtZW50ZWQsDQo+ID4gaXQgY291bGQgYmUgdGhhdCB0aGUg
aGVscGVyIGJlY29tZXMgYSBiaXQgc2xvd2VyLCBhcyBpdCB3aWxsIGJlIGhpZGRlbiBhd2F5DQo+
ID4gaW4gdGhlIElJTyBjb3JlLg0KPiA+IA0KPiA+IEZvciB0aGlzIGRyaXZlciwgdGhlIElJTyBk
ZXZpY2UgY2FuIGJlIHBhc3NlZCBkaXJlY3RseSBhcyBhIHBhcmFtZXRlciB0bw0KPiA+IHRoZSBh
dDkxX3RzX3NhbXBsZSgpIGZ1bmN0aW9uLCB0aHVzIG1ha2luZyBpdCBpbW11bmUgdG8gdGhlIGNo
YW5nZSBvZg0KPiA+IGlpb19wcml2X3RvX2RldigpLg0KPiA+IFRoZSBmdW5jdGlvbiBnZXRzIGNh
bGxlZCBpbiBhbiBpbnRlcnJ1cHQgY29udGV4dC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBB
bGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiBJIHdv
bmRlci4gU2hvdWxkIHdlIGp1c3QgcGFzcyB0aGUgc3RydWN0IGRldmljZT8gIEl0J3Mgb25seSB1
c2VkIGZvcg0KPiBlcnJvciBwcmludGluZyBJIHRoaW5rLCBzbyB3ZSBjb3VsZCBtYWtlIHRoYXQg
ZXhwbGljaXQuDQoNCkkgd2FzIGFsc28gdGhpbmtpbmcgdGhhdCBmb3IgdGhpcyBzZXJpZXMsIFtm
b3Igc29tZSBkcml2ZXJzXSBpdCB3b3VsZCBtYWtlIHNlbnNlDQp0byBwdXQgYSByZWZlcmVuY2Ug
dG8gaW5kaW9fZGV2IG9uIHRoZSBzdGF0ZS1zdHJ1Y3Q7IGFuZCBqdXN0IHJldHVybiBpdC4NCkkn
bGwgc2VlIGFib3V0IGl0Lg0KSSBhbSBmZWVsaW5nIHRoYXQgc29tZXRpbWVzIHRoZXNlIElJTyBj
b3JlIGNsZWFudXBzIGVuZCB1cCBiZWluZyBtb3JlIHRoYW4gSQ0Kd2FudCB0byBkby4gQnV0IEkn
bGwgdHJ5IHRvIHNlZSBhYm91dCBpdC4gTWF5YmUgSSBjYW4gbWFrZSB0aW1lIG9yIGRlbGVnYXRl
IHNvbWUNCm9mIHRoaXMuDQoNCk15IHBlcnNvbmFsIGludGVyZXN0IHdpdGggdGhlbSwgaXMgdG8g
cmVkdWNlIG15IGNvbXBsYWludHMgZHVyaW5nIHJldmlld3MuDQpQZW9wbGUgc3RhcnRpbmcgdG8g
d3JpdGUgSUlPIGRyaXZlcnM6IHdlbGwsIEkgY2FuIHNlZSB0aGVpciBmcnVzdHJhdGlvbiBbb24N
CnRoZWlyIGZhY2VzXSB3aGVuIEkgY29tcGxhaW4gdGhhdCB0aGV5IHNob3VsZG4ndCB1c2Ugc29t
ZXRoaW5nLCBhbmQgdGhleSBjb3BpZWQNCml0IGZyb20gc29tZXdoZXJlLg0KDQoNCj4gDQo+IEkn
bSBub3QgdGhhdCBib3RoZXJlZCBlaXRoZXIgd2F5IHRob3VnaC4NCj4gDQo+IEpvbmF0aGFuDQo+
IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9hZGMvYXQ5MV9hZGMuYyB8IDUgKystLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2F0OTFfYWRjLmMgYi9kcml2ZXJzL2lp
by9hZGMvYXQ5MV9hZGMuYw0KPiA+IGluZGV4IDAzNjhiNmRjNmQ2MC4uNTk5OWRlZmU0N2NkIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hdDkxX2FkYy5jDQo+ID4gKysrIGIvZHJp
dmVycy9paW8vYWRjL2F0OTFfYWRjLmMNCj4gPiBAQCAtMjg3LDEzICsyODcsMTIgQEAgc3RhdGlj
IHZvaWQgaGFuZGxlX2FkY19lb2NfdHJpZ2dlcihpbnQgaXJxLCBzdHJ1Y3QNCj4gPiBpaW9fZGV2
ICppZGV2KQ0KPiA+ICAJfQ0KPiA+ICB9DQo+ID4gIA0KPiA+IC1zdGF0aWMgaW50IGF0OTFfdHNf
c2FtcGxlKHN0cnVjdCBhdDkxX2FkY19zdGF0ZSAqc3QpDQo+ID4gK3N0YXRpYyBpbnQgYXQ5MV90
c19zYW1wbGUoc3RydWN0IGlpb19kZXYgKmlkZXYsIHN0cnVjdCBhdDkxX2FkY19zdGF0ZSAqc3Qp
DQo+ID4gIHsNCj4gPiAgCXVuc2lnbmVkIGludCB4c2NhbGUsIHlzY2FsZSwgcmVnLCB6MSwgejI7
DQo+ID4gIAl1bnNpZ25lZCBpbnQgeCwgeSwgcHJlcywgeHBvcywgeXBvczsNCj4gPiAgCXVuc2ln
bmVkIGludCByeHAgPSAxOw0KPiA+ICAJdW5zaWduZWQgaW50IGZhY3RvciA9IDEwMDA7DQo+ID4g
LQlzdHJ1Y3QgaWlvX2RldiAqaWRldiA9IGlpb19wcml2X3RvX2RldihzdCk7DQo+ID4gIA0KPiA+
ICAJdW5zaWduZWQgaW50IHh5el9tYXNrX2JpdHMgPSBzdC0+cmVzOw0KPiA+ICAJdW5zaWduZWQg
aW50IHh5el9tYXNrID0gKDEgPDwgeHl6X21hc2tfYml0cykgLSAxOw0KPiA+IEBAIC00NDksNyAr
NDQ4LDcgQEAgc3RhdGljIGlycXJldHVybl90IGF0OTFfYWRjXzl4NV9pbnRlcnJ1cHQoaW50IGly
cSwgdm9pZA0KPiA+ICpwcml2YXRlKQ0KPiA+ICANCj4gPiAgCQlpZiAoc3RhdHVzICYgQVQ5MV9B
RENfSVNSX1BFTlMpIHsNCj4gPiAgCQkJLyogdmFsaWRhdGUgZGF0YSBieSBwZW4gY29udGFjdCAq
Lw0KPiA+IC0JCQlhdDkxX3RzX3NhbXBsZShzdCk7DQo+ID4gKwkJCWF0OTFfdHNfc2FtcGxlKGlk
ZXYsIHN0KTsNCj4gPiAgCQl9IGVsc2Ugew0KPiA+ICAJCQkvKiB0cmlnZ2VyZWQgYnkgZXZlbnQg
dGhhdCBpcyBubyBwZW4gY29udGFjdCwganVzdCByZWFkDQo+ID4gIAkJCSAqIHRoZW0gdG8gY2xl
YW4gdGhlIGludGVycnVwdCBhbmQgZGlzY2FyZCBhbGwuDQo=
