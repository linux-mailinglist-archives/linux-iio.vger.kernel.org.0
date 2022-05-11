Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737E3522D64
	for <lists+linux-iio@lfdr.de>; Wed, 11 May 2022 09:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbiEKHaw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 May 2022 03:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiEKHav (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2022 03:30:51 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2129.outbound.protection.outlook.com [40.107.113.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9120B15;
        Wed, 11 May 2022 00:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPoLbAW8b0vqtmc4kttujjUSYfoAUgd4yTkhLkrVDx8JgW4jEr2IlqvpVdoHgHxF1ANx+VVLIOuLzB6agibfs3JUzwhAvtxXV26e59SneYZkVOfFkh/mfYGq9IR4SxhWf4dvMgU2CTJe4wuYMeZeEJ9QirYejAOqQofxwKiR9Fcc9c4NeTdXMmQRVjA4gKkHc619GWj9EQM+5ZmZ2fdnAz6A0tjDo6VzP62w7UGAqxyIY5suK9ILIrQPrOi3aFm4p6WkcW9YtVuYYzZLNs4W5gHm15jluGTpQeSIxHijYsj+8qPXTlryrwfYV2oCL4CWo2iZ/UXZWXusIqZcTH0LrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QYDvbXmoXfYDiQxPJsynT8O4sUUfDBUiNFcU9jtDDs=;
 b=nm0aFkAGR/UcaG/dXNIu+pB5kq+638QSorIbGUA9dCQROlEM1H/C0YOlV25ypVvNMo+67Fhqh8mnzQMz8S1skpDuhkCM2raLgFS64E0GxqEjh8nVQL5XrwviA+7a5w2TwMVGxtUPQoOjaO2mNCfg8uHAHl1yNMNbICEKk1qfrWRdg8QPDzLnYiZ6chDJkwBw/K0gzheK6qfC9JUwaIsSxvDmitO48jK4f8Skfcr6nMvQP88s0oboZUjPVRzANCGkVjezoqYdCklDOU+Wz5+BOOjECege2BaybYtmhcb1GYqUSSAd34UHH0XcbLQcZyawqSIscJsb5h10pk90b0w/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QYDvbXmoXfYDiQxPJsynT8O4sUUfDBUiNFcU9jtDDs=;
 b=ULoQunwgOB3EyCC1k+8pMHLXZKexDXQ0KkkUpFSnNIV+x1UpIrWsSyQe+P6FslNu7gEEhB+D0I3usQer8eWzYnpnWpOMlZ+3VzSCsaHHN6ypt6NtFX3hs46NSucmjlAd2DbwKQ2tyqGLwCrxSPTtnAWizvvamPlgxCSEQrmNYEo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB6813.jpnprd01.prod.outlook.com (2603:1096:604:130::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 07:30:43 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:30:43 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Index: AQHYYK+lDsvUpPE0qE2rS+QRz8CKdq0RcTaAgAASxFCABQDbAIABHEGggACve4CAACORYIAA0j+AgAAEMgA=
Date:   Wed, 11 May 2022 07:30:43 +0000
Message-ID: <OS0PR01MB5922A4D11BB9B034F142455586C89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com>
 <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdVV=MB8xa-Q-c_aZx9LGrW=9aP9iC3P-FMRSf-HiovOzA@mail.gmail.com>
 <OS0PR01MB59224E3B5A9E5D8FD5E55B2886C59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXDCDLhOSGgy9WWwawiHpE8C6isU2dLn6uSpY2gFAr38g@mail.gmail.com>
 <OS0PR01MB5922CD6D965A6138721F9A5886C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YnqPTQVUNADk/YO4@robh.at.kernel.org>
 <OS0PR01MB59222568C4189A74FE83D6B186C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdVAxgsfnS1hjmrjT+pQrne8qGLejFgQ54+KDPdv=mq72g@mail.gmail.com>
In-Reply-To: <CAMuHMdVAxgsfnS1hjmrjT+pQrne8qGLejFgQ54+KDPdv=mq72g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94cfdc89-ea4f-4574-27c2-08da33202831
x-ms-traffictypediagnostic: OSZPR01MB6813:EE_
x-microsoft-antispam-prvs: <OSZPR01MB68135E0568A45EF6795E62ED86C89@OSZPR01MB6813.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GAWayMvpfErMgDJ/hWN42i8qoqpDPb3z+i8PPKGETO/cU4iv/u4Nt175bBsZVS8nFyWsbXPjijynJ2swiBYOPkoqm6MXDWacnPo3g2WlPM11m4BI0Xp3eWWsP7YKqDiRWkCi7SFv56fQsN2nPAdFbrkzvvhAXOxMMwDqk6gok3fLtmTh8EDYMN0oNG377aXqPgqdQyd1q5xUz67iQP/08rUdnDsFKdfjKR8hKeNbSjEoL+Z+WNSXUnYAMdJ367161IowvcZqAfJqLGdH/RxWS26pypiVQ9+XY9YERGuy/qOObsLnXC5O/A2S4y6LpxcMa5CQzYe1JbeeccEMHiyANNlDr177WaZA/EBWcRAAKV+h/W7jk2njmpchuONfC2CGb+17FNi83aEc5mWOn/KH0uwgDPpeUnl/Xl90kQMZ0svIk9zWkDxFa26AXzPkKHZQno7Hs6oYpPHOBWPb0xOvv8nNaZjaufi6s2Mq7gnlV32yELIS/NE0R6qENUk37tvekR02aimE9ZwFhsgpX/g0+P5R+ZOr433IK7QnBtnyaU5v7EmSKbtWXprsw+FDhOsiM1ixC6Az39BqtS/UIuTg/RyT0S4MSbLsc1xJhSwW0gfU2/mCEJ2SC+hG5E6aIMSlPdaoUBIRsreftlXMAt39FjhALmu0EpfCKajUMKh0N/2HsPdnT9H2oQQX6CRzSWXScEWARUe7DOhZuNkzTIzKeth5WyMoo4Mg31Be4SusS+aDXgZxd7m8yLsG/s2f3biSJyxVhC4J8m1OScZ7Zwbhko45yRTdRa/cEs+GWEwnLEA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(64756008)(76116006)(66556008)(66446008)(52536014)(8676002)(66476007)(2906002)(66946007)(4326008)(7696005)(316002)(53546011)(508600001)(54906003)(55016003)(6506007)(966005)(71200400001)(33656002)(6916009)(5660300002)(9686003)(4744005)(107886003)(26005)(186003)(86362001)(122000001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmFmY2ROQWtiNndTL1BRZWRncHMvVG1rYzVjODBXY3ZCa09yTkorV1hYa1ZX?=
 =?utf-8?B?MnN3NnBMWWVBcytVbVdoOU9GeXBvTnJJL0FQU21uWEhjdTFBMkNWTUQ2TE43?=
 =?utf-8?B?Z25aZW5HTnlmVjNsa3RlSyt2ZzRGdnVMM3BlNFdkNHZqdXFVbFp5ZEtvbjNG?=
 =?utf-8?B?cWZnVENPVnFuZEQ4MThSR0g3QUtLcmZKVjlqRDFqYjdiYktEZndhTU9NcFJM?=
 =?utf-8?B?dlo4alFYOHNJOUwrTExCT2dwcHNOOTExT21MNHoxU3hSN2h3MUNiYUVxc21p?=
 =?utf-8?B?ejFpWVM5U3M2WWJzZmQ0MnJMOEU3VDRvaWlLVDd2L2hkb0ZLREtXNkppUUFJ?=
 =?utf-8?B?TGtIYUwrQVhSTWtuZnQvVVRhelB6ZERmWllSTythdnVZSFVWZ1hRUkVRZFVE?=
 =?utf-8?B?Y2dUM3ZIZTVNRjhSVklrRFNiOFFHMUhPZll0aHFjN3FSOVAzOWVyVExhazV4?=
 =?utf-8?B?RHVDV2M0MEtuc21WTFNRYUZlWjNWelFSODVRdmZsWnJjYmJJUVZSdEZKUVhE?=
 =?utf-8?B?WlBaMkhwWCtOaGk3a21nNG1EWGlrcDVtS2JCQ3Jtc1djbHIra29wTWQ4NEdO?=
 =?utf-8?B?NERmYUs2NXE2U0ZSOVVzL3VIZERjVjh6QWV5ajdNeEszRXQvdER3TGNGeFVh?=
 =?utf-8?B?MWdra0M5dUlRZDM5a1FzSkRmZmc1QjVDQXY1L0htRVYwem1STVk0TkRPOVdL?=
 =?utf-8?B?a0hEQXJqSFluN01CY0ZKMFcremFISGZvMW8vc21SZGhGWkZxTmUyQWRRVS92?=
 =?utf-8?B?UGluK29NdVkzZEp2QjBTNnUra3FvbjhHQm92WG12dStRTWRja0w4SE9UV3V3?=
 =?utf-8?B?M1ZMNGN6VUhjQ25WMjRnNVVDRFNNL1lxdUdDbVQ1WFJSRmJIbThTaWRyeWNj?=
 =?utf-8?B?THI0M2UrQk9Qdjl6NnpTandCU1ZJK1JzUVRFc0lCS1F3YkFrN1d3dTBDeWhH?=
 =?utf-8?B?cEk0RkpSVkJBUTRoNE51dDJvNUM0cjhMQ29CNWZCald0WEs0c2xUcmJFVDdh?=
 =?utf-8?B?K3pPbStNekJ2V0ZHa1UyeWZZMUE5NzB4a3BDRS9ubm1ZMjBuZjA0OWZCaGVV?=
 =?utf-8?B?STQ0NmpqQVplaHFFT1Z0VGpCdk84NGpKKzV1OHFlTkovVWNEVnVjeUJ2SE9X?=
 =?utf-8?B?MWEySWVkL0xJZm1sNmxxSHgxWFk5OUU4REk5enk4UGYwTjJLVGNBRkN0ekY5?=
 =?utf-8?B?dzN3YVNrQTJScWQ5VGtmMGd4cm04bWU1YnJHUEhIZERXcStRc2xoRTdZY0o2?=
 =?utf-8?B?SkFpTHVFd0E4amh1ZHl0SFExSDQ1RUpHZnVnL1owVCtFbXFyUzcxZ2ljV3Qx?=
 =?utf-8?B?ZlNteVFXb0JIVjBWOWFIQ1U5UU1xbmpJeEt2ZVpPZU5va1RWYnByVXRWZjMx?=
 =?utf-8?B?akh3THpua1czNEJRNHVxaFBEa3RNKzdHK1JyUHpKRCs0Sjh4RGpzSFhBVFNI?=
 =?utf-8?B?R3BWWWd1TGY5N2EySk81UG1xaDNsNUdVYi81WFd6U0VReElreVpPNUZ0RVd1?=
 =?utf-8?B?UmNXY21CcFZ0MWJYL2FHVDFNdk4zc1JuVzZuY2d2U2Y5WVpTY2poZGpQWGlz?=
 =?utf-8?B?VkVJenZMYVl4QzArR2U1ZURLNXJVZXNXUmJJN0lBNEdBaXVoWU1RRWFhcHIr?=
 =?utf-8?B?OFFBMmNqZ1VCdGFSSUxxZk1FekMrRk1pL1pMOTB0cmprUCtKL05FZWVxVUoz?=
 =?utf-8?B?dGlHb3pSbTF2Yk1RQjhXSkRJZ1lqUTlMalJRQUwyMkcvY3dKYXZaRDJjckFw?=
 =?utf-8?B?WTZkN3llVmtPOWQzMzQrSFlCZEpRQXhsS3hLbktSanJvQWlKeGF3aGVrT09F?=
 =?utf-8?B?Uk9WSmNwcG1RQ0Y1QW1KYk5Hc25yTXNNVjM0amhQUDBJZXhhaWdLcEdBdWFH?=
 =?utf-8?B?OUpDVU0vOHQ5KzFiQmxzblI5VjltWGJsU3VlZ1V5WkdnSEVpdEdJa2VQNVht?=
 =?utf-8?B?a2dEWGlTKzFqNnBhSHdPMmtVVlBZbzFCYzNoWmNrMTBjSk1qaGoxVDJHYi8r?=
 =?utf-8?B?ZXNzWWFaQTRpTVZHNnBZVlNST1JvNExjVkcxTHF5VC9zbC9QM1pCR3E2bVNy?=
 =?utf-8?B?NVNBWVNuWjcyendDRnFvaTI2KythV1hvQkFuS2lNWmd4cUk2eUJPdjZ6bU44?=
 =?utf-8?B?T09HTThuN2hPeTFLQnJLSENHWGVucGlwZ2NkY0pkYnBoMG5BcVBLeUZZU25n?=
 =?utf-8?B?azFkM0ppWnFqLzNXWHRHMDNRWDFNOWFra3FzMlorZFpKNVVyS0FZL2w0OTRu?=
 =?utf-8?B?dkk5ZG1tUGo1cGg5Y1FIbTU1S1d1ckVrTnpwSzA3Y1hBWWNlcURGU1dIN1M1?=
 =?utf-8?B?bjYxUnNWWitMVzNwSXh1TE1Xc3diYURhY2lnNnRQcDZ0UE5uUFJzdDEyQkcy?=
 =?utf-8?Q?8PwP4gayK5LaSZ28=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cfdc89-ea4f-4574-27c2-08da33202831
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 07:30:43.2001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epBP/q1Byb/ml4aTGnX6OidXEflMKG9Okm2NbEYYYUmHWv4VzjFlRmcYmX0WsNJrKkVibeKcMSmZag8CraPOvTm/0VCxwQrxqWG0jA97axM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6813
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMS8yXSBkdC1iaW5kaW5nczogaWlvOiBhZGM6IERvY3VtZW50IFJlbmVzYXMgUlov
RzJVTA0KPiBBREMNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBUdWUsIE1heSAxMCwgMjAyMiBh
dCA4OjMxIFBNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6
DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gZHQtYmluZGluZ3M6IGlpbzogYWRj
OiBEb2N1bWVudCBSZW5lc2FzDQo+ID4gPiBSWi9HMlVMIEFEQw0KPiA+ID4gcGF0dGVyblByb3Bl
cnRpZXM6DQo+ID4gPiAgICdeY2hhbm5lbEBbMi03XSQnOiBmYWxzZQ0KPiA+DQo+ID4gVGhpcyBm
aXhlcyB0aGUgdmFsaWRhdGlvbiBmb3IgY2hhbm5lbHMuIEJ1dCBob3cgZG8gd2UgcmVzdHJpY3Qg
cmVnIGluZGV4DQo+IGJldHdlZW4gMC0xID8NCj4gPiBUaGUgYmVsb3cgZXhhbXBsZSBpcyBwYXNz
aW5nIGluc3RlYWQgb2YgZmFpbGluZy4NCj4gPiAgICAgICBjaGFubmVsQDAgew0KPiA+ICAgICAg
ICAgcmVnID0gPDU+Ow0KPiA+ICAgICAgIH07DQo+IA0KPiBJIGV4cGVjdCB0aGF0IHRvIGJlIGZs
YWdnZWQgYnkgdGhlIGdlbmVyaWMgdW5pdC1hZGRyZXNzIHZzLiByZWcgY2hlY2s/DQoNCllvdSBt
ZWFuIHRoaXMgc2hvdWxkIGJlIHRha2UgY2FyZSBieSBkdC1zY2hlbWEgYXV0b21hdGljYWxseSwg
cmlnaHQ/DQpDdXJyZW50bHkgaXQgaXMgbm90IHRoZSBjYXNlLiBJdCBuZWVkcyBhZGRpdGlvbmFs
IGNoZWNrIGZvciB0YWtpbmcgY2FyZSBbMV0NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LXJlbmVzYXMtc29jL0NBTXVITWRXTlBfSDlGTmN5Z1hacDBZc3c9d0dYelY3MVFfVTdI
cz13SF9WY3RuejFwZ0BtYWlsLmdtYWlsLmNvbS9ULyN1DQoNCkNoZWVycywNCkJpanUNCg0KDQo=
