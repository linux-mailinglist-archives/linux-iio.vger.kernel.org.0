Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7262A25A867
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 11:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIBJMh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 05:12:37 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35960 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbgIBJMc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2020 05:12:32 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08297MWS008001;
        Wed, 2 Sep 2020 05:12:02 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00128a01.pphosted.com with ESMTP id 337kx6bbmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 05:12:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH8b2JxkXhnzYI70x8j5Up9snvlkhZF6bE8aXTPfMGS56xlnDGm6P2bztbgNysb+PeeKhPxKaEmPtj4t5+IaJfuYtNumJ1kl1zY5uAHm+TfOLnMRlH0SbHok02qSbZHvoCZfacEG8QGevxEL29z+IjEziwZZuhLXnbNB7v0WEPN1Vjw6yLycwYmXdpuNEDgdxdKrXdJuD8oXvrsi+dCsKvB+MRTYS6QdS8NUZPYi3JkPrPozkQ8QOSdWsm6nwISWCK+aUwVTKWzjAe0tUIlMU8F5IrNhGcM23JYLdEGYwRpVuuGpIxnyToDBsMFtqojgVMRRZ5JDRQHa4f2wM1NIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XX/JMpu/+CVfrEAkVwogNaCjgzWBuHegfOBh0XKqE8=;
 b=Ia9Zf6g4A2DhfGAunjn2qQWwupk8/SjU99i5MntF0NUkaVYnHiIFuoixExl8mGQgfmyGJ4qgE8I3afl2OO/g2hR6LskI70KKjuOgShH+qYrLJrtq36AoZz2XR8SAuGKP4GlV0TCfAPOy3PipJNwalfouI4j0UCwfo/7wjM03MujiBWgRPE5vi7J5GPOImL/rXVjoCbRSBA+G5naAJs8tic2RqLW7Bejez7BeRpRe0qU0lXn79ZN5iufFbz/UPilJof6C1A45l5v8iKzBuK3zw1LUVxbnBgiqm4ACsZj8S25GUuH9XpxqNOIPE4GsFIy3TfLEcLyTPN7paQKI9J2DUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XX/JMpu/+CVfrEAkVwogNaCjgzWBuHegfOBh0XKqE8=;
 b=TV2bl8NFFiubcmn7ymG4NvfbIWI/4j3yzOHV0OA02SNPw+hIwhsdIphWRN+sBLU499Kqvd1PMxGfvXQslM24LeCY3djINtBdy26ks0vR+zf3yM+9CLHM48kFP36hJ8zfsgcE1a/h6HbE7VEwq2A5yxfoCkH2Io+2eN0okviamOI=
Received: from BN6PR03MB2596.namprd03.prod.outlook.com (2603:10b6:404:56::13)
 by BN6PR03MB3137.namprd03.prod.outlook.com (2603:10b6:405:3e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 09:11:58 +0000
Received: from BN6PR03MB2596.namprd03.prod.outlook.com
 ([fe80::316b:48fd:9ee7:85c1]) by BN6PR03MB2596.namprd03.prod.outlook.com
 ([fe80::316b:48fd:9ee7:85c1%10]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 09:11:58 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     AceLan Kao <acelan.kao@canonical.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        William Sung <william.sung@advantech.com.tw>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Subject: RE: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
Thread-Topic: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
Thread-Index: AQHWedmTV7eSUUrgC06reX0RtWg5DalQ7EqAgAEzv4CAABWJAIAC0+SAgAAPnYCAAALxsA==
Date:   Wed, 2 Sep 2020 09:11:58 +0000
Message-ID: <BN6PR03MB259650CEEEC9647AB5C9D8338E2F0@BN6PR03MB2596.namprd03.prod.outlook.com>
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
 <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
 <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
 <BN6PR03MB25968259EBEAD55E040367308E2F0@BN6PR03MB2596.namprd03.prod.outlook.com>
 <CAHp75VdvnUsEf=fsRQRmyxQO=1m09M5U19GBtSPkjxSGA5cRBA@mail.gmail.com>
In-Reply-To: <CAHp75VdvnUsEf=fsRQRmyxQO=1m09M5U19GBtSPkjxSGA5cRBA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYldobGJtNWxjbWxjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAxT0dZeE1qazBaUzFsWTJaakxURXhaV0V0T1RBMFppMDBPRGc1?=
 =?utf-8?B?WlRjM1kyUmtaV05jWVcxbExYUmxjM1JjTlRobU1USTVOVEF0WldObVl5MHhN?=
 =?utf-8?B?V1ZoTFRrd05HWXRORGc0T1dVM04yTmtaR1ZqWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpNamM1SWlCMFBTSXhNekkwTXpVeE1UVXhOalkwTmpRME5qRWlJR2c5SWk5?=
 =?utf-8?B?Tll5ODFXbU0xVHl0aFpYVkVXR1JJWkZscmNYcHhjVGRMTUQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUkU0clZXZGlRMWxJVjBGU05sY3pOM0ZIVVVaU01r?=
 =?utf-8?B?aHdZbVoxYjFwQlZraFpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-office365-filtering-correlation-id: c5998847-6277-4d12-bad9-08d84f203ef1
x-ms-traffictypediagnostic: BN6PR03MB3137:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB31375A946558AE7F12DF818E8E2F0@BN6PR03MB3137.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AbhmsZQjG+KLCszGUcCRodeSpQ8SNGTprWlFfUJB5ElosQr9h/+3in0pHfbo0SoIj0dY4qwITfGlZLaF2KJVlfQHZFwIifqxFZfsxbSOYUYguEvBNCuASnx/ndw73IzSleji8ZVy3CU5UcWYCm5iMei2RSyZKkG18gpXOIls/QTqF/bz7LDXsjnCp5aVjH2NOklHplQ1YnyV9F8BWgAxjGodyzy2nUyVJFpT1exrzfOAm79H7iYC/CPgNKOLMeCxYr6TEQs3PCkSJ3ZuYWEz9thLay3LJjKyXEWHye1KMvuCxJTcv/PrhFdhJ6/n8KMQMurGDxmppfbnACE3nFxyBPDcon5pwHxg0PTnPAvJvkF7CDIEMdBCtSFtmDnue1MuvZlER/33Zi1z/J0qNeTgrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB2596.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(66446008)(9686003)(64756008)(66946007)(66476007)(6916009)(66574015)(26005)(8676002)(66556008)(83380400001)(52536014)(76116006)(186003)(4326008)(71200400001)(86362001)(966005)(6506007)(53546011)(7696005)(5660300002)(2906002)(8936002)(7416002)(316002)(54906003)(55016002)(478600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CtRqY4DY7R2HzIBWwJz3+Qfinu6arJKbLk3Kw3QhpoBo09gAeigVWk897R5wVhRbRxYJi+3+rYJPnyQciLMxlkNvJNmaLnhxA2Vjnwb3xvo2YwjrE7RWZ0WT3hKcLG1S3tW1a1X+3ARQKHYvKGOlKJW+n8tkVuHXWJEL9/Ppy8dMAVAW9c12l9JBDPLvMq+4XlFMzCzQzfpcqkNgKNwrh91BdLM1RnoEjYOy3M6Nn7jN6bBIKNVzQ3q/Hh7OnxIftC2TLk6P/QDJy3kY6ma/Utb5ukf4VZG6eyDNrus8eoqAUw+HazEX7ca7bTU+AFu6GElcWZRPN83ya8LkEV2c9lovLNZXIRVOXqoE0pisJ/5p1YrIp0ouyb4+p/bhxU4WKf9gHWyfWxwBLLmE2NgWkGKvPeatJv5QxUg1DuaVZ4mTKD3N3U4x9nFCFSYT7sepXbLHHLm+QGuczRu6X0InPurVngAWFJm1fO5rIrzxzlAN52K5YRcE6iU51399BB7EUuU03eYytUzkgdqLAuqvHUqDOX4iBZqOBlZ9HfV2zVkPlyvSpxLgjViqa0x1nls53hw+pSEi+IKmx2OidpUbgYdPb8KFp3AjRzlfF+ifvwltoLJTJ5P5l3nulf5Lzanb0Pb+3zVIdQ/f+HfPFnmNrA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR03MB2596.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5998847-6277-4d12-bad9-08d84f203ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 09:11:58.4143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mwCePXegqvZoZbP5S5yBvUaJYPD4At5Eg5Y3d8inzr5Xmrqf+Y+W3eyTFxn5kMbVL6jTHIItlWkGav7Ra4FGEBXlYd8mwRjGXiDL4OE7FcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3137
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020085
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBNaXR0d29jaCwgMi4gU2VwdGVt
YmVyIDIwMjAgMTA6NTINCj4gVG86IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFlbC5IZW5uZXJp
Y2hAYW5hbG9nLmNvbT4NCj4gQ2M6IEFjZUxhbiBLYW8gPGFjZWxhbi5rYW9AY2Fub25pY2FsLmNv
bT47IEFyZGVsZWFuLCBBbGV4YW5kcnUNCj4gPGFsZXhhbmRydS5BcmRlbGVhbkBhbmFsb2cuY29t
PjsgV2lsbGlhbSBTdW5nDQo+IDx3aWxsaWFtLnN1bmdAYWR2YW50ZWNoLmNvbS50dz47IExhcnMt
UGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPjsNCj4gSm9uYXRoYW4gQ2FtZXJvbiA8amlj
MjNAa2VybmVsLm9yZz47IEhhcnRtdXQgS25hYWNrIDxrbmFhY2suaEBnbXguZGU+Ow0KPiBQZXRl
ciBNZWVyd2FsZC1TdGFkbGVyIDxwbWVlcndAcG1lZXJ3Lm5ldD47IGxpbnV4LWlpbyA8bGludXgt
DQo+IGlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsNCj4gQ2FtcGlvbiBLYW5nIDxDYW1waW9uLkthbmdA
YWR2YW50ZWNoLmNvbS50dz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaWlvOiBkYWM6IGFkNTU5
M3I6IER5bmFtaWNhbGx5IHNldCBBRDU1OTNSIGNoYW5uZWwNCj4gbW9kZXMNCj4gDQo+IFtFeHRl
cm5hbF0NCj4gDQo+IE9uIFdlZCwgU2VwIDIsIDIwMjAgYXQgMTE6MDkgQU0gSGVubmVyaWNoLCBN
aWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiA+IEZy
b206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gPiA+IFNl
bnQ6IE1vbnRhZywgMzEuIEF1Z3VzdCAyMDIwIDE0OjQ2DQo+ID4gPiBPbiBNb24sIEF1ZyAzMSwg
MjAyMCBhdCAyOjI4IFBNIEFjZUxhbiBLYW8NCj4gPiA+IDxhY2VsYW4ua2FvQGNhbm9uaWNhbC5j
b20+DQo+ID4gPiB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4gPiA+IFAuUy4gSm9uYXRoYW4sIGl0
IHNlZW1zIHRoaXMgZHJpdmVyIGhhcyBhcnRpZmljaWFsIEFDUEkgSElELiBXZQ0KPiA+ID4gcHJv
YmFibHkgaGF2ZSB0byByZW1vdmUgaXQuIEhvd2V2ZXIsIEFEUyBpcyBpbmRlZWQgcmVzZXJ2ZWQg
Zm9yIEFuYWxvZw0KPiBEZXZpY2VzIGluIFBOUCByZWdpc3RyeS4NCj4gPiA+IENhbiB3ZSBoYXZl
IEFEJ3Mgb2ZmaWNpYWwgYW5zd2VyIG9uIHRoaXM/DQo+ID4gPiBDYydpbmcgYWRkaXRpb25hbCBB
RCBwZW9wbGUuDQo+ID4NCj4gPiBBZ3JlZWQsIHRoaXMgSUQgd2FzIGNob3NlbiB1bmRlciB0aGUg
UE5QIElEIFZlbmRvciBTcGFjZSBmb3IgQW5hbG9nIERldmljZXMNCj4gSW5jLg0KPiA+IERheXMg
YmFjaywgSSBkaWQgYSBxdWljayBrZXJuZWwgZ3JlcCwgYW5kIHRoZXJlIGFyZSBtYW55IGRyaXZl
cnMgd2hpY2gNCj4gPiB1c2UgdGhlIDMtbGV0dGVyIFBOUCBJRCBhcyBhY3BpX2RldmljZV9pZC4g
U28sIEkgdGhvdWdodCB0aGlzIGJlaW5nIG5vdCBhbiBpc3N1ZS4NCj4gDQo+IE5vLCBubywgdGhl
IHVzZSBvZiBQTlAgSUQgaXMgbm90IGFuIGlzc3VlLiBUaGUgcG9pbnQgaXMgaWYgdGhlIElEIGlz
IGFydGlmaWNpYWwgb3INCj4gb2ZmaWNpYWwuDQo+IA0KPiA+IEknbSBhZ2FpbnN0IHJlbW92aW5n
IGl0IHNpbmNlIEkga25vdyBwZW9wbGUgc2hpcHBpbmcgdGhpcyBpbiB0aGVpciBBQ1BJIHRhYmxl
cw0KPiBhbHJlYWR5Lg0KPiANCj4gSSBzZWUuIENhbiB3ZSBjb25zaWRlciB0aGlzIGVtYWlsIGFz
IHRoZSBvZmZpY2lhbCBhbnN3ZXIgZnJvbSBBRCB0aGF0IHRoaXMgSUQgaXMNCj4gYmVpbmcgYWxs
b2NhdGVkIGZvciB0aGlzIGNlcnRhaW4gY29tcG9uZW50Pw0KDQpUbyBteSBrbm93bGVkZ2Ugb25s
eSBQTlAvQUNQSSB2ZW5kb3IgSURzIG5lZWQgdG8gYmUgcmVnaXN0ZXJlZCB3aXRoIHRoZSBVRUZJ
IA0KQUNQSSB3b3JraW5nIGdyb3VwLiBBRCBwYXJ0IG51bWJlcnMgYXJlIHVuaXF1ZS4gVGhlIElE
IGNob3NlbiB1c2VzIHRoZSANCnBhcnQgbnVtYmVyIHByZWZpeGVkIHdpdGggdGhlIFBOUCBWZW5k
b3IgSUQuIEFEeHh4eC0+QURTeHh4eA0KUGxlYXNlIGNvbnNpZGVyIHRoaXMgYXMgYWxsb2NhdGVk
Lg0KDQo+IA0KPiA+IFJlZ2FyZGluZyBBQ1BJIERTRCBjdXN0b21pemF0aW9uLCBvbmUgd2F5IHRv
IGRvIHRoaXMgaXMgdG8gbW92ZSB0aGlzIGludG8gdGhlDQo+IEJJT1MuDQo+ID4gVGhpcyB3YXkg
dGhlIHBhcnRpY3VsYXIgcGllY2Ugb2YgSFcgY2FuIGJlIGN1c3RvbWl6ZWQgcmF0aGVyIHRoYW4N
Cj4gPiBtYW5hZ2UgSFcgY29ubmVjdGlvbnMgaW4gc29mdHdhcmUuDQo+IA0KPiBBc3N1bWluZyB0
aGUgY29uZmlybWF0aW9uIG9uIHRoZSBhYm92ZSwgaW5kZWVkLCBvbmUgbWF5IHVzZSBBQ1BJIEhJ
RCB3aXRoDQo+IERTRCBwcm9wZXJ0aWVzIGluIHRoZSBmaXJtd2FyZS4gTWFpbiBwdXJwb3NlIG9m
IFBSUDAwMDEgaXMgdGhlDQo+ICpkZXZlbG9wbWVudCogc3RhZ2Ugb2YgdGhlIHByb2R1Y3QgYXQg
d2hpY2ggYSB2ZW5kb3Igc2hvdWxkIHRha2UgY2FyZSBhYm91dA0KPiBhbGxvY2F0aW9uIG9mIHBy
b3BlciBBQ1BJIElEcyBmb3IgdGhlIGNvbXBvbmVudHMgaW4gdXNlLiBZZXMsIEkga25vdyB0aGF0
IHRoaXMgaXMNCj4gbm90IGFsd2F5cyBmZWFzaWJsZSBiL2Mgc29tZSBIVyBjb21wb25lbnQgdmVu
ZG9ycyBkb24ndCBjYXJlIGFib3V0IEFDUEkgYXQNCj4gYWxsLg0KPiANCj4gLS0NCj4gV2l0aCBC
ZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KDQoNCkJlc3QgUmVnYXJkcywNCk1pY2hh
ZWwNCg0KQW5hbG9nIERldmljZXMgR21iSA0KTWljaGFlbCBIZW5uZXJpY2jCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCANCk90bC1BaWNoZXIgU3RyYXNzZSA2MC02
NA0KRC04MDgwNyBNdWVuY2hlbjsgR2VybWFueQ0KbWFpbDogbWljaGFlbC5oZW5uZXJpY2hAYW5h
bG9nLmNvbQ0KaHR0cDovL3d3dy5hbmFsb2cuY29tDQoNClNpdHogZGVyIEdlc2VsbHNjaGFmdCBN
w7xuY2hlbiwgUmVnaXN0ZXJnZXJpY2h0IE3DvG5jaGVuIEhSQiA0MDM2OCwNCkdlc2Now6RmdHNm
w7xocmVyOiBTdGVmYW4gU3RleWVybCwgVGhvbWFzIEVkd2FyZCBDcmliYmVuLCBNaWNoYWVsIFBh
dWwgU29uZGVsDQoNCg0K
