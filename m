Return-Path: <linux-iio+bounces-17669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1EAA7CE20
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 15:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35961889982
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270A205E3F;
	Sun,  6 Apr 2025 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI/KAiJt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352392AD25;
	Sun,  6 Apr 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743946290; cv=none; b=l873sJFlYV6011XLJ4XZRBuv/oSpwP1fyN+XyXTptvzfzBmzLHYbtyr3Qm7unBO/1Cfi8RBb1/rzZ7kUlz51B8wtwmQ6f0VVSzFfY1g4zN6+69asstzPsZgQSwGsUvEJt9IMPratvTdWbpTOokGgdw9M757VdKNyzns81ck6uDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743946290; c=relaxed/simple;
	bh=LW6DNAqdojKA55Rx/SSTjTlKlXXLc8IquoNciDXLm1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c5lnAafW2zmAatWpiH2w8+oIH+GcOaF0BlK8r5lwb7FYqiKgMriAAYHNY8EjwAg2CZ/zKnTtVe578uLoEcsPrucTC7oAw9XdXH6YZFnr7tPVZWZfBxRAiys/iwLmcuECspePzMNLTGnrECahzjd7kRR4VvPXdUMAdkANliBOwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eI/KAiJt; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736b350a22cso2899352b3a.1;
        Sun, 06 Apr 2025 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743946288; x=1744551088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW6DNAqdojKA55Rx/SSTjTlKlXXLc8IquoNciDXLm1I=;
        b=eI/KAiJtalFG1uvZr2NEV2t1SoMgm2aIae4hRWhE8uJFjoeeEgZoi9lU95t4OO59Pj
         X6O6X23ozOwNZ1DcaDUWJLKB0ILGyvwFtQ3o5y4Yl8Qysa7kVKGYAMCPiN+FG3UXhkFt
         zSP08v6XU2YBCiXWvqrJn3DSIGQOfaK100KAbX02j06tbyR0AQS49iQ3PKsX8Z6yHl6V
         3tg5j9QBF0U0Yf5MV7KOCy1d8mEIAop+GbNl05+IRRuutosacqntHILtPgM99z2+bQYC
         LA9xgLkqYbf80DkGehUZ7+yU0gYwZz5ZJRnrlFYOWIi/bbo2LLLwQBM+o5zZ4B2HV5md
         I32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743946288; x=1744551088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW6DNAqdojKA55Rx/SSTjTlKlXXLc8IquoNciDXLm1I=;
        b=oAz0HpIpZmNVke05QjBeD2AjbLqBd1HR0RSg94N8Dt9RstrqhyFuHExYMSFYoVdV0i
         eBqxWoIC/Alx4fcnXzXb8WnY+psauXjAqVzpSpXWqNdCDqxoYU4+PrKgZGtG6fgq7LZn
         mtEE+EC5FKEeQJbzumWiPOjnT+xqrQb5Tr32cDx06XBXEu0vDb/TVTjnO7hgp5ITOlci
         bZ0EhsTvqXKPTQlRvlcy6DSO38llLSoUyFCnLZek5DddM0pnhrOVpe+o2QfA/bK+dUSD
         rLteWnPCiR1Td8OnJr3Gd4VJxf+EG/oezVr8xj3P2G3celw1wkJoRO1BnshdmxztSKud
         6cGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuC2LPXKQFeetxj9DmTdq05LWUNa+JN+wHul9jDcnoefazoQh4do/texhnUuPvOQ5gRFyzN5uwaBZKO8Lm@vger.kernel.org, AJvYcCXZd23V+rBjC0COcdQG86qzGWK+ZsHu/p5WjkIjUF1DZ1Uy5qpLN64++gWNcJqoJIHxOW4SIc0UusM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ/sPfOgIv24tyx9LXq1Tvety6OGJozGQjRPDlaqiU4+V4YtNJ
	Wu7TdP3dhuowqHv3yNLpCiJvXlG2DpXZJTyoHnCg8OknWRzrdt91DFK6Pybi
X-Gm-Gg: ASbGnctVuAcQSAcjkFpX78Je0/jTrhod8k922X/8V0RbAo3PwGYeQTmaZe2B9FQOtdU
	rf1Z3ZycRDnVn4kn+FaPxYS+1iJtedxUe7GJxp33cxBAYnDSiwOAg5L5JYSdGA+svueiSw6yAEA
	4EbEv088rXrXkau0blLM9mhwn4tzuLN5Nb5Pdpp9hhymkc52Q6PyBc728N0Ow3vPFMFX+AlhSwM
	6vnPhhSN2I5GiR4n2u5jp5KHD+R/nt9gnqsZwaCf9NaffMoWz7eebGFmnv3foNLEnGC308iGxP4
	tF1TvGyuLs6OWOgLnFDdfCmYtTzPe8z/XdsPu/raaaB2bLixmN2KaEoMPD84ZcumJVWw
X-Google-Smtp-Source: AGHT+IGMVH4Y2XKSeQHG0qyn9bswIapMf3BUrYpRUZ/hdJQ90hKdNdg356TYLyuCy2mDzor/LEfvMg==
X-Received: by 2002:a05:6a00:23c8:b0:736:3c6a:be02 with SMTP id d2e1a72fcca58-739e4b49c79mr11171847b3a.11.1743946288190;
        Sun, 06 Apr 2025 06:31:28 -0700 (PDT)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:989b:d133:ca19:bd6d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea20cesm6652595b3a.86.2025.04.06.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 06:31:27 -0700 (PDT)
From: Saalim Quadri <danascape@gmail.com>
To: marcelo.schmitt1@gmail.com
Cc: danascape@gmail.com,
	dragos.bogdan@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com
Subject: Re: GSoC Proposal 2025
Date: Sun,  6 Apr 2025 19:01:23 +0530
Message-Id: <20250406133123.8704-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z_F1ybM7B3g2WHvx@debian-BULLSEYE-live-builder-AMD64>
References: <Z_F1ybM7B3g2WHvx@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the suggestions, I am still new to the subsystem, and am still learning about the process
of working on IIO, I will keep on updating the proposal, that I uploaded on the gsoc project page, as I
continue to learn more about it. I keep getting intrigued by the subsystem, as I keep diving more into it.

Looking forward to your responses.

Thank you very much,

Sincerely,
Saalim Quadri

