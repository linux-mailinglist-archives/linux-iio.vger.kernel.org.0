Return-Path: <linux-iio+bounces-16715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD7BA5A6B9
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 23:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F673AEDA0
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 22:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092131D8DF6;
	Mon, 10 Mar 2025 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yL0T6+FA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3336B
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644434; cv=none; b=il60fyu5RgeVlDXws3msBNjFRIlDwuIvuD9dESh+XuMn4q+Mxmcdouy4XGxsUFxERAhl7jHpn0nBL0XetTpJTYPguG9Mq/MugmJertUCSqEYeGm4Sty4/C4BCxXsOyU9zkILnHv6V4VxaxlBw2CCnR2BZxe09DUuLZdnP0Z5bB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644434; c=relaxed/simple;
	bh=EMuc8COp5lgmuit9b8G1Jfo1nmkDQ8RxzmH2Jrg6LBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4+jU/AJd2c1lNXA4wro7EPtLEku0d3Ych0tTMKFFOaNYsUHcExmWdONW5TpYZoN7oVEB5MkiqmbcMqry4nT4H93VMIYDGeEnvfd8X1/w3ORNpyFnEH5M0jjqyDaL/nFO463tj+soTXsMP8YivdP08VYjCZ+hgVAKmGAitM6gzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yL0T6+FA; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f6a92f234dso1144871b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741644431; x=1742249231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YVhtSoFEXa+CZRwBeTvjPdgas+Ot3CgVVeSUfqfkCk=;
        b=yL0T6+FAZBnTJayvqW0qTF7RkbWx+w6H6HMj8maMG3NMc3u2RzOn0nK7xBqXAFvUQK
         1Nlnwvcwff/K9LgfuE8xV5fP4om50zvxX3q9CFxq9SPb05pn4+nSayyAPNbiQ1L/Nmow
         cMz83j8bBnDBWJXnAgg+P5NHeDLJiMorTpr5LeNOLA+AYpcd5uZes7cC5XXtaK1ub+wm
         uL/rh983gHP/y77lRu5ibfK7ZZd0lbab83bufDDi3zdznons09gitOTUAQqpNnZPt/xb
         xRzIhTgdkaGFbjh5G3VzICkRmOkiw2oAqBUFXAJqoECNqpnGLqJCLJ5NYDH0KrSwcsqj
         nH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741644431; x=1742249231;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YVhtSoFEXa+CZRwBeTvjPdgas+Ot3CgVVeSUfqfkCk=;
        b=g6UyI0dQGYocYX3BluP4Ute4FBepvLNQirBW/tVaiQxSRDm8TCCybNe6GlMt/i90ZJ
         yUJDB4uiz9wI6p18dXAlR81hp3D0qPaofpLJQR/X7zqx43KHnANdGQaqBelqgMtZTgbl
         80M1ykWOhzml1DHYc+tZOLDHF+XWbjvkj2vrd3oiqfK4LWqT9xkbS/zK5YWY8EGbmHwQ
         Htejf/Xs7lp6D5LWE21TV/KIB0IxpC0X8NWNQvCYYVRFXsUC7uZEyoP6kzSpMTQwEQ22
         Cuq1t5seekjnu+Qe28ndA/daECRkN3x0RWOZxBrTZ4Gf2b5HPQs1itnZnqoXxNWi0Cvr
         2ZVw==
X-Forwarded-Encrypted: i=1; AJvYcCUaLzUa/zcOnh8u969dnazYLTkuLbL33g4SxK+NUECt2J4KG++TlKtwXRrDFFlCyfNcgVvbTbmKQ2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjlavgfhlsdfQFja2LrRCp38EW3YHA3U72h9qWDDnFswmCBqlI
	rZWikTnC/1KGl8E+ZmVGgXv3jCozCagJs/tplKBbm7wJbffhz2TyRzAWva591c0=
X-Gm-Gg: ASbGnctPusiNAGz5Xqyya/63E7PvIQKjK3XW3/qZX7MIhCpDvEM1Oxmo3JVfTQQ8qpM
	4v7NW4D/EVfxYUCP/N0mqRtjBkxX2wINN4xWplPsf3HDeut0Xhwvu4iqvL2ogxD0UgHyfnkfdGJ
	8FeWeWEd0t51ajMx61d00nCwyVJGC6aXxAK/8ElBwajKsJE83wQMWOCPlamch2hhX1FSduzQKPv
	rkUIxX+dcn4pO5Z9A92+WrJRFDCdfbEQix9+7Vg1wfiY1FBlau+Ohen5LUXPrCRL7YThw3pL7pn
	Rj/8QfD02oAc08JoXOqPExsxvXaBB2id4hZH8jT9RPZ8fTNrDfrvMNGNTCumXnSgz8FOGzyk4nX
	CnmrNHQ==
X-Google-Smtp-Source: AGHT+IEZNSPv1xKZpKapEPCvrF/pcfbZqrqd+oEvSGtA3HM2PfGG5kOL6N5HAyUmV2E7V8OVdqtJ1w==
X-Received: by 2002:a05:6808:1506:b0:3f4:1a7d:959a with SMTP id 5614622812f47-3f697afe2d6mr7981257b6e.2.1741644431603;
        Mon, 10 Mar 2025 15:07:11 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6005d95dc9dsm1191282eaf.6.2025.03.10.15.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 15:07:10 -0700 (PDT)
Message-ID: <bd68a271-8c31-4331-8409-bc924e4c93de@baylibre.com>
Date: Mon, 10 Mar 2025 17:07:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] iio: adc: ti-ads131e08: Use new
 iio_push_to_buffers_with_ts() to provide length sanity check.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309182100.1351128-1-jic23@kernel.org>
 <20250309182100.1351128-5-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250309182100.1351128-5-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 1:20 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> By providing the size of the buffer used, runtime checks can be performed
> to ensure not overrun.
> 
> Also change the pushed data pointer to be that of the structure that also
> contains the timestamp.  Not an actual bug but semantically incorrect
> to push the channel data when we want the storage with the timestamp
> as well.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


