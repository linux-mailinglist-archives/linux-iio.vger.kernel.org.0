Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15A144AB18
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 11:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhKIKEN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 05:04:13 -0500
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:28225
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229845AbhKIKEM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 9 Nov 2021 05:04:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkYEdxHO2Wu8+zvgrERTcWQs4Xt52eN5e1pz6QtiooEbMb2mDqrlQGSyISZpPdo6xDbxRV9ZQGpdpIOdl8ngQTXeewvznXy05tJ2GKWFjZD3fLv5niskOMseHcO9j/YnIA6wRLahyfzK16eH1XYm/2tYb0jM5H84s9KmCaV0d+Wx3dDR3/KstwLIivEJcPePekQZKcbGIFy191uTjo0bmHnXuLJes5bK9wK3I8iPTFxzZWGAt7G6yRDfD+hvXKJqdjN5in4KJ2u4EhoDpmzdqkD7eLwnlqwLx5ZQdSnlZdyTixM/4nRUXq2fz/yoUVKfTp2MmChCljBrs3AWorouyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZMXEkn9eJ6sftegG1+l6m0M8cd300kxq5P/v5l2Jjc=;
 b=oeWtvbV/8uBysUrFh7zt+EqdLVXEIXYCJw9FxayXUv3NjL5dTG8m423FA0YZKOQIJRaSSCqdGpvcpqsmgNdQFYdNVHqbXD1ncRGRObmbvvYxVmImY2dWrCTBpjxcswHL3J253og8pOm4J3KCnpupiEsWDty3NStYvq6ndRdTF2sMrwyhqQ2yrJNZ2YKV9WcxZufZfyNbNGGpwwAyEHdbPods8mn6fVqWv0iMsxGLilex2G2UbURcgtkLGsxZ+LweaNKpjaT23QgsLDK5MG2+CNO95OaYOlEuX67ZcGtimbQ6kwV1p6f2HAbxAv8cABG6DjZ48TCzi6xwwtZAwY8jhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZMXEkn9eJ6sftegG1+l6m0M8cd300kxq5P/v5l2Jjc=;
 b=sKx7weBAdtqIJKvyINunPbecdLBmGaHFMEWIaS+u2O7/i3O1fr15x7vnuTCEuNQElno08AMpwLxG3ituLpzNZldIcJd6a5uQAXy47enyGb2JYOOttFfh3SOYOX8um4btnZOKXz6xfPjN9Og6YaQnk5iB+8pChKdZzdIHnxiA2+k=
Received: from DM6PR02MB6923.namprd02.prod.outlook.com (2603:10b6:5:25e::8) by
 DM8PR02MB8137.namprd02.prod.outlook.com (2603:10b6:8:1a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15; Tue, 9 Nov 2021 10:01:25 +0000
Received: from DM6PR02MB6923.namprd02.prod.outlook.com
 ([fe80::88ca:b598:cc07:bd0c]) by DM6PR02MB6923.namprd02.prod.outlook.com
 ([fe80::88ca:b598:cc07:bd0c%3]) with mapi id 15.20.4690.015; Tue, 9 Nov 2021
 10:01:25 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v8 2/4] iio: adc: Add Xilinx AMS driver
Thread-Topic: [PATCH v8 2/4] iio: adc: Add Xilinx AMS driver
Thread-Index: AQHX1ORlUCJOSLcFoUKx28Qs+DOPj6v6PaIAgAC5whA=
Date:   Tue, 9 Nov 2021 10:01:25 +0000
Message-ID: <DM6PR02MB6923340A37113D2A5B801A83A9929@DM6PR02MB6923.namprd02.prod.outlook.com>
References: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
 <20211108210509.29870-3-anand.ashok.dumbre@xilinx.com>
 <f81d00b2-8df1-8866-da4e-bedba13c34a2@infradead.org>
In-Reply-To: <f81d00b2-8df1-8866-da4e-bedba13c34a2@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecb57837-1fb4-4d1a-2983-08d9a367e443
x-ms-traffictypediagnostic: DM8PR02MB8137:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM8PR02MB813758B17D9130EFEEF3805BA9929@DM8PR02MB8137.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KiwIZz0TQYXg6xX4CzbYnluBuBrMkDdOCKK7aG2spi0blwv/8j2MdmHMhmPjZn/YVlnNzCE2dz8S6UWA//k6PyFrKvUAFrg11jr7mO0WsYtjG4hm/s8QTjI5MkDybQX2FxxOWzz+dnD93xb+SMITc6LMd4TQCe2yHxg1yfKWoLTpk/p/927nMf+DuIjSVO4Sm4SNm7GVYgR62YrgBnlYRTGbo+bB1AcnFeAS++fVXFAdD+tBzh3eayMAy3hxt6qgO6zNgM0zxeZvtCva3pTEUkUgeuA3fzHZlWG8uHGSrTjAidovDxeEwP8AC5pQaVzhMamN1GKfvXkALlGmV7o+wF2mbl+2iTXvTsPyyVvT704E4SqajiBEmh7I2souawFQbn6kmlQrYAbSNQnvkO1rv8vyie8Jhs1F3pzDsaapcXBOPvNF8JJ3alSrypFBX+dbKRtiCLwCau1U8yk9MsxPLW4to86mG6gH7jnlufeNVkRIbZn1Pus2ArqT4dk7oVO8/ta+/XYYiyZbBQ/Zgsk4xD2dDt5TQMIJ7oDznHiLSSjaDUvUXbAaTZZItqeuaskf+Zji+y4t4L/eyo199vNjpC/qOYNBNRu2wKeG9qUBR8ogmiuTk2wo8sI0Jo5xPdpwUZ8L7Ni8FFB56X9CU9w2NKUrqmnSzNillJ2gDT6MIGBfUoiax9plRbMTllSHrxT80tyGzOsAV6uxJ/16OGQ7rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6923.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(122000001)(55016002)(38070700005)(86362001)(316002)(53546011)(186003)(64756008)(66946007)(110136005)(66446008)(66556008)(71200400001)(6506007)(66476007)(76116006)(2906002)(26005)(33656002)(7696005)(508600001)(8936002)(4744005)(107886003)(8676002)(9686003)(4326008)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZThsV084ODUreHlKd1JhRi9RMnh5VGRpWXZiOWcrWFg5ZjVicjYwWWhVOXVG?=
 =?utf-8?B?aGJwTUV4RVppTkQ0TGdveElxV005UGxXeVM3ZytxcTF5NFYzcGJJbEpYclM5?=
 =?utf-8?B?dy9HWVpCL1o3Z2NhV09UZFpMbW5uckhGNGpRZUYzdEFSTnNvR0tUNUpYS2do?=
 =?utf-8?B?d1VTTG9RQlVDVTYzVmN4OXZFTFhlR1B4SUVlcWVwZ3FMRFN4ZHhnSHdxMGRv?=
 =?utf-8?B?SHl1REF5eUNIUDdnQzRmYlBqK2lrdGVoYnBGZDVnRSt6ckx6SVdjaG5mVG1L?=
 =?utf-8?B?U01DaVltQVN0OWVoSUh3L1FUQzVhWmFqUUtXcG8rQUtoQnZ3Zmp6TXlTUFNM?=
 =?utf-8?B?OGR0cWpzZVI0R3RBbHdqVUw5elBvY3BVcGN3SWpoQXlMV05nSzZlNGlGWXJn?=
 =?utf-8?B?VlVwQ0d5WlF6ZHZZVHVUUzNqVlRLbE1TSHJheG9zbmtJVHRuS3cvY2xPZTlT?=
 =?utf-8?B?Rnc5MkFQeDVoMjViajRQS3RGTHc4NWdPR1dFQ1ZiYXhQVmlKY2xlNW5SSGM0?=
 =?utf-8?B?a0JpcW83ODd2RUVPd2hYMW5ablNzNFVZa3FOcE5TVGpwN1hPTS9vLzY0UUZW?=
 =?utf-8?B?Zm5SakM1bFUxY3lweUd1R3NpYzZFd2hsRUEyZ213NHVWclZ1dHpSVEgzYTFo?=
 =?utf-8?B?b2dSc2xmZ2dqTTBhY3F1RVBEK1gyWWs1bDFhU1l4N2QwcUZybHp5UHdSSnVz?=
 =?utf-8?B?MldwZFNtVStENFl2NGFBdElmZVhiWUhveWNtQ0llNVQwUXhKVEgvYm1nTCtK?=
 =?utf-8?B?Rmo5VWxWRGlLbkg4a3R5SkFwZEdGLzU5M1VGdUU0aFJqbXc0Q1dyNTU2Y0pK?=
 =?utf-8?B?QWtYOUVQN1JGQlV2NWpLQ21VSlhmM0R6QkpSYzdoTUM2R2tkVUgwcG9ZaWpP?=
 =?utf-8?B?WHYrMm16aUdiL2gyT285cCtjZytIM2RucmFLejl5cERhcWFlQjNtRzhLR0xn?=
 =?utf-8?B?aVZCSWdidWlVTzVXMXIvbjA3aWxCdXpCbG1ZQXhQYmg5cUx1Q2x2THNQWjFZ?=
 =?utf-8?B?TUtLRTQybEtVZmhUZFRrRXB1ZFVJU1p3REh3MnBYT0JOOVJIRzVLbnRpSVhL?=
 =?utf-8?B?dVhOV1JOSlVQQXN5SnhaTUV3UC9FWnZVeDNRMjZ4eVI4V3YxcTlFVm11cC9W?=
 =?utf-8?B?VHpIVjM0MjAyWFNON3RtSVFHcWwrT1J4NlZBQzA2MFROYUxXR0ZPYW9vWjZV?=
 =?utf-8?B?cjUvZmI5SmVuZW9hd2FFamhwemhXSXVRMDFOS3FaSGlCNC83VDVhc0xaTGtk?=
 =?utf-8?B?TEI1UHVCTXc5YTdwMjNDTEFNZXZDWkdFdWtTRWEreldwSVZXVTlNb3NlWWhO?=
 =?utf-8?B?RXkvRkg2NFBQalFuS0YrdnlvSDJjQVN5OGNOSjc1Y3hYb0YyU1VGZzJmTDJn?=
 =?utf-8?B?WU8yTUNwcmR5UUtjcEVvSHBuNkpnNUwyckxSbkp4bDV6a29XYWNtOVd6S2p6?=
 =?utf-8?B?YzBqOWNhd0xlaTRRcHZFMTlGWjIrelN6cXJmOEV4UGNPZm1TQnlvNUNuQXNr?=
 =?utf-8?B?NUJoM1VTWWliangvVGY2RktQWDY2aURnSmRQc2taNHBPWEZrYjdQTVhUajBD?=
 =?utf-8?B?enJqUU8xbGM3N1BtcWphV1dyK1UweUNLWGhFd2RUcmhQMDUyNG1EWUJHTEFX?=
 =?utf-8?B?OHhER0ZOTjM0aHoyc2g0dVNkbkNDZ00ybjRmb1U2eHNGQVZmcXFnd0x2V25E?=
 =?utf-8?B?NlV6Ym5adnhzQ1N2WUVuS1BvdGs1WDBISmlJZGd0eTBnbkFnWWttRFRhYzU0?=
 =?utf-8?B?b3kzTHQxYWFYLzNZai9IK1FwTzhrOW92WFo5QWVUUFZ6enJUUFVLbzdxOVdX?=
 =?utf-8?B?OSs2OWZXSFdwVWNCY1ZVSnp4R1JjU1BEYkJoalAzMnU3MVUyUTBqd29iTFRV?=
 =?utf-8?B?UU9VMGJpZVd5R2tleVRRaEw4eDZvOHlWMkVHL3RZZjI4Qjg2a1F1Q1ZMVWRM?=
 =?utf-8?B?L0c5WlZZVHNPY3U2K2V4Z01YZGxMRi9yU1pjbDhTZUZ3NmppRjJzSUtXR3Ux?=
 =?utf-8?B?ZTJ0dDVqSGxkKzRMM0lWODFzQ3hheEtjdTZpd2I2Y0xXbTdiS3BHZGZtY0RN?=
 =?utf-8?B?SGZCRGdRRkluelh5emJVR2FUTXk0L0JQZTd2cnM4S2ZzeFF0R2t5S0lkMFli?=
 =?utf-8?B?cTB1eG9yUE5xc0d5VTR1NFRVTTVSWVhXSXdxdWdYZVhoYnZnZjBHbWt1YnRH?=
 =?utf-8?Q?by8itobh2dwxyQQ6RCv0Ce4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6923.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb57837-1fb4-4d1a-2983-08d9a367e443
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 10:01:25.0984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pM+36xoacC7bpNrR0h1Ulwo3y5gJbudZTi2VpSKeLabwic2x55u9nTRw9W4WHxlLMHmWaAod0XZQ1VFlVAjIUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8137
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgUmFuZHksDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nLiANCg0KPiBPbiAxMS84LzIxIDE6MDUg
UE0sIEFuYW5kIEFzaG9rIER1bWJyZSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
aW8vYWRjL0tjb25maWcgYi9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZyBpbmRleA0KPiA+IGFmMTY4
ZTFjOWZkYi4uNmQ3MTFmNDAxMzI2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9L
Y29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL0tjb25maWcNCj4gPiBAQCAtMTI3OCw0
ICsxMjc4LDE5IEBAIGNvbmZpZyBYSUxJTlhfWEFEQw0KPiA+ICAgCSAgVGhlIGRyaXZlciBjYW4g
YWxzbyBiZSBidWlsZCBhcyBhIG1vZHVsZS4gSWYgc28sIHRoZSBtb2R1bGUgd2lsbCBiZQ0KPiBj
YWxsZWQNCj4gPiAgIAkgIHhpbGlueC14YWRjLg0KPiA+DQo+ID4gK2NvbmZpZyBYSUxJTlhfQU1T
DQo+ID4gKwl0cmlzdGF0ZSAiWGlsaW54IEFNUyBkcml2ZXIiDQo+ID4gKwlkZXBlbmRzIG9uIEFS
Q0hfWllOUU1QIHx8IENPTVBJTEVfVEVTVA0KPiA+ICsJZGVwZW5kcyBvbiBIQVNfSU9NRU0NCj4g
PiArCWhlbHANCj4gPiArCSAgU2F5IHllcyBoZXJlIHRvIGhhdmUgc3VwcG9ydCBmb3IgdGhlIFhp
bGlueCBBTVMgZm9yDQo+IFVsdHJhc2NhbGUvVWx0cmFzY2FsZSsNCj4gPiArCSAgU3lzdGVtIE1v
bml0b3IuIFdpdGggdGhpcyB5b3UgY2FuIG1lYXN1cmUgYW5kIG1vbml0b3IgdGhlDQo+IFZvbHRh
Z2VzIGFuZA0KPiA+ICsgICAgICAgICAgVGVtcGVyYXR1cmUgdmFsdWVzIG9uIHRoZSBTT0MuDQo+
IA0KPiBUaGF0IGxhc3QgbGluZSBhYm92ZSBzaG91bGQgYmUgaW5kZW50ZWQgd2l0aCBvbmUgdGFi
ICsgMiBzcGFjZXMgaW5zdGVhZCBvZiBhbGwNCj4gc3BhY2VzLg0KPiANCg0KQWggY3JhcCEgV2ls
bCBmaXggaXQgaW4gdGhlIG5leHQgc2VyaWVzLg0KDQo+IC0tDQo+IH5SYW5keQ0KDQpUaGFua3Ms
DQpBbmFuZCANCg==
