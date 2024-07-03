Return-Path: <linux-iio+bounces-7254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB61926336
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 16:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFD31F22EB8
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 14:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F241EA90;
	Wed,  3 Jul 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SJkfehJP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D4E1DFE1
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016253; cv=none; b=sbO2I7ZR5jtU8BaFmeQ1q4r/S1gX2OycVTy422U1A60u+ubSNd1ITfmYS04Rchr9skpyVrWcWNHa5BjUnm/1Qv+knIv9UoRT44UCIodllr3PsDOAjMIpm7PDOy76dWGsuhptDa1acEOKOQ8jrEl6tJvBywIoB4thZo9g5PUn72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016253; c=relaxed/simple;
	bh=LDomTYEyYxkL5hI457GSwuePhbxFnQ800N3TOqtzBDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+E+c+8or2TaMSHeQ9/lvX8uoTgJNVB7fvwM1Gxd8h3Xdef9/1qO1MiFDT/x8icOqsDKQ8kj5yBBAIJtysrubSfguWaFgmFNdxMianC3hOyR9Jx1Kfv43XwP+dFe1mt15uQ6xbYiAYg6kjKaKqEihw2yF9GOtmlEG61TfnD1Iw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SJkfehJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A35C2BD10;
	Wed,  3 Jul 2024 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720016252;
	bh=LDomTYEyYxkL5hI457GSwuePhbxFnQ800N3TOqtzBDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJkfehJPgPXCaQ+shKOVrt090hraODYUjMt/voAsbO5S2YNcSDYN14ue9lIu7kpcK
	 nBS843JNRnnQ5xlU3mGs67vBEovRt5ZrW5WEIASm3Vr++ezrBzIAkW+rnTC8SjGgQy
	 3tJa1g/IZqZXf2+oWZfAkaICbT8GLuJAxSXfEFDo=
Date: Wed, 3 Jul 2024 16:17:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 3rd set of fixes for the 6.10 cycle (or for 6.11
 merge window)
Message-ID: <2024070318-unrest-mutate-db67@gregkh>
References: <20240702083511.1197a537@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702083511.1197a537@jic23-huawei>

On Tue, Jul 02, 2024 at 08:35:11AM +0100, Jonathan Cameron wrote:
> The following changes since commit 8fe050e94daeb0280338d04ff8c6207dea44ddfc:
> 
>   Merge tag 'iio-fixes-for-6.10b' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2024-06-17 20:01:23 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.10c

Pulled and pushed out,t hanks.

greg k-h

