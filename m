Return-Path: <linux-iio+bounces-21398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF3AFA509
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 14:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C64E17CB85
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AB81F192B;
	Sun,  6 Jul 2025 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il/al//1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F84430;
	Sun,  6 Jul 2025 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751803442; cv=none; b=bYqteRNQpy5BTiMAmQdSUtWFqv+XIrpFiqHx+hR2tEgALBoXmN9I2Vf+09Y5vw9+yuC3sazd9HhDBeHzIuwy4zDjdabSF8c8m5hpFNeJOG0G0rM3cUjdZWM9Cz74VMBJKORVHkOqWQ6H8SR3kAy08xXuexSS1mlxL7kwCjQ+9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751803442; c=relaxed/simple;
	bh=ffNR0btLjrsULx7vcS9topZNvmkb08JnLqNltkd+u9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVNZMXCydqQSPTmxktI93Str1BhJdzULlONBFBL2K3CuWVvWgwwQR/Ooo6llzjGoTQjWeov3HeqObb/A6NQsDBpo7aUnVZDvoYCbbMtXRUK0GnNrUhJ0PK2Fv0Rw0YLkx4bz+9tzYOBjoAZGqY1qMj3jbiUtBfaoi5X+iH8um7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il/al//1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D508CC4CEED;
	Sun,  6 Jul 2025 12:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751803442;
	bh=ffNR0btLjrsULx7vcS9topZNvmkb08JnLqNltkd+u9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Il/al//1/jPki7qFAIFbfbsFGHTdHtGplCXmxlM5Ruk+IiabHSNDzVGTl7/eagKaB
	 ly8N9RqzwrnSWm2WNscFwYGwiiyIR2ccpdsdYM6dpY6+ayHyzIuTkx0DRRcIf2WnCj
	 Sn33zEBdmRTrbl8FZgScJe8KmHXFz0oHIG/AWUvG0FU9BUiW4pvJzOncOkBB0pS4o7
	 tTjU8gBVwkMyWRZoSN8HE4v/crT3ZuLbqCgKFIgfBR1O8pEQkNEiOoMA6TBl9rB/Ux
	 cO15jA1kNqj8ifHebWM99HY5ZBn1ZUO0jKV2leqxOAr+ck1JktfrbygrWK7mBHcSmg
	 YeGbYkTH7cP/A==
Date: Sun, 6 Jul 2025 13:03:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 bagasdotme@gmail.com, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iio: accel: adxl313: add power-save on
 activity/inactivity
Message-ID: <20250706130354.390f7be3@jic23-huawei>
In-Reply-To: <aGaWdEto-z3_dKr9@smile.fi.intel.com>
References: <20250702230819.19353-1-l.rubusch@gmail.com>
	<aGaWdEto-z3_dKr9@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 17:40:52 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Jul 02, 2025 at 11:08:11PM +0000, Lothar Rubusch wrote:
> > The patch set covers the following topics:
> > - add debug register and regmap cache
> > - prepare iio channel scan_type and scan_index
> > - prepare interrupt handling
> > - implement fifo with watermark
> > - add activity/inactivity together with auto-sleep with link bit
> > - add ac coupled activity/inactivity, integrate with auto-sleep and link bit
> > - documentation
> > 
> > Sorry for the fuzz: when I was about to rebase for submitting I
> > noticed Jonathan actually already applied parts of this. I'd recommend
> > to consider v6 rather over v5.
> > 
> > Since activity and inactivity here are implemented covering all axis, I
> > assumed x&y&z and x|y|z, respectively. Thus the driver uses a fake
> > channel for activity/inactiviy. AC-coupling is similar to other Analog Device
> > accelerometers, so MAG_ADAPTIVE events are chosen. Combinations are
> > documented and functionality tested and verified working.  
> 
> Overall LGTM, one nit-pick somewhere, otherwise feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> to the rest of the series (which has no my tag yet).
> 

Tweaked as suggested to err_reset_fifo and applied with tag on whole series.

J

