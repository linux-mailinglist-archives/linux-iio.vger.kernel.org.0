Return-Path: <linux-iio+bounces-21401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1594EAFA650
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 18:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7475A17A868
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 16:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6379428640B;
	Sun,  6 Jul 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMxejibh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B815D1;
	Sun,  6 Jul 2025 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751818165; cv=none; b=fzgsB8pVqGHTLBmXlh16UoW72T76+Hq0YEulyuHONn5P2wG68mDe3ZxIVVcA4wh1Lsn/hwAvHS4qpbMbZg5a99fkax58Wh++wOndHVbrD93xSSqKYYHKYXYAnwktmUhBIttFkAjEx2JDYZYEsysOWIKvJgrkHUZVDJ8lqZpIB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751818165; c=relaxed/simple;
	bh=qV/OJ8LdTuJrlP2M38dxUDyFbscgaTZzX3iUlnI8xr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJbzk5lPO1X3DQLUbSNsMFIcZBWph3h4H8N64xqU+FU7nl0ILNi2xLOdaiSr66qIIemLUIgzka9P7HmTLHegqtHIe65jI3e7GdKGj58UpXFt8c0VbA9dM/tuVMBpFZWwf9obUW5OA1oDJk5wldcy9eCujl6G12HjZkwIFJXBRcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMxejibh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915F5C4CEED;
	Sun,  6 Jul 2025 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751818164;
	bh=qV/OJ8LdTuJrlP2M38dxUDyFbscgaTZzX3iUlnI8xr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hMxejibhIaYp0UIEQpBGnjqrjlMAF+hfphmFJrvCzWNCSP81wCt4zwe6VjZfNWDDi
	 V5HZenPDYxnYN4to5yYvfE5wPZwysDvwvsTr43ao7O4qwPAPPslasIXaoRDz/VNZhg
	 CNpzfequO2hH9vZe23SQsyUf4Ejabw3cPMWLerRu05ntmkgggUQMCWQscc0cLCirCj
	 ec7za4itRHwH2jOhZwhdglmtKuIfm5RFISUx4E2fbjAUq//XBQ+r89EbsOrRKveJ8a
	 2XXeA5SjLSflK1brKoWTaJl43r1qFwtq4u3t5kC63WBtuHEpNl2oVbJfp8lMhX92wj
	 do++5dAuRepgA==
Date: Sun, 6 Jul 2025 17:09:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v11 3/8] iio: accel: adxl345: add activity event feature
Message-ID: <20250706170916.17417514@jic23-huawei>
In-Reply-To: <aGaSkQHQKCqfrVXF@smile.fi.intel.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
	<20250702230315.19297-4-l.rubusch@gmail.com>
	<aGaSkQHQKCqfrVXF@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 17:24:17 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 02, 2025 at 11:03:10PM +0000, Lothar Rubusch wrote:
> > Enable the sensor to detect activity and trigger interrupts accordingly.
> > Activity events are determined based on a threshold, which is initialized
> > to a sensible default during probe. This default value is adopted from the
> > legacy ADXL345 input driver to maintain consistent behavior.
> > 
> > The combination of activity detection, ODR configuration, and range
> > settings lays the groundwork for the activity/inactivity hysteresis
> > mechanism, which will be implemented in a subsequent patch. As such,
> > portions of this patch prepare switch-case structures to support those
> > upcoming changes.  
> 
> >  #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
> >  #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
> >  #define ADXL345_REG_TAP_SUPPRESS	BIT(3)
> > +#define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
> >  
> >  #define ADXL345_TAP_Z_EN		BIT(0)
> >  #define ADXL345_TAP_Y_EN		BIT(1)
> >  #define ADXL345_TAP_X_EN		BIT(2)
> >  
> > +#define ADXL345_ACT_Z_EN		BIT(4)
> > +#define ADXL345_ACT_Y_EN		BIT(5)
> > +#define ADXL345_ACT_X_EN		BIT(6)
> > +#define ADXL345_ACT_XYZ_EN		(ADXL345_ACT_Z_EN | ADXL345_ACT_Y_EN | ADXL345_ACT_X_EN)  
> 
> I'm trying to understand the logic behind the placement of the masks and bits.
> To me it sounds that the above should be rather
> 
> #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
> #define ADXL345_TAP_Z_EN		BIT(0)
> #define ADXL345_TAP_Y_EN		BIT(1)
> #define ADXL345_TAP_X_EN		BIT(2)
> #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3) // Do we need this at all?
> #define ADXL345_REG_TAP_SUPPRESS	BIT(3) // or actually this? One is enough, no?
> #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
> #define ADXL345_ACT_Z_EN		BIT(4)
> #define ADXL345_ACT_Y_EN		BIT(5)
> #define ADXL345_ACT_X_EN		BIT(6)
> #define ADXL345_ACT_XYZ_EN		(ADXL345_ACT_Z_EN | ADXL345_ACT_Y_EN | ADXL345_ACT_X_EN)
> 
> (Yes, I know that the mess is preexisted, but try to keep some order in the
>  pieces you add here.)

FWIW I fully agree on keeping field definitions and field break up together.

The ACT_MSK is a little odd as thing as then we'd expect there to be bits
within that. So that FIELD_GET(a, ADXL345_REG_ACT_AXIS_MSK) would return
a value from a list of things like
ADXL345_REG_ACT_AXIS_VALUE_A and similar.

So I'd not define that as a mask a tall but just use the
ACT_XYZ_EN for it as then it's clear you are checking for any of the
3 bits being set.

Jonathan


> 
> ...
> 
> > +		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
> > +			BIT(IIO_EV_INFO_VALUE),  
> 
> I would expect one of the below (indentation) styles
> 
> 		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
> 				       BIT(IIO_EV_INFO_VALUE),
> 
> 		.mask_shared_by_type =
> 			BIT(IIO_EV_INFO_ENABLE) |
> 			BIT(IIO_EV_INFO_VALUE),
> 
> ...
> 
> >  static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
> > -			      enum iio_modifier tap_dir)
> > +			      enum iio_modifier tap_dir,
> > +			      enum iio_modifier act_dir)  
> 
> Hmm... Why not
> 
> static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
> 			      enum iio_modifier act_dir,
> 			      enum iio_modifier tap_dir)
> 
> ?
> 


