Return-Path: <linux-iio+bounces-24766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC01BBD206
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 08:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C8A3B76B3
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 06:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC71E1E1C;
	Mon,  6 Oct 2025 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iFg+FZNo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98AAEEBD;
	Mon,  6 Oct 2025 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759731703; cv=none; b=HrQPLxvwCdYincVF/iKkVKavpXIIuIoS8Hq9bXmxvOVB21FySEOvx+t46kBu/lAEJKUDKAz9ums4cqc8LpRyJI4MpkGSGzhwFV6U2u/jJTaJwL8D5KOmQ/YNDvj/kfSYIG8inc8L4fra9fNP7WSFk8Jfv/EmVVWJ7Men7wCi8XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759731703; c=relaxed/simple;
	bh=Lq660/Jrft1bEg64usT0JC2TwH0XZExqwIf30V3jzGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv49hf3LDwzxGxXEkMLS4suqVFZCF1KXUyz+zDIwvgcOT8gpmhbyXb2fsnImGPDdrOxY5uSVuZ6TXEGAfc517FP+FPVm7nh+z2cJrlIhcKnHz3hVlpJM5ys40HPfKKfmOjNcTi3Pfes67nsVgDQjXM0hNygp/LvaWvl/dUhkkgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iFg+FZNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C533BC4CEF5;
	Mon,  6 Oct 2025 06:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759731702;
	bh=Lq660/Jrft1bEg64usT0JC2TwH0XZExqwIf30V3jzGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iFg+FZNoLMiwNW6m3nHxse4wHjf9Bd/FqUmlREIwziHpAom1FcYjuZ5asiDpSmaQe
	 sVpTWX9KRqrzSOcqqkiv/DvBo9G6B4XvSldTDteHq4fcewljdXeu1YBDgLQv+xofrv
	 h8o7shwSFj/q0GXg59kEilsmZ2Pxi1NHO+IA/F1k=
Date: Mon, 6 Oct 2025 08:21:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Taimoor Zaeem <taimoorzaeem@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: iio: ad9832: move ad9832_platform_data into
 include/linux/lib
Message-ID: <2025100625-profound-delirious-2b3f@gregkh>
References: <2025100548-stereo-patronage-408a@gregkh>
 <20251005144758.190457-1-taimoorzaeem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005144758.190457-1-taimoorzaeem@gmail.com>

On Sun, Oct 05, 2025 at 07:47:58PM +0500, Taimoor Zaeem wrote:
> > Also, why is a .h file needed for just one file anyway?  Shouldn't this
> > be part of the .c file instead?
> 
> Not sure what's the convention here, but yes it could be part of .c instead. There is another .h file in the same directory (ad9834.h) which is basically empty. Should we remove that too?

Yes please.

thanks,

greg k-h

