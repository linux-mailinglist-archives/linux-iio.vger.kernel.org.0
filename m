Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F8043944B
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 12:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhJYK6f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Oct 2021 06:58:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5984 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231829AbhJYK6f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2021 06:58:35 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19OLenXE029323;
        Mon, 25 Oct 2021 06:55:52 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bwcgcjuts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 06:55:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOX5ZxgAoytYl+ub6m5bufjkSsDlmJqPzCXMABpTT7Dc3euc2Goez+kZI809ZBUlDwLlYwA2RN+M9g2tcxCWBeqOjHl1vl1qEf1DLzfO9iHyVl/lqf9iYTd9liNRszmzO4yFzVY/4+HpFxg+GQ+nMEWLIP53Xvx/wY4XvSPLpCwWfRiy9DxFzmx/CbAExRAdc8GJtS5D9tU+cPM7vLSBE8agEj325F5Vb/JbJ3jUYucOk6ACAib+q9TbTAj1vpzFgFNzX4/FvSUPaZ3ch2TYlXTno6DZBIlKDTrcQyK5NI4QHfzFXlICrFOm9R3CShkY9gjRt5MAK1/X9dDFAs34Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sek/qhdy2xUFtDppEWhC0x4kCoNLHERNE4BGqarGLVY=;
 b=MzIV8NcW3Z+GU2S1eRPcQwB03kmRZY10ouTOxAwv1gB3FPY6GfoWcQ8V1HhhGExXZPR/+KxHzva4wt9MnZ5jRAZAA2QPBfeAzds4M6AWJzoZKqeuu3SpRiv/nJ1rZvzBdaGT/LK8eGqBkqFdPKSBzDL3IfcrXN61dY+HioypkADRDdJmtJpiIbLyngFRyyZsf1TfPksiesdqtRKvlyVk/+zkzLsCrtM8P8esfrPWIgO+AnPct6Yp8iihmSfbjISozf/+d9MyCAUw3MQW8pMslOH3jIk71IfdEOzkZp5FzaHnMgZ4fjZr1PlyylqZA0mPi+nR+Vki+PQFzfGEUYst5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sek/qhdy2xUFtDppEWhC0x4kCoNLHERNE4BGqarGLVY=;
 b=xaXpRKqKzxA0xmb+c5AROWqSK4VSvvoyLCFzLi9rKC4AXnDSGEAKsqyUU9eidwnTJRgla9NWzvN6pwmHRV7OLtekhQm91Oh/EXoC43qbR2PD4ZltvNd+wH7RCd/Y/UyKtO3dJRjzcnmcHzNJrghq7Gu+EQjcQYzzCX9qqw0nAYs=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5781.namprd03.prod.outlook.com (2603:10b6:510:32::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 10:55:50 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73%7]) with mapi id 15.20.4628.018; Mon, 25 Oct 2021
 10:55:50 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Martin Fuzzey <mfuzzey@parkeon.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: trigger: Fix reference counting
Thread-Topic: [PATCH 2/2] iio: trigger: Fix reference counting
Thread-Index: AQHXyLlgGI73fsNWc0yc3c412zhae6vji+Wg
Date:   Mon, 25 Oct 2021 10:55:50 +0000
Message-ID: <PH0PR03MB636676B8D42B59300751FA6C99839@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211024092700.6844-1-lars@metafoo.de>
 <20211024092700.6844-2-lars@metafoo.de>
In-Reply-To: <20211024092700.6844-2-lars@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMWIyNzUxNmItMzU4Mi0xMWVjLThiOTMtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDFiMjc1MTZkLTM1ODItMTFlYy04YjkzLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMjcwMSIgdD0iMTMyNzk2MzI5ND?=
 =?iso-8859-1?Q?Y5MzgxNTI1IiBoPSJ2RUpIcGFuTlpKZ2lLL1FuUjRITkE2cVhRUnc9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUNWaTMvZGpzblhBU1FrR2FEMTFrKy9KQ1Fab1BYV1Q3OERBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
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
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa9b0401-2f43-4719-8e97-08d997a60224
x-ms-traffictypediagnostic: PH0PR03MB5781:
x-microsoft-antispam-prvs: <PH0PR03MB5781EF4F2AF7B3F04CC71C6499839@PH0PR03MB5781.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1/DA1PKuGugS8vjOW4CRJPAKV3JnoS4qXPweiyGRsPRVMod34frhXRAZAT2KFjQseYl/lviRQWj+9a6RQaDFWHSZaLGs9egs/kmCd6Eze8MDIwmKjhRb+/8f+rHPXHQV+8M9DaXryYXaPj8yGOKn2rM11N6I29h1pqk/X0A9iQT7fNBjcqCWlPby90AHIwaTgv1u/CwUcwUfbT3PDYJQ+fTPfzdHGefnElwG+LeZpLSXFvlRbtO/7y8eWyNZhIlhb3APqf1GE8FWS2Q+nX5RsbOv4mEv0i2cpCJEHmSm6/QtjF+4DzHtBp5vK3DmltVRXaDOp3kW5xeJoXvW4RAl90lX+9JeaMay/zibXJgkwHQjYqteWV/94wFkNcjzbyr8wGtLqjZfUSKY5BAKOcxp2ZubgPNKa7ildUSitMfXWZa2bJaf5wHXdIiPqzHbu3M/wx5+LraAJrwFaD0eDvPG3nzivr6UA5Xd/oqebCFOZkM/PLldYKzK2hOGzEQ9Z0xrgSiLqWcVIYnfd++SuRgmpbVtAxhfu5H6tEgWdjfieUpmxbKihBotLOT9+Qf6+linnaPRUxsS4uAArgvOuoZ6Y+e2koqLkiIo8zghLFd87Mz3HLSF/26wCimaAVhmQu7HN/DPkQW14jMe6xMHlj08b4zey1ixSQ2sWE9Ea7oJXqhCYqtkELa9FNv0aVbCCYgXD4jHGNX3UIZ3eycxaB2MNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(122000001)(86362001)(110136005)(9686003)(8676002)(54906003)(52536014)(8936002)(508600001)(83380400001)(66476007)(316002)(55016002)(7696005)(26005)(5660300002)(2906002)(66946007)(64756008)(33656002)(186003)(71200400001)(4326008)(38070700005)(6506007)(53546011)(66556008)(66446008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?B1ewXa6eOA76BOzGhEnrhcaGIwE5d3mPeJ1lxiu1uJCPxqASS3kRACDltx?=
 =?iso-8859-1?Q?4DaySpWzFHVyg09ROI6mC2ebnaqiqEpNznxuRvAmoK2NWF00javs5emJvN?=
 =?iso-8859-1?Q?Xf5pIn72f8P9YcrNKDPDAwsWyII7EY83S3F9+q8j8NFCdO3G/fUP6LqXO0?=
 =?iso-8859-1?Q?t6WBqE9KjzUZcKfLfVZJzTYZYE9dvjocRuFXYAusfj94/B0tESVF98ZOLr?=
 =?iso-8859-1?Q?AolBYSkS5h+NEiUolyIWdvBrA6LdLUOdVRa1rDpgSmzDrd3l+vTu9kJvCl?=
 =?iso-8859-1?Q?HTQTkIanJ9kHxgCugtkdMbER1GrJ8MCbvTWkD6ZMnTDJAEN/MJ4oYw2jty?=
 =?iso-8859-1?Q?2yeTgwOojChgyC8pmz4uDA3k3mVEmKbrkVi0SIAz8WO5mVjkZDPxhcdobQ?=
 =?iso-8859-1?Q?dy/IIv9g/kMGqgxt7iIXPW0OZVP2eQU0UKoDmW6D/lUxxLhTBCLOhCjRGd?=
 =?iso-8859-1?Q?8hNAFE2XQNslapamwF57ewotogpoegZQsl6e2z2bNWdTOXfHDrpAH+xx6x?=
 =?iso-8859-1?Q?/xggv0WJMrtQCDTXOnd4cqCso3ML6vcQIH+QuLteTGBSWKt3g+b2Ao/zQY?=
 =?iso-8859-1?Q?M4XpicOk6W9m/r++pxMaHr0AoPWUedod3aawd+1PqBK5YMSoYn6wZpDvCp?=
 =?iso-8859-1?Q?GOHWU2DopbA5zZxzdzTJZHa5RIPgtoEsnoYil6u4jxYlFoA/OHDAOAF6dY?=
 =?iso-8859-1?Q?2AslbmhlOWqNCvrj3jyaxCdL5T8TonCIb4F0wIvqxGUYsQsaZXtfBUsj8L?=
 =?iso-8859-1?Q?wdv9I9U02+kOMlj/N9+EUg0HRmL6sZxSPEzqx/gQ+6hinrZkjEnXlinARc?=
 =?iso-8859-1?Q?xzF0YrBrTr7HIv5xvTy9goRSpp/3XnIDeAxTsMTxrnBa8xtKPctxT1cePd?=
 =?iso-8859-1?Q?qoV96HuUVP98gfbPIp8eFR+5BkLAjlRnReq6Sb1lGlG4j02xKTw/ZNjQTr?=
 =?iso-8859-1?Q?5NqB5xOlI/Qyz6OPM0d6QyPBC7jgsx3DvmJTfrWKhoShtwfcBbRDtnS1r9?=
 =?iso-8859-1?Q?m02CBbdoAAh4B8vp+n5p5e5N2G888Yd6aR2yOV5GrsozIA/w/wR50mt+kN?=
 =?iso-8859-1?Q?d4y0omROKEKzGuZS9ET8pLJCG+kKqGRalj7QpsBwam/JvDQ2n7LknKKB1f?=
 =?iso-8859-1?Q?t1KpBOtv0lp/qW1MuWrUXsQhhELVRZUxIFQkHIdwLrB6A9iZ355PnebTX6?=
 =?iso-8859-1?Q?LA6QvJlNR1qaIiO34yqtjAUviyJX8KxysNUpzhKRvrqazaIZCdbQTgcAdZ?=
 =?iso-8859-1?Q?rzdiA1Z5D4YC7bSzR3oZI7ZWOb5CEKY8j7l1xICpVL9mLK0/fPVIomb77z?=
 =?iso-8859-1?Q?jK80FGYA14IGOAg8u8cyl8RfZ9fT5sxffSl56kmdhVbz6zqWkL+n9PbUrf?=
 =?iso-8859-1?Q?rUVH39oEmqObaf0T+g0XpMX4r754u9aUiFtjqOdCYungPxG1AuW7HajX6X?=
 =?iso-8859-1?Q?+7zjEyX/NgSW6uJxhaLhh8B/kgveon+dBH8yz3AqB2ryz8mq2PDn3O22ql?=
 =?iso-8859-1?Q?DqpJjDAjhdy5HKou94m0PpafDqdvC/rN4tfgioiOPazoT5qBWs0NjlV3NF?=
 =?iso-8859-1?Q?x+QPQKQ72ZQ3dkr4hd9L26QVh95j1nuyVkmYP5jAYrRslU6IpGNN+GwJKL?=
 =?iso-8859-1?Q?p5/l49ZKyq/oCNxCXDHqBLx22/0lGH0hfIhgomlU+FHZc1WOAuzUZ0lw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9b0401-2f43-4719-8e97-08d997a60224
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 10:55:50.4358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WIkr/c/1fzUoAaNbH0Tchyr26788SuDdRM9Zw7/Cdsjf7NV6NYrtqf7P7PD+WZjPgNWYX0B/Jzz5Qh2ELnTx5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5781
X-Proofpoint-ORIG-GUID: wrTooHdJUDGzgEqdMJ6_q8_rtbGSQGm9
X-Proofpoint-GUID: wrTooHdJUDGzgEqdMJ6_q8_rtbGSQGm9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_04,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110250068
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Lars-Peter Clausen <lars@metafoo.de>
> Sent: Sunday, October 24, 2021 11:27 AM
> To: Jonathan Cameron <jic23@kernel.org>
> Cc: Martin Fuzzey <mfuzzey@parkeon.com>; Peter Meerwald-Stadler
> <pmeerw@pmeerw.net>; linux-iio@vger.kernel.org; Lars-Peter
> Clausen <lars@metafoo.de>
> Subject: [PATCH 2/2] iio: trigger: Fix reference counting
>=20
> [External]
>=20
> In viio_trigger_alloc() device_initialize() is used to set the initial
> reference count of the trigger to 1. Then another get_device() is called
> on
> trigger. This sets the reference count to 2 before the trigger is
> returned.
>=20
> iio_trigger_free(), which is the matching API to viio_trigger_alloc(),
> calls put_device() which decreases the reference count by 1. But the
> second
> reference count acquired in viio_trigger_alloc() is never dropped.
>=20
> As a result the iio_trigger_release() function is never called and the
> memory associated with the trigger is never freed.
>=20
> Since there is no reason for the trigger to start its lifetime with two
> reference counts just remove the extra get_device() in
> viio_trigger_alloc().
>=20
> Fixes: 5f9c035cae18 ("staging:iio:triggers. Add a reference get to the
> core for triggers.")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Nuno S=E1 <nuno.sa@analog.com>

> ---
> I'm a bit unsure about the fixes tag. I've looked at the IIO tree at the
> point when this was introduced and I believe it was incorrect even
> back
> then.
>=20
> But we also had a few drivers that directly assigned the indio_dev->trig
> without getting an extra reference. So these two bugs, one in the
> core, one
> in the drivers sort of even out. Except that iio_trigger_get() also gets =
a
> reference to the drivers module and iio_trigger_put() releases it again.
> So
> with the missing iio_trigger_get() there is still the problem that, even
> though the device references balance out, there is a module reference
> count
> imbalance.
> ---
>  drivers/iio/industrialio-trigger.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-
> trigger.c
> index b23caa2f2aa1..93990ff1dfe3 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -556,7 +556,6 @@ struct iio_trigger *viio_trigger_alloc(struct
> device *parent,
>  		irq_modify_status(trig->subirq_base + i,
>  				  IRQ_NOREQUEST | IRQ_NOAUTOEN,
> IRQ_NOPROBE);
>  	}
> -	get_device(&trig->dev);
>=20
>  	return trig;
>=20
> --
> 2.20.1

