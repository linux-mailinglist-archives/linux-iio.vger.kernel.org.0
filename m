Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3396F330ECB
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 14:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhCHNBP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 08:01:15 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13332 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229950AbhCHNAz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 08:00:55 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 128CvB9Z004689;
        Mon, 8 Mar 2021 08:00:40 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 3744fbcme5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 08:00:40 -0500
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 128D0dOg010401;
        Mon, 8 Mar 2021 08:00:39 -0500
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by mx0a-00128a01.pphosted.com with ESMTP id 3744fbcme2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 08:00:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLZoBt+gM0+jLs42hm276RV/R3KmpM7PCKcdMc4oc7D2B0DZnXEVqq0gYByVPGtKccMmDYzD2n/eqcjeP5lNm4LtE6U9sfVszcJozPLrqOaakVgn3qLRIoU0p/D/Vm94pdeqDDvW+tqXb/BuPq9+7gn7SVphNnQelkQKn/k1cpKln6+EY31LFctXBQuB8f+yTa554D1grTWSAbNGN5w9FXVBxBpKwvJUHFH0GAha167E6vudnjCJflodgOrGcqpsu0BEr99paWe4TE6msfJ5EEJNuvD9wzMsgmKmz/zg7xTbuXrLKoUPnZN/Uo3q6w6V4PPUK1CNEXqcjLVnc3sZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=887u8VRJM+KrxqsDhTLB2qfRKlZtC/Q7gIBuUedjXZI=;
 b=AC2SviH+U8AvjuanfDP5TnPKtB7BZNTl1jq6eS+CMp49Lcct9882YkgrQGstem5DRjWR0uhrFIhFqGVSS7b7x+yFD+iZoqj29HP9qzimptdweqJQo95dQQuKCKmLNTqhs/Yh8ygZ4p9n/aGeV/rd2joLAC9KW5TIomJAGWf9IMvrQIwTvJkoYNgokLdNLYaUkVF9u+7Ujcm7cR9yPm/Yf7U1cMsOyrZG3XvKdzSwXgxFIBA88m2V72b/F4jxl4n6Y+vMssD5EFmF0RC6D5emyiJnBXQaM785GkIcHnAf+XztPiQkNuJN9/uzEn9gkdB4EMl5kLjOAixKajjaRQ/f1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=887u8VRJM+KrxqsDhTLB2qfRKlZtC/Q7gIBuUedjXZI=;
 b=iBF+XfUvAk31ggJfk/KlwBqCyyX8E0zQgL0lWEKysIS76fHbcDATyewUW7eN4qxfSR+G2zKjyDYloIWv4Z358zbaE4xS31LJ3l+bNmSfMmfF+wgq7BGTK3CkvzEA0c2g8pT25uKD1C5WUYCQ4HXBzbXQT3nrMsIgkYlUnTbbzDU=
Received: from CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:74::18)
 by CY4PR03MB2869.namprd03.prod.outlook.com (2603:10b6:903:136::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 8 Mar
 2021 13:00:38 +0000
Received: from CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::b439:cc16:d1ec:1c5e]) by CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::b439:cc16:d1ec:1c5e%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 13:00:38 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "zzzzArdelean, zzzzAlexandru" <alexandru.Ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [PATCH v3 0/6] iio: Add output buffer support
Thread-Topic: [PATCH v3 0/6] iio: Add output buffer support
Thread-Index: AQHXBrxjq9QBbWMRtka/kQD4wV/AUapihP4AgBKolACAAiL4gIACpXPggAAfcoCAABE7cA==
Date:   Mon, 8 Mar 2021 13:00:37 +0000
Message-ID: <CY4PR03MB26318FE58CDB5301224EAC9399939@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20210219124012.92897-1-alexandru.ardelean@analog.com>
        <20210221120106.00ae1078@archlinux>
        <BN8PR03MB497724AAAFA43E6555554DC98E969@BN8PR03MB4977.namprd03.prod.outlook.com>
        <20210306173449.06f2f32b@archlinux>
        <CY4PR03MB26318300B44C07A5890067B499939@CY4PR03MB2631.namprd03.prod.outlook.com>
 <20210308115203.00006230@Huawei.com>
In-Reply-To: <20210308115203.00006230@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNDRjMDdjMTItODAwZS0xMWViLThiMjQtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDQ0YzA3YzEzLTgwMGUtMTFlYi04YjI0LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMzE3MCIgdD0iMTMyNTk2ODIwMz?=
 =?iso-8859-1?Q?YxMTk2MDE3IiBoPSIyMHRUQTdEQlR1R0Qzb1p2YkErdEJvNG41LzQ9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUR4c2ZrSEd4VFhBU2VLdyt0b0JxbUxKNHJENjJnR3FZc0ZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQWJKUFNkUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCaEFISUFhUUJoQUY4QVpBQn?=
 =?iso-8859-1?Q?BBR01BZEFCcEFHOEFiZ0JoQUhJQWVRQmZBSFFBYVFCbEFISUFNUUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBY2dCcEFHRUFYd0JrQUdrQVl3QjBB?=
 =?iso-8859-1?Q?R2tBYndCdUFHRUFjZ0I1QUY4QWRBQnBBR1VBY2dBeUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?iso-8859-1?Q?Q0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:24bd:6c01:a1f5:689b:a546:7acf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aaf42b1f-5413-4553-37a8-08d8e2322ba4
x-ms-traffictypediagnostic: CY4PR03MB2869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB286945E731E32561A2580C0599939@CY4PR03MB2869.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QY4ml0oD2WLZBB5tIOufH8Ox4b3tmjWZzyomkg6X86Ki21nViP8lVa8u/N7PqrnvfR0B3BzKVZvJ1UMFOzsO5XBlZVd4uC/BQnyrv388H3jeX78S4XKPI0Z32H+IPID/g91lM9acPHAnZJCwGIMsc6MWE/DQgmbTXXVqbxu7s19ijKPJAV4+BO3QBLqj5g/3tm74wfhEXKMgScRsokjaIGaZl91xoidfzN9DamybKXwodKFcl3gch3HTyTUegY/KdIIIYimPsmHeliSfP9AuFr5KiWDb/t67ecoc98WziEeNwME96CXjPNyBh1uTpas60DTiseeYhIWoMOdUunPnLpKJH0bp/bTIqi99Sd3PAvoh+v3cgW7xsd2tk6VBiepxSl4/WxAj+Q17QTvaEQzs9jiRJyZDKeYgTs8zGhAfHYY4fgklhENb+fD9PyOfpQgAB2rhmmB1esUB6rpWmkoFZPn4RwSM06XllvQDuOEXDrAt51b4eu9cSCCywkWMarDesx9/pQYvKrMGUnFbAHHMpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2631.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(6506007)(4326008)(478600001)(5660300002)(110136005)(107886003)(316002)(7696005)(186003)(76116006)(54906003)(66556008)(66946007)(33656002)(66476007)(64756008)(66446008)(9686003)(2906002)(55016002)(53546011)(86362001)(83380400001)(71200400001)(52536014)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?ijCNOei77noEQtCRUmK4cwvYhscU2I9H+dFiehu9Nt5ZJRBEr574Ts2ldC?=
 =?iso-8859-1?Q?QuTVzm5Cat/JgVdboL/leNyo/cxDpXBTVbdfopA5bE3HTqgv9RgSCsfcF5?=
 =?iso-8859-1?Q?4Z73hL8iDlVmwqlm4AvCxcBjJPPkHQpoQREX+2+uIgfY/JFQX9jTWLH34O?=
 =?iso-8859-1?Q?Ygf4/RqYXrXTcRp0tVpi9gagQ3mUuegPvepGLiF69o7Cuxe3VGh9c7XEpP?=
 =?iso-8859-1?Q?ce0V/CxWK+jWIGuWIw+V1OwdtFwGxwvvgOadlKNU54yezQxeli/ywkvZGd?=
 =?iso-8859-1?Q?tGCduivBuFo9y0UyX1wj8zU2YzFrEYcIpw8TzAM4QsnbAvcK2PlvpVk613?=
 =?iso-8859-1?Q?+kpN8fG+KKcoyUiZlSf7W1vhidAcIr3fRxCu4yFIY8WJZfFjXKTvjEuEoI?=
 =?iso-8859-1?Q?RtbKZiSwATQ0QOKVKQmgPf/a0Ve31GVsLTPCt2aT2L4LMKJHIrKGgbyZO/?=
 =?iso-8859-1?Q?O09QcgrpN+wJ/ZFH0+T37VGgd3R5kPw+NHrMng/eT3r6bJLAhMWfvvWRnI?=
 =?iso-8859-1?Q?bNACbQUTLU7DVIY+KYnHMoOPhv9064DjROXUASp0tEv3B0eyrD6dxdN9AS?=
 =?iso-8859-1?Q?TRHwlyc3FlFMR/JhBKJGhp8xOF6IKStrXTE132nLvwe0CwfrUrzLb/yxqy?=
 =?iso-8859-1?Q?3BAObJrZG/pcQSmbMTx3ykkQtF78zzKMSXeDCHqhOYMVrp8pG7YshO1BRe?=
 =?iso-8859-1?Q?iPy+9adSqTFfK0c89unWSAgwy2D2Z+PpEjcKu+41RmuVKI/DWN5JtY9oec?=
 =?iso-8859-1?Q?JVbFVPad447uVaKd9tbSHs6FDOeWxej61raz26kKluNu585aL4qS763mlJ?=
 =?iso-8859-1?Q?OT/JqjDNU0GwPSp+g0ltcu8IOdKGC/R6N1SLP/SELNfq1Hivw7ZRQoEMQy?=
 =?iso-8859-1?Q?d8WKLsf9bJRZm65z8HSahJAR0tJs06SQyb7MYOiqVM/PpteDnpjXpwYkML?=
 =?iso-8859-1?Q?fI9K04BMv05m0ecdPuqEVPoGCKrqYd0KCuxtitslLzl3wDa2yYaiYyXtW/?=
 =?iso-8859-1?Q?igcklBZanptFXaI4G4MZdRqtmcEdHfbhyFf1nOdnfM4XrpXxS6cO89Vgaj?=
 =?iso-8859-1?Q?QXT/VF0TeYmhFqv+YVmJdol/jB5+RmxGY4oJfZJeJWbFzIppNsIB2gXH0w?=
 =?iso-8859-1?Q?0/b8gSUmgQYdRYc32X5s4WITRYoIRpovlAZugsyb4bW3s0BqAcogkiTLz9?=
 =?iso-8859-1?Q?JGyifvscSws4XWEjmImixuO4KavqUmvG7CaocDsHFkXmzKhgnTEO/RCB/O?=
 =?iso-8859-1?Q?9by8SIHO1CqdlQFA66ZZUT1FBPyDYAMC4xkatN2A6s1oQxEc+eQXVjt+2t?=
 =?iso-8859-1?Q?hF/dtHrAEXLgP2v0eqyMnFo4+xwj8j8PNs1EsTEWesUP9esNObg5Jvbi+j?=
 =?iso-8859-1?Q?eKavsykc2OgXVVz7DPspDqz7pUTfugJ+zjMHEr3vj4EPEhivz4JInm9BLd?=
 =?iso-8859-1?Q?7GN3ZYsT4TJuJz4m?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2631.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf42b1f-5413-4553-37a8-08d8e2322ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 13:00:37.9260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Utbkr2TXxlK7DVupswDfWxWjWdugi/Tbnamxp4oLgtnPElEkHrvW508zqFX5AJRLZq7tiVSoWoTFIX+nglEUFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_08:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080067
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, March 8, 2021 12:52 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>; Jonathan Cameron
> <jic23@kernel.org>
> Cc: Hennerich, Michael <Michael.Hennerich@analog.com>;
> zzzzArdelean, zzzzAlexandru <alexandru.Ardelean@analog.com>;
> linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> lars@metafoo.de; Bogdan, Dragos <Dragos.Bogdan@analog.com>
> Subject: Re: [PATCH v3 0/6] iio: Add output buffer support
>=20
> [External]
>=20
> On Mon, 8 Mar 2021 10:07:05 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Saturday, March 6, 2021 6:35 PM
> > > To: Hennerich, Michael <Michael.Hennerich@analog.com>
> > > Cc: zzzzArdelean, zzzzAlexandru
> <alexandru.Ardelean@analog.com>;
> > > linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > > lars@metafoo.de; Sa, Nuno <Nuno.Sa@analog.com>; Bogdan,
> Dragos
> > > <Dragos.Bogdan@analog.com>
> > > Subject: Re: [PATCH v3 0/6] iio: Add output buffer support
> > >
> > > On Fri, 5 Mar 2021 08:57:08 +0000
> > > "Hennerich, Michael" <Michael.Hennerich@analog.com> wrote:
> > >
> > > > Hi Jonathan and others,
> > > >
> > > > With output/dac buffer support the semantics of the
> scan_element
> > > type may change.
> > > >
> > > > Today the Format is
> [be|le]:[s|u]bits/storagebitsXrepeat[>>shift].
> > > >
> > > > While shift (if specified) is the shift that needs to be applied pr=
ior
> to
> > > masking out unused bits.
> > > >
> > > > So far so good and it sounds universal.
> > > >
> > > > However, we use the right shift (operator) for that, which makes
> > > sense for capture devices.
> > > > For output devices the more logical operator would be the left
> shift.
> > > >
> > > > I'm not proposing a new Format here. I just want to get some
> > > agreement that for an output device
> > > >
> > > > le:s12/16>>4
> > > >
> > > > is understood as a left shift of 4, since the unused bits are then
> on
> > > the LSB.
> > >
> > > Good question. Guess I wasn't thinking ahead when I came up with
> > > that :)
> > >
> > > I'm not sure I'd mind if we did decide to define a new format for
> > > output
> > > buffers. Feels like it should be easy to do.
> > >
> > > What do others think?
> > >
> >
> > I guess the most straight forward thing would be just to add a 'shift_l=
'
> variable
> > to 'struct scan_type'' and make sure either 'shift_l' or 'shift' is def=
ined
> and then
> > properly export either ">>" or "<<" to userspace?
>=20
> Given we already know it's an output channel, can we not just use that
> to make the decision?
>=20
> Jonathan

I would argue that having two variables gives us more flexibility for whate=
ver
the future brings us :). But if we can sanely say that an output buffer wil=
l
always use left shifts, then we could definitely use that information... I =
mean,
we are already doing that assumption for input buffers and right shifts...

- Nuno S=E1
