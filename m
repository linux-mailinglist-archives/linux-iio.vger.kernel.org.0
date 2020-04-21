Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125C71B1F4F
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 08:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDUG6P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 02:58:15 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18040 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbgDUG6O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 02:58:14 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03L6tEpk023176;
        Tue, 21 Apr 2020 02:58:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 30fx687qcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 02:58:11 -0400
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03L6wBsq025446;
        Tue, 21 Apr 2020 02:58:11 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0b-00128a01.pphosted.com with ESMTP id 30fx687qcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 02:58:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvCtfRAQJUvx1qLP/i5zpcbcqOwUVITJARHpQm6W1Pe8htN+IM3lvl6s2EGmYWzG1ccT2YUnIjm/VNt3fGVeToS8Xjd9T9LNNeDnwh+5eLX/iXfJB7buJ4Z9wB/eVudicgtnbWqRtKMQbShKwbevqKIGdhX6WefsbpzOUlvqXGHD1jHnmAamerxb8Vhq22WW6ejPQt8hrC2162qU12uWSWNwi3UWheBB+bx8nhTEW5A2dG6823rix65A53pWHi2++M4lUPCn80dJ1VtKmaxORkCvH32ZGNrQKGI1rjyLFYZWTgnPVrFzMMmGwlSkm9F0W1yMvzQUubTX/QknHNwQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IsNek3s3u1Lm2O/uze3UBzOYk5rciELrqj6LotRQh8=;
 b=Vw6SNtCRbirSHdLrWapTNupVYneEwvKv5msztHz8OWCqAb1ccvuHOSBZjFOHPPTz4PJZ2qqPgp1OpCfzU0qT8bsRaPfYK4csd/8FEqRoUwGiRoGXr5Is+E/oL9GVC7KUDV2zpuYXlWEEXMUuHDnDwq1J1VTvHrZ2PnfgacxR/jyJvJ0sv86uG2U9w447YsmLzjzF1i9NdK34YzvsIaE/e7lxSgPGVjTTd+b5MVxU8b4RlytLXjBMXJgPPs2Z98dXmKL8qhfTJGLsiSubEfmtvMw9qixpKwrTgzRTvIN7NTWvWALHVN1dlzqwOyUq/x+RlelFFG7K8ITROSd/3lmjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IsNek3s3u1Lm2O/uze3UBzOYk5rciELrqj6LotRQh8=;
 b=gjWspADyIhU4RwsxQY3q19nysuZ3tdZ1cHu+U6aF46D5rR9bx3FvlwMDSTzc4YTb6SbzuBLpLJ04sw/0j+shop3qYBKpF2A9E3bPZcWDRu5MmWlFZsDpiIIknAxV/aXg8izVHlq+x+/o3FiEq9/3WyGkehYwIWOnz8l2fgadu4U=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4859.namprd03.prod.outlook.com (2603:10b6:5:185::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 06:58:08 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 06:58:08 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 7/7] iio: light: vl6180: swap of.h for mod_devicetable.h
 and drop of_match_ptr
Thread-Topic: [PATCH 7/7] iio: light: vl6180: swap of.h for mod_devicetable.h
 and drop of_match_ptr
Thread-Index: AQHWFlvXQj8wNMwlzUSC4y4MFUucEKiBi6OAgACdNYCAAP/9AA==
Date:   Tue, 21 Apr 2020 06:58:08 +0000
Message-ID: <7b06bd58bd5744fd67eccd1115eef0098ab2ded4.camel@analog.com>
References: <20200419150206.43033-1-jic23@kernel.org>
         <20200419150206.43033-8-jic23@kernel.org>
         <0d3e8e58e39060ce9a28f2bb3b1d0161f4ed36f1.camel@analog.com>
         <20200420164557.00005648@Huawei.com>
In-Reply-To: <20200420164557.00005648@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66fd7f09-2931-412c-8d3f-08d7e5c15965
x-ms-traffictypediagnostic: DM6PR03MB4859:
x-microsoft-antispam-prvs: <DM6PR03MB48595902EAC9BDEDF83F8688F9D50@DM6PR03MB4859.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(366004)(8676002)(66476007)(66556008)(64756008)(66446008)(6506007)(36756003)(6916009)(186003)(6486002)(71200400001)(91956017)(2906002)(8936002)(54906003)(86362001)(478600001)(6512007)(5660300002)(76116006)(26005)(4326008)(2616005)(66946007)(316002)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RbcRXai9WBJfl2a8bOEwWAzbk0/bkUuHekeGvbZUYEv4Gf4woHy7FRAvUy5hXQ15Lsec/G3/ivhyKkFYlU3/FkBepqEO0NrPns53bJbf0yA3syPtbp66hRXCE9hxCxNe6ApGxo9pNGBtjfe3tVLgf9BkzRbURoGT3PAS6uNdnozNJniWe9ZVt8m9Ra69zWvqGOYAYtRVUOrU7hb5ESQp0MRlZPdfhCMHJtO8r9CReswjJMowO+03lATNtkYq48xLJWg2LGDDgvEn01YnGMot1yf5WVfPJTZPbo0HnuoWl1d5ZUvLmRRYWQzo4mUIJrBPd5gJHSvh08pf2PGU6INhuUPh7xpnTPy4ESbz7IDw/WqxSUPuJftrMxWcess/chq2TiZ1SAEgIbP41P7Sf30pLr2HMZcNepmQe0jxU7imWYich+SsFMpvv4SpULv2RYh3
x-ms-exchange-antispam-messagedata: w7q7JZ5UxbqMMolztLwxawzQUFQIPLhkOnYRxssLir8Zrp3Hq/0SBVskkxenUhSJhsBtVaaKXRUpQB88SPTi2eDGvafslpI0mhTQpGNXqDDLiBX3kA4Yni5NiRS1brJUERksxX2mJqtTnPOH86iI8w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <162522CB2640B74D992A561D0B6846A9@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fd7f09-2931-412c-8d3f-08d7e5c15965
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 06:58:08.6321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfH/mCEgv2Bk+iRRnj58jrtuOyp+TfNrKlqqePajGJNL+K+fgNsV63rpG62Zif0zX94ukm0HS+8LIF9/6kqVMXbQXn/GHJKOrk3AuvzwpUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4859
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_02:2020-04-20,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210058
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTIwIGF0IDE2OjQ1ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBNb24sIDIwIEFwciAyMDIwIDA2OjE5OjE3ICswMDAwDQo+ICJBcmRlbGVhbiwgQWxl
eGFuZHJ1IiA8YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBP
biBTdW4sIDIwMjAtMDQtMTkgYXQgMTY6MDIgKzAxMDAsIGppYzIzQGtlcm5lbC5vcmcgd3JvdGU6
DQo+ID4gPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5j
b20+DQo+ID4gPiANCj4gPiA+IEVuYWJsZXMgcHJvYmluZyB2aWEgQUNQSSBQUlAwMDAxIHJvdXRl
IGFuZCByZW1vdmVzIGFuIGV4YW1wbGUgb2YNCj4gPiA+IGFuIGFwcHJvYWNoIHdlIG5vIGxvbmdl
ciB3YW50IHBlb3BsZSB0byBjb3B5Lg0KPiA+ID4gICANCj4gPiANCj4gPiBUaGlzIGRvZXNuJ3Qg
aW5jbHVkZSAnbGludXgvbW9kX2RldmljZXRhYmxlLmgnLg0KPiA+IEknbSB3b25kZXJpbmcgbm93
IGlmIGl0IGlzIG5lZWRlZCBhdCBhbGwuDQo+ID4gU2hvdWxkIHdlIHJlbW92ZSBpdCBmcm9tIHRo
ZSByZXN0Pw0KPiA+IA0KPiBPb3BzLg0KPiANCj4gU28gdGhpcyBpcyBvbmUgb2YgdGhvc2UgY2xh
c3NpY3MuICBtb2RfZGV2aWNldGFibGUgaXMgaW5jbHVkZWQgYnkgdGhlIHNwaQ0KPiBhbmQgaTJj
IGhlYWRlcnMgYnV0IHRoZXJlIGlzIG5vIGFjdHVhbCAnbmVlZCcgZm9yIHRoZW0gdG8gZG8gc28u
IFRoZQ0KPiBjb3VsZCAoSSB0aGluaykgZ2V0IGF3YXkgd2l0aCBhbiBhcHByb3ByaWF0ZSBmb3J3
YXJkcyBkZWZpbml0aW9uLg0KPiANCj4gVGhpcyBpcyBpbiBjb250cmFzdCB0byB0aGUgZHJpdmVy
cyB0aGF0IG5lZWQgdG8ga25vdyB3aGF0IHRoYXQgc3RydWN0dXJlDQo+IGxvb2tzIGxpa2UgKGFz
IGRvZXMgdGhlIGkyYyBjb3JlIGRldmljZSB0cmVlIGNvZGUgZXRjKS4NCj4gDQo+IFNvIHNob3Vs
ZCB3ZSBpbmNsdWRlIGl0IG9yIG5vdD8gIEknbSBnZW5lcmFsbHkgb2YgdGhlIHZpZXcgdGhhdCB3
ZSBzaG91bGQNCj4gZm9yIHJlc2lsaWVuY2UgYnV0IG90aGVycyBmYXZvdXIgbWluaW1hbCBpbmNs
dWRlcy4NCg0KSSdtIGEgYml0IGluIHRoZSBtaWRkbGUgaGVyZSBiZXR3ZWVuIG1pbmltYWxpc20g
JiByZXNpbGllbmNlL21vcmUtZXhwbGljaXQtDQppbmNsdXNpb25zLg0KDQpObyBzdHJvbmcgb3Bp
bmlvbnMgYWJvdXQgaXQuDQpJJ3ZlIGJlZW4gdGhyb3VnaCAxLTIgaW5jbHVzaW9uLWhlbGwgZml4
aW5nOyBzdGlsbCBubyBzdHJvbmcgb3Bpbmlvbi4NCk1heWJlIEkgbmVlZCBhIGZldyBtb3JlLg0K
DQpJIHVzdWFsbHkgbGVhdmUgaXQgdG8gc29tZW9uZSBlbHNlJ3MgcHJlZmVyZW5jZS4NCg0KPiAN
Cj4gSm9uYXRoYW4NCj4gDQo+IA0KPiA+IFdpdGggdGhhdCBhZGRyZXNzZWQ6DQo+ID4gDQo+ID4g
UmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxv
Zy5jb20+DQo+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25h
dGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2lpby9s
aWdodC92bDYxODAuYyB8IDIgKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlv
L2xpZ2h0L3ZsNjE4MC5jIGIvZHJpdmVycy9paW8vbGlnaHQvdmw2MTgwLmMNCj4gPiA+IGluZGV4
IGQ5NTMzYTc2YjhmNi4uN2U2N2Q3YjNiZmI2IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9p
aW8vbGlnaHQvdmw2MTgwLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2xpZ2h0L3ZsNjE4MC5j
DQo+ID4gPiBAQCAtNTM3LDcgKzUzNyw3IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUoaTJjLCB2bDYx
ODBfaWQpOw0KPiA+ID4gIHN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciB2bDYxODBfZHJpdmVyID0g
ew0KPiA+ID4gIAkuZHJpdmVyID0gew0KPiA+ID4gIAkJLm5hbWUgICA9IFZMNjE4MF9EUlZfTkFN
RSwNCj4gPiA+IC0JCS5vZl9tYXRjaF90YWJsZSA9IG9mX21hdGNoX3B0cih2bDYxODBfb2ZfbWF0
Y2gpLA0KPiA+ID4gKwkJLm9mX21hdGNoX3RhYmxlID0gdmw2MTgwX29mX21hdGNoLA0KPiA+ID4g
IAl9LA0KPiA+ID4gIAkucHJvYmUgID0gdmw2MTgwX3Byb2JlLA0KPiA+ID4gIAkuaWRfdGFibGUg
PSB2bDYxODBfaWQsICANCj4gDQo+IA0K
