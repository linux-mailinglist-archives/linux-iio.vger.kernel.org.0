Return-Path: <linux-iio+bounces-6084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF46990132C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 20:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C4F1C20F03
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149781CD24;
	Sat,  8 Jun 2024 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5LiJqJH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC86FC6;
	Sat,  8 Jun 2024 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717870079; cv=none; b=crrLVDf6yHz3UR2py7zcAzuVb1wnOddP0G/ziaUW1pLBKcdJZdYpEHbH6jkri/vL+IeQ0a53SnWx/6vluNx/VyuwSjaxA9nm1fsoUmeiului4KFlnuFPGxWJiRaI1QoHosEbCF/I21q6olyd5vdHZ3308D3UxFpZ/P7zPtko2To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717870079; c=relaxed/simple;
	bh=jUcNYbh3MGIEFUYqd8dowXXVHvZCOM7pzgqnGK70whs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVfjc0OZV9mqv7Gi1SukmX/JnMi0a4I3W0bviQEKUcO3zDcMKqpbIAU8WJuwAx35Q/dLlhp1/KPn5TItPJv6/enKJx3F2wGV7TYrID1eMhNzY/tGC17OyUgPtJE9I0dC/Tr5tQ3IWMAzCbvM1kFqCOHcByyaS4JFyMh7whdr76Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5LiJqJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CFFC2BD11;
	Sat,  8 Jun 2024 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717870079;
	bh=jUcNYbh3MGIEFUYqd8dowXXVHvZCOM7pzgqnGK70whs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U5LiJqJHFA+Z7aRvnS8KASzYe3jtUKkWOEblVjh1z03u30nlw3XchIiYaGR+mZnrn
	 MyMdLaeL/5P1wSlB+oUqEz4y1SCWG+qpBTKoIt/OzdTQmLvwnUVR1Hks5KXgYWuHcu
	 yoT5iO+Y+K63DupEyJ7O0VFKb7Tu+yyFRHdN9c+Kxyzqg28VMACZTfRFqonHtjaPRg
	 fZPH2AnJTEcxu0K2FGl8/3wgmc8oih36uSsgljRvRvo18W0ETlsR356JZ0lTGcrjcg
	 9JtaBQv0t7cyE5OtcYGqxpMsJl3r20ntdJaWXkWBpnLUni9+iR1igja06AjNRykP3u
	 Eyfk/mgn1/3gg==
Date: Sat, 8 Jun 2024 19:07:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Petr Mladek <pmladek@suse.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Jyoti Bhayana
 <jbhayana@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Chris Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andi Shyti
 <andi.shyti@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] dev_printk: add new dev_err_probe() helpers
Message-ID: <20240608190748.2577b8a5@jic23-huawei>
In-Reply-To: <20240606-dev-add_dev_errp_probe-v3-1-51bb229edd79@analog.com>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
	<20240606-dev-add_dev_errp_probe-v3-1-51bb229edd79@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 09:22:37 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> This is similar to dev_err_probe() but for cases where an ERR_PTR() or
> ERR_CAST() is to be returned simplifying patterns like:
> 
> 	dev_err_probe(dev, ret, ...);
> 	return ERR_PTR(ret)
> or
> 	dev_err_probe(dev, PTR_ERR(ptr), ...);
> 	return ERR_CAST(ptr)
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

I'm convinced this is worth doing but would like inputs from others
before I pick this series up.

Jonathan

> ---
>  include/linux/dev_printk.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
> index ae80a303c216..ca32b5bb28eb 100644
> --- a/include/linux/dev_printk.h
> +++ b/include/linux/dev_printk.h
> @@ -277,4 +277,12 @@ do {									\
>  
>  __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
>  
> +/* Simple helper for dev_err_probe() when ERR_PTR() is to be returned. */
> +#define dev_err_ptr_probe(dev, ___err, fmt, ...) \
> +	ERR_PTR(dev_err_probe(dev, ___err, fmt, ##__VA_ARGS__))
> +
> +/* Simple helper for dev_err_probe() when ERR_CAST() is to be returned. */
> +#define dev_err_cast_probe(dev, ___err_ptr, fmt, ...) \
> +	ERR_PTR(dev_err_probe(dev, PTR_ERR(___err_ptr), fmt, ##__VA_ARGS__))
> +
>  #endif /* _DEVICE_PRINTK_H_ */
> 


