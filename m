Return-Path: <linux-iio+bounces-411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 561697F94E2
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 19:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA70B20D49
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 18:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0B911C93;
	Sun, 26 Nov 2023 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtaOsSCy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7A7E
	for <linux-iio@vger.kernel.org>; Sun, 26 Nov 2023 18:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904E7C433C7
	for <linux-iio@vger.kernel.org>; Sun, 26 Nov 2023 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701023816;
	bh=l/kinZyz7cTcUEwgdAShn/eYFWhPweoE4DYLhlKHdLc=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=LtaOsSCyWCVhb7gHF+zrJzmYIP3eMLM8AUvzqz5qgTC9ZdMue2VIP2myNob3Hl8fP
	 yW53X+L9Eyg6Pf4xd/AKQ1Movhrj65EQukc4XprKHhpJjr8p08eAbkCYmk/iIsPA8D
	 26FabDES/y9c79u0/7fEh0pUiHsGPl1oc29tZ6p2R47U/ZTQEs/I06QbRcFqcwqBmt
	 4byzwKKGdERqkNkFISpZyBoHV6TX4ZFbMGXxK5/69VMd+v36vA31EewWjhTJCZxzPu
	 hS4YQ7u6QVFOwMhJ3Ma79QNSSOBPhaPjzzLEti809+b9SX7tajaYPe0WOxU0yuNSN6
	 O2q8fpV6Lm01A==
Date: Sun, 26 Nov 2023 18:36:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Subject: Re: IIO: Playing catch up.
Message-ID: <20231126183650.08b98393@jic23-huawei>
In-Reply-To: <20231123190341.088b4951@jic23-huawei>
References: <20231123190044.4fb992f1@jic23-huawei>
	<20231123190341.088b4951@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 19:03:41 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 23 Nov 2023 19:00:44 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Hi all,
> > 
> > Unfortunately I didn't get nearly as much time to do normal reviews etc in the
> > last few weeks due to travel and resulting day job pile up.  I'll catch up, but might
> > take a little while yet before we get back to normal target (I aim for within 2 weeks of
> > posting.)  It's early in the cycle so hopefully this shouldn't delay anything
> > too much!
> > 
> > Jonathan
> > 
> > p.s. LPC was fun/mad. Was great to meet some new people f2f - apologies for my terrible
> > memory for names!  Thoroughly recommend attending LPC at least once (I believe it's
> > in Europe next year)
> >   
> 
> Forgot to say: Thanks to all those who do reviews for IIO, it particularly helps at
> times like this as well as often catching things I miss. Everyone looks at code differently,
> so the set of reviewers we have for IIO is wonderful!  More always welcome :)
> 
> Jonathan
> 

With exception of Nuno's new version of the backend framework I think I've caught up
(sigh - that was a pair of long sessions but nice to be moderately on top of things
again)  Bad luck Nuno, your work is too complex for a evening review! :)

However, a few emails when astray. I got all the patches via patchwork, but if anyone
posted an email that wasn't a patch and you think I'm ignoring you then please
send me a message to point it out, or just resend the message in general.

Thanks,

Jonathan

