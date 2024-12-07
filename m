Return-Path: <linux-iio+bounces-13203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5849E9E8179
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 19:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED809281812
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98A714F9FA;
	Sat,  7 Dec 2024 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6vPX8Jm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9C1F602;
	Sat,  7 Dec 2024 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733595071; cv=none; b=heyGbxYUGM7KiY4aXghV6pyhlN+WWrPwb8isYpXiOtsSJdJnQ/sCwrQqYmKUunrfhTN1bB2wLi+6tXBas5DXxf8+gGFyNwNKX18S4+t/5KPynb4OHf0YRWTkSCe0xNudF9SPtRD47Q1ynRbpvNU7P1+aWELWpRIZu+jJ2kEq76Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733595071; c=relaxed/simple;
	bh=9rLpIq57aYY5q6fCycVQHDVk+l6BdakZCZsYRLwOYHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGjmJ3q6xKDJi2bHlU826WoI+Wr5qrajyqWioFPidi1+R1kO2ZL+vSQybyIw4PDOQSciKEJoF+znb1d2SzII3WCGTd0mDMT1SZSwKIpwZDbjuZen3BXHhP84WjQGA1WCiCimPnm9h/T/5sNWumLi2im6Q4nJ//2aNuQj3RKdDmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6vPX8Jm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84FCC4CECD;
	Sat,  7 Dec 2024 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733595071;
	bh=9rLpIq57aYY5q6fCycVQHDVk+l6BdakZCZsYRLwOYHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N6vPX8Jm4KXlZjRL4hCWFUYjwpvP0zlUWj6WaYTeuKIDpvRJI3bEH21ggS4NlF3Og
	 /42yvI/SOb3dgXGF/5CxZdB4ez/MJwW8lRogEAmVuL+17lWm78iHjohZW9aRTlnu5e
	 04C3lMHI86DgZlGUd987uyoonddcvUUn89KdZ1RD63+YSEr7nT44yV7fT9Z3Kxg1gH
	 XDkjcgVG+WR82Gd2Gu1+XYPcNF4NaTjlmbXMmR1z82jD0Li9dap9Fm42/JVk4As/ST
	 6SI0QcYKSfGjIRaWKpE2Dre8HBCMg0dOuQqcK2+9TBD37FlW0cf2Bg0C6hvZDpJqfF
	 xghl5BgbCrsIA==
Date: Sat, 7 Dec 2024 18:10:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 02/15] iio: adc: rzg2l_adc: Convert dev_err() to
 dev_err_probe()
Message-ID: <20241207181058.3df9c7a0@jic23-huawei>
In-Reply-To: <20241206111337.726244-3-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
	<20241206111337.726244-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Dec 2024 13:13:24 +0200
Claudiu <claudiu.beznea@tuxon.dev> wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Convert all occurrences of dev_err() in the probe path to dev_err_probe().
> This improves readability and simplifies the code.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi Claudiu,

> +	if (IS_ERR(adc->presetn))
> +		return dev_err_probe(dev, PTR_ERR(adc->presetn), "failed to get presetn\n");
>  
>  	ret = reset_control_deassert(adc->adrstn);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to deassert adrstn pin, %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to deassert adrstn pin, %d\n", ret);

Take a closer look at the implementation of dev_err_probe().
It already prints the return code (where appropriate) and in a pretty text form
which is easier to read.  So we should not print it again.

I'd also prefer wrapping some of the longer lines in here a little earlier.  For IIO
I still prefer to stay under 80 chars or only a little over it where it doesn't
hurt readability.

Jonathan



