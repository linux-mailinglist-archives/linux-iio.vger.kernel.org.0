Return-Path: <linux-iio+bounces-27874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4542DD38539
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33D51310D9AF
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BD9348879;
	Fri, 16 Jan 2026 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t03XsJU8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D84A92E;
	Fri, 16 Jan 2026 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590123; cv=none; b=KZRNvGWDQ38OcpIRlhckfl5gJzh3ztz3+9yX+UIdOiPA4q2z7JzsyEFPndGiI5WRoWd+yMXs7/J3V8OBuRWD1u2e2FiSO6T3TRRkXnbOZvKDrBVJFLxKTIMnfne0Wh+iHi3k5OpymA3rRMBIcLwH5gVRwxBqw4AJMSpFGYF8wqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590123; c=relaxed/simple;
	bh=Z7pn9hHPvIKBxiWZ46T+k8jygbiSiwg2YvyDSdtlcjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6mjlcRv9Pqqe2KN/dpEgJagQaT2+DL/D8WX3+uJQzdGaQlAzOufe53JAY5nZaVSkgj6v+Uq/vY3+Br9/vaTAXwTj3J5YZSVDaQeWek6RBigvZS1SSVmOOjPQtTk3m88ZtdsohjjpePaWU5I7sP/4WpDe8tW3eAJuFu9+BIbwiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t03XsJU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF48C116C6;
	Fri, 16 Jan 2026 19:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768590122;
	bh=Z7pn9hHPvIKBxiWZ46T+k8jygbiSiwg2YvyDSdtlcjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t03XsJU80zF0hllmo4AkN7s/el+rYBNqttwxAgQW9DgNoDCbQId7i2WzjE7eOQoCf
	 ih15/bWPkB7aR7nuURO9aNFTWcM5fQROk06QOrFAKsPetPUpPc5gLYpkkpKl0o3a5N
	 iqGUsca5Q8ZvTTKSsM+mVQQNmjypB9sDRlMKY5C3RPhVj5O6IyquYMOZuDonw0mJqA
	 sq4saii3rqPkDVB+ADR3DC+aJ4neTwBlvjBMVjBnKDj8Cd5JVDTPKL+x77NigS8sYm
	 PWK9ZW7xU08Y6301pIZFXtxPbmiGrSjWZAAemyn0H4rZxCa3GRKFsx7swYjgKZ9S6w
	 +odVNY5lcF9hw==
Date: Fri, 16 Jan 2026 19:01:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 00/13] iio: pressure: mprls0025pa: driver code
 cleanup
Message-ID: <20260116190153.082b9cc0@jic23-huawei>
In-Reply-To: <aWfNwLRi4ftU5LLC@smile.fi.intel.com>
References: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
	<aWfNwLRi4ftU5LLC@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 19:09:20 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jan 14, 2026 at 06:55:29PM +0200, Petre Rodan wrote:
> > This series contains a collection of patches to the MPR sensor based
> > on feedback I received for other drivers.
> > 
> > major changes:
> >  - trigger flag fix (define edge direction only in the device tree)
> >  - fix SPI timing violation
> >  - fix scan_type struct
> >  - fix pressure calculation
> >     (does not affect users that define a sensor via the pressure-triplet)
> >  - stricter check for the status byte + better error return levels
> >  - drop the use of devm_kzalloc()
> >  - stick to the datasheet parameters while performing the measurement
> >     sequence
> > 
> > minor changes:
> >  - includes added and removed
> >  - rename generic 'buffer' variable to 'rx_buf'
> > 
> > Tested on two sensors - MPRLS0015PA0000SA and MPRLS0001BA00001A  
> 
> This version looks good to me,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> The change I mentioned can be sent as a followup.
> 

Applied to the togreg branch of iio.git.
(I wrote this earlier but apparently didn't hit send for some reason) 

