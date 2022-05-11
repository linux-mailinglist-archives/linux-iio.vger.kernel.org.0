Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AC7522DFF
	for <lists+linux-iio@lfdr.de>; Wed, 11 May 2022 10:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbiEKIO3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 May 2022 04:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243370AbiEKIO2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2022 04:14:28 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2095.outbound.protection.outlook.com [40.107.114.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF1BE6B45;
        Wed, 11 May 2022 01:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YncOKlrxU6ltn3T2DPAEqZ4MJ8WVfBsF65pEZmJHR2tt7Tv1N4Kr60K7hpxuix/o5ZkPWzIS5WPDAmjQjedP1haeb5n2we4ODu9t6CbzmNf58LzI8NlqgSZkUNccea/PWIxnof/h4e/glhW8BvQ71cET1vXvzJgCgqROVOW3Oaqjlj4hWBS/DxhGVm/miHVcGGxROrAHpEuw9lOE4ca2e2S3+7xiXW4p2ir/Y1azxsoURmaIvjXKO3np+8GUObPznqX6Z9GVxTuVxuP7braQCZtIXUw4jx2zcZMLEknivHOrLTAYLrH0CSGqkRIBWwxHHoFrbfllcsXwGjkgHzdl1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4EEKE2cLlx0JEQBKcLI6dgNgAGWlzPJbodLlZs/KL8=;
 b=S373dSPixkbnWGTpzf2bBeC9dRW9Xa+DwM0FzgWUs+RKkp7GGB1fIY4EhQ1CCZjI+JTwk6uRifHZfeQgTPlvdygdy1F9zdPjzHnIZqPSk7YfRasHGRiyQy8HkrjeTghcIGgMsGhQ/a+H0kH/rwZkVlSVPJgjoxPbCxupzx7vv74gVC0dUiPaPNojTDPgH/i57mMZXnCcZTd7UfWPh/l9LESBGXIdOXmBMh/4CuSWRvu7jfUtMNjkxyiB0+1Qh72sHvX+3Z6KDdpLhfsf2bHColQ00cfiTNkGlqooNdt/zKWdRTEtjcLkSA1NuytIKf4mxUarIVE8QHfznubZrG4MtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4EEKE2cLlx0JEQBKcLI6dgNgAGWlzPJbodLlZs/KL8=;
 b=eSOwj8w5EUKifqtyxXBrg2uvmw0/9BtCCUYgDefHiVG4tmsSlacg7bwI7VVxUUUn9tTqxkwwNL80K4ukDHpuAFgjaMBx7e02Wr/VZpKA+WIqivnRVjWNn0crioDzgnFmkbQP7UMbtv/y1M0/yQlMWmVHBu2Cs3SkC5xIq4dnyVY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB2802.jpnprd01.prod.outlook.com (2603:1096:603:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 08:14:21 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 08:14:21 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Topic: [PATCH v3 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Index: AQHYZQVtPYCoiRK5X0qgXNrhfCN9w60ZQz8AgAAExjCAAAX6gIAABecw
Date:   Wed, 11 May 2022 08:14:21 +0000
Message-ID: <OS0PR01MB5922A4E4B929FC28A025A1AD86C89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220511070443.30231-1-biju.das.jz@bp.renesas.com>
 <20220511070443.30231-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdWNP_H9FNcygXZp0Ysw=wGXzV71Q_U7Hs=wH_Vctnz1pg@mail.gmail.com>
 <OS0PR01MB5922FF4C6F417DFF1C3BED5186C89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdW3+HG+7JXBH2CjwK8GM5frKyP-kbXL1JXUD9R8j2MYkg@mail.gmail.com>
In-Reply-To: <CAMuHMdW3+HG+7JXBH2CjwK8GM5frKyP-kbXL1JXUD9R8j2MYkg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6266e9b4-c205-4dee-9e28-08da33264099
x-ms-traffictypediagnostic: OSAPR01MB2802:EE_
x-microsoft-antispam-prvs: <OSAPR01MB280233367874EBDD9315D68086C89@OSAPR01MB2802.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIJ3PmPOgARGjqVGsgm16jTGDW5Jko49bR7aR3XNlxoSylvemk7D7/mfYgdGzgIi0cwE4mN0lsY9w0iB9d7uEOSQL3+o25EAGZPx7/AIIl05GtyTj9oIS+T+pjhJmnRWXySYxtxkEicL3tnfKi8UUaRKZQ+85wKV68hnh7chtRum24zQkukyOo6kyn4qcC7SHaJD3fwF8KIHsUhZIFgJzgpbVVGIi+RrIOWDJAXKFO8y/xoYVQSDWwKIGJ1ME3FxwOIK1Xq32vj2qf5ghpNknHAXc8U5yORKyaIth1A6JktsQ5+FplvghYTbP44MUgDd+HwX2K2DT2M+TmI79f0uCeaD+tHFYhC+xOVhFENLogylbk3xKF56XlsDzLKwSrASs1sm8X8iDSZFGWLAvLJvrLQlzv05aR++Swy/im9ed1nX0ZyyFh6uDO9b3YEHMHihPoTiHg6+ePAumQlquO8w6zDcH/lKGOiKVZ1liNedZo1Lkavlf3AAOSeZy/uIdQtlhmYVIcBO1nnDQT6fJ65KbSdWad+UGqKtGK2u4+nQvdU8oXwkmFBHAVUE5eTlR0YysF4poxWKDv2bIlxuL0Vh1f1YmvXmYtZMenyRERw6efMf0tN4wIHXeu4a1P+hFPDwpghFTBLyPQbE6tgEqlxNERQvPhWX66gEjnb0aEB9DnsQEMSI66jXAv7+mDjx9TUJx9AM2wrnXfIkW5zI7AUJ9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(66446008)(8676002)(4326008)(38070700005)(9686003)(64756008)(26005)(2906002)(7696005)(6506007)(53546011)(8936002)(508600001)(52536014)(66476007)(5660300002)(33656002)(55016003)(54906003)(83380400001)(86362001)(186003)(316002)(66556008)(107886003)(122000001)(6916009)(66946007)(76116006)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVV3SnVGTFNwcFZzLzFpUGpUQjZPZUNWL3EvYUpXemhLNmoyRFpGMGp6ZDlm?=
 =?utf-8?B?V2VXeGxpSml1NlNsam1uMnpqS3ZjLzhTS1dYengrcW9jdGdTWm5VMVhkMEpz?=
 =?utf-8?B?Q1NTZGhCbEhXVXViSWZ1YmN1QmZPYjBWMTJzcElFdzUrWHZSMTY4QU1HUmJk?=
 =?utf-8?B?bithMTJLVlcyZzNGa3dOaDNTbDdqVVlkN1RaS0srWjIyVUx5djN6UWZZTWFo?=
 =?utf-8?B?UXdPUU1lRzZERUMyMlMwTTJ4NThkMVRPS0wrOFR6MWNYYURyTS93NkRYQmZl?=
 =?utf-8?B?emdudW52MG4vVUZpS3RzM25Zbm83SlBmNWFIVzdRZ0NST1VZQkVOOEtYNUFO?=
 =?utf-8?B?cXQrUkdhSlNlUS9SZXNwbGJ1cGtYU0R5L1M4TkNqVmNuVkdoVDdIek9SUnBk?=
 =?utf-8?B?eHNFVklNZTFTT1hJS01ZdnBrajRxMlcrVElhU0pGYXZkM0V3U1JEblUxQ3g2?=
 =?utf-8?B?S0I4MWIyYmVWU3N3ZVlyd2wxYUgxdzdDMmJnTEdkVnlHb2tiZ05oWFFGRTBl?=
 =?utf-8?B?WjBXcWkxeERPSHVFWnlXNHRWSzBUdFJBbk1KS1Q1bE5PL2EzMUFEVDgwaDBj?=
 =?utf-8?B?aEZJR2VtT1Z2RmNVU1hudWh4MWN4VjlCWTRGQkFkR1Jxc3MrNnlpV2hFSTZi?=
 =?utf-8?B?N0h3alh4WHEwaEpoM2VES0hjOVBFdHB6NnFWZTNJUWJWdGhETlBQbXpjTUp0?=
 =?utf-8?B?Y25IVDJJcHZxQThKZm94LzdXbitGOG5uak4zMjlJUE0yTDlYazd1TEMyaW1X?=
 =?utf-8?B?TXZJL2NXdVFPalVmL0pydVoySGJBQUNma0Q2VTMvcllib2pHQk41b2ZxWUhi?=
 =?utf-8?B?dWFSOXY1cTUyWVYzeStETWFmdFQvdkhESzVhcEFKVWI1dU0rWkJualZwVnRG?=
 =?utf-8?B?bXdxQ3d4Ym9uR3pTck5Xa1FkVW9jOWtZK3pwd3BMSlR2VWhvK2JJZytvRVM3?=
 =?utf-8?B?SnpsaERObnJtcnp3ZjdubWthSFhma3J1V3F0aG5BNkRZMktNcmt2Qlo4U2VE?=
 =?utf-8?B?aXVkK1IzMHE4OWR2YVpqRWYwRS9ZVkxrSUVlUlZhN3FxUDYvRU1sTm82V1hl?=
 =?utf-8?B?aVlYMVJWb3I4QmM2ZGVTWmhTMDJJZDVMdTBYWjNickJXTS9LUUh1bTZHOEwz?=
 =?utf-8?B?SFdNR2N1ZGRoNEM4SlJrMWhmaTAzbitzWlIxRHdmU2JIYWgzd2wyb05CSGgy?=
 =?utf-8?B?bWhteXExbjh3aGhCaVJXU2cwYmJ5U0hEOXg1eW03cmF3ald2UytUZUFXUzhv?=
 =?utf-8?B?ekVPczhockxPbUxGK0M0Y3I2RGZDWU85UXh6NktDMDRENWFmdlJ5TVVGTm5W?=
 =?utf-8?B?Z0dXS08rVldxNjQwZlRiYmlhaHZzZ2xTT3lJN2h2MGtpSE1CWm52ZnhnMEtO?=
 =?utf-8?B?b2hiK2tqdkhkWWdSakp0RE5lemtnUWRKRUo4KzlLNGR2MDAzbjZhdTNUd0lV?=
 =?utf-8?B?c2NSaU9MWTlKOHE4VUMxT0xsTnVSRjdyUUszNDlxeVByMVd2ekpUZjJ1QWtv?=
 =?utf-8?B?NnRzZ3pVYWJvL0hyQUt6dHJXTnIzenB6bXlvdVVRSWVCZWh1dG9kQlJId21P?=
 =?utf-8?B?d2NjSFNEbEwxWHBuYjZVYTRMTTNVbWVpenFxNXRMdUhuNU1rd3oraVFpdHhn?=
 =?utf-8?B?VzZkczM1bUphc0VDWTBkV3BHQ2RFckZHdVVoeHUrTzQvQVVheXRlcHRuSUNC?=
 =?utf-8?B?M3hleHlNYzVNRnhITlNsZ1o4RVdGd0RsbTFqVFFMc0tHdTRmQ3NhbWJWVjE2?=
 =?utf-8?B?K1hqZi9MSkRIOFBuRlVsS0l2dUhydUI2bUhIa21LYTRGUEdWL3VOKzl5M2Fj?=
 =?utf-8?B?cHRaNzRJb3RwY2pZTHlhamRpdGJ6aUV3MElyRHFLbm1VWVZidVRUc1FwcnhM?=
 =?utf-8?B?VXh5UVk5dFBMUmtlNEQrcDBJelhQUksrRDN6ZGd2RnZVbnd4eUFIbXNJZUtF?=
 =?utf-8?B?cVNYVGJiN1hraXNFSms4RkoyNEJpVkFyUXR3RWhadzZ6VmpJRTE2bnN6aG1u?=
 =?utf-8?B?ckpSY2s4T25ZTmZwdjNWdm01a3NyRGRabVNOd0RUa2d6Y1RRQjZzZk1ZbWd2?=
 =?utf-8?B?eTBFYVMveUFzZ0o4WXJMc3lGc0p5VzRCbVF1NmswQkd0MjFwR252NEJ4Qkow?=
 =?utf-8?B?SzJ2eVJXVEVVY3U5clRNb016RW9NUkViMkZ3Rmh4NUp3QjZoTlIzdEFydnph?=
 =?utf-8?B?Rk1RVk0rTkZvb3hGZ1hHaWs2dFJOUFNSekRHdmpwOXlwS3JvSHdoOXpJQzlP?=
 =?utf-8?B?Y0RENHFuWGxUMzVCYlhJc1hDQXVEaUZ1aTl4bXoxZjNQTGY0elRuM09YamtP?=
 =?utf-8?B?bWY4Y1ppT053blp4RktnbmVoWmVKclpnemxVajMvTTk0a2daeXRUcGpxUXhR?=
 =?utf-8?Q?ac3YNxq4SOb3wjyA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6266e9b4-c205-4dee-9e28-08da33264099
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 08:14:21.1617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iG1ywGdViqSq5Q+nHFavjCpiCidA2nzWOcNV+4CIiJh+t8BlmGIF6eHEKI37RBKtwnDve4+xhBYOq0484DhVG0nUKEIsxsxReU2FCkJiDYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2802
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgMS8yXSBkdC1iaW5kaW5nczogaWlvOiBhZGM6IERvY3VtZW50IFJlbmVzYXMgUlov
RzJVTA0KPiBBREMNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBXZWQsIE1heSAxMSwgMjAyMiBh
dCA5OjM5IEFNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6
DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gZHQtYmluZGluZ3M6IGlpbzogYWRj
OiBEb2N1bWVudCBSZW5lc2FzDQo+ID4gPiBSWi9HMlVMIEFEQyBPbiBXZWQsIE1heSAxMSwgMjAy
MiBhdCA5OjA0IEFNIEJpanUgRGFzDQo+ID4gPiA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gRG9jdW1lbnQgUmVuZXNhcyBSWi9HMlVMIEFEQyBiaW5k
aW5ncy4gUlovRzJVTCBBREMgaXMgYWxtb3N0DQo+ID4gPiA+IGlkZW50aWNhbCB0byBSWi9HMkws
IGJ1dCBpdCBoYXMgMiBhbmFsb2cgaW5wdXQgY2hhbm5lbHMgY29tcGFyZWQNCj4gPiA+ID4gdG8g
OCBjaGFubmVscyBvbiB0aGUgUlovRzJMLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9yZW5l
c2FzLHJ6ZzJsLWFkYy55YW1sDQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9paW8vYWRjL3JlbmVzYXMscnpnMmwtYWRjLg0KPiA+ID4gPiArKysgeWFtbA0K
PiA+ID4gPiBAQCAtMTksNiArMTksNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiAgICBjb21wYXRp
YmxlOg0KPiA+ID4gPiAgICAgIGl0ZW1zOg0KPiA+ID4gPiAgICAgICAgLSBlbnVtOg0KPiA+ID4g
PiArICAgICAgICAgIC0gcmVuZXNhcyxyOWEwN2cwNDMtYWRjICAgIyBSWi9HMlVMDQo+ID4gPiA+
ICAgICAgICAgICAgLSByZW5lc2FzLHI5YTA3ZzA0NC1hZGMgICAjIFJaL0cyTA0KPiA+ID4gPiAg
ICAgICAgICAgIC0gcmVuZXNhcyxyOWEwN2cwNTQtYWRjICAgIyBSWi9WMkwNCj4gPiA+ID4gICAg
ICAgIC0gY29uc3Q6IHJlbmVzYXMscnpnMmwtYWRjDQo+ID4gPiA+IEBAIC03NiwxNiArNzcsNDMg
QEAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gPiA+ICAgICAgcHJvcGVydGllczoNCj4gPiA+ID4g
ICAgICAgIHJlZzoNCj4gPiA+ID4gICAgICAgICAgZGVzY3JpcHRpb246IHwNCj4gPiA+ID4gLSAg
ICAgICAgICBUaGUgY2hhbm5lbCBudW1iZXIuIEl0IGNhbiBoYXZlIHVwIHRvIDggY2hhbm5lbHMg
bnVtYmVyZWQNCj4gZnJvbQ0KPiA+ID4gMCB0byA3Lg0KPiA+ID4gPiAtICAgICAgICBpdGVtczoN
Cj4gPiA+ID4gLSAgICAgICAgICAtIG1pbmltdW06IDANCj4gPiA+ID4gLSAgICAgICAgICAgIG1h
eGltdW06IDcNCj4gPiA+ID4gKyAgICAgICAgICBUaGUgY2hhbm5lbCBudW1iZXIuDQo+ID4gPiA+
DQo+ID4gPiA+ICAgICAgcmVxdWlyZWQ6DQo+ID4gPiA+ICAgICAgICAtIHJlZw0KPiA+ID4gPg0K
PiA+ID4gPiAgICAgIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ID4gPg0KPiA+ID4g
PiArYWxsT2Y6DQo+ID4gPiA+ICsgIC0gaWY6DQo+ID4gPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0K
PiA+ID4gPiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ID4gPiArICAgICAgICAgIGNvbnRhaW5z
Og0KPiA+ID4gPiArICAgICAgICAgICAgY29uc3Q6IHJlbmVzYXMscjlhMDdnMDQzLWFkYw0KPiA+
ID4gPiArICAgIHRoZW46DQo+ID4gPiA+ICsgICAgICBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiA+
ID4gKyAgICAgICAgIl5jaGFubmVsQFsyLTddJCI6IGZhbHNlDQo+ID4gPiA+ICsgICAgICAgICJe
Y2hhbm5lbEBbMC0xXSQiOg0KPiA+ID4gPiArICAgICAgICAgIHR5cGU6IG9iamVjdA0KPiA+ID4g
PiArICAgICAgICAgIHByb3BlcnRpZXM6DQo+ID4gPiA+ICsgICAgICAgICAgICByZWc6DQo+ID4g
PiA+ICsgICAgICAgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgSXQgY2FuIGhhdmUgdXAgdG8gMiBjaGFubmVscyBudW1iZXJlZCBmcm9tIDAgdG8gMS4NCj4g
PiA+DQo+ID4gPiBJTUhPIHRoZSBkZXNjcmlwdGlvbiBkb2Vzbid0IGFkZCBhbnkgdmFsdWUsIGFz
IGl0J3MgZXF1aXZhbGVudCB0bw0KPiA+ID4gdGhlIGxvZ2ljIGJlbG93Lg0KPiA+DQo+ID4gSXQg
aXMgc3VnZ2VzdGVkIGJ5IEpvbmF0aGFuIG9uIG15IHByZXZpb3VzIHZlcnNpb24uIElmIHRoZXJl
IGlzIG5vDQo+ID4gb2JqZWN0aW9uLCBJIGNhbiBkcm9wIHRoaXMuDQo+IA0KPiBPSy4NCj4gDQo+
ID4gPiA+ICsgICAgICAgICAgICAgIGl0ZW1zOg0KPiA+ID4NCj4gPiA+IEkgZG9uJ3QgdGhpbmsg
dGhlICJpdGVtcyIgaXMgbmVlZGVkIG9yIHdhbnRlZCwgYXMgdGhlcmUgY2FuIGJlIG9ubHkNCj4g
b25lPw0KPiA+DQo+ID4gSXQgd2lsbCBiZSAyIHJpZ2h0PyBlZzotIHJlZyA9IDwwPiBhbmQgcmVn
ID0gPDE+Ow0KPiA+DQo+ID4gV2l0aG91dCB0aGlzIHJlZyBpbmRleCB2YWxpZGF0aW9uIGZhaWxz
Lg0KPiANCj4gSSBtZWFuIGp1c3QgZHJvcCB0aGUgIml0ZW1zIiwgYnV0IGtlZXAgdGhlIHJlc3Q6
DQo+IA0KPiAgICAgcHJvcGVydGllczoNCj4gICAgICAgcmVnOg0KPiAgICAgICAgIG1pbmltdW06
IDANCj4gICAgICAgICBtYXhpbXVtOiAxDQo+IA0KPiAodGFrZW4gZnJvbSBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXRhL3BhdGEtY29tbW9uLnlhbWwgOy0pDQoNCkdvdCBpdC4g
V2lsbCBzZW5kIG5leHQgdmVyc2lvbiB3aXRoIHRoZXNlIGNoYW5nZXMuDQoNCkNoZWVycywNCkJp
anUNCg==
