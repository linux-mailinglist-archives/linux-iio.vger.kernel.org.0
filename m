Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E95199484
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 12:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgCaK66 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 06:58:58 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37824 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730403AbgCaK66 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 06:58:58 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VAo8Yl027544;
        Tue, 31 Mar 2020 06:58:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e6hcax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 06:58:37 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02VAwavl010000;
        Tue, 31 Mar 2020 06:58:36 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e6hcau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 06:58:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVxMQqttMSMsf5p1egOvyO6iZpvbnR+eYpqb9OWHGox0++7NLEwA4MMeBLdeTwHaAkqw/H0I3/7JUi5VukmyJPakaHyyZACmT05V8KLV+rkgWaIaz9WZnalav8+YqwKQlUcqhSus+VY1eat+t5IQnHEKpeisx0XuQL/u7NzgfQGVvVL9M1GfUzLN+T+qChr3vEEhpczeI1I/ka0d87PC5p21Q/Sj8dJ8fAP5hNdLZudYYbhPcvGyy4S9R1ecZIiPU6URvv/hWjF+njSnHbdVkHWUBEh0gpNOjHnRNPcSExNeAcLI1beBsM9URPQPO6Uv0IgketJB9Gf3/Bw3UQf8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY2/OMlWmXWdtFRTEzH3idmTiDljKRCiZJCfh9cP1lo=;
 b=RiiwVkREvJLuLez4wThEjssi2ohpnN3n4GY6ZwbW3OKmxGBEXS/DuymjgNwfuoP4Fh2XFyr5m+kM91sjgD5cfr5H/ya/NVpP1XD03JOSOCqpC8ArXNty+qzu4Yvul80tyNbsLIQ/ZS+Tu/U6YSjVu/g7Dl/J5qok7qxLnLM9RCJQxx7gOQqt/X3E1nGFVsvQwxBPMf+cATqf6ykbEsB7GWnGdu18lndRkba4DUrLqUAkMW5PAoloMJ6+r4UaDi3g2ObTO2XMx7uVeKZUKNh1CFcORS9bkzkiVAFUV5YEsIQbd0IWrRz+a/QjSbr3hmI/4uEuK6njnC8hWXnhPsHNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY2/OMlWmXWdtFRTEzH3idmTiDljKRCiZJCfh9cP1lo=;
 b=H/6RSE9lBx9WyLsd9oFk5AgDZ1Jzy4FezAREWNbZAOGv+8i0ZAxucyAbMF0fMSkpDvOvIw1JFleGqcxotQIOLExpzvo14TDoiWkO0PRwQsID27D7r7dDpDX7NbyDXCjsHYuBXA+SoQ1eXaqwXvgoMpeyP50CbHXUh4l0QZF3pk8=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB3281.namprd03.prod.outlook.com (2603:10b6:405:41::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 10:58:34 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 10:58:34 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "rohitsarkar5398@gmail.com" <rohitsarkar5398@gmail.com>
CC:     "stefan.popa@analog.com" <stefan.popa@analog.com>,
        "zhongjiang@huawei.com" <zhongjiang@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: RE: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of
 DEFINE_SIMPLE_ATTRIBUTE
Thread-Topic: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of
 DEFINE_SIMPLE_ATTRIBUTE
Thread-Index: AQHWBMsVVhk01u9Q+ku9e2lfo1M2mqhfUfcAgAGNSICAAa0UAA==
Date:   Tue, 31 Mar 2020 10:58:33 +0000
Message-ID: <BN6PR03MB33472A88BA78392686737F9099C80@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
         <20200329103818.2fce9529@archlinux>
 <aee10d6bfc5f2fef85d90245304f3e0f368f94ec.camel@analog.com>
In-Reply-To: <aee10d6bfc5f2fef85d90245304f3e0f368f94ec.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE9HVTFaamMzTURFdE56TXpaUzB4TVdWaExUaGhNekF0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEaGxOV1kzTnpBekxUY3pNMlV0TVRGbFlTMDRZ?=
 =?utf-8?B?VE13TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTXpZNU15?=
 =?utf-8?B?SWdkRDBpTVRNeU16QXhNalU1TVRFeU1UVTROamc0SWlCb1BTSkhZM2gwVkVk?=
 =?utf-8?B?NGIybDVOVzQwY1ZsS2VsUTNlVEphVTFGYVdqZzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVUm5iR0prVVZOM1psZEJabWRSY3pJeE5HSnpiRlFyUWtONlls?=
 =?utf-8?B?aG9kWGxXVFVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-originating-ip: [2001:a61:25e8:5601:8594:23ee:fc00:bd03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0eefdc3-4e97-4e88-470c-08d7d562755a
x-ms-traffictypediagnostic: BN6PR03MB3281:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB3281F10ED1A322DBD0B31A6899C80@BN6PR03MB3281.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(86362001)(71200400001)(66946007)(55016002)(81156014)(966005)(81166006)(8676002)(66476007)(52536014)(66556008)(66446008)(478600001)(64756008)(8936002)(4326008)(7696005)(110136005)(76116006)(66574012)(5660300002)(2906002)(316002)(6506007)(54906003)(9686003)(33656002)(186003)(53546011);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CYw62XlZrrfALXivpKFkkPaeujLqNOwJHnX1aBsiOopBle3CaxbI2MvrHVujwOJxOkVfFIvCJE2Dovw73OtRS6Mwz1JVb2KxJxxBk2l8YCV+jW5DkTSlROUOs+Zx0DdK2nAfDbs+YzH5YhzsPebtUBdnyY4eu1sy84E6H+V/3u9miKpGNedY3RmGZ/rwMaLvcL1VBRCYJkn7PVbimKHNYA6af/EZDl4x7NoLAYiBIhhW/2i9cwtev2tMjdT6vfisXlmaf8tF2VlGIbgju3mttSSC8nO6PDds+3tcMaHNXzpVaKcEWBg+jwtnBEiu7Yv2p2mSZkvJ9SLK1tKUDHnyiXF+cMOjvsQAM4C/dDCjyxtX3iA4wXDC+7Dugg2yN+MpRZ1vCRzo0BZAtOePjc1wfH8F7jQUL075xo0YHwiFYk6+h0TyLrFACcDUb+LSk/HHZ5/ZEksjj55ar8O6ucJFxkqBOGi/lVFWFm6fD99rE2nl7i3WB73Cp9K27AdJnz9HdBVNuMGMYHhquYgjLfPlZA==
x-ms-exchange-antispam-messagedata: ubuUfQTc+JaH5wB+F6gy2z1wxmT6zfVLWY2LekGvW3BV3+tYB0PU5bfT/h4ruikwUDcnvC5UKBppc4qvP9He/qbfVEP66wOvVMvvVHIW/ISjpyu74+QLp1348WzIJZjd4cacbexUkxhPKLD4WRRXC0fpw4jVHLrBkREwER39WmI9JcI7vs/zKBbf4WDgQWlUDl6Qj5tTTktGO7G5trZ8LQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eefdc3-4e97-4e88-470c-08d7d562755a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 10:58:34.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uaWDfgLXCuQIP6DNsjwJDHkxuOKegwFFyxNnrdRCrZyLSqcEoX8ACtXQ+Kp0edJwACvUFtR/3L6C0CcWBd+hOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3281
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_04:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgUm9oaXQsDQoNCj4gRnJvbTogbGludXgtaWlvLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGlu
dXgtaWlvLW93bmVyQHZnZXIua2VybmVsLm9yZz4gT24NCj4gQmVoYWxmIE9mIEFyZGVsZWFuLCBB
bGV4YW5kcnUNCj4gU2VudDogTW9udGFnLCAzMC4gTcOkcnogMjAyMCAxMToyMA0KPiBUbzogamlj
MjNAa2VybmVsLm9yZzsgcm9oaXRzYXJrYXI1Mzk4QGdtYWlsLmNvbQ0KPiBDYzogc3RlZmFuLnBv
cGFAYW5hbG9nLmNvbTsgemhvbmdqaWFuZ0BodWF3ZWkuY29tOyBsaW51eC0NCj4gaWlvQHZnZXIu
a2VybmVsLm9yZzsgQm9nZGFuLCBEcmFnb3MgPERyYWdvcy5Cb2dkYW5AYW5hbG9nLmNvbT47DQo+
IHBtZWVyd0BwbWVlcncubmV0OyBrbmFhY2suaEBnbXguZGU7IEhlbm5lcmljaCwgTWljaGFlbA0K
PiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxhcnNAbWV0YWZvby5kZQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvMl0gdXNl
IERFRklORV9ERUJVR0ZTX0FUVFJJQlVURSBpbnN0ZWFkIG9mDQo+IERFRklORV9TSU1QTEVfQVRU
UklCVVRFDQo+IA0KPiBPbiBTdW4sIDIwMjAtMDMtMjkgYXQgMTA6MzggKzAxMDAsIEpvbmF0aGFu
IENhbWVyb24gd3JvdGU6DQo+ID4gT24gU2F0LCAyOCBNYXIgMjAyMCAxMjowNDo1MyArMDUzMA0K
PiA+IFJvaGl0IFNhcmthciA8cm9oaXRzYXJrYXI1Mzk4QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiA+IFRoZSBkZWJ1Z2ZzX2NyZWF0ZV9maWxlX3Vuc2FmZSBtZXRob2QgZG9lcyBub3QgcHJv
dGVjdCB0aGUgZm9wcyBnaXZlbiB0bw0KPiA+ID4gaXQgZnJvbSBmaWxlIHJlbW92YWwuIEl0IG11
c3QgYmUgdXNlZCB3aXRoIERFRklORV9ERUJVR0ZTX0FUVFJJQlVURQ0KPiA+ID4gd2hpY2ggbWFr
ZXMgdGhlIGZvcHMgYXdhcmUgb2YgdGhlIGZpbGUgbGlmZXRpbWUuDQo+ID4gPg0KPiA+ID4gRnVy
dGhlciB1c2luZyBERUZJTkVfREVCVUdGU19BVFRSSUJVVEUgYWxvbmcgd2l0aA0KPiA+ID4gZGVi
dWdmc19jcmVhdGVfZmlsZV91bnNhZmUgc2lnbmlmaWNhbnRseSByZWR1Y2VzIHRoZSBvdmVyaGVh
ZCBpbnRyb2R1Y2VkDQo+IGJ5DQo+ID4gPiBkZWJ1Z2ZzX2NyZWF0ZV9maWxlIHdoaWNoIGNyZWF0
ZXMgYSBsaWZldGltZSBtYW5hZ2luZyBwcm94eSBhcm91bmQgZWFjaA0KPiA+ID4gZm9wcyBoYW5k
ZWQgaW4uIFJlZmVyIFsxXSBmb3IgbW9yZSBvbiB0aGlzLg0KPiA+ID4NCj4gPiA+IEZpeGVzIHRo
ZSBmb2xsb3dpbmcgd2FybmluZ3MgcmVwb3J0ZWQgYnkgY29jY2luZWxsZToNCj4gPiA+IGRyaXZl
cnMvaWlvL2ltdS8vYWRpczE2NDYwLmM6MTI2OjAtMjM6IFdBUk5JTkc6DQo+IGFkaXMxNjQ2MF9m
bGFzaF9jb3VudF9mb3BzDQo+ID4gPiBzaG91bGQgYmUgZGVmaW5lZCB3aXRoIERFRklORV9ERUJV
R0ZTX0FUVFJJQlVURQ0KPiA+ID4gZHJpdmVycy9paW8vaW11Ly9hZGlzMTY0NjAuYzoxMDg6MC0y
MzogV0FSTklORzoNCj4gYWRpczE2NDYwX3Byb2R1Y3RfaWRfZm9wcw0KPiA+ID4gc2hvdWxkIGJl
IGRlZmluZWQgd2l0aCBERUZJTkVfREVCVUdGU19BVFRSSUJVVEUNCj4gPiA+IGRyaXZlcnMvaWlv
L2ltdS8vYWRpczE2NDYwLmM6OTA6MC0yMzogV0FSTklORzoNCj4gYWRpczE2NDYwX3NlcmlhbF9u
dW1iZXJfZm9wcw0KPiA+ID4gc2hvdWxkIGJlIGRlZmluZWQgd2l0aCBERUZJTkVfREVCVUdGU19B
VFRSSUJVVEUNCj4gPiA+IGRyaXZlcnMvaWlvL2ltdS8vYWRpczE2NDAwLmM6Mjc4OjAtMjM6IFdB
Uk5JTkc6DQo+IGFkaXMxNjQwMF9mbGFzaF9jb3VudF9mb3BzDQo+ID4gPiBzaG91bGQgYmUgZGVm
aW5lZCB3aXRoIERFRklORV9ERUJVR0ZTX0FUVFJJQlVURQ0KPiA+ID4gZHJpdmVycy9paW8vaW11
Ly9hZGlzMTY0MDAuYzoyNjE6MC0yMzogV0FSTklORzoNCj4gYWRpczE2NDAwX3Byb2R1Y3RfaWRf
Zm9wcw0KPiA+ID4gc2hvdWxkIGJlIGRlZmluZWQgd2l0aCBERUZJTkVfREVCVUdGU19BVFRSSUJV
VEUNCj4gPiA+DQo+ID4gPiBbMV06IGh0dHBzOi8vbGlzdHMuZ3QubmV0L2xpbnV4L2tlcm5lbC8y
MzY5NDk4DQo+ID4gPg0KPiA+ID4gUm9oaXQgU2Fya2FyICgyKToNCj4gPiA+ICAgaWlvOiBpbXU6
IGFkaXMxNjQwMDogdXNlIERFRklORV9ERUJVR0ZTX0FUVFJJQlVURSBpbnN0ZWFkIG9mDQo+ID4g
PiAgICAgREVGSU5FX1NJTVBMRV9BVFRSSUJVVEUNCj4gPiA+ICAgaWlvOiBpbXU6IGFkaXMxNjQ2
MDogdXNlIERFRklORV9ERUJVR0ZTX0FUVFJJQlVURSBpbnN0ZWFkIG9mDQo+ID4gPiAgICAgREVG
SU5FX1NJTVBMRV9BVFRSSUJVVEUNCj4gPiA+DQo+ID4gPiAgZHJpdmVycy9paW8vaW11L2FkaXMx
NjQwMC5jIHwgNCArKy0tDQo+ID4gPiAgZHJpdmVycy9paW8vaW11L2FkaXMxNjQ2MC5jIHwgNiAr
KystLS0NCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4gPiA+DQo+ID4gSGkgUm9oaXQsDQo+ID4NCj4gPiBZb3UndmUgb3BlbmVkIGEgY2Fu
IG9mIHdvcm1zIHdpdGggdGhpcyBvbmUuICBUaGVyZSBhcyBhIHByZXZpb3VzIHNlcmllcw0KPiA+
IHBvc3RlZCBkb2luZyBleGFjdGx5IHRoaXMgY2hhbmdlIGJhY2sgaW4gMjAxOSBieSBaaG9uZyBK
aWFuZyAoY2MnZCkNCj4gPg0KPiA+IEF0IHRoZSB0aW1lIEkgZGlkIGEgYml0IG9mIGxvb2tpbmcg
aW50byB3aHkgdGhpcyBoYWQgYmVlbiB1bml2ZXJzYWxseSB0YWtlbg0KPiA+IHVwIGNyb3NzIHRy
ZWUgYW5kIHR1cm5lZCBvdXQgdGhlcmUgYXJlIHNvbWUgcG90ZW50aWFsIGlzc3Vlcy4NCj4gPg0K
PiA+IEFsZXhhbmRydSBhZGRlZCBpdCB0byB0aGUgbGlzdCBvZiB0aGluZ3MgdG8gdGVzdCwgYnV0
IEkgZ3Vlc3MgaXQgZ290DQo+ID4gYnVyaWVkIHVuZGVyIG90aGVyIHdvcmsgYW5kIGlzIHN0aWxs
IG91dHN0YW5kaW5nLg0KPiA+DQo+IA0KPiB5ZXANCj4gbXkgYmFkOw0KPiB3aWxsIHRyeSB0byBt
YWtlIHJvb20gdGhlc2UgZGF5cyBmb3IgdGhhdCBvbGQgb25lDQo+IA0KPiANCg0KSSBkb24ndCBo
YXZlIHRoZSBleGFjdCBwYXJ0cyB0aGF0IHRoaXMgcGF0Y2ggaXMgdG91Y2hpbmcgYnV0IEkgaGF2
ZSBvdGhlciBwYXJ0cyB3aGVyZSB0aGlzIHBhdGNoDQphcHBsaWVzIGFuZCBzaG91bGQgYmUgc2Ft
ZS4gU28sIHRoZSBpZGVhIHRvIHRlc3QgdGhpcyBpcyB0byByZWFkIHRoZSBmaWxlcyBpbiBkZWJ1
Z2ZzPyBNYXliZSBhbHNvDQpzb21lIHVuYmluZCArIGJpbmRpbmc/DQoNCkkgd2lsbCB0cnkgdG8g
dGVzdCB0aGlzIHN0aWxsIHRvZGF5Li4uDQoNCi0gTnVubyBTw6ENCj4gPiBodHRwczovL2xrbWwu
b3JnL2xrbWwvMjAxOS8xMC8zMC8xNDQNCj4gPg0KPiA+IEhhcyBHcmVnIEtIIHJhaXNpbmcgdGhl
IHBvaW50IHRoYXQgZmlsZSByZWZlcmVuY2UgY291bnRpbmcgaXMgY2hhbmdlZCAoYXMgeW91DQo+
ID4gbWVudGlvbikgYnV0IHRoYXQgY2FuIGNhdXNlIHN1YnRsZSBidWdzLiAgSXQgJ21pZ2h0JyBi
ZSBmaW5lIGJ1dCBpcw0KPiA+IGRlZmluaXRlbHkgb25lIHRoYXQgbmVlZHMgYSB0ZXN0ZWQtYnkg
ZnJvbSBzb21lb25lIHdpdGggdGhlIGhhcmR3YXJlLg0KPiA+DQo+ID4gSm9uYXRoYW4NCg==
