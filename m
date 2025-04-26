Return-Path: <linux-iio+bounces-18706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED73A9DBD9
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 17:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB081924432
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3ED200BB8;
	Sat, 26 Apr 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swrUppKf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4873D3B8
	for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745681600; cv=none; b=hw+gWU39s+gYIkOfkGblNChPtLI68tgnD6mGwUKk3j172QrPJbAXJyuH6DCo193M8OAvKxhc2xuBukk0duc9jQiIKN5zTwKu49gGq5vR3akJzF0uIpnATzYVbjgNVDb2NJ4B4BNqtzDtEskkQStArjKrtmvPgy8Ehc7sdzefVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745681600; c=relaxed/simple;
	bh=UMMZoJa5sTAnUqqbqT/XuPn3/PzGzQRr3EjLm2cHbSc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROajgHHIMkg9ErCGi2YR4nfFeloJ7cfpNQ25FzC9UASuJduPEc+elHxeSEaeThEnNkHHk1D5gY685tVUW99CFAvRUHZsyt+JzoNujQqfd/Udc9pI3SVZLP1rKlLHXt+5IyQ2bvVHBMr6ddDa+KK2rPgHqBiIoXn5SqX5gGvYBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swrUppKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2759AC4CEE2;
	Sat, 26 Apr 2025 15:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745681597;
	bh=UMMZoJa5sTAnUqqbqT/XuPn3/PzGzQRr3EjLm2cHbSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=swrUppKfFcBuqkYRYBFUN6TFRPiJjfHZdKTowCso3oi3eoay2NX860P+XLw6fhPv5
	 UwcP2i7HC6KWPJPfgy+SFrZk3W5aF9TQDcVmecuTfycDNE9QymVWHJ3kHBcsqOrUdg
	 BlJI9iCCycxGRZEW8Ay3OLV6iuOnLo1s+LZCko6v90XnFOW6S81ZHzEzAH7ECET3ip
	 eegXb0pMCZRIXGStK6cgxXxznNjW84mnWDQuUkmDV/1ZBiJ5tAMQfzHnONGanyUZhY
	 NdO2NG6k9HtcUI5JhBchtJAFOwPQqltLalx93eUoH+MUl35dXHCRTfHF+oeulpOqD7
	 2nWCcIR9ng0sA==
Date: Sat, 26 Apr 2025 16:33:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Arthur Pilone <art.pilone@gmail.com>, marcelo.schmitt@analog.com,
 linux-iio@vger.kernel.org, bruno.stephan@usp.br, aschwarz@usp.br
Subject: Re: [PATCH v3] iio: adc: ad7091r-base: Remove duplicate code on
 volatile reg check
Message-ID: <20250426163311.546500bc@jic23-huawei>
In-Reply-To: <aAb2WYSkhE3xWqAv@debian-BULLSEYE-live-builder-AMD64>
References: <20250421145534.91146-1-arthurpilone@usp.br>
	<aAb2WYSkhE3xWqAv@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 22:52:25 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hello Arthur et. al.
> 
> This version looks good to me.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> On 04/21, Arthur Pilone wrote:
> > From: Arthur Pilone <art.pilone@gmail.com>
> > 
> > Both ad7091r_writeable_reg() and ad7091r_volatile_reg() perform the
> > same test, checking whether a given 'reg' code is
> > AD7091R_REG_RESULT or AD7091R_REG_ALERT. As the volatile ad7091r
> > registers happen to be the only read-only ones, the volatile_reg()
> > function now returns the negated output of writeable_reg().
> > 
> > Co-developed-by: Bruno Stephan <bruno.stephan@usp.br>
> > Signed-off-by: Bruno Stephan <bruno.stephan@usp.br>
> > Co-developed-by: Andre de Lima <aschwarz@usp.br>
> > Signed-off-by: Andre de Lima <aschwarz@usp.br>
> > Signed-off-by: Arthur Pilone <art.pilone@gmail.com>  

Applied.

