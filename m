Return-Path: <linux-iio+bounces-25795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E56C28E01
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 12:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688C6188D70E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 11:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB6C29AAE3;
	Sun,  2 Nov 2025 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnjBl1yu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE3299AB4;
	Sun,  2 Nov 2025 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762082219; cv=none; b=Zm9uf/zWwj93l3PxnBe8WEjooGojuMIXZhoKQOGH+kxZr3PYqSaS/p12yuZG3ToHOgiaHGyFm0NPX+J4Sdix2HKOViLZsdztcFKVtVVPS0nqWSBvM3T4ubIvIQXi7xxJrgugd9ichkp9muPFff8GffZyLF5mYvDWQ5ah/aITYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762082219; c=relaxed/simple;
	bh=+55SDzzuC1w7VAx3o43TzO3mcMJJORGrhXePDlw6MA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfSrXLqyIImhXYhlvABCH1QxJ5pCOD56OJGUu2IwmDCobQnyuFTSzAM0+AbD6/uY5q57dI+j4A372zyWtJbc4FNwtLQVX0DlH9qU35ZDjSqYPYO/l4zOTHGV1aHMOSA0Z/hi9SwujUTbHomIYJMH8SmY+UortZ3AMLEgHLDAQDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnjBl1yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CBAC4CEF7;
	Sun,  2 Nov 2025 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762082219;
	bh=+55SDzzuC1w7VAx3o43TzO3mcMJJORGrhXePDlw6MA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TnjBl1yuXVUCC94ifK2T1mm2FcRJqaPi7NF6bABto/Wsd7XjTAu5ENcFrcHXi51UD
	 wrTBFwzU8QyYnUC88L3yrfYs0VW2vEGTWvGLACF3q+9aKGQvACiXlK/SN+8D+Qjerz
	 aZ7XH+p6QhZkqgdftv3x4wA4Y4hh5JjXIGhpnXyYF9EIDx43fM6m+KTghcEJFIJeFg
	 s5oeKScF62OYZAat1WdAh/vKwRIG30/eDtM6fn3zfWLsVJ4RAKSZcibSrkOXW7B4CS
	 ZwmlYj7zzBnG4CSOCtQp8LBQFDPhq6/9zBsQdxkqEZDJEbBMvw1Al0lBqkZLQ5z7VX
	 WDjSHMJWD2jdQ==
Date: Sun, 2 Nov 2025 11:16:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize
 iio_chan_spec data
Message-ID: <20251102111648.73422267@jic23-huawei>
In-Reply-To: <20251030072752.349633-2-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	<20251030072752.349633-2-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 08:27:44 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> Using the ST_LSM6DSX_CHANNEL_ACC() macro as a static initializer
> for the iio_chan_spec struct arrays makes all sensors advertise
> channel event capabilities regardless of whether they actually
> support event generation. And if userspace tries to configure
> accelerometer wakeup events on a sensor device that does not
> support them (e.g. LSM6DS0), st_lsm6dsx_write_event() dereferences
> a NULL pointer when trying to write to the wakeup register.
> Replace usage of the ST_LSM6DSX_CHANNEL_ACC() and
> ST_LSM6DSX_CHANNEL() macros with dynamic allocation and
> initialization of struct iio_chan_spec arrays, where the
> st_lsm6dsx_event structure is only used for sensors that support
> wakeup events; besides fixing the above bug, this serves as a
> preliminary step for adding support for more event types.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>

In cases where there are only a small number of options for what the channel
arrays should contain, my normal preference would be more data over moving
the complexity into code.  That is have two struct iio_chan_spec arrays and
pick between them based on availability of the interrupt.

I haven't checked the whole series yet, but how many channel arrays
would we need to support the features you are introducing here? That is
how many different combinations exist in the supported chips?

Jonathan




