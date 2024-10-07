Return-Path: <linux-iio+bounces-10288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0820E9931BA
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3131C23634
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2AB1D9592;
	Mon,  7 Oct 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="sChPqv8v"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B81D6DB7;
	Mon,  7 Oct 2024 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315869; cv=fail; b=E6n1n6+RxjcIagFhTnVJR4V7dT7zz0srsTIwOzycjVPSN9j5fkVkG6bf1Gbq/eWsVo6dnaeIFo/4bmdJ1r5cZKmE4/zRuq1sGfXsrgIWjcZJd7/CJhwpuwBmXR+7nSDbg/M6oJT5TEB1wN5ESHxTIoHORDuLbweylGE2GVdrCVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315869; c=relaxed/simple;
	bh=vNNqd2PhbvrvblZkQbaIZGJIg6CmdJrWhy0FXGiB5zU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JwhCLZiQqlURaurwBH1++gK2y+7P4fJdpPXpqThDHAHqPn5JJCT3icmew8RL/a/PALmySXqo69ys2jZY4kuyxaMkWguYpU21YtwXK18Rz09N/iYpi4Q4oZgTjGHat9hFa/7jV0N8rMWf6z4P6OND/lIQ59WuKxEvx+iA4Sli8DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=sChPqv8v; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDoh7a0ItIbWyqwoAQdgwn21AllbT3p80g2oZylTiSN5PNydXLccNyJoDs3Fcw86xsAQxNZ/RsmOdGyssCECo7Z3p5vVl4JUUR186NnmN132y3WmBWVOvCCkPav+t3zmMreFPih9knUUqTEc5y1GVPBsbopLYNvUBypzcU+7X36y9GrashGJcvHYZLaoOH6lggL58XgjWnlwJWEZUcXoP20NQIk5DnmgNfRjQJI18TC5wQGY00l+Tinza3ihiKZ/vIdZyu9GWJGCnBV6/MySZncDEyniDl6/pg881IaJkQM6O2/NxWsPHmAlOfScGttS4KJPJR9wTWeTmwGJh5TRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGHrRUZ37h5pauHCXISGWp2X/8+kXZUgsMEPE2qRkqQ=;
 b=vko6w1gWiEKbkIwyJsNfvA0Sf+JPY4DEU4IylwlXKU+vfgbxlEFcMJPolpZN1Bx6w69W97pIbO/Ij6B8yUeKcwmOusvRy5NsH7zs99bad5qGFHNzzMCLf+pzZERPNtJVxUk2MQNtX5qnqM9DeV3I8WeVjCWO1s2sHolmSg/Ro6BzR+wiU4tey9zey2e2XbS94gRp4HTBNodIMWw1mNNrBl1/QeHNb46GLrTznyiPb7OWWZ2wlYXp/gZl7BdsMwlsc+Qx/FU59cpz19wKIAmWB1re3aGplQqy5p3HanSSMyZitOVSMk4m1VZgDdMeC3iqz9Dg8bxmoAHg3qgjxa/A/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGHrRUZ37h5pauHCXISGWp2X/8+kXZUgsMEPE2qRkqQ=;
 b=sChPqv8vL59/3w6Y/aE1rkoIXEHXjUjJuOVi8b4o1/QZvo9Rsg51cSQVYcEv+Rg+vV6Bh1IHhQFYgieruXg0oKEquyU7ENa5Ptf/U9x7NiofTxZpJxtHRe1q9jvlWqYioEE9POqJOmBti1BpUTZ7Ur+UcZyQng2Q6cSD8fbTRw8=
Received: from DUZPR01CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::11) by DU2PR07MB8320.eurprd07.prod.outlook.com
 (2603:10a6:10:27d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 15:44:19 +0000
Received: from DU6PEPF0000B620.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::a7) by DUZPR01CA0053.outlook.office365.com
 (2603:10a6:10:469::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 15:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000B620.mail.protection.outlook.com (10.167.8.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 15:44:18 +0000
Received: from n9w6sw14.localnet (192.168.54.124) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 7 Oct
 2024 17:44:18 +0200
From: Christian Eggers <ceggers@arri.de>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
	<alisa.roman@analog.com>, Peter Rosin <peda@axentia.se>, Paul Cercueil
	<paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>, Matteo Martelli
	<matteomartelli3@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mips@vger.kernel.org>, <linux-pm@vger.kernel.org>, Matteo Martelli
	<matteomartelli3@gmail.com>
Subject: Re: [PATCH v2 4/7] iio: as73211: copy/release available integration times to
 fix race
Date: Mon, 7 Oct 2024 17:44:17 +0200
Message-ID: <2287601.vFx2qVVIhK@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20241007-iio-read-avail-release-v2-4-245002d5869e@gmail.com>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
 <20241007-iio-read-avail-release-v2-4-245002d5869e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B620:EE_|DU2PR07MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fc4fc3-690d-48f1-eddd-08dce6e6e819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?YyIS0BlTLLSOEAmar+4e15fD/GRzdFyuNUGOyhlIf9R2DSGdSwr6bNVjLp?=
 =?iso-8859-1?Q?vdxhSh+MAuWcz+MJ0UP5p7Jto52i0kEAHl2aBUMtImNTC95tUfIjGktSzD?=
 =?iso-8859-1?Q?YUf4oVhzRzBWnDXK01/40c18tXte8crXn8LC7sDZgWOcb1UswxSP8+x3SN?=
 =?iso-8859-1?Q?x/o4f5T7X8hE4fgAbi9gISbu+NHv8f5PpfWQETmrNHPYDObj4eP10Y6Qvz?=
 =?iso-8859-1?Q?W2bLrJaVBadCp6MbOA2mf7p1DETXAb/acDs6G149Tg+TnCC/M8/G9bXLdR?=
 =?iso-8859-1?Q?r6YeBHiJMnzcd0ntr7FQjSphYXGfLauKsG3VMv3nCuOivtq5Q3uw5IPgI4?=
 =?iso-8859-1?Q?IkKpgHJsMTrzKgOnoTEVLZAOYKuGpCgKGDJjC9yEu4FKsIvjidcjbJ2Agk?=
 =?iso-8859-1?Q?TQlebAIyL+8SlE1rbEeWYPT7vH7YZj6sJOanPiSW4jtYroRnWA1iXH3q5c?=
 =?iso-8859-1?Q?ij4gqCmgGGJ6S2GP1f5axhkkRcK2LRP30cMjNozqb1od3nkPDEiQ70qlmW?=
 =?iso-8859-1?Q?bje6QGsLyHh+vhXLAqCq4b5s0Qc1bArK5HMvTD16cLgwM6BHRPpzvg/M+J?=
 =?iso-8859-1?Q?bCx9GFkF6dVhV6VhMQq5piCFXcFfwef2jbTCZEMR31ofh9YNm+GpM4rO0Q?=
 =?iso-8859-1?Q?G2jcKgc68t4Yv+6Cz6G0Ow+99uJmZMKR65t/F3ekct+U7fcIiCpT0+tELH?=
 =?iso-8859-1?Q?391+JC7AbHNywaHlCAam1w7vCV0yRMUPlQXpb0BuZgwVgcHgSUXOQsM+Hw?=
 =?iso-8859-1?Q?4OnUJ5RFwgAG14/oXQabDFcA2jgCHX0rt3Rr+U1wphT77YZhn/Fqqd3BKI?=
 =?iso-8859-1?Q?C2iJe8Dvw+bc6rmCzcWnqSJJzpZYuQYnDkV+Ny61ZcOQoRsJ3WL60JZW8S?=
 =?iso-8859-1?Q?FO0Y4r33nAyPTdrCC4b3vKq83VhGNyDdAXZ+42uMt7bpW34WKdZO/xiRsq?=
 =?iso-8859-1?Q?fXEhlgO1FX+hc12m3z9//Be/+SBGmwicb/WUgj3CzORBYxrjJOcO5WR+uA?=
 =?iso-8859-1?Q?Pz4EUA/1BW0AMf01qwFM5lHARk+wDvnvQEk/qZf9DdJFbZkznz/Cq8oH5F?=
 =?iso-8859-1?Q?0Gqp/8rgF1Fwt00sru+GdEjBmKMKcPonH1L5PI8fAh1Dbn/c55J+Qp+FE7?=
 =?iso-8859-1?Q?jLEI7pfV+wkjG1MnkF3moqzlmGG8meAaAnvewE6gthk1RmmJFxf+SdwaBW?=
 =?iso-8859-1?Q?3WeeRKsl7R4e8V78idITdRHxWezlCLDOxGw+i9wNEgiRPiBrgp0tWXtCp0?=
 =?iso-8859-1?Q?9tZpf4bA87GV6Q36ehdaYqXZZF13OIyepnvMeaPIYd36uMuhzUOF2LaPik?=
 =?iso-8859-1?Q?ugq9LH80ByvWgT/kWPSDgBOzXbWeT4GHF3RIBafwQc86KNfxof+Nsq8irK?=
 =?iso-8859-1?Q?KSRmNXSTDU4HXVZmFZ2T6+dZJYNY2U7FCdc4+izQXnDmi9vHNqx0CSaJLU?=
 =?iso-8859-1?Q?RCly/QHNMF/Hf2DI?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:44:18.9866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fc4fc3-690d-48f1-eddd-08dce6e6e819
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8320

Hi Matteo,

originally the `mutex` member of `struct as73211_data` was only intended for
protecting the cached device registers. So can you please update the
documentation of this member?

I can perform some testing f=FCr as73211, but I would like to wait until
the "copy data twice" question has been solved. IMHO a solution like Nuno
proposed may be easier to understand.

regards,
Christian

On Monday, 7 October 2024, 10:37:13 CEST, Matteo Martelli wrote:
> While available integration times are being printed to sysfs by iio core
> (iio_read_channel_info_avail), the sampling frequency might be changed.
> This could cause the buffer shared with iio core to be corrupted. To
> prevent it, make a copy of the integration times buffer and free it in
> the read_avail_release_resource callback.
>=20
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
>  drivers/iio/light/as73211.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index be0068081ebbbb37fdfb252b67a77b302ff725f6..27bc8cb791039944662a74fc7=
2f09e2c3642cfa6 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -493,17 +493,32 @@ static int as73211_read_avail(struct iio_dev *indio=
_dev, struct iio_chan_spec co
>  		*type =3D IIO_VAL_INT;
>  		return IIO_AVAIL_LIST;
> =20
> -	case IIO_CHAN_INFO_INT_TIME:
> +	case IIO_CHAN_INFO_INT_TIME: {
>  		*length =3D ARRAY_SIZE(data->int_time_avail);
> -		*vals =3D data->int_time_avail;
>  		*type =3D IIO_VAL_INT_PLUS_MICRO;
> -		return IIO_AVAIL_LIST;
> =20
> +		guard(mutex)(&data->mutex);
> +
> +		*vals =3D kmemdup_array(data->int_time_avail, *length,
> +				      sizeof(int), GFP_KERNEL);
> +		if (!*vals)
> +			return -ENOMEM;
> +
> +		return IIO_AVAIL_LIST;
> +	}
>  	default:
>  		return -EINVAL;
>  	}
>  }
> =20
> +static void as73211_read_avail_release_res(struct iio_dev *indio_dev,
> +					   struct iio_chan_spec const *chan,
> +					   const int *vals, long mask)
> +{
> +	if (mask =3D=3D IIO_CHAN_INFO_INT_TIME)
> +		kfree(vals);
> +}
> +
>  static int _as73211_write_raw(struct iio_dev *indio_dev,
>  			       struct iio_chan_spec const *chan __always_unused,
>  			       int val, int val2, long mask)
> @@ -699,6 +714,7 @@ static irqreturn_t as73211_trigger_handler(int irq __=
always_unused, void *p)
>  static const struct iio_info as73211_info =3D {
>  	.read_raw =3D as73211_read_raw,
>  	.read_avail =3D as73211_read_avail,
> +	.read_avail_release_resource =3D as73211_read_avail_release_res,
>  	.write_raw =3D as73211_write_raw,
>  };
> =20
>=20
>=20





