Return-Path: <linux-iio+bounces-22779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7187AB28C96
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 11:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659445C7B84
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F316328A3EA;
	Sat, 16 Aug 2025 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI8czEog"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B715E97;
	Sat, 16 Aug 2025 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755338057; cv=none; b=jcaJqP+MnxTYaYWWxGPZdGP0qriVGb8ghj3BrKfERoIkLugZMBX/40ogCZKCxgTEyyVh7ozgJBjysgCUGS70dslORVtbj8pCNtCkNedMJXUNSgHGrKJF6CoQ0tregX4bO0+YQcGXVvzEf2MZpQUK8Vj3aMm+3/Za9VzrCKKzXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755338057; c=relaxed/simple;
	bh=NtLH2o5zFdwL8qLnkv2fWmiwgZJi4KCQFqICzRQxE4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9Dd52TdIq1U91YLG5BKhA8mim3ZmIKOcnbkqD5GY6T8iHuPce39mtdqFw4gWJ/d7H3R2W+fooubKOQzCpiQE2JxJgZOkQRsPuCOx71glWLy177Ilfs/6Yi6suzKI5dMMgrM0268uZ0toft4M2DAViLPYCQkbyJO1/lqIHHuSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI8czEog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9724C4CEEF;
	Sat, 16 Aug 2025 09:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755338057;
	bh=NtLH2o5zFdwL8qLnkv2fWmiwgZJi4KCQFqICzRQxE4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fI8czEogd8nQ0MJyN+ikp5ha0X9Hnj3k38RpvscZnt/uGura+0KTetoMXs4KUa0Iv
	 waYJdzjv88/3Wj/UxUTd0tW3Rmo8KVEbp2bMSAUQt3N4JvoAiqLjRtV5yAHCfRVrSE
	 1mjPJRZIcusHuZxsx9EhD6BMQVAy4hdpfwGV3oAp/j175fUCESGpMGY38hyHtp82CJ
	 uv4Znmf+TBRsjNi90a0dcgooDHC08HbPIEajcBOZJUSxtORodI7pr8c/zUqE/N5fhX
	 gZt84Kv+ZVBQRtF676EFKUdMnvMletZBvnwJ+EMXLwJTEHfzQ+ef7/nHXHvIu+ITAN
	 CrbS4V6QKA3cw==
Date: Sat, 16 Aug 2025 10:54:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ben Collins <bcollins@watter.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <20250816105410.70e47dac@jic23-huawei>
In-Reply-To: <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
References: <20250813151614.12098-1-bcollins@watter.com>
	<20250813151614.12098-6-bcollins@watter.com>
	<a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 17:52:04 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/13/25 10:15 AM, Ben Collins wrote:
> > MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> > to allow get/set of this value.
> > 
> > Signed-off-by: Ben Collins <bcollins@watter.com>
> > ---
> >  drivers/iio/temperature/mcp9600.c | 43 +++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> > index 5ead565f1bd8c..5bed3a35ae65e 100644
> > --- a/drivers/iio/temperature/mcp9600.c
> > +++ b/drivers/iio/temperature/mcp9600.c
> > @@ -31,6 +31,7 @@
> >  #define MCP9600_STATUS_ALERT(x)		BIT(x)
> >  #define MCP9600_SENSOR_CFG		0x5
> >  #define MCP9600_SENSOR_TYPE_MASK	GENMASK(6, 4)
> > +#define MCP9600_FILTER_MASK		GENMASK(2, 0)
> >  #define MCP9600_ALERT_CFG1		0x8
> >  #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
> >  #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
> > @@ -111,6 +112,7 @@ static const struct iio_event_spec mcp9600_events[] = {
> >  			.address = MCP9600_HOT_JUNCTION,		       \
> >  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
> >  					      BIT(IIO_CHAN_INFO_SCALE) |       \
> > +					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
> >  					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE), \
> >  			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
> >  			.num_event_specs = hj_num_ev,			       \
> > @@ -149,6 +151,7 @@ static const struct iio_chan_spec mcp9600_channels[][2] = {
> >  struct mcp9600_data {
> >  	struct i2c_client *client;
> >  	u32 thermocouple_type;
> > +	u32 filter_level;
> >  };
> >  
> >  static int mcp9600_read(struct mcp9600_data *data,
> > @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> >  		*val = mcp9600_tc_types[data->thermocouple_type];
> >  		return IIO_VAL_CHAR;
> > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +		*val = data->filter_level;  
> 
> We can't just pass the raw value through for this. The ABI is defined
> in Documentation/ABI/testing/sysfs-bus-iio and states that the value
> is the frequency in Hz.
> 
> So we need to do the math to convert from the register value to
> the required value.
> 
> I'm a bit rusty on my discrete time math, so I had chatgpt help me
> do the transform of the function from the datasheet to a transfer
> function and use that to find the frequency response.
> 
> It seemed to match what my textbook was telling me, so hopefully
> it got it right.
> 
> Then it spit out the following program that can be used to make
> a table of 3dB points for a given sampling frequency. If I read the
> datasheet right, the sampling frequency depends on the number of
> bits being read.
> 
> For example, for 3 Hz sample rate (18-bit samples), I got:
> 
>   n  f_3dB (Hz)
>   1  0.58774
>   2  0.24939
>   3  0.12063
>   4  0.05984
>   5  0.02986
>   6  0.01492
>   7  0.00746
> 
> I had to skip n=0 though since that is undefined. Not sure how we
> handle that since it means no filter. Maybe Jonathan can advise?

This is always a fun corner case.  Reality is there is always
some filtering going on due to the analog side of things we
just have no idea what it is if the nicely defined filter is
turned off.  I can't remember what we have done in the past,
but one option would be to just have anything bigger than 0.58774
defined as being filter off and return a big number. Not elegant
though.  Or just don't bother supporting it if we think no one
will ever want to run with not filter at all.

Hmm. or given this is a digital filter on a sampled signal, can we establish
an effective frequency that could be detected without aliasing and
use that?  Not sure - I'm way to rusty on filter theory (and was
never that good at it!)

Jonathan

