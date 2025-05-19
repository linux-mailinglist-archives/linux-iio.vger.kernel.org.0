Return-Path: <linux-iio+bounces-19646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 339CCABB447
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 07:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43613189347A
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 05:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A561E9905;
	Mon, 19 May 2025 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Suezyo91"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A728E8;
	Mon, 19 May 2025 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747630958; cv=none; b=NWyc262d3PKVlza8dPMqZ4Uzp90K4WdzQfHzaNgAn0WoAGhV7KbDzR+tc3z9tV4/x5wyBdrM2/Vx6f5gaDrvn8xmWsJ8cgL82mTtS6deKiO/wN4eUdkfts+5qe6GZRoSTuKpnbk/f2Ix2TdzhYfmPccghMRrb2Ucdv5vS4gpomg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747630958; c=relaxed/simple;
	bh=p1gquzaqu+Om0MkOGnIz75aDTvfyEbAoDstn+p22jI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brRzslEYriE2uoLNyPjuuNw8aDi0+jCe/As4MkgmacSwEVPImWlAE5uCLXBpCzWbFtLsOs7TNG7m/ILEMDAQkAH2ZmyJtMuG+7U2ayQujnaQ7gb4dmMzqHTmJFrblIbIKki0e3Lzu3vfMnvTIvjbTmiKTx7i7F+kJjryuCb++3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Suezyo91; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54e816aeca6so5636739e87.2;
        Sun, 18 May 2025 22:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747630955; x=1748235755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVlbgkQWHhic3i+kYMQHejSHv3bnzz+BwyA3qqAUb1w=;
        b=Suezyo91Wr+d6JnEBjPCPMZAkgHhgPQ4GlZqRyfxp/Im32+i50Jf7pMWV9y6Z3LVFk
         btO3fi2JtcyyfxNFHAOZ2Tpv5MeokWYTbHkfRuHvgX7xgUJSeGmlXxT5LfJIJSZ0bsw4
         7EZu7k/7kI1317HXcPq1B+PKQr4w/JqTryrJOVLXyNxCVSOa63s3NgK6L+ZkRd8HxPaI
         tPnFsvO4mbDFvHC3kxZYCRcXN/kgC8BW+u2Jv//6ShOEFVvzRUsaKYTjJdYqyHaYZIs6
         tkhbxxz2iaIeIx8MfHgRQrwbccqbK8ALtQhr81S5TfXHkh33R1zWA8qw2txGmUDN0PTU
         PSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747630955; x=1748235755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVlbgkQWHhic3i+kYMQHejSHv3bnzz+BwyA3qqAUb1w=;
        b=LA1OiCFDlLJbkQHHoO7THNvjiHKBmEGdzVaURKRzU0HfaEEsnn8Syfd+FaE5kjN5Gg
         FlUwz+39L5TInYWJR9ztBV5NTnxo6npERFLPwRy7F+4HRsRbXdEmINBbJnLH0AWB2ys7
         cLyEDzbpz12xgYbIupQNNGjus4Oxx2vACPhlsS303DG0J7828L/LgzyO6d5uZBCZsz4F
         HUIREl8+iKfTujPAWXMX59+Ks9PuFWKoxiZXyWNun1VAFHI8vSPEvA7bHZ4nrSgWet/f
         y3vwEpXyJazosnOcJ62wlii8qZuqmLbJPKODJtVvW68jbpibJ0MftVLeyDWKcjvsF8al
         Ba7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6Hen01PzEZN5vAypstzdi4QRisOfR6z5J+scgn9ePVPXXvwvVVQCjJskP3xBTurKGegeRMeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzQGxX29JZz32rFTijjQfvGneBLWsKBVzmDwItHnK9rD3D7QS
	k8v0XLrquRLlyR1lGGr4jWxluTlIYkOwHiGeFc/Bai68ktqf5DGZ8gP68q+lUQ==
X-Gm-Gg: ASbGncsNqgi7cyHiTHd7SXPcb14Sn7vniz0RwM0issdCiaxSMk024/ghxtyg12n0Bzw
	33BBW0o5xKTHxN9BS6/jQ4GndjgDOTAUxXosnNIPsW7UWZ0ouodRDC91cenXa2oM2ULujbIrl5r
	UXMiF6VbK8JU8TPpIkZ44C7dseAwkCNMaIptTVBBakJVRq3C/BFvBq5QsOlGeTIp9jdXysVWPLx
	q1Myq4RUqhrUWrnxB3+JwV92Ymza9OsQot63U9PhvNMpt5T9ogKmh2lFavV8XU9bPhxYoIvS5I7
	ckqW3xwNe3yhE9oAVznySEgJkMFzTV7x5qCF8CE9K3kVY6PEbrVTegdG8GO1laqAclHPJcj58/v
	DxK/TF39opa4WSil52h/lU2FNiqG6IiVM
X-Google-Smtp-Source: AGHT+IH/SaROa+H+IB4btC4PK+MG0yExwt9dxg2TCQPNgnRco7VPTx+gsxSVbeKPNOjKOsrmDRY+JQ==
X-Received: by 2002:a05:6512:630e:b0:545:576:cbd2 with SMTP id 2adb3069b0e04-550e71978e2mr2492278e87.10.1747630954594;
        Sun, 18 May 2025 22:02:34 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e704026esm1677793e87.241.2025.05.18.22.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 May 2025 22:02:33 -0700 (PDT)
Message-ID: <b6113648-1832-49eb-a14e-460c388c3e53@gmail.com>
Date: Mon, 19 May 2025 08:02:33 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: max1363: Reorder mode_list[] entries
To: Fabio Estevam <festevam@gmail.com>, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
 stable@vger.kernel.org
References: <20250516173900.677821-1-festevam@gmail.com>
 <20250516173900.677821-2-festevam@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250516173900.677821-2-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/05/2025 20:39, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The IIO core issues warnings when a scan mask is a subset of a previous
> entry in the available_scan_masks array.
> 
> On a board using a MAX11601, the following warning is observed:
> 
> max1363 1-0064: available_scan_mask 7 subset of 6. Never used
> 
> This occurs because the entries in the max11607_mode_list[] array are not
> ordered correctly. To fix this, reorder the entries so that no scan mask is
> a subset of an earlier one.
> 
> While at it, reorder the mode_list[] arrays for other supported chips as
> well, to prevent similar warnings on different variants.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2718f15403fb ("iio: sanity check available_scan_masks array")

Same comment as for patch1/2

Yours,
	-- Matti

