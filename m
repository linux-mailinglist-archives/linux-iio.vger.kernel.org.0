Return-Path: <linux-iio+bounces-27263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C5BCD3F8F
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 12:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BF9C3009AAB
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4642D6E4B;
	Sun, 21 Dec 2025 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKD0dK8B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE097262A
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766317406; cv=none; b=N7CjvxbbO8jHRxr8YctQnZS2U6xGpegO+7cP3tq1rL87DEChhON1sVTuWxSeVfqW0dCD/zg/X5s6r1KOCcPb+JiGlaieNi/q2xN3UcKiL8mg3lWHP97W4iCyb+lST6mRpThtB+2LHWy09Mbg6V6H0o8PtSaj5/832NKRjtXyGdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766317406; c=relaxed/simple;
	bh=2KL3Cf182oeA1p4u4TfFDXD5ZK9Wz0P23bimmi3sdG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMzH1+m8CtQy59+D/5fXQISJrBUISzqVMsI5KaoZSIWzSbz4Ooe2Zt91i5tEtwQTajjzjuDUZwyd0tc4KvOtpMh16lQ8ynnDb9KuwkzBxsPmW6ETJm+E8sSKFklOfacTgKsh+yDccj0BDA82TqJTUvMIS83oB3kwdC7OyjpjTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKD0dK8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9EEC4CEFB;
	Sun, 21 Dec 2025 11:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766317406;
	bh=2KL3Cf182oeA1p4u4TfFDXD5ZK9Wz0P23bimmi3sdG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pKD0dK8BLUczYzjnFSy+uoxd867a4pVjvjwgc6Lh/t5/+Bfyz1nCLSRIRLHywAAbc
	 3qgZ9e9PHakryYok/cntl8mrYEl2iqBJ2WUxFdhTbILyeUa+mu2XVajVdqQdtEzpIj
	 fGeHIXWPsfLEFoEsXmXjBvJLnaoJ+O4fo1P4N9zrgMg981jJYXtYzoKK2adYZFjvIY
	 +9Xbp0avXdvcwAjs7FbZJGVOhdFuvWjEpEF3MA14lW7WWRpJXdEzACzdK2MTgkybUV
	 VM1Ap83Qqg7UK9DrWvBD9moZUWwR2VMMtpt1kpmxKCILF5ZT+b56D8j5UvAUp5k/Pg
	 IAIaH3nil6E8A==
Date: Sun, 21 Dec 2025 11:43:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 0/2] iio: adc: adi-axi-adc: Minor cleanups
Message-ID: <20251221114318.7ae2fe1c@jic23-huawei>
In-Reply-To: <20251219-iio-axi-adc-minor-change-v2-0-9d8e7270d19a@analog.com>
References: <20251219-iio-axi-adc-minor-change-v2-0-9d8e7270d19a@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Dec 2025 15:40:37 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Small series to use dev_err_probe() and turn dev_info() into dev_dbg().
> It also simplifies axi_adc_create_platform_device() and makes it
> consistent with what we have in the adi-axi-dac driver.
>=20
> (I'm aware that the dev_err_probe() patch is not consistent with the
> series on the axi-dac. I plan to also remove the braces in there as
> David suggested).
>=20
> I ended up dropping the patch that turned dev_info -> dev_dbg()
Applied.

>=20
> ---
> Changes in v2:
> - Patch 1
>    * Added helper struct device variable as suggested by Andy.
> - Link to v1: https://lore.kernel.org/r/20251204-iio-axi-adc-minor-change=
-v1-0-2d441d6c5b65@analog.com
>=20
> ---
> Nuno S=C3=A1 (2):
>       iio: adc: adi-axi-adc: Make use of dev_err_probe()
>       iio: adc: adi-axi-adc: Slightly simplify axi_adc_create_platform_de=
vice()
>=20
>  drivers/iio/adc/adi-axi-adc.c | 62 ++++++++++++++++++-------------------=
------
>  1 file changed, 26 insertions(+), 36 deletions(-)
> ---
> base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
> change-id: 20251203-iio-axi-adc-minor-change-f281c70208e8
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


