Return-Path: <linux-iio+bounces-10888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF389A7263
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 20:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4701F24B40
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931631F9419;
	Mon, 21 Oct 2024 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chQWSQK0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0001EF941
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535580; cv=none; b=bfFqhggeyaC0HzsvGk1ZjR4Y2B7gJNEP+sdk9i+Cx9AQJwb3zDDjiQzuB6s4fvjBKd29uJWh1d8ThQvyFe2El033gzp/r0/qGipIAkS2qc51rw7stv+rG6Opx1DU9iHFP0IKPhwsIMSydBGdizgeU5l/F+W/yA6K/5SK7/d4E5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535580; c=relaxed/simple;
	bh=xvA4avjANey+0vEHMf7eD4Rioj05sFnrEhAP0yzYz0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ch3NWkr5Cki1gQ4Gh8yC+bejeTdD46ilLDMFsdHyDCrGLntIAr3Wpd+UV7FohIfq3YB3vD4KfZt0v/FIWZ9xhMK+Htj7VP1bYg/BM/fjLMQdcibQVY1aFd6jpWEma8Si52fjBTV8mTh6EjFt/TeRpbldd/XFeizxC0y6aSQ+82Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chQWSQK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E45CC4CEC3;
	Mon, 21 Oct 2024 18:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729535579;
	bh=xvA4avjANey+0vEHMf7eD4Rioj05sFnrEhAP0yzYz0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=chQWSQK0IhvpKyJbuVJjiWYm1tAafkqVkVAZ4WYqOTmIOozPaVnHhN6MVeQRAFaNX
	 CJrShY9UjKV72Vv9GYObkfyWMIxan5OG/++4RRFO+ILSpOoKuGd1L4y3LPvPWsAR/M
	 Tjh6wb30sBMXbBNep688wS1yY6qK7giApV2qPxQ9iucYUvM4rg8TB1rflL2UY1fAj7
	 OyVtyulo9+5wsG+WmDfWHp5iyEv+D4dzXewTgon8PgN99amekeZE3+9uKKfW9jgI8p
	 GBMMcak7zabcNB1/xNyP2KIX3N9mnn+aaDMyONQHZjqQXBD91zpGKwpxqF+/jcHPCL
	 3XKkkBpggLU4A==
Date: Mon, 21 Oct 2024 19:32:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: accel: replace s64 __aligned(8) with aligned_s64
Message-ID: <20241021193254.61ea9048@jic23-huawei>
In-Reply-To: <ZxX-YXTOuYEb8AoY@smile.fi.intel.com>
References: <20241020180720.496327-1-jic23@kernel.org>
	<ZxX-YXTOuYEb8AoY@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 10:10:25 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Oct 20, 2024 at 07:07:20PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > e4ca0e59c394 ("types: Complement the aligned types with signed 64-bit one")
> > introduced aligned_s64. Use it for all IIO accelerometer drivers.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > 
> > I debated whether to split this up by driver by the time we've done all IIO
> > drivers that will be a very large number of trivial patches.
> > 
> > The changes are minor enough that they shouldn't present much of a
> > backporting challenge if needed for future fixes etc.
> > 
> > I'm find splitting them up if people prefer.
> > Next on my list is to look at adding runtime checks that the buffers
> > containing these timestamps are big enough but I want this out of the
> > way first.  
> 
> I agree on all your points.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Applied given it's so trivial and 3 people already reviewed!

Thanks,

Jonathan

