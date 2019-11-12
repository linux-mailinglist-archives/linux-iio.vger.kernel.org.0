Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91BF4F8F08
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2019 12:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfKLL5c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Nov 2019 06:57:32 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:6998 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbfKLL5c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Nov 2019 06:57:32 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xACBqrj3028336;
        Tue, 12 Nov 2019 06:56:54 -0500
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2053.outbound.protection.outlook.com [104.47.40.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w7pr6gkea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 06:56:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLTEZA4A65tofanCU63Ox3tEsswDCyLd9nRJ42a72OoSJEc3wJXhbekvWzd3DTq0k7vXZ1kS8TVpY+EnawVcSZ3WiWS+vdco83aG6RubgDeEA+sKzjhwU3u08FvwbhDixYMq5mW0QGVgdSi7lrZECYz6uTMyhgVpllbhctPVZG/mn1UnR4yfX9RSZDxVs1yAlcR5aXmlJPhp8iUgnZB4ONYS0yM87KynZT2DN3QAYFqXIpzgzpQMflxXQ5cCwCHLuAFV0awaBBqMp2ZgW/nNFpCkgIcTSQZFOG0mjyhA9gD/lkDykSs0LaYa128r8GVV9KtA77lmdE3tdfzIegveSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByZkVSi4IstnbMIQ0yZAYwgblfvEeedlnENDiCoHH/A=;
 b=GYCZ5talcxje/ls9z254rYdc77LN132YMLZXwt1TBfmIVRHTb0BNcnh6iLi+YdYxpdIvEk//plvFEyhP2I1K5ZJ5vzNPn4PmL0jbSX0V7z+tz4qXXf88KobdQglatlaWJy4sKFcHJDeMQ6t+SaSwy/82pTR7ZcAsrXl72iiE91QSq/Q5RCNgezNrLAnT0b2muWgRoVz62E98v6O+TaPFdoDREa/gQrIHr18/jZpruBEgBe25wToP4bQSGwulXkseT04M4JC2YyOCfxTgNDPKZ9zt30VUtkYzM7Ae9U7OWOJa4DCO0U4soTAPoGy6RE5JzgBwKkBG1USPq/WpiEe+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByZkVSi4IstnbMIQ0yZAYwgblfvEeedlnENDiCoHH/A=;
 b=K50V4wn/hXn/vmR6fj322XB2y5ZPr7CcYNQGtk2cuJW2yUsAF14+4J6Ofhs8+A08vvWGwjG6jOa3zckIwoPe/RwhH6bGmIVWN9xPIULXaeMCldmCqeAHTvaj9huoW7fLNXSjo7At2f5trm2fkDelb+NFLlQbMdzIB9ozn4IcLUw=
Received: from MN2PR03MB5200.namprd03.prod.outlook.com (10.186.146.8) by
 MN2PR03MB5056.namprd03.prod.outlook.com (10.255.232.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Tue, 12 Nov 2019 11:56:52 +0000
Received: from MN2PR03MB5200.namprd03.prod.outlook.com
 ([fe80::5aa:4121:999c:c8f0]) by MN2PR03MB5200.namprd03.prod.outlook.com
 ([fe80::5aa:4121:999c:c8f0%3]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:56:52 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 1/3] iio: adc: ltc2496: provide device tree binding
 document
Thread-Topic: [PATCH 1/3] iio: adc: ltc2496: provide device tree binding
 document
Thread-Index: AQHVmNs1F8/40KLd8kC0t9/fsa+nz6eHG4MAgAABhICAAFIKgA==
Date:   Tue, 12 Nov 2019 11:56:52 +0000
Message-ID: <1e1a148095d2ea6c49c62e5fb2e5e741faa9d5f4.camel@analog.com>
References: <20191111214025.18310-1-u.kleine-koenig@pengutronix.de>
         <b6ed43afbfb0128301f11198eb83a8f72b7661e9.camel@analog.com>
         <20191112070405.zinuqnfb3wqbehvw@pengutronix.de>
In-Reply-To: <20191112070405.zinuqnfb3wqbehvw@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60f25fb0-6ea2-43e8-6e38-08d76767687c
x-ms-traffictypediagnostic: MN2PR03MB5056:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB5056B2DB6878248327B16B3BF9770@MN2PR03MB5056.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(36756003)(66446008)(8676002)(54906003)(8936002)(316002)(2351001)(305945005)(229853002)(7736002)(6916009)(118296001)(81156014)(6486002)(256004)(81166006)(6436002)(5640700003)(25786009)(4744005)(5660300002)(64756008)(66556008)(4001150100001)(2616005)(102836004)(6506007)(476003)(486006)(6246003)(76176011)(11346002)(446003)(66476007)(186003)(71190400001)(6512007)(26005)(2906002)(14454004)(478600001)(76116006)(66946007)(3846002)(91956017)(2501003)(86362001)(66066001)(7416002)(71200400001)(99286004)(6116002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB5056;H:MN2PR03MB5200.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JcMh/RzcUQ+lzo2Tsaj55YgDs2Tht5OIThGBuhb8B0GPfJgFLSavhmrpwj3IrIazq9KnQ3kyO/6qgYIH5YnhvMPp+mXHD84NS6ZsC05q2NsnGO3PQ5b0x4jjkPWRxvTntrsaqCAd4Mf0ohfsSAUaYApyBI9CmqOASZcJqwsIu4F2H8J/sr30cGbbLqdzrPYmVQIAvgCyz8PQ6++jnmhESIKUZo0IXNESe/o1nazhQp8ymVkRBlgRSEe+kVWrI+XsHH9Fn/9z5rjJk3MQ9DyCgEWCKZ3/d/cjvO0uC7fSJcP+GIsdqEBY5DTBz4kTX++ntybn+rIB/hhMyk7QdztLyeouJSFZdAVl0L0lexK4oXZB8L6FOlypUuoa4rBubp+vCm2VaRMsXvrQW1oncdUjE2SeWwruE1+Nz1FQAJ0KynyyLZJkADdjlKDXltQ2g02k
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD8621DC3BBC374FBBE865EB3CAF82F4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f25fb0-6ea2-43e8-6e38-08d76767687c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 11:56:52.7456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXpu8k8OIi2zCCguQT3YSH/0Y/uKeBD2cZPfsj2zW9E9x144QpI7EhpMd7aRyUeJpacfqh13LohdbeGNpnRifi8cWyPVnVeGZK7Eny5trkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5056
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_03:2019-11-11,2019-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=769 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911120109
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTExLTEyIGF0IDA4OjA0ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gW0V4dGVybmFsXQ0KPiANCj4gSGVsbG8gQWxleGFuZHJ1LA0KPiANCj4gT24gVHVlLCBO
b3YgMTIsIDIwMTkgYXQgMDY6NTc6NDlBTSArMDAwMCwgQXJkZWxlYW4sIEFsZXhhbmRydSB3cm90
ZToNCj4gPiBPbiBNb24sIDIwMTktMTEtMTEgYXQgMjI6NDAgKzAxMDAsIFV3ZSBLbGVpbmUtS8O2
bmlnIHdyb3RlOg0KPiA+ID4gVGhlIEFEQyBvbmx5IHJlcXVpcmVzIHRoZSBzdGFuZGFyZCBzdHVm
ZiBmb3Igc3BpIGRldmljZXMgYW5kIGENCj4gPiA+IHJlZmVyZW5jZQ0KPiA+ID4gdm9sdGFnZS4N
Cj4gPiANCj4gPiBEVCBiaW5kaW5ncyBtdXN0IGJlIGluIFlBTUwgZm9ybWF0Lg0KPiANCj4gWWVh
aCwgSSBub3RpY2VkIHRoaXMgdHJlbmQuIEJ1dCBnaXZlbiB0aGF0IEkgb25seSBzYXcgLnR4dCBm
aWxlcyBmb3INCj4gaWlvLCBJIHRob3VnaHQgSSdkIHN0aWNrIHRvIHRoYXQuDQo+IA0KPiA+IEJ1
dCBpbiB0aGlzIGNhc2UsIHlvdSBjYW4gcHJvYmFibHkgZXh0ZW5kIHRoZSBleGlzdGluZw0KPiA+
ICJEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9sdGMyNDk3LnR4dCIu
DQo+IA0KPiBJIGNvbnNpZGVyZWQgdGhhdCBzaG9ydGx5LCBidXQgYXMgdGhlIGx0YzI0OTcgaXMg
YW4gaTJjIGRldmljZSBhbmQgdGhlDQo+IGx0YzI0OTYgdXNlcyBzcGkgSSBjaG9zZSB0byBjcmVh
dGUgYW5vdGhlciBzaW1wbGUgZG9jdW1lbnQgaW5zdGVhZCBvZg0KPiBjb21wbGljYXRpbmcgdGhl
IGV4aXN0aW5nIG9uZSBieSBkZXNjcmliaW5nIHR3byBuZWFybHkgb3J0aG9nb25hbCBzZXRzDQo+
IG9mIHByb3BlcnRpZXMuDQoNClRoZXJlIGFyZSBkdC1iaW5kaW5ncyB0aGF0IGNvdmVyIGJvdGgg
U1BJICYgSTJDLg0KSSB0aGluayBBRFhMMzcyIGRvZXMgdGhhdCB0b28uDQoNCg0KPiANCj4gQmVz
dCByZWdhcmRzDQo+IFV3ZQ0KPiANCg==
