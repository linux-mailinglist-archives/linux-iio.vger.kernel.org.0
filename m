Return-Path: <linux-iio+bounces-12957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 342E19E0A8F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CCD163D78
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 18:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0841DACA1;
	Mon,  2 Dec 2024 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="DXX5xllz"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942B070814;
	Mon,  2 Dec 2024 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162454; cv=fail; b=Rtblr0X2g/E6OMZdWwGHgNLWM+S4LBNUWBT3lyM2C0zh04Iml0qom/WEC3DV9vvhnxRgFfQO7O/kYNW7MiBzO3MfN1qyGe0eeT7XDyRpz8a3wjY6OXkqAEH8lCfvnzgd5XU5oMkK6yG2xg/EkjoYag2S+lTgPIu1vBgfpbZDlj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162454; c=relaxed/simple;
	bh=9IEAvhA98xicPHphDg7KFmeO9fqi/ZSU+PIhXnyeALM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHms450JI2uY8ylKNlX8AP4SJHvjdSI5u2OQp7nUSUrw6XW7oa0bvZ6mAPpKuz6HwiQ1U43Q5Ovn54ke6p4hl4Uf9IIJN6U5Z9npxuwU3sgoFrfLDHp5Db11kG3WzP1RgmZbvKIE/pWHCmf5ixvJ6/A35Kkxj/a8D/DpvaqxSPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=DXX5xllz; arc=fail smtp.client-ip=40.107.159.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hzl90y0b+nKy42TcDiURJLFEcE95rQAbZ9PllwEHwISTN26zKcIPsl7DR9xaA7WPLKmXyzLAEcGb658J/5bJr9a1doTSt6Ss6En4EeNu0Eynd1D/mhwMljWAmCXXmaR/gqGYtSrUqOiW4Vg02XnZ1+JnBpkb79ROj5O43yJqMZDXlIkQU3iOiuNu6DHuaX85h3fl/aJs0zDrf0PcAE69zh9CSmIrpkSlPtnf8lTWDS10BMuX2rCYnz9NvxUbfTxgAuY2LgNlVK0//6O5eeP4Ut35tr8toh5SwaW3BE2EEhdqgb8ipnHz6ydWc9bnKTk+QOOtN81Fss+uRFDBs6BeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcl5CT37hbNJIMZ9ElUQwXrKgFRHxPR0Ud5svTbzkg8=;
 b=wb2GaywrakHDb9zem2r6d3DjFQgTpoZQL3QIyfw0PkQcCCFb5fgU+RUDZhjJCOJ/Iim94yKlYImMXzzv2Qxv9gakyTgzN1tlec1nURnUgn6u85TC0m99i57BQCVci65ApmBouFpPkaebl1cl6q75kgOzXVQWF54xgLSG0gQpTzp5lv3Nn7TMpoxGTrvUi1xBwZ5CxM3lS+CwvyRBgfeaCzAFljo4YJXwmiEKTaFxCjpy7gN+20wh4B8klio5mxDyge6NaZ5B/gjC4Hxg2UyIbmqO1am052AqpGYeybQ7evWXgBuAhzPR4gH95qRIXFr9ODJIcBWfuzd2kHi2fzqy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcl5CT37hbNJIMZ9ElUQwXrKgFRHxPR0Ud5svTbzkg8=;
 b=DXX5xllzIY/IfCGp921p0i71XoWcWdrTwbk4DHWN9Vvr3nrv6zG0t4ArlzBdbg1CM4Bwr+Wps5VCjk11segDNAp+ZNPykmE5ggQAnHc72qW207L97alNWJMh6qWJ6+8yYtgQSASrVWAXI3JKlwgqm5qbmSXLf9a9lO/9ee+22mA=
Received: from AS9PR06CA0522.eurprd06.prod.outlook.com (2603:10a6:20b:49d::18)
 by DB5PR07MB9456.eurprd07.prod.outlook.com (2603:10a6:10:4a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Mon, 2 Dec
 2024 18:00:44 +0000
Received: from AM3PEPF0000A797.eurprd04.prod.outlook.com
 (2603:10a6:20b:49d:cafe::eb) by AS9PR06CA0522.outlook.office365.com
 (2603:10a6:20b:49d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 18:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF0000A797.mail.protection.outlook.com (10.167.16.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 18:00:43 +0000
Received: from n9w6sw14.localnet (10.30.4.231) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 2 Dec
 2024 19:00:42 +0100
From: Christian Eggers <ceggers@arri.de>
To: Jonathan Cameron <jic23@kernel.org>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Antoni Pokusinski
	<apokusinski01@gmail.com>, Francesco Dolcini <francesco@dolcini.it>,
	=?ISO-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Gregor Boirie <gregor.boirie@parrot.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, =?ISO-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?=
	<joao.goncalves@toradex.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 10/11] iio: light: as73211: fix information leak in triggered
 buffer
Date: Mon, 2 Dec 2024 19:00:42 +0100
Message-ID: <7089293.9J7NaK4W3v@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <9e1310d8-bcd9-40f9-8d44-abddc595ae9b@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
 <20241130204923.45d71fa4@jic23-huawei>
 <9e1310d8-bcd9-40f9-8d44-abddc595ae9b@gmail.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A797:EE_|DB5PR07MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 033ed702-40f6-4ca8-c45e-08dd12fb3d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hp/RwDp2pQZQgM2QImyT/sjOojeNmSC7ayXkN9k6oIniksFEoUOs9kQJHQkL?=
 =?us-ascii?Q?/P6Kc+0wK7avLgDxplFXUFvA5XOzj+Dz9wl5m0J4cS6fzA4gGHAYn/dPs1/e?=
 =?us-ascii?Q?Y+99b8m+dcay+WrJxk5K4Z2ji228s1YMzIL+AIG+B+jgznJN7nKzSjNEcTS1?=
 =?us-ascii?Q?9HbSuXW0Cee1rnhVDkBHIx8sUK6uy32Z9O/wRtKDwTWVVwjYl6dY7B0LM5jF?=
 =?us-ascii?Q?mj2pBtkTm6Yi/03+/jy/Ng/tqKszYqbR4XjaAgP89r5c5+PcvmTLLpYiA/Er?=
 =?us-ascii?Q?HfMUguuzsvlgHaK6zS3TgXzmIPxQQAyajP4Ih0KYk9R5kkSEYqhNrj/l++I7?=
 =?us-ascii?Q?/pLz7BP9LTmB0wdCHgzG7/TccRLK3BaRNyijnlOUdq0RsndYSJjGVTdzl/NQ?=
 =?us-ascii?Q?EZAwBSwkcwsHFSKDFpbcXOQNg4VWlfvXvS7Jkq6zUpDqXxWtgTxVZiSbdCUX?=
 =?us-ascii?Q?duYNYkiyerKxGRsOgZRGNWU1UBI2J/fC0V14i09bC4Yzw1Bp8ZVw6aW7CRMp?=
 =?us-ascii?Q?7rXDjxaFtieJGy3QB+xu2mKbg/AH5ALLl85zPlmYCWxdVUMo34VdsDC7U59u?=
 =?us-ascii?Q?LDY/uDJT9TOUtw2lTjTnA7/YX/YDg2mE/L8wTuEiLpedyGFshQmUgZC5kf3G?=
 =?us-ascii?Q?BnVvf2bqn+TIzeYZhLkxU0lkizkbg/ro/6gjDwj1T0rREgaCsMPo+Lxgn8AE?=
 =?us-ascii?Q?5/RSn/wktvbY7c5YMEAFGZnNGttTiQ8GSh9snzM29LkpEJO8TY56gbVEl+p3?=
 =?us-ascii?Q?Yn0UTMB/QTaVUnvZ+m5hQlPMEUzUC4VtfvnPiu26jyabd103iPhGnWf4XYbA?=
 =?us-ascii?Q?HH7tuBgqnADu0JWSJY+UXxEoaK74Jeyk/lJiqscIaoG8HQgX5bgyt2b+2ywr?=
 =?us-ascii?Q?NT7G7P/aSKuhpqxHHWFJ9zWvk9EW/PZ0bO6lKCAOexJ38iRvZbH78l5Ptj1T?=
 =?us-ascii?Q?DjCC2xlzMeRnuCA6KQNJ2E8rnNhZ8FpoBN8LJyQCTZkW7n3CRKaVL+jWIJrx?=
 =?us-ascii?Q?lNyXlnmNEDysxEkkHe6X8YtJR8+3h7oKTrprepCV6pvqGFGFFFD1VMhirUzF?=
 =?us-ascii?Q?duWkkeOSchIATmWGthDZYFghqwb0yOy5v25U3I/6aqXob+OJR751dgq47mk1?=
 =?us-ascii?Q?MfTlV2mg1qRQlv7ujbV1w2ZBnmuukCmH0cZCgFM7ZJRexBhMgCDekSacR0ke?=
 =?us-ascii?Q?N6/uA90HuOpjHaQJhnQ+dLz9Beg+PT2Ovg43NnRPOxZyHIDpEqB8Tp1eHrP/?=
 =?us-ascii?Q?9nrvaS5MAnrgXMSg8UBS+vxOkXhzHuekcSiXYIoHmZBo2UWVkr4Nuqbog6e4?=
 =?us-ascii?Q?5D0GFthxoOxZnaKaBXIOGhAN5cBrSxMDoQBT05Kbi1C0D2yu6gWe8+zwwnLV?=
 =?us-ascii?Q?r3FXo2U4wRKwrD9v4dsB+O8g7C6jU1yDSC3mO2q18jcaTvnk/yYkdQuCgO0j?=
 =?us-ascii?Q?84uY65M6Rjh70GyLEH6SCyNlgLxX0VLU?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:00:43.4635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 033ed702-40f6-4ca8-c45e-08dd12fb3d94
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9456

Hi Jonathan, hi Javier,

On Monday, 2 December 2024, 16:38:50 CET, Javier Carrasco wrote:
> On 30/11/2024 21:49, Jonathan Cameron wrote:
> > On Mon, 25 Nov 2024 22:16:18 +0100
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> > 
> >> The 'scan' local struct is used to push data to userspace from a
> >> triggered buffer, but it leaves the first channel uninitialized if
> >> AS73211_SCAN_MASK_ALL is not set. That is used to optimize color channel
> >> readings.
> >>
> >> Set the temperature channel to zero if only color channels are
> >> relevant to avoid pushing uninitialized information to userspace.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 403e5586b52e ("iio: light: as73211: New driver")
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > Huh.
> > 
> > If the temperature channel is turned off the data should shift. So should be read
> > into scan.chan[0] and [1] and [2], but not [3].
> > 
> > Not skipping [0] as here.
> > 
> > So this code path currently doesn't work as far as I can tell.

I've just tested and you are right! In our application we never had the case that
we didn't read the temperature channel. If I don't enable scan_elements/in_temp_en,
I need to put the data into scan.chan[0..2] in order to get correct values in my
application. This also means that the "Optimization for reading only color channel"
(and the following saturation block) isn't correct at all, especially if reading only
one or two of the available channels.

> > 
> > Jonathan
> > 
> >> ---
> >>  drivers/iio/light/as73211.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> >> index be0068081ebb..99679b686146 100644
> >> --- a/drivers/iio/light/as73211.c
> >> +++ b/drivers/iio/light/as73211.c
> >> @@ -675,6 +675,9 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
> >>  				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
> >>  		if (ret < 0)
> >>  			goto done;
> >> +
> >> +		/* Avoid leaking uninitialized data */
> >> +		scan.chan[0] = 0;
> >>  	}
> >>  
> >>  	if (data_result) {
> >>
> > 
> 
> Adding the driver maintainer (should have been added from the beginning)
> to the conversation.
> 
> @Christian, could you please confirm this?
> 
> Apparently, the optimization to read the color channels without
> temperature is not right. I don't have access to the AS7331 at the
> moment, but I remember that you could test my patches on your hardware
> with an AS73211, so maybe you can confirm whether wrong data is
> delivered or not in that case.

Yes, the delivered data is wrong (as already stated above).

@Javier: If you like to rework this, I can test your patches (I have still
access to the hardware).  Otherwise I can also try to fix this on my own.

> 
> Thanks and best regards,
> Javier Carrasco

Thanks for reporting this!
Christian
> 
> 





