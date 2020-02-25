Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD98E16BA7C
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 08:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgBYHTQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 02:19:16 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21246 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgBYHTQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 02:19:16 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01P7Gns5002536;
        Tue, 25 Feb 2020 02:19:14 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yb23afup8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 02:19:14 -0500
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01P7JD0i015291;
        Tue, 25 Feb 2020 02:19:13 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yb23afup6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 02:19:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUWD/nCpJ0WLwxZLI5e01mPUMaTDx6EMHrWfH6C1ndtl8CT/Adf9dZzml8/bKN/GxQw720hfTYpiFT2bRdMx4hozd0Vg6IgbOIj1IzyezMSzFg15zf+qp1zT8Jq7vOXUHPAQEv/zMHeBzl7MP48o35klTxAgxcgjy47adENImyidXE7ltDUhAQcameRDUKQ5hxLesLYHtCCjGx7MZ7E4ptetg1SxGWs+G6+QgW5Gs/RGDGj+cvsOQHdzz34jDTdhjYnVS7E7X0Y9fYVDS+g63Zt6mDyQf6+6xFeNf9isbOJzcYHR0kBZTMaQAFJfZojM1ASGJ9k502F6QdYFmSMdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/KM45sjYOlb0vj6A29T+k0pvfRbVfgdJS0rijX7hKM=;
 b=d+iXqGUwPyAf+qiIO1u/C0V7PeK105GPG8gcMPpT+OyKxozlRO4b779gFQRmxXOAQeUVtWVJJJ2EEjMjiws4yuVHkXyuERA6FYm++sWHzn9fZnNUJhrUw+0esANcTtVCv8d6P7VvniGLT7RUEPcQiQbefgsBlBgf41fMMR9RsuHmcwet4R5zhejbB1C4kTG+pCW7NvC0E8HgEvbJjSct93xT72smA9ZSnrtkxvJhM/dtA7xmkNALLqh+mAzrBM75e2V5ehd+gKuYmYvDDHtbAZ0wHOJBVKrrZyX+JLPHMu+Npg78mD0xCiOkPmL1T9I1QOE0v7fUAZZ2f6FOSOu5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/KM45sjYOlb0vj6A29T+k0pvfRbVfgdJS0rijX7hKM=;
 b=aFrLcPEFXBkrx7LUGd0ADwMbJ8MHlYN9nw9K4zWex+fEs+Tk2aiAUI4rrTnnVkOL9Tj9PSbNTf84oizEOzDws6F/RhxCkoBUcmTsne0to/anr9aej+MktUgL69c+m4B9L18nvCGZfuF5+UO7WbIrKv1jJBcS82erCSIBskeMNuo=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5271.namprd03.prod.outlook.com (2603:10b6:610:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 07:19:12 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 07:19:12 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "rohitsarkar5398@gmail.com" <rohitsarkar5398@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "device-drivers-devel@waws-prod-bn1-047.cloudapp.net" 
        <device-drivers-devel@waws-prod-bn1-047.cloudapp.net>
Subject: Re: IIO staging TODO
Thread-Topic: IIO staging TODO
Thread-Index: AQHV6iiH7NIXzSd5qkqjehNAujwzWagqpCiAgADgGYA=
Date:   Tue, 25 Feb 2020 07:19:12 +0000
Message-ID: <5a4c3a4a20b9ae80d8612164d46ccba80a4495aa.camel@analog.com>
References: <20200223090609.GA5222@SARKAR>
         <20200224180003.00007d63@Huawei.com>
In-Reply-To: <20200224180003.00007d63@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82f094c8-8064-474e-81f1-08d7b9c30360
x-ms-traffictypediagnostic: CH2PR03MB5271:
x-microsoft-antispam-prvs: <CH2PR03MB5271ACFC3955A21C5605C45AF9ED0@CH2PR03MB5271.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(346002)(39860400002)(189003)(199004)(110136005)(26005)(3480700007)(54906003)(64756008)(8936002)(66446008)(86362001)(76116006)(66556008)(8676002)(6512007)(186003)(66476007)(66946007)(91956017)(7116003)(316002)(5660300002)(81156014)(6486002)(2616005)(478600001)(4326008)(2906002)(36756003)(81166006)(71200400001)(6506007)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5271;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KcgaVcEfQ5qXh22d9nzqn1NJS5zA/11dZYPyIYDKS2hzgQbQJokt0pshkd5VkwPsWZNkTx2JiEALgDrikyDN9ekuOQX4FMLfoxQQQwQ56rH3nd/G4E65oQckCdo3joS7GFcWjELvNM9fLHKOYUjGdsNku4CSHFkkVnFj2TmVIgW0CeAQBOViYqijjALHI1CacVGRaqoNxVQW787undSDL0ClXDl1efgtZRWUzVu96yowdDXtIYj22j9bmuFeBBS0DZQL2d+BkbQIbVFQjnFj+ua2mtVy4am0wI4VnfAGaNsXHWsKZB+VX6ODjFbfysdQO2I0H5dJxbfuQWAXJLQTF309CeoM6Yu7yaXcxlOL0YCFUYp8BroPvdSp3A3KjRE+fpv3ARHQF1QgrJpaJbTk3KLxatfm7xrgxyOtIbInT2YY/AbGQHJt50A5c/tCOGU1ulTancjDFkJuG0MRIk1tKcbeU1nMgiMwt+dufufPgmSMcZmO1HUK416d/uk45AtS
x-ms-exchange-antispam-messagedata: ejI9XPVe/IXxaZhR5zR2QiAPzEEyUNG7XRPc9rnMK4NT69HY/TwUTY3O2/6PZilWv0DgL9qmWYtwnnbY9lRgcYX/lSNdyOiO1JMniYtnZZvyGkbjKTBJDzzGl8g88dZ4lEpt60DzPvAX9UsNn8FdkQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CD387597798D74E994BA33D0A853E37@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f094c8-8064-474e-81f1-08d7b9c30360
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 07:19:12.1118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JKyMmX2vuaQ44Or9+XdG1Lnh1KqGEiZoB6CWr74hOLQ7FqUJ05x672eRtZ7WO8US5BAoeNBxEuqJplDENCZREWYd5oDK0+VtaGlVU0pDev4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5271
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_01:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250059
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTI0IGF0IDE4OjAwICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBTdW4sIDIzIEZlYiAyMDIwIDE0OjM2OjA5ICswNTMwDQo+IFJvaGl0IFNhcmthciA8
cm9oaXRzYXJrYXI1Mzk4QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEhleSwNCj4gPiBJIHdh
cyBnb2luZyB0aHJvdWdoIHRoZSBUT0RPIGluIHN0YWdpbmcvaWlvLg0KPiA+IA0KPiA+ICINCj4g
PiBDb252ZXJ0IGFsbCB1c2VzIG9mIHRoZSBvbGQgR1BJTyBBUEkgZnJvbSA8bGludXgvZ3Bpby5o
PiB0byB0aGUNCj4gPiBHUElPIGRlc2NyaXB0b3IgQVBJIGluIDxsaW51eC9ncGlvL2NvbnN1bWVy
Lmg+IGFuZCBsb29rIHVwIEdQSU8NCj4gPiBsaW5lcyBmcm9tIGRldmljZSB0cmVlLCBBQ1BJIG9y
IGJvYXJkIGZpbGVzLCBib2FyZCBmaWxlcyBzaG91bGQNCj4gPiB1c2UgPGxpbnV4L2dwaW8vbWFj
aGluZS5oPi4NCj4gPiAiDQo+ID4gDQo+ID4gSSBjb3VsZG4ndCBmaW5kIGFueSB1c2FnZXMgb2Yg
dGhlIG9sZCBncGlvIEFQSSBpbiBpaW8gc3RhZ2luZy4gV2UgY2FuDQo+ID4gcHJvYmFibHkgdXBk
YXRlIHRoZSBUT0RPIHRvIHJlbW92ZSB0aGlzIGl0ZW0uDQo+IA0KPiBDb29sLiBQYXRjaGVzIHRv
IHRoZSBUT0RPIHdlbGNvbWUgOikgSSBndWVzcyB0aGUgbGFzdCBvZiB0aGVzZSBnb3Qga2lsbGVk
IG9mZi4NCj4gDQo+ID4gV2FzIHdvbmRlcmluZyBpZiB0aGVyZSBpcyBhbnkgb3RoZXIgVE9ETy8g
bG93IGhhbmdpbmcgZnJ1aXQgaW4gSUlPPw0KPiANCj4gSWYgeW91IHdhbnQgdG8gdGFrZSBhIGxv
b2sgYXQgZGV2aWNlIHRyZWUgYmluZGluZ3MgdGhlcmUgaXMgZGVmaW5pdGVseSB3b3JrDQo+IHRv
IGJlIGRvbmUgdGhlcmUuDQo+IA0KPiAqIE1pc3NpbmcgYmluZGluZyBkb2NzIGZvciBkZXZpY2Vz
IHRoYXQgYXJlIG9idmlvdXNseSB1c2VkIHZpYSBkZXZpY2UgdHJlZS4NCj4gKiBZYW1sIGNvbnZl
cnNpb25zIG9mIGFiYW5kb25lZCBkcml2ZXJzLiANCj4gDQo+IEknZCBtb3N0bHkgbGlrZSB0byBs
ZWF2ZSBhY3R1YWxseSBkb2luZyB5YW1sIGNvbnZlcnNpb25zIG9mIGFjdGl2ZWx5DQo+IG1haW50
YWluZWQgZHJpdmVycyB0byB0aGVpciBtYWludGFpbmVycyBidXQgSSBzdXNwZWN0IHdlIGhhdmUg
cXVpdGUgYSBmZXcNCj4gd2hlcmUgbm8gb25lIGhhcyB0b3VjaGVkIHRoZW0gaW4geWVhcnMuDQo+
IA0KPiBBbm90aGVyIGFyZWEgaXMgbWlzc2luZyBBQkkgZG9jdW1lbnRhdGlvbi4NCj4gDQo+IFJl
dmlld2luZyBpZiB0aGVyZSBpcyBhbnl0aGluZyB3b3J0aCBrZWVwaW5nIGluDQo+IGRyaXZlcnMv
c3RhZ2luZy9paW8vRG9jdW1lbnRhdGlvbg0KPiBhbmQgcHV0dGluZyBpdCBpbiB0aGUgcmlnaHQg
cGxhY2UgaWYgc28gaXMgYWxzbyB1c2VmdWwuDQo+IA0KPiBGb3IgY29kZSByZWxhdGVkIHN0dWZm
LCBJIHN1c3BlY3QgdGhlIHJlbWFpbmluZyBzdGFnaW5nIGRyaXZlcnMgYXJlIHN0aWxsDQo+IHRo
ZXJlIGZvciBhIHJlYXNvbiAob2Z0ZW4gYSBoYXJkIHByb2JsZW0gdG8gYmUgcmVzb2x2ZWQpLg0K
PiANCj4gT25lIHRhc2sgd2Ugb2Z0ZW4gYXNrIHBlb3BsZSB0byBsb29rIGF0IGlzIHVzZXMgb2Yg
aWlvX2Rldi0+bWxvY2suDQo+IFRoYXQgbG9jayBzaG91bGQgbmV2ZXIgYmUgdXNlZCBkaXJlY3Rs
eSBidXQgd2Ugd2VyZSBsZXNzIHRoYW4gY2FyZWZ1bA0KPiBhYm91dCBpdCBpbiB0aGUgZWFybHkg
ZGF5cyBvZiBJSU8gc28gdGhlcmUgYXJlIHN0aWxsIGEgZmV3IGluc3RhbmNlcw0KPiBpbiBkcml2
ZXJzLiAgTXkgbWF4MTM2MyBkcml2ZXIgZm9yIGV4YW1wbGUgOikNCj4gDQo+IE1vdmluZyB0byBl
aXRoZXIgYSBsb2NhbCBsb2NrLCBvciB0byB1c2luZyB0aGUgaWlvX2NsYWltX2RpcmVjdCBldGMN
Cj4gZnVuY3Rpb25zIHRvIG1hbmFnZSB0aGlzIGluIGEgcmFjZSBmcmVlIHdheSB0aWRpZXMgdGhp
cyBiaXQgb2YgaW1wbGVtZW50YXRpb24NCj4gbWVzcyB1cC4gIEl0IHJlcXVpcmVzIGNhcmVmdWwg
YW5hbHlzaXMgb2YgJ3doYXQnIHRoZSBsb2NrIGlzIHRoZXJlIGZvciBhbmQNCj4gcGF0Y2hlcyBu
ZWVkIHRvIHN0YXRlIHlvdXIgY29uY2x1c2lvbnMgb24gdGhhdCBjbGVhcmx5IHNvIG90aGVycyBj
YW4NCj4gdmVyaWZ5IHlvdSBhcmUgY29ycmVjdCENCj4gDQo+IE9uZSB0aGluZyB0byBub3RlIGlz
IG5ldmVyIHNlbmQgdG9vIG1hbnkgcGF0Y2hlcyBvZiB0aGUgc2FtZSB0eXBlIG91dA0KPiB1bnRp
bCB5b3UgaGF2ZSByZXZpZXdzIGJhY2suICBJdCdzIHRvbyBlYXN5IHRvIGhhdmUgdGhlIHNhbWUg
aXNzdWUgcmVwZWF0ZWQNCj4gbWFueSB0aW1lcyBvdmVyLCBzbyBiZXR0ZXIgdG8gc2VuZCB0aGlu
Z3Mgb3V0IHNsb3dlci4NCj4gDQoNCkkgYWxzbyB1c3VhbGx5IGFkZCBoZXJlIHRoZSBjb252ZXJz
aW9uIG9mIGRyaXZlcnMgZnJvbSBkZXZpY2UtdHJlZS1jZW50cmljIHRvDQp0aGUgbW9yZSBuZXV0
cmFsL2dlbmVyaWMgcHJvcGVydHktaGFuZGxlcnM7IHVzdWFsbHkgaXQncyBqdXN0IGNvbnZlcnRp
bmcNCmZ1bmN0aW9ucyAib2ZfcHJvcGVydHlfcmVhZF94eHgoKSIgdG8gImRldmljZV9wcm9wZXJ0
eV9yZWFkX3h4eCgpIjsgdGhlIGxhdHRlcg0KYWxzbyBzdXBwb3J0cyBBQ1BJLg0KDQpPbiB0aGUg
c2FtZSBwYWdlLCB0aGVyZSdzIGFsc28gcmVtb3ZpbmcgdGhlIG9sZCBwbGF0Zm9ybV9kYXRhIGNv
bnN0cnVjdHMgZnJvbQ0KZHJpdmVycyBhbmQgY29udmVydGluZyBpdCB0byBzdGF0ZS1zdHJ1Y3Qg
YW5kIHVzaW5nIHByb3BlcnR5IGhhbmRsZXJzL3JlYWRlcnMuDQoNClVzdWFsbHkgd2Ugd291bGQg
anVzdCBzYXkgY29udmVydCBwbGF0Zm9ybS1kYXRhIHRvIGRldmljZS10cmVlLCBidXQgbm93IEkn
bQ0KdHJ5aW5nIHRvIGdvIGEgYml0IGZ1cnRoZXIgYW5kIHRyeSB0byBtYWtlIHRoaW5ncyBhIGJp
dCBtb3JlIGdlbmVyaWMgdG8gYWxzbw0KaW5jbHVkZSBBQ1BJLg0KDQo+IFRoYW5rcyBhbmQgZ29v
ZCBsdWNrLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gVGhhbmtzLA0KPiA+IFJvaGl0DQo+IA0K
PiANCg==
