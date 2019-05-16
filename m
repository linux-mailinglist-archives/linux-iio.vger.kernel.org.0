Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA26120849
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2019 15:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfEPNe2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 May 2019 09:34:28 -0400
Received: from mail-eopbgr750043.outbound.protection.outlook.com ([40.107.75.43]:37316
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbfEPNe2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 May 2019 09:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cjR+UV2nFvaMjVEXfOvYZ/gtZfXpxkMFp+Q4oHEDcM=;
 b=X/gaJnAPI2hl169jGfacbHW0hC+q2TAIVfKkDBgRlJHpnH7de3KE7G4lRNXAZOyUj+aGuUpn3YWocZRARec3I9GIPMzEgoYM6lb+1kDnVKSMloI6TwWDiZ0AS0q96etU2csvhFGvlgZDtleEXAVma8c35ZDyWJAjMoQZ+r82GaU=
Received: from DM5PR03CA0044.namprd03.prod.outlook.com (2603:10b6:4:3b::33) by
 CY1PR03MB2268.namprd03.prod.outlook.com (2a01:111:e400:c614::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.16; Thu, 16 May
 2019 13:34:12 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by DM5PR03CA0044.outlook.office365.com
 (2603:10b6:4:3b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Thu, 16 May 2019 13:34:11 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Thu, 16 May 2019 13:34:11 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4GDYBdd004758
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 16 May 2019 06:34:11 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Thu, 16 May 2019 09:34:10 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: accel: adxl345: switch to YAML
 bindings
Thread-Topic: [PATCH] dt-bindings: iio: accel: adxl345: switch to YAML
 bindings
Thread-Index: AQHVC+ECpfV4GN/cpE6IkEVi7Cs1EaZuAfkAgAABZ4A=
Date:   Thu, 16 May 2019 13:34:10 +0000
Message-ID: <f2c3728e370bab8998d11ecabd4366e4776ea671.camel@analog.com>
References: <20190516121509.1441-1-alexandru.ardelean@analog.com>
         <CAL_JsqJLEuCJWnD1G5iXdCNcJ+a_0zhoUH2a=4i6VBm8_B9r6w@mail.gmail.com>
In-Reply-To: <CAL_JsqJLEuCJWnD1G5iXdCNcJ+a_0zhoUH2a=4i6VBm8_B9r6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7CB4942CF932143ACA5F70E6BA74DB2@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(189003)(199004)(118296001)(486006)(14444005)(5660300002)(36756003)(126002)(6306002)(102836004)(2616005)(53546011)(966005)(7696005)(476003)(336012)(76176011)(8676002)(2486003)(23676004)(246002)(8936002)(356004)(50466002)(54906003)(14454004)(229853002)(436003)(3846002)(86362001)(7736002)(2906002)(6116002)(6246003)(70586007)(4326008)(70206006)(316002)(7636002)(53376002)(106002)(478600001)(186003)(26005)(426003)(446003)(11346002)(47776003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2268;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e42e6ff-d6e3-4dc8-fe09-08d6da032e65
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:CY1PR03MB2268;
X-MS-TrafficTypeDiagnostic: CY1PR03MB2268:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <CY1PR03MB2268A0CC964320196835468DF90A0@CY1PR03MB2268.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0039C6E5C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: zl4KUTfgsEwdLqZe76z0rLI6UvkPN7Tmn7jdZTy8iYt7ZCnaL9zIYd8alC12ybaBITqwoIs3j2zSKdByEKgbRKziKPECTP4L9rj0CzuVuXz+DowK8JqstreErj1+drEy5uEPH/8t1Xhqes09I8H+AVMZ+iI0SkUKaH4qOZ6H2WQ7C7x9iVoVbrAqMTszcZaOvQfHOteu1h79hwvgUWy6gn2PUcyR0ug+U/5eguZJqhfwxY3KjNGCq5O5Itqeg+wumnVYNwiZiWb3oe64JVQAbsva4A+MkbMURLk238mxeW/psfK2ORqoomWE6ojGJdUH3Uw33uJ060Kms+a4bxCd310NndHXyRnZ9HAziZHsKVz0MMtRaaWHbqf97H5dPpR2YslBRpL2dJU0P+P+lH9afO2OlJwmKz8JZMfrTyFjEzA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2019 13:34:11.5445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e42e6ff-d6e3-4dc8-fe09-08d6da032e65
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2268
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA1LTE2IGF0IDA4OjI5IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
W0V4dGVybmFsXQ0KPiANCj4gDQo+IE9uIFRodSwgTWF5IDE2LCAyMDE5IGF0IDc6MTUgQU0gQWxl
eGFuZHJ1IEFyZGVsZWFuDQo+IDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6
DQo+ID4gDQo+ID4gVGhlIEFEWDM0NSBzdXBwb3J0cyBib3RoIEkyQyAmIFNQSSBiaW5kaW5ncy4N
Cj4gPiBUaGlzIGNoYW5nZSBzd2l0Y2hlcyBmcm9tIG9sZCB0ZXh0IGJpbmRpbmdzLCB0byBZQU1M
IGJpbmRpbmdzLCBhbmQgYWxzbw0KPiA+IHRyaWVzIHRvIG1ha2UgdXNlIG9mIHRoZSByZWNlbnQg
bXVsdGlwbGUtZXhhbXBsZXMgc3VwcG9ydC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+IC0tLQ0K
PiA+ICAuLi4vYmluZGluZ3MvaWlvL2FjY2VsL2FkaSxhZHhsMzQ1LnlhbWwgICAgICAgfCA3NCAr
KysrKysrKysrKysrKysrKysrDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hY2Nl
bC9hZHhsMzQ1LnR4dCB8IDM5IC0tLS0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3NCBp
bnNlcnRpb25zKCspLCAzOSBkZWxldGlvbnMoLSkNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+
ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hY2NlbC9hZGksYWR4bDM0
NS55YW1sDQo+ID4gIGRlbGV0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9paW8vYWNjZWwvYWR4bDM0NS50eHQNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FjY2VsL2FkaSxh
ZHhsMzQ1LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8v
YWNjZWwvYWRpLGFkeGwzNDUueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi40N2NkZmIzYjgxODINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hY2NlbC9hZGksYWR4bDM0
NS55YW1sDQo+ID4gQEAgLTAsMCArMSw3NCBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiANCj4gPiBo
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9paW8vYWNjZWxlcm9tZXRlcnMvYWRpLGFkeGwz
NDUueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1h
cy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogQW5hbG9nIERldmljZXMgQURYTDM0NS9B
RFhMMzc1IDMtQXhpcyBEaWdpdGFsIEFjY2VsZXJvbWV0ZXJzDQo+ID4gKw0KPiA+ICttYWludGFp
bmVyczoNCj4gPiArICAtIE1pY2hhZWwgSGVubmVyaWNoIDxtaWNoYWVsLmhlbm5lcmljaEBhbmFs
b2cuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246IHwNCj4gPiArICBBbmFsb2cgRGV2aWNl
cyBBRFhMMzQ1L0FEWEwzNzUgMy1BeGlzIERpZ2l0YWwgQWNjZWxlcm9tZXRlcnMgdGhhdA0KPiA+
IHN1cHBvcnRzDQo+ID4gKyAgYm90aCBJMkMgJiBTUEkgaW50ZXJmYWNlcy4NCj4gPiArICAgIGh0
dHA6Ly93d3cuYW5hbG9nLmNvbS9lbi9wcm9kdWN0cy9tZW1zL2FjY2VsZXJvbWV0ZXJzL2FkeGwz
NDUuaHRtbA0KPiA+ICsgICAgDQo+ID4gaHR0cDovL3d3dy5hbmFsb2cuY29tL2VuL3Byb2R1Y3Rz
L3NlbnNvcnMtbWVtcy9hY2NlbGVyb21ldGVycy9hZHhsMzc1Lmh0bWwNCj4gPiArDQo+ID4gK3By
b3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAg
IC0gYWRpLGFkeGwzNDUNCj4gPiArICAgICAgLSBhZGksYWR4bDM3NQ0KPiA+ICsNCj4gPiArICBy
ZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBzcGktY3BoYTogdHJ1ZQ0K
PiA+ICsNCj4gPiArICBzcGktY3BvbDogdHJ1ZQ0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHQtcGFy
ZW50OiB0cnVlDQo+IA0KPiBZb3UgZG9uJ3QgbmVlZCB0byBkb2N1bWVudCBpbnRlcnJ1cHQtcGFy
ZW50LiBJdCBpcyBpbXBsaWVkLiBXaXRoIHRoYXQNCj4gZHJvcHBlZCwNCg0KSSdsbCBzZW5kIGEg
VjIgZHJvcHBpbmcgaXQuDQoNClRoYW5rcw0KQWxleA0KDQo+IA0KPiBSZXZpZXdlZC1ieTogUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6
DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBj
b21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiArICAtIGludGVycnVwdHMNCj4gPiArDQo+ID4g
K2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dw
aW8vZ3Bpby5oPg0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250
cm9sbGVyL2lycS5oPg0KPiA+ICsgICAgaTJjMCB7DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2Vs
bHMgPSA8MT47DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKw0KPiA+ICsg
ICAgICAgIC8qIEV4YW1wbGUgZm9yIGEgSTJDIGRldmljZSBub2RlICovDQo+ID4gKyAgICAgICAg
YWNjZWxlcm9tZXRlckAyYSB7DQo+ID4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYWRpLGFk
eGwzNDUiOw0KPiA+ICsgICAgICAgICAgICByZWcgPSA8MHg1Mz47DQo+ID4gKyAgICAgICAgICAg
IGludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8wPjsNCj4gPiArICAgICAgICAgICAgaW50ZXJydXB0
cyA9IDwwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsgICAgICAgIH07DQo+ID4gKyAgICB9
Ow0KPiA+ICsgIC0gfA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5o
Pg0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ly
cS5oPg0KPiA+ICsgICAgc3BpMCB7DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKw0KPiA+ICsgICAgICAgIC8q
IEV4YW1wbGUgZm9yIGEgU1BJIGRldmljZSBub2RlICovDQo+ID4gKyAgICAgICAgYWNjZWxlcm9t
ZXRlckAwIHsNCj4gPiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhZGksYWR4bDM0NSI7DQo+
ID4gKyAgICAgICAgICAgIHJlZyA9IDwwPjsNCj4gPiArICAgICAgICAgICAgc3BpLW1heC1mcmVx
dWVuY3kgPSA8NTAwMDAwMD47DQo+ID4gKyAgICAgICAgICAgIHNwaS1jcG9sOw0KPiA+ICsgICAg
ICAgICAgICBzcGktY3BoYTsNCj4gPiArICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwm
Z3BpbzA+Ow0KPiA+ICsgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDAgSVJRX1RZUEVfTEVWRUxf
SElHSD47DQo+ID4gKyAgICAgICAgfTsNCj4gPiArICAgIH07DQo+ID4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWNjZWwvYWR4bDM0NS50eHQNCj4g
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWNjZWwvYWR4bDM0NS50
eHQNCj4gPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCBmOTUyNWY2ZTNkNDMu
LjAwMDAwMDAwMDAwMA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9paW8vYWNjZWwvYWR4bDM0NS50eHQNCj4gPiArKysgL2Rldi9udWxsDQo+ID4gQEAgLTEsMzkg
KzAsMCBAQA0KPiA+IC1BbmFsb2cgRGV2aWNlcyBBRFhMMzQ1L0FEWEwzNzUgMy1BeGlzIERpZ2l0
YWwgQWNjZWxlcm9tZXRlcnMNCj4gPiAtDQo+ID4gLWh0dHA6Ly93d3cuYW5hbG9nLmNvbS9lbi9w
cm9kdWN0cy9tZW1zL2FjY2VsZXJvbWV0ZXJzL2FkeGwzNDUuaHRtbA0KPiA+IC0NCj4gPiBodHRw
Oi8vd3d3LmFuYWxvZy5jb20vZW4vcHJvZHVjdHMvc2Vuc29ycy1tZW1zL2FjY2VsZXJvbWV0ZXJz
L2FkeGwzNzUuaHRtbA0KPiA+IC0NCj4gPiAtUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAtIC0g
Y29tcGF0aWJsZSA6IHNob3VsZCBiZSBvbmUgb2YNCj4gPiAtICAgICAgICAgICAgICAgImFkaSxh
ZHhsMzQ1Ig0KPiA+IC0gICAgICAgICAgICAgICAiYWRpLGFkeGwzNzUiDQo+ID4gLSAtIHJlZyA6
IHRoZSBJMkMgYWRkcmVzcyBvciBTUEkgY2hpcCBzZWxlY3QgbnVtYmVyIG9mIHRoZSBzZW5zb3IN
Cj4gPiAtDQo+ID4gLVJlcXVpcmVkIHByb3BlcnRpZXMgZm9yIFNQSSBidXMgdXNhZ2U6DQo+ID4g
LSAtIHNwaS1tYXgtZnJlcXVlbmN5IDogc2V0IG1heGltdW0gY2xvY2sgZnJlcXVlbmN5LCBtdXN0
IGJlIDUwMDAwMDANCj4gPiAtIC0gc3BpLWNwb2wgYW5kIHNwaS1jcGhhIDogbXVzdCBiZSBkZWZp
bmVkIGZvciBhZHhsMzQ1IHRvIGVuYWJsZSBTUEkNCj4gPiBtb2RlIDMNCj4gPiAtDQo+ID4gLU9w
dGlvbmFsIHByb3BlcnRpZXM6DQo+ID4gLSAtIGludGVycnVwdHM6IGludGVycnVwdCBtYXBwaW5n
IGZvciBJUlEgYXMgZG9jdW1lbnRlZCBpbg0KPiA+IC0gICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaW50ZXJydXB0LQ0KPiA+IGNvbnRyb2xsZXIvaW50ZXJydXB0cy50eHQNCj4g
PiAtDQo+ID4gLUV4YW1wbGUgZm9yIGEgSTJDIGRldmljZSBub2RlOg0KPiA+IC0NCj4gPiAtICAg
ICAgIGFjY2VsZXJvbWV0ZXJAMmEgew0KPiA+IC0gICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
ImFkaSxhZHhsMzQ1IjsNCj4gPiAtICAgICAgICAgICAgICAgcmVnID0gPDB4NTM+Ow0KPiA+IC0g
ICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvMT47DQo+ID4gLSAgICAgICAg
ICAgICAgIGludGVycnVwdHMgPSA8MCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiAtICAgICAg
IH07DQo+ID4gLQ0KPiA+IC1FeGFtcGxlIGZvciBhIFNQSSBkZXZpY2Ugbm9kZToNCj4gPiAtDQo+
ID4gLSAgICAgICBhY2NlbGVyb21ldGVyQDAgew0KPiA+IC0gICAgICAgICAgICAgICBjb21wYXRp
YmxlID0gImFkaSxhZHhsMzQ1IjsNCj4gPiAtICAgICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiA+
IC0gICAgICAgICAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDw1MDAwMDAwPjsNCj4gPiAtICAg
ICAgICAgICAgICAgc3BpLWNwb2w7DQo+ID4gLSAgICAgICAgICAgICAgIHNwaS1jcGhhOw0KPiA+
IC0gICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvMT47DQo+ID4gLSAgICAg
ICAgICAgICAgIGludGVycnVwdHMgPSA8MCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiAtICAg
ICAgIH07DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPiANCg==
