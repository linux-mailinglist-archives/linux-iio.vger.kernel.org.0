Return-Path: <linux-iio+bounces-2164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AD2848F40
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 17:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9624283B58
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE023749;
	Sun,  4 Feb 2024 16:26:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9D22F0E
	for <linux-iio@vger.kernel.org>; Sun,  4 Feb 2024 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063981; cv=none; b=NsKyRRqRTl3ktCt3r/awyVmYjZ8p7TCtjeqXFGdls1E0304zpFqnFf4qFsdlzYlqef90DmhqqAEgwMWMuWxGXsscenHYlJLltqWU8D/VyI3eReeSkJMINwNi3A33DEl0aNuN7dlnSOH3KThw34o2E1ogpAZfilRuKipJOs3xfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063981; c=relaxed/simple;
	bh=WPOSF1o+U6IhCqyoPXUc5JkrOHyb2bBwRr1ujyAaMdc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOcQYAr/LhOPvDxbuc+umsNASp34OPY+iQKylmhoo3ZPSskcOfRjYaaeJe76cEWiT+0XtVhH4Ed13HQERNIvBYHrH3mMa1WNP+xVlkCXKUHfO6mJafvueXnFqf6CeVaLWPkdVaP3lDcCoaOh1EspwGZYO2YITzeZYPgRM4wyQ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 1eeac7bd-c37a-11ee-abf4-005056bdd08f;
	Sun, 04 Feb 2024 18:26:17 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Sun, 4 Feb 2024 18:26:16 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/10] iio: locking: introduce __cleanup() based direct
 mode claiming infrastructure
Message-ID: <Zb-6qPf66YJFqerk@surfacebook.localdomain>
References: <20240128150537.44592-1-jic23@kernel.org>
 <20240128150537.44592-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128150537.44592-2-jic23@kernel.org>

Sun, Jan 28, 2024 at 03:05:28PM +0000, Jonathan Cameron kirjoitti:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Allows use of:
> 
>        iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>        }
> 
> to automatically call iio_device_release_direct_mode() based on scope.
> Typically seen in combination with local device specific locks which
> are already have automated cleanup options via guard(mutex)(&st->lock)
> and scoped_guard(). Using both together allows most error handling to
> be automated.

...

> +/* This autocleanup logic is normally used via iio_claim_direct_scoped */

Wrong name? And missing parentheses.

-- 
With Best Regards,
Andy Shevchenko



