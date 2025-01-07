Return-Path: <linux-iio+bounces-14013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF95A04DE6
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 00:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7453C3A540E
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 23:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDCA1F63D4;
	Tue,  7 Jan 2025 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yVBVnSbp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944FD1DF27C
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293861; cv=none; b=IPNuaXVW3WWujTRGJ9QiaJw9PLyjs1KducC5cslo1aa0eOlUmwp2YG/ljPIqMNRuwVCFaiVa1T+5Pnem5hSife38ZCN19XGjT6Q4MMzEWstFzKo+X5q5bCP5aVBoW9UvuOpPj5SYM5pKjKYfLuC86r6e+Gl+0zCnXqYmLqa7oJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293861; c=relaxed/simple;
	bh=9VpUmzYiTMqpRssvnvfD7S7WSlpD9f7LMaXqYjiaWl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YP8qE2162lJKa8X9JnXn4RKbeASwGRFMyv6BkkuR8DGICCAyS1TCxj+prdLeWaKO3GsbRVWYsg8pNB1Y8HC4NEBPh9mE5YZ6wcSWcI1C912y6YPZx7K8Hq18TBvHTcg2HGa6yvBGXkEa8yUhtFiKuSFHYoRGu8AmkJpdGPvMsdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yVBVnSbp; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71e2bc5b90fso8504735a34.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 15:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736293859; x=1736898659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxe5fK9+PaockwMQ56BVWMGy02hAR06xAVeNpiyd0xw=;
        b=yVBVnSbpqRG6uLjMdgTHjNK952b0ieTTYcBMnENts8CgZ9JJH1IIEPjMTFxE69SYt4
         CBBLpU9sNIxIeWgjQZnV2W8o+uy0cGDU9PpgJ5SUevRyBGU2FxpDEqoIKF/H0SrVo2nu
         /RpZjyxMWPK/hiu2J94ndQtqI20YU9Tu2kDWQjf0mHSwj52i2Y1lCx6FQr9+wM+oC+Rz
         EYEgSxk009jgUuOJGtTnZc2j5xw0mZFbxccWnJGYOl11oXzuSt+dn6upgpin4yj1MSvj
         5Mhj+eMbNiF3dvIWayLo+83DC0ESHtFmNJbEuL98wujMbnLBSUc2VfBwgLVhst7epm5V
         ig7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293859; x=1736898659;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxe5fK9+PaockwMQ56BVWMGy02hAR06xAVeNpiyd0xw=;
        b=BQ/Epu9hc+IoS3Etr4QsC5MMsnxmygahatUMzPve3va2QowlGRUm+cNhd2jBukot6a
         eC1lDdoSD3UA0o5c/1tGKIcm5XLunmQ7Nax/oRL+ZAC+OYGhpM5L60vA8A5Wm6Qbz0rG
         N7wC9wAzKex05YKiHppkTEOLPKjLeA5ebqXCmS/F75tpT5JazBnahkC2OW98SJNKpeEr
         MRtXW2IGqZ5h6FIKpqJED3Y1HvLwz0xnxH1igZiTLYbLb9V2m2rZTkti6NXMZw+InXxy
         4kyDt66p8bDeBR0m+JusvNw5jb+XYr5RpqeA4qp/Xt3vrNINNud0NfIyorpKRWdeyQNd
         014Q==
X-Forwarded-Encrypted: i=1; AJvYcCVM+6emDcWg2+k2smF+6czymeTnvCNBK/j0GJknWRQCrArFFFLkuQVvdHbi3fTYoju4HWgZOo+Q0is=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGtEVztzkOV6gP/zg2iVTTntK+fLzFnLG80NfEZvno1wfy3Rn
	iltStkAHBwvnzTElixaJC+2Bu69z602RwxQn3YJhwEIMDNyG2wYbj77a61GYJ0M=
X-Gm-Gg: ASbGncuqEk/juS3eKFYw3dRILLK8Uw51JzUx/ofVFSxgyP6mWUO7IRB/nB7QuXeqbA4
	G9IcJ4LodJZ+s97oRzep02z4pjQuxeJI+qTpNazQ/23yrQ3KmKDszL+GwvGzOfR7ei4cbLyrrCG
	RBB/T6Cr1KfAr9VhBdC/T00h9QqEzpwK8SDk0W5NdsOpFyPaZMPAL4zTcmPAN+lEoo73Jet2iNn
	+dchbaQ91g+IqsNisSYh6YF3wpFldSn51JeHO2EiaxZB7OOeVTuef5nSzd1Nr93LwBsM0kuoXsF
	WJCiROAv0jvHjewfKQ==
X-Google-Smtp-Source: AGHT+IE7yzxUi5oQvlLU3DlUFKJpeT4/XYqyGq1OtgTEXGDgGaina2HGVk3yHfNdQybXSvDKsrKkKw==
X-Received: by 2002:a05:6830:3748:b0:71d:f239:c0b5 with SMTP id 46e09a7af769-721e2e52e47mr548687a34.18.1736293858780;
        Tue, 07 Jan 2025 15:50:58 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc938998csm10831203a34.0.2025.01.07.15.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:50:58 -0800 (PST)
Message-ID: <5d492f38-b103-4850-8d13-ef1fd1d2c483@baylibre.com>
Date: Tue, 7 Jan 2025 17:50:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/15] iio: adc: ad7768-1: add filter type and
 decimation rate attributes
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com, PopPaul2021 <paul.pop@analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <b88a167234c49a66792c0d3e182bb40b5b695b5c.1736201898.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <b88a167234c49a66792c0d3e182bb40b5b695b5c.1736201898.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:27 AM, Jonathan Santos wrote:
> Separate filter type and decimation rate from the sampling frequency
> attribute. The new filter type attribute enables SINC3 and WIDEBAND
> filters, which were previously unavailable.

See related comments in my reply to the documentation patches about wideband vs.
FIR and decimation rate vs. -3dB cutoff.

> 
> Previously, combining decimation and MCLK divider in the sampling
> frequency obscured performance trade-offs. Lower MCLK divider
> settings increase power usage, while lower decimation rates reduce
> precision by decreasing averaging. By creating a decimation attribute,
> users gain finer control over performance.

It seems like we would also want a power_mode attribute. We already have an
attribute for this for used by accelerometers so there is some precedent for
such an attribute.

> 
> The addition of those attributes allows a wider range of sampling
> frequencies and more access to the device features.



