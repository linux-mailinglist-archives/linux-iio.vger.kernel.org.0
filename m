Return-Path: <linux-iio+bounces-8305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E2994A823
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 14:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08AD281F18
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFCF1E6746;
	Wed,  7 Aug 2024 12:57:40 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005D11E3CBE;
	Wed,  7 Aug 2024 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035460; cv=none; b=OwqR6uaErj3g3MSTntUglbMWiJ5rD926WBpHZGfSZCSQSocuA/dlXlJCPdY+ZEoMKKqkBXPDQFXTJqdSqRukKrmU3KMi8VvPYsHWg3EfWgJfEtQD1W+AaqsIr5CdHMNY9oxUUKgP/tRUwL9fLjAFfxIDIcSROucY5ragxfImKpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035460; c=relaxed/simple;
	bh=Rxq0DBkB+xoXm/qVxDT5AhEtVPkMEZuS6YL0SxnWQBg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXocguiGpmujrFxQwORNXrgNFdulVMXYOWlc3IKRf/MBegvoidS7Bpd18Xm5Bm/SzjFsuHwgZonrgqORFIKpbh8C/evYlU/2Ou5HT9zbXJOoLDdjRRMtdhj8xsQt6mblIWwGWhiTNzu2Y/HrSG/G6AntUz+KCul22gho2OcZo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wf99q2dX9z6K7Cp;
	Wed,  7 Aug 2024 20:54:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 41B9A1402C6;
	Wed,  7 Aug 2024 20:57:33 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 7 Aug
 2024 13:57:32 +0100
Date: Wed, 7 Aug 2024 13:57:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Denis Benato <benato.denis96@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Luke D . Jones" <luke@ljones.dev>, Jonathan
 LoBue <jlobue10@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: bmi323: suspend and resume triggering on
 relevant pm operations
Message-ID: <20240807135731.0000320f@Huawei.com>
In-Reply-To: <b7e91e68-9f5f-4dd0-aa96-e57983e4a56d@gmail.com>
References: <20240727123034.5541-1-benato.denis96@gmail.com>
	<20240727123034.5541-3-benato.denis96@gmail.com>
	<20240803164428.50fdd15c@jic23-huawei>
	<b7e91e68-9f5f-4dd0-aa96-e57983e4a56d@gmail.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 4 Aug 2024 17:40:49 +0200
Denis Benato <benato.denis96@gmail.com> wrote:

> On 03/08/24 17:44, Jonathan Cameron wrote:
> > On Sat, 27 Jul 2024 14:30:34 +0200
> > Denis Benato <benato.denis96@gmail.com> wrote:
> >   
> >> Prevent triggers from stop working after the device has entered sleep:
> >> use iio_device_suspend_triggering and iio_device_resume_triggering helpers.  
> > 
> > Hi Denis,
> >   
> Hello Jonathan,
> > I'd got it into my head this was about main suspend / resume, but
> > it's runtime PM. I assume the s2idle uses only that level which is
> > interesting.
> >   
> I have catched the problem with s2idle, but I don-t fully understand
> it will manifest outside of said scenario, nor if it will at all and
> only s2idle is affected.
> 
> > Anyhow, solution seems safe. We might be able to do something nicer
> > in the long run as potentially we could have the trigger driver
> > notified when all consumers have entered this state at which point it
> > could stop generating triggers at all.
> > Totally agree.
> > Anyhow, that's a job for when we actually care about it.
> > 
> > Applied to the togreg branch of iio.git and pushed out as testing
> > for 0-day to poke at it.
> >   
> I have made a mistake while cleaning up patch 1/2 for submission and lost a piece:
> the pollfunc->irq=0 you suggested in your first mail.
> 
> I would be more than happy to provide a v3, but if you prefer I can also send
> a separate patch.
Send a v3. I'll try and remember to drop the v2 before sending a pull request
upstream.

> 
> I am sorry about that and I would like guidance on what to do in cases like this.

Not a problem, we all do stuff like this from time to time!

> > For now I'm not keen to see this pushed into drivers where we don't
> > know if anyone is running into this particular situation.  We can
> > reevaluate that if we start getting lots of reports of this.
> >   
> I catched the issue while developing an application for a handheld PC.
> 
> As the application will target these kind of devices we can apply the fix
> to every relevant driver (bmi260 comes to mind) and have that well-tested
> on multiple drivers.

Ok. Let's see how it goes with a few drivers.

Jonathan

> > I'm also not going to rush this in as a fix. We can consider backporting
> > it once it's been in mainline for a bit and no side effects have
> > shown up.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> Thanks,
> 
> Denis
> >>
> >> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> >> ---
> >>  drivers/iio/imu/bmi323/bmi323.h      |  1 +
> >>  drivers/iio/imu/bmi323/bmi323_core.c | 23 +++++++++++++++++++++++
> >>  drivers/iio/imu/bmi323/bmi323_i2c.c  |  1 +
> >>  drivers/iio/imu/bmi323/bmi323_spi.c  |  1 +
> >>  4 files changed, 26 insertions(+)
> >>
> >> diff --git a/drivers/iio/imu/bmi323/bmi323.h b/drivers/iio/imu/bmi323/bmi323.h
> >> index dff126d41658..209bccb1f335 100644
> >> --- a/drivers/iio/imu/bmi323/bmi323.h
> >> +++ b/drivers/iio/imu/bmi323/bmi323.h
> >> @@ -205,5 +205,6 @@
> >>  struct device;
> >>  int bmi323_core_probe(struct device *dev);
> >>  extern const struct regmap_config bmi323_regmap_config;
> >> +extern const struct dev_pm_ops bmi323_core_pm_ops;
> >>  
> >>  #endif
> >> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> >> index d708d1fe3e42..4b2b211a3e88 100644
> >> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> >> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> >> @@ -2121,6 +2121,29 @@ int bmi323_core_probe(struct device *dev)
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
> >>  
> >> +#if defined(CONFIG_PM)
> >> +static int bmi323_core_runtime_suspend(struct device *dev)
> >> +{
> >> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >> +
> >> +	return iio_device_suspend_triggering(indio_dev);
> >> +}
> >> +
> >> +static int bmi323_core_runtime_resume(struct device *dev)
> >> +{
> >> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >> +
> >> +	return iio_device_resume_triggering(indio_dev);
> >> +}
> >> +
> >> +#endif
> >> +
> >> +const struct dev_pm_ops bmi323_core_pm_ops = {
> >> +	SET_RUNTIME_PM_OPS(bmi323_core_runtime_suspend,
> >> +			   bmi323_core_runtime_resume, NULL)
> >> +};
> >> +EXPORT_SYMBOL_NS_GPL(bmi323_core_pm_ops, IIO_BMI323);
> >> +
> >>  MODULE_DESCRIPTION("Bosch BMI323 IMU driver");
> >>  MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
> >>  MODULE_LICENSE("GPL");
> >> diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
> >> index 52140bf05765..057342f4f816 100644
> >> --- a/drivers/iio/imu/bmi323/bmi323_i2c.c
> >> +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
> >> @@ -128,6 +128,7 @@ MODULE_DEVICE_TABLE(of, bmi323_of_i2c_match);
> >>  static struct i2c_driver bmi323_i2c_driver = {
> >>  	.driver = {
> >>  		.name = "bmi323",
> >> +		.pm = pm_ptr(&bmi323_core_pm_ops),
> >>  		.of_match_table = bmi323_of_i2c_match,
> >>  		.acpi_match_table = bmi323_acpi_match,
> >>  	},
> >> diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
> >> index 7b1e8127d0dd..487d4ee05246 100644
> >> --- a/drivers/iio/imu/bmi323/bmi323_spi.c
> >> +++ b/drivers/iio/imu/bmi323/bmi323_spi.c
> >> @@ -79,6 +79,7 @@ MODULE_DEVICE_TABLE(of, bmi323_of_spi_match);
> >>  static struct spi_driver bmi323_spi_driver = {
> >>  	.driver = {
> >>  		.name = "bmi323",
> >> +		.pm = pm_ptr(&bmi323_core_pm_ops),
> >>  		.of_match_table = bmi323_of_spi_match,
> >>  	},
> >>  	.probe = bmi323_spi_probe,  
> >   
> 
> 


