Return-Path: <linux-iio+bounces-305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0466D7F66DA
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 20:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9925AB21273
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 19:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6203FE37;
	Thu, 23 Nov 2023 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbrrZ5cS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BADD4AF71
	for <linux-iio@vger.kernel.org>; Thu, 23 Nov 2023 19:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B9BC433CA
	for <linux-iio@vger.kernel.org>; Thu, 23 Nov 2023 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700766225;
	bh=bO6e/A+UV5VCpsW0QjTBixtEMCUzvhdhNajnL+3LKH0=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=RbrrZ5cScYCuynPZeKstnfACNEhz3hupyqLaYs4BhGSXb+GiQrfR9PuQP+xygSxQb
	 vCjKhxg4hCCR8p6Lti52u4oqVOBPn/5OMX4xY8pk/YLlLOq4Kr2tnRdc0sDKCbehZs
	 fiWe3Olg+O5Zpb+n3W/atp+UTWUdbEL0mC7Idx1RmDAVPQIEajxexdJep+Sy0b9hnE
	 nbO8ZstUkubMywP8dWyCL8RJJIWEKsg5eW6UZNPCyuXvQStcwWSaoYRtrrYI2P81XW
	 lIVx6gw+bjxYCO2FxW6SliV7V7UJevKPk/FTn4pMuVkGfSnS96m11gxpLcRw6di09P
	 gv6zLd6SFYRUg==
Date: Thu, 23 Nov 2023 19:03:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Subject: Re: IIO: Playing catch up.
Message-ID: <20231123190341.088b4951@jic23-huawei>
In-Reply-To: <20231123190044.4fb992f1@jic23-huawei>
References: <20231123190044.4fb992f1@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 19:00:44 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> Hi all,
> 
> Unfortunately I didn't get nearly as much time to do normal reviews etc in the
> last few weeks due to travel and resulting day job pile up.  I'll catch up, but might
> take a little while yet before we get back to normal target (I aim for within 2 weeks of
> posting.)  It's early in the cycle so hopefully this shouldn't delay anything
> too much!
> 
> Jonathan
> 
> p.s. LPC was fun/mad. Was great to meet some new people f2f - apologies for my terrible
> memory for names!  Thoroughly recommend attending LPC at least once (I believe it's
> in Europe next year)
> 

Forgot to say: Thanks to all those who do reviews for IIO, it particularly helps at
times like this as well as often catching things I miss. Everyone looks at code differently,
so the set of reviewers we have for IIO is wonderful!  More always welcome :)

Jonathan

