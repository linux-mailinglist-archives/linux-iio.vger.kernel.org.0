Return-Path: <linux-iio+bounces-16886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A77A634D4
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 10:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4BB18901D0
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EAA19DF64;
	Sun, 16 Mar 2025 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dno9Eqh0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FF19CC39;
	Sun, 16 Mar 2025 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742118088; cv=none; b=rrfHIpvMDqdEyf1jrSIjgo/i1UvvFnI2H21nol1PVu7/S2Sm0dvKL9Vc+DD23gK/+LENfSuydW3Fd8W5d1d8s4ehIVzc7QAKJD5Y1z5cGeP9ennksj2ab6k9iocFWSwrKb0h0l2UZZNE3RDTYFnqiEKYL2cHQhPUw4ODOqHHBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742118088; c=relaxed/simple;
	bh=puDl3rB5y/M97kW2lFGXNqo6QtunGrZjc7dlVKkYZSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BU+5/hnVnElFmjiMMnJDuQKY28zrEypK8erT1jJIhlJu0NwCah7hzdESrY1ZDN4czZz7q0/3tZ9AfOzRSSHSwwtUOMF0bmI7ueJbNEyYlO1xTjJexSxrea17eLcMq+g60GZvrDr3QKZG4Yk9X61TVHcYX3D07PncctHZBYZIzhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dno9Eqh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C876C4CEDD;
	Sun, 16 Mar 2025 09:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742118088;
	bh=puDl3rB5y/M97kW2lFGXNqo6QtunGrZjc7dlVKkYZSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dno9Eqh0qhwYJ4lTi7hNkN/Keqtg1ukHhOGtaXU7K5uy5MbrN5z4gCQ6YXlyF27/1
	 /Nb9K3AvbggKF08mHXurrZ5cZLkbUrPPA1WyEnFo3bZWM33AMc3TOEqO84TUuS5tjX
	 MH7fCtPqb2MFKCq16oodB7pmecUZDKgKaG6KVrmgu7irir1PK6MtuGGC3JsKenTHyS
	 aS3dt1rHZQ/V4htHdf75Tp9kyGOAFPpjMrTzGVGJzf9gBino3vbvR/Ibq36w3ZOugs
	 0ncIletBELy1KvzmpcdPeMOUi3YTTrqNhHz8m7lRgEbvOqnUFnpZhs4b2SaE8eTGls
	 jmbPQTSYlRfRw==
Date: Sun, 16 Mar 2025 09:41:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>, David
 Lechner <dlechner@baylibre.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v7 05/10] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <20250316094112.6731bd01@jic23-huawei>
In-Reply-To: <Z9LQ0O34EUM8WZku@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
	<df0b2b53affbef5ccb7219328cc15db3ba843737.1741849323.git.mazziesaccount@gmail.com>
	<Z9LQ0O34EUM8WZku@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 14:34:24 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Mar 13, 2025 at 09:18:49AM +0200, Matti Vaittinen wrote:
> > The new devm_iio_adc_device_alloc_chaninfo_se() -helper is intended to
> > help drivers avoid open-coding the for_each_node -loop for getting the
> > channel IDs. The helper provides standard way to detect the ADC channel
> > nodes (by the node name), and a standard way to convert the "reg"
> > -properties to channel identification numbers, used in the struct
> > iio_chan_spec. Furthermore, the helper can optionally check the found
> > channel IDs are smaller than given maximum. This is useful for callers
> > which later use the IDs for example for indexing a channel data array.
> > 
> > The original driver treated all found child nodes as channel nodes. The
> > new helper requires channel nodes to be named channel[@N]. This should
> > help avoid problems with devices which may contain also other but ADC
> > child nodes. Quick grep from arch/* with the sun20i-gpadc's compatible
> > string didn't reveal any in-tree .dts with channel nodes named
> > otherwise. Also, same grep shows all the in-tree .dts seem to have
> > channel IDs between 0..num of channels.
> > 
> > Use the new helper.  
> 
> ...
> 
> > +	num_channels = devm_iio_adc_device_alloc_chaninfo_se(dev,
> > +				&sun20i_gpadc_chan_template, -1, &channels);
> > +	if (num_channels < 0)
> > +		return num_channels;
> > +
> >  	if (num_channels == 0)
> >  		return dev_err_probe(dev, -ENODEV, "no channel children\n");  
> 
> Note, this what I would expected in your helper to see, i.e. separated cases
> for < 0 (error code) and == 0, no channels.
> 
> Also, are all users going to have this check? Usually in other similar APIs
> we return -ENOENT. And user won't need to have an additional check in case of
> 0 being considered as an error case too.
In a few cases we'll need to do the dance the other way in the caller.
So specifically check for -ENOENT and not treat it as an error.

That stems from channel nodes being optionally added to drivers after
they have been around a while (usually to add more specific configuration)
and needing to maintain old behaviour of presenting all channels with default
settings.

I agree that returning -ENOENT is a reasonable way to handle this.

Jonathan

> 
> 
> 
> 


