Return-Path: <linux-iio+bounces-9821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C58BF988FCB
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81290281D7C
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539B417C8B;
	Sat, 28 Sep 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR+NbwEL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA1A101E2;
	Sat, 28 Sep 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727535641; cv=none; b=u7rBGcbGtJ94Vg6BJpUhPeCX4WT+RzP6ZvsJ2O/HaWHz5Z8USe38IYXHIqosUYi0v4EtgWg4z21csJL5OSvoT1TfLhCsbg4sIKw2Qj0c1TmTi4h0qalI2ee5Vmpa+gbklhAco7XZD8cMAbvLOVOem1pZi+BUWxHPWC8Qt0ms0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727535641; c=relaxed/simple;
	bh=W5DRZ84lYNw5fKdfYqvY9tGzDb4B/HiLZlDLH24rXfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYNOc8Ewd+pYDO3Vmqomto0inUtZNTIq4FcPhAw3qEYvJaBhXSP3VE6n7kfGiN/0lOysGZHU+O5OWMWrZxbA5EhrRaRVZ2RSGs3Pw2Zke/F42TXpi4UzB2rJtNrsGEakyH2YDK+EcwHleyNT2xis99ODAYWIMISXhd2F8z+Shk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR+NbwEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D2BC4CEC3;
	Sat, 28 Sep 2024 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727535640;
	bh=W5DRZ84lYNw5fKdfYqvY9tGzDb4B/HiLZlDLH24rXfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BR+NbwELUkVCQnIhbug8SXfIkt3fWS9bHuafL5jtuHflIRJcmx4Ee5qmGOuIGvcdc
	 XdGMzRATx1QTVhjJ7k1xGMfV2l2w+HCYBOLxn5PbyMearhMU5mW5f/j7SCeo/e5I5b
	 wqAjEhcmb6Putkq0Ye7AaUflnV+buggxYEvF4gXSTKodTELTRgydvXzkSlcT3E6/pK
	 Xbm1gFpy/2k7C8GS2JpGBKNpEENdklKIzdkplhJwqmG6MTRAMeeThQ0bciRVBNw1Ow
	 zHjR83ux/krO0HExv2MyNDKQDKYVs4M2cV+b/F6eiKluAYfCJcGHzbC3stRmy9ocC0
	 M5DWRMrC+62lg==
Date: Sat, 28 Sep 2024 16:00:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v7 0/4] pressure: bmp280: Minor cleanup and interrupt
 support
Message-ID: <20240928160030.3e5d914b@jic23-huawei>
In-Reply-To: <20240918193724.GA6917@vamoiridPC>
References: <20240914002900.45158-1-vassilisamir@gmail.com>
	<20240914153617.3f816e5a@jic23-huawei>
	<20240918193724.GA6917@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Sep 2024 21:37:24 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sat, Sep 14, 2024 at 03:36:17PM +0100, Jonathan Cameron wrote:
> > On Sat, 14 Sep 2024 02:28:56 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com
> > >   
> > This looks fine, but given outstanding comments on that patch I can't
> > take it quite yet.
> > 
> > Jonathan  
> 
> Hi Jonathan,
> 
> Thanks for the review. I will fix the other patch and poke you again on
> this one, you don't have to keep a note. In case, I could rebase this
> patch-series, without the depended patch since they are not related
> functionally in order for you to be able to pick up this series while
> we still review the depended patch. Let me know how you feel.

If you think that dependency will go in soon Id' not bother with a rebase
of this one.  We have plenty of time this cycle after all!

Jonathan

> 
> Cheers,
> Vasilis
> 
> >   
> > > Changes in v7:
> > > 
> > > [PATCH 1/4]:
> > > 	- Use 5ms instead of 5000us in comment
> > > 	- Use USEC_PER_MSEC
> > > 	- Move parenthesis to make checkpatch.pl --strict happy
> > > 
> > > [PATCH 2/4]:
> > > 	- Remove interrupt description since enforcement was added.
> > > 
> > > Added also review tags for patches 1,3 and ack tag for patch 2.
> > > 
> > > ---
> > > v6: https://lore.kernel.org/linux-iio/20240912233234.45519-1-vassilisamir@gmail.com
> > > v5: https://lore.kernel.org/linux-iio/20240902184222.24874-1-vassilisamir@gmail.com
> > > v4: https://lore.kernel.org/linux-iio/20240828205128.92145-1-vassilisamir@gmail.com
> > > v3: https://lore.kernel.org/linux-iio/20240823181714.64545-1-vassilisamir@gmail.com
> > > v2: https://lore.kernel.org/linux-iio/20240725231039.614536-1-vassilisamir@gmail.com
> > > v1: https://lore.kernel.org/linux-iio/20240711211558.106327-1-vassilisamir@gmail.com
> > > 
> > > Vasileios Amoiridis (4):
> > >   iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
> > >   dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and
> > >     BMP5xx devices
> > >   iio: pressure: bmp280: Add data ready trigger support
> > >   iio: pressure: bmp280: Move bmp085 interrupt to new configuration
> > > 
> > >  .../bindings/iio/pressure/bmp085.yaml         |  22 +-
> > >  drivers/iio/pressure/bmp280-core.c            | 580 ++++++++++++++++--
> > >  drivers/iio/pressure/bmp280-i2c.c             |   4 +-
> > >  drivers/iio/pressure/bmp280-spi.c             |   4 +-
> > >  drivers/iio/pressure/bmp280.h                 |  43 ++
> > >  5 files changed, 612 insertions(+), 41 deletions(-)
> > > 
> > > 
> > > base-commit: fec496684388685647652ab4213454fbabdab099
> > > prerequisite-patch-id: e4f81f31f4fbb2aa872c0c74ed4511893eee0c9a  
> >   


