Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8B0462BAE
	for <lists+linux-iio@lfdr.de>; Tue, 30 Nov 2021 05:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbhK3EdN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Nov 2021 23:33:13 -0500
Received: from ms.asus.com ([103.10.4.13]:44442 "EHLO ms.asus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233263AbhK3EdM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Nov 2021 23:33:12 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2021 23:33:11 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=asus.com; i=@asus.com; q=dns/txt; s=asuscom;
  t=1638246308; x=1669782308;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g/+ElbgDSthK85onXDebira1AurruPKvcUdDuRiiwPc=;
  b=jPTuN1g92pXLHxFYiDBmpbByx+CW5YUOZqs32nwVFYH9BlWmEO3TKqYG
   RhWaVw/EuT3vUJ0u92nHGRlo4DuLo81YHUuDWKBxtRk31rOFC1rV8us73
   9fL2znD3bsA5qB8f7GxGkgYd76lXyBiLCaJ15eVOGHXDZuL1krCJtUdoD
   g=;
IronPort-Data: A9a23:6TJ726BlIqmXRBVW/3Piw5YqxClBgxIJ4kV8jS/XYbTApGwrhWAFz
 2dKCjzSO/yONmH9Kth3bYXgoRsA68PSn9c2TANkpHpgcSlH+JHPbTi7Bh6rZnvNdKUvb67FA
 +E2MISowBUcEye0Si+Fa+Sn9T8lvU2xbuKU5NTsY0ideCc/IMsfoUM78wIGqtMw6TSJK1vlV
 QTa+JW31PeNglaYA0pMg06xgEoHUMfa4Vv0imcDicVj5zcyoZW14KU3fsldJ1OgKmVd83XTq
 +zrlNlV9UuBl/sh50/Mfh8WvSTmT5aLVTVihEa6VICCriJsonc47p0wd6Q3NWJRqx7Sts9Yn
 YAlWZyYEW/FP4XwoKEwY0AGVh8nZOtN/6XfJ3Wj98WI0laun3nEmqo0Shtse9FHvLwuaY1N3
 aVwxDQlTQ2Fluuwz4WVQ+9Ej98+N4/gO4Z3VnRIl2GGU6p8G8Grr6PivcJ23ycRrdJ1MufvO
 YlCNwdCfRnOfEgaUrsQINdk9AuyvVH2dTFJ7kmVqLQ842XVzwtZ373kMd6TcduPLe1Xn03C/
 UrF8n7/DxVcM8aQoRKB83SxlqrOnCTTRo0fDvu7++RsjVnVwXYcYDU0Ul2yvfmwjAiVUtdSM
 UsS0iozpLc/9QqgSdyVdz6lpm+NuBErddNWO+Qz5QaLjKHT5kCFGQA5oiVpMYN88pVsA2B1k
 AXQ9z/0OQFSXHSuYSr13t+pQfmaaUD58Udqifc4cDY4
IronPort-HdrOrdr: A9a23:q9o+T6OjN13ji8BcTq+jsMiBIKoaSvp037BL7SFMoHNuHvBw+/
 rEoB1573HJYVQqN03I8OroUJVoKkmwyXca2+MsAYs=
Received: from unknown (HELO TP-EX16-V11.corpnet.asus) ([172.22.47.21])
  by ms.asus.com with ESMTP; 30 Nov 2021 12:17:47 +0800
Received: from TP-EXHB-V03.corpnet.asus (172.22.6.15) by
 TP-EX16-V11.corpnet.asus (172.22.47.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 30 Nov 2021 12:22:30 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (104.47.26.49) by
 TP-EXHB-V03.corpnet.asus (172.22.6.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12 via Frontend Transport; Tue, 30 Nov 2021 12:22:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2EsreagofWqPOGGryWRR4+T0p61/miCrY/ReRjYDXNHtAzLiR+s+CDKe9uEWNJx0C2XNlukhSGsRKNharRuJym01Z121oZ3u1KIC4hLC6pR7raPEAeGYX2GriTG+1b3/j9mw6gYD/E469J7vMyVgnMq/HV15e1F7JE4o+xDzf9nJHZE2Dx7TYfBrvi55P/tsJ1PV3I0dxEj+Sv7OY8ql2iYauxInqwhl5IsGmihSPBH6DAjvBBidhgBMNodjacn2+5FQnQCdyQOQ7N79ilbsikcYtzjTpPgvD1Gb6K7/2Tk2+X7POJvlmfHutF8QwRPlqijF2dbTa5Fxcs4BDIl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gLhCxv5wjwJOWmFQ2mCXNZaz3z/I0NGaBekmFNBOu0=;
 b=dB6xMXaN1GHcRHZXkiXJv8KMayWTWvcDUfNcy2uVBNaZnpJVB9YgJjxgInKBwHAHxrGzOh3tu+UcFQhH/9fi+zuZcc8/SfuamHVbQ+PIWETps1dmqJQbgJ9JWNtOB3OhL5CKi6yrXLwgY8jhPV/sZ0/0ALM/PIzIPaW4cX02dmdXDSS/93TK8Ane/JyxweHAYFO4OZ7gx1e+o1Ls9CIN31AjbaZ/NwMxNGY5/EAaf/ujsO2W/jT+TcCykNB+9+99y9HmEa6+o3Omyun4Ug7Iyk2IZcizH+GRYy+3Vg3ommgLUfFpRoxf17X1pv+qMtAoV630gamf2uZsY6LpXEw3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asus.com; dmarc=pass action=none header.from=asus.com;
 dkim=pass header.d=asus.com; arc=none
Received: from HK0PR04MB3074.apcprd04.prod.outlook.com (2603:1096:203:8b::17)
 by HK0PR04MB3492.apcprd04.prod.outlook.com (2603:1096:203:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 04:22:29 +0000
Received: from HK0PR04MB3074.apcprd04.prod.outlook.com
 ([fe80::7c61:80d6:63b9:96c8]) by HK0PR04MB3074.apcprd04.prod.outlook.com
 ([fe80::7c61:80d6:63b9:96c8%4]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 04:22:29 +0000
From:   =?utf-8?B?S3VueWFuZyBGYW4o6IyD5Z2k5o+aKQ==?= <Kunyang_Fan@asus.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kunyang Fan <Kunyang_Fan@aaeon.com.tw>,
        =?utf-8?B?SmFjb2IgV3Uo5ZCz5paH5YKRKQ==?= <Jacob_Wu@asus.com>
Subject: RE: [PATCH] iio: adc: ti-adc081c: Partial revert of removal of ACPI
 IDs
Thread-Topic: [PATCH] iio: adc: ti-adc081c: Partial revert of removal of ACPI
 IDs
Thread-Index: AQHXuHKp7ZDgW/NliESoli6Y8qOxd6vBdmQAgFpbG+A=
Date:   Tue, 30 Nov 2021 04:22:29 +0000
Message-ID: <HK0PR04MB307480DD560E45390BA4F081F6679@HK0PR04MB3074.apcprd04.prod.outlook.com>
References: <20211003162417.427260-1-jic23@kernel.org>
 <CAHp75VfduySLoeLUS0QsjVhqm7bfh9pbwreMmBYkTva7EH6jPg@mail.gmail.com>
In-Reply-To: <CAHp75VfduySLoeLUS0QsjVhqm7bfh9pbwreMmBYkTva7EH6jPg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asus.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23f05e7a-ddcf-4632-e23e-08d9b3b905b2
x-ms-traffictypediagnostic: HK0PR04MB3492:
x-microsoft-antispam-prvs: <HK0PR04MB34920CAB3F41F32199E6FF87F6679@HK0PR04MB3492.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WRSQ80jIcdmKRoiTE2IzPzW7PLMR5ew4wrUS2LVzcZZ6EGEgYvwlLxlGGr8NKg+4e+KffRzMFkz28rvCabafohHAjxVTXh0nGwQzGQJR26ft7vR3h/nxZ8DyxREPMJci97wKhFVKzRKQf16JPkbPkl2CBB/z6YFbrvwSVVM7PYejS/DZ/mEy0KL9S5z7sjPqE13Qf5vHzpgmnLmCJnc/EBDg9Y9Je2duGntSr5XtEpgGy9aY6myDSuIWuXfalF/tKSVMuNTmQvDEJnCGilkMk7/w0+yQEdapNNK/mqdFax3ZtGnbzGNZfC30eZinTgOx/byf71CwduxXmhUnhVJdUWBr1tJsy+KfhXTD1NWyB2mq1GaScgFEnRamkqJOHIGjdge5DeFQWRfn5THukCZ5RF5QAh8iu9zujl4hFkqmLZKu8+ts1z0jz5TO++92u7WSZhW7+PCTPh8YD76XllOjSMsTP7YsygwYhegkDktlKvOIbg5owXIiJ2PVyqCrgA10O69BLiFaEquWqYbrArGRsxwutI1KMQtpEXc4S3Osf6C9Us1FfnZr22Mw7D/BicKypsEfZbtPhvrMoeJGWdyMsdkNRo6gTsapss9znu88iIKmz9Lg5rZcDnBxXIDzsCzKJulZPhAubVNoJR6aFstK0E+JbyZY/SVqfsPhOn4oOCn52ZY7aQd4dPzREYpsphFh1AHBMAnzFsOKK7V0p11JMxQKxUA8K/pEnfyjZUAQDShsZfeN3osx03qglLUuqP/1onUlLPiQ4vrM0bMk3iK7oSBpnaDjh7lWDnzjg3llCQc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3074.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(54906003)(107886003)(33656002)(66946007)(55016003)(2906002)(7696005)(5660300002)(38100700002)(508600001)(52536014)(55236004)(316002)(71200400001)(38070700005)(86362001)(66446008)(64756008)(66556008)(9686003)(110136005)(8936002)(53546011)(122000001)(4326008)(8676002)(76116006)(83380400001)(85182001)(26005)(66476007)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1Y5RWJZUE5TcG1QTXJBL01pOWVpMEsrK0hiWG93TzhDQ2NOeUMxSjk1Zk5O?=
 =?utf-8?B?Q29XMm1MT01SbnJZNGJtRUlhY0E5cWl4SEhGUGRwa3lMRDFzc2grR3VaS2JY?=
 =?utf-8?B?ekRXcHBOaytieGsrd0QvZHAyZURhazF3NnI2bUJSTURMWFhKanRqVkJSSlNi?=
 =?utf-8?B?VzRwUDcxNVloakNjNUEzbTNMY1Nyb09iMGYzZmI1eTRlUlFmWmRRZCtWRVFK?=
 =?utf-8?B?WHYyVTJQWEFtUk95b2xKeHVuSjBpYU1YL3ZTQlVNcGdCUlZBTU9DcXZwZjRL?=
 =?utf-8?B?YzNUbE95NU83eGh5RTJqekRNemhoaFJNN1I4c3VlRCtJeFYxbWVBcWpHc0Vh?=
 =?utf-8?B?c01WQUtuVy9JZXUyVFR2THhhakJIUHMrN0dtTU5FUWFvbnZPRTFDL0V2T2RG?=
 =?utf-8?B?dGlWUTJqd1RNZ1ducDFiN2NzdTE4ZzU0a0g2ZTBEUmZoSkdPZmN4MndmL1Z1?=
 =?utf-8?B?ajFkaFluY29nMVprZmMzVnluWVY2akcweXA2MUlmT0pQT1g3LzFVeUtoempH?=
 =?utf-8?B?czM1Yk03SGFuLzZmL0dDSTRVVmZRaEQzY3JKYmd0ZndQY01OOGo0RW5Ec1NM?=
 =?utf-8?B?WXp5ekZGblRnNW5LQ1dkK1pNaDE0bjFnZnYvRnc2RFI1NUxQcnQ0MFUrMExj?=
 =?utf-8?B?QUdGZ2tSbmJLSmVOTGYrTzJKalVUZzJhV1BmbDYvTUlKNmlyV3R3cFBDV2FQ?=
 =?utf-8?B?cW43ZkRhNUtVVHFMbG9pUHp4YzJEZ28zK2ZYUWQwV0JaeStpajRoNmNxTEFN?=
 =?utf-8?B?dkJDSjNRajJFZGpjaDFlTk5zUEMzUmlvek1QWkZnSXZ4L1RFMjZvamtGNFFo?=
 =?utf-8?B?M3F3SnpSdFEralpOOUlocTZtV21SNjJrSzdPZUlCVVFQRnBDOERYbkxpNHJK?=
 =?utf-8?B?MjFobTV2L0NmTDl3NEJvTDhoVHZtdjM0eGFOcUtaMkFUL0U2Um5FWDFyRUNE?=
 =?utf-8?B?ZWlZU1ZTZThVOW12TjdkOEQwbXd3aGQzKzJIbVlLSWVXUmYyNWxBcHNwSmV1?=
 =?utf-8?B?blpWZ3B3Z0VweitDa0QxTk81a3dQaE15NFZnblhUT214dExKcXZ3dFBFQ25k?=
 =?utf-8?B?WDZteHRHbGQrL3ZVRjdJUjlNZThKQ1lqYWpSWWx2LzhYZW1tSlRVTXVySHVu?=
 =?utf-8?B?Z2FKbEhSL04xYlg1QU9VRFg2KzRxdDBNK0xiQldOVXkrVGd6OFd6RmR0eVB3?=
 =?utf-8?B?eG5rUko4WExwbFRWakFWSWs5VWRuRE1qbDc0VFZNQXd5UlRpV3B4SmhYSXZu?=
 =?utf-8?B?Ums4R1h4WUt3cU5jbGFlUXYwQXh6ZllPYTNRa0tYRmMrZDZPNFVSc0liNE5p?=
 =?utf-8?B?ZUpadHRrUk1obHQ1N2tYc2s4RUtCOVRpaHlJVU5kUWRBOExLVHAzREo0QkMw?=
 =?utf-8?B?anVDNUpVcmZBYkQrdVhjdmZrbmM1WEpkV2xuNE16NlFSSlVWUUJVYVZVa0k2?=
 =?utf-8?B?eC8rdERTMDYrWW9qUVRKRUZuZk8yaE5Lb2l4ZEU4OG1nZVk2ancxckdPOU1R?=
 =?utf-8?B?VWRmVlhrUC9mS3RPVWhHeWNoWmVPZjRsQlVMc0VHc0I2T0dFRDR1RTZPMGNP?=
 =?utf-8?B?UmdVaUlyT3QvbnNjajlsWUpxRUFtTGdHQXljNlJ3d2gwQ2dxdHNWcFVMb3hV?=
 =?utf-8?B?T3ZSTCtQVCtERWdWS0tJUmxFS0hpblp0TE1SS0ZsZWV5clZ3c2c5U3ljaCty?=
 =?utf-8?B?MFFnbDBvQUtrYk4vK3hJZCs5UDRnYjl3YnBodXJwV2V0U0FyblBDRi81Vkph?=
 =?utf-8?B?Y2xCanR1T0V5M21Tck5BTFRMRWpHWi9OYjN3RDliNjhxNmdRdWRsTUNBR2tq?=
 =?utf-8?B?U25CcmdNNThHSkFuSDcwZEVRSUtPQWlMNzhGTHFzekJ0clBxQkxuK2E2NnZV?=
 =?utf-8?B?WXgyNVZsMUlETXFUVW5ucFdFeldBSS9WRUp4c3dSQ3pvbU13VUFmVXZPMEdi?=
 =?utf-8?B?RGMxWVE5VXNRZlBIbXl1VzFTTjR1c2tvNkhNdkJ4ZUFXUzloQUE2dUJWQXN3?=
 =?utf-8?B?WXIwd3pKWFN5MTZaWTY1UjFBMGh6QUNFVVRtS2x4UlpobVlkdStkMzI5bkpm?=
 =?utf-8?B?L0lvVVA4ZmwvMlVKMUQvVzBDR2IrUHF4bi9jbVNpUGR5b3VlZWo4TGE3OUJy?=
 =?utf-8?B?TjBLL0ZpMnE4WDJQOC8rcUFmTHlITVNUcDE0b0xsY2I2L29TSTZmU0xwYlNG?=
 =?utf-8?Q?KER+8rYyw6GgOZfynNHG5i8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3074.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f05e7a-ddcf-4632-e23e-08d9b3b905b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 04:22:29.4147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 301f59c4-c269-4a66-8a8c-f5daab211fa3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1cYo9OMDk51iqjzJeMnHNB+JgJ5XFVg4pdow5l6T5lXhbixfSb8At7yJRS8il2DI9hoLk76dUBb5bxjO7J3wIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB3492
X-OriginatorOrg: ASUS.com
X-TM-AS-Product-Ver: SMEX-14.0.0.3092-8.6.1018-26560.003
X-TM-AS-Result: No-10--5.333700-8.000000
X-TMASE-MatchedRID: 9M69yBZ2Ml7UL3YCMmnG4n4neC0h7SADhnpDm0ThsHTgm7lSO4VWy1TN
        qf3EQ8ox4goPf9WPArrXrK/L1MjjlUPu4/hW5W83jrVn4cme+w5R3sGN+j7mNNURh96ntLOmfjc
        dX7WMS/A0mpdbUFhhs1pEx2cwDus8TmRX2WnYFMfxryc2N+6fmuvWkvu/824/qr3CBdU3C2B2UK
        6xU6n4P3SXwTI/BXkMP70MlkYPhZxvDa/I52Wry/RUId35VCIeecm5MLY/477URn+XOe/hRR+Di
        3+4QSRcupGKv0xxGEJrKrvLA7tDFADNPxu11HXj/ccgt/EtX/02n5qKMGIFlwzvg1/q1MH2i7q7
        kJ+Pw5rEDN38OU5WUpGTpe1iiCJq0u+wqOGzSV0LbigRnpKlKWxlRJiH4397ZgcslVdw9VH3zuV
        K72Vcuu6xui/yaD0EznVfAtHHYWmbmIYSfQRLOA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.333700-8.000000
X-TMASE-Version: SMEX-14.0.0.3092-8.6.1018-26560.003
X-TM-SNTS-SMTP: 0C901FB2DFC9B1889B323233FF5D1A4C58CB15E384E1C0FE65ED39A87BBB66EB2000:9
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQW5keSwNCg0KVGhpcyBwYXRjaCB3b3VsZCBhZmZlY3QgdGhlIEFEQyBmdW5jdGlvbiBvbiBB
QUVPTiB4ODYgcHJvZHVjdHM6IGh0dHBzOi8vd3d3LmFhZW9uLmNvbS9lbi9wL2RldmVsb3Blci1i
b2FyZC1pbnRlbC0xMXRoLXVwLXh0cmVtZS1pMTEsIHdlIG5lZWQgdGhlIEFDUEkgSUQgdG8gZW5h
YmxlIEFEQyBkZXZpY2UgQURDMDgxQw0KDQpUaGFua3MsDQoNCkt1bnlhbmcNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtv
QGdtYWlsLmNvbT4NClNlbnQ6IE1vbmRheSwgT2N0b2JlciA0LCAyMDIxIDEyOjI4IEFNDQpUbzog
Sm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4NCkNjOiBsaW51eC1paW8gPGxpbnV4
LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9u
QGh1YXdlaS5jb20+OyBLdW55YW5nIEZhbiA8S3VueWFuZ19GYW5AYWFlb24uY29tLnR3Pg0KU3Vi
amVjdDogUmU6IFtQQVRDSF0gaWlvOiBhZGM6IHRpLWFkYzA4MWM6IFBhcnRpYWwgcmV2ZXJ0IG9m
IHJlbW92YWwgb2YgQUNQSSBJRHMNCg0KT24gU3VuLCBPY3QgMywgMjAyMSBhdCA3OjIwIFBNIEpv
bmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPg0KPiBGcm9tOiBKb25h
dGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+DQo+IFVuZm9ydHVh
bmF0ZWx5IGEgbm9uIHN0YW5kYXJkcyBjb21wbGlhbnQgQUNQSSBJRCBpcyBrbm93biB0byBiZQ0K
DQpVbmZvcnR1bmF0ZWx5DQoNCj4gaW4gdGhlIHdpbGQgb24gc29tZSBBQUVPTiBib2FyZHMuDQo+
DQo+IFBhcnRseSByZXZlcnQgdGhlIHJlbW92YWwgb2YgdGhlc2UgSURzIHNvIHRoYXQgQURDMDgx
QyB3aWxsIGFnYWluIHdvcmsNCj4gKyBhZGQgYSBjb21tZW50IHRvIHRoYXQgYWZmZWN0IGZvciBm
dXR1cmUgcmVmZXJlbmNlLg0KDQphZmZlY3Q/ISBPa2F5LCB5b3UgYXJlIG5hdGl2ZSBzcGVha2Vy
Lg0KDQouLi4NCg0KPiArI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4NCg0KPiArICAgICAgIGlmIChB
Q1BJX0NPTVBBTklPTigmY2xpZW50LT5kZXYpKSB7DQo+ICsgICAgICAgICAgICAgICBjb25zdCBz
dHJ1Y3QgYWNwaV9kZXZpY2VfaWQgKmFkX2lkOw0KPiArDQo+ICsgICAgICAgICAgICAgICBhZF9p
ZCA9IGFjcGlfbWF0Y2hfZGV2aWNlKGNsaWVudC0+ZGV2LmRyaXZlci0+YWNwaV9tYXRjaF90YWJs
ZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmNsaWVudC0+
ZGV2KTsNCj4gKyAgICAgICAgICAgICAgIGlmICghYWRfaWQpDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PREVWOw0KPiArICAgICAgICAgICAgICAgbW9kZWwgPSAmYWRjeHgx
Y19tb2RlbHNbYWRfaWQtPmRyaXZlcl9kYXRhXTsNCj4gKyAgICAgICB9IGVsc2Ugew0KPiArICAg
ICAgICAgICAgICAgbW9kZWwgPSAmYWRjeHgxY19tb2RlbHNbaWQtPmRyaXZlcl9kYXRhXTsNCj4g
KyAgICAgICB9DQoNCkNhbiB3ZSBwbGVhc2UgdXNlIGRldmljZV9nZXRfbWF0Y2hfZGF0YSgpIGlu
c3RlYWQgKHdpdGggY29ycmVzcG9uZGluZyBwcm9wZXJ0eS5oIGluY2x1c2lvbiBpbnN0ZWFkIG9m
IGFjcGkuaCk/DQpUaGlzIG1heSByZXF1aXJlIGFkZGluZyBkcml2ZXJfZGF0YSB0byBPRiBJRHMu
DQoNCi0tDQpXaXRoIEJlc3QgUmVnYXJkcywNCkFuZHkgU2hldmNoZW5rbw0KPHA+PC9wPg0KPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NClRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyB0byBpdCBjb250
YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBhbmQgYXJlIGludGVuZGVkIHNvbGVseSBmb3Ig
dGhlIHVzZSBvZiB0aGUgaW5kaXZpZHVhbCB0byB3aG9tIGl0IGlzIGFkZHJlc3NlZC5JZiB5b3Ug
YXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IG9yIHJlY2VpdmUgaXQgYWNjaWRlbnRhbGx5
LCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBzZW5kZXIgYnkgZS1tYWlsIGFuZCBkZWxl
dGUgdGhlIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2htZW50cyBmcm9tIHlvdXIgY29tcHV0ZXIgc3lz
dGVtLCBhbmQgZGVzdHJveSBhbGwgaGFyZCBjb3BpZXMuIElmIGFueSwgcGxlYXNlIGJlIGFkdmlz
ZWQgdGhhdCBhbnkgdW5hdXRob3JpemVkIGRpc2Nsb3N1cmUsIGNvcHlpbmcsIGRpc3RyaWJ1dGlv
biBvciBhbnkgYWN0aW9uIHRha2VuIG9yIG9taXR0ZWQgaW4gcmVsaWFuY2Ugb24gdGhpcywgaXMg
aWxsZWdhbCBhbmQgcHJvaGliaXRlZC4gRnVydGhlcm1vcmUsIGFueSB2aWV3cyBvciBvcGluaW9u
cyBleHByZXNzZWQgYXJlIHNvbGVseSB0aG9zZSBvZiB0aGUgYXV0aG9yIGFuZCBkbyBub3QgcmVw
cmVzZW50IHRob3NlIG9mIEFTVVNUZUsuIFRoYW5rIHlvdSBmb3IgeW91ciBjb29wZXJhdGlvbi4N
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQo=
