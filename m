Return-Path: <linux-iio+bounces-10769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FB19A4D1D
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 13:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022591F228C8
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238D11DF752;
	Sat, 19 Oct 2024 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BijMo7lN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1818FDA3;
	Sat, 19 Oct 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729337628; cv=none; b=oq7u8KpGLKqJfbOn+36sjvZBFzsAJrH2NycrJITcUrz+CvhjzglFWhNDfhodpJGM+rOzBQg7QhXNHO4qzh/ChpMnrxtn2SGAKFCxZkdkKurVhC9W4cdNLVA/062D1CizC/Qfk6qycwVZMwSrIvXq4HFpWuasQYve2S9fJa9HJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729337628; c=relaxed/simple;
	bh=20C8vmgTvtwj+pWKXsdakfN0BlXeXYFDm08Ta84e6Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fspRC3mGW5ICMrPX4bC7V+omR1aroxh0LX4jtjHVpHkeiIKh2vsSuYsYMcl9/Z9Z9mBtiYsr65mndxvYlN2WokuowBNZNNeHNiTq+9sJkpvyr+dH8R2IVDTg+L1K2cCPo+Hq6aea3PBM2cDKZKS0nVf3XHBSofegpW/pIXUiAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BijMo7lN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1F3C4CEC5;
	Sat, 19 Oct 2024 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729337628;
	bh=20C8vmgTvtwj+pWKXsdakfN0BlXeXYFDm08Ta84e6Xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BijMo7lNedNSCzd3BPb0A/JJ4kkmm9CwKd8tRhl8ZuxUg9GZLCyBEEAP2DZ0Gsrd0
	 H9flrRxwGqduc6WtS6spXclXDQMjtSyGecdIQLYW+ssPrgB5iy2u+/C61kdFWbX2vL
	 UvSj51MgjMS0bBLBREgeSOV7MOVirTGXY7ihDOjXyJciN+aIjQbEQwjUtQNW+WJtDz
	 TZ7PHzJ/1rE6DiCXvLvcKTmIg5wZFQwHv8MHXd3yfsbKJQ2NDB3s2zupHkpQ9zQ5jG
	 oYRs2n36Y1YZEIdv/ZJh46gIplQitnLPdxn6uRZCMRMU3jl6nbXk7mr5nqLR2TAjmj
	 pfs9V9RxCJp2Q==
Date: Sat, 19 Oct 2024 12:33:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>
Subject: Re: [PATCH v2 2/6] iio: imu: bmi270: Provide chip info as
 configuration structure
Message-ID: <20241019123339.155c046c@jic23-huawei>
In-Reply-To: <20241018233723.28757-3-justin@justinweiss.com>
References: <20241018233723.28757-1-justin@justinweiss.com>
	<20241018233723.28757-3-justin@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 16:36:08 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Prepare the bmi270 driver to support similar devices like the bmi260.
> 
> Signed-off-by: Justin Weiss <justin@justinweiss.com>
One thing in here.  The enum ID thing tends to end up costing more than
the benefit it brings, so for newer drivers preferred option is separate
structure instances rather than an array.

> ---
>  drivers/iio/imu/bmi270/bmi270.h      | 15 ++++++++++++++-
>  drivers/iio/imu/bmi270/bmi270_core.c | 18 +++++++++++++++---
>  drivers/iio/imu/bmi270/bmi270_i2c.c  | 11 ++++++++---
>  drivers/iio/imu/bmi270/bmi270_spi.c  | 11 ++++++++---
>  4 files changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
> index 8ac20ad7ee94..2e8d85a4e419 100644
> --- a/drivers/iio/imu/bmi270/bmi270.h
> +++ b/drivers/iio/imu/bmi270/bmi270.h
> @@ -10,10 +10,23 @@ struct device;
>  struct bmi270_data {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	const struct bmi270_chip_info *chip_info;
> +};
> +
> +enum bmi270_device_type {
> +	BMI270,

Whilst quite a few drivers do it this way, over time we've found that it's
much easier to just skip the array of structures and have independent ones.
Increase the extern lines to one per supported device, but removes
need for an enum here and generally gives slightly more readable code.


> +};

>  };
>  
>  static const struct of_device_id bmi270_of_match[] = {
> -	{ .compatible = "bosch,bmi270" },
> +	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },

After dropping the enum this just becomes &bmi270_chip_info
and later you'll add bmi260_chip_info etc.

>  	{ }
>  };
>  


