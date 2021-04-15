Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A3A360381
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 09:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhDOHjb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 03:39:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30964 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231329AbhDOHja (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 03:39:30 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13F7aRQv022429;
        Thu, 15 Apr 2021 03:38:55 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-00128a01.pphosted.com with ESMTP id 37vyd2132g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 03:38:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0T3wkn+pNlm0MtZZBaMnkS1ndRIQA5TrDIeO7e4hP+mIrMIIRMTk0rts8DPq3mvus3Er5l7gUvJy+aJtlQ7qMPwQhTVguBuIL18Tg89yfSt3adCF8h5ho9oIr2tMlLAyP3wo1fq+qml6Z5xkO688K0stytGtD3ImB9cgl6Wk9tBFCuXEfB00710ea74BY4XFLt51nj8V5jt9+0Vb89TBAgJAl8Oe1jOHIiPZiQzRPrPznqWLMmKjm87jQr4VwNHs4+9YBt4hnSas+ExkRFpPbQ36Lj4xD7fdOU6c+HieePUxyQiOCrhoPC4XPo7UM2/iSn4OausU+FIwiI9sohGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EzBp5hJ/gNbQUhatqRLU3Vk8pRLrT25o82Wtin3FPQ=;
 b=QrLNLu6MPCI2mGHl336UvmNIn6cFwqJVFmufdnCYFoBEEG/4zkNK+yUmEvC1S73c6nzilGQb0o+mYm/VGb7xATvjnL7r1QeVbMKK9hl/VzBeSzEwpRl78AFLQZHuJh7t+YpOO0QJldVP78LAVW9Kkdpomj2HzRs5avcwCn8v0+/4V9XQr3Xv9GN7qNh4tdtqOYJGzOj/0ZsGivs815hlLX/1D7HMI1494c37kPXqt5Admc87UxGSofPQ+IF0s4c7ocWRiYI5HT8WUAZr17SdTMNOhcYQ4wQJYf2a6PNt7YrSssEN0CwVRUNEJ2rW6laqNDRjjfyf9WzLSJntDeH/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EzBp5hJ/gNbQUhatqRLU3Vk8pRLrT25o82Wtin3FPQ=;
 b=qDRoNdIWKk3iOc/A67PslNlxNuceV6XLh+6pDVBfeZwwMbuHSm7jLRhflBL590C1XigXfMXimIk+n+RE1qCP/wHjbD/npPvg1Sg7ch5MxaVC7OOQQB9orzPNmCcpd8oECx6DQ5CX9QxyYBg0lo0uSOeoMIgjsW3y/vqFvEliI2I=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY1PR03MB2249.namprd03.prod.outlook.com (2a01:111:e400:c615::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 15 Apr
 2021 07:38:51 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4020.022; Thu, 15 Apr 2021
 07:38:51 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH 3/7] iio: adis16475: do not return ints in irq handlers
Thread-Topic: [PATCH 3/7] iio: adis16475: do not return ints in irq handlers
Thread-Index: AQHXMFb19uVbktdYfkaZ0rccs16Wy6qznpKAgAGVBDA=
Date:   Thu, 15 Apr 2021 07:38:51 +0000
Message-ID: <CY4PR03MB3112FE37268179DA1ED3436C994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210413112105.69458-1-nuno.sa@analog.com>
 <20210413112105.69458-4-nuno.sa@analog.com>
 <CA+U=DsqFJ_qJk_vnyvxJeN0Cfm9uN82RfWmvrNV5uDX7qgWPGA@mail.gmail.com>
In-Reply-To: <CA+U=DsqFJ_qJk_vnyvxJeN0Cfm9uN82RfWmvrNV5uDX7qgWPGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE9XUTJPRFpqTjJVdE9XUmlaQzB4TVdWaUxUaGlNMkV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEbGtOamcyWXpnd0xUbGtZbVF0TVRGbFlpMDRZ?=
 =?utf-8?B?ak5oTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRZNE1D?=
 =?utf-8?B?SWdkRDBpTVRNeU5qSTVORFU1TWprd016UTJNemMySWlCb1BTSjZRbU5pYVhj?=
 =?utf-8?B?NU9GcHFjRVkzUlU1bldHZGtWSGgxVGk5RFJrVTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTkpNRGhDWm5scVNGaEJaWEJXT1VWNVlYaEtOelkyYkZnd1ZF?=
 =?utf-8?B?cHlSVzUyYjBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 9b48cf30-d046-4e8e-4cf1-08d8ffe183c6
x-ms-traffictypediagnostic: CY1PR03MB2249:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR03MB2249576890991F62077776BD994D9@CY1PR03MB2249.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZhXCfFP5w7o3S2GDomx2VGNvoElib1JgygqCOe2+XIyVdZTQdlILGMeG8+4ukVE4HM9xBndtCYjJc4wlBLjKl61DfO+8ghlWA4Y1fR4f1wSCDv7J6tTrEx17XLML8WVdeRHCizTjxaHjC1kLIt+ZDpLCJxS4wOlh30BFufkhs3Ow91CkhaLK2GTOkZIgo3Es33fuV57jbSfXOjj2vcM49Shqe/Mm5G1WANFoAwhkbmLlnyiZy1DLcuaX+WoTL6x4fJ33O6e92HOLGd9PLrDQxdsSRUgRrrNAXfcmowz4ZwVotb5j+8P1G3pR0i1nElycywY3EMZfjM3RjS+w96+DqE4/gWd6BmWpGAc1eq+FQqOROFZwJMN+mNXgYSNtH3tptG+QHIkS8O0++vUiHUPSIbwZZ+AYq8kEQGQ30vx0S+CF9OKY4Q2x2nBA4DBjNq7lMr0F7BLOYhsq9WMBNyKbhU2qGDGlZQrdC/F51ETb5OoXMPzG0Ay8/ekXR/7eVvk279UY6T2T1L/U0v+mOrIe8irIY71BDb60LJYpFX6yQFD4vpMI22Xg5bZ4Jj0IwBI5Wygo16+o5TDhnxs10fXtqpHeOnQu1ZvhCjpX0iiZ0j4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(9686003)(76116006)(66476007)(66446008)(66946007)(66556008)(316002)(86362001)(26005)(2906002)(54906003)(4326008)(53546011)(83380400001)(6506007)(64756008)(478600001)(186003)(7696005)(8676002)(33656002)(6916009)(38100700002)(52536014)(122000001)(8936002)(5660300002)(55016002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NkszckRJbHp2N21RdFB1YW5GcDBIV1BkQWh5b2JFdXRhZ05aOWMwNVZvTEQz?=
 =?utf-8?B?U2R1bHduQlJySVBieTdKM0hGbFF5amU4UXBkSTJ5WHIwNldFb2FDbHQ3NWhO?=
 =?utf-8?B?VDA0ZjgyWUNaNFJXWVdWWDdFTTJreDk2bDZuT1ZWMkpiZlZ5SGNDbC9URCtu?=
 =?utf-8?B?TXZlMUJaclkzVldOQVprYUw4QWZXa2ExOWpTTk1pa2hkTjhqL1RiZk4vTXNY?=
 =?utf-8?B?ZnJKdVQxVWRYT1oxTWxpdmd0RjcrREZ5Y1lsTnh3VnMyNTFuYWdHbWZSZzk5?=
 =?utf-8?B?ZzVzUzFtcFBFaDQ1TktCbHY3bFBMcWVxMHh2VnlnTVBMenZuSHVtYUxsTzhY?=
 =?utf-8?B?Qm00THBoalp3V0R2bFJLUyt3bU0wTUZyN1FjTzBKVEhCQndFR3p1WjBwUnRq?=
 =?utf-8?B?Y1FYL0pGUHRESnBxekJqRVk1Z1k4MGRpMG5HcmRwVzZmVkFETzhSNTFiSlp6?=
 =?utf-8?B?aXpWREhEUTdBaC9wZVBuNTFWaVdxdlBCL0RTWkhxaTk0K3VyQkdwUE96L29B?=
 =?utf-8?B?WGJZSCsvR0w1SjNYZmRPcDdpWitybXFzOFg5ZkJMaWtqS1d2QTdURjcxMnVp?=
 =?utf-8?B?b2NkWk9PaGszalZnNytKblhHVVBmQ2QxT1I0TU9uVUZIaFlKaDdNbjhOMGM1?=
 =?utf-8?B?Qk12c3hyUklsR3VPTHlpdnJtZzF1SHc1QTBDc1NrRU9MUGVWdVE5NkRuYnNm?=
 =?utf-8?B?dU1YcG1RbzJIUGd1ZVZET0wrUUxTdnRtWUdRTlhCOHByQWhsM2JiVlp0YW8w?=
 =?utf-8?B?OTI3ZEhCUmVzd3IrK0FzU081VlQvS2U0dVBXSW9IRUUyekxBTmFhVk8wS0lm?=
 =?utf-8?B?NERRMWI1cDVScGFiSGE0MzVubzZaaXFJdlQ3MFFoZXcrOHpRZUpiUUJ3OE5m?=
 =?utf-8?B?cFV1QnFlazl4VHZ5TzFteW5ORDZ4MFNPSTdxUEFJQXNHdm8rSHo4RGt5ZlRT?=
 =?utf-8?B?bVJPQTlZZ3NXYWE2RUlpeEkrT2Z1WDFvNE82UEZCcC9XV1A5U0I2L1hsbTYy?=
 =?utf-8?B?b0RSZEpyRmt4WThDMGVaRDljM2dMZGxvL2gvOTEyb0VsdXBSZ3V2KzZYYlRD?=
 =?utf-8?B?UEhGMmNzZzE1TzQ2elgrV2dyME9GNUF5NHNjcnBINGVPZHc5ZnhMUDVPVDJH?=
 =?utf-8?B?ZGVXWlh0WVR2YmdiVnF0ZFhLaHNiaStPUE9TWjBWN1RSQmo5Vk1iWWxaNHVH?=
 =?utf-8?B?a0k1aFYwQXdlVWh2ditpdW43NnBZOXlFTUZTb25PRTA5Y1J3MUxISDUrbjFu?=
 =?utf-8?B?WXZWZ0NGajlCMDF4eEJlQ1l2WlRmOFVEcVJxYUdJZ0F0cUh4VmV6OWh2U1Vj?=
 =?utf-8?B?N1RHOG5iQUxaVXlWR1R0M292K2hjd1BCRmh3S2FaMWU1ODhvWE9zSUNRS1pz?=
 =?utf-8?B?OGdVTzRUazRBTm5aZTlYOEJrNzBNcUIzenNJNHB4R2tRWFVoOFFoSURVWC92?=
 =?utf-8?B?Um9Scm9vRVA1cGdRODBWNlU0SzVWRFJSSFB1SFI3Z1pnZUtpelpoVU9VMTFq?=
 =?utf-8?B?eDZZME54ZW1EMGxUVjlTalg1WTA2YlhtQTBnd1dSU2VhN2VKVlpycm9VWXor?=
 =?utf-8?B?ejBzdi9lL3J5Yys5c01VdW5MSC85bTF5QStoWjhCakhpZ1d4VXI5RjRxbFBW?=
 =?utf-8?B?bldGcklITTR5ZlkrUFFzaDc1cVdkMGJBNm1KME50aUQ4Q1N1aUQzSGR5RlZI?=
 =?utf-8?B?YXdOcGFpUk9KdjB0bG5jUG9FeE1zdVFNSFcyRjRSREFuVXl2cUhtVmp2TmdO?=
 =?utf-8?Q?V436iRmveLpJPQ91ElbkUwnKV7wKYd5YJjtfLC9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b48cf30-d046-4e8e-4cf1-08d8ffe183c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 07:38:51.5123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WFVeLTuExrS7ueZ7/jjU0VE+A4sdQ652mapiNxnlsnRvaYkbAcWqkeiaTn829ksFrg+AX1R0axAC3eXYi+0K4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2249
X-Proofpoint-GUID: fkRhZYTNNPdX8Vvf_PZ0StSaKcEN_09h
X-Proofpoint-ORIG-GUID: fkRhZYTNNPdX8Vvf_PZ0StSaKcEN_09h
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150049
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQo+IEZyb206IEFsZXhhbmRydSBBcmRlbGVhbiA8YXJkZWxlYW5hbGV4QGdtYWlsLmNvbT4NCj4g
U2VudDogV2VkbmVzZGF5LCBBcHJpbCAxNCwgMjAyMSA5OjI3IEFNDQo+IFRvOiBTYSwgTnVubyA8
TnVuby5TYUBhbmFsb2cuY29tPg0KPiBDYzogbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJu
ZWwub3JnPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8amljMjNAa2VybmVsLm9yZz47IEhlbm5lcmlj
aCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IExhcnMtUGV0ZXIg
Q2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvN10g
aWlvOiBhZGlzMTY0NzU6IGRvIG5vdCByZXR1cm4gaW50cyBpbiBpcnENCj4gaGFuZGxlcnMNCj4g
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFR1ZSwgQXByIDEzLCAyMDIxIGF0IDU6NDUgUE0gTnVu
byBTYSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIGFuIElSUSBo
YW5kbGVyIHdlIHNob3VsZCByZXR1cm4gbm9ybWFsIGVycm9yIGNvZGVzIGFzDQo+ICdpcnFyZXR1
cm5fdCcNCj4gPiBpcyBleHBlY3RlZC4NCj4gPg0KPiA+IEZpeGVzOiBmZmY3MzUyYmY3YTNjICgi
aWlvOiBpbXU6IEFkZCBzdXBwb3J0IGZvciBhZGlzMTY0NzUiKQ0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2lpby9pbXUvYWRpczE2NDc1LmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlv
L2ltdS9hZGlzMTY0NzUuYyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0NzUuYw0KPiA+IGluZGV4
IDFkZTYyZmM3OWUwZi4uNTFiNzY0NDRkYjBiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlv
L2ltdS9hZGlzMTY0NzUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0NzUuYw0K
PiA+IEBAIC0xMDY4LDcgKzEwNjgsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QNCj4gYWRpczE2NDc1
X3RyaWdnZXJfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpwKQ0KPiA+DQo+ID4gICAgICAgICByZXQg
PSBzcGlfc3luYyhhZGlzLT5zcGksICZhZGlzLT5tc2cpOw0KPiA+ICAgICAgICAgaWYgKHJldCkN
Cj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArICAgICAgICAgICAgICAgZ290
byBjaGVja19idXJzdDMyOw0KPiANCj4gVGhpcyBpcyBhbHNvIGdvaW5nIHRvIGNhbGwgYWRpczE2
NDc1X2J1cnN0MzJfY2hlY2soKS4NCj4gV2hpY2ggaW4gaXRzZWxmIGlzIFtwcm9iYWJseV0gYW4g
dW5kZXNpcmVkIGJlaGF2aW9yIGNoYW5nZS4NCj4gDQo+IE1heWJlIHRoaXMgbmVlZHMgYSBuZXcg
J2lycV9kb25lJyBsYWJlbD8NCg0KVGhhdCB3YXMgaW50ZW50aW9uYWwuIElmIHNvbWVvbmUgY2hh
bmdlZCB0aGUgZGVjaW1hdGlvbiBvciB0aGUgRklSDQpmaWx0ZXJzIHNvIHRoYXQgd2UgY2FuIGNo
YW5nZSB0byBidXJzdDMyLCB3ZSBjYW4ganVzdCBkbyBpdCBub3cuLi4NCg0K
