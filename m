Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D516D77B3A9
	for <lists+linux-iio@lfdr.de>; Mon, 14 Aug 2023 10:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjHNIQD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Aug 2023 04:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjHNIQB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Aug 2023 04:16:01 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2116.outbound.protection.outlook.com [40.107.113.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553E3DA;
        Mon, 14 Aug 2023 01:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEhY81I7gAlX9XNtvi0brrbmC5A7YKOj+ZDmshxO+CulIOM+/sLua1FkeaDMzVF8GleGIXUT6npvZpXCcvQ5o7cRMutALQL+rG3Lk0IfdRu5TG7ncx3aaQUlYBOCDEME7ZAHeoGPcbz9dGBfEFxUvBHFfdFPSa4foA9gzB6OmkSfdv0DT997pqjWxepvzVN1z2ib9pH/oI8LMSgRST7PMZo3mTJv44bWJA0Sxlq95kfKYxqspfILeLgvtTTvVGcXzut6yzZvMvr5e0oLX7hOZrX29HUCwaOG+zvrpKi14u8zdcD0dt+PV1VrXRa7gopavze3+8drKwMfI5eBR+vLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ps0Gt9+CatR/1vWaJs+ZjboG+Ckz905j5YnBvGbjj1s=;
 b=IPdBF+v2YhTGxbztT7lupv1Xm94pwKbSrpxEiKcx5k6RQgPLKaJGIvKSq+fHkbUc/PhQkD63eHqaB/cPFPcpAYu3DsbRLnc8/L69SYC6tOOt0aM5+YPjjmLzJcngF6Z9HZ+PpE3lfeuurOahI8uWbqsRF0QAAT9j4gvfYNEXxv37lKdoFYMB4nlhpFfdixVHf5h9d0WW74DR3p8nbOjX2pfJiPhzA8qhu3uEra+brEhhC7bAoX8vGgf6SRbg9BMM/xyo7om5q0mkOOMJycky61hvjpZWQiCBHAz8Z4v4Nx3OYVoysjt4mRwodLW94Zur8nGDzDMKCh0zhm81kcuwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps0Gt9+CatR/1vWaJs+ZjboG+Ckz905j5YnBvGbjj1s=;
 b=aUpMGvVDeWSZL6PFi/kunLk38Exes7sl2dB5V2UexJi58H2r2KfAYUPvMeS+UJNN/3FraV6MDAQo2uskt98K3h0nJke9olHQ26qOymDvxh63cIMe/Du0/RM+rRUvLrEnVcWKHMcT9KLo9XlUZN9f8KANbmH+5Yrz4OJuuyFl4Cs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10176.jpnprd01.prod.outlook.com (2603:1096:400:1e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 08:15:56 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 08:15:55 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>
Subject: RE: [PATCH] iio: accel: adxl345: Convert enum->pointer for data in
 match data table
Thread-Topic: [PATCH] iio: accel: adxl345: Convert enum->pointer for data in
 match data table
Thread-Index: AQHZzSJIyfDj45QVS0ShY8ZRlRjq0q/oq54AgADH91A=
Date:   Mon, 14 Aug 2023 08:15:55 +0000
Message-ID: <OS0PR01MB5922BC5A05A5DFDC9B6092A48617A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230812133825.141581-1-biju.das.jz@bp.renesas.com>
 <CAHp75VeX+T=hAN+PgtHTdv4b6UtDVgveUUww1b1kuOngzDinFw@mail.gmail.com>
In-Reply-To: <CAHp75VeX+T=hAN+PgtHTdv4b6UtDVgveUUww1b1kuOngzDinFw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10176:EE_
x-ms-office365-filtering-correlation-id: 67b1b044-685c-4199-fa7b-08db9c9eaf14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OZDJZHvvIK4VLVbQdMvrH90nhq2+jvYDV3l59GOBgn8oRNHDlRVBaJG0hFP6gfjXrmhfnFE4DUiN9GDGxae08gdxn0Da9Rjmqba/FMLoRbkhEeVhYJmL1VqAl2aEYxcd8Yh4+et7JIeUww6WsdnR9L9H8eV2QYzP0ZTJ+g/n+BkunyvdC/UHUkTTHfrkguDfIs8s3EXQ34OpcnJOrTW61ckh+kItTGqnYvZ8GYjGYSIPTdMfO4n4UJlgcB7s5lKDFnpcPC6GHArvZ5CbPAlT08vGYe1wX56ZyQMrShzXZnVTW24XA17PF7NI5XJkFqvP1OaXJjQfwOvkv/L8w/b0hPfREnmF78mllstug6wo2ZcvYk19JAIDbjyyWaogugDQGVYneMnpeq7ke6GV37EYQftk3kW14vpsofPwWuT6WnrvxizXDi9d1hoGGe+D0XJs2u7QmJy7I+W++S8xwdYmvSmhaacvUOXTQMxVK0Tx58iwUVWocs6LwCmGvuScHqdURA9+yI7U4gDLFIJmlWXa3qa1e3EwK9DriGKz9K12UUSz1SU+NFYMIC3j1RZ/Z1xt14sUr8AsAaChmwyVEY7zWca6m1rTH9hh0wo3YOCF2p8pSZZ9Es2lDpXYiJvBJ51h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(1800799006)(186006)(55016003)(38100700002)(54906003)(7696005)(71200400001)(478600001)(122000001)(52536014)(38070700005)(5660300002)(2906002)(33656002)(86362001)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(41300700001)(8936002)(316002)(8676002)(6506007)(53546011)(26005)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1QwWkh2MVUySlc5aTQrMExRVmNydjBud3V6cWludG1JdjJoK1I1cG4xSGNk?=
 =?utf-8?B?SEFtSTZ5aXVzVDIyenFWbHFFSVQxd0FwN3RXOGttT1cwQjd0aWgrWTJwTEZJ?=
 =?utf-8?B?Y3FJU3lZdk0wSDc1ZWgzOU5IODRGdHBMazNWR1FlMnlrY2QrQ1RKMzZPRG9z?=
 =?utf-8?B?LzdFTVg5VklvR0N0VnVoRWx3YlFZYVhxa2RRRDNqUU84QUxMczJOVm5sMTVJ?=
 =?utf-8?B?bnpidUlaaWh5RDZubjg1OG9iSW1CZGVmckFPRHh6YzBXLzFmN0RPYnF0UnZl?=
 =?utf-8?B?SXZMNVdQYjJsaVR1U0hzUEdpUVNiN0ZvaVJORTVGN1BQZjI3azl2UHJRRy9p?=
 =?utf-8?B?MGhRV09xMVNFcWMyM3pIZ3Y1Y2xYNUhhUVlhTVk5ekVDNi9rRFNGU0hQVmNp?=
 =?utf-8?B?bDk5dGhZZmtndDFHNWg4aXQySENqSS9wdnVaenFYaHBsVWJ3Q0g4TFA5Qy9H?=
 =?utf-8?B?ekFwdXorQS9YMnh4VkhvNUt2cUtmbTA0aUZEQ1RoM0MwU0swYTF0MUNIZTdj?=
 =?utf-8?B?OEU1YTB5a2h4T3ZGZVlSVWF0WTdsYkU3ZVRHd1dLVFE5d0xyWVVUQWtxYlhp?=
 =?utf-8?B?ZXJScjRJdk1KTVNhL0lNOUNkN0FwcFgwK2lUVXI1Wi9WUWxZQU1OZnJUVGV2?=
 =?utf-8?B?dTJQSzBYTjcrc3lST1o0dnk4ejN6YS9Eejd1cTFVQXJlK0FvV3U4TnZ4WUpP?=
 =?utf-8?B?VjR1M1B6U3lLcG9SMEc5Rzd0Q216Z0ZHK1hacjcyUGlNRlBBTTZVN1NsemtM?=
 =?utf-8?B?UGQyeURPRXIrS3hqUjNqaFVEWEZNUzAzZlM3ZVNuQTlSaWZqSDJzU3dwNGoy?=
 =?utf-8?B?RmVYWUxhdldmSktwNXpCV3lDSUs2QmNCczJjSmd5eEc2eUpSVTV4c3diYjJL?=
 =?utf-8?B?WkplUGsyNDh0a1JRZzR4V1U0Nm9KaUVxSWVZNFlsWTJaaHRGMjdORFB6blhw?=
 =?utf-8?B?dlV0eXRTb3RCQXNQUHFHOENVWDZqaS91WDdBaHBRUEZXQ1ZmNVFFNllOOERX?=
 =?utf-8?B?N1ZtSjFKRU9YNUdpcHFXVWlDWjM1VzByQURBdmRQakRuckZWbjhQcmJ3ME5C?=
 =?utf-8?B?eWcyYUdML3FvWDVZRUs2K3JiNFIzdnM2cENuK3JaZkxzN2V2MHhXU1B3ZDl4?=
 =?utf-8?B?VUptdHFVeDJiU2FSQThySDUxVzVEUUdNTjdTdGNpVWpicERkeThHVm1KdDR0?=
 =?utf-8?B?Z0FldUJQQlZrTXc2WERTVmhvRFpqQ0xnQnphNnp6RlQxbkYxUVFZcVFCN0Rs?=
 =?utf-8?B?eWJHTEFVNytwcml5enlLZ2o5YjU0RlBRVkNGYno5dEJMbmEySHY0OTVaZTRG?=
 =?utf-8?B?eXVUOVgzejlSOHVEQmNRTWVRNElMdW9vUmluSlRSTzl0cHBwbE1Ld3dLK2Iw?=
 =?utf-8?B?K0c3WktvU010MW9jK0czS3I2ajRyYmFVSkhIa2NSREtHdWthS2N3NTVBay93?=
 =?utf-8?B?akZObTN5VkRKUWlxRHhZSENwVlR6N3EyQUNsMVc0bXJXVXY4dkg5dnVhK3pC?=
 =?utf-8?B?ZHkzTWJGTXNEcEphYVR3MFZnV2Fxa1BLTEdLbXF1Q0VObEhUbEw3bWdFakkw?=
 =?utf-8?B?cGVMOTF6ajBLT3pOS2l6ZmJSZEMySWV3UXZDWUpZbHlVY3RmWXovSm1BUmhw?=
 =?utf-8?B?blVCc0ZoRXpBdnViTGFQbHB0aU96WnkrNVhCUDBBWFFtKzlJakJWa3dIU1pX?=
 =?utf-8?B?VDVPZU5tQ0wrMTJPblBRVks2bm9RZUVuVUxLaWtoaTFEcHdoSTNtZm9CaUpu?=
 =?utf-8?B?VEJTQm5IdU5IVE9UaXBZWWQ0TTg3cS9RamZHOU1wMW5PcENLcDNscitqMnQr?=
 =?utf-8?B?MkxNaks1NUsrbFdyZmVXeVVQUnl0UitoT0ROUzhtOWxjMlIzM2tUMWUwbXZW?=
 =?utf-8?B?RWRIVXY5UlZ3WDhuWkdWWk5IczRQcFFadjJmMUQ4NHVhV3VLSk1wUFRDSVhN?=
 =?utf-8?B?RTF6SHNXektLRHFEVGVxZ0QvbDN5aWVMZWlINlIycm9nNVA5WFdEblZrbFho?=
 =?utf-8?B?dCtMNHVYNHBocXRPMGhYVjRYb3J1M2t3QXdQdUFLck8zWkFpbno2azNJQ0Rx?=
 =?utf-8?B?SWp2S0szcnlhakp5b2ZicEhndnJmdGFVTFVOMmNoa3d2SGlBeHcrT2lKVk4r?=
 =?utf-8?Q?tSul4K+tuZMrD8qIWpqwHsjmk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b1b044-685c-4199-fa7b-08db9c9eaf14
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 08:15:55.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOxzD96L4qUt1juFfr4tcEBRzo79Elfl8N/RMybK9M6nxnDK7bfhDMfyuQK/1K1bNfVFZJWQmLB4gP4MWXix+bcwXlnEikNIjK/R0erMal8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10176
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gaWlvOiBhY2NlbDogYWR4bDM0NTogQ29udmVydCBlbnVtLT5wb2ludGVyIGZvciBkYXRh
DQo+IGluIG1hdGNoIGRhdGEgdGFibGUNCj4gDQo+IE9uIFNhdCwgQXVnIDEyLCAyMDIzIGF0IDQ6
MzjigK9QTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0K
PiA+DQo+ID4gQ29udmVydCBlbnVtLT5wb2ludGVyIGZvciBkYXRhIGluIG1hdGNoIGRhdGEgdGFi
bGUsIHNvIHRoYXQNCj4gPiBkZXZpY2VfZ2V0X21hdGNoX2RhdGEoKSBjYW4gZG8gbWF0Y2ggYWdh
aW5zdCBPRi9BQ1BJL0kyQyB0YWJsZXMsIG9uY2UNCj4gPiBpMmMgYnVzIHR5cGUgbWF0Y2ggc3Vw
cG9ydCBhZGRlZCB0byBpdC4NCj4gPg0KPiA+IEFkZCBzdHJ1Y3QgYWR4bDN4NV9jaGlwX2luZm8g
YW5kIHJlcGxhY2UgZW51bS0+YWR4bDN4NV9jaGlwX2luZm8gaW4NCj4gPiB0aGUgbWF0Y2ggdGFi
bGUgYW5kIHNpbXBsaWZ5IGFkeGwzNDVfcHJvYmUoKS4NCj4gDQo+IC4uLg0KPiANCj4gPiArICAg
ICAgIGluZm8gPSBkZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gPiArICAgICAgIGlmIChp
bmZvLT50eXBlICE9IEFEWEwzNDUgJiYgaW5mby0+dHlwZSAhPSBBRFhMMzc1KQ0KPiA+ICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gDQo+IEkgd291bGQgcmF0aGVyIHVzZSBzd2l0
Y2gtY2FzZS4NCk9LLCB3aWxsIHVzZSBzd2l0Y2ggY2FzZS4NCg0KPiBBbnl3YXksIHNhbWUgY29t
bWVudHMgaGVyZSBhcyBmb3IgdGhlIG90aGVyIHBhdGNoOiBFTk9ERVYgYW5kIHRyYWlsaW5nDQo+
IGNvbW1hcy4NCg0KT0suIElmIHRoZXJlIGlzIG5vIG9iamVjdGlvbnMuDQoNCj4gDQo+IC4uLg0K
PiANCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBhZHhsM3g1X2NoaXBfaW5mbyBhZHhsMzQ1X2ky
Y19pbmZvID0gew0KPiA+ICsgICAgICAgLm5hbWUgPSAiYWR4bDM0NSIsDQo+ID4gKyAgICAgICAu
dHlwZSA9IEFEWEwzNDUNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
YWR4bDN4NV9jaGlwX2luZm8gYWR4bDM3NV9pMmNfaW5mbyA9IHsNCj4gPiArICAgICAgIC5uYW1l
ID0gImFkeGwzNzUiLA0KPiA+ICsgICAgICAgLnR5cGUgPSBBRFhMMzc1DQo+ID4gK307DQo+IA0K
PiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGFkeGwzeDVfY2hpcF9pbmZvIGFkeGwzNDVfc3BpX2lu
Zm8gPSB7DQo+ID4gKyAgICAgICAubmFtZSA9ICJhZHhsMzQ1IiwNCj4gPiArICAgICAgIC50eXBl
ID0gQURYTDM0NQ0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBhZHhs
M3g1X2NoaXBfaW5mbyBhZHhsMzc1X3NwaV9pbmZvID0gew0KPiA+ICsgICAgICAgLm5hbWUgPSAi
YWR4bDM3NSIsDQo+ID4gKyAgICAgICAudHlwZSA9IEFEWEwzNzUNCj4gPiArfTsNCj4gDQo+IFdo
eSBkdXA/DQoNCkJlY2F1c2UgaXQgaTJjIGFuZCBzcGkgdGFibGUuIEFueXdheSBJIHJlcXVlc3Rl
ZCBBbmdlbCBJZ2xlc2lhcyANCnRvIHVzZSB1bmlmaWVkIHRhYmxlIGZvciBibXAyODBfaTJjKCkg
YW5kIGJtcDI4MF9zcGkoKSBhbmQgaWYgaXQgaXMgZG8gYWJsZSwgY3JlYXRlIGEgc2VwYXJhdGUg
cGF0Y2guDQoNCkNoZWVycywNCkJpanUNCg0KPiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMs
DQo+IEFuZHkgU2hldmNoZW5rbw0K
