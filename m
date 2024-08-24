Return-Path: <linux-iio+bounces-8751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 341B695DD3C
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 11:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA3E28368C
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18C2154C04;
	Sat, 24 Aug 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMOmkc0s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610E514D702;
	Sat, 24 Aug 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724493079; cv=none; b=KV3nxkg4iV3WMFfmihklS2zYZ6Ss/YFVaCTCB6PnlsnIFF/X1TsuxORjcivrIH8S6VFNpPcSSzFa3XuP9y06Q3N2+pv2FYyf8b6LuRQAKXYM3XLBWkZKd1fmI3Mm6XVXjRE4eWuoBaJj5QVRp4sOS6cXldtJXOoNWTxBWGBP2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724493079; c=relaxed/simple;
	bh=S7PoQMyo4AHBJ7EjsNHBCDhgulNjIuKO82W7aNKdZjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESK1APtIVjJUHKxRkCTV2h9VvkJSAGjNUv2h2dUdksvPfwrTDPPldvN7u3CHzdPwDl2y0vuTP/4K+ivqKqpZYjo0FFqPdTWQqKUIBFQul3nGQMZi4nHThW8RJ8c0VfyP7/tGxNVdFl9Dq2TFZdoWeTEvhU1rKVBShU5pXqC1btQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMOmkc0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CAEC32781;
	Sat, 24 Aug 2024 09:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724493078;
	bh=S7PoQMyo4AHBJ7EjsNHBCDhgulNjIuKO82W7aNKdZjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WMOmkc0sk4OIW71puUpXtgTqM9zRvLKn5YfCk182fDRWimbO1eONcAzQDpWJJXMPu
	 keVS7oHimFOYKojlRyl88KHfiXxByj2M1lQVQ0g86PYYQn4XrrlZ/2Q6KHTuGgeU5b
	 EfxMy/xC+sD3ElguYQUtUeolAaGcRWYU5tIB6TCVJEHOs/f6QVLw8nmK8hNL26YFxJ
	 futCSzgKrPJGoza6Awaa8oo7CzCNkmdWuvioU3g9LyVst3JEC6n9zbH7y+qXFCus/9
	 QQh/274VCJQdGIvxYPHtIISHXcXj6DkRdA6lmsvBWowTQFscN3+hJA8TNsIzUwyF8U
	 SX0DQfendamiw==
Date: Sat, 24 Aug 2024 10:51:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: accel: bmc150: Improve
 bmc150_apply_bosc0200_acpi_orientation()
Message-ID: <20240824105107.55b55507@jic23-huawei>
In-Reply-To: <20240823230107.745900-1-andy.shevchenko@gmail.com>
References: <20240823230107.745900-1-andy.shevchenko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 02:01:07 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> By using ACPI_HANDLE() the handler argument can be retrieved directly.
> Replace ACPI_COMPANION() + dereference with ACPI_HANDLE().
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied.

Thanks,

J

