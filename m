Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B016044D792
	for <lists+linux-iio@lfdr.de>; Thu, 11 Nov 2021 14:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbhKKNxb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Nov 2021 08:53:31 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:32552 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233287AbhKKNx3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Nov 2021 08:53:29 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1ABBjaSh015127;
        Thu, 11 Nov 2021 08:50:26 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3c89006sfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 08:50:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXlfV5+yCXZVvyEc1e2I9c2muiEdWXDOPw7CsSF3smhoxWXpxzQ6Dtci8FI76HaXhjD2USd9buMUOcMnj3yJI4UiGXatyk15Bl49z4E/aYz8JHs55pgak+oIUq5VLXtHqHEdCHQ4F6zHU/x/jqMa3TefzKauTJ7P8aqm7xAlzpmlDh6oQSlt3c+DDU4NulySMRGpb0eVPpVBKH4DTz2Q4khTgOKNe5F7eiCebqRpKqwrb91GacJgV/4zxdhMq3EmdM+Ty2P/GF9R77BeuxeOvoq6ak7zAz9/BOaMUEteC4VgUAgc+ousQ+f9tnN6I8NUlXdW3qcZPg0J73/eMW3c1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ar3tjQ0Y8uH39q32Ht2K9QgMtqxA41iYRDyt8CxQz+c=;
 b=N6vwMYPF07qKhcxSea447R3enhlef97rfJuREipY80kI0z+3mHpfY3xHVfgVCgIKrC6nmI+mm/pHllF+lQjCGb6EfUNimsBMjQCED+cdneb9p4+QpijhCnGKdpkBu4TFLvxsiPuUkwBp2UepR0HJe/RhETgBewe7PVWrAbbuwQ7T8TPz6xS3BEzOjQz4pM8D87mOfmLv+o3NsixUHjmWW35B+7w+7Ki9Y9bRNUEY6o+JvHp9hB7Ub49Wmt8BbS7Ei6t0pe+nGz+P9495A4EjmLWZCFduC5bEaRlnddE+tL9kcvjLXpRMAftA6oqnsWBYGFk6z2XzfGhb/xz4lg4cnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar3tjQ0Y8uH39q32Ht2K9QgMtqxA41iYRDyt8CxQz+c=;
 b=PzTDf4U4XN/bhkTgIixZ4/v3jeEkKnJmDl5EWikN1sfeMekqHe32tsVovTUimI2eKRiNF1SmrftOEXD/dzK1wX/1HCzeQCvn1YDfVCZx2oGDsh2XnHG0PP4RPSd9bdZcJFxs35adcJjyt/bJ/sn1vsGAcQEQSCC82FwYX+2V9S4=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5717.namprd03.prod.outlook.com (2603:10b6:510:41::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 11 Nov
 2021 13:50:24 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73%8]) with mapi id 15.20.4628.022; Thu, 11 Nov 2021
 13:50:24 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        "Jimenez, Kister" <Kister.Jimenez@analog.com>
Subject: RE: [PATCH] iio: adxrs290: fix data signedness
Thread-Topic: [PATCH] iio: adxrs290: fix data signedness
Thread-Index: AQHX1vZjfUH8MzJrZk6MsNalI9zHn6v+RywAgAAQlhA=
Date:   Thu, 11 Nov 2021 13:50:23 +0000
Message-ID: <PH0PR03MB63661AD66C33F00FE4C4112299949@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211111121915.173616-1-nuno.sa@analog.com>
 <CAHp75VdDBXehV0NTt15AOHdE5qqYn2k96+JkY1+nM+rReGWHUQ@mail.gmail.com>
In-Reply-To: <CAHp75VdDBXehV0NTt15AOHdE5qqYn2k96+JkY1+nM+rReGWHUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5HWTJOVGxpWmpFdE5ESm1OaTB4TVdWakxUaGlPV0l0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEUm1OalU1WW1ZekxUUXlaall0TVRGbFl5MDRZ?=
 =?utf-8?B?amxpTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRJd01p?=
 =?utf-8?B?SWdkRDBpTVRNeU9ERXhNVEl5TWpFek56SXdNVE00SWlCb1BTSTVjWGhHU1hk?=
 =?utf-8?B?bmNGVmlhWFl6VlVwVU4ySkJVVnB5VjBOVmVGazlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVSkxSVTFWVWtFNVpsaEJWRk5vUTJKeWIzbDRZVzlPUzBWS2RY?=
 =?utf-8?B?VnFURVp4WjBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3a7d7a7-0694-453a-f5ae-08d9a51a35e2
x-ms-traffictypediagnostic: PH0PR03MB5717:
x-microsoft-antispam-prvs: <PH0PR03MB57170792F238DD9425F6CE6D99949@PH0PR03MB5717.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kyf7s6+joiIAXbY1/BJVhh1TyWXP28erSzbcHK9cFs9pxS2XjebfIfwSfZPnv7ev6jRrJx2aPk3ow4AHjxnjKmoNC622K6yxZWFNNyyiHm+aKY3z2kP09jBHECUXSnUE9tZok5KJHIzjkGKp7vauL9zx1cmpuQ8acbf2HcGGFpL2ZLLrmVce0jyi7XS1e1H5wMRTvO+5v58b6B70jJ+ecD81yBfHXwYQynn3+f+CWQysegAnhdK9QgdXKEuogYRdue2QqPXOLqRarEIgXJgtFrW5AFJiBvVqgy50MSe7mzdYjM6l5DqRAldD+iVncmfmE02gD0M7fhDqa3lmL/rZnNvkN3cxJsKo5fVjcHG1NU6D1MU6v9LihqJxsD2B2sLMGV2LQj8/AZfM9lxJBDS424JpMqlgU/daX15brmZoo5gZxWX65pCATRHs/mebPYPcKfOVXPJT1uTiUeu7bkLbv0zmZFMGbCbjh86yf3UmjTkJAHYDdKywzf3A4/X43fcA/daM5iUaWVrjvakgykchQWZIJHG6g0Op+7ltPxJ010T0Qe85oqpXgl3Oa5sfvxZgCO2iGfCZRdy5AIqnTULzQMCIhj/DEc5PfYOP7+YYBb8/rwomn5a/b759CRHs52qMGHcCv4N2XVmaRmxRgxbmkkALS4slpu0D1rSgaf+ULf+l7rAeYHsRQbeI/djSuH3sBxwQYVt/9O7FQhYcDexYsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(38070700005)(5660300002)(7696005)(8936002)(53546011)(66556008)(66476007)(64756008)(83380400001)(66446008)(508600001)(6916009)(2906002)(122000001)(33656002)(186003)(8676002)(316002)(52536014)(107886003)(4326008)(4744005)(38100700002)(76116006)(66946007)(54906003)(9686003)(55016002)(86362001)(71200400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWJJd1hGWlQzZ29Ddk56cUJCN0NRYlRWNEZlMnNsME9HVDhnVDluTmxoT3No?=
 =?utf-8?B?M0psMkFPVTBTNFN6Wi9hSmFrR29aS0tpakw1SjQ5ZkRFNzdkUm8vT01EUDNV?=
 =?utf-8?B?Z1RoVWpxRmZpdFRHLzV3M0NESkFreXlkWnJMVTRwRVZiZ3Y1YWdMaFZEWExi?=
 =?utf-8?B?ZHdzT2VXbUx3Z25KN0xoL0pUT0xyVXQ4OVdxV1RFNGM3U1N2T0YzZDYzYVlP?=
 =?utf-8?B?RkpXQThPc2hiaEtnU0lpS1ArdlhLZFNqUUFxNFRXVFZzWS8xVDhRUWlDOTlU?=
 =?utf-8?B?dVcva2E5azhhT2dTZGEva1YxT3JPczgyNW14Nk1XZ3FlYlhmUmhlSm83cVhD?=
 =?utf-8?B?RkJvaVAzYWxaWXZzaDJLUjJOZUV0MlNra0diNXhzY29TN2JZZllSRDFrNzFU?=
 =?utf-8?B?Ky8yTzRZRzVYL2dIOGtlVXU3REtmUHRQSnFBUW1acExFc1owakR2UW90Rm9Z?=
 =?utf-8?B?Qm1HWUtCZ1hIYUxndFlwN1NOUXhXM1BSeFZCOWJaL01rVVRGZVBjVkRHUjlo?=
 =?utf-8?B?Ulc4bzA5eHEwUUhmU3VxOHNXeFhhZ3d1TFJFZkNGY2MveHVBQlcwdHkxUTZp?=
 =?utf-8?B?UU5oQ2NzcklMQmxZbTdqL3BIaUxhN052SDk3SlZoTG5UMCtRWi8yRll0RHNh?=
 =?utf-8?B?b1NiZ0F5cTJhT3FFUThZRXVabnYvQkdHOGxtY2JNa2ZnbmVoTE9FMVAvY0xN?=
 =?utf-8?B?ajNQdEUzS2xzTTF3aDBBL0tHTDFEbGRTYlJ4V0dvaVVJY0pwQTduQjZra2U2?=
 =?utf-8?B?RXl0bE96NzlYQXNFR25lU25tVW13NmdEQVppQUJJWEM5OGdQRWYxOStnQ29C?=
 =?utf-8?B?bkNqWHJyL2FHY2xleHNQTzhHK2F1L0xrSHlyb0hldlVERjdUalQ1SVJYVFpT?=
 =?utf-8?B?NEU4alZFK2lXV0NybzVma0RxalJnR3VuVnJlNzNvazRHVEVOdmJWTkUzTnhz?=
 =?utf-8?B?Nkgyd2pkdWg1dVFPNDBjenRHSDk0dHN2OENjeWVnb0JOUWJNTlhocHVPdFNU?=
 =?utf-8?B?M2VPa3RJYk80MjNxY2E2M2luLytkNkxpTVJTMlR4Wk9tdmZiSFJYTEZ5ZG9u?=
 =?utf-8?B?OEltVkE5ekgrbnp6bENaL253NVc0WEg1a3BkU0M1RVFnRnF4a3A4aG5MRDU4?=
 =?utf-8?B?dGovWHo0c1RYMWp4dDltaStLa0prRXpXWm0vL3E5N1VReFZUaVRrVU1oTC83?=
 =?utf-8?B?NE9aMXJpZldFSWNkd1M2QzNEM3RGVHZSUitpZkNMd2J3M1ZMeWkrZGlYSFRk?=
 =?utf-8?B?RFdtWGsyUkRXNmVBbk1NV1drR2FwRHNYVVZDY1dVV3hvU3Z1cVRYWFdXMjRR?=
 =?utf-8?B?enI2ODhoOVZHTmFoOVJ4RHJuSnVSTkVlaWV1SStKd2hKVTVTSjlSRDRWWjBN?=
 =?utf-8?B?OXBiOW94eXVFcEdjWkJ1c1ZueW01MG5WWlo4aGJRNm5MYU9sejc0c0MrdUhE?=
 =?utf-8?B?Y3VKVjhpRzlaR1hZOFZORnlmRDFQN2tiVWVXcDg4Y3dVRlMvZm5sQVppMDVk?=
 =?utf-8?B?MVFFaXptbVArWDBmVEdGdS9ZOHdHcWF5YnhUZmJQdWVQRWlEbnlTSTVmcVFh?=
 =?utf-8?B?MVUveFo4eEhwSXhITVMxMmduTGVZeXdWTktNNVVQTTJhbzlCdGt1UTZBaXFy?=
 =?utf-8?B?SE16enRQVzZnQUwxQnJUZWhick5icXZIbGlWQ251aUh2SXVGei92Z0MzeWZh?=
 =?utf-8?B?OEhIbFZRL3hDREhhcmg3clVxdnYvYS9uSkFXS3RIZnoxdTUvaEtqdVNaRHlL?=
 =?utf-8?B?RG9oRUtlN1kzeHNVVVVBc042MGNubkRtY2F3TFlUMjZxbXM0WEhHRHVPK3JD?=
 =?utf-8?B?bVdBOHcySE9XcElMQlZKRm9xc280QXdyUHl2WkNtTWphTjVyWkpyZ0JiMlY4?=
 =?utf-8?B?V2EwR1YzZkt4bWovalU2YTFGc0ptdmcvKzdBQ1psckZBWTNTMEJhTFUwaDZH?=
 =?utf-8?B?Z3JScTloNXg3WGN1MndsK1BKd2c0dzc2dDdkS3pKTWZ3NzNuWVJpcG9jRis0?=
 =?utf-8?B?OS95TksyUXdjWUduNityR2UzR0UvTE4waDZrcEFFS3hYaEFSZllISFhTN2pL?=
 =?utf-8?B?aSs1Z1pYNGcwYXlRWTBjc0hqZktKcnlYWGdjU3NWeE1HVG5ySm93eEtGSjlK?=
 =?utf-8?B?bGpQRUkvWDZjaXZ1ZStycWMvV25UeHZtZ2dMMlBxNVRXdkJ6NW5KT0JDRUxK?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a7d7a7-0694-453a-f5ae-08d9a51a35e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 13:50:23.9184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XF/l/oIjucmEcAykL2T0ka5trZfuBtWmT6k/nI/HYRqvUVXjrxif/5bL9rztDFAWW+E1tFhs3qdlOmiXR2Ugw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5717
X-Proofpoint-ORIG-GUID: 3cQdq1G6ZNVwzzSrUoHXRrBV9TCeCwBa
X-Proofpoint-GUID: 3cQdq1G6ZNVwzzSrUoHXRrBV9TCeCwBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_03,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110080
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIg
MTEsIDIwMjEgMTo0OSBQTQ0KPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4g
Q2M6IGxpbnV4LWlpbyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IEpvbmF0aGFuIENhbWVy
b24NCj4gPGppYzIzQGtlcm5lbC5vcmc+OyBIZW5uZXJpY2gsIE1pY2hhZWwNCj4gPE1pY2hhZWwu
SGVubmVyaWNoQGFuYWxvZy5jb20+OyBMYXJzLVBldGVyIENsYXVzZW4NCj4gPGxhcnNAbWV0YWZv
by5kZT47IE5pc2hhbnQgTWFscGFuaSA8bmlzaC5tYWxwYW5pMjVAZ21haWwuY29tPjsNCj4gSmlt
ZW5leiwgS2lzdGVyIDxLaXN0ZXIuSmltZW5lekBhbmFsb2cuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBpaW86IGFkeHJzMjkwOiBmaXggZGF0YSBzaWduZWRuZXNzDQo+IA0KPiBbRXh0ZXJu
YWxdDQo+IA0KPiBPbiBUaHUsIE5vdiAxMSwgMjAyMSBhdCAyOjE5IFBNIE51bm8gU8OhIDxudW5v
LnNhQGFuYWxvZy5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogS2lzdGVyIEdlbmVzaXMg
SmltZW5leiA8a2lzdGVyLmppbWVuZXpAYW5hbG9nLmNvbT4NCj4gPg0KPiA+IFByb3Blcmx5IHNp
Z24tZXh0ZW5kIHRoZSByYXRlIGFuZCB0ZW1wZXJhdHVyZSBkYXRhLg0KPiANCj4gLi4uDQo+IA0K
PiA+ICAgICAgICAgLyogZXh0cmFjdCBsb3dlciAxMiBiaXRzIHRlbXBlcmF0dXJlIHJlYWRpbmcg
Ki8NCj4gPiAtICAgICAgICp2YWwgPSB0ZW1wICYgMHgwRkZGOw0KPiA+ICsgICAgICAgKnZhbCA9
IHNpZ25fZXh0ZW5kMzIodGVtcCAmIDB4MEZGRiwgMTEpOw0KPiANCj4gV2hhdCByb2xlIGRvZXMg
dGhlICcgJiAweDBGRkYnIHBhcnQgcGxheSBub3c/DQo+IElzbid0IGl0IHNpbXBseSBhIGR1cCAo
cmVkdW5kYW50KSBwaWVjZT8NCg0KT29wcywgeW91J3JlIHJpZ2h0LiBJdCBzZXJ2ZXMgbm8gcHVy
cG9zZSBhcyB3ZSBzaGlmdCBvdXQgdGhlIGJpdHMNCnRoYXQgd2UgZG8gbm90IGNhcmUuIE15IGZh
dWx0LCBJIGp1c3QgYWN0ZWQgYXMgYSBib3QuLi4NCg0KLSBOdW5vIFPDoQ0K
