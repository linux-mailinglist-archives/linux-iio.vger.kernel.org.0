Return-Path: <linux-iio+bounces-4984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F37F8C3662
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 14:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704C21C208FB
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D35E208BC;
	Sun, 12 May 2024 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUEj2HC5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2E0210FB;
	Sun, 12 May 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715515997; cv=none; b=dSM+E21SI1GIh6Y3ifIT0oc58cV299eSLW2JfWBOiv7xnJ8KPxMXWghwps2chxzFcxpWfGOCJTFy1dX3ujiEjxt9u4b3yXlsZwbvM5Ki5opx+CUExrIFitYBlaLRTtKHH1HWk213qz/dHcQMSAT9G/LlaMAbcbhbVKGwohA0mZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715515997; c=relaxed/simple;
	bh=9ecrq6ewkCPgWwI2dBv/kDtPnydKl5OIf4t6YTMMTPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVff1PS2uNZamgz+EvhwOzt3hiY+SuIPYsvN8VXWKseleD+hSBuo0437+DTEd5+IySO1N6ClKNH51R8wovNw7J7iJffbxt6v+gw6uATaKQ8oJdofU66O5Y5AoKtdJ/vprTxEuoI8NWRHj7R9NZczLXk0QDdEC2MO+xqHl7esRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUEj2HC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C22CC116B1;
	Sun, 12 May 2024 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715515997;
	bh=9ecrq6ewkCPgWwI2dBv/kDtPnydKl5OIf4t6YTMMTPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fUEj2HC5irRdGCzhWGUvrZg3OEGI1RPbWs71u6DaREfu4RQV5BA8Mya5rwOg+spVy
	 eGOccclJR+/DKa7PMLyh4qo8wqNI9M9JCegaBowmpsNjolGElBd5k3xvyXQ4ps7jHl
	 4s8SRh88R8xU9ruKsEjrOd3vcBWdcJfLkByoTFehaXp2KGZMu+N60ARUdKrv9tNZ0L
	 emTgh5t7fA+qrIrqY3zYmzAqSAqWKzQA5zO4FQmF0OoDdH8Pfn8gVN/E0gOQeOl/34
	 qh+sE7eSeQmDfbjoDvUv/MYQg/EwlDGGxfo8aIACAi0WFp5xUHu59MbVxbLOib5OdM
	 eAeqjiPcroipw==
Date: Sun, 12 May 2024 13:13:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/9] iio: pressure: bmp280: Use unsigned data types
 for raw sensor data
Message-ID: <20240512131304.687de3b1@jic23-huawei>
In-Reply-To: <20240508165207.145554-5-vassilisamir@gmail.com>
References: <20240508165207.145554-1-vassilisamir@gmail.com>
	<20240508165207.145554-5-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 18:52:02 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The raw sensor data that have not been compensated yet cannot be
> signed values, so use unsigned ones. Also, compensated pressure
> values cannot be negative so use unsigned also there.
> 
> Also, drop redundant cast of data->t_fine variable from s32 to s32.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Looks good to me.

Applied.


