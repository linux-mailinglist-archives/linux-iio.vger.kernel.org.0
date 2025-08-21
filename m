Return-Path: <linux-iio+bounces-23082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DCAB2F099
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 10:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E90017E6C4
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 08:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8302E9722;
	Thu, 21 Aug 2025 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BC2Bjycq"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013062.outbound.protection.outlook.com [52.101.127.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1053F24DCF9;
	Thu, 21 Aug 2025 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763666; cv=fail; b=Gto2N0daecjtFW3CbPH5yHraJmzg85pKFM262CtS4s0t51lA8hDPFyVBzFYUm8H0+7efVvxJur5yqhg92wbLfLdkjDtPXNqLIDXZYaeGEMic5RjgBKVR4c/8+Axjd/yEyi96aa8AWryUKi1N0BNxvppHIdpxBknhGJGx2OyKbDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763666; c=relaxed/simple;
	bh=mNswIVViM7nibn+ntiOyvV60oarQqWJbUd1LjSVeb4Y=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RXNG1F3h/C5XzgyPL73frZzrRDIpHlVcimxoGVqCE//7SYvK0AHWA+ZFa4G4jDJXwoeS3MNlNF/thsD4iGQodMXZl2ObBgNxI85IPdIgTve2uPPdz7WrWb1j/iQoNNMHEMkeRczy0pJ9OJis1pZlT3oinQFyOsMog6bEITDfTAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BC2Bjycq; arc=fail smtp.client-ip=52.101.127.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DE02HkwDCS5l6Fsm7AJlZwvRhUHdGm5VvYmhWrBjLn1e/T6pOhXwYRvBNVjNXN+kJm6a29d3WqhJ/Ze4fR/D/kpvLpQueZCWti4qtrXuSdLHYBvC5QUv/UyYQoCcHYYbRmWhnwJqACa4yvTfDMz8ziKqNd2O8nbX5XeoyA1VWJIY9CpjKq1dbNO8pQRrCRtTs+pwDbV94VVTyzvA9qJf77BFZUH7gG8XNlabaNjtWJ9lcSiyC1MKgkTJYGP6KzCb4Cz+kB6/NQk8rtxK/JQBCm3UWwUwOudiFFUjCCRQ4SFAXWyaB9EQgZis6d4KOc2WNp1hEqLM09B2F4fCL2uv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDBq7ts4Aa2+P3c6upNyukXvuuAeh7oYP6MMc2MPggM=;
 b=b/yAauY/7ShhFrmV4d28JEsZX30yAsFZlaRc6GyiPrb0IykIYBIQBIgWNAaWraxvBbaxWMNxNDJAzOlDm0q3xpjcoPruyf7CqLebEAJRSV/yXwnLPVUIPoYA+MbUMC5vrXGY6xcNkT4MSOjC0KzYF+f8BRxQrZ9o1wZdNZcyS4i7VG1Nf1Y4yZnaAJo/kAAAT/v5T83s6GAlKSpocUVHLBW7/M9aRDW3omAckR2p5MRWZl0XmMXcpIohK/YriYW2KL5NYNXc4hpi9JsQZqq0cQI+5v6NdE1uO2i7ZFmZXN8K30SLZYDNjN0QTsC//ZGUxSJXkbyif7R+23nx1YwhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDBq7ts4Aa2+P3c6upNyukXvuuAeh7oYP6MMc2MPggM=;
 b=BC2Bjycql56jHW0mRzqzdlM/TG7jpTAC3En/BO1S8u6lOyJYqJbxVlpJ6F1ILLx6VvJT09Iv8s347pOUGCmR31MHM9peK44oZrwWiSESWFLhYKTHV2UOXQY8wHpXnetxJQsx220MgTDDAPyvlNqlcaLtfTSTHjDVqENfNu3jZOAWI8hTf+mb2+zcvtu/IML/FKaY03dXenp+7zWuT1DKdhzNNNhNcQPEgBwOqgvrz9iqd30HNUgG+649Q9fX6o6hLAAzW+KeSBBcFKYODk/wCiJ0o4Uh8jFM9GfwQxJc7R+FCXwpnsKUsLs0b1pu5Ut3bzzduNdwMr1sYHRRo8k4wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB6598.apcprd06.prod.outlook.com (2603:1096:101:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 08:07:39 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 08:07:38 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Haibo Chen <haibo.chen@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Francesco Dolcini <francesco@dolcini.it>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Crt Mori <cmo@melexis.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH 0/7] iio: Remove dev_err_probe() if error is -ENOMEM
Date: Thu, 21 Aug 2025 16:06:44 +0800
Message-Id: <20250821080723.525379-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::9) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5f3c3b-82cb-485b-4637-08dde089cb73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4dZeZ5IkhEg4GGvjCMw8sElf+L2UyzEweVtq12BaRQPYLTqPe4sk7x3/bg0u?=
 =?us-ascii?Q?ljcTD2umIqosoSMPrVLQpOagAmqHYRZHrz7fiSAW75JYXGpJW2/7WqY6JqXh?=
 =?us-ascii?Q?zyEmPSmgEbx2XI/LjDbWzpqEPyEtSxQjV1bhQN7iVVdt0rM1QTyaQQGBivLX?=
 =?us-ascii?Q?oF1eK/v+uwNskPAaHRc7FColxnpTwfSXBQUm+YtKytF7Bkozvlruhaym8rq9?=
 =?us-ascii?Q?i4H6pmbTCrdMfskFyQwWyxssdwKCSjrpBNxT656j3PoOMRHdmKuby8XUlDuD?=
 =?us-ascii?Q?4jK2fhaDAz+AqAgxO9MyKfUuCPTGrQMEXALZncMTlMKfrsVP4g4ryxRzxw+3?=
 =?us-ascii?Q?LBeMivCxyEwQbQXqJ7cZQvcmkB06bev2epmb41660qe1z/ekdfX3IKWVNFmF?=
 =?us-ascii?Q?pr0lF0OcRmr9PIVEkbON4T7GUIowb2JDW6kzR5EX05ddDa/E63vHKWxTACVn?=
 =?us-ascii?Q?5jbABMLFkdhvyIvEyV69KMYHbFZvC+50rJ5SsxtnsCOutB02NEL3WJGUbuQJ?=
 =?us-ascii?Q?oK2FPeWmVopoMrJc3RCrABboKBGgsshwI7xROfFs42F2YGoX1XcaV/pjw5ZH?=
 =?us-ascii?Q?IPRMa4l7BBEdAPNVuB+/7R1bzYurxtc9F7YhADeq0eDGAvB0v5NaCApbQplh?=
 =?us-ascii?Q?87QMKrH7g7TjqV+JyhX1Iv6Fxu5gzMUqpW5nyG5q+FDrEZqVKALnDB/U+eeR?=
 =?us-ascii?Q?vgl2bipQmMgwHrc9cyVxLXpaJGtem5BKiEYmFrqQ8EinOmd+F6tHMZvxc/GH?=
 =?us-ascii?Q?LE3EHQ5K8EEWW+mHs6OcC8QGxMuZf71O5B3EWhtHuLdxwnB0d92DcctfeFM/?=
 =?us-ascii?Q?3mE8Dmc7n0QR6i05KG8d0kOGxy/4y2Fmgk9th5XI7LiXXD3M+TJ1p4lWR9bG?=
 =?us-ascii?Q?YHx9AashhVelUzXWd4n1ljOt3vTZekV/hZmbUwRSt0oPVYb9s0t7Tn/6XGNU?=
 =?us-ascii?Q?8piHn6GYJ4Qnw9BIPPOFS4RdFvsWBqfj5jOvtalq4DLR1L9rHqWbHBHJe3EX?=
 =?us-ascii?Q?58TGHtpYfxTXGyinmGqsHgBLPP8smvCzBhXMT1y1rcmGbC9n4eZJjt8QCZoS?=
 =?us-ascii?Q?ydd0tADtgHV95ojdUp4OOrw4oVb8g3zhLVlYYrIApIOP1iB92It1lK3y5qjG?=
 =?us-ascii?Q?LMRte7mVHWlGJKjnXDt1MXlHRCS8/Wh7MWdFDMr3ZisyPkaPaeo4iWjhIKSm?=
 =?us-ascii?Q?4HUa94QWvNDPpK3qVztQUl0n0TbtVa6GyQBj2MNq9ThA7FRd8KzBlF/lZICn?=
 =?us-ascii?Q?YkykQz60tbS+VBzW5UkJF+UOEN/GTQTAzk1YFhKTgIhU8BjS9LLdNKeKSPMk?=
 =?us-ascii?Q?4c7VpVdggt+t1zUf2nro54zYyKWn81WUEgFnwQZMoPug/iGjtlVEwdaLiC9k?=
 =?us-ascii?Q?QEW5hZ+B3h41IWr35G9t/f4uhp+r3rQ41h6Nb1YMrK7njE4mRjYAvGIIkNLZ?=
 =?us-ascii?Q?v8zUi7OVaIaWvL184h9Y8IbuWgY8JAaYvFpSe0Va7ndpYKbWOfnnzUv8s7OK?=
 =?us-ascii?Q?kq0/gfISTIv5Pko=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zi6CBwhCdh8TNaTIw+IlnPt2i0BIXMZM8GtI5SK56zlReidRtUNxeXKKVWuA?=
 =?us-ascii?Q?4pd4Wl0E5WSVegWst4yAmIld/XgAjiDFRVIKS74VyHAl9jnVlvWorj/RoK19?=
 =?us-ascii?Q?KteLyQ6IjsVFcdZqyZ+FhRbfZcDJiOB40TMPSP6maIinVdqI8NWZxVsPIaOW?=
 =?us-ascii?Q?6ljX0xn+YmqXnbP71QjR+/9z2tPFgwxKgGLTre1cVn4CPABmR4FMtnyg8Vw5?=
 =?us-ascii?Q?fdxWqlUS0ZZz5b6BX8NedoEwMiraDybVKO9sKdIZPUkG0M7kpeXe+mWdj7Fy?=
 =?us-ascii?Q?bZpKrP203y0/vhHaTgGTQL115q86YBKFiK9+l9XHTC159qAg31/B2Jl4zZtm?=
 =?us-ascii?Q?z8Alpog+sgudK6BTe69y3/R/0Mtqk7dRJmCLS6I5K/W/UsFJWzLO4NmKqJ36?=
 =?us-ascii?Q?+G5vMVcWKsam2tIq4W4y1wzV6VEHE4dT+CohoXS5nZYQg2PFI0YtBJHsRfyr?=
 =?us-ascii?Q?J2N/Rh7gxHD7i8DygprtpXsh6SjPY/XKZgnYXLB30BrVUkUucXf/tTL5K5Cl?=
 =?us-ascii?Q?TLxXByYHsmSjZbx0h00VARYZfcD86xV935zbOPjZXe7+lPVkwq5wRZ63jdt/?=
 =?us-ascii?Q?PuoqxaXGQmWVbapWRDDaua/ER8FAE4ADfoTUQETqo9znsQx3DwcSHreNw3fv?=
 =?us-ascii?Q?oyqwC7LALfPXepkojSakUbKZGZmmhu7wbScBmqAT9v5TKYFQcdWp032y1NcR?=
 =?us-ascii?Q?8l2YIu3Ac/9DJGlrDwn0d8YSpvr8qVqhrIvnOu191vaNHVXMJWfam75zkAvR?=
 =?us-ascii?Q?0HLJkKkK1B2ampIF5hV+eE0XXmAccrbFInq1NXzWXQPZ9PCN9wQA2uuUqGZI?=
 =?us-ascii?Q?eOm/WzftiKPxtjMSaDdQGr54uHSexKKYtp/Fxrv9Pd1vXqmRv+qiVH+Az3J5?=
 =?us-ascii?Q?Xa4gYqFGdgikQEXowY9x2SNy6veMNlz6y4CsXVorbx4tW1++se3PT+fKzgCj?=
 =?us-ascii?Q?NeqZBFxRHS4cqpBMtRoegtdPRkTimwwzcTay4KEa9X3VC5yUHQRxuiUHACds?=
 =?us-ascii?Q?XrsnYFovSH2LerHKrRdm7EAxfbOQazzD+MjUym68cF843KbrqqiRfJCmluri?=
 =?us-ascii?Q?UI6q3eL+B4xSQpG1JI7JVsBeprgVjnKN81iVcYWdBOqzXf/eX14TH3bPP244?=
 =?us-ascii?Q?5LedpHo7KCx6dFwcL664ABXzDWD3Sx/x5nvg+2S1prOxvM+ZEzQzSgATZQei?=
 =?us-ascii?Q?mXMibPopa6mALkLi/D1jl4sjSunkFp2He/oRNgb193e2FmjUhsAhhwxYiyZ4?=
 =?us-ascii?Q?E8CuExav4L8d/SrS15l+aUjrk80J1eTMkYOLQJpq59dvw8IagI/boFJiNdFA?=
 =?us-ascii?Q?YGSTZSHOj5ahGe6ELmQDuB6tDWjpPWIDveAOGVWQWW60pn1oYmHizu1I9lhi?=
 =?us-ascii?Q?NQPvL7CN6oF6aEQuREkKo9hUO5w9ger5D3ifwERfDm8gGKzVI+COg/mw+Sck?=
 =?us-ascii?Q?8LhRYeNk/LXgrxrEstg0ASQxnnS1WLHmqE2y6xS65bnO+tjHlYzGxDh2N5l/?=
 =?us-ascii?Q?Q3Y3jfJrNkDJCV9DT2nJo9Y2EwG0RP+1hoR3Vxyfe3OfcvE+2xND/IhmC7rW?=
 =?us-ascii?Q?S5OuD0uFofYVWNA2TXIrS3bZ6FgK1f+damBlmOas?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5f3c3b-82cb-485b-4637-08dde089cb73
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:07:38.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GK92CaqbdrujQat5X1Y/8B8xHp79Q/v3hAOXRDmlZ56GkvMvG96NvlnFPpnMqOjAFKzJ5+soXN9mrass7dVtmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6598

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Xichao Zhao (7):
  iio: accel: msa311: Remove dev_err_probe() if error is -ENOMEM
  iio: adc: Remove dev_err_probe() if error is -ENOMEM
  iio: chemical: Remove dev_err_probe() if error is -ENOMEM
  iio: imu: bmi323: Remove dev_err_probe() if error is -ENOMEM
  iio: light: Remove dev_err_probe() if error is -ENOMEM
  iio: proximity: Remove dev_err_probe() if error is -ENOMEM
  iio: temperature: mlx90635: Remove dev_err_probe() if error is -ENOMEM

 drivers/iio/accel/msa311.c           | 8 +++-----
 drivers/iio/adc/hx711.c              | 2 +-
 drivers/iio/adc/imx93_adc.c          | 3 +--
 drivers/iio/adc/mcp3564.c            | 2 +-
 drivers/iio/adc/meson_saradc.c       | 2 +-
 drivers/iio/adc/rockchip_saradc.c    | 3 +--
 drivers/iio/adc/spear_adc.c          | 3 +--
 drivers/iio/adc/ti-ads1119.c         | 6 ++----
 drivers/iio/adc/ti-ads7924.c         | 3 +--
 drivers/iio/adc/vf610_adc.c          | 2 +-
 drivers/iio/chemical/ens160_core.c   | 3 +--
 drivers/iio/chemical/scd30_core.c    | 2 +-
 drivers/iio/imu/bmi323/bmi323_core.c | 3 +--
 drivers/iio/light/opt4060.c          | 2 +-
 drivers/iio/light/veml6040.c         | 3 +--
 drivers/iio/proximity/d3323aa.c      | 3 +--
 drivers/iio/proximity/hx9023s.c      | 3 +--
 drivers/iio/proximity/irsd200.c      | 6 ++----
 drivers/iio/temperature/mlx90635.c   | 2 +-
 19 files changed, 23 insertions(+), 38 deletions(-)

-- 
2.34.1


