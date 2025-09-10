Return-Path: <linux-iio+bounces-23942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF9DB51D86
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADB37AE385
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00131337694;
	Wed, 10 Sep 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZWC4Ri0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB67327A20
	for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521406; cv=none; b=rMPlT0LZcUMa7m2G52JPnNlMbicrn4xh3lkc/KmhK8/82Q2JMSwjJMMbxGE338BYO9qf2K54JvXJCy4t4t1ZhF4cADzkwzHzk0+R8HwTIUZEgCyVw4X0kBBOUQMN7mKuh7tOa306N7RTaq73O5T1sEDjOmad1uc5XAfUL+zLr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521406; c=relaxed/simple;
	bh=uuBE++pJE4DNOrnB0oW9D4U1ShZQV1dKQgNjGdNZZe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8spTCkdOrJ+Hvjx+oi33GrcMwA7m61sdNTX0Nu8VEclvkVH563U3gLrEpkoz3gxnGlSoYxYOeOj4DBhj2B9SvktfXzO7vIMpsKFJwuJob4QIRlCFbJDp5iyqFAwPbdkfmXA78VANkKOnkfMfPRTXDZsOgqbFqHbOJIZBtjMZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZWC4Ri0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C867DC4CEEB;
	Wed, 10 Sep 2025 16:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757521406;
	bh=uuBE++pJE4DNOrnB0oW9D4U1ShZQV1dKQgNjGdNZZe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aZWC4Ri0b/RwyBciAlIEEmXa8gI4oZ+kVGeBU4bstYcwBz8jExy/Ehmq54tRKJzsy
	 vg+0daO55Zm1K8YjHsvMcaGwd63mJ4vel9cPDEPo9gAkxZOFMJMgwNzb8872JocR89
	 /nWjXGCoGi+DUmKN9hGfAdYUjT+hixfaxCOqDKJOWwCTx5JLom62ij9m8kgBVT2bdE
	 tOdYSdo5ZYdPkqXHfSizxYrsXNh9E9HrmVrj2kv777bvyFZXP3omeNuHMV1csxQ1gY
	 C84QdGKM/9WKAFsvaU8kUTocxLDbHtrB//DQ46XPOvPT4irHvD0CSf+T8ZVAHJGer4
	 k9sQCTeAiAbVg==
Date: Wed, 10 Sep 2025 17:23:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: tzungbi@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] Documentation: iio: Remove location attribute
Message-ID: <20250910172318.1138918a@jic23-huawei>
In-Reply-To: <20250903190102.1647098-1-gwendal@chromium.org>
References: <20250903190102.1647098-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Sep 2025 12:01:02 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> The cros-ec specific |location| attribute has been superseded by the
> generic |label| attribute.
> 
> Fixes: 7cbb6681d7e5 ("iio: common: cros_ec_sensors: Add label attribute")
whilst the reference perhaps has some value, I don't think 'excess'
documentation counts as a fix.   Given I don't want the potential noise
of this being backported to stable I've dropped the fixes tag.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-cros-ec | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> index adf24c40126f0..9e39262437979 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> @@ -7,16 +7,6 @@ Description:
>                  corresponding calibration offsets can be read from `*_calibbias`
>                  entries.
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/location
> -Date:		July 2015
> -KernelVersion:	4.7
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		This attribute returns a string with the physical location where
> -                the motion sensor is placed. For example, in a laptop a motion
> -                sensor can be located on the base or on the lid. Current valid
> -		values are 'base' and 'lid'.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/id
>  Date:		September 2017
>  KernelVersion:	4.14


