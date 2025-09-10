Return-Path: <linux-iio+bounces-23945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0509BB51DA5
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434C21C82251
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C90334383;
	Wed, 10 Sep 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSzw2hH1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233D3277B8;
	Wed, 10 Sep 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521753; cv=none; b=c7EKikVgE57yYYG0SwrGA9+mtYeQphSDHe9sSPKZHEucI3GZPDn2LAltc5FKFRpiTMdyZgvkrWY21O1VlgDHjy2andC0zK0jbgU+9WHEDZymoujY+klaYhiLsC4HSb1RKf53DcjcPgo7f9IIooWOAfAWgwgZwvA2u6a5I2B3tpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521753; c=relaxed/simple;
	bh=Xe9fVm6ckw3sd+kWMHURtc8foU7vbzOBCzr9GkZ5t+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3XX/kfxk2iSBFN9j6BZAEo4F09bpUrixeRfXo+rfFGRS/matQugZvD6uPSsBSnIx4loBbtieokKuOsSzr/CK9HWPC2dqjd4jlQTcDLI0gOB4EDJPKptSQVygWvazPqseotQOwSHjSEFHNUUNMJ/8ZBU+OOwNN33FUOYDdLfr0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSzw2hH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F57C4CEEB;
	Wed, 10 Sep 2025 16:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757521752;
	bh=Xe9fVm6ckw3sd+kWMHURtc8foU7vbzOBCzr9GkZ5t+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DSzw2hH1nydvDnfQrdZP33WV2y0ufQR0Py1CicGNGJSXfsfcTy8lQ3KY8Mqrh0/ED
	 KZJYO3drheecgud6/pPef669TVdEL6VB+kXt+ikwxU60Z6VEHoZjGs0jcH+wytn8B2
	 Qovjk9d+H4kz/3/2dwEdku2v8HnsAsVuZQ8IvOcaiUP467DLwFUYgg30I3HtIESrE5
	 +xq+z9dWDo1NEi9tf8gmVkrusnn+HjSJtTxfHplqzjGb/RGaoCE0mRtGgqi8lv3yDK
	 XJckp0UQm7UXqvLF+JCJMVysZV9s9zG5lWXXH2KRXQCokdVTXMD6+zyK3kUJQBQpPC
	 p4V+SqKut0rJQ==
Date: Wed, 10 Sep 2025 17:29:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] iio: adc: ad7124: add filter support
Message-ID: <20250910172907.5e6cbc6c@jic23-huawei>
In-Reply-To: <20250907112214.36b8564a@jic23-huawei>
References: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
	<20250905-iio-adc-ad7124-add-filter-support-v1-5-aee3834be6a9@baylibre.com>
	<20250907112214.36b8564a@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Sep 2025 11:22:14 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 05 Sep 2025 13:12:00 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > Add support to the ad7124 driver for selecting the filter type.
> > 
> > The filter type has an influence on the effective sampling frequency of
> > each channel. For sinc3+pf{1,2,3,4}, the sampling frequency is fixed.
> > For sinc{3,4} (without post filter), there is a factor of 3 or 4
> > depending on the filter type. For the extra +sinc1, there is an extra
> > averaging factor that depends on the power mode.
> > 
> > In order to select the closest sampling frequency for each filter type,
> > we keep a copy of the requested sampling frequency. This way, if the
> > user sets the sampling frequency first and then selects the filter type,
> > the sampling frequency will still be as close as possible to the
> > requested value.
> > 
> > Since we always either have the SINGLE_CYCLE bit set or have more than
> > one channel enabled, the sampling frequency is always using the
> > "zero-latency" calculation from the data sheet. This is only documented
> > for the basic sinc{3,4} filters, so the other filter types had to be
> > inferred and confirmed through testing.
> > 
> > Since the flat filter type list consists of multiple register fields,
> > the struct ad7124_channel_config::filter_type field is changed to the
> > enum ad7124_filter_type type to avoid nested switch statements in a
> > lot of places.
> > 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>  
> 
> One really trivial comment inline.  Not worth a v2 for just that.
> However, this is complex enough code I'd like to keep this on list anyway
> for a little longer to see if anyone else has review comments.
> 
> Jonathan
Hi David,

Given your self review of the fix, I am assuming you will do a new
version of that and these.  Which mostly means I'll mark them as waiting
for changes in patchwork and forget about them till I see the new version :)

Thanks,

Jonathan

