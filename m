Return-Path: <linux-iio+bounces-17210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFB8A6CF06
	for <lists+linux-iio@lfdr.de>; Sun, 23 Mar 2025 12:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D948B1898B4F
	for <lists+linux-iio@lfdr.de>; Sun, 23 Mar 2025 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECCE204844;
	Sun, 23 Mar 2025 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDU6cPdN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5F1EE028;
	Sun, 23 Mar 2025 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742730696; cv=none; b=l1WdEu/Rjx103jTffqF/RsFtfQS3oxa3O3eowMQC0S+8SR/J0izVf9dziyECyP4EiVQWiBZDSxZXS5mPWy8H2Hcys/tIXmrqW75aGh9cQDw1gU2jkdCAbYBtFRbL8rYZgi+7ktUDQ7I7WSOfFWEJH6YMJlsTmZLhzdP79XrnxAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742730696; c=relaxed/simple;
	bh=Z6VZv9XJvfOC4nN8cMFRk96f0NsWhkMi6zOL4ll7Xa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzN7htG7+0uAptZ91BlYUJW++auAd7JccdP/H5x2R8KGw/G+cnHU8PA7BVPxhfQsyjLpNLXmv4Koc5zDRlXWJsozoNCGCG/gjLxOi5QvOpxvFEQumqJScqtoSR4JRhrWNXXdKlGNxH8/EVCrShVYvJTaZodgmMqvloUr6N/EtBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDU6cPdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D11C4CEE2;
	Sun, 23 Mar 2025 11:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742730693;
	bh=Z6VZv9XJvfOC4nN8cMFRk96f0NsWhkMi6zOL4ll7Xa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hDU6cPdNd6G9oxSCct04hGTaz+JRXmVluqzQLEOcyHyktP47QBz1LmHxSul2iTy5N
	 gAyAb6WM54kkliRGHr/oqemLkgCQ2kwzQgHNgsr2aASoSA/GWzjTuzA5MPDM1q8UP4
	 si00iD3tPnRbFZHU5xSwbSDN39JFaTd4dRkWcA+pF66qn/kJL0hisIxzZTMXg+Yj3B
	 Mk0sRbggj0KWaPPmF508floU2VVPKB1eiQCX4Gk16hV6ohlTyYRjov02MmWYWmc8/n
	 RVOQqKE2jEy2KxUnH+LpZRULa8JRktRUp3niL7+3DSkRU086wUpD/gauoRgliPgSdJ
	 qlS036RZhVpPg==
Date: Sun, 23 Mar 2025 11:51:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com,
 mazziesaccount@gmail.com, subhajit.ghosh@tweaklogic.com,
 muditsharma.info@gmail.com, arthur.becker@sentec.com,
 ivan.orlov0322@gmail.com
Subject: Re: [PATCH 2/3] iio: light: add support for veml6046x00 RGBIR color
 sensor
Message-ID: <20250323115129.665457c0@jic23-huawei>
In-Reply-To: <Z9jXLYYbY7nKDwA-@mail.your-server.de>
References: <20250316113131.62884-1-ak@it-klinger.de>
	<20250316113131.62884-3-ak@it-klinger.de>
	<20250317115005.72a539a0@jic23-huawei>
	<Z9jXLYYbY7nKDwA-@mail.your-server.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > > +	data = iio_priv(iio);
> > > +	i2c_set_clientdata(i2c, iio);
> > > +	data->dev = dev;
> > > +	data->regmap = regmap;
> > > +
> > > +	ret = veml6046x00_regfield_init(data);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Failed to init regfield\n");
> > > +
> > > +	ret = devm_regulator_get_enable(dev, "vdd");
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> > > +
> > > +	ret = devm_add_action_or_reset(dev, veml6046x00_shutdown_action, data);  
> > 
> > Mostly we want a devm action to match against a specific setup operation.  Here is
> > it that the device comes up in non shut down state?  Perhaps a comment to
> > make it clear.  Also, how do we know it's in a good state rather than part
> > configured by someone else?  I'm not seeing a reset sequence though perhaps
> > that effectively happens in setup_device()  
> 
> In veml6046x00_setup_device() all registers are set up to bring the device in a
> known state. This function also switches the device on. I could move the call to
> setup_device() up to here and add a comment to make it clear.

Perfect.


