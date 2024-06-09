Return-Path: <linux-iio+bounces-6105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB9A9015D0
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 13:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961841C2111A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 11:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C128DA5;
	Sun,  9 Jun 2024 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDeT0grw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E1B20310;
	Sun,  9 Jun 2024 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717930944; cv=none; b=U5wmCLu7n1yAiAmUfsJZwiajAGq5/M4dJ/Z/UIUtTTsO7jyScMPXLzutdVdrevrDSOeERtw5M7Gh3y+Fm5J6WWsKEMelxTcL+UHIQCfH96PWzZLFFV7GneeuW1XRth/CqI+2FmSGDH/m398OsYW/AP7YyIZ+oHdVR9wp/fx7USA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717930944; c=relaxed/simple;
	bh=BYuNwJ0N6PcEiyA8zGc+9GkZM45vti7rmqGC85qqzlo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXuq8JZ+TR3skPDp64Djsd7Xtp76FjJxGfvmqrTnmy3HH0yJJU4uv76fX97TI+xcYKizQK9ZXVtfI/mmYfSnLSXnGNdgnJMjQtBY7J1Nlh1XoO9hI+o7/vmJ5Cbzj78Vb0G8wGuGYK4uD1xNqP4XTLey+yp4s+EnX3ul2nC2yN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDeT0grw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5770FC2BD10;
	Sun,  9 Jun 2024 11:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717930944;
	bh=BYuNwJ0N6PcEiyA8zGc+9GkZM45vti7rmqGC85qqzlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WDeT0grwqJJYljdZuSZjgdFCsg/b3HPBkc+w69tpV6QXlWnoIe1+O2v+dUO17j+9e
	 XuP+ngkWnyh5lMMd5XBXQTWTvgL9OYO5G70na+Wtfh11HK06fHSChCZvkvgD03GlCZ
	 YXszG3iFLEbqvlGuaKVlSsHTpwadWVfM9mcgHltx8eVw6weSN2Z1QNoUrv6GpNJxTY
	 zd3nEj0vPVIooIFlgF5iv2PNoRbfPDK8pPzpSMfpjmYrNzRgI9oxH+8h4cB/QfdoC7
	 f7/GVq22eoT0dgajsq7IuT267gnD9m+E00u4+BA9uf8N09Ft7AIOZo+RIeZgzsit5a
	 l2fThFwedX9Xw==
Date: Sun, 9 Jun 2024 12:01:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dpfrey@gmail.com, himanshujha199640@gmail.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mike.looijmans@topic.nl
Subject: Re: [PATCH v2 03/19] iio: chemical: bme680: Fix overflows in
 compensate() functions
Message-ID: <20240609120147.65c7001d@jic23-huawei>
In-Reply-To: <20240606212313.207550-4-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
	<20240606212313.207550-4-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 23:22:55 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> There are cases in the compensate functions of the driver that
> there could be overflows of variables due to bit shifting ops.
> These implications were initially discussed here [1] and they
> were mentioned in log message of Commit 1b3bd8592780 ("iio:
> chemical: Add support for Bosch BME680 sensor").
> 
> [1]: https://lore.kernel.org/linux-iio/20180728114028.3c1bbe81@archlinux/
> Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied and marked for stable

Thanks,

Jonathan

