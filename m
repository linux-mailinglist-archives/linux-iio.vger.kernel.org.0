Return-Path: <linux-iio+bounces-26154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C471C48FF3
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 20:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A12044EE53F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 19:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81224332EA5;
	Mon, 10 Nov 2025 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LrNdybCn"
X-Original-To: linux-iio@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA6C33290C;
	Mon, 10 Nov 2025 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802674; cv=none; b=p1Z0lJ6UgN5SHusw8PmFHnFkeXMC5a7xJfcGOWf2kTUkd0yLza8neZjgzDI+X7ZlkihcO/flGX4Qea/utLyCnetDci9bAsUxdcTfGtNa5xVLzVE8l91A2sXsDaXYLSwOyuG12KJmZOomcRNhjDM5RCEtxQ2FKWUOvCt2NBR6vbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802674; c=relaxed/simple;
	bh=jekjcNBy2E4c1c0yPWqzQqES4OUUHGM0AQmpLGpOFqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1OpVBMUhlsOfUBfLeqQUYP9MImPGv1GDglderEmk54zns2GwR+YoV4/M7HwInaIDC4P+lzQhBjnaPExveuAQ9qvo0OSssaFId5HsnoU8OoshgNTqesMyqrgm2T17dCR1rP6BWbY4oLhpRHtvmZGDVFWgfgw6BtP6+lhRkv1ugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LrNdybCn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=zHSN+Mh7ncyx0AYcFN5Z7T7CQcFnHal6f6bYdu4mO7U=; b=LrNdybCneDc8S5CX2nR1LifOsF
	M/YwjpXSTZpN0JEv2FW1sgH28soA27Pwy/KrS72Fo+dZj+hhWOP3j8hOYrGNwcGcefKB3dX64jLL+
	l0zFx5XII5TM3WAtx5ItPBrO16j6CZGwOig6CpsLwtTTOUSFvCCz/8itqVVR5DTwsEhcz5XsVYOYA
	nnCWFuGnumYs3qADGxZI6CGpcJ2EYdjAxonN5XjWWpJrV1ksXYW5J58f1oM1NoCqkvQ9SLpik+pcU
	zNCeRauXvZgVRW7z6JvXd1jM0FNINoA+nGLIS5GQ4HzLgVnnEOV35V/Ne2ZD74ICXjBpvdPrilMmX
	jWzg2vjQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIXV8-000000061UF-1p4b;
	Mon, 10 Nov 2025 19:24:30 +0000
Message-ID: <b5c1e5ec-0081-4a26-afb2-135d9a0a14bf@infradead.org>
Date: Mon, 10 Nov 2025 11:24:29 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] Docs: iio: Add AD4134
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 cosmin.tanislav@analog.com, marcelo.schmitt1@gmail.com
References: <cover.1762777931.git.marcelo.schmitt@analog.com>
 <bbb702b6e2cad4bf79b1490c4280ce998b46827b.1762777931.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <bbb702b6e2cad4bf79b1490c4280ce998b46827b.1762777931.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/25 4:45 AM, Marcelo Schmitt wrote:
> diff --git a/Documentation/iio/ad4134.rst b/Documentation/iio/ad4134.rst
> new file mode 100644
> index 000000000000..fe20ec6f2132
> --- /dev/null
> +++ b/Documentation/iio/ad4134.rst
> @@ -0,0 +1,58 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD4134 driver
> +=============
> +
> +Device driver for Analog Devices Inc. AD4134 and similar ADCs.
> +
> +Supported devices
> +=================
> +
> +* `AD4134 <https://www.analog.com/AD4134>`_
> +* `AD7134 <https://www.analog.com/AD7134>`_
> +
> +Wiring connections
> +------------------
> +
> +AD4134 and similar ADCs can operate in a few different wiring configurations.
> +
> +Minimum I/O mode (SPI control mode)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Fourth level "underlines" should be "~~~~~~~~~~~~~~~~~~~~~~"
according to Documentation/doc-guide/sphinx.rst.

> +
> +The minimum I/O mode wiring allows AD4134 register and data access with the
> +conventional set of SPI bus lines. The hardware configuration settings for using
> +AD4134 in minimum I/O mode are:

-- 
~Randy


