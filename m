Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526FE517DEC
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 08:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiECG7T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 02:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiECG6Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 02:58:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2120.outbound.protection.outlook.com [40.107.114.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66BB1D0C1;
        Mon,  2 May 2022 23:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLVAx+RgRrCwEVDJjUTL3od1bWxEi3r9HxXG8D+YTZLd5bunT5sxpch9I1eY+X7vhaJJOU/ZjU0LyHoUCVuQPf63hf2k58ZVXB0RigDCU3vzI/eeP59TpVUSCT1PPlKLg3Ga7GeQ3ZgtWzCz0d46kmWcdNJ/Ch0poJGHJGTN5dzVV38YVht0+0lgkmsQv42lJ55WQ+VNxVs42uhtR6e/57SYOFjcECZEbN9MN82KRCvRrvhx3T1X8EpmaX14iDMOMbEOS+fKcgvoVTF8Lmd/Eeg39cvu+XMu3jtsOMob4uG8Gw0fY65eZESXJLdxDLwbd7Qp3wJdcI8yRaslS7I4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meAluhfCZ8WgSTFPeP1hiTGJWjkChNiU0coFQIbLeLI=;
 b=mJo81omE7LsSiZbQrVfoEfeQdVF3Nrl7ujwZRDRLtu2SbwSl6kANqpr9IbADwslX4CzNZHefi/CRs1jC9bU/CX5P3gu62Bikv//3pLmY3/d/ZHcw1jwLzy4Gcri0SRjHNs9FT7fIQxkKUjaXWGZzfV8Z9UKgYFPeCIC5FgU0N+5DnX6rlsj64KvzOiqeCdr3z8lz3+TsHBZIrBx6ATV005SnXB8exUVd5k3SxAmIF5Cx7vxVgKqduqjQ4JClJmpUe0yx5V2cgxEJhxv3RacCN27QjEFQNLJFuMJRJIZReC39Lq59Hz2xrXjz2Z0Hk7OJBy8X681uDvV4Y6lYJxZTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meAluhfCZ8WgSTFPeP1hiTGJWjkChNiU0coFQIbLeLI=;
 b=M9vHffW1Dshd2Qe7kq1TUQCHIWsqjGExw6l4mCnBj+JiYES9Hvd8nEES7AlZsIlBXxc8RZ5vWpOQBCdUdqAfYiy45/j55Co0KmuE+0e1X+DZXlK3MPN5rmp8RKdS6RLZmsS2uaBGYlsje2+wVKdv9XAtvtQCh5VJHjjp9w1uAZs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB4196.jpnprd01.prod.outlook.com (2603:1096:604:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 06:54:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%7]) with mapi id 15.20.5206.014; Tue, 3 May 2022
 06:54:45 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Topic: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Index: AQHYXTOfwzcIy4H/ukmJ0Fyg702b460K+rcAgAAijpCAAIpCgIABDTkAgAAC7gA=
Date:   Tue, 3 May 2022 06:54:45 +0000
Message-ID: <OS0PR01MB59222A7FAB923579C21D6B6286C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
 <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922CCDFA8C3648F49A10EB186C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWHemJn2KUBzYA8oVYgtG4sX2H=4-AdRuF0uZ2EgQEk6w@mail.gmail.com>
 <OSZPR01MB701947B40187981ACE6A271DAAC09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB701947B40187981ACE6A271DAAC09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fed1c94-8512-4d13-c3af-08da2cd1ceab
x-ms-traffictypediagnostic: OSAPR01MB4196:EE_
x-microsoft-antispam-prvs: <OSAPR01MB41963E12AC5238E8D215BC3D86C09@OSAPR01MB4196.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6FHkco33jx9dvysrTqVTguHifZg5T1UVe01OOIXVUUzqFd/bWNdC/+fYkup628RzKUS6VCqLOVR4IZpmUCCGpWcauFwDSnQW01pQB38P08Psd/OzThbJp6bGz/EOcN6FPmAQPho97KQ9RgjAKiqxg+p7Wc+txAlZiCpO5ENJzparRIgMHkkdHDajtF6OfzLQ8xmiA1wHZaIEL4L04e5/4Q5qUY96oF9rreV248aBiA8V0vcYEuD0+o8eLCBy9Wwx2riAoxbebawY6VYwuX0blRklfLr3WUvhGOglUBufJFK8x47f884/9wPdVT/fyKEXtMRlKXDc0582Mpt+tI57+9bAxb9PVbrkEnr4MQujX20JLx+z4zvvyDDrvQuxKewVLTXdl4q8m4XzXuVVmoFgotYfwZq5o2jemKl0TkCDhxZCywnU3qgHfbaNjj64TworyPst0PfIuO8Dy/1pVTRKcnJ88PwyFd25KsNNgsxKswQPaGWN+Kc3K7y8QLXwSnNqecAyAd7gWYtoDJsBUIgQyeWzyyh2iI9KenZMQh9+MSzQZNtRjsHamFiup19rfttDXEBK165wXtoGxoF4xCOahgPF7tM7+FO5T7IvKVmcJJjYdlXTdN9xM5FbEGYVmuis9KknboMpwWX79fJl8g43we9mZ8Mn1U0EPGydhYe6dNQMV1Fx2+IjVR+p2xOx6UkJ7x2DEvreIbcVbyBZPf0Pph2lDUhcJygN/rDE/zuKxiLSfppHk/Hrz/bj9da4B6ayImJMJ0Go5FO50zZ8pdajGcZ1W4kYmD5VXOWkRk2c28+AI67OTZxHJYc8UNuYrizhzTF5NHy9UwTPT7msmYBgsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(52536014)(8936002)(53546011)(6506007)(26005)(9686003)(110136005)(71200400001)(316002)(966005)(5660300002)(508600001)(66476007)(66556008)(86362001)(66946007)(122000001)(8676002)(7696005)(38070700005)(4326008)(66446008)(38100700002)(64756008)(107886003)(76116006)(186003)(83380400001)(55016003)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlZkV2dXUU9ZMDMrVEdvVkdQekxzYzg4TzNUVTZudU9DT1JORU1NTFpuZ00r?=
 =?utf-8?B?MXptVVg0VWllY2JIK2RBeTFlbnY0bmRSMzhLSVluNkd4R0hKOUlFSTE3VVFE?=
 =?utf-8?B?UytodlRXdVU5UzVSTVJ5TFYxcDBJaGtGVi9WRkNZQ3ZQMjZmS2k0OFFwOFZk?=
 =?utf-8?B?WGh3bnZ1RzQ2Nkw3aEZGL1lJSEIrZms2NjVXOTZkd3pNeVp6VzlRTkhyZXdj?=
 =?utf-8?B?ZU9wYUplVlN1b1dFWlAxUExsc3YwRFV4bzIvRDJrNFpkSml6WlltMmk2R1BQ?=
 =?utf-8?B?dVBkb3g1MmpVaVdHMVBHM1dINjVWSlRqME9pY00rTCtpRUF0TGUwTWJmdk1M?=
 =?utf-8?B?bGxZN0I4endtc2dBYTNNNWRWbVZPUWxsMlJ6cmgzL0tsNmZQSEhCTFozMlJt?=
 =?utf-8?B?QWlvaEt0bFlrWWpKcmxMLzdvWitmV0g2N2oxMGxxMEZHSFV6ZlY5V3ArREZU?=
 =?utf-8?B?ZTRFVi9GbXFFZnAxa1NhODBFMVlPcFloSStmR2JKem4vN0d3bml1amZzdC9k?=
 =?utf-8?B?ZFl4TEZxWkVSaGJaeStZY3VrUzRFTVpCaVozeFQ2M0gvWFNEbGNhTytjNUFr?=
 =?utf-8?B?bTJxYVl3Q0N6U1N0UXpwWDJNNHBNajdmaFlpUVoveU9pdUhPdkpWdkNwTkVT?=
 =?utf-8?B?M0VXOXFqcktGQnM2QURUWVZ1NTJnYUNzQlJxdnBUU3hoRW9YUWw4bHBiUk1V?=
 =?utf-8?B?S1NIMThHNkZyOXpBdjB5a2E4N3ozZ3doN011eHR5K3RhV2lhcTBtNzlKOERs?=
 =?utf-8?B?ZXJyb1dwMEpmMmpIRVBDMG82MXBvWGZkZlNvTVJOVEpFYktFMjU5Q0FBdnp1?=
 =?utf-8?B?eHp4cUNucmtweDdUVmRFNTVrZE56QlJ1M0w0UWxWZWpBNktkUm5TaHdPK0Jt?=
 =?utf-8?B?ZDVVYjdRKzZFU1ZPb2VMNFFLZFd4eC9LNGlHenA0TUlNTlErWnFRUldwRngw?=
 =?utf-8?B?L2dWOHhaRDFVSTd5NjZCZXJabmM2QnVuN0hqU3FjTnNlQk5YTzVNT2JsQ3ds?=
 =?utf-8?B?N2pVZDVjUkRjdmVUUlh1RmlGNHMrMFRpdjJCNDJnQWM3a2V4WEpJeWZYdmpW?=
 =?utf-8?B?Z0Y1OWlXakt3NFNhd0xsNW9CeXNUekFGRW5pdHpsaWV2TCtFTFRNdmNrSjlL?=
 =?utf-8?B?MGs3ZzFGdVRCNklDeklvZEZiYjZHMTZYai8xMTdJcVpaSmJCdTdFdE1USHRx?=
 =?utf-8?B?aHFjNlkrZ0VWSWhYQ0JzZ1ZjTVJEZ0FLUStzWXYxL2ZNdVdqb2s2RGZNblhV?=
 =?utf-8?B?a2pxM2lxbEhQblQ1Y0NLZFNrUGFjQUxWSEpVODhvMWllc3BMcndXSUtQWU5H?=
 =?utf-8?B?NWI0NHkyQUVHWkM5a05DaFY3K0lQQ09ZSWVZNU9OWVpSNTd6UGo3UWJJRHhY?=
 =?utf-8?B?U0ZieGJNQWpRYy9PRk5IQ0g2cjY1VGFaa3ZDYThFY1Awcm5mcWRDL3BLSTYr?=
 =?utf-8?B?S2JvUHJGRVZwRUQrT2ZOcEo1TGlJZy9jc2RDRitTUXQvMVFlZXMycXo0TlpN?=
 =?utf-8?B?eEg2UFQwR2NUeFF0cE1TZXdrVFpGRllONXI5UDNlbWlVZGVjSWFTcHMyQ043?=
 =?utf-8?B?ZFE0eThlYzQ0RG9kK3lCc1gvMFU1VVdwM0pHY2FhaFd0VUI1UUV4UHdDRnhR?=
 =?utf-8?B?UFBoYlJ5NFZaQk96Vmd6VEorZjZOMHNEd2Rqc1lyc3pUSFVxV1JvUUQwdk85?=
 =?utf-8?B?eUdMVWFoWmg1eVNsNDlackczTU8zNFVCWlMyc1BId2NkYms5ck5JdWNGQUNR?=
 =?utf-8?B?eVpLTFR6bjliT081dkJ6NmtXaXhhNm5uRUdlUllHNmFkei9NYnR1cTIvbTRs?=
 =?utf-8?B?cXNKdmlMbkdTVG1OclhtR2MyYnpBQjYzM0RmSURXcW4zRmNrMUV2d1dBMVd3?=
 =?utf-8?B?Rld5SjgvRWZPemRsRklCbVFjcjFKdnFPQ0tmTDBKSzBRV0dMNkRBcGorQWxV?=
 =?utf-8?B?SW1BajAzWGRxWnI3a2NuSUcxOFhnSGZmTEtURHNPUlhsWnVoSk44c0FwVEw4?=
 =?utf-8?B?SklkaW5JTkZmdnNZRk5ob0NwSE4waTlWOTFnSXZvR3R3NGFkc2Z6b1Y0d2NY?=
 =?utf-8?B?RW5ORXlVRWtOWklkamwwZzNyRG1TbGRzVEEvR3hTMjNvVEQyWVlzcW1pVFh1?=
 =?utf-8?B?WFNUbTI2NWpTMTZONHBBVkR6WjhZMUQ0Q1JlT1NxdFlWWkt5MEdmVGVIdXFU?=
 =?utf-8?B?MVhwUlBBdFFUdWFXWit6RVYwbXV2UjdmaUh3eHpFSHhqRFhCSEZtRnNRdVEv?=
 =?utf-8?B?VW5PVUdQb2k3Y091UG45NCtTOXpNem5KT1pvQVYvV0JtREdDOUl0TjNVNzlh?=
 =?utf-8?B?YStmYVFHdFhRSGplQjE0WWhtdU1BdDVSY3VFT0diMEM0SUM4Q1FPYXNmMTJE?=
 =?utf-8?Q?4FC+Oxw5Lex9eeOQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fed1c94-8512-4d13-c3af-08da2cd1ceab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 06:54:45.2871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/9I1Jn/wuwD3OGOO/GfVQaA5ZgPHnVk2zJxMnl+ZMP8pkETtSveD7KZTU/XEM9yrEQKM8u22+spqPULbjsaQE0nKe25N/9Q37ix2epFFjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlpbzogYWRjOiByemcybF9hZGM6IEFkZCBzdXBwb3J0
IGZvciBSWi9HMlVMIEFEQw0KPiA+DQo+ID4gSGkgQmlqdSwNCj4gPg0KPiA+IE9uIE1vbiwgTWF5
IDIsIDIwMjIgYXQgODoxOCBBTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
DQo+ID4gd3JvdGU6DQo+ID4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGlpbzogYWRjOiByemcy
bF9hZGM6IEFkZCBzdXBwb3J0IGZvciBSWi9HMlVMDQo+ID4gPiA+IEFEQw0KPiA+ID4gPiA+IFN1
YmplY3Q6IFtQQVRDSF0gaWlvOiBhZGM6IHJ6ZzJsX2FkYzogQWRkIHN1cHBvcnQgZm9yIFJaL0cy
VUwNCj4gPiA+ID4gPiBBREMNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFEQyBmb3VuZCBvbiBSWi9H
MlVMIFNvQyBpcyBhbG1vc3QgaWRlbnRpY2FsIHRvIFJaL0cyTCBTb0MsIGJ1dA0KPiA+ID4gPiA+
IFJaL0cyVUwgaGFzIDIgYW5hbG9nIGlucHV0IGNoYW5uZWxzIGNvbXBhcmVkIHRvIDggY2hhbm5l
bHMgb24NCj4gPiBSWi9HMkwuDQo+ID4gPiA+ID4gVGhlcmVmb3JlLCBhZGRlZCBhIG5ldyBjb21w
YXRpYmxlIHRvIGhhbmRsZSB0aGlzIGRpZmZlcmVuY2UuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4g
PiA+ID4gLS0tDQo+ID4gPiA+ID4gIGRyaXZlcnMvaWlvL2FkYy9yemcybF9hZGMuYyB8IDE4ICsr
KysrKysrKysrKystLS0tLQ0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiBJIHdvbmRlciBpZiB0aGlz
IGNoYW5nZXMgaXMgcmVhbGx5IHJlcXVpcmVkLiBSWi9HMlVMIGNhbiBzdGlsbCB1c2UNCj4gPiA+
ID4gdGhlICJyZW5lc2FzLHJ6ZzJsLWFkYyIuIEFzIHRoZSBkcml2ZXIgcG9wdWxhdGVzIHRoZSBj
aGFubmVscw0KPiA+ID4gPiBkZXBlbmRpbmcgdGhlIG51bWJlciBvZiBlbGVtZW50cyBpbiB0aGUg
YXJyYXkgcGFzc2VkIGluIHRoZSBEVFMNCj4gPiA+ID4gYW5kIG5vdCBhbHdheXMgOCBjaGFubmVs
cy4gRm9yIGV4YW1wbGUgb24gUmVuZXNhcyBTTUFSQyBFVksgb25seQ0KPiA+ID4gPiBmb3VyIGNo
YW5uZWxzIGFyZSBwb3B1bGF0ZWQuDQo+ID4gPg0KPiA+ID4gRm9yIG1lIHRoYXQgcmVzdHJpY3Rp
b24gaXMgY29taW5nIGZyb20gYm9hcmQgZGVzaWduLCBhcyBTb0MgaXMNCj4gPiA+IGNhcGFibGUg
b2YgaGFuZGxpbmcgOCBjaGFubmVscywgQnV0IGJvYXJkIGRlc2lnbiBhbGxvd3Mgb25seSA0Lg0K
PiA+ID4NCj4gPiA+IEJ1dCBvbiBSWi9HMlVMIFNvQywgaXQgaXMgY2FwYWJsZSBvZiBoYW5kbGlu
ZyBvbmx5IDIgY2hhbm5lbHMuIE90aGVyDQo+ID4gY2hhbm5lbHMgYXJlIGludmFsaWQgZm9yIFJa
L0cyVUwgU29DLg0KPiA+ID4NCj4gPiA+IFRoYXQgaXMgdGhlIGRpZmZlcmVuY2UuDQo+ID4gPg0K
PiA+ID4gPiBXaXRoIHRoaXMgd2UgZG9uJ3QgaGF2ZSB0byBkaWZmZXJlbnRpYXRlIFJaL0cyVUwg
U29DIGlmIGp1c3QgYWRkDQo+ID4gPiA+IHR3byBjaGFubmVsIGVudHJpZXMgaW4gdGhlIFNvQyBE
VFNJIGFuZCB0aGUgZHJpdmVyIHdpbGwganVzdA0KPiA+ID4gPiBjcmVhdGUgdHdvIGNoYW5uZWxz
Lg0KPiA+ID4NCj4gPiA+ID4gQEdlZXJ0IC0geW91ciB0aG91Z2h0cyBvbiB0aGlzLg0KPiA+DQo+
ID4gSXQgZGVwZW5kcyBvbiB0aGUgbWVhbmluZyBvZiB0aGUgY2hhbm5lbCBzdWJub2RlczogZG8g
dGhleSBpbmRpY2F0ZQ0KPiA+IChhKSB0aGUgbnVtYmVyIG9mIGNoYW5uZWxzIHByZXNlbnQgb24g
dGhlIFNvQywgb3IgKGIpIHRoZSBudW1iZXIgb2YNCj4gPiBjaGFubmVscyB1c2VkIG9uIHRoZSBi
b2FyZD8gIFRoZSBEVCBiaW5kaW5ncyBhcmUgbm90IGNsZWFyIGFib3V0IHRoYXQuDQo+ID4NCj4g
PiBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjlhMDdnMDQ0LmR0c2kgbGlzdHMgYWxsIGNo
YW5uZWxzIGFuZA0KPiA+IGRvZXNuJ3Qga2VlcCBhbnkgZGlzYWJsZWQsIHdoaWNoIHN1Z2dlc3Rz
IChhKS4NCj4gPiBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcnpnMmwtc21hcmMtc29tLmR0
c2kgZG9lcyByZW1vdmUgdW51c2VkDQo+ID4gY2hhbm5lbHMsIHdoaWNoIHN1Z2dlc3RzIChiKS4N
Cj4gPg0KPiBZZXAgaXRzIChiKSwgc2luY2UgdGhlIFNvQyBjYW4gc3VwcG9ydCA4IGNoYW5uZWxz
IHRoZSBSWi9HMkwgU29DIERUU0kgaGFzDQo+IDggZW50cmllcywgSWYgdGhlcmUgY29tZXMgYSBu
ZXcgRVZLIGJhc2VkIG9uIFJaL1JaL0cyTCBTT0Mgc3VwcG9ydGluZyBhbGwNCj4gdGhlIGNoYW5u
ZWxzIHNvIHRoaXMgaG9sZHMgZ29vZC4NCj4gDQo+ID4gSXMgdGhlcmUgYW55IChwZXJoYXBzIHBl
cmZvcm1hbmNlPykgcmVhc29uIHdlIGNhbid0IGp1c3QgdXNlIHRoZQ0KPiA+IG51bWJlciBvZiBj
aGFubmVscyBwcmVzZW50IGluIERUPyAibWFrZSBkdGJzX2NoZWNrIiBjYW4gc3RpbGwgdmFsaWRh
dGUNCj4gPiB0aGlzIGFnYWluc3QgdGhlIFNvQy1zcGVjaWZpYyBjb21wYXRpYmxlIHZhbHVlLg0K
PiA+DQo+IE5vcGUgcGVyZm9ybWFuY2UgaXNzdWVzLiBUaGF0IGlzIHdoYXQgdGhlIGNvZGUgZG9l
cyBbMF0sIEl0IGNvdW50cyB0aGUNCj4gbnVtYmVyIG9mIGF2YWlsYWJsZSBjaGFubmVscyBpbiBE
VFMgYW5kIGRlcGVuZGluZyBvbiB0aGUgY291bnQgaXQNCj4gcG9wdWxhdGVzIHRoZSBBREMgY2hh
bm5lbHMuIFNvIGZvciBSWi9HMlVMIGlmIHdlIGp1c3QgYWRkIHR3byBjaGFubmVscyBpbg0KPiB0
aGUgU29DIERUU0kgdGhpcyBob2xkcyBnb29kIGFuZCB0aGUgZHJpdmVyIHNoYWxsIHBvcHVsYXRl
IG9ubHkgdHdvDQo+IGNoYW5uZWxzLiBBbmQgYXMgeW91IHNhaWQgdGhlIHZhbGlkYXRpb24gZm9y
IHRoZSBSWi9HMlVMIFNvQyBmb3IganVzdCB0d28NCj4gY2hhbm5lbHMgd2lsbCBiZSBkb25lIGJ5
IG1ha2UgZHRic19jaGVjayBhbmQgaW4gdGhlIGRyaXZlciB0aGUgY29uZGl0aW9uDQo+IHN0aWxs
IGhvbGRzIGdvb2QgMiA8IDguDQo+IA0KPiA+IERvIHdlIG5lZWQgdG8ga25vdyBhdCBydW50aW1l
IGJvdGggdGhlIG51bWJlciBvZiBjaGFubmVscyBwaHlzaWNhbGx5DQo+ID4gcHJlc2VudCBhbmQg
dGhlIG51bWJlciBvZiBjaGFubmVscyB1c2VkPyAgSWYgeWVzLCB3ZSBlaXRoZXIgbmVlZCB0bw0K
PiA+IHVzZSB0aGUgU29DLXNwZWNpZmljIGNvbXBhdGlibGUgdmFsdWUsIG9yIGFkZCBhIG51bS1j
aGFubmVscyBwcm9wZXJ0eS4NCj4gPg0KPiBBdCBydW50aW1lIHdlIGp1c3QgbmVlZCB0byBrbm93
IHRoZSBudW1iZXIgb2YgY2hhbm5lbHMgdXNlZCBvbiB0aGUgYm9hcmQuDQo+IA0KPiBbMF1odHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51
eC5naXQvdHJlZQ0KPiAvZHJpdmVycy9paW8vYWRjL3J6ZzJsX2FkYy5jP2g9djUuMTgtcmM1I24z
MzUNCj4gDQoNCkRUIGRlc2NyaWJlcyBoYXJkd2FyZSBhbmQgaGVyZSB0aGVyZSBpcyBhIGhhcmR3
YXJlIGRpZmZlcmVuY2UgMiBjaGFubmVscyhSWi9HMlVMKSB2cyA4IGNoYW5uZWwoUlovRzJMKS4N
CktyenlzenRvZiBLb3psb3dza2ksIHdhbnRzIHRvIHRha2UgY2FyZSB0aGlzIGRpZmZlcmVuY2Ug
aW4gZHQtYmluZGluZ3MgYnkgYWRkaW5nIHNvbWUgdmFsaWRhdGlvbiBjaGVja3MuIA0KDQpJZiB3
ZSBhbGwgYXJlIGFncmVlaW5nIHRvIGRyb3AgZHQtYmluZGluZyB2YWxpZGF0aW9uIGZvciBjaGFu
bmVscywgSSBhbSBvayB3aXRoIHRoYXQuDQoNCkJ1dCBmcm9tIGRyaXZlciBwb2ludCwgc3RpbGwg
aXQgbmVlZCBTb0Mtc3BlY2lmaWMgY29tcGF0aWJsZSB2YWx1ZSwgb3IgYWRkIGEgbnVtLWNoYW5u
ZWxzIHByb3BlcnR5IGFzIA0KdGhlcmUgaXMgaGFyZHdhcmUgZGlmZmVyZW5jZSBSWkcyVUxfQURD
X01BWF9DSEFOTkVMUygyKSB2cyBSWkcyTF9BRENfTUFYX0NIQU5ORUxTKDgpDQoNCkN1cnJlbnRs
eSBkcml2ZXIgdmFsaWRhdGlvbiBvbmx5IGhvbGRzIGdvb2QgZm9yIFJaL0cyTCBTb0MuDQoNClNl
ZSBbMV0sIFsyXSwgWzNdIGFuZCBbNF0NCg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy9paW8vYWRj
L3J6ZzJsX2FkYy5jP2g9djUuMTgtcmM1I24zMjQNCg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy9p
aW8vYWRjL3J6ZzJsX2FkYy5jP2g9djUuMTgtcmM1I24zNDANCg0KaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJp
dmVycy9paW8vYWRjL3J6ZzJsX2FkYy5jP2g9djUuMTgtcmM1I24yNjMNCg0KaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3Ry
ZWUvZHJpdmVycy9paW8vYWRjL3J6ZzJsX2FkYy5jP2g9djUuMTgtcmM1I24yOTMNCg0KQ2hlZXJz
LA0KQmlqdQ0KDQo=
