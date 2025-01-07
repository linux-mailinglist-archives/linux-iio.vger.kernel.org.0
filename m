Return-Path: <linux-iio+bounces-13954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E21DBA03DAD
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 12:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523001886994
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6351D5CE0;
	Tue,  7 Jan 2025 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4fYn/75"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580018A6C1
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249345; cv=none; b=uLXQLs2uijtJKq849gV1jSO87ktbytf1XnUK3bJkJGUWYdsRKtSSuq+eDjbh+b2eOJ+9NYXLb8N+lb0sQv3Q6npPxXbLf2SjVOvhJBxuiaecqh8iyCTNXxKNF+O+vqvowtxKjVJjMweb7hPgdIZs159iv8lI/atgu0c84bJurJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249345; c=relaxed/simple;
	bh=xJsTxgnNBNceCsS6YgmO5KNCleUnzDrhcZgnclMsZL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXW7N3GugdigD7eT19Uk9kxL0Sxz8Jwvh41j9Oy/Cqt4BYS4RsO0riIadTLvGOC7YN1EWYxLos4Ogu2cvLiOdPAUonqJfQnwmQdjQtjbwDaHkB1tx+QrVcw/WZHI0bhouGwkUIpkrNr1LgNeeCC0xnIDXCWe9y69QAQcxLLEUz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4fYn/75; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-219f8263ae0so176974125ad.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 03:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736249342; x=1736854142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rk54K8gCqowlm6wLU6qf9atMv9BYp+jbF8pHDPgrmuk=;
        b=N4fYn/75wYuV32QN/+xrCnlb4fLbmoh4IkIei3Gm90daaYAoFEcLhcR/cUseON0fC8
         53iO7fxFBhn1O2kq8xlOlsFXwmCvFto3IHnECcrX6U4Ib2GV/+uqubp6AaYGeXGDL8/V
         7WagUJ7Dh7yqvBOSnYGxUfC70VKaGzvpviyec9DK2C3zgBzHFKo8mboWMKqmBYSv4BoY
         LjUNTUqXuNPf5eTrDdWA33tWte0LPNUaU3e0wwfNW1QCCqT667owb08qgAqHMIql3hwZ
         NzomzQctw0NR5sK6r5ATmubjPvyZse6t0vIFJpSyu72llSk2X46UyCWMBWNCyU7OIFXO
         lEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736249342; x=1736854142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk54K8gCqowlm6wLU6qf9atMv9BYp+jbF8pHDPgrmuk=;
        b=Aqtkf38+aEuumWPDEXwaZ6a5zALO+5eQrMillHK+Q1ymiswP+ZJZETXk0DOZTgNxqw
         /qJMNTfx0Osa8u/w5y9/McytXdEKJTjtjc4B/kG4tkdEuYou2VkyTDbwCoZV0+8k3jk1
         bGIbPNKBvWw878c1Spks6mtuBm7FX/5DDHDk7HmlsIkUZoKVBDI9q4zEjT2I7FwW4dmh
         0O5eBF1jV0C4BpO+tumlFi0yvUyfSOlPggstuLPP9wnBGrD1MFuLG/Y3ch5Xvx8h72nC
         A/tFqwvJ7OqNC6fY/tyTdyjlo4BpyBl0gCll4fIlCJRx6SLjSu/JfXbVlForXBXgGctr
         Sv/g==
X-Gm-Message-State: AOJu0Yz56oylNkiISvMsuNrM4So7pej+0acszqXXLKJBXowbUx7vyzBE
	dC6dxVxkWCYS5Gj7xj8I/IE4jdT/TZp71pnzchewu56ob7BYliN8YHmTHQ==
X-Gm-Gg: ASbGncsUv5+9s/W/++CIwLVrjcvut+Zi6QCTS3tfaS5naE5Q/Rmbds1xsHKXxdx302f
	IX2muXY5Wztde8cta6LsdDZe9ST1WCaPNn5aiAkUJEeoIx0uYXMnAO7J18JUzBCgF1fWrrkEfbX
	bKaQWQ74AMoiojNtimMs72xjFEi8VEcXhY5Fc803WUTd+F5BIW7CTLX+DhMlrsgW15uHn6eq8n3
	RM6h8PovREQ4olC7c7JSHHqwvCA5ewMepR9fMK8+VSUmIrTpUFoXinLD/Pe5M9W/Ec=
X-Google-Smtp-Source: AGHT+IEG7HwBydUTY9jm4RBlJavgfQOOhgIY+ERO/68Tfk1RbmzXXUvmjHMVxTpo4GC3a/C+CA10Tg==
X-Received: by 2002:a05:6a00:3910:b0:725:e37d:cd35 with SMTP id d2e1a72fcca58-72abe060d9fmr88468078b3a.18.1736249341561;
        Tue, 07 Jan 2025 03:29:01 -0800 (PST)
Received: from localhost ([2804:30c:4057:c200:dfe2:5075:a83a:1a44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad836d0fsm33102210b3a.73.2025.01.07.03.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:29:00 -0800 (PST)
Date: Tue, 7 Jan 2025 08:29:36 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	=?utf-8?B?4oCcTHVjIFZhbiBPb3N0ZW5yeWNr4oCd?= <luc.vanoostenryck@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 09/27] iio: adc: ad4000: Stop using
 iio_device_claim_direct_scoped()
Message-ID: <Z30QIFr12sw7Wajd@debian-BULLSEYE-live-builder-AMD64>
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
>  drivers/iio/adc/ad4000.c | 61 +++++++++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 23 deletions(-)
> 
Hi Jonathan, aside from the spurious blank line noted by David, the changes for
ad4000 look good to me.

Acked-by: <marcelo.schmitt1@gmail.com>

I also tried running Sparse on IIO subsystem but didn't see any warns for the
drivers being changed (nor prior nor after applying the patches).

make CHECK="path_to_local_sparse_v0.6.4-66-g0196afe1" C=2 drivers/iio/

Did see warns after adding incorrect type in assignments in the driver.

Mind sharing how you are running Sparse?

Thanks,
Marcelo

