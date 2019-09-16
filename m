Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAB7B35E6
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 09:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfIPHtL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 03:49:11 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:43452 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbfIPHtK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 03:49:10 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G7m099030585;
        Mon, 16 Sep 2019 03:48:34 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2051.outbound.protection.outlook.com [104.47.48.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v0t2938tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 03:48:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaVmDOb404so7Zo08zBKmmvs0oiZzKblp7IRcBtqRIewI8TvUGrxmyxqIcutQwpIcowbcXW+2B9AAq9eW2oJU0pEDjqRkkmB4E0sq4oeVasCN/lHdKBBnp+Pd+fleOA7WWRZHLwpqrs4MDz5MC5ozSohtgM1ZZiylfxIehJLF3d3Em9ND4bATgOI6PWtFT7RuaD3B/SODmbvTwo6Ju6PSOnxvc7DnC3cxL1I12o3aac8kee8YNcC9SVZ60C4NegYbwJMAxbqhjCJQWE5mFU1r4FjdrkRurKKQtXUqPK+9/+Z1pI8b2I3cDWlVR3JLG4hqlLj9DOc9PSdoiGhjhJCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIPl4S1OG8ULp7Qkv9/tXSu1ngYosYCt94KBV8rDai8=;
 b=Fpf/tEr0tCH3gvPx8fIv1krMPsYFgbG/v8pROAy9azUIBWJlzXUGtwdsLw1MYwYn++pZL/HECjn/UYVqMZLhdjeFzmBbSD9S6/ri8YJGh/mZO4HbH0vTZu24l9j3tHCYUqT8t7+8Lwd5iKWlgg5j574qHPaqaWZs1dZx7VN8/87oe/5gwbNOm1fk4xTHfVAC4nN42UmtSvdiY50LpU/QtVHohS8PyQmtqNsAi4y2B6E8AaMpVsPQdom7ryKWIpakmyVypNACjDWaov+OAK/aqCqWAEb6JO7SBreAF0RiC8PsjMNzlQuM4PhPdj4os+a938WTeWiEu5oRj/GiVe0KJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIPl4S1OG8ULp7Qkv9/tXSu1ngYosYCt94KBV8rDai8=;
 b=eemo/6xgVZUc2CBJ2NK23aJoPn4pOPSHaXqasNWH/+Jj+uYWTLB9t6oFz7GcyZvDduKP7bM98iFa50JK04nYSTi4EV3WsSzW4EzWs9ihPLvPhuk5OlGf5/RO6QbdtBJi8FQbOMnz74fnNMxr0liVv7S3FlBRTX1FNgmJwZ84cjQ=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5287.namprd03.prod.outlook.com (20.180.4.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Mon, 16 Sep 2019 07:48:32 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 07:48:32 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 0/4] Fixes for ad7949
Thread-Topic: [PATCH 0/4] Fixes for ad7949
Thread-Index: AQHVaXiJvkTPKl6mIkeot7v5rveqP6cpZ9+AgAA8Y4CAAu9YgIABXRAAgAACqYA=
Date:   Mon, 16 Sep 2019 07:48:32 +0000
Message-ID: <60ccde67a06a896003126a0d86701b635010d2e6.camel@analog.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
         <1f13820761bbdb4db685a90e9bcf35a388b246cf.camel@analog.com>
         <2b7ab6c3-6ff6-69b5-bbd4-f8a1966b6b57@essensium.com>
         <20190915114939.13fc6d44@archlinux>
         <CAN8YU5NVWubV0HeXDHZ=fJThaKTC5R2AoNtX-BsDdifVkiJZnA@mail.gmail.com>
In-Reply-To: <CAN8YU5NVWubV0HeXDHZ=fJThaKTC5R2AoNtX-BsDdifVkiJZnA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2421652-9c6e-4134-ee09-08d73a7a45c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR03MB5287;
x-ms-traffictypediagnostic: CH2PR03MB5287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB528743D4B7DBA35B399BAAB5F98C0@CH2PR03MB5287.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(396003)(346002)(136003)(43544003)(199004)(189003)(51914003)(110136005)(76116006)(102836004)(14454004)(6506007)(7736002)(186003)(305945005)(26005)(229853002)(478600001)(76176011)(86362001)(66574012)(66066001)(2906002)(2501003)(66946007)(486006)(8676002)(14444005)(256004)(3846002)(6116002)(71200400001)(71190400001)(316002)(6486002)(54906003)(2616005)(446003)(11346002)(36756003)(66556008)(118296001)(66476007)(64756008)(66446008)(25786009)(53936002)(6512007)(476003)(81166006)(81156014)(6436002)(99286004)(5660300002)(6246003)(4326008)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5287;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WEY7h0FDuBRdLTcGId/wE52Z7fldlz+bAuFchaah9s02RY+eSKSbN8lgwG6Jee64WCp9KjZh557tP+7IxlI6Qn2kMT5/T6+gWKEL1mrOes2FI9CyDCoF28biC1E5YmGfLzNdps6XdwHoE1QgmAU6F8frVyVT7Z2NoSnmH7HDBb1BaXquOICKYnHG82c9DMGtphE7tmZJw3IJ7PBjK2TAyDyu9uYbgbEJUNdnvbZCvZNx7WVGxUKGv0UhK1OWc6ozQz9gc+uUDHmZBDN/SMCnU0p4vQdUYhMQo0Hb9YeqJC8mWqhP/T4MR9cIDIqSgkhaMY3RI1H6MnD8Ermq83DOkIxgFRUzmlBqeqdi4Iim7dMjL7B+mtWdlT/H0lTO6dvz6frVPsIiC+jpQSOklCvA5W1TRht3zu1l8XJ0aJjVATQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C8EFCE03A6AA241BB2B25AEEA9E2ECC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2421652-9c6e-4134-ee09-08d73a7a45c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 07:48:32.4165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhpRP6XGIK64GVrKzeNbs45V8NyGhKYzDnRBiKnND0NwtKNRI2p/sfN+R/gH7b9GbquE+PgZl7xBx6d+l85GWqO9YP9Qx6zVn7uv53NENE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5287
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_04:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909160085
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTE2IGF0IDA5OjM5ICswMjAwLCBBbmRyZWEgTWVyZWxsbyB3cm90ZToN
Cj4gSWwgZ2lvcm5vIGRvbSAxNSBzZXQgMjAxOSBhbGxlIG9yZSAxMjo0OSBKb25hdGhhbiBDYW1l
cm9uDQo+IDxqaWMyM0BrZXJuZWwub3JnPiBoYSBzY3JpdHRvOg0KPiA+IE9uIEZyaSwgMTMgU2Vw
IDIwMTkgMTY6MDA6MjkgKzAyMDANCj4gPiBDb3VyZXQgQ2hhcmxlcy1BbnRvaW5lIDxjaGFybGVz
LWFudG9pbmUuY291cmV0QGVzc2Vuc2l1bS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+ID4gTGUgMTMv
MDkvMjAxOSDDoCAwOToyNCwgQXJkZWxlYW4sIEFsZXhhbmRydSBhIMOpY3JpdCA6DQo+ID4gPiA+
IE9uIFRodSwgMjAxOS0wOS0xMiBhdCAxNjo0MyArMDIwMCwgQW5kcmVhIE1lcmVsbG8gd3JvdGU6
DQo+ID4gPiA+ID4gW0V4dGVybmFsXQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoaXMgcGF0Y2gg
c2VyaWVzIGZpeGVzIGFkNzk0OSBkcml2ZXIgaW5jb3JyZWN0bHkgcmVhZCBkYXRhLCBzaW1wbGlm
eSB0aGUNCj4gPiA+ID4gPiBjb2RlLCBhbmQgZW5mb3JjZXMgZGV2aWNlIHRpbWluZyBjb25zdHJh
aW50cy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGlzIGhhcyBiZWVuIHRlc3RlZCBvbiBhIFVs
dHJhWmVkIFNPTSArIGEgY3VzdG9tIGNhcnJpZXIgZXF1aXBwZWQgd2l0aA0KPiA+ID4gPiA+IHNl
dmVyYWwgQUQ3Njg5IEEvRHMuIFBhdGNoZXMgaGF2ZSBiZWVuIGRldmVsb3BlZCBvbiBhIFhpbGlu
eCB1cHN0cmVhbQ0KPiA+ID4gPiA+IGtlcm5lbCBhbmQgdGhlbiByZWJhc2VkIG9uIGxpbnV4LW5l
eHQga2VybmVsLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiBUaGFua3MgZm9yIHRoZSBwYXRjaGVzLg0K
PiA+ID4gPiBBZGRlZCBDaGFybGVzLUFudG9pbmUgdG8gYWxzbyB0YWtlIGEgbG9vay4NCj4gPiA+
ID4gQXBvbG9naWVzIGZvciBub3QgdGhpbmtpbmcgb2YgYWRkaW5nIGhpbSBzb29uZXIuDQo+ID4g
PiA+IA0KPiA+ID4gPiBJIHR5cGljYWxseSB0cnkgdG8gcmV2aWV3IGNoYW5nZXMgZm9yIEFESSBw
YXJ0cywgYnV0IGhlIHdyb3RlIGl0LCBzbyBoZSBtYXkgaGF2ZSBtb3JlIGlucHV0IHRoYW4gSSBk
by4NCj4gPiA+ID4gSm9uYXRoYW4gd2lsbCBsaWtlbHkgYWxzbyB0YWtlIGEgbG9vay4NCj4gPiA+
ID4gDQo+ID4gPiA+IElmIGl0J3MgYWdyZWVkLCBJIHdvdWxkIHNheSB0byBhdCBsZWFzdCB0YWtl
IHRoZSBmaXJzdCBwYXRjaCAoImlpbzogYWQ3OTQ5OiBraWxsIHBvaW50bGVzcyAicmVhZGJhY2si
LWhhbmRsaW5nDQo+ID4gPiA+IGNvZGUiKQ0KPiA+ID4gPiBub3cgYW5kIHNlZSBhYm91dCB0aGUg
cmVzdC4NCj4gPiA+ID4gVGhlIHJlc3QgYXJlIGEgYml0IG1vcmUgb3BlbiB0byBkaXNjdXNzaW9u
LCBzbyBhIHYyIG1heSBoYXBwZW4uDQo+ID4gPiANCj4gPiA+IEhpLA0KPiA+ID4gDQo+ID4gPiBE
b24ndCB3b3JyeS4gRHVlIHRvIHRoZSBmYWN0IEkgZG9uJ3QgaGF2ZSBvbiBteSBtYWlsIGNsaWVu
dCBhY2Nlc3MgdG8NCj4gPiA+IHRoZSB3aG9sZSBkaXNjdXNzaW9ucywgSSdtIG1ha2luZyBhIGNv
bXBsZXRlIGFuc3dlciB0aGVyZSBiYXNlZCBvbiB0aGUNCj4gPiA+IGFyY2hpdmUgb2YgdGhlIG1h
aWxpbmcgbGlzdC4gU29ycnkgZm9yIHRoYXQuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gRm9yIHRo
ZSBwYXRjaCAxLCBJIGFwcHJvdmUgaXQgdG9vLiBUaGlzIHBhcnQgb2YgY29kZSBpcyB1c2VsZXNz
IGJlY2F1c2UNCj4gPiA+IHRoZSBmZWF0dXJlIHdhcyByZW1vdmVkLiBSSVAgbXkgY29kZS4gOkQN
Cj4gPiA+IA0KPiA+ID4gRm9yIHRoZSBwYXRjaCAyLCB0aGUgY2FjaGUgaW5mb3JtYXRpb24gd2Fz
IGFkZGVkIGR1ZSB0byBjb21tZW50IGZyb20NCj4gPiA+IEpvbmF0aGFuIENhbWVyb24gd2hlbiBJ
IGRldmVsb3BlZCB0aGUgZHJpdmVyLiBUaGUgY29tbWVudCB3YXM6DQo+ID4gPiANCj4gPiA+ID4g
TG9vayB2ZXJ5IGNhcmVmdWxseSBhdCB0aGUgcmVxdWlyZW1lbnRzIGZvciBhIGJ1ZmZlciBiZWlu
ZyBwYXNzZWQNCj4gPiA+ID4gdG8gc3BpX3N5bmMuICBJdCBuZWVkcyB0byBiZSBETUEgc2FmZS4g
IFRoaXMgb25lIGlzIG5vdC4gIFRoZSB1c3VhbA0KPiA+ID4gPiB3YXkgdG8gZG8gdGhhdCBlYXNp
bHkgaXMgdG8gcHV0IGEgY2FjaGVsaW5lIGFsaWduZWQgYnVmZmVyIGluIHlvdXINCj4gPiA+ID4g
YWQ3OTQ5X2FkY19jaGlwIHN0cnVjdHVyZS4NCj4gPiANCj4gPiBUaGUgc2hvcnQgdmVyc2lvbiBv
ZiB0aGlzIGlzIGJlc3QgaWxsdXN0cmF0ZWQgd2l0aCBhbiBleGFtcGxlLg0KPiA+IFRoaXMgb25s
eSBhcHBsaWVzIHN5c3RlbXMgd2hlcmUgdGhlIERNQSBlbmdpbmVzIGFyZSBub3QgY29oZXJlbnQN
Cj4gPiAoaS5lLiBhIGNoYW5nZSBtYWRlIGJ5IGEgRE1BIGVuZ2luZSBpcyBub3QgYXV0b21hdGlj
YWxseSB1cGRhdGVkIHRvDQo+ID4gIGFsbCBvdGhlciBwbGFjZXMgYSBjb3B5IGlzIGhlbGQgaW4g
Y2FjaGVzIGluIHRoZSBzeXN0ZW0sIHdlIGhhdmUgdG8NCj4gPiAgZG8gaXQgYnkgaGFuZCkuDQo+
ID4gDQo+ID4gV2UgaGF2ZSBhIHN0cnVjdHVyZSBsaWtlDQo+ID4gc3RydWN0IGJvYiB7DQo+ID4g
ICAgICAgICBpbnQgaW5pdGlhbF9kYXRhOw0KPiA+ICAgICAgICAgdTggYnVmZmVyWzhdOw0KPiA+
ICAgICAgICAgaW50IG1hZ2ljX2ZsYWdzDQo+ID4gfTsNCj4gPiANCj4gPiBXaGVuIGEgRE1BIHRy
YW5zZmVyIGlzIHNldHVwIGludm9sdmluZyAnYnVmZmVyJywgdGhlIERNQSBlbmdpbmUgbWF5IHRh
a2UNCj4gPiB1cCB0byBhIGNhY2hlbGluZSAodHlwaWNhbGx5IDY0IGJ5dGVzKSBpbmNsdWRpbmcg
YnVmZmVyLCBtYWtlIGEgY29weSBvZiBpdA0KPiA+IGFuZCBhc3N1bWUgdGhhdCB0aGUgb25seSBi
aXQgb2YgaGFyZHdhcmUgd29ya2luZyBpbiB0aGlzIGNhY2hlbGluZSBpcyBpdHNlbGYuDQo+ID4g
KExpbnV4IGlzICdndWFyYW50ZWVpbmcnIHRoaXMgd2hlbiBpdCB0ZWxscyB0aGUgRE1BIGVuZ2lu
ZSB0byB1c2UgdGhpcyBidWZmZXIuJy4NCj4gPiBXaGlsc3QgdGhhdCBETUEgaXMgZ29pbmcgb24s
IGEgQ1BVIGNhbiB3cml0ZSBzb21ldGhpbmcgaW4gbWFnaWMgZmxhZ3MuDQo+ID4gVGhhdCBzb21l
dGhpbmcgbWlnaHQgYmUgaW1wb3J0YW50IGJ1dCB1bnJlbGF0ZWQgdG8gdGhlIERNQSB0cmFuc2Zl
ciBnb2luZw0KPiA+IG9uLg0KPiA+IA0KPiA+IFRoZSBETUEgZmluaXNoZXMsIGhhdmluZyBwdXQg
bmV3IGRhdGEgaW4gdGhlIGJ1ZmZlciBlbGVtZW50IG9mIHRoZSBjb3B5DQo+ID4gb2YgdGhlIGNh
Y2hlbGluZSBsb2NhbCB0byAuIEl0J3MgZ3VhcmFudGVlZCB0byBub3QgY2hhbmdlIGl0J3MgY29w
eSBvZiB0aGUNCj4gPiBjYWNoZWxpbmUgKGluIHRoaXMgY2FzZSBjb250YWluaW5nIHRoZSB3aG9s
ZSBvZiBib2IpLiAgIEhvd2V2ZXIsIGl0J3MgdmVyc2lvbg0KPiA+IG9mIG1hZ2ljX2ZsYWdzIGlz
IG91dCBvZiBkYXRlIHNvIHdoZW4gd2UgZmx1c2ggdGhlIGNhY2hlcyBhdCB0aGUgZW5kIG9mIHRo
ZQ0KPiA+IG5vbiBjb2hlcmVudCBETUEgdHJhbnNmZXIgKHRvIGZvcmNlIHRoZSBDUFUgdG8gcmVh
ZCBpdCBmcm9tIG1haW4gbWVtb3J5IGFuZA0KPiA+IGdldCB0aGUgbmV3IHZhbHVlcyBpbiBidWZm
ZXIpLCB0aGUgdmFsdWUgb2YgbWFnaWNfZmxhZ3MgY2FuIGJlIHJlc2V0IHRvIHRoZQ0KPiA+IHZl
cnNpb24gdGhlIERNQSBlbmdpbmUgaGFzLg0KPiA+IA0KPiA+IFNvLCB1cHNob3QgaXMgdG8gYXZv
aWQgYW55IHBvdGVudGlhbCBvZiBzdWNoIHByb2JsZW1zLCBETUEgYnVmZmVycyAnbXVzdCcNCj4g
PiBhbHdheXMgYmUgaW4gYSBjYWNoZWxpbmUgY29udGFpbmluZyBub3RoaW5nIHRoYXQgbWlnaHQg
YmUgY2hhbmdlZCBieQ0KPiA+IG90aGVyIGFjdGl2aXRpZXMuICBUaGlzIGNhbiBtZWFuIGl0IGlz
IHNhZmUgdG8gcHV0IGJvdGggVFggYW5kIFJYIGJ1ZmZlcnMNCj4gPiBpbiB0aGUgc2FtZSBjYWNo
ZWxpbmUgYXMgd2Ugd29uJ3QgdG91Y2ggZWl0aGVyIGR1cmluZyBhbiBTUEkgdHJhbnNmZXIuDQo+
ID4gDQo+ID4gPiA+IExvdHMgb2YgZXhhbXBsZXMgdG8gY29weSwgYnV0IGl0J3MgYWxzbyB3b3J0
aCBtYWtpbmcgc3VyZSB5b3UgdW5kZXJzdGFuZA0KPiA+ID4gPiB3aHkgdGhpcyBpcyBuZWNlc3Nh
cnkuDQo+ID4gPiANCj4gPiA+IEZvciB0aGUgZW5kaWFuZXNzIHRoaW5nLCBpdCBzaG91bGRuJ3Qg
YmUgcmVxdWlyZWQgdG8gbWFrZSBhbiBleHBsaWNpdA0KPiA+ID4gY29udmVyc2lvbiBpbnRvIHRo
ZSBkcml2ZXIuIEFjY29yZGluZyB0byB0aGUgc3BpLmggZG9jdW1lbnRhdGlvbjoNCj4gPiA+IA0K
PiA+ID4gPiAqIEluLW1lbW9yeSBkYXRhIHZhbHVlcyBhcmUgYWx3YXlzIGluIG5hdGl2ZSBDUFUg
Ynl0ZSBvcmRlciwgdHJhbnNsYXRlZA0KPiA+ID4gPiAqIGZyb20gdGhlIHdpcmUgYnl0ZSBvcmRl
ciAoYmlnLWVuZGlhbiBleGNlcHQgd2l0aCBTUElfTFNCX0ZJUlNUKS4gU28NCj4gPiA+ID4gKiBm
b3IgZXhhbXBsZSB3aGVuIGJpdHNfcGVyX3dvcmQgaXMgc2l4dGVlbiwgYnVmZmVycyBhcmUgMk4g
Ynl0ZXMgbG9uZw0KPiA+ID4gPiAqIChAbGVuID0gMk4pIGFuZCBob2xkIE4gc2l4dGVlbiBiaXQg
d29yZHMgaW4gQ1BVIGJ5dGUgb3JkZXIuDQo+ID4gPiBTbyBmcm9tIG15IHBvaW50IG9mIHZpZXcg
dGhlIFNQSSBzdWJzeXN0ZW0gYWx3YXlzIGNvbnZlcnRzIHRvIHRoZSByaWdodA0KPiA+ID4gZW5k
aWFuZXNzLiBXZSBkb24ndCBoYXZlIHRvIHRha2UgY2FyZSBhYm91dCBpdC4NCj4gPiANCj4gPiBD
b3JyZWN0LCB0aG91Z2ggYXMgSSBjb21tZW50ZWQgb24gdGhhdCBwYXRjaCwgdGhhdCdzIG5vdCBh
bHdheXMgJ3Bvc3NpYmxlJw0KPiA+IGFuZCBub3QgYWxsIGRyaXZlcnMgc2V0IHRoZSB3b3JkIGxl
bmd0aCAnY29ycmVjdGx5Jy4NCj4gDQo+IFRoYW5rIHlvdSBib3RoIGZvciB0aGUgZXhwbGFuYXRp
b25zIGFib3V0IERNQSBhbmQgU1BJIGVuZGlhbmVzcyA6KQ0KPiANCj4gU28gaW5kZWVkIDIvNCBz
ZWVtcyBPSyB0byBtZSwgYW5kIGl0IGRvZXNuJ3QgbmVlZCBhbnkgZnVydGhlcg0KPiBlbmRpYW5l
c3MtcmVsYXRlZCBmaXguDQoNClllcC4NCldpdGggdGhlc2UgZXhwbGFuYXRpb25zOg0KDQpSZXZp
ZXdlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNv
bT4NCg0KPiANCj4gDQo+ID4gV29sZnJhbSdzIHByZXNlbnRhdGlvbiBvbiB0cnlpbmcgdG8gaW1w
bGVtZW50IERNQSBzYWZldHkgaW4gSTJDIGF0IEVMQ0UyMDE4DQo+ID4gYWxzbyB0b3VjaGVzIG9u
IGEgbG90IG9mIHRoaXMuDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IA0KPiA+IEpvbmF0aGFuDQo+
ID4gDQo+ID4gPiANCj4gPiA+IEZvciBwYXRjaCAzLCBJIGRpZG4ndCB1c2UgZGVsYXlfdXNlY3Mg
ZmllbHMgZHVlIHRvIHRoZSB0aW1pbmdzDQo+ID4gPiBkZWZpbml0aW9uIGluIHRoZSBkYXRhc2hl
ZXQgaW4gIlJFQUQvV1JJVEUgU1BBTk5JTkcgQ09OVkVSU0lPTiBXSVRIT1VUIEENCj4gPiA+IEJV
U1kgSU5ESUNBVE9SIiBtb2RlLiBEdXJpbmcgdGhlIGRlbGF5LCB0aGUgY2hpcCBzZWxlY3QgbGlu
ZSBtdXN0IGJlDQo+ID4gPiByZWxlYXNlZCB3aGljaCBpcyBub3QgdGhlIGNhc2Ugd2hlbiB3ZSB1
c2UgZGVsYXlfdXNlY3MgZmllbGQuIFNvIEkgYWRkDQo+ID4gPiB0aGUgZGVsYXkgaW5zdHJ1Y3Rp
b24gYWZ0ZXIgdGhlIHdyaXRlIHN0ZXAgdG8gYmUgY29tcGxpYW50IHdpdGggdGhlc2UNCj4gPiA+
IHRpbWluZ3MuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gRm9yIHBhdGNoIDQsIEkgZXhwbGFpbmVk
IGEgYml0IGluIHRoZSBvdGhlciB0aHJlYWQuIE1heWJlIHdlIGhhdmUgYQ0KPiA+ID4gZGlmZmVy
ZW5jZSBvZiBiZWhhdmlvdXIgZHVlIHRvIHRoZSBjaG9pY2Ugb2YgdGhlIHRpbWluZ3MgIm1vZGVz
Ij8NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBCVFcsIGZyb20gbXkgcG9pbnQgb2YgdmlldyB0aGUg
ZGF0YXNoZWV0IGlzIG5vdCB0b3RhbGx5IGNsZWFyIGFib3V0IHRoZQ0KPiA+ID4gdGltaW5ncyBh
bmQgd2hhdCBpcyBtYW5kYXRvcnkgb3Igbm90IGluIHRoZSBleHBlY3RlZCBiZWhhdmlvdXIuDQo+
ID4gPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiANCj4gPiA+IENoYXJsZXMtQW50b2luZSBDb3Vy
ZXQNCj4gPiA+IA0K
