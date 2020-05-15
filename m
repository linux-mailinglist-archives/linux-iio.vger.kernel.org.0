Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712621D4DD3
	for <lists+linux-iio@lfdr.de>; Fri, 15 May 2020 14:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEOMhu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 08:37:50 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:46844 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbgEOMht (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 May 2020 08:37:49 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04FCUYNO000744;
        Fri, 15 May 2020 08:37:30 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0b-00128a01.pphosted.com with ESMTP id 3100xka2ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 May 2020 08:37:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjOFVw9KakWLfV2hW/jFRqSubyKIv+8b4O+5UOZxFaMzvjZlET0vjLYBNuDPfdgGtd6EIKwDXp9Bwf79g0d4zS5XknmeJ+puJS8QVAYkLDctnkYm+hu6+/MmljCK5kjTDMwCyUA9Vkng++6BQVFqXzc656Kh1Y/lsa3rGN6+h4l+Bhg6YygGf9l0xEV3VByslGnX40VT8PpMwVHY0bJHhGGcqslz/VzF9Wyzee3FYDpuMzSQuX8PhOC0hBlvm8381uXmRPcT7pwNLBErZDDtBhxshyW441Wg8hj2ZkobsffOCZffNfPysaxV7MsR2AO6lvClICABYcuAJzQd9so1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=af3F+SNXr4EauLYPKj1hD5sQopPH6iNkOYIqFLPMkyo=;
 b=n4Wg3YOdALMF/wslsdnPBeFbRHwnoXUu25l4uBmwwi781JMhLX73cwpB1KUSHjBtlqYYaDD+vpizSioP2JpvqAoGyidE8VjVfPFo5cTa6Q+mbTfptX2+0yafLwtjWf/dlwgDw3NtiDBD/xn73NiuDacvr6Plam/Udn+Y0jS06nZQz2mDP2QLzhhxbElc2pDEz6f/JkO/G2U9P3rq3n0efme+MPIZnQF4CSGHzbu7ooSp60UdbNtHdMl4LBnYZqA1lEWVV6CzWEsqkyNxqlljnxYNeFj/oeE5mZ/PCxarGMCq3ZTnDzEcVVe7OXVtKSkWheGHlOPNlBPEhhbij37VLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=af3F+SNXr4EauLYPKj1hD5sQopPH6iNkOYIqFLPMkyo=;
 b=rl3GHlViDHgRaQ24dUFz3W4O+1oD7bfq9RhcOtVTyAhf6kPdQUWdDg/E/NPi3eOTrud6D4rE9TSSLektcBJWWMPU+W5gaOZUXLt14zyn5QyJikTsb45h750IFBG7jaRZdQXZBIUIdmWdfNZ1HbqxXlli3c/20Ilc3UmvhbR1sZU=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2964.namprd03.prod.outlook.com (2603:10b6:404:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 12:37:28 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::21b1:c085:e156:cfe7]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::21b1:c085:e156:cfe7%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 12:37:28 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "ak@it-klinger.de" <ak@it-klinger.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Subject: RE: [PATCH v2 7/8] iio: core: simplify alloc alignment code
Thread-Topic: [PATCH v2 7/8] iio: core: simplify alloc alignment code
Thread-Index: AQHWKfIlEQ+thZzvFU2AhvRLBAoa1aiou+aggABNkoCAAAlrAA==
Date:   Fri, 15 May 2020 12:37:28 +0000
Message-ID: <BN6PR03MB3347D0598B1700D1A5C6974C99BD0@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
         <20200514131710.84201-8-alexandru.ardelean@analog.com>
         <BN6PR03MB33472A1B559F98E3BDCAB40B99BD0@BN6PR03MB3347.namprd03.prod.outlook.com>
 <1d89df334b08486e73ca181cf9035d9af8fbccf2.camel@analog.com>
In-Reply-To: <1d89df334b08486e73ca181cf9035d9af8fbccf2.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpEUTRNak0wWmpFdE9UWmhPQzB4TVdWaExUaGhOakV0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHUTBPREl6TkdZeUxUazJZVGd0TVRGbFlTMDRZ?=
 =?utf-8?B?VFl4TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTkRJeE1T?=
 =?utf-8?B?SWdkRDBpTVRNeU16UXdNVGs0TkRZME56QTNPVFl4SWlCb1BTSlNhMlE1Tkhw?=
 =?utf-8?B?RmN5OTNZVXAyYmxGcVNXbEdVMmhQVlhwS2VXODlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVSTFXR1kyVjNSVGNsZEJaVWRKV0RSek5GcE9iMDQwV1dobWFY?=
 =?utf-8?B?cG9hekpuTUVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVEJGU1VkeVowRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:24da:5501:cc3f:7631:1113:673f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65b2ea90-0c19-4b04-a35b-08d7f8ccbaca
x-ms-traffictypediagnostic: BN6PR03MB2964:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB29645F77EDC1AF2FD64B88AC99BD0@BN6PR03MB2964.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 40Tow1aDucQYrsK+d/WZD+fujG2LfhwKZG874lWihU6dTvUHGKWqg0Pe+EYzJh8d28NYSPKtKK/8PB4ccqcHAEM0gRYAj6MAxWCpegmeo6w0bec7Y/CrVKUGcEB8DWq6Q6cYbNYEVkcYIZAkOIbDy5ZdRnacBYMUCW10Zdb3ULwxoaghjQiouauSxJs9Kf6P02zXvGuJVG1p2Qyq3AJJxAHWVKaXQp4tHu0vUDSDok6ZybDB9Qb2N8ogt1nqQVOHguUXOzq0UP59qsS/yW9m61sCe7dccJpvqRYXsOkAP/Vdo/DiBbKtzrPjklNG4jFgI216GeQZQyQ84sIGRtJB5dFmhTQDR8FYexBQICEHdZUYXFe3p0uqsJMOuZToL67fKEiufe+3B5mClYZ8s4DsDkbbASUSphnUnQERiXqiTMWwYCyfjHsNo55Sk7v8RWHGRpyvCgXhPTu2E+Ed+DFFPNvJf+kMZH4vJkpmWe1KIPKXrGeBscMe2HOQ5Tgps5aMZwjxHsYqCrjfsGX6qBKVfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(376002)(136003)(366004)(39860400002)(8936002)(8676002)(966005)(2906002)(52536014)(86362001)(54906003)(6506007)(5660300002)(7696005)(110136005)(186003)(53546011)(71200400001)(316002)(9686003)(66446008)(66476007)(66946007)(76116006)(33656002)(7416002)(55016002)(66556008)(4326008)(64756008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RyjLRqbTJFec8VFYnuKEHnNFzZpsIPy426Pzj7iUP4vvfgTyQH1mR6fiUm/tc2mx2/cXuD1ARjWevxslffzQ8Z815Xa0jpexd1qsoFFUQXSFhRLfdTgJ1QW2zqkXFjM54Or3Kc5zNx9DaNgzRDykvP+iW8OatLgCOBSH+9HGaIFNK9SDLxWKw5qvbj+0bTRC/piORv/KV6pIjG/KdctGu9XIdSoe85/Ioensr0q93j113YWTGztzd236lFjxnH7r9/x6Nj5V6yo6dM0OJAdJ6hxAWm3m4r6eCPjaMBSLwhyPfF0s5AHWXnKcHmqyfYII2eGyk4xRFrGkg2Ld143mMCkcNqny3OXXJHao/MBcZXDNy5ie/d6J+BncDN9qZYUCjd0K2jcDULSHBZNHV9wmPRPbe4I5saX2VqUzQBl3RTPXrELaZYTOtKormc9b3Pepj8i/Pe01bdCERsQQ7Xq4jne4GAu/r4lUjc1UJnhNSHoWRCfC92vwN6+XoO2JwNNdSqvrryvDM0yYQKqQ9kimdbKZEWIAqDigBp2drLeG6yR9cJXAZt6o5c3lsTE3iByn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b2ea90-0c19-4b04-a35b-08d7f8ccbaca
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 12:37:28.4055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+Cusfkb72TpyxyW0n81uuyWeOd8FASNSw0EOHJJM8ANzNxEJ6Qp3F7mZr7rE6/NWplvMed3HLbGiEmGbFY+hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2964
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_05:2020-05-15,2020-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 malwarescore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150109
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBBcmRlbGVhbiwgQWxleGFuZHJ1IDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNv
bT4NCj4gU2VudDogRnJlaXRhZywgMTUuIE1haSAyMDIwIDEzOjQ4DQo+IFRvOiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXN0bTMyQHN0LW1kLQ0KPiBtYWlsbWFu
LnN0b3JtcmVwbHkuY29tOyBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPjsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IGx1ZG92aWMuZGVzcm9jaGVzQG1pY3JvY2hpcC5jb207IG5pY29sYXMuZmVycmVAbWljcm9jaGlw
LmNvbTsNCj4gYWxleGFuZHJlLnRvcmd1ZUBzdC5jb207IGFrQGl0LWtsaW5nZXIuZGU7IGppYzIz
QGtlcm5lbC5vcmc7DQo+IGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbTsgbWNvcXVlbGluLnN0
bTMyQGdtYWlsLmNvbTsNCj4gYWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MiA3LzhdIGlpbzogY29yZTogc2ltcGxpZnkgYWxsb2MgYWxpZ25tZW50
IGNvZGUNCj4gDQo+IE9uIEZyaSwgMjAyMC0wNS0xNSBhdCAwNzoxMiArMDAwMCwgU2EsIE51bm8g
d3JvdGU6DQo+ID4gSGV5IEFsZXgsDQo+ID4NCj4gPiBKdXN0IGEgc21hbGwgcXVlc3Rpb24uLi4N
Cj4gPg0KPiA+ID4gRnJvbTogbGludXgtaWlvLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgt
aWlvLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4gPiBPbiBCZWhhbGYgT2YgQWxleGFu
ZHJ1IEFyZGVsZWFuDQo+ID4gPiBTZW50OiBEb25uZXJzdGFnLCAxNC4gTWFpIDIwMjAgMTU6MTcN
Cj4gPiA+IFRvOiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LQ0KPiA+ID4gc3RtMzJAc3QtbWQtbWFpbG1hbi5z
dG9ybXJlcGx5LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gQ2M6IGx1
ZG92aWMuZGVzcm9jaGVzQG1pY3JvY2hpcC5jb207IGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNv
bTsNCj4gPiA+IGppYzIzQGtlcm5lbC5vcmc7IG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbTsN
Cj4gPiA+IGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tOyBhbGV4YW5kcmUudG9yZ3VlQHN0
LmNvbTsNCj4gPiA+IG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb207IGFrQGl0LWtsaW5nZXIuZGU7
IEFyZGVsZWFuLCBBbGV4YW5kcnUNCj4gPiA+IDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNv
bT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2MiA3LzhdIGlpbzogY29yZTogc2ltcGxpZnkgYWxs
b2MgYWxpZ25tZW50IGNvZGUNCj4gPiA+DQo+ID4gPiBUaGVyZSB3YXMgYSByZWNlbnQgZGlzY3Vz
c2lvbiBhYm91dCB0aGlzIGNvZGU6DQo+ID4gPiAgIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC0NCj4gPiA+DQo+IGlpby8yMDIwMDMyMjE2
NTMxNy4wYjFmMDY3NEBhcmNobGludXgvX187ISFBM05pOENTMHkyWSFwZ2RVU2F5SkNmeE1pRQ0K
PiA+ID4gdzhGcHYwTGtFWnVyQ1NrWDBzRWNMblhlRFNDTG1ocHUxeG9udDYtdkJRajNaYkN3JA0K
PiA+ID4NCj4gPiA+IFRoaXMgbG9va3MgbGlrZSBhIGdvb2QgdGltZSB0byByZXdvcmsgdGhpcywg
c2luY2UgYW55IGlzc3VlcyBhYm91dCBpdA0KPiA+ID4gc2hvdWxkIHBvcC11cCB1bmRlciB0ZXN0
aW5nLCBiZWNhdXNlIHRoZSBpaW9fZGV2IGlzIGhhdmluZyBhIGJpdCBvZiBhbg0KPiA+ID4gb3Zl
cmhhdWwgYW5kIHN0dWZmIGJlaW5nIG1vdmVkIHRvIGlpb19kZXZfcHJpdi4NCj4gPiA+DQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBh
bmFsb2cuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNv
cmUuYyB8IDEwICsrKy0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lp
by9pbmR1c3RyaWFsaW8tY29yZS5jIGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLQ0KPiA+ID4g
Y29yZS5jDQo+ID4gPiBpbmRleCBhMWIyOWUwZjhmZDYuLjc2NzFkMzZlZmFlNyAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMNCj4gPiA+ICsrKyBiL2Ry
aXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMNCj4gPiA+IEBAIC0xNTE0LDEzICsxNTE0LDkg
QEAgc3RydWN0IGlpb19kZXYgKmlpb19kZXZpY2VfYWxsb2MoaW50DQo+IHNpemVvZl9wcml2KQ0K
PiA+ID4gIAlzdHJ1Y3QgaWlvX2RldiAqZGV2Ow0KPiA+ID4gIAlzaXplX3QgYWxsb2Nfc2l6ZTsN
Cj4gPiA+DQo+ID4gPiAtCWFsbG9jX3NpemUgPSBzaXplb2Yoc3RydWN0IGlpb19kZXZfb3BhcXVl
KTsNCj4gPiA+IC0JaWYgKHNpemVvZl9wcml2KSB7DQo+ID4gPiAtCQlhbGxvY19zaXplID0gQUxJ
R04oYWxsb2Nfc2l6ZSwgSUlPX0FMSUdOKTsNCj4gPiA+IC0JCWFsbG9jX3NpemUgKz0gc2l6ZW9m
X3ByaXY7DQo+ID4gPiAtCX0NCj4gPiA+IC0JLyogZW5zdXJlIDMyLWJ5dGUgYWxpZ25tZW50IG9m
IHdob2xlIGNvbnN0cnVjdCA/ICovDQo+ID4gPiAtCWFsbG9jX3NpemUgKz0gSUlPX0FMSUdOIC0g
MTsNCj4gPiA+ICsJYWxsb2Nfc2l6ZSA9IEFMSUdOKHNpemVvZihzdHJ1Y3QgaWlvX2Rldl9vcGFx
dWUpLCBJSU9fQUxJR04pOw0KPiA+ID4gKwlpZiAoc2l6ZW9mX3ByaXYpDQo+ID4gPiArCQlhbGxv
Y19zaXplICs9IEFMSUdOKHNpemVvZl9wcml2LCBJSU9fQUxJR04pOw0KPiA+DQo+ID4gRG8gd2Ug
YWN0dWFsbHkgbmVlZCB0byBkbyB0aGUgYEFMSUdOYCBhZ2Fpbj8gSXQgc2VlbXMgdG8gbWUgdGhh
dA0KPiBgYWxsb2Nfc2l6ZQ0KPiA+ICs9IHNpemVvZl9wcml2YA0KPiA+IHdvdWxkIGJlIGVub3Vn
aCBvciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nIG9idmlvdXM/DQo+IA0KPiBXZWxsLCBpdCdzIG5v
dCBhbHdheXMgY2xlYXIgd2hhdCB2YWx1ZSAnc2l6ZW9mX3ByaXYnIGhhcywgYW5kIHdoZXRoZXIg
aXQgaXMNCj4gcHJvdmlkZWQgYWxyZWFkeSBhbGlnbmVkLg0KPiBUaGUgcmVxdWlyZW1lbnQgaXMg
dXN1YWxseSB0aGF0IHRoaXMgZGF0YSBiZSBjYWNoZWxpbmUgYWxpZ25lZC4NCj4gDQo+IFNvLCBz
aXplb2Yoc3RydWN0IGlpb19kZXZfb3BhcXVlKSBpcyBhbGlnbmVkIGFscmVhZHkgYSBmZXcgbGlu
ZXMgYWJvdmUsIGJ1dA0KPiB0aGUNCj4gcHJpdmF0ZSBpbmZvcm1hdGlvbiBzaG91bGQgYWxzbyBi
ZSBhbGlnbmVkIFtnaXZlbiB0aGF0IGl0J3MgYW4gdW5rbm93biB2YWx1ZQ0KPiBwcm92aWRlZCBi
eSB0aGUgZHJpdmVyXS4NCj4gSSB0aGluayB0aGlzIGlzIG1vc3RseSBpbXBvcnRhbnQsIGlmIHdl
IG5lZWQgdG8gZG8gRE1BIGFjY2VzcyB0byBidWZmZXJzDQo+IGFsbG9jYXRlZCBvbiB0aGUgZHJp
dmVyJ3Mgc3RhdGUtc3RydWN0LCB3aGljaCBpcyBhbGxvY2F0ZWQgaGVyZSwgYW5kIHdoaWNoIGlz
DQo+IHVzdWFsbHkgcHJvdmlkZWQgYXMgc2l6ZW9mX3ByaXYuDQoNClllcywgQUZBSVUgdGhpcyBp
cyB0byBndWFyYW50ZWUgdGhhdCB0aGUgcHJpdiBzdHJ1Y3Qgd2lsbCBzdGFydCBhdCBhbiBhZGRy
ZXNzIHRoYXQgaXMgDQpETUEgc2FmZSAoY2FjaGVsaW5lLWFsaWduZWQpLiBIZW5jZSwgaWYgdGhl
cmUgaXMgYW55IGRhdGEgaW4gJ3ByaXYnIHRoYXQgbmVlZHMgdG8gYmUgRE1BDQpzYWZlLCB3ZSBh
cmUgZmluZS4uLg0KDQpXZWxsLCBJIHdhcyBhbHNvIG1pc3JlYWRpbmcgdGhlIGNvZGUuIFN0aWxs
LCBJIHRoaW5rIGl0IHNob3VsZCBsb29rIHNvbWV0aGluZyBsaWtlOg0KDQpgYGBgDQphbGxvY19z
aXplID0gc2l6ZW9mKHN0cnVjdCBpaW9fZGV2X29wYXF1ZSkNCmlmIChzaXplb2ZfcHJpdikNCglh
bGxvY19zaXplICs9IEFMSUdOKGFsbG9jX3NpemUsIElJT19BTElHTik7DQpgYGBgDQoNCklmIHRo
ZXJlIGlzIG5vIHByaXYsIEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0aGUgcGFkZGluZyBieXRlcy4u
Lg0KDQotIE51bm8gU8OhDQoNCg==
