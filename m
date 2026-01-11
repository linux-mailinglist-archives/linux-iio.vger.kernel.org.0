Return-Path: <linux-iio+bounces-27597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47045D0ED1A
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6FC03008E93
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E983382CB;
	Sun, 11 Jan 2026 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zud7RUFG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85D3396F7;
	Sun, 11 Jan 2026 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133627; cv=none; b=tkFrWvRsCInDAIIq3Eq2MbNeUakCFeDV/vReLJlEu0R97YqS+87gETeFdwti1amYA8hJlzP0pdAc5SsBOWN/UJ7uEly2XWxI2lBzTLyQFK0ETlpIkUS2RSkTgcwL9X6ZigkkXwun84MpJVvksBtHn+nTv5oJjaMWsN1YjkDeYT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133627; c=relaxed/simple;
	bh=Q4vyqCjeaIy/bxa6BSzjTBX5MwJls04a5aPpDNApAZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLAjaFnEgFt/tKwGg37R2iEVTpV13i7v7wLa2HbrckjGuHHrhk5zjPgkcaAGDiuXZP0vgxOM90twzHoMurNyJolsVVIu4eE/UWJm3N2Ilhcz0Zf51Xa7Q8BbuNkOA4q0H403MQHjlxl2774+U8+c5VCZcnOqokperjT5oBuDMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zud7RUFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41924C19422;
	Sun, 11 Jan 2026 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768133627;
	bh=Q4vyqCjeaIy/bxa6BSzjTBX5MwJls04a5aPpDNApAZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zud7RUFGxpEBsHrxmv4MlDJT4oju4I9DpotSSqNuUVwnB3kEyTLEHqLuHlXjH6PnV
	 /c9eKA5+0dIm4TCkHCg+rFScz9zE60kzEBTS880zqW16xBBSeuNOKf1B+NVehBPOU9
	 +Ii+jbegCjIaUAj9dIEfjkSPz4YsnDUzZHiXsvvRxRYCf431NZdZsGFIKK8dCFqGYU
	 dVm6lflTQpoTEpK69nxq6VZmYZB2MA0kHE+AG6K3i82o3LzHiPb6QPIOp3HZqUl+Z4
	 2pR+WwSSX93lDb6mp1Z9ByRZPF90QKeCg4+jXM0IHLkyvjpPe3GWi7PkWk0qjmzbCR
	 2FmxqxvFeJ3cQ==
Date: Sun, 11 Jan 2026 12:13:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/6] staging: iio: ad9832: remove dds.h dependency
Message-ID: <20260111121337.24f4eae5@jic23-huawei>
In-Reply-To: <7s5n34ucflr5jvn7xpotj7qnp5msf45t37ziydh2g4eej4j6ai@irs5mrlpwcyr>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
	<20251230203459.28935-5-tomasborquez13@gmail.com>
	<20251231180939.422e9e62@jic23-huawei>
	<20251231181153.556f14fe@jic23-huawei>
	<7s5n34ucflr5jvn7xpotj7qnp5msf45t37ziydh2g4eej4j6ai@irs5mrlpwcyr>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 Jan 2026 02:38:50 -0300
Tomas Borquez <tomasborquez13@gmail.com> wrote:

> On Wed, Dec 31, 2025 at 06:11:53PM +0000, Jonathan Cameron wrote:
> > On Wed, 31 Dec 2025 18:09:39 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Tue, 30 Dec 2025 17:34:57 -0300
> > > Tomas Borquez <tomasborquez13@gmail.com> wrote:
> > >   
> > > > Remove dependency on dds.h by converting custom macros to standard IIO
> > > > attribute declarations.
> > > > 
> > > > Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>    
> > > Hi Tomas,
> > > 
> > > Happy new year (almost)  
> Hey Jonathan,
> 
> Happy new year!
> 
> ...
> 
> > > I'm not that keen on having the documentation only several patches later. Drag that
> > > before this patch or combine adding the new ABI and documentation in the same patch  
> > Ah. I'd missed that this is deliberately a no change patch with old abi.
> > 
> > So ignore the stuff that doesn't make sense with that in mind!  
> 
> Just to make sure I understood:
> - I should just remove out_altvoltage0_frequency_scale
> - And add documentation in the same patch with all the ABI changes
>   "staging: iio: ad9832: convert to iio channels and ext_info attrs"
>   or as a separate patch like it is now?

It's fine as you have it already.  Ultimately out_altvotage0_frequency_scale
should go away but that can come in the ABI update patch.

I'd just misunderstood that this was simply a 'get rid of dds.h' usage
patch and the real ABI changes are later.

Jonathan

> 


