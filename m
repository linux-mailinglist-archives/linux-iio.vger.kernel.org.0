Return-Path: <linux-iio+bounces-16231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805DEA4B124
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 12:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973C21887A82
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A607E1DA61B;
	Sun,  2 Mar 2025 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxIIqLI7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2C51B6CFE;
	Sun,  2 Mar 2025 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740914353; cv=none; b=XTnflrFbFwejQgOrdvb8EXWrhj9Spg1vj7q8yKso6MEJRhN0h0FPFG3ebi+w1w2Pd7yc5XqnwMS8VPw8G+fp5gV4Jsd+5Ok+YiXA5JJ4bcM3tDbes/u4dWYEtifg4Ifk7HUkX1c2oimK7uRnAtMaikzxCzJ0/+7HnoIkZXxZLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740914353; c=relaxed/simple;
	bh=okwEJknzjBqTWmKmouXxJRjOFKgbK+rfZCDQcMOh4gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9/FWI+tTm+vAsnLKHeC/LobizUq84I5cxOnTGPzxfXoVO5aqrz6rzIWNvSIGwIz8CuNFleIutCQWgTEiailQeoo2SJ6tpTbsU7Fbume+D8IDZy6VFmLWVL+6yvL5zAWch31FeRjkCsI2F2lZwz8q5jlv62w9EG460x+SDirgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxIIqLI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45260C4CED6;
	Sun,  2 Mar 2025 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740914352;
	bh=okwEJknzjBqTWmKmouXxJRjOFKgbK+rfZCDQcMOh4gQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MxIIqLI7GDWFQUR4bV8ybkpZ2N1U9CnjncXFTG76sVT3SXRDC3jwZ2bPSZw6KaN1w
	 RKIVOLfhiQgDzCChpwh8Lo0ELVpMJeSnpIylzSk4asFqfiwY2JIvf4SUMN6manXc9I
	 qGVDScIR5geVS4NUlmeUDr/9uNEBgnt8Oy9NDOD9P9mQAWXTV3xCD+Ilq2hvbydMp7
	 QgX0zWlrAkaqGLDYtcL/io2LEYcF9l90eTeZI7fJdhRgrh8ACe3AdKkl5zahsIymTa
	 u4zRRydYkLiSXnIH7xe3z+lE2m4eiOXCdNC7yeqUHBusZvhAcPLLc88GDY4iR8BAJU
	 PcP2AWrfYnumA==
Date: Sun, 2 Mar 2025 11:18:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 corbet@lwn.net, dlechner@baylibre.com
Subject: Re: [PATCH v4 1/1] Documentation: iio: Add ADC documentation
Message-ID: <20250302111858.343dd4d2@jic23-huawei>
In-Reply-To: <Z7n-s5yOD7D9t1Oi@debian-BULLSEYE-live-builder-AMD64>
References: <e6ac2a595f06ba2d5ff0eb86e5895479c9dd797f.1739998491.git.marcelo.schmitt@analog.com>
	<Z7bn3TEC4faXbzEj@archie.me>
	<Z7n-s5yOD7D9t1Oi@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Feb 2025 13:43:31 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 02/20, Bagas Sanjaya wrote:
> > On Wed, Feb 19, 2025 at 06:00:56PM -0300, Marcelo Schmitt wrote:  
> > > +For a **single-ended bipolar** channel, the analog voltage input can go from
> > > +-VREF to +VREF (where -VREF is the voltage reference that has the lower
> > > +electrical potential while +VREF is the reference with the higher one). Some ADC
> > > +chips derive the lower reference from +VREF, others get it from a separate  
> >                                                   "... obtain it ..."  
> Ack. Maybe, if there are no additional suggestions to the docs, Jonathan can
> tweak this while applying the patch? Otherwise I'll change accordingly on v5.
That one is marginal.  Formal vs less formal language with slightly different
emphasis.  I think either works here.
> 
> > > +input. Often, +VREF and -VREF are symmetric but they don't need to be so. When
> > > +-VREF is lower than system ground, these inputs are also called single-ended
> > > +true bipolar. Also, while there is a relevant difference between bipolar and
> > > +true bipolar from the electrical perspective, IIO makes no explicit distinction
> > > +between them.
> > > +
> > > <snipped>...
> > > +In the ADC driver, ``differential = 1`` is set into ``struct iio_chan_spec`` for
> > > +the channel. Even though, there are three general input types, ``differential``
> > > +is only used to distinguish between differential and not differential (either  
> >                                                    "... non-differential ..."  
> Ack. Same as the other suggestion.

I agree with this change - tweaked and patch applied.

Thanks,

Jonathan

> 
> > > +single-ended or pseudo-differential) input types. See
> > > +``include/linux/iio/iio.h`` for more information.  
> > 
> > Thanks.
> > 
> > -- 
> > An old man doll... just what I always wanted! - Clara  
> 
> 
> Thanks,
> 
> Marcelo


