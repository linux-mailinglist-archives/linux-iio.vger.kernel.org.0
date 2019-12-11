Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F6911A513
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 08:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfLKH1c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 02:27:32 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:51666 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbfLKH1c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 02:27:32 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB7HY6j011915;
        Wed, 11 Dec 2019 02:27:13 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wrb1sbdkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 02:27:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VN7rnvuqiPEaKZCNRlCZ3T0/MTQW09MzY+WGP7sxUJwFyJncJr36W+Y1KltpSllVwipwzBP2sd+qIyzWTjOgecqotkh9mWsANf+cKhhzVwK5L9oJrjCZ2klX8ITBnyXJKFP0ibORz4Kba6brN4rmzu+h3N/3Gk+G7SEJwAKXI1WVBHmJgbi2ublOdbGjenLu1lvpnUWKYKyViJzZr29stELNzE6abs1XUg6aaHxMvvwoarDqcAhu9Uvl2lvGSVi/LdjHLw0ggcefBwKIEfGsfsovcBoJmDOBy4Jy3aEBxLHv/6YgX15nC4vUygoWmwY6SocqDTLBiohtPJrSIrmrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUgpw3j5PeH0FcG1QXByJztHG50GxFLgIzNXCt3Zyfc=;
 b=m6g8vJ6czs8+IDkRYBsvHICcU9NzzBhHmzMG29TTHP8xHP//NLfSTEvtl4GrZWSeoHr+G4fvRjcDV6jkCNY6KUcJBlBQVZ8TClqXxKouHR7vaK+MhapvSeJutqSRJRLXqM+BSb2TisgG7ilr1xfIGmQENjyI0orsvlSQJR5GtiSmLYhBp3VKm7G+nAXYGPbexgBw9xfyDiuNWG6DmV86/ghjk4hLwXbThf7udaE2X3smCqysSVv7DN1g/vGv1eE9s4gWqi0oz6KwPddywfdgmSOaSyUV27iUAmbCUqDgpqcopcxKK0927dLWPE9YxxIaOyAKC5M2xvedDmpi4/MIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUgpw3j5PeH0FcG1QXByJztHG50GxFLgIzNXCt3Zyfc=;
 b=jWAlmtEPP7F2qnSkbVg4LKRJeGGd8JrARcIihPtsJJ0sPdtfBHC/4D3B4C8T3okkyLQyjuatNuuXz0fJ9YjZiQwb6nwln8XbpA/Ug2fJLQlugTHG9wBNZcyXgYgRy+LZJR/5PNkzMKI+RT/0Ws+18xM/lL9TOxQP/iL2rvpbBPQ=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5174.namprd03.prod.outlook.com (20.180.4.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 07:27:11 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 07:27:11 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2 3/4] iio: adc: ad7923: Add of_device_id table
Thread-Topic: [PATCH v2 3/4] iio: adc: ad7923: Add of_device_id table
Thread-Index: AQHVr2vNvVB1N9c3W0CXyPoI7IvDUqe0ilsA
Date:   Wed, 11 Dec 2019 07:27:11 +0000
Message-ID: <b9e83fadfaf49fbbe2230ee6cd0007fb72cd6292.camel@analog.com>
References: <20191210150811.3429-1-djunho@gmail.com>
         <20191210150811.3429-4-djunho@gmail.com>
In-Reply-To: <20191210150811.3429-4-djunho@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae574d70-94fc-4912-6e6a-08d77e0b898c
x-ms-traffictypediagnostic: CH2PR03MB5174:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB517446E50F787B4A13E69147F95A0@CH2PR03MB5174.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:480;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(39860400002)(346002)(396003)(189003)(199004)(186003)(2906002)(478600001)(316002)(86362001)(66946007)(81166006)(2616005)(26005)(110136005)(36756003)(6512007)(8936002)(76116006)(5660300002)(6486002)(66476007)(8676002)(4001150100001)(71200400001)(66446008)(81156014)(64756008)(66556008)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5174;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fo/T3cDk/NSVvNqCH4pBDQPAesyAh2mFRVbJIGIbq+b4ePpnjJKRwgoCG0CSayExlZCxvFG+cFBHapiPK2rRqatAEUDV1MAzG6/37BgmZIYOCIIyPtKdOpjwKPABViLJHHmT1beDmnjUtMuNIhE80eJjb7BnJM0XzJpHJa9zsQDxH3fByWdt2i+bbXX4YXRYuYD6K3cXjLXs8qelRs64tv0pWrfyi/R2IjEFvBhvvCepeyFz9IehABcrz2JZOoJYbWv7gQaKhNvbRDLbCvhDlHTPjFURKn8dAY7sfZbqHf1sscbT23ymiHOjU0cpXC2gLokuSn/4R1XbheLLDyXN/DnZrXndi/8ONhGJgmah7fu0LBkuNsrqAwNYGH2ipIVUzXoKlxSWoJK4GZnIs1Bg34S3ffTWrk1pYQzE2jBi6hGtVBQegdxD8Xd8xLb78HV7aGbXAFesBDJBkxor1T/ZK8oDwJ7wenv9YnZx+Lvb6W5cS2CNrvKEa1Oc68qJSxAH
Content-Type: text/plain; charset="utf-8"
Content-ID: <1151509C361B8B4FB2BAB70EBDD48AB5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae574d70-94fc-4912-6e6a-08d77e0b898c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 07:27:11.2690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UL7yd2oLEvUVqQ3F+0a/0ZhTgiceWrotN8kgmgqt6coNW3hIhZWrgV0SSEjcjRxOATsUTCv+aibLGO5VLr8uxyKNyLNuWPLPpQvl5JpPHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5174
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_01:2019-12-10,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110062
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTEwIGF0IDEyOjA4IC0wMzAwLCBEYW5pZWwgSnVuaG8gd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IEFjY29tcGxpc2ggZGV2aWNlIHRyZWUgY29tcGF0aWJpbGl0eSB0
byBkcml2ZXIgQUQ3OTIzDQo+IGJ5IGFkZGluZyBvZl9kZXZpY2VfaWQgdGFibGUgYW5kIG1ha2lu
ZyBhIHN1YnNlcXVlbnQgY2FsbCB0bw0KPiBNT0RVTEVfREVWSUNFX1RBQkxFLg0KPiANCg0KUmV2
aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5j
b20+DQoNCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEp1bmhvIDxkanVuaG9AZ21haWwuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9hZDc5MjMuYyB8IDEwICsrKysrKysrKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9paW8vYWRjL2FkNzkyMy5jIGIvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+IGluZGV4IGU1
MzVjZWM5ZmMwMi4uNmQ1NmZhMGI5ZTMwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMv
YWQ3OTIzLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+IEBAIC0zNDgsOSAr
MzQ4LDE5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpX2RldmljZV9pZCBhZDc5MjNfaWRbXSA9
IHsNCj4gIH07DQo+ICBNT0RVTEVfREVWSUNFX1RBQkxFKHNwaSwgYWQ3OTIzX2lkKTsNCj4gIA0K
PiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYWQ3OTIzX29mX21hdGNoW10gPSB7
DQo+ICsJeyAuY29tcGF0aWJsZSA9ICJhZGksYWQ3OTA0IiwgfSwNCj4gKwl7IC5jb21wYXRpYmxl
ID0gImFkaSxhZDc5MTQiLCB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAiYWRpLGFkNzkyMyIsIH0s
DQo+ICsJeyAuY29tcGF0aWJsZSA9ICJhZGksYWQ3OTI0IiwgfSwNCj4gKwl7IH0sDQo+ICt9Ow0K
PiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYWQ3OTIzX29mX21hdGNoKTsNCj4gKw0KPiAgc3Rh
dGljIHN0cnVjdCBzcGlfZHJpdmVyIGFkNzkyM19kcml2ZXIgPSB7DQo+ICAJLmRyaXZlciA9IHsN
Cj4gIAkJLm5hbWUJPSAiYWQ3OTIzIiwNCj4gKwkJLm9mX21hdGNoX3RhYmxlID0gYWQ3OTIzX29m
X21hdGNoLA0KPiAgCX0sDQo+ICAJLnByb2JlCQk9IGFkNzkyM19wcm9iZSwNCj4gIAkucmVtb3Zl
CQk9IGFkNzkyM19yZW1vdmUsDQo=
