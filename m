Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEFC74E792
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jul 2023 08:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjGKGzz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jul 2023 02:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGKGzy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jul 2023 02:55:54 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D376136
        for <linux-iio@vger.kernel.org>; Mon, 10 Jul 2023 23:55:51 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B463rQ020334;
        Tue, 11 Jul 2023 02:55:30 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3rq4q6fygq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 02:55:30 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 36B6tT6m032262
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jul 2023 02:55:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 11 Jul
 2023 02:55:28 -0400
Received: from ASHBMBX8.ad.analog.com ([fe80::5480:da01:e8ae:ffda]) by
 ASHBMBX8.ad.analog.com ([fe80::5480:da01:e8ae:ffda%9]) with mapi id
 15.02.0986.014; Tue, 11 Jul 2023 02:55:28 -0400
From:   "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v9 2/2] iio: adc: max14001: New driver
Thread-Topic: [PATCH v9 2/2] iio: adc: max14001: New driver
Thread-Index: AQHZsubiZVm2aMsLPUi7mLF9xAsvxK+y39eA///AI5CAAHWzAIABAMag
Date:   Tue, 11 Jul 2023 06:55:28 +0000
Message-ID: <fe0cd5348f864a6392a7e0e5ca93bec5@analog.com>
References: <20230710042723.46084-1-kimseer.paller@analog.com>
 <20230710042723.46084-2-kimseer.paller@analog.com>
 <CAHp75Vd386P9xM_+wLahp6B_XwYVq1AZxaFQeWvZ2pnk-tFGHA@mail.gmail.com>
 <11c30a02df784ca78be271fdf9190dad@analog.com>
 <CAHp75VegvKFUXoJoJnuXstJa_L66M2Ah9yf1aEQ8-ET1QczDtQ@mail.gmail.com>
In-Reply-To: <CAHp75VegvKFUXoJoJnuXstJa_L66M2Ah9yf1aEQ8-ET1QczDtQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFsT1RFMVpXSTROaTB4Wm1JM0xURXhaV1V0WVdVNE1DMDVPV1Zs?=
 =?utf-8?B?T1dNMk1HRXhPV1ZjWVcxbExYUmxjM1JjWlRreE5XVmlPRGd0TVdaaU55MHhN?=
 =?utf-8?B?V1ZsTFdGbE9EQXRPVGxsWlRsak5qQmhNVGxsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STBPREEySWlCMFBTSXhNek16TXpVek1qRXlOVFV6TWpFM056Z2lJR2c5SW1S?=
 =?utf-8?B?UVdGWkxTRFJtTTBOVFFqWlBSelp3Y0VKRlJYaEVNMk5LWXowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTNsdlJ5dHllRXhRV2tGa1YzRk1TbVV4V2xvdmFE?=
 =?utf-8?B?RmhiM05zTjFac2JpdEZSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQmRtUm9hM2huUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
x-originating-ip: [10.116.18.29]
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-GUID: 8Cz4kFfBy9HAPC76wECqL_sCHy_BJ6N8
X-Proofpoint-ORIG-GUID: 8Cz4kFfBy9HAPC76wECqL_sCHy_BJ6N8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_03,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110060
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bHkgMTAsIDIw
MjMgNjo1MCBQTQ0KPiBUbzogUGFsbGVyLCBLaW0gU2VlciA8S2ltU2Vlci5QYWxsZXJAYW5hbG9n
LmNvbT47IEhlbm5lcmljaCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNv
bT4NCj4gQ2M6IGxpbnV4LWlpbyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IEpvbmF0aGFu
IENhbWVyb24NCj4gPGppYzIzQGtlcm5lbC5vcmc+OyBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNA
bWV0YWZvby5kZT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSAyLzJdIGlpbzogYWRjOiBtYXgx
NDAwMTogTmV3IGRyaXZlcg0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gUmV0dXJuIHRvIHRoZSBw
dWJsaWMgc3BhY2Ugb2YgdGhlIGRpc2N1c3Npb24uDQoNCk9oIGxhdGUgdG8gbm90aWNlLCBJIGhh
ZCBtaXN0YWtlbmx5IHNldCBteSBlbWFpbCBjbGllbnQgdG8gInF1aWNrIHJlcGx5IiANCmluc3Rl
YWQgb2YgJ3JlcGx5IHRvIGFsbCcuDQoNCj4gT24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgMTE6MTfi
gK9BTSBQYWxsZXIsIEtpbSBTZWVyDQo+IDxLaW1TZWVyLlBhbGxlckBhbmFsb2cuY29tPiB3cm90
ZToNCj4gPiA+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNv
bT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgSnVseSAxMCwgMjAyMyAzOjM3IFBNDQo+ID4gPiBPbiBN
b24sIEp1bCAxMCwgMjAyMyBhdCA3OjI34oCvQU0gS2ltIFNlZXIgUGFsbGVyDQo+IDxraW1zZWVy
LnBhbGxlckBhbmFsb2cuY29tPg0KPiA+ID4gd3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+ID4gPiA+
IFY4IC0+IFY5OiBDaGFuZ2VkIFNQSSBidWZmZXIgZGF0YSB0eXBlcyB0byBfX2xlMTYsDQo+ID4g
Pg0KPiA+ID4gV2h5Pw0KPiA+DQo+ID4gQmFzZWQgb24gdGhlIHByZXZpb3VzIGNvbW1lbnRzLCBJ
IGhhdmUgdGFrZW4gdGhlIF9fbGUxNiBkYXRhIHR5cGUNCj4gPiBpbnRvIGFjY291bnQuIFRoZSBk
ZXZpY2Ugc2VlbXMgdG8gZnVuY3Rpb24gdGhlIHNhbWUgYXMgdGhlIF9fYmUgZGF0YSB0eXBlLg0K
PiA+IEkgaGF2ZSBub3QgeWV0IHN1cmUgYnV0IHRlY2huaWNhbGx5IHNwZWFraW5nLCBkbyBJIGhh
dmUgdG8gcmV0YWluIHRoZSBkYXRhDQo+ID4gdHlwZXMgYXMgX19iZTE2IGJhc2VkIG9uIHRoZSBv
dmVyYWxsIG9wZXJhdGlvbj8NCj4gDQo+IElmIHRoZSB0eXBlIGlzIF9fYmUsIHRoZSAqYmUqKCkg
QVBJcyBzaG91bGQgYmUgdXNlZCwgb3RoZXJ3aXNlIF9fbGUgYW5kICpsZSooKS4NCg0KSSBiZWNh
bWUgYSBsaXR0bGUgY29uZnVzZWQgd2l0aCB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbnMsIHdpbGwg
bWFrZSB0aGUgDQpuZWNlc3NhcnkgY2hhbmdlcyBhY2NvcmRpbmdseS4NCg0KPiA+ID4gT2J2aW91
c2x5IGl0J3MgaW5jb3JyZWN0IG5vdyBldmVuIG1vcmUgdGhhbiBiZWZvcmUuDQo+ID4gPiBUaGUg
dHlwZXMgYXJlIGRlZmluZWQgYXMgX19sZSwgd2hpbGUgb3BzIGFyZSBhZ2FpbnN0IF9fYmUuDQo+
ID4NCj4gPiBXb3VsZCBpdCBiZSByaWdodCB0byBpbXBsZW1lbnQgdGhpcyBieSByZXZlcnRpbmcg
dGhlIHR5cGVzIGJhY2sgdG8gX19iZT8NCj4gPiBXaGF0IG90aGVyIGNvbnNpZGVyYXRpb25zIGNv
dWxkIHRoZXJlIGJlPw0KPiANCj4gRmlyc3Qgb2YgYWxsLCB5b3UgbmVlZCB0byBkb2N1bWVudCB3
aGF0IHlvdSBhcmUgZG9pbmcgd2l0aCB0aGVzZSBiaXQNCj4gdHdpZGRsZXJzLiBCYXNlZCBvbiB0
aGUgY2xlYXIgdW5kZXJzdGFuZGluZyBieSBldmVyeW9uZSB3ZSBjYW4gc3VnZ2VzdA0KPiB3aGF0
IGRhdGEgdHlwZShzKSBzdWl0cyB0aGUgYmVzdC4NCj4gDQo+IEhlbmNlIGluc3RlYWQgb2YgdjEw
LCByZXBseSB3aXRoIGEgZHJhZnQgb2YgdGhlIGNvbW1lbnQgaW4gdGhlIGNvZGUgKEkNCj4gaGF2
ZSBhc2tlZCBiZWZvcmUpIHRoYXQgZXhwbGFpbnMgdGhlc2UgYml0IHR3aWRkbGVycy4NCg0KSW4g
cGF0Y2ggdjksIHJlZ2FyZGluZyB3aXRoIG15IGJpdCBhcnJhbmdlbWVudCBjb21tZW50cywgaXMg
aXQgc29tZXdoYXQgY29ycmVjdCANCm9yIGRvIEkgbmVlZCB0byB0b3RhbGx5IHJlcGxhY2UgaXQ/
IA0KDQpJIGFtIG5vdCB5ZXQgZmFtaWxpYXIgd2l0aCB0aGUgdGVybWlub2xvZ2llcywgc28gSSBo
b3BlIHlvdSBjYW4gcHJvdmlkZSBzb21lIA0Kc3VnZ2VzdGlvbnMgYW5kIEknbGwgZGVmaW5pdGVs
eSBzZW5kIHRoZSBkcmFmdCBmaXJzdC4NCg0KVGhhbmtzLA0KS2ltDQoNCg0K
