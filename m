Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6899F16C269
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 14:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgBYNeF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 08:34:05 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:34224 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729501AbgBYNeF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 08:34:05 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PDPLH7004248;
        Tue, 25 Feb 2020 08:34:01 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0b-00128a01.pphosted.com with ESMTP id 2yb1tcf40y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 08:34:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuBvaIRyw5WQEjC6ZbxtDeVYf2Njid+g51Ebvm/RWtMZ7vuHmn9fpz3h2DFDum6k+McV1mdozfk/7Z5UfKnfJtB36lSx0ZOfVmSJjyzudWMlgVfvO1kma42ESpF+eIvf4Wpj2+VsL0omEr3ssw5gdXSvrWIAjx0qJwFufnyvUn/RJJIVSrDUO6dCi9DoINjpYIqnNshUiC6TqnvUYwj7vZYqzMIzbMLgnmCsVq4Oah7MfygLaKm0fhB7AD8FjrMnckYHl2rrdadETTWZVOC1i6DJd5yHcwE2XuImATOchzyKBkfdQLCnG0ihCHnYxL+2FZZQpvXp9kHr37ThGQI3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDBo7UwsYTLle/zk5jGl9Tgmz1Y57SxrVEEX3uvvJhs=;
 b=gDxKZ9757yAf170diVAu0cROVWNMbmq80VW0Uo1pyazYFcY0jw/DFHPwXx0W/jpuX2N1nGfM/mjCms5xyn/gxeYK5ZC7hW8YPZHFIaiePbjw1vmp2YyrGUWOFjBteP2R/OFlNKWzHw9KXejzKWAPL61xUukkmlSW8WEuoTfC604oChP/lSlKqAgKxgUmv75igvvuu7wq76FXvW79Hs/lSv+14MQ8hwY758ZXDuJ7MTvZ/n+YA9iMw6bup2r2s1r9r2q7ZW4vqPHreEJxZJXXbkvDFhHOcpujkuZphuSi5sFerlTkvp2pRMfCT2K8fnORh+APdorIcXzqd69g48LwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDBo7UwsYTLle/zk5jGl9Tgmz1Y57SxrVEEX3uvvJhs=;
 b=kpuYX+DtWth4reWDjJD5bStpTtDucSDiwOWdFHCy6+D8Rf9uu4JhyOyP85a4QMhzW762ktEt/SDN7ZYADF5+mHPtYflIxEJy1NUd6dnYqOHFMsUXRPuVpA4OuxFnJ60/ZPFSaLk+Is3zBU1bN8A1UKrbaFJUidHFJNZ2c5lTllI=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5366.namprd03.prod.outlook.com (2603:10b6:610:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Tue, 25 Feb
 2020 13:33:59 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 13:33:59 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/5] iio: buffer-dmaengine: add dev-managed calls for
 buffer alloc/free
Thread-Topic: [PATCH 1/5] iio: buffer-dmaengine: add dev-managed calls for
 buffer alloc/free
Thread-Index: AQHV5/6IulMe0NcvZ0qBYbnSY8yDIqglktWAgAZdpAA=
Date:   Tue, 25 Feb 2020 13:33:59 +0000
Message-ID: <142a971a778bd8e8ad0bc830390d36e2ac10a5c6.camel@analog.com>
References: <20200220150317.1864-1-alexandru.ardelean@analog.com>
         <20200221122115.48d8ca90@archlinux>
In-Reply-To: <20200221122115.48d8ca90@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc043500-d10d-47f0-6561-08d7b9f75ef8
x-ms-traffictypediagnostic: CH2PR03MB5366:
x-microsoft-antispam-prvs: <CH2PR03MB536600987CF165C9E47E3B1DF9ED0@CH2PR03MB5366.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(81166006)(2616005)(186003)(6486002)(8676002)(81156014)(4326008)(498600001)(6512007)(6916009)(26005)(64756008)(76116006)(91956017)(36756003)(71200400001)(2906002)(54906003)(66556008)(86362001)(6506007)(8936002)(66446008)(5660300002)(66946007)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5366;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3iInLw6KMjHg6x70TMQOI35I3h21hXK3xY7s3MLYbwIXigHTJLl//Pla2Pjp40QpvfiiOxr7kjysGKPUGB9SGroGXSBoB2x4MpCoeY6yLS2bVj27t/uzGF0hc3ijqSeZYnzxmMbWCz9jL8TREh+nR6ftTqyBmEh5Hcdwl9gRlUsOBk4HJVWOXLrbekuzS/YlfsEksqXdl8kN5zVEUt8snlDA/FOSMpGK44GNzeMC+aoQ9+UVhRLEHnC06s+5XWt1m+d11z6uIc1gOufaHQ8vl/eQxcDFVNhmK3lw+QfUEr0vyAED1tEBMlA/Z+K+9kb1BwlDGhc8SVB3HrrAeKKjZgk9SsLIqT8fiAqy7W7RTyPyfpP3w670tbBK1IM9uPXokxb+WC5xjlD7OZn1isNYpVfQx075bn2ug6DZvgRH30CQLhvXwshy8CbV9o4AsrOR
x-ms-exchange-antispam-messagedata: bFSa4XAV9Rt1ZVOUMKxM6/pqIsFcewU6yX3mwOastZIefHJjGQVaER5J3pjXhwJgrInL6VGNEnZ8flZbv8TzAJ+N9y31lQbfv6BJHz3siqjmEoibIjPY45CcvUjwL+NjR7i0wSYVt4Tg1jEsBqZHLQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0A2CC9B1E4BDB458AA9EC29F7DBE6DE@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc043500-d10d-47f0-6561-08d7b9f75ef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 13:33:59.2853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4gj2syTWt2Zrcbps/sAMkiuVH+yA5vHZ63MUTAejt2TSjT6mJHzldU65z21apNuPlq/AQro2Le9eFBs3Lba7vpYwIdiiTgi2LZJjDVj+rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5366
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_04:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002250107
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTAyLTIxIGF0IDEyOjIxICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUaHUsIDIwIEZlYiAyMDIwIDE3OjAzOjEzICswMjAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBDdXJyZW50bHksIHdoZW4gdXNpbmcgYSAnaWlvX2RtYWVuZ2luZV9idWZm
ZXJfYWxsb2MoKScsIGFuIG1hdGNoaW5nIGNhbGwgdG8NCj4gPiAnaWlvX2RtYWVuZ2luZV9idWZm
ZXJfZnJlZSgpJyBtdXN0IGJlIG1hZGUuDQo+ID4gDQo+ID4gV2l0aCB0aGlzIGNoYW5nZSwgdGhp
cyBjYW4gYmUgYXZvaWRlZCBieSB1c2luZw0KPiA+ICdkZXZtX2lpb19kbWFlbmdpbmVfYnVmZmVy
X2FsbG9jKCknLiBUaGUgYnVmZmVyIHdpbGwgZ2V0IGZyZWUnZCB2aWEgdGhlDQo+ID4gZGV2aWNl
J3MgZGV2cmVzIGhhbmRsaW5nLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBB
cmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gLS0tDQo+ID4gIC4u
Li9idWZmZXIvaW5kdXN0cmlhbGlvLWJ1ZmZlci1kbWFlbmdpbmUuYyAgICB8IDcwICsrKysrKysr
KysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9saW51eC9paW8vYnVmZmVyLWRtYWVuZ2luZS5oICAg
ICAgICAgIHwgIDUgKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3NSBpbnNlcnRpb25zKCspDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2J1ZmZlci9pbmR1c3RyaWFsaW8tYnVm
ZmVyLWRtYWVuZ2luZS5jDQo+ID4gYi9kcml2ZXJzL2lpby9idWZmZXIvaW5kdXN0cmlhbGlvLWJ1
ZmZlci1kbWFlbmdpbmUuYw0KPiA+IGluZGV4IGIxMjk2OTNhZjBmZC4uZWZmODkwMzdlM2Y1IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2J1ZmZlci9pbmR1c3RyaWFsaW8tYnVmZmVyLWRt
YWVuZ2luZS5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYnVmZmVyL2luZHVzdHJpYWxpby1idWZm
ZXItZG1hZW5naW5lLmMNCj4gPiBAQCAtMjI5LDYgKzIyOSw3NiBAQCB2b2lkIGlpb19kbWFlbmdp
bmVfYnVmZmVyX2ZyZWUoc3RydWN0IGlpb19idWZmZXINCj4gPiAqYnVmZmVyKQ0KPiA+ICB9DQo+
ID4gIEVYUE9SVF9TWU1CT0xfR1BMKGlpb19kbWFlbmdpbmVfYnVmZmVyX2ZyZWUpOw0KPiA+ICAN
Cj4gPiArc3RhdGljIHZvaWQgX19kZXZtX2lpb19kbWFlbmdpbmVfYnVmZmVyX2ZyZWUoc3RydWN0
IGRldmljZSAqZGV2LCB2b2lkICpyZXMpDQo+ID4gK3sNCj4gPiArCWlpb19kbWFlbmdpbmVfYnVm
ZmVyX2ZyZWUoKihzdHJ1Y3QgaWlvX2J1ZmZlciAqKilyZXMpOw0KPiA+ICt9DQo+ID4gKw0KPiA+
ICsvKioNCj4gPiArICogZGV2bV9paW9fZG1hZW5naW5lX2J1ZmZlcl9hbGxvYygpIC0gUmVzb3Vy
Y2UtbWFuYWdlZA0KPiA+IGlpb19kbWFlbmdpbmVfYnVmZmVyX2FsbG9jKCkNCj4gPiArICogQGRl
djogUGFyZW50IGRldmljZSBmb3IgdGhlIGJ1ZmZlcg0KPiA+ICsgKiBAY2hhbm5lbDogRE1BIGNo
YW5uZWwgbmFtZSwgdHlwaWNhbGx5ICJyeCIuDQo+ID4gKyAqDQo+ID4gKyAqIFRoaXMgYWxsb2Nh
dGVzIGEgbmV3IElJTyBidWZmZXIgd2hpY2ggaW50ZXJuYWxseSB1c2VzIHRoZSBETUFlbmdpbmUN
Cj4gPiBmcmFtZXdvcmsNCj4gPiArICogdG8gcGVyZm9ybSBpdHMgdHJhbnNmZXJzLiBUaGUgcGFy
ZW50IGRldmljZSB3aWxsIGJlIHVzZWQgdG8gcmVxdWVzdCB0aGUNCj4gPiBETUENCj4gPiArICog
Y2hhbm5lbC4NCj4gPiArICoNCj4gPiArICogT25jZSBkb25lIHVzaW5nIHRoZSBidWZmZXIgaWlv
X2RtYWVuZ2luZV9idWZmZXJfZnJlZSgpIHNob3VsZCBiZSB1c2VkIHRvDQo+ID4gKyAqIHJlbGVh
c2UgaXQuDQo+IA0KPiBVbW0uICBJdCByZWFsbHkgc2hvdWxkbid0IQ0KDQpZZWFoLg0KQ29weStw
YXN0ZS4NCk15IGJhZC4NCg0KDQo+ID4gKyAqLw0KPiA+ICtzdHJ1Y3QgaWlvX2J1ZmZlciAqZGV2
bV9paW9fZG1hZW5naW5lX2J1ZmZlcl9hbGxvYyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gKwlj
b25zdCBjaGFyICpjaGFubmVsKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgaWlvX2J1ZmZlciAqKmJ1
ZmZlcnAsICpidWZmZXI7DQo+ID4gKw0KPiA+ICsJYnVmZmVycCA9IGRldnJlc19hbGxvYyhfX2Rl
dm1faWlvX2RtYWVuZ2luZV9idWZmZXJfZnJlZSwNCj4gPiArCQkJICAgICAgIHNpemVvZigqYnVm
ZmVycCksIEdGUF9LRVJORUwpOw0KPiA+ICsJaWYgKCFidWZmZXJwKQ0KPiA+ICsJCXJldHVybiBF
UlJfUFRSKC1FTk9NRU0pOw0KPiA+ICsNCj4gPiArCWJ1ZmZlciA9IGlpb19kbWFlbmdpbmVfYnVm
ZmVyX2FsbG9jKGRldiwgY2hhbm5lbCk7DQo+ID4gKwlpZiAoIUlTX0VSUihidWZmZXIpKSB7DQo+
ID4gKwkJKmJ1ZmZlcnAgPSBidWZmZXI7DQo+ID4gKwkJZGV2cmVzX2FkZChkZXYsIGJ1ZmZlcnAp
Ow0KPiANCj4gRnJvbSBhIGZsb3cgcG9pbnQgb2YgdmlldyBJJ2QgcHJlZmVyLg0KPiANCj4gCWlm
IChJU19FUlIoYnVmZmVyKSB7DQo+IAkJZGV2cmVzX2ZyZWUoYnVmZXJwKQ0KPiAJCXJldHVybiBi
dWZmZXI7DQo+IAl9DQo+IA0KPiAJKmJ1ZmZlcnAgPSBidWZmZXI7DQo+IAlkZXZyZXNfYWRkKGRl
diwgYnVmZmVycCk7DQo+IA0KPiAJcmV0dXJuIGJ1ZmZlcjsNCj4gDQo+IA0KPiA+ICsJfSBlbHNl
IHsNCj4gPiArCQlkZXZyZXNfZnJlZShidWZmZXJwKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwly
ZXR1cm4gYnVmZmVyOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGRldm1faWlvX2Rt
YWVuZ2luZV9idWZmZXJfYWxsb2MpOw0KPiA+ICsNCj4gPiArc3RhdGljIGludCBkZXZtX2lpb19k
bWFlbmdpbmVfYnVmZmVyX21hdGNoKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCAqcmVzLA0KPiA+
ICsJdm9pZCAqZGF0YSkNCj4gPiArew0KPiA+ICsJc3RydWN0IGlpb19idWZmZXIgKipyID0gcmVz
Ow0KPiA+ICsNCj4gPiArCWlmICghciB8fCAhKnIpIHsNCj4gPiArCQlXQVJOX09OKCFyIHx8ICEq
cik7DQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuICpyID09
IGRhdGE7DQo+ID4gK30NCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsgKiBkZXZtX2lpb19kbWFlbmdp
bmVfYnVmZmVyX2ZyZWUgLSBpaW9fZG1hZW5naW5lX2J1ZmZlcl9mcmVlDQo+ID4gKyAqIEBkZXY6
IERldmljZSB0aGlzIGlpb19idWZmZXIgYmVsb25ncyB0bw0KPiA+ICsgKiBAYnVmZmVyOiBUaGUg
aWlvX2J1ZmZlciBhc3NvY2lhdGVkIHdpdGggdGhlIGRldmljZQ0KPiA+ICsgKg0KPiA+ICsgKiBG
cmVlIGJ1ZmZlciBhbGxvY2F0ZWQgd2l0aCBkZXZtX2lpb19kbWFlbmdpbmVfYnVmZmVyX2FsbG9j
KCkuDQo+ID4gKyAqLw0KPiA+ICt2b2lkIGRldm1faWlvX2RtYWVuZ2luZV9idWZmZXJfZnJlZShz
dHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gKwlzdHJ1Y3QgaWlvX2J1ZmZlciAqYnVmZmVyKQ0KPiA+
ICt7DQo+ID4gKwlpbnQgcmM7DQo+ID4gKw0KPiA+ICsJcmMgPSBkZXZyZXNfcmVsZWFzZShkZXYs
IF9fZGV2bV9paW9fZG1hZW5naW5lX2J1ZmZlcl9mcmVlLA0KPiA+ICsJCQkgICAgZGV2bV9paW9f
ZG1hZW5naW5lX2J1ZmZlcl9tYXRjaCwgYnVmZmVyKTsNCj4gPiArCVdBUk5fT04ocmMpOw0KPiA+
ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGRldm1faWlvX2RtYWVuZ2luZV9idWZmZXJfZnJl
ZSk7DQoNClNob3VsZCBJIHJlbW92ZSBkZXZtX2lpb19kbWFlbmdpbmVfYnVmZmVyX2ZyZWUoKSA/
DQpUaGVyZSB3YXMgYSBjb21tZW50IG9uIHRoZSBBWEkgQURDIHRoYXQgbWF5IGFwcGx5IGhlcmUg
YXMgd2VsbCwgYWJvdXQgbWF5YmUNCnJlbW92aW5nIGl0Lg0KDQo+ID4gKw0KPiA+ICBNT0RVTEVf
QVVUSE9SKCJMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4iKTsNCj4gPiAgTU9E
VUxFX0RFU0NSSVBUSU9OKCJETUEgYnVmZmVyIGZvciB0aGUgSUlPIGZyYW1ld29yayIpOw0KPiA+
ICBNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
aWlvL2J1ZmZlci1kbWFlbmdpbmUuaA0KPiA+IGIvaW5jbHVkZS9saW51eC9paW8vYnVmZmVyLWRt
YWVuZ2luZS5oDQo+ID4gaW5kZXggYjNhNTc0NDRhODg2Li44ZGNkOTczZDc2YzEgMTAwNjQ0DQo+
ID4gLS0tIGEvaW5jbHVkZS9saW51eC9paW8vYnVmZmVyLWRtYWVuZ2luZS5oDQo+ID4gKysrIGIv
aW5jbHVkZS9saW51eC9paW8vYnVmZmVyLWRtYWVuZ2luZS5oDQo+ID4gQEAgLTE0LDQgKzE0LDkg
QEAgc3RydWN0IGlpb19idWZmZXIgKmlpb19kbWFlbmdpbmVfYnVmZmVyX2FsbG9jKHN0cnVjdA0K
PiA+IGRldmljZSAqZGV2LA0KPiA+ICAJY29uc3QgY2hhciAqY2hhbm5lbCk7DQo+ID4gIHZvaWQg
aWlvX2RtYWVuZ2luZV9idWZmZXJfZnJlZShzdHJ1Y3QgaWlvX2J1ZmZlciAqYnVmZmVyKTsNCj4g
PiAgDQo+ID4gK3N0cnVjdCBpaW9fYnVmZmVyICpkZXZtX2lpb19kbWFlbmdpbmVfYnVmZmVyX2Fs
bG9jKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiArCWNvbnN0IGNoYXIgKmNoYW5uZWwpOw0KPiA+
ICt2b2lkIGRldm1faWlvX2RtYWVuZ2luZV9idWZmZXJfZnJlZShzdHJ1Y3QgZGV2aWNlICpkZXYs
DQo+ID4gKwlzdHJ1Y3QgaWlvX2J1ZmZlciAqYnVmZmVyKTsNCj4gUGxlYXNlIGFsaWduIHBhcmFt
ZXRlcnMgd2l0aCBvcGVuaW5nIGJyYWNrZXQgd2hlcmUgcG9zc2libGUuDQo+IA0KDQphY2sNCg0K
PiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiANCj4gPiArDQo+ID4gICNlbmRpZg0K
