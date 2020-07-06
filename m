Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BED4215BE5
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jul 2020 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgGFQgN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jul 2020 12:36:13 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:49630 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729293AbgGFQgN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jul 2020 12:36:13 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066GP6YI030638;
        Mon, 6 Jul 2020 12:36:10 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00128a01.pphosted.com with ESMTP id 322km7fbes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 12:36:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvxCnHZdq6S+rfsIXZs5T4xB+sSlCCSrGSmdcr4BkK+ue2r+ViJpmxOyyoHbX/7K9mMoC7ponDJ0uxIBWTQTpPTtuLwyU+2uZ7ZPn/wwvMJfbXPKZuIhRNdTbQVdqYFta14oXJz2VIO7+eCYfryBsmCGte14z7YJVpYrSwF8toZMXvhUo9fXNfJ8CTSsNaqBJJj/K6UMFKIqeWIPglTAJc1Uka72RcNa6C/VLvYWOD+y/TNAQpvvxvx1rygA/BrZPoXYpFV4db9HIW8AgRPmqnAwv8HC3dwL+pZaKncRdgq2voUhylVIFm7blz+oQhcP69hGo2ylwEdSGFTIgL0Skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TknF8VOgDgGiYuiP9/07Z+zuUiZHL1oCifUlKMx+OXs=;
 b=CA+GukKF05KRfvId6471Y1qt1HVlU/VqyhwMamNN2K2yymaq0bnXfubeioW3MrRg+qJ+5giaDiXwd9ktCRsDDUKVJACSZI8qau5xJkHsC6QoDL7KA1Gjxi9NMPN/RyK/QM+96XZByjfNhmT7ARnlvfyI7aNvsP4q4rGA+RVBAimRYNXQ629f0ayBuXmrJyw3ItJ7pzKOeK9PcKkpv7B5V5XjghrSXIwo4Iz2bpyICtfsrw8Fjtteq7rXgnjN7jthrsuiyubSgh+pCbuWnjNqfYHW55TFw1l78nqfAxVrPd1RLeVMTp5hgepFwmSB6pfKtUWmGP1Qk+vAzS3U0KTGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TknF8VOgDgGiYuiP9/07Z+zuUiZHL1oCifUlKMx+OXs=;
 b=miCzQ2kJ+J70wcRwEVEl92TcB6+uxwWJ73a3Ygo83KDBLepKCdYRbB89mgeIDNr/ha0FBvC8yQV8lFKuRE7pfBBbk/HRxYvT+VBE0vV+51i4R4Z6z4acZFb45kHSMvsBoXeMyy661HE66iZ4hYcvxSrg4T14IL6z7+NxwGGVs9A=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5002.namprd03.prod.outlook.com (2603:10b6:5:1e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 16:36:09 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 16:36:09 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "charles.stanhope@gmail.com" <charles.stanhope@gmail.com>
Subject: Re: [PATCH 1/3] iio: dac: ad5592r: fix unbalanced mutex unlocks in
 ad5592r_read_raw()
Thread-Topic: [PATCH 1/3] iio: dac: ad5592r: fix unbalanced mutex unlocks in
 ad5592r_read_raw()
Thread-Index: AQHWU2vlQmmalJIG60O3Ys2vrhmxR6j6wECA
Date:   Mon, 6 Jul 2020 16:36:09 +0000
Message-ID: <872263d31269c590c34b46ccb6517ec26a330c18.camel@analog.com>
References: <20200706110259.23947-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200706110259.23947-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8f7cc97-42eb-4997-aaed-08d821cab022
x-ms-traffictypediagnostic: DM6PR03MB5002:
x-microsoft-antispam-prvs: <DM6PR03MB500288A71B746CEC5B161B4AF9690@DM6PR03MB5002.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9LC5ilOKoxsuCy5Vxri+VjOnBLHtB40aWQL/CrRuA9XCYQTC7Y42gTUl2+9dbN1dk152GU7bDCJXpxhtWGvmTxhxDZmXV0HYQxRulzFOHn8KTvzQC45SFCxG++IN81vUzFxHpA0tSM9IEbLLOYA3Kj9orHT7O3Hlh8nIokBkZao5dM3Vyre2HZdScQgiK5VsP3x8Ug7JyLvp6lrLZfkI5GGhI8bDRgVJ+ggGBkHO9qS0BZGlFeFprf6QSmVHCou/9MIhWXZSVeEgu3p29KQbfG2JAo8R21nDKJU9U+G7fHMRpyDHPKSA9WnGamNRW1+zEQahwHNYj70KHBnY2za3nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(39860400002)(396003)(346002)(376002)(26005)(2906002)(110136005)(316002)(478600001)(66446008)(66476007)(66946007)(64756008)(66556008)(4326008)(6506007)(91956017)(54906003)(76116006)(8936002)(6486002)(186003)(8676002)(2616005)(5660300002)(86362001)(36756003)(83380400001)(6512007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: kMA1YDDweyPphxsAE3ZejzRWDwpiQ/WYVi3iQAZCmNzT/dp751kmnUigO2j7LT2ecjro36jOd+kI202BsZk4xWsCfm9Ui+9vVFQLvX+1gXe/NmEe+4u8IIkHlqhtopFcBO1O/ujBx6qdZRur2i0lrOBcAawgZ2qxQYT/OZihQs2/dxTgCCKqhbqNB8v93suTRLdX023r1Kmdx5uwXfw7C0i+6+Db6Hq98ARaMttbFXGpL2yZCKN0q97fAvPqBU532SaiHJsQ35RpYuYcGJ+w85gPChEIIonzm6tswcAItd/0oTjkOesxFPMelCxTtv03UNNUhTlatKIWMiMyxyMKmBh2EFgUzKlytBDeXYcTJmuTmFx8w/jWRr5ANBU1g8J4ZAg8UDBUUGWBPcvAhvp5zmenUr4tWMHKzTxIdZD8Kg1NY9wZiGkA71BSb22kL5rV9Wa8JpVgJN8FGWJ0t4yYiLC0Nz2lPP4n6GSLsyORrp4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <42B7CD6EE98AFD45A2F7DB000CCC2782@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f7cc97-42eb-4997-aaed-08d821cab022
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 16:36:09.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1IsvqupQVrROR2xHP4JuOqhS9loUokDH5YNjO6VT/46sgNr7XaxzUX/sFEW4Uj5SDGCEHnNCRYUXJtXKucrxZ8Xd+EEQMYk0JxZRcDhaNvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5002
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_15:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=910 malwarescore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 cotscore=-2147483648 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007060120
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTA2IGF0IDE0OjAyICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IFRoZXJlIGFyZSAyIGV4aXQgcGF0aHMgd2hlcmUgdGhl
IGxvY2sgaXNuJ3QgaGVsZCwgYnV0IHRyeSB0byB1bmxvY2sgdGhlDQo+IG11dGV4IHdoZW4gZXhp
dGluZy4gSW4gdGhlc2UgcGxhY2VzIHdlIHNob3VsZCBqdXN0IHJldHVybiBmcm9tIHRoZQ0KPiBm
dW5jdGlvbi4NCj4gDQo+IEEgbmVhdGVyIGFwcHJvYWNoIHdvdWxkIGJlIHRvIGNsZWFudXAgdGhl
IGFkNTU5MnJfcmVhZF9yYXcoKSwgYnV0IHRoYXQNCj4gd291bGQgbWFrZSB0aGlzIHBhdGNoIG1v
cmUgZGlmZmljdWx0IHRvIGJhY2twb3J0IHRvIHN0YWJsZSB2ZXJzaW9ucy4NCj4gDQoNCkkgd2Fz
IGEgYml0IHRvbyBoYXN0eSB3aXRoIHRoaXMuDQpBcG9sb2dpZXMuDQpJJ2QgbGlrZSB0byBhZGQg
YSB0YWcgaGVyZS4NCg0KUmVwb3J0ZWQtYnk6IENoYXJsZXMgU3RhbmhvcGUgPGNoYXJsZXMuc3Rh
bmhvcGVAZ21haWwuY29tPg0KDQo+IEZpeGVzIDU2Y2E5ZGI4NjJiZjM6ICgiaWlvOiBkYWM6IEFk
ZCBzdXBwb3J0IGZvciB0aGUgQUQ1NTkyUi9BRDU1OTNSDQo+IEFEQ3MvREFDcyIpDQo+IFNpZ25l
ZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vZGFjL2FkNTU5MnItYmFzZS5jIHwgNCArKy0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2RhYy9hZDU1OTJyLWJhc2UuYyBiL2RyaXZlcnMvaWlv
L2RhYy9hZDU1OTJyLQ0KPiBiYXNlLmMNCj4gaW5kZXggNWM0ZTVmZjcwMzgwLi5jYzQ4NzU2NjBh
NjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2RhYy9hZDU1OTJyLWJhc2UuYw0KPiArKysg
Yi9kcml2ZXJzL2lpby9kYWMvYWQ1NTkyci1iYXNlLmMNCj4gQEAgLTQxMyw3ICs0MTMsNyBAQCBz
dGF0aWMgaW50IGFkNTU5MnJfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYgKmlpb19kZXYsDQo+ICAJ
CQlzNjQgdG1wID0gKnZhbCAqICgzNzY3ODk3NTEzTEwgLyAyNUxMKTsNCj4gIAkJCSp2YWwgPSBk
aXZfczY0X3JlbSh0bXAsIDEwMDAwMDAwMDBMTCwgdmFsMik7DQo+ICANCj4gLQkJCXJldCA9IElJ
T19WQUxfSU5UX1BMVVNfTUlDUk87DQo+ICsJCQlyZXR1cm4gSUlPX1ZBTF9JTlRfUExVU19NSUNS
TzsNCj4gIAkJfSBlbHNlIHsNCj4gIAkJCWludCBtdWx0Ow0KPiAgDQo+IEBAIC00NDQsNyArNDQ0
LDcgQEAgc3RhdGljIGludCBhZDU1OTJyX3JlYWRfcmF3KHN0cnVjdCBpaW9fZGV2ICppaW9fZGV2
LA0KPiAgCQlyZXQgPSAgSUlPX1ZBTF9JTlQ7DQo+ICAJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6DQo+
IC0JCXJldCA9IC1FSU5WQUw7DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiAgCX0NCj4gIA0KPiAg
dW5sb2NrOg0K
