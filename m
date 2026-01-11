Return-Path: <linux-iio+bounces-27608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B8D0EF2D
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 14:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDDBB300B983
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF93396F4;
	Sun, 11 Jan 2026 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aieQc8MD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42707262A;
	Sun, 11 Jan 2026 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768136634; cv=none; b=EdnRCaPaT7a45llc05mxdmyo4LOpjGtlSKROKubLdTWCidiEneCzhkcCZKEs9qqK2fMXpjG0ewghsVZhxA5vt0T4DsVSpzJKvvXXyPL0g95Tc3mWhOEImM4zRO4BpXGOsJaXt7jhxL1QnaEc9G1BuBIAETR5NZBL+dLo7m7w6aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768136634; c=relaxed/simple;
	bh=xnFecsZcJrziBt1AmL7g4IRZf5OWO89RyKWJNmcj2eE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffdGD/4pTaKKwwSEoir2fcwsaFmPQ6zS5pYSkRy9kuKrPHvQm1VYxzMvw+JDbY+WBpcOgF4Kt49JK7rKq0pfm1r7+gn5FGkjsjp0Yc8l8qRCGdotKJNM2JWmPOi4aOMuLZr8V85LvpQkZgxSXb75ZavoZTSuL6cQsUJ2KCM7Gs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aieQc8MD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FA7C4CEF7;
	Sun, 11 Jan 2026 13:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768136634;
	bh=xnFecsZcJrziBt1AmL7g4IRZf5OWO89RyKWJNmcj2eE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aieQc8MDjIdKcTG5cglBl5evJvsk7O0Rr7CJyRHGlPTyg833HKyAj+lrvo7zaR3cz
	 bNQWE9Zi0cuRUpp8wtItPPlUDGdH/2iTpSE5c3DmuUIgDP2wAVhkCDhFqvNJhcQh8M
	 /wdPgqc6l0lA/fT+YJJwX0i/6CtXuvpe7MRXElDzlgEowEWACow69K6HkxpdnY4l7l
	 ExsW3adXctVjVyIZhkp2Ta62ewdVzJ3dAhnDRHuZJYlgpQnzp/r6FBkwGewZksGhld
	 gtv5AweNEQapNT1D2qWkDcZ1BxWWVYa04uHwqFOCrSFcHwkAbj40juoqgK2hMOEOfj
	 BYbjv7szjHR+w==
Date: Sun, 11 Jan 2026 13:03:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Alex Lanzano
 <lanzano.alex@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: bmi270_i2c: Add MODULE_DEVICE_TABLE for BMI260/270
Message-ID: <20260111130346.73ecb12d@jic23-huawei>
In-Reply-To: <aV7KdXkQkI5XsoF3@smile.fi.intel.com>
References: <20260106054519.566796-1-derekjohn.clark@gmail.com>
	<aV7KdXkQkI5XsoF3@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 23:04:53 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jan 06, 2026 at 05:45:19AM +0000, Derek J. Clark wrote:
> > Currently BMI260 & BMI270 devices do not automatically load this
> > driver. To fix this, add missing MODULE_DEVICE_TABLE for the i2c,
> > acpi, and of device tables so the driver will load when the hardware
> > is detected.
> > 
> > Tested on my OneXPlayer F1 Pro.  
> 
> No objections,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied to the togreg branch of iio.git and pushed out as testing.

These are always a bit of a corner case wrt to whether we should treat
them as a fix.  It never worked though so I'm not going to rush them in.
If you want it applied to stable kernels, I'm fine with a request for
that after the next merge window.

Thanks,

Jonathan



