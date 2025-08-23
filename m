Return-Path: <linux-iio+bounces-23170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EDEB32B4A
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 19:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB70D7B43D4
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 17:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9E02367B0;
	Sat, 23 Aug 2025 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT+cqhzh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCBE1A288;
	Sat, 23 Aug 2025 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755970042; cv=none; b=Bv8qaV1H3iSSiSOY8kANBa3cLrkVQbDlGYnue8BoEyWRvZAVWoRgMHPqHjKARicGywlcgPY8hrZtHk4CuK7oIkHs7l/XU+cugU8ipYgqXaliud7ykVnQl/1Ik3ZCnAyhtqs2MEDIuGovzFnUNidA2+1j7a4icLYDp5Q65MaqaCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755970042; c=relaxed/simple;
	bh=5mQ5TAyduzyoir5ioPBW61IHUPHBdHOokgstGaDR/4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e72dJZStr+NceuCq/jNF13mHB3/PXLay7Osf980SHIcRdFYEBucnhSlGoo9HgVEY4YyEb0FP6CQZ+NLYrNx3SsxX+osQRQl08mbvYNynYO7iN4EvA8Ihjof/rqAejO1ALNTBu2AIwN8111OIgtlShfba/uEy/w2Tv2DXVSJUt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT+cqhzh; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2eb09041so2777454b3a.3;
        Sat, 23 Aug 2025 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755970038; x=1756574838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxPm1yRekm/+3b/b/E2m9eg4tpzRVDbuEKTHuhBVPyI=;
        b=cT+cqhzhfdofQw2CLwHjcJLuUcf6NnwbAHZX5ZR4sM1Y0C9tbVXNMvg2PTFd9ylN28
         UTMwI1Dx5CwHLwueEzVFYxZupBQAgu1tKuoyxpEs8pV3DL8dBTe724uPDRIPbjK73vVs
         YgkvmqYNHhU/Us4XhVrqz4J+x86seHXJnsoCA8ZvTa92wjfjPGrv5JHqdMsslpIhCcRK
         Kb6pOSthvpUvTuEt1i6LeaFWDCmqr/2JR6ct63ntUvhGTk3JbU9yAMeCaUhBNRo0axoB
         igOwIQoE+RkjLkG14WsvXYMIYvbSPiyrQSJul07AgUofhSJAQ6BP3gyY/KvWN8PNlPkv
         qvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755970038; x=1756574838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxPm1yRekm/+3b/b/E2m9eg4tpzRVDbuEKTHuhBVPyI=;
        b=ICjkolgkNTNl9HaWqSSE75cEbrkY1BoH6Nk2Lrdr1WE8b22z88ol0d7Kc42rnTKAPB
         bpEJqXNd4zZAoPmaqA8y9Ek4VK0v4cbp2Fhw4/LgZ6Wzcq5pvuxgNKSB3QAGg0RH2DEU
         nUqbRqBL+H8CXgFxHIihO0gHCCmX3mpzVklAhhVeI2R55uHsPPFylPudpJHM9FMTgXdq
         N3ZSPsd48+J6pVMk1mllYGgcj7xTbx8o6MTa4GjIm8XUKU9lC7XcDReG6qGxWn4u4nxV
         ve7Q/f6H4sxd2B5+3DcT0P19GHfzEsy4A/FpnqT1KMFQiexs10n2YK4ROuUCwx38Ai/s
         HwZA==
X-Forwarded-Encrypted: i=1; AJvYcCWGxSOeIu2x/t5AntWKVY1i3QVyAlSNDQBn/GsJ+l5P2qGMiY8MfmhCZDu6tdvPIrjVkVucXgMo+bA=@vger.kernel.org, AJvYcCX+7zJVhFFu74U30qgpRwXqZll2i0ai2EvMUENmVqoXU7xiSBpAbPjw9MrwpnA8Av5g0ddwW0sTlfcGOV0h@vger.kernel.org
X-Gm-Message-State: AOJu0YxDaZ2+pEyVzu21pGbA2JsZnoPk0F2nn/5fbQ/IUtQJZy+Qmn+W
	aBj72lMyYZSgFHm1dNycCBBx80Shvtv/zAykUVvKZvsKiAKD41CqaMTf
X-Gm-Gg: ASbGncvHfKFlhMVmfqYJNW/c6jhVQU7RhElUYalBAy2S07lkxuJ/x0PGlZCY5UU47YJ
	unPEbdhXGmiXpFXR1oyAYjxKhwG+qgCtkSIszkOF5UoVEG4DxP8NFJAC72W/MkEu5cUGUg+Dg9U
	wQV2AOOYFPQEvCPSEmXMVgKihNIO819hAV8qbdNrgqcu7ytXaTXaMILCq0ayj6dljthJapD3kRp
	W6eg2AWyjEFNAKNEVhALyKPPacUmI80WEJDbW5N7+xFyaWLtAmv/B3EVhnHdNXyF4t51bNflZn8
	2yJ6xX3p11mOaAX8jklmBP6TzgyroePj7biNAkg6iG4ns/i+TWcW4j5ylrA2Tdsj1S46sSvDM60
	2Kyk/pw==
X-Google-Smtp-Source: AGHT+IHWSbw1qdXlPsZeWT2i31LU/xLlq6B0wGE78zmgmS/Sq+I0Bff1BbMMJzItCwE5x/J3gmtzDw==
X-Received: by 2002:a05:6a20:9151:b0:226:d295:bd6a with SMTP id adf61e73a8af0-243408348bbmr10049986637.0.1755970038068;
        Sat, 23 Aug 2025 10:27:18 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:4498::6b2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8c369csm2707952a12.24.2025.08.23.10.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 10:27:17 -0700 (PDT)
Date: Sat, 23 Aug 2025 14:27:55 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] iio: chemical: Remove dev_err_probe() if error is
 -ENOMEM
Message-ID: <y3pmdf6swvsqltu3imitrcietjybbwtmewjmmk326o4oqzadh4@pyxfp3czft2n>
References: <20250821080723.525379-1-zhao.xichao@vivo.com>
 <20250821080723.525379-4-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821080723.525379-4-zhao.xichao@vivo.com>

On Thu, Aug 21, 2025 at 04:06:47PM +0800, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/iio/chemical/ens160_core.c | 3 +--
>  drivers/iio/chemical/scd30_core.c  | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
For ens160:
Reviewed-by: Gustavo Silva <gustavograzs@gmail.com>

