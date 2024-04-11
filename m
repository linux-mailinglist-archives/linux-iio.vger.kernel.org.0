Return-Path: <linux-iio+bounces-4191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610F8A14E4
	for <lists+linux-iio@lfdr.de>; Thu, 11 Apr 2024 14:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA181F23C8E
	for <lists+linux-iio@lfdr.de>; Thu, 11 Apr 2024 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0C53F9D5;
	Thu, 11 Apr 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CMcLvh9U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3D3987C
	for <linux-iio@vger.kernel.org>; Thu, 11 Apr 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839548; cv=none; b=BUCZuBsSmXPSOqYn9M9FvXfw2ml5NNd/VMB/Rl+pwwamL/L8fjXiWRCdHmmNVseBI/kIReGLEOBr/+j2hwOvDo5S6On4QIxfBIklybQsDtmlJdVNI3X2AhycvHoEcXEJ9+DK3T9ddzfwi3ts8Vksc2HUYvfz0bBLQW9dg7WYgxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839548; c=relaxed/simple;
	bh=+3H98kBgNnvDYV6r6wAgT9JT5hssLr92l6iTawQU6Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdyAap3JcoXvM4+89v3qWJcHq947N/uVz7E5hrbrIjDCV1raFPgirjrelgMLY4QuC4/zlaKHww2su1A3ewsD9mq7wSQhwGQpQ4GqKaKPtjQwgTvpFC90OhAiVAbQq4/y73ZAuyTrwGM7oERCAyvj9hO5q17jqetOjm5BvadImYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CMcLvh9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7952C433F1;
	Thu, 11 Apr 2024 12:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712839548;
	bh=+3H98kBgNnvDYV6r6wAgT9JT5hssLr92l6iTawQU6Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMcLvh9U8GeODqR5JCHYAj5WZL6wxTFMdXlipz0wrOiPNFxbyARtiw5AUnAoocaaN
	 p6o44jzHrjmJvH7w9/ZJU/dtb0/mfGpBytE/UJSiy5dc5wcenwAi+Wj6QDrxseW86i
	 f3Cl7sJWeJHaLlGuUTmij4shyNgMWoS84aIQQy8k=
Date: Thu, 11 Apr 2024 14:45:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter updates for 6.9
Message-ID: <2024041131-implicit-decipher-76f4@gregkh>
References: <ZeyMLe1lmfyMcrss@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeyMLe1lmfyMcrss@ishi>

On Sat, Mar 09, 2024 at 11:19:57AM -0500, William Breathitt Gray wrote:
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:
> 
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.9

Did this ever get taken?  If so, should it be for 6.10?

confused,

greg k-h

