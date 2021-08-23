Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48773F4591
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 09:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbhHWHFm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 03:05:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35874 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235136AbhHWHFl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 03:05:41 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N3323w022963;
        Mon, 23 Aug 2021 03:04:44 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00128a01.pphosted.com with ESMTP id 3akwffap37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 03:04:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arjCKrXW21almafWPJy+TOgUV6NmHkUpiRjlzhSU/NqRnxsJ5bJpZQ9ynyHCNaeSs9OGm1y0LftubIc670iWFkVqr+OpLWdTu6j7sPACZ+aswnK8T66BncgiFFk0yMT6H+DVe8JZqCdZur22fOPk1l2k0PJ/fG7IBfI8PsbhLPODIp9DJnMgjbVWiuLZMkhJCkXVYQeH50IuGEF+S+c2cDxEfRl7i2Mas1y93Z7wcGb/LzboTW2NK9VNl0vOPII8AjC9I0t8vJy6L4vA0IGvmnPCQQltzUrsmchk4lE1unz8bA273WVB77Govgh82ftN0xwFBnHqtQoklEjgwnI4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiwODJo8PbujeD7R7Ws2MODFe7xf4pUhY9YOQ0QV7Ao=;
 b=GjIqw0h/dJEzEX6vlrxmse99JbTXFFOczxxD/vtzD7EeNpDWJHHYFoedL7rlrloip/mdMAYiztFPgHMQmr72X+/l4yUNZxo6MCe78Bx4O2opyyVk4lqWXo43RfUSV7FSKqCAqJ733Yc1Run2tNU+8BsYq7LSyCrA07bnGr/0Xo0AcbKkd8ca2vFhGNbI/egXsDJTh21dq2pee5DCyDgXv/xhQgqiSiXOwi/pN/Rupb8k4NNAJRFn97/+a6pEA53I08CYNEqrfOIctS7t4+85784D6YBDaIS6QTAMCLBktDXEyjgo/RpHLcX1vrsddCa9ydZZUTcFLg//5G+/c6LsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiwODJo8PbujeD7R7Ws2MODFe7xf4pUhY9YOQ0QV7Ao=;
 b=W8gdH0oCOfyo+UNbOkfvRRP2ee1jQLJCky4WUEX3jwl9DInapq0CvxXTscPQIuekzSZfCFvNu20+h4xH4Mv6HyolpJhuf+Ed7cdqi4iA+kHp2En8BXNF2moWgeNAvJrsCXXRAPfJl8cIYudoJybAbSHliqOChVeQYY8rHpi0on8=
Received: from MW4PR03MB6363.namprd03.prod.outlook.com (2603:10b6:303:11e::10)
 by CO2PR03MB2214.namprd03.prod.outlook.com (2603:10b6:100:1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Mon, 23 Aug
 2021 07:04:42 +0000
Received: from MW4PR03MB6363.namprd03.prod.outlook.com
 ([fe80::3c5f:4b91:b79f:b1b4]) by MW4PR03MB6363.namprd03.prod.outlook.com
 ([fe80::3c5f:4b91:b79f:b1b4%7]) with mapi id 15.20.4415.023; Mon, 23 Aug 2021
 07:04:42 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Subject: RE: [PATCH 1/2] iio: ltc2983: add support for optional reset gpio
Thread-Topic: [PATCH 1/2] iio: ltc2983: add support for optional reset gpio
Thread-Index: AQHXlZAEw8Cp9hamfE+zlTHLEe4sGqt8DZ2AgAASExCAAJ/yAIAD7Hzw
Date:   Mon, 23 Aug 2021 07:04:42 +0000
Message-ID: <MW4PR03MB636377CD2EB2531043734BFF99C49@MW4PR03MB6363.namprd03.prod.outlook.com>
References: <20210820065535.6994-1-nuno.sa@analog.com>
 <CA+U=Dso61XreVxxz8a3cSO+LJrdQAJAi--3Nuv5nRG=buuVCcQ@mail.gmail.com>
 <SJ0PR03MB6359B7B5B7BF6975590879EC99C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
 <CA+U=Dsr6UevuFcJ9rositNx9hMx_Pwj4AnTHcN_ioEg5tOPueQ@mail.gmail.com>
In-Reply-To: <CA+U=Dsr6UevuFcJ9rositNx9hMx_Pwj4AnTHcN_ioEg5tOPueQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5qRTROMkpsWm1FdE1ETmxNQzB4TVdWakxUaGlPRGd0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEWXhPRGRpWldaaUxUQXpaVEF0TVRGbFl5MDRZ?=
 =?utf-8?B?amc0TFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTkRReE5T?=
 =?utf-8?B?SWdkRDBpTVRNeU56UXhOelU0TnprMk9Ea3lNVEEySWlCb1BTSlZPVkk1VjAx?=
 =?utf-8?B?emQwSkZabUl2WXpkT1QwRkxjalpuVUdwM1NVVTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVUkxRaTlOYWpkYVpsaEJabTVJWTA1dVdVWXhhV3dyWTJSM01t?=
 =?utf-8?B?Um5XRmRMVlVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVUpQV1VkalowRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlNqUkJRVUZDYUVGSVNVRmhVVUpv?=
 =?utf-8?B?UVVZNFFWcEJRbkJCUjAxQlpFRkNjRUZIT0VGaVowSm9RVWhKUVdWUlFtWkJT?=
 =?utf-8?B?RkZCWVZGQ2JFRklTVUZOVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVVZCUVVGQlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlIw?=
 =?utf-8?B?VkJZMmRDY0VGSFJVRllkMEpyUVVkclFWbDNRakJCUjJ0QlluZENkVUZIUlVG?=
 =?utf-8?B?alowSTFRVVk0UVdSQlFuQkJSMVZCWTJkQmVVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZC?=
 =?utf-8?B?UVVFOUlpOCtQQzl0WlhSaFBnPT0=?=
x-dg-rorf: true
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1b1e785-ca1f-452c-45a1-08d96604484b
x-ms-traffictypediagnostic: CO2PR03MB2214:
x-microsoft-antispam-prvs: <CO2PR03MB22146628E459E61C9DE2C01D99C49@CO2PR03MB2214.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: psob6skPBjuWkxfsuWjiB6EEnqEU4/JDvFmdxVQVDMMnn51JOJFnNOfdqPxTtBeSSNwGFoFI31TI1l/UtFBT95+iEQKi9CJ06TNqEtQV120hZ1N2xZ1OV0U1GMTnbBJsqKk/ok5SCWDjO+9Tb2YPoSfQGjI2RShfBFw6aPaXp21Mj+tD1S7HGFrIDZaEj8tpwLWuxW67E0AE2wjt9Vf/GsWvI+cFOJEOtGc0HY/okQC8M1ihHdZ0PwENNONpuV13+/iQ+Sae48Mmu+M7eTbGGbGbFkoBdNr83FdobYdFA4l8fVH8d7SSpgxVWrtrsM3JZH9Pcbml5mlnN32Ce7xRYaUXjyPKsnDfQCNvfv7KW9os5QbpTC3i8aUGxMcFwNVCQzVOx4bq9kiqdqNHm6ua3yXZFcfEP5VjQ/EuA/Zyssxr8IlXH5sFAqnQgGf3foSKq7uvi5P0PDBu5ipALE7gUvr0pOS9n1b3uG9du9hc7Eub8YXInm9pIN/Dv+zZFJrXUTkKustWqymll2Ou1ryXnCK9K50QBAU/2EVi0wd84DW4LocLu0uBG8QXQO8P3rsNNK/eEpjOS6Q4nviAUf5izib2x1h1n5is8+Llr1g/SoTQWOdWjcwOpApr86XOzeC/CkuDNgra24lJEeYSYrItBshwSmWvlvIOMHIdOFS2fZNnd6xItrbORZUDJSvOczmq6nWod9KFoRGM+Qj1F2GGmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6363.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(53546011)(186003)(6506007)(478600001)(5660300002)(316002)(8676002)(8936002)(2906002)(76116006)(66946007)(26005)(71200400001)(66446008)(64756008)(6916009)(66556008)(66476007)(55016002)(83380400001)(4326008)(9686003)(38070700005)(33656002)(122000001)(86362001)(54906003)(38100700002)(7696005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzVxeFNPbENIdFh3cERidmFjOExoOE1yMjdhTGp6cjMrd3B2SUFlU2NvY29L?=
 =?utf-8?B?bmZwa2F6ZHRvc3ljd2FEc1VHdG1JVElkN1Z5TDl2dlRrc25rM25icDYzVVBt?=
 =?utf-8?B?L3kxSlhPKys1L3ZLQlZ2aWZTOVBiTU9uZmVyLzhWNHRvbGhyZnQzUHVJZUY1?=
 =?utf-8?B?c1dWVG1MNStzeDBEY1ZYb0xuK2ZnaE12L3RRUHY0Qjl6NnZ1cDdXNVZ6S21Z?=
 =?utf-8?B?TURKaFllWHh2UERGcHk4RVc4MmxKblBRS0Q0WHdKS2ZzUTJaRlFudXlWSW9K?=
 =?utf-8?B?SXBpd0oxaDgxcGpKKzFBbDI2TjdIQ0N6OGE1M0N2Y2VYYW45Z1ZmZGhvVm5u?=
 =?utf-8?B?ODh2VWQ4R29YaThYWlAxVXc1YWkxSjQ5RlhoUHF5amlSZmxYSXBsMjVtTVBT?=
 =?utf-8?B?WjBXdloxZWlUZWpoWm5yaE1uRFp3eHdWOWFLaGI2VEhTbStCa1pkbktkTUgx?=
 =?utf-8?B?VG5iNk5RU1FObG9UbG5NZGEwcmo3ellrK3htVXpKSVp5RC9kNlVYUnFrZmN4?=
 =?utf-8?B?V0JWRWY3UVdXVmRYV2ZUNzg1L214L1JQQ2plWGJVQ0k4VUdIQTUzTTA2dTR5?=
 =?utf-8?B?UGZZS052MWROVTkvK05KNy9zVXZHMlRNaTEvakZtdXpvc2tTUk5EbG03c1Jt?=
 =?utf-8?B?SU1EUENlQlZ0UzJqTzl0VnYvdk5wcTVJbzI4SG40L1lUcVhXZTVUaFNIUFlv?=
 =?utf-8?B?QVYrUmhYZXlmWHNobUhjZmdvR2VTTHpwQ2padU5KNUNucEFBc1ZTTEZIOUxM?=
 =?utf-8?B?NjdrbGVKRnBMZW9TbVhqSFF4TmNxR3JhTk9YVFoxMzF5Smh6ZzlLc3J4L0xs?=
 =?utf-8?B?NGkzTUxxb2tVRkI1SjJuYUE0ZjB0eCthNDZzSTFic1hUTmw4VkhUV29McC9O?=
 =?utf-8?B?SE02UXJvdXY5c2MwZGdpOEp1WUJIVWkwb1MxRWd5Q3hzWVlZdmJ1NTZOTjRQ?=
 =?utf-8?B?M2FiQTljdG1CdWVzMmtMbEgrY3BOaXJaVmk4ZnNlR0ZGeTgrb3pwVUxHSWFZ?=
 =?utf-8?B?MHBPUkEwdDRHM3NhMGtGMlZFTDRKUlJPcFJwcUtPSk51TytVRUNsZks5cHor?=
 =?utf-8?B?cFFQMWNsOUNwbDZwQ0tTazVHZitjNmU1eVhaS2FhVjhNQmNFYVlMN1c5ck94?=
 =?utf-8?B?aWYrdzlWL045UXFKNXFiM2lCU1VyQlRCdmZTYllhbnYra2QxbGxjVXIzbFYr?=
 =?utf-8?B?ZmU3c3o3Sk0rdjQrUU9hUzN1NU0vOXhBb1Fic1grZGtXci9zbmNraHBJTFV2?=
 =?utf-8?B?MzZIWCt5c0VmVXZjdDlDc3c0TUNYQXozcVkzb2RSeEpDMk1YckNnbHNmYXFp?=
 =?utf-8?B?OHVsdEY3NEpPSVdad2duV1R1MDFHZFEvYlhYUlBYY3ZmKzUwcTI2dzVBTmFs?=
 =?utf-8?B?L3hLWjV6WkJ5R2ZBemsxQnRZU3JNdTVhNmZQUnFkWjA5NkRWY2ZIbjNZZlUx?=
 =?utf-8?B?SjZUdHdhMU5lM0NJcmhPR1BsZUVyYmc3Vndpb1dySmZBZHlucWpmcUJpNGhZ?=
 =?utf-8?B?ekYyaWMvcDlGd0x1cGNNVWVZRnM4by9hMEVUa0ZYK0daeTJ1aEtLaU1zM29C?=
 =?utf-8?B?MXBlKzJuS2xBcWo1UERrRVVqZ3FOZWE2SHJMN0pTeUF2SmV1TEZuRnVpRkNi?=
 =?utf-8?B?azYvVU5IV0FJVWZJZXJCVjNwR2lPbE54ZCtFNFlmZ3M2Sm5sSzBLdEtzMU5K?=
 =?utf-8?B?N0NjOGJuKzVzMWhvRnZuS05kRWJoNUE3TTNEKy9BV2p1SDEyRzhtN2Rhdzlt?=
 =?utf-8?Q?fyCYrSvhJEeZFb7AsKoMLJauFLK/SVNrAh+CeDo?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR03MB6363.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b1e785-ca1f-452c-45a1-08d96604484b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 07:04:42.6598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ud7KN9M44E+JE0iEiuBvIrVsz+kqd4jg8dIBT/fHLZNJitTd81rzrkpXBaKsit/KD+kC7LJLuDAvsd87+lryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2214
X-Proofpoint-ORIG-GUID: KqUqhCKHULjIGK5LvoYZ1RN35dqH1rkv
X-Proofpoint-GUID: KqUqhCKHULjIGK5LvoYZ1RN35dqH1rkv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-23_02,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230047
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZHJ1IEFyZGVs
ZWFuIDxhcmRlbGVhbmFsZXhAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAyMCwg
MjAyMSA4OjU5IFBNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiBDYzog
bGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3JnPjsgSm9uYXRoYW4gQ2FtZXJvbg0K
PiA8amljMjNAa2VybmVsLm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRl
PjsgRHJldw0KPiBGdXN0aW5pIDxkcmV3QHBkcDcuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDEvMl0gaWlvOiBsdGMyOTgzOiBhZGQgc3VwcG9ydCBmb3Igb3B0aW9uYWwgcmVzZXQNCj4gZ3Bp
bw0KPiANCj4gT24gRnJpLCBBdWcgMjAsIDIwMjEgYXQgMTI6MjkgUE0gU2EsIE51bm8gPE51bm8u
U2FAYW5hbG9nLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhcmRlbGVh
bmFsZXhAZ21haWwuY29tPg0KPiA+ID4gU2VudDogRnJpZGF5LCBBdWd1c3QgMjAsIDIwMjEgMTA6
MjEgQU0NCj4gPiA+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiA+ID4gQ2M6
IGxpbnV4LWlpbyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IEpvbmF0aGFuIENhbWVyb24N
Cj4gPiA+IDxqaWMyM0BrZXJuZWwub3JnPjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFm
b28uZGU+OyBEcmV3DQo+ID4gPiBGdXN0aW5pIDxkcmV3QHBkcDcuY29tPg0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCAxLzJdIGlpbzogbHRjMjk4MzogYWRkIHN1cHBvcnQgZm9yIG9wdGlvbmFs
IHJlc2V0DQo+ID4gPiBncGlvDQo+ID4gPg0KPiA+ID4gW0V4dGVybmFsXQ0KPiA+ID4NCj4gPiA+
IE9uIEZyaSwgQXVnIDIwLCAyMDIxIGF0IDk6NTMgQU0gTnVubyBTw6EgPG51bm8uc2FAYW5hbG9n
LmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBDaGVjayBpZiBhbiBvcHRpb25h
bCByZXNldCBncGlvIGlzIHByZXNlbnQgYW5kIGlmIHNvLCBtYWtlIHN1cmUgdG8NCj4gPiA+IHJl
c2V0DQo+ID4gPiA+IHRoZSBkZXZpY2UuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gSnVzdCBvbmUg
bm90ZS9xdWVzdGlvbiBpbmxpbmUuDQo+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOdW5v
IFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMv
aWlvL3RlbXBlcmF0dXJlL2x0YzI5ODMuYyB8IDExICsrKysrKysrKysrDQo+ID4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9paW8vdGVtcGVyYXR1cmUvbHRjMjk4My5jDQo+ID4gPiBiL2RyaXZlcnMvaWlv
L3RlbXBlcmF0dXJlL2x0YzI5ODMuYw0KPiA+ID4gPiBpbmRleCAzYjRhMGU2MGU2MDUuLjM3OTAz
ZTlmYjkwZiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9paW8vdGVtcGVyYXR1cmUvbHRj
Mjk4My5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL2x0YzI5ODMuYw0K
PiA+ID4gPiBAQCAtMTQ3MCw2ICsxNDcwLDcgQEAgc3RhdGljIGludCBsdGMyOTgzX3Byb2JlKHN0
cnVjdA0KPiBzcGlfZGV2aWNlDQo+ID4gPiAqc3BpKQ0KPiA+ID4gPiAgew0KPiA+ID4gPiAgICAg
ICAgIHN0cnVjdCBsdGMyOTgzX2RhdGEgKnN0Ow0KPiA+ID4gPiAgICAgICAgIHN0cnVjdCBpaW9f
ZGV2ICppbmRpb19kZXY7DQo+ID4gPiA+ICsgICAgICAgc3RydWN0IGdwaW9fZGVzYyAqZ3BpbzsN
Cj4gPiA+ID4gICAgICAgICBjb25zdCBjaGFyICpuYW1lID0gc3BpX2dldF9kZXZpY2VfaWQoc3Bp
KS0+bmFtZTsNCj4gPiA+ID4gICAgICAgICBpbnQgcmV0Ow0KPiA+ID4gPg0KPiA+ID4gPiBAQCAt
MTQ5NCw2ICsxNDk1LDE2IEBAIHN0YXRpYyBpbnQgbHRjMjk4M19wcm9iZShzdHJ1Y3QNCj4gc3Bp
X2RldmljZQ0KPiA+ID4gKnNwaSkNCj4gPiA+ID4gICAgICAgICBpZiAocmV0KQ0KPiA+ID4gPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+ID4NCj4gPiA+ID4gKyAgICAgICBncGlv
ID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoJnN0LT5zcGktPmRldiwgInJlc2V0IiwNCj4gPiA+
IEdQSU9EX09VVF9ISUdIKTsNCj4gPiA+ID4gKyAgICAgICBpZiAoSVNfRVJSKGdwaW8pKQ0KPiA+
ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoZ3Bpbyk7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKyAgICAgICBpZiAoZ3Bpbykgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgLyogYnJp
bmcgZGV2aWNlIG91dCBvZiByZXNldCAqLw0KPiA+ID4gPiArICAgICAgICAgICAgICAgdXNsZWVw
X3JhbmdlKDEwMDAsIDEwMDUpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgZ3Bpb2Rfc2V0X3Zh
bHVlX2NhbnNsZWVwKGdwaW8sIDApOw0KPiA+ID4NCj4gPiA+IERhdGFzaGVldCBtZW50aW9ucyB0
aGF0IGl0IHRha2VzIHVwIHRvIDEwMCBtcyBmb3IgdGhlIGRldmljZSB0bw0KPiBmdWxseQ0KPiA+
ID4gc3RhcnQtdXAuDQo+ID4gPiBJdCBhbHNvIG1lbnRpb25zIHRoYXQgdGhlIChjb21tYW5kKSBz
dGF0dXMgcmVnaXN0ZXIgd2lsbCBiZQ0KPiA+ID4gdW5hdmFpbGFibGUgdG8gdGhlIHVzZXIgYmVm
b3JlIHRoaXMgcG9pbnQuDQo+ID4gPiBQYWdlIDE2LCBDb252ZXJzaW9uIFN0YXRlIERldGFpbHMg
c2VjdGlvbiwgc2Vjb25kIHBhcmFncmFwaC4NCj4gPiA+DQo+ID4gPiBJIHRoaW5rIHRoZXJlIHNo
b3VsZCBwcm9iYWJseSBiZSBhIHNsZWVwIGhlcmUgb2YgMTAwIG1zLg0KPiA+ID4NCj4gPiA+IE90
aGVyIHRoYW4gdGhhdCBjaGFuZ2UgbG9va3MgZ29vZC4NCj4gPiA+DQo+ID4NCj4gPiBJbiB0aGUg
c2V0dXAgZnVuY3Rpb24gd2UgZG8gYSBwb2xsZWQgcmVhZCBvbiB0aGUgc3RhdHVzIHJlZ2lzdGVy
IHVudGlsDQo+ID4gd2UgZ2V0IHRoZSBpbmRpY2F0aW9uIHdlIGFyZSB1cC4gVGhpcyB3YXMgYWN0
dWFsbHkgYSBmaXggc2VudCByZWNlbnRseQ0KPiA+IFsxXS4NCj4gPg0KPiANCj4gWWVzLCBJIHNh
dyB0aGF0Lg0KPiBCdXQgSSBkaWQgbm90IGhhdmUgZW5lcmd5IHRvIGxvb2sgYXQgaXQgdG9vIGlu
LWRlcHRoIFthdCB0aGF0IG1vbWVudCBpbg0KPiB0aW1lXS4NCj4gQXBvbG9naWVzLg0KPiANCj4g
QnV0IHRoZSBxdWVzdGlvbiBpczogaXMgdGhlIHN0YXRlbWVudCBvbiBwYWdlIDE2IHZhbGlkPw0K
PiBpLmUuIGRvIHdlIG5lZWQgdG8gd2FpdCAxMDBtcyBhZnRlciB0aGUgcmVzZXQgcGluIGdvZXMg
bG93PyBiZWNhdXNlIGl0DQo+IHN0YXRlczoNCj4gDQo+IEluIHRoZSBmaXJzdCBwaGFzZSBvZiB0
aGUgc3RhcnQtdXAgc3RhdGUgYWxsIGNyaXRpY2FsIGFuYWxvZyBjaXJjdWl0cw0KPiBhcmUgcG93
ZXJlZCB1cC4NCj4gVGhpcyBpbmNsdWRlcyB0aGUgTERPLCByZWZlcmVuY2UsIGNoYXJnZSBwdW1w
IGFuZCBBRENzLg0KPiAqKipEdXJpbmcgdGhpcyBmaXJzdCBwaGFzZSwgdGhlIGNvbS1tYW5kIHN0
YXR1cyByZWdpc3RlciB3aWxsIGJlDQo+IGluYWNjZXNzaWJsZSB0byB0aGUgdXNlci4qKioNCj4g
KioqVGhpcyBwaGFzZSB0YWtlcyBhIG1heGltdW0gb2YgMTAwbVMgdG8gY29tcGxldGUuICoqKg0K
PiBPbmNlIHRoaXMgcGhhc2UgY29tcGxldGVzLCB0aGUgY29tbWFuZCBzdGF0dXMgcmVnaXN0ZXIg
d2lsbCBiZQ0KPiBhY2Nlc3NpYmxlIGFuZCByZXR1cm4NCj4gYSB2YWx1ZSBvZiAweDgwIHVudGls
IHRoZSBMVEMyOTgzIGlzIGNvbXBsZXRlbHkgaW5pdGlhbGl6ZWQuDQoNClllcywgSSBzYXcgdGhh
dCBvbiB0aGUgZGF0YXNoZWV0LiBNeSBpbnRlcnByZXRhdGlvbiBpcyB0aGF0IHRoZSBzdGF0dXMN
CnJlZ2lzdGVyIGlzIGp1c3Qgbm90IGF2YWlsYWJsZSBzbyB3ZSBqdXN0IGdldCAweDAwIG9yIDB4
ZmYgKHdoYXRldmVyIHRoZQ0KZGVmYXVsdCBzdGF0ZSBvZiB0aGUgU0RPIGxpbmUpLiBJbiBteSB0
ZXN0cywgaXQgdG9vayAzIGl0ZXJhdGlvbnMgdG8gYWNrbm93bGVkZ2UNCnRoZSBkZXZpY2UgYXMg
dXAuIFJlYWRpbmcgMHgwMCwgMHg4MCBhbmQgMHg0MC4uLg0KDQpCZWluZyB0aGlzIHNhaWQsIGxl
dCdzIHNlZSBpZiBzb21lb25lIGVsc2UgaGFzIHNvbWV0aGluZyB0byBzYXkgYWJvdXQgdGhpcy4N
CkknbSBtb3JlIHRoYW4gZmluZSBpbiBhZGRpbmcgdGhlIDEwMG1zIGFzIEkgYWxzbyB3b25kZXJl
ZCBhYm91dCB0aGlzIHRvDQpiZSBob25lc3QuDQoNCi0gTnVubyBTw6ENCiANCg0K
