Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F7F1E3717
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 06:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgE0EWv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 00:22:51 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:41550 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725681AbgE0EWv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 00:22:51 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04R4FSMp015854;
        Wed, 27 May 2020 00:22:32 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2054.outbound.protection.outlook.com [104.47.38.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 316wkb1wjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 00:22:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2n0YBxLvX7WvKQ/2nty5SoS5v3xtWRVB6eD1xnlQRA9Z4bXqAV361zAS+n2/heHI3ynsTAmvbvo6QbZoJq/nH8ojbQJdD7WQiKKgpbPaXv7BXwcVp8LdhiELzGpQuPcv0hz97XnTElf5dP1GwV8lYLmLH2nKCIPnAERA3/EjcCBTx50VP35X5kj5tW9H+5MNXUSQ5nfQFxGA7gN4lJ418MapQoYohR5dqQJQFnvfvJIYr1YaVobTZLCBN7twBeZtG8UYNxtCvnLMhE86oGlKzANGXk5qR/oKdA6lG1/LirAhEjw9ffRQxrvNVwfM+OX9j+n5JkL/Gkgr+AiHwGfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZeg9A6iV9ofWr2oHIAimQ6ghkPnTdNq4AHm95XCyy0=;
 b=aiaaLAOym1AF2W9e0lPKn+67og294Z/9TMkz0ppAsw5hAcrJXz0vVCJWgPESU3ZHZ0te/CUifOO28WJ6WcdD/gs12QbRVIdBy43JA0UuKqwJ+uF+eJHgp2X3hGXmzOB3QrUfmpXtIdDE13B4VYPzAAV71T2TZvnPOCGd8Y01CgBlR8mR1HXd2pR6gFXHCxeqcgIVFKFpSQeEglgx5Ul9KHYzzskpxwdgyUPOSs6dAcoKHEMSesePyT3+TbQIVR2Sfv28WdaKnkglmk+PRjcrY+KfGXa+w3HvM7n8W5uz7TQcOhzs4DpXaG6pK6yccp1A/fEfn/jKyIdqsSuTGe8GVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZeg9A6iV9ofWr2oHIAimQ6ghkPnTdNq4AHm95XCyy0=;
 b=GJDMbgyHsS0dBY9qcIq3hpii0mHV6rUZS9GQwFez1jV/JXuRaO6fQ5IqYPJbo7X7NcHjW6KVGdIMV6NyT0dyMQa9H1G6ldclXgjmTXIU2LvMFrbY7vz+J4Y5XEg8cMtphxtA5Ob/NvOYqX65/vwi4hXNoGLOBscF85wIKHO8blY=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4281.namprd03.prod.outlook.com (2603:10b6:5:a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.27; Wed, 27 May 2020 04:22:30 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 04:22:30 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] iio: dac: ad5380: Constify struct
 iio_chan_spec_ext_info
Thread-Topic: [PATCH 2/6] iio: dac: ad5380: Constify struct
 iio_chan_spec_ext_info
Thread-Index: AQHWM6EYSicDyTMfvkutncZKeSU/eai7VZuA
Date:   Wed, 27 May 2020 04:22:30 +0000
Message-ID: <dfbaa1863b7bc3f69a184bb4d7b7ee7805f06e88.camel@analog.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
         <20200526210223.1672-3-rikard.falkeborn@gmail.com>
In-Reply-To: <20200526210223.1672-3-rikard.falkeborn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6821bcb-c871-4514-f07b-08d801f59249
x-ms-traffictypediagnostic: DM6PR03MB4281:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB42819AE968A561A7A3F438FCF9B10@DM6PR03MB4281.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G/7T8aqafmWF/u5uRklrvlUCNKfkPX03I1QcUhUpHioewBX1cCdb9vBrGpNh8KbkRKNy+Q/OvZEOrsSmppICGuhaVBempIgumL79BA7FqmLjYtP13cwDoEx/aqqsKojKzUd+G5t+xEubVfXrID04QtKbs+oyExUbxeYLrmIYQC/LHJdPBjqheG8QPAH8/8WoCUTEsjI976krEe0PwUW2VcVEncMHEFbBwm2N1eroBXjhAletImRWXPN+p4A69EH5Q3MnpvwYkbfbFfWZ9ShrD/T02I/mRsPOrkoTxsqCMnoTcAhZ6Qg+R0kkAlIn/Ht5FiQtzsWAISoh9gMW4xDSyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(366004)(346002)(396003)(39850400004)(478600001)(66556008)(6506007)(64756008)(4326008)(66446008)(66946007)(66476007)(86362001)(110136005)(316002)(91956017)(76116006)(54906003)(2616005)(71200400001)(8936002)(186003)(26005)(2906002)(5660300002)(6512007)(36756003)(8676002)(6486002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CmY2rmYpgMKzZ5NfeTUd98/ldaVgV+8UQ6yaGDGw5sXpHnEjSQ0GkLiYbi5p0L5w3JnZyjdLP6kgaLTX3dcRQEVTtEkpF9GW012lqwVtwmPN84ywAXQeBJtHWlIwuvNcegBnvgCnS0SjorCR5TdUSW86AHc52LTfuxAlM8X0cNbp+P3t7mKFTt1JP19kEtfkcr4E8BB057p4jGCjCNS6xIm9N3j7iGecrNeqghzbwgJb9ja3cHkPJFa4HFDNAPGjCGl/tYXJHnkBODvj15K25b4VVRchdq/DsekIbpShRvYn9j5g0G9nT4JoG8MaIgv0LmkcB12qlpxKRGWrpaZqRvuIWEYllwFuvkYIJOKiR/CczhmF+QR4/oOm1JB4wXb1hkCS2QdpC3NSHFzPOFAghyPzcW0teWuoKxUDP7ng6wn65U/E+dpzVayWrHuF4osfrD+/tcysC3PA7r9tb7+JmSOKHWWyJASqYi6E7vQ46qLprurkVi6ggdngmfQHUcID
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E2D46C80D164549A2A093E8EE7621FD@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6821bcb-c871-4514-f07b-08d801f59249
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 04:22:30.5110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tH6KG6hX4hVhgMV9LN0OntX+nGllhCBUzoy6WDzOEaPlah+Z4GNbyqnW8cEYxe/2g0TwlflyeK7tU8VNDQadJUNG6N1kVcQl17X+g7q8RxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4281
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_01:2020-05-26,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 cotscore=-2147483648 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=742 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270029
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTA1LTI2IGF0IDIzOjAyICswMjAwLCBSaWthcmQgRmFsa2Vib3JuIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBhZDUzODBfZXh0X2luZm8gaXMgbm90IG1vZGlmaWVkIGFu
ZCBjYW4gYmUgbWFkZSBjb25zdCB0byBhbGxvdyB0aGUNCj4gY29tcGlsZXIgdG8gcHV0IGl0IGlu
IHJlYWQtb25seSBtZW1vcnkuDQo+IA0KPiBCZWZvcmU6DQo+ICAgIHRleHQgICAgZGF0YSAgICAg
YnNzICAgICBkZWMgICAgIGhleCBmaWxlbmFtZQ0KPiAgIDEyMDYwICAgIDMyODAgICAgIDE5MiAg
IDE1NTMyICAgIDNjYWMgZHJpdmVycy9paW8vZGFjL2FkNTM4MC5vDQo+IA0KPiBBZnRlcjoNCj4g
ICAgdGV4dCAgICBkYXRhICAgICBic3MgICAgIGRlYyAgICAgaGV4IGZpbGVuYW1lDQo+ICAgMTIy
NTIgICAgMzA4OCAgICAgMTkyICAgMTU1MzIgICAgM2NhYyBkcml2ZXJzL2lpby9kYWMvYWQ1Mzgw
Lm8NCj4gDQoNCkFja2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVh
bkBhbmFsb2cuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IFJpa2FyZCBGYWxrZWJvcm4gPHJpa2Fy
ZC5mYWxrZWJvcm5AZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2RhYy9hZDUzODAu
YyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2RhYy9hZDUzODAuYyBiL2RyaXZlcnMv
aWlvL2RhYy9hZDUzODAuYw0KPiBpbmRleCBiMzdlNTY3NWY3MTYuLjA0Yzc0Y2MxYTRlYyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vZGFjL2FkNTM4MC5jDQo+ICsrKyBiL2RyaXZlcnMvaWlv
L2RhYy9hZDUzODAuYw0KPiBAQCAtMjQwLDcgKzI0MCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
aWlvX2luZm8gYWQ1MzgwX2luZm8gPSB7DQo+ICAJLndyaXRlX3JhdyA9IGFkNTM4MF93cml0ZV9y
YXcsDQo+ICB9Ow0KPiAgDQo+IC1zdGF0aWMgc3RydWN0IGlpb19jaGFuX3NwZWNfZXh0X2luZm8g
YWQ1MzgwX2V4dF9pbmZvW10gPSB7DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19jaGFuX3Nw
ZWNfZXh0X2luZm8gYWQ1MzgwX2V4dF9pbmZvW10gPSB7DQo+ICAJew0KPiAgCQkubmFtZSA9ICJw
b3dlcmRvd24iLA0KPiAgCQkucmVhZCA9IGFkNTM4MF9yZWFkX2RhY19wb3dlcmRvd24sDQo=
