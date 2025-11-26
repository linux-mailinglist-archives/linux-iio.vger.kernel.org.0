Return-Path: <linux-iio+bounces-26495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8EEC8BE5B
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 21:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561D83AE55D
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 20:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2815340A69;
	Wed, 26 Nov 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCtPbVPy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464B34029E
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764189870; cv=none; b=ft4C7epW1sPxh77wTkgYujIYTrmlar5i9uW2b8TtUvUgczT2va1Va02oRuAl2jDbwK54KVps8Gzer56WuLDcGIUGfFsTg6gvQiQVClGO/1yNbPP3FcI++3Y+gUmsKbxj5IOofc44tVDS+YZg4D1QQE7rTDr42oGc4wh44C6xODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764189870; c=relaxed/simple;
	bh=17BEzP4qKUfG0OHCA1QjP6eKDGBvEJaVnp5YPbxCwzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1WuZNzR+jL0sUKXtBXVh96iA9AEIV4VeDHHkVafQ/xrICdvbA0AN7yae+zV88PAU/gkQWeSC/TgJIFYUnU5grhEuSvJ7aCdX+2WwOcqvUyVkMfDL+MP9nySKeIEVL27Ow7dBXnba9GcetW3ZFmaMT2oo0qNsDT6NTJJiHf5L9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCtPbVPy; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-55b219b2242so102236e0c.0
        for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 12:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764189868; x=1764794668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OULkeN6O7zwX2AJ7jsHhZ3lf36I9K1vJcNVQwkEYqI=;
        b=XCtPbVPyKi69E8XGOU8Z4S8P81b99G0nKzFlBLDI2Cvt9o5XZc4mbCDZp9UYKtvnZP
         R8PX603DPoRYuU6MlMInvhTkf9TPxlfo+HejS+XpadhuKhT3lZEfQReZgmTeOAWqc0bC
         MwCHHBdhIqkXMadtqn8d3gqJYwZfwwBzCyRjsTgqvc+hnjaSp7rfwYkOiqqt2G+B/CIE
         hqLhSCIOAo7wZ9WHLIae1vEheyZUkZ8QLEO4U6Mlo5dt9rY8JZ1+lkdaMKDE5c2PTR/O
         PRYvDob4632sVR4gkjkuxWLWL3gP57qtrQA3UoQTlDAyx+gqzgUBySGjjgk8lX6wT9dp
         u16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764189868; x=1764794668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9OULkeN6O7zwX2AJ7jsHhZ3lf36I9K1vJcNVQwkEYqI=;
        b=VQBFCwppxtn3bHQ8zGT+HRF7eZYglETD7OoxPszgH9Zfd7xlqffJMXVSIwEowQgxX7
         AmBe00EeqL+WxxDRuTjm9fJpxJ/ruWWERtV1Fj37KMtfm4xwFE4ODe4Mv4iddEX1Xg96
         bm2ExwASappMXrJSF81yPMUSO6wcoVfB1+t8z2YxDz61sZYgSBlUXiPbXv/2iwiy1R32
         X0SWhUlJab9DsneuEvZSRZMsLiGJ0i0kQPEIVoAcZ8Epx6txvY8IXJ36vugQ3J/vINtD
         IwO9FxXVRXCzp/nqf6zs0JEGmB6y2nNlyexcDah95wv+svBUZcEleW3NoPWvWUmcl1+n
         5atA==
X-Forwarded-Encrypted: i=1; AJvYcCWnwGX4p8qyZY2QhtEoyjl470G61DsSLK9BSBe+HlIFH8cKd/2lHVAxZeXUH4ZFp/U6RLp3eG0DsJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypFi5u+cV2qsFWEgDNZHVMQBzaI46z+jvsvsFVsDFV1pIOhFQ0
	15+JpYi4peZSfaKQVsmkD/WtONHOvbZ3DvVIwlpdc8bffz3cx2Ji7MAX
X-Gm-Gg: ASbGnctdfyRo0V+Chi8BffuHu6oYQ42cm46wuDslP+vB+ETURH1SCqrVgYTQYGiRW9t
	v4VRa1shTJKcjvYXx/J1ZgyeboQ90L5mHFn1Mc1UDMnwsqEhDCcwOkIiTfSmi+WyF91Yq/+IDwJ
	/rzwEWqbidGIYqZk4RUBhRDfFVXz4FxcfT2oxm+7KdLkooJCIomaY/m8hTYs6X7SZGyh1u2YcbY
	fvus0GDwk+NKOzknpSx7gSfurB5i/R/faz/VVJmKtfMFLbF6fWvsCHj8+5fSk4Vxwu3e6VNWNc6
	ogRnIzvFRTss20eRbMcvB9OPCF+VcOS2oNc3+MNi5u9x1bmqdcnRfvsDV3WXNE+tjm+Yj4rXC1d
	d4T83O9QJofWeqO9IIiSiskYna1WPOzMQ1tflkMskuuSQkomYkmUkVCCI+PdWLlPGsYGz73g1JX
	ZlGxTpCZjhwaSBXPXGNzFkJYGxgqUqha5j+HzNxM7Xh0/IUetNxUj1VIt3J6ChGU4jDeWPuBsA1
	yEF3O+iHFOSOEflvdJ+tRHVO2CVeOTe/Iey2amwKOHwXpWueV+mVKFBqPiIIDlbgI4EUGVx5A==
X-Google-Smtp-Source: AGHT+IF8kDfLACY+5luM/Lwgk2eASP/JhwY6nZcRQcMupu/i1lGzCtaQsg+upJUd1DjgzeULycyJqg==
X-Received: by 2002:a05:6122:d1e:b0:55b:9bef:2530 with SMTP id 71dfb90a1353d-55b9bef4661mr6521641e0c.6.1764189867936;
        Wed, 26 Nov 2025 12:44:27 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.230])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f7a1c53sm8956330e0c.19.2025.11.26.12.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 12:44:27 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: andriy.shevchenko@intel.com
Cc: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: Re: [PATCH v2] iio: isl29018.c: replace sprintf with safer alternatives
Date: Wed, 26 Nov 2025 17:43:33 -0300
Message-ID: <20251126204333.13547-1-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aSdWZQmmvlvJr-Kn@smile.fi.intel.com>
References: <aSdWZQmmvlvJr-Kn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review Andy!
> sprintf()
> "...sysfs_emit() and sysfs_emit_at()..."
> 
> alternatives
> 
> OR
> 
> "...sysfs_emit() or sysfs_emit_at()..."

...

> Forgot to update indentation.

Updated both commit message and indentation in v3

Tomas

