Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0260C18C80D
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 08:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCTHOP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 03:14:15 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25110 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgCTHOO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 03:14:14 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02K7DEA1017965;
        Fri, 20 Mar 2020 03:13:49 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yu751292u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 03:13:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcGQBO4sKKjLX29TZwS7WOwsoOV7ZcFEliVTrwhaZq7S8rfUJfbUwgJJWffHLIWTZCRI6TpWjt3pPER7IqjDCTlv9dj9GoO8wdsDoaRzbrCQ5bQUvNMTuVrV//uw07BZtDWOZvixr+oqbh65v0xDFO1qDtvPB6svQhU9mS7J6gWkyeeEaWUHK6BvtdiUfLGU/gthnBVyYa/Q3d5tOrNMgcN8owsDgXlRY1KjoS4ep9W/1eetH3bfP7/10N2Ey1LYrhxtPITfisTc5XWbk3koasJM9Bu0nJM7kI99//wreT8Z2kfXMJJNO6Oziqvz8z7tkwHlHtIW6NqSZ+cSkiuITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8aFbf3TEDKrY8TkPvSVFO4taYq939xC6fVIg9H5yHo=;
 b=ZxFxGJQMI8wtWBsES1Dl5YTVYaNKnSk2JGoaBzwPzYmRQuTTOxioZJsQwVHqQXvTCmGaEtoRgTWnsDWGqEOh1O08gv1pGBMzNdnn74lzUI9RxmpY+nnnGmvjEcXVF4wFO3omdkiOu7guDRAYPtnUSSZLUNBHJGA8ob4RjSeFPUICAlttlsA41Eby6IIpbUzpZM89O1rwcfyFRARuGRIob1XePlwlOqc5wGTfpfBmqHodcVlkpJeS3wZEUr0ESuLU06OUe5iTX/GBSVvbpiEf6USWlHfvwP5GxttOpRAvJ9uV16jVM5byJkADWKgB9EB3Q1xRq7jozZXQwkkbHONx3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8aFbf3TEDKrY8TkPvSVFO4taYq939xC6fVIg9H5yHo=;
 b=2uYGAGN3TrmPA8FARE8Dq3uhvs88JTkGfRf+fT72AFqBTJ1NdZsE0ebvLwSo3cq0qoRplhf/RcCuy+BvZ9H9Pxb3NFIUsICmJqayxg6/Q+qdfCaD1yy0n9U8PzaHFtVCPYwbMUT9cxyWMQShKzf9VtJZhAAAOmN18T4ja4m189g=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3609.namprd03.prod.outlook.com (2603:10b6:5:b0::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Fri, 20 Mar
 2020 07:13:48 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 07:13:47 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "mh12gx2825@gmail.com" <mh12gx2825@gmail.com>
CC:     "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "julia.lawall@inria.fr" <julia.lawall@inria.fr>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>
Subject: Re: [Outreachy kernel] Re: [PATCH 2/2] staging: iio: adc: ad7280a:
 Add spaces around operators
Thread-Topic: [Outreachy kernel] Re: [PATCH 2/2] staging: iio: adc: ad7280a:
 Add spaces around operators
Thread-Index: AQHV/N2ybpBps/EzlU+x4vN/65WR1qhN21wAgACaLgCAAAHwAIAAEgeAgAABOICAAAkcgIAA63EA////4QCAAAIeAIAAmGYAgAD7vIA=
Date:   Fri, 20 Mar 2020 07:13:47 +0000
Message-ID: <76805d0d1507c9f3c37adc93b8ad24315881d522.camel@analog.com>
References: <6703668c512dd665a2299a1f5bf14d99262314f8.1584505215.git.mh12gx2825@gmail.com>
         <20200318060038.GB1594471@kroah.com>
         <35afdc4b-bd59-7851-aa4f-3d8807668931@metafoo.de>
         <20200318151924.GB2862853@kroah.com> <20200318162353.GA23226@deeUbuntu>
         <alpine.DEB.2.21.2003181727440.2979@hadrien>
         <20200318170051.GA23498@deeUbuntu>
         <b471d6102a731d577fff9f2175d4e35217a45e18.camel@analog.com>
         <alpine.DEB.2.21.2003190802450.3010@hadrien>
         <f783d807e2e74ae492c83eb9827ac43767411808.camel@analog.com>
         <20200319161608.GA14738@deeUbuntu>
In-Reply-To: <20200319161608.GA14738@deeUbuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 428da85c-20e6-452b-e88b-08d7cc9e3b90
x-ms-traffictypediagnostic: DM6PR03MB3609:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB3609EE76EC4CA21E1F662C23F9F50@DM6PR03MB3609.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(366004)(199004)(76116006)(4326008)(2906002)(6486002)(5660300002)(71200400001)(54906003)(64756008)(66446008)(66476007)(6512007)(81156014)(66556008)(6506007)(53546011)(8936002)(81166006)(8676002)(7416002)(316002)(478600001)(66946007)(91956017)(6916009)(966005)(2616005)(36756003)(86362001)(26005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3609;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TMF5Qty7A0+okW5v4VpIFpW6MD6iDGAjOeQRLp8DoiKFf2YWKTmNXd64bYZdXTTh3Qkn7UBvVAkchqxBMWaJK5qOQFBKlFmM4y5D7mUfJB9gr2qW3jnJcphq+DaLxYsdKoZd625WjI7zROmibjqmIpr3mbP7Q8RuLcqKGSrw874J6Rgb+82a8ZQKXMrCkvWRv92RxvpUDET05eSVZS+LEDj/dQDN81pta8NRgFh/5nSrlc8YcZFoYnEkGCATiog5spTVHSf9H4LsS2+baUbJ9TSAiio1N2JV605bwcNlLYR4+mv+DO6rM5XD//ac8gWwDMQ53R9yBYwrcPhPiRMEz+yghZijyJjerkGW22HPIsNIIIE/765wdwchVxJzleQSqx/NvgXT3VwDrjsay5orwj59R5lZHxPlVP3CspQ1PioC4KCtKKV4WX8x0ggs34LNnIP7gd0NhuvqK/HdV/qGaM3pu5srFC65BVwt/w1vbgAk1xoeHIz/JITD6VWa9C0KA6jdcU/KlTkolTOoaiLhaQ==
x-ms-exchange-antispam-messagedata: 7SPIFMfGLbe7ruWO84ukPJPh7gV/2UQ+tysY4JfMMHEttXXlI97zj8GQ5nQzVHtb6nLZUYyb77wSI4TfCX5w5YbF3GI1giTWjyUgDziZ/ydhJyBXxV7WZ1N/+yKo4AnDAe097eIBJNDVpsSYAriHSw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2F416B8A31FA9478AC672A7947986D5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428da85c-20e6-452b-e88b-08d7cc9e3b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 07:13:47.1296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rSlCrZ0heT7FvCAOCpdqETQIjbx9BOK2z+oegZ4FKGLj7vZk+fC8Kq1fJokeba3gLXN+Nk3Buaznhx1Lt81p+de8WNVKt/9Ay4RlWDl8K3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3609
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_01:2020-03-19,2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 clxscore=1031 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200031
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTE5IGF0IDIxOjQ2ICswNTMwLCBERUVQQUsgVkFSTUEgd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFRodSwgTWFyIDE5LCAyMDIwIGF0IDA3OjA3OjIwQU0gKzAw
MDAsIEFyZGVsZWFuLCBBbGV4YW5kcnUgd3JvdGU6DQo+ID4gT24gVGh1LCAyMDIwLTAzLTE5IGF0
IDA4OjAzICswMTAwLCBKdWxpYSBMYXdhbGwgd3JvdGU6DQo+ID4gPiBbRXh0ZXJuYWxdDQo+ID4g
PiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBPbiBUaHUsIDE5IE1hciAyMDIwLCBBcmRlbGVhbiwg
QWxleGFuZHJ1IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IE9uIFdlZCwgMjAyMC0wMy0xOCBhdCAy
MjozMCArMDUzMCwgREVFUEFLIFZBUk1BIHdyb3RlOg0KPiA+ID4gPiA+IFtFeHRlcm5hbF0NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBPbiBXZWQsIE1hciAxOCwgMjAyMCBhdCAwNToyODoxN1BNICsw
MTAwLCBKdWxpYSBMYXdhbGwgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBXZWQsIDE4IE1hciAyMDIw
LCBERUVQQUsgVkFSTUEgd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gT24gV2Vk
LCBNYXIgMTgsIDIwMjAgYXQgMDQ6MTk6MjRQTSArMDEwMCwgR3JlZyBLSCB3cm90ZToNCj4gPiA+
ID4gPiA+ID4gPiBPbiBXZWQsIE1hciAxOCwgMjAyMCBhdCAwNDoxMjoyOFBNICswMTAwLCBMYXJz
LVBldGVyIENsYXVzZW4NCj4gPiA+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+
IE9uIDMvMTgvMjAgNzowMCBBTSwgR3JlZyBLSCB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
T24gV2VkLCBNYXIgMTgsIDIwMjAgYXQgMDk6NTg6MTNBTSArMDUzMCwgRGVlcGFrIFIgVmFybWEN
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQWRkIHNw
YWNlcyBhcm91bmQgb3BlcmF0b3Igc3ltYm9scyB0byBpbXByb3ZlIHJlYWRhYmlsaXR5Lg0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IFdhcm5pbmcNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBmbGFnZ2Vk
IGJ5IGNoZWNrcGF0Y2ggc2NyaXB0Lg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERlZXBhayBSIFZhcm1hIDxtaDEyZ3gyODI1QGdt
YWlsLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiAgIGRyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzI4MGEuYyB8IDQgKystLQ0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3MjgwYS5jDQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDcyODBhLmMNCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBpbmRleCAxOWE1ZjI0NGRjYWUuLjM0Y2EwZDA5ZGI4NSAxMDA2NDQNCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDcyODBhLmMN
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDcy
ODBhLmMNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBAQCAtODI1LDE0ICs4MjUsMTQgQEAgc3RhdGlj
IGlycXJldHVybl90DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYWQ3MjgwX2V2ZW50X2hhbmRsZXIo
aW50DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaXJxLCB2b2lkICpwcml2YXRlKQ0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ICAgfQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgc3RhdGljIElJT19ERVZJ
Q0VfQVRUUl9OQU1FRChpbl90aHJlc2hfbG93X3ZhbHVlLA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IC0JCQkgICAgIGluX3ZvbHRhZ2UtDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdm9sdGFnZV90aHJl
c2hfbG93X3ZhbHVlLA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsJCQkgICAgIGluX3ZvbHRhZ2Ug
LQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHZvbHRhZ2VfdGhyZXNoX2xvd192YWx1ZSwNCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiAgIAkJCSAgICAgMDY0NCwNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAg
IAkJCSAgICAgYWQ3MjgwX3JlYWRfY2hhbm5lbF9jb25maWcsDQo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gICAJCQkgICAgIGFkNzI4MF93cml0ZV9jaGFubmVsX2NvbmZpZw0KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ICwNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgIAkJCSAgICAgQUQ3MjgwQV9DRUxMX1VO
REVSVk9MVEFHRSk7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICBzdGF0aWMgSUlPX0RFVklDRV9B
VFRSX05BTUVEKGluX3RocmVzaF9oaWdoX3ZhbHVlLA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0J
CQkgICAgIGluX3ZvbHRhZ2UtDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdm9sdGFnZV90aHJlc2hf
aGlnaF92YWx1ZSwNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArCQkJICAgICBpbl92b2x0YWdlIC0N
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiB2b2x0YWdlX3RocmVzaF9oaWdoX3ZhbHVlLA0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ICAgCQkJICAgICAwNjQ0LA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAg
CQkJICAgICBhZDcyODBfcmVhZF9jaGFubmVsX2NvbmZpZywNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiAgIAkJCSAgICAgYWQ3MjgwX3dyaXRlX2NoYW5uZWxfY29uZmlnDQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gLA0KPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gRGlkIHlv
dSB0cnkgYnVpbGRpbmcgdGhpcyBjb2RlPw0KPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gPiA+ID4gSXQgY2F0Y2hlcyBldmVyeW9uZS4uLg0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+ID4gPiBUaGUgcHJvYmxlbSBpcyBpdCBidWlsZHMuIFRoZSB0b2tlbiBpcyBz
dHJpbmd5ZmllZCBhbmQNCj4gPiA+ID4gPiA+ID4gPiA+ICJpbl92b2x0YWdlIC0gdm9sdGFnZV90
aHJlc2hfaGlnaF92YWx1ZSIgaXMgYSB2YWxpZCBzdHJpbmcuDQo+ID4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+ID4gQWgsIEkgdGhvdWdodCBpdCB1c2VkIHRvIGJyZWFrIHRoZSBidWlsZCB3
aGVuIGl0IGhhcHBlbmVkLiAgT2gNCj4gPiA+ID4gPiA+ID4gPiB3ZWxsLA0KPiA+ID4gPiA+ID4g
PiA+IGl0J3Mgc3RpbGwgYSBncmVhdCAidHJpY2siIHRvIHNlZSBpZiBwZW9wbGUgdW5kZXJzdGFu
ZCBDIG9yIG5vdA0KPiA+ID4gPiA+ID4gPiA+IDopDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiA+IFllcywgaXQgZGlkIGJ1aWxkLiBJIGFtIHNvcnJ5IGJ1dCBJIGFtIG5vdCBmb2xsb3dp
bmcgeW91IGZ1bGx5Lg0KPiA+ID4gPiA+ID4gPiBDYW4NCj4gPiA+ID4gPiA+ID4geW91DQo+ID4g
PiA+ID4gPiA+IHBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGUgY2hhbmdlIEkgaW50cm9kdWNlZCBp
cyBub3QgZ29vZC4gWW91IG1heQ0KPiA+ID4gPiA+ID4gPiBwbGVhc2UgZGlyZWN0IG1lIHRvIGEg
ZG9jdW1lbnQgd2hlcmUgSSBjYW4gcmVhZCBtb3JlIGFib3V0IGl0Lg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBUaGUgY29kZSBpbnZvbHZlcyBhIG1hY3JvLCBhcyBpbmRpY2F0ZWQgYnkgdGhl
IGNhcGl0YWwgbGV0dGVycy4gIFlvdQ0KPiA+ID4gPiA+ID4gd2lsbA0KPiA+ID4gPiA+ID4gc2Vl
IHRoZSBpc3N1ZSB3aGVuIHlvdSBsb29rIGF0IHRoZSBkZWZpbml0aW9uIG9mIHRoZSBtYWNyby4N
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4ganVsaWENCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBU
aGFuayB5b3UgSnVsaWEgYW5kIGFsbC4gSSBnb3QgbXkgbWlzdGFrZS4gSSB3aWxsIHJldmVydCB0
aGUgY2hhbmdlLg0KPiA+ID4gPiA+IFNvcnJ5IGZvciB0aGUgdHJvdWJsZS4NCj4gPiA+ID4gDQo+
ID4gPiA+IEknbGwgdHJ5IHRvIG1ha2Ugc29tZSB0aW1lIHRvIGFkZHJlc3MgdGhpcyBzb21laG93
LCBzbyB0aGF0IGNoZWNrcGF0Y2gNCj4gPiA+ID4gZG9lc24ndA0KPiA+ID4gPiBidW1wIGludG8g
dGhpcy4NCj4gPiA+ID4gDQo+ID4gPiA+IEluIHRoZSBsYXN0IDItMyB5ZWFycywgSSB0aGluayBJ
IHNhdyAzLTQgcGF0Y2hlcyB0cnlpbmcgdG8gYWRkcmVzcyB0aGlzDQo+ID4gPiA+IFtmb3INCj4g
PiA+ID4gdmFyaW91cyBBbmFsb2cgZHJpdmVyc10uDQo+ID4gPiA+IFNvLCBkb24ndCBmZWVsIHRv
byBiYWQuDQo+ID4gPiANCj4gPiA+IE1heWJlIGEgY29tbWVudD8NCj4gPiANCj4gPiBDb21tZW50
IHdvcmtzIGZvciBub3cuDQo+ID4gQW55Ym9keSB3YW50cyB0byBkbyBhIHBhdGNoIGZvciB0aGF0
Pw0KPiA+IElmIG5vYm9keSBzZW5kcyBhIHBhdGNoIGZvciB0aGlzIGluIDEtMiB3ZWVrcywgSSds
bCBzZW5kIG9uZS4NCj4gPiANCj4gPiBQYXJ0aWN1bGFybHksIHRoaXMgd291bGQgaGVscCB3aXRo
IHJldmlldywgc2luY2UgcGVvcGxlIHRoYXQgYXJlIHVuZmFtaWxpYXINCj4gPiB3aXRoDQo+ID4g
SUlPLXNwZWNpZmljIG1hY3JvcyB3b3VsZCBhbHNvIGZpbmQgaXQgZWFzaWVyIGF0IHJldmlldy4N
Cj4gPiANCj4gPiBUaGUgZ29vZCBwYXJ0LCBpcyB0aGF0IGl0J3Mgb25seSBuZWVkZWQgZm9yIEFE
NzI4MEEuDQo+ID4gQUQ3MTkyIGhhcyBiZWVuIHJlLXdvcmtlZCwgYW5kIGlzIG5vIGxvbmdlciBv
biBjaGVja3BhdGNoJ3MgcmFkYXIuDQo+ID4gSSdtIHJld29ya2luZyBBRDc3OTMgbm93Lg0KPiA+
IA0KPiANCj4gSSB3aWxsIGJlIGhhcHB5IHRvIGFkZCBhIGNvbW1lbnQgYXJvdW5kIHRoZSBjb2Rl
IGFyZWEgdG8gaW5kaWNhdGUNCj4gaWdub3JlIGNoZWNrcGF0Y2ggd2FybmluZyBmb3IgdGhlIG1l
bnRpb25lZCBhcmd1bWVudC4gUGxlYXNlIGNvbmZpcm0gaWYNCj4gdGhhdCBpcyB3aGF0IHlvdSBh
cmUgZXhwZWN0aW5nIHRvIGJlIGRvbmUuDQoNClN1cmUuDQpQbGVhc2Ugc2VuZCBhIHBhdGNoLg0K
DQpUaGFua3MNCkFsZXgNCg0KPiANCj4gVGhhbmtzLA0KPiBEZWVwYWsuDQo+IA0KPiA+ID4ganVs
aWENCj4gPiA+IA0KPiA+ID4gPiA+IERlZXBhay4NCj4gPiA+ID4gPiA+ID4gVGhhbmtzLA0KPiA+
ID4gPiA+ID4gPiBEZWVwYWsuDQo+ID4gPiA+ID4gPiA+ID4gdGhhbmtzLA0KPiA+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiA+IGdyZWcgay1oDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiAtLQ0KPiA+ID4gPiA+ID4gPiBZb3UgcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGJlY2F1c2Ug
eW91IGFyZSBzdWJzY3JpYmVkIHRvIHRoZSBHb29nbGUNCj4gPiA+ID4gPiA+ID4gR3JvdXBzDQo+
ID4gPiA+ID4gPiA+ICJvdXRyZWFjaHkta2VybmVsIiBncm91cC4NCj4gPiA+ID4gPiA+ID4gVG8g
dW5zdWJzY3JpYmUgZnJvbSB0aGlzIGdyb3VwIGFuZCBzdG9wIHJlY2VpdmluZyBlbWFpbHMgZnJv
bSBpdCwNCj4gPiA+ID4gPiA+ID4gc2VuZA0KPiA+ID4gPiA+ID4gPiBhbg0KPiA+ID4gPiA+ID4g
PiBlbWFpbCB0byBvdXRyZWFjaHkta2VybmVsK3Vuc3Vic2NyaWJlQGdvb2dsZWdyb3Vwcy5jb20u
DQo+ID4gPiA+ID4gPiA+IFRvIHZpZXcgdGhpcyBkaXNjdXNzaW9uIG9uIHRoZSB3ZWIgdmlzaXQN
Cj4gPiA+ID4gPiA+ID4gaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9kL21zZ2lkL291dHJlYWNo
eS1rZXJuZWwvMjAyMDAzMTgxNjIzNTMuR0EyMzIyNiU0MGRlZVVidW50dQ0KPiA+ID4gPiA+ID4g
PiAuDQo+ID4gPiA+ID4gPiA+IA0K
