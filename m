Return-Path: <linux-iio+bounces-11947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2254D9BEFE8
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 15:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC201F218CA
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 14:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C940201278;
	Wed,  6 Nov 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+rRsnjh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F06201102;
	Wed,  6 Nov 2024 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902503; cv=none; b=Ti9nv04LofXJKogLOjufqD1Bc7DAZeN79ILepqj6PyQ7pXL8DGYnrASeTaQQd7JxdVqRF1K2Ba8OT9ZaVpxbghkEmKsCykAXoN5Wq65TXPI3BJZuYbBnnFkD2Xu0iFA9NUc2TcVNEJKtDcWvFZPpOxue1fOQ1pAVXU1weUcpc68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902503; c=relaxed/simple;
	bh=11PMx9PUL7fbdUFkuufBbDuWSsqlV0+8mLWc3JFbaIc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dsmwt53jVWDaP7VsaapTqQaJglln+ofjpLt8tF+xo/dQITa8nggmxF5Th/LZqKZ2jaP9+GqHtcqH+OSm+oxDc0dQ91GjuHsIZOpVf2N3N+NGwEBJyhntTnPuTRcXqkeAwwhk4pP+K0iRZKCozszLDR2dliA/jVrIqVajTIPawy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+rRsnjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E715C4CECC;
	Wed,  6 Nov 2024 14:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730902502;
	bh=11PMx9PUL7fbdUFkuufBbDuWSsqlV0+8mLWc3JFbaIc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=F+rRsnjhBcvNds6EfcEKKubrxKhvs4gJK379dg+ThvzdwHmBuPwmU1upveo3K8emM
	 TAupZHHPt/16+ctZEEEXRlbhMSYy4kkcacC5gjAFm6sE5ZR2OJcXWlHqsej+vWzViJ
	 SSKPyfIv9gJEkIse95rurPFjOqHht1ofB99YBFVNOvqdDVDfKBkS29xb0RABdY5GqE
	 4PZ0le5EcKNlwS7bfHPanYMksI4pommYjDq/fl45goSdVfCc62N7oj/yaLgomHE4fS
	 mvAYAvaEWmZ5O3b6vB7fJtsj8CkuPeu3UYs/YITbjyGtsgGyw2V7DTlnfIoOmRQV4N
	 dCUt0v0BT2+ww==
Date: Wed, 6 Nov 2024 15:14:59 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
cc: Ricardo Ribalda <ribalda@chromium.org>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    Lars-Peter Clausen <lars@metafoo.de>, 
    Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
    linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iio: hid-sensors-prox: Add support for more
 channels
In-Reply-To: <20241101153255.4d835495@jic23-huawei>
Message-ID: <nycvar.YFH.7.76.2411061514451.20286@cbobk.fhfr.pm>
References: <20241101-hpd-v3-0-e9c80b7c7164@chromium.org> <20241101153255.4d835495@jic23-huawei>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 1 Nov 2024, Jonathan Cameron wrote:

> On Fri, 01 Nov 2024 07:46:26 +0000
> Ricardo Ribalda <ribalda@chromium.org> wrote:
> 
> > EgisVision 620 provides two additional channels:
> > - proximity
> > - attention
> > 
> > Add support for them.
> > 
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Looks good to me. I'll queue it up, but Jiri / Srinivas if either of you have time
> to take a look as well that would be great of course.

FWIW:

	Acked-by: Jiri Kosina <jkosina@suse.com>

Thanks,

-- 
Jiri Kosina
SUSE Labs


