Return-Path: <linux-iio+bounces-20464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76B3AD5C5F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 18:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E30A3AAC9A
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD2C202981;
	Wed, 11 Jun 2025 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9CJ9dpp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7FC1F91C8;
	Wed, 11 Jun 2025 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659683; cv=none; b=syd2T5U2bd6j3nu4nh0+wizyqyFIKIgoNdfsinc8zHq2sqlajakuwJ65/iPduTzcyjOLREnrIzpdr66chBvzgKDYbWpQFPIYEAE20eOfeAFgtgvmKN8MswPiCtfmZDHNdL1jLyq+lLuSCjHPdMN73fbiDeRddFtD7GLXcZMX4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659683; c=relaxed/simple;
	bh=WBdEf0/HZqkhDmCcxbwgGvvd9cOJk0qwHZjEEgt/ZCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6rxOsopTyLo+k/hdKExEVlPKdphk6XfaF1tBGOAPFs3hRcwrJ/pB5dvKQHahoelxamjJz5HPHvPt0lnCxWJ6cQBF7XBRVOjzfmyyrTn2g1A47/IpzfIaGVPnjAwoVi0jmzMchnvod/GZpiXIj1J4zBAX90YPbucsPk25sS6LKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9CJ9dpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8C1C4CEEA;
	Wed, 11 Jun 2025 16:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749659682;
	bh=WBdEf0/HZqkhDmCcxbwgGvvd9cOJk0qwHZjEEgt/ZCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R9CJ9dpp9w5VDPPesK/5/rpC4lTAgov0Lz0m5tWPIwOM1a8pucz2AQJ+RuXpVd+8e
	 eZ6LuqHLGtrCoDUyNmTpcDWZ5ccxi8xLL2VyhxtUaQaxz9ZL95NpwedI9bbEVyBaH3
	 lI/i8QKLVE+L9hwXgUMLBUC589xACUwMBSGRO+c5vZdvnHOg2Pa/GijMw2RgcTYDy+
	 0p8ZFhYrPxPQ6E9FaFC2nnBS5/+Y0G/qGfWs4MmauaK5rrGxb6tSaknwNxLXdUmb1o
	 +xgBPkQci1eGdMYHTMdfX3VQce/ZOi5dvkf2zOu44OuvtgHnnGpw+2Axs5DpJFhsKS
	 eqxai+HX0/7Qg==
Date: Wed, 11 Jun 2025 17:34:33 +0100
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
Subject: Re: [PATCH 2/5] iio: adc: stm32-dfsdm: Fix build warnings about
 export.h
Message-ID: <20250611173433.430c8eb4@jic23-huawei>
In-Reply-To: <7600b151-0487-4cb9-ab6e-3cc9c6012bdf@foss.st.com>
References: <20250610124855.269158-1-antonio.borneo@foss.st.com>
	<20250610124855.269158-3-antonio.borneo@foss.st.com>
	<7600b151-0487-4cb9-ab6e-3cc9c6012bdf@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 15:05:16 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 6/10/25 14:48, Antonio Borneo wrote:
> > After commit a934a57a42f6 ("scripts/misc-check: check missing #include
> > <linux/export.h> when W=1") and commit 7d95680d64ac ("scripts/misc-check:
> > check unnecessary #include <linux/export.h> when W=1") we get the build
> > warnings with W=1:
> > 
> > drivers/iio/adc/stm32-dfsdm-adc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> > drivers/iio/adc/stm32-dfsdm-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> > 
> > Fix them.
> > 
> > Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>  
> 
> Hi Antonio,
> 
> You can add my:
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Applied to the togreg branch of iio.git.

Ta.

> 
> Thanks,
> Fabrice
> > ---
> >  drivers/iio/adc/stm32-dfsdm-adc.c  | 1 +
> >  drivers/iio/adc/stm32-dfsdm-core.c | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> > index f583924eb16bb..c2d21eecafe79 100644
> > --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> > +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> > @@ -8,6 +8,7 @@
> >  
> >  #include <linux/dmaengine.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/export.h>
> >  #include <linux/iio/adc/stm32-dfsdm-adc.h>
> >  #include <linux/iio/backend.h>
> >  #include <linux/iio/buffer.h>
> > diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> > index 041dc9ebc0482..47e2d1338e9e6 100644
> > --- a/drivers/iio/adc/stm32-dfsdm-core.c
> > +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> > @@ -8,6 +8,7 @@
> >  
> >  #include <linux/bitfield.h>
> >  #include <linux/clk.h>
> > +#include <linux/export.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/interrupt.h>  


