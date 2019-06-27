Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC5C58381
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2019 15:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfF0NbB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jun 2019 09:31:01 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45252 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfF0NbB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jun 2019 09:31:01 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RDSUkW015125;
        Thu, 27 Jun 2019 09:30:55 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2051.outbound.protection.outlook.com [104.47.41.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tcntvhdaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 09:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDE4VAXziFkkbjSHoxsmpZ9teXpXc2wN3UDnae/MWbc=;
 b=xIgjzvIP+2twHl/WRKFC75zCk3c9xAbOW2znrrq+Pi6gD/VtONoHoYxy3NFAsXpQEZ9trFdnpFlPP61dDdByQzYAulraGdo4Y1HMFSXbyBMpnbFJ6Kwg8zG0SOUlw2TptRzihIbS6tgfcRE+q+uXskfqxqYz2cKD1RklOhxO100=
Received: from BN6PR03CA0004.namprd03.prod.outlook.com (2603:10b6:404:23::14)
 by BLUPR03MB549.namprd03.prod.outlook.com (2a01:111:e400:880::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.13; Thu, 27 Jun
 2019 13:29:17 +0000
Received: from BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN6PR03CA0004.outlook.office365.com
 (2603:10b6:404:23::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.18 via Frontend
 Transport; Thu, 27 Jun 2019 13:29:17 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT026.mail.protection.outlook.com (10.152.77.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Thu, 27 Jun 2019 13:29:17 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5RDTF9U019931
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Jun 2019 06:29:15 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Thu, 27 Jun 2019 09:29:16 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/5] drivers: spi: core: Add optional stall delay
 between cs_change transfers
Thread-Topic: [PATCH 2/5] drivers: spi: core: Add optional stall delay
 between cs_change transfers
Thread-Index: AQHVK1fSomHfBxPFU0OCnjvN6Hk0n6auh/0AgAE8+QA=
Date:   Thu, 27 Jun 2019 13:29:15 +0000
Message-ID: <4233221bfa727965e1d46ce327d1bfd29b0c8aaf.camel@analog.com>
References: <20190625131328.11883-1-alexandru.ardelean@analog.com>
         <20190625131328.11883-2-alexandru.ardelean@analog.com>
         <20190626193438.7248d0a9@archlinux>
In-Reply-To: <20190626193438.7248d0a9@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.145]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E313F6E9F41E714FA458A9E2FD3E21A4@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(2980300002)(189003)(199004)(426003)(2501003)(76176011)(11346002)(229853002)(36756003)(476003)(446003)(50466002)(102836004)(2616005)(126002)(86362001)(436003)(70586007)(336012)(5660300002)(3846002)(54906003)(6116002)(106002)(186003)(486006)(316002)(7696005)(5640700003)(14454004)(47776003)(14444005)(8936002)(2906002)(70206006)(356004)(7736002)(8676002)(7636002)(6916009)(246002)(2351001)(478600001)(305945005)(6246003)(2486003)(23676004)(26005)(4326008)(118296001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB549;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 693b127c-341e-4d68-9cf3-08d6fb037423
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BLUPR03MB549;
X-MS-TrafficTypeDiagnostic: BLUPR03MB549:
X-Microsoft-Antispam-PRVS: <BLUPR03MB5498F87AE79D020FDDF8908F9FD0@BLUPR03MB549.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 008184426E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /cK1r8BKDDbDLZaYyHWKQDxPtFuENfndNuxyFtkAqaIqQX5L1lTqbKX333kWcce40TfQqEuwA6m5zkr2C5FCQjAmjLd6UsqH++5sTIVwtVuwFcP9LGGHjLMQfBaePol33bAyyUGKtzio6rHJAnVjyhcbJWgveddCrZl0jgu6qysYSCkA0hJUfBiA+UgjIjs4dyDpo8CClfKEmkQHxTjGu5EmojAqr8S2LTYyZ4JzlQhVQDmdg9grz3EnEXqwfdp2k0oOYraiH9uT3OpAB2yLxn+VQ2nEcTGc76U+7/buTXgrVQxhIdp4Mu2LBAsPUzK8VitZ8b4tNpYuaP84BEzgr7Xj0CJgM6aslTsQFrJDkeoz4EqkFP6Amrx5uCBUHbCNgVlu0ILR1Xb1UqFDHvqE5nSHp/qAlIcRTGnY7QZYWcc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2019 13:29:17.0457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 693b127c-341e-4d68-9cf3-08d6fb037423
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB549
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270158
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA2LTI2IGF0IDE5OjM0ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUdWUsIDI1IEp1biAyMDE5IDE2OjEzOjI1ICswMzAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBTb21lIGRldmljZXMgbGlrZSB0aGUgQURJUzE2NDYwIElNVSByZXF1aXJl
IGEgc3RhbGwgcGVyaW9kIGJldHdlZW4NCj4gPiB0cmFuc2ZlcnMsIGkuZS4gYmV0d2VlbiB3aGVu
IHRoZSBDUyBpcyBkZS1hc3NlcnRlZCBhbmQgcmUtYXNzZXJ0ZWQuIFRoZQ0KPiA+IGRlZmF1bHQg
dmFsdWUgb2YgMTB1cyBpcyBub3QgZW5vdWdoLiBUaGlzIGNoYW5nZSBtYWtlcyB0aGUgZGVsYXkN
Cj4gPiBjb25maWd1cmFibGUgZm9yIHdoZW4gdGhlIG5leHQgQ1MgY2hhbmdlIGdvZXMgYWN0aXZl
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSGVubmVyaWNoIDxtaWNoYWVsLmhl
bm5lcmljaEBhbmFsb2cuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVh
biA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+IA0KPiBHZW5lcmFsIHByaW5jaXBs
ZSBzZWVtcyBmaW5lIHRvIG1lLCB0aG91Z2ggbmFtaW5nIG1heSBuZWVkIHNvbWUgd29yay4NCj4g
DQo+IGNzX2xvd190aW1lIG9yIHNvbWV0aGluZyBtb3JlIHNwZWNpZmljIHRoYW4gc3RhbGwgcGVy
aGFwcz8NCg0KSSBhZ3JlZSB0aGUgbmFtaW5nIGNvdWxkIGRvIHNvbWUgd29yay4NCkl0IHdhcyBv
bmUgb2YgdGhlIGl0ZW1zIFtpbiB0aGlzIHNlcmllc10gZm9yIHdoaWNoIEkgd2FzIGV4cGVjdGlu
ZyBhIGJpdCBvZiBhIGRpc2N1c3Npb24uDQoNClRoYW5rcw0KQWxleA0KDQo+IA0KPiArQ0MgTWFy
ay4NCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvc3BpL3NwaS5jICAgICAgIHwgMyArKy0NCj4g
PiAgaW5jbHVkZS9saW51eC9zcGkvc3BpLmggfCAzICsrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3NwaS9zcGkuYyBiL2RyaXZlcnMvc3BpL3NwaS5jDQo+ID4gaW5kZXggNWU3NTk0NGFk
NWQxLi43MzlkZTAxMThlZTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLmMNCj4g
PiArKysgYi9kcml2ZXJzL3NwaS9zcGkuYw0KPiA+IEBAIC0xMTYzLDcgKzExNjMsOCBAQCBzdGF0
aWMgaW50IHNwaV90cmFuc2Zlcl9vbmVfbWVzc2FnZShzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0
bHIsDQo+ID4gIAkJCQlrZWVwX2NzID0gdHJ1ZTsNCj4gPiAgCQkJfSBlbHNlIHsNCj4gPiAgCQkJ
CXNwaV9zZXRfY3MobXNnLT5zcGksIGZhbHNlKTsNCj4gPiAtCQkJCXVkZWxheSgxMCk7DQo+ID4g
KwkJCQl1ZGVsYXkoeGZlci0+Y3NfY2hhbmdlX3N0YWxsX2RlbGF5X3VzID8NCj4gPiArCQkJCSAg
ICAgICB4ZmVyLT5jc19jaGFuZ2Vfc3RhbGxfZGVsYXlfdXMgOiAxMCk7DQo+ID4gIAkJCQlzcGlf
c2V0X2NzKG1zZy0+c3BpLCB0cnVlKTsNCj4gPiAgCQkJfQ0KPiA+ICAJCX0NCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9zcGkvc3BpLmggYi9pbmNsdWRlL2xpbnV4L3NwaS9zcGkuaA0K
PiA+IGluZGV4IDA1M2FiZDIyYWQzMS4uZDIzYWRkM2I0NzkwIDEwMDY0NA0KPiA+IC0tLSBhL2lu
Y2x1ZGUvbGludXgvc3BpL3NwaS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zcGkvc3BpLmgN
Cj4gPiBAQCAtNzM0LDYgKzczNCw4IEBAIGV4dGVybiB2b2lkIHNwaV9yZXNfcmVsZWFzZShzdHJ1
Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIsDQo+ID4gICAqICAgICAgdHJhbnNmZXIuIElmIDAgdGhl
IGRlZmF1bHQgKGZyb20gQHNwaV9kZXZpY2UpIGlzIHVzZWQuDQo+ID4gICAqIEBiaXRzX3Blcl93
b3JkOiBzZWxlY3QgYSBiaXRzX3Blcl93b3JkIG90aGVyIHRoYW4gdGhlIGRldmljZSBkZWZhdWx0
DQo+ID4gICAqICAgICAgZm9yIHRoaXMgdHJhbnNmZXIuIElmIDAgdGhlIGRlZmF1bHQgKGZyb20g
QHNwaV9kZXZpY2UpIGlzIHVzZWQuDQo+ID4gKyAqIEBjc19jaGFuZ2Vfc3RhbGxfZGVsYXlfdXM6
IG1pY3Jvc2Vjb25kcyB0byBkZWxheSBiZXR3ZWVuIGNzX2NoYW5nZQ0KPiA+ICsgKiAJdHJhbnNm
ZXJzLg0KPiA+ICAgKiBAY3NfY2hhbmdlOiBhZmZlY3RzIGNoaXBzZWxlY3QgYWZ0ZXIgdGhpcyB0
cmFuc2ZlciBjb21wbGV0ZXMNCj4gPiAgICogQGRlbGF5X3VzZWNzOiBtaWNyb3NlY29uZHMgdG8g
ZGVsYXkgYWZ0ZXIgdGhpcyB0cmFuc2ZlciBiZWZvcmUNCj4gPiAgICoJKG9wdGlvbmFsbHkpIGNo
YW5naW5nIHRoZSBjaGlwc2VsZWN0IHN0YXR1cywgdGhlbiBzdGFydGluZw0KPiA+IEBAIC04MjMs
NiArODI1LDcgQEAgc3RydWN0IHNwaV90cmFuc2ZlciB7DQo+ID4gICNkZWZpbmUJU1BJX05CSVRT
X1FVQUQJCTB4MDQgLyogNGJpdHMgdHJhbnNmZXIgKi8NCj4gPiAgCXU4CQliaXRzX3Blcl93b3Jk
Ow0KPiA+ICAJdTgJCXdvcmRfZGVsYXlfdXNlY3M7DQo+ID4gKwl1OAkJY3NfY2hhbmdlX3N0YWxs
X2RlbGF5X3VzOw0KPiA+ICAJdTE2CQlkZWxheV91c2VjczsNCj4gPiAgCXUzMgkJc3BlZWRfaHo7
DQo+ID4gIAl1MTYJCXdvcmRfZGVsYXk7DQo=
