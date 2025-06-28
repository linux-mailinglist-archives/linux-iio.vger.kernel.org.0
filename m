Return-Path: <linux-iio+bounces-21028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 154B2AEC548
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 08:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B24917D999
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 06:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84721D011;
	Sat, 28 Jun 2025 06:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g57ghAgR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09B199E9D;
	Sat, 28 Jun 2025 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751090929; cv=none; b=eHgtjvs7xfjm0h26OfW0tll8cobL5QjczJaWikYqrC9WcWFcBTY4U2d6i78IUuEb0SbzQRdDNEMbpGHl293Bw6XmHtcmK8DvNB2PxH1cb9ZLERuyzBKlm90OE2mBIFz9bw46qOSybNcuRXnylzswZ+gS5mOOSnX5gfIkYNpu4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751090929; c=relaxed/simple;
	bh=FWKzhYGQM7gdwjjfdFj34tQM7NG2yfbSnWb2WAtbmF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeXcQuFZhl4yLxFmyCpNOyHX1tFnXUyIO6stePgowmo9sLothlS7NDS0jYDz1ZU62D8p5M0mz2vwjP62ksThSyvtUI6tucoHyGyC6z1zbhphXaiQUF7sHx8Edj/1+ugKeqUTshYmF8m2826vdudernSX+xBkLs22int0WD+A+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g57ghAgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A61C4CEEA;
	Sat, 28 Jun 2025 06:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751090929;
	bh=FWKzhYGQM7gdwjjfdFj34tQM7NG2yfbSnWb2WAtbmF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g57ghAgRX2EPrbyBT1aB8DNfKOSLox6DnN6/l44bCwaOVrDXusWNAX6uX2qnd9132
	 cDpcac3CngPfZH/EVvUHJtAo5R9kzZhJDtNPzvuFmliJR9WCOG43cM59wN5TJWUVVV
	 qHNmgfmuJYThAWcaB15x8HSUB9phxspMnVvXvNdU=
Date: Sat, 28 Jun 2025 07:08:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Abdalla Al-Dalleh <abdalla.ahmad@sesame.org.jo>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gabriel Shahrouzi <gshahrouzi@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Subject: Re: [PATCH] drivers: staging: iio: frequency: ad9832.h: Fixed TODO
 note.
Message-ID: <2025062815-resolute-cornflake-48c4@gregkh>
References: <20250627175114.548076-1-abdalla.ahmad@sesame.org.jo>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627175114.548076-1-abdalla.ahmad@sesame.org.jo>

On Fri, Jun 27, 2025 at 08:51:14PM +0300, Abdalla Al-Dalleh wrote:
> - drivers/staging/iio/frequency/ad9832.c: Changed .h file location
> - drivers/staging/iio/frequency/ad9832.h: Removed struct definition
> - include/linux/iio/dac/ad9832.h: Added header file according to the
>   TODO note.
> 
> Signed-off-by: Abdalla Al-Dalleh <abdalla.ahmad@sesame.org.jo>
> ---
>  drivers/staging/iio/frequency/ad9832.c |  3 +--
>  drivers/staging/iio/frequency/ad9832.h | 23 ------------------
>  include/linux/iio/dac/ad9832.h         | 33 ++++++++++++++++++++++++++

Staging drivers need to be "self-contained" for now.

Why do you even need a .h file for a single .c file anyway?  Why not
just remove it?

thanks,

greg k-h

