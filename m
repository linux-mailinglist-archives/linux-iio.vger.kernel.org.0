Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D434B19AC93
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbgDANSu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 09:18:50 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:26086 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732505AbgDANSu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 09:18:50 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031DFHvP013340;
        Wed, 1 Apr 2020 09:18:27 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 302377jnu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 09:18:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNW5UxSI/9RpGKYt42LPBBs8i1Hhg3Wv4f0uH253INtAyx+hKFqXY1Z0YpKzY67+ms2qBpdRp1voE+VqJqeO1a64hbXhoSGfIl5NsvzET6AObxEmrpqVL5w06XZDGbbSfKKTkckcizUfL2tUAH1sS8SqI5ZK0F56RanC7jeawZmDwf4JrWcvwQJMPvcgnwTJLB73wLKbrwEfn4qwKsIRBc9aI4E4m6/a7TFHAxPvP+aaxB8Oeek66MkBKAHNsn9T7OV5fd4/ssNPtkza8VNzlFxHBsbkxnU8b6c10+qLicFgcWebs0smZj+eRQfPgr+jEKniIynZqI1ACYnLnAAj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgcFknfOsXg7RyugLXm5v72W6ZK02O42bARpLaDea0M=;
 b=RsXYRClnFTrAN6NOb7Z7xJkTtfcOnUz/eDeIShu4frCBuzI7GeBff4eLleXWARt5RKsXdNUPPGSZcBYJ3YYmsKdBMbkTbCw2LWeBMTa1u7e3TLzVlW9KD0i8QuwOoZIIxzVk7CqjVaJJ1RyLLiaMGBjg6JRN3sCjl2rJAIFwVDKPRc8ggX4Wt7kTix7V4Q72GRjt+vg27QctyOgfJs+9ftLg655fUzzHAZik2MaD82Xb4ZmniZrR8DH7bfv7mlrsEp7m5QZONmoLTdTbKgKoeS9yC3MNm0ufvJ5t2WMs583cdzlCwyE9GoKfFFuL4rADfap0z4s2Fk0pWIho2kXLvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgcFknfOsXg7RyugLXm5v72W6ZK02O42bARpLaDea0M=;
 b=la1IQsFa/Xop0cvGcwhys5ggtj0Zc3Rcs62/n8zAugdTXVC67oc6CiY8yFQU+6bi9uoS5kWp6oQNoY9CnHlOHFN59f4I2NR3sdqdO6ipo+FTtEr93e6zR/USHiEbkF+tdtA492WGuEXN8fFQ9Xb87UCKjuUnMiGemGOWa90FHGc=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2948.namprd03.prod.outlook.com (2603:10b6:404:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Wed, 1 Apr
 2020 13:18:25 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 13:18:25 +0000
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
Subject: RE: [PATCH v3 2/6] iio: imu: adis: Add irq mask variable
Thread-Topic: [PATCH v3 2/6] iio: imu: adis: Add irq mask variable
Thread-Index: AQHWB1JXGSpmkJ3opUGHDYpi/3D/j6hi+CsAgADjkaCAADXigIAAL4zg
Date:   Wed, 1 Apr 2020 13:18:25 +0000
Message-ID: <BN6PR03MB3347D602FA12EFBA1D32DC6499C90@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200331114811.7978-1-nuno.sa@analog.com>
 <20200331114811.7978-3-nuno.sa@analog.com>
 <CAHp75VfXS1P-EJaKERojK=-3erYi5MxyDMjfrELyY2X3PZEN1A@mail.gmail.com>
 <BN6PR03MB3347F9B31FE4E82904ED3E8C99C90@BN6PR03MB3347.namprd03.prod.outlook.com>
 <CAHp75VfowVagnG0U8N4SM5Y2ZRoRTFFtJtZgkV+XWGznhrkogg@mail.gmail.com>
In-Reply-To: <CAHp75VfowVagnG0U8N4SM5Y2ZRoRTFFtJtZgkV+XWGznhrkogg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5ESmlZV1UzWm1NdE56UXhZaTB4TVdWaExUaGhNek10Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEUXlZbUZsTjJabExUYzBNV0l0TVRGbFlTMDRZ?=
 =?utf-8?B?VE16TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTWprM05p?=
 =?utf-8?B?SWdkRDBpTVRNeU16QXlNakEzTURNd09UVTBNVFExSWlCb1BTSndVWGRJVGtO?=
 =?utf-8?B?TFdURlVVVEVyZDJ4MVdWVnllamxDY2tscVJYYzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVTm9hVUpSUmt0QmFsZEJVVVJWU1c1RE9EaHFjV1ZCVGxGcFkw?=
 =?utf-8?B?eDZlVTl3TkVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-originating-ip: [2001:a61:2422:3901:2c8d:64f0:f8a8:6170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79d5b12f-4a2f-4a5b-4635-08d7d63f2917
x-ms-traffictypediagnostic: BN6PR03MB2948:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB2948E21EC4E2D61902C3B86799C90@BN6PR03MB2948.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(366004)(52536014)(4326008)(107886003)(71200400001)(55016002)(66476007)(186003)(7696005)(76116006)(86362001)(5660300002)(66946007)(9686003)(8936002)(64756008)(2906002)(6506007)(6916009)(8676002)(81166006)(53546011)(66556008)(54906003)(33656002)(316002)(478600001)(66574012)(81156014)(66446008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TS4yXyWJ6VLIcvMLle80tU8q9Bz871IWZK6RR3lnY7bkqWUFuknJBLwM29/E7vWVieTrkdvp60wkYN1MWwr4XLaJ9x0FUyFA7ubs0R7M409t1tlgLWp4/4DH4qD0NrKLjRkq1ttaOXbq+6li9fDlj9wE87ClN/lOSIbatONttftg+yHsy2MOQvIz+WGz0Gko7CESgv8cG8U7ZZ7gbNauaNdX28ySg4MQMS6rG3Mc0TWfxCyEIWy56P9o+LD2nkfV7ZrUixtK2U1oTT6+aQZ6fZo7bEfsTLY0ZbIl2aXowDb1/XSuAP67G4c2ZQjYbq2grBdZ5+b1/c2xjmeVZrNjqz+jFHtqTwSgyKEPLZWCJ/7W4HTiNiulQYFalLd11YaX9gbAItmXQ0/9hpuE7pvHX/um7n/E+UuuRIA7d35sFlJTGNan8JtD5ZdlMmqcOGqC
x-ms-exchange-antispam-messagedata: p39YAVm5hW7OWGwNmSuonVEkcVIGGU5jaoVhRhg02mYmrsb4ZOIbuGZwWJggPekiHY7hKKTCOB/55cWivEnv0WX/MHK5MN2kPTg2zNMUix2WnBps90lEMF6VG+1703ydm7Q7ZRf/4fyF6TzSAlkuI4si0P+J0WfEmxfq0OqJT/PDlto+gDg1+1Ij2VHOf8DVeVQ0CH+YFUvzMDxHDkwQfw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d5b12f-4a2f-4a5b-4635-08d7d63f2917
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 13:18:25.5070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkuU5rc2IeHI13GpiPiqcVBythw2ydu2TPR7nlL6q5VT2Q+CLhJWjdNKnCTazG0w3C+GghUGSNLx3xqcxHo9Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2948
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010120
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNl
bnQ6IE1pdHR3b2NoLCAxLiBBcHJpbCAyMDIwIDEyOjI3DQo+IFRvOiBTYSwgTnVubyA8TnVuby5T
YUBhbmFsb2cuY29tPg0KPiBDYzogbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
PjsgZGV2aWNldHJlZQ0KPiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBD
YW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsNCj4gSGFydG11dCBLbmFhY2sgPGtuYWFjay5oQGdt
eC5kZT47IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPjsNCj4gUGV0ZXIgTWVl
cndhbGQtU3RhZGxlciA8cG1lZXJ3QHBtZWVydy5uZXQ+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtk
dEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IEFyZGVs
ZWFuLA0KPiBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRlbGVhbkBhbmFsb2cuY29tPjsgSGVubmVy
aWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzIDIvNl0gaWlvOiBpbXU6IGFkaXM6IEFkZCBpcnEgbWFzayB2YXJpYWJs
ZQ0KPiANCj4gT24gV2VkLCBBcHIgMSwgMjAyMCBhdCAxMDoyMiBBTSBTYSwgTnVubyA8TnVuby5T
YUBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiA+IEZyb206IGxpbnV4LWlpby1vd25lckB2Z2VyLmtl
cm5lbC5vcmcgPGxpbnV4LWlpby1vd25lckB2Z2VyLmtlcm5lbC5vcmc+DQo+IE9uDQo+ID4gPiBC
ZWhhbGYgT2YgQW5keSBTaGV2Y2hlbmtvDQo+ID4gPiBTZW50OiBEaWVuc3RhZywgMzEuIE3DpHJ6
IDIwMjAgMTk6NDANCj4gPiA+IE9uIFR1ZSwgTWFyIDMxLCAyMDIwIGF0IDI6NDkgUE0gTnVubyBT
w6EgPG51bm8uc2FAYW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IFRoZXJlIGFy
ZSBzb21lIEFESVMgZGV2aWNlcyB0aGF0IGNhbiBjb25maWd1cmUgdGhlIGRhdGEgcmVhZHkgcGlu
DQo+ID4gPiA+IHBvbGFyaXR5LiBIZW5jZSwgd2UgY2Fubm90IGhhcmRjb2RlIG91ciBJUlEgbWFz
ayBhcw0KPiA+ID4gSVJRRl9UUklHR0VSX1JJU0lORw0KPiA+ID4gPiBzaW5jZSB3ZSBtaWdodCB3
YW50IHRvIGhhdmUgaXQgYXMgSVJRRl9UUklHR0VSX0ZBTExJTkcuDQo+IA0KPiAuLi4NCj4gDQo+
ID4gPiA+ICtzdGF0aWMgaW50IGFkaXNfdmFsaWRhdGVfaXJxX21hc2soc3RydWN0IGFkaXMgKmFk
aXMpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAgICAgaWYgKCFhZGlzLT5pcnFfbWFzaykgew0K
PiA+ID4gPiArICAgICAgICAgICAgICAgYWRpcy0+aXJxX21hc2sgPSBJUlFGX1RSSUdHRVJfUklT
SU5HOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPg0KPiA+ID4gPiAr
ICAgICAgIH0gZWxzZSBpZiAoYWRpcy0+aXJxX21hc2sgIT0gSVJRRl9UUklHR0VSX1JJU0lORyAm
Jg0KPiA+ID4NCj4gPiA+ICdlbHNlJyBpcyByZWR1bmRhbnQuDQo+ID4gPg0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgYWRpcy0+aXJxX21hc2sgIT0gSVJRRl9UUklHR0VSX0ZBTExJTkcpIHsN
Cj4gPiA+DQo+ID4gPiBCdXQgdGhpcyBjb25kaXRpb24gcmlzZXMgcXVlc3Rpb25zLiBXaHkgaSBj
YW4ndCBjb25maWd1cmUgYm90aD8NCj4gPiA+IFdoeSBJIGNhbid0IGNvbmZpZ3VyZSBvdGhlciBm
bGFncyB0aGVyZT8NCj4gPg0KPiA+IEJvdGggeW91IGNhbid0IGJlY2F1c2UgaXQgaXMganVzdCBo
b3cgdGhlc2UgdHlwZSBvZiBkZXZpY2VzIHdvcmsuIERhdGEgaXMNCj4gcmVhZHkgZWl0aGVyDQo+
ID4gb24gdGhlIHJpc2luZyBlZGdlIG9yIG9uIHRoZSBmYWxsaW5nIGVkZ2UgKGlmIHN1cHBvcnRl
ZCBieSB0aGUgZGV2aWNlKS4uLg0KPiA+IEkgYWdyZWUgdGhpcyBjb3VsZCBjaGVjayBpZiBvbmx5
IG9uZSBvZiB0aGUgZmxhZ3MgYXJlIHNldCBpbnN0ZWFkIG9mIGRpcmVjdGx5DQo+IGNvbXBhcmlu
ZyB0aGUNCj4gPiB2YWx1ZXMgKGludmFsaWRhdGluZyBvdGhlciBmbGFncykgYnV0IEkgd291bGQg
cHJlZmVyIHRvIGtlZXAgdGhpcyBzaW1wbGUgZm9yDQo+IG5vdy4uLg0KPiA+DQo+ID4gPg0KPiA+
ID4gPiArICAgICAgICAgICAgICAgZGV2X2VycigmYWRpcy0+c3BpLT5kZXYsICJJbnZhbGlkIElS
USBtYXNrOiAlMDhseFxuIiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYWRpcy0+
aXJxX21hc2spOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4g
PiA+ICsgICAgICAgfQ0KPiA+ID4NCj4gPiA+ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiA+ID4g
K30NCj4gPiA+DQo+ID4gPiBBbmQgYWN0dWFsbHkgbmFtZSBvZiB0aGUgZnVuY3Rpb24gaXMgbm90
IGV4YWN0bHkgd2hhdCBpdCBkb2VzLiBJdA0KPiA+ID4gdmFsaWRhdGVzICpvciogaW5pdGlhbGl6
ZXMuDQo+ID4NCj4gPiBXZWxsLCB5ZXMuIEl0IGp1c3Qgc2V0cyB0aGUgbWFzayB0byB0aGUgZGVm
YXVsdCB2YWx1ZSB0byBrZWVwIGJhY2t3YXJkDQo+IGNvbXBhdGliaWxpdHkNCj4gPiB3aXRoIGFs
bCB0aGUgb3RoZXIgZGV2aWNlcyB0aGF0IGRvbid0IHN1cHBvcnQvdXNlIHRoaXMgdmFyaWFibGUu
Li4NCj4gDQo+IFBlcmhhcHMgZG9jdW1lbnRhdGlvbiBpbiBhIGNvbW1lbnQgZm9ybSBzaG91bGQg
YmUgYWRkZWQuDQo+IE1vcmVvdmVyLCBJIHJlYWxpemVkIHRoYXQgeW91IGFkZGVkIHRvIHZhcmlh
YmxlIGFuZCBmdW5jdGlvbiBtYXNrDQo+IHN1ZmZpeCB3aGlsZSBpdCdzIGFjdHVhbGx5IGZsYWcu
DQoNCldpbGwgY2hhbmdlIHRoZSBzdWZmaXggdG8gZmxhZy4uLg0KDQotIE51bm8gU8OhDQo+IC0t
DQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg==
