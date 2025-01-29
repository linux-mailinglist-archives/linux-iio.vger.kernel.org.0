Return-Path: <linux-iio+bounces-14719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0577A221EA
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 17:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339941622A7
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 16:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096B1DE4ED;
	Wed, 29 Jan 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN9GjDTm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A6143722
	for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168865; cv=none; b=ncLj0lxYGF03FcVSXk9PZYhzmlCPrHn0C6Oa67Fd6/BvAmymqW7a3qWV5Rhis9UgJPCgM/fG9n12gXha46ngcN73EEF5CFbonWZVzU73yPvvvJpVUdaY29T72p2rllwBczedz6lEIHSG6Op2DAllTXxnKE6R6xEKg0XeFFpd2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168865; c=relaxed/simple;
	bh=C7KYobmsgpL4pc4Uqv5XP9ljuDIGsXSCFuaPALxgEl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkDdL7eVwNUbVqoD411ri0Btz52L0xxhJCrtB6Z0YXM/7j9CogqSRsV6Pb+7Mhp76vv+dmecCi5OxDd7xNZM7xa6yhtcEfB0ZGqDY1QogNEB5iVvUszfr2wlO07ENwQbyO6p4/19zSnajUszID5BF8QlYFCW1IzSWbV49+EVSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN9GjDTm; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so9486509a91.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2025 08:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738168863; x=1738773663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sv8pjRcQx0Qisg4UmlZrZqhz6I6xBU9Zlx0F/EGKFx0=;
        b=iN9GjDTmeBPe3R6RH1Nh6bzMcqxgWrOpBZfR2wBZwSkP2urpzM5BfV3RDKWbs8LCzR
         YOSNTiO5khWbiV56s9QsZ4wSm/vbiFAdTn9aZC3ruLW2ZbWqrmquo+VM76NBC14vzfrJ
         wxLvliuSbDyYpQzQz0wyj1gWCWd90QQmkMDIYARrc24DtWjzkFgpPLWjtvE97JsU48zL
         UOjkln58P+xp7Km71T3uiJt4gFyqYuxXLjrYxsebyqg53SY7hKf6MlsUoBsXgJvw5qHB
         pD223NkdR/Gp4Zj3cbuzeKWMkjHzOXlrmmtvoORooSx/WHqy4U20wBywoTmdwJSXzkLd
         5GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738168863; x=1738773663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sv8pjRcQx0Qisg4UmlZrZqhz6I6xBU9Zlx0F/EGKFx0=;
        b=Z1HGaA83HhMzNbdU1+TMSa880BDs2INEynex33r7Q7y0RM1L/YLCxeI/eHaGGp3O8L
         mSsk9WvdIPCDABtfSLwDeZNHXbm60svPr90hFepX740YRorJBSXKaiHsrEwTsWKG7HrJ
         kvRFaKxSP6h9ga6P5QXLMPwaHpQLTCnbUasBnoNkEykipJxfco2G9//IiwGLR2FLtYvU
         GCkQW2ozhOgOGoHoV9dvi6iJ0c25k6ooSGEE2QpcRJ2TFq6GocDA//8nVlX4gHKNiNjr
         Wz7q2n9MKZtN14MPJFEEiXkBmh5LChFalJlD2sfc0bN1OP9VqkF9EBvXB8YO/nxJRhJh
         F9DA==
X-Gm-Message-State: AOJu0YyxFwtou/jVk1BecjlfZKyT/tfK9OtmggOwRAhp7Y5yaIUt7tKz
	LBFl4lPRfTzNucI+VJnwTVNBiUsJaLl3AerwcielGEJGVY8pgqn4KbC/tg==
X-Gm-Gg: ASbGncuTNfvZFzW7xm3/lCt0gVBJHB9GkcM/cM+NSvv6u/uSJPypwk20y1JygIHMLil
	oBp0FfHtZjgmbIjFhAZb/mku7BFkEVAAQB4y6KGwCcNFLDahSrruRd6Q5HEnSsPFsJpLKPqaS5/
	uvivegHhIBAmn+W8Ox5fb30Mcr3KxMbvQ0ZuDblNJkReHVbE+doreulNqzqjwqOnf4kr4hI2UC/
	XarLyLEBApsnUibdG2FGXC4JWs7c11RTBW/kWFneY4dN/1W0Qn+45wuDZ872QWGyzhePT4OSRx2
	RAcvFjzT28+cSrvrKQWcAyfd
X-Google-Smtp-Source: AGHT+IFV9MTg2dxy/yLQzCmrSynwyZcwmv0sqI6h/TwG6Zzy5+LWMDQFFK8OpzmKzzv3rSDhkJmHdg==
X-Received: by 2002:a17:90a:fc44:b0:2ee:b2fe:eeee with SMTP id 98e67ed59e1d1-2f83abfa2f3mr5969978a91.15.1738168863585;
        Wed, 29 Jan 2025 08:41:03 -0800 (PST)
Received: from localhost ([2804:30c:b39:fa00:e13a:6da3:e9ec:bbcc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da413f474sm103155165ad.130.2025.01.29.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:41:02 -0800 (PST)
Date: Wed, 29 Jan 2025 13:41:43 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	=?utf-8?B?4oCcTHVjIFZhbiBPb3N0ZW5yeWNr4oCd?= <luc.vanoostenryck@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 09/27] iio: adc: ad4000: Stop using
 iio_device_claim_direct_scoped()
Message-ID: <Z5paRxKxxOJZPJMT@debian-BULLSEYE-live-builder-AMD64>
References: <20250105172613.1204781-1-jic23@kernel.org>
 <20250105172613.1204781-10-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105172613.1204781-10-jic23@kernel.org>

Hi Jonathan,

If you end up not changing this patch much, please consider taking my tags.

On 01/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
> 
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Tested-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

