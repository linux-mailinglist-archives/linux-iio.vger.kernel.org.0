Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3A55174B2
	for <lists+linux-iio@lfdr.de>; Mon,  2 May 2022 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386345AbiEBQrI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 May 2022 12:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381744AbiEBQrI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 May 2022 12:47:08 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E8D64E4;
        Mon,  2 May 2022 09:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vkh7PjVrqBdcfe07RtOxQN6cTfGYCmUzmVAMfd2n3HONw/H0wczp/NX2U5+mY4ymPONXG5b82osHP42IN8tlGTk/vECQoa4ReYFAj7z7zoXbty2htg0JY6GXeotZrZ/+dm162ILvLY/SFkcgdho7NWzxRExH9qi4l0bmIbNX+PHlR8+B0CBkebZVlo8AzGdbC9btEav7dZcVbLI6C1YZ7IX/avETpNyg+RcyKWnlQIv0YQLzTE076zOQLSPMlzckyO0BwhLYdtE1n+oP4HtWKKHQXL8i0CPe6LVf05ZArwho/JfdVTqE7EUl+MHnPAEJ0xshi2k7YvFVhetAgkgOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1Ftsqmckf0b3bfo4WsHqZEJRX2ko9GmgW86HZhYxd0=;
 b=maWZ4KJpajbD8jcyx6Dkx7b/YTFmx8do9lnqPRVHlJt5Qp676omdMGijK3kso2H0Ei/Q8bCwI1y8m3dBJoOAmmgxkwzfGF0Eua414DUErrQzdvTUO78IrSttPx01L8EE17CIEqO5Z5HFk652cipwQDQZXT44kenvvoNKEJtfHQFsnV5/eXvYbLQwyH7OQWbX9JYk/uuwkWbpABSTpTnMmsOiI+qLRtxQ0wA8B6uI4oyCeb3adoViv5jlWh7QkblNNPdB2KPJV//GSVTq0rF7DvkQCf1nPr0nuUEsgi2kqPE+OhmzqRnYDGyzrJ35bDxejDWqsCIcJbiVvWRh+s0sGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1Ftsqmckf0b3bfo4WsHqZEJRX2ko9GmgW86HZhYxd0=;
 b=WxHgcMtZ4I/vISgr24zbk2jHvcMLhJ0ssq1Z/tyqCs/28GMk/jaQHJEDCwirASElRAycGl0f0cJo8t5OdJsqwlh79LYeg4Z1MiEsaVbY/tnpjr+MkmxBQbUsjKsh5eewIx+32nsUy6ZqNh6/78kjn72fzJiazkFkW7kPhWOPoT8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB4086.jpnprd01.prod.outlook.com (2603:1096:604:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Mon, 2 May
 2022 16:43:34 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%7]) with mapi id 15.20.5206.014; Mon, 2 May 2022
 16:43:34 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Topic: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Index: AQHYXTOfwzcIy4H/ukmJ0Fyg702b460K+rcAgAAijpCAAIpCgIAAIbmA
Date:   Mon, 2 May 2022 16:43:34 +0000
Message-ID: <OS0PR01MB59229742CDB0CE2B9532DE4086C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 87d6786f-8e0c-4fb4-1a83-08da2c5ae644
x-ms-traffictypediagnostic: OSBPR01MB4086:EE_
x-microsoft-antispam-prvs: <OSBPR01MB4086CC220FF2C56EF3D563EA86C19@OSBPR01MB4086.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7dKwh4rcfJb3KZzYXXqxdqYhdT7nRuX/43OS+FPbo9TqF7+kEohzBEVI8hFdNVnrCth0Ty1YIh3EW6J9sboV6fnr4L/oy5MB9yg2pUfiRF92BdNnhgmA7r3CWWZyvsAIGDpZnej2fKBwh3QAG5/d/VNVLJFeS8eTS7ocJFNXeOs3U/5gpY1NfxwDNr0+KR2IFp6aesTjKBHLYksCf1UrYOVktTcVfuITWHJ6GAjfTzBa442C1+OoxeD9GNGUs+92u0kM1sGMC4cHtWxemSctFX7bGzZE+V+0l/4shImW2UUme/ypM4DN4yNh8r6NlKHr/6bpTWCNHjHLQI8SYiNYVeZ6NJAWuT6MIIJUXfAp8zJ/xGphJu7tQ3wmYZw0eU69Bvqf2dZaWfheBsrQwD58C0RJshSQVMJN4Bturwo27i8GlcJmqWVPgEC0xQYBBh6lDdm0GPI0O9Ygyc3yrMAVT1rvKDUv2sKl6R3cylUhLHMQGLSkeSQOgBNiDjBp3dEBqpxAYZlxP8o6bjEKQrAOw2Awf95da+nUaqnF+B/ps6OGJ3N7gYERuNagur/7LdU2GlRtvqs8433k73j3SZjkSXPCOHXJjQjixT9JIisN2+UrQ4b2IBapeOQuFHX0OxO4GAMoWzZPyhYizppxHbejqEBK5KhuYMqEFP2kqZ2f/PjGqkiEfkohrE28rxr0slaPdMaGFW8CY8oil8h9UYHX2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(316002)(54906003)(122000001)(38100700002)(38070700005)(6916009)(66476007)(86362001)(66556008)(66946007)(107886003)(76116006)(66446008)(64756008)(4326008)(8676002)(508600001)(71200400001)(55016003)(9686003)(26005)(53546011)(7696005)(6506007)(5660300002)(33656002)(52536014)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0lmZkJkRDgvYjhjT3pXRDBRVmhmbWNHMUJlcjYweVZ1bEhBcks4eHYyNFNG?=
 =?utf-8?B?VHBxNldSZlhRNU50OHBaQnF3MFRxb050Z0hLRnJXYXFCWFZvYlBFZGFNdnJ6?=
 =?utf-8?B?SUx4bXo1M0VCY3hlckk4UWVheXJFeUd2Y0xWaStiVVRyK1NOdk9yaWZ6Tmpv?=
 =?utf-8?B?cnNvb0FEck1lemMzOEQ4MjdpaEVMdDl0NE5nTjVINFRMT2UyUUI3Rmp5MXgy?=
 =?utf-8?B?SXhhS1BiV1lUNzNXM0Erb0dOeGttcFUyRnNrTHNpTnhyaVM2NXovYVhqM01M?=
 =?utf-8?B?RkFNR08rT25xcDVJQXFOZzQvSjIzWDQ3VG1tU0RLajB3bTBvWkZUSHIwOFNN?=
 =?utf-8?B?b3YwclRPOHhNUlpGanlzRzdzcERNSmJhaVV3S0tua2p0TTdLVmdISXlvSWR3?=
 =?utf-8?B?K3R0K0taWkR3ZnhCaG5qQnhHclk2R3RzZmJ6aWtJSlU2VTUwU01LUjcvTUow?=
 =?utf-8?B?M2RYcXpyc3ZZYk5VTGNFT0xHOXZJZ1JwdjJmZkQ5NnEwRm5jR2RMaVVGejVo?=
 =?utf-8?B?RmVxMzdkanVGM256b2ZGNXU1bUs1NFR3STlOaG4rMnB4dWxCQnM3czVJT0hz?=
 =?utf-8?B?MWxvRGJuWVBURGpHbW1LMHM3dVd5OGtqMVNncXBwTm9FUDZ0SlFSYUF1RHdM?=
 =?utf-8?B?ZnFrNGFlMFlUMVlPc0FQclpDaVdmUko1bFlldnNlMWJXS3BKQ1YvSkxFQzBH?=
 =?utf-8?B?UUtlWjBqVkxkTWhPWHVXRkNSVWhpU1RCeldBQnBWZ0I3NWp2TUEyQ1B2TEty?=
 =?utf-8?B?U1hGY0hlVEVicksyRlpkNDMwZkxqeVpWZWJYR0xpc2p6ZzVqYlRKRTZ1b1Bm?=
 =?utf-8?B?WWVzT1pYMTcyVHkvSjM2ZGlSUjFhc3ZrMmd0UnRIWXJYN1NxbUhCWng2SGt5?=
 =?utf-8?B?RUQ1TllVaGpZVFVOdGZCMlNKYkN1SlpKUnhMa1MrSVQ3WWZ0MUZxTmhYM1RN?=
 =?utf-8?B?QlkvRlBDdGdWQ3IvZWV3ZjR3RWt4MjlnNzRkbkYvMUdoZ1hLRDQ3Uk83VWpz?=
 =?utf-8?B?di82Z0ZZc0JSVllubWt1OGd5VXBXMUwxTG1wenBqOGxPS2dIRHEya0JTSGdS?=
 =?utf-8?B?bmJjUXQxR01YU0VOYWRqL1lHVmVvNTRvelI2QjVwNXgwZ3I5TXRWOVJ0cC82?=
 =?utf-8?B?RkRWMVFDbFU5MkRzQkh1VERIRjVKWUt2SXJSeVBYYXVHdDA0SURGU2FUMDBi?=
 =?utf-8?B?QnlBSldxbkxWTWYzalJRbkhvSjBjZEN6K3VQU3VwVUdvRGtLYVhybm41NWk2?=
 =?utf-8?B?VU1CQTlnMnJyc3Z5K2NiWUZjTmxHenRla2lDNGlJZHY1eFZTTUlUUHE2Yzlt?=
 =?utf-8?B?aGJ6bXA4ZXZISnJFaW5UTFhjNjRsRmtWajlNRWRGdTREQ0hUM1JaSk1oYmth?=
 =?utf-8?B?UWorSjBuVzM3SXFMTElLOW9zcTlWbSs3T2dVci9MYWFpSzhOYlUrcit5Qjc0?=
 =?utf-8?B?Qk5XVmVEc0lTLzltL2FPZFJmdHpuem0vblUvVS9VSFE4NnNSelUwdnJWNFMw?=
 =?utf-8?B?c1hna05xU0gwZy9CdS9qRFJ3T0pZMXBuRUJybFNFUmdvcDVlSG16OEJhUHVJ?=
 =?utf-8?B?SStvcmUzUFNJamJFbEtjenVqYVJhQXA5NjNrMCt6THppdEIwQ2NrNGlSZGYr?=
 =?utf-8?B?NDFEUlBVQ0p3MkRBUHBFblJMN1RRZlUxSnhLMjNZZm00TDBsdEZKcVFFYzdV?=
 =?utf-8?B?SmJ1SjRFQXJKQzJEV0N1ajhLdURoVFBPYlRJMHNYcFl1eHVZbng4dlFDY3c5?=
 =?utf-8?B?dFNlcVFaOFRZT0c0aVpHUWtWUkNaQUNYdDBic0pDRGE5L0xhODVZeUtQZWVQ?=
 =?utf-8?B?cjdlMWF3N1VpbGZ3Nnk2ZGpwVE9UUytSREpUc2tKNGxLU2xMbUZmLytPZ2NQ?=
 =?utf-8?B?UkdsOTI3ejhEbVhRV2RMMnlEUlAva241TVlNMEdMaktBcE1SeURod24xRU9F?=
 =?utf-8?B?dnJoUnBsNnVMYVpRS2hEbnlXWjF6cGRURDl6K0ZwL29MZVBVZlZ3VnpLR0VB?=
 =?utf-8?B?TE9jc3k3di84ckNKZDhodWQzeW4yeTlZTmtCWksvTCtNQ3h6SXlGdmFCUHYy?=
 =?utf-8?B?NmNpSDdmZ1R6SnJQa050THYrdHNKSUoxSVpKRzBJQ2NFaXlBelBDcXl3cy82?=
 =?utf-8?B?QlYwZ0hOME9CZk1aSURTZUVmS010T0d2UnRNUDFrcEtXY1R5cFFVM3pWczRt?=
 =?utf-8?B?eURCQ1J2Z0ZEdXdnMHd0YkNRRGFSUU9RUHVtSzBRdDFVWW41SXhvOGZMWEkz?=
 =?utf-8?B?M3FnMThsVXJVS1pFRTFxWldPNmJnVk1Ta1Fvd1djZnhsajhIclR4SmhTbUNF?=
 =?utf-8?B?amRtUTlkZW0zWGMrYUxrd1BwZ3NaSERTMDR0QzZTMis2eitvRHVVZC92SC9F?=
 =?utf-8?Q?VMeRG3rml1UII5w4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d6786f-8e0c-4fb4-1a83-08da2c5ae644
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 16:43:34.7779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MnAyREISSYj5KjU1YdwVDktLuhY6J2uMCQZ/bL71W2ckMjhCq4ixZA0c0eCF2GOWsm9VToGHVpJ0YmImHFPLqRDmLzbwoWVfzXPCWfnmjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrDQoNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gaWlvOiBhZGM6IHJ6ZzJsX2FkYzogQWRkIHN1cHBvcnQgZm9yIFJaL0cyVUwgQURDDQo+
IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gTW9uLCBNYXkgMiwgMjAyMiBhdCA4OjE4IEFNIEJpanUg
RGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiBTdWJqZWN0
OiBSRTogW1BBVENIXSBpaW86IGFkYzogcnpnMmxfYWRjOiBBZGQgc3VwcG9ydCBmb3IgUlovRzJV
TA0KPiA+ID4gQURDDQo+ID4gPiA+IFN1YmplY3Q6IFtQQVRDSF0gaWlvOiBhZGM6IHJ6ZzJsX2Fk
YzogQWRkIHN1cHBvcnQgZm9yIFJaL0cyVUwgQURDDQo+ID4gPiA+DQo+ID4gPiA+IEFEQyBmb3Vu
ZCBvbiBSWi9HMlVMIFNvQyBpcyBhbG1vc3QgaWRlbnRpY2FsIHRvIFJaL0cyTCBTb0MsIGJ1dA0K
PiA+ID4gPiBSWi9HMlVMIGhhcyAyIGFuYWxvZyBpbnB1dCBjaGFubmVscyBjb21wYXJlZCB0byA4
IGNoYW5uZWxzIG9uDQo+IFJaL0cyTC4NCj4gPiA+ID4gVGhlcmVmb3JlLCBhZGRlZCBhIG5ldyBj
b21wYXRpYmxlIHRvIGhhbmRsZSB0aGlzIGRpZmZlcmVuY2UuDQo+ID4gPiA+DQo+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+
ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL2lpby9hZGMvcnpnMmxfYWRjLmMgfCAxOCArKysrKysr
KysrKysrLS0tLS0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gSSB3b25kZXIgaWYgdGhpcyBjaGFuZ2VzIGlz
IHJlYWxseSByZXF1aXJlZC4gUlovRzJVTCBjYW4gc3RpbGwgdXNlDQo+ID4gPiB0aGUgInJlbmVz
YXMscnpnMmwtYWRjIi4gQXMgdGhlIGRyaXZlciBwb3B1bGF0ZXMgdGhlIGNoYW5uZWxzDQo+ID4g
PiBkZXBlbmRpbmcgdGhlIG51bWJlciBvZiBlbGVtZW50cyBpbiB0aGUgYXJyYXkgcGFzc2VkIGlu
IHRoZSBEVFMgYW5kDQo+ID4gPiBub3QgYWx3YXlzIDggY2hhbm5lbHMuIEZvciBleGFtcGxlIG9u
IFJlbmVzYXMgU01BUkMgRVZLIG9ubHkgZm91cg0KPiA+ID4gY2hhbm5lbHMgYXJlIHBvcHVsYXRl
ZC4NCj4gPg0KPiA+IEZvciBtZSB0aGF0IHJlc3RyaWN0aW9uIGlzIGNvbWluZyBmcm9tIGJvYXJk
IGRlc2lnbiwgYXMgU29DIGlzIGNhcGFibGUNCj4gPiBvZiBoYW5kbGluZyA4IGNoYW5uZWxzLCBC
dXQgYm9hcmQgZGVzaWduIGFsbG93cyBvbmx5IDQuDQo+ID4NCj4gPiBCdXQgb24gUlovRzJVTCBT
b0MsIGl0IGlzIGNhcGFibGUgb2YgaGFuZGxpbmcgb25seSAyIGNoYW5uZWxzLiBPdGhlcg0KPiBj
aGFubmVscyBhcmUgaW52YWxpZCBmb3IgUlovRzJVTCBTb0MuDQo+ID4NCj4gPiBUaGF0IGlzIHRo
ZSBkaWZmZXJlbmNlLg0KPiA+DQo+ID4gPiBXaXRoIHRoaXMgd2UgZG9uJ3QgaGF2ZSB0byBkaWZm
ZXJlbnRpYXRlIFJaL0cyVUwgU29DIGlmIGp1c3QgYWRkIHR3bw0KPiA+ID4gY2hhbm5lbCBlbnRy
aWVzIGluIHRoZSBTb0MgRFRTSSBhbmQgdGhlIGRyaXZlciB3aWxsIGp1c3QgY3JlYXRlIHR3bw0K
PiA+ID4gY2hhbm5lbHMuDQo+ID4NCj4gPiA+IEBHZWVydCAtIHlvdXIgdGhvdWdodHMgb24gdGhp
cy4NCj4gDQo+IEl0IGRlcGVuZHMgb24gdGhlIG1lYW5pbmcgb2YgdGhlIGNoYW5uZWwgc3Vibm9k
ZXM6IGRvIHRoZXkgaW5kaWNhdGUNCj4gKGEpIHRoZSBudW1iZXIgb2YgY2hhbm5lbHMgcHJlc2Vu
dCBvbiB0aGUgU29DLCBvciAoYikgdGhlIG51bWJlciBvZg0KPiBjaGFubmVscyB1c2VkIG9uIHRo
ZSBib2FyZD8gIFRoZSBEVCBiaW5kaW5ncyBhcmUgbm90IGNsZWFyIGFib3V0IHRoYXQuDQo+IA0K
PiBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjlhMDdnMDQ0LmR0c2kgbGlzdHMgYWxsIGNo
YW5uZWxzIGFuZCBkb2Vzbid0DQo+IGtlZXAgYW55IGRpc2FibGVkLCB3aGljaCBzdWdnZXN0cyAo
YSkuDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yemcybC1zbWFyYy1zb20uZHRzaSBk
b2VzIHJlbW92ZSB1bnVzZWQNCj4gY2hhbm5lbHMsIHdoaWNoIHN1Z2dlc3RzIChiKS4NCj4gDQo+
IElzIHRoZXJlIGFueSAocGVyaGFwcyBwZXJmb3JtYW5jZT8pIHJlYXNvbiB3ZSBjYW4ndCBqdXN0
IHVzZSB0aGUgbnVtYmVyIG9mDQo+IGNoYW5uZWxzIHByZXNlbnQgaW4gRFQ/ICJtYWtlIGR0YnNf
Y2hlY2siIGNhbiBzdGlsbCB2YWxpZGF0ZSB0aGlzIGFnYWluc3QNCj4gdGhlIFNvQy1zcGVjaWZp
YyBjb21wYXRpYmxlIHZhbHVlLg0KDQpOby4gS3J6eXN6dG9mIEtvemxvd3NraSBzdWdnZXN0ZWQg
dG8gdmFsaWRhdGUgdGhlIG51bWJlciBvZiBjaGFubmVscyBwcmVzZW50IG9uIHRoZSBTb0MNCmFz
IHRoZXJlIGlzIGEgZGlmZmVyZW5jZSBpbiBoYXJkd2FyZSBjYXBhYmlsaXR5IGJldHdlZW4gdGhl
IFNvQ3MuDQoNCj4gDQo+IERvIHdlIG5lZWQgdG8ga25vdyBhdCBydW50aW1lIGJvdGggdGhlIG51
bWJlciBvZiBjaGFubmVscyBwaHlzaWNhbGx5DQo+IHByZXNlbnQgYW5kIHRoZSBudW1iZXIgb2Yg
Y2hhbm5lbHMgdXNlZD8gIElmIHllcywgd2UgZWl0aGVyIG5lZWQgdG8gdXNlDQo+IHRoZSBTb0Mt
c3BlY2lmaWMgY29tcGF0aWJsZSB2YWx1ZSwgb3IgYWRkIGEgbnVtLWNoYW5uZWxzIHByb3BlcnR5
Lg0KDQpZZXMsIGN1cnJlbnRseSBkcml2ZXIgZG9lcyB0aGUgdmFsaWRhdGlvbiB3aXRoIFJaRzJM
X0FEQ19NQVhfQ0hBTk5FTFMoOCkgd2hpY2ggaXMNCndyb25nIGZvciBSWi9HMlVMIGFzIGl0IGhh
cyBvbmx5IDIgQ2hhbm5lbHMuDQoNClRoYXQgaXMgdGhlIHJlYXNvbiwgbmV3IFNvQy1zcGVjaWZp
YyBjb21wYXRpYmxlIGludHJvZHVjZWQgdG8gdGFrZSBjYXJlIG9mIHRoaXMgZGlmZmVyZW5jZS4N
CkN1cnJlbnRseSBJIGhhdmUgZG9uZSB0aGUgYmVsb3cgY2hhbmdlcywgd2hpY2ggcmVzdHJpY3Rz
IHRoZSB1c2FnZSBvZiBjaGFubmVsID4gMSBpbiBEVCBmb3IgUlovRzJVTC4NCg0KKyAgICAgIHJl
ZzogdHJ1ZQ0KICAgICByZXF1aXJlZDoNCiAgICAgICAtIHJlZw0KIA0KICAgICBhZGRpdGlvbmFs
UHJvcGVydGllczogZmFsc2UNCiANCithbGxPZjoNCisgIC0gaWY6DQorICAgICAgcHJvcGVydGll
czoNCisgICAgICAgIGNvbXBhdGlibGU6DQorICAgICAgICAgIGNvbnRhaW5zOg0KKyAgICAgICAg
ICAgIGNvbnN0OiByZW5lc2FzLHI5YTA3ZzA0My1hZGMNCisgICAgdGhlbjoNCisgICAgICBwYXR0
ZXJuUHJvcGVydGllczoNCisgICAgICAgICJeY2hhbm5lbEBbMC03XSQiOg0KKyAgICAgICAgICB0
eXBlOiBvYmplY3QNCisgICAgICAgICAgcHJvcGVydGllczoNCisgICAgICAgICAgICByZWc6DQor
ICAgICAgICAgICAgICBkZXNjcmlwdGlvbjogfA0KKyAgICAgICAgICAgICAgICBUaGUgY2hhbm5l
bCBudW1iZXIuIEl0IGNhbiBoYXZlIHVwIHRvIDIgY2hhbm5lbHMgbnVtYmVyZWQgZnJvbSAwIHRv
IDEuDQorICAgICAgICAgICAgICBpdGVtczoNCisgICAgICAgICAgICAgICAgLSBtaW5pbXVtOiAw
DQorICAgICAgICAgICAgICAgICAgbWF4aW11bTogMQ0KKyAgLSBpZjoNCisgICAgICBwcm9wZXJ0
aWVzOg0KKyAgICAgICAgY29tcGF0aWJsZToNCisgICAgICAgICAgY29udGFpbnM6DQorICAgICAg
ICAgICAgY29uc3Q6IHJlbmVzYXMscnpnMmwtYWRjDQorICAgIHRoZW46DQorICAgICAgcGF0dGVy
blByb3BlcnRpZXM6DQorICAgICAgICAiXmNoYW5uZWxAWzAtN10kIjoNCisgICAgICAgICAgdHlw
ZTogb2JqZWN0DQorICAgICAgICAgIHByb3BlcnRpZXM6DQorICAgICAgICAgICAgcmVnOg0KKyAg
ICAgICAgICAgICAgZGVzY3JpcHRpb246IHwNCisgICAgICAgICAgICAgICAgVGhlIGNoYW5uZWwg
bnVtYmVyLiBJdCBjYW4gaGF2ZSB1cCB0byA4IGNoYW5uZWxzIG51bWJlcmVkIGZyb20gMCB0byA3
Lg0KKyAgICAgICAgICAgICAgaXRlbXM6DQorICAgICAgICAgICAgICAgIC0gbWluaW11bTogMA0K
KyAgICAgICAgICAgICAgICAgIG1heGltdW06IDcNCg0KDQpDaGVlcnMsDQpCaWp1DQoNCg==
