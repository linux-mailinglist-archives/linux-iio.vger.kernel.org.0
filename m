Return-Path: <linux-iio+bounces-10782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A44309A4E7A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C212B265B6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC97C38DD8;
	Sat, 19 Oct 2024 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOF7+HTW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB1179BC;
	Sat, 19 Oct 2024 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729346400; cv=none; b=h/SMZbGBBNceQ4xaXJ9QRZcE+JMiavUafi82X6fw0YzpoZ0xRNr2qsmd0tU4KIGm6g+unvWjsZmlXK3IlOjacyPvv5qkM5yfFv1izGdZUfGQB6YqWdJVEweks/qLDwVc/2+p/fInykAT+/WP/01TEvqsO5nxMrivfeeBDqe7Qbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729346400; c=relaxed/simple;
	bh=CXVTKQ2lO/E8UkOgX5TgeRaO/Mv81ac62pj6rNEoRJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QL6XggVbdGHXSzYwXZDb10vf8gljwwBf4kqncO4eFnxwbEe4VELrDhQBpJ8d1j1R8FE8bKO/uj4PqbuNrRs4hijl4YtFSTNRTBLLK6hPWh+jRR09plnw7FQ62N+dRnGczplMcOjmnWmn4Zxowia62v2GA6OZ8oBbZnuu6+gjEmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOF7+HTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86105C4CEC5;
	Sat, 19 Oct 2024 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729346399;
	bh=CXVTKQ2lO/E8UkOgX5TgeRaO/Mv81ac62pj6rNEoRJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VOF7+HTWRc1En2VDqPL/oNKqC5DGjumSRkAe7H5Q5TU8QdvfDsNlAklgdolWHKzIr
	 Y1apDf2r8wZCAE0B+QxqsB6NRqPfLdIbcV6WZjy41RBKtXMGZ8GuP7GtjQuiy+/L0q
	 pDbwQagU8BZ09f/IKrT29Ek40lg3zYCsa174Et3JoiYUJHjTfXk7RaUL3qsHBUTJM+
	 fYiAnU3Pn4u6zFGUjCx5eHBt+ScBS0mNS69Yjj0sYu7m+V7m2tt1xaN7sv4G+a0Iyy
	 O6vpP1DSnRcDYeKQUVjweRsJzgy6MHGvRPNYxB3EMfoEjY5kZk4hMUyD1Nk7C3DcFg
	 LDz3mkz1IzlEA==
Date: Sat, 19 Oct 2024 14:59:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
 andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/13] iio: chemical: bme680: Move ambient
 temperature to attributes
Message-ID: <20241019145925.5d54e7b4@jic23-huawei>
In-Reply-To: <Zw17n7DB2LdgDct3@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
	<20241010210030.33309-10-vassilisamir@gmail.com>
	<20241012130124.44c69521@jic23-huawei>
	<Zw17n7DB2LdgDct3@vamoirid-laptop>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 22:14:23 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sat, Oct 12, 2024 at 01:01:24PM +0100, Jonathan Cameron wrote:
> > On Thu, 10 Oct 2024 23:00:26 +0200
> > vamoirid <vassilisamir@gmail.com> wrote:
> >   
> > > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > 
> > > Remove the ambient temperature from being a macro and implement it as
> > > an attribute. This way, it is possible to dynamically configure the
> > > ambient temperature of the environment to improve the accuracy of the
> > > measurements.
> > > 
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>  
> > New ABI? Would need docs.
> > 
> > However, I 'think' we have a few cases where we handle this via the slightly
> > odd interface of out_temp_processed / _raw with a label saying it's
> > ambient temperature.
> > 
> > The tenuous argument is that we have heaters that actually control the
> > temperature and the affect of either heating the thing or just happening
> > to know the external temperature ends up being the same. Hence use
> > an output channel for this control.
> > 
> > Jonathan  
> 
> Hi Jonathan,
> 
> Thanks for taking the time to review this. I saw your previous messages,
> and I am not responding to all of them so as to not flood you with ACK
> messages.
> 
> For this one though I have to ask. The last commit of this series is
> adding support for an output current channel that controls the current
> that is being inserted into an internal plate that is heated up in order
> to have more precise acquisition of humidity and gas measurement. Does
> it makes sense to add an ambient temp output channel as well?

If we need to know that temperature to calculate the meaning of the pressure
channels then I think it does.

I am a little confused though as this device measures the temperature.
Why isn't that the right value to use?  Is that because the heater
is confusing things?


> 
> Cheers,
> Vasilis
> 


