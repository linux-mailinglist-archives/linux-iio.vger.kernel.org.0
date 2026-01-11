Return-Path: <linux-iio+bounces-27607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D14D0EF15
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 14:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 660A83003B17
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4030B3396F4;
	Sun, 11 Jan 2026 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhaiENLz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C712F49F1;
	Sun, 11 Jan 2026 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768136453; cv=none; b=gwBMKYdssjcnqIgte4vqvJY+OXIZ6foYvedFrb8imWzaZhJcCgTQFM9pC5TllwXLkgSspFeluCecqlE6DEOON7jF07L5Ob+hsEUSdHuHxfuJAZgqqT/Qax1szT+r500/FF6feT+PI2GiVmypczXynGsYl9VGUxj7BIu7igshRIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768136453; c=relaxed/simple;
	bh=bsUMYq9zK4TB4Uecl1CADcEXMgPAE/Ix0Zn7gXJKdpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIz9QGGao9RdHAqbLO6qaRk+mpaTlz3fLArcprLJ1wkFaTwXrHKMVJ8Gg3OX6FszUTpyCgVZ36CejF/bwoJjnuKpZ53FtqEDUqG5m+vLEO6kcnHYL3s9RyGTd23HL2xHaagImSFM+bhqAREGW2lAH19679RpoqlQn/eI+UibkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhaiENLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F175C4CEF7;
	Sun, 11 Jan 2026 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768136452;
	bh=bsUMYq9zK4TB4Uecl1CADcEXMgPAE/Ix0Zn7gXJKdpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DhaiENLzUgMqSrkd0D/st0S/P53xwct6j7PoUfNbzICiU3aF1uT2al7F9vNuJMOEM
	 Iyr9DDDhpsGgvUTNurEs9axA1JZAlDO67zxXe+xyCn19rxvJCMOWSXLyKz6WTi+W42
	 nlbVNRilUyA3lNyupJNjyeE2StTIbWIg7P94D0nMV2HbA4TsY3n6J0vuPUQkomC+/z
	 SJjS8pmCF2Z79pbM1vovd+L8U98I10L0GN5VRmODdc0VEkpQJ8XzC/bON2X9Qcq1h5
	 Sup2x6JL7wlOnuLubxtDZpIUZJkLmk2Ek95rcpJ5FtTxP4G4wrQ71PgcTuPJISqui7
	 LPJi3HhSavrrg==
Date: Sun, 11 Jan 2026 13:00:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Harris <michaelharriscode@gmail.com>,
 gregkh@linuxfoundation.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: adt7316: modernize power management
Message-ID: <20260111130042.10e321c9@jic23-huawei>
In-Reply-To: <aV14wL35muj55kMF@smile.fi.intel.com>
References: <20260106145055.2557551-1-michaelharriscode@gmail.com>
	<aV14wL35muj55kMF@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 23:04:00 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jan 06, 2026 at 06:50:55AM -0800, Michael Harris wrote:
> > Replaced use of deprecated function SIMPLE_DEV_PM_OPS() with
> > EXPORT_GPL_SIMPLE_DEV_PM_OPS().
> > 
> > Removed PM preprocessor conditions with usage of pm_sleep_ptr().  
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Applied to the togreg branch of iio.git and pushed out as testing.

thanks,

Jonathan

> 


