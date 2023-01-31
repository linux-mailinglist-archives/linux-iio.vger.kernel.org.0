Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F016828E5
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 10:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjAaJcB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 04:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjAaJcA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 04:32:00 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2096.outbound.protection.outlook.com [40.107.20.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF0A125AE
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 01:31:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWU8GtAU66B3JC9AkSUY8eW4GqRidHqyT3QyR+dUpNv5oWsv3RtlG1Da2DiAfQvIYIxwZ/kZNuCUmIRIGNMUAmzbWJKkexxaEXLx/mnPIYq5zMvCqOcPwCYzz3EXRiWLjZzJcaR5XADpQaLzfXEp28EYTBeonOHRnJJyAiHX4wAMsOUeJSdmrr8Wcpzs5849JmhEFBh+Jofei5tdhi25XiYHChLznRAsiTTERCXTmPpf5laC0lgLyud4vuBYZZwr2GoGY7RN1sWwzHMWPCr2r0UIZR5uImR/ami6orsWLHPIyc8dNxmAWCfomsiHCokFDD6GrgsXFcKFA+cXE8aCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNDnCL6ctrPa6CAx9eZinDO71euFaHXDkn0HEJZJ8a8=;
 b=Q1fuE/1no0jZC79K1Bo+Lxqprk++tv1JUBeeWigQxLa+03bDUoJGAs9Ee7R7juC9z9ZUSAgWawLP+Aq8qWSe86/wAmT/LFO2dTMu6oSVxq/MFzZaTvs5jJMi2nKZH5VFe1448RyXuQiHU3NporckJhWfLBXf87TAftacKSjId82mgmuADNmnQTcWI79u21WkkLwIp58VxDoAOK0PFeaIF7I2PcRDsK1uwHN0Gaaat4LYTA82C6UlynlE5uDz8iLTwRHbOMwsLdSzp6Ga3xXxsNNAK9rup1Uobmv0dXjdZlO1xA9b4p2pe7GR+Lo7jKOjBGVFlz4vv8q0qncJfLjWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNDnCL6ctrPa6CAx9eZinDO71euFaHXDkn0HEJZJ8a8=;
 b=ZsbZ63yRMMJrLnIsLZAeJoi4Vy8QjpIp/A9CMyURJMmsx9kIF0WSi9gaB8x05bOHLhn2jliREOwHR0YvuMAxGdSgqPTYm6Lrt3f/By5NrwPukiW5frl9bdbxEnpXJnqsDW9W9TOoozyKLUOT2Ykxri/gWqK4wMNtqhYPIyJjUUQ=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR3P281MB1517.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 09:31:53 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f504:16e7:71d4:2fd8]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f504:16e7:71d4:2fd8%6]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 09:31:53 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: ROHM ALS, integration time
Thread-Topic: ROHM ALS, integration time
Thread-Index: AQHZNKMVIPWNlUK74ku14mYbRomWqa627POAgAFXe4A=
Date:   Tue, 31 Jan 2023 09:31:53 +0000
Message-ID: <baec476f-c72e-23d7-76b1-4e5062173226@fi.rohmeurope.com>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
 <20230130130231.000013b6@Huawei.com>
In-Reply-To: <20230130130231.000013b6@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR3P281MB1517:EE_
x-ms-office365-filtering-correlation-id: f8633fce-deda-4b29-c879-08db036dfd1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWNscx5tMtSgYTA28HwXO0vjiNB4thcPVeoGqveUm4C1SW4y/vX4yP2Sx3tRqyNSbC81aYR01WbRydaqNZ7R2Yzp4oRYHkDp+LOLZtnSzYZujVPPcC80PCdQZpQof8GzJ2nCvzCMLqMDgtSnFp4CJMktkB7CQPgx7KZRWSbbSh2iTcxbHFpH5ntA7ESFZ3z8U36oXuS8dIuNMqYpD84HdfAA9Ybb07v4baahMc2IeFZGbUNCCWl4/F7eO+aA0hRCzoqymnLshmneidvCuMtvyuPOGiDtB5u8xpp8b2wEwxoXheYhzHFLXSK9d6e6XgUPNrkLaRxPkH8MP8/lzAmLn/gXK4A3YcZzid94055rtzewQgQ057OJzm8U1Hfyg0BEofhM/AvDEq3Ip36zJ0rATffY2Y0nG55pwtcTSipcT1B93NR5Mb/uaIiKVfV33fyvSgt4Oeo5HYZyNEepbnxVe52BkUXVfBZjSa1AjlltnsHRwB4ngHr8mF3LxmHBMJgCdIMGT6ZalFTJt7IQ0n503onja3xHzkqDxoPftnHsNZnz/vxqGlBD0LRcpsnjccYnEyzAHvzjjv/w031X62rPIAvJeGXl3yfKFvkO8M6YksaoGocvEBBliGEscz8aIHMfYgJCOJ514qvcrcs7WamA9VJF4pqoT92VVQBkyp9Jj1gPMI2CGFzzKptwbh2PG1Ha1oXPogF0OMTQqDCP8SiQ6EXnkPDfc6TMTFKLd+sIhnZvF95Z4yUY11Z/so5Mj/sjJaE5biRQ+2vNIuZElooEOIt2KF8UOYY6o484UEPgXNnNop+hV75j/3mLUvUnNJ4y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39850400004)(346002)(136003)(376002)(451199018)(316002)(8936002)(6506007)(86362001)(478600001)(53546011)(38100700002)(966005)(2616005)(31696002)(6486002)(38070700005)(71200400001)(186003)(6512007)(122000001)(5660300002)(54906003)(110136005)(2906002)(83380400001)(41300700001)(31686004)(4326008)(66476007)(66446008)(64756008)(66556008)(76116006)(91956017)(66946007)(8676002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDlKY1RkQ2lZQXJ6V0pnY2dERkVxYStwNnZQWlJyZGI2c1VOOG9GenBjRUVV?=
 =?utf-8?B?UVBCYnNpYVZTM0RKMWRQSVR3UkhFeGRpSkk4YXFzQXkvelJLVEJkSzcvdGRE?=
 =?utf-8?B?UU9iMEg5V3JHbEpITnBjTSt0UStaY1dnZit3WTBpQjhHYWNzNTFlYnl0Rmdl?=
 =?utf-8?B?S3lzSVJBd3JEeEV0WVRsY2RUZG5oRE12c21XL2FrMXlCcGZOSlViUGdaT1VK?=
 =?utf-8?B?QXNySk9ZNk4rcFo5Z2h1UVkvNlU2Nmh2dzk3a3NKNlppZ2UzK1ZvbmRMbjFF?=
 =?utf-8?B?MSt0UFlvOVB0eXppaTQzd1kxRUpNc0JZUGFEdkVOUktrUU15RjkrMGhUeXpa?=
 =?utf-8?B?RmNBNk83d2sxUkhxZURPQ2IrUi9qTlNDVUhRQktvczJQWG5FQ0dnRUdHaEx4?=
 =?utf-8?B?QmM0MlhwTFg0K2tVTGwzVEtqRVFwOWc2ZnBiSzU2ZkxoWDRKRGJJRWFCUW9V?=
 =?utf-8?B?M0w0MktkSjFJdGNDVmxKNFdrMmZsUDRtYUJ2c3grQUQzMFNtd3V3bmFtcGFw?=
 =?utf-8?B?QmtDMEhyVEpjL05JN05lbU9FUGU2T3MyWUkrT1o5YTRybDI0Sk1wL2luQ1RC?=
 =?utf-8?B?aHQ0OWFFbCsvek56NlRmdm9CQzZHd01XUFlycGlNS053TS9vbzhnNmRrUThY?=
 =?utf-8?B?dzZvbFZvb2w2SzBsbmpYL0xMUWtuVEZ0dVVhSlh0SDFXMjYra05tUzNYRllJ?=
 =?utf-8?B?Q2ZQTkl0elNhdnpMTzFKbE1xNUpvK2VCc0RYeVN5bDhOWmRFR1FOQ2NadlI1?=
 =?utf-8?B?VFdyZHVTSlNTY2dGMDNmOXlFK0dlRWZYWXpock5pT1d4bm53TnluM2g5WFEz?=
 =?utf-8?B?bUtWcUQ2cXZnR251ZlVtTXRKcWpqb3ROU29SejZjYWlaTHFkRUpudlRnSFJa?=
 =?utf-8?B?RHk4M2s3RmExdlZSL1JlOVNxRktrOG1waTUwdlRSc1Q4bjdZaFVUUHNsQWlL?=
 =?utf-8?B?RHRPOEdGWHBhTEMyUU12VTdEckxBSmNjbzhyTlE3R3dTL0hwR0R2VU53Q2Uz?=
 =?utf-8?B?WmplOUVwRnpZZjlZSUdwRjZBVEIzQUw1R2ZqdHRIU0doOXdCdlhuOXRYUW9w?=
 =?utf-8?B?ZG4zZGNsNk1XYmFDeXplWU5LazRiVmtBbS9LSTV2S1hKeGdIaUgrR1hWSDVl?=
 =?utf-8?B?S0E0YWdFVVlGOUxrQmxXdEt3WkRTTXdjOW8yRzYvTlhLdTN1OEFMTXlGeEFu?=
 =?utf-8?B?VzRaTzNTTlJCaDlqQmsrRU1jY3NaMnNlbzlMRmFrZkpDeVRBcEhURkxtQTI0?=
 =?utf-8?B?TGRnMnF4UzhqYVJ5dUpDcUlGWVZTdEVKdEtXRzNISTJxd2phK2d5aFJnNnhx?=
 =?utf-8?B?NUJqc1Urd0toSGxYbEh3c0NUbXJZM2JxWFNZNlhzTVh1Ty9PLzlUbmVWZWRI?=
 =?utf-8?B?Ti8zM3NUSXc4TnM5S2N2MHB3OFYyVmpZd3JtaXRRVFFjeDZ5QVRqcVVjTzdr?=
 =?utf-8?B?amwrdVFMUVRRbVp3aTRzci9jT056SENlbVVRazg5MmtEbXdwUmFBZU5ZTHFD?=
 =?utf-8?B?UHFDSGZjbTl0bjk1MklpajU2NThPQUNURm1pYTJmK0g4TGpRQ2tXR3hMN2Jm?=
 =?utf-8?B?d3FSZ3doRkdKUUN3VEtYVUpCdXNjVUhQT0tJZUt4RjZSaTNqY256Q3BBaUVh?=
 =?utf-8?B?WFJObG1rSk9IY3V5QVhrc2ZkQXRUa1RhMXk2ek9QWkdGUXJBdnU1bzh6Wnd6?=
 =?utf-8?B?Z1lhUnpBc3hXS080bU14RllreDRHNnBoSTJ5UDUzSDRSRnpWbDFQOHV4Q1Ez?=
 =?utf-8?B?Q0NDK2IySkF2Y1RsZ1NHNWJTMHRocWt2SkhSdU90bm9aTnQ3VTFpU2wzQWNk?=
 =?utf-8?B?RXhRSVZHRGlDM2s4aUpOaGFkcVl4UFUzeG5XVzYvdGVMdUZsY2xtVzU4RDMx?=
 =?utf-8?B?b3RONDBqVjdFanlyckpVU25ZRDg1T1VPK0lVSkRQTktZaWczN2I5L3JxWlE3?=
 =?utf-8?B?cmNpWXNZMXpxdzlXN011ZE5RUFVzZGp2a2RmMU5JazhvZU8yaGw2eTQ0WnRM?=
 =?utf-8?B?UFdZTlhDY3duajJVdEc2MStFTm8wVVZSa0ZkWnEzcFhueWw2QUt5cFhpOEtD?=
 =?utf-8?B?WWthU0k0M3RUc2NNSjF4d3czQlBvWEIwSkpPRXVRQXVib1dqSFNhQVg2aTRq?=
 =?utf-8?B?dzEzMnByc21VNy9HdzlGaUx6U2JFWkMrcWY4N2gzajJKem9QQTJzUDk4UE95?=
 =?utf-8?Q?SXY5Lz6Aj66WwSrcFfDwB90=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F2C822E04814643A9BF374C885FB7AF@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8633fce-deda-4b29-c879-08db036dfd1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 09:31:53.5872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d90jFIDVwO+uZBxQdGu+vPyJ9b3TCtpc7tWiN8D7UCwsZBnFxaep3psFOda/oQdSx7PZ5JZQM72ey3j/SlUa+teaZof6yi+/Kaz+VmAVpKPGqtPA63dEH4luEQ68A00V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1517
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMS8zMC8yMyAxNTowMiwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gTW9uLCAzMCBK
YW4gMjAyMyAxNDowNDo1MyArMDIwMA0KPiBNYXR0aSBWYWl0dGluZW4gPG1henppZXNhY2NvdW50
QGdtYWlsLmNvbT4gd3JvdGU6DQoNCj4+IEhvd2V2ZXIsIHRoZSB2YWx1ZXMNCj4+IHNwaWxsZWQg
ZnJvbSByYXcgSUlPX0lOVEVOU0lUWSBjaGFubmVscyB3aWxsIGNoYW5nZSB3aGVuIGludGVncmF0
aW9uDQo+PiB0aW1lIGlzIGNoYW5nZWQuIFNvLCBzaG91bGQgSSB1c2UgdGhlIGluZm9fbWFza19z
aGFyZWRfYnlfdHlwZSA9DQo+PiBCSVQoSUlPX0NIQU5fSU5GT19JTlRfVElNRSkgZm9yIElJT19J
TlRFTlNJVFkgY2hhbm5lbHM/DQo+IA0KPiBBaC4gVGhpcyBwcm9ibGVtLiBUaGUgbWl4dHVyZSBv
ZiB0d28gdGhpbmdzIHRoYXQgZWZmZWN0aXZlbHkgbWFwIHRvIHNjYWxpbmcNCj4gb2YgcmF3IGNo
YW5uZWxzLiBBcyBfc2NhbGUgbXVzdCBiZSBhcHBsaWVkIGJ5IHVzZXJzcGFjZSB0byB0aGUgX3Jh
dyBjaGFubmVsDQo+IHRoYXQgaGFzIHRvIHJlZmxlY3QgYm90aCB0aGUgcmVzdWx0IG9mIGludGVn
cmF0aW9uIHRpbWUgYW5kIGEgZnJvbnQgZW5kIGFtcGxpZmllcg0KPiBhbmQgaXMgdGhlIGNvbnRy
b2wgdHlwaWNhbCB1c2Vyc3BhY2UgZXhwZWN0cyB0byB1c2UgdG8gdmFyeSB0aGUgc2Vuc2l0aXZp
dHkuDQo+IA0KPiBUaGF0IG1ha2VzIGl0IG1lc3N5IGJlY2F1c2UgaXQncyBub3QgYWx3YXlzIHRv
dGFsbHkgb2J2aW91cyB3aGV0aGVyLCB3aGVuDQo+IHRyeWluZyB0byBpbmNyZWFzZSBzZW5zaXRp
dml0eSwgaXQgaXMgYmV0dGVyIHRvIGluY3JlYXNlIHNhbXBsZSB0aW1lIG9yIGdhaW4uDQo+IFVz
dWFsbHkgeW91IGRvIHNhbXBsZSB0aW1lIGZpcnN0IGFzIHRoYXQgdGVuZHMgdG8gcmVkdWNlIG5v
aXNlIGFuZCBmb3IgbGlnaHQNCj4gc2Vuc29ycyB3ZSByYXJlbHkgbmVlZCBwYXJ0aWN1bGFyIHF1
aWNrIGFuc3dlcnMuDQo+IA0KPiBTbyBpbiB0aGUgaW50ZXJlc3RzIG9mIGtlZXBpbmcgdGhpbmdz
IGVhc3kgdG8gdW5kZXJzdGFuZCBmb3IgdXNlcnNwYWNlIGNvZGUNCj4geW91IHdvdWxkIG5lZWQg
dG8gcHJvdmlkZSB3cml0ZWFibGUgX3NjYWxlIHRoYXQgdGhlbiBhdHRlbXB0cyB0byBmaW5kIHRo
ZQ0KPiBiZXN0IGNvbWJpbmF0aW9uIG9mIGFtcGxpZmllciBnYWluIGFuZCBzYW1wbGluZyB0aW1l
Lg0KDQpUaGVyZSBpcyAoYXQgbGVhc3QpIG9uZSBtb3JlIHRoaW5nIHdoaWNoIEkganVzdCBub3Rp
Y2VkIHdoZW4gSSBjb250aW51ZWQgDQp3cml0aW5nIHRoZSBjb2RlLg0KDQpDaGFuZ2luZyB0aGUg
aW50ZWdyYXRpb24gdGltZSBpbXBhY3RzIGFsbCBpbnRlbnNpdHkgY2hhbm5lbHMuIFNvLCBzY2Fs
ZSANCndpbGwgYmUgYWRqdXN0ZWQgZm9yIGFsbCBjaGFubmVscyB3aGVuIGEgcmVxdWVzdCB0byBz
ZXQgc2NhbGUgZm9yIG9uZSANCmNoYW5uZWwgY2F1c2VzIGludGVncmF0aW9uIHRpbWUgdG8gY2hh
bmdlLiAoR2FpbiBvbiB0aGUgb3RoZXIgaGFuZCBpcyANCmFkanVzdGFibGUgc2VwYXJhdGVseSBm
b3IgZWFjaCBjaGFubmVsLikgRG8geW91IHRoaW5rIGEgdHlwaWNhbCANCnVzZXItc3BhY2UgYXBw
bGljYXRpb24gY2FuIGNvcGUgd2l0aCB0aGlzPw0KDQpJIGFtIHVuc3VyZSBpZiBJIHNob3VsZCBq
dXN0IHVzZSB0aGUgYmlnZ2VzdCBpbnRlZ3JhdGlvbiB0aW1lICg0MDBtUykgYnkgDQpkZWZhdWx0
IGFuZCBvbmx5IGRlY3JlYXNlIHRoaXMgd2hlbiB2ZXJ5IHNtYWxsIGFtcGxpZmljYXRpb24gaXMg
DQpyZXF1ZXN0ZWQgYnkgc2V0dGluZyBzY2FsZSA+IDEuIFRCSCwgSSBkb24ndCBsaWtlIHRoaXMu
IEl0IHByZXZlbnRzIA0KaGF2aW5nIHNob3J0ZXIgbWVhc3VyZW1lbnQgdGltZXMgd2l0aCBnYWlu
cyBncmVhdGVyIHRoYW4gMXggLSBhbmQgSSANCmJlbGlldmUgdGhhdCB1c2VycyBtYXkgd2FudCB0
byBoYXZlIGhpZ2hlciBnYWlucyBhbHNvIGluIGNhc2VzIHdoZXJlIA0KdGhleSB3aXNoIHF1aWNr
ZXIgbWVhc3VyZW1lbnRzIGZyb20gdGhlIHNlbnNvci4NCg0KU29tZSBvdGhlciBvcHRpb25zIEkg
YW0gY29uc2lkZXJpbmc6DQoxLiBTa2lwIHRpbWUgY29uZmlnIGZvciBub3cgLSBlYXNpZXN0IGJ1
dCBkb2VzIG5vdCBnaXZlIGZ1bGwgdXNhYmlsaXR5DQoyLiBBbGxvdyBzZXR0aW5nIHRoZSB0aW1l
IHZpYSBkZXZpY2V0cmVlIGF0IHByb2JlIHRpbWUgLSBzbGlnaHRseSBiZXR0ZXIgDQpidXQgbm90
IHZlcnkgZHluYW1pYy4NCjMuIEN1c3RvbSBkZXZpY2Utc3BlY2lmaWMgc3lzZnMgZmlsZSBmb3Ig
c2V0dGluZyB0aGUgdGltZSBzbyANCnNwZWNpZmljYWxseSB0YWlsb3JlZCB1c2VybGFuZCBhcHBz
IGhhdmUgYWNjZXNzIHRvIGl0IC0gYWRkaW5nIG5ldyBBQkkgDQpmb3IgdGhpcyBpcyBwcm9iYWJs
eSBub3Qgc29tZXRoaW5nIHdlIHByZWZlciA7KQ0KNC4gQWxsb3cgc2V0dGluZyB0aGUgaW50ZWdy
YXRpb24gdGltZSBpbiBzaXR1YXRpb25zIHdoZXJlIHRoZSBkcml2ZXIgY2FuIA0KaW50ZXJuYWxs
eSBoaWRlIHRoZSBzY2FsZSBjaGFuZ2UgYnkgY2hhbmdpbmcgdGhlIGdhaW4gYXMgd2VsbCAtIHRo
aXMgDQpvcGVyYXRpb24gaXMgbm90IGF0b21pYyBpbiB0aGUgSFcgYW5kIGFkZHMgc29tZSBleHRy
YSBjb21wbGV4aXR5IHRvIHRoZSANCmRyaXZlci4gQWxzbywgdGhpcyBmYWlscyBmb3IgY29uZmln
dXJhdGlvbnMgd2hlcmUgdGhlIGdhaW4gc2V0dGluZyBpcyANCnN1Y2ggaXQgY2FuJ3QgY29tcGVu
c2F0ZSB0aGUgc2NhbGUgY2hhbmdlLg0KDQpJIHdvdWxkIGJlIGdyYXRlZnVsIGZvciBhbnkgc3Vn
Z2VzdGlvbnMgOikNCg0KRmluYWxseSwgdGhlIEJVMjcwMzQgYWxsb3dzIHByZXR0eSBiaWcgZ2Fp
bnMgLSBmcm9tIDF4IHRvIDQwOTZ4LiBBZnRlciBhIA0KcXVpY2sgbG9vayBpbiBleGlzdGluZyBs
aWdodCBzZW5zb3IgZHJpdmVycyAtIEkgdGhpbmsgdGhlIGF2YWlsYWJsZSANCnNjYWxlcyBmb3Ig
SUlPX0lOVEVOU0lUWSBjaGFubmVscyBhcmUgdXN1YWxseSBmcm9tIDEuMCBkb3dud2FyZHMuICgi
MS4wIA0KMC54eHggMC55eXkgMC56enoiKS4gNDA5NnggKG9yIDMyNzY4eCBpZiB3ZSB0YWtlIHRo
ZSBtYXggbWVhc3VyZW1lbnQgDQp0aW1lIGludG8gYWNjb3VudCkgd2lsbCBjYXVzZSBzb21lIGxv
c3Mgb2YgYWNjdXJhY3kgZXZlbiB3aXRoIE5BTk8gc2NhbGUgDQppZiB3ZSB1c2Ugc2NhbGUgcmFu
Z2Ugc3RhcnRpbmcgZnJvbSAxLjAuIElzIHRoZXJlIGFueXRoaW5nIHRoYXQgcHJldmVudHMgDQpz
dGFydGluZyB0aGUgYXZhaWxhYmxlIHNjYWxlcyBmb3IgZXhhbXBsZSBmcm9tIDE2LjAgZW5kaW5n
IDk3NjU2Mi41IA0KTkFOT3MgKHRvIGRlY3JlYXNlIGxvc3Mgb2YgcHJlY2lzaW9uIGFzc3VtaW5n
IGJvdGggdGhlIGZ1bGwgZ2FpbiByYW5nZSANCmFuZCBhbGwgdGltaW5nIHZhbHVlcyBbZXhjZXB0
IHRoZSA1IG1TXSBhcmUgc3VwcG9ydGVkKT8gQXQgbGVhc3QgSSANCmRpZG4ndCBzZWUgYW55IGxp
bWl0YXRpb25zIGluIHRoZSBzeXNmcy1idXMtaWlvIDspIE15IGd1ZXNzIGlzIHRoZSANCnVzZXJz
cGFjZSB1c3VhbGx5IGhhbmRsZXMgdGhlIGludGVnZXIgcG9ydGlvbiBvZiBzY2FsZSBqdXN0IGZp
bmUoPykNCg0KT2gsIGJ5IHRoZSB3YXkgLSBJIGZvdW5kIGEgcHVibGljbHkgYXZhaWxhYmxlIGRh
dGEtc2hlZXQgZm9yIHRoZSBBTFMgDQpzZW5zb3IgSSBhbSB3b3JraW5nIHdpdGguIDopDQoNCmh0
dHBzOi8vZnNjZG4ucm9obS5jb20vZW4vcHJvZHVjdHMvZGF0YWJvb2svZGF0YXNoZWV0L2ljL3Nl
bnNvci9saWdodC9idTI3MDM0bnVjLWUucGRmDQoNClNlZW1zIGxpa2Ugbm8gcHVibGljIGRhdGFz
aGVldCBmb3IgdGhlIG90aGVyIHNlbnNvcnMgSSBtZW50aW9uZWQgdGhvdWdoIDooDQoNCkFzIGEg
c2lkZSBub3RlIC0gSSBoYWQgYWx3YXlzIHRob3VnaHQgbWVhc3VyaW5nIHRoZSBsaWdodCBpcyBq
dXN0IHNpbXBsZSANCnZhbHVlIHJlYWRpbmcgZnJvbSBhIHNlbnNvci4gSSBuZXZlciByZWdhcmRl
ZCB0aGUgZmFjdCB0aGF0IGh1bWFuIGV5ZSANCnNlZXMgb25seSBjZXJ0YWluIHdhdmVsZW5ndGhz
IG9yIHRoYXQgdGhlIHNlbnNvcnMgc2Vuc2l0aXZpdHkgY2hhbmdlcyANCmRlcGVuZGluZyBvbiB0
aGUgd2F2ZWxlbmd0aC4gSXQncyBmdW5ueSBob3cgSSBhbHdheXMgZW5kIHVwIGtub3dpbmcgbGVz
cyANCndoZW4gSSBrbm93IG1vcmUgOykNCg0KWW91cnMsDQoJLS0gTWF0dGkNCg0KLS0gDQpNYXR0
aSBWYWl0dGluZW4NCkxpbnV4IGtlcm5lbCBkZXZlbG9wZXIgYXQgUk9ITSBTZW1pY29uZHVjdG9y
cw0KT3VsdSBGaW5sYW5kDQoNCn5+IFdoZW4gdGhpbmdzIGdvIHV0dGVybHkgd3JvbmcgdmltIHVz
ZXJzIGNhbiBhbHdheXMgdHlwZSA6aGVscCEgfn4NCg0K
