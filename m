Return-Path: <linux-iio+bounces-27401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC33CE4EF4
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 13:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E2773007632
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B79B2D8387;
	Sun, 28 Dec 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u/n6ko6D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69D2D594F
	for <linux-iio@vger.kernel.org>; Sun, 28 Dec 2025 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766926532; cv=none; b=VbMgFqiSZiQ3PLI8AmUUoRVNEch8x5TCpTmsJwkha6XYc7VFJa0swG/5FC1ftSfMOmNox5xyZiMTtIU2WNaMmGGyhDjMJhzU5xoJfMSceSHGLgOdOsPpq4rk+0RP9JCBN3PrhKTZ0VlEq3+RlbFIYd6vLWdqXXrffZF/jbyBnX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766926532; c=relaxed/simple;
	bh=YHmMRoJ52yLjLXm6E4xCb3sjH+3Lk4khI960c/UVFgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr4oAyW5gzTxPNVJqSATrNXm1Wlu2H8JX2hr92i4JaepUNWD8zN2iR3vbsnIbW/FbgfJ0tWcVotOeto+8Mw4sCESsBtJZnYUqq7eKgkWhWH0lU4uGjKMtU/WwPJ1mfNolFJPPtmvsTVO8xoAMh6VFn1rmNkyW0bhw9d7LkCzrR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u/n6ko6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D74BC113D0;
	Sun, 28 Dec 2025 12:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766926531;
	bh=YHmMRoJ52yLjLXm6E4xCb3sjH+3Lk4khI960c/UVFgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/n6ko6DDTaLiYVYwaCDOoF4iTn4cF+Ma1wUvdkyJNIgPKsTpsg4PSQuy3cn7Iiw6
	 puG76AK1286ZUwQxWJpMzY3XFzr11fLG8pwULNg6hoKMngvK+Vz0uBA2g20xOwHqEN
	 msh2jCVMTs2qX7SAemp3URmo5MDE52c2VmO00Ph0=
Date: Sun, 28 Dec 2025 13:55:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter fixes for 6.19
Message-ID: <2025122820-corroding-pellet-9cca@gregkh>
References: <aVC-QsxCpDSnelZq@emerald>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVC-QsxCpDSnelZq@emerald>

On Sun, Dec 28, 2025 at 02:21:06PM +0900, William Breathitt Gray wrote:
> The following changes since commit 9448598b22c50c8a5bb77a9103e2d49f134c9578:
> 
>   Linux 6.19-rc2 (2025-12-21 15:52:04 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.19

Pulled and pushed out, thanks.

greg k-h

