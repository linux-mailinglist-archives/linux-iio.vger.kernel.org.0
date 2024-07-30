Return-Path: <linux-iio+bounces-8070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83240942060
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 21:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D355FB229EB
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 19:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB5018C900;
	Tue, 30 Jul 2024 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Cjv0mLgW"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2051.outbound.protection.outlook.com [40.92.19.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD21AA3D8;
	Tue, 30 Jul 2024 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366671; cv=fail; b=kvctpaiwvQwu/tmPk0VsbRcaGmXg1VEDUeSXD3Q2cS4+S++uYCIWYhPGD9wuJKt2rSEksRkzepK0nkuUYphfuqe8Gs9uhNd9Htxqc8wo95zDdpn/5m5k+hWZ/YOHh5ZBQJKSV4vynQ/j6wRXSIxXGmdzZ+2PI0e1GQOLB2qssFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366671; c=relaxed/simple;
	bh=L9ElqdM21wkjHWnNN3vtWnC2JAAUdvBDa3NJPa0ieuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LhQMz788QQ6eBRh+R0YyRbIMFAaVLsMEu2jwKyyYJqePGg+Cv67ewrqjZy8yA8dQLSJG1zYyeTZ88t8Pdijw0SdZbhPVsLAHHoLBeB2HHMFz4VZNGcpOxIY6qAC1AOD4dGtiiwV4B8gkyTha7nZE0Qll+Tqhp0rd/WosZtbKFy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Cjv0mLgW; arc=fail smtp.client-ip=40.92.19.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SI7K8lE0bgzgw9yH3Xz2Iq0FRs5kNRCbI0zD11ihhZRCOrxuJsVmridDmmIPvHqSeJ2xChMiSmJ8IRI2gDafBcCp3aVR+ZfpQclX6keeZgJpips8hvxTvSNhLn3M4A06H5ErV9zw01pusPx6+/tQSKvjswx1UhzjtpJA33tLp9mIUe8hLHdTXSe0ZDgD3OYrPBVKJDfoAZ9471i/pXRk5eK7iLXUNo4xd8evZqBJqjGCRhumG4HpNul5VmWaXwqJ2P5S9/hCluNUqVXUUPzPVNOdNbumkPLp/PqqhkGYK8esGoYXdCD4EELG6YxcDGQUYlWTGGiHXCdDkUPfnSvZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbkDIg9WuZBoFtMZqkdQpR9oocsEzBqik7ML7Gk7Wz8=;
 b=RMdR7MwORfiH9KarVIz5suzgNrCIeXNo6eS0l8+ltp9NWxvYyS/0q1qxqdlzKbVSzD9ZNsC4QqvfN62jVkngIcF6PPn1G3Wg8Jh2eScHwyQebIw9Z0+5o8bOtOAWiDnzYzDtkjSOH80S6X4vk+xIT3lfR/wyu35+IFi6o8BWVOoCmCf0+eq5FkuFjNwELt8bjypKLBacmLX6IwA2OL5y7d4oiboj7QnxCFF6XNzZ+c8F6ZSN1tfqNKLgF8qukNkMtUFOH0eHvJKzIsVzlCe1A4qRPJ6yBl2Pn1PlY3QlBHtcUHfSt5ETqzWzKg0spJyfbHYJSaetEYhT9bPuA/CCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbkDIg9WuZBoFtMZqkdQpR9oocsEzBqik7ML7Gk7Wz8=;
 b=Cjv0mLgWT/1TsM+6gI/+PKzFHCpl/ro3H/iG7z1BsqHAG8/nAa/ykkvC3dlrFEZVak8Uk4AqjaYTflvwM93mDY1YeDdxgCQVPR3kcge/Lmp++6UOQ4KhlTsBA7QkbWpCvtP+hqUa8Bmw3A5IqlYM/BKWC+bDhsOFcDeN1p/aq/yrqNtMr+dvGRr4msQNwC+KUCV3KoKU9wXRyS7ko9D0F8KM4Qrsp4+vubWw4rTmwkPRX1/DH/YVkezKOSV4Hoou6LL3w2NfFS8UHT5ubsz7QvnEEgJq+fteLV637EW/YZ+nHu5iELAnqKurTBSY/Kwr5aNUH21++ZzAgVjbV+yrQg==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 19:11:08 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 19:11:07 +0000
Date: Tue, 30 Jul 2024 14:11:02 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, broonie@kernel.org, lee@kernel.org,
	samuel@sholland.org, jernej.skrabec@gmail.com, sre@kernel.org,
	wens@csie.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, lars@metafoo.de
Subject: Re: [PATCH 5/8] iio: adc: axp20x_adc: add support for AXP717 ADC
Message-ID:
 <MN2PR16MB2941D402D60D08F1E6A7F330A5B02@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
 <20240617220535.359021-6-macroalpha82@gmail.com>
 <ZneyPV9DYzjNV5_x@wens.tw>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZneyPV9DYzjNV5_x@wens.tw>
X-TMN: [rZZFUVVJNyx67xpYyOcWoYhhpM8WGRgvyGIpSxrp/XTPm5XoKURh+NT7T6dmZ2J1]
X-ClientProxiedBy: SA0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:806:130::14) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <Zqk6xrTomCWATTo2@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|DS1PR16MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2ecafa-5b57-437a-bf9e-08dcb0cb5cb5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	Z9kH9GmCiDG08EwefFo6uX2uAbe2Ly87pcebyzz0vLDiPxNb4Eo1TcJeZM9GlR4fYQLZkC20NOuuCfKorQHAsjxLl7pkHoGG2kxK2PvIL/dibeabGqi5NWuihFky/rHBexd2vdiEqmgL6tCDi8EWraMMG1DMJlXAWy+MZFrCLNJ94nGbqldl9HLIQqgglLwGn4r7eoaAXm/hgrRZKw+xNpSgLAQAc+bi6uPIR2GUaRNLDir3GWMfkyf95MZ1zvCVoxq9mw1LhTDQYo5eHw2sO6DVN6lHEWWgqJ4fRFZIjyPbhW7qJjfuynJZfZPnrCMs1oq8JIDfhSXJmOyWpJs9Ln61nUaF8dH6Z4DtjMwqV0FqDvLyId/5H6muAMyFu/IjqAH6d3KyuDRRu9l9tvanurLOESMQpA6yRalSbDls6ubt/A6ITOCiq9GCcPKpasqRvv9txKmQET9YI40CXaIb/y8+AS7EiVCaoiGNTUOjTNCXskGDQe+mDYWz/BTvYkzGwEAdKe/G64ObS9YDlEWzgAjLltsbjUNCvwuDgDguQOzUJ5MezbTNOlAAW9Cz9ErkGfrC+Gvu7h1vkcxMQKdXstehqCd4ZmePOxzCLtWYAUFs+xTEP1k5TBl9tscQ0+041zl1eSgl7E5+6nQMRGT+jBSOUezgMex5ObFP5slIIoY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fcmugcjgte2rJ88wBnWz7sYRA4Fm93OGKiSJS1UhUxKhooUzwFE6BfG48wUX?=
 =?us-ascii?Q?/vDyyRzU0paeysKKPRJdDv2OZNKq61ZMWWtg/OD2/fLNv7PgC5gCKRALPh1g?=
 =?us-ascii?Q?c/DEyVjYY6eApauN5uSXe+MBmJHRmKUk1wbXIA9WZcuKvCZyE63MTtd8YD2p?=
 =?us-ascii?Q?o2a/AYCH8h/KpxIsVutMlRcnrjbbDjESwdh8vnIhhAJbQlwH9JOirYPzrDDM?=
 =?us-ascii?Q?tBLP8SJolc735DGxn5MrXE36i4mjbEIuwWs/TxSKAGGDTZD7qzT+u04tnv/i?=
 =?us-ascii?Q?FaZeiIcHfh0YCG3nKu4JqcpdYXLSEsTQX0tJuJ50WqcRVOXgoPd7LKlB9ZFc?=
 =?us-ascii?Q?sPnMrLMmX/IkdVUNbbbSDbdEitCDiL9PszJQDz+n8uW8dPVQSQwutOO11tlU?=
 =?us-ascii?Q?qHDndqTIhpcABLLzaVS7WZDLQn24GXWw/GPl21JKE3jbgYNdooOw3bHzSQUm?=
 =?us-ascii?Q?UjRhSLBZdppTfqbWeEeC/sWjyCxBgKsbP/GXI9tsbRQlGfUhlxmJjUau09fe?=
 =?us-ascii?Q?xeG+Mz3NtBGl2YHzOT+ljpTipiMid3funZKjCXGnR64w/P493cMyKyGmW+0L?=
 =?us-ascii?Q?MxqWwYrrmdpwbr03UgXGwxST1rZa3OsTjvB6lHzWHazzuEROZ4jEtEkGULxw?=
 =?us-ascii?Q?BOZN78jzG6fxcmIPKtc3KrWaIQIwPUevASSz4M9OH8eC3kMfoyTX5+Tb2L4k?=
 =?us-ascii?Q?ZBYapHtaXTfrX5f87GT8PaaBK5XwhVuzpGvuqBAYRuTPDwjtgJV5TirDamEG?=
 =?us-ascii?Q?o4m/H6kkH6JeDIX6gyg3dNUSARoYj8H20N0XAyEar1TI8uclsfntmZ8s7OvW?=
 =?us-ascii?Q?V7QZKmF7jgasx0Dt4OWQcAJAOLroizedbk9fv3uvA9ZHGX0fH59CF6F2Qw8H?=
 =?us-ascii?Q?zwuR64uf2wV1gVsDcHfL5vPbzYfRBuzJZyfVQ2b300SB/WUFI/FejEom93wx?=
 =?us-ascii?Q?tnA3nztZ9f7KgGTSYLvSsz1YeuV4v7niX0R8x/qZMhUVz4Nx5E+cRpZNz8h0?=
 =?us-ascii?Q?CjT8MEuSeghw81bv5DdRcTrYTirVUX4mX70fkSX7iaEojfATG0yTr/Dv9nSL?=
 =?us-ascii?Q?ix0Slg+HSc6cqci8zfbU0S93diyN43N3DgrYwvUHzaHhvvXY3GMCwOqf9K11?=
 =?us-ascii?Q?vGlHzUTabLyuBM6mXFNOVB8HNV9N+6RcwVxurjzlTCHprJ+TqDXszirSDn2R?=
 =?us-ascii?Q?uKJDhNeJDAYZmfhpYbcsJU8zF7wkosXZdDeigafpPMH/59x13MfQYyuqT0Qa?=
 =?us-ascii?Q?BqDw/oc9w9F5/ybEuDb5tiB0dJntXxJTzgNs2yjDZkk+zb5Az4zOp1hYRXAg?=
 =?us-ascii?Q?HilZq9YMQwdwb16WfVOitY7r?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2ecafa-5b57-437a-bf9e-08dcb0cb5cb5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:11:07.4586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR16MB6753

On Sun, Jun 23, 2024 at 01:27:25PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jun 17, 2024 at 05:05:32PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the AXP717 ADC. The AXP717 differs from other ADCs
> > in this series by utilizing a 14 bit ADC for all channels (a full 16
> > bits with the first 2 digits reserved). It also differs by lacking a
> > battery discharge current channel.
> 
> Maybe charge and discharge share the same channel?

I can't confirm that. I've enabled multiple power draws and don't
notice a change on this channel consistent with such a draw. Power
draws include backlight, GPIO vibrators, and turning on/off regulators.

> 
> > Note that while the current charge channel itself is included in this
> > driver for the AXP717 and listed in the datasheet, no scale or offset
> > was given for this channel. For now no scale or offset is provided in
> > this driver.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  drivers/iio/adc/axp20x_adc.c | 167 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 160 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> > index d6c51b0f48e3..f35ba2c11e1b 100644
> > --- a/drivers/iio/adc/axp20x_adc.c
> > +++ b/drivers/iio/adc/axp20x_adc.c
> > @@ -5,6 +5,7 @@
> >   *	Quentin Schulz <quentin.schulz@free-electrons.com>
> >   */
> >  
> > +#include <asm/unaligned.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/completion.h>
> >  #include <linux/interrupt.h>
> > @@ -27,6 +28,8 @@
> >  
> >  #define AXP22X_ADC_EN1_MASK			(GENMASK(7, 5) | BIT(0))
> >  
> > +#define AXP717_ADC_EN1_MASK			GENMASK(5, 0)
> > +
> >  #define AXP20X_GPIO10_IN_RANGE_GPIO0		BIT(0)
> >  #define AXP20X_GPIO10_IN_RANGE_GPIO1		BIT(1)
> >  
> > @@ -35,6 +38,11 @@
> >  
> >  #define AXP22X_ADC_RATE_HZ(x)			((ilog2((x) / 100) << 6) & AXP20X_ADC_RATE_MASK)
> >  
> > +#define AXP717_ADC_DATA_TS			0x00
> > +#define AXP717_ADC_DATA_TEMP			0x01
> > +
> > +#define AXP717_ADC_DATA_MASK			0x3fff
> > +
> >  #define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
> >  #define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
> >  #define AXP813_TS_GPIO0_ADC_RATE_HZ(x)		AXP20X_ADC_RATE_HZ(x)
> > @@ -98,6 +106,18 @@ enum axp22x_adc_channel_i {
> >  	AXP22X_BATT_DISCHRG_I,
> >  };
> >  
> > +enum axp717_adc_channel_v {
> > +	AXP717_BATT_V = 0,
> > +	AXP717_TS_IN,
> > +	AXP717_VBUS_V,
> > +	AXP717_VSYS_V,
> > +	AXP717_DIE_TEMP_V,
> 
> Please also add VMID and backup battery voltage.

Will do, I'll make sure all ADC channels are here, even if they aren't
used.

> 
> > +};
> > +
> > +enum axp717_adc_channel_i {
> > +	AXP717_BATT_CHRG_I = 5,
> > +};
> > +
> >  enum axp813_adc_channel_v {
> >  	AXP813_TS_IN = 0,
> >  	AXP813_GPIO0_V,
> > @@ -152,6 +172,22 @@ static struct iio_map axp22x_maps[] = {
> >  	}, { /* sentinel */ }
> >  };
> >  
> > +static struct iio_map axp717_maps[] = {
> > +	{
> > +		.consumer_dev_name = "axp20x-usb-power-supply",
> > +		.consumer_channel = "vbus_v",
> > +		.adc_channel_label = "vbus_v",
> > +	}, {
> > +		.consumer_dev_name = "axp20x-battery-power-supply",
> > +		.consumer_channel = "batt_v",
> > +		.adc_channel_label = "batt_v",
> > +	}, {
> > +		.consumer_dev_name = "axp20x-battery-power-supply",
> > +		.consumer_channel = "batt_chrg_i",
> > +		.adc_channel_label = "batt_chrg_i",
> > +	},
> > +};
> > +
> >  /*
> >   * Channels are mapped by physical system. Their channels share the same index.
> >   * i.e. acin_i is in_current0_raw and acin_v is in_voltage0_raw.
> > @@ -210,6 +246,25 @@ static const struct iio_chan_spec axp22x_adc_channels[] = {
> >  			   AXP22X_TS_ADC_H),
> >  };
> >  
> > +/*
> > + * Scale and offset is unknown for temp, ts, and batt_chrg_i channels
> > + * for now. Leaving scale and offset undefined for now.
> > + */
> > +static const struct iio_chan_spec axp717_adc_channels[] = {
> > +	AXP20X_ADC_CHANNEL(AXP717_BATT_V, "batt_v", IIO_VOLTAGE,
> > +			   AXP717_BATT_V_H),
> > +	AXP20X_ADC_CHANNEL(AXP717_TS_IN, "ts_v", IIO_VOLTAGE,
> > +			   AXP717_ADC_DATA_H),
> > +	AXP20X_ADC_CHANNEL(AXP717_VBUS_V, "vbus_v", IIO_VOLTAGE,
> > +			   AXP717_VBUS_V_H),
> > +	AXP20X_ADC_CHANNEL(AXP717_VSYS_V, "vsys_v", IIO_VOLTAGE,
> > +			   AXP717_VSYS_V_H),
> > +	AXP20X_ADC_CHANNEL(AXP717_DIE_TEMP_V, "pmic_temp", IIO_TEMP,
> > +				  AXP717_ADC_DATA_H),
> > +	AXP20X_ADC_CHANNEL(AXP717_BATT_CHRG_I, "batt_chrg_i", IIO_CURRENT,
> > +			   AXP717_BATT_CHRG_I_H),
> > +};
> > +
> >  static const struct iio_chan_spec axp813_adc_channels[] = {
> >  	{
> >  		.type = IIO_TEMP,
> > @@ -269,6 +324,44 @@ static int axp22x_adc_raw(struct iio_dev *indio_dev,
> >  	return IIO_VAL_INT;
> >  }
> >  
> > +static int axp717_adc_raw(struct iio_dev *indio_dev,
> > +			  struct iio_chan_spec const *chan, int *val)
> > +{
> > +	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> > +	u8 bulk_reg[2];
> > +	int ret;
> > +
> > +	/*
> > +	 * A generic "ADC data" channel is used for TS, tdie, vmid,
> > +	 * and vbackup. This channel must both first be enabled and
> > +	 * also selected before it can be read.
> > +	 */
> > +	switch (chan->channel) {
> > +	case AXP717_TS_IN:
> > +		regmap_write(info->regmap, AXP717_ADC_DATA_SEL,
> > +			     AXP717_ADC_DATA_TS);
> > +		break;
> > +	case AXP717_DIE_TEMP_V:
> > +		regmap_write(info->regmap, AXP717_ADC_DATA_SEL,
> > +			     AXP717_ADC_DATA_TEMP);
> > +		break;
> > +
> > +	default:
> > +		break;
> > +	}
> > +
> > +	/*
> > +	 * All channels are 14 bits, with the first 2 bits on the high
> > +	 * register reserved and the remaining bits as the ADC value.
> > +	 */
> > +	ret = regmap_bulk_read(info->regmap, chan->address, bulk_reg, 2);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val = get_unaligned_be16(bulk_reg) & AXP717_ADC_DATA_MASK;
> > +	return IIO_VAL_INT;
> > +}
> > +
> >  static int axp813_adc_raw(struct iio_dev *indio_dev,
> >  			  struct iio_chan_spec const *chan, int *val)
> >  {
> > @@ -425,6 +518,27 @@ static int axp22x_adc_scale(struct iio_chan_spec const *chan, int *val,
> >  	}
> >  }
> >  
> > +static int axp717_adc_scale(struct iio_chan_spec const *chan, int *val,
> > +			    int *val2)
> > +{
> > +	switch (chan->type) {
> > +	case IIO_VOLTAGE:
> > +		*val = 1;
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CURRENT:
> > +		*val = 1;
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_TEMP:
> > +		*val = 100;
> > +		return IIO_VAL_INT;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static int axp813_adc_scale(struct iio_chan_spec const *chan, int *val,
> >  			    int *val2)
> >  {
> > @@ -529,6 +643,22 @@ static int axp22x_read_raw(struct iio_dev *indio_dev,
> >  	}
> >  }
> >  
> > +static int axp717_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan, int *val,
> > +			   int *val2, long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		return axp717_adc_scale(chan, val, val2);
> > +
> > +	case IIO_CHAN_INFO_RAW:
> > +		return axp717_adc_raw(indio_dev, chan, val);
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static int axp813_read_raw(struct iio_dev *indio_dev,
> >  			   struct iio_chan_spec const *chan, int *val,
> >  			   int *val2, long mask)
> > @@ -593,6 +723,10 @@ static const struct iio_info axp22x_adc_iio_info = {
> >  	.read_raw = axp22x_read_raw,
> >  };
> >  
> > +static const struct iio_info axp717_adc_iio_info = {
> > +	.read_raw = axp717_read_raw,
> > +};
> > +
> >  static const struct iio_info axp813_adc_iio_info = {
> >  	.read_raw = axp813_read_raw,
> >  };
> > @@ -622,7 +756,9 @@ struct axp_data {
> >  	const struct iio_info		*iio_info;
> >  	int				num_channels;
> >  	struct iio_chan_spec const	*channels;
> > +	unsigned long			adc_en1;
> >  	unsigned long			adc_en1_mask;
> > +	unsigned long			adc_en2;
> >  	unsigned long			adc_en2_mask;
> >  	int				(*adc_rate)(struct axp20x_adc_iio *info,
> >  						    int rate);
> > @@ -633,7 +769,9 @@ static const struct axp_data axp20x_data = {
> >  	.iio_info = &axp20x_adc_iio_info,
> >  	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
> >  	.channels = axp20x_adc_channels,
> > +	.adc_en1 = AXP20X_ADC_EN1,
> >  	.adc_en1_mask = AXP20X_ADC_EN1_MASK,
> > +	.adc_en2 = AXP20X_ADC_EN2,
> >  	.adc_en2_mask = AXP20X_ADC_EN2_MASK,
> >  	.adc_rate = axp20x_adc_rate,
> >  	.maps = axp20x_maps,
> > @@ -643,15 +781,26 @@ static const struct axp_data axp22x_data = {
> >  	.iio_info = &axp22x_adc_iio_info,
> >  	.num_channels = ARRAY_SIZE(axp22x_adc_channels),
> >  	.channels = axp22x_adc_channels,
> > +	.adc_en1 = AXP20X_ADC_EN1,
> >  	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
> >  	.adc_rate = axp22x_adc_rate,
> >  	.maps = axp22x_maps,
> >  };
> 
> Please split out the changes generalizing the driver into a separate
> patch. That makes it easier to follow.
> 

Acknowledged.

> 
> ChenYu
> 
> > +static const struct axp_data axp717_data = {
> > +	.iio_info = &axp717_adc_iio_info,
> > +	.num_channels = ARRAY_SIZE(axp717_adc_channels),
> > +	.channels = axp717_adc_channels,
> > +	.adc_en1 = AXP717_ADC_CH_EN_CONTROL,
> > +	.adc_en1_mask = AXP717_ADC_EN1_MASK,
> > +	.maps = axp717_maps,
> > +};
> > +
> >  static const struct axp_data axp813_data = {
> >  	.iio_info = &axp813_adc_iio_info,
> >  	.num_channels = ARRAY_SIZE(axp813_adc_channels),
> >  	.channels = axp813_adc_channels,
> > +	.adc_en1 = AXP20X_ADC_EN1,
> >  	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
> >  	.adc_rate = axp813_adc_rate,
> >  	.maps = axp22x_maps,
> > @@ -660,6 +809,7 @@ static const struct axp_data axp813_data = {
> >  static const struct of_device_id axp20x_adc_of_match[] = {
> >  	{ .compatible = "x-powers,axp209-adc", .data = (void *)&axp20x_data, },
> >  	{ .compatible = "x-powers,axp221-adc", .data = (void *)&axp22x_data, },
> > +	{ .compatible = "x-powers,axp717-adc", .data = (void *)&axp717_data, },
> >  	{ .compatible = "x-powers,axp813-adc", .data = (void *)&axp813_data, },
> >  	{ /* sentinel */ }
> >  };
> > @@ -668,6 +818,7 @@ MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
> >  static const struct platform_device_id axp20x_adc_id_match[] = {
> >  	{ .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
> >  	{ .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
> > +	{ .name = "axp717-adc", .driver_data = (kernel_ulong_t)&axp717_data, },
> >  	{ .name = "axp813-adc", .driver_data = (kernel_ulong_t)&axp813_data, },
> >  	{ /* sentinel */ },
> >  };
> > @@ -709,15 +860,17 @@ static int axp20x_probe(struct platform_device *pdev)
> >  	indio_dev->channels = info->data->channels;
> >  
> >  	/* Enable the ADCs on IP */
> > -	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
> > +	regmap_write(info->regmap, info->data->adc_en1,
> > +		     info->data->adc_en1_mask);
> >  
> >  	if (info->data->adc_en2_mask)
> > -		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
> > +		regmap_update_bits(info->regmap, info->data->adc_en2,
> >  				   info->data->adc_en2_mask,
> >  				   info->data->adc_en2_mask);
> >  
> >  	/* Configure ADCs rate */
> > -	info->data->adc_rate(info, 100);
> > +	if (info->data->adc_rate)
> > +		info->data->adc_rate(info, 100);
> >  
> >  	ret = iio_map_array_register(indio_dev, info->data->maps);
> >  	if (ret < 0) {
> > @@ -737,10 +890,10 @@ static int axp20x_probe(struct platform_device *pdev)
> >  	iio_map_array_unregister(indio_dev);
> >  
> >  fail_map:
> > -	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
> > +	regmap_write(info->regmap, info->data->adc_en1, 0);
> >  
> >  	if (info->data->adc_en2_mask)
> > -		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
> > +		regmap_write(info->regmap, info->data->adc_en2, 0);
> >  
> >  	return ret;
> >  }
> > @@ -753,10 +906,10 @@ static void axp20x_remove(struct platform_device *pdev)
> >  	iio_device_unregister(indio_dev);
> >  	iio_map_array_unregister(indio_dev);
> >  
> > -	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
> > +	regmap_write(info->regmap, info->data->adc_en1, 0);
> >  
> >  	if (info->data->adc_en2_mask)
> > -		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
> > +		regmap_write(info->regmap, info->data->adc_en2, 0);
> >  }
> >  
> >  static struct platform_driver axp20x_adc_driver = {
> > -- 
> > 2.34.1
> > 

Thank you for the feedback,
Chris

