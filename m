Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AD93F086B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 17:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbhHRPvL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 11:51:11 -0400
Received: from mail-eopbgr1400103.outbound.protection.outlook.com ([40.107.140.103]:35062
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237755AbhHRPvL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Aug 2021 11:51:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiT5gPoLlKmsB+JP8yOtaB5/qvs6ka5O8WcFzAjWDv5c/OmNkw3gKXmsHoRL7LcNWt92Gd7E0Xv23vyuG/F6Vosj5LkWq+dUV+UNF5OCCxHczN3Oo7ZS/zkoTTnOnOgHIbBeYaqCpxIUzppdnSDrB5yMNK5hpHj5bj8TN3Y6km/Lk/5n6pc/xMTwLhPH+FfuSX3Jnkx6ssu+8TYe2nMBkElEWpbxK3DaYWdjmqBB+u4dCXl9KcDt1K19OgXLltUqUdib5l11eWVbnW4uo1dL8WnI8cKHjbW+inHQvNHxFe7P7G8SP0afTZMbIgXxUZVhSM9sj7D99qwhXVvcBurN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSQEb4Pr0CfbZkxQT8lU4jkQyfvvtIHGlL3e1TAPuOI=;
 b=LAbzJdDL5kRoIqt9ZXW5xSZZnHn0L9sqs8h+W6gA3ZF9E1F7N4ChKNDYgox8YJvWeHu76OhnHQ7eYT1v+lBXSww3ClUrmyaAQ7iWzJ8whmt/Tz3XEoGcda424P/qcVvW9jroXflH/+HliGtaI+bUd/IAosAwWuXN9VUgu1sR80bjBWjockPpe4qwj9WHk0BgBtX+l6moGqiKNG5ESdEVSh5uxSCWDKD6H9z/qpNV18HKs5sEGoL2KMJ6BJCUpr6+9u7GF/XA6fgWru+YJ7XDmHWMMk1lmoPxrh0HRt2DWa0ead/7k781MMS9P+I4uUGHbBFZ219s14c3PBfVeAbMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSQEb4Pr0CfbZkxQT8lU4jkQyfvvtIHGlL3e1TAPuOI=;
 b=QUzsQT90e5Q/x8Pqh6gvhBqY6ICXTxnzEKmsIY2gqTvWlYx4MiQ2imRhQVT2MuO12LlKNzGi/FPEgeh+HGvlA7oiAL5l+fWt3DhUJDwAVv7LCUNANgRSpvx65fRql7cjcATBPBBtXPJgsH8eVvXZBI+aL1Kewqsx1FUNFdLemmQ=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB4500.jpnprd01.prod.outlook.com (2603:1096:604:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.24; Wed, 18 Aug
 2021 15:50:32 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::dd31:23ef:4263:e86b]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::dd31:23ef:4263:e86b%6]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 15:50:32 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Colin King <colin.king@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] iio: adc: Fix -EBUSY timeout error return
Thread-Topic: [PATCH][next] iio: adc: Fix -EBUSY timeout error return
Thread-Index: AQHXk4xKnmwFd9XUf0+wRuPZLU5uOqt5aX/w
Date:   Wed, 18 Aug 2021 15:50:32 +0000
Message-ID: <OSZPR01MB7019DD199CB1B9A4521A3C28AAFF9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20210817172111.495897-1-colin.king@canonical.com>
In-Reply-To: <20210817172111.495897-1-colin.king@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none
 header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed70674b-bd88-4457-e072-08d9625fe973
x-ms-traffictypediagnostic: OSAPR01MB4500:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB4500578FB69F8FCFC7738395AAFF9@OSAPR01MB4500.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O34JpMZZqD/fM+kqu+wnzS0cysgOHMG9Cy3AjxtUzrtdeupbdVvgPG8OBcMGVdGZdK5KBwBOhDYXusjD2A13d8+WO47KlKoVTxDVnOqUTCgjpOgNK2qC4rSKNNxCvppz4OuiH9mU6UgygUv+Q2GxHVNJYB/lydwtcUHsDwzpaNJTwH1x9s95Wxum/35QfM0h+9QxY74NcHGBgRrF7bYVrQ7jivbXTjqlRmeSHWCrxEkStD1f1j3AONrCK60qho8jh16C3sbRHaQEjoXbmzigyo5xz9Uvu2MbSmLh5XtLf6SjOkdmrqL14uYCRVt4iocBsxuahkm22UWJ65t3tL0K2UMrtgqYtouxvODayGYQmmDGoWxcfYSAt4j2cb7jmHAIqZ9exDAYGBhptOw85EhoLr/jvvXg04WqErcV3uG+qAEwSUmdYWSICmoDRM85r97ohW7alDobb7kd43gik+F9016C82/sp2w9ofFtlsA9Sp0m4Ccrpqp6qfRGxarW7oWKUfIAcb96xgcLUOixhcoEfNlXoJZoo1ibzMaismcN3N2VTsWERPvVht7JK0sXDOaDI7WavsPZMvBDi3b2AkMMSaqPrJZ61HhDRoxBHAW4f5d/FVXdbewB45S0nCbORp9ug+BhDaz6clNyGAr0DOTo07POi5TsiYTXWqfUa7+zhsHeyco1YGcr30AKSLfsJi9XBi/aWrHKVieylWgllLIH5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39840400004)(136003)(396003)(4326008)(316002)(8936002)(33656002)(86362001)(71200400001)(66446008)(186003)(8676002)(2906002)(66556008)(26005)(478600001)(66476007)(76116006)(66946007)(7696005)(5660300002)(122000001)(83380400001)(38100700002)(38070700005)(54906003)(53546011)(110136005)(6506007)(9686003)(52536014)(55016002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEJNK09hc0EvQUZhV3poL2o4WnNlWHRUTXA4S0NMVlJnTjJRWVowamljdWpx?=
 =?utf-8?B?QTNzSlFscWhyZDhzRXk0N2hGOUVWTjdDZXdzSmxvSHpYQkxPTDBTenFMb1NO?=
 =?utf-8?B?UHZmSDhLMDEzUTMxclgrVVBNRmh5Y0wzb21NR3R6Skw0QkZlOFNiZUd5d3Jq?=
 =?utf-8?B?NE9aN3lLWU8xL2Z1MU92MGpJK0cxSXZVcGtFRWtVNWZka0pPYk90ZWJJVmRh?=
 =?utf-8?B?eDdaVy9LMmNyb3VlUHdLWVV1bzIweW9IZEU2SW9TRm9RZklCd0labG83RFo5?=
 =?utf-8?B?S29PQkR0Wk53WGxzWDkvcE8rb2QzbWprQWczYXM5NEpraWF5NU8zN05oSG96?=
 =?utf-8?B?Z1ZxMG03dG55ZE9MRmthQWpra1I2UnQwNTFHTmxUM2NMZGozNCtNNUp4VHRC?=
 =?utf-8?B?MVdkR3AvNTVadmwwczZkODVKcTk0UVRwQW1YNGcydEpnTDlINElBU00zQjhI?=
 =?utf-8?B?OU5oTHNXdGlzSzFJU3Q1L21Sbk52S1NhMmorZlA0Z1hCN2VDbjgrODQ0T3ZL?=
 =?utf-8?B?SnBvV0srbFRzZnZ1Q3M0Q3IwZCtxNWpEdUN1OFFkZmRIVHduejFqK0FBeDBB?=
 =?utf-8?B?ZlJrajJsNFZUOEZLaml0Q2UwRFY0N0JsbGxPV0pRT2NIT28zbnhBRFZlVHcv?=
 =?utf-8?B?MXF4NXpLdHM1M0wwTlRJNHl3VlRYUWx4UHRZcWNHSUxTWmtsWTBSak9vU2RR?=
 =?utf-8?B?YzhFOHF0YjRCY3J1QnAwWUgrdisxVjd4TXpMUVdBdldDZWlURCswU0N6S1J5?=
 =?utf-8?B?R0dYMGtqOHFwN1RQdGE3M25mT2RlRW4wVUMwZHpqZmErZFNaTVgxRlpDemRX?=
 =?utf-8?B?cUI2M1c1QUc4WXIvNGhtd1JMRW1FL1NiS1VPVFhqRGZLZXBNWDBGM3ZvTFIy?=
 =?utf-8?B?eHFWY0dVeU4yZlB5anlJdWpORzYvSVpoM3FvMWZGQnBHbFYxc2lKNkNHM3VR?=
 =?utf-8?B?Z25MYk5pK1lTK21ad1hadnBYUWtzZWhBR0Zuc2cvUmpNMmJDRkJNd0ZwYVhX?=
 =?utf-8?B?Q09GOVBsSnRQODRWZGlsTGxQcU5SaWhQQldqVUhEUWFsVDNXZ2gySWNtWFBp?=
 =?utf-8?B?VGFMVHV0empTc0FmM0ZUNmlhc2oyVjZ1Qzc4dldZL2F6Kys1ZXFtMVkrWkpT?=
 =?utf-8?B?Tjl2aTFXRDhDODJIbGt5alp6UDBqc0VlN2lxQWhuV0l6Y1N3TDlmblpjMlRE?=
 =?utf-8?B?QmFibUpUYzRxTVV2QTVheG00eUVvV0FWaHFYRUQ3WEx0aklqaVhxcVRJVGNo?=
 =?utf-8?B?L1RhSzVrS2hnZ3NzN3Ywcm1velNDRkxqK3JzRklhQ0FWL0hqTS9QMjhzQVZn?=
 =?utf-8?B?YUE2Nkl6VFg4U1VxRjJkWldGRVBrd1prc29lVUpyckt2SXV4Qm00REtBNndn?=
 =?utf-8?B?T1hlc1MyQU04UlR6dXJQTmhMU0YwNXdHYkUycTloeUJBbkxXK09xeHlraVVQ?=
 =?utf-8?B?OHZDb2pOMXEzUXJqajY3SWMwVE5NaEZiR3hGQWdvZVNoVi85M1JsTWJGdUhO?=
 =?utf-8?B?RUt3SDRLeFRJWnZDTTZZY01NcXkrNThhS3dSK000enY2L3JBMFQrdk1lWmhO?=
 =?utf-8?B?WkFTRzlCZkxweWdtU0tkSkFLRjZvVEJuSDNvd0RjaXhIK0ZjSlplMUVaaDgx?=
 =?utf-8?B?U25WbFI0cm9NYitmUnM3WnJya1N1di9ZaHNIUDVZcnh6RjZWZDJvOTVBb1Ba?=
 =?utf-8?B?OVQzaEVLci9VSUdpVUw3czdOMWJrN0krZ3JXSXhZcjJoZDR4aURObE9FSm94?=
 =?utf-8?Q?Xq1C1Ni2/oI14GPSomxgBe07uoYXSgNvbLM2PPF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed70674b-bd88-4457-e072-08d9625fe973
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 15:50:32.3455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: inrbYp5kshEvuC908rWpBlgJ4o/3c1N8IKhK+hnjTAIz8TSUtrIkBem5ceSrdXpU+0HdDKd2J4HMDx5IWcO6qPpQ7XHrS37RpCWw/C5OZTqIzQbNc4IN24muv2DNOTcE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4500
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQ29saW4sDQoNClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IENvbGluIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNv
bT4NCj4gU2VudDogMTcgQXVndXN0IDIwMjEgMTg6MjENCj4gVG86IFByYWJoYWthciBNYWhhZGV2
IExhZCA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPjsgSm9uYXRoYW4g
Q2FtZXJvbg0KPiA8amljMjNAa2VybmVsLm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0Bt
ZXRhZm9vLmRlPjsgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPjsNCj4gbGlu
dXgtaWlvQHZnZXIua2VybmVsLm9yZzsgbGludXgtcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF1bbmV4dF0gaWlvOiBhZGM6IEZpeCAtRUJV
U1kgdGltZW91dCBlcnJvciByZXR1cm4NCj4gDQo+IEZyb206IENvbGluIElhbiBLaW5nIDxjb2xp
bi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IA0KPiBDdXJyZW50bHkgd2hlbiBhIHRpbWVvdXQgb2Nj
dXJzIGluIHJ6ZzJsX2FkY19od19pbml0IHRoZSBlcnJvciAtRUJVU1kgaXMgYXNzaWduZWQgdG8g
cmV0IGJ1dCB0aGUgZXJyb3INCj4gY29kZSBpcyB1c2VkIGFzIHRoZSBmdW5jdGlvbiBpcyBoYXJk
LWNvZGVkIHRvIHJldHVybiAwLiAgVGhlIHZhcmlhYmxlIHJldCBpcyAwIGJlZm9yZSBlbnRlcmlu
ZyB0aGUNCj4gd2hpbGUtbG9vcCBoZW5jZSB0aGUgZml4IGlzIGp1c3QgdG8gcmV0dXJuIHJldCBh
dCB0aGUgZW5kIG9mIHRoZSBmdW5jdGlvbiB0byByZXR1cm4gdGhlIHN1Y2Nlc3MgMCBvciAtDQo+
IEVCVVNZIHJldHVybiBjb2RlLg0KPiANCj4gQWRkcmVzc2VzLUNvdmVyaXR5OiAoIlVudXNlZCB2
YWx1ZSIpDQo+IEZpeGVzOiBkNDg0YzIxYmFjZmEgKCJpaW86IGFkYzogQWRkIGRyaXZlciBmb3Ig
UmVuZXNhcyBSWi9HMkwgQS9EIGNvbnZlcnRlciIpDQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElh
biBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8v
YWRjL3J6ZzJsX2FkYy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KaWlvOiBhZGM6IHJ6ZzJsX2FkYzogRml4IC1FQlVTWSB0aW1l
b3V0IGVycm9yIHJldHVybg0KDQp3aXRoIHRoZSBzdWJqZWN0IGNoYW5nZWQgdG8gYWJvdmU6IFJl
dmlld2VkLWJ5OiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVu
ZXNhcy5jb20+DQoNCkNoZWVycywNClByYWJoYWthcg0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lpby9hZGMvcnpnMmxfYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvcnpnMmxfYWRjLmMgaW5kZXgN
Cj4gOTk5NmQ1ZWVmMjg5Li44NjhiMTgzZTc1ZWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlv
L2FkYy9yemcybF9hZGMuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvcnpnMmxfYWRjLmMNCj4g
QEAgLTQwMSw3ICs0MDEsNyBAQCBzdGF0aWMgaW50IHJ6ZzJsX2FkY19od19pbml0KHN0cnVjdCBy
emcybF9hZGMgKmFkYykNCj4gIGV4aXRfaHdfaW5pdDoNCj4gIAljbGtfZGlzYWJsZV91bnByZXBh
cmUoYWRjLT5wY2xrKTsNCj4gDQo+IC0JcmV0dXJuIDA7DQo+ICsJcmV0dXJuIHJldDsNCj4gIH0N
Cj4gDQo+ICBzdGF0aWMgdm9pZCByemcybF9hZGNfcG1fcnVudGltZV9kaXNhYmxlKHZvaWQgKmRh
dGEpDQo+IC0tDQo+IDIuMzIuMA0KDQo=
