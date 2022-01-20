Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1996494566
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jan 2022 02:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiATBKG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jan 2022 20:10:06 -0500
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:49318 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231720AbiATBKF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jan 2022 20:10:05 -0500
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K0Vdmi010083;
        Wed, 19 Jan 2022 20:09:42 -0500
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2056.outbound.protection.outlook.com [104.47.60.56])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dprrpg6fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 20:09:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxhJHJV2DxDUN84HOf4XkPofYbHcN6pSZEoMVkSOn62ZBmpWP+9PFWQDIyel8qrJHCiR9k5hYr19MWfjLmZ1KthEI3doScPkKEvfdnpcRDBKwOO8xsF1bGDJ74mFoJgseDP6/mK4UlcL0dJ5mhecHyj8wenLifAU5jCuOy8TD7Zr8HQZkMi+v/356B/L3rE6EEzHf6HDUMtPNnFxvLd/fKRYuByF+LAOIirv7P5jGVFIwap4M34ctvgk95wznN2LwS+bAQMd5UrzFbJWIqWh3mnObMtV0odoJa8DKlOO84jroWyKenGOrAzXcKO4pSIIpaM871DdXYaDdej8Hv7nxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwlLmscUZ6mjFaRUTS9ockKIlPwuXpkoEbPqebUUsQc=;
 b=nWgTFXmn18I6pC13oqTRLTppRex6QVrSl49oTBJGwRWzALglL/5R1g78e/CyCd4QK5tzjt8pcRrE6GYU2KOlfdJDtnkX2aiNCiHLgGXiQE98BRRWmsWh5YjMOXAO220nZJqKhauWMk3zBN/CKQTSYau6mRXBdQ+4T2PRp8C5FlzoQ/hL1EnImbmpdAT3n7jdkXlUDCycaFtO52cy5XjcaEW05qG5Fe6Pu6QIMnqJYZ8kcJZrIStM4iSnl3qaMZKjnjq9gv8WAUvEVvc0hRsq5rbmF+++P4wgKAf6+pUogOoYx6LCjmARO+Voy1X6CwdS4Z7jLfHluImASNS4OkVrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwlLmscUZ6mjFaRUTS9ockKIlPwuXpkoEbPqebUUsQc=;
 b=g8g2/AInUMw2b/AcwYZwlaHIf3QpdRPHy1BVD+2aVL/+l7CpA/JBr6Nn4ICNv7OYn/n+KOrM4HIsYOgrNOO13Ht0+ZvnTsO0pPXjbMhEyyM3uuGpfXsiys9CX9i6fmFNvGdvW8VUqzmTQEQZl1viq4ZZxBTqu08BBk4JnGvb4qw=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YQXPR01MB3253.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:45::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 01:09:40 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 01:09:40 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "m.tretter@pengutronix.de" <m.tretter@pengutronix.de>,
        "anand.ashok.dumbre@xilinx.com" <anand.ashok.dumbre@xilinx.com>
Subject: Re: [PATCH 2/4] iio: adc: xilinx-ams: Fixed missing PS channels
Thread-Topic: [PATCH 2/4] iio: adc: xilinx-ams: Fixed missing PS channels
Thread-Index: AQHYDZl51R/cmmwTRkiz/3AcyFUuV6xrGZiA
Date:   Thu, 20 Jan 2022 01:09:39 +0000
Message-ID: <c615acdc4f0a818e070705e1f3f5d82660fb4c8a.camel@calian.com>
References: <20220120010246.3794962-1-robert.hancock@calian.com>
         <20220120010246.3794962-3-robert.hancock@calian.com>
In-Reply-To: <20220120010246.3794962-3-robert.hancock@calian.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f08fb59b-2438-4848-9dce-08d9dbb188c9
x-ms-traffictypediagnostic: YQXPR01MB3253:EE_
x-microsoft-antispam-prvs: <YQXPR01MB3253F6C36E749C740ABC8C28EC5A9@YQXPR01MB3253.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d6yzY84Rgiw50nt5Q8DbLiR39JYXPyGxIpeEw06KfnR70l//9e5B1j20ZYhePV1HcXBq7JCyXw2YeUs9RzQhg63UO/JkSEW9ZBnUyyu090NNZYvcYYNKt5lXqhPgbM2I5FFtKCqv6jewrbGBANxcGH5CTW+1Rc5rXFmtW6jmeaFkEBm+zpWHhgjua0surK9g1KtAqbGFlz8NmpaNN9MNT2QHb83bYWkyk2ESZqWiCmj07uj79BOT2CsoiAUplRBMmIhPY9SdlhWIFFOA9Q2dKBqIjAC34/FFsOiD3+UgWgpNDxaQgeLv9gyw6+0V/210eQJ/4v3YPriGsh9RJWnDBXhtpl2QC9Btw96XauO98c7Z4/n+wRYS2qDwo2geSSY6Va80RKdJsED8K+5Z2TkKBBoJLV6K0pjB/JdMyOvhLflqRwFSXuhDuT+/1SuwrwL0FFjf0oGMf1K1ls3OkwNMGg3hh1yOa0nSoazQMC5OQZkHmEvOxbvqxIrXSfZE2oR14/jK6MbEG/6kZw6EcE2vTobwQX5hStrJQpcHbmXBciJSboU3p3rdcs7+f8GZTexNSiaQ37ousaCO/bdvMRYGU9BYsYlfcgkeOmVRaiw1GSa1+pOqDyFiEIxHvP3OUABhtblkLOX1LcTckkhKHFtKqmPY40wuzmm2v5qhJy7oW5L8HuXSCAw7xyzagegxszfA5z/Koy0ZSw9WynoNyyAENf70Hle8PXkFz49GccILLO999v3wiOJ0WvN4nG+GMsIz6iqrvmbuTt6k4lgUWidrDJan+rH/P0ibR2/Ur/UZ07NmRK3O4TsAQyXxazahi8tq+wYwwUNwpsHQX7/+dufeDj+vQZsPh7pbcNVpVpbFhZA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(7416002)(8676002)(5660300002)(8936002)(4326008)(54906003)(6512007)(71200400001)(66946007)(66476007)(76116006)(64756008)(66446008)(66556008)(91956017)(44832011)(2906002)(15974865002)(2616005)(6486002)(38070700005)(316002)(508600001)(6506007)(6916009)(86362001)(186003)(26005)(38100700002)(122000001)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVpIdldzR1NWbDhkZXhrVTVEd1pJVGpReFhkLzRuaHNPRGNpeUV5RkFydXdB?=
 =?utf-8?B?S0h4UklvdlVFYlRUVTQwVHAzWWw3TlduRy83Yll4RkpJeUoyREtERTNQNS81?=
 =?utf-8?B?RVk1TGhoKzNrdzRxQmgwcjhPb2o3TXpveVVLMjU4UEZySkhlWW1yNEVuTTE3?=
 =?utf-8?B?U3gxNUd1QXBIb0t2SnJnVm12WUh4NTVETEN3aU1xUmo0a2RteFF6SGp1aHVr?=
 =?utf-8?B?QlcydzJSOXdKQTNjcmpWTTRhTE0yZEhyd0hZSXZxM0dtSFpoY3N0OURSbXJM?=
 =?utf-8?B?VGRETXg3WEltdE52cE5lVTJLUStEaDhKUGF6TmRHWis2RVhqRjZDQis4STAv?=
 =?utf-8?B?VC84MThsc0JzTjgwMFBEWlY4WkpVc1NuYzJISndPZUNDMmpUak9pemVPT3Vv?=
 =?utf-8?B?VFdLTGdTVWJ5QWFLZ3RCWFRKeUtMZy8xNi9aNHNPQzNmeCt1c1FDa0JyUHU1?=
 =?utf-8?B?bTBqczBxY1pERXRLRnVtRUFoWHlaMHQrYVZ4aytLYUVuNG1Nb2J5NDk2Y3Ni?=
 =?utf-8?B?SWc1MTN2bGx6NXZwZlRzQkJ0T1NhMEdQRjdsajlRRlNiQjBJdThDc3J4YlJo?=
 =?utf-8?B?YVNOK1U2UEFzY2xRQ3lQeU9laHBvaFZBRzJtbytSY2lTZnd6NmtkazI4Y2tT?=
 =?utf-8?B?WXVXQTlDTGhzUUVsQURTYmpNellQeVBlQ2szQkRyQkE5SG1qWnNRRFd3cGxU?=
 =?utf-8?B?cU9ZSzJlYTlORGNKaHM5N0JVQlBXczY5S3NMZGwzVDN5RlkwS2VDV3pMK0ps?=
 =?utf-8?B?c0o2WTc4Vkt2QnhwM01CNk5vZGpmOHA2MzhLR1lDVmNOREptRm1MM3RSWkw0?=
 =?utf-8?B?NityNTd3MUVyUHk3OEtKQlF4WXJRNTRpOGwvZ2dEbVk1ZWpJUUVVb2dCTVRp?=
 =?utf-8?B?MTJTUzQ3MW5EU3EzV0h6OHBoQktjaW92MEEzbG1waER6NmZNNGxXMEhiNSs1?=
 =?utf-8?B?OHFNcElJSUE0YVQvTVRCRXZtQXg2N296VkRzcVdrN2NEVkNmNzVESGpMd3M5?=
 =?utf-8?B?QkUxOFhUSDdsMzRxdWxtY2lwb3Irbkp5YTlwSlB1bkNNQjl4QVp6U3A0N20v?=
 =?utf-8?B?WTlRZHVndkx3a2poWUt3OXV5enZYdEhaN1V2RURXS2MxTUw1QnJZMFdRaFlG?=
 =?utf-8?B?b1owdmtFWGhhc0g5OGdnSk9QbG55MGx0S0FYbXJqZzQxRDJ3cEtTWnFUdXE0?=
 =?utf-8?B?aWF5MTVJYnh1cjIydHh4TCtsUEhWSHlxOS92ZUZkREMxbkVCTHVSeFQ3c3Z2?=
 =?utf-8?B?My9PNjZZL3h0MDRPQUdLNkRFR0t5cHFzRFhoQjVIbnhXckFGbXpobDZKNGlI?=
 =?utf-8?B?V010Q3R2WnNBMkFkU3Q1Z0Z1aXV6RFp1V0dEZnNIVFNoVFpLR2RUbkpaMmNB?=
 =?utf-8?B?YXBnTUtsbUlMbnJnYlgxSjRNNmgrNEN5c3d6RVk4dkRLUFZRVVhQWEhsMHZt?=
 =?utf-8?B?Wk1iRVBBTXhYTUJVZFZRRVl2VndWRldhNWFUbFJYeDZwaDdxeFJGWEk4Z2Zx?=
 =?utf-8?B?UUttNktEOVZOQi9RK2I2c1g5dmJZcDJNZlp5TzVyM2toQmdxZXJnWWtCTGlX?=
 =?utf-8?B?ZmdjZlBtanAxQXg2ZThrTjhQUEJHN3psVEF3WExabFhqLy90SEE3ZXlHQjQ1?=
 =?utf-8?B?TUMzNWhkbWNRLzBtKzYzd0x6TU9EV1BpU0p2Wkp0UEJqUnBCT2JZNE5PcUpi?=
 =?utf-8?B?dURwWnhVTy83WkZiQ0dvMlFlUGJOTWljYXE4Ykt2bi9EZmhwZGZMS1l1bElp?=
 =?utf-8?B?NmVkWjBCM00zbjBSbVprTmEwRldjcndOYk85cGVxMkpGckgyT0wyR3c3L3B1?=
 =?utf-8?B?VlBsYXE5cEdna1grQkdyNDRPQW81Ujh0YURUaHc1eFNWVXpkQnhhZWhDWFhr?=
 =?utf-8?B?ZWQxdFo5THd0NzlkUUgzQU1VQjVpK3FwSzh5TkpCd3l0dXFsVUN4aTlWeVJ0?=
 =?utf-8?B?NVR2dW1KdEt1ZjVjSzhTbXJrRWNYV1FBbndHUW41RlF2WTBCV3pZbklsZ1ZF?=
 =?utf-8?B?NjVDRnZLWVVxL3h5RlBlb0Y1NEZ6TGN2SE5KSmNXVTVYdFYrVEUvRHBkWjVR?=
 =?utf-8?B?MUNIVWoyMDBxMDJGSXMxOEMyRTNjbzNMaFRrTEtLSThuMURzVmdxUTNKRzZj?=
 =?utf-8?B?YnN0LzR3S1c4UWVhT0FNLzNlanE0M3dWZjZFYlRUbktmellpV29CL3hMS2F1?=
 =?utf-8?B?UGpVc1dSUEs0ZE9NUVRidG1EazdWUStKY3liZ1lxeEpxb3IvYldFNUJCdVpx?=
 =?utf-8?Q?MsUywPVdfvYbe9V/RE7KGo+AFuf69W4E15EW6DCLRc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E57CC13954B34D4994E66E8681BE8D8F@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f08fb59b-2438-4848-9dce-08d9dbb188c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 01:09:39.9620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jd4WY1vk7i7W3NMc7wcCH6Q32GAqVbyi19QDix/IxpsNMH5q0UKUezk30x7m/1DqniG9PIqVy+JsAZS5rSZz+kZyHahkiH3992JRDUl3HOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB3253
X-Proofpoint-ORIG-GUID: Xa3-cs2Ue605pAvYejDF96pfITpMIALC
X-Proofpoint-GUID: Xa3-cs2Ue605pAvYejDF96pfITpMIALC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200006
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTE5IGF0IDE5OjAyIC0wNjAwLCBSb2JlcnQgSGFuY29jayB3cm90ZToN
Cj4gVGhlIGNvZGUgZm9yZ290IHRvIGluY3JlbWVudCBudW1fY2hhbm5lbHMgZm9yIHRoZSBQUyBj
aGFubmVsIGlucHV0cywNCj4gcmVzdWx0aW5nIGluIHRoZW0gbm90IGJlaW5nIGVuYWJsZWQgYXMg
dGhleSBzaG91bGQuDQo+IA0KPiBGaXhlczogZDVjNzA2MjdhNzk0ICgiaWlvOiBhZGM6IEFkZCBY
aWxpbnggQU1TIGRyaXZlciIpDQo+IFNpZ25lZC1vZmYtYnk6IFJvYmVydCBIYW5jb2NrIDxyb2Jl
cnQuaGFuY29ja0BjYWxpYW4uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy94aWxpbngt
YW1zLmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy94aWxpbngtYW1zLmMgYi9kcml2ZXJzL2lpby9hZGMv
eGlsaW54LWFtcy5jDQo+IGluZGV4IDgzNDNjNWY3NDEyMS4uYjkzODY0MzYyZGFjIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMveGlsaW54LWFtcy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlv
L2FkYy94aWxpbngtYW1zLmMNCj4gQEAgLTEyMjQsNiArMTIyNCw3IEBAIHN0YXRpYyBpbnQgYW1z
X2luaXRfbW9kdWxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ICANCj4gIAkJLyogYWRk
IFBTIGNoYW5uZWxzIHRvIGlpbyBkZXZpY2UgY2hhbm5lbHMgKi8NCj4gIAkJbWVtY3B5KGNoYW5u
ZWxzLCBhbXNfcHNfY2hhbm5lbHMsIHNpemVvZihhbXNfcHNfY2hhbm5lbHMpKTsNCj4gKwkJbnVt
X2NoYW5uZWxzID0gQVJSQVlfU0laRShhbXNfcHNfY2hhbm5lbHMpOw0KPiAgCX0gZWxzZSBpZiAo
Zndub2RlX3Byb3BlcnR5X21hdGNoX3N0cmluZyhmd25vZGUsICJjb21wYXRpYmxlIiwNCj4gIAkJ
CQkJCSJ4bG54LHp5bnFtcC1hbXMtcGwiKSA9PSAwKSB7DQo+ICAJCWFtcy0+cGxfYmFzZSA9IGZ3
bm9kZV9pb21hcChmd25vZGUsIDApOw0KDQpMb29rcyBsaWtlIHRoaXMgaXMgdGhlIHNhbWUgY2hh
bmdlIGp1c3Qgc3VibWl0dGVkIGJ5IE1pY2hhZWwgVHJldHRlciAoImlpbzoNCmFkYzogeGlsaW54
LWFtczogRml4IG51bV9jaGFubmVscyBmb3IgUFMgY2hhbm5lbHMiKS4NCg0KLS0gDQpSb2JlcnQg
SGFuY29jaw0KU2VuaW9yIEhhcmR3YXJlIERlc2lnbmVyLCBDYWxpYW4gQWR2YW5jZWQgVGVjaG5v
bG9naWVzDQp3d3cuY2FsaWFuLmNvbQ0K
