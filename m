Return-Path: <linux-iio+bounces-3358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B91873C7C
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 17:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21D61C2181F
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7E81369BA;
	Wed,  6 Mar 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtBKxm0F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E509132C3D
	for <linux-iio@vger.kernel.org>; Wed,  6 Mar 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743423; cv=none; b=AZ/ZrHc3aZRry0agneQ79FVdKWmKZHndouBFmtJZV9EyHe69wj6+OmeHqksmZxlKFW18RkZ8sgbdsvu+ceK0UnLwrPNasC4VZmuVtS6Anco+12a01fVTMHQtdqirm3MPsLLIe2MAFPlVUFNPuHvDI8I/5bsJ8TInzPJGiD6B2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743423; c=relaxed/simple;
	bh=E3MQOz1OCEoOqhzGxzqvg86mWlLxnYD562N0ynNIUgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ni08h2WWUnpqCUSRp6tvv86y6Nv9g94B9w/Ee188jhQhKLENcyCcRtSk9Qa2ElPJdesjmvaegc4e8d4Rai96ZfJLzifFxSY1bcpWiu1ftSvIbHo34CLFalY2vrTEABM+VP6BC4uQqq9qpC+1zA4NjFIClNE291jKE7S3jaM81Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WtBKxm0F; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7db123701bcso8571241.2
        for <linux-iio@vger.kernel.org>; Wed, 06 Mar 2024 08:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709743421; x=1710348221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CzHKJhoZJ9L9/JumXPgp0DQ56z60RjeIgEzaXkgl64=;
        b=WtBKxm0FgQ4JzrKaKgOHxpRCy5Wg0C4o1nAxZ2mfFCXs0IKswdUF61huwKuuel1rL2
         RmomFY8CnUZyR1kL0/80f78mfan3AxQ5nTdeN+ntuOO9CZhZPd00C4XMa9JhJNTdb9GX
         YnF6SdGjPRDu9O8veB8mHkvGSFitZ8YMy7OfH9TIcKnFZJ+rXyfuCJRf0FWKZOmfCgra
         Cwrr2/ENtq4l1ZyejuqWet5R7sUdKs+QfVh9LVSeAz5VjLFzpcKECk3CsFdib4nGnjjJ
         0OUB2Z5yRxTOMBZ6BM+05wOQK7gFRkDnT+5ZAdvZ7V1sFUJPKMupHEzoUUVpjddKo+YX
         1/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709743421; x=1710348221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CzHKJhoZJ9L9/JumXPgp0DQ56z60RjeIgEzaXkgl64=;
        b=Zbx66NYzKnDJYsxI1y/2Bpt90RnpNGBtesSkmIex5OrmZtaNnijsB3cjpqFCKJgzpA
         iVsSRn/vU4oetjKq22Ai0XC1egk1jyO7KyZvjpeNuJD6UqRR6OSkwockU/dZNc21M/cZ
         pDrupXcTn25J5ulpiibA69G27q7dwqjdZEDbW6IickFa+ar1Gitzw0/YG2pOL+fCzs7D
         JyIPdWQrjFAwSP6T8rlsCynqrmDHfa0/FyrtewXXfPvI3yM54kndnw2a8P1Po4EMyry+
         0Hs+UmKMHVdQNmX0JREWZasNsUyYY2tL7OlHQfqWoUb/R7KFD1oKykaSqwQpBnZTTd5A
         YEmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbjhi0L2xAh+dZ9uJnWmhiYpBSNNcSpwvauhq7q094vLXTiAIH3shm4Z/m04VenUbTCfMAlkXxb1s8tGrRt6B9MZhCMXgJ0nlb
X-Gm-Message-State: AOJu0YyVCwcECfBIcqmlZizGOvPzz/9vye8BO2R1wn1d+4/moBO0p354
	XG+yliVp095zsvQcc01WNx9fnEZhrmmnLDyIcaYdm2iYJGKk8o7Sn6jCxVLONoY=
X-Google-Smtp-Source: AGHT+IEtqKs4f+XSGVsSLHNo1vi31Z+1UVpK7SSLgkuapm9nCa1m0G66gdX1EHLx1QeDvVmUMUFg2A==
X-Received: by 2002:ac5:ccc7:0:b0:4cd:20ea:35aa with SMTP id j7-20020ac5ccc7000000b004cd20ea35aamr4880544vkn.8.1709743420987;
        Wed, 06 Mar 2024 08:43:40 -0800 (PST)
Received: from ishi.. ([185.243.57.249])
        by smtp.gmail.com with ESMTPSA id ep15-20020a056122390f00b004c02d68e4ffsm1628459vkb.44.2024.03.06.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 08:43:40 -0800 (PST)
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: William Breathitt Gray <william.gray@linaro.org>,
	syednwaris@gmail.com,
	vigneshr@ti.com,
	jpanis@baylibre.com,
	alexandre.torgue@foss.st.com,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] counter: Introduce the COUNTER_COMP_FREQUENCY() macro
Date: Wed,  6 Mar 2024 11:43:23 -0500
Message-ID: <170974334053.40130.15652602513065815985.b4-ty@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306153631.4051115-1-fabrice.gasnier@foss.st.com>
References: <20240306153631.4051115-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 06 Mar 2024 16:36:31 +0100, Fabrice Gasnier wrote:
> Now that there are two users for the "frequency" extension, introduce a
> new COUNTER_COMP_FREQUENCY() macro.
> This extension is intended to be a read-only signal attribute.
> 
> 

Applied, thanks!

[1/1] counter: Introduce the COUNTER_COMP_FREQUENCY() macro
      commit: 0e313270e0e91e8d48be7a58e1622228cf9e53f3

William Breathitt Gray

