Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877141947C3
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 20:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgCZTpr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 15:45:47 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:47058 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbgCZTpq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 15:45:46 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QJYwHT017831;
        Thu, 26 Mar 2020 15:45:42 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2054.outbound.protection.outlook.com [104.47.45.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywfj7078h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 15:45:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejS/SJuKLxLC25ewernaSSgrziFazF+mw5cIYkrxvE/55KZvMA5VqXo0k++x9dRq1Bu7cA1Y913uxs5pFJzhY3Y1ZDnaDlZLTeL+/K2c9nbGi1t1ocRJMvNt1TvFGRpotNOKX2DmJvmHZsxKuWjO8/1edi/xndIjpo530P+xWx8ZA0Ba7GMYYLKNJB3pxYjb/o5ybd275sIekx9GsjW2zDurdEA70XJz7KXHTEGJlA78Ha9OW+pytoyAOP7bcB8pauhKd+4MYowGU+D7dUb5I9TLOaVNroSciZcGOKLfxrHspXMgeXBrtRwIbqIA01hB32CXuCHWfsoMmc6lak35yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YerV7I3/3mc4xbkXspC2GQJzEh9o9FBzljpVCgJ5oo=;
 b=Tdomxb6cW8nq1BaEKmNtHUXyBoLpqS/wkdc1igIQ42eotksxqBO42SJpNmIaSudcBMJ7bJNzfmG7C3k7rI5eHaq8hCpXE8yCkX2HKQ+JXWZSTS4QflsPYJtIEeI/6T/wTkLWb5tTpZoQ0hNp/0vXm79AZwXbUslxeSLnGOTPDNW7X6wgo+sK10DbCP7u/ug+OLdl1KJ6IiMiaNePzLCKlAzNTfcgvGfk63rXUFynI3Z1gxTDLYO+ewCU/Y+7SK2Lg6kBTTJs9CI/mn6oDrvFTVPMpfBRcKG/c6mzDd+rpYdzzIGTXwCx/wDwSxMZ+jz5cjym9092br/0di8C7F0wIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YerV7I3/3mc4xbkXspC2GQJzEh9o9FBzljpVCgJ5oo=;
 b=hi0Cw4dfBcj2i2Gpfo19VC10RtF3u6QhL2tP8R0RzZxAj8vahrezDnSsFvialW25QGMBmVsnIjzsryr3p71Ss6YkCHpNZ96C5tCa2qlW3EX5fzXspcRzvchAQwhP4ttxBFPzxX9Oh/2lPpN3RzSf6eFFQxZ/EJ3MqbQNscdX+7c=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4649.namprd03.prod.outlook.com (2603:10b6:5:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 26 Mar
 2020 19:45:40 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 19:45:40 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Grozav, Andrei" <Andrei.Grozav@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Nagy, Laszlo" <Laszlo.Nagy@analog.com>,
        "Csomortani, Istvan" <Istvan.Csomortani@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Costina, Adrian" <Adrian.Costina@analog.com>
Subject: Re: [PATCH v13 8/8] dt-bindings: iio: adc: add bindings doc for
 AD9467 ADC
Thread-Topic: [PATCH v13 8/8] dt-bindings: iio: adc: add bindings doc for
 AD9467 ADC
Thread-Index: AQHWAeLaFJHA9/JyBEWQMKe2keio2KhbPK4AgAANywA=
Date:   Thu, 26 Mar 2020 19:45:39 +0000
Message-ID: <17a99874285734496a97d271dda7368b40e88255.camel@analog.com>
References: <20200324134636.64643-1-alexandru.ardelean@analog.com>
         <20200324134636.64643-9-alexandru.ardelean@analog.com>
         <20200326185616.GA2673@bogus>
In-Reply-To: <20200326185616.GA2673@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91392951-fa6d-4473-73db-08d7d1be4365
x-ms-traffictypediagnostic: DM6PR03MB4649:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB46499EBBF897097904C6D6F4F9CF0@DM6PR03MB4649.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(366004)(346002)(39860400002)(4744005)(26005)(186003)(316002)(2906002)(54906003)(86362001)(66446008)(66476007)(66946007)(66556008)(64756008)(4326008)(5660300002)(2616005)(107886003)(76116006)(91956017)(71200400001)(8936002)(81166006)(81156014)(8676002)(6512007)(478600001)(6916009)(36756003)(6486002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4649;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 65Zqkc4T+n6Fxqk3wPjkjpyGkFC+TtBsFjRbVF8s6CvyL/f1Wdz7/nwj95ZOjyvMd6NDX5OtHK2i0zCBHbJCo28PAsak7bcUoc2U9GJsJc4suC43DIqvAxwtgl+c8h1GHx72q9B77VhZQLkTfndMaAP8grf8UxpMoc5MYuyhhd4aHcU628Q7b+fGv2kgfbGyg/eSgIXF4WjtziJMNW+AGhxpG3y0uy+4knlgeaIvoL3o0xaNUqAepa1ZPtWiMeW5EGTkzXN63Uqflfy/GvpEcWc60zeSCGGr+JvQBN2xxHTC/0o3TPv3arcIsdP3wdCFyWavj/OHgVHlyzpKGe0Q8S31i3VriwCHspBLCGeh9tmVdFcjU317l5qjHeZyXCazpxlZPB+RD3U/bH5QVdJr30o0CpHxrO8PpBKv8pGqJeJXyTN90LcCk/jQQyo66nrH
x-ms-exchange-antispam-messagedata: yY0KgGqxHwRma+Rauc7NDKYHk6zicj3rCoodF9eL6xRnXXhOalUU5sEbPWRLy/r7xT0MAW3J5S/9Rdv8lKBg93nxlP5sgO2AxX7tD20ZsxOtgD6QfNAhu6S+9mPlnaZo6AuXUjNvNli9CrhrOK3IcA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FAEDEEFC37F98468B2C2222A2AAD212@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91392951-fa6d-4473-73db-08d7d1be4365
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 19:45:39.9359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxuYDeulebb12+I2aXCjC1ghVGdua6K0XaI9xtT5hLigLi5DwXjGZe0CCnH+c539UgwJiqhApRR8AMHKrw3TOf+WJK1JA+I7Mri7+HSfVTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4649
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_12:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260144
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTI2IGF0IDEyOjU2IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCAyNCBNYXIgMjAyMCAxNTo0NjozNiArMDIwMCwgQWxleGFuZHJ1IEFyZGVsZWFuIHdy
b3RlOg0KPiA+IFRoaXMgY2hhbmdlIGFkZHMgdGhlIGJpbmRpbmcgZG9jIGZvciB0aGUgQUQ5NDY3
IEFEQy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhh
bmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvaWlv
L2FkYy9hZGksYWQ5NDY3LnlhbWwgICAgICAgICAgfCA2NSArKysrKysrKysrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxh
ZDk0NjcueWFtbA0KPiA+IA0KPiANCj4gUGxlYXNlIGFkZCBBY2tlZC1ieS9SZXZpZXdlZC1ieSB0
YWdzIHdoZW4gcG9zdGluZyBuZXcgdmVyc2lvbnMuIEhvd2V2ZXIsDQo+IHRoZXJlJ3Mgbm8gbmVl
ZCB0byByZXBvc3QgcGF0Y2hlcyAqb25seSogdG8gYWRkIHRoZSB0YWdzLiBUaGUgdXBzdHJlYW0N
Cj4gbWFpbnRhaW5lciB3aWxsIGRvIHRoYXQgZm9yIGFja3MgcmVjZWl2ZWQgb24gdGhlIHZlcnNp
b24gdGhleSBhcHBseS4NCj4gDQo+IElmIGEgdGFnIHdhcyBub3QgYWRkZWQgb24gcHVycG9zZSwg
cGxlYXNlIHN0YXRlIHdoeSBhbmQgd2hhdCBjaGFuZ2VkLg0KDQpNeSBiYWQuIEFwb2xvZ2llcyBm
b3IgdGhhdC4NCk5vIGlkZWEgaG93IEkgbWlzc2VkIGFkZGluZyB0aGlzLiBFc3BlY2lhbGx5IHNp
bmNlIEkgYWxyZWFkeSBrbm93IHRoYXQgSSBzaG91bGQNCmFkZCBpdC4NCg0KSSBndWVzcyBJIGdv
dCBtaXhlZCB1cCB3aXRoIHRvbyBtYW55IGJyYW5jaGVzIGFuZCBub3QgcGF5aW5nIGF0dGVudGlv
bi4NCg==
