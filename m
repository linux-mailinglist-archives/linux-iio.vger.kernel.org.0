Return-Path: <linux-iio+bounces-4572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4618B4BFD
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 15:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9831C20B16
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB656CDD8;
	Sun, 28 Apr 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZAjilNc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE5C3A1DA
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714311032; cv=none; b=R1lHAgaRb35TBLDjILfXEOpoIP8opEluxXcZbpR50NCfhlLu7mx0PoM8reBdQZiMFxU/tpVLF8J0Ca5Mwsh1GddTMevzsdaGLtBCne0bGYcwvWNSkYF3HPQu3IOpxPxbiRyUu4SuEFQ+tUGkYqRI8lvN2TU1V7z4NA39pkB+EkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714311032; c=relaxed/simple;
	bh=FiowQ0rAywpPdXUYPdnKcMpVRab1dgytLfjYkfw3qa4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohNMtHtVF03TmcfS0MVVDDu8kAYOO8e1tBUp6PtNSUsasY2uA9MkrmojPQJmD5IkwQIi6KPqe32Wg/GXhOh9uMGh3QW9Cep701lJFk1ziV9O4fBiyoQUpLuv+lSL0Hs5MydfoIVH57r2UzMrhjg6JgJavwgY5LcdR8LCNOIrZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZAjilNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3221DC113CC;
	Sun, 28 Apr 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714311032;
	bh=FiowQ0rAywpPdXUYPdnKcMpVRab1dgytLfjYkfw3qa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OZAjilNc99DUPAwfG6FzmaRtItBFl0fjafe4/QU9sWPR6KwG5R9iAONe7J2WwJSUO
	 HBcjNFZNSK6CwqjNDOMKwtJtdAjKllyo8/fsKlzQqolww1mb+RHni5TjGlBV/Z+lP7
	 aD4gfHldwmZ01aNOlGQipzPYQtBEhZCM604ShpZJYmc/L/tDYQ0H5+gSAsircALbad
	 w9do7s13Z9lx6tSlJVWYPnBq93ljZS2+ACgKmmSb40o1YvTgOWyP6zsMxo+uREd6Ea
	 tjtqzWSdVLLsxrxc3eIsYGRLsv7NZw0UYawISiiUlpgwq8qXL5k0C2nYbupvqLa9Ah
	 ULHk/w0ZJ84sQ==
Date: Sun, 28 Apr 2024 14:30:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Sean Rhodes
 <sean@starlabs.systems>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: accel: Share ACPI ROTM parsing between
 drivers and add it to mxc4005
Message-ID: <20240428143023.2cf99d75@jic23-huawei>
In-Reply-To: <20240425125754.76010-1-hdegoede@redhat.com>
References: <20240425125754.76010-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 14:57:50 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi All,
> 
> Here is v2 of the patch series to refactor the ACPI ROTM orientation matrix
> handling in kxcjk-1013 + bmc150-accel to share the code instead of having
> 2 copies and then also use the shared implementation in the mxc4005 driver
> since some MXC6655 ACPI firmware nodes also include this.
> 
> Changes in v2:
> - Add comment about the Microsoft specification for the "ROTM" ACPI method
> 
> Changes in v3:
> - Add the new iio_read_acpi_mount_matrix() helper to industrialio.ko instead
>   of making it a static inline
> 
> Regards,
> 
> Hans
LGTM
Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to play with it.

Thanks for tidying this up.

Jonathan
> 
> 
> Hans de Goede (4):
>   iio: core: Add iio_read_acpi_mount_matrix() helper function
>   iio: accel: kxcjk-1013: Use new iio_read_acpi_mount_matrix() helper
>   iio: bmc150-accel-core: Use iio_read_acpi_mount_matrix() helper
>   iio: accel: mxc4005: Read orientation matrix from ACPI ROTM method
> 
>  drivers/iio/Makefile                  |  1 +
>  drivers/iio/accel/bmc150-accel-core.c | 44 +-------------
>  drivers/iio/accel/kxcjk-1013.c        | 80 +------------------------
>  drivers/iio/accel/mxc4005.c           | 22 +++++++
>  drivers/iio/industrialio-acpi.c       | 85 +++++++++++++++++++++++++++
>  include/linux/iio/iio.h               | 13 ++++
>  6 files changed, 124 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/iio/industrialio-acpi.c
> 


