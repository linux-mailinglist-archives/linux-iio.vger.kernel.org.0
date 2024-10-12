Return-Path: <linux-iio+bounces-10501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE94999B4AF
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 14:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEDB1C21314
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 12:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04829156C69;
	Sat, 12 Oct 2024 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If9Mqfx5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8815C0;
	Sat, 12 Oct 2024 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734499; cv=none; b=m7QEXldHZtsTkwJaULA4dssHNgWsLA1mVOxjtqYCPua6on+oLRA7/7b/fYVjWnlcmsigDwI7ip3xjy/UK24QaC25gNVV4PuMFcmVRrc76lq8xI1jjCJdvKxXjPzNQRTJAHBQr41LJ0Szbm0Qw6oNpe/FZxQAmIdgRGe1fSj5c1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734499; c=relaxed/simple;
	bh=plERdmNBM5/sxntNA4IfxGm9pbV3oKBHNIWGFVDmHcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eC9Dcq37uv7eXYjPjs3xuH0/WOt+H9y7R1uaCD3q3GxOSHqCm6t73t9oilQcSSPLNnCaCPIvyrN7+ATz1HfpceG2LzrdljlYBK/UUd8qIhHekVaSt1eVY0ZLGLEv1PZlN613QRjjHirIDRLdXYyQrcdtYH6PFTDsaGONvBl7xPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If9Mqfx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C55C4CEC6;
	Sat, 12 Oct 2024 12:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728734499;
	bh=plERdmNBM5/sxntNA4IfxGm9pbV3oKBHNIWGFVDmHcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=If9Mqfx5J0lEBpqHqt6keIoR0sMnpkG5LHIGrM2ICSwdEY1Why+H3G32GPT6iJZIR
	 Y45uncyG8NVIgP8u2Oo9JcPWLJuqnjtUqbOA851VNMC35M6vcSK9AD3/sQ0s6m5d/l
	 plmFqhlfA+788aIDSWI+Q0ISiksG9IGV9JcS3d9y4c07G2c5ZOzDJNMXaqo+W1i8hs
	 j4uz4rzaLZZhAhrW+pl0nDGviCh/a1A7U4HoUPFOeXaIhl3vjgVBISibHM/lBcRNiz
	 nDFYXqA/scAmSNGHvt7xeDyDJAmCpsjqkZGmbzAjHhYJTRgG2Cuj7Ow6Sqc8FunxpP
	 l3qhvLHyIyTpg==
Date: Sat, 12 Oct 2024 13:01:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: vamoirid <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
 andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/13] iio: chemical: bme680: Move ambient
 temperature to attributes
Message-ID: <20241012130124.44c69521@jic23-huawei>
In-Reply-To: <20241010210030.33309-10-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
	<20241010210030.33309-10-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 23:00:26 +0200
vamoirid <vassilisamir@gmail.com> wrote:

> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Remove the ambient temperature from being a macro and implement it as
> an attribute. This way, it is possible to dynamically configure the
> ambient temperature of the environment to improve the accuracy of the
> measurements.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
New ABI? Would need docs.

However, I 'think' we have a few cases where we handle this via the slightly
odd interface of out_temp_processed / _raw with a label saying it's
ambient temperature.

The tenuous argument is that we have heaters that actually control the
temperature and the affect of either heating the thing or just happening
to know the external temperature ends up being the same. Hence use
an output channel for this control.

Jonathan

