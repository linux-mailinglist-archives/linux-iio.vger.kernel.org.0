Return-Path: <linux-iio+bounces-2608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C5857BCB
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 12:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913341C21F4C
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE47690B;
	Fri, 16 Feb 2024 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR+IUJae"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593B17C6D
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083358; cv=none; b=iqV2tKO9d3RrmsaMX+FpTWpfvlae5PlorZ9VAseXqM2w6JXygayboL+b+ZwoKjRXG7EaaJQM5AbD5PRcBxrQQiZeb77vI/BNI3m3vMV0G692TDujpaqMC0kqoHd2cwshf8Ex3S3u+SJT/PA9282us5tvPUSOtOslTktxyLIFED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083358; c=relaxed/simple;
	bh=a833L4yDnR7xE57Tr6uCX9DL0USFtAl7CsyeeW6RbDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P48b7U5Ps/LF1CAwr1iGY9MvS/6MaxpSkiItm9Qi8e5rAxpjivKYggAU5xsfWM/Hlbt1zEmjjFo0+0F5+Ns3ntxQxvJqLNR9ReyYv6Lqho3/hU9sZ7G/R7TWQr3KK5FTidhzVBckAng+btT12D01Mkvbs1Ft7ij3Y4bkn7oT/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR+IUJae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF915C433C7;
	Fri, 16 Feb 2024 11:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708083357;
	bh=a833L4yDnR7xE57Tr6uCX9DL0USFtAl7CsyeeW6RbDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bR+IUJae7yuWw7iS5pwoEOSgtpOSo9Mz3ctASvmaxj7oNfIY2JlkQRk/CxSWZe/a3
	 DNproyv8bUuSwg9/uZ0N4QiCdQhIlLZSacnY7Qz1iZQwWtmsltgj/vV3il0G4F7QjS
	 +CxA6WLVnBfqOKaTZuCrEfvwQU12sGuy8v9NRSEu5zAM9btgradySDT3NfshBosvBX
	 4VwXsTa4RfPMKQvrFxL8iPaTn4MSC5VyAJz4yDIrMmEj+vu4w0I04bCLgDDf1J53yL
	 yCAfV/gvePf9/taqQaHphVWDOGjL4ZcT0G9FSyfWANmhm8X09/aqV4VvjAfkve8uQw
	 Dsh1p3h0XSFrA==
Date: Fri, 16 Feb 2024 11:35:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: J Lo <jlobue10@gmail.com>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Hans De Goede <hdegoede@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, jagath jogj <jagathjog1996@gmail.com>,
 Luke Jones <luke@ljones.dev>, Denis Benato <benato.denis96@gmail.com>,
 Antheas Kapenekakis <lkml@antheas.dev>, Derek John Clark
 <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v5 0/2] Add bmi323 support for ASUS ROG ALLY
Message-ID: <20240216113545.33b46e19@jic23-huawei>
In-Reply-To: <CAF6rpDwtj-mtpfFntf8XtTnF2vQMw4rtg1eV-kFGYj6r9hWvKA@mail.gmail.com>
References: <CAF6rpDwtj-mtpfFntf8XtTnF2vQMw4rtg1eV-kFGYj6r9hWvKA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 10:19:52 -0800
J Lo <jlobue10@gmail.com> wrote:

> From: Jonathan LoBue <jlobue10@gmail.com>

Hi Jonathan

Cover letter should always include at least a short overview of what
the patch is doing.

Long term this solution may be a pain to maintain.
The reasoning is the DT path where we have moved over time to allow
for fallback compatibles (same concept exists in ACPI even if it is
little used) to be used even if we don't recognise a ID read from
the chip.  The intent being to allow old kernels to work with new
devices where they really are backwards compatible.

If that gets fixed in these drivers, we will have to explicitly
exclude ACPI IDs.

Hopefully we'll pick up such issues in review though so this should be fine.

I'd like input from Hans though on whether this solution of duplicating
the IDs generally works out longer term and is appropriate here.

Jonathan


> 
> Changes since v4:
> - Fixed comment location in bmc150.
> - Fixed signed off by portion.
> 
> Jonathan LoBue (2):
>   iio: accel: bmc150: Duplicate ACPI entries
>   iio: imu: bmi323: Add and enable ACPI Match Table
> 
>  drivers/iio/accel/bmc150-accel-i2c.c | 13 +++++++++++++
>  drivers/iio/imu/bmi323/bmi323_i2c.c  | 20 ++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> --
> 2.43.0


