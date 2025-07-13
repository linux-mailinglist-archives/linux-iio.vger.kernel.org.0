Return-Path: <linux-iio+bounces-21604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAD0B0314A
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 15:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC93B3AEB57
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 13:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F30525B2E3;
	Sun, 13 Jul 2025 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT12mC8g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B64B1D5CD4;
	Sun, 13 Jul 2025 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752415098; cv=none; b=IFE1czkRIuPP9YihZAzylol8vnVYY5yi4w4D5d+z2FUHQv0+E+G3VMu/PFPmiaCcFZxF6Mpzza8y31iQp0Vq/41/LEeiFPMJsgTnLN3um+RZcduMpPmO+d5IK0vaR25D1tN38bELk7at0yb2EjIMb+dKsOE+THMfeRxooHYZG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752415098; c=relaxed/simple;
	bh=aY4iabyi499gtHPbsJz+gic9lQWRDiPB/ZLamKoKwp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZypgI3m7hIEBp/bVXIKpZhx4nFaQv4RqNuw6lDKlr4L25PsIWUkK23JhMhKXeOR9t8LDLnMZB8PopABreYo5iEwjIo32ihQD2aBUO0AwHZxTdOvTdE6Ppa91/UAKEge2BgsORStTSo//lqvDJcT4VUCcVYA8o2UiNsT0ZdMHUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT12mC8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA91C4CEE3;
	Sun, 13 Jul 2025 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752415096;
	bh=aY4iabyi499gtHPbsJz+gic9lQWRDiPB/ZLamKoKwp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VT12mC8gsXCytJO6buTbHkw2cnKz5WKzmF68WTFyAo2ytVAalkZz8v31Ve0Mpl1kk
	 Eo7iG6g6VDJcGOTKzmq1QqGHBV3lGrpMYz6RZ0GMr8G4fn/hyhLngZuUpBTqcUu64N
	 u0O0/IeS3FTqSs9OEFZpoXkUQJslnTjg6xi11wDu5gEiVSeMwAkNo85YCwcEMn5NeE
	 mpbKHiEYJFR0++7Yvqcm29tJlq4eBoVSytRqzxUKKxlIwMG8Yr/bHL2JFKvJqDaGIP
	 5gUOYfHJ6bV2tYZgtmnCX/v8sOX3shR7MZlEzo3bzWWaSIUdlKiRqIcf6DxzICOkrM
	 xpp+X+KauHxfQ==
Date: Sun, 13 Jul 2025 14:58:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9500: use stack allocated buffer for
 scan data
Message-ID: <20250713145810.31853bc7@jic23-huawei>
In-Reply-To: <20250713145533.5a3d4336@jic23-huawei>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-4-v1-1-1a1e521cf747@baylibre.com>
	<aHE-8VDgQ7WuoA_y@smile.fi.intel.com>
	<20250713145533.5a3d4336@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 14:55:33 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 11 Jul 2025 19:42:25 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Fri, Jul 11, 2025 at 10:47:57AM -0500, David Lechner wrote:  
> > > Use IIO_DECLARE_BUFFER_WITH_TS() to declare a stack allocated buffer
> > > in sx9500_trigger_handler(). Since the scan buffer isn't used outside
> > > of this function, it doesn't need to be in struct sx9500_data.
> > > 
> > > By always allocating enough space for the maximum number of channels,
> > > we can avoid having to reallocate the buffer each time buffered reads
> > > are enabled.    
> > 
> > Ag ood one!
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >   
> 
> Applied.
> 

Actually on second thoughts - why not a more descriptive structure?
There are only a max of 4 channels and so the timestamp is always
in the same location.

Dropped for now.

Jonathan

