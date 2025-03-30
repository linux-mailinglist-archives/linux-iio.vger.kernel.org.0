Return-Path: <linux-iio+bounces-17360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4F0A75B0F
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1607D3A7876
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761981D7E57;
	Sun, 30 Mar 2025 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaIEU0zv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4CB524F;
	Sun, 30 Mar 2025 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743353637; cv=none; b=JUEn//+PkfLmJBfwxusfcymeEF/q7+UdSwJD1sYY6Blpa8q80CHV+8mlqcGa8sryK2ngCmcklRZ9yqC5WJl7EjnuA9+3HkyfgpgUd82A00KXrOZVes98OVP4MveMIq76T4HainQ2K6b74OEhfh89BmEAZYGD8RdslHua9khFDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743353637; c=relaxed/simple;
	bh=hSoAvav/HO8H75lU2bgG5hy9eofT6f2Z4mnIG7Uv5no=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asaX0u8YerbCxVV353yf/DFy+AllIjte183qkSyh3GcLpDJNWlHEi75ieo+2NXMIjDDXonyKz8aBfmsjEdp5a7yvWhS34lBVRNLipuyw+5ejb0fm9ZnK/I/6aoNIla4MAX0WjxoJyye7y+wmf9CTTpWV7ZAxQnbkANx/Rfb1KmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaIEU0zv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B448AC4CEDD;
	Sun, 30 Mar 2025 16:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743353635;
	bh=hSoAvav/HO8H75lU2bgG5hy9eofT6f2Z4mnIG7Uv5no=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uaIEU0zvPwAQuptNcFWV2YFXVJnetpk0V/TQgn6J8qQi+qfpmqiHaCZGTVA+l3dR0
	 omGqGGMVT4iMnG/u6bVXggPFt14XjR16g4egievkIXUz2XBI/RKO1LpO9bXVxSpyxf
	 gYlsEhhp+yUSAOCoJG+hwlSWXj0OKA5TDKkgYmo9EFC5vdbIilMLGh0JXqJVT1QkZw
	 KbeSQzfMciGneQK+GmoITbUXAzjsnvrej/0N2e2nHxuT5LBBOSSwbhz0X/X+pzYoeD
	 jsri0dzfkAssMhfecVk1jq2XW6EzOv8GIn5i9nItXpTdbBcYTZGyZ5spRY0wls0DUh
	 q8fuQm/lIaZUA==
Date: Sun, 30 Mar 2025 17:53:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] iio: ad3552r-hs: add support for internal ramp
 generator
Message-ID: <20250330175350.6cebf779@jic23-huawei>
In-Reply-To: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 21:28:47 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Add support to enable the HDL IP core internal ramp generator,
> actually managed by the adi-axi-dac backend. 

What is it for?  Circuit testing or something else?
We have in the past had pattern generators in IIO (currently under
frequency drivers, though I'm not sure what we have in the way of
waveforms in the stuff outside staging) so I'd like to be sure
this is about debug rather than a pattern that is actually expected
to be useful.

Jonathan

> 
> It works this way:
> 
> /sys/bus/iio/devices/iio:device0# echo 1 > buffer0/out_voltage0_en 
> /sys/bus/iio/devices/iio:device0# echo 1 > buffer0/out_voltage1_en                                           
> /sys/bus/iio/devices/iio:device0# echo 1 > buffer0/enable 
> 
> Activating ramp generator:
> 
> /sys/kernel/debug/iio/iio:device0# echo -n backend-ramp-generator > data_source
> 
> Deactivating:
> 
> /sys/kernel/debug/iio/iio:device0# echo -n iio-buffer > data_source
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> Angelo Dureghello (4):
>       docs: iio: add documentation for ad3552r driver
>       iio: backend: add support for data source get
>       iio: dac: adi-axi-dac: add data source get
>       iio: dac: ad3552r-hs: add support for internal ramp
> 
>  Documentation/iio/ad3552r.rst      |  65 +++++++++++++++++++++++
>  Documentation/iio/index.rst        |   1 +
>  MAINTAINERS                        |   1 +
>  drivers/iio/dac/ad3552r-hs.c       | 106 ++++++++++++++++++++++++++++++++++---
>  drivers/iio/dac/adi-axi-dac.c      |  27 ++++++++++
>  drivers/iio/industrialio-backend.c |  28 ++++++++++
>  include/linux/iio/backend.h        |   5 ++
>  7 files changed, 227 insertions(+), 6 deletions(-)
> ---
> base-commit: eb870a5af7db1e5ca59330875125230b28e630f9
> change-id: 20250321-wip-bl-ad3552r-fixes-4a386944c170
> 
> Best regards,


