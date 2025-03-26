Return-Path: <linux-iio+bounces-17275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F896A720FD
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 22:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA21717528B
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 21:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B7C253B59;
	Wed, 26 Mar 2025 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSTVxpql"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8BD2AD02;
	Wed, 26 Mar 2025 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743025880; cv=none; b=sQXa1QFndp0iPWio7vL5TlSPniueO8sBxg9eNQFJc8LWhhuJ2UzZ1jN4/fCobQ5Z6cFfLi9pnyv0O51SgJDDrMlF82J8SUEQOQf/E3QO2K1aac2q8sZT1ppUswKXX5hYwEsluTRmrph8+c3su/zZN6aCi+RxadsNmYL1tC2hzM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743025880; c=relaxed/simple;
	bh=057SRzMfijCNDKCImBfeVk1oDT4K2sIo/2bJO/oFWSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+wlDon0awwWAXRzKoUBX7t9Av/YLfdq1RW3dd8ngopZAGd4fbsMMnWVP6YQXuYvu5jupZNsqxRqdwFs4bjjX74QIEgCJwWlqE/1P21JP0TKHjMAAyVikLGwXXMlySLqcv8QJLQDSVdwJ4dgoxu8nl2Cq5fRnhUfnZJHKtAIyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSTVxpql; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2241053582dso9454845ad.1;
        Wed, 26 Mar 2025 14:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743025878; x=1743630678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3tYy/kGS0BXULb658AxYn46DDhxyfH6Cn5tP3N9OA4=;
        b=nSTVxpqlKYMkK+51cOl/A4CnB/MlnbzlUhnG2ME/KFD88G4qEz4BSKLRywv5t+cRYF
         MrP26LthdOBh1zFcDomZiahawpsNrpS83fJu7yRrtSeKJG6O2rXwMMbvE2+fUBREHY3t
         7rh5CjKJjWXtYbxPaWBRJYdj3SDBh2qMIyFHDn/u+kC0bmiuAJQbngVEAZncMz83QEiv
         VNvMRA3LwfeJlEJjLZ/EUJReDBE819XF5o/RjOdkZQsx4dkj2ar8qHoz4DVmjZnIEcAF
         z2VR70NStfMx1lZZxTS5fNRwpVry2X9p1/66F7/cXPstd4JCHZZFEBqMexgi2GeRw5DM
         Vi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743025878; x=1743630678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3tYy/kGS0BXULb658AxYn46DDhxyfH6Cn5tP3N9OA4=;
        b=oMiNc9w4Dhg7VjPBJ2rbYk+J0YKz80gkNGRVH1fL7jKDofZkbcEl11r9UJExKdGR8G
         FrlEAX7glhEcbtaFlQ9s0XJewuO7WVMShCS2KqYoFjbSgqqcoV49PpPKa98wzPR2Qx/e
         xtd9A0d1KbcaPAq4QiPixy5APt01xu1cqLIPAX9wKwP2chv5LcjgaOGvRIMdVHEE2uYb
         8wt3aV1fVHDhZXgNdqePgtOv+ugxpTcRaos2F0xc1WxVpeT9DhO91oeF7Fr5dij5aXwn
         JIkuTyqn5RePY5wehOD8gxL8xc7DRk+pW01u7kA+nRi9ThPFPQuh1SxJF9bEUswOBto8
         Y/mg==
X-Forwarded-Encrypted: i=1; AJvYcCU1tjt8DEfi2AL1HIbKQsjnIR8DkzCFEE/utR9/aJbgnpRerpKoQMTU/ThPx6cZLmvGgrXMUpne/j0=@vger.kernel.org, AJvYcCUamasn3ALdU1pUivfKnlf+8S3lfqZZqD5mj0aCikIKtT02gt4+0KmE7eg4Jhqe0T4aJLdLQXzPnogqsVbl@vger.kernel.org, AJvYcCUqrSIFo+NhRKwTV/yoTiPbbx3bXGaUOs2H+B+1xtObrDqm6/PtCuyU+5zdAzuIQS4sTL/c5LyMerAi@vger.kernel.org
X-Gm-Message-State: AOJu0YxvtdkZVeFbMNRuqySVGg4gO3kOHzPKzK+K4K22P7by8gPtx+Rk
	3UYMf86aoOvbVjtRYVV9vcnIBxq3RIHe6MsnTIkWFvplav4L1hej
X-Gm-Gg: ASbGncs/843PP9V0XUcttqBt3mNaR5LQ9BvQcl0bpKYMr0Cz5uVSakqc7pJvYh3boIK
	GSQvxWxraJT+Q2F4YXTa1UdfXWO3tKGgcjm9xczqzKlRwnf4h4ZmHyU6nJsfyY2zMDJh4JbUtkA
	sG17YWuXBmdiG0YqNqu+jF79kcG42jFMgwhMpwDO3bFKNjYK/+sol6AW3ca17Wz8mLswPdgE2A2
	b5G1fCAca7LPXDDEYgW57wAXcwoG0OoUZUos0ebgiEMb/mWWfTaLWCPTeZlOsSSB7t8DrA5is8X
	ZHp55ujpkcmzDm+QhCq/LBJoQs1LMRi6czU/sxvEKh3IOzsvwh7wB+4=
X-Google-Smtp-Source: AGHT+IG81JBcoxCSpL/yba99zPCKx3gG10RaIXSaNybvimLBCJcKk3Mk9P6fzw2KJkuwaPEoBz3r3A==
X-Received: by 2002:a17:903:19e8:b0:220:e023:8fa6 with SMTP id d9443c01a7336-2280495aa82mr17551805ad.50.1743025877614;
        Wed, 26 Mar 2025 14:51:17 -0700 (PDT)
Received: from localhost ([2804:30c:1f10:1900:2580:2d5b:b16d:c55b])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811f4383sm114338945ad.229.2025.03.26.14.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 14:51:16 -0700 (PDT)
Date: Wed, 26 Mar 2025 18:52:19 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: dac: ad3552r-hs: add support for internal ramp
Message-ID: <Z-R3E23hWiUKDc6q@debian-BULLSEYE-live-builder-AMD64>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
 <20250321-wip-bl-ad3552r-fixes-v1-4-3c1aa249d163@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-wip-bl-ad3552r-fixes-v1-4-3c1aa249d163@baylibre.com>

Hello Angelo,

Patch looks good to me.
One minor comment bellow.

On 03/21, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> The ad3552r can be feeded from the HDL controller by an internally
> generated 16bit ramp, useful for debug pourposes. Add debugfs a file
> to enable or disable it.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/dac/ad3552r-hs.c | 106 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 100 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 37397e188f225a8099745ec03f7c604da76960b1..41fe78d982a68980db059b095fc27b37ea1a461b 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -7,6 +7,7 @@
...
> +
> +static ssize_t ad3552r_hs_write_data_source(struct file *f,
> +					    const char __user *userbuf,
> +					    size_t count, loff_t *ppos)
> +{
> +	struct ad3552r_hs_state *st = file_inode(f)->i_private;
> +	char buf[64];
> +	int ret;
> +
> +	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> +				     count);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf[count] = 0;
Shouldn't it be
	buf[count] = '\0';
?

