Return-Path: <linux-iio+bounces-10764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B49A4CF6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 13:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C632842B5
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 11:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFD31DD875;
	Sat, 19 Oct 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbiizVSS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43451DFD84;
	Sat, 19 Oct 2024 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729336494; cv=none; b=kznEfo1z7HOnEewMqkI2rNBbEccMNBQ3jIRYxrqanloHaMArNO+If5Vnp0XtDAh1FqtWl3nmahVwvuyXvByG602uO+F299GoexU5O5tRNYEM4PZxVZcAGlCvEBUcmFKGcKMpf1t6z+nYQHw8U0z1zpzcR8wYLTkPu794vFDcyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729336494; c=relaxed/simple;
	bh=RyzKcnI3W0eX+0Jx1z9PYMnzdUZZmkR+P6UgLoIhPTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAzcb6HDQD4ghQ0NyCoZrM+kCGgCZpgcAWMXN/220aTqBYq0WHUuFHUqCvG9h1jMmUKELJnvc0u80K7RSD6XCICotLeQpWk1oA2YdVAq8oFX2QR0pU/BitDH+7tC15CS3bG2IzWP3MoZzuNRvD+KrPpgW0KiCSbtlCL4Lvzp6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbiizVSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A133C4CEC5;
	Sat, 19 Oct 2024 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729336494;
	bh=RyzKcnI3W0eX+0Jx1z9PYMnzdUZZmkR+P6UgLoIhPTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CbiizVSSrktLmoPkBdPiKjAK25UcjRvcN6EbFkdxDFSd/U8Ed9rbpv8mgVqzztozw
	 /9uRsW5jBqFGE0eZPfJ1HfuqHh9h4Ejr+kFz0r61MLBw/ricUxTDs1AxUI+I6l755Q
	 xHRuJBGH6f1LNmuSlPua1qpj9Ayq4hxn+fdJiDVoC3D22HRQjdNcr6fSQEqRnmNaJM
	 i6zL2C20/CFSBa8Pmu8UgWIKem8+JyHNBwBYqaX1bCp74ppaFr4ZiD3c6dSZGxWUIk
	 leirmMawHEGs5hYHhNiDh+ZHn2t/2+uHIeV9hOFBvGjnBUv6LakZl0JyOEMr3xGFbd
	 yIp1lMyWnubVA==
Date: Sat, 19 Oct 2024 12:14:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: magnetometer; bmc150_magn: Drop most likely
 fake ACPI IDs
Message-ID: <20241019121443.0c2856c7@jic23-huawei>
In-Reply-To: <e5cfc7d5-3f5c-44a2-a359-7b63ad7bf07a@redhat.com>
References: <20241018145805.2181682-1-andriy.shevchenko@linux.intel.com>
	<e5cfc7d5-3f5c-44a2-a359-7b63ad7bf07a@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Oct 2024 12:03:19 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 18-Oct-24 4:58 PM, Andy Shevchenko wrote:
> > The commits in question do not proove that ACPI IDs exist.
> > Quite likely it was a cargo cult addition while doing that
> > for DT-based enumeration. Drop most likely fake ACPI IDs.
> > 
> > The to be removed IDs has been checked against the following resources:
> > 1) DuckDuckGo
> > 2) Google
> > 3) MS catalog: https://www.catalog.update.microsoft.com/Search.aspx
> > This gives no useful results in regard to DSDT, moreover, the official
> > vendor IDs in the registry for Bosh are BSG and BOSC.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> 
> 
> 
> These HIDs are also not used in my acpidump collection (mostly
> BYT / CHT models):
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Some more multichip package devices in here.  Anyhow, on same
basis as the previous I'll apply the patch and we'll see if anyone shouts.

Jonathan

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> > ---
> >  drivers/iio/magnetometer/bmc150_magn_i2c.c | 9 ---------
> >  drivers/iio/magnetometer/bmc150_magn_spi.c | 9 ---------
> >  2 files changed, 18 deletions(-)
> > 
> > diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
> > index a28d46d59875..17e10a462ac8 100644
> > --- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
> > +++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
> > @@ -38,14 +38,6 @@ static void bmc150_magn_i2c_remove(struct i2c_client *client)
> >  	bmc150_magn_remove(&client->dev);
> >  }
> >  
> > -static const struct acpi_device_id bmc150_magn_acpi_match[] = {
> > -	{"BMC150B", 0},
> > -	{"BMC156B", 0},
> > -	{"BMM150B", 0},
> > -	{},
> > -};
> > -MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
> > -
> >  static const struct i2c_device_id bmc150_magn_i2c_id[] = {
> >  	{ "bmc150_magn" },
> >  	{ "bmc156_magn" },
> > @@ -67,7 +59,6 @@ static struct i2c_driver bmc150_magn_driver = {
> >  	.driver = {
> >  		.name	= "bmc150_magn_i2c",
> >  		.of_match_table = bmc150_magn_of_match,
> > -		.acpi_match_table = bmc150_magn_acpi_match,
> >  		.pm	= &bmc150_magn_pm_ops,
> >  	},
> >  	.probe		= bmc150_magn_i2c_probe,
> > diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
> > index abc75a05c46a..c850de1bc79b 100644
> > --- a/drivers/iio/magnetometer/bmc150_magn_spi.c
> > +++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
> > @@ -41,20 +41,11 @@ static const struct spi_device_id bmc150_magn_spi_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(spi, bmc150_magn_spi_id);
> >  
> > -static const struct acpi_device_id bmc150_magn_acpi_match[] = {
> > -	{"BMC150B", 0},
> > -	{"BMC156B", 0},
> > -	{"BMM150B", 0},
> > -	{},
> > -};
> > -MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
> > -
> >  static struct spi_driver bmc150_magn_spi_driver = {
> >  	.probe		= bmc150_magn_spi_probe,
> >  	.remove		= bmc150_magn_spi_remove,
> >  	.id_table	= bmc150_magn_spi_id,
> >  	.driver = {
> > -		.acpi_match_table = bmc150_magn_acpi_match,
> >  		.name	= "bmc150_magn_spi",
> >  	},
> >  };  
> 


