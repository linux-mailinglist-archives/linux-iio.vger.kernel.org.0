Return-Path: <linux-iio+bounces-11327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3E89B1792
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20211F22DE5
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED5A1D27A6;
	Sat, 26 Oct 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElilVkNF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A629217F47;
	Sat, 26 Oct 2024 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943303; cv=none; b=E8+sO3paUzR442lA19BD3RXp/tScPHoGgHiFI+iK/FHVHXPdv9Hd+jyFM/oolhIISWXECvNzs60Bu/+7Sx06q+0XAt0/j/pViV/Y5J2dXwhnj0NUSlno9m62BA6CxpLDZVIOoEYIqF3s+pWZOzHQSTzvYuGqW2kfvt8LM4GT4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943303; c=relaxed/simple;
	bh=UaE/zKS0aTWkP/Q13bWOY2hdJNy5HdxKKXhG/Xh5XI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9t0MzyiwEBy0n4qy/L4sQOl6gzw+NUE2eoriO1YL33k/xkSOQ7sd/17PoTX6WCZIdpudi2jDpcR9eSMQiZ0mmOtwrWzNFbWXwMXxnhd/S7CP8l4ikf5VKf1rfzPzARTFeA6g7YAo+RLUY4pEZY6vbkKmMBV0vS7b7+OH0c08vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElilVkNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A93C4CEC6;
	Sat, 26 Oct 2024 11:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729943302;
	bh=UaE/zKS0aTWkP/Q13bWOY2hdJNy5HdxKKXhG/Xh5XI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ElilVkNFXjSyeQmbx3ubZvrf6y3JzxKsz2upkRJC7mRnKYwGtBNf0rJLcqU1uURmM
	 H2+zpPGbQHAX+SYwyfccG48OzF2mHI0xr5Xs66MzWctaXD8MoZ7Hmw887OM/Pi2Uw4
	 XH5UwpQuNFYGKDHG61gMVq01g4zPxJR9vhaT7ah4BkzxwhKtJb32NPDidzToyfHawd
	 VZjQPbSeeBSilqwN2kTWfAre8jBezGwW16o2p+MEAdoD6w2NghyYvdhQtVKRs8Eeh1
	 XFqpyDkRS5qVoGmtKUtW8dnxR9a/DN2OWqiBon2bvi30ZVxqircjvXQEcvJAt1LEs0
	 LKD3W0UmtM0vg==
Date: Sat, 26 Oct 2024 12:47:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 18/24] iio: accel: mma9553: Replace custom
 implementation of iio_get_acpi_device_name()
Message-ID: <20241026124746.3814758a@jic23-huawei>
In-Reply-To: <20241024191200.229894-19-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-19-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:07 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> IIO core (ACPI part) provides a generic helper that may be used in
> the driver. Replace custom implementation of iio_get_acpi_device_name().
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

