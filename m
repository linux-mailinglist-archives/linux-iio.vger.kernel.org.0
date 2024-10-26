Return-Path: <linux-iio+bounces-11318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B309B1760
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC595282E06
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1961D2B10;
	Sat, 26 Oct 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOhjQvwm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC55217F29;
	Sat, 26 Oct 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729941586; cv=none; b=bde6yD+rYV2H6JWxCviDtfbatuur9Z6JGSJX8wI41CKkcXyOpHicm2QmTWicIHGOy2NwBrgJyLIuuCVbXdLtmDJXNSkG8twHvyi/cMFsFezZRqETzyInAgKerCWtt9OWJqdhAaB8NtXXe6exOiPHNYZzWXbauii5IermzCf8EbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729941586; c=relaxed/simple;
	bh=gp7zdFVsanefY7fC9Kqe7L5uGSIeL0Bf5zkyiXtdRsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y52mi7dCHB1g3mYSTCoRW9jsRFkK9r1I2BEugohfP3Lq7TL0NRxiUF1AdL6TbTnBG+Q6rnHfgEV96MvH07dW3Nb7nRicWTzIPqlcQPahV4NlTVYWgM/JUwE9GeLjLJ6Tjr+roPDOIMDowAh2oHtW9KRUKKWiOK4S6yZiTTzVtLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOhjQvwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FCAC4CEC6;
	Sat, 26 Oct 2024 11:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729941586;
	bh=gp7zdFVsanefY7fC9Kqe7L5uGSIeL0Bf5zkyiXtdRsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mOhjQvwmxC3gLs2ywtRSmCv/HqEpcsb2sO/mjkch315jnECHFfAFcR6t2G5axIvwv
	 3PPZtxKRVktpsV9L93cwrD/dM7dWSGqS1Ft9pF7IeVe1XKmPzaeUcH7BieQP47Qadl
	 mr8gMrxtXv87ckfcOYD5uzIKiMajpvwScZvJH9nOJAPMCX3VqA7c5hajy4VNU0KCxs
	 O/xxUVtUJCxe5vvkujX5v2sUr5g0K07Fum1IkZ+wdKSOHMI4c8onbISLI0QuPQbWVk
	 bkuH7stikxmlax0PNxj+/+XPo+XltYLMSefoki9EkqAqI4lYIeBwB4ifD1FYpHP1A/
	 hPnqiXO81osuQ==
Date: Sat, 26 Oct 2024 12:18:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 09/24] iio: accel: kxcjk-1013: Use local variable for
 regs
Message-ID: <20241026121859.13842dbc@jic23-huawei>
In-Reply-To: <20241024191200.229894-10-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-10-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:04:58 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use local variable for regs in preparatory of further cleaning up changes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.   A little less obviously a good idea than some such cases
but not a bad idea either...

