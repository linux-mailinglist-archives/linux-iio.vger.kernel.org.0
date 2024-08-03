Return-Path: <linux-iio+bounces-8200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BEB9469FF
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 16:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163ACB214F8
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387091514F2;
	Sat,  3 Aug 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6MERVGL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907C13635E;
	Sat,  3 Aug 2024 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722693968; cv=none; b=sisxcM1lXWKqz0OyJH5iMMWMGPxD4S6TJGFnt7gdq6ckIsUEOgN+9dPlGK/pv5jO3pKV2JXufVjSnSiyHude4HL22ogn6meRPibhkIhkUcuINZtUpfREk+LO+0kg0u93C1f4ZCRrU/QwAIFLwVzbXnxFlT1S5JSq8RHGpaL1adY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722693968; c=relaxed/simple;
	bh=RixCY/h5yZqnK3e9g9NA35t0Jqq1QrZ6k4P96vrMYK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuLbjs1qlRD58rc8s9niHiNShv3Lfz2fLJg8xgWt5APZwSnSO20vEgLpwyLaq4imXfsNG0StW32xvSFAlmPIc4SzVuW8THmNMCCPVij1NumDh1RtDeIOMp6hIC3XpP3ias+ORK6fmc8hc99WMOe+tNkQg85AuB3Tye4x0DwsJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6MERVGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624B8C4AF09;
	Sat,  3 Aug 2024 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722693967;
	bh=RixCY/h5yZqnK3e9g9NA35t0Jqq1QrZ6k4P96vrMYK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s6MERVGLjLr0hh39Q65cROiQyPTB1QppZOVCxqrRTI68TwsXOzOcd5jG1lr7kMzL+
	 qMEdItB36PCF4/nd/IRbRAlrmfKbZ9Cj/s7ocNJVLEVWkl1xLp21UP6ffXxZkfI5si
	 +qlSFO7brnSaYV/9/rS8Yrn+mDTXRZuz64OPko5wBWmW8AW8tgdwuFt0Tb3kuMBQYB
	 YgtwoaR9oE1JQRnkHdW48av4uJ4ZIFrnLC0AEPmbb2q78DjbOnm4ZaTqMUe3HR6bGw
	 10x4tIqdFU8OAMacp0VaJNqNOwew9KRKkcEqufr2IkXjBKxF7TXvdYWSEmzDedenoq
	 kf8aqkDFRKO7g==
Date: Sat, 3 Aug 2024 15:06:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] iio: light: ltr390: Add configurable gain and
 resolution
Message-ID: <20240803150600.2b61fe65@jic23-huawei>
In-Reply-To: <20240731063706.25412-2-abhashkumarjha123@gmail.com>
References: <20240731063706.25412-1-abhashkumarjha123@gmail.com>
	<20240731063706.25412-2-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 12:07:03 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Add support for configuring and reading the gain and resolution
> (integration time). Also provide the available values for gain and
> resoltion respectively via `read_avail` callback.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Look good.  To reduce what we have to cover for future versions, I'll
pick this up now.  No need to include it in v6.

Applied to the togreg branch of iio.git which is pushed out initially
as testing for 0-day to see if it can find anything we missed.

Thanks,

Jonathan

