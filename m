Return-Path: <linux-iio+bounces-12087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72849C2E17
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 16:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868B51F21DE5
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D441991A1;
	Sat,  9 Nov 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zvs42O4D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E25022083;
	Sat,  9 Nov 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731165342; cv=none; b=aiHz4MBspDEAgsRn3cbdUw6HJO2kndgTV+XoDC99kG29VDhvpk6f9cEPx3ZkvcikMZ86SIFOAOXwuL1FQbCFbGoLmpDnCrX23v+gPrzq6tfsuum3d5no+JQ3SNL+KT9bSAObmfkpayRWJgN/pvsL6W8iH6RJ4C1lZGR+YGFW1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731165342; c=relaxed/simple;
	bh=VJ9+yL4/Qo6csHxmltBLugUE69mq36tQ6mfEaJh/YeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsS6WASH8eN5JxEMjyEgvuzCVwlb+ux1/eTeeB5agCxCiOfRDLnjZeho6lDg3GGAi+lqIwXeoLAtS9LuyyDlteuHV4Dol00+Eg6IkqvF5LDVps0iHBb2jf+mt62RHjH9cIlrfzag5AcUTPk98U9Dzti5XI1jR9DEjzTZz9cGqeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zvs42O4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0187C4CECE;
	Sat,  9 Nov 2024 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731165342;
	bh=VJ9+yL4/Qo6csHxmltBLugUE69mq36tQ6mfEaJh/YeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zvs42O4DOgKodK1TVptRlfMe7K+kCM9K8JReUjWCtsRxb4rOuLx+ukaDcddGAw08S
	 n+JN/YPByhxF+1e4uXRfSWBJacmuZ3EblQXlJDlhIerAX9Cqulav7Sd0N3JS+13g4X
	 49r5rgRcL0ECJ9jO992a6gDZWlHk7PQlWgm9zhQLtxQiK6TcB0tmQO1ccDDpHVqELZ
	 BbQT0U/if5IY6+aFbvj8bUiCGVLEDkD/ittWQwzY4INH7vWXL+9Gk1yJwLOhpyjJhd
	 GqDn2v75wOJj7fhsnM7t+gY3HSf5dcwr//sP2Zd567f+ZYOm0+G50npKVSwdjHexTU
	 JvgJBUoPbgioA==
Date: Sat, 9 Nov 2024 15:15:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Krzysztof
 Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hwmon: tmp108: Add support for I3C device
Message-ID: <20241109151531.37ac4226@jic23-huawei>
In-Reply-To: <014410fc-8a4c-440f-a6eb-1fafccc444a6@roeck-us.net>
References: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
	<20241108-p3t1085-v2-3-6a8990a59efd@nxp.com>
	<20241109131604.5d8b701a@jic23-huawei>
	<014410fc-8a4c-440f-a6eb-1fafccc444a6@roeck-us.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Nov 2024 06:53:28 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On 11/9/24 05:16, Jonathan Cameron wrote:
> > On Fri, 08 Nov 2024 17:26:57 -0500
> > Frank Li <Frank.Li@nxp.com> wrote:
> >   
> >> Add support for I3C device in the tmp108 driver to handle the P3T1085
> >> sensor. Register the I3C device driver to enable I3C functionality for the
> >> sensor.
> >>
> >> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >> ---
> >>   drivers/hwmon/tmp108.c | 31 +++++++++++++++++++++++++++++++
> >>   1 file changed, 31 insertions(+)
> >>
> >> diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
> >> index bfbea6349a95f..83d6847cb542c 100644
> >> --- a/drivers/hwmon/tmp108.c
> >> +++ b/drivers/hwmon/tmp108.c
> >> @@ -13,6 +13,8 @@
> >>   #include <linux/mutex.h>
> >>   #include <linux/of.h>
> >>   #include <linux/i2c.h>
> >> +#include <linux/i3c/device.h>
> >> +#include <linux/i3c/master.h>  
> > 
> > Seems odd you need master.h in a device driver.
> > I'll guess that's because you should be using i3cdev_to_device()  
> 
> I assume you mean i3cdev_to_dev() ?
> 
Indeed! :(

> Good point, but there are not many examples to draw from. The one
> existing iio driver (st_lsm6dsx) doesn't use it either. I'll send
> a patch shortly to fix that to prevent others from making the same
> mistake.
Excellent.
> 
> Thanks,
> Guenter
> 


