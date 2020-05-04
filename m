Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBF51C325F
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 07:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgEDFwl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 01:52:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:18594 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725859AbgEDFwl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2020 01:52:41 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0445qbUE008397;
        Mon, 4 May 2020 01:52:37 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0a-00128a01.pphosted.com with ESMTP id 30s5s5uy9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 01:52:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABb6QYzymCmWerGbyRmc3I8fyG4mhTIRFekVHtaxZC8k8LqMAuPM5G/n4T5A8ynVx8E/VYcnMdhOSJwBUqVeaJcisVM2gCJKZgEPuvP5LGWaSK+6bNS/t3USEwvKCttwAlUXcPOHihp1V13SVUITUSJ5AdOyIVtckVabe0hUoEPHR14mLRo+dpdZTQYHqBaCMX7mEdAfbNAUwushWkWgPWqxVOFMjkOHnyFrtq6qN7otiHZnRkq+4bruxE8uoYuIZfJpx28XrI/OyUDYe2b0EZM7Gj91rbtlXrfNS17yxY43FZzm+FrpXt3QD1pWUp8Yq+smnTTuuIdggZtzjPn4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k9wlOc2lxzVbqRx9XMiOoZtQz/SM9DQvjSn+rp7dFI=;
 b=SShJTJSA5qPpu9MrFYo3dOss+5i0Z7wPsCtsL0Gxs/qHLIiyrvtDUGZOtELJaAtLAiJjI9DLZa8GOTkHVV09wmFqbvNOt5MYpwKD4ZBXYee8DU/2NMxh2nS5OlzV7V/C0o9OpMF5Q+CMtvz6pCJ0nfA2IlP9ajzXX8vYtofC4nbVHzOX+1Y5A40l2ZgYb5PH/x1DSp48o1ZcPSlQPqvz+5/3liTeijICGfkvUWKIjlCducQVMpz+E9p6BjaBwAYrwYMCyYXAmFKkAaS3SawVNr462ObYRuxW4R+QbvwN1tm1Mutb6NgKAcQu+TR8HPltT1RFLrz130Va9OthzbpODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k9wlOc2lxzVbqRx9XMiOoZtQz/SM9DQvjSn+rp7dFI=;
 b=KI6DPGAme2eiJ+FV9KFx4ffbtIeRkAucwWym6+1CTC90tuTUfLNJdNxuNW9aXTkmIvaapKmBAZTzg80nizfo3Woc/8bxoOc6OJZ9FEzL3SF5Hn1mVWVbhD947ZCXIN/kGIzjdiyuPTfsUbK53O2BqNBHODaiEB0NqC06/zrXxtA=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3546.namprd03.prod.outlook.com (2603:10b6:5:b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 05:52:35 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::40df:9aa4:c85a:a020]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::40df:9aa4:c85a:a020%4]) with mapi id 15.20.2958.030; Mon, 4 May 2020
 05:52:35 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: ad5933: rework probe to use devm_ function
 variants
Thread-Topic: [PATCH] staging: iio: ad5933: rework probe to use devm_ function
 variants
Thread-Index: AQHWHT/LBHaKQyj2SEOHWsNJccdzo6iVI60AgAJSPIA=
Date:   Mon, 4 May 2020 05:52:35 +0000
Message-ID: <8695e337ca71351cac2f262b0104a1411c173417.camel@analog.com>
References: <20200428093128.60747-1-alexandru.ardelean@analog.com>
         <20200502192542.63cc25a2@archlinux>
In-Reply-To: <20200502192542.63cc25a2@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e848913-75bf-47f5-9c8f-08d7efef5831
x-ms-traffictypediagnostic: DM6PR03MB3546:
x-microsoft-antispam-prvs: <DM6PR03MB354624B2DC884D2FB995426CF9A60@DM6PR03MB3546.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CjMsmuNQOOY0P4YMb1Ft7FlNZJzHZfM5bDb/D84JhZVUo/EtGyDcSURwjQLP4hdZCi3UEZzwW/2ZSQpBJscW/9YUBSPciykKSVzS6NYrACxlNIOMZnUVJbsWkyggT9XXZMvdI7OKflw7l++SvTFa6KCa7tJxV9Fsf4hzE9EsdnbbuAVvgDrN1IeOnsmLWavkT0jcVmwwHc1wvP766rHwYIBThS43CXaWG7GuyCMMQeaYmQI856qQVylijQAqbHcNLZjpQXnRTsxZBmexgraPoXfZvih4R1Y6ldSJTYNMoYMS8oIMJ5kwJBmQKwiWzRxMwN5VLdmbTx2h1l78ePQ3qli3WkyY405vlLfCeCAOGIv1zL2BaaAO+0qmK3owYXocouebzir9KaiIT7EcN1zRacen8Rxe5thtV6N4tUusUrmajA6SvASQzccsG313+cCy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(39850400004)(136003)(366004)(376002)(6916009)(91956017)(86362001)(5660300002)(71200400001)(316002)(6506007)(66946007)(4326008)(66476007)(54906003)(76116006)(66446008)(64756008)(2616005)(2906002)(66556008)(186003)(6486002)(478600001)(36756003)(26005)(8676002)(6512007)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZSKYJC+qXuZY3GXk1WBN/O7DaaBTdxcLAf2PNbTs65sf+UD0xkH6NuRapouVSUMf9fkTqYkQRyT6gJ2qhXrJQsXe5L6z5sdgodRnsJs2896OD05xWr1RyDJHGOebGZ2X58UCZJ/xf6YXb3X+RkWVLj+H57+HdajxR1vA6bxVaA/Fmwv2zsy0LWk67PnPS5G7vIKQUXXNUKPd1Tm9kWLKFzj2cs4pKbuOugU0gurKYf471UcftsDEp3rKanPBmdwQ2UwhIA5MP6DdDLoKQAbZO8BUVihY8FdneAYqLGZuh1wqQa07rhDWsySeXDw2vIXN5iez6rkdY1gvD2+fre3vZUP+5lnYtsAnA+kP7tRW7G6TaQibe6j9qedqACk+lmdmnLHessj/Nsx7UAFpA3Ddg36C2SgnaR2ubfnbDSUTgw7TT9XhTSIzPhJUTFMzXfJ1blVtJWr69IoRYEqVfyGEQOSObbROC3m7BskKcha4/SxZ8fyzxrMaGRWGPMZXL0LWEaP6wkB1rDjShmARbn17CQF6oAg8tFCTf42V3VNW53YREpDZvKEJ9UrKFsw7T5js6MgRu+OjCvGYWHDcdC61n6TP6mVlDy1/oYcqtb6U239pJO+LUzI9XFY44/6XEsiXFNIMr8BbIdv3UAD2QVR6/AZwTtqKrqvONkCn9Y1rgc7SVut+xAn1d/eYq77oyLe/b6uHKh+3psT+jsR96yQ0WSC6vNf4BL0SCEYtEshmniRC2dNMfBid3C5j+dM38JDAtF4n9aBkMa6A2atlB0VAUs1j9cb2EAGpu+LuO1y8QCI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5624C27EFBCAD49A86D016A3CE39C0C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e848913-75bf-47f5-9c8f-08d7efef5831
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 05:52:35.1053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /yoWu3OFq1In/VmjnPdnZX7zswEIezh/m7V4UzoC2q00mH3kQEkAxX58XnQvPwiprZ9Co3JgLTmpQzLFVtmVTPRmqZTQl67fq4VgrghbDiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3546
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_02:2020-05-01,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040050
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTA1LTAyIGF0IDE5OjI1ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsIDI4IEFwciAyMDIwIDEyOjMxOjI4ICswMzAwDQo+IEFsZXhhbmRydSBBcmRl
bGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGlz
IGNoYW5nZSBjbGVhbnMgdXAgdGhlIGRyaXZlcidzIHByb2JlIGZ1bmN0aW9uIHRvIHVzZSBvbmx5
IGRldm1fDQo+ID4gZnVuY3Rpb24gdmFyaWFudHMuIFRoaXMgYWxzbyBnZXRzIHJpZCBvZiB0aGUg
cmVtb3ZlIGZ1bmN0aW9uIGFuZCBtb3ZlcyB0aGUNCj4gPiBjbG9jayAmIHJlZ3VsYXRvciBkZS1p
bml0aWFsaXphdGlvbnMgdG8gdGhlICdhZDU5MzNfY2xlYW51cCgpJyBjYWxsYmFjay4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVh
bkBhbmFsb2cuY29tPg0KPiANCj4gQmFzaWMgcnVsZSBvZiB0aHVtYi4gV2hhdGV2ZXIgeW91IHJl
Z2lzdGVyIHdpdGggZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0DQo+IHNob3VsZCBvbmx5IGNsZWFu
dXAgb25lIG9uZSB0aGluZyBkb25lIGluIHRoZSBwcm9iZSBwYXRoLg0KPiBUaGVyZSBpcyBhbG1v
c3QgYWx3YXlzIGEgcmFjZSBpZiB5b3UgZG8gbW9yZSB0aGFuIG9uZSBiaXQgb2YgY2xlYW51cA0K
PiBwZXIgc3VjaCBjYWxsYmFjayArIGl0J3MgaGFyZGVyIHRvIHJldmlldyBhcyBpdCBmYWlscyB0
aGUgJ29idmlvdXNseSBjb3JyZWN0DQo+IHRlc3QnLg0KDQpJIGRpZCBub3Qga25vdyB0aGF0Lg0K
VGhhdCBpZGVhIG1pc3NlZCBtZSB1cCB1bnRpbCBub3cuDQoNCldpbGwgcmUtc3Bpbi4NClRoYW5r
cw0KQWxleA0KDQo+IA0KPiBKb25hdGhhbg0KPiANCj4gPiAtLS0NCj4gPiAgLi4uL3N0YWdpbmcv
aWlvL2ltcGVkYW5jZS1hbmFseXplci9hZDU5MzMuYyAgIHwgNTkgKysrKysrKystLS0tLS0tLS0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMzYgZGVsZXRpb25zKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9paW8vaW1wZWRhbmNlLWFu
YWx5emVyL2FkNTkzMy5jDQo+ID4gYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2ltcGVkYW5jZS1hbmFs
eXplci9hZDU5MzMuYw0KPiA+IGluZGV4IGFmMGJjZjk1ZWU4YS4uMDZhNmRjZDc4ODNiIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vaW1wZWRhbmNlLWFuYWx5emVyL2FkNTkz
My5jDQo+ID4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2lpby9pbXBlZGFuY2UtYW5hbHl6ZXIvYWQ1
OTMzLmMNCj4gPiBAQCAtNjAyLDExICs2MDIsMTIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9f
YnVmZmVyX3NldHVwX29wcw0KPiA+IGFkNTkzM19yaW5nX3NldHVwX29wcyA9IHsNCj4gPiAgCS5w
b3N0ZGlzYWJsZSA9IGFkNTkzM19yaW5nX3Bvc3RkaXNhYmxlLA0KPiA+ICB9Ow0KPiA+ICANCj4g
PiAtc3RhdGljIGludCBhZDU5MzNfcmVnaXN0ZXJfcmluZ19mdW5jc19hbmRfaW5pdChzdHJ1Y3Qg
aWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ICtzdGF0aWMgaW50IGFkNTkzM19yZWdpc3Rlcl9yaW5n
X2Z1bmNzX2FuZF9pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiArCQkJCQkgICAgICAgc3Ry
dWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gPiAgew0KPiA+ICAJc3RydWN0IGlpb19idWZmZXIg
KmJ1ZmZlcjsNCj4gPiAgDQo+ID4gLQlidWZmZXIgPSBpaW9fa2ZpZm9fYWxsb2NhdGUoKTsNCj4g
PiArCWJ1ZmZlciA9IGRldm1faWlvX2tmaWZvX2FsbG9jYXRlKGRldik7DQo+ID4gIAlpZiAoIWJ1
ZmZlcikNCj4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAgDQo+ID4gQEAgLTY3Niw2ICs2Nzcs
MTQgQEAgc3RhdGljIHZvaWQgYWQ1OTMzX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0K
PiA+ICAJfQ0KPiA+ICB9DQo+ID4gIA0KPiA+ICtzdGF0aWMgdm9pZCBhZDU5MzNfY2xlYW51cCh2
b2lkICpkYXRhKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgYWQ1OTMzX3N0YXRlICpzdCA9IGRhdGE7
DQo+ID4gKw0KPiA+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHN0LT5tY2xrKTsNCj4gPiArCXJl
Z3VsYXRvcl9kaXNhYmxlKHN0LT5yZWcpOw0KPiANCj4gUGxlYXNlIGRvIHR3byBzZXBhcmF0ZSBj
YWxsYmFja3Mgc28gdGhhdCB0aGVzZSBjYW4gYmUgaGFuZGxlZA0KPiBpbiB0aGUgY29ycmVjdCBw
bGFjZXMuICBJLmUuIHlvdSBkbyBzb21ldGhpbmcgdGhlbiBpbW1lZGlhdGVseQ0KPiByZWdpc3Rl
ciB0aGUgaGFuZGxlciB0byB1bmRvIGl0Lg0KPiANCj4gQ3VycmVudGx5IHlvdSBjYW4gZW5kIHVw
IGRpc2FibGluZyBhIGNsb2NrIHlvdSBoYXZlbid0IGVuYWJsZWQNCj4gKHdoaWNoIEkgYW0gZmFp
cmx5IHN1cmUgd2lsbCBnaXZlIHlvdSBhbiBlcnJvciBtZXNzYWdlKS4NCj4gDQo+ID4gK30NCj4g
PiArDQo+ID4gIHN0YXRpYyBpbnQgYWQ1OTMzX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGll
bnQsDQo+ID4gIAkJCWNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkICppZCkNCj4gPiAgew0KPiA+
IEBAIC03MDMsMjMgKzcxMiwyOCBAQCBzdGF0aWMgaW50IGFkNTkzM19wcm9iZShzdHJ1Y3QgaTJj
X2NsaWVudCAqY2xpZW50LA0KPiA+ICAJCWRldl9lcnIoJmNsaWVudC0+ZGV2LCAiRmFpbGVkIHRv
IGVuYWJsZSBzcGVjaWZpZWQgVkREDQo+ID4gc3VwcGx5XG4iKTsNCj4gPiAgCQlyZXR1cm4gcmV0
Ow0KPiA+ICAJfQ0KPiA+ICsNCj4gPiArCXJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgm
Y2xpZW50LT5kZXYsIGFkNTkzM19jbGVhbnVwLCBzdCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJ
CXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICAJcmV0ID0gcmVndWxhdG9yX2dldF92b2x0YWdlKHN0
LT5yZWcpOw0KPiA+ICANCj4gPiAgCWlmIChyZXQgPCAwKQ0KPiA+IC0JCWdvdG8gZXJyb3JfZGlz
YWJsZV9yZWc7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiAgDQo+ID4gIAlzdC0+dnJlZl9tdiA9
IHJldCAvIDEwMDA7DQo+ID4gIA0KPiA+ICAJc3QtPm1jbGsgPSBkZXZtX2Nsa19nZXQoJmNsaWVu
dC0+ZGV2LCAibWNsayIpOw0KPiA+ICAJaWYgKElTX0VSUihzdC0+bWNsaykgJiYgUFRSX0VSUihz
dC0+bWNsaykgIT0gLUVOT0VOVCkgew0KPiA+ICAJCXJldCA9IFBUUl9FUlIoc3QtPm1jbGspOw0K
PiA+IC0JCWdvdG8gZXJyb3JfZGlzYWJsZV9yZWc7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiAg
CX0NCj4gPiAgDQo+ID4gIAlpZiAoIUlTX0VSUihzdC0+bWNsaykpIHsNCj4gPiAgCQlyZXQgPSBj
bGtfcHJlcGFyZV9lbmFibGUoc3QtPm1jbGspOw0KPiA+ICAJCWlmIChyZXQgPCAwKQ0KPiA+IC0J
CQlnb3RvIGVycm9yX2Rpc2FibGVfcmVnOw0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICAJCWV4
dF9jbGtfaHogPSBjbGtfZ2V0X3JhdGUoc3QtPm1jbGspOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiBA
QCAtNzQyLDQxICs3NTYsMTUgQEAgc3RhdGljIGludCBhZDU5MzNfcHJvYmUoc3RydWN0IGkyY19j
bGllbnQgKmNsaWVudCwNCj4gPiAgCWluZGlvX2Rldi0+Y2hhbm5lbHMgPSBhZDU5MzNfY2hhbm5l
bHM7DQo+ID4gIAlpbmRpb19kZXYtPm51bV9jaGFubmVscyA9IEFSUkFZX1NJWkUoYWQ1OTMzX2No
YW5uZWxzKTsNCj4gPiAgDQo+ID4gLQlyZXQgPSBhZDU5MzNfcmVnaXN0ZXJfcmluZ19mdW5jc19h
bmRfaW5pdChpbmRpb19kZXYpOw0KPiA+ICsJcmV0ID0gYWQ1OTMzX3JlZ2lzdGVyX3JpbmdfZnVu
Y3NfYW5kX2luaXQoJmNsaWVudC0+ZGV2LCBpbmRpb19kZXYpOw0KPiA+ICAJaWYgKHJldCkNCj4g
PiAtCQlnb3RvIGVycm9yX2Rpc2FibGVfbWNsazsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICAN
Cj4gPiAgCXJldCA9IGFkNTkzM19zZXR1cChzdCk7DQo+ID4gIAlpZiAocmV0KQ0KPiA+IC0JCWdv
dG8gZXJyb3JfdW5yZWdfcmluZzsNCj4gPiAtDQo+ID4gLQlyZXQgPSBpaW9fZGV2aWNlX3JlZ2lz
dGVyKGluZGlvX2Rldik7DQo+ID4gLQlpZiAocmV0KQ0KPiA+IC0JCWdvdG8gZXJyb3JfdW5yZWdf
cmluZzsNCj4gPiAtDQo+ID4gLQlyZXR1cm4gMDsNCj4gPiAtDQo+ID4gLWVycm9yX3VucmVnX3Jp
bmc6DQo+ID4gLQlpaW9fa2ZpZm9fZnJlZShpbmRpb19kZXYtPmJ1ZmZlcik7DQo+ID4gLWVycm9y
X2Rpc2FibGVfbWNsazoNCj4gPiAtCWNsa19kaXNhYmxlX3VucHJlcGFyZShzdC0+bWNsayk7DQo+
ID4gLWVycm9yX2Rpc2FibGVfcmVnOg0KPiA+IC0JcmVndWxhdG9yX2Rpc2FibGUoc3QtPnJlZyk7
DQo+ID4gLQ0KPiA+IC0JcmV0dXJuIHJldDsNCj4gPiAtfQ0KPiA+IC0NCj4gPiAtc3RhdGljIGlu
dCBhZDU5MzNfcmVtb3ZlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpDQo+ID4gLXsNCj4gPiAt
CXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsN
Cj4gPiAtCXN0cnVjdCBhZDU5MzNfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4g
PiAtDQo+ID4gLQlpaW9fZGV2aWNlX3VucmVnaXN0ZXIoaW5kaW9fZGV2KTsNCj4gPiAtCWlpb19r
Zmlmb19mcmVlKGluZGlvX2Rldi0+YnVmZmVyKTsNCj4gPiAtCXJlZ3VsYXRvcl9kaXNhYmxlKHN0
LT5yZWcpOw0KPiA+IC0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHN0LT5tY2xrKTsNCj4gPiArCQly
ZXR1cm4gcmV0Ow0KPiA+ICANCj4gPiAtCXJldHVybiAwOw0KPiA+ICsJcmV0dXJuIGRldm1faWlv
X2RldmljZV9yZWdpc3RlcigmY2xpZW50LT5kZXYsIGluZGlvX2Rldik7DQo+ID4gIH0NCj4gPiAg
DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCBhZDU5MzNfaWRbXSA9IHsN
Cj4gPiBAQCAtODAxLDcgKzc4OSw2IEBAIHN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciBhZDU5MzNf
ZHJpdmVyID0gew0KPiA+ICAJCS5vZl9tYXRjaF90YWJsZSA9IGFkNTkzM19vZl9tYXRjaCwNCj4g
PiAgCX0sDQo+ID4gIAkucHJvYmUgPSBhZDU5MzNfcHJvYmUsDQo+ID4gLQkucmVtb3ZlID0gYWQ1
OTMzX3JlbW92ZSwNCj4gPiAgCS5pZF90YWJsZSA9IGFkNTkzM19pZCwNCj4gPiAgfTsNCj4gPiAg
bW9kdWxlX2kyY19kcml2ZXIoYWQ1OTMzX2RyaXZlcik7DQo=
