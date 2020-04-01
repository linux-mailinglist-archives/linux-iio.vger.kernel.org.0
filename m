Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935BC19A607
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 09:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgDAHOq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 03:14:46 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54376 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731680AbgDAHOp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 03:14:45 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0317CdJm016429;
        Wed, 1 Apr 2020 03:14:22 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00128a01.pphosted.com with ESMTP id 3023g5bfsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 03:14:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5+W2/+O9+FWkJfDerD03P4rN+QCKbi3jkzJWCJIhuf+5buvp+KEURfpXY7MsDyXChyw8NacTz6FTQVbL+BV8s95VYoFl//j83cU89NPYOnRKEKTO4FH8T3fLFfrMDsx8vXq4l2PYFWng6EVcItvrmcFfETUiEJxR1vYiQvwHSt69cDiufZaMAeZ71Xcw4NsICgwo0uk0vinQd+xJTUs9DeHasPSOD2Yc1zWsZEwF0iFjyp6mQGw8IWIoxtHThjBFv0YaiRXyItfotbFgg2iquj1Qv9EfvpWMLrqXGoWoBDZlTGGvyS52D0w/C8vsIVEG5AR1Cx7W2nXTR78oz0idA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPLoSDycU3BhNtdoRqu9ttHqKkemeXX+TeN9w1sYntQ=;
 b=cwpTCl5qC2H4k3PrfjKwuSYhty+QQQUz/dr0AgRKz57PR2H4laU0LXnQgjfiYwM4+9yLHvHF/r9TvGKASFq9kp7zmKt7z/0Bjp3jI+Ve//ohVml03NJVFuRLfLCWrYLnyk5rdYSdVKNo6BV2Hf1RyH7IHFx0DKqIhFLm0iQEs1qmURF9EgmCnKCkuY3h2It6OjIKSVB+IiJQr8INDdHQT0GX82LXmNliUYDh56i2sMZRiV03flOl7++pmhhAerkg9RRCxzvleot5jX/B0TfafmmZmq6AW3z+8oWriWj+fPtZTWreiFjmLV/hw5tkhQ7DpqJu7VN6cNOuswtejBRLow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPLoSDycU3BhNtdoRqu9ttHqKkemeXX+TeN9w1sYntQ=;
 b=UXzSEndblMFr5SCBK7zDAZSyWb+i0JC8rfQlFJA9EdMdXnFirvecL4opqV5fzBOG2t+GB00EfC1YFJCuk68S7aFPYc6S1cN16if6Clqhy0Z/zzE5AVC1sXrtIQeqmFr5foUTMehAkpTDnua29p0HVegPA//0mQjizE9y+eW3PK0=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB3122.namprd03.prod.outlook.com (2603:10b6:405:3c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 07:14:15 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 07:14:15 +0000
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
Subject: RE: [PATCH v3 3/6] iio: adis: Add adis_update_bits() APIs
Thread-Topic: [PATCH v3 3/6] iio: adis: Add adis_update_bits() APIs
Thread-Index: AQHWB1JXB+/DDq6i7UWJXZLzqLViE6hi+KGAgADi8GA=
Date:   Wed, 1 Apr 2020 07:14:15 +0000
Message-ID: <BN6PR03MB3347EEACC06B5B3F2146EFAB99C90@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200331114811.7978-1-nuno.sa@analog.com>
 <20200331114811.7978-4-nuno.sa@analog.com>
 <CAHp75VdWa_-x4n+FwuZZ6a9pw19bejOGtx_VwWhvNAuSTYfgdw@mail.gmail.com>
In-Reply-To: <CAHp75VdWa_-x4n+FwuZZ6a9pw19bejOGtx_VwWhvNAuSTYfgdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5qTXlOR1ZsTkdNdE56TmxPQzB4TVdWaExUaGhNekV0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEWXpNalJsWlRSbExUY3paVGd0TVRGbFlTMDRZ?=
 =?utf-8?B?VE14TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTVRFNE55?=
 =?utf-8?B?SWdkRDBpTVRNeU16QXhPVGc0TlRNeE16Y3pNVEU0SWlCb1BTSkxRblJzT1ZS?=
 =?utf-8?B?cldYUkVRbTV1WlVkVFpXbHJTaXRtUm5aVFUxVTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVRXJhRWd3YkRsUlpsZEJVME56Um5oallqaG9NMnRKUzNkWVJu?=
 =?utf-8?B?aDJlVWhsVVVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-originating-ip: [2001:a61:2422:3901:c912:5684:2cfe:d6d1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb9212ea-54c1-4520-400a-08d7d60c493a
x-ms-traffictypediagnostic: BN6PR03MB3122:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB3122E6FD6D949CE0848EC50299C90@BN6PR03MB3122.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(136003)(66946007)(86362001)(71200400001)(4326008)(66574012)(6916009)(4744005)(5660300002)(53546011)(33656002)(9686003)(186003)(54906003)(6506007)(107886003)(7696005)(316002)(2906002)(8676002)(478600001)(76116006)(55016002)(52536014)(81156014)(8936002)(64756008)(66446008)(66556008)(81166006)(66476007);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DQbI1fcLKG1DeQXaVjpMGE2wmgVX/euuVc+1FasZxye0JB8jM2lSJSN2MnUfNQoDcKYHBqrSuO21f6rONQWyhsleYXEOCPbE3JdvxDXlZY0j+tUMiH/RtJGfDRmSJgVWVTwoy8y0LqCUaGCEXqzE7y/ww2ebEpbXrnsLLAWwZ94uKCSiElBzy1LQD5fi3SY1D2xgTJ3x4XqcaTeTNNmolCNEquepvzAlnNootZZdW9EgQuRhX1hEY0IqjkIjFAzvY+WxEjB8cyS79OLQqSNJEo5YATvwkkM6MC0Xl4X3O5y7Kc8EVlxlFfAChwdLI5zmMKeHTIZXltG1kMeuBWDyLZpr9ZwT4VCL8qCzRez0mK9fngS48a8JjVX2Pnrh8CMaYpN+AEQ5XuG+O1W27RiCTJfGqLlIqp58RPcNz6U9BWz84pJ5AoKOHjKRdXnK52qq
x-ms-exchange-antispam-messagedata: dovwRNO760gYsaIuHXxzYVGDVXX22CDyeLnABnB8WKqgy5yrITbI6FZZcYSk0jm26Cjkz5+CWEPe+6Wlhb7bRmF3wf1mUs8PjK43XePSOtza6aYuqg49hOgnlB7vO8+dbGDkwmQrvzYxv50ZMVco1A6kJECdkFUbvaSwHLo/C4lItkikOTtxbjy69rY5GUWeb5mG7CRSAEeEJ1bahTEWUg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9212ea-54c1-4520-400a-08d7d60c493a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 07:14:15.2000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7uz+iXB+ixt8YYKJOcAMRDSmuw5lLbe6m9HONayHctDjiWYW2gmYmbF37O9NIZZAepQzC1BBpsnMBonZqvMu4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3122
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004010065
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNl
bnQ6IERpZW5zdGFnLCAzMS4gTcOkcnogMjAyMCAxOTo0Mg0KPiBUbzogU2EsIE51bm8gPE51bm8u
U2FAYW5hbG9nLmNvbT4NCj4gQ2M6IGxpbnV4LWlpbyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9y
Zz47IGRldmljZXRyZWUNCj4gPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgSm9uYXRoYW4g
Q2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47DQo+IEhhcnRtdXQgS25hYWNrIDxrbmFhY2suaEBn
bXguZGU+OyBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47DQo+IFBldGVyIE1l
ZXJ3YWxkLVN0YWRsZXIgPHBtZWVyd0BwbWVlcncubmV0PjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgr
ZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBBcmRl
bGVhbiwNCj4gQWxleGFuZHJ1IDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT47IEhlbm5l
cmljaCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MyAzLzZdIGlpbzogYWRpczogQWRkIGFkaXNfdXBkYXRlX2JpdHMoKSBB
UElzDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUdWUsIE1hciAzMSwgMjAyMCBhdCAyOjQ5
IFBNIE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBw
YXRjaCBhZGRzIGEgYHJlZ21hcF91cGRhdGVfYml0cygpYCBsaWtlIEFQSSB0byB0aGUgQURJUyBs
aWJyYXJ5Lg0KPiA+IEl0IHByb3ZpZGVzIGxvY2tlZCBhbmQgdW5sb2NrZWQgdmFyaWFudC4NCj4g
DQo+ID4gKyAgICAgICBfX3ZhbCAmPSB+bWFzazsNCj4gPiArICAgICAgIF9fdmFsIHw9IHZhbCAm
IG1hc2s7DQo+IA0KPiBZb3UgY2FuIHVzZSBzdGFuZGFyZCBvbmUgbGluZXIsIGkuZS4NCj4gDQo+
ICAgICAgICBfX3ZhbCA9IChfX3ZhbCAmIH5tYXNrKSB8ICh2YWwgJiBtYXNrKTsNCg0KU3VyZS4g
Q2FuIGRvIHRoYXQuLi4NCg0KLSBOdW5vIFPDoQ0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywN
Cj4gQW5keSBTaGV2Y2hlbmtvDQo=
