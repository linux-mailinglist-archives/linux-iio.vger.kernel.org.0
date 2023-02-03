Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9FB6892F1
	for <lists+linux-iio@lfdr.de>; Fri,  3 Feb 2023 10:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjBCI64 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Feb 2023 03:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjBCI6y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2023 03:58:54 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B026EAE2;
        Fri,  3 Feb 2023 00:58:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kW3OPOxi2zkGLcVi2HxHuAWmQBTlPE7vA1XXpJyx39SMTiwOzOKb0WqRrJoqvjvhS/tf8QbK3agCywW9w1rD36yiEt6fHOXPsh51ewiXObqqyNZci7JRoBtgipgNguyZU2kRuOv88LML6Wx/5tUR47zJ6iwjRt7a2jWXv4Ke7BmWjh3Zd14N3NBphpnLhv2HJFidXsJEgy12/1V1wkktSPRq7xQVOiP2mFUYiE9z3Uf2aIqiS4odNEREIEoUNtWIAAWWyUFYIBJJZ0ZE0P+zAXebBad5hgMnSAeKPTMfIVILx0FwYZ6pqzEr1IBy4NaTC+Di6D0p3ljKSUVeRWRkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnokkIYO6MtMt+tP7HEM08SktbmVBKaj/TN4hsBznrE=;
 b=g7wLsj8E/670C2CFItFRQYaBQOoJL8fS+FyBMwMh+qczUHBWWEPWb4c60d0aeHnNYaOLiNwO7zJKTMyd4c+cKeJ9XhQdtnf0HU8RWJlMZY7JEuREnWVbgFVFigWwMRe1Hy4H6QaRqV+PJ5ZPT4e6CjLI+WIXah2fzBu55yuQDbRghse5tqyP9GXzoyX1LNXSGX7IqaC1J3qnw0LPhEpsaWUbfrZFfIpwGdlX1F5oFmhrw/q4/QQEtjVP9IHTTdxvijJoww9sJNVzyQYdjby3Hft6V/697TPDuyrgU28p22W0MjJfMcyvLBkEnHNgGlu87eVmpc7iM+0sTD9a/VNWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnokkIYO6MtMt+tP7HEM08SktbmVBKaj/TN4hsBznrE=;
 b=vQ9fcAgqNBz3JzE2LC4oylOvoadtSvj3HTkZI2QRAotIKLZWpcCSFIKbWM1EcfsMc29LU1ZauYNl0QH2hgh+14bjYzYwc5KFiCtL89MnPsTP5KKUF/Ed1CvYQFjtg1cXF2kBj45oOQSslt53BtUTAdDUDXTJmXTp8Pz/d0VevIE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6275.jpnprd01.prod.outlook.com (2603:1096:604:f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Fri, 3 Feb
 2023 08:58:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6064.028; Fri, 3 Feb 2023
 08:58:47 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v12 4/6] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Topic: [PATCH v12 4/6] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Index: AQHZNyeI91/kMj3+9023YpUUWnbht6683P8AgAAPhbA=
Date:   Fri, 3 Feb 2023 08:58:47 +0000
Message-ID: <OS0PR01MB5922BF3489BC0A263DB60DAA86D79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230202165732.305650-1-biju.das.jz@bp.renesas.com>
 <20230202165732.305650-5-biju.das.jz@bp.renesas.com>
 <Y9y/PDUKoyexFIpN@google.com>
In-Reply-To: <Y9y/PDUKoyexFIpN@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB6275:EE_
x-ms-office365-filtering-correlation-id: 3b8e8a10-8748-48df-9fe2-08db05c4dc5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2aJa7NcB61y2yFZbBVaWGISrzAHgCh9SQW9tT3Ej3F8jIDpLXjYA7BdxdFWbvI5F0kenbuBsIvyhKLZJOskYZAj+Y8T59cBaRrNLJJTgMiey1v5nPIxtqkursATRsfhGQMgvKt+FS/eM96nYeih8xxknbXz9Qh8gk40Ru1s7CByOPLfA2hIEbVG1y/JjOtVt5VB6wJ/jeCYZ/Ysz5EYDpUJ1WYycbdtgStnCbeECW+Le961P+PQgP5TFDhwXlSeR6xiNVNyBkVxlOIvdamF+pLI6lmxrL2FzJ48bzu2SyLhTN4GeZwYHRjGaTVzdjipZwE1lTJud7n5/iLQ6E99ZAwTisokpo09Kmb49eJvJeZFoCO8QSN1Qat+oQKF2jutSKbISWeVSWNmbyucHz7gb3Ykx73Xho4wTqyFHcBGRLf9AzjmVfgTG4BvCsYKNo5fKY4wQIp7zpbMtmCDN9AkLEieWvGYk9p6X0rOnVyAtgslZf/5thu498+iBTUZeL/FGCOsKLKVa1kZO9sdk46gml2bl4DZR18mbMEuxeX1Xr+LI6U8JBeGnDrNl+R8P9Nos36/I3NMkV/Fwk2Y+1wRrMZWgqmodGqtdw3FW7b5vF86T2YG9pQ8JTJv/S3Hw4B3ArkJ4RyksqexX6LGHk6FXCzGaLDCnLu/f0RLyG92+2NtnXQjMJls0T+9uLDzvNVIZgEdnsHJhcbO2xcQoe2yZyhsTqCH2P0OOYxC+NrhA9Xo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199018)(71200400001)(478600001)(2906002)(26005)(7696005)(9686003)(53546011)(6506007)(8936002)(41300700001)(8676002)(66556008)(76116006)(66946007)(64756008)(66446008)(66476007)(4326008)(186003)(316002)(110136005)(52536014)(5660300002)(54906003)(122000001)(38100700002)(33656002)(55016003)(86362001)(83380400001)(38070700005)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGVLUmRCZUtncWxEaGJsaFBIRjF6REZ1UDM2aXNRWjR6Vi9MSENzTklwdGl0?=
 =?utf-8?B?bWxpc2JXaWE1eHgrRUFnNlZnRTVFVUVabklsZFh5Y3c3dU15eUIxNjYxeXM3?=
 =?utf-8?B?K0RZUEs3bHhZOXlTQVhNRnhGalcrTmtLa1ZCY0VzYkNpQzNLZWQyZzFnZHV1?=
 =?utf-8?B?U1hRTWFXZU56YVpUUE42UVRUNWJmYUdQNklJN2pCNjJwTlJGTnZ2Q1lvaDdp?=
 =?utf-8?B?dmlZVXdPQ0VQQ1R2UW9zYkg5dmJ3Z0o5L2Fza0hFLzlLeEZwak0ydVNsSy93?=
 =?utf-8?B?Y1hGbVNZUkdYdGFpcEcvMk42dlRJMGZCUnhnQ0RGdWlVYW91QTlsNG9KU1N1?=
 =?utf-8?B?VnM1dWNBZkdENmpoZUVBeFAvSXgzZHpHRGpUU3RKMnRBQzd6TDRXVUtiTnIr?=
 =?utf-8?B?c2U0YzdneW4xcXd6d3pqNCtoZi8zNWoyV3IyeG1RTEpuNnd2Vi9HbTNvcHpo?=
 =?utf-8?B?NGh4VVpxU2E0UXppRmpqTHZGei83alFzYlYyODdkVjVyQWxiVzFZakFhQk1X?=
 =?utf-8?B?NjBSQkJaWURlOVlVMDB1d0dUYy95RDR1SVBHME51RXVPK2NFbHl0cVo2RmJU?=
 =?utf-8?B?USs2QW1nL1ZSZ0JXTlgxSmNHYnlGaTVpazcwUy9YOVhYNzcyc05yc1JDQnBD?=
 =?utf-8?B?OUZ4ZHpOc3duNFM4YXFWemtQY0pYRzlYQWJZdzViM1lyYVhxTFF2K1V6cUlh?=
 =?utf-8?B?UlVWVWU2NkdlNEREVmhGWUdLQUErUGpmeERod25XZ29jVXJaRXVsbG9DeS90?=
 =?utf-8?B?aGI5TWJBN0hYRE9scGFnSktzb1ZRcnV6YUVzRnFnK2F1TTJ5S1NkRm9UeDVr?=
 =?utf-8?B?OFNTak80bm1XOS9KMCsvOWJCWHUwckg3QzhibWJTMjVPMWR1c09vajRaZGhp?=
 =?utf-8?B?MzlpOVlNK04xNGUyMzQ4eHUydFZ4bWpqWENPUzdnMFMxbjNlSFdaR1M0ekUw?=
 =?utf-8?B?cGdWVWxsZFVuNUVIQ1kvS2NDSDFZeWc5RnhnOUVTTU5QQ1NHWUl1NTVuMjd5?=
 =?utf-8?B?ZmxQU29OdVk1M29mMzJiTlQzc0oyWVNsOEd1aXBEWWdVZ0NXTXFjSG1LNkRh?=
 =?utf-8?B?N0xBQ2FlN2I4TjFkSXdyUm52WG1GcjNkYXAxRWpUQUdLU05KdTRFenZyQ3Zu?=
 =?utf-8?B?Z0FSbXorbFhoeWs4UGZoNTBqZEF6bkVXVnQvYnA1RUJHVXkyaHNEUkdnNWdV?=
 =?utf-8?B?TExDY2M1ZStzSTFBRlFjN0ZRTGtWZXZCQVVGTXU5MHdESjJXNkxKTXFMcTdy?=
 =?utf-8?B?NUhpOWJTc2JsQldtWUhVT1JiQnpkOG9YWVFuK2o3dWRzYmdiV2RxdWJuL1pT?=
 =?utf-8?B?dHJjU3dYUkR0c09xRTJ5ZU9uMElrcVcrdGs0b2JiWG1YKzd5dVo4dFQwbDBv?=
 =?utf-8?B?VXBmYmJxU2d4MW1rZnNIN2VLN2hrYkpyMzNiQUZjUGM4RGF1SmlBaXcwU0hM?=
 =?utf-8?B?Q3ArSjNXNFVrR0NtMVE2T1NXT2RyMnF4U1puR0ZPZnBvNjROWGpRN0tVaWpN?=
 =?utf-8?B?S0wyL2t5Z2lLWmQwYWR1WFdKS3FUQW5TQzEweGlYMkRTQ3YzNWtIYUxxUTZJ?=
 =?utf-8?B?d0tadVIxTUh1bURLb3FuSWJMSHIzOVJHcXllOVJXZEl1VFIrZkF0aW54ZVhu?=
 =?utf-8?B?eWtWaEY4TEMvOEk1cC9KYzQ1eVRuQlp0cjJqUW9sTUZxR0VRY3Z0YzhHcjli?=
 =?utf-8?B?VVBtTmpTa05DUkwwZlliSVh0UjBiT1RUcXp2NDFKekNFWDdUZXFjckEzeVps?=
 =?utf-8?B?ZDFCZmZjRDM1ckVrY09vSHphRjM4SHZpOGNjS3dMZ29Pb2FMWTVLZDRaQVlD?=
 =?utf-8?B?WkpaYzJibzNZU05OKy9uTlQzSU5WdzZMWk1oUHU0cjF5d2lCTzZwcEtZWmVi?=
 =?utf-8?B?SEE3WjVIQWI3bmtHOElobkl4MEpuT0RVcnZOR3g1QldzWC8ySnNiUU1UZFZw?=
 =?utf-8?B?aTU1bVpBN2tQNk1zdzdvcTMvWkNDbDBQcDdheGdPUGRjSHBPcEozenVENGJw?=
 =?utf-8?B?TUlsbEh2WXdRbWlXUmNOc3gwT3VOMEZkSDNDQWhnOVRNNlEvUzVlby9xODdt?=
 =?utf-8?B?SVYxRXM5OUFOQm9kVUFESE9oZ29rNU9XcGRsOEtxaTc3NTNSR3VOcTExUisw?=
 =?utf-8?B?ZitVS2JCd0wrbXQ2MFZ4OFpSd0RZc2hvbktRdVVvQjd4UFJZeTZoQjlMOWJi?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8e8a10-8748-48df-9fe2-08db05c4dc5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 08:58:47.1153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGlyeOvDI8nkiD3dfBgUs2H0vDgAMZmDjUUmPyfY2RG8F0C+TsmB1YlOoxam3goKvWtpogyIPDLh+a/W8QJ6XoWQJMkzbkzDs+v0mkK0/JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6275
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQpIaSBMZWUgSm9uZXMsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExlZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+DQo+
IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMywgMjAyMyA4OjAxIEFNDQo+IFRvOiBCaWp1IERhcyA8
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IENjOiBXaWxsaWFtIEJyZWF0aGl0dCBHcmF5
IDx3aWxsaWFtLmdyYXlAbGluYXJvLm9yZz47IGxpbnV4LQ0KPiBpaW9Admdlci5rZXJuZWwub3Jn
OyBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz47IFRoaWVycnkNCj4g
UmVkaW5nIDx0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb20+OyBVd2UgS2xlaW5lLUvDtm5pZyA8dS5r
bGVpbmUtDQo+IGtvZW5pZ0BwZW5ndXRyb25peC5kZT47IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2Vl
cnQrcmVuZXNhc0BnbGlkZXIuYmU+OyBDaHJpcw0KPiBQYXRlcnNvbiA8Q2hyaXMuUGF0ZXJzb24y
QHJlbmVzYXMuY29tPjsgUHJhYmhha2FyIE1haGFkZXYgTGFkDQo+IDxwcmFiaGFrYXIubWFoYWRl
di1sYWQucmpAYnAucmVuZXNhcy5jb20+OyBsaW51eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTIgNC82XSBjb3VudGVyOiBBZGQgUmVuZXNhcyBS
Wi9HMkwgTVRVM2EgY291bnRlcg0KPiBkcml2ZXINCj4gDQo+IE9uIFRodSwgMDIgRmViIDIwMjMs
IEJpanUgRGFzIHdyb3RlOg0KPiANCj4gPiBBZGQgUlovRzJMIE1UVTNhIGNvdW50ZXIgZHJpdmVy
LiBUaGlzIElQIHN1cHBvcnRzIHRoZSBmb2xsb3dpbmcgcGhhc2UNCj4gPiBjb3VudGluZyBtb2Rl
cyBvbiBNVFUxIGFuZCBNVFUyIGNoYW5uZWxzDQo+ID4NCj4gPiAxKSAxNi1iaXQgcGhhc2UgY291
bnRpbmcgbW9kZXMgb24gTVRVMSBhbmQgTVRVMiBjaGFubmVscy4NCj4gPiAyKSAzMi1iaXQgcGhh
c2UgY291bnRpbmcgbW9kZSBieSBjYXNjYWRpbmcgTVRVMSBhbmQgTVRVMiBjaGFubmVscy4NCj4g
Pg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyAzIGNvdW50ZXIgdmFsdWUgY2hhbm5lbHMuDQo+ID4gCWNv
dW50MDogMTYtYml0IHBoYXNlIGNvdW50ZXIgdmFsdWUgY2hhbm5lbCBvbiBNVFUxDQo+ID4gCWNv
dW50MTogMTYtYml0IHBoYXNlIGNvdW50ZXIgdmFsdWUgY2hhbm5lbCBvbiBNVFUyDQo+ID4gCWNv
dW50MjogMzItYml0IHBoYXNlIGNvdW50ZXIgdmFsdWUgY2hhbm5lbCBieSBjYXNjYWRpbmcNCj4g
PiAgICAgICAgICAgICAgICAgTVRVMSBhbmQgTVRVMiBjaGFubmVscy4NCj4gPg0KPiA+IFRoZSBl
eHRlcm5hbCBpbnB1dCBwaGFzZSBjbG9jayBwaW4gZm9yIHRoZSBjb3VudGVyIHZhbHVlIGNoYW5u
ZWxzIGFyZQ0KPiA+IGFzIGZvbGxvd3M6DQo+ID4gCWNvdW50MDogIk1UQ0xLQS1NVENMS0IiDQo+
ID4gCWNvdW50MTogIk1UQ0xLQS1NVENMS0IiIG9yICJNVENMS0MtTVRDTEtEIg0KPiA+IAljb3Vu
dDI6ICJNVENMS0EtTVRDTEtCIiBvciAiTVRDTEtDLU1UQ0xLRCINCj4gPg0KPiA+IFVzZSB0aGUg
c3lzZnMgdmFyaWFibGUgImV4dGVybmFsX2lucHV0X3BoYXNlX2Nsb2NrX3NlbGVjdCIgdG8gc2Vs
ZWN0DQo+ID4gdGhlIGV4dGVybmFsIGlucHV0IHBoYXNlIGNsb2NrIHBpbiBhbmQgImNhc2NhZGVf
Y291bnRzX2VuYWJsZSIgdG8NCj4gPiBlbmFibGUvIGRpc2FibGUgY2FzY2FkaW5nIG9mIGNoYW5u
ZWxzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBXaWxsaWFtIEJyZWF0aGl0dCBHcmF5IDx3aWxs
aWFtLmdyYXlAbGluYXJvLm9yZz4NCj4gDQo+IFdoZW4gd2UgY29tZSB0byBtZXJnZSB0aGlzLCBh
biBBY2sgd2lsbCBiZSByZXF1aXJlZC4NCg0KWW91IG1lYW4gYW4gQWNrIGZyb20gV2lsbGlhbSBC
cmVhdGhpdHQgR3JheSBhbmQgeW91IGNhbiB0YWtlIGl0IHRocm91Z2gNCk1GRCAoaWUsIGNvcmUg
KyBjb3VudGVyIHBhdGNoZXMgdG9nZXRoZXIpPz8NCg0Kb3IgDQoNCllvdSB3aWxsIGFwcGx5IGNv
cmUgZHJpdmVyIGFuZCBjcmVhdGUgYW4gaW1tdXRhYmxlIGJyYW5jaCwgY291bnRlciBzdWJzeXN0
ZW0NCmNhbiB1c2UgdGhhdCBicmFuY2ggdG8gYXZvaWQgYnVpbGQgaXNzdWVzIHdoaWxlIGFwcGx5
aW5nPz8NCg0KUGxlYXNlIHNoYXJlIHlvdXIgdmlldyBvbiB0aGlzLg0KDQpDaGVlcnMsDQpCaWp1
DQo=
