Return-Path: <linux-iio+bounces-20826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C298AE2AD9
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 19:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00061754FF
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 17:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A295266580;
	Sat, 21 Jun 2025 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpWgtfhL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B3221544;
	Sat, 21 Jun 2025 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750527663; cv=none; b=K5DHEq5XjEQth93avJj+HT61rHjWWxZBwlMuksqPsF8paikusfl6luarNZgFe7Fd5LvKr+saVl5a1z2aHpyAQxHVWj9AAgSzhL0VLhBBt3PkBThwQR3Rl+En2D8NCNRExChCBR4uj24SAe6EdCBdsiEgdK7eYniaZm1EpEHisPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750527663; c=relaxed/simple;
	bh=flwpeb2IwtJg75XdbWu0JdT2fbI+Rkq26Vnnw67qiDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3FytTWi9neIAf4UO4hoX8GxlARjWbBQrZz37QI3/E6Gnb85mQJps2B4rwAcAped1hEK5XoftAig85HP5B0lnhFSuAUJAQRFL94EoN718FHBQbZTJ7+4uxQtEbeb2O+YnRowGLh1WsH+czFFWOvaOLbJmklPdNpPJ0vuw/TVxZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpWgtfhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E2CC4CEE7;
	Sat, 21 Jun 2025 17:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750527662;
	bh=flwpeb2IwtJg75XdbWu0JdT2fbI+Rkq26Vnnw67qiDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qpWgtfhLvAYkhTOyW0rNGqsOVaIfwcuteTcR8eQoOprgOgSdEF9F7wl5mK1DMP8ai
	 G58hZ3P2msIhtGMdh70jNZmALhfxVwQeME+hLN2x06aJJ18diXjBILLqGuVwtY1hDd
	 B1XFx7/xwdq093ycaLcBz35EbAlAKnSJ2QKHEo4kYuDKhb1xl/FPdJ/2Eb7amM0dzD
	 DAVZ3aqShH1cu3rbm1e7e/q8qtRI8ks+qXvwfW2OTklotD3agT+3X3sDZXVWgpfHsr
	 ZR0jPpF/Pz83ztjjN1jKhTgaC6T1lksYvDvwaVcOnOTF4Y9V2ZAQYQScuQIs/lTYdV
	 GXuAoks4Q8q5g==
Date: Sat, 21 Jun 2025 18:40:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] iio: accel: sca3000: clean sca3000_read_data()
Message-ID: <20250621184054.76e53bb8@jic23-huawei>
In-Reply-To: <20250618031638.26477-3-andrew.lopes@alumni.usp.br>
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
	<20250618031638.26477-3-andrew.lopes@alumni.usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 00:12:17 -0300
Andrew Ijano <andrew.ijano@gmail.com> wrote:

> Clean internal sca3000_read_data() helper by removing unnecessary
> arguments and return logic.
> 
> Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
> Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
> Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
Applied

