Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9846CE98FC
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2019 10:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfJ3JN5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Oct 2019 05:13:57 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:22106 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfJ3JN5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Oct 2019 05:13:57 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9U97bG6027349;
        Wed, 30 Oct 2019 05:13:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vxwh5h6ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 05:13:53 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id x9U98H4s027946;
        Wed, 30 Oct 2019 05:13:52 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2056.outbound.protection.outlook.com [104.47.48.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vxwh5h6ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 05:13:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2w0UYJVBvDycI6qVRKufqSg8dzXyEL737Up53p40gSHTPi5xtt8qJ7x2NLiWndK1MyvAbDcTmH7qo5ilcQ8PMWAGPj80gP5x7BeyD89xbW+PjmZnjrY5/orBBX++7lG1Fpj6CZ3q0WaRTFJIpQgivYxLihy5HREX3yw2bQEuLHXmNQTJj7M37nzvZBnXmgSRw+hxihO0DkR94/HRzz5mBO7SHRg17xa9OVDT+Z9Yo3OGOYwXTt4t6yMUxEKkkzB2JKBWrp93JFsNMKqy9J60zkaLgnZclHHBzvHf+xDYdqae5K3C9vJFWfFmmTINROXl1lYytW5iiVxfPeK6zetKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gHSkk/7VcLlM4lwr4oA+xpTW2e9AFnMoNYcnjp7Gs8=;
 b=N8H7xAnngwa7JWqDWzaCJMU/drFoNAP7qGnL7EkiqfJxm2OUt4k2noFIzwZjIoocP4+ouw92RD6Hvc42t1gY3C7U8ln27kkcFATq48zxSvjgGEfN+n1KqNhTGi+K1D7VV5W73A3J0u8hxj9G/NZlfAsWlPAfe924YckB+e23eb9GEjj2S5YB9m6mUVxYe0kVteeKomqBfwfmCe4dLBRp0ZQ9DLVUF7y4MWLoeA5SUGeiiHUE1tKT6tVsRn69BTFm5i8ac6osW2ozJVUKoDjf7UUAKn9nJap4mCLMXYa61XaeY+b/sJalGZ2oDDqsl44KqONjZY436/FVetMpj0fjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gHSkk/7VcLlM4lwr4oA+xpTW2e9AFnMoNYcnjp7Gs8=;
 b=oVt0sED9F2ccnI8JQvmsExFGoY+lw3DmJQ/s84dj3l1Pzl30k/OIAwTUe1OKSSW2zuaDRbV3gMu/0/LdQB/RRLnOL9Tlh4+kXDdp6v5oBhQG4ok0tq9cqiF789p2iUaIqPiOGzwm0QHCDXipy45DDSnRRjhf7O+ibPv92Kx7PZQ=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5157.namprd03.prod.outlook.com (20.180.15.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 09:13:44 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 09:13:44 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "zhongjiang@huawei.com" <zhongjiang@huawei.com>
CC:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE to
 define debugfs fops
Thread-Topic: [PATCH 2/2] iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE to
 define debugfs fops
Thread-Index: AQHVjvtvMo3TRSbgd0mq4a0nRuTfD6dy5rCA
Date:   Wed, 30 Oct 2019 09:13:44 +0000
Message-ID: <8bb174ac8805759ce45eddaaec300078c95de5a2.camel@analog.com>
References: <1572423581-59762-1-git-send-email-zhongjiang@huawei.com>
         <1572423581-59762-3-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1572423581-59762-3-git-send-email-zhongjiang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6bd43ad9-cd8a-4c9e-042a-08d75d1976ca
x-ms-traffictypediagnostic: CH2PR03MB5157:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5157C921B2610E7987534F23F9600@CH2PR03MB5157.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(189003)(199004)(229853002)(4326008)(118296001)(6246003)(8676002)(66476007)(66066001)(76176011)(54906003)(6506007)(66946007)(6512007)(4001150100001)(102836004)(36756003)(26005)(110136005)(186003)(99286004)(66446008)(6116002)(5660300002)(8936002)(7736002)(76116006)(81156014)(6486002)(305945005)(3846002)(66556008)(64756008)(86362001)(81166006)(6436002)(486006)(2906002)(256004)(71190400001)(11346002)(476003)(25786009)(446003)(71200400001)(2616005)(316002)(14454004)(478600001)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5157;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZCam+LV8C3etLICCILuxW7f1eFeaMLtQ60zWtfJZwaIUUjxrLG9BrsBjEr9mZ+2O2Tf/gOxzdKqHXrGD8uhI70CIprvESOqF+Kl9AdogwArpjJ4XCM43yvJK1UNPjMqjHS65nO4fK8mbI/rfexjwHebr9GvrY/Osydy5A8D4qcGGlpZOyHIzgmAMDJEsyrmmeIHkbdJnmg/HhiXs/kbt+H3nM9SxjPV9rgomAICr8LfLDkuIA1QsXLmHBI/lDxiBbViecDzjFvAiKBNFRChl5DakZMcfX7ndLuAmz1utOuRsDpciVEQaRbY/Zm5K6poF4IHYneTivHl9DeJ4oe1nuj69hpYH6cyLiPw+1rRwzCndFjYAOFzUxRegh1zmXLRaCjJ5U8e5SRSyzWtzI+3g7O/nGFzKY/EAQcuecUUxBObIJvVXU8AcOEKTZsR30lj
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ED005EECF15D348A89FE25148B4AD4F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd43ad9-cd8a-4c9e-042a-08d75d1976ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 09:13:44.3695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/EJyOs+5CmzmDYCN2UP1sP79YoHKJlkunrXvfHEJb+wP+hLn/gHZnqgWF6b8pFUJCKqNop577hqCoBU/YA2n04PqVI2A5FitYr2z7e+QuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5157
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_04:2019-10-30,2019-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910300092
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTMwIGF0IDE2OjE5ICswODAwLCB6aG9uZyBqaWFuZyB3cm90ZToNCj4g
W0V4dGVybmFsXQ0KPiANCj4gSXQgaXMgbW9yZSBjbGVhciB0byB1c2UgREVGSU5FX0RFQlVHRlNf
QVRUUklCVVRFIHRvIGRlZmluZSBkZWJ1Z2ZzIGZpbGUNCj4gb3BlcmF0aW9uIHJhdGhlciB0aGFu
IERFRklORV9TSU1QTEVfQVRUUklCVVRFLg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZHJ1IEFyZGVs
ZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogemhvbmcgamlhbmcgPHpob25namlhbmdAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2lpby9pbXUvYWRpczE2NDAwLmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8v
aW11L2FkaXMxNjQwMC5jIGIvZHJpdmVycy9paW8vaW11L2FkaXMxNjQwMC5jDQo+IGluZGV4IDA1
NzVmZjcuLjgxOTViYzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0MDAu
Yw0KPiArKysgYi9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDAwLmMNCj4gQEAgLTI1Niw3ICsyNTYs
NyBAQCBzdGF0aWMgaW50IGFkaXMxNjQwMF9zaG93X3Byb2R1Y3RfaWQodm9pZCAqYXJnLCB1NjQN
Cj4gKnZhbCkNCj4gIA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAtREVGSU5FX1NJTVBMRV9BVFRS
SUJVVEUoYWRpczE2NDAwX3Byb2R1Y3RfaWRfZm9wcywNCj4gK0RFRklORV9ERUJVR0ZTX0FUVFJJ
QlVURShhZGlzMTY0MDBfcHJvZHVjdF9pZF9mb3BzLA0KPiAgCWFkaXMxNjQwMF9zaG93X3Byb2R1
Y3RfaWQsIE5VTEwsICIlbGxkXG4iKTsNCj4gIA0KPiAgc3RhdGljIGludCBhZGlzMTY0MDBfc2hv
d19mbGFzaF9jb3VudCh2b2lkICphcmcsIHU2NCAqdmFsKQ0KPiBAQCAtMjczLDcgKzI3Myw3IEBA
IHN0YXRpYyBpbnQgYWRpczE2NDAwX3Nob3dfZmxhc2hfY291bnQodm9pZCAqYXJnLCB1NjQNCj4g
KnZhbCkNCj4gIA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAtREVGSU5FX1NJTVBMRV9BVFRSSUJV
VEUoYWRpczE2NDAwX2ZsYXNoX2NvdW50X2ZvcHMsDQo+ICtERUZJTkVfREVCVUdGU19BVFRSSUJV
VEUoYWRpczE2NDAwX2ZsYXNoX2NvdW50X2ZvcHMsDQo+ICAJYWRpczE2NDAwX3Nob3dfZmxhc2hf
Y291bnQsIE5VTEwsICIlbGxkXG4iKTsNCj4gIA0KPiAgc3RhdGljIGludCBhZGlzMTY0MDBfZGVi
dWdmc19pbml0KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo=
