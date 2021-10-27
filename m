Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9D743C68B
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 11:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhJ0Jhj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 05:37:39 -0400
Received: from mail-bn8nam11on2057.outbound.protection.outlook.com ([40.107.236.57]:3808
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241126AbhJ0Jhi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Oct 2021 05:37:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf6pqOpisjt8A9MN/6J5nP+a5C6HOd1DTRYzUFEniMQEA0ckKjcylI/go3iDnJ9h+zQROSUW9w/gSfRV0Rfy5zJLWjXkGqYqy7Ra2h2zVrUTVYg0CyMU0jfPa1+2eMXOzeHntlZBMzyYul9YDixHQPFkc0KOWIWGC7SjHBHsp1XAFY0ltBzMK6a4frqSLAa4OLLgIfE3R1OAYlSD3X2NLyJu37S9dzkHOgknDTBnqSxwD8ej3eQVrQFC2DR99PefJ9c/SHy4cTqjB4dc0ksQuC8s1m7xova4YC6IaErRADIgwmo42WdOz0SaUf/zSDmMiLioUImAzs6+5ECA0VXySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEbbiZpYyMO1bTZAl+rXUaA80+xKhzcWYz4X+cEU/iI=;
 b=RJB9HNxWSkB34TQoWJzaPBzzhXTwIuX/RhFN73xA+h3FtPi0iJNuOHv1HTcp+VKSTQMPwFCTMCw/MsNQoGVAB8EDOayI52aSORcteqmATA8imqcor2lmr15+sx8/qdaYG4rVxcuBnHa9+Mj5+lziyD78sPKT/68c702PryzkAtjTPcR01HwsaUiMFDVhurT/T9v/P+hbbpwGylY3UMR4jD5rHGdP6NqyTsHnllH3dGl7T2yH/qwO3K3amBBJOwBA5tyDZGVDTUwneaKx+QelVUBKTL9Fu6HMnxxLpSViFj7+6fHI/hPL/Ax4lfGd1MwZj+nK99xCWBHdS8CGPpI9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEbbiZpYyMO1bTZAl+rXUaA80+xKhzcWYz4X+cEU/iI=;
 b=hFQpKfA1gKQ7nar69Ew5D+sjYqvjKkTGlI6hCcln+SwcGcjktJ+paSyiTFRMjZM8C2DmtgVY26/8gjexySuMc3iEP33x63V9rdU7IuiZ6AVSzYyZkw81J8rN6LOpPM8+DFxYU5H3R5pA5vn1jP2ucWKjiWWoYSWZwaRqZYLdRgk=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BY5PR02MB6501.namprd02.prod.outlook.com (2603:10b6:a03:1d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 09:35:07 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 09:35:07 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v7 2/4] iio: adc: Add Xilinx AMS driver
Thread-Topic: [PATCH v7 2/4] iio: adc: Add Xilinx AMS driver
Thread-Index: AQHXxPztLE/r+aVUT0W7KtDOJosftqvjuLIAgALg45A=
Date:   Wed, 27 Oct 2021 09:35:07 +0000
Message-ID: <BY5PR02MB69160E6008452AABA759E670A9859@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
 <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
 <caaa19ef-131c-ad5c-1403-ff948de9f200@metafoo.de>
In-Reply-To: <caaa19ef-131c-ad5c-1403-ff948de9f200@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06569b8b-6577-4cb5-4842-08d9992d104c
x-ms-traffictypediagnostic: BY5PR02MB6501:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BY5PR02MB65019744081E916521B39AE1A9859@BY5PR02MB6501.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23RBhccGEW9NzHfDa9hzl9cPu/sNrS8dB4hv26Ma63NCvan3XQe/q6rYdEjINLQNgOL9GpsMohq/obsq99nYa7wJlC4CZcJMXquc/gpPEZnRQBYRQcmoJClCAKgqfBfSMla07WvBaZZN6nj8nLTjzYeSvGw3UAZvxAscOGPYDGDLDsxyPNVIQ1SAnrm+wWEeXVZyojfmJWxWvhmIOF4ZaIuYMMm0vxY0ryw2sWkF5TfHoaFhcSlQxZWl5wbdtSMU61AwCEOxrED4D2mSrvlmcEX8CzmQFoEgAz7zb5TC15R0/9XkvyQvYv1iUhbwwJQpNU62EF/NVhbJaHEZyc8KSQoCHk0GNj67meMqU2XjFSg1qRZ+fYy+DiGPolYa8I+QZ8S1lle+ScZbDbfYBOxRX2GWkp3CSBBoUZk+nzAPSLTSeMoiEoJX8aflFRKeEWQLGturZmfM1NXSmhZUtO78x7y+Dd3OAO3mFJOCkdheWKq/xvBN8OAmqsv7v10zF4rGltuqcIq3HN35Jr345SzGtVrp6MQiLBp/HPyZf9X1jxdgFrTafYis2ItXr6bNcC0PcHa9okHKpLg4TVHK/6LnghHWQDXXe83D4MlTuwCyH1IaHhBwGGmioUk3Ww2/Cji8amP6miyr/oR5ZZNv2x9MqYVoOZXyIHvmmPiEUe9b8zbKJch6ib9To+ODtlrT4dTIFZWcJxBr67MDXhubgwqrJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52536014)(6506007)(83380400001)(53546011)(33656002)(55016002)(508600001)(7696005)(2906002)(8936002)(8676002)(4326008)(5660300002)(110136005)(316002)(186003)(38070700005)(66446008)(107886003)(76116006)(64756008)(9686003)(66476007)(66946007)(122000001)(86362001)(38100700002)(26005)(71200400001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEhzYVNZN09QSGhNTUw5ajFoYzRRWTUvK0RISU5jVjZqWllwN3NHQXRPNlU3?=
 =?utf-8?B?V2RRT3dISWxQME5Id2J6QStSWllNRG80RENvdk54YmJVVTBpWEVDRVJkTGZQ?=
 =?utf-8?B?N0JpZ09Lb3hkYUdsTStpWVlnN0Z0WE90RzhhNjhaMkxLNnR2R1R6cERZUnpu?=
 =?utf-8?B?b01OOGhKMmcyNTNvS2xoZkNjWEUxaENXQ25UN2dGMk5zSEV2NzN4ZmxQajFU?=
 =?utf-8?B?VEtxekt5SWRqM3h2R3ZOTUFWSEFIcVJlbTFsUVNzSDIxSElPdElMNHhFYXY1?=
 =?utf-8?B?UG8wdnc4RXZ3ckxNYW9jWGFxa1IveWdYOFAwV2MxNFZNNHdWTTNBalh0SVpv?=
 =?utf-8?B?d0VqOGgrOWdrU2dtZnFzTENjcno3U1NTTjhIdWo2dDhuRk5ySld0akx4NEpv?=
 =?utf-8?B?Q0xGL1hxL2JOeldscXZyR0RKSm9oU3lMcjJqSVpHaHI3ZDdMc1F4SWdnSkcy?=
 =?utf-8?B?MXgycXdZeGFTOWdvMWZkYjNXVUxDbTVhRWd0K2xma1FNTGpTbTdiWE5XRGhP?=
 =?utf-8?B?RUZIeWlGWGREdk9qVk9UYWNiVW5FRDl1OGdqM1c1WXJxOE9TcEp1T0wxUHF1?=
 =?utf-8?B?VVkwZnhzRWV1NmlKSEcwU2JVTm12ZVdBU2o3QlRQU2dxVU5STTVuT1VyWlJ4?=
 =?utf-8?B?RkFXL1A5TkFLMzVuS0lHUkVOUGhqd0JCd3NuOHh6a3JEWCthR3V6dVBHTDdp?=
 =?utf-8?B?TDJ5RlNrcGtsdGR4MFgwMzFFU2NWZTNGRkloTDFTRGxjem4wM0ZnSm9PQzkr?=
 =?utf-8?B?ZmZJYTR6VXVkMUpMRmtudDZkUzF4Q0RpTGgrTDVQbGVySmg1ckJic2prNnlo?=
 =?utf-8?B?NWs5cjlNTWl2V2JkZEtNczZFU2JvUkF1K0VFRDR5YitKRGE3ZkZ5YVBWMnVO?=
 =?utf-8?B?SGJJY1BqK1B3U3RzaWxENjc0VFEwajVLOTFjZ1pIMmRXV3ZoKytPcEZMQ1FM?=
 =?utf-8?B?RjJHUDJnWkkxaVAwYitNQlhIckw5WW01cm5HQlliWkpLc1Q0RFZoTDhiZEJV?=
 =?utf-8?B?QmRpRlVDVUkwYXJjYVRFQ01XaU13b3RKS3R5aDA4Uy81Y1FycTZNU3NlWXpq?=
 =?utf-8?B?ekx6b1oxWEQyWmQzZVBSMHBJWnpBa0dvYXNGeWJUUHluSkR6T1d3c0l3VG5p?=
 =?utf-8?B?bjQzMVQwQklsU0Q4UzVJTnVWNGV2STlzMWFiMUZXaFpZMDRBN3QxQW40VnRh?=
 =?utf-8?B?SHZwY3dBSDJOU3d6MGFCcENKd2dvRFJxMjV1QWR0UjFUVFM1YmtBd0xETHZC?=
 =?utf-8?B?dm52d1pjWmJrWi91bjZybDUrVHB1dWY3Ri8yYnRNelpZRGxGVmlUV0RBNzlZ?=
 =?utf-8?B?Y1BvUmEyWVI1K25hcHpYMEkreFpHMzVOK0lBMWw4ZENZSlZrSEpJanJKSmt1?=
 =?utf-8?B?c3cvRmVSZDBJT3k4akNDNC9IdUMxZHVkTjJmYXZkM0wwM0Y0eXdwQXVQMklF?=
 =?utf-8?B?akJSRnFUU3F5a0FQczVwSWRKL2pKOUdOQVRzVENHTFMyR1pOWHhpbTUyOHgr?=
 =?utf-8?B?SzV2TG5lYU9GNGZNaktJQkp4THg0VTdncXVob0h4TWdkVHhLNHRCUFBSYVRF?=
 =?utf-8?B?MEVOT2tYUERUelZOdDM4ZStSSHpIaFFoTGNJZzEwUzRDOHJsTzEyNWQ2cEQ3?=
 =?utf-8?B?M1hWM2lBV0plZU1hekNONmlocnEwR25YRVhoTVZITUZVWm9obXhSMzRueXBK?=
 =?utf-8?B?RGZEWlk1cGU3MDlCRVQwZGhjTWdTREMxbkZOVEhlckl5OVpITDROaUZ4SWNY?=
 =?utf-8?B?YkxQYzliZmdPRFVkQlJhUzh3b2d4UnlCOUE1LzZIMFB1Ujl2RFMwMm1nU2JR?=
 =?utf-8?B?YWtYejduaWUyMkR1NUF3cU1TWDNiWXVuWjU2LzBKemYrYzNjMEhkNk5PS0dI?=
 =?utf-8?B?WGgrVmVZVDBqbFJmL1lBN3lvclVsWjBrakEyalRNMzcvb2NOVEk3SzNkVmFz?=
 =?utf-8?B?bGltazJ3Nk9pdEl2SUlyOEIxOU02aFZGbXV3dXhUYkVBRnBqa3lvc0hCL0VZ?=
 =?utf-8?B?L2NsMUlpbC91eGxIZkVqZEpLRklJdzlkRHFUWlpiODc0b2hxSmFtbGNaNlBI?=
 =?utf-8?B?VW1abzFCYUcxTEVpSElTMFZVa3FqQnhYajdtdVIzMEg2eDVoM0JBdTFiaDF0?=
 =?utf-8?B?UXZzbDRSMXlOZ2JtbngzV3M4ejBaaE5jUVZINnYxNUQ5aTlhc210MUY0aWtK?=
 =?utf-8?Q?ryah27mFPxG0xAfedC6P3ho=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06569b8b-6577-4cb5-4842-08d9992d104c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 09:35:07.4095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSBPZpUjwF9Cff8HEV4skI17rDphg19DbMg3IXDZz3Yoe83EqbHxczd9qlKC+qaFxXGw7xtr+6UsMeRbzRRNWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6501
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgTGFycywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KSSBkaWQgYSBiaXQgb2YgZGlnZ2lu
ZyBhbmQgZm91bmQgdGhlIHJlc3Qgb2YgdGhlIHJldmlldy4NCg0KPiBPbiAxMC8xOS8yMSA1OjIw
IFBNLCBBbmFuZCBBc2hvayBEdW1icmUgd3JvdGU6DQo+ID4gK3N0YXRpYyBpbnQgYW1zX2luaXRf
ZGV2aWNlKHN0cnVjdCBhbXMgKmFtcykgew0KPiA+ICsJdTMyIHJlZzsNCj4gPiArCWludCByZXQ7
DQo+ID4gKw0KPiA+IFsuLi5dDQo+ID4gKwlpZiAoYW1zLT5wbF9iYXNlKSB7DQo+ID4gKwkJd3Jp
dGVsKEFNU19QTF9SRVNFVF9WQUxVRSwgYW1zLT5wbF9iYXNlICsNCj4gQU1TX1ZQX1ZOKTsNCj4g
PiArDQo+ID4gKwkJcmV0ID0gcmVhZGxfcG9sbF90aW1lb3V0KGFtcy0+YmFzZSArIEFNU19QTF9D
U1RTLCByZWcsDQo+ID4gKwkJCQkJIChyZWcgJg0KPiBBTVNfUExfQ1NUU19BQ0NFU1NfTUFTSykg
PT0NCj4gPiArCQkJCQkgQU1TX1BMX0NTVFNfQUNDRVNTX01BU0ssIDAsDQo+ID4gKwkJCQkJIEFN
U19JTklUX1RJTUVPVVRfVVMpOw0KPiANCj4gVGhlIFBMX0NTVFMgcmVnaXN0ZXIgaW5kaWNhdGVz
IHdoZXRoZXIgdGhlIFBMIG1vbml0b3IgY2FuIGJlIGFjY2Vzc2VkDQo+IHRocm91Z2ggdGhlIEFN
Uy4NCj4gDQo+IEJ1dCBoZXJlIHdlIGFjY2VzcyB0aGUgcmVzZXQgcmVnaXN0ZXIgZXZlbiBiZWZv
cmUgdGhlIGNoZWNrLiBJbiBhZGRpdGlvbg0KPiB0aGVyZSBpcyByZWFsbHkgbm8gcG9pbnQgaW4g
cG9sbGluZyB0aGUgcmVnaXN0ZXIgYXMgdGhlIHN0YXRlIHdpbGwgbm90IGNoYW5nZS4gSWYNCj4g
dGhlIFBMIGNhbiBub3QgYmUgYWNjZXNzZWQgdGhpcyBzaG91bGQganVzdCByZXR1cm4uIEFuZCBv
bmx5IGFmdGVyIHZlcmlmeWluZw0KPiB0aGF0IHRoZSBQTCBjYW4gYmUgYWNjZXNzZWQgc2hvdWxk
IHRoZSByZXNldCBiZSBkb25lLg0KDQpJIG1pc3NlZCB0aGlzLiBJIHdpbGwgZml4IHRoaXMgYW5k
IGNoYW5nZSB0aGUgb3JkZXIgb2YgZXhlY3V0aW9uLg0KDQo+IA0KPiA+ICsJCWlmIChyZXQpDQo+
ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJCS8qIHB1dCBzeXNtb24gaW4gYSBkZWZh
dWx0IHN0YXRlICovDQo+ID4gKwkJYW1zX3BsX3VwZGF0ZV9yZWcoYW1zLCBBTVNfUkVHX0NPTkZJ
RzEsDQo+IEFNU19DT05GMV9TRVFfTUFTSywNCj4gPiArCQkJCSAgQU1TX0NPTkYxX1NFUV9ERUZB
VUxUKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlbLi4uXQ0KPiA+ICsNCj4gPiArCXJldHVybiAw
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgYW1zX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiBbLi5dDQo+ID4gKw0KPiA+ICsJcmV0ID0gYW1z
X2luaXRfZGV2aWNlKGFtcyk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2VycigmcGRl
di0+ZGV2LCAiZmFpbGVkIHRvIGluaXRpYWxpemUgQU1TXG4iKTsNCj4gPiArCQlyZXR1cm4gcmV0
Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldCA9IGFtc19wYXJzZV9kdChpbmRpb19kZXYsIHBk
ZXYpOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWx1
cmUgaW4gcGFyc2luZyBEVFxuIik7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiAr
DQo+IFRoZXNlIHR3byBuZWVkIHRvIGJlIGNhbGxlZCB0aGUgb3RoZXIgd2F5IGFyb3VuZC4gYW1z
X2luaXRfZGV2aWNlKCkgd2FudHMNCj4gdG8gYWNjZXNzIHRoZSBJTyByZWdpc3RlcnMsIGJ1dCB0
aGV5IGFyZSBvbmx5IG1hcHBlZCBpbiBhbXNfcGFyc2VfZHQoKS4NCg0KVGhhdCBpcyBjb3JyZWN0
LiBJIHdpbGwgZml4IHRoaXMgYXMgd2VsbC4NCg0KVGhhbmtzLA0KQW5hbmQNCg==
