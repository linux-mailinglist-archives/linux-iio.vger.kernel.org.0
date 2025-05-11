Return-Path: <linux-iio+bounces-19435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83244AB294B
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 17:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9757B3B0E1E
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 15:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451AC25B68A;
	Sun, 11 May 2025 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az0y9Wl+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D7256C94;
	Sun, 11 May 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746975951; cv=none; b=F4anke27J4HNHY1zK3gF1iIlqmCLB79TUI5Zczqvv0zuofUV3dfqWERykbU0c4PtbF1mUbOtpia6/Ls4wQePu/cPxa6S3KMHctfJMRQSJ7EHLhkWV+R2Ci7r2+9pyizlF911+74eHo12ndC2Pj3MkWKefEgnKxpLJpPN5j1DJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746975951; c=relaxed/simple;
	bh=f532yqfXcAqTZsj4y6JvZArxU7J/0LHTCWK9QqGrBHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=az/qBau707uq6+YkOHiFe+rQqBhOZlS7nChb9RiDz6ITfDhDY+4aL0ZwVYj34SLL2GBMPkZHkGKFB2d0WpUFbsxmG9N9Hvd9HdKuO7uOkaP4lAZZ+oab0V6YpbM7/1OdyQ+RMt/ERfIK8gy04MJygHrORc0XYPeWzPcJ/s7rPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az0y9Wl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5C7C4CEE4;
	Sun, 11 May 2025 15:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746975950;
	bh=f532yqfXcAqTZsj4y6JvZArxU7J/0LHTCWK9QqGrBHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Az0y9Wl+s77ebqfiLCwIg//ul8jJXdY06whK/rO0zoBB8To+rIs6zWfL1IcFwh9pa
	 LTPklqUdsPUlEb6pVQvuBWhvsnVrfHa7/UDOXZN4PzDZnPGEwI9kqGvARavVfalUc8
	 Es4UgRLq7kG0/OUp0WOLB31dN9nM83SpOEb2ImUA77Zgj3kZjF7ReNcjdI+7c7pLBd
	 ribF/SlppS0IV37ISEn0eXXHOAt/9rOf2fWYojNHub5MjL6DF+VQ8WZRJUP8qWTi90
	 kr8IQGlCyazc9L0BMMTKOFWjH802BdupTK4SvfD+BL7j92sGbMNcTZI2Oy0rKErs22
	 CVD1LRXbQvIjQ==
Date: Sun, 11 May 2025 16:05:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v7 01/12] iio: adc: ad7768-1: reorganize driver headers
Message-ID: <20250511160539.1290029d@jic23-huawei>
In-Reply-To: <aB0EhqbHd4QXmvxq@smile.fi.intel.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
	<1f7677d31a0165cb30d7eb3b4d613e1337937f9a.1746662899.git.Jonathan.Santos@analog.com>
	<aB0EhqbHd4QXmvxq@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 May 2025 22:22:46 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Thu, May 08, 2025 at 02:03:04PM -0300, Jonathan Santos wrote:
> > Remove kernel.h since it adds a lot of unnecessary dependencies.
> > Add specific headers to ensure all functions and macros used in the driver
> > are directly declared.  
> 
> Suggested-by: ?

Blamed-on: :)

Anyhow, I added it and picked this one up as good change on it's own
even if maybe some other bits of this series need a little more work.
> 
> Nevertheless,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 


