Return-Path: <linux-iio+bounces-10317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DA9993F83
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 09:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B79B2340A
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 07:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D251C9B77;
	Tue,  8 Oct 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB2m2W1K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2316C695;
	Tue,  8 Oct 2024 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370460; cv=none; b=et/gx3Icp2pTbQO6ZMbU/L/GDcQ8hJbhmrq8SeEi/2CNNNLu0UVa5V1lyRkOblhUE7/JISxsl8zzMDjJPAQXpnaQiOSJE4nayof7XU9dFMvrf7kR5good2Ne2lBz6T/7+DMu5l+I62gchsUOtRYviA/Hy3LoFcFHwMPzUKUw8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370460; c=relaxed/simple;
	bh=B0gH9Dqz8PxRVVM4RZd2AcaICH4Dxpie6xhdfRKEhtA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R7krHN2BESGjMVKnElUVYNa8wnHdfK82cdO+7lf7+/acv5f08w+OvCJaCXBC3WzovElDIASLyI/aYwkpqY1Qs9W1B7KdGUkbCaYy7nC6Em00gRE6QVBTxAICqbyMuCAQEYp1VlE2rghUJpG7bfLW7XtlnlDPHac7jqkxXLEGbYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB2m2W1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D69C4CEC7;
	Tue,  8 Oct 2024 06:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728370458;
	bh=B0gH9Dqz8PxRVVM4RZd2AcaICH4Dxpie6xhdfRKEhtA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IB2m2W1KUUwwSn2zJRFG2KCVqVV6GlQApW2i22jtXpCIuayjBXz8nxU7TMgtpf8WA
	 2naXkT9S/wxitDt7jgqOUPa0NH9n4vNt3H7x0lO0YR966KNiM7xP8MTB7PssYfrU3I
	 OAZJ3JxtvVntJoAnEFq1LcTwPiwAh/VczaukwHTGfmqRRRck+zG+H3O8vd6LLqkKZG
	 6/Fr1KhoLYOw9w8udZslxMAr1QPafaRuXzWGl5SiXT4g23RazvBumesDdl8R82fA92
	 4BpDzr/yPE5TVHY6QxPmbtbY3O1JFynNL+CZQsxY1IwziR2Za0HjBjGUuDUXtJcqlR
	 mODqRvTzfqppw==
Date: Tue, 8 Oct 2024 08:54:16 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
cc: bentiss@kernel.org, bonbons@linux-vserver.org, jic23@kernel.org, 
    srinivas.pandruvada@linux.intel.com, lains@riseup.net, hadess@hadess.net, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-iio@vger.kernel.org, linux-usb@vger.kernel.org, 
    opensource.kernel@vivo.com
Subject: Re: [PATCH v1] HID: Fix typo in the comment
In-Reply-To: <20240924115005.3130997-1-yanzhen@vivo.com>
Message-ID: <nycvar.YFH.7.76.2410080854080.20286@cbobk.fhfr.pm>
References: <20240924115005.3130997-1-yanzhen@vivo.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Sep 2024, Yan Zhen wrote:

> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Fix typos:
> 'mninum' -> 'minimum',
> 'destoyed' -> 'destroyed',
> 'thridparty' -> 'thirdparty',
> 'lowcase' -> 'lowercase',
> 'idenitifiers' -> 'identifiers',
> 'exeuction' -> 'execution',
> 'fregments' -> 'fragments',
> 'devides' -> 'devices'.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


