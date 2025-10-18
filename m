Return-Path: <linux-iio+bounces-25237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D16BED429
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 18:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA74F34C902
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20609253359;
	Sat, 18 Oct 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgKNSd5p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FE71FDE01;
	Sat, 18 Oct 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760806467; cv=none; b=hbLL+HAsQxIy8JmkSoWz6vcVzTErJcjp47Ez2mJ/FvoO8giwncuOCDhh4NFPE7JDtPP6LLYmTfB3K75NOLUKOgCfDvybMqXIB5w+1UKtaw1JKKsWHm6xFunNUzodikc1z3C0jblgCTjZeW1rgogNAvyS8MyhiCiJYEOOHNZEuGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760806467; c=relaxed/simple;
	bh=9xCpoINAgwkfDm9boKe98rLyOvgdKQxkOpTeAJ69dXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9TN2jVV2Ngxpaxgnd6nExXkHrKh2IDeK0FXnN2jwXhrGZzzHGkVkQGMbbd81hjGjRnGikP1W2hlx/LMkTnfZIwX2BS5y2T+2/YfvPwhIbd4Ex9T1oblOG2KEPrAS/AMdZtmKaTJW1TsrgVZKZ76nr8LqaOIOz12Du/3A75fEQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgKNSd5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11A7C4CEF8;
	Sat, 18 Oct 2025 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760806467;
	bh=9xCpoINAgwkfDm9boKe98rLyOvgdKQxkOpTeAJ69dXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XgKNSd5pMfzDvdGWMTdY5LBJ2wBAm4wwQJ7roW1vNPCms93UkCiV+6dzxz+SE9+7w
	 vMfP+bxk4jIT6kKPJzbviikporKbXjDMXiBiF0WfO2KQWfwwyNOlMemL+bKRVPP7rI
	 CpK8UvBQGUD5VPQrryEO/MzoJfhrWAe5FiFLu4c+XRBSc69ljvsq4bzJs9E2i+4pEh
	 dYmz8hOXhRdN+H+LA/rLRowUVrAeLhJ87X6O6sO1HqcelwcNveAxVzMJIeGc/watK5
	 0k8pqb8uBozinERkxXNYmaIQUA7LaTxbrS92MIpmOhML8lZxpcrUhyaJSzJ7LpbZIa
	 ajFBZ0VgB5wHA==
Date: Sat, 18 Oct 2025 17:54:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
 devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>, Adrian
 Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v6 5/5] iio: magnetometer: Add mmc5633 sensor
Message-ID: <20251018175419.7a6242a3@jic23-huawei>
In-Reply-To: <20251018175232.064a8aee@jic23-huawei>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
	<20251014-i3c_ddr-v6-5-3afe49773107@nxp.com>
	<20251018175232.064a8aee@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Oct 2025 17:52:32 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 14 Oct 2025 12:40:04 -0400
> Frank Li <Frank.Li@nxp.com> wrote:
> 
> > Add mmc5633 sensor basic support.
> > - Support read 20 bits X/Y/Z magnetic.
> > - Support I3C HDR mode to send start measurememt command.
> > - Support I3C HDR mode to read all sensors data by one command.
> > 
> > Co-developed-by: Carlos Song <carlos.song@nxp.com>
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
> > Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>  
> LGTM.
> 
> So my ideal case (assuming i3c parts are good to go) is an immutable
> branch in an appropriate tree that gets merged into both i3c and IIO trees
> and has first 4 patches.  I'll then put the driver on top in the IIO tree.
I can't count. First 3 patches.  Binding and driver would go on top in the IIO tree.

> 
> I can spin one if that is useful.
> 
> Thanks,
> 
> Jonathan


