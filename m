Return-Path: <linux-iio+bounces-20982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A471AEA884
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 22:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEB8164F11
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FA625A2B3;
	Thu, 26 Jun 2025 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2xrVoGt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7E925A334;
	Thu, 26 Jun 2025 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750971465; cv=none; b=tyWguNuaKPbDgN/okFFoCC/JYOXy9ebo1HFqVnKHF2M/Kr8Ht2wDV04GqEAJ1xqQF0A/M9VY5QEjhemMsa10rPoTcAcpLjIYGcrv8h3eZLAVCtonaM0GUI+gTESrPh8NyoY5CC1Z+Pr2Z1EPoc7fwAyO/max+Jy8O8bEW2EM0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750971465; c=relaxed/simple;
	bh=fboFooiv5nQCNWPaoV3T7R8k3RIvcK1dRe+5TeMQ214=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+QHU/oR0LUvEV9mVutzD3OVhMrZeWYn0zN1YqKlQXqYxPo4G3oiHbuvgK3w9vCMUUIf+r6jod8huzAlXM7CSX2vC/9vj6FEVT35WveT8O9Fad0UdRCaJVIvm9VqVbR3B4jO4yKFJbq6pJFUemQz0yc5whoIEmXhTH4LPbhKpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2xrVoGt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74af4af04fdso412653b3a.1;
        Thu, 26 Jun 2025 13:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750971463; x=1751576263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fboFooiv5nQCNWPaoV3T7R8k3RIvcK1dRe+5TeMQ214=;
        b=H2xrVoGtgqABU379MSLXy5p/OM/FRfEwUmcEsFAe+w58Br0lcAqUfaA5/9CrMYSzA5
         7VBQ93LUwa56h6eh2fW2g8SOGtfwCJZGyzC4kvz44NNcrftBuixxahibMYTguZXGazVM
         BJkAtWV12J/Mk0yvm2tI08hzQ5LmldgXVAGMwBozjPpLQNih6KAsBgMbGs4T2RjP3fPX
         y86lKf+/ugAtFDpBzSmKpGL56ficg82/yq4feT64nj3LUT51SX4qq9mOARzeDP9FbI2M
         HUg17VYaGc0IiOSEXY8SqWLEo075z+k0wUJ/s4u/y5yQQVH14c+db7wL72c6BHB/xo0r
         5Pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750971463; x=1751576263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fboFooiv5nQCNWPaoV3T7R8k3RIvcK1dRe+5TeMQ214=;
        b=r67qgQ2URV44PY+3AsqSofHenpTS1MeFTrD1ne3EbMA0m7PbrQKj01Kw2p68ru6a9Z
         eEETEvuWf4whyoUNGdkA2y2/3iMcyZzAyF3yeSs2PpNTxcOC4CA9/I9zt/P6KGS4xxJd
         h5J30YUUt8z4DVAQrpQ3UHc0GOZjhSskCBU+lfjOz77+nHAmPLQbx5nYB2DzJcojYC8F
         qPNVH5UdRHu1NHYj21WGjyZwNlRoOGPT3XC31okRW7ZdY8/nGoJ6x9ag4wiVNu78UfDE
         UoY98+ow/2sQ69fOikHeCxCvlhMWOnDvBOtA6WvOuuUMYh4U5Ek+sg+JzOi/fH+S8MNh
         UP1A==
X-Forwarded-Encrypted: i=1; AJvYcCU36tVT6BOJzj9K/V2cVGMjhuCOqz7RTcOeAiVZxwybGv7KmyHeNBlO2qhyqR6r6KtlMcjzdOMmYz+SWVxg@vger.kernel.org, AJvYcCU5KfiEa4MJXsC73gq3Ppbz1u6ufov7MKhxlhjUEoxl7T/yB6tDeW8r9yWy+1lEuNo0cuplpRy7bT06@vger.kernel.org, AJvYcCUZDQ7/DnNxtxSvJab6tG6v0rPeerqEvDVXYv6NzJDPqZyEVEQVcT6Z4udDWArFl3dpdeuRr3QaA1pk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7c+D6zSiwPWaeJoVTrwnyUcaLto2eHNv1q20a/KTo0OYR0nqR
	tZNs3QkM7LdIthE9NGQvwx7r25InxLimn/hjbWHcRlU1dIKAGvQvEqJo
X-Gm-Gg: ASbGncs7hNLSOvNRq/CwSab9PVuOxLoRO4G26xHZjbCq4FwlJm6/zGj/U5PMOhWUI8I
	x0QF/0jQSRZedET5cpCBkKiW3owTaeVgFl7GSJY7LaGJaRil9zt2pXSoV2K8/8pgnoK2qPnwBTq
	ICDFz0NdyaGRhvw72R7koYhqO8Of/I4N+8r9mKNmy6W/oiCXZy1j4U3J7EruDn8qsRrxLlTMXtz
	li080t3SGRDM1oWdxBA/l/vNm4jVBM3xUQC7ErRw6LgkbwcnED55s/8dWu/073jE+em1tWN/WIx
	Wzh91ogJu8R9uWnLCEXzD7LlNkHYCyCw0bqZ7Dmlv3wZk1ixcyrP0c6xKRynHoYMyhDQ9XlS/z9
	XZEDl5OtMoxuIBrWwkOY=
X-Google-Smtp-Source: AGHT+IHOMStf689VxqL03BfuyX0jEndQjIUPRMfj87Aj79T5t0yVc3e26PVqXcYYXZ9eoinzT1hcnw==
X-Received: by 2002:a05:6a00:8ca:b0:749:1e60:bdd with SMTP id d2e1a72fcca58-74af7893218mr609513b3a.2.1750971463012;
        Thu, 26 Jun 2025 13:57:43 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:4ff:1626:32b1:712a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ef669sm498169b3a.158.2025.06.26.13.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 13:57:42 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: conor@kernel.org
Cc: andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	robh@kernel.org,
	rodrigo.gobbi.7@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v3] dt-bindings: iio: adc: st,spear600-adc: txt to yaml format conversion.
Date: Thu, 26 Jun 2025 17:54:01 -0300
Message-ID: <20250626205733.6354-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526-overtake-charger-6c5ffcc2bc09@spud>
References: <20250526-overtake-charger-6c5ffcc2bc09@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all,

Just a gentle ping here since it was already been reviewed.
If there is any other concerns, let me know.
Tks and regards.

