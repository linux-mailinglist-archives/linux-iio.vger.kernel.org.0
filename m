Return-Path: <linux-iio+bounces-21380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F16DAFA433
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 11:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C612C3B808C
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 09:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE061FCFF1;
	Sun,  6 Jul 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxBv+itc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1453595C;
	Sun,  6 Jul 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751795881; cv=none; b=mL04beGQ0HMt3zARY9FDZE6IzuzgcvQvR2gSgsX94wcO67AhYeKCGPz6TCYQfFvEVEBAugsRWClXdP+aB/uDYO81Qkz5QxNnUELsdHt9ptbZhsz0OYGEaNtZ1CbirMpydFKtucnNnN/fWVYi16k61OkpVEGe1uL0y6bpoNLQ194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751795881; c=relaxed/simple;
	bh=85c004UtJafh8FGUILtXn17LOQmN/GTnvTeHAjTdZoo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktbNY9ngAly9Myv8oFaRKQKJDO8ZTiwgujtw9IFfMvPK4RUCrW7GcErR6nVL+b6/ePy3cquAKSSXHNoxt8Qx1Uk73YcFi4quHxx5xOjvuGyXJLaZ9FdLEYJV8OGd6a29JHMbaoouoCuJWp6jAXRmbwnn1DpzlLhpnfIq//RpnVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxBv+itc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0CFC4CEED;
	Sun,  6 Jul 2025 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751795881;
	bh=85c004UtJafh8FGUILtXn17LOQmN/GTnvTeHAjTdZoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hxBv+itcZXme1aiVCOFAekSlJqbuQvaq92ckHHQVkLS6ms/6zRLsNNnZJboCiIIYw
	 DlB8kY8LygEJ0IdnIjeqHBbGo3lOqiCncC1NYjTubPq2LVnc46soRCoottwdvWNkhe
	 Gdt0Aj1QeYF7HmDY7ds5TpfiGJAGDt/0L5ep4IApFi7aOZ2X6XDpPCyeUXvNOo8Zjt
	 jQtod5jz0k4UM3CpuZ9H2NItH/3rHQ5B4N+00MAA1BRM75RfWziBiMenC5rRnjZx2t
	 BHKQo4bCTna+eToR2OIWftNEhycOEORgcYvPQFQ/qDflbDx+jVqVXhWQ7c7IwglTTa
	 liwbedbfjhjLQ==
Date: Sun, 6 Jul 2025 10:57:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>,
 jean-baptiste.maneyrol@tdk.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Replace scnprintf with
 sysfs_emit
Message-ID: <20250706105754.1bf09585@jic23-huawei>
In-Reply-To: <aGQ0re136jUaPN-o@smile.fi.intel.com>
References: <20250701154720.54276-1-chelsyratnawat2001@gmail.com>
	<aGQ0re136jUaPN-o@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Jul 2025 22:19:09 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Jul 01, 2025 at 08:47:20AM -0700, Chelsy Ratnawat wrote:
> > Documentation/filesystems/sysfs.rst mentions that show() should only
> > use sysfs_emit() or sysfs_emit_at() when formating the value to be
> > returned to user space. So replace scnprintf() with sysfs_emit().  
> 
> ...
> 
> > -		return scnprintf(buf, PAGE_SIZE,
> > -			"%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
> > +		return sysfs_emit(buf, "%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
> >  			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);  
> 
> Ideally second line should be reindented, but I won't be bothered by that
> right now.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the togreg branch of iio.git.  I'll initially push that out
as testing to get some early build testing from 0-day.

Thanks,

Jonathan

> 


