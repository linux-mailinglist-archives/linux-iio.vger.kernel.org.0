Return-Path: <linux-iio+bounces-9060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B639693B1
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 08:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0617E284553
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 06:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411A81D1748;
	Tue,  3 Sep 2024 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLgPA+y5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A81CE6F4;
	Tue,  3 Sep 2024 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345169; cv=none; b=Xsp9uRJda2I2L1hlvwbZ9xLdClOXPTvZIRo92sY1yrdgFawLrE6tBxJPVkMo5gLE9r9b0+22lxMa/UiMAvtwz4dwxVBuvNKHFB/C9otwuYcP0CaT4ukV7GcR0coub57OEn6dTJr6XvHjy8JrrePQxuWNsFU2pNhMj9Fj7sq9cf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345169; c=relaxed/simple;
	bh=Bm7MKarr3FGzALiV2kY3ApdriLG46rhsB+q0R5b2a/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxllOI7D65YJWd2JpLmJ0AbIhiunUJU3L3Q87uhMCBEjjVmdhtlLhVylTpGxZwtxed8QK0qPEtvbmNrFqhG6eq8pI09YAHSr9YOP4c598Bpu3QkSRFM0l1AUWg+Z3Z++TouQojCyaiQUf8N2tUbRlhGrcWAlFX/7+qr7ecaLshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLgPA+y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A65FC4CEC5;
	Tue,  3 Sep 2024 06:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725345168;
	bh=Bm7MKarr3FGzALiV2kY3ApdriLG46rhsB+q0R5b2a/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLgPA+y5ZN2JNKRTfReoir61qmFkStH/MIIzmKsYB+LZ6tP7ImeW8smOxRJxyX1A8
	 dR5dZvqzj7ElaIrKhvnLu+BHSEPwi8ul6fILNnv5pZBVvQSOLgQI4Ov4t8f14wRNji
	 YPVWWnRCI+xZas1t5w4D2eK0wzLx1m8Kjf0d7XgcIMP8pfufjGzVb5+n+Q7Qo66nza
	 rp4hpW44lSxjVRJ6iaxiZiyZUao/0rGC0LKgaII/br+Qs2mgPwhCv0gGNCGk56a7I0
	 /f3m4ZAnit0ThQGGR4MvtJbgwAQHNxxWk8oVo1aAuXnabihhcqTRzLPI70GTi1MHaQ
	 nliEuWvdPHr7g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1slN67-000000004SR-114w;
	Tue, 03 Sep 2024 08:33:03 +0200
Date: Tue, 3 Sep 2024 08:33:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 17/22] iio: light: lm3533-als: Get platform data via
 dev_get_platdata()
Message-ID: <Ztatn6sZjmQ59N4j@hovoldconsulting.com>
References: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
 <20240902222824.1145571-18-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902222824.1145571-18-andy.shevchenko@gmail.com>

On Tue, Sep 03, 2024 at 01:17:02AM +0300, Andy Shevchenko wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Access to platform data via dev_get_platdata() getter to make code cleaner.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Johan Hovold <johan@kernel.org>

