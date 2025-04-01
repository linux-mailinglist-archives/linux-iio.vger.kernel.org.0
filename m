Return-Path: <linux-iio+bounces-17504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0C7A774E8
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 09:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33669188EB12
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 07:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEAF1E47A8;
	Tue,  1 Apr 2025 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trafsysas.onmicrosoft.com header.i=@trafsysas.onmicrosoft.com header.b="nr/Wha3m"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023136.outbound.protection.outlook.com [40.107.162.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F34727468
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491002; cv=fail; b=dbhsrNEoF3dpKn/cjdYWbuR8y6KITHeHxYSO9lV3fgLFqAttJXl9rdLOibxNSsgsjB/HSPmzE1sCNTHk7Dy0in66hPN36EvRPk2JgCBJ5qVInUmgVkM9YfJNUlQbkpdZKzSRgxfWl/3+qvI58hqqCoRD5fXVY4ZLFQONQgISX38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491002; c=relaxed/simple;
	bh=Q7mP24OMhZhYRkyQ8LGV3GKTXeBh/F4iOnsE/XFQSKw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=lnM1Xzi3kSXV4CVzd6xXcy/lKUcCfOE4ow0mhZEumt/PkE6ZgqhbgpO7eAVMeHV4/YM/q1hXrwo22Qv6WzzOW/LWojRvME7liVo0MCDj7S0NEVXOyaFjvzf6SXC2RnKwsL7i5QvyhvPsPUZVN26+0ZumWgJZ8IKADKpzF2i1hNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norphonic.com; spf=pass smtp.mailfrom=norphonic.com; dkim=pass (1024-bit key) header.d=trafsysas.onmicrosoft.com header.i=@trafsysas.onmicrosoft.com header.b=nr/Wha3m; arc=fail smtp.client-ip=40.107.162.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norphonic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norphonic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OS2A9XZCUsCxKRD0f+rUoQSHsC4UAm0liuYyN5tTJ/UAT3ndnSQkVdGsg2mkCHJSX4Lm50re3utMmht1yelo9fnPBSKSbCw/kWRWop8XxMhy8o2x8veKI2J8kGL/A4s+otZvBWOurGq8u5A7EQwUw82Q0Nvyu0bYU89YJ0jGYqCASUiaBeUqS8N80JHcU7QqvXMKUBh3+/7FyEz+eGsdP2ozhynsW9i81y80PIDwlVTvNy3z+SomDt77VN/pFr9ZaggXuU8mJuVtpQ+kGWaXF/oqJqrFs9M6E+gRySPd3i170o/7Xyy2d6unXZcgvzTYBaSRHx7Ryh7zS+fxFsxYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKA9lD1aKdUg8ldjA6pAvYizjzu4YEryc9YE3CjpnoQ=;
 b=E0ee7vRa/5Xo1ywlo0fAOXcXXp4tgr/5cuNU95BpWFO53yGNOajzzRxauijC7PJYO6NpLdyBzshRZVUOUgDEaRgWH4V1U61fJ9+n/HhIc45EKeHESmeoMa0IEAtXqlPGNglEV3ILVCZ9rfPcCYveF6HiqxoGwZZmUVrbSh9zf++NoTsOUbNwFYDApyYoyzlBrLz5jamvLF97+DCXpzMKjKdNSvynPasntBG5uojYHYf601WJCINDy3vfFZIWsQ7lhwbioN9pvZLlHW2eK02EDWUqRwYBuX012xcJzylfPnarcZHEVRIzQ1xAEGueADJUWAC3mlGwXeUATTLWk9s+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKA9lD1aKdUg8ldjA6pAvYizjzu4YEryc9YE3CjpnoQ=;
 b=nr/Wha3m+FQqopbVyPnmWYHadWNtQTGSredh1cWc1d4NGIE3nYNShxOJqAazAMjOhSPs/rMPpoo1S2GdaAwKhrKT5TgHXPZ9Cx0lGV7pFjUkK5AOlgESOIN/gOfRMN1QVmXwu3H+pv9+4Qc8h0HlnD7S+7XZ8lNvp02c04guoh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=norphonic.com;
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by PAXPR06MB7872.eurprd06.prod.outlook.com (2603:10a6:102:1a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 07:03:16 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::a710:9bcc:a807:b431]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::a710:9bcc:a807:b431%5]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 07:03:16 +0000
References: <20250331121317.1694135-1-jic23@kernel.org>
 <20250331121317.1694135-13-jic23@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.3
From: Eugene Zaikonnikov <ez@norphonic.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 12/37] iio: humidity: hdc2010: Switch to sparse friendly
 iio_device_claim/release_direct()
Date: Tue, 01 Apr 2025 08:59:58 +0200
In-reply-to: <20250331121317.1694135-13-jic23@kernel.org>
Message-ID: <86ecyccqj1.fsf@norphonic.com>
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0084.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::17) To AM6PR06MB5430.eurprd06.prod.outlook.com
 (2603:10a6:20b:86::11)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR06MB5430:EE_|PAXPR06MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3b4334-00af-46ea-3d33-08dd70eb46c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ymsjak9gDa1WGR3rwkXD260tLq2bozQX38wRkGJ1bqBk9l7GnPQ3KfWgzvGs?=
 =?us-ascii?Q?v4H9tzaJFkbTufqeVt9XY1f/DA4Y//ojuJYabs7Q6FYOTL+FPxo7SEqFnkC0?=
 =?us-ascii?Q?HTH3jt6k78UAyACDvbFJbflNuPuYPlIb4na3hF6sceEzOpKYn8TpxfrKqbZQ?=
 =?us-ascii?Q?mFjU//3VoyGaQiK9XutmXMVznKA9qsbXFMR9T+MFMxiKUIRvzbF2o44WlSsk?=
 =?us-ascii?Q?EiY0KjspfNQ/lhtnyzEG25TKubifKWiu1pl5a4cHUKxq1BzUl8esg+qAQ0QN?=
 =?us-ascii?Q?U7tDXN5a2ZZFlGGkek24tUuNX9spnuzn/khOz7xZ4YCquvW5S2gk58kVPu3L?=
 =?us-ascii?Q?8lOJqqS0NvhXztrQRgzi/jAZfczbHkJj03O0P4OWXjM7nRpa29Y9O0pkn9mw?=
 =?us-ascii?Q?PJWpnhccDyvyubhaNI/fZhzXuJA/kPWcMp5ZFa1aLp6aAdiBikYIqN/uGVnH?=
 =?us-ascii?Q?guXvYVcaeDoDOKcjDLEzheYmCuZ9B2xMyYiWUn8XKRa4Dea2+OhijXR0Sq5V?=
 =?us-ascii?Q?n/NhwQjVOcmIwAf7+yka2JxLcsoM4GgvDJ0aChnhyY2okOU5Vp6+NMfi6NaE?=
 =?us-ascii?Q?YtPAOv02N7Ey1E3uIJmquV8GtEe3uMJidG7o//FfWV4I021QvL1KwUkECiYI?=
 =?us-ascii?Q?69/E3rJC+DM3KL6mr396BdxDB41N+NaVhnmaV+Q4mRXUbcb4t2WqBCVllJnZ?=
 =?us-ascii?Q?nKQAyBBn9ROXgSY1AJtX4cn6bEnsGF1T9D0spJBzITmyFIO0JyXbBJqApsF/?=
 =?us-ascii?Q?ZJz9ssw9RqaJf+d4T9pMGZFxJuSWxnbPq0Vw/qxZympRiUmRQC40dekl4YUi?=
 =?us-ascii?Q?600/6Kum8otrIvvnr7KHp099qR6KyjwIrDr2ZP7QnDXnHlJlyS7wQdm92ARe?=
 =?us-ascii?Q?vnvjBXxBbduZ1uY++et2G20zdsK1PPGdW7agZ7vy3EzTKDVngvTIRcpYPp9A?=
 =?us-ascii?Q?EFyWQXpaUWJKFZa+AszWsOV9CjPjNVojHxXPiy1As9VoGQjgybn6pExEhOO8?=
 =?us-ascii?Q?6ZU6F5UfkXX/tnepa5x58S7XP2cAmxFYm9PD40ufO0oygImplaM8vE1JpGoy?=
 =?us-ascii?Q?/vRaEVICg37qa1QSM7MuA0x0Dj9L2+IPYAWn7oP3nc1cMp/pC5q/H47EO7os?=
 =?us-ascii?Q?BDFiafRl5GyIhv3XKaOTLzUB78/XDThe2hpN5v65N/OfKxTtPjB6C7ReTrjX?=
 =?us-ascii?Q?PeB9ZNjVDIA0brSRguAdISbyBwn7SMq2n9vV0f8NcOMiAl9htK0zJlsmkayy?=
 =?us-ascii?Q?FP73hMQrtgF9tY7MzHbLEdstedz1yqM9273YXyztLJBYz9n2FCe42YS+xiiZ?=
 =?us-ascii?Q?4L39SboHbPseQqnMHtNqql0Abts+2ipqnDlr6WHPyhPKHev0I60BQr064yJl?=
 =?us-ascii?Q?+83/FG/SVYx5LQXTVX3kPmviG8S1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vRNHvr7mszj+vtIuKjsPrJtGlCLWI2y0rXOw7j5ThihVHAKtNBI9kxPF0K3p?=
 =?us-ascii?Q?mIsoGqBiHDkPwvcBSaWEc8/BtD7DmYnujewFz87H51BIn+TRplYcOhEJHmeS?=
 =?us-ascii?Q?KVWVgToQzB2rFnuMzGCRv5B3BgyYKm2B/P0OWnMT3M/ZmrrLeS8nNrEdueIc?=
 =?us-ascii?Q?AoybNeNMSymx27FxA64HWI2f4C60ZK03EW8sxex106QgjE39oY1PhLG8FWfN?=
 =?us-ascii?Q?PLgjFglzMlL+sMXVbb1WR0P38PzGTRLJW08yJ1jhtzmd+xIndfp9zig0WLds?=
 =?us-ascii?Q?leLSzJa7DnMjbVP4QdGz10VzezCOBGxA3eQbuRWayW1/fkrXCVyEcBgGQOPy?=
 =?us-ascii?Q?1cSKCW1UZjumAmjVm/2Bjo9jvQSfNnBbrKoXzarDf/mGu4reEsTy0tYReDJl?=
 =?us-ascii?Q?YBr91PsbN9a3Wm59+EEjYgrlu6sNkAUjQQh3Ww+XZfEyngaZcp6IwzvweTpG?=
 =?us-ascii?Q?LtABdvR7xgSpQFsuXvBi1Y9cH46nv4o93COGQwP6LqSGEf+dxU8zyT62eWRR?=
 =?us-ascii?Q?xxefBa1AuZ8Ttsod3gUeGNCBjtZ/dZeQ0rD9SBubo53IQ75MGzMGEx4P6/zB?=
 =?us-ascii?Q?ZZObhDmk0upW/x3CPu7kWah7eKIf4C+4UDuKT76Aqjr8UO/RzV35kOhIAGlo?=
 =?us-ascii?Q?hjP+eiJGwqTdQdKPCjq3R8FKaxQtBTCLPTCm3amCv/vwNSGa6+jxJ98dTkW5?=
 =?us-ascii?Q?T8mSUu7rhQRAeQx1SCh7EALa5lzhDU0zOSYWIYA574KAoDO+hZiI3TWS2ujr?=
 =?us-ascii?Q?KFkWKf3aj7ZOxuXOs98/VZdlGlXmJk8WjQwZ5ExruzVHz0Vy0xovK73hflH/?=
 =?us-ascii?Q?IpmrfLhEFuMrnlaMVe2Dh8DnO1/YxjXDgE3ibjxtOziOv+bxwGXSWjQECetZ?=
 =?us-ascii?Q?RQf+N8QcY9SW95o4ym7FNWdviGqHBZQdAniETkNVFh2klv89s1vtoy+aSU13?=
 =?us-ascii?Q?iCdvugmhlX+MkC9VvWUCJiZTDDDxl7NCmL1S4EY6/KJKvco3eO/zpddujKaS?=
 =?us-ascii?Q?YV/DP/Xu/A4K71YTrGTNm9D31rYNFdunNBg+4imDVUVSIR4m5KBLlNOLzptB?=
 =?us-ascii?Q?IGhTo8LVqlMjNaX2wcdMnDhhFZFOi+LUOEmKXLQVl6GmOadLLRj1gGlSoTya?=
 =?us-ascii?Q?O0dwCOXyrMfqujAp5MkL8RCqu2B9ivai82K1DK5Y7z6FhwYN441OhrGFDmEj?=
 =?us-ascii?Q?uy1a7X2znhqUDRx5O8ScFkVSLkFMNqrmiqWqip/Y8BnZDA7kSt5P1O5bx2OU?=
 =?us-ascii?Q?sMYh7oDA0yYMLk+hbRYlGekIh7c8/5zArUeFja2pZgvk02n0NP77cjKYUtRh?=
 =?us-ascii?Q?xRMut1rTlY1O55pQF8aGZQz1dP91dPmIlXH2dbWFHDO2wO05A5yupdAxSE80?=
 =?us-ascii?Q?rGd3idjps2g4cPAlWyMTWzIa2SoRsrMIDOLI/pUbDWOC3xFaVI1hP/RyDBa2?=
 =?us-ascii?Q?1rAUWCgfX8PeWoePX0nTONBK9/LOEMX9ug0wfOlvjc3kqe0JwxFqrazKZ5am?=
 =?us-ascii?Q?O3qWqrUBIqwUXS5mlu0NVeSb19xuiJeC/Q1iW7wEPliCSLDDIa5CP4ewzLKz?=
 =?us-ascii?Q?2y8jrN3thBND2M2ZRcvCIm7HfnBi1p/EW4EOtc79?=
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3b4334-00af-46ea-3d33-08dd70eb46c5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB5430.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 07:03:16.5160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HilOhs0wfgVzimynOgrdXuFkgbzzt6giVatscRyO4Vfo4cUU/ux3B/BJg3opgCfFse2XnN2Uby5HP08Q3LmxUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7872

Hi Jonathan,

Thanks for the patch. It looks good to me.

Acked-by: Eugene Zaikonnikov <ez@norphonic.com>

Jonathan Cameron <jic23@kernel.org> writes:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Eugene Zaikonnikov <ez@norphonic.com>
> ---
>  drivers/iio/humidity/hdc2010.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/humidity/hdc2010.c b/drivers/iio/humidity/hdc2010.c
> index f5867659e00f..894a8b4ab193 100644
> --- a/drivers/iio/humidity/hdc2010.c
> +++ b/drivers/iio/humidity/hdc2010.c
> @@ -169,13 +169,12 @@ static int hdc2010_read_raw(struct iio_dev *indio_dev,
>  			*val = hdc2010_get_heater_status(data);
>  			return IIO_VAL_INT;
>  		}
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
>  		mutex_lock(&data->lock);
>  		ret = hdc2010_get_prim_measurement_word(data, chan);
>  		mutex_unlock(&data->lock);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  		*val = ret;
> @@ -184,13 +183,12 @@ static int hdc2010_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PEAK: {
>  		int ret;
>  
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
>  		mutex_lock(&data->lock);
>  		ret = hdc2010_get_peak_measurement_byte(data, chan);
>  		mutex_unlock(&data->lock);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  		/* Scaling up the value so we can use same offset as RAW */


-- 
Regards,

  Eugene Zaikonnikov

  Norphonic AS
  Tel: +47 98 23 97 73

