Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A5B75BFEA
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jul 2023 09:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGUHhj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jul 2023 03:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjGUHhB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jul 2023 03:37:01 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A660819B0
        for <linux-iio@vger.kernel.org>; Fri, 21 Jul 2023 00:36:57 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L4EnUl028706;
        Fri, 21 Jul 2023 03:36:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3rx7bugkne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 03:36:36 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36L7SG6M004911;
        Fri, 21 Jul 2023 03:36:36 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3rx7bugkn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 03:36:36 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 36L7aYTn001731
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jul 2023 03:36:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 21 Jul
 2023 03:36:33 -0400
Received: from ASHBMBX8.ad.analog.com ([fe80::5480:da01:e8ae:ffda]) by
 ASHBMBX8.ad.analog.com ([fe80::5480:da01:e8ae:ffda%9]) with mapi id
 15.02.0986.014; Fri, 21 Jul 2023 03:36:33 -0400
From:   "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [jic23-iio:testing 6/10] drivers/iio/adc/max14001.c:135:13:
 warning: result of comparison of constant 18446744073709551615 with
 expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned
 char: (unsigned char)0, signed char: (unsi...
Thread-Topic: [jic23-iio:testing 6/10] drivers/iio/adc/max14001.c:135:13:
 warning: result of comparison of constant 18446744073709551615 with
 expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned
 char: (unsigned char)0, signed char: (unsi...
Thread-Index: AQHZpBoMRQgB2IdeHUCavmdJyiD/i6/C1FaAgACTuQCAAJkogA==
Date:   Fri, 21 Jul 2023 07:36:33 +0000
Message-ID: <20be2be0eaba4045a268407c1b6f07ad@analog.com>
References: <202306211545.7b6CdqsL-lkp@intel.com>
        <CAHp75VcNj-P_WCvx2Pf9sj_ir2oKf2AZ-mdTP=KHSuPY7WcjeA@mail.gmail.com>
        <769e6521-a86d-4380-b27c-2ff29b795802@app.fastmail.com>
 <20230720191838.73473d2c@jic23-huawei>
In-Reply-To: <20230720191838.73473d2c@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAwWlRNeE56WXhNaTB5TnprNUxURXhaV1V0WVdVNE1TMDRORE5o?=
 =?utf-8?B?TldKallUZ3pNVFJjWVcxbExYUmxjM1JjTkdVek1UYzJNVFF0TWpjNU9TMHhN?=
 =?utf-8?B?V1ZsTFdGbE9ERXRPRFF6WVRWaVkyRTRNekUwWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXlNVGN5SWlCMFBTSXhNek16TkRNNU9EVTVNREExT0RrMk1Ea2lJR2c5SWtK?=
 =?utf-8?B?NVpYbHNNMVJ0UXpBelJtRk5WblJEYTFJek1GSkxRbk5vUVQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVhCRmIyOVJjSEoyV2tGbFZVWlpOVEJ3ZVZSb1Z6?=
 =?utf-8?B?VlJWbXB1VTI1S1QwWlpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
X-Proofpoint-ORIG-GUID: Pjoz1ykBvsI2-Jov97Ly-a66ywPWZ4qV
X-Proofpoint-GUID: G_Bu6BOPEO3NRokl6_C-Vx_glrNf1vYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=753 clxscore=1011 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210067
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiANCj4gSSdkIHByZWZlciB0byBqdXN0IGRyb3AgdGhpcyByZWdfdXBkYXRlIGZ1bmN0aW9uIGVu
dGlyZWx5LiAgUHV0IHRoZSBjYWxsIGlubGluZSBzbw0KPiB0aGF0IHdlIGNhbiB1c2UgRklFTERf
UFJFUCgpIGRpcmVjdGx5IHJhdGhlciB0aGFuIChhZnRlciBmaXhpbmcgdGhlIHByb2JhYmx5DQo+
IGJ1ZykgcGFzc2luZyBpbiBib3RoIHRoZSB2YWx1ZSBhbmQgdGhlIG1hc2suDQo+IA0KPiA+DQo+
ID4gYnV0IGl0IGxvb2tzIGxpa2UgdGhlcmUgaXMgc3RpbGwgYSBidWcgaW4gbWF4MTQwMDFfcmVn
X3VwZGF0ZSgpLCBzbw0KPiA+IEknZCBwcmVmZXIgS2ltIFNlZXIgUGFsbGVyIHRvIHJldmlzaXQg
dGhpcyBpc3N1ZSBhbmQgc3VibWl0IGEgcHJvcGVybHkNCj4gPiB0ZXN0ZWQgcGF0Y2guDQo+IA0K
PiBBYnNvbHV0ZWx5IGFncmVlLiAgIElmIGl0J3Mgb3V0c3RhbmRpbmcgaW4gZmV3IHdlZWtzIHRo
b3VnaCB3ZSBjYW4gZ28NCj4gd2l0aCBhbiBlZHVjYXRlZCAnZ3Vlc3MnIGZvciB0aGUgZml4IGJ1
dCBJJ2QgcmVhbGx5IHJhdGhlciBub3QgaWYgS2ltIGNhbiBwb3N0IGEgZml4DQo+IGluIHRoZSBt
ZWFudGltZS4NCg0KVGhhbmsgeW91IGFsbCBmb3IgeW91ciBpbnB1dCBhbmQgZmVlZGJhY2suIEkn
bSBjdXJyZW50bHkgd29ya2luZyBvbiB0aGUgZml4IGFuZCANCndpbGwgdGVzdCBpdCBhcyBzb29u
IGFzIEkgaGF2ZSBhY2Nlc3MgdG8gdGhlIGV2YWwgYm9hcmRzIGFnYWluLiBJJ2xsIHJlYWNoIG91
dCBpZiANCnNvbWV0aGluZyBuZWVkcyB0byBiZSBjbGFyaWZpZWQuDQoNClRoYW5rcywNCktpbQ0K
