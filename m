Return-Path: <linux-iio+bounces-24529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A63EBA6F2C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 12:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEE3C7A213E
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161212DC339;
	Sun, 28 Sep 2025 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F81ZZNL/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4A41DC9B5;
	Sun, 28 Sep 2025 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759055569; cv=none; b=mhYDjt90Yt3bwFQAJPYOPwK4+uoR/SNQX7ZPQsDF/15NIJjQRXieKdN9Vvxq3t9/UB4Ze+Xnef9oTxt9/FpVHEnYwYt8s2/THcwOUNnkYKMW1B5qUITgGWfiZxPZ1juualehvWTl/+MROzxh9DlerSGaOTU6TqWAo6isZW+3pSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759055569; c=relaxed/simple;
	bh=iW5PZ047R8tg5QXPTMoCd640qW4nDqm5nKOSscw1Q0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIz+dOPD32E2cc/gNHYP/MG1+Y8SgKj3P2v26U5FvHq15QjDn4fp5C9SBO4A7tKWgGbnk5s9dRR7sOSGA7PPX8uQU6wd7/Hc/lDM105/sFF4oKkpucTqNMwMn1km2iM6dCBguBEa8X1YhKawO/K2NUZVg6SmsxJ5+jYZjnPEARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F81ZZNL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75C5C4CEF0;
	Sun, 28 Sep 2025 10:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759055566;
	bh=iW5PZ047R8tg5QXPTMoCd640qW4nDqm5nKOSscw1Q0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F81ZZNL/z5yVabIVXXsY82B25C8qIIiCngWBgCs5vsgoFOuZBapnROoVIRr1X+Jbm
	 VJ7ckGwZrXEO3I+JyyMkoH9x97PKhUfnRvWgybs4eDENye39X2QEXfKIhhfL5Ng+J6
	 YZLXmqtTDD5nb6/oH45RikBabhDQgkS5tVVikLVQ6BhXyyg8CjRcrA845JVhFdj+pX
	 j5novLJmDT10LXDzPvbFYNof8k+OBzWHFHYtEqfX9Gbk0kQJ1lmRLdrXynrdJlJ7nt
	 rfBu4bZGzid79nP1hHgWvJx4rEOnFfCJ8um4MLTPlSO0Aeh9NIapu64MBl1pO25tih
	 HYc6qnxOGHadA==
Date: Sun, 28 Sep 2025 11:32:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux@roeck-us.net, rodrigo.gobbi.7@gmail.com,
 naresh.solanki@9elements.com, michal.simek@amd.com,
 grantpeltier93@gmail.com, farouk.bouabid@cherry.de,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 3/4] iio: mpl3115: add support for DRDY interrupt
Message-ID: <20250928113234.3ba70df8@jic23-huawei>
In-Reply-To: <20250928100232.tafcimfsoljdq6nt@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250926220150.22560-1-apokusinski01@gmail.com>
	<20250926220150.22560-4-apokusinski01@gmail.com>
	<20250927175125.66bcc18c@jic23-huawei>
	<20250928100232.tafcimfsoljdq6nt@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > > +static int mpl3115_trigger_probe(struct mpl3115_data *data,
> > > +				 struct iio_dev *indio_dev)
> > > +{
> > > +	struct fwnode_handle *fwnode = dev_fwnode(&data->client->dev);
> > > +	int ret, irq, irq_type, irq_cfg_flags = 0;
> > > +
> > > +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> > > +	if (irq < 0) {
> > > +		irq = fwnode_irq_get_byname(fwnode, "INT2");
> > > +		if (irq < 0)
> > > +			return 0;
> > > +
> > > +		irq_cfg_flags |= MPL3115_INT2;
> > > +	}
> > > +
> > > +	irq_type = irq_get_trigger_type(irq);
> > > +	if (irq_type != IRQF_TRIGGER_RISING && irq_type != IRQF_TRIGGER_FALLING)
> > > +		return -EINVAL;
> > > +
> > > +	irq_cfg_flags |= irq_type;  
> > Commented on this before, but mixing flags that are local to this driver
> > with those that are global provides not guarantees against future changes
> > of the global ones to overlap with your local values.
> > 
> > So just track these as two separate values rather than combining them.
> >  
> 
> So you mean 2 separate variables, one for INT1/INT2 and one for the
> trigger RISING/FALLING, am I right?

Yes.

> This was the approach in v1, but the code for writing the regs CTRL3 and
> CTRL5 should be improved, I was thinking something like:
> 
> if (irq_pin == MPL3115_IRQ_INT1) {
>     write_byte_data(REG5, INT_CFG_DRDY);
>     if (irq_type == IRQF_TRIGGER_RISING)
>         write_byte_data(REG3, IPOL1);
> } else if (irq_type == IRQF_TRIGGER_RISING) {
>     write_byte_data(REG3, IPOL2);
> }
> 
> This is perhaps a bit less readable than the switch(int_cfg_flags) with 4
> cases... but IMO it's still quite ok and it's less verbose since we do not
> duplicate the write_byte_data(REG5, INT_CFG_DRDY).

That looks ok to me.

...

				 indio_dev->name,
> > > +						 iio_device_id(indio_dev));
> > > +	if (!data->drdy_trig)
> > > +		return -ENOMEM;
> > > +
> > > +	data->drdy_trig->ops = &mpl3115_trigger_ops;
> > > +	iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> > > +	ret = devm_iio_trigger_register(&data->client->dev, data->drdy_trig);  
> > 
> > Whilst unlikely the race matters. It is this call that creates the infrastructure
> > that might allow the interrupt generation to be triggered via userspace controls.
> > So the handler should probably be in place firsts.  I.e. do the devm_request_threaded_irq
> > before this.
> >  
> Will fix in v4

Side process related note: If you agree with something, just crop it out!  That means
we get to focus in quickly on the bits where there is more discussion to be done.

Your change log in v4 is where I'll see you made these changes.

When there is nothing to continue the discussion around in a thread, don't reply at all.
Thanks etc can come alongside the change log.

Thanks,

Jonathan

p.s. I have periodic sessions of mailing people about the process stuff once the
overall list traffic is larger than it should be for stuff like this. You just happened
to be an 'unlucky' recipient today!

