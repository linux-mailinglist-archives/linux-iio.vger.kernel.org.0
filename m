Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A2217734D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 10:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgCCJ7v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 04:59:51 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32258 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727587AbgCCJ7v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Mar 2020 04:59:51 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0239i6B3007628;
        Tue, 3 Mar 2020 04:59:26 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ygm526hdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Mar 2020 04:59:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeaBd9dgXzL3V+V/gSqfWbspnMgePwNiqE357OJpG9tdEqxP9dMVafJCsvgZYGBenPo6RNoM9Prn0hwS4aNp2R4HtTXBPHdnrcv4Ru5OEKdMGkJxcszsVDwGMqrZdAWC4elRYXBw1oDXmv85pixaYZuh7ytVsPbRX9SVAmixxJRgUD+hBBgj6/E4zhDl2mIocUhrUQP2GTmCIpTJisFLG2hS0hVm2iuJzlAxFBWp5k/J/4fCBg2nQFPM8bAnKWPNyMf1ZTj4KKoGpMdZyV+SAcLu7/m/+6nf7SWN+Al0bxRFsMPopTF8MA/oGweP/Eyj330Fqy8AQpomZYKbyyZqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGL7LWFZKhRQTCqaSxBZU4d1IxELZ62Lq1qj5yaViL0=;
 b=GN/CzlAM1XovAmLwOP8hCRuZDjCYqgdB6zjCMV2FGLzDaTZ1yL54Tw+HBPXYMJJSW/ht8WaAPpiCkSLZUB01778NjDe8GiSPpw8m1zHagWyBPEQa/RUpeEhmr1/OIkjkXlyDLUfoLIaNlmw1w+cKZhYS+tiDsbeA+1hlRNJVZDFCieSMG40XhNkuQrUIaHkSnNpdEz9MAkoQQzRA4dt7kPmVycggAtGPp6066C7pfGVWBUz1HGx7YJZZGLSY7aCZ5lsxd80sm2jpJ5GXv5CZ3rMSnrLeiyr8WhmOpZQPNFP82dvBko7IoIolA9R0YW8QaDj+0yH9qu4ZTrlSvMvDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGL7LWFZKhRQTCqaSxBZU4d1IxELZ62Lq1qj5yaViL0=;
 b=khfvpC8lrko4K/PV2t6NAKivsJ27STdqdVjQm26nGIFVFkL/kvAzc9EqHB5TbKE0jHkqiJXyEHbxTt6FOwx8RclyGth0Blg8xq/1lT5aA+g8sDcSsZX0gAJkLzsrwehn7HP2ZVuQEcuYupCoLCjEnCo4UF4fX5PYXO8tdy8ntbg=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2995.namprd03.prod.outlook.com (2603:10b6:404:111::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 09:59:24 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 09:59:24 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Thread-Topic: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Thread-Index: AQHV69jpKCRYfnfL+0eh49A+u9WwfKg16ooAgAC+fACAAARgAA==
Date:   Tue, 3 Mar 2020 09:59:24 +0000
Message-ID: <5661b3f80a7fd041989b30d2f9ca76bfa762499d.camel@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
         <20200225124152.270914-6-nuno.sa@analog.com> <20200302222254.GA27619@bogus>
         <1054e87af61518d73dfcb0995e7aab7484e81630.camel@analog.com>
In-Reply-To: <1054e87af61518d73dfcb0995e7aab7484e81630.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b519938b-0a85-469f-aab2-08d7bf598d82
x-ms-traffictypediagnostic: BN6PR03MB2995:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB299564439B5C9071D1CC81BD99E40@BN6PR03MB2995.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(66476007)(8676002)(316002)(66446008)(64756008)(81156014)(66556008)(6916009)(8936002)(54906003)(966005)(81166006)(6512007)(76116006)(66946007)(107886003)(26005)(186003)(478600001)(36756003)(71200400001)(6486002)(86362001)(4326008)(5660300002)(2616005)(6506007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2995;H:BN6PR03MB3347.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: idZVYwpy10x70WbJr2Pp8ifRooJZzORlE0XzGY0HvRdYvPwUMN59DbyAYKopIhF1KpPlFmWe96C6gF8HT8U9nvpCvxM0s1S5bffKnJPuH+3HIVjrLzutdacCp9RB5EgjrZ+D9WL+9AwXEew2Dkrsldc88XChPzvdw8xN/cJCfiNWyytEFVeN3mrejYUwS3/nZWmAOJmn6AtwPNKZauuKcaKNz+yglwFmjzB8Qk755+irIFtsbaE9hnSdCxoxi4RtFzmRT63FTIdAlzux9v1atAoR/+QN3QQnRWiQiAGBuzn4oZq6nDZeAfsVC2IDSOYdKF97Z72/iTaWx5HlUrzFqNC3cx+8q1lD9qdDvHIaRKmygWPB8bHjVasped8njkpRwnrKyEXamuOpYQ/Y748L32ybQHSOjTcpLGeCzTTOZzSVbt+9ObPfT9Hm6FLenvW4CZWG/tKm7mrr3l5Kjf5go01I8ObtjhG5QBoWEVgyZxDf7jFH7uv7bwOiqtLhPfPu
x-ms-exchange-antispam-messagedata: MADAmCBHKYOwX/0+l9lVgjNdz0BVs35ihUG3rBXEOaavC4qNfo0iq/PcNiE+3BRkjfwkmhw2FgReAlWX0T8f3qvHPf8xv/ksZN+mvRISNwzB+ICkm9n09rUNNQmvfhIjGhcacmzqofQsZn8DtTBdew==
Content-Type: text/plain; charset="utf-8"
Content-ID: <020A4BA193673440A4B29C0CF638D2AD@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b519938b-0a85-469f-aab2-08d7bf598d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 09:59:24.1710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SP/B81/InccvR260OQSI4xSxPdNfbQ/dgj3Od1ht5ksBg+2ox/QGzJCpGuAiAOKjIH9BGwE/BmLdho2PBuQXlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2995
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_02:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTAzIGF0IDA5OjQzICswMDAwLCBTYSwgTnVubyB3cm90ZToNCj4gW0V4
dGVybmFsXQ0KPiANCj4gT24gTW9uLCAyMDIwLTAzLTAyIGF0IDE2OjIyIC0wNjAwLCBSb2IgSGVy
cmluZyB3cm90ZToNCj4gPiBPbiBUdWUsIEZlYiAyNSwgMjAyMCBhdCAwMTo0MTo1MlBNICswMTAw
LCBOdW5vIFPDoSB3cm90ZToNCj4gPiA+IERvY3VtZW50IHRoZSBBRElTMTY0NzUgZGV2aWNlIGRl
dmljZXRyZWUgYmluZGluZ3MuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE51bm8gU8Oh
IDxudW5vLnNhQGFuYWxvZy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAuLi4vYmluZGluZ3MvaWlv
L2ltdS9hZGksYWRpczE2NDc1LnlhbWwgICAgICAgfCAxMzANCj4gPiA+ICsrKysrKysrKysrKysr
KysrKw0KPiA+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgMSArDQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMzEgaW5zZXJ0aW9ucygrKQ0KPiA+
ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lpby9pbXUvYWRpLGFkaXMxNjQ3NS55YW1sDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1n
aXQNCj4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9pbXUvYWRp
LGFkaXMxNjQ3NS55YW1sDQo+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9paW8vaW11L2FkaSxhZGlzMTY0NzUueWFtbA0KPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uYzBmMjE0NmUwMDBjDQo+ID4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gPiArKysNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lpby9pbXUvYWRpLGFkaXMxNjQ3NS55YW1sDQo+ID4gPiBAQCAtMCwwICsxLDEzMCBAQA0KPiA+
ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xh
dXNlKQ0KPiA+ID4gKyVZQU1MIDEuMg0KPiA+ID4gKy0tLQ0KPiA+ID4gKyRpZDogaHR0cDovL2Rl
dmljZXRyZWUub3JnL3NjaGVtYXMvaWlvL2ltdS9hZGksYWRpczE2NDc1LnlhbWwjDQo+ID4gPiAr
JHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+
ID4gPiArDQo+ID4gPiArdGl0bGU6IEFuYWxvZyBEZXZpY2VzIEFESVMxNjQ3NSBhbmQgc2ltaWxh
ciBJTVVzDQo+ID4gPiArDQo+ID4gPiArbWFpbnRhaW5lcnM6DQo+ID4gPiArICAtIE51bm8gU8Oh
IDxudW5vLnNhQGFuYWxvZy5jb20+DQo+ID4gPiArDQo+ID4gPiArZGVzY3JpcHRpb246IHwNCj4g
PiA+ICsgIEFuYWxvZyBEZXZpY2VzIEFESVMxNjQ3NSBhbmQgc2ltaWxhciBJTVVzDQo+ID4gPiAr
ICANCj4gPiA+IGh0dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2FsLWRvY3Vt
ZW50YXRpb24vZGF0YS1zaGVldHMvQURJUzE2NDc1LnBkZg0KPiA+ID4gKw0KPiA+ID4gK3Byb3Bl
cnRpZXM6DQo+ID4gPiArICBjb21wYXRpYmxlOg0KPiA+ID4gKyAgICBlbnVtOg0KPiA+ID4gKyAg
ICAgIC0gYWRpLGFkaXMxNjQ3NS0xDQo+ID4gPiArICAgICAgLSBhZGksYWRpczE2NDc1LTINCj4g
PiA+ICsgICAgICAtIGFkaSxhZGlzMTY0NzUtMw0KPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ3
Ny0xDQo+ID4gPiArICAgICAgLSBhZGksYWRpczE2NDc3LTINCj4gPiA+ICsgICAgICAtIGFkaSxh
ZGlzMTY0NzctMw0KPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ3MA0KPiA+ID4gKyAgICAgIC0g
YWRpLGFkaXMxNjQ2NS0xDQo+ID4gPiArICAgICAgLSBhZGksYWRpczE2NDY1LTINCj4gPiA+ICsg
ICAgICAtIGFkaSxhZGlzMTY0NjUtMw0KPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ2Ny0xDQo+
ID4gPiArICAgICAgLSBhZGksYWRpczE2NDY3LTINCj4gPiA+ICsgICAgICAtIGFkaSxhZGlzMTY0
NjctMw0KPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjUwMA0KPiA+ID4gKyAgICAgIC0gYWRpLGFk
aXMxNjUwNS0xDQo+ID4gPiArICAgICAgLSBhZGksYWRpczE2NTA1LTINCj4gPiA+ICsgICAgICAt
IGFkaSxhZGlzMTY1MDUtMw0KPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjUwNy0xDQo+ID4gPiAr
ICAgICAgLSBhZGksYWRpczE2NTA3LTINCj4gPiA+ICsgICAgICAtIGFkaSxhZGlzMTY1MDctMw0K
PiA+ID4gKw0KPiA+ID4gKyAgcmVnOg0KPiA+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4gKw0K
PiA+ID4gKyAgc3BpLWNwaGE6IHRydWUNCj4gPiA+ICsNCj4gPiA+ICsgIHNwaS1jcG9sOiB0cnVl
DQo+ID4gPiArDQo+ID4gPiArICBzcGktbWF4LWZyZXF1ZW5jeToNCj4gPiA+ICsgICAgbWF4aW11
bTogMjAwMDAwMA0KPiA+ID4gKw0KPiA+ID4gKyAgaW50ZXJydXB0czoNCj4gPiA+ICsgICAgbWF4
SXRlbXM6IDENCj4gPiA+ICsNCj4gPiA+ICsgIGNsb2NrczoNCj4gPiA+ICsgICAgbWF4SXRlbXM6
IDENCj4gPiA+ICsNCj4gPiA+ICsgIGNsb2NrLW5hbWVzOg0KPiA+ID4gKyAgICBvbmVPZjoNCj4g
PiA+ICsgICAgICAtIGNvbnN0OiBzeW5jDQo+ID4gPiArICAgICAgLSBjb25zdDogZGlyZWN0LXN5
bmMNCj4gPiA+ICsgICAgICAtIGNvbnN0OiBwdWxzZS1zeW5jDQo+ID4gPiArICAgICAgLSBjb25z
dDogc2NhbGVkLXN5bmMNCj4gPiANCj4gPiBBY2NvcmRpbmcgdG8gdGhlIGRhdGFzaGVldCBJIGxv
b2tlZCBhdCwgdGhlIGlucHV0IGlzIGNhbGxlZCAnc3luYycuDQo+ID4gSXQgDQo+ID4gbG9va3Mg
bGlrZSB5b3UgYXJlIG1peGluZyBvcGVyYXRpbmcgbW9kZSBhbmQgY2xvY2sgY29ubmVjdGlvbi4N
Cj4gDQo+IFRoZSBzeW5jIHBpbiBpcyB3aGVyZSB0aGUgZXh0ZXJuYWwgY2xvY2sgc2hvdWxkIGJl
IGNvbm5lY3RlZCAod2hlbg0KPiBhdmFpbGFibGUpLiBJJ20ga2luZGEgb2YgdXNpbmcgdGhlIGNs
b2NrLW5hbWUgcHJvcGVydHkgYXMgYSB3YXkgb2YNCj4gc2VsZWN0aW5nIHRoZSBtb2RlIHRoZSB1
c2VyIHdhbnRzIHRvIHVzZSBhcyBkb25lIGluIG90aGVyIGRldmljZXMgKA0KPiBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQv
dHJlZS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2ltdS9hZGksYWRpczE2
NDgwLnR4dA0KPiApLiBJbiB0aGUgZW5kLCB3aGF0IHdlIHNob3VsZCBoYXZlIGluIHRoZSBzeW5j
IHBpbiBpcyBhbiBleHRlcm5hbA0KPiBjbG9jaw0KPiB3aXRoIHRoZSBleGNlcHRpb24gb2YgdGhl
IGBzeW5jYCBtb2RlLiBJIGd1ZXNzIHRoaXMgb25lIGNvdWxkIGJlDQo+IGNhbGxlZA0KPiBvdXRw
dXQtc3luYyBhbmQsIGluIHRoaXMgY2FzZSwgdGhlIHN5bmMgcGluIGlzIGFjdHVhbGx5IGFuIG91
dHB1dCBwaW4NCj4gcHVsc2luZyB3aGVuIHRoZSBpbnRlcm5hbCBwcm9jZXNzb3IgY29sbGVjdHMg
ZGF0YS4NCj4gDQo+IEknbSBvayBpbiBjaGFuZ2luZyBpdCBpZiB0aGVyZSdzIGEgYmV0dGVyIHdh
eSBvZiBkb2luZyBpdC4uLiBEbyB5b3UNCj4gaGF2ZSBhbnkgc3VnZ2VzdGlvbj8NCj4gDQo+IC1O
dW5vIFPDoQ0KDQpTbywgeW91IG1lYW4gaGF2aW5nIHRoZSBjbG9jay1uYW1lIG9ubHkgYXMgInN5
bmMiIChvciBtYXliZSBldmVuDQpyZW1vdmluZyBpdD8pIGFuZCBoYXZpbmcgYSBkZWRpY2F0ZWQg
cHJvcGVydHkgbGlrZSBjbG9jay1tb2RlPw0KDQotTnVubyBTw6ENCj4gPiA+ICsNCj4gPiA+ICsg
IHJlc2V0LWdwaW9zOg0KPiA+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiA+ICsgICAgICBNdXN0
IGJlIHRoZSBkZXZpY2UgdHJlZSBpZGVudGlmaWVyIG9mIHRoZSBSRVNFVCBwaW4uIElmDQo+ID4g
PiBzcGVjaWZpZWQsDQo+ID4gPiArICAgICAgaXQgd2lsbCBiZSBhc3NlcnRlZCBkdXJpbmcgZHJp
dmVyIHByb2JlLiBBcyB0aGUgbGluZSBpcw0KPiA+ID4gYWN0aXZlIGxvdywNCj4gPiA+ICsgICAg
ICBpdCBzaG91bGQgYmUgbWFya2VkIEdQSU9fQUNUSVZFX0xPVy4NCj4gPiA+ICsgICAgbWF4SXRl
bXM6IDENCj4gPiA+ICsNCj4gPiA+ICsgIGFkaSxzY2FsZWQtb3V0cHV0LWh6Og0KPiA+ID4gKyAg
ICBkZXNjcmlwdGlvbjoNCj4gPiA+ICsgICAgICBUaGlzIHByb3BlcnR5IG11c3QgYmUgcHJlc2Vu
dCBpZiB0aGUgY2xvY2sgbW9kZSBpcyBzY2FsZWQtDQo+ID4gPiBzeW5jIHRocm91Z2gNCj4gPiA+
ICsgICAgICBjbG9jay1uYW1lcyBwcm9wZXJ0eS4gSW4gdGhpcyBtb2RlLCB0aGUgaW5wdXQgY2xv
Y2sgY2FuDQo+ID4gPiBoYXZlDQo+ID4gPiBhIHJhbmdlDQo+ID4gPiArICAgICAgb2YgMUh6IHRv
IDEyOEhaIHdoaWNoIG11c3QgYmUgc2NhbGVkIHRvIG9yaWdpbmF0ZSBhbg0KPiA+ID4gYWxsb3dh
YmxlIHNhbXBsZQ0KPiA+ID4gKyAgICAgIHJhdGUuIFRoaXMgcHJvcGVydHkgc3BlY2lmaWVzIHRo
YXQgcmF0ZS4NCj4gPiA+ICsgICAgbWluaW11bTogMTkwMA0KPiA+ID4gKyAgICBtYXhpbXVtOiAy
MTAwDQo+ID4gPiArDQo+ID4gPiArcmVxdWlyZWQ6DQo+ID4gPiArICAtIGNvbXBhdGlibGUNCj4g
PiA+ICsgIC0gcmVnDQo+ID4gPiArICAtIGludGVycnVwdHMNCj4gPiA+ICsgIC0gc3BpLWNwaGEN
Cj4gPiA+ICsgIC0gc3BpLWNwb2wNCj4gPiA+ICsNCj4gPiA+ICtpZjoNCj4gPiA+ICsgIHByb3Bl
cnRpZXM6DQo+ID4gPiArICAgIGNvbXBhdGlibGU6DQo+ID4gPiArICAgICAgY29udGFpbnM6DQo+
ID4gPiArICAgICAgICBlbnVtOg0KPiA+ID4gKyAgICAgICAgICAtIGFkaSxhZGlzMTY1MDANCj4g
PiA+ICsgICAgICAgICAgLSBhZGksYWRpczE2NTA1LTENCj4gPiA+ICsgICAgICAgICAgLSBhZGks
YWRpczE2NTA1LTINCj4gPiA+ICsgICAgICAgICAgLSBhZGksYWRpczE2NTA1LTMNCj4gPiA+ICsg
ICAgICAgICAgLSBhZGksYWRpczE2NTA3LTENCj4gPiA+ICsgICAgICAgICAgLSBhZGksYWRpczE2
NTA3LTINCj4gPiA+ICsgICAgICAgICAgLSBhZGksYWRpczE2NTA3LTMNCj4gPiA+ICsNCj4gPiA+
ICt0aGVuOg0KPiA+ID4gKyAgcHJvcGVydGllczoNCj4gPiA+ICsgICAgY2xvY2stbmFtZXM6DQo+
ID4gPiArICAgICAgb25lT2Y6DQo+ID4gPiArICAgICAgICAtIGNvbnN0OiBzeW5jDQo+ID4gPiAr
ICAgICAgICAtIGNvbnN0OiBkaXJlY3Qtc3luYw0KPiA+ID4gKyAgICAgICAgLSBjb25zdDogc2Nh
bGVkLXN5bmMNCj4gPiA+ICsNCj4gPiA+ICsgICAgYWRpLGJ1cnN0MzItZW5hYmxlOg0KPiA+ID4g
KyAgICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gKyAgICAgICAgRW5hYmxlIGJ1cnN0MzIgbW9kZS4g
SW4gdGhpcyBtb2RlLCBhIGJ1cnN0IHJlYWRpbmcNCj4gPiA+IGNvbnRhaW5zIGNhbGlicmF0ZWQN
Cj4gPiA+ICsgICAgICAgIGd5cm9zY29wZSBhbmQgYWNjZWxlcm9tZXRlciBkYXRhIGluIDMyLWJp
dCBmb3JtYXQuDQo+ID4gPiArICAgICAgdHlwZTogYm9vbGVhbg0KPiA+ID4gKw0KPiA+ID4gK2V4
YW1wbGVzOg0KPiA+ID4gKyAgLSB8DQo+ID4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gPiA+ICsgICAgc3BpIHsNCj4gPiA+ICsgICAg
ICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiA+ICsgICAgICAgICAgICAjc2l6ZS1j
ZWxscyA9IDwwPjsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgICAgICBhZGlzMTY0NzU6IGFkaXMx
NjQ3NS0zQDAgew0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhZGks
YWRpczE2NDc1LTMiOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgc3BpLWNwaGE7DQo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICBzcGktY3BvbDsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVl
bmN5ID0gPDIwMDAwMDA+Ow0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9
IDw0IElSUV9UWVBFX0VER0VfUklTSU5HPjsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgIGlu
dGVycnVwdC1wYXJlbnQgPSA8JmdwaW8+Ow0KPiA+ID4gKyAgICAgICAgICAgIH07DQo+ID4gPiAr
ICAgIH07DQo+ID4gPiArLi4uDQo+ID4gPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlO
VEFJTkVSUw0KPiA+ID4gaW5kZXggZjExMjYyZjFmM2JiLi5mOGNjYzkyYWIzNzggMTAwNjQ0DQo+
ID4gPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiA+ID4gKysrIGIvTUFJTlRBSU5FUlMNCj4gPiA+IEBA
IC0xMDE1LDYgKzEwMTUsNyBAQCBXOgkNCj4gPiA+IGh0dHA6Ly9lei5hbmFsb2cuY29tL2NvbW11
bml0eS9saW51eC1kZXZpY2UtZHJpdmVycw0KPiA+ID4gIFM6CVN1cHBvcnRlZA0KPiA+ID4gIEY6
CWRyaXZlcnMvaWlvL2ltdS9hZGlzMTY0NzUuYw0KPiA+ID4gIEY6CURvY3VtZW50YXRpb24vQUJJ
L3Rlc3Rpbmcvc3lzZnMtYnVzLWlpby1pbXUtYWRpczE2NDc1DQo+ID4gPiArRjoJRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9pbXUvYWRpLGFkaXMxNjQ3NQ0KPiA+ID4gLnlh
bWwNCj4gPiA+ICANCj4gPiA+ICBBTkFMT0cgREVWSUNFUyBJTkMgQURNMTE3NyBEUklWRVINCj4g
PiA+ICBNOglCZW5pYW1pbiBCaWEgPGJlbmlhbWluLmJpYUBhbmFsb2cuY29tPg0KPiA+ID4gLS0g
DQo+ID4gPiAyLjI1LjENCg0K
