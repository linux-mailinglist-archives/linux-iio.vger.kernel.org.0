Return-Path: <linux-iio+bounces-20466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D5EAD5C72
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 18:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7073A72A2
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CDA20468C;
	Wed, 11 Jun 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr9Tkr4C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16027199FB2;
	Wed, 11 Jun 2025 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659783; cv=none; b=tE0EFgBISUcVDm0MU3sFXqDY4IHOFSrqEhfQx68zFeC/AE/4HlJ0yeTTFbF1suRpFYka6j4+Pe0x5CYJLbte4o3FpS0BrMwK6rnhlWsMpm9Y+l4fK8lxZegC8bCaEhSOVPNAJ7zl4ad0T56mwPdxf22TXlja7m+Vb8dPfgDaDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659783; c=relaxed/simple;
	bh=sclz4982E4WzBN3+77UXueLPKjZaQ8E9dIo5KXXJhDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVZkq38ch0WWZfIgwP219u98OJFEOITnK6KoWk4QO/3PeeKVM37AZ1HeUtUZpimUZW7W6v84rKIHgtJp29H3I79E5J7fhA6dG27mjQXRYC/830OynUQ6pUv5P60RRUyXexTclHbIkc4S2/snJ3/ukkc8bg3K1fz1L7P4gd0evTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr9Tkr4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B13C4CEE3;
	Wed, 11 Jun 2025 16:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749659782;
	bh=sclz4982E4WzBN3+77UXueLPKjZaQ8E9dIo5KXXJhDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gr9Tkr4C3a+q0tp1tV/MbnrtfnQ54lTT+lFIVz+Um9u/CfxGTiBksQGPeaBSNpcuL
	 QHf0m6u+Qkq1y3uabTQOAYtq50kt77CYoQI6606AjD2jLqXpQvuQ+tk91sH2VX1CQt
	 ZOmg2O4qjTc3U7fYpeqcwn2hSBZlXknZbFI/goyKaXuYMuxAggboykF7fVxYjeJcEU
	 WqAtS2FEyKpRHvME+bIzdi5fQBPft3FHAPo6yrSlzutch9g582P1FA7SKuUupHK9pH
	 4n4oFIQaYt0dmEW1yQWah7Lse9ooe1Iyax/nnJBQ4nFIwiM76SLS9nBJr/M+rofH64
	 Daez8pQNQSlgw==
Date: Wed, 11 Jun 2025 17:36:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andy Shevchenko <andy@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, "Lee Jones" <lee@kernel.org>,
 <linux-iio@vger.kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH 3/5] iio: trigger: stm32-timer: Fix build warnings about
 export.h
Message-ID: <20250611173613.492b7fc5@jic23-huawei>
In-Reply-To: <f8b1adef-10f3-4cff-9e11-10c1a16f6ec5@foss.st.com>
References: <20250610124855.269158-1-antonio.borneo@foss.st.com>
	<20250610124855.269158-4-antonio.borneo@foss.st.com>
	<f8b1adef-10f3-4cff-9e11-10c1a16f6ec5@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 15:05:36 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 6/10/25 14:48, Antonio Borneo wrote:
> > After commit a934a57a42f6 ("scripts/misc-check: check missing #include
> > <linux/export.h> when W=1") and commit 7d95680d64ac ("scripts/misc-check:
> > check unnecessary #include <linux/export.h> when W=1") we get the build
> > warning with W=1:
> > 
> > drivers/iio/trigger/stm32-timer-trigger.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> > 
> > Fix it.
> > 
> > Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>  
> 
> Hi Antonio,
> 
> You can add my:
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
as I have some other stuff queued today that needs 0-day to look at it.

Thanks,

J
> 
> Thanks,
> Fabrice
> 
> > ---
> >  drivers/iio/trigger/stm32-timer-trigger.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> > index 925b864facca1..3b9a3a6cbb25c 100644
> > --- a/drivers/iio/trigger/stm32-timer-trigger.c
> > +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> > @@ -6,6 +6,7 @@
> >   *
> >   */
> >  
> > +#include <linux/export.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/iio/timer/stm32-timer-trigger.h>  


