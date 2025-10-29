Return-Path: <linux-iio+bounces-25630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DC9C1CB45
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 19:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 917A04E1FE9
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 18:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A10B355046;
	Wed, 29 Oct 2025 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV/xve4K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240633F8AD
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761450; cv=none; b=bWJAsqjP74dPidJgOF12HjlzbNN9z6CS/CfpPzrrHX1bSXARdtJrQcAEOLBVA/VI8lGcfcI1MJFJb2mvwzRZe35VWi/TZ1GFTqL1Rg9kwBVz4H1DUFlRe5q7TA1W94hlrmnuqjdSDmIUjT3v8WGUOh5cHBrV44tVDJIJBw7UtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761450; c=relaxed/simple;
	bh=T1dDe4fF+Gy9LcvzjbTF78eafwB4w168lpzpr6gvaC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqX9jachUfyLtbFj+EXZvESnni179baW9FDKh7bEu4wQQvlzHgqNJwLs4Bufv4ihmQm+rzxs77CLZHovrSpm8zsqQfoYjdM3ywc8yTx0j7N1TXl6gMwLgln7Rp1gawZx/zvqB1k2JFJ/ZEtYmF3b0ii7NsTsVc42eS5nR2hHcyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV/xve4K; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so188950b3a.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761761448; x=1762366248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=agJFytMuXaOzzx9eJ7GjTw67SZ3daSqUTCtci+2uLtM=;
        b=PV/xve4Kv2VqBQFNxT6v5eWFw3bNkdIZBKjd/Ds0PBuIsQT+dy17EquEg+gKCLjbXa
         upFlDcG+SgpKbjCk98yUcfCOuUu19aGOovAg/obPTv+hzaRZfkaCbl9sXoM0QxKLq3d1
         hfC8Sb0NYBZPNBLCeU+IMTM8jPpxl8ks6qzYq6PmpWXFrB1xfbq86tHM8WsvyCePS6SB
         1PZ/xwURPDQKT+A1xUnUQ68MgNYvmCbqpmWF4S54Aunb71Gr0bzlNtyI5NXNrRyQHtmZ
         USZOoya9ppLX+A3DD4U9AmjtRrWToHpyMzQLusnJoqyBQbsktX3xoQuMTlXW+aqhcCjS
         6oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761448; x=1762366248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agJFytMuXaOzzx9eJ7GjTw67SZ3daSqUTCtci+2uLtM=;
        b=gronsmAdHqKE8mH0tQabCY0A0q22PXdM52DcEr6RVQ1IfhwVaTrfoiMZkKSghLy/ga
         59arIJv+Xlwb9v2rWkhyPc7P0BBTf8FPoejJhTlUKpM33W0/ZxQmUR+bpOIfDyGoAj15
         9Nub81YvmB9z7qgRsxbK/7TJkLGF+eym9OAUReitn9HullGO9VZz16+W+gewAEz/+zXG
         woYenT5puJT1bW1OUvRwtAXJQyA9AcQlb9805mmdDLl8ltw7DQRS9GktPeidtP0vHf7Q
         0QKFLnw+sLqPuXmhAOoaL0SG+E9du+Tf8yUTeA4qpyLAC19lvZexVGb+yaCm1j2QRJK9
         +8uA==
X-Forwarded-Encrypted: i=1; AJvYcCUEjAMHf4m2EzOv69XacXNmuxiCeh38TVlrv4yHhXeQhz191pnEHcMaYxvxmwUlZyeP2xxUPvjDzVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrWlSuZ11yTqwia8NfQ/oYOwkH40bTf5feRZtUQKd9pJL7tdwC
	uWFWdqyezKLvkHEcu+vCXYM45eLTuZS39htDnAX1fJaTzq1QlxZluCpo
X-Gm-Gg: ASbGncuclmEQd28lv/0+qbplhdjR2uav0Z5xb6GDfFGL0m2ilaTE87UIzmAKwNwsBkJ
	bBJXei5/0MwVDEqwFUh4wL3fJZVDq/dyPT2VNR61VJwi5DvgFHPv38MZ+0IE89eaL6Iss0QOvGv
	Qlosda0t5onnvD/lZdGBopioEukFYNXD+vs2oBfKNpRVgdUh2Yncr30AVqOKfyCjRXMpTnyEeQN
	m4vf2za+w2y3MheTE1EmbHP6nuTzm5Vx7EPb3vZ+CQQl5BW3UMbmcKV5ge6wuBf6A7m8EOyCuAC
	d5z2EUEJXMkC4PbgKJ7YT09n9tTql6vFbIzIbJVsyrOb9zx0ppwXO3Msb+MWtvYFi6j6UKpqeE0
	UjfCFIe9Ck/cunG61o2qKKe3SHs4SEQDULpq0LL2FbEpGhNUzwV6+xzE4YZh5NgTLmd7BXlJHYN
	C/+34zksd1CA==
X-Google-Smtp-Source: AGHT+IHmC5Yrl54xcDnexWsIAzQgtJ1USAgaMzHIOfEboyM5+j4bp63GVlKTN5o/1wavfr3co1WYBw==
X-Received: by 2002:a05:6a20:3ca5:b0:33e:6885:2bb6 with SMTP id adf61e73a8af0-3478580e749mr390734637.23.1761761447662;
        Wed, 29 Oct 2025 11:10:47 -0700 (PDT)
Received: from localhost ([2804:30c:1653:6900:3b53:af9d:48d6:f107])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b7128884e0asm14495232a12.16.2025.10.29.11.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:10:46 -0700 (PDT)
Date: Wed, 29 Oct 2025 15:11:57 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v6 8/8] iio: adc: ad4030: Support common-mode channels
 with SPI offloading
Message-ID: <aQJY7XizVWbE68ll@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1760984107.git.marcelo.schmitt@analog.com>
 <3fadbf22973098c4be9e5f0edd8c22b8b9b18ca6.1760984107.git.marcelo.schmitt@analog.com>
 <20251027140423.61d96e88@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027140423.61d96e88@jic23-huawei>

On 10/27, Jonathan Cameron wrote:
> On Mon, 20 Oct 2025 16:15:39 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > AD4030 and similar devices can read common-mode voltage together with
> > ADC sample data. When enabled, common-mode voltage data is provided in a
> > separate IIO channel since it measures something other than the primary
> > ADC input signal and requires separate scaling to convert to voltage
> > units. The initial SPI offload support patch for AD4030 only provided
> > differential channels. Now, extend the AD4030 driver to also provide
> > common-mode IIO channels when setup with SPI offloading capability.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > New patch.
> > I hope this works for ADCs with two channels. It's not clear if works as
> > expected with current HDL and single-channel ADCs (like ADAQ4216).
> > 
> > The ad4630_fmc HDL project was designed for ADCs with two channels and
> > always streams two data channels to DMA (even when the ADC has only one
> > physical channel). Though, if the ADC has only one physical channel, the
> > data that would come from the second ADC channel comes in as noise and
> > would have to be discarded. Because of that, when using single-channel
> > ADCs, the ADC driver would need to use a special DMA buffer to filter out
> > half of the data that reaches DMA memory. With that, the ADC sample data
> > could be delivered to user space without any noise being added to the IIO
> > buffer. I have implemented a prototype of such specialized buffer
> > (industrialio-buffer-dmaengine-filtered), but it is awful and only worked
> > with CONFIG_IIO_DMA_BUF_MMAP_LEGACY (only present in ADI Linux tree). Usual
> > differential channel data is also affected by the extra 0xFFFFFFFF data
> > pushed to DMA. Though, for the differential channel, it's easier to see it
> > shall work for two-channel ADCs (the sine wave appears "filled" in
> > iio-oscilloscope).
> > 
> > So, I sign this, but don't guarantee it to work.
> 
> So what's the path to resolve this?  Waiting on HDL changes or not support
> those devices until we have a clean solution?

Waiting for HDL to get updated I'd say.

> 
> Also, just to check, is this only an issue with the additional stuff this
> patch adds or do we have a problem with SPI offload in general (+ this
> IP) and those single channel devices?

IMO, one solution would be to update the HDL project for AD4630 and similar ADCs
to not send data from channel 2 to DMA memory when single-channel ADCs are
connected. Another possibility would be to intercept and filter out the extra
data before pushing it to user space. My first attempt of doing that didn't
work out with upstream kernel but I may revisit that.

We could maybe split the driver into two. One for supporting two-channel ADCs
and one for single-channel. Though, we would fall into the same issue when
handling offloaded data for the single-channel driver.

