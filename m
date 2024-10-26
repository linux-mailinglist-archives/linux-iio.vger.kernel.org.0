Return-Path: <linux-iio+bounces-11325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 039BE9B1784
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94592834E0
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3CC1D4141;
	Sat, 26 Oct 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv05mK12"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987238DD3;
	Sat, 26 Oct 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729942916; cv=none; b=LDDFKpK1RhWo093Sb7CHnmrV7wtDYvITDxsEslxkaHdlA2wjbDxJa9e0bMCAAnYgKDTIjQDR82RfuJRSH8WQbIPuKuvuKQQx7BTvFNuCCwGkQxPUSjjvKLJWWz0l9oda1309i3W7BYO+8XKLcqiqluNf/dXC4OeW0J4evUuiYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729942916; c=relaxed/simple;
	bh=VbInSfL2T64TaFzvaLojZNlhCf5Mf0t+TxXGPb3Mth8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pxm90KJgluxtHUy10DGxmrGeUGRPSmmp01iBOhXceTgEtSzUYn6vR3Tgh7h1odK/0rax19c+Y4g+NyTFp1LP1RF2rPTRHDbKYHrlvHCCewsRUgWCjzjo52ZkW3HwaGO/XvMl8QToEgkISMjJXL5HoJpzmjPUw8spvdBb5BnAWQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv05mK12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E4FC4CEC6;
	Sat, 26 Oct 2024 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729942915;
	bh=VbInSfL2T64TaFzvaLojZNlhCf5Mf0t+TxXGPb3Mth8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gv05mK12ZSb5jucejfgbcOJvGaINSXGhgnCb72H7i4SiGaod/cyATFO8tG056XiN2
	 PJZePwozCa0/jEFXgPjohHXL+T3fH7UON6qxKE1X4h7PCnEpgXA3AtueQ2c32ZRoLS
	 MmEsoBv0e+zGmRoyiuJmXBTdj+WAczEg8ux+Rul08XY5yGXy8CUX7GS62jNRAmvlLf
	 jLkQftPBEdgFoVsFNEaUVrkPIPqgxSj+JO2/zVMXWwvDu8puCSFJVEGClNj1mHpW8F
	 BAsQQ1I+V6kuUTHBx54Yc9OjXATCFASBuiOcwaEGgazloYNCsEOe5Ypm899p9vMCcU
	 amdS/GSLxn4CQ==
Date: Sat, 26 Oct 2024 12:41:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 16/24] iio: accel: kxcjk-1013: drop ACPI_PTR() and
 move ID out of CONFIG_ACPI guards
Message-ID: <20241026124118.266c52db@jic23-huawei>
In-Reply-To: <20241024191200.229894-17-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-17-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:05 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The complexity of config guards needed for ACPI_PTR() is not worthwhile
> for the small amount of saved data. This example was doing it correctly
> but I am proposing dropping this so as to reduce chance of cut and paste
> where it is done wrong. Also added linux/mod_devicetable.h for
> struct acpi_device_id definition.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Ah. so my white space messing around earlier made this slightly harder to apply.
I carried forward the spaces after {

Applied,

Thanks,

Jonathan

