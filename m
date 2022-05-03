Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD13517D78
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 08:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiECGhC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 02:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiECGgw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 02:36:52 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2116.outbound.protection.outlook.com [40.107.114.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9421F3BBC6;
        Mon,  2 May 2022 23:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=invQZIWsSfISelZ+suN5+/FJ8/UW83Y40ss0XNYR7wdeDINXuF3xH/DQ5p3Dwr+UhhauCIgINitJud2tqzV4YZJoZCAO9pdzPLlwjmH9mUmO4ODw+jwbij86503oxoR3/d4GzeYi/Jj+oyke6+gj30whX+vWVK4OC79YXdqbn9EN4z03pwjM+BtKyBRzNhcA524URhRUuoD8gyr8q/4qF+G1l+83DqJk/cPZYW1DZcbgUzjgl+AwcJW/gKlaEk9lHSU6c9sNOEAIbfOixG5gI4FnxvOctG+4QG8FsxhMn8H2KUprVtTmlRlMvF5ZtkDrPRSfhmEZc5wZonwY2PjG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7A3qoE/N0LwrOPMuUGoZCIP0rf1ubkV62mA5aJ67YE=;
 b=bdvxnsq0i3t4njWryNgE1OTBkfq8W84P+ToTUgIsI6t+Ipkm6w1JY44o/x9qVHVYi0SHl4fOuCIlz05qjf3ncX63rNnbQsrEu/UFDlXfUMOAXkJ7C2RrlEINMgDgykldBBNh7ojYP3GjtMcME1T2lttXVTQOBdZvJIVDURpgewgvacbfqfrvfQhnzr2OgVa9Df0kSRJ5p4P7hcSyS4wW2l6Q+ngHkbldLHQ6Ok5M3NMYDeQoEEHIFNErIKj0E8ta/z3iJIl4iQ/YrYTTuXyNT3cvwH86DL2b+L2+wI6E7JVOpGF6IpmHS8Cgeu7ioMtg9mr0eAB83m6SACTlGFMTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7A3qoE/N0LwrOPMuUGoZCIP0rf1ubkV62mA5aJ67YE=;
 b=WckaEf7IyKDtd4NiKpmxGbzFd2udXz6Xhm4F7z1TTlwg6fq79NzF53XknAfWuvaQM3Dh+GYGIBlGJj8vVJVMEwNtoV5GwWEv1poXvy4pP/QRlbMmEfv771DPE/x29jYFcGRgh749V9xvPqrSQVeKUNNfwkkuSPSbvMR/gCRLDP0=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB4225.jpnprd01.prod.outlook.com (2603:1096:604:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 06:32:36 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1%4]) with mapi id 15.20.5206.012; Tue, 3 May 2022
 06:32:36 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Topic: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Index: AQHYXTOfd6MOv31HREqgoJEzHLjIx60K+TpwgAAlQwCAAIkKgIAANPaQ
Date:   Tue, 3 May 2022 06:32:36 +0000
Message-ID: <OSZPR01MB701947B40187981ACE6A271DAAC09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
 <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922CCDFA8C3648F49A10EB186C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWHemJn2KUBzYA8oVYgtG4sX2H=4-AdRuF0uZ2EgQEk6w@mail.gmail.com>
In-Reply-To: <CAMuHMdWHemJn2KUBzYA8oVYgtG4sX2H=4-AdRuF0uZ2EgQEk6w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e09caeea-5d4b-42aa-7d2f-08da2cceb689
x-ms-traffictypediagnostic: OSAPR01MB4225:EE_
x-microsoft-antispam-prvs: <OSAPR01MB4225350EA729F313815790C7AAC09@OSAPR01MB4225.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: niNXazkzOK270UDugi/a+DuWCcnYmPzWNKNufO8JK8DKLpmQZSTstuSleX1CSTaV+EIjgzKXdnrzp6iR2y8LQ2x/8lGxzozdyJJa3OuUcDX6e2AuUFIsRrpsOzhZBHGVCM0oU8dDHWPt4ivhcGmbLumbeBL+Gr5qkORxBoBVvHfe3GjiebHLeeGNPWlq1Dc6IJpIQapmsTnhYJmr95yShPtG5vWWfxSHfRtRZHMMQFN5WUmPob3QQ+cm2eBXIJUSSzsR6GbN/HZjthxK742VkxVszJKBB3YkHRpFhB9YpBMObe8LkkhEnr5Agc+C5YPbVup+Mx8vCivnHCnvneXAhDfDDVFEMMqxY0uiBbF0PlelY+DtXg4eqJOTad2TfMmx4kG83MkzCqOohgd9SZzobSzgFcMYTsp949Wq+7jiePq/D0SadI+UH8vhg95wnS8JYky1Xi3BkLrv8MeE8j9G3Yhd2GEZ+ZZ4pvJPuMsjEdnPME/0GECP6/x0OL2gcGDw6ELnbsT/BUQTwj9Yx6st2bs0lyiEryiiQyIRDcco4v433olfWRLzE0MMoW210HmL+vzOg677KSQmsLNAWLmiKeyvkRgJ0Vo90FcU0FaVJxwziFn+6jAPKgBK/ZEsEEfJau2m46CjP6Gy4gisuHBydD7DgBdaEnlygnOjrEUrII1iCYNouPKGm8VSsD6pbBLqSN07eLgTyj+LwGUCAeIjENhrxVfCTAg0GjF5RKlOasv4KFRzrW3lVsg6+5i8QNcimvw2pV2sGJ3wWKCcTvAIIn57h1GVu61m/kE98ROsZHU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(107886003)(6636002)(4326008)(26005)(110136005)(9686003)(5660300002)(122000001)(2906002)(66476007)(66946007)(55016003)(66556008)(33656002)(316002)(76116006)(54906003)(8676002)(52536014)(66446008)(64756008)(8936002)(53546011)(38070700005)(6506007)(508600001)(38100700002)(83380400001)(86362001)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlpaVHIxTGRBc3FsQlFJMXc2dzI2Y2V4Y2JEVXM5Q2Z2QlNReVJVVlhUTmdI?=
 =?utf-8?B?WWdUOWVlbHF3TGFiUkVFSGZFRlM3VTJvSHp0Q0VFT21xNGdVZWxWVnFGVm0w?=
 =?utf-8?B?RmRCZU9WYmp0R0l2REJ2dm1XSFRCZ1JMVVg4aWUzc05WMWtacXltYUkzZlYz?=
 =?utf-8?B?NXA5V00vL1RUTit0a0RjVGZ1RTlqdlNoRkcwNm5JQ0E1UW8yMFdGMXNUU3JU?=
 =?utf-8?B?dTJSMWxaUkFKUEM4MVRBdGs4SDdVVVFQWHpub0RqTDV1ZGFwZzNiQmh3RlR3?=
 =?utf-8?B?NkRIRTZSWktGcmh5SmlMMFFlYkpsNUhCSDZPaGlmTHVTQ0lZZUtrVVlMb21i?=
 =?utf-8?B?NHRLaVVpYzFES2ZVZlRyV1NLUWpiSHF6RUs1VVltZnpGZnFyZHROWndBUTZx?=
 =?utf-8?B?bzBSaGk2RFVaeHVPSlQ3UTIvWkZmeExmYm52czRMMUtQTW5RdlRFeDRFS0hY?=
 =?utf-8?B?N3pBTmZ5UGZrUGMreUthSjFXVkxWOGRBT25JVTV3L1VPWEVXdStxTXVVZEVu?=
 =?utf-8?B?YmdKNWtKV2xERzQ0R3R6blN2RDhXbzRWdzduVlVzb0MyZnNkUURwa1hFaUNl?=
 =?utf-8?B?REdJSFdiY3JuKzRQNy9PVmhsYVVHbG5oVTJVZGlUY2NHVElYNUtoS0RXUWpw?=
 =?utf-8?B?eW1wWW5BVFlUeTZNZDkycmNsMCsxTzRSRC9HanlPNXdBbmZSeVduelZYdVZ6?=
 =?utf-8?B?cDJ0MGhkMU00eGluSjcwQllnUC9hWmJqalFDcEd2em1OcVV0Zm9MckJ6UmpR?=
 =?utf-8?B?SGRaQlArQ2ZlTllqbURnaWRzRWl1Qm81MklxUmVSajFjRnhYakdvTWR6blVC?=
 =?utf-8?B?L2NLRXg2TmgzVG1BQlhPcTB4bTF6QS9rLzJJQTNyZEp4RUZaOGF3Mm9ibFo4?=
 =?utf-8?B?SHBNSGhwR0plZ3NtY3d0ZTh6MEVNUGFxR2daUm5zZDhLaXk5bDBjdHlJWnRY?=
 =?utf-8?B?Qm5neGhKWVUwWTV4anNWWGJlYXpGYmtNcHQyM3VoUU92OWVSNElQQ1dYcS9Z?=
 =?utf-8?B?L2hoUERQRjVGRmwzTGJUdDFBOHVwampBQmpJd2t5SDJ2VGl5VkdJckFsdDdv?=
 =?utf-8?B?QzJhTk1zN0t0Q29vT1g3NS9hd0UvWXQ3WTNHYng2QjNpWjFkYlMzVm5IUTBp?=
 =?utf-8?B?elN2UGZzVlorVFlwRHRCalRQVXQ5SlpxajBBL0RpK0UxdGZwcVdkTmNXMERx?=
 =?utf-8?B?bGJSSnphb3lYRFJGSGdrei9UT2s2MnBNSFM4ZDJMUy9vOGtZbXFHWDB1T0FX?=
 =?utf-8?B?cHpjOG0vbWJHQTNubnQxNThyTndVSHN0YWREVldESmVpTUptOXNWbWhtSVNE?=
 =?utf-8?B?UmN0eURvRXhxeTJNcFBGQnE1RzNmUkd0K2ZSWkw5ZUw1TmZsMUVOTWhtWjhF?=
 =?utf-8?B?MllvZ0ZMVS9CSHlUR0s2T1JiTWtra3hVeEJsZ3F1clY4SkcyZENlcXc5SHY2?=
 =?utf-8?B?eWZqTUNwSk1jM3hWZUNTQzkvaFI3UGdRRDJRSEpBenUvbEw2cERORVo3c1FJ?=
 =?utf-8?B?SlFHbnEyR1pHRWFOYlk1dVlqY1pHd1lyRDVQSTlhT1RIb0xZMU5LMnpOUlBX?=
 =?utf-8?B?Qks4Z2JKdmlyMGM5SWwwdEdpVTY5MEhvV3BIU2hmT0pCdnBzMklpNXlyeUlH?=
 =?utf-8?B?cCs5dU1mNVVyYjdRN01DeTMxWjNCR2V0S2hkTTd6eS8xb0lqbFRCcWc0RXV0?=
 =?utf-8?B?dXZEeDdvTmFmMXBXMm16eUgrNE1Vdzk3b011TGhrbGl3TXNFOG9PcnhZMjQz?=
 =?utf-8?B?ZEg3SGVTajhXLzlZV29haHFJWHp3WGxlRlpUZ3N6M1hRL1MrUDd5NWwreCto?=
 =?utf-8?B?bzdEaWQ4cmR2UUZiOEVUY056aU5MT0VtRm1XeDl5K3MyQTg1OXlnZnZ3VEdw?=
 =?utf-8?B?b2t0U2FCUTBHUjJYWlc5ZEpocVBOREdZbm4zdm8xZjVRZGZVdk1oa0o3cjFW?=
 =?utf-8?B?TC9sdzRYbFpHaENVdE5JcWNWQzZQN1d3WjJrMEg4emM4Y1YzbGtOaXZrSkpt?=
 =?utf-8?B?Ym1MUXNZUlpBK25xTXZKZDN0dEpPV3hZTnQxQUxxRXBsbHBUMjBxTGVqVi9x?=
 =?utf-8?B?bWdRUU13Ri9KL3loRTZLYkdhUUVzbGt1UUNEay9jZkI4VEJ5Wm9VY1R4WWZ0?=
 =?utf-8?B?QzZCM1JodGQ3dzRmOEtlRW40K3I0OWRYQU9IQm9xTnF3MndVcm5IWmRzWVdm?=
 =?utf-8?B?c1lkN1QxbFhaQStQbVQ0UmVReXNsWHoyUEUrVlEyVGI1T043WHFQY2p4a1Vt?=
 =?utf-8?B?a09ab1FacHNSdUhic1NxV3lnMXllWlBnQnE4ejdvbXhJS1BwMTVqdUc3V0Yy?=
 =?utf-8?B?Sk93UncrZ3ZjQkw0dmRibXhILytpckErejFBQTMySG83SmJxYU5CRHdLS2xN?=
 =?utf-8?Q?i6VQ/1qBElTqk28yMKgK60cOyPdemBZBE6EnI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09caeea-5d4b-42aa-7d2f-08da2cceb689
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 06:32:36.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ru8dEx8mEm1WbL5iRXT+KJTU8Xxgl3lY85IYx+XloqlNKro80FPA3xmIvoUWvBPM84gB7cm4G6ezcpcGe6tzGu+/9FS+UWsk3gB1ZQr8TEaFnOIeWYDpQWvuyMmLHGlU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4225
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4g
PGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAwMiBNYXkgMjAyMiAxNToyOQ0KPiBUbzog
QmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBDYzogUHJhYmhha2FyIE1h
aGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+Ow0KPiBK
b25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgTGFycy1QZXRlciBDbGF1c2VuIDxs
YXJzQG1ldGFmb28uZGU+Ow0KPiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1yZW5l
c2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmc7IENocmlzDQo+IFBhdGVyc29uIDxDaHJpcy5QYXRlcnNv
bjJAcmVuZXNhcy5jb20+OyBCaWp1IERhcyA8YmlqdS5kYXNAYnAucmVuZXNhcy5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGlpbzogYWRjOiByemcybF9hZGM6IEFkZCBzdXBwb3J0IGZvciBS
Wi9HMlVMIEFEQw0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIE1vbiwgTWF5IDIsIDIwMjIgYXQg
ODoxOCBBTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0K
PiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSF0gaWlvOiBhZGM6IHJ6ZzJsX2FkYzogQWRkIHN1cHBv
cnQgZm9yIFJaL0cyVUwNCj4gPiA+IEFEQw0KPiA+ID4gPiBTdWJqZWN0OiBbUEFUQ0hdIGlpbzog
YWRjOiByemcybF9hZGM6IEFkZCBzdXBwb3J0IGZvciBSWi9HMlVMIEFEQw0KPiA+ID4gPg0KPiA+
ID4gPiBBREMgZm91bmQgb24gUlovRzJVTCBTb0MgaXMgYWxtb3N0IGlkZW50aWNhbCB0byBSWi9H
MkwgU29DLCBidXQNCj4gPiA+ID4gUlovRzJVTCBoYXMgMiBhbmFsb2cgaW5wdXQgY2hhbm5lbHMg
Y29tcGFyZWQgdG8gOCBjaGFubmVscyBvbg0KPiBSWi9HMkwuDQo+ID4gPiA+IFRoZXJlZm9yZSwg
YWRkZWQgYSBuZXcgY29tcGF0aWJsZSB0byBoYW5kbGUgdGhpcyBkaWZmZXJlbmNlLg0KPiA+ID4g
Pg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNh
cy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9paW8vYWRjL3J6ZzJsX2FkYy5j
IHwgMTggKysrKysrKysrKysrKy0tLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+IEkgd29uZGVyIGlmIHRo
aXMgY2hhbmdlcyBpcyByZWFsbHkgcmVxdWlyZWQuIFJaL0cyVUwgY2FuIHN0aWxsIHVzZQ0KPiA+
ID4gdGhlICJyZW5lc2FzLHJ6ZzJsLWFkYyIuIEFzIHRoZSBkcml2ZXIgcG9wdWxhdGVzIHRoZSBj
aGFubmVscw0KPiA+ID4gZGVwZW5kaW5nIHRoZSBudW1iZXIgb2YgZWxlbWVudHMgaW4gdGhlIGFy
cmF5IHBhc3NlZCBpbiB0aGUgRFRTIGFuZA0KPiA+ID4gbm90IGFsd2F5cyA4IGNoYW5uZWxzLiBG
b3IgZXhhbXBsZSBvbiBSZW5lc2FzIFNNQVJDIEVWSyBvbmx5IGZvdXINCj4gPiA+IGNoYW5uZWxz
IGFyZSBwb3B1bGF0ZWQuDQo+ID4NCj4gPiBGb3IgbWUgdGhhdCByZXN0cmljdGlvbiBpcyBjb21p
bmcgZnJvbSBib2FyZCBkZXNpZ24sIGFzIFNvQyBpcyBjYXBhYmxlDQo+ID4gb2YgaGFuZGxpbmcg
OCBjaGFubmVscywgQnV0IGJvYXJkIGRlc2lnbiBhbGxvd3Mgb25seSA0Lg0KPiA+DQo+ID4gQnV0
IG9uIFJaL0cyVUwgU29DLCBpdCBpcyBjYXBhYmxlIG9mIGhhbmRsaW5nIG9ubHkgMiBjaGFubmVs
cy4gT3RoZXINCj4gY2hhbm5lbHMgYXJlIGludmFsaWQgZm9yIFJaL0cyVUwgU29DLg0KPiA+DQo+
ID4gVGhhdCBpcyB0aGUgZGlmZmVyZW5jZS4NCj4gPg0KPiA+ID4gV2l0aCB0aGlzIHdlIGRvbid0
IGhhdmUgdG8gZGlmZmVyZW50aWF0ZSBSWi9HMlVMIFNvQyBpZiBqdXN0IGFkZCB0d28NCj4gPiA+
IGNoYW5uZWwgZW50cmllcyBpbiB0aGUgU29DIERUU0kgYW5kIHRoZSBkcml2ZXIgd2lsbCBqdXN0
IGNyZWF0ZSB0d28NCj4gPiA+IGNoYW5uZWxzLg0KPiA+DQo+ID4gPiBAR2VlcnQgLSB5b3VyIHRo
b3VnaHRzIG9uIHRoaXMuDQo+IA0KPiBJdCBkZXBlbmRzIG9uIHRoZSBtZWFuaW5nIG9mIHRoZSBj
aGFubmVsIHN1Ym5vZGVzOiBkbyB0aGV5IGluZGljYXRlDQo+IChhKSB0aGUgbnVtYmVyIG9mIGNo
YW5uZWxzIHByZXNlbnQgb24gdGhlIFNvQywgb3IgKGIpIHRoZSBudW1iZXIgb2YNCj4gY2hhbm5l
bHMgdXNlZCBvbiB0aGUgYm9hcmQ/ICBUaGUgRFQgYmluZGluZ3MgYXJlIG5vdCBjbGVhciBhYm91
dCB0aGF0Lg0KPiANCj4gYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I5YTA3ZzA0NC5kdHNp
IGxpc3RzIGFsbCBjaGFubmVscyBhbmQgZG9lc24ndA0KPiBrZWVwIGFueSBkaXNhYmxlZCwgd2hp
Y2ggc3VnZ2VzdHMgKGEpLg0KPiBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcnpnMmwtc21h
cmMtc29tLmR0c2kgZG9lcyByZW1vdmUgdW51c2VkDQo+IGNoYW5uZWxzLCB3aGljaCBzdWdnZXN0
cyAoYikuDQo+IA0KWWVwIGl0cyAoYiksIHNpbmNlIHRoZSBTb0MgY2FuIHN1cHBvcnQgOCBjaGFu
bmVscyB0aGUgUlovRzJMIFNvQyBEVFNJIGhhcyA4IGVudHJpZXMsIElmIHRoZXJlIGNvbWVzIGEg
bmV3IEVWSyBiYXNlZCBvbiBSWi9SWi9HMkwgU09DIHN1cHBvcnRpbmcgYWxsIHRoZSBjaGFubmVs
cyBzbyB0aGlzIGhvbGRzIGdvb2QuDQoNCj4gSXMgdGhlcmUgYW55IChwZXJoYXBzIHBlcmZvcm1h
bmNlPykgcmVhc29uIHdlIGNhbid0IGp1c3QgdXNlIHRoZSBudW1iZXIgb2YNCj4gY2hhbm5lbHMg
cHJlc2VudCBpbiBEVD8gIm1ha2UgZHRic19jaGVjayIgY2FuIHN0aWxsIHZhbGlkYXRlIHRoaXMg
YWdhaW5zdA0KPiB0aGUgU29DLXNwZWNpZmljIGNvbXBhdGlibGUgdmFsdWUuDQo+IA0KTm9wZSBw
ZXJmb3JtYW5jZSBpc3N1ZXMuIFRoYXQgaXMgd2hhdCB0aGUgY29kZSBkb2VzIFswXSwgSXQgY291
bnRzIHRoZSBudW1iZXIgb2YgYXZhaWxhYmxlIGNoYW5uZWxzIGluIERUUyBhbmQgZGVwZW5kaW5n
IG9uIHRoZSBjb3VudCBpdCBwb3B1bGF0ZXMgdGhlIEFEQyBjaGFubmVscy4gU28gZm9yIFJaL0cy
VUwgaWYgd2UganVzdCBhZGQgdHdvIGNoYW5uZWxzIGluIHRoZSBTb0MgRFRTSSB0aGlzIGhvbGRz
IGdvb2QgYW5kIHRoZSBkcml2ZXIgc2hhbGwgcG9wdWxhdGUgb25seSB0d28gY2hhbm5lbHMuIEFu
ZCBhcyB5b3Ugc2FpZCB0aGUgdmFsaWRhdGlvbiBmb3IgdGhlIFJaL0cyVUwgU29DIGZvciBqdXN0
IHR3byBjaGFubmVscyB3aWxsIGJlIGRvbmUgYnkgbWFrZSBkdGJzX2NoZWNrIGFuZCBpbiB0aGUg
ZHJpdmVyIHRoZSBjb25kaXRpb24gc3RpbGwgaG9sZHMgZ29vZCAyIDwgOC4NCg0KPiBEbyB3ZSBu
ZWVkIHRvIGtub3cgYXQgcnVudGltZSBib3RoIHRoZSBudW1iZXIgb2YgY2hhbm5lbHMgcGh5c2lj
YWxseQ0KPiBwcmVzZW50IGFuZCB0aGUgbnVtYmVyIG9mIGNoYW5uZWxzIHVzZWQ/ICBJZiB5ZXMs
IHdlIGVpdGhlciBuZWVkIHRvIHVzZQ0KPiB0aGUgU29DLXNwZWNpZmljIGNvbXBhdGlibGUgdmFs
dWUsIG9yIGFkZCBhIG51bS1jaGFubmVscyBwcm9wZXJ0eS4NCj4NCkF0IHJ1bnRpbWUgd2UganVz
dCBuZWVkIHRvIGtub3cgdGhlIG51bWJlciBvZiBjaGFubmVscyB1c2VkIG9uIHRoZSBib2FyZC4N
Cg0KWzBdaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9y
dmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy9paW8vYWRjL3J6ZzJsX2FkYy5jP2g9djUuMTgt
cmM1I24zMzUNCg0KQ2hlZXJzLA0KUHJhYmhha2FyDQogDQo+IEdye29ldGplLGVldGluZ31zLA0K
PiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5
dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRA
bGludXgtDQo+IG02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGgg
dGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4NCj4gQnV0IHdoZW4gSSdt
IHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRo
aW5nDQo+IGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBM
aW51cyBUb3J2YWxkcw0K
