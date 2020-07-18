Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB59224D40
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 19:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgGRRKh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 13:10:37 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14748 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbgGRRKg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jul 2020 13:10:36 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06IHALIE015682;
        Sat, 18 Jul 2020 13:10:21 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00128a01.pphosted.com with ESMTP id 32btx514b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Jul 2020 13:10:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQj93PE3StzMt1avgE0srOpxAokhX43pErRg8zelXIazZbIqyoO6DBY+ccDQxkbCGhjoYaMjbjD5c/6PjbX5NAPElARIPgoQ/SL99kStBum1LNJDyXVg+TKSMQmCX53Rt+JFKxd9gnTz1ImufbPY/6icfzWl72u0AVahU2PWwNajAkpA3IR/doim3CBLMuY3fRBKPWm9++RbAKCBAY4UDxlx4om64UW4m/z4JsRLEabfBGKd7D2u6ApzBC7FBnEvyMIoxidwEtCpMsVCly1+61dtQU7dyzsBg0goegU5anSN2fZaIDdKQCQ43IMZv52haT8D+aUVnLsM9RYYpN627Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mUgYG6tOR86BL6JM/x06bcHJfBgp1LwRwf2C3RR87A=;
 b=iVSCAh6Njyk2wanY5omD9Yz5ujDRDkRRYTs6Rj3y39LPSpO3wxIVREcaeu/Cd0lcDtxZK4rkyOmQVjGJe4wPE0RfEqXMrZFptRE0KQyPbDNd1putE0ckU7+OE7zDxpHtgXN7/tJ/7HQv2PlZwVPQ0H3sNmaX8GffpnB6+6qbftKBeP8jt/TgxnCdm7NFul7b9ag5Qe0yx7i1GhhK+oufmArGtIRCXSftwQ94Oj0KpN2zfc8WbKS9HcJcT/XAJhzo31l0xykkAXj4abNx6zljv3ED5CgoHMFZrAJK2D73pAjWrZNZLtepz+A/NSg/tqz+2QkqnHD33nHPEWJkhJxBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mUgYG6tOR86BL6JM/x06bcHJfBgp1LwRwf2C3RR87A=;
 b=UjfJqCr+/aJ8VGdYTORiiPtsDkjuBTeIHD5sbJCbW6YBjg5ogpwRq30w7haptSpFcOmnljoHtEtu9XBDau+59rs+ok08HKjzbDjk48O6KQBdvk6l1mxZh1ujmqw1mETuXhMLZ4Hf4abh44xeeQQnfk3sgsUVwaFgD78I4BhC6wI=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4172.namprd03.prod.outlook.com (2603:10b6:5:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Sat, 18 Jul
 2020 17:10:17 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c1c3:9cbb:449c:ac0a]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c1c3:9cbb:449c:ac0a%7]) with mapi id 15.20.3195.023; Sat, 18 Jul 2020
 17:10:16 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: trigger: Staticise stub functions
Thread-Topic: [PATCH] iio: trigger: Staticise stub functions
Thread-Index: AQHWWepFpjXeep6Q/UWn3AyL8iLHRqkNjCOAgAADT4D///dWIA==
Date:   Sat, 18 Jul 2020 17:10:16 +0000
Message-ID: <DM6PR03MB4411D0B8239819F58B33F7BCF97D0@DM6PR03MB4411.namprd03.prod.outlook.com>
References: <20200714142456.67054-1-alexandru.ardelean@analog.com>
 <20200718172501.4ba58924@archlinux>
 <017b33b1-b6f9-107b-b9c4-8c0abd0d6a3b@metafoo.de>
In-Reply-To: <017b33b1-b6f9-107b-b9c4-8c0abd0d6a3b@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVdGeVpHVnNaV0ZjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB5TmpsbFlUbGpOQzFqT1RFeExURXhaV0V0WVRrMk1pMWtOREkx?=
 =?utf-8?B?T0dKbFlUWmhZbVJjWVcxbExYUmxjM1JjTWpZNVpXRTVZell0WXpreE1TMHhN?=
 =?utf-8?B?V1ZoTFdFNU5qSXRaRFF5TlRoaVpXRTJZV0prWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhOekE0SWlCMFBTSXhNekl6T1RVMk1qSXhNRGt6TlRZek1ERWlJR2c5SW5W?=
 =?utf-8?B?TVZHVnhkRlpHUzJNM1IwZHplREUwV1VkTlQzSXJhelp4UlQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVU1SllWaHdTRll6VjBGaGRuaHNlR2R4VjJWRldu?=
 =?utf-8?B?RXZSMWhIUTNCYU5GSnJSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQk1sZHBibE5uUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
authentication-results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48acea14-3885-436b-c68d-08d82b3d715c
x-ms-traffictypediagnostic: DM6PR03MB4172:
x-microsoft-antispam-prvs: <DM6PR03MB4172C6AAAACE2C018BE29340F97D0@DM6PR03MB4172.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7nQWe/wGAG6hOwQf7kXBDuqMvKRx9KtY4ZUq31t6cEuV5ZmXpFL8raiHNw6ZVy1MZa7qVKrNMguDSMX6u2VzUIc8/prblvgyjLoLyaWIZJaf1t7Ey5zpHN5rLRaoaKclkVyLm50pmehtHxa98TK09UIgR4G6VtJhLZdY4aD/3qM6JDru0DACnAh5AJbYRS+VYCRSZQk425LwlWeb71Od+iIdMalNNyD/O9vuaIsd/xwFfmdynFqy4xVwMChr/xieUDePoYqdbr4UErKKcYoaNAH/Gvm9G7odXzAh+Yvb2Z4EsKYmqlnGZMDTOhJkU7CiKTvdhy0g5+efqHEAm67V7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(376002)(366004)(346002)(39850400004)(76116006)(8676002)(9686003)(8936002)(4326008)(83380400001)(66556008)(54906003)(66476007)(64756008)(7696005)(478600001)(45080400002)(55016002)(2906002)(6506007)(5660300002)(52536014)(86362001)(71200400001)(33656002)(110136005)(53546011)(186003)(26005)(316002)(66446008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0+hxWAlefLffNIuu5N4SWzPA8y4lKagzhl3m0OC6DIZxSXzEQzlPQ7NL3BDReGR3l2ma+8jwcxBMcABBYJ0R31XXS3x0BeY0MCTlfRDDXo32v32HXitDTVC+EExTtj2rNjuWKNm+YeQiHWhJrurNiCqi8gfoo/yD6Ve4KaG1Juw3EFwUIJBQvkn3Bx2GozqDMIWhHHLP7dEj5lj5f5DIH7M80mkpcJHnFhg9uRPBd12Cqm7/25amhN5frVnnPDM/R05W5ESrJdKCXnyYO4Fy4UFF0mBPEMermWEYTP8k2PRyi+PHt8fjy5w2n2ZRcDh5dcCleopKfs3V0RuPPKN/NLYyOvecJV4QKNVtQOeRBIwcd/4LwezZMeTCKnX3HxyCrNhh1ewyRoKm0FHrcEWwkDvTpfOBrJZJ309r0Uxgv3GHukQ7XRSaIlC5favwzoARf/bq5LsIQRtASphISkIUfxyDkQ4m8AdwR/E75tkyjXg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48acea14-3885-436b-c68d-08d82b3d715c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2020 17:10:16.4172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tedUhn4oLVRg8g6vlW1NHQA8Gu6BRF0Fb8Bd915qgpi08A1WsksVXRBZToGAkA1jFJk/fINolyE/fDyshiNGRsOpoUaE6xoCU4kEbOMk1yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4172
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-18_07:2020-07-17,2020-07-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007180132
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

QXBvbG9naWVzIGZyb20gbXkgc2lkZSBmb3IgYmVpbmcgdG9vIG11Y2ggb2YgYSBwYXRjaC1ib3Qg
aGVyZS4NCkkgc2hvdWxkIGhhdmUgYWxzbyBnaXZlbiBzb21lIG1vcmUgdGhvdWdodCB0byB0aGUg
cGF0Y2guDQpBdG0sIEknbSBzZW5kaW5nIHRoaXMgZnJvbSBPdXRsb29rLCBzaW5jZSBbZm9yIHNv
bWUgcmVhc29uXSB0aGUgTGludXggbWFpbC1jbGllbnQgaXNuJ3Qgd29ya2luZy4NClsgV2hpY2gg
aXMgd2h5IHRoaXMgaXNuJ3QgcHJvcGVybHkgaW5saW5lZCBlaXRoZXIgXQ0KDQpJJ2xsIHNlbmQg
YSBWMi4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhcnMtUGV0ZXIgQ2xh
dXNlbiA8bGFyc0BtZXRhZm9vLmRlPiANClNlbnQ6IFNhdHVyZGF5LCBKdWx5IDE4LCAyMDIwIDc6
MzcgUE0NClRvOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgQXJkZWxlYW4s
IEFsZXhhbmRydSA8YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+DQpDYzogbGludXgtaWlv
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDog
UmU6IFtQQVRDSF0gaWlvOiB0cmlnZ2VyOiBTdGF0aWNpc2Ugc3R1YiBmdW5jdGlvbnMNCg0KW0V4
dGVybmFsXQ0KDQpPbiA3LzE4LzIwIDY6MjUgUE0sIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+
IE9uIFR1ZSwgMTQgSnVsIDIwMjAgMTc6MjQ6NTYgKzAzMDANCj4gQWxleGFuZHJ1IEFyZGVsZWFu
IDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+DQo+PiBGcm9tOiBMYXJz
LVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4+DQo+PiBNYWtlIHN1cmUgdGhhdCB0
aGUgdHJpZ2dlciBmdW5jdGlvbiBzdHVicyBhcmUgYWxsIHN0YXRpYyBpbmxpbmUuIA0KPj4gT3Ro
ZXJ3aXNlIHdlJ2xsIGdldCBsaW5rZXIgZXJyb3JzIGR1ZSB0byBtdWx0aXBsZSBkZWZpbml0aW9u
cyBvZiB0aGUgc2FtZSBmdW5jdGlvbi4NCj4+DQo+PiBGaXhlcyBmOGM2ZjRlOWE0MGQ0OiAoImlp
bzogdHJpZ2dlcjogU3RhdGljaXNlIHN0dWIgZnVuY3Rpb25zIikNCj4+IFNpZ25lZC1vZmYtYnk6
IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPj4gU2lnbmVkLW9mZi1ieTog
QWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gSSdt
IGN1cmlvdXMgb24gd2hhdCB0aGUgYWN0dWFsIGJ1aWxkIGVycm9yIGlzPyAgU3RhdGljIGZ1bmN0
aW9ucyANCj4gc2hvdWxkIHJlc3VsdCBpbiBpbmRlcGVuZGVudCBpbXBsZW1lbnRhdGlvbnMgaW4g
ZWFjaCBDIGZpbGUgdGhhdCANCj4gaW5jbHVkZXMgdGhlbS4gSW5saW5lIGlzIG5vcm1hbGx5IGNv
bnNpZGVyZWQgYSBoaW50LiAgSGVuY2Ugd2hhdCBhbSBJIG1pc3Npbmc/DQoNCkl0J3MgYSBiYWQg
Y29tbWl0IG1lc3NhZ2UsIG15IGZhdWx0LiBUaGlzIHNob3VsZCBoYXZlIGJlZW4NCg0KTWFrZSBz
dXJlIHRoYXQgdGhlIHRyaWdnZXIgZnVuY3Rpb24gc3R1YnMgYXJlIGFsbCBzdGF0aWMgaW5saW5l
LiANCk90aGVyd2lzZSB3ZSBtaWdodCBzZWUgY29tcGlsZXIgd2FybmluZ3MgYWJvdXQgZGVjbGFy
ZWQgYnV0IHVudXNlZCBmdW5jdGlvbnMuDQoNCg0KDQo=
