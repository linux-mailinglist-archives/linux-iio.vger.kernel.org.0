Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6A1B8B3A
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2019 08:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfITGqh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Sep 2019 02:46:37 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:63332 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730573AbfITGqh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Sep 2019 02:46:37 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8K6gmuq016433;
        Fri, 20 Sep 2019 02:46:07 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2056.outbound.protection.outlook.com [104.47.41.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v3vb2c82x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 02:46:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRGdaIpaqxaDHGWBBOibFDi7zblPUaLN+MmAPEK0Is8/ddyrU6i1hhZP22xyK5WGAHHbgM47X4QkdGY3UVWtZq9oah3MIBb5D/OiYq125xCDn3wcH6T8FmBd34ZdoFq/s17jxU5ytMzXogZ6YVbZlj4KdDkBRUAK4GFHJ4kyQ2EJnkR0PAoStx42sUyO1apPHMjwUKPrXPNVGkJsrv0MCKXnln38CF0h0XfpyR0PQUq+xTEBVzgs7pGtu5Sy+tlh5u6P0bFm4fbWUCInaX87jvpGiepgaYcj4kWejB0ZbwUT1wSAvDvqvW7U61sxxQBiT8KRytFdOJgvz3D3wFV3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeL8hL6PN3ieW05fmC4FesP0QBEFsZ9ug4lVCMvk4U4=;
 b=Pcq5qanKWG2j5xGW347XmtJ46LosdWkCu71Vyi+I/s4RdI7S13JzmvKDzggc4inYRT+fcTkM8rXwHakkmaIgC5lb86sqU4arFKk7Ak4Lrsy/dzDgIAj43eh0LzFUiVANjTMidJDxVAJp6kiqeMzO3+CrBuzEpXOc/4G5IeAsuzTll03lQQ0StEUxe35b9kSFT2UcPXPzf9jLZiMslbfJEN61MHaCGyb9ekRaqVts6lJo6IU4EZMYX4AX8Czmvdeq9sluTQSXFKOWzd+epI3OR9xmDD3F8hQ2peL0BOcdu8b7wnNXzcLpFeFhILd1mWnnR82jTX8ygRsTIaYOvPzLog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeL8hL6PN3ieW05fmC4FesP0QBEFsZ9ug4lVCMvk4U4=;
 b=9kFPmESrOmUrSop25m5o2L8sr86vTZ/eNQTi6mXc3O/17aSxC3qhcRvmii5+HkyCmSgDJIYaw3o0trHUbjHkHvvJSUuUcWJgw/71OocYwAIyMKXsftSa7mTTarZ8tc+oA8tLyKolsGBVau6Z43NG6ijORJI3CHgQILuwyYw6EaE=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5352.namprd03.prod.outlook.com (20.180.15.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 06:46:05 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2284.009; Fri, 20 Sep 2019
 06:46:05 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "navid.emamdoost@gmail.com" <navid.emamdoost@gmail.com>
CC:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "emamd001@umn.edu" <emamd001@umn.edu>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio: imu: adis16400: fix memory leak
Thread-Topic: [PATCH v2] iio: imu: adis16400: fix memory leak
Thread-Index: AQHVbwLdYHo/yPhdTUGs4+xcCQhutqc0UmaA
Date:   Fri, 20 Sep 2019 06:46:05 +0000
Message-ID: <3438e843e2304e22456b4ea83796f1118564b3f4.camel@analog.com>
References: <76a7c8d43f8c03a0549d157bbf278b515cfbc047.camel@analog.com>
         <20190919155636.3241-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190919155636.3241-1-navid.emamdoost@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22c6e7bc-3f55-4afa-ee21-08d73d9635ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5352;
x-ms-traffictypediagnostic: CH2PR03MB5352:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB53524ABFA9131E6B118DF18AF9880@CH2PR03MB5352.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(199004)(189003)(186003)(6512007)(5640700003)(476003)(6486002)(486006)(229853002)(71190400001)(71200400001)(6436002)(66446008)(6506007)(66066001)(66476007)(26005)(76116006)(36756003)(478600001)(66556008)(102836004)(64756008)(2616005)(66946007)(25786009)(14444005)(11346002)(99286004)(2351001)(256004)(446003)(7416002)(76176011)(81156014)(6916009)(5660300002)(86362001)(14454004)(316002)(4326008)(4744005)(8676002)(81166006)(1361003)(2501003)(6116002)(3846002)(118296001)(54906003)(8936002)(305945005)(7736002)(2906002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5352;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jtsyjd5L4xXZZSxkUPQ5fFjDqhSMk9IBg3NqeHJBbP/oKo5VSmFPcX+K7F6nnE8YgiVDTeFr3QV+GU8wrwbmfPsGIiy+J29alFiyLxxvmli1zn/jtL9C7Gp4XALepb5+IeJDyRNdr2qPgWQ2cngAjizvvZKbrQKe7cd2H1+ekLFSRZDkMRlr1/DyvfVq2Od6mPlbXTkHnxK0+plPEMwwR0QnkaU9Z8dKs0H9zpSyrCkxqu7fT/WXqyqJSR5WZhmuk9pp/+8Wdr1srnzDA9p9VMsI0LQOjBEipSG0K40tljM8jOyoJ47347Kungm8cWQZiUpmnaT1nOy6BdmtoQaHVtEbuz+XkYz+jz6Lk1hManY1CjBjgS1AaZzvgwdobFkoCpLHgk8vqYUefAQoWr0miW3Ai+LnRMX8gJFzRyb8RAM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D91F6B6C70037A438699451BEB461F4E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c6e7bc-3f55-4afa-ee21-08d73d9635ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 06:46:05.4348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mfKxgKFFVLXTwR+xs6Yqhln8HD4Rq3X/6O6Qjg9GJRC8si1v5icW7m+zpQDnMZZVrVV0CZxLcX/aodr3NhmthlMxUxrVsERlXWPCaRAhV4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5352
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-20_01:2019-09-19,2019-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909200072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTE5IGF0IDEwOjU2IC0wNTAwLCBOYXZpZCBFbWFtZG9vc3Qgd3JvdGU6
DQo+IEluIGFkaXNfdXBkYXRlX3NjYW5fbW9kZV9idXJzdCwgaWYgYWRpcy0+YnVmZmVyIGFsbG9j
YXRpb24gZmFpbHMgcmVsZWFzZQ0KPiB0aGUgYWRpcy0+eGZlci4NCj4gDQo+IHYyOiBzZXQgYWRp
cy0+eGZlciA9IE5VTEwgdG8gYXZvaWQgYW55IHBvdGVudGlhbCBkb3VibGUgZnJlZS4NCj4gDQoN
ClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFs
b2cuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IE5hdmlkIEVtYW1kb29zdCA8bmF2aWQuZW1hbWRv
b3N0QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9pbXUvYWRpc19idWZmZXIuYyB8
IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUvYWRpc19idWZmZXIuYw0KPiBi
L2RyaXZlcnMvaWlvL2ltdS9hZGlzX2J1ZmZlci5jDQo+IGluZGV4IDlhYzgzNTZkOWE5NS4uNzhm
ZTgzYzFmNGZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvYWRpc19idWZmZXIuYw0K
PiArKysgYi9kcml2ZXJzL2lpby9pbXUvYWRpc19idWZmZXIuYw0KPiBAQCAtMzUsOCArMzUsMTEg
QEAgc3RhdGljIGludCBhZGlzX3VwZGF0ZV9zY2FuX21vZGVfYnVyc3Qoc3RydWN0IGlpb19kZXYN
Cj4gKmluZGlvX2RldiwNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4gIAlhZGlzLT5idWZm
ZXIgPSBremFsbG9jKGJ1cnN0X2xlbmd0aCArIHNpemVvZih1MTYpLCBHRlBfS0VSTkVMKTsNCj4g
LQlpZiAoIWFkaXMtPmJ1ZmZlcikNCj4gKwlpZiAoIWFkaXMtPmJ1ZmZlcikgew0KPiArCQlrZnJl
ZShhZGlzLT54ZmVyKTsNCj4gKwkJYWRpcy0+eGZlciA9IE5VTEw7DQo+ICAJCXJldHVybiAtRU5P
TUVNOw0KPiArCX0NCj4gIA0KPiAgCXR4ID0gYWRpcy0+YnVmZmVyICsgYnVyc3RfbGVuZ3RoOw0K
PiAgCXR4WzBdID0gQURJU19SRUFEX1JFRyhhZGlzLT5idXJzdC0+cmVnX2NtZCk7DQo=
