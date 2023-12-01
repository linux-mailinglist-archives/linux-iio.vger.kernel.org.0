Return-Path: <linux-iio+bounces-537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B4B801284
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 19:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B494A1C203DE
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 18:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A4D4F21D;
	Fri,  1 Dec 2023 18:20:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D4F9;
	Fri,  1 Dec 2023 10:20:47 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ShhDz0xc5z689rj;
	Sat,  2 Dec 2023 02:20:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 06FF8140B33;
	Sat,  2 Dec 2023 02:20:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Dec
 2023 18:20:44 +0000
Date: Fri, 1 Dec 2023 18:20:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Marek Vasut <marex@denx.de>
CC: "Dr.-Ing. Andre Werner" <andre.werner@systec-electronic.com>,
	<linux-iio@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Matti Vaittinen
	<mazziesaccount@gmail.com>, Alexander Stein
	<alexander.stein@ew.tq-group.com>, Bjorn Helgaas <bhelgaas@google.com>, Conor
 Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@denx.de>, Guenter Roeck
	<linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown
	<broonie@kernel.org>, Naresh Solanki <naresh.solanki@9elements.com>, Patrick
 Rudolph <patrick.rudolph@9elements.com>, Rob Herring <robh+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>, Vincent Tremblay
	<vincent@vtremblay.dev>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <20231201182043.000043a3@Huawei.com>
In-Reply-To: <124ca1d8-5569-4c6c-8019-24e58dd8a5fc@denx.de>
References: <20231125222738.97875-1-marex@denx.de>
	<20231125222738.97875-2-marex@denx.de>
	<907048010.848203.1701027206602.JavaMail.zimbra@systec-electronic.com>
	<124ca1d8-5569-4c6c-8019-24e58dd8a5fc@denx.de>
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

On Sun, 26 Nov 2023 23:17:55 +0100
Marek Vasut <marex@denx.de> wrote:

> On 11/26/23 20:33, Dr.-Ing. Andre Werner wrote:
> 
> [...]
> 
> > +static int isl76682_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int val, int val2, long mask)
> > +{
> > +	struct isl76682_chip *chip = iio_priv(indio_dev);
> > +	int i;
> > +
> > +	if (chan->type != IIO_LIGHT && chan->type != IIO_INTENSITY)
> > +		return -EINVAL;
> > 
> > In my understanding, this is not necessary as you use that 'iio_chan_spec' to specify
> > the channels available at all. So there will be no other channel types created by the IIO environment, I think.  
> 
> That's a good point, I think we can drop it in this case and the next one.
> 
> Jonathan , is there any reason you can think of why this shouldn't be 
> dropped ?

I don't mind a little paranoia, but fine with dropping it as well.

The reason paranoia is fine is that if other channels are added in future
we might not remember to fix this up if they happen to have no writeable attributes.
I leave that assessment up to driver authors.

Jonathan

> 
> I'll add it into V6, thanks.
> 


