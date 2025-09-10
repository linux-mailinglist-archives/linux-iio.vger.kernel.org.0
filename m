Return-Path: <linux-iio+bounces-23947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB0CB51DD2
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAB93A53F2
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2757A26CE3C;
	Wed, 10 Sep 2025 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu/Fm0pO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF40B329F0B;
	Wed, 10 Sep 2025 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522082; cv=none; b=gUPX9BVnmahXd5LZ63OqVpW3z4BoJoKXyVe2P0h6F/udreVW5mlWencsTr1bK0suasgYyefwgnwZgy0HqNuasW3AhCa7HnYrT/t+orUB/abqytyH22sYl7XVKfTabie4D74kqcurYRyUMG/X8dvG/mPkzQO/wBq8RmG5AhFR0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522082; c=relaxed/simple;
	bh=VqnVe7ND+z/dHs2bcI+Mkh13Zz2u2mKxafPYDENBCWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bT3KqLcL6N6ZBnfJ14lQRhw55HMkoWC51b67s5l5u2ajzU6pdfSO/9Zx5e7sTWw89KkrY7+GssKJMYsMVPicqV8jXOdd1HVsL9i7SL3GGohv56Vy3bcoYpS3OcNsjV7P9KCBh47UjUqZX+GgNU8vXq/EmCgE7ERwUvspTr6TJGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu/Fm0pO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98CEC4CEEB;
	Wed, 10 Sep 2025 16:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757522082;
	bh=VqnVe7ND+z/dHs2bcI+Mkh13Zz2u2mKxafPYDENBCWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vu/Fm0pONBD9IALPZ47AK1IXAVgbjE2+QAC35PY89+UqTdMmWUtEaBciVEY1KT3mD
	 5o50i59e2fP2SHutZj2sJuQU2ZRNiTWMuwHpasen2CFUXoRGnhL2f26Mga6zT2kOyx
	 hG1ZRC4qWDBgCaAx0FVuDXHmgVv1xUsRoR4BaBKrCT72PuzDw0X5io3SCQi+QTNZjZ
	 0gWQdiZiaB8kIXoo8rJTjWPz0DZZciQoc2IUOPhZPUfmJOv80iPHbWWx8ldzFHVxQK
	 Enlw8uXMoAbzTYZeKXBsSGDo17ZPQ3Om9U9LI8PEtM6566f1tApAFIACImBg1yxJCq
	 bqE7qlBiSqVww==
Date: Wed, 10 Sep 2025 17:34:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ioana Risteiu <Ioana.Risteiu@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ramona Nechita
 <ramona.nechita@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] Add IIO backend support for AD7779
Message-ID: <20250910173437.7e442621@jic23-huawei>
In-Reply-To: <20250831133738.5ba540c7@jic23-huawei>
References: <20250825221355.6214-1-Ioana.Risteiu@analog.com>
	<82a21a66-409f-4ec8-9351-365031b8646b@baylibre.com>
	<20250831133738.5ba540c7@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Aug 2025 13:37:38 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 26 Aug 2025 11:24:26 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 8/25/25 5:13 PM, Ioana Risteiu wrote:  
> > >   - Add axi_adc_num_lanes_set in the adi_axi_adc_ops structure to support
> > >   setting number of lanes used by AXI ADC.
> > >   - Add the generic io-backends property to the AD7779 binding to enable
> > >   support for the IIO backend framework.
> > >   - Add the adi,num-lanes property to set the number of lanes used by
> > >   AD7779.
> > >   - Move the initialization specific to communication without iio-backend
> > >   into a separate setup function.
> > >   - Add a new functionality to ad7779 driver that streams data through data
> > >   output interface using IIO backend interface.    
> > 
> > It is more helpful for the cover letter to contain a high-level
> > overview of why you want this series included in the kernel. We
> > can look at the individual patches to see what they are about, so
> > repeating that here isn't especially helpful.
> > 
> > For example, I would write the cover letter for this series like this:
> > 
> > The AD7779 ADC chip has a secondary data bus for high-speed data
> > transfers. To make use of this bus, it is connected to an FPGA IP
> > core [1] which is handled using the IIO backend framework. This IP
> > core connects to the data bus lines as well as the data ready signal
> > on the ADC. This interface can use 1, 2 or 4 lanes at a time.
> > 
> > This series extends the devicetree bindings to describe these wiring
> > configuration, extends the IIO backend framework to allow setting the
> > number of lanes that are being used, and extends the ad7779 driver to
> > allow using such a backend for reading data in buffered reads.
> > 
> > [1]: https://analogdevicesinc.github.io/hdl/projects/ad777x_fmcz/index.html
> >   
> > > 
> > > Ioana Risteiu (4):
> > >   iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
> > >   dt-bindings: iio: adc: add IIO backend support
> > >   iio: adc: extract setup function without backend
> > >   iio: adc: update ad7779 to use IIO backend
> > > 
> > >  .../bindings/iio/adc/adi,ad7779.yaml          |  44 +++-
> > >  drivers/iio/adc/ad7779.c                      | 192 ++++++++++++++----
> > >  drivers/iio/adc/adi-axi-adc.c                 |   1 +
> > >  3 files changed, 196 insertions(+), 41 deletions(-)
> > >     
> > 
> > Please include a changelog of what was changed in each revision of
> > the series along with links to the previous revisions. Tools like
> > b4 can help automate this.
> > 
> > https://docs.kernel.org/6.16/process/submitting-patches.html  
> Whilst I fully agree with this, please keep the per patch change logs
> as well as personally I find those more useful.  For those just
> changes from previous version is fine.
> 
> Anyhow, other than this process stuff the series looks good to me
> so applied to the togreg branch of iio.git and pushed out as testing.
> 
Was missing a SELECT IIO_BACKEND.
0-day found this and I've fixed it up.

Thanks,

Jonathan

> Thanks,
> 
> Jonathan
> 
> 
> 


