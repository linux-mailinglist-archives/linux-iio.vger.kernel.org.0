Return-Path: <linux-iio+bounces-21118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CFAAECEDA
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430C33AF772
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5B322127E;
	Sun, 29 Jun 2025 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1eIhv4H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BEE49641;
	Sun, 29 Jun 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751216627; cv=none; b=HM8chCVlA14J67/zhqG5BDPX1byaT41oO1l4wFdKSiG5YCBiwHEdCJtaQluXg8nrEy+AIsS7cesU6R9WVOpVOTC4WlEjjVvPjx0xC/IO55tOcpHbgs9yeSYgx6PzKc4qMkV3peHA2Y5a1W4ipCBRYo8B67MgvJKBZo41Ewxlt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751216627; c=relaxed/simple;
	bh=sIPB2T0+LyQdpNZAPueooEFja4U9jb6/KMVgSiLYBsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1RNuVr8QGQS9Wzx6vuxq2y5lZ3jYoRjj1TSKG8XHKH2kya8GJh0RHQYAJ/QTNPsOYrb9VAtDUfUqGND3sCoSvm1+59irbxlC23HFvpyP51dyk/+3v+BL3jAytvAkJ0AQz090RxK+tMRiv4axJmEOle85x87vQGFB3hmPuAzcw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1eIhv4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563AFC4CEEB;
	Sun, 29 Jun 2025 17:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751216627;
	bh=sIPB2T0+LyQdpNZAPueooEFja4U9jb6/KMVgSiLYBsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R1eIhv4Hpr0tl7f4ubuCUWu7jriXCLbuivImMgw3wwpJeLRJXsxyLiunW1J7pw4tH
	 baUx0nbEauQC285B59RPZk9qw5VrcpHsZix+a80A8uaEDA0vU6BpAioxPK/lF8ezga
	 Swu2GDWe60+0KGe1Zpm1b4a72WG5Luebp6Exrx/I1wzQt8R3JkCPKgAd/TNhafFAu9
	 JMCxym5TVguxPpN0Fex1niGfj75wrmoyCVequXPlZ7z31pqDqwFzF46gm0yYAxiXHL
	 +XkM5V0GG6F0xYmrcbK0edIZE2VAQPNPMLbpRRSecgaqS5qSmAV89oVwBBO6CAfDQ9
	 uFG7RIL6eOXCw==
Date: Sun, 29 Jun 2025 18:03:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: amplifiers: ad8366: make ad8366_info const
Message-ID: <20250629180339.760c189f@jic23-huawei>
In-Reply-To: <871eafac-f643-410b-b201-681551075a2c@baylibre.com>
References: <20250628-iio-const-data-12-v1-1-88029e48a26b@baylibre.com>
	<871eafac-f643-410b-b201-681551075a2c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 12:05:03 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/28/25 12:01 PM, David Lechner wrote:
> > Add const qualifier to struct ad8366_info ad8366_infos[]. This
> > is read-only data so it can be made const.
> > 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > I looked into dropping use of the chip info array in this one, but
> > removing it isn't trivial. There are several switch statements that
> > are using the chip ID still. So we'll save that for another day.
> > ---
> >  drivers/iio/amplifiers/ad8366.c | 6 +++---  
> 
> Replying with the correct subject. I missed updating the prefix
> from a copied commit message.
> 
> Should be `iio: amplifiers: ad8366:`
Fixed up and applied to the testing branch of iio.git on the
perhaps foolish basis "it's obviously correct" :)

> 
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >   
> 


