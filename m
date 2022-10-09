Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759AB5F88CB
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 04:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJICKs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Oct 2022 22:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJICKr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2022 22:10:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182FF2B19B
        for <linux-iio@vger.kernel.org>; Sat,  8 Oct 2022 19:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXuJPmcJ1rjktK96JddmeJEJ7y06e4TmIdg9SqbvihvAm612QNAwERF0LvIR0FmQJ5Vba5WUWXjO/06lM0UJYZbSmrUn8neQp/E1KTsmv7hrfgd1rIr/bwFzX28LLYkglnfXT4P3USPnagr6dcIoxEbafupR1yIZRSxatr2yFbgd/IiG9WZ9KoaTtZSltTDXEArcfvMsDZDyOWAEwmNW3KR78lNiB9hJIkuBY7TNPHYKz6KYUJDVOipDpaXUGCq2v6fU1ysarx/wLHLUPsCDlYUi33gR+SlIidLGetNEnGqAKgs53YHuxRWN/OpFxpDQ/46IfRXKp217vyUHucT5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhgpkXHe/v3lMsYA9AppCDb4xxQC66OzQrE5tapOcOI=;
 b=Ka+WLb0tncCG7E7XZOpk5TmzvsOJY+7xXwApz5tOF9Orr7v/wVHRNnms9TQ2Q9C11/TB/Jo+QMhQvwTkole3ueg+zk+RI/NF6/UAnNNL374oNHn7TmoYSxdDSaFE7i5x4ZEPre+o4xs3FZee5nldJ+pntrNfFagom/DykhtGYIAu4nP9l/MXC0N4cO1V23fOeXHnz7e0QPG24kGBtaJSLxiMMok1iGc7Zn5NECICLg8ffz+JJDgYOJVwzr1qqrzEoNflDeI8d4Ph2JV3bbBm9OyhYNQysIaPPLAH5LS+6lUw8oSaP9adpGKyq4eVgnpvJ67b1m8g4r21VMcsNBs7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhgpkXHe/v3lMsYA9AppCDb4xxQC66OzQrE5tapOcOI=;
 b=WAypobhoGj/0FwMwfAcspA+c9DHZKG0N79gBVJ26XZ/usbBQWgD0HmhPUmmr8SJPwLMAjqJughOs5klk0FsjmCoanJSp3nVeybFRB330uE5J4HugSorvQCUEYIS8Ugk379isjaWv6mfs00CUH8s5kqHnSWvQPN7RrTtF+vDnwOo=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DBBPR04MB7705.eurprd04.prod.outlook.com (2603:10a6:10:209::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Sun, 9 Oct 2022 02:10:43 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27%3]) with mapi id 15.20.5709.015; Sun, 9 Oct 2022
 02:10:43 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
CC:     Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: RE: [PATCH v2 10/16] iio: adc: vf610_adc: vf610_adc: do not use
 internal iio_dev lock
Thread-Topic: [PATCH v2 10/16] iio: adc: vf610_adc: vf610_adc: do not use
 internal iio_dev lock
Thread-Index: AQHY1/gqIVVlG6SUJEG4ZkkWXvUL+q4FWJaA
Date:   Sun, 9 Oct 2022 02:10:43 +0000
Message-ID: <DB7PR04MB40104FAE90AF7AEA2A08D50690219@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
 <20221004134909.1692021-11-nuno.sa@analog.com>
In-Reply-To: <20221004134909.1692021-11-nuno.sa@analog.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DBBPR04MB7705:EE_
x-ms-office365-filtering-correlation-id: 1ceee621-5777-42bf-fcaf-08daa99b787e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oAkqxB2UsKKem5SMg8UjHW5Nty2U166OTkqShIgGM8DqSE8ki96cnVFpNGxOTeZkJHtBVb7kzclDL5bm4nj5OBU8pImy1AydFHdQ7YGrGngJiGnRrD5M48DQrZA0ZfuF297sLNk+3StaJULzfFfleNmt452yeSENeayVqZBUcwXXehB9LLwA1wH6NP6+ZYsCdZkayhTb0LDo6B6rE5YUjJSc2cRNSleqpS++sOon67ghwSLD1JA69v42y+exB7ZWkZYDUoLY0KoGfMWIXv/j+pKjUZEkSfymWBA3vNFcidNbKc8o6fogSR6yMz1iYfnx7B1OPb9eSvi8pdg8iCDvq+L0bFLbRS4DyKMYvLJeMc18gUtdmT6D+S3dGkVBrgwXkshjsk9J8ZSdleQdqtiuI/OkkLBUqMuVFnzWvpz2trulvAv8qKu/qZALpm2DW3Z2q4xPRJce7n4N/ll4rNYC4X0x8sxxF/2RoVgSY2XBv+wpMhqi8KIzM6sLqG+fpjXlJECmPAM1D3NVNGp3/DlL6GGl5kx1tx6h/E8zflk0Kzc/dJpgQ5GiIQjLK2cPY6gY8zn/rLKI8LRmUQwxrjj+b8Wao4E4KgYwZer3FD9cs9Dpo9G3GjGHTJ13/VszclmfOQ2ZT/V8u79uS49ozfmeu7mkBxrcZ3YGy0gWKrkcYETp6q6b5kKnk0CObAGAYRKhWOvcgaB9Z7y8Rdc8BcRm0JlzwXsf8QR4Kjh9ImvewUSTQ1X7cS/U/LStV5ZdL/EIf64/ag3Us6NmuZtT2d5yzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(110136005)(8936002)(54906003)(52536014)(55016003)(83380400001)(186003)(86362001)(316002)(9686003)(71200400001)(26005)(2906002)(7406005)(5660300002)(7416002)(478600001)(6506007)(53546011)(7696005)(64756008)(4326008)(8676002)(66446008)(66946007)(66476007)(76116006)(66556008)(38070700005)(122000001)(33656002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkR0akdVTlN2QVQ5OTErODJVcXNXSWkrRXgxS2xIL2FlYVc4YnVwY0dORHp2?=
 =?utf-8?B?cmJQVDJXNi9aQjJpUWRpZCtmcFhsQlZnU2haS0t2YzNOUmlZRGJtOVowbVlJ?=
 =?utf-8?B?eTIrU1lzWFRyemlWTG4vRStGd090Y0dUYXJJRlUwUDljNXhGTFpVaDFSaTB6?=
 =?utf-8?B?bW9PS1Nza3pPQ1RadTk1VU1jZndwOEE4enNjcHBtOEQ0S1BiaFVsbmxMT1dk?=
 =?utf-8?B?bk5Sb055bUN4dzNjTnhiMVovbmVTM2tYVUN6RkZIZlhWWVZQQWNrNWRHczVX?=
 =?utf-8?B?U3JEeGV4NWZJcjVCQTdONVh5aTk5TTF3SU9PMGRzZUlwRWZMWVNFbW1md3A3?=
 =?utf-8?B?VnN1bnFhTHZTQy95TUN2cFNZWEdJMUhBRkhvalFUb1N3YVNVbXVhZCsvT1JW?=
 =?utf-8?B?TzJlSzVZNER1aUNYR3VjcllaajgzVkgwT3ppNm5yUjJpUStMTXZ3RUFGYUZI?=
 =?utf-8?B?ZjhJZ1ArSTlqNnN6bWxjOVUyZXUzMmFUV0ErYjJyd0FtaXJjVkE2S3lDbXJB?=
 =?utf-8?B?MFd4RnQ4NVpwRUtlVkJDc0lVN1JFZEtaQS9xSFlhRmdNQXBLWU9Meld4eWtY?=
 =?utf-8?B?b0d3SmJHRllkNHFpSzE3cjNiVnJRVEd0cDF3WmRYNDBXQ0UzcWdJSkNTT0Qy?=
 =?utf-8?B?WHhoNThhYk5GcVFpY1hOYnVMWlJXM05SUFlsUFdHWFd6cm5pZDVLTnBpdWtV?=
 =?utf-8?B?bkZoSU9nMW00K0NTZmg0S2J1Q1ZLekZ3c0dwckhwQVBpMk9NQUl5aHBFdEwy?=
 =?utf-8?B?d201bXFKYW5qOWp1Tlg4d0ptVUZibnZLWGE2TjAxY3UzaC9mNG13eGh4WTZ5?=
 =?utf-8?B?RDJlWHQxNXNDbEREbFZYVVZ3UHpWaFI5UlJZNjJSQjVEZ3Q4U3hvQXpyMVBK?=
 =?utf-8?B?cHIxR1Nzd2lnRklvZmJqT2RTVzY1bDQzTlViaGk2RUhGYmNuK0ZqVjVkQnJU?=
 =?utf-8?B?MlVlcno1R1BPUnVDZzlKZDBqU3lCcVcxQlRoek5CdGNUdFhEY3p5VnJYTXlD?=
 =?utf-8?B?ckpOZDgzQk1mdjdBaFUvM2paZU83anFpV3czOExCNEVmbzR6d0tvZ2pZZ3Fn?=
 =?utf-8?B?RzdMeGs1TWJ0N01tb3lDUU44Qk91Vm1LOHlYU0hRYzB1dU9SOWZaSFNLNCtX?=
 =?utf-8?B?MXNkTmxFdnBHcVJ1TVpvUVBvZzBUYkZqU09WY1lNR205c2RCWWdzVmJpTUZM?=
 =?utf-8?B?TmkycXR2ZW5SdVNxMUpzbHVLZVpPMmdpMCswblpFMWorSHpTUWtKL1RnaDl1?=
 =?utf-8?B?Vm41Sks1MVIzRGwvYml5a3FCb3l6S0hKc3l5V0E1SzlGTGNNb1pKS1pLOUVs?=
 =?utf-8?B?ei9kVEU5TEZXZGcyQ3l0TGxkemdlQWRoSFVJY2ZxRW5KMWk3S1dHQldnSHhy?=
 =?utf-8?B?MkQ1ejNWVk9BRUM1UzVkKzJHQ1ByMmdhQjM0dUJzb2tVU21Qa2t2R3NQdzQ2?=
 =?utf-8?B?OHgvaXJOdDNiaTJPZWExQlAySktSYXpKOWhYR2hRa0lmZUlMa1dUdUJEZmhR?=
 =?utf-8?B?c1g0TS9LTXV2ZkZiOXVSWVhBb3VrWGlRczdhb0tLNWxhQUt2R2UxSmgzWHlY?=
 =?utf-8?B?OHlQdVR3YkhiVzhxcW5NQitOTmdXeStIVUZ1UUV1ZHFsQWhsR09sNGpwYjBD?=
 =?utf-8?B?cGVQN1ozNEN4Y3J2WkpVaHNiK0lUMWZlOTVmNFUrdHd1d21kdzBlU1RINjZ2?=
 =?utf-8?B?WVZpK0JIVWg2bWtmOHpzVkNKallpRnBJZUViMysrS0lqdW84K0F6UFhobWZ2?=
 =?utf-8?B?L0MrbDZNeHBTQzEvRnd3Z0dtK0MxaWs3R0lHeTlWa3U5ZkJmNWJFaXJjbmdt?=
 =?utf-8?B?VUlWTXYyNEdaTHlpVWpsYlhNdEd6WVhweDNsdG81bFIzemp3Q3diTFZoS0d5?=
 =?utf-8?B?Mm1jNG1saTZ4QTJKaDdVQmUvRFlDaVVpL2REclN2MnlOVGZOQzdDSURLdFVF?=
 =?utf-8?B?R0daQmRVMjdXczdQMVNKODZxZHFzQjFjbGhIRzVVUVFqVUh6dys3UENSWlVH?=
 =?utf-8?B?MlkyVlJKdEtydUV1Q25vYkh6eU0xajNjQW5xRzluVHZvVHl3S1BBUmMrOXFX?=
 =?utf-8?B?dG9DTHlEL1l5cG4vM3E3YVk0K0VsNEhYK0l5UmtyeWc5QXRpU0xxTVFmQ0Rx?=
 =?utf-8?Q?Oo/cUazhcqb0NmqP5xhTDmzSA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ceee621-5777-42bf-fcaf-08daa99b787e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2022 02:10:43.2647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbHpELwCAOSWKf6RN821qGUGQZQz18gz9Z2j8WVrzcapV8sd9SI8v3m246M7mBBn4nsbHgipIbpMRo6/UNYx2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7705
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOdW5vIFPDoSA8bnVuby5zYUBh
bmFsb2cuY29tPg0KPiBTZW50OiAyMDIy5bm0MTDmnIg05pelIDIxOjQ5DQo+IFRvOiBsaW51eC1h
bWxvZ2ljQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+Ow0KPiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4g
Q2M6IEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+OyBNYXJ0aW4gQmx1bWVuc3Rpbmds
DQo+IDxtYXJ0aW4uYmx1bWVuc3RpbmdsQGdvb2dsZW1haWwuY29tPjsgTmVpbCBBcm1zdHJvbmcN
Cj4gPG5hcm1zdHJvbmdAYmF5bGlicmUuY29tPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwu
b3JnPjsgTGFycy1QZXRlcg0KPiBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBKeW90aSBCaGF5
YW5hIDxqYmhheWFuYUBnb29nbGUuY29tPjsgSGFucyBkZQ0KPiBHb2VkZSA8aGRlZ29lZGVAcmVk
aGF0LmNvbT47IEFuZHJpeSBUcnlzaG5pdnNreXkNCj4gPGFuZHJpeS50cnlzaG5pdnNreXlAb3Bl
bnN5bmVyZ3kuY29tPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0NCj4gPGtlcm5lbEBwZW5ndXRy
b25peC5kZT47IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+OyBDaXhp
DQo+IEdlbmcgPGNpeGkuZ2VuZzFAdW5pc29jLmNvbT47IEJhb2xpbiBXYW5nDQo+IDxiYW9saW4u
d2FuZ0BsaW51eC5hbGliYWJhLmNvbT47IENpcHJpYW4gUmVndXMgPGNpcHJpYW4ucmVndXNAYW5h
bG9nLmNvbT47DQo+IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IE51bm8gU8Oh
IDxudW5vLnNhQGFuYWxvZy5jb20+Ow0KPiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU+OyBBbGV4YW5kcnUgQXJkZWxlYW4NCj4gPGFhcmRlbGVhbkBkZXZpcW9uLmNvbT47IEZs
b3JpYW4gQm9vciA8Zmxvcmlhbi5ib29yQGtlcm5lbGNvbmNlcHRzLmRlPjsNCj4gTWljaGFlbCBI
ZW5uZXJpY2ggPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBPcnNvbiBaaGFpDQo+IDxv
cnNvbnpoYWlAZ21haWwuY29tPjsgQ2hlbi1ZdSBUc2FpIDx3ZW5zQGNzaWUub3JnPjsgQ2h1bnlh
biBaaGFuZw0KPiA8emhhbmcubHlyYUBnbWFpbC5jb20+OyBWbGFkaW1pciBaYXBvbHNraXkgPHZ6
QG1sZWlhLmNvbT47IEFuZHkNCj4gU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNv
bT47IEplcm9tZSBCcnVuZXQNCj4gPGpicnVuZXRAYmF5bGlicmUuY29tPjsgQm91Z2ggQ2hlbiA8
aGFpYm8uY2hlbkBueHAuY29tPjsgS2V2aW4gSGlsbWFuDQo+IDxraGlsbWFuQGJheWxpYnJlLmNv
bT47IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFtQQVRD
SCB2MiAxMC8xNl0gaWlvOiBhZGM6IHZmNjEwX2FkYzogdmY2MTBfYWRjOiBkbyBub3QgdXNlIGlu
dGVybmFsDQo+IGlpb19kZXYgbG9jaw0KPiANCj4gSW4gb3JkZXIgdG8gZHJvcCB0aGUgaW50ZXJu
YWwgbG9jayB1c2FnZSB3ZSBuZWVkZWQgdHdvIGRpZmZlcmVudCB0aGluZ3M6DQo+IA0KPiAxKSBU
aGUgZmlyc3QgcGxhY2Ugd2hlcmUgJ21sb2NrJyB3YXMgYmVpbmcgdXNlZCB3YXMgYSB0eXBpY2Fs
IGNhc2Ugd2hlcmUNCj4gaWlvX2RldmljZV9jbGFpbV9kaXJlY3RfbW9kZSgpIGZpdHMgcGVyZmVj
dGx5Lg0KPiAyKSBJbiB0aGUgc2Vjb25kIGNhc2UsIGl0IHdhcyBiZWluZyB1c2VkIHRvIHByZXZl
bnQgY29uY3VycmVudCBhY2Nlc3NlcyB0byB0aGUNCj4gZGV2aWNlIGFuZCBzaGFyZWQgZGF0YSBi
dXQgbm90aGluZyB3YXMgYmVpbmcgZW5mb3JjZWQgd2l0aCByZWdhcmRzIHRvDQo+IGJ1ZmZlcmlu
ZyAoaS5lLCB0aGVyZSB3YXMgbm90aGluZyBwcmV2ZW50aW5nIGZyb20gY2hhbmdpbmcgdGhlIGNv
bnZlcnNpb24gbW9kZQ0KPiB3aGlsZSBidWZmZXJpbmcpLiBIZW5jZSwgaW4gdGhpcyBjYXNlLCBh
IG5ldyBsb2NrIHdhcyBpbnRyb2R1Y2VkIGluIHRoZSBzdGF0ZQ0KPiBzdHJ1Y3R1cmUuDQo+IA0K
PiBOb3RlIHRoYXQgdGhlIGdvYWwgaXMgbm90IHRvIGludHJvZHVjZSBhbnkgZnVuY3Rpb25hbCBj
aGFuZ2UgYW5kIHRoYXQgaXMgdGhlDQo+IHJlYXNvbiB3aHkgYSBuZXcgbG9jayB3YXMgaW50cm9k
dWNlZCB0byBndWFyYW50ZWUgMikuDQo+IA0KPiBXaGlsZSBhdCBpdCwgcHJvcGVybHkgaW5jbHVk
ZSAibXV0ZXguaCIgZm9yIG11dGV4IHJlbGF0ZWQgQVBJcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+DQoNClJldmlld2VkLWJ5OiBIYWlibyBDaGVu
IDxoYWliby5jaGVuQG54cC5jb20+DQoNClRoYW5rcyENCg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlv
L2FkYy92ZjYxMF9hZGMuYyB8IDIyICsrKysrKysrKysrKysrLS0tLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaWlvL2FkYy92ZjYxMF9hZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy92ZjYxMF9h
ZGMuYyBpbmRleA0KPiBhNmY5MTgyZDc3NjYuLmFlMzFhYWZkMjY1MyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9paW8vYWRjL3ZmNjEwX2FkYy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy92ZjYx
MF9hZGMuYw0KPiBAQCAtNyw2ICs3LDcgQEANCj4gDQo+ICAjaW5jbHVkZSA8bGludXgvbW9kX2Rl
dmljZXRhYmxlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ICsjaW5jbHVkZSA8
bGludXgvbXV0ZXguaD4NCj4gICNpbmNsdWRlIDxsaW51eC9wcm9wZXJ0eS5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVw
dC5oPg0KPiBAQCAtMTU2LDYgKzE1Nyw5IEBAIHN0cnVjdCB2ZjYxMF9hZGMgew0KPiAgCXZvaWQg
X19pb21lbSAqcmVnczsNCj4gIAlzdHJ1Y3QgY2xrICpjbGs7DQo+IA0KPiArCS8qIGxvY2sgdG8g
cHJvdGVjdCBhZ2FpbnN0IG11bHRpcGxlIGFjY2VzcyB0byB0aGUgZGV2aWNlICovDQo+ICsJc3Ry
dWN0IG11dGV4IGxvY2s7DQo+ICsNCj4gIAl1MzIgdnJlZl91djsNCj4gIAl1MzIgdmFsdWU7DQo+
ICAJc3RydWN0IHJlZ3VsYXRvciAqdnJlZjsNCj4gQEAgLTQ2NywxMSArNDcxLDExIEBAIHN0YXRp
YyBpbnQgdmY2MTBfc2V0X2NvbnZlcnNpb25fbW9kZShzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9f
ZGV2LCAgew0KPiAgCXN0cnVjdCB2ZjYxMF9hZGMgKmluZm8gPSBpaW9fcHJpdihpbmRpb19kZXYp
Ow0KPiANCj4gLQltdXRleF9sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4gKwltdXRleF9sb2Nr
KCZpbmZvLT5sb2NrKTsNCj4gIAlpbmZvLT5hZGNfZmVhdHVyZS5jb252X21vZGUgPSBtb2RlOw0K
PiAgCXZmNjEwX2FkY19jYWxjdWxhdGVfcmF0ZXMoaW5mbyk7DQo+ICAJdmY2MTBfYWRjX2h3X2lu
aXQoaW5mbyk7DQo+IC0JbXV0ZXhfdW5sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4gKwltdXRl
eF91bmxvY2soJmluZm8tPmxvY2spOw0KPiANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gQEAgLTYy
OSwxMiArNjMzLDExIEBAIHN0YXRpYyBpbnQgdmY2MTBfcmVhZF9zYW1wbGUoc3RydWN0IGlpb19k
ZXYNCj4gKmluZGlvX2RldiwNCj4gIAl1bnNpZ25lZCBpbnQgaGNfY2ZnOw0KPiAgCWludCByZXQ7
DQo+IA0KPiAtCW11dGV4X2xvY2soJmluZGlvX2Rldi0+bWxvY2spOw0KPiAtCWlmIChpaW9fYnVm
ZmVyX2VuYWJsZWQoaW5kaW9fZGV2KSkgew0KPiAtCQlyZXQgPSAtRUJVU1k7DQo+IC0JCWdvdG8g
b3V0X3VubG9jazsNCj4gLQl9DQo+ICsJcmV0ID0gaWlvX2RldmljZV9jbGFpbV9kaXJlY3RfbW9k
ZShpbmRpb19kZXYpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+IA0KPiArCW11
dGV4X2xvY2soJmluZm8tPmxvY2spOw0KPiAgCXJlaW5pdF9jb21wbGV0aW9uKCZpbmZvLT5jb21w
bGV0aW9uKTsNCj4gIAloY19jZmcgPSBWRjYxMF9BRENfQURDSEMoY2hhbi0+Y2hhbm5lbCk7DQo+
ICAJaGNfY2ZnIHw9IFZGNjEwX0FEQ19BSUVOOw0KPiBAQCAtNjY5LDcgKzY3Miw4IEBAIHN0YXRp
YyBpbnQgdmY2MTBfcmVhZF9zYW1wbGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwNCj4gIAl9
DQo+IA0KPiAgb3V0X3VubG9jazoNCj4gLQltdXRleF91bmxvY2soJmluZGlvX2Rldi0+bWxvY2sp
Ow0KPiArCW11dGV4X3VubG9jaygmaW5mby0+bG9jayk7DQo+ICsJaWlvX2RldmljZV9yZWxlYXNl
X2RpcmVjdF9tb2RlKGluZGlvX2Rldik7DQo+IA0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IEBA
IC04OTIsNiArODk2LDggQEAgc3RhdGljIGludCB2ZjYxMF9hZGNfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAkJZ290byBlcnJvcl9paW9fZGV2aWNlX3JlZ2lzdGVy
Ow0KPiAgCX0NCj4gDQo+ICsJbXV0ZXhfaW5pdCgmaW5mby0+bG9jayk7DQo+ICsNCj4gIAlyZXQg
PSBpaW9fZGV2aWNlX3JlZ2lzdGVyKGluZGlvX2Rldik7DQo+ICAJaWYgKHJldCkgew0KPiAgCQlk
ZXZfZXJyKCZwZGV2LT5kZXYsICJDb3VsZG4ndCByZWdpc3RlciB0aGUgZGV2aWNlLlxuIik7DQo+
IC0tDQo+IDIuMzcuMw0KDQo=
