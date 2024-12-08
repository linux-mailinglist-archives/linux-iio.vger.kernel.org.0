Return-Path: <linux-iio+bounces-13232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7279E86BD
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25E016421B
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2385418754F;
	Sun,  8 Dec 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKFgh8Fi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B120323;
	Sun,  8 Dec 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677090; cv=none; b=fdmIoNqtVPTGUhCzltmhwH+rUZI9107zNKafbLiST494PVg0aVSvxdWVLIWAorYa5uW8LsyQg6qEbFa41nDnYvxpmfGuh6vT1fItCQRuxLbcQJH5kaTdCER6zH+eYakgphEHeVaJIaOy4GWcvB7A1DNxgGi89AzXRcGKoNb0jr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677090; c=relaxed/simple;
	bh=ZupYwODzz1JZIpwYvnLeAs3GYHnLlQAmCgPJ5BKpR5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdIU8cgOz6ob4UBFDi110dkCzHDAE0WKise7yGDyBQTs6W5TGiBGkqW5qHIzNiBaREcQZGRMNi3OwHg77HRtp2U5jJWDbTrfW91UvCnVzy32G093Z6dpdJJLdaN2umQbprpF5mAxDulN+EaXfBaGJnOWQeVLdC7NNjmEQGPvdLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKFgh8Fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73174C4CED2;
	Sun,  8 Dec 2024 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733677090;
	bh=ZupYwODzz1JZIpwYvnLeAs3GYHnLlQAmCgPJ5BKpR5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tKFgh8FiS8FbRTFkK2N+FlA7iqzGWZknrBXFt8WYBZ8DtYjuE5gSiiWqTM9CNI56G
	 fjeOd1LWq2bILNNh+9jeOvowOvhohfDcNzI65UVz0jiojk4b4/T/culUhkplgEtRDD
	 zQ75TY9PgTECJH08yI43oLajI9aN/VZ6NhoCrFmXY8/HlsHKKD+5OsJVynKVEz730N
	 pz4bro2tW+HiOZWGXRTSamb3qBw9NCn4Z5O+qdarOilS6zVKSm+UHFqc9ZQU5kxO9c
	 Lnhkrju45GcVM9kYoGpc8onf6R5SXzzCxjVCRNKOuM3ks9/8pSRmEPTzGKwN7zqbRn
	 I/jlR5A60YWHw==
Date: Sun, 8 Dec 2024 16:58:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christian Eggers <ceggers@arri.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Antoni Pokusinski
 <apokusinski01@gmail.com>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29u?=
 =?UTF-8?B?w6dhbHZlcw==?= <joao.goncalves@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: light: as73211: fix channel handling in
 only-color triggered buffer
Message-ID: <20241208165800.1f4504a9@jic23-huawei>
In-Reply-To: <3614353.dWV9SEqChM@n9w6sw14>
References: <20241204-iio_memset_scan_holes-v2-0-3f941592a76d@gmail.com>
	<20241204-iio_memset_scan_holes-v2-2-3f941592a76d@gmail.com>
	<3614353.dWV9SEqChM@n9w6sw14>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Dec 2024 17:20:47 +0100
Christian Eggers <ceggers@arri.de> wrote:

> On Wednesday, 4 December 2024, 00:55:32 CET, Javier Carrasco wrote:
> > The channel index is off by one unit if AS73211_SCAN_MASK_ALL is not
> > set (optimized path for color channel readings), and it must be shifted
> > instead of leaving an empty channel for the temperature when it is off.
> > 
> > Once the channel index is fixed, the uninitialized channel must be set
> > to zero to avoid pushing uninitialized data.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 403e5586b52e ("iio: light: as73211: New driver")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
> >  drivers/iio/light/as73211.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> > index be0068081ebb..2d45dfeda406 100644
> > --- a/drivers/iio/light/as73211.c
> > +++ b/drivers/iio/light/as73211.c
> > @@ -672,9 +672,12 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
> >  
> >  		/* AS73211 starts reading at address 2 */
> >  		ret = i2c_master_recv(data->client,
> > -				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
> > +				(char *)&scan.chan[0], 3 * sizeof(scan.chan[0]));
> >  		if (ret < 0)
> >  			goto done;
> > +
> > +		/* Avoid pushing uninitialized data */
> > +		scan.chan[3] = 0;
> >  	}
> >  
> >  	if (data_result) {
> > @@ -682,9 +685,15 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
> >  		 * Saturate all channels (in case of overflows). Temperature channel
> >  		 * is not affected by overflows.
> >  		 */
> > -		scan.chan[1] = cpu_to_le16(U16_MAX);
> > -		scan.chan[2] = cpu_to_le16(U16_MAX);
> > -		scan.chan[3] = cpu_to_le16(U16_MAX);
> > +		if (*indio_dev->active_scan_mask == AS73211_SCAN_MASK_ALL) {
> > +			scan.chan[1] = cpu_to_le16(U16_MAX);
> > +			scan.chan[2] = cpu_to_le16(U16_MAX);
> > +			scan.chan[3] = cpu_to_le16(U16_MAX);
> > +		} else {
> > +			scan.chan[0] = cpu_to_le16(U16_MAX);
> > +			scan.chan[1] = cpu_to_le16(U16_MAX);
> > +			scan.chan[2] = cpu_to_le16(U16_MAX);
> > +		}
> >  	}
> >  
> >  	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
> > 
> >   
> 
> With this change, having only X, Y and Z in the scan_mask (without the
> temperature channel) works fine.
> 
> But it looks that there is still another problem if a single color channel
> (e.g. X) is omitted from the scan mask (which probably wouldn't make much
> sense in practice).  If I am right, the layout of scan.chan[] is also wrong for
> that case, so e.g. if omitting X, the application will get the X values where
> it expects the temperature value (which isn't read from the hardware at all).
> 
> Does it make sense to write a follow-up patch for this? I fear that taking all
> possible combinations into account could make the driver more complicated than
> necessary.  Or is there a good example how to handle such combinations?
> 
Good spot. I'd fallen for assuming a driver worked the way I thought it would
and not checked everything necessary was there.

Hmm. This is a bit odd. Driver seems to be written with assumption that the IIO
core is doing demux.  That doesn't work unless available_scan_masks is set.

Make that
{
	AS73211_SCAN_MASK_ALL,
	AS73211_SCAN_MASK_COLOR,
	0,
};

And then if you enable fewer channels, the IIO core will still enable one of the
sets in available_scan_masks and then do the relevant data manipulation to repack
as necessary.

I'll not pick this patch up as it makes sense to fix both issues together.

Thanks

Jonathan

> 
> Tested-by: Christian Eggers <ceggers@arri.de>
> 
> 
> 
> 


