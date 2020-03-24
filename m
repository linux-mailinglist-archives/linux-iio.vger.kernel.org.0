Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDE3190700
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 09:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgCXIHD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 04:07:03 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6306 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbgCXIHC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 04:07:02 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O81axv003007;
        Tue, 24 Mar 2020 04:06:36 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywfu58uwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 04:06:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgQpBeG9eqeoN3FudzsrA02hNPB8S/1jW62tqJLPzH6Wj3i05Gn49pj1nK2Txx0pX74CiiKmpCMEIUjE8356hIrvvMSS429QhlrAVnkDNZuZatcbTCNTA0VenD/7+uQgYYIGlrr2YjEFdO/9ZOyQYyRunvk74nycEZ24AgzBdorHq5qUnLda6V4rmosPhPJ127LYDa4+ea/lwVa7bbMW42sF6gpWEyJ+jJW7aNsPQECpsAI8hvDYjuhHFaFg/PtuVlIdMa8aWE++60MM0Fy1wBrBGlvuRXrPktJbjSeYXhACU+3oYJg5jgubpHvXN8KeWF8mNiQueXTL/gntgz5neA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfAfQ2AGX9/WqyJcRzjEu7mjNsQflw3YimztfAbPR6s=;
 b=N4yTCtn8nQeM7vWDa9bbgIKy0U5WsgNgCgzomEZhSJD1k1s5JJ5AaTyb6/X4/hOLwHZ/Ir5TrJc/VLyvfZC/PgHiSCJUp1YigK1OJzY3JZuWCDTl6YLc+ZjzYoASKKk09arm5+1Yi2zGAQ38+8C5+Sj83AcmSo3LYC/NaZZFeM92u2Mapn4wEUStfGyTvipIIdrEtDts4PI/RvLV/0XDeaOMAeBMswUCyuddw00Y6MTQT1FA51xeOtv1Zn5l0N5334Y2g1VUSWjIpm0xdEloukxsU0X4L37az9R6tmoMLXBLGo5Px5+136/kgfmbMbRIlS8/Z+WRf6YzJc1Gvn2Q0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfAfQ2AGX9/WqyJcRzjEu7mjNsQflw3YimztfAbPR6s=;
 b=scAZMuz0r6fzZ+Xiwez7tX1bTSH8sY0r+dHWHZxICafrW9avIJLzWrrz0eVho2ulsSoY5sJ9soLM89iolC53XEjRfBB6GREuGO5dtfaCFp03RXZ3jP0MUbZDTKk7OWAhAoweObyYbP10qbw/iFtx0iuIbNFKH7ljMeRVoWv5KtA=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5020.namprd03.prod.outlook.com (2603:10b6:5:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Tue, 24 Mar
 2020 08:06:35 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 08:06:34 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "mh12gx2825@gmail.com" <mh12gx2825@gmail.com>,
        "sbrivio@redhat.com" <sbrivio@redhat.com>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>
CC:     "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [Outreachy kernel] Re: [PATCH v3 3/4] staging: iio: adc: ad7192:
 get_filter_freq code optimization
Thread-Topic: [Outreachy kernel] Re: [PATCH v3 3/4] staging: iio: adc: ad7192:
 get_filter_freq code optimization
Thread-Index: AQHWAIP7bG2z5cfkz02QNYgY4udV/ahVRpUAgAASO4CAAJEWAIAALpCAgABeHwCAAO6mgA==
Date:   Tue, 24 Mar 2020 08:06:34 +0000
Message-ID: <4385dc0509f035bbd14d85b81527997f7a2538e8.camel@analog.com>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
         <dad3cdb5de76234cc460300c31aea6af671f81ad.1584904896.git.mh12gx2825@gmail.com>
         <CAHp75VfC=y1mHW5=ghwdMMZYg=00_a5RB0Phz4j_vM77pehvMA@mail.gmail.com>
         <20200323014935.48048405@elisabeth>
         <CAHp75VfF+oDWsOF+_=U6YBeP60XLF=SLYzExa=5WjLSgoMUw9A@mail.gmail.com>
         <20200323131531.1d6c8f93@elisabeth> <20200323175223.GC22110@deeUbuntu>
In-Reply-To: <20200323175223.GC22110@deeUbuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d899cc74-d2bd-4f25-9f62-08d7cfca4558
x-ms-traffictypediagnostic: DM6PR03MB5020:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5020B61E65C102C5E01610DBF9F10@DM6PR03MB5020.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(5660300002)(6636002)(86362001)(4326008)(66446008)(66556008)(66476007)(91956017)(76116006)(66946007)(64756008)(2906002)(478600001)(2616005)(6486002)(6512007)(7416002)(8936002)(8676002)(81166006)(81156014)(316002)(26005)(36756003)(110136005)(6506007)(71200400001)(186003)(53546011)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5020;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aW/lRjHmiuLyHNrhZ4A/5Z1G4DuFdKcHOeDOkYZR56CApvyCr4pgZItbT3pGZnXSvJZfcbintcei+ibsFpeHTEcRIDsOTUtnFOOAAK7gZ210oMYe0LTGCBvZ9AhxgjSt9ud5BDfKkn7oHCBGKtoHj8o1D9Qv5aJZ9HA8mXpsf8ESynonDrtq1Z2Snnh05MhBz/aanHETJweNrhbSUJXEu/w8SaZ3qyGNljTLebg8vWCrYYFgWBefss6orjiC3LAeIoJA2t24/6bW/y6m6BD4nFLoq7F4ry2r18y8tGt2bRCUy1/XObirXAqTrxQ3qiS6pcc12YQIbzoWGl8a3CUeTE0aPth9cdyQQ1UEZvQqPeYSsZONFbbbI69+9WocMtU5p2xlRlGWG7mPNkA2eY8K+x/PrO/zSfTAtbzEx8a+bO3YuFeo5lElSB25KILDPCkU
x-ms-exchange-antispam-messagedata: rBtTqnMjiE9OlnykwiGfSwCnoH+IHby96xMB04B66aCZHSYRL00MHRUv+n9Em3KXq8T5W5jGhGfpZie1bQe314jikpTyRHWFY5sbtMkNfxXf3EsZlVbG+pRR+E4x6ENjA3K719y+oIxxqWZQrY3PCA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A49F50E5539B54DA7413AE0A968F0CC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d899cc74-d2bd-4f25-9f62-08d7cfca4558
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 08:06:34.8254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDEyIxO1cKMlD9DPtChNhtSrirAU2WMJxFu0IYpQ6Yc4WKLq7kNAkVxnVQcOlCeDuOR6XZZdgJsZpwwZr60fiQNnXFbWW8gNCci7Cudeazg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5020
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_02:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1031 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003240042
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTIzIGF0IDIzOjIyICswNTMwLCBERUVQQUsgVkFSTUEgd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IE9uIE1vbiwgTWFyIDIzLCAyMDIwIGF0IDAxOjE1OjMxUE0gKzAx
MDAsIFN0ZWZhbm8gQnJpdmlvIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjMgTWFyIDIwMjAgMTE6Mjg6
NTIgKzAyMDANCj4gPiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+
IHdyb3RlOg0KPiA+IA0KPiA+ID4gT24gTW9uLCBNYXIgMjMsIDIwMjAgYXQgMjo0OSBBTSBTdGVm
YW5vIEJyaXZpbyA8c2JyaXZpb0ByZWRoYXQuY29tPiB3cm90ZToNCj4gPiA+ID4gT24gTW9uLCAy
MyBNYXIgMjAyMCAwMTo0NDoyMCArMDIwMA0KPiA+ID4gPiBBbmR5IFNoZXZjaGVua28gPGFuZHku
c2hldmNoZW5rb0BnbWFpbC5jb20+IHdyb3RlOiAgDQo+ID4gPiA+ID4gT24gU3VuLCBNYXIgMjIs
IDIwMjAgYXQgOTo1NyBQTSBEZWVwYWsgUiBWYXJtYSA8bWgxMmd4MjgyNUBnbWFpbC5jb20+DQo+
ID4gPiA+ID4gd3JvdGU6ICANCj4gPiA+ID4gPiA+IEN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2Yg
dGhlIGZ1bmN0aW9uDQo+ID4gPiA+ID4gPiBhZDcxOTJfZ2V0X2F2YWlsYWJsZV9maWx0ZXJfZnJl
cQ0KPiA+ID4gPiA+ID4gcmVwZWF0cyBjYWxjdWxhdGlvbiBvZiBvdXRwdXQgZGF0YSByYXRlIGEg
ZmV3IHRpbWVzLiBXZSBjYW4gc2ltcGxpZnkNCj4gPiA+ID4gPiA+IHRoZXNlIHN0ZXBzIGJ5IHJl
ZmFjdG9yaW5nIG91dCB0aGUgY2FsY3VsYXRpb24gb2YgZkFEQy4gVGhpcyB3b3VsZA0KPiA+ID4g
PiA+ID4gYWxzbw0KPiA+ID4gPiA+ID4gYWRkcmVzc2VzIHRoZSBjaGVja3BhdGNoIHdhcm5pbmcg
b2YgbGluZSBleGNlZWRpbmcgODAgY2hhcmFjdGVyLiAgDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
SSdtIG5vdCBzdXJlIHlvdSBkaWQgYW4gZXF1aXZhbGVudCBjaGFuZ2VzLiBJIGJlbGlldmUgaW4g
dGhlIG9yaWdpbmFsDQo+ID4gPiA+ID4gY29kZSBwcmVjaXNpb24gaXMgYmV0dGVyLiBDb25zaWRl
ciBsb3cgY2xvY2sgZnJlcXVlbmNpZXMgd2hlbiAxMCBiaXQNCj4gPiA+ID4gPiByaWdodCBzaGlm
dCBtYXkgaGlkZSBzb21lIGJpdHMgb2YgdGhlIGRpdmlzaW9uLiAgDQo+ID4gPiA+IA0KPiA+ID4g
PiBOb3RlIHRoYXQgdGhvc2UgYml0cyBhcmUgZXZlbnR1YWxseSAiaGlkZGVuIiBpbiB0aGUgc2Ft
ZSB3YXkgbGF0ZXIsICANCj4gPiA+IA0KPiA+ID4gRXZlbiBpZiBtYXRoZW1hdGljYWxseSAoYXJp
dGhtZXRpY2FsbHkpIGV2YWx1YXRpb24gaXMgY29ycmVjdCwgd2UgaGF2ZQ0KPiA+ID4gdG8gcmVt
ZW1iZXIgdGhhdCBjb21wdXRlcnMgYXJlIGJhZCB3aXRoIGZsb2F0aW5nIHBvaW50IGFuZCBlc3Bl
Y2lhbGx5DQo+ID4gPiBrZXJuZWwsIHdoaWNoIHVzZXMgaW50ZWdlciBhcml0aG1ldGljLiBUaGF0
IHNhaWQsIGl0J3MgZWFzeSB0byBnZXQNCj4gPiA+IG9mZi1ieS1vbmUgZXJyb3IgKGR1ZSB0byBw
cmVjaXNpb24gbG9zdCkgaWYgd2UgZG8gYmlnIGRpdmlzaW9uIGJlZm9yZQ0KPiA+ID4gKG5vdCBz
byBiaWcpIG11bHRpcGxpY2F0aW9uLg0KPiA+IA0KPiA+IFRoYXQncyBleGFjdGx5IHRoZSBwb2lu
dCBJIHdhcyB0cnlpbmcgdG8gZXhwbGFpbiBiZWxvdzogc3dhcHBpbmcgc3RlcHMNCj4gPiBpbiBh
IHNlcXVlbmNlIG9mIERJVl9ST1VORF9DTE9TRVNUKCkgKCpub3QqIG9mIGFyaXRobWV0aWMgZGl2
aXNpb25zKSwNCj4gPiAqc2hvdWxkKiBub3QgYWZmZWN0IHF1YW50aXNhdGlvbiAoIm9mZi1ieS1v
bmUiKSBlcnJvci4NCj4gPiANCj4gPiBJJ20gbm90IGVudGlyZWx5IHN1cmUgaW4gdGhpcyBjYXNl
LCBzbyBhIHF1aWNrICJkZW1vbnN0cmF0aW9uIiBpbg0KPiA+IFB5dGhvbiBvciBzdWNobGlrZSBh
cyB5b3Ugc3VnZ2VzdGVkIHdvdWxkIGJlIG5pY2UgdG8gaGF2ZSwgaW5kZWVkLg0KPiA+IA0KPiA+
ID4gPiBkZXNwaXRlIHRoZSBkaWZmZXJlbnQgc2VxdWVuY2UsIGR1ZSB0byBESVZfUk9VTkRfQ0xP
U0VTVCgpIGJlaW5nIHVzZWQNCj4gPiA+ID4gYXQgZXZlcnkgc3RlcCAoYm90aCBiZWZvcmUgYW5k
IGFmdGVyIHRoZSBjaGFuZ2UpIHdpdGhvdXQgb3RoZXINCj4gPiA+ID4gb3BlcmF0aW9ucyBvY2N1
cnJpbmcuICANCj4gPiA+IA0KPiA+ID4gQnkgdGhlIHdheSwgd2hlcmUgQUQ3MTkyX1NJTkMzX0ZJ
TFRFUiBhbmQgQUQ3MTkyX1NJTkM0X0ZJTFRFUg0KPiA+ID4gbXVsdGlwbGljYXRpb25zIGRpc2Fw
cGVhciBhbmQgd2h5Pw0KPiA+IA0KPiA+IFRob3NlIHdlcmUgaW4gZmFjdCBkaXZpc2lvbnMgKG11
bHRpcGxpY2F0aW9ucyBvZiB0aGUgZGl2aXNvcikuIE92ZXJhbGwsDQo+ID4gdGhlc2Ugc3RlcHMg
YXJlIG5vdyBhcnJhbmdlZCBpbiBhIHdheSBjbG9zZXIgdG8gaG93IHRoZXkgYXJlIHByZXNlbnRl
ZA0KPiA+IGluIHRoZSBkYXRhc2hlZXQgbWVudGlvbmVkIGhlcmUgKHVwIHRvICJDaG9wIEVuYWJs
ZWQiIHBhcmFncmFwaCwgcGFnZQ0KPiA+IDI2KS4NCj4gPiANCj4gDQo+IFRoYW5rIHlvdSBBbmR5
IGFuZCBTdGVmYW5vIGZvciB5b3VyIGNvbW1lbnRzLiBJdHMgdmVyeSB0aG91Z2h0ZnVsLiBJIGFt
DQo+IG5vdCBtdWNoIGZhbWlsaWFyIHdpdGggUHl0aG9uIHNvIGZhciwgYnV0IHRoaW5raW5nIG9u
IGV2YWx1YXRpbmcgeW91cg0KPiBzdWdnZXN0aW9uIGluIGEgc2FtcGxlIGMgcHJvZ3JhbS4gSSB3
aWxsIHNoYXJlIHRoZSBvdXRjb21lIHNob3J0bHkuDQoNCithZGRpbmcgTWlyY2VhIENhcHJpb3J1
DQoNClVtbSwgdGhpcyBtYXRoLWNsZWFudXAgbG9va3MgcHJldHR5IGRhbmdlcm91cy4NCklmIHBv
c3NpYmxlLCBJIHdvdWxkbid0IGNoYW5nZSBpdC4NCkF0IGxlYXN0IHdpdGhvdXQgc29tZSB0ZXN0
aW5nIG9uIEhXLg0KDQpNYXliZSBkb2luZyBtYXRoLXNpbXVsYXRpb25zIGluIFB5dGhvbiBzY3Jp
cHRzIHdvdWxkIGFsc28gd29yaywgYnV0IG5vdCBzdXJlLg0KDQo+IA0KPiBEZWVwYWsuDQo+IA0K
PiANCj4gPiAtLSANCj4gPiBTdGVmYW5vDQo+ID4gDQo=
