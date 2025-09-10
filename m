Return-Path: <linux-iio+bounces-23944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26216B51D9B
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EBD16365F
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE1231DDB7;
	Wed, 10 Sep 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7VfaJ6R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1223958A;
	Wed, 10 Sep 2025 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521676; cv=none; b=FeoTjLF04AYKiIirVxNXh9+kH5WyKFmYRd24+5l6rOXYYjESftMDy+B/WgvHe6W/zW9P/HXfUMDmUpyADjNDBoEihIimKa4sRXkTmliFkoQbWgBeXDkP+kYDepi3zq3Jyw8BtiXZvcWmiaPsXhKY6ZNCzQZaxecWdJOXrqEOeB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521676; c=relaxed/simple;
	bh=/1FSxR9TTupSEy6uKX3Zjqa5kVmdzmGXNNMfvSwrgWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OA7dvlGQNMMTHLkyZYeyY/J1JvjOd30J2OSdZtZmY+huMUlcRIWRUwBGLY3f09+2X43PTMejeUpiOzUU9RrJR8BOkGfwrpnudwMwu8TlrbF64cR6AC4xv3wBaoahhO+PhWC4fyoM1WMeJLmydn+T7pZ6NmI/fjU4QtkyvlH8iuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7VfaJ6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B321C4CEEB;
	Wed, 10 Sep 2025 16:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757521675;
	bh=/1FSxR9TTupSEy6uKX3Zjqa5kVmdzmGXNNMfvSwrgWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L7VfaJ6RYxagN6Y2G4qUTgOX7ogAEsIv/dFtNRHrapc9bE4LnkpjdF1L969ZiSIPn
	 kwyisPgMcQ6mB10zrjaPHoMfQb1IUbAmBBVjGnWvc5q6wluuwwc4AMGyOSFbicgJw4
	 FJuP3wahkq8nlGQMJtSDvPFQKYhfdFFg29gjp1vQ2jLUX5ekCyxCH/g+rfhe8rH6XJ
	 zCvLbWxILozVFeowfJyujzYzkeRQD1GpRYdFOu5UosI+Ggc2KPxNSWAqfPyBB1wH8n
	 QN7bdnve8YJ+M8w7Bopvv/lkmKPoDR05DLeqxvvDoFCFv+kuS4RLcau0DfjgeKmFej
	 RZHQMZvKuFVFg==
Date: Wed, 10 Sep 2025 17:27:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: adc: ad7124: use guard(mutex) to simplify
 return paths
Message-ID: <20250910172750.156bb1ae@jic23-huawei>
In-Reply-To: <20250907110652.295b296b@jic23-huawei>
References: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
	<20250905-iio-adc-ad7124-add-filter-support-v1-3-aee3834be6a9@baylibre.com>
	<20250907110652.295b296b@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Sep 2025 11:06:52 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 05 Sep 2025 13:11:58 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > Use guard(mutex) in a couple of functions to allow direct returns. This
> > simplifies the code a bit and will make later changes easier.
> > 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>  
> Another nice improvement that stands on it's own.
> 
> Applied.
> 

Unapplied due to drop of the precursor fix.  Same with patches 1 and 2.

J

