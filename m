Return-Path: <linux-iio+bounces-20918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADDAAE4C9F
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 20:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A48C189CD5B
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 18:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA1242D68;
	Mon, 23 Jun 2025 18:16:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090542065
	for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702570; cv=none; b=eP335SdttyLToGAXxPISNN32rl97zSgn7w1jTcJfqNegJff75SqldtWMYh39uohQ2WyKFkt++D23GmRD5yYsyHUfELbdCHRy6A9lfUhM1u9TARvvrwFx1gF2Yw4dbef8E56RGGUZdoRVy+FaHHlX7Y3Wf/4Tpp2vtLTCCM/Rxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702570; c=relaxed/simple;
	bh=qMFBZekCPVTMf9SvkH/5wR6ClBHJVTkBxTWqLtS3fQM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBwpn5uPXM9XOD6G9/+rK0iJeOz75f+P64RQz508jk6I2OpGq/09SA3JiwjG7fQto9/4dzlWGWy33k1dlxDy5vcyWeTiQTB+P7nOSZIYgBzWCqs+2qmFnUtr7GZF9gL8wXw1erx3cVXx/UIjIDLDBp7q/eIBfm4w4at5w+hJZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 206b6da1-505e-11f0-9ff9-005056bd6ce9;
	Mon, 23 Jun 2025 21:16:05 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 23 Jun 2025 21:16:04 +0300
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: EXPORT_SYMBOL_GPL_FOR_MODULES() heads up
Message-ID: <aFmZ5FRiNsoHtSPo@surfacebook.localdomain>
References: <aFkwMyQ4v6i4JBG_@smile.fi.intel.com>
 <20250623184158.28ebfef6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623184158.28ebfef6@jic23-huawei>

Mon, Jun 23, 2025 at 06:41:58PM +0100, Jonathan Cameron kirjoitti:
> On Mon, 23 Jun 2025 13:45:07 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Pay attention to a new commit 707f853d7fa3 ("module: Provide
> > EXPORT_SYMBOL_GPL_FOR_MODULES() helper"). This one is what we
> > mostly need in IIO.
> > 
> 
> Thanks Andy - I'd not registered that merged.
> 
> I was following the discussion that lead to that patch and
> it was targeted at a different use case to our typical one in IIO.
> I was to prevent anyone else getting access to a particular call
> that was needed for modular KVM. It's about abuse prevention rather
> than what we typically care about which is reducing namespace
> polution.
> 
> Now that's not to say it isn't also helpful for us, but I'd like
> to not rush to using it until we see if it is getting general
> adoption outside of that specific KVM case and similar.

FWIW, I have noticed this due to the commit
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=b20d6576cdb3530d4a2d81611a8b8eb99780ce3e

> So let's wait a cycle or so and look again,

Sure.

-- 
With Best Regards,
Andy Shevchenko



