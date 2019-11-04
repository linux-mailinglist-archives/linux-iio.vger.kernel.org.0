Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB57EE382
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfKDPT2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:19:28 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:54728 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728510AbfKDPT1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:19:27 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4F9wxw021654;
        Mon, 4 Nov 2019 10:19:21 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a75ht64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:19:21 -0500
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4FFWFP026169;
        Mon, 4 Nov 2019 10:19:21 -0500
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2051.outbound.protection.outlook.com [104.47.40.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a75ht62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:19:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PorCJFoVknCzAd/quiIWcN5PrDw6AYFuNswkfladYblmGrokEOaJZZg70hB3RDvXhMAUV8eQnKMddQ1pdFK7Gqcy5YF+TaSx5H3FKv+5Wqhy03Amr48YT6coTkxpFg6UPcsoy8XrM8KCL9ptAfIjPRLLA80uJjNksHYcyLBcZJ/yyx7cxw0zrnCKV6G/m9yhsnHg2eout05O8SsxtTOnxTKVGtlnxSNf04jQYDTRgynQ2DP59CfruClrNAo9F11pZU1yK+lke8kuEZYZTbLcAjGFbUjeeknd9SYtwLBifVUMiPvHfCCi0n1jl+h7uz30SO3s8LgCZyxGsnabnhYyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b/fRhT7jaMpQ1c7z9N8e4Dde7NpftsZgXZn8AnQbi0=;
 b=CNhTjUNHPRIrIxZOR64jgswkA0ozyfzp9hxoN55hk7v/lP3OuCiCZenvDNvzDlbriVm4bcXxn7iLfvTH5ZqeuT597ImyvdFMVcjHQJ71iL3vP4bQ0DgUCeMsExTF6KNcCDtkeJ3xjV38YlY6LTHjyZu8aXwoeOKsU1qnxxP1uCFwVhLxNh09XWzjTkCeaIu9hhCFN/eiTpwjM7HQkxs/Ku7m+Q+1LndEEjIr4cnHdWRsZWtwPsoRl9cNf7Z213Wwo4qqKKKZfbBhMxt9/SQazslsxGywTj0sAR2bmVPy1WdnRKZVykqMgP7A2Ktcuz4nS73ooN4A83wWxosvBMiULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b/fRhT7jaMpQ1c7z9N8e4Dde7NpftsZgXZn8AnQbi0=;
 b=AmYxRjqKgd4uowVSXZyujm+GKuA41MsSDMrD21pt+PrVfGUbYPBzSEXf96QII3abb6z9maF9dAJTjnYmho0/n1TqK25DG8BnNXDHxWsrq99P6JLpLdlQBIygnRCTMJYi2kHtVFRY5kbcINQTlJlcM6svri2P32Hmha8+1zy6F0U=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5302.namprd03.prod.outlook.com (20.180.4.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:19:13 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:19:13 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "b38611@freescale.com" <b38611@freescale.com>
Subject: Re: [PATCH] iio: adc: vf610: use devm_platform_ioremap_resource
Thread-Topic: [PATCH] iio: adc: vf610: use devm_platform_ioremap_resource
Thread-Index: AQHVgeW2oesYBfQqykackDDxu4Yhnqd7QqEA
Date:   Mon, 4 Nov 2019 15:19:13 +0000
Message-ID: <0e4fecb0b690549305690972d3a83bef13b026e8.camel@analog.com>
References: <20191013164349.2049538-1-jic23@kernel.org>
In-Reply-To: <20191013164349.2049538-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c7731ca-cc19-483d-0da5-08d7613a59ab
x-ms-traffictypediagnostic: CH2PR03MB5302:
x-microsoft-antispam-prvs: <CH2PR03MB5302E37EB5092EA786B980B2F97F0@CH2PR03MB5302.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(39860400002)(396003)(189003)(199004)(4001150100001)(66446008)(99286004)(446003)(2616005)(3846002)(6116002)(2906002)(305945005)(478600001)(6246003)(6512007)(4326008)(5660300002)(14454004)(71190400001)(71200400001)(14444005)(256004)(25786009)(2501003)(26005)(8676002)(6506007)(76176011)(81166006)(81156014)(66066001)(486006)(476003)(11346002)(7736002)(36756003)(229853002)(118296001)(6486002)(110136005)(86362001)(316002)(54906003)(8936002)(66556008)(186003)(66946007)(66476007)(102836004)(6436002)(64756008)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5302;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WyOKa3CfynCXdCWc7WDwLVwtbbGEosAO0rp1m56FBy8s+x70kcAtr2VoIxiWYdTJi7btVT45VlTZ7X7lrj5cCRYobG9lYN4xF3biY+NX8UITXROmBVBl5v1vAYHEEyGa0/RbaMn5iJzwqUjtujRXwa8Nj4LWRnxMcjBXOV+CPtKKUE/QTvcbOg1UVWBKS/qOzJB4uoId4jjXXwXcgWb8AJK5hurdrVm9woFui4ZxQ6aGnro0izFqworbrwsG9PqlL+2z9Kqaq760jtGAOeNbrhYYnObzxFLhKo9VIyjL1SbZ59+JfjyFSZIG5Q1ABnGzw3PoLVTFCVcZCMJtGygxLL2jdPSBYBosR0SncZwdoWV0SVFpJTL/C838UW/+FWoouhXBU5/FH08FO4SPUN6NO/uzlujyMbKkdn0Yu2a7QoUH8XGlDhWDRFjqgfEb2WTv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5AC740BDD1CF34B840736E1CA4B882E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7731ca-cc19-483d-0da5-08d7613a59ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:19:13.5917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xllouGWOgzjbCNZlIDSrETFg/Jv1+Hq4wriiZlTIaDcHj3Z7EGFA0dKqtzitqINmkaOG4bJtI1Y4ri6lVS6YMwWYCaZyw9st7tMVcvB07JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5302
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_09:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911040151
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDE3OjQzICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBSZWR1Y2VzIGJvaWxlcnBsYXRlLg0KPiANCj4gU3VnZ2VzdGVkIGJ5IGNvY2NpbmVs
bGUNCj4gQ0hFQ0sgICBkcml2ZXJzL2lpby9hZGMvdmY2MTBfYWRjLmMNCj4gZHJpdmVycy9paW8v
YWRjL3ZmNjEwX2FkYy5jOjgxOToxLTExOiBXQVJOSU5HOiBVc2UNCj4gZGV2bV9wbGF0Zm9ybV9p
b3JlbWFwX3Jlc291cmNlIGZvciBpbmZvIC0+IHJlZ3MNCj4gDQoNClJldmlld2VkLWJ5OiBBbGV4
YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+IFNpZ25l
ZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4N
Cj4gQ2M6IEZ1Z2FuZyBEdWFuIDxiMzg2MTFAZnJlZXNjYWxlLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2lpby9hZGMvdmY2MTBfYWRjLmMgfCA0ICstLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lp
by9hZGMvdmY2MTBfYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvdmY2MTBfYWRjLmMNCj4gaW5kZXgg
OThiMzA0NzViYmM2Li5jYjczODBiZjA3Y2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2Fk
Yy92ZjYxMF9hZGMuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvdmY2MTBfYWRjLmMNCj4gQEAg
LTgwMiw3ICs4MDIsNiBAQCBzdGF0aWMgaW50IHZmNjEwX2FkY19wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCB2ZjYxMF9hZGMgKmluZm87DQo+
ICAJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldjsNCj4gLQlzdHJ1Y3QgcmVzb3VyY2UgKm1lbTsN
Cj4gIAlpbnQgaXJxOw0KPiAgCWludCByZXQ7DQo+ICANCj4gQEAgLTgxNSw4ICs4MTQsNyBAQCBz
dGF0aWMgaW50IHZmNjEwX2FkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2
KQ0KPiAgCWluZm8gPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiAgCWluZm8tPmRldiA9ICZwZGV2
LT5kZXY7DQo+ICANCj4gLQltZW0gPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNP
VVJDRV9NRU0sIDApOw0KPiAtCWluZm8tPnJlZ3MgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBk
ZXYtPmRldiwgbWVtKTsNCj4gKwlpbmZvLT5yZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jl
c291cmNlKHBkZXYsIDApOw0KPiAgCWlmIChJU19FUlIoaW5mby0+cmVncykpDQo+ICAJCXJldHVy
biBQVFJfRVJSKGluZm8tPnJlZ3MpOw0KPiAgDQo=
