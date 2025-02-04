Return-Path: <linux-iio+bounces-14965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6B3A2727A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 14:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCC43A47B0
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 13:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2208E211708;
	Tue,  4 Feb 2025 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9K8tegJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBD025A651;
	Tue,  4 Feb 2025 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673570; cv=none; b=CYqDZ+DQaqIut/le5iKShYLZCIeIkfUnge/B39TJX8zQy53IWsU/f86dYXisyfipbHhXJJTYFdcN/A/Vf0kPVD9MelspHlOwaOp6AhvWxFx0hJCIDyRrxvDBnEaKtx55zXt2bMuPU70FRgC3K4hwVikUyTVm8jtH2eTGdayfuBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673570; c=relaxed/simple;
	bh=v8dQwZc+RDfNGdEyEBlS8RKgI0rSd+RCZN5Cunk297w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb3hKunaF1bpivkfM8I8jCjJ6Jr3rLhp9IFHzmp7kmprbd0uyXusmjKzgjWzvqzZvEfRYu9n4dswDXoFSj/3oVTnE5Fl/snf23U3IO7dfx3yBPEpYjnTnfo070eOryCxoLeYEai1zvUTk+wn6ViGJPFId8laKEOmLGbHq2HmGG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9K8tegJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9cd9601b8so536370a91.3;
        Tue, 04 Feb 2025 04:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738673568; x=1739278368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FsSUmCyDEjlRRQk/77j/aqz1QkijMxxBEzWWqU1f7p0=;
        b=h9K8tegJSKg70Uab3AppmFebRA8+ojA3T7Cui7Al0hNX497UoNWgtHBxmxkGDNSksT
         CydW7sm292C49B4jJ2mPohoYuzYUuf6NEXXKx3v77c6criobMKsgfKa9dfL4aE3KmpfL
         Ix0ItucgI6Mr00GQbnPOpWlUgslEmUAlu3/hHb3RR6je4vwxYzws3snskBj4iOA9FeB+
         L9MOdBx6gcXoDSd4k1MkEMlF5tT5/VovMr0xvCxPemekfKVlw5Mu5R5HEvMOLrvEEl3o
         OWiheulXJBxcVX6rr5xkBYaT/U37NE5e8t6qHxaSa567qANfwtyfNVV7QVDREgUUCE28
         MyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738673568; x=1739278368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsSUmCyDEjlRRQk/77j/aqz1QkijMxxBEzWWqU1f7p0=;
        b=LeFh+KvK6VUTKe/c8BEOWzvASlVCfgEPV6ShOeAt4lAkTSHxctDsafjNr+UqygeW58
         NdCTrwprIwllU6AVtbQZacQTsJVu0pUJNI1bVFt86WHEEhGNeStGl4GV8jgJDp0TniqU
         C5O5ReEiARYgtAUqkSY1obmXOD6na6X5pwA5/QfkA6xFf2mlCt+cNJWlvWmL0HPDdm0x
         +/slvCKjijZ7sYoKKH0Bmx1RSPlVe6GRVSsYEneUiwkHOgJhYro29XxaKghJP8KhF53g
         vC0/89N+8JI9G7vcECNXj7UskyX3f/hOvAYUKyVfB/6fb4jLQ5InTyXlyVTtWnHIf7eI
         pfkA==
X-Forwarded-Encrypted: i=1; AJvYcCVuZIdE+yonUa/IeE9aDDwiescONMBjwvO+wEEpfDAzd3TXe43uFCmrdDxNdDoxtZNz+58cFq2YsHzlAGHT@vger.kernel.org, AJvYcCWk2Aih587wENNX86YiKuJt3imezfvafst6da4QYL7As0L1upTQijViHSc9q4lR/6nxZuin8wHIDNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8j+0nJJq+dUIqv0/0LkLqiDOW5JFiQbTFzajMLU2p3zCUa2RM
	maKKNc40kK6cqbtnxUCcAuSKeSPKT8tc6O/7tYlxzYpeyDBfk429
X-Gm-Gg: ASbGnct9QlghhyCX8xe+a5Fa5sQ0zWm5/UJqx0k187QxRMbyLZ5AVi3r/bJfYEv/zxL
	HbBVniAcHrvoDu9izoI/QYqm9t+E55BsqkTpZ/6R6EsQvG6u2GhDqoVQMeST/HhVgN3XwYqMXNa
	f+3iQjhz8zT7Dxn1ve1RH9VFYo6MajITcnZjtvT07EytifZL+V2XvL34xFr949iEhyLZO98j1e7
	9Y1V2WZdZpImzCTElgH5ouexg8XJxbXcP+bGT2mwZTBgOyJK+Wxo8tj0DOLEMuTdnlf43anXCfE
	gM7+uODHIkswc+7Cy8WC5nESQw==
X-Google-Smtp-Source: AGHT+IF3npigCMq0BInZRuttQILORcvhB+MZ/4cPK1MLXMKiA6bdsqESY8K68cM7YFbkG9jxXIHcsQ==
X-Received: by 2002:a17:90b:520d:b0:2f6:f107:fae4 with SMTP id 98e67ed59e1d1-2f83abd7cdamr37261821a91.8.1738673568383;
        Tue, 04 Feb 2025 04:52:48 -0800 (PST)
Received: from localhost ([2804:30c:4042:6b00:ec80:71ac:dccc:2753])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bf95b44sm13456771a91.37.2025.02.04.04.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 04:52:47 -0800 (PST)
Date: Tue, 4 Feb 2025 09:53:30 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, cosmin.tanislav@analog.com,
	jic23@kernel.org, lars@metafoo.de, granquet@baylibre.com,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v3 3/3] Documentation: ABI: IIO: Re-add
 sysfs-bus-iio-adc-ad4130
Message-ID: <Z6INymQYxxJcaEpt@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1738608986.git.marcelo.schmitt@analog.com>
 <0d73303f2bca3312ccf2abfeb2c654c228fa7f60.1738608986.git.marcelo.schmitt@analog.com>
 <322c34f8-a920-41d1-b77c-09537554ad04@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322c34f8-a920-41d1-b77c-09537554ad04@baylibre.com>

On 02/03, David Lechner wrote:
> On 2/3/25 1:11 PM, Marcelo Schmitt wrote:
> > The ad4130 driver exports in_voltageY-voltageZ_filter_mode and
> > in_voltage-voltage_filter_mode_available attributes to user space. A
> > previous patch merged the documentation for those attributes with the
> > documentation for filter_type/filter_type_available into sysfs-bus-iio.
> > Filter mode and filter type refer to the same feature which is the digital
> > filter applied over ADC samples. However, since datasheets use the term
> > `filter type` and ad4130 driver is the only one using filter_mode,
> > deprecate the filter_mode ABI in favor of filter_type and keep the docs
> > separate to avoid confusion and intricate attribute descriptions.
> > 
> 
> 
> > The digital filter helps shape the noise rejection bandwidth and is
> > supposed to be adjusted according to the signal of interest. Depending on
> > the particular ADC design, the digital filter configuration may have an
> > impact on the output data rate (ODR) (which is equivalent to the sampling
> > frequency for SAR ADCs - `sampling_frequency` ABI), 3dB cutoff frequency of
> > the filter (`_low_pass_3db_frequency` attributes), or settling time.
> > 
> > Digital filters are a common feature among sigma-delta ADCs and
> > IIO drivers set digital filters according to different attributes.
> > ad4130 and ad7779 filter options are supported through dedicated
> > filter_mode/filter_type attributes in sysfs.
> > ad7768-1 and ad7173 set the sinc filters according to the
> > sampling_frequency attribute. No filter_type attribute.
> > ad7124 sets the digital filter according to a filter_low_pass_3db_frequency
> > attribute so it doesn't export filter type attributes to user space.
> 
> These last two paragraphs seems a bit excessive and could be dropped.

Yes, the patch is justified without those paragraphs.
I wanted to understand how digital filtering works and how it was supported
across IIO ADC drivers to implement something reasonable for AD4170.
Those are my conclusions after looking at few ADC drivers.
I thought those could be useful but didn't have a good place to write to.
Oh well, that is not covering all ADCs so also a bit far-fetched to propose it
as some doc. Will drop the extra text on v4.

> 
> > 
> > Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio       |  1 -
> >  .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 20 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  3 files changed, 21 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index ff9cc09360dc..e4fd99c92d81 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -2277,7 +2277,6 @@ Description:
> >  		representing the sensor unique ID number.
> >  
> >  What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
> 
> Instead of removing the line, I think we need to replace it with:
> 
> /sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_type_available
> 
> (change mode to type)
> 
> This attribute is used in the previous patch.
> 
> 
> >  KernelVersion:	6.1
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> With those changes...
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>

