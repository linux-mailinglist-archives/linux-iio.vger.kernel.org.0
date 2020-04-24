Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855101B6F6C
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgDXHvX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 03:51:23 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:48176 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgDXHvX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 03:51:23 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O7jXWF024746;
        Fri, 24 Apr 2020 03:51:07 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 30fx68kgpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 03:51:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOGr3z29WWcomf8JBUUlRuNtj68fzdGbvuCNxroLYkDMat3DfKVX8IisKMPB7+pVG2EmeyRoORc5JF8atUZzOxP3srYTwPCejXu9vQDA2CfjKVICjPBMwDsWqnOKv1HJDgXTG8vCF9vB8yFTX7RPlD1cTp25jVyMDpz8N2DaaaicuY8SlSMUUjbVSTq1Ziaqca4lA+OzKQ4F5Lky2lgmdmivvkp79Vk8lvKPoLT+18k6GQBdTY4uAZJOrW3Ca7oJ/oCge2h7y8Z3V/i/2lszZnY8lsBNLr766cne28z0j68NVY73HQFnb8asAhy6rP59pjf2q/SJw2YRFdxSYyP74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt1VepY6xNTbjP9y1s8gwqYPzbw7neBD4fE3dGkA76M=;
 b=gXPGrwYL2jX43rFmc4yLRgVzoOdCe4Yr9AGVB+c8NOQT19juFO6OX+adMtdalbjxuVA71rkq08OxXGGliUnwpjKj35ertJjFlT2DV6Lk3XO7cRzxX2ZCJrPsB3lggsB5NlwvrEXhcAwekh/Lgu9gpk5RSSkd0/wSpImFC3SrhWiJ1/IeRC81QwDfn3uF/4/IlP2t73Liz+EXAFV6/X8JcjRJUkyvh/IGIYnh5ZJwwVoX7Z4+PDim3gZjGVDST5utN/bfjhVK7/FZF4OBLFEro9DnpSgl1wQPT+RSQx2mFSW6ccHnp0Zt+/yohPuGsN1Jag9FnVswHDoJ7Z5/wpqLKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt1VepY6xNTbjP9y1s8gwqYPzbw7neBD4fE3dGkA76M=;
 b=dIFEAm2lo3SJ0dfqOVlpt8gB3urxCWkamh+tYrzupTX2sncHL+YJVWEFAOUV2iUykqXm0Ark/JzVrgpvTF+8316u437VZyIUIdZHOpgtj5yGJOhey4BQLSmcAtauDuVUfygE72Fd2JBLlmpmssIPo+0FClTicmaAx/jxnsrYA/c=
Received: from CY4PR03MB3350.namprd03.prod.outlook.com (2603:10b6:910:55::24)
 by CY4PR03MB2485.namprd03.prod.outlook.com (2603:10b6:903:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 07:51:06 +0000
Received: from CY4PR03MB3350.namprd03.prod.outlook.com
 ([fe80::e483:8557:31ac:d59b]) by CY4PR03MB3350.namprd03.prod.outlook.com
 ([fe80::e483:8557:31ac:d59b%4]) with mapi id 15.20.2921.027; Fri, 24 Apr 2020
 07:51:06 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: RE: [RFC PATCH 4/4] iio: Track enabled channels on a per channel
 basis
Thread-Topic: [RFC PATCH 4/4] iio: Track enabled channels on a per channel
 basis
Thread-Index: AQHWGffHKP4cv1C0/ES0EynNzW/LxqiH4ogg
Date:   Fri, 24 Apr 2020 07:51:05 +0000
Message-ID: <CY4PR03MB33506FD8C2BF3921FE9BA2DD99D00@CY4PR03MB3350.namprd03.prod.outlook.com>
References: <20200424051818.6408-1-alexandru.ardelean@analog.com>
 <20200424051818.6408-5-alexandru.ardelean@analog.com>
In-Reply-To: <20200424051818.6408-5-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNTczYWZiMWUtODYwMC0xMWVhLThhNTItZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDU3M2FmYjFmLTg2MDAtMTFlYS04YTUyLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iNDM0NSIgdD0iMTMyMzIxODgyNj?=
 =?iso-8859-1?Q?U3ODEzMDc2IiBoPSJrbWsyUHZZNm8vN3E5bXN1NUV6MHhPOENielE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJVY3RRYkRScldBVkVxNDQ0dkd5ZVVVU3Jqamk4Yko1UURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQTV1R0RXQUFBQUFBQUFBQUFBQUFBQUo0?=
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
x-originating-ip: [2001:a61:24cc:eb01:701a:32:5e81:fad2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5101931-f7a8-4f1f-c6f5-08d7e8243e75
x-ms-traffictypediagnostic: CY4PR03MB2485:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB24854DEB374ABCFAC1999ABF99D00@CY4PR03MB2485.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3350.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(39860400002)(136003)(366004)(9686003)(55016002)(54906003)(6506007)(53546011)(8936002)(8676002)(33656002)(7696005)(81156014)(110136005)(2906002)(5660300002)(316002)(186003)(71200400001)(478600001)(76116006)(66476007)(66446008)(64756008)(52536014)(107886003)(4326008)(66556008)(66946007)(86362001)(309714004);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +l0rhOmAPXNtcFNwO6p0DSDwnGGxXokTvKbbhc5W+dReNjE3C4BWnwIrz4kLn74SUbNGkpxEO7pa/16GUZg+pje3PuxFt4BjvUC+OBxBWGZp4yUkK9QX9bjmc1UwFvGJIiCxSMozZQqoDkzu+SjSl3ony0dVLJk+TmbvfblDXBML0qV89ZBd/aCvATLxC/A3M5oDLNBhWIUqC1H4NGpTUXTaYLXMzEt0P6t9rZkq4ih6rgugi3wL/bcF2SwzmIoSzrVYMsZrMCEDalfFmA9RRS2STwVL4i+oPJgY712kDYMVgvtnPKu5BCe74Gpf3BHdrtG2p23evi1JGsH+KG3OYAQmdivmaWlzfg9D4G5VeaOoVWVgPE2BaVExPyQAsOO/zor+t6lwsuZpSPtTuUXY74OwkButof4Svl0Jp1i10Sv1l0/ar2xlE94A4JQWcUOHj9nWWLKnBaQu7dsYEFkLUe3rUSB98EniPyrraZlsMnG9wUTNnGqK+ObMrog0IbbP
x-ms-exchange-antispam-messagedata: Q4l1Wjr7RlB89f2topqkwkjVs7MDxXOOpKo2B+6GzFlC8XIhvajoxGzHGC4BXS/uIfvDwfnWy37Ni7w26QNeiNGTVOZH8s7CuiFLFNe6V2hQyg8FQc5uPkCqq51/+S8OPCNgXhnXN6JJ3PKqNTEhTX9crxBzyNiXbLrWWQDT7+n0LF25tMeuzKr9InFCfYv/0gsQqlURO1BQmwS7vBnSjQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5101931-f7a8-4f1f-c6f5-08d7e8243e75
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 07:51:05.8558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eN7Hg32RWwy/MMutyjlgI/xx7XTH1Boi9lIeXvqhsCjbtzH0DVtzBcD4Mv6soFAl8U5Qr87Pr24mmvckK2LRnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_02:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240059
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>
> On Behalf Of Alexandru Ardelean
> Sent: Freitag, 24. April 2020 07:18
> To: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: jic23@kernel.org; lars@metafoo.de; Ardelean, Alexandru
> <alexandru.Ardelean@analog.com>
> Subject: [RFC PATCH 4/4] iio: Track enabled channels on a per channel bas=
is
>=20
> From: Lars-Peter Clausen <lars@metafoo.de>
>=20
> Now that we support multiple channels with the same scan index we can no
> longer use the scan mask to track which channels have been enabled.
> Otherwise it is not possible to enable channels with the same scan index
> independently.
>=20
> Introduce a new channel mask which is used instead of the scan mask to
> track which channels are enabled. Whenever the channel mask is changed a
> new scan mask is computed based on it.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-buffer.c | 62 +++++++++++++++++++++----------
>  drivers/iio/inkern.c              | 19 +++++++++-
>  include/linux/iio/buffer_impl.h   |  3 ++
>  include/linux/iio/consumer.h      |  2 +
>  4 files changed, 64 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-buffer.c
> index c06691281287..1821a3e32fb3 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -216,12 +216,20 @@ int iio_buffer_alloc_scanmask(struct iio_buffer
> *buffer,
>  	if (buffer->scan_mask =3D=3D NULL)
>  		return -ENOMEM;
>=20
> +	buffer->channel_mask =3D bitmap_zalloc(indio_dev->num_channels,
> +					     GFP_KERNEL);
> +	if (buffer->channel_mask =3D=3D NULL) {
> +		bitmap_free(buffer->scan_mask);
> +		return -ENOMEM;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iio_buffer_alloc_scanmask);
>=20
>  void iio_buffer_free_scanmask(struct iio_buffer *buffer)
>  {
> +	bitmap_free(buffer->channel_mask);
>  	bitmap_free(buffer->scan_mask);
>  }
>  EXPORT_SYMBOL_GPL(iio_buffer_free_scanmask);
> @@ -285,7 +293,7 @@ static ssize_t iio_scan_el_show(struct device *dev,
>=20
>  	/* Ensure ret is 0 or 1. */
>  	ret =3D !!test_bit(to_iio_dev_attr(attr)->address,
> -		       indio_dev->buffer->scan_mask);
> +		       indio_dev->buffer->channel_mask);
>=20
>  	return sprintf(buf, "%d\n", ret);
>  }
> @@ -330,11 +338,12 @@ static bool iio_validate_scan_mask(struct iio_dev
> *indio_dev,
>   * buffers might request, hence this code only verifies that the
>   * individual buffers request is plausible.
>   */
> -static int iio_scan_mask_set(struct iio_dev *indio_dev,
> -		      struct iio_buffer *buffer, int bit)
> +static int iio_channel_mask_set(struct iio_dev *indio_dev,
> +				struct iio_buffer *buffer, int bit)
>  {
>  	const unsigned long *mask;
>  	unsigned long *trialmask;
> +	unsigned int ch;
>=20
>  	trialmask =3D bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
>  	if (trialmask =3D=3D NULL)
> @@ -343,8 +352,11 @@ static int iio_scan_mask_set(struct iio_dev
> *indio_dev,
>  		WARN(1, "Trying to set scanmask prior to registering
> buffer\n");
>  		goto err_invalid_mask;
>  	}
> -	bitmap_copy(trialmask, buffer->scan_mask, indio_dev-
> >masklength);
> -	set_bit(bit, trialmask);
> +
> +	set_bit(bit, buffer->channel_mask);
> +
> +	for_each_set_bit(ch, buffer->channel_mask, indio_dev-
> >num_channels)
> +		set_bit(indio_dev->channels[ch].scan_index, trialmask);

So, here if the channels all have the same scan_index, we will end up with =
a scan_mask which is
different that channel_mask, right? I saw that in our internal driver's we =
then just access the
channel_mask field directly to know what pieces/channels do we need to enab=
le prior to
buffering, which implies including buffer_impl.h.

So, for me it would make sense to compute scan_mask so that it will be the =
same as channel_mask
(hmm but that would be a problem when computing the buffer size...) and dri=
vers can correctly use
` validate_scan_mask ()` cb. Alternatively, we need to expose channel_mask =
either on a new cb or
change the ` validate_scan_mask ()` footprint.=20

- Nuno S=E1
