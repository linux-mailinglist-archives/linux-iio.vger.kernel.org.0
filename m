Return-Path: <linux-iio+bounces-15357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592AEA3150B
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 20:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58C218876B0
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A71264F8D;
	Tue, 11 Feb 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNlYEDsh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7D264FAD;
	Tue, 11 Feb 2025 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301775; cv=none; b=CPfD3BV05IV7ffOG4iLDu2Z/pz3iKB99C4hOww6LnY5MK0Aa77OH/qJldXuvNivm4S7NKdUuLu1Bv1eE//awGV7GQ+VBhRI+gWG9bP3bKDeU5drcRgp2+/P8yl5I3phjPGLP4/425JWB/eh3NptBbXchp9cLHVS574Zgp+P03VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301775; c=relaxed/simple;
	bh=5IaTcpAOuygrsLVKHnKcdOYvqEnpIjQxluHnnPqOJWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBN+HK+VtdlOsL0qjbzjAdAeEjCswpCrFe/RuU/bWHlHURVSCRfHutP0yq02MFmQxua40hG7qWdr7Sme6VcpjCFEDdjBmltoVIFOtUQ+GgYcfdBpDcQMQr0INWhVZ8W4cSzot5OQuRXRryKiMYPgwOmW3o+s5MIXC6xfjHjfJuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNlYEDsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4C2C4CEDD;
	Tue, 11 Feb 2025 19:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739301775;
	bh=5IaTcpAOuygrsLVKHnKcdOYvqEnpIjQxluHnnPqOJWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TNlYEDshy8Hec78h4vtwsNMw2j/1S6yiY9fL4RWnmAlXaFqX9gMQNqAKD0HXvQiMN
	 qEZvO/TYkpXucnE9M7Z44a7wOTnfIQYL5BU2Usq2MSrI6FmXHzr7B3ro+6ySfiVB9z
	 Eo0DyfJyhbfoOKmzmYYo6Oi25NDYTUc5CZOS+VgrJGAWulagJoa+JUPPsEEH/iC0sI
	 28ko+ftPOGyugjqd4rhqKmz6PaFZqutv48ERgo/LaEWkCMjafsG6BbrbLy09fLl74Y
	 XzUY/mL5LzrN/4qI2eeHC/l4Ele+g7QvST4EfJt4P4Sfc6K9+Ea6FjVsIa1WN7PDgn
	 g3kRdod0dwPYg==
Date: Tue, 11 Feb 2025 19:22:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hermes Zhang <chenhuiz@axis.com>
Cc: Hermes Zhang <Hermes.Zhang@axis.com>, robh@kernel.org, lars@metafoo.de,
 krzk+dt@kernel.org, kernel@axis.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: chemical: add support for Sensirion
 SEN5x/SEN6x
Message-ID: <20250211192247.57e8d7d1@jic23-huawei>
In-Reply-To: <c397401d-63b7-7a6e-80fa-16dd4ceb0537@axis.com>
References: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
	<20250206061521.2546108-4-Hermes.Zhang@axis.com>
	<20250208161501.7b6c6c17@jic23-huawei>
	<1237314b-78a8-a871-ea24-f3011766606b@axis.com>
	<20250210190942.21ba97cc@jic23-huawei>
	<c397401d-63b7-7a6e-80fa-16dd4ceb0537@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 10:29:54 +0800
Hermes Zhang <chenhuiz@axis.com> wrote:

> On 2025/2/11 3:09, Jonathan Cameron wrote:
> > On Mon, 10 Feb 2025 17:16:57 +0800
> > Hermes Zhang <chenhuiz@axis.com> wrote:
> >  
> >> Hi Jonathan,
> >>
> >> Thanks a lot for your review. I will fix most of them in v2, just one
> >> question below.
> >>
> >> Best Regards,
> >> Hermes
> >>
> >>
> >> On 2025/2/9 0:15, Jonathan Cameron wrote:  
> >>> On Thu, 6 Feb 2025 14:15:17 +0800
> >>> Hermes Zhang <Hermes.Zhang@axis.com> wrote:
> >>>
> >>>     
> >>>> +
> >>>> +	state->last_update = jiffies;
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>> +static ssize_t status_show(struct device *dev, struct device_attribute *attr,
> >>>> +			   char *buf)
> >>>> +{
> >>>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >>>> +	struct sen_common_state *state = iio_priv(indio_dev);
> >>>> +	int status;
> >>>> +	int ret;
> >>>> +
> >>>> +	ret = sen_common_status(state->client, &status);  
> >>> This is custom ABI. So it would need documentation and will need
> >>> to overcome quite a high barrier.
> >>>
> >>> Superficially this looks like debug perhaps that should be
> >>> in debugfs?  
> >> The status is one of the support commands from the chip, we (from
> >> userspace) could read it and notify customer if the sensor is wrong or
> >> not. So it is ued in normal usage, regarding the ABI, I see your point,
> >> so instead of my way, do you have any suggestion for how to handle it in
> >> iio? Thanks.  
> > What is actually reporting?  I hope something more specific than
> > 'wrong'.  Also when do you read it?  Standard software is never going to
> > so you may be better of doing some scheduled reading or reading it
> > on the back of a channel read.  Unfortunately the nature of failure modes
> > is that they are not easy to describe in a generic ABI - sometimes
> > our best bet is to just log an error (rate limited).
> >
> > Some of these look like they mean the data read is garbage when they
> > are happening?
> >
> > Jonathan
> >  
> It's e.g. a 32bit data which some of the bits indicate if the 
> PM/CO2/GAS/RHT/FAN is error. Yes, the software will scheduled to read it 
> and deal the error based on some policy configurable (e.g reboot the 
> device). I hope if the driver can provide such inteface to read it, so 
> userspace can decide how to handle it. Is there some similar case 
> already in driver now? Thanks.

There are some but they aren't typically left to userspace because
that would require custom userspace for every driver (which is typically
not possible).  Hence checks like this are usually done by the driver
directly (often the device has an optimized read of data + status) and
we report a simple error to userspace + restart device etc.

Typical cases of this are things like fifo overflow which sometimes needs
a device reset to recover.

So can you do this check in the driver on each read? It's a really slow
sensor so the extra bus access time isn't going to make much difference
and then you can take correct action.

Jonathan


> 
> 
> Best Regards,
> 
> Hermes
> 


