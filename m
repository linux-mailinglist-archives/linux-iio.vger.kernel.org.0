Return-Path: <linux-iio+bounces-4665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E048B6B5C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Apr 2024 09:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750781C21D6F
	for <lists+linux-iio@lfdr.de>; Tue, 30 Apr 2024 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A761376E5;
	Tue, 30 Apr 2024 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kynHOgnM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F5E2C184
	for <linux-iio@vger.kernel.org>; Tue, 30 Apr 2024 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461792; cv=none; b=ecYKCBD17NOQ3SEPpfZkXm01sn2U0XL7KlIAgW8ufwlY2u06ZP4/B6Dz5uhSk5c+Tjl0sFSAaJuPuobkINst9Q+tFfkoqlEeZx4x+3mg97pZvvWwR3yCWnMbT3Tthv9if8430tfM1u7qDgvfi4KscHZ6pLI/ViaQDLxQ8+jCcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461792; c=relaxed/simple;
	bh=GxsGFhR3Riig+xtXe2i1B2tN1wu1RltZ79d1YxH3xc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJsunHgH7emWXTSTyw+mEsSlW7h9EJE6QWxJCaALolaZ+gfB6iqLYSG+onmAAqDntAS2qezILTW5/xu2yTqQSCLYMmQgImOSyfPiUnaEmtNiGQdmnl9T7TGMvbGq42bnuUWXjmCayw/tAVDBZud+HttSiqS/6P3YPrqPnarxHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kynHOgnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562D1C2BBFC;
	Tue, 30 Apr 2024 07:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714461792;
	bh=GxsGFhR3Riig+xtXe2i1B2tN1wu1RltZ79d1YxH3xc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kynHOgnMN06yyp5XGYAJScEsDfmh5EUyLCuD3vGYR/QSIFK9FqjIPutMhV0N4EXta
	 UIcUOoesj97AY/QAJCdXA74HCiCwxoj/Rm3tBtSRzzJBkQk7eCiZyHZx2GesftBafy
	 fkxNzGZRa+zJ9NyehiDxhR+Yublfz96DFRtl1U4I=
Date: Tue, 30 Apr 2024 09:23:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Second set of Counter updates for 6.10
Message-ID: <2024043001-shy-entwine-b8f3@gregkh>
References: <ZjAkzFeHTJXY1LA0@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjAkzFeHTJXY1LA0@ishi>

On Tue, Apr 30, 2024 at 07:53:00AM +0900, William Breathitt Gray wrote:
> The following changes since commit 916baadd293a4d11e08a7ca1e2968314451ade6c:
> 
>   counter: ti-ecap-capture: Utilize COUNTER_COMP_FREQUENCY macro (2024-04-02 13:15:03 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.10b

Pulled and pushed out, thanks.

greg k-h

