Return-Path: <linux-iio+bounces-7386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A33C92938E
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 14:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6904D1C20F7E
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A76584E1C;
	Sat,  6 Jul 2024 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kMtAaZ3r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C37D3FB;
	Sat,  6 Jul 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720268974; cv=none; b=UBGzQUPctD6fobp27DJ+QLw+DDl3UadjIk5ap8HWTOgMYvfO01O8f3u+DJDtTCImYJ4kRPW3d3Wy4xhdi6lbuGamjgjRElAGlKbkyXb0WdZC2XeDxXQ3cJn/EdVRzjR3Ccs0heIDKS2ncVPF7z5lS2+l9UapzDb60FAhuWWeexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720268974; c=relaxed/simple;
	bh=a4hr+lF5lsa4T4pmwO8qJMekpIUAmRcbcuxqF7sAq9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUSK6kyXvcjqRRvQuHQmxor0cUiAFmeN+SD0BpqnNOVtY41q1zsgxeo4xyy8JvWil6dLQW3j4tPBMsyJ2sVB6FEyraBmxuVH6we+LEemyAtMvXDUXHqxONy5v+8cUN3iIHyToeVrfdtBA7aDevqNWC/6iJ1mlwx9bmCS3VUHpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kMtAaZ3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44313C2BD10;
	Sat,  6 Jul 2024 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720268974;
	bh=a4hr+lF5lsa4T4pmwO8qJMekpIUAmRcbcuxqF7sAq9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMtAaZ3rW/sxE4lcqDb92weUGcjRRAQEKY8otuHoXIER2jg/W7KDYffFwIcUKoDIa
	 oyErOKmSTuco6IiVOVg+msVbbSBIe21TTjDS39Ep5P5g5qQ5Bg95kyVBC+3K+8GanD
	 Sr89VWLp1l0l8ewB6Z1wLRppVY8MVdut7nA7t/O0=
Date: Sat, 6 Jul 2024 08:29:28 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Guillaume Stols <gstols@baylibre.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, jstephan@baylibre.com, dlechner@baylibre.com, 
	Conor Dooley <conor.dooley@microchip.com>, tools@kernel.org
Subject: Re: [PATCH v3 0/8] iio: adc: ad7606: Improvements
Message-ID: <20240706-funny-flamingo-of-temperance-9d1e85@lemur>
References: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
 <20240706131549.1f94449c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240706131549.1f94449c@jic23-huawei>

On Sat, Jul 06, 2024 at 01:15:49PM GMT, Jonathan Cameron wrote:
> This series is blowing up with b4, in that it is finding tags that were
> not given and I can't work out why.
> 
> Tried various options but even a simple b4 am -l 20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com
> Is merrily finding tags that I can find no record of.

I can't replicate this, so something else is going on. Can you try:

    b4 --no-cache am -l 20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com

In either case, I want to see the output of:

    b4 -d am -l 20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com 2>/tmp/b4-debug

-K

