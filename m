Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FEE75FAAB
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 17:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjGXPWS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jul 2023 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjGXPWQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 11:22:16 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2127.outbound.protection.outlook.com [40.107.113.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D4210FD;
        Mon, 24 Jul 2023 08:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nv2WQ9jeSfs+GT/DKDx+N00xUYA98fR7ZukfC8rjsgF3pB6pSOM7etuztfyXAH0y6XIZpHhQJBmhe713+Jiw17+UIWdFo3uXPHqQ1Os3dxmtRQkRlhvbrLGHKIVdGu0+AklhytdfvKDejw3TNgyJpLTOgCm8M0VWObBmXRWbmWo18OvjxdtXy+FbtmVcVTtQRZw9OQrFOr2u45/u35Tp7WS4YE2dp7CKblA4FaKMiF9InEY2aKd+9IcOh+vcieflDk/XZj+czta295T4rd1aSnhOdnrq3I0L5dPUocINmGtq4nC8FILSszqLn+EicXJFeVMtTZ38jhJckRuOWFmdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtJWnIUcY/5BU1osam42+wu3H/vgqcfqoKtrLgiiwmc=;
 b=Wvct+XTo6GwalN35/KokPOQhj8AzLLmd7NXdkCQ9XX19zYKgAPRe4a3juiNZXGo0g5RjmVh64alttzo98ENWd8iauvTWApQfvNTDkampnn6yQO1/W8kmBh36+urFhw19mjQSV3xhlljeMpzR0Zmb8sdZkaRsvq7AYn0z67N8JegXMVwvYQJbM8EKHFOGIXfXMtAz2EIfSlcZt5LV1clyUYSBUcPqh/e6nbTCJMJnQiYuobrx8C+EJ4qlmTfuuQ6llLSUtIs25q/xMBZZxbHo/0Y1YAO1c0oHhJd7rNlGvPBQArqCBMOze+joBaWq+f8O/IHuCOsxgsgsArhlQzPq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtJWnIUcY/5BU1osam42+wu3H/vgqcfqoKtrLgiiwmc=;
 b=nxKDJpxz6gcWPKRGlpRSqs/8hWYJho1fm7IQvBvQYQtpXdSVhWvxYas5vZ+eZUpSRpO698cw7MrmwqYTg6rh41aVm511L9jOyN29wr08bqAm61IuSnJPrlIOlUqdOpib8VQbC98HCq1s0dfopVAojJWPCGnL8vxMhEJAELQByOw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5987.jpnprd01.prod.outlook.com (2603:1096:604:ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 15:22:02 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 15:22:02 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     William Breathitt Gray <william.gray@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2] counter: rz-mtu3-cnt: Reorder locking sequence for
 consistency
Thread-Topic: [PATCH v2] counter: rz-mtu3-cnt: Reorder locking sequence for
 consistency
Thread-Index: AQHZu+mQWum+pJ7Rkki5uRpa32ZX9a/JA9IAgAAJAyA=
Date:   Mon, 24 Jul 2023 15:22:02 +0000
Message-ID: <OS0PR01MB5922D84DA025C2C985976AD18602A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230721153933.332108-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdU6PFqF-NLB7LdA4LLAN7VfSTwDg2iHFtc5GR+riQp4eg@mail.gmail.com>
In-Reply-To: <CAMuHMdU6PFqF-NLB7LdA4LLAN7VfSTwDg2iHFtc5GR+riQp4eg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5987:EE_
x-ms-office365-filtering-correlation-id: 8e9363f3-74b8-4928-08b0-08db8c59bb1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f488YESXCMmMTbyJkueJYfNKFChWsyf/ky9PQY7uq7orDY4O08WY90vq0138gYdHkAqsAWnhhvw1bgtrzVeAuC+ulUVPkffEn7EfP4JpvWXJXYR/XYpDmM47UZO9gDBcEP38phnVhK2Lq830fJ3XKw2EaJna+Q8a8oIZd0AswOaw5IUev2TRFF9oa2V+n1YN6/lgP6TZ9985JiNyUYJvfBunCuSXKUlog77xceMeUnCKdIbcaV+L1ArCEuvktAh0N8FbogCavmQ6RXg5oupOKIE7OqirTMi+8c6v2mCw4LiNHT6/cQj2jYg2vg7E8u9Q8PiGeMB6Dnu3AM5F3hDHVcM+4Yj8B3wtIaOvWcnZK+MVOafshYbLcjjBPZRhD1GmStbqtOFWljfPYVk1Fukm9CTqoMHTDtr09/byw4j+/inn+7Wouigw0NJlxm1W0BXW8IuaZ39pUiPzbKkir0aila+jvyp0j12fniVkl/MLZC5dH8k6O8vGVbPJgQj0S8bhbzUGsLYxqXzVQ6KMAW2lx9RKtz+tujePuhVebMda04MHGLOtdUOsu80cIm6U0Ii2BKDJi/Pf/DYIPN2KFajJ8VxG9ysloGV8HpdbcfA1KpnGALAqrWtjOdHr0cccSiYY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(38100700002)(122000001)(55016003)(53546011)(107886003)(83380400001)(8676002)(8936002)(5660300002)(52536014)(478600001)(54906003)(6916009)(4326008)(66556008)(66476007)(64756008)(316002)(76116006)(66946007)(41300700001)(186003)(6506007)(71200400001)(7696005)(9686003)(66446008)(4744005)(2906002)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVpQbFFmOUQxWG1aUHV3YlRlOVkveXBISURsbWF3RGRqZngrL0dQdEZySzVh?=
 =?utf-8?B?NDhrSUtXVVljYWw3b1NVdkJQajhlM2Y0Q0ZmWmZyTjA4NDU3Wmp0WkNUTS9R?=
 =?utf-8?B?bjdyaGVPaThoYytGZ05DWkhyUW5pVlQyY2tiVlFoUzFibmJjR0NYbTBMZ2J4?=
 =?utf-8?B?blFyanMvNkdKS3FXTGE2ZzBteFFzN1QzRFI1MHFrUjNmN1BmLzVJeXFoZjVB?=
 =?utf-8?B?eEZzT0RkNW4vd09OSktyeDA4amFzR1VvQ1FXVnJxamlJWmRETHVyc09objEz?=
 =?utf-8?B?SmpvNlZ2SHp4eFZqd1Jic3NkWXVLY2RFWVpHWmpCN3MxOTVIZnhKYUNBWk9n?=
 =?utf-8?B?Z1ZWYzNkN0c0VGZ1WXgyLzVzcFhrRnZvYStPZ3V6TWVvUEtYN0Rxbmduempa?=
 =?utf-8?B?ZTRqQldISHhwNkdmOTdkUytpYkt3TG00ZUdIYnRzZVd5Yks4RG1aUkNzMWF2?=
 =?utf-8?B?VXJvZnYra2U5a29yVVJQdVZZaEplRTU3V2FDVU82d3kwN1FTSzAvcHkzNXRP?=
 =?utf-8?B?dFpldDhvWFozbFVBYmFmR21Ma1BxRVJXR1lmUFVJNEpMdGpESkU5dGNQRngw?=
 =?utf-8?B?TE92TGF5cVBOZ0tUbThkbjArbm03T1FOUHVnWnVZME9odjZrYld3TkRxY0U2?=
 =?utf-8?B?Z2dyeW1wOUVJQ2Jmd3BNaDJuSEgvUnFLWmNyZmJoTWlkaEZyVnBCRTJZUThz?=
 =?utf-8?B?ZGoxaHlmT1hmL3Jod0FlQmxjcVNVNFNEcGNlb1JRelVxSFpPczhIUEJZMmd5?=
 =?utf-8?B?YjhTZXF5Z3Rnak9ENmlJR3VFMGFmK1h6djVpS3gwQ0JKTXYxU3FnNDhjaFBv?=
 =?utf-8?B?TUFZU2RSdC9QdnFVTUFHOEx1SjlxbDNldGo2SFVJRmlocm1VS3ZZby9ML2lL?=
 =?utf-8?B?WjA1N25kbE5rYzZ2cEUwVCt0U1d2MmpzT0JTaC8wejBmdmRQajd2TXJHZVNT?=
 =?utf-8?B?SFRjNkhrVEhRblI4ZHBDcSs1R3k1WGpCWkhtWFdhTVRKbEV3MkM3TnpsYXAv?=
 =?utf-8?B?SnlPOFNpZVJZeXZQam1LWlZib1pXSnh5K1JMKzNtRkxrNHo1TXlvalBsckw5?=
 =?utf-8?B?NEZiYjdaTEJRcHFTMzN1UGJnc3hadHNkcXdteEpQcVlpQVE0ZVd0VTh4Sndr?=
 =?utf-8?B?R20xOHpHZXhpSFNnMkt0Z1pxSnowbk9rUHJqclFZWDMrMDZ1WGl0c0E0SzFV?=
 =?utf-8?B?b0xCWVlIWCt5aHQ4WjhLNFVMNHBZMGp1NGZSTkNQZjZaa1dna1ZUMCtrVXlF?=
 =?utf-8?B?S1J6dHRYak4vQWZjUEgzOXJUN2FYVnM0N3ZiOTFCemtpTzZId09Tai9qcys3?=
 =?utf-8?B?Z0lSZ3paTkE5QWtaNyt1U3pJQ0hVcFBFcFkzNlY2U1lnTWkrQjZlOFZIbkYr?=
 =?utf-8?B?dGgzbkhXWVAwbjAwQ1d4RG93ZWxVaWNvNnQxWWpISGw2cjI4Y05lNUZ5Zkpq?=
 =?utf-8?B?c01TWWFMRTdHaVpmNi9OSGVOWExGSkVVMXZYczdFU3I5MHJyWWVJOUZZeEVG?=
 =?utf-8?B?VyttMXo0V2NuYzVNWTJVdnRxTVJOZTQ5K2V5YlYwMWN5TTFLdTlEOVhOa3Y3?=
 =?utf-8?B?ekZxeEVESlBQcHUrWXBNQmQzRnZzQWN6WmI3eXBTL29CWnBNTGFwQ25ZQ21o?=
 =?utf-8?B?U3FlTzhPWFhTY2VETWgyVmZCWDk3R1JzUmlQaTJRWGwyNzZJZUtOWXgwYnNr?=
 =?utf-8?B?Q2JDUkhNL0lCNVpEM3V6ekZnUTdEZDBEWU5iTjQ3ZzZwUVdydGg5d1lMSEFo?=
 =?utf-8?B?UG5DOEdnUWIwZHU5U2Q0Q3I3U2lHMWdQUW1MU204NWcvRXdPZ1NCQTQzY3g3?=
 =?utf-8?B?SjJDMTd6RGxrQjk1d3ZjNG1oWWprb3gyNFZIRThRVHdBV2VaMUJMRU5rSEht?=
 =?utf-8?B?dGZFTzNic3M0V05CcjYvYVRDc2RFWlhWQjY2d1V3VXcxK08zZXBtUzlZZWh4?=
 =?utf-8?B?Uyt6SDNKN0svb1BCTGFRTm1nd3J5T1hid0hvc3MzcDVLT2lUa09tdkxzbmd4?=
 =?utf-8?B?RWpsS0RERUFic1haUnltcXo2Q21nYW4wSXQvb2F4Y21KRVAvL3M5TDJtdFVv?=
 =?utf-8?B?dlhMazcxVjB1ZFNEZnloMmpGZTFvbkFZeG0rV2lwMVF0T2tnTmFFTUw1QnRa?=
 =?utf-8?Q?zKrk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9363f3-74b8-4928-08b0-08db8c59bb1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 15:22:02.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLDzcsHWdDlNxHUubxBAAFA10W/09Wq+WT1KinV3A5WtFcAGxpx6cXQyMjl8HMqoBQfe6I9uBQpXfEyfy9OgxoiwliXKRd0VuWlOPQYRHRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5987
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IE9uIEZyaSwgSnVsIDIx
LCAyMDIzIGF0IDU6MznigK9QTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
DQo+IHdyb3RlOg0KPiA+IEFsbCBmdW5jdGlvbnMgZXhjZXB0IHJ6X210dTNfY291bnRfZW5hYmxl
X3dyaXRlKCksIGNhbGxzDQo+IA0KPiBjYWxsDQoNCk9LLg0KDQo+IA0KPiA+IHBtX3J1bnRpbWVf
e2dldCxwdXR9IGluc2lkZSB0aGUgbG9jay4gRm9yIGNvbnNpc3RlbmN5IGRvIHRoZSBzYW1lDQo+
IGhlcmUuDQo+ID4NCj4gPiBSZXBvcnRlZC1ieTogUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRl
Pg0KPiA+IENsb3NlczoNCj4gDQo+IFRoaXMgaXMgbm90IGEgZGlyZWN0IGxpbmsgdG8gUGF2ZWwn
cyByZXBvcnQsIGJ1dCB0byB0aGUgYnJlYWQgc3RhcnRlZCBieQ0KPiB5b3VyIHBhdGNoLiAgV2h5
IG5vdCBhIGxpbmsgdG8gbG9yZT8NCg0KT0ssIHdpbGwgdXNlIHRoZSBsaW5rIHRvIGxvcmUuDQoN
CkNoZWVycywNCkJpanUNCg==
