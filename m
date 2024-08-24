Return-Path: <linux-iio+bounces-8769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4956995DFB5
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 21:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC351F21CF5
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 19:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC7D558BC;
	Sat, 24 Aug 2024 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKcb7riC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F0AD2F
	for <linux-iio@vger.kernel.org>; Sat, 24 Aug 2024 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724526375; cv=none; b=lSQ1DpU32+QMVcrZIaW85h7Ze+mqtHw9ar9Tt6NdwGbTROO/+rBYqUmYdAomZsHf+CK+9n3GJPXyEbYqn6UOlr1Kg9WMYQ9UGyU52B0N0G9fSUAaJCsu3RYtYJFgtwiwRTUoHI1mjPb/AynOXrKC1lR31Ku/MGzyUuJS9gmQagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724526375; c=relaxed/simple;
	bh=5MAaK0yVA7WxHmUC9+JOV/ui43YIbj+Dn6Lz1GZ/am8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKxQgm1k2CPLRUhO8ErpnarI/fPvf/D/q3NA6Uqtj/+/nSE8Xs9vu3ruK9zD6fGe44NT45UhI4V/k1JlALRgKshLcWF0fTrt/9JqA0GLmFWJsrGK0bfRdGPfZ+soS6DaSpXTnElVOOKj4D37CZBc/g1ytOGKT/V2C2FYvPjNW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKcb7riC; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-534366c194fso2326503e87.0
        for <linux-iio@vger.kernel.org>; Sat, 24 Aug 2024 12:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724526371; x=1725131171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5MAaK0yVA7WxHmUC9+JOV/ui43YIbj+Dn6Lz1GZ/am8=;
        b=XKcb7riCCl2SuVxgYQLwJI2q9gSga9QM1qzJWkLxiOSoZWfH6n0VezJX7VLMorKav2
         oFTyiCC2HY6m75Zg21WQRAatGm+DKxvQ6uy+3f+h2Z9uUMXAhPAhi1qDLkyVt8EEtzDL
         OJvb3Ax/e+PygIUIfDs8+dJZYEV9CnBiKP6JoEmAW6cWbkml7YRfLLEd0HCg3mRxz0Wq
         CbQIAas7dgh9jTD939ioyqJaw4P7WGcuj91ytpOR5M4BVEUtrMyEyNhWgieqCzRTBKK3
         fFDTsxkRmW1znzph13uYcK0fBapetYEY84mSW0cfSWaOSeweeblNK2ULZtuNChk7SU5x
         eaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724526371; x=1725131171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MAaK0yVA7WxHmUC9+JOV/ui43YIbj+Dn6Lz1GZ/am8=;
        b=Ea5ssmYz+ZZz0E+FBMJOOdAhWtu705/bPRPodMAhlv8mO0Cj5UBrUTvQrrakqQ4DGH
         j5iquKi6uzezrAUmsATwpuI8j+0YQdJ7ATziqK3454X5NEPfyJw7G1oJJJTSn8QyGf7D
         XMooouO0c3H5YCQPzpSDZBPukbmoIt/TS5dFEA0B3IjdEhWPA6WgyowiQMTSom8ixvTP
         y3nRs2M2IIHMLl9jtuUAfNPn8TkHYo1k8NN4JeHQt368X2F4p9j8UmekFcQkvaM1bjx2
         wdN6yblxEYri4glwxAjUiebMm16yrG8p7qoBBu2n0fCXPTt2Zc3p1VcueBrsqdSsv09d
         wArA==
X-Gm-Message-State: AOJu0YzNbur6RhjuNL0GY9vq1PSoD4Yi3GF0mUin7u2865KCcpknmwbK
	vFu+pJIQGgLnPJ/1wDhWC6coqNDQGN04UCjNghUH47AAWHMG0GTOXqwqaA==
X-Google-Smtp-Source: AGHT+IHtXMHksKXR6Z+ayNQKREwsrrIePGD0LHsjIwbFEEDunC+Uf328Dw+0ZYc3zr9Ph+m4uLeRfg==
X-Received: by 2002:a05:6512:3a8c:b0:52f:2adf:d445 with SMTP id 2adb3069b0e04-534387be5a9mr4838810e87.41.1724526370684;
        Sat, 24 Aug 2024 12:06:10 -0700 (PDT)
Received: from tdg-software.bcc.bilkent.edu.tr ([139.179.211.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f299e28sm437374766b.56.2024.08.24.12.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 12:06:10 -0700 (PDT)
From: Ibrahim Bagriyanik <ibrahim.bagriyanikb@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Subject: iio: trigger: Software Resend of Triggers
Date: Sat, 24 Aug 2024 22:05:42 +0300
Message-ID: <20240824190544.5705-1-ibrahim.bagriyanikb@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear IIO Community,

I was developing a device driver for the MAX11040K ADC and have encountered an issue where the device begins sampling but stops after a few seconds. After debugging, I found that when an interrupt arrives while another trigger handler is still in progress -has not called iio_trigger_notify_done-, the poll calls seem to get lost.

As you know, the kernel provides the CONFIG_HARDIRQS_SW_RESEND option for software resends of IRQs. This feature masks IRQs in the control flow and resends them once the current IRQ handler finishes. I looked for a similar implementation in the IIO trigger source code but couldn't find anything.

Is there a similar mechanism within IIO, or how do others typically address this problem on slower processors? If there isn't, would implementing such a feature in IIO make sense? I tackled this by simply not using IIO triggers, and only thing I thought to make use of was simply blocking poll calls with synchronization primitives until the former trigger finishes. I would appreciate your thoughts and suggestions.

Best,
Ibrahim Bagriyanik.

