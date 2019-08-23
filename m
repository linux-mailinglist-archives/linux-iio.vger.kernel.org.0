Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0465A9B7E0
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2019 22:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392495AbfHWUvN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Aug 2019 16:51:13 -0400
Received: from mail-eopbgr700042.outbound.protection.outlook.com ([40.107.70.42]:42048
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388903AbfHWUvN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Aug 2019 16:51:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7bYZexuCeXXg5rAZJKFKGeqMpZZTwn/1hr/jjGZksSujg2HbbYWHUA9CrbcN/ENMf76o8jqdERv0ENfsxlPID04oDdGiHq3TehOfnNL1FzvfeS5suNtsxB8/5ydeDyUdcYQQyU/kH8UBAt6bQBg6H6OgLjtUw3ZtmwMpB8aSSdXSVx5Rn0KCKncy9gJfuFlu50Cqy/bq4o36HcEHugaEBoRRhf8BuL5evwEGviIZJWJHeGx+3cm+fdpagpH1/J2iQtRJVYMgscZgrikjjHIi3uKzhkjRxjR1BldKa8hrcX8X/D1SD2L8bFI52+7ANrM6VCpwxuv/sS2dNQX+51Rvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7LIGr5Zny4JwyyH9yQyc7su5+Kt2kRL1f6ZhC1vWp4=;
 b=iInceNydpK/4ulgNH7Y6OwC3UtCkjxeddGwA7ybedspm15rwYPVbxZHV7Is1MbbwLmbDCxTIqm7RXC+oWZBJrrA7ZDJF1aihcLCm+jT5RlWn90m0p5FEdLO78uuNI2FhejIQHBzvp1KZ2/+jZz96ePrdCiBadtptVrXID13LRVfjiyzuJfZDhaxisrfSNMntN2A59gN5I6c7RtKt4hVB0cijP4XCi4VoqhadapxfaeNcqZ9Ke6t5tn9WXgUUZ5jnLfEjkt1V0U1P3LDI0NH5lXA+s7VCIyOeaDHxtMsA7onRdrYbNa9qqb9sLFjV5Vp4fhmdVO8lc4MvBJUlKwu7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teejet.com; dmarc=pass action=none header.from=teejet.com;
 dkim=pass header.d=teejet.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sprayingsystems.onmicrosoft.com;
 s=selector2-sprayingsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7LIGr5Zny4JwyyH9yQyc7su5+Kt2kRL1f6ZhC1vWp4=;
 b=S7OkAokZBMw1nBsR2E1dk07qsbH4NZJGnZNZK+20uQPkirbfRB4y+ibc1pi3otOljDcfLQMFOXSfRKFWWTE2yC+mjHS82yUQGOc6kuB6Ne2j1wOoqRyKGg5irHQS4pVN5CAWBF4oHAhkLaT1olq/bon1FrdRNsRdtC+HLAJXLrI=
Received: from DM5PR19MB1657.namprd19.prod.outlook.com (10.175.225.14) by
 DM5PR19MB1402.namprd19.prod.outlook.com (10.175.225.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 23 Aug 2019 20:51:11 +0000
Received: from DM5PR19MB1657.namprd19.prod.outlook.com
 ([fe80::8cc9:43a6:4ba7:95ad]) by DM5PR19MB1657.namprd19.prod.outlook.com
 ([fe80::8cc9:43a6:4ba7:95ad%8]) with mapi id 15.20.2199.015; Fri, 23 Aug 2019
 20:51:11 +0000
From:   "Grim, Dennis" <Dennis.Grim@teejet.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: buffer read
Thread-Topic: buffer read
Thread-Index: AdVZ4JwdLx/k60FyQVWzw6A5k5S4IAABkHsAAAL7EvA=
Date:   Fri, 23 Aug 2019 20:51:11 +0000
Message-ID: <DM5PR19MB16572CE964533959B4499A329EA40@DM5PR19MB1657.namprd19.prod.outlook.com>
References: <DM5PR19MB1657B9E3EE28C387B09DB1889EA40@DM5PR19MB1657.namprd19.prod.outlook.com>
 <2cf1675b-4a70-7296-d3dc-3ea99254f6e4@metafoo.de>
In-Reply-To: <2cf1675b-4a70-7296-d3dc-3ea99254f6e4@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dennis.Grim@teejet.com; 
x-originating-ip: [50.200.218.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5667052e-8325-4c2f-f42a-08d7280ba164
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR19MB1402;
x-ms-traffictypediagnostic: DM5PR19MB1402:
x-microsoft-antispam-prvs: <DM5PR19MB140283B7182F00E3CA722FE89EA40@DM5PR19MB1402.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39850400004)(136003)(396003)(189003)(199004)(9686003)(7116003)(26005)(476003)(8676002)(86362001)(4744005)(2351001)(6506007)(486006)(6436002)(478600001)(316002)(229853002)(52536014)(66066001)(186003)(55016002)(446003)(11346002)(74316002)(81156014)(14454004)(221733001)(7696005)(102836004)(305945005)(7736002)(76116006)(66446008)(64756008)(5640700003)(66476007)(66556008)(66946007)(53936002)(6246003)(6116002)(25786009)(3846002)(6916009)(71200400001)(71190400001)(3480700005)(99286004)(256004)(76176011)(5660300002)(33656002)(8936002)(2906002)(81166006)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR19MB1402;H:DM5PR19MB1657.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teejet.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vrs+EgbMPP1AlaVEP0dDbeYM1EV/QncCsjNDnblNAmD2e/z//e6ZhjGD4ltBAhJFFc/6K8Ymln5awMtVkVjrsXSBUPLp1dkXnKTH7lBPjq2xfkR3KKjOHGIhYXg3AkAaDtS2MNeXu9dDNYQrc/xUgaPF5dunD4r0voS9dxtMLR1faudbDEeX5EPgb+VN605akCns5NST964ntFgnErcqRmsA0yOC6iQW+nK4EaogFG3bRquOr12D4Ql0UviL5H3OyHmxKWyk33Iib8opGycF2OWURfHml9tXkFWb/bg9a7ebAYL1SbkPcwgMm6oX2eLQd0bLJEvJOw/dfVKb+gZrIDSCeJi0c7JR/QkXukgLDOT2AwunnsTNycqclxIeN+5dfAIf80Zg9owpgHokZcT8EzxCSUKQKaKiCWS2Sva9AuA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: teejet.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5667052e-8325-4c2f-f42a-08d7280ba164
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 20:51:11.3303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: db000de6-d154-412a-bd1b-47cf93f41d57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89VLZahB0nN7afThjVK+OeSVmkh6wNRwIUwkgi4v+hCcWFzMx8u+EZzZwfhpe1jI05BCNFx/PPgtQ+2fLXL3Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1402
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBBcmUgeW91IHN1cmUgYWJvdXQgdGhlIHZlcnNpb24gbnVtYmVyPw0KTXkgbWlzdGFrZS4gIDMu
Ni4wLg0KDQo+WW91IGNhbiB1c2UgdGhlIHBvbGwoKSBvciBzZWxlY3QoKSBBUEkgdG8gd2FpdCBm
b3IgZGF0YSB0byBhcnJpdmUgYmVmb3JlIGlzc3VpbmcgdGhlIHJlYWQoKSBjb21tYW5kLg0KcG9s
bCgpIHdpdGggYSB0aW1lb3V0IHJldHVybnMgMCBmb3IgZmRzLmV2ZW50cyBzZXQgdG8gUE9MTElO
IHwgUE9MTFBSSS4NCg0KU2ltaWxhcmx5LCBzZWxlY3QoKSBkb2VzIG5vdCB3b3JrLiANCg0KPiBB
bHNvIG1ha2Ugc3VyZSB0aGF0IHRoZSBidWZmZXIgaXMgZW5hYmxlZA0KV2l0aCByZWFkKCkgaW4g
bG9vcCwgZGF0YSBhcHBlYXJzIGFmdGVyIGlpb19wdXNoX3RvX2J1ZmZlcnMoKS4NCg0KVGhhbmsg
eW91IExhcnMuDQoNCi0gRGVubmlzDQo=
