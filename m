Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8126CE6E2A
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 09:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbfJ1IZq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Oct 2019 04:25:46 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:50576 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729786AbfJ1IZq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Oct 2019 04:25:46 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9S8O0HI028264;
        Mon, 28 Oct 2019 04:25:26 -0400
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2053.outbound.protection.outlook.com [104.47.42.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vvjs63n7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 28 Oct 2019 04:25:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6viDvrk/xApI3SwoVg9148jEg0YatLPvc3Nkgm/HRzB/yv+cJwJrxsDFEGIWcM4TTPf1jtwtDWpvf4AOeauhX4XtdM5ELupzBcDKo9urnmb2F2k6jkrVeGjKaoIuWh1BC1N5JoRdM8vG88z3T9dsljXeosz+yAy5yR84EgznVHt0ebHoPFWriayn120s915b3HBTiwq5qPf8psAPhek+QIJ2rJl27SHgDBofEsL7rJfj/mOKK25wL9CaFm9GpUc44kJ4xmtn9EDrGD7jnCjqnTraUXU1b7RzTlA9KoTrgXqSjiE2xjWBZSSD6eKugChVwRaCNxJuNL8dQ33y8GLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6TMCltHfMbocGaPQh4NcXhyGMpXyc242kiPHPBCODY=;
 b=AyF/+PMcDiVsr2QMTUTnmj8HTFqEvbpKbnFK8xierIKIedXyxoxiOyZ0H+D9UDAZv0uEb7EKo9XR5iPzWaet4z5CHB6iG8c4EDJ3KkVR3o8KrmAEbVmBPp/0eE/lmbKma3MMy9tgKkwo0kaxYg8x05HMEu7Svb214GRvbnoHEQA+4ASa2GO2gJ3U5kKGDWgzBbdtwVpXqWxy38Qhip0OXH6FbJAN6F3R8oxPL4LrGMvSi1ubeJoTjZn/4QIVNL2PuvVY+jWXtSUnQI0IVaCrI+caDk9CGlVXoaEhRlNvvLM/5OxPOsxUjabLIzUcZxHsI45VVVE6h2SdgZo1+rumsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6TMCltHfMbocGaPQh4NcXhyGMpXyc242kiPHPBCODY=;
 b=MR+qVSfyejN1i9gG+mDHdnoUl5zu61a1ZcsV6bxB6ZLl/VdzKjvYz/JFq/NzM1OpG6rPpaPlmltVkv9LJwyQeUMQGmXo+pSZbEhBFBkYRQr0fV5942E/+Jbz5297ANE/zPnMsqaCYqUXFA1M0PLvasiXjrh7Lgvz1QSmo/l3jdo=
Received: from BY5PR03MB5110.namprd03.prod.outlook.com (52.133.251.202) by
 BY5PR03MB5362.namprd03.prod.outlook.com (10.186.132.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 08:25:24 +0000
Received: from BY5PR03MB5110.namprd03.prod.outlook.com
 ([fe80::3131:7c25:b35:ea7a]) by BY5PR03MB5110.namprd03.prod.outlook.com
 ([fe80::3131:7c25:b35:ea7a%7]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 08:25:24 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 2/2] iio: adis16480: Add debugfs_reg_access entry
Thread-Topic: [PATCH 2/2] iio: adis16480: Add debugfs_reg_access entry
Thread-Index: AQHVizIKq6cQNYfVPE+oBwVWvMUCMqdusx4AgAEJHwA=
Date:   Mon, 28 Oct 2019 08:25:24 +0000
Message-ID: <5a01de12c49f198d6d09b5e733225c6cc357f822.camel@analog.com>
References: <20191025124508.166648-1-nuno.sa@analog.com>
         <20191025124508.166648-2-nuno.sa@analog.com>
         <20191027163700.16d7d3f8@archlinux>
In-Reply-To: <20191027163700.16d7d3f8@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c247fc08-e32b-4494-c745-08d75b80617c
x-ms-traffictypediagnostic: BY5PR03MB5362:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR03MB53621C76EF159F555DC33F4299660@BY5PR03MB5362.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(366004)(376002)(189003)(199004)(4001150100001)(6486002)(3846002)(6246003)(6116002)(71200400001)(5024004)(14444005)(256004)(2351001)(71190400001)(76176011)(102836004)(26005)(229853002)(14454004)(486006)(2906002)(186003)(86362001)(11346002)(99286004)(446003)(7736002)(118296001)(305945005)(6506007)(2616005)(476003)(66946007)(5660300002)(4326008)(76116006)(66476007)(64756008)(36756003)(6436002)(66446008)(66556008)(5640700003)(66066001)(81156014)(81166006)(478600001)(8676002)(25786009)(8936002)(316002)(54906003)(2501003)(6512007)(91956017)(4744005)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5362;H:BY5PR03MB5110.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yWrehCQ5kCUZBJnrz0BSQAiEvalgIZI9RtCGCPorKsoJ7IBg8j1AF3ovKe2jIKTJfdAyny3iJEMDhyVHz4nucmmnZjCdl/SZmuawugt0PYW9PuHVA+cUrdxCps9INvAYkuyY/qwMa9KVKK50WDP3FiBo7w7/VRWV2bEOZjwRco233ToUFGE+TO+HuuKSkdQWey6zU2SSIZ0s+ckI0fQj6VIS+3zC5fjmHyJD8ERudc/90p60vVcO0dakGNjLJGv1cB4ZIynLakdPuW0W9Q9aGCwbPfRbNTufet6elTng6qPZzwTNm7N79ojLZg/XPXldQcON7/aZuo/zVyamW4P2ruET4EnXNUxzscOIN/rlxwanzuuCnvZ9LHcWFlNDWekCzs+cfpr5Oj9IwV/6FD83O/vD35nK7/DjO5UwXhdohzvAH7AnJAog8ilotrMyReGu
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBA60F379C252B488CB20EF881580635@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c247fc08-e32b-4494-c745-08d75b80617c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 08:25:24.3314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJqsKBRBMvjRBarnvb3MkAGUMz6vLQ/RBHm4RVozyDE9QRJ6AJbGuYV671gsSw36FOXR4eXSICuCnxKBIB/YDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5362
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_04:2019-10-25,2019-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=981 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910280085
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTI3IGF0IDE2OjM3ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksIDI1IE9jdCAyMDE5IDE0OjQ1OjA4ICswMjAwDQo+IE51bm8gU8OhIDxudW5v
LnNhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGUgZHJpdmVyIGlzIGRlZmluaW5nIGRl
YnVnZnMgZW50cmllcyBieSBjYWxsaW5nDQo+ID4gYGFkaXMxNjQ4MF9kZWJ1Z2ZzX2luaXQoKWAu
IEhvd2V2ZXIsIHRob3NlIGVudHJpZXMgYXJlIGF0dGFjaGVkIHRvDQo+ID4gdGhlDQo+ID4gaWlv
X2RldiBkZWJ1Z2ZzIGVudHJ5IHdoaWNoIHdvbid0IGV4aXN0IGlmIG5vIGRlYnVnZnNfcmVnX2Fj
Y2Vzcw0KPiA+IGNhbGxiYWNrIGlzIHByb3ZpZGVkLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+DQo+IEFzIHlvdSBhcmUgcmVzcGlubmluZyB0
aGUgZmlyc3Qgb25lIGFuZCB0aGlzIGlzIHByb2JhYmx5IHN0YWJsZQ0KPiBtYXRlcmlhbCBhcyB3
ZWxsLCBwbGVhc2UgYWRkIGEgZml4ZXMgdGFnIGZvciB2Mi4NCj4gVGhhbmtzLA0KPiANCg0KV2ls
bCBkbyB0aGF0LiBTaG91bGQgSSBhbHNvIGNjIFN0YWJsZT8NCg0KVGhhbmtzIQ0KTnVubyBTw6EN
Cg==
