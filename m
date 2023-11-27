Return-Path: <linux-iio+bounces-416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C162D7F979B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 03:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528F4B20A48
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 02:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DE415CF;
	Mon, 27 Nov 2023 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GosD5zab"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808C8A5
	for <linux-iio@vger.kernel.org>; Sun, 26 Nov 2023 18:47:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfJHuPLKUXR4x9INlHPAxJJspeH8G757wDJiOiX4nASG5dDPGOXUB2bpUYGUrUpkeXdDcd7JIr8IIyhY01UxaPM9aeMw4H9KJ4Zmt1Pt3lcQ8fN3zsIIzcxmIGJxiZ99q+iTfpik86S7DTslkFdU81j4jB80VvCb3pv+9JVooKGVgSlJvjlse3jgA0HTzKdM+k/pqEq1WUj/HuMDeOGO8DLWhDoWD3HSE7KnWCPsGZ19yFdIlIKTE82o1ApKGucjZZECCN5A7oGMeto5FVU7KoN9sEfKjXz75VQCkm/smSOtViXa/9spv4It4ueAWUaA2924gJt0w2KxhOD93eV7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLsCv22DUeoxrJzYVPhXIZSLuB305aJHESXQOU0zgNE=;
 b=M8CLY+aQ0Vi5EA+0YCWAQIT8v42RFc/DmNLjiLBF1Fcc/89i0FOrc+E3FGiGqgaMkt0FMPM9zYjhhSZf/sCwKdlG/dMSoLgCFTZDrUZaCM7jAb4j79SWrm+Q+KwPuNTXDeZV5hitV0M4TNQsyi5LvRwspVA1nyng0BeYxfO0zeH15wZX3W/VZn67PTIolwgklAPAaoTQqPt0DDnZAAXbRb/HHKAC9Apoer3pnHw8vhROYluB0zDlblo0H4vQOQc2W3Ua8deSiFomGfCs6vMBnq1EcBxcNea9478CsHdcic1uAECO7GQOH2W4aERqibDeECaVHQHzAmsbXAMgSKrjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLsCv22DUeoxrJzYVPhXIZSLuB305aJHESXQOU0zgNE=;
 b=GosD5zabe2loI9wI+j2hN1CcfVeejodClRkKCXa7dZd7wRgf/D6E0wMigTUaO3MWGcU5FLbYSzAtkVlMznRFGXVrVHBnPFtci6HCR4L5vuRIWJnRzRMWSCj/0pV5/qHJDms4XUVK0/3y1MNgmEpDc2FD8YDnyuo8KmTNbxVlTLM=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DB9PR04MB8186.eurprd04.prod.outlook.com (2603:10a6:10:25f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.16; Mon, 27 Nov 2023 02:47:31 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::c09:60ad:6ac5:d57f]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::c09:60ad:6ac5:d57f%4]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 02:47:31 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: imx93: add four channels for imx93 adc
Thread-Topic: [PATCH] iio: adc: imx93: add four channels for imx93 adc
Thread-Index: AQHaGFs8x9UZm3qCAEiN4Q2zzUGOo7CM02YAgACzntA=
Date: Mon, 27 Nov 2023 02:47:31 +0000
Message-ID:
 <DB7PR04MB401023D016E11C44699310D090BDA@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20231116071026.611269-1-haibo.chen@nxp.com>
 <20231126160312.2ef8a307@jic23-huawei>
In-Reply-To: <20231126160312.2ef8a307@jic23-huawei>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DB9PR04MB8186:EE_
x-ms-office365-filtering-correlation-id: c93cac4c-c2f6-431d-933c-08dbeef3339a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2Js73a4dPPeBeFBcCk48h+bpCBw2hFyrYQzF3JsF/ayZPNKHwy6HsFN81z2t/PMM73/skYSzEKbmVDnR78dtHLEnHwofeWgPngcnpcX/EWUuVuiMaUr5V15u5g+yCCEm0OjbyEk9RjRdBv56oMDyr/PoG8v0dYQz18CB7vvSgK8ffZIcpN1JAcdkWKhj1gCr+duQgYzHeqvxeg2q+/MRokmgksPogcFGklfv0ucO0exujr+IEWoGWo/ffHe8pJJqWnI9o9NJKfjrpuRi9ULlp4X4xbXMMF2mhI9VLIQj3A9uDzTa3/Cy0fiAj9mJY4ji/afWFXpus1U6XiXszdGI9qLMZwTp6SGTHE9dbhG2zoyAZEfGqQPH8lguEojMQwbDYK8mquvNoDhNXgjYm8r6oJAIySd+VI4v6+hX/Hv/OfFMNsrc0lWXdJrD1RUgyCH5CznfaZWQaAGHSm/aA0e1lkX2++FIbbfTeyzs9fdfexKen/TVteN2NDlk8ikT4352TUHOvYxrRpiniKsR7qnl2P22Zwa2W/fjvE/CCKcNFbLs5k+clN6gxscdy3NrbJCdsKMkh/J63R0CJkQcT+rOieZ6WAOnffl3lOzvuBoudopIJrPHbyJSujKvdQtajdpK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(55016003)(26005)(478600001)(6506007)(71200400001)(7696005)(9686003)(53546011)(38100700002)(38070700009)(122000001)(86362001)(33656002)(41300700001)(66946007)(5660300002)(76116006)(64756008)(66446008)(66556008)(54906003)(6916009)(66476007)(83380400001)(2906002)(316002)(52536014)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?STZyZUxMZ0xNbnJJV0xkSTgwdzRVYjRPU1dGSWExUXo1aWtyTHVCRytTQUtM?=
 =?gb2312?B?UldTVEF3N2Z3bEVreFRpUS8xM0E4VVlTa2pwUWFGQTUzb04yYkVaSDZxeU5B?=
 =?gb2312?B?SXkrdVRXQ2FlZ28rdlRSU1BOM05WN29JSERFM2tmU05uMlpjTlhjZS81Z2Jx?=
 =?gb2312?B?a2hkMWtUdkVFNzAvZDgvald6NWFydVV3aHQzRThkVTBHWmIvT3ltOFZxTkpl?=
 =?gb2312?B?QlJQT1llalNsODMrZWRPN290cFBBWjQ5OUwyMlJxQmloUkNuWnAwMTdoTU9x?=
 =?gb2312?B?cTVMUTAyNGV4Nk9aL3BpajRNRkpsOTZuYUd5RnQ2dHBueEJMdllPTkVXNkJT?=
 =?gb2312?B?dGFMQklMNStqYjFOa0R0Z2F6VmJWK2I0cEFxK2dTTmdoWGZyUVNsSElqVmEz?=
 =?gb2312?B?a0lyUjhCYWpsbmMwZnpGTS9UUkwyVHJLdFJsU0wrazBSL2M2STI1dVkvQmZT?=
 =?gb2312?B?cXEvMEgyOWhSemFYUmlOc2xFWEwwWTI1bVl2M3RNeGZpYjZqUUw5TjI4dzBw?=
 =?gb2312?B?OWNtWmlxTDU5clBmTG9Ja3ZjdmJ0TU1IYVZ3QkN1a0VTSTg0Y1BtOWY5VnVi?=
 =?gb2312?B?bEN5VEd3NlNraTNQR1pZT2x3bURha29jbFdkQVYyRXA4T3RKcjB1eHRjTGly?=
 =?gb2312?B?VFplZThRRmhLcVRjcGhlck9hdzhMQXFVM1pDVm1oNnBDK1pkVVZqbEF5bmVG?=
 =?gb2312?B?YXR2NzJYbWZZeVA0SEJsYlVMaTdyUHQ0dWYzKzVEMmdNNnFRL21keXNhTDBw?=
 =?gb2312?B?RDE1SHhIVGxiWXQ0UDlYREZVWG80L091TUg4bjA1RHh4VDZIOEh1azE0TTVZ?=
 =?gb2312?B?SnNkRVhzWExYS29jNUlRY0VmZ1lLU0d3VmFjS2tUbEdlWjJLbm9KL2NuVUhV?=
 =?gb2312?B?Y0R4SW1yRjBSUXRvenlTY3FETmV0MStxRlg5KzNwdHZTQmg2eGdDb0lGdHNu?=
 =?gb2312?B?bkpGTysvOTZmRytwR0lOUkEvN1dRVDdwc044VEVoSHpLVHBudkVVSjd1Unk1?=
 =?gb2312?B?d1c2S1ZzYk0rOTBGSWVGVjhDSVV0Y09VOFpwS1dmeE1Eay9nTWpwa0JXZjFH?=
 =?gb2312?B?c0ZlTDI0Z0tVREsySnMvQm43OENRWTA3YmdBUHF6dzhNV0lRT216V0w1NDBX?=
 =?gb2312?B?RmFzU0Fhd1VNWGZFWGRpQXBiSW0zQkNTWDVrbzNXM2MvMEo2d01veUwreGwv?=
 =?gb2312?B?bG1MYnJ4Y25zQzB1UVBvZXVZb3o1cks1QTBJWXFURC9qcHdUekNnTnYrUFg4?=
 =?gb2312?B?OUlJTnp6bVp6ZGdLY0EvV3BEL0JhYXdaalFCSnBPS0d4QlZMNDFWL25QT2xu?=
 =?gb2312?B?RHZ6elNFVEdlVzBKRllnS3VTMTJRZFJSOUxtb3krc3F6TExMWlZSamp3bHg3?=
 =?gb2312?B?UlFHakJVcE1QS3lGMmtHV3NQVmt5NVp6UkszUEgrMEV0ME5IVmQ3Nnl5enhR?=
 =?gb2312?B?STlUVlU3T0FxSERITWhoV2xGSGUvc1pPMU4zR1ppYVJ6VmdBc2xXcE4rMlFK?=
 =?gb2312?B?Qm95TXB0OXJER2FiaHNxaGZROTZ5UVp4RHNVQWxIbGl3Q3dEWHMrcjdqL0pN?=
 =?gb2312?B?WFRTYm9QS3k2NEFWejcyK010ampDUzlnZnBTbUdma0JQaE9OMlpIN3pHc1R2?=
 =?gb2312?B?Njhpd0l6eFhNckdLS0I0SC9lVkorRzRDL1piRzZMQytCclFwYTFXbkhjNTAw?=
 =?gb2312?B?K0I1TVdtSmVHaDFhbmswaElnN0ZmellPalhCV2dLVmNQMTZtQzA2SEFOZmY5?=
 =?gb2312?B?T2hiTmxZUUd1QXJDZjI4eWlYMzU4Yk1MaEt3QXdvQ3lnd2VsRUIyQXY1ejFa?=
 =?gb2312?B?Zk5IMUtQN1dsQW5QRGJ2OGNITWdXZWllM1JLVDUyMXhXZjRvUi81MXhycmhi?=
 =?gb2312?B?aFFBZzV1NmVBcUdnVGV5bmxJYnJhdlBPQ0xScVZtcmRVVzFPQVhHNTVHRXh0?=
 =?gb2312?B?YlJnUjJHeGRsWjM3S0xqSXp0SXZVQjVPWkFOcDJ6N25zU1h5S2E1MEJNeFZn?=
 =?gb2312?B?SW9LTjMwYnliRVUxZDFrckFJTm1lUzVRTzdHUVFudFZ2Y0twN0F1U2xOL29Y?=
 =?gb2312?B?d2JmRkxJeWlQWm5HamtkeVF1dmtQNElLRzIrd2NwNlMrZ0NtK2drODJRbzIx?=
 =?gb2312?Q?z290=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93cac4c-c2f6-431d-933c-08dbeef3339a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 02:47:31.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iV8Z6ySDaUGImJbLFTTYossrh4XJK4wBvXbsQuEjIcv92bxxc8FSZHdIGWy2N49Jm5fSMCaIRvZfd0Vt3IoqrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8186

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOoxMdTCMjfI1SAwOjAzDQo+IFRvOiBCb3Vn
aCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiBsYXJzQG1ldGFmb28uZGU7IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBu
eHAuY29tPjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBpaW86IGFkYzogaW14OTM6IGFkZCBmb3VyIGNoYW5uZWxzIGZvciBpbXg5MyBhZGMNCj4gDQo+
IE9uIFRodSwgMTYgTm92IDIwMjMgMTU6MTA6MjYgKzA4MDANCj4gaGFpYm8uY2hlbkBueHAuY29t
IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+
ID4NCj4gPiBBY2NvcmRpbmcgdG8gdGhlIHNwZWMsIHRoaXMgQURDIHRvdGFsbHkgc3VwcG9ydCA4
IGNoYW5uZWxzLg0KPiA+IGkuTVg5MyBjb250YWluIHRoaXMgQURDIHdpdGggNCBjaGFubmVscyBj
b25uZWN0ZWQgdG8gcGlucyBpbiB0aGUNCj4gPiBwYWNrYWdlLiBpLk1YOTUgY29udGFpbiB0aGlz
IEFEQyB3aXRoIDggY2hhbm5lbHMgY29ubmVjdGVkIHRvIHBpbnMgaW4NCj4gPiB0aGUgcGFja2Fn
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNv
bT4NCj4gU2hvdWxkIEkgdHJlYXQgdGhpcyBhcyBhIGZpeD8NCj4gDQo+IElmIHNvIGNvdWxkIHlv
dSByZXBseSB3aXRoIGEgZml4ZXMgdGFnIHBsZWFzZQ0KDQpZZXMsIHBsZWFzZSBoZWxwIGFkZDoN
CkZpeGVzOiA3ZDAyMjk2YWM4YjggKCJpaW86IGFkYzogYWRkIGlteDkzIGFkYyBzdXBwb3J0IikN
Cg0KVGhhbmtzDQpIYWlibyBDaGVuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiAN
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9paW8vYWRjL2lteDkzX2FkYy5jIHwgNCArKysrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby9hZGMvaW14OTNfYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvaW14OTNfYWRjLmMN
Cj4gPiBpbmRleCA5YmIxZTRiYTFhZWUuLjRjY2Y0ODE5ZjFmMSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2lpby9hZGMvaW14OTNfYWRjLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9hZGMvaW14
OTNfYWRjLmMNCj4gPiBAQCAtOTMsNiArOTMsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9f
Y2hhbl9zcGVjDQo+IGlteDkzX2FkY19paW9fY2hhbm5lbHNbXSA9IHsNCj4gPiAgCUlNWDkzX0FE
Q19DSEFOKDEpLA0KPiA+ICAJSU1YOTNfQURDX0NIQU4oMiksDQo+ID4gIAlJTVg5M19BRENfQ0hB
TigzKSwNCj4gPiArCUlNWDkzX0FEQ19DSEFOKDQpLA0KPiA+ICsJSU1YOTNfQURDX0NIQU4oNSks
DQo+ID4gKwlJTVg5M19BRENfQ0hBTig2KSwNCj4gPiArCUlNWDkzX0FEQ19DSEFOKDcpLA0KPiA+
ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIGlteDkzX2FkY19wb3dlcl9kb3duKHN0cnVjdCBp
bXg5M19hZGMgKmFkYykNCg0K

