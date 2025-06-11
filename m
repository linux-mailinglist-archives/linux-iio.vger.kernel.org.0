Return-Path: <linux-iio+bounces-20468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862C2AD5CA4
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 18:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC25E7ACC08
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E972063D2;
	Wed, 11 Jun 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBMjNugp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673EB1EDA02;
	Wed, 11 Jun 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660481; cv=none; b=IdxyZt41ZB9IGNv35REHxEb3AwEeI3RqCQNWHAcLaPZulTFjaQqEhUzv5AJbm01vUD7YIAPsmWXQupmRcOh9IFH9IixP4TPRUz8bHcXEGjEx8ZR0inUK/YcAZW0zxp65ylEqe6ANUlI0TppuzQH6kAAPK1cZqwx9LOW8ePyDVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660481; c=relaxed/simple;
	bh=shR7CjHfewUOZWnt1K8nSueY1b7AwTEUCxc3wScauGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfUTXjlg7zgoAsrDVxzFXrlsGydCs1LbnhAhU5ehef1VH/V/NSHNNxXu158s/UsKpwPpNFPkFumuQrHTvGASrZW9WfH3FeynKBv8MGJg4v30VqHrGpZmdaV7ONpHREnNIWOF2JsZB+rI69cl49s978Rj2oGvI1bsZ//fP1lxs+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBMjNugp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C71AC4CEEA;
	Wed, 11 Jun 2025 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660480;
	bh=shR7CjHfewUOZWnt1K8nSueY1b7AwTEUCxc3wScauGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oBMjNugpvLyh0irwRRKKoaOvvigzPp77i0hOnqd97w1Q4VakWUXoJYf2W3EH5SNs1
	 eFcNITvH/Sws5JtyhbAigpAMOcMe1sqkhtLzYIpj+EyalNAd9I7luoceGkU6rQHvar
	 A72/jpYmp1dFxwzEReG3sCh3yT/SiiBNsuN13HQlzmL5GrdRBfGuHEUYEgne12y6JT
	 bAQQCDdSC4zFmee62JyAnOmugwx1ONxZ83010eDFp+8BNpy0xUv8a+NGLXTQ64e6Ut
	 vDFXG57hTElPCx3f6GO+tw6FJPr+3tveR5tDAA1y43wv4QqkByzrCwK3ZLn1RStIVo
	 Y80uVjh/W2EQg==
Date: Wed, 11 Jun 2025 17:47:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/11] iio: accel: adxl313: add activity sensing
Message-ID: <20250611174751.0612dfc0@jic23-huawei>
In-Reply-To: <CAFXKEHaRupFmFQ9ixTT_3p_XaoorJP=y4asYjw3dSMpxXhbOwQ@mail.gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-8-l.rubusch@gmail.com>
	<20250608170819.3de87f4e@jic23-huawei>
	<CAFXKEHaRupFmFQ9ixTT_3p_XaoorJP=y4asYjw3dSMpxXhbOwQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > >  static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int value)
> > >  {
> > >       struct adxl313_data *data = iio_priv(indio_dev);
> > > @@ -502,19 +705,32 @@ static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
> > >
> > >  static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)  
> >
> > Ah. This does not also have events.  Still it's a mix, so maybe
> > adxl313_handle_interrupts() or something like that.  
> 
> I also could break it up into:
> - handle interrupt source register events
> - drain fifo watermark samples
Sure - if that makes more logical sense that break up is fine.

> ?
> 
> > >  {
> > > +     s64 ts = iio_get_time_ns(indio_dev);
> > >       struct adxl313_data *data = iio_priv(indio_dev);
> > >       int samples;
> > > +     int ret = -ENOENT;
> > > +
> > > +     if (FIELD_GET(ADXL313_INT_ACTIVITY, int_stat)) {
> > > +             ret = iio_push_event(indio_dev,
> > > +                                  IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > > +                                                     IIO_MOD_X_OR_Y_OR_Z,
> > > +                                                     IIO_EV_TYPE_MAG,
> > > +                                                     IIO_EV_DIR_RISING),
> > > +                                  ts);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > >
> > >       if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
> > >               samples = adxl313_get_samples(data);
> > >               if (samples < 0)
> > >                       return samples;
> > >
> > > -             return adxl313_fifo_push(indio_dev, samples);
> > > +             ret = adxl313_fifo_push(indio_dev, samples);
> > >       }
> > >
> > >       /* Return error if no event data was pushed to the IIO channel. */
> > > -     return -ENOENT;
> > > +     return ret;  
> > This handling works, but as Andy observed maybe the comment is now confusing
> > given ret is mostly not an error.  Perhaps put that where ret is declared
> > instead, or use a separate mask check at the start to quickly
> > error out if no bits that we handle are set.  
> > >  }  
> 
> Yes. Andy also pointed out here. I already developed a feeling for
> "something's smelly" with this code, but cannot really think of a
> better approach. Actually it works, and for me it is somehow logical.
> Probably there are better ways to solve this situation in a cleaner
> way?

The check against a mask at the start is pretty common way to deal with
no status bits (that we understand) set.  Then update that mask
define as you support more bits.

That deals with the odd error case.  It is technically an additional
conditional but the compiler may squash it anyway or if on a decent CPU
it'll be a very easy to predict branch as it should never happen.

Jonathan

> 


