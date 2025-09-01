Return-Path: <linux-iio+bounces-23560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038F7B3D98D
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 08:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC354179EF4
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 06:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8204242930;
	Mon,  1 Sep 2025 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bdSVmUwF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E67921019C;
	Mon,  1 Sep 2025 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707026; cv=none; b=BlZ+L1ee44MU3Iad21VvH90Gc4HOcWwdoJ+ZNNtN4G0CRDvSLGVeYNcihY04YT5VYzHKjAF38yQ8B/x+xr+AjibzGL1inpZ5gq2QAlIS6s4LiGhCTZircO89wTpyOldkJqeSs8LgqBzkAaCv8aIGmQ6sg1wG+zWexU81dVchIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707026; c=relaxed/simple;
	bh=DgRuaBcNWQtJ24Tl7NhKDs3+2MFCajM3UYXIaPKY8uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrZ6hzK0Y81HkbPeQBYZVh3EPc+y+jC6R5w61WcaUmzuB2ALUB5iAF7etr90MXOZjPhDpDipcjaeyWezWQI3uVtiTkoAtNiGCXwvdqU2Px9nv9k8JGhfK7zj6mB3PSbugyrp1EeNBAMMQWT8MAuszdxwm4EAMKrJvMFALKuy8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bdSVmUwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EF4C4CEF0;
	Mon,  1 Sep 2025 06:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756707026;
	bh=DgRuaBcNWQtJ24Tl7NhKDs3+2MFCajM3UYXIaPKY8uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdSVmUwFWL02V5muTJ9zoZcNw1MkXOseAo6mSWuGoisau8nSj1WEPTkvgaC4sHC/5
	 EprOs8nOwH+1La96sHR2QJRHccLiWDA8/qSvwrWSBFS5Ma9Pm+L9Vz0WdV0C/3cyPN
	 33BB8kZR+w1GdRG3bW1eI1V85nyJ2j1OVFyiATew=
Date: Mon, 1 Sep 2025 08:10:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7816: add mutex to serialize
 SPI/GPIO operations
Message-ID: <2025090150-backspace-undone-e11d@gregkh>
References: <20250831153741.8820-1-moahmmad.hosseinii@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831153741.8820-1-moahmmad.hosseinii@gmail.com>

On Sun, Aug 31, 2025 at 07:07:41PM +0330, Mohammad Amin Hosseini wrote:
> From: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>
> 
> The ad7816 driver was accessing SPI and GPIO lines without
> synchronization, which could lead to race conditions when accessed
> concurrently from multiple contexts. This might result in corrupted
> readings or inconsistent GPIO states.
> 
> Introduce an io_lock mutex in the driver structure to serialize:
> - SPI transactions in ad7816_spi_read() and ad7816_spi_write()
> - GPIO pin toggling sequences
> - Updates to device state via sysfs store functions (mode, channel, oti)
> 
> The mutex ensures proper mutual exclusion and prevents race
> conditions under concurrent access.
> 
> Signed-off-by: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>

Doesn't match the From: line exactly :(



