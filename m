Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF053C539B
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 12:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245003AbhGLHzS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 03:55:18 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:51646 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245606AbhGLHsi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 03:48:38 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16C7jMOa001414;
        Mon, 12 Jul 2021 03:45:43 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-00128a01.pphosted.com with ESMTP id 39q869cv89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 03:45:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk6DcpAYCEbpUqcDapVnFqUz2uYsmy8xs1c9MDqr7AC6JYTfXohOe3rxTIWCAzzuZMD1Bl0syo2bgykqIYqGv01/j6zpfH//2SjTAJNlpdwIQARmVdPDees+9W9b4YGNjO02PLUZMuCKeOK9YhOscUi+eQn+NV3mIfP7Vx0juT5nTsZkHMF2DSuPpacsVKTMtGdEVrpdJfLuzS82yBrNvzzgKSMrOlW+JP4AeSD+iZPVqyz9NRcydBhzUxCx14WbrTKJgB9gFkQ7kJQfxj31VSgFfxmoP6SzoK7Oav2Dgez0w1id8h9THLdIMhhdSoG3X/YbCq/QlUlWMSNrjzwd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozgqIicdftWe5WJcfEakF7rtuJiTndIz7XQEU+Gm4Xk=;
 b=NkFPv6JC123dr4mvYIq5oVSUCkg6baQhFlGtxEheo/p7KlfON7tIdyN8UVrPFYm3bCwJELTEcpC2nRqnGBamYgM+SEDI8QPSgExGKQJdZy9kmOK6ZpTBmNUgfRUtIJ/sCiNZKJLCyKFI2PuNpMRspe+fKHrdfznO0ACztTeds42X/+3g4C1t5ruIqfIBoFp2++t3e2Y0Utdrz1wl6a/7HzToqH6OwHPmEYTj9LVnFnTHFM4U6hHHcvKgzy+f7NtYlUp7CtQfAl11t4CeMGkPomdOzeKcmoXGGUbM4pzit19ctA4F5vADjp+QG1W7Yy5h9+9jhSPLBcQluz1eGbgkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozgqIicdftWe5WJcfEakF7rtuJiTndIz7XQEU+Gm4Xk=;
 b=r4rIw8QHd4p14LWOl/vFeX60+dq2arv8kzN/6zaphY1Fcc0TyeRdp945EXU27Zn/w8Bn1GvGdX8BxXFCnAG7uefW3UgddWa+8GEpRtTUe9Pq7cOjwwy3Y0FU2+GELWpWrdVzloBHEuAY5Bh7ezzqliCETp6bitSnZ9DjD0MxFMg=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5701.namprd03.prod.outlook.com (2603:10b6:510:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Mon, 12 Jul
 2021 07:45:42 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::54ff:7b16:5fc7:38ca]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::54ff:7b16:5fc7:38ca%4]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 07:45:42 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: RE: [PATCH] iio: light: adjd_s311: convert to device-managed
 functions
Thread-Topic: [PATCH] iio: light: adjd_s311: convert to device-managed
 functions
Thread-Index: AQHXbCTYimFLfU5hEUqMWlbg40f1MKsxj26AgAJo+YCACa2tAIABVt8g
Date:   Mon, 12 Jul 2021 07:45:42 +0000
Message-ID: <PH0PR03MB6366FCE9E3F85195F881C88899159@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210628135132.73682-1-aardelean@deviqon.com>
        <20210703185007.2c2283f4@jic23-huawei>
        <CAASAkoYMaSuRnSWwtcoZVaGj+m6bDtu7ms2idHBtp5JFzDEp1g@mail.gmail.com>
 <20210711112618.50c5bea1@jic23-huawei>
In-Reply-To: <20210711112618.50c5bea1@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMjc3YmUwOGMtZTJlNS0xMWViLThiNzItZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDI3N2JlMDhkLWUyZTUtMTFlYi04YjcyLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iNjIwMCIgdD0iMTMyNzA1NDk1ND?=
 =?iso-8859-1?Q?EzODA0ODU1IiBoPSI0R3dlUnFud0kzOXE4WGF1SW9CMUovRTdKaVE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUEzeitIcDhYYlhBUVhhWWZJc2tjM2ZCZHBoOGl5UnpkOEZBQUFB?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3b5c769-2a3d-4879-3898-08d945090d11
x-ms-traffictypediagnostic: PH0PR03MB5701:
x-microsoft-antispam-prvs: <PH0PR03MB570157DD4E140906A2E7CEE099159@PH0PR03MB5701.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f6ne8m61XRQGEqhHyaa+SwgA+PAR02tnMv7m6IkGVSPI4QzX/1SANmaWSPJ7gVbL8aktHYUK5kc06RQzuKCyG5Es/3xNDWJ9KTnoELWPQudouK+K+TsceUQCZZusysUIKxZWcx0y7KNzyqzsuHB5pAMPL5VHLPBmSlopemvniuTUKcaGcJq/s5hPzppTPmFWIHT7GE3mV83iJE7u5G1t0/NOcly9MYmua1eNgRjk0xqlPkY+yOSvCMCR2CCdxtlsw5Mpbjtlx6acq5qKqcrxcJukf4ldv3bFs3z9FOkC1u36DdBHfk7HmNVqm9aXjJC0rBNT98aCQ7NJ/Rya+hMZeUti2xbPRQzN+4DCQZ6FOJYUD+2CBNYr2GvdhYBfjlUYR05WSq2ISVJZU4P5skivJ+vLi4L0/NAuH5Kk5k/YCBwWQBuDyUEL4QpSO6g+m4MuAF5VBgRy/wdnP6wiIBgAmSl5mS4EZeCCib6n1EzWOe3P0fGQEnIh8d0p8jLxXTfLPJMvJdIuqJ1Qh6mKVbk/72ZJraeHWxMAnNqa3i+/DucvDXa2fIjHp8wvtOQVQIACky2PykeW0ca9hEGlMv5Jd8H+TN1n/TuOzzpFcVTgSHZfBE0t3HN8au5baNxT9SoU6U24fycDrZfbbi/aTZrgw404Z7Olym2ot2h/1W2f/v4flqzoVxvmFjQCxUKNI+LgERn+svvo4eIByD4csW8yazShsaPHzjB1hxLDEdetq52joOJZz2n3Ayv7JBgyMh6U03w7GucAPb3FlXJ7Qe/B+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(2906002)(86362001)(966005)(9686003)(55016002)(71200400001)(7696005)(54906003)(53546011)(6506007)(186003)(33656002)(110136005)(478600001)(38100700002)(5660300002)(66476007)(66446008)(64756008)(66556008)(66946007)(8936002)(122000001)(76116006)(52536014)(19627235002)(8676002)(4326008)(83380400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jSoxa5ESh3+DTYcu5UKZg+CtxsXBl3TO+74f80HbWeZBejfc/+RWvXR7XR?=
 =?iso-8859-1?Q?l5d9+C6KUgf29uDbAtLAG1r2lh6sLcheaMinIREd9XPbWQXuiuQQ/CCSwp?=
 =?iso-8859-1?Q?b2vL9UwCoq+xxNLc8trSBtodHX/7YPt6oNmwbkr5luUTq9/XQH5XhO/0OO?=
 =?iso-8859-1?Q?lH7ztDRvxIIcnn8frwrSrrwkvcdKtEUBXtSONSaXTljWY9B5YcZ5ngeAYH?=
 =?iso-8859-1?Q?40Usny1JY7dzf7yQKdxVhfXcqLtT+bBKgW4iag0ROCJB/FjZrs/k5IIxir?=
 =?iso-8859-1?Q?8Hy1hLt+evM6OVvWCFUM/O25gLFaoEY4Rt5l+XNzcOQNQYlGKUqguOyZGF?=
 =?iso-8859-1?Q?99PLe+Qw/1u+UCg7ONG6+av4dogLAd2nvzkagJ9Gi1S1b+X0oaA1o9z/kf?=
 =?iso-8859-1?Q?AQxec88WPhU06UtG/rFmNSWgiIGPmIiEJNXU5IuybbKzvsQvq5W8skFmzz?=
 =?iso-8859-1?Q?pNpug9mDAn4wQMlkHQ+FVGI67t8XNs8N7Wa95w1DNCztU4+cXtG3JUmSfi?=
 =?iso-8859-1?Q?1Jcn5OlhsNO0p/tqZdupBddYZTl1r8NtQ6UzXClwSo1UABgHqoTNdx+K3+?=
 =?iso-8859-1?Q?PVL7XUwNtm5aNiQgTtocWTD7MdPAfHI/l9pZY4hcRKgs3z5cBAq+dievhE?=
 =?iso-8859-1?Q?RdFyAxhdv1y8uyh7112wpms9WnLlb1DQx3zGby3cweF9xgi/ww1Lv3Efdp?=
 =?iso-8859-1?Q?lKD+O7QhkwBicTQA3EZf1Cm/pI5FIxSs+XXy6NHM2LC92TxdWWSh223erY?=
 =?iso-8859-1?Q?SSsH/+fb+hVf7xzzg2HQGlAsmHjzdAuYFq6lbXEhYlhQQ5iaguluGbeGJ8?=
 =?iso-8859-1?Q?bAhxuJvLZc3YkRpewwOIFj50YfnkHsL9w7R8cJS5ppD1cC72KLnJ+Psh3v?=
 =?iso-8859-1?Q?NSvhV91irR3QNKrz4kGsPQGGl8f5uMAJVeoDuSbdBgbrho43eH4O/G6/YI?=
 =?iso-8859-1?Q?EPyD5sTxMMV3rW0TFzVBiNb+hJqaNyWWf6N/ECa5CX4lxI5A+0xKNMoyu7?=
 =?iso-8859-1?Q?8751mH/WW1bse+iKGFt7HgirXChQxBzeW5amyRHBj8SqP/uTIFAaC5Mpxx?=
 =?iso-8859-1?Q?VAsakWv3ejIJkwtdSrGJ/sbvUHYIdv3OgQfyZE7D8dLmOqp1yJ1MA7493b?=
 =?iso-8859-1?Q?mn26NgJwMP55/qereprc1j4neehDKNSkIE9m2LEzAAl9oz7curZ39oKSW+?=
 =?iso-8859-1?Q?DM3zz32aTzNEaRGRSf/XKC7kmM7PS/glA4PZQtViYkx03YvfNmzxQOO4r0?=
 =?iso-8859-1?Q?yAxLrjvTEi4S9xu/psqlWa7AAc6sJK4BdsQ/OOgFNPBHsAvnH1d+6V00ay?=
 =?iso-8859-1?Q?fzC2r3mFwoQ9X4spF3cZ8D1BmZHkhlLMUkJFhGoZJhdJidSlUElzGJ/OKq?=
 =?iso-8859-1?Q?hEzNHVyKKKDPJz7B71fPJt+6+C6u2WBZ3s7ix2bedldPuJaEnlvGyv4Gy3?=
 =?iso-8859-1?Q?mW3xD9JW75X2Ri32?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b5c769-2a3d-4879-3898-08d945090d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 07:45:42.4168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YHXcAnPuu/OpAYx/iI7v6OTwevDz06d6SkDUGmRqSMp7SkUe2RYv+2ZTyJbBrC4nA2e+QG1Idqa3+/8SHJ7GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5701
X-Proofpoint-ORIG-GUID: 7ME8w4pwOtw9P-i7nlNxWxok2rmkVnpd
X-Proofpoint-GUID: 7ME8w4pwOtw9P-i7nlNxWxok2rmkVnpd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_04:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120061
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, July 11, 2021 12:26 PM
> To: Alexandru Ardelean <aardelean@deviqon.com>
> Cc: linux-iio <linux-iio@vger.kernel.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; pmeerw@pmeerw.net
> Subject: Re: [PATCH] iio: light: adjd_s311: convert to device-managed
> functions
>=20
> On Mon, 5 Jul 2021 09:38:21 +0300
> Alexandru Ardelean <aardelean@deviqon.com> wrote:
>=20
> > On Sat, 3 Jul 2021 at 20:47, Jonathan Cameron <jic23@kernel.org>
> wrote:
> > >
> > > On Mon, 28 Jun 2021 16:51:32 +0300
> > > Alexandru Ardelean <aardelean@deviqon.com> wrote:
> > >
> > > > This one is a little easier to convert to device-managed, now with
> the
> > > > devm_krealloc() function.
> > > >
> > > > The other iio_triggered_buffer_setup() and iio_device_register()
> can be
> > > > converted to their devm_ variants. And devm_krealloc() can be
> used to
> > > > (re)alloc the buffer. When the driver unloads, this will also be
> free'd.
> > > >
> > > > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> > > > ---
> > > >  drivers/iio/light/adjd_s311.c | 34 +++++--------------------------=
---
> > > >  1 file changed, 5 insertions(+), 29 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/light/adjd_s311.c
> b/drivers/iio/light/adjd_s311.c
> > > > index 17dac8d0e11d..19d60d6986a1 100644
> > > > --- a/drivers/iio/light/adjd_s311.c
> > > > +++ b/drivers/iio/light/adjd_s311.c
> > > > @@ -230,8 +230,8 @@ static int
> adjd_s311_update_scan_mode(struct iio_dev *indio_dev,
> > > >  {
> > > >       struct adjd_s311_data *data =3D iio_priv(indio_dev);
> > > >
> > > > -     kfree(data->buffer);
> > > > -     data->buffer =3D kmalloc(indio_dev->scan_bytes,
> GFP_KERNEL);
> > > > +     data->buffer =3D devm_krealloc(indio_dev->dev.parent, data-
> >buffer,
> > > > +                                  indio_dev->scan_bytes, GFP_KERNE=
L);
> > > I got some complaints about exactly this trick in a review recently
> so I'll
> > > pass them on.
> > >
> > > Whilst devm_krealloc() usage like this won't lose the original
> reference, its
> > > not what people expect from a realloc() case, so to not confuse
> people it is
> > > better to do a dance where you use a local variable, then only set
> data->buffer
> > > to it once we know the realloc succeeded.
> > >
> > > That avoids this looking like the anti-pattern it would be if that
> were a normal
> > > realloc in which case you would just have leaked the original
> allocation.
> > >
> > > More interestingly, why are we bothering with resizing the buffer
> dependent on what
> > > is enabled?  Can't we just allocate a 128 byte buffer and not bother
> changing it
> > > as we really aren't wasting that much space?  Just embed it in the
> adjd_s311_data
> > > structure directly and don't worry about the allocations.  Will need
> to be
> > > aligned(8) though to avoid the push_to_buffer_with_timestamp()
> issue.
> > > Using something like
> > >
> > > struct {
> > >         s16 chans[4];
> > >         s64 ts __aligned(8); /* I hate x86 32 bit */
> >
> > do you want to me t also add this comment? :p
> > [just kidding]
> >
> > > } scan;
> > >
> > > Inside the priv structure should work nicely.
> >
> > i agree; will do it like this;
> > i hesitated a bit due to the inertia of converting things to devm_
>=20
> A long discussion on rust usage in linux diverted into the issues around
> devm.
> I 'believe' that we are fine in IIO after some work Lars did a long time
> back
> to make us resilient to unbinds whilst the chardev was open, but
> probably
> worth keeping an eye on that discussion.
>=20
> https://urldefense.com/v3/__https://lore.kernel.org/ksummit/CANiq
> 72nkNrekzbxMci6vW02w=3DQ2L-
> SVTk_U4KN_LT8u_b=3DYPgw@mail.gmail.com/T/*m6db86a574237c22a3
> 2ecf49b596b3c2917967c5e__;Iw!!A3Ni8CS0y2Y!oeM8GJzKVXb8mYa1m
> VJNw5fI2adsFk3FKkFzbnqyuDkUMKVTKQ3OoT0cnXP5rA$
>=20
> I'm a tiny bit nervous that there might be races where we are doing
> the devm_realloc.
> I 'think' we are fine, but the 'think' and 'believe' in these statements
> expresses
> a slight lack of certainty!
>=20
> Jonathan
>=20

Hi,

It's the second thread where I see you mentioning this, so this I will take=
 the
opportunity to also give a bit on though about this. I actually have in min=
d a RFC
(hopefully sending it out this week) for this as I think we might still hav=
e some=20
issues with open chardevs and device unbinding.

What we have in [1] is not enough to make sure the whole thing is synchroni=
zed with
device unbinding... We still have the door open to races where we call 'iio=
_buffer_ready()'
or even 'rb->access->read()' after the device gets unbinded. Maybe we are l=
ucky and
nothing bad really happens and we just error out in the next time 'read()' =
is done on
our fd. However, during the possible race,  I think it's very likely that w=
e end up touching
the same data structures concurrently. On some devices, we surely
(in theory and if all the stars align) have a path where 'iio_buffer_flush_=
hwfifo()' might
be called with 'indio_dev->info' already set to NULL...

IMO, the only way to have this fully in sync is to use the 'info_exist_lock=
' as it's done
in [2]. I think [2] was actually "fixed" when Alex sent his patches for mul=
ti buffer support...
Naturally, for the read case, we need to make sure we are not going to slee=
p with the
mutex held so we might need an unlock -> lock dance which is not that nice.=
 But I'm
not really seeing another way. We also need to look at other file operation=
s and also
for the events case to see if this is also a thing.

Naturally, I might be missing some subtlety and that's why I had this plann=
ed as RFC.
But since is mentioned here, I thought I could bring this up as in the end =
I might not
even need to send the patches :)

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/iio/industriali=
o-buffer.c#L117
[2]: https://elixir.bootlin.com/linux/latest/source/drivers/iio/industriali=
o-core.c#L1763

- Nuno S=E1
