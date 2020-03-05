Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA7F17A53B
	for <lists+linux-iio@lfdr.de>; Thu,  5 Mar 2020 13:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgCEM2W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Mar 2020 07:28:22 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:33680 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbgCEM2W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Mar 2020 07:28:22 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 025CF0Bc005066;
        Thu, 5 Mar 2020 07:27:58 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0b-00128a01.pphosted.com with ESMTP id 2yfnfcg6sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Mar 2020 07:27:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8Uk9trBhIucix71r8zXMgEKDL1bCE1yj+D5fYf3aIeI/J7tzPibOorObFbMiim0Q5m4PjskDUnrguNOIMqzeI7CAHAngo13TAppeULVo46xuESMMBcK+sHgCGwJy+su4OaAIlP1Ok5BjXsPa8Bc+iFu7+94uDzipTtERCc4Y1lrZ7f5hYJHZaFLHwUOmx80lWzKnziyruRGsb5Z9QPjJIWlbWaBRdERxpOrPZZOzKSY9J34751wywcUBhg5o7Ic9gWFeh0JZaJWR4WXSE/gXrTRNUW8Gn4uYc6R7VcwSoFm9BJcY9QJ/jbSwyA5BSlM9pt/c4bBkU6y98UZHSN8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MJT6E7wl4mncA/8B7AKRF9lesARkhHowamhr8jOA1U=;
 b=F1GWezYXo1dnNYgjIvPotQLzevSjQpljzUp8CqyJyyTKGWNPtz1mmJysBpJTkUdt+MmpDkgxiMITkPHxmtx+lPV5VD3VH6GR+YXiWhpGguhMRFR0X4bfxW7adhXWYNZcS0zI+16Qef+fR2Xw1o7BNcTCgNpe7eMWg/9MfW9U1MTx7se0nG5nxV9oWESPknWIRQ9CIzgLSAsGPDB0QKeGRcqXfXhKDJm69tIMsp6Dok3SLPTNCAjReaTrTEzazExzFiJxJJ+fBB5nDdkjZF8U/8EPc0n37tZOaHJfiz0NY3/v27pgl6F9VtOeay08+FXgLazC5cbLr+Ruw61GfbQhzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MJT6E7wl4mncA/8B7AKRF9lesARkhHowamhr8jOA1U=;
 b=K5u1od0Hp74JeCt99MZu0Qff3vZGw2LSvbv83uzJIn6NyUoi3gGOMbAHF2Qtd3Up7SxDlm/dN02OKhu5U2VqxBjh3QE8+Iel5ICszQdhoHTvye1Xb995xZN4FRgjS+gVm1IpvyHRjh8X45t7HjB3Ah1LblwNiverDbEB1wJRjGI=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2609.namprd03.prod.outlook.com (2603:10b6:404:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 12:27:55 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a%4]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 12:27:55 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Thread-Topic: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Thread-Index: AQHV69jpKCRYfnfL+0eh49A+u9WwfKg3aLaAgAFdfACAARVLAIAAIBKA
Date:   Thu, 5 Mar 2020 12:27:54 +0000
Message-ID: <3bdae6c113381c7dd0645b7b98c67fac734b92ab.camel@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
         <20200225124152.270914-6-nuno.sa@analog.com>
         <20200303211045.31f977bb@archlinux>
         <9b9e18f279edbcb60122a0b0d4c067975868194a.camel@analog.com>
         <63b5c766-78a2-59c4-6efb-3eb35031a351@metafoo.de>
In-Reply-To: <63b5c766-78a2-59c4-6efb-3eb35031a351@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1088ad91-dd0e-4b38-7fc4-08d7c100a1b6
x-ms-traffictypediagnostic: BN6PR03MB2609:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB2609CF07777EE8AF60EFA83199E20@BN6PR03MB2609.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(81166006)(76116006)(4326008)(8676002)(81156014)(6486002)(36756003)(86362001)(26005)(316002)(5660300002)(186003)(966005)(54906003)(478600001)(64756008)(71200400001)(66556008)(66476007)(53546011)(66446008)(6506007)(6512007)(66946007)(2616005)(110136005)(8936002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2609;H:BN6PR03MB3347.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: phiLGq1950k5bXEeyXAOwqh8yUqPHClCmHs8h87IFyRMqjG7pQyAxLWyjlJq7Uf34Dgth84mN+LTMuLJpTD5wPWhul0pxVluvamc9AaI0q5QFDCgdkaqQIZZsWX0Ki+rCcWA6cMkfH8hn3xPyfPYXYRQG3fSVGwyVAippLA51U6mFYLAs0r7kbTyLunSewqvgyU3wLpcaxJjS6u9oK3TPHl1uv5Gg6STN0urPWa7ZHA9gu/hsti6xEjozXgYO5oVxru7dHCTZ7F7D7hxpHz8UG8x8QPm25itkjQIpjkUvd7RsoqjqbRPoAx1MmNd9v0IGmRhjOf5KPGz8Nnmd5OA0WLWDE77sSa4wvcGzTqz1sI+IuNAp4jmOvwPFV3u3jt/Nfp+iQ0RE81TBVPq2EAMi1Yg1hslKRGmvHkwaXudJ09BwiINTJsPPlpALk0DnMIO0ssMHql7qkj2ldGJvFVbiHHEEANg1PuGVZ8CIRi7sytzCySqo4g4llj+B4CXtrMvedvAq/uz4k4yxh8yQQkQwA==
x-ms-exchange-antispam-messagedata: XtfIy/lgAClkHkZanCsReakhPtvZh06Sq5yKxLMpzoNoxlJOENAWzuRcsNwbHap51KDNV6tSac+cr/Su7440/m7M+H009SbXVT0b/00+SyZqGwuakP8hwNJkip9MMzHUXIdL/gfVh5sozhjROCg1bA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C014D53D2BF04408EA1CAACC7BB989B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1088ad91-dd0e-4b38-7fc4-08d7c100a1b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 12:27:54.2253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95voJEc/9w8WV6Zv4VRniqUkrGjfbAONnZPKmZqsf0bGumAiTZxyJcebPYXMJzk8zb+H29mt1TAFbEQrb5u62Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2609
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-05_03:2020-03-05,2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003050080
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTA1IGF0IDExOjM0ICswMTAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IE9uIDMvNC8yMCA3OjAwIFBNLCBTYSwgTnVubyB3cm90ZToNCj4gPiBPbiBUdWUsIDIw
MjAtMDMtMDMgYXQgMjE6MTAgKzAwMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4gPiAN
Cj4gPiA+IE9uIFR1ZSwgMjUgRmViIDIwMjAgMTM6NDE6NTIgKzAxMDANCj4gPiA+IE51bm8gU8Oh
IDxudW5vLnNhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IERvY3VtZW50IHRo
ZSBBRElTMTY0NzUgZGV2aWNlIGRldmljZXRyZWUgYmluZGluZ3MuDQo+ID4gPiA+IA0KPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiA+ID4gT25l
IHRoaW5nIGlubGluZSBvbiB0aGUgYnVyc3QgbW9kZSBzdHVmZi4NCj4gPiA+IA0KPiA+ID4gVGhh
bmtzLA0KPiA+ID4gDQo+ID4gPiBKb25hdGhhbg0KPiA+ID4gDQo+ID4gPiA+IC0tLQ0KPiA+ID4g
PiAgIC4uLi9iaW5kaW5ncy9paW8vaW11L2FkaSxhZGlzMTY0NzUueWFtbCAgICAgICB8IDEzMA0K
PiA+ID4gPiArKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gICBNQUlOVEFJTkVSUyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ID4gPiAgIDIgZmlsZXMgY2hh
bmdlZCwgMTMxIGluc2VydGlvbnMoKykNCj4gPiA+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4g
PiA+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9pbXUvYWRpLGFkaXMx
NjQ3NS55YW1sDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiA+IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9pbXUvYWRpLGFkaXMxNjQ3NS55YW1sDQo+
ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9pbXUvYWRpLGFk
aXMxNjQ3NS55YW1sDQo+ID4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+IGluZGV4
IDAwMDAwMDAwMDAwMC4uYzBmMjE0NmUwMDBjDQo+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+
ID4gKysrDQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9p
bXUvYWRpLGFkaXMxNjQ3NS55YW1sDQo+ID4gPiA+IEBAIC0wLDAgKzEsMTMwIEBADQo+ID4gPiA+
ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVz
ZSkNCj4gPiA+ID4gKyVZQU1MIDEuMg0KPiA+ID4gPiArLS0tDQo+ID4gPiA+ICskaWQ6IGh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2lpby9pbXUvYWRpLGFkaXMxNjQ3NS55YW1sIw0KPiA+
ID4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlh
bWwjDQo+ID4gPiA+ICsNCj4gPiA+ID4gK3RpdGxlOiBBbmFsb2cgRGV2aWNlcyBBRElTMTY0NzUg
YW5kIHNpbWlsYXIgSU1Vcw0KPiA+ID4gPiArDQo+ID4gPiA+ICttYWludGFpbmVyczoNCj4gPiA+
ID4gKyAgLSBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiA+ID4gPiArDQo+ID4gPiA+
ICtkZXNjcmlwdGlvbjogfA0KPiA+ID4gPiArICBBbmFsb2cgRGV2aWNlcyBBRElTMTY0NzUgYW5k
IHNpbWlsYXIgSU1Vcw0KPiA+ID4gPiArDQo+ID4gPiA+IGh0dHBzOi8vd3d3LmFuYWxvZy5jb20v
bWVkaWEvZW4vdGVjaG5pY2FsLWRvY3VtZW50YXRpb24vZGF0YS1zaGVldHMvQURJUzE2NDc1LnBk
Zg0KPiA+ID4gPiArDQo+ID4gPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ID4gPiArICBjb21wYXRpYmxl
Og0KPiA+ID4gPiArICAgIGVudW06DQo+ID4gPiA+ICsgICAgICAtIGFkaSxhZGlzMTY0NzUtMQ0K
PiA+ID4gPiArICAgICAgLSBhZGksYWRpczE2NDc1LTINCj4gPiA+ID4gKyAgICAgIC0gYWRpLGFk
aXMxNjQ3NS0zDQo+ID4gPiA+ICsgICAgICAtIGFkaSxhZGlzMTY0NzctMQ0KPiA+ID4gPiArICAg
ICAgLSBhZGksYWRpczE2NDc3LTINCj4gPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ3Ny0zDQo+
ID4gPiA+ICsgICAgICAtIGFkaSxhZGlzMTY0NzANCj4gPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMx
NjQ2NS0xDQo+ID4gPiA+ICsgICAgICAtIGFkaSxhZGlzMTY0NjUtMg0KPiA+ID4gPiArICAgICAg
LSBhZGksYWRpczE2NDY1LTMNCj4gPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ2Ny0xDQo+ID4g
PiA+ICsgICAgICAtIGFkaSxhZGlzMTY0NjctMg0KPiA+ID4gPiArICAgICAgLSBhZGksYWRpczE2
NDY3LTMNCj4gPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjUwMA0KPiA+ID4gPiArICAgICAgLSBh
ZGksYWRpczE2NTA1LTENCj4gPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjUwNS0yDQo+ID4gPiA+
ICsgICAgICAtIGFkaSxhZGlzMTY1MDUtMw0KPiA+ID4gPiArICAgICAgLSBhZGksYWRpczE2NTA3
LTENCj4gPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjUwNy0yDQo+ID4gPiA+ICsgICAgICAtIGFk
aSxhZGlzMTY1MDctMw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgIHJlZzoNCj4gPiA+ID4gKyAgICBt
YXhJdGVtczogMQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsgIHNwaS1jcGhhOiB0cnVlDQo+ID4gPiA+
ICsNCj4gPiA+ID4gKyAgc3BpLWNwb2w6IHRydWUNCj4gPiA+ID4gKw0KPiA+ID4gPiArICBzcGkt
bWF4LWZyZXF1ZW5jeToNCj4gPiA+ID4gKyAgICBtYXhpbXVtOiAyMDAwMDAwDQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyAgaW50ZXJydXB0czoNCj4gPiA+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4g
PiArDQo+ID4gPiA+ICsgIGNsb2NrczoNCj4gPiA+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4g
PiArDQo+ID4gPiA+ICsgIGNsb2NrLW5hbWVzOg0KPiA+ID4gPiArICAgIG9uZU9mOg0KPiA+ID4g
PiArICAgICAgLSBjb25zdDogc3luYw0KPiA+ID4gPiArICAgICAgLSBjb25zdDogZGlyZWN0LXN5
bmMNCj4gPiA+ID4gKyAgICAgIC0gY29uc3Q6IHB1bHNlLXN5bmMNCj4gPiA+ID4gKyAgICAgIC0g
Y29uc3Q6IHNjYWxlZC1zeW5jDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgcmVzZXQtZ3Bpb3M6DQo+
ID4gPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gPiA+ICsgICAgICBNdXN0IGJlIHRoZSBkZXZp
Y2UgdHJlZSBpZGVudGlmaWVyIG9mIHRoZSBSRVNFVCBwaW4uIElmDQo+ID4gPiA+IHNwZWNpZmll
ZCwNCj4gPiA+ID4gKyAgICAgIGl0IHdpbGwgYmUgYXNzZXJ0ZWQgZHVyaW5nIGRyaXZlciBwcm9i
ZS4gQXMgdGhlIGxpbmUgaXMNCj4gPiA+ID4gYWN0aXZlIGxvdywNCj4gPiA+ID4gKyAgICAgIGl0
IHNob3VsZCBiZSBtYXJrZWQgR1BJT19BQ1RJVkVfTE9XLg0KPiA+ID4gPiArICAgIG1heEl0ZW1z
OiAxDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgYWRpLHNjYWxlZC1vdXRwdXQtaHo6DQo+ID4gPiA+
ICsgICAgZGVzY3JpcHRpb246DQo+ID4gPiA+ICsgICAgICBUaGlzIHByb3BlcnR5IG11c3QgYmUg
cHJlc2VudCBpZiB0aGUgY2xvY2sgbW9kZSBpcw0KPiA+ID4gPiBzY2FsZWQtDQo+ID4gPiA+IHN5
bmMgdGhyb3VnaA0KPiA+ID4gPiArICAgICAgY2xvY2stbmFtZXMgcHJvcGVydHkuIEluIHRoaXMg
bW9kZSwgdGhlIGlucHV0IGNsb2NrIGNhbg0KPiA+ID4gPiBoYXZlDQo+ID4gPiA+IGEgcmFuZ2UN
Cj4gPiA+ID4gKyAgICAgIG9mIDFIeiB0byAxMjhIWiB3aGljaCBtdXN0IGJlIHNjYWxlZCB0byBv
cmlnaW5hdGUgYW4NCj4gPiA+ID4gYWxsb3dhYmxlIHNhbXBsZQ0KPiA+ID4gPiArICAgICAgcmF0
ZS4gVGhpcyBwcm9wZXJ0eSBzcGVjaWZpZXMgdGhhdCByYXRlLg0KPiA+ID4gPiArICAgIG1pbmlt
dW06IDE5MDANCj4gPiA+ID4gKyAgICBtYXhpbXVtOiAyMTAwDQo+ID4gPiA+ICsNCj4gPiA+ID4g
K3JlcXVpcmVkOg0KPiA+ID4gPiArICAtIGNvbXBhdGlibGUNCj4gPiA+ID4gKyAgLSByZWcNCj4g
PiA+ID4gKyAgLSBpbnRlcnJ1cHRzDQo+ID4gPiA+ICsgIC0gc3BpLWNwaGENCj4gPiA+ID4gKyAg
LSBzcGktY3BvbA0KPiA+ID4gPiArDQo+ID4gPiA+ICtpZjoNCj4gPiA+ID4gKyAgcHJvcGVydGll
czoNCj4gPiA+ID4gKyAgICBjb21wYXRpYmxlOg0KPiA+ID4gPiArICAgICAgY29udGFpbnM6DQo+
ID4gPiA+ICsgICAgICAgIGVudW06DQo+ID4gPiA+ICsgICAgICAgICAgLSBhZGksYWRpczE2NTAw
DQo+ID4gPiA+ICsgICAgICAgICAgLSBhZGksYWRpczE2NTA1LTENCj4gPiA+ID4gKyAgICAgICAg
ICAtIGFkaSxhZGlzMTY1MDUtMg0KPiA+ID4gPiArICAgICAgICAgIC0gYWRpLGFkaXMxNjUwNS0z
DQo+ID4gPiA+ICsgICAgICAgICAgLSBhZGksYWRpczE2NTA3LTENCj4gPiA+ID4gKyAgICAgICAg
ICAtIGFkaSxhZGlzMTY1MDctMg0KPiA+ID4gPiArICAgICAgICAgIC0gYWRpLGFkaXMxNjUwNy0z
DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3RoZW46DQo+ID4gPiA+ICsgIHByb3BlcnRpZXM6DQo+ID4g
PiA+ICsgICAgY2xvY2stbmFtZXM6DQo+ID4gPiA+ICsgICAgICBvbmVPZjoNCj4gPiA+ID4gKyAg
ICAgICAgLSBjb25zdDogc3luYw0KPiA+ID4gPiArICAgICAgICAtIGNvbnN0OiBkaXJlY3Qtc3lu
Yw0KPiA+ID4gPiArICAgICAgICAtIGNvbnN0OiBzY2FsZWQtc3luYw0KPiA+ID4gPiArDQo+ID4g
PiA+ICsgICAgYWRpLGJ1cnN0MzItZW5hYmxlOg0KPiA+ID4gPiArICAgICAgZGVzY3JpcHRpb246
DQo+ID4gPiA+ICsgICAgICAgIEVuYWJsZSBidXJzdDMyIG1vZGUuIEluIHRoaXMgbW9kZSwgYSBi
dXJzdCByZWFkaW5nDQo+ID4gPiA+IGNvbnRhaW5zIGNhbGlicmF0ZWQNCj4gPiA+ID4gKyAgICAg
ICAgZ3lyb3Njb3BlIGFuZCBhY2NlbGVyb21ldGVyIGRhdGEgaW4gMzItYml0IGZvcm1hdC4NCj4g
PiA+IFdoeSBpcyB0aGlzIGluIERUPyAgSXMgaXQgbm90IGEgcnVudGltZSBkZWNpc2lvbg0KPiA+
ID4gKGlkZWFsbHkgYXV0b21hdGljYWxseSBzZWxlY3RlZCkNCj4gPiBTbywgeW91IG1lYW4ganVz
dCBoYXZlIHRoaXMgbW9kZSBieSBkZWZhdWx0IG9uIHBhcnRzIHRoYXQgc3VwcG9ydA0KPiA+IGl0
Pw0KPiANCj4gTWF5YmUgbGV0cyBzdGFydCB3aXRoIGV4cGxhaW5pbmcgd2hhdCBidXJzdDMyIG1v
ZGUgaXMsIHNvIGV2ZXJ5Ym9keQ0KPiBpcyANCj4gb24gdGhlIHNhbWUgcGFnZS4NCj4gDQo+IFRo
ZSB3YXkgcmVnaXN0ZXJzIGFyZSB1c3VhbGx5IGFjY2Vzc2VkIGZvciB0aGlzIGNoaXAgaXMgdGhh
dCB5b3UNCj4gZmlyc3QgDQo+IHdyaXRlIHRoZSBhZGRyZXNzIHlvdSB3YW50IHRvIHJlYWQgb24g
dGhlIFNQSSBidXMgYW5kIHRoZW4gcmVhZCB0aGUgDQo+IHNlbGVjdGVkIHJlZ2lzdGVyLiBUaGlz
IGNhbiBiZSBxdWl0ZSBzbG93IHRob3VnaCBpZiB5b3Ugd2FudCB0byByZWFkIA0KPiBtdWx0aXBs
ZSByZWdpc3RlcnMgYW5kIGlzIHRvbyBzbG93IHRvIGJlIGFibGUgdG8gcmVhZCBhbGwgdGhlIGRh
dGENCj4gYXQgDQo+IGZ1bGwgZGF0YSByYXRlLiBTbyB0aGVyZSBpcyBhIHNwZWNpYWwgYnVyc3Qg
bW9kZSB3aGljaCBhbGxvd3MgdG8NCj4gcmVhZCANCj4gYWxsIHRoZSBkYXRhIHJlZ2lzdGVycyBp
biBvbmUgZ28uDQo+IA0KPiBOb3cgYnkgZGVmYXVsdCB0aGUgZGF0YSByZWdpc3RlcnMgYXJlIDE2
LWJpdC4gQnV0IHRoZXJlIGlzIGFuDQo+IGludGVybmFsIA0KPiBkZWNpbWF0aW9uIGZpbHRlciBh
bmQgdGhlIGV4dHJhIGJpdHMgcHJvZHVjZWQgYnkgdGhlIGRlY2ltYXRpb24NCj4gZmlsdGVyIA0K
PiBnbyBpbnRvIGFkZGl0aW9uYWwgZGF0YSByZWdpc3RlcnMgbWFraW5nIHRoZSBkYXRhIDMyLWJp
dCB3aWRlLiBUaGUNCj4gY2hpcCANCj4gYWxsb3dzIHRvIGNvbmZpZ3VyZSB3aGV0aGVyIHRvIHJl
YWQgdGhlIG9ubHkgMTYtYml0IE1TQnMgb3IgdGhlIGZ1bGwgDQo+IDMyLWJpdCByZWdpc3Rlci4N
Cj4gDQo+IFNvIHRoZSBkZWNpc2lvbiB3aGV0aGVyIGEgdXNlciB3YW50cyB0byB1c2UgMzItYml0
IG9yIDE2LWJpdCBkZXBlbmRzDQo+IG9uIA0KPiB3aGV0aGVyIHRoZSBleHRyYSAxNi1iaXQgYXJl
IG5lZWRlZCBvciBpZiB0aGV5IGFyZSBldmVuIGF2YWlsYWJsZS4NCj4gRS5nLiANCj4gaWYgdGhl
IGRlY2ltYXRpb24gZmlsdGVyIGlzIG9mZiB0aGVyZSB3b250IGJlIGFueSBleHRyYSBiaXRzLg0K
PiANCj4gVGhpcyBtZWFucyBpZGVhbGx5IGl0IHdvdWxkIGJlIHVzZXIgY29uZmlndXJhYmxlIHdo
ZXRoZXIgdG8gdXNlIDE2LQ0KPiBiaXQgDQo+IG9yIDMyLWJpdCBidXJzdCBtb2RlLCBzaW5jZSBp
dCBpcyBhcHBsaWNhdGlvbiBzcGVjaWZpYy4gVGhlIHByb2JsZW0NCj4gaXMgDQo+IHdlIGRvbid0
IGhhdmUgYW4gaW50ZXJmYWNlIGZvciBjaGFuZ2luZyB0aGUgYml0IHdpZHRoIG9mIGEgYnVmZmVy
IA0KPiBjaGFubmVsLiBBZGRpbmcgc3VjaCBhbiBpbnRlcmZhY2Ugd291bGQgcmVxdWlyZSBxdWl0
ZSBhIGJpdCBvZg0KPiBlZmZvcnQgDQo+IHNpbmNlIHRoZSBhc3N1bXB0aW9uIGN1cnJlbnRseSBp
cyB0aGF0IHRoZSBiaXQgd2lkdGggZG9lcyBub3QNCj4gY2hhbmNlLiANCj4gRS5nLiBsaWJpaW8g
YXNzdW1lcyB0aGlzIGFuZCB3b3VsZCBzdG9wIHdvcmtpbmcgaWYgaXQgZGlkIGNoYW5nZS4NCj4g
DQo+IE1heWJlIGFzIGEgY29tcHJvbWlzZSBmb3Igbm93LiBVc2UgMzItYml0IGJ1cnN0IHdoZW4g
dGhlcmUgaXMNCj4gYWN0dWFsbHkgDQo+IG1lYW5pbmdmdWwgZGF0YSBpcyB0aGUgTFNCcywgaS5l
LiB0aGUgZGVjaW1hdGlvbiBmaWx0ZXIgaXMgdXNlZCBhbmQgDQo+IGRpc2FibGUgaXQgb3RoZXJ3
aXNlLiBBbmQgdGhlbiB0aGluayBhYm91dCBob3cgdG8gbWFrZSBpdA0KPiBjb25maWd1cmFibGUg
DQo+IGFzIGEgZm9sbG93IHVwIGFjdGlvbi4NCg0KSSBkbyBhZ3JlZSB3aXRoIHRoYXQuIEp1c3Qg
dG8gYWRkIHRoYXQgSSB0aGluayB3ZSBhbHNvIG5lZWQgdG8gdGFrZQ0KaW50byBhY2NvdW50IHRo
ZSBGSVIgZmlsdGVyIHdoaWNoIGNhbiBhbHNvIGJlIHJlc3BvbnNpYmxlIGZvciBiaXQNCmdyb3d0
aC4gSSB3aWxsIGNhY2hlIHRoZXNlIHZhbHVlcyBhbmQgaWYgb25lIG9mIHRoZW0gaXMgIT0gMCB0
aGFuIGJ1cnN0DQozMiB3aWxsIGJlIHVzZWQuLi4NCg0KPiBJbiBteSBvcGluaW9uIHRoZXJlIGlz
IHNob3VsZCBub3QgYmUgYSBkaWZmZXJlbmNlIGluIHRoZSB1c2Vyc3BhY2UgDQo+IGludGVyZmFj
ZSBmb3IgY2hpcHMgdGhhdCBkbyBzdXBwb3J0IDMyLWJpdCBidXJzdCBhbmQgdGhvc2UgdGhhdA0K
PiBkb24ndC4gDQo+IEZvciBkZXZpY2VzIHRoYXQgZG9uJ3Qgc3VwcG9ydCAzMi1iaXQgYnVyc3Qg
aXQgc2hvdWxkIGJlIGVtdWxhdGVkIGJ5IA0KPiByZWFkaW5nIHRoZSBMU0IgYml0cyByZWdpc3Rl
cnMgbWFudWFsbHkuDQoNCkhtbS4gSW4gdGVybXMgb2YgaW50ZXJmYWNlIEkgdGhpbmsgdGhlcmUg
aXMgbm8gZGlmZmVyZW5jZS4gV2UgYWx3YXlzDQpyZXBvcnQgMzJiaXRzIGNoYW5uZWxzIChmb3Ig
YWNjZWwgYW5kIGd5cm8pLiBIb3dldmVyLCB3aGF0IHdlIGRvIHJpZ2h0DQprbm93IGlzIGp1c3Qg
dG8gc2V0IHRoZSBMU0IgdG8gMCBpZiBidXJzdDMyIGlzIG5vdCBzdXBwb3J0ZWQuIFNvLCB3ZQ0K
Y2FuIGJlIGp1c3QgaWdub3JpbmcgdGhlIExTQiBiaXRzIGlmIHRoZXkgYXJlIGJlaW5nIHVzZWQu
Li4NCg0KLSBOdW5vIFPDoQ0KPiAtIExhcnMNCj4gDQoNCg==
