Return-Path: <linux-iio+bounces-27602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF94D0EE08
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94E6130065B0
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49413375C5;
	Sun, 11 Jan 2026 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8bVSt4B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E771DFDE;
	Sun, 11 Jan 2026 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768134977; cv=none; b=Jtxijr0RJr0KL5wjSYu/obKysFG1vljMuGzPYRi7qUrssKDYtwps6Sg40JU4NwERQ9x0nIGHwE2NuS/fyRUL5H8pCxK+qnBi/CyESsrsz+42QdRIwlpTG2c9Hx6ZU/9NinMMV+JgQwjWhKnNFN7VuHRR46Pt+oY9SjFr51tQ3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768134977; c=relaxed/simple;
	bh=Duzvya6Z7Ck+DtdMgnSV7xdhdZUVaMHLe/s62Waj1H0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLKan8vfblE3bn15pnnXDQUqtHBKliZjK2jC5UCh/Y0629AMDw2+p8LWKQr8YtLJvkv24KkqQO3W4RaD471gPLFDlCK8L4NekDaC4q1t6sGxqifQnsYkXbV0U1d6j/hgx7GdZQ0wjuk5LUa0vRj9QJCd4/n3a7PhuNW8G4VtZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8bVSt4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DF0C4CEF7;
	Sun, 11 Jan 2026 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768134977;
	bh=Duzvya6Z7Ck+DtdMgnSV7xdhdZUVaMHLe/s62Waj1H0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B8bVSt4BbPxllswunaZC3NexjDUVhry9XGgYOipjCPs+lJap5WFCfuJnsDyhj3Nyx
	 ckvq+4lF20i77zgwPVM5Ka3idT247evtH9MlxrCWLFfUlSlyvcJlmcar2Tb4/mpv6X
	 ohIQBNzu/QVHcXUZyrJARZlZiU1QnvEumxAer/krKeq94qANI/z+LOZAx0aUuiZEjW
	 o0hGjaj1+ZGvArHI6xiRrC5HDj5xTVsqOuNsJM7eD3a/2YmmwhZ+3rSf/yzy6u0Kkv
	 qiY0xJZP6Yu4ptcNJ3aVZP6ixa4MLJj/DsnmwLhZ4s3HqAdga3jVVRfQ/Rhv/bIOcU
	 XZ49NPeaeCdtg==
Date: Sun, 11 Jan 2026 12:36:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Shrikant <raskar.shree97@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: proximity: rfd77402: Add interrupt handling
 support
Message-ID: <20260111123606.559b8428@jic23-huawei>
In-Reply-To: <aV101TrC5hB_nHJM@smile.fi.intel.com>
References: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
	<20260101-b4-rfd77402_irq-v4-4-42cd54359e9f@gmail.com>
	<aVe7SP914oI-jAam@smile.fi.intel.com>
	<CAHc1_P4dCdt6QFgfZ8OUZGT+UfLqiP_ect7pOsd_HeQaDe8jTg@mail.gmail.com>
	<aV101TrC5hB_nHJM@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 22:47:17 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jan 06, 2026 at 05:39:29AM +0530, Shrikant wrote:
> 
> ...
> 
> > > >  #include <linux/module.h>
> > > >  #include <linux/i2c.h>
> > > >  #include <linux/delay.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/completion.h>
> > > >  #include <linux/iopoll.h>  
> > >
> > > Same comment as per previous patch. Do not add even more misordering, please.  
> > Will it be okay if I re-order the includes as below ?
> > #include <linux/completion.h>
> > #include <linux/delay.h>
> > #include <linux/i2c.h>
> > #include <linux/interrupt.h>
> > #include <linux/iopoll.h>
> > #include <linux/module.h>  
> 
> Just try to squeeze the new inclusions in the longest chain of the sorted ones
> (yes, some original ones may be left untouched and hence unordered).
> 
Or a separate cleanup precursor patch woudl be fine.

> > #include <linux/iio/iio.h>  
> 
> ...
> 
> > > > +/**
> > > > + * struct rfd77402_data - device-specific data for the RFD77402 sensor
> > > > + * @client: I2C client handle
> > > > + * @lock: mutex to serialize sensor reads
> > > > + * @completion: completion used for interrupt-driven measurements
> > > > + * @irq_en: indicates whether interrupt mode is enabled
> > > > + */
> > > >  struct rfd77402_data {
> > > >       struct i2c_client *client;
> > > > -     /* Serialize reads from the sensor */
> > > >       struct mutex lock;
> > > > +     struct completion completion;
> > > > +     bool irq_en;
> > > >  };  
> > >
> > > The kernel-doc conversion can be a separate patch, but I'm not insisting.  
> > I can split this into a separate patch within the same series.
> > Please let me know if you would prefer it to be handled differently.  
> 
> It's up to maintainers.
I'd prefer it split.

Thanks,

Jonathan

> 


