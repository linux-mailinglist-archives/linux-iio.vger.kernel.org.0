Return-Path: <linux-iio+bounces-24060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DE0B56189
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 16:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69456178484
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6782ED14B;
	Sat, 13 Sep 2025 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anmYAQUv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270EC15D1;
	Sat, 13 Sep 2025 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757773357; cv=none; b=noSbjTSXJHwPmXP4kYOWJFh16QkwNiIwu9S11bQSEy9rtWsZMejpCj96KjmQq83MZqtsn1MLZD5O+QNHuch76sGywHMmUJ8zboXRgIfrXTPDmm4mtKR7/K1xKZ7r6fhDtB5K6742Z9ZfBJZHKaq8AgFIz8vxdI4asp8L1t8Xy1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757773357; c=relaxed/simple;
	bh=6Gfymw1RGlr2gkjjiPGTAhQw51EEadX30Abe/CKJi7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6MpUPWn6YmsmJ7Wc0334NhFAj/AZOk36GwwR7+kTiI09AQRGuOwe3RUwDsR3ka/csJoigYAaC8IX1gSLq07Zza6KkjjUe/Js1cdtutbvy4OffWzuY/1Jcab46Him76YpstKMzHBch45RgOwts9FEEjPEWjmDXToQlgcMTrkbRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anmYAQUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A860BC4CEEB;
	Sat, 13 Sep 2025 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757773357;
	bh=6Gfymw1RGlr2gkjjiPGTAhQw51EEadX30Abe/CKJi7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=anmYAQUvRacARd/NsUpJvo7wAU+8ZAUUCyXSfsB/ozNEu8nXv2Df1IkdDQimM5vSO
	 7KlHuoz6TRIquavyXdClvg4H4PMpI2RH/Or65qIY4tDORIhDjfzTjz7bQ4yJSYgjhR
	 wmHz0NwhQ+z/mBM3OtWJ8JDx1B5QFbkdjxrvr2clInByOhNDq9g9ckwTZ3SsvmO5A8
	 T3oo8XYQewkNDNVXzvjGjx1qj3CnJZCGdwPcbASt+HZS2YSMNdmjw3MqmiuYavcBrP
	 IuofwYzm4itimRhxtjcgVizYyp7HghWJE4ROPxDdJkEyC3YDLTPwQ9J9EAjUCJeFZH
	 8zGv7PTgix/8w==
Date: Sat, 13 Sep 2025 15:22:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Salah Triki <salah.triki@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, Markus.Elfring@web.de
Subject: Re: [PATCH v4 2/3] iio: pressure: bmp280: Remove noisy dev_info()
Message-ID: <20250913152228.2e87fe7a@jic23-huawei>
In-Reply-To: <aKXgh-gBs6r1zPY-@smile.fi.intel.com>
References: <20250818092740.545379-1-salah.triki@gmail.com>
	<20250818092740.545379-3-salah.triki@gmail.com>
	<aKXgh-gBs6r1zPY-@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 17:49:43 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Aug 18, 2025 at 10:27:31AM +0100, Salah Triki wrote:
> > Remove `dev_info()` call as it was considered noisy and is not
> > necessary for normal driver operation.  
> 
> I agree with this.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Applied. Thanks

