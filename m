Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE12B18AD29
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 08:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgCSHHt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 03:07:49 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55938 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgCSHHt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 03:07:49 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02J77EQR028777;
        Thu, 19 Mar 2020 03:07:22 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yu750wx0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 03:07:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GH+JeuQMPDW5qTIx0lE52BiKufThUMC1MY7RUTZUtLHe7G+B3Z+bJZvZv7WQ4Gt6sdrv1wurvJSY/VKGsCUg1A3MQk3cYWBXpA9F4kdXNb+pt+BcXMMod4D6XZhYE6JbAS5WQPAVUu/+099VZ0kh9TC0g/LmQ3BbGpm7GUqMTBAEwlr6BgJ0M2mfC3z2Z1MFOiTWFOQnE5WTj+rBOBBOQOelm70jf6mjSmD0wtOWKYDN8tOFngYXMIGx9SVnlXkGiSaTz6I1F5zipxGa4QPn0GML3uS5lXkeWaZsBUsnlX1tSUeU41oVjsPJDOL6UxGs+D3T56zd4unI+XPRlsRlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0LCKdXFtUEk0KcKtBinyNqXEizL5cRGllj5cJ37CPY=;
 b=bJg+akhHEdeKWK/SdSufGBnqQcv+l5f/1YJVn+O+NLD7RpGphuvfFPYO2MFPwPADWb/sLk7s+1E5ZTlNiL6KjeerAqVs6GapdcQoHdH5oHi/cvJDhn1ujCDTMHiw5BtZj6t352Vwb/NDVAKH2Bzuq/I5jry6AsqhzNNoy2GfxbChSgIGg64ediSpb2a/Byj8fBLADreT6Xo4DTkkhxLWgxnEouVIHBBiiJstDRWItco/MfoBrlQJwbueZ+p9eTHEuH4YPjvPTrNS2oAG1pcZgaacEvAKnfkhCx2hnDp0R8X1ESf5moUljD+z3W2rC6nO1xN+XOQltuJx+oqCJcEpMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0LCKdXFtUEk0KcKtBinyNqXEizL5cRGllj5cJ37CPY=;
 b=FwrTnJa44R2C01GvIY3C5DEZ67D0QtrR5Ekz0dpANONc7hAbVVNRiwbdHtYkn5rF+wGxi06BgPCjJ++gTCzaqcfDmsACfcxuku5WdlpvTEAW8cshDiId8ua7D/OBdug/AzarOU8QHtyaftsEfMFH45zXX15jzBYb4ZsnwjYww4Q=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4458.namprd03.prod.outlook.com (2603:10b6:5:107::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Thu, 19 Mar
 2020 07:07:21 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Thu, 19 Mar 2020
 07:07:21 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "julia.lawall@inria.fr" <julia.lawall@inria.fr>
CC:     "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "mh12gx2825@gmail.com" <mh12gx2825@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>
Subject: Re: [Outreachy kernel] Re: [PATCH 2/2] staging: iio: adc: ad7280a:
 Add spaces around operators
Thread-Topic: [Outreachy kernel] Re: [PATCH 2/2] staging: iio: adc: ad7280a:
 Add spaces around operators
Thread-Index: AQHV/N2ybpBps/EzlU+x4vN/65WR1qhN21wAgACaLgCAAAHwAIAAEgeAgAABOICAAAkcgIAA63EA////4QCAAAIeAA==
Date:   Thu, 19 Mar 2020 07:07:20 +0000
Message-ID: <f783d807e2e74ae492c83eb9827ac43767411808.camel@analog.com>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
          <6703668c512dd665a2299a1f5bf14d99262314f8.1584505215.git.mh12gx2825@gmail.com>
          <20200318060038.GB1594471@kroah.com>
          <35afdc4b-bd59-7851-aa4f-3d8807668931@metafoo.de>
          <20200318151924.GB2862853@kroah.com> <20200318162353.GA23226@deeUbuntu>
          <alpine.DEB.2.21.2003181727440.2979@hadrien>
          <20200318170051.GA23498@deeUbuntu>
         <b471d6102a731d577fff9f2175d4e35217a45e18.camel@analog.com>
         <alpine.DEB.2.21.2003190802450.3010@hadrien>
In-Reply-To: <alpine.DEB.2.21.2003190802450.3010@hadrien>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 478f3c2c-221d-45c6-0c9f-08d7cbd42afd
x-ms-traffictypediagnostic: DM6PR03MB4458:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB44580C40EAF58D41AF8D807CF9F40@DM6PR03MB4458.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(136003)(199004)(6486002)(6916009)(316002)(86362001)(186003)(2616005)(26005)(54906003)(7416002)(64756008)(76116006)(2906002)(81166006)(81156014)(66446008)(66476007)(66556008)(91956017)(66946007)(8936002)(8676002)(36756003)(966005)(4326008)(71200400001)(478600001)(6506007)(53546011)(5660300002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4458;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uoXcLPTsN9CksaJCJuJShCxCJoWLik9aM1XWnVUjVK/8TiFUQWowJQDELtwaJhvU5JgfOUxhSJPTPjUONo9+WFndCimDiFODOFR5XoJYkeeSTUUvfIU9lXTp8hXypQ3ok1OeYFdbtIT6PgF6YHexXYdJq12AspYNKGc9hFIa6PVXSQEifIOphICipIjSPRbO62LJmy6VbDR9TsxM0V1EE0VttmrVPAHZ1uVlTatFLlRahd9IsRpUgbg37rVipXryAJxItlocBR3IFqHpBDhPvzIIu08Hg7p8wDfKzK2W3ym9yfCUdEh50zJsPIH8P5Vm28banhcanmksO5/JJCm5r8kDSE2+1nzwvS/E4rpm27u0TSoEP7yv4K8e8wapo+xmH9c8U64jTo78AF+jiIMGiqnJv06DUmdsAe9HDiK3ip2BVnWZgusyjxFqklP6swYuEagJIeFPvxgY9Y/iGSc48LI5kfR8ERf6iQRRXyfVeVAeMYxMLDGqFXDKDGFfsHbMb2mxAINvKijGyHMOacBj4Q==
x-ms-exchange-antispam-messagedata: luDZCNOYMcX/bx8vapa5lraYCvKcHXNtA/1GCDj4sjxMgrhvPQbL50qJ5Bo0lBvS3BQCIUFtqToeM2a6IGyl6jnsTfL68qXJO3hac3bHPbq4VSE7hphqck/dtpFE43dXWtNjTElxLwJ+lQHe8DTWZg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <66A7263C86C271428D3BD8877DB4F348@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478f3c2c-221d-45c6-0c9f-08d7cbd42afd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 07:07:20.9707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FM4JncbnOEzpNIi2NMzjVW3LPyLzWl90/sS+9u6ETEDwzZHz8WErKuHYfSnlC6K7xNIW4m45kTdEQBuXzECO5/ihmwtDpF5g3B0S8a7zCxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4458
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_10:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 clxscore=1031 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190032
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTE5IGF0IDA4OjAzICswMTAwLCBKdWxpYSBMYXdhbGwgd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiANCj4gT24gVGh1LCAxOSBNYXIgMjAyMCwgQXJkZWxlYW4s
IEFsZXhhbmRydSB3cm90ZToNCj4gDQo+ID4gT24gV2VkLCAyMDIwLTAzLTE4IGF0IDIyOjMwICsw
NTMwLCBERUVQQUsgVkFSTUEgd3JvdGU6DQo+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPiANCj4gPiA+
IE9uIFdlZCwgTWFyIDE4LCAyMDIwIGF0IDA1OjI4OjE3UE0gKzAxMDAsIEp1bGlhIExhd2FsbCB3
cm90ZToNCj4gPiA+ID4gT24gV2VkLCAxOCBNYXIgMjAyMCwgREVFUEFLIFZBUk1BIHdyb3RlOg0K
PiA+ID4gPiANCj4gPiA+ID4gPiBPbiBXZWQsIE1hciAxOCwgMjAyMCBhdCAwNDoxOToyNFBNICsw
MTAwLCBHcmVnIEtIIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gV2VkLCBNYXIgMTgsIDIwMjAgYXQg
MDQ6MTI6MjhQTSArMDEwMCwgTGFycy1QZXRlciBDbGF1c2VuIHdyb3RlOg0KPiA+ID4gPiA+ID4g
PiBPbiAzLzE4LzIwIDc6MDAgQU0sIEdyZWcgS0ggd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gT24g
V2VkLCBNYXIgMTgsIDIwMjAgYXQgMDk6NTg6MTNBTSArMDUzMCwgRGVlcGFrIFIgVmFybWEgd3Jv
dGU6DQo+ID4gPiA+ID4gPiA+ID4gPiBBZGQgc3BhY2VzIGFyb3VuZCBvcGVyYXRvciBzeW1ib2xz
IHRvIGltcHJvdmUgcmVhZGFiaWxpdHkuDQo+ID4gPiA+ID4gPiA+ID4gPiBXYXJuaW5nDQo+ID4g
PiA+ID4gPiA+ID4gPiBmbGFnZ2VkIGJ5IGNoZWNrcGF0Y2ggc2NyaXB0Lg0KPiA+ID4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEZWVwYWsgUiBWYXJtYSA8
bWgxMmd4MjgyNUBnbWFpbC5jb20+DQo+ID4gPiA+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+
ID4gPiA+ICAgZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3MjgwYS5jIHwgNCArKy0tDQo+ID4g
PiA+ID4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDcyODBhLmMNCj4gPiA+ID4gPiA+ID4gPiA+IGIv
ZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3MjgwYS5jDQo+ID4gPiA+ID4gPiA+ID4gPiBpbmRl
eCAxOWE1ZjI0NGRjYWUuLjM0Y2EwZDA5ZGI4NSAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzI4MGEuYw0KPiA+ID4gPiA+ID4gPiA+ID4g
KysrIGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3MjgwYS5jDQo+ID4gPiA+ID4gPiA+ID4g
PiBAQCAtODI1LDE0ICs4MjUsMTQgQEAgc3RhdGljIGlycXJldHVybl90DQo+ID4gPiA+ID4gPiA+
ID4gPiBhZDcyODBfZXZlbnRfaGFuZGxlcihpbnQNCj4gPiA+ID4gPiA+ID4gPiA+IGlycSwgdm9p
ZCAqcHJpdmF0ZSkNCj4gPiA+ID4gPiA+ID4gPiA+ICAgfQ0KPiA+ID4gPiA+ID4gPiA+ID4gICBz
dGF0aWMgSUlPX0RFVklDRV9BVFRSX05BTUVEKGluX3RocmVzaF9sb3dfdmFsdWUsDQo+ID4gPiA+
ID4gPiA+ID4gPiAtCQkJICAgICBpbl92b2x0YWdlLQ0KPiA+ID4gPiA+ID4gPiA+ID4gdm9sdGFn
ZV90aHJlc2hfbG93X3ZhbHVlLA0KPiA+ID4gPiA+ID4gPiA+ID4gKwkJCSAgICAgaW5fdm9sdGFn
ZSAtDQo+ID4gPiA+ID4gPiA+ID4gPiB2b2x0YWdlX3RocmVzaF9sb3dfdmFsdWUsDQo+ID4gPiA+
ID4gPiA+ID4gPiAgIAkJCSAgICAgMDY0NCwNCj4gPiA+ID4gPiA+ID4gPiA+ICAgCQkJICAgICBh
ZDcyODBfcmVhZF9jaGFubmVsX2NvbmZpZywNCj4gPiA+ID4gPiA+ID4gPiA+ICAgCQkJICAgICBh
ZDcyODBfd3JpdGVfY2hhbm5lbF9jb25maWcsDQo+ID4gPiA+ID4gPiA+ID4gPiAgIAkJCSAgICAg
QUQ3MjgwQV9DRUxMX1VOREVSVk9MVEFHRSk7DQo+ID4gPiA+ID4gPiA+ID4gPiAgIHN0YXRpYyBJ
SU9fREVWSUNFX0FUVFJfTkFNRUQoaW5fdGhyZXNoX2hpZ2hfdmFsdWUsDQo+ID4gPiA+ID4gPiA+
ID4gPiAtCQkJICAgICBpbl92b2x0YWdlLQ0KPiA+ID4gPiA+ID4gPiA+ID4gdm9sdGFnZV90aHJl
c2hfaGlnaF92YWx1ZSwNCj4gPiA+ID4gPiA+ID4gPiA+ICsJCQkgICAgIGluX3ZvbHRhZ2UgLQ0K
PiA+ID4gPiA+ID4gPiA+ID4gdm9sdGFnZV90aHJlc2hfaGlnaF92YWx1ZSwNCj4gPiA+ID4gPiA+
ID4gPiA+ICAgCQkJICAgICAwNjQ0LA0KPiA+ID4gPiA+ID4gPiA+ID4gICAJCQkgICAgIGFkNzI4
MF9yZWFkX2NoYW5uZWxfY29uZmlnLA0KPiA+ID4gPiA+ID4gPiA+ID4gICAJCQkgICAgIGFkNzI4
MF93cml0ZV9jaGFubmVsX2NvbmZpZywNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
PiBEaWQgeW91IHRyeSBidWlsZGluZyB0aGlzIGNvZGU/DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+ID4gSXQgY2F0Y2hlcyBldmVyeW9uZS4uLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gVGhlIHByb2JsZW0gaXMgaXQgYnVpbGRzLiBUaGUgdG9rZW4gaXMgc3RyaW5neWZp
ZWQgYW5kDQo+ID4gPiA+ID4gPiA+ICJpbl92b2x0YWdlIC0gdm9sdGFnZV90aHJlc2hfaGlnaF92
YWx1ZSIgaXMgYSB2YWxpZCBzdHJpbmcuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEFoLCBJ
IHRob3VnaHQgaXQgdXNlZCB0byBicmVhayB0aGUgYnVpbGQgd2hlbiBpdCBoYXBwZW5lZC4gIE9o
IHdlbGwsDQo+ID4gPiA+ID4gPiBpdCdzIHN0aWxsIGEgZ3JlYXQgInRyaWNrIiB0byBzZWUgaWYg
cGVvcGxlIHVuZGVyc3RhbmQgQyBvciBub3QgOikNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFll
cywgaXQgZGlkIGJ1aWxkLiBJIGFtIHNvcnJ5IGJ1dCBJIGFtIG5vdCBmb2xsb3dpbmcgeW91IGZ1
bGx5LiBDYW4NCj4gPiA+ID4gPiB5b3UNCj4gPiA+ID4gPiBwbGVhc2UgbGV0IG1lIGtub3cgaWYg
dGhlIGNoYW5nZSBJIGludHJvZHVjZWQgaXMgbm90IGdvb2QuIFlvdSBtYXkNCj4gPiA+ID4gPiBw
bGVhc2UgZGlyZWN0IG1lIHRvIGEgZG9jdW1lbnQgd2hlcmUgSSBjYW4gcmVhZCBtb3JlIGFib3V0
IGl0Lg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIGNvZGUgaW52b2x2ZXMgYSBtYWNybywgYXMgaW5k
aWNhdGVkIGJ5IHRoZSBjYXBpdGFsIGxldHRlcnMuICBZb3UNCj4gPiA+ID4gd2lsbA0KPiA+ID4g
PiBzZWUgdGhlIGlzc3VlIHdoZW4geW91IGxvb2sgYXQgdGhlIGRlZmluaXRpb24gb2YgdGhlIG1h
Y3JvLg0KPiA+ID4gPiANCj4gPiA+ID4ganVsaWENCj4gPiA+IA0KPiA+ID4gVGhhbmsgeW91IEp1
bGlhIGFuZCBhbGwuIEkgZ290IG15IG1pc3Rha2UuIEkgd2lsbCByZXZlcnQgdGhlIGNoYW5nZS4N
Cj4gPiA+IFNvcnJ5IGZvciB0aGUgdHJvdWJsZS4NCj4gPiANCj4gPiBJJ2xsIHRyeSB0byBtYWtl
IHNvbWUgdGltZSB0byBhZGRyZXNzIHRoaXMgc29tZWhvdywgc28gdGhhdCBjaGVja3BhdGNoDQo+
ID4gZG9lc24ndA0KPiA+IGJ1bXAgaW50byB0aGlzLg0KPiA+IA0KPiA+IEluIHRoZSBsYXN0IDIt
MyB5ZWFycywgSSB0aGluayBJIHNhdyAzLTQgcGF0Y2hlcyB0cnlpbmcgdG8gYWRkcmVzcyB0aGlz
IFtmb3INCj4gPiB2YXJpb3VzIEFuYWxvZyBkcml2ZXJzXS4NCj4gPiBTbywgZG9uJ3QgZmVlbCB0
b28gYmFkLg0KPiANCj4gTWF5YmUgYSBjb21tZW50Pw0KDQpDb21tZW50IHdvcmtzIGZvciBub3cu
DQpBbnlib2R5IHdhbnRzIHRvIGRvIGEgcGF0Y2ggZm9yIHRoYXQ/DQpJZiBub2JvZHkgc2VuZHMg
YSBwYXRjaCBmb3IgdGhpcyBpbiAxLTIgd2Vla3MsIEknbGwgc2VuZCBvbmUuDQoNClBhcnRpY3Vs
YXJseSwgdGhpcyB3b3VsZCBoZWxwIHdpdGggcmV2aWV3LCBzaW5jZSBwZW9wbGUgdGhhdCBhcmUg
dW5mYW1pbGlhciB3aXRoDQpJSU8tc3BlY2lmaWMgbWFjcm9zIHdvdWxkIGFsc28gZmluZCBpdCBl
YXNpZXIgYXQgcmV2aWV3Lg0KDQpUaGUgZ29vZCBwYXJ0LCBpcyB0aGF0IGl0J3Mgb25seSBuZWVk
ZWQgZm9yIEFENzI4MEEuDQpBRDcxOTIgaGFzIGJlZW4gcmUtd29ya2VkLCBhbmQgaXMgbm8gbG9u
Z2VyIG9uIGNoZWNrcGF0Y2gncyByYWRhci4NCkknbSByZXdvcmtpbmcgQUQ3NzkzIG5vdy4NCg0K
DQo+IA0KPiBqdWxpYQ0KPiANCj4gPiANCj4gPiA+IERlZXBhay4NCj4gPiA+ID4gPiBUaGFua3Ms
DQo+ID4gPiA+ID4gRGVlcGFrLg0KPiA+ID4gPiA+ID4gdGhhbmtzLA0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBncmVnIGstaA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4g
WW91IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBiZWNhdXNlIHlvdSBhcmUgc3Vic2NyaWJlZCB0byB0
aGUgR29vZ2xlDQo+ID4gPiA+ID4gR3JvdXBzDQo+ID4gPiA+ID4gIm91dHJlYWNoeS1rZXJuZWwi
IGdyb3VwLg0KPiA+ID4gPiA+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBncm91cCBhbmQgc3Rv
cCByZWNlaXZpbmcgZW1haWxzIGZyb20gaXQsIHNlbmQNCj4gPiA+ID4gPiBhbg0KPiA+ID4gPiA+
IGVtYWlsIHRvIG91dHJlYWNoeS1rZXJuZWwrdW5zdWJzY3JpYmVAZ29vZ2xlZ3JvdXBzLmNvbS4N
Cj4gPiA+ID4gPiBUbyB2aWV3IHRoaXMgZGlzY3Vzc2lvbiBvbiB0aGUgd2ViIHZpc2l0DQo+ID4g
PiA+ID4gaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9kL21zZ2lkL291dHJlYWNoeS1rZXJuZWwv
MjAyMDAzMTgxNjIzNTMuR0EyMzIyNiU0MGRlZVVidW50dQ0KPiA+ID4gPiA+IC4NCj4gPiA+ID4g
PiANCg==
