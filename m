Return-Path: <linux-iio+bounces-21033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1FFAEC815
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399763BD062
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323B207A27;
	Sat, 28 Jun 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcP8qKBl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA414883F;
	Sat, 28 Jun 2025 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122989; cv=none; b=eRIfeDmoD3pAiJ3FJuN9NVgGCCKXXN3W3oY3EKajYlqAl5Fgx+kyUbk6MKTrlgH1vGsIvjI5JLDkojYm58zdH+PPCcRRYLCik3dh8F/qzHNoL0SmaytK7hdxoVQ/cHyNpcTMrRHPMv9Ll7hoaioPU5bJLfTRa1HNyR+r73hDzjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122989; c=relaxed/simple;
	bh=49Z90gaj+g5BDJ6o8+zUrcbyGbY6NcvXSKTAvmPRkiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P09vnBSCukhoFgvkVs//mbRYiySqzCrmvLECQAIljFyuQwl3ZJ+r3AWLNR0A7vPb8+P+suULivwa68W00h2oK52fvl5PhcrzC+whGChbk0arSN/kImwZh1k8hSF+rqj/hbtZIhfwwgoYos0DrcU9LgyToULMv5M89H7ouAg628I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcP8qKBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72C2C4CEEA;
	Sat, 28 Jun 2025 15:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751122989;
	bh=49Z90gaj+g5BDJ6o8+zUrcbyGbY6NcvXSKTAvmPRkiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TcP8qKBl0QN9xukw1rAnIRDLNNKa08EYv3r9OeAvlreUGTNcj8L5gZ5GztLklB3/y
	 4xkZY7kuMgmc4iWkWCOH+wOtrJCWqx5LjObu00tUa74SIO1UU7ae9p0SQ8a3cY1GDX
	 +XRFS9O6C2+/JwoEpTvcdmmRsjqECYJ04n3gjNiVCj6qN3AgxEYE2E03AkGGFYd8r7
	 RjF1LFrQPMrO9xAuKxKb/PhM1PkFYaO3HQvxpQkPf73b2+RAk1isItPhd6vjz0V0Yr
	 xHZaR4iwdpkS7SysWGdcF6QYtUdNMEhMIcBnv51s03SFBFxQFceEfarrd799cGNbkh
	 pRliBM9dLbAkA==
Date: Sat, 28 Jun 2025 16:02:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 09/11] spi: offload trigger: add ADI Util Sigma-Delta
 SPI driver
Message-ID: <20250628160259.6f220dfd@jic23-huawei>
In-Reply-To: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-9-f49c55599113@baylibre.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
	<20250627-iio-adc-ad7173-add-spi-offload-support-v2-9-f49c55599113@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 18:40:05 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add a new driver for the ADI Util Sigma-Delta SPI FPGA IP core.
> 
> This is used to trigger a SPI offload based on a RDY signal from an ADC
> while masking out other signals on the same line.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Hi David, Mark,

This looks fine to me and I'm not immediately spotting any
build requirements to mean this (and binding in previous patch)
need to go through IIO with the rest of the series? Shall I leave
this for Mark to pick up through the SPI tree if he is happy with it?

I'm happy with the rest of the series, but won't pick it up for
a little while to give Andy (+ anyone else who wishes to) time to
take a look at v2.

Thanks,

Jonathan



