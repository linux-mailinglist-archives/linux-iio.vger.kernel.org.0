Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D9965A2AA
	for <lists+linux-iio@lfdr.de>; Sat, 31 Dec 2022 05:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiLaEJP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Dec 2022 23:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLaEJO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2022 23:09:14 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55675F50;
        Fri, 30 Dec 2022 20:09:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLoYsjx2qzOdoB2oDmO2tiUrISfYyE7PKDJqPfHkEiQkekj9nhFMtaAkSDVbvIJFdoht+DdwgdPc4qzGllD4LcWP1jqME6JxXndOvBRbEqYocsQNlNqNVW1dfcv1L7tgSkyrFM+f6Tz3guCtO++Pma0TNUnPaWql/tDuG9tyqd5s/3oRUqcO4iMC3vxRtHwOSe3OIEEnYa7qwlJBSMIBi450d0fPoGqs+I1PrFoocIHkDPS2n5dnYdSkLKwwUdZKitaqH/TsSYv+H49jtotB1yiRvJHcqZJkquY/4dphr7zGYEVaa7k0yENUcCwyFpDOpdcfE2famq1kOMOZsfzAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jF3L0Ta8vZQe3hN+CTIcSIUEnfbvT7bL4cuQIpxgomQ=;
 b=UWycfF7SSzAcmypWInaZs6VM2qf/pwuj8hKU5Sh4UPpOIaJrJ0OxTG7+dzJWfGo1njOIfsqXDbB6joJFcLWJRkNZiaMzIC3ru+v+Z3gPNd899pSz1lpHkM3LizDj0lY0uMjKvP6Ct+3D2PYs9lKdsiZRGQKjppMa0IGPkftLRrpq5XUP+EfgHqrZ924+Krc9czhTEpyobaOt25yIhLC3mK9OoWtW9ZJ33n4mkWjeUZ+2auUMN3k+pHhLz4Tkk59SLqulb5WcOARK8Zc2G7GFdgktqyNKaHtIdZFnt/KRqK6nmud5zQoerbXZnWZM03861fScphaY8xH5GHWYxi7HeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF3L0Ta8vZQe3hN+CTIcSIUEnfbvT7bL4cuQIpxgomQ=;
 b=GTFupOYx3Wmhuf9cqqx5/+U0ww8tFNbAuR0pUnTxAZqD3UZoF+dY85owENX6VSgE+JzX+Hv09ux0Wgug4X3GDLf4BWkAJA+OL6zFH8HZ9zn8qiOGYyScwaMkR3v5YHBIAfGZDFWYqDnf0AWfZfAzf7n7+D0eGaAi57CBPiKi+GQ=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM0PR04MB6852.eurprd04.prod.outlook.com (2603:10a6:208:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 04:09:10 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5944.016; Sat, 31 Dec 2022
 04:09:09 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 1/3] iio: adc: add imx93 adc support
Thread-Topic: [PATCH v4 1/3] iio: adc: add imx93 adc support
Thread-Index: AQHZGOJFbXT7a8jkB0aZyOwM1zqdfK6G1KuAgACTvRA=
Date:   Sat, 31 Dec 2022 04:09:09 +0000
Message-ID: <DB7PR04MB401030854B39D121AA153F3E90F19@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221226042719.694659-1-haibo.chen@nxp.com>
        <20221226042719.694659-2-haibo.chen@nxp.com>
 <20221230191629.01205144@jic23-huawei>
In-Reply-To: <20221230191629.01205144@jic23-huawei>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AM0PR04MB6852:EE_
x-ms-office365-filtering-correlation-id: 7daf017c-c5a2-4099-2564-08daeae4c47d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u0J/LUFbIWBribP8Gcf607xqthg9m4yHokeHu33Zqeks+tDJPRfiXcjETX9RVeEv+hBLZk0RA4TUiXPCejZeFidWiEKK8DHuSoxx87/RAOXhQ09Z0XTLQl4dj2zG8iZ325/cfcgD/fKI10BlKHkg8+qOUbt3pWE9rC8h4B6pi7pQ8mqbSRb/UgV6ROjfqAMOkOg0EA3qokWnC2Shlg46YRxwa7gZgr0r7IO+7ov063Oy3TCbnvplQPOkGEM7+afLtUNsGe5+thGq6Fmel6jZdQ3t1AcbykjrY4SeZV/2V0e/QU8RQUmpNluenGvuJ6b9hZqoYihDY7MMQf9ejA9S2hAS20tvqIPPVf6f4vvcuTEWy1Cdugn3QX60K9MoTcrUBYSVQCEJNCn7ZkP9+y9K4tR1knYcM3TffuYRxf1FgndkPnXf0Pnyz1S4BpK4y7POEGn8Sosr1bnBhd6Z+snqxpCH6q0aQhd4+IY1QOq3xmJ1jB4VGbc9gmLdp7nFwXOhdod40QAovr32VFsD8UwmAqyIw+1yTudYtUr9dbYYm71iq9JDFzs9H1HQhWFx0TSFKUMnrmKXBvEirL3njWnOeTK7j53n7qTrwCZhZaEwBvKDyiNddqBkU7KE7vFLyLugxMU1mideg+CNUu5SETiBon0vN03zwX3RCbIioR+lbeukd+rHaDkMvDNV6KINn9CTYbIaEcW7V7PoqpSZPbCG1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199015)(66899015)(86362001)(54906003)(6916009)(316002)(2906002)(55016003)(38070700005)(38100700002)(33656002)(122000001)(186003)(26005)(83380400001)(53546011)(6506007)(9686003)(52536014)(66476007)(76116006)(64756008)(66946007)(66556008)(5660300002)(7416002)(478600001)(71200400001)(7696005)(8936002)(66446008)(8676002)(41300700001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Zjllb29KcG85Zm5nM21UUms2K040NHdKNFdNTVRFVVFQaHYvNVFxNk1XOXFS?=
 =?gb2312?B?c2tuYjZUaHJ4TTJKMjNoaitlVlRMTnJRWHRIVkFvbCtralY3Y2FYV0dOY284?=
 =?gb2312?B?c2l0WVdIYmpyWEEyU1FkL3M3eHhtV1RJVjBPNlpnMzdqVzlMVnpBMjUwb2My?=
 =?gb2312?B?TXpuVkpEcWxPUlhiVlNZZk5NK2JLSHZHV2xzUkx3dXJmZlNLWTc1TDlLT1RD?=
 =?gb2312?B?QWM3d2o0L3dla2kvVjNZWERXSEdycXpmTlZidGVseWh1b2hpOXM4RFdjbUYv?=
 =?gb2312?B?bmtwMTBGYnpNM2ptVnhrbXpzNnBJRllSS1RYeG5qSWs0dzVMbTQ4dnByL0tT?=
 =?gb2312?B?djFDRWcyR1c1TXlDaGw3dDJSYjFuR2hoMHZEWlRDbHhDWDJSYk41K3M5TlMy?=
 =?gb2312?B?anFBampWbmt4YS8rV2k4UUlnQnNCMnlWazd3Y1AxK0huY3JhcFEzbS9zdmV2?=
 =?gb2312?B?NWFzb2dnaXhURUVzdnE2Z0VkTDRRN2kxNGlUZVZ5NVRGT3pjZmg0b3RQSWdQ?=
 =?gb2312?B?SjI3NVYrQ1hXWUtieFdsVHpxWis3Y0hJSlFpSkVyNGd2WlJ2SS9TcytzNkVp?=
 =?gb2312?B?SndzTlhIVWQ4dlJyaC96MnFWV21jMllWWHZhTWpSbEYzRjIzY1FwU2FVQkE4?=
 =?gb2312?B?SkpZUzRpVUx4YS9NZ2czTjJaMEFqejNHUitZdHUxTHp4YUxCZ2JmWnBjQkdp?=
 =?gb2312?B?MnRMbWhzcnd5VUpuL25JSFpNMXAzOW5CTUFCNUozUGMwYzFMRjl1Z1hLbzUz?=
 =?gb2312?B?Q0swR1BzZnQ2Y0hwVUlpZXFyQWsxemRxSUxzeGN2cHh3RmE5c2VxQy82UzJ5?=
 =?gb2312?B?V0JkQXFwYnZQcXFvUzFIRWpaYlpQdFVNV09vVGdXTFRTbTl2SW5mMWppd2JE?=
 =?gb2312?B?dnRmQ0dHS09pakY4cXU1bkxSSHN3cnRWWnVvOU1ITWVKbng5ZG82eEdxYnVH?=
 =?gb2312?B?N2tVMjcrZE1vTzh6THpDWGZJU01XOGVhTjF3K2g0S01qdURxQit3Qll5dnhF?=
 =?gb2312?B?ZDduUWZOM21sd09HMDVNMFlRaG1SQWJncE11WlhuejZMaFlZVUFGOWNKK3Q0?=
 =?gb2312?B?VXBwL0ZSVmk2QWlyaFdJNUdwbVA5cHg5WEQ1bUFnWkhBSWdQQ1pHeUFvN3Fz?=
 =?gb2312?B?Y1ZZVGxQNVNROUhuT2NWVUUxSGN3RzA0ek9iVzhYaEppdzdIUStadSt6blov?=
 =?gb2312?B?ZC9reHl0akR6ZVhwMnIyc0M0R3YxVDUyZkVqZzh3Z09lOUNNTEVlbkR3RFRP?=
 =?gb2312?B?cWVwZkhOcHJsWWoxM1VVRU9yUExTVzVPdTUvdTIwajhnNlVtZXQ0bjliZVRE?=
 =?gb2312?B?dTBoSXJkRVJnZ1JJektSS21hdGYxTUxDWXNPc1hhaTZ5QndqN3dMNDIzQjJw?=
 =?gb2312?B?Z3kxWjhrdmhKRGh5OGkrQjVWNU5meDVWM0liRWRKcDJ1TmQ4VXdaVVNLU3Mw?=
 =?gb2312?B?UU1OZStWVXRnRmJ2eFdUdm9vdzRXR01GWUZuUm0xanRFd2E5QXZveEVLQWRo?=
 =?gb2312?B?cUc1QjNSTm51czdMZ1hqc05MY29oWHRDOVRTcW5jMW5VMGVLSy84Rk1FVkw0?=
 =?gb2312?B?dXJOVnFiV1Uvek9wbnA3V25NZzZzbEdXT2ltdWRGZXByZndYRE5oY2VxUlVh?=
 =?gb2312?B?VTNTMHpBYmVaZGRDNUlxT1VFNlU1R1hlQjdIYzU1TlA3NVhKZUdGYTFEUEFo?=
 =?gb2312?B?NjFNQm1YeTBJa0pGWmdPU3E5Wm5UTDlxYUxxNWViT2NzYlBNZzJWQ2QwUlJC?=
 =?gb2312?B?bjQwNTIyVHFEU0RKMldqZm1mYmxrVWM4UGwydDdlU1czNHU1MFJBWW5EQTlY?=
 =?gb2312?B?WWkxVWhqTWtESHA3MmJlVEIvNGY1N0NabTBkQ1FuQ1VFU2xoOW1WaUxBVjda?=
 =?gb2312?B?eUw1MVhvMEc2QWZZTDVNN1hPZzh2WWNYbnNYVUtwUW1oS3dRMWdYM1Bwelkr?=
 =?gb2312?B?UkYweXExeHpCTnhvNFc2UUt6TUlQb0dNeVJoWWE5Mm10RmNmdE94Y25mQ1I0?=
 =?gb2312?B?aTFuOE9DNW9CSlc5SmNoZFdIVzFYcGs5ZHl0cXJBUkFSeG5XSUJoZ29qeHVM?=
 =?gb2312?B?TG9oOVFnQitjSXR2MTJ4Rm52TU5hSmRRclBDNHViSnQ2QkNjdURtZnk3R0k1?=
 =?gb2312?Q?F/H8UxI45J4ARTJRvHohC54Vn?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7daf017c-c5a2-4099-2564-08daeae4c47d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2022 04:09:09.5856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNtA+9wJEBtoLR+dZY6x6tWFat+ahbb2zc0/4meU3P82Vdh1zCoYqI0z4aHxyqlBa5jmVwXS+pIxLdo6CyFXZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6852
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOoxMtTCMzHI1SAzOjE2DQo+IFRvOiBCb3Vn
aCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiBsYXJzQG1ldGFmb28uZGU7IHJvYmgr
ZHRAa2VybmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBzaGF3
bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhw
LmNvbT47DQo+IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMS8zXSBpaW86IGFkYzogYWRkIGlteDkz
IGFkYyBzdXBwb3J0DQo+IA0KPiBPbiBNb24sIDI2IERlYyAyMDIyIDEyOjI3OjE3ICswODAwDQo+
IGhhaWJvLmNoZW5AbnhwLmNvbSB3cm90ZToNCj4gDQo+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFp
Ym8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4gVGhlIEFEQyBpbiBpLm14OTMgaXMgYSB0b3RhbCBu
ZXcgQURDIElQLCBhZGQgYSBkcml2ZXIgdG8gc3VwcG9ydCB0aGlzDQo+ID4gQURDLg0KPiA+DQo+
ID4gQ3VycmVudGx5LCBvbmx5IHN1cHBvcnQgb25lIHNob3Qgbm9ybWFsIGNvbnZlcnNpb24gdHJp
Z2dlcmVkIGJ5DQo+ID4gc29mdHdhcmUuIEZvciBvdGhlciBtb2RlLCB3aWxsIGFkZCBpbiBmdXR1
cmUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5j
b20+DQo+IA0KPiBIaSBIYWlibywNCj4gDQo+IEkgdGhpbmsgdGhlcmUgYXJlIHN0aWxsIGltcHJv
dmVtZW50cyB0byBiZSBtYWRlIGluIG9yZGVyaW5nIGluIHByb2JlKCkvcmVtb3ZlKCkNCj4gYW5k
IGFsc28geW91IGFyZW4ndCBjYWxsaW5nIHBtX3J1bnRpbWVfZG9udF91c2VfYXV0b3N1c3BlbmQo
KSB3aGljaCBpcyBhDQo+IHJlcXVpcmVtZW50IGlmIG1hbnVhbGx5IGhhbmRsaW5nIHJ1bnRpbWUg
cG0gZGlzYWJsaW5nIG9uIHJlbW92ZSgpDQoNCkhpIEpvbmF0aGFuLA0KDQpUaGFua3MgZm9yIHlv
dXIgcGF0aWVuY2UgYW5kIGNhcmVmdWwgcmV2aWV3LCBJIHdpbGwgaW1wcm92ZSB0aGlzIGRyaXZl
ciBhY2NvcmRpbmcgdG8geW91ciBzdWdnZXN0aW9uLg0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENo
ZW4NCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+IC0tLQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL2FkYy9pbXg5M19hZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy9pbXg5M19hZGMuYw0K
PiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAwMC4uNjc3ZjEzYTA0MGY4
DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9pbXg5M19hZGMu
Yw0KPiA+IEBAIC0wLDAgKzEsNDc3IEBADQo+IA0KPiANCj4gDQo+ID4gK3N0YXRpYyBpbnQgaW14
OTNfYWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiArCXN0cnVj
dCBpbXg5M19hZGMgKmFkYzsNCj4gPiArCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXY7DQo+ID4g
KwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsJaW50IHJldDsNCj4gPiAr
DQo+ID4gKwlpbmRpb19kZXYgPSBkZXZtX2lpb19kZXZpY2VfYWxsb2MoZGV2LCBzaXplb2YoKmFk
YykpOw0KPiA+ICsJaWYgKCFpbmRpb19kZXYpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgIkZhaWxl
ZCBhbGxvY2F0aW5nIGlpbyBkZXZpY2VcbiIpOw0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+
ICsJfQ0KPiA+ICsNCj4gPiArCWFkYyA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gKwlhZGMt
PmRldiA9IGRldjsNCj4gPiArDQo+ID4gKwltdXRleF9pbml0KCZhZGMtPmxvY2spOw0KPiA+ICsJ
YWRjLT5yZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiA+
ICsJaWYgKElTX0VSUihhZGMtPnJlZ3MpKQ0KPiA+ICsJCXJldHVybiBQVFJfRVJSKGFkYy0+cmVn
cyk7DQo+ID4gKw0KPiA+ICsJLyogVGhlIHRoaXJkIGlycSBpcyBmb3IgQURDIGNvbnZlcnNpb24g
dXNhZ2UgKi8NCj4gPiArCWFkYy0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAyKTsNCj4g
PiArCWlmIChhZGMtPmlycSA8IDApDQo+ID4gKwkJcmV0dXJuIGFkYy0+aXJxOw0KPiA+ICsNCj4g
PiArCWFkYy0+aXBnX2NsayA9IGRldm1fY2xrX2dldChkZXYsICJpcGciKTsNCj4gPiArCWlmIChJ
U19FUlIoYWRjLT5pcGdfY2xrKSkNCj4gPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBU
Ul9FUlIoYWRjLT5pcGdfY2xrKSwNCj4gPiArCQkJCSAgICAgIkZhaWxlZCBnZXR0aW5nIGNsb2Nr
LlxuIik7DQo+ID4gKw0KPiA+ICsJYWRjLT52cmVmID0gZGV2bV9yZWd1bGF0b3JfZ2V0KGRldiwg
InZyZWYiKTsNCj4gPiArCWlmIChJU19FUlIoYWRjLT52cmVmKSkNCj4gPiArCQlyZXR1cm4gZGV2
X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoYWRjLT52cmVmKSwNCj4gPiArCQkJCSAgICAgIkZhaWxl
ZCBnZXR0aW5nIHJlZmVyZW5jZSB2b2x0YWdlLlxuIik7DQo+ID4gKw0KPiA+ICsJcmV0ID0gcmVn
dWxhdG9yX2VuYWJsZShhZGMtPnZyZWYpOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCWRldl9l
cnIoZGV2LCAiQ2FuJ3QgZW5hYmxlIGFkYyByZWZlcmVuY2UgdG9wIHZvbHRhZ2UuXG4iKTsNCj4g
DQo+IFlvdSBjYW4gdXNlIGRldl9lcnJfcHJvYmUoKSBmb3IgYWxsIHN1Y2ggaGFuZGxpbmcgaW4g
cHJvYmUoKSB3aGV0aGVyIG9yIG5vdCBpdA0KPiBjYW4gZGVmZXIuICBUaGF0IHRlbmRzIHRvIHNp
bXBsaWZ5IHRoaW5ncyBhbmQgYXZvaWRzIHRoZSBuZWVkIGZvciByZXZpZXdlcnMgdG8NCj4gY29u
c2lkZXIgaWYgYSBmdW5jdGlvbiBjYW4gZGVmZXIgb2Ygbm90Lg0KPiANCj4gPiArCQlyZXR1cm4g
cmV0Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGlu
ZGlvX2Rldik7DQo+ID4gKw0KPiA+ICsJaW5pdF9jb21wbGV0aW9uKCZhZGMtPmNvbXBsZXRpb24p
Ow0KPiA+ICsNCj4gPiArCWluZGlvX2Rldi0+bmFtZSA9ICJpbXg5My1hZGMiOw0KPiA+ICsJaW5k
aW9fZGV2LT5pbmZvID0gJmlteDkzX2FkY19paW9faW5mbzsNCj4gPiArCWluZGlvX2Rldi0+bW9k
ZXMgPSBJTkRJT19ESVJFQ1RfTU9ERTsNCj4gPiArCWluZGlvX2Rldi0+Y2hhbm5lbHMgPSBpbXg5
M19hZGNfaWlvX2NoYW5uZWxzOw0KPiA+ICsJaW5kaW9fZGV2LT5udW1fY2hhbm5lbHMgPSBBUlJB
WV9TSVpFKGlteDkzX2FkY19paW9fY2hhbm5lbHMpOw0KPiA+ICsNCj4gPiArCXJldCA9IGNsa19w
cmVwYXJlX2VuYWJsZShhZGMtPmlwZ19jbGspOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCWRl
dl9lcnIoJnBkZXYtPmRldiwgIkNvdWxkIG5vdCBwcmVwYXJlIG9yIGVuYWJsZSB0aGUgY2xvY2su
XG4iKTsNCj4gPiArCQlnb3RvIGVycm9yX3JlZ3VsYXRvcl9kaXNhYmxlOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCXJldCA9IHJlcXVlc3RfaXJxKGFkYy0+aXJxLCBpbXg5M19hZGNfaXNyLCAwLCBJ
TVg5M19BRENfRFJJVkVSX05BTUUsDQo+IGFkYyk7DQo+ID4gKwlpZiAocmV0IDwgMCkgew0KPiA+
ICsJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHJlcXVlc3RpbmcgaXJxLCBpcnEgPSAlZFxuIiwgYWRj
LT5pcnEpOw0KPiA+ICsJCWdvdG8gZXJyb3JfaXBnX2Nsa19kaXNhYmxlOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCXJldCA9IGlteDkzX2FkY19jYWxpYnJhdGlvbihhZGMpOw0KPiA+ICsJaWYgKHJl
dCA8IDApDQo+ID4gKwkJZ290byBlcnJvcl9mcmVlX2FkY19pcnE7DQo+ID4gKw0KPiA+ICsJaW14
OTNfYWRjX2NvbmZpZ19hZF9jbGsoYWRjKTsNCj4gPiArDQo+ID4gKwlyZXQgPSBpaW9fZGV2aWNl
X3JlZ2lzdGVyKGluZGlvX2Rldik7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2Vycihk
ZXYsICJDb3VsZG4ndCByZWdpc3RlciB0aGUgZGV2aWNlLlxuIik7DQo+ID4gKwkJZ290byBlcnJv
cl9mcmVlX2FkY19pcnE7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcG1fcnVudGltZV9zZXRfYWN0
aXZlKGRldik7DQo+ID4gKwlwbV9ydW50aW1lX3NldF9hdXRvc3VzcGVuZF9kZWxheShkZXYsIDUw
KTsNCj4gPiArCXBtX3J1bnRpbWVfdXNlX2F1dG9zdXNwZW5kKGRldik7DQo+ID4gKwlwbV9ydW50
aW1lX2VuYWJsZShkZXYpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICsNCj4gPiArZXJy
b3JfZnJlZV9hZGNfaXJxOg0KPiA+ICsJZnJlZV9pcnEoYWRjLT5pcnEsIGFkYyk7DQo+ID4gK2Vy
cm9yX2lwZ19jbGtfZGlzYWJsZToNCj4gPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShhZGMtPmlw
Z19jbGspOw0KPiA+ICtlcnJvcl9yZWd1bGF0b3JfZGlzYWJsZToNCj4gPiArCXJlZ3VsYXRvcl9k
aXNhYmxlKGFkYy0+dnJlZik7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+
ICsNCj4gPiArc3RhdGljIGludCBpbXg5M19hZGNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpIHsNCj4gPiArCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYgPSBwbGF0Zm9ybV9n
ZXRfZHJ2ZGF0YShwZGV2KTsNCj4gPiArCXN0cnVjdCBpbXg5M19hZGMgKmFkYyA9IGlpb19wcml2
KGluZGlvX2Rldik7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBhZGMtPmRldjsNCj4gPiAr
DQo+ID4gKwkvKiBhZGMgcG93ZXIgZG93biBuZWVkIGNsb2NrIG9uICovDQo+ID4gKwlwbV9ydW50
aW1lX2dldF9zeW5jKGRldik7DQo+ID4gKw0KPiA+ICsJaWlvX2RldmljZV91bnJlZ2lzdGVyKGlu
ZGlvX2Rldik7DQo+ID4gKwlpbXg5M19hZGNfcG93ZXJfZG93bihhZGMpOw0KPiANCj4gV2h5IGlz
IHRoZXJlIG5vIHNpbWlsYXIgcG93ZXIgZG93biBpbiB0aGUgZXJyb3IgcGF0aCBpbiBwcm9iZSBm
b3INCj4gaWlvX2RldmljZV9yZWdpc3RlcigpIHJldHVybmluZyBhbiBlcnJvcj8NCj4gDQo+ID4g
KwlmcmVlX2lycShhZGMtPmlycSwgYWRjKTsNCj4gPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShh
ZGMtPmlwZ19jbGspOw0KPiA+ICsJcmVndWxhdG9yX2Rpc2FibGUoYWRjLT52cmVmKTsNCj4gPiAr
DQo+ID4gKwlwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gPiArCXBtX3J1bnRpbWVfcHV0X25v
aWRsZShkZXYpOw0KPiANCj4gSSB0aGluayBJIGNhdXNlZCBjb25mdXNpb24gYSBiaXQgaGVyZSBi
eSBwb2ludGluZyBvdXQgdGhlIGRldmljZSB1bnJlZ2lzdGVyDQo+IG5lZWRlZCB0byBiZSBmaXJz
dC4gVGhhdCdzIG5vdyBmaW5lLCBidXQgdGhlIHJlc3Qgd291bGQgYmVuZWZpdCBmcm9tIGEgcmV0
aGluay4NCj4gVG8gbXkgbWluZCwgdGhlIGlkZWFsIHNpdHVhdGlvbiBpcyB0aGF0IHRoZSByZW1v
dmUoKSBpcyBhIHJldmVyc2Ugb2YgdGhlIHByb2JlKCkNCj4gZnVuY3Rpb24sIHNvIEknZCBleHBl
Y3QgdG8gc2VlIHRoZXNlIHBtX3J1bnRpbWVfZGlzYWJsZSgpLA0KPiBwbV9ydW50aW1lX3B1dF9u
b2lkbGUoKSBhdCB0aGUgc3RhcnQgb2YgdGhpcyBmdW5jdGlvbi4gIE5vdGUgdGhhdCB5b3UgYWxz
bw0KPiBuZWVkIHRvIGNhbGwgcG1fcnVudGltZV9kb250X3VzZV9hdXRvc3VzcGVuZCgpIHNvbWV3
aGVyZSBpbiBoZXJlIC0gb3IgdGFrZQ0KPiBhbGwgdGhlIHByb2JlL3JlbW92ZSBkZXZtXyBtYW5h
Z2VkIGFuZCB1c2UNCj4gZGV2bV9wbV9ydW50aW1lX2VuYWJsZSgpIHdoaWNoIHRpZGllcyB0aGF0
IHVwIGZvciB5b3UgYXMgbmVlZGVkLg0KPiAoc2VlIGRvY3MgaW4gcG1fcnVudGltZS5oKQ0KPiAN
Cj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KDQo=
