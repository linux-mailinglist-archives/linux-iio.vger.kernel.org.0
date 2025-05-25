Return-Path: <linux-iio+bounces-19881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753FBAC34B0
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390F317480D
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B401F3BA4;
	Sun, 25 May 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcSSScDg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D54A1D;
	Sun, 25 May 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748177798; cv=none; b=uPjboYnwXJHF2JvkO3tL5A5yYVlDSUCDUTGqjS4NYywvQG7gakFThuq/vzQiVnlW6yEJBQAWQTEldwZiqIGAafv/LMrIb0sk2arETAEylLHmDp9xHMONjxIPly4gVS8ChUNrlYwpAnHWhalsa2s1r0KjIHJFd+ISoDmtstYhqJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748177798; c=relaxed/simple;
	bh=TPbGACxOUYt19ivP9896jh+N+xLN76rtUSqQfYb+4Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pv8siCC4FWz1tUko+sF/gsLKgJ9I/D8gxdX6bwI7QzgY1sRXWlktq2hxNQwbv1Gm1SjZAc6LJWgK62lQSwlahUIcPJKmrDOtG9hYwScFsfX+NPqEHlTuIppbZCitWDxMA4oFFyw0NS/uOO6Cy+PgtmcJ4eOz97za5Ui8PNxs3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcSSScDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051ABC4CEEB;
	Sun, 25 May 2025 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748177798;
	bh=TPbGACxOUYt19ivP9896jh+N+xLN76rtUSqQfYb+4Ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hcSSScDgTreKVsWKw1qDl2ynGyYSJDZsFTdaU5LiRcXhi9o7cyMa6igGLwTjEHsLn
	 BRZzDwVNqr/hIW6A8GNX4HXXOgwwBzbVrOUclVxFkn0/8cY0TExsbrfLHSvC2s4vPs
	 K9CTLTp4IL6kJR/RfJHuG9JU0U4LeZUwCEDlZjTRVcUOZpHvIXBBmSPDF//ZFRrePj
	 H1kJxtS5FksKwr5b8iS1ExtrkZ2LgVI33ULcF76hzgpAMcq/7ATgJOOMFu2PUieWiU
	 xnNTYpTVIEetS/145F/9x0kg5g2BTHuKmV62joGdV8S+edJnLUBN8K1jrzRIOP28b5
	 PHXYo40EUsllA==
Date: Sun, 25 May 2025 13:56:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/12] iio: accel: adxl313: add basic interrupt
 handling
Message-ID: <20250525135631.3ae0a911@jic23-huawei>
In-Reply-To: <20250525134831.68b3c905@jic23-huawei>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-8-l.rubusch@gmail.com>
	<20250525134831.68b3c905@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > +/**
> > + * adxl313_fifo_reset() - Reset the FIFO and interrupt status registers.
> > + * @data: The device data.
> > + *
> > + * Reset the FIFO status registers. Reading out status registers clears the  
> 
> I think you already read it before calling this. So how is it ever set?
> 
> > + * FIFO and interrupt configuration. Thus do not evaluate regmap return values.
> > + * Ignore particular read register content. Register content is not processed
> > + * any further. Therefore the function returns void.
> > + */
> > +static void adxl313_fifo_reset(struct adxl313_data *data)  
> 
> As below.  This isn't a reset.  Fifo reset is normally the term used
> for when we have lost tracking of what is in the fifo and drop all data,
> not normal readback.

Ok. After next patch it became more obvious how this is being used.

I'd combine the patches probably to avoid confusion or the odd state
that any interrupt resets the fifo after this patch.

> 
> > +{
> > +	unsigned int regval;
> > +	int samples;
> > +
> > +	adxl313_set_measure_en(data, false);  
> Disabling measurement to read a fifo is unusual -  is this really necessary
> as it presumably puts a gap in the data, which is what we are trying
> to avoid by using a fifo.

This makes more sense as well if we are in a reset condition.
I just got thrown off by the lack of a 'good' path in this patch.

> 
> > +
> > +	samples = adxl313_get_samples(data);
> > +	if (samples > 0)
> > +		adxl313_fifo_transfer(data, samples);
> > +
> > +	regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &regval);  
> 
> Not processing the convents of INT_SOURCE every time you read it
> introduces race conditions.  This logic needs a rethink so that
> never happens.  I guess this is why you are disabling measurement
> to stop the status changing?  Just whatever each read of INT_SOURCE
> tells us we need to handle and all should be fine without disabling
> measurement.  That read should only clear bits that are set, so no
> race conditions.
> 
> > +
> > +	adxl313_set_measure_en(data, true);
> > +}

