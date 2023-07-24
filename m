Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC875FAB2
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjGXPXP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jul 2023 11:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGXPXO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 11:23:14 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2126.outbound.protection.outlook.com [40.107.113.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748501B3;
        Mon, 24 Jul 2023 08:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ru/f5p5D+oWTqhz8Utdc4M1yd6F2CrxjuupB4eBHHGGbm86xHcYKoDE11mbTyiC18oHXQ5lt1siez9NSIRmHnr7prPBpwLY130MFkbKoHCjqTCd8/FoRvn3WUM95o0mn+x4hkDW2Y5TfJpaZrovMamHNgfT1EKTXvYhndMV7/gKHWWQwSv3upa9ZZLEmjYe/wVY7qy+9GgO1nmlH9XgVHaxs+zCNZEWfRFWMrshtpUbttDz+pGZDoo5lmzw4GXCTTkDJOE0qKb6aOyXBWP1Hb2ck1RDVOXVXG4MoRU6lpnK3bpPl3gySTJLz9Ufav6yUSvsG/htSPcyWD6wdSmxj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhPxO4gJ9EH/dml6Kjb+g09cTV4ih5tkOUcx7P6H4NI=;
 b=Xu77fi491E2LITrLLUmG9wDBhlh6ckqBJO695BIjt39frbkeSy1qcWRyEVfCUMsQK/6bUDqiU1rhhY5M8am3Q2n5QXl0hVTf8qpeTpyCGnKORuEq2ScWa6xeKyoyunbjmCE1gNJKGsXpgRtNDITmN6tycHun48t3UyfEwLW1rrN0soaRFTAK7ekiteeeSgNvHFImeV6wvNtTnJ7xspmRRbW/SacNubPhj48ropximFGezs0jDli/kYZbdRu4ETseHEvhHvz9ZHMhyhn4jxE+Nyubsd/P2xzAF5iUif9PTl4A+aHvJtXiEdh8pkKEb4RI3QqHnNoPPaEpMJ6eJYEMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhPxO4gJ9EH/dml6Kjb+g09cTV4ih5tkOUcx7P6H4NI=;
 b=qFK9Fn7/CJ22EUxx2xvscu0KEM4OXZGUY2tsFNboB9VP2RlEK9laqJ2tlwrV5+8vIo/UaWH5RoX2BfJxNuGxusUDF1qeuEnIPp4NpwY02ypw+xCN6JWdT2U9zSp8T6LLIhpu9M+aGJnktUkN7AIjDkDD+/bANjAkSyRbr15rgos=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5987.jpnprd01.prod.outlook.com (2603:1096:604:ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 15:23:10 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 15:23:09 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        George Mois <george.mois@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] iio: accel: adxl313: Fix adxl313_i2c_id[] table
Thread-Topic: [PATCH v2 1/2] iio: accel: adxl313: Fix adxl313_i2c_id[] table
Thread-Index: AQHZvNgku1XShbouQUqiZUidIs6gPK/JCAiAgAADhuA=
Date:   Mon, 24 Jul 2023 15:23:09 +0000
Message-ID: <OS0PR01MB59222767DE636E86BA3BE6398602A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230722200718.142366-1-biju.das.jz@bp.renesas.com>
 <20230722200718.142366-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdVWJyHB8zop-JpvOo1-xAkqUyjFk02v5JkeNFDaM4LUUQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVWJyHB8zop-JpvOo1-xAkqUyjFk02v5JkeNFDaM4LUUQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5987:EE_
x-ms-office365-filtering-correlation-id: 22c691bc-e1ea-4279-cfb7-08db8c59e377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xsGLbdTCnvJG/fYixZOTTQ15ViymoawDebqX6wr3OpOnPqn5eOHXx2mcLVw6Uw4gEYh9dDv3njhvs1VsjZOn21ha9gS8g/tk4HCKANDC9CaDfvM9NSggkVh4I7JLX2bMQYLl8IXcP3XYNxXa0VzETcSTiCtLU/2pNgtp70kWENu2p9eBX/HK3TRqCjMzv8gBuUFysAVzXzQmJfgPsoEwBZB5YAfEgzGZrBvpVuMoUk8pJNwMUWLvktABvxZebz6F/qvDdM/OA3iD7y55OUi7jzWPJ4HVakoMbAds7XKSZO5NkZeXJIEH0bRXLJbpnXZaMnBlSYnrYk7/wqrkkfhcn634PtwTfICM/EaVgGkzYvVtWXm7YSIQxE0aTJ0EazToLk4mVpO5pVPFKlXj7+sZvQA/0ntNngjWMR0yOD+fB/7PgVC9Ro4uXobbtTXJSdaYZHZ7cNGfs3JRmK1MGYzf8KMt9vyUVAk6mIklX8PM5W5jcc+J7+vVRnXXKkHi95IV9x1xS+61kwRKB6mou6sCxp/D9qlgSCA+hKR5dylSfnfj3z0ULjLzQgBta3sikvjXet9AXwk0I+Rs0aHFDtd/VdjA4SdVn33wM2AGy2CYqLqdjLvGvDtSx+A4PvFGA0OoLfnR1h96PPeABrjssXuisg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(38100700002)(122000001)(55016003)(53546011)(83380400001)(8676002)(8936002)(5660300002)(52536014)(478600001)(54906003)(6916009)(4326008)(66556008)(66476007)(64756008)(316002)(76116006)(66946007)(41300700001)(186003)(6506007)(71200400001)(7696005)(9686003)(66446008)(4744005)(2906002)(33656002)(38070700005)(86362001)(70780200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHFaRmtnaGJnLyt4ZmZ3amNSQ29jbzN4TG9CanZZRkUrNmlvWSt3TTF0aXB5?=
 =?utf-8?B?eWJ1cll3OVJzdTZOT2J1Z3MzaUdyVFg3NWk0VElnRGlLNnEzY3EwYWlZb1B4?=
 =?utf-8?B?RlBYbGVZbjdEZHZMS1AwNmJjdVV4a3ArNDkrUnEzMHJXdnNrY1RJK2tBNnNl?=
 =?utf-8?B?R2FpSG1TeDhUN1VMOWxXejFFTjNqSytnYTE0SGlzdDllK2R2ZUdhUFV4dEdu?=
 =?utf-8?B?MUd0S0s4TDlkSkZGZGZPekJISzVKZUxuY3dkRW5SaEVROXpNNnBkZkRhL1dG?=
 =?utf-8?B?d0sreVFCRVliZno1WlhjazRzMzhxSy9vN1dqWU9jazZWNllRNnNLd2JlTFVP?=
 =?utf-8?B?Y1A2dmpVejFBSzJrZnFvekl6U1Z0T0JsTnhCdUVWRVZ1dzdnRVhwZ1FMWm5E?=
 =?utf-8?B?clVadDFveG5TY0tMME94VEorMnNFeFhSWEhQdmFJRTdOdGoyMGJxK01wOEcx?=
 =?utf-8?B?N0tWT2x1RllieExrZFFQN1FjK3Q2WkFkaDV3Ti9peEI5WlJaN3R5MnM3TmZ4?=
 =?utf-8?B?YzBZZjBqMFZhcWkwRU4xcVNUU3J2cnBGK05LZ3dPOFlKMWh0dE9WRHBpaEJT?=
 =?utf-8?B?UlRtZkY0Y1JXalF4cm1KN0RCc2l0bG5LL21LSFpuY2RBY24yN2t0cUlUejR0?=
 =?utf-8?B?VnF5SkpyVzU3Tyt6blQ3amhXVU02cVZCZnBUOEMxM1krZ3hLRU4yRkFuTzVL?=
 =?utf-8?B?cDdzTzVjb1VRbGN0a2p0TmZoMjhCbEd1NkN2SHB2d2V4dmgzZUFFQnhXVGJJ?=
 =?utf-8?B?cEpLSThRSHlJd1FZcW1QeWpWSUZ0cXViektxVTRWb0YwRHJTTUJWclJCYTht?=
 =?utf-8?B?ZmZKZ004Sy9NSTdOK0J0S0V2ZmFYQk5rN0ZIYjJDSXBhUGxNLzJaN1V0Uy9B?=
 =?utf-8?B?cjEwZmhUNnc5YkRNZW5PVXJVdlhocmEwRUpQSytpazdNQjlzZloxUk40ZURo?=
 =?utf-8?B?ejFOQUNTZFlmMzVHdDRFa1dLZEkzdHJQZmNwcTluTU1mZFpJM2k0emlzenBo?=
 =?utf-8?B?VUQ0WlpiNDBhZStTVzFpVEloQU9jMWdtdnFwaXdDSTRBSHk4MDVmWEE3djVQ?=
 =?utf-8?B?dUZZaVY3NGFpemNYOWNISzBmRHJhNlkwZGd6VUJNclM5ZTFyRHh0ekZUOHZK?=
 =?utf-8?B?Z2IrSkNqNGo5LytUVEgwek81aVhFS3ozYkdRYWFYVkl2WG5Eclp6VmZxdHdY?=
 =?utf-8?B?VnJPQzlZaTlyS1ZXQllZcjdGTmF5N3Zvd0drbHBwZXpOdy8wRU52dGtybXNK?=
 =?utf-8?B?Nm5hanE0QnRVYmZBZ2gwVGFVY0JQdG05L0wxcTk1UUlYcGxpamZZL3A4MXI1?=
 =?utf-8?B?R3Rjb0IxRnA2Ni9KczlWMDNQYUNpaFpkbUVuS09YWWJjc2d3STFiekxVaDAz?=
 =?utf-8?B?ZnVibU9VeEVJQkF2anNPdjVlTnRxbHdyN2lzR1FCc2lFYkt5M3pmQ3lPMkQr?=
 =?utf-8?B?a1B6b1Z3MjNEZC8ydXlPYlpPV0J5cWQ2amx5WjRoM25jV1ppa0loaldsV01P?=
 =?utf-8?B?Z2ExejUvaWRSVGg5SGVTczZKeVpSR2Myam9GTEJudk5KN1dPVHlkQm1kc1FZ?=
 =?utf-8?B?NVdTKy9hb3dqQWRnWEtGQVVYbEV1eS9hRXFQQlFlaWwrQ2tiQ1lkL3BVL3E5?=
 =?utf-8?B?eURQSUNVQ3crd3hNbFQyczF2NkR2UDFGbzhpL0xlOUtTVlVkaFRmeEVYRGpq?=
 =?utf-8?B?S2ZaUXhaTHV2N245VldNcDR4YjdjWDdXT2krdVVRS091dnNtbXROOTZpU210?=
 =?utf-8?B?WWt0bkVtTkxSaDdrRUVwZTExZ24yVTZNeTFHWnpmNXdzRWFuUnJsWFFGWHVP?=
 =?utf-8?B?RGpmMzlSMG4va0VMQ0YxSjZCZG8xQlJqRktZektWdzRmR3lrKzdkQ3UyWTVM?=
 =?utf-8?B?YWFXRlBDR1V4c2l6ZTFnRjdsd0xuTkFlVnkxQjdCUzh2TXM0cEd3WDBlVDly?=
 =?utf-8?B?bUpBckdNNmhzV1RoQW8rUk9JNTZSUXlOZ1dQdWE5ZHYyeVZRMnZCeTg3OUVk?=
 =?utf-8?B?Y0RuNGdZUm9FcWNvbit5TGVzZFBjUXgyUWZXRHVYbWZGNHdMR0cycGxKTUt0?=
 =?utf-8?B?bTZWQTNoMjErUXBYMUYxWFljbFpWbjlHTzVYTzBqbjEvWHJTWSs3WWl2bmxq?=
 =?utf-8?Q?MFSg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c691bc-e1ea-4279-cfb7-08db8c59e377
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 15:23:09.9130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ektFNpsvGF/ZCLiEfVDmXbQBiKr2RXWwc693uRVE6QCOFqMM2WZe/qiZnpSuLGyQwclaezzdw59FXCP0mOx8JF4rexmNVzE8K8Soaxn128Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5987
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMS8yXSBpaW86IGFjY2VsOiBhZHhsMzEzOiBGaXggYWR4bDMxM19pMmNfaWRbXQ0K
PiB0YWJsZQ0KPiANCj4gT24gU2F0LCBKdWwgMjIsIDIwMjMgYXQgMTA6MDfigK9QTSBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+IFRoZSAuZHJpdmVy
X2RhdGEgaW4gYWR4bDMxM19pMmNfaWRbXSBmb3IgYWR4bDMxMiBhbmQgYWR4bDMxNCBpcyB3cm9u
Zy4NCj4gPiBGaXggdGhpcyBpc3N1ZSBieSBhZGRpbmcgY29ycmVzcG9uZGluZyBhZHhsMzF4X2No
aXBfaW5mbyBkYXRhLg0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPGpp
YzIzQGtlcm5lbC5vcmc+DQo+ID4gQ2xvc2VzOg0KPiANCj4gV2h5IG5vdCBhIGxpbmsgdG8gbG9y
ZT8NCg0KT0ssIHdpbGwgdXNlIHRoZSBsaW5rIHRvIGxvcmUuDQoNCkNoZWVycywNCkJpanUNCg0K
PiANCj4gICAgIENsb3NlczoNCj4gDQo+ID4gRml4ZXM6IGE3YTFjNjBiYzRjOSAoImRyaXZlcnM6
IGlpbzogYWNjZWw6IGFkeGwzMTIgYW5kIGFkeGwzMTQNCj4gPiBzdXBwb3J0IikNCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBS
ZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4N
Cj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAg
R2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2Yg
TGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtDQo+IG02OGsub3JnDQo+IA0KPiBJbiBw
ZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2Vs
ZiBhIGhhY2tlci4NCj4gQnV0IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0
IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nDQo+IGxpa2UgdGhhdC4NCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
