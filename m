Return-Path: <linux-iio+bounces-10759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 786159A4B7B
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 08:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC231C2205B
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 06:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A961D619D;
	Sat, 19 Oct 2024 06:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="k8YIcyZV"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F728EF;
	Sat, 19 Oct 2024 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729317978; cv=fail; b=BCEpirCeNNzyfScnOeNlcfJ15FomwypZqtxQMChMyDxf2QpHSMFHUWjRjzUsLtAEMoHNsN7hh61LKGEWzaFBB06VnhTilNQ42Uawb7pC9RzLGbgnQfdgu7b37pPNJPSamr8rHmghoME2IgUEjbjRiksghMuc46G5b0sgw7GksHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729317978; c=relaxed/simple;
	bh=Yx68Su07o2Z3sSp5kw2SrUMjs/g9ybcgS3CMI3nViUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pv6sS6BG454jIYkdpF1KFHwNquMPlPFxfZJa03pD5/SXJIcli6KLlOGh9M6T+dYRdlmUPnWT057BYLEwvvG8ULfyLSOed3S9CcUJ1rKSHr4neIOK9WKudHkz4oMJ/cMGPYh6g+G5/Gi8HBkv/NSVPosBcNJ8fEI5IFonBN5FqAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=k8YIcyZV; arc=fail smtp.client-ip=40.107.247.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbtTcY+9LxRSdSBekCuBFvzsVJHruOnBy2Wd63t9ayV0BTqojXjciTjYM6icdX+GBaDrmeWB0nuk6yPMM51dxiEQgsfpZYvNMbqq144r2E/gagtJlwCOALhCZTYUoxrp7buemek1xVwPKenP6BtyZv8wHXY+ArxUhMp9H4mYQjGuymGYaK8QyQQ+6T2L5OjQ7Wcb0gkMR6UgklUug11ETlDZ6z/SUdJnRNaaXXOrceJVVm0honqQVOFE2ksgR/kMfw9elVUoACtWyANh5UFzvH/VVc9FiMvJLS+M0pYX2UgbqbL7UN11UWqLoLLALb312SKQ0R5vY51N4VrR69cL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu+JDIvrVQ1ki2lRe1/jFW4LWmQMbP+wEb6hHVOMJJU=;
 b=PnEy6ZY90Yp+29d9uvTlwpGO5QBVRwedUEMJCy7P0nHq67eUnpbpwfvCX7swM52XKUNlB55dP0o6FW0h17WbO5R8mYBR/iNC7OcApm2pSU5bgcf2Quf4gXC8ZeXVLSs5shRHFesDWz2uQsmgkllKg3BhcN6u+O0cuAKYCJf2164fe8tMV+HdFU/rYAZcLtwWlrk/+3WEJepVW71hz4ftYlzZJ36foUR2nkaKLTPm+t32Jx8DWsRZTqRHIZzvII3e73RwIPqb+Uqi0wnkIFfhPhY1N1vq18urw6nBH9QAbcqIDwYjlGk6cUSG27Qd8MHKwW9YuYwgdQ5zZWV+Fv+l3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu+JDIvrVQ1ki2lRe1/jFW4LWmQMbP+wEb6hHVOMJJU=;
 b=k8YIcyZVE1WHnDQMCU1/5uyRJRaT4lTSvGN4AmlJwcoNy6P3vCdvEW/IIv7c3KqiciW3PIFbkk2JCswIpv/TiNcXTQbRydwR6kiMtMMIzcbQP1pYG837lpxxvSirIvbCMhboLFu2d6jsjMDnenNQCIgLFOTqIbnmsRzlLeNxI4Y=
Received: from AM0PR04CA0131.eurprd04.prod.outlook.com (2603:10a6:208:55::36)
 by DBBPR07MB7612.eurprd07.prod.outlook.com (2603:10a6:10:1e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Sat, 19 Oct
 2024 06:06:08 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:208:55:cafe::8a) by AM0PR04CA0131.outlook.office365.com
 (2603:10a6:208:55::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26 via Frontend
 Transport; Sat, 19 Oct 2024 06:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Sat, 19 Oct 2024 06:06:08 +0000
Received: from n9w6sw14.localnet (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 19 Oct
 2024 08:06:07 +0200
From: Christian Eggers <ceggers@arri.de>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
	<alisa.roman@analog.com>, Peter Rosin <peda@axentia.se>, Paul Cercueil
	<paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>, Matteo Martelli
	<matteomartelli3@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mips@vger.kernel.org>, <linux-pm@vger.kernel.org>, Matteo Martelli
	<matteomartelli3@gmail.com>
Subject: Re: [PATCH v4 5/5] iio: as73211: copy/release available integration times to
 fix race
Date: Sat, 19 Oct 2024 08:06:06 +0200
Message-ID: <2721272.vuYhMxLoTh@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20241018-iio-read-avail-release-v4-5-53c8ac618585@gmail.com>
References: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
 <20241018-iio-read-avail-release-v4-5-53c8ac618585@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019E:EE_|DBBPR07MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e0eb9a-352a-4005-ee83-08dcf0041fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KRbci8JN6rdGqzNpJI65wMwLI6QkxfU9ihdK0rHVtXMeS4haL0Zrgnyy77Si?=
 =?us-ascii?Q?yv/Cs5zjRgsCyDHY5+SG2uxSb16I2bhg9EsNvrjZYkzXHcofyvr+gdSgk+0k?=
 =?us-ascii?Q?RBPprAcTOe/QdC3ET4kkBYAacubliiuv3Cbkc8wYuyISALlxM8jgZ6qT1+8q?=
 =?us-ascii?Q?lFHloJUtFirSNz8rtuQuWbmCuAT8HJsPDTiLDiHeDxjWCHgUisq1zUQAtWC/?=
 =?us-ascii?Q?2x3UWSkLzqJp7CBTYkKTz3P/UuyB4xre11q2ByNWYJxub4qijV3SWh0nQyxH?=
 =?us-ascii?Q?GqwjQveG3JgGo89IGaxxb8B53eH9fCP8XSfH0QgKAjE5XGY1XSidf0zQQixy?=
 =?us-ascii?Q?b7FRI5bSEp5226MWEEzirgNsbxZcrtpAR92BfqsNoyMXauqz8z6CFoXVMM2b?=
 =?us-ascii?Q?GOnsaNkdvLytuRANK34MNjx+Gm9WUStPakGwbk7r84ypuSd4zQPw1h1ny807?=
 =?us-ascii?Q?/mn7LsVe5/KBVZv3wxdGXgmq7tOLMucFyJfCDJv+ulUikm3nI6mg7VgzWcAt?=
 =?us-ascii?Q?0qYKQWIU9+aiupRxkVJlIvzuqQ7mlQZu//MqHLYWtYLxhwmQadow90LPYdfy?=
 =?us-ascii?Q?vki+k3CO2IVO/9WMiIgfLHkekpxfQwIs8G0HKMux+4vxI4GQ5G0QZ06iYn9S?=
 =?us-ascii?Q?K4hP4iYOYRIV5+EpxrXlG3N8bzKRURSFt2eNhaQunuGY7/CSuFhGxjswjfxy?=
 =?us-ascii?Q?HGrP/oMECRcg3LzMm513xWTn0tn8ZQG5diq/0GEOwjXPCX5+KT8jeFjbC/Bd?=
 =?us-ascii?Q?6gpJ2A795Ir22VSMuSGYjOB3tJI+lTDTBAZ16Yrr8/XnbkZP1T++h9xtSCDp?=
 =?us-ascii?Q?Gf38nmuBQP4ccsFaRauzd+zq+o8vzSMeDPnHjZZ9zVICTviHVbYgPvnLD4a7?=
 =?us-ascii?Q?/Ge7EGKc2Sot93u5HWIgZ+wrb5U8/pPgcesq1ADhAtwtCcN1GpKZRgtg7QOa?=
 =?us-ascii?Q?/tKqUdiGAE4YZuSHJ6XKmiX79KuWn3z0j/8bJ3+4THINqJS5v7+KNg106c/3?=
 =?us-ascii?Q?NZELmdv+BM5nyRjYgwtmY6kvPxClOFZYQCz0P6GI9VNOK2mtrcCjldl0mH+c?=
 =?us-ascii?Q?nzi4uNCTOg3lXDA3mrO9b/8okt8ZoPyH/GAdYSsmSXWiQJ+awJKiNZRwHU3A?=
 =?us-ascii?Q?/RJNRzSXU1RBuO/81TEAbVMji9qw/id2CbiYl+nQ9lVqcJr9y8di3n5kVumP?=
 =?us-ascii?Q?kq6cpt+/aMPPfEcGZ6eSwP24OLB6T0GzNuMr/C6d3vFX71Qh8RvSP0B5wwxT?=
 =?us-ascii?Q?42MtpJ4EUTjlnWJc7x7W6hjxih6o4jQwwAhDQ81R9HlOrppse90y+xEuSfD5?=
 =?us-ascii?Q?IihjwUs72pBJGnK/cAnkEB0JxU3bXrrh9WMgz88QLNKyxJSJ9XASVfKj0cRJ?=
 =?us-ascii?Q?GvKx1J7Zs95xNTErEynVP2BYTIGgSgWHQxbPWSDmjgd46M9Iag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 06:06:08.2899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e0eb9a-352a-4005-ee83-08dcf0041fc5
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7612

On Friday, 18 October 2024, 12:16:44 CEST, Matteo Martelli wrote:
> While available integration times are being printed to sysfs by iio core
> (iio_read_channel_info_avail), the sampling frequency might be changed.
> This could cause the buffer shared with iio core to be corrupted. To
> prevent it, make a copy of the integration times buffer and free it in
> the read_avail_release_resource callback.
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
>  drivers/iio/light/as73211.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index be0068081ebbbb37fdfb252b67a77b302ff725f6..c4c94873e6a1cc926cfb724d906b07222773c43f 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -108,7 +108,8 @@ struct as73211_spec_dev_data {
>   * @creg1:  Cached Configuration Register 1.
>   * @creg2:  Cached Configuration Register 2.
>   * @creg3:  Cached Configuration Register 3.
> - * @mutex:  Keeps cached registers in sync with the device.
> + * @mutex:  Keeps cached registers in sync with the device and protects
> + *          int_time_avail concurrent access for updating and reading.
>   * @completion: Completion to wait for interrupt.
>   * @int_time_avail: Available integration times (depend on sampling frequency).
>   * @spec_dev: device-specific configuration.
> @@ -493,17 +494,32 @@ static int as73211_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec co
>  		*type = IIO_VAL_INT;
>  		return IIO_AVAIL_LIST;
>  
> -	case IIO_CHAN_INFO_INT_TIME:
> +	case IIO_CHAN_INFO_INT_TIME: {
>  		*length = ARRAY_SIZE(data->int_time_avail);
> -		*vals = data->int_time_avail;
>  		*type = IIO_VAL_INT_PLUS_MICRO;
> -		return IIO_AVAIL_LIST;
>  
> +		guard(mutex)(&data->mutex);
> +
> +		*vals = kmemdup_array(data->int_time_avail, *length,
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
>  
> +static void as73211_read_avail_release_res(struct iio_dev *indio_dev,
> +					   struct iio_chan_spec const *chan,
> +					   const int *vals, long mask)
> +{
> +	if (mask == IIO_CHAN_INFO_INT_TIME)
> +		kfree(vals);
> +}
> +
>  static int _as73211_write_raw(struct iio_dev *indio_dev,
>  			       struct iio_chan_spec const *chan __always_unused,
>  			       int val, int val2, long mask)
> @@ -699,6 +715,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
>  static const struct iio_info as73211_info = {
>  	.read_raw = as73211_read_raw,
>  	.read_avail = as73211_read_avail,
> +	.read_avail_release_resource = as73211_read_avail_release_res,
>  	.write_raw = as73211_write_raw,
>  };
>  
> 
> 

Thanks for fixing this.

Tested-by: Christian Eggers <ceggers@arri.de>




