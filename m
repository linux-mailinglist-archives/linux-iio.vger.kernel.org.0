Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990864630D9
	for <lists+linux-iio@lfdr.de>; Tue, 30 Nov 2021 11:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhK3KUH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Nov 2021 05:20:07 -0500
Received: from ms.asus.com ([103.10.4.13]:56751 "EHLO ms.asus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhK3KUF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 30 Nov 2021 05:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=asus.com; i=@asus.com; q=dns/txt; s=asuscom;
  t=1638267130; x=1669803130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AwGUZ7iwhBongLWMVQftIwpLomqQBhhwbgQmPb3iIsI=;
  b=RKILjlloFRAgZKSO/8csbe9AEd9RqDLUF3SPeSPKngFXvJzsDfo/Heb7
   egegcIZ724ETg3Dsb3wR3P2QnGOR2G3AwUY94x9T7ZvKwU1xkXiwgueuE
   ObT86O3lAsuuKh7Fncj5iKW2YcYmG5vgfXf75OETcAxl/S4SSTiCokiN5
   c=;
X-IPAS-Result: =?us-ascii?q?A2EjAAAW+aVh/w0GFqxaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?YE8BwEBCwGBUVFpFVhqhEiDRwOEWYVugwIDiwWBCo5/gS4UgWgLAQEBAQEBA?=
 =?us-ascii?q?QEBBwEBNQwEAQEDBIR9AheCaSY0CQ4BAgQBAQEBAwIDAQEBAQEBAwEBAQUBA?=
 =?us-ascii?q?QEBAQEFAwEBAQKBGIUvOQ2CNSkBdIEIAQEBAQEBAQEBAQEBAQEBAQEBARYCC?=
 =?us-ascii?q?FJMAQEdAQEBAQIBEhERRQUHBAIBBgINBAQBAQECAiYCAgIfERUICAIEAQ0FC?=
 =?us-ascii?q?BqCUIJVAw4hAQ6Tco82AYE6AoofeoExGmeCFASFCg2BIoEhBgkBgQYqAYFlh?=
 =?us-ascii?q?UaBHoFggw17glAmb0OCNzA+giFCAYEsARIBIwUQFQwCgl43gi4EkAETgTkQW?=
 =?us-ascii?q?iAJLysVNRsRD5IyAUKDI6hCaA2CV2CZGoJVgzMVg22Ld4YzA5EXkHWFIR+QI?=
 =?us-ascii?q?ZVMAgQCBAUCDgEBBoE+I4ElcDM9gzlRGY47FoEqgiaKXkIyOAIGAQoBAQMJh?=
 =?us-ascii?q?Q+LYAWBZF0BAQ?=
IronPort-PHdr: A9a23:D1iyxRxKZYA4epbXCzLfzFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 hWZu6wm1QWBdL6YwsoMs/DRvaHkVD5Iyre6m1dGTqZxUQQYg94dhQ0qDZ3NI0T6KPn3c35yR
 5waBxdq8H6hLEdaBtv1aUHMrX2u9z4SHQj0ORZoKujvFYPekdm72/qz9pHObAlEmSSxaq5uI
 RurqgncqtMYipZ4JKYrzRvJrHpIe+BIym5tOFmegRXy6Nqu8ZB66yhftO4v+MBGUaXhYqQ3V
 qdYAyg8M2A0/8Lkqx/ORhaS63QGU2UWlh1IAxXZ7Bz/Q5z8vDf2uvZ71SKHJsD9U6w6Viq+4
 KdqUB/oiTkINzgl8GHMl8d8iLtXrA+9qxBjxoLZZpyeOvhjcaPHZd4URXRPUNtNVyJPAY28Y
 YkAAPYOM+lXtIT9u0ABoQeiCQWwGO/iyDlFjWL2060g1OQhFBnL0gk9H9IIsHXbttP1NKgPW
 u611qbIyzHPbfVQ2zX77YTDbxcsr/SRXbJ2ccve008vFwzdgVuQs4PlOSiY2f4Ws2iG9OpsT
 /6gi2kiqwxopDWk28gjhJXTiI0P1lDE6Tt2wJwzJdCgR0B1Yd2pHIVSuiyZOIV7XMEvTW52t
 CskxbMLu562cTQFxZon2xLTdeGLf5aL7x7+W+ucJSl1iG54dL6hmxu/9U6twfDyWMmz1VZFt
 CtFkt/Uu38XzRPc9M+HSv1n8ki93jaP0gbe4fxHL0AsjafXNpwszqAqmpYNr0jPBC77lF/rg
 KKYbkko5Oml5/jpb7jju5OQK4t5hwD7P6gwhsCyD+E1PwsVUGWe/Omwyb/u8EvkS7tQlPI2i
 LPWsJXCKMQeoa62HhFa35446xa6EzemyNMYnWQbLF5deBKIkYzpO1bWLf7mF/mzmluinzZpy
 f3bJ7HuDYnBImXZnLj9erZ98VZcyAwtwtBD/Z5bEKoBIO/oWkPptdzYCAE2MxCszur6Cthxy
 JkSVXyRDqODMa7eq0KE6+w3L+mJfoAVuTL9K/Y/5/7piH80gVoTfbSv3ZoXcn+4GPtmLF2Zb
 3X2hNcMCn0FvhEjTOzxklGNTTlTZ3OqU6Im+j47EJ6mDZvERo21hLKB2yG7EYdKZmBGEF+MF
 23kepueVPcJdi2SOMhhkjofWLihVo8uzx+vuxH7y7Z9MuXU/SgYv4r51Ndp/+3TiQ0y9TtsA
 suH1WGCUmF1knkTRz82wq9/v1Byyled3qh+gPxYEsde5/xMUgggNJ7cy/Z2BMz1WgLEZt2JU
 kqpQs26ATEtSdI8290OY0dhFNm8gB3OxCmqDKEPl7yNGpM09rjQ33/rJ8Zy03zGzrUuj0E6Q
 stTMm2rnqp/9wnVB47UnESVjqeqdaUb3CPW6meDwnSBvFtCXA5zT6rFR3YfaVXSrdjj4UPCV
 bCuA6w9MgRd0c6CNrdKatrxgFtDWffjPtTfbHi3m2e/HRmGxqmDbIzxdmoHxirSFk8EkwYJ8
 XmaMgg+Az2to37QDW8mKVW6QUTq+PV+oXXzZUYxwhuNaQU19b2z8wIVjPraYPoW06gDvg8Bt
 jxrEVf71NXTXZ7Ijgxtbe1nYd4j61dK02He/1h0OJCxabtii0AVcwlxvETG2BB+C4EGms8v+
 iAE1g13fIGF1kJIcTzQ85n2ekUv0ii6qDOybb/f3F7p/t+Q0q4U9e9+oFLm6lL6XnE++mlqh
 oEGm0CX4Y/HWU9LCcqZug4f+xt7ouTcZS8wr8PR2GZ3OKa5+jnFx5oyBeQjxxrhGrUXMK6NG
 ALoVcFPAc+oJb8mnlGzZUcCO+ZfvKc/I8Khca6A36imdOZtlT6rlyJJ+od4h0uX6jE6QenNj
 P44
IronPort-Data: A9a23:z2I61aOE/iiAB8TvrR3+lsFynXyQoLVcMsEvi/4bfWQNrUp21TJWz
 jYeDDjXO6qNZGOhfNFzatyw9EIO7JfdxoU3SQZtpSBmQlt08seUXt7xwmXYZnjLdpKZJK5EA
 2fyTvGacajYm1eB/n9BCpC48T8kk/jgqoPUUIYoAAgoLeNZYH5JZSxLyrZRbrFA3IDR7zOl4
 bsedOWEYDdJcxYtWo4lw/rrRCFH5ZweixtB1rAKXs2niXeF/5Uj4DLzEonqR5fwatE88udX3
 I8vxpnhlo/S109F5t9IDt8X26DFK1LfFVHmt5ZYZ0StqjJB/Tco7plqCKU/YGAPiAjRxNQu2
 OwY4PRcSS9xVkHNsNglFjRoMws7A/UfvrTAO2C5vNDVxlbbaBMAwd03UxtwZ9depKAuWgmi9
 tRBQNwJRjOegfO/xr2MZOBqrs04MdKtN4Qa0p1l5WuGUqx9H86cK0nMzdkf/wU/hu5nJqudO
 PoAbWtMQB/DOzQabz/7D7p7xo9EnELXUTpeoU6VrKxxyGHWwRZ21pDtLdPKd93MTsJQ9m6Ro
 G7XuX/5Dw8RNNGZyj2t/Xelh+uJliT+MKoQFbbirdZpjUeVy2hVDwcZPXO/oP+kmgu/WtV3N
 UMZ4GwtoLI0+UjtScPyNzWbvXiVtxgTbPRZFcUz4QyKzOzf5APfGndsc9JaQIV57olsH3p0k
 AbS9z/0OQFSXHSuYSr13t+pQfmaYED58Udqifc4cDY4
IronPort-HdrOrdr: A9a23:wpU1IqADXLL1rIflHelb55DYdb4zR+YMi2TDj3oBLiC9Afbo8f
 xG/c5rpyMc5wxhO03I9ertBEDEewK5yXcX2/hlAV7BZniFhILAFugLhuGO/9SjIVyaygc079
 YVT0EUMrPN5C1B7foSlzPYLz9P+ra6GeuT9J7jJj9WPHlXg2sJ1XYCNu5ZencGOTWvf/ACZe
 WhDpEsnUvfRZzTBv7LekXsm4D41qz2fFWPW293O/cI0nj0sdvngoSKYCSl4g==
X-IronPort-Anti-Spam-Filtered: true
Received: from unknown (HELO TP-EXHB-V01.corpnet.asus) ([172.22.6.13])
  by ms.asus.com with ESMTP; 30 Nov 2021 18:12:08 +0800
Received: from TP-EXHB-V03.corpnet.asus (172.22.6.15) by
 TP-EXHB-V01.corpnet.asus (172.22.6.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Tue, 30 Nov 2021 18:16:41 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (104.47.124.55)
 by TP-EXHB-V03.corpnet.asus (172.22.6.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12 via Frontend Transport; Tue, 30 Nov 2021 18:16:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMQ/DQHJHAdp2QgXjrQmutHxPdDdKbjT31wqSc8l7+mZ9aLFgVJA0NL+zDYKv1Ifus9cJhuqD40yksu1A5JqCZ0D/mlij0iYfdZ/+Z5T9UEzFKVsAUq5YID0V3FAJyKqWPXs+ZzREoCjonsw0DH4lCTE7qo265catpE/d67E8V1KDo8qWVBRn2CDDlfyVzYuqSHYTqDJKJo+SFWL39YifIoU/QXLH8ztN7hEYxdPYbReFIQkOrYWlRNOg8HI3+t8K5qK8n7d6OqVMPGFeYJJVgDXpvTk2f1RpywvETkxhaXmOLlut5LfUesHUYf674wj6urRclkJOdXbTCFyZ5IBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YGRar/P4rxlTsAfZWQL7aTcV15UJhqxAXA8G0kStLc=;
 b=UnsRfUz2bSPrVWXKE8hHeaqBoijaxpqU+XFeTzLLMbbZcMk5HpmT775Kd/h0IAImUnI3YGdECDVIMJ7EOLMZp8VD7ANB2nBey9D2oV6O7xQwZNZjzfBrNO6LwHFw/hRS4zCH0TEKkMy+wUW7NghBxbdWQg7DNcRILVa+FW7+4AoqGcGaUjUK5qBS78tL3+F2IuamXnxZGxycBgv3IqmrvTkNe+ht6drpRBH8xpZ+Am0KZylfekOAqBk3IFANTLekobPJg6ey2cjYN91p+dHuPkyQgYhIB12Z9Up2l/EUXHy/Fj8aTgEYNClHj2l8mDgv3Yi9fUatCc6wG0G8HjkS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asus.com; dmarc=pass action=none header.from=asus.com;
 dkim=pass header.d=asus.com; arc=none
Received: from HK0PR04MB3074.apcprd04.prod.outlook.com (2603:1096:203:8b::17)
 by HK2PR04MB3764.apcprd04.prod.outlook.com (2603:1096:202:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 10:16:39 +0000
Received: from HK0PR04MB3074.apcprd04.prod.outlook.com
 ([fe80::7c61:80d6:63b9:96c8]) by HK0PR04MB3074.apcprd04.prod.outlook.com
 ([fe80::7c61:80d6:63b9:96c8%4]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 10:16:39 +0000
From:   =?utf-8?B?S3VueWFuZyBGYW4o6IyD5Z2k5o+aKQ==?= <Kunyang_Fan@asus.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Kunyang Fan <Kunyang_Fan@aaeon.com.tw>,
        =?utf-8?B?SmFjb2IgV3Uo5ZCz5paH5YKRKQ==?= <Jacob_Wu@asus.com>
Subject: RE: [PATCH] iio: adc: ti-adc081c: Partial revert of removal of ACPI
 IDs
Thread-Topic: [PATCH] iio: adc: ti-adc081c: Partial revert of removal of ACPI
 IDs
Thread-Index: AQHXuHKp7ZDgW/NliESoli6Y8qOxd6vBdmQAgFpbG+CAAFtKgIAAB1gAgAABGnA=
Date:   Tue, 30 Nov 2021 10:16:39 +0000
Message-ID: <HK0PR04MB30749C7A0F46357BD0650D19F6679@HK0PR04MB3074.apcprd04.prod.outlook.com>
References: <20211003162417.427260-1-jic23@kernel.org>
        <CAHp75VfduySLoeLUS0QsjVhqm7bfh9pbwreMmBYkTva7EH6jPg@mail.gmail.com>
        <HK0PR04MB307480DD560E45390BA4F081F6679@HK0PR04MB3074.apcprd04.prod.outlook.com>
        <CAHp75VcfcG55FB7uRKozKUnb6ZGQ_v=L71bTND5+5vcjgQaBOg@mail.gmail.com>
 <20211130101034.00001827@Huawei.com>
In-Reply-To: <20211130101034.00001827@Huawei.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asus.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d46ecac2-2b03-43de-f925-08d9b3ea7fe9
x-ms-traffictypediagnostic: HK2PR04MB3764:
x-microsoft-antispam-prvs: <HK2PR04MB3764CFC6B5B3BF3C0EED95BEF6679@HK2PR04MB3764.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RjI68uHK9q/2P3pyNkDsPTx/tIu74SvzgomfXbfUb+eguVSETlzlj3wuIONPeHNqPBjOA0JeCfIjwUmHjOAjJi+9hC1sC+1kSWSSf9IWLpuxe/HCjWIzfNLKHhhlpebaxyKRLX8kBQgqhWNnLFv+TDas4AqDwEIIjD6ckV7C3e3H8b6sGZWUqBzerfI7s1NnZzqBKEHf3uAZFCZwxaYaNVvYCitXEeJWr6vEsCJetTR1hLjySC+ScPR8L9iujhIYdVf+Va3uZRcPwiJHNsP5ddSyyi5bgdm1gIQ5iRgRwqFJ9BO7cINL8rME6t0w3vY9sdPt7y7TAVm2hz/AH7/dcvkwc6iDvk+RpnyVu33k2t33hyzUfzX2Modi3N3j+YPBftwwIi2NgkAaenmpMyIJ1ll4IeKvEYJ75zZ1mkL2jPDno3DXiJ3p1Vfd8a9WYtDOrMx/IClm07lG0fuLUvjAPpO1QecuKZgR3jwucUqoybaIEFsibbUtkS9VSXnbssxY0x4tOKupCUQ15TlsdWQMzMBYPFuFm2wVX8OfEtb0Zy5jJJ19xOJB27M1Vqhuup4Y7eM5L+KiiN7SNNJAJgUP485gqY0D3NVEfYdJ0XlspAIISDD3gkaQT8/ZsQF1pRUAIz9gahN0IVdHhjdKPByOshIwP8O4hc4+d3POUMOMQwNvC3HbPIf5tzLX9xHnGh9khjuAVaZ0h2i99p0+ciAKaP7hc1iXuF75hF78wWn09rSrjPQ3M9Iyx44XyDyZLZ3E98XYfXaoPmSLb6ZI9V/pBWIF8U8NzbYFaLZOLlxr7a0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3074.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016003)(83380400001)(38070700005)(5660300002)(6506007)(55236004)(966005)(76116006)(71200400001)(9686003)(53546011)(64756008)(8936002)(66446008)(7696005)(86362001)(110136005)(54906003)(316002)(66556008)(122000001)(33656002)(508600001)(2906002)(52536014)(186003)(4326008)(107886003)(26005)(66476007)(66946007)(85182001)(38100700002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzZvU3ZEbW9rTWlGbkZKcitNcVFSRUxTTitBcmZlcEhINFZ5blNpdHJDL3M3?=
 =?utf-8?B?TWtRNGVPbTRtYzJxRVNxOHpMS0Z2NTRBUE5sUUZsdEgxemI3QU1wLzJDQmtH?=
 =?utf-8?B?RFY2QWxjQlE2VE5UTElrUEpvRHNZYzFFbWYrUWZLd0l2ZnhIbUlCSjZ4YXZ3?=
 =?utf-8?B?STZwV1pkVkk4Mm5XSGZFejJzTUFGR2twVFB3Qk9sSVk2dWlZRTh4VVJLdWV2?=
 =?utf-8?B?K3hTTExLSVdWcDBHUnlGQldtNlJJc20rVW82dHIyUkp6R1c3YlpNNnlTUU14?=
 =?utf-8?B?VjV5ejgxekVPTnV2WnJsc1ZML1gwZlJWUFI2QzRIM1hWWmJmTUQ0Um5FMk5R?=
 =?utf-8?B?UWRHV2MyaUs3NmhpRkFEekdLa0wySmlYeWw1U0pLdVd5VjBGcVIwcVVaa25X?=
 =?utf-8?B?MFF2eUJSZVFFUm5qblRITTIwMDhFNWZQR0wwVXZzTGNxNk5rUkZoaEtneE1L?=
 =?utf-8?B?V2ZRZDRYdW9OdmtlL1VCeUZ3aUpiSmRXMnNOTjlwSjlzazJMaDRJdWloOWgv?=
 =?utf-8?B?RjhIVzd0S0YvWVN0dW4ybytISXNhbFY5ems3cy9uclBFVFFDUFR3RGJ6STA4?=
 =?utf-8?B?UWR6eEhNUkpOaDIyelM0MmtPQVlsKzZaVkwzMXNPTHcvNVJDYjJidWFFRUJh?=
 =?utf-8?B?NGFKNE9GcS9UNGJjc0R4aEIrNjU1NEFZV1lCMk1GK1lVQlZZaDhieVY2L0U2?=
 =?utf-8?B?VzZGa1FCWmVaV3pUcWluVXNFZlVNMkRoV0lnTURJRlJ0cVpuTzB4bmJaaDZj?=
 =?utf-8?B?c0VJdTFCcXFQOUNEY2NZbmEzbmFKdWtqR29kT0R3dS9SbTFwS2Q4Yjkwa2xh?=
 =?utf-8?B?OFdTTVQwMTRCUUlpRDJpTHNaQXJ5YU1HU3NzOHR6SWxZS2hRczdwYkR4N1pl?=
 =?utf-8?B?aHBubC9QZ2JBSTV2eFpTZzc2d2Vxempvd2s3bTZ1TG43QTIxVC9ERThNOVVR?=
 =?utf-8?B?cEpSY0ZnYUNaMTJqaE9YMFRoNllEZmtPQXJ2K0JGUXRJVzNyVW1FeEVMOGZx?=
 =?utf-8?B?RnhQQ0Q2VXMzS2ZFRGRaNUwvTE9NNjJSNVdZSzhpdzd3ZXI3MUt5S05vNjdj?=
 =?utf-8?B?NWd3UWt2QzhaN2wvb2xBWnQ1MTZwMUxlRjFIbEIxdGpaNXNkM00xeHJGRE5M?=
 =?utf-8?B?bmhycVdqYm1maEREZkpKZHkxekVnbzV5NWhMRjd0UG5vS0FTMnFVUW8xSDZH?=
 =?utf-8?B?R05adytZR0hRN2daQmlUbDVLckNhK3J6TGpHOGg5UVZtOFpLVG8zZG1RQmJw?=
 =?utf-8?B?alZmUXlNYWFrVEFsUDlKMmw1ZVZ5dnNIT0x4MWtuT09MYytHa2hyU1Q3Q1hQ?=
 =?utf-8?B?N0U3Y1JBaDRMVURlQVBhUW9rNnZGbE5BcG4yMmkvN3RXeVJFdW9vNzhFTFQ5?=
 =?utf-8?B?UEVVa2F1U2ptVjJranY1WnQvVTlaa2loaTRNNnFJUWp5blNMYlJkWHVURWlU?=
 =?utf-8?B?WmFrUzhzTnRkdERQM1g5L090OE1iMmhRTnI4RG9oQnQrSzNTcU9iYmIxNjVr?=
 =?utf-8?B?NWo4akZ5U2tzQUQ3YnVoNmZuSzlRMlA5c3lxUHlCc09KaHZqa0JCeHg3STly?=
 =?utf-8?B?RHQxTjZqcVV6UWExQXVERTEzTytLREdrb2RTak9FVmY0dHFhTXZ4TllIbWlC?=
 =?utf-8?B?WnV3UEZ4UnJtQ3hiNzRGRXBIam5GS3FHNnFaK296MkJYVmxTUVRyUTVuSzZ0?=
 =?utf-8?B?bzI2RzZ1aHozVko3Rno1dHRxaTlmOFY0TlQ5akswTk4vZFNRMDFHNWJLQWpI?=
 =?utf-8?B?MWFPakgvSDZsR08vSnVqWDFmcks2SDFpS0NXdWgxVU1EdUlGaWFjNFI1RlQ3?=
 =?utf-8?B?Z0FneFhibUo4Y3A4QXhOYUV1ek5LVlRtc09ydS80VWozMEYvRzdZQXhmaCtU?=
 =?utf-8?B?UkowdFhld3RqRXhlcFJYRjQwemYyZHpNWXBSWTVpUlhvaE5SZklGbUNUMUMr?=
 =?utf-8?B?dmxDMlBCM2doTmFSamJvZTdWYVl2VVZrR0VQZzNuUjVtbzRwYit4K09OWWxk?=
 =?utf-8?B?SlR2d2wvWk1uYU81MjVsdmVtVXRGRHlHNkRVcnNDWHVDK3czNEQ0YkFweU1S?=
 =?utf-8?B?SGRoNW5RVkE4TjFWWHpHaVNhTkUycUxwMndoT0J6TDV3NHQzZHlFNmpHclpT?=
 =?utf-8?B?a3lHaTc0YmhQVkhYcTlWNUlpZjVsZlJwdEF1QStSdUVEZXZiMTl4WjczdkZZ?=
 =?utf-8?Q?QMrGyTLSQK4v6WolYNEZsfc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3074.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46ecac2-2b03-43de-f925-08d9b3ea7fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 10:16:39.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 301f59c4-c269-4a66-8a8c-f5daab211fa3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmAi8aNEiZen2ooaEMSGWSUcS6ZpTzZIFoZW6RtgEDRityfAh3obHzRGoc2XhfdVle9IJXL0VjtzQmZX1n92rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR04MB3764
X-OriginatorOrg: ASUS.com
X-TM-AS-Product-Ver: SMEX-14.0.0.3092-8.6.1018-26560.007
X-TM-AS-Result: No-10--11.754000-8.000000
X-TMASE-MatchedRID: c/HXCguHooHUL3YCMmnG4n4neC0h7SADStGAgmKqWuWeEPi9wVyFrnN8
        LqnPuFqMJ4659cU+eYajeh1Xkn87pV+c6oQe8SWciVJZi91I9JhR3sGN+j7mNHATs0J+9trcBPj
        aZmSR/0fDMdh5CR5dYNiUCGstbltGPg9yfk4YC0aaVoAi2I40/YZ6Q5tE4bB04Ju5UjuFVstUza
        n9xEPKMeIKD3/VjwK616yvy9TI45W8FWDghTh72fSG/+sPtZVk9DmY4JJYLjqTk6rQzecvUPhdk
        K+YC/gq4vM1YF6AJbY9l7H+TFQgdbeQq6mF2S4/SVdy2uiYUWL6C0ePs7A07YVH0dq7wY7uvQY3
        aZjqYhdYgL44QO4hwIQgyUIvcm50MKxMM/+4ARcmNQgq4u0jFA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.754000-8.000000
X-TMASE-Version: SMEX-14.0.0.3092-8.6.1018-26560.007
X-TM-SNTS-SMTP: 21E29C66830556E7E0D8F2631ABD8EEAA749E1FAAF5DE9CC9A13A5FFA597245D2000:9
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQW5keSwNCg0KWWVzLCB0aGlzIHBhdGNoIGNhbiByZXNvbHZlIHRoZSBBREMgZGV2aWNlICJB
REMwODFDMDIxQ0lNS1giIG5vdCBmb3VuZCBpc3N1ZSBvbiBvdXIgeDg2IGRldmljZXMuIEN1cnJl
bnRseSwgdGhpcyBwYXRjaCBpcyBzdGlsbCBub3QgaW4gdGhlIGxhdGVzdCBrZXJuZWwgNS4xNi4w
LXJjMy4NCg0KQmVzdCByZWdhcmQsDQoNCkt1bnlhbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25ASHVhd2VpLmNv
bT4NClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDMwLCAyMDIxIDY6MTEgUE0NClRvOiBBbmR5IFNo
ZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQpDYzogS3VueWFuZyBGYW4o6IyD
5Z2k5o+aKSA8S3VueWFuZ19GYW5AYXN1cy5jb20+OyBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0Br
ZXJuZWwub3JnPjsgbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3JnPjsgS3VueWFu
ZyBGYW4gPEt1bnlhbmdfRmFuQGFhZW9uLmNvbS50dz47IEphY29iIFd1KOWQs+aWh+WCkSkgPEph
Y29iX1d1QGFzdXMuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gaWlvOiBhZGM6IHRpLWFkYzA4
MWM6IFBhcnRpYWwgcmV2ZXJ0IG9mIHJlbW92YWwgb2YgQUNQSSBJRHMNCg0KT24gVHVlLCAzMCBO
b3YgMjAyMSAxMTo0NDoxNyArMDIwMA0KQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29A
Z21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBUdWUsIE5vdiAzMCwgMjAyMSBhdCA2OjIyIEFNIEt1
bnlhbmcgRmFuKOiMg+WdpOaPmikgPEt1bnlhbmdfRmFuQGFzdXMuY29tPiB3cm90ZToNCj4gPg0K
PiA+IEhpIEFuZHksDQo+ID4NCj4gPiBUaGlzIHBhdGNoIHdvdWxkIGFmZmVjdCB0aGUgQURDIGZ1
bmN0aW9uIG9uIEFBRU9OIHg4NiBwcm9kdWN0czoNCj4gPiBodHRwczovL3d3dy5hYWVvbi5jb20v
ZW4vcC9kZXZlbG9wZXItYm9hcmQtaW50ZWwtMTF0aC11cC14dHJlbWUtaTExLA0KPiA+IHdlIG5l
ZWQgdGhlIEFDUEkgSUQgdG8gZW5hYmxlIEFEQyBkZXZpY2UgQURDMDgxQw0KPg0KPiBBRkFJVSBK
b25hdGhhbiBkaWQgdGhhdCBwYXRjaCAoYW5kIGl0J3MgYXBwbGllZCwgcmlnaHQ/KSBleGFjdGx5
IGZvcg0KPiB0aGF0IHJlYXNvbiwgYnV0IHRoZSBtYWluIGlzc3VlIGhlcmUgaXMgdGhlIHByb2Nl
c3MgaW5zaWRlIEFBRU9ODQo+IGNvbXBhbnkgcmVnYXJkaW5nIEFDUEkgSURzLCBjYW4gdGhhdCBi
ZSBmaXhlZCBwbGVhc2U/DQo+DQoNCkkgbmVlZCB0byBkbyBhIHYyIHdpdGggY2hhbmdlcyBhcyB5
b3Ugc3VnZ2VzdGVkLCBzbyBub3QgaW4geWV0Lg0KDQpKb25hdGhhbg0KDQo8cD48L3A+DQoNCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQpUaGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgdG8gaXQgY29u
dGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gYW5kIGFyZSBpbnRlbmRlZCBzb2xlbHkgZm9y
IHRoZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwgdG8gd2hvbSBpdCBpcyBhZGRyZXNzZWQuSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvciByZWNlaXZlIGl0IGFjY2lkZW50YWxs
eSwgcGxlYXNlIGltbWVkaWF0ZWx5IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IGUtbWFpbCBhbmQgZGVs
ZXRlIHRoZSBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMgZnJvbSB5b3VyIGNvbXB1dGVyIHN5
c3RlbSwgYW5kIGRlc3Ryb3kgYWxsIGhhcmQgY29waWVzLiBJZiBhbnksIHBsZWFzZSBiZSBhZHZp
c2VkIHRoYXQgYW55IHVuYXV0aG9yaXplZCBkaXNjbG9zdXJlLCBjb3B5aW5nLCBkaXN0cmlidXRp
b24gb3IgYW55IGFjdGlvbiB0YWtlbiBvciBvbWl0dGVkIGluIHJlbGlhbmNlIG9uIHRoaXMsIGlz
IGlsbGVnYWwgYW5kIHByb2hpYml0ZWQuIEZ1cnRoZXJtb3JlLCBhbnkgdmlld3Mgb3Igb3Bpbmlv
bnMgZXhwcmVzc2VkIGFyZSBzb2xlbHkgdGhvc2Ugb2YgdGhlIGF1dGhvciBhbmQgZG8gbm90IHJl
cHJlc2VudCB0aG9zZSBvZiBBU1VTVGVLLiBUaGFuayB5b3UgZm9yIHlvdXIgY29vcGVyYXRpb24u
DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0K
