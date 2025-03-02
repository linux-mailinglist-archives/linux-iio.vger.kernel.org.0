Return-Path: <linux-iio+bounces-16237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D946AA4B169
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 13:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58836188F94B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523441E1C09;
	Sun,  2 Mar 2025 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcPRjs03"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE381D7E35;
	Sun,  2 Mar 2025 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740917424; cv=none; b=I1vki+LExNoYWjqrVCWQs9yPs91Zq6rXBgHaBKzwg3Jny1GnX0WCIZuWFTEbKheC8gLf3QkNtWlfDzlsT982bnwpVmczR8MTvQxMdJDu4UguhSoVWSw3eGaCJhVFWvhhhoXGgn9k3MTg93jxTP4zaTX85mza1Ao/0jpiN+62nn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740917424; c=relaxed/simple;
	bh=NqkKPwOotaxSVDY087pDD3/wAOA19WW3XbYhp4Usg+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2m0W8oLLLZ8ycko0qLR8Xz/CB7zyowOx4It0oQs8Kx4l3V2C78r2kV8eX64oF3sLM3svzdODW8JiK2EwKjm06KhIaj9dNGWWs6CvxjfNMLbOT+JG0/7Vgf3VOUvhQeW2U+k5M0BYv7u0vx5bLWAK7vmJchhimCjQ0FTRBFKm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcPRjs03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447E1C4CED6;
	Sun,  2 Mar 2025 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740917423;
	bh=NqkKPwOotaxSVDY087pDD3/wAOA19WW3XbYhp4Usg+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qcPRjs03EXkwAqczsSCXpYbwP/WmclNohmndLm5uYWzF3H6iO6igUeY6qKdGTayJL
	 8h2OT9R323MBgPyveYxcOx8G5aDPxorfeRiwfBygaVYaxZSaZZ3sSlAP54oJ9iH53M
	 CSQZzenz9/+x6nXQGv14batbstatgSCjdIEdZoJ/D0GzGqpg3r+ggvWwxIKjrKnizg
	 vBCS2YglNfgFJx3Xg9ZKKanaj9s+HPEspMI8HN61NvNn14CyHzQ4Hj6gMBpAHMEwDt
	 1m1nPQtwgcnZh68v5k4xA8k6cH1qI2/tCaMtFhs3TaNL0I5q12sR2a7w9IybXz7VaW
	 cVzttCJgjwYag==
Date: Sun, 2 Mar 2025 12:10:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 04/15] iio: accel: adxl345: use regmap cache for INT
 mapping
Message-ID: <20250302121012.0227a117@jic23-huawei>
In-Reply-To: <20250302114503.26cbcd97@jic23-huawei>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-5-l.rubusch@gmail.com>
	<20250302114503.26cbcd97@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Mar 2025 11:45:03 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 20 Feb 2025 10:42:23 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
> 
> > Use regmap cache to replace maintaining the member variable intio
> > for the interrupt mapping state. The interrupt mapping is initialized
> > when the driver is probed, and it is perfectly cacheable.
> > 
> > The patch will still leave the function set_interrupts(). A follow up
> > patch takes care of it, when cleaning up the INT enable register
> > variable.
> > 
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345.h      |  4 ++
> >  drivers/iio/accel/adxl345_core.c | 63 ++++++++++++++++++++------------
> >  drivers/iio/accel/adxl345_i2c.c  |  2 +
> >  drivers/iio/accel/adxl345_spi.c  |  2 +
> >  4 files changed, 48 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > index bc6d634bd85c..a2a81caa292a 100644
> > --- a/drivers/iio/accel/adxl345.h
> > +++ b/drivers/iio/accel/adxl345.h
> > @@ -8,6 +8,8 @@
> >  #ifndef _ADXL345_H_
> >  #define _ADXL345_H_
> >  
> > +#include <linux/regmap.h>  
> 
> Why add this include?
> 
> The file should have a forwards def of
> struct regmap;
> which is currently missing.  If you clean that up in this patch that
> is fine (mention it in the patch description though as it isn't
> directly related) but I don't see a reason to include regmap.h here.
> 
> Given rest if fine I'll tweak this whilst applying. Applied to the
> togreg branch of iio.git, pushed out for now as testing for 0-day
> to poke at it.
> 
> Also move to a newer kernel tree. The changes in export symbol
> should be causing you build errors for this path. I'll fix that up.
> Quotes now needed around IIO_ADXL345 in the EXPORT_SYMBOL_NS_GPL()
> calls. I fixed that up.
Dropped again after reviewing later patch.  I think the volatile
stuff should specify all registers that are volatile from the start
not add them as we go.
> 
> Jonathan


