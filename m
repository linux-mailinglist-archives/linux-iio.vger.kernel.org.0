Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D353BB5DB6
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 09:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfIRHBQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 03:01:16 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:63950 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728047AbfIRHBP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 03:01:15 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8I6xKix005639;
        Wed, 18 Sep 2019 03:00:45 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2055.outbound.protection.outlook.com [104.47.32.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v37jg0xf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 03:00:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOkZX1WNmheHg5ilLvKrsfdt6Eeas8tKlkAtgL+m8Erxq2co2QQVejQLZ2emGDPGxcqRrm68q2eXr89cr6FLxRn08L6SyyXrXpLyCnoer9ALm4wg9nLJWPgiGXIYAlPwxm8OIdVsQ9MoIMccEmvWXOZfDkFjm7MBH0hWj6+6/C93Gx7nJfjx/n+SG5rWDH6/HtWx2xkOAzQOpv8OZO00z24feeUdW0C/XDiyUxgUSA9kKGdEYBv8MqQ5nmtaORu3eKTl+mU1KYDJGdsx+8haW5efBu6cyruUK6dQAvlokAZ0jxdvFbkdUPkrsoYbwopRaHYuZPYAl4m04GFe/YDjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=830vdoMp+CQH3tORVEBcEIqbUEn+f1FHSPFzfo7rzrY=;
 b=Dtf27oiOjsk5KkTVlSijfwB8H34qoEjKj5lgP37p2vrViewczb+NprAgOcIoReygT7MRsMtaoX3ZE3u6AvgjZ2uh1qOlsjSz01E5F2FvVLpaLHRhVpTDthxofWuzn2wUDbQzQtGf+88+jg3E8SyJKSnoyEROTA8GE/JgzLmawAHBtRx4nCKqWMb/ZxQMxOTR/YrWqx+6wLOAuQnzl7kl8AUIcVFbN7rQmoOHCpNnlIyEsdG2k00W9L3y622u73pwE1vFKgEJjtf2fETjhCzHULrw0Q1yzxL+SWjcF4pZLYna61OGnujft1TBu7yEQ5JgVZrqh9b6MWECzPXxfwxOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=830vdoMp+CQH3tORVEBcEIqbUEn+f1FHSPFzfo7rzrY=;
 b=Z++vlQqZVx4g2BQPLrORVa9So8TbBqqnr+fMq2QJOG5vEYy0G6zcCJifrSWBMP7vYqzHDMuuD1Czl7Isb+u70xqf6cAtmrcRVenYxv2o40fo+cDGcDkbZ1AqB9Ll2X2lJZjYjj0YiafgQHhvLbClOO52VZT+ML9IwlMTKrdil8k=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5207.namprd03.prod.outlook.com (20.180.15.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 07:00:43 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 07:00:43 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/3] ADC AD799x improvements
Thread-Topic: [PATCH 0/3] ADC AD799x improvements
Thread-Index: AQHVbXJxfaKWVZENRkKePPozLOpjBacxNPUA
Date:   Wed, 18 Sep 2019 07:00:43 +0000
Message-ID: <4cab6e664f65d890d9dc7cf03b12eb2ff9f396e1.camel@analog.com>
References: <20190917160925.9791-1-m.felsch@pengutronix.de>
In-Reply-To: <20190917160925.9791-1-m.felsch@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce2c370b-249b-48ac-6681-08d73c05ec48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5207;
x-ms-traffictypediagnostic: CH2PR03MB5207:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5207CEEE8D9CDA80268A150AF98E0@CH2PR03MB5207.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(51914003)(66556008)(6246003)(4326008)(5660300002)(64756008)(66476007)(446003)(66946007)(66066001)(4744005)(229853002)(118296001)(3846002)(102836004)(6436002)(99286004)(6486002)(76176011)(2906002)(186003)(66446008)(25786009)(6512007)(26005)(6116002)(6506007)(2201001)(2501003)(316002)(110136005)(54906003)(86362001)(7736002)(71200400001)(71190400001)(8936002)(81166006)(81156014)(8676002)(76116006)(256004)(476003)(11346002)(2616005)(14454004)(486006)(14444005)(305945005)(478600001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5207;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ccVyQEq3zEPODyXKttbi9apLyB87lUQL6IRQ2JOSJPAc1hMHq80Ma84k6gI1fVduwjxOO6xh3NzCTKhAbGCTgCzL4c3pA1TIU3GhhqxSX4s2+AzdFYJkidoDSoMPqIhek5tnnXMx2oL8/4cLc8+yAJzWFgzM3zXWy6O3kMSBTZ7miGEtKD9M7mobx7ya4NhrCjb9dGQuFAaUs60ZkUwGOAxWRulzz7Lzdat/UbNLTtDGV5JuZbKIt2hAcHJDNGB61HdpR3l87iXoLdyqAlp0VdlHKGqC0Bl10akhV2Hr9zZe13b8Jwr09+0sVQ0E/0kluXoLYFPGqP9R5BHhuidAsY24c2DzKIQlbG2JxNXRFh4DhbRt8s+wfqeXTzPJ7veIyihzReatnpirwvosu5yMe3Ba4oW4FO2V4Kob0o5Txlo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B83DBA8C9A12E45A04ECBD240DCC72E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2c370b-249b-48ac-6681-08d73c05ec48
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 07:00:43.1543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8USksPEow/hARJ6XgK56o04YGwINbQGF6sd/FeGKaTYf2NtLvOSv8qZ/uLE3qtV3q04O3fZep3cppO8dMqMVYsIhnU3sT+Mzu1A/DglMKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5207
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_05:2019-09-17,2019-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=917 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909180074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTA5LTE3IGF0IDE4OjA5ICswMjAwLCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IEhpLA0KPiANCj4gdGhlIG1haW4gcHVycG9zZSBvZiB0aGlzIHNl
cmllIGlzIHRvIGFkZCB0aGUgcG1fb3BzIHN1cHBvcnQuIFRoaXMgaXMNCj4gaW1wb3J0YW50IHRv
IGZyZWUgdGhlIHJlZ3VsYXRvcnMgd2UgYXJlIHVzaW5nIHdpdGhpbiB0aGUgZHJpdmVyLg0KPiAN
Cg0KSGV5LA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaGVzLg0KVGhlcmUgYXJlIHNvbWUgbWlub3Ig
aXNzdWVzIHdpdGggcGF0Y2ggMyB3aXRoIHJlZ2FyZCB0byBlcnJvciBwYXRocy4NCg0KT3ZlcmFs
bCB0aGV5IGxvb2sgZ29vZC4NCkkgZG8gaGF2ZSBhIGdlbmVyYWwgY29tbWVudCB0aGF0IG1heWJl
IGFkNzk5eF9yZXN1bWUoKSAmIGFkNzk5eF9zdXNwZW5kKCkNCmNvdWxkIGJlIHJlLXVzZWQgaW4g
YWQ3OTl4X3Byb2JlKCkgJiBhZDc5OXhfcmVtb3ZlKCkuDQoNClRoYW5rcw0KQWxleA0KDQoNCj4g
UmVnYXJkcywNCj4gICBNYXJjbw0KPiANCj4gTWFyY28gRmVsc2NoICgzKToNCj4gICBpaW86IGFk
YzogYWQ3OTl4OiBmaXggcHJvYmUgZXJyb3IgaGFuZGxpbmcNCj4gICBpaW86IGFkYzogYWQ3OTl4
OiBmYWN0b3Igb3V0IGNvbmZpZyByZWdpc3RlciB1cGRhdGUNCj4gICBpaW86IGFkYzogYWQ3OTl4
OiBhZGQgcG1fb3BzIHRvIGRpc2FibGUgdGhlIGRldmljZSBjb21wbGV0ZWx5DQo+IA0KPiAgZHJp
dmVycy9paW8vYWRjL2FkNzk5eC5jIHwgNzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQo+IA0K
