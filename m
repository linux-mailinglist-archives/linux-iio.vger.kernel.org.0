Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88401DADDC
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 10:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgETIqy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 04:46:54 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:15356 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726224AbgETIqx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 04:46:53 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04K8jrf6019158;
        Wed, 20 May 2020 04:46:32 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0b-00128a01.pphosted.com with ESMTP id 313ca0r8my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 04:46:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCs3Sq5n6Y8NwCe0v/a3vKEDtYfjerfTzUDOwX7UgbhtE4xRf7iatrukQaPugVKh6kdqsfVSUETHI0nzd8lx68NVqfdsORiz4bRbE0+BsL3RqmJHXwObA/K5QNco7cfYkc8KZeJgXrY1KtATAgxJyPEnJ0WGVQ5sRpgXB+T6D5VyJT34vD9g/+q6ZkC3JLvJ9nILYOppjai9qJmWxTXAOOAvLsGVlD7mMU9UiQMy2fhgtgAzaoxhUEqYfPzKvuWA8RwSLnds0SN56Em9MANadYtiov0aAWpIdccyHq5dzF7PNAG0WVyo0mzTqmNkR3h9MytSMyAhoa6QQVwkM2/y9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lskyuNNyneXLcMFZ1AKjuWNysmKSArN4rkaiZvSc/0=;
 b=nCcLYvbbYoBiveotrkWBNH1zQ0E2SQKi+xAaC8YH8I15FSIBbdkOudfiQvf3gzLKriqpwn+blxvevfV8FKEC+mV+0t6XWlXgJCAZAa02dE/KKSxBPQ/AJwcWgg/TEn4S7s3+QFMUui4YCuS4S+F821lf+RPlzPYWhwfUd124e1KotE8f+nveja2yCG3zXupsKMR2G17ic9SMQ4Ktm3cV9f/wqNMSt1NCwTcHXlCoFM1hIgkeYhKbMu6v4UjoR3X7EnxwGxaLLm5/eY5UWIlLLje90zLuRyAWdoW0j8ViRTNNvib8SQae69CZ8jahK2wEk9cjva+rFy9lUNAqCoWazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lskyuNNyneXLcMFZ1AKjuWNysmKSArN4rkaiZvSc/0=;
 b=ly3Wt4GJPJLrKmo9MO5xUAoMlNiZxviwuGr8kAjb+NEV95XfkW9V0UnvaC1kzJfxSyAwqdB/boM0f6U/MIQs1eYmM4pGe/kv4xgLGf1Sh/fJuo6fFddRnBTiw3DzmZvuEUxFiQVgtHYxQEqQngzb7RAOT5tX5nFrseObTMeiGNU=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4761.namprd03.prod.outlook.com (2603:10b6:5:18d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Wed, 20 May
 2020 08:46:30 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 08:46:30 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "stefan.popa@analog.com" <stefan.popa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: dac: ad5592r-base: Replace indio_dev->mlock with own
 device lock
Thread-Topic: [PATCH] iio: dac: ad5592r-base: Replace indio_dev->mlock with
 own device lock
Thread-Index: AQHWLm6XzQaq6yrnSUmNb9i10wDGsqiwqXGA
Date:   Wed, 20 May 2020 08:46:30 +0000
Message-ID: <918ba21673a4af64c8715e203d16b8a59e6f641b.camel@analog.com>
References: <20200520061819.29056-1-sergiu.cuciurean@analog.com>
In-Reply-To: <20200520061819.29056-1-sergiu.cuciurean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63905849-d44e-4287-ce99-08d7fc9a4ac2
x-ms-traffictypediagnostic: DM6PR03MB4761:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB476129C93C3F7A2574B7FFF7F9B60@DM6PR03MB4761.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8lFyEirQsRrtsTuO13Ca2g+hoR6CntrITZLWLm1ZVVRCHgVEhpV8fz334lupNxTHdK8LfuOlihw1IYnOxHMkpzd6TxivkKSLnp3JL0sXpHvCPtQyEDmPjwnhDZ0+bg3lNtfGf2RfJlDU0B/fTT4Koa/irZEYo5V4/bexpkhU+bVn3ZOgW6jwt6MbHFlaCy6yeNpkCfoBntP7UAIwDYoNM1FxiYQ6w8sC1JmpE53Oxu/6RwXqHJD3gSFRtnpyZEL3j/noJLQ/yxke3pAWi4c7qkUCix/oCCJnoS4rGCQJuVFkxyh1gjm/81YFyzcIfm8SJm4vOU5O8faA6KfOMAh9bo7zbvx1D1FW4p1qgWRUiaHGohXQHYWAojQ4J/q18mMwnkyu8xxfTACLZLISuTIS1z1baXaeBEB/vYD3+7KyRzvCxL8bMTtfI1mk9iNa02+0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(366004)(396003)(39860400002)(8676002)(5660300002)(54906003)(36756003)(66946007)(91956017)(71200400001)(316002)(4326008)(86362001)(76116006)(2616005)(6486002)(2906002)(478600001)(66556008)(110136005)(186003)(6506007)(66476007)(26005)(8936002)(66446008)(64756008)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7eBZHT1fqT9+66Wv/MHzk+eDU5auK3pQedXb4xXHrGtsIiETHxFPw2AVrl/EesQLjNFdabbvxNodGiAJqjxm8v7pd9iU4u41b+lqg0HNKUcNrdOc2uggYpc1BAKFmDA6v6fF/ktLHOC+e7zR4d3y8bG+YBQQbI6IKG55+3hrMY3yS7W9E9TZH5Kgc+L/7Pbn+iLsJQQwSs48L3Y1Vmy9rTLtqXI1lh/fV6YcJjwZCepM8DPwwNw4tExVvk93CfrZhapzO/4LhTa2JQPNbjepB/1ng8sAsIoXDQyKzXkrr+MYx7JQKbDcthU1An/AQoozbS+dAPRNWuhwLsKsHKtE6QF4ScOsIYiIqthd6zwOHpXBSOwo2WvHUJ32cOMSwO5fc5ECrRE0RtQIVm8JEecaKpiu74sGPTtg5eU1GG3WU3IjuSYzzP189W/rkruCDUjff6LupDV9ZKnPpibPnAUykUkU/M7cewuAHhAJ+n/+uReVfVbFITZ2gDkQ8h9QFB19
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AADB9673315A24D9EED44E4F64E9DCD@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63905849-d44e-4287-ce99-08d7fc9a4ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 08:46:30.4539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqrUoPCUirNpwu5ZXgg6TRZNUuJD8f9C+Dt0QqjcGFig2h9Th2soEsHhjj4zMQCKd8FtNPhkYhnoaOmOu6/J3W9N5vtw+tJux3Tdyh+23Lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4761
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_03:2020-05-19,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=872
 mlxscore=0 cotscore=-2147483648 clxscore=1015 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200077
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTIwIGF0IDA5OjE4ICswMzAwLCBTZXJnaXUgQ3VjaXVyZWFuIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBBcyBwYXJ0IG9mIHRoZSBnZW5lcmFsIGNsZWFudXAgb2Yg
aW5kaW9fZGV2LT5tbG9jaywgdGhpcyBjaGFuZ2UgcmVwbGFjZXMNCj4gaXQgd2l0aCBhIGxvY2Fs
IGxvY2sgb24gdGhlIGRldmljZSdzIHN0YXRlIHN0cnVjdHVyZS4NCj4gDQoNClRoaXMgcmVxdWly
ZXMgYSBWMi4NCkl0IHByb2R1Y2VzIGEgd2FybmluZzoNCg0KICAxNTkgfCAgc3RydWN0IGlpb19k
ZXYgKmlpb19kZXYgPSBpaW9fcHJpdl90b19kZXYoc3QpOw0KICAgICAgfCAgICAgICAgICAgICAg
ICAgIF5+fn5+fn4NCmRyaXZlcnMvaWlvL2RhYy9hZDU1OTJyLWJhc2UuYzogSW4gZnVuY3Rpb24g
4oCYYWQ1NTkycl9zZXRfY2hhbm5lbF9tb2Rlc+KAmToNCmRyaXZlcnMvaWlvL2RhYy9hZDU1OTJy
LWJhc2UuYzoyMDA6MTg6IHdhcm5pbmc6IHVudXNlZCB2YXJpYWJsZSDigJhpaW9fZGV24oCZDQpb
LVd1bnVzZWQtdmFyaWFibGVdDQogIDIwMCB8ICBzdHJ1Y3QgaWlvX2RldiAqaWlvX2RldiA9IGlp
b19wcml2X3RvX2RldihzdCk7DQoNCg0KWW91IGNhbiByZW1vdmUgYm90aCBpbnN0YW5jZXMgb2YN
CiBzdHJ1Y3QgaWlvX2RldiAqaWlvX2RldiA9IGlpb19wcml2X3RvX2RldihzdCk7DQoNCg0KPiBT
aWduZWQtb2ZmLWJ5OiBTZXJnaXUgQ3VjaXVyZWFuIDxzZXJnaXUuY3VjaXVyZWFuQGFuYWxvZy5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vZGFjL2FkNTU5MnItYmFzZS5jIHwgMjggKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9paW8vZGFjL2FkNTU5MnItYmFzZS5o
IHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9kYWMvYWQ1NTkyci1iYXNlLmMg
Yi9kcml2ZXJzL2lpby9kYWMvYWQ1NTkyci0NCj4gYmFzZS5jDQo+IGluZGV4IGUyMTEwMTEzZTg4
NC4uMTAxMDllYjgxZGIyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9kYWMvYWQ1NTkyci1i
YXNlLmMNCj4gKysrIGIvZHJpdmVycy9paW8vZGFjL2FkNTU5MnItYmFzZS5jDQo+IEBAIC0xNjYs
MTAgKzE2NiwxMCBAQCBzdGF0aWMgaW50IGFkNTU5MnJfcmVzZXQoc3RydWN0IGFkNTU5MnJfc3Rh
dGUgKnN0KQ0KPiAgCQl1ZGVsYXkoMSk7DQo+ICAJCWdwaW9kX3NldF92YWx1ZShncGlvLCAxKTsN
Cj4gIAl9IGVsc2Ugew0KPiAtCQltdXRleF9sb2NrKCZpaW9fZGV2LT5tbG9jayk7DQo+ICsJCW11
dGV4X2xvY2soJnN0LT5sb2NrKTsNCj4gIAkJLyogV3JpdGluZyB0aGlzIG1hZ2ljIHZhbHVlIHJl
c2V0cyB0aGUgZGV2aWNlICovDQo+ICAJCXN0LT5vcHMtPnJlZ193cml0ZShzdCwgQUQ1NTkyUl9S
RUdfUkVTRVQsIDB4ZGFjKTsNCj4gLQkJbXV0ZXhfdW5sb2NrKCZpaW9fZGV2LT5tbG9jayk7DQo+
ICsJCW11dGV4X3VubG9jaygmc3QtPmxvY2spOw0KPiAgCX0NCj4gIA0KPiAgCXVkZWxheSgyNTAp
Ow0KPiBAQCAtMjQ3LDcgKzI0Nyw3IEBAIHN0YXRpYyBpbnQgYWQ1NTkycl9zZXRfY2hhbm5lbF9t
b2RlcyhzdHJ1Y3QNCj4gYWQ1NTkycl9zdGF0ZSAqc3QpDQo+ICAJCX0NCj4gIAl9DQo+ICANCj4g
LQltdXRleF9sb2NrKCZpaW9fZGV2LT5tbG9jayk7DQo+ICsJbXV0ZXhfbG9jaygmc3QtPmxvY2sp
Ow0KPiAgDQo+ICAJLyogUHVsbCBkb3duIHVudXNlZCBwaW5zIHRvIEdORCAqLw0KPiAgCXJldCA9
IG9wcy0+cmVnX3dyaXRlKHN0LCBBRDU1OTJSX1JFR19QVUxMRE9XTiwgcHVsbGRvd24pOw0KPiBA
QCAtMjg1LDcgKzI4NSw3IEBAIHN0YXRpYyBpbnQgYWQ1NTkycl9zZXRfY2hhbm5lbF9tb2Rlcyhz
dHJ1Y3QNCj4gYWQ1NTkycl9zdGF0ZSAqc3QpDQo+ICAJCXJldCA9IC1FSU87DQo+ICANCj4gIGVy
cl91bmxvY2s6DQo+IC0JbXV0ZXhfdW5sb2NrKCZpaW9fZGV2LT5tbG9jayk7DQo+ICsJbXV0ZXhf
dW5sb2NrKCZzdC0+bG9jayk7DQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiBAQCAtMzE0
LDExICszMTQsMTEgQEAgc3RhdGljIGludCBhZDU1OTJyX3dyaXRlX3JhdyhzdHJ1Y3QgaWlvX2Rl
dg0KPiAqaWlvX2RldiwNCj4gIAkJaWYgKCFjaGFuLT5vdXRwdXQpDQo+ICAJCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gIA0KPiAtCQltdXRleF9sb2NrKCZpaW9fZGV2LT5tbG9jayk7DQo+ICsJCW11dGV4
X2xvY2soJnN0LT5sb2NrKTsNCj4gIAkJcmV0ID0gc3QtPm9wcy0+d3JpdGVfZGFjKHN0LCBjaGFu
LT5jaGFubmVsLCB2YWwpOw0KPiAgCQlpZiAoIXJldCkNCj4gIAkJCXN0LT5jYWNoZWRfZGFjW2No
YW4tPmNoYW5uZWxdID0gdmFsOw0KPiAtCQltdXRleF91bmxvY2soJmlpb19kZXYtPm1sb2NrKTsN
Cj4gKwkJbXV0ZXhfdW5sb2NrKCZzdC0+bG9jayk7DQo+ICAJCXJldHVybiByZXQ7DQo+ICAJY2Fz
ZSBJSU9fQ0hBTl9JTkZPX1NDQUxFOg0KPiAgCQlpZiAoY2hhbi0+dHlwZSA9PSBJSU9fVk9MVEFH
RSkgew0KPiBAQCAtMzMzLDEyICszMzMsMTIgQEAgc3RhdGljIGludCBhZDU1OTJyX3dyaXRlX3Jh
dyhzdHJ1Y3QgaWlvX2Rldg0KPiAqaWlvX2RldiwNCj4gIAkJCWVsc2UNCj4gIAkJCQlyZXR1cm4g
LUVJTlZBTDsNCj4gIA0KPiAtCQkJbXV0ZXhfbG9jaygmaWlvX2Rldi0+bWxvY2spOw0KPiArCQkJ
bXV0ZXhfbG9jaygmc3QtPmxvY2spOw0KPiAgDQo+ICAJCQlyZXQgPSBzdC0+b3BzLT5yZWdfcmVh
ZChzdCwgQUQ1NTkyUl9SRUdfQ1RSTCwNCj4gIAkJCQkJCSZzdC0+Y2FjaGVkX2dwX2N0cmwpOw0K
PiAgCQkJaWYgKHJldCA8IDApIHsNCj4gLQkJCQltdXRleF91bmxvY2soJmlpb19kZXYtPm1sb2Nr
KTsNCj4gKwkJCQltdXRleF91bmxvY2soJnN0LT5sb2NrKTsNCj4gIAkJCQlyZXR1cm4gcmV0Ow0K
PiAgCQkJfQ0KPiAgDQo+IEBAIC0zNjAsNyArMzYwLDcgQEAgc3RhdGljIGludCBhZDU1OTJyX3dy
aXRlX3JhdyhzdHJ1Y3QgaWlvX2RldiAqaWlvX2RldiwNCj4gIA0KPiAgCQkJcmV0ID0gc3QtPm9w
cy0+cmVnX3dyaXRlKHN0LCBBRDU1OTJSX1JFR19DVFJMLA0KPiAgCQkJCQkJIHN0LT5jYWNoZWRf
Z3BfY3RybCk7DQo+IC0JCQltdXRleF91bmxvY2soJmlpb19kZXYtPm1sb2NrKTsNCj4gKwkJCW11
dGV4X3VubG9jaygmc3QtPmxvY2spOw0KPiAgDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAgCQl9DQo+
IEBAIC0zODIsNyArMzgyLDcgQEAgc3RhdGljIGludCBhZDU1OTJyX3JlYWRfcmF3KHN0cnVjdCBp
aW9fZGV2ICppaW9fZGV2LA0KPiAgDQo+ICAJc3dpdGNoIChtKSB7DQo+ICAJY2FzZSBJSU9fQ0hB
Tl9JTkZPX1JBVzoNCj4gLQkJbXV0ZXhfbG9jaygmaWlvX2Rldi0+bWxvY2spOw0KPiArCQltdXRl
eF9sb2NrKCZzdC0+bG9jayk7DQo+ICANCj4gIAkJaWYgKCFjaGFuLT5vdXRwdXQpIHsNCj4gIAkJ
CXJldCA9IHN0LT5vcHMtPnJlYWRfYWRjKHN0LCBjaGFuLT5jaGFubmVsLA0KPiAmcmVhZF92YWwp
Ow0KPiBAQCAtNDE5LDcgKzQxOSw3IEBAIHN0YXRpYyBpbnQgYWQ1NTkycl9yZWFkX3JhdyhzdHJ1
Y3QgaWlvX2RldiAqaWlvX2RldiwNCj4gIAkJfSBlbHNlIHsNCj4gIAkJCWludCBtdWx0Ow0KPiAg
DQo+IC0JCQltdXRleF9sb2NrKCZpaW9fZGV2LT5tbG9jayk7DQo+ICsJCQltdXRleF9sb2NrKCZz
dC0+bG9jayk7DQo+ICANCj4gIAkJCWlmIChjaGFuLT5vdXRwdXQpDQo+ICAJCQkJbXVsdCA9ICEh
KHN0LT5jYWNoZWRfZ3BfY3RybCAmDQo+IEBAIC00MzcsNyArNDM3LDcgQEAgc3RhdGljIGludCBh
ZDU1OTJyX3JlYWRfcmF3KHN0cnVjdCBpaW9fZGV2ICppaW9fZGV2LA0KPiAgCWNhc2UgSUlPX0NI
QU5fSU5GT19PRkZTRVQ6DQo+ICAJCXJldCA9IGFkNTU5MnJfZ2V0X3ZyZWYoc3QpOw0KPiAgDQo+
IC0JCW11dGV4X2xvY2soJmlpb19kZXYtPm1sb2NrKTsNCj4gKwkJbXV0ZXhfbG9jaygmc3QtPmxv
Y2spOw0KPiAgDQo+ICAJCWlmIChzdC0+Y2FjaGVkX2dwX2N0cmwgJiBBRDU1OTJSX1JFR19DVFJM
X0FEQ19SQU5HRSkNCj4gIAkJCSp2YWwgPSAoLTM0MzY1ICogMjUpIC8gcmV0Ow0KPiBAQCAtNDUw
LDcgKzQ1MCw3IEBAIHN0YXRpYyBpbnQgYWQ1NTkycl9yZWFkX3JhdyhzdHJ1Y3QgaWlvX2RldiAq
aWlvX2RldiwNCj4gIAl9DQo+ICANCj4gIHVubG9jazoNCj4gLQltdXRleF91bmxvY2soJmlpb19k
ZXYtPm1sb2NrKTsNCj4gKwltdXRleF91bmxvY2soJnN0LT5sb2NrKTsNCj4gIAlyZXR1cm4gcmV0
Ow0KPiAgfQ0KPiAgDQo+IEBAIC02MjUsNiArNjI1LDggQEAgaW50IGFkNTU5MnJfcHJvYmUoc3Ry
dWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyDQo+ICpuYW1lLA0KPiAgCWlpb19kZXYtPmluZm8g
PSAmYWQ1NTkycl9pbmZvOw0KPiAgCWlpb19kZXYtPm1vZGVzID0gSU5ESU9fRElSRUNUX01PREU7
DQo+ICANCj4gKwltdXRleF9pbml0KCZzdC0+bG9jayk7DQo+ICsNCj4gIAlhZDU1OTJyX2luaXRf
c2NhbGVzKHN0LCBhZDU1OTJyX2dldF92cmVmKHN0KSk7DQo+ICANCj4gIAlyZXQgPSBhZDU1OTJy
X3Jlc2V0KHN0KTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2RhYy9hZDU1OTJyLWJhc2Uu
aCBiL2RyaXZlcnMvaWlvL2RhYy9hZDU1OTJyLQ0KPiBiYXNlLmgNCj4gaW5kZXggNDc3NGU0Y2Q5
YzExLi4yM2RhYzJmMWZmOGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2RhYy9hZDU1OTJy
LWJhc2UuaA0KPiArKysgYi9kcml2ZXJzL2lpby9kYWMvYWQ1NTkyci1iYXNlLmgNCj4gQEAgLTUy
LDYgKzUyLDcgQEAgc3RydWN0IGFkNTU5MnJfc3RhdGUgew0KPiAgCXN0cnVjdCByZWd1bGF0b3Ig
KnJlZzsNCj4gIAlzdHJ1Y3QgZ3Bpb19jaGlwIGdwaW9jaGlwOw0KPiAgCXN0cnVjdCBtdXRleCBn
cGlvX2xvY2s7CS8qIFByb3RlY3QgY2FjaGVkIGdwaW9fb3V0LCBncGlvX3ZhbCwNCj4gZXRjLiAq
Lw0KPiArCXN0cnVjdCBtdXRleCBsb2NrOw0KPiAgCXVuc2lnbmVkIGludCBudW1fY2hhbm5lbHM7
DQo+ICAJY29uc3Qgc3RydWN0IGFkNTU5MnJfcndfb3BzICpvcHM7DQo+ICAJaW50IHNjYWxlX2F2
YWlsWzJdWzJdOw0K
