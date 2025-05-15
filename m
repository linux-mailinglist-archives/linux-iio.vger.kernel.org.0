Return-Path: <linux-iio+bounces-19546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF5CAB8C15
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 18:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689CC4E28C1
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BAE21B185;
	Thu, 15 May 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS5dcVhh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6B414B092;
	Thu, 15 May 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747325777; cv=none; b=Fk5sTMDx0x/IU6mMLNc6tFyQtrZOLnzGO6xDjoOnbDLofbUhlOz4/03eoxYaG5P3gWyIBiiAhRZ6DmcWu/sKMOYhvRax1MoZaAJRPE9Sc3ni11r9pAiPrDGKGBqeWlEHk4kaTMvS+wZn78IN9hFI6wy+kCzEqDxlHymFJV/mrAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747325777; c=relaxed/simple;
	bh=KrGbBp0qqtgFNGdBmHKXj3aMJkohcCnaXJ1mZ7MXcxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oc9AO45lwbsUksKUXhWicSa2J1c8siU9w5OZQTU+V5t3FHSH0Jdnz0aoTyGkeywo+a36uqotaoFP/5+tjPDBBycfJ7sXJoE+mEYNaKNbdSALguqxlxw05nhuhVYVwB9eBXsoUgRttqRGDfM24i11OTetUD4SYJsqV5WdsLBfejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS5dcVhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7117BC4CEE7;
	Thu, 15 May 2025 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747325777;
	bh=KrGbBp0qqtgFNGdBmHKXj3aMJkohcCnaXJ1mZ7MXcxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nS5dcVhhRDivq63Ye9Yt1A/YCU3SKrD0JrS0v7WQ9kpfvmnSysSn5ygRj3NhY+lLy
	 i+3Xe1ROl+4Oq/TLTHHTgiqM9KrEysqwISK2e8IzKfH7bfhAs/lBQ3tpUSUqXOdDAe
	 F/FM5iBrLygS3+wbl07COGYU2cSxFfZDwuJcgGkNXSYFxnkDLudZC0PGVQoGVSxanq
	 RyMXk9PdoDQcAusnPZWXZBprfZkLULufwO68jPhAXrA/ttCi3ILCgROZzHcooP905L
	 Ez1Qg7s85Clblpd+WW26uWw7QM/bba7RpuPeVGueY2Qe3+Hq5tjYNZ9S5lObHhXtxf
	 38WVTbBpG44aw==
Date: Thu, 15 May 2025 17:16:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7944: max high bits on direct read
Message-ID: <20250515171611.27b77172@jic23-huawei>
In-Reply-To: <26d10040-08bb-4ec7-a438-7b4618df0a4d@baylibre.com>
References: <20250505-iio-adc-ad7944-max-high-bits-on-direct-read-v1-1-b173facceefe@baylibre.com>
	<26d10040-08bb-4ec7-a438-7b4618df0a4d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 May 2025 16:03:15 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Just realized the subject is supposed to say "mask", not "max".

Applied, marked for stable and wording tweaked.

Thanks,

J

