Return-Path: <linux-iio+bounces-6292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E7F909819
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 14:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE44028218C
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1135433C1;
	Sat, 15 Jun 2024 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI/Tb/Y/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0222318;
	Sat, 15 Jun 2024 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718453347; cv=none; b=LNsfea05nZn2ar9RcZrEd79R6KtYJBDtWjWmm2P9iNkuDPppUW/ia4Cv/o/rdE+ia13KbcoWPKTSZY34x5EQ02nG0q5cIf3itHYC8FkUnK5fx6g4UnKQ5X9Xmk5iIRbc5B2ogihytJIiR3iZeX2HqNqiO2GJl4iAB/H6VgTx3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718453347; c=relaxed/simple;
	bh=o9CKb0p04y3vdHKYxcqijUw8AEgxUBS8t9UOrGfPG2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxJDgkp4wWeW1u0BnyIAv5lecHqA6uiCJcQNfFwWttlodFXGgqoI+dotUAz8+er2eqN9TpylSf2O2aITPJlSsuTsKPTjzFXLtcvc0iVhgH3SpSc9YrTDsj906dD0XmASZNft3qoDG9BYiLWS8WXvFCyCNRghr+esWAkJMJm1hbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI/Tb/Y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744D1C116B1;
	Sat, 15 Jun 2024 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718453347;
	bh=o9CKb0p04y3vdHKYxcqijUw8AEgxUBS8t9UOrGfPG2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MI/Tb/Y/EjaM2jZGyACCm0aM6Sza+JV1dNmxrjLLZPP1f7BpaPfps11NuXY6lV26T
	 +M3/99Rzg4DkQSTRZQWgZigOqqmrwGl1SsRGNtW9EADj/g0Gtq0vBmCCwC2dYfee8G
	 XQ8NuXLzp1KmPIwsTKp2qqQTgdpvRW7+T3uvmW5I4KFPS1OMWKi7EAw+YFHvDmLJ/O
	 ax+3Rrd27EoHBQnctd3+JY8GLxgCv67NivkgX+QIKYkvnrQ3ezNxqhWgg58d5S3HNj
	 uL9eUMVtfSt9dD8hIdoP81AUFy+J6dNyiqNBOkgh/iYZRqj5t7htqTbac4W7W4dL7D
	 UH3dotCoqhOdA==
Date: Sat, 15 Jun 2024 13:08:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Alisa-Dariana
 Roman <alisadariana@gmail.com>
Subject: Re: [PATCH v2 1/5] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
Message-ID: <20240615130858.22043725@jic23-huawei>
In-Reply-To: <20240612-iio-adc-ref-supply-refactor-v2-1-fa622e7354e9@baylibre.com>
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
	<20240612-iio-adc-ref-supply-refactor-v2-1-fa622e7354e9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 16:03:05 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This makes use of the new devm_regulator_get_enable_read_voltage()
> function to reduce boilerplate code.
> 
> Error messages have changed slightly since there are now fewer places
> where we print an error. The rest of the logic of selecting which
> supply to use as the reference voltage remains the same.
> 
> Also 1000 is replaced by MILLI in a few places for consistency.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Complicated bit of code, but seems correct.
However, it crossed with Alisa-Dariana switching adding a
struct device *dev = &spi->dev to probe() that I picked up earlier
today.

I could unwind that but given Alisa-Dariana has a number of
other patches on this driver in flight, I'd like the two of you
to work out the best resolution between you.  Maybe easiest option
is that Alisa-Dariana sends this a first patch of the next
series I should pick up.

Thanks,

Jonathan

