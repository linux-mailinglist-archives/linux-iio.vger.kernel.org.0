Return-Path: <linux-iio+bounces-197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99C47F19E0
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 18:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161581C2110D
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 17:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B39208DF;
	Mon, 20 Nov 2023 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD0D10F;
	Mon, 20 Nov 2023 09:28:06 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SYvZB3s7mz6K9Kv;
	Tue, 21 Nov 2023 01:26:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 20 Nov
 2023 17:28:03 +0000
Date: Mon, 20 Nov 2023 17:28:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Marek Vasut <marex@denx.de>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Conor
 Dooley" <conor.dooley@microchip.com>, Alexander Stein
	<alexander.stein@ew.tq-group.com>, Andre Werner
	<andre.werner@systec-electronic.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@denx.de>, Guenter
 Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>, Naresh Solanki
	<naresh.solanki@9elements.com>, Patrick Rudolph
	<patrick.rudolph@9elements.com>, Rob Herring <robh+dt@kernel.org>, "Stefan
 Windfeldt-Prytz" <stefan.windfeldt-prytz@axis.com>, Vincent Tremblay
	<vincent@vtremblay.dev>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: isl76682: Document
 ISL76682
Message-ID: <20231120172802.00006f38@Huawei.com>
In-Reply-To: <4fe94f10-ff06-417b-a6d5-433bfeeac641@denx.de>
References: <20231118000614.186558-1-marex@denx.de>
	<20231119150756.20a023b5@jic23-huawei>
	<4fe94f10-ff06-417b-a6d5-433bfeeac641@denx.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Sun, 19 Nov 2023 19:08:45 +0100
Marek Vasut <marex@denx.de> wrote:

> On 11/19/23 16:07, Jonathan Cameron wrote:
> > On Sat, 18 Nov 2023 01:06:09 +0100
> > Marek Vasut <marex@denx.de> wrote:
> >   
> >> The ISL76682 is very basic ALS which only supports ALS or IR mode
> >> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> >> other fancy functionality. Document it as trivial device.
> >>
> >> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >> Signed-off-by: Marek Vasut <marex@denx.de>  
> > 
> > I'm always a bit in 2 minds about trivial-devices as it doesn't
> > include a basic power supply.  In this case vdd which I'd prefer
> > to see documented even on such a simple device as this.
> > Not everyone is going to leave it powered up all the time!
> > 
> > Still I'm not that fussed. Maybe it's worth allowing vdd-supply in
> > trivial-devices.yaml?  
> 
> The hardware I have is powered all the time, so I'd be adding completely 
> untested code which is no less useless for me (at least right now). Lets 
> postpone this until there is a need for it, can we ?

It's untested but trivial code (one call and an error code check) but fair enough.
Previous experience says that we'll soon see it added... Its probably the most common
follow up patch for a new driver.

> 
> I addressed all the other comments in 2/2.
> 


