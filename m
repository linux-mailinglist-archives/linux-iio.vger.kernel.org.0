Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6285F3603BD
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 09:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhDOHy6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 03:54:58 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:54212 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231215AbhDOHyz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 03:54:55 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13F7kOBR011541;
        Thu, 15 Apr 2021 03:53:58 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0b-00128a01.pphosted.com with ESMTP id 37xg85g657-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 03:53:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyO1G2OBS7U4VG3SYd5K+s8cvKlhxlH1qCCT+EEkPR3Rxgiu8R2yzrmv88tzlXFa4jVpG6y0ecJcQzwvk/fvGNiyrjXM1ZXa/f4HSXJhidsfmPC9D9Ch5LedYTyWj1eR3CYKelwZ823LbndjHHT/bL+bbXEvvbOXtb+YMzojyD9a+GC+Jdi2sjwfYqNOkzrg2xSEwZtS6xjijMs+EaL01vHCBYr3NIkjYTH65mqDKOOqHRgejEEgWuFwNQYwW2/03ibaUURiUo7JF1aoqvpii6934VvzrVOeWxQnHg0fP52tPtr4re47qrgpFFhOYHG019EVwKreL/b1LyHHXdfdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfCoLkxRTsY7ozJ1nNLMK8Onp3A088VUXNyTQxrVNpw=;
 b=RMTDoVNirtOo9n8hxk/w2jtKCy1ejEGJFvqK4nOa1s4Rkrmz+IuD61CJObKO0RqV0kwhmK5HI7JY6JqoShPc/ETnojmh7fJHLjH5ObtpzzCOF1G1aE4e8H9iFwbbLPkFSKjdDi1uURex/xmqjSaDZ6OuhWTaGfsiYdCARnem8OQk0GjUETRZQffQCgDgIc1FFamcUUnL+phLsY470POusHu/Aa62oTtcltMVYb7zFvwc+PRZ2YmyZspBJxy+ykcqDa8nXaMbO3Mg/AjhynnrlIFW+KrytbJHrAASmlcZOxweylg43SZrNgNf792J+fCUMIiniO5+ZCm2AKK8i4+K4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfCoLkxRTsY7ozJ1nNLMK8Onp3A088VUXNyTQxrVNpw=;
 b=A5GX6iOBGeIZvVloaJk5Ggu2sHpQ0EUNGj3rZSBIfgpgtgaGeSlaJCf/auLOp1FtO/56HU9wmkyc7kyLg7c0LxAQM0/WyaNxttDlEs+yg/v4ecpIDZrZbFdXn45ttl6TerSSsi8dpHMA9oaLGZbtyIdHckeMtfxScbxSykNEi9M=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY4PR03MB2645.namprd03.prod.outlook.com (2603:10b6:903:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 07:53:53 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4020.022; Thu, 15 Apr 2021
 07:53:53 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH 4/7] iio: adis16475: re-set max spi transfer
Thread-Topic: [PATCH 4/7] iio: adis16475: re-set max spi transfer
Thread-Index: AQHXMFbUjw8K/uCRQ0qG6XJFfEfrAqqznvwAgAGVJPA=
Date:   Thu, 15 Apr 2021 07:53:53 +0000
Message-ID: <CY4PR03MB3112C342E901F4E308D0AFF0994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210413112105.69458-1-nuno.sa@analog.com>
 <20210413112105.69458-5-nuno.sa@analog.com>
 <CA+U=DsqeiRRGp+Q+yZ7OVOE719aBiyMoBLsFTZL3amGfWHtgkg@mail.gmail.com>
In-Reply-To: <CA+U=DsqeiRRGp+Q+yZ7OVOE719aBiyMoBLsFTZL3amGfWHtgkg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFlqY3hNRFkzT1RJdE9XUmlaaTB4TVdWaUxUaGlNMkV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHSTNNVEEyTnprekxUbGtZbVl0TVRGbFlpMDRZ?=
 =?utf-8?B?ak5oTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpFME55?=
 =?utf-8?B?SWdkRDBpTVRNeU5qSTVORFk0TXpFMU1EazBPVFF3SWlCb1BTSk1ibTQxWkZS?=
 =?utf-8?B?MmQyMDJMelExWlZCdWVTdFFXSGxyWWpCdk0zTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTmphalowTlhwRVNGaEJZVTlaU2xsTldUVjVWRGx2Tldkc1oz?=
 =?utf-8?B?aHFia3BRTUVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRV0pLVUZOa1VVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d538668-9488-4460-756a-08d8ffe39d69
x-ms-traffictypediagnostic: CY4PR03MB2645:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB264567BA087FC9D7C63999B3994D9@CY4PR03MB2645.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zk6F0z+EevSlEqKiOpE703H3pNpzkjSOcVoGbSlQ3zspKw541xKkWuUuFWelulSfMitszpr1PnNG1mE3gn/1m7DRZxD6HRP9g1bvDMONDC1tNukYmbRF83EeLSoYBcQDW1NaAfdhgQTeuAEGHEQibgAyswsJTHtdV6xtorb6WvtVLO/z8LmY7VOSHtIRmou0m1uZlerTpU4qqdBDK0VO3PNJRzY3c33UTBIKoLGp3uhIpfMFPDgIns+azmVEZ3gCsFJ4fmgFN/b4DRy4gTgaKvs6+mah+j9yxdCDBoLMb9U1/nTpE2zt5t7OYph+gf3d2xSR8vkDzDrzsN74ab1SbeXz95KTPdGbsYTUqZ86MI6ABn/+EP/cTNmKiqc3WFos7FLev9w6hBU+UWPIyUIQ74rDGLVCKgxf45+6nVhoAqANn0frDa4L6WPkE+xBhopA9YCepfUqkLumYkKkU9dMUEP57nRkhsbDkDHQDeD70MAq06x3XnoqhRzbVvmGFLmsE5Wf3p7+h7Qc6LQ6KEMjDnEN9+ZNSy2dprVV0XQtcJXfKrRxQQJcN/frMQ6t9spYRnR8HKAZSOUIsZ1ftf/Bt2J0kPji5UFuwOKkXl/ewvs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(54906003)(122000001)(316002)(38100700002)(83380400001)(52536014)(2906002)(86362001)(33656002)(55016002)(71200400001)(76116006)(5660300002)(7696005)(4326008)(186003)(53546011)(6506007)(9686003)(64756008)(66476007)(66556008)(8936002)(66946007)(478600001)(66446008)(8676002)(26005)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WEpSejBBVmZ4TG1mVXhXaTJYeGdocjB4S1lYQjdUWjZWNmFxdEpMRmFibzlj?=
 =?utf-8?B?Q0RVa09tNW5HeXBhSEh1UXNwalppc21yMkkwbk5vWmZ5Mm5mdlpxbU1hOTFK?=
 =?utf-8?B?TWhPMWw0MjVBQVpIN1gvdk8rMWVoUVA3YzlQYnhFWmhhTHlTb05LY2huSE5l?=
 =?utf-8?B?YTNuVWxPcm5kRTRacnVBL3lPY1Y5b3lkTFlESGlPSGp1ZUxIRVhaeEpMKzgx?=
 =?utf-8?B?N2kxTnVBSm1INGppbU9YbzV2N3RpVzVNeWtPMkNndUJHNUtkQ0dFZ2hXcWFh?=
 =?utf-8?B?UC9BdlFwMC9EeHdZR3ZGaG5aMTVkMHNBOXF1SVdCRUJMVEQrZXNjSUk2UWVX?=
 =?utf-8?B?SHVhMndrWktiK0VlNUVBZEw3Slp2d3NoTjZIZGpWY05vTU5hVURZZTVHNnBm?=
 =?utf-8?B?THpyWlljMTNDMXBtZTd3NkcvQ25ib2grRVVETHJad1VxZWhPVGxVbTNSbEMw?=
 =?utf-8?B?T1lKR3RBdFduWjdsKzFTQXVlUTM1N1ZZWm01WnVGb2E3LzFZRnFiS3Y4RExE?=
 =?utf-8?B?bGxmS1Y1Q1ZwK0JCYmFhQnlVYk5hZjRFR2RIM1VmZTVTRUdTREZUM0paZVBC?=
 =?utf-8?B?UEcwUGRwSERLazF1RUZrMWZ6aUc0blJySWJUUEQ4a1UxODc4TDJwYkNBTGMv?=
 =?utf-8?B?aHlyZGVzYUk3Y1RvaWwxQm9qNUFnc01QYTJ4enNIYW5XR0ZpZ2hONkNVSVVO?=
 =?utf-8?B?WmJuRnV5SzBCK3BBV05Hd2FFOE1tcjZvMTIzUFV2blFWT3Q3czkyZVdMWmYy?=
 =?utf-8?B?NlJMMmZYcFIvUDVlaUNlU1JmWlpJZi9sekhMeFFRemlRMUR6bGJjYVNoN3Bw?=
 =?utf-8?B?YmJ3eU9qbHJibUwzV1JPelliZXhVSGxqNEV3S0trSEJTZ0hQTGh5SHZWbEJo?=
 =?utf-8?B?UFd6b1hlVDFQMURWY3Q3ZkdHdFRBamhWNWtHNlNXZ2FvWWlsakdZVlJjK3R3?=
 =?utf-8?B?bStDcHpMY0k1VXp2YkQyNk5HVjFIVjhGeFBKL2JkTXl0UjNOL0wydDgraDFv?=
 =?utf-8?B?QXllMTVqczBOUHVBK2NmSlptb1hsRzBCWmwxQ3h1aFZicVVQM29wWHVkOXJV?=
 =?utf-8?B?Yk1RZkJvbTZyT0xzMWc5Z213THRHRkEyL1FmOVQyWUp6YWwyYXR1b1dCK0N6?=
 =?utf-8?B?VFVHOEJpYUlxZUlpYXZ5bVVNTHBFOTJTTXdJV2RDaGNFcEVDcUZRVTh4cE45?=
 =?utf-8?B?N014ZVFhcmFxL3RHTUVRYkxTRHZEaWdIeGRhTDh2cGpTck9LVmJPcmZEWjlH?=
 =?utf-8?B?ZWZSRnQzRzJVVzFvMXdPdDcrNHd6VnBFcTF6SkhxREZLNFJiYXdMVWowRE1Y?=
 =?utf-8?B?dDJTQzY0b0xhcXlJbW1iUytkN0pyUi9odWZiQWtGNFh0RmVjM0J1L2lBdGFx?=
 =?utf-8?B?cW9ZYzBsb3RlWTNQbzJzUnlyRHNNZG4zK0pPMngrTlV3WG5aa0M4UWhyWFlX?=
 =?utf-8?B?WUFYWEJJc2t0aW85dmtFTndPcWIvTkNON0t1TnhDTk1pWVFaWVYwb05WK1c3?=
 =?utf-8?B?RUFEdFMwYjZFL201K0VwenB2RXd5eW5saUhHZWVZV0NaT0RqV09Gbzg0Yyto?=
 =?utf-8?B?VFM4aytEZkxsYXJXdmE2cGRKbXlhUzVyVDNXOWlQQ3JIR0pDdkR1S3JYeVZw?=
 =?utf-8?B?bFNFMDcwTTZQek5QL0JHYnMrOGlJc1JOSFM4ZFc1bDBYUVZqK1hIWERMR2xU?=
 =?utf-8?B?UDBWc2l0bUNXZVo3RnkyWWFZaUlzWjdHUEIwU0loNHJJc0NVajBGUW4wQVBG?=
 =?utf-8?Q?40pFoLv++HBS+/M+EMmQSdT+pMOtvimFL0Uru27?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d538668-9488-4460-756a-08d8ffe39d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 07:53:53.5480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0U1GDIR876vuzKLA3TIptWH8mQnupbi0a7jCdg5nGfWYyizBZz2TOCwNhrHfXXmTCEcDX8V6Q0jpuOhvwendw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2645
X-Proofpoint-GUID: htYIIaYJEDphSfE3L2PlsTPSWjQ0k6hh
X-Proofpoint-ORIG-GUID: htYIIaYJEDphSfE3L2PlsTPSWjQ0k6hh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150051
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZHJ1IEFyZGVs
ZWFuIDxhcmRlbGVhbmFsZXhAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE0
LCAyMDIxIDk6MjkgQU0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENj
OiBsaW51eC1paW8gPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBDYW1lcm9u
DQo+IDxqaWMyM0BrZXJuZWwub3JnPjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhl
bm5lcmljaEBhbmFsb2cuY29tPjsgTGFycy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28u
ZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC83XSBpaW86IGFkaXMxNjQ3NTogcmUtc2V0IG1h
eCBzcGkgdHJhbnNmZXINCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFR1ZSwgQXByIDEzLCAy
MDIxIGF0IDU6NDUgUE0gTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiB3cm90ZToNCj4g
Pg0KPiA+IEluIGNhc2UgJ3NwaV9zeW5jKCknIGZhaWxzLCB3ZSB3b3VsZCBiZSBsZWZ0IHdpdGgg
YSBtYXggc3BpIHRyYW5zZmVyDQo+ID4gd2hpY2ggaXMgbm90IHRoZSBvbmUgdGhlIHVzZXIgZXhw
ZWN0cyBpdCB0byBiZS4gSGVuY2UsIHdlIG5lZWQgdG8gcmUtDQo+IHNldA0KPiA+IGl0IGFsc28g
aW4gdGhpcyBlcnJvciBwYXRoLg0KPiA+DQo+ID4gRml4ZXM6IGZmZjczNTJiZjdhM2MgKCJpaW86
IGltdTogQWRkIHN1cHBvcnQgZm9yIGFkaXMxNjQ3NSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTnVu
byBTYSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9pbXUv
YWRpczE2NDc1LmMgfCA0ICsrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9h
ZGlzMTY0NzUuYyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0NzUuYw0KPiA+IGluZGV4IDUxYjc2
NDQ0ZGIwYi4uOWRjYTdlNTA2MjAwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9h
ZGlzMTY0NzUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0NzUuYw0KPiA+IEBA
IC0xMDY3LDggKzEwNjcsMTAgQEAgc3RhdGljIGlycXJldHVybl90DQo+IGFkaXMxNjQ3NV90cmln
Z2VyX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqcCkNCj4gPiAgICAgICAgIGFkaXMtPnNwaS0+bWF4
X3NwZWVkX2h6ID0gQURJUzE2NDc1X0JVUlNUX01BWF9TUEVFRDsNCj4gPg0KPiA+ICAgICAgICAg
cmV0ID0gc3BpX3N5bmMoYWRpcy0+c3BpLCAmYWRpcy0+bXNnKTsNCj4gDQo+IFB1cmVseSBzdHls
aXN0aWMgaGVyZS4NCj4gQnV0LCB0aGUgcmVzdG9yZSBmcm9tIHRoZSBjYWNoZWQgdmFyaWFibGUg
Y291bGQgYmUgZG9uZSBoZXJlIGluIGENCj4gc2luZ2xlIGxpbmUuDQo+IFNvLiBqdXN0IG1vdmlu
ZyBbMV0gaGVyZS4NCg0KWW91IG1lYW4gYWxzbyBkb2luZyBpdCBpbiB0aGUgbGFiZWw/IEkgdGhv
dWdodCBhYm91dCB0aGF0IGFuZCB0aGUgcmVhc29uDQp3aHkgSSBkaWRuJ3QgaXMgdGhhdCBvbiBh
IG5vcm1hbCBydW4sIEkgd2FudCB0byByZXNldCB0aGUgbWF4IGZyZXEgYXMgc29vbg0KYXMgcG9z
c2libGUgc28gdGhhdCBpZiBzb21lb25lIGNvbmN1cnJlbnRseSB0cmllcyB0byByZWFkICdkaXJl
Y3QgbW9kZScgYXR0cnMNCmdldHMgdGhlIG1heCBmcmVxLiBUaGlzIHdhcyBteSByZWFzb25pbmcg
YnV0IEkgYWRtaXQgdGhhdCBpdCdzIG5vdCB0aGF0DQppbXBvcnRhbnQgc28gSSB3aWxsIGxlYXZl
IHRoaXMgdG8gSm9uYXRoYW4ncyBwcmVmZXJlbmNlLi4uDQoNCkhtbSBub3cgdGhhdCBJIHNwb2tl
IGFib3V0IHRoZSBjb25jdXJyZW50bHkgYWNjZXNzIHRvIElJTyBhdHRyIGFuZCBiZWluZyBwYXJh
bm9pZCBhYm91dA0KdGhlIGNvbXBpbGVyLCBJIHdvbmRlciBpZiB3ZSBzaG91bGQgbm90IHVzZQ0K
V1JJVEVfT05DRShhZGlzLT5zcGktPm1heF9zcGVlZF9oeiwgQURJUzE2NDc1X0JVUlNUX01BWF9T
UEVFRCkuLi4NCg==
