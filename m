Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1051C18C75A
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 07:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgCTGTH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 02:19:07 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:10220 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgCTGTG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 02:19:06 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02K6CgAm004181;
        Fri, 20 Mar 2020 02:19:02 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2051.outbound.protection.outlook.com [104.47.38.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2yu9cr0ndr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 02:19:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpfXsAT2Hfk+OIRsuy0CPZJG3+f/QtqqXhX1XjmpQRdtMi0/HbohUn5FW3tpZ7kvxYQltD6nAopTFjXMsieQMZSYTulbUvI/iw3Q54sc1n95AMaWz5bIadQWrV0geND+jU2EHA3WNWmCvBmdAMeCUS4YzhS58a/4e3MKtkZE8F3v38pZ7tOi+HTqilch0DM0Y1COUh/hbo9VOD9rLgahgKJHtMuIRsOs6AIDnixNT6iwbGBpfTkAl4rSAdzfdgm+G1LCkAT4hzBDGg3uFDNGMJ6QxGWKDsDMNDWj4gPQCiArooIsGn7lYmN8kuteR8koOJOGztggbcpZ5hWs7kCGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9Y22O7tFJOb3aCAZw9ChVki7tZJF6IuLxqUAfHGPaQ=;
 b=dPjGyKY8Nm34DEDgIT/9xzm8iGFjkQrRbwZ4iUKfWO/oMaQDhvRgu2ZvCbYU+bBHOXmvxvGsLYcUVc7aNnUAWtkPmwXgHIB9rMSf1BfIonpLH8veJmYw2wdl/SmmAZKIz2cz6Iqmu5LxzhihYJNP5HFvEQakgZ0UKrLbU1qzpNAx6GI5o+cDnIkBHArgHgaWcKXzWW9g3JszqU6sI7cNRTaY+bnjhO3CKidHOn2bpoIZrqL+eRQ4DSfVC5MwrPLUSBpq2gaVRyGgL1fBcHQMKgMHUWHnYVcQQwjB3CjPT3ni0TdoPHRftwOZBLO9MrMQ2lbXlIvIyXJZMAg6odAhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9Y22O7tFJOb3aCAZw9ChVki7tZJF6IuLxqUAfHGPaQ=;
 b=Te89RyBCAK/5psd+uKHFsAoCnVNpdTOJzQwxuaXX1aFcvxZ3v6fzsGLAEuiVAuF8DwJfDX+Crs+5iX/LtEemGqEFCrBBOHVsmkwG/nIFum08oDHUKOMQ5wp2+yd6Ehug+KbFeo52psR8fVhh/gGWPZ5kNRRMmght7m/LdvC6Qow=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5370.namprd03.prod.outlook.com (2603:10b6:5:249::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Fri, 20 Mar
 2020 06:19:00 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 06:19:00 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>
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
Subject: Re: [PATCH v10 8/8] dt-bindings: iio: adc: add bindings doc for
 AD9467 ADC
Thread-Topic: [PATCH v10 8/8] dt-bindings: iio: adc: add bindings doc for
 AD9467 ADC
Thread-Index: AQHV+6rSzmjxHHvp10yjrHoXF1vhqKhQq8aAgABcuAA=
Date:   Fri, 20 Mar 2020 06:19:00 +0000
Message-ID: <481d207a0f77540cb9215feb23251123081cbc2f.camel@analog.com>
References: <20200316155035.25500-1-alexandru.ardelean@analog.com>
         <20200316155035.25500-9-alexandru.ardelean@analog.com>
         <20200320005031.GA31806@bogus>
In-Reply-To: <20200320005031.GA31806@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 121c2f3d-a094-446c-8189-08d7cc9694af
x-ms-traffictypediagnostic: DM6PR03MB5370:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5370F343BF67BFF93B56BF0EF9F50@DM6PR03MB5370.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(136003)(199004)(107886003)(6512007)(4326008)(2906002)(186003)(54906003)(66946007)(8936002)(66446008)(478600001)(81166006)(76116006)(8676002)(36756003)(64756008)(110136005)(91956017)(86362001)(81156014)(316002)(66556008)(66476007)(26005)(4744005)(5660300002)(2616005)(6486002)(6506007)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5370;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkXL0NYrhI1bPwDXeDQaZDyCylX+gJm647HjqbTRrrxagsygX22j4l/nqN621qJ24M1XBXJV0hbn0qdaETTLUUrtcIqFn1uc/CfZ306jwtH4GyvRAQB+En16zU/EHF7Fm/Ev28I/pbVRQzrFz1Ovr5x9isYK6cCQPukETseA8smUwVIQXXRiIGd40Mcz0/HqTU3Q0iTVEwslO2yPH+arglgixfuj6usBakUfeYJW892KPOa3N8xrUhj+WN0rIjXwjxi87aDZLWtGFzV7eF/8jhhq0wQlAHKlF9H+rg+g6o0rNj9O6gUEBOJJUpzOkJl+fhOviMrav7Z3pVGZiClCEaVj03/XYu1HcNnl2kVnPFWQIRjkC+XGaoT07mfJL24u2Dc0W/NlpUd31QLtNroNXL1yL1sxUMvrqZRKvf+k6UKTpRWPfBLdmbK4gLYNE5MM
x-ms-exchange-antispam-messagedata: wkeXoTwT8l9KeVlM4KwOLdevvcyAlYH80B+VlP1iQ2SPU/mHjIkMvOqtNV11vrETDwOL/QilMeLYNAJ9Ku6YEr3m59dm85oMLit6slSfAEwpJcPwcYtwhEgBKYZV20CnsQxIdQQSNRS4D5Ad/lSuzg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A865641BD18F994A8CF2539F4C858DE0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121c2f3d-a094-446c-8189-08d7cc9694af
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 06:19:00.6026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsoILaCyCL1TZXAK8g3GPS8W/juipVoflRqcJeHxXmKLTtC0a/+d4WMUlsLjDzTxyF/4ip4Dak04JfTToLuGiEtGCMlFEg/jajBE/kzK/Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5370
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_01:2020-03-19,2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=840 lowpriorityscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200026
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTE5IGF0IDE4OjUwIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCAxNiBNYXIgMjAyMCAxNzo1MDozNSArMDIwMCwgQWxleGFuZHJ1IEFyZGVsZWFuIHdy
b3RlOg0KPiA+IFRoaXMgY2hhbmdlIGFkZHMgdGhlIGJpbmRpbmcgZG9jIGZvciB0aGUgQUQ5NDY3
IEFEQy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhh
bmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvaWlv
L2FkYy9hZGksYWQ5NDY3LnlhbWwgICAgICAgICAgfCA2NSArKysrKysrKysrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxh
ZDk0NjcueWFtbA0KPiA+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtl
cm5lbC5vcmc+DQoNCkhleSBSb2IsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCkNhbiBJIGdl
dCB5b3VyIGF0dGVudGlvbiB0byBwYXRjaCA2LzggaW4gdGhpcyBzZXJpZXM/DQoNClRoaXMgc2V0
IGNvbnRhaW5zIDIgZHJpdmVycywgc28gMiBiaW5kaW5ncy4NCg0KVGhhbmtzDQpBbGV4DQo=
