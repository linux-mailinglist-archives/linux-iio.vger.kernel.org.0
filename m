Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BD166DA4A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 10:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjAQJsV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 04:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbjAQJsG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 04:48:06 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FAA9EFF;
        Tue, 17 Jan 2023 01:48:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhUItgCOsy+1H8rBesugsT/GpdGAn4Ks41s4fqUDy7BDTjrSjR8SggXydVgjfpic5KqHyZLigpmf8XGMbXpQ1daNZoHUVLO4bY8h1IEpAq8OpOMoG48TFtoexI8AWSUL+beX80h2Aw8qe/5snzTu7yTnljLeewe13sPIEmk1B6PmSosf9iXo9tTRc1Lry/V/ODFgPdyZMB0ghReURNliQe4MWjdJFioLDtpea8nGFxtWiY33PO19kXPa78g08a0T3SEVf8Q35y0DqEtY7RTwnfuB29W7kZXDrvmX1P06kKTg8cJM1KAB3emKMCpL4eOERsTxaFl0/7a5jEuzpA29Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y455CW6qvwcus2JZoIYl8wAhWy3ZJiiamzKrzTRY88w=;
 b=AWBHhnUY/FuTf4pGrxd/BoyqnWlG4NhBUKYVHHdjDApyDhBwtHJV6CG0zDIu+lmo3CvXk6N199Xmazq3NW9VSw+KFFlYBx9Nx81vt5yJ2plh3ipWSlpBagtIb2fWHQoeRNtdC3rydYxlUiqyHko8jaFSrhQ5m7uPZyBwdbDVs/qcIHIR7kUg50i0HjdHrCjDz8sEyLxcfwExy2Ku0RH5Fvu7HA2k0JxSf9wEqzhhLq5sX/oEmJBXwYoFAUD/4ngCVuU2ZnuktBsOTcXI/JU9G+k5D4OUJhUG0Z0PukNchvpofOW0X90zhJV5wynj5I9yTFOHWfQPpanl/G01UccQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y455CW6qvwcus2JZoIYl8wAhWy3ZJiiamzKrzTRY88w=;
 b=MUXnrf6VwPL37q5/psCTMbM/nfSssedr9ZEskushRuxtwXhhcgI+BQ2S/eohLCZOx/r3zKZb4LFhF/tfHYsrosOsjKyW1Ck6YklKJ14E09DcQbBtBgfu2AJP0ooppqdb0tpB+ytv8aJ/MIWOjBjMKLNeXRtOoUu8UVHM+LfuzRM=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DB9PR04MB8447.eurprd04.prod.outlook.com (2603:10a6:10:2be::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 09:48:02 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 09:48:01 +0000
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
Subject: RE: [PATCH v5 1/3] iio: adc: add imx93 adc support
Thread-Topic: [PATCH v5 1/3] iio: adc: add imx93 adc support
Thread-Index: AQHZH2iTq/b1eFNsV0CtngRQjYJffa6UiXSAgA3mzSA=
Date:   Tue, 17 Jan 2023 09:48:01 +0000
Message-ID: <DB7PR04MB4010D4F47BCD9E46740A9DBA90C69@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230103114359.2663262-1-haibo.chen@nxp.com>
        <20230103114359.2663262-2-haibo.chen@nxp.com>
 <20230108132137.1f965aa3@jic23-huawei>
In-Reply-To: <20230108132137.1f965aa3@jic23-huawei>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DB9PR04MB8447:EE_
x-ms-office365-filtering-correlation-id: c163510b-45d9-4e5a-0849-08daf86fec7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T6vdrMlYb7m3E4+JoOGu1L0HGkQsiuPl3nSPK3GU5qnP2uzTQugxmWmq+9MJmd0O4UAOAlzJsZAfc6QO039NiCKFAnwSaX65gr3AVCf2aHN9SBkqJE5hev362oz+BvfIdw1+HHu8tcPREWG5JFxaClyrPiT1lVRisXteBp37FYBtXz/+HxSyuLJln+cgKm+aE116qcbPV0T2wSVkuC0+NqzcqWKRgnvBpjmh13tG35zhI8Fee9/RTPa03lnn4me/jaLLs7+iVfmX+DUyQPs+qi5NGvqZSHTDrzxax9phLOf8YBi5nWwy55qgyYLzY/Kerm0xOGUb6tMh7u9IVI4mNJMB14C2+CEjYgGUfoZXVvTBAAmFbwzUE0pyNk5Cb1psuPni1GXkRF9yw+eWQ9nCdnpuoAd+KZzf2/17Cn0trpedkjMD5x9Qr7z8z2OCY1RXHnkd5vr2a2YztEorMzgzPHrQV9XJV56ZEjGzsIHDo+Kj1AnX1/FarlA1x24hp+GsMZ9Zmh+w/gpQFM/9Bkjbis2yXUvFozLQ7iYy4gXEtuSLKoaSX5RudlK2apF8ReltxqeAugJjcoBfS1E8m71GNDH3jchlcN8CkzBs6tmm0/2pYhKi1upDF5v4nsq47PROmOk1JaxVYDPR44l39V/Tj9TOqiTnoPhrh9Y/EsROzRVWCnoNx/fpkCzgQ9TR3s4Po5uj6XEjejes6Ks+EKJGdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199015)(83380400001)(55016003)(33656002)(122000001)(38100700002)(38070700005)(86362001)(8936002)(7416002)(8676002)(2906002)(5660300002)(6916009)(4326008)(64756008)(66476007)(76116006)(66446008)(52536014)(66556008)(66946007)(478600001)(9686003)(53546011)(186003)(26005)(6506007)(54906003)(316002)(71200400001)(7696005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MG9PazVteW5DL3E2WElUZ1pTdFBDbGtSYWRYbjd2MzJYWjEzRzl4MUpPTlFy?=
 =?gb2312?B?VXJ4dGY4N09EemlvL2s0NXQvNW1RbmhCV0dFVkQ5MExzMm5uT3MrRFVVM0Fh?=
 =?gb2312?B?QTBuSW4xeEZ6ajYrZTZVSFR0N3ZZcFdmTHlIVS82ZTRINHJiVkU0dUIrc1BE?=
 =?gb2312?B?NnY2Y0k2OXcwRXJqQzlBSE1IOGRjcnF6MFJOejFDU01zUWpVK3FjNlZ0elly?=
 =?gb2312?B?SW9vZjNEZnVNdFhkY2NYVVQzdExoVDRKTFhCSjNrM1Q2aFNOYnNWaGl2S3pJ?=
 =?gb2312?B?YUNwbUNhL3ZuKzlXZHd6Q0VhQUpSYzN3bndWVnJlWXFhMThDUW1hRXZtc3Zs?=
 =?gb2312?B?NG5COHNZTERzRVRNVitiRzJEalZJWnduK3AxbW5JSmZ5MVZlMy9PVUZSYmM1?=
 =?gb2312?B?WVBUY2JGcEdhU0hqbDVoRWpIWEMwOW5GWU5wak51U0ZpRUkyaE82N1dxVmZG?=
 =?gb2312?B?VVUva3ZXdVNOWWZ6UlNhbVh3Y252dFk3cWRaUzdqODUyUVV4MG53VVppckFa?=
 =?gb2312?B?RzYyYmR4ZkQ0alhjTm04bmlseHMreEJqY1BQK1N3OVgwcDR1QUhLcHFJUEJX?=
 =?gb2312?B?dzJIbC9CUDJlcmFtMlJ2Z1FRbHRRS0dScENwSm0wUFJDME1KVlg3cHk5RkE4?=
 =?gb2312?B?L2dUOStCQW9wYkt4Nm0xeTROc2N0bUl5U1l2ZlNFSmgxZTBMZmtpcGhwZ3kv?=
 =?gb2312?B?YTZzaDljdnJKRjMzM29pbURlVnBpNHZtTENMbldRNWgvdkhGN1VwMTFHenlk?=
 =?gb2312?B?dnZVb2VUb3EvUExIZXJIeG5BMzRGRSt2OW9jVjh2TmpHSUtUTE5vS2dtN1Zh?=
 =?gb2312?B?K3MzaUVkU2lMMDNIRE1rUS9UL0RsOUQxVFdMM3pRV1lyK3Y1QVJITkZNUkVR?=
 =?gb2312?B?UzR5Qm9qblpaWWNxdGpXM3FvNEdSbk9kVG5MaWVUZzZLSzlncTM1NmR2YXg3?=
 =?gb2312?B?d0Jzc2hsbGFWZHAxaisrVER1bjdNWXZORzBiRFIvL0NFa0NpbVIrT1RHTkFE?=
 =?gb2312?B?TVJtVEVXMnlJci9NdzVtV2ljZUFBSU4zVjR2ZDRkdDdBZ2dqalkxRXF5RFlM?=
 =?gb2312?B?U0N2cXNXNjl1UWJXZGs1WTRzU2pyUzIxOW9nc2U0YUM1VjhaSGZWSFBrbjhu?=
 =?gb2312?B?OUVJV1B6YTRzemN6czlsL3FZUFdDd3FPckptejBCSTFtanZFMi8wazF1Q3VN?=
 =?gb2312?B?ak4wbFp5aUo0T1IyUHJLVGZveEowUjh1eVJ6dzc0clMwbGI2Ylp5YXk2UHVr?=
 =?gb2312?B?WC9KKzRSNlc3TkEyeDVqaEdPYkdhQmlrRzZuMm43a0hjblY2YTN3YzdPZjUz?=
 =?gb2312?B?dThkRnNNV3FMWFBMcnJheHplMUpMYWdyWWh3clZzR3lMMHVINGxKdUxlQ1Vo?=
 =?gb2312?B?VVpIazE2Mys0amdkVzlPZEtKQjRCVW1kSG5vWlZ5bXVJWjNKYll5RkRlOXp0?=
 =?gb2312?B?ODFaU1NxemRPc1FhRDQ4Lzg1SUtSOXhwSFlhNUlhaC9vY0NuRHh4WXFpcm1X?=
 =?gb2312?B?bWZ0WmZUTFFJbU5RMUlwbkJvTGJpUGlibG9tc3FiWk8xZ1o2blAzOUtaMlVB?=
 =?gb2312?B?SGFjM0RyQVJYdUZnL3ZGMTNYcmozMkxGeVp4NFpjSnl3MWhTNVRMZEdhZXVC?=
 =?gb2312?B?dmp6V2JSY0c2cHNMdzNhSE5Jay84b1RlTUU3Z2ZZYkp3RU0yOERKMHRxQnVS?=
 =?gb2312?B?V1lCckhuTElKTXplSnJMTVNOUnVBeEh1QlhCb2YyL2xMUEVWdkxrZ25aV3ow?=
 =?gb2312?B?OThBL1lHZDBmTzZXSjZqaThib2REUGlFNU84K2VVTnJLS3NPV29sUm9MMG5n?=
 =?gb2312?B?TjdzT2hrbGRNN0hzMElJTXhFbHkvbEZ1MW5jNkJsMFNzRWhMeHZrWU4xQ0lI?=
 =?gb2312?B?S2QzRFFIZTNiL1BqcVVwOXM1aXE3MDZ4V1czd0wvOTlPUlFlbVY4dGNqRGQw?=
 =?gb2312?B?bjNjMWlRWllEOWN3THp3bTRHcHRMYU42UTVLRXpZZTdJTDRBTnVjMnBwL1Yw?=
 =?gb2312?B?M1RNVm9QdHd4aDBSZ0kwcVQ2VXVwUG1JRGg5SlpDSWoxM0tvRXcyU0ZOV1Bs?=
 =?gb2312?B?RVRUaW1CbDFYU3htT2ZBYS9mbjlhMEo3T1VQb1hNS1BuaG9Zb2pGY2s0MmIv?=
 =?gb2312?Q?BOfq6t5wYgdAv0MxmUqpL4PEe?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c163510b-45d9-4e5a-0849-08daf86fec7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 09:48:01.8422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7HFsQiDejsay6tCOmK9n5YcvryvFT/TBH727x6IjTGaas6GMIki14FXl5FLxhCIgWhh/C40iRBU778KhSPKBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8447
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
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOox1MI4yNUgMjE6MjINCj4gVG86IEJvdWdo
IENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IGxhcnNAbWV0YWZvby5kZTsgcm9iaCtk
dEBrZXJuZWwub3JnOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsNCj4gbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxLzNdIGlpbzogYWRjOiBhZGQgaW14OTMg
YWRjIHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgIDMgSmFuIDIwMjMgMTk6NDM6NTYgKzA4MDANCj4g
aGFpYm8uY2hlbkBueHAuY29tIHdyb3RlOg0KPiANCj4gPiBGcm9tOiBIYWlibyBDaGVuIDxoYWli
by5jaGVuQG54cC5jb20+DQo+ID4NCj4gPiBUaGUgQURDIGluIGkubXg5MyBpcyBhIHRvdGFsIG5l
dyBBREMgSVAsIGFkZCBhIGRyaXZlciB0byBzdXBwb3J0IHRoaXMNCj4gPiBBREMuDQo+ID4NCj4g
PiBDdXJyZW50bHksIG9ubHkgc3VwcG9ydCBvbmUgc2hvdCBub3JtYWwgY29udmVyc2lvbiB0cmln
Z2VyZWQgYnkNCj4gPiBzb2Z0d2FyZS4gRm9yIG90aGVyIG1vZGUsIHdpbGwgYWRkIGluIGZ1dHVy
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNv
bT4NCj4gSGkgSGFpYm8sDQo+IA0KPiBJJ20gc3RpbGwgbm90IHN1cmUgYWJvdXQgdGhlIHBvd2Vy
IGhhbmRsaW5nIGluIHJlbW92ZS4gT25lIG90aGVyIG1pbm9yDQo+IGNvbW1lbnQgaW5saW5lIHRo
YXQgd291bGQgYmUgZ29vZCB0byBjbGVhbiB1cCBmb3IgdjYuDQo+IA0KPiBUaGFua3MsDQo+IA0K
PiBKb25hdGhhbg0KPiANCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAw
MDAwMDAwMC4uMGM5OGRlNDM4OTE5DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZl
cnMvaWlvL2FkYy9pbXg5M19hZGMuYw0KPiANCj4gLi4uDQo+IA0KPiA+ICsNCj4gPiArc3RhdGlj
IGludCBpbXg5M19hZGNfY2FsaWJyYXRpb24oc3RydWN0IGlteDkzX2FkYyAqYWRjKSB7DQo+ID4g
Kwl1MzIgbWNyLCBtc3I7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCS8qIG1ha2Ugc3Vy
ZSBBREMgaW4gcG93ZXIgZG93biBtb2RlICovDQo+ID4gKwlpbXg5M19hZGNfcG93ZXJfZG93bihh
ZGMpOw0KPiA+ICsNCj4gPiArCS8qIGNvbmZpZyBTQVIgY29udHJvbGxlciBvcGVyYXRpbmcgY2xv
Y2sgKi8NCj4gPiArCW1jciA9IHJlYWRsKGFkYy0+cmVncyArIElNWDkzX0FEQ19NQ1IpOw0KPiA+
ICsJbWNyICY9IH5GSUVMRF9QUkVQKElNWDkzX0FEQ19NQ1JfQURDTEtTRV9NQVNLLCAxKTsNCj4g
PiArCXdyaXRlbChtY3IsIGFkYy0+cmVncyArIElNWDkzX0FEQ19NQ1IpOw0KPiA+ICsNCj4gPiAr
CWlteDkzX2FkY19wb3dlcl91cChhZGMpOw0KPiANCj4gSSB0aGluayB0aGlzIGZ1bmN0aW9uIHNo
b3VsZCBiZSBzaWRlIGVmZmVjdCBmcmVlIG9uIGVycm9yIHRvIGFpZCBlYXN5IHJldmlld2luZyAv
DQo+IGNvZGUgbW9kdWxhcml0eS4gVGh1cyBpZiBhbnl0aGluZyBhZnRlciB0aGlzIHBvaW50IGZh
aWxzLCB0aGUgZGV2aWNlIHNob3VsZCBiZQ0KPiBkZWxpYmVyYXRlbHkgcG93ZXJlZCBkb3duIGFn
YWluIHRvIHJlbW92ZSB0aGF0IHNpZGUgZWZmZWN0Lg0KPiANCj4gPiArDQo+ID4gKwkvKg0KPiA+
ICsJICogVE9ETzogd2UgdXNlIHRoZSBkZWZhdWx0IFRTQU1QL05SU01QTC9BVkdFTiBpbiBNQ1Is
DQo+ID4gKwkgKiBjYW4gYWRkIHRoZSBzZXR0aW5nIG9mIHRoZXNlIGJpdCBpZiBuZWVkIGluIGZ1
dHVyZS4NCj4gPiArCSAqLw0KPiA+ICsNCj4gPiArCS8qIHJ1biBjYWxpYnJhdGlvbiAqLw0KPiA+
ICsJbWNyID0gcmVhZGwoYWRjLT5yZWdzICsgSU1YOTNfQURDX01DUik7DQo+ID4gKwltY3IgfD0g
RklFTERfUFJFUChJTVg5M19BRENfTUNSX0NBTFNUQVJUX01BU0ssIDEpOw0KPiA+ICsJd3JpdGVs
KG1jciwgYWRjLT5yZWdzICsgSU1YOTNfQURDX01DUik7DQo+ID4gKw0KPiA+ICsJLyogd2FpdCBj
YWxpYnJhdGlvbiB0byBiZSBmaW5pc2hlZCAqLw0KPiA+ICsJcmV0ID0gcmVhZGxfcG9sbF90aW1l
b3V0KGFkYy0+cmVncyArIElNWDkzX0FEQ19NU1IsIG1zciwNCj4gPiArCQkhKG1zciAmIElNWDkz
X0FEQ19NU1JfQ0FMQlVTWV9NQVNLKSwgMTAwMCwgMjAwMDAwMCk7DQo+ID4gKwlpZiAocmV0ID09
IC1FVElNRURPVVQpIHsNCj4gPiArCQlkZXZfd2FybihhZGMtPmRldiwgIkFEQyBkbyBub3QgZmlu
aXNoIGNhbGlicmF0aW9uIGluIDEgbWluIVxuIik7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gKwkvKiBjaGVjayB3aGV0aGVyIGNhbGJyYXRpb24gaXMgc3VjY2VzcyBv
ciBub3QgKi8NCj4gPiArCW1zciA9IHJlYWRsKGFkYy0+cmVncyArIElNWDkzX0FEQ19NU1IpOw0K
PiA+ICsJaWYgKG1zciAmIElNWDkzX0FEQ19NU1JfQ0FMRkFJTF9NQVNLKSB7DQo+ID4gKwkJZGV2
X3dhcm4oYWRjLT5kZXYsICJBREMgY2FsaWJyYXRpb24gZmFpbGVkIVxuIik7DQo+ID4gKwkJcmV0
dXJuIC1FQUdBSU47DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4g
PiArDQo+IA0KPiAuLi4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgaW14OTNfYWRjX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiArCXN0cnVjdCBpbXg5M19hZGMgKmFkYzsN
Cj4gPiArCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXY7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlpbmRpb19kZXYg
PSBkZXZtX2lpb19kZXZpY2VfYWxsb2MoZGV2LCBzaXplb2YoKmFkYykpOw0KPiA+ICsJaWYgKCFp
bmRpb19kZXYpDQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCAtRU5PTUVNLA0KPiA+
ICsJCQkJICAgICAiRmFpbGVkIGFsbG9jYXRpbmcgaWlvIGRldmljZVxuIik7DQo+ID4gKw0KPiA+
ICsJYWRjID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiArCWFkYy0+ZGV2ID0gZGV2Ow0KPiA+
ICsNCj4gPiArCW11dGV4X2luaXQoJmFkYy0+bG9jayk7DQo+ID4gKwlhZGMtPnJlZ3MgPSBkZXZt
X3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQo+ID4gKwlpZiAoSVNfRVJSKGFk
Yy0+cmVncykpDQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGFkYy0+
cmVncyksDQo+ID4gKwkJCQkgICAgICJGYWlsZWQgZ2V0aW5nIGlvcmVtYXAgcmVzb3VyY2VcbiIp
Ow0KPiA+ICsNCj4gPiArCS8qIFRoZSB0aGlyZCBpcnEgaXMgZm9yIEFEQyBjb252ZXJzaW9uIHVz
YWdlICovDQo+ID4gKwlhZGMtPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMik7DQo+ID4g
KwlpZiAoYWRjLT5pcnEgPCAwKQ0KPiA+ICsJCXJldHVybiBhZGMtPmlycTsNCj4gPiArDQo+ID4g
KwlhZGMtPmlwZ19jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCAiaXBnIik7DQo+ID4gKwlpZiAoSVNf
RVJSKGFkYy0+aXBnX2NsaykpDQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJf
RVJSKGFkYy0+aXBnX2NsayksDQo+ID4gKwkJCQkgICAgICJGYWlsZWQgZ2V0dGluZyBjbG9jay5c
biIpOw0KPiA+ICsNCj4gPiArCWFkYy0+dnJlZiA9IGRldm1fcmVndWxhdG9yX2dldChkZXYsICJ2
cmVmIik7DQo+ID4gKwlpZiAoSVNfRVJSKGFkYy0+dnJlZikpDQo+ID4gKwkJcmV0dXJuIGRldl9l
cnJfcHJvYmUoZGV2LCBQVFJfRVJSKGFkYy0+dnJlZiksDQo+ID4gKwkJCQkgICAgICJGYWlsZWQg
Z2V0dGluZyByZWZlcmVuY2Ugdm9sdGFnZS5cbiIpOw0KPiA+ICsNCj4gPiArCXJldCA9IHJlZ3Vs
YXRvcl9lbmFibGUoYWRjLT52cmVmKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIGRl
dl9lcnJfcHJvYmUoZGV2LCByZXQsDQo+ID4gKwkJCQkgICAgICJGYWlsZWQgdG8gZW5hYmxlIHJl
ZmVyZW5jZSB2b2x0YWdlLlxuIik7DQo+ID4gKw0KPiA+ICsJcGxhdGZvcm1fc2V0X2RydmRhdGEo
cGRldiwgaW5kaW9fZGV2KTsNCj4gPiArDQo+ID4gKwlpbml0X2NvbXBsZXRpb24oJmFkYy0+Y29t
cGxldGlvbik7DQo+ID4gKw0KPiA+ICsJaW5kaW9fZGV2LT5uYW1lID0gImlteDkzLWFkYyI7DQo+
ID4gKwlpbmRpb19kZXYtPmluZm8gPSAmaW14OTNfYWRjX2lpb19pbmZvOw0KPiA+ICsJaW5kaW9f
ZGV2LT5tb2RlcyA9IElORElPX0RJUkVDVF9NT0RFOw0KPiA+ICsJaW5kaW9fZGV2LT5jaGFubmVs
cyA9IGlteDkzX2FkY19paW9fY2hhbm5lbHM7DQo+ID4gKwlpbmRpb19kZXYtPm51bV9jaGFubmVs
cyA9IEFSUkFZX1NJWkUoaW14OTNfYWRjX2lpb19jaGFubmVscyk7DQo+ID4gKw0KPiA+ICsJcmV0
ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGFkYy0+aXBnX2Nsayk7DQo+ID4gKwlpZiAocmV0KSB7DQo+
ID4gKwkJZGV2X2Vycl9wcm9iZShkZXYsIHJldCwNCj4gPiArCQkJICAgICAgIkZhaWxlZCB0byBl
bmFibGUgaXBnIGNsb2NrLlxuIik7DQo+ID4gKwkJZ290byBlcnJvcl9yZWd1bGF0b3JfZGlzYWJs
ZTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXQgPSByZXF1ZXN0X2lycShhZGMtPmlycSwgaW14
OTNfYWRjX2lzciwgMCwgSU1YOTNfQURDX0RSSVZFUl9OQU1FLA0KPiBhZGMpOw0KPiA+ICsJaWYg
KHJldCA8IDApIHsNCj4gPiArCQlkZXZfZXJyX3Byb2JlKGRldiwgcmV0LA0KPiA+ICsJCQkgICAg
ICAiRmFpbGVkIHJlcXVlc3RpbmcgaXJxLCBpcnEgPSAlZFxuIiwgYWRjLT5pcnEpOw0KPiA+ICsJ
CWdvdG8gZXJyb3JfaXBnX2Nsa19kaXNhYmxlOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldCA9
IGlteDkzX2FkY19jYWxpYnJhdGlvbihhZGMpOw0KPiA+ICsJaWYgKHJldCA8IDApDQo+IA0KPiBB
cyBhYm92ZSwgSSdkIGV4cGVjdCB0aGUgZGV2aWNlIHRvIGJlIHBvd2VyZWQgZG93biBpZiB0aGlz
IGZ1bmN0aW9uIGZhaWxzIGFuZA0KPiBoZW5jZSBuZWVkIGFuIGFkZGl0aW9uYWwgZXJyb3IgbGFi
ZWwuDQoNClllcywgc2hvdWxkIGFkZCBhIG5ldyBlcnJvciBsYWJlbC4NCg0KPiANCj4gPiArCQln
b3RvIGVycm9yX2ZyZWVfYWRjX2lycTsNCj4gPiArDQo+ID4gKwlpbXg5M19hZGNfY29uZmlnX2Fk
X2NsayhhZGMpOw0KPiA+ICsNCj4gPiArCXJldCA9IGlpb19kZXZpY2VfcmVnaXN0ZXIoaW5kaW9f
ZGV2KTsNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyX3Byb2JlKGRldiwgcmV0LA0K
PiA+ICsJCQkgICAgICAiRmFpbGVkIHRvIHJlZ2lzdGVyIHRoaXMgaWlvIGRldmljZS5cbiIpOw0K
PiA+ICsJCWdvdG8gZXJyb3JfZnJlZV9hZGNfaXJxOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXBt
X3J1bnRpbWVfc2V0X2FjdGl2ZShkZXYpOw0KPiA+ICsJcG1fcnVudGltZV9zZXRfYXV0b3N1c3Bl
bmRfZGVsYXkoZGV2LCA1MCk7DQo+ID4gKwlwbV9ydW50aW1lX3VzZV9hdXRvc3VzcGVuZChkZXYp
Ow0KPiA+ICsJcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsN
Cj4gPiArDQo+ID4gK2Vycm9yX2ZyZWVfYWRjX2lycToNCj4gPiArCWlteDkzX2FkY19wb3dlcl9k
b3duKGFkYyk7DQo+ID4gKwlmcmVlX2lycShhZGMtPmlycSwgYWRjKTsNCj4gPiArZXJyb3JfaXBn
X2Nsa19kaXNhYmxlOg0KPiA+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGFkYy0+aXBnX2Nsayk7
DQo+ID4gK2Vycm9yX3JlZ3VsYXRvcl9kaXNhYmxlOg0KPiA+ICsJcmVndWxhdG9yX2Rpc2FibGUo
YWRjLT52cmVmKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+
ICtzdGF0aWMgaW50IGlteDkzX2FkY19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikgew0KPiA+ICsJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IHBsYXRmb3JtX2dldF9kcnZk
YXRhKHBkZXYpOw0KPiA+ICsJc3RydWN0IGlteDkzX2FkYyAqYWRjID0gaWlvX3ByaXYoaW5kaW9f
ZGV2KTsNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IGFkYy0+ZGV2Ow0KPiANCj4gQXMgcGVy
IHJlcGx5IHRvIGNvdmVyIGxldHRlciBJIGRvbid0IHVuZGVyc3RhbmQgbG9naWMgYnkgd2hpY2gg
d2UgYXJlIGRlZmluaXRlbHkNCj4gcnVudGltZSByZXN1bWVkIGF0IHRoaXMgc3RhZ2UuDQo+IA0K
PiA+ICsNCj4gPiArCXBtX3J1bnRpbWVfZGlzYWJsZShkZXYpOw0KPiA+ICsJcG1fcnVudGltZV9k
b250X3VzZV9hdXRvc3VzcGVuZChkZXYpOw0KPiA+ICsJcG1fcnVudGltZV9wdXRfbm9pZGxlKGRl
dik7DQo+IA0KPiBUaGlzIGlzIG5vdCBiYWxhbmNlZCB3aXRoIGEgcG1fcnVudGltZV9nZXQqIHNv
IEkgdGhpbmsgd2UgdW5kZXJmbG93ICh3aGljaCBpcw0KPiBwcm90ZWN0ZWQgYWdhaW5zdCBpbiBy
dW50aW1lIHBtIHJlZiBjb3VudGluZyBidXQgbm90IGEgbmljZSB0aGluZyB0byBkbw0KPiBkZWxp
YmVyYXRlbHkpLg0KDQpPaCwgeWVzLCBzZWVtcyBzdGlsbCBuZWVkIHRvIGNhbGwgcG1fcnVudGlt
ZV9nZXRfc3luYygpIGV2ZW4gd2Ugc3RpbGwgaW4gcnVudGltZSByZXN1bWUgc3RhdGUuDQoNCkJl
c3QgUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gPiArCWlpb19kZXZpY2VfdW5yZWdpc3Rlcihp
bmRpb19kZXYpOw0KPiA+ICsJaW14OTNfYWRjX3Bvd2VyX2Rvd24oYWRjKTsNCj4gPiArCWZyZWVf
aXJxKGFkYy0+aXJxLCBhZGMpOw0KPiA+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGFkYy0+aXBn
X2Nsayk7DQo+ID4gKwlyZWd1bGF0b3JfZGlzYWJsZShhZGMtPnZyZWYpOw0KPiA+ICsNCj4gPiAr
CXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KDQo=
