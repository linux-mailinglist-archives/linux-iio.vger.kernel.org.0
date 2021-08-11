Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F563E8F7B
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 13:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhHKLc0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 07:32:26 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19174 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237268AbhHKLcZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 07:32:25 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BBUMaY022272;
        Wed, 11 Aug 2021 07:31:47 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-00128a01.pphosted.com with ESMTP id 3abjesmqae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 07:31:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9xVNcWJMR0qavQu/SO3pCm1+t8w1OTzRv1zPHM0u31hHdt2jm7iB27DdiV8NxRuRM8FZ4Bh0fPKrgZuL74FbkgKrm9jZjuz9c89p0SE/WTGNE3tNRcIKhaxvfPfV1qMF6LnqN++0RXnWgK0x70g8JXBiUbi9qISbDlyjhRsa+dv40kpNC40+ho9VU3/fxe1/21GzCZVV9jgP929OhiUMdW4k2d2W1GDUd1aZY3AKoNCSOFpYJextWHKCnDT1fBCNBxoQI1GSNcwVyRhL1c0XeflCpIUMuf5MfSCYyZLMQL1PdRSBSqg2+htuwpiZ5y8a9KV+sROhnXoYQD6IbC4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlPokHgXe+0mKGB9yZu3MSNm5yaqgz/fue5cAFSGroo=;
 b=KeKsB7CvwlSPE7Eip1PT7Ds8+SpSJB0z52CdICJE04CJ7C57j/Tb4F8vQD1TkbAkIZ4rcr+hl1LR90x+uTQfLn/I+g23mWCF9MN/BF/22+95oE8ULml1QNPOIdagBWqGWdbiKhx/yp2+6n5nd2fe71EG9e4hF3RdHaYBiP/1aG4Wzpmis/40dDVGb9OfHkovHbVr+yosdWKRMU68Npuo1TGwOli2F75LLTOyWIovwtLo0v9+owNKCMO8/ZYkHmtkvxFB5YB+qM0gOo0rs4KCntXu/FtaS+dcTCR2hsmKEmMPLJYSikuV36YYSjSWoZRRMwAOIqKHth05JqSWt29uhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlPokHgXe+0mKGB9yZu3MSNm5yaqgz/fue5cAFSGroo=;
 b=rrgFyFiVREnYCv3TuxBGan3mjR5BmHAgj5lbOEDLloMTIL6ZeQkbDmlQEJEeyF8Ry3QUtSUR+nZ0q/WiF/SyQZt64H7IX9xeNrOMP8o/T87HA2NJoM06lIT3OnJmBY2r0oHJIDYBLPuYFZe0XOjxFhNjijTr1l+Xrbj7hv1TIIU=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6368.namprd03.prod.outlook.com (2603:10b6:510:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 11:31:44 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304%6]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 11:31:44 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        =Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Subject: RE: [PATCH 1/1] iio: ltc2983: fix device probe
Thread-Topic: [PATCH 1/1] iio: ltc2983: fix device probe
Thread-Index: AQHXjfemPNxIy2g6a06Ig/hxF4Z+gatt1HwAgABYLIA=
Date:   Wed, 11 Aug 2021 11:31:44 +0000
Message-ID: <PH0PR03MB6366ACB1FE4E8856547396BF99F89@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210810145653.295397-1-nuno.sa@analog.com>
 <20210810145653.295397-2-nuno.sa@analog.com>
 <CAHp75VfjuoTywEc_HP8OwZn+gDVF+HJti=8itc-_bwSniB5ubA@mail.gmail.com>
In-Reply-To: <CAHp75VfjuoTywEc_HP8OwZn+gDVF+HJti=8itc-_bwSniB5ubA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFlqSm1NekV4TVRjdFptRTVOeTB4TVdWaUxUaGlPRFV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHSXlaak14TVRFNUxXWmhPVGN0TVRGbFlpMDRZ?=
 =?utf-8?B?amcxTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTXpJNE1D?=
 =?utf-8?B?SWdkRDBpTVRNeU56TXhOVFV4TURJME16azVNVFUzSWlCb1BTSmpUbVIyYldo?=
 =?utf-8?B?b1prNDJUbTVKTmpGTVVqTllNU3RhT0VsVVJWazlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRXhkekIwTVhCSk4xaEJXa054UzB4cFZUaFpjRUpyUzI5dmRV?=
 =?utf-8?B?cFVlR2xyUlVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: a3ba46c0-0919-49e2-23ab-08d95cbb992b
x-ms-traffictypediagnostic: PH0PR03MB6368:
x-microsoft-antispam-prvs: <PH0PR03MB63684032997EDE943E68307C99F89@PH0PR03MB6368.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mJUQQcF2JPF+GxxoXHKi/6qjLmVqYX7pQHUzdOgT1lOALo7q+7c4TvY1+Xc7TmtJz/V4VZCEn3yVHLknksuTGgnD5NyzR42tOLsXRiPO10TdqRvPOA5qAFuCfpu/RMicXyyQ91gdAANmpxkJcNHBGPzctCExj/qWWPsXZaice7kzOMUQy1xFyKk6NiT4xrylbplyzxGCop46vdI4qF0JvSk9gkqA4GtWsafVu/l45gcVt5UzL8WaQzbV/CWLauEh6sSLBTNfo8a4oLm0kRPUPELS4AlM+eo1QhDaLQRikUPOBforTdiCoVKceIbIP+eGXi0XBivzP7lwIgeSZAReY2dFlfw1UqGkkvcaxNqQBwc0ifDKZ/bVEWzvbMBJqF9xOyy6cbgm/7aeqRiATo55xvGZUKHvlepBYb6wpFDv9pXl9LXNPkyG0evmEG4UadrCOBc9HFkBAfH3g2vjfWzbo3BC0BJuRmr98H7difh1aWjDi32z8Wy+yBbl1Z8sHMyzi+eI8GzWf9t6A9yZG6G9Zqvxrzvq/MmYXsxdi6AORNlqxNCDponItKWPuHyvbRT0jr1NmcWy6iPUvB7CJCWAcNccEdnhLNj3W/2geaiAwPbunMWJbqRbl5KEaG0Jw752EAApzdLoUHuDkhTssUsnSQLDt8z37GBcDWTxp5Wi0IPjyeTzkff5oOypnsStmR98VbrPSLREKaui3bEbl5zk8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(186003)(55016002)(4326008)(2906002)(54906003)(26005)(8936002)(5660300002)(6916009)(316002)(38070700005)(33656002)(86362001)(38100700002)(76116006)(122000001)(7696005)(71200400001)(66946007)(66556008)(64756008)(66476007)(66446008)(52536014)(9686003)(83380400001)(478600001)(53546011)(8676002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG9yNG5JOVoxRlJkbEhyN0M1RmlmT0ZCajRsQXptUlNaWlBSNWYyMnUxTjd1?=
 =?utf-8?B?dXBhNjM4TWN1UEhEUjQ1ck5KbFh6SE00eWRWTnRlaE9LamZ3OXFLaTBubFBO?=
 =?utf-8?B?ODBybXdhYU5rS0FObkY4b1Evdlc2alY1Q0J4aHRuZFB6UGEvMUxGN29QNjdP?=
 =?utf-8?B?c29lRmdCLzljUGhuTmphYWJqOXlJZlIwN1Jzd1l3ajEvbjUwK2tuR3M3bEY2?=
 =?utf-8?B?YXduQkJsMFJvOUp6aEFKUjRxSVBtOTMwTXpnbGNNaTJmNTNVTUMrM2o5V3Ft?=
 =?utf-8?B?Rll5dUtSOGlVZEJqWVB2c21ieXp4QzhDOTRNVGQ3OFZXdlJZV3l2ekxrdkVG?=
 =?utf-8?B?MFQ3b2NPKzVqa1g3a1NPbHhTZkoxNW9iVllVaG43RWlkV0ErK2NFcXQ4SFB3?=
 =?utf-8?B?bEJTcXpYOW9FRCtPVlM5NVhGZ1BONnZDUUplZGpwRzk3STkrSnRTR080M01T?=
 =?utf-8?B?VnFBVGYyMmhQYUhDVVhGbHB1ZlBBVmhPWERXMFRWcFY4cS9ld2NPMGZJOEs4?=
 =?utf-8?B?UTRPdHFXUXl5NVVYQlRiaGZtZmpxbmtBMlhXN2JIODNjNkdQRGlaU0tNa2tY?=
 =?utf-8?B?azIvWlBSNmRSZTlJSnJqN3I4VVFJR0xtcmtFVi9nNTVCc3c2ZXE1Y05WUWNI?=
 =?utf-8?B?R0t1eXc5b2x0K2ZHR3VIUklKZXNzcjJVWlZ3S2hhUnU3Ny9CNGFGd01BYnow?=
 =?utf-8?B?MTFSR1NkcHJYZnFwNk9WQWhlbEtURXE1bUxsd2E3NEhKNEJBQUhLcGZwb3hl?=
 =?utf-8?B?TExXMW0rUVlCQTZXeTFyakQyakViQkdhTXFsVXVtay9weFpWbkJPRjY4MXN0?=
 =?utf-8?B?ejVsQ3BoRmU2SVM3OFpXa2tMbmw3aS9OR1Ewc3k3VHhWUWJyTVNqQy85ZkNw?=
 =?utf-8?B?MlRIS1dUS3RoOFpOSzBvTXY3NTFXZndtcDU4c2tCZGc4a3JtT2pIL1FpNE9v?=
 =?utf-8?B?V242WkJhOXNBZmhycFlIaEpvVCtRZGFPNWJUZFlkL1dva3pEQVYydGE2dGZN?=
 =?utf-8?B?akJ5QlBrVFFRcFEwOE15ZnJGbE15M0JBY1AydWZoa2htZWhQMWI1czhCc0xZ?=
 =?utf-8?B?c1dQM2d2TDdDVEhQMGpKT2doZU1WSHRIeDhvZlkwY3BsWWU5cENuczQ1V2RR?=
 =?utf-8?B?OHZrdm9IcWoxQmp6dGxMaFI5QU9nb0dKZDVvcDZ2K0pTakpRdHN3ZVlHR0NG?=
 =?utf-8?B?NGs0bmhEMVdUNS9pSHN4VzFuUDlkUmVVbStKeWhRSmZjL1lxK2NjbFJjRFJn?=
 =?utf-8?B?N0Z1cTkxVUhnaDUrdTcxaWFBSDhnM0M3Q05kMXd3QitOT09GNWhKeE1TejZi?=
 =?utf-8?B?N2VCSHh4QjJBUUIycnRxWUoxY1BwWmlBRlVkL0FjM1FBdWVxRlFvdmdiQ2JH?=
 =?utf-8?B?R0d1aVBhaXFhQ2pHaFZhcUxrTitLSjB3V0hMY04wdCtHdGFzYkF3NnFPNEVa?=
 =?utf-8?B?Vy9rY3R0SFBlQjNELzBMSnpGRUtYZDAxZE9pc1dhemhSdktwTUJZczhIRUwz?=
 =?utf-8?B?Ty9QR1NrK0VpemVRUGVGcFJEQngwOWZYOE9CUHNyckxNMGlWZ1V4aXZ0cmF4?=
 =?utf-8?B?TXRLdWZWL0pFa0c3Rml5NlVHQ0h3WlJ1RDY2UXVPaEp6d2ZLeVNmUU45bFNT?=
 =?utf-8?B?Sll1UDBhY0FmSEtZUTdSQ3FuZmh2NjZlajdJNHNlcU9mRGlyUm84Q1dsSEVx?=
 =?utf-8?B?WUhsZUNNR2ZRWmZ3ZmJhc2FoR0NuWUtwTkE3Wi9HNEZLYW1aTGRlVzl5WTBM?=
 =?utf-8?Q?79CdjLbGuh3nqHmCfZZu1oYa/hpE1CKtP2QIbNY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ba46c0-0919-49e2-23ab-08d95cbb992b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 11:31:44.6085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wTdZCjh0ef5sQlXmyUYJQUwve9AkGJ7gxcjksFUFMD7xVeJyAjU+kAQYlypRfvhGtkiRcg++wX954WRb18rs3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6368
X-Proofpoint-ORIG-GUID: Caim_0HQv_x_7Vk4M8AGHEGWf-6fI-W7
X-Proofpoint-GUID: Caim_0HQv_x_7Vk4M8AGHEGWf-6fI-W7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_04:2021-08-11,2021-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108110076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAx
MSwgMjAyMSA4OjE1IEFNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiBD
YzogbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgPUpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtl
cm5lbC5vcmc+Ow0KPiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IERyZXcg
RnVzdGluaQ0KPiA8ZHJld0BwZHA3LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIGlp
bzogbHRjMjk4MzogZml4IGRldmljZSBwcm9iZQ0KPiAgDQo+IA0KPiANCj4gT24gVHVlc2RheSwg
QXVndXN0IDEwLCAyMDIxLCBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tDQo+IDxtYWlsdG86
bnVuby5zYUBhbmFsb2cuY29tPiA+IHdyb3RlOg0KPiANCj4gDQo+IAlUaGVyZSBpcyBubyByZWFz
b24gdG8gYXNzdW1lIHRoYXQgdGhlIGlycSByaXNpbmcgZWRnZSAoaW5kaWNhdGluZw0KPiB0aGF0
DQo+IAl0aGUgZGV2aWNlIHN0YXJ0IHVwIHBoYXNlIGlzIGRvbmUpIHdpbGwgaGFwcGVuIGFmdGVy
IHdlIHJlcXVlc3QNCj4gdGhlIGlycS4NCj4gCUlmIHRoZSBkZXZpY2UgaXMgYWxyZWFkeSB1cCBi
eSB0aGUgdGltZSB3ZSByZXF1ZXN0IGl0LCB0aGUgY2FsbCB0bw0KPiAJJ3dhaXRfZm9yX2NvbXBs
ZXRpb25fdGltZW91dCgpJyB3aWxsIHRpbWVvdXQgYW5kIHdlIHdpbGwgZmFpbA0KPiB0aGUgZGV2
aWNlDQo+IAlwcm9iZSBldmVuIHRob3VnaCB0aGVyZSdzIG5vdGhpbmcgd3JvbmcuDQo+IA0KPiAJ
VGhpcyBwYXRjaCBmaXhlcyBpdCBieSBqdXN0IHBvbGxpbmcgdGhlIHN0YXR1cyByZWdpc3RlciB1
bnRpbCB3ZSBnZXQNCj4gdGhlDQo+IAlpbmRpY2F0aW9uIHRoYXQgdGhlIGRldmljZSBpcyB1cCBh
bmQgcnVubmluZy4gQXMgYSBzaWRlIGVmZmVjdCBvZg0KPiB0aGlzDQo+IAlmaXgsIHJlcXVlc3Rp
bmcgdGhlIGlycSBpcyBhbHNvIG1vdmVkIHRvIGFmdGVyIHRoZSBzZXR1cCBmdW5jdGlvbi4NCj4g
DQo+IAlGaXhlczogZjExMGYzMTg4ZTU2MyAoImlpbzogdGVtcGVyYXR1cmU6IEFkZCBzdXBwb3J0
IGZvcg0KPiBMVEMyOTgzIikNCj4gCVJlcG9ydGVkLWJ5OiBEcmV3IEZ1c3RpbmkgPGRyZXdAcGRw
Ny5jb20NCj4gPG1haWx0bzpkcmV3QHBkcDcuY29tPiA+DQo+IAlTaWduZWQtb2ZmLWJ5OiBOdW5v
IFPDoSA8bnVuby5zYUBhbmFsb2cuY29tDQo+IDxtYWlsdG86bnVuby5zYUBhbmFsb2cuY29tPiA+
DQo+IAktLS0NCj4gCSBkcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9sdGMyOTgzLmMgfCAzMQ0KPiAr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+IAkgMSBmaWxlIGNoYW5nZWQsIDE5IGlu
c2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gCWRpZmYgLS1naXQgYS9kcml2ZXJz
L2lpby90ZW1wZXJhdHVyZS9sdGMyOTgzLmMNCj4gYi9kcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9s
dGMyOTgzLmMNCj4gCWluZGV4IDNiNWJhMjZkN2Q4Ni4uYzZjNDg3N2JkY2ZmIDEwMDY0NA0KPiAJ
LS0tIGEvZHJpdmVycy9paW8vdGVtcGVyYXR1cmUvbHRjMjk4My5jDQo+IAkrKysgYi9kcml2ZXJz
L2lpby90ZW1wZXJhdHVyZS9sdGMyOTgzLmMNCj4gCUBAIC04OSw2ICs4OSw4IEBADQo+IA0KPiAJ
ICNkZWZpbmUgICAgICAgIExUQzI5ODNfU1RBVFVTX1NUQVJUX01BU0sgICAgICAgQklUKDcpDQo+
IAkgI2RlZmluZSAgICAgICAgTFRDMjk4M19TVEFUVVNfU1RBUlQoeCkNCj4gRklFTERfUFJFUChM
VEMyOTgzX1NUQVRVU19TVEFSVF9NQVNLLCB4KQ0KPiAJKyNkZWZpbmUgICAgICAgIExUQzI5ODNf
U1RBVFVTX1VQX01BU0sgIEdFTk1BU0soNywgNikNCj4gCSsjZGVmaW5lICAgICAgICBMVEMyOTgz
X1NUQVRVU19VUChyZWcpDQo+IEZJRUxEX0dFVChMVEMyOTgzX1NUQVRVU19VUF9NQVNLLCByZWcp
DQo+IA0KPiAJICNkZWZpbmUgICAgICAgIExUQzI5ODNfU1RBVFVTX0NIQU5fU0VMX01BU0sNCj4g
R0VOTUFTSyg0LCAwKQ0KPiAJICNkZWZpbmUgICAgICAgIExUQzI5ODNfU1RBVFVTX0NIQU5fU0VM
KHgpIFwNCj4gCUBAIC0xMzYyLDEzICsxMzY0LDIxIEBAIHN0YXRpYyBpbnQgbHRjMjk4M19wYXJz
ZV9kdChzdHJ1Y3QNCj4gbHRjMjk4M19kYXRhICpzdCkNCj4gDQo+IAkgc3RhdGljIGludCBsdGMy
OTgzX3NldHVwKHN0cnVjdCBsdGMyOTgzX2RhdGEgKnN0LCBib29sIGFzc2lnbl9paW8pDQo+IAkg
ew0KPiAJLSAgICAgICB1MzIgaWlvX2NoYW5fdCA9IDAsIGlpb19jaGFuX3YgPSAwLCBjaGFuLCBp
aW9faWR4ID0gMDsNCj4gCSsgICAgICAgdTMyIGlpb19jaGFuX3QgPSAwLCBpaW9fY2hhbl92ID0g
MCwgY2hhbiwgaWlvX2lkeCA9IDAsIHN0YXR1cw0KPiA9IDA7DQo+IAkgICAgICAgIGludCByZXQ7
DQo+IAktICAgICAgIHVuc2lnbmVkIGxvbmcgdGltZTsNCj4gCSsgICAgICAgdW5zaWduZWQgbG9u
ZyB0aW1lID0gMTA7DQo+IA0KPiAJICAgICAgICAvKiBtYWtlIHN1cmUgdGhlIGRldmljZSBpcyB1
cCAqLw0KPiAJLSAgICAgICB0aW1lID0gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZzdC0+
Y29tcGxldGlvbiwNCj4gCS0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbXNlY3NfdG9famlmZmllcygyNTApKTsNCj4gCSsgICAgICAgZG8gew0KPiAJKyAgICAgICAg
ICAgICAgIHJldCA9IHJlZ21hcF9yZWFkKHN0LT5yZWdtYXAsDQo+IExUQzI5ODNfU1RBVFVTX1JF
RywgJnN0YXR1cyk7DQo+IAkrICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gCSsgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IAkrICAgICAgICAgICAgICAgLyogc3RhcnQgYml0
ICg3KSBpcyAwIGFuZCBkb25lIGJpdCAoNikgaXMgMSAqLw0KPiAJKyAgICAgICAgICAgICAgIGlm
IChMVEMyOTgzX1NUQVRVU19VUChzdGF0dXMpID09IDEpDQo+IAkrICAgICAgICAgICAgICAgICAg
ICAgICBicmVhazsNCj4gCSsNCj4gCSsgICAgICAgICAgICAgICBtc2xlZXAoMjUpOw0KPiAJKyAg
ICAgICB9IHdoaWxlICgtLXRpbWUpOw0KPiANCj4gDQo+IA0KPiBOSUggcmVnbWFwX3JlYWRfcG9s
bF90aW1lb3V0KCkNCg0KTmljZSBoZWxwZXIuIFdpbGwgc2VuZCBhIHYyIHdpdGggaXQuLi4NCg0K
LSBOdW5vIFPDoSANCg0K
