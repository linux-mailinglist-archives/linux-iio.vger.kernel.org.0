Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1661A622A
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 06:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgDMEbe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 00:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgDMEbd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 00:31:33 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7841C0A3BE0
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2020 21:31:33 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03D4TxJD018435;
        Mon, 13 Apr 2020 00:31:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 30b7namy4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 00:31:31 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03D4VVPW020322;
        Mon, 13 Apr 2020 00:31:31 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0b-00128a01.pphosted.com with ESMTP id 30b7namy4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 00:31:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAqhjsBFXh8TYJtEIw+MDV3vdOeNgOAhKgfRUGnrJ9URMssTPyK4MlOU5Zn0SQFopFSCblg6Ty7xNRdBAwoFWSzbhYil3ATIaSqTRz1/WJl3k2W8qqd9DUhDQX2DjsRJU5w1RVx31jz9hkDsoGTlaa3eFr70lqI8FAHWFdnsMDyiuxSskDVnABKQS1i2D41Z4KiWrvtB/tOhq4YfIcuc6staE5mCdWThkethgDgi9n3RtkHZBYYtZwKDStwSfPXSDQGvsIAiT+m7LOt178JUdvDMDHKgCdjVdYQRLHsa9TsODsVu8I/0K1F/78rFIFhHu6tVCAkov8BqBIzVdjozng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa4C5tCupXqq3zrA+yolso65TahkTenWC6e/euv7Ndc=;
 b=RYTFgYHFAK9kGpwOxIlgp5A6sYtHYyIVKLx7O+NmJXQTaZtCy/5/NAd2IS8YeIFepxlv+8xeU9NslThl8VQhQSq07+RL7aUSnpqyKAEGdiKgGa54rQPSThPDnFnLua/XPOh+/HPA3zL8cZqKbHhQDI13ev8Q2UekqmoBq7/8nHAzaFymrIIMpsKkrLJRsy9cRrUkUFRe4vMWaHCl7eYSVrL4pW+Eh01yGV/EODwlGsdVRfYjfbS26l/zf+r/sgj97+HIF/sRhHVK0T1s6Zci7Jof7KldgXSq67ppPje7FWjTLTwRnrTc/IhIPlagmqdrvTLNakBgbTce46Qv0WnSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa4C5tCupXqq3zrA+yolso65TahkTenWC6e/euv7Ndc=;
 b=zyswlUB0/iigQTfUQJRSJbt82+7PipR1OOOP+b9+9HkRXyd2MQgYbAVRkZhGX5P++dE2ZIs7IQkXU1wFybtkJuivvOFMASFTLPGkQRmxPdV+v6gPSeJigfWpRfQOBGFpEhEO51bYJWC9DYqSIWnlDURtA0eNDNGJO6yffKdS3sE=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3787.namprd03.prod.outlook.com (2603:10b6:5:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Mon, 13 Apr
 2020 04:31:29 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 04:31:29 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/6] iio:accel:mxc4005: Drop unnecessary explicit casts in
 regmap_bulk_read calls
Thread-Topic: [PATCH 1/6] iio:accel:mxc4005: Drop unnecessary explicit casts
 in regmap_bulk_read calls
Thread-Index: AQHWC3TZRHKV9xGe106JQLG1in8ocqh2gvYA
Date:   Mon, 13 Apr 2020 04:31:29 +0000
Message-ID: <6372edb1b9f88fdae77ad46d0b26388a99ba9c43.camel@analog.com>
References: <20200405180321.1737310-1-jic23@kernel.org>
         <20200405180321.1737310-2-jic23@kernel.org>
In-Reply-To: <20200405180321.1737310-2-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f6cf437-4940-4016-6341-08d7df638948
x-ms-traffictypediagnostic: DM6PR03MB3787:
x-microsoft-antispam-prvs: <DM6PR03MB37874344D6B85ED3DBECA850F9DD0@DM6PR03MB3787.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(136003)(376002)(396003)(346002)(39850400004)(478600001)(110136005)(5660300002)(6512007)(36756003)(54906003)(2906002)(186003)(76116006)(26005)(316002)(91956017)(66946007)(66476007)(64756008)(66556008)(66446008)(4326008)(81156014)(2616005)(86362001)(8936002)(6486002)(71200400001)(6506007)(8676002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kyEQZhBy7XpCL0OeHpV4lvFojWDNkwr+jgha0K6X7EiFQThcYod9zyFTutEE5soejprWgKRY31nyCVurADZhMdvA8NZj+krV9yK9DsGJYcRr84R3/WJaDtVVQc95L325NjFoM3+uuhnZIrgShufBrS7s3eeZBnr6tc19OTjnNwOZZPfwmcShmGnmLVmE7YeSwDVaDeGK65V0bOp05ymypFchCiK4LJ4riyJGnYT4D0sJVaHBWAicfNzAFQWwlKmUX6zcLsUAe9STRuoFanq2yGNGGVElul1NdEajjW/M2s8rCmxEgkhIfs9uwWXfBsAbYMCBVmYpTE5tIEaIqpAYgpvWDswL9IGsonWnOfYRoazOP/H6SLOkDYTI4IwOBuK/5u6yvnEGwTj0dmWd2YJHPRpa69Hh9dcSJxexbUc64a4p3EGEvsdZMPND/x6gtJGF
x-ms-exchange-antispam-messagedata: ZDxG0K5wSBraPkl2Fst5yMB38uPJtfMQHGCVeqgY+EKnTcyIgREtu+9XoiA8h8XlSK+vA1L4IH+ze/R27dEaVjIJy9j/Foil51Wph3xnpLp98rSFXaXDycMJD++CZQYP6Oa3nQItQdLTI6d9/kD7Nw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC23D731EB0FDF4C8AA5218C107B4DFE@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6cf437-4940-4016-6341-08d7df638948
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 04:31:29.2524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHK7fOcGWTN3yg2yIknATspuqoSmc/ipquPxaM8O3o9qd0yyQKfnrEtxGcnU+QIeAAIGJDubSZ4lIAUmdb8dBuv+OKZV9udwyW6LbIHMuCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3787
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_01:2020-04-12,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130040
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTA1IGF0IDE5OjAzICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiByZWdtYXBfYnVsa19yZWFkIHRha2VzIGEgdm9pZCAqIGZvciBpdHMgdmFsIHBhcmFt
ZXRlci4gSXQgY2VydGFpbmx5DQo+IG1ha2VzIG5vIHNlbnNlIHRvIGNhc3QgdG8gYSAodTggKikg
KyBubyBuZWVkIHRvIGV4cGxpY2l0bHkgY2FzdA0KPiBhdCBhbGwgd2hlbiBjb252ZXJ0aW5nIGFu
b3RoZXIgcG9pbnRlciB0eXBlIHRvIHZvaWQgKi4NCj4gDQoNClJldmlld2VkLWJ5OiBBbGV4YW5k
cnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+IFNpZ25lZC1v
ZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2lpby9hY2NlbC9teGM0MDA1LmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9paW8vYWNjZWwvbXhjNDAwNS5jIGIvZHJpdmVycy9paW8vYWNjZWwvbXhjNDAw
NS5jDQo+IGluZGV4IDNkNWJlYTY1MTkyMy4uOWQwNzY0MmMwZGUxIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2lpby9hY2NlbC9teGM0MDA1LmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWNjZWwvbXhj
NDAwNS5jDQo+IEBAIC0xMzUsNyArMTM1LDcgQEAgc3RhdGljIGludCBteGM0MDA1X3JlYWRfeHl6
KHN0cnVjdCBteGM0MDA1X2RhdGEgKmRhdGEpDQo+ICAJaW50IHJldDsNCj4gIA0KPiAgCXJldCA9
IHJlZ21hcF9idWxrX3JlYWQoZGF0YS0+cmVnbWFwLCBNWEM0MDA1X1JFR19YT1VUX1VQUEVSLA0K
PiAtCQkJICAgICAgICh1OCAqKSBkYXRhLT5idWZmZXIsIHNpemVvZihkYXRhLT5idWZmZXIpKTsN
Cj4gKwkJCSAgICAgICBkYXRhLT5idWZmZXIsIHNpemVvZihkYXRhLT5idWZmZXIpKTsNCj4gIAlp
ZiAocmV0IDwgMCkgew0KPiAgCQlkZXZfZXJyKGRhdGEtPmRldiwgImZhaWxlZCB0byByZWFkIGF4
ZXNcbiIpOw0KPiAgCQlyZXR1cm4gcmV0Ow0KPiBAQCAtMTUwLDcgKzE1MCw3IEBAIHN0YXRpYyBp
bnQgbXhjNDAwNV9yZWFkX2F4aXMoc3RydWN0IG14YzQwMDVfZGF0YSAqZGF0YSwNCj4gIAlfX2Jl
MTYgcmVnOw0KPiAgCWludCByZXQ7DQo+ICANCj4gLQlyZXQgPSByZWdtYXBfYnVsa19yZWFkKGRh
dGEtPnJlZ21hcCwgYWRkciwgKHU4ICopICZyZWcsIHNpemVvZihyZWcpKTsNCj4gKwlyZXQgPSBy
ZWdtYXBfYnVsa19yZWFkKGRhdGEtPnJlZ21hcCwgYWRkciwgJnJlZywgc2l6ZW9mKHJlZykpOw0K
PiAgCWlmIChyZXQgPCAwKSB7DQo+ICAJCWRldl9lcnIoZGF0YS0+ZGV2LCAiZmFpbGVkIHRvIHJl
YWQgcmVnICUwMnhcbiIsIGFkZHIpOw0KPiAgCQlyZXR1cm4gcmV0Ow0K
