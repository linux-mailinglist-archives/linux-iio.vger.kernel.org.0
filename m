Return-Path: <linux-iio+bounces-27298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CE4CD44E1
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DB5E3006A96
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC41F31618C;
	Sun, 21 Dec 2025 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bi2UAMpw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF12264CB;
	Sun, 21 Dec 2025 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766345782; cv=none; b=SFJeY3GGkrsPCS7O2a2B9CTBTQ2yRakpM3KDf5kJf9da177ZDYsd+5BCbSyWzNtL6wLtPfSRAOrvW2vbOUABIVqYr9fX0lGKL94uYzGYZgY3LBhlPeihn4fFA6t6ORR0acCRXF6qyxgZGpSku9qCmTMyyWxHtCfV4hXBbBLPGTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766345782; c=relaxed/simple;
	bh=OLKg0NPRIwhLpHBbaNiGt8rMd/F/K6D8vXjxGBQtxGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLm0MPzRQONOnSPFIWsNQFl0FWEi+oqR7nTrtjsAuJQqxGFgLAKWMw6t0CrBPa1+QI2hUD9DZMBK0uF6uNg/JmuAkpynBJ4k0tCBnilXaB8nsVeSiY0OhIbAyp56qVtZpe/cggmid5cDTDI72PeUUlNDfaBDR4dbtTV767B+eI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bi2UAMpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29507C4CEFB;
	Sun, 21 Dec 2025 19:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766345782;
	bh=OLKg0NPRIwhLpHBbaNiGt8rMd/F/K6D8vXjxGBQtxGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bi2UAMpwBNFIWwg2ZWrMXvZE9+vAWqTjPVw7zYo06SwKHIG8oXKhkoWihdiujC7FK
	 jLyAlLQsgBGujYlc4+U1WxwHanK6SJj3l8YncRaCLLSFBUzInU3LH//NLnHDdHpLC9
	 7c84bcEsCpZL0sZ6D87XfWO7rbzjikB3ux4vfjaxFm1u674MbB8zqIC+O2pmI1MeLj
	 ey4KK5gaa9x22N+2cnWwZhORrFfAmkMmTF8hSk++Nd42AUGWk9cprdQb4/nNX/GFLU
	 JoAHJNo3qMje0oGTCtDDU5kLi7RWfz0YfUpIAXiZKwoiLSgVVK6TX6wrEgyla9uCU7
	 qH+tbrYT1QHAA==
Date: Sun, 21 Dec 2025 19:36:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH 4/5] staging: iio: ad9832: convert to iio channels and
 ext_info attrs
Message-ID: <20251221193613.2f956ff8@jic23-huawei>
In-Reply-To: <20251215190806.11003-5-tomasborquez13@gmail.com>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
	<20251215190806.11003-5-tomasborquez13@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 16:08:05 -0300
Tomas Borquez <tomasborquez13@gmail.com> wrote:

> Convert ad9832 from custom sysfs attributes to standard channel interface
> using a single IIO_ALTCURRENT channel with ext_info attributes, as this
> device is a current source DAC with one output, as well as removing the
> dds.h header.
> 
> Changes:
> - Add single iio_chan_spec with ext_info for frequency0/1 and phase0-3
> - Phase attributes accept radians directly, driver converts internally
> - Frequency attributes accept Hz (unchanged)
> - Cache frequency and phase values in driver state for readback
> - Remove dependency on dds.h macros
> - Rename symbol attributes to frequency_symbol and phase_symbol

If you can break this up into a few smaller patches that would make
it easier to review. These symbol elements would be one thing I think
could be done in a separate patch.

Otherwise I didn't see anything extra to comment on in the actual code.

Jonathan

> 
> The pincontrol_en attribute is kept temporarily with a TODO noting it
> should become a DT property during staging graduation.
> 
> NOTE: This changes the ABI from out_altvoltage0_* to out_altcurrent0_*
> with different attribute organization.
> 
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>


