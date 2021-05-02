Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA59A370ADA
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 11:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhEBJLw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 May 2021 05:11:52 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:63348 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229754AbhEBJLv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 May 2021 05:11:51 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 142905im032035;
        Sun, 2 May 2021 05:10:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 3890rd9xw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 May 2021 05:10:58 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1429AwgY016990;
        Sun, 2 May 2021 05:10:58 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0b-00128a01.pphosted.com with ESMTP id 3890rd9xvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 May 2021 05:10:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfLSzwy1QBCXP0CxwyACg1VNxOLruh0vteGx6AxmQKh3LCOZIaFo3/TNDUNk4UDlp1Dcym6bNo6tJr7iOObnye8HG8sFZnddGaAztzziJzzL+WGiAYEjdtdd6+uUx6YwPsXOPt4KhjU3obF3CTFtpotGXAd5R+59IYzLtF3NL7FifoJe+L4ZjWwgTKPvG1cQu+BZio/tunauf6yV3XzQvWRTj3o6S1CaDHO4BgaB5jnssEIo7SOXRR7uidcZZBA58A+wr1Vi1rbQBZEtE4/Oo3rSkR5QHc2wrIEF3ju99ffvMy/W1ZL94p/WouWXFbShfJBcxyBac5UDgcJ4rpfNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfzlUGT/jfA6vsvdv07zfhgXrPsLrVwXGTQwivm5MP4=;
 b=LYYj+b8EaGqmXWHSdLqqdRmyycywE3WtYxSx2Ip8eBiqg7vcfNldx7z7Hek8/MicivJIf3zSO2VewK1M0IPCFkhMcpRqZHihKPYshypNvTLEGU6n0PSvQv7noD+hrwRchvICEIPpUb+SmuUX9J7tIx+bcr8a5mPe3sOY4fjzFNfgvcsrumggzsF7vIO4pT3MjbQteiP4FQPLIdS/3NAwV49ZCwfK1XxpmHjkeYt9FJzC1JUoVz6cFuZ1Axu2+u+rQAjgLPxclJLlitR5urMp28RurNOYkKZJoMmmyGANYsV59Pq+UnCAzct8Ji0xc5DWbmJPkyzkGtgR9s4NutXR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfzlUGT/jfA6vsvdv07zfhgXrPsLrVwXGTQwivm5MP4=;
 b=JUTqKHBnnpusx42YQQKZnw2aKVpjToyRdKR0Ny9aQ3JfHf+NcDis02dvlDwBKN7+8N8SiJjVpN7RkMt6/ymued+D0yAiYq6KLUv7+07fvWoT7LPX3kzP8hl5FLLGCwlvggx6Qc8Ap4u3YQWY/6ji/yTadhAabojQ5fkvghS6Av0=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6350.namprd03.prod.outlook.com (2603:10b6:510:bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Sun, 2 May
 2021 09:10:56 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::811f:3542:ef73:92ef]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::811f:3542:ef73:92ef%6]) with mapi id 15.20.4087.038; Sun, 2 May 2021
 09:10:56 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [RFC PATCH 1/4] iio: core: Introduce
 iio_push_to_buffers_with_ts_na() for non aligned case.
Thread-Topic: [RFC PATCH 1/4] iio: core: Introduce
 iio_push_to_buffers_with_ts_na() for non aligned case.
Thread-Index: AQHXPq8pmIYaNTX0Dkm+X9u8shZfcarP46Xg
Date:   Sun, 2 May 2021 09:10:56 +0000
Message-ID: <PH0PR03MB6366C6AB21991C43CDF40B43995C9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210501172515.513486-1-jic23@kernel.org>
 <20210501172515.513486-2-jic23@kernel.org>
In-Reply-To: <20210501172515.513486-2-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNGI4NThlZDUtYWIyNi0xMWViLThiNDctZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDRiODU4ZWQ2LWFiMjYtMTFlYi04YjQ3LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iNDQxMSIgdD0iMTMyNjQ0MjAyNT?=
 =?iso-8859-1?Q?QxODk2NzkzIiBoPSJ6Qkp1aEpuNSs5V0x2c3ZBN25sMU5La3hRdTA9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUJaVkFZT016L1hBUjEvSEN0RXdXRmNIWDhjSzBUQllWd0ZBQUFB?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:248c:fb01:446:1e37:6027:5acf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8135e30-ab2f-4757-645f-08d90d4a320d
x-ms-traffictypediagnostic: PH0PR03MB6350:
x-microsoft-antispam-prvs: <PH0PR03MB63508F90BC7EC01D74154915995C9@PH0PR03MB6350.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yT/J2+c2w9k6ft6B8FvVM9KSX5a1u1EJAUD1XBnjolhdI2pKwD0yXXgzwV8a2PmM1BBgA8kGsqarbd5LIX4wfE5ivmCd9+0UH9ybJSngTrHrtCczRU0Juv3P+QebB/MoY+r1eUGj9cDXdUbjbqnO0THRO+5hsW1KJ/VV5E4/IUtmwrKjXtmHI4LhoNFnMvkhnLNpaEijbLpZ/5TuJyNvqU+hWrTyt4VsWXyIDBjxExzeOFLY94Xl0VD6wRXINyaKSBCLKcpYXCuQN+jFRGOfwFywUxAYS5h7Ro5lsivDcOmGpXiGBqvQZQQByVZM3IxlsdnbKQTizFsZlg9sd9m9D6jhSWeMqzAjexQucGJnSFC/jlCSgr7IyfVE9J3djq26IYQ6+yskGz9+JWk5SNzhZ8dqjPBxCND1jsXW2PQret7SWD1nZ99XAwvwLg9aspiZbh3edT5HNzoR9m21auhda3mwR6xL3QI1QFpHg/lOR7e0+Ei7yWe4Ix0I9Wiac2qwVlfo8HNKC9RL9cD9OkuRNLWGF0GnTVv2SizKSEju9kEgTz27PqeLoZLwFDrtjrqBnkWDO8ZQIDeVtL6Volal94D3FUcT7DMkz2IexLAC/3I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39850400004)(366004)(136003)(66446008)(86362001)(64756008)(8936002)(53546011)(6506007)(2906002)(83380400001)(316002)(38100700002)(110136005)(478600001)(52536014)(4326008)(7696005)(9686003)(71200400001)(122000001)(8676002)(33656002)(66556008)(5660300002)(66476007)(186003)(76116006)(66946007)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?xcVp5tx0cz5g6+QyWORADWqcJu6s+28HSgrM4wCtvOKc7aUwZVFEwfktZ8?=
 =?iso-8859-1?Q?wjMLcvpbYiZVtpI73CWkkV7lFYKTsqUq7ar+mo1ciEV/x9JX7AUD3bWuFs?=
 =?iso-8859-1?Q?ql0BMWxq7T6hGjcEGm0V8HiOH+v6Nt07+GY0NCaYEpbiTSw4fgY5erv2bt?=
 =?iso-8859-1?Q?NTWZkmMabpWD3fuUh83pEW+CgSd5CZ70IGV9krbkTW/riHTkm+6QfWBusr?=
 =?iso-8859-1?Q?Q6lH1O/lUu6jOOGRoDyxV5iDr+QZRMMFNga75uouyHUWkgk7GING8GLoMj?=
 =?iso-8859-1?Q?0UVYVCavUr2yaFfjgmzJAydtFqCoRbkisEJO/tTM7Kis6sDns4vIZH3rZ+?=
 =?iso-8859-1?Q?cpRWYhAJM3CFA8dIJ1HsUeGRTatqftiYdIPapjvi4RVGGNOwttLm+taDlr?=
 =?iso-8859-1?Q?M6jLfpAEP3wFltUxD8rPrKF59P1FrxpywgILcquT4jWLFHfp/U1yVvcCss?=
 =?iso-8859-1?Q?ElBk96IjRoxggULSmctrP9l7/qK1kQv5y9eca1/PuIhKXzKKDlPkWVhwLa?=
 =?iso-8859-1?Q?vDPMBsGGLDkBMSfqyoJaYgOwN/jJnSG/I/kv35EAZ9ISlV0v/8U2dakUw6?=
 =?iso-8859-1?Q?w8pnwRGGoqJ1Qx80LD0rWFJRS4F0DhHtKKeCXuzlLfjOGnHSM4I5K6u69L?=
 =?iso-8859-1?Q?ydXBIs+FKF4cYMYUbSL3y8bRBzmjk87wImmVsV9jZPROYwgtV+0UuDx7c+?=
 =?iso-8859-1?Q?tFLxz5iseLwRdu4QZipvhkeo+AeTJRVpv3BuaJiURZiOt4QK9EFLAGDaSf?=
 =?iso-8859-1?Q?kXGEfhxy+hKnPIXjsDxAUYQh9I8SllkumXS25F/3A949QAhCeznONLiixR?=
 =?iso-8859-1?Q?orhm5sNLtIq1mP5u4fKHLT39GxIy6vvClsh+XGOk3DhoIAIMPQLW47/NlA?=
 =?iso-8859-1?Q?ARxgfy0fV5Lul1rlsRZbZUJCQbf75OSkCYRZxgbSiG0DfW3oi4gMjQ7lX7?=
 =?iso-8859-1?Q?rAgD84spy7XBERlf6DUuLOu5+hPsjcIdgZihGr1Kk8htW+AYuTm1A9ou0m?=
 =?iso-8859-1?Q?Le9bGOiKYeiU6MLgtaNnMXEEklTgqTB4jTqcCMVe0jKVlQ/I3i5GFlqGf2?=
 =?iso-8859-1?Q?AqWGnpxwsAnNjZz9nwkw3+ICd8Qtg0l6TCP64J8S08QTnSGn4qjXWeVwa7?=
 =?iso-8859-1?Q?XZfqK/Zee+YCQE7NsSXI5raHFFqFQiKNi6QA30GlJsy5TNPsVPh7vtykBC?=
 =?iso-8859-1?Q?/pWfdohkSFR1YTliBP7nF3WM/CHbUnXF9MIa6FfphWdNsk0+3ecoVGCCwv?=
 =?iso-8859-1?Q?FnT0uBeCWP7+Y9ypreATTM4dh+OtUd4Mf0V45zfjkxH0Bs3mJGckST8TZD?=
 =?iso-8859-1?Q?mNWZFzC4wJGkiHZA1kgedKBbPrMaw82Mzo5qxiwvjHKgpeDgAQr/6h5PrP?=
 =?iso-8859-1?Q?MWywraBkiiO4hU2NkiljK2Ycmh0XHD53DOUjiRTLNiPlq68F/ABFBr2RBf?=
 =?iso-8859-1?Q?AA4EQzQgBpNShZxh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8135e30-ab2f-4757-645f-08d90d4a320d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2021 09:10:56.6651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGzf+1SL1XqBAauyBR+xsoESFjEGhB+Fp8Q0wXNjCKcvaOAzz41Sbgp7sCCiBAja5WWbi/ZWI2eM6f1KIXDMKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6350
X-Proofpoint-GUID: -BnZakANVtH1s7iK-UfcJ0pCN1HtysHD
X-Proofpoint-ORIG-GUID: uZAyI9RDAELAHnNZ4MnIvfF3eq7il6m2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-02_02:2021-04-30,2021-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105020074
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, May 1, 2021 7:25 PM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Subject: [RFC PATCH 1/4] iio: core: Introduce
> iio_push_to_buffers_with_ts_na() for non aligned case.
>=20
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Whilst it is almost always possible to arrange for scan data to be
> read directly into a buffer that is suitable for passing to
> iio_push_to_buffers_with_timestamp(), there are a few places where
> leading data needs to be skipped over.
>=20
> For these cases introduce a function that will allocate an appropriate
> sized and aligned bounce buffer (if not already allocated) and copy
> the unaligned data into that before calling
> iio_push_to_buffers_with_timestamp() on the bounce buffer.
> We tie the lifespace of this buffer to that of the iio_dev.dev
> which should ensure no memory leaks occur.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-buffer.c | 36
> +++++++++++++++++++++++++++++++
>  include/linux/iio/buffer.h        |  4 ++++
>  include/linux/iio/iio-opaque.h    |  4 ++++
>  3 files changed, 44 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-
> buffer.c
> index 9a8e16c7e9af..818dfaa73665 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1727,6 +1727,42 @@ int iio_push_to_buffers(struct iio_dev
> *indio_dev, const void *data)
>  }
>  EXPORT_SYMBOL_GPL(iio_push_to_buffers);
>=20
> +/**
> + * iio_push_to_buffers_with_ts_na() - push to registered buffer,
> + *    no alignment or space requirements.
> + * @indio_dev:		iio_dev structure for device.
> + * @data:		channel data excluding the timestamp.
> + * @data_sz:		size of data.
> + * @timestamp:		timestamp for the sample data.
> + *
> + * This special variant of iio_push_to_buffers_with_timetamp() does
> + * not require space for the timestamp, or 8 byte alignment of data.
> + * It does however require an allocation on first call and additional
> + * coppies on all calls, so should be avoided if possible
> + */
> +int iio_push_to_buffers_with_ts_na(struct iio_dev *indio_dev,
> +				   const void *data,
> +				   size_t data_sz,
> +				   int64_t timestamp)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque =3D
> to_iio_dev_opaque(indio_dev);
> +
> +	data_sz =3D min_t(size_t, indio_dev->scan_bytes, data_sz);
I'm not really sure  about this. Is it really a good idea to silently trunc=
ate
the data if some erroneous driver calls this with data_sz > scan_bytes?
(I don't think it's ever valid for data_sz to be bigger than scan_bytes)
We might be discarding data that userland actually requested. So, I'm
not sure if it would not be better to be strict here and return error, so t=
hat
driver developers could catch this early on...

data_sz < scan_bytes is also probably not valid as that might happen
if some drivers call this without the scan elements properly aligned
which will definitely be problematic... Naturally in this case we would
have to take into account timestamp possible alignment fill bytes as it
could be possible (and likely) that data_sz won't include those bits...

Alternatively, we could be consistent with 'iio_push_to_buffers_with_timest=
amp()'
and assume drivers play along in terms of alignment and size
(so, removing the data_sz parameter)...

My point is, if we are taking the data_sz parameter, maybe we should be ped=
antic
about it...
> +	if (iio_dev_opaque->bounce_buffer_size !=3D  indio_dev-
> >scan_bytes) {

Where do we set ' bounce_buffer_size '? I guess we do not want to
get  here all the time...
> +		iio_dev_opaque->bounce_buffer =3D
> +			devm_krealloc(&indio_dev->dev,
> +				      iio_dev_opaque->bounce_buffer,
> +				      indio_dev->scan_bytes,
> GFP_KERNEL);

I'm also not a big fan of realloc so I prefer to avoid it unless really nee=
ded...
Here, maybe we could just allocate this once during device/buffer initializ=
ation
and allocate it for the maximum possible size, i.e all scan elements enable=
d...
That could also make this API simpler to the point of actually be inlined..=
.

- Nuno S=E1
