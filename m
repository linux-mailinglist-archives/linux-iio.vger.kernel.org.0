Return-Path: <linux-iio+bounces-11333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAF29B17AE
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00BE1C21603
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A31D47BD;
	Sat, 26 Oct 2024 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPlT+o1f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA321D47AC;
	Sat, 26 Oct 2024 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943925; cv=none; b=t6XfYPy0FV175cPP7XmkNKz1t7iXI30L4AYpIEYzRDgpybZsZ+RiebfJjUzV15t0J3Uur/hf0PsT4P88XC4MY2H6GOG3dt7YRk3rOYg2/X4LcKqnJFg1KBIdZnLeZWrRiqxkpmM6ip5z1sbuseG+SvYK+saQgu/eVs08lNQ2s7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943925; c=relaxed/simple;
	bh=MOiYzwTEwSA4p8Bc44UsWegiODiMDMLUcKod2tq5B/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtByqigP6ib/54Gzj0nLLOZLWemdyX+cNuk3JBOTqNENsVQ8Jau0BpzRpeIT4zEJjwKMwnX8xNvSJ/lU011zGB9B3F+XszuQp+AvV0VcfFP+Dov2WVdtpSMt3AVQget2L8wJS8eBvd8hu0Hxg1GDwwi474cndhIBDfZ/NLcqpSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPlT+o1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BBBC4CEC7;
	Sat, 26 Oct 2024 11:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729943924;
	bh=MOiYzwTEwSA4p8Bc44UsWegiODiMDMLUcKod2tq5B/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YPlT+o1f2Kx0bjZCMrlYmyWUTGiQRPz1pAD+2dMeqFGx0G15eq5h/jtL+D7RIYFmq
	 B8CkiEZp7ChrxpMgOUsokmUbfsUdntNdrwQfFDP2/cqi6bTbX1IkYHOMurhEB02rC5
	 39HGLieuic57q2xFI5s09BV4HJy1i6i5LcFe4fk/5mNMuh0KQonccSYwWzfxCZiVHl
	 j0+Vsc2fh7KxeaN11miEPB3naMhct5ieFvn9vqSJZP4ZuLO+KZF5O1o9OnPpEgj9Fv
	 UkypjdhB3Fltxng9ckBQ/ibu7ibWsTSA4I/RYydAM1N02lXFwZi/tCoi50ZNAeSKXi
	 Ds7aWldborbBQ==
Date: Sat, 26 Oct 2024 12:58:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 24/24] iio: light: ltr501: Replace a variant of
 iio_get_acpi_device_name_and_data()
Message-ID: <20241026125814.60660253@jic23-huawei>
In-Reply-To: <20241024191200.229894-25-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-25-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:13 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> IIO core (ACPI part) provides a generic helper that may be used in
> the driver. Replace a variant of iio_get_acpi_device_name_and_data().
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

So I ended up picking up all 24, with just white space tweaks.

Thanks for you hard work cleaning this stuff up.

Jonathan

