Return-Path: <linux-iio+bounces-21603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DA3B03146
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 15:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A851179929
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47F2233701;
	Sun, 13 Jul 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHn6xIAP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01C54A04;
	Sun, 13 Jul 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752414940; cv=none; b=ConfcKHxRllM2FKtckXL4nyqFSqs/dsFtLdnT0D9XzppBSl7CiVDDbfcUip8YTq5b7VgX73Unu2eZ4rX3MxBlcckB+S7NglsXXgEWf6zzzM5VcgYftWGNSRqbeNaVREJf/mzKwjd1UAwKBmnW8kpm5Be25jV71QzMzCbA5PX0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752414940; c=relaxed/simple;
	bh=7PqKQzU5B2ABLGwVbAb33x47XXzMnaZFtJvibVZPFIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJlNpX0PJE9Mo4/v74GtMIkXV1bveEH2QkQ5RyTjWFPJ8XcvOaORN4TH7M1zWGhS8YX85ko29VpzMahqRK/ztPQAAUCfsgefToYJGsF0sD57IGLx7lL98+GbKJOXVDAYhoDTufFRGytLxnmnTQAcQSTbelyms/linP6nehjC/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHn6xIAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90663C4CEE3;
	Sun, 13 Jul 2025 13:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752414940;
	bh=7PqKQzU5B2ABLGwVbAb33x47XXzMnaZFtJvibVZPFIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SHn6xIAPIiQEbMEaNfK1yUXqIZ3p9jqJsvZ6C/eYYq9YFReR2Wo5/K87y/p4kM+ez
	 Qsy3vriD+fnmFYqOC/J4N3SxyqWHuWZN2gk/mTp4shUPnO0PZtkhuDpkGsz4DyVDbk
	 ous1heOkTHsHIF5DREkVfPNTarwU3smr2VI9q8R7SXNkIxL2jm+kux+EDd8Mdk7E0v
	 dOxzhHWtgIbNxtZhjNZ9ei5r1jg51taP+5GQ5wPCRHoMhmVBn9nE2Y4o868dq3dN7U
	 /yUZYYzbACUw2sfEGqEjdM/LwUsNb4zI5JXqAUt8BoxjF/9CGNccQuXr0G9d6NNZiB
	 YTllkR5bUiLDg==
Date: Sun, 13 Jul 2025 14:55:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9500: use stack allocated buffer for
 scan data
Message-ID: <20250713145533.5a3d4336@jic23-huawei>
In-Reply-To: <aHE-8VDgQ7WuoA_y@smile.fi.intel.com>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-4-v1-1-1a1e521cf747@baylibre.com>
	<aHE-8VDgQ7WuoA_y@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 19:42:25 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Jul 11, 2025 at 10:47:57AM -0500, David Lechner wrote:
> > Use IIO_DECLARE_BUFFER_WITH_TS() to declare a stack allocated buffer
> > in sx9500_trigger_handler(). Since the scan buffer isn't used outside
> > of this function, it doesn't need to be in struct sx9500_data.
> > 
> > By always allocating enough space for the maximum number of channels,
> > we can avoid having to reallocate the buffer each time buffered reads
> > are enabled.  
> 
> Ag ood one!
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Applied.

