Return-Path: <linux-iio+bounces-21488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A71BAFEE0A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 17:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B407481139
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3850E2E7647;
	Wed,  9 Jul 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cwuh3Xe6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB52DA765;
	Wed,  9 Jul 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076183; cv=none; b=DAuW5/jYOThJnwQi5JIXimZBku2C3DDluKJniqK2+96NVcMKh43h/IuK0/4jzBi14lyXMDlY94dZ3OoXIMSEvpS8rjMmkbHm5a8gL19l4cB8uL0I6YtXR9Yhi+8+nuJpXCJQN1sfW7t/9PAuOZAxoSjNiuAMqTl3HAs1sceTS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076183; c=relaxed/simple;
	bh=4eG67VwdY6yryX9Oqb584knMPMQAKXI8QBnDkqUgg/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUtTrm6kmRRlxvfYspfwYsHWgxwU8tybYT+fVpTt0FvdMoHbvTr8AYjFcndWzlz8JYX6d7mX0Y3NsdaF1NNBFZsvttr27y/6ijxp2USE343PrsGPdFRUh7OYLWUzNf1TF0RcCAAYMCwAtD3rYWpypSN+GEsspk26LraUiXpPpW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cwuh3Xe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AF3C4CEEF;
	Wed,  9 Jul 2025 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076182;
	bh=4eG67VwdY6yryX9Oqb584knMPMQAKXI8QBnDkqUgg/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cwuh3Xe61CXjMKNkToIZevUXQzpOfauMU3w1uzfo4otQHWOZURQipbRvGCdThUF2q
	 ye+BL+7tfamDxzHaO7jA7S7avZDaaw7zxWQGdu2Z8nZlAR36pAQvgnpwX2PHuVDkcB
	 RTej8EmaA/9GFzRVcJyLhsAyoDuOX4LVihX1tnt5GDO+qrq/9g3oVfa8sCehLBJ3rM
	 CmHD+UvXKoqROd00XIWOvQBQI0LGobiTS8tdnG/z0v8vPpssCsDOGyQLGffKl/w3Bz
	 RmUVNmpSsAnRnXBKGECv+Z3/pcxdtMzheiG99XWQM6obd4Z5qxcVxhBd+5MTTc0WQx
	 v3451WtbhxAmw==
Date: Wed, 9 Jul 2025 16:49:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Uwe =?UTF-8?B?S2xlaW5l?=
 =?UTF-8?B?LUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/12] iio: dac: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250709164933.47913e22@jic23-huawei>
In-Reply-To: <aG4sxEtXRw982Z9q@smile.fi.intel.com>
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
	<20250708231152.971550-1-sakari.ailus@linux.intel.com>
	<aG4sxEtXRw982Z9q@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 11:48:04 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 09, 2025 at 02:11:52AM +0300, Sakari Ailus wrote:
> > pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> > pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> > to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> > pm_runtime_mark_last_busy().  
> 
> ...
> 
> > -	if (!enable) {
> > -		pm_runtime_mark_last_busy(dev);
> > +	if (!enable)
> >  		pm_runtime_put_autosuspend(dev);
> > -	}
> >  
> >  	return 0;
> >  
> >  err_put_pm:
> > -	if (enable) {
> > -		pm_runtime_mark_last_busy(dev);
> > +	if (enable)
> >  		pm_runtime_put_autosuspend(dev);
> > -	}
> >  
> >  	return ret;  
> 
> 
> Hmm... Why not simply
> 
> 	ret = 0;
It's already zero (as last call was a regmap_update_bits() return value ) so even easier.
However, switch if (ret < 0) to if (ret) for that regmap call
to make that more obvious.

> 
> err_put_pm:
> 	if (enable)
> 		pm_runtime_put_autosuspend(dev);
> 
> 	return ret;
> 
> instead of the duplication?
> 


