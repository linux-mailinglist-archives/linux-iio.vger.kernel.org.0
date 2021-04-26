Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40A236B0EF
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhDZJqG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 05:46:06 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6546 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232695AbhDZJqG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Apr 2021 05:46:06 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13Q9ee8M015418;
        Mon, 26 Apr 2021 05:45:11 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-00128a01.pphosted.com with ESMTP id 384d67n74s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 05:45:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3xjHUOr3UbFDQZXbaKoP7yjfL/QZI7HV79n5Y/4hHKntZBUtyrMcXSf/D85TDf8Hum2tHo6UUd0i27MXTYrsd/Y5V7EXm8fG17RoQpG2RaYqArJeyR9e8TXW94X3ppCf/TUbhC20InBFbzBhQ4jyYl1HqiWI1HhIlBKNB6qayubifvXjr2fxFF9RLQDfiSstAypytwufIPaYYO4Dt4AT+kM7UNPBdneZu6WuDlVtvt3Qdh1NDxks0GwNAusE4HZxN0WGRpOfn3Bgg4Qe9jZzW98CfUg6FOBXSDTzXyyMVYOeK8HuhA/Dy3A6LPAOM9EmZNHmOSv8BQXrBhLOzF5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//jgZXAzkFs6am/BNXmq+RI9M9827VcIISg6IBoKhC8=;
 b=BSy/wwirqXKQB8lweWM7RadBaqwdnZy+9IzWUMy1w0FWMEJe6DTq1+HVOCDlccc5wfL8VJFMQn0/a+XU/+ouWRVIWzXHFt955wzSW2pjYsRQzyaA2+0OSGFoM39PdAYChNPXBndKFSjlDKlbL2uyv+Ai9IE34VELY+HOXsKC+P7lV65tMQDHl7KyfnZ28lSegSYDhkXCTQPo/KP/3I171e6YB+D56mal4NmDlx6Fy6Jn91TKO3lJjsDM1WndQhbgeeleEP6uK8k/oGgb8CJKoWjhZn66izwcRKtDZv7sdHpMmGoNPUbWfknfMMHf0zN6xR43T7rfnTibftZ3ARfEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//jgZXAzkFs6am/BNXmq+RI9M9827VcIISg6IBoKhC8=;
 b=8ZB5/cFrRkh3mrSVGDSAs5gojEztNHOt9fffAcqUewDb2xulFRFakYLpJa+0GlhuHMi5JEIkTIY50AHLPU/Jt1MvdIn14awe5QDqkiD49E+gW8Qz+Rz+jxzl0oEFS/YcxEkDLiDD6G+4OGBx+en73DkQ8OPIFaGEyfD0w//QOws=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY4PR03MB2646.namprd03.prod.outlook.com (2603:10b6:903:76::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Mon, 26 Apr
 2021 09:45:08 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 09:45:08 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v2 3/9] iio: adis16475: do not return ints in irq handlers
Thread-Topic: [PATCH v2 3/9] iio: adis16475: do not return ints in irq
 handlers
Thread-Index: AQHXN2ClNYD5owPH60CtxnbyFe8cmqrBqJwAgAHcawCAAw25AA==
Date:   Mon, 26 Apr 2021 09:45:05 +0000
Message-ID: <CY4PR03MB3112F03C168D6903B84B40B299429@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210422101911.135630-1-nuno.sa@analog.com>
        <20210422101911.135630-4-nuno.sa@analog.com>
        <CA+U=Dsq0SYxfZ+k-CoKnYDk93LkV4xEpJDSoWjMvgDcmv8UhVA@mail.gmail.com>
 <20210424120636.15565c54@jic23-huawei>
In-Reply-To: <20210424120636.15565c54@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMTI3ZjZhOGMtYTY3NC0xMWViLThiNDEtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDEyN2Y2YThlLWE2NzQtMTFlYi04YjQxLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTQ3NiIgdD0iMTMyNjM5MDM5MD?=
 =?iso-8859-1?Q?MxODQ1NzAyIiBoPSJHemdzdE0wYTJIdUZGUkRNQTZpRkhNZmVuaEk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUJHbzlmVWdEclhBZVNzclZGU1NYSkI1S3l0VVZKSmNrRUZBQUFB?=
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
x-originating-ip: [2001:a61:2539:a901:900d:3ef0:a416:bbf9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b40c951f-cc47-46cb-f62a-08d90897fa3e
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB2646693E6C564566A2DBC21299429@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6/aEnl5q6egqNwAkiwzDfBeZvVAUiFDZKGjJj9dPhQJd4YvHEuLqtyb+0HVw7Z5ymaESvClH/kVK6flG7T1kPNR4pSyvmhsZqBJAVUvJsAe6P749H2QcvTVLemYmfXqP+8JfJc6r2sK1C87W5FeYRjHuNjjRy9mIBTzsLgzfW4Fwx3NH2hLqXFmX6d6AbmyyApZMEMmoU8CXeGAQGS3cnUfo9jn2Ko8cCD6jLTnBmwvHLAd73UK1KZtj2X8AODDUHbV0JAwP/7w9+micMZo8G/atPuXF1I6l2KWkamX8HUmHFRwwJ0DCK3ReSjNzghiNJ3EjSP/hhbO2RfBOAYqhzjjtDJF6VmiFk3P5jGRnbYtvhcOSBqSLFV4vPUbK7Ub94F1936tf4FvSt1jsAF6YyatPlCLUtoSN6fcSyf/SUKv9vPgOiniAfgF8w8xuveDbvcAqo8g+lDpdzvN8v4mGIE9ue/PHwwt/14BQHbHpOQKumJHXPXKOolX0xIfQkiUwH+kcEuEL1YRA6gXJhm3di5ke0g4otg10+LkJSzZD9QYd+eukRTOSVFi9DrLZ8TkWoEUnme3jhEJ47XrcYsEiNF3icZsTSGd0utQ/h91lAQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(186003)(4326008)(6666004)(6506007)(53546011)(478600001)(66946007)(66476007)(66446008)(71200400001)(83380400001)(33656002)(64756008)(7696005)(52536014)(8936002)(76116006)(316002)(8676002)(110136005)(2906002)(55016002)(122000001)(86362001)(5660300002)(9686003)(54906003)(38100700002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?WyFew6g6e5NAHMCq54J/7NQf1wqTfFdmskka3GPOSexJyI988Bw67W0VVw?=
 =?iso-8859-1?Q?7LoORZYBQXz5wSsO8WM62aoFa3/VrYa9g91IbLu6RF2lUQHZ7IZ9OwUcUn?=
 =?iso-8859-1?Q?1GRDyLB4Pbt5Z1M7XrRKe4Fg6aIFMSyOnYgX8M9T+D1oOAX9MvUkMCfxak?=
 =?iso-8859-1?Q?M3hrdRmw7kMAD9aSrZ1eCweGWkQx7sOLiDdc+g+m0c+Xh2LEonP+mv2Lv3?=
 =?iso-8859-1?Q?5wY1Y+9ciWLRWgVxC9UAfWCc4NZ2higy5g8wCeJ6QTrNU6eTdpU2D83e+Z?=
 =?iso-8859-1?Q?NLCW+j3gqb800r3vgmNaMB3eef+GhrCIjaSHRl7fK1k0uo6FN0Mr0Yagz4?=
 =?iso-8859-1?Q?AerluoI0nAhJewSNt48uXO3cDDinoAs41cJfx7IjCjlQAgfFVgtsNnFIN5?=
 =?iso-8859-1?Q?oHPriPNUjmJxHFTksW2KgsVZDM50EnbW/lIJ7xv+PogMmh0pH8JrN76JaR?=
 =?iso-8859-1?Q?2kmQnwqLMfhmQL2W4d8Yz145WkTEXt5T2XXEropCoLvXdHZYC+uBYjPYDc?=
 =?iso-8859-1?Q?tZFns/MafMprimjnDH5NjlXohNQb02JhJkp9HZDJQvHXAeVHQm2SdxpKhx?=
 =?iso-8859-1?Q?Y6che6OqcrZdyiDftxzA9qXu0e9tzzLLvR86o/8gi7XaKfzSiM89ucPOFk?=
 =?iso-8859-1?Q?ZcR31XoZGn7N+hXSvOFCtrhrPbda8z/3RlMuyPT4O2trTziN2Dqzwx8wsU?=
 =?iso-8859-1?Q?eH3BgxFWEFYYp6nlhXJK/BQMydDKVgdSKxxduZps41SlbU9cZB4aYeqtJ2?=
 =?iso-8859-1?Q?+qcHKaOW677fpqjBpiVHpLtdlv+uRmNyE+2/6WYnUbXvG5SpmHNNVi/YFT?=
 =?iso-8859-1?Q?6E2Ah98RcISAP7Z6CyY1fou57D6SflcmNEMAHsIStT1qYf7tBuQwruqOXs?=
 =?iso-8859-1?Q?qk7lbvA6TEb+odFGRE7JjXzBdgA3+nVln4QT1MMXPNpY+rUENtLUQtQO0t?=
 =?iso-8859-1?Q?8Tfr6UrkPB+0n8Qtb7zIqSLdwtuucLH4qGQru6OmX9vWYZqXl3fzjqDRdQ?=
 =?iso-8859-1?Q?Tqe4Uq+n11swmv1b16ZJffZEHQo5rZtysxXG8UUaTFEe6VpEIdRv9D3z46?=
 =?iso-8859-1?Q?5U63equ8lVrQfJ/0IEaYE2KCFXDi6653iuNXc7PSBYuh1ei2CgO/odmHnk?=
 =?iso-8859-1?Q?FAu9YAKuweCBNbqsT21pApXwHiqhRaK71o/vgIfqQXPck/InXOnVtJ7RyD?=
 =?iso-8859-1?Q?WDbKpZbco/NAisGSbQAvD3zLoOCFKmQe2VesEaKrQfOGVGmpRqQxgYDcPq?=
 =?iso-8859-1?Q?PAQX1lUszeXBFHgkSq04feO/MI3Mr0N3lzBUg8q5tZqyzW2bcXyaC7/aN6?=
 =?iso-8859-1?Q?IFZQp/vXYsAdpYikmB+Zj5DhRWKl/sc0d4VpdbbKnTIfV0Dfl193C+DpA3?=
 =?iso-8859-1?Q?6R8AdjrjVQwtJtGUgry8+MmOcyHJECYIjNcPN32H6lgB43I9CRjmRmzGc7?=
 =?iso-8859-1?Q?HvgHpbQbsBr+SqTX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40c951f-cc47-46cb-f62a-08d90897fa3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 09:45:07.8081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKKl+u9qF5CcQqvpwHaA0vFvqPITBr+aYrmE7MBk8EanovzBqw4Yuud+oVKPP0Fbc6B/IXfKrAr2H1e2Rmyd4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-Proofpoint-GUID: B6PnRPgWjdY1YP9TLp_lpUVTcvJq2BK3
X-Proofpoint-ORIG-GUID: B6PnRPgWjdY1YP9TLp_lpUVTcvJq2BK3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_03:2021-04-23,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104260071
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, April 24, 2021 1:07 PM
> To: Alexandru Ardelean <ardeleanalex@gmail.com>
> Cc: Sa, Nuno <Nuno.Sa@analog.com>; linux-iio <linux-
> iio@vger.kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>
> Subject: Re: [PATCH v2 3/9] iio: adis16475: do not return ints in irq
> handlers
>=20
> [External]
>=20
> On Fri, 23 Apr 2021 09:41:26 +0300
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
>=20
> > On Thu, Apr 22, 2021 at 1:17 PM Nuno Sa <nuno.sa@analog.com>
> wrote:
> > >
> > > On an IRQ handler we should return normal error codes as
> 'irqreturn_t'
> > > is expected.
> > >
> >
> > Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> >
> > > Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> Hi Nuno,
>=20
> This needs a more detailed commit message as it is simply changing
> the return code.  That goto does other stuff.
> Please add some more info and send a v3 with this + other patches
> I that build on it and hence I won't be able to apply.
>=20
> Whilst this one is a real bug, I'm not that fussed about backporting
> it quickly so will probably be fine to take this via togreg once the
> commit message gives enough detail.

Agreed...

- Nuno S=E1
