Return-Path: <linux-iio+bounces-10579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3A699D6EB
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 21:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6366B21391
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1951C6F71;
	Mon, 14 Oct 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9oMBxic"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24726296;
	Mon, 14 Oct 2024 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728932481; cv=none; b=oKanuyhhpTJwlzrgVqN+uNF+0nst9WkqMq/K/ud13xYiQnTkEXg+McDkEq7VgwBGIMVbCyIMEG1gxeg2kF9I+zD/BlYhpmVgGj+6JdKWjh6kHeB1Jr/YFRyDOOztVYQwH4/Jsbbx8ZjGoxfe/8oMNgcHPSLF40HG4IqCwSR/3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728932481; c=relaxed/simple;
	bh=DoulpXDCPVAqiVKh8GLijg6HiPK/0IenFH/4cMtCQa4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sd0hitTbtURwX7rmUXMGs86Pne6tzkh2C0blIXGd1ew8lB/BK/i9/hvjuHVIF18yOhcW+nOTFJHLlJE4wz64DT8TJc7ny6h+tAOe2fdsDkeZ4ErbXaVO5RdzeXexqUbI5GJs/C9JaSYzJZ+BjBLKb636i65Q8DBN14seaJea5eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9oMBxic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C531C4CEC3;
	Mon, 14 Oct 2024 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728932480;
	bh=DoulpXDCPVAqiVKh8GLijg6HiPK/0IenFH/4cMtCQa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u9oMBxicAA35CINm+aHfbyvfXJQ4A61Sb8O75rC5Y7PL1YlrPGc2GQet+HYkv9t1m
	 DRLQla3RP7rEzdJtiZNxHVyPQ2oUqQxQANaRWka00V+nV1IRQY8+DLEymwibePhb+p
	 OiVNghvEod2SpXB807zmckr1nrn0/ZixBhbubukLn+XsVtsm2PYROfXGX8K9Wo5m0b
	 iaaSCq5W+m2BG+jC/ldRxgh2n248T0yXN3YnuRx44WXHRn6jhdBA/P/DT8OartLQgh
	 llFUYoxh3GTRSmar5ilcO/vkzEvXsACgvT8Vb9/g01O+8CXqkvJvS0w6O96jj+Qw3b
	 zJd4fyWDAoRNQ==
Date: Mon, 14 Oct 2024 20:01:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxl?=
 =?UTF-8?B?cg==?= <philm@manjaro.org>
Subject: Re: [PATCH 2/3] iio: imu: Add triggered buffer for Bosch BMI270 IMU
Message-ID: <20241014200113.2a7b2a35@jic23-huawei>
In-Reply-To: <871q0joh9v.fsf@justinweiss.com>
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-3-justin@justinweiss.com>
	<20241012121812.0c62ba51@jic23-huawei>
	<87wmicpvso.fsf@justinweiss.com>
	<20241013161722.5cb25eb3@jic23-huawei>
	<871q0joh9v.fsf@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Oct 2024 13:54:36 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Jonathan Cameron <jic23@kernel.org> writes:
> 
> > On Sat, 12 Oct 2024 19:43:19 -0700
> > Justin Weiss <justin@justinweiss.com> wrote:
> >  
> >> Jonathan Cameron <jic23@kernel.org> writes:
> >>   
> >> > On Fri, 11 Oct 2024 08:37:48 -0700
> >> > Justin Weiss <justin@justinweiss.com> wrote:
> >> >    
> >> >> Set up a triggered buffer for the accel and angl_vel values.
> >> >> 
> >> >> Signed-off-by: Justin Weiss <justin@justinweiss.com>    
> >> > Hi Justin
> >> >
> >> > A few suggestions inline. Other than the DMA safe buffer thing, looks good
> >> > but you might want to consider using a single bulk read.
> >> >
> >> > My cynical view is that if someone paid for an IMU they probably want all
> >> > the channels, so optimizing for that case is a good plan.
> >> >    
> >> >> ...
> >> >> 
> >> >> +	__le16 sample;
> >> >> +
> >> >> +	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
> >> >> +		ret = regmap_bulk_read(bmi270_device->regmap,
> >> >> +				       base + i * sizeof(sample),
> >> >> +				       &sample, sizeof(sample));    
> >> >
> >> > This is always a fun corner.
> >> > regmap doesn't guarantee to bounce buffer the data used by the underlying
> >> > transport. In the case of SPI that means we need a DMA safe buffer for bulk
> >> > accesses.  In practice it may well bounce the data today but there are optmizations
> >> > that would make it zero copy that might get applied in future.
> >> >
> >> > Easiest way to do that is put your sample variable in the iio_priv structure
> >> > at the end and mark it __aligned(IIO_DMA_MINALIGN)
> >> >
> >> > Given you are reading a bunch of contiguous registers here it may well make
> >> > sense to do a single bulk read directly into buf and then use
> >> > the available_scan_masks to let the IIO core know it always gets a full set
> >> > of samples. Then if the user selects a subset the IIO core will reorganize
> >> > the data that they get presented with.    
> >> 
> >> That's convenient :-)
> >> 
> >> It should make this much simpler. To clarify, I'll use regmap_bulk_read
> >> to read all of the registers at once into a stack-allocated buffer, and
> >> then push that buffer. Then I can remove bmi270_device->buf entirely,
> >> and avoid the DMA problem that way.  
> >
> > Given this supports SPI. The target buffer can't be on the stack.
> > You still need the __aligned(IIO_DMA_MINALIGN) element in your iio_priv()
> > structure.
> >  
> 
> Got it. I see that the BMI323 driver does the regmap_read into the
> DMA-aligned buffer, and then copies it to the timestamp-aligned buffer,
> which it then sends to iio_push_to_buffers_with_timestamp. Is that a
> good way to handle this?

Yes.  We don't have a zero copy path so that's the best we can do.

> 
> I think the timestamp-aligned buffer could still be stack-allocated in
> that case.

No it can't.  __aligned doesn't do anything useful for us on the stack
as we don't control what comes after it.  You could in theory force alignment
and pad - as long as compilers now respect __aligned  for this case (they
didn't use to!)  It's potentially a few hundred bytes on the stack, so
better on the heap.

> Or maybe a second buffer isn't even necessary, if
> DMA_MINALIGN is at least the correct alignment for
> iio_push_to_buffers_with_timestamp and I could pass the DMA-aligned
> buffer in.

Common trick is to just DMA into almost what you already have in bmi270_data.
But now the timestamp is in a fixed place you can use a structure to handle
the alignment for you.
	/*
+	 * Where IIO_DMA_MINALIGN is larger than 8 bytes, align to that
+	 * to ensure a DMA safe buffer.
+	 */
+	//__le16 buf[12] __aligned(IIO_DMA_MINALIGN);
	struct {
		__le16 channels[6];
		aligned_s64 timestamp; //type is only in iio tree currently.
	} data __aligned(IIO_DMA_MINALIGN);

The aligned_s64 is needed for x86_32 where s64 is only aligned to 4 bytes
whereas IIO assume natural alignment of everything (so 8 bytes).
 };

Then pass that to the push_to_buffers call just as you currently do.

Jonathan


 


