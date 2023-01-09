Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C23A662878
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 15:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjAIOa2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 09:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjAIO2a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 09:28:30 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2098.outbound.protection.outlook.com [40.107.114.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E48AE4F;
        Mon,  9 Jan 2023 06:28:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6F4p4hhl3l5kd5ceS2B/85cUMjXlx0RibdhD8y4l0hQk17UeFmccWzYhVi76ebqaaXJNbTSrNQJ+lYnZxyu0XA17mjdPAGNidtysjlMmX+DotDOHOPy+t6mbqbnjNMZTw0vawOf9n7yczHIzRiQxU8ZH5cI/miJY4H9GtzPLsX06WZ9//lUK6bU6oSg2z1tPDP+Q1SBtciV54Ll9ZTCDG9pFZ8nDjhX1V/ZNsVApH48DDbxBzCWwvxnhJuJocRHc7Ka1KonnAToW15A/Mx7/AK9NIPhd4Ncy71Z2fqIAAeCMYjUAL3FNamzkCXzvKnK9z8G2CVWt6OH7N/ujAuZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIWQL/IkuavR5SPuCjiJBgGtX2UUtTsLVXJEvoO3SOI=;
 b=PkhZL6uX3dK93kGuUnmBkLKDGCin4Jz/CLGytRjqVZM7TkbVk7WVEIBe1XQqtIW/vZGzIspuLtVnSa6dO4W8oKKbjb1bCRz1WY0AGtJbIi0FFpbQKXVWlGTSnVz02AKeCy1ko2ePIqxBi4z+DM9tKWdCna3GKhdg0io6ReUVU1zBkP/vK6y6Ict2tughYpNnqwleQrupsMM58xHgdjj/ynbwWI7FnoFaj/0uT7AkLeJCVGgoB7a967jSQa4wteWl814rVN2y341FYsVL0GuXPTq1RjSU67rBWrIL+Z1OaV4runQDNrpXoCa2+32nCmEnTtK1n2/AylJuD4gFPp7x2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIWQL/IkuavR5SPuCjiJBgGtX2UUtTsLVXJEvoO3SOI=;
 b=pPSF7lZ5S2yicP7oxDFeFr1/mmQNKtR83GTM07D3dNAnfDaYBWfruGLcbeZ+GXftoDO2a3fyuhSMmCzU9NvDv9/yWZFezpDgwdbEEYNPDWyY0YWt9Z8H6G/xky9tq7ggVXHa9DqCJQVVQkpKJH9L5xU82XIKWK/Tf4YgI0cmzZE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB7924.jpnprd01.prod.outlook.com (2603:1096:604:1bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 14:28:26 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%3]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 14:28:25 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     William Breathitt Gray <william.gray@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v10 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Topic: [PATCH v10 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Index: AQHZEZAUiq0ZEMlrLEO1YySNLLmjlK505+CAgCFhM5A=
Date:   Mon, 9 Jan 2023 14:28:25 +0000
Message-ID: <OS0PR01MB592297092D63FDAA16D46AC086FE9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221216205028.340795-1-biju.das.jz@bp.renesas.com>
 <20221216205028.340795-5-biju.das.jz@bp.renesas.com>
 <CAMuHMdXLqgWLb5B7=Orf6aMtcaXgejftHbOZAmg_yDX6QkCjnA@mail.gmail.com>
In-Reply-To: <CAMuHMdXLqgWLb5B7=Orf6aMtcaXgejftHbOZAmg_yDX6QkCjnA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB7924:EE_
x-ms-office365-filtering-correlation-id: 9775d62e-2cf1-48a0-8853-08daf24dc518
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oc4cQHbsyRWNjn4oj052uwy1A3te5uJKmwyB6QE58GjZDHDMiRzDKngQcZnlyWSQdsH9DLXdDqyv/Lrsl+jPgK4dUiKodbaWX9w+pDVBLPW6256PU+PAA4QhKyeg0gaFGsu4i2vNU9EqKL0N39IvK7k7fn0lLgwT+3n9YeoBmFbHruvL2oK3WpHd0HVivrkTJqUnbKgbgc2xZHK4HOrE2Bqfy6uk77r4msTDhbscQlTxo0MGif4jPjBO9jZGfwWhD1q/Awj4U1eOiDA/BQV51J7soi+sArWLGqeqkFRWjcbUxPAvvRPz5ayma8hNiCUVhjsa3W724a+gfrHEYb/FwfX+xZOtsTy6SYIwkqys5paN9xPJ1IuhefXRnCjAj40vAf6QEsfcFl/iXEF55//HTOja+aPjCTIU+ujMtOaix+W79DN7oZ/2gZdfg77cwSfWyk1ppY3Xci0TeMPXbIi9dHItoO+5vYVXyy9V339csfbV6hBm3TgCfTnCI88ff/KcJ/vMr1HISOq/Jt7JrzaeWiqZTylIpY6TJAed6ZP9GFey+xgC1OU+QGCAFhLaCCXJApu7xpMdh2h1h4B8/AyjtfwLihzwojsze+HZ2qiRIJCxMbRiY5JSl9kPb4M9BK+YZlYIA9gWzT0/cLi2N1dJYLT8Sotq7T6+3ZrVZMrNwleQpK1PWF/vKLnoBgB+YB45BHZ7fSOerxcBasmI9efmm64my7YMGZiffC4BCh+R/l4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199015)(53546011)(186003)(122000001)(8936002)(52536014)(26005)(6506007)(54906003)(9686003)(55016003)(5660300002)(66946007)(33656002)(7696005)(66446008)(66476007)(64756008)(66556008)(6916009)(4326008)(316002)(86362001)(38070700005)(71200400001)(76116006)(38100700002)(478600001)(41300700001)(8676002)(2906002)(83380400001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU5SMDRodVFWYjhLL1NXQ0F3UXRuNnVlaCt4ZWpRU3dKRGRZNm4wRVRBVHlH?=
 =?utf-8?B?K0VLbVNaREFjMEROUzBjRXRkNzNEc0kvN1cvTFY2dDNRR2hCejZqa3hObzdk?=
 =?utf-8?B?K1FsTHNwRzFzS2RhTTh5cVVROXcyVWxSL0pHd1liSytPQ1BpWDBiTUtLYmk4?=
 =?utf-8?B?dEx4bi9lenBHMlBaWUpJUFh0VE5US0lvRUV6UWhhb2hiL3FrR0VwZG9Cempt?=
 =?utf-8?B?NjhsMFcxK1YwSjBoaDBENVUrNnV4NkJMWHVVd1orVk9YaFJqSERCZDdHNWIx?=
 =?utf-8?B?ZXVMVDIzTDh6UGN6eEF5b3krREJCOUdqSG40cTlvMDVBamxMVlFNbzh0TG84?=
 =?utf-8?B?U0U5V2ZEOEswU0MwNC9WZXhBSDBXQ0tVNnJFbmRzd21aVVlNS2FyT2F3WlRZ?=
 =?utf-8?B?VTFvMnFRbmp0ZWNmUEZqZ2NEZnhYWHlpK1dnOFZqY29hREtrTHZhVjM1QmNp?=
 =?utf-8?B?b2hkdVZwM2Z4bWY2WG0xOUJYaEUxUjh6S24xUXdzVjE2OThVbDRmbkNraktR?=
 =?utf-8?B?eTFrcFcrRVNJNHZGYmMvQnRGWm9VdjZneHVIOFFPTTQ0L1V0ODRiQlB3dVZN?=
 =?utf-8?B?U1dIb3pJSk9QR3J4ejBlVGJMUXlQcEpncWtGLzVWUmRiYVZaUitSbEZOakRx?=
 =?utf-8?B?UWg3ekxNTDlXdHNoRDFMcnFrZ1ZWc2hpUm93YWdzQ3E5ZXE4SmNyckhkakxn?=
 =?utf-8?B?bGkxa3ZtN21LZGpFQTRSSlQ4bnNlMkYxaWUvZVA1emo1UFZ6MjFTb2Y4RHo3?=
 =?utf-8?B?U1JCdjJEWFhFWmNzb3VEOVNDcXdiVjQ4c0laZ0ZIUDBkZjRUSHQvOGI0SlBJ?=
 =?utf-8?B?dU9SQ2hZNXVya2ZvS1B2OGJUZXlPMDBzdElNOFNwYWczSjcwTVh3VCtpZDFz?=
 =?utf-8?B?S0FSZ2RqTUt0OVRXVTJRR0Y1QXFrZzE1YzA5Z05NMkpvZW55NGszMlY2OUlj?=
 =?utf-8?B?UVZXNk1pckxwVGw1NFF6UHYxOGhnaVdyOEVUNFQveWtxV3g5QkdMZDNrS29S?=
 =?utf-8?B?U2c0MnhMTzA3ODR5QThwQnE4eldmN2F5dlZvaldWdlEybzh0NHcyUS8xcHZs?=
 =?utf-8?B?cjFPaWdWOTFQRGRZN0FrRDRyZXRhSkthUER0RjF5ZEJ1SUQvcnJxN1VNZzZ1?=
 =?utf-8?B?Snc1RHRKN0xBYm9uc1BObXRDZVdWeEhSR0k0bmQ4NHVEQ0FiUHh5ZFJCVTdO?=
 =?utf-8?B?R0U1SG1yckhRVHEwUDBNQmVjRmVDT3M1Z3BSazM0MDRSemJoRjQ4VFRUUmxD?=
 =?utf-8?B?NHZPbU5WVmxwdWJHdXJNaldzSksrVG9TOXJlbG8xMVB0U2RYU0ZKWkMzbVZn?=
 =?utf-8?B?MXNJTDZsWUVmTFNNMjdyTjk4dnYxRUxJSEJtQ1VpbnFKRW5YWmkrMlhydmFj?=
 =?utf-8?B?bEVIa0tqYks4ZWFjTTRLTElpdHNIWFdiVlFKL3pFdDFYRGpxRkNDZjZ1SE9z?=
 =?utf-8?B?QWo3SHRIZVRsTlo2SEwrQ1M4Q3IyazlFZ0xIc05WUXpKSHZoODVCcGJrTjNp?=
 =?utf-8?B?VmNVU1l5R3FUMUZob3dIcVhPZzV2REpXSXhDeThiczlGQnBpR2d4ZEdVTm5m?=
 =?utf-8?B?VkE3VlRyN0ppcEhQTVdsNndFY3BxK3ArZS9LRm9abCt0V3VzTU9ldEN1L0dq?=
 =?utf-8?B?SnhHQXdsWWNJVUNwUnlqWE9uaTdzT0wyQmg0WklMUFRGcllreVlvZ1l6UGYw?=
 =?utf-8?B?ZnFOaHY1c1ZvVGdPTElRMFptV2lDaFJPdTRSemJrZml4MG1Dc3h3di9MU1ZJ?=
 =?utf-8?B?eURSNXJzRnhzQ1FWeHRDWWdTQ3VlRzRQUzJjdlVTVzZ4aG56NkNTSm4rekVi?=
 =?utf-8?B?UzBsMCtSSjRPNHJtSXNvNDdkL0V5YWFGbCtBanlXeVVzTmpNbUh3ZnR6MlN1?=
 =?utf-8?B?aTFxemZHK3FzVVFDdm1VNjZyd3VCVnR5Yzdpa0JQdTBMdHoxaHlZcnhwRFFl?=
 =?utf-8?B?aHB5ay9uWFZLei84dmFtWlVHdk5EeDlENzh4ZlFPcHJSamdOc3ZleVBzZnFF?=
 =?utf-8?B?Y052MCtIMGJZUjVuSWFKZWpobnBRWmRvTTBJbnFmd0xuK2JBL29ObGxmVDM0?=
 =?utf-8?B?MzlEWVp6c3VCcGk2WjViVER4VGx5bFd3UVRzc0xXYVh0bjFJQThjU1paU0JE?=
 =?utf-8?B?Z3pBSFhnZHl0NW8xR2dxK2VScm8vTVlPWlNPZjJTVDhrczdLSm5WN3VVZjBy?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9775d62e-2cf1-48a0-8853-08daf24dc518
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 14:28:25.9313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXr/kNAqw/OmCVzEDlM6ume+coNOn4erIHDDFPTKdu8qk7gDq+sJmzwx7XOTeMwgz7ZQANmq4h3PE+nAchHxQDAeNaByBu1KoVcnUglKa7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7924
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE5IERlY2VtYmVyIDIwMjIgMDg6NDANCj4gVG86IEJpanUgRGFzIDxi
aWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gQ2M6IFdpbGxpYW0gQnJlYXRoaXR0IEdyYXkg
PHdpbGxpYW0uZ3JheUBsaW5hcm8ub3JnPjsgbGludXgtDQo+IGlpb0B2Z2VyLmtlcm5lbC5vcmc7
IENocmlzIFBhdGVyc29uIDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+OyBQcmFiaGFrYXIN
Cj4gTWFoYWRldiBMYWQgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT47
IGxpbnV4LXJlbmVzYXMtDQo+IHNvY0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MTAgNC81XSBjb3VudGVyOiBBZGQgUmVuZXNhcyBSWi9HMkwgTVRVM2EgY291bnRlcg0K
PiBkcml2ZXINCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBGcmksIERlYyAxNiwgMjAyMiBhdCA5
OjUwIFBNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4g
QWRkIFJaL0cyTCBNVFUzYSBjb3VudGVyIGRyaXZlci4gVGhpcyBJUCBzdXBwb3J0cyB0aGUgZm9s
bG93aW5nIHBoYXNlDQo+ID4gY291bnRpbmcgbW9kZXMgb24gTVRVMSBhbmQgTVRVMiBjaGFubmVs
cw0KPiA+DQo+ID4gMSkgMTYtYml0IHBoYXNlIGNvdW50aW5nIG1vZGVzIG9uIE1UVTEgYW5kIE1U
VTIgY2hhbm5lbHMuDQo+ID4gMikgMzItYml0IHBoYXNlIGNvdW50aW5nIG1vZGUgYnkgY2FzY2Fk
aW5nIE1UVTEgYW5kIE1UVTIgY2hhbm5lbHMuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgMyBj
b3VudGVyIHZhbHVlIGNoYW5uZWxzLg0KPiA+ICAgICAgICAgY291bnQwOiAxNi1iaXQgcGhhc2Ug
Y291bnRlciB2YWx1ZSBjaGFubmVsIG9uIE1UVTENCj4gPiAgICAgICAgIGNvdW50MTogMTYtYml0
IHBoYXNlIGNvdW50ZXIgdmFsdWUgY2hhbm5lbCBvbiBNVFUyDQo+ID4gICAgICAgICBjb3VudDI6
IDMyLWJpdCBwaGFzZSBjb3VudGVyIHZhbHVlIGNoYW5uZWwgYnkgY2FzY2FkaW5nDQo+ID4gICAg
ICAgICAgICAgICAgIE1UVTEgYW5kIE1UVTIgY2hhbm5lbHMuDQo+ID4NCj4gPiBUaGUgZXh0ZXJu
YWwgaW5wdXQgcGhhc2UgY2xvY2sgcGluIGZvciB0aGUgY291bnRlciB2YWx1ZSBjaGFubmVscyBh
cmUNCj4gPiBhcyBmb2xsb3dzOg0KPiA+ICAgICAgICAgY291bnQwOiAiTVRDTEtBLU1UQ0xLQiIN
Cj4gPiAgICAgICAgIGNvdW50MTogIk1UQ0xLQS1NVENMS0IiIG9yICJNVENMS0MtTVRDTEtEIg0K
PiA+ICAgICAgICAgY291bnQyOiAiTVRDTEtBLU1UQ0xLQiIgb3IgIk1UQ0xLQy1NVENMS0QiDQo+
ID4NCj4gPiBVc2UgdGhlIHN5c2ZzIHZhcmlhYmxlICJleHRlcm5hbF9pbnB1dF9waGFzZV9jbG9j
a19zZWxlY3QiIHRvIHNlbGVjdA0KPiA+IHRoZSBleHRlcm5hbCBpbnB1dCBwaGFzZSBjbG9jayBw
aW4gYW5kICJjYXNjYWRlX2NvdW50c19lbmFibGUiIHRvDQo+ID4gZW5hYmxlLyBkaXNhYmxlIGNh
c2NhZGluZyBvZiBjaGFubmVscy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxi
aWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiB2OS0+djEwOg0KPiANCj4g
VGhhbmtzIGZvciB0aGUgdXBkYXRlIQ0KPiANCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
ZHJpdmVycy9jb3VudGVyL3J6LW10dTMtY250LmMNCj4gDQo+ID4gK3N0YXRpYyBpbnQgcnpfbXR1
M19jb3VudF9yZWFkKHN0cnVjdCBjb3VudGVyX2RldmljZSAqY291bnRlciwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgY291bnRlcl9jb3VudCAqY291bnQsIHU2NCAq
dmFsKSB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcnpfbXR1M19jaGFubmVsICpjb25zdCBjaCA9IHJ6
X210dTNfZ2V0X2NoKGNvdW50ZXIsIGNvdW50LQ0KPiA+aWQpOw0KPiA+ICsgICAgICAgc3RydWN0
IHJ6X210dTNfY250ICpjb25zdCBwcml2ID0gY291bnRlcl9wcml2KGNvdW50ZXIpOw0KPiA+ICsN
Cj4gPiArICAgICAgIG11dGV4X2xvY2soJnByaXYtPmxvY2spOw0KPiA+ICsgICAgICAgaWYgKGNo
LT5pc19idXN5ICYmICFwcml2LT5jb3VudF9pc19lbmFibGVkW2NvdW50LT5pZF0pIHsNCj4gPiAr
ICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZwcml2LT5sb2NrKTsNCj4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAg
aWYgKHJ6X210dTNfaXNfY291bnRlcl9pbnZhbGlkKGNvdW50ZXIsIGNvdW50LT5pZCkpIHsNCj4g
PiArICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZwcml2LT5sb2NrKTsNCj4gPiArICAgICAg
ICAgICAgICAgcmV0dXJuIC1FQlVTWTsNCj4gPiArICAgICAgIH0NCj4gDQo+IEFzIHRoZSBsb2Nr
aW5nIGFuZCB0aGUgYWJvdmUgdHdvIGNoZWNrcyBhcmUgZHVwbGljYXRlZCBtdWx0aXBsZSB0aW1l
cywNCj4gcGVyaGFwcyB0aGV5IGNhbiBiZSByZXBsYWNlZCBieSBhbiByel9tdHUzX2xvY2tfaWZf
Y291bnRlcl9pc192YWxpZCgpDQo+IGhlbHBlciBmdW5jdGlvbj8NCg0KT0sgd2lsbCB1c2UgdGhl
IGhlbHBlciBmdW5jdGlvbiAiIHJ6X210dTNfbG9ja19pZl9jb3VudGVyX2lzX3ZhbGlkIg0KDQor
c3RhdGljIGludCByel9tdHUzX2xvY2tfaWZfY291bnRlcl9pc192YWxpZChzdHJ1Y3QgY291bnRl
cl9kZXZpY2UgKmNvdW50ZXIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCByel9tdHUzX2NoYW5uZWwgKmNvbnN0IGNoLA0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcnpfbXR1M19jbnQgKmNvbnN0IHBy
aXYsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBpZCkN
Cit7DQorICAgICAgIGlmIChjaC0+aXNfYnVzeSAmJiAhcHJpdi0+Y291bnRfaXNfZW5hYmxlZFtp
ZF0pDQorICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQorDQorICAgICAgIGlmIChyel9t
dHUzX2lzX2NvdW50ZXJfaW52YWxpZChjb3VudGVyLCBpZCkpDQorICAgICAgICAgICAgICAgcmV0
dXJuIC1FQlVTWTsNCisNCisgICAgICAgbXV0ZXhfbG9jaygmcHJpdi0+bG9jayk7DQorDQorICAg
ICAgIHJldHVybiAwOw0KK30NCg0KPiANCj4gPiArc3RhdGljIGludCByel9tdHUzX2NvdW50X2Z1
bmN0aW9uX3JlYWQoc3RydWN0IGNvdW50ZXJfZGV2aWNlICpjb3VudGVyLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBjb3VudGVyX2NvdW50ICpjb3Vu
dCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIGNvdW50
ZXJfZnVuY3Rpb24NCj4gPiArKmZ1bmN0aW9uKSB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcnpfbXR1
M19jaGFubmVsICpjb25zdCBjaCA9IHJ6X210dTNfZ2V0X2NoKGNvdW50ZXIsIGNvdW50LQ0KPiA+
aWQpOw0KPiA+ICsgICAgICAgc3RydWN0IHJ6X210dTNfY250ICpjb25zdCBwcml2ID0gY291bnRl
cl9wcml2KGNvdW50ZXIpOw0KPiA+ICsgICAgICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgICAg
ICBtdXRleF9sb2NrKCZwcml2LT5sb2NrKTsNCj4gPiArICAgICAgIGlmIChjaC0+aXNfYnVzeSAm
JiAhcHJpdi0+Y291bnRfaXNfZW5hYmxlZFtjb3VudC0+aWRdKSB7DQo+ID4gKyAgICAgICAgICAg
ICAgIG11dGV4X3VubG9jaygmcHJpdi0+bG9jayk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KPiA+ICsgICAgICAgfQ0KPiANCj4gcnpfbXR1M19sb2NrX2lmX2NvdW50X2lz
X2Rpc2FibGVkKCkgaGVscGVyPw0KPiAoY2FuIGFsc28gYmUgY2FsbGVkIGJ5IHJ6X210dTNfbG9j
a19pZl9jb3VudGVyX2lzX3ZhbGlkKCkpDQoNCk9LIHdpbGwgdXNlIHRoZSBoZWxwZXIgZnVuY3Rp
b24gInJ6X210dTNfbG9ja19pZl9jb3VudF9pc19lbmFibGVkIg0KDQorc3RhdGljIGludCByel9t
dHUzX2xvY2tfaWZfY291bnRfaXNfZW5hYmxlZChzdHJ1Y3QgcnpfbXR1M19jaGFubmVsICpjb25z
dCBjaCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCByel9tdHUzX2NudCAqY29uc3QgcHJpdiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGludCBpZCkNCit7DQorICAgICAgIGlmIChjaC0+aXNfYnVzeSAmJiAh
cHJpdi0+Y291bnRfaXNfZW5hYmxlZFtpZF0pDQorICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQorDQorICAgICAgIG11dGV4X2xvY2soJnByaXYtPmxvY2spOw0KKw0KKyAgICAgICByZXR1
cm4gMDsNCit9DQoNCj4gDQo+ID4gK3N0YXRpYyBpbnQgcnpfbXR1M19jYXNjYWRlX2NvdW50c19l
bmFibGVfc2V0KHN0cnVjdCBjb3VudGVyX2RldmljZQ0KPiAqY291bnRlciwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1OCBjYXNjYWRlX2VuYWJsZSkg
ew0KPiA+ICsgICAgICAgc3RydWN0IHJ6X210dTNfY250ICpjb25zdCBwcml2ID0gY291bnRlcl9w
cml2KGNvdW50ZXIpOw0KPiA+ICsNCj4gPiArICAgICAgIG11dGV4X2xvY2soJnByaXYtPmxvY2sp
Ow0KPiA+ICsgICAgICAgaWYgKHByaXYtPmNoLT5pc19idXN5ICYmICFyel9tdHUzX2lzX2NoMF9l
bmFibGVkKHByaXYpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmcHJpdi0+
bG9jayk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAgICAg
fQ0KPiANCj4gcnpfbXR1M19sb2NrX2lmX2NvdW50X2lzX2Rpc2FibGVkKCkgaGVscGVyPw0KDQpP
SywgV2lsbCB1c2UgdGhlIGhlbHBlciBmdW5jdGlvbiAicnpfbXR1M19sb2NrX2lmX2NoMF9pc19l
bmFibGVkIg0KDQorc3RhdGljIGludCByel9tdHUzX2xvY2tfaWZfY2gwX2lzX2VuYWJsZWQoc3Ry
dWN0IHJ6X210dTNfY250ICpjb25zdCBwcml2KQ0KIHsNCisgICAgICAgaWYgKHByaXYtPmNoLT5p
c19idXN5ICYmICEocHJpdi0+Y291bnRfaXNfZW5hYmxlZFtSWl9NVFUzXzE2X0JJVF9NVFUxX0NI
XSB8fA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcml2LT5jb3VudF9pc19l
bmFibGVkW1JaX01UVTNfMzJfQklUX0NIXSkpDQorICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQorDQorICAgICAgIG11dGV4X2xvY2soJnByaXYtPmxvY2spOw0KKw0KKyAgICAgICByZXR1
cm4gMDsNCiB9DQoNCkNoZWVycywNCkJpanUNCg==
