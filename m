Return-Path: <linux-iio+bounces-24516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3348DBA6C11
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 10:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8BF7AC986
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C6E2BEC59;
	Sun, 28 Sep 2025 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD1U3oor"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F5220F29;
	Sun, 28 Sep 2025 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049553; cv=none; b=JPIeI30nMSNjCuPe7E+/7rL7WhOo34EgWD1VTb3k+Wf0MOiZBFdfK5hTjQ34Za6WyyrSe1wVKYmLOM40U+Si4Fsi6b5qXNEJopgj5GCHbZS8d8KqHozWi0F31sQpm7C+DKIDhQdplVbUuby47Lp9fJub2av2gBQpYlnUxLG6p/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049553; c=relaxed/simple;
	bh=TmVCpd402UZVos/0N6uuXIkDpEJwZ3l8EUGkdUPHbho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udwHnIMhV8X/YXpSXMg9hdVSepvD9Aq8N9nrBRFqSKb8U4J4M4nk/EkB4zKMNx397rbWXnm5ycQSP/JNFxnYDaLzDVo6hj8YovxDHve5zor2AYncR0LxfuA6TXGtAXx4JPuWpv5ACYOsTLzQ1ejRhjTjzR8LmxZQ6YkNTm8mafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD1U3oor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626D9C4CEF0;
	Sun, 28 Sep 2025 08:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759049552;
	bh=TmVCpd402UZVos/0N6uuXIkDpEJwZ3l8EUGkdUPHbho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JD1U3oor9u0s1cB/aYwVgU9YS/ZD4Nny2ETcj5ctPiQB9PhVprAbeluFGbIBgShAu
	 FTy5QD3AqyEXt6TF8QKXLRjeY0rIAVSr/ka9JDXSvwGz70wScZvqkiUVoFz0WhCdvp
	 QoxG5s7YrEW/x1AJCOHksebTMAIuEge99q3uqfAW6/en9fx9X0nYei+M3hM9A2KuE9
	 8ab8PTnQ5riBaHv2HjEaTCassNQpNLdKdnfDuI8ftm9NuOF7Futrf0QSjBS8BMVqqf
	 C0U0PxwzBcByMhAKlfgCEACoTCOVF+mLS2fBrnrY3psKFksFd56Ys9gl5E4ChJWIHe
	 8aSgirVK9+HjA==
Date: Sun, 28 Sep 2025 09:52:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 4/9] iio: imu: inv_icm45600: add IMU IIO gyroscope
 device
Message-ID: <20250928095223.6e9130c3@jic23-huawei>
In-Reply-To: <20250924-add_newport_driver-v6-4-76687b9d8a6e@tdk.com>
References: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
	<20250924-add_newport_driver-v6-4-76687b9d8a6e@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 09:23:57 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add IIO device for gyroscope sensor
> with data polling interface and FIFO parsing.
> Attributes: raw, scale, sampling_frequency, calibbias.
> Temperature is available as a processed channel.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
Nice. LGTM.

