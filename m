Return-Path: <linux-iio+bounces-21937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFACB107A1
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78B1AA19AD
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB25262FE2;
	Thu, 24 Jul 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMfOANyf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766325D549;
	Thu, 24 Jul 2025 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352605; cv=none; b=SG71NObagBNo0+tU2fMiL35mxNMy8wnuHboCDKNpETeDRuix7PuPU2U4EV0/rmOQ+nxW/HYNuXoeBJO6Z3fEsk91W78JOybdvyxQejPemG5Os4h8EkUcZM7oKjwWiNHcWvzi7nOdtc0cb3yJUWzN3E9Wrn7KGg56RMyUEWicNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352605; c=relaxed/simple;
	bh=I3vc9qIadyoA2Oy+WG9mC7O7L+Uss7M1nJsjNCA2cHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmQmS8ZSxnSMppmo1F9+MiGhEBVJNG0EH7QBubcIB5PNyPMmqPVypKwP/qxrdZwgvEKBieXUpJmGA4KibncpUGaG9Oo95f8E1Yn9JKF5JhDSqpl/qbp2LUfsjukixQKQXVL/uMZ24oUJKVPpexmIq0IuPU7+HmD8HTpgS5ZplxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMfOANyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94224C4CEED;
	Thu, 24 Jul 2025 10:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753352604;
	bh=I3vc9qIadyoA2Oy+WG9mC7O7L+Uss7M1nJsjNCA2cHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZMfOANyfxBbXqayAEtdGW95tbNw0ftxMFv9caUNSfvDSg77M0D8AJYS3HioUCTIdD
	 pqrTgjbrOCr6TPLf8jTKiaQ9LrrzE3IMB/ZXkePt5IIAPjrVy+wSDXFbpkVAMm7G2p
	 lk1sihGP2gY/lAR8RrynKfY6oqa/+M01ZqRJOYaVLvblQBGDj+aoiMPpVCY3l8Zjit
	 4ChOp3eZZpQS1rUoevVLJ++z4/fOt+Y2NpwiPKIdYLh54M3bTecjycD1HzoxLtASkw
	 K+l5GM0grK1Fp28gUPkWG8IokJngJYcQhuwFC/rCbjUokeReHHTkcW5JKhIKiwVE4O
	 B0focFBRPpxnw==
Date: Thu, 24 Jul 2025 11:23:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yasin Lee <yasin.lee.x@gmail.com>
Subject: Re: [PATCH] iio: proximity: hx9023s: use
 IIO_DECLARE_BUFFER_WITH_TS()
Message-ID: <20250724112317.0c9b561b@jic23-huawei>
In-Reply-To: <57e16589-3d9c-49c1-ba91-abae23143803@baylibre.com>
References: <20250722-iio-use-more-iio_declare_buffer_with_ts-8-v1-1-36188a3f214f@baylibre.com>
	<57e16589-3d9c-49c1-ba91-abae23143803@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 10:07:55 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/22/25 5:54 PM, David Lechner wrote:
> > Use stack-allocated IIO_DECLARE_BUFFER_WITH_TS() to declare the buffer
> > that gets used with iio_push_to_buffers_with_ts().
> > 
> > We change from a struct to IIO_DECLARE_BUFFER_WITH_TS() since
> > HX9023S_CH_NUM is 5 making channels[] larger than 8 bytes and therefore
> > the timestamp is not always as the same position depending on the number
> > of channels enabled in the scan.
> > 
> > And since the data structure is not used outside of the scope of the
> > interrupt handler, the array does not need to be in the driver state
> > struct and can just be stack-allocated.
> > 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
Given the type issue you fix in next patch, I'll sit on this one for now
(otherwise I'd just have fixed up the below initialization that you call out)

+CC Yasin

> > ---
> >  drivers/iio/proximity/hx9023s.c | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> > index 33781c3147286fb3e2f022201ccf7e908d0b6b12..1203fa4bc7512ea85b55d537e2459104b52407b9 100644
> > --- a/drivers/iio/proximity/hx9023s.c
> > +++ b/drivers/iio/proximity/hx9023s.c
> > @@ -143,12 +143,6 @@ struct hx9023s_data {
> >  	unsigned long chan_in_use;
> >  	unsigned int prox_state_reg;
> >  	bool trigger_enabled;
> > -
> > -	struct {
> > -		__le16 channels[HX9023S_CH_NUM];
> > -		aligned_s64 ts;
> > -	} buffer;
> > -
> >  	/*
> >  	 * Serialize access to registers below:
> >  	 * HX9023S_PROX_INT_LOW_CFG,
> > @@ -928,6 +922,7 @@ static const struct iio_trigger_ops hx9023s_trigger_ops = {
> >  
> >  static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
> >  {
> > +	IIO_DECLARE_BUFFER_WITH_TS(__le16, channels, HX9023S_CH_NUM);  
> 
> Ooof. I remembered to zero-initialize all of the scan structs in the other
> similar patches, but forgot we need to do the same with the array to avoid
> leaking uninitialized stack to usespace.
> 
> 	IIO_DECLARE_BUFFER_WITH_TS(__le16, channels, HX9023S_CH_NUM) = { };
> 
> >  	struct iio_poll_func *pf = private;
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct hx9023s_data *data = iio_priv(indio_dev);
> > @@ -950,11 +945,11 @@ static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
> >  
> >  	iio_for_each_active_channel(indio_dev, bit) {
> >  		index = indio_dev->channels[bit].channel;
> > -		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
> > +		channels[i++] = cpu_to_le16(data->ch_data[index].diff);
> >  	}
> >  
> > -	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
> > -				    sizeof(data->buffer), pf->timestamp);
> > +	iio_push_to_buffers_with_ts(indio_dev, channels, sizeof(channels),
> > +				    pf->timestamp);
> >  
> >  out:
> >  	iio_trigger_notify_done(indio_dev->trig);
> >   


