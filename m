Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 416F917A5F3
	for <lists+linux-iio@lfdr.de>; Thu,  5 Mar 2020 14:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCENEv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Mar 2020 08:04:51 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48928 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbgCENEv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Mar 2020 08:04:51 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 025CorLi022446;
        Thu, 5 Mar 2020 08:04:30 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ygm52f3fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Mar 2020 08:04:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab5pG3tN1HEDeolmtMi1QG8dlr2IK0iqxc951b3qu/0meYpvZ/GOx/ekshuHjwC44drcAniwUt8jaqEhIH3Ejo4g5SO7ocRcKRcTALlvnTOSHg8XepjdYxw5Gp+tv1aZSBxOzLejzaH4/NEebmLZa6hsAlkKNjkniTp07Wv7FkqB70V06qQ4ZBFYOmpiV3p9LBARAMkTACP6ctnmqI4NY/k/4jOTZKK7YEgArRB7BolJwJc643qLzJ8DNL8hXvsKjNBGoVgSryFMvvgV9n1snRb9QUEMlw+s5PlYpT1mxiXE5kGL0xeLwbSeVfq804SpDOZvvQUyWSXYiCYSrYQYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7UiAFyatrV/QUuR5cF0QV2bfprNiYWyOPxsDYAnDGg=;
 b=gDK2HT+Yw5xplx992DVCUb+KPy7U2O5J6ZVk5PVpnrQnjyuUlhYOQXkN0//16jRVtjCMPqOOt7uI6koLNKEwfVUcf6pElGWHXC/SrLItglAnpDCK1jgPtxyD8yn9Q6Md8u+y3rWhwvoCNJ5s4n0D3HYowMZffAs+xJA99RTekg+5mclxM4DIab0LSeXFQZvCaCYRKND6xRBydmizhpgkfAa5PgDRN+9MoAIg/f1mlHdjXYmT+Nj2pk0XybGCGQ02gbVkucAC7v3Lvt6d4NOWs7xlzZLCmXrr0hEoh8ulG9AuefBdi9Xk/hTjQ//ApT7LAU1CE4xu9tQTPYg92rp4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7UiAFyatrV/QUuR5cF0QV2bfprNiYWyOPxsDYAnDGg=;
 b=pQ/LS+c7lbWgeP2RVWF+zjrqFKsL4DF3BesD4EqEVusBaQhyoEMWo4W2sY8XHAbSztHP06dxgSyOWIg8thKBk9cmMZkUPMNT4HFCN9TcQKJX2YNaoaH6XCmZrLAMqCi4C+LYeWl1yqV2nI/p3ZAIsxYP/v4IKniEK+xSZPdi9NY=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2419.namprd03.prod.outlook.com (2603:10b6:404:15::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Thu, 5 Mar
 2020 13:04:28 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a%4]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 13:04:28 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Thread-Topic: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Thread-Index: AQHV69jpKCRYfnfL+0eh49A+u9WwfKg3aLaAgAFdfACAARVLAIAAIBKAgAAD94CAAAY/AA==
Date:   Thu, 5 Mar 2020 13:04:27 +0000
Message-ID: <a6b4c76a337f53db1ee05a03eca06751b901d04b.camel@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
         <20200225124152.270914-6-nuno.sa@analog.com>
         <20200303211045.31f977bb@archlinux>
         <9b9e18f279edbcb60122a0b0d4c067975868194a.camel@analog.com>
         <63b5c766-78a2-59c4-6efb-3eb35031a351@metafoo.de>
         <3bdae6c113381c7dd0645b7b98c67fac734b92ab.camel@analog.com>
         <13e355c6-af60-772a-92ec-aff17d0255ee@metafoo.de>
In-Reply-To: <13e355c6-af60-772a-92ec-aff17d0255ee@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b12113b0-effb-4cb5-53f7-08d7c105bcb6
x-ms-traffictypediagnostic: BN6PR03MB2419:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB2419746EF5D4160EBB14D96099E20@BN6PR03MB2419.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(376002)(346002)(189003)(199004)(4326008)(76116006)(478600001)(2906002)(66446008)(71200400001)(64756008)(66946007)(66556008)(66476007)(5660300002)(2616005)(8676002)(81166006)(8936002)(81156014)(26005)(186003)(6486002)(316002)(54906003)(110136005)(36756003)(86362001)(6506007)(53546011)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2419;H:BN6PR03MB3347.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oKxuy1HJ3ACs6H4Rwx6wYd1O5Zu1aKgVsEpGYPeOUJ1xh27aUdWM4aprZ+2x0Y6VDWhZxPEKwAgRwsE5si1LlmuxgCBlO2w1KxXffmW3umnCthEd4u/SwFSsR1Ij+ExSOdoL41TH6RAustX/WTBvOFIneyssYIsvBus7KgbhtbxUvkl4guLasHxyqegJ4Qi9Ja+6Wgt4kVqISudZ85tO6OwbYMJfN4pVrKNHllp2dAEMqhDIhJvG0WAA3Va6EE7ZE5wwhbFVKPyZjkcBlWyuCnAOLp4G/ygMzOveEr0FCTbS/i/S+MdnhQKKaZtdSwDYGXssL5J7dbUtgCNKiXNP1W+V+wwiv2ufhEqPYGc2Te/f8VI4BOcZTcsxYiiAn5MkaHcMBvR3WRjCtE4YjZd/0+6R2/2Ei9/K6ItNTv93AzxqYsGIjZno5VuH/LQq9W0a
x-ms-exchange-antispam-messagedata: S2Pyt9SEH7UnV952WH+wKRUK+D1hKkk9Y4Gewau8OFNvryTNgI7Fe+3moxzVfRWD54m4NgxyQQwFDv8924umLB2VBgstmGZ3EmHHlIMOij8e9oXoAW5s0ifX+ArevtlGGcsRrhZCVHB8Ouc95A1Djw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <40FFF3FE26A5AB4DAA754C1DA7E3D7E9@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12113b0-effb-4cb5-53f7-08d7c105bcb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 13:04:28.0248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQlP+fTUpsyQVduzKbopshj2NW6SQpkMF2WJksKh3vP4v6jyux3YfHeesXah24yuYdoPcTKbdLo87O8xos4Dzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2419
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-05_03:2020-03-05,2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTA1IGF0IDEzOjQzICswMTAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IE9uIDMvNS8yMCAxOjI3IFBNLCBTYSwgTnVubyB3cm90ZToNCj4gPiA+IEluIG15IG9w
aW5pb24gdGhlcmUgaXMgc2hvdWxkIG5vdCBiZSBhIGRpZmZlcmVuY2UgaW4gdGhlDQo+ID4gPiB1
c2Vyc3BhY2UNCj4gPiA+IGludGVyZmFjZSBmb3IgY2hpcHMgdGhhdCBkbyBzdXBwb3J0IDMyLWJp
dCBidXJzdCBhbmQgdGhvc2UgdGhhdA0KPiA+ID4gZG9uJ3QuDQo+ID4gPiBGb3IgZGV2aWNlcyB0
aGF0IGRvbid0IHN1cHBvcnQgMzItYml0IGJ1cnN0IGl0IHNob3VsZCBiZSBlbXVsYXRlZA0KPiA+
ID4gYnkNCj4gPiA+IHJlYWRpbmcgdGhlIExTQiBiaXRzIHJlZ2lzdGVycyBtYW51YWxseS4NCj4g
PiBIbW0uIEluIHRlcm1zIG9mIGludGVyZmFjZSBJIHRoaW5rIHRoZXJlIGlzIG5vIGRpZmZlcmVu
Y2UuIFdlDQo+ID4gYWx3YXlzDQo+ID4gcmVwb3J0IDMyYml0cyBjaGFubmVscyAoZm9yIGFjY2Vs
IGFuZCBneXJvKS4gSG93ZXZlciwgd2hhdCB3ZSBkbw0KPiA+IHJpZ2h0DQo+ID4ga25vdyBpcyBq
dXN0IHRvIHNldCB0aGUgTFNCIHRvIDAgaWYgYnVyc3QzMiBpcyBub3Qgc3VwcG9ydGVkLiBTbywN
Cj4gPiB3ZQ0KPiA+IGNhbiBiZSBqdXN0IGlnbm9yaW5nIHRoZSBMU0IgYml0cyBpZiB0aGV5IGFy
ZSBiZWluZyB1c2VkLi4uDQo+IA0KPiBXaGF0IEkgbWVhbnQgd2FzIHRoYXQgc29tZWJvZHkgbWln
aHQgc3RpbGwgd2FudCB0byBnZXQgdGhlIGZ1bGwgMzItDQo+IGJpdCANCj4gdmFsdWVzIGluIGJ1
ZmZlcmVkIG1vZGUsIGV2ZW4gaWYgdGhlIGRldmljZSBkb2VzIG5vdCBzdXBwb3J0IGJ1cnN0MzIu
DQoNClRoZXkgYXJlLiBKdXN0IHRoYXQgdGhlIExTQiBwYXJ0IGlzIGFsd2F5cyBzZXQgdG8gMCA6
KS4gQW5kIHRoYXQsIGluIG15DQpvcGluaW9uLCBpcyB3cm9uZy4gQXMgeW91IHNheSwgd2Ugc2hv
dWxkIGRvIHRoZSBtYW51YWwgcmVhZGluZ3MgaWYNCnRoZXJlIGFyZSBhbnkgYml0cyBvbiB0aGUg
TFNCIHJlZ2lzdGVycy4uLg0KDQotIE51bm8gU8OhDQo+IEluIA0KPiB0aGF0IGNhc2UgeW91IGNh
biBmaXJzdCBkbyBhIDE2LWJpdCBidXJzdCByZWFkIHRvIGdldCB0aGUgTVNCcyBhbmQNCj4gdGhl
biANCj4gZG8gbWFudWFsIHJlYWRzIG9mIGFsbCB0aGUgTFNCIHJlZ2lzdGVycyBhbmQgdGhlbiBw
dXQgYm90aCBpbnRvIHRoZQ0KPiBidWZmZXIuDQo+IC0gTGFycw0KPiANCg0K
