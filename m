Return-Path: <linux-iio+bounces-23838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA720B47A55
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593A3178ED0
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66CD23A9AD;
	Sun,  7 Sep 2025 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys4uTu9S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4891B6CE9;
	Sun,  7 Sep 2025 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239506; cv=none; b=slpwIOMtEtGh6NZwJndPHGy8LEdoTJ1Od7SAXO0++uoi+pyx/cl3BcsP0FOlF54itFrsXspk5QGAhbJVzgOK3vmtzTGM0cWMSkrOAGMEcXnNnFl+rkSiNP19+heCjwiEQVUy6Q2gCCDTthHDC+CthsalKAEQhmMrp0OvRDOs7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239506; c=relaxed/simple;
	bh=qN1bMbjPIKjQztmATX5G66xrqLywtKklcCkbYmIW1rY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlxCO9nonirTgrMR8DFAL23SVjEg3kwDhauJZ6w5zvjtJ2YXclP9ZjiqRjmU0sQME/ojicwrsUaGaT6lt8AK4f/m0qN94dZ10CHf7ImsHy/r+7eRotKYFi3KR4leREFBwSoexbAg/kVUEUq2t3pv7yTU1BnPaJmAqQIwf35GIkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys4uTu9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AE4C4CEF0;
	Sun,  7 Sep 2025 10:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757239506;
	bh=qN1bMbjPIKjQztmATX5G66xrqLywtKklcCkbYmIW1rY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ys4uTu9Sk7oV1BlMag6Ugqx2wHnThKOwtqyG+Zlf9gmB3qYUWmco4Orfci8G8A/fL
	 KJVx8G7moBXtk5TuWdx7FnlxKSxCsjuX3zA7LZOvI0rUD75wl81IB6w4vL5B4W8XqZ
	 mbqoyyEnRx42n1a/oFWJQPkvz+Q/KEnIO+RCHDCLRVSukKwvcgbSdHYAuaOBGYwhVt
	 GmCVGZQ9dL6we8TVSUIV7Kg22TjgH3/Nl6iAnHEWDp9TH4fGYW2Zly+gaCIwP6bds6
	 WMNafvyIz9hNEybBZUaN1B6wc9E3cpEDDhSNkcACq65YBz1pl8vLNI66T6/V3NbjW4
	 L4eurocFbChzg==
Date: Sun, 7 Sep 2025 11:04:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: adc: ad7124: use read_avail() for
 scale_available
Message-ID: <20250907110458.2a14d07a@jic23-huawei>
In-Reply-To: <20250905-iio-adc-ad7124-add-filter-support-v1-2-aee3834be6a9@baylibre.com>
References: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
	<20250905-iio-adc-ad7124-add-filter-support-v1-2-aee3834be6a9@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Sep 2025 13:11:57 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Replace custom attribute with the standard IIO read_avail() callback
> to provide in_voltage_scale_available attribute.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Another (hopefully) uncontroversial improvement.

Applied.

