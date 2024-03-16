Return-Path: <linux-iio+bounces-3570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D70A87DB57
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 20:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A58F1F21429
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 19:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0AF1BDE2;
	Sat, 16 Mar 2024 19:49:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25551A38E5
	for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710618561; cv=none; b=s18aFdkHs6D41UIsvGlQF+Wo+YCLOkGC0EuIYXnxAj9GgqIdtEE4mgxmtCt/eS/g0b+RWtPDyZcd/tLa2rkbkIiQn54u1dkgcBbYZoSfGd9ttxrjKGYxtOZUtr8xHzWQiLpkHnzEzGhcCAGpzJY050uMAKANbSSPnwvjAQmKxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710618561; c=relaxed/simple;
	bh=xZvpYBpQr3Dz9jQMjkfFj+YHY5lZ6NVZmjfgy2dQ9as=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdrkemfTB2kqfXcw2X5DT4gx9iZcFvPURg1ftW0aW1vsaYUfr1gO0HoqgIgwiEjx+UjuPkR3KXQ3Ig8a0umL9A7nwB2tUS/x47qE/lk7C0hxLq16LfcyAqvq5TGVIuXupcAKMSBHVVog0cqkY2QqFW9CLEJuIOuKeViAo1uZ9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 4611a19e-e3ce-11ee-b972-005056bdfda7;
	Sat, 16 Mar 2024 21:49:17 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 16 Mar 2024 21:49:17 +0200
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 3/4] iio: buffer: iio: core: move to the cleanup.h
 magic
Message-ID: <ZfX3vQ-0EWFcFN0f@surfacebook.localdomain>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
 <20240229-iio-use-cleanup-magic-v3-3-c3d34889ae3c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-iio-use-cleanup-magic-v3-3-c3d34889ae3c@analog.com>

Thu, Feb 29, 2024 at 04:10:27PM +0100, Nuno Sa kirjoitti:
> Use the new cleanup magic for handling mutexes in IIO. This allows us to
> greatly simplify some code paths.

Forgot, the Subject has a leftover 'iio: core:'.

-- 
With Best Regards,
Andy Shevchenko



