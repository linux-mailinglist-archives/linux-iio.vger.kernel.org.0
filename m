Return-Path: <linux-iio+bounces-5631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E5B8D75B2
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6F51C20E20
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F33D0D1;
	Sun,  2 Jun 2024 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjfsh/Hd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3763C6AC;
	Sun,  2 Jun 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717334657; cv=none; b=lce7EUjptC/evQJGWnC7tSQvs//2hJUJGiLrUUlpoXasWMbmweTipkfdGaAshsG/D8WRDvj+dHVZ0ytvN3gYKWcpxxpnRyJcmaQNkjKaDxc/FY9K2YEZoMXaOM+3/BsaFeyz5fPuAC6GdLlBIpZGzdh9+OQNREo6QB4DJsQT9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717334657; c=relaxed/simple;
	bh=dnamS6gYRBTa9AM8C9UJNIgYkhTlgyuFI5Sr/Q8Rxek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bw6I9kLqRMXCNM41vQ9y9FKEDyj1frjQOvUqvbyE9bhPerYrVxPct0Lf0ghbwCe/G+cTfLJ70rrmXwEbPgwQlhquGrk5yhzOVjXyDeieSou51JlJSFsSp4GMfDnGlBpDA7RVvicPauQros8Z25siqczxoTV03gM+M69J8XgvPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjfsh/Hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4F5C2BBFC;
	Sun,  2 Jun 2024 13:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717334657;
	bh=dnamS6gYRBTa9AM8C9UJNIgYkhTlgyuFI5Sr/Q8Rxek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qjfsh/HdfPr5jRbfiGC87ljMrYiyrRuV9sHa1qrgvPOo+3/+dGR/cL1kU14hRSNZq
	 EDogUu50Bq4pl+1ZJbFQcJXe54OHDHS+t43RgafeodGti1fDGO+rRJH9kO8WHcAHqX
	 4ukUEG+tr+8TviqEyWnhlHBJAz3woViUjbkgRV0UZfXO8+AGv0kq3y73E8NFodslLy
	 9dB+aw9IITRL8O8pydbA2ht1kBVGDiFNv+tzOmEWImN7dn6QY5XKAe+XfS1lu6NDc+
	 lJjyowQ2+fWauN46qo5DWlypIvcitmInebFj+u8d2hVZvJX4aEoUELkkqeR55zNuSR
	 QLnVBeFFqRXOg==
Date: Sun, 2 Jun 2024 14:24:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: andy.shevchenko@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org,
 u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
Subject: Re: [PATCH v3 0/2]
 iio-proximity-hx9023s-Add-TYHX-HX9023S-sensor-driver
Message-ID: <20240602142405.18a99cef@jic23-huawei>
In-Reply-To: <SN7PR12MB81019093E9E5D29BEC4B821FA4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
References: <20240519162438.17af0ff8@jic23-huawei>
	<SN7PR12MB81019093E9E5D29BEC4B821FA4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 12:57:47 +0800
Yasin Lee <yasin.lee.x@outlook.com> wrote:

> From: Yasin Lee <yasin.lee.x@gmail.com>
> 
Hi Yasin,

Don't send a new version in reply to an old one.
Given how many revisions some kernel patches go through, it becomes impossible
to follow some threads where this is done.
On a more practical basis it ends up off the top of my screen in my email client
so I may miss your series entirely.

Patchwork was tracking it so I noticed this time.

Jonathan

> v3:
>  - Renamed the files to keep the file names consistent with the chip name.
>  - Removed custom bit operation macro definitions.
>  - Deleted redundant documentation that duplicated the Standard ABI.
>  - Deleted unused header files.
>  - Deleted unused register definitions.
>  - Changed parts of the code related to circuit design to be configurable through DTS.
>  - Removed unnecessary print statements.
>  - Fixed the error in hx9031as_write_event_val.
>  - Removed unnecessary threshold settings in the probe.
>  - Replaced enable_irq(data->client->irq) with interrupt enable register operations.
>  - Fixed style issues.
> 
> v2:
>  - Deleted the global data structures, replacing them with dynamic allocation.
>  - Delete debugfs.
>  - Fixed styles issues.
> 
> Yasin Lee (2):
>   dt-bindings:iio:proximity: Add hx9023s binding
>   iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
> 
>  .../bindings/iio/proximity/tyhx,hx9023s.yaml  |  106 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
>  drivers/iio/proximity/Kconfig                 |   14 +
>  drivers/iio/proximity/Makefile                |    2 +-
>  drivers/iio/proximity/hx9023s.c               | 1428 +++++++++++++++++
>  5 files changed, 1551 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>  create mode 100644 drivers/iio/proximity/hx9023s.c
> 


