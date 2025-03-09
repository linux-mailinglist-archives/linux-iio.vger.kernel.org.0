Return-Path: <linux-iio+bounces-16591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAB6A585CD
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D2F16A749
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B3A1D63EF;
	Sun,  9 Mar 2025 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Osxg9Xnl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70FE1FB3
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741537603; cv=none; b=unGjLqBopJwnEfzdTYRd0Ma5dBajbl8Trs1lsT+BPknu8pKkyhnM4i+FeMZD+ZG3ht9NOg6i85PqckQNJ6T22ZZoAntDq3LFD5cDXYUjHpH72eTFtLSoXDjAu3Tc+2/X5zgixa8bbdViEYU3IgkmIDJGqEcQq5WvLW/39ea6KuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741537603; c=relaxed/simple;
	bh=4FfqC5P8X4cmd/eJJ4M8K2zcx3UPWF9L9T5qwQV6M9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbJYs5Hs1RB39Pm7ZZP4tTIreAfpcxE0QCWpNCIzgRTXvtGxrD/dQfOAQgnWqr10V6jJxR8IaJ1MWnkTX1yOi4zkLJqKqAEHylA9jvm70p4/OiEWa3fXx+Vy0FCtzb4XecrU38wvaiIBGO84Llg82pmW0XbcF4oLGJ3E9rxCZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Osxg9Xnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B4BC4CEE3;
	Sun,  9 Mar 2025 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741537603;
	bh=4FfqC5P8X4cmd/eJJ4M8K2zcx3UPWF9L9T5qwQV6M9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Osxg9Xnl5SLfxRtFN6/8h4+hmnZbN/ZQ8ARCD8d6XYGLxQhbPG4b/kAEWalc/Vo43
	 rQB9qXHnwpgMkQcsxSkDVMfTbU4uWpRvLBcIUckdT8jSy664hRHLMsBKlBOrqMfCem
	 UnRdPnq9uMmnYJXh5wowq7AydqqBjo0DhvAagY5mjmSc9GyidAsJ9zyl9HsPypYu4n
	 juvNW3hKfUHLW8zMbeklWhfo5rjQbchxNvKa33V4M07E358oePHJIZZuBo244kN9Yh
	 HaScLptvFe8udcIEKFj+ALDZUhCo9/JsFz3+yauhaRm85vGhOcD7UcL4titZkylwPN
	 79wvMAZMHVACw==
Date: Sun, 9 Mar 2025 16:26:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Prince Kumar <855princekumar@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: Proposal Discussion: ADE9113 IIO Driver Development for Linux
 Kernel
Message-ID: <20250309162637.6937c7c6@jic23-huawei>
In-Reply-To: <CAMmuoA+1Qi2qnF64nmHobL6hSFdf6GUrX=BjZ=0aGULu75b3GQ@mail.gmail.com>
References: <CAMmuoA+1Qi2qnF64nmHobL6hSFdf6GUrX=BjZ=0aGULu75b3GQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 22:15:38 +0530
Prince Kumar <855princekumar@gmail.com> wrote:

> Dear Linux IIO Maintainers,
> 
> I hope you are doing well. I am interested in contributing to the
> Linux Industrial I/O (IIO) subsystem as part of GSoC 2025 under the
> Linux Foundation. I would appreciate your feedback on my project idea
> to ensure it aligns with the community's goals and best practices.
> 
> Project Proposal: ADE9113 IIO Driver Development
> 
> My goal is to develop a mainline-compatible Linux kernel driver for
> the ADE9113 ADC (or similar SPI-based ADCs), enabling seamless
> integration into the IIO subsystem. The driver will expose sensor data
> via sysfs, libiio, and standard Linux interfaces, making it accessible
> for various applications.
> 
> Technical Approach
> 1. IIO Driver Implementation:
> Develop a modular and reusable kernel driver for ADE9113, ensuring
> compliance with IIO standards.
> Implement buffered and direct register read/write methods for
> real-time data access.
> 
> 2. Extensibility & Optimization:
> Design the driver with flexible Device Tree (DT) bindings, allowing
> support for other SPI-based ADCs with similar architectures.

This is an interesting comment.  On what basis do you plan to decide
the trade off between flexibility and maintainability of that binding?
It's rare to put much effort into making a DT binding for a specific
part flexible in this way (as opposed to generic shared bindings that
aren't specific to a part like this in adc.yaml)

> Explore an MCU-assisted vs. direct SPI approach to evaluate
> performance and CPU overhead trade-offs.

Perhaps expand a little on this.  You are talking about something
not particularly standard so anyone reviewing this doc is likely
to want to know if it is a well thought out plan or just a vague
idea.

> 
> 3. Testing & Documentation:
> Provide unit tests using kselftest or libiio to validate the driver.
> Write comprehensive kernel documentation to guide future contributors.
> Ensure compatibility with existing Linux tools for IIO sensor data
> visualization.
> 
> Community Involvement & Next Steps
> I have reviewed existing IIO ADC drivers and the Linux IIO framework
> to ensure this proposal aligns with upstream development goals. I
> would greatly appreciate your input on:
> 
> Feasibility: Is this project a good fit for IIO and GSoC?
> Driver Design: Are there any best practices or existing reference
> drivers I should study?

Generally no, but we have the dummy fake driver in iio/dummy/ that
is there to exercise interfaces etc without hardware.  Otherwise
we don't maintain any specific driver to current best practice so
you may just want to look at recent drivers for suitable references.

> Additional Considerations: Are there specific IIO guidelines I should follow?

Follow local coding style.  There are subtle differences across
the kernel but mostly we want to see a driver that 'looks and smells'
like other drivers.  Keep innovation to where it is needed. In most
cases copying and adapting is a better plan than inventing something
new.

Jonathan

> 
> I am eager to receive feedback and refine my approach to make a
> meaningful contribution. Looking forward to your thoughts!
> 
> Best regards,
> Prince Kumar
> 


