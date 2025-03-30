Return-Path: <linux-iio+bounces-17352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52785A75AC5
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60903A8A91
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A81CEADB;
	Sun, 30 Mar 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHUMTXp4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5582B2D7;
	Sun, 30 Mar 2025 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743350687; cv=none; b=maDvHDWCKYPqXmjt0zoPvsLfknDEnphoASGWyGyQl662JX9pyxWx34UE78h6MJq2+JFyHMO0LbFgbLHWf7mrmmZ1vEBMSSH6zztRO6f2D1xeFyRFDn6t7AVs1NMx/JOgDxaHcqvIeAyaWse1iQ1+OSa6dm8w7P4WMa5hH+KBk0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743350687; c=relaxed/simple;
	bh=zQ61M6jPec8LFR9R4abZV1pWmtg3ZCY4D71VwoNhMjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDWDO1ycX+ikbJkr73+JyTMk/c0dzz9AgfDLip02fQDQ5Njr4vVuHbkte0Zhcdjz24SVDybAa3s1a6Nbcr5r77lyNsaC5nUmXQaepAXtgfJM3WEh9Jwi/vIwI+64Exw1cxRJozQ46dq1oo1/GX4YvDBYqleRMH2vRVYpEx0sOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHUMTXp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4E0C4CEDD;
	Sun, 30 Mar 2025 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743350686;
	bh=zQ61M6jPec8LFR9R4abZV1pWmtg3ZCY4D71VwoNhMjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vHUMTXp4lsZoFzi9roDeAsVnXPo3k+fg1WdZUNUhhLpOujgCux/RDN1c9p4mpjqgS
	 8OIsY9ch/EB3xJz1vSB14xDUDkety4q+zg3yzfCgLKreACAoAa7JutwmQNq2dFFDTq
	 9yqATTdlWsTe3w0nEvnmmPsuYYB3qVdDn6N0pFUnwv1E1c4Ji6veivg70XF8O7xmo4
	 tvpuiRnanUwULoazgP90wa0U5i/s1kMzk75zlJwDICSR89+Hct2NmQzYCx9RSW2eFx
	 PylakSsMQUoCwQI+/BD0GQRLeKPEmxwiByHnFbFJCu1hlYOh5OKPtOX8q0vcRuU0lC
	 WRrb4kyBkmK9Q==
Date: Sun, 30 Mar 2025 17:04:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Guillaume Stols
 <gstols@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, Trevor
 Gamblin <tgamblin@baylibre.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?UTF-8?B?Sm/Do28=?=
 Paulo =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250330170436.0fc14b64@jic23-huawei>
In-Reply-To: <222c5fa7-283b-48ce-9d01-34ca633674eb@gmail.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
	<b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
	<20250316110237.0b558248@jic23-huawei>
	<222c5fa7-283b-48ce-9d01-34ca633674eb@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 13:24:07 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 16/03/2025 13:02, Jonathan Cameron wrote:
> > On Thu, 13 Mar 2025 09:19:03 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:  
> 
> ...
> 
> >> +static int bd79124_write_int_to_reg(struct bd79124_data *data, int reg,
> >> +				    unsigned int val)  
> > ..  
> >> +static int bd79124_read_event_config(struct iio_dev *iio_dev,
> >> +				     const struct iio_chan_spec *chan,
> >> +				     enum iio_event_type type,
> >> +				     enum iio_event_direction dir)
> >> +{
> >> +	struct bd79124_data *data = iio_priv(iio_dev);
> >> +
> >> +	if (chan->channel >= BD79124_MAX_NUM_CHANNELS)
> >> +		return -EINVAL;
> >> +
> >> +	return (data->alarm_monitored[chan->channel] & BIT(dir));  
> > 
> > Drop the outer brackets as not adding anything.  
> 
> I just noticed that the integer returned from here is directly provided 
> to the user-space. I don't know the history, but it feels a bit off to 
> me. I mean, I would expect the read from sysfs file "*_en" to return '1' 
> or '0' - not 0x04.
> 
> Oh well, I suppose it's too late to change this in the IIO core - but 
> I'll do:
> 	return !!(data->alarm_monitored[chan->channel] & BIT(dir));

Agreed it should be returning 1 or 0.

This stuff is a little bit messy.  I'd not be against that ABI
cleanup if we squashed the values to 0,1 in the core as a follow up.

I doubt anyone relies on getting 0x4 as that would be very driver
specific userspace code!

Jonathan

> 
> in v8.
> 
> 
> Yours,
> 	-- Matti


