Return-Path: <linux-iio+bounces-14246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA42A0AAF7
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDB0162118
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0001BDABE;
	Sun, 12 Jan 2025 16:37:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1AD20DF4
	for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699871; cv=none; b=YyYiw5ioQItyYJwWwrYY4xjJXA4j1MpQTXJ8VqvgWhkVFW2GatIGnqBaaz8wd/Qdk7d4kJ1wUx7dvUPLP+f8fbB6zx2tZt+CZrcILHj/rTochCjRf/ZkR4GXSUaFMnHDu2gjMlAwTaP0dP567Tly7mRIZY7KfTN4nLuVJ+Wv6+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699871; c=relaxed/simple;
	bh=zgNnFmDaedR6q147uCSiJTEaufymbc8ncrgkAXjAPGU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mD62OFYzjBJeLT910D2tCFnyHjskoGly2pytyiTeYlpCsscIKukJbtWgU8eXarFOuuP6plAdfjkY6TwuZaFHuHBHxUwmNLdNhSJymfNTuq7iDg38TZLse7ybt8ssQZjJxH3opxFOdin59HmDU1Lz6eYmeKgseLTW9UX5rElJ/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 8db110ae-d103-11ef-832d-005056bdf889;
	Sun, 12 Jan 2025 18:37:46 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Jan 2025 18:37:46 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7625: Add ending newlines to error messages
Message-ID: <Z4Pv2jpBZRrbl0oy@surfacebook.localdomain>
References: <20241230151030.3207529-2-u.kleine-koenig@baylibre.com>
 <bbdd02f0-e40a-4ff1-bc7f-10f6b863d2ba@baylibre.com>
 <20250104131132.4c20b330@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250104131132.4c20b330@jic23-huawei>

Sat, Jan 04, 2025 at 01:11:32PM +0000, Jonathan Cameron kirjoitti:
> On Mon, 30 Dec 2024 10:15:21 -0500
> Trevor Gamblin <tgamblin@baylibre.com> wrote:
> > On 2024-12-30 10:10, Uwe Kleine-König wrote:
> > > Error messages passed to dev_err_probe() are supposed to end in "\n".
> > > Fix accordingly.
> > >
> > > Fixes: b7ffd0fa65e9 ("iio: adc: ad7625: add driver")
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>  
> > Tested-by: Trevor Gamblin <tgamblin@baylibre.com>

Actually Q to everybody: do you know that "supposed" in this commit message is
just a good style as dev_*() are all automatically add newline AFAICS?

P.S. Recently discussed this topic with Linus W. and if I'm not mistaken one
should never see an issue with those messages in the dmesg. OTOH, all other
means that try to save or do anything with messages w/o \n should be aware.

-- 
With Best Regards,
Andy Shevchenko



