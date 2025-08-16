Return-Path: <linux-iio+bounces-22835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDA1B28EAA
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC48AC30AD
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A85D2F1FEC;
	Sat, 16 Aug 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1KhSq1c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEA2F0684
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355990; cv=none; b=HVJR63lk28U4RTQpXWn96nLdgkL0iZPkVN8DmuN4IqwnYI2+s+LeowQxAYsAKLqlZbEfI8SyJlUwc25arNnRcvW/3MnYK3/8Zq2uT+ktzcZwqLP+SuZ4PIodxwHAewcjk6aASHQZcItq29CFkqENg67+YX7JfBJG4A19Q/cpjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355990; c=relaxed/simple;
	bh=3TAdWTbvszTv58hHzAHQsdfYSaiVDlGqChVAPrHaZkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASOfcrePSeKYbw/a0jog6lT0XzVKIzs7x0vhlyOVbtWPXelgaHbnGqh30CDeORD9+DQEEZ8le/qPsv4rohuF+HwFXRxe9THgIgBrbP6Xu5pRv5aXqfSAk1+ccsKgxuzXKXP+mCJCSkoSb6r6jWRbPcuFQ8Nj00iDz/WLxhU4G74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1KhSq1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE29C4CEEF;
	Sat, 16 Aug 2025 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755355989;
	bh=3TAdWTbvszTv58hHzAHQsdfYSaiVDlGqChVAPrHaZkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L1KhSq1cDxkyAEn4r938nxLNINUKA8tJ2hg6jflpWLyAi7keLJgGnHmFn/vd+8fG+
	 hy30d2QSyKaDA8L+FkO5+n3q/j5FotrbojL5ZcIa9oEGmsQza3I1RVGhUH7HZIfT66
	 iE1vb/Y63jC6LyN3vqc7WZvhGbRFbQcsatyTuJ/tHztyNMpcCWapjh2TlyAtMwLCeF
	 3ZBDS5QC/am3f6WBU93dVCHObfmMFK4yPzmg0nFKOLQfq9422tviQlthnJj+LF31am
	 3Ityqr/DvowpI6g1P69xdxgJToiJslJAB8EGRDxkTK0GqpC6V1iWYAptfHT8son+m5
	 eW5slDGJQCvvw==
Date: Sat, 16 Aug 2025 15:52:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>, =?UTF-8?B?TcOlcnRlbg==?= Lindahl
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 09/16] iio: light: isl29125: Use
 iio_push_to_buffers_with_ts() to allow source size runtime check
Message-ID: <20250816155258.239252bf@jic23-huawei>
In-Reply-To: <5dc80967-6bfb-4caa-8e6c-dc8b7c533df9@gmail.com>
References: <20250802164436.515988-1-jic23@kernel.org>
	<20250802164436.515988-10-jic23@kernel.org>
	<5dc80967-6bfb-4caa-8e6c-dc8b7c533df9@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Aug 2025 10:06:30 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 02/08/2025 19:44, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Also move the structure used as the source to the stack as it is only 16
> > bytes and not the target of an DMA or similar.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied.

> > ---
> >   drivers/iio/light/isl29125.c | 14 +++++++-------
> >   1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
> > index 6bc23b164cc5..3acb8a4f1d12 100644
> > --- a/drivers/iio/light/isl29125.c
> > +++ b/drivers/iio/light/isl29125.c
> > @@ -51,11 +51,6 @@
> >   struct isl29125_data {
> >   	struct i2c_client *client;
> >   	u8 conf1;
> > -	/* Ensure timestamp is naturally aligned */
> > -	struct {
> > -		u16 chans[3];
> > -		aligned_s64 timestamp;
> > -	} scan;
> >   };
> >   
> >   #define ISL29125_CHANNEL(_color, _si) { \
> > @@ -179,6 +174,11 @@ static irqreturn_t isl29125_trigger_handler(int irq, void *p)
> >   	struct iio_dev *indio_dev = pf->indio_dev;
> >   	struct isl29125_data *data = iio_priv(indio_dev);
> >   	int i, j = 0;
> > +	/* Ensure timestamp is naturally aligned */
> > +	struct {
> > +		u16 chans[3];
> > +		aligned_s64 timestamp;
> > +	} scan = { };
> >   
> >   	iio_for_each_active_channel(indio_dev, i) {
> >   		int ret = i2c_smbus_read_word_data(data->client,
> > @@ -186,10 +186,10 @@ static irqreturn_t isl29125_trigger_handler(int irq, void *p)
> >   		if (ret < 0)
> >   			goto done;
> >   
> > -		data->scan.chans[j++] = ret;
> > +		scan.chans[j++] = ret;
> >   	}
> >   
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> > +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> >   		iio_get_time_ns(indio_dev));
> >   
> >   done:  
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com


