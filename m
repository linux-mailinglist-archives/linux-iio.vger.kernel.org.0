Return-Path: <linux-iio+bounces-16593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2187AA585D1
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7270188D7B0
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE29F1DE2C4;
	Sun,  9 Mar 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oylf7/e9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32542A93;
	Sun,  9 Mar 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741537837; cv=none; b=Jlp63HHeUc0zZrC7M2Pv5J0V8q+rcqO8TGuq3awHrhv7CVzIh9FpfHovEbP5Y9/TX0vR4nbPo4ElTERNov+50Ixov9ht1ABLrtgPKQ2SROBlrwhpV6DMpM9+9K8aATGjKz7K0sVDgdGsK3WdaTS0Ft/CipXdt8JlGbxOGgV01Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741537837; c=relaxed/simple;
	bh=8R3PKmNhc66MIFXQf5pCfmUO/9Oc9YhK92/YidFByYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQvngxtwcG8JJ9FynLcz5OBCm17yExucwc4hFBWQVmc9gzgY5/XLnSSSLx2KHGkQSsQh9Wftx0Brw5SUm4g+mrggz7ThJLe1TySZYG1PU8wHiTcQOf1ZoGegDnA/N2kNOeQv1wk4gUcR+rrJvp6vUAYCPWDnO0zXSb/c6N2QlwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oylf7/e9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F23C4CEE3;
	Sun,  9 Mar 2025 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741537837;
	bh=8R3PKmNhc66MIFXQf5pCfmUO/9Oc9YhK92/YidFByYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oylf7/e94w7pxSoUNi87o3dVYljrWD9gJYT4PFMcgTpLlFVPW824IBqAJHSFS4k86
	 2YIsY1rhDo0qpfe6stO1X5IhMftQnaBpkZFlEIyRC+KzPm/UmtFfnh6qBonDHEzoRl
	 ojl1u1KxS4VY35gkDxhcShF+V5fgJRFfowEs128n7W4nOGoNuerBA37J8uGxTU62AE
	 /eFcQK4BQGBF6rlAZ9B8eehQ3+Z7Pwl7ZzNdsFz9jLH4Z5ZypNcWCfhx6+JIOWnR4z
	 6U+AEXEMl52ij9dNtDY78cZXAoUrAUH2wJJtWVrH6lFTCkrPvfN/PMtqxaL1u7iyCc
	 taCw/rb3d6Mnw==
Date: Sun, 9 Mar 2025 16:30:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Baluta
 <daniel.baluta@nxp.com>
Subject: Re: [PATCH 1/4] iio: light: al3320a: Drop deprecated email for
 Daniel
Message-ID: <20250309163032.732f4d05@jic23-huawei>
In-Reply-To: <20250308-al3010-iio-regmap-v1-1-b672535e8213@ixit.cz>
References: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
	<20250308-al3010-iio-regmap-v1-1-b672535e8213@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 08 Mar 2025 21:00:58 +0100
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> He no longer works at Intel.

True, but we have .mailmap to account for stale email addresses and I'm
not sure it's appropriate to drop this one.

Daniel, maybe you want to add a .mailmap entry?

Thanks,

Jonathan

> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/iio/light/al3320a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index 497ea3fe337775b07efdfc56c80beb1aa55e394c..d34a91fdafa0affad4665d995e1f66d2aaa0373b 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -266,6 +266,6 @@ static struct i2c_driver al3320a_driver = {
>  
>  module_i2c_driver(al3320a_driver);
>  
> -MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
> +MODULE_AUTHOR("Daniel Baluta");
>  MODULE_DESCRIPTION("AL3320A Ambient Light Sensor driver");
>  MODULE_LICENSE("GPL v2");
> 


