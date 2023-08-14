Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7511E77B933
	for <lists+linux-iio@lfdr.de>; Mon, 14 Aug 2023 15:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjHNNAK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Aug 2023 09:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjHNM7p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Aug 2023 08:59:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2091.outbound.protection.outlook.com [40.107.113.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B0FE5F;
        Mon, 14 Aug 2023 05:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOtPn0c5p/nC5Sc7Y+dPCBRhY9t0TEhdzSuRhlQr/YBuTk6YEMdZJLH4mbwatQBIMbMtZz5/pO11fqQPmCvLz6tROU2K74KJZ4LmRLuMgTjop9E3tOhO93MmUCNBi0T4DOqW+SByE0VqYVhAMb2oMyXmMibhvItKzqgYXAOP3C0Qi5HwJV2QHsp1DutpMudd1SkC6179d7ICdyZ983yZ0lBTzAcWYEQElQpVeOos3Lu4W8z9V6qBUJnc0FJVtPt2VLnszrPD/XJdMjaNdGtlz6Grf9K0qLUGzaxAuNPjqNL93qKkfxpl9Dj5HLC6sNfan6a/6kpzERhL8Sliu/VoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuhwzFzBp4qm4n8N6BQZ8E2rJB2ArqC93GxnwW8T4pk=;
 b=nndm1dbcbabQAyb2a1oqvJcTzt5cv7HbpzvbcaV0qPa+Y0udw1rqXOkKFbUhKnQYWqFh/8KTt98nPGAyAtJaA7ENEpUGFiI46SA49H+bl/xLg/mg8UhvWuBoUT+yt+qFF/c/61saUfXwu+UypQlugSiTbT7MMzk2YPvDivVSeilBy0mtUZ3D6gubdpHP4HkNJ1yabDOpyUeNM2m4RBANCBES6k9PGZrPchf0+YBkzO4MfTjnYz0i/5DyvzzVf0R+LERvFltZIXhFyMXL90ZouxfGMOjHTPCtNyJJ/Td+tRrCZjMBoqdXUJo5/spD5adJhxqpzDiJwEZVPW6IFidqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuhwzFzBp4qm4n8N6BQZ8E2rJB2ArqC93GxnwW8T4pk=;
 b=MFJvUi7aP8Jsero4/CG8UY0ZQvH2DcjYUkNJOb/wpjEaMIU4ui6XAspQhZzjPR27Yn44uqcK12nvoKzPmdWuXKZwYkPMjopC0iU2RVTSww9siqz7Hzz3gDLdAbRIxqeyhX34Qfwf48XksS+GntZHS5l80hSFMo97ZrdoP5qk9So=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB7841.jpnprd01.prod.outlook.com (2603:1096:604:1b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 12:59:39 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 12:59:35 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>, Peter Rosin <peda@axentia.se>
Subject: RE: [PATCH RFC/RFT] iio: imu: lsm6dsx: Use i2c_get_match_data()
Thread-Topic: [PATCH RFC/RFT] iio: imu: lsm6dsx: Use i2c_get_match_data()
Thread-Index: AQHZzPd9ppsd8VFLAkCyYP4LRjeoRq/pvImAgAABA9A=
Date:   Mon, 14 Aug 2023 12:59:35 +0000
Message-ID: <OS0PR01MB59225550148D422F22F81EFC8617A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230812083204.55346-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXbrh2B8-=v8NqQ2M-4hHqm-eVcO49-0P9L+=MMLLXchg@mail.gmail.com>
In-Reply-To: <CAMuHMdXbrh2B8-=v8NqQ2M-4hHqm-eVcO49-0P9L+=MMLLXchg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB7841:EE_
x-ms-office365-filtering-correlation-id: 1f8970c1-88e2-45c8-6385-08db9cc64f97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a0pyOaWSsSTzjeWoQ4gbq5GyiD1FrTspBv29U4mS8YcXRwVBePLhCqh5FejX27TCPPmlrKK0FUO6/rW7y1U0Mo/0RGJM5sHwBRY5Jf6deYAU6qJUliTgSZZEdrTvc3RieBkC4P1EAA44ug+HkmqqyDL9QtCBLnDMVRWN3HuGAphzzv2Zf0FMZfhb2ZYgHGFmAMZLKbly8LB4BnePV+zr0FJCfpPXyO/90y2J3U7AuZkOMyN+4/Fy1p027MJv7wjpp1p9XDLNb7AatvKJpNpRQ9RB2AA00ZgwXPdLQJy2JN/EC/StQTu5m/FWN2UBiLpxXwiGeySymRu12fsDojjuotMmdydg7dmW368TQenwuvmIugKQkNsPIpK9VOCGwNHFcADwDssBGDtmHI7F+7p+DJCpGArTVOAvjt4ObvkZ1bNSzxjiVmdZ4hCoT5IeWqSJY+VrbBiFNh92YiDYHhW069irnFK7FVY35Ymg8Q0AAk/0/2TwxM3gf2/W0RyTp+3ZxlHSlukWdCiXyoPIiF083gf6xmJQHRZ0oAd2ku9zLEtuiHe6qEnls2a4CxpZffo8PAIaykLG7PBA2RELqIsSU6sHRUL3XL1EFYXBJyBxxRZTj9L29XAevymZ2V/SezzY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(39860400002)(396003)(186006)(451199021)(1800799006)(66946007)(66556008)(64756008)(66476007)(66446008)(6916009)(76116006)(316002)(41300700001)(54906003)(8936002)(8676002)(52536014)(5660300002)(478600001)(71200400001)(7416002)(2906002)(966005)(53546011)(9686003)(6506007)(26005)(7696005)(4326008)(55016003)(38070700005)(122000001)(38100700002)(86362001)(33656002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnJvbTErNzhkMW82ZTZqdEx6aVFuZEZvVVZQZzl6VEJLSzBZaU56TG1WMzdF?=
 =?utf-8?B?U3Z2c2hnYjF0NVh2SVVkODJPaEd6bHg0K1d5cUFnWXJYczdxV3ltY1dUdnB4?=
 =?utf-8?B?S2dhME1JMkJ3bFRYM3Vmc1ZYUHZiL2hLOUdXRnFUYzRGTmY0NG50Vnl6U2cy?=
 =?utf-8?B?Nm9CMHhIbUdtQXNJaVg4NndyWmJGdWtFcmhMY0k5MElhaGdCRCs5eW1kbFpG?=
 =?utf-8?B?c1hQanNjejdzSXNYTU5ia1lNK01ROTU5WGhQcnBuN2R1eElrQ0FwZ1F2cU5E?=
 =?utf-8?B?UFJHRHdwT3laekUxclZmbjdSdFF4NzdlamUrNUEzNHBXL1JiYWd3QVJySlJD?=
 =?utf-8?B?MTd2Q3RvNW05ZnhHOUljanpYbHFGQytjcVZ5Q3JiWWl4Mlp1SC9IZUpxU2Q0?=
 =?utf-8?B?MTg3OUZDVUErZzJQZU8wYVZtMS8rMURKYVQ5cFlmWEcrbVNGd0ZrMU1sYmxx?=
 =?utf-8?B?a25lSmd1bVlNZlBUSHVXeUZjWlBINkZINExjdzQ1RnhhUldESzQvbTFlbUNm?=
 =?utf-8?B?K01LcGRYNDdwSUF0SGRuS2dFbmx1dW1zZ21ZYnlMUkVkZ2E3NGJrZTlhTEt1?=
 =?utf-8?B?RENJV21BR1E3MjRkOTJ3RzVHN1NqTXFvL0xDejhBNUZSYjFjV1FUNnhvNHpF?=
 =?utf-8?B?M0srQW5Id1BQNzBPa2JDSHNpeXFoMGlnWms5U0VnK3E4bkp3Nis0cHVpdHZU?=
 =?utf-8?B?RkY4cUdoNERLdEthaFVTd3ZQOUoxcUFDRmdacFJ4SkE5ZVRjNXVFSkNBcTA5?=
 =?utf-8?B?L0d6SXI4M1NsRlRtZHRCM2Q3QnU2V3NraFpOV0ZEbmpHWjFQaVBYRHhub0VD?=
 =?utf-8?B?N2NmR3FEdGExWjJJMWNBdjdKbXYvUUlWWThJcEJhNVlwR0Vpbi9INTU4eXFW?=
 =?utf-8?B?NmUxNnRvVG9RVlpCNWpCUWYzVllucG1mY0hJYWY2VStOYjVKMDJzMVUyQTJi?=
 =?utf-8?B?VUNLaXZkMEUwMDVFeGRKcU5VUSt0eGV4U01TMDh5eEhNcS8zQTUrKy90UnEz?=
 =?utf-8?B?aTVqaXpCeEcxNWhVZklIdzM1NHRhTFN3Z1hvM1hPQ1NyUWtVYTlxdTNGSURa?=
 =?utf-8?B?bklSMVFsVC90a1Q5cnhvdE5oMXZmRE1Zb0FxZUFySVhlZk1LT0JGaU82d1Zl?=
 =?utf-8?B?NTE4bHZYRkIxMFFXT1NUV3dpTjUyQkMxRjdNS0s1ZzlNcUxzMlh3TVJBWUhO?=
 =?utf-8?B?VkFJaDc5ZXg2TFBqWFh2MXcwaUJyR2pjQlBQeEpuanF2TFllRnN3aUpDa3lU?=
 =?utf-8?B?UFdwV29GODF0YTR6Z25XSWlFYjN0VndZU1plQjUwb0UrS3NJblNKTnVYNTY3?=
 =?utf-8?B?QVBNdnlLOGFqS1ZsSk1Cd1g5MG9aUDN1RkgvdjdycTN3WWRXS0NLbk1LV2V4?=
 =?utf-8?B?UnUxMnprc05FK3RoUGYxYTd6S3c4VTdBa2JvQlhCSkswZjNJbVdVb29weXk2?=
 =?utf-8?B?V2JwV0pTU0pySmZRVGJqUjdGMHJ2eTZIK1REL3RZRXVTUi9ieVZZeHZOaVJp?=
 =?utf-8?B?eUp5T01yelM1TXR6U25sck1ZZ2JVU29QcEg1YmMreFVqK1AzK0MrWWxlakUz?=
 =?utf-8?B?REdEK2dkN1ZJZnRteCtxbFZGZmhZVU8xU1N0NVBZdllXa0w3L1RaS3F3ZWxB?=
 =?utf-8?B?SmZaaDVtMXV1d29IWU1XZDVwUkg1U0ZHc1haRlBnU0U2TmJWMDdJYUVId2Y1?=
 =?utf-8?B?MnNvUUZXRWpIdVZFS2x5SlNMT2x0aWZWOEFuZUZOb2N6S29lbzdMNWJXWUdC?=
 =?utf-8?B?cXhJSEdkNEpFWCsvL0RyQjlpK3ozelgzWVBNRXFkNERiT0ZXQ3JWN3I3b0di?=
 =?utf-8?B?Y1R2dG1XVlJxbUI0WW9PTWsrK0N6UDc0ZU52VUhQU2dJNWEyZk1MZFpXUlBT?=
 =?utf-8?B?bEdncW9TRGVTQ1NiNnpnUTJNSmkxMnZSY2hSaFZwOFAxUlc2NXYvWnRLdTZx?=
 =?utf-8?B?RjI2dkc3VFdvU3dIUVNiVFBDcHdPcnd2TStzU0VNdHBReE5USlpONGxaeUhs?=
 =?utf-8?B?K05pd2pCWUxzZnQzWHdXSDE4R2lPMnhLNW4wYVViQklVRFlxS1BTTnBXekRk?=
 =?utf-8?B?TmE0YUk5V3ZWUDFGbmVRM1JVMnllTnFyWjFXbWZBY1pJNUgvY3d1cUdFQXdX?=
 =?utf-8?B?Q0x1MWVpa3FoTmJHSmE3MFpwOU1pUUM3aUlONmhLcmhrbjA3d0JTRzJxb3hs?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8970c1-88e2-45c8-6385-08db9cc64f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 12:59:35.5369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZlzWJexQGFO1txG7LHf8hVCQu22q5X36dlulFkDHtttIZbpo4/0DPFlYZnVrLF4Dn8iHwpUwGeMxfLrZeCvuS/SLHwCFU87bF1iqnGbDPd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7841
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggUkZDL1JGVF0gaWlvOiBpbXU6IGxzbTZkc3g6IFVzZSBpMmNfZ2V0X21hdGNoX2RhdGEo
KQ0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIFNhdCwgQXVnIDEyLCAyMDIzIGF0IDEwOjMy4oCv
QU0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiBS
ZXBsYWNlIGRldmljZV9nZXRfbWF0Y2hfZGF0YSgpIGFuZCBpZCBsb29rdXAgZm9yIHJldHJpZXZp
bmcgbWF0Y2gNCj4gPiBkYXRhIGJ5IGkyY19nZXRfbWF0Y2hfZGF0YSgpIGJ5IGNvbnZlcnRpbmcg
ZW51bS0+cG9pbnRlciBmb3IgZGF0YSBpbg0KPiA+IHRoZSBtYXRjaCB0YWJsZS4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4g
DQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+ID4gaW5kZXggOTExNDQ0ZWM1N2MwLi5h
MmRlZjQzNWM5YzIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vaW11L3N0X2xzbTZkc3gv
c3RfbHNtNmRzeF9pMmMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9zdF9sc202ZHN4L3N0
X2xzbTZkc3hfaTJjLmMNCj4gPiBAQCAtMTYsNiArMTYsMzAgQEANCj4gPg0KPiA+ICAjaW5jbHVk
ZSAic3RfbHNtNmRzeC5oIg0KPiA+DQo+ID4gK3N0YXRpYyBjb25zdCBpbnQgbHNtNmRzMyA9IFNU
X0xTTTZEUzNfSUQ7IHN0YXRpYyBjb25zdCBpbnQgbHNtNmRzM2ggPQ0KPiA+ICtTVF9MU002RFMz
SF9JRDsNCj4gDQo+IEFzIHRoZXNlIGFyZSBzaW5nbGUgdmFsdWVzLCBub3Qgc3RydWN0dXJlcyB3
aXRoIG11bHRpcGxlIG1lbWJlcnMsIEkgc2VlDQo+IG5vdCBtdWNoIHZhbHVlIGluIGFkZGluZyBh
bGwgdGhlc2UgdmFyaWFibGVzLCB3aGljaCBpbmNyZWFzZXMga2VybmVsDQo+IHNpemUuLi4NCg0K
T0suDQoNCj4gDQo+ID4gQEAgLTIzLDEyICs0NywxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJl
Z21hcF9jb25maWcNCj4gPiBzdF9sc202ZHN4X2kyY19yZWdtYXBfY29uZmlnID0gew0KPiA+DQo+
ID4gIHN0YXRpYyBpbnQgc3RfbHNtNmRzeF9pMmNfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNs
aWVudCkgIHsNCj4gPiAtICAgICAgIGludCBod19pZDsNCj4gPiArICAgICAgIGNvbnN0IGludCAq
aHdfaWQ7DQo+ID4gICAgICAgICBzdHJ1Y3QgcmVnbWFwICpyZWdtYXA7DQo+ID4NCj4gPiAtICAg
ICAgIGh3X2lkID0gKGtlcm5lbF91bG9uZ190KWRldmljZV9nZXRfbWF0Y2hfZGF0YSgmY2xpZW50
LT5kZXYpOw0KPiA+IC0gICAgICAgaWYgKCFod19pZCkNCj4gPiAtICAgICAgICAgICAgICAgaHdf
aWQgPSBpMmNfY2xpZW50X2dldF9kZXZpY2VfaWQoY2xpZW50KS0+ZHJpdmVyX2RhdGE7DQo+ID4g
KyAgICAgICBod19pZCA9IGkyY19nZXRfbWF0Y2hfZGF0YShjbGllbnQpOw0KPiA+ICAgICAgICAg
aWYgKCFod19pZCkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiBT
byBqdXN0DQo+IA0KPiAgICAgLSAgICAgICAgaHdfaWQgPSAoa2VybmVsX3Vsb25nX3QpZGV2aWNl
X2dldF9tYXRjaF9kYXRhKCZjbGllbnQtPmRldik7DQo+ICAgICAtICAgICAgIGlmICghaHdfaWQp
DQo+ICAgICAtICAgICAgICAgICAgICAgaHdfaWQgPSBpMmNfY2xpZW50X2dldF9kZXZpY2VfaWQo
Y2xpZW50KS0+ZHJpdmVyX2RhdGE7DQo+ICAgICArICAgICAgICBod19pZCA9IChrZXJuZWxfdWxv
bmdfdClpMmNfZ2V0X21hdGNoX2RhdGEoY2xpZW50KTsNCj4gDQo+IGFuZCBiZSBkb25lIHdpdGgg
aXQ/DQoNCkFncmVlZCBmb3IgdGhpcyBjYXNlLiBUaGlzIHdpbGwgZml0IGhlcmUuDQoNClRoZXJl
IGlzIGEgZGlzY3Vzc2lvbiByZWxhdGVkIHRvIGV4dGVuZGluZyBkZXZpY2VfbWF0Y2hfZGF0YSgp
IHRvDQpidXNlcyBbMV0NClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA4MDcy
MDQ1MDUuNWYzZjI0NWVAamljMjMtaHVhd2VpLw0KDQpTb21lIG1haW50YWluZXIncyB3YW50IGxl
Z2FjeSBlbnVtcyBpbiBJRCB0YWJsZSBhbmQgcG9pbnRlciBpbiBPRiB0YWJsZS4gVGhlcmUgd29u
J3QgYmUgdW5pZm9ybSBkYXRhIGFjcm9zcyBPRi9BQ1BJL0lEIHRhYmxlcy4NCg0KU28gaTJjX2dl
dF9tYXRjaF9kYXRhKCkgYW5kIGRldmljZV9tYXRjaF9kYXRhKCkgd2lsbCBmYWlsIGluIHRob3Nl
IGNhc2VzLg0KDQpPbmNlIGNhc2UgaXMgaGVyZSBbMV0NClsxXSBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0L3RyZWUvZHJp
dmVycy9paW8vbWFnbmV0b21ldGVyL2FrODk3NS5jP2g9bmV4dC0yMDIzMDgwOSNuOTM2DQoNCkhl
cmUgbmFtZSA9IGlkLT5uYW1lOyB3aGljaCBpcyBtYWtpbmcgaXQgbm90IGJhY2t3YXJkIGNvbXBh
dGlibGUuDQoNCkJ5IGxvb2tpbmcgYXQgdGhlIGRhdGEgaW4gT0YvSTJDIHRhYmxlIChwb2ludGVy
IHZzIGVudW0pIGluIHRoZSB0YWJsZSwgaXQgbmVlZHMgdG8gcmV0dXJuIE5VTEwgdG8gbWFrZSBp
dCBiYWNrd2FyZCBjb21wYXRpYmxlLg0KDQpDaGVlcnMsDQpCaWp1DQoNCg0K
