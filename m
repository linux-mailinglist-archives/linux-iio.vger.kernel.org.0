Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955104286E
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2019 16:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437270AbfFLOJy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Jun 2019 10:09:54 -0400
Received: from mail-eopbgr690046.outbound.protection.outlook.com ([40.107.69.46]:43722
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437199AbfFLOJx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 Jun 2019 10:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sEo+HwAI3skkjlsHFLNUbRdicxZBgNeo5ltH1lbzpY=;
 b=VfsjDGPxSrXTBfXl1/QjBUojS/Z0royJvYC2xIcrkv4deWQF9Fg+2Rj05DnW1G9dSREkLwokkzFgBQjspZR2lpwau5r0SgoD9qIlKgY5UPTNwo9ZRGUbT0vgxXfcOEYy6ETe4lnJcF496c9GR5JCbRjVIwGKhaiOo725BW6nwKg=
Received: from BN3PR03CA0063.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::23) by CY1PR03MB2265.namprd03.prod.outlook.com
 (2603:10b6:600:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.11; Wed, 12 Jun
 2019 14:09:49 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BN3PR03CA0063.outlook.office365.com
 (2a01:111:e400:7a4d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1987.10 via Frontend
 Transport; Wed, 12 Jun 2019 14:09:49 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Wed, 12 Jun 2019 14:09:49 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5CE9mt1015437
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 12 Jun 2019 07:09:48 -0700
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Wed, 12 Jun 2019 10:09:48 -0400
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: iio: frequency: Add docs for
 ADF4371 PLL
Thread-Topic: [PATCH v5 2/2] dt-bindings: iio: frequency: Add docs for
 ADF4371 PLL
Thread-Index: AQHVGtaWSysYYfF89kiPx+e4Rzh1OKaXT0YAgAEPFQA=
Date:   Wed, 12 Jun 2019 14:09:47 +0000
Message-ID: <1560348586.4768.5.camel@analog.com>
References: <1559653697-2760-1-git-send-email-stefan.popa@analog.com>
         <20190611215932.GA24974@bogus>
In-Reply-To: <20190611215932.GA24974@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.224.122]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <79AF52B7F5E7FA4BB1D76ECE4FFEA5BD@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(189003)(199004)(55674003)(316002)(4326008)(54906003)(8676002)(246002)(1730700003)(6916009)(86362001)(2501003)(103116003)(5660300002)(70586007)(356004)(70206006)(50466002)(8936002)(102836004)(336012)(14454004)(186003)(26005)(11346002)(446003)(486006)(47776003)(476003)(126002)(2616005)(106002)(5640700003)(2906002)(436003)(426003)(229853002)(76176011)(2486003)(23676004)(6306002)(7696005)(36756003)(7736002)(3846002)(6116002)(6246003)(7636002)(478600001)(966005)(305945005)(72206003)(2351001)(7416002)(53376002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2265;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bac810d-d1ba-4324-5efb-08d6ef3fa1bd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:CY1PR03MB2265;
X-MS-TrafficTypeDiagnostic: CY1PR03MB2265:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <CY1PR03MB2265E577319C4D64D33711669DEC0@CY1PR03MB2265.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0066D63CE6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZJNFJAinKbAPYfI63CyTiL/xe4vebqn4QaJpQ5/csfOqqLbCUafizC9cZzL70r1JnHylzKtoABhEv86Igf/BFx777UnWTrW+kfGSMi8ux2Y5fdThMmU0lBsmGLOyQI/L6V7cK8ke/EHg3PWgBIDepvOU+bngtn4VcvkNmYIdfWSTRy3OKCOEt88TX/Zm8CubD55KSpQqRfGDJHuWajtLEVbn6LzNkZ+gZbsqkURn5y3eRcdPpRfy5pD367bdHkwEtb8hH6CCfJU6Bzfwy/SdU5TjzdWdCKtJC/hn/Hq0cXyqZx+DvnNkOkK1xnK6oga13i6TKAss65m2J6D9t33ECRKs0pOfnUhbGuNr/7m/oQyJxrSixAywt2jxcgnU2AgNAcUAtN0hKcy+EAXPApJeu7VN8pcGYsy+jQE8k4hRwvs=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2019 14:09:49.3863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bac810d-d1ba-4324-5efb-08d6ef3fa1bd
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2265
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgUm9iLA0KDQpJJ20gc29ycnkgSSBmb3Jnb3QgdG8gaW5jbHVkZSB5b3VyIFJldmlld2VkLWJ5
IGluIHRoaXMgcGF0Y2ggc2VyaWVzLg0KSG93ZXZlciwgSSByZWFsaXplZCB0aGlzIG1pc3Rha2Ug
YW5kIGFkZGVkIGl0IHRvIHY2IHdoaWNoIGluIHRoZSBtZWFudGltZQ0KSm9uYXRoYW4gaGFzIGFw
cGxpZWQuDQoNCkkgd2lsbCBmaXggeW91ciByZW1hcmsgYmVsbG93IHJlZ2FyZGluZyBjbG9jay1u
YW1lcyBpbiB0aGUgbmV4dCBwYXRjaA0Kc2VyaWVzIGZvciB0aGlzIGRldmljZS4NCg0KVGhhbmsg
eW91LA0KLVN0ZWZhbg0KDQpPbiBNYSwgMjAxOS0wNi0xMSBhdCAxNTo1OSAtMDYwMCwgUm9iIEhl
cnJpbmcgd3JvdGU6DQo+IA0KPiANCj4gT24gVHVlLCBKdW4gMDQsIDIwMTkgYXQgMDQ6MDg6MTdQ
TSArMDMwMCwgU3RlZmFuIFBvcGEgd3JvdGU6DQo+ID4gDQo+ID4gRG9jdW1lbnQgc3VwcG9ydCBm
b3IgQW5hbG9nIERldmljZXMgQURGNDM3MSBTUEkgV2lkZWJhbmQgU3ludGhlc2l6ZXIuDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIFBvcGEgPHN0ZWZhbi5wb3BhQGFuYWxvZy5jb20+
DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiDCoMKgwqDCoMKgwqAtIE5vdGhpbmcg
Y2hhbmdlZC4NCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+IMKgwqDCoMKgwqDCoC0gTm90aGluZyBj
aGFuZ2VkLg0KPiA+IENoYW5nZXMgaW4gdjQ6DQo+ID4gwqDCoMKgwqDCoMKgLSBOb3RoaW5nIGNo
YW5nZWQuDQo+ID4gQ2hhbmdlcyBpbiB2NToNCj4gPiDCoMKgwqDCoMKgwqAtIE5vdGhpbmcgY2hh
bmdlZC4NCj4gUGxlYXNlIGFkZCBhY2tzL3Jldmlld2VkLWJ5cyB3aGVuIHBvc3RpbmcgbmV3IHZl
cnNpb25zLg0KPiANCj4gQnV0IHNvbWV0aGluZyBlbHNlIEkgbm90aWNlZDoNCj4gDQo+ID4gDQo+
ID4gDQo+ID4gwqAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZnJlcXVlbmN5L2FkZjQzNzEu
eWFtbCB8IDU0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgMSBmaWxlIGNoYW5n
ZWQsIDU0IGluc2VydGlvbnMoKykNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZnJlcXVlbmN5L2FkZjQzNzEueWFtbA0K
PiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9paW8vZnJlcXVlbmN5L2FkZjQzNzEueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lpby9mcmVxdWVuY3kvYWRmNDM3MS55YW1sDQo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi5kN2FkZjA3NA0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2ZyZXF1
ZW5jeS9hZGY0MzcxLnlhbWwNCj4gPiBAQCAtMCwwICsxLDU0IEBADQo+ID4gKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICsk
aWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2lpby9mcmVxdWVuY3kvYWRmNDM3MS55
YW1sIw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2Nv
cmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBBbmFsb2cgRGV2aWNlcyBBREY0MzcxIFdpZGVi
YW5kIFN5bnRoZXNpemVyDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArwqDCoC0gUG9w
YSBTdGVmYW4gPHN0ZWZhbi5wb3BhQGFuYWxvZy5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlv
bjogfA0KPiA+ICvCoMKgQW5hbG9nIERldmljZXMgQURGNDM3MSBTUEkgV2lkZWJhbmQgU3ludGhl
c2l6ZXINCj4gPiArwqDCoGh0dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2Fs
LWRvY3VtZW50YXRpb24vZGF0YS1zaGVldHMvDQo+ID4gYWRmNDM3MS5wZGYNCj4gPiArDQo+ID4g
K3Byb3BlcnRpZXM6DQo+ID4gK8KgwqBjb21wYXRpYmxlOg0KPiA+ICvCoMKgwqDCoGVudW06DQo+
ID4gK8KgwqDCoMKgwqDCoC0gYWRpLGFkZjQzNzENCj4gPiArDQo+ID4gK8KgwqByZWc6DQo+ID4g
K8KgwqDCoMKgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gK8KgwqBjbG9ja3M6DQo+ID4gK8KgwqDC
oMKgZGVzY3JpcHRpb246DQo+ID4gK8KgwqDCoMKgwqDCoERlZmluaXRpb24gb2YgdGhlIGV4dGVy
bmFsIGNsb2NrIChzZWUgY2xvY2svY2xvY2stYmluZGluZ3MudHh0KQ0KPiA+ICvCoMKgwqDCoG1h
eEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICvCoMKgY2xvY2stbmFtZXM6DQo+ID4gK8KgwqDCoMKgZGVz
Y3JpcHRpb246DQo+ID4gK8KgwqDCoMKgwqDCoE11c3QgYmUgImNsa2luIg0KPiBUaGlzIGNhbiBi
ZSBhIHNjaGVtYToNCj4gDQo+IGNsb2NrLW5hbWVzOg0KPiDCoCBpdGVtczoNCj4gwqDCoMKgwqAt
IGNsa2luDQo+IA0KPiA+IA0KPiA+ICvCoMKgwqDCoG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICty
ZXF1aXJlZDoNCj4gPiArwqDCoC0gY29tcGF0aWJsZQ0KPiA+ICvCoMKgLSByZWcNCj4gPiArwqDC
oC0gY2xvY2tzDQo+ID4gK8KgwqAtIGNsb2NrLW5hbWVzDQo+ID4gKw0KPiA+ICtleGFtcGxlczoN
Cj4gPiArwqDCoC0gfA0KPiA+ICvCoMKgwqDCoHNwaTAgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
I2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqAjc2l6ZS1jZWxscyA9
IDwwPjsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqBmcmVxdWVuY3lAMCB7DQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJhZGksYWRmNDM3MSI7
DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDA+Ow0KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwaS1tYXgtZnJlcXVlbmN5ID0gPDEwMDAw
MDA+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrcyA9IDwmYWRm
NDM3MV9jbGtpbj47DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2xvY2st
bmFtZXMgPSAiY2xraW4iOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgfTsNCj4gPiArwqDCoMKgwqB9
Ow0KPiA+ICsuLi4NCj4gPiAtLQ0KPiA+IDIuNy40DQo+ID4g
