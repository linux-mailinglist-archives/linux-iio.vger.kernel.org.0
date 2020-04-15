Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E912E1A92A1
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 07:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393418AbgDOFnc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 01:43:32 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:29054 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393395AbgDOFn2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 01:43:28 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03F5eQFf007928;
        Wed, 15 Apr 2020 01:43:23 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2050.outbound.protection.outlook.com [104.47.46.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 30dn83gx5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 01:43:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcWqMevi/IVYWH8Ri/unePqQMbESH5c2VNsCOEa1ThFNfkSujeGTjhzWRO/0MZv3Wm+uyBUzAeDezdPdw+KlAK6PNrbAtEXLMALOGJtndStvwpVAZSEVmqcVHGipa8NYXESIONp9K92n+heOdba7O/ZUOjSij3i6Vs0iZau4flUcnfpfjecbl21zax35vqI1dMO8a3/Es5rPWnzIoEImTeX2kLa40aHbQ05IAnghCc7oihF3ccW3+TbMb8UzURfZIWlRt5F51W3dPZd1PmFXiid7szC+iKOSktPu6+yI3XOex4/ZHxmiQElD3ai70/BbjMkYpIyQfA8gVqb0B+cquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBWIY63TGIKyogl8iLfbdYtt5Ps+7ee0uYDyrEwZGgY=;
 b=GBCuNkQqwyL9K3Swzb74UOkJMiWLUZnr8atT8guiUTNStOY8WdvXXcvDvVHkJpHB4I9KOSTlP9WbbqFFp1PopKHyYpBXfvMznn1aIbM4hf21ZPfn1RQjNz9K5YqZH6TTYrsG1tu8tYn6g098pBvQgJUfaFElpupq2GhLSj67P+SVwlRxg7iduHWLcmIJUD8V5pZT7z2UxYmGl6QEpyad+vVZkLpMqVa4x3BePyXBM6+I6EhktRg1RdgyuJ8KBhoFz0VGrv+tgBnkedHwc9NfLlAZ/HZJlyPgtSM3bkZgc66LBqHSdbPX+zCA+s9jWg9FkyHSBRQq+dgkuPpnpXSVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBWIY63TGIKyogl8iLfbdYtt5Ps+7ee0uYDyrEwZGgY=;
 b=UsnjkbPm772AHIkBBpXcn8eXm9224CfUihR0LrJ6vNt4mbrZyhJ+RZLzwdjkArYWCz9UEjOHArsiJlSy1bpPbdvSwMDWk1AjIsX8oGV5aWG0Qmeui8aNTHiu0gC11n/RYLCPJDquYHqlcNiA7EcGxHkolw/TPUH7PRi2SGTaslc=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4412.namprd03.prod.outlook.com (2603:10b6:5:107::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Wed, 15 Apr
 2020 05:43:21 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.024; Wed, 15 Apr 2020
 05:43:21 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lars@engebretsen.ch" <lars@engebretsen.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] iio: core: remove extra semi-colon from
 devm_iio_device_register() macro
Thread-Topic: [PATCH] iio: core: remove extra semi-colon from
 devm_iio_device_register() macro
Thread-Index: AQHWEoyhteKpF4p11EGbglnW/AlH1Kh5rYiA
Date:   Wed, 15 Apr 2020 05:43:21 +0000
Message-ID: <d11920433cd3c6476c1c0da18846b7d41cd1fde3.camel@analog.com>
References: <20200414184237.23018-1-lars@engebretsen.ch>
In-Reply-To: <20200414184237.23018-1-lars@engebretsen.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 339f20bd-13a7-4253-5a65-08d7e0ffe843
x-ms-traffictypediagnostic: DM6PR03MB4412:
x-microsoft-antispam-prvs: <DM6PR03MB4412B02230D4F7B18C90B0C5F9DB0@DM6PR03MB4412.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:45;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(346002)(39860400002)(376002)(366004)(136003)(26005)(4326008)(6486002)(8936002)(86362001)(2616005)(5660300002)(316002)(2906002)(36756003)(186003)(6512007)(66476007)(8676002)(91956017)(81156014)(6506007)(66556008)(71200400001)(478600001)(66446008)(66946007)(76116006)(110136005)(64756008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4ZEkzjbJQxcGlhcV0WKdmHSYyDr68vdkRsS0rg6vxb7FZF1aUNuGWQtuLkzV80glsM598bm9/5e2/8zdeGBNpSGvHF0MfzqwfdwlGwYwH+WcGOxO93Mj5tcshJ07eBiduSuyu5F47RlG3OPlwOcF0/fDswnh/x8b4A3zNd+C3RA4XmhgvyB6nKWWL9siwnFuKBnwXcns6Y3l6higZMXDU9L5XvHnyXgKC/DYV00blDYPx+F99OvhvEl6e931QiOefQ8uvb+sRQ8nyxgf6z45UXKbARXe31yS+OiG1Hh8qxefQ/qXffRgRqLXzPIDOKJ+W6hprcVQFPvenU2Q8QW10U/Z5kl+4TMdkC73Ws3UG1Y0EwFB8/woQsKmia074ZeNOZBmUvhR5JcIzvroIEM4LHSFMa8b9+1SvfrlPbGv0Pa8Ib28sNOYTodz2cXrqfs
x-ms-exchange-antispam-messagedata: zM1+m8mfG2ZxR0OnCd9BQrjwmdInxjXPr5cTrHIfUepcmhYNCnuSyuYw7vwUGGkx8ihjvr6+lT72x2cifxoZRxmbiqPICscZsjSaxjDVAZjVeZCEUTjDNJr0I13Jygj/9FXGcjH+R9j4XCcw5c/ujQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E373698BC01442488083654EAE5D83A4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339f20bd-13a7-4253-5a65-08d7e0ffe843
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 05:43:21.2675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLMqJa+goiKyU/0A+Qh3wgxSXcSHqy/4iyM1KjZJLX5tgJf7nH5sq0mW/RE4l5+1X+kM3lW4r1SZJWO7KAu8KKsxyUcjw2LuWNX5x/WF740=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4412
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_01:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150042
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTE0IGF0IDIwOjQyICswMjAwLCBMYXJzIEVuZ2VicmV0c2VuIHdyb3Rl
Og0KDQpBIGRlc2NyaXB0aW9uIG9mIHRoZSBjaGFuZ2UgaXMgcmVxdWlyZWQgdG8gZGVzY3JpYmUg
dGhlIGNoYW5nZS4NCkkgdGhpbmsgSSBtZW50aW9uZWQgdGhpcyBpbiBteSBlbWFpbCwgYnV0IEkg
d2FzIGxhenkgdG8gcHJvdmlkZSBhbiBleGFtcGxlLg0KDQpEZXNjcmlwdGlvbiBvZiBjaGFuZ2Vz
IGFyZSByZXF1aXJlZCBldmVuIGZvciB0aGUgc21hbGxlc3Qgb2YgY2hhbmdlczsgSSB0aGluaw0K
aXQncyBtb3N0bHkgc28gdGhhdCBwZW9wbGUgYWx3YXlzIGtlZXAgdGhlaXIgYnJhaW5zIHRyYWlu
ZWQgdG8gZGVzY3JpYmUgYWxsDQpjaGFuZ2VzLg0KDQpTbyBoZXJlLCB5b3UgY291bGQgc2F5IHNv
bWV0aGluZyBsaWtlOg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpUaGlzIGNoYW5nZSByZW1vdmVzIHRo
ZSBzZW1pLWNvbG9uIGZyb20gdGhlIGRldm1faWlvX2RldmljZV9yZWdpc3RlcigpIG1hY3JvDQp3
aGljaCBzZWVtcyB0byBoYXZlIGJlZW4gYWRkZWQgYnkgYWNjaWRlbnQgdmlhIGNvbW1pdCA2M2Ix
OTU0N2NjM2Q5ICgiaWlvOiBVc2UNCm1hY3JvIG1hZ2ljIHRvIGF2b2lkIG1hbnVhbCBhc3NpZ24g
b2YgZHJpdmVyX21vZHVsZSIpLg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCk1ha2Ugc3VyZSBjb21t
aXQgY29tbWVudHMgc3RheSB3aXRoaW4gYSA3NSBjb2x1bW4gd2lkdGggbGltaXQuDQpBbmQgbWFr
ZSBzdXJlIHlvdSBhZGQgYSB2ZXJzaW9uIHRhZyBmb3IgdGhlIG5leHQgcGF0Y2gvcmUtc2VuZC4N
CmkuZS4gZG8gIGdpdCBmb3JtYXQtcGF0Y2ggLXYyICBbb3IgdjMgZm9yIDNyZCB2ZXJzaW9uLF0N
Cg0KQW5kIGl0J3MgYSBnb29kIGlkZWEgdG8gYWRkIGEgY2hhbmdlbG9nIGFmdGVyIHRoZSBsaW5l
IHdpdGggJy0tLScgaW4gdGhlIHBhdGNoDQpmaWxlLiBUZXh0IGFmdGVyIHRoYXQgbGluZSBnZXRz
IGlnbm9yZWQgZm9yIHRoZSBjb21taXQgZGVzY3JpcHRpb24uDQpTb21ldGhpbmcgbGlrZToNCg0K
Q2hhbmdlbG9nIHYxIC0+IHYyOg0KKiBhZGRlZCBjb21taXQgY2hhbmdlIGRlc2NyaXB0aW9uDQoN
Cg0KPiBTaWduZWQtb2ZmLWJ5OiBMYXJzIEVuZ2VicmV0c2VuIDxsYXJzQGVuZ2VicmV0c2VuLmNo
Pg0KPiAtLS0NCj4gIGluY2x1ZGUvbGludXgvaWlvL2lpby5oIHwgMiArLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9paW8vaWlvLmggYi9pbmNsdWRlL2xpbnV4L2lpby9paW8uaA0KPiBpbmRl
eCBkNjM4ODRhNTQ5MzkuLjc2YmE3YzlmZDNlMCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51
eC9paW8vaWlvLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9paW8vaWlvLmgNCj4gQEAgLTU5Nyw3
ICs1OTcsNyBAQCB2b2lkIGlpb19kZXZpY2VfdW5yZWdpc3RlcihzdHJ1Y3QgaWlvX2RldiAqaW5k
aW9fZGV2KTsNCj4gICAqIDAgb24gc3VjY2VzcywgbmVnYXRpdmUgZXJyb3IgbnVtYmVyIG9uIGZh
aWx1cmUuDQo+ICAgKi8NCj4gICNkZWZpbmUgZGV2bV9paW9fZGV2aWNlX3JlZ2lzdGVyKGRldiwg
aW5kaW9fZGV2KSBcDQo+IC0JX19kZXZtX2lpb19kZXZpY2VfcmVnaXN0ZXIoKGRldiksIChpbmRp
b19kZXYpLCBUSElTX01PRFVMRSk7DQo+ICsJX19kZXZtX2lpb19kZXZpY2VfcmVnaXN0ZXIoKGRl
diksIChpbmRpb19kZXYpLCBUSElTX01PRFVMRSkNCj4gIGludCBfX2Rldm1faWlvX2RldmljZV9y
ZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+
ICAJCQkgICAgICAgc3RydWN0IG1vZHVsZSAqdGhpc19tb2QpOw0KPiAgaW50IGlpb19wdXNoX2V2
ZW50KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsIHU2NCBldl9jb2RlLCBzNjQgdGltZXN0YW1w
KTsNCg==
