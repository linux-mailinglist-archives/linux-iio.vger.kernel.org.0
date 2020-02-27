Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4AA17112C
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 07:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgB0G6O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 01:58:14 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:12466 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727663AbgB0G6O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 01:58:14 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R6uWda007165;
        Thu, 27 Feb 2020 01:58:12 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ydtrv1xw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 01:58:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz1CegdMozgJjoc4RZZeyjR2KY2EuTwPUeEyyh8GabwEQfG1TIJdcwXUAk6KDBgES1deCnT8K4L8hHR4yGh6cifjEQF+g62GVjQuNmbwpyGdFPt82LXkI4JZCFwqrSn734ck/APqy+M9d+oVrohsCufVChLF1DUkeAUSlVrygCPnEP1OYKzudhwcPIC/uX/RV0T/LTT3cbJ62CzWWV6AM/vKkdO22H/ZEKpCfApeIZLDqPA+YwO+pfp1sbMRVpXA5dKmtUIaKEm4uCzNDQv8v+FeC/1FCFsxGtX+jF+zE0sgeGFoSAkrZTJyOMn6HLEFHId3qcDYy8eR5RBJJa1y7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxvvqn/XC6kPcklUzt0Yo54BCTTMFp1XsP3yxUFkEqw=;
 b=QSEXXTrHyhVgB65GkFRQar34WtBYay62UN4GpXqVOjSJFTRdz3yaBb98u/A2+RSYN8KAwTap90Kvaa47b1emZrfpsdWknNITCfwLrDtaTZuCPRBadDyo/Z6m9VcDy/RPzWGHt+KWZ8H2ugmy0QuZVy/j8Z4OzDXbUsodPq/2J+g3fTqyd+PsuSC8f/cbpS+ibau0bmbCR6XRRQTTO1qqwBjV200FGAVdT1C4xU85GCw77OJM9zeu0zfTOlXRWR76aJ/zkaLm63J7PNuo1Iy4ovSOXt/18ZNXuL6EAemDacmOiyhyUbLegEqs4hKtPsy7SrAjw6XrmgQceBKLSNjfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxvvqn/XC6kPcklUzt0Yo54BCTTMFp1XsP3yxUFkEqw=;
 b=cO/T+HMuiPoBiMA5VPSev2TMXXT2FADdOQQW5SEPbAaMmh0DB2VdypjLHBAwnZUsVYd2lAVRe6lhfhzXhcboi9y5Jfbtegydd3oXb8OSfB+/KpDgVvudV/afVGepMj6pvSE0dLV9hSjeViez4mtDPJYzSf6psXlJ5yl2WEY5kD4=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5335.namprd03.prod.outlook.com (2603:10b6:610:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Thu, 27 Feb
 2020 06:58:11 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 06:58:11 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "rohitsarkar5398@gmail.com" <rohitsarkar5398@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: query about locking in IIO
Thread-Topic: query about locking in IIO
Thread-Index: AQHV6/66Pk/plpKKl0GYGdml23kVmqgtC/oAgACveACAAOPvAA==
Date:   Thu, 27 Feb 2020 06:58:11 +0000
Message-ID: <a644fc06b461361e6d6b001fe2e4e50dbaba6943.camel@analog.com>
References: <20200225171150.GD24663@SARKAR>
         <67108b1b3172e5f51d54a51fbe5a23c7ff4ce5ba.camel@analog.com>
         <5e56aa03.1c69fb81.3f3c3.8b05@mx.google.com>
In-Reply-To: <5e56aa03.1c69fb81.3f3c3.8b05@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e3efe88-3d13-4f8d-f7cf-08d7bb5268a2
x-ms-traffictypediagnostic: CH2PR03MB5335:
x-microsoft-antispam-prvs: <CH2PR03MB5335E1B7012C4BB3CFA25769F9EB0@CH2PR03MB5335.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(136003)(376002)(189003)(199004)(4326008)(81156014)(6506007)(6916009)(81166006)(6486002)(71200400001)(26005)(8936002)(478600001)(6512007)(8676002)(64756008)(86362001)(66946007)(91956017)(2616005)(5660300002)(66556008)(2906002)(66446008)(186003)(36756003)(316002)(66476007)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5335;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kH3NAE5xEfDJxrnYca6NtRe/beh81eUCwdLzwBeBw6hqyKqw0SZQC5RUJeFfxpT90SCc1cSMNgu9laSLVBmpejTbq9a80G0ZoGA/m69LddxDMcqDp90TafmeYPKHDvt03shSs1u3kUg5eKqKHihsqn+9m5yaftZ2Kll1x2DYCjwepiqGAwt/4dRh1GkitsHBNMSbXypdq8f0VDzAlkSmmNfdEFXm+E6/P6Ep/xBH0y9QYZdBbBt7Tv3LW+cKcwBcKt+NGHNa9zW4ZjZYM5CIeeSIb0KExy6SkywaSa8vjrBwG+EByLJWRuK5t768Fcar2dKwUPCO6mWDxzrN+R7syEYW2IiLgwE0Pno9CzcQp8K2uGQRTUZxF50NFLEJhN3BTQ+GJiu33ReQWvFgE8aVlbot2WpjjMpIJ0fkM60i38bTDduB7KisOR6EsCx2mUeu
x-ms-exchange-antispam-messagedata: 8/ytJd+HM77WFisjpBioIltz6GGRfhbBD7EHTxdb/BhBQTBmZufeX0DtS0i1guwI3qfpMVrdY940pUd3WNX3TEoYfkv/5fB2ByDTA4mPyU4L2UCbBVelxTWWWWx0CalJDdrTbSmepNSj24GdJx7a7w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF9C5E99574A1F4FA2492EA46DD23568@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3efe88-3d13-4f8d-f7cf-08d7bb5268a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 06:58:11.2760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDPz3+wiaDhO8WNZpucwneLLGrZmRDl2GHAG8ibsgi/Yw3QbihoL6rW34TGZ829UfnUN7ek4LqH5v/xWA1Kyhew82GvR8YoWoBCp0+WY0EQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5335
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_01:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1031 mlxlogscore=796
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTAyLTI2IGF0IDIyOjU1ICswNTMwLCBSb2hpdCBTYXJrYXIgd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFdlZCwgRmViIDI2LCAyMDIwIGF0IDA2OjU0OjIxQU0gKzAw
MDAsIEFyZGVsZWFuLCBBbGV4YW5kcnUgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIwLTAyLTI1IGF0
IDIyOjQxICswNTMwLCBSb2hpdCBTYXJrYXIgd3JvdGU6DQo+ID4gPiBIaSwNCj4gPiA+IENvdWxk
IHNvbWVvbmUgZXhwbGFpbiB3aHkgdXNpbmcgaW5kaW9fZGV2LT5tbG9jayBkaXJlY3RseSBpcyBh
IGJhZCBpZGVhPw0KPiA+ID4gRnVydGhlciBleGFtcGxlcyBvZiBjYXNlcyB3aGVyZSBpdCBjYW5u
b3QgYmUgcmVwbGFjZWQgd2lsbCBiZSBoZWxwZnVsDQo+ID4gPiANCj4gPiANCj4gPiBKb25hdGhh
biBtYXkgYWRkIG1vcmUgaGVyZS4NCj4gPiANCj4gPiBCdXQgaW4gZ2VuZXJhbCwgZWFjaCBkcml2
ZXIgc2hvdWxkIGRlZmluZSBpdCdzIG93biBleHBsaWNpdCBsb2NrIGlmIGl0IG5lZWRzDQo+ID4g
dG8uDQo+ID4gU29tZSBkcml2ZXJzIG5lZWQgZXhwbGljaXQgbG9ja2luZywgc29tZSBkb24ndC4N
Cj4gPiANCj4gPiBBIGxvdCBvZiBvdGhlciBmcmFtZXdvcmtzIGFscmVhZHkgZGVmaW5lIGxvY2tz
IGFscmVhZHkuDQo+ID4gTGlrZSwgZm9yIGV4YW1wbGUsIHdoZW4gYW4gSUlPIGRyaXZlciB1c2Vz
IHNvbWUgU1BJIHRyYW5zZmVycywgdGhlIFNQSQ0KPiA+IGZyYW1ld29yaw0KPiA+IGFscmVhZHkg
dXNlcyBzb21lIGxvY2tzLiBTbywgeW91IGRvbid0IHR5cGljYWxseSBuZWVkIGV4dHJhIGxvY2tp
bmc7IHdoaWNoDQo+ID4gZm9yDQo+ID4gc29tZSBJSU8gZHJpdmVycyB0cmFuc2xhdGVzIHRvOiBu
byBleHRyYSBleHBsaWNpdCBsb2NraW5nLg0KPiA+IA0KPiA+IEkgZ3Vlc3MgSm9uYXRoYW4gYWxz
byB3YW50cyB0byBtb3ZlIHRoZSBtbG9jayB0byBiZSB1c2VkIG9ubHkgaW4gdGhlIElJTw0KPiA+
IGZyYW1ld29yay4NCj4gPiBJbiBzb21lIGNhc2VzLCBpZiBkcml2ZXJzIHVzZSB0aGlzIG1sb2Nr
LCBhbmQgdGhlIGZyYW1ld29yayB1c2VzIGl0LCB5b3UgY2FuDQo+ID4gZW5kDQo+ID4gdXAgdHJ5
aW5nIHRvIGFjcXVpcmUgdGhlIHNhbWUgbWxvY2sgdHdpY2UsIHdoaWNoIGNhbiBlbmQtdXAgaW4g
YSBkZWFkbG9jay4NCj4gPiBUaGVzZSB0aGluZ3MgY2FuIHNvbWV0aW1lcyBzbGlwIHRocm91Z2gg
dGhlIGNvZGUtcmV2aWV3Lg0KPiANCj4gVGhpcyBtYWtlcyBzZW5zZQ0KPiANCj4gPiBJIGd1ZXNz
IHRoZSBkb2NzIG5lZWQgYSBiaXQgb2YgdXBkYXRlLg0KPiA+IEJlY2F1c2U6DQo+ID4gDQo+ID4g
KiBAbWxvY2s6ICAgICAgICAgICAgICBbRFJJVkVSXSBsb2NrIHVzZWQgdG8gcHJldmVudCBzaW11
bHRhbmVvdXMgZGV2aWNlDQo+ID4gc3RhdGUNCj4gPiAqICAgICAgICAgICAgICAgICAgICAgIGNo
YW5nZXMNCj4gPiANCj4gPiBJIHRoaW5rIGl0IHNob3VsZCBiZSBjb252ZXJ0ZWQgdG8gW0lOVEVS
Tl0NCj4gPiANCj4gPiA+IFRoYW5rcywNCj4gPiA+IFJvaGl0DQo+ID4gPiANCj4gDQo+IEFzIGEg
Zm9sbG93IHVwIHdvdWxkIEkgYmUgcmlnaHQgdG8gYXNzdW1lIHRoYXQgYXMgbG9uZyBhcyB0aGUg
bWxvY2sgaXMNCj4gbm90IGJlaW5nIGluIHRoZSBJSU8gZnJhbWV3b3JrLCBleHBsaWNpdCBsb2Nr
aW5nIHNob3VsZCBiZSB0aGUgd2F5IHRvDQo+IGdvPw0KDQpUaGUgcXVlc3Rpb24gc291bmRzIGEg
Yml0IGhhcmQgdG8gZm9sbG93Lg0KRWFjaCBkcml2ZXIgc2hvdWxkIGRlZmluZSBpdCdzIG93biBs
b2NraW5nIGlmIGl0IG5lZWRzIGl0Lg0KbWxvY2sgd2lsbCBjb250aW51ZWQgdG8gYmUgdXNlZCBv
bmx5IGluIHRoZSBJSU8gZnJhbWV3b3JrOyBpdCB3b24ndCBiZSByZW1vdmVkLg0KW0lOVEVSTl0g
aXMganVzdCBhIG1hcmtlciBpbiB0aGUgZG9jLXN0cmluZyB0byBtYWtlIHN1cmUgcGVvcGxlIGRv
bid0IHVzZQ0KdGhlc2UgZmllbGRzIGluIGRyaXZlcnMuDQoNCg0KPiBUaGFua3MsDQo+IFJvaGl0
DQo=
