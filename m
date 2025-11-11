Return-Path: <linux-iio+bounces-26174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7F7C4FA3A
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 20:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 327554E2BBC
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 19:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CAF333448;
	Tue, 11 Nov 2025 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkdn7Kgu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022073254A8;
	Tue, 11 Nov 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890430; cv=none; b=jYT3xsnXukGqxFhKk8y2Yyj6XVnJRyF1AXLhiIe+pfkoabXjxumrLFr9f7w1Z6rqnlr0Kce1DsfVIkPPP75ju/QM+yxaqtsIzX8/YChKRDydwjuswLavEeGGae+aWzSJBh8yBswrZuFK12PbxG9m16To/ASgJ8Ew8YVXtgITrJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890430; c=relaxed/simple;
	bh=0Ktb1TweGnNTBqjtAY5SaKqT2o0Or34mDCZKWxPEmao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eS/BprpS/X/QR/vlLlWv9D2wuY4ePCaW/qtqd4os42be/6D13Kaz2PlZOsVnFRl3Im05atradtY93dGG3WN3C68w4wo9lQLHAN0VClU8tNeTEOFt41KKJDnCgIFPMTGlQKvwiDMAlPPgLUvt2g/+cs1mR2iJEvWhm1PG9oShwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkdn7Kgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E20C16AAE;
	Tue, 11 Nov 2025 19:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762890429;
	bh=0Ktb1TweGnNTBqjtAY5SaKqT2o0Or34mDCZKWxPEmao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fkdn7Kgubp9ZYDiM873okv6Y3IUWjscBGuwRu+a4gnVy4Q0Z1O9N7aTE7YUO/JVOd
	 YNGLNQ34KGaEdrmU7SrG6cAPh1vSc4FIfpa5uUdf/rYY1sblaoVF02rseJd2Bvj+tJ
	 f/MV+AKWaFYgrMVufQFTNcJZfBKZIP4QyStt/QNT/e7eCnUENSByAHWITjg9qp7FvA
	 qyAkaPRPh+9p8OeBfohfUXMy50zgabt2bb9k57ieRYN6XyweIlq3TDTqnIAKhbK735
	 Mv8Hmx9nqGk/FHwNM9G6u9Osfkz5snFOIWizaRlnAs74eC7z6d5nWW7R2iNfiGO0Fi
	 zTnk1tbm03+Vg==
Date: Tue, 11 Nov 2025 19:47:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: marcelo.schmitt1@gmail.com, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: mpl3115: use get_unaligned_be24 to retrieve
 pressure data
Message-ID: <20251111194703.0dc872a0@jic23-huawei>
In-Reply-To: <20251110155932.o2oipfzuxhgq4vn4@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
	<20251105095615.4310-2-apokusinski01@gmail.com>
	<aQ1MfTu24hhk-dKP@debian-BULLSEYE-live-builder-AMD64>
	<20251109163840.64144586@jic23-huawei>
	<20251110155932.o2oipfzuxhgq4vn4@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 16:59:32 +0100
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> On Sun, Nov 09, 2025 at 04:38:40PM +0000, Jonathan Cameron wrote:
> > On Thu, 6 Nov 2025 22:33:49 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >   
> > > On 11/05, Antoni Pokusinski wrote:  
> > > > The pressure measurement result is arranged as 20-bit unsigned value
> > > > residing in three 8-bit registers. Hence, it can be retrieved using
> > > > get_unaligned_be24 and by applying 4-bit shift.
> > > > 
> > > > Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> > > > ---
> > > >  drivers/iio/pressure/mpl3115.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c    
> > > ...  
> > > >  
> > > > -		*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
> > > > +		*val = get_unaligned_be24(tmp) >> 4;    
> > > hmm, now the number of bits shifted is dissociated from the channel characteristics.
> > > We can do
> > > 		*val = get_unaligned_be24(tmp) >> (24 - chan->scan_type.realbits);  
> > This encodes that the field is always aligned to the maximum bit. Whilst it might
> > be true, there is nothing inherent that says it must be.
> > 
> > I'm not sure why we aren't using chan->scan_type.shift though.  
> The chan->scan_type.shift is 12 for the pressure channel, because
> .realbits is 32. In order to better reflect the actual data format,
> the pressure .shift and .realbits should be changed to 4 and 24 respectively
> and the we could use the chan->scan_type.shift in here indeed.
> 
> But then the `iio_generic_buffer` tool should also be updated so that it
> can manage the scan_data with realbits not being in the form 2^n.
> Currently it supports only scan sizes of 1,2,4,8 bytes [1].

> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/tools/iio/iio_generic_buffer.c#n189

I think this is confusing storagebits and realbits.

storagebits is always power of 2 * 8 because we want them naturally aligned for
efficient accesses.  realbits is however many bits of actual data we have, so once we
shift off the bottom "shift" bits, how many to mask.
  
This confusion isn't helped by inconsistent names between that
tool and the kernel. 

Anyhow, I indeed now see why it is shifted by 4 here - thanks for talking me through it!

You could do the much messier
*val = get_unaligned_be24(tmp) >> (chan->scan_type.shift - (chan->scan_type_storage_bits - 24));
Which is hideous.  Perhaps a comment will do the job.

/*
 * Note that chan->scan_type.shift accounts for 24 bit big endian data being
 * read into the lower addresses of a 32 bit buffer - hence shift here is 4 rather
 * than 12.
 */

Or as another option. Could do in _fill_trig_buffer() do

ret = i2c_smbus_read_i2c_block_data(data->client,
			MPL3115_OUT_PRESS, 3, &buffer[pos + 1]);
Then set the shift for the pressure channel to 4.  That is, read the 3 bytes
after leave the most significant byte as 0. 

Whilst technically an ABI change, and correctly written software shouldn't notice.

Jonathan

 
> >   
> > > or maybe
> > > 		*val = get_unaligned_be24(tmp) >> (sizeof(tmp) - chan->scan_type.realbits);  
> > 
> > That one needs a BYTES_TO_BITS factor too.
> >   
> > > but it starts becoming too long IMO. Even longer if `tmp` gets a more meaningful
> > > name. Ah well, any of the three forms should work the same at the end of day so
> > > no strong opinion.
> > > 
> > > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > >   
> > > >  		return IIO_VAL_INT;
> > > >  	}
> > > >  	case IIO_TEMP: { /* in 0.0625 celsius / LSB */
> > > > -- 
> > > > 2.25.1
> > > >     
> >  
> Kind regards,
> Antoni Pokusinski
> 


