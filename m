Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1626443C60E
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 11:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbhJ0JHU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 05:07:20 -0400
Received: from mail-mw2nam08on2059.outbound.protection.outlook.com ([40.107.101.59]:28416
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236159AbhJ0JHT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Oct 2021 05:07:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gwb7aX7zix24NoDOPOcsjv6Zw5XP/HqLliCiZhgjwcMwsuvdCnYXHoM1LL4xcMiAeiiGvDNAD1FME6r9dyc5K+bJWuj0FphkrBrLA1fsRPgPYbais4g0F5sVZUbG9OcXZdJaO6q8pUE8Nq1zhavRfMpbTXkW14Q+oFTGlD1HKTR4uqYvnN22OrmXnsMd3U8KUJWUFK+9kNQ1YPq2UvIRT9QdUzr4BqfD8ZovUGIbwHMucIByePUZO6p7iumtUtD0BM4Y1iTosbvV+G00sDfwSECQpCk9nNznl0xiSobSK15R40wFv4I9W1Pi6uG+yOZyR0ETIiZnXrfKXD9HBEHGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxBrtTWsEh87NyiIFV4U6eLkcREoB702bNLRxoutvs4=;
 b=DXN3QdhzWDQaI10M/BBD7Y5nvLjTtxkRtlfUIZry9ISuPijm+xPCf6qIhFHR3ooOE7ipmprZQERZnzBFH8MTp/Mave41Nhy4lhJ49F/D1+GkdswvvArcYy8MKrsQTB1Tws6SGnTFLkRxPoRLGVXlbu3GEFZKDfG0ARF9l64uSW51gLRPStvaBQMs8ym5hBtgtKAzeJSB+pU5mRMWhaEgkBFkz7Od0IypSP+L04W+ZKxTTd9bt+ERyRwwhC1LcqzJ4kfUzNC0m6sG2jcfgfB5ts6TupNKbVFvL9J7HZUhTaT24GwZ2preCfhah43T72rGrpQfJlKpyzhUPPRaXJJqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxBrtTWsEh87NyiIFV4U6eLkcREoB702bNLRxoutvs4=;
 b=pUD0jWUAVD5/YRE+d9p3j9aRytIdJAGRCLmg7GkJWnrEmYX8dkSUB8bjRa7LzNRA/s/pa5IZk1m+Jo661xacthnbFeZnSB3WXPztdyTtA8y9e6bvxQUhbUiEDLb9jQzWDLLi+P2TumQRTbdCiY/wtQi6G5eZoI+cEHL4xhiMFAw=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BYAPR02MB5365.namprd02.prod.outlook.com (2603:10b6:a03:66::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Wed, 27 Oct
 2021 09:04:51 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 09:04:51 +0000
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
Thread-Index: AQHXxPztLE/r+aVUT0W7KtDOJosftqvk5u0AgAGxjBA=
Date:   Wed, 27 Oct 2021 09:04:51 +0000
Message-ID: <BY5PR02MB6916298122D8F4BDEFF67D0FA9859@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
 <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
 <03afaedd-8ea5-0379-ac98-db61ac679259@metafoo.de>
In-Reply-To: <03afaedd-8ea5-0379-ac98-db61ac679259@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10f19532-b738-426c-dd24-08d99928d5be
x-ms-traffictypediagnostic: BYAPR02MB5365:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB5365279ABBE9F693EA7940EFA9859@BYAPR02MB5365.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sI4H7lmDZVE5CN+nWwUPkmWqZmRF/ArbbqghT4mUXNmt+35QlovSSgcVNySKclaFwZangPWfoqa2XDy/Sd9ZXHBsYLKX+aTXRPGbUBFJbebkfnBwBaAuBJ8+im57YC2R3GnOeJFDdLYP+JOmN0gRgeWneh7EGXitt0Wz2g3QyTOxy+TzhLHzOuPx387C3/tK/Zy81UrILiOwBIhEPJbjbfQkYqPCg5Y7ML90/iptjIm11XtDqlm0x9liVkGz9+XhBLSEcgTyL1IzvAM62qQrrdx5oJo1nw4OGCF7GrW3ftvujCRB0+q49YpiCcurtBMkTXEkZko/DDvY20StzTpsnt37SttOrihpFg/IRLSv6rXazrVhkmoabO/NPZJkA9GAVl2r9EAx+N+CqYJnu1ogKcBvDc72dC2HGgV+qfPBMpifJA5kcLZeoy8Ddak2Js0Hc/eln1zYQiX6m4Vio4aIDKRi0cpYNQwNJQ5JjwJyOgt2Qyef3CMNo8CI1pKzUYYHMLWpznTkmvoCo4eMJc6RkG1/VFaZHu37VI/u7qKiD/gXBsiLH5D7p777I/Bwpc4SgafFi2ya6A7I2KhKsTqZsXG/ZysTLVAzode5Pb0b3wiwMhl8YRe/WhR/fM1ATLIRLhR/9F38YYwvwTLSNUSWX9WjKYLIX25ye/Atrpbn3yQBP/af1UDjibiQkhhb6/lESjRw2R95yH1aMxkrbqgryw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(110136005)(9686003)(33656002)(52536014)(26005)(186003)(76116006)(8936002)(38100700002)(2906002)(122000001)(71200400001)(4326008)(316002)(107886003)(64756008)(53546011)(66556008)(38070700005)(66946007)(66476007)(7696005)(8676002)(6506007)(66446008)(55016002)(86362001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWVEV05OZEdkWWJkNGRyNGZoS1U3a0p1T2t6WWhzRVBpM3NzbHd3dnptemFM?=
 =?utf-8?B?bDRYTm53dUx1VGVRMkFTamJSbkhLelZqbVJxVEZ2cllXQWsxTGI5WUgvZzYy?=
 =?utf-8?B?enZSNGVUSytEekZnQkVialgxdUpVQTFlbkZHNngvVjRPTUdPeVhnSCttUmND?=
 =?utf-8?B?cUZuNEEzRjM2LzBCOWFQN3JWRGZ1MlF5UndPNjdRUVVqdW56cmduOHhjTVR2?=
 =?utf-8?B?Mnk0cE9qdFNsQ2FzY0E2REpYZjNKbWZQTXFBVjFuWWVxc29ZdGVQVGxVYUp3?=
 =?utf-8?B?U3dWN2NYdngycEZ1T0QwVkJkWU5pZEU0RWZxTTh3TGR0NmhUSEVBT25YTXp0?=
 =?utf-8?B?K0gwdjdiUS9rdVhZdDFUUENCRmEyWnExUkgvbEU3V1p1ZWdLSy9UdEc4V0hi?=
 =?utf-8?B?aVluYVc0djdjYjJxQ0FuVDZpcmp4WllVSUlPSXlOdjA2VXpESlpyRitmVGFy?=
 =?utf-8?B?M0owYUJLK1h5b3d3dW5kSW01TlRPWHpSam1tQjd6bW5aRGdiT081YVh1dEhE?=
 =?utf-8?B?c2FQRWt2NE9XTlRITjczbjNXVHIzTldLZHZJUUlxVmRxWW1uUnJTcXhXQkh2?=
 =?utf-8?B?c1g3MnhvTlJVSE1vOW41S3J6bVNVbUZzMG1oTGZWM0hPSDFPa1Jnc0FqTThk?=
 =?utf-8?B?b3JWT1hqY3BYKzdQb2kwZUViTDdEczRKOE5IQ3d0UkZMc3RkV1NFWnJJT1pI?=
 =?utf-8?B?MXZYWDFESzNtR1hrYTM1RTh1QTZaZnhHKzE4aCtFdHEwRWRmcklPcXgzRDZp?=
 =?utf-8?B?VTRZWis5SWFvVTBUN3VTa2JlZ2ZxWEw4QzQyWGtGRWcvdkhPYThLRVZPN2ww?=
 =?utf-8?B?WEx3THhmMWtZaU5FSklkdFpmblBaYldQMVFjUXFjeDFQbEYyVU1GbGJZZlQ1?=
 =?utf-8?B?eXJVcHBid3ptRS9PV21uYnorazJYL1NtcGpVZXBiZWdMdFArZ2NTWUk2NWNV?=
 =?utf-8?B?RmZ1ajZKL0NkaXh2ZGpma1pHSmZ6aVp0bmZ4cnFLK2tiUFdjekhxeWFMQ2Vq?=
 =?utf-8?B?TXU5QUZIVldlNCtSMzNQalN2S2FQWThmUnp5UzYwSE9Jc2h0UktIZXVyay8w?=
 =?utf-8?B?UThLeUZGVmVrZVI1VmdsV1FIeWVXSWFBUUJidjU1NXJtRG9BaFhxa0kxTmIx?=
 =?utf-8?B?bzhBaVRHdUpya3psZHp3RzFjUUlJNStaa20yc2tqTTZOZ09rcDBJd2p6aFpV?=
 =?utf-8?B?a0VNS252UElvSTRVZTQ0MTh2cW0vbXpjQmJTd0ZtSmlSSmZSdFJ3bFp2RTRT?=
 =?utf-8?B?aVNHU3JCU2Q3dzVpVGVFZzl1OTFLd2JFazJncFNOcW1VQm1SOWttVU1zbGxD?=
 =?utf-8?B?djdic0JhWGdlMTNjc3dYWDJrT2czWUJHcGVUL00zVFlMem1leUZia1JBTGd1?=
 =?utf-8?B?c241WjIxOVF1NXY0Wm5COEo1Tk9qY0RJMlpFQU96dXI1NnRBSGwweW4wa3ll?=
 =?utf-8?B?YnpwRy9zOU95Y1dDU1gyendpYUxGenFVU1FpenJQVmhwWStlUGRtb2F1UURP?=
 =?utf-8?B?STd1Rm1hUmttd3VrZzBpT2pIaTZ4MG5zbW9vOXczRW1hUDRJRER4YWVTSjV3?=
 =?utf-8?B?amZ5Y05CQ0t3RmZpMFVwaytYU29JY2dwaFBoZ3o1QmlDUXhrRzJXMW9ETmlZ?=
 =?utf-8?B?RUsrYWZ1ZlR2S2h4VXFGMXNFYmQxREo3MGxNcXBkbnhINDhZWmljS1pNNno4?=
 =?utf-8?B?NG5KK0M2RzRSUGdDM2xYQmY3TWhtYkZObm14eisvNUs1WWxZQWJVdTFRREhz?=
 =?utf-8?B?WGxkRG54allLVlNZNnF6bVNZNVZUZnU1dTRzQTRBL3BFdXp3Qyt4N3ltUGZU?=
 =?utf-8?B?MzUyTVVmcFE4MWhsWk1kSndlVWRmU0dTYnFMWEV5OHAvTUdrbENTSUpSdWZs?=
 =?utf-8?B?OUlqZGVySU96WHI5eVZGcVlSUUhqcjY4QzNVUHUySDBzVm95QjhYREJBOHlI?=
 =?utf-8?B?TkZjdlJkb3g0RDBQT3c2dytlN09FSXVrRW1HSE4rSndXeHRXKzFvam1OeVRM?=
 =?utf-8?B?RlhaL3VwTVZYb2xxenlhU1RwWUJDTGRKeTJ6RHlHUUx3WEw4bHBEMGJJaHNK?=
 =?utf-8?B?R2lvVWZ5UTA1d0k5TElFZUdTV05jcjZ2TEdmNkNNMGE4NlRZam4rTmJ1U0xJ?=
 =?utf-8?B?RXJvWFVkMW1NLzlkc0dsR2tSaWVJS0FlTWQxMU5zOVJwWlR6RUFPNFNXZkFP?=
 =?utf-8?Q?MyyP0xo2uxyC4TPcXL+h3K8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f19532-b738-426c-dd24-08d99928d5be
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 09:04:51.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKlGCJlwCatPRKiDrb+sOv6GePLTRkrp/owtNoK5zcUEaeBHlghqJVL7Ij3KKZhURDUhtvdSjJREdmbNEMxyVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5365
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgTGFycywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IE9uIDEwLzE5LzIxIDU6MjAg
UE0sIEFuYW5kIEFzaG9rIER1bWJyZSB3cm90ZToNCj4gPiBbLi4uXQ0KPiA+ICsjZGVmaW5lIEFN
U19DSEFOX1RFTVAoX3NjYW5faW5kZXgsIF9hZGRyKSB7IFwNCj4gPiArCS50eXBlID0gSUlPX1RF
TVAsIFwNCj4gPiArCS5pbmRleGVkID0gMSwgXA0KPiA+ICsJLmFkZHJlc3MgPSAoX2FkZHIpLCBc
DQo+ID4gKwkuaW5mb19tYXNrX3NlcGFyYXRlID0gQklUKElJT19DSEFOX0lORk9fUkFXKSB8IFwN
Cj4gPiArCQlCSVQoSUlPX0NIQU5fSU5GT19TQ0FMRSkgfCBcDQo+ID4gKwkJQklUKElJT19DSEFO
X0lORk9fT0ZGU0VUKSwgXA0KPiA+ICsJLmluZm9fbWFza19zaGFyZWRfYnlfYWxsID0gQklUKElJ
T19DSEFOX0lORk9fU0FNUF9GUkVRKSwgXA0KPiBUaGVyZSBpcyBubyBoYW5kbGluZyBvZiBJSU9f
Q0hBTl9JTkZPX1NBTVBfRlJFUSBpbiByZWFkX3JhdygpLiBSZWFkaW5nDQo+IHRoZSBzYW1wbGlu
Z19mcmVxdWVuY3kgYXR0cmlidXRlIGFsd2F5cyByZXR1cm5zIC1FSU5WQUwuDQpDb3JyZWN0LiBJ
IHdpbGwgcmVtb3ZlIGl0Lg0KDQo+ID4gKwkuZXZlbnRfc3BlYyA9IGFtc190ZW1wX2V2ZW50cywg
XA0KPiA+ICsJLnNjYW5faW5kZXggPSBfc2Nhbl9pbmRleCwgXA0KPiA+ICsJLm51bV9ldmVudF9z
cGVjcyA9IEFSUkFZX1NJWkUoYW1zX3RlbXBfZXZlbnRzKSwgXCB9DQo+ID4gKw0KPiA+ICsjZGVm
aW5lIEFNU19DSEFOX1ZPTFRBR0UoX3NjYW5faW5kZXgsIF9hZGRyLCBfYWxhcm0pIHsgXA0KPiA+
ICsJLnR5cGUgPSBJSU9fVk9MVEFHRSwgXA0KPiA+ICsJLmluZGV4ZWQgPSAxLCBcDQo+ID4gKwku
YWRkcmVzcyA9IChfYWRkciksIFwNCj4gPiArCS5pbmZvX21hc2tfc2VwYXJhdGUgPSBCSVQoSUlP
X0NIQU5fSU5GT19SQVcpIHwgXA0KPiA+ICsJCUJJVChJSU9fQ0hBTl9JTkZPX1NDQUxFKSwgXA0K
PiA+ICsJLmluZm9fbWFza19zaGFyZWRfYnlfYWxsID0gQklUKElJT19DSEFOX0lORk9fU0FNUF9G
UkVRKSwgXA0KPiA+ICsJLmV2ZW50X3NwZWMgPSAoX2FsYXJtKSA/IGFtc192b2x0YWdlX2V2ZW50
cyA6IE5VTEwsIFwNCj4gPiArCS5zY2FuX2luZGV4ID0gX3NjYW5faW5kZXgsIFwNCj4gPiArCS5u
dW1fZXZlbnRfc3BlY3MgPSAoX2FsYXJtKSA/IEFSUkFZX1NJWkUoYW1zX3ZvbHRhZ2VfZXZlbnRz
KSA6DQo+IDAsIFwNCj4gPiArfQ0KDQpBbHNvLCBmb3Igc29tZSByZWFzb24sIEkgaGF2ZW7igJl0
IHJlY2VpdmVkIHJlc3Qgb2YgeW91ciBjb21tZW50cyBpbiB0aGUgbWFpbCwgYnV0IEkgc2VlIHRo
ZW0gb24gcGF0Y2h3b3JrLg0KSSBhbSBub3Qgc3VyZSBob3cgSSBjYW4gcmVzcG9uZCB0byB0aG9z
ZSBjb21tZW50cy4NCg0KVGhhbmtzLA0KQW5hbmQNCg==
