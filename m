Return-Path: <linux-iio+bounces-6404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C92390B8E0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 20:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2101F24DAD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACDA171E71;
	Mon, 17 Jun 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ifkldnnd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F1225AE
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647240; cv=none; b=ADMqrfOAuNV3GAxDXX9xeAsvGRRk5ADsnYUvV/zDeT6GaSgDR3LguzYoW5tHd+HJ1zoUzMBmXo0oVn0ZFPyKAinMKSjOieN3eePa9W48K5/UaaWXu+WxnFYVUtl8v8Vt6V/Vv2q5TrpkmCvxSyR82FTJTvPevlp7I7OvndCeoGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647240; c=relaxed/simple;
	bh=WQlt1pMC/0BGr6aKNRLmgbpaFmDFhFaI51sOj4nWWQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+JBOeog8O4NdxydZXKtP4ebTzL4n7t3H+fqeFDVLuPiO2dwKmaRG+TepwTJM3r/xqHxopMp9saZsAXsjI0XiMzgnpIsGWAmhiR5Ehz6pN+Ay2lEpWYXEB+x+ye4IikgKBtM4M3hqjEatcBryPO0TVPkwvdjVKpDRT5tBi+bPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ifkldnnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9179DC2BD10;
	Mon, 17 Jun 2024 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718647239;
	bh=WQlt1pMC/0BGr6aKNRLmgbpaFmDFhFaI51sOj4nWWQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifkldnndAqtEuCqi+mxL7xZr6z63sA7I50VboXL8b9nf+4GnYCEISe0Gj2brkOqIj
	 M1B/JYjER042iYKeZBE+pY3KB+64xq63HH7MfASzFzcepJuJIF0pRBiWijWu6S7Tuy
	 1Z5u+vN3/Jw1xLf+7WGDMYfIwedJNQL8B/9j0QU4=
Date: Mon, 17 Jun 2024 20:00:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of fixes for the 6.10 cycle.
Message-ID: <2024061709-culture-cleaver-ef0a@gregkh>
References: <20240615101121.09118fed@jic23-huawei>
 <2024061646-deviator-maritime-4e35@gregkh>
 <20240617185405.61939834@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617185405.61939834@jic23-huawei>

On Mon, Jun 17, 2024 at 06:54:05PM +0100, Jonathan Cameron wrote:
> On Sun, 16 Jun 2024 12:04:53 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Sat, Jun 15, 2024 at 10:11:21AM +0100, Jonathan Cameron wrote:
> > > The following changes since commit 8f40af31971ce012c0a4b13444900aed3f708edf:
> > > 
> > >   Merge tag 'iio-fixes-for-6.10a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2024-06-07 21:05:39 +0200)  
> > 
> > Pulled and pushed out, thanks.
> > 
> > greg k-h
> > 
> 
> Hi Greg,
> 
> This one I'm not seeing (looking in char-misc-linus) but I am seeing the other
> pull request so I'm guessing reply to wrong pull request?

Ick, yes, I got that wrong :(

I'll go do the other one now, my fault, thanks for catching this.

greg "too many trees and branches..." k-h

