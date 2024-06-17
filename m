Return-Path: <linux-iio+bounces-6415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4053C90BB4C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 21:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19381F22578
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 19:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E9D187560;
	Mon, 17 Jun 2024 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhCYstuj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFCA11CAB;
	Mon, 17 Jun 2024 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653324; cv=none; b=kRrP0za8oQ+qiZR70Q7wjkE6Wu5g9PqOjmaIsKUufQBgygquFA3oGJOyr+iX7xycZUDFAai4JzgtoSnS4uLhuVhkpVRHzXN5xDk7PEXrDl2esgdFmPnZv7HVMWoldoS0kJSFJcuHLx/C91MqRZXNrZH5ceaoufB1vppXbJG37ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653324; c=relaxed/simple;
	bh=flflYDi4mhe3CZNIZCARjMkhFJCeJvc1dZgvuC7Pj1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqrTXDwkTTJ4WTXf5V1sUockXALUacV2KPJAOv+7VLrGRSDh46XZMv3BzJ4SgJf3RqSwscxJsdymzqnXza7Xdf6kvcaeroldoYWIErvsCtZwO4Wlqzki82AozrMajBtb1pRZFQ9hMmBG+jLMxEgA0mv0Wn0reS/OSG9HHZIpjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhCYstuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F04CC2BD10;
	Mon, 17 Jun 2024 19:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718653323;
	bh=flflYDi4mhe3CZNIZCARjMkhFJCeJvc1dZgvuC7Pj1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qhCYstujFRLjohjiyRebQEPtMDUm8tjeIWAy30zkQ74q8zpr6KR5/fyEj9UXywzr6
	 fCG91kGssxAvp8g9upCE+4d7NABtkaZBHiQjPq3UHaT6r3RMUJ3Fx9il+kPP7LzxJR
	 mdsRNnS2pNQRyU5te/QbLqpvbNR2wScJXmAXvOFICWzB3BaAbPcQtEbQyfBcc2gBoe
	 YEUPTz8B7gQtcErI0kmSZ87kN1oBo/apeLWTfOfWSWQZ3MkB9sY9lax3mendcwMLt5
	 LZJnzGzFd65S3S5qzuT5IyYQR/epPUXD5Z0aEVkSHndobL70p4x0Ye7q+NHcRgqmin
	 Rld0z7ym23/4g==
Date: Mon, 17 Jun 2024 20:41:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Petr Mladek <pmladek@suse.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Jyoti Bhayana
 <jbhayana@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Chris Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andi Shyti
 <andi.shyti@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/4] dev_printk: add new dev_err_probe() helpers
Message-ID: <20240617204153.7e36b157@jic23-huawei>
In-Reply-To: <20240608190748.2577b8a5@jic23-huawei>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
	<20240606-dev-add_dev_errp_probe-v3-1-51bb229edd79@analog.com>
	<20240608190748.2577b8a5@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Jun 2024 19:07:48 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 6 Jun 2024 09:22:37 +0200
> Nuno Sa <nuno.sa@analog.com> wrote:
> 
> > This is similar to dev_err_probe() but for cases where an ERR_PTR() or
> > ERR_CAST() is to be returned simplifying patterns like:
> > 
> > 	dev_err_probe(dev, ret, ...);
> > 	return ERR_PTR(ret)
> > or
> > 	dev_err_probe(dev, PTR_ERR(ptr), ...);
> > 	return ERR_CAST(ptr)
> > 
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>  
> 
> I'm convinced this is worth doing but would like inputs from others
> before I pick this series up.

Andi and Andy,

You both commented on earlier versions.  Do you think this is a good
change set?

I've +CC a few more based on a quick look at the original
dev_err_probe() series. Whilst this isn't adding a bunch of new stuff
around deferred probing (like that series did), maybe some of those
reviewers will give opinions here?

Jonathan



> 
> Jonathan
> 
> > ---
> >  include/linux/dev_printk.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
> > index ae80a303c216..ca32b5bb28eb 100644
> > --- a/include/linux/dev_printk.h
> > +++ b/include/linux/dev_printk.h
> > @@ -277,4 +277,12 @@ do {									\
> >  
> >  __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> >  
> > +/* Simple helper for dev_err_probe() when ERR_PTR() is to be returned. */
> > +#define dev_err_ptr_probe(dev, ___err, fmt, ...) \
> > +	ERR_PTR(dev_err_probe(dev, ___err, fmt, ##__VA_ARGS__))
> > +
> > +/* Simple helper for dev_err_probe() when ERR_CAST() is to be returned. */
> > +#define dev_err_cast_probe(dev, ___err_ptr, fmt, ...) \
> > +	ERR_PTR(dev_err_probe(dev, PTR_ERR(___err_ptr), fmt, ##__VA_ARGS__))
> > +
> >  #endif /* _DEVICE_PRINTK_H_ */
> >   
> 
> 


