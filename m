Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1470401872
	for <lists+linux-iio@lfdr.de>; Mon,  6 Sep 2021 10:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbhIFI6e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Sep 2021 04:58:34 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:21180 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241107AbhIFI52 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Sep 2021 04:57:28 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 185Mm5g9020657;
        Mon, 6 Sep 2021 04:56:10 -0400
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by mx0b-00128a01.pphosted.com with ESMTP id 3aw5n4t7mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Sep 2021 04:56:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lN9CAUtwwwvKAFJR15Eb/qybK6NnZMfeH0PnrhlLgbVarcBplBeGzqiYY0wXqRdemNBNg5BQRZ9p5T0W1nFymUkvFVhWTZuagf+QE6D1CrJpFxQAJzuXOuycARcZKb7gdk4nLtGT4scusKzGEJo7auDonhRVBCElVDAXMvZRhFttYZWkl/sSIWtUt/ckRd30o0ZINcGMzcnVAe8hZvvhBGpYp4FK/VlnfEELmGADxVREk0Nrjb5zQQvzqAUg+yTikuQN9YMJZOPg5QwdfJYbJmtcjo2zIzq/Bvfaa6pnEgddtl4owj2zDtIWiF7WIuPhZOZYDH+YxC7oleBFwofdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=i46vRPigUqRrWYA574WrzoRk4z98XxKi6hQyfponjps=;
 b=URcPx4SIJOQNJB1kq5uA28xPqbIf28iy9wVOY8o+RvJpDWRgRDCQ1qRJ1BJKLD+iMSl/rhHnCOVvYa0icsTeZrHSXWAYv8wCdJlbH6mANl46WYfj1GinEZm7MuVqChop1QBAbZpzS7gnoDv+k9c2FeoNjrzuep4GZ5ggVckm2LyGdWjC8m+xK3LFgUf5yIYQyLwxPM8VksVpLkX6Pja+Lj1awuMM/fnM0RqP3SLQYVdavUfpoJ9sdKlMjaYEbvabKLTiLajyBcHybhEVzIiGdpolV/nbQlWqTk12pzCrdSFHCj+K2Sq+hRIFkBbyzuxQITVrUOzU9W7wZ4W+Ki5PKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i46vRPigUqRrWYA574WrzoRk4z98XxKi6hQyfponjps=;
 b=b16CNBDjbzbkIP8taw9LJAu0iHBIwlSIgwRQXDVs8rphek60KY0qiQsRFBvbVeq576obFap0f84FG37AgfJTjW77osl6gH1CCrtre9sNE0GaxCrfCj9UJURZcycmCk6JktJmgGGU20ZUVrEz2n1zeVdD5gGqxdvDLP3JkdTekTU=
Received: from SA1PR03MB6355.namprd03.prod.outlook.com (2603:10b6:806:1b6::10)
 by SN2PR03MB2159.namprd03.prod.outlook.com (2603:10b6:804:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Mon, 6 Sep
 2021 08:56:09 +0000
Received: from SA1PR03MB6355.namprd03.prod.outlook.com
 ([fe80::f0f4:64cb:bc0b:95d9]) by SA1PR03MB6355.namprd03.prod.outlook.com
 ([fe80::f0f4:64cb:bc0b:95d9%9]) with mapi id 15.20.4415.024; Mon, 6 Sep 2021
 08:56:09 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [PATCH 0/5] Fixes and improvements to the ADIS lib/devices
Thread-Topic: [PATCH 0/5] Fixes and improvements to the ADIS lib/devices
Thread-Index: AQHXoM377AuAwLIJnUSfloTx4f2YLauVdU+AgAFCroA=
Date:   Mon, 6 Sep 2021 08:56:08 +0000
Message-ID: <SA1PR03MB63555CB3B2C5A6B5D9BB3BA199D29@SA1PR03MB6355.namprd03.prod.outlook.com>
References: <20210903141423.517028-1-nuno.sa@analog.com>
 <20210905143933.4f492b78@jic23-huawei>
In-Reply-To: <20210905143933.4f492b78@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5EVXdabUZqWTJNdE1HVm1NQzB4TVdWakxUaGlPR1F0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEUTFNR1poWTJObExUQmxaakF0TVRGbFl5MDRZ?=
 =?utf-8?B?amhrTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpNeU5p?=
 =?utf-8?B?SWdkRDBpTVRNeU56VXpPVEl4TmpZMU5URXdNekkySWlCb1BTSlVObTh2T0Zo?=
 =?utf-8?B?blJERlZPRTgxTnpSWGNHVTJlRXBTZGxCQ1pVazlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTXljVEpyU0M5aFRGaEJXRUZ6YTJGSFZrTlFSVEJqUTNsU2Ix?=
 =?utf-8?B?cFZTVGhVVVVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVmh0V21kcWQwRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 277af4fd-f170-48a0-bb09-08d971142b87
x-ms-traffictypediagnostic: SN2PR03MB2159:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR03MB2159751DEFA56991E0554DFD99D29@SN2PR03MB2159.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qVt48UTbN9zZlXSMulknMUPGJlPAvQhZxDcfhrkdvhVQy7kTwNFd+FtK+oj+clFn7Mnj8fsEssRVdYwJPXywPXfiGV5hrGWE609dxGlNVu8LyGssVgXQV7XQU9+O36WnwkDQqO1V9y7cF86AqqhmaQLyj46JD39u78ILWBAHcxgD5YW6ceHoxaP3lWdBdp2CUoo0z83qCv96al1+vGOWtoOnDrGv5oQVtFJjyzrEUQFO6lFAmDJQCp0gchGUutFYwptq/kU+fTW48tZOwbKps1Pt1zigDj0HMOrXmVoUys3Cq4ct+qsZC4sJvDQfszajPZMW/NSRJytaWHyC3kQ6G9A/uo33fm/1LPQS3+HEI4dV7UNl3pVnS2hPMqMQIUEvy/SfB/s0XIXqliR3tu65C+lNU4wiwecRQJnoTDzkgyYiiLxKzvd1uDD7ta412shUIyYfhZEPrvsmywFnG5nJ7Fp2JRdvsJQI+3LApYkm4/e2idrWSp29nCmIW86SanwShEBIi5ZFoSDK/uDMeUgEIEb9yQ0glXu2aR6Q239HkHDCikba+K2gRZfJfmzTJqogDo1OJLzXDr1FTJjXVM9u2sGeqyszGgsefevCUTR7m9YVCnJ+89zLBs0RJ4v+xC4YIE09qiOgPqCtcjJKeKY6TB7y9idTmbyQAFx6qOPnvUcHfBnHQTDRQfOwroptw9su3tZpTE5HFbu99mzbJYE5hA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6355.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(26005)(107886003)(186003)(55016002)(66476007)(76116006)(6506007)(54906003)(38100700002)(122000001)(6916009)(478600001)(38070700005)(9686003)(83380400001)(7696005)(86362001)(4326008)(66946007)(2906002)(5660300002)(33656002)(52536014)(8936002)(66446008)(71200400001)(64756008)(316002)(66556008)(8676002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1R6TEpjbjlLTS9NazR1S3pNd1ZrSjFoTkp2RWFRK1NkSWhUYVBmazVQS25x?=
 =?utf-8?B?SFV4QkRqLzBsbHJHWENXQm1WNE1HMjd0VGZNK2F0K1lrd2tzRDVYUTNBVFp3?=
 =?utf-8?B?UXA3dGxxaWgxakxsMFB3LzJxbkhjVENOKzFCbGw3cXhyRVJISTYwUWRQdFVp?=
 =?utf-8?B?eHpJSi94TGg2R29mZUZDenp6ajNzMElvTHRCT1hhaXZRdWtLMTNtQVFNWktO?=
 =?utf-8?B?UDlmNmNHb0dYaEJNRUtjVjZmYThtckdHMEFweFlaY2JGS0ZyYjVWbTlhQnov?=
 =?utf-8?B?MDB1OERuNlNHNUh4UGRiRmRCWG9HeE42YWdFbkU5eXNqUGZPUStxR3d1Rnho?=
 =?utf-8?B?cTFuMDJQcHBFdU80bzcyV2pLdlBoeWlwbjRHYjlsVnFwc0NxTC9KM0xpMUwz?=
 =?utf-8?B?ZCtZTDNpaWNZcUlmMzNNK01SdHFNT0k4SWhZYTFnZkhrcHRLbDFOSmpvTUto?=
 =?utf-8?B?cVhWUFcxaGw5alNBaXRta0hFc29UVXFwVjRCdHBGcXNYNDFKSkM0Sjl1c2hH?=
 =?utf-8?B?TW85amY0ajJOeWRVMDVQaVhhNGUwV055cWpJdm9vUWkzVjR0ck9JMXU2bDRU?=
 =?utf-8?B?Q3h0eERLTy9lbnNocWZjZmtPdkJtNmtmMmhwVGxWQWM5OHR1SEZSUzBjWnMr?=
 =?utf-8?B?SEVZRjFYdnRHRFpEd0JVOUwvaGVia29KUFI5aW03S2p0Mmd0eHdmaExuT216?=
 =?utf-8?B?eVJZSkxiaXQ4ckFBYkJCNGpTS2ZhS1hXU2M3MUJXMUlwM05tcWNnVmRkZExx?=
 =?utf-8?B?R2RhMkRWamk2SXdPMVhyZmRoRlR1ZXpabnYxMnZ4RTkwbGxJQiszaHBCVnFR?=
 =?utf-8?B?RmxWeFZCSXRrTEF6MFQreGdYQ3JsY0VnaWQrZXdtbjlQMm9vYUEvZVZUMTVJ?=
 =?utf-8?B?K3NJTjRMMUl6ZXpESGxEZHFyVUpFM0kydjN6bGx0TWd5NHlnT0lVRlFCRlhH?=
 =?utf-8?B?L2pTc3Z6M2lPSlAyODEwSEptOXFWRXRvS0dOSzZObndPY2FKQ3RVYU9mc3NZ?=
 =?utf-8?B?bVpscWlqVFlBdXZKME55eVQ4blZwN0lrS0lGRmxGcGxxZ3F0YXRtazFrTjFQ?=
 =?utf-8?B?RUNQN2lOaDc1MXQrUzBpaTh4dzRVREJXTE8rcnFaSUJhNEVLQ2tiaGRNcEtx?=
 =?utf-8?B?ZjBvb1RqODAxL2FacHZITmEzT3pQWVYwcjN2cEZQSHVXcDJkdmUzMmlQekxZ?=
 =?utf-8?B?d3RZZ0l0S3BpdlNMTGpOam5OZDF1NWh0bmRMWGJVZit0ZDJXSU0ybThaZEt1?=
 =?utf-8?B?S2VpT1JIZGZnVEF2SmNHclNJMzBpRWtwSDgvSk5sRnhBMWYyZFZ2bTg2VE1Q?=
 =?utf-8?B?RGptaEtOK1VuaitKZHFva3hPQkFTL0hSZnRFZHhNZklpOVFRWHk0NnQ0UWVZ?=
 =?utf-8?B?NEtwTlBxeGpuclFHeGllYVFpWEwySmVqdVdnL2loeUFHeEtlUXBwUjl5d0RT?=
 =?utf-8?B?SHpuWFU4N2F1WWpPT2tpMWtyL2kvc1V1UlZBNlpsbHVUZEorRFlJaGYyeGlU?=
 =?utf-8?B?NWYvTXFHMHpaTncwa2N4dmVhTklybVN0SVNoZW9sMVdPaXY4T3dtckhvV3U0?=
 =?utf-8?B?N1VsdDRFWTB3SWo1dFhQLzlpUHBrTTYzSDZFeGsyVHN3NHJrbnU5eDJydEpU?=
 =?utf-8?B?TVNMS045SHhqKzlkaWRNMys1QzBYN0FxNWhQMU1FRmRHdVBVYW4yUEFOeDNH?=
 =?utf-8?B?WW9CTEUrbUtucDVzeXdGTy9lOWYrcnN4SVR2OGdvK3ZyZDhuaElvTGZLbkVz?=
 =?utf-8?Q?JNShte5f9Tg6pPJXcuveWGxLZchjlEaBD/D2M/t?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6355.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277af4fd-f170-48a0-bb09-08d971142b87
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2021 08:56:09.1433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyrvwXQm9FBWuPwSKBNBD5kptV/+KmJ7tJRlbuoe/1Z/vBt5LojA/wfeRUHfkjGnvIkCfXES4I3WV51sQJdwMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2159
X-Proofpoint-ORIG-GUID: 1bSKpXVy42082Cn9-4P6vFABVmsUKFy2
X-Proofpoint-GUID: 1bSKpXVy42082Cn9-4P6vFABVmsUKFy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-06_04,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109060056
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCBTZXB0ZW1iZXIgNSwgMjAyMSAz
OjQwIFBNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiBDYzogbGludXgt
aWlvQHZnZXIua2VybmVsLm9yZzsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+
Ow0KPiBIZW5uZXJpY2gsIE1pY2hhZWwgPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBC
b2dkYW4sDQo+IERyYWdvcyA8RHJhZ29zLkJvZ2RhbkBhbmFsb2cuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDAvNV0gRml4ZXMgYW5kIGltcHJvdmVtZW50cyB0byB0aGUgQURJUw0KPiBsaWIv
ZGV2aWNlcw0KPiANCj4gT24gRnJpLCAzIFNlcCAyMDIxIDE2OjE0OjE4ICswMjAwDQo+IE51bm8g
U8OhIDxudW5vLnNhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGlzIHNlcmllcyBhZGRz
IHNvbWUgZml4ZXMgYW5kIGltcHJvdmVtZW50cyBmb3IgdGhlIEFESVMgbGlicmFyeQ0KPiBhbmQN
Cj4gPiBkZXZpY2VzLiBUaGVyZSBhcmUgdHdvIGZpeGVzOg0KPiA+DQo+ID4gMSkgT24gdGhlIGxp
YnJhcnkgJ2FkaXNfaW5pdCgpJyBmdW5jdGlvbiwgYSBjYWxsIHRvICdhZGlzX2VuYWJsZV9pcnEo
KScNCj4gPiB3YXMgYmVpbmcgZG9uZS4gVGhhdCBkb2VzIG5vdCBtYWtlIHNlbnNlIGJlY2F1c2UN
Cj4gPiAnX19hZGlzX2luaXRpYWxfc3RhcnR1cCgpJyB3aWxsIHJlc2V0IHRoZSBkZXZpY2UgYW5k
IHB1dCB0aGUgZGF0YSByZWFkeQ0KPiA+IHBpbiBpbiB0aGUgZGVmYXVsdCBzdGF0ZS4gRm9yIHNv
bWUgZHJpdmVycywgdGhlc2UgY291bGQgbWVhbiB0aGF0IHdlDQo+ID4gd2VyZSBsZWF2aW5nIHBy
b2JlIGluIGEgc3RhdGUgZGlmZmVyZW50IGZyb20gdGhlIGRlc2lyZWQgb25lLg0KPiA+IDIpIFRo
ZSBhZGlzMTY0ODAgZHJpdmVyIHdhcyByZWdpc3RlcmluZyBhIG1hbmFnZWQgcmVzZXQgYWN0aW9u
IHRvIHB1dA0KPiA+IHRoZSBkZXZpY2UgaW50byBzbGVlcCBtb2RlIGluIHRoZSB1bmJpbmRpbmcg
cGF0aC4gV2VsbCwgbm90IGFsbA0KPiBkZXZpY2VzDQo+ID4gc3VwcG9ydGVkIGJ5IHRoZSBkcml2
ZXIgc3VwcG9ydCBzbGVlcCBtb2RlLg0KPiA+DQo+ID4gVGhlIHJlc3Qgb2YgdGhlIHNlcmllcyBp
cyBhIG1pbm9yIGltcHJvdmVtZW50IGFib3V0IHBhc3NpbmcgdGhlDQo+IGhhbmRsaW5nIG9mDQo+
ID4gZW5hYmxpbmcvZGlzYWJsaW5nIElSUXMgKGZvciBkZXZpY2VzIHRoYXQgY2Fubm90IHVubWFz
ayB0aGUgZGF0YQ0KPiByZWFkeQ0KPiA+IHBpbikgaW5zaWRlIHRoZSBsaWJyYXJ5Lg0KPiA+DQo+
ID4gTnVubyBTw6EgKDUpOg0KPiA+ICAgaWlvOiBhZGlzOiBkbyBub3QgZGlzYWJlIElSUXMgaW4g
J2FkaXNfaW5pdCgpJw0KPiA+ICAgaWlvOiBhZGlzOiBoYW5kbGUgZGV2aWNlcyB0aGF0IGNhbm5v
dCB1bm1hc2sgdGhlIGRyZHkgcGluDQo+ID4gICBpaW86IGFkaXMxNjQ3NTogbWFrZSB1c2Ugb2Yg
dGhlIG5ldyB1bm1hc2tlZF9kcmR5IGZsYWcNCj4gPiAgIGlpbzogYWRpczE2NDYwOiBtYWtlIHVz
ZSBvZiB0aGUgbmV3IHVubWFza2VkX2RyZHkgZmxhZw0KPiA+ICAgaWlvOiBhZGlzMTY0ODA6IGZp
eCBkZXZpY2VzIHRoYXQgZG8gbm90IHN1cHBvcnQgc2xlZXAgbW9kZQ0KPiANCj4gSGkgTnVuby4N
Cj4gDQo+IFNlcmllcyBsb29rcyBnb29kIHRvIG1lIGJ1dCBJJ2QgbGlrZSBpdCB0byBzaXQgb24g
bGlzdCBhIGxpdHRsZSBsb25nZXIgYmVmb3JlDQo+IEkgdGFrZSBhbnkgb2YgaXQuDQo+IA0KPiBX
b3VsZCBoYXZlIGJlZW4gJ25pY2UnIHRvIGhhdmUgaGFkIHRoZSB0d28gZml4ZXMgYXQgdGhlIHN0
YXJ0IG9mIHRoZQ0KPiBzZXJpZXMNCj4gYXMgdGhleSBzaG91bGQgcHJvYmFibHkgZ28gdmlhIHN0
YWJsZSB3aGVyZWFzIHRoZSAzIHBhdGNoZXMgbW92aW5nDQo+IHRoaW5ncw0KPiBpbnRvIHRoZSBj
b3JlIGFyZSA1LjE2IG1hdGVyaWFsLg0KDQpJIGFjdHVhbGx5IHdvbmRlcmVkIGFib3V0IHRoaXMg
YnV0IHNpbmNlIHRoZSBhZGlzMTY0ODAgZml4IGhhcyBubw0KZGVwZW5kZW5jaWVzIG9uIHRoZSBs
aWIgc3R1ZmYgSSBlbmRlZCB1cCBkb2luZyB0aGUgbGliIHBhdGNoZXMgZmlyc3QNCmFuZCB0aGVu
IHRoZSBkcml2ZXJzLiBOZXh0IHRpbWUgSSB3aWxsIHNlbmQgZml4ZXMgdG9nZXRoZXIuLi4NCg0K
LSBOdW5vIFPDoQ0KDQo=
