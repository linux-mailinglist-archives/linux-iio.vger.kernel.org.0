Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 600FB19C59A
	for <lists+linux-iio@lfdr.de>; Thu,  2 Apr 2020 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbgDBPNe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Apr 2020 11:13:34 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7406 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388853AbgDBPNe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Apr 2020 11:13:34 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032EQxWC002950;
        Thu, 2 Apr 2020 11:13:14 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-00128a01.pphosted.com with ESMTP id 3023g5g5gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 11:13:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Se8UPTr0wegpwmcMXE0Ngc4Q5DWGLVSf7X5yWBkWTUtHQX031Bu3t04jPV6xE0sFnaHTuZz4e9baerq1gsgTICO3D0Ziw4kF4kGxKpS4JQQEPkwlnNRguk1mN1o8IVGVJ2rbXqivMVHwBUU6EtGgHLHlh+ZYXMWmqOIMRMom7WlGAfqSXlA9+o8YBAzUsfwhAwzOISAQ0mKy0W7/y8jB883q/sXDfmDoUO1g2jIt4cWBAMVCvlgJG+24a5BoiOSGiOYhaq1H+CndNmsGtogS4+2pyT98oE/abGl9t9H0ZFGe3ZqpFHXRms+/KfE8EJ7au/eM4UsBy3oe1I0JV4EVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sloOhtmolarg7OV+vf5r+b7jyJextdtG8HYMOto6XHU=;
 b=PwhEIbwQVCmFIzs/5WYJ3tNOkYUV5cZJ7plmxFDQV+FwdFdT3tONw3ImCsQNoidDSaO6zYm9rHvgmpZxauzGznQHLEhV8v7W8XkZ+J+RoupWZrdYTAdwc+6+93T2PPSj0cJNEb13Z7Z29YBsRfOehxswIbagBflgZBzjBa23h/SQpZIfgFm05/8c/fEfaVreN/RPicn3n2ovoeVAzjo5Xm0lcp9kYNjO3j8oiibBHSDT4BXNVh8a/BB6oZfh2hwQ24JFph9Vw3BzgipiqaoklD7ajj7QYnTQMLRkZTbqN0Pv+3vQ4aXr13AVWs0yyFwhlQiw6qiTS6VK/oTgJs3S6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sloOhtmolarg7OV+vf5r+b7jyJextdtG8HYMOto6XHU=;
 b=otGwNlRqdAhEzJw0eewBawFFs+SNeEItBiC96tiuKiyV0W/EJ0JynXmzLDnn4aRSBZXVz8kqWM4i/qeyF3JilbcT+UbWIH0RlslYVTPZpCHTsFXqa5aOa9qIAUhxFeYIklV0GbqEqxdBLPC/LaJrAO6urjsUAgwRm6+DkZjlzpI=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4923.namprd03.prod.outlook.com (2603:10b6:5:1e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 2 Apr
 2020 15:13:12 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 15:13:12 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h
 includes
Thread-Topic: [PATCH v2] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h
 includes
Thread-Index: AQHWCEay+FCTQHziLE2p+h4lxc99/ahl8eSA
Date:   Thu, 2 Apr 2020 15:13:12 +0000
Message-ID: <490a1fe0296f3ea92c0419c2887cb02b615af572.camel@analog.com>
References: <20200401165706.30416-1-lars@metafoo.de>
In-Reply-To: <20200401165706.30416-1-lars@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f7e6d1a-8bec-4eaa-c489-08d7d7185c53
x-ms-traffictypediagnostic: DM6PR03MB4923:
x-microsoft-antispam-prvs: <DM6PR03MB4923D1F007EFF6BF75DF4A5DF9C60@DM6PR03MB4923.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(376002)(366004)(346002)(396003)(39860400002)(136003)(81166006)(66446008)(81156014)(6506007)(2906002)(478600001)(5660300002)(54906003)(76116006)(316002)(6512007)(66476007)(66946007)(110136005)(4326008)(2616005)(36756003)(71200400001)(91956017)(66556008)(86362001)(8676002)(8936002)(6486002)(186003)(64756008)(26005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YX5ofizKUpZxD3ybJs7fvym80I4FBhQ+x02UMZfardST2kuyLIndVcCetf0YV73Auy2Umok+F5mzvFKFcRg0qb35WuTPDvTr8D/mZ9FwQs/+nPRZUcoD8AwTe3BFObu3HETPQx+NwPIiQRAW4/fvQAhJ1g3nFjgVayjL6SfrAP6NLQqPaiivgP1LeSXTmwbakuFFzcBHQWMAs0HkEYdyLIKQ75LDq9XSZMQxF3vOrH7s4nQNM478oyHvAk/6p/9GGuAJGxnVl0Ofd6INNQosO+mt7piilj9KxhVzggmCUCz5gcynrSMdLoMm+fdCrORSTX0/yBbW9hMbDPJxn+D/jSlTjskd0XGo5v86SGds2oPA34YuPUGNA5Zg5ZRMzy7lay1tnZ4jdXO2gkXUUIhmrur7G9xr1SPv+DpjxdxxtjU+BjOq7ld3hXUjlvnskA61
x-ms-exchange-antispam-messagedata: AttbWLWh9uHO5XmWimyTzKsKnmcurxTDGNHLnWb01+l9sCrgoGAiFbHwW4RdXVET8j0FH8I9rcb7/AB+sCcIBTl+V+th123iJuhEdLBKhVLv0b/k1el9/7F/QzgeHm728HdinWKgid0OrRBvDSMe4A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <61EF4B44A6F2C24A97EF09EC67B71CCE@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7e6d1a-8bec-4eaa-c489-08d7d7185c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 15:13:12.3815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHxPm+Ng8XVLVqmkNIkAcWsIYAD3m/+vkj2pNX03bRetMuFBlW68LDnUa9COQoQ7SbQ80tJms/BnM9GAaOsLXrC9sBA8dY+xzOMPl3djwHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4923
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_05:2020-04-02,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004020131
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTAxIGF0IDE4OjU3ICswMjAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IFRoZSBJSU8gRE1BIGJ1ZmZlciBpcyBhIERNQSBidWZm
ZXIgaW1wbGVtZW50YXRpb24uIEFzIHN1Y2ggaXQgc2hvdWxkDQo+IGluY2x1ZGUgYnVmZmVyX2lt
cGwuaCByYXRoZXIgdGhhbiBidWZmZXIuaC4NCj4gDQo+IFRoZSBpbmNsdWRlIHRvIGJ1ZmZlci5o
IGluIGJ1ZmZlci1kbWEuaCBzaG91bGQgYmUgYnVmZmVyX2ltcGwuaCBzbyBpdCBoYXMNCj4gYWNj
ZXNzIHRvIHRoZSBzdHJ1Y3QgaWlvX2J1ZmZlciBkZWZpbml0aW9uLiBUaGUgY29kZSBjdXJyZW50
bHkgb25seSB3b3Jrcw0KPiBiZWNhdXNlIGFsbCBwbGFjZXMgdGhhdCB1c2UgYnVmZmVyLWRtYS5o
IGluY2x1ZGUgYnVmZmVyX2ltcGwuaCBiZWZvcmUgaXQuDQo+IA0KPiBUaGUgaW5jbHVkZSB0byBi
dWZmZXIuaCBpbiBpbmR1c3RyaWFsaW8tYnVmZmVyLWRtYS5jICBjYW4gYmUgcmVtb3ZlZCBzaW5j
ZQ0KPiB0aG9zZSBmaWxlIGRvZXMgbm90IHJlZmVyZW5jZSBhbnkgb2YgYnVmZmVyIGNvbnN1bWVy
IGZ1bmN0aW9ucy4NCj4gDQoNClRlc3RlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5k
cnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBMYXJzLVBldGVyIENs
YXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgdjE6DQo+IAkq
IERvbid0IHJlbW92ZSBidWZmZXIuaCBpbmNsdWRlIGluIGJ1ZmZlci1kbWEuaCBzaW5jZSBpdCBp
cyBuZWVkZWQNCj4gCSAgYWZ0ZXIgYWxsLg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2J1ZmZlci9p
bmR1c3RyaWFsaW8tYnVmZmVyLWRtYS5jIHwgMSAtDQo+ICBpbmNsdWRlL2xpbnV4L2lpby9idWZm
ZXItZG1hLmggICAgICAgICAgICAgICB8IDIgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8v
YnVmZmVyL2luZHVzdHJpYWxpby1idWZmZXItZG1hLmMNCj4gYi9kcml2ZXJzL2lpby9idWZmZXIv
aW5kdXN0cmlhbGlvLWJ1ZmZlci1kbWEuYw0KPiBpbmRleCBhNzRiZDljMDU4N2MuLmQzNDhhZjhi
OTcwNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYnVmZmVyL2luZHVzdHJpYWxpby1idWZm
ZXItZG1hLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYnVmZmVyL2luZHVzdHJpYWxpby1idWZmZXIt
ZG1hLmMNCj4gQEAgLTEyLDcgKzEyLDYgQEANCj4gICNpbmNsdWRlIDxsaW51eC9tdXRleC5oPg0K
PiAgI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcG9sbC5oPg0K
PiAtI2luY2x1ZGUgPGxpbnV4L2lpby9idWZmZXIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9paW8v
YnVmZmVyX2ltcGwuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9paW8vYnVmZmVyLWRtYS5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L2lpby9idWZmZXItZG1hLmggYi9pbmNsdWRlL2xpbnV4L2lpby9idWZmZXItZG1hLmgNCj4g
aW5kZXggMDE2ZDhhMDY4MzUzLi5mZjE1YzYxYmYzMTkgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
bGludXgvaWlvL2J1ZmZlci1kbWEuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2lpby9idWZmZXIt
ZG1hLmgNCj4gQEAgLTExLDcgKzExLDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9rcmVmLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tdXRleC5o
Pg0KPiAtI2luY2x1ZGUgPGxpbnV4L2lpby9idWZmZXIuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9p
aW8vYnVmZmVyX2ltcGwuaD4NCj4gIA0KPiAgc3RydWN0IGlpb19kbWFfYnVmZmVyX3F1ZXVlOw0K
PiAgc3RydWN0IGlpb19kbWFfYnVmZmVyX29wczsNCg==
