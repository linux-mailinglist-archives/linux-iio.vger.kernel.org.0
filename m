Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81E853DF9A
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jun 2022 04:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347444AbiFFCGc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jun 2022 22:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbiFFCGb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jun 2022 22:06:31 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A404F9CF
        for <linux-iio@vger.kernel.org>; Sun,  5 Jun 2022 19:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTwbE4ApBnb4TfhBTJKK4Df2X7L3s6nORWxeXnr7q3VhdpZ4OYGQ69LTlQNMDzc/hNwFzYR+/Y1sUPAfcCEUKd3P7Gxud1oaCHhlW50jW8VgyKme1dSDmJxpv36wqRFbk4thb/6Ldi/0KXjDhSVJKN7o7cZc0RnUVxtddBw67S5B/3sv2DR6nBMfna94mE3uodLt0SjM0y28aaxUQ8FeC2u4CH73tIizgdXt/19N+7/vBeUVqLG3+2zFx7WAKSBlCkoGgfrk2vKBBbaVBFyYoX8tq5ukhr67SsLuJDzi+Nkrb3IsWZEr7YrgEWbEtiC9fXDWmaF9q6Dlrb6fMZu+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yg9OnkMzMHW9FQUF6id9YKJ1sU+F6xJvKowlOa1S5Y=;
 b=OMnAHx9Lqo6Wer1JBAY0jEFbfaaXxssaQuIipm3wvDKmUE6igAB4gtehWJwfdMKQItZaODoOQBd4ZCHLjkqQmqKLUyWIhM3cbYq76nxlrm9nqaDr9wR3FtsbHuCJa+FDQnzAP4N1tUdI1BulePIVozuISq6Y/3Ruboux95rQnbG/KEGAiAUGiqbZ6Vo9XgVqSAqOHuvOjanU9cesRjsQuzcE7lF1BycMGep9gvAjspsPiyD3iBGLGv3CED4Fpi5R5rdCL2H5Dsg84BLjJdyjYg+aNpn7TQlXTAExlUfgm67XiuVWgTp2FoUKmiZgZzya2R6fmMgeqbwhyfP5WGIIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yg9OnkMzMHW9FQUF6id9YKJ1sU+F6xJvKowlOa1S5Y=;
 b=VH85XrREtLQJQRSHEdV+R9dnz5Pme9l47DM7o+yJT5EkW+ypKLuPU9ZsWFqBbQmzPfpN6LqoC8kvyys6eDzITqT1banxilsfAF9nw5IFpf33xYO5vh460lhqMbXV2Ed8UEbNWIDRx7KJJ/dO6qm18d9Koeyn4yV+0eCcLJ7Qs0Q=
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27)
 by AM5PR0402MB2691.eurprd04.prod.outlook.com (2603:10a6:203:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 02:06:27 +0000
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::c0e1:c8a4:c7cd:616f]) by VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::c0e1:c8a4:c7cd:616f%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 02:06:27 +0000
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
Thread-Index: AQHYJ6hClmYnFKRpxkqcnCLeaYH3M6yfx1WAgAL+joCAADQOAICdE8SAgAI2GNA=
Date:   Mon, 6 Jun 2022 02:06:27 +0000
Message-ID: <VI1PR04MB401666B849855D77865DDA3B90A29@VI1PR04MB4016.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 3eb68b96-2ac4-409b-9c6e-08da47612a36
x-ms-traffictypediagnostic: AM5PR0402MB2691:EE_
x-microsoft-antispam-prvs: <AM5PR0402MB2691D5E88F43272FC9A6187C90A29@AM5PR0402MB2691.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gnf+IN1QJSTl8aY4nrHVFSyfTDqK8xJ//GdYACVc/ekcUyXcAgHz80rZgTaEaXZpd/2o3sCUHoiTnXU7yyk5j505wnyBujye1Xay4vgjK5LBjGFHCdzcE3/C3ki/Cz0TGo+jdp58FS1Ff+zzyMb8TNyvAV96eYWfTkmdtEG3RmhQ4QKUFBpQw5/9tZbeKQ9451me04iVAjzG873AdCMmErnGa3m+klEzyF6BKcsEAVIT6puOyUxyYBWqdc6T8EN0bTnLMahTzd9FICPJcPqnNSti0yj4xeLj8jLyN7qthSrcUnnvKxZOEZgZTzsy0pmXZ5pDMP06xoU7qMVn+YlCtvaK0uDV9abVWu1f3pkMH3jgJPnVDhvpobIH5MPE5V5sSsuOhRj1Hp0fNBF+LMK8ttA8iJ0u+uiM7FbjV1Kz4NprvsK6sXiDtN//74GvBbBqJanDZZJPNvNrC3dx3PjyeoJ+IL13PgpfCYdbvSauh0Py8JzsBpCxoY2g9Kao8t4lmSoiSAShefNMF9ztGSwNrFWRy4OyM+AJp53ZiRX5Mavs6oVT4xRUi+Iwyq68i/S9SdgOu6L/2mboaeR4mnt8jOWcBhQI/s41QNrbBwPILHUgdFlA4VSMxiKTNFUPVUwOtkIBWKZm4jgFSHIAVquxijPejxVg5ATA9B30zpEfiHCCSPGJe4v4wJCP4G1MGtECinNTC9l02UedaNPMvv8lJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(76116006)(64756008)(66446008)(66946007)(66476007)(110136005)(71200400001)(316002)(66556008)(5660300002)(38070700005)(26005)(122000001)(9686003)(55016003)(8676002)(8936002)(2906002)(4326008)(52536014)(6506007)(83380400001)(7696005)(53546011)(33656002)(508600001)(186003)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UVdXbUdGNkFuT0Rick40MGZwMHpoU3pUREdCRzcrTFQzU1ltTWU0aXFjOHdO?=
 =?gb2312?B?dlVhREVDc0tWRGVKNytOeVFVb09FTGlHYmJ2T0ZwZHpEQnl5b3Jrb3pkTVNs?=
 =?gb2312?B?Uno3THhvSDh3ZVArUjVQV2xsVm1YNmc5elhoVFY5SjAvUm5qSEhKYWtvRnFu?=
 =?gb2312?B?cXFXVFV2YnNDdXEzbjBPU2x4eGUwT1l0U0lrU1BJRERuNm5yU1JCd0IrU1k2?=
 =?gb2312?B?TFQ1SXhxYnQxejBUWTZVZ0huY2YrZ21yNHVRT2xJQStzejZtekl5RUVRc1lK?=
 =?gb2312?B?Z1FpUEVadmJhQm56ak5RRFNZeFVZQ0ZjTkh6blp4Q1pUNGxHS0M3dWQ1WUxP?=
 =?gb2312?B?ejU3NlJIbSthenlxUHdla0Zsa1VXaFFxZEsrcUxVV2JSQjQ3bDM3NHBHMkhN?=
 =?gb2312?B?cndtSVNFMzFWL091NmtjaFBJTEltc3VSd3NzdmgwRFBGV29Od21jemNxYy90?=
 =?gb2312?B?Zm85ZGp4S0ZmUW4wLzlBcThRWkYwQ0xBZS9aVHk5RC9YTjJySnJ3KzJaWEI5?=
 =?gb2312?B?VEx1Ym1vTnZVcktjMnlvTXRQZDBTcEFnWSt2c0VTamNyQTZNOXVjOGNkTjc3?=
 =?gb2312?B?b0JzeWJhK0lJUDd6L1ErU0xIczNWSUxxR1RBaUZDMHJ3aEgxRkQvREFPTERS?=
 =?gb2312?B?dnFNWE1CRzFod2dqMTZ3alJYNTlFNVVNVHFpSU96ZWpKMDNzUG5ONDU0MTlm?=
 =?gb2312?B?OTlaZnZFaUpxdkhYaENlWEY1dllXbWV0WDNSMVVHNXlSa1pkZlNFdFNTRkhF?=
 =?gb2312?B?SWU1MWNYZlpab0VvSmpuZXBHUzlFeUxmN0pQTGttNlFoNkJRWkNVRlF2Nktp?=
 =?gb2312?B?Ylh1UXNMQWtoL0RyaDBPT2V0anVSVmVhMjA4MTgrVkZ1TFpwU0d5TjkzanMx?=
 =?gb2312?B?NUxkeEpzOHlYSFNia1NZTmsvVWVDd3pCZkc1ZFNWRjJKa1hsQ3J5WUUySDd6?=
 =?gb2312?B?UFdnQ3pHR1Jzc3F4ZVVjYzVnVEJCYitZK2F1YXlpcWt0UXQ4UWt3L3U1emxW?=
 =?gb2312?B?ZDU1REhWbFRucU9EZVBjWUhPeDR6M2pFeWpWbmg0a3M2WXl6T2h6U0M5bDdv?=
 =?gb2312?B?M1dDRWhUWWhIeS9iYWw0bndCOUlibU9UT3FPQ2RWUWJmRHVDUURQWk9wSmtp?=
 =?gb2312?B?NWZGKzFQUC9JZmJxdVV2VVVVYjVqTGF3T0RYSXFpT2h2MW9DbWRZQm9aNW01?=
 =?gb2312?B?NmlXTWh2VnRQVzVEeXh5ZVpIU0dySWpXKzRaTm5HbUlLWlJBMUNyLzVOS2FS?=
 =?gb2312?B?QUZXbDQ3SUFFTUpPNUVJVW9oWElwNG9pTnMzYlZON2F4RGFUcUNHMUQ5SnI1?=
 =?gb2312?B?TFkwM2EzRURLWDFLOHdDQ3V0Yi9FQiszTm5kWVhHY1NSZHk4Q1VKNHo3dW5a?=
 =?gb2312?B?MGMySHFQdDExQWo2cFluLzA4Wnc2TzBWa3lMaDE3ejZkTmZKazk3UFM2NlJt?=
 =?gb2312?B?ZkpDdUhOSm1ITUtLMXVtcVVWc21rZWMvWkZOWXhEVGI4UUpFRURJQkc2ZUI0?=
 =?gb2312?B?aE4zcEVuS1hCYTFVTWhYeXZ0RWZYUytwU1BPZTNTQzRscCsyMlBQNGVRNHlS?=
 =?gb2312?B?QzdyNXNBdW1MRFcxOW53Tkx6ZUJpTXVmY3BBTmpmQWkyQys2alJoViszb0tn?=
 =?gb2312?B?RXlRYkpzNkNZMEZxb0cvUTg3Vzh3N09MRmttY2hUYWV4bUQ3VjdlZXNla0xz?=
 =?gb2312?B?Z3FLeVpVTEVlazkxZU80WkZ0aEx6RmliWDZXdlU0ZjhCZGVCbFJ0aXBZc1c3?=
 =?gb2312?B?cWdWazQ0SE01QkV5Vko3SStJVXBmN3RaSEdWSW83Rk5wRFNPdUFaaXVpK1Ba?=
 =?gb2312?B?Y1lnbGQ5L0piV2Z4c0ZhTFIwWUE5UmwyVU50UU1jMXBGWW9WK3JkUSsrdWxB?=
 =?gb2312?B?a2ppaWhGeXBXMXV1U1B0cGpIUnNWVFJBYXFBSkpnT2I1czJ5VjJiRHhjTHY3?=
 =?gb2312?B?bEpwby9pakhXdUpGdElTZFJib3VLTmwvNitCbkJ0Rk55azJUb3VZbENVdDFX?=
 =?gb2312?B?Q2Q1dmpqM1FlTE9EWVRzNUxzUUpRcDVjWEtKUXB2ZnVxQjdpdTRydFRIbFF6?=
 =?gb2312?B?MmlNSFF4aENzNkhXNDc2U1hoeGwvV3dFbHV4RUM3bFNYbWl6K1pMWUszK0di?=
 =?gb2312?B?cVp0eUFVUGNETWk2NFErc0RmL0RGZE1YQk5Jd0RtYUpwUkFpaWM0MUE4UU80?=
 =?gb2312?B?QjUxMzcyNHArRm92ajByd2JBL1laRjhjUTluMFZDMkx6b3RjaVJBZ0JUaEtU?=
 =?gb2312?B?VUExVGM2QVRJS0tReXUrVVAzU3lOK05ZTGdsTlloTEFiZ0RDcUFqQjYvYjJ0?=
 =?gb2312?B?NmhPeWl1ZGZrMGwxeHBDTnZqMndmSW5DSWdqNTl5ZHZLQVVTQWR0QT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb68b96-2ac4-409b-9c6e-08da47612a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 02:06:27.1499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5D9H6aZ5gcG5Kk6+jY5iNPhD9vPXm5IJrL45ZisLBoeXjOB/H6Yp2LdL/YEAcwdfkK6bp4M4cWODjgSG2g+l+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2691
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
YSBuZXcgU1RBUlQgY29uZGl0aW9uIGZvciBjb21tdW5pY2F0aW9uPw0KPiA+DQo+IA0KPiBAQm91
Z2ggQ2hlbiwNCj4gDQo+IEknbSBhc3N1bWluZyB0aGlzIGlzIHN0aWxsIGFuIGlzc3VlIGZvciB5
b3U/ICBJZiBzbyBjYW4geW91IHJlcGx5IHRvIFdvbGZyYW0gc28gd2UNCj4gY2FuIGhvcGVmdWxs
eSBtb3ZlIHRoaXMgZm9yd2FyZHMuDQo+IA0KPiBGb3VuZCB0aGlzIGJlY2F1c2UgaXQncyBzdGls
bCBsaXN0ZWQgYXMgbmVlZGluZyBhbiBhY3Rpb24gaW4gdGhlIElJTyBwYXRjaHdvcmsuDQoNCkhp
IEpvbmF0aGFuLA0KDQpHaXZlIG1lIGZldyBkYXlzIHRvIHN3aXRjaCBteSBjdXJyZW50IHdvcmsg
dG8gdGhpcyBwYXRjaCB3b3JrLg0KDQpUaGFua3MNCkJvdWdoIENoZW4NCj4gDQo+IFRoYW5rcywN
Cj4gDQo+IEpvbmF0aGFuDQo=
