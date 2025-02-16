Return-Path: <linux-iio+bounces-15574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B688DA37531
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E94716E8A2
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3F219047C;
	Sun, 16 Feb 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J376lhw5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A06E567;
	Sun, 16 Feb 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739720562; cv=none; b=QpumgpJ73aQfACQxtcuMBHRYb2TEngTunow7Qys9lB+oKtioQ07uwjZGPNwalBeKhDR6lqsF7wi5e4yVsjUaEe2roCUCWKl2KPIikQQ08EIuWEm8PSbqEoalKnfup5OdKclqunL2nE7rMJydk92Y7ohj1p4VtbDZvlKbz8D9e9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739720562; c=relaxed/simple;
	bh=J7ZSCVhAQn6InkNMQIcxrycHOMp48oyICLlrFEVIjjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4zYH/U2qDkQEZT+nYYFmy8yySnmU27A7h+3CW4GHntB4+hXsML2pAV5emCla9MvT/hwnjzHLv9/J5Do4O++QEAtTaeTSIvpYZg22VLPnTxHn7l56PRACZFc4aAiQYsVzlkFNNXIhPKr6b/UW9AzEkbO3upzfhnbGBO/Y1ZWByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J376lhw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6117BC4CEDD;
	Sun, 16 Feb 2025 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739720562;
	bh=J7ZSCVhAQn6InkNMQIcxrycHOMp48oyICLlrFEVIjjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J376lhw5hDfSQVMCdn2bsJKMzgpdcGB5oz6z0gI/NOKKZRwTknxDrtWd6zkTignl0
	 oUaMSU2kDSW9OVt7SVi8GHMV8eP0aN/1iuS/yp3I6MKZ1B2wH3P5W9g1ud8GyIBOn5
	 jzCvuXEolRrAeBS5gMICni/+zwQ+kPrwRhpTIod7tC1ojtlOmzZWX88I5qApTorTWh
	 IXbAPjlD99zhEgJ8kPLMj0gkMhgXN4krzGgbg0rL6JU1IRswLz2o1McMKfYzc8oCAu
	 z2O7pHL1BXqhWOm7XHApz29Vf3/Lf11GXF7nZFX8+dg2nriVNoRbmrGq3EZNjp73/z
	 F2yzTLoEG+0sQ==
Date: Sun, 16 Feb 2025 15:42:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/6] iio: adc: ad4030: new driver for AD4030 and
 similar ADCs
Message-ID: <20250216154232.3a1c5e66@jic23-huawei>
In-Reply-To: <20250214-eblanc-ad4630_v1-v4-0-135dd66cab6a@baylibre.com>
References: <20250214-eblanc-ad4630_v1-v4-0-135dd66cab6a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 13:22:30 +0100
Esteban Blanc <eblanc@baylibre.com> wrote:

> This is adding DT bindings and a new driver for AD4030, AD4630 and
> AD4632 ADCs.
> 
> This work is being done in collaboration with Analog Devices Inc.,
> hence they are listed as maintainers rather than me.
> 
> The code has been tested on a Zedboard with an EVAL-AD4030-24FMCZ,
> an EVAL-AD4630-24FMCZ and an EVAL-AD4630-16FMCZ. As there is no eval
> board for AD4632 the support can't be tested at the moment. The main
> difference is the reduced throughput.
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
Hi Esteban,

Series applied to the togreg branch of iio.git with a few minor tweaks
as called out in replies to the patches.  I'll initially push that out
as testing to let 0-day take a first look.

Jonathan

