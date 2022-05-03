Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DCB517FB9
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiECIbO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiECIbN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:31:13 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A74832058;
        Tue,  3 May 2022 01:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMrnSj27XTHFo/4Bwv/2TOeZq3/al+BEvbyPkX57xglzT+JiPOdrZleXs174cz9YqpgGOUBIj+2Fh4qfhbv4NKyEIqMble/DezB7SzFuoLagqVxxEBsZAyo0c9fopTHtjD1Ind3sdcNYQFESl2fGxXmm7W6mwELOBbPaqlPmcmnNwIFaH0wiH5Y4ze2Vfl8OMtYdIiYxRg2ar1UoA2+M3dhl8Uvm0eE465jvg4cEKTV4kwcjadD7ceRhV4l8AeO479ZUbSIrwmqwLAnYohFT+IMDjBUoU56krLV+jV7/grhOmb3snQfBCaDfo7zra40m3KITHCj8wx30FznImH7Gvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCb4lQR5RAxJcbJzNS7p93m53iIXqs1D5OcBaLIPgvk=;
 b=iicIP9bEKkAYbqhjQu65RnYiS5QnpmLfzv6C49Pojx6reW2KIbXzErU9jXgDHAL1MR5T9ifnHUyUQYjCa1H2EOjpMSdeBwqMHOeQEnUr2YNf9ZSCffvgvgL0wsBYeUYb65Z1l5iNmPBkogmoOiR8rv786L1HPc5Q6xNAQ0srLqkvyTNsQDfXF32CeDdwCMefzbwVLbtS+DCktVVOpuYko+2WYTWMGuVfUfk0fXt9rRH+FrhvUwgtM3ykovXjo94TxYKNki1vFj9imLSGPVxe/Jv172guDU2FUi729vqwrOFMv3KRMEn0NjErbekwW3vLGKzCqve5tR9vVNqwWAsDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCb4lQR5RAxJcbJzNS7p93m53iIXqs1D5OcBaLIPgvk=;
 b=u8d2jIuHPdN/tmpcO9l8lQWHA5Hibb1RdO+Lg+Gfz9UnqLJta28E4WPj8mA8VFNMCYQi8ILqUc1OLb7y+jkOkCsQMW4ur8BRzlnX9cmbN6cMgO23epZG7SYcwGnvP79rPr73yiJ09rWWfiKM444+aJCFtxoa2BupJ0oRa0O4idk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB2753.jpnprd01.prod.outlook.com (2603:1096:604:3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Tue, 3 May
 2022 08:27:39 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%7]) with mapi id 15.20.5206.014; Tue, 3 May 2022
 08:27:39 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Topic: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Index: AQHYXTOfwzcIy4H/ukmJ0Fyg702b460K+rcAgAAijpCAAIpCgIABDTkAgAAC7gCAAArkAIAAAkrQgAAGegCAAAEegIAAB30AgAAAZlA=
Date:   Tue, 3 May 2022 08:27:39 +0000
Message-ID: <OS0PR01MB5922D97C2701F1977F825C9486C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
 <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922CCDFA8C3648F49A10EB186C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWHemJn2KUBzYA8oVYgtG4sX2H=4-AdRuF0uZ2EgQEk6w@mail.gmail.com>
 <OSZPR01MB701947B40187981ACE6A271DAAC09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB59222A7FAB923579C21D6B6286C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdV5F9RMyKbqV=zUAhH2UZuRCoc5Y+WC_GNvG5JioMnFGA@mail.gmail.com>
 <OS0PR01MB5922BCC070E328A9B5AA6AA486C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWy9-68EUdjZOVDU-DTAYgijeUZ1u+_nGE0pVBZSX=e1w@mail.gmail.com>
 <OS0PR01MB5922EE8A730DB8A97C9CEF5086C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdVj9bshjPHeoamKE2oLmctJxNA6wnUsqr7gAVLj9xLEEQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVj9bshjPHeoamKE2oLmctJxNA6wnUsqr7gAVLj9xLEEQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a7990da-8ff9-4b6f-a812-08da2cdec933
x-ms-traffictypediagnostic: OSAPR01MB2753:EE_
x-microsoft-antispam-prvs: <OSAPR01MB2753FB7525992EE540FD684186C09@OSAPR01MB2753.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PdfjpQpeuwwHD7dIzsPTQD2zziRXTwCnt1r+uGKGsBj0nb/A8BdlWoh2I6EFfgL+jbbfkQ62ubW9x9HGefKYEMQYg+IHrOGgeg5Z5iwdHyQkiFNagREQNORfZ3ZMdeSTSTsK5WKUUIMRAjvRnsj+wawuBk/j5un/jRKXGrBjQ/GerzTOJS1cLWLcuGh6DHMX6eCZZHuswk2pY1hVDojnbJ6oFb9yhDG2ywoJXWiE7+CbUnj54FQ48W5gHWQaf5y6ZO0sBut3ENfRR2F/+tSI8L9hf7TpS7x1gwKOORCdRdhvPJix2qiF78ILkAWpDIi49PVkY9uN9JKGkdgUMUfcmz2txjHx8OAf0/Pj2NCJ5CPLVD8RJ/qi1G1iXnmtmEjBxPnie0x+Zj2NWQpjv/jghE7nlB3lsuBxHMnxBMJHlChg1NOhN+ieXUFi27/9j6k9OuZJLK8rGfCisnc8V7TkhlgEqEw4ocoukBnzkMLn0z49pLi3KpCcOO6CAzxaBEQjwkfqGm41vGcbCA+ocXB+bXSRl93Iu0Sh1MYUz1SGMtR9JCS4rj22ePfLx69lXHUq0CcgLkDA2D303h7iI1Q43tHrC8Zxbd+6biFYXXbcTiowBl2+5MdfI/6mw65IBmwkj2DtO1JMNhFEeXoKSwkspT/uxSdaNFNbUm2Hx6GstMX4eM/1codS/6lXldGvEuHwk0WVuvcfG0CFP1uPYik3/Dl1jjMuubELQks7JN6b/A8+G1yhNPdjWHM7Wu6Bq0jdMFmsQgPQ8gCOPpcm14u+rJDoWP1uFe4/ILW1RbYDtxA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(76116006)(53546011)(6506007)(26005)(54906003)(6916009)(55016003)(9686003)(52536014)(5660300002)(8936002)(71200400001)(83380400001)(186003)(2906002)(107886003)(66446008)(66556008)(33656002)(66476007)(66946007)(4326008)(86362001)(64756008)(8676002)(38070700005)(966005)(38100700002)(508600001)(122000001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkdMYk1tVWZsYWY4L0htMG1Ga2pQb2U5dnN5MXE3MUVnVExkWFc1ODBnNWFW?=
 =?utf-8?B?cWhuRDNGYzgxOHIvZGRPbEcybm5USy9ZcGhnUlJVSGV6QlJkaDZld2M5STJ4?=
 =?utf-8?B?cXZPQ1RwRDJXZUNkN0JsMVBkM05HYWc5eGdaWU80bHdtdG1xalZ6VFp6bzFI?=
 =?utf-8?B?Zml5TXVpV0UweEJKZmhFTkFxeFpRcjlwQUs4bWh1STBNTzBZM0tDVmJMaFVZ?=
 =?utf-8?B?b1p3cjRGRW1heDVLSlp5eDFqOFZnc3pIVEVZRkdlbURyY1UzNlowM1V5V21O?=
 =?utf-8?B?S3Fsd2lYOFp5cXVybkxQTzhJOXFXeUVtNDd2cE5TbEt4VFppN2pGSUlQZkdY?=
 =?utf-8?B?WWNhK1c2RnVjRmJUbzczQzAyZTJnS01yYzJIUGlLQUVST3hESkEwNllEcWxu?=
 =?utf-8?B?YVBPU0FRT3JXUzZGcFdadkVja0lKcHBoOVJkNWtaNHZSWG5LWHM2cGR4WEt3?=
 =?utf-8?B?SkxRZ0l6VlNiVHFBMGoxczNlQlN3eGpHRnZxcnVrNW1iTmxOWkxFaHlEVmZK?=
 =?utf-8?B?c2FoUmVNVjJXWlJKUU9GVFpoVzBXNHdmL3dTM0paVEhxNjc2QWdYczJ4aElK?=
 =?utf-8?B?WVNMR3B4elhnQ2Z0WGVPaHFLSzltMzJJL0NjNGluSEg4WndMOTF6SEdiU2or?=
 =?utf-8?B?NGNMVHZkMzBSZWN6dXJzbE5XNVJra255YXpQVG11bm83T0FEbTVXajlKWVZk?=
 =?utf-8?B?Z0N4WXM3M1NBN3ZvZG9mY0JUR3hmRWtNZFhrOXJDK3cwejlFbnlhRnFCRklO?=
 =?utf-8?B?bXBLWlI5RkM5cForVExRWXBMVXJ0eUlVVVdWb01iSTBMTEdScDRSUm1kc0ta?=
 =?utf-8?B?MXpOWld6cUZVNkpnWW5LbktrRmkzR1RiM2thb3kzamY2OW4vbHVMdlhXZE1a?=
 =?utf-8?B?aFdpcUdQQmo4Mm93Um1ReElEWnZZU1VGcVJ4bWorUGdnOTM4T3ZrYmtqd3Ra?=
 =?utf-8?B?VWlBSlNYWUVPWWdYMWxFT1pYNEFrd1RtVlo4Wk1HeTJQbXlGMmRvSTNoaDVt?=
 =?utf-8?B?V21rUW5pNlpxSG9kS05Pdkc4a3BreWJsZXdiRFhTeXdQS2lPZlNsRUpwcTcr?=
 =?utf-8?B?cE5yNkc1dm1JLzN4blQvdTA2L2Q0TlJJbGpOZ0xIMFBrOTE3emZiSjcwSHN0?=
 =?utf-8?B?WUV5UjlCRVlhWEhxL1FMekh1d2RVdktLb2RGVWsxWU5vVDlQQ2tuVXZjMDdQ?=
 =?utf-8?B?Nkg0a3pOTDNwMEU5bTRCckl0d0xHS1orbnFaQWo1bHRwMnJXTmIrMDNBdkhK?=
 =?utf-8?B?R1JBNWxkWFhvYXZ0ZmJqT1phdmY5K1BEbWR3N2t5cWpjKytuQ1ZoeVozRGxJ?=
 =?utf-8?B?amplT1Q5d0RmMG5qdWExeUN4ODhYczMzWlJZMG9aekZONXFRSFJrWGMzM0th?=
 =?utf-8?B?Qm5DeFZkaEFFS3hkdWw4aWtqZ3VpQ3lJcDNvY0pYM0dCUmErVHIrZUlHQ3pC?=
 =?utf-8?B?Zk0rNmlUZnFEaTRPV215Q3VSa1ZFWVdxNnhYMTNuWVhEMTlnTE04TzJnaFRC?=
 =?utf-8?B?YTJmcnd6aHhrSDVaNFRsQW9yUE5lV2I0bmMyUUpFdUlPVlRmZXJieGFEYXJa?=
 =?utf-8?B?MjhqcHVsN1hWNlJZQzlsY2hGdWZ1Ym5td0pjL1NqV0VXNjFTR09MZWpmM1pU?=
 =?utf-8?B?QStuVGlXMmhuT2RsS25qclBtM21uaURKRk1FTzkvaHQrNVBhajdjVjFDcEs2?=
 =?utf-8?B?eWh4Z0EvY1crcHFNMkVFSW9aSkxGZkkwTmdOZEFVUk4reEZTMHZFVmlUaitP?=
 =?utf-8?B?R1FiekVLVFZhMWlOY3B0amtUNjZRUGxhNWFvanFxT0hFbGVjdnJrQzNVSC9l?=
 =?utf-8?B?MnpmZGFwaXhhQkwzTjR4QkNrb2JJY3oxTnBWMzdjakliUVRiRXJESzdTR2hj?=
 =?utf-8?B?ZWIrZ1RIRDBNNU14SE1DakRoZ0lWSWw4aitMMFlLZlZqMHM4cTRYNXdta3JO?=
 =?utf-8?B?bjVnTlpEWWNZcjR4RXN1czRjY3E5K2F0aDlSNmpCVWpZcHBPeHpTWVcwUDdK?=
 =?utf-8?B?YnpLbVF5NVdnWHI0OWNjaTNaQmYrZytLYS80Z1ZCY3F6Yk42VUxlRURqekcv?=
 =?utf-8?B?UXpTRzlSbjY0MHVRQ3BId0dOd2RxWjdseDAwOWRhdlR2N2VJTlJEaHNTcThQ?=
 =?utf-8?B?bzN4VkhlOEEvVmRDVy9wZ2diU0h2QTZVT2w2S2Zob2l0RHk0RlRhSGdhNkt3?=
 =?utf-8?B?L1hRNEhTbldGamxBazcrMzRBRVVwVktZbitKS0dOUkF0WU9lSEphYTJDNTIx?=
 =?utf-8?B?V1pYVnluT2R3TXZwVXFxbUs3Z2l3T2JrVHNWZXl2bVp2TDE1ZWJNM05TamNJ?=
 =?utf-8?B?U0szVFJQcXoxRnJYdWxWampjNHBTaVlyWUppMVdPbFZCVFQ2eVRrcVNjNnZY?=
 =?utf-8?Q?RSvtUQAAeantUfXc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7990da-8ff9-4b6f-a812-08da2cdec933
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 08:27:39.5689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOiIY6/ZI7FLEJSioMTLzxtVSVfhRMh13Qtaevaie14Tb0tUclNjocYvcj5ILpHK4bguEOgb0fF7zpCbU0Ztq/Eu3LsrnbXABj06RPpWO9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2753
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaWlvOiBhZGM6IHJ6ZzJsX2FkYzog
QWRkIHN1cHBvcnQgZm9yIFJaL0cyVUwgQURDDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gVHVl
LCBNYXkgMywgMjAyMiBhdCAxMDowNSBBTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNh
cy5jb20+DQo+IHdyb3RlOg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gaWlvOiBhZGM6IHJ6
ZzJsX2FkYzogQWRkIHN1cHBvcnQgZm9yIFJaL0cyVUwNCj4gPiA+IEFEQyBPbiBUdWUsIE1heSAz
LCAyMDIyIGF0IDk6NDcgQU0gQmlqdSBEYXMNCj4gPiA+IDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlpbzog
YWRjOiByemcybF9hZGM6IEFkZCBzdXBwb3J0IGZvcg0KPiA+ID4gPiA+UlovRzJVTCBBREMgIE9u
IFR1ZSwgTWF5IDMsIDIwMjIgYXQgODo1NCBBTSBCaWp1IERhcyAgVGhlc2UgY2FuDQo+ID4gPiA+
ID5iZSBkcm9wcGVkLCBhcyBkdGJzX2NoZWNrIHNob3VsZCB0YWtlIGNhcmUgb2YgdGhhdC4NCj4g
PiA+ID4NCj4gPiA+ID4gT0ssIFdpbGwgcmVtb3ZlIHRoaXMuDQo+ID4gPg0KPiA+ID4gQWN0dWFs
bHkgaXQncyBPSyB0byBrZWVwIHRoZW0sIGFzIHRoZXkgYXJlIHRoZSB1cHBlciBsaW1pdHMNCj4g
PiA+IHN1cHBvcnRlZCBieSB0aGUgaGFyZHdhcmUgYmxvY2suDQo+ID4NCj4gPiBZb3UgbWVhbiB1
c2UgdXBwZXIgbGltaXQgb2YgMiBmb3IgUlovRzJVTCBhbmQgOCBmb3IgUlovRzJMLCByaWdodD8N
Cj4gDQo+IE5vLCBJIGRpZCBtZWFuIFJaRzJMX0FEQ19NQVhfQ0hBTk5FTFMsIHdoaWNoIGlzIHRo
ZSB1cHBlciBsaW1pdCBvZiB0aGUNCj4gaGFyZHdhcmUgYmxvY2suDQoNCk9LLCBUaGFua3MgZm9y
IGNsYXJpZmljYXRpb24uDQoNCj4gDQo+ID4gRm9yIGVnOi0NCj4gPiAgSWYgd2UgdXNlLCBDaGFu
bmVsMCBhbmQgY2hhbm5lbCAyIDotIHRoaXMgd2lsbCBiZSBjYXVnaHQgaW4gZHRicyBhcw0KPiA+
DQo+ID4gL2hvbWUvYmlqdS9yemcybC1saW51eC9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaWlvL2FkYy9yZW5lcw0KPiA+IGFzLHJ6ZzJsLWFkYy5leGFtcGxlLmR0YjogYWRjQDEw
MDU5MDAwOiBjaGFubmVsQDI6cmVnOjA6MDogMiBpcw0KPiA+IGdyZWF0ZXIgdGhhbiB0aGUgbWF4
aW11bSBvZiAxDQo+ID4NCj4gPiBCdXQgZm9yIHJ1biB0aW1lLCB3ZSBkb24ndCB3YW50IHRvIHRo
aXMgdG8gaGFwcGVuIGZvciBSWi9HMlVMPz8NCj4gDQo+IEl0IHdpbGwgYmUgY2F1Z2h0IGF0ICJt
YWtlIGR0YnNfY2hlY2siIHRpbWUuDQo+IEFuZCBhdCB0ZXN0IHRpbWUsIGFzIGl0IHdvbid0IHdv
cmsgYW55d2F5IC0tLSBkbyBub3QgcG9zdCB1bi10ZXN0ZWQNCj4gcGF0Y2hlcyA7LSkNCg0KT0ss
IEkgd2lsbCBzZW5kIFYyIHdpdGggdGhpcyByZW1vdmVkLg0KDQpodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2
ZXJzL2lpby9hZGMvcnpnMmxfYWRjLmM/aD12NS4xOC1yYzUjbjI2Mw0KDQpSZWdhcmRzLA0KQmlq
dQ0K
