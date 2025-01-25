Return-Path: <linux-iio+bounces-14575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F7A1C3A8
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 15:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35283A8DD6
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CB28821;
	Sat, 25 Jan 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH2fqfvI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5201EA90;
	Sat, 25 Jan 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737813731; cv=none; b=Oxqyi5LBpidr671RctC7nJBPshHFTHtyqT239mQqzbw9hDVP9nbgFsP3VUd0fv6qNM0VQiVupZ+k6clDRT0TjjGDdCxLZHPKvRSs9wm7pMRf3S4s4NepmJiK0uKj4NEqHQGX50/RiFNDyS5P8otNaTBwESfPCteQ/3yuVeMsvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737813731; c=relaxed/simple;
	bh=h5c9IMWt9iFgT5MLj1Kq3WojfpWPeAg4OWrNklmAl/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgqoyd40Fr97AXb0bOylbCwvTVRLQZpVBURePNTAm2wRvKBZLdmYdZYyKwrCK1cSHMZrqgEvkTVGsLN+vVDoL86frW7hUQn2jl8hO3PhbDVU0GTjaODKfJMQOFPrtlGHGyvxYHWfiEGFyHMhI8eiW7fooMD5YHQadvkK424OUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH2fqfvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFF1C4CED6;
	Sat, 25 Jan 2025 14:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737813730;
	bh=h5c9IMWt9iFgT5MLj1Kq3WojfpWPeAg4OWrNklmAl/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iH2fqfvI5oonGK8E3uZSRtSOyL51jzXCVWnDZsxAR5nsGOCZwP4NJer48Abr+luiV
	 yjy9bTYwaBfwnHg1l0yVrRg2z6heLsJH9xlpPQWKd/rrvo5CPUDhVgKssWA/ewsjV9
	 JoZg9uV0taZ7nLS+7kVZ2aOpux24e7RzioZ1nGOCp9KnhTPbd+HmVyqvPZwmImOKrw
	 W4K5TCsitRAQUi/lEiOqHZvjvsLITREit2BiH9kUZRtdxQGxtsSM8YanjU1gD27rTy
	 HWh1l3d4z6Y/O7qbDcXUS64TSozReIR9FvKDRj3CyyI+k5pL+magQ52xRA+KpKf0Q+
	 DhO7JDFe87MxQ==
Date: Sat, 25 Jan 2025 14:02:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrej.skvortzov@gmail.com, neil.armstrong@linaro.org,
 icenowy@aosc.io, megi@xff.cz, danila@jiaxyga.com,
 javier.carrasco.cruz@gmail.com, andy@kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/2] iio: magnetometer: add support for Si7210
Message-ID: <20250125140200.15cac097@jic23-huawei>
In-Reply-To: <20250120215620.39766-1-apokusinski01@gmail.com>
References: <20250120215620.39766-1-apokusinski01@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jan 2025 22:56:18 +0100
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> This patch series adds support for the Si7210 Hall effect I2C sensor.
> The driver currently supports the basic functionalities (i.e. making
> temperature and magnetic field measurements and changing the
> measurements scale) but I plan to add support for some other features in
> the future as well (e.g. the digital output interrupt).
> 
> ---
> Hi all,
> In this version I add only some minor tweaks and comments (for the
> temperature calculation) according to the latest review.
> Everything else was left intact.

Applied to the togreg branch of iio.git but initially only pushed out
as testing because I'll rebase on rc1 once available in about a week.

Thanks,

Jonathan

