Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA21C32EC
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 08:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgEDG3R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 02:29:17 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:47376 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbgEDG3R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2020 02:29:17 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0446FAA3016390;
        Mon, 4 May 2020 02:29:11 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0b-00128a01.pphosted.com with ESMTP id 30s5g7kmjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 02:29:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIsj/x7McCvjNmDLSDhMCFNehPXRf/XAT0scXFghoptG81gMyvz6yaH1oVOcRTY6Z5UUkrbGx4poHuHa5Zvt9s9d3c4NSbC88MDyN7wGOmFCH7gdV8aEwgUiFq+sGIO+dW5z/VTAdiAr1veLq5FInnBBwmyZaprdi+OgMm5+zVBkxgyJurbv3ps8Om2IpsFxLtCJoZD+CLKyndhV/nRvohviIowuf5CbrumUVZiHJG9lRz+CZoHBMa26e/zY8JC4Rl2tI89/d/gr+VffO3IFUYcGV8fy1UWpygvVzggLouLnLJsR17ZhcdU/LrBFVzZqm4obJeHftRRgmcacEWWmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd1R7+eLPi7ya9j52ChY5UPUGLdJjqtozBidfyS4tM8=;
 b=Gui6/uF581h0tOqq4Z1ANlKl+Qhbg3LqqZEDDHs7HzLkDl3uQNpxKLrIOl8o5+1zGaCMfEZaHpKV9iDcS+ABlNeSiXi09LDuRHjbkD4LTgly/7u8EZ4mjixRapyeMQKOfpyj57KhbIUHSlwu3QG6cZ+qdDEms8MxKlGG/6NfFjKYbJ99qDRWQLr7nGrx3LME8TJA1vpVYo0MHrJW56AouhKw1G1Po7xpYeyVuuY+Lhqb/PCjzIkwefnUs+LVKuN7Xq9nEMN+ZLr38hmtAgeI9ZZ4mILDsOGSi+cSgDwT42OK80rr2WXv5wNEe9d7w/y5wa1zQif3CM6orK031aAC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd1R7+eLPi7ya9j52ChY5UPUGLdJjqtozBidfyS4tM8=;
 b=L0sIBjoiFdUs7wu/9miz5hT+QDI36aIAa+hllruhOv1v1orEOwMtocQb+mcrPiqIUnVc4QfC7sPeV9Bhnhe6n5LFiIX3iPM5PlP5lNJc/RRWkv3gCjw6IXeEc/21EaogaCQuoTmsYn9IJUsBon/TUZKxMBy1N/X0qhQC3vwT+SM=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5291.namprd03.prod.outlook.com (2603:10b6:5:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Mon, 4 May
 2020 06:29:09 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::40df:9aa4:c85a:a020]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::40df:9aa4:c85a:a020%4]) with mapi id 15.20.2958.030; Mon, 4 May 2020
 06:29:09 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH] staging: iio: ad2s1210: Fix SPI reading
Thread-Topic: [PATCH] staging: iio: ad2s1210: Fix SPI reading
Thread-Index: AQHWHfbFvz2rPjYFokKwqczkwMyh86iWQqKAgAE8EQA=
Date:   Mon, 4 May 2020 06:29:08 +0000
Message-ID: <893e40040ba819e467f9d3840ba9712c226419a4.camel@analog.com>
References: <20200429072129.81504-1-alexandru.ardelean@analog.com>
         <20200503123753.29ea8be0@archlinux>
In-Reply-To: <20200503123753.29ea8be0@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52c13d49-4bdd-4407-4e7d-08d7eff473e0
x-ms-traffictypediagnostic: DM6PR03MB5291:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5291B87675DDEC53A25F5436F9A60@DM6PR03MB5291.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xhtkXv1suFjrDQfvogrNZTJ9M3vRaxLpC0hvo0UFC+cismRiX4p3NCju+6h19q7Hz0vRjPdWlvukGcgseDCC/kuLiTaoYqu2Wr/1eUfqCwKhq2yb7gGvX2pueyoTcAdCuyfmb5q4pm2byvVdAiXRdjxWASSPy740/4fSNoWVesuUxac5JXyANXCD5b4yE0uQ8YVnkezEatjyHfMp+kwgcEvW4MHIj8q3syPib5C3VIJRoFzD+cLdkeTm77mnr1wZd5r55nn7mQGNBC15TG+EBztaPQyOZ5hpTpTApQMhR4zIZTZbOU4qeBkOV69zv2h2uEjBr+2TErq0oIRFxFyCelOodWLvfFtdF6GogdkIqn5P9yekK4c4sbEzzLcvm1LatclDbZ4JPqfFKQa16KmIRIajEGawMcBjfehx79JK+OrtUR31UtNOVfAGUs4pN1TJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(39850400004)(136003)(346002)(376002)(2616005)(66446008)(64756008)(5660300002)(66556008)(66476007)(66946007)(6916009)(76116006)(91956017)(2906002)(316002)(6486002)(6512007)(54906003)(8936002)(107886003)(86362001)(8676002)(4326008)(71200400001)(478600001)(26005)(6506007)(186003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VL1qwwtN1OhfpMAGJ9Gph37yVLe1wsKcROACvlJZgBpop8RLZO1Z3pi8XOmrcKCO7xiRXZ+xWTNMGil2EfCmH28QvYR1eNIeO4ZrCZFAoMx0jtaFr64yYnJFvwCXTRCdS0Ta+JucoeDVHyJkPi/FBQBqH+SYvLE8en3UkGqFv3gxCOBtIq4Mk6nCBNpwZGoREMNUpbSCaB38T02sF7nk7Kqc4sZqNDIXrRjfob7TFsZWlCyf/8nxjL0efYKAXbEcPMnAkz+gdK4SbqBIFLbgLzM3K6FswfphD3jit3YNd/aUwmt3uSUKVxbQyva5FXrYxjHwWfrQfduoSD+8C13Kv8W37Bfx66sOY2EagZ3Br6TPjvEs2+g/z3l5iiCYe4DnZctEHPBAE2MpcPYh726IHAT883bUVEogLY5Lml1JihX0aC58kzRPTY/swFmq6DR3TnVkbJdcRQQNwmR+sUm8dQWqD7WReR0P3GSV4X7j6Xda8SAkkPgwJm58KeD9f3/+6exMLxRr0XpaYTgb07pOKRLUqmA98nTgpbpSryQNEF6/EWlth5oN2CQskLQrbHFxbhGqf3wpZiMFKJZmpQ87Hs8yuheqyufv8/dU19ZjwIjCcPI23dCWIdBjzuvc4PKnE52ykt9RYBsBIB2YI9z6CtUEdM4FUnh7ga7xjbvV5BLjh+PcKmB18fGViSp6506bWyFkz8fGSuT+HP43x2rm6HZWTID9UfgvxNf1x4NzLew/agnpVCz9OMhVr11Zm/bW2Tc8AYkAqD9DbIqB7prNKRvzgNam2hSjqfjT+SrZUsU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0574BBC535A9DB439E4EB41B11969F00@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c13d49-4bdd-4407-4e7d-08d7eff473e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 06:29:08.9524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYcOB9MwnpkTembeCkvTJHGX06JGK9mrKFQ9Z+/dhgvEjdqYqM3AttOpapH1TCnO17uXYqQuMRVD/W7gT2fc62kuzyLJWn0i1q5xLjhroeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5291
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_02:2020-05-01,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA1LTAzIGF0IDEyOjM3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBXZWQsIDI5IEFwciAyMDIwIDEwOjIxOjI5ICswMzAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBGcm9tOiBEcmFnb3MgQm9nZGFuIDxkcmFnb3MuYm9nZGFuQGFuYWxvZy5j
b20+DQo+ID4gDQo+ID4gSWYgdGhlIHNlcmlhbCBpbnRlcmZhY2UgaXMgdXNlZCwgdGhlIDgtYml0
IGFkZHJlc3Mgc2hvdWxkIGJlIGxhdGNoZWQgdXNpbmcNCj4gPiB0aGUgcmlzaW5nIGVkZ2Ugb2Yg
dGhlIFdSL0ZTWU5DIHNpZ25hbC4NCj4gPiANCj4gPiBUaGlzIGJhc2ljYWxseSBtZWFucyB0aGF0
IGEgQ1MgY2hhbmdlIGlzIHJlcXVpcmVkIGJldHdlZW4gdGhlIGZpcnN0IGJ5dGUNCj4gPiBzZW50
LCBhbmQgdGhlIHNlY29uZCBvbmUuDQo+ID4gVGhpcyBjaGFuZ2Ugc3BsaXRzIHRoZSBzaW5nbGUt
dHJhbnNmZXIgdHJhbnNmZXIgb2YgMiBieXRlcyBpbnRvIDIgdHJhbnNmZXJzDQo+ID4gd2l0aCBh
IHNpbmdsZSBieXRlLCBhbmQgQ1MgY2hhbmdlIGluLWJldHdlZW4uDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogRHJhZ29zIEJvZ2RhbiA8ZHJhZ29zLmJvZ2RhbkBhbmFsb2cuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxv
Zy5jb20+DQo+IA0KPiBGaXhlcyB0YWcgd291bGQgaGF2ZSBiZWVuIG5pY2UuIEkndmUgaGFkIGEg
Z28gYnkgcGlja2luZyBhIHBhdGNoIHdoZXJlIEkNCj4gcmVmYWN0b3JlZCB0aGlzIGNvZGUsIGJ1
dCBJIHRoaW5rIHRoZSBpc3N1ZSBwcm9iYWJseSBwcmVkYXRlcyB0aGF0IG9uZS4NCj4gSXRzIGlu
IDIwMTEgc28gSSBkb3VidCBhbnlvbmUgd2lsbCB0cnkgZ29pbmcgcGFzdCB0aGF0IHdpdGggYmFj
a3BvcnRzIDspDQo+IA0KDQpBcG9sb2dpZXMgYWdhaW4gZm9yIG5vdCBjb25zaWRlcmluZyBGaXhl
cyB0YWcuDQpBdCB0aGlzIHBvaW50LCBJIGZlZWwgYmFkIGZvciByZXBlYXRpbmcgdGhlIGFwb2xv
Z3ksIGFzIGl0IG1heSBzb3VuZCBsaWtlIGhvbGxvdw0KDQp3b3Jkcy4NCkJ1dCwgSSBndWVzcyB0
aGlzIGNvdWxkIGhhdmUgc2tpcHBlZCBnb2luZyB0aHJvdWdoIHRoZSBmaXhlcyByb3V0ZS4NClRo
ZSBwYXRjaCBoYXMgYmVlbiBsaXZpbmcgaW4gb3VyIHRyZWUgZm9yIGEgd2hpbGUuDQoNCj4gQXBw
bGllZCB0byB0aGUgZml4ZXMtdG9ncmVnIGJyYW5jaCBvZiBpaW8uZ2l0IGFuZCBtYXJrZWQgZm9y
IHN0YWJsZS4NCj4gDQo+IEknbSBndWVzc2luZyB0aGlzIG1lYW5zIHlvdSBoYXZlIGhhcmR3YXJl
IGFuZCBob3BlIHRvIGdldCB0aGlzIG9uZSBvdXQNCj4gb2Ygc3RhZ2luZyBzaG9ydGx5PyAqY3Jv
c3NlcyBmaW5nZXJzKiA6KQ0KDQpTb3JyeSwgYnV0IG5vdCBhdCB0aGlzIHBvaW50IGluIHRpbWUu
DQpJIGp1c3QgZmlzaGVkIHRoaXMgZnJvbSBvdXIgdHJlZS4NCkkgYWxzbyBoYW5kbGUgb3VyIGtl
cm5lbCB1cGdyYWRlcyBbb24gb3VyIHNpZGVdLCBhbmQgd2hlbmV2ZXIgSSBkbyBhbiB1cGRhdGUs
DQpzb21lIHVwc3RyZWFtZWQgcGF0Y2hlcyBkaXNhcHBlYXIgZnJvbSBvdXIgdHJlZSwgYW5kIHNv
bWUgc3RhbmQtb3V0IGFuZCBJIHdvbmRlcg0KaG93IGNvbWUgdGhpcyB3YXNuJ3Qgc2VudCB1cHN0
cmVhbS4NClRoaXMgaXMgb25lIG9mIHRoZW0uDQoNCkkgZG9uJ3Qga25vdyBpZiBJJ2xsIGJlIGFi
bGUgdG8gZmluZCBzb21lb25lIFtpbiB0aGUgbmVhciBmdXR1cmVdIHRvIGFsbG9jYXRlDQp0aGlz
IHRvIFtmb3IgbW92aW5nIG91dC1vZi1zdGFnaW5nXS4NClJpZ2h0IG5vdywgdGhlIHByaW9yaXR5
IFtvbiBvdXIgc2lkZV0gaXMgdGhlIGhpZ2gtc3BlZWQgY29udmVydGVycy4NCg0KDQo+IA0KPiBK
b25hdGhhbg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zdGFnaW5nL2lpby9yZXNvbHZlci9h
ZDJzMTIxMC5jIHwgMTcgKysrKysrKysrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvc3RhZ2luZy9paW8vcmVzb2x2ZXIvYWQyczEyMTAuYw0KPiA+IGIvZHJpdmVycy9zdGFn
aW5nL2lpby9yZXNvbHZlci9hZDJzMTIxMC5jDQo+ID4gaW5kZXggNGIyNWEzYTMxNGVkLi5lZDQw
NDM1NWVhNGMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2lpby9yZXNvbHZlci9h
ZDJzMTIxMC5jDQo+ID4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2lpby9yZXNvbHZlci9hZDJzMTIx
MC5jDQo+ID4gQEAgLTEzMCwxNyArMTMwLDI0IEBAIHN0YXRpYyBpbnQgYWQyczEyMTBfY29uZmln
X3dyaXRlKHN0cnVjdCBhZDJzMTIxMF9zdGF0ZQ0KPiA+ICpzdCwgdTggZGF0YSkNCj4gPiAgc3Rh
dGljIGludCBhZDJzMTIxMF9jb25maWdfcmVhZChzdHJ1Y3QgYWQyczEyMTBfc3RhdGUgKnN0LA0K
PiA+ICAJCQkJdW5zaWduZWQgY2hhciBhZGRyZXNzKQ0KPiA+ICB7DQo+ID4gLQlzdHJ1Y3Qgc3Bp
X3RyYW5zZmVyIHhmZXIgPSB7DQo+ID4gLQkJLmxlbiA9IDIsDQo+ID4gLQkJLnJ4X2J1ZiA9IHN0
LT5yeCwNCj4gPiAtCQkudHhfYnVmID0gc3QtPnR4LA0KPiA+ICsJc3RydWN0IHNwaV90cmFuc2Zl
ciB4ZmVyc1tdID0gew0KPiA+ICsJCXsNCj4gPiArCQkJLmxlbiA9IDEsDQo+ID4gKwkJCS5yeF9i
dWYgPSAmc3QtPnJ4WzBdLA0KPiA+ICsJCQkudHhfYnVmID0gJnN0LT50eFswXSwNCj4gPiArCQkJ
LmNzX2NoYW5nZSA9IDEsDQo+ID4gKwkJfSwgew0KPiA+ICsJCQkubGVuID0gMSwNCj4gPiArCQkJ
LnJ4X2J1ZiA9ICZzdC0+cnhbMV0sDQo+ID4gKwkJCS50eF9idWYgPSAmc3QtPnR4WzFdLA0KPiA+
ICsJCX0sDQo+ID4gIAl9Ow0KPiA+ICAJaW50IHJldCA9IDA7DQo+ID4gIA0KPiA+ICAJYWQyczEy
MTBfc2V0X21vZGUoTU9EX0NPTkZJRywgc3QpOw0KPiA+ICAJc3QtPnR4WzBdID0gYWRkcmVzcyB8
IEFEMlMxMjEwX01TQl9JU19ISUdIOw0KPiA+ICAJc3QtPnR4WzFdID0gQUQyUzEyMTBfUkVHX0ZB
VUxUOw0KPiA+IC0JcmV0ID0gc3BpX3N5bmNfdHJhbnNmZXIoc3QtPnNkZXYsICZ4ZmVyLCAxKTsN
Cj4gPiArCXJldCA9IHNwaV9zeW5jX3RyYW5zZmVyKHN0LT5zZGV2LCB4ZmVycywgMik7DQo+ID4g
IAlpZiAocmV0IDwgMCkNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+ICANCg==
