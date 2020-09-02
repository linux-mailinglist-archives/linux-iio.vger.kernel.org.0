Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B2325A75F
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 10:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIBIJl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 04:09:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26648 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgIBIJj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2020 04:09:39 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08283Wnk021036;
        Wed, 2 Sep 2020 04:09:10 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00128a01.pphosted.com with ESMTP id 337kx6b6k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 04:09:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzP/hpGDVTIh9cc4aYSZOPiUoKb1a+G8I4rwmojrlx05fW0VQvsAiDyim+zJrXdbAH//80eENegCNX8rXCjlRHkLVzQEiTTeXC0lnQy3FQYuW7+Qy0gQ82Vv2Ad+Nuwae2tAnmQUQoF0Dv/n4UmxAc9Ba6I5SBHKNgN/BU1dyGZfBg9lYiTejbGUBG9nJV2TrAK0qhgUx19ZS4G+P79d5G54Hs3eRrv7LOywS5oOWZ7pHG1q2XDwBzx/haTGwJkC7KON7YKbnrRWwn044y9Rd13r4tb2d+OMk1gnzHxjNqwxZzrEqO5gzJ13FIGAEE1FU0++KoTxnx0dNtpsiZRHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWKdqliCdO7/5eZez3grtnnTLbTy8FtgfKRx3jVOhsw=;
 b=iAROA2yKxTVn7SL92kIuY8HvQVuushc+fIIcFU664TCQWTitg8JDltKidqDVckALyQtLUEjqBdfqEtH9NPFb4M37p/DYTIAz/HdUXy+cMbhFH+Q/dKN+3o6h6OKjL7Wf82RowB8ODUbn3FCod3oDNvSP6SdbSY8uE8yLLYuPoH18d7q6m2Gsymq3kZrVWKrm8aQrGVk53aZXI1N23/qPrDYQhdMEtK712ZyJoHVQN/O8RhduFY7ZRni9rE8CETcl10/stmUMbT9VRZ9pd1YuHwWQtDQhqeLBe73R7inM5ZGrw+AkMjowJLlwYUbY93g+k8n9dyEGvU200B8Z2dan+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWKdqliCdO7/5eZez3grtnnTLbTy8FtgfKRx3jVOhsw=;
 b=rapTQG7OicJ48U6FkOzzw2moAgI28KncHF7dy4pcjRoHvIxG91TbzwRbtfuQa+YqCF3Pp6dDXLVuov+I2zAxG1EVT1shn3NrrTnrC3IETqRF1s/Fa68ofUvCIxAuyizMd2c1IOctmHp/NS9i4OYnCdKeoRNgCO3VC9MSF/A/LiA=
Received: from BN6PR03MB2596.namprd03.prod.outlook.com (2603:10b6:404:56::13)
 by BN3PR03MB2323.namprd03.prod.outlook.com (2a01:111:e400:7bbb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 08:09:06 +0000
Received: from BN6PR03MB2596.namprd03.prod.outlook.com
 ([fe80::316b:48fd:9ee7:85c1]) by BN6PR03MB2596.namprd03.prod.outlook.com
 ([fe80::316b:48fd:9ee7:85c1%10]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 08:09:05 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     William Sung <william.sung@advantech.com.tw>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Subject: RE: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
Thread-Topic: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
Thread-Index: AQHWedmTV7eSUUrgC06reX0RtWg5DalQ7EqAgAEzv4CAABWJAIAC0+SA
Date:   Wed, 2 Sep 2020 08:09:05 +0000
Message-ID: <BN6PR03MB25968259EBEAD55E040367308E2F0@BN6PR03MB2596.namprd03.prod.outlook.com>
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
 <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
 <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
In-Reply-To: <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYldobGJtNWxjbWxjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTA1TURFek56UTNNeTFsWTJZekxURXhaV0V0T1RBMFppMDBPRGc1?=
 =?utf-8?B?WlRjM1kyUmtaV05jWVcxbExYUmxjM1JjT1RBeE16YzBOelV0WldObU15MHhN?=
 =?utf-8?B?V1ZoTFRrd05HWXRORGc0T1dVM04yTmtaR1ZqWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STBNekl6SWlCMFBTSXhNekkwTXpVd056YzBNelkzTlRNeU56RWlJR2c5SW0x?=
 =?utf-8?B?RlZsSjNXbVpXVDJsMFFVZHlibFJ1YjJ0c2JHSkZVSEI1TkQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUWpOU1YzUlRRVWxJVjBGWGNDOUJLeTlFZURCSU1H?=
 =?utf-8?B?RnVPRVEzT0ZCSVVXWlJSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQk9IcFJXR0YzUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf: true
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ded1861-eec1-4ead-5895-08d84f177613
x-ms-traffictypediagnostic: BN3PR03MB2323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN3PR03MB2323106E5B72B588C32A10568E2F0@BN3PR03MB2323.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WiP8R56rpEZx5rGAte1IQ6neLPcHDAGB8hzKOe+JuoMAeTSL//cu+sE43nZDN/406ERHd8/Lbw5A0nthEQBXbeyyQgsfZmqCAP6U5t9lK+Ylbd9I9S+6Qhq50wXmpvSaBe+NZPcUbMwAOA5cVp0ba6NKeXIMnxPYqYILwOfJC/HVFH/QpZAKar7CR5GJo2s+UtlcSY8uRmLTX5/5F0XWtOfaOLZCthvl5eZCpi/b3rOgu3XYGHaB4qUtphsGtlG0/tfBqsJjcRXBb4mTHkgHfHWlwTQ4pvLLyGghKvzi1CP5kQ0u0rM39Fc3s21ZCre0+XUtLYBsw7CX3BVI8zH5SqO+m4WHVI7hkrcIUw9g0fdieMzViS+FVJlHA1A3f8wurbjvpYjFwCzjycy8xR79Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB2596.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(53546011)(6506007)(8936002)(19627235002)(316002)(33656002)(55016002)(966005)(26005)(2906002)(186003)(9686003)(76116006)(52536014)(66946007)(66556008)(66476007)(66446008)(6636002)(64756008)(71200400001)(8676002)(86362001)(4326008)(54906003)(83380400001)(110136005)(5660300002)(7696005)(66574015)(478600001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rXrrmAsaXH4Opium4WK+kT6uJNq5oTC9H29Zwt8E3GJ8Zzisd5dB+ydkOlngjz3Q9IhL3XkxiIUqLWIWwqthrL0a7ABUGz4hQxr3/52Q1HQTlg1TWDMaAaUhJ3ij83vnGZTU3OHksgSeOYtXV8Ge/rWDX7MyO8/gFAD8eS2ELe+R5LQtymIrgBV4T4eprHhhi+RgaHy2F5+eBa/Dw9HcNHIf0CumI5uih1iogUZRmPLM0o0k2/2c87GMkeGwHWYG3FlVAYQcdXrhxPZZ8LoeFBfx8pRdD9ZLkKEqARkJ0A70fAF3nF6b2DlTD/Bdg8DX5QHFflNN2Bsl0xlX5lxafLAqMj6aiV6/HiBLHBq6aFd9cmxETkO7ZGSx56HIq0a1PtmF0u8kFCZTU1AG2JnWKtPDHpONJZra8Z/Kv/aen5QCTTtogkJ6qaeA/V4Ik5QXPdftUwBhMOdHhGyhI0BxV8TW4ZpqLjVX1929/Lx9E5nKQKbvDncuyPzwWwJquCpZbaTHBMGoibZ2SclzXRgY/reBONpxpz+N4NoucnFecwMQHKQuuTEfmohieSsOTefsU3EqrJQty75u0gu35jGJyt02ue2D3ECwYD06sXrBEPgouAWxqejULqKroiEXrextPDY4HKZyt4VCclrVH58C5Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR03MB2596.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ded1861-eec1-4ead-5895-08d84f177613
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 08:09:05.4767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNYYPAC8ryy4CnBGb9GqQPre7eHabLiBzjktLpsaMgX6l/QwC07JH4m9gAKKcg1TvrIBRrH4v/iQLiNsdVkwTLGihk8ApJZw82V3aBzEPOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2323
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbnRhZywgMzEuIEF1Z3VzdCAyMDIw
IDE0OjQ2DQo+IFRvOiBBY2VMYW4gS2FvIDxhY2VsYW4ua2FvQGNhbm9uaWNhbC5jb20+OyBBcmRl
bGVhbiwgQWxleGFuZHJ1DQo+IDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gQ2M6
IFdpbGxpYW0gU3VuZyA8d2lsbGlhbS5zdW5nQGFkdmFudGVjaC5jb20udHc+OyBMYXJzLVBldGVy
IENsYXVzZW4NCj4gPGxhcnNAbWV0YWZvby5kZT47IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFl
bC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47DQo+IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5l
bC5vcmc+OyBIYXJ0bXV0IEtuYWFjayA8a25hYWNrLmhAZ214LmRlPjsNCj4gUGV0ZXIgTWVlcndh
bGQtU3RhZGxlciA8cG1lZXJ3QHBtZWVydy5uZXQ+OyBsaW51eC1paW8gPGxpbnV4LQ0KPiBpaW9A
dmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz47DQo+IENhbXBpb24gS2FuZyA8Q2FtcGlvbi5LYW5nQGFkdmFudGVj
aC5jb20udHc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlpbzogZGFjOiBhZDU1OTNyOiBEeW5h
bWljYWxseSBzZXQgQUQ1NTkzUiBjaGFubmVsDQo+IG1vZGVzDQo+IA0KPiBPbiBNb24sIEF1ZyAz
MSwgMjAyMCBhdCAyOjI4IFBNIEFjZUxhbiBLYW8gPGFjZWxhbi5rYW9AY2Fub25pY2FsLmNvbT4N
Cj4gd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBpcyBtYWlubHkgZm9yIEFkdmFudGVjaCdzIFVOTy00
MjBbMV0gd2hpY2ggaXMgYSB4ODYtYmFzZWQNCj4gcGxhdGZvcm0uDQo+ID4gVGhpcyBwbGF0Zm9y
bSBpcyBtb3JlIGxpa2UgYSBkZXZlbG9wbWVudCBwbGF0Zm9ybSBmb3IgY3VzdG9tZXJzIHRvDQo+
ID4gY3VzdG9taXplIHRoZWlyIHByb2R1Y3RzLCBzbywgc3BlY2lmeSB0aGUgY2hhbm5lbCBtb2Rl
cyBpbiBBQ1BJIHRhYmxlDQo+ID4gaXMgbm90IGdlbmVyaWMgZW5vdWdoLCB0aGF0J3Mgd2h5IFdp
bGxpYW0gc3VibWl0IHRoaXMgcGF0Y2guDQo+ID4NCj4gPiBBcmUgdGhlcmUgb3RoZXIgd2F5cyB0
byBzcGVjaWZ5IG9yIHBhc3MgdmFsdWVzIHRvIHRoZSBtb2R1bGUgd2l0aG91dA0KPiA+IHVzaW5n
IG1vZHVsZSBwYXJhbWV0ZXJzPw0KPiA+IEl0J3MgZ29vZCBpZiB3ZSBjYW4gbGV2ZXJhZ2Ugc3lz
ZnMsIGJ1dCBJIGRvbid0IGtub3cgaWYgdGhlcmUgaXMgb25lDQo+ID4gZm9yIHRoaXMgc2NlbmFy
aW8uDQo+IA0KPiBDYW4gd2UgcHJvdmlkZSBEVCBiaW5kaW5ncyBmb3IgdGhhdCBhbmQgdXNlIHRo
ZW4gaW4gQUNQST8gQUNQSSBoYXMgYSBwb3NzaWJpbGl0eQ0KPiB0byByZXVzZSBEVCBwcm9wZXJ0
aWVzIGFuZCBjb21wYXRpYmxlIHN0cmluZ3MgWzFdLiBBcyBmYXIgYXMgSSBjYW4gc2VlIHRoZSBk
cml2ZXINCj4gdXNlcyBmd25vZGUgQVBJLCBzbyBpdCBzdXBwb3J0cyBBQ1BJIGNhc2UgYWxyZWFk
eSBbMl0uIFNvLCB3aGF0IHByZXZlbnRzIHlvdSB0bw0KPiB1dGlsaXplICdhZGksbW9kZScgcHJv
cGVydHk/DQo+IA0KPiBBbHNvLCB3ZSBhY2NlcHQgZXhhbXBsZXMgb2YgQVNMIGV4Y2VycHQgaW4g
bWV0YS1hY3BpIHByb2plY3QgWzNdLiBJdCBoYXMgYWxyZWFkeQ0KPiBwbGVudHkgb2YgZXhhbXBs
ZXMgWzRdIGhvdyB0byB1c2UgUFJQMDAwMSBmb3IgRElZIC8gZGV2ZWxvcG1lbnQgYm9hcmRzLg0K
PiANCj4gU28sIHRha2UgYWxsIHRvZ2V0aGVyIEkgdGhpbmsgdGhpcyBwYXRjaCBpcyBzaW1wbGUg
cmVkdW5kYW50Lg0KPiANCj4gWzFdOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvZmlybXdhcg0KPiBlLWd1aWRlL2Fj
cGkvZW51bWVyYXRpb24uaHRtbCpkZXZpY2UtdHJlZS1uYW1lc3BhY2UtbGluay1kZXZpY2UtDQo+
IGlkX187SXchIUEzTmk4Q1MweTJZIW9lMGJWd0UtDQo+IEQ4WTZRaVdZVTA2cHd4Y2xHU2dGcEZR
MTBSZG96eTVwQ0taWW1RM1N2VHZFbjhPeWphTDFlZm9qUnFyb3lnJA0KPiBbMl06IGh0dHBzOi8v
dXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS45
LQ0KPiByYzMvc291cmNlL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZGFj
L2FkNTU5MnIudHh0X187ISFBM05pOA0KPiBDUzB5Mlkhb2UwYlZ3RS0NCj4gRDhZNlFpV1lVMDZw
d3hjbEdTZ0ZwRlExMFJkb3p5NXBDS1pZbVEzU3ZUdkVuOE95amFMMWVmcl9UVEU0Q1ENCj4gJA0K
PiBbM106IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdGh1Yi5jb20vd2Vz
dGVyaS9tZXRhLQ0KPiBhY3BpX187ISFBM05pOENTMHkyWSFvZTBiVndFLQ0KPiBEOFk2UWlXWVUw
NnB3eGNsR1NnRnBGUTEwUmRvenk1cENLWlltUTNTdlR2RW44T3lqYUwxZWZwWm5RamdCZw0KPiAk
DQo+IFs0XTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0aHViLmNvbS93
ZXN0ZXJpL21ldGEtDQo+IGFjcGkvdHJlZS9tYXN0ZXIvcmVjaXBlcy1ic3AvYWNwaS10YWJsZXMv
c2FtcGxlc19fOyEhQTNOaThDUzB5Mlkhb2UwYlZ3RS0NCj4gRDhZNlFpV1lVMDZwd3hjbEdTZ0Zw
RlExMFJkb3p5NXBDS1pZbVEzU3ZUdkVuOE95amFMMWVmcXB6RGVSN0ENCj4gJA0KPiANCj4gUC5T
LiBKb25hdGhhbiwgaXQgc2VlbXMgdGhpcyBkcml2ZXIgaGFzIGFydGlmaWNpYWwgQUNQSSBISUQu
IFdlIHByb2JhYmx5IGhhdmUgdG8NCj4gcmVtb3ZlIGl0LiBIb3dldmVyLCBBRFMgaXMgaW5kZWVk
IHJlc2VydmVkIGZvciBBbmFsb2cgRGV2aWNlcyBpbiBQTlAgcmVnaXN0cnkuDQo+IENhbiB3ZSBo
YXZlIEFEJ3Mgb2ZmaWNpYWwgYW5zd2VyIG9uIHRoaXM/DQo+IENjJ2luZyBhZGRpdGlvbmFsIEFE
IHBlb3BsZS4NCg0KQWdyZWVkLCB0aGlzIElEIHdhcyBjaG9zZW4gdW5kZXIgdGhlIFBOUCBJRCBW
ZW5kb3IgU3BhY2UgZm9yIEFuYWxvZyBEZXZpY2VzIEluYy4NCkRheXMgYmFjaywgSSBkaWQgYSBx
dWljayBrZXJuZWwgZ3JlcCwgYW5kIHRoZXJlIGFyZSBtYW55IGRyaXZlcnMgd2hpY2ggdXNlIHRo
ZSAzLWxldHRlcg0KUE5QIElEIGFzIGFjcGlfZGV2aWNlX2lkLiBTbywgSSB0aG91Z2h0IHRoaXMg
YmVpbmcgbm90IGFuIGlzc3VlLg0KSSdtIGFnYWluc3QgcmVtb3ZpbmcgaXQgc2luY2UgSSBrbm93
IHBlb3BsZSBzaGlwcGluZyB0aGlzIGluIHRoZWlyIEFDUEkgdGFibGVzIGFscmVhZHkuDQoNClJl
Z2FyZGluZyBBQ1BJIERTRCBjdXN0b21pemF0aW9uLCBvbmUgd2F5IHRvIGRvIHRoaXMgaXMgdG8g
bW92ZSB0aGlzIGludG8gdGhlIEJJT1MuDQpUaGlzIHdheSB0aGUgcGFydGljdWxhciBwaWVjZSBv
ZiBIVyBjYW4gYmUgY3VzdG9taXplZCByYXRoZXIgdGhhbiBtYW5hZ2UgSFcgDQpjb25uZWN0aW9u
cyBpbiBzb2Z0d2FyZS4NCg0KU29ycnkgZm9yIHRoZSBtaXNmb3JtYXR0ZWQgZW1haWwgcmVwbHku
DQoNCj4gDQo+ID4gMS4NCj4gPg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly93d3cuYWR2YW50ZWNoLmNvbS9wcm9kdWN0cy85YTBjYzU2DQo+ID4gMS04ZmMyLTRlMjItOTY5
Yy05ZGY5MGEzOTUyYjUvdW5vLTQyMC9tb2RfMmQ2YTU0NmItMzllMy00YmM0LQ0KPiBiYmY0LWFj
ODkNCj4gPiBlNmI3NjY3Y19fOyEhQTNOaThDUzB5Mlkhb2UwYlZ3RS0NCj4gRDhZNlFpV1lVMDZw
d3hjbEdTZ0ZwRlExMFJkb3p5NXBDS1pZbQ0KPiA+IFEzU3ZUdkVuOE95amFMMWVmcC1lWnFiY1Ek
DQo+IA0KPiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0K
DQpCZXN0IFJlZ2FyZHMsDQpNaWNoYWVsDQoNCkFuYWxvZyBEZXZpY2VzIEdtYkgNCk1pY2hhZWwg
SGVubmVyaWNoICAgICAgICAgICAgICAgICAgICAgICANCk90bC1BaWNoZXIgU3RyYXNzZSA2MC02
NA0KRC04MDgwNyBNdWVuY2hlbjsgR2VybWFueQ0KbWFpbDogbWljaGFlbC5oZW5uZXJpY2hAYW5h
bG9nLmNvbQ0KaHR0cDovL3d3dy5hbmFsb2cuY29tDQoNClNpdHogZGVyIEdlc2VsbHNjaGFmdCBN
w7xuY2hlbiwgUmVnaXN0ZXJnZXJpY2h0IE3DvG5jaGVuIEhSQiA0MDM2OCwNCkdlc2Now6RmdHNm
w7xocmVyOiBTdGVmYW4gU3RleWVybCwgVGhvbWFzIEVkd2FyZCBDcmliYmVuLCBNaWNoYWVsIFBh
dWwgU29uZGVsDQo=
