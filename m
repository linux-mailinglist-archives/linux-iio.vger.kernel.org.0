Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21ACC458357
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 13:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhKUMdJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 07:33:09 -0500
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:4696
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237951AbhKUMdI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 07:33:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLtLgb9UFlcj/Mog2MMNpZKUcqosvNf2SWb3CVfBHrWqBxjgMQ7BlhMq+GNSqM7ZjVctmnDpEUm0Qx6GQWHkH3u/77O9ea2Vkt6HjmIOlJpqQ3ae0YKQdDF+Ln2E0v7LEvRLm5duhBlHUsWB5+hWk0TZxA3M49knIzYUDwthCYQ5xYyBtUbt3rIYpmi1yNI5E8irjmqr1NRIdDUAp5Pu03crRL/yuYIdbb2gDnjxrLigS8dOTqELjMTVjVUgN0+bpjlYxVsnP2XCyUmLSw66IPPGSV6NEA2AL5qtc0De+vhlf+WsW5rsfEgUcL6J/tND8OGfu0khnDQZuOtf1zK44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKstG1MbJbM00i53uKPovvZYLs70uy1ghqLsY6LNZmE=;
 b=WQ7wJ4j41UOiRdQwQj+xr3FyC0WeJ5d1zOVVaMBnKsSEkcr5zEK6tXg7rRWPWjvtmshJuHUMufQtRvAGxpLHX1Oynn+wBRjzhAzk6DASjedd8Uy3BrF+zFEAgASZhBPD/kmIXU0im3Y8H3wLi/11E7jFySlRc8lTvkabmajcwyGlEscAubPihOBpVN/IhscUn8YWC+Dj3Z9OXJFB2TrfiDN2Yacv1/sLruT/chmx1gQfttsz0nP0Kn+Y1GZKIj2ALEcpDnTtrp0vBdhJiIbyMZTp743U1VYCpiCgPcTRu6BGQ6rynkWjrfHk9p7wkc7M32HOVoS2Nl20PMnyMgbeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKstG1MbJbM00i53uKPovvZYLs70uy1ghqLsY6LNZmE=;
 b=dB6iaAybkjGhawVN4ZK+nh6Ey5webSGBzlkxCHLXy/e1GEuJyPe1UJgvMrHz4IS70E8/yGVUOmqCCWoDgmGkjj3fQtrvMNDRJu6vxbrMhqHOvkuxukDtFdTBs7W8f3XMavIS0ajcDNhs83ABhUa/rqZzB8ZECIQ6VgTYPiHV/Ag=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by SJ0PR02MB7664.namprd02.prod.outlook.com (2603:10b6:a03:323::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Sun, 21 Nov
 2021 12:29:59 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%8]) with mapi id 15.20.4713.024; Sun, 21 Nov 2021
 12:29:59 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v10 3/5] iio: adc: Add Xilinx AMS driver
Thread-Topic: [PATCH v10 3/5] iio: adc: Add Xilinx AMS driver
Thread-Index: AQHX282sZu1pJFP81EiVfi9bN2U8cqwIJKiAgAD1PdCAAFRLgIAEce9w
Date:   Sun, 21 Nov 2021 12:29:59 +0000
Message-ID: <BY5PR02MB6916F55748F4237679E62BADA99E9@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
 <20211117161028.11775-4-anand.ashok.dumbre@xilinx.com>
 <YZVf+Y/KxASvT2MU@smile.fi.intel.com>
 <BY5PR02MB6916A1C867FCD6C289E894A2A99B9@BY5PR02MB6916.namprd02.prod.outlook.com>
 <YZZ0Z++xlAjBbRtI@smile.fi.intel.com>
In-Reply-To: <YZZ0Z++xlAjBbRtI@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 936ddf19-5be6-4934-7f38-08d9aceaa231
x-ms-traffictypediagnostic: SJ0PR02MB7664:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB76647549350DC5AB67BA0009A99E9@SJ0PR02MB7664.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HJvJQABxNWD8Bf8tNcII5xhiGDHiIELo13pshlvLxIfPHtkbifW6Bzeec9oQ3GSgvMd0bOmgynmXq7G0hnU5EUAr7HnE5gDbcybV5t3inYlrHRT+gPOOG3eGo3tFDQ3XvqOqRs/ZN1IqS5sR8kcm76qCCwYAqzZ4v8laHCcXBy3p4ge1rs74RpP04V7/M7M4SqqBIBpf4UNNTTMvw/ukd3u7lLxo5YFSzlhqEnIwXhYbUVPW2bAnM0/UK80Nlwhm+fNjB3TahzMFgiwr5g5Qp7jZI/QDohgsqo6ph3i3yHqru5uT8ZmQT9zgGuBQ9NFogZgwt1AlxB2IXwb45p4PW2qVyYgd64aj8HPKsjOD3LjlZ9zZp9rvX6rvwjX9GXO27dH7eli2eBg3I1JMh9/TU6aS6zbX1Rh/4jtodNdsj8wWK07fbk117T74xUdU0O2PvgI76kRqZrTDSpjKyB2fI+LPQiD8rXIJng83qB/XlgefUvwhFRtj0FTN9XsvZXNSta5FI4iNOkq+lQZrnXPniOVd77/cS/BWrfyqvRDaRSdYYdcW0Z+PYxIiWhh7BGH4wSmi2pMsBjf3oEBrV+TwvKQ4Zhy+YNiVfM3kaXTEvkinKplwcNBySxt8BJ6TbJqZYZu87FtLjxSKa8GwcJ+aRMXnL2eoaG4qLBdZVgTV+igOOoBYcJIm4fbG9+R0Y2epyjMcNxR8MXiNDOfFtxhEzHFLxxdAikP8il/bN0waz4CQqiGuDa2bT7xppeCHFhIgegPHGsKViFlGNmGSX5DuG/171TmdK0Azz86npuiorb8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(8936002)(5660300002)(4326008)(6916009)(38100700002)(7696005)(83380400001)(26005)(316002)(71200400001)(2906002)(66946007)(76116006)(107886003)(86362001)(8676002)(33656002)(508600001)(55016002)(7416002)(38070700005)(122000001)(54906003)(6506007)(66476007)(66556008)(9686003)(64756008)(66446008)(52536014)(53546011)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnNTcEpWOWNrS0pIVkxvazVGcUJSenE4dWtLLzQvanhzdEZlL2lVRGd2VzdJ?=
 =?utf-8?B?SVFjZkhxRXQ1ZCtQcVJJUjAvSTdIN0xVRzhoWHFuVnJsMFFWNHZvRVFxcHhk?=
 =?utf-8?B?Zk5IZ1ltTGVVQ2ZFQjcrcmlGWHJZMFBERDhkWWptL3R3WmIwa2RvbHczR095?=
 =?utf-8?B?cnU5Y2FGblRLQWRuMXhJTU5hRTM0aEgrMjFsZTlwRlR6bVNRQUpKbzRZMmRs?=
 =?utf-8?B?RlFKSUtLcDJIcXpxUW9VRkhrNGpTSnFmWTlCWjcwVENIVDdRSnR2OW9iK1Ny?=
 =?utf-8?B?RUhXSG92MDcvKzEzM3V5Y1VnZnRLdm5MZ2xyclVaK1BZLzRpbWthVE95UXJG?=
 =?utf-8?B?bkNMTXNjN05rTDhTKy9PK3JrakZJYmxMeE9XbDNkUGc3aVZQQmxoSjhFTmxr?=
 =?utf-8?B?aUdRTWlhZkVxRmYwaEhKUzE5VG96RXZVcDVkRFNlc1RPMnN5VkJ0S1VaR0dq?=
 =?utf-8?B?c3ZKZmRXLzk2a0o0VWwyQjMxK3Z1dEdHSGd2UHB5c2M2cEt0WWs2MEM5NUQz?=
 =?utf-8?B?YXIwMWVyVVJvN3NNVlpyb1RBTXBaMnQ3TktJaytNc3Q2Mzhzem5HZXRwNUcx?=
 =?utf-8?B?YW9SOEdMSUVNOXVNSm5JdGRvS1hScXFXWmVYbWc3UklGdFVXdVhIUlBPWHJS?=
 =?utf-8?B?RkJyS1lvZjl1NzNRSHNoUGlpRTBOZWlZRXp6bnl2RnlqY3F1NUp6TmFGeGVM?=
 =?utf-8?B?WmxZVmJ6VjRwSFY0UVFpcHVpMnV5UjdLWEw4RHI3Rklod0dZbzRjb0U3N0Nw?=
 =?utf-8?B?NHJtRzJBelZpVVRWeHFEcGgzamIwenVuUDJyWVB2UHJLb1FmNEFWcXJUclNx?=
 =?utf-8?B?b3U4N0U5Lzd6Q1FoY1dacllPdmtScVZBZjdCUTRaNm14TTRoOVNxQ0kvdU5J?=
 =?utf-8?B?aWkyK3dtRW4xOHNlVkJya090akhVMEttbTY4WXU3MndrZ0taUSt3cCtnWU9Q?=
 =?utf-8?B?aUdrQ3Bucm80dVJ4aG1mRmp6T2xWQklnTU1LRThRNEFEK1ZEUUJ1ZjZvamxT?=
 =?utf-8?B?RFI1MThjN2daZ1NuZEJlRUE3SE50dm9UVGpMNzRMaXE1S3lRSFZzR2ZJT3Fq?=
 =?utf-8?B?NnN3TjhLZkkyZjVlK2VDbVhvNmR2MUEybmVsTXZ6Tk9LanNQT3YvblJDbmcv?=
 =?utf-8?B?ampMSVdib2NRUkp4SEozSkVhNkJSK3F6V0Y3OTRsS3duRGZmOG0wTHlmOGlX?=
 =?utf-8?B?dzI4L3lyM1BTSXhjRk54QldQMlVrckJYdjh3SG5yQjNlNjdLWUpLcVJoUFNQ?=
 =?utf-8?B?Zk5FUEtJNWE5YnRkTWtPY1FNVm9JaGE0VElUQTB3SVQySi96SnVzZ3R6bTBF?=
 =?utf-8?B?UjFCb3NCM0FuWE1NaFE0WGVxK1hDbmg4YzMzUmNHZ0ZucnlGeUN2UzRRTFpQ?=
 =?utf-8?B?d3lNd0locCtjY0xKd3ZoeFBtY0hqVGNmd1h2TzZkYS9KbkppcHN2OWZ5ZXcx?=
 =?utf-8?B?QjVERjBaR0VkWHhHcnJHSC9XVVAxejBwb2dHVWJLUUdZT1h6cmtWUzczNFZh?=
 =?utf-8?B?T253T2MrR1dwT28zSTJZMWpEWXdQcHBscnliQnYreEVDTElJdUFvalh0dWt4?=
 =?utf-8?B?ZmYzZzlscm9UaUdiOGQ5WDMycC9TYkkxRWJseCt0MmhRWGxWLzhCcVhWUFpB?=
 =?utf-8?B?UnRqdisvRy9KOVZoN2NUV2JUNm9SUE80NlIvWTZxS2h5WnVyMUlwMjZwUHNy?=
 =?utf-8?B?NFN4TURlOXZFSm1aWDJFTHdCdlA2bWZSNXlIeGxqYklNbmVRZjJ3UzY0RTFF?=
 =?utf-8?B?eTUwY1BJVXF4RktHSmovWUkwODY5NnNOcUoyN0trSTR0dnNuQWloblRjQnIz?=
 =?utf-8?B?eklLbDQ2dkF2YkVPSllQM2p1cmVjZ0FjZ2dUa0hwNVIzU21KcjJHVU9qVGxV?=
 =?utf-8?B?NGM5b29obktYc1pGVk1rcmlLVlNwMzN3ZHFTMnRHU3hUUDlVMWJIOWRWWkZu?=
 =?utf-8?B?a1Jjd3hSY1pnaUNITjJHT0dxN2tTQmdVZ3lHR0pZdE5laWRYOEZ5VUNZd3pk?=
 =?utf-8?B?U1RhanpUaW93S201SWp6OVpQMkw5MExnSjdrdkliM3gweE81VjdUMWZITnJh?=
 =?utf-8?B?OUF6S1VVemxpWUdaV3ZCZWkyaGQwK01OT0pIZXdPNGNQazBCM2ZGNU11K1V4?=
 =?utf-8?B?bFZJZ3FMRDZOTWV4QlBCVTRGMktNc1NXaUYwRDRKdnVxSWlJQXlvS0pTUUJw?=
 =?utf-8?Q?GrYHKzoOA2csW69VxibGDSc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936ddf19-5be6-4934-7f38-08d9aceaa231
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2021 12:29:59.1480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYTnVLNLv/Ib9Kn4WrA6eRX1pBRD7PQdDYfLwZ6RoA56ItF4eM3xE/7uNSEI/NJgehQFuJYSBGJpeSSa67vwRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7664
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGlu
dXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSAxOCBOb3ZlbWJlciAyMDIxIDM6NDMgUE0N
Cj4gVG86IEFuYW5kIEFzaG9rIER1bWJyZSA8QU5BTkRBU0hAeGlsaW54LmNvbT4NCj4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGppYzIzQGtlcm5lbC5vcmc7IGxhcnNAbWV0YWZv
by5kZTsgbGludXgtDQo+IGlpb0B2Z2VyLmtlcm5lbC5vcmc7IGdpdCA8Z2l0QHhpbGlueC5jb20+
OyBNaWNoYWwgU2ltZWsNCj4gPG1pY2hhbHNAeGlsaW54LmNvbT47IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnOyByYWZhZWxAa2VybmVsLm9yZzsNCj4gbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5v
cmc7IGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRlbC5jb207IE1hbmlzaCBOYXJhbmkNCj4gPE1O
QVJBTklAeGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAgMy81XSBpaW86IGFk
YzogQWRkIFhpbGlueCBBTVMgZHJpdmVyDQo+IA0KPiBPbiBUaHUsIE5vdiAxOCwgMjAyMSBhdCAw
MjoxNDo0MVBNICswMDAwLCBBbmFuZCBBc2hvayBEdW1icmUgd3JvdGU6DQo+ID4gPiBGcm9tOiBB
bmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+
IFNlbnQ6IFdlZG5lc2RheSAxNyBOb3ZlbWJlciAyMDIxIDg6MDMgUE0gT24gV2VkLCBOb3YgMTcs
IDIwMjEgYXQNCj4gPiA+IDA0OjEwOjI2UE0gKzAwMDAsIEFuYW5kIEFzaG9rIER1bWJyZSB3cm90
ZToNCj4gDQo+IC4uLg0KPiANCj4gPiA+ID4gKwkJCXJldCA9IGFtc19yZWFkX3ZjY19yZWcoYW1z
LCBjaGFuLT5hZGRyZXNzLCB2YWwpOw0KPiA+ID4gPiArCQkJaWYgKHJldCkgew0KPiA+ID4gPiAr
CQkJCW11dGV4X3VubG9jaygmYW1zLT5sb2NrKTsNCj4gPiA+ID4gKwkJCQlyZXR1cm4gLUVJTlZB
TDsNCj4gPiA+DQo+ID4gPiBTaGFkb3dlZCBlcnJvciBjb2RlLg0KPiA+DQo+ID4gSSBkb27igJl0
IHVuZGVyc3RhbmQuDQo+IA0KPiBZb3UgZ2V0IGFuIGVycm9yIGNvZGUgaW4gcmV0IHZhcmlhYmxl
LCBidXQgeW91IGFsd2F5cyByZXR1cm4gLUVJTlZBTCwgd2h5Pw0KDQpHb3QgaXQuIFdpbGwgZml4
IGl0Lg0KDQo+IA0KPiA+ID4gPiArCQkJfQ0KPiANCj4gLi4uDQo+IA0KPiA+ID4gZGVmYXVsdDog
Pw0KPiA+DQo+ID4gVGhpcyBpcyBsaW1pdGVkIGJ5IGh3IGJpdHMuDQo+ID4gRm9yIGRlZmF1bHQg
SSB3aWxsIHVzZSB0aGUgZGVmYXVsdCBzY2FuX2luZGV4IHZhbHVlLg0KPiA+IElzIHRoYXQgb2s/
DQo+IA0KPiBJIHRoaW5rIHNvLCB5b3Uga25vdyBoYXJkd2FyZSBiZXR0ZXIsIHlvdSBkZWNpZGUg
d2hhdCB0byBwdXQgdGhlcmUuDQoNCldpbGwgZG8NCg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiAr
CQlpZiAocmV0IHx8IHJlZyA+IChBTVNfUExfTUFYX0VYVF9DSEFOTkVMICsgMzApKQ0KPiA+ID4N
Cj4gPiA+IFRvbyBtYW55IHBhcmVudGhlc2VzLg0KPiA+DQo+ID4gSXMgaXQgYSBnb29kIHByYWN0
aWNlIHRvIG5vdCBoYXZlIHBhcmFudGhlc2VzIGFyb3VuZA0KPiAoQU1TX1BMX01BWF9FWFRfQ0hB
Tk5FTCArIDMwKSA/DQo+IA0KPiBJdCdzIG1pbm9yIHRoaW5nLCB1cCB0byB5b3UuDQo+IA0KPiA+
ID4gPiArCQkJY29udGludWU7DQo+IA0KPiAuLi4NCj4gDQo+ID4gPiA+ICsJZGV2X2NoYW5fc2l6
ZSA9IGFycmF5X3NpemUoKHNpemVfdCludW1fY2hhbm5lbHMsIHNpemVvZihzdHJ1Y3QNCj4gPiA+
IGlpb19jaGFuX3NwZWMpKTsNCj4gPiA+ID4gKwlpZiAoZGV2X2NoYW5fc2l6ZSA9PSBTSVpFX01B
WCkNCj4gPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPg0KPiA+ID4gV2h5IGlzIGl0IG5l
ZWRlZCBub3c/DQoNCkkgZGlkbuKAmXQgc2VlIGtjYWxsb2MgZGlkIGl0IGludGVybmFsbHkuIEkg
d2lsbCByZW1vdmUgaXQuDQoNCj4gPiA+DQo+ID4gPiA+ICsJZGV2X2NoYW5uZWxzID0gZGV2bV9r
Y2FsbG9jKCZwZGV2LT5kZXYsIChzaXplX3QpbnVtX2NoYW5uZWxzLA0KPiA+ID4NCj4gPiA+IFdo
eSBjYXN0aW5nPw0KDQpSZW1vdmVkLg0KDQo+ID4gPg0KPiA+ID4gPiArCQkJCSAgICBzaXplb2Yo
c3RydWN0IGlpb19jaGFuX3NwZWMpLCBHRlBfS0VSTkVMKTsNCj4gPiA+DQo+ID4gPiBzaXplb2Yo
KmRldl9jaGFubmVscykNCj4gPiA+DQo+ID4gPiA+ICsJaWYgKCFkZXZfY2hhbm5lbHMpIHsNCj4g
PiA+ID4gKwkJcmV0ID0gLUVOT01FTTsNCj4gPiA+ID4gKwkJZ290byBmcmVlX21lbTsNCj4gPiA+
ID4gKwl9DQo+ID4gPg0KPiA+ID4gPiArCW1lbWNweShkZXZfY2hhbm5lbHMsIGFtc19jaGFubmVs
cywNCj4gPiA+ID4gKwkgICAgICAgc2l6ZW9mKCphbXNfY2hhbm5lbHMpICogbnVtX2NoYW5uZWxz
KTsNCj4gPiA+DQo+ID4gPiBIbW0uLi4gYWNjb3JkaW5nIHRvIHRoZSBjb2RlIHRoZSBudW1fY2hh
bm5lbHMgY2FuIGJlIGxlc3MgdGhhbiBvcg0KPiA+ID4gZXF1YWwgdG8gbnVtX2NoYW4uIEhlbmNl
LCB3aGF0IHlvdSBzaG91bGQgdXNlIGlzIHRoZQ0KPiBkZXZtX2tyZWFsbG9jX2FycmF5KCkuDQo+
ID4gPg0KPiA+ID4gc3RhdGljIGlubGluZSB2b2lkICpkZXZtX2tyZWFsbG9jX2FyYXkoLi4uKSB7
DQo+ID4gPiAJLi4uc2VlIGhvdyBrcmVhbGxvY19hcnJheSgpIGlzIGRlZmluZWQuLi4NCj4gPiA+
IH0NCj4gPiA+DQo+ID4gPiBObyBuZWVkIHRvIGNvcHkgbWVtb3J5IGFnYWluLg0KPiA+DQo+ID4g
V2lsbCB0YWtlIGEgbG9vay4NCg0KSSBkaWQgc2VlIHRoYXQgdGhlcmUgd2FzIHByZXZpb3VzbHkg
YSBkZXZtX2tyZWFsbG9jX2FycmF5IGltcGxlbWVudGF0aW9uIHNlbnQgZm9yIHRoZSBvdGhlciBY
aWxpbnggeGFkYyBkcml2ZXIuDQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9saW51eC1paW8vcGF0Y2gvMjAyMDExMDIxNDIyMjguMTQ5NDktMi1icmdsQGJnZGV2LnBsLw0K
DQpGcm9tIHRoZSBjb252ZXJzYXRpb25zIGJhc2VkIGhlcmUsIHNob3VsZCB0aGUgdXNlIG9mIGRl
dm1fa3JlYWxsb2MganVzdCBiZSBmaW5lPw0KSWYgbm90LCBJIHdpbGwgc2VuZCBhIHBhdGNoIHdp
dGggZGV2bV9rcmVhbGxvYyBmb3Igbm93LCBhbmQgdGhlbiBJIGNhbiBzZW5kIGEgcGF0Y2ggbGF0
ZXIgZm9yIGRldm1fa3JlYWxsb2MgYXJyYXkgYW5kDQpJdHMgdXNhZ2UgZm9yIGJvdGggWGlsaW54
LWFtcyBhbmQgeGFkYyBkcml2ZXIgYXMgd2VsbC4NCg0KDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3Qg
UmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo+IA0KDQpUaGFua3MsDQpBbmFuZA0K
