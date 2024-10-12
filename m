Return-Path: <linux-iio+bounces-10481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB77599B26C
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 11:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8717E1F22CF3
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA89149C6F;
	Sat, 12 Oct 2024 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="VpyZ3rdG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7093D13B780;
	Sat, 12 Oct 2024 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728724274; cv=none; b=jCNxWDHASOQ8qv9hFHgFwXmXjM58yQ6TYxyAKlMTv+KqTH7IHUxJfPZZq8OX6RWKWNReAKm3YlWf/rUVSAZDc/ADrlVIwFa3pzWXfw4hlliM5/UyhS6t5SIj8ksooZPOG25Qv8a7/ni0dnWnqr5MnOkNipUY7n4IuQ414EGGEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728724274; c=relaxed/simple;
	bh=Oe7mm0rcqRcsliA/I4pbGXbLiymUoZlO39wmcrkF4KI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O8gFxviCkFOmoUHUrwPeTAnMef3n9cQppFHchkHQICaMt28Qu0bDydLvIehyz1epi2apngxmS+eVsMJ5JrEtAvMaaCNhwd2p4FJc3etrsS/zg73ik6N9ZyzLazT7A/CKxkrTr/wYENnJkBejb4Bb8OB/Bt55OztXgIYwGZAu3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=VpyZ3rdG; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NqtUHjAfr8QA7ELc1P6eM37sDCzunyhommn/mZw9lcg=;
  b=VpyZ3rdGKwrSw/hoOAyBRNVUid1wzQ8EXNoHGBD06AuigV7WYTElgYXg
   +zc14W56xi0g9Egm055gvLG+35wT7PpUtKwxb2ZKAuWc0fUXaNPrdV1h5
   L9/WyulEL+QA5QXvTqS2Bi6ESB/xwvmM/d2WNughN1fOOMXShxLtydeyW
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,198,1725314400"; 
   d="scan'208";a="98917317"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 11:11:09 +0200
Date: Sat, 12 Oct 2024 11:11:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Su Hui <suhui@nfschina.com>
cc: jagathjog1996@gmail.com, jic23@kernel.org, lars@metafoo.de, 
    nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
    justinstitt@google.com, benato.denis96@gmail.com, 
    Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org, 
    linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: bmi323: mark bmi323_ext_reg_savestate as maybe
 unused
In-Reply-To: <20241012083701.2189663-1-suhui@nfschina.com>
Message-ID: <alpine.DEB.2.22.394.2410121110540.8471@hadrien>
References: <20241012083701.2189663-1-suhui@nfschina.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sat, 12 Oct 2024, Su Hui wrote:

> When running 'make CC=clang drivers/iio/imu/bmi323/bmi323_core.o', there
> is a clang warning as follows:
>
> drivers/iio/imu/bmi323/bmi323_core.c:133:27: error:
> variable 'bmi323_ext_reg_savestate' is not needed and will not be emitted
> [-Werror,-Wunneeded-internal-declaration]
>   133 | static const unsigned int bmi323_ext_reg_savestate[] = {
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
>
> Mark bmi323_ext_reg_savestate as __maybe_unused to silent this warning.

Why might it be unused?

julia

>
> Fixes: 16531118ba63 ("iio: bmi323: peripheral in lowest power state on suspend")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/iio/imu/bmi323/bmi323_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index beda8d2de53f..1167984809c5 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -130,7 +130,7 @@ static const unsigned int bmi323_reg_savestate[] = {
>  	BMI323_FIFO_CONF_REG
>  };
>
> -static const unsigned int bmi323_ext_reg_savestate[] = {
> +static const unsigned int bmi323_ext_reg_savestate[] __maybe_unused = {
>  	BMI323_GEN_SET1_REG,
>  	BMI323_TAP1_REG,
>  	BMI323_TAP2_REG,
> --
> 2.30.2
>
>
>

