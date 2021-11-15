Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC94450132
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 10:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhKOJ0a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 04:26:30 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:14469 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbhKOJ0O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Nov 2021 04:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1636968199; x=1668504199;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/MQ2AbleS2mfF+YDnSszmi4KhoHN13zaJJ5/EpvmQwM=;
  b=NJu59GNuKU8MQ6a53Q3nBU5UgtXOsKl3PpiseB9mv/pHzZt18sRsVtNf
   rXCej7YL4gNg40bShOfFdnN38k4SbwQNwRYIG5qF0rb3e86m4phqq2337
   7sKBhxbCXFRwlZ4eocmH9scF9dPdjYq+aG1f97CkpqlWmlMUA49xuI0sD
   Q3Y4uHvgpIJ27wQ64JLCPIEtoIXwPH2jo8+vWSiRNA3Ke9OmiK/NxUcRf
   ApOwMbtkYwDMnbW4st0rMc/HDIlh+0wNMJ+0sAGvHllyn8xIyYAe+UoYm
   eakSWcN6JBTZUuPUyoeHQlh0KefOpm6tYUbvkVlA6tT7LRoZ3Ai76Lp5f
   A==;
IronPort-SDR: 3Mmo8Szc0SIWedGhMv7QOqVswCh4vnmqEzqQag+cGNnUkZUEvrLqNpbWTKHh/WkVivVitLyYzL
 8HMUvX6EQWWt4jTmESyogggPeSDd4L1rk2pQqwKghkcYbDAMGmaGbbd+JppNjW0oEHBbB9+uD2
 Uz2AfX1ppmNbLcPQPfypArX0va5q5zFfvNRstHQUhOmDfksl61KkeqrWfy6MotFaF/A0QPt72n
 zSQrPe5c3aKrNqgwFsmpGSzdmaDp/QAyyhRXdkZehXEx7fFhQois6mzNRABlmHh7vM96J5WbUn
 Ak16vmLgmgn8QsOwPx3WR4QG
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="143921562"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2021 02:23:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 15 Nov 2021 02:23:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Mon, 15 Nov 2021 02:23:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H57ct28mod5dykjgdQUEElQ8aY4bgHRlmjoWAc9hWijaEHtTXJgsh0QI8C93ieVuDfeWK6b/idGrGWb16iS/IBwyf/kkUyqcskfELneX32O1u35kPS+UkV6wstku2WFqWDiQNgLdFfn/kjmdmILzHbBknyNjYkCA0SPdC1YaeAg46DQgko1QBvU7dr5nHD4SH+lN+ypuMoVUjikkDEvpkt1DXzwMc2y+CBq7G6R2MfotUHvfyIcrsUy+qLi/z7M9zUynSdnm3f9PT7BPrxD1PEbUg3CxqtHxJ3G0BVFw/a8OfKZI4bLM5/eFVOGaee5CLesDefC+8YqP4sgcWiZE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MQ2AbleS2mfF+YDnSszmi4KhoHN13zaJJ5/EpvmQwM=;
 b=O7TvkiKu1K/umGyh/3dGP930Vr2y8LQaVJp8TClG9JGyIiR8mSm21zGTjxhVaa79+Tl9rMfXNnNb5sUGRN3lcEorzZj73uFa8iprcMjV9C5tl/TTBM8wEO1cf8x5ZnL/taASpV6swV5I6WIExPN+Tlnk+E8Hpixq8YZzMCCmaOJvqB7eXd/cfbwM3cFrhfPHkluEAO7qBqEK50VAMpgzjS7sfFVarN0WtRQ58p5DqZhbsEhew/K8zc7al3ufKoqMdNLS/TT2SJDdEh9HPqufW3dzzmomsXpqKTnsuocGHzsdP/luoB1l5jyy3akntF3OIau/tfUDcf2c9ce8jWO3aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MQ2AbleS2mfF+YDnSszmi4KhoHN13zaJJ5/EpvmQwM=;
 b=TXw0e2qFesWQc4ul4rtlcfBFCG/8RaeQTU5Ksl4XD015Ij7QfKqPd+WoGUdR4E4YyvIGvIo5b1Oq7YfS8vgdQRrJ0L9BZ0Pn+7p5KNQP3Kqtjrb017Be713Swj9c/gAuJyYQ3mucplme3qDv3cgt7ryY2q71q2qeQXL1tByKhSs=
Received: from BN9PR11MB5514.namprd11.prod.outlook.com (2603:10b6:408:103::7)
 by BN6PR11MB1442.namprd11.prod.outlook.com (2603:10b6:405:9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Mon, 15 Nov
 2021 09:22:58 +0000
Received: from BN9PR11MB5514.namprd11.prod.outlook.com
 ([fe80::5933:9a3c:4793:c21]) by BN9PR11MB5514.namprd11.prod.outlook.com
 ([fe80::5933:9a3c:4793:c21%7]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 09:22:58 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <gwendal@chromium.org>
CC:     <lars@metafoo.de>, <andy.shevchenko@gmail.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] iio: at91-sama5d2: Use scan_type when processing
 raw data
Thread-Topic: [PATCH v2 08/13] iio: at91-sama5d2: Use scan_type when
 processing raw data
Thread-Index: AQHX0VV0834tJnYqjkaIHHJDhpqmGawBuBiAgAKp9IA=
Date:   Mon, 15 Nov 2021 09:22:58 +0000
Message-ID: <115f9f1b-5282-4756-8128-863e15065a2f@microchip.com>
References: <20211104082413.3681212-1-gwendal@chromium.org>
 <20211104082413.3681212-9-gwendal@chromium.org>
 <20211113164201.60644fc4@jic23-huawei>
In-Reply-To: <20211113164201.60644fc4@jic23-huawei>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab76ee9d-a1af-49d6-c38e-08d9a81983a2
x-ms-traffictypediagnostic: BN6PR11MB1442:
x-microsoft-antispam-prvs: <BN6PR11MB1442AE79355BD113D0E461ACE8989@BN6PR11MB1442.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P9cMpG6UCg6OJZ3DkyAB2MIGhforlkFSOisRB0EpGFrTXLUT3KiivLU6uuky0GKFPOT1KiKmw/35ymaUruD9BS7yjaeilu2odVMrbJX0FD3Q8ueaD7J1496yBBhypMZWXhtKY8hIOwvhCjEDjtgGJC4k11ltMyonTNj7exDfDBqEc0+O8iMz2BZV6iwOgESdlPU/5Lk3H0FLyqTg247gEoGsJR/G66WFXLOZWTBQUk4CnjKvQ3LDs0OZknUZn+erSerWtQ9QwVAqAyTjuBD9ooEJu8WiNv/WwCxjtmRTnIxEo+I8clWvDLigEcWB+7ZeobjDWUkErhg57GYtrY3IS4aGidz6agR/1KPG+/EvTrERhMQiUTYOiT0G8MiCmjtojRta+b/XYxJyTT1nziQmkaoIDJWM9yXJmZTGw/SmfKx+VxhxCvnKRaro45faTRxJieRAj2jteWTe/T4+B8bizIW0scUGF+ciW8AZDGSPd6qwZoaHea1a8aujt/Zh53RwgP1BhT2HNQjQBY2byZPH5RW5fzvA2tw0HMmZLLvhSXweH9DKxjy3rA+/N30hc0QhmN0uxtzg66V2A4udrJLIqMryeIoHUetUGUJNgO9bl3+p7Z2BvRNdLfawKMrYey8mJG6lGrZEzZPJiy4cVA3/D8fp9TxDD02IE7wVO2iR3RmNHJSiVaUs/n5RBwaocC6ilmNQqjyFEhuhPj0Bp0hRTySS8lOZK71VaPywRv8avNc0Rhmz3JOVQgnPS2uFL3qiF9g4/mAsX4imKg9pA2YPrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(2906002)(71200400001)(64756008)(66946007)(6486002)(66556008)(38100700002)(186003)(8936002)(2616005)(316002)(8676002)(508600001)(31686004)(86362001)(66446008)(66476007)(76116006)(83380400001)(53546011)(5660300002)(6506007)(31696002)(6512007)(38070700005)(4326008)(36756003)(110136005)(54906003)(122000001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3RyL1Q2YzZDTGVHb2Y2dExrNTQ2bWowOHJWTW53NWdaRTNXcFRtRmhQMGwx?=
 =?utf-8?B?RzMwYVJMM3hlZDkwNCtjUjZTUExsaW1TblF2Q0ZwZGxaeWwzdFU1dGs5bXFK?=
 =?utf-8?B?OUVtOE5RN20ybCtML05aZGwwR3k3N1JTQ2Zsa0VhOWpEOEI2djM2MzB1UTMz?=
 =?utf-8?B?VHlacnZOaWYyZWpxbUh2QmIzSit1RkQvcnNybW40NU5pSFpWZ1dpd1ZhQWxi?=
 =?utf-8?B?Wk5LME5VWXZ2dkJzQUttWEhaYTJmcXBOQm9kcWJMTUdFK3l1VjhjVnkvUWJC?=
 =?utf-8?B?MGFvTmpDRkxhcmZxWWgvWTlRUDQxY2NJQ003UnB3L1JMbGoxMEhQUHFJOFQ3?=
 =?utf-8?B?SGRXK3M4R1F2TUtaelcxeGRaYnpnNEFtSG5sWTdEMndvVXhJdlBrUFd2M2pp?=
 =?utf-8?B?cUdnUVJ5NWNUNmE1RnNtWFBXM0tTTFlMU3REYzIySG8wR3NvWWxMMGh2bU01?=
 =?utf-8?B?QlRqR1FjNXhQOTdDZUZ5eHMrMDhNSkJwRkVOQ2tJYVE5M2Iza0ZwZTYybkMz?=
 =?utf-8?B?Mmt3aEdzQWlGZXF0a2Jqc3p0RjFYcHdlbHdZQlllUEQ5YnBlR3VHd3NCTkZm?=
 =?utf-8?B?TWZzWnhmc0o0bUhCOUxKdDcySWtDdzBUUDZNY2M5d20rV1E4UFBLVm5ickh6?=
 =?utf-8?B?MVU3UVlFUWJWTEVveWdva1ZQbjJabXE1Tjc4SHArTzFlRSt0Y21hdytwT3dH?=
 =?utf-8?B?NUNtdGVNemg1N0w1YjBoNFVHRlRjYldQWmNNbUVLUTM5WlJzRElRV0NRbDND?=
 =?utf-8?B?azRBdVlrTW54MWdselJRMnBXQTgvYzhMdTN0UlBMOTM3eVBTK1g1ZnlIZ055?=
 =?utf-8?B?eXZiem4wWlNkSVdyNDNUOXg2WUtsUk9XSFRCcWoxckw0K21SclZmVTgxUWc4?=
 =?utf-8?B?aG9tM1JneGgvWEpVSzdoUVRzWTVIQnFiWWZTM0xUa1VnbnBpWmVZR3JqV2V6?=
 =?utf-8?B?cERTcDdXc3JlTUE3UUZrZFZqRHNqSjA3UUdIMmdNbVpiS1lzWlVkaDk0OEVh?=
 =?utf-8?B?c2UzMExTeDdrOHFmZE9KZHh0TGxwcXdLY3lyZm5zYU9VeFUyejlSQkFNK2dx?=
 =?utf-8?B?ZDVNVUx6bHhybVB0azRUaWdwaHJSVmtDdFRvK1p6V0hXZmIva2F0c2p0QkRV?=
 =?utf-8?B?N3BPbUdQdDJOalNvRWNSRU5waVVwMGc2aFNkSll6NCtsT1A3TFhydm9iMGdp?=
 =?utf-8?B?eTcySHhUVEFFLy94RXJRTUh5ZVk5TlRHOE5iSVI2SFdMRjhDSThmcjBPaGhH?=
 =?utf-8?B?UWwyQjY5R3EvbEZHY3JuSk85TUx4aUlVRmxGM0IvdldDU0oydVl4WXFJOWs1?=
 =?utf-8?B?dDQ0Q2dkMWNLWlNUTkQ4eHdENzRGekN2QVc0TVBQK2FsKzRtUDFBcGJCSjZJ?=
 =?utf-8?B?WmdJSlBGSGdoTytpNjk4R3J5VjZ4d0dIWTJDVEM1MkxpM0FleXBnL0JpYjU5?=
 =?utf-8?B?bXdPcVczUnRqaURyUE41UmtBSG02M1BEaFVyV2wwOTdGZ1owKzNNQjNDclEw?=
 =?utf-8?B?TjhlMG1jbVRibUo5Z2NGMFUxdzd1dk1TOG15NHhLcTBSWlU5YUFlM3EvcXZL?=
 =?utf-8?B?WlpNRUE2YUU5SkRMRjRpcWhvYTJnQk9kNVdvcFBGOWZ0Z2hHMHlyaHNTZkJC?=
 =?utf-8?B?YWR4UWdVTmhqMElOSll5TFRWOXdVU29nMGNjTERhNDVXTTNBNlgxR2JoeUlR?=
 =?utf-8?B?VDVjWm9Bdk1WRUJ2ZllOOUhJV04rdVhtZk16UDBYSzF1eVhTRkpBOG5IWkIv?=
 =?utf-8?B?dUVQaTNuQkhzR1k3TXFONlRjcEhCWlNaK1RtN3F0d3pEeXBpdUNyVE1LR0li?=
 =?utf-8?B?ZjA5VGhRazRyUXY5c3ZxOU94YUVWUFZ0azJ4YVBLaStBVTY3K2FYQmljQUNp?=
 =?utf-8?B?anRQRGdwdThnWms4Z2Q5RTY4L0NUbnhFcVpZSzhOQktHQWI4dmdLM2F4ZDlO?=
 =?utf-8?B?dGxPQStSV21uck1RZ1BqeGlKbEcvRVJWS1lQZ2wzK2FmSklrUEtnMzU2UkF1?=
 =?utf-8?B?UEdDVGJDRWhSWWttM25oNFhPK0VzQ09KOWpIRm8yL0JaZDJpL0MyNXJPVldG?=
 =?utf-8?B?REFkUHpnRmcyUllGcFNpYmVGNzRtR1V4eFp4QkhQdTR1MHZQRUdWd0hLbGlj?=
 =?utf-8?B?MUlmMU1jd2tEY01UMmtEMkoxOFBBbzNlNzkxSlp0eXNEMTR1VHhwNUx5b0FG?=
 =?utf-8?B?SWFZWGJYSDhiT2xRMzQxU3hpYmZtMEtEUDNNVGEvamRXaG5OQ1NpbWVBdFV3?=
 =?utf-8?B?S0xlUzRtbmNIOUo2OTRtWDNSZ1B3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1CB1D10B2EC5B4DA0D18B61FFDACD41@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab76ee9d-a1af-49d6-c38e-08d9a81983a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 09:22:58.4143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPlcWLvDRW1VQpor/fDsvPZi8n0OXJc4gdtxuiV2gG2Vw54kIEKENFtzWZXWYxke5g/aWuHYK3fjG1Bv9w0aS+NIVGk30YJjTf241dimDFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1442
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMTEvMTMvMjEgNjo0MiBQTSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gVGh1LCAg
NCBOb3YgMjAyMSAwMToyNDowOCAtMDcwMA0KPiBHd2VuZGFsIEdyaWdub3UgPGd3ZW5kYWxAY2hy
b21pdW0ub3JnPiB3cm90ZToNCj4gDQo+PiBVc2UgY2hhbm5lbCBkZWZpbml0aW9uIGFzIHJvb3Qg
b2YgdHJ1c3QgYW5kIHJlcGxhY2UgY29uc3RhbnQNCj4+IHdoZW4gcmVhZGluZyBlbGVtZW50cyBk
aXJlY3RseSB1c2luZyB0aGUgcmF3IHN5c2ZzIGF0dHJpYnV0ZXMuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogR3dlbmRhbCBHcmlnbm91IDxnd2VuZGFsQGNocm9taXVtLm9yZz4NCj4gDQo+IEhpIEV1
Z2VuLA0KPiANCj4gR3dlbmRhbCdzIHYyIGNyb3NzZWQgd2l0aCB5b3VyIGNvbW1lbnRzIG9uIHRo
aXMgZml4aW5nIGFuIGlzc3VlIGluDQo+IDY3OTRlMjNmYTNmZSAoImlpbzogYWRjOiBhdDkxLXNh
bWE1ZDJfYWRjOiBhZGQgc3VwcG9ydCBmb3Igb3ZlcnNhbXBsaW5nDQo+IHJlc29sdXRpb24iKQ0K
PiANCj4gWW91IHJlcXVlc3RlZCBhIHNlcGFyYXRlIGZpeCB0byBjaGFuZ2UgdGhlIHZhbHVlIHRv
IDEzIHRoZW4gdGhpcyBvbiB0b3ANCj4gb2YgdGhhdC4gIEkgZG9uJ3Qgc2VlIHdoeSB3ZSBjYW4n
dCBnbyBkaXJlY3RseSB0byB0aGlzIHdpdGggYW4gYXBwcm9wcmlhdGVseQ0KPiByZXdvcmRlZCBt
ZXNzYWdlIHRvIHNheSB3aGF0IGlzIGJlaW5nIGZpeGVkLiAgQW0gSSBtaXNzaW5nIHNvbWV0aGlu
ZyBiZXlvbmQNCj4gdGhlIGZpeCBiZWluZyBtb3JlIG9idmlvdXMgaWYgd2UganVzdCBjaGFuZ2Ug
dGhlIHZhbHVlPw0KPiANCj4gV2hpbHN0IHRoaXMgaXMgcGVuZGluZyBJJ3ZlIGFwcGxpZWQgdGhl
IHJlc3Qgb2YgdGhpcyBzZXJpZXMgYXMgaXQncyBvbmx5IHRoaXMNCj4gb25lIHdpdGggb3BlbiBx
dWVzdGlvbnMuDQoNCkhpIEpvbmF0aGFuLA0KDQpJZiB5b3UgZmVlbCBpdCdzIG5vdCB3b3J0aCBm
aXhpbmcgaXQgaW4gYSBzZXBhcmF0ZSBjb21taXQgLCB0aGVuIGZlZWwgDQpmcmVlIHRvIGFwcGx5
IHRoaXMgcGF0Y2gsIEkgYW0gaGFwcHkgd2l0aCBib3RoIHdheXMuDQoNCnlvdSBjYW4gYWRkIG15
DQoNClJldmlld2VkLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5j
b20+DQoNClRoYW5rcyAhDQpFdWdlbg0KPiANCj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCj4g
DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYyB8IDMgKyst
DQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYyBiL2Ry
aXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMNCj4+IGluZGV4IDRjOTIyZWY2MzRmOGUu
LjkyYTU3Y2YxMGZiYTQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1h
NWQyX2FkYy5jDQo+PiArKysgYi9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+
PiBAQCAtMTU4Niw3ICsxNTg2LDggQEAgc3RhdGljIGludCBhdDkxX2FkY19yZWFkX2luZm9fcmF3
KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+PiAgICAgICAgICAgICAgICAqdmFsID0gc3Qt
PmNvbnZlcnNpb25fdmFsdWU7DQo+PiAgICAgICAgICAgICAgICByZXQgPSBhdDkxX2FkY19hZGp1
c3RfdmFsX29zcihzdCwgdmFsKTsNCj4+ICAgICAgICAgICAgICAgIGlmIChjaGFuLT5zY2FuX3R5
cGUuc2lnbiA9PSAncycpDQo+PiAtICAgICAgICAgICAgICAgICAgICAgKnZhbCA9IHNpZ25fZXh0
ZW5kMzIoKnZhbCwgMTEpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICp2YWwgPSBzaWduX2V4
dGVuZDMyKCp2YWwsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY2hhbi0+c2Nhbl90eXBlLnJlYWxiaXRzIC0gMSk7DQo+PiAgICAgICAgICAgICAgICBzdC0+
Y29udmVyc2lvbl9kb25lID0gZmFsc2U7DQo+PiAgICAgICAgfQ0KPj4NCj4gDQoNCg==
