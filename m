Return-Path: <linux-iio+bounces-21037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0023AEC82B
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB2A1656BA
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C663C247282;
	Sat, 28 Jun 2025 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgbi/VKD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760EC1401C;
	Sat, 28 Jun 2025 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751123574; cv=none; b=qUoOxqDw2/JSTt15aoeLjGAWCDv3V73hmowF/Z5NBHzuynoUAf8v7cfo/aLyxud+EzNhELa12V8twO7lTGH5BziWhWL45+5nSS4/SuHi/NIprBNWr2qcJVpazGiXAYGdZS49uzWv1vOB/OEzd/ARxJeOGkVoCxt8JG0b7CaSwxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751123574; c=relaxed/simple;
	bh=Su952xlJaznvagA5q2zxyjauve2XziNZOY/9Q9A5gTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sq6M3zHj6dRnMORtI/Ko4jPdwyxGr/B2fP8m1mTx5ndDj9dd5XYlOrh7p+78JJ7WxqEQfYlCVsd2J42KFIUGE3HvAUfDpPU9teTzCjFkO6gzyk2R1MWeWlu/83kEQ3oTKtj+faFNW2H+kvuL2VkiTCfXx7FQJNZEltksQEK0OLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgbi/VKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C602FC4CEEA;
	Sat, 28 Jun 2025 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751123573;
	bh=Su952xlJaznvagA5q2zxyjauve2XziNZOY/9Q9A5gTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tgbi/VKDLUu4+JS4AHGA78v8TvfFjPHRMPitEKdY+yjNx7jKFUy4o5Wcazijzz2j0
	 5NVj0Fqy5k+lAeTJTsyG4kIOEKyvnKAoRTPe60JoKt8dfEGu4ABveZ78g4eYvasSIe
	 vbZIldflS67MZigHpHt/zUl4um5pQG73CYQgkAJaOD99MtRLFIjGWHS4Bnq0sDbJeo
	 90a5teY16rWrSnjm3miXNcTcB9Xo+FImqM2f3JjC4Za6HEow0gBnujsELJZ7PFEQ1i
	 zN9cLcWuxgmvF1AzBl9CLZCdE61kYLe602OAa1dev3NmlO9MfLVjiRgYskbgQdq3CY
	 lx6FSidkmnBSw==
Date: Sat, 28 Jun 2025 16:12:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Abdalla Ahmad <Abdalla.Ahmad@sesame.org.jo>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Gabriel Shahrouzi <gshahrouzi@gmail.com>,
 open list <linux-kernel@vger.kernel.org>, "open list:IIO SUBSYSTEM AND
 DRIVERS" <linux-iio@vger.kernel.org>, "open list:STAGING SUBSYSTEM"
 <linux-staging@lists.linux.dev>
Subject: Re: [PATCH] drivers: staging: iio: frequency: ad9832.h: Fixed TODO
 note.
Message-ID: <20250628161241.10ad84ef@jic23-huawei>
In-Reply-To: <364b2846-e299-4be5-aadf-0668445c715d@baylibre.com>
References: <20250627175114.548076-1-abdalla.ahmad@sesame.org.jo>
	<aF7kW6xRxRb0VN5H@smile.fi.intel.com>
	<AM9PR08MB6114261F0CA8CD89EC443E59A145A@AM9PR08MB6114.eurprd08.prod.outlook.com>
	<364b2846-e299-4be5-aadf-0668445c715d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 15:32:43 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/27/25 2:29 PM, Abdalla Ahmad wrote:
> > Hi  
> 
> ...
> 
> >   
> >> Ideally this should be dropped from any global header file. If one needs
> >> something like this, it can be propagated via software nodes.> Well, Including it in include/linux/iio/ made sense to me, would you please elaborate?  
> >   
> 
> No one uses platform data anymore. We use linux/properties.h instead to give
> named properties for this sort of thing. So the right thing to do would be to
> create a proper devicetree binding for the chip to define the properties and
> fix up the driver so that we can move it out of staging. Then the header file
> would just be deleted as part of these changes when we stop using platform
> data.
> 
> If you don't care about the driver and just want the TODO to go away, then
> we can just delete the comment since it is no longer applicable. It doesn't
> make sense to move the header out of staging without moving the rest of the
> driver out of staging at the same time.
> 

I think larger, better change would be to also delete the platform data definition
and the use of it in the driver.  I don't think the content needs to come
from firmware or board files.

Jonathan


