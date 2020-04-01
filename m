Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C023419ACD7
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbgDAN14 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 09:27:56 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:49402 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732166AbgDAN1z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 09:27:55 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031DJp2S008379;
        Wed, 1 Apr 2020 09:27:33 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e6n2f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 09:27:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzQwyA+qklmn6ACorHOcmo1AkCXQ+8Doc919V+w0M1r+fu5SHXAgJ3l2z/BVpsecVpy+Mrj9i0BZqm60uDhbTA8CoOxWvitd6VsoZtKM5+Keo0C4h53LsgzwLZWjv1MM/ZqMX6sYgun4yuVnbgrUIGi1werTkQDNrcoxQHPW3EdwJ4ZbZoA9xG3Lnul+e/ALXiLQ2enGmqbNj1M7EKMszvZn3DeTgkV5cZ1biKpFSrtiR+SAu+cQyB7L2N3GyFswbMk6VXt3BKXuN8S5PV3vaFyBy4rBPTh1VGnygVlMLd86BZJzL4+KY7vUGUyXLZngG7McP5xIq6BCszqCdi4x8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz1V17715L0EavdQ8+RQMWFqCw8xIzOSRm+qA7yh8Ck=;
 b=hp6Sn4XQMl7GASBLprP+xmEcpD36jrRtPhd6w/tc00rFcM2I2vKM2zZfupTVILgTHvtLKIFsWqUaYs3GKve8eVIq4V5EB3cDJEWYVWnRrm3g9jtlMAnn8xBfNwyj+2DoW+0j0SyHoppd9Sn+DxX1icq3WOVbLwVjwYnleWXCD+Ar8BV6azFgj41vVIlsXB/xRiHeBtCgLfawGLup4jss8tsq3v4Z/Ftkvjk3fUsAINywMJJkg6pbmmIXhteR122MLzVxreOTFfXiai7KhERL4b6eak/31hRiFWzNg86CzHaDnHleYYoXsk1RMv5cRd1FjpCztIH3hPagSPxuIdstjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz1V17715L0EavdQ8+RQMWFqCw8xIzOSRm+qA7yh8Ck=;
 b=Xv6PYBMpVNceqT2QzAS2RgMkjq1LaLRoR78M46QBYuwwywpwyQXEe3WRjOq2Hdxm9Bn9uYAy1NaAw8HmuCpmzvn3WbZyv0i99hwzzmPUT76PFzmCl/i0CGn2mUedOx6vIQeiU0ApVs/p3iE9XgFCcEbP7uK6XDcencNSGPzL5Wk=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2948.namprd03.prod.outlook.com (2603:10b6:404:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Wed, 1 Apr
 2020 13:27:31 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 13:27:31 +0000
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
Subject: RE: [PATCH v3 5/6] iio: imu: Add support for adis16475
Thread-Topic: [PATCH v3 5/6] iio: imu: Add support for adis16475
Thread-Index: AQHWB1JdQRnhX3Zcn0CzNsZZpB/4wahjAhmAgADREuCAAD0vgIAAMSFQ
Date:   Wed, 1 Apr 2020 13:27:31 +0000
Message-ID: <BN6PR03MB3347E5ECF100EAD1453B577D99C90@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200331114811.7978-1-nuno.sa@analog.com>
 <20200331114811.7978-6-nuno.sa@analog.com>
 <CAHp75Vdxtn1gXi=xCJfGOkBYiWB2qsYQLTJyaEGiiFqHvELaHQ@mail.gmail.com>
 <BN6PR03MB3347862A4C434CCA8C1B1E2599C90@BN6PR03MB3347.namprd03.prod.outlook.com>
 <CAHp75VfuWMDR4dUmjsYgeMgNMcVDZKdKVCsZ5p6g0m3TLHi5UA@mail.gmail.com>
In-Reply-To: <CAHp75VfuWMDR4dUmjsYgeMgNMcVDZKdKVCsZ5p6g0m3TLHi5UA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE9EZGpZbVF5TW1RdE56UXhZeTB4TVdWaExUaGhNek10Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEZzNZMkprTWpKbExUYzBNV010TVRGbFlTMDRZ?=
 =?utf-8?B?VE16TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTmpVMk1p?=
 =?utf-8?B?SWdkRDBpTVRNeU16QXlNakV5TkRnMk9EVTBOVEkwSWlCb1BTSmtUVEJ6TUhK?=
 =?utf-8?B?ME1ESXJPR3BKZEc1VFZXeHdOWE54YlVGVk1HTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVSTRPVEJhUzB0UmFsZEJablZ5VldSSGEwVlJaMGdyTm5SU01H?=
 =?utf-8?B?RlJVa05CWTBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 729450ad-f57e-4671-796c-08d7d6406e52
x-ms-traffictypediagnostic: BN6PR03MB2948:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB29481E61861D3C2B517AE0BE99C90@BN6PR03MB2948.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(366004)(52536014)(4326008)(107886003)(71200400001)(55016002)(66476007)(186003)(7696005)(76116006)(86362001)(5660300002)(66946007)(9686003)(8936002)(64756008)(2906002)(6506007)(6916009)(8676002)(81166006)(53546011)(66556008)(54906003)(33656002)(316002)(478600001)(66574012)(81156014)(66446008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2paBh/eM7CQScisl6ANZumMp5evN//05zthZZpCuw2bFiYzYN0DO+jqh4AeOU14U1MOJ0eHPA8HCmzR3TRyMs5aDS5WXPC+ZOvQJFVM95e0/hs0uS54PL4oLrIdrmDFZOLJLMI1fxxompETLC1kIJ20xYHWucMfF+pGT0WtOUUw/1jZhR4yNDcCky9ZYgLyTGVKeh1GLMX4gwxInWWKqhMETXljDwG2xiOXDRIRRKv8ICIFqVdobk1MX6j+p0oLL7eSJ77G9i1BMB9IxaBq7UZP/7uBSEiusoh/diNnXT7Z0B0OHz4Yc8HPL60VILNKhYPaek9wFCgD7rQnCSp//5qSkVNy3pPPQGZIHH/6+0H6n5dR4X+zQ8EJ06uqOKXTKGDUXcBSDV3zMLT1ytcwNawQGwwAQ1u+R32oA1kXQ4KizllylJS+OWdGd+28iM1r2
x-ms-exchange-antispam-messagedata: zX4NKeQk4oyzSmIpPPTqEVgm6PHt3CWmqmETSgjtNT/TCqK7fT6GFsGc1B7k7/KM6F+onsz58hgcdyD5qoP9X7YzX1uPPL0ScUDTrUXGoo0DCnFBJovlCr4muq7j+mA/jpFJYQCSlQ8lyFowDMAB+lp3VSSE9eKGViLituNFE/IGi0bdcMhixzphvFenyuIM+KU1lWW4hYb5E064fi7kMw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729450ad-f57e-4671-796c-08d7d6406e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 13:27:31.0376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3aCmij1YZf0qU1w3Pz9FltcHgCcC0Mf4ujYqdSQNw2GVYRML0nImWF8aYF4B+Eo1PniMvlgi8LxXMMtYRdw5Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2948
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010121
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBsaW51eC1paW8tb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1paW8tb3duZXJA
dmdlci5rZXJuZWwub3JnPiBPbg0KPiBCZWhhbGYgT2YgQW5keSBTaGV2Y2hlbmtvDQo+IFNlbnQ6
IE1pdHR3b2NoLCAxLiBBcHJpbCAyMDIwIDEyOjIzDQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBh
bmFsb2cuY29tPg0KPiBDYzogbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3JnPjsg
ZGV2aWNldHJlZQ0KPiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBDYW1l
cm9uIDxqaWMyM0BrZXJuZWwub3JnPjsNCj4gSGFydG11dCBLbmFhY2sgPGtuYWFjay5oQGdteC5k
ZT47IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPjsNCj4gUGV0ZXIgTWVlcndh
bGQtU3RhZGxlciA8cG1lZXJ3QHBtZWVydy5uZXQ+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBr
ZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IEFyZGVsZWFu
LA0KPiBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRlbGVhbkBhbmFsb2cuY29tPjsgSGVubmVyaWNo
LCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYzIDUvNl0gaWlvOiBpbXU6IEFkZCBzdXBwb3J0IGZvciBhZGlzMTY0NzUNCj4g
DQo+IE9uIFdlZCwgQXByIDEsIDIwMjAgYXQgMTA6MTMgQU0gU2EsIE51bm8gPE51bm8uU2FAYW5h
bG9nLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5z
aGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gPiA+IFNlbnQ6IERpZW5zdGFnLCAzMS4gTcOkcnogMjAy
MCAyMDoxNg0KPiA+ID4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+ID4gPiBD
YzogbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3JnPjsgZGV2aWNldHJlZQ0KPiA+
ID4gPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNA
a2VybmVsLm9yZz47DQo+ID4gPiBIYXJ0bXV0IEtuYWFjayA8a25hYWNrLmhAZ214LmRlPjsgTGFy
cy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28uZGU+Ow0KPiA+ID4gUGV0ZXIgTWVlcndh
bGQtU3RhZGxlciA8cG1lZXJ3QHBtZWVydy5uZXQ+OyBSb2IgSGVycmluZw0KPiA+ID4gPHJvYmgr
ZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+Ow0KPiBB
cmRlbGVhbiwNCj4gPiA+IEFsZXhhbmRydSA8YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+
OyBIZW5uZXJpY2gsIE1pY2hhZWwNCj4gPiA+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29t
Pg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyA1LzZdIGlpbzogaW11OiBBZGQgc3VwcG9y
dCBmb3IgYWRpczE2NDc1DQo+ID4gPiBPbiBUdWUsIE1hciAzMSwgMjAyMCBhdCAyOjQ5IFBNIE51
bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPiA+ID4g
PiArI2luY2x1ZGUgPGFzbS91bmFsaWduZWQuaD4NCj4gDQo+ID4gSSB0aG91Z2h0IHdlIHdhbnRl
ZCBhbHBoYWJldGljIG9yZGVyLi4uDQo+IA0KPiBZZXMsIGJ1dCBmcm9tIG1vcmUgZ2VuZXJpYyBo
ZWFkZXIgZ3JvdXBzIHRvIGxlc3MgZ2VuZXJpYy4gSW5zaWRlIGVhY2gNCj4gZ3JvdXAgaXMgYWxw
aGFiZXRpY2FsLg0KPiBhc20vIGlzIGxlc3MgZ2VuZXJpYyB0aGFuIGxpbnV4Ly4NCj4NCg0KR290
IGl0Li4uDQoNCj4gPiA+IFVzdWFsbHkgaXQgZ29lcyBhZnRlciBsaW51eC8qDQo+IA0KPiA+ID4g
PiArI2luY2x1ZGUgPGxpbnV4L2JpdGZpZWxkLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgv
Yml0b3BzLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ID4gPiA+ICsjaW5j
bHVkZSA8bGludXgvZGVidWdmcy5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+
DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQo+ID4gPg0KPiA+ID4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiA+ID4NCj4gPiA+IFdoYXQgdGhpcyBpcyBmb3I/DQo+
ID4gPg0KPiA+IFllcHMuIE5vdCByZWFsbHkgbmVlZGVkLi4uDQo+IA0KPiBJIHRoaW5rIHlvdSBu
ZWVkZWQgaXQgZm9yIERJVl9ST1VORF9VUCBvciBhbGlrZSBtYWNyb3MuIEl0IGFsc28gaGFzDQo+
IGNvbnRhaW5lcl9vZi4uLg0KPiANCg0KWWVzLCBESVZfUk9VTkRfQ0xPU0VTVCBpcyBkZWZpbmVk
IHRoZXJlLi4uDQoNCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9paW8vYnVmZmVyLmg+DQo+ID4g
PiA+ICsjaW5jbHVkZSA8bGludXgvaWlvL2lpby5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4
L2lpby9pbXUvYWRpcy5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2lpby9zeXNmcy5oPg0K
PiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2lpby90cmlnZ2VyX2NvbnN1bWVyLmg+DQo+ID4gPiA+
ICsjaW5jbHVkZSA8bGludXgvaXJxLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxl
Lmg+DQo+ID4gPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiA+ID4N
Cj4gPiA+IERvIHlvdSByZWFsbHkgbmVlZCB0aGlzPyBQZXJoYXBzIG1vZF9kZXZpY2V0YWJsZS5o
IGlzIHdoYXQgeW91IGFyZQ0KPiBsb29raW5nDQo+ID4gPiBmb3IuDQo+ID4gPg0KPiA+DQo+ID4g
WWVzLiBGb3IgYCBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEgYGAuIElmIGNoYW5nZWQgYnkNCj4g
YGRldmljZV9nZXRfbWF0Y2hfZGF0YWAsIHRoZW4gSSBndWVzcw0KPiA+IEkgY2FuIGRyb3AgaXQu
Lg0KPiANCj4gUHJvYmFibHkgY2hhbmdlIHRvIG1vZF9kZXZpY2V0YWJsZS5oIHdpdGggcHJvcGVy
dHkuaC4NCj4gDQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvc3BpL3NwaS5oPg0KPiANCj4gLi4u
DQo+IA0KPiA+ID4gPiArICAgICAgIGZvciAoaSA9IEFSUkFZX1NJWkUoYWRpczE2NDc1XzNkYl9m
cmVxcykgLSAyOyBpID49IDE7IGktLSkgew0KPiA+ID4NCj4gPiA+IFdoeSB0aG9zZSBtYXJnaW5z
PyBzaXplLTIgYW5kIDEgPw0KPiA+ID4NCj4gPg0KPiA+IFRoZSAtMiBpcyBuZWVkZWQgc2luY2Ug
aW5kZXggNyBpcyBub3QgdmFsaWQuIFRoZSAxIEkgaG9uZXN0bHkgZG9uJ3QgcmVtZW1iZXINCj4g
d2h5IEkgZGlkIGl0DQo+ID4gbGlrZSB0aGlzLiBVc2luZyA+IDAgaXMgdGhlIHNhbWUgYW5kIG1v
cmUgImNvbW1vbiIuLi4NCj4gDQo+IE1vcmUgY29tbW9uIGlzID49IDAuIFRoYXQncyBteSBxdWVz
dGlvbiBiYXNpY2FsbHkuDQo+IEFuZCBpZiA3IGlzIG5vdCB2YWxpZCB3aHkgdG8ga2VlcCBpdCBp
biB0aGUgYXJyYXkgYXQgYWxsPw0KDQpXZWxsLCBJIGNhbiByZW1vdmUgdGhlIDcuIEkgaG9uZXN0
bHkgdG9vayBpdCBmcm9tIGFub3RoZXIgZHJpdmVyIGFuZCBJIGd1ZXNzIHRoZSBpZGVhDQppcyB0
byBtYWtlIGV4cGxpY2l0IHRoYXQgNyBpcyBub3Qgc3VwcG9ydGVkLiBTaW5jZSB0aGlzIGlzIGEg
MyBiaXQgZmllbGQgYW5kIHRoZSBkYXRhc2hlZXQNCmRvZXMgbm90IHN0YXRlIHRoaXMgZGlyZWN0
bHkuDQoNCkFzIGZvciB0aGUgPj0wLCBJIHByZWZlciB0byBoYXZlIGVpdGhlciBhcyBpcyBvciA+
MCBzaW5jZSB3ZSBkb24ndCByZWFsbHkgbmVlZCB0byBjaGVjayB0aGUNCmluZGV4IDAuIElmIDEg
ZmFpbHMsIHRoZW4gd2Ugd2lsbCB1c2UgMCBlaXRoZXIgd2F5Li4uDQoNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIGlmIChhZGlzMTY0NzVfM2RiX2ZyZXFzW2ldID49IGZpbHRlcikNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiA+ICsgICAgICAgfQ0KPiANCj4g
Li4uDQo+IA0KPiA+ID4gPiArI2RlZmluZSBBRElTMTY0NzVfR1lST19DSEFOTkVMKF9tb2QpIFwN
Cj4gPiA+ID4gKyAgICAgICBBRElTMTY0NzVfTU9EX0NIQU4oSUlPX0FOR0xfVkVMLCBJSU9fTU9E
XyAjIyBfbW9kLCBcDQo+ID4gPiA+ICsgICAgICAgQURJUzE2NDc1X1JFR18gIyMgX21vZCAjIyBf
R1lST19MLCBBRElTMTY0NzVfU0NBTl9HWVJPXw0KPiAjIw0KPiA+ID4gX21vZCwgMzIsIFwNCj4g
PiA+ID4gKyAgICAgICAzMikNCj4gPiA+DQo+ID4gPiBJdCdzIG5vdCBvYnZpb3VzIHRoYXQgdGhp
cyBpcyBtYWNybyBpbnNpZGUgbWFjcm8uIENhbiB5b3UgaW5kZW50IGJldHRlcj8NCj4gPiA+IERp
dHRvIGZvciB0aGUgcmVzdCBzaW1pbGFyIG9uZXMuDQo+ID4gPg0KPiA+DQo+ID4gSG9uZXN0bHkg
aGVyZSBJIGRvbid0IHNlZSBhbnkgcHJvYmxlbXMgd2l0aCBpbmRlbnRhdGlvbiBhbmQgaXQgZ29l
cyBpbg0KPiBjb25mb3JtaXR5IHdpdGgNCj4gPiBvdGhlciBJTVUgZHJpdmVycyBhbHJlYWR5IGlu
IHRyZWUuIFNvIGhlcmUsIGFzIGxvbmcgYXMgYW55b25lIGVsc2UgaGFzIGENCj4gcHJvYmxlbSB3
aXRoIHRoaXMsIEkgcHJlZmVyDQo+ID4gdG8ga2VlcCBpdCB0aGlzIHdheS4uLg0KPiANCj4gSSdt
IG5vdCBhIG1haW50YWluZXIsIG5vdCBteSBjYWxsIDotKQ0KPiANCj4gLi4uDQo+IA0KPiA+ID4g
PiArICAgICAgIGJ1ZmZlciA9ICh1MTYgKilhZGlzLT5idWZmZXI7DQo+ID4gPg0KPiA+ID4gV2h5
IHRoZSBjYXN0aW5nIGlzIG5lZWRlZD8NCj4gPiA+DQo+ID4gPiA+ICsgICAgICAgY3JjID0gZ2V0
X3VuYWxpZ25lZF9iZTE2KCZidWZmZXJbb2Zmc2V0ICsgMl0pOw0KPiA+ID4NCj4gPiA+IElmIHlv
dXIgYnVmZmVyIGlzIGFsaWduZWQgaW4gdGhlIHN0cnVjdHVyZSwgeW91IG1heSBzaW1wbGUgdXNl
DQo+IGJlMTZfdG9fY3B1KCkuDQo+ID4gPiBTYW1lIGZvciB0aGUgcmVzdCBvZiBnZXRfdW5hbGln
bmVkKigpIGNhbGxzLg0KPiA+ID4gT3IgZG8geW91IGhhdmUgdW5hbGlnbmVkIGRhdGEgdGhlcmU/
DQo+ID4NCj4gPiBUaGlzIGlzIGEgbmljZSBwb2ludC4gU28sIGhvbmVzdGx5IEkgbWFkZSBpdCBs
aWtlIHRoaXMgdG8ga2VlcCBjb25mb3JtaXR5IHdpdGgNCj4gb3RoZXIgZHJpdmVycyB3ZSBoYXZl
DQo+ID4gaW4gb3VyIGludGVybmFsIHRyZWUgKGluIHF1ZXVlIGZvciB1cHN0cmVhbSkgYW5kIEkg
YWxzbyB3b25kZXJlZCBhYm91dCB0aGlzLg0KPiBUaGUgb25seSBqdXN0aWZpY2F0aW9uIEkgY2Fu
DQo+ID4gZmluZCB0byB1c2UgdW5saWduZWQgY2FsbHMgaXMgdG8ga2VlcCB0aGlzIGluZGVwZW5k
ZW50IGZyb20gdGhlIEFESVMgbGliIChub3QNCj4gc3VyZSBpZiBpdCBtYWtlcyBzZW5zZSkgc2lu
Y2UNCj4gPiB3ZSBnZXQgdGhlIHBvaW50ZXIgZnJvbSB0aGUgbGlicmFyeSAoYWxsb2NhdGVkIHRo
ZXJlKS4NCj4gPg0KPiA+IE5vdywgaWYgSW0gbm90IG1pc3Npbmcgbm90aGluZyBvYnZpb3VzIHdl
IGNhbiBhY2Nlc3MgdGhlIGJ1ZmZlciBub3JtYWxseQ0KPiBzaW5jZSBpdCdzIGJlaW5nIGFsbG9j
YXRlZA0KPiA+IHdpdGgga21hbGxvYyB3aGljaCBtZWFucyB3ZSBoYXZlICBBUkNIX0tNQUxMT0Nf
TUlOQUxJR04gKHdoaWNoIGlzDQo+IGF0IGxlYXN0IDggaWYgSW0gbm90IG1pc3Rha2VuKS4NCj4g
PiBPbiB0b3Agb2YgdGhpcywgdGhlIGRldmljZSBzZW5kcyB0aGUgZGF0YSBhcyBuIDE2IGJpdHMg
c2VnbWVudHMuIFNvIGluIHRoZW9yeSwNCj4gSSBndWVzcyB3ZSBjYW4gZGl0Y2ggdGhlDQo+ID4g
b3ZlcmhlYWQgb2YgdGhlICp1bmFsaWduZWQgY2FsbHMgaWYgYW55IG9iamVjdGlvbnM/DQo+IA0K
PiBObyBvYmplY3Rpb25zIGZyb20gbXkgc2lkZSBhdCBsZWFzdC4NCj4gDQoNCkkgd2lsbCB3YWl0
IHRvIHNlZSBpZiBzb21lb25lIGVsc2UgaGFzIGFueXRoaW5nIHRvIGFkZCBhbmQgaWYgbm90LCBJ
IHdpbGwgY2hhbmdlIGl0DQp0byBub3JtYWwgYnVmZmVyIGFjY2Vzc2VzIChwcm9iYWJseSB1c2lu
ZyByZXN0cmljdGVkIHR5cGVzKS4NCg0KPiAuLi4NCj4gDQo+ID4gPiA+ICsgICAgICAgZGVzYyA9
IGlycV9nZXRfaXJxX2RhdGEoc3BpLT5pcnEpOw0KPiA+ID4NCj4gPiA+ID4gKyAgICAgICBpZiAo
IWRlc2MpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoJnNwaS0+ZGV2LCAiQ291
bGQgbm90IGZpbmQgSVJRICVkXG4iLCBzcGktPmlycSk7DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gLUVJTlZBTDsNCj4gPiA+ID4gKyAgICAgICB9DQo+ID4gPg0KPiA+ID4gSXMgdGhp
cyBldmVuIHBvc3NpYmxlPw0KPiANCj4gPiBJIGd1ZXNzLiBJZiBzb21lb25lIGRvZXMgbm90IGlu
Y2x1ZGUgaXQgaW4gZGV2aWNlIHRyZWUuLi4NCj4gDQo+IEhtbS4uLiBhbmQgdGhpcyBmdW5jdGlv
biB3aWxsIGJlIGNhbGxlZCBhbnl3YXk/DQo+IA0KDQpZZXMsIGl0IGlzIGNhbGxlZCBvbiBwcm9i
ZS4uLiBBbmQgd2Ugc2hvdWxkIGZhaWwgaWYgbm8gaW50ZXJydXB0IGlzIGdpdmVuDQppbiBkZXZp
Y2UgdHJlZS4gSXTigJlzIGEgcmVxdWlyZWQgcHJvcGVydHkuDQoNCi0gTnVubyBTw6ENCj4gLS0N
Cj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0K
