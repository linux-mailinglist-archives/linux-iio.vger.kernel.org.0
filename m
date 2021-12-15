Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514ED475A01
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 14:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhLONzh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 08:55:37 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15392 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232338AbhLONzg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 08:55:36 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BF72ERG023006;
        Wed, 15 Dec 2021 08:55:23 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cxemcx7ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 08:55:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzxw5Ivk8OlVh3USm9iso6J12ewyVdWRPHfyv/yOGT1a4F76NfeAe3A0etp74OQCYWpC9Piu7dqfA4PlLEm1PUcUGC3h7QT02J25fac+L3wEx3jOMRziGa3Rl1jQ9DQER2/EFOLFqtCjX0ocxVzUS1q11I/3xQL/6D7OsMIqvlLQxRI3L10a3IW+WJRzgjc/4+M0QS0wtlJ3hpwD6lkK0YxfeSrgGmDFNItsO2bPXYwWdEsYhFXpWpUPckVJU/pII1ct7iYgiDN8atlkSL5pcQpSJIYRFyG7PKTGCvosLzcpxu/vLSgYgtwQOcijnkCqlDmw77PkueF7WUKA1ZBZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y90fsY7DfXxlYLVwTnYF3QqnYz4IaaAZfCpuazQjxJ0=;
 b=fb8/xTgV/vygVzcToOYv2/MmfUDsQR7hwjIhAe6/kurVbMWbEsl4giIIlNWhI8axi1Gh+0AUzaTLHDUmLp+OP88O7MsDTx/5IIHWP379q5iNM/ng4EOmbznhWlGJGK/fT6/kxpTfpWn4Dm0ON99sSkoBN8uKeQ+XLc0/G8soi67WsBO/AM07ZiXETgy/vIp5CXCvDG357XfBU0jAYWJy/c6iZH1DlDQVoEc0jiD9hBKd6adXEOrFw9wL8lQWMXra0xFZsJTkyegoqbpbXhOpGOCH2lj55MtEgVutqGSEzU7ia08HJsTXiKR3z2QYaPX6g8asMEV9nPdHjdUYenBd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y90fsY7DfXxlYLVwTnYF3QqnYz4IaaAZfCpuazQjxJ0=;
 b=Z77XLu7REXez4T6sB6aDO6rIANRe0jQ9cbQ68gZ4cxYmZSllXmXdTkDOpF2wleAJyf7XovFFgt6F0of9RTWEU1tGTRExg5K3LLTuh5TLr6QDPlIsitPzh5dVVOr/HCB35VQsP/WV8LVer/hLIMAnJqUXfpms7dryKi3m/fvJSeo=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6738.namprd03.prod.outlook.com (2603:10b6:510:115::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 13:55:20 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::9cf:c1e3:ea42:f47e]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::9cf:c1e3:ea42:f47e%8]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 13:55:20 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 1/3] iio: dac: add support for ltc2688
Thread-Topic: [PATCH 1/3] iio: dac: add support for ltc2688
Thread-Index: AQHX8QuhEU7uaanqVkqKIBVDF63x2qwzWaEAgAAverCAAAsRMA==
Date:   Wed, 15 Dec 2021 13:55:20 +0000
Message-ID: <PH0PR03MB6786F475B3A8FC92249D06D099769@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20211214165608.7903-1-nuno.sa@analog.com>
 <20211214165608.7903-2-nuno.sa@analog.com>
 <001b1c03-3d46-291f-e732-21514a9fd721@metafoo.de>
 <PH0PR03MB67862614BE38CEA3A5C5831599769@PH0PR03MB6786.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB67862614BE38CEA3A5C5831599769@PH0PR03MB6786.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFlUSTNZemcxWTJRdE5XUmhaUzB4TVdWakxUaGlZVEl0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHRXlOMk00TldObUxUVmtZV1V0TVRGbFl5MDRZ?=
 =?utf-8?B?bUV5TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTXpRMk9T?=
 =?utf-8?B?SWdkRDBpTVRNeU9EUXdOVEF4TVRnek5qazBNek0ySWlCb1BTSmlabGxwUlVo?=
 =?utf-8?B?cmIydHdVM2R4Ylc5UldVazFSMFppZGtkSlZUZzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVRkJlSFJhYTNVdlNGaEJVMmRWV21oYU5tSmpZM2hMUWxKdFJt?=
 =?utf-8?B?NXdkSGg2UlVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVlpKUlhadlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7175c28-c6ca-4085-da51-08d9bfd288d7
x-ms-traffictypediagnostic: PH0PR03MB6738:EE_
x-microsoft-antispam-prvs: <PH0PR03MB6738A0083CD5F8E27CE0FBFD99769@PH0PR03MB6738.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bQpjPbj3OlcMnufdgiC8H92WgZM7CADiW+C7afBAuPl9+T5v0yu5ewE0ntHnSlKHv6+QNgwMBlaOwGBBhLERVlNtV+CK9VyrZQW7gZd9dxoyJJAYiM63sEFVPW3ow04vyT1F5KM+8O7JHa53owaoYlimGSajuvGmdgtNzrAXGbzUGBKIr1HkRoI7/kTWDMyKilHl1N3k9jhp7WW+gLTQQyRBDod9tLm+tpM+gv3kF5F7/nqfuZyj46Bzsz5u+JGg9VZUM2vumk/FpBreNUJEV1gIUg5IB5j0AA0F+L5dcyp0sL06dRH137LMqEORoUwnOUza7jwj5L4iqvaPeWqv37NvSPO24NsF9ZXe7lzlYyxKifPFF4lRfeX57T/P8kMkI28HiWBt588LaePrQWK1vJyjUECu3JZZtXVMDdtICgamHl/qZDWqNRVzHWw2q+M41wtWhYkn/nI/8IwSyFB3WH0OsR6iEkscAiBfCsMn181mpUcLbYjezMV/hNnplTYG0r+RE4gJLc74OJLnhF7TK1APwRyFrTtkno3tjsoF8isXi9s3Vc1X//sY18KUl92FbouWnT5zkD6XVPmQyvfJkY2J2gcUrCErALFzT8JpDM+SygZMbb9KjUjnsAUtQgvIMfdGQmUNtmIO10mJ/TPOxmjlzpIKR8Dejf8dXCRaggywNSpiCQkCiPKeqxbNXt8wgfiEFDRkrtYsjbNU3Ro5Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(508600001)(5660300002)(316002)(8936002)(6506007)(53546011)(8676002)(38100700002)(107886003)(2906002)(122000001)(52536014)(4326008)(2940100002)(110136005)(66476007)(9686003)(186003)(76116006)(64756008)(66446008)(86362001)(66556008)(66946007)(54906003)(71200400001)(7696005)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WURtUmthUVFOZGdiVUNNbXAybWVNcDJvdDJKNWdVUkJQSE44empmcHBkNXk0?=
 =?utf-8?B?NDNCZUlKUWhUOSsvbTB5M3FVWmZCUGt2aVlTNEY4UTBhUDZ4Q3U3T2RPOUxh?=
 =?utf-8?B?a3I0OE5Nb1VCeXNuUnYraWlLZkdsTm9VUStzN0lUcEZ1UlhYQ2xjeS8zT1Uz?=
 =?utf-8?B?SGc1bHJGazRqZHdHZytZSTVyWlkwS3FVUDFIekc2a1RWMWl4SGMvZzZFQVV4?=
 =?utf-8?B?RHhodVJKUEQxNEhlbGdpbjhVVDVSeGFZQmt3VEhWVjZLUlBkQXhjd09WcjJr?=
 =?utf-8?B?em1qUUdZMUU5ZlVNaTduUHFNeTZGQXhETFFOQkJ6d2RaRWhFb3FabHJ4eU8x?=
 =?utf-8?B?N2o3UFRtaGh1WlRHelFKOE43Z3JSbHV4cFUycjJNN05wcEYvK3pmNlUxNUFQ?=
 =?utf-8?B?Z2graTBlTS9yZkxkVVBhWnVySXMzNkNFTkR0UHNXMmhHckw5NFZmbHIydytr?=
 =?utf-8?B?UTBQQmlDemlUeHBWa2d6VWlNMitrSmtpNzR1ejAyeEZ6cUNodEVBc2RWTjll?=
 =?utf-8?B?cU9yZ0UycVhnWVRnOEQ4RXNrYnJXNUNScjlrVEQ1Q2J3bnlDa0ExaEpEVHpK?=
 =?utf-8?B?dVZwYTBJVlVjOFBxeFA5djJLRFhwSE5PZityNTMvMjkrRGFrUm1hNnBETXZM?=
 =?utf-8?B?Szg5VG85eGR1aEV4d3FVZENtY1F6N1czM2NESWRlWmxPN3U2SEw4MWJ0eUxP?=
 =?utf-8?B?dEJPMTRiZWlNOWxZMkJXNG1CSXBHWVQvbWFzMGdGMGhQOHdEaFg5cGgvSTBi?=
 =?utf-8?B?d215Z3RoUTFod0hWZXpmbkZtUVBDeVQwTnRySTVWeWhDU1hlN0tGeCtncGZt?=
 =?utf-8?B?amg3OFpIRnJEcFFBOHVTRjJRTU1rTzVXNVFwRVk0M3hJa096WGE1YlR1TmZ0?=
 =?utf-8?B?VFZ1OWdtTnY1YTZaQWJkNnp5RS84blRGV29iSjlhNGJRZUo0UmFBOFUxcUlu?=
 =?utf-8?B?azZDK24xekRQbmdOb2tZdFJDVDRhLzVFVjZzQmI3cHI4NHAwdnprSWVIOU5n?=
 =?utf-8?B?RnZsMEVCcm1CSy83VXcxaFczMCtRRXFlR2lFQVk1c2dsQ0NtVHlkbDk4Q2tN?=
 =?utf-8?B?d3FsR1ZPVThrWlJmRkFSRUxCLzBqU3JDNmhjNDNVTkN0STFZeGxiNm1pblc4?=
 =?utf-8?B?M0QyOEhsaURlMkNuVDJ4S0kxRUt4VTc0MWhMSEx6eDFIN216WXhhU2RCeUgy?=
 =?utf-8?B?YncySHdWWTdycWRSV01EWmxsRWtnbnhYNTdqbXJob2w5cjUybjdhTHZyMWN0?=
 =?utf-8?B?RGhtcmZPOUVqallQT21WYytlTUI4Nk1oNjNEMmdLMzlTTllidHREd1Y4cjZ1?=
 =?utf-8?B?dzNBYUo3N3o1OGFsZUdoMG5YelJ5L3lqTS9xZHpTNzhCNC9YdmtKRDA1TWZ2?=
 =?utf-8?B?bEcyRHNwK1ViTVJQdmZwNzRDT2pDMldKc2J2R2JlTjV2d3hKY2ROL0VtK2Zo?=
 =?utf-8?B?YTlSNHBROFlINUJ1OXNVZE11UTJKUGdxMnd6OUdjN09QQXlscUhrWUtSNWRY?=
 =?utf-8?B?RW03MWhxYm5KbDhxOWxsZFg5THRoOUsyS3c3aEF3cFVlYnFweWZMOXB6L3ow?=
 =?utf-8?B?M21uMytGYVdTYUF3cGtDelpaT0pDVVdobHFzM1BJdEMxNXJZcHR2K1c3cUxR?=
 =?utf-8?B?MHJQYjlhWGdFSHJNOEtwRFJkbUcwYnFrd3dreWsyZWwwczlNK0d4NjZZYlpi?=
 =?utf-8?B?em16ZHliWm9WOEQvdXdRYTZZbTlKU25YdmtkejFGZW9nYUlMNXM4aHRtTy9n?=
 =?utf-8?B?aXB4cnJ6WGRoTlRxL0FaVVR4dTkxOEJaR3hiWlFJVUI4YTBoeEtqOXRoc2Uy?=
 =?utf-8?B?SS9NK0tZTmRweUc4bVpKb0FSRmM4Y0VDbXY4ckdBeUNTYVdYVlNsWDF1Qkli?=
 =?utf-8?B?YXZPZ3pjSGFJd2ZuRmRkU0cxakRiOVg5aTRlcHArQkxGeEhIMkM0NHNMQTM0?=
 =?utf-8?B?aXpEdTJueHlaRTNFWS9STUJDMnlid2pxWGJGbkhLb1pCUm1LM1ZEdGxLb0Jy?=
 =?utf-8?B?WmtPci9oRmJpbmFiV0w2dmZTUWxOMWdMNlFwbVVoanRTcUwrd3ZIZDNIQ2du?=
 =?utf-8?B?Nmlvd205cS9QSVIrQUk1RGFyckc3dGxGZFVaVzFXdHJkSFdqWVJROEFDdlhx?=
 =?utf-8?B?RmRKOUJ3Y0k0U1Z3OFBwWmJubUdCWkxNWGdaMm5rbWRBeEMrc1pPeU9UYUVL?=
 =?utf-8?B?b1REUVgxL0xWK25DUXRDTFU3V2crbDQvbWdMaUY5Y1E1ck12amx6dTJCZTR1?=
 =?utf-8?B?U0g2Z1hoZFIyKyswQ1NQR3FtYThBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7175c28-c6ca-4085-da51-08d9bfd288d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 13:55:20.8271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3Cq3fsxQUcP+FZYrEq3ta6G8OruTp1UGndB0W4QNg4XMVqXVDHZPRWGpKz+13+RxupjzU0kxlP6bRQ3G4uoaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6738
X-Proofpoint-ORIG-GUID: nOj_-Vd13PalpfHrOVPOJBWeSflVx7bG
X-Proofpoint-GUID: nOj_-Vd13PalpfHrOVPOJBWeSflVx7bG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_09,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112150079
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2EsIE51bm8gPE51bm8u
U2FAYW5hbG9nLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxNSwgMjAyMSAyOjQx
IFBNDQo+IFRvOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IGxpbnV4LWlp
b0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBK
b25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgr
ZHRAa2VybmVsLm9yZz47IEhlbm5lcmljaCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hA
YW5hbG9nLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCAxLzNdIGlpbzogZGFjOiBhZGQgc3Vw
cG9ydCBmb3IgbHRjMjY4OA0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gSGkgTGFycywNCj4gDQo+
IFRoYW5rcyBmb3IgdGhlIHJldmlldyENCj4gDQo+ID4gRnJvbTogTGFycy1QZXRlciBDbGF1c2Vu
IDxsYXJzQG1ldGFmb28uZGU+DQo+ID4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxNSwgMjAy
MSAxMToyNCBBTQ0KPiA+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPjsgbGludXgt
aWlvQHZnZXIua2VybmVsLm9yZzsNCj4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiA+
IENjOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcNCj4g
PiA8cm9iaCtkdEBrZXJuZWwub3JnPjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+ID4gPE1pY2hhZWwu
SGVubmVyaWNoQGFuYWxvZy5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGlpbzog
ZGFjOiBhZGQgc3VwcG9ydCBmb3IgbHRjMjY4OA0KPiA+ID4NCj4gPiBPbiAxMi8xNC8yMSA1OjU2
IFBNLCBOdW5vIFPDoSB3cm90ZToNCj4gPiA+IFRoZSBMVEMyNjg4IGlzIGEgMTYgY2hhbm5lbCwg
MTYgYml0LCArLTE1ViBEQUMgd2l0aCBhbiBpbnRlZ3JhdGVkDQo+ID4gPiBwcmVjaXNpb24gcmVm
ZXJlbmNlLiBJdCBpcyBndWFyYW50ZWVkIG1vbm90b25pYyBhbmQgaGFzIGJ1aWx0IGluDQo+ID4g
PiByYWlsLXRvLXJhaWwgb3V0cHV0IGJ1ZmZlcnMgdGhhdCBjYW4gc291cmNlIG9yIHNpbmsgdXAg
dG8gMjAgbUEuDQo+ID4NCj4gPiBMb29rcyB2ZXJ5IGdvb2QhDQo+ID4NCj4gPiBBbHRob3VnaCBJ
J20gbm90IHN1cmUgd2hhdCB0byBtYWtlIG9mIHRoZSBgcmF3MWAgQVBJLiBNYXliZSBpdA0KPiBt
YWtlcw0KPiA+IHNlbnNlIHRvIHN1Ym1pdCBhbiBpbml0aWFsIHZlcnNpb24gb2YgdGhpcyBkcml2
ZXIgd2l0aG91dCB0aGUgdG9nZ2xlDQo+ID4gQVBJLiBBbmQgdGhlbiBoYXZlIGEgZm9sbG93IHVw
IGRpc2N1c3Npb24gaG93IHRvIGRlZmluZSB0aGUgQVBJIGZvcg0KPiA+IHRoaXMuIFRoaXMgd2ls
bCBub3QgYmUgdGhlIG9ubHkgREFDIHRoYXQgaGFzIHRoaXMgZmVhdHVyZSBzbyBpdCB3b3VsZCBi
ZQ0KPiA+IGEgZ29vZCBpZGVhIHRvIGNvbWUgdXAgd2l0aCBhIGNvbW1vbiBBUEkuDQo+IA0KPiBU
aGlzIHdhcyBkaXNjdXNzZWQgaW4gdGhlIFJGQy4gVGhlIHJhdzEgcmVmZXJzIHRvIHRoZSBzZWNv
bmQgY29kZQ0KPiBvbiB0aGUgREFDIG91dHB1dCBwYXRoIHNvIHdlIGNhbiB0b2dnbGUgYmV0d2Vl
biByYXcgYW5kIHJhdzEuIFRoZQ0KPiBmZWVsaW5nIEkgZ290IGZyb20gSFcgZ3V5cyBpbnRlcm5h
bGx5IGlzIHRoYXQgdGhpcyBpcyBhbiBpbXBvcnRhbnQgZmVhdHVyZQ0KPiB0byBzdXBwb3J0LiBU
aGF0IHNhaWQsIEkgdW5kZXJzdGFuZCB0aGF0IHRoaXMgYmVpbmcgQUJJIGlzIGFsd2F5cw0KPiBz
ZW5zaXRpdmUNCj4gc3R1ZmYgYnV0IHVsdGltYXRlbHksIEkgaG9uZXN0bHkgdGhpbmsgdGhhdCBy
YXcxIGZpdHMgdGhpcyBmZWF0dXJlLg0KPiANCj4gVGhlIHRoaW5nIHRoYXQgaXMgbWFraW5nIG1v
cmUgcmVsdWN0YW50IGFib3V0IHRvZ2dsZSBtb2RlIGlzIG5vdCBzbw0KPiBtdWNoIHRoZSBBQkkg
YnV0IGZvcmNpbmcgYSBjbG9jayB0byBiZSB1c2VkIHdoZW4gYSB0b2dnbGUgY2hhbm5lbCBpcw0K
PiBtYXBwZWQgdG8gYSBUR1B4IHBpbi4uLg0KPiANCj4gPg0KPiA+ID4NCj4gPiA+IFsuLi5dDQo+
ID4gPiArDQo+ID4gPiArc3RhdGljIGludCBsdGMyNjg4X3NwaV9yZWFkKHZvaWQgKmNvbnRleHQs
IGNvbnN0IHZvaWQgKnJlZywgc2l6ZV90DQo+ID4gcmVnX3NpemUsDQo+ID4gPiArCQkJICAgIHZv
aWQgKnZhbCwgc2l6ZV90IHZhbF9zaXplKQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IGx0YzI2
ODhfc3RhdGUgKnN0ID0gY29udGV4dDsNCj4gPiA+ICsJc3RydWN0IHNwaV90cmFuc2ZlciB4ZmVy
c1tdID0gew0KPiA+ID4gKwkJew0KPiA+ID4gKwkJCS50eF9idWYgPSByZWcsDQo+ID4gPiArCQkJ
LmJpdHNfcGVyX3dvcmQgPSA4LA0KPiA+ID4gKwkJCS8qDQo+ID4gPiArCQkJICogVGhpcyBtZWFu
cyB0aGF0IEB2YWwgd2lsbCBhbHNvIGJlIHBhcnQgb2YgdGhlDQo+ID4gPiArCQkJICogdHJhbnNm
ZXIgYXMgdGhlcmUncyBubyBwYWQgYml0cy4gVGhhdCdzIGZpbmUgYXMNCj4gPiB0aGVzZQ0KPiA+
ID4gKwkJCSAqIGJpdHMgYXJlIGRvbid0IGNhcmUgZm9yIHRoZSBkZXZpY2UgYW5kIHdlIGZpbGwN
Cj4gPiA+ICsJCQkgKiBAdmFsIHdpdGggdGhlIHByb3BlciB2YWx1ZSBhZnRlcndhcmRzLiBVc2lu
Zw0KPiA+IHJlZ21hcA0KPiA+ID4gKwkJCSAqIHBhZCBiaXRzIHRvIGdldCByZWdfc2l6ZSByaWdo
dCB3b3VsZCBqdXN0IG1ha2UNCj4gPiB0aGUNCj4gPiA+ICsJCQkgKiB3cml0ZSBwYXJ0IG1vcmUg
Y3VtYmVyc29tZSB0aGFuIHRoaXMuLi4NCj4gPiA+ICsJCQkgKi8NCj4gPiBUaGlzIGlzIG1ha2lu
ZyBhc3N1bXB0aW9ucyBhYm91dCB0aGUgbWVtb3J5IGxheW91dCBpbiB0aGUgcmVnbWFwDQo+ID4g
Y29yZS4NCj4gPiBUaGlzIGNvdWxkIGNoYW5nZSBpbiB0aGUgZnV0dXJlIGFuZCB0aGVuIHRoaXMg
ZHJpdmVyIGJyZWFrcy4gSXQgaXMNCj4gPiBiZXR0ZXIgdG8gbm90IGFzc3VtZSB0aGF0IHJlZyBp
cyBwYXJ0IG9mIGEgbGFyZ2VyIGJ1ZmZlci4NCj4gDQo+IFRydWUsIGJ1dCBJIHRoaW5rIHJlZ19z
aXplIHNob3VsZCBub3QgcmVhbGx5IGNoYW5nZSBhcyB3ZSBkZWZpbmUgaXQgaW4NCj4gb3VyIHJl
Z21hcF9jb25maWcuIEFyZSB5b3Ugc3VnZ2VzdGluZyB0byBqdXN0IHVzZSBwbGFpbiAzIGhlcmU/
DQoNCkFoaGggSSBnZXQgd2hhdCB5b3UgbWVhbi4gU28geW91IGFyZSBzYXlpbmcgdG8ganVzdCB1
c2UgYSBib3VuY2UgYnVmZmVyDQoodGhhdCBhY3R1YWxseSBob2xkcyBzcGFjZSBmb3IgMyBieXRl
cykgaW4gb3VyIHN0YXRlIHN0cnVjdCBhbmQganVzdCBjb3B5IHJlZw0Kb250byBpdD8gVGhhdCBt
YWtlcyBzZW5zZS4uLg0KDQotIE51bm8gU8OhDQo=
