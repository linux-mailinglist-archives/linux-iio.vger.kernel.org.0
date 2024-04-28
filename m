Return-Path: <linux-iio+bounces-4563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0C48B4927
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 04:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E4ECB21F6C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 02:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E610E3;
	Sun, 28 Apr 2024 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="UNx5F102"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A4A59
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 02:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714269781; cv=none; b=WKjV9+5vi8Sm2HLvIBO9obkYm4y8LNYta8mHe/575iE11hwAu/QfZkZqb0WjtMmO2D8PwihqQjn2kYtID0OYZAMuFsNBTZ+0bL5MkU4a2ucHl7O0OvpCbe7cxVhvjDjAmrwiluHDHvQPArmDDKDOQzK43A1utRq4YNqedKzeGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714269781; c=relaxed/simple;
	bh=+IDNJ2iYmH7S6OQ9I1xm3u6CGOmXdHv+EHl2B9vK9ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPBV5s9YBOJ83F8JxlO8sIrOBz7Xgst2IktqJtpQKkmkYkgmfhIpi9G3/NcnRX5q93xqn7BXzY/kSe+x8JxVODH5AnyFBKkB/jqvsvhKZLAY6V6fSzBV5SowINKNXxo9AiicVtdIOGweicfuG/8usynFS9uaQHfeMnUiwRiYiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=UNx5F102; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e9451d8b71so29288135ad.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Apr 2024 19:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714269778; x=1714874578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IDNJ2iYmH7S6OQ9I1xm3u6CGOmXdHv+EHl2B9vK9ck=;
        b=UNx5F102YQfZMaT+uJmXiccwB1Bd7ZZdEy4Yhx58smSKe4JquLunc6oYyy+wZ6khnE
         4zHhGL8vkV2ZsqzYRWdkHW1s93+rTWWLdVQwoCZy3xexbTeINzLuRH3TcjuzUdgEp0mn
         +DnoHJsVTiXncp9DA8T9yEWwa8JUd/Pm/h8bJYS/qDLremXsRReWWn2q2JO9DUJsLwDN
         cPRDu38vgVM8E8TE+7F98zjAXQYMCgK2e5/vI9PQMgr/eC0v/1iUzZ4K/SXHeH1uBIEO
         WFjg1FxCmAFy6ZTiztfRpnVJ9c3T9jT3AHjLMqJVv1+y3bIaI6q+lXwG/gvLNwi06vBg
         xnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714269778; x=1714874578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IDNJ2iYmH7S6OQ9I1xm3u6CGOmXdHv+EHl2B9vK9ck=;
        b=MVKjmTeBFdAIs7cE1ahYSD9uAL6HnMDuCgYWWhszfTDoKMGtqGkOQOBcgtC6xv1OFC
         zOMKzi5KcV6xTWs7DclxRHiKxarKNUTJ4O5XksDykSyBteCq4npV3tdz93Jg3++GCUof
         9/SSFGHnICR9yy1eiTXIig/5l9SuUSXgo9cVWZ7uNFd9IzB73MXFX0/dwfCN6ftkRsUl
         pNlm+Iq6VTCWVPnxONBxzmQjI3HB+lN6BLUB1NifDvq+v8sYrKn03taBPxNlmLcqI6+x
         PeRbM4XssqxO/tYNBTNfECvYBy1wWK9oLBpfsB6tUXMwQ2TdrErWfKqjY7ec26XRpQHh
         FkEw==
X-Forwarded-Encrypted: i=1; AJvYcCVh3phmzrPsT13QwwgqpXYbt29HeiY1KpDWFL8Ee0V4wZjVHxuaGMBve15+lcBx4Dmhyc8u8akqM6VnGjZma7K0QYUhKWfapuWG
X-Gm-Message-State: AOJu0YydPCOvVwb0+GXbfLj1XDdVYVfwbgN9MMokkRhoJahey042K36d
	CruCqTwKE2i60zH4I5IsX8wwtsq7chOaYvnReUuu8f7RmjjpxgvfUAvb/7w1gSA=
X-Google-Smtp-Source: AGHT+IG7Qnz1gAEEsoGX94Jtonzmr8idOepq33PmkrBEGsYPzrvtAZtZB03HFhPuMEG8FC3eNh9pzg==
X-Received: by 2002:a17:903:2d0:b0:1e0:b62c:460d with SMTP id s16-20020a17090302d000b001e0b62c460dmr8995574plk.38.1714269778319;
        Sat, 27 Apr 2024 19:02:58 -0700 (PDT)
Received: from tars.localdomain ([2804:14c:32:8eef::1000])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d60500b001e421f98ebdsm17735850plp.280.2024.04.27.19.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 19:02:58 -0700 (PDT)
From: =?UTF-8?q?Ot=C3=A1vio=20Silva?= <otavio.ols@usp.br>
To: jic23@kernel.org
Cc: felipeanibal@usp.br,
	linux-iio@vger.kernel.org,
	otavio.ols@usp.br,
	thiago.duvanel@usp.br
Subject: Re: [PATCH] iio: adc: use sign_extend32 to provide negative numbers conversion
Date: Sat, 27 Apr 2024 23:02:46 -0300
Message-ID: <20240428020247.50114-1-otavio.ols@usp.br>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421183820.4e2c0133@jic23-huawei>
References: <20240421183820.4e2c0133@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello!

Upon further study of the LTC2309 device we realized we were mistaken in
our last patch. It seems that the driver is set to work only on unipolar
mode (despite having support for differential and non-differential input),
so it does not require 2’s complement as we first thought.

We are sorry for the misunderstanding (and for the wrong emails), and
thankful for your attention,
Otávio Silva

