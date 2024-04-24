Return-Path: <linux-iio+bounces-4485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FC18B0084
	for <lists+linux-iio@lfdr.de>; Wed, 24 Apr 2024 06:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5997285674
	for <lists+linux-iio@lfdr.de>; Wed, 24 Apr 2024 04:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A412F13D886;
	Wed, 24 Apr 2024 04:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HY/XKlOY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6585C46
	for <linux-iio@vger.kernel.org>; Wed, 24 Apr 2024 04:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932883; cv=none; b=D/7zYnDJM9h/Z8ailY62Qj8QyYYQ602l5x+/SjjQ9vtdybFXMiwll4bzl7akFEtJfdWTwOSrYiMBqdoNpjEjh8pyZsA77WL7OGzftTDEcKqcrnewUZ/QfZO1vZjLzURUyWVhjxzahLYRDlYz8rc5WMtjs6MhLkKmFgB//5va+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932883; c=relaxed/simple;
	bh=CgnUmFb2G6S2vxvfUxfaMpmas0NNfx+p+BzzmBIOo9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKw/XS4/OCOW1TmVfwYHJRGMbkIivMEM4+GAj3URDVYs+jr9wdFsnu6QyLF9/EkKlAE9RAt627BD5Eo1D/KDfr+msnFeGwVgk+n4scAes+c1XuxpeE96zF8TphVGQUzBdOeO4HO+HpHyhyKqFb6lu7n5SAwSK1KjqUHNchnVhBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HY/XKlOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6966C113CE;
	Wed, 24 Apr 2024 04:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713932883;
	bh=CgnUmFb2G6S2vxvfUxfaMpmas0NNfx+p+BzzmBIOo9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HY/XKlOYT3itDHdHlBz43FzuFW01zVrMI27GukY4ruDUw7NdKqV4+3308J/btUOFe
	 +a7pYdKIa1JnZMtJSTB7bs8gi5LGhejuK69EsdhMGW+y3jtyQ5eT0A94ajWyt6wzBE
	 sOcRLXp7fPFWvzcWI/W8mr7uYyf9x5j0dLcWgQU4=
Date: Tue, 23 Apr 2024 21:27:53 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for 6.9
Message-ID: <2024042346-crummy-thinness-dc6b@gregkh>
References: <20240421185716.72eee37e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421185716.72eee37e@jic23-huawei>

On Sun, Apr 21, 2024 at 06:57:16PM +0100, Jonathan Cameron wrote:
> The following changes since commit bfa8f18691ed2e978e4dd51190569c434f93e268:
> 
>   Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2024-03-22 13:31:07 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.9a

Pulled and pushed out, thanks.

greg k-h

