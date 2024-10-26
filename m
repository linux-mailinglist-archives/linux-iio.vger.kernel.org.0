Return-Path: <linux-iio+bounces-11324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5F09B1783
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A37B21FEA
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A12B1D3654;
	Sat, 26 Oct 2024 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLn1bAsZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1EF38DD3;
	Sat, 26 Oct 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729942770; cv=none; b=geYVGUN3UVK3Yzqo7INwYtP30RvmRpondggKws16+SnqSSIKzH1CPsqf1ktGd6oSgNWVTNUzFiC5y/Y1fquNFeL5S8+3WtDv6Gtfv7X7bLDcrmiLp7S+A1naIGK0H2LxepihjCHW9VcspoaxoipnSPHxSTiboA/uJCDJIY+uhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729942770; c=relaxed/simple;
	bh=M3A0wSpFkEf/FBW1Zq3UqCRbQrh6AUlcRxAmrVfZHOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUK2G7ien9NmH+2aH6y4S23CqtjV93i7UM3vJ7m+BT/FOhMvu4daMKehi5oMi8IIPaPmGC/Yw4EGNxzqH8IzbGBzEQWGg8sx/muiYtsPpywdP2zDJIashDzzmpY1ZZ+m2+ZOrv6HpELidfrgZxXMp2jbOlRAAM5SN/1jF3oiRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLn1bAsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DEEC4CEC6;
	Sat, 26 Oct 2024 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729942769;
	bh=M3A0wSpFkEf/FBW1Zq3UqCRbQrh6AUlcRxAmrVfZHOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vLn1bAsZGDfJUcPoYGhMYAfyRbe+FocnWlI/WRXXjkES5RCAjEe7TqVMkoH5sOJ9E
	 kVjEoaC9Wx8tghai3Y0kdAl/7GBkeI091yPN3FxjQBCpcIsWhPk6lHyateEulIEiUG
	 lFFmpZIVBrZ9yYB45AU+IpRnwtHHuvpLw6Ot7K9lmYGypKXjg66C6sZqiqtv/gh4Y0
	 es2eDQeo1XNM0jjLede+IrmVd6rAkbGubUuwE6kN29A6zGt24qrupVOSnmkMxypb0y
	 eFp/Oz4qfLUS5iK5WoAerUZl+a8IAX8bWfPEVM1F0jyGcLjcXcH4HB0idxHrdwKnhd
	 lpDl/QMnxewGA==
Date: Sat, 26 Oct 2024 12:38:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 15/24] iio: accel: kxcjk-1013: Replace a variant of
 iio_get_acpi_device_name_and_data()
Message-ID: <20241026123838.408163d3@jic23-huawei>
In-Reply-To: <20241024191200.229894-16-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-16-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:04 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> IIO core (ACPI part) provides a generic helper that may be used in
> the driver. Replace a variant of iio_get_acpi_device_name_and_data().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

