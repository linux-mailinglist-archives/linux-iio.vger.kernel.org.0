Return-Path: <linux-iio+bounces-17375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8399A75B81
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FBF168A62
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442E61D7998;
	Sun, 30 Mar 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qv+60sBq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C6322E;
	Sun, 30 Mar 2025 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743356834; cv=none; b=J5R2xvP5CxqsKfz4M8itII4znpGmPvzQayimdG0GW7PocxVl9qOSkM98Irlt0HJhTysR8OYltOZTCFmnUbyDdEUaTJqm0z7BLswkNQkjCcocQNEc4WwGGw2FQH6xOLAalE80PpIO6uA1eKo0NWt7u1CjcIz9Rv7yQw1CdAHHDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743356834; c=relaxed/simple;
	bh=pi/5a/9uYyYOqfzdr22/HIB7loYWIwyjfEUykCzLbR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hA4VDlR1Z1xcKlZIB0MZZKvcTXC2BPE2vmzTaQPzbDtrdbQkzGa7JIE7XvHSUQFwio6MiYE2bZEkdA9+88r2+WTr3YoDYnWrAZG0YGkPDxEvuMOJdgyhQEILedE+Dag/7FDyiacgZkSL2s2ZXfq46deresSuqRQClz9nI6uOvrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qv+60sBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E90EC4CEDD;
	Sun, 30 Mar 2025 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743356833;
	bh=pi/5a/9uYyYOqfzdr22/HIB7loYWIwyjfEUykCzLbR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qv+60sBq+0wTjq4Q/3UDOYW0yqu9VST6u35CPsyZCo5Miy4toveDUQrfbmouxjZxk
	 etlqAoSFSkYa+8ZMM0ZmEGpGA8xPjs9Lr/Dw7t1tve+LWz+nLhL1XnZtOVgFpLMo9m
	 FhDZvsyyBKv3jH8VuRhuM+Gki5W/hYMEOM2xK/EEgWa2rclD8dsKuesjLlWXB4lvS2
	 ndhRQSJ3q93oZLA51NBtoowa1cw4+b+SfsK5eUB/w3ttPE33u0sG45wnqe6eHF1ZZn
	 uWByJQYgHg3kn4+vVP7Vrnd5+txxGlzV6GQenYYVVy607k5hOUJFjJQIGJlpe3u90c
	 cgfqKaZraF+Dg==
Date: Sun, 30 Mar 2025 18:47:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/13] iio: light: al3010: Implement regmap support
Message-ID: <20250330184705.7a9b1211@jic23-huawei>
In-Reply-To: <20250330184538.5b5e6f39@jic23-huawei>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
	<20250319-al3010-iio-regmap-v2-12-1310729d0543@ixit.cz>
	<20250330184538.5b5e6f39@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Mar 2025 18:45:38 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 19 Mar 2025 21:59:51 +0100
> David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:
> 
> > From: David Heidelberg <david@ixit.cz>
> > 
> > Modernize and make driver a bit cleaner.
> > 
> > After the regmap implementation, the compiler is able to produce
> > much smaller module.
> > 
> > Size before: 72 kB
> > Size after:  58 kB
> > 
> > Signed-off-by: David Heidelberg <david@ixit.cz>  
> Just one real comment on your code. 
> Also a passing musing that you can feel free to ignore!
> 
> Jonathan
> 
> 
> >  static void al3010_set_pwr_off(void *_data)
> >  {
> >  	struct al3010_data *data = _data;
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +	int ret;
> >  
> > -	i2c_smbus_write_byte_data(data->client, AL3010_REG_SYSTEM,
> > -				  AL3010_CONFIG_DISABLE);
> > +	ret = regmap_write(data->regmap, AL3010_REG_SYSTEM, AL3010_CONFIG_DISABLE);
> > +	if (ret)
> > +		dev_err(dev, "failed to write system register\n");  
> 
> Unrelated to your patch, but I wonder if there is appetite for
> 		regmap_err(data->regmap, "failed to write system register\n");
> 
> A lot of drivers carry a local dev pointer because the regmap_get_device() stuff
> is a bit clunky. They only use it in many paths for prints like this.
> 
> >  }  
> 
> 
> > @@ -204,7 +210,9 @@ static int al3010_suspend(struct device *dev)
> >  
> >  static int al3010_resume(struct device *dev)
> >  {
> > -	return al3010_set_pwr_on(to_i2c_client(dev));
> > +	struct al3010_data *data = iio_priv(dev_get_drvdata(dev));  
> 
> Why this change?
Ah. Obvious.  Ignore me.
> 
> > +
> > +	return al3010_set_pwr_on(data);
> >  }
> >  
> >  static DEFINE_SIMPLE_DEV_PM_OPS(al3010_pm_ops, al3010_suspend, al3010_resume);
> >   
> 


