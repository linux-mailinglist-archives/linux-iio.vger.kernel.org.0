Return-Path: <linux-iio+bounces-16386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEF2A4EB15
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 19:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977771885F3B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 18:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19D32512F9;
	Tue,  4 Mar 2025 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IM1ITgS5"
X-Original-To: linux-iio@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159ABA2E
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110902; cv=pass; b=dyIYUd6IGQjD25kfit8qFgU3QQAg305u2IUQcc9Y0JJ5UgnkDDdqXspXswWgFcHsyqNC2KNPNv+LJUlSUa1nBpcHe9JUTUhFk7HQoh54Mfve6AJj1nzpSmh1LdcYB9joW2Zs2S728Ik730B767wl5X/LsDs4Z/g8HPQoYt392ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110902; c=relaxed/simple;
	bh=zBpdfr05Ho1fS7EiczKuumrPUmBYTKjWBPWuy/77H+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNi2mZapM2wSRFXiTh7kMyTieAmDGGjtajkkRstl29cgq1Joo4CLMcRSq2uTUd2bal0/NPJx4JAvzCE90RrJ7OZERtrPTPlITOFGf0L5s4xMOYpvE/SdulrYRpmEuERtuxx9lkMtHj0K/fuOqBKFti1j9zjgWhcS3iUfac8RVYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IM1ITgS5; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 9513740D1F47
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 20:54:59 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IM1ITgS5
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6f455VNQzFwVJ
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 18:00:05 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 8C3514272C; Tue,  4 Mar 2025 17:59:59 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IM1ITgS5
X-Envelope-From: <linux-kernel+bounces-541743-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IM1ITgS5
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 4703841FA4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:57:08 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id EEBB4305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:57:07 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A44C164076
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408E621149C;
	Mon,  3 Mar 2025 12:56:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3C420FAB9;
	Mon,  3 Mar 2025 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006604; cv=none; b=e8UsQpMHenxwHhulhSLjDr1EN1DwsCMw44dsa3d8EkAAQujedQXMrCFfs+T36rdGb6OIRz7XXTMP7acQR1iBNZfYbiUhgAj8Nb8DNiXRDNlZz2B6Je5yoABWwsLcIs6+GEFk8zTTwOKXsoNNsQl1AEfRJzqNmBDsZG7KCE/zF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006604; c=relaxed/simple;
	bh=zBpdfr05Ho1fS7EiczKuumrPUmBYTKjWBPWuy/77H+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKdIKRtI7+O9FuTh665EUdMp4GvXKO8MuywCGz8/N77YKsL1S6ceIPhqogYr9m2FytXJN6zD31MTl+3Q95fU5QazvuQDTu29YM9fSwxQusZDJVbybChs6ipcerczn1KSDfqrL7YswnP/O1kZsKD3vUOofC+ufxBtgO8JtyB8sT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IM1ITgS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E696C4CED6;
	Mon,  3 Mar 2025 12:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741006603;
	bh=zBpdfr05Ho1fS7EiczKuumrPUmBYTKjWBPWuy/77H+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IM1ITgS5ZODPLmGIgbVJnVplYiRlss2mC9jCTrj9YNAC40yHKVNYXbMufpYsvaKRO
	 h2XILlNtqXI3nOCPtVJXjSLCNp71WeQ/8Kmg2mE4R2JIhZONky7QfScKcveFM2MKjk
	 EIzsefVdOb/2W3GJYK+IydJawPbeV1xxc7fll4M8=
Date: Mon, 3 Mar 2025 13:56:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Saalim Quadri <danascape@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: iio: ad5933: Fix CamelCase naming
Message-ID: <2025030301-niece-evacuate-0f05@gregkh>
References: <20250303125246.342704-1-danascape@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303125246.342704-1-danascape@gmail.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6f455VNQzFwVJ
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741715570.59109@bQzLGCfw6ngIAu+DOfEZWA
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 06:22:46PM +0530, Saalim Quadri wrote:
> Reported by checkpatch:
> 
> CHECK: Avoid CamelCase
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index d5544fc2fe98..a1a5eee4f736 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -43,10 +43,10 @@
>  #define AD5933_CTRL_POWER_DOWN		(0xA << 4)
>  #define AD5933_CTRL_STANDBY		(0xB << 4)
>  
> -#define AD5933_CTRL_RANGE_2000mVpp	(0x0 << 1)
> -#define AD5933_CTRL_RANGE_200mVpp	(0x1 << 1)
> -#define AD5933_CTRL_RANGE_400mVpp	(0x2 << 1)
> -#define AD5933_CTRL_RANGE_1000mVpp	(0x3 << 1)
> +#define AD5933_CTRL_RANGE_2000MVPP	(0x0 << 1)
> +#define AD5933_CTRL_RANGE_200MVPP	(0x1 << 1)
> +#define AD5933_CTRL_RANGE_400MVPP	(0x2 << 1)
> +#define AD5933_CTRL_RANGE_1000MVPP	(0x3 << 1)

No, these are units of measurement, the "m" is correct here, right?  If
you change that to "M" it logically means something a lot different :(

Please always treat checkpatch.pl as a hint, not as a rule.

thanks,

greg k-h


