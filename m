Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CFB5378B8
	for <lists+linux-iio@lfdr.de>; Mon, 30 May 2022 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiE3JHC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 May 2022 05:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbiE3JG7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 May 2022 05:06:59 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140057.outbound.protection.outlook.com [40.107.14.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7D54B86D
        for <linux-iio@vger.kernel.org>; Mon, 30 May 2022 02:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlwjF/6gqWlmip1mnwnFnXDcb1EJoOu2qH0EtwXG4DbVWFDa9PGwVNQP3rMNDaonYM/sdfkddKyO1GlD/jLo9uctT4QvwkYTAwRmbmrywKWNViuFso5Drwx82pI4/hn1UEr2rWehywFGyA30t4ulPXq364BLvPBi9lxdQzLZ2lL8ZWBNnqisYbPR0rVN+H/Rjd1P/I/ZPZ0iCcK0gxrL/WGUIsJt6FK7y3IdmfweofeHBzfW+P8V1eKS5VDibqCVpVXmefAn0D93FhXxVE7Su1AbeCTIzLKgIJ3XbjspbCBOTo8Z9DgoO1Z31X8OQ8QHaKHW3kVq5YEDrT1P8VqlMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxZT8nlMdW1IhP7vdBU4fdgZ8lL2+M5LI2X0/Djm6S0=;
 b=oa8t4GvgM4yTIKLWqYkFduNq+i6rWVdN8J+BWs598ubNvXvuM8ru1/OtQA+vPnypqO3r8hC/ennXdvZjzUizfOJRwQ7ePXfA3vp65yrVfxgTpcE6QP5xCLQyxz62H3xzqVKS3Vx1kyEQMfmbZI9//VyYeOtsYZe+OVNRkDx71FH2A+psgDWiX+JwjGd33WFA28a2ANW3arLNikcd6iFwblDR6DiqxkayVW6KcfAJPwytnR86UB/QLK1pE236J4HCZMGn3vZPF81P6xx8m9GgFBhGlHyaKH/WNlrjNTB/Y7hpK+KTWFv+j6qoY0BGAhNygmX0bUil1aApfsIl5VBU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxZT8nlMdW1IhP7vdBU4fdgZ8lL2+M5LI2X0/Djm6S0=;
 b=mm3wXLaxPX8K9HqaW0v7t3zIR4ZLuVlLYgAZJ0f5XFe2t0JD05/iaJLpzr7e0gNVb/mhe7LRaIiclYItZe0/BcxPlU9avJoJuX3wrWqi2j1EwfI/uHgf7ODyGDJ67SXZAHMLIOWqRj0rZPntuNMgthCJLTev3DStNLanHYBn5iI=
Received: from DB7SPR01MB0028.eurprd04.prod.outlook.com (2603:10a6:10:37::10)
 by PAXPR04MB9137.eurprd04.prod.outlook.com (2603:10a6:102:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 30 May
 2022 09:06:54 +0000
Received: from DB7SPR01MB0028.eurprd04.prod.outlook.com
 ([fe80::5d38:6c4f:89bd:4f6e]) by DB7SPR01MB0028.eurprd04.prod.outlook.com
 ([fe80::5d38:6c4f:89bd:4f6e%7]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 09:06:54 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Baruch Siach <baruch@tkos.co.il>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH] iio: adc: vf610: fix conversion mode sysfs node name
Thread-Topic: [PATCH] iio: adc: vf610: fix conversion mode sysfs node name
Thread-Index: AQHYdALawOtUC2RH0kmcK82h2bofga03IIdQ
Date:   Mon, 30 May 2022 09:06:53 +0000
Message-ID: <DB7SPR01MB0028368318C836EBA62D34A690DD9@DB7SPR01MB0028.eurprd04.prod.outlook.com>
References: <560dc93fafe5ef7e9a409885fd20b6beac3973d8.1653900626.git.baruch@tkos.co.il>
In-Reply-To: <560dc93fafe5ef7e9a409885fd20b6beac3973d8.1653900626.git.baruch@tkos.co.il>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e82a8f8a-658e-4b60-9c1f-08da421bbdb6
x-ms-traffictypediagnostic: PAXPR04MB9137:EE_
x-microsoft-antispam-prvs: <PAXPR04MB913703D1B1A7E1432396742E90DD9@PAXPR04MB9137.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tGnKVrW+/CyYOpPeIJIkv0yvEXmSI1RKW/XtH8+ETv9yjzWYKTKz4aQ/SlRBb39RhRMsfEv5jArp9FlYHCtexLu2lJqqI2vtttGtOb7XAeQpMvcTJeU1KVoyFx2tnMis9eDc5lL+6V9x2FYwNQLujlNpVt8naeDBii0e9WRpO2oEHfI0F0hJQ1FDnNaDfwmtrIfxIhVob/frBOXbEgNIiZ7ZiS1L7zdRFH4IPAbJoPYEdNGLQnmha+9ELM0c0DmeLeZ59vw2dFkjVKxmB3vCertM4ZL2VqdhkcKRkzdMcwV0Wmb1+Jl9pqcME2iMM5LdsU4J27jgvoU4KGNnKMmlC1FsZulLpxkndW8YkoEKlsWQ2suYTXq1ghvM8cST8DhvZYEKv1TOMWhhJh2M4a3or/Sh2v4xsPakMkjKGLzTnC2Hn8XO67g9Q9q5U9uJOq7lTIh3uyFJxFdTcWuN/aMTUQXOj+CEtTGNm/XF1R5uDDgfD11eJz8yCR8Bt9UdaXsvvrqxafkX7+LUslRYmQo8BpXG2/LVLz0U/5Smj3GGWvBD1DajQEdh4lmuymT5xNpX1aW2NmlLv2wcdDYKAosVDipkysm7HnSv3Stkoizp4r/TiI3AL1oabI7kOqWag9zM5EzpVpaaZ5TlUpGzqXJmoQNkLu44xkDEc6F6YKNlHY+tuomql5iBRa+paP4Xx8/Ojk4WWL+Dp/Bpe5eQiJaNBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7SPR01MB0028.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(508600001)(316002)(6916009)(54906003)(19627235002)(38070700005)(38100700002)(122000001)(2906002)(52536014)(8936002)(5660300002)(86362001)(64756008)(66946007)(66446008)(66476007)(66556008)(76116006)(7696005)(83380400001)(26005)(9686003)(186003)(55016003)(53546011)(6506007)(33656002)(4326008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UVVsd0tpNUcxZFpZZlpnem0wTEJ2Qlo4T2lNZlFvYzUyeXNSanYyZGg0SnFx?=
 =?gb2312?B?a3AzNEdWdGxQbjhNZ3Z5NnI5Tlh5QzVRNnZNUWJXMm83R0ZlQ09rWWNtdEs1?=
 =?gb2312?B?NlBUVUczZWxsdFpTU1lmTzR1cFNidngxSklQeXBMVXp5bTNzSVZuemlVeUxk?=
 =?gb2312?B?eWFBNVkraW5zQysxc21UdmkrRHFPU2ZKdlViZURyeEpEaW9ESThBdk5CNXZG?=
 =?gb2312?B?aFVuZDB3Y1FENWZLbTdZdUtUb1MrbVhOcmpjbjhvNGR1QUZVWE5UNzBWM081?=
 =?gb2312?B?MkgzRUtvZ1ZBa09rbTZHcGxtd3p5MWtXM1RuSDhOQ1lOTWNnWTF0MGtCZHdT?=
 =?gb2312?B?RWZYbFFRMGV0UjZMNW43b09RSHgyUWp0YlVRaGxsdENsSjhldkthcXFZU0xR?=
 =?gb2312?B?bXc4QmkvdVFpcWVxVG1MZ2pCODA3Yit2T1prN1dHbmZ1NnI5VGx0VHhMaFRG?=
 =?gb2312?B?U1BDcXRpSFArOUMzY3ZKRUdMZjh3UnNuZERrbjNtUXFra0xYZGhISnVWMmE2?=
 =?gb2312?B?ZkI2Mm5yMHd2dUdmK1pNTUZrTmRBcTIzMGR2Sm4rVDN6bEc1RjNZMGE5dWJE?=
 =?gb2312?B?ZTUxZlQxOURTTDVpQWhBVUE2QlBRc0xSdE5IZGhWUS92TFJZVGg3cFRDbnN1?=
 =?gb2312?B?U1UrbnJNdzFjV1Z3bmJ6M2xoUFd0SUprMkx4RlNrKzMvZ0hYa2ZGL1VDVWly?=
 =?gb2312?B?ZDVzOXVvZG5sTmtkRG9vdzZKd2RwLzg3UG4zMzJTS1dmVU0rdzJ1RWlmVVFn?=
 =?gb2312?B?Q0E1YXFtRnZXRjVQYzY1b2o2NENuWUNZVU85YnB4L3Z2Ykp0OFRETlFQTWNW?=
 =?gb2312?B?M2V4WUZzZGE2YVJrcVRDcGpOUlZFa2VmU1E0aFFUVmhNaEo3MTBMSGcvdlpR?=
 =?gb2312?B?bi80ZGdTZTdZZ1QyeGhHWHUyOWY0WHRXUTZFc2ZCVUhwMHhSYkdhVEJzWDFS?=
 =?gb2312?B?UkFsOXBrWTRlSVFsSDJZblJQWm9SdS82NkpIUTlsS0piNngwN1c2a0FUT3p3?=
 =?gb2312?B?NEJIaG1uZ2orMWo5QkhiUTAxL3ZHUjFLSlQzbm9iM1AxeXQ3UUo1c1E3VWlQ?=
 =?gb2312?B?WklGdEdWdnpCSldMNW5sVkFjOVl3V3FTYTJWM2NCU1E3SjczOEQvMU1hT0tP?=
 =?gb2312?B?R3A0UjRtai8vb2FTS29MMklFc09kSDdZeEpUTlBqQW1TcmIrTDRYeXg4NjFi?=
 =?gb2312?B?RVIvYUZwV2tNalltN3QxMGtmZXRJR1RoTDNtTnVnbmVHYnFJVm5NNEd0anAx?=
 =?gb2312?B?dlU1Yy8wWCs4bTM3ZEZSYkdBUEF3bjArUmM5T1pxQXNsTEJYaFRqTnd1WmRk?=
 =?gb2312?B?NnhGZ3cvWmVWQ2JoMERzcE0xVDlGVWRqNzNWR3R4OHRBZFBMdUU2ZmNtZkhL?=
 =?gb2312?B?L0hvTWJwL1hndWNqYk1MUlIzVUxKRkNkYTgvZG4rcWpiZEk3dUtLenhMdyt0?=
 =?gb2312?B?SW5ENi9IaEJiMUYzMHhUMy83aHNVZjByRnBZbXYrL1ZrYTQyc2Z2VFFQZkJo?=
 =?gb2312?B?bElJYnRHZENwSVBCdDBxTEtpN0lJZnNoS1lVUEdpMC9iVFpKVmw3WlZXc1Zv?=
 =?gb2312?B?RmxBYWVad3k5UmkrcFhnOUFIT3JCcCtJa1o3c2ZkYWl2cWkwalY2S2lxWmtu?=
 =?gb2312?B?dUt5Q0pycitINi9ZSldQYm0wdXZCcGM3YnI2SDgrWXhBS3gxLzNmZGRTaDFG?=
 =?gb2312?B?SlpKN1BhTWFoNVliTDZiYjdQT0ZyQldNTmx1TXB1L09tdGtvR0l3amlKMmQr?=
 =?gb2312?B?bjRraXk3TW1RRWY5Y1AyQXF4SzhNYXVRSjFuL2gyTkpvYjJTdFhEcldCa3kx?=
 =?gb2312?B?SkJwMVFVS2RXTHRJNWpLM1lOSUdCdzhPMXZ1UFZVOXVYd3NDN3ZKbGdLMkc5?=
 =?gb2312?B?Ym1uMkJIUDZ6YXRIMm94OWptY3ZtR3RoTkNKVVhmVkplUGdSVnYzY3lOUWRs?=
 =?gb2312?B?eGYrMlc3SVl0VmJ1b2FSMWlmVnlEMlhyazNhR3kzVGhRcHJ0ZGUwTkhmczlK?=
 =?gb2312?B?MUZRblg3R3lNaU55YVdaMnQwN0JOd2RUanNsNWVnTUxzLzN0eEhVVHVtd3NR?=
 =?gb2312?B?SGhvSCtzR3kreThaaUpPVmszbWZGV01FUFZoNDlFdHNtVG43Y1NDT2F5Mk5m?=
 =?gb2312?B?MVA4RlZZRnVRcWZ2dkpXMUFBQ2Fzb25QbDJHcmxnS2g4d2VXVjhYNjZJZGU4?=
 =?gb2312?B?RkZCL1QwTUlGWHFyYnFqRzJCQUpFUzlhYldmV2tvZ01OYnhwL092bHBSNFRK?=
 =?gb2312?B?L0hmdmw2OEpVdzFYdVJTQjByMmUvOU55UVFUcE13UVFFSFJmNkZ0WTZoM3Ux?=
 =?gb2312?Q?aJpMY1RDBcrYIYYL9P?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7SPR01MB0028.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82a8f8a-658e-4b60-9c1f-08da421bbdb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 09:06:54.0601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uavKFRBOr9JsvaXE2uygZwOjOo0BCsbtC4hWcM8izdNlkw16WG+TpMWNMta696mT5+BwEXmdVmzq9sDmpHNtsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCYXJ1Y2ggU2lhY2ggPGJhcnVj
aEB0a29zLmNvLmlsPg0KPiBTZW50OiAyMDIyxOo11MIzMMjVIDE2OjUwDQo+IFRvOiBCb3VnaCBD
aGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5l
bC5vcmc+OyBTYXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBQZW5ndXRy
b25peCBLZXJuZWwgVGVhbQ0KPiA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZh
bSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNv
bT47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IEpvbmF0aGFuIENhbWVyb24NCj4gPGppYzIz
QGtlcm5lbC5vcmc+OyBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IEJhcnVj
aCBTaWFjaA0KPiA8YmFydWNoQHRrb3MuY28uaWw+DQo+IFN1YmplY3Q6IFtQQVRDSF0gaWlvOiBh
ZGM6IHZmNjEwOiBmaXggY29udmVyc2lvbiBtb2RlIHN5c2ZzIG5vZGUgbmFtZQ0KPiANCj4gVGhl
IGRvY3VtZW50YXRpb24gbWlzc2VkIHRoZSAiaW5fIiBwcmVmaXggZm9yIHRoaXMgSUlPX1NIQVJF
RF9CWV9ESVIgZW50cnkuDQo+IA0KPiBGaXhlczogYmYwNGMxYTM2N2UzICgiaWlvOiBhZGM6IHZm
NjEwOiBpbXBsZW1lbnQgY29uZmlndXJhYmxlIGNvbnZlcnNpb24NCj4gbW9kZXMiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBCYXJ1Y2ggU2lhY2ggPGJhcnVjaEB0a29zLmNvLmlsPg0KDQpBY2tlZC1ieTog
SGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KDQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlv
bi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlvLXZmNjEwIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlvLXZmNjEwDQo+IGIvRG9jdW1lbnRh
dGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlvLXZmNjEwDQo+IGluZGV4IDMwOGE2NzU2ZDNi
Zi4uNDkxZWFkODA0NDg4IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5n
L3N5c2ZzLWJ1cy1paW8tdmY2MTANCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9z
eXNmcy1idXMtaWlvLXZmNjEwDQo+IEBAIC0xLDQgKzEsNCBAQA0KPiAtV2hhdDoJCS9zeXMvYnVz
L2lpby9kZXZpY2VzL2lpbzpkZXZpY2VYL2NvbnZlcnNpb25fbW9kZQ0KPiArV2hhdDoJCS9zeXMv
YnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2VYL2luX2NvbnZlcnNpb25fbW9kZQ0KPiAgS2VybmVs
VmVyc2lvbjoJNC4yDQo+ICBDb250YWN0OglsaW51eC1paW9Admdlci5rZXJuZWwub3JnDQo+ICBE
ZXNjcmlwdGlvbjoNCj4gLS0NCj4gMi4zNS4xDQoNCg==
