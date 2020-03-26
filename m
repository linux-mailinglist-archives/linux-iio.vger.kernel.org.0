Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA4193ABD
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 09:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgCZIWs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 04:22:48 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19214 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727585AbgCZIWr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 04:22:47 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02Q8JP9o029819;
        Thu, 26 Mar 2020 04:22:26 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs68bcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 04:22:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uy//o451YBdH22qTGF6lGcN9e5sPFzUSX1hSjMNO8a5JhS1V8GFFbDH8ahPlw/1/EwSqFrUNJbQ8UPojcyig02mb3p9HEZqlCDsEFtS79dmyXWDQnoM9DPRGaJtT0l98BppMZLuAegt4RCScUugEV0Bt02WkcfqrAwZ9dJaQjdzYWU3FLarASVE4kk8NfjRvirKgUKiGor1fKC/jFjbFvHFa7koe1TAcVn2Nbtz3LaRafpuD/tV+2N+Mn/NukEIPuOhHnK2a/onGknvS4xgl9/Y5QbrB9FJtxF2k3bTkmaEyD+B/1Fkgr4c9LJN7NImHp0PFyC4ucg4Piqkvvl+WqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmQylVdCTCbbdg4vtDSpaz1beGpeQLHM+Bw6BibvdcU=;
 b=BvAx6hYzviL8Pf+AXrqD7hFJ7emx3PPg2JFymHKXKSNJc5IHjsBWnyIpGipmFeWvgyen7MP+PNe25nlITGIgLKDrjGCBgirZxIFtkt0qB3oeee3dhEHmrJ2u7oAzD/rHOEjo5IyzPmrxUG/AgcAOzexJfPhY9hEYv91jAOJ2u3cg3/71IOk6NX75NozRk1K76EXlDMBhG0/uUtFUQT9yGKuLw7xq1r/AWCmnfFasX/f1P1PMoRP3emwBLSOv/At/SowiVbvFNfNovq39FTCO1xC3v2RzCyVyGsQZqyqMxUBSbLXlXL91D38lN1VXLrDxzibPT0X8wZWjHtYFF2pzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmQylVdCTCbbdg4vtDSpaz1beGpeQLHM+Bw6BibvdcU=;
 b=dq0UOcolzlkReHJD/l/kqcyTV2pvw2v+K0fh7paCa4O96UOEz0Czl1gk6NvTe22nwZpW3fJgMA96LTEY179+cCnu/t2z5E50wUkSV03ZOAMOMIl0/1LE3/Q1UbXzec/eOL6Dc3xcTasvtAGz9gnBWhbRPSZ2YEPVHsGWiUuVy3c=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4746.namprd03.prod.outlook.com (2603:10b6:5:18b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Thu, 26 Mar
 2020 08:22:25 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 08:22:25 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "mh12gx2825@gmail.com" <mh12gx2825@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v3 1/4] staging: iio: adc: ad7192: Re-indent enum labels
Thread-Topic: [PATCH v3 1/4] staging: iio: adc: ad7192: Re-indent enum labels
Thread-Index: AQHWAIOyM0GegiihW0G94ym/VoVsuahajoGAgAAAzAA=
Date:   Thu, 26 Mar 2020 08:22:25 +0000
Message-ID: <259e81ea9237cb764786b5f9aeb99a80ba4eed55.camel@analog.com>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
         <5c6bef6462d135b748f58f8c2645c60234482f52.1584904896.git.mh12gx2825@gmail.com>
         <0308197b41f1faeac7b0f76b07fcc6d65dc1cfd8.camel@analog.com>
In-Reply-To: <0308197b41f1faeac7b0f76b07fcc6d65dc1cfd8.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b683861-1e0b-4666-2126-08d7d15ed0b1
x-ms-traffictypediagnostic: DM6PR03MB4746:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB4746C9B3E1123BE469C08344F9CF0@DM6PR03MB4746.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(2616005)(36756003)(8676002)(26005)(81156014)(8936002)(6486002)(81166006)(4326008)(2906002)(6512007)(186003)(110136005)(6506007)(478600001)(316002)(66556008)(66446008)(5660300002)(7416002)(54906003)(64756008)(86362001)(66946007)(76116006)(91956017)(71200400001)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4746;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gUyJCwNAEF6JCXCU4BFqkt2+zATSJO24sikbQScrXzePmwslvo25HTh4M2pzi/FUjCgXdBJJHXda2G1QnnlRjhbQbVVpvZgKl92xAqRQHcspAO+BST0GBTLwzb8zsryrQkvK6nY8l9o4ab17HoNWRMq9Ac/Cn74NnvenXdpEKGv3fKkrHbU1e3Lu1nE881fbdOFEKudixxt79eka4mGTzX5k0TA8F5GuLpll9mm2HMw4w+66tlzQLbAevD0KAjjvTxCA1Pn1uBtFcbiRteOuIhHUPFgvKpkEZLvrDe00aWVTXOuzEF9egKPO7W0LCqM0iWdbqYy+81V9RQKzR22PoimGg5p09oq7/I7a0r6tU5wdkfS6HapwPHVQgjAwwXqbB3/r6jxxtTRfJFjekcKikWBGkiTvGcdJKs30Oq0r/M0nJrUCNjWD6IYEegXKLqXg
x-ms-exchange-antispam-messagedata: ylnRtau7/asmFmhqbcaJhpYUlsQNwYF1cth462OGMCxZaKXhqNLWUECnNMOmNgcKfOJ5ttL367hj0Y7KZEd0q4Oxfq5XChinvabpW5Bo7mTCnRc3qIJ2NsbHrQXaa+ZuIdbxHwYgPjCNMmXJ5kpHrQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F64253CB5F7D7D46973E0CD059215ACB@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b683861-1e0b-4666-2126-08d7d15ed0b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 08:22:25.4334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Q3luubXtIGpw+cHw59pS6JP1weLHbDjDBA3eXV5oAVxKzLmZRA+ZNj3jv0I4W8Z4NpOyfuLVhwH6F8q2FptJCDdbeCQ+NiT2DIGSeAIAyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4746
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_15:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=958
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260060
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTI2IGF0IDA4OjE5ICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdy
b3RlOg0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIDIwMjAtMDMtMjMgYXQgMDE6MjQgKzA1
MzAsIERlZXBhayBSIFZhcm1hIHdyb3RlOg0KPiA+IFtFeHRlcm5hbF0NCj4gPiANCj4gPiBSZS1p
bmRlbnQgZW51bSBsYWJlbHMgYXMgcGVyIGNvZGluZyBzdHlsZSBndWlkZWxpbmVzLiBQcm9ibGVt
DQo+ID4gZGV0ZWN0ZWQgYnkgY2hlY2twYXRjaCBzY3JpcHQuDQo+IA0KPiBJdCdzIGN1c3RvbWFy
eSB0byBrZWVwIHRoZSByZXZpZXcgdGFncyB5b3UgcmVjZWl2ZSBmcm9tIGVhcmxpZXIgcGF0Y2hz
ZXRzIGluDQo+IHlvdXIgbmV4dCBzZXRzLg0KPiBVb3UgY2FuIG5vdyBhZGQgaXQgW3R5cGljYWxs
eSBiZWZvcmUgeW91ciBTaWduZWQtb2ZmLWJ5IHRhZ10gc3RhcnRpbmcgd2l0aCBWMw0KPiBhbmQg
b253YXJkcy4NCj4gWW91IGRvbid0IG5lZWQgdG8gc2VuZCBhIFY0IGp1c3QgZm9yIHRoaXMuDQo+
IA0KPiBTbywgSSBhZGRlZCBbZm9yIHRoaXNdOg0KPiANCj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRy
dSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCg0KV2FpdDsgbXkg
YmFkOyBJIGFtIGdldHRpbmcgbG9zdCBpbiBlbWFpbHMgbm93Lg0KSSBmb3VuZCBhIFJldmlld2Vk
LWJ5IHRhZyBvbiB0aGlzIHNldC4NCkRpc3JlZ2FyZCB0aGlzIGNvbW1lbnQuDQoNCj4gDQo+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IERlZXBhayBSIFZhcm1hIDxtaDEyZ3gyODI1QGdtYWlsLmNvbT4N
Cj4gPiAtLS0NCj4gPiANCj4gPiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiA+IAktIE5vbmUuIFZlcnNp
b24gbnVtYmVyIGluY3JlbWVudCB0byBmb2xsb3cgcGF0Y2ggc2VyaWVzIHZlcnNpb24uDQo+ID4g
DQo+ID4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gPiAJMS4gU2VwYXJhdGVkIG90aGVyIGNoYW5nZSBp
bnRvIGEgc2VwYXJhdGUgcGF0Y2ggYXMgc3VnZ2VzdGVkIGJ5DQo+ID4gCSAgIEdyZWcgS0guDQo+
ID4gDQo+ID4gDQo+ID4gIGRyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYyB8IDQgKystLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYWQ3MTkyLmMgYi9kcml2ZXJzL2lpby9hZGMv
YWQ3MTkyLmMNCj4gPiBpbmRleCA4ZWMyOGFhOGZhOGEuLjAyOTgxZjNkMTc5NCAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYWQ3MTkyLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9h
ZGMvYWQ3MTkyLmMNCj4gPiBAQCAtMTU3LDggKzE1Nyw4IEBADQo+ID4gICAqLw0KPiA+ICANCj4g
PiAgZW51bSB7DQo+ID4gLSAgIEFENzE5Ml9TWVNDQUxJQl9aRVJPX1NDQUxFLA0KPiA+IC0gICBB
RDcxOTJfU1lTQ0FMSUJfRlVMTF9TQ0FMRSwNCj4gPiArCUFENzE5Ml9TWVNDQUxJQl9aRVJPX1ND
QUxFLA0KPiA+ICsJQUQ3MTkyX1NZU0NBTElCX0ZVTExfU0NBTEUsDQo+ID4gIH07DQo+ID4gIA0K
PiA+ICBzdHJ1Y3QgYWQ3MTkyX3N0YXRlIHsNCg==
