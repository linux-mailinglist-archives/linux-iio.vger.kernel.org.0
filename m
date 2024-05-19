Return-Path: <linux-iio+bounces-5108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CD48C94F7
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 16:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF7B1C20F9B
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2154AEEA;
	Sun, 19 May 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbgC9ZXM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7039481A5;
	Sun, 19 May 2024 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716128346; cv=none; b=fJMpIsMYdFy9Wt+F1dwkQIxDmGLDKdnfd3BlifwpWpJ96F71EN7y0cIBkpD+6+UY7WW2+ysVb2fXJTXeQpMCejCRL6WRwpRiC9MGenPne8YwxL98LpTE4b06g7pdeMsH1ZwfUpLPKIrBPuHPw65sJ8QpEcoMJVPpXp8B2NQaPeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716128346; c=relaxed/simple;
	bh=v+umHiUUnGUmUTtXXqr7TM+1+g9u9v5AvQ+HeTXUJ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGRhpYUg3WFkvdWKbfdqhcDianjAhaiV/LTTfUa1y2L22wo6FgN2b7VCSsYhpOeX4OR4uGoWnfKv1UKeGZWKTAD4sf7DuXMT3rAkvF5CgceG/bcsf6PYNZuyPwgbUymPdT1nTL0kA0Us1B1ftCUDKaqMxBWSSsi1cgtkhPFKsbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbgC9ZXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E641C32781;
	Sun, 19 May 2024 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716128346;
	bh=v+umHiUUnGUmUTtXXqr7TM+1+g9u9v5AvQ+HeTXUJ9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cbgC9ZXMJLZaMSh5eY0NtKtlGJsZWmkuU+gQCAN1cRpH/5Pc0g2Q+vBF35MrkdIUC
	 qDIP9tDvqEY8V4B3mjLIPHllOwyrmtLbsCglYWwOEl+mF8hz1tMwryFhuciPxxmA9A
	 XLMFHQSz+ncblVe3BQCJu2ReKddTuCC7jXEz6MPbIIaEmY3nZvTH1kTh+IzFozYMpy
	 B9phTr98C6PlLw3SWmGaplmjz+3szJ+BZKTB48iUGdCmIO4jlLcsA45+pYV9sO7tGP
	 1pkDs1rmIEati+7krlA0XsUNHXkrmmuyk0hdPIbCWsXHF2vkElH2Xw/p4P7hl+XncZ
	 Qa+KCsTMn5y9g==
Date: Sun, 19 May 2024 15:18:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, christophe.jaillet@wanadoo.fr,
 gerald.loacker@wolfvision.net, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] iio: chemical: ens160: add power management support
Message-ID: <20240519151853.5590caa3@jic23-huawei>
In-Reply-To: <20240512210444.30824-6-gustavograzs@gmail.com>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
	<20240512210444.30824-6-gustavograzs@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 May 2024 18:04:41 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> ENS160 supports a deep sleep mode for minimal power consumption.
> Use it to add PM sleep capability to the driver.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
Looks good.

J

