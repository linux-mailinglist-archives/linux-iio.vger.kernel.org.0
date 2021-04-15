Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EFA3603C1
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 09:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhDOH4W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 03:56:22 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38874 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231423AbhDOH4W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 03:56:22 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13F7kjbV004824;
        Thu, 15 Apr 2021 03:55:47 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 37vyd214bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 03:55:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PW0t6XSouI/V1UaOtxmNd4AOKP9WeFw6d73pR2M2wu5txkrPRbkNHEA2XzJ/Yxswkd6WguJyxeAuUR3Uvw5lrjQukbhuscI7Xbc/74nfo4LEV3Wt42DqBPlQktSayqW2xZy7O0M7rWzN8PRNTGhrXSPI+WGf23Zn7JVlKCQXsIGdGS0SPbQSZtYGO57kjhWQ54Ck1gWPKi7nhNNWFyuYWq1IOd8rs8Hlnlse5p9fDAfJthp9YY4K3t+5Cdh7TX0bZkCB0xpED/+Vlka4PmN81JMaCmBnhdXjxPLo/sgnfCi3gRmlUtSSXirFRa5ywMbty20fHOOUJBlwTCK9fg6p9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8/CeHtlhBhXI7EZGPbN/iej0Ml5gyqy6Z8tTnezXLM=;
 b=H5g8WPMYVeE+6cok3L0K3ulHao1zGupnNeY6VcLLT/k9eZqi09SmcBGklLOuBysVSwys/9Km9Sos5TjmzuYT9YDundjueXGaNFFEUNBNJCNnn1yC5n92M4Mv04UibkrSw2uibRnYv0ggUJ1Cx6Fn8yltosQC/I2bZlWP3KkEAerAR41lFzZ7oI4FHMfODbVClwueI9V1eyuIweSe3HRGFEqhOmeveT0klj5RDZR0C5kVVyLe9N9mGR2DMdZ8Y4rX/Gao6T48sMKQS1oR9CvSgwTt3tk4Q58YrZi+y1kc/vwa384kYo4ZHtIZoFJhFGrA6la9mZOu7By8WO4/zzvKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8/CeHtlhBhXI7EZGPbN/iej0Ml5gyqy6Z8tTnezXLM=;
 b=YU2daG6WaleSAtRTlaP1s2QdxwUfDnchMEg5pGvhTo2kziYXED8fAXYGXUzwEQp5njtC5p/hX5r8PJPqT5kyjE8iUJwVtbvk17wWwmQp52Jp0BHtWTVr8sYXhhKWV6K/ujun5aBeEqjOpb/RgRiFMh1V75MIvAeebjDeqoMtaZE=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY4PR03MB2584.namprd03.prod.outlook.com (2603:10b6:903:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 15 Apr
 2021 07:55:22 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4020.022; Thu, 15 Apr 2021
 07:55:22 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH 5/7] iio: adis_buffer: check return value on page change
Thread-Topic: [PATCH 5/7] iio: adis_buffer: check return value on page change
Thread-Index: AQHXMFb1JtotqPZpYUS42sQpcXaFn6qzoGgAgAGYF5A=
Date:   Thu, 15 Apr 2021 07:55:22 +0000
Message-ID: <CY4PR03MB311209824D37230C89497995994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210413112105.69458-1-nuno.sa@analog.com>
 <20210413112105.69458-6-nuno.sa@analog.com>
 <CA+U=DsoZx3q3_620hYVcaA6AoHq2b-JUJPpzn0+C3Pc+USru0g@mail.gmail.com>
In-Reply-To: <CA+U=DsoZx3q3_620hYVcaA6AoHq2b-JUJPpzn0+C3Pc+USru0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpXTTNOV0k0T0RRdE9XUmlaaTB4TVdWaUxUaGlNMkV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHVmpOelZpT0RnMkxUbGtZbVl0TVRGbFlpMDRZ?=
 =?utf-8?B?ak5oTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpFME1D?=
 =?utf-8?B?SWdkRDBpTVRNeU5qSTVORFk1TWpBMk5qQTFORFUwSWlCb1BTSklVMVJ5VFdw?=
 =?utf-8?B?aFdVMDNaRGc0VVRKaGNuSnBTek5hVGpWVFdsazlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTlBOM00yZFhwRVNGaEJVbWxzU1RsMk5sZHJhMFJIUzFWcU1p?=
 =?utf-8?B?OXdZVk5SVFVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 8c447e9f-a0fb-4224-a5d1-08d8ffe3d256
x-ms-traffictypediagnostic: CY4PR03MB2584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB25842F9C902E213070CF0D6B994D9@CY4PR03MB2584.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5n1G8UHkkLizUgV+J81cKVthmAeB0KjBeDRbVgwk837C5WOT78OoJnCo/KAZj4M18VPZNlbQFS8M9ofQkyFTrsWPBYMKLAGVVhg9hhGGDVghFnmEwXOnfqo0b8fvyBQkgYudrr/scYQPRoTL0iHeeMyNvnqUngItnvLcYTdNJHB7+10zPfIaEt1ptUUinzcyBKcFRltvqO6CIuULW8e04LpyrtOhcanjR8lcaf0kt5Osat/oexKogyPa0y99UxZ+llRIct38lBEFjJw5xmwqPX1pCCMJpwIdqceuy0AY/cbcqAbIhNAEm6TKdhDmhw+XtfuYoI3MqUYoABpyYutfOwpAgpYhgbvSYAGM/bu/dudeD7wvqACy1jF2rPSbkZLLHFMFYsnC7B2/dXi5CGiyJDS/5C0dsjpuoKm0NkenpzaqJvSg2NzZ54rse4taslKnJwIRQbWcuJRk8UaGISWelVl/MBsaBPSdtF3n85yO6UuueFt/LTnH/7wG5Bpq/AzpPYeKYAHhMi4MIp6hxRkfZCB4VcIVfF0eNSHLWyiyjiPhZscVHhFRCjtTWT4zAFPU6aDvodPe85k6ST9ZGGgpMb8wcMCMrDTfEZ8F8v/dJHo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(66556008)(66446008)(76116006)(66946007)(122000001)(66476007)(83380400001)(54906003)(64756008)(316002)(2906002)(71200400001)(52536014)(38100700002)(6506007)(186003)(53546011)(7696005)(26005)(55016002)(9686003)(33656002)(86362001)(8936002)(6916009)(8676002)(478600001)(4326008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Qmo0QXVVZTdqK3p6eDFJdWMvNVRDWVVSQjEvN2llblFOTjY1c25sbUFVT1kx?=
 =?utf-8?B?azZyQy9nblVtT3BEMHg1U0FsT29qWEUvQlYxWUkyaVFYQVFZbXJUb2JGUGs1?=
 =?utf-8?B?cEN5YmtRcURzOUVlclVPb3VHUFg5dWNuMWNhOTMxeU44SFZMUkZsQmUzTGpL?=
 =?utf-8?B?VGhSVnVCeEVLTkFSOEVHN0lFLzR5aUtKVk8xY2VEYzBpMXNtSnI3TnhYSVd0?=
 =?utf-8?B?VSs1dVRCbDc1aEpVdHp5MXBFQUxLY2M5Mi9lSnBjWlJlNnZzaE51NW56NWFv?=
 =?utf-8?B?OUc2Y1pQaVRyN1BOazRPVjBRMTFERzA4dTcwNzhPSkNOZzR6SU5yY0hrN1FM?=
 =?utf-8?B?YThDTzA4dTFiaWlvQi9KNHdMU2c3aU1iOXhXYlIrVFY5VEdRdGw3YUhiclJu?=
 =?utf-8?B?NVdENUpyZmQ0QVlUcWRqZnVNNk9ZdE9aT3FGdDR2UnJEZXFGUEsxQmFQYlBN?=
 =?utf-8?B?YjFxb00xZXlDUk1xQ3IvRUxpUGY0TGIvUUhQVmFzVHhsbnBSTUVGb0JScU92?=
 =?utf-8?B?UkkybUdvUjZZcWtRRUtWelM4TWNjK1NXSkUyblhaM1RDQ3I5bFZBQTNjQnFi?=
 =?utf-8?B?MFhSNGZ1akdFK0RrS0tBNSs0ZnkvSzNiQzZwK1B3NE5MWVBWemxBb1BRcjdB?=
 =?utf-8?B?bUlmV01BQzNrL1AxbVlYNEM2NzRKY3hGVE1FZENUK3BKS1NRZDQyMG5HMlcr?=
 =?utf-8?B?aFdrVzFLQ2NUczVMZFRqdWF5TVRjRVlVNnVHekpOYjB4eURpRS9nTVlnSkVj?=
 =?utf-8?B?SHlKN25zWlMwRkkyVWZCZ3JzZ2xIRWpodmJ5Yk1iU0pyd1NMbFVrMEQ1MGR4?=
 =?utf-8?B?VjhlNHFtZ21lQ1JmUUl6c0paMmlKN1NvZG56TytPYkFFcUFSZDFOMWgvRkZo?=
 =?utf-8?B?VUxSNHJHcVpNcERCdnpUcXZjVEZJeEMycUJpcVkwd3hJRkxsQkt2Mk1BdkNR?=
 =?utf-8?B?TzB3ZlN6M1VpUUg0ZUNrZmhXY3VrU0txVERUYVhsWEZJelFkK0FKT002Vmtx?=
 =?utf-8?B?RW1oYm82akZSRW9KNGN4UVNSZXlRSlNtWUFnQVBySXh0NVBQOU1PWEJMbmNl?=
 =?utf-8?B?MXlVTWZHRGoxdXh3UnF4OGw3ZE92YnVHSkFLdHBEblNESXNIc2RWa1R1L1E2?=
 =?utf-8?B?YUcrZkhOSnc0bkhqb2VjUFFtQ3Vua2VwaDdGMkxacjI3WUVOY3kwQkVMazZ4?=
 =?utf-8?B?c2dLZGxWS0loc0EwdzVwOStNNjNaRnZQNkp3bERtY1RJNmpUTmtoeWlYRjdL?=
 =?utf-8?B?K0Z0ZFpUb1doY29ZUHRXNGFZL1d0Z2FtSEZZcXpPOG9TNHFmNDBKc0FpZk9B?=
 =?utf-8?B?dUo5Y3MwdXVDWnJ3Mm00RFBNM3FncnhYUWdkeWt4R1JEeUdRMSsvWVFTOGhr?=
 =?utf-8?B?aERjTmJIQlVvK25ZaDZiT1czTlllNmhuQUlZOGkzbGlCdGh4Sm0yYnN0YWc2?=
 =?utf-8?B?SXlVRGVWVzZEUFVud3B0VFc1aSs5QUN1dkhabHFBMmFJamgwRk9SMU5iM2ZH?=
 =?utf-8?B?UGF2dGtoT3Avakt2ZnBtenJUQWpSMUJTem9ORExjVmsxWE94ZzRVMURlK1Bl?=
 =?utf-8?B?ODJaSTB6QTNwRmp5KzdlbFUxeTg4anJXMnVYQXFBdzJRcGZqNk5GY2FsVTF4?=
 =?utf-8?B?NnNDU1RxL1pNRXVQaXpQREdtSDUwZlAycjdPZk5CLzB5OEN4YTEyNFNkMzZU?=
 =?utf-8?B?V1I3bVlqd3FRTC9DMzZxV1lJR0kvRGZpRnM1RDBkQ2xpSEhPNVB3cjZBOTNl?=
 =?utf-8?Q?Wv0QhcIP6C+kJ9CaZaiFCw030PZRfSHEB/5Tge5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c447e9f-a0fb-4224-a5d1-08d8ffe3d256
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 07:55:22.2856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9k/htzocJTRWeV8w5orhVMJ2V6gb02bSBl4A1HCWg1fPRsk3g1bPVTylZS9HrWb3vB+BOXZoMglmHempVyGLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2584
X-Proofpoint-GUID: MdyQ0B144dojYt3-jiVM6nwrt18Q3t1Y
X-Proofpoint-ORIG-GUID: MdyQ0B144dojYt3-jiVM6nwrt18Q3t1Y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150051
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZHJ1IEFyZGVs
ZWFuIDxhcmRlbGVhbmFsZXhAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE0
LCAyMDIxIDk6MzQgQU0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENj
OiBsaW51eC1paW8gPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBDYW1lcm9u
DQo+IDxqaWMyM0BrZXJuZWwub3JnPjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhl
bm5lcmljaEBhbmFsb2cuY29tPjsgTGFycy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28u
ZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS83XSBpaW86IGFkaXNfYnVmZmVyOiBjaGVjayBy
ZXR1cm4gdmFsdWUgb24gcGFnZQ0KPiBjaGFuZ2UNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9u
IFR1ZSwgQXByIDEzLCAyMDIxIGF0IDU6NDUgUE0gTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29t
Pg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIHRoZSB0cmlnZ2VyIGhhbmRsZXIsIHdlIG1pZ2h0IG5l
ZWQgdG8gY2hhbmdlIHRoZSBkZXZpY2UgcGFnZS4NCj4gSGVuY2UsDQo+ID4gd2Ugc2hvdWxkIGNo
ZWNrIHRoZSByZXR1cm4gdmFsdWUgZnJvbSAnc3BpX3dyaXRlKCknIGFuZCBhY3QNCj4gYWNjb3Jk
aW5nbHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOdW5vIFNhIDxudW5vLnNhQGFuYWxvZy5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaWlvL2ltdS9hZGlzX2J1ZmZlci5jIHwgNiArKysr
Ky0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzX2J1ZmZlci5jDQo+IGIv
ZHJpdmVycy9paW8vaW11L2FkaXNfYnVmZmVyLmMNCj4gPiBpbmRleCBmODliY2UxMDA5MGEuLjdh
YjE1YzA4ODg5ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvYWRpc19idWZmZXIu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzX2J1ZmZlci5jDQo+ID4gQEAgLTEzNyw3
ICsxMzcsMTEgQEAgc3RhdGljIGlycXJldHVybl90IGFkaXNfdHJpZ2dlcl9oYW5kbGVyKGludA0K
PiBpcnEsIHZvaWQgKnApDQo+ID4gICAgICAgICAgICAgICAgIGlmIChhZGlzLT5jdXJyZW50X3Bh
Z2UgIT0gMCkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGFkaXMtPnR4WzBdID0gQURJ
U19XUklURV9SRUcoQURJU19SRUdfUEFHRV9JRCk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgYWRpcy0+dHhbMV0gPSAwOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHNwaV93cml0
ZShhZGlzLT5zcGksIGFkaXMtPnR4LCAyKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBy
ZXQgPSBzcGlfd3JpdGUoYWRpcy0+c3BpLCBhZGlzLT50eCwgMik7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZGV2X2VycigmYWRpcy0+c3BpLT5kZXYsICJGYWlsZWQgdG8gY2hhbmdlIGRldmljZQ0KPiBw
YWdlOiAlZFxuIiwgcmV0KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdv
dG8gaXJxX2RvbmU7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiANCj4gVGhlICZh
ZGlzLT5zdGF0ZV9sb2NrIGlzIG5vdCBiZWluZyB1bmxvY2tlZCBvbiB0aGlzIGVycm9yIHBhdGgu
DQo+IFRoaXMgcHJvYmFibHkgbmVlZHMgYSBiaXQgb2YgcmUtb3JnYW5pemF0aW9uIG9mIHRoaXMg
YmxvY2s6DQo+ICAgICBpZiAoYWRpcy0+ZGF0YS0+aGFzX3BhZ2luZykgew0KPiAgICAgICAgIGFk
aXMtPmN1cnJlbnRfcGFnZSA9IDA7DQo+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZhZGlzLT5zdGF0
ZV9sb2NrKTsNCj4gICAgIH0NCj4gDQoNCkFyZ2hoaCwgZ29vZCBjYXRjaC4gTm90IHN1cmUgd2hl
cmUgSSBoYWQgbXkgaGVhZCB0byBub3Qgc2VlIHRoaXMuLi4NCg0KVGhhbmtzIQ0K
