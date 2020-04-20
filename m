Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6111B0149
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 08:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgDTGFA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 02:05:00 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3670 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgDTGE7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 02:04:59 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K62U6J031082;
        Mon, 20 Apr 2020 02:04:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf5vn43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:04:52 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03K62bfC031141;
        Mon, 20 Apr 2020 02:04:51 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf5vn41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:04:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTVgan7qyrhyQsA+8WRx0U8Aiu9/bXVbK7X7LaHb4bhb9o1TcOJHWMW0SvfeVJ8fLBS5EBTKUCvitCGmUl1ca47I/yax1AkrajLvC058ezE4jjx5XPLtPu98MLcmJFo9GKgL9H562ZOtbrgWzc6fVP+WfEMfJubBSoi/KhzvgXR6BLieLuzGE6a0KoHDIsqPxSLtKgJns1pidpiDYQZAmPVBnZw+E73wLm6YUcwG8FFgPQzwDEBWUpMGmbi951qxTZSz27UdUB0Ov1B15BoJVQBXQr/oX1AXCsFgwIXdZ7aOs+DJpOgxSsmc/aOQJ4t4CKiU4MVX5r/VMnGMLNA8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmgY5bLVhXWWqSDIbHPqFw1+36LvKln3Mp6vIFVjROE=;
 b=Kp1Wjt88GUup+OX9KwCgTriLQA+04/13dPjvzn2Wd9UFShKaVRrNj4+GVeSBttUpO1WMZD8YtrPgVlXT7d6xGIK22lyyFxe81+NN1oTZ29a5O8OQWJvlleCKolWgNGU0M2xBejUuobBWiFNFMxACVWjlHWjbXPBVJe1qQMTA9Sv5fd6sExdP6St5ceNvnpENUVJu4uzGebSlP51v/5GV+KLxs9PSJ2L5cW74DDQW5dgnOP/M2KbeSDHf7izYdZMA4rFeDOZodXYWfroq79PGDtPk3Ut9rMDLoqlCtN3XQn+CG8DY9TMIjWnH6yXwnNL4RImcVHMNG1IaYt6wLXqD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmgY5bLVhXWWqSDIbHPqFw1+36LvKln3Mp6vIFVjROE=;
 b=qKfa5fYQSK7UDokWgMqq63H6/kEcFcWi8kIlGhvKS27nPZiTe0Du0qa1xty1pFrCyS1X9yvfMe0AunsFu/GB4zuzX2+vnBvSr6+jbjPdpC/YhyxLq/nbmk6f03kjGyPdTs0shrt3A7Oc6Nz4dqGKMQGwYtTs1m7c/+p0/68fcR0=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4153.namprd03.prod.outlook.com (2603:10b6:5:5c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 06:04:48 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 06:04:48 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/7] iio: light: clean out of_match_ptr and tidy headers
Thread-Topic: [PATCH 0/7] iio: light: clean out of_match_ptr and tidy headers
Thread-Index: AQHWFlvUJkLrnMIP/Uqgyo/lT8NGiKiBh5cA
Date:   Mon, 20 Apr 2020 06:04:48 +0000
Message-ID: <beff54a412caddaaa7facbc2df2ddf939668fc44.camel@analog.com>
References: <20200419150206.43033-1-jic23@kernel.org>
In-Reply-To: <20200419150206.43033-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17d76cda-39c5-4063-025a-08d7e4f0bbac
x-ms-traffictypediagnostic: DM6PR03MB4153:
x-microsoft-antispam-prvs: <DM6PR03MB4153B6E595E5909DDD31498EF9D40@DM6PR03MB4153.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(346002)(396003)(376002)(39850400004)(366004)(86362001)(36756003)(6512007)(186003)(26005)(71200400001)(6506007)(478600001)(110136005)(2616005)(4326008)(2906002)(66946007)(76116006)(91956017)(8676002)(5660300002)(8936002)(316002)(66446008)(6486002)(64756008)(66556008)(66476007)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPazekXMPjD1u7CKNCVNoS/v1R9HSFeF81LnLFTVc8qFv+o3weSrIWQMgaZAtYt9uDdBGF8oLdwrkrDZr0RspkC2oDSQEcoSzhNzKuovKMV9O8MC6MB/u98C5Ef16WdOPydt4rZ8qeBbQNYqEKlK62wmI/MA2Y+EALgeGqbFqFlg60MEWvfBI1iAWEUiHdc1R6//7cWuKk3FrPv4cSnKRcINkTvG9uOK9MHWKwB7EWlZMUBlUIW4hN8oUvNJD/NYn7gAI5wgsuqrutClpu76hy5sPBvNuTdu2wibvH5qwLEZUJrzpBOjaWzAaATeJJBppmXPJiPiB0LkKedqBCd5bwYefxi2e/tb6HF+UAkqgcfvJp4Jolf+xX+JsfrtgV/R1WFAfuOkNbAc713zS1BZevVieA7a1j8h2GXkoolBSYy+fOUb2gkvax8rCzUv6pj7
x-ms-exchange-antispam-messagedata: sC1OWNTE9wjVpdSzTIpD6sxb4ckaHIS5Wtso/nNuBaxkUlqw05H4uTyydoRCCEVBYCdUEEI61Yu7SyMmYrkeqwCBLW8qtLZMq9W6f/PfpAFvZovuOMPljcvBHvNo4XsLZBKny/5rPYuTPwaDW6qG6A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B3AF5096E6332439D8BDD4259E99B4C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d76cda-39c5-4063-025a-08d7e4f0bbac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 06:04:48.7640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4LG7jgpms5dCxhDL6a7ogBeQ66HUykAIDZTNQIet1j02fCL6icg7Yg76+1m0Ll8anwthSbZXcztBfzHjoTrhEap8eloZVctMgn8ee/Wq10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4153
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_01:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200053
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTE5IGF0IDE2OjAxICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBIaSBBbGwsDQo+IA0KPiBHaXZlbiB3ZSBrZWVwIGhhdmluZyB0byBleHBsYWluIHRv
IHBlb3BsZSB0aGF0IG9mX21hdGNoX3B0ciBpcyBsZXNzDQo+IHRoYW4gaWRlYWwgbm93IHdlIGhh
dmUgdGhlIG9wdGlvbiBvZiBBQ1BJIERTRFQgdXNpbmcgUFJQMDAwMSBhbmQNCj4gdGhlIGNvbXBh
dGlibGUsIGl0IHNlZW1zIHNlbnNpYmxlIHRvIHJlZHVjZSB0aGUgbnVtYmVyIG9mIGluc3RhbmNl
cw0KPiB0aGF0IHBlb3BsZSBtaWdodCBjb3B5IGZvciBhIG5ldyBkcml2ZXIuDQo+IA0KPiBBZGRl
ZCB0aGVvcmV0aWNhbCBiZW5lZml0IGlzIHRoYXQgd2UgY2FuIHByb2JlIGFsbCB0aGVzZSBkcml2
ZXJzIGZyb20NCj4gYXBwcm9wcmlhdGUgRFNEVCAodGhvdWdoIEkgZG91YnQgYW55b25lIHdpbGwp
Lg0KPiANCj4gSSdtIHNlbmRpbmcgdGhpcyBmaXJzdCBzZXQgb3V0IHRvIHNlZSBpZiBhbnlvbmUg
aGFzIHN0cm9uZyB2aWV3cyBhZ2FpbnN0DQo+IGRvaW5nIHRoaXMgZm9yIGF0IGxlYXN0IHRoZSBz
aW1wbGUgZHJpdmVycyB0aGF0IGhhdmUgbm8gb3RoZXIgZGV2aWNlDQo+IHRyZWUgZGVwZW5kZW5j
ZS4gIE9idmlvdXNseSBtb3JlIHdvcmsgd291bGQgYmUgbmVlZGVkIHRvIHJlbW92ZQ0KPiB1c2Ug
b2Ygb2ZfbWF0Y2hfcHRyIGZyb20gSUlPIGNvbXBsZXRlbHkuDQo+IA0KPiBMaWdodCBzZW5zb3Jz
IHBpY2tlZCBhcyBhIHN0YXJ0aW5nIHBvaW50IGFzIHRoZXkgdGVuZCB0byBiZSBzaW1wbGUuDQo+
IA0KPiBJIG1heSBkbyBmb2xsb3cgdXBzIGluIGxhcmdlciBibG9ja3MgdG8gYXZvaWQgc28gbWFu
eSBzbWFsbCBwYXRjaGVzDQo+IChvciBpbmRlZWQgZmxhdHRlbiB0aGVzZSBpbnRvIG9uZSB3aGVu
IGFwcGx5aW5nKQ0KDQpmd2l3OiBpIHdhcyBhbHNvIHBsYW5uaW5nIHRvIGRvIGEgc3dlZXAgb2Yg
dGhlc2U7DQp3ZWxsLCB0YmgsIHRoZSBtYWluIGludGVudCB3YXMgdG8gdGFyZ2V0IEFESSBkcml2
ZXJzIGZpcnN0IGFuZCBkbyBhIGJpZ2dlcg0KY29udmVyc2lvbiBmb3IgdGhlbSB0byBtYWtlIHRo
ZSBzbGlnaHRseSBmcmllbmRsaWVyIHdpdGggQUNQSTsgDQoNCmFzaWRlIGZyb20gdGhpcywgaSdt
IGFsc28gbm90aWNpbmcgc29tZSBiYWQgcGF0dGVybnMgYmVpbmcgY29waWVkIGZyb20gb2xkZXIN
CmRyaXZlcnMsIHdoZW4gYXNraW5nIG5ldyBwZW9wbGUgdG8gd3JpdGUgTGludXggZHJpdmVyczsN
CmkgZGlkIG5vdCBtYWtlIGEgbGlzdCwgcHJvYmFibHkgc2hvdWxkIGhhdmU7DQpvbmUgaXMgJ21s
b2NrJyBbc3RpbGxdIGJlaW5nIGNvcGllZDsgYW5kIGFjY2Vzc2luZyBvdGhlciBpbnRlcm5hbCBm
aWVsZHM7DQpidXQgdGhlIGludGVybmFsIGZpZWxkcyBhY2Nlc3NpbmcgcmVxdWlyZXMgYSBiaXQg
b2YgYSBjbGVhbnVwIGluIHRoZSBmb3JtIG9mDQpwcml2YXRpemluZyB0aGUgZmllbGRzIHNvbWVo
b3c7DQoNCg0KPiANCj4gVGhhbmtzDQo+IA0KPiBKb25hdGhhbg0KPiANCj4gSm9uYXRoYW4gQ2Ft
ZXJvbiAoNyk6DQo+ICAgaWlvOiBsaWdodDogYmgxNzgwOiB1c2UgbW9kX2RldmljZXRhYmxlLmgg
YW5kIGRyb3Agb2ZfbWF0Y2hfcHRyIG1hY3JvDQo+ICAgaWlvOiBsaWdodDogY20zMjE4MTogQWRk
IG1vZF9kZXZpY2V0YWJsZS5oIGFuZCByZW1vdmUgb2ZfbWF0Y2hfcHRyDQo+ICAgaWlvOiBsaWdo
dDogY20zMjMyOiBBZGQgbW9kX2RldmljZXRhYmxlLmggaW5jbHVkZSBhbmQgZHJvcA0KPiAgICAg
b2ZfbWF0Y2hfcHRyDQo+ICAgaWlvOiBsaWdodDogZ3AyYXAwMjBhMDBmOiBTd2FwIG9mLmggZm9y
IG1vZF9kZXZpY2V0YWJsZS5oICsgZHJvcA0KPiAgICAgb2ZfbWF0Y2hfcHRyDQo+ICAgaWlvOiBs
aWdodDogb3B0MzAwMTogQWRkIG1vZF9kZXZpY2V0YWJsZS5oIGFuZCBkcm9wIHVzZSBvZg0KPiAg
ICAgb2ZfbWF0Y2hfcHRyDQo+ICAgaWlvOiBsaWdodDogc3RfdXZpczI1OiBBZGQgbW9kX2Rldmlj
ZXRhYmxlLmggYW5kIGRyb3Agb2ZfbWF0Y2hfcHRyDQo+ICAgaWlvOiBsaWdodDogdmw2MTgwOiBz
d2FwIG9mLmggZm9yIG1vZF9kZXZpY2V0YWJsZS5oIGFuZCBkcm9wDQo+ICAgICBvZl9tYXRjaF9w
dHINCj4gDQo+ICBkcml2ZXJzL2lpby9saWdodC9iaDE3ODAuYyAgICAgICAgfCA2ICsrLS0tLQ0K
PiAgZHJpdmVycy9paW8vbGlnaHQvY20zMjE4MS5jICAgICAgIHwgMyArKy0NCj4gIGRyaXZlcnMv
aWlvL2xpZ2h0L2NtMzIzMi5jICAgICAgICB8IDMgKystDQo+ICBkcml2ZXJzL2lpby9saWdodC9n
cDJhcDAyMGEwMGYuYyAgfCA2ICsrLS0tLQ0KPiAgZHJpdmVycy9paW8vbGlnaHQvb3B0MzAwMS5j
ICAgICAgIHwgMyArKy0NCj4gIGRyaXZlcnMvaWlvL2xpZ2h0L3N0X3V2aXMyNV9pMmMuYyB8IDMg
KystDQo+ICBkcml2ZXJzL2lpby9saWdodC9zdF91dmlzMjVfc3BpLmMgfCAzICsrLQ0KPiAgZHJp
dmVycy9paW8vbGlnaHQvdmw2MTgwLmMgICAgICAgIHwgMiArLQ0KPiAgOCBmaWxlcyBjaGFuZ2Vk
LCAxNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo=
