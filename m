Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB8457AE02
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jul 2022 04:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiGTCbR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 22:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiGTCbC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 22:31:02 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20074.outbound.protection.outlook.com [40.107.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD912A978
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 19:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzMNBPsiUJ6hwvTcpF/v0n1gQbpmxF6H4ZT99OROkCHtytdAkYwv+kn8TXGs7BztsXoTOdD/XBzCZQjGQxXAydPkhPPuT0lXwduwomVDM9wNHkjB+pszvNFSJKELq2nQrz4HG7zNvUejArl3iF9bAvjS4FtjkieQ4ZDsXnsfYuByGHKf0tA6qb8vs9zwvdOz9WhH8UsuLS2+fEC8M+bm3NJS8FXqGE7AFEjfUsRlQ2+pXa4yIjrQxnZoR/jDT+b8/qyK/2wL5OR7LoiuoreKSNZwzyWTO80MlK4c95aM8Z314GjBkF1TeZRyTNcLPAerC0x3/n3bjx0boGOaIJ8ucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WagjPycCaIsHQSh/0IkO9ikfZDv4xfpUjga36Gc8D20=;
 b=QDM7hKzCldSSCDkfwxOJiymEr5jRHXtRw1649LyDnMsa+Ajgp8jSd2fFTTYSML8Cs8gWSVNmgxeIy4GPS3rNwzN/flOidjGYQ93+Z6Ac8hXE8NhVk6M500AB/om00qB5W/uFymDmYCRbgiqUAH9NUioSwvA0mgbB3m4hE1Po4BCDDrQLUssw5kuTzBAay7Cj76mkQzDVGM1jLJ2nvZBd5ly7onE/dzCUDgg+1mL2mVN6510jUwBCvvLBx4mcaAYSNZbiNgN3qqe3Gwr4cC7D89N34IGmUi+xq9mIc9AvQjPI7jS8JG2mu8cEPkn2r+IK1BRb195V27wCC3+o7Tfz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WagjPycCaIsHQSh/0IkO9ikfZDv4xfpUjga36Gc8D20=;
 b=Hxe+xi+exewlW9YwEPiCRMOSPVBYjC3neKRIJIaJaUTL088QGxdk+zVXUYM8TXY0b/DUgM1TjN20xVN2rwRTrc2CGHm26eRVXDLD2qFCQIGKAc1a9On0xs86nTCbbwoDbCJE23wLpdX7atp5IDLj2vnXYlt46xiIKi/kc9+JKZ4=
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27)
 by DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 02:30:34 +0000
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::7860:3ed5:c3f9:af55]) by VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::7860:3ed5:c3f9:af55%4]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 02:30:33 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Martin Larsson <martin.larsson@actia.se>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] iio: adc: imx8qxp-adc: propagate regulator_get_voltage
 error
Thread-Topic: [PATCH] iio: adc: imx8qxp-adc: propagate regulator_get_voltage
 error
Thread-Index: AQHYm4CvVEOgJp0PAEWVobJ6jyI6a62GigdQ
Date:   Wed, 20 Jul 2022 02:30:33 +0000
Message-ID: <VI1PR04MB4016D335E537CD6F89CABA19908E9@VI1PR04MB4016.eurprd04.prod.outlook.com>
References: <20220719150317.67156-1-martin.larsson@actia.se>
In-Reply-To: <20220719150317.67156-1-martin.larsson@actia.se>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db32a4a4-853b-4b08-7e4f-08da69f7d268
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LLqp9wLTnq92oHISb7OGimogvZoWjFmBQQAK7ibhtW3mlrGVN76vmk+N2rI591kNNRcntRGwc8aJOs+dxte/BH0Vywl/OSWYFOOZWN0/438YTmx+KoOChp9qJtqb/uZlaCSsOOVEOSyaeLX7KRZAWofcM0mRQUtRaxLrTJxT+vLcQWm8QrYDhktjk0SuaizzFOTMbs4NNT/I5kdxKrC+qupmD5VNrJvqi6uidNEv82Iy/fNUe61Hzi6b0HkV0K5hZUQliQ+LVrR6kOLceuLmrqOO0byNh7shZk7NmT/sYGMDpg7G6IL6FpQ7njPpFuvbSeIrFS+nWilnE2ljIeWy1UY9TCU+5wMQS4PPye+1tuyI9Fvy/PFDlt+8GP/giNOvJsSdEp1JpDqMLXhi9tV7Ve9hNRHRQnmTY2mRXik4/oFNiZwALJvs3NHL5JiHUs3FWTmgz7UNs6nU/VJCUHsHqJXhdVXZ23CL16FmTURnT/o5U4qBLLXS/XFBt1TEfYRJFsqHsG8w1D6SptHKEuEh66bhXPITeFWvLVkglFQwXNM4oqS7CGY5AmoXDYllsixk2syU81lDw9fHV8wNnCuwoAAAahTor7puOxYkbwq8pgv8/BjyaN9U3Tl4qJpLqEyg7XMxmJcN+FdP0DwXxQuaoqM1sb9AJfB9tMkAZCkURg5sCxLre1YlmGvKTiQKlbbjttm0XHgrlCsn7mIi8xp0cXxEspGRtMM6mZ8VZtnDekeevT8JG+BHHexIaxNgNB/lxOPJIAofE8E7nB9Hh5kZeJOQsc6fSTUH48iOLQmV71knLG/lLWYCQ+cOV2XpNzJ5brFamjmiJk7soFqetqmUHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(33656002)(110136005)(66556008)(71200400001)(6506007)(8676002)(7696005)(478600001)(4326008)(26005)(41300700001)(66946007)(66446008)(2906002)(316002)(66476007)(9686003)(76116006)(64756008)(55016003)(38100700002)(7416002)(53546011)(8936002)(86362001)(5660300002)(83380400001)(38070700005)(122000001)(54906003)(52536014)(186003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RHMyS2tnNFJENHNiOGtRTWRMcFdSSlhYY0V3U3RJQzRVcGh5enVuK0pINjJo?=
 =?gb2312?B?bk5OemNveFFRa1FOZEsyLzZyeFA4VmN5a3lHbGRRWlNPWHpLYjJlT0tlSjdN?=
 =?gb2312?B?SFc4aDBkZmFVMVRCNFZXaldWYW8rSy9pei8vTkFWSkJQMk50bjdDN3ZBRmsv?=
 =?gb2312?B?T3B2Y1NzUkRCVXBzQXE1OURxNmU1YmtwSEhZRTRuamgzRFd0MjZ1QjFSNUsw?=
 =?gb2312?B?UEpSdjhxM3BjeUJtRVp5TEpDcEFhbVRMWG13SFV2VzRWOURSNU96NFlHR2tH?=
 =?gb2312?B?cWtOVGE5czBvOVQ1M3pWNkxGYkN6YkF4SEMvVFhoVDJ0K0pkVU9uNlBIeE9m?=
 =?gb2312?B?dW5LaEFjV0JiZGgxYVp2NWR0akhhUk5RaWtnYlFRRWxTQ2Z6MTQ4L2xJYlJp?=
 =?gb2312?B?YmM0N3JRQ2lXejVKWFJVdHlweXBBak5yTU54bmhYdDNiQkZlSDJpRzJxei9D?=
 =?gb2312?B?bEFucDE5bkoveW1iQTFDTVZLQ1p6Wmw4L0t6anlOL2U3c2s2MXRwRU1XeFUz?=
 =?gb2312?B?T20wN09TUkRhcnc4STdLUHkxRXkrRzFMaVExRXlyUHI2Z3FyeEJ4cmxQY1M5?=
 =?gb2312?B?RGlQL3dxRGk5VTN3QW9DY1BoRVNMTFdDYldjOUxER1piSnFEUWZqWDJHTmlT?=
 =?gb2312?B?aEZEczF5Rmc1UVNKSnBMZUljS2xwS0hYNytaclkzN0lnZXZCZ3VSemFJQzhz?=
 =?gb2312?B?WTRubFk5bGhOVStiZTJKLzlpVzZWL1lCNm80UkhPNHlwZG96OWJibkpWbjRI?=
 =?gb2312?B?OC90VkFJRnQzSkhuUDdDOU9xaDZKMXNUb043T3JUYkdoMXZCcVIwS3dOcmhV?=
 =?gb2312?B?VXpEWHFzZnQ2VzNkVWdDeUV4T1pzL25yNDJQbHd2TWJKaXdxTXNxaXlTV1N1?=
 =?gb2312?B?ZTBQeTFpWDc4S25Zc2JlTVZibmFPVCtxZjFjZlE3L1pJSFEvb0ZZMy9NZUFk?=
 =?gb2312?B?OVFhWUswaVhGMXM0RFZ6bjdJS1Vvek1DSVc5ZkZxS2dGc01GSC85blhPMElP?=
 =?gb2312?B?WWpKT3N0VmYwZGI5eHFydHhydHNXLzh2NTgzZlhyR0tpV0haOGtpdW8wclJy?=
 =?gb2312?B?TVYzZkk3L1p4UncrRHE5ZVdadUoreEZSWDFzMDdCeUs0MGhrSTJBQyt0ZGto?=
 =?gb2312?B?SGc0KzhENThwSS9Nd3RlOUFKL0VTaXZEOHFFRUp3T3g5NGtZWENoVG9SVFA0?=
 =?gb2312?B?bHR2NUpkNGVSK2xPOUU1c0VFOFJhWDJxcVJ2V29NS05Sa2dGb0RJWEJnUlJ6?=
 =?gb2312?B?RklmbnJyR0Z4UFJPYUF2OE9jNTdxSnBwc1NCaStSYVB5SFZsaUdiTlBvQWtx?=
 =?gb2312?B?UUJHY3JBeVpSWnpSU3RVYmswanJVNG5qbXNENWZ4bmdsSFBwOU5nb2NldGtI?=
 =?gb2312?B?d3EveW9wc0I2TnlPTldqKzVlL0MxNmc4NzkxdHlmY09PREU0ZjJsSnRRUm5B?=
 =?gb2312?B?R2ZEcld2cUlwRW42UU4vNFNCUzFubi93bmtTY1hVcHlOUXFiZW5GZloySmZW?=
 =?gb2312?B?Z2NVNmtKK29FNXJuQXJlT2NrSnpLdHI1bWFpZHFQQlluaWRvRndhcHBRcVRi?=
 =?gb2312?B?SHEyTGlreTlFTlpkLzR3amI3SDRNeU1uSUs2Z0tZZlh1U1NxMW85OUdWZzVp?=
 =?gb2312?B?QXVKZ01QYzhtOUxFWm5BRk9rV0l6WEdwVHFVKzRLMjRlYWdnQkdPeHJhWUww?=
 =?gb2312?B?TEMwL3lTT0luWjJGWXpUMUtXZ2tDN05qTEw0bTQrd2tKcklNblRtenNCWm5k?=
 =?gb2312?B?dU52TUxJTlJjVjd6NWJjbE5QbjQ3T09lUlk3UmRJSy9jMTVtNzRqVktCN2tX?=
 =?gb2312?B?bXQxUmFRWXJ5by9KRE5PdDA5emU4MTBpYTNLQjFZUFBMT1ovczNVZVJjOVVy?=
 =?gb2312?B?Zm1SODg4NGU1S3NUcVdFUDlEUzZMK3dUMzg1U0NkRkJldUU3alloK0k3SkNo?=
 =?gb2312?B?UC8vS09JWXVNeXkvcHdxZDJ4Z1hYMWtuYm5URXNmeElGVjBsMVptUngzOC94?=
 =?gb2312?B?b0RQZm9HcVA1SEZDTUErNXg1S0JQdGhQZEFHdHBHcVFYTDNjclNndFMyMDM1?=
 =?gb2312?B?MjA1YzFYdVVuQjFZcksrQTdpWDB6MzVEUEVSWWY5aU4vTUl0S2hSdlZJYjQ2?=
 =?gb2312?Q?rLB9ZjlnBSUfb9CgzBv0h+745?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db32a4a4-853b-4b08-7e4f-08da69f7d268
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:30:33.4092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHMUdmaxmLXsRC4B+4TL93Jbu9RB5cjEJmAV9DMPGMtnpI4MJCjcJ7sdF6Q7DPKLEkcIFbj3PwGPittdnFiPaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8461
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJ0aW4gTGFyc3NvbiA8bWFy
dGluLmxhcnNzb25AYWN0aWEuc2U+DQo+IFNlbnQ6IDIwMjLE6jfUwjE5yNUgMjM6MDMNCj4gVG86
IENhaSBIdW9xaW5nIDxjYWkuaHVvcWluZ0BsaW51eC5kZXY+OyBKb25hdGhhbiBDYW1lcm9uDQo+
IDxqaWMyM0BrZXJuZWwub3JnPjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZw0KPiBDYzogTWFy
dGluIExhcnNzb24gPG1hcnRpbi5sYXJzc29uQGFjdGlhLnNlPjsgQm91Z2ggQ2hlbg0KPiA8aGFp
Ym8uY2hlbkBueHAuY29tPjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBT
aGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU+Ow0KPiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1
dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIGlpbzogYWRjOiBpbXg4cXhwLWFkYzogcHJv
cGFnYXRlIHJlZ3VsYXRvcl9nZXRfdm9sdGFnZSBlcnJvcg0KPiANCj4gSWYgdGhlIEFEQyB2cmVm
IHJlZ3VsYXRvciByZXR1cm5zIGFuIGVycm9yLCBmb3IgZXhhbXBsZSwgaWYgQ09ORklHX1JFR1VM
QVRPUg0KPiBpcyBub3Qgc2V0LCB0aGUgZXJyb3Igd2lsbCBiZSB1c2VkIGFzIGEgcmVmZXJlbmNl
IHZvbHRhZ2UuDQo+IA0KPiBJbnRyb2R1Y2UgYSBndWFyZCBmb3IgbmVnYXRpdmUgcmV0dXJuIHZh
bHVlcyBpbnN0ZWFkIG9mIHVuY29uZGl0aW9uYWxseSBjYXN0aW5nIGl0DQo+IHRvIHUzMi4NCg0K
QWNrZWQtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCg0KUmVnYXJkcw0KSGFp
Ym8gQ2hlbg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9pbXg4cXhwLWFkYy5jIHwgOCArKysr
Ky0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvaW14OHF4cC1hZGMuYyBiL2RyaXZl
cnMvaWlvL2FkYy9pbXg4cXhwLWFkYy5jIGluZGV4DQo+IDkwMWRkOGUxYjMyZi4uOGE3ODZkNzNh
ZThlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvaW14OHF4cC1hZGMuYw0KPiArKysg
Yi9kcml2ZXJzL2lpby9hZGMvaW14OHF4cC1hZGMuYw0KPiBAQCAtMjAxLDcgKzIwMSw3IEBAIHN0
YXRpYyBpbnQgaW14OHF4cF9hZGNfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2Rl
diwNCj4gIAlzdHJ1Y3QgaW14OHF4cF9hZGMgKmFkYyA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+
ICAJc3RydWN0IGRldmljZSAqZGV2ID0gYWRjLT5kZXY7DQo+IA0KPiAtCXUzMiBjdHJsLCB2cmVm
X3V2Ow0KPiArCXUzMiBjdHJsOw0KPiAgCWxvbmcgcmV0Ow0KPiANCj4gIAlzd2l0Y2ggKG1hc2sp
IHsNCj4gQEAgLTI0NCw4ICsyNDQsMTAgQEAgc3RhdGljIGludCBpbXg4cXhwX2FkY19yZWFkX3Jh
dyhzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0KPiAgCQlyZXR1cm4gSUlPX1ZBTF9JTlQ7
DQo+IA0KPiAgCWNhc2UgSUlPX0NIQU5fSU5GT19TQ0FMRToNCj4gLQkJdnJlZl91diA9IHJlZ3Vs
YXRvcl9nZXRfdm9sdGFnZShhZGMtPnZyZWYpOw0KPiAtCQkqdmFsID0gdnJlZl91diAvIDEwMDA7
DQo+ICsJCXJldCA9IHJlZ3VsYXRvcl9nZXRfdm9sdGFnZShhZGMtPnZyZWYpOw0KPiArCQlpZiAo
cmV0IDwgMCkNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsJCSp2YWwgPSByZXQgLyAxMDAwOw0KPiAg
CQkqdmFsMiA9IDEyOw0KPiAgCQlyZXR1cm4gSUlPX1ZBTF9GUkFDVElPTkFMX0xPRzI7DQo+IA0K
PiAtLQ0KPiAyLjM2LjENCg==
