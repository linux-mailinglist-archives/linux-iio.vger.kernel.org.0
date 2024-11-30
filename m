Return-Path: <linux-iio+bounces-12892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3DC9DF2FD
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D78162CE2
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36C71AAE05;
	Sat, 30 Nov 2024 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THQQsrqH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F96C1AA78A;
	Sat, 30 Nov 2024 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732998539; cv=none; b=OhA3yvLtuISjCQiB4b/ddVqZIfG9AKZGPw/U87mFbmz5ICJDvA2Ue5nxt/aPSpOnHueFPoZDqSMYbv8ScUF2r0nKDX1GqIAlibkWCALafKl8Y2r7ybT2qquV/D17+BYG4iZYVeZ3kfMlok/HCkwa0o/LMhGDwVclzrv1E3arJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732998539; c=relaxed/simple;
	bh=SiY2Nq9QzSin2vjmXSMhAfeksH3aD0224fqxI9VqMSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCKe+198PnoxHUwVh0xoUb7jdfYZ7ifX/kltylCipcbPW7ipHaEQLdjYfuDUwUDSYDm+yuBzzYEL8hMHur8jY34SfYvaxKr8nKbAW4ZfShc6PnUVzesWTqJKa+Ji9QchAOPrb78vi3Mg9l5dn4E3U4UVdTGJiKxyulKbQJHhLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THQQsrqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56089C4CECC;
	Sat, 30 Nov 2024 20:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732998538;
	bh=SiY2Nq9QzSin2vjmXSMhAfeksH3aD0224fqxI9VqMSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=THQQsrqHLVL9bpqOb8h8nwY8dHsGur7AbcDZs3PJeFsc7ru2U4qfyFDktqvoXjGry
	 Q8lNLqjiuV4aPq1uOx3A4QCxkueW7tBFkCXF1sgDqEddC1Zl9EmXXUAgwAGaaNO1bS
	 qKan3lrqVwjoPfroskLWVASQNHSlU12VJjWoVg8fVmeoFhWTdDAWH3c6pypnFak+up
	 pMiveP0yeP33GOzEWZrDlPqOuy28+9FaNlOrbo9tfSQcLQ8gjJGoU0h4djJCOslKbH
	 XjhwGHiHQ5KChLWd6+88r7s2LPl2ybNFTAERShqtAhMH9fscgi9Mq0ymttTeismz5N
	 0KYlOYrrQMYCg==
Date: Sat, 30 Nov 2024 20:28:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, cmo@melexis.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 0/2] Add Nuvoton NCT7718W IIO driver
Message-ID: <20241130202849.13eedb04@jic23-huawei>
In-Reply-To: <20241126074005.546447-1-tmyu0@nuvoton.com>
References: <20241126074005.546447-1-tmyu0@nuvoton.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 15:40:03 +0800
Ming Yu <a0282524688@gmail.com> wrote:

> NCT7718W is an I2C based thermal sensor chip from Nuvoton.
Hi Ming Yu,

+CC Jean and Guenter,

Why an IIO driver rather than a HWMON one?  Superficially this looks like a hwmon
chip.  We do have the means to put a generic driver in IIO and bridge to hwmon, but
when a device is very much intended for monitoring of hardware temperatures etc
the IIO driver rarely has any purpose and a simpler hwmon only solution makes sense.

For temperature sensors IIO normally makes sense if:
1) They are part of a series of devices some of which have more functionality than temp
2) Fast devices where hwmon sysfs interfaces become a bottleneck - note you have to have
a usecase for reading them fast, not simply a device that is capable of it.
3) 'Unusual' temperature sensors such as infrared thermometers or very high precision
   thermocouple interfaces.

Any of those apply here?

Note that hwmon has better threshold and critical temperature handling than we can do
in IIO and it seems your part has those as well.

Thanks,

Jonathan


> 
> Ming Yu (2):
>   dt-bindings: iio: temperature: Add support for NCT7718W
>   iio: temperature: Add Nuvoton NCT7718W support
> 
>  .../iio/temperature/nuvoton,nct7718.yaml      |  44 ++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/temperature/Kconfig               |  10 +
>  drivers/iio/temperature/Makefile              |   1 +
>  drivers/iio/temperature/nct7718.c             | 505 ++++++++++++++++++
>  5 files changed, 567 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/nuvoton,nct7718.yaml
>  create mode 100644 drivers/iio/temperature/nct7718.c
> 


