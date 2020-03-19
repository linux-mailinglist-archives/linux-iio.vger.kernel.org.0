Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A619218AD0B
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 08:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgCSHAn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 03:00:43 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:36876 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgCSHAn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 03:00:43 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02J6w7SV013450;
        Thu, 19 Mar 2020 03:00:17 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2056.outbound.protection.outlook.com [104.47.38.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2yu88sn4m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 03:00:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a74fgonOfPBATnt7r1MyqIGQHVXKJHqQVyzpFtjPuHkb9FIbTSaWIo7GBvnAksMKcbqzH8kx2apziMF9iOi/sjw7YOw/+hjkwNZuQfNBSLdCqSgyE/DDQ+wXXQ1BT6645Uq+c4H51Lp58F9bCEi+zNBHhgXWo3R2Ibp73uSbXjHy5k/o20J/1pFfWII4D4QSuG+Qij7he85befwJhGeoaSKBONK+MBPObGUMfYwWz5LXrCorLlGiMwE+wCDrisQfwQ4ijds2l1EIIs3OddNWSxB9CRk7sF6UBMInVPsghO7dxpyzou8q3ViZBqgUHF7ub8nNgrK5cKXFXDmUH+iCMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4Iu06pMSDCguCIYqARd0Tm3EFVT7DeZvxADdOby3ks=;
 b=QL5vA2uTRJ++xuSE+YYCQzXSQPx7zVwz8KQOi3HuwJaBeKkP7ilLTHNJFKNmZQpkHgiwhrrreXrqP7u6ia8TbllGTqrvIps2svnCAYsx4cd8/n3J3NU0/BBgeMZcytVjUWRsIIfG3gokgV1wLYzxE7Ke9Iix9lXPMneG2G73Zeo+V5+SzGTeRMvaeLCl8zOcOSokyMfhtM6jBz1I54gv/PcB3WY6pbA1YH5ajUGAnuU8CX0KALk1uN3FL36aXXJabb3164LNaf4+cJhw2oYFr7zlqOAB2yVxQh919Ul2njj2eI1aJJlzaAP5Ff6w59weShOVtoZbBY0nziEqL0sYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4Iu06pMSDCguCIYqARd0Tm3EFVT7DeZvxADdOby3ks=;
 b=p3wrngKYT5tM5VMHb02AyoaBuPvhHRjS6Q846eygTvZAl9Dj7eMLTyV1UOZ/noOAoXrB+5Yb0PnJVPv3vSIZais7eNJ4yj8g6bdhWTEhFzv/RbmUeI/mrAVf3YE7dnksshOR9VmLOAf1Wp9yLJnoQdNS2cFZtp4Vd7JEzJmmSlI=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3932.namprd03.prod.outlook.com (2603:10b6:5:46::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Thu, 19 Mar
 2020 07:00:12 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Thu, 19 Mar 2020
 07:00:12 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "mh12gx2825@gmail.com" <mh12gx2825@gmail.com>,
        "julia.lawall@inria.fr" <julia.lawall@inria.fr>
CC:     "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [Outreachy kernel] Re: [PATCH 2/2] staging: iio: adc: ad7280a:
 Add spaces around operators
Thread-Topic: [Outreachy kernel] Re: [PATCH 2/2] staging: iio: adc: ad7280a:
 Add spaces around operators
Thread-Index: AQHV/N2ybpBps/EzlU+x4vN/65WR1qhN21wAgACaLgCAAAHwAIAAEgeAgAABOICAAAkcgIAA63EA
Date:   Thu, 19 Mar 2020 07:00:12 +0000
Message-ID: <b471d6102a731d577fff9f2175d4e35217a45e18.camel@analog.com>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
         <6703668c512dd665a2299a1f5bf14d99262314f8.1584505215.git.mh12gx2825@gmail.com>
         <20200318060038.GB1594471@kroah.com>
         <35afdc4b-bd59-7851-aa4f-3d8807668931@metafoo.de>
         <20200318151924.GB2862853@kroah.com> <20200318162353.GA23226@deeUbuntu>
         <alpine.DEB.2.21.2003181727440.2979@hadrien>
         <20200318170051.GA23498@deeUbuntu>
In-Reply-To: <20200318170051.GA23498@deeUbuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84c05db4-f485-4c42-0013-08d7cbd32bc4
x-ms-traffictypediagnostic: DM6PR03MB3932:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB3932E7BD99A7540D48775224F9F40@DM6PR03MB3932.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(39860400002)(376002)(199004)(5660300002)(53546011)(6486002)(110136005)(7416002)(8936002)(4326008)(316002)(36756003)(478600001)(86362001)(966005)(66946007)(91956017)(2616005)(26005)(76116006)(2906002)(81156014)(81166006)(8676002)(54906003)(66476007)(71200400001)(6512007)(186003)(6506007)(64756008)(66446008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3932;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4uQ/5PnQuVMmilSM8oYJYRv7moqvUF4zD5BnVcDuiaEVNblG2YJaCXCaeSoce7OufQmiM1MSneUTEsFFifuwyI32KdKQiiMlD+jx4ArS3xjEaGfzkv0xwXt1i8d9w55S/qeYrlCVZpkpGh38Y63qT6su+8sPGakgbcwXBk4OreRAu3+TPuelYP+ViG7LVUHQge0aMqqE4+EJ8lFYAI5tya7nv1zdTBwK1TpVVSQ0PNPDxVxaCn3JEb8rwOGOo9QttzxIufD6b4yeyHtKn4aIutX/w3YG33jyMVkwasOc2vBbkYCjHDhOPNjcChfVqBcHLZe976eAXGSj7bKska8MNNE+YXpbvbGIdV4bsl/6miOWy4sVPC78BnRPaSNKsdoIdTfl384Qd3Xl4mEJOXAl4J+PjouUkOTrLiU4DkVzq44jskx9QDrmZ9Ui2tMa9qmqmmBvb5IOF4vz4UVO5n1iidWVPM9hKUT5/dXjJxss+r1X1QF1E7TjNhU5UCuX24HifBzH4t05FKzXq5g9/7gjJA==
x-ms-exchange-antispam-messagedata: E4rcJehg94ssucfHbskdqpM8DRBnSQOm990KtfYrKFF3OXXiS0dlYpywudppFigoX5yUatcMLlhffz9i5KTyayJMPReOwEoXJoVstT6xX1F0ktV6xyC6DqAomf65yCUcWNHZRWANg89DlUpgfgCu+Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEEA98D62482B644BC463A7C285ED467@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c05db4-f485-4c42-0013-08d7cbd32bc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 07:00:12.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSRNGzPss4NeTiMApXipzXzmtJwohFDXY8nvNlm/i1lbf9xwkpxrke/ZvR0IwXGxeqDZN5BJfx/0noLeAztN6xbuiuNKAvtOhfYMnN9Mi58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3932
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_10:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1031 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190031
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTE4IGF0IDIyOjMwICswNTMwLCBERUVQQUsgVkFSTUEgd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFdlZCwgTWFyIDE4LCAyMDIwIGF0IDA1OjI4OjE3UE0gKzAx
MDAsIEp1bGlhIExhd2FsbCB3cm90ZToNCj4gPiANCj4gPiBPbiBXZWQsIDE4IE1hciAyMDIwLCBE
RUVQQUsgVkFSTUEgd3JvdGU6DQo+ID4gDQo+ID4gPiBPbiBXZWQsIE1hciAxOCwgMjAyMCBhdCAw
NDoxOToyNFBNICswMTAwLCBHcmVnIEtIIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIE1hciAxOCwg
MjAyMCBhdCAwNDoxMjoyOFBNICswMTAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3JvdGU6DQo+ID4g
PiA+ID4gT24gMy8xOC8yMCA3OjAwIEFNLCBHcmVnIEtIIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24g
V2VkLCBNYXIgMTgsIDIwMjAgYXQgMDk6NTg6MTNBTSArMDUzMCwgRGVlcGFrIFIgVmFybWEgd3Jv
dGU6DQo+ID4gPiA+ID4gPiA+IEFkZCBzcGFjZXMgYXJvdW5kIG9wZXJhdG9yIHN5bWJvbHMgdG8g
aW1wcm92ZSByZWFkYWJpbGl0eS4gV2FybmluZw0KPiA+ID4gPiA+ID4gPiBmbGFnZ2VkIGJ5IGNo
ZWNrcGF0Y2ggc2NyaXB0Lg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogRGVlcGFrIFIgVmFybWEgPG1oMTJneDI4MjVAZ21haWwuY29tPg0KPiA+ID4gPiA+ID4g
PiAtLS0NCj4gPiA+ID4gPiA+ID4gICBkcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDcyODBhLmMg
fCA0ICsrLS0NCj4gPiA+ID4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzI4MGEuYw0KPiA+ID4gPiA+ID4gPiBiL2Ry
aXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzI4MGEuYw0KPiA+ID4gPiA+ID4gPiBpbmRleCAxOWE1
ZjI0NGRjYWUuLjM0Y2EwZDA5ZGI4NSAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9zdGFnaW5nL2lpby9hZGMvYWQ3MjgwYS5jDQo+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
c3RhZ2luZy9paW8vYWRjL2FkNzI4MGEuYw0KPiA+ID4gPiA+ID4gPiBAQCAtODI1LDE0ICs4MjUs
MTQgQEAgc3RhdGljIGlycXJldHVybl90IGFkNzI4MF9ldmVudF9oYW5kbGVyKGludA0KPiA+ID4g
PiA+ID4gPiBpcnEsIHZvaWQgKnByaXZhdGUpDQo+ID4gPiA+ID4gPiA+ICAgfQ0KPiA+ID4gPiA+
ID4gPiAgIHN0YXRpYyBJSU9fREVWSUNFX0FUVFJfTkFNRUQoaW5fdGhyZXNoX2xvd192YWx1ZSwN
Cj4gPiA+ID4gPiA+ID4gLQkJCSAgICAgaW5fdm9sdGFnZS12b2x0YWdlX3RocmVzaF9sb3dfdmFs
dWUsDQo+ID4gPiA+ID4gPiA+ICsJCQkgICAgIGluX3ZvbHRhZ2UgLSB2b2x0YWdlX3RocmVzaF9s
b3dfdmFsdWUsDQo+ID4gPiA+ID4gPiA+ICAgCQkJICAgICAwNjQ0LA0KPiA+ID4gPiA+ID4gPiAg
IAkJCSAgICAgYWQ3MjgwX3JlYWRfY2hhbm5lbF9jb25maWcsDQo+ID4gPiA+ID4gPiA+ICAgCQkJ
ICAgICBhZDcyODBfd3JpdGVfY2hhbm5lbF9jb25maWcsDQo+ID4gPiA+ID4gPiA+ICAgCQkJICAg
ICBBRDcyODBBX0NFTExfVU5ERVJWT0xUQUdFKTsNCj4gPiA+ID4gPiA+ID4gICBzdGF0aWMgSUlP
X0RFVklDRV9BVFRSX05BTUVEKGluX3RocmVzaF9oaWdoX3ZhbHVlLA0KPiA+ID4gPiA+ID4gPiAt
CQkJICAgICBpbl92b2x0YWdlLXZvbHRhZ2VfdGhyZXNoX2hpZ2hfdmFsdWUsDQo+ID4gPiA+ID4g
PiA+ICsJCQkgICAgIGluX3ZvbHRhZ2UgLSB2b2x0YWdlX3RocmVzaF9oaWdoX3ZhbHVlLA0KPiA+
ID4gPiA+ID4gPiAgIAkJCSAgICAgMDY0NCwNCj4gPiA+ID4gPiA+ID4gICAJCQkgICAgIGFkNzI4
MF9yZWFkX2NoYW5uZWxfY29uZmlnLA0KPiA+ID4gPiA+ID4gPiAgIAkJCSAgICAgYWQ3MjgwX3dy
aXRlX2NoYW5uZWxfY29uZmlnLA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBEaWQgeW91IHRy
eSBidWlsZGluZyB0aGlzIGNvZGU/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEl0IGNhdGNo
ZXMgZXZlcnlvbmUuLi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgcHJvYmxlbSBpcyBpdCBi
dWlsZHMuIFRoZSB0b2tlbiBpcyBzdHJpbmd5ZmllZCBhbmQNCj4gPiA+ID4gPiAiaW5fdm9sdGFn
ZSAtIHZvbHRhZ2VfdGhyZXNoX2hpZ2hfdmFsdWUiIGlzIGEgdmFsaWQgc3RyaW5nLg0KPiA+ID4g
PiANCj4gPiA+ID4gQWgsIEkgdGhvdWdodCBpdCB1c2VkIHRvIGJyZWFrIHRoZSBidWlsZCB3aGVu
IGl0IGhhcHBlbmVkLiAgT2ggd2VsbCwNCj4gPiA+ID4gaXQncyBzdGlsbCBhIGdyZWF0ICJ0cmlj
ayIgdG8gc2VlIGlmIHBlb3BsZSB1bmRlcnN0YW5kIEMgb3Igbm90IDopDQo+ID4gPiA+IA0KPiA+
ID4gWWVzLCBpdCBkaWQgYnVpbGQuIEkgYW0gc29ycnkgYnV0IEkgYW0gbm90IGZvbGxvd2luZyB5
b3UgZnVsbHkuIENhbiB5b3UNCj4gPiA+IHBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGUgY2hhbmdl
IEkgaW50cm9kdWNlZCBpcyBub3QgZ29vZC4gWW91IG1heQ0KPiA+ID4gcGxlYXNlIGRpcmVjdCBt
ZSB0byBhIGRvY3VtZW50IHdoZXJlIEkgY2FuIHJlYWQgbW9yZSBhYm91dCBpdC4NCj4gPiANCj4g
PiBUaGUgY29kZSBpbnZvbHZlcyBhIG1hY3JvLCBhcyBpbmRpY2F0ZWQgYnkgdGhlIGNhcGl0YWwg
bGV0dGVycy4gIFlvdSB3aWxsDQo+ID4gc2VlIHRoZSBpc3N1ZSB3aGVuIHlvdSBsb29rIGF0IHRo
ZSBkZWZpbml0aW9uIG9mIHRoZSBtYWNyby4NCj4gPiANCj4gPiBqdWxpYQ0KPiANCj4gVGhhbmsg
eW91IEp1bGlhIGFuZCBhbGwuIEkgZ290IG15IG1pc3Rha2UuIEkgd2lsbCByZXZlcnQgdGhlIGNo
YW5nZS4NCj4gU29ycnkgZm9yIHRoZSB0cm91YmxlLg0KDQpJJ2xsIHRyeSB0byBtYWtlIHNvbWUg
dGltZSB0byBhZGRyZXNzIHRoaXMgc29tZWhvdywgc28gdGhhdCBjaGVja3BhdGNoIGRvZXNuJ3QN
CmJ1bXAgaW50byB0aGlzLg0KDQpJbiB0aGUgbGFzdCAyLTMgeWVhcnMsIEkgdGhpbmsgSSBzYXcg
My00IHBhdGNoZXMgdHJ5aW5nIHRvIGFkZHJlc3MgdGhpcyBbZm9yDQp2YXJpb3VzIEFuYWxvZyBk
cml2ZXJzXS4NClNvLCBkb24ndCBmZWVsIHRvbyBiYWQuDQoNCg0KPiANCj4gRGVlcGFrLg0KPiA+
ID4gVGhhbmtzLA0KPiA+ID4gRGVlcGFrLg0KPiA+ID4gPiB0aGFua3MsDQo+ID4gPiA+IA0KPiA+
ID4gPiBncmVnIGstaA0KPiA+ID4gDQo+ID4gPiAtLQ0KPiA+ID4gWW91IHJlY2VpdmVkIHRoaXMg
bWVzc2FnZSBiZWNhdXNlIHlvdSBhcmUgc3Vic2NyaWJlZCB0byB0aGUgR29vZ2xlIEdyb3Vwcw0K
PiA+ID4gIm91dHJlYWNoeS1rZXJuZWwiIGdyb3VwLg0KPiA+ID4gVG8gdW5zdWJzY3JpYmUgZnJv
bSB0aGlzIGdyb3VwIGFuZCBzdG9wIHJlY2VpdmluZyBlbWFpbHMgZnJvbSBpdCwgc2VuZCBhbg0K
PiA+ID4gZW1haWwgdG8gb3V0cmVhY2h5LWtlcm5lbCt1bnN1YnNjcmliZUBnb29nbGVncm91cHMu
Y29tLg0KPiA+ID4gVG8gdmlldyB0aGlzIGRpc2N1c3Npb24gb24gdGhlIHdlYiB2aXNpdCANCj4g
PiA+IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZC9tc2dpZC9vdXRyZWFjaHkta2VybmVsLzIw
MjAwMzE4MTYyMzUzLkdBMjMyMjYlNDBkZWVVYnVudHUNCj4gPiA+IC4NCj4gPiA+IA0K
