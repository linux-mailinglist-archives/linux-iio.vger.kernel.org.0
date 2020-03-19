Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFCE418AD58
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 08:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCSHcQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 03:32:16 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30822 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgCSHcP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 03:32:15 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02J7Si3P005642;
        Thu, 19 Mar 2020 03:31:52 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yu9jawfv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 03:31:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeAyK+tr6gPon0VqBZiNNvOwZx1HBNMCRHQPHipW0nV0rcXMsbEIDPjpfyPkhtzni/FY5Zi2V/pIHEmN9gDG/5ao5Em4lNcKMKvSIygSmnmNhPAzwRzvZLJ6b26dp2oHv99Or+hwW+UCA5HdEG1PnewtA1x/CnAOQm0Fda5mkZPbw4P5wujo0zK5NGTOy7bLvsMGyMUuze4BGhu8S6dGw9aj9X8GdcefOzW4Mu/dlUttd0G/M2sDAv4YIosk4J975T03g9Hc8Sc0TKgNLxm+NQDMK4RLfQMohgbhM8h+VvhxoTcJbzeju8KERA8VBsTzjIcLeZH/QJpLrLD3i1dF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dxE7+dZhkjt7ihjIvlgaQoXZxgrw6G91DvwqvtEvLM=;
 b=NhQaBVz37UkBI5PQ9mtA3mT0iXrWbJqFgkVqM24S6IGXC7/ZnZhnxZzXRsWgMoC1NhH9NT9AQHcg6E30kJnmRL8C264XbNSzpEaVWP/vhASY2VJePyoesdbdlWPk8rqlGSM+4b98La2nvW9M+O4sApM8haz1vxWSOvy8RL0chgKUk8Ywd3+qTgwocJVCism8QaV5jQiTnnWlhqdSs7MLfhwP2fDHEb1/0yl37zM+CNdrjSkNVJtD8yx6vnNPNwrZsBfa3Z8jdfSN1Egh+emQIcBSvTrG0Ugj9VEawB+S7YLowzUepov3tDJree3itEYm+gL3CaaZanMXwICvNY1Hxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dxE7+dZhkjt7ihjIvlgaQoXZxgrw6G91DvwqvtEvLM=;
 b=aiobYfL3sup2VjkATYu+muG88Zv+xN0MQwi1feRDfsivn7wCKZRzAh2me2HeENZOwPowSi1lYQjLVcnQxFmF1IQsbfsfs0OEvg/CqfOeQctqXX37oJL7BnXUU7OMAYYjeRkzxNhizyvJbOB05os3VuRfz6WmKedGhd6kZgevTxA=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3513.namprd03.prod.outlook.com (2603:10b6:5:aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Thu, 19 Mar
 2020 07:31:50 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Thu, 19 Mar 2020
 07:31:50 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "alazar@startmail.com" <alazar@startmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 0/2] Maxim MAX1241 driver, v2
Thread-Topic: [PATCH 0/2] Maxim MAX1241 driver, v2
Thread-Index: AQHV/WM7BmXtq9wFgEmEkm/wn9v30KhPhxGA
Date:   Thu, 19 Mar 2020 07:31:50 +0000
Message-ID: <c6a73c86bad67d2e4f77467a830cec06072eb986.camel@analog.com>
References: <20200318202837.512428-1-alazar@startmail.com>
In-Reply-To: <20200318202837.512428-1-alazar@startmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d970c170-422f-4ce7-1ed4-08d7cbd796de
x-ms-traffictypediagnostic: DM6PR03MB3513:
x-microsoft-antispam-prvs: <DM6PR03MB351303983D3105DF11C75CBEF9F40@DM6PR03MB3513.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(396003)(376002)(346002)(199004)(76116006)(91956017)(2906002)(5660300002)(66946007)(6512007)(86362001)(66556008)(478600001)(64756008)(66476007)(966005)(26005)(66446008)(81166006)(81156014)(54906003)(6506007)(4326008)(2616005)(186003)(8676002)(71200400001)(6486002)(36756003)(316002)(8936002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3513;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KwtQ2sAQKSAYrcgtdk9m2het4aGG/s/SygneY7G9QS+xNxVQb15nPsk76QmTHpilUHvDBpLobYbGEqiN4lqzON/iama+FgJTA0XawtEctHtA7BtWVj4pS/4Q9G5v362VP+79j85IZ/2Djx+OGJU4bDtgSr10Hsf0JNj+P30WfDIbKdQg+DAH/lIkThvrkzocYRsja73I2ArEJgUt4mYj32+hLTz+ScJnp1XjzB3fc2LaO6dU6c7HZpkLlMj/g1GUVnVK+XzPqXnMC4hcbw8/nwxbJLf2OSQo+3jBKXKMs7jyiy/8Hu7lqasE0zHBHKHMmjXS3xsa6hDkemznEzxuoqfa3L/D6b73f8mbgvJaFeqGalKDKdUczZedurFqZY6V0brLBlBG/LE0k3NWxXyigoDbfwKpgbaF4hThcvj9lDB3yaCe8VO2LliaZg+QdPFJJCNZDP/0tYLJJ0lmZDj6vjruK49JONWByRTR8lZzg5dHN8FpYLxz5nTIAperQZFLPirDqrsOml0YXayD13RMGQ==
x-ms-exchange-antispam-messagedata: v0GD4xS5nMj2iObTwGlFOX8m8q00Qnju+c9EJyVllc1NJNztMnCwaF12Um3hk98YTBMYlO1OGQ2oM7WQ4YsMjwWEh6xP2qowPQJW7f55DB4h9mUhRqFr41O0gi/mFL/7e9O+zLV1TKR1/tWDVICA2w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <817629E27678474E9FCC1AC48930D0F2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d970c170-422f-4ce7-1ed4-08d7cbd796de
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 07:31:50.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4s2jjxwNXeY2pDHDZlSjaK7Xg4/pYYuxPHVnv+XEMYfUcbPiJs7WShgX3kwPZywrAmjSJoPpdiC60++kVMip7kGWQnf59aMHxA01SGSjtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3513
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_01:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190033
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTE4IGF0IDIyOjI4ICswMjAwLCBBbGV4YW5kcnUgTGF6YXIgd3JvdGU6
DQo+IEhlbGxvIGFnYWluLA0KPiANCj4gSGVyZSdzIHZlcnNpb24gMiBvZiBhIHBhdGNoIHNlcmll
cyB3aGljaCBhZGRzIHN1cHBvcnQgZm9yIHRoZSBNYXhpbQ0KPiBNQVgxMjQxLCBhIDEyLWJpdCwg
c2luZ2xlLWNoYW5uZWwsIFNQSS1jb25uZWN0ZWQgQURDLiBUaGUgcHJldmlvdXMNCj4gdmVyc2lv
biBpcyBoZXJlOg0KPiANCg0KYXMgYSBxdWljayBub3RlLCB3aGVuIGdlbmVyYXRpbmcgcGF0Y2hl
cyB3aXRoIFYyIGl0J3MgdXNlZnVsIHRvIGRvOg0KDQpnaXQgZm9ybWF0LXBhdGNoIC12MiA8Y29t
bWl0LXJhbmdlPg0KDQp0aGF0IHdheSwgdGhlIFYyIGdldHMgYXBwZW5kZWQgdG8gYWxsIHBhdGNo
ZXM7DQptYWtlcyBpdCBlYXNpZXIgZm9yIG1haW50YWluZXJzIHRvIHNlZSB3aGljaCBpcyBWMiwz
LDQsZXRjDQoNCm5vIG5lZWQgdG8gcmUtc3BpbiBWMjsNCmJ1dCB3aGVuIGdvaW5nIHRvIFYzLCB5
b3UgY2FuIHRyeSBpdA0KDQoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaWlvLzIw
MjAwMzE3MjAxNzEwLjIzMTgwLTEtYWxhemFyQHN0YXJ0bWFpbC5jb20vDQo+IA0KPiBJJ3ZlIGlu
dGVncmF0ZWQgcHJldHR5IG11Y2ggYWxsIG9mIHRoZSBzdWdnZXN0aW9ucyBJIGdvdCBoZXJlLCBh
bmQgZml4ZWQNCj4gdGhlIGlzc3VlcyB0aGF0IHlvdSBhbGwgcG9pbnRlZCBvdXQgKHRoYW5rcyBh
Z2FpbiEgRGlkIEkgc2F5IHRoYW5rcw0KPiBsYXRlbHk/IFRoYW5rcyEhISkuIEEgc2hvcnQgbGlz
dCBvZiB0aGUgY2hhbmdlcyBpcyBhdCB0aGUgZW5kIG9mIHRoaXMNCj4gbWVzc2FnZS4gY2hlY2tw
YXRjaC5wbCBpcyBoYXBweSwgaXQganVzdCB3YXJucyBtZSBhYm91dCB0aGUgTUFJTlRBSU5FUlMN
Cj4gZmlsZSwgd2hlcmUgSSBkb24ndCB0aGluayBhbiBlbnRyeSBpcyBuZWNlc3NhcnkuIGR0X2Jp
bmRpbmdzX2NoZWNrIGlzDQo+IGhhcHB5LCB0b28uDQo+IA0KPiBUaGUgb25seSBzdWdnZXN0aW9u
IHRoYXQgSSBoYXZlbid0IGluY29ycG9yYXRlZCBpcyBhZGRpbmcgbWF4MTI0MCB0byB0aGUNCj4g
bGlzdCBvZiBjb21wYXRpYmxlIGRldmljZXMuIEkndmUgdGhvdWdodCBhYm91dCBpdCwgYnV0IHRo
ZXJlIGFyZQ0KPiB0aW1pbmctcmVsYXRlZCBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRoZSB0d28gZGV2
aWNlcywgc28gc2ltcGx5IHZhbGlkYXRpbmcNCj4gd2hhdCBteSBtYWNoaW5lIHNlbmRzIHdvdWxk
bid0IGJlIGRlZmluaXRpdmUuIEkgdGhpbmsgaXQgd291bGQgYmUNCj4gZGlzaW5nZW5pb3VzIHRv
IGNsYWltIGNvbXBhdGliaWxpdHkgdW5kZXIgdGhlc2UgY2lyY3Vtc3RhbmNlcy4gSSBkbyBwbGFu
DQo+IHRvIGdldCBhIDEyNDAgYXNhcCwgYW55d2F5LCBhbmQgd2l0aCBhbnkgbHVjayBteSBwYXRj
aCB3b3VsZCBqdXN0IHVwZGF0ZQ0KPiB0aGUgY29tcGF0IHN0cmluZy4NCj4gDQo+IE5vdywgaGVy
ZSdzIHdoYXQgSSBjaGFuZ2VkOg0KPiANCj4gKiBSZW1vdmVkIHVzZWVsZXNzIGhlYWRlciBpbmNs
dWRlcw0KPiANCj4gKiBEcm9wcGVkIG5lZWRsZXNzbHkgdmVyYm9zZSBzdHVmZiBpbiBfcmVhZCBh
bmQgX3Byb2JlIGZ1bmN0aW9ucw0KPiANCj4gKiBEcm9wcGVkIHVzZWxlc3MgR1BMIG5vdGljZQ0K
PiANCj4gKiBMb3dlcmVkIGxvZyBsZXZlbCBvZiBzaGRuIHBpbiBzdGF0dXMgaW4gcHJvYmUgZnVu
Y3Rpb24sIG5vdyBpdCdzDQo+ICAgZGV2X2RiZw0KPiAgIA0KPiAqIEFkZGVkIHByb3BlciBlcnJv
ciBjaGVja2luZyBmb3IgdGhlIEdQSU8gc2h1dGRvd24gcGluDQo+IA0KPiAqIHJlbW92ZSBub3cg
YWx3YXlzIHJldHVybnMgemVybyAobWFuLCBJJ3ZlIGJlZW4gd3JvbmcgYWJvdXQgdGhpcyBmb3IN
Cj4gICAqeWVhcnMqIG5vdy4uLikNCj4gICANCj4gKiBBZGRlZCByZWd1bGF0b3IgZGlzYWJsZSBh
Y3Rpb24sIGNsZWFudXAgaXMgbm93IGhhbmRsZWQgdmlhIGRldm0NCj4gDQo+ICogRHJvcCBkZWxh
eV91c2VjcywgdXNlIGRlbGF5LnZhbHVlLCBkZWxheS51bml0DQo+IA0KPiAqIERyb3AgY29uZmln
X29mLCBvZl9tYXRjaF9wdHIgY2FsbA0KPiANCj4gKiBEcm9wcGVkIElJT19CVUZGRVIsIElJT19U
UklHR0VSRURfQlVGRkVSIGRlcGVuZGVuY2llcywgc2V0IFNQSV9NQVNURVINCj4gICBhcyBkZXBl
bmRlbmN5LCBmaXggaW5kZW50aW5nLg0KPiAgIA0KPiAqIERUIGJpbmRpbmc6IHVzZSBjb3JyZWN0
IGlkLCBhZGQgcmVnIGRlc2NyaXB0aW9uIChsb29rcyBwcmV0dHkNCj4gICBzdGFuZGFyZCksIGRy
b3BwZWQgc3BpLW1heC1mcmVxdWVuY3ksIGZpeGVkIGR0X2JpbmRpbmdfY2hlY2sNCj4gICBjb21w
bGFpbnRzIChvb3BzISkNCj4gDQo+IFRoYW5rcyENCj4gDQo+IEFsZXgNCj4gDQo+IEFsZXhhbmRy
dSBMYXphciAoMik6DQo+ICAgaWlvOiBhZGM6IEFkZCBNQVgxMjQxIGRyaXZlcg0KPiAgIGR0LWJp
bmRpbmdzOiBpaW86IGFkYzogQWRkIE1BWDEyNDEgZGV2aWNlIHRyZWUgYmluZGluZ3MgaW4NCj4g
ICAgIGRvY3VtZW50YXRpb24NCj4gDQo+ICAuLi4vYmluZGluZ3MvaWlvL2FkYy9tYXhpbSxtYXgx
MjQxLnlhbWwgICAgICAgfCAgNjIgKysrKysrDQo+ICBkcml2ZXJzL2lpby9hZGMvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKw0KPiAgZHJpdmVycy9paW8vYWRjL01ha2VmaWxl
ICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gIGRyaXZlcnMvaWlvL2FkYy9tYXgxMjQx
LmMgICAgICAgICAgICAgICAgICAgICB8IDIwNiArKysrKysrKysrKysrKysrKysNCj4gIDQgZmls
ZXMgY2hhbmdlZCwgMjc5IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9tYXhpbSxtYXgxMjQxLnlh
bWwNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lpby9hZGMvbWF4MTI0MS5jDQo+IA0K
