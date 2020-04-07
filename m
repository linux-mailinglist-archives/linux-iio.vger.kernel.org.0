Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89D551A0C16
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 12:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgDGKi1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 06:38:27 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:12306 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbgDGKi1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 06:38:27 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037AZTTQ008920;
        Tue, 7 Apr 2020 06:38:08 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0b-00128a01.pphosted.com with ESMTP id 3079ubeuav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 06:38:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/nq1hWp5gZVeO36P+MQM3t/dJv7AN1QfjmvVDI1P9rdRDdrLg4gh1S/qb+sNNf1MfAbc5EZo3uyUou0oOPPSIsljV5wRDax9DnJBdd7kKdadE92NgUt+8TLMFSyUQTCeSvxI8FHB84s7o+ryCC8YF1adoToMD2I4eSf+AOEuupRgaDkNHT1Qscq0+TsbDpeRgKqizefoLQBIszcgwhMZ1SM3uQGGs6BvI2Xxx1nJ/KebgNPdPNRoQfkNR2C+q6cwoIYXBmxwRwj5khW7kijsa5LN+UOQpyvTfYi1HbvY4nLQPHVCRzGWS/mt5SnYVhOQhQ+UscIdo28uCXgwlpm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TO40ABePxd5safs/k+mDjY7Dwy6y+f6AgdMpuuooC4=;
 b=DNBsnXDvOZjpKi7WNz7Xla9Q6mYvhxfe060jMSSjvoKQEswhWlV5Flz83QTw24lpJCrBkess1PA9tumTl2ZhcAT2vNCS89hdTKEpTxAnopMKLbwr12DW4pDD+jyBAeaGlp66kPIZtOIVhXvbvkURSpzU4722gBaIfi5a55QJ8SIRzPrEV3ES/tgTCScdJlFkxrnLHh3mJ8/bAnOmmc7wfAtfonR5+qaHaEHCvpri5rBC4V9rOWT+INQoYtogy/rBkFsm9uUT5j26+Gkpz9WsBVq8rDVQcjTKojwDQ/OTOF4w0lLQ/3+CA1VEwYUwOyg6lAtL2+8w73nHpu0aW0ls7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TO40ABePxd5safs/k+mDjY7Dwy6y+f6AgdMpuuooC4=;
 b=PjQlTISoBuZOpz1kn7gJ9b71HvPf0xqvlQpglSDz2mYxBu3nMwJ8SKntdMIUM1vYflfhB1yThoz8g+DIAaQNJtyGjXPWKZHYqBOEs9jJZQZBOEB/IHH3Rjo0e1WtCF17aQHbj06KlaSTVCy03culO/0HQI0bxDKa+YU34OX6JjM=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2418.namprd03.prod.outlook.com (2603:10b6:404:1d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Tue, 7 Apr
 2020 10:38:06 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 10:38:05 +0000
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
Thread-Index: AQHWDCVkOfz1b8oGSEWNSpsmzzycs6hsRgOAgAD0LqCAACjKAIAAAJRQgAAJQYCAAAr8kA==
Date:   Tue, 7 Apr 2020 10:38:05 +0000
Message-ID: <BN6PR03MB3347A09B7760F6F34086303899C30@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200406150846.878-1-nuno.sa@analog.com>
 <20200406150846.878-6-nuno.sa@analog.com>
 <CAHp75VeK8K0WHK3gDwyT3ZAaMaVdfZ5xVG94JY4O8fd2U0HEHg@mail.gmail.com>
 <BN6PR03MB33476ECFB3F8454CC6C67F0E99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
 <CAHp75VcOxjnNRetQxUR=8Z-WA=V6rzAFwCfhjNCmjQE3hgAEEA@mail.gmail.com>
 <BN6PR03MB33475380CFB1AD5B50026A6A99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
 <CAHp75VeAOKXNU+FEYsXBZ65sM1AWxB2zA+LJ2diAxyiJPk60mQ@mail.gmail.com>
In-Reply-To: <CAHp75VeAOKXNU+FEYsXBZ65sM1AWxB2zA+LJ2diAxyiJPk60mQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpHSmpPVFZqWkRNdE56aGlZaTB4TVdWaExUaGhORFV0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHUmlZemsxWTJRMExUYzRZbUl0TVRGbFlTMDRZ?=
 =?utf-8?B?VFExTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTkRFek5p?=
 =?utf-8?B?SWdkRDBpTVRNeU16QTNNamswT0RReU16TXlPREkzSWlCb1BTSnJUMXBqY2xC?=
 =?utf-8?B?UVZtbFRha1YzUmpVNFVYTlhWVTExYlZSaUwyczlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVTmlTbXRYWlhsQmVsZEJaRWd4VHpsWVVrcG1TMG93WmxVM01X?=
 =?utf-8?B?UkZiRGh2YTBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: df329c37-5fe2-4ff2-41e3-08d7dadfc1bd
x-ms-traffictypediagnostic: BN6PR03MB2418:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB24185671BC8EB621CD1862C399C30@BN6PR03MB2418.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(64756008)(2906002)(316002)(9686003)(54906003)(55016002)(76116006)(86362001)(66446008)(66946007)(66556008)(66476007)(52536014)(5660300002)(7696005)(8676002)(186003)(6916009)(6506007)(478600001)(107886003)(71200400001)(33656002)(4326008)(81156014)(8936002)(81166006)(53546011);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kpIl9BDZGKH7v3ESgbE19gP6KSlN9AHB6+xBPTr0h+6xxn7SwU5d4IIKBIwZ65kAloMClBQhrWjbwt47CtoIpcPcJ13zWcWdzs5kBeH5w0s7pKa+RKVdyfRD2r+UOxVnES49oSD2J3r0ZfYWfioLg6S8nG8hMSodhkDhfVlLksEkiX7Sf1EcxJ5wCAfx8Cwo7Jqcy5kdMNuSilRp+4SfY9bo8gzXuwZPEvAq2qomLV0cNDN0/fEFG/4S+LXobcTE31ARtp3lThQ776XTYonL7lOUlTPuo45kveI4azUvYV3S+0ED5WKCtrvNnB0wohHGeLqEdZbHDudzFdKN/Vnz3W7ns1K3eFTayJM8mJrRI2Rh5N8gP5dORrBwedvDDkVQQwQTlelw+Djv01wbQluZjEQgZh1z/inOf2NfTPlvpsNpb6cDsJb60oKUiAZtE4Ob
x-ms-exchange-antispam-messagedata: PpUQNJiZpX64f/31bB3Y102GMsSjOQT0oY+7AWQ6VUvNrYOI77lRLc1cQUVUkWuUCNDh8+kiVziF7A8q8KA9wpoKUoRYEFSN/BD/mOzxODyrjwBswIDbcgNwLGuQ1cmvl7GGQLMxBu/H6ztiFPG8lWCNFaddBj1xF/bvMUb8V32SNduN8sZ7kRb5pUbmbx2kHobmySd3mfXERY+Db0ECPA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df329c37-5fe2-4ff2-41e3-08d7dadfc1bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 10:38:05.7623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2wT4a+qIgmybej0NhXKQXfXz5z8RjFaiGWSm0NnsEOBJJ+AW9C1brAwdYbpPKBSNrmeng3QA0XuZ2gRk8PRCpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2418
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_03:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070091
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBsaW51eC1paW8tb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1paW8tb3duZXJA
dmdlci5rZXJuZWwub3JnPg0KPiBPbiBCZWhhbGYgT2YgQW5keSBTaGV2Y2hlbmtvDQo+IFNlbnQ6
IERpZW5zdGFnLCA3LiBBcHJpbCAyMDIwIDExOjU1DQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBh
bmFsb2cuY29tPg0KPiBDYzogbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3JnPjsg
ZGV2aWNldHJlZQ0KPiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBDYW1l
cm9uIDxqaWMyM0BrZXJuZWwub3JnPjsNCj4gSGFydG11dCBLbmFhY2sgPGtuYWFjay5oQGdteC5k
ZT47IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPjsgUGV0ZXIgTWVlcndh
bGQtU3RhZGxlciA8cG1lZXJ3QHBtZWVydy5uZXQ+OyBSb2INCj4gSGVycmluZyA8cm9iaCtkdEBr
ZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47DQo+IEFyZGVs
ZWFuLCBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRlbGVhbkBhbmFsb2cuY29tPjsgSGVubmVyaWNo
LA0KPiBNaWNoYWVsIDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY0IDUvNl0gaWlvOiBpbXU6IEFkZCBzdXBwb3J0IGZvciBhZGlzMTY0NzUNCj4g
DQo+IE9uIFR1ZSwgQXByIDcsIDIwMjAgYXQgMTI6MjYgUE0gU2EsIE51bm8gPE51bm8uU2FAYW5h
bG9nLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5z
aGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gPiA+IFNlbnQ6IERpZW5zdGFnLCA3LiBBcHJpbCAyMDIw
IDExOjE5DQo+ID4gPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gPiA+IENj
OiBsaW51eC1paW8gPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBkZXZpY2V0cmVlDQo+ID4g
PiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0Br
ZXJuZWwub3JnPjsNCj4gPiA+IEhhcnRtdXQgS25hYWNrIDxrbmFhY2suaEBnbXguZGU+OyBMYXJz
LVBldGVyIENsYXVzZW4NCj4gPiA+IDxsYXJzQG1ldGFmb28uZGU+OyBQZXRlciBNZWVyd2FsZC1T
dGFkbGVyIDxwbWVlcndAcG1lZXJ3Lm5ldD47DQo+IFJvYg0KPiA+ID4gSGVycmluZyA8cm9iaCtk
dEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47DQo+ID4g
PiBBcmRlbGVhbiwgQWxleGFuZHJ1IDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT47IEhl
bm5lcmljaCwNCj4gPiA+IE1pY2hhZWwgPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+DQo+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDUvNl0gaWlvOiBpbXU6IEFkZCBzdXBwb3J0IGZv
ciBhZGlzMTY0NzUNCj4gDQo+IC4uLg0KPiANCj4gPiA+ID4gPiA+ICsgICAgICAgZm9yX2VhY2hf
c2V0X2JpdChiaXQsIGluZGlvX2Rldi0+YWN0aXZlX3NjYW5fbWFzaywNCj4gPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICBpbmRpb19kZXYtPm1hc2tsZW5ndGgpIHsNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IE9uZSBsaW5lPw0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEl0IGdv
ZXMgYmV5b25kIDgwIGNvbCBsaW1pdC4uLiBJIGtub3cgSSBjb3VsZCBpbml0aWFsaXplIHRoZXNl
IHRvIHNvbWUgbG9jYWwNCj4gPiA+IGNvbnN0IGJ1dC4uLg0KPiA+ID4NCj4gPiA+IFRoYXQncyB3
aHkgcXVlc3Rpb24gbWFyayBpcyB0aGVyZS4NCj4gPiA+IE5vbmV0aGVsZXNzLCBpZiBpdCB+Mi0z
IGNoYXJhY3RlcnMgbW9yZSwgSSB3b3VsZCBsZWF2ZSBpdCBvbiBvbmUgbGluZQ0KPiBhbnl3YXku
DQo+ID4gPg0KPiA+ID4gSkZZSTogcmVhZGFiaWxpdHkgaGFzIGEgcHJpb3JpdHkgb3ZlciA4MCBs
aW1pdC4NCj4gPiA+DQo+ID4NCj4gPiBUaGFua3MhIEkgd291bGQgc2F5IGl0IGFsc28gZGVwZW5k
cyBvbiB0aGUgbWFpbnRhaW5lciAobm90IHN1cmUpPyBTb21lIGFyZQ0KPiBtb3JlDQo+ID4gc3Ry
aWN0IGFib3V0IGNoZWNrcGF0Y2guLi4NCj4gPiBCdHcsIHRoZSBsaW5lIHdpbGwgaGF2ZSA4NCBp
ZiBvbmUgbGluZXIuLi4NCj4gDQo+IExldCdzIGxlYXZlIGl0IHRvIG1haW50YWluZXIgdGhlbi4N
Cj4gDQo+ID4gPiA+ID4gPiArICAgICAgIH0NCj4gDQo+IC4uLg0KPiANCj4gPiA+ID4gPiA+ICsg
ICAgICAgaXJxX3R5cGUgPSBpcnFkX2dldF90cmlnZ2VyX3R5cGUoZGVzYyk7DQo+ID4gPiA+ID4g
PiArICAgICAgIGlmIChpcnFfdHlwZSA9PSBJUlFGX1RSSUdHRVJfUklTSU5HKSB7DQo+ID4gPg0K
PiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHBvbGFyaXR5ID0gMTsNCj4gPiA+DQo+ID4gPiBG
b3IgdGhlIHNha2Ugb2YgY29uc2lzdGVuY3kgSSB3b3VsZCBhc3NpZ24gaXJxX2ZsYWcgaGVyZSBh
cyB3ZWxsLg0KPiA+ID4NCj4gPg0KPiA+IFRoZSBsaWJyYXJ5IHdpbGwgZG8gaXQgYnkgZGVmYXVs
dCwgQnV0IHRoYXQncyBtZSB1c2luZyAiaW5zaWRlIiBpbmZvLi4uIG9yIG1heWJlDQo+IGlmDQo+
ID4gSSBkb2N1bWVudCB0aGF0IGluIHBhdGNoIDIgKHRoZSBzdHJ1Y3Qga2VybmVsIGRvY3MpIHdl
IHdvdWxkIG5vdCByZWFsbHkNCj4gbmVlZCB0bw0KPiA+IGFzc2lnbiBpdCBoZXJlPw0KPiANCj4g
SSBzZWUgbm93LiBGcm9tIG15IHBvaW50IG9mIHZpZXcgdGhlIGxpYnJhcnkgaGVyZSBkb2VzIGFu
IGlsbCB0dXJuDQo+IGJlY2F1c2UgaXQgaGlkZXMgc29tZSBkZXRhaWxzIHdoaWNoIGRyaXZlciBu
ZWVkcyB0byBkbyBhbnl3YXkuDQo+IEkgcHJlZmVyIGV4cGxpY2l0IG92ZXIgaW1wbGljaXQgYXQg
bGVhc3QgaGVyZS4NCj4gDQoNCkxldCdzIGV4cGxpY2l0bHkgYXNzaWduIHRoZSBpcnFfZmxhZyB0
aGVuLi4uDQoNCj4gSSB3b3VsZCBzYXkgb2theSwgaWYgdGhlcmUgaXMgbm8gc3VjaCBjb2RlIChs
aWtlIGJlbG93KSB3b3VsZCBiZQ0KPiBwcmVzZW50IGluIHRoZSBkcml2ZXIuDQoNCk5vdyB0aGF0
IEkgdGhpbmsgYWJvdXQsIHRoaXMgaXMgYWN0dWFsbHkgY29kZSB0aGF0LCBwcm9iYWJseSwgY291
bGQgZ28gaW5zaWRlIHRoZQ0KbGlicmFyeSBzaW5jZSB0aGlzIGlzIHByZXR0eSBzdGFuZGFyZCBm
b3IgdGhpcyBraW5kIG9mIGRldmljZXMuIEFueXdheXMsIHRoYXQncw0KYW5vdGhlciBzdG9yeS4u
Lg0KDQotIE51bm8gU8OhDQo+ID4gPiA+ID4gPiArICAgICAgIH0gZWxzZSBpZiAoaXJxX3R5cGUg
PT0gSVJRRl9UUklHR0VSX0ZBTExJTkcpIHsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBw
b2xhcml0eSA9IDA7DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgc3QtPmFkaXMuaXJxX2Zs
YWcgPSBJUlFGX1RSSUdHRVJfRkFMTElORzsNCj4gPiA+ID4gPiA+ICsgICAgICAgfSBlbHNlIHsN
Cj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKCZzcGktPmRldiwgIkludmFsaWQg
aW50ZXJydXB0IHR5cGUgMHgleA0KPiBzcGVjaWZpZWRcbiIsDQo+ID4gPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBpcnFfdHlwZSk7DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAg
cmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IEhlcmUgaXMgdGhlIHByb2JsZW0uIFlvdSBnb3QgdHlwZSwgYnV0IHlvdSBjb21wYXJlIGl0
IHRvIGZsYWdzLiBJdCdzDQo+ID4gPiA+ID4gbm90IGNvcnJlY3QuDQo+ID4gPiA+ID4gQWx0aG91
Z2ggdmFsdWVzIGFyZSB0aGUgc2FtZSwgdGhlIG1lYW5pbmcgaXMgZGlmZmVyZW50Lg0KPiA+ID4g
PiA+DQo+ID4gPiA+DQo+ID4gPiA+IEhtbSwgdGhhbmtzISBIb25lc3RseSwgdGhpcyB3YXMgY29w
eSBwYXN0ZSBmcm9tIGFkaXMxNjQ4MCBhbmQgSSBuZXZlcg0KPiA+ID4gcmVhbGl6ZWQgdGhpcy4g
SSB3aWxsDQo+ID4gPiA+IHVzZSBJUlFfVFlQRV9FREdFX1JJU0lORyBhbmQgSVJRX1RZUEVfRURH
RV9GQUxMSU5HLg0KPiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNo
ZW5rbw0K
