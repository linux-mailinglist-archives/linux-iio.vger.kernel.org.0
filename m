Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEF4E976D
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2019 08:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbfJ3Hy2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Oct 2019 03:54:28 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62970 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725822AbfJ3Hy2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Oct 2019 03:54:28 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9U7riEF020595;
        Wed, 30 Oct 2019 03:53:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vxwhg10d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 03:53:59 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id x9U7rw7E020974;
        Wed, 30 Oct 2019 03:53:58 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vxwhg10d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 03:53:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAkVesAISBuDXOxdScqLczXTxn2KbBg6NCBRoa6MVYkS538f2Hpu6iiyvpn2WzqdtiQoLUYIJHmbPLZZ9jXEDZ5ELC9xpdPhFvmuQRdhrCKfRZkK+zShhvg3ZataMdYyEOzWBstToxU2RTu6dfJv9MEUv+teJBzme2WUujb4d94yWYM2OdSzm8r+ZRlRHQbodTC7l9ksH4fTHoY+M6Ewpd0K4SAkx0xO/nZZR7um9q4l9kxVdNZQDuZ9/4iXiXtz/HrYLKZARpsByu4/JnRfSYr/0yhub2YFMWZfdprHYYTiPkWseQxHlrbLOqzWQjanW1odTG5MKfzBfARkM0zwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGX5ee6SEH7ErS4+6ZhDEkA/Rmq5g2Ky9dkRzLEzrZg=;
 b=Cj/M3N9R3sW5Ku5Ql/7S2FNEkoU7oVohK5mj3/lEprZCuJc2zg2lSHPMOHEf71WVf7qnfeOJppNhFrs1LKQuTXK1/kjkeqtAfRzTO+MwtAUPty0HdajkZCsI3mso9m3xjiSDb7IXESiivPgTGpVXAspk0cIy9KkaANNr8hyonn1K921vu/T+NM2NBxw0NvBW5Ij3niqiLgqeALlFg7spCS+D4k/ju6kach5T3DFIEbZUHJ5MXZogpIaQK0mCp/i0bnqkovpIMobF0VOiH9GnHU6hvQj+vL8OHGmIA5Z8SlYKo3S+TSeGnssTbF2rEVjYezRvF5rh8zEMkCY0mVvJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGX5ee6SEH7ErS4+6ZhDEkA/Rmq5g2Ky9dkRzLEzrZg=;
 b=EUeCuMj/i7WaUtj3BllzBaNiv6A1gDgEbHZh7wj3Yv9A3hX/I4b42zF0vkzVr9FoWC8rrFRx4eXoEQEWlLO9ZRIgudCrDCR0eoK2NFA4XkHHQgDwEGAiRGFAWW7GboDpF95RDvEbm8voYlcllBff96kZVNNSI2bu1vuG50ITohM=
Received: from BY5PR03MB5110.namprd03.prod.outlook.com (52.133.251.202) by
 BY5PR03MB5236.namprd03.prod.outlook.com (10.186.133.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.18; Wed, 30 Oct 2019 07:53:54 +0000
Received: from BY5PR03MB5110.namprd03.prod.outlook.com
 ([fe80::3131:7c25:b35:ea7a]) by BY5PR03MB5110.namprd03.prod.outlook.com
 ([fe80::3131:7c25:b35:ea7a%7]) with mapi id 15.20.2387.027; Wed, 30 Oct 2019
 07:53:54 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 2/2] iio: adis16480: Add debugfs_reg_access entry
Thread-Topic: [PATCH 2/2] iio: adis16480: Add debugfs_reg_access entry
Thread-Index: AQHVizIKq6cQNYfVPE+oBwVWvMUCMqdusx4AgAEJHwCAAjnagIAA4gIA
Date:   Wed, 30 Oct 2019 07:53:54 +0000
Message-ID: <b0912f5a99b4208e40dfd42cd7db98c53ead99ea.camel@analog.com>
References: <20191025124508.166648-1-nuno.sa@analog.com>
         <20191025124508.166648-2-nuno.sa@analog.com>
         <20191027163700.16d7d3f8@archlinux>
         <5a01de12c49f198d6d09b5e733225c6cc357f822.camel@analog.com>
         <20191029182529.00004f03@huawei.com>
In-Reply-To: <20191029182529.00004f03@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c04ab13b-ba4e-4bc4-6fd8-08d75d0e4fd1
x-ms-traffictypediagnostic: BY5PR03MB5236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR03MB5236A7EB6AE1D1B7259AD8C499600@BY5PR03MB5236.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(8936002)(91956017)(64756008)(76116006)(66476007)(5660300002)(66446008)(6246003)(66556008)(316002)(66946007)(6916009)(54906003)(6512007)(26005)(2501003)(6436002)(186003)(6486002)(76176011)(5640700003)(4001150100001)(8676002)(66066001)(99286004)(81166006)(81156014)(229853002)(102836004)(6506007)(118296001)(2906002)(86362001)(3846002)(6116002)(14444005)(25786009)(36756003)(5024004)(256004)(478600001)(476003)(446003)(11346002)(2616005)(4326008)(486006)(71190400001)(14454004)(71200400001)(305945005)(7736002)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5236;H:BY5PR03MB5110.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qiR6H3QDuJMTyORagFtILbl3Oem4Lp2rBsUZSRM4vNfohIEoBVGfU7pU1vqlQuzaL7nyAPbuXTxh9qNPe2Dn9zxeRkLf6OVixO2DXBh0SpAjVCIAuA1qqFJ8niwPELQVAuzxJdV3/t2/xoxReotpuYpE/Ef1CxOt97h31FgEcy1tYlHSSK2Qryv1paY0j/UqwQXV6YWnu+nxOFTO6SGLcwXoJ15xUqZZ+W5UUnugc0Nzq+1+fan8Nb7Y43pxhaCxzc9hmPa5wJJkDYLR5jnr78E+NjHV/XkYV1z9Gv1ew18oOJQgDPWGOxc8DWj1B6j6WUzK5QWK9YeZ0vFsdiXldNwD5vM3AOfNdSjNSuHth0KfoswWddLQ7sBAsuR361qMiYzgQ4/3QgIptDL9lyD1d36PlqbxPCYNC1+p6j2OMjUp+BOsITgHYYAdIe9qrH3B
Content-Type: text/plain; charset="utf-8"
Content-ID: <8719B671F38511468CF80A3F375BBA5B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04ab13b-ba4e-4bc4-6fd8-08d75d0e4fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 07:53:54.3796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmB2BD+U/wz72+1cgfdegKYxK00vIkjxP6OejnCYTQGLgl2GnVxhYNokjHAvMfH6aktwz0DntyJQhgm27qP/vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5236
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_03:2019-10-30,2019-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910300078
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTI5IGF0IDE4OjI1ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBNb24sIDI4IE9jdCAyMDE5IDA4OjI1OjI0ICswMDAwDQo+ICJTYSwgTnVubyIgPE51
bm8uU2FAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IE9uIFN1biwgMjAxOS0xMC0yNyBhdCAx
NjozNyArMDAwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gPiA+IE9uIEZyaSwgMjUgT2N0
IDIwMTkgMTQ6NDU6MDggKzAyMDANCj4gPiA+IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+
IHdyb3RlOg0KPiA+ID4gICANCj4gPiA+ID4gVGhlIGRyaXZlciBpcyBkZWZpbmluZyBkZWJ1Z2Zz
IGVudHJpZXMgYnkgY2FsbGluZw0KPiA+ID4gPiBgYWRpczE2NDgwX2RlYnVnZnNfaW5pdCgpYC4g
SG93ZXZlciwgdGhvc2UgZW50cmllcyBhcmUgYXR0YWNoZWQNCj4gPiA+ID4gdG8NCj4gPiA+ID4g
dGhlDQo+ID4gPiA+IGlpb19kZXYgZGVidWdmcyBlbnRyeSB3aGljaCB3b24ndCBleGlzdCBpZiBu
bw0KPiA+ID4gPiBkZWJ1Z2ZzX3JlZ19hY2Nlc3MNCj4gPiA+ID4gY2FsbGJhY2sgaXMgcHJvdmlk
ZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOdW5vIFPDoSA8bnVuby5zYUBh
bmFsb2cuY29tPiAgDQo+ID4gPiBBcyB5b3UgYXJlIHJlc3Bpbm5pbmcgdGhlIGZpcnN0IG9uZSBh
bmQgdGhpcyBpcyBwcm9iYWJseSBzdGFibGUNCj4gPiA+IG1hdGVyaWFsIGFzIHdlbGwsIHBsZWFz
ZSBhZGQgYSBmaXhlcyB0YWcgZm9yIHYyLg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4gICANCj4gPiAN
Cj4gPiBXaWxsIGRvIHRoYXQuIFNob3VsZCBJIGFsc28gY2MgU3RhYmxlPw0KPiBOb3BlLCBJJ2xs
IGFkZCB0aGF0IG9uY2Ugd2UgYXJlIGhhcHB5IHdpdGggaXQuICBPdGhlcndpc2UgdGhleSdsbA0K
PiBnZXQgc3BhbW1lZCB3aXRoIGV2ZXJ5IHZlcnNpb24gYWxvbmcgdGhlIHdheS4gIFRoZXkgb25s
eSBuZWVkDQo+IHRvIGNhcmUgb25jZSBpdCBoaXQncyBMaW51cycgdHJlZS4NCj4gDQoNClVwcywg
SSBhbHJlYWR5IHNlbnQgYSB2MiB3aXRoIHN0YWJsZSBvbiBDYy4gU29ycnkgZm9yIHRoYXQsIG5l
eHQgdGltZSBJDQprbm93Lg0KIA0KTnVubyBTw6ENCg0KPiBUaGFua3MsDQo+IA0KPiBKb25hdGhh
bg0KPiA+IFRoYW5rcyENCj4gPiBOdW5vIFPDoQ0KPiANCj4gDQoNCg==
