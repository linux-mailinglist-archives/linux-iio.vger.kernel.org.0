Return-Path: <linux-iio+bounces-6406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6DC90B8EA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 20:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D32280A87
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA14A1991B0;
	Mon, 17 Jun 2024 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FODSxLr8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687501991AD
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647353; cv=none; b=EjOVb5dWEVyVo9ZbDGVQnQxYWjes7oUMZ5AoN01HibpoocAakPvKJqzOPgn1MVV+/4JARXlUzvBygF475D1gGSc0eirwHLZv+/qweaMNw+lCVlRxp8C8LpareZ5KNFBA5sawfcELj3lcrzFoiK6XkIwrzjHJcIGexhiT9U1ZO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647353; c=relaxed/simple;
	bh=5wB0hIU6h7f8IT0egPGHE9mDyqwDWpNRpkWwtRIXGa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIfUi0fCPSSi5s97LXAAKp8FfkuRx592cx81nMbL70y+q8nTWBlAPwmeaAWEKBVmvjwtTEhG1HUE+BqX1b6e7KdvuE+EZtuCEgB7tEGlE1xGexe9IPpWhqPlpJHyYY60v1gN4VVbSIhyZywsqZEZzMF8THJSGbozD2WOX1TQ9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FODSxLr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972D1C3277B;
	Mon, 17 Jun 2024 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718647352;
	bh=5wB0hIU6h7f8IT0egPGHE9mDyqwDWpNRpkWwtRIXGa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FODSxLr8TAX309LtedTZf59UxKn6ZSD/6UL0dCXxfUGt4Ny3YVIPFcL48BiTfIoiU
	 AmoX9i7mbUnaloCDlGMb7deIDiae/mZv0TDLZYVFT742EqwQkmRmMxlg/+caV63f7o
	 wOW4Uh5k/ZUFIyuR7ZpAPwsKNJppEaPYPd+ZY8zo=
Date: Mon, 17 Jun 2024 20:02:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of fixes for the 6.10 cycle.
Message-ID: <2024061715-fasting-sputter-4597@gregkh>
References: <20240615101121.09118fed@jic23-huawei>
 <2024061646-deviator-maritime-4e35@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061646-deviator-maritime-4e35@gregkh>

On Sun, Jun 16, 2024 at 12:04:53PM +0200, Greg KH wrote:
> On Sat, Jun 15, 2024 at 10:11:21AM +0100, Jonathan Cameron wrote:
> > The following changes since commit 8f40af31971ce012c0a4b13444900aed3f708edf:
> > 
> >   Merge tag 'iio-fixes-for-6.10a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2024-06-07 21:05:39 +0200)
> 
> Pulled and pushed out, thanks.

Really did it this time, sorry for the confusion.

greg k-h

