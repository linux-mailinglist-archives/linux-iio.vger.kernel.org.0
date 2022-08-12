Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E625559105C
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 13:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbiHLLwF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 07:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbiHLLwD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 07:52:03 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20081.outbound.protection.outlook.com [40.107.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0B6AF0C6;
        Fri, 12 Aug 2022 04:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koYULii32z2UoubDrkB8qB8zJN+sJ9oyyhtTLkLS2vbkqOpCM34ZxQKnzYGQ3IlWyihMvfbc4qE/jPQJy3VmJ2GGaMrxfLT7Zn7WIAfCEzki0kpOtg6dUl+MbvgX7kFvkJ+zqGC7we4G5asgfT5QlXgGABynig9gCJNpUzWTy0SDKuacJacGjFzUrZlopIwCx1Z9KLvi8OOtXLi3ZtkcGLBhxVrabIt8soAJzwf5NkmE5opixykdosaEGRXORZDFhYWU4uYuh7gk+A1VSFp9H38aTh+t42jpTNxp3CMD4+ixS8JzXSSJAM4p3s6u2ulMsx7560IQMvCF94T04pdjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/N+K2AwQs/ldT1KMSL3atKqGCOAZrP9nz88Z+IT3dQ=;
 b=L8JCoQWNEK+SL9h4eOz6/fkBTcRzNAoM51CAE0Vec5MkrEc9bewIjhhpXuE4pIYQFhw2fCcnj0tEVWqvxjWIA2Wod5ay5KLC0sMtPqjbvwAVlnj4DW5OLLaPgdUbR7MuuMFSXh17mo+9s6h76lDXDN8DehDdHXGgZKD+nveVbMkoZh9vYaf8XR2/bbNnZRW5SjThoGEX0il13I1UodIhshJCCOfhXk8fObFBBH4AOrEjJWkfcG77OX49c1VyJckNLRuk8u2+mjGbJphO8vB4kixEd/qmxpmyBUAGqesvrSijMshXGJlWROZ555SE60l6QNdocsIfascs9XVNG//EnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/N+K2AwQs/ldT1KMSL3atKqGCOAZrP9nz88Z+IT3dQ=;
 b=hhmadpQue0esuJ0dP0KZAcKK70nzedjlqONXsAPz76N4zyLTUxVUGVB0KNgVfwiezAAhI9DGUTudFZVDF8+yng4CnWvokCg6MdgHqOuNrjtBFNdsd359YR4B4EC12CcCaaSI9Ut2eQwoulWsztRGmYn9RplpNipRhYR0dHK31LQ=
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27)
 by PAXPR04MB9492.eurprd04.prod.outlook.com (2603:10a6:102:2bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Fri, 12 Aug
 2022 11:51:59 +0000
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::b020:6e17:a5ef:8871]) by VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::b020:6e17:a5ef:8871%7]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 11:51:58 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: iio: adc: Add binding documentation for
 NXP IMX93 ADC
Thread-Topic: [PATCH 2/3] dt-bindings: iio: adc: Add binding documentation for
 NXP IMX93 ADC
Thread-Index: AQHYpxt9KWDqyJ673EyktV6rN9jRtK2c9voAgAD2stCAAGbDgIAM0n0A
Date:   Fri, 12 Aug 2022 11:51:58 +0000
Message-ID: <VI1PR04MB40163F952AD90A73664A560A90679@VI1PR04MB4016.eurprd04.prod.outlook.com>
References: <1659517947-11207-1-git-send-email-haibo.chen@nxp.com>
 <1659517947-11207-2-git-send-email-haibo.chen@nxp.com>
 <8afe7812-7dbd-7257-2a55-b4ae49f47381@linaro.org>
 <VI1PR04MB4016C146F9C8EF90557B362F909F9@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <d8fec5ab-2e03-4df0-f858-4a83c6f23233@linaro.org>
In-Reply-To: <d8fec5ab-2e03-4df0-f858-4a83c6f23233@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75b59b35-9a07-4759-5f6e-08da7c590ff9
x-ms-traffictypediagnostic: PAXPR04MB9492:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xxVwTF9pMEfr7o+sft/bPv4wsJFySEtNPIM4wTm9/z8D9zh/ets52xLia5K3an+u73T4fnYNje+Vs6fomZ8HTVV+NmssgaTx3qokrJYHechSZNTA7tC2syka+2syKePcBuYMLhs3QEfi19yqu90Ag4ntMf7KH+1Bj0E68DfEEcVlCNWAMdV5H+Bgi64spFQLdVs0fhSznNkcbqD6rs41WwtSVKbIrGwDWCZdV1RP4fHBZixtdFmm/CIdO6yhVo+hTW4RfUs6z2gWzy/Ktybg4trJorj2t8jiga8rNTcvRkQ2fnoyHL+VcwW5z8Oqimk7W5zcVSj2R9BRdcj5xWEMvc9PqkpCDwGTeCPFfyfnteYROSpo93eu1xSDHzzQgi/mEO1T1HEB8Biyz90D9rCUJAVs21VP+evkacvlzluuI5k43a92fI8jguiB0rTdPvATPAYSB1LV+wmvrQVAkMTM3BbowoB2hRTxqDZRyaF1HSS4mt7fj6QGMymbA72dA4mzXTCIuLcIM8GfSW3c0aw/SfW+oIwcyvZmmglphctG0mWDLqARYYip4ePh3Cua+23Qu18Zfzsq1gEcet8ODzh67xrrKasPcebjhEa3djauV9S8vE4y5AUE6ig9RDHZ3mV3tR9RNfngzv8JeIrGybilSRyFvXOgO4BhWBd+F7vHiMyM9n0rQzsGX1MuK9PUnecSFmOm1a+NpnL7ayBzv2eR/LrQOVxEgCXICCucPLRW+iHo0vuseigm31czaoNcQ2hX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(45080400002)(2906002)(110136005)(316002)(41300700001)(186003)(54906003)(55016003)(33656002)(38070700005)(86362001)(64756008)(52536014)(7416002)(66946007)(8936002)(5660300002)(76116006)(38100700002)(122000001)(83380400001)(66476007)(66446008)(8676002)(4326008)(66556008)(26005)(478600001)(6506007)(9686003)(71200400001)(7696005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aHFpYUFHa1hocmdMcmVoRVRhZVlYYUFrVGoxdWVFTWI0L2Z2RGt1dTcvV1Rq?=
 =?gb2312?B?UHpJTUNTeTFINWtURldkQnhiL1ViMitseVlra1AxczZHMUxKSjNha0hVQkt2?=
 =?gb2312?B?SDArZDdZN2orem85NDUremlvUXArWTh4YlpFMzg5S0NLcDBtbmVqY0IzbEVl?=
 =?gb2312?B?dnJhZHBYQ3lFa1FFZlI1aXFxNkFhOENMcUlMM0dSVW1YYTd6UkJuZ2FNT1M1?=
 =?gb2312?B?c0VNNGkxMTFXdEx2MVpEMkg3emJTRkxIK1lFSUZtV2N2eHVFbHFaSlhNTTFB?=
 =?gb2312?B?QnJ0SXRUbUdiNVUzZ21LWU9aN0ZWbVJEWTFZZ2NJVTlRRi9aenlhN1lXeTZK?=
 =?gb2312?B?MlkvM2ZxR1VCcWdveGNUY0RlTEFPU3U5L05QTFJBTm96T01uRE5SRWRJZTMy?=
 =?gb2312?B?a2pnSFpkREp0OU40bGVRSUkxZ0FJdFJHd2IrcEVkTGVNcHkrcktpc2tUWWxl?=
 =?gb2312?B?WnZYY0xlaWY5MksrWjhxMms3NVlnNzF3Ym5OdGtLczdzcEwzVWcwRmp0Skdk?=
 =?gb2312?B?N2NudUtYY1pQSUUxWTI0b05yZThhcmNOTzliSUhtam56UHoxNHFCWjE3T2Yx?=
 =?gb2312?B?WDZoS0hQdHdoMisvSm4rNWY5UDQxdnV0eFhFdWM5U0JxK0xubXp5Y3hDUTJs?=
 =?gb2312?B?THZNYVRydVVvblhTclNCc0NwRUlEY1NWcXZSSHM0YkhPaUdhbjluSE1sM05N?=
 =?gb2312?B?U05Cd0FZTkY1UFVYNWpFSzJOSDhlWENXSitSQ0N2aHlxNFF6ODgySG5GVU9B?=
 =?gb2312?B?MU91SE1BTXNQZUxyWlhNeit1UHpWckZOdkpmVVF3RjVvVk9vSU1ET3J5dW8v?=
 =?gb2312?B?YWVhSUZkTFhxTTVkNzVkRG5aSjZYeE1ZT3h6eGRSZzFlNndJT2N0RFY3eWs0?=
 =?gb2312?B?RUwzbDEzYytacDVVMVlQZTIvdDdUL3BWMXZqTGtMRzZjamFKVkN2OGRxbDJN?=
 =?gb2312?B?aG9NS25mT25zMmtJT1NIWDF6NTFpTDBGS0QyRlRkdjZHSVYzVWg0WndTMnpr?=
 =?gb2312?B?dkhUUXlCTThhMGNKZDYwcjBwZjRCS0gvS3VZNjVpZERTUFQ3TFQ3NUJHQytZ?=
 =?gb2312?B?MmxZRnNscUE3Zkp2NUZUYWgwSnlNYm0zbmpnSy9BbVlQNitHSHhGRGJoSW1w?=
 =?gb2312?B?YjlVNnlLOWxYSzQwY2ZhWUVsM09BTVhCZHFaMlpycTFMNGhkWWUzYms3anVt?=
 =?gb2312?B?L21QTnY3U2E4OXZoMXJzenJqZ1I1SHUvUE5MekROaEpmeXo1WXU1dzNHaUto?=
 =?gb2312?B?N2R2c3g1UE1HSUtTa0h1SFlHWVdGeFpOWU9Ka3hjaFNBbHpzZ3ZKbGRKVVcv?=
 =?gb2312?B?dUJqaFNZQ01kWDhtV1J0N2F4TlVTOTBub3RDdFNGeUhiMC9BWWpFUTBzRm9N?=
 =?gb2312?B?NElvUDVFazYrSVl2WWtFSlk1bStTT0tQNzJSY1BmWGtvTDJrNnVDRWcxT1ht?=
 =?gb2312?B?bjdIbVhXKzczZW1hK0NPZVQ0VE1RZFBWWk1aRE1CaE9MWlVhSFUzd1g4ZGFq?=
 =?gb2312?B?MmdzeU5vWHJ6MGt1Y2g2dkxQVjRxblFjRUowRmwxQ0tVdiszTVdHd3RqakFi?=
 =?gb2312?B?OWh5bSthaTNOZTVsRE5vMmhBL0FsUVpVTDIxektaWXIwVkZ3bjBFTHpZcjkz?=
 =?gb2312?B?M1hMcjhlR2dMY3R2S2kzZlFsSHU1Y0Y2dHpuZDFEa2xVOHU1cjYwdFBNa1VU?=
 =?gb2312?B?cU8yQkxubWdhUGVnU3VZRzNka1gzVXpuOEcxYXRnbmgxTEFLaFRtbTZVaGRz?=
 =?gb2312?B?d29pazJTU1ZUWWcweUpRRFljNWNzT25nMHBpbzhRcEtCdGF6TThLemRsL2Zk?=
 =?gb2312?B?Lzc4dUYrUnZmb283aGRXMWwzNDMwUU15bStXL0gzdGV6Z0JScWpVN0lqT3Fz?=
 =?gb2312?B?WkNpNGUwV3RyWmpxMXNhWlh4cUFDQkltTlY2RVNtbWhFRGYrUmJlZFhJZ1Zl?=
 =?gb2312?B?S2t2d2lqcWE2N2Q5OWFTc3ZpN1VQK0xnTzd3WVNsaU40THhwZ1Z4NWpsQXdt?=
 =?gb2312?B?am01YlIwTmZDeWpWeS9EYWRMdTNiWUt6MFBpOElLT0lRbjZlcWRuZGcwTE9s?=
 =?gb2312?B?Wit4a1NueHFSWm9uc0Nka3U1c1VJVzNnNm93WVNCVE5WNHNTTlZ2dnlwZWQv?=
 =?gb2312?Q?9m7OFZjcycRuXMeGHZEMQAVzP?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b59b35-9a07-4759-5f6e-08da7c590ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 11:51:58.7968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjaem3aXqZsIajaZXlWIDF1/+wcFD/eHfjBMoNI8GTcPmLGWo8k2DVgIF7seDE/Xs+P6DWbpy7xtN/vyeCFw8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9492
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjLE6jjUwjTI1SAx
NToxMQ0KPiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgamljMjNAa2VybmVs
Lm9yZzsgbGFyc0BtZXRhZm9vLmRlOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5r
b3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBw
ZW5ndXRyb25peC5kZQ0KPiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFp
bC5jb207IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC1paW9Admdl
ci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDIvM10gZHQtYmluZGluZ3M6IGlpbzogYWRjOiBBZGQgYmluZGluZyBkb2N1bWVudGF0
aW9uIGZvcg0KPiBOWFAgSU1YOTMgQURDDQo+IA0KPiBPbiAwNC8wOC8yMDIyIDAzOjA1LCBCb3Vn
aCBDaGVuIHdyb3RlOg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9t
OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+
ID4+IFNlbnQ6IDIwMjLE6jjUwjPI1SAxODoyMA0KPiA+PiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8u
Y2hlbkBueHAuY29tPjsgamljMjNAa2VybmVsLm9yZzsNCj4gPj4gbGFyc0BtZXRhZm9vLmRlOw0K
PiA+PiByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9y
ZzsNCj4gPj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZQ0KPiA+
PiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4
LWlteA0KPiA+PiA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
Ow0KPiA+PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogW1BB
VENIIDIvM10gZHQtYmluZGluZ3M6IGlpbzogYWRjOiBBZGQgYmluZGluZw0KPiA+PiBkb2N1bWVu
dGF0aW9uIGZvciBOWFAgSU1YOTMgQURDDQo+ID4+DQo+ID4+IE9uIDAzLzA4LzIwMjIgMTE6MTIs
IGhhaWJvLmNoZW5AbnhwLmNvbSB3cm90ZToNCj4gPj4+IEZyb206IEhhaWJvIENoZW4gPGhhaWJv
LmNoZW5AbnhwLmNvbT4NCj4gPj4+DQo+ID4+PiBUaGUgSU1YOTMgU29DIGhhcyBhIG5ldyBBREMg
SVAsIHNvIGFkZCBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIE5YUA0KPiA+Pj4gSU1YOTMgQURD
Lg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5Abnhw
LmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIC4uLi9iaW5kaW5ncy9paW8vYWRjL254cCxpbXg5My1h
ZGMueWFtbCAgICAgICB8IDY1DQo+ID4+ICsrKysrKysrKysrKysrKysrKysNCj4gPj4+ICAxIGZp
bGUgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0K
PiA+Pj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbnhwLGlteDkz
LWFkYy55YW1sDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdA0KPiA+Pj4gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9ueHAsaW14OTMtYWRjLnlhbWwNCj4gPj4+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbnhwLGlteDkzLWFkYy55
YW1sDQo+ID4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+Pj4gaW5kZXggMDAwMDAwMDAwMDAw
Li5lMGVhYzVhYTgxZDcNCj4gPj4+IC0tLSAvZGV2L251bGwNCj4gPj4+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL254cCxpbXg5My1hZGMueWFtbA0KPiA+
Pj4gQEAgLTAsMCArMSw2NSBAQA0KPiA+Pj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChH
UEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkgJVlBTUwgMS4yDQo+ID4+PiArLS0tDQo+ID4+PiArJGlk
Og0KPiA+Pj4gK2h0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwJTNBJTJGJTJGZGUNCj4gPj4+ICt2aQ0KPiA+Pj4NCj4gPj4NCj4gK2NldHJlZS5v
cmclMkZzY2hlbWFzJTJGaWlvJTJGYWRjJTJGbnhwJTJDaW14OTMtYWRjLnlhbWwlMjMmYW1wO2QN
Cj4gPj4gYXRhPTANCj4gPj4+DQo+ID4+DQo+ICs1JTdDMDElN0NoYWliby5jaGVuJTQwbnhwLmNv
bSU3Q2ExMWNkMTI4Zjg4MTQ5Mjk2ODRiMDhkYTc1MzliDQo+ID4+IGRiYyU3QzY4DQo+ID4+Pg0K
PiA+PiArNmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc5NTExODgx
MDE0OTE2NjklDQo+ID4+IDdDVW5rbm93bg0KPiA+Pj4NCj4gPj4gKyU3Q1RXRnBiR1pzYjNkOGV5
SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGENCj4gPj4gV3dp
TEMNCj4gPj4+DQo+ID4+DQo+ICtKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0
YT1KRk5yNHRlbGI0QW92RTYyWWFIUXUNCj4gPj4gS05yMXl3TCUyDQo+ID4+PiArQmxjMGRKTUZO
TjFPQTFVJTNEJmFtcDtyZXNlcnZlZD0wDQo+ID4+PiArJHNjaGVtYToNCj4gPj4+ICtodHRwczov
L2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUy
RmRlDQo+ID4+PiArdmkNCj4gPj4+DQo+ID4+DQo+ICtjZXRyZWUub3JnJTJGbWV0YS1zY2hlbWFz
JTJGY29yZS55YW1sJTIzJmFtcDtkYXRhPTA1JTdDMDElN0NoYWliDQo+ID4+IG8uY2hlDQo+ID4+
Pg0KPiA+PiArbiU0MG54cC5jb20lN0NhMTFjZDEyOGY4ODE0OTI5Njg0YjA4ZGE3NTM5YmRiYyU3
QzY4NmVhMWQzYmMyDQo+ID4+IGI0YzZmYTkyYw0KPiA+Pj4NCj4gPj4gK2Q5OWM1YzMwMTYzNSU3
QzAlN0MwJTdDNjM3OTUxMTg4MTAxNDkxNjY5JTdDVW5rbm93biU3Q1RXRg0KPiA+PiBwYkdac2Iz
ZDhleUoNCj4gPj4+DQo+ID4+DQo+ICtXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlM
Q0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlDQo+ID4+IDdDMzAwDQo+ID4+Pg0KPiA+Pg0K
PiArMCU3QyU3QyU3QyZhbXA7c2RhdGE9QTFQUGxTa09zUzduV0ZPUEFva3lBMUY4JTJCWUZTWmo1
ZFklMkZPDQo+ID4+IGJsbTBVNFVBJQ0KPiA+Pj4gKzNEJmFtcDtyZXNlcnZlZD0wDQo+ID4+PiAr
DQo+ID4+PiArdGl0bGU6IE5YUCBBREMgZm91bmQgb24gdGhlIGlteDkzIFNvQw0KPiA+Pg0KPiA+
PiBIb3cgZGlmZmVyZW50IGl0IGlzIGZyb20gQURDIGluIGlteDhxeHA/DQo+ID4NCj4gPiBUaGV5
IGFyZSB0b3RhbGx5IHR3byBkaWZmZXJlbnQgQURDIElQLCBubyBzaW1pbGFyIHdpdGggZWFjaCBv
dGhlci4NCj4gDQo+IEVhY2ggc3VibWl0dGVyIHJlc3BvbmRzIGxpa2UgdGhhdC4uLiBob3cgbXVj
aCBkaWZmZXJlbnQ/IFdoYXQgaXMgZGlmZmVyZW50Pw0KPiBEcml2ZXIgaGFzIGxvdHMgb2YgY29w
aWVkIHBpZWNlcywgc28gYWN0dWFsbHkgY291bGQgYmUgdW5pZmllZCBhcyB3ZWxsLg0KDQpISSBL
cnp5c3p0b2YsDQoNClNvcnJ5IGZvciB0aGUgZGVsYXksIGhpZ2ggbG9hZGluZyBvbiBteSBjdXJy
ZW50IHdvcmsuDQoNCkZvciB0aGUgZGlmZmVyZW5jZSwgaW4gZ2VuZXJhbCwNCiBGaXJzdCwgdGhl
IHJlZ2lzdGVyIGRlZmluZSBpcyB0b3RhbGx5IGRpZmZlcmVudC4NCiBTZWNvbmQsIHRoZSBBREMg
YXJjaGl0ZWN0dXJlIGlzIGRpZmZlcmVudCwgRm9yIGlteDhxeHAsIGl0IGNvbnRhaW5zIEFEQyBp
bnB1dCBjdHJsICsgQURDIGNvcmUgKyBBREMgb3V0IGNvbnRyb2wNCiAgICAgICAgRm9yIGlteDkz
IEFEQywgaXQgY2FsbGVkIFNBUl9BREMsIGNvbnRhaW4gQURDRCArIEFEQ0EsIGluIGRldGFpbCwg
aXQgYWxzbyBjb250YWluIGNhbGlicmF0aW9uL3NlbGYtdGVzdC93YXRjaCBkb2cgdGltZXIgSVAg
bG9naWMsIA0KIFRoaXJkLCBkaWZmZXJlbnQgY29udmVyc2lvbiBtb2RlLCA4UVhQIEFEQyBzdXBw
b3J0IHNpbmdsZSBhbmQgY29udGludWUgY29udmVyc2lvbiwgc3VwcG9ydCBhdmVyYWdlIGNvbnZl
cnNpb24uDQogICAgICAgIEZvciBpbXg5MyBBREMsIGl0IHN1cHBvcnQgbm9ybWFsIG1vZGUsIGlu
Y2x1ZGUgc2luZ2xlIGFuZCBhdmVyYWdlIGNvbnZlcnNpb24sIGluamVjdCBtb2RlLCBoYXJkd2Fy
ZSB0cmlnZ2VyIG1vZGUuDQoNClRoZXNlIHR3byBkcml2ZXJzIGFyY2hpdGVjdHVyZSBsb29rcyBz
aW1pbGFyLCBiZWNhdXNlIHRoZXkgYWxsIHVuZGVyIElJTyBzdWJzeXN0ZW0uDQoNCkZvciA4cXhw
IEFEQywgaXQncyBmZWF0dXJlIGxpc3QgaW4gUk06DQo/IFN1cHBvcnQgdXAgdG8gMTYgYW5hbG9n
IGlucHV0cw0KPyBTdXBwb3J0IGZpdmUgY29udmVyc2lvbiBwYWlycywgY2FuIHdvcmsgc2ltdWx0
YW5lb3VzbHksIHdpdGggZGlmZmVyZW50IGNvbnZlcnNpb24NCnByaW9yaXR5Lg0KPyBXb3JkIHNp
emUgaXMgMTItYml0cy4NCj8gU3VwcG9ydCBTaW5nbGUgYW5kIENvbnRpbnVlIGNvbnZlcnNpb24u
DQo/IFN1cHBvcnQgQ29tcGFyZSBtb2RlIGFuZCBjaGFubmVsIGF1dG8gZGlzYWJsZSBpZiBkYXRh
IG1hdGNoIHRoZSByZXF1aXJlbWVudC4NCj8gU3VwcG9ydCBBdmVyYWdlIGNvbnZlcnNpb24sIFN1
cHBvcnQgZmxleGlibGUgNCwgOCwgMTYsIDMyIG51bWJlciBvZiBjb252ZXJzaW9uDQpkYXRhLg0K
PyBDb25maWd1cmFibGUgc2FtcGxlIHRpbWUgYW5kIGNvbnZlcnNpb24gc3BlZWQgLyBwb3dlci4g
VGhlIEFEQyBjb3JlIGNsb2NrIGNhbg0KdmFyeSBmcm9tIDMwMCBrSHogdG8gNiBNSHosIGFuZCB0
aGUgbWF4aW11bSBzYW1wbGUgcmF0ZSBpcyAxLzYgQURDIGNvcmUgY2xvY2suDQo/IENvbnZlcnNp
b24gY29tcGxldGUsIGhhcmR3YXJlIGF2ZXJhZ2UgY29tcGxldGUsIGNvbXBhcmUsIERNQSwgdGlt
ZSBvdXQgZmxhZyBhbmQNCmludGVycnVwdC4NCj8gQXV0b21hdGljIGNvbXBhcmUgd2l0aCBpbnRl
cnJ1cHQgZm9yIGxlc3MgdGhhbiwgZ3JlYXRlciB0aGFuLCBhbmQgZXF1YWwgdG8sIHdpdGhpbg0K
cmFuZ2UsIG9yIG91dC1vZi1yYW5nZSwgcHJvZ3JhbW1hYmxlIHZhbHVlLg0KDQpGb3IgaW14OTMg
QURDLCBpdCdzIGZlYXR1cmUgbGlzdCBpbiBSTQ0KPyA0J2QxMi1iaXQgcmVzb2x1dGlvbg0KP011
bHRpcGxlIG1vZGVzIG9mIHN0YXJ0aW5nIGNvbnZlcnNpb24gKE5vcm1hbCwgSW5qZWN0ZWQpDQqh
qk5vcm1hbCBtb2RlIHN1cHBvcnRzIE9uZS1TaG90IGFuZCBTY2FuIChjb250aW51b3VzKSBjb252
ZXJzaW9ucw0KoapJbmplY3RlZCBtb2RlIHN1cHBvcnRzIE9uZS1TaG90IGNvbnZlcnNpb25zIG9u
bHkNCj9Tb2Z0d2FyZS1pbml0aWF0ZWQgY29udmVyc2lvbnMgaW4gTm9ybWFsIGFuZCBJbmplY3Rl
ZCBtb2Rlcywgb3IgZXh0ZXJuYWwgaGFyZHdhcmUgdHJpZ2dlcg0KP1R3byBkaWZmZXJlbnQgYWJv
cnQgZmVhdHVyZXMgZm9yIGVpdGhlciBhIHNpbmdsZSBvciBjaGFpbiBjb252ZXJzaW9uIGluIE5v
cm1hbCBhbmQgSW5qZWN0ZWQgbW9kZXMNCj9JbmRlcGVuZGVudCBkYXRhIHJlZ2lzdGVycyBmb3Ig
ZWFjaCBjaGFubmVsIGNvbnRhaW4gaW5mb3JtYXRpb24gYWJvdXQgbW9kZSBvZiBjb252ZXJzaW9u
LCBkYXRhIHZhbGlkaXR5LCBvdmVyd3JpdGUgc3RhdHVzLCBhbmQgY29udmVyc2lvbiBkYXRhDQo/
QWx0ZXJuYXRlIGFuYWxvZyB3YXRjaGRvZyB0aHJlc2hvbGRzICh0aHJlc2hvbGQgc2VsZWN0ZWQg
dGhyb3VnaCBpbnB1dCBwb3J0cykNCj9Qcm9ncmFtbWFibGUgRE1BIGVuYWJsZXMgZm9yIGVhY2gg
Y2hhbm5lbA0KP0luZGl2aWR1YWwgaW50ZXJydXB0IGZsYWdzIGZvciB0aGUgZm9sbG93aW5nIGNv
bmRpdGlvbnM6DQqhqkVuZCBvZiBjb252ZXJzaW9uIG9mIGEgc2luZ2xlIGNoYW5uZWwgZm9yIE5v
cm1hbCBhbmQgSW5qZWN0ZWQgbW9kZXMNCqGqRW5kIG9mIGNoYWluIGNvbnZlcnNpb24gZm9yIGJv
dGggTm9ybWFsIGFuZCBJbmplY3RlZCBtb2Rlcw0KoapXYXRjaGRvZyB0aHJlc2hvbGQgdmlvbGF0
aW9ucw0KP1Byb2dyYW1tYWJsZSBwcmVzYW1wbGluZyBmb3IgY2hhbm5lbHMNCj9BdXRvLUNsb2Nr
LU9mZiBmZWF0dXJlIGZvciBpbXByb3ZlZCBwb3dlciBwZXJmb3JtYW5jZQ0KP1Bvd2VyLURvd24g
bW9kZSB0byBwbGFjZSB0aGUgU0FSX0FEQyBpbiBwb3dlci1kb3duIHN0YXRlDQo/UHJvZ3JhbW1h
YmxlIGNsb2NrIHByZXNjYWxlciBmb3IgU0FSX0FEQyAoYnVzIGNsb2NrLCBvciBidXMgY2xvY2sg
ZGl2aWRlZCBieSB0d28gb3IgZm91cikNCj9Tb2Z0d2FyZS1pbml0aWF0ZWQgY2FsaWJyYXRpb24N
Cj9TZWxmLXRlc3QgZmVhdHVyZQ0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IA0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
