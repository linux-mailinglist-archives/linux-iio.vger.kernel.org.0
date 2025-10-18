Return-Path: <linux-iio+bounces-25245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AFBBED55F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A707334C726
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 17:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2D254841;
	Sat, 18 Oct 2025 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX65JpSk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B83242D8B;
	Sat, 18 Oct 2025 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808764; cv=none; b=WVoMuJ+DX2wYU1FTSPjpLlya3Wf6ifkh43O7YSyeZhxO12qBfLYEyKTtecheyJFMQTIJYbYM4bzEdrPHtWy/4ZPfYzwfMNCTWmw4gGq6H4Pmw9oamEUZKA+suk28eFAFHq5/j3t28/HE7vbiC8CRxNOFy0kwpoUf13vWb8KGn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808764; c=relaxed/simple;
	bh=/mm6cdCVwtTwG9uTGu9blDaWbvr3L7p2XvHqc5rDSbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+lZMRVYvF/udKaewxNWZz2l9VPcjObKYwH93X2fyW3s65lCGTGgPKXyDfbyy7QCt5ciKsRM1Z0Fdf71JR4EOGCLhgeTUWM2Bxq4jERT0QuJ3lqkdd1ZK6GD2Nz0IUMrjFblBxrktuWyP7GI5k7ATQ2FMTHY8R0qbHssNRIcvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX65JpSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0619C4CEF8;
	Sat, 18 Oct 2025 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760808764;
	bh=/mm6cdCVwtTwG9uTGu9blDaWbvr3L7p2XvHqc5rDSbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AX65JpSk3xWrS2qM5hLzmm3vrrS6797fM1fbXBIz2mYKcvDEwO0ZWLvbr9KZdhTEe
	 qRbmNr7kgLttIO8b6a6q1r6l8Umq2Yi+89k6Piyl1vW1h4ooP8V4DDKR/knQNyjEHk
	 mUO+LcRRohzsFvICOxPjFBNP5JU+fYzNHuCROBo1QxvS57rG9a+DYC1HoL+Ybmm+MT
	 trdoqgBob9PYraxNm3J4qrrZtZgWZS2tK5TDOuetq2msgnN8N/gj47H8LGWmJK2SYv
	 5CT230S97p7ki9T4++LzvoPl70Idyfb3LgtYcFncwW7Aup0jUGdExNlBf9aQDmAnXl
	 M4/604/v0F1Aw==
Date: Sat, 18 Oct 2025 18:32:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: accel: bma220: add any-motion detection
Message-ID: <20251018183238.05b60ac7@jic23-huawei>
In-Reply-To: <20251014-bma220_events-v1-6-153424d7ea08@subdimension.ro>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
	<20251014-bma220_events-v1-6-153424d7ea08@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 19:43:02 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add support for what Bosch calls "any-motion (slope)" detection.

Slope is normally rate of change in IIO ABI terms. See the _roc_
event types.

The slight wrinkle here is that we have it based on the magnitude
and, whilst it has been a while since most of the sensors using
_roc_ were added I think they were typically signed. So it was
acceleration is getting higher at x rate, rather than what I think
we have here which is that the acceleration is either growing or shrinking
at x rate.  (kind of _rocmag_, similar to _mag_ relationship to _thresh_
events)

What this has to do with 'any motion' I have no idea - I'm just
looking at the graphs.  If I read them right we need something new.
Or it's entirely possible I've forgotten some part of existing ABI
that can handle this.

Jonathan


> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> I think Jonathan remarked that this might be improper use of the iio API?
> please advise.



