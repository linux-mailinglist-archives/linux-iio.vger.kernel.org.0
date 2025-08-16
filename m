Return-Path: <linux-iio+bounces-22839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E4BB28EAF
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067A8AC177A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4776D2F1FCA;
	Sat, 16 Aug 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra90sPxo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF62EBB96
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356322; cv=none; b=NLOqvDelU2vqg2YGwZzHXjEUbe38Kh24+p/TO/O2mPFhLruXvINhKp/rf8xRNYoMgnvsDqHCOyiXlJk4e12mOpnz7Eu/X/4trL2xDBKHwpdyXTzyVF9m2zuxz2O5RdoSUg5LzUAcAOUxiUKCUJqPJ0Godf8uRIL2C7mlr3Y6c1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356322; c=relaxed/simple;
	bh=cVTh1JjPx+Id3qfpgH7Z0AItjuUep9Lx/Dcf+518hfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAOuc3qMWNkC8a3VHLCoLXw3QH/+6f1a3sVAe5IcXm+Xnd59ZrVTOf0EeejeEcsey1d+mhfMuU9LhUjhPyIi+YnBls69niid0nq5/yedlZEb/h1JQ9P1AdZXkKGG+t6ctJadEuQFk3cCah/T6HIEdWUrBiOvV1Ur+X5Bb4Wnnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra90sPxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1076EC4CEF1;
	Sat, 16 Aug 2025 14:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755356321;
	bh=cVTh1JjPx+Id3qfpgH7Z0AItjuUep9Lx/Dcf+518hfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ra90sPxoeMpThtW5GzE5dFBh8Qg2svIpWUg3hPiVdy8TbCk9n5xQmmQkRRwMMr0za
	 sJIRewCnrbciV3upziayN8jrp2XdnjuBkddLeBk5jmPdJP7AdwNkvd2X0nnzB80VbR
	 RUtYHZ3Q0QWVDyKPiWSuTw/K1Q+hEFpSrpmztk9wnMXgMTi3v/TIu+5PnkOBF3xZez
	 hG5tGE+njMONVawu/hyc6w1U0/+kJueG8x8sa4PZ2UeaaQcBfw/kf6bPY8twOomeXj
	 3owFPGvlY8jy7v8bn/T6Uouww299rIlpKp1a8OAheSqqHHKsRgGvf8cW1HC3p305e3
	 aRbNUM92IOHMA==
Date: Sat, 16 Aug 2025 15:58:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>, =?UTF-8?B?TcOlcnRlbg==?= Lindahl
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 13/16] iio: light: tcs3472: Use
 iio_push_to_buffers_with_ts() to allow source size runtime check
Message-ID: <20250816155831.2ef3dc7e@jic23-huawei>
In-Reply-To: <20250802164436.515988-14-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
	<20250802164436.515988-14-jic23@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Aug 2025 17:44:33 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Also move the structure used as the source to the stack as it is only 16
> bytes and not the target of an DMA or similar.
Applied. Description tweaked similar to earlier patches.

