Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC643F2793
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhHTHWH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:22:07 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:57824 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233162AbhHTHWH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:22:07 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JK0OuZ022234;
        Fri, 20 Aug 2021 03:20:54 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ahka2nq6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:20:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCKrbGftMpYWBQNwj7YxALCCllogCWVLJJ/MMkApIbcmUFvpumrNuD1fnVDvKuMw/dW/NjHEJzn29YEnnCGg3ZwQ73l9e7UiBK1JVz5LQSBRY8dSpqH1j1mbkSr4u7Gi59tRRI9oOumgSj5fgsXZ76R/dHM2XPiBgj1IvgErsshBgau3EfuJho++pavTkSc/SW+HoF3pzLTywg1Urs6Ho8KwFVlqGYMXbQkXc14pxkHbGu/SAZiKGIb7E1MmhP1lYuLiASSjQdmmYvkyN9nOkCwrn8cRQhav/fJVtRC4Im48h+lS7s2B8JSdkbZaVy3HjGbYQNGqbJ0t2UxB7tobxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p2NyD5EwTVcGTAgPjDqmTykXR5fF8XXqHi6M/MMPE0=;
 b=YbgEn0Tc+rLsAkUZDiDUYn8wznPbPIOuXXg7+yAfpNWftFIsoNu+6UVVs3tJT5S4bpvJfaObvjr1FEJ2mYKCNvbxhWJ11uCDhvgpZRAOaGajuuw+Wz5udRUOm0dOB904D8RdhuSzacfSpwK/N6FUYKbMIbQchfBuH6wuSlDF6GRqncFPJqRaI+vxJQeoaRSoujO8BleijjLVlbyMCtYX3k/cy8zDiBrVN4WshLJEPk6cEQVEHogt4qJ/SqmoE5uj7xXvShkG6V84wmeMIhsJQXhwo5F4nzGAh+HniL2bFsKRKROvb081pF+Khtsq7TQxcIrAphpjQvBgQDPYhG3T3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p2NyD5EwTVcGTAgPjDqmTykXR5fF8XXqHi6M/MMPE0=;
 b=u8YTktSQ+64h5FWoTcFYuCV7beneNkaxwyy2ilK1r9VD/eAPeDQRc2h4xj4Hv3lCYiL2f3KUS0JCFthK4RgvTqmjhSdq3tvaCR2ogIGB8rkK2QLE5S7mi9/RPdhFDztXvkc3dfJKZaOQUGyoRqRjSvzDuKV/myNeGvLITA8bLz0=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by SJ0PR03MB5392.namprd03.prod.outlook.com (2603:10b6:a03:282::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 07:20:53 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:20:53 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 10/16] iio: adc: max1027: Prevent single channel accesses
 during buffer reads
Thread-Topic: [PATCH 10/16] iio: adc: max1027: Prevent single channel accesses
 during buffer reads
Thread-Index: AQHXlCHwwUDElOtgskK3oBAOzRZBB6t7/uqg
Date:   Fri, 20 Aug 2021 07:20:53 +0000
Message-ID: <SJ0PR03MB635942A6E93291B5134350B799C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-11-miquel.raynal@bootlin.com>
In-Reply-To: <20210818111139.330636-11-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1qVTFaVGsxTjJFdE1ERTROeTB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhESTFOV1U1TlRkakxUQXhPRGN0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRZMk5T?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGMyTlRFeE1URXpNVEV3SWlCb1BTSmhSVUZ6Ukdw?=
 =?utf-8?B?eWQxYzFRMVE1U21SVFpFcGtLMUJQVjJOaVpGazlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTlhRamR1Ym1zMVdGaEJabWhWTWxWSlNFRXZPRWNyUmxSYVVX?=
 =?utf-8?B?ZGpSQzkzV1VaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 654d34b3-7950-4f5f-c24c-08d963ab0b8b
x-ms-traffictypediagnostic: SJ0PR03MB5392:
x-microsoft-antispam-prvs: <SJ0PR03MB5392149FC909AB2C696FB71E99C19@SJ0PR03MB5392.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wkEqf/GUz827fnMpOJnkVu8SPyqeCCdSN8CEdpniMJRi12xaAIuSz3jB56hN+PXTUoV8NegtnVoYol7lsKvrjdYNJalOpcEcONV3hI1p50MUY+qGMT3+V4cHx6HKftk5qPsq2Kd5U6tm8CUIHqzVF6hGpVoYbV8L1+lE9RDYTt6CP9bCZTs+dy1la6jryy7ZOu9XtNgf6fjFqqj4c6oCsOc1GKVb+caCvhlNmQtRiPkhIbYcB7XYUujBqcRWCPIZkgo7aWgyVCdyT0tbORUqfCsbqDlakTS7SNpMWW2+Dh41gwXF23EcXlPmgHhWm6GDHlicwpsfcDx+UE5lgKw6N8wPgKgLFXx4RX3e/0aDr1z5Y7xCU607f0T94qJZmFOYBF2nOn5IgiCJnZ3MB1SOGQSw3+QROExFRy1IxVxARNYqzACkoKq87z+ELeyNf1m65/DCTN01b938iMVypqHttWJ+LU7u6aW+xoALsDwbyC+QbV2Bg8dPwKwQ9OLY95+QKSYAjEQYN4xC4WEGZbRsAJ8W3AFTXPI7UNcBR++FsdAIsrumKIyOWXyxsmv/dipp91xhGGwLWBTADPL5tEGpNZaao4b1NVG/ub1+THPMFEVwhmuisBsbHrt9LaIWqfzxlXyo2VwmVvmBF4k/VWrLyVNV2kwEOwvuZILdXXIeznJmjoCvbWSw2rT54SRpuVwa1u2nPeDjcOpVWItE5+biwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(8936002)(316002)(6506007)(26005)(53546011)(71200400001)(55016002)(52536014)(9686003)(64756008)(7696005)(33656002)(5660300002)(76116006)(66446008)(66476007)(83380400001)(86362001)(122000001)(54906003)(8676002)(4326008)(66556008)(38100700002)(478600001)(110136005)(66946007)(2906002)(38070700005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zk1kSmo0SUpUcG5GOTFrR3JDQzRETHVDaHBiNUJhNjJVaG1FNTVNVmMrVEVx?=
 =?utf-8?B?dHFRUy93MW5GOGVnaXhmRlA4dnowaUQvN0t3Tm92UzZLaldSSmZrVXJQMXlt?=
 =?utf-8?B?RU52cWlOM0dOdHpPdWkzc0ZEYVZ0RmtRdlZvSDNuT3VMdkJUZVZvZDg4RkVq?=
 =?utf-8?B?bTNyaS85NTB5Mmh5blRjZVdqc21OcUVRNFdESFI0K2RwdWg0cVlBYkhZZHBI?=
 =?utf-8?B?TThsUHR2WEg1Z3pQZThqNFh6L0orVjQ5VDZ0U2ZybXBUdTNDNGhNVXE1VkZo?=
 =?utf-8?B?WVhTYkNjNXNmTjUzRlpCa2FvQXZxeHJxQXlodndXY0U4eDIvazdycnZMMjZn?=
 =?utf-8?B?Tm84U1Mzc0tLV0RiMVFuYWRMYjcyekpvekI0Z1YwaENiRHVyM0FnM3lCYjNL?=
 =?utf-8?B?VWdFK2p1cnUvWHkvSElwMktNL3FESEx2eWFEd3VYdXlsK0huaHY4S0FVQlJT?=
 =?utf-8?B?LzZlcTBscVo5Zk94Tllpc2pjalFKSCtxcFRXbEtiMGdERHhyV3plOElhNmFp?=
 =?utf-8?B?MjFTR045YjkvTWMyYWUySUZ5QmpxQXlVbGpub2hzVEliSlBNSEVOZ01vYlBv?=
 =?utf-8?B?VXdtKzZpRTk2ZW5PM25LVUFFK29RKzZEWkVxV2wxaE90L3dvbjF5em9YVy84?=
 =?utf-8?B?bUdIUHdhdlpFUHkySEs1LzdKbWg4U1FyaVRzajVmRGF1ZDFUTmhIVkpYNS9M?=
 =?utf-8?B?QklpMDNYOTd2Q0VUUlNmbXhBamVpQW1VR3E4L0dsK21VelNFS28zdk52WUVY?=
 =?utf-8?B?dTNnam0xZmtBYk5ESGltbXUzc3F0VDI1S1daTnp6SjlRTzNnRmxQZHE2eXdV?=
 =?utf-8?B?ZzJUcU9OK3krUHUvK09IYnUrNTJWUzVTUGt0UEZCOUpjMXlTM3lSVW5QNnpE?=
 =?utf-8?B?c1lOWlk5L1FUc2xrVFVPTjYwQ25vVEJZbzhFL0lNMGVVRFhTUUhoS1ZXd2dQ?=
 =?utf-8?B?VFBJY0FuMXBqYS8yNkh2WXJDTVFqZGg5MUdhYUV1SlNyd2l1UEgxZEJ6OWtl?=
 =?utf-8?B?eS8wY1FEL2FUc29ZQUlWYlVOR3Z1RGhrUGRNSTNMaHFqamtxUVd4L2Q5MXk3?=
 =?utf-8?B?c2luR0xxQUw5UkFEWTlzbG5qQyt5NHZHaGVNN3JNNjRweG1POW9SMjY0M1Bs?=
 =?utf-8?B?SnpERC9FODQxU3VRdENtbE8zN0dwTzVtaFNrOHY2dEs4R3lpb0tVcE92enpW?=
 =?utf-8?B?NnB0ditXWENUdGZ5ZzVoK1RLbWFTRFh6T3BzUlJzQjYySlowd3JNMXBuejlB?=
 =?utf-8?B?UmloekU0V1k5VGl0L1hnK2lnSWFrcFZ4Mkt1cExlOExXUkdYRUs2dFI1TVYx?=
 =?utf-8?B?bFFsSE0vaGZpa0JseEU4T2hkTnEyckZZOUJiUVNSZzJrYW4rMU1OUyt4TnZ1?=
 =?utf-8?B?OWFHMldqQlBrTFFMbVE1TnJtdDI0dlp1VnNjTzJSQjVQZDAzaENHbklLYlp1?=
 =?utf-8?B?cGcvQVcxbTZ0MjVoMTYzU0NRYnhRb3U0YXE5akFjd1lyNzBlOVJBUVFUV0lB?=
 =?utf-8?B?YWl5eTV5MXh6SWJlWnFsM0hQWUt0Nkg5alU3dHhZTHVaMVNmYS9sZzhoaUht?=
 =?utf-8?B?UGxPT2RHNVd6V1FBTW9BMFB5UTZ1eFlCVUtuVDdVdU0xMkNFTTZVZ0VXMHlD?=
 =?utf-8?B?bVltVVIzWnZzdVlldGp5REJ3N1AvWENtaXJlNkpkN0RIek1jNFNYejY4aDBR?=
 =?utf-8?B?SzhJQ2hLODArYXRrak5sb1gzdWtVeVVSTFczdU55N2xqNlh5Wi9SM25TZW0r?=
 =?utf-8?Q?auwYCO/JgurYsbxkPEejV8gYrntjqDcIyQtEo1B?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654d34b3-7950-4f5f-c24c-08d963ab0b8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:20:53.2946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fSdT/p/BmjfbEjCgqDMhOm9xuZcM++EdWtoXDpODntudTnnMFldctaD10tqblrmTrziV3DRnMP33CgjURnUlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5392
X-Proofpoint-ORIG-GUID: TaeL1aQ7QmAuSSUyNkiKKxYeto4NDpv7
X-Proofpoint-GUID: TaeL1aQ7QmAuSSUyNkiKKxYeto4NDpv7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_02,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200042
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTgs
IDIwMjEgMToxMiBQTQ0KPiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47
IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBDYzogVGhvbWFzIFBl
dGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT47IGxpbnV4LQ0KPiBpaW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNaXF1ZWwgUmF5bmFs
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMTAvMTZd
IGlpbzogYWRjOiBtYXgxMDI3OiBQcmV2ZW50IHNpbmdsZSBjaGFubmVsDQo+IGFjY2Vzc2VzIGR1
cmluZyBidWZmZXIgcmVhZHMNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IFdoZW4gaGFyZHdhcmUg
YnVmZmVycyBhcmUgZW5hYmxlZCAodGhlIGNudnN0IHBpbiBiZWluZyB0aGUgdHJpZ2dlciksDQo+
IG9uZQ0KPiBzaG91bGQgbm90IG1lc3Mgd2l0aCB0aGUgZGV2aWNlIHN0YXRlIGJ5IHJlcXVlc3Rp
bmcgYSBzaW5nbGUgY2hhbm5lbA0KPiByZWFkLiBQcmV2ZW50IGl0IHdpdGggYSBpaW9fYnVmZmVy
X2VuYWJsZWQoKSBjaGVjay4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1p
cXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL21heDEw
MjcuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jIGIvZHJpdmVycy9paW8vYWRjL21h
eDEwMjcuYw0KPiBpbmRleCAyMjNjOWU0YWJkODYuLjgzNTI2ZjNkN2QzYSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9paW8vYWRjL21heDEwMjcuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvbWF4
MTAyNy5jDQo+IEBAIC0zMzUsNiArMzM1LDggQEAgc3RhdGljIGludCBtYXgxMDI3X3JlYWRfcmF3
KHN0cnVjdCBpaW9fZGV2DQo+ICppbmRpb19kZXYsDQo+IA0KPiAgCXN3aXRjaCAobWFzaykgew0K
PiAgCWNhc2UgSUlPX0NIQU5fSU5GT19SQVc6DQo+ICsJCWlmIChpaW9fYnVmZmVyX2VuYWJsZWQo
aW5kaW9fZGV2KSkNCj4gKwkJCXJldHVybiAtRUJVU1k7DQoNCkkgZ3Vlc3MgJ2lpb19kZXZpY2Vf
Y2xhaW1fZGlyZWN0X21vZGUoKScgd291bGQgYmUgYSBiZXR0ZXIgb3B0aW9uDQpoZXJlPyBUaGVy
ZSdzIG5vdGhpbmcgcHJldmVudGluZyB0aGlzIGNoZWNrIHRvIHBhc3MgYW5kIHRoZW4sIGNvbmN1
cnJlbnRseQ0Kc29tZW9uZSBlbmFibGVzIHRoZSBidWZmZXIuLi4NCg0KLSBOdW5vIFPDoQ0KPiAg
CQlyZXQgPSBtYXgxMDI3X3JlYWRfc2luZ2xlX3ZhbHVlKGluZGlvX2RldiwgY2hhbiwNCj4gdmFs
KTsNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBJSU9fQ0hBTl9JTkZPX1NDQUxFOg0KPiAtLQ0KPiAy
LjI3LjANCg0K
