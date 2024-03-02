Return-Path: <linux-iio+bounces-3259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6D786F1F4
	for <lists+linux-iio@lfdr.de>; Sat,  2 Mar 2024 19:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70ED71F21324
	for <lists+linux-iio@lfdr.de>; Sat,  2 Mar 2024 18:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCD53FB32;
	Sat,  2 Mar 2024 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IkBOnQ6n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17AE17C69
	for <linux-iio@vger.kernel.org>; Sat,  2 Mar 2024 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709405655; cv=none; b=UPPubNU7UtjlzbHQ5OixZpeQEBMtW3MtTX9z67NxNYMjMKqy/LTXEDbWinkrCF6JnkS3ZrTPJXdp9mA9s7Dk4QGc5KUCPA1Mb+45Kbm2CpeFTJ3sIZzaOQmov1Xy2u1bqVhqVwbrN0eiEny9npIwSQIchKQYyDFIdTQEMQd4RLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709405655; c=relaxed/simple;
	bh=/vbOoqtUfy4ki4Pac9f1dO4bvfgY56TCu6sgJkkSYTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A39h9fu1mScbBNTMv432HzHwF0aTxoOQGukuF7Ui9Dty4avFuZH3AfenGmcPVCnT830NkD4/n2faLDYTrqy9igCYedfzjBQ+Wlh6Vuzo7qR9mqI+JPvbXGw6mEzWsLGYkk0kII2heUVjs+ACFuH3DRCPAzXG3PuXKVIpJ232Y30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IkBOnQ6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F5EC433C7;
	Sat,  2 Mar 2024 18:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709405655;
	bh=/vbOoqtUfy4ki4Pac9f1dO4bvfgY56TCu6sgJkkSYTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkBOnQ6n15XHqJTSzsoHSILVyZFekdkRQXQFuc/I1bvRaScRssJivpjUULq0/C5HJ
	 KVMs845/ld2OrEKrKYsXQI+sUz81Rw0Jg3SvYZPQ7Tn+OCsWxK6JI+2kIMT6afvnXJ
	 98FhhWcsjR3YoveP/u9UKXpX0ejsjR22YkUasq+k=
Date: Sat, 2 Mar 2024 19:54:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org, william.gray@linaro.org
Subject: Re: [GIT PULL] First set of Counter fixes for 6.8
Message-ID: <2024030204-satin-trimming-9b5b@gregkh>
References: <Zdzm51zyzSipL8T_@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdzm51zyzSipL8T_@ishi>

On Mon, Feb 26, 2024 at 02:30:47PM -0500, William Breathitt Gray wrote:
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:
> 
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.8b
> 
> for you to fetch changes up to c83ccdc9586b3e9882da9e27507c046751999d59:
> 
>   counter: fix privdata alignment (2024-02-16 18:51:00 -0500)
> 

Pulled and pushed out, thanks.

greg k-h

