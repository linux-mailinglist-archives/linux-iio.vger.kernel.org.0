Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C3338DF63
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 04:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhEXCu5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 22:50:57 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:53574 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231896AbhEXCuy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 22:50:54 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14O2n5UX018750;
        Mon, 24 May 2021 02:49:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-0064b401.pphosted.com with ESMTP id 38qjghre56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 02:49:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/QqTIx4WGVNW4i/eHzKNDPl7K7L0N2SXXPK3l0rtcqqI6hgJvzOgjgCZyWrtXqaZNmU+AjO3pRcpI3Booxubmd2HiyN22mjtWWjX6dNgBO/XN+5j2eenu1520s4WuQWtLonHQawTi/M7TgSfGLQK8G/ZLAMsjN1t0u/+oMPaAwtCzXG67B1vvHsNsFKeIyM5wAlDKYHoRa+k+GwNQhZ/KmNva1QZgQmFS3ihJrtmWt6bQ2hgqo2FX1upwTwBcWp87lsMtNWhR7hGTMQWea0f8LX1NcFVfCLNpoiyjm8Nze80NCj25gimSo0AafFgwaSiDfLTKo94On3OPEEbcq1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSZKUCA2DxsypSVQdw4ev3t2FkVOQwfaMEuWdysoaBY=;
 b=ABN5dmSa0iRegafXLq7wTcIWA2nN5Y7GZ6EGlmliVzVG+fSmX6JVFlWTFBJSJID7qMTbE5FpCO/8jguNX243rGhEAWS2KrceI/hWd4G10N7sKiHyUnWM75E+mETMhlyLz6w9qWZeKfzhPHvY7J6Z9n96z2qrOXM3PjNrTUUHn8duLA/w+Aw46wKkPlIi0+gRz9E4mF1I6UhHN2Vs/YcBTjywpyBSXHTjORDFy2r3RgDroJqeIf6gug1zVS+hAyknoAq4FbhaqTgBaHZTWDzAYDNPcFdVtnZXR58G1aOTcSt9yBhb8absIaQhYFPawjSYpYCBPB3v3VLcvbxqD5aZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSZKUCA2DxsypSVQdw4ev3t2FkVOQwfaMEuWdysoaBY=;
 b=Ww6ciV/n6teC+u43xwMYAehdt9M83LgzU1Y4wMasIoqLbcGlpBsS9+T5eMRZ6GdfqYHcnie+f3Yi1bgQEtAo0P58l6vS5dVPBZt2bICjywjx6ld4PCyw5X2ooHAbt+0ifKI7rMIjLEc3vwY04jgbBxilAprnRDXdaXMncqYElPY=
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB5206.namprd11.prod.outlook.com (2603:10b6:510:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 02:49:01 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49%9]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 02:49:01 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Thread-Topic: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Thread-Index: AQHXRutZA2KT9UoVoUu9pd++4IrNe6rqkr4AgAOlZgCAA8QIcA==
Date:   Mon, 24 May 2021 02:49:01 +0000
Message-ID: <PH0PR11MB519159873BE8CB7ACA227826F1269@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20210512045725.23390-1-Meng.Li@windriver.com>
        <20210519092104.pntanimcjg6s6fca@pengutronix.de>
 <20210521180150.0f4d1b5d@jic23-huawei>
In-Reply-To: <20210521180150.0f4d1b5d@jic23-huawei>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [147.11.252.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a71b61bf-bed1-4401-9d7d-08d91e5e7cc6
x-ms-traffictypediagnostic: PH0PR11MB5206:
x-microsoft-antispam-prvs: <PH0PR11MB52061DDFA8BFF1F45732B5FDF1269@PH0PR11MB5206.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkxvOYoxH8H4yScHxcGnxNLA+524T/fkDJvzoZdWwet3XwiRcY1IYLqveRxiyxRlU+MoybrD9rQ02NA6Mq9Se1W6EekpMq89KzbqsEziysOvitS6owo+uLv8HFQarbEkF+rqmkZoluxHLhHXp8OJZwqtD4/O6ujqfs4+Sqt9h4dGQz0zcyvU456QoI3h/KHUpc1iKHcmzhEftSxH7rTPuRQ0J1hK48Wp/M1b8ulhPDewHcWMAzSqn6yO06ojX25sBLERn1fXpGBYgLPY6sG/WRHmen43/4mWbOCwsG87KIt/Cg7REbgynZbuWJWGIBRZz95+qljGC60CdzL6UIV4RGVf9UaONLMh11UDhL47rBaGuMexQ46YhpOsokof4kbG3g8O2fiHbOM+Zqwrotxnyl1ZV9GQMLPaOteCuYSwsl3O0vtAjVCGGfzhtAIPsAwD6hPuaK9EY3JkWbuQJOt5zVyOoKbGtz/7vEmGkOSMzuxxFqRgCevqfgBqIDMLOqGdR2s3FwVFqKcSAK4M2q8sJI7CxTOMll8ttfdcYdpcWVNOuvZZ4SR152IMap8GFxcZzieG//LOdMF1hmf0OyOOrYzJnYDfvlkuueBwDxFzd7w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(366004)(376002)(136003)(346002)(4326008)(38100700002)(316002)(55016002)(5660300002)(186003)(8936002)(8676002)(86362001)(110136005)(54906003)(64756008)(66556008)(66476007)(478600001)(122000001)(83380400001)(52536014)(66574015)(33656002)(53546011)(26005)(6506007)(9686003)(2906002)(66446008)(66946007)(76116006)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MXlFV29VQWpUaXpJMWdaak5mQksydSt3b0FaemRoRjcxSUNrcmVEc3BJUWk3?=
 =?utf-8?B?OXczUHhwZGxGMTB2RXcrM2ZiSmZyRGMzeDc0ZnpObG0zbS9zWndNNHZsR3NN?=
 =?utf-8?B?UVZ2dFNoWlJzb1p3cXJZSzZOdGloYXpRQ04zTGc3SStwcVdUdkNYcHJ6U0Rw?=
 =?utf-8?B?N3pTdG5MbDk3ZkRIbDNmUWJsNkpYV01sY0FBcVJRSFRIYTdDajV0YkxuUmJ6?=
 =?utf-8?B?amdBL0pMaHJDMktUMm9Lcy95U3BPY2xUWFVDL0dsVmVodnVyMk02YXE3MEdY?=
 =?utf-8?B?SjBPcW5ZWjI0OWtsVzRacnRNaTk2Zmg2S1YzNlNFUVQyNWxSVmo1T3B5Rnk2?=
 =?utf-8?B?UHFSNlhBZmhQWjVCOFFjVklsaEd4S0ZyNmVwMVBPV2QrZWVlOEx3eDN5bTd0?=
 =?utf-8?B?ZTRDbEZtRGQ2R3k1YjBJd3U5T05EU3NZcHV5T2pnS1N2WksrbkJBUXA3NkI2?=
 =?utf-8?B?KzNzNy9rYWFYWkpWREJNWWNFUUIzYXNXeHRRdGE0MUM2ZEg3NHRQMytXbWF6?=
 =?utf-8?B?UVRvN1RnaTRZWFNXbFFJVTNET2dtL2pYeFA4THA5WXFwY0YwTTdNVUJXK2o4?=
 =?utf-8?B?aFYvTFRnYTBXN2VER2RieE5JRnJnT284RnVqTGlFbVFsT1Exbk1FRm9lYjVs?=
 =?utf-8?B?U2c3ZkgzV0ZFaFhSVTZCOGs1Y2ZpV0s0cC92N0ZEOWJzdVZOWldSanVpU0o1?=
 =?utf-8?B?TlR2WmlpNzRpWkU2N2N2cUt3QUVuVDVIQ0hOejVzZHVHNUU2blZjQndUTXF5?=
 =?utf-8?B?TzNjSGZzdWpReUFhRTRLZ25pNDZ3L2JweHg1bHYyb0IxcWhpZmJnMkZPVWdl?=
 =?utf-8?B?MHQ2ZG5QbEduOG1lTldkeEErSElpeDNwTnc2MDV5aEFiKzc2K1lyZTJqbTZ0?=
 =?utf-8?B?dDFnRFNvbVRsT3hlcEkxcXhQRnp0M1RRMnoyZkxWRTJpbnorczhnRStrMy9t?=
 =?utf-8?B?cmhkR3lPSHBGYXFRSkJtU3V0Y0xnOTdHeENhaXVtcnRycndpVWRTSTU2T0s1?=
 =?utf-8?B?RWlMSUhSbGtWMHFQWFZCVWFDeThaTENYZ3JOdmtxUUxYNzZWUmtlclIzem1t?=
 =?utf-8?B?LzA4UVY1VmNnK3ZVa1dubXlVY0pBYW53VHQ3clRQSCtYaEpYNnE3dDA4YnpQ?=
 =?utf-8?B?VVFGSitIL20rRWVTQUxUK2dNOTJpQm9xZXBCd2dKVzBuUTZ0ZzUwaWtCWTBZ?=
 =?utf-8?B?V3BaMmdrSFdGMmpibTR3eXBkYVlmNUlrOEl0eTNNSWNOWkZQc2ZqTzNYYnYv?=
 =?utf-8?B?T2tPQktHV1dZcmU0cUtEVUN4VHltTHY2ekVTdERnZVh0UnNUekpoMUhIQmRC?=
 =?utf-8?B?TUltQWwxbkd0bkVKNzQxQXZrc0FaSmNSTDkrNCs5LzhFSWw4Q2tzU1hKZWNw?=
 =?utf-8?B?NU9vOE5jcVdUdWgyV0lDSnczSnBuZ1IvMlJ5VGVsTmNqeHBuZTYxYUErYkln?=
 =?utf-8?B?OERYenlZRVhGelJjZWkzMzlqTDlNeUNjc1JseUg4R0NmbHIxR3FUcnZrMXdq?=
 =?utf-8?B?VVRoRlBOc2VNdnVPeXB1YUNnNDZLeC9lM3ViOWZRU1pSSHVmUklwOG5LOFVZ?=
 =?utf-8?B?QlhlYVpvY2xwL2JuMFczenVRR01VbmpQaWJXTUZnQUpWK3E3ZDFvYytEQXB6?=
 =?utf-8?B?QlF0T3FURlR0QVZiNVk5SWFjd1pMK0h5OWw0SmhzZnNvSHVrazhyRSsxdWNk?=
 =?utf-8?B?elZRNmhxLzFJNnNJY0FvOThCM3BSZWwzTFRjWU1WeU9aYy9WV1gxMzFUQjlX?=
 =?utf-8?Q?jm9LjvqsEBEvSJyjG+/NmSpvXEOBV3tY2wr6khY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71b61bf-bed1-4401-9d7d-08d91e5e7cc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 02:49:01.6864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laCXy3jHun0oKAezh4lDhSnxXQo663ihq3MqLGDTIsFydWPPp1ahc5rmb2WFCRY1LTvR13kKGWVIQsBt5HeDfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5206
X-Proofpoint-GUID: F5vCKJB5NMEBoiUkR5-Xw5F1-EYkESrO
X-Proofpoint-ORIG-GUID: F5vCKJB5NMEBoiUkR5-Xw5F1-EYkESrO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_02:2021-05-20,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240019
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIE1heSAyMiwgMjAyMSAxOjAy
IEFNDQo+IFRvOiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4
LmRlPg0KPiBDYzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJpdmVyLmNvbT47IGxhcnNAbWV0YWZv
by5kZTsNCj4gTWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbTsgcG1lZXJ3QHBtZWVydy5uZXQ7
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1paW9Admdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRyaXZlcjogYWRjOiBsdGMyNDk3OiByZXR1cm4g
ZGlyZWN0bHkgYWZ0ZXIgcmVhZGluZyB0aGUgYWRjDQo+IGNvbnZlcnNpb24gdmFsdWUNCj4gDQo+
IFtQbGVhc2Ugbm90ZTogVGhpcyBlLW1haWwgaXMgZnJvbSBhbiBFWFRFUk5BTCBlLW1haWwgYWRk
cmVzc10NCj4gDQo+IE9uIFdlZCwgMTkgTWF5IDIwMjEgMTE6MjE6MDQgKzAyMDANCj4gVXdlIEts
ZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JvdGU6DQo+IA0K
PiA+IE9uIFdlZCwgTWF5IDEyLCAyMDIxIGF0IDEyOjU3OjI1UE0gKzA4MDAsIE1lbmcuTGlAd2lu
ZHJpdmVyLmNvbQ0KPiB3cm90ZToNCj4gPiA+IEZyb206IE1lbmcgTGkgPE1lbmcuTGlAd2luZHJp
dmVyLmNvbT4NCj4gPiA+DQo+ID4gPiBXaGVuIHJlYWQgYWRjIGNvbnZlcnNpb24gdmFsdWUgd2l0
aCBiZWxvdyBjb21tYW5kOg0KPiA+ID4gY2F0IC9zeXMvLi4uL2lpbzpkZXZpY2UwL2luX3ZvbHRh
Z2UwLXZvbHRhZ2UxX3Jhdw0KPiA+ID4gVGhlcmUgaXMgYW4gZXJyb3IgcmVwb3J0ZWQgYXMgYmVs
b3c6DQo+ID4gPiBsdGMyNDk3IDAtMDAxNDogaTJjIHRyYW5zZmVyIGZhaWxlZDogLUVSRU1PVEVJ
TyBUaGlzIGkyYyB0cmFuc2Zlcg0KPiA+ID4gaXNzdWUgaXMgaW50cm9kdWNlZCBieSBjb21taXQg
Njk1NDhiN2MyYzRmICgiaWlvOg0KPiA+ID4gYWRjOiBsdGMyNDk3OiBzcGxpdCBwcm90b2NvbCBp
bmRlcGVuZGVudCBwYXJ0IGluIGEgc2VwYXJhdGUgbW9kdWxlIikuDQo+ID4gPiBXaGVuIGV4dHJh
Y3QgdGhlIGNvbW1vbiBjb2RlIGludG8gbHRjMjQ5Ny1jb3JlLmMsIGl0IGNoYW5nZSB0aGUgY29k
ZQ0KPiA+ID4gbG9naWMgb2YgZnVuY3Rpb24gbHRjMjQ5N2NvcmVfcmVhZCgpLiBXaXRoIHdyb25n
IHJlYWRpbmcgc2VxdWVuY2UsDQo+ID4gPiB0aGUgYWN0aW9uIG9mIGVuYWJsZSBhZGMgY2hhbm5l
bCBpcyBzZW50IHRvIGNoaXAgYWdhaW4gZHVyaW5nIGFkYw0KPiA+ID4gY2hhbm5lbCBpcyBpbiBj
b252ZXJzaW9uIHN0YXR1cy4gSW4gdGhpcyB3YXksIHRoZXJlIGlzIG5vIGFjayBmcm9tDQo+ID4g
PiBjaGlwLCBhbmQgdGhlbiBjYXVzZSBpMmMgdHJhbnNmZXIgZmFpbGVkLg0KPiA+ID4gSW4gb3Jk
ZXIgdG8ga2VlcCB0aGUgY29kZSBsb2dpYyBpcyB0aGUgc2FtZSB3aXRoIG9yaWdpbmFsIGlkZWFs
LCBpdA0KPiA+ID4gaXMgbmVlZCB0byByZXR1cm4gZGlyZWN0IGFmdGVyIHJlYWRpbmcgdGhlIGFk
YyBjb252ZXJzaW9uIHZhbHVlLg0KPiA+ID4NCj4gPiA+IEZpeGVzOiA2OTU0OGI3YzJjNGYgKCJp
aW86IGFkYzogbHRjMjQ5Nzogc3BsaXQgcHJvdG9jb2wgaW5kZXBlbmRlbnQNCj4gPiA+IHBhcnQg
aW4gYSBzZXBhcmF0ZSBtb2R1bGUgIikNCj4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNZW5nIExpIDxNZW5nLkxpQHdpbmRyaXZlci5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2lpby9hZGMvbHRjMjQ5Ny5jIHwgMiArKw0KPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9paW8vYWRjL2x0YzI0OTcuYyBiL2RyaXZlcnMvaWlvL2FkYy9sdGMyNDk3LmMN
Cj4gPiA+IGluZGV4IDFhZGRkZjVhODhhOS4uZmQ1YTY2ODYwYTQ3IDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9paW8vYWRjL2x0YzI0OTcuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9paW8vYWRj
L2x0YzI0OTcuYw0KPiA+ID4gQEAgLTQxLDYgKzQxLDggQEAgc3RhdGljIGludCBsdGMyNDk3X3Jl
c3VsdF9hbmRfbWVhc3VyZShzdHJ1Y3QNCj4gbHRjMjQ5N2NvcmVfZHJpdmVyZGF0YSAqZGRhdGEs
DQo+ID4gPiAgICAgICAgICAgICB9DQo+ID4gPg0KPiA+ID4gICAgICAgICAgICAgKnZhbCA9IChi
ZTMyX3RvX2NwdShzdC0+YnVmKSA+PiAxNCkgLSAoMSA8PCAxNyk7DQo+ID4gPiArDQo+ID4gPiAr
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+DQo+ID4gVGhpcyBsb29rcyB3cm9uZyBmb3IgbWUu
IFRoZSBpZGVhIG9mIHRoZSBmdW5jdGlvbg0KPiA+IGx0YzI0OTdfcmVzdWx0X2FuZF9tZWFzdXJl
IGlzIHRoYXQgaXQgcmVhZHMgdGhlIHJlc3VsdCBhbmQgc3RhcnRzIGENCj4gPiBuZXcgbWVhc3Vy
ZW1lbnQuIEkgZ3Vlc3MgdGhlIHByb2JsZW0gaXMgdGhhdA0KPiA+IGx0YzI0OTdfcmVzdWx0X2Fu
ZF9tZWFzdXJlIGlzIGNhbGxlZCB0byBlYXJseSwgbm90IHRoYXQgaXQgZG9lcyB0b28gbXVjaC4N
Cj4gPg0KPiA+IEJ1dCBub3RlIEkgZG9uJ3QgaGF2ZSBzdWNoIGEgc3lzdGVtIGhhbmR5IHRvIGFj
dHVhbGx5IGRlYnVnIHRoaXMgYW55DQo+ID4gbW9yZS4NCj4gDQo+IEBNZW5nIExpLA0KPiANCj4g
SSBzZWUgZnJvbSB0aGUgZGF0YXNoZWV0IHRoYXQgdGhlIGRldmljZSBjYW4gYmUgdXNlZCB3aXRo
IGFuIGV4dGVybmFsDQo+IG9zY2lsbGF0b3IuDQo+IElzIHRoYXQgdGhlIGNhc2Ugb24geW91ciBi
b2FyZHMsIGJlY2F1c2UgaWYgc28gdGhlIHRpbWluZyBkZWxheSBvZiAxNTBtc2Vjcw0KPiBtYXkg
YmUgZmFyIHRvbyBzaG9ydC4gIElmIG5vdCwgcGVyaGFwcyB0aGUgcGFydCBpcyByaWdodCBhdCB0
aGUgdXBwZXIgZW5kIG9mDQo+IHRpbWluZ3MgYW5kIHdlIGp1c3QgbmVlZCB0byBhZGQgMjAlIHRv
IHRoZSAxNTBtc2VjcyB0byBiZSBzdXJlIG9mIG5vdA0KPiBoaXR0aW5nIHRoZSBsaW1pdD8NCj4g
DQoNCkhpIEpvbmF0aGFuLA0KDQpUaGFua3MgZm9yIHlvdXIgdmVyeSBwcm9mZXNzaW9uYWwgY29t
bWVudHMuDQpJIGNoZWNrIG15IGJvYXJkIHNjaGVtYXRpY3MsIHRoZSBwaW4gMzUgZjAgaXMgY29u
bmVjdGVkIHRvIEdORCwgc28gSSB1c2UgdGhlIGludGVybmFsIG9zY2lsbGF0b3IuDQpJbiBhZGRp
dGlvbmFsLCBJIGFtIG5vdCB2ZXJ5IHVuZGVyc3RhbmQgeW91ciBjb21tZW50IGFib3V0IHRoZSBj
YXNlIG9mIHVzaW5nIGludGVybmFsIG9zY2lsbGF0b3IuDQpEbyB5b3UgbWVhbiB0aGF0IHlvdSBh
Z3JlZSBteSBwYXRjaCBhbmQgb25seSBuZWVkIHRvIGNoYW5nZSAxNTAgaW50byAxODA/DQojZGVm
aW5lIExUQzI0OTdfQ09OVkVSU0lPTl9USU1FX01TCTE1MFVMTA0KPT4NCiNkZWZpbmUgTFRDMjQ5
N19DT05WRVJTSU9OX1RJTUVfTVMJMTgwVUxMDQoNClRoYW5rcywNCkxpbWVuZw0KDQo+IFRoYW5r
cywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiANCj4gPg0KPiA+IEJlc3QgcmVnYXJkcw0KPiA+IFV3
ZQ0KPiA+DQoNCg==
