Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55681A0A07
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 11:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgDGJ0w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 05:26:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10154 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbgDGJ0v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 05:26:51 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0379HKqp028008;
        Tue, 7 Apr 2020 05:26:24 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-00128a01.pphosted.com with ESMTP id 306q55hvwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 05:26:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHNCwr1ZibTU/QYUg6clILTHRB/ggk0exl6Kz8w41RUfqQAYP9eEa7neMfbeNbsTwVdtcwAz6UtEBJhSCuAlHxgKzF6fR6kB/xmo7EcOoMP5IV/UXyApZo/EZS4gtQJKHLz5D2FtQKx9HBUecol7NaZYKDz06XFkk4plK3EWlozCPYUviISFW95EBb58T9ZUXYb5MYmhBcc1rJ4nRYZ9MXWDOjjv+bCBdrMMkyY+FLTD+uSj9gzm4qlMWJDYMEj059LEsAfVIMds5A00JYkJyUeosqQ+V7NhkEyGvh9sEIe0+KlO7tXbJv4IOrQdnW418B7iIDOlUdZ2dhbvVGHMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOxgqJ928QlXYYiZL9/fpTChy16rJuxu5sgcUbAMeP4=;
 b=NEqf9x5D8ztonVdUnQo0XE248wTnzBWLuNQp2CjB9cgLxzRmRtIN+LwgB/NuJwo2KUtIcNJn5tKbNHQWW7TRq4EK9xBI+kaYThKcCbn16CIcHrCADAgEYKdxcVFLB1Lwkte75KZUw6rwv4UEm2so1c5lJhTrbrLUBsNys9PbPH1+UahJduHhFViTYX9bHOzAjC/fvN92rAmr5Pw5PkdBgsiD4BAisdgj5CbhCARnmUrlpSRNJ3nDfnrC+jkxgI5VHv95ngiOAdk5tYyzDQquveaC2MrGApUiYn2vRWlAIu9yG5WeIW3KfRppBv4qdL/HqsCd6YKsmR9DdxfMjqUXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOxgqJ928QlXYYiZL9/fpTChy16rJuxu5sgcUbAMeP4=;
 b=DMNeNbjtxvoVmISQ+ptjNz4JAM2uQZXP+AvT+3mrLmwqQnn1HoyKK7MpqyAJUoRW7Cnuczp8OUUOsdI8KorYnbKDxudL7VdPM1+OLLhdJUMjQoZ+h6K6OjMxEZyFRTNCY2dh100rRo+h8COq2W1ktH4ut5MC6v/cJXGndGc5cx0=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2659.namprd03.prod.outlook.com (2603:10b6:404:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Tue, 7 Apr
 2020 09:26:22 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 09:26:22 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v4 5/6] iio: imu: Add support for adis16475
Thread-Topic: [PATCH v4 5/6] iio: imu: Add support for adis16475
Thread-Index: AQHWDCVkOfz1b8oGSEWNSpsmzzycs6hsRgOAgAD0LqCAACjKAIAAAJRQ
Date:   Tue, 7 Apr 2020 09:26:22 +0000
Message-ID: <BN6PR03MB33475380CFB1AD5B50026A6A99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200406150846.878-1-nuno.sa@analog.com>
 <20200406150846.878-6-nuno.sa@analog.com>
 <CAHp75VeK8K0WHK3gDwyT3ZAaMaVdfZ5xVG94JY4O8fd2U0HEHg@mail.gmail.com>
 <BN6PR03MB33476ECFB3F8454CC6C67F0E99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
 <CAHp75VcOxjnNRetQxUR=8Z-WA=V6rzAFwCfhjNCmjQE3hgAEEA@mail.gmail.com>
In-Reply-To: <CAHp75VcOxjnNRetQxUR=8Z-WA=V6rzAFwCfhjNCmjQE3hgAEEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpEWTNOMlkyWWpZdE56aGlNUzB4TVdWaExUaGhORFV0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHUTJOemRtTm1JM0xUYzRZakV0TVRGbFlTMDRZ?=
 =?utf-8?B?VFExTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTkRjNE5T?=
 =?utf-8?B?SWdkRDBpTVRNeU16QTNNalV4T0RBek16QXhOVEV6SWlCb1BTSjVhSHBYWmxC?=
 =?utf-8?B?UmNsWmlNa3R0TkdGTk5reDRRM1Z5UVc1QlVVazlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVTktjSFpIV1habmVsZEJXblZLUlVWR2NFdElNRmh0Tkd0UlVW?=
 =?utf-8?B?ZHJiMlpTWTBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVFYxUjBSWFFVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-originating-ip: [2001:a61:2557:2e01:d4ab:ab:35c7:53e6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac9a4c9b-4a2d-4bf6-2fb5-08d7dad5bca5
x-ms-traffictypediagnostic: BN6PR03MB2659:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB2659FF18C8D846E1D5B04CA599C30@BN6PR03MB2659.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(7696005)(6506007)(4326008)(6916009)(55016002)(9686003)(81166006)(52536014)(33656002)(86362001)(478600001)(5660300002)(8936002)(66446008)(54906003)(64756008)(186003)(76116006)(66476007)(53546011)(107886003)(8676002)(66946007)(316002)(71200400001)(2906002)(81156014)(66556008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cOKmGQqxR+9LBPz1yewTpJxFoECVqpnwFVA7w1pcP+UT/8vtQKoAKBcg41aGkaeV0MBC60Vd4RRDq6EvuYYHE0Un499nmYPf7GVC9KgKKpA5MCYYZpKsvp9nHtP0qzCW8tCkxS2OtnV944njHyihkUoWm5HsXWfhPa670Vr/QgDX2hQTLzhiQr/dBB+Tm0XM4INrbpGWljQwF9KiAFs7DKpBiLXTfP9xfiNxkIkNVZtw4EudvpPfdnwqAyRrHKDAoC3ekqAFqcaCJwqjXOudjCzEeHpEOZgCi0C2ErZHXdAgBdRju0XUzQVzV/sPiGCnUU++jrw/9zAz6jCdyWYGSBUajSTWZCEMAaBmKxjrIj2fFtNfhlLRg7aGFUXCzKdyov1eLGdD7I1u2/iwC2aIN4e/8/lJrseUY4474B9xoKbktkUFl6/0e0nTbHq93mXL
x-ms-exchange-antispam-messagedata: KjLse2iJKlR8AghXiRMRWUJuu8r9N1yH2qn4D7v0VAOycqkqgjig3G7Mx+ZqLVsoWeSpqTkqyh566gdz6gUanEoVFmR5IFlkX7w0tq3GBIXxzoWVlpFrdA+63Ivcj/ldfua+pGlm9lSis8TfJj/qUdWiWcL+gm4lIxt5BvKZRSaYBQYwLv0j2A+QsdTLEPPVvdr9SXpsFv3Bzf43miLK6A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9a4c9b-4a2d-4bf6-2fb5-08d7dad5bca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 09:26:22.2836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjM0B4RXf2r6zTEqzQCr2W95SXZDqPwR77MTJTjzfkCGXvNXCe+CAd30RddfN27OiHzdClaway6SzRzSOPsydA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2659
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_01:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070079
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNl
bnQ6IERpZW5zdGFnLCA3LiBBcHJpbCAyMDIwIDExOjE5DQo+IFRvOiBTYSwgTnVubyA8TnVuby5T
YUBhbmFsb2cuY29tPg0KPiBDYzogbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
PjsgZGV2aWNldHJlZQ0KPiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBD
YW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsNCj4gSGFydG11dCBLbmFhY2sgPGtuYWFjay5oQGdt
eC5kZT47IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPjsgUGV0ZXIgTWVl
cndhbGQtU3RhZGxlciA8cG1lZXJ3QHBtZWVydy5uZXQ+OyBSb2INCj4gSGVycmluZyA8cm9iaCtk
dEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47DQo+IEFy
ZGVsZWFuLCBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRlbGVhbkBhbmFsb2cuY29tPjsgSGVubmVy
aWNoLA0KPiBNaWNoYWVsIDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY0IDUvNl0gaWlvOiBpbXU6IEFkZCBzdXBwb3J0IGZvciBhZGlzMTY0NzUN
Cj4gDQo+IE9uIFR1ZSwgQXByIDcsIDIwMjAgYXQgMTA6MjYgQU0gU2EsIE51bm8gPE51bm8uU2FA
YW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4gPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hl
dmNoZW5rb0BnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBNb250YWcsIDYuIEFwcmlsIDIwMjAgMTg6
MjANCj4gPiA+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiA+ID4gQ2M6IGxp
bnV4LWlpbyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IGRldmljZXRyZWUNCj4gPiA+IDxk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5l
bC5vcmc+Ow0KPiA+ID4gSGFydG11dCBLbmFhY2sgPGtuYWFjay5oQGdteC5kZT47IExhcnMtUGV0
ZXIgQ2xhdXNlbg0KPiA+ID4gPGxhcnNAbWV0YWZvby5kZT47IFBldGVyIE1lZXJ3YWxkLVN0YWRs
ZXIgPHBtZWVyd0BwbWVlcncubmV0PjsNCj4gUm9iDQo+ID4gPiBIZXJyaW5nIDxyb2JoK2R0QGtl
cm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsNCj4gPiA+IEFy
ZGVsZWFuLCBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRlbGVhbkBhbmFsb2cuY29tPjsgSGVubmVy
aWNoLA0KPiA+ID4gTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT4NCj4gPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNS82XSBpaW86IGltdTogQWRkIHN1cHBvcnQgZm9yIGFk
aXMxNjQ3NQ0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgQXByIDYsIDIwMjAgYXQgNjoxMCBQTSBOdW5v
IFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPiB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4gPiA+ID4g
KyAgICAgICBmb3JfZWFjaF9zZXRfYml0KGJpdCwgaW5kaW9fZGV2LT5hY3RpdmVfc2Nhbl9tYXNr
LA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgaW5kaW9fZGV2LT5tYXNrbGVuZ3Ro
KSB7DQo+ID4gPg0KPiA+ID4gT25lIGxpbmU/DQo+ID4gPg0KPiA+DQo+ID4gSXQgZ29lcyBiZXlv
bmQgODAgY29sIGxpbWl0Li4uIEkga25vdyBJIGNvdWxkIGluaXRpYWxpemUgdGhlc2UgdG8gc29t
ZSBsb2NhbA0KPiBjb25zdCBidXQuLi4NCj4gDQo+IFRoYXQncyB3aHkgcXVlc3Rpb24gbWFyayBp
cyB0aGVyZS4NCj4gTm9uZXRoZWxlc3MsIGlmIGl0IH4yLTMgY2hhcmFjdGVycyBtb3JlLCBJIHdv
dWxkIGxlYXZlIGl0IG9uIG9uZSBsaW5lIGFueXdheS4NCj4gDQo+IEpGWUk6IHJlYWRhYmlsaXR5
IGhhcyBhIHByaW9yaXR5IG92ZXIgODAgbGltaXQuDQo+DQoNClRoYW5rcyEgSSB3b3VsZCBzYXkg
aXQgYWxzbyBkZXBlbmRzIG9uIHRoZSBtYWludGFpbmVyIChub3Qgc3VyZSk/IFNvbWUgYXJlIG1v
cmUNCnN0cmljdCBhYm91dCBjaGVja3BhdGNoLi4uDQpCdHcsIHRoZSBsaW5lIHdpbGwgaGF2ZSA4
NCBpZiBvbmUgbGluZXIuLi4NCg0KPiA+ID4gPiArICAgICAgIH0NCj4gDQo+IC4uLg0KPiANCj4g
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHNjYWxlZF9vdXRfZnJlcSA8IDE5MDAg
fHwgc2NhbGVkX291dF9mcmVxID4gMjEwMCkgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRldl9lcnIoZGV2LA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIkludmFsaWQgdmFsdWU6JXUgZm9yIGFkaSxzY2FsZWQtb3V0cHV0
LWh6IiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNj
YWxlZF9vdXRfZnJlcSk7DQo+ID4gPg0KPiA+ID4gV2hlbiB0aGVyZSBpcyBubyBwcm9wZXJ0eSBv
ciBwcm9wZXJ0eSBoYXMgYSB2YWx1ZSAwIHRoaXMgbWVzc2FnZSBjYW4ndA0KPiA+ID4gdGVsbCB0
aGUgZGlmZmVyZW5jZS4NCj4gPiA+IFBlcmhhcHMgeW91IGhhdmUgdG8gY2hlY2sgcmV0dXJuIGNv
ZGUgZnJvbQ0KPiBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoKQ0KPiA+ID4gY2FsbC4NCj4gPiA+
DQo+ID4NCj4gPiBXZWxsLCBJIHRoaW5rIHdlIGRvbid0IHJlYWxseSBuZWVkIHRvLiBJZiB0aGUg
c3luYyBtb2RlIGlzIHNjYWxlZCwgdGhlbiB0aGlzDQo+IHByb3BlcnR5IGlzIG1hbmRhdG9yeQ0K
PiA+IChhbmQgdGhpcyBpcyBzdGF0ZWQgaW4gdGhlIGJpbmRpbmdzKS4gU28sIEkgZG9uJ3QgcmVh
bGx5IGNhcmUgaWYgdGhlIHByb3BlcnR5IGlzDQo+IG5vdCB0aGVyZSBvciBpZiBpdCdzIGp1c3QN
Cj4gPiBhIHdyb25nIHZhbHVlLiBXZSBzaG91bGQgZmFpbCBlaXRoZXIgd2F5IGFuZCBJJ20gbm90
IHN1cmUgYW4gZXh0cmEgaWYgd2l0aA0KPiBzb21lIG90aGVyIG1lc3NhZ2Ugd2lsbA0KPiA+IGdp
dmUgdXMgdGhhdCBleHRyYSB2YWx1ZS4uLg0KPiANCj4gVXAgdG8gbWFpbnRhaW5lciAoSSBoYXZl
IG5vIHN0cm9uZyBvcGluaW9uIGFib3V0IHRoaXMpDQo+IA0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICB9DQo+IA0KPiAuLi4NCj4gDQo+ID4gPiA+ICsgICAgICAgLyoNCj4gPiA+ID4g
KyAgICAgICAgKiBJdCBpcyBwb3NzaWJsZSB0byBjb25maWd1cmUgdGhlIGRhdGEgcmVhZHkgcG9s
YXJpdHkuIEZ1cnRoZXJtb3JlLA0KPiB3ZQ0KPiA+ID4gPiArICAgICAgICAqIG5lZWQgdG8gdXBk
YXRlIHRoZSBhZGlzIHN0cnVjdCBpZiB3ZSB3YW50IGRhdGEgcmVhZHkgYXMgYWN0aXZlDQo+IGxv
dy4NCj4gPiA+ID4gKyAgICAgICAgKi8NCj4gPiA+ID4gKyAgICAgICBpcnFfdHlwZSA9IGlycWRf
Z2V0X3RyaWdnZXJfdHlwZShkZXNjKTsNCj4gPiA+ID4gKyAgICAgICBpZiAoaXJxX3R5cGUgPT0g
SVJRRl9UUklHR0VSX1JJU0lORykgew0KPiANCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHBvbGFy
aXR5ID0gMTsNCj4gDQo+IEZvciB0aGUgc2FrZSBvZiBjb25zaXN0ZW5jeSBJIHdvdWxkIGFzc2ln
biBpcnFfZmxhZyBoZXJlIGFzIHdlbGwuDQo+DQoNClRoZSBsaWJyYXJ5IHdpbGwgZG8gaXQgYnkg
ZGVmYXVsdCwgQnV0IHRoYXQncyBtZSB1c2luZyAiaW5zaWRlIiBpbmZvLi4uIG9yIG1heWJlIGlm
DQpJIGRvY3VtZW50IHRoYXQgaW4gcGF0Y2ggMiAodGhlIHN0cnVjdCBrZXJuZWwgZG9jcykgd2Ug
d291bGQgbm90IHJlYWxseSBuZWVkIHRvDQphc3NpZ24gaXQgaGVyZT8NCg0KPiA+ID4gPiArICAg
ICAgIH0gZWxzZSBpZiAoaXJxX3R5cGUgPT0gSVJRRl9UUklHR0VSX0ZBTExJTkcpIHsNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgIHBvbGFyaXR5ID0gMDsNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
IHN0LT5hZGlzLmlycV9mbGFnID0gSVJRRl9UUklHR0VSX0ZBTExJTkc7DQo+ID4gPiA+ICsgICAg
ICAgfSBlbHNlIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoJnNwaS0+ZGV2LCAi
SW52YWxpZCBpbnRlcnJ1cHQgdHlwZSAweCV4IHNwZWNpZmllZFxuIiwNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgaXJxX3R5cGUpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+ID4gPiA+ICsgICAgICAgfQ0KPiA+ID4NCj4gPiA+IEhlcmUgaXMgdGhl
IHByb2JsZW0uIFlvdSBnb3QgdHlwZSwgYnV0IHlvdSBjb21wYXJlIGl0IHRvIGZsYWdzLiBJdCdz
DQo+ID4gPiBub3QgY29ycmVjdC4NCj4gPiA+IEFsdGhvdWdoIHZhbHVlcyBhcmUgdGhlIHNhbWUs
IHRoZSBtZWFuaW5nIGlzIGRpZmZlcmVudC4NCj4gPiA+DQo+ID4NCj4gPiBIbW0sIHRoYW5rcyEg
SG9uZXN0bHksIHRoaXMgd2FzIGNvcHkgcGFzdGUgZnJvbSBhZGlzMTY0ODAgYW5kIEkgbmV2ZXIN
Cj4gcmVhbGl6ZWQgdGhpcy4gSSB3aWxsDQo+ID4gdXNlIElSUV9UWVBFX0VER0VfUklTSU5HIGFu
ZCBJUlFfVFlQRV9FREdFX0ZBTExJTkcuIEkgZ3Vlc3Mgd2UNCj4gbmVlZCBhIHBhdGNoIGNoYW5n
aW5nIHRoaXMNCj4gPiBpbiBhZGlzMTY0ODAuLi4NCj4gDQo+IEFzIGEgc2VwYXJhdGUgcGF0Y2gs
IHllcy4NClN1cmUuLi4NCg0KVGhhbmtzIQ0KLSBOdW5vIFPDoQ0KPiAtLQ0KPiBXaXRoIEJlc3Qg
UmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
