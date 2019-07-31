Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AEF7D03E
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 23:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfGaVsR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 17:48:17 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42439 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727865AbfGaVsR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 17:48:17 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VLknMg011520;
        Wed, 31 Jul 2019 23:48:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=XiLu8PvYEYtjdYxkcwWuO2N2P1FAjMr1OX257WPAzFw=;
 b=BYzl8DbH1Fu5litdFCHPJFVtCCR3MB9oUvbF8lpXvn+HgymF1hv34e1aEw722aFF8aZy
 kXiWr7ndYvYrWEs0sU9ifDlL2binV4YaJTflMMai1oYhiu6qfYi091i/m1jnpf26AdnM
 hRx+QzA3pZ/ulkeh4Xu5B2x52qOz4XNO5fye+iD0pe/b/Bde3ac14Y9UkWHrb+nmsZGl
 A5n/mZ0TfV/8YR3sSSt7F/2bDen2KIwE0ZyZ3VN17gVFouzQOra5eMN2H4ep+v1vg70A
 xIkp777FXoaZbHkLdemU812nhRjdzgrlR2wJtf9EDxbPeOz0aSlHHipVD2d4LhHJMPpx JA== 
Received: from eur02-am5-obe.outbound.protection.outlook.com (mail-am5eur02lp2051.outbound.protection.outlook.com [104.47.4.51])
        by mx07-00178001.pphosted.com with ESMTP id 2u0ccwtcdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Jul 2019 23:48:06 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnlbPkVEIiQotoM8+0+FPuNZ5Z5IJZzmGHvK/2RspgCOIfiuyjf9b6ZLcZW5iEUDzhHojHzuHAZ1KGgqcXxDRbKvQyxudheQH9r/Sqas8fB/NZ+DnMgPN4DzW6XX8ocHvjr78f4oo4JCyKRkXjrp7YtqUMjdcFwk5+sp46RmlbhvZdqaGAawnT2bpUKl70jieZ/7m7tZVCMvlCDwiyxrGkgPv/1+pfmTWlybAy0aj+kXgOYGxXuM42zgjFv7MKvxpf8RKsnyxkL8xsrlhXoO5oBaxeHEWmsY2bQy3312sviRXhbWBatkCYxM1LVfe7EY5KBJjX/c2EV2e7bMSnxuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiLu8PvYEYtjdYxkcwWuO2N2P1FAjMr1OX257WPAzFw=;
 b=iueBucMvWfiaF+ApD1z/sXkE/xyCRcoRDGDVuprJcoWeu2bEtM8Acl4RocmtD9tsKqSxUCZMwA1DMB6WaDrfHV7XWZKGvblW4LtLJld+7yUdEMq0HfFa4GZk4OpxEcc3Wk04qpZbZzQdhzIkLw6l8gA2WI5160a5vpyXwK3qxQQguv7rCqMJtEyaPxM7dg1l+OKmH/DLMHFSv2wm/Cc5TIRdf/NmXGyy4Us+NbkoDg+j33CKkNgw9EaK9gGX7EZOChumeGzlen7lIwN6+8oN1tI1HNAb0b7UHGxIya9wYVQe4jmT84p+8xLvOPOGzTz8Xtdnv+mB78TWmhoMGnEmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=st.com;dmarc=pass action=none header.from=st.com;dkim=pass
 header.d=st.com;arc=none
Received: from AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM (10.255.28.79) by
 AM0SPR01MB21.EURPRD10.PROD.OUTLOOK.COM (52.134.87.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 31 Jul 2019 21:48:04 +0000
Received: from AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d1b5:b9a3:30f6:c95b]) by AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d1b5:b9a3:30f6:c95b%6]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 21:48:04 +0000
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 4/4] iio:pressure: preenable/postenable/predisable fixup
 for ST press buffer
Thread-Topic: [PATCH 4/4] iio:pressure: preenable/postenable/predisable fixup
 for ST press buffer
Thread-Index: AQHVRmtQH5lKzSvTyU+qKfPA7gGdKabi3iYAgABz4bCAAPvmAIAA+DDw
Date:   Wed, 31 Jul 2019 21:48:04 +0000
Message-ID: <AM0PR10MB2897A0170291B681EA3B9B32EDDF0@AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM>
References: <20190730000305.30958-1-denis.ciocca@st.com>
         <20190730000305.30958-5-denis.ciocca@st.com>
         <c73657b4203d8112636751413c85f525f57dcc2a.camel@analog.com>
         <VE1PR10MB291275F4B3C439A1B86F8579EDDC0@VE1PR10MB2912.EURPRD10.PROD.OUTLOOK.COM>
 <2e2683cd5cbee9b8157d3c49ae674f5b48cb3a4c.camel@analog.com>
In-Reply-To: <2e2683cd5cbee9b8157d3c49ae674f5b48cb3a4c.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.34.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3550d3d0-1a33-4dd6-3c17-08d71600c480
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0SPR01MB21;
x-ms-traffictypediagnostic: AM0SPR01MB21:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0SPR01MB21C1BCF49D57441268B2E4EDDF0@AM0SPR01MB21.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(13464003)(2201001)(6246003)(2501003)(8936002)(476003)(486006)(66476007)(7736002)(305945005)(64756008)(66556008)(66446008)(74316002)(71200400001)(71190400001)(68736007)(256004)(14444005)(5024004)(86362001)(81156014)(66946007)(52536014)(5660300002)(76116006)(81166006)(8676002)(53546011)(6506007)(33656002)(110136005)(316002)(76176011)(3846002)(2906002)(14454004)(966005)(6116002)(25786009)(26005)(7696005)(186003)(55236004)(102836004)(66066001)(11346002)(6436002)(446003)(229853002)(99286004)(9686003)(478600001)(53936002)(55016002)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB21;H:AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: st.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y/BFRGW5VcyQfjaZiuWtErdXhxn1xjrQO5CyYDNXxUb2ZYrKAWbUiTwpev5Y+JeZeFinTw/uTQCARY6jDtPnPsnqy/FOtRyFjBwhbzQqRGtInunn7/YxewdHRAPSQUK13ftdKUV/8lEGZSeIaar2wiFWrfUDjTqKvbBW1s5AKy/Cbdafh2sakKTa7zze675JkZ8MxSdcec8D+w593MXzkdJyddg/lJMhOlEjDVutA5UnD9s/KDMLJ+Z9MAdJaaYfd97pReAqgs6od6zZgfUAyQ1qsi8HjhAWqh+dbIQgPFe/UOc3IM/f7Y6yQsXriqmAUxheyR8a1VTS8x2G69w2eWdTxb7xOE+rl6tshbJeYm4NzXFm4gM30wEuxM5RxDbXzTOHWh+vnWztcNiE2CwQFlOR5GjruC0MGPdS8VrHkPo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3550d3d0-1a33-4dd6-3c17-08d71600c480
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 21:48:04.7204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: denis.ciocca@st.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB21
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310218
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcmRlbGVhbiwgQWxleGFuZHJ1
IDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVseSAz
MCwgMjAxOSAxMTo1OSBQTQ0KPiBUbzogamljMjNAa2VybmVsLm9yZzsgRGVuaXMgQ0lPQ0NBIDxk
ZW5pcy5jaW9jY2FAc3QuY29tPjsgbGludXgtDQo+IGlpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCA0LzRdIGlpbzpwcmVzc3VyZTogcHJlZW5hYmxlL3Bvc3RlbmFibGUv
cHJlZGlzYWJsZQ0KPiBmaXh1cCBmb3IgU1QgcHJlc3MgYnVmZmVyDQo+IA0KPiBPbiBUdWUsIDIw
MTktMDctMzAgYXQgMTY6MDggKzAwMDAsIERlbmlzIENJT0NDQSB3cm90ZToNCj4gPiBbRXh0ZXJu
YWxdDQo+ID4NCj4gPiBIaSBBbGV4YW5kcnUsDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBBcmRlbGVhbiwgQWxleGFuZHJ1IDxhbGV4YW5kcnUuQXJk
ZWxlYW5AYW5hbG9nLmNvbT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMzAsIDIwMTkgMjow
MiBBTQ0KPiA+ID4gVG86IGppYzIzQGtlcm5lbC5vcmc7IERlbmlzIENJT0NDQSA8ZGVuaXMuY2lv
Y2NhQHN0LmNvbT47IGxpbnV4LQ0KPiA+ID4gaWlvQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSCA0LzRdIGlpbzpwcmVzc3VyZToNCj4gPiA+IHByZWVuYWJsZS9wb3N0
ZW5hYmxlL3ByZWRpc2FibGUgZml4dXAgZm9yIFNUIHByZXNzIGJ1ZmZlcg0KPiA+ID4NCj4gPiA+
IE9uIE1vbiwgMjAxOS0wNy0yOSBhdCAxNzowMyAtMDcwMCwgRGVuaXMgQ2lvY2NhIHdyb3RlOg0K
PiA+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgcGF0Y2ggaXMgdHJ5aW5n
IHRvIGNsZWFudXAgZm9yIGdvb2QgdGhlIGJ1ZmZlcnMgb3BlcmF0aW9uIGZ1bmN0aW9ucy4NCj4g
PiA+ID4gVGhlcmUgaXMgbm8gbmVlZCBvZiB1c2luZyBwcmVlbmFibGUsIGFsbCBjYW4gYmUgZG9u
ZSBpbnRvIHBvc3RlbmFibGUuDQo+ID4gPiA+IExldCdzIGFsc28gdXNlIGxvZ2ljYWwgc2VxdWVu
Y2Ugb2Ygb3BlcmF0aW9ucyBhcyBhbHJlYWR5IGRvbmUgaW4NCj4gPiA+ID4gYWNjZWwgZHJpdmVy
Lg0KPiA+ID4gPiBGaW5hbGx5IGFsc28gcmVuYW1lIHRoZSBnb3RvIGxhYmVsIHVzaW5nIG9wZXJh
dGlvbiB0byBwZXJmb3JtIGFuZA0KPiA+ID4gPiBub3Qgd2hlcmUgaXQgZmFpbHMuDQo+ID4gPiA+
DQo+ID4gPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1
LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gPg0KPiA+ID4NCj4gPiA+IFVucmVsYXRlZCB0byB0
aGlzIHBhdGNoLCBJIHdhcyB0aGlua2luZyB0aGF0IGl0IHdvdWxkIGJlIGEgbmVhdCBpZGVhDQo+
ID4gPiB0byBtb3ZlIHRoZSBgYnVmZmVyX2RhdGFgIGFsbG9jYXRpb24gaW4NCj4gPiA+IGBkcml2
ZXJzL2lpby9jb21tb24vc3Rfc2Vuc29ycy9zdF9zZW5zb3JzX2J1ZmZlci5jYA0KPiA+ID4NCj4g
PiA+IFRoaXMgd291bGQgcmVtb3ZlIHNvbWUgZHVwbGljYXRpb24gb2YgdGhpcyBhbGxvYyArIGZy
ZWUgaW4gZHJpdmVycy4NCj4gPiA+DQo+ID4gPiBNYXliZSBpbiBzdF9zZW5zb3JzX3RyaWdnZXJf
aGFuZGxlcigpIHNvbWV0aGluZyBsaWtlOg0KPiA+ID4NCj4gPiA+IGlmICghc2RhdGEtPmJ1ZmZl
cl9kYXRhKSB7DQo+ID4gPiAgICAgc2RhdGEtPmJ1ZmZlcl9kYXRhID0gZGV2bV9rbWFsbG9jKCkN
Cj4gPiA+ICAgICBpZiAoIXNkYXRhLT5idWZmZXJfZGF0YSkgew0KPiA+ID4gICAgICAgICBkZXZf
ZXJyKGluZGlvX2Rldi0+ZGV2LCAiRmFpbGVkIHRvIGFsbG9jYXRlIGJ1ZmZlciBkYXRhXG4iKTsN
Cj4gPiA+ICAgICAgICAgZ290byBzdF9zZW5zb3JzX2dldF9idWZmZXJfZWxlbWVudF9lcnJvcjsN
Cj4gPiA+ICAgICB9DQo+ID4gPiB9DQo+ID4gPg0KPiA+ID4gVXNpbmcgZGV2bV9rbWFsbG9jKCkg
b3IgYSBzaW1pbGFyIGRldm1fIHZhcmlhbnQgd291bGQgYmUgbmVhdCwgc2luY2UNCj4gPiA+IGl0
IGdldHMgZnJlZSdkIHdoZW4gdGhlIGRldmljZSBnZXRzIHJlbW92ZWQuDQo+ID4NCj4gPiBOb3Qg
c3VyZSBhYm91dCB0aGUgc29sdXRpb24gcHJvcG9zZWQuDQo+ID4gTWVtb3J5IGFsbG9jYXRpb24g
aXMgYWN0dWFsbHkgcmVsYXRlZCB0byBob3cgbWFueSBjaGFubmVscyBhcmUNCj4gPiBlbmFibGVk
LCBvbmUgcG9zc2liaWxpdHkgY291bGQgYmUgdG8gYWxsb2NhdGUgdGhlIG1heGltdW0gYnV0IG5v
dCBzdXJlIGl0J3MNCj4gd29ydGguLi4NCj4gPiBNb3Jlb3ZlciB0aGUgbWVtb3J5IGFsbG9jYXRp
b24gdGhlcmUgY291bGQgbGV0IGRyaXZlciBtaXNzIHRoZSBmaXJzdA0KPiBzYW1wbGUgSSBndWVz
cy4NCj4gPg0KPiANCj4gSSBzZWUuDQo+IFdvdWxkIFt0aGVuXSBtb3ZpbmcgdGhlIGFsbG9jYXRp
b24gaW4gcHJlZW5hYmxlIHdvcms/IGFuZCB0aGUgZnJlZSBpbg0KPiBwb3N0ZGlzYWJsZT8NCg0K
WWVhaCwgSSB0aGluayB3aWxsIHdvcmsganVzdCBmaW5lLiBJJ3ZlIHRlc3RlZCBhIHByZWxpbWlu
YXJ5IHZlcnNpb24sIEknbGwgc2hhcmUgc29vbi4NCg0KDQoNCj4gDQo+IFRoaW5nIGlzOiB3aGVu
IGlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3RlbmFibGUoKSBhbmQNCj4gaWlvX3RyaWdnZXJlZF9i
dWZmZXJfcHJlZGlzYWJsZSgpIGdldCByZW1vdmVkIChhbmQgbG9naWMgbW92ZWQgaW50byBjb3Jl
KSwNCj4gdGhlbiB0aGUgb3JkZXIgY2hhbmdlcywgYW5kIHRoZSBhdHRhY2ggcG9sbGZ1bmMgZ2V0
cyBjYWxsZWQgYmVmb3JlIHRoZQ0KPiBhbGxvY2F0aW9uLg0KPiANCj4gDQo+IFRoZSBmaW5hbCBk
ZXN0aW5hdGlvbiBmb3IgdGhlc2UgY2hhbmdlcyBpcyB0aGlzIGNvbW1pdDoNCj4gaHR0cHM6Ly9n
aXRodWIuY29tL2FuYWxvZ2RldmljZXNpbmMvbGludXgvY29tbWl0L2VlZTk3ZDEyNjY1ZmVmOGMj
ZGlmZi0NCj4gMGE4Nzc0NGNlOTQ1ZDJjMWM4OWVhMTlmMjFmYjM1YmJSNzIyDQo+IFt0aGlzIGFu
IG9sZGVyIGZvcm1dDQo+IEluIHRoaXMgY29tbWl0LCB0aGUgYXR0YWNoL2RldGFjaCBvZiB0aGUg
cG9sbF9mdW5jIGlzIG1vdmVkIGludG8gY29yZSwgc2luY2UNCj4gdGhhdCBpcyBhbGwgdGhhdCB0
aGUgMiBmdW5jdGlvbnMgZG8NCj4gKGlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3RlbmFibGUoKSBh
bmQgaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZSgpKQ0KPiANCj4gV2hlbiB0aGUgbW92
ZSBoYXBwZW5zIFtmb3IgdGhlIFNUIGRyaXZlcnMgaW4gcGFydGljdWxhcl0gdGhlIHBvbGxfZnVu
YyBpcw0KPiBhdHRhY2hlZCwgYW5kIHRoZW4gdGhlIGFsbG9jYXRpb24gaXMgZG9uZSwgYW5kIHRo
ZSBmcmVlIGlzIGRvbmUgZmlyc3QsIGFuZCB0aGVuDQo+IHRoZSBwb2xsX2Z1bmMgaXMgZGV0YWNo
ZWQuDQo+IA0KPiANCj4gPg0KPiA+ID4gVGhhbmtzDQo+ID4gPiBBbGV4DQo+ID4gPg0KPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBDaW9jY2EgPGRlbmlzLmNpb2NjYUBzdC5jb20+DQo+ID4g
PiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9paW8vcHJlc3N1cmUvc3RfcHJlc3N1cmVfYnVmZmVy
LmMgfCAzMg0KPiA+ID4gPiArKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vcHJlc3N1cmUvc3RfcHJlc3N1cmVfYnVmZmVy
LmMNCj4gPiA+ID4gYi9kcml2ZXJzL2lpby9wcmVzc3VyZS9zdF9wcmVzc3VyZV9idWZmZXIuYw0K
PiA+ID4gPiBpbmRleCBmMjFiNjMwYWJhYTAuLjU0ODIzY2ZjZmFiNSAxMDA2NDQNCj4gPiA+ID4g
LS0tIGEvZHJpdmVycy9paW8vcHJlc3N1cmUvc3RfcHJlc3N1cmVfYnVmZmVyLmMNCj4gPiA+ID4g
KysrIGIvZHJpdmVycy9paW8vcHJlc3N1cmUvc3RfcHJlc3N1cmVfYnVmZmVyLmMNCj4gPiA+ID4g
QEAgLTI5LDUzICsyOSw0MyBAQCBpbnQgc3RfcHJlc3NfdHJpZ19zZXRfc3RhdGUoc3RydWN0IGlp
b190cmlnZ2VyDQo+ID4gPiA+ICp0cmlnLA0KPiA+ID4gYm9vbCBzdGF0ZSkNCj4gPiA+ID4gIAly
ZXR1cm4gc3Rfc2Vuc29yc19zZXRfZGF0YXJlYWR5X2lycShpbmRpb19kZXYsIHN0YXRlKTsgIH0N
Cj4gPiA+ID4NCj4gPiA+ID4gLXN0YXRpYyBpbnQgc3RfcHJlc3NfYnVmZmVyX3ByZWVuYWJsZShz
dHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KSAtew0KPiA+ID4gPiAtCXJldHVybiBzdF9zZW5zb3Jz
X3NldF9lbmFibGUoaW5kaW9fZGV2LCB0cnVlKTsNCj4gPiA+ID4gLX0NCj4gPiA+ID4gLQ0KPiA+
ID4gPiAgc3RhdGljIGludCBzdF9wcmVzc19idWZmZXJfcG9zdGVuYWJsZShzdHJ1Y3QgaWlvX2Rl
diAqaW5kaW9fZGV2KSAgew0KPiA+ID4gPiAtCWludCBlcnI7DQo+ID4gPiA+ICAJc3RydWN0IHN0
X3NlbnNvcl9kYXRhICpwcmVzc19kYXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiA+ID4g
KwlpbnQgZXJyOw0KPiA+ID4gPg0KPiA+ID4gPiAgCXByZXNzX2RhdGEtPmJ1ZmZlcl9kYXRhID0g
a21hbGxvYyhpbmRpb19kZXYtPnNjYW5fYnl0ZXMsDQo+ID4gPiA+ICAJCQkJCSAgR0ZQX0RNQSB8
IEdGUF9LRVJORUwpOw0KPiA+ID4gPiAtCWlmIChwcmVzc19kYXRhLT5idWZmZXJfZGF0YSA9PSBO
VUxMKSB7DQo+ID4gPiA+IC0JCWVyciA9IC1FTk9NRU07DQo+ID4gPiA+IC0JCWdvdG8gYWxsb2Nh
dGVfbWVtb3J5X2Vycm9yOw0KPiA+ID4gPiAtCX0NCj4gPiA+ID4gKwlpZiAoIXByZXNzX2RhdGEt
PmJ1ZmZlcl9kYXRhKQ0KPiA+ID4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiA+ID4NCj4gPiA+
ID4gIAllcnIgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wb3N0ZW5hYmxlKGluZGlvX2Rldik7DQo+
ID4gPiA+ICAJaWYgKGVyciA8IDApDQo+ID4gPiA+IC0JCWdvdG8gc3RfcHJlc3NfYnVmZmVyX3Bv
c3RlbmFibGVfZXJyb3I7DQo+ID4gPiA+ICsJCWdvdG8gc3RfcHJlc3NfZnJlZV9idWZmZXI7DQo+
ID4gPiA+DQo+ID4gPiA+IC0JcmV0dXJuIGVycjsNCj4gPiA+ID4gKwlyZXR1cm4gc3Rfc2Vuc29y
c19zZXRfZW5hYmxlKGluZGlvX2RldiwgdHJ1ZSk7DQo+ID4gPiA+DQo+ID4gPiA+IC1zdF9wcmVz
c19idWZmZXJfcG9zdGVuYWJsZV9lcnJvcjoNCj4gPiA+ID4gK3N0X3ByZXNzX2ZyZWVfYnVmZmVy
Og0KPiA+ID4gPiAgCWtmcmVlKHByZXNzX2RhdGEtPmJ1ZmZlcl9kYXRhKTsNCj4gPiA+ID4gLWFs
bG9jYXRlX21lbW9yeV9lcnJvcjoNCj4gPiA+ID4gIAlyZXR1cm4gZXJyOw0KPiA+ID4gPiAgfQ0K
PiA+ID4gPg0KPiA+ID4gPiAgc3RhdGljIGludCBzdF9wcmVzc19idWZmZXJfcHJlZGlzYWJsZShz
dHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ID4gPiB7DQo+ID4gPiA+IC0JaW50IGVycjsN
Cj4gPiA+ID4gIAlzdHJ1Y3Qgc3Rfc2Vuc29yX2RhdGEgKnByZXNzX2RhdGEgPSBpaW9fcHJpdihp
bmRpb19kZXYpOw0KPiA+ID4gPiAtDQo+ID4gPiA+IC0JZXJyID0gaWlvX3RyaWdnZXJlZF9idWZm
ZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiA+ID4gPiAtCWlmIChlcnIgPCAwKQ0KPiA+ID4g
PiAtCQlnb3RvIHN0X3ByZXNzX2J1ZmZlcl9wcmVkaXNhYmxlX2Vycm9yOw0KPiA+ID4gPiArCWlu
dCBlcnIsIGVycjI7DQo+ID4gPiA+DQo+ID4gPiA+ICAJZXJyID0gc3Rfc2Vuc29yc19zZXRfZW5h
YmxlKGluZGlvX2RldiwgZmFsc2UpOw0KPiA+ID4gPg0KPiA+ID4gPiAtc3RfcHJlc3NfYnVmZmVy
X3ByZWRpc2FibGVfZXJyb3I6DQo+ID4gPiA+ICsJZXJyMiA9IGlpb190cmlnZ2VyZWRfYnVmZmVy
X3ByZWRpc2FibGUoaW5kaW9fZGV2KTsNCj4gPiA+ID4gKwlpZiAoIWVycikNCj4gPiA+ID4gKwkJ
ZXJyID0gZXJyMjsNCj4gPiA+ID4gKw0KPiA+ID4gPiAgCWtmcmVlKHByZXNzX2RhdGEtPmJ1ZmZl
cl9kYXRhKTsNCj4gPiA+ID4gIAlyZXR1cm4gZXJyOw0KPiA+ID4gPiAgfQ0KPiA+ID4gPg0KPiA+
ID4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fYnVmZmVyX3NldHVwX29wcyBzdF9wcmVzc19i
dWZmZXJfc2V0dXBfb3BzID0NCj4gew0KPiA+ID4gPiAtCS5wcmVlbmFibGUgPSAmc3RfcHJlc3Nf
YnVmZmVyX3ByZWVuYWJsZSwNCj4gPiA+ID4gIAkucG9zdGVuYWJsZSA9ICZzdF9wcmVzc19idWZm
ZXJfcG9zdGVuYWJsZSwNCj4gPiA+ID4gIAkucHJlZGlzYWJsZSA9ICZzdF9wcmVzc19idWZmZXJf
cHJlZGlzYWJsZSwgIH07DQo=
