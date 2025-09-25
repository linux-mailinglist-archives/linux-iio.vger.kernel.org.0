Return-Path: <linux-iio+bounces-24426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECD7B9D5FF
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 06:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3387D1898638
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 04:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80EB22F75C;
	Thu, 25 Sep 2025 04:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BifqFWL1"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578DD134AB
	for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 04:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758774001; cv=fail; b=e23bhG/0lBOUaRzJEZnSUvJTvcXS3bY6fuwdHkibaL2MY+sFXPEjAagMwtbMpX9aw2q5fhWehZH3Qy4q1SbHYl9lCiopOBr010tq0Z9zMTZIoG+TBvnsJFgTTflQFqkzPylBYhHHlNHnMn4X26MXcpjPDg5NpJxnaPIMRs3rQXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758774001; c=relaxed/simple;
	bh=8XeYL0RYxS5TUP7Uy5WljGMZcdUp6pd6sKccG+OtDnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QgjKnuk9YD3Ua1AHViT813llhhfHn3QNKQ3fuBeBbIsEY66qrQ15N+rZRwOKostMFZkTW89qOH7NJ62yZNPEKGWS7RJCgGcLIGknOYxjuvZDjBb/b2P4BXU1Pu8tOZNfGqOnS0KwZrXKQB6YqX5Bcfa6Wyinc1d8zMDSmwCvPUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BifqFWL1; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsDVjQH/iQE4e8Uhx7yDsN8ukXcuj0SX2KFjP7I20HoDQ/Ade+vnOVzaJibOpt0wL5Hft4mwKiXTBZ8v9zZ4T2c9e/Py8bnWoeK7IX8aFRrxVo64lN3uJsetR6Uwhr2SaNR31V1yrsnppdKZbUfgmPSGMRQuaSpgvt5TmmKJyCUqWbbM0yLmWkFWcxRBnoZqIPnC7zs0I0qM3K2UBBe1uE4w5RliUFFADOR1QHCj5RWO81OFxheqNPSathWm8IRTkxUEJ6qRMYE1KKKq7zhZKjc92vzeqGf0IG2ua7NwT0FCEuqnOQi4ca8sDnLOpLImcGOqk+n72SsI7Wdqm60uGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbq1E6ZdVt7XmQ1DvJw7k2Ymp51uRotSy8ZF/HlEFkQ=;
 b=Fd2XCL8Fu8Sgv8HUTjuPGPRYxjAQSG12vZV3CbSYWH0rlDKiuKeg1Wq453NYQjBqHof6MwE056Md0HRZVkwbi7oOsIf6w70anjhe0lMs4Mipa66yDLAIooqnwoIVXyBT7LW6GhomFTnqF27Vmm7qQQSVAHnFNjTFbTEAmCMd1VLFyDJCJnMt2NNyZNKAdBXQZwC88LzbyUMmA5N6P2YSBKnaV13qvSd9o5Ovo/2n1ptta6gZv78BoXZW0zRmtl6WwP/PsZCw1SRx3tplpy42gLqy/Z7t41FZii1d1BQcg9tI3b8Hv5UvTy7OZ1v+UNQGJAmQWwWiE4nOrhv4qZPbfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbq1E6ZdVt7XmQ1DvJw7k2Ymp51uRotSy8ZF/HlEFkQ=;
 b=BifqFWL1mW769qggyPLRYV2GM9j2ErmDax7MnjzHLEwMvftnMPYtkNudITsyoivC4WR6OEdozU7LBd13byq5oIT9MkT4lbTA20x3CHDf1cIW8LQCkkQ9ciEZME+Qau6TCXrgUWe8jFc5vP16s2UFC4EWoYMR2SwLMLvTUogWK313H5GtZiJuq3B9aIcTumltLXJVl8H1GEfNJTzAlHzGi/kOKsKEs8ot42tF2FEwwLpR/rerGZ4u20ImsJfgm+CZsfdSFcNAaYZ4VNYaMj7Ce6X9sGJGkyjxR+Lcp31RcMK82QJvsYZyHrtRkX0RxkaauJ8+eAVrpysyZ6qkL+D/Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB10229.eurprd04.prod.outlook.com (2603:10a6:800:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 04:19:51 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 04:19:51 +0000
Date: Thu, 25 Sep 2025 00:19:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Adrian Fluturel <fluturel.adrian@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aNTC4QepfAwvkTev@lizhi-Precision-Tower-5810>
References: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
 <20250924-i3c_ddr-v2-4-682a0eb32572@nxp.com>
 <aNRhBw2lKgsvEEDL@flu-Virtual-Machine>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNRhBw2lKgsvEEDL@flu-Virtual-Machine>
X-ClientProxiedBy: PH5P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::7) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI0PR04MB10229:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b2dfa2-713d-4563-b75a-08ddfbeac58f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?04qDzRqt9qr728fuSGZd6o+Qy43TG844mr/rRWAGchibK4oQ1uMxTp35PW5J?=
 =?us-ascii?Q?HIyfrjvucls7hr2RNml5NfJUUn74f5XOWAsSmhQn00r9pFg/KmCn7yLPxp4m?=
 =?us-ascii?Q?lQL868K4f6ATft/LMyhIKy6qJqafBRxZb1a4B3IaSvfR2bTcE5tw6il+8CCA?=
 =?us-ascii?Q?X0VegczaN//ug1bLtTLa0PmYMT49avY9KYOKkvw+ahQNAOlaohEn6PM6hJXv?=
 =?us-ascii?Q?egxhpi2maIXWwSLTsvTahqs1LNtHVCsI35xNZXg3bKfeP2pN3uC1FaGq3vnY?=
 =?us-ascii?Q?ShAPNsjjDD0P0iOkVvNnLqH+lmzqcTgBRYB0GKASClMkH2Wa4P4PhTCIEOE4?=
 =?us-ascii?Q?3bmIAqQ/RrXnVQXTfSCkk+3/KkhzwNB6DMeM6SX2UxolcQHIOQ0hh7bHOus0?=
 =?us-ascii?Q?At7xO/jMuRHMiIPn2sSodjIFYZ5YE4rw65MoIKbsxv1fHJP8YeKEIFQUqF6Q?=
 =?us-ascii?Q?4j0vvRxxYyPu5bE7kcP08P1mIvJFqjpY9KlRDQYknbiIkO2fZkTSUqzNekz6?=
 =?us-ascii?Q?TMX0MnMp0qCdqBHj+6g6wsu7IkiCtuvMIflX+L6nO+B9+SFqUMumqf+F6HgH?=
 =?us-ascii?Q?cug6ALJun3Th4SOLN2/C+zISyJlQsqV3Gd8Wb+NrdWsL2Z76hHZArduYaLWW?=
 =?us-ascii?Q?wia7XVCERTz/wySK0W1/VOUQ3dlLUic9kwAh4C/qnjmCXPH975vfG3oMonoq?=
 =?us-ascii?Q?WXvaxRPw9ggfT6bXa/I4Xd7j1kMaNoWhOBmbZ6IjHNI8/zjS70aTdzN8SXp3?=
 =?us-ascii?Q?OW8SVZjY2HzJzMOo8gs++SqC/XDLREKfNGMeLdZCXjf27qVxLQsOimXAjoDt?=
 =?us-ascii?Q?BDsvcgQj1r/Sc0MWLV6lge7B62DpvEQ3V7rVN0/LfW3ZpL8fnSuDt1Dzh+oK?=
 =?us-ascii?Q?yvqygc5pJq7g+uQgOItcUZVMeLva8l97chtLjs7PDbLd/BLcRm0awcorPgX3?=
 =?us-ascii?Q?ZPQh+XPZ65HIOEF4JgSNmyigQ9I9R/Xh0w6RxXvYxSssNiatyTwJbDl0WgIl?=
 =?us-ascii?Q?CXhn5Ol3KxtRd7BWrx+rOSRDoRHSwYzckCw53fTs2lBny99z3uX2jF1XBETc?=
 =?us-ascii?Q?KWKh9Vaff1RtQcSBgoX82NwUZfSaikTtNx0Y3ePoaVEtWyXq4Z1/maMaWitW?=
 =?us-ascii?Q?K70ay40p+glpyvZWmP4nh8b+r7l5IlrEh+tFQrh2J9RCSlpEn3aaG6BCg/F1?=
 =?us-ascii?Q?mX+cxzAvg8Tfo/rQUYseykzYgUm45m9wV7UdMQDpT4ICdtnh/+FvIgrmmZTC?=
 =?us-ascii?Q?+F3iYMUDJr2Of9tnSyK6bwOxycTJ1Vg/dGTRIcQM/iYh5ZNZr2WB/csLaFBi?=
 =?us-ascii?Q?/nyhzFlyigUPqXByunL2wL7mOcrpl8Cw4z50pu6TpZRPAfwzNzIWoUN8wvpt?=
 =?us-ascii?Q?4vfc0LqUqnQGK2UHNh3fiXfQpSpVB/1xFEcimBbpBpRa+h5sCJYEk3BxZHP6?=
 =?us-ascii?Q?iZpdPUPTx/DUM5kWCYtxU8y8EXmZEIX+gL4OHZx16Ha5k0QEzyDTdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UqiM/NcN9CRIY6Lr6KjQs/MnR7GOKN2m3j35pRmO5gU/PU9ICe0dWvwdzix4?=
 =?us-ascii?Q?hQ6l5EVgNUGdtMQKenOfPY9lOzMXJUikhcH9LtR1c/aOdJei2LcJB1dPNy76?=
 =?us-ascii?Q?dOxPfXq0KhPFI/t+NNed+nNLLLWvjhrbGtySBeN2iT1bBXHspODVgtVek+vg?=
 =?us-ascii?Q?V86x2TOzh4vF8BwPnRc8yiUCMsTH1xtzK4HZPhnB/OW6QxmTHBCt3RlCaH5E?=
 =?us-ascii?Q?6AOlYFXhX0Z5jyVy47B4KNhmU0AzPAuj+dac7q8fnazbn2xjwvb+3To0Dk1Z?=
 =?us-ascii?Q?E3CmobiYrSJIcQc87mLEc8iCz0Rdx3nCu0nTdUT1hJXZot0GXA4yjuf/neBt?=
 =?us-ascii?Q?qTH6eN0NFmXur61q0pCwtFdh7EErgJ9Fh0FO/bH5L9T3hW2n/R/2WUDCarHm?=
 =?us-ascii?Q?M6CYHtkcvaWPtQTbQoqMwEo3LWW8Xs+8Xprk3Zs7hGtY49xHvrwQlRaOcO96?=
 =?us-ascii?Q?X0VZHYqKA6GA4/U5jzcVLBLBFZrMgcRtTfaXHKb5U+WXFJiPSPgrTZAPuTx1?=
 =?us-ascii?Q?WEuEAqGW9G3ff6zd3cZUzEfAsuBTxcKiT2vZMJW2n4v3DS74njS+tpvh4oDZ?=
 =?us-ascii?Q?vditzUSi3IR1anyJNuZ0Kdz+4zWDoCQO0VUBro4CmU0XlUbfMilE/2/acaoy?=
 =?us-ascii?Q?ftlnQIM1w2yHshCC0PgJMR/7tnMdDmu2OHDM5Z82U8iOmafNCuwTaKJTdTP5?=
 =?us-ascii?Q?iIvjA6U5U84X+//p8kiE486U1tN/Gm7I4Pb9JYHsXp0j8DTVA4bn7MF2VOly?=
 =?us-ascii?Q?ZSBSKagYOa2aMcVGsXZ6yq/gU/SbYhCE0nWiEY+pzIB3RVVvO9x94M+EB8uE?=
 =?us-ascii?Q?hYkpm2nmIGlKaX2wqYFP6+KJ2JsD2eWloxXBgzoJTa9K0Jz30S9IdNhxEnTr?=
 =?us-ascii?Q?Df8N4KwxOGiYWBMxsjkfILFWhVjJSjmsl0NmwNj0/MOKhlNhBLR8bMJkBwT8?=
 =?us-ascii?Q?2CkU783d90c+wlMcKojnVn82sPNW2aGa9MD3ayrGNub0Lp7ycB+Vm4vlHh1Q?=
 =?us-ascii?Q?JVVLUAk6QmtRhWkBFdpPcRAc/jg+5Mraxm2vNA3W5X7NEFahDDRCodbK3Bvk?=
 =?us-ascii?Q?jkxp/+oshZ1X1OZSlVxbIWBExqWCOFKccAr6oB8j25HVjRGAvnj7Iukn+a4Y?=
 =?us-ascii?Q?HPUyjOzA/XLtSkQHjFEQQKWj7aTJ+3sPxSJTjXjgWBfVZa6XE71o3sugQJGM?=
 =?us-ascii?Q?FB2Mo9XR63M7eronKEDkKI0L7/k/Nk4je6K/t6xrdna01O4IQk9DZBdmmXWE?=
 =?us-ascii?Q?gzCa7uZtMNcFuWoTgz4q6jstWZAacTjtU1yzdqUsapt2Y1EXBWz1xF8wDBYT?=
 =?us-ascii?Q?MorQ1hApOTi4vyFi6DdfzQKEd6cx7qGjQomslkS7U94gOlXf8V4zRg3jPLkw?=
 =?us-ascii?Q?6Z2bCSe8PRccB8FfIal+f9kkGOe+Nw48tEir2nSKNVOFhvDcZZmXzFf9BNTa?=
 =?us-ascii?Q?G5wtwegi2afbN815JvUuiWbbg3bH9gs5Z/M2SqDau5uCGWVj6EtYJDmRhDrS?=
 =?us-ascii?Q?bNgusxNvsCx/0wmc056ALjVWiKlc6iyijSiyiLbv0TIuxvA9Y7UJBr2/8gzJ?=
 =?us-ascii?Q?/szUKfHExzbWITvVK3uwbS2D2ofxUX8Q/IZTr3yc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b2dfa2-713d-4563-b75a-08ddfbeac58f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 04:19:51.5408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4I6iPfQE9CGDDwa/tBQeIiEmW6P2GxuOP5lZY4rgG7U3ccEl5fjh7z5x2o9sOKenHybr1PwxHUM+GHmxti+/fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10229

On Wed, Sep 24, 2025 at 11:22:15PM +0200, Adrian Fluturel wrote:
> On Wed, Sep 24, 2025 at 10:30:05AM -0400, Frank Li wrote:
> > Add mmc5633 sensor basic support.
> > - Support read 20 bits X/Y/Z magnetic.
> > - Support I3C HDR mode to send start measurememt command.
> > - Support I3C HDR mode to read all sensors data by one command.
> >
> > Co-developed-by: Carlos Song <carlos.song@nxp.com>
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change in v2
> > - new patch
> > ---
> >  drivers/iio/magnetometer/Kconfig   |  12 +
> >  drivers/iio/magnetometer/Makefile  |   1 +
> >  drivers/iio/magnetometer/mmc5633.c | 543 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 556 insertions(+)
> >
> > diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> > index 81b812a29044e2b0b9ff84889c21aa3ebc20be35..cfb74a4a083630678a1db1132a14264de451a31a 100644
> > --- a/drivers/iio/magnetometer/Kconfig
> > +++ b/drivers/iio/magnetometer/Kconfig
> > @@ -139,6 +139,18 @@ config MMC35240
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called mmc35240.
> >
> > +config MMC5633
> > +	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
> > +	select REGMAP_I2C
> > +	select REGMAP_I3C
> > +	depends on I2C || I3C
> > +	help
> > +	  Say yes here to build support for the MEMSIC MMC5633 3-axis
> > +	  magnetic sensor.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called mmc5633
> > +
> >  config IIO_ST_MAGN_3AXIS
> >  	tristate "STMicroelectronics magnetometers 3-Axis Driver"
> >  	depends on (I2C || SPI_MASTER) && SYSFS
> > diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> > index dfe970fcacb8664b293af84893f7d3e3e8d7bf7e..5bd227f8c1204bdd8b8a43da180833eedca1457b 100644
> > --- a/drivers/iio/magnetometer/Makefile
> > +++ b/drivers/iio/magnetometer/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
> >  obj-$(CONFIG_MAG3110)	+= mag3110.o
> >  obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
> >  obj-$(CONFIG_MMC35240)	+= mmc35240.o
> > +obj-$(CONFIG_MMC5633)	+= mmc5633.o
> >
> >  obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
> >  st_magn-y := st_magn_core.o
> > diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..b1a6973ea175634bbc2247ff84488ea5393eba0e
> > --- /dev/null
> > +++ b/drivers/iio/magnetometer/mmc5633.c
> > @@ -0,0 +1,543 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * MMC5633 - MEMSIC 3-axis Magnetic Sensor
> > + *
> > + * Copyright (c) 2015, Intel Corporation.
> > + * Copyright (c) 2025, NXP
> > + *
> > + * IIO driver for MMC5633, base on mmc35240.c
> > + *
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/i3c/device.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/init.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/pm.h>
> > +#include <linux/regmap.h>
> > +
> > +#define MMC5633_REG_XOUT_L	0x00
> > +#define MMC5633_REG_XOUT_H	0x01
> > +#define MMC5633_REG_YOUT_L	0x02
> > +#define MMC5633_REG_YOUT_H	0x03
> > +#define MMC5633_REG_ZOUT_L	0x04
> > +#define MMC5633_REG_ZOUT_H	0x05
> > +#define MMC5633_REG_XOUT_2	0x06
> > +#define MMC5633_REG_YOUT_2	0x07
> > +#define MMC5633_REG_ZOUT_2	0x08
> > +
> > +#define MMC5633_REG_STATUS1	0x18
> > +#define MMC5633_REG_STATUS0	0x19
> > +#define MMC5633_REG_CTRL0	0x1b
> > +#define MMC5633_REG_CTRL1	0x1c
> > +#define MMC5633_REG_CTRL2	0x1d
> > +
> > +#define MMC5633_REG_ID		0x39
> > +
> > +#define MMC5633_STATUS1_MEAS_M_DONE_BIT	BIT(6)
> > +
> > +#define MMC5633_CTRL0_CMM_FREQ_EN	BIT(7)
> > +#define MMC5633_CTRL0_AUTO_ST_EN	BIT(6)
> > +#define MMC5633_CTRL0_AUTO_SR_EN	BIT(5)
> > +#define MMC5633_CTRL0_RESET		BIT(4)
> > +#define MMC5633_CTRL0_SET		BIT(3)
> > +#define MMC5633_CTRL0_MEAS_T		BIT(1)
> > +#define MMC5633_CTRL0_MEAS_M		BIT(0)
> > +
> > +#define MMC5633_CTRL1_BW0_BIT		BIT(0)
> > +#define MMC5633_CTRL1_BW1_BIT		BIT(1)
> > +
> > +#define MMC5633_CTRL1_BW_MASK		(MMC5633_CTRL1_BW0_BIT | \
> > +					 MMC5633_CTRL1_BW1_BIT)
> > +
> > +#define MMC5633_WAIT_CHARGE_PUMP	50000	/* us */
> > +#define MMC5633_WAIT_SET_RESET		1000	/* us */
> > +
> > +#define MMC5633_HDR_CTRL0_MEAS_M	0x01
> > +#define MMC5633_HDR_CTRL0_MEAS_T	0x03
> > +#define MMC5633_HDR_CTRL0_SET		0X05
> > +#define MMC5633_HDR_CTRL0_RESET		0x07
> > +
> > +enum mmc5633_axis {
> > +	AXIS_X,
> > +	AXIS_Y,
> > +	AXIS_Z,
> > +};
> > +
> > +struct mmc5633_data {
> > +	struct device *dev;
> > +	struct i3c_device *i3cdev;
> > +	struct mutex mutex; /* protect to finish one whole measurement */
> > +	struct regmap *regmap;
> > +};
> > +
> > +static const struct {
> > +	int val;
> > +	int val2;
> > +} mmc5633_samp_freq[] = { {1, 200000},
> > +			  {2, 0},
> > +			  {3, 500000},
> > +			  {6, 600000},
> > +			};
> > +
> > +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1.2 2.0 3.5 6.6");
> > +
> > +#define MMC5633_CHANNEL(_axis) { \
> > +	.type = IIO_MAGN, \
> > +	.modified = 1, \
> > +	.channel2 = IIO_MOD_ ## _axis, \
> > +	.address = AXIS_ ## _axis, \
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> > +				    BIT(IIO_CHAN_INFO_SCALE), \
> > +}
> > +
> > +static const struct iio_chan_spec mmc5633_channels[] = {
> > +	MMC5633_CHANNEL(X),
> > +	MMC5633_CHANNEL(Y),
> > +	MMC5633_CHANNEL(Z),
> > +};
> > +
> > +static struct attribute *mmc5633_attributes[] = {
> > +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group mmc5633_attribute_group = {
> > +	.attrs = mmc5633_attributes,
> > +};
> > +
> > +static int mmc5633_get_samp_freq_index(struct mmc5633_data *data,
> > +				       int val, int val2)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(mmc5633_samp_freq); i++)
> > +		if (mmc5633_samp_freq[i].val == val &&
> > +		    mmc5633_samp_freq[i].val2 == val2)
> > +			return i;
> > +	return -EINVAL;
> > +}
> > +
> > +static int mmc5633_hw_set(struct mmc5633_data *data, bool set)
> > +{
> > +	u8 coil_bit;
> > +
> > +	if (set)
> > +		coil_bit = MMC5633_CTRL0_SET;
> > +	else
> > +		coil_bit = MMC5633_CTRL0_RESET;
> > +
> > +	return regmap_write(data->regmap, MMC5633_REG_CTRL0, coil_bit);
> > +}
> > +
> > +static int mmc5633_init(struct mmc5633_data *data)
> > +{
> > +	unsigned int reg_id, ret;
> > +
> > +	ret = regmap_read(data->regmap, MMC5633_REG_ID, &reg_id);
> > +	if (ret < 0)
> > +		return dev_err_probe(data->dev, ret,
> > +				     "Error reading product id\n");
> > +
> > +	/*
> > +	 * make sure we restore sensor characteristics, by doing
> > +	 * a SET/RESET sequence, the axis polarity being naturally
> > +	 * aligned after RESET
> > +	 */
> > +	ret = mmc5633_hw_set(data, true);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	usleep_range(MMC5633_WAIT_SET_RESET, MMC5633_WAIT_SET_RESET + 1);
> > +
> > +	ret = mmc5633_hw_set(data, false);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* set default sampling frequency */
> > +	ret = regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
> > +				 MMC5633_CTRL1_BW_MASK,
> > +				 FIELD_PREP(MMC5633_CTRL1_BW_MASK, 0));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mmc5633_take_measurement(struct mmc5633_data *data)
> > +{
> > +	unsigned int reg_status;
> > +	int ret;
> > +
> > +	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_MEAS_M);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
> > +				       reg_status & MMC5633_STATUS1_MEAS_M_DONE_BIT,
> > +				       10000, 10000 * 100);
> > +
> > +	if (ret) {
> > +		dev_err(data->dev, "data not ready\n");
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mmc5633_read_measurement(struct mmc5633_data *data, void *buf, size_t sz)
> > +{
> > +	__le16 data_word;
> > +	__le16 status;
> > +	int ret, val;
> > +
> > +	if (data->i3cdev &&
> > +	    (i3c_device_get_supported_xfer_mode(data->i3cdev) & BIT(I3C_HDR_DDR))) {
> > +		struct i3c_xfer xfers_wr_cmd[] = {
> > +			{
> > +				.cmd = 0x3b,
> > +				.len = 2,
> > +				.data.out = &data_word,
> > +			}
> > +		};
> > +
> > +		struct i3c_xfer xfers_rd_sta_cmd[] = {
> > +			{
> > +				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
> > +				.len = 2,
> > +				.data.in = &status,
> > +			},
> > +		};
> > +
> > +		struct i3c_xfer xfers_rd_data_cmd[] = {
> > +			{
> > +				.cmd = 0x22 | BIT(7), /* RDLONG CMD */
> > +				.len = sz,
> > +				.data.in = buf,
> > +			},
> > +		};
> > +
> > +		data_word = cpu_to_le16(MMC5633_HDR_CTRL0_MEAS_M << 8);
> > +
> > +		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd, 1, I3C_HDR_DDR);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = read_poll_timeout(i3c_device_do_xfers, val,
> > +					val ||
> > +					(le16_to_cpu(status) & MMC5633_STATUS1_MEAS_M_DONE_BIT),
> > +					10000, 10000 * 100, 0,
> > +					data->i3cdev, xfers_rd_sta_cmd, 1, I3C_HDR_DDR);
> > +
> > +		if (ret || val) {
> > +			dev_err(data->dev, "data not ready\n");
> > +			return -EIO;
> > +		}
> > +
> > +		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd, 1, I3C_HDR_DDR);
> > +	}
> > +
> > +	/* Fallback to use SDR/I2C mode */
> > +	ret = mmc5633_take_measurement(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT_L, buf, sz);
> > +}
> > +
> > +static int mmc5633_get_raw(struct mmc5633_data *data, int index, unsigned char *buf, int *val)
> > +{
> > +	/*
> > +	 * X[19..12] X[11..4] Y[19..12] Y[11..4] Z[19..12] Z[11..4] X[3..0] Y[3..0] Z[3..0]
> > +	 */
> > +	*val = buf[2 * index];
> > +	*val <<= 8;
> > +
> > +	*val |= buf[2 * index + 1];
> > +	*val <<= 8;
> > +
> > +	*val |= buf[index + 6];
> > +
> > +	*val >>= 4;
> > +
> > +	return 0;
> > +}
> > +
> > +#define MMC5633_ALL_SIZE (3 * 3 + 1) /* each channel have 3 byte and TEMP */
> > +
> > +static int mmc5633_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int *val,
> > +			    int *val2, long mask)
> > +{
> > +	struct mmc5633_data *data = iio_priv(indio_dev);
> > +	char buf[MMC5633_ALL_SIZE];
> > +	unsigned int reg;
> > +	int ret, i;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		scoped_guard(mutex, &data->mutex) {
> > +			ret = mmc5633_read_measurement(data, buf, MMC5633_ALL_SIZE);
> > +			if (ret < 0)
> > +				return ret;
> > +		}
> > +
> > +		ret = mmc5633_get_raw(data, chan->address, buf, val);
> > +		if (ret < 0)
> > +			return ret;
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = 0;
> > +		*val2 = 62500;
> > +		return IIO_VAL_INT_PLUS_NANO;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		scoped_guard(mutex, &data->mutex) {
> > +			ret = regmap_read(data->regmap, MMC5633_REG_CTRL1, &reg);
> > +			if (ret < 0)
> > +				return ret;
> > +		}
> > +
> > +		i = FIELD_GET(MMC5633_CTRL1_BW_MASK, reg);
> > +		if (i < 0 || i >= ARRAY_SIZE(mmc5633_samp_freq))
> > +			return -EINVAL;
> > +
> > +		*val = mmc5633_samp_freq[i].val;
> > +		*val2 = mmc5633_samp_freq[i].val2;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int mmc5633_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan, int val,
> > +			     int val2, long mask)
> > +{
> > +	struct mmc5633_data *data = iio_priv(indio_dev);
> > +	int i, ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		i = mmc5633_get_samp_freq_index(data, val, val2);
> > +		if (i < 0)
> > +			return -EINVAL;
> > +
> > +		scoped_guard(mutex, &data->mutex) {
> > +			ret = regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
> > +						 MMC5633_CTRL1_BW_MASK,
> > +						 FIELD_PREP(MMC5633_CTRL1_BW_MASK, i));
> > +			if (ret)
> > +				return ret;
> > +		};
> > +		return ret;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_info mmc5633_info = {
> > +	.read_raw	= mmc5633_read_raw,
> > +	.write_raw	= mmc5633_write_raw,
> > +	.attrs		= &mmc5633_attribute_group,
> > +};
> > +
> > +static bool mmc5633_is_writeable_reg(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case MMC5633_REG_CTRL0:
> > +	case MMC5633_REG_CTRL1:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +static bool mmc5633_is_readable_reg(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case MMC5633_REG_XOUT_L:
> > +	case MMC5633_REG_XOUT_H:
> > +	case MMC5633_REG_YOUT_L:
> > +	case MMC5633_REG_YOUT_H:
> > +	case MMC5633_REG_ZOUT_L:
> > +	case MMC5633_REG_ZOUT_H:
> > +	case MMC5633_REG_XOUT_2:
> > +	case MMC5633_REG_YOUT_2:
> > +	case MMC5633_REG_ZOUT_2:
> > +	case MMC5633_REG_STATUS1:
> > +	case MMC5633_REG_ID:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +static bool mmc5633_is_volatile_reg(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case MMC5633_REG_CTRL0:
> > +	case MMC5633_REG_CTRL1:
> > +		return false;
> > +	default:
> > +		return true;
> > +	}
> > +}
> > +
> > +static const struct reg_default mmc5633_reg_defaults[] = {
> > +	{ MMC5633_REG_CTRL0,  0x00 },
> > +	{ MMC5633_REG_CTRL1,  0x00 },
> > +};
> > +
> > +static const struct regmap_config mmc5633_regmap_config = {
> > +	.name = "mmc5633_regmap",
> > +
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +
> > +	.max_register = MMC5633_REG_ID,
> > +	.cache_type = REGCACHE_FLAT,
> > +
> > +	.writeable_reg = mmc5633_is_writeable_reg,
> > +	.readable_reg = mmc5633_is_readable_reg,
> > +	.volatile_reg = mmc5633_is_volatile_reg,
> > +
> > +	.reg_defaults = mmc5633_reg_defaults,
> > +	.num_reg_defaults = ARRAY_SIZE(mmc5633_reg_defaults),
> > +};
> > +
> > +static int mmc5633_common_probe(struct device *dev, struct regmap *regmap,
> > +				char *name, struct i3c_device *i3cdev)
> > +{
> > +	struct mmc5633_data *data;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	dev_set_drvdata(dev, indio_dev);
> > +
> > +	data = iio_priv(indio_dev);
> > +
> > +	data->regmap = regmap;
> > +	data->i3cdev = i3cdev;
> > +	data->dev = dev;
> > +
> > +	ret = devm_mutex_init(dev, &data->mutex);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->info = &mmc5633_info;
> > +	indio_dev->name = name;
> > +	indio_dev->channels = mmc5633_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(mmc5633_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	ret = mmc5633_init(data);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "mmc5633 chip init failed\n");
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static int mmc5633_suspend(struct device *dev)
> > +{
> > +	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
> > +
> > +	regcache_cache_only(data->regmap, true);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mmc5633_resume(struct device *dev)
> > +{
> > +	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
> > +	int ret;
> > +
> > +	regcache_mark_dirty(data->regmap);
> > +	ret = regcache_sync_region(data->regmap, MMC5633_REG_CTRL0,
> > +				   MMC5633_REG_CTRL1);
> > +	if (ret < 0)
> > +		dev_err(dev, "Failed to restore control registers\n");
> > +
> > +	regcache_cache_only(data->regmap, false);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mmc5633_i2c_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct regmap *regmap;
> > +
> > +	regmap = devm_regmap_init_i2c(client, &mmc5633_regmap_config);
> > +	if (IS_ERR(regmap))
> > +		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
> > +
> > +	return mmc5633_common_probe(dev, regmap, client->name, NULL);
> > +}
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(mmc5633_pm_ops, mmc5633_suspend,
> > +				mmc5633_resume);
> > +
> > +static const struct of_device_id mmc5633_of_match[] = {
> > +	{ .compatible = "memsic,mmc5633", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mmc5633_of_match);
> > +
> > +static const struct i2c_device_id mmc5633_i2c_id[] = {
> > +	{ "mmc5633" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
> > +
> > +static struct i2c_driver mmc5633_i2c_driver = {
> > +	.driver = {
> > +		.name = "mmc5633_i2c",
> > +		.of_match_table = mmc5633_of_match,
> > +		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
> > +	},
> > +	.probe	  = mmc5633_i2c_probe,
> > +	.id_table       = mmc5633_i2c_id,
> > +};
> > +
> > +static const struct i3c_device_id mmc5633_i3c_ids[] = {
> > +	I3C_DEVICE(0x0251, 0x0000, NULL),
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(i3c, mmc5633_i3c_ids);
> > +
> > +static int mmc5633_i3c_probe(struct i3c_device *i3cdev)
> > +{
> > +	struct device *dev = i3cdev_to_dev(i3cdev);
> > +	struct regmap *regmap;
> > +
> > +	regmap = devm_regmap_init_i3c(i3cdev, &mmc5633_regmap_config);
> > +	if (IS_ERR(regmap))
> > +		return dev_err_probe(dev, PTR_ERR(regmap),
> > +				     "Failed to register i3c regmap\n");
> > +
> > +	return mmc5633_common_probe(dev, regmap, "mmc5633_i3c", i3cdev);
> > +}
> > +
> > +static struct i3c_driver mmc5633_i3c_driver = {
> > +	.driver = {
> > +		.name = "mmc5633_i3c",
> > +	},
> > +	.probe = mmc5633_i3c_probe,
> > +	.id_table = mmc5633_i3c_ids,
> > +};
> > +
> > +module_i3c_i2c_driver(mmc5633_i3c_driver, &mmc5633_i2c_driver)
> > +
> > +MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
> > +MODULE_DESCRIPTION("MEMSIC MMC5633 magnetic sensor driver");
> > +MODULE_LICENSE("GPL");
> >
> > --
> > 2.34.1
> >
>
> Hello all,
>
> I've been working on a driver for the MMC 5603NJ using I2C these last few days and it seems to be working. As it happens, I noticed your patch and looked over the datasheet and it seems they are very similar, but your sensor has some extra features. My driver also reads the temperature. I am not experienced enough to tell if they are compatible and if we could merge the drivers in some way. Is there a point to me sending my driver? What is the protocol for situations like these?
>

Please wrap your reply at 80 or 100 chars to read easily. If your driver
is good enough, you can post to public list, I can pickup and try to
merge it.

If not, you can send patch to me only.

Frank

> I would test your driver to see if it works on my sensor, but there are some features there that my board does not have, so in its current form, I don't think I can use it.
>
> Thank you for your consideration,
> - Adrian Fluturel

