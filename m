Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A04A3C5B1A
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhGLLCL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 07:02:11 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12532 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230187AbhGLLCK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 07:02:10 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CAuhYi032131;
        Mon, 12 Jul 2021 06:59:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 39rj8dgdt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 06:59:03 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16CAwBdg002517;
        Mon, 12 Jul 2021 06:59:03 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-00128a01.pphosted.com with ESMTP id 39rj8dgdt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 06:59:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqZ+BRVdNm3o1u3CjDWNNA/DYT0Tma9WeSlo0oYTbRHHtTwvH9781j9XjjoMa9N8z6YJtaihK1ln3jExA1Ke+bRQjhuOhSqFDWBYZal9I+B5CESd2l13+eiKZG/raQQqNwBcUCZh8f3jjnMLq8sEqUHn9YKMzhhGMH9HkwiiyLcUU2gK6MpNx5xSXOnKTDE/Zmf1mQETAQNWZXpkzDPx8fYDI5xLSjTKqlFJE2s0/Vw/ybrmJCgG60hAwrThyOQtWnbS7IJsjhTyUPh+b6fHR380mMjeYH32toSZobhOKOaWdtqKFKRGBCx+dkmslMZ7ABUXrxhGSzq+besR81Z6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3yI8QFyOd7mtu0B2hv6ziIEAAsjttudbN4FyDJJW3w=;
 b=etU7MjrrqcxMxoMKc5neS/rEefL9yMDERm+LksZO/VTQM+CYxafhg6w1J4AYiZMxp+1LCJnypMU8aCVUV57XApnFEolFSSmVAp1t1OOVQatFYuCWBmPt8uYwicPOdxNKWz8iYsmo/NYp+slbY9jMTpIGzmOVnQXPJCZyFG3BpmnC104+ueHgVxchEK5chlTnvhrkcEeWRhz4BdxofjhL+ns9YypmqREZW3INup1HJ66kCTQBgHuBrJGjTA0fkBtBzFIayPKUhdpE3ugMwN6uIjs37lEB9U4XxpCsabGndm5/Dvalvthl7uhTWrUg2pP3Rei4+Ey6SG6IydHpf6PH5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3yI8QFyOd7mtu0B2hv6ziIEAAsjttudbN4FyDJJW3w=;
 b=WU1G299lq2onblDibAC2NwXfSLqlnBy7nNlrUWQVXucnnXWawJeee8GVq9/rRE+nqinDsm1eyuxkkp74RXFanfrL6G/IJFff1dmzcYXUMA+GM7cxp3pIO0dHIHd7JQ9ls82K1X8BHAei/Bx2iU2ecmOLMJuY+HxQzeq5NoWGHvs=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5783.namprd03.prod.outlook.com (2603:10b6:510:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Mon, 12 Jul
 2021 10:58:59 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::54ff:7b16:5fc7:38ca]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::54ff:7b16:5fc7:38ca%4]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 10:58:59 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH] iio: light: adjd_s311: convert to device-managed
 functions
Thread-Topic: [PATCH] iio: light: adjd_s311: convert to device-managed
 functions
Thread-Index: AQHXbCTYimFLfU5hEUqMWlbg40f1MKsxj26AgAJo+YCACa2tAIABVt8ggAA+g4CAAAIUcA==
Date:   Mon, 12 Jul 2021 10:58:59 +0000
Message-ID: <PH0PR03MB636667F5DA59084E4D30FCEC99159@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210628135132.73682-1-aardelean@deviqon.com>
        <20210703185007.2c2283f4@jic23-huawei>
        <CAASAkoYMaSuRnSWwtcoZVaGj+m6bDtu7ms2idHBtp5JFzDEp1g@mail.gmail.com>
        <20210711112618.50c5bea1@jic23-huawei>
        <PH0PR03MB6366FCE9E3F85195F881C88899159@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20210712113713.000044da@Huawei.com>
In-Reply-To: <20210712113713.000044da@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMjgyNzhjMTgtZTMwMC0xMWViLThiNzItZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDI4Mjc4YzE5LWUzMDAtMTFlYi04YjcyLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iOTE2MSIgdD0iMTMyNzA1NjExMz?=
 =?iso-8859-1?Q?g5OTAxNjgzIiBoPSJNeFREb2FhZm1UZ1pqeStYZkxOS3N6RUorMFU9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUJ6bTVqcURIZlhBUWYrY0VQdmxjN3FCLzV3USsrVnp1b0ZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQUJPWUdjZ0FBQUFBQUFBQUFBQUFBQUo0?=
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
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad359c48-ba23-46b1-44e2-08d945240d7d
x-ms-traffictypediagnostic: PH0PR03MB5783:
x-microsoft-antispam-prvs: <PH0PR03MB5783CF9D562528DD5529174999159@PH0PR03MB5783.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RrxKSQh06lcuJBnWHjLKKh45Dv8jqewC+DPbBJOF3oKWPQolV5PXYbe8Pzr4/mIntvSCoadi0Qct49FjQpm3v5JL3X0Di6NlsFRwm0AFwQ7uTsHdt3yRKkRbbV/RwciU46WqmfVMTiEpvgdD2OJzx/z1bn3nL22/o1IRtwkjR8uSJndnIYwn+hhSVuQkNPuIOrpXONbIIB6hKc8QBIvaTIhDanfpymQsPLc8aytaNKSlHoIzOqNm+bhrOGmi4kR0nvKHTBNeNmkFfLiY7crGhU8kh8+vEyCjmtmaFANu/DQadvK5MZ5rX0qucQYjl8ONzx+4VSV7N4fK7Jt+EWEUx9m0EAztlwvzLRKvPvGAV/TtDx3tr++ytcTSFSpNow7gsbataWML9jFui8JwsmDidLvP6r3b3TK5wgQi81JTgSCgMSuSvKlhifpzOk7tyzkGPxnfwlXwCU/Bf8Z2UdV5MYGXMSHWXufqb4JlLEOWwp0jMizgZhpA3bYv/0qGGxb9mdW/3B4m+ezW2Vjl6ip5wrfzwbBqYUnzR4+FI7D7Ig0ZEvlKM06TGsre58YJfJcYk7j9gRq5Gsr2nXXFyjbAaSbvJ1ZEgGzf1PNtLE/ClZ5PyJzviaDyZA9b6om32UE5BYFcBRg4+bR6/5sdxKexJxrl6oO+b6HTuartqZ76KJKBzNo0xsjHONFjLscs3rVnQW95vRsDP0fapZ54XIARywhyPbgGNW9FaTHl6+Edj0w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(83380400001)(7696005)(6506007)(53546011)(316002)(33656002)(186003)(19627235002)(4326008)(8936002)(86362001)(54906003)(2906002)(55016002)(76116006)(71200400001)(66556008)(66946007)(66446008)(64756008)(66476007)(6916009)(38100700002)(5660300002)(966005)(8676002)(122000001)(478600001)(52536014)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?glD4yZcQRlyKVZgZ/JnP3VBW+U79XyXe9deXxqnzy8+PEhaCZtgc1SXs9+?=
 =?iso-8859-1?Q?RezAPa+8LrHY5xGYMdLcw54ZiZRqj7a8+H+h+JeGStrPE+fL0jiScYPcb8?=
 =?iso-8859-1?Q?dF+vL5LA1/5VlszDrJT50v2SA1FhvYsqpYaarz/6hinCTv4t6rDNR9eKxs?=
 =?iso-8859-1?Q?07cMrUMYH4Ng/g9UWaGWh7gsyavLB1jdzL8LKt/BJgMslzxFUui1Zbsmwy?=
 =?iso-8859-1?Q?55AnSTF3z8uaWw3JSqX/QNnj0hDEKVNa3NDElciWPJ2YWQLGqZj8XOBY9u?=
 =?iso-8859-1?Q?ZxUiWKU8hfJa5ag8ywzzQC4ZABThCUhtdcXj650ikBteb3nGEIaeC0Ghib?=
 =?iso-8859-1?Q?/lCDfCLeBmiFCMDWOeocqa506Kp9oEXt6dZkFnuTAdBtlD9CtFl7gvktnt?=
 =?iso-8859-1?Q?wIVmJAhxijizhJRLpVdlQuOf4+PcFWIHwqoe8OKRtpzng4WZ2RQv+txl2J?=
 =?iso-8859-1?Q?W+4NmeDhYNdGXenUaEtpPB5TXcHYo4ytMadwtQeScAHPWqwJ8iRee64xkW?=
 =?iso-8859-1?Q?NjZbwXd5kvlHLMG2rqrcjH8adSlHG20NdzwJ5ncZOWJyDMEYE9IS6fpLKs?=
 =?iso-8859-1?Q?bKjprA5hIkAi/GHC/aWiJ6o2Pu6iVAonEVVbXhReViY7U1pmsReZnJyz9P?=
 =?iso-8859-1?Q?biRTCO/oVRRdEDAKxXn+HRQpKIJ0yASvh0dwqRN7nfte/GDEk7xHW0F6Xi?=
 =?iso-8859-1?Q?j8jdc6a2reDiE45R+3AIIhkUlYwDjqgJ9xmRq37N3eZwmROblbDhK5dONE?=
 =?iso-8859-1?Q?GmUlV1EACsJNp7KQdJNyT0pXf1U4eqh4NrN3JUCBodtKLcpTaUE3u0jiMk?=
 =?iso-8859-1?Q?8u8ZPQ31Wf9jdYC4MSR+OqHoYdT3189UK+5Mdkr0HCU7JkeYKDn+9wzz/c?=
 =?iso-8859-1?Q?bdC76NMxTDuJiOoDAdYsYDltJ8tOxAR2ku63PgdXZ/qdYw51yinudYuz3Z?=
 =?iso-8859-1?Q?R7BtdjabrXTh620F7dcr0VlAyfURSJ8l7qg/MUTy/jD9V6ERosfbcJhIJr?=
 =?iso-8859-1?Q?WcYGhI6Xf4ZoHhoXSimS+saRt9Tsy+/MRng+Hv9TNeNFXAxSqOOkQgtfml?=
 =?iso-8859-1?Q?pHGH75svaf9MwX+qX18zaKV3/CypinG4asovagZ+AvICBAAZ4a7nQMS7hL?=
 =?iso-8859-1?Q?SDH68q24BOP9pddZYNyrvGi6h8juK57xSONIytwF+rvwcnysBoZHtFsKjk?=
 =?iso-8859-1?Q?h0rnSvFIUhMaCDKHRPUK3F++RgW8fj2yzKy3w/sgBdANyDorANyGz/gGV1?=
 =?iso-8859-1?Q?t+9NUTJBlUka1W671aQYF49JCTsnL30iOhNND5Lrm23KslMAeYb0sVxTFt?=
 =?iso-8859-1?Q?Aj4s2UvS/vJqFkrijA4AtuIrUMt6JZtie63R2eGpb23CKjRkGaH+c6ltQI?=
 =?iso-8859-1?Q?ZN8YyBK5SSnpuxQ28UKYao8eoANiyhtynh87cYitfCSoXs+D0xs4+QuwXX?=
 =?iso-8859-1?Q?bLOTic1MtW3JyTVb?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad359c48-ba23-46b1-44e2-08d945240d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 10:58:59.6112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAauoKWr4PsrDzrxEE6gykpVv+WbId2izGrr/JfZBgQe4d2XSlj7mYTw8g9iRrFvcbibdczKLqVvhA+km2DMFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5783
X-Proofpoint-GUID: ebzSsxPqJqoWU3Krk5MAKN9r1F3TXS0e
X-Proofpoint-ORIG-GUID: BJdwVNpmeSimxElw7tw0YLMtM9Vg-N2C
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_05:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120085
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, July 12, 2021 12:37 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; Alexandru Ardelean
> <aardelean@deviqon.com>; linux-iio <linux-iio@vger.kernel.org>;
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>;
> pmeerw@pmeerw.net; Lars-Peter Clausen <lars@metafoo.de>
> Subject: Re: [PATCH] iio: light: adjd_s311: convert to device-managed
> functions
>=20
> [External]
>=20
> On Mon, 12 Jul 2021 07:45:42 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
>=20
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Sunday, July 11, 2021 12:26 PM
> > > To: Alexandru Ardelean <aardelean@deviqon.com>
> > > Cc: linux-iio <linux-iio@vger.kernel.org>; Linux Kernel Mailing List
> > > <linux-kernel@vger.kernel.org>; pmeerw@pmeerw.net
> > > Subject: Re: [PATCH] iio: light: adjd_s311: convert to device-
> managed
> > > functions
> > >
> > > On Mon, 5 Jul 2021 09:38:21 +0300
> > > Alexandru Ardelean <aardelean@deviqon.com> wrote:
> > >
> > > > On Sat, 3 Jul 2021 at 20:47, Jonathan Cameron <jic23@kernel.org>
> > > wrote:
> > > > >
> > > > > On Mon, 28 Jun 2021 16:51:32 +0300
> > > > > Alexandru Ardelean <aardelean@deviqon.com> wrote:
> > > > >
> > > > > > This one is a little easier to convert to device-managed, now
> with
> > > the
> > > > > > devm_krealloc() function.
> > > > > >
> > > > > > The other iio_triggered_buffer_setup() and
> iio_device_register()
> > > can be
> > > > > > converted to their devm_ variants. And devm_krealloc() can
> be
> > > used to
> > > > > > (re)alloc the buffer. When the driver unloads, this will also b=
e
> > > free'd.
> > > > > >
> > > > > > Signed-off-by: Alexandru Ardelean
> <aardelean@deviqon.com>
> > > > > > ---
> > > > > >  drivers/iio/light/adjd_s311.c | 34 +++++----------------------=
----
> ---
> > > > > >  1 file changed, 5 insertions(+), 29 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/iio/light/adjd_s311.c
> > > b/drivers/iio/light/adjd_s311.c
> > > > > > index 17dac8d0e11d..19d60d6986a1 100644
> > > > > > --- a/drivers/iio/light/adjd_s311.c
> > > > > > +++ b/drivers/iio/light/adjd_s311.c
> > > > > > @@ -230,8 +230,8 @@ static int
> > > adjd_s311_update_scan_mode(struct iio_dev *indio_dev,
> > > > > >  {
> > > > > >       struct adjd_s311_data *data =3D iio_priv(indio_dev);
> > > > > >
> > > > > > -     kfree(data->buffer);
> > > > > > -     data->buffer =3D kmalloc(indio_dev->scan_bytes,
> > > GFP_KERNEL);
> > > > > > +     data->buffer =3D devm_krealloc(indio_dev->dev.parent,
> data-
> > > >buffer,
> > > > > > +                                  indio_dev->scan_bytes, GFP_K=
ERNEL);
> > > > > I got some complaints about exactly this trick in a review
> recently
> > > so I'll
> > > > > pass them on.
> > > > >
> > > > > Whilst devm_krealloc() usage like this won't lose the original
> > > reference, its
> > > > > not what people expect from a realloc() case, so to not confuse
> > > people it is
> > > > > better to do a dance where you use a local variable, then only
> set
> > > data->buffer
> > > > > to it once we know the realloc succeeded.
> > > > >
> > > > > That avoids this looking like the anti-pattern it would be if tha=
t
> > > were a normal
> > > > > realloc in which case you would just have leaked the original
> > > allocation.
> > > > >
> > > > > More interestingly, why are we bothering with resizing the
> buffer
> > > dependent on what
> > > > > is enabled?  Can't we just allocate a 128 byte buffer and not
> bother
> > > changing it
> > > > > as we really aren't wasting that much space?  Just embed it in
> the
> > > adjd_s311_data
> > > > > structure directly and don't worry about the allocations.  Will
> need
> > > to be
> > > > > aligned(8) though to avoid the
> push_to_buffer_with_timestamp()
> > > issue.
> > > > > Using something like
> > > > >
> > > > > struct {
> > > > >         s16 chans[4];
> > > > >         s64 ts __aligned(8); /* I hate x86 32 bit */
> > > >
> > > > do you want to me t also add this comment? :p
> > > > [just kidding]
> > > >
> > > > > } scan;
> > > > >
> > > > > Inside the priv structure should work nicely.
> > > >
> > > > i agree; will do it like this;
> > > > i hesitated a bit due to the inertia of converting things to devm_
> > >
> > > A long discussion on rust usage in linux diverted into the issues
> around
> > > devm.
> > > I 'believe' that we are fine in IIO after some work Lars did a long
> time
> > > back
> > > to make us resilient to unbinds whilst the chardev was open, but
> > > probably
> > > worth keeping an eye on that discussion.
> > >
> > >
> https://urldefense.com/v3/__https://lore.kernel.org/ksummit/CANiq
> > > 72nkNrekzbxMci6vW02w=3DQ2L-
> > >
> SVTk_U4KN_LT8u_b=3DYPgw@mail.gmail.com/T/*m6db86a574237c22a3
> > >
> 2ecf49b596b3c2917967c5e__;Iw!!A3Ni8CS0y2Y!oeM8GJzKVXb8mYa1m
> > > VJNw5fI2adsFk3FKkFzbnqyuDkUMKVTKQ3OoT0cnXP5rA$
> > >
> > > I'm a tiny bit nervous that there might be races where we are doing
> > > the devm_realloc.
> > > I 'think' we are fine, but the 'think' and 'believe' in these
> statements
> > > expresses
> > > a slight lack of certainty!
> > >
> > > Jonathan
> > >
> >
> > Hi,
>=20
> +CC Lars who might recall how this all works!
>=20
> >
> > It's the second thread where I see you mentioning this, so this I will
> take the
> > opportunity to also give a bit on though about this. I actually have in
> mind a RFC
> > (hopefully sending it out this week) for this as I think we might still
> have some
> > issues with open chardevs and device unbinding.
> >
> > What we have in [1] is not enough to make sure the whole thing is
> synchronized with
> > device unbinding... We still have the door open to races where we
> call 'iio_buffer_ready()'
> > or even 'rb->access->read()' after the device gets unbinded. Maybe
> we are lucky and
> > nothing bad really happens and we just error out in the next time
> 'read()' is done on
> > our fd.
>=20
> My understanding of that test is it was only intended to ensure a
> smooth exit 'after' the
> buffer pull down has occurred.  From vague memory rather than
> careful analysis, the
> reason it is needed is we only send the break out signal once for a
> given buffer,
> so we need to be sure that userspace doesn't call read() then ignore
> the error returned
> due to the buffer going away mid read and call read() again.  There
> may be races in the
> first time path though. In particularly I'm not sure the reference count
> on the buffer

Yes, that is my concern. In theory , with the current code, there's no guar=
antee
that some user might already be in a 'read()'-> passed the 'if (iio_dev->in=
fo)' check
and then get's preempted for example. In that time, the device might very w=
ell
be unbonded so that when the user is scheduled again, we will be left think=
ing
the device is there but it won't. Or maybe even worst, we get re-scheduled =
in the
exact time the device is unbonded so there's plenty of room for data races.=
.. As
you stated, this is only a thing in the first path. And probably one of tho=
se concurrent
things that might have a 1 in trillion chances to happen. But when they do,=
 they are
hell to debug :).

> is raised during the read and it perhaps should be.
>=20
>=20
> > However, during the possible race,  I think it's very likely that we en=
d
> up touching
> > the same data structures concurrently. On some devices, we surely
> > (in theory and if all the stars align) have a path where
> 'iio_buffer_flush_hwfifo()' might
> > be called with 'indio_dev->info' already set to NULL...
>=20
> Yeah, the hwfifo stuff is more recent, it's definitely possible there is =
a
> race around that.
>=20
> >
> > IMO, the only way to have this fully in sync is to use the
> 'info_exist_lock' as it's done
> > in [2]. I think [2] was actually "fixed" when Alex sent his patches for
> multi buffer support...
> It's rather painful to take that lock. If we can make things safe with
> appropriate reference
> counting that's definitely preferable.
>=20
> For ioctl's they are always slow path so the exist_lock route is fine.
>=20
> > Naturally, for the read case, we need to make sure we are not going
> to sleep with the
> > mutex held so we might need an unlock -> lock dance which is not
> that nice. But I'm
> > not really seeing another way. We also need to look at other file
> operations and also
> > for the events case to see if this is also a thing.
> >
> > Naturally, I might be missing some subtlety and that's why I had this
> planned as RFC.
> > But since is mentioned here, I thought I could bring this up as in the
> end I might not
> > even need to send the patches :)
> Wise move :)
>=20
> I'd suggest that any fix in this space would ideally be accompanied by a
> confirmed race.

Yeah, it makes sense but this is one of those cases where this is very hard
to hit...

- Nuno S=E1
