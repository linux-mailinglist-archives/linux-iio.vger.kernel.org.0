Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A4E173230
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2020 08:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgB1H4X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Feb 2020 02:56:23 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:26800 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbgB1H4X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Feb 2020 02:56:23 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01S7uLbF027951;
        Fri, 28 Feb 2020 02:56:21 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0b-00128a01.pphosted.com with ESMTP id 2yepx31528-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Feb 2020 02:56:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz4xmpsIb8MLeeAzJScatXpqFz0V4HKYh95baTzL+fiDR62FU61sUg2d+sa5S+h+gZ0ypmkKNeJjQaMwBVrSBAQxo5qM81npI++8ZIOVqcgpaLN8e1gsJJLOK8mSyyh0PFAN+igGtJBKdmPKZ5J9vRKrjUVDkQfPyslba5Ml6ufLbFlzFMYgf7ifXtqrbXpqvbf9bwxDb9TtT3dZKzN3V/RIl+E1gfjFa6DPAz9GtxYQPo1qKnNUSdfvrQ047zW/hqss4TIdFNF7BsbkoLQuxEqUv4iugYhNESLCj1rubn7JZ8T5biDAu42z6+zYSh9MmvnsvZTrFdpUISvO88YEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tegd73btvEJl5slOP/FchameDagnA/5evxSGCQTVQIY=;
 b=PUlRBO4TVziqPd5c5Rtt+k3WBahyJuDTeOWd3b3Scx0Kmr6hBxjZdykH5IQRqM03ZAfjnDjRzHoI7EGmrQYHKQr6D0IWyqWU5TKHOy376RlyMFJCNsUbQFmrm7uN3v0HaPi98Tw2xklW5RHOV6SLjbd+zh1UafrrPjps8LItgWXJlDjBhdeQBF9EnJVNOosR6Dg7gWZVsI3VD6uI/p69A1qQ5xMb1Yj++tv0XwFkcvFeUAMTr6e6GMnMhL6XbiaEUvOYpaMZG3/zkeHbnk9h0yVy6EHhCoE4S0DwpQ6jGcZTUYqBqZqloQ77+1nO5lbS1QI2Higgxnaqo2Hw8+DDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tegd73btvEJl5slOP/FchameDagnA/5evxSGCQTVQIY=;
 b=F3EED4Ro5kHpr9AU3XTV1XrsJOMl+ByZzvV8IU8na9Q9ipTb4NYGHVLOC0xtLj2+MtsGuozkZN01VSdSmoU2jz2ZkAm+wV0ceUjFtmDmjP7B7vVcCwa5VGSBJrxCEiA2TISis/6URHI98N12rsjTs/VZx89pWMrrI6KflDSjUG0=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5272.namprd03.prod.outlook.com (2603:10b6:610:a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 28 Feb
 2020 07:56:15 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 07:56:15 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "rohitsarkar5398@gmail.com" <rohitsarkar5398@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: max1363: replace mlock with own lock
Thread-Topic: [PATCH v2] iio: adc: max1363: replace mlock with own lock
Thread-Index: AQHV7aFZGgU1G3dG5k+YrSz9gDTDzKgwPdYA
Date:   Fri, 28 Feb 2020 07:56:14 +0000
Message-ID: <519965df20014e135acc9cc9c4674bbba8d76f1a.camel@analog.com>
References: <5e5813b9.1c69fb81.e3d1a.5426@mx.google.com>
In-Reply-To: <5e5813b9.1c69fb81.e3d1a.5426@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ee84d40-3b35-45f9-a527-08d7bc23af91
x-ms-traffictypediagnostic: CH2PR03MB5272:
x-microsoft-antispam-prvs: <CH2PR03MB5272701B76B83AEA54430BD5F9E80@CH2PR03MB5272.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(136003)(199004)(189003)(6506007)(478600001)(71200400001)(26005)(6512007)(110136005)(2616005)(2906002)(6486002)(86362001)(91956017)(36756003)(316002)(186003)(66476007)(66446008)(66946007)(64756008)(66556008)(81156014)(81166006)(8676002)(8936002)(5660300002)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5272;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q73edSjPb0jns/07Mmw0upagvQRui59SpVLJyOD8CfNHFMmHdOCXFGLz1fh8Jf4tgvNUrGIQLxOvJ2rMdiN6b9CJNn0g/W4+54Jx1rC7prbTcW/tiv4NRseKvq3KUUUugfF8/d9owx0lnZzoVArNrlkNKlyClEbgg7UfnwyUvb6rTkqO/zV2u1Y+qmaPYgDLOzJNqn2Zwpah2v8mRlt5LYrCOVg+3dKPSe13IaRujnSKqHpH6UnhkmIwmeUJgcBa9XRlBxv+ezgCevJEoTITw4Ev9dEPF25KgB8R4r8d3YD2bLObKlVLhna9jZtbkw8Zsf117+Pw76JvAj/7rLKXXW7hcBu/gr8Jw6R05L6TWkbHY26/lr+cUXg3dQg4U0Ejihrtqcap+AasxA1P5viiPRjKXEi5qDD8zBS8VjxiIUghRrhcorSDa8Z1QN9da1Ug
x-ms-exchange-antispam-messagedata: 7F6zlVcBScYet0yZxj4RBhb2KYh8pQWNoLA9NxP4GPn8nBllTT3Y0gTodoFRbcMrLV+xZjRxi541Pgcz0sHsd22nAVmwuO9lub1uSzWtQJLRg6rOp994tCOAE4p4QiCPRBhEXdsZs6RBjwzwIIQLcg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <107A5D8EEBE1D440BB97DCC39A6488E4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee84d40-3b35-45f9-a527-08d7bc23af91
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 07:56:15.0335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OfTJ0DaL4EGddNunRPCpctefzKvf1Ig9RVaciUa8VAeIR1nm89xkHklS251aydnGDszlJHm558r3/XhOROi7cHLtpWL6hNKF0qak/8KOWhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5272
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_02:2020-02-26,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280067
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTAyLTI4IGF0IDAwOjM4ICswNTMwLCBSb2hpdCBTYXJrYXIgd3JvdGU6DQo+
IFRoaXMgY2hhbmdlIHJlcGxhY2VzIGluZGlvX2RldidzIG1sb2NrIHdpdGggdGhlIGRyaXZlcnMg
b3duIGxvY2suIEluDQo+IGVhY2ggY2FzZSB0aGUgbG9jayBpcyBuZWVkZWQgdG8gcHJvdGVjdCB0
aGUgZHJpdmVyJ3Mgb3duIHN0YXRlLg0KPiANCj4gQ2hhbmdlcyBmcm9tIHYxOg0KPiBGaXggaW5k
ZW50YXRpb24uDQo+IEFkZCBhIG11dGV4X2luaXQoKSBpbiB0aGUgcHJvYmUgZnVuY3Rpb24uDQo+
IA0KDQpUaGlzIGxvb2tzIGxpa2UgdGhlIGZpcnN0IHBhdGNoLg0KSSBkb24ndCBzZWUgdGhlIGNv
ZGUgY2hhbmdlcyBmcm9tIHRoZSBmaXJzdCBvbmUuDQoNCg0KPiBTaWduZWQtb2ZmLWJ5OiBSb2hp
dCBTYXJrYXIgPHJvaGl0c2Fya2FyNTM5OEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9p
aW8vYWRjL21heDEzNjMuYyB8IDEzICsrKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9paW8vYWRjL21heDEzNjMuYyBiL2RyaXZlcnMvaWlvL2FkYy9tYXgxMzYzLmMNCj4gaW5kZXgg
NWMyY2M2MWI2NjZlLi5iOTU1N2Y5NTdmM2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2Fk
Yy9tYXgxMzYzLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL21heDEzNjMuYw0KPiBAQCAtMTY5
LDYgKzE2OSw3IEBAIHN0cnVjdCBtYXgxMzYzX3N0YXRlIHsNCj4gIAljb25zdCBzdHJ1Y3QgbWF4
MTM2M19tb2RlCSpjdXJyZW50X21vZGU7DQo+ICAJdTMyCQkJCXJlcXVlc3RlZG1hc2s7DQo+ICAJ
c3RydWN0IHJlZ3VsYXRvcgkJKnJlZzsNCj4gKwlzdHJ1Y3QgbXV0ZXggbG9jazsNCj4gIA0KPiAg
CS8qIFVzaW5nIG1vbml0b3IgbW9kZXMgYW5kIGJ1ZmZlciBhdCB0aGUgc2FtZSB0aW1lIGlzDQo+
ICAJICAgY3VycmVudGx5IG5vdCBzdXBwb3J0ZWQgKi8NCj4gQEAgLTM2NCw3ICszNjUsNyBAQCBz
dGF0aWMgaW50IG1heDEzNjNfcmVhZF9zaW5nbGVfY2hhbihzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5k
aW9fZGV2LA0KPiAgCXN0cnVjdCBtYXgxMzYzX3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rl
dik7DQo+ICAJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHN0LT5jbGllbnQ7DQo+ICANCj4g
LQltdXRleF9sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4gKwltdXRleF9sb2NrKCZzdC0+bG9j
ayk7DQo+ICAJLyoNCj4gIAkgKiBJZiBtb25pdG9yIG1vZGUgaXMgZW5hYmxlZCwgdGhlIG1ldGhv
ZCBmb3IgcmVhZGluZyBhIHNpbmdsZQ0KPiAgCSAqIGNoYW5uZWwgd2lsbCBoYXZlIHRvIGJlIHJh
dGhlciBkaWZmZXJlbnQgYW5kIGhhcyBub3QgeWV0DQo+IEBAIC00MDUsNyArNDA2LDcgQEAgc3Rh
dGljIGludCBtYXgxMzYzX3JlYWRfc2luZ2xlX2NoYW4oc3RydWN0IGlpb19kZXYNCj4gKmluZGlv
X2RldiwNCj4gIAl9DQo+ICAJKnZhbCA9IGRhdGE7DQo+ICBlcnJvcl9yZXQ6DQo+IC0JbXV0ZXhf
dW5sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4gKwltdXRleF91bmxvY2soJnN0LT5sb2NrKTsN
Cj4gIAlyZXR1cm4gcmV0Ow0KPiAgDQo+ICB9DQo+IEBAIC03MDUsOSArNzA2LDkgQEAgc3RhdGlj
IHNzaXplX3QgbWF4MTM2M19tb25pdG9yX3N0b3JlX2ZyZXEoc3RydWN0IGRldmljZQ0KPiAqZGV2
LA0KPiAgCWlmICghZm91bmQpDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgDQo+IC0JbXV0ZXhf
bG9jaygmaW5kaW9fZGV2LT5tbG9jayk7DQo+ICsJbXV0ZXhfbG9jaygmc3QtPm1sb2NrKTsNCj4g
IAlzdC0+bW9uaXRvcl9zcGVlZCA9IGk7DQo+IC0JbXV0ZXhfdW5sb2NrKCZpbmRpb19kZXYtPm1s
b2NrKTsNCj4gKwltdXRleF91bmxvY2soJnN0LT5tbG9jayk7DQo+ICANCj4gIAlyZXR1cm4gMDsN
Cj4gIH0NCj4gQEAgLTgxMCwxMiArODExLDEyIEBAIHN0YXRpYyBpbnQgbWF4MTM2M19yZWFkX2V2
ZW50X2NvbmZpZyhzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0KPiAgCWludCB2YWw7DQo+
ICAJaW50IG51bWJlciA9IGNoYW4tPmNoYW5uZWw7DQo+ICANCj4gLQltdXRleF9sb2NrKCZpbmRp
b19kZXYtPm1sb2NrKTsNCj4gKwltdXRleF9sb2NrKCZzdC0+bWxvY2spOw0KPiAgCWlmIChkaXIg
PT0gSUlPX0VWX0RJUl9GQUxMSU5HKQ0KPiAgCQl2YWwgPSAoMSA8PCBudW1iZXIpICYgc3QtPm1h
c2tfbG93Ow0KPiAgCWVsc2UNCj4gIAkJdmFsID0gKDEgPDwgbnVtYmVyKSAmIHN0LT5tYXNrX2hp
Z2g7DQo+IC0JbXV0ZXhfdW5sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4gKwltdXRleF91bmxv
Y2soJnN0LT5tbG9jayk7DQo+ICANCj4gIAlyZXR1cm4gdmFsOw0KPiAgfQ0K
