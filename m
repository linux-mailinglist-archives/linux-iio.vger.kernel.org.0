Return-Path: <linux-iio+bounces-23867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 903F8B47B9B
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 15:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D90189B7D1
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FF027055D;
	Sun,  7 Sep 2025 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZLaP7l2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B520CCDC;
	Sun,  7 Sep 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757251773; cv=none; b=ItDOen7voeV6sqeFJApPKyoDWHhF7CxBvSKG+Fi8rXrjIXPYJDFNG2F/9BlhtWZ+Fp4YX/qbqzH++d9qMTJidRGhXhJnmkmeDxItz5NerM4cyglq+Kfn268CmFxdL+JmXhSk1xlgipbv60/AXlw80SKsawLU0P1jzXrA2g0vhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757251773; c=relaxed/simple;
	bh=d9tdFYgIP2/VvzU/D9UnbyBeGXtxyN37GfOZZ6KJQjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UX2qvDu21FT8PREjhlysCsu9O4Lw7Y3ezZ60m6oCV67M5vp1y1dO17a0uCahpYhcA6sOSYgG9Eo5VUJ7uSoNUE2i+LiAGEVMSZPoCNJkHZ6YC+rFEt2OECN5FTGC+/wStn3UQzJkyJTwcumeg+BdieMgH/ihf4E15nck/DBSYVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZLaP7l2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28BCC4CEF0;
	Sun,  7 Sep 2025 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757251773;
	bh=d9tdFYgIP2/VvzU/D9UnbyBeGXtxyN37GfOZZ6KJQjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mZLaP7l22b9VaIM/rHGh9sZwuYK9cEO929lPvkVrvipmMR0E938U7d2b+1KkGkHCy
	 xcaBbzWXy0a/9+p/3b8GRZ8wSIuwwJCLuJ3zRkMZBQvg5xMWeDFk97Pw2nh5r7TpBk
	 usMf6Q4S+q+oVzgUNbuwBD0ShuNOc7eAaBQer3a0kMiSUEXdu+tv9D0ZNXbLNFNXfq
	 QcTG9iB2Uz80r3D805+oJn4dxTdPmbm0ioopze93+OlJKsiXYtiKJwyWoJsJMYvP1s
	 f5Wbu59wBUCA0baTJNsZqd8JVq/DC8Pwd8AkWAYSNby5EMWJ1wz8ngkcEHhXn3QP8W
	 EqIDaZXpbblCw==
Date: Sun, 7 Sep 2025 14:29:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: mb1232: use stack allocated scan struct
Message-ID: <20250907142925.6008a5cc@jic23-huawei>
In-Reply-To: <fb550af2-37e0-40f2-a44b-52962337cea5@baylibre.com>
References: <20250722-iio-proximity-mb1232-use-stack-allocated-scan-struct-v1-1-b4ef77e9ddea@baylibre.com>
	<20250724112628.565aac47@jic23-huawei>
	<fb550af2-37e0-40f2-a44b-52962337cea5@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Sep 2025 14:12:49 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/24/25 5:26 AM, Jonathan Cameron wrote:
> > On Tue, 22 Jul 2025 17:39:17 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> Use a stack allocated struct for the scan data instead of using the
> >> driver state to store the struct. The scan data is not used outside of
> >> the interrupt handler function so the struct does not need to exist
> >> outside of that scope.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>  
> > Hi David,
> > 
> > Applied to the testing branch of iio.git.
> > 
> > I don't suppose you fancy a follow up to take that irqnr local to probe?
> > If not I'll get to it at some point maybe.
> >   
> It is also used in mb1232_read_distance(), so this wouldn't be trivial.

Ah. I'd missed that.  Agreed that it doesn't makes sense to make it
local.

J

