Return-Path: <linux-iio+bounces-6328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2898909CE8
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 12:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133881F211D0
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0D1862B8;
	Sun, 16 Jun 2024 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g1OgyYsY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26511862A4
	for <linux-iio@vger.kernel.org>; Sun, 16 Jun 2024 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718532417; cv=none; b=MHsQ30aAFfcjRwkJFAaUiBg53zeTssn0+xo4PLyRmHxpNlpYMTEw2euHEW6ajyzCj5HFmBl0QygiXQVhXKyfWbViTEGRQvvRU+vckjuezWfdiD2WsZMqE35IjK0SfVs0enocMl94g9V+WXjvNf/GfNRsDJ1heaE3HNJtKdLLg6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718532417; c=relaxed/simple;
	bh=srjg1JVAgtmavdSq/3PkdqL2ksa6hFZZOBaHmxgIwS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mj1yJgC7/cUtGN7t6SmvF7Itv63rOYzb9S7DDi7CSuJSOIjcuguOnaIN62WAOVzKbusNL+DXJl+sX9E8NNl6W9ybRqTknGjjA94CS4p39d8PV1k71C0JZjoZ4c/Bz3UTqNcH7k4y2Xd/YDKJdrgfeQgjs86OVLptZA63fBgwihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g1OgyYsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBFFC2BBFC;
	Sun, 16 Jun 2024 10:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718532417;
	bh=srjg1JVAgtmavdSq/3PkdqL2ksa6hFZZOBaHmxgIwS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g1OgyYsYJXZytvQs2+Du8ezV5arNY+Gfh6Mz94Xh5QATRrgHqJz+M+hnEHxx6NRDJ
	 Bk5eZ3M7OAWZHHOq/2GlsjPKr1MDMkoBOQl1s+kfgvc37oaMcTv+qo0S/WRqVP8e5g
	 h23p/pD7TQqikevTxzk7LIqDJBYtZEF0Ni+NltBI=
Date: Sun, 16 Jun 2024 12:04:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of fixes for the 6.10 cycle.
Message-ID: <2024061646-deviator-maritime-4e35@gregkh>
References: <20240615101121.09118fed@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615101121.09118fed@jic23-huawei>

On Sat, Jun 15, 2024 at 10:11:21AM +0100, Jonathan Cameron wrote:
> The following changes since commit 8f40af31971ce012c0a4b13444900aed3f708edf:
> 
>   Merge tag 'iio-fixes-for-6.10a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2024-06-07 21:05:39 +0200)

Pulled and pushed out, thanks.

greg k-h

