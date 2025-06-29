Return-Path: <linux-iio+bounces-21129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BE0AECF0C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934AB3AE720
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B382376FC;
	Sun, 29 Jun 2025 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZeLx4XJ8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD5226D0A
	for <linux-iio@vger.kernel.org>; Sun, 29 Jun 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217889; cv=none; b=HFw8tbnd/HJUVdV+ke1Z7sM8yth6aN+cKpXaIqdrkZsR20Gh8xnVAg6W7lm3HWsSwGxLvYkSryhYlMmYl+k+p1eu7Psx1NHCgLCwSc7o1+URpjufL1m3q1fbLqOXUl0BUKhw6p6kuRsmBG75cNtbg6WL2MgB1lAxl+E+qj33psg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217889; c=relaxed/simple;
	bh=J0Ixkl5utjBmAEa5cnB6QG9Lrq6ZqKh2gYTnUIB/lJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ndKsSbzXMeqKorEWFmwFCUAA4bbsSD9wcrsg8+WLDU2KeekJqjyUSY5pXAinBpPzNXIzQ5FiQ8NryjiYTkDYkUC9zp59NnNtpRtULZUOR2J6Ph1DtaQmr4yWWYqpcyepwOxFdOO1cbbXzy0eKUTKhiqCV/L11FbhyP7RaQluxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZeLx4XJ8; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72c47631b4cso1108873a34.1
        for <linux-iio@vger.kernel.org>; Sun, 29 Jun 2025 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751217885; x=1751822685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Diy1MlYscq1DF0Zv66TQbVLrO14SzJmah7qWSQHod6M=;
        b=ZeLx4XJ8ZFiAuDdjKu7OVbTgFNBArH21fl8912zMpIZfQ9UVz4VAfi0HJ04oio46e4
         TkHPQELyVOe8h3yHDprPak2BISQ8MyiT7SkKaKRhpsxWYPWZlkvIVTKozAZibArGGynn
         DoTlupypfbdOau6HB+LMt1UmM575hmSXewkTXJFvKvg/95uxXUbZZcD4sJtb3Jx1u11H
         Pl9NC1rMkdJePMKpFxNJGPrsM44r0Le9bAjgjach5pKwx37YWiHpoXJENm/dWsnLJw+6
         +Fz0+eAFOqYXDa4ZpLTKgbJNdZB+ZADilrOUCa/IIfVb+ubfUU+BQbQ4BO/oVh5ud9Mf
         BA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751217885; x=1751822685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Diy1MlYscq1DF0Zv66TQbVLrO14SzJmah7qWSQHod6M=;
        b=WRpMuEEicDfDBOIeXkNPC2MH0oSS3sdCGEuSi6xkPOQWub/08VVqP1UQ1glLE+sx8v
         COTCiw1yGE/Rc37ANdIxR7PH3QyL9pLfHAyH3xS8hG5VuaIAgnCYMfIJPbwQd94MrzJy
         lQo6lnNAZVrG1p1wS/MgBXRMk8MJIpq8Wcb6efmIrJgyp+n8fC7pVX2FpvlRQKl2of7r
         P/FKBfCfoWJKGbPqPXlmUU9C1EJf4zvaEm0m40p5jvNZ1pzLyzjf0O2mtDtAd6F++0nN
         u1mz1c9tZffH6SaMvD5uce+NILNO4nBFwBzklEbbH6bRbVw8Jyba3pRG0qGhP7++GBYe
         J/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUDFYyGa2s+lAa9Te2VBo6S5WdC+OioLt4nHt5WZwfJKZ1wriWPzRqOkoVYt+rgom3STlqSIEFFcVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkm9Ak2smLwr9DlkK1p21elSkZ4SK4gwaBo/dthcgMZlAZppn6
	CBIyOzNPz1qCyk9wqv2tZzn0DxwJuBPEFrdD4N8DOfQsnmclmp2RzVd2X3UTlIxRjs0=
X-Gm-Gg: ASbGncsqLjmu6ZaouGdmRqTssPbvmZiaE3JIbBWJn2PWeo7cwMl6ud2LnXO3QC5XD9r
	SUJ0z6HD0w8N6Thy1Qx1lnDZASQO5Dc+AhTSZpTweGZYr+I1shsIgVXpmXuS/CJOvhdJzFW9Abm
	6Sz1gqAIimWrTk46trC/yx7+W/tuwTzawf6TqmJ/Zk91w1K0QrDrnvugMK5dl8kUwLTnharSXoX
	JM/FKrD9yU2x3Nr4iSo90rgc9dTxyoZ+qIO6GqkpxYbOCMn0+3S88n8dS66/EDmBqLPtTSxfs/F
	cITpSPHuZ4n2YMhxtJq2vjadSl88WcksCgCOM6+ehEot9/imCxcOinXls91l1mBMcSzZZZxy/y/
	JDQUx2OR2sgkmJfBebw2p1hiF4V10zSRCvJ5e2bnRH1+mgNQKYA==
X-Google-Smtp-Source: AGHT+IEK2rnn6/CI2tLl625vjrG+arb7O1+sLlYYhwkeqs1zOcrydEV8o9HIf7UnVmK1VGPUEVYPLQ==
X-Received: by 2002:a05:6830:3898:b0:72b:8fd3:e2dc with SMTP id 46e09a7af769-73afc5c1555mr9130015a34.21.1751217885111;
        Sun, 29 Jun 2025 10:24:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4876:5a0d:2fea:6208? ([2600:8803:e7e4:1d00:4876:5a0d:2fea:6208])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb006a02sm1328459a34.23.2025.06.29.10.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 10:24:43 -0700 (PDT)
Message-ID: <9422d6db-5ada-4a93-88b2-74f1217fa771@baylibre.com>
Date: Sun, 29 Jun 2025 12:24:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add thermal sensors support for MT7981
To: Aleksander Jan Bajkowski <olek2@wp.pl>, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, zhiyong.tao@mediatek.com,
 linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250628223837.848244-1-olek2@wp.pl>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250628223837.848244-1-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/25 5:38 PM, Aleksander Jan Bajkowski wrote:
> This patch adds support for the temperature sensor in the MT7981 SoC.
> This sensor is exactly the same as the one in the MT7986.
> 
> Aleksander Jan Bajkowski (3):
>   arm64: dts: mediatek: add thermal sensor support on mt7981
>   thermal/drivers/mediatek: Add support for MT7981 SoC
>   dt-bindings: iio: adc: Add support for MT7981

When considering building and testing at each commit, it would make sense
to reverse the order of these patches to reduce the possibility of errors.

> 
>  .../iio/adc/mediatek,mt2701-auxadc.yaml       |  1 +
>  arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 29 ++++++++++++++++++-
>  drivers/thermal/mediatek/auxadc_thermal.c     |  4 +++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 


