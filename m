Return-Path: <linux-iio+bounces-16962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D66C9A64DE3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 13:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857A2188843F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3989237709;
	Mon, 17 Mar 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbaCb+Au"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E41233728;
	Mon, 17 Mar 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213099; cv=none; b=pDDTToiQqh72rUU9w44bWLLIveSuAZ8+C/hmpnWrvZnKAB6OpHq2Uarj+wx7g8ekRBYUOo8UbTBkxd2axrif6u2YAkLIu5Jq/CguUleJbZKIqHoazYiM9mLDzi7DqH6FE5+047oEaj3eUuwhdBW6dNHygmZgMF4iovbugwzUmew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213099; c=relaxed/simple;
	bh=je+ey6i8no3sFlkJe6m7dmE5sqD8NCKHZp2TXP5ndtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgFf1potspwgKKxO4VQ2msJR2lqgyKmnJdGl+v3OcmCCfXGXAcRhJRm6yqk12j6U/ciTXuhmqZI9wenDgHvPVT8p4VYw/fil0Sr/8i7ruRhsEorloQhTWZTQSTQAHjUEgkhW+zK/azK15iJyLMCgfwF1ADyKe81Bvs2GMuyHHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbaCb+Au; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80539C4CEE3;
	Mon, 17 Mar 2025 12:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742213099;
	bh=je+ey6i8no3sFlkJe6m7dmE5sqD8NCKHZp2TXP5ndtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AbaCb+Auv7TskKOmlBP9E358jJ4VU4zvKPui9Yfxl3HwJQu9UfNgOM83QdYK8xdVa
	 xPRYN/iUlXU+Hvqko+9yh9v+LhhR8W5UIK1oCLdUfZ/6fzLiGMihAbMqwNw0xEvtDg
	 o4fILn+axcCnCpHsKCcQCD1EnhSZsIyA12T3pMa25S3D9UbRbdiMKkFby0+OHJlhyK
	 X5B4mjaWj8lx7qzJ4TBOi6YGpUpBGnpzeuUIMbUNa6IIxZhWI8npO6u7CQGAWVAioZ
	 p0YpfWzt4q2P6edEta5AUx+WjODWtxooNTXRBrnOK1YxyHuJClW76rT1jCuFi8wmRE
	 dCSSjiZt64Kfw==
Date: Mon, 17 Mar 2025 12:04:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iio: cros_ec: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20250317120447.4fa26083@jic23-huawei>
In-Reply-To: <112490dd-4490-44f4-abd2-07f7a519aa7b@embeddedor.com>
References: <Z9dy43vUUh4goi-Q@kspp>
	<Z9d7rp-ullvmXKoM@google.com>
	<112490dd-4490-44f4-abd2-07f7a519aa7b@embeddedor.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 15:10:38 +1030
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> On 17/03/25 12:02, Tzung-Bi Shih wrote:
> > On Mon, Mar 17, 2025 at 11:24:59AM +1030, Gustavo A. R. Silva wrote:  
> >>   static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
> >>   					     u16 cmd_offset, u16 cmd, u32 *mask)
> >>   {
> >> +	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data,
> >> +			sizeof(struct ec_response_get_cmd_versions));  
> > 
> > max(sizeof(struct ec_params_get_cmd_versions),
> >      sizeof(struct ec_response_get_cmd_versions))?  
> 
> I considered that, but DEFINE_RAW_FLEX() complains about it due to the
> 
> _Static_assert(__builtin_constant_p(count),				\
> 		       "onstack flex array members require compile-time const count");
> 
Maybe add an assert that you indeed have the larger of the two + a comment
on why it matters?

> --
> Gustavo
> 


