Return-Path: <linux-iio+bounces-11056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7BC9ADE38
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 09:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4C11C21ACA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380701AC445;
	Thu, 24 Oct 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufwazgcy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617F198E9B;
	Thu, 24 Oct 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756360; cv=none; b=Jm3S6aKQhAow9dqDyK+tD21XFqYVA3epOaxeEb/lXXuijuK9IOaRIibLBCwmgkU8+bHQR4ZvG+sOH/4DRyp7h/vwmpQkeJIgB8FTMg0FCMcmwpX65YdHW7N7kXO8g4bJxO2vVx2urNWQuEbMWfDth7y1BkQGILoQPHBtFHWNYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756360; c=relaxed/simple;
	bh=iuAEsgdQuR7QXql0865AuzrLAn3JGMitY8NvxPwXVYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0dksZvwduwRH5QrkriXVn5CspH5uF1RxkS9susbDB0C+ZM5iFyRspoD7VrVlEsDE67Mzblgilb3vrMLlf5i2uWDkVxPe6JI7S9Y3FroMW4498z1J02tzNtjUNgSYm/gzF5FzZJ33jAPYE8qSnIoTn49JHG5JioqNjTrX+7EIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufwazgcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C067C4CEC7;
	Thu, 24 Oct 2024 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729756359;
	bh=iuAEsgdQuR7QXql0865AuzrLAn3JGMitY8NvxPwXVYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ufwazgcyvS3+PqWhNPLE7RWn/6xzkkfrQOC70JQlPDSXAPdWFiJ4cocW+zRM50qL8
	 8N4CYetxsWQ1apYszsX3/QoGsujnm53IfE4nE1V9ywjAsI5kaCijfLZMNPteULgpk3
	 jYQfCwHKkAWbRBTuw6pyXwBkniLjvyHZxZHcnGrlESmBIgjuqTwfWvK8r1/SqDRhwL
	 umZSgNhP84+2toqbWDoF0/odM50d5mqS/22AsuMdILu7Yk3pjfqESARNgaqJQ1sOho
	 /DzqVFgR0h6dqxUQx1ACuT8FaFaLrpLNTk1bhb5pr0Heoij+sdkURE4l3vJdD62Kbg
	 OjxpVCjGBJM7A==
Date: Thu, 24 Oct 2024 08:52:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v1 00/13] iio: Clean up acpi_match_device() use cases
Message-ID: <20241024085231.132a8786@jic23-huawei>
In-Reply-To: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
References: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 18:17:23 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There are current uses of acpi_match_device():
> - as strange way of checking if the device was enumerated via ACPI
> - as a way to get IIO device name as ACPI device instance name

Quick note on this one. That's an ABI bug that we are stuck with because
we missed it in review a long time back and names aren't critical enough
to justify forcing a fix through.

I don't have a particular problem with a function to wrap that up,
but thought I'd just make it clear in this thread that no new
driver should ever do this!

Jonathan


> - as above with accompanying driver data
> 
> Deduplicate its use by providing two new helper functions in IIO ACPI
> library and update the rest accordingly.
> 
> This also includes a rework of previously sent ltr501 patch.
> 
> Andy Shevchenko (13):
>   iio: magnetometer: bmc150: Drop dead code from the driver
>   iio: adc: pac1934: Replace strange way of checking type of enumeration
>   iio: imu: inv_mpu6050: Replace strange way of checking type of
>     enumeration
>   iio: acpi: Improve iio_read_acpi_mount_matrix()
>   iio: acpi: Add iio_get_acpi_device_name_and_data() helper function
>   iio: accel: mma9551: Replace custom implementation of
>     iio_get_acpi_device_name()
>   iio: accel: mma9553: Replace custom implementation of
>     iio_get_acpi_device_name()
>   iio: gyro: bmg160: Replace custom implementation of
>     iio_get_acpi_device_name()
>   iio: light: isl29018: Replace a variant of
>     iio_get_acpi_device_name_and_data()
>   iio: light: isl29018: drop ACPI_PTR() and CONFIG_ACPI guards
>   iio: light: ltr501: Drop most likely fake ACPI IDs
>   iio: light: ltr501: Add LTER0303 to the supported devices
>   iio: light: ltr501: Replace a variant of
>     iio_get_acpi_device_name_and_data()
> 
>  drivers/iio/accel/mma9551.c                | 19 ++-------
>  drivers/iio/accel/mma9553.c                | 19 ++-------
>  drivers/iio/adc/pac1934.c                  |  2 +-
>  drivers/iio/gyro/bmg160_core.c             | 15 --------
>  drivers/iio/gyro/bmg160_i2c.c              |  4 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c |  5 +--
>  drivers/iio/industrialio-acpi.c            | 45 ++++++++++++++++++++--
>  drivers/iio/light/isl29018.c               | 38 ++++++------------
>  drivers/iio/light/ltr501.c                 | 29 +++++---------
>  drivers/iio/magnetometer/bmc150_magn.c     | 15 --------
>  include/linux/iio/iio.h                    | 10 +++++
>  11 files changed, 86 insertions(+), 115 deletions(-)
> 


