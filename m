Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36DC75FAC9
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 17:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjGXP3c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jul 2023 11:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjGXP3b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 11:29:31 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2131.outbound.protection.outlook.com [40.107.114.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46915E57;
        Mon, 24 Jul 2023 08:29:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDujaT6whWj85fp2L6C5N6eRNMUGtR0yEgqi+APDFzQ3rMWZVQ7aEelFZC86YwOQCT7M2tzdjnuddKh5mS+XKoUFhh+Yhp5b7/S74DXSnO4r4ykY21+a+GJiS4e4pjt8R6uCk4GwU3D7XNVMn2r6qHR539ImmKsdntMWBgDXVGS2c9LMWA2eaJtgbsM91LN0NYEa6gvnFDRsA/flXGjR5FC8xXrRfn/l2Q/wBt4X7IKDnpTe/ledCBXdq6jwtxqgtP4PC+cfUj83p4vvjqVW45ShojPgxEcAOCy5f0Tl2NI6/vVJBlwM6mx2M1cI86RRWamWoQ/MkUhI2eOV8BWKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yf8/o5Q5B/Zoy3VLGlEthSMDLdtodym0YaVmQTQyojI=;
 b=kTbRTpf8/YibAkBWNMTDvYCtOuH5fBo7JX226p9bNtyGxdJCVnuLUOh0hG+XHz6uBfVGfgBnvzxaCEXNOg+kf0nken6zFC0+jxRkQUwaGE/47eNCLt4a0n/xj7PNCmYMlhaJYTKxO5ng3gMMEHNci5zZ/excjXVYoMIXeU2Lqe5FHNKVlTL8Q0qc6gq4I44sjZjER7o4/6WnZMMqK3eci2m0r15yN3kB7Wv27s1fY5H8UgcxUd6C/yO5zsAs93Vmo7FWG9+dZ0UFqfIlJ9E+2ntoN/QzcKFWBvuB03hZodcAInCokbuf99IuYBm1mF8qhfOdyWOsrrP/X4nYtiGMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yf8/o5Q5B/Zoy3VLGlEthSMDLdtodym0YaVmQTQyojI=;
 b=NdGMOp31ZpSB4QRyIySqwvGg3r2xt5nDoZ2m7pbdgwmftKJM6g6wQ9xBbn0+BRHOT/w/8li7RlYkPjIQ0pwepPBX1ulSfQJwmFOFvqMoKqP55+nNBtfmCfqAKdcd4kN+0lxzdHVbkedUYMDw3+Q316KQ8D6JqzI+Voe1LK2u5sY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5826.jpnprd01.prod.outlook.com (2603:1096:604:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 24 Jul
 2023 15:29:27 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 15:29:27 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v2 3/6] dt-bindings: timer: renesas,rz-mtu3: Document
 RZ/G2UL SoC
Thread-Topic: [PATCH v2 3/6] dt-bindings: timer: renesas,rz-mtu3: Document
 RZ/G2UL SoC
Thread-Index: AQHZvhAAicAu8X/+CEe1ESg9j+rKoq/JCmeAgAAAYxA=
Date:   Mon, 24 Jul 2023 15:29:27 +0000
Message-ID: <OS0PR01MB5922AFE9A5C3E806A2D2EBBD8602A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230724091927.123847-1-biju.das.jz@bp.renesas.com>
 <20230724091927.123847-4-biju.das.jz@bp.renesas.com>
 <CAMuHMdW9XynFaOrvWZ50FYthQYQFYtyFMOTwPX_tzXK2bB=4HQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW9XynFaOrvWZ50FYthQYQFYtyFMOTwPX_tzXK2bB=4HQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5826:EE_
x-ms-office365-filtering-correlation-id: e88329c8-4efb-46c8-4269-08db8c5ac4a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OeoMggPJP5kfo/HtIDGi5jpSQwrhsQzVtzqpD04wBj9uTq1IUAn5ODkChAx4HsMMV+rsBexJgpHLJ202bz33Ai708H5dOXmMtsKm3rYGb7ODLi/BCOoyk/UEAkrTvioNYvW04isYGwiH3ld8bFBI/pS/rF3zw1zFGnc0yIAwhk2SVT1xuuS5Rp9v/7B6M61WGBObrqkvKfmVVqTK0Qgg4FmSNoebYK+7a9KgDglVi7ryOPvKkcUC9EFHM2+wMta3VPn7luYI0QOB5VcYoO1gMWbnrwuCrgvE99G/inThL2QdZ8Wti/gKb074nXWjNehZSiMu3cHmxe2ETca3KLOjQoAhXkvfLVHjxbAj9JP3W66pCzDWvpt237hU6uM6PvY6dWcrJO8aabnLA/Mci9R24Tz7oO+iA0c7dS7QkuBjWEzMMoY3+df+yrrZdbLsdpAK5fZBxTy/ALTMbEKKeKlbTnKRztuHgf7/mRlb75lYuiwO5LSk6NNmFGi17gPB6f3wYfetC6QvWM1mCsaiDIe6nBdnlZzCjbQs86R+x+En6u5V0XEfR8FtJfI6McaeVLdaBeoh6t6pRFGd+eG85cL5kFOL1bzXRKWteAywZ8TFFIEgTXyJ0dsm9zK7As2CyEy3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199021)(55016003)(7696005)(71200400001)(9686003)(478600001)(122000001)(86362001)(53546011)(6506007)(33656002)(5660300002)(52536014)(38070700005)(7416002)(41300700001)(8936002)(8676002)(4326008)(316002)(2906002)(38100700002)(54906003)(76116006)(66946007)(6916009)(64756008)(66446008)(66476007)(66556008)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXloVGFYVXF1M1gzZzdaWTRVdlJ6UmtVelp1UDNrYk93bDh0VUd5MzlyQlR6?=
 =?utf-8?B?R1FQZkpVT0VaV3I0VkU2dFp3TEovak9TcjZBeDJaN05JTXByeDVWczRYTzVv?=
 =?utf-8?B?UnYxWHFPdmJYWnpBemRYRklVMm52NllPTmlhNXg1SnN3dUp3SysyanU5bnlN?=
 =?utf-8?B?azQzZCtWWVFWRWMxWTFmZjZhZElsbHM5ZlJ4emtVRkpqTUxUdVhVNGF2eDkz?=
 =?utf-8?B?emh1WXRLd0J2UTU4SGExK0llY21uenhsRmh0TTBlaElaWTlWZ2l6SkdXM1lN?=
 =?utf-8?B?S0JucXEreHNpOEdTeXRhb05pR2xyT1B1ZDMzdU5XNSsyNTl1TDRoK0JDMXRV?=
 =?utf-8?B?NHFmalBCcDQ0NWJSd2o2RjBnT3JVU2VCZU9hWVRMdTR2dGUyMWkzOVBLWFEz?=
 =?utf-8?B?LzRwVXVQZ0EwYi9RY0xmRkIzL1JqZVgyb3NKM2VkUDNwd1IxWVA3L1A3em9S?=
 =?utf-8?B?L1AvZVY1SmJ6WSttY0pYcldQUDl1UTBGZncreVJRVi8vZWlYVExQK0Z5aTY2?=
 =?utf-8?B?RzJoNFVDZjlEMHVPNWFIRGYvOFIzUm8zMXNxT2dvVS8wK1BLYThEWDY5V0xF?=
 =?utf-8?B?VDF4d2pTS3dzeGw1c3NCS0p4K3NqODNhWHhSRngrRmRiTzh6V1l2a2wzS0xn?=
 =?utf-8?B?WlpZVG8xVTd5ak8zZDIvVm1reTl2MnNVUXpOZ3dhRjdmUDhLN25DYnVyaU8y?=
 =?utf-8?B?NmZYZmZuZ3A5SXhwc0M4Z2FEZTl0WjJTWG5FS2F6dk52ZVltMTNhNTFrdmd2?=
 =?utf-8?B?dUJLZ25lTFUrSDFReGZ5Q2dnL2xPK3hBM051NlRRemk1UDFlRUJ1OU91aGV2?=
 =?utf-8?B?c3h3cHdWYzdqM3ZKbE5LRkgwUjVYamF1d1d2Tm5PQkpQUUh0eEVINWdFbE1l?=
 =?utf-8?B?R1oxSklPaFRUME9LMzZ4eDNITVVkcHJrMFdtRUloNlVqVXM4U0xUOWZpYUIy?=
 =?utf-8?B?bWFHYnd5MktuNnBPaTA4Tk1uWWNQazF4bXRjNGlmckIrVnY5Yk0yYUYyQ29R?=
 =?utf-8?B?VEdpUWMxWlkvUXJ0TUMxaFVwT0ZmKzZFZnlWdFZLSVloY1pRWklLWXlWRDRZ?=
 =?utf-8?B?YUVHcmplOFFZeXFsMXgxdENPdnpkYlZzeFc3cTdpWUs2ck9aNnd0TUV3cDZm?=
 =?utf-8?B?OFNlcE83WENqZjIvbWh6N2pqOTJlLzFlL1BweXZhNzFIZm1BR0ZoMmpINTJv?=
 =?utf-8?B?WTRwQUNOUWtlYWhZckcyRWhJNVpqOGg5VG5aMHVKdnhVZlRGQW1wNGxUZHVH?=
 =?utf-8?B?b2R4R0U3OFRQZUxLTkZiNmtPRnJVSEdzam1sWDNWU1QvTmhUVklxZXlWbVRz?=
 =?utf-8?B?QlRPc01NS0JvM1FGZ04xaHlJdEd2R1AybXZvMUMwMEZCN3NzUU0xVGRIcGd2?=
 =?utf-8?B?T3FGQzVyWXhiK2IvaWFaZkRGOUtNZUhYZFRpWENWanl0ZVI0aUg0ek54dXkw?=
 =?utf-8?B?cGNWTXVIWTlFVmYrUi9mYmtudTNpbjFvMGk2VmQ0K2x4czdZaDA5K0s4bWto?=
 =?utf-8?B?Tzd6SmJ1L3F6RVVMV3BNMGEzMEZCUjNTTVRxV2g1T2pRMTdrdU4yaFpIek1Q?=
 =?utf-8?B?ZEpLUFQ0QXh4cmxhN1VDR053cXAwRXVJQzc3VHcxQmZUTmhOUnNxYUc1ckh1?=
 =?utf-8?B?Yk5MT2lzbnhrU1luYmFLNTFwY2hnQzhYbXk3L2dVUERHR25nRkJJN2lMcDF4?=
 =?utf-8?B?K2FmS3BsUUVqUEsyeXZuL213RGlBS3d6M1JIb2l1b01mOGdobUg5RkZZNEph?=
 =?utf-8?B?ZjlJKzBMMXpoMUZnR3FFdERnY0k3SnBDeTZUZHBZTnc0Zm5PRU9RNWtyQ0Fy?=
 =?utf-8?B?aUV1eno4RjIxbVNqVFlvRFJka2s1Z2xJYzlhbmVoU1RLZFVROEVmbnpLTFNl?=
 =?utf-8?B?d1lmbDUvdVV4b3hZTVRXS1BQTFJWSVRicWJEUDV2SDVDbjBFd3pjdTZTRXJ2?=
 =?utf-8?B?c1ExUmdiRTNmbnI2UWxsN0o5ZmNuRXNmZERMS0xYaHhLSmU1dys1eEQ0Q3RN?=
 =?utf-8?B?NzBTOEFhK3N6ZXFIRnhndVhGWEc2NFY5ekNVV1Q2OEI4dGxqWXlRSmV3aXdw?=
 =?utf-8?B?VWppOGNDRllKdmhrWTR6SUllSjJ6OUFJWGpJKzVhS2RaVnM3a3F1c0JmSkVo?=
 =?utf-8?Q?gtHE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88329c8-4efb-46c8-4269-08db8c5ac4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 15:29:27.6778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOdtSWEnyBKIIc6ML6XkJshAQmMuJCQ52dnsVQ1wIOCsVaD/rI1FZSheNdRUdnw0fRHva2Uc8Cknx6/sZCNxaI2jk8GVNdCF61XOgtsk71o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5826
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQgVXl0dGVyaG9ldmVuLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyIDMvNl0gZHQtYmluZGluZ3M6IHRpbWVyOiByZW5lc2FzLHJ6
LW10dTM6DQo+IERvY3VtZW50IFJaL0cyVUwgU29DDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24g
TW9uLCBKdWwgMjQsIDIwMjMgYXQgMTE6MTnigK9BTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAu
cmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+IEFkZCBNVFUzYSBiaW5kaW5nIGRvY3VtZW50YXRp
b24gZm9yIFJlbmVzYXMgUlovRzJVTCBTb0MuDQo+ID4NCj4gPiBNVFUzYSBibG9jayBpcyBpZGVu
dGljYWwgdG8gb25lIGZvdW5kIG9uIFJaL0cyTCwgc28gbm8gZHJpdmVyIGNoYW5nZXMNCj4gPiBh
cmUgcmVxdWlyZWQuIFRoZSBmYWxsYmFjayBjb21wYXRpYmxlIHN0cmluZyAicmVuZXNhcyxyei1t
dHUzIiB3aWxsIGJlDQo+ID4gdXNlZCBvbiBSWi9HMlVMLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IEFja2VkLWJ5OiBD
b25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiANCj4gVGhhbmtzIGZv
ciB5b3VyIHBhdGNoIQ0KPiANCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2Vl
cnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy90aW1lci9yZW5lc2FzLHJ6LW10dTMueWFtbA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9yZW5lc2FzLHJ6LW10dTMueWFtbA0K
PiA+IEBAIC0xMDksNiArMTA5LDcgQEAgcHJvcGVydGllczoNCj4gPiAgICBjb21wYXRpYmxlOg0K
PiA+ICAgICAgaXRlbXM6DQo+ID4gICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgIC0gcmVu
ZXNhcyxyOWEwN2cwNDMtbXR1MyAgIyBSWi9HMlVMDQo+ID4gICAgICAgICAgICAtIHJlbmVzYXMs
cjlhMDdnMDQ0LW10dTMgICMgUlovRzJ7TCxMQ30NCj4gPiAgICAgICAgICAgIC0gcmVuZXNhcyxy
OWEwN2cwNTQtbXR1MyAgIyBSWi9WMkwNCj4gPiAgICAgICAgLSBjb25zdDogcmVuZXNhcyxyei1t
dHUzDQo+IA0KPiBBcyBwYXRjaCA1LzYgYXBwbGllcyB0byBib3RoIFJaL0cyVUwgYW5kIFJaL0Zp
dmUsIEkgdGhpbmsgeW91IHNob3VsZCBhZGQNCj4gImFuZCBSWi9GaXZlIiwgdG9vLg0KDQpPSywg
d2lsbCBhZGQgUlovRml2ZSBhcyB3ZWxsLg0KDQpDaGVlcnMsDQpCaWp1DQo=
