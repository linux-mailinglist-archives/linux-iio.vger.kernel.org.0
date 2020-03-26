Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAC8193A9D
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 09:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgCZIQk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 04:16:40 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:34426 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727821AbgCZIQO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 04:16:14 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02Q8FrA5001665;
        Thu, 26 Mar 2020 04:15:53 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywfj6xf7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 04:15:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRQazNph1NMe8fsb0j2UPI5pM4CuMUFC27/MmeQm65mJ2LbODZxb4k9wZXp3fYHke71NhcXl/xIrgi0snHQBEjUD9RvxQdqdVqfhukNVDIEzeYuEKcxRQ2wl6djh4QASDIhKKlS2GN1fXzwtLjNM7F/28N1gGhYYcEW55BfWAQTbopJ25YG2RBvPE5VwfN1+9e8INDuB9T0Zjch7yQq+x705Jczx2bmOLGvhvCyFm6WTFePkkuPXwzK44dCJhwD8DFn7jgs/4u2d+e87HxorXlj5HqlgMFOIeo93hG1F8S5GutH03pPAF07wru+Txc1QVuKxxtz1lvlODemRBiZ2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqXuHKNaKywsCVymko6abRCZ3/b3hfz89WGzZryma1o=;
 b=Wy3Rz2wJpgNnKMw1V0Y+4X9gVXn5HwgiGZ7y8klNg5pamgLGYBa4dKqZZyrRr7amkNG7NhP4wSSXe28xz17K+aTMdxixLVfigbVL7mOHTLtcIN4eraSor1mTw0wvgAJDUF99iDficoUv+zIFJ0QNRd50hCpDr1Xdxgs4eKJNU+ARl3PtohFEs3H5rXiVOPWA2sY/38BTrWY8BDNXT3hVRmI3LScOgjmDqm4GVn+2yCxOSucZ7GLkUkPqBt2xdz619t03ruFw/yrpekxuf5B5kqDAUO3GCjcAYBS0j0L6MJeBSvsirnj1wHGPqspFx493D3nXdNALY1TAoEFjDfQQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqXuHKNaKywsCVymko6abRCZ3/b3hfz89WGzZryma1o=;
 b=4mS1nFtyTUnm/hVvEbBdEjPh6lE60L7qWmwJ+LqIn3s+7CUpaeUznK/QWDvzrCi4igbEDkg8bJXk3tSDtakYqFeV/bRfRNVMuHWvNosJXZmtMoNHBJw4fXA6u76hjHICNBKpubmPLfJWnj3ptHzsJ5CLwUt2sVbvoGNzvANTvto=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4201.namprd03.prod.outlook.com (2603:10b6:5:56::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 08:15:50 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 08:15:50 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "mh12gx2825@gmail.com" <mh12gx2825@gmail.com>
CC:     "sbrivio@redhat.com" <sbrivio@redhat.com>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [Outreachy kernel] Re: [PATCH v3 3/4] staging: iio: adc: ad7192:
 get_filter_freq code optimization
Thread-Topic: [Outreachy kernel] Re: [PATCH v3 3/4] staging: iio: adc: ad7192:
 get_filter_freq code optimization
Thread-Index: AQHWAIP7bG2z5cfkz02QNYgY4udV/ahVRpUAgAASO4CAAJEWAIAALpCAgABeHwCAAO6mgIACMhKAgAD2KgA=
Date:   Thu, 26 Mar 2020 08:15:50 +0000
Message-ID: <f6e7ccbf497bc1d5570c331b0af5b49c07f74222.camel@analog.com>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
         <dad3cdb5de76234cc460300c31aea6af671f81ad.1584904896.git.mh12gx2825@gmail.com>
         <CAHp75VfC=y1mHW5=ghwdMMZYg=00_a5RB0Phz4j_vM77pehvMA@mail.gmail.com>
         <20200323014935.48048405@elisabeth>
         <CAHp75VfF+oDWsOF+_=U6YBeP60XLF=SLYzExa=5WjLSgoMUw9A@mail.gmail.com>
         <20200323131531.1d6c8f93@elisabeth> <20200323175223.GC22110@deeUbuntu>
         <4385dc0509f035bbd14d85b81527997f7a2538e8.camel@analog.com>
         <20200325173815.GA28246@deeUbuntu>
In-Reply-To: <20200325173815.GA28246@deeUbuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ccdc25b2-bece-4f9d-39f1-08d7d15de586
x-ms-traffictypediagnostic: DM6PR03MB4201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB420155534805BE9DE75EB3D9F9CF0@DM6PR03MB4201.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(478600001)(54906003)(7416002)(86362001)(6916009)(36756003)(8936002)(5660300002)(4326008)(6506007)(71200400001)(2616005)(6512007)(81156014)(8676002)(81166006)(53546011)(186003)(316002)(2906002)(66556008)(26005)(66946007)(64756008)(66476007)(66446008)(6486002)(91956017)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4201;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3INbpsgtQp9S1uX0BVpDTon7sULfZOzLgGR1rSBzu89F5KJAp0Lld0untSRxFFhFDDOfAJCUYsvgh/IieHk7nUsea5ASr0QK8F9JBjlEFG7wvtX+I7ar/NpOYfIWEL4zSyrWCQysViv4zDUVz/+CE2j30tbUHLrdVy9JO9kKwTx1EJNAEAMku7P7xuzBB3YdpiWML3e7dlwlSwXAUrxQ8gbpXS65IiBwACKCH00dDIgSOVkrLNvlUzUELR/nnFQS3SE1KolcBgsS8FMbXhxc04Fh1ouIvHBy8Iez0Bb8bM5WIEexDtPw+kY/nzJ52KqayQCP3kqBlf/q8LwrPMxNHMESpugyPn672a+856BNuWtaPLYlsthS9TYpTiQBpwmWH/J+4gbh2MOFVRsRZ7rNrVcf/rGs4BRCrl0mKWxvmE3wjNy/clIv1ECy8nDz7PBA
x-ms-exchange-antispam-messagedata: DYF1u3N+5IlaAaxzSBd4DCraRsafkHvXSMIrB24B3dvCnTGyH1ybTTsVaMGrCf2vjlCoosdy5XK3w1Zo8DG6SJD/5BWsfX9viY/JDvAOUEyV3SNlNr/5cseXJffUo9riahv2nkn1rttufJZ4yzLVGg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B9C4369BF45ED4280666242CC916895@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdc25b2-bece-4f9d-39f1-08d7d15de586
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 08:15:50.8387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5m2NYS7MbY8SML9vCRRgHPNZvNOeuuJaHKXhjmagnCF+4ZBgud6+fUhShRpAFJtMd+1SEBE0780kJSNhulssvZT4lcuwK/ekw3f/sq8Ff/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4201
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_15:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1031 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260059
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTI1IGF0IDIzOjA4ICswNTMwLCBERUVQQUsgVkFSTUEgd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFR1ZSwgTWFyIDI0LCAyMDIwIGF0IDA4OjA2OjM0QU0gKzAw
MDAsIEFyZGVsZWFuLCBBbGV4YW5kcnUgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDIwLTAzLTIzIGF0
IDIzOjIyICswNTMwLCBERUVQQUsgVkFSTUEgd3JvdGU6DQo+ID4gPiBbRXh0ZXJuYWxdDQo+ID4g
PiANCj4gPiA+IE9uIE1vbiwgTWFyIDIzLCAyMDIwIGF0IDAxOjE1OjMxUE0gKzAxMDAsIFN0ZWZh
bm8gQnJpdmlvIHdyb3RlOg0KPiA+ID4gPiBPbiBNb24sIDIzIE1hciAyMDIwIDExOjI4OjUyICsw
MjAwDQo+ID4gPiA+IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4g
d3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIE1vbiwgTWFyIDIzLCAyMDIwIGF0IDI6NDkg
QU0gU3RlZmFubyBCcml2aW8gPHNicml2aW9AcmVkaGF0LmNvbT4NCj4gPiA+ID4gPiB3cm90ZToN
Cj4gPiA+ID4gPiA+IE9uIE1vbiwgMjMgTWFyIDIwMjAgMDE6NDQ6MjAgKzAyMDANCj4gPiA+ID4g
PiA+IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4gd3JvdGU6ICAN
Cj4gPiA+ID4gPiA+ID4gT24gU3VuLCBNYXIgMjIsIDIwMjAgYXQgOTo1NyBQTSBEZWVwYWsgUiBW
YXJtYSA8DQo+ID4gPiA+ID4gPiA+IG1oMTJneDI4MjVAZ21haWwuY29tPg0KPiA+ID4gPiA+ID4g
PiB3cm90ZTogIA0KPiA+ID4gPiA+ID4gPiA+IEN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgdGhl
IGZ1bmN0aW9uDQo+ID4gPiA+ID4gPiA+ID4gYWQ3MTkyX2dldF9hdmFpbGFibGVfZmlsdGVyX2Zy
ZXENCj4gPiA+ID4gPiA+ID4gPiByZXBlYXRzIGNhbGN1bGF0aW9uIG9mIG91dHB1dCBkYXRhIHJh
dGUgYSBmZXcgdGltZXMuIFdlIGNhbg0KPiA+ID4gPiA+ID4gPiA+IHNpbXBsaWZ5DQo+ID4gPiA+
ID4gPiA+ID4gdGhlc2Ugc3RlcHMgYnkgcmVmYWN0b3Jpbmcgb3V0IHRoZSBjYWxjdWxhdGlvbiBv
ZiBmQURDLiBUaGlzDQo+ID4gPiA+ID4gPiA+ID4gd291bGQNCj4gPiA+ID4gPiA+ID4gPiBhbHNv
DQo+ID4gPiA+ID4gPiA+ID4gYWRkcmVzc2VzIHRoZSBjaGVja3BhdGNoIHdhcm5pbmcgb2YgbGlu
ZSBleGNlZWRpbmcgODANCj4gPiA+ID4gPiA+ID4gPiBjaGFyYWN0ZXIuICANCj4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+IEknbSBub3Qgc3VyZSB5b3UgZGlkIGFuIGVxdWl2YWxlbnQgY2hh
bmdlcy4gSSBiZWxpZXZlIGluIHRoZQ0KPiA+ID4gPiA+ID4gPiBvcmlnaW5hbA0KPiA+ID4gPiA+
ID4gPiBjb2RlIHByZWNpc2lvbiBpcyBiZXR0ZXIuIENvbnNpZGVyIGxvdyBjbG9jayBmcmVxdWVu
Y2llcyB3aGVuIDEwDQo+ID4gPiA+ID4gPiA+IGJpdA0KPiA+ID4gPiA+ID4gPiByaWdodCBzaGlm
dCBtYXkgaGlkZSBzb21lIGJpdHMgb2YgdGhlIGRpdmlzaW9uLiAgDQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IE5vdGUgdGhhdCB0aG9zZSBiaXRzIGFyZSBldmVudHVhbGx5ICJoaWRkZW4iIGlu
IHRoZSBzYW1lIHdheQ0KPiA+ID4gPiA+ID4gbGF0ZXIsICANCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBFdmVuIGlmIG1hdGhlbWF0aWNhbGx5IChhcml0aG1ldGljYWxseSkgZXZhbHVhdGlvbiBpcyBj
b3JyZWN0LCB3ZSBoYXZlDQo+ID4gPiA+ID4gdG8gcmVtZW1iZXIgdGhhdCBjb21wdXRlcnMgYXJl
IGJhZCB3aXRoIGZsb2F0aW5nIHBvaW50IGFuZCBlc3BlY2lhbGx5DQo+ID4gPiA+ID4ga2VybmVs
LCB3aGljaCB1c2VzIGludGVnZXIgYXJpdGhtZXRpYy4gVGhhdCBzYWlkLCBpdCdzIGVhc3kgdG8g
Z2V0DQo+ID4gPiA+ID4gb2ZmLWJ5LW9uZSBlcnJvciAoZHVlIHRvIHByZWNpc2lvbiBsb3N0KSBp
ZiB3ZSBkbyBiaWcgZGl2aXNpb24gYmVmb3JlDQo+ID4gPiA+ID4gKG5vdCBzbyBiaWcpIG11bHRp
cGxpY2F0aW9uLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhhdCdzIGV4YWN0bHkgdGhlIHBvaW50IEkg
d2FzIHRyeWluZyB0byBleHBsYWluIGJlbG93OiBzd2FwcGluZyBzdGVwcw0KPiA+ID4gPiBpbiBh
IHNlcXVlbmNlIG9mIERJVl9ST1VORF9DTE9TRVNUKCkgKCpub3QqIG9mIGFyaXRobWV0aWMgZGl2
aXNpb25zKSwNCj4gPiA+ID4gKnNob3VsZCogbm90IGFmZmVjdCBxdWFudGlzYXRpb24gKCJvZmYt
Ynktb25lIikgZXJyb3IuDQo+ID4gPiA+IA0KPiA+ID4gPiBJJ20gbm90IGVudGlyZWx5IHN1cmUg
aW4gdGhpcyBjYXNlLCBzbyBhIHF1aWNrICJkZW1vbnN0cmF0aW9uIiBpbg0KPiA+ID4gPiBQeXRo
b24gb3Igc3VjaGxpa2UgYXMgeW91IHN1Z2dlc3RlZCB3b3VsZCBiZSBuaWNlIHRvIGhhdmUsIGlu
ZGVlZC4NCj4gPiA+ID4gDQo+ID4gPiA+ID4gPiBkZXNwaXRlIHRoZSBkaWZmZXJlbnQgc2VxdWVu
Y2UsIGR1ZSB0byBESVZfUk9VTkRfQ0xPU0VTVCgpIGJlaW5nDQo+ID4gPiA+ID4gPiB1c2VkDQo+
ID4gPiA+ID4gPiBhdCBldmVyeSBzdGVwIChib3RoIGJlZm9yZSBhbmQgYWZ0ZXIgdGhlIGNoYW5n
ZSkgd2l0aG91dCBvdGhlcg0KPiA+ID4gPiA+ID4gb3BlcmF0aW9ucyBvY2N1cnJpbmcuICANCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBCeSB0aGUgd2F5LCB3aGVyZSBBRDcxOTJfU0lOQzNfRklMVEVS
IGFuZCBBRDcxOTJfU0lOQzRfRklMVEVSDQo+ID4gPiA+ID4gbXVsdGlwbGljYXRpb25zIGRpc2Fw
cGVhciBhbmQgd2h5Pw0KPiA+ID4gPiANCj4gPiA+ID4gVGhvc2Ugd2VyZSBpbiBmYWN0IGRpdmlz
aW9ucyAobXVsdGlwbGljYXRpb25zIG9mIHRoZSBkaXZpc29yKS4gT3ZlcmFsbCwNCj4gPiA+ID4g
dGhlc2Ugc3RlcHMgYXJlIG5vdyBhcnJhbmdlZCBpbiBhIHdheSBjbG9zZXIgdG8gaG93IHRoZXkg
YXJlIHByZXNlbnRlZA0KPiA+ID4gPiBpbiB0aGUgZGF0YXNoZWV0IG1lbnRpb25lZCBoZXJlICh1
cCB0byAiQ2hvcCBFbmFibGVkIiBwYXJhZ3JhcGgsIHBhZ2UNCj4gPiA+ID4gMjYpLg0KPiA+ID4g
PiANCj4gPiA+IA0KPiA+ID4gVGhhbmsgeW91IEFuZHkgYW5kIFN0ZWZhbm8gZm9yIHlvdXIgY29t
bWVudHMuIEl0cyB2ZXJ5IHRob3VnaHRmdWwuIEkgYW0NCj4gPiA+IG5vdCBtdWNoIGZhbWlsaWFy
IHdpdGggUHl0aG9uIHNvIGZhciwgYnV0IHRoaW5raW5nIG9uIGV2YWx1YXRpbmcgeW91cg0KPiA+
ID4gc3VnZ2VzdGlvbiBpbiBhIHNhbXBsZSBjIHByb2dyYW0uIEkgd2lsbCBzaGFyZSB0aGUgb3V0
Y29tZSBzaG9ydGx5Lg0KPiA+IA0KPiA+ICthZGRpbmcgTWlyY2VhIENhcHJpb3J1DQo+ID4gDQo+
ID4gVW1tLCB0aGlzIG1hdGgtY2xlYW51cCBsb29rcyBwcmV0dHkgZGFuZ2Vyb3VzLg0KPiA+IElm
IHBvc3NpYmxlLCBJIHdvdWxkbid0IGNoYW5nZSBpdC4NCj4gPiBBdCBsZWFzdCB3aXRob3V0IHNv
bWUgdGVzdGluZyBvbiBIVy4NCj4gPiANCj4gPiBNYXliZSBkb2luZyBtYXRoLXNpbXVsYXRpb25z
IGluIFB5dGhvbiBzY3JpcHRzIHdvdWxkIGFsc28gd29yaywgYnV0IG5vdA0KPiA+IHN1cmUuDQo+
ID4gDQo+IA0KPiBIZWxsbyBBbGwsDQo+IEkgZnVydGhlciByZXZpZXdlZCBjdXJyZW50IGFuZCBw
cm9wb3NlZCBpbXBsZW1lbnRhdGlvbiBvZiB0aGUNCj4gZ2V0X2ZpbHRlcl9mcmVxKCkgZnVuY3Rp
b25bVGhhbmsgeW91IFN0ZWZhbm8gZm9yIHlvdXIgdGltZV0uIFdlIHJlYWxpc2VkIHRoYXQNCj4g
SQ0KPiB3YXMgd3JvbmcgaW4gc3dhcHBpbmcgRElWX1JPVU5EX0NMT1NFU1QgY2FsbHMgd2l0aCBt
aXhpbmcNCj4gbXVsdGlwbGljYXRpb24gaW4gaXQuIEl0IGlzIGluZGVlZCBpbmNvcnJlY3QgdG8g
bWl4IG11bHRpcGxpY2F0aW9uIGlmIHdlDQo+IHdhbnQgdG8gcmVvcmRlciB0aGUgY2FsbHMuIENv
bXBhcmlzb24gb2YgdGhlIHJlc3VsdHMgZnJvbSBjdXJyZW50IGFuZA0KPiBwcm9wb3NlZCBpbXBs
ZW1lbnRhdGlvbiBwcm92ZWQgaXQuIEluIHNob3J0LCB0aGUgcGF0Y2ggSSBzZW50IGlzIHdyb25n
Lg0KPiBNeSBhcG9sb2dpZXMgZm9yIGFueSB0cm91YmxlLg0KPiANCj4gV2UgaGF2ZSBmdXJ0aGVy
IGltcHJvdmVkIHRoZSB0ZXN0IHByb2dyYW0gd2l0aCBhIHJldmlzZWQgaW1wbGVtZW50YXRpb24N
Cj4gW2F0dGFjaGVkIHdpdGggdGhpcyBlbWFpbF0gYW5kIGZvdW5kIHRoYXQgdGhpcyByZXZpc2lv
biBhcHBlYXJzIHRvDQo+IHByb3ZpZGUgbW9yZSBhY2N1cmF0ZSByZXN1bHRzIFtJIHRoaW5rXS4N
Cj4gDQo+IE1heSBJIHBsZWFzZSByZXF1ZXN0IHlvdSB0byByZXZpZXcgdGhlIGF0dGFjaGVkIHRl
c3QgcHJvZ3JhbSwgdmVyaWZ5IHRoZQ0KPiByZXN1bHRzIGFuZCBzaGFyZSB5b3VyIGZlZWRiYWNr
Lg0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGllbmNlIGFuZCB0aGUgb3Bwb3J0dW5pdHkg
dG8gbGVhcm4gYSBmZXcgbmV3DQo+IHRoaW5ncyENCj4gDQoNCkhleSwNCg0KTWFueSB0aGFua3Mg
Zm9yIHRoZSB0ZXN0IHByb2dyYW0uDQpJIGFkbWl0LCBpdCBpcyBhIGdvb2Qgd2F5IGZvciBjb252
aW5jaW5nIG1lIFthbmQgbXkgcGFyYW5vaWEgYWJvdXQgY2hhbmdpbmcgbWF0aA0KaW4gdGhlIEFE
SSBkcml2ZXJzXS4gSSBkb24ndCB3YW50IHRvIHNheSB0aGF0IHRoZSBtYXRoIHdlIGRpZCBpcyB0
aGUgYmVzdCwgYnV0DQpzaW5jZSBpdCB3YXMgdGVzdGVkLi4uIMKvXF8o44OEKV8vwq8NClsgQWxz
bywgdGhlcmUncyBwbGVudHkgb2YgQURJIGRyaXZlcnMgdGhhdCB3ZSBoYXZlIHRvIGxvb2sgYXQs
IHNvIHRoYXQgYWxzbw0KbWFrZXMgbWUgcGFyYW5vaWQgXQ0KDQpJIHRvb2sgYSBsb29rIGFuZCBy
YW4geW91ciBwcm9ncmFtLg0KSSBsaWtlIHRoZSBpbXByb3ZlZCByZXN1bHRzLg0KDQpPbmx5IG9u
ZSBzdWdnZXN0aW9uIEkgaGF2ZSBmb3IgaXQ7IG1heWJlIHVzZSBhbiBleHRyYSB2YXJpYWJsZSBm
b3IgcGFydCBvZiB0aGUNCmRpdmlzb3I7IHNlZSBoZXJlOg0KDQp2b2lkIG5ld19mdW5jX2dldF9m
cmVxMShzdHJ1Y3QgYWRjNzE5Ml9zdGF0ZSAqc3QsIGludCAqZnJlcSkNCnsNCiAgICAgICAgdW5z
aWduZWQgaW50IGRpdjsNCg0KICAgICAgICAvKiBGb3JtdWxhcyBmb3IgZmlsdGVyIGF0IHBhZ2Ug
MjUgb2YgdGhlIGRhdGFzaGVldCAqLw0KICAgICAgICBkaXYgPSBBRDcxOTJfTU9ERV9SQVRFKHN0
LT5tb2RlKSAqIDEwMjQ7DQogICAgICAgIGZyZXFbMF0gPSBESVZfUk9VTkRfQ0xPU0VTVChzdC0+
ZmNsayAqIDI0MCwgZGl2ICogQUQ3MTkyX1NJTkM0X0ZJTFRFUik7DQogICAgICAgIGZyZXFbMV0g
PSBESVZfUk9VTkRfQ0xPU0VTVChzdC0+ZmNsayAqIDI0MCwgZGl2ICogQUQ3MTkyX1NJTkMzX0ZJ
TFRFUik7DQoNCiAgICAgICAgZnJlcVsyXSA9IERJVl9ST1VORF9DTE9TRVNUKHN0LT5mY2xrICog
MjMwLCBkaXYpOw0KICAgICAgICBmcmVxWzNdID0gRElWX1JPVU5EX0NMT1NFU1Qoc3QtPmZjbGsg
KiAyNzIsIGRpdik7DQp9DQoNCmlmIHlvdSB3YW50IHRvIHlvdSBjYW4gZ28gZXh0cmEtZnVydGhl
ciBhIGJpdCBhbmQgcmUtYWRkIHRoZSBmYWRjIGZvciB0aGUgZmlyc3QNCjIgZnJlcXVlbmNpZXM7
IHNvIHNvbWV0aGluZyBsaWtlOg0KDQoNCnZvaWQgbmV3X2Z1bmNfZ2V0X2ZyZXEyKHN0cnVjdCBh
ZGM3MTkyX3N0YXRlICpzdCwgaW50ICpmcmVxKQ0Kew0KICAgICAgICB1bnNpZ25lZCBpbnQgZGl2
LCBmYWRjOw0KDQogICAgICAgIC8qIEZvcm11bGFzIGZvciBmaWx0ZXIgYXQgcGFnZSAyNSBvZiB0
aGUgZGF0YXNoZWV0ICovDQogICAgICAgIGZhZGMgPSBzdC0+ZmNsayAqIDI0MDsNCiAgICAgICAg
ZGl2ID0gQUQ3MTkyX01PREVfUkFURShzdC0+bW9kZSkgKiAxMDI0Ow0KICAgICAgICBmcmVxWzBd
ID0gRElWX1JPVU5EX0NMT1NFU1QoZmFkYywgZGl2ICogQUQ3MTkyX1NJTkM0X0ZJTFRFUik7DQog
ICAgICAgIGZyZXFbMV0gPSBESVZfUk9VTkRfQ0xPU0VTVChmYWRjLCBkaXYgKiBBRDcxOTJfU0lO
QzNfRklMVEVSKTsNCg0KICAgICAgICBmcmVxWzJdID0gRElWX1JPVU5EX0NMT1NFU1Qoc3QtPmZj
bGsgKiAyMzAsIGRpdik7DQogICAgICAgIGZyZXFbM10gPSBESVZfUk9VTkRfQ0xPU0VTVChzdC0+
ZmNsayAqIDI3MiwgZGl2KTsNCn0NCg0KZWl0aGVyIHZlcnNpb24gaXMgZmluZSBmcm9tIG15IHNp
ZGU7DQoNClRoYW5rcw0KQWxleA0KDQoNCj4gRGVlcGFrLg0KPiANCj4gPiA+IERlZXBhay4NCj4g
PiA+IA0KPiA+ID4gDQo+ID4gPiA+IC0tIA0KPiA+ID4gPiBTdGVmYW5vDQo+ID4gPiA+IA0K
