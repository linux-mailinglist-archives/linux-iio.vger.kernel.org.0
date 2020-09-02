Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE0225A538
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 07:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgIBF4v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 01:56:51 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:50196 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgIBF4q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2020 01:56:46 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0825tx0t011154;
        Wed, 2 Sep 2020 01:56:42 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0b-00128a01.pphosted.com with ESMTP id 337kn79vcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 01:56:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL80ksyYNj66TD2HwMAQfqX3UujY53e8wpgxVaLh/ndrRZ76jFRO/s2OZy2urE5hVaAnPV4yl5S62r2laeAx1bpxCGG+USL645/T9mIQT/N/+n91srSZtlgR1QkMVR5UgvipB/moDa4tl8C2RFYuWNN7KyHF2HV1hVs16ZcZ/Fyv2OhBDwaNuO6+oh6SPXJfhhhC5O4xV9o/ptUYNZvQSj/CtmgWvEsgusjZGdNxe7ElFgARJZhVXFf/aShg29WbZdl+6Ot5rnM84FpObzKT3L2TM8iYgA7Y9gllVMCKJHd5QHDwBCh2YLVkJFqoEx5TRtpl2lrWe2De9mPhxGqcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBmNY6Ry3wsIsN+88IUqjh8Hnls9OFs7En8vrQFZ5c0=;
 b=YHa1xdsRKCPDGr2QEs69mECTbfzIF581gkWLoMwA3usOQDwamLpWNJ/8mTBt4v0ElK8/i4VSw6YnDBdakoPzMon3m1uLZhN95DJw3SnCFh87/VwoakVu83LjnG/E+lzLpGM6/+qdwnPV8SwSjQn4Qlp6FxL5WDJ1A/Q3dj4C1FKQIAqitxAJQPGGMjpD1YevLhP4sn+26oGjOqejG98815THX56jAyAGBJih/RXqOlnutaY/yU/i/woitxw5Xyvaw4KraIUByHclUOrS5U2LE/x9hpZ5QkAr3rYXEktsdDyV6WhcsXdI5EhSMh694NYxbG0QEDUnFRERf8JvldwCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBmNY6Ry3wsIsN+88IUqjh8Hnls9OFs7En8vrQFZ5c0=;
 b=63aiH04xqbNdVr7u/jmEPfCbAfSPdzDkT76XnkNPNT1sObyRD8YDFTkiOqL4pVekB73FeQEL2Ui6RwgUXDwu3WDk7x1KXAHIxUd7swt0mHVvzyWhT/xyrcjl3GbGAIPnFm7zKto86rHITGsv2yFPOVHqofufHdxOnMHt/tckfYk=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4715.namprd03.prod.outlook.com (2603:10b6:5:181::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 05:56:41 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f457:143e:f83b:26cf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f457:143e:f83b:26cf%4]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 05:56:41 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Remove bouncing email of Beniamin Bia
Thread-Topic: [PATCH] MAINTAINERS: Remove bouncing email of Beniamin Bia
Thread-Index: AQHWfK8quei6UlSGVE2sLyLbFWlWbqlNLn6AgAIApACAAAEngIAFsALg
Date:   Wed, 2 Sep 2020 05:56:41 +0000
Message-ID: <DM6PR03MB441122FDB3323690166C21A0F92F0@DM6PR03MB4411.namprd03.prod.outlook.com>
References: <20200827201707.27075-1-krzk@kernel.org>
 <CAHp75VcnV8_SRQuiTnzzaWxfA1m37gVXfxgPkH51tbMT+-T2RA@mail.gmail.com>
 <20200829155410.6d34a8b9@archlinux>
 <CAJKOXPd78m-3jMsFRa7ySREDdx+GMZ_YHMG3AcqCHTABLBwqVA@mail.gmail.com>
In-Reply-To: <CAJKOXPd78m-3jMsFRa7ySREDdx+GMZ_YHMG3AcqCHTABLBwqVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVdGeVpHVnNaV0ZjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB4TURVMVkySTROUzFsWTJVeExURXhaV0V0WVRrNVl5MWtOREkx?=
 =?utf-8?B?T0dKbFlUWmhZbVJjWVcxbExYUmxjM1JjTVRBMU5XTmlPRGN0WldObE1TMHhN?=
 =?utf-8?B?V1ZoTFdFNU9XTXRaRFF5TlRoaVpXRTJZV0prWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhPRFEzSWlCMFBTSXhNekkwTXpRNU9UYzVPRFF5TXpJME9Ua2lJR2c5SW5r?=
 =?utf-8?B?ek1qUllaRzFYYzFwNWJGQm9VSGt3Tm1rd1ZsVlJUR2RQWXowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVhwQ1N6ZFROMWxFVjBGWlVHZHpReXRuWm5NeU1X?=
 =?utf-8?B?Y3JRM2RNTmtJcmVtSlZSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlUyeEdLMFpSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3be93a91-d4de-4b37-48c9-08d84f04f6c2
x-ms-traffictypediagnostic: DM6PR03MB4715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB4715E396C6AA39447E85AA6CF92F0@DM6PR03MB4715.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KNtj5EFU394NYec7qL3OV/WtnpUFtnu1mx3lxTaqMDglgvS5L5w+c0zU+BSxSTabbg3YJUZP6CI0zx0V1/TbACTDA0Oy4zH5V5S4PVxMOkbTRdqUHY7+APU3JAlYyDrN4+9CgS+42WFOs558EY8Yy6Q3RhvnDQ0h29hvz7vPo6IOgRtCtopUpZAKg+afNILvuXzp6JmQx84Onh/pv/Z9e7ADOmtibUcnDKiavtM/EIzPjImn1CZDIjc+LN+PNSVkK244ORTavKDmbZIOUzBsdqIPfRdIAp72SaDQxG1uxUD8AL7Cl1VVWjzepGBkpiQVP4/MeDho1UMUGIeVvzqhdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(7696005)(66946007)(76116006)(8936002)(66556008)(71200400001)(64756008)(66476007)(33656002)(316002)(55016002)(86362001)(66446008)(110136005)(4326008)(2906002)(54906003)(52536014)(83380400001)(53546011)(186003)(26005)(8676002)(9686003)(5660300002)(6506007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PJ2QW8CJ4Vb9JkRZwk6qnyCWTEt5upaVytC8+82dOuqGCTKkursdILy5QFQT0iZ5rAzPl1ep58Pe3HRBnZ8AIAhC53MeJWUpWd445NIirA4+5bt2aGOe4fXy69YCPchFcql5YVQRUHEjH9Pn70oasHVbX+u6iTAetOLQC2t07RckzeWcPlNhifHFVWq2FvDWm9sHz4Fhn3llBgkKWah1y8zdFvCRn4i0p6du3dn8czW0tZLd1XcUvBjuZyYykTgQbbg+wEWChnHg4cMj8kkNElB9Pirq5Is0J0pr4m2MfN/b4+FgSH7RthqBl/HwqH7nb8u8+DbQCjCDas44umWpccwPj1jXjA8wAfJ/FpA4tYmJrdg3NtZuCVo7fxctyqPbS6GObaUy29wy4551k+sjdp98H06HR6faxr7Jtz8xRORL/itbcYvdBcHFaBvSiwcX36QmbosWXrlaIim8ZPixRruqoCNkoQ2d93WIu+4nF3ANJ+DUGh2jytthRquxPo1mp0rIu/NSQyq+HVGygA1loqGimbZbtWedZilEyXmgLSVZQEnksVEfzQszFzvyQ7hAmptqUkW9ktd1iiY1+RgASE0juWCjzn7GV0u2bR+MdL/4y2VP9lzDPNBuxDwSTJJOGh/QQYij/PB7jOwriD7AhQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be93a91-d4de-4b37-48c9-08d84f04f6c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 05:56:41.0336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17xcBCzC4PfkBhz4XTRewHcXhmsDPgaAqEHWaz5tUI9az1VxTWujcMPYgFjwkYdLncsG6LMJ9uO8SOHMnTgHGRg88iEvjl9Sz3zk/iAErR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4715
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-01,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=881
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020055
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

W3llcywgSSBrbm93LCBiYWQtZW1haWwgZm9ybWF0LCBidXQgSSB3YW50ZWQgdGhpcyB0byBjb21l
IGZyb20gbXkgd29yayBlbWFpbF0NCg0KQXBvbG9naWVzIGFsc28gZm9yIHRoZSBkZWxheSBoZXJl
LiBUaGluZ3MgcGlsZS11cCBvbiBteSBzaWRlIGFuZCBJIGRlZmVyIHRoaW5ncyBhIGJpdC4NCg0K
VGFsa2VkIHRvIE1pY2hhZWwgSGVubmVyaWNoIGFib3V0IHRoaXMgW3NpbmNlIGhlJ3MgdGhlIG1v
cmUgc2VuaW9yIGNvbnRhY3QgYXQgQW5hbG9nXS4NCldlIGNhbiByZXBsYWNlIHRoZSBlbWFpbCBm
cm9tIEJlbmlhbWluIEJpYSB3aXRoIE1pY2hhZWwncy4NCk9yLCB3ZSBjYW4gcmVtb3ZlIHRoZSAi
T3JwaGFuIiBibG9ja3MgYW5kIGp1c3QgaGF2ZSB0aGUgY2F0Y2gtYWxsICJkcml2ZXJzL2lpby8q
L2FkKiIgY292ZXIgdGhpcyBkcml2ZXIgYW5kIG90aGVycyB0aGF0IHdlcmUgdXBzdHJlYW1lZCBi
eSBCZW5pYW1pbi4NCg0KRWl0aGVyIG9wdGlvbiBpcyBmaW5lIGZyb20gdXMuDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5l
bC5vcmc+IA0KU2VudDogU2F0dXJkYXksIEF1Z3VzdCAyOSwgMjAyMCA1OjU4IFBNDQpUbzogSm9u
YXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4NCkNjOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgSGVubmVyaWNoLCBNaWNoYWVsIDxNaWNoYWVsLkhl
bm5lcmljaEBhbmFsb2cuY29tPjsgbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
PjsgQXJkZWxlYW4sIEFsZXhhbmRydSA8YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIXSBNQUlOVEFJTkVSUzogUmVtb3ZlIGJvdW5jaW5nIGVtYWlsIG9m
IEJlbmlhbWluIEJpYQ0KDQpPbiBTYXQsIDI5IEF1ZyAyMDIwIGF0IDE2OjU0LCBKb25hdGhhbiBD
YW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPiB3cm90ZToNCg0KKC4uLikNCg0KPiA+ID4gIEFOQUxP
RyBERVZJQ0VTIElOQyBBRDcwOTFSNSBEUklWRVINCj4gPiA+IC1NOiAgICAgQmVuaWFtaW4gQmlh
IDxiZW5pYW1pbi5iaWFAYW5hbG9nLmNvbT4NCj4gPiA+ICBMOiAgICAgbGludXgtaWlvQHZnZXIu
a2VybmVsLm9yZw0KPiA+ID4gLVM6ICAgICBTdXBwb3J0ZWQNCj4gPiA+ICtTOiAgICAgT3JwaGFu
DQo+DQo+IEdpdmVuIGl0IHNob3VsZCBiZSBjb3ZlcmVkIGJ5IHRoZSBjYXRjaCBhbGwgZm9yIEFu
YWxvZyBkZXZpY2VzIElJTyANCj4gZHJpdmVycywgZWl0aGVyIHdlIHNob3VsZCBjb25maXJtIGlm
IGl0IHNob3VsZCBtb3ZlIHRvIHNvbWVvbmUgZWxzZSBhdCANCj4gQW5hbG9nLCBvciBpZiB3ZSBz
aG91bGQganVzdCBkcm9wIHNwZWNpZmljYWxseSBsaXN0aW5nIHRoaXMgb25lLg0KPiBMaXN0aW5n
IGl0IGFzIE9ycGhhbiB3aGVuIHRoZXkgYXJlIGdvb2QgYXQgc3VwcG9ydGluZyB0aGVpciBkcml2
ZXJzIA0KPiBtYXkgZ2l2ZSB0aGUgd3JvbmcgaW1wcmVzc2lvbi4NCj4NCj4gK0NDIEFsZXggdG8g
bWFrZSBzdXJlIHBlb3BsZSBhdCBBbmFsb2cgbm90aWNlIDopDQoNClN1cmUsIGdvb2QgcG9pbnQu
IEkgd2FudGVkIHRvIHN0YXJ0IHRoZSBkaXNjdXNzaW9uIHNvIHRoZSBpbnRlcmVzdGVkIHBlb3Bs
ZSBtaWdodCBhcHBlYXIuDQoNCkJlc3QgcmVnYXJkcywNCktyenlzenRvZg0K
