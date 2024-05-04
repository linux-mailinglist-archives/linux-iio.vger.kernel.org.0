Return-Path: <linux-iio+bounces-4788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7738BBAB1
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 13:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58F51F21DFF
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6A21C694;
	Sat,  4 May 2024 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu1gtAgG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5A12E4A;
	Sat,  4 May 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714821917; cv=none; b=d3UEIneovagY0rH7uZ1slvSvtKoiRRdR+uuPvqCtnMc0/JoFkTAs5fOUYpemli7KjLh6XsQJ5qqyqOGGR9IFp/y99lVxdRTYPRY+YsydUnnjz3mvMk8/o6s8gkXm6R1kIQUYLjgCe7qXg97MoNAYIWhPTMONhSqFVh0JxHQmJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714821917; c=relaxed/simple;
	bh=aoXtElC6QjfEFEfzT5AfaOXZlXtAWDSJADrXTUPIhJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iw+p2gYXchSk9PxM3LRIXLjEDaluYG0/MgZXGR39cLALH5fOXpj+WG45yctgD1+IBsFqyy7vk8xjz/asYAFgOGu7fo3d+TKm6sHE47fqDdMu7P9rpNoqtQo64Zsz6w8YNpz25KC0wxMu7ep74wpotNazKcF0uUCj0jBlHt/oHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu1gtAgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C081C072AA;
	Sat,  4 May 2024 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714821917;
	bh=aoXtElC6QjfEFEfzT5AfaOXZlXtAWDSJADrXTUPIhJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tu1gtAgG9z5Y+yIvIEIVmQ2fgyjD9Tn/RCv0n/DVuQsXojxeIcNqTROwRA0zGng4j
	 Ya5SpoaGi4SNih9n8Sq3x2yfWbKEhYzBOqQZnSxnGf5l7dtD3PWZLGjvO1Ih20FJQD
	 TReESyKIdZ7IsVIZsuw+P7sRyIFVtAbV56r6zgRm45YQ57ybcMMkFIXvmtn8AJNS7L
	 SXuEjrVx4AQy13Z4yg9Rs4OpkuCPiiSzKbCIBkbCtfS15qjAPrPWQ8hxsqGMzicPgt
	 RLgbpCGMpBjeLONT4v4OjIUqu4JFCpK+1qh829hJZmLNgsXGxStgLOER2GggkuhHv7
	 8TOSwx7Ys5crA==
Date: Sat, 4 May 2024 12:25:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Support Opensource <support.opensource@diasemi.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-input@vger.kernel.org
Subject: Re: [PATCH v2 4/7] iio: addac: ad74115: Use
 devm_regulator_get_enable_read_voltage()
Message-ID: <20240504122504.0389b872@jic23-huawei>
In-Reply-To: <20240429-regulator-get-enable-get-votlage-v2-4-b1f11ab766c1@baylibre.com>
References: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
	<20240429-regulator-get-enable-get-votlage-v2-4-b1f11ab766c1@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 18:40:12 -0500
David Lechner <dlechner@baylibre.com> wrote:

> We can reduce boilerplate code by using
> devm_regulator_get_enable_read_voltage().
> 
> To maintain backwards compatibility in the case a DT does not provide
> an avdd-supply, we fall back to calling devm_regulator_get_enable()
> so that there is no change in user-facing behavior (e.g. dummy regulator
> will still be in sysfs).
> 
> Also add an informative error message when we failed to get the voltage
> and knowing the voltage is required while we are touching this.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
A somewhat fiddly case.  I think you've done it the best way possible though.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

