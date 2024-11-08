Return-Path: <linux-iio+bounces-12041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA309C224F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 17:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199851C22B3F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62F1197A92;
	Fri,  8 Nov 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GSmAPH8i"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF81803A;
	Fri,  8 Nov 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084327; cv=fail; b=baDgrRi5F5JkNcsJ4nZk3jcxt0jVr2ZLy9pUxGcSA8LDTSQ9YFKz68589qoz9I74FPT1ZZlzUY4AUjcRgHNcRJwPm1FX3OzF10iFhht+ozgBNvKBpwP0dqYROszFgZd9+Jw/cU3dDiedfZD/1QAr/sWDuJoB1J+oNBWzwqHll/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084327; c=relaxed/simple;
	bh=29Q2MRzMBaU4Nz8mfrF+vPARfG8GmT+PRkw5JXJHB/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BRLSfFwch/DcNRQ5t2+K/s82xMk9BHpn4AyME1TrmKu+jJEFMRVDVi9pw2E+2zDrMsZsSoM9ndeJv2QLh55j6CVr/I7LLzOoH7Lma5zrgGeMR/WHrPhiJeT88pvVekQDgtFDPWIY5kQBw+AMLC9kJH8Wo/zbIaHcOnl6VRDGDxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GSmAPH8i; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXm6qndDotZAF0JyxJWyYHcvuTytKXLWlpgPfXvd76V8q7Kpo0vikM5+hk643EkiQ8BjJb5dvx2zK6DEHdvOq5Q9r7cQ++c4c63j7GyZdlOQX5sRRgp/6BIV97MOTRDKukRtOd5/fNN4RDCOIAE8p8fv3TIuD5w/HEvdLOV1YN1uGEbxMaatoxJuppxD1n5XBJWWCauVnNlpIkAcQ/bL9gqrDRNGhU10yh6+ew2AKejC2y8Q2WM7riTExhGzrWvHrCWNWebYb8TUiiUkiGnqhRddDL4phLRs+QD9dc72CzjeRIDfDOeqevo4DvnjAspmLtEFLZ8YDG8u04FxGiXYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29Q2MRzMBaU4Nz8mfrF+vPARfG8GmT+PRkw5JXJHB/w=;
 b=MfPCQAZKoOkXJrB94wwtysLOippAbI53k3/qCOg+jD56ndeKbrRpS19+stGO0JFbY2qKphNLSh2JMuVrIyTr1eGxTfyOGYZGO0Au8CcTwEKQrh7QwB8173YwK5wXybj5B73zlnn5b29mdH6tqr7aeDUGDCsa4mDXTzJhHhyMLRwSKuKeETOk54/vWZ/5z7S1zwlCvrMnH+6HLpdZL0s4wYB5xicfXfvkLjDfqa5XQXzQMU+lYw/xNT7/oLSLsvxnk/uclsk3ThaBeZw0LcZQVyFBuOQ9n0t+MB8EbjRun9RD2ZeVGWANjIfSUu1OL450xgIDLfS4h2ZGonSW7Cmwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29Q2MRzMBaU4Nz8mfrF+vPARfG8GmT+PRkw5JXJHB/w=;
 b=GSmAPH8ikVSo7V36twdrYDiJyXr9tNQ5pg16bXpa2hRUA71cdXZrAqLj4zI7re9O+C4IYdbj4Cy5EPnOdSFbrtkWPB21v2IZcuz97Oq+0/HmATSneftyvQqSGSx6LIicZNcR4o1IfjhhHevdpeZRkLi+zvS0mjvvgw3TlQEFRprr/XyaWFUe3zFVkt8Kx5Qf6l3pIQrwcLz/JQVXleQT32URQGzgEmOERe8MgMzygCawypG8s4piZFkXDmDo/C4foPAjksChOexTOh58vITzRujIjis5q7ppJ6eWLqAF54ya6Tv907INr92hofU7NBAETy6VbMIoW8fjL8h3dMTf3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9681.eurprd04.prod.outlook.com (2603:10a6:20b:480::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 16:45:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 16:45:22 +0000
Date: Fri, 8 Nov 2024 11:45:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Carlos Song <carlos.song@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: temperature: Add support for P3T1085
Message-ID: <Zy5AFxdkxIvB37M/@lizhi-Precision-Tower-5810>
References: <20241107-p3t1085-v1-0-9a76cb85673f@nxp.com>
 <20241108152856.000042ed@huawei.com>
 <e566ee56-523c-4cfd-999d-1cd9ca8eb7a6@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e566ee56-523c-4cfd-999d-1cd9ca8eb7a6@roeck-us.net>
X-ClientProxiedBy: BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: 40df34f8-fafe-4041-611b-08dd0014bc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VuP4FbkHUYSbAaTy9eMKgIUi/2udooT8wrt5yeXVynYLnFwcb/dpncT+GAaX?=
 =?us-ascii?Q?0mR93UxSXVYqL6MK4JPWti9o72oUFISsAMALhEc/oRajVPZThTv6fyYIzsrh?=
 =?us-ascii?Q?F0l1+Hsr2RcsevFStoogazE6rhNK6lkbEdIfjTxW2jtE32wa9oqSlJYshWBV?=
 =?us-ascii?Q?m2GOVAQnVyCaQoW4h7hVu7HdZ5ZkQKURfNx5ufIsV2KWbAMz8kFPxRutuVQS?=
 =?us-ascii?Q?YZcLfBGoNtagSovCIjnaH93aDUPnuPXPaFiR5PEI24jhLbOksTrV72gMsmoh?=
 =?us-ascii?Q?f4CTZM69YGSSUh9hdGURnZGiNjOh8iPaQ09eFg+FJHhrhDjTAHpKX687n7Ba?=
 =?us-ascii?Q?nzd68/4k9lCuJcjRFY7ywwJwSl7bujshhfg6CV6DEOA79uuRv1MaHFemuu67?=
 =?us-ascii?Q?5TLqZtSe3dZlFsR2OjaD2QCno1WvGBTu4jsWUfixnctfOKe2hCk1es8y2/dW?=
 =?us-ascii?Q?RT8bFdz/tmkC9K7v3Xzqo86OmZGSv3lVSVc1Qy2TOYxfIY661KtNvP3tk2Vj?=
 =?us-ascii?Q?ZyGFvrJCS359z0G2HgF2Ew+j/e5Q+QD7Lg3XluWrJwMfJ/QqrLJPzSReLSth?=
 =?us-ascii?Q?KxeU6KBye5Ykgu7LjD7gwArROGCcJ6qGThGcPOBh/mYwNPjRpUc2qTz/NvL9?=
 =?us-ascii?Q?Zyt/HGbnbuWD8mkHZWvzhlmshFjac011Fda6V7y9Z9z3r6Q4nJRVZiqlKMyb?=
 =?us-ascii?Q?K/5mJIosn2ynCErySFF2rm5Gknj8d/dGRI7b3eTPggGvVlrOlif/+d7x2X7T?=
 =?us-ascii?Q?xdiW73yUkcdKc+e/CAdtLBLHteYQ4l+ssDu6u82ruyKEyDKFuC80WMRS/kd5?=
 =?us-ascii?Q?C0RiGFPU1s0tT6qJcJ9WmsSDq4DHlHTX6XMBL8g7iYo7Esy4pY1LYPSql6lB?=
 =?us-ascii?Q?O8LN9y4mPAHazkicV7rAZLi8nhpG65xhxKN0i4byJ/wjFQbqwRk3OTBhKpxm?=
 =?us-ascii?Q?EqSUmqzeEeSvsEeNGz46ExaZ5RPfUATfvqOVmDDip4dPYFTa6+Y+iyfjbAXM?=
 =?us-ascii?Q?WjNaW27a4d+QYUzgXr0WdoHl0RmPWs67ueZxrFY7BUY0HdvTFQuoRrNRBGIZ?=
 =?us-ascii?Q?4+aBOtckKgY0v7DpeWRWI39zeLlCnwDuOkXLbS1sG2IQ6qp4u2xhRnShPAMm?=
 =?us-ascii?Q?wKQqCa3NkZb/agb/eqYsQpSMBL7qwHww6T2qZq9aN5LDmDuKUdyksKNgKJSa?=
 =?us-ascii?Q?/Or8cmyLzF1dkV5/5Zk5qSasvUlsaVFqvh9gBzeDj6p5UGQETs8sjnj5iJZY?=
 =?us-ascii?Q?2vHWI2nyfSgiQvvXzv6aXu/7B+jQnbVWzQdG8lIHfa1Po7y98eSg5uZVpunu?=
 =?us-ascii?Q?6Vem131wQzD9hzSD4F2Wxpj3CHtHLDBqxIZeyg+HvpXKYt+HHPupCnD2se7+?=
 =?us-ascii?Q?F/+IxPE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DHnp8/PClE6Y7+BZ4coJ2kHf9dFLlsuCcy84th4BIJdnQCjxqchvoP/VwzW+?=
 =?us-ascii?Q?OOZlWwietRFJp9TULKcck1JV8wI5K2HgD4zIpAu3U6VHg5Lc7LFp76wIrIpD?=
 =?us-ascii?Q?LxCzewLxJbiMjDZ07qCk6aSNx4s94xSWKUFk7XZWsxQEY8B3diwRG/XRiN2p?=
 =?us-ascii?Q?7ZjUEsgSDokvmNkBO4bE8JbaTtU55Uc5nnZVmQkSQvRqWhMgNt5cBXqHRsf8?=
 =?us-ascii?Q?tDabtJ9kz5ERS77tuMR8panRx84cwigZb8+X7f+CQxj1OgvwxUabL6dJDm3w?=
 =?us-ascii?Q?vNvbI6PFL2vM+2pvLZF8JNrCPKfcF95k0z9H0ZcV/ENdnXAKxYD6ME5+yoVN?=
 =?us-ascii?Q?4BiQwcHlU5YX8GYJ11Fu1Ly8bF79slAMjgAHqcordPGS89kppIcaUUe0XJBd?=
 =?us-ascii?Q?jOXyZu71h+Bj41CceroA/VTXy5tOsWij0RbdFDFW6ObvmKvSvVmbXMj1AnRB?=
 =?us-ascii?Q?u7+2llMcjfouwhTZxRA7ElBifdWXNayNs2fSTWBc1QJkY7rX7+FeWX3SXSUp?=
 =?us-ascii?Q?udAhgWMN4z3wCVsOieu5r9S8pJ7igo9Tig2cqMfKJ5ooRaDXTzlGhK0A+yp/?=
 =?us-ascii?Q?+dZOIW1o6MSxCqYT5uq4ZSFQxz3d7X6OURJXDdQKj+RvYW9QDoMy7DkOkWSX?=
 =?us-ascii?Q?M8Rq2QnWl7itQ0OPzlVsW/K1SWq95PmaYglP21VRs1oQhQSPUKIcYv/QApek?=
 =?us-ascii?Q?cgLnEYKqAgAOJyTYCzxpvi7tPV6hdKeZLKs37eh1u+WXPHcXN+W9j7IA/UmL?=
 =?us-ascii?Q?DvLmuKn4Vjmbhi+KQ4b6ZRnJeFci1NVie8sdOiW3LcmTEdvio7NWLqAwQXW1?=
 =?us-ascii?Q?3iGcnSbq3afPWWVxZAojpT1RN3hmXElE1RUrTP/71Fgsod8Yv30N8pWIgQZa?=
 =?us-ascii?Q?V8cU75K+SShaIjI3RVZAK/xzFifyFxiFQNgtuXf/elTGvXKzrMzcPTenttYN?=
 =?us-ascii?Q?MpjHtPVLNCWM7/6C5ktHrfKNMiUVch8DYXWEEZqcWCsIeuO+HXV4xBqhhlj7?=
 =?us-ascii?Q?d0YI4iQaaKtk4dDTcU5eF2DEh5vpsqxu6qQAxQWZ4jRaoa3Z2jVSVgnCaXY7?=
 =?us-ascii?Q?9yuqraVhTSfff4nomCjjWBXvobPGQ7C5xCUVLnqzZR+l/cHUaKC/hIg7DKT6?=
 =?us-ascii?Q?kG2bnzGsCp/2halYByNFX2kTEIFn3kvUiTUVLhLkHnTc97KyZxWY5N4+LUMo?=
 =?us-ascii?Q?r0jmHALgo6+dTRm6fjHBt3nVRPPN+PlWSYIX88bH7TcrDj6+OhIdTQIAVRuc?=
 =?us-ascii?Q?IcHxVm8hNAQidGeL+rtdhSOsqo503P1uP+shhe1V5qEsdXqU+dQFLzIb0Pq0?=
 =?us-ascii?Q?PIVO9meDXaCAKpeOsdPPwJVN92btTS0TkGyhyxNIEgEOvU15wudHFmRmRFoR?=
 =?us-ascii?Q?6IDsjYdQ4pThPphjK2P4moqZPjZCkasnZz7QrSc3/bJxnqBSwcSCXDAV9iAC?=
 =?us-ascii?Q?YvZ/BqSBNwn0DLpGo5mCt6hvheCTTz56YezoNSfe2tQnx9e/xp518VjxhU8S?=
 =?us-ascii?Q?UJDh3iw13dYrSyqeH6acqd0Knc6GWxZbqrwkPNHN7Lh5Pb+xx4U+0+a/xfFh?=
 =?us-ascii?Q?E9t/XusWKo53nJ6mcic=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40df34f8-fafe-4041-611b-08dd0014bc7e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 16:45:22.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqIiu3D7IILXGltPiA9cNAor1KBfxjlR7QL2DgK/HnhnqhMl5RGkWPDbk+pd1IzTDGd34/IFyxLvXSCpeGgnrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9681

On Fri, Nov 08, 2024 at 07:49:54AM -0800, Guenter Roeck wrote:
> On 11/8/24 07:28, Jonathan Cameron wrote:
> > On Thu, 07 Nov 2024 18:02:26 -0500
> > Frank Li <Frank.Li@nxp.com> wrote:
> >
> > > Add basic function support for P3T1085 temperature sensor.
> > > - Add binding doc trivial.yaml
> > > - Add basic read temperature driver
> > Hi Frank,
> >
> > For a simple temperature sensor the usual question is why IIO rather
> > than hwmon?
> >
>
> From looking into the datasheet, this is a chip which will be typically
> used for hardware monitoring.
>
> > Previous reasons have been:
> > - Very high performmance / accuracy part (i.e. expensive)
>
> 0.25 Hz ... 16 Hz sampling rate. No.
>
> > - Remote temperature so not typically hw monitoring.
>
> Local only.
>
> > - Same silicon with a more complex sensor (typically humidity or similar).
> >
> No.
>
> It looks like the I2C part of the chip is is compatible to TMP108, so
> another question would be why to implement a new driver in the first place.

Thanks, let me check TMP108.

Frank
>
> Guenter
>
>

