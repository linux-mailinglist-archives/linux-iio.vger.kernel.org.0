Return-Path: <linux-iio+bounces-22872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5390B29455
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 19:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D7E2A2E4C
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 17:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7196D29E0FD;
	Sun, 17 Aug 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkbJVEIZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2E219F11B
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755450269; cv=none; b=F3Qt5lVzurB9gupSPT6lDLcCh9zxZaeW/LEO6syQwLf0maC8BDEzKYVqCyiiJUiw8LjR2wxLQ4jKRhZX2i93I9NxIJPLSFMl9GOu9/uoKcgMFEtk11SjtEpCrD1jPsAEnOdabF34YlF0TbQVCMsqx6qpjFXcrz4ZNyhO1DEdKNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755450269; c=relaxed/simple;
	bh=YxCOMMi1RErbeXeufBHfh7rfWyal4uP1VKW8rnu4i/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGaLwvk0/MD999QLVAVRftrXnUDS3FM4jE3XWYmdsqODXvFI/BDQnQbB0NSW+aNeWwO35GR2jaQQittDWdyT8jVUSUJAyz68q4ZAIMF0gGp+wZ/VCR72yK6rFB1+WYGGdY4xriD6lqDmMB60VBP2sJ9Bi9kNecK4OLe4WFq6jQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkbJVEIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763E0C4CEEB;
	Sun, 17 Aug 2025 17:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755450268;
	bh=YxCOMMi1RErbeXeufBHfh7rfWyal4uP1VKW8rnu4i/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BkbJVEIZ8b33ZiIlJQ5Gbh3vcF0Bu4AufWKgJ1SPa1HpZL4l1AFZ/gsEGxhbclGnk
	 VKu8bv8Au+IH/JshmVH8uaF2iIPrtvmdht7unOQ968cKlwq7PxD43DXf8AzhISijJT
	 828Mb5Cf+s1z/ryD3nnHhs82qo+0RLGLQFnES2iOtVQi42Ay2r6cRVBW1H3MDiUBmM
	 s12YLdVEQ0Ylj6ihhSV5pj07LTfFcaNcdaSMciFH9sCIzf2oVRgGo1ld1Hhvt/LsLa
	 We1N7QNg/VRKR7FZ5HzKQrUnkgkmVV4aRvRzfuFRW0uVeKu/YPEgEtXFwkE3Cb0lLo
	 DxRKZfhJUREhg==
Date: Sun, 17 Aug 2025 18:04:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v2 8/9] iio: pressure: bmp280: implement
 sampling_frequency calculation for BMx280
Message-ID: <20250817180421.1d9edb28@jic23-huawei>
In-Reply-To: <20250810185846.114355-9-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
	<20250810185846.114355-9-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Aug 2025 20:58:45 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> Report of the actual sampling frequency via sysfs is implemented based
> on the maximum measurement cycle time, depending on oversampling_ratio
> and t_standby settings.  If the device dependent table for the
> t_standby values is missing, the reported value is taken from the ODR
> table as before, which enables the support for the BMx[35]80 devices
> to be unchanged.

Ah. Ok. I was thinking you weren't handling the oversampling multiplication
but you do it in here. Great.  However without sampling_frequency_available
how is the user going to figure out what to set?  That will need to take
the oversampling ratios into account.

This driver seems to have the infrastructure for providing available attributes
but is it hooked up?  I can't find where info_mask_*_available is set for
any of the channels.  Maybe I'm missing something, but if not would be
good to fix that as part of your improvements.

otherwise this code looks fine to me.
> 
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>



