Return-Path: <linux-iio+bounces-585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D9B8036E6
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 15:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D14B281169
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 14:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFBC28DC4;
	Mon,  4 Dec 2023 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBTHRZHS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9322F07;
	Mon,  4 Dec 2023 14:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CA4C433C8;
	Mon,  4 Dec 2023 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701700533;
	bh=43kZFxboZ4YHoUC1LLSWMdjlMCmjRQLpNL6yIzCv1ok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MBTHRZHSVjsriGMLsBOOJy6+2Udr/gW1c78Zn2Nxh9AF1rmd9cp6kfCTrdQ+XGr0C
	 knttF9rDe9zvGzkZo3z4RMkbd5o5nrjvb+Udr8peaH+VpBf4SGwZmSGrsuVUD4KNX3
	 MGgZ1APITGNKjo/Y8RpidIPCjy1F3WOx3XtDXy1Dzj3wqVK8OYhXM//RhBD4CEc+LC
	 c9YyU5DFxa8d3adpmRMMTvhGcUZK7qQtXnwejMla1X0qIDOL4jlzVDfNPTO/wmcJj6
	 HyhMT7VBcSvTdPxfDLxhy4MGEeffovyrj94z2nnSNcQ5UaeSYKczjvLg80KIEIXGMX
	 VCayo+Ji5hmIw==
Date: Mon, 4 Dec 2023 14:35:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Andre Werner
 <andre.werner@systec-electronic.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@denx.de>,
 Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Rob Herring <robh+dt@kernel.org>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>, Vincent Tremblay
 <vincent@vtremblay.dev>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <20231204143521.5ca0fc7e@jic23-huawei>
In-Reply-To: <6e4ed42c-21be-469c-a8bb-57779ef24bf9@denx.de>
References: <20231127212726.77707-1-marex@denx.de>
	<20231127212726.77707-2-marex@denx.de>
	<20231204112001.7dff7066@jic23-huawei>
	<6e4ed42c-21be-469c-a8bb-57779ef24bf9@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 12:23:06 +0100
Marek Vasut <marex@denx.de> wrote:

> On 12/4/23 12:20, Jonathan Cameron wrote:
> > On Mon, 27 Nov 2023 22:26:53 +0100
> > Marek Vasut <marex@denx.de> wrote:
> >   
> >> The ISL76682 is very basic ALS which only supports ALS or IR mode
> >> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> >> other fancy functionality.
> >>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> Signed-off-by: Marek Vasut <marex@denx.de>  
> > Hi Marek,
> > 
> > Discussion around available on v5 made me look closer at that aspect.
> > You are providing all the available entries in the callback but they
> > shouldn't be exposed to actually read unless the *_available bitmap
> > bits corresponding to them are set.
> > 
> > If you like I can just rip the unused code out whilst applying?
> > Or if you'd prefer to send a v7 that's great too.
> > 
> > Otherwise everything looks good to me.  
> 
> Maybe just do that while applying and I'll test it right after to see 
> whether something broke, that's probably fastest. Just let me know where 
> this got applied. I have the device on my desk .

Diff is below.  Applied to the togreg branch of iio.git and initially pushed out
as testing for normal reasons + for you to test.

Thanks,

Jonathan


diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
index 15a68609985b..8605187bfb62 100644
--- a/drivers/iio/light/isl76682.c
+++ b/drivers/iio/light/isl76682.c
@@ -184,8 +184,6 @@ static int intensity_scale_available[] = {
        0, 673000,
 };
 
-static int integration_time_available[] = { 0, ISL76682_INT_TIME_US };
-
 static int isl76682_read_avail(struct iio_dev *indio_dev,
                               struct iio_chan_spec const *chan,
                               const int **vals, int *type,
@@ -207,11 +205,6 @@ static int isl76682_read_avail(struct iio_dev *indio_dev,
                default:
                        return -EINVAL;
                }
-       case IIO_CHAN_INFO_INT_TIME:
-               *vals = integration_time_available;
-               *length = ARRAY_SIZE(integration_time_available);
-               *type = IIO_VAL_INT_PLUS_MICRO;
-               return IIO_AVAIL_LIST;
        default:
                return -EINVAL;
        }




