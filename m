Return-Path: <linux-iio+bounces-12649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 342A19D8CCF
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 20:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9741287A22
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 19:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8101B87CC;
	Mon, 25 Nov 2024 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PFmXGeHc"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF651B86CC;
	Mon, 25 Nov 2024 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732562699; cv=fail; b=XCittVIBpNaFAD9froURIJ4we54PKnQtgEzTU5ur7xJljHzhX1z2j7Z5UEpji5n3ZCgHKHm9UiGsJ3crqUcTscouWLWBb96XRjc2l8LqteNvcbMeflnOht5k70rt2SvhRPi5eNzywMSpVsfsJk3Y7KTfPTfYJ6XgJzl+Vr4Kp4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732562699; c=relaxed/simple;
	bh=gVRdKA4vZEo1gI0IvY+Knn7dtPSzy3Y8MBChSgKcatU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qkmpsOZaSLzaXQRjjo2S+nQJ+cejB76QKfHnXc2YEHGCS/LYglMyAAunBvhoP3wLvV9NxKCFR4lWweFE+bwEVxympvcpu1BHkFWKvz53oQXY57P75xE2ZFhMAu5g1u5P8of1fnNwuwaFYeqiRLh38GJasDfR7ao4FhEGxkdhJcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PFmXGeHc; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V06kks34F4V4KxCjd3AmRHy7yYSXeYhoWmrYzIXaChOLdK3DJiYDuYiP8RK1y64GG4OQKoKCwov40WHnEEx7ZXXYpIsxJu23SVqlcCSrxwYgGZEwOiCz5bHxcPWBJVH3U93t8V37SP7bjiuQ9kjKNFPTk3lws6Jx9EKAtTXFcDtN8JeoKIOlhq7hkLRWAjmBGt4HMoiRYxWSAsuH9zBJpGNLpuqHh+W9JNjd/qRDjrz2PWgKbrWsbEFHfznIkFac6a+xidr8PpcWANp+jMUo+Sue+CmH9RyZJmDQiYebfhvqU9bEWco3zLj0Ds9VZeMlwpU3lTrVneDVNeAk5mnGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSFwS48kL2a9UubSNR2I9a210XsscyekzE4UQ9PdPY8=;
 b=uAbMYu7WmBF4CpURsRNLvGLba5mLNpM9COgXsbxcTxawdyBy7c283z+Q4hclg2RoRQR7uu987Oiv94unEJvt9ExhILdHV4QXL2BZE9MvCxfnZSSDATi5gUXKCFV5gDUTHXakCIoL3aMpOcgMI6x/Mz1aPPct3scdb4mMTvCuKDaOZCvcFXaTY3g4wpwxSVPZDP7xF9SH3SmJF6a6EtBAeFZuojPsJREKOjyV+IhFvYKHjF1LpAuCG6th35nPgako4e5gNRwBqTLs0jHI02vFahZwiFrI2o/Mrn/Wqo7/U3dV+r11uWmOa1eoekT/U+anCQtwCgZGT0COX5lX5tljHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSFwS48kL2a9UubSNR2I9a210XsscyekzE4UQ9PdPY8=;
 b=PFmXGeHca9fRZcjmGnaMA06EYCWh59aAQunJCWDIozKgLnRYj6lMDzzRtFVcjGKeTsmuBb/okIlD/ZSZ0ErDaO90lxbD8k/bDoTAn8MA3VChyZSmpQyZ/v42xDbto4n7njarlx1F1HR4s/GvplTiYuN2FYtZcXVVb5ZvZGb9pzRTgEI4u6M+an3h7NJGplWex1PJ5Oruu4Zdu8HdoFvbzi+81ggQe3EEsVvlVTOp+dLogKGKKWB56inCu+agI+UGsaY/faet9OHewlwdMJ9a4jDnzLSQAknG/tAL5/3E3AC5xLA8gpH5luS1NTSWkoZwRBkBxVHa70wrNgeEVdACHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8103.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 19:24:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 19:24:50 +0000
Date: Mon, 25 Nov 2024 14:24:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Haibo Chen <haibo.chen@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>,
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <linux-iio@vger.kernel.org>,
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <imx@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] iio: adc: vf610_adc: use devm_* and
 dev_err_probe() to simple code
Message-ID: <Z0TO/OL5DQWSMLfG@lizhi-Precision-Tower-5810>
References: <20241111213859.3317909-1-Frank.Li@nxp.com>
 <20241123152637.27a66403@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123152637.27a66403@jic23-huawei>
X-ClientProxiedBy: PH7P220CA0073.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: b1dc8866-85b2-4d1e-073d-08dd0d86d493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JUmm9jq7pnFbIWf+mMJHRGV621WM5zSBRo8uPIdAg+qcsTPqegIQIx52jBca?=
 =?us-ascii?Q?NW210v7wKDT4cEejhRkjFRo/hnAcRZOUqGN88Kge0IZwNpDXfii0wwVHt/01?=
 =?us-ascii?Q?LF+Jryrz5p9NFOirK1/pP4fW5yf0Ia84w1jMDrYGINgTDKS/ExUnfAq4haL9?=
 =?us-ascii?Q?6EpISgzMkir/Ii3UhMWhf8qNRPZxutlj33dSe+iesTfBkrmOKNmk/wBaobJ2?=
 =?us-ascii?Q?/13R69cZ5q92tmqPk/me4sDfSRVTYi1Hl8TDwxIqlISHN3ZxUvH8SZ7XUjcF?=
 =?us-ascii?Q?A+3OPlyDEhEqObwPtqv2qxkaaJzsZgxyZ1M8saEVoEH/MnFiGgXw1H+IdSa4?=
 =?us-ascii?Q?QiL9CXTx5tbtGaTK7bnaewQH/KfZvCiENW/TO6qn1JIXwb2FTcigNIuf35my?=
 =?us-ascii?Q?AwDjCmMZDNQe8CeezMJQH+myh+g4hw6jiMeIHidQb6pNCMv3vmvJVIBlO72o?=
 =?us-ascii?Q?AUUg+p9y5PhqRhZif5gWo0qwh5QOuevkv5LJSj1aH41YIQMIIO0vWvii6R4g?=
 =?us-ascii?Q?U7jv8BIpZwNvYT2LkphMP3wa4GkPTxb7NDElP57/qCDsmxhEjZyhVjNu3J/q?=
 =?us-ascii?Q?9g0mPkIJx9Q6N+qVYxbVAKqG2zQBB80BYEoSnaiG5i+JKuo+c3GoRV0n1V5b?=
 =?us-ascii?Q?wRI1ffYhiNfxVVVeSHo1DwP2bouEYKpD7qosXHpzm2h04vPu62LQyoVnE5hB?=
 =?us-ascii?Q?d8ZJCw3ykK3TgzTMIsXg3IMbE+voSpS8j1u+ef/2tB2Htohr3B+KQdkiBEgH?=
 =?us-ascii?Q?hiAf8LEJyTOo6KMXKoltRqLrYqKamprKVICNjTqHJg+Dno0QRt6cVKxTeHux?=
 =?us-ascii?Q?Po+MyJqaSgM2a0NJcMdQCzuKDz8EDNs3hOcmGgJs711WYRDgmwFMp3zEsUXp?=
 =?us-ascii?Q?b2LZ8v5xIIuZvs1WLIXWEdzHl4DLeiCwYMsSwUic/Fk4NnKobmJE/8KHYZTW?=
 =?us-ascii?Q?TBlYmZ1SDhdmLwD+adcxo2o43u46moS8X0zfXklO+LzQIJMoUKyspd0Y9f9w?=
 =?us-ascii?Q?QIQc7U00jyG4Gm2jNkw6YyZXltT3GF+Ns/adlhl6FV/OkmdSeOcWQHcLWAu8?=
 =?us-ascii?Q?nyJiTglH2zGgJCsKdRMZJE0N/al3ldobTtjCnOSK4fYUMdJFHDNlKx8JLS+C?=
 =?us-ascii?Q?60LFJ/LA997yG9jDq+K6n9pzpcIn3p9wRmPNp8VEeldFHbU0rvCV3Qv6Ps+3?=
 =?us-ascii?Q?kRlnv3L+UP/0ETuvEWRTP6GOIInoC6DQyAwxjcFe/zw6IQ4XrnhNuvYVTIKJ?=
 =?us-ascii?Q?HMsSXhGCSi0tLF6zPXW3FITaX6pia8PB7GGrV0jF2pK9o2FsIFz2HAUZDnxi?=
 =?us-ascii?Q?bYC4/acrmDGBT7iQXtylMgok3Kk80lvD6hfCkua7uAd4cFndrY9+whiS7PXM?=
 =?us-ascii?Q?WbGGoes+jzVx5hUPDZiffj/kC2FvY9MOSgi9oAAcUWbbSWE8lQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZpUebmDIN+re+4gLmKO5q/utAGxPogO9hx9SkuHLTQboOWu+50jUtBHfSiYO?=
 =?us-ascii?Q?ZfG/Uwsbg3M9tIkX2l12dCo86XeyC+Trd03uUvMcRivZeElmkHIQe8oL6cs2?=
 =?us-ascii?Q?/maiQad2fsmKY5E47EhmEXURCmZOZk8qZs3LSuVuqv7QKSVQ+HEeaedWMLQR?=
 =?us-ascii?Q?5HfXWUtSbLoFCq/8xU+/3ImhdvNz3+gjLgtXV5+vNvpFvoqVS9FJx9REXMaj?=
 =?us-ascii?Q?lt521WeWBj97uYvWRUratC1nkR7vYW4foYVu4AJ2Uskg3UA/3Ap656SIim6E?=
 =?us-ascii?Q?FA/EmGy5TkQ9OU+i5fY7QJ3fS5keBePvPujM7pudLmd35+ZKmJKDNV2rARZl?=
 =?us-ascii?Q?+vrLzvJ3kr1DAjYNskT/RtfHTgX7BkDL5zleo0NovkIOoX8qZQPAJeiRLb/c?=
 =?us-ascii?Q?1u+s9P/QaAPqeShO4+Eh31zUOyUO2teDWjkalGXP7Ai8TGo8xYanah0yV1d3?=
 =?us-ascii?Q?eNZzo5tmsXImboWByn/xx6PVNjHezmiF1oUglAhQER1yT0s64LL/3Z1qA5lT?=
 =?us-ascii?Q?kLO2pE4lp3JZ2yGh9Zd8Y50CbfkvhjHjiLX6SS/gI2zSUfivqXbH3xkGwGho?=
 =?us-ascii?Q?x3eVyezjej9GfJ2GTQPdt8v/P4Xwd0/jz34bzaFPji8I9S3ntWUAjUReyjTX?=
 =?us-ascii?Q?g6uPZXvBC10t6ykMoRzUdNjX1eDQmN7aZACMOW/LUyTgHtSlK9weL0sD4PY2?=
 =?us-ascii?Q?kjYmQr4HqyWnvsYl0VEZvEL67dNb8VqB0+PFOIwu5WPhi15SV37lDPiqesj1?=
 =?us-ascii?Q?ejMBsGJ46fImIIZgtYs5fZvQXN5NZZVjYxUIj1mDb3y02RlxgJtAr87WA0rS?=
 =?us-ascii?Q?6aTMW/1FZAJQdfQHjDiMU6bc2ELutGMTAeB4ZfFnsc3HYaSgi90cR65UCehi?=
 =?us-ascii?Q?rmYIDIYoCZZDqMX0wYfxbdQlfiZY0UvUtNkuZHffwVXF1JqC8I4fNiHvspxk?=
 =?us-ascii?Q?K4CyW61n7ZG+6UtkHQ+3AYqGObDsQ76zl4SPyYRBpjOFLo7hYYuRf3hBfqyP?=
 =?us-ascii?Q?QejcwQp2QsRdouBB+veLsNBnaJmTEtiafiXE/cWeTphRnE6t806TyI52pfFj?=
 =?us-ascii?Q?ToG1NxErtYKvbf4ua60AxVWy1rhiOAQaZjhQHDB7Ll7/EXAJzBCdlYbqSxc8?=
 =?us-ascii?Q?a/SrqDDQ9mrL6TJBUmH9c8GFXkZ2zM/by2BIhJ2AevRhAd0+VkAJZvyOAhoW?=
 =?us-ascii?Q?ffUy8OfeVH7h/jp8TrRw+YZyvGl6Gs220DJwEn8p3ChnTFfJo/PHLY50Edug?=
 =?us-ascii?Q?TFzddzr9gxn7c/VdaWXyk7CrlXnx/xrOpk8FuAOMVMfe2vdlPbgr7zBV+jAM?=
 =?us-ascii?Q?D5QT49SKlxBtSHVyE0xnpMOmEHzKL13Yqoz5okdpGpsyZi7dV6837H5nDQgE?=
 =?us-ascii?Q?DIj3A3vs1BC8nIQs9SVqR/3pHrEmUmH1cySj8thiHmxc2UGt0QynZMFnSCn6?=
 =?us-ascii?Q?qf0K5Rk1PRdpblGc1qsTGGjvo13iEtCsi4ubAzcy0AtTAMyq4f8cUeuKBGTO?=
 =?us-ascii?Q?iqFovW0iJ+PfQSFaourSoXMS/YzvuYZSp/Vl/+wkNMMj0Tu4Rn+y8Dlx4njA?=
 =?us-ascii?Q?iWYN8iMVwJxeNikN7TA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dc8866-85b2-4d1e-073d-08dd0d86d493
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 19:24:50.0512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvfVUsUJsKYz0ebBJbeMqgimiCp/Zmtc+pWiA6d4/UZ99bqomK7OtPYRe7Uvl+CkEeRX9HW+t/2ToMgdQnag+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8103

On Sat, Nov 23, 2024 at 03:26:37PM +0000, Jonathan Cameron wrote:
> On Mon, 11 Nov 2024 16:38:58 -0500
> Frank Li <Frank.Li@nxp.com> wrote:
>
> > Use devm_* and dev_err_probe() simplify probe function and remove
> > vf610_adc_remove().
> >
> > Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Hi Frank,
>
> One (hopefully final) question inline.
>
> Jonathan
>
> > ---
> > Change from v3 to v4
> > - keep vref_uv as u32
> > - keep original regulator part and only add
> > devm_add_action_or_reset(&pdev->dev, vf610_adc_remove, info)
> >
> > Change from v2 to v3
> > - change vref_uv to int from u32 to fix below warning
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202411070633.NIrO7Ert-lkp@intel.com/
> > smatch warnings:
> > drivers/iio/adc/vf610_adc.c:857 vf610_adc_probe() warn: unsigned 'info->vref_uv' is never less than zero.
> >
> > vim +857 drivers/iio/adc/vf610_adc.c
> >
> > Change from v1 to v2
> > - add Haibo's review tag
> > ---
> >  drivers/iio/adc/vf610_adc.c | 79 ++++++++++++-------------------------
> >  1 file changed, 26 insertions(+), 53 deletions(-)
> >
> > diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> > index 4d83c12975c53..d4b778799755b 100644
> > --- a/drivers/iio/adc/vf610_adc.c
> > +++ b/drivers/iio/adc/vf610_adc.c
> > @@ -814,6 +814,14 @@ static const struct of_device_id vf610_adc_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, vf610_adc_match);
> >
> > +static void vf610_adc_action_remove(void *d)
> > +{
> > +	struct vf610_adc *info = d;
> > +
> > +	if (info->vref)
> > +		regulator_disable(info->vref);
>
> Why is the check on info->vref needed?
> vref is required to reach the point where this callback is registered.
>
> > +}
> > +
> >  static int vf610_adc_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -823,10 +831,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
> >  	int ret;
> >
> >  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct vf610_adc));
> > -	if (!indio_dev) {
> > -		dev_err(&pdev->dev, "Failed allocating iio device\n");
> > -		return -ENOMEM;
> > -	}
> > +	if (!indio_dev)
> > +		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed allocating iio device\n");
> >
> >  	info = iio_priv(indio_dev);
> >  	info->dev = &pdev->dev;
> > @@ -842,17 +848,12 @@ static int vf610_adc_probe(struct platform_device *pdev)
> >  	ret = devm_request_irq(info->dev, irq,
> >  				vf610_adc_isr, 0,
> >  				dev_name(&pdev->dev), indio_dev);
> > -	if (ret < 0) {
> > -		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
> > -		return ret;
> > -	}
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret, "failed requesting irq, irq = %d\n", irq);
> >
> > -	info->clk = devm_clk_get(&pdev->dev, "adc");
> > -	if (IS_ERR(info->clk)) {
> > -		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
> > -						PTR_ERR(info->clk));
> > -		return PTR_ERR(info->clk);
> > -	}
> > +	info->clk = devm_clk_get_enabled(&pdev->dev, "adc");
> > +	if (IS_ERR(info->clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk), "failed getting clock\n");
> >
> >  	info->vref = devm_regulator_get(&pdev->dev, "vref");
> >  	if (IS_ERR(info->vref))
> > @@ -862,6 +863,10 @@ static int vf610_adc_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >
> > +	ret = devm_add_action_or_reset(&pdev->dev, vf610_adc_action_remove, info);
>
> As above, but this time if info->vref is not set, we have already returned so it
> must be set and doesn't need checking the callback.

Yes, you are right. Needn't check it at callback.

Frank
>
> > +	if (ret)
> > +		return ret;
> > +
> >  	info->vref_uv = regulator_get_voltage(info->vref);
> >
> >  	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
> > @@ -879,52 +884,21 @@ static int vf610_adc_probe(struct platform_device *pdev)
> >  	indio_dev->channels = vf610_adc_iio_channels;
> >  	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
> >
> > -	ret = clk_prepare_enable(info->clk);
> > -	if (ret) {
> > -		dev_err(&pdev->dev,
> > -			"Could not prepare or enable the clock.\n");
> > -		goto error_adc_clk_enable;
> > -	}
> > -
> >  	vf610_adc_cfg_init(info);
> >  	vf610_adc_hw_init(info);
> >
> > -	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> > -					NULL, &iio_triggered_buffer_setup_ops);
> > -	if (ret < 0) {
> > -		dev_err(&pdev->dev, "Couldn't initialise the buffer\n");
> > -		goto error_iio_device_register;
> > -	}
> > +	ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev, &iio_pollfunc_store_time,
> > +					      NULL, &iio_triggered_buffer_setup_ops);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret, "Couldn't initialise the buffer\n");
> >
> >  	mutex_init(&info->lock);
> >
> > -	ret = iio_device_register(indio_dev);
> > -	if (ret) {
> > -		dev_err(&pdev->dev, "Couldn't register the device.\n");
> > -		goto error_adc_buffer_init;
> > -	}
> > +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret, "Couldn't register the device.\n");
> >
> >  	return 0;
> > -
> > -error_adc_buffer_init:
> > -	iio_triggered_buffer_cleanup(indio_dev);
> > -error_iio_device_register:
> > -	clk_disable_unprepare(info->clk);
> > -error_adc_clk_enable:
> > -	regulator_disable(info->vref);
> > -
> > -	return ret;
> > -}
> > -
> > -static void vf610_adc_remove(struct platform_device *pdev)
> > -{
> > -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > -	struct vf610_adc *info = iio_priv(indio_dev);
> > -
> > -	iio_device_unregister(indio_dev);
> > -	iio_triggered_buffer_cleanup(indio_dev);
> > -	regulator_disable(info->vref);
> > -	clk_disable_unprepare(info->clk);
> >  }
> >
> >  static int vf610_adc_suspend(struct device *dev)
> > @@ -972,7 +946,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend,
> >
> >  static struct platform_driver vf610_adc_driver = {
> >  	.probe          = vf610_adc_probe,
> > -	.remove         = vf610_adc_remove,
> >  	.driver         = {
> >  		.name   = DRIVER_NAME,
> >  		.of_match_table = vf610_adc_match,
>

