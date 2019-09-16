Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57EB3AEA
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 15:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbfIPNE4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 09:04:56 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:50188 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732825AbfIPNE4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 09:04:56 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8GD3c2C032011;
        Mon, 16 Sep 2019 09:04:45 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2052.outbound.protection.outlook.com [104.47.50.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v0sy940ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 09:04:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvYshs4xpvv9dUHXQhncNztiM8OxelqXrRMhGM+uVZ7KcYR3jWUaVpk3FHkh6C5tzQTuYFTER6bJ10YriF6xSwboHCBdgxQisG0jbY7ubGDa7e4HOOJpssLpU7NmQK9E0ggLH0LIzf7ocRrDPBa+HT+vP9s796fCTSC6mdi/JFRRYquZ7bW9OVfD2s17sURSVvvSzpbW8lU/7atGaFuNAISwlQFxHjUQujO01CDyexvTDAZdzdDbKpCZ1vEDWsXdVo7d/aUqsd0sthglhjYNy+hulRP1FtnD+5pXiUz+GV6LyUaK385dLRots+VRQ27SfSS7/pGN95e4+1ZwzD4MRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfeMMJPbYZAcXKpxWO09idCTGnT4Y/Xu/vzucFArCPI=;
 b=d/QKZs89AxB5L9zXRv8TPcIhVExI2yqdy5Q1yorm8WGjgJl1EUl+5oT1L0c21xsAVLVWsI+1Y9Y7TInTzErI3D+OYCDhuzpYAqd+M2cvqXGuD1GY2Z03HTwiylo1yvRRdhWxk1jFK7Ol4zCYGEFRtI4qUtYSbeR7/+DmsnJ6yCvvZTgVznvvCc20k0hzT4XzeSVBKjm06rctXgetyWhe6D+xNP3q95D7EAnLbYYO+NikXwwPiupIAtmeS5akbqMAmUx1G1hIe4nOKbGHf1eKlrzSc8ThPB5v5efDhb8g4WtSvkpGRkN3cXRtCnifcmm4Txl5YV0ZuklKiae8ZLzoPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfeMMJPbYZAcXKpxWO09idCTGnT4Y/Xu/vzucFArCPI=;
 b=7XY4FOrA+4zE1HtDWJDmwt1G9LjkhXDM77pWe4K7XspGqRlNzq5XnPi5cCDq01Kv5zrMDnoFLtEln4xVTvCozo9gxcgP8IZZfECqZlwk0AEPG5uGGiAv1ALBVRTdqv7CLeoWhWdKIHYpR89+5koS0SWLSTHGeftFCiTKL+fUmTc=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5269.namprd03.prod.outlook.com (20.180.12.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 16 Sep 2019 13:04:42 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 13:04:42 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "baolin.wang@linaro.org" <baolin.wang@linaro.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>
Subject: Re: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Thread-Topic: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Thread-Index: AQHVag+8uWmQQq3ExEyRd/qnwNwICqcuP2sAgAADYYCAAALHAIAABOiA
Date:   Mon, 16 Sep 2019 13:04:42 +0000
Message-ID: <458cbb212fbd04c157c9861501f51c03ea958302.camel@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
         <20190913114550.956-4-alexandru.ardelean@analog.com>
         <20190916122505.GC4352@sirena.co.uk>
         <ae469c65828443524f9ff0409f1c7a81bf64cf6b.camel@analog.com>
         <20190916124707.GD4352@sirena.co.uk>
In-Reply-To: <20190916124707.GD4352@sirena.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8939395b-52bb-4b6a-37b7-08d73aa670db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR03MB5269;
x-ms-traffictypediagnostic: CH2PR03MB5269:
x-microsoft-antispam-prvs: <CH2PR03MB5269BE0BAE3E579672D045F7F98C0@CH2PR03MB5269.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(396003)(346002)(189003)(199004)(76176011)(5640700003)(6436002)(2616005)(118296001)(229853002)(446003)(7736002)(36756003)(305945005)(8676002)(6512007)(66946007)(66476007)(66556008)(64756008)(66446008)(86362001)(11346002)(5660300002)(81166006)(81156014)(6916009)(6486002)(4326008)(316002)(486006)(3846002)(6116002)(476003)(1730700003)(66066001)(8936002)(2351001)(25786009)(256004)(54906003)(2906002)(186003)(71200400001)(6246003)(102836004)(478600001)(71190400001)(76116006)(14454004)(6506007)(7416002)(26005)(2501003)(99286004)(4744005)(53936002)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5269;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 22GJVKUCLBXhIhs9DrxYQ6911xoz1i2ve2T2K0nwTBNmBSELS6ce/OjVQO8BhuMOpOugKz+0Di6doxduQwXQDS5BGQBIUDPGoDksLFUz+kVNhQdBba2UdWsH0X7yBbdb3NzG1k9n48lh+o4Zrx9jhJhJd1LpqEQfzvjCXcERDAnKZCbEoU85KalxnyuAUq7fPAReaeVwgH/cRXzOaIWF/ptxT2II8MK+i6zQ2eZOsA4KsEdPnDVoj/iGahPXQnGDX2jj6AIDevEdn+my9arHrXx/SpNGEtyyg8u1Q6evUxML1bemvhS+cGPkurn3gH6lgiKxLIsCi6rvE9FfZuGoQYFxujtNVhTgeDjDW8i6LiypWaxCB5GYJAbPj54HLnCSzBvfZWkHg0ryQ/66m9tA7qXJ09nkuXlrg2T4xaZujPI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9A871C55AD7F64187978CE710CCCF5B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8939395b-52bb-4b6a-37b7-08d73aa670db
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 13:04:42.7160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ka4JQAwThyPWodAKoINqRUcSdRj66j+f3pqCF3nC3IgzfSHG8zysZ3Uk7m4OB0KJcX8ecYq3PYo8/wXY0OkQER+Xd40fw6qUSVXWumBBp2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5269
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_06:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=865 bulkscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909160140
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTE2IGF0IDEzOjQ3ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIFNlcCAxNiwgMjAxOSBhdCAxMjozNzoxMlBNICswMDAw
LCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3RlOg0KPiANCj4gPiA+IFRoaXMgYnJlYWtzIHRoZSBi
dWlsZCBhcyB0aGVyZSBpcyBhIHVzZXIgb2YgdGhpcyBpbnRlcmZhY2UuDQo+ID4gQWNrLg0KPiA+
IEpvbmF0aGFuIHBvaW50ZWQgdGhpcyBvdXQuDQo+ID4gVGhlcmUncyBhIFYzIHRoYXQgY2hhbmdl
cyBib3RoIHRoaXMgYW5kIGl0J3MgdXNlciAoaW4gSUlPKS4NCj4gDQo+IFRoYXQgdjMgc2VlbXMg
dG8gYmUgYSBzbWFsbCBzdWJzZXQgb2YgdGhpcyBzZXJpZXM/DQoNCkFjay4NClYzIGlzIHRoZSBm
aXJzdCA0IHBhdGNoZXMgZnJvbSB0aGlzIHNlcmllcy4NCldlbGwsIHBhdGNoZXMgMyAmIDQgYXJl
IHNxdWFzaGVkLg0KDQpJIGFtIDEwMCUgY29udmluY2VkIHRoYXQgdGhlIGVudGlyZSBzZXJpZXMg
aXMgYSBnb29kIGlkZWEuDQpJbiB0aGUgc2Vuc2UgdGhhdCBhIGBzdHJ1Y3Qgc3BpX2RlbGF5YCBt
YXkgYmUgYSBnb29kIGlkZWEsIGJ1dCBhdCB0aGUgc2FtZSB0aW1lLCBpdCBtYXkgYmUgdW4tbmVl
ZGVkLg0KDQpBbGwgSSB3YW50ZWQgdG8gZG8sIHdhcyB0byBhZGQgYW5vdGhlciBkZWxheSBzb21l
d2hlcmUsIGFuZCBnb3QgbG9zdCBpbiB0aGUgcmV3b3JrIG9mIGN1cnJlbnQgZGVsYXlzLg0KSSB0
aG91Z2h0IGFib3V0IHByb3Bvc2luZyBqdXN0IHRoZSBmaXJzdCA0IHBhdGNoZXMgW29uIHRoZWly
IG93bl0sIGJ1dCBJIHRob3VnaHQgdGhhdCBzaG93aW5nIHRoZSBjdXJyZW50IHNlcmllcyBhcy1p
cw0Kbm93LCBtYXkgYmUgYSBnb29kIGlkZWEgYXMgd2VsbCBbdG8gZ2F0aGVyIHNvbWUgZmVlZGJh
Y2tdLg0K
