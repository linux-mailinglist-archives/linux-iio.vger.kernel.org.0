Return-Path: <linux-iio+bounces-10498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA88599B49B
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 13:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913001F21B66
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 11:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3896E19E967;
	Sat, 12 Oct 2024 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvywfWbz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442E19D8A9;
	Sat, 12 Oct 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728733756; cv=none; b=TZdFm4hTUlXrtR+KJPqxXXK2f+oggKZ3An9yIfsYO61yX1Yr25DCb1yqknFFfTyTnhaJwKjRhYPEhdOeFq1YY8LwKx3yQ3bK3WDPYtwnTFXzu7DFDiGshibTdYC8SXw5GnGAVzgjUIuIzXvOEj3/AmM0TPvYMzkGiKDyFWQh6YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728733756; c=relaxed/simple;
	bh=ayHqr4UPyqeErk3NI2av9IV9VxtnZOYMncyiCnoXVSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIo6WzUAOF5uMFBwW71LT1LacnY29yhd3crXntP6ciC9vj8Ay4Q39FDtfRz57wRgja+2ukfRZ4R2cTgTUVrWn2vrRdNUHP7xNomsPv01+TtIrTo05xos4IRDBSmMI6rb4YWA9gXuaQSwvAG5c1SbNFaF5c5tJ9cAPfqQ7tXByMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvywfWbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B70BC4CEC6;
	Sat, 12 Oct 2024 11:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728733755;
	bh=ayHqr4UPyqeErk3NI2av9IV9VxtnZOYMncyiCnoXVSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EvywfWbzeSfc/NDi2vDNoI40U55sck42XoS+LqkGMC33yEQTTvfKsPjZr4cQ0W8H5
	 8ZuBqYkWO3PTV35XcsTXFtvZNw3FZ3qvTkMHOlKqojTHMSjlgoziYwtz6Ba2T0QhCk
	 VpqrHpIyeu0lf3yJS8FnoPcEGJVs0mQefpkZBHSHu2p+HeiBVXQUIqptSUdVteneFD
	 wn5BE1giqmX0nmKcrNL3QZeJpBEOyb/U2xvImpR7eac9aj509ZGoW6MJJegiH9DWW7
	 sLGtNAD4Y7x0WQiytM8wbo/D/o32oa0Uu2DdtOGKnpHsiIm9VEO/D6S34eCZ6hFDuS
	 enjGV/tAZKIUg==
Date: Sat, 12 Oct 2024 12:49:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Aoiridis <vassilisamir@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, lars@metafoo.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, anshulusr@gmail.com,
 gustavograzs@gmail.com, andriy.shevchenko@linux.intel.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/13] dt-bindings: iio: add binding for BME680
 driver
Message-ID: <20241012124907.33b18534@jic23-huawei>
In-Reply-To: <ZwlyI3DasF7PEVqE@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
	<20241010210030.33309-7-vassilisamir@gmail.com>
	<9fc325ee-0c14-4d17-a0a5-8cf35a8ce245@kernel.org>
	<ZwlyI3DasF7PEVqE@vamoirid-laptop>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 20:44:51 +0200
Vasileios Aoiridis <vassilisamir@gmail.com> wrote:

> On Fri, Oct 11, 2024 at 08:51:00AM +0200, Krzysztof Kozlowski wrote:
> > On 10/10/2024 23:00, vamoirid wrote:  
> > > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > 
> > > Add dt-binding for BME680 gas sensor device. The device incorporates as
> > > well temperature, pressure and relative humidity sensors.
> > > 
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > ---
> > >  .../bindings/iio/chemical/bosch,bme680.yaml   | 64 +++++++++++++++++++
> > >  1 file changed, 64 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml  
> > 
> > The device is already documented. You need to move it from trivial devices.
> > 
> > Best regards,
> > Krzysztof
> >  
> 
> Hi Krzysztof!
> 
> Thanks for your time to have a look at this!
> 
> You mean to keep this new dt-binging and remove it from trivial devices?
> 
Yes

> Cheers,
> Vasilis
> 


