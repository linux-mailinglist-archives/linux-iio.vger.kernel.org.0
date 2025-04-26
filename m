Return-Path: <linux-iio+bounces-18699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4C4A9DBA8
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 17:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEEA7A3B6C
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A8225CC7A;
	Sat, 26 Apr 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpqgUuFK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48D025C83E;
	Sat, 26 Apr 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745679799; cv=none; b=Z3o5Jn4xTEaN+3oLwq2QMC/5ZSUqvJB5T8ao6YEUMSTVClvjAqI3KbDPGzDEtrH0tslfAFhYGyflJf6Ajb7p8v5csAIY0q0WUK3PTluA/jZ1E/HKjgYpZmGe4GCGRWP3h9HuRwdaljb6QIY1QeFvPpVCwaRsoADbK6UoE+JYMqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745679799; c=relaxed/simple;
	bh=A0tSDsuysVgzgS/kLqYVOrFF4K6MtDc+HGAO6z7j9s0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQ5KNY9wUiJIrE/ejxtXmMnbHvbORmnJ4/vXIw+JYfR3TZmi+BTNOci3G9secLTnVoqELZ8hVNJkwAumotyk/QrMj56As8B4vcrPEf9XMdNfQAoNMxnlj7y326h1Kkn+WU72NIkudAu7ClJ3kfRXYJGPngSAWwZ4XUyk+UUWSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpqgUuFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E72C4CEE2;
	Sat, 26 Apr 2025 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745679796;
	bh=A0tSDsuysVgzgS/kLqYVOrFF4K6MtDc+HGAO6z7j9s0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lpqgUuFKP+2mJSiUSOyQ5UywoNLnMrpzLjbO54TXc4+6/ayWnslX9r+YS2FNrdlAD
	 VyAJMxVy6P78AxffNqhRqEgzFTMrKC5VS3KJOcvIVeetMzlRkUrV7T08342koy+I//
	 VBRX7d2FrVXhDYKCp+knM0dMPCZH0B6ql14PQ5x7cOfh2ZAntwZLWaCqA6KQ3YkGs9
	 4UcLZ7zBokJaSI5aE2FbmQBChHOeUZ3xJyFQquJi4FRyc/aPT2sBC7qjG6tnQXN7/u
	 A1/fn9W7SYf89avUsw0HkG0isYvQQXLoDMlNZzhWi+QTte4afbAYodut87PXICcifa
	 bLSpi3qJhTprA==
Date: Sat, 26 Apr 2025 16:03:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 0/4] Add support for Winsen MHZ19B CO2 sensor
Message-ID: <20250426160308.6dbe1cdc@jic23-huawei>
In-Reply-To: <20250423194100.53934-1-gye976@gmail.com>
References: <20250423194100.53934-1-gye976@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 04:40:56 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

Applied to the togreg branch of iio.git.
I'll initially push that out for a few days as testing  to let the 0-day
build bot see if it can find anything we missed.

Thanks,

Jonathan

