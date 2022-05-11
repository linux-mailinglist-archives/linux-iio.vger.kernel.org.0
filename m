Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9120A522D82
	for <lists+linux-iio@lfdr.de>; Wed, 11 May 2022 09:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiEKHje (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 May 2022 03:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiEKHjd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2022 03:39:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2115.outbound.protection.outlook.com [40.107.113.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FEF22A2FA;
        Wed, 11 May 2022 00:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJn9UVFkkjMcd2reEJcMFINXDSy9LCB0bMSsfworoZ/kwJGdQAY5irIOBdvZPThCkr+mAH/6gpMJ+ct6BPsanhm7z6GKMnumYiO+akFNC7o/KXZAbXWQn/osZA8KajHRiJog0L6D2l6SqhyRvOrxSPWQx/do7LLXyGe195WktOmmybrQvpFNiU9fgeHk9MX+RgB+KsY/st3t6t+M/LtiJnru2EdVhFLEmRP76p+MWvDEVxfc7u3FxHF1Dw3XyFWyPT1yKHBGeeM7XQRLejCWqn08OCzmI6lM+vRFeM/NffB4ssO9gbPZoOclbrfOYTQfLVhk7B1uCSidmcQ5m2KNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3ceHi/C9qIuhn26qoUieqxF62O/TksvrY5EuLbAPwc=;
 b=DUUq2kQuy5hVfK6YrGHmy8m2zTFn/NpsIB3Y7pz1rZ6fYep2TwDDcaI/bqqR0kZl0Gv4KeeODCIkphHXzEny0viaZxIOJc58dMEzlkaIkSMK62A/8WiAPhR9snw6UqCXZ8hotSdEUzM6gYF8iP1kSz5pUFtQ0hOPdkhZBd9gwTGRkJFcTiwJanyu7lOGX7Be7jME/iPfpqupYSF2curvhSAi+qusimgS0HXOUOgHLwfjRyIyQcjZm/9G5RZ4OYYvAc2+24Lz52qcho2kEHWCIP+3iDWBrFzgQVA4I939ek7fDh1NhWgcKd6jwoZkdKk2TWhSFlnIUnkTUtzZxqe0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3ceHi/C9qIuhn26qoUieqxF62O/TksvrY5EuLbAPwc=;
 b=biozZYJM96pHZIA/eZmy2FrxJlDbu3ojVLEebhSkFG92ta6xB8sj2gq6KL/G+pPwNzbsHukUdujRDLOxY9C0tqqDEwVaOKN031en33jFsjfVre16lH0ddPIl1AQLV2ujeM7GcQwWZPAJ3z1TFY95tnRDsXh7fkVV6Litjnk/eRw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6929.jpnprd01.prod.outlook.com (2603:1096:400:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 07:39:27 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:39:27 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Topic: [PATCH v3 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Index: AQHYZQVtPYCoiRK5X0qgXNrhfCN9w60ZQz8AgAAExjA=
Date:   Wed, 11 May 2022 07:39:27 +0000
Message-ID: <OS0PR01MB5922FF4C6F417DFF1C3BED5186C89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220511070443.30231-1-biju.das.jz@bp.renesas.com>
 <20220511070443.30231-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdWNP_H9FNcygXZp0Ysw=wGXzV71Q_U7Hs=wH_Vctnz1pg@mail.gmail.com>
In-Reply-To: <CAMuHMdWNP_H9FNcygXZp0Ysw=wGXzV71Q_U7Hs=wH_Vctnz1pg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fc8a696-b253-4a71-da7e-08da332160e1
x-ms-traffictypediagnostic: TYCPR01MB6929:EE_
x-microsoft-antispam-prvs: <TYCPR01MB692973AAAD838221E5076A1A86C89@TYCPR01MB6929.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g0YLyHkkdkFmStbtgL3/9BLu0deyAMXseOYkNIE/aMbV3vWnqink3TAmM+PXOMacHCZd670rLqGmTERd0XITNt0LRGtixeOUjxLu5NGXgYK8a0f0668oyZWXtsA2471v1wvbJrcOPwFpTafk3pN6b4pTkhe5OPkGSwDPMEEog8dO+zKI1Kqwg0M86fY4t8LdtZJd+rn7E6fblEGpGGQ6J0nNQTvMyTdlMRNCSbaQoFEandlUOCS1MOFXxWnIrJq+XqgCoq/ZHre4kAFCn1tkZm6ODYmo43LL6VTtvPkQDs22bQH+jdf8SoWLO2mqb2g/X7osgUenPcw3NWgHjZgQCkTZZIH9SDOlqz4t3Ns2csiwF77+ZaEvA7Dyv5pmZHy0lgkSBKx4kUZIb0g23ozGCCeyat5f3sYx8XMzGFRIaXsAlx6pac79/+i7W4oytXwtKPl+69mnOjAmmsuGSvZpWdxHN9IbsEz8uwoJgYFwGhY8Y0xwojLcKQxfl8DY90MYLvwHQRQBJ2vTMfz1wG1cQIwBA2WWPKQUB93JmeSnSyb34Yx/mR006lB+0xVcm6yjwvOy6KUbKMTgen85hV4ARIIuMQgswnJVNJUhL7yBVs4yyuxyVHi9NUoOrT+tH5TulB8dNxHsmMmNlyQ/qxRLQuj+6R/pGuzYgum2eFhXWTqd0RNcf6I6Ot+Bq5lZ7OiU2R+JAvNe1UBhGl1eOG1VHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(71200400001)(508600001)(55016003)(52536014)(316002)(66556008)(66946007)(122000001)(8676002)(64756008)(66446008)(66476007)(4326008)(86362001)(76116006)(9686003)(5660300002)(38070700005)(38100700002)(26005)(54906003)(6916009)(7696005)(53546011)(6506007)(107886003)(186003)(2906002)(83380400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjJXY2J3ekJKbXh3cDlnOXZRbFhmbU4rVDdWVFh5d2Fiay9UeDBudFk2KzJC?=
 =?utf-8?B?eEdvVkJnTHlrV09RTTFBSXpMY2lodVRjdlg3cVJEbWFaNmhpNzE4dEt1OTVl?=
 =?utf-8?B?NGF5b3JZd0t3eUFrQlFCKzhBY3ljK2plZTVpajhEa1ZzZmhYdnlvbVlmRlpa?=
 =?utf-8?B?NWtuMERiZ1d0MkhrZkZKUXQ4UDExWG4zN2llMkdYbjEwbmJaNGtZbFdQV1RV?=
 =?utf-8?B?MWpBYUxMaGc2dDFnU1FNTVZrcjRKbFFFc1ZuZjVYNXRMc0x2a3hNZWpzNjM0?=
 =?utf-8?B?cGxRRzNvRkJQZTRvOFZHZDJnVWcyRUtjMjJZWFRqRjRiRUtLZVBpV1BYRURh?=
 =?utf-8?B?bFk0aVBvREJaNnprWjlwZ2ZTN1JvaFJJNysyakRFcXh2bVpxTFF1WkpZaUd0?=
 =?utf-8?B?RThFVmt1L1RVOGFvcy9ZNThCTzE4Z0hOTStLcU1aQ0VNVWJwd21SeFFjVGgy?=
 =?utf-8?B?MFlsdU8zS3ROak1naEtmU0ZCQzVpNDNVT0NzZG5pRFRXODlqNHBmTVhKeHpX?=
 =?utf-8?B?TzBhTi9GWkhoKy9LNU81VzQ0Wk5QVThUUFpSOTZvQmdFRW1tbDdTQms3U3Ev?=
 =?utf-8?B?YTk5WkZ1Smp4ODA4Vnlud3p6ZUh2S0ZZZEpTaW1nV280dDZqejVwQ1JCaDA1?=
 =?utf-8?B?TDZ4V3dUdkQxc2M2QUJ4cGRrdGora3VoYjBhS1BGdmdjRmhoWCtydXYrSW0v?=
 =?utf-8?B?RkxIK2xKVWVROFNZdlpjcWNESm96VENIYTVycnpTZys1YjJneG1TRGsrZGxy?=
 =?utf-8?B?cGhiR3YyZmFNbUVOa0RUOEMvQjVVa29aUFZ1MXJmQ29zWHJHcW1JanExZ2dO?=
 =?utf-8?B?d2ZlVW9iTDc3WEpjRWJ5MG9lVVFhYmJxRTN3NkhsTjBjNWtiWU9ycUhEME1v?=
 =?utf-8?B?ZEFiWHVlNm5acExmSXdFK2RrS3oreXVHenVuZFdCNTJaR3krbTNHM0QwaTBE?=
 =?utf-8?B?YTdHUVhZQmFRQnRkS1MzRUNLaFM4MEVWaWhxUHRtWWV3dlJTVTVKdzE0Nm9Z?=
 =?utf-8?B?RE5IUDhUUkRzcTZNc2puQ3VyMDJzYXFCa2tKSlljb1RnSXpQMnAxcWVJS3FJ?=
 =?utf-8?B?REIzdHBtYUswdUhtNGk2YlFxS3UvazN3V0JVWEZ1V1BGV2E1MDBWNXZEUFU5?=
 =?utf-8?B?TUdOTEdSYlFPMmxyZXdUUjh0N0FsSitTd1hRcDZaMDB4U3FDRU9vbzdxeGRK?=
 =?utf-8?B?ZXNiWHYrOEx4blVvNWNwSDd1SGZySVo4emFDd1lMd3RRL0ROaWlYZG43cFVj?=
 =?utf-8?B?akd5Q2NKZmMzWENvaHdGb3FxbmFETmN6cDFORmFCMnAyQ3ZyaXEwVUk2Rkpk?=
 =?utf-8?B?UndDYk9iTnd0anFvVDhEeGdLZUxZRVpOMmR3NXZ4WTVhQVpoVFRRVGlYallV?=
 =?utf-8?B?azVkUUErNDRsdnJJR2JHeDlpelBoVVhLYnNOMzhuVTBDaE9BNjFVQStNVTZh?=
 =?utf-8?B?UFJJbFA5SFp6cVhKVXo0eFhzaVh6MTNnbFd4UmFhcGRHZytyQ2I0TGRiTGQr?=
 =?utf-8?B?MGpnL0NDdjVGTlJzWkFwQmVFTTdPQXZPMDViWDFScE13aUhZdXJmeXBSTFJE?=
 =?utf-8?B?QlVEQUNZbDhQWC9MNlpoWVpJcm5jSERyRk1jT2RTdWNwNmpINS9va3NSa0sx?=
 =?utf-8?B?eDZTQjNmVVNWNmNPMU9YR0o5WkJXaSt6WHNVbWZYc3lXbFN1MHVFTUxGQjV0?=
 =?utf-8?B?SW1oWGpTaC9IanlrZHZVNzIwQU43Zi9wdEd0a203a2x1bVA5VDFQTzFJazZ2?=
 =?utf-8?B?TTFQRUZZWkxtY2VWcnV2UFRBYXZSOUw5SjRURFJHaFVUZ243Y2xzOW5Zaisv?=
 =?utf-8?B?eUsxUzh1S2ZSanhYV2hUdGJBdlorTlRrRVM2RmovR0N4cVJ1NXJhcDNxSGtB?=
 =?utf-8?B?c1RZWjdTcVdyRWU4STVWZGZud1NnbTY2R0hWR1B1a1l5VXhocWIvK0wreFdI?=
 =?utf-8?B?cWxxYUdjVi83MkdEOW5YTUdvbHU5akE3bmxhR2hzQU44dnJVM1o5Q1UzcVhF?=
 =?utf-8?B?Uk5GRFlPQ0VKeGdBdU12UkljUnZLdXBRcmpna3hpYldiemtlbjVTRWJBdHVL?=
 =?utf-8?B?ZU1vdkMzN1h6T09rY3ZveFVHOXVoVHYvUld2Yi9ETGE5a0lZT1JQcCtlelN1?=
 =?utf-8?B?My9pOEN1YkNvNCtFUFZjODhBKzJnRXdkOHY0MnBoaHVLYmpZMGFGVDVMYmZt?=
 =?utf-8?B?cVRxZ29IZlZjRnJsdGtudmgzd2VwajFPUzlLNTNvYTFNZ2FFcW5OVENKWmN3?=
 =?utf-8?B?YndxOWlZNUY5V3pTY1pkcWExWkNsQ2dwdHVXUEJESjk2bjltcTBZVklJVlIr?=
 =?utf-8?B?QStoNm90TzZKanRzVlZuanAxNCtuVm5HR3ZJdC9kWUJzbmFmOG1kb2p5UXFj?=
 =?utf-8?Q?Iqkf0Mt1D1kkbpBc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc8a696-b253-4a71-da7e-08da332160e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 07:39:27.8541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gHQqoj79cKUSRkxWeQtBPgmW8Lkj5W0QHoRlZ5fnRFVi0f7XE8JvMZyn2RjLaciZy6FIAN7dX8kieXZRXPotbwQqsoN8k2wsPM9LPCP4xI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6929
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
UEFUQ0ggdjMgMS8yXSBkdC1iaW5kaW5nczogaWlvOiBhZGM6IERvY3VtZW50IFJlbmVzYXMgUlov
RzJVTA0KPiBBREMNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBXZWQsIE1heSAxMSwgMjAyMiBh
dCA5OjA0IEFNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6
DQo+ID4gRG9jdW1lbnQgUmVuZXNhcyBSWi9HMlVMIEFEQyBiaW5kaW5ncy4gUlovRzJVTCBBREMg
aXMgYWxtb3N0IGlkZW50aWNhbA0KPiA+IHRvIFJaL0cyTCwgYnV0IGl0IGhhcyAyIGFuYWxvZyBp
bnB1dCBjaGFubmVscyBjb21wYXJlZCB0byA4IGNoYW5uZWxzDQo+ID4gb24gdGhlIFJaL0cyTC4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT4NCj4gPiAtLS0NCj4gPiB2Mi0+djM6DQo+ID4gICogQWRkZWQgZ2VuZXJpYyBkZXNjcmlw
dGlvbiBmb3IgcmVnLg0KPiA+ICAqIEltcHJvdmVkIHNjaGVtYSB2YWxpZGF0aW9uIGJ5IHJlc3Ry
aWN0aW5nIGJvdGggY2hhbm5lbCBhbmQgcmVnIHRvIFswLQ0KPiAxXS4NCj4gDQo+IFRoYW5rcyBm
b3IgdGhlIHVwZGF0ZSENCj4gDQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lpby9hZGMvcmVuZXNhcyxyemcybC1hZGMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL3JlbmVzYXMscnpnMmwtYWRjLnlhbWwN
Cj4gPiBAQCAtMTksNiArMTksNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+
ID4gICAgICBpdGVtczoNCj4gPiAgICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAgLSByZW5l
c2FzLHI5YTA3ZzA0My1hZGMgICAjIFJaL0cyVUwNCj4gPiAgICAgICAgICAgIC0gcmVuZXNhcyxy
OWEwN2cwNDQtYWRjICAgIyBSWi9HMkwNCj4gPiAgICAgICAgICAgIC0gcmVuZXNhcyxyOWEwN2cw
NTQtYWRjICAgIyBSWi9WMkwNCj4gPiAgICAgICAgLSBjb25zdDogcmVuZXNhcyxyemcybC1hZGMN
Cj4gPiBAQCAtNzYsMTYgKzc3LDQzIEBAIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICAgICAgcHJv
cGVydGllczoNCj4gPiAgICAgICAgcmVnOg0KPiA+ICAgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+
ID4gLSAgICAgICAgICBUaGUgY2hhbm5lbCBudW1iZXIuIEl0IGNhbiBoYXZlIHVwIHRvIDggY2hh
bm5lbHMgbnVtYmVyZWQgZnJvbQ0KPiAwIHRvIDcuDQo+ID4gLSAgICAgICAgaXRlbXM6DQo+ID4g
LSAgICAgICAgICAtIG1pbmltdW06IDANCj4gPiAtICAgICAgICAgICAgbWF4aW11bTogNw0KPiA+
ICsgICAgICAgICAgVGhlIGNoYW5uZWwgbnVtYmVyLg0KPiA+DQo+ID4gICAgICByZXF1aXJlZDoN
Cj4gPiAgICAgICAgLSByZWcNCj4gPg0KPiA+ICAgICAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZh
bHNlDQo+ID4NCj4gPiArYWxsT2Y6DQo+ID4gKyAgLSBpZjoNCj4gPiArICAgICAgcHJvcGVydGll
czoNCj4gPiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAgICAgY29udGFpbnM6DQo+
ID4gKyAgICAgICAgICAgIGNvbnN0OiByZW5lc2FzLHI5YTA3ZzA0My1hZGMNCj4gPiArICAgIHRo
ZW46DQo+ID4gKyAgICAgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgICJeY2hhbm5l
bEBbMi03XSQiOiBmYWxzZQ0KPiA+ICsgICAgICAgICJeY2hhbm5lbEBbMC0xXSQiOg0KPiA+ICsg
ICAgICAgICAgdHlwZTogb2JqZWN0DQo+ID4gKyAgICAgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsg
ICAgICAgICAgICByZWc6DQo+ID4gKyAgICAgICAgICAgICAgZGVzY3JpcHRpb246IHwNCj4gPiAr
ICAgICAgICAgICAgICAgIEl0IGNhbiBoYXZlIHVwIHRvIDIgY2hhbm5lbHMgbnVtYmVyZWQgZnJv
bSAwIHRvIDEuDQo+IA0KPiBJTUhPIHRoZSBkZXNjcmlwdGlvbiBkb2Vzbid0IGFkZCBhbnkgdmFs
dWUsIGFzIGl0J3MgZXF1aXZhbGVudCB0byB0aGUgbG9naWMNCj4gYmVsb3cuDQoNCkl0IGlzIHN1
Z2dlc3RlZCBieSBKb25hdGhhbiBvbiBteSBwcmV2aW91cyB2ZXJzaW9uLiBJZiB0aGVyZSBpcyBu
byBvYmplY3Rpb24sDQpJIGNhbiBkcm9wIHRoaXMuDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAg
aXRlbXM6DQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoZSAiaXRlbXMiIGlzIG5lZWRlZCBvciB3YW50
ZWQsIGFzIHRoZXJlIGNhbiBiZSBvbmx5IG9uZT8NCg0KSXQgd2lsbCBiZSAyIHJpZ2h0PyBlZzot
IHJlZyA9IDwwPiBhbmQgcmVnID0gPDE+Ow0KDQpXaXRob3V0IHRoaXMgcmVnIGluZGV4IHZhbGlk
YXRpb24gZmFpbHMuDQoNCkNoZWVycywNCkJpanUNCg0KPiANCj4gPiArICAgICAgICAgICAgICAg
IC0gbWluaW11bTogMA0KPiA+ICsgICAgICAgICAgICAgICAgICBtYXhpbXVtOiAxDQo+IA0KPiBH
cntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+
IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJl
eW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwg
Y29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNr
ZXIuDQo+IEJ1dCB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInBy
b2dyYW1tZXIiIG9yIHNvbWV0aGluZw0KPiBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
