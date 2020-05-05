Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D99A1C5BCA
	for <lists+linux-iio@lfdr.de>; Tue,  5 May 2020 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgEEPly (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 May 2020 11:41:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31058 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729561AbgEEPlx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 May 2020 11:41:53 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045FeFAV031274;
        Tue, 5 May 2020 11:41:28 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 30sh4jqnmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 11:41:28 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 045FfRNs032628;
        Tue, 5 May 2020 11:41:28 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 30sh4jqnms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 11:41:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8vhLSafYja2SU2zz+fR57x5GHiHtkMUrY7MU7w+rbaqIxJUf3JLVjML5oBuTkUHkSsvgdhqmmyiz6A8hiphTCv7OcWNOdL5aFSXCM0DoLeDHIWhjMEXQ5eQREZZQKktawNrnTtDu+pKZbZCUTTNdivLZAO6EvCxw6Jb+JsDIy2vtzobu0M0wPtmy/G3AJAwyZp8lULPlOAObzT1I2QiS+eXhfrpassPYMDmCJ9pEkYdYayZqcrlV8tHWqEpi3HNzXXuGK2M/x8pWzmcO2xa5Y3gcJc+gzzJ8/130ZyZ6Rnzf6RCxzMrOZ3uCcQbkncmW8D2JUzc0FhBi11fX21Olg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUSxyNa4ws87BvXjiWi4cAiMubdKTLzu06Aj97HEjTM=;
 b=M7FcqboyXK6YfN1NxT2UiuBoWvhYfi2RxyJCPL0uFE5xsXhxhlaDMP1+LwJseygFdt/bwHn2NsVnJIkAs+3Gf7QK+MKODINanm6IcQWKI3SF158Zr8yoSuGwkOp+c/baV3IY5IPxx5+W4g9b2LZBJB8yEjclfKzQYDTwBQQ+T9kYLV0HbW6bwwZzh5D9wXtVgFMGUc/3di7LxIW2qgsATuyBlFdBkdovi7j47AouXX1/t5aY34z09af32VHPcNUxftyepZEiPqqqgL7n/hf2mzHD1Lkcd8GKxup9mDL/BX9030kY5JWKBFnAas0MX/6utvH0bjO4sgObGEWHExEH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUSxyNa4ws87BvXjiWi4cAiMubdKTLzu06Aj97HEjTM=;
 b=zY0GBoZ4zj7Ew7UaZXl0pcvKqxaE1nBU2Pmg3lpp/Q79Tlp3fV5sN6/Cj2SNs1FXeDVR+MxQBh0oTOQraOSkp+1wDw6kQm+AyvL58CWOBefCul7bY14PVJQO13xlDYAeWw5F1trjB0dzIXxDmoDns8QXod4N+uxBbpBR0VHt4Hg=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3756.namprd03.prod.outlook.com (2603:10b6:5:44::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Tue, 5 May
 2020 15:41:25 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::40df:9aa4:c85a:a020]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::40df:9aa4:c85a:a020%4]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 15:41:25 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "beniamin.bia@analog.com" <beniamin.bia@analog.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7476: fix clang -Wpointer-bool-conversion
 warning
Thread-Topic: [PATCH] iio: adc: ad7476: fix clang -Wpointer-bool-conversion
 warning
Thread-Index: AQHWIuj5swUrWUk3ZUqIkHP7vKml+KiZoXKA
Date:   Tue, 5 May 2020 15:41:25 +0000
Message-ID: <81fedffa59202e11e364abf44a3b529b4dfb98c8.camel@analog.com>
References: <20200505142408.1113763-1-arnd@arndb.de>
In-Reply-To: <20200505142408.1113763-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed595328-d4fb-47bc-7fcb-08d7f10ac550
x-ms-traffictypediagnostic: DM6PR03MB3756:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB375682DACF37FED48AEC9613F9A70@DM6PR03MB3756.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kYsGlJkiVvIXM7cooXfxrJfmbtd5w2SZ86tP5AgJO345T8YJZEDOBpQnqfiC/RWM4HCk3reQhmnNNEkPc9Uat1v/UUu/XBh+old++yYlMfMeyBKiUMMtBsJVB7vxPEG+veW17gDif4idkkuAE1370UUdMvFfWLBGgm4cXkNe4c5E/7htCjSu7Lhkkk+sog+vFcNTCaF1NNPCBxilhKhgkV+00nrf3CZ70A4g7yrvc/xlN2rzgPsND7y1SifbH8ubSTiDgDCqHe2diICaQhGV5LFST10osROqzy3clOxzxtROpiyv/nUK87v3vjCjPBWFibVcVJIwrYyxfyFbAgDhJ2pgpjpr+JUmhnigIOvSpdJ+qBTLBcfyllccEWQ7fVzVHxqee5n2++6l3G8/vSRhynKLPUTMB8M8LYRSULpuVWFIXnuAUVokKCgVD1nR/vmqtbelr8jRJiZjfoM45Vra9hJUyrari/qtofN4mJm2+OtQ6sKGz43IKrS1VWaOjEbYbLd59NzRP1vdPAlY/xyPrTwqzPqE89FLGbLz7XlW3BfvaF4X1zcnKA36LXnINqtvx5eNROXX4NN/kJu+5zrXnVV0gZ2H0TSUTBA2lzdwqYg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(39860400002)(366004)(396003)(33430700001)(5660300002)(4326008)(8676002)(6636002)(86362001)(26005)(36756003)(316002)(6486002)(966005)(478600001)(6512007)(110136005)(91956017)(76116006)(54906003)(66946007)(186003)(71200400001)(66476007)(66556008)(6506007)(66446008)(2616005)(8936002)(33440700001)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XwTRzEu1ERpLJiTzn5lSOJbd2axlIyE2PteOuKB7H1Wrcq1h+1fxAduiLEEjFqWjDm/RjRBHjvrrJcMqB2shZVlS8bWm0954hMcagOUAAljzo3OI5S9i9MLwtPpDB9jS/8qDav+ZOUNjJEwOw+nmWXg31Y8CojpuCcU+r9bwfQQNd4ISuhhqzdCgwZyqgy7D8KDNRh1YRATB9+D79c82bO+3TPwzDeSt3PFM6PpXoCtg9qchh7g7ewoh0MjcwwxlPwrbc7ZSqxqN9VWtYsJCQDoKaR8RP0JSl/p4mP8QIyjc/LqrxKgYwAA0HjrS31eU+xehcrGJagURoUXwE0UOJVJnU8mqvDj+8WpnpAuztwi6Awc/pjUhwdoRMaZh4Q+EZUQmn3VKLjjiEabmhRojeH8tsZf83LT1tkiL+zdytzUgj3EjZfwPtWC65TTrQ6CSeI3GrqzMs8jayJ9pCO3EE5z4RVe1Dw2aD1rsYGg2pULwkNyqzC0YFXlRx0dDEH4YB3NOrdplCD3AK+aLGKC6kuFftJ23UNMmrHaQimkL8tFNpoSkwfStZXPByT0UnKuBaGAi16YQFMzl2IoIjJfQ/7mxoefi9ebrpfZXZ7Ng+8pnV44IebUdFSdaBniBSiv/W6LFtXv9RhXuc1UgpyiIgARcNXqQsxInimdFwA5gLWroCCKosxEYpvKqWKzRRQjCEM0LAiYYNlW4PdULUZkeSQ94oXPvP3PpoAiHIZOq1CXRfcdfrHbUBlF6iZ0PSiRwiXnWS40QAYeJJ2o3O6Y+vR7YPnQtzdZdJIAr7SmnaL0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <655D5A5965B8E247A543BF8F24F3D08C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed595328-d4fb-47bc-7fcb-08d7f10ac550
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 15:41:25.7969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yrkIqPmDDeXCHHtQr2lhjj133knfN3JWnDrlkZkc2X6EAMyusgaKsov9bmkdhSDxqluq2ikvaC6xK4eItvHwpUSATVIaDqNJmQ8wFbXzkEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3756
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_09:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=902 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050125
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTA1LTA1IGF0IDE2OjIzICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiBbRXh0ZXJuYWxdDQo+IA0KPiBDaGVja2luZyB0aGUgcG9pbnRlciB2YWx1ZSBvZiBzdC0+Y2hp
cF9pbmZvLT5jb252c3RfY2hhbm5lbCBpcyBwb2ludGxlc3MNCj4gc2luY2UgdGhpcyB0aGlzIGFu
IGFycmF5IGluc2lkZSBvZiBhIHN0cnVjdDogZXZlbiBpZiBzdC0+Y2hpcF9pbmZvIGlzIE5VTEws
DQo+IHRoZSBwb2ludGVyIGlzIG5vbi16ZXJvLiBDbGFuZyB3YXJucyBhYm91dCB0aGlzOg0KPiAN
Cj4gZHJpdmVycy9paW8vYWRjL2FkNzQ3Ni5jOjMxMjo0MDogd2FybmluZzogYWRkcmVzcyBvZiBh
cnJheSAnc3QtPmNoaXBfaW5mby0NCj4gPmNvbnZzdF9jaGFubmVsJyB3aWxsIGFsd2F5cyBldmFs
dWF0ZSB0byAndHJ1ZScgWy1XcG9pbnRlci1ib29sLWNvbnZlcnNpb25dDQo+ICAgICAgICAgaWYg
KHN0LT5jb252c3RfZ3BpbyAmJiBzdC0+Y2hpcF9pbmZvLT5jb252c3RfY2hhbm5lbCkNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIH5+IH5+fn5+fn5+fn5+fn5+fl5+fn5+fn5+fn5+fn5+
DQo+IA0KPiBJIGNvdWxkIG5vdCBjb21lIHVwIHdpdGggYSBzYW5lIHdheSB0byBjaGVjayB3aGV0
aGVyIHRoZSBlbnRyeQ0KPiBpcyB2YWxpZCwgc28ganVzdCByZW1vdmUgdGhlIGNoZWNrIGFuZCBr
ZWVwIHRoZSBiZWhhdmlvciBhcyBpdA0KPiBpcyB0b2RheSBidXQgd2l0aG91dCB0aGUgd2Fybmlu
Zy4NCg0KVGhlcmUncyBhbHJlYWR5IGEgcGF0Y2ggZm9yIHRoaXMsIGluIG9uZSBvZiBKb25hdGhh
bidzIGJyYW5jaGVzLg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTUwNzgy
OS8NCg0KVGhhbmtzDQpBbGV4DQoNCj4gDQo+IEZpeGVzOiAzYTZhZjkzZGQ2NmUgKCJpaW86IGFk
YzogYWQ3NDc2OiBBZGQgSUlPX0NIQU5fSU5GT19SQVcgZm9yIEFENzA5MVIiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMv
aWlvL2FkYy9hZDc0NzYuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hZDc0
NzYuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDc0NzYuYw0KPiBpbmRleCBlOTk4NGEzOGZjNGMuLjRl
ODE2ZDcxNGFkMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkNzQ3Ni5jDQo+ICsr
KyBiL2RyaXZlcnMvaWlvL2FkYy9hZDc0NzYuYw0KPiBAQCAtMzA5LDcgKzMwOSw3IEBAIHN0YXRp
YyBpbnQgYWQ3NDc2X3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ICAJaW5kaW9fZGV2
LT5udW1fY2hhbm5lbHMgPSAyOw0KPiAgCWluZGlvX2Rldi0+aW5mbyA9ICZhZDc0NzZfaW5mbzsN
Cj4gIA0KPiAtCWlmIChzdC0+Y29udnN0X2dwaW8gJiYgc3QtPmNoaXBfaW5mby0+Y29udnN0X2No
YW5uZWwpDQo+ICsJaWYgKHN0LT5jb252c3RfZ3BpbykNCj4gIAkJaW5kaW9fZGV2LT5jaGFubmVs
cyA9IHN0LT5jaGlwX2luZm8tPmNvbnZzdF9jaGFubmVsOw0KPiAgCS8qIFNldHVwIGRlZmF1bHQg
bWVzc2FnZSAqLw0KPiAgDQo=
