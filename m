Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED3F150D50
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2019 16:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbfFXOJN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 10:09:13 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:43886 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731756AbfFXOJM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2019 10:09:12 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OE8ZFb004224;
        Mon, 24 Jun 2019 10:08:48 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2057.outbound.protection.outlook.com [104.47.49.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t9e63dupf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 10:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbtYM6TFQdOxKuLzKw5MOPPqicJtbW7agMipMrUmpEE=;
 b=Aw1qVF90vKKQBnGt21mkS05mR2Y4HUbMwTxOnlJx+RiaLXcNkMdraFmpxoLH9BuIH2JBeRijUsHLdfrMbiWaSpjMPmkfTfiOc2g17wSMTM+NzL9cyiR6xGwtgqjwO8dRBik7OqRdymW5QuuIjpBIImVJetTqvhCDaEeiH7MY2Ps=
Received: from DM6PR03MB3658.namprd03.prod.outlook.com (20.176.85.151) by
 DM6PR03MB4412.namprd03.prod.outlook.com (20.178.25.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 14:08:46 +0000
Received: from DM6PR03MB3658.namprd03.prod.outlook.com
 ([fe80::3d04:7ea3:14e6:de91]) by DM6PR03MB3658.namprd03.prod.outlook.com
 ([fe80::3d04:7ea3:14e6:de91%7]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 14:08:46 +0000
From:   "Caprioru, Mircea" <Mircea.Caprioru@analog.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 4/5] dt-bindings: iio: adc: Convert ad7124
 documentation to YAML
Thread-Topic: [PATCH V3 4/5] dt-bindings: iio: adc: Convert ad7124
 documentation to YAML
Thread-Index: AQHVKmQnaX7c8Zkm3k6sgnGGJOqaBKaq0qgAgAAFKwA=
Date:   Mon, 24 Jun 2019 14:08:46 +0000
Message-ID: <6d9ae527d98c77812d5d261419db3e1ddd5e0e2e.camel@analog.com>
References: <20190624080845.18537-1-mircea.caprioru@analog.com>
         <20190624080845.18537-4-mircea.caprioru@analog.com>
         <CAL_JsqJY_bO7EQa=Sfqs8Prwj483Q8Xs0+eX+HZyGsyr-4p-oQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJY_bO7EQa=Sfqs8Prwj483Q8Xs0+eX+HZyGsyr-4p-oQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b438869-c3c2-42a6-3a6c-08d6f8ad794e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR03MB4412;
x-ms-traffictypediagnostic: DM6PR03MB4412:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-microsoft-antispam-prvs: <DM6PR03MB4412648EA90994299E985C1581E00@DM6PR03MB4412.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(366004)(39860400002)(54534003)(199004)(189003)(2616005)(68736007)(8936002)(2906002)(316002)(186003)(4326008)(81156014)(81166006)(3846002)(86362001)(8676002)(54906003)(66066001)(102836004)(53546011)(6506007)(26005)(229853002)(76176011)(6116002)(99286004)(53936002)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(73956011)(91956017)(6436002)(25786009)(6486002)(118296001)(6512007)(71190400001)(71200400001)(486006)(6246003)(5660300002)(14454004)(305945005)(478600001)(446003)(72206003)(256004)(11346002)(476003)(7736002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4412;H:DM6PR03MB3658.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EIuw3d45G2dYf1vgG8YcAa+RlsJgnpv64iEGHIub1r/jy93mM2Pb1hxPCIqYzU2qGd/KJ9XgBdTBge4a7EpPFULoCG6pTSC8wz81O4J9vAiv/uew7wBHb8M5+VWf7JQixp7GYUB1RiYwCs6oHxRBhpo6pAbDkkVYhI6qSwdzCoYvnXKLags2Ed1B5y3+fn/4aaicLyixnBYSSanraiHfC5VRv8JL9HjNTBpMtnkrRfa9nQMqKj3IHodAa4ZIeb5JO0VCe5WBC35+/vFiZp7SmTLXASQXatTnfqRpLx8NkvpRT2TvvX6xJUjwKJbiklOg0+DhSQvb04YojYONLZHFw3vb9BKeu1PbUKSTtSi3+Pz6U5GvubAzVVoPLZu9E7IwTEhZbCM+sTjxidHESXSpjbTsca+yMbu1KOtU2doH5hg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9548103C6EA45F488CC1EB5B5F0929A9@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b438869-c3c2-42a6-3a6c-08d6f8ad794e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 14:08:46.5945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mircea.Caprioru@analog.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4412
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA2LTI0IGF0IDA3OjUwIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
W0V4dGVybmFsXQ0KPiANCj4gDQo+IE9uIE1vbiwgSnVuIDI0LCAyMDE5IGF0IDI6MDkgQU0gTWly
Y2VhIENhcHJpb3J1DQo+IDxtaXJjZWEuY2FwcmlvcnVAYW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4g
DQo+ID4gQ29udmVydCBBRDcxMjQgYmluZGluZ3MgZG9jdW1lbnRhdGlvbiB0byBZQU1MIGZvcm1h
dC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaXJjZWEgQ2FwcmlvcnUgPG1pcmNlYS5jYXBy
aW9ydUBhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5nZWxvZyB2MjoNCj4gPiAt
IG1vZGlmaWVkIFNQRFggbGljZW5zZSB0byBHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZQ0KPiA+IC0g
YWRkZWQgcmVnZXggZm9yIGEgcmFuZ2UgZnJvbSAwIHRvIDE1DQo+ID4gLSBhZGRlZCBtaW5pbXVt
IGFuZCBtYXhpbXVtIGNvbnN0cmFpbnRzIGZvciByZWcgcHJvcGVydHkNCj4gPiAtIHNldCB0eXBl
IGFuZCByYW5nZSBvZiB2YWx1ZXMgZm9yIGFkaSxyZWZlcmVuY2Utc2VsZWN0IHByb3BlcnR5DQo+
ID4gLSB1c2VkIGl0ZW1zIGZvciBkaWZmLWNoYW5uZWxzIHByb3BlcnR5DQo+ID4gLSBzZXQgYmlw
b2xhciwgYWRpLGJ1ZmZlcmVkLXBvc2l0aXZlIGFuZCBuZWdhdGl2ZSB0byB0eXBlOiBib29sZWFu
DQo+ID4gDQo+ID4gQ2hhbmdlbG9nIHYzOg0KPiA+IC0gbW92ZWQgYWRpLGJ1ZmZlcmVkLXBvc2l0
aXZlIGFuZCBuZWdhdGl2ZSBwcm9wZXJ0aWVzIHRvIG93biBjb21taXQNCj4gPiANCj4gPiAgLi4u
L2JpbmRpbmdzL2lpby9hZGMvYWRpLGFkNzEyNC55YW1sICAgICAgICAgIHwgMTQ0DQo+ID4gKysr
KysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNDQgaW5zZXJ0aW9ucygrKQ0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaWlvL2FkYy9hZGksYWQ3MTI0LnlhbWwNCj4gDQo+IFRoZSBzdWJqZWN0IHNheXMgJ0Nv
bnZlcnQnLCBidXQgd2hlcmUncyB0aGUgcmVtb3ZhbCBvZiB0aGUgb2xkDQo+IGJpbmRpbmc/DQo+
IA0KPiBSb2INCg0KWW91IGFyZSByaWdodCBJIHdhcyBub3Qgc3VyZSBpZiBJIHNob3VsZCBhbHNv
IHJlbW92ZSB0aGUgb2xkIGJpbmRpbmcuDQpJJ2xsIGRvIGEgdjQgdG8gZGVsZXRlIGl0IGluIHRo
aXMgcGF0Y2guDQoNClRoYW5rcywNCk1pcmNlYQ0K
