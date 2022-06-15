Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75F754C77B
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 13:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241143AbiFOL0x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 07:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiFOL0v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 07:26:51 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10072.outbound.protection.outlook.com [40.107.1.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053954F1D4
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 04:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS0xFvSPvcDO35QUGr0x7lQLQm9mtTiqkwF2VaY2EgkN1eruxj0x60yrdjq2Eoo823+dmTRnhv1UTV8lVthiFDiWVl9+2ucnOnW+LJwWMcl0+RmTldUvv63m99+nV8vm4JlcJt2J9TdPG7OUEwVT74xMRjkVJRhdqJ0jloe0nR5OtcRuaWjZiVOj8rToJWFnjObqX9PufQAxqXBImOQcars5gBXjWKruIH4bndBSAZ4T8tYLvs/i/ISiKYVZu8dmRPO3ti4os494Fz5Q0KHs3creH3YLHBOQnZSdvi9PH/8CNr6DjnVWCnt3LuALIyH10sRqSjwbuq7o48aCQl3K+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8h5mPqk5/kG69EbepN/N/utXkrzTmHRUResDOIHIXPU=;
 b=bDBjola2cxptKqkw/fVo9qXdX23annoXpliCbJUjNOlSmtDHBK13/fp8cKvUzQ2DuBUMU4qx60IMZPdppUA6/O7K0k411q56wDm9fpSV2hi45nvb+JDOX9celQd2s/GtY/dBuBJiP/dGS86jIO22TcyNSBYm2pEZGWfnGur04b9Ojk60149vJCFxASqeXOgwWP6WafR7H0DaOC9ZuU8WTBbQipdh+kRBmoIzRz4dApnEsFOxad7N2vLTGSbfTBxrW/JRAnnb/ViU436MltahoMXiml1aNeXuLnZQiap2zFb5WBjfL6XPWLjBo+KT+9ixha+NWvOkw61OQ1LdPJp1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8h5mPqk5/kG69EbepN/N/utXkrzTmHRUResDOIHIXPU=;
 b=q7LsEDVnKNK3Nx/6vRnDyBI54WdvEBvshFHFd3qLFqyKCxrLP9ldfDbSr3tBCH3tyyo40hwlYQM+dw4LXFEM6/OpJQIORGS0JeKvNYOSzMVYIBZTAvP8jl95zG4qtR4QthwLu2CFcxclfNmW7EcB0/VPfLVYGgBnSkViczSQsjI=
Received: from AM0PR04MB4001.eurprd04.prod.outlook.com (2603:10a6:208:5d::20)
 by AS8PR04MB8657.eurprd04.prod.outlook.com (2603:10a6:20b:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Wed, 15 Jun
 2022 11:26:47 +0000
Received: from AM0PR04MB4001.eurprd04.prod.outlook.com
 ([fe80::f843:aee5:eb45:dfdf]) by AM0PR04MB4001.eurprd04.prod.outlook.com
 ([fe80::f843:aee5:eb45:dfdf%5]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 11:26:47 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] iio: accel: mma8452: remove the reset operation during
 driver probe
Thread-Topic: [PATCH] iio: accel: mma8452: remove the reset operation during
 driver probe
Thread-Index: AQHYJ6hClmYnFKRpxkqcnCLeaYH3M6yfx1WAgAL+joCAADQOAICdE8SAgBD11tA=
Date:   Wed, 15 Jun 2022 11:26:47 +0000
Message-ID: <AM0PR04MB40018A808DCDEC08151D983690AD9@AM0PR04MB4001.eurprd04.prod.outlook.com>
References: <1645505151-5789-1-git-send-email-haibo.chen@nxp.com>
        <20220222164331.00002d18@Huawei.com>
        <VI1PR04MB401628231C1D06E318820D26903D9@VI1PR04MB4016.eurprd04.prod.outlook.com>
        <YhfBZv7msnpvDVEs@ninjato> <20220604171657.78eb7927@jic23-huawei>
In-Reply-To: <20220604171657.78eb7927@jic23-huawei>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df9da9c7-7baa-47f3-a815-08da4ec1ef08
x-ms-traffictypediagnostic: AS8PR04MB8657:EE_
x-microsoft-antispam-prvs: <AS8PR04MB865769074027AC3C4AD6288490AD9@AS8PR04MB8657.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TtSR1YY+9DBTUoMhSMPOfDod7bHkWNdBMt6FIetpw+4bri5LAJ4X2I3CPRxXWrAoy01ftM53qq6up9Frv0rurVqACsA307USPWEpPhSCSd9lM8AJeGRndSH8+YotUjYhUHsWDTMIuESEPCFlGmCFTOr0CqxSTKyKyg2ls7sawGAjQZ3BmBbC4GtZmxPp63b4fzcKh06LiSrohN1zwb9v0qKbX4g8OXuJouTn5sd6fPBakdt5w+24y4YV7yhhJLo+JMduT3kNYw5IA8rRFQseCWaQRE2XpcsczZvLEAzOfOoaNCiNN/dfNE/Y78CPpRMjIJ1D0YP7qUdi6426Yj9uJAldXKR0ko8GOfCd72xS2tqFeAwsEuv5JQ2h6XLwcDPVlyVIjdWRNWT/4Q7lGhuF9cdhbGmdfJGFk3uax+k+SfPON5Qks9KOk74XJ0E5FG2qevD2iCU1QrniWagGOwe2Y7rR7P6IxWtNzwhYSFqNUql1HlB6OK9whOyMMOYk8krrXki20hLMdFUmwfu2GasdCXYamKdyc6yzDfloXkM13ubvxs4GscIxz+z5tm8nzsCUPs0emKjK7LkywremkHcIYlDR45ukBwSD+zghgMkx6egYKtkx5ANXrLYEyxJmLg4DU5U3Xr/bt/0LQKHxw+xCDEnRRI9feu6p4iOXnhlWHFr6V6gl21YNAxdSHT3P7EVgicYcS4sI1mRykON89TMmpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4001.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(33656002)(38070700005)(8936002)(316002)(9686003)(52536014)(38100700002)(55016003)(53546011)(5660300002)(8676002)(4326008)(7696005)(6506007)(66946007)(66556008)(508600001)(110136005)(54906003)(2906002)(66446008)(66476007)(26005)(71200400001)(186003)(83380400001)(86362001)(76116006)(64756008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aUhjbmdWcXN4alBacFZFQ2xsZ0xaZFRLbGkxeENPU1dheDBFc09DRkFVUUc4?=
 =?gb2312?B?cjJyRm9SbVJCN2JZMzNqN3dBaHV3dHJKOVRvNEVNeHArdGdzaDQ0ZlFwVGho?=
 =?gb2312?B?M3ZTVmNHY1JaN0JMREVMQUN1c041N0JmTVRTZHAvZlZraG1aVXRJZ2p0NGZn?=
 =?gb2312?B?dzNrNkp2Y2Ezem43T3lSbFVMQ2k4TkFqQVhJcmpiSm1sNDJBZ0VpSUw2WjYz?=
 =?gb2312?B?dUs3T1hzVXNWWXp6UkluNlplelM0ODZ2TlBXMFNBQWVNTWNuVFNCcmtqOWpF?=
 =?gb2312?B?em1kVUV1NEZjYnkrM2R1UDZaRU1WTWpEVFltZGhWR2hBcmJ5bGJ4M0x0djVp?=
 =?gb2312?B?dWVWcnM3UzRLa2RtNXR1RHVOd2RsZTdCVnVUODZyd0dDK2VzRXJKZkw1OW1p?=
 =?gb2312?B?alFLRWxwbGFrZ3UvN0YvVjA3S2RQU2J1VDdVZGc0RnRCdFMrWVNVbWpzMS96?=
 =?gb2312?B?amprTXI0OWxocG55Y1BDN2xKUVlEV2ZkV3ptR2NWa0F4WWJKQzhncUdjTy90?=
 =?gb2312?B?WkRoWlJMVWIvcmpyVXFrVU0xZFdLbjg0QWlyUnFuRjdDVnZVczU3d1J6V1M5?=
 =?gb2312?B?cnczN2tBL2p0NmVSeGl0VjAya00zekR2a0NENU1Jd1Bmb0hpV3Rtb2l4bHNh?=
 =?gb2312?B?U3g2d25lSjIzaWY3MVNvOXdjbVNFdzFOTlJ5Q0oxNXc4QUozTzVoWVQ1d1lt?=
 =?gb2312?B?aTdQZ0l5bTZ5cXdMbHVObWNjb095RFRaQjZuK3BYUzhZTDU2QjdieXhhTmdL?=
 =?gb2312?B?bGc1Z2lzK1BpOGN3d3JWbjBieGY5T1BpYXk4S1BpdzhrZnByT1hYNGlkSFJn?=
 =?gb2312?B?Z1lLcVUyMll6dEZBRkV4Ym9La3dzMG00bUZ3ck1mYkc5czh4azZlSGJEd3R0?=
 =?gb2312?B?Qmc3N3ZlQ09VN0VjcEllbWYybXdYRVI4STBsY0NxbEFOVnVPc2JVd3RLT282?=
 =?gb2312?B?UEFtMEQzK0tvK3UzWGpvS3NFMGsyOGdTaitlNWhIUUFxQzlFMnd0R1ZXZzMv?=
 =?gb2312?B?UUtlVVZ3TFFFMERhaUJ0RkdOMk5ubmFEMkNJU2lnc2VFVnpTWVp4TnZZRm82?=
 =?gb2312?B?NjMzaXNjSjJJcm1HYjk3SXA3K3ZvQjJqbU9NK3dEV1FmRFR3VmtSNS9QNysy?=
 =?gb2312?B?d3ZwYUtpTFZpU3k3MjJBbFlCSC9GbUlPbU5VckQxZHZRY3VyS2UrTXlhN1l3?=
 =?gb2312?B?OC9NT2dKdXd3bVB6K0JYY1NTak0yWktvOVRCeEdzWWtVZnJtMlFsSU5VeUZS?=
 =?gb2312?B?S1dtdkM2M2xCanFiYnFaSVQrU09CL09NdXI2bWk1ZHkxSnlmR1V1TGpYdVd2?=
 =?gb2312?B?d2RleXlUZ2s3alJOaElNMDMxOGxXejFDWWhmeUV1QmlTMVJKY25DZk1TMnM4?=
 =?gb2312?B?bTQrWVd1QVZ4TVBKaHd0RkxBVnVLVS85MG0zVlg4RVd5VlEreE1UaUJuQ3Zy?=
 =?gb2312?B?eWgxNEtUOVZTTjBlRi9mYVVXNFJvcUpzcTIvOXVUdktMYjFScGxzSXF1dUhP?=
 =?gb2312?B?TGNwU2U5bk53TDBDM1pWTVRxYWptQ1hVRk1Fdm1NWVpjcXp0SjZkTDdkeGVV?=
 =?gb2312?B?NmorMHNYTWs1azR6QnMza3ZmbGx2dUFsTEs1Wnd5T2lFdDV1Vm1HQ2FJcFlW?=
 =?gb2312?B?OEdHKzVsQ1NJRlFIc1hCZUJncGVqcDV6Smp0U0tzanVlYXp3NnAwWVZqUXA2?=
 =?gb2312?B?cjVnS0lIS2djN0pXN3lrVUNsT3F0M2cxVkdrSTNjdEFTeHlrRllnbjRlamIr?=
 =?gb2312?B?anB1UzdMeFJjYkR2cS9yOHlQMm1KY2xWNU1WWXErcXNkTHZBaXV5bjVZam1E?=
 =?gb2312?B?OFVmOXAvdzNCdWIyYlhCVmJ5MUthdXk1YW5JWHVDVmYxRHBBTzlicTJnZlkr?=
 =?gb2312?B?NGxkVUwwTTZWdFhXU0FzWTc4dWlhN2xLN3RlMHRSRnFqMzBSSXpaUzcwV1Ux?=
 =?gb2312?B?dlJEeTRWQkY3eE81aWIzNWt5YzZTMVRSLzlKTU5TSzdKYUVWQWp4OTBGMXl0?=
 =?gb2312?B?NWI0czN6N0dWem1TbTEvVnZrcTh2NHFCZENiMUZOZVRRamtWRlE1Um9pbkpU?=
 =?gb2312?B?Q1I3b0dnbjBXSE1RU0JzY044ajQ5UExJbjJvazFPOXkyR2NpeXVJTFVrMDdV?=
 =?gb2312?B?ekc5UmExTGxZb1p2ZTExbHphZzgzaUlnWlYwNTcreG1GWW1QYm1LS1dvMEJB?=
 =?gb2312?B?YkpDT2tEV3daZGNua3ovdjVhRGFyU2xxQlVIWUFaMlg3MVd3b1FCMXlXbTZ3?=
 =?gb2312?B?SE9md1FjbDFoV1RFNlVKbDRobWFrVTkvbnhFQlhSSnVheEZqK0tqczAwNWNr?=
 =?gb2312?B?dnVQOEtXN3BibE5ORlMwUXo5Q3FRNU5BUmxKbklKZlNvSnYza0Mxdz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4001.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9da9c7-7baa-47f3-a815-08da4ec1ef08
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 11:26:47.1854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgImp7s13ikHdF6vrEawTQCZU2wC99P9p6dVXT8QBQJ4omepaMDYllVvX1RdZOPN4OcNCrUE7yedIn7RvAN3Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8657
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOo21MI1yNUgMDoxNw0KPiBUbzogV29sZnJh
bSBTYW5nIDx3c2FAa2VybmVsLm9yZz4NCj4gQ2M6IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5Abnhw
LmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT47
IGxhcnNAbWV0YWZvby5kZTsNCj4gbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgcG1lZXJ3QHBt
ZWVydy5uZXQ7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGlpbzogYWNjZWw6IG1tYTg0NTI6IHJlbW92ZSB0aGUgcmVzZXQgb3BlcmF0
aW9uIGR1cmluZw0KPiBkcml2ZXIgcHJvYmUNCj4gDQo+IE9uIFRodSwgMjQgRmViIDIwMjIgMTg6
MzM6MjYgKzAxMDANCj4gV29sZnJhbSBTYW5nIDx3c2FAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0K
PiA+ID4gPiBXb2xmcmFtIGlzIHRoZXJlIGEgc3RhbmRhcmQgd2F5IHRvIHdvcmsgYXJvdW5kIG1p
c3NpbmcgQUNLIGluDQo+ID4gPiA+IGNhc2VzIGxpa2UgdGhpcz8gIFdvdWxkIGp1c3QgaWdub3Jp
bmcgdGhlIHJldHVybiB2YWx1ZSBiZSBmaW5lIG9yDQo+ID4gPiA+IGFyZSB0aGVpciBpMmMgbWFz
dGVycyB0aGF0IHdpbGwgZ2V0IHN0dWNrIGlmIHRoZXkgZG9uJ3QgZ2V0IHRoZSBleHBlY3RlZCBh
Y2s/DQo+ID4NCj4gPiBEaWQgSSBnZXQgdGhpcyByaWdodDogdGhlIHJlc2V0IHByb2NlZHVyZXMg
dGVybWluYXRlcyB0aGUgQUNLIGFuZCBTVE9QPw0KPiA+IEFuZCB0aGUgY2xpZW50IGV4cGVjdHMg
YSBuZXcgU1RBUlQgY29uZGl0aW9uIGZvciBjb21tdW5pY2F0aW9uPw0KPiA+DQo+IA0KSGkNCg0K
SSB1c2UgYSBJMkMgbG9naWMgYW5hbHl6ZXIgYW5kIGZpbmQgdGhpcyByZXNldCBqdXN0IHRlcm1p
bmF0ZSBBQ0ssIGFuZCBJMkMgYnVzIGNvbnRyb2xsZXIgdGhlbiBkZXRlY3QgdGhpcyBOQUNLLCBh
bmQgZ2l2ZSBhIFNUT1AuIEFmdGVyIHRoYXQsIEkyQyBidXMgd29yayBub3JtYWwuDQpJZiBqdXN0
IGlnbm9yZSB0aGlzIHJldHVybiwgZXZlcnl0aGluZyBjb250aW51ZSB3aWxsIGJlIGZpbmUuIA0K
U2VlbXMgZm9yIHRoaXMgc2Vuc29yLCBhZnRlciB0aGUgcmVzZXQgYml0IGlzIHNldCwgaXQgd29y
a3MgaW1tZWRpYXRlbHksIHNvIHdpbGwgbm90IGdpdmUgQUNLLg0KDQpJIHdpbGwgc2VuZCBhIHYy
IHBhdGNoLCBqdXN0IGlnbm9yZSB0aGlzIHJldHVybiByYXRoZXIgdGhhbiByZW1vdmUgdGhlIHdo
b2xlIHJlc2V0IG9wZXJhdGlvbi4NCg0KQmVzdCBSZWdhcmRzDQpCb3VnaCBDaGVuDQoNCj4gQEJv
dWdoIENoZW4sDQo+IA0KPiBJJ20gYXNzdW1pbmcgdGhpcyBpcyBzdGlsbCBhbiBpc3N1ZSBmb3Ig
eW91PyAgSWYgc28gY2FuIHlvdSByZXBseSB0byBXb2xmcmFtIHNvIHdlDQo+IGNhbiBob3BlZnVs
bHkgbW92ZSB0aGlzIGZvcndhcmRzLg0KPiANCj4gRm91bmQgdGhpcyBiZWNhdXNlIGl0J3Mgc3Rp
bGwgbGlzdGVkIGFzIG5lZWRpbmcgYW4gYWN0aW9uIGluIHRoZSBJSU8gcGF0Y2h3b3JrLg0KPiAN
Cj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCg==
