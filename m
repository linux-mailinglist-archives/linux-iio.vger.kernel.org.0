Return-Path: <linux-iio+bounces-536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC82180126E
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 19:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E52FB211A0
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF77E4F206;
	Fri,  1 Dec 2023 18:17:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFD7194;
	Fri,  1 Dec 2023 10:17:25 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Shh7j1n26z6K91p;
	Sat,  2 Dec 2023 02:15:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E79A1401E0;
	Sat,  2 Dec 2023 02:17:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Dec
 2023 18:17:22 +0000
Date: Fri, 1 Dec 2023 18:17:21 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Marek Vasut <marex@denx.de>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Matti Vaittinen
	<mazziesaccount@gmail.com>, Alexander Stein
	<alexander.stein@ew.tq-group.com>, Andre Werner
	<andre.werner@systec-electronic.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@denx.de>, Guenter
 Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
	Naresh Solanki <naresh.solanki@9elements.com>, Patrick Rudolph
	<patrick.rudolph@9elements.com>, Rob Herring <robh+dt@kernel.org>, "Stefan
 Windfeldt-Prytz" <stefan.windfeldt-prytz@axis.com>, Vincent Tremblay
	<vincent@vtremblay.dev>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <20231201181721.0000445c@Huawei.com>
In-Reply-To: <9e73c450-2380-459a-9b41-a1b88f89548c@denx.de>
References: <20231125222738.97875-1-marex@denx.de>
	<20231125222738.97875-2-marex@denx.de>
	<20231126181655.4e1040f9@jic23-huawei>
	<9e73c450-2380-459a-9b41-a1b88f89548c@denx.de>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 26 Nov 2023 23:09:36 +0100
Marek Vasut <marex@denx.de> wrote:

> On 11/26/23 19:16, Jonathan Cameron wrote:
> > On Sat, 25 Nov 2023 23:26:23 +0100
> > Marek Vasut <marex@denx.de> wrote:
> >   
> >> The ISL76682 is very basic ALS which only supports ALS or IR mode
> >> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> >> other fancy functionality.
> >>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> Signed-off-by: Marek Vasut <marex@denx.de>  
> > 
> > Hi Marek,
> > 
> > One last question + a comment in general. Act on that if you like.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> >> +static int integration_time_available[] = { 0, ISL76682_INT_TIME_US };  
> > 
> > Why have an available attribute for a single value. Is it useful for anything?  
> 
> To report it to userspace, iio-sensor-proxy uses that to control the ALS 
> poll interval .

It should use integration_time, not the associated available attribute.

> 
> >> +static int isl76682_probe(struct i2c_client *client)
> >> +{  
> > 
> > ...
> >   
> >> +	indio_dev->info = &isl76682_info;
> >> +	indio_dev->channels = isl76682_channels;
> >> +	indio_dev->num_channels = ARRAY_SIZE(isl76682_channels);
> >> +	indio_dev->name = ISL76682_DRIVER_NAME;  
> > Trivial but I'm not a fan of using defines in cases like this. It just makes
> > me go find the define when I could see the string directly here.
> > 
> > In cases where matching or similar strictly requires the naming to be the same
> > in various places a define is useful. In this case less so.
> > 
> > Anyhow, it's a very minor comment so never mind if you prefer to leave it
> > as it stands.  
> 
> I added it to V6 .
> 
> I'll wait for the integration time reply above and then send V6 .
> 


