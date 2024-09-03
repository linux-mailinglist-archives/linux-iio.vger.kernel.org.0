Return-Path: <linux-iio+bounces-9090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F198296A728
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2658B1C20D9A
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 19:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A321D5CDE;
	Tue,  3 Sep 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDvINS3T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C961D5CC0;
	Tue,  3 Sep 2024 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390726; cv=none; b=O3X5/VdPzG0CF1zGMPzEFsLHuH4tLhyyuk8Bqed17w5vNJS4hBqfF4Q1muEKZZDwB+JEc5a6CnURPbXUu+VGM0PM3GGhYwt+3mgjMlh9pyn/lFaY8rqI/Y07h3MKd9r9pJI2n88dz9dPV7NTntJyqkHNwX/LabTKEjWnjy6skrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390726; c=relaxed/simple;
	bh=wLSLhLdH1cSSuPslUNw8khn4BjyUP/bISLgk9bBaWKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1PZXUbZRna209vcqOKgR2A3csWqSmnq8RFIRv94ausoah2sQNc5aMiCw/cmIOoF6L8QulNvL1Dxr0VgXkdIwJsnxEMHSulAvvbS1SlFSiiIecChuPE+99jSO7iL3ovg937qpJpG5GTtroCv/dVh8518ShFUjvZ7vjFUGYkjxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDvINS3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E86C4CEC4;
	Tue,  3 Sep 2024 19:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725390726;
	bh=wLSLhLdH1cSSuPslUNw8khn4BjyUP/bISLgk9bBaWKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tDvINS3TRla0yN89jmTdD1F9Fk8rBEOzE7WCpkBsMVPCrstr1eky2dIGgGx8ERbLd
	 82+R4nrL+UvZBXxYBQScPDKoYw9NiwczVdJBKD7//5lpa03Ma9repl1tGls42dqrjD
	 v/sK903DEHSxzxeL94/RT+ayzkjnIyaPPRGr9+nLq80TIVfxSJJ9Jl/P0CWPiPM3/N
	 Js4VlYi3dvKQWwsTbOkyvqITzLFsNMlOjPNbUL4epooDc5dk+bV9+TD2d9nbnZRMEp
	 I+gYloMUH9HVK8epXgvKPwZWY64iZRDN3wcQwYeRUPGt60KEp058HktUNDq8Oqc9N6
	 wOeaqOc1etPlg==
Date: Tue, 3 Sep 2024 20:11:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
Subject: Re: [PATCH RFC 2/8] iio: backend: extend features
Message-ID: <20240903201157.5352ec04@jic23-huawei>
In-Reply-To: <0fbe1321-cc67-4ade-8cbb-cbbaa40d2ca1@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240829-wip-bl-ad3552r-axi-v0-v1-2-b6da6015327a@baylibre.com>
	<20240831122313.4d993260@jic23-huawei>
	<0fbe1321-cc67-4ade-8cbb-cbbaa40d2ca1@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 16:03:22 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Hi Jonathan,
> 
> thanks for the feedbacks,
> 
> On 31/08/24 1:23 PM, Jonathan Cameron wrote:
> > On Thu, 29 Aug 2024 14:32:00 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >  
> >> From: Angelo Dureghello <adureghello@baylibre.com>
> >>
> >> Extend backend features with new calls needed later on this
> >> patchset from axi version of ad3552r.
> >>
> >> A bus type property has been added to the devicetree to
> >> inform the backend about the type of bus (interface) in use
> >> bu the IP.
> >>
> >> The follwoing calls are added:
> >>
> >> iio_backend_ext_sync_enable
> >> 	enable synchronize channels on external trigger
> >> iio_backend_ext_sync_disable
> >> 	disable synchronize channels on external trigger
> >> iio_backend_ddr_enable
> >> 	enable ddr bus transfer
> >> iio_backend_ddr_disable
> >> 	disable ddr bus transfer
> >> iio_backend_set_bus_mode
> >> 	select the type of bus, so that specific read / write
> >> 	operations are performed accordingly
> >> iio_backend_buffer_enable
> >> 	enable buffer
> >> iio_backend_buffer_disable
> >> 	disable buffer
> >> iio_backend_data_transfer_addr
> >> 	define the target register address where the DAC sample
> >> 	will be written.
> >> iio_backend_bus_reg_read
> >> 	generic bus read, bus-type dependent
> >> iio_backend_bus_read_write
> >> 	generic bus write, bus-type dependent
> >>
> >> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> >> ---
> >>   drivers/iio/industrialio-backend.c | 151 +++++++++++++++++++++++++++++++++++++
> >>   include/linux/iio/backend.h        |  24 ++++++
> >>   2 files changed, 175 insertions(+)
> >>
> >> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> >> index a52a6b61c8b5..1f60c8626be7 100644
> >> --- a/drivers/iio/industrialio-backend.c
> >> +++ b/drivers/iio/industrialio-backend.c
> >> @@ -718,6 +718,157 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
> >>   	return 0;
> >>   }  
> >  
> >> +
> >> +/**
> >> + * iio_backend_buffer_enable - Enable data buffering  
> > Data buffering is a very vague term.  Perhaps some more detail on what
> > this means?  
> 
> for this DAC IP, it is the dma buffer where i write the samples,
> for other non-dac frontends may be something different, so i kept it
> generic. Not sure what a proper name may be, maybe
> 
> "Enable optional data buffer" ?
How do you 'enable' a buffer?  Enable writing into it maybe?

> 
> 
> >> + * @back: Backend device
> >> + *
> >> + * RETURNS:
> >> + * 0 on success, negative error number on failure.
> >> + */
> >> +int iio_backend_buffer_enable(struct iio_backend *back)
> >> +{
> >> +	return iio_backend_op_call(back, buffer_enable);
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(iio_backend_buffer_enable, IIO_BACKEND);
> >> +
> >> +/**  
> 

> >> +/**
> >> + * iio_backend_bus_reg_read - Read from the interface bus
> >> + * @back: Backend device
> >> + * @reg: Register valule
> >> + * @val: Pointer to register value
> >> + * @size: Size, in bytes
> >> + *
> >> + * A backend may operate on a specific interface with a related bus.
> >> + * Read from the interface bus.  
> > So this is effectively routing control plane data through the offloaded
> > bus?  That sounds a lot more like a conventional bus than IIO backend.
> > Perhaps it should be presented as that with the IIO device attached
> > to that bus? I don't fully understand what is wired up here.
> >  
> Mainly, an IP may include a bus as 16bit parallel, or LVDS, or similar
> to QSPI as in my case (ad3552r).
ok.

If this is a bus used for both control and dataplane, then we should really
be presenting it as a bus (+ offload) similar to do for spi + offload.

> 
> In particular, the bus is physically as a QSPI bus, but the data format
> over it is a bit different.
> 
> So ad3552r needs this 5 lanes bus + double data rate to reach 33MUPS.
> 
> https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
> 
Jonathan


