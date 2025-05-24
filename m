Return-Path: <linux-iio+bounces-19850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 029A0AC2DFC
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 08:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039453BE0EF
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 06:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EFF19D8A7;
	Sat, 24 May 2025 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xNOXUHQa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E626F1C5D72
	for <linux-iio@vger.kernel.org>; Sat, 24 May 2025 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748068215; cv=none; b=pIYSHPoHAhVWO869ronjbrHxCJIFGigvDOArRLymGHTa/LoqF9FDWt3J+l0X5yoKqjCJ0m3o7i5xVnUP/hXz8h0qYl0OSBNUaYjfZKm/disjkZiw2Ufa20fn9RXT57YzxykVi4BQlJ4g7BeWZDnOJbNnVBavzIYe+qDgD14L1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748068215; c=relaxed/simple;
	bh=AwTcsSzi60rORwl8kx2bHmnnGwbmBkaSzfmISx9GOng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqycmxTdbrQA4er1k2pBDAYMCBmn7JBcE6QiFSW8YFB/c/pQnfMTgBjROrH2xpd8zcuco4gk0Lyg8BsVLq4LzsIEikyZA2mX0PtXQXi5/pbj/GhOTixTjNIiQk1BwV6/vebhOQgtVrpiyqVIJ54lK7Phn2pgmZ3h9m6jlzvKwBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xNOXUHQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB04C4CEE4;
	Sat, 24 May 2025 06:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748068214;
	bh=AwTcsSzi60rORwl8kx2bHmnnGwbmBkaSzfmISx9GOng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xNOXUHQauR5z9Fj+icEvZE1s5KI2Aswok84WaTXpqhGO54DlLZn9fk531HDjZ91iz
	 XUk7EmX/LG7XZmYjL3FSVvOAlEG7/2NaxuJ0nseCcR/SuNwNoRxpG7mrHlJZ5HQ5Op
	 7eu8QjryYOnaskcJjNn3vwHTd+IEiHIUHYUlDV8w=
Date: Sat, 24 May 2025 08:30:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of Counter updates for 6.16
Message-ID: <2025052400-deluge-dawdler-79ac@gregkh>
References: <aDBw7nF3TxsgHraC@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDBw7nF3TxsgHraC@ishi>

On Fri, May 23, 2025 at 09:58:22PM +0900, William Breathitt Gray wrote:
> The following changes since commit 08e2a660b1601963ced37ac8e8d8c134a97f167e:
> 
>   counter: interrupt-cnt: Convert atomic_t -> atomic_long_t (2025-05-02 22:46:01 +0900)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.16b

Pulled and pushed out, thanks

greg k-h

