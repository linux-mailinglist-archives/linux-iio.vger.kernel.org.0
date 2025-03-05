Return-Path: <linux-iio+bounces-16438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CD2A53EA8
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184811891A12
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 23:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E101B1E7C20;
	Wed,  5 Mar 2025 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXUd5Mom"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597620766A;
	Wed,  5 Mar 2025 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218641; cv=none; b=UNM7nn+pBDzkpn4PcAfHYVPCdcnp2CNxKVQeOMQsHQMTwqCcioDVPAlBLZ5J/ogIGG4TR003rbnVF+0e4CRN6FIEsN2ERXTm/wYVDtG/rAMjUiBB3NiixWp6pM2/KiL7j+qprxoODFsF8NBeG2+eHrqAw3LKGg6vYtcv84XIfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218641; c=relaxed/simple;
	bh=Drrr2Zu7hQ3OgsXqSg6RRujzqDzMNYci98Mv7nKaP+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V346Jij9SW+pybaw4jze1LrfW1FJpRRJqKeQPLHS8tZztkKcGmQr+LChqEBKnrcSjfFCJQifXIu/q9mmzdmzz1OmuP0nEhjajBYm/u9b17Rp7QMYO+A0BKXS7/V1QtUb4ZS4YPGjl2e+gbobfOFByUCTAGLtqLfe1tATDQXz99I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXUd5Mom; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2234bec7192so539835ad.2;
        Wed, 05 Mar 2025 15:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741218639; x=1741823439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Drrr2Zu7hQ3OgsXqSg6RRujzqDzMNYci98Mv7nKaP+8=;
        b=CXUd5Momg8VbuJc5lmtrq19ys+FRarmZtPWuyRBsqqZHRzty/KOcdnJnxD0dgNeFLA
         Ccuc/U3A02pv/XFU4i6P4IEPQq+378PbU5IN0Q1ubNbXoitcgu8kYTWbpsLLCQlIE/of
         Ie5A6PNTXptSzfQBgKJTgj1j8y2ym1uuZkL5PqW282Rew6BSbFbv5mv/W5B1A8vC4OSZ
         4DAAMIf/bNdc44bp/FfUAPhoLEcTcdvHKeAoCiODrdJzu8dqw+gsYv39f1RiRdX50gfo
         Q7+kbv/HfBvFMWztSEFBSWay2uCxUw3JgxbrpLYJ5Ot18AamHSpLnRcai1sgVST2AHwa
         hkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741218639; x=1741823439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Drrr2Zu7hQ3OgsXqSg6RRujzqDzMNYci98Mv7nKaP+8=;
        b=Cj/gvJj0BVW8aTrFirzzHHaw1O320X5KC4OAr5BjbCev0jp1h1zI5883qfy+EiZYF3
         sacmFHX3pYWRfjyQuiq1DwSNA46ZyvA/eQDxXhoH8rqaE40AD5S5Y/K7XuS2OJomr5q3
         FhAr6VBbu7rO8wva+ZSOoQWN3ECInN6akKfRQ+05czou6rD5A8viw4UdWH9bC7o1lO18
         ph8KVpwqPYCrAvdbQcOoZRkTO66SF74KwUXH4ajaF0q09BGSX/mncG859sCIXqUmAnFO
         ydSVg2hOLLci6G0djsp5eC8zMYkVuq8WwIx3olFqLM/zCyIoVHDwveribty1s26y86jY
         Nz3w==
X-Forwarded-Encrypted: i=1; AJvYcCW16iWxNpIuffDJ7AneTSiUB3/dNhHZzojmXXVqjpG2HabCaHEoiN2UzKX0g+JFN/3HLRPCz0T1PzvyBgpe@vger.kernel.org, AJvYcCXjl9gJZ1iUqMsLkLIPXR2KlhLIu1iGm/YZD2A9YV+PgyPB88564g/P6BWfWryVvDAzrAo/LDifxSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJ4yfELLRzYUOqUTUOjfNsaaqmFkp5nGi63GixjdHscN1WW4K
	fhHOMLVy7z/R2zdD99+VrI+hUBW8icnCuouvAodE59/ufkxEcPCW
X-Gm-Gg: ASbGnct5q/ljP09tqSDYLboc9TZS5+siFgfxQCj1ZbbFzoyHK1VGHAsqZjKY8T7h5O1
	nOTV1RjbE2882Rq32clMtbWhdmjlQzk+HCexYKbKze1TEtyIcXDvIYJMkqMRE+ijUfAHa24nsje
	q3/LQa+I1fERTI7/K8rEekVeQOMa3LpJmY7dU0Xhg8xwHJ+Ekj6P8qcIshOw35fTbLNXYFPQOKX
	W0m0HEb6sVp5jMWGovSfJdUM4RDMPP94hahblrh8tPhkSO7E4zpzvHz6R1TKXzRAKB3C7Q1G8Ie
	Yyd0GdD12Q3e0hhAhwfotwgoBfwV6xVVenp0WuLS2QlSFTeylzb1O528NL4ftmut5hA=
X-Google-Smtp-Source: AGHT+IHoz+lf460cNSoIaOZQhBjzMQPTXlH7YysMIJ2rgNlpSS+X5znxdoE6LIbrBkEBdraCcU1Y8A==
X-Received: by 2002:a05:6a21:6d9a:b0:1f0:e893:409f with SMTP id adf61e73a8af0-1f349496b41mr8807677637.23.1741218639522;
        Wed, 05 Mar 2025 15:50:39 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:857:3077:7768:d8a9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281077229sm18349a12.12.2025.03.05.15.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:50:39 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: Michael.Hennerich@analog.com,
	danascape@gmail.com,
	gregkh@linuxfoundation.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: iio: adis16203: Remove unneeded spi_set_drvdata()
Date: Thu,  6 Mar 2025 05:20:34 +0530
Message-Id: <20250305235034.1548822-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304143230.6d91f64d@jic23-huawei>
References: <20250304143230.6d91f64d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review

I sent the patch v2 in a separate thread, if that is alright.

Sincerely,
Saalim Quadri

