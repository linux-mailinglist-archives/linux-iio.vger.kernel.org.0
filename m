Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 718C51A097A
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 10:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgDGIqF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 04:46:05 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:55166 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbgDGIqF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 04:46:05 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0378js1K009171;
        Tue, 7 Apr 2020 04:46:00 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-00128a01.pphosted.com with ESMTP id 306pv6r53s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 04:46:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MakoirwgAOguBaM5NKhUhdnOVcNbCNHnF9iXRtLDm9QDaL+H6DmCNAFY/PgXbIOys5sutqVqZVSSqjPK5mzcAmdyp07sbYZUNXW3jHPNwVGT3JLHOeAHQ14ObCHvF2hRgGYeH5cnbk9EE++G0C1xZ8tleKt+FNnTX/+nOyxi4APfaaNK0xS9et6WhkrEpH785tULg/0GvsNO0vvGDZ6thNjNLLA32w0d06YmXYEbuZAyw3n8mWBjeNRHl6xZ+vnNTrBaVFyLRetrIbY7OFy3TH5knARsl5iGjC76JrODoO0V1CVx9ExOfgZ3+NOdmtJM/ZkDMnXBONsZ8xQuoPlXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFgeVmW1jM3YS+wZAgpBBMv2ijocbMWU3eVjwmCzqxI=;
 b=WBB5jLVCXDXxa+yG0oRB1I/pRn7eKkpIH4spvKeYlGtsAKTNcIhV9OFAMb1B4dFfZdpgFv2YogIFAZLlG74h1luOsCcpLtTuXO2Be8L7dTjwuon7H+YQAZyNbKBgGVyhk+riLdpaacGf+jk1rmSX8akWsc0/MA5SB/5jK/Uxiwv7YuTT9ZKbJwdQTU+8Qk31fu8CTuJRLst5NJbZ3QrDCxy/4iqa3b6OsVLPmch2G+ynwA+Qvqem8nbfQZa1tGvD+o7dJDKgHFlpQ9m581blezjykmipoVTvEHPmEGGD+WeeARMrmBwY6ryM4Ys1L4HTZgquhrEvFljkM779pX6UAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFgeVmW1jM3YS+wZAgpBBMv2ijocbMWU3eVjwmCzqxI=;
 b=qHp4uQYUa5JukIAa0BEb0NSubrSkAPaFGr9DF0WLiCvmzIK3ft01cJ4yOELiNxVcKZUEsG7XRVRCQLigOcAVGx4CyAY9ZDcOpq55bfWNLCZYOxUfTSQeONiDtbG++YaYfXB3NyaV1hiYccMRSz4LDT1tLsby32/f3qWJ6Zgy3GY=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4171.namprd03.prod.outlook.com (2603:10b6:5:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Tue, 7 Apr
 2020 08:45:59 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 08:45:59 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: core: move 'indio_dev->info' null check first
Thread-Topic: [PATCH v2] iio: core: move 'indio_dev->info' null check first
Thread-Index: AQHWDLV1YdKNMBIVQUCS1yPFAE4JMKhtWH8A
Date:   Tue, 7 Apr 2020 08:45:58 +0000
Message-ID: <3725f882accda683815f04c0eff0bb36c285fe62.camel@analog.com>
References: <cb300eeb-6045-bd91-3e0e-902dd3b5d5d8@web.de>
In-Reply-To: <cb300eeb-6045-bd91-3e0e-902dd3b5d5d8@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01793f74-d793-4fa8-a0e0-08d7dad01843
x-ms-traffictypediagnostic: DM6PR03MB4171:
x-microsoft-antispam-prvs: <DM6PR03MB41717FE4370B7F4B3F578393F9C30@DM6PR03MB4171.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(39850400004)(136003)(376002)(346002)(366004)(316002)(110136005)(81166006)(81156014)(8936002)(8676002)(6506007)(478600001)(966005)(36756003)(4326008)(86362001)(6486002)(6512007)(2906002)(71200400001)(186003)(26005)(2616005)(54906003)(5660300002)(91956017)(76116006)(66446008)(64756008)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: po59OsE3VMVxeJkiVxRa6E9zevEwg3bi5euSrrp0N216P4oS6lDbGX5HoVk5eJ+KC0391t8ggOPrIhkX1E/EyOXfFvFiTpiNI6Z2apdBQirs+LUoZol1Wd5z/px0jpHNJBqPEbQlLXwzu+UrVmE42gRlOOj+ucIidUOtiJkgduiGDPV3o+yQOTwfHnD9NSG4mfbR4te3vWiIySw0M6gVLFYArNl50Q1/Qu0fx/pfGxKjT5+9ze0DCoCUZDk2J6YF0Q9FuMC6kD1j5oszL6vh7FrCOahQBF3fjyBINKWp2BpgV3bKC+uk84Uo6eSsaOq0FbpaRlDpxeR6kpZbJKVfm8ugPxNhztw6asfa2O4oKoPceol3mHcYPgq9qL70otFcgq6kiwdK09i33wA17qQp2vV+Cz2J2wXRwJXJiny/+svdPtETpvdcl8TZp4/ZkPBJCYqh9/pAUyESkAan4K9RicVMGrwD8lD4ZDdfDZKDb5KPR4SQUczf8C1exWUFyBtC0IGKgCwAGVBavIAnXm1iHw==
x-ms-exchange-antispam-messagedata: anTS/xudLl6cMUVIuI6EWsqXQDNnRgCFQkxSzLN/vO+CnqUYM6RVEdb4SU8nbRd9f/jYncRzUB8XZFjjEM6C6cGg88NeiiOb3M7FwyfnJ1TQmRH83kldrFViALzrcelvYYI749DO+4lBG6F7EhunrA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <64BF73E56D979949AAA7FF455112130D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01793f74-d793-4fa8-a0e0-08d7dad01843
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 08:45:58.9763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZsFwqsEyAbtePcWY3dFInPKdQRQaqxgXRLxQgfZAYmo8z4F0d4hFQvplOTwSJDlVj61pwidBQWSq+cXtNXiNEBJV1giRsNprplGEy9Nt1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4171
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_01:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004070074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTA3IGF0IDEwOjIwICswMjAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gPiBEb2Vzbid0IGZpeCBhbnl0aGluZy4NCj4gDQo+IFdvdWxk
IHRoZSBjaGFuZ2UgZGVzY3JpcHRpb24gYmUgbmljZXIgd2l0aG91dCB0aGlzIHNlbnRlbmNlPw0K
PiANCg0KVGhhdCBwYXJ0IGlzIHNsaWdodGx5IGRlYmF0ZS1hYmxlLg0KSSd2ZSBoYWQgbXkgZmFp
ci1zaGFyZSBvZiBjb21tZW50cyBbZHVyaW5nIHJldmlld3NdLCB3aGVyZSBvdGhlcnMgd2VyZQ0K
YXNraW5nL3NheWluZyAiaXMgdGhpcyBmaXhpbmcgYW55dGhpbmc/IHBsZWFzZSBzdGF0ZSBpZiB0
aGlzIGlzIGZpeGluZw0KYW55dGhpbmciLg0KDQpTbywgb3ZlciB0aW1lIEkgZ290IHRoZSBoYWJp
dCBvZiBtZW50aW9uaW5nICdEb2Vzbid0IGZpeCBhbnl0aGluZy4nIGlmIHRoZSBwYXRjaA0KZG9l
c24ndCBmaXggYW55dGhpbmcuIA0KDQpTbywgSSdkIGxlYXZlIGl0IGFzLWlzIFtpZiB0aGF0J3Mg
cG9zc2libGVdLg0KDQo+IA0KPiA+IEp1c3QgbW92ZXMgdGhpcyDigKYNCj4gDQo+IEkgc3VnZ2Vz
dCB0byBjaG9vc2UgYW4gaW1wZXJhdGl2ZSB3b3JkaW5nLg0KPiBodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmct
cGF0Y2hlcy5yc3Q/aWQ9N2U2MzQyMDg0N2FlNWYxMDM2ZTRmN2M0MmYwYjMyODJlNzNlZmJjMipu
MTUxX187SXchIUEzTmk4Q1MweTJZIXBNb3FaSUx2V3l1ODdma05lMTZTdWEwak1yWlpLODFvUU9I
RU5VaHlUV1p6OVVyWTRDaXN5S1dTUkNQRndzMFdUbTUwaVEkIA0KPiANCg0KSSBhZG1pdCwgSSBk
aWRuJ3QgcmVhZCB0aGF0IGRvY3VtZW50IHRvbyBtdWNoIGluLWRlcHRoLg0KQW5kIEkgcHJvYmFi
bHkgd29uJ3QsIGJlY2F1c2UgSSBhbSBsYXp5Lg0KDQpQZXJzb25hbGx5LCB3aGF0IEkgdHJ5IHRv
IGRvLCBpcyBndWVzcyB0aGUgbWFpbnRhaW5lcidzL2NvbW11bml0eSdzIHByZWZlcmVuY2VzDQpv
dmVyIHRpbWUgdmlhIGludGVyYWN0aW9ucy4NClRoaW5ncyBkaWZmZXIgc2xpZ2h0bHkgZnJvbSBj
b21tdW5pdHkgdG8gY29tbXVuaXR5Lg0KT2YgY291cnNlLCB0aGVyZSBpcyBzb21lIGNvbW1vbiBn
cm91bmQgYWNyb3NzIGFsbCBjb21tdW5pdGllcywgYW5kIEkgdHJ5IHRvDQphcHBseSB0aGF0IGZp
cnN0Lg0KVGhlbiwgZGVwZW5kaW5nIG9uIHRoZSBmbGV4aWJpbGl0eS9wYXN0LWNvbW1lbnRzIGZy
b20gb3RoZXIgc2VudC1wYXRjaGVzIEkgdHJ5DQp0byBhcHBseSB0aG9zZSBvbiB0b3AgW3VubGVz
cyBJIGZvcmdldDsgd2hpY2ggSSBraW5kYSBkb10uDQoNCj4gUmVnYXJkcywNCj4gTWFya3VzDQo=
