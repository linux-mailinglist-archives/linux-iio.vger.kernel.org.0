Return-Path: <linux-iio+bounces-9069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C663969A0A
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 12:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3141F23BD1
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 10:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61B31AD25C;
	Tue,  3 Sep 2024 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gq15TpoR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BAE1A0BD1
	for <linux-iio@vger.kernel.org>; Tue,  3 Sep 2024 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358990; cv=none; b=LPlLYTKvCrnQH1UcqZdEvwBIBQe+kzGY8+9vlDQ6bZrTiQPutW2Z+GioKhxYrF+rJ4fz+aOO6RuD0q47jbEZn+5ugFmPXzgzyQSrH2yp8q+IasnB11YD6P+xrKnRNjbzRZwbjTEWPbD5D5k+7TIJzq3rBH4svkFqtEa2FmbNYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358990; c=relaxed/simple;
	bh=GOx4kShMlxhwYK3tSSnd14tWFYG6U//vzwGBggPXksg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLbtjo4z7OrmjFp/8KTljI870PmvZHOwz45dXIU3Oj+4WoHo0wJT/Gf2Jmh0dECFAotRzhRfM9LvipcUmFDMZ4lcGvZYJbk9+gpWNdzpfxNNgbMAFVmzOzCvnmJDPVPCwh70bTfoyBecSgKYONDdQn9J2L2Om/uqeZkzBoFK6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gq15TpoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B38C4CEC4;
	Tue,  3 Sep 2024 10:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725358990;
	bh=GOx4kShMlxhwYK3tSSnd14tWFYG6U//vzwGBggPXksg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gq15TpoRppFcbYA8Xsiecb5QBYNDpWP6jexOWByeiWZjqQYEfbAnSeHGrK+HjKcq9
	 w/Y+C8GmVyBA9FcFz8yvZiM1Mab3xLT4Dh4TSZAY33GujlJgA2mNnxfTGPBYNAKKch
	 PAIfkUluOQCXu4mkHoQpQ0RQX565Qww0MEfAAcog=
Date: Tue, 3 Sep 2024 12:00:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of New device support features and cleanup
 for 6.12
Message-ID: <2024090304-handheld-evergreen-4f0e@gregkh>
References: <20240822194412.2b0f179e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822194412.2b0f179e@jic23-huawei>

On Thu, Aug 22, 2024 at 07:44:12PM +0100, Jonathan Cameron wrote:
> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:
> 
>   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.12a

Pulled and pushed out, thanks.

greg k-h

