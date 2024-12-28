Return-Path: <linux-iio+bounces-13845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A879FDB96
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 16:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9081882247
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504E7192B74;
	Sat, 28 Dec 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boYnegt7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE019067A;
	Sat, 28 Dec 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735400835; cv=none; b=CDi5PBNlcHW2sJU/EeVPgVNL9Cr1uqYq5iH9JZA9QXSfm8ULdfwBzUq/ebQapdT3rCCnCbRFGOY57PYHXu3fNcN/bS/6ogxXNnkZaULP84yLniJai1DJxUhOxZFnQOBG9T2iBc2L95j8NGFG6H+jSwzNcT/ovo65uW/g6v5uAt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735400835; c=relaxed/simple;
	bh=NgZyQSWlK67EWvdYeIZNjQFg4glesvMR6K5qEIeNMUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGxnMO7fStjL+YXiDaEPz8GK4VOtijjdNww1VQM3cEhc2r/4sN+0A0iLJsTqdOrKeJI+YjWlRbbWOsaafNjwde2AT6fW3fTxd+xcTTkSa1vkrfO6h+UrRHkNg+Ushxf9C70WQXims9qzSCFVYuF7Rrb8hOZUZsdla9lACoPCqHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boYnegt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC65C4CECD;
	Sat, 28 Dec 2024 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735400834;
	bh=NgZyQSWlK67EWvdYeIZNjQFg4glesvMR6K5qEIeNMUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=boYnegt7IXmvO8IZTotXG+GeWHybfXlzmm5WHicDZdpakwk1KR9QlknE6yGhg1W7D
	 0r4ALsdxYsasnXdQjW6eaaRn0pRlAHSItdedu1bjFeFaRapbc1Gfh3t/4dMWkKTsH2
	 TmjQjExKVdWObJck7mN+A3EeFOEHZUeO1Ohl9Qc4HCPPbPsLMfftuH704lXWlHFTd+
	 JCfL0UDrIQDi8z9t45QcPh6sLLewiivS2B5CL6qlMqqaAFT1YfRZM4JJP6AIwhePWO
	 ftNoLMyYbP49UYvSrBot2i1B7fzRR/Sggl6mfJ8RVybT/27zWD0QUU/sLMK2GkCUgS
	 WwpjiIr3XIgRg==
Date: Sat, 28 Dec 2024 15:47:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 4/4] iio: veml3235: fix scale to conform to ABI
Message-ID: <20241228154708.1dc501cd@jic23-huawei>
In-Reply-To: <20241224-veml3235_scale-v2-4-2e1286846c77@gmail.com>
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
	<20241224-veml3235_scale-v2-4-2e1286846c77@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Dec 2024 11:59:03 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The current scale is not ABI-compliant as it is just the sensor gain
> instead of the value that acts as a multiplier to be applied to the raw
> value (there is no offset).
> 
> Use the iio-gts helpers to obtain the proper scale values according to
> the gain and integration time to match the resolution tables from the
> datasheet. When at it, use 'scale' instead of 'gain' consistently for
> the get/set functions to avoid misunderstandings.
> 
> Fixes: c5a23f80c164 ("iio: light: add support for veml3235")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Hi Javier,

To me this looks fine, but I'd like Matti to take another quick
look at this and patch 1 if time allows given Matti is a lot more
familiar with the GTS helpers than I am.

Jonathan

