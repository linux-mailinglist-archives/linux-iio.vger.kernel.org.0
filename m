Return-Path: <linux-iio+bounces-8560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 966FF9558CB
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 17:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386C11F21D95
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762B114F9E9;
	Sat, 17 Aug 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEncB7cs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0361B66E;
	Sat, 17 Aug 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723909828; cv=none; b=oA1++mbIDvhBAJCm2WynIRH0Ytrblblnrp6lVCMNRr9Xy+ZKUX9Cl3P9WusR8nBW2Z9bYpGvwB98Z3JehnHsDAq+lGXkj56jMDF57RuHP3qpv5fAd85q4g2RGgiRwd0M80Ah9EfYiRrXz4Mfi9jqQYvtEaL62vR/IpOJGljNTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723909828; c=relaxed/simple;
	bh=fUJCAK8PPToGy0AWsAAjITyCFLBUAd3mJakeS/9+NBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agU3DZdhfCohb5eP4MwohLuuTLjgE+zuSdTk8qaERaiOiFvpkAzOVND9eczjhdrIm4UHfpsn/9Ao/FQ0xQzKOUVZGbELVFnayVsPmiDe2KQpD1e0MLilNm86a42CQv7DQoBt5R58yuER879QFS6rsGVB9PvOVgFLqXRyboYnz6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEncB7cs; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-530e22878cfso2980246e87.2;
        Sat, 17 Aug 2024 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723909824; x=1724514624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h1GvbgdyiJc4EjKcSTE6L8qq7eWcsQYjW+Rfw/8jZPY=;
        b=JEncB7csT3PyIZZJzXOqGSWJKYGHi6ftY4hQ88fjzT5COIeHApJpEGEDJdpFsOgV6O
         ohExV4tz7H5Q/XTSEOt5FaAyBKSorBVIFSFx7F0G69cUCCfdxIUzn2Q6vDY4Y/xjnGkz
         vW+OLwXnkom5g0DkFUtPpYc/MRRf6s43DwfUDhdjvp45W2Ib194ME3zA43TePvtLWWGT
         wmzD3k4jHMJ37EPyH9OnGaerX3PdSPDfx06S5T+A85qnpxDigr0gEIuJtexNi8fHxM1q
         tBiwvdzPf1F3223DeVmakWjp8ZSTTdIB3fAtoLDtoyuWwXqFgS3u59OruNiUPWHWVXyo
         Tftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723909824; x=1724514624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1GvbgdyiJc4EjKcSTE6L8qq7eWcsQYjW+Rfw/8jZPY=;
        b=NbkXh02NZAuPd6XtbDhG9miG5Z2Llm9ZfGri0lObx3agQNGvBySZnu/bl+O2Led1mn
         WK5J7QiLaICADjPznQQRl6LkY9HhlVBS/LJh/gtCJIjwhGWie4NBjcJcakF15Pi1i6F3
         VMzfonSbKxfBF+j6gRzRGF7WQ9uPwYFnuAsXQETcOVcsvU/0VMq5oa8GMEHQsgKT7ZLX
         30kcSjUsxu4ChZcfN/22WVgScVqtlp7KydPW6kAMqv5UAbNrny1UR5ufhCfTa1Z8jTxb
         qikNqA/S1kgWvEXODdbTPNq4/KBHiFFoXs4SA8TxbnLMKhEmcmU6KAhNljDq0Bn1rEYk
         yKrw==
X-Forwarded-Encrypted: i=1; AJvYcCWsgSkjtuukWOmUPp5AzyWlzew1FP2nw1b58w/WEXe1jjXhnBMoeYR0tg8E9SguwAcu02p3tQhAXrUsihwppkMvA/s2m/ybcfoIDPzM
X-Gm-Message-State: AOJu0Yw4D0NKPGzHH6rabVP2vLyH+WTkWl+4SlG7Fu6OjoDHKJYw4Rul
	5zoekKG58+nnWqmXypmZSsyvIo08Ehpt2irpmnEbBQ1bDZiKucTUV7DycNsST3cARMnp0w7wGrt
	DN8g7XmedHl6xXFkoh6PVoXGdrDI=
X-Google-Smtp-Source: AGHT+IF2zinGhuKR0LifhVhDWm/WIO+nRhia7/dj9Zoi3GL25cuGgmUrcyhsCDWIRjYL6RZ5OS+kHcrVt0TGrzuQJrI=
X-Received: by 2002:a05:6512:110c:b0:533:e83:c414 with SMTP id
 2adb3069b0e04-5331c6edea5mr3382241e87.59.1723909823324; Sat, 17 Aug 2024
 08:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814113135.14575-1-abhashkumarjha123@gmail.com> <20240817153953.1743e020@jic23-huawei>
In-Reply-To: <20240817153953.1743e020@jic23-huawei>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Sat, 17 Aug 2024 21:20:10 +0530
Message-ID: <CAG=0RqLaigoVLN2D9LEfC0_1ctJO6OzwEgpeOx8NQavB4mZxoA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Add light channel for LTR390
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is v7 mark 2.  I'm confused, but I think I picked up this version
> (Seems I'd queued an earlier one and not mentioned it on the list though
> so I've dropped that in favour of this).
>
Does that mean that you have picked up the patch 1/2 and 2/2 of the v7 series
as well ?

Thanks,
Abhash

