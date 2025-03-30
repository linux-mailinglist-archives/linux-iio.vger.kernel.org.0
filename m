Return-Path: <linux-iio+bounces-17376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DEEA75B83
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1091A3A8068
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D996F1DA31D;
	Sun, 30 Mar 2025 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq0JGrPM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA7322E;
	Sun, 30 Mar 2025 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743356895; cv=none; b=pOka5z7zA383WBrJ2FRADL6glovaO9yAZSHo+Sma0uSwXXcgTPWI9oL/5T8K1hL1tPGsblaifJBVKgapE1Uq8KZfvjHB4HJTgjQ1sWVMl6dZ3msuy82fqEFRSdO7AW2r8IZDGgjaL5dUMt3VCurr+MqnYu77ePHpvpyiT2WqwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743356895; c=relaxed/simple;
	bh=nXZiLK+sz+KwmE7bYTFfDXy5+teTn694nil9D8nw6I4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqAFyOVV60GPRa3Qp7qTe3gfcel3ctFaTTLa/R3++RUKxCIwl9qRCRZAHJJ3Jxh59Jz1KaILZmFn2X7Qqye6t9bKU8aeDP2Kkrfad/SldaIe3x7k2GuOgEdjg1c2hdAL8bVEaH0pRBuiqVXmMybi8jsC/niI6JJP9E2/MFtT83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq0JGrPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B55C4CEDD;
	Sun, 30 Mar 2025 17:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743356895;
	bh=nXZiLK+sz+KwmE7bYTFfDXy5+teTn694nil9D8nw6I4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rq0JGrPM3B34jfuylY8tnRuqBpI8nCu5HLKF5xTYnEdf9j3WDE4xEoIwJeRH2fT0b
	 r0L0mCUM+YaKN0el3Ohaz1B2B9y46V6MxPmT+7H73CiFon65q8/0sbzI+mPqEvb4gy
	 LAv/HzgxLxMdwgj2lbqwMua6J79ftMX90CoL3SGWudrSmNjY8CD6HtQJmb8lLd217f
	 UoMyTbUQIc59jvOhoiU96Jzo8onP7AgeKTDe5rGU1dr8rQjrLaUx4yq2ZkmeYM4Vbs
	 lvDg4ThhL6EuKeeUarE0IayW3QBMA5GtZAXTFEuV+ahl8SPiTy0wLDRJ4USND3KH8v
	 GtrjRp7Z97b/A==
Date: Sun, 30 Mar 2025 18:48:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] iio: light: al3320a: Implement regmap support
Message-ID: <20250330184807.52d64c67@jic23-huawei>
In-Reply-To: <20250319-al3010-iio-regmap-v2-13-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
	<20250319-al3010-iio-regmap-v2-13-1310729d0543@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 21:59:52 +0100
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> Modernize and make driver a bit cleaner.
> 
> After the regmap implementation, the compiler is able to produce
> much smaller module.
> 
> Size before: 72 kB
> Size after:  58 kB
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

LGTM



