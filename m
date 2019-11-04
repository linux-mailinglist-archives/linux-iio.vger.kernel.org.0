Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9D2EE35B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfKDPQ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:16:26 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:52324 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbfKDPQ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:16:26 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4F9wXe003990;
        Mon, 4 Nov 2019 10:16:17 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a9yhr4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:16:16 -0500
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4FFVAB008901;
        Mon, 4 Nov 2019 10:16:16 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2059.outbound.protection.outlook.com [104.47.44.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a9yhr4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:16:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/PNiRNgd7j+2rp6Lyq41oF5pm1TqbLSomDV9LPq/ZO7CRh+CGM1SNZ66QQ9cJkePQZBM4qvYzKWiWMVfYrT/nNCDIbZz2gFMxI2oehzpg1bkIueAJ6BOtl+sdx02cBOfLBygkwPkmMK1h3xactFBYLTRkqgsnmstMz2XRHNvNTIqE0iT3cSsL0Qj9zpPNJ8OVeowJ5f9oj2oc3ELq5SUI31054aMQj6SyA3hpzfVI36sJiIfLS/QLg5kbkgqc2naak8BReDNfaoqz2INyoLLbCPjY+eIkeyhMcO6EreTIPrc0P+I1gqG6KxvVqycmn+VkDN4nrCUqgdP8x+MY5Z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJjHGv3S/RES1zMsZMj8ni9UEcW6PvgKjJsie08pUmo=;
 b=K1WMzORxOauhtbifsQ/X2smOsukH1E2l2+wwJ8jB1eysXGw2OevRzQS2vLYVmV7a2yYtMb89pVkS4mXk8U7uwDXo26K9CGWbEGAkRzmwIkw/MlLzR4XMcmB98v/YFVDlsUPRvI3qmZDD+ALFAkVJiSruM4gJnUwkwbLVamf+VIv3hoKK52CURz3yy6NyUN+kK82VTGb59VSsmCJ2vaikXV1P29yYrtpSVRd4V0ZE3UlYxcTA8zjdQEtoKMHWfWn5TwLtgv8ogVZi0Tt9RLdjo8URX1YTCATSgEGgeiAxjy5omcNz0/AvWY2Q0iXiVGDphMaV+q0ihZeVpEEEDEDIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJjHGv3S/RES1zMsZMj8ni9UEcW6PvgKjJsie08pUmo=;
 b=j/BYiseC9+8RkoMCffvxddVtGmph1phMR2hfRKNXR1M3tzEQYLuF+jr5D6MtX0D6Vd+fKVWpzdLA9xEnnWgTgC7dJ3UgEpe0/xIdLFQbda89yPZOqPbEsyjIC/Dt/iL2Tc6CsE7/AHUKGe/iKxk0Q52wbrCUmAGl9AV6lWBTPcA=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5224.namprd03.prod.outlook.com (20.180.13.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:16:14 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:16:14 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "contact@artur-rojek.eu" <contact@artur-rojek.eu>
Subject: Re: [PATCH] iio: adc: ingenic: Use devm_platform_ioremap_resource
Thread-Topic: [PATCH] iio: adc: ingenic: Use devm_platform_ioremap_resource
Thread-Index: AQHVgdsC2iTMr4Lxd0++/r8rkRCxOad7QeIA
Date:   Mon, 4 Nov 2019 15:16:14 +0000
Message-ID: <30c84014f09f22ed2cdfe2d5785eb60adff8b2a7.camel@analog.com>
References: <20191013152716.1830911-1-jic23@kernel.org>
In-Reply-To: <20191013152716.1830911-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33a0a597-427a-4614-7a6f-08d76139ef28
x-ms-traffictypediagnostic: CH2PR03MB5224:
x-microsoft-antispam-prvs: <CH2PR03MB522401825CC0B968674A62F8F97F0@CH2PR03MB5224.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(6116002)(3846002)(76116006)(66476007)(66556008)(66446008)(66946007)(256004)(2906002)(64756008)(99286004)(26005)(6506007)(102836004)(305945005)(2616005)(54906003)(2501003)(14444005)(316002)(76176011)(446003)(11346002)(118296001)(110136005)(36756003)(71200400001)(71190400001)(86362001)(478600001)(14454004)(6512007)(186003)(229853002)(6486002)(7736002)(486006)(476003)(4326008)(5660300002)(25786009)(8676002)(8936002)(81156014)(81166006)(6436002)(66066001)(6246003)(4001150100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5224;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z1QwNb9bbCHZi5MBBT+Y7QkbCW1tJO2NlVr52zWf78/h6t5YJUGzl7IaG0Ma1w56mDPj0Qw7mYCEVffQ6BF5nN8Al44VfvE9vYtl5ZeszlAXdsXbDr0Jq1fvieZjMIOgxosNC4b7jH1OlhqWqcfqsnoGPzjYH64HB0gND4n4Qot9Qu4NV0IpvLbbsH3SegrJPAzq+q+st6mnujLROf/j0OM5XQzrZowpqKFWX0Dp+5RKunOTX5xLi4E0uQX9hn5lF76n8L0JKqLJqvzTyx/yOIxQGa5OEAPVxdTShCC2jMPLSu6PiQ7YknuKm0Yo5KNi3NXSA0JeLuCHfrqBzTK9BCleahzJ4kqsTngv/gmprZq93SqejCeWnn369b4ASJg9eZc4eoEB8Ygy1/wOEf54aNxWC1ioj0G5R2RQyV3dveW3DDF3eO68TTMuCp/4Zsp7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D0490FAD46C6C4AB10C00BF4B9CDA34@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a0a597-427a-4614-7a6f-08d76139ef28
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:16:14.8059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxEs5d7OEA/HQ3ogQkY10tTLrWcT8RdlQBywjL7kA/ovxpaj8852SqA3ANy+h+97O4WIM6M5IV7vyb8Yy//qleQq0FjAVH7dIxwAL8zvV/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5224
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_09:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911040151
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDE2OjI3ICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBSZXBsYWNlcyBsb2NhbCBib2lsZXJwbGF0ZS4gIElkZW50aWZpZWQgYnkgY29jY2lu
ZWxsZS4NCj4gQ0hFQ0sgICBkcml2ZXJzL2lpby9hZGMvaW5nZW5pYy1hZGMuYw0KPiBkcml2ZXJz
L2lpby9hZGMvaW5nZW5pYy1hZGMuYzo0NDk6MS0xMDogV0FSTklORzogVXNlDQo+IGRldm1fcGxh
dGZvcm1faW9yZW1hcF9yZXNvdXJjZSBmb3IgYWRjIC0+IGJhc2UNCj4gDQoNClJldmlld2VkLWJ5
OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+
IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2Vp
LmNvbT4NCj4gQ2M6IEFydHVyIFJvamVrIDxjb250YWN0QGFydHVyLXJvamVrLmV1Pg0KPiAtLS0N
Cj4gIGRyaXZlcnMvaWlvL2FkYy9pbmdlbmljLWFkYy5jIHwgNCArLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9paW8vYWRjL2luZ2VuaWMtYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvaW5nZW5pYy0N
Cj4gYWRjLmMNCj4gaW5kZXggN2E1M2MyZjhkNDM4Li4zOWMwYTYwOWZjOTQgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvaWlvL2FkYy9pbmdlbmljLWFkYy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2Fk
Yy9pbmdlbmljLWFkYy5jDQo+IEBAIC00MjgsNyArNDI4LDYgQEAgc3RhdGljIGludCBpbmdlbmlj
X2FkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCXN0cnVjdCBk
ZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICAJc3RydWN0IGlpb19kZXYgKmlpb19kZXY7DQo+
ICAJc3RydWN0IGluZ2VuaWNfYWRjICphZGM7DQo+IC0Jc3RydWN0IHJlc291cmNlICptZW1fYmFz
ZTsNCj4gIAljb25zdCBzdHJ1Y3QgaW5nZW5pY19hZGNfc29jX2RhdGEgKnNvY19kYXRhOw0KPiAg
CWludCByZXQ7DQo+ICANCj4gQEAgLTQ0NSw4ICs0NDQsNyBAQCBzdGF0aWMgaW50IGluZ2VuaWNf
YWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJbXV0ZXhfaW5p
dCgmYWRjLT5hdXhfbG9jayk7DQo+ICAJYWRjLT5zb2NfZGF0YSA9IHNvY19kYXRhOw0KPiAgDQo+
IC0JbWVtX2Jhc2UgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0s
IDApOw0KPiAtCWFkYy0+YmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIG1lbV9iYXNl
KTsNCj4gKwlhZGMtPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwg
MCk7DQo+ICAJaWYgKElTX0VSUihhZGMtPmJhc2UpKQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihhZGMt
PmJhc2UpOw0KPiAgDQo=
