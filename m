Return-Path: <linux-iio+bounces-27768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2041D1E614
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87EAC3004283
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E61393DF9;
	Wed, 14 Jan 2026 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QXuYChnB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E23921D4
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389995; cv=none; b=PylQnlEmn4ZU36JhyeyhcMN0hLHNYe81QzxN/tke7moZK/4aH66BJsrfxmhL4P1jGh569ZM6mMR0NO4iWclquKYYmLyN0jQil3dXfGKxRlKCqRumxKjDtGvX8NxHi56LopoFkTxbCJ2LZqhO//M0q/mvfU7Ynv6+uWjQ65E2PmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389995; c=relaxed/simple;
	bh=3DhfF20iK9tIKc0rCQ3h5g/PTJnBiMDRFkbDDW2AXEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fl6NYfCWYAWNvdrvZRK4gijJdhCwqjp2GUdyGHUYaQ1aTO2Q9cfdVc/uRNQSbEICd/vhZ/hZUDVGzjTErOmcjSUgeXZJpSpazovjPFf+uDEG5nadHWzhIFp7Zuw5GftR1+Jvw62SGUgMh9Ud9j3v/VJ22hI+Na0KBqaLK8lAfsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QXuYChnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877F6C4CEF7;
	Wed, 14 Jan 2026 11:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768389994;
	bh=3DhfF20iK9tIKc0rCQ3h5g/PTJnBiMDRFkbDDW2AXEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QXuYChnBX25GlzLKsijRL9swIOYNfyHtV+g+Xr1XGxU2Ocyi6lnkAfuAEufL8pk6z
	 VedPyC7eblJFLbAEHlsmzZPrIEtdvwt34G83Id/hLzn9gD4WxKhM4S2a7G9WOqZFjZ
	 rj2KG3ITFLb/d5tKUnoJYIB2gFdYIV1YhnC9Vsnc=
Date: Wed, 14 Jan 2026 12:26:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: Fixes for 6.19 set 1
Message-ID: <2026011418-sessions-outbreak-e396@gregkh>
References: <20260114084945.1a7d67ba@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114084945.1a7d67ba@jic23-huawei>

On Wed, Jan 14, 2026 at 08:49:45AM +0000, Jonathan Cameron wrote:
> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:
> 
>   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.19a

Pulled and pushed out, thanks.

greg k-h

