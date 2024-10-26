Return-Path: <linux-iio+bounces-11312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65A09B1740
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87931C21241
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AE31D27A6;
	Sat, 26 Oct 2024 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucBECbsV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4542056;
	Sat, 26 Oct 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729940727; cv=none; b=mtrws/mXKmK57SpXmixo7cvGmlOhsTA9Rb72rudGOZLIp6pSDC8ru6XnIsSi2SkY/66JG24SfF+PEXeoqZOOwrqU9JjUwxfUKq+upbK+hEJ68y1biNFxNVUOHlL4LYkW8g6/l02kGM9uXWERVmGGMTtdfM2K8biHko0vzQWkCRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729940727; c=relaxed/simple;
	bh=+HLuQHjz/+cQWkY3quaTgNg6b5ST0nih76e+lPVgFFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmKHTVKVFb0UUlnwmkhxJJmyZdnoBL/gJNJdy3KoaJYjiKGraPJbOlOAJbSsj43gFong+FSWPJSh6L7z0Re+caEuVPJCKqMYlYxhwoaq/2/SNdZrb3O6CIicA8ZaCTm8LpphygsrUE+CccuqbEtMDh/zpj+0j95Rtb/UwOLWEwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucBECbsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F91DC4CEC6;
	Sat, 26 Oct 2024 11:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729940727;
	bh=+HLuQHjz/+cQWkY3quaTgNg6b5ST0nih76e+lPVgFFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ucBECbsVNfYTRqZsUH8WGGjf6t5931AjTw8U/y4fkSy5D170SQkwPjQFjlO3FIuXj
	 N3ogBU4nel4po9IzoRK6x5RtZhVGjqmhM44xU1u7Yni4dINAXGqNfUOPigMg3UmM23
	 h8rB0KpD5DNMGaVVphztKtp9/O1+bQItF6fGFoNy1fwPeCGISur/Y76hD1nBpkvHVS
	 pH2ngeZ0sDK17U1wYBmYwzhWU6JHvWJ1E3ypm+52EnGFtXpe3tEayYPoiEGXRymBh7
	 23Jux6Db4Eb41vykruRrIn4MYkoEiGhx+FIh2jNvwkdX8DUbBpT1uk22laXU8THysJ
	 tEFNiG5PI6+2A==
Date: Sat, 26 Oct 2024 12:04:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 03/24] iio: imu: inv_mpu6050: Replace strange way of
 checking type of enumeration
Message-ID: <20241026120450.4e58ecbb@jic23-huawei>
In-Reply-To: <20241024191200.229894-4-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-4-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:04:52 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> When device is enumerated via ACPI the respective device node is of
> ACPI device type. Use that to check for ACPI enumeration, rather than
> calling for full match which is O(n) vs. O(1) for the regular check.
> 
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

