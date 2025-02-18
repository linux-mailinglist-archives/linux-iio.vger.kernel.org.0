Return-Path: <linux-iio+bounces-15740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D570A3A453
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 18:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938DE3A1762
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 17:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6BA26FDA0;
	Tue, 18 Feb 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q6I0Gcd2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B578270EA7
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899754; cv=none; b=MGURtRPF3jCySj2ud4yVbmr50J730sZBjRi/cKtWBGE9Q6qd17AMH5skgR0ED14Dc6Xije3bAYc9Sc20l5YGL4blYUX54SEJr/63LPxA/bLeX4V2sumZcTFoT3AARQXB2L59Hvfdd52e29d00mN/fyQZ0zu8gJVuMtyGbfvYRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899754; c=relaxed/simple;
	bh=/rN1Sil7ECtewuTQqNEGatfMsR9L2e68Srmfan0MIGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAOibRMJtqKR8GeeXlb3//19Ee35xe0rJmU5q4dwstMnc2zODGEujz4VjUVYVDCsHlLs/+yFOmpyy1Elo/LzpxqJ8xLXmh1x9sBpxx/U6uYXyS5fU0vcCiBlCrf45bajDIUXyKv1WAjhT+3Gp2DcDMZCcHNg/THj0gb/hb1IhmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q6I0Gcd2; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71fbb0d035dso3672636a34.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 09:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739899750; x=1740504550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbiFJU71DsVTxmJ4gj67sONpi3T5q988AYpsTlFS8Jc=;
        b=Q6I0Gcd2Yem+BHuGlgnnQBCJjK/44s8vqWu7G+3vvmV9XxveuoeYPgA9XpFvm+3wrc
         NDKZSbVAJ8z/ZB384ljhOYpBDN4pk3jXAv9BHTN7pGVm+cRf5Yf5QCYoHe7Tz6fK32X3
         i5WNrP51x3Es/Rd0l2CXkq1ohNqu9ZHvf7cgB8T8VS6t6w+jLsvuW+Lgkzs5xGACRVrR
         4HU6WoHSxC5ngqRfROimjYd+OPT1UlDRQevI5wu/tk7L7RaRG3G217LWvSr7po6lLNnp
         +6eTTRlBKIqucb+6N+QOF/tob7E2k2qiP38y7vE5nyViziR6ywiCXO8mceFfoTnT9p4E
         WrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899750; x=1740504550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbiFJU71DsVTxmJ4gj67sONpi3T5q988AYpsTlFS8Jc=;
        b=p6n+OcXzX0SS2bfhwIOHVoGB0FDr4trDGtJOHCaJllXJgSBd50gjj78NeY5thKnUT6
         tCh2AM1wgGjeqPMpgETVDgY4F3RYtd2YEECoGOFAepyfPqIaje89C9L67Ncb4QQD0efC
         eWAo14eZYniYvuuA8AGdrUrMHKwTpY1hEtAcxBiJ4/P/3Uw3jcVNsX+m2Wi9fKhdB3VY
         kDR5RtHkPyp7W2pvnMYxbLyo5QRE2kkvJc9gB8wR2m0R91A44WAZSYNrTXxLe6XkBmK1
         D8yKLekYhzW3l+NBi9OWx/CO3h+hBeLACtjjPc/0HR20BNh+cPIgFmmamQzbcizgM7bN
         VsRA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8blKRNV6IfScP1MTyHu9NWaor6jqLsmEE2LWYdc3/Y+UKQTWFQsOHp0WKN9H+f9dWw3nXyGNQ4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvyclK5zFpQhsffs1AOQJhaw6qNygCgxZay/Qi/8otwh0xCozQ
	9Z4YyaD94FaE6V4M+Ug0TM7zlnG9O+K0YXKIi1xrzZ3/An20TSDZcubSyopm3SLpzYYoBdekODI
	D
X-Gm-Gg: ASbGncuHaXOxkzG688PbIaKXB5QqT+fAsCiI0GSiu+BCrgN4ZJkVGKkEoMlzXkUb1rk
	qSOzlgMvPUeq+9FTyK2fT/qesU+y67s5toZTkbXV/YKEhwtY0So73B5jIz+51OSMTEjdwhteZ34
	MadUiceK06DfJcBYdPqqa9XavzxhLI38kXqUojsR4ZhB/5ARZaRDW8BNNvwRsLHhBmVrL0CJIWf
	es83+dy//N0Kc7JUgtT30gxqvWOKIBh97Va3DRykOYlwg4R4UdsqpAVfXTMrIcHyBwG6P2UYRFx
	lBl/5q5yj7oxun8jA4kwEnS0GqfHhH0SrvfoXl4uMgM1ilgFu6cw
X-Google-Smtp-Source: AGHT+IHAVduF+3IQNuzvGy++wGxU0HNqdUPsgFljNoxvo1H+nI7m+l+eMk5JpIwngm9/GLO8wTMTNQ==
X-Received: by 2002:a05:6808:2f14:b0:3f4:1ba:9e82 with SMTP id 5614622812f47-3f401baa0d8mr4851733b6e.15.1739899750509;
        Tue, 18 Feb 2025 09:29:10 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f4028e7bd9sm916324b6e.18.2025.02.18.09.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 09:29:10 -0800 (PST)
Message-ID: <4bf45120-d9f5-4c31-811b-655962984ba1@baylibre.com>
Date: Tue, 18 Feb 2025 11:29:08 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: small fixes and improvements
To: nuno.sa@analog.com, linux-iio@vger.kernel.org
Cc: Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
References: <20250218-dev-iio-misc-v1-0-bf72b20a1eb8@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250218-dev-iio-misc-v1-0-bf72b20a1eb8@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/18/25 4:31 AM, Nuno Sá via B4 Relay wrote:
> The first patch is a fix for the backend code dealing with
> direct_register_access. We need to properly terminate the received
> string before passing it to sscanf().
> 
> The second patch is about using the simple_write_to_buffer() which makes
> the direct_register_access write side more symmetric with the read side.
> 
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


