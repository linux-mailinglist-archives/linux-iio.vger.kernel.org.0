Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9D21E3718
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 06:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgE0EXH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 00:23:07 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25352 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725681AbgE0EXH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 00:23:07 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04R4ILjB013113;
        Wed, 27 May 2020 00:22:48 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3170r63mph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 00:22:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9hE35q9xGyT2ADnECzg5qBpBS0inXpv1EuwHB8gKqZUZoSjf9OskqiV5MGu0CMnyfSRAc5gV+pHhWqFKMNjvOVp2bFHSiXzfc2ajjJVSNk7AMbyHzazEv4qPJRfa6mtn9iCiDD5PbLNFSF05/YsSkuEUMUGRaL3psL2BknrG1cZ5WgubHqtkUcCf0syZfWRpybsuPykY8vN7G0hRaX8zPVlG1VbFQJs5NNLJQTVmB1/dzBRfzxhwdCJ1MFisZLWml/3x7miQy5aFmYnkNt0pR8sVtbDOLe1X4BLoPJwCKL+JktUycVyvK5085xR7tsPn7pFEHQhbFiLS5yojFIRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy7nHrleuM+uHDgNHq4FHgBXMAMAKC0b+nXidb5wq/4=;
 b=kNmwDnLLa81RA0rngbymd3sSZsxGIJH/iufIuUPwZs6Af/h/e8bR2QMNfLikI9d/BUROYHraEyBP1ad/ZGR5alTXl4O88NphxI1+uZKbfI9C8+geRUm8WjHRbr1CWLFYa6GXQWPm7PouI2uN1XH+r1I3ehOKdRCbckM7LCtJpU2sew5IirvTBwvtBUs6n9hmQtc/qeXyFcoVezB8RWVVqD38BySpBuyDmmbeDphRBQfHxTz7oYSlGsJ9O/RUlTVgyIM0Nbdbd6b/62cyaAHd5V+zi6J3B+2vvtBZND9LQz7SJehBzchsUdSczCVkAXjm14pNQT2A0aTMxTwHNYvTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy7nHrleuM+uHDgNHq4FHgBXMAMAKC0b+nXidb5wq/4=;
 b=x04bojulhsrkge6PWiNx/IMsov+kpSYiU+w/4caDTRq8x8Bcu3+U34gqLlUEvqnuoL/DzD2XJHivKpj3GwBVP4jgk1vtvGKkkgI+1SFiMwNWab6+ikAL/pVkfD+nsZE5TnCGmaOB1NgtfhvNbN1j5V2je8d3CpjeO6e2C0toECg=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4281.namprd03.prod.outlook.com (2603:10b6:5:a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.27; Wed, 27 May 2020 04:22:47 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 04:22:47 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] iio: dac: ad5592r-base: Constify struct
 iio_chan_spec_ext_info
Thread-Topic: [PATCH 3/6] iio: dac: ad5592r-base: Constify struct
 iio_chan_spec_ext_info
Thread-Index: AQHWM6EXHGGuRTKLBEOh3vkODiiyg6i7VasA
Date:   Wed, 27 May 2020 04:22:46 +0000
Message-ID: <efde021ebc6da585f030adde11fbb31c5cdca3a1.camel@analog.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
         <20200526210223.1672-4-rikard.falkeborn@gmail.com>
In-Reply-To: <20200526210223.1672-4-rikard.falkeborn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bcb19dc2-f5ae-4994-65b4-08d801f59c1a
x-ms-traffictypediagnostic: DM6PR03MB4281:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB4281004607AF7593F2B77597F9B10@DM6PR03MB4281.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2yr/yBJGymDYd2iT+GnOJw9OCsWER1tjzgWSA6pzOf0panHKp5NRH3g8NNhOJhscUPa9yoncc0Trm7S7noDEivsbjfbqxxEj88vafEY00++7DxFgaAKOH1T3GUbkCSb/31HbC1/6MEMQTkuI18pqpmLkzBLwppRL+XKCIZ7iRRG6ujsGfvQo8IW++ygYy9mv20M5BG767efYeRv6Bhue6nUpN1DzqF8ZVs7x5NuPHsO2glDdNi8E23mDYjR3juwcbIr1hCVbd358DSoKkJI/AkfR5zOIhxf2rL2TmIkPdJWGX1GJUR31153gkWNZ7atn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(366004)(346002)(396003)(39850400004)(478600001)(66556008)(6506007)(64756008)(4326008)(66446008)(66946007)(66476007)(86362001)(110136005)(316002)(91956017)(76116006)(54906003)(2616005)(71200400001)(8936002)(186003)(26005)(2906002)(5660300002)(6512007)(36756003)(8676002)(6486002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uZ7FCbO8aDy4n7UqUI+/Utu7f5wQrCQXzVBSSH99qzsLKwZf9Bs0zR3DA+umFh3Ho/XSfRJPMWM2XXWxtnmWyUq0eX0X25W0wx0ON56wiIpZZTpI7KD0QK4Pc5hNHxSI5/SVqSFwRkwio/TYLAzCY7zO55f2E7uy+NLmkN5lWz+Ray69qJo00WHTaQAKwpDJd7D/qJzehKqKuj5iK9LWbMB29aPLsYA80tyUCfvsdn8+Cebc6g3n51Pfk5L4KGLmS6NSZK1EIGO4MF7yVGAI41ACLFn9kpOSU5QcryJX0ChM5t28KdbUoHedob8HKFuK9LQ1bP9UxniTlbrIBLz+/C/NNNXQQe+JUL6hCr7sJHCQyQkBpdHAf89QfDsUj2ufKlX6i6mr0J5KWdNz4p1mJ060D0H7dYf4ejcIwCcOEC7izUC9L0GRNjufFhKc4JJF06K5T4jRZYNSRSSioTZSVxgcq+Q8soqq/W3s9B1FEhvCMKDVYUC/vTIiQ8fvEoS/
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A422179825980429FDD241A73CCF844@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb19dc2-f5ae-4994-65b4-08d801f59c1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 04:22:46.9276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+7rxvQAR5IU1Zc8X1p9MYuiV6scZdjRS3tbg2pnh8unmrE6sOx6VKCnBhulceefid3n2NOe/8wssc3CTerfDqnedfccy55819hqSCV/6U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4281
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_01:2020-05-26,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=740 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1015 cotscore=-2147483648 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270029
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTA1LTI2IGF0IDIzOjAyICswMjAwLCBSaWthcmQgRmFsa2Vib3JuIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBhZDU1OTJyX2V4dF9pbmZvIGlzIG5vdCBtb2RpZmllZCBh
bmQgY2FuIGJlIG1hZGUgY29uc3QgdG8gYWxsb3cgdGhlDQo+IGNvbXBpbGVyIHRvIHB1dCBpdCBp
biByZWFkLW9ubHkgbWVtb3J5Lg0KPiANCj4gQmVmb3JlOg0KPiAgICB0ZXh0ICAgIGRhdGEgICAg
IGJzcyAgICAgZGVjICAgICBoZXggZmlsZW5hbWUNCj4gICAxMzI5MyAgICAyMDg4ICAgICAyNTYg
ICAxNTYzNyAgICAzZDE1IGRyaXZlcnMvaWlvL2RhYy9hZDU1OTJyLWJhc2Uubw0KPiANCj4gQWZ0
ZXI6DQo+ICAgIHRleHQgICAgZGF0YSAgICAgYnNzICAgICBkZWMgICAgIGhleCBmaWxlbmFtZQ0K
PiAgIDEzNDIxICAgIDE5NjAgICAgIDI1NiAgIDE1NjM3ICAgIDNkMTUgZHJpdmVycy9paW8vZGFj
L2FkNTU5MnItYmFzZS5vDQo+IA0KDQpBY2tlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4
YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBSaWthcmQgRmFs
a2Vib3JuIDxyaWthcmQuZmFsa2Vib3JuQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lp
by9kYWMvYWQ1NTkyci1iYXNlLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9kYWMv
YWQ1NTkyci1iYXNlLmMgYi9kcml2ZXJzL2lpby9kYWMvYWQ1NTkyci0NCj4gYmFzZS5jDQo+IGlu
ZGV4IDQxMGU5MGU1Zjc1Zi4uNzQwMmY2N2E1NTFkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lp
by9kYWMvYWQ1NTkyci1iYXNlLmMNCj4gKysrIGIvZHJpdmVycy9paW8vZGFjL2FkNTU5MnItYmFz
ZS5jDQo+IEBAIC00ODQsNyArNDg0LDcgQEAgc3RhdGljIHNzaXplX3QgYWQ1NTkycl9zaG93X3Nj
YWxlX2F2YWlsYWJsZShzdHJ1Y3QNCj4gaWlvX2RldiAqaWlvX2RldiwNCj4gIAkJc3QtPnNjYWxl
X2F2YWlsWzFdWzBdLCBzdC0+c2NhbGVfYXZhaWxbMV1bMV0pOw0KPiAgfQ0KPiAgDQo+IC1zdGF0
aWMgc3RydWN0IGlpb19jaGFuX3NwZWNfZXh0X2luZm8gYWQ1NTkycl9leHRfaW5mb1tdID0gew0K
PiArc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjX2V4dF9pbmZvIGFkNTU5MnJfZXh0
X2luZm9bXSA9IHsNCj4gIAl7DQo+ICAJIC5uYW1lID0gInNjYWxlX2F2YWlsYWJsZSIsDQo+ICAJ
IC5yZWFkID0gYWQ1NTkycl9zaG93X3NjYWxlX2F2YWlsYWJsZSwNCg==
