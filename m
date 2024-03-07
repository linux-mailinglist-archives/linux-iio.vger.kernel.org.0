Return-Path: <linux-iio+bounces-3380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E58753EE
	for <lists+linux-iio@lfdr.de>; Thu,  7 Mar 2024 17:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E885E1C24B02
	for <lists+linux-iio@lfdr.de>; Thu,  7 Mar 2024 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8579312F59C;
	Thu,  7 Mar 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgCHyBIQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B564C12F398
	for <linux-iio@vger.kernel.org>; Thu,  7 Mar 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827812; cv=none; b=eBNuFiLXmug7eF2Bs1P5DB2JsKr4GcgaYeE8YcPJlyQxCEheXRmRzkNZmODtqIP5wphCOoQHYfsc8cDo2kgp8gqA5QERjqqEXx2CdS8rch3TRR/kkBzzWvN/AFpL+f+Hv4dU6GyfVtsquT3Ujm2n8JcCtloxA61dLw9740nPBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827812; c=relaxed/simple;
	bh=Jm+OdD2u7MAgKiU7NFZDz3CSQvTuPwxgrDuuVtzPTxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQrOREudWk/n5onQWeX+5deOH6P0mQ5/8M1pIpwN+DGXuuP0wKTOOPZG9iKP02dr5mYMJX3qk5b+T0o/F9HSfKNrn+zjeRypcq6YyUMaoBXpZptDBdNtnFY+OriGgQ6c6peAvGZIYKwVDxUQ6WaTRf2Dv5EHkc5Z4oXGOu6gcP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LgCHyBIQ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e5027608a9so483938a34.1
        for <linux-iio@vger.kernel.org>; Thu, 07 Mar 2024 08:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709827810; x=1710432610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVzT2QSwauUmQXDgyV4/hYmFZcp2eT14HsdupV+MgYE=;
        b=LgCHyBIQsLzg9fDvrwLysWJQgbnDpNmaMpLvSf9sefKHsZ9dcRIBkaysrBcVukejpW
         KFUuAOeqtiStGPOckk+s7QmNvEayB4OUXYBIJZiDXqIBuDcz1dSMWBWcbrRf+ABTSO4G
         qGPiK12Uvxpo2SXwNF1XtZhd3exv6O/ESa1kszmq5kc7T2PrF9GQKFNjliE//zf2raKQ
         tcCvF0E5+VrF6Tp2WKxfNRLdI+bOyXRO1G11r4PCC/vNGSJlGAUnbphs7x/InT/Gr6YG
         D7XF9hewT6cN+yt+3dtSMBhxeCVwMraWd85y7PZ1VxyFxIc7oiv8Ng6jKzAW6hsOKfzG
         i0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709827810; x=1710432610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVzT2QSwauUmQXDgyV4/hYmFZcp2eT14HsdupV+MgYE=;
        b=svKcEl4XuXbxjQ/Yx4uvgKQDUj5Ci/T66TYxQcDk4akRqi/05GB6quiAMOXjZJki+I
         cgWJvovuCybksJ1gtZzPi8qPnDo1yqKPi4su7shPnF7wL6RflKQKanEVQI65cqc0kEiK
         aBbQCX7Pj8I99TnKG+PQbREUfh6aN7C/Zb8C07Y4umDUWQN3Si704nRu3Gp/fxwmIwJw
         V0UoYa0fwJWrc05QhLGotoy+0JT88BFE7CuRvohyq0etr6V3/fUF+FJBVsD4jZNb1Yhn
         kZ/EaXDW7ufZwjHkTj38g/OQ8dkwyJMmnoCZcQr0yEp6oqfzq2C3EflpAsFchtYYN8TM
         N0wA==
X-Forwarded-Encrypted: i=1; AJvYcCXs0jH5u00ySg8mPhpOQrNGjHu+Q7+FS63zO6MAauYS8/r25wgp43NKDPdyFgk98UwB2HqM0D8InqkOE39BpIOBoMfEjuEGCqSt
X-Gm-Message-State: AOJu0YxMe8XVseCdeciCBLicqNuy28/vysBLbjfrYik0D4gzLiyu2ZA5
	byfgy5Vy4nfiziQ2HbJ1rtENSq6p1Vp3lCKxePQZwYWJxQCAAGtB3pbtsjTwNxw=
X-Google-Smtp-Source: AGHT+IEIyRs7AXpqG00AY0+Fef/12UtewTvs6Q2q2klTZYQ6YV9VEPXsKkxidX6ek4INd4XUG2Cmeg==
X-Received: by 2002:a05:6870:2c87:b0:220:c604:8df with SMTP id oh7-20020a0568702c8700b00220c60408dfmr331707oab.37.1709827809735;
        Thu, 07 Mar 2024 08:10:09 -0800 (PST)
Received: from ishi.. ([185.243.57.249])
        by smtp.gmail.com with ESMTPSA id p16-20020a67fc50000000b0046d2b34617bsm2502935vsq.28.2024.03.07.08.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 08:10:09 -0800 (PST)
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: William Breathitt Gray <william.gray@linaro.org>,
	lee@kernel.org,
	alexandre.torgue@foss.st.com,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] counter: Add stm32 timer events support
Date: Thu,  7 Mar 2024 11:09:58 -0500
Message-ID: <170982771148.275811.6055226756648410455.b4-ty@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307133306.383045-1-fabrice.gasnier@foss.st.com>
References: <20240307133306.383045-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 07 Mar 2024 14:32:56 +0100, Fabrice Gasnier wrote:
> Improves the stm32 timer counter driver by introducing new signals,
> e.g. counting frequency, and missing channels.
> 
> It also adds support for interrupt based events using the chrdev interface.
> Two event types are added in this series: overflows and capture.
> 
> Up to now, stm32 timer counter driver focused mainly on quadrature
> encoder feature on channel 1 & 2. It was limited to timers that has
> the HW quadrature encoder.
> 
> [...]

Applied, thanks!

[01/10] counter: stm32-timer-cnt: rename quadrature signal
        commit: 74326ec28e2794e352284f619faa967b4744b79f
[02/10] counter: stm32-timer-cnt: rename counter
        commit: 017edec6629109d14e8d0caf2539998f7912ec80
[03/10] counter: stm32-timer-cnt: adopt signal definitions
        commit: 2017a23fc03c9c6d0aab7775ae6a91b4b0a7b84e
[04/10] counter: stm32-timer-cnt: introduce clock signal
        commit: 70f8e3252192451bdb5575dc6f931655a45764a3
[05/10] counter: stm32-timer-cnt: add counter prescaler extension
        commit: 18766e036b33ea2cd017cf49cb0be6504a8821f6
[06/10] counter: stm32-timer-cnt: add checks on quadrature encoder capability
        commit: 395db2e2de1434c9f361db5a8ebcae07086826a0
[07/10] counter: stm32-timer-cnt: introduce channels
        commit: ed54da4ae5e10ea104aca4feab9a7f413ec4ace6
[08/10] counter: stm32-timer-cnt: probe number of channels from registers
        commit: 1f4552e70ca8ff36c59b7ffe2a7c277c23ea274a
[09/10] counter: stm32-timer-cnt: add support for overflow events
        commit: b30011f67e90076476d843f416085be7dead3bf1
[10/10] counter: stm32-timer-cnt: add support for capture events
        commit: a297b4a46ffd195a87532d37a2c344240d7d5ee4

William Breathitt Gray <william.gray@linaro.org>

