Return-Path: <linux-iio+bounces-20859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56791AE304C
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 274CA7A645E
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95851E5B9A;
	Sun, 22 Jun 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts3f1+Bk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D85757EA;
	Sun, 22 Jun 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750601387; cv=none; b=a2F17oGkyun5QmubUWqQ3l0ClZuZq3BKD1Kil3MaZFq5nMhTjcSS+54S335Zy+hw/MdlIPOCngTk0lkXD9ASuMfq8wb7A5pRUOGgamCkjXzjAHoCjvqXEPIE8fH3TIUpXCYzRsKNj/ku+2DhGsIQoqsMCmECQfjUvfBkGA5trAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750601387; c=relaxed/simple;
	bh=4Qd6Qi34vSRzwjqQQCCjbHEFlkq3N+kG/xNxq2lu5m0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgo4jnLfOACMatE2T2+pXLoEBJfi+DjOWj7/DaBVEYtSUCdggAxQQtliHB5k2MTDhQQKiLdMajwDgeQO6TVgJTbk0fuFbWXS+VQ3t7OaW9jcXmTNnAYd5Z0xFYr+7k40C9fuygUUhPw6+TFCi/Olyb7Xw3M7hMXBjmP4X6MF2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts3f1+Bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487D4C4CEE3;
	Sun, 22 Jun 2025 14:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750601386;
	bh=4Qd6Qi34vSRzwjqQQCCjbHEFlkq3N+kG/xNxq2lu5m0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ts3f1+BkIkihypOPW7yO8K6r+qRh7W6yQIisr6+v7IJKKEwbAgK1vmpEeKWmbJ+Ug
	 vSvdffZChJlkLYYJhHmeB2fNO7+FkIhZG8Rpl1PaHKly7EKjl0lRzkGHpKaA3VVuP4
	 q2gIGW56NOfBl5e/d49K6GVOCEh5MTp5yvTnB9YlDy0whzvB8fsDyvzhnHDsjq3N1x
	 uwNP4jHc94KhSix9maRujC+EBsL/K/3Pd+RyiFm10uNqRKLh/9MJriw9dHTKN47HmG
	 gtpt5dPDmHCvYn6asq1xaM8Mad+8a0hS+7sKHQgycw927YZBCDp9Dv0hGV+4Q63NW2
	 2q9uJuJcEt0uQ==
Date: Sun, 22 Jun 2025 15:09:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
 <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v6 05/12] Documentation: ABI: IIO: Add sinc5+avg to the
 filter_type_available list
Message-ID: <20250622150934.09151aae@jic23-huawei>
In-Reply-To: <58854f63fb664b9d99a5404b02794718c01a34ea.1750258776.git.marcelo.schmitt@analog.com>
References: <cover.1750258776.git.marcelo.schmitt@analog.com>
	<58854f63fb664b9d99a5404b02794718c01a34ea.1750258776.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 14:36:51 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add the sinc5+avg filter type to the list of possible values for the
> filter_type_available attribute.
> 
> The sinc5+avg filter type is handled by the ad4170 driver.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> New patch in v6.
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 3bc386995fb6..c1f657182ad8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2321,6 +2321,7 @@ Description:
>  		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
>  		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
>  		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
> +		* "sinc5+avg" - Sinc3 + averaging by 4.

Seems an unlikely description that something called sinc5 is in fact sinc3

>  		* "wideband" - filter with wideband low ripple passband
>  		  and sharp transition band.
>  


