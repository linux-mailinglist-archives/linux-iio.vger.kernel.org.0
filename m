Return-Path: <linux-iio+bounces-17802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E793CA7F72C
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 10:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F409171B27
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 07:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14CC25F99E;
	Tue,  8 Apr 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrL/DcZG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836FF1FECDF;
	Tue,  8 Apr 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099176; cv=none; b=EFnOa1AbuyNYbCMlipSf0V2/+sOmLUnNZvx7AgPDCgPq+9VUKjgM+1BOiFVw4UOuafv9V6Xcmz6bshlM8zNm3qN/eFBAJmTYwlC55pchamx6SQPXVfZenILWmdzN24wpYmN+qDlGBLwlwzsxMkhThOyeKADBLUPtxzCATn+rS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099176; c=relaxed/simple;
	bh=R1ijQ3kBDcwUSWxv7wnlaXKC0PsJ0DHQs7sROgqv68Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teuExQ6mUPwv/svoDTyUs9jcJ1LXoptJr0b/rfP0bMGPSTg0aFyTSY8+0HbvLI1tmmSVWykX/0us7pso56XWYH2ZgxhWcvD2p2T+VQSPvpS/CAw8Rj4aZiEOiEWqWffBPlSmd8M65iTiFkAo9GpupqIOgPiulStZGTc5b79MwyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrL/DcZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C34C4CEE5;
	Tue,  8 Apr 2025 07:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744099176;
	bh=R1ijQ3kBDcwUSWxv7wnlaXKC0PsJ0DHQs7sROgqv68Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrL/DcZGiXsYQC9iWOpQpDoG5td307Qa2g9h4dWM/R7lIIAuedLdU+4Ex2AEgMKLT
	 2akDQJj2krbO/IU5Z8pU5IoN2VFX2ehKRfrCeDN9aTfpd2nBwnw6dhdSXmYs5I1A2O
	 EFQJDFiRQ/Q8acWP/OKnPbGf8VFAhwUKXJruyzgautJCK79gh7j1h7jfFDThLrcpeW
	 Tf4Y/qkPpYXJ98lylPGsvowXfmwVlxuhVU5JfqWpSimV1VrUFKf4R4h0oa886Ag22S
	 liZV/tcj0Lx3haXbLGkqNOQ27hNUTzy4FNc87wdY0iQkttC1dbPn4VG4F4Z4OyrQvy
	 iWb0+hhUEzEdw==
Date: Tue, 8 Apr 2025 07:59:33 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] iio: cros_ec_sensors: Flush when changing the FIFO
 timeout
Message-ID: <Z_TXZT3SPEpTm6tc@google.com>
References: <CAPUE2uuY=BaPFro5cQSmQg4JS1Z5J5aBL7XvqqAo-X=LR4be3Q@mail.gmail.com>
 <20250408055412.1623257-1-gwendal@chromium.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408055412.1623257-1-gwendal@chromium.org>

On Mon, Apr 07, 2025 at 10:54:11PM -0700, Gwendal Grignou wrote:
> @@ -853,6 +859,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  		st->param.sensor_odr.roundup = 1;
>  
>  		ret = cros_ec_motion_send_host_cmd(st, 0);
> +
> +		/* Flush the FIFO in case we are stopping a sensor.
> +		 * If the FIFO has just been emptied, pending samples will be
> +		 * stuck until new samples are available. It will not happen
> +		 * when all the sensors are stopped.
> +		 */
> +		if (ret >= 0 && frequency == 0) {

To disambiguate, `ret == 0` or `!ret`[1].

[1]: https://elixir.bootlin.com/linux/v6.13/source/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c#L411

