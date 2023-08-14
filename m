Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BED77B38A
	for <lists+linux-iio@lfdr.de>; Mon, 14 Aug 2023 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjHNIMT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Aug 2023 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjHNIMD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Aug 2023 04:12:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2115.outbound.protection.outlook.com [40.107.113.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4466E1BE5;
        Mon, 14 Aug 2023 01:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Au2B0nEMDkyCBc7EOjwD3KQxGDcRvjggZTjH+GWW85JA3aQjopzQwg11upkKSwXvnCjXdZNp5eXJHbHFQ9NJvu8AwiYYxEQZdrhVsfDPwkgouslMGiEopfAZSq35PIaL6SAIufpF7bUF6AN/L2y2uu/+HDfeQD9n2MQFNtRSwWwWMXGZMGlNkpj2GttmpL2gfpFiqv2QLKWIUcwTGwP5LH40Fsc15Rs9HZmwdePwfY5iu1WBSKlNCYFODGMx7ThoxoforvTToCC5lMhvAmr5YB/gmaNjV26f4FPpetEZhuGO4vvhPGMfE/NF72wvY8LVjC9FLMNSpOr1rotZCsSaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7c6VLqiii5VR46f+IyxrfVBonlLt9wZRTWfAlr0E/Ro=;
 b=SZ4eRIvXGrJFxvv9hZZ5jFj8k8nhZnpxoitQQyhufodisGapLWRO8hQv5/NNhaBn1EDba2xwzcvouH5i/UyqVJ/v/KGIAJN1NQKbasQi0VkOVe/Q+tn3kN0/fqzB0C0IJ3hKEg9cabltvbXA6IlxkfLlIK3MZnKhfkMrr6NlHj/QKRUlHwU1h3Xder8azVASTvSTdbUIyEHI7PO5mTUGndLEizPWMOzUqJxXYQAfVZVI5gXpnM6sHV+dbeXNdMXZr3q8frgAQA1KO/sttC8D5kI7pLO6hUKNFS+wxAXkcJcy2/idB1aCsDvRPYIWFbmp66Wd3KPwge9DQBEH1VOkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c6VLqiii5VR46f+IyxrfVBonlLt9wZRTWfAlr0E/Ro=;
 b=B9Pdpa1ZKYZSCQ4gJYPrvg7LGZigq+XLF7NHAOCeKwhjhDQTS7vPTGHUyNgS5hUi0KWh246QkJBzb8XjmpJTT/UGqJSrjlE1wdxsiduDt9C/aPsv6TqAgwuR+KteEayZFFKzXu4ygxMJaCtNwu8zyERFIdBMaY++D+g6Tvq+D4w=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB12015.jpnprd01.prod.outlook.com (2603:1096:400:3e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 08:11:15 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 08:11:15 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] iio: proximity: sx9310: Convert enum->pointer for match
 data table
Thread-Topic: [PATCH] iio: proximity: sx9310: Convert enum->pointer for match
 data table
Thread-Index: AQHZzR0hKk0+7vl3mUqHHMR9WMEpH6/oqc+AgADJcXA=
Date:   Mon, 14 Aug 2023 08:11:15 +0000
Message-ID: <OS0PR01MB5922F85E8365CEB364B5962E8617A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230812130130.123243-1-biju.das.jz@bp.renesas.com>
 <CAHp75VfqGB1OYLGjK6MRPtPCkaFeY=c13RSEXrDH9eC5W9vjmw@mail.gmail.com>
In-Reply-To: <CAHp75VfqGB1OYLGjK6MRPtPCkaFeY=c13RSEXrDH9eC5W9vjmw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB12015:EE_
x-ms-office365-filtering-correlation-id: eac1a20a-b2da-417b-5bf0-08db9c9e07ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AmoVUuBIdoYTMAG1Sca96Y9UxiIxrLxWNVz41uriOFuSgI6baf1bnUP9ihNco1Tfeq8QCy2Zl1o45UsdSBcQ9FVZvQSLEtm5HHklWa1KqDGETGxl+Y4WqnzquVfztT7EgepAZTMlJosBc3xWIRGkU6ChtlGtWn0EHGryk/jP8Yg0keBgwZyLKeDj59UjCOFjZcL0Vaa+UfQgPhi84HeriNCdsaSPiKO/lA3u5tdLNfG1PlcBwz9WnwF8n3CZrQHmsy/GelgyalSTBAONgwNBfnAC1ylxbUZ4Tzo1JOe1hEn+oSDLjjT/FSS51y7fJ2iX2q732nUqeetZaomfcxZOuqeuaOhU0Tah601h/STmmVhtFV+fce2Ox2PLfMgkMaUcqU2jCgZOYPBZJw9A+6Be24RK2Kp8LpfBqcroY3hsQDmBENfWDrz1SqNO4aOSRr0EZrMquYqTCFoUTKQbVMiRtRPA2QjfN8LfSQn72wB1CCNlZVBrNdqPB8+6IgS8gducgXR46kLAmxu8qEqtjjRYoc5rokvS+kINPq/AbeVVnMQH/4Qbczb2L9fb+QrPOOkJ4SM9xIdmGewsf8tcOvGq33VbXqNIsntNncYvnyoEzkk/y4L0OVl3b/9/6oZpofig
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(1800799006)(186006)(451199021)(9686003)(71200400001)(53546011)(7696005)(6506007)(478600001)(2906002)(26005)(41300700001)(64756008)(54906003)(66556008)(6916009)(316002)(66446008)(66946007)(76116006)(66476007)(5660300002)(4326008)(8936002)(8676002)(52536014)(86362001)(38100700002)(122000001)(33656002)(55016003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUZjVUw4akdmcDJNc2x1VnpRWU5SWFREcXNmaSs5dm5EVTQ1SXVZUmhTNExT?=
 =?utf-8?B?RVhxMFBKalVpY2kxMGJ4YjloUjJRbnZUVTRhMkxhczQrSStKVkFMREEyRFo0?=
 =?utf-8?B?b1dKaklQL21mMHorV3NqVGdoeVRWMWFJMEE1WFhhNFUvbjZVbDdNd3NKbU5F?=
 =?utf-8?B?a1ExbHA4OFcvSFdiOThaeUZkZjNTQ3E4M0UydUZneXcyZW5QSkZ1NElUMGpi?=
 =?utf-8?B?M0V3azJ2VXhzTUlGZElnNisrUmNleG8yQUFvTTIzMnpKWkxsanJ4TGFrdU9x?=
 =?utf-8?B?V2x5aFNtVTZuTjlnN3hLSDhVbCtZUXpOSlFOa1FvWTIxcHprM2ZsYXYxL0hn?=
 =?utf-8?B?S3VVSFk2STBTdytiNGI2dzJpbFZ0cUx3UCtXSC9RNHhOSlJ5UUU5dThaYXdI?=
 =?utf-8?B?azV4ZHhLK25Mcm0vb2xDZnpFTk5Qa1pBSnVScjluaUo1Z1FjTTlPU2RKYkJS?=
 =?utf-8?B?NnhHNFhoTnFzV3RmdzZYY3M2TkZqTmFrRGh4dzVhLzJsUFY1cFRrM3IwVGJz?=
 =?utf-8?B?WkJHMDF3L0xXdkx4a2NLNklYN3owY0JCR0JEcXZiWHQrUGVvTU51aHQyc3Mw?=
 =?utf-8?B?TzZZbzNWSzhLU0tVNVM1cmIzZGR5cnh4eUJlQ2RNbnRYcGkzOHNSbDFXMzRU?=
 =?utf-8?B?aXVJaFZqYTZZRVkxN3FkMHc5ZnQyNkoza3VvV1lVRmhzdE5DNUlmZ0J0bnZG?=
 =?utf-8?B?cFphN3ZJdXFEV1JOTnNRTFNVb3pRaWJ6Sy85SVMraXVPTSt2Vy8xUkJXV0Vr?=
 =?utf-8?B?TlA1NVdtUWttaTRKYzVPM3ZWaWpESFRGSU0rSS9wK0h2RUZMcXdpWGtxRk1D?=
 =?utf-8?B?VTZpQ2l2cU53LzVKejEralNkMmR2M2Via2IzTDBpOXcyWUQ4NlFjUTVrdStx?=
 =?utf-8?B?Y3FOeWg3QnhVb0hQbVZtUnhSdnZaemVvd252NE0vTm5MQ2FDUUt0ZytCMUFB?=
 =?utf-8?B?NzkzNkIvWGV6RUNoUktsUHo0QUZiRXp1dnhvVnUxeTRzaXVCdDJBTkFwYnl2?=
 =?utf-8?B?bEx3ZVNiS0tUK3VHMXk1bmJoQURhT1d4ZmRDcHl4WXFhcXNMVlA2WDBLV0Rm?=
 =?utf-8?B?MVNtWGZiV2lmNFAyN0Q1MVpiSUd0WnVsLyt6eXhETmcyanVzUi9STDJzOGRv?=
 =?utf-8?B?ZlZ5MVdLcUxmOEpOaGwrbVppaFlXSXNrMC93ZE1raGx5bHJZUC9LZGNkMWVz?=
 =?utf-8?B?UGNIYkVJaENhNVpRUCtGTXdZOTF2bWZEaTBxS3ZRQTVneHdWL2RNbzJNeUc0?=
 =?utf-8?B?bGI4bzU0ZWtnMWh3L3lsME9VV0t1QW0ycjBkMWYwTGZJTlJjbXMxUjJUQTgz?=
 =?utf-8?B?SnpoQVkxTE03RGdzV3RDTVJwcDRFaDJSclFRQWpUTXlZVkVUK2ZwdzJBN21m?=
 =?utf-8?B?SjZPRTlEaVk0bWN6YjNHVHJ4eXp5SitEa091TmJOcWpjUHF4MXdIVW5MaUFo?=
 =?utf-8?B?aHc5UFprTU84ZFNMb29GaVA3dXd4VTl6VFV2L0JoSnFGb0RvNHZHVjI3bDBT?=
 =?utf-8?B?K1FpaHFEKzFTZUhxTmRWNGVkQ2JRUXFOSlRBNnI5MWZ1Ly9UMDZJOXZQSEQ5?=
 =?utf-8?B?WWV2RzB0bWkySW1JZi9wVHVNNXJBTllTU28ra3NTcGQ5ZVBRamVURTZTS203?=
 =?utf-8?B?YWIxU2ZZakpyZ0lNZE9UeDQzM2dLT1M3NjBIbHpvT3RUMlNNbXFwTDlFRVFy?=
 =?utf-8?B?bFh5RGVRMS93eVV2VnUrRnpUNXNFcll6NGNQT2lENVVIWWFxTE9EU0JsYlNa?=
 =?utf-8?B?Q1JxQ1dydmljNzc3U2QyQ2VGNWkvMWVxZ1Y3b2wrdTh1WWpNVmVOdDAvdWZp?=
 =?utf-8?B?T3QzNnFWR0dYNnVyODNSYWRESzlNZlgwM3FaNzlHVkZXV2pDeFFYVEhqQ2NH?=
 =?utf-8?B?SnpQdjgvVjNBTkVLQW9ybXZERmtnL0MvYVNDMkJpSGpNUWtEVVgwcGlzdDBw?=
 =?utf-8?B?aWZOK0hDRk5NL1RFSnFaVjRBVUVZeDk1WmpmMGlSZ294ZkY2c0VDYkd4Mjd1?=
 =?utf-8?B?TEg0K2tlR1RuU3JLTmp2TzR5Y1FuT29CYncvUVd6dnVhY3JaZU94WVVjWm1E?=
 =?utf-8?B?b200ODFHSCtuQUxwMnUrQVgrMjFsNUljWFNEbWhOUXJQc3ZEWVFOSTNHd2pw?=
 =?utf-8?Q?+NYLzX9O2D37z62Q5W+qQWlig?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac1a20a-b2da-417b-5bf0-08db9c9e07ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 08:11:15.4389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdKus6D8nxTdWGkh9t5uWZUE2zPwK/fEAUj7E0sL5gppWhWbVn89CA7jKzLmeEsBGdL3Zuc9kV9BUTN5yc1qH6TDbfePwdm0Vl9yh4Xs4wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12015
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gaWlvOiBwcm94aW1pdHk6IHN4OTMxMDogQ29udmVydCBlbnVtLT5wb2ludGVyIGZvcg0K
PiBtYXRjaCBkYXRhIHRhYmxlDQo+IA0KPiBPbiBTYXQsIEF1ZyAxMiwgMjAyMyBhdCA0OjAx4oCv
UE0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPg0K
PiA+IENvbnZlcnQgZW51bS0+cG9pbnRlciBmb3IgZGF0YSBpbiBtYXRjaCBkYXRhIHRhYmxlLCBz
byB0aGF0DQo+ID4gZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkgY2FuIGRvIG1hdGNoIGFnYWluc3Qg
T0YvQUNQSS9JMkMgdGFibGVzLCBvbmNlDQo+ID4gaTJjIGJ1cyB0eXBlIG1hdGNoIHN1cHBvcnQg
YWRkZWQgdG8gaXQuDQo+ID4NCj4gPiBBZGQgc3RydWN0IHN4OTMxeF9pbmZvIGFuZCByZXBsYWNl
IGVudW0tPnN4OTMxeF9pbmZvIGluIHRoZSBtYXRjaA0KPiA+IHRhYmxlIGFuZCBzaW1wbGlmeSBz
eDkzMTBfY2hlY2tfd2hvYW1pKCkuDQo+IA0KPiAuLi4NCj4gDQo+ID4gKyAgICAgICBkZGF0YSA9
IGRldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiA+ICsgICAgICAgaWYgKGRkYXRhLT53aG9h
bWkgIT0gd2hvYW1pKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gDQo+
IC1FTk9ERVYgbG9va3MgYmV0dGVyLg0KDQpPSy4NCg0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IHN4OTMxeF9pbmZvIHN4OTMxMF9pbmZvID0gew0KPiA+ICsgICAgICAg
Lm5hbWUgPSAic3g5MzEwIiwNCj4gPiArICAgICAgIC53aG9hbWkgPSBTWDkzMTBfV0hPQU1JX1ZB
TFVFDQo+IA0KPiBLZWVwIHRyYWlsaW5nIGNvbW1hLg0KDQpPSy4NCg0KPiANCj4gPiArfTsNCj4g
PiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc3g5MzF4X2luZm8gc3g5MzExX2luZm8gPSB7
DQo+ID4gKyAgICAgICAubmFtZSA9ICJzeDkzMTEiLA0KPiA+ICsgICAgICAgLndob2FtaSA9IFNY
OTMxMV9XSE9BTUlfVkFMVUUNCj4gDQo+IERpdHRvLg0KDQpPSy4NCg0KV2lsbCBmaXggdGhpcyBp
biBuZXh0IHZlcnNpb24sIGlmIHRoZXJlIGlzIG5vIG9iamVjdGlvbnMuDQoNCkNoZWVycywNCkJp
anUNCg0KPiANCj4gPiArfTsNCj4gDQo+IC4uLg0KPiANCj4gT3RoZXJ3aXNlIGxvb2tzIGdvb2Qg
dG8gbWUNCj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdt
YWlsLmNvbT4NCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVu
a28NCg==
