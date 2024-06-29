Return-Path: <linux-iio+bounces-7041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B960791CDF4
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 17:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C09282CD5
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D60A84FAD;
	Sat, 29 Jun 2024 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkT1Ce5i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F04812FB0A;
	Sat, 29 Jun 2024 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675536; cv=none; b=UuuNORPQQvrJkBy48/DRK06g9ZtHUQXVNFKjwfMEXFoit/Pq3jNH/FS2w8KasFM/Ab6P9trBv0Do4Z8UIMgyKgokKGfoa+yep6h0E+18F+wogtsvDjz6zAtN0UgN2cUJLQEOSiBHIqk8mQt/M84Lc5rKPEaoNqSC1v8KAu/kbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675536; c=relaxed/simple;
	bh=w5KItqDIKE1p3uvX9oUdr2VMhdVrSQkIWAiPqx16K64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbVjvHhMWhzFUz/oWxseeNbtx6nCrRren5CUTl5VT9P7FlnqGDNUkQ6ojEeE4L+X8yjENp+7d3tPHBDSnTg2f0CPkupIgdIwC/Kbfo9IeaNLoXnureK3EMWVOhjgeWh04ogUoxGuWnsMzdnQva54SAh5h1rrDlThzp8q3y5bINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkT1Ce5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBB1C2BBFC;
	Sat, 29 Jun 2024 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719675535;
	bh=w5KItqDIKE1p3uvX9oUdr2VMhdVrSQkIWAiPqx16K64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jkT1Ce5iaYIBwSnNqY19yNOtHJ9/Mf+X9G1daByOqFqZHaVnHZ7yzDp0az55yytNQ
	 c58T0Rf6oUqxz1Dcvb3MC17dpTFstkguPhNXH4+X0v48Kxo+0N44DAYyIGD9mVPynt
	 koaySiaeRvjgU7CttiB4fWSWsXgnUuQrpMwo9X8eT+7P3QfTnysO2ZNd9IUp8WAmWJ
	 7lfKwmwZs9l1ZW0wbGFO1WlOCsWSchvDpXLvYgnuXzGIflN4sIyZ7h4SldAMcR7enP
	 eAhE4mIQdaeDoMCazHyK02i0p7jhjd9qSMzEDdElWH5FK4BDfCOOdyPnutn4Ng2FGg
	 D8inQcZqiM75A==
Date: Sat, 29 Jun 2024 16:38:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Guillaume Stols <gstols@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>,
 Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH v2 00/10] iio: adc: ad7606: Improvements
Message-ID: <20240629163845.0a8ed683@jic23-huawei>
In-Reply-To: <20240628-postwar-scaling-cb7d7b1f4f3c@spud>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
	<20240628-trustful-urchin-741943d2e98d@spud>
	<20240628-postwar-scaling-cb7d7b1f4f3c@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 16:55:37 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Jun 28, 2024 at 04:53:50PM +0100, Conor Dooley wrote:
> > On Fri, Jun 28, 2024 at 02:48:18PM +0000, Guillaume Stols wrote:  
> > > This series adds the following improvements over the current AD7606's
> > > driver implementation:
> > > 
> > > - Fix wrong usage of gpio array
> > > - Fix standby that was documented as ACTIVE_LOW but handled in the
> > >   driver as if it was ACTIVE_HIGH
> > > - Improve dt-bindings documentation
> > > - Switch mutex lock to scoped guard
> > > 
> > > Signed-off-by: Guillaume Stols <gstols@baylibre.com>  
> > 
> > You missed Acks from Rob on several patches that he gave yesterday:
> > https://lore.kernel.org/all/171952025424.477297.14698127361119381011.robh@kernel.org/  
> 
> You also seem to be missing acks from me..
> 

I picked up the first 2 with the acks scraped from v1.
There are enough minor changes that I've requested in the other patches
that I'd like a v3 fixing those.  Obviously make sure to gather up appropriate
acks.  You may want to wait a few days first though as there are a couple
of DT patches in here that need tags.

Jonathan

