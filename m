Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5546DD996
	for <lists+linux-iio@lfdr.de>; Tue, 11 Apr 2023 13:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjDKLlK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Apr 2023 07:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDKLlJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Apr 2023 07:41:09 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2132.outbound.protection.outlook.com [40.107.127.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668073A9B
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2023 04:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr90OimHDtCmjQVUKH4ZrwA0EBACjrOC7RxWp7RZrVcoleNt7TJB1rgc7VnIisRz3xahdSGOs1K6d51fohxEBQQTCLF9DylDRMtLR2DnbRPWT6kG92cS2671b7vxaGhHA+d2cja/b5RgBNGt3ZhTaajNbhH6jd5b6mqzF4DAH6hcZbstrduwfrKs7v5KclRPQljs2Ry8YFPxbXVK4GsX/dwZj5e572ehF7Xr7ipcdpODJXVLXiVu8Xn5qR7SMUUcthsm5aBwEz34Hk/ZzIvFJovc6sNjOjPZvP8TZHPjA6EZQuOJbqnR+koClqsWyjZl4skBFE84E0O11jGlc9Pf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yH+fqfj1yimPaUflXlgCHOn5T6QWLH06MGvYlY6rx0s=;
 b=AF1/rjHl2CjkIJ8T9p+Ytao2EkvzZgYDjsZUsOnmn3yzy1Syn97rXDKwSrUiABo9cs3C/XpQdkgbegsIuk7UxU/cUSuqf6mQ7C4kg0lRSxVmU7FJ/75Ij6tbOI01MgikGwCtNYAJIyS8DkVyHsEZzp6ELlMsfTe56ImDVZOmr6jwvSeJkhvDMVMHhNAfb9Y4Qcha9Xoiz7MxqhJB7KO5BhkwK+uKqyV2t3G2b4tIE1jDkSAPhcZI1h6hqU+RdgjkFA4Wz0cOQ2vtoYYi2J8aZHjlrk81hdR31fhyPGE6cCzLMJE0q4sbP0IRUp4o4ih5i3ROTdlSOJy8SdzsXDeOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yH+fqfj1yimPaUflXlgCHOn5T6QWLH06MGvYlY6rx0s=;
 b=RpG0h/1v26OdxQEuzhWFjyQTGZDOTUy7FUHo4TYERLPxt9B3x8LR7ISb2yb5nsOz1ZxmfrvmxhL3my64lIgGOGnZcmukQQFzCF9aU0R+qRtg9XJRN0jAtDKdigiq+eV95HuEd51mplKLzebsqcuL7QcBwRhzfrY506pXtAfVGgo=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR0P281MB1723.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:83::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 11:41:01 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f%5]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 11:41:01 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: ROHM BU27008 RGB sensor
Thread-Topic: ROHM BU27008 RGB sensor
Thread-Index: AQHZZu2pPMu43ReP9kutQyfvEEIMCa8kwd8AgAFFPwA=
Date:   Tue, 11 Apr 2023 11:41:01 +0000
Message-ID: <8c8aadcd-f703-01cb-def9-8a2f4779df40@fi.rohmeurope.com>
References: <5942c0c2-3997-e10f-0872-30d201bc52ae@gmail.com>
 <20230410171654.66605efe@jic23-huawei>
In-Reply-To: <20230410171654.66605efe@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR0P281MB1723:EE_
x-ms-office365-filtering-correlation-id: 5c95bc88-4168-42ed-0349-08db3a819ff2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HBb9ianjR2fc1s9+0LqkQSvs5/sdc4BMmdnWYbMXpopslOTV2MYVO6yCOWEc5Ilo35GnXSNC+pcPXZql57g06zEJn7usfqGP6+SXJPJTfZwFPOK+SBE6z2lvRxiUjd6XnGDSa+MkaO/Hnb/97aiAkCs8Qc7nOTA7DYcXFN1cYW6aHHkAg//uySj/diDeahc5lB1GMLXNVmSFkJyBIP06axlwgovhiADXQmCs4lqnGIydyGPtvSa+mO3+76BxbY4/+MOLdTfPIX0Hn90Lf2RdRjeUfNddqZvTBo/iD4WkrAXZFz3MekYYVuWlICr5B72UUZBpAgqWOxKS0lgrGX8dLKvUwQ+dVGlPwzkCEtZFe0wPlPtrX2mW1SSjWYps0Ek4PYAKAfgEMvQ+tCvgCF8C+/KNvlFa+C9QXfbhrUcOEg113GMJ8pg/3JtmKTB8Ht0cwGKPxkVYmhPKEj7PcOt1iNVBWdZKB91lqOhnhTbtA4BgHiNynLbqc6VVUbEM0qQT5JPXMAf2CuxUci67v8kxgfQoWvHalNI/kPEmQZEAx6i1a5KdHvIntETzUsDEXwyiwwVROBzqdzunC/0e1+OuewPKZxSxhiMZ+btRkSkyuq84HmawN5mm8ypCG2KEWQnne36t/69pBIMNxUqAIsaPEDOpB6r9MQ3u391QPct3yOVSI/zKLqrWoFHuZV6haD/x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39850400004)(451199021)(8936002)(110136005)(41300700001)(316002)(86362001)(4326008)(66476007)(76116006)(8676002)(66446008)(91956017)(38070700005)(64756008)(66556008)(66946007)(2906002)(122000001)(66899021)(478600001)(5660300002)(31686004)(31696002)(38100700002)(71200400001)(6486002)(6512007)(6506007)(53546011)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0xZWjNtYm0xaXpVSHZpK0VORWtydEpvQUZaU3JFeUpWbmJuS2tFUHltWG0w?=
 =?utf-8?B?Sk53WDJmUy9GaFZOK0xKc0d2K3NEc2Y3b3h1b2xHd2cza3FibytJdmVmRU0v?=
 =?utf-8?B?Qy9tNXJ2bEhJbzJMTzNvazBQU3JXNVByL0RZSFptYjRzN2x0NEJFMGJ0elRF?=
 =?utf-8?B?bUx5aFAzWkx0eXgvV3hEQTdXeEpFTzZoeG1LUjhwS29neDhjdGtiblFkYkZt?=
 =?utf-8?B?V0pKSVBENG9YTEkzK2xuUktNc04xdjZPZUhqYXBXazlSSVVLVCtmYXRvL2tl?=
 =?utf-8?B?WVRPbWZBOHJsVFhnNHBSeGM3Q0h0VjlnRlpGMjFsMEp5dFdmb0ptYUM0ZVQw?=
 =?utf-8?B?VzE1YmtHcWtWcnRpbExOU2FlbkY1RTJXdVU5UzJYUVdLbEZiMFFBOFozUVNX?=
 =?utf-8?B?V3czQ3E5R1M2WnIxa3k0eG5SVVhZV05HQlZGMUVUNGFzNHZnQjR5emxpbVNk?=
 =?utf-8?B?alNJMDBlMTl2OGFTanducTROTWJ3cVJ0VG5QQm1UeklPTmJCNXNUeUdFMDdU?=
 =?utf-8?B?azFkUlRzZHF3SmlWWWk4U3BULzlGMGd3U25VT3Q1QUZOYis3c2hXaHNRS1hs?=
 =?utf-8?B?Ukc0MncyZENkM0tvdVVNMDFRMlpCa1ExWkhVYTlOOFo2U2EwUTFxUXBJRUhr?=
 =?utf-8?B?WlZqL2w5bFVQdm5BWENXV05IT2V2MlJLa1R2eElXWjNiV2NBSXJ6bHh0T0Rk?=
 =?utf-8?B?OGIrSEV5TXh5elBHaWN1a01ZR3RsVzgvVjIxaFBpZUxNRXRkdnVXMlFObTI4?=
 =?utf-8?B?Y0hHc3FjWWpjV2ppWWIwUmV3NFdyN3dPU3dFY0pjNEVpSzN0SzNqaCtIVWtj?=
 =?utf-8?B?dGtiNHA3R0NZTlRyVWtQL1I4MVBVQ0ZUQmo3dEsxeDhWdHZKUUxlK244YUxZ?=
 =?utf-8?B?cHFRMnREUTNNclUxRjN0SW5kSWZYM3A5NFNLMWlOSmFwRysrdGsrQ0FsQXJ1?=
 =?utf-8?B?b2lRSWdDSllLMXpzNGJEMWZTamM4cFJ1bkN5QnJPYzhTMEFlcXRoNGx5azd2?=
 =?utf-8?B?bWZSZlpUNWNHZHhETTZGcmJqWTRnNVBOY1ZSTml4WkF4U2pidTByWTVsU3Ix?=
 =?utf-8?B?YTIrQkdGcHE1MVdvT00wQnpYa0pDZHVkTHZMQ1ZyRjdJa1dJLzNkbkZYcGo0?=
 =?utf-8?B?T1l1Smt3K29iOXpIVFVhT09rWXYycGNLU0VncDg5N3VsRm5SMU4ycUJLTzBM?=
 =?utf-8?B?cXZONjFhMmZoY2poU2QzR1R2TFEydnBFYVl0M1dXSDR4NVloSFY1Y2tPL0tY?=
 =?utf-8?B?UmhpQjVXSnU3RkxJT2QwQmVUMjdCNVlvWDRJV1BOSTd4SXErZnliMUZwWTY3?=
 =?utf-8?B?OGptOWNPL3BUZ0dSN21lSzJ5OWJNZHJhV2tlK2F6TkdweFlMcXl2bVhGRkNW?=
 =?utf-8?B?Z0lxRWV3S1FNcDNvTUQrczZoZFNHTDgxaG9scmZwZENNcFBZcEV1YVV3S3dh?=
 =?utf-8?B?eDB3dXpxWDlheHA4dWxGbkc5dUVTa2R3WXJHWENwbEJJcVFUOXU3RXBURDFI?=
 =?utf-8?B?cEhqclR1eHRFOWVtUDZET00rc2dSRlpjVXB1OFFSeWlRWEtPYlRPSXBvaU9K?=
 =?utf-8?B?VHpjTzd1eVhSVGRwSUtBMkxhZVk2RnlwalJ2R3dlZFBBbGs1bEZwdHpVTmd3?=
 =?utf-8?B?UTRBUy8wV1ZzVnp3WUhwcjk4TkNGRmQvMVFUMEpPQlZ0MkdzOG9LZDdMUTlM?=
 =?utf-8?B?ZEh5NlJ3MWlVUTRpcVBVR2NIYVZRaElZT2d3VjdqUEtJWUtaTFFibG9yTHhV?=
 =?utf-8?B?QlAwT1hEWG44QmhwSTBnUUhkNUZneGJwMmlkZm81ZHdnTTBpRXpXeGdMVXYy?=
 =?utf-8?B?RkxnVzVPUFY3QnZKTElHU3VaY25EcDFCZGhzYlNBSVFuZjhGWGVSdTBzSnhk?=
 =?utf-8?B?MldUWGJUS09KUWYwV2ZMalB2SzI4YkRUa00xajJMdHFER29DTTJrL085cnZJ?=
 =?utf-8?B?KzZ6MmxtR3dRQXFJdFhNb0cva0VoZ3Q3OWRLdXNaR2ZUUXFpNEJCZkJwM2Zo?=
 =?utf-8?B?bktpN042OW1HSWlLRHlkVlhFZUhGVEYyTHZDSThKaDU0WjRLUmtkN0l1TEsy?=
 =?utf-8?B?WlhZSUNvQm40T1IzSEdMQUZ4cEJmZGJlUi9ZRkVIK0tKWGFlNVFtR3IzQWhj?=
 =?utf-8?B?QnhTNGQwa1ZyMVhhMS9ZNW43ZjVKSlBRRFM1ck0xaFovdnpjMFZvNnp2cmlK?=
 =?utf-8?Q?4JOmcCd4Fc5j0D3VR35WUds=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C15DCFD744E028459C4B5AB233D694D3@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c95bc88-4168-42ed-0349-08db3a819ff2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 11:41:01.1273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOiQvRnfObialJQF89HNHlWRkekYCTgLA93NMWzrsqTYIwrQq+LS9CxR99N/4FO2ndNekY47jz0yOuxzeNqT0ILiGNf7KTG9JCvpEY53OrC1S8QQA1AbdFRX/8iT2Hws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1723
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gNC8xMC8yMyAxOToxNiwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gVHVlLCA0IEFw
ciAyMDIzIDE1OjA0OjM4ICswMzAwDQo+IE1hdHRpIFZhaXR0aW5lbiA8bWF6emllc2FjY291bnRA
Z21haWwuY29tPiB3cm90ZToNCj4gDQo+PiBIaSBkZWVlZSBIbyBwZWVwcywNCj4+DQo+PiBUaGUg
Uk9ITSBCVTI3MDM0IHdvcmsgc2VlbXMgdG8gYmUgc2xvd2x5IGNvbnZlcmdpbmcgOikgU28sIGl0
IGlzIGEgZ29vZA0KPj4gdGltZSB0byBzdGFydCB3b3JraW5nIHdpdGggdGhlIG5leHQgc2Vuc29y
IHNpdHRpbmcgb24gbXkgdGFibGUuDQo+Pg0KPj4gVGhpcyB0aW1lIEkgYW0gZGVhbGluZyB3aXRo
IGFuIFJHQitjK0lSIHNlbnNvciwgd2hpY2ggb25jZSBhZ2FpbiBoYXMNCj4+IHNvbWUgcGVjdWxp
YXJpdGllcy4gSSB3b3VsZCBhZ2FpbiBiZSB2ZXJ5IGdyYXRlZnVsIGZvciBhbnkgYW5kIGFsbA0K
Pj4gcG9pbnRlcnMgc28gSSBjb3VsZCBoZWFkIHRvIHRoZSByaWdodCBkaXJlY3Rpb24uDQo+Pg0K
Pj4gVGhlIElDIGhhcyA0IGRhdGEgY2hhbm5lbHMuIEZpcnN0IHR3byBiZWluZyBhbHdheXMgUkVE
IGFuZCBHUkVFTi4gVGhpcmQNCj4+IGNhbiBiZSBjb25maWd1cmVkIHRvIEJMVUUgb3IgQ0xFQVIg
YW5kIGZvdXJ0aCBjYW4gYmUgc2V0IHRvIENMRUFSIG9yIElSLg0KPiANCj4gR3Vlc3NpbmcgZ2Ft
ZXMsIGJ1dCBhcmUgd2UgdGFsa2luZyBhIGNhc2Ugd2hlcmUgd2UgYXJlIGVmZmVjdGl2ZWx5DQo+
IGxvb2tpbmcgYXQgYSBwYWlyIG9mIHR3byB3YXkgbXV4ZXMgb24gdGhlIGxhc3QgdHdvIGNoYW5u
ZWxzPw0KPiBPciBpcyB0aGlzIGEgY2FzZSBvZiBvbmUgYmlnIG11eCBhbmQgYW4gb2RkbHkgZGVz
aWduZWQgc2VxdWVuY2VyPw0KPiBEb2Vzbid0IGFjdHVhbGx5IG1ha2UgYW55IGRpZmZlcmVuY2Uu
IFRoaXMgaXMganVzdCBvZGQgZW5vdWdoIHRoYXQgSSdtIGN1cmlvdXMuDQo+IA0KDQpJIHRoaW5r
IEkgbWlzc2VkIHJlcGx5aW5nIHRvIHRoaXMuDQoNCkkgd291bGQgZ3Vlc3MgaXQgaXMgYSBwYWly
IG9mIG11eGVzIC0gYnV0IEkgZG8gbm90IGtub3cgZm9yIHN1cmUuIFRoZSANCmRhdGEtc2hlZXQg
SSd2ZSBzZWVuIGlzIG5vdCB0b28gZGV0YWlsZWQuIFRoZSAiYmxvY2sgZGlhZ3JhbSIgSSBzZWUg
DQpzaG93cyB0aGUgcGhvdG8gc2Vuc29ycyBmb2xsb3dlZCBieSBmb3VyIEFEQ3MuIFRoaXMsIGhv
d2V2ZXIsIGlzIGp1c3QgYSANCnZlcnkgcm91Z2ggcGljdHVyZSBhbmQgaXQgZG9lcyBub3Qgc2hv
dyB0aGUgbXV4ZXMuIEkgZ3Vlc3MgaXQgaXMgdGhlcmUgDQpqdXN0IHRvIGlsbHVzdHJhdGUgdGhl
IGZ1bmN0aW9uYWxpdHkgbW9yZSB0aGFuIHRvIHJlYWxseSBleHBsYWluIHRoZSANCmhhcmR3YXJl
Lg0KDQpZb3VycywNCgktLSBNYXR0aQ0KDQotLSANCk1hdHRpIFZhaXR0aW5lbg0KTGludXgga2Vy
bmVsIGRldmVsb3BlciBhdCBST0hNIFNlbWljb25kdWN0b3JzDQpPdWx1IEZpbmxhbmQNCg0Kfn4g
V2hlbiB0aGluZ3MgZ28gdXR0ZXJseSB3cm9uZyB2aW0gdXNlcnMgY2FuIGFsd2F5cyB0eXBlIDpo
ZWxwISB+fg0KDQo=
