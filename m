Return-Path: <linux-iio+bounces-16448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175F7A53F26
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 01:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507891705BF
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2410E9;
	Thu,  6 Mar 2025 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jax/Miw2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E917BBF;
	Thu,  6 Mar 2025 00:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741221096; cv=none; b=CVKnBPJCRkE8UYRejn3CAnOvcirmKhOnd63TmKVuFrTJT0ixOsDARfq3vlOYtNunAsS4aMYHYWcJHVVnR5yn0jCKg4lYayKR/IcKbsg4ADrfe7CcGjm5iKDCHEgTm0k+ziYwkhvFgip1+tlRQclOL+LkmDSO21paj5eJ7qOCAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741221096; c=relaxed/simple;
	bh=Qug14P/IOvkpt7K5TlO54BpzbITyLYPPgkjtmYnhnWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dj7wtWlGeLAhSrHAVW+/JBNXTz7BP+Pb49nu0Y16aqXQWOFfZapOnVYu4SjL66seYgGvHf756R7Cg2kP1RsoWUorZXD1r9FhF7gmZBQ/TLklvkznocwj5okwCPfNFh6B+vvak7wE2avF36dFc6WgU5SgErvejgWJn+rsgQgxdfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jax/Miw2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22113560c57so889845ad.2;
        Wed, 05 Mar 2025 16:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741221095; x=1741825895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qug14P/IOvkpt7K5TlO54BpzbITyLYPPgkjtmYnhnWo=;
        b=jax/Miw25aBCQxPLAUC9MpJ+fiKv8WzzdMp7VII55Pr+Y7Fg3qxbHVfn7o93Wky7GW
         9pA65FDw6Ht00RehhM+JikadEW1XCYx/oLYu9l6TY5Qp/Lh/m64C8n4mFKGx/b+3Xw8R
         2fHv/NjGd6aiYaTutCqxFmCSy/ZUp3THFvbIve2EKMofg57cmb0mwD+SWOBo06dePEbb
         /Q3cQY2M7ltRFDdvXGY12Y57FeP0tEDzwjYg5zFBd8j3+Dc4idfdAfaDig0yfKBPRoGV
         0Cfmpy/8Oh8sK55h5VCti5I1s59f5eniGQ2kJ4rYnwMkCncGKyRLnOVeJJbSmX3kJmOH
         fJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741221095; x=1741825895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qug14P/IOvkpt7K5TlO54BpzbITyLYPPgkjtmYnhnWo=;
        b=iD6RyTfehhkF3qZk8IE9RbsgLiwwkUZSsROvVYH/YqeqqogJwxNHPEdMfjyI8wIAzV
         UcK7ckeMzTkPnnmcb9agHiZ8SgWV95gol+xH4hhV9FiLsPrYVS9S7GCUc9jby5SsIr1F
         WuLRG9g8c/K0jFs64S/t+6zslldukPQ7drzzzStaKU2TsxZIuaUZbpbCh1oiiA+cCIXo
         /gtwAUeKcOeXTSSMQgT6E0IXwix0EYdmBmtclw5ICIvOUSr9RcmdC6MFzA9hn/zouAfu
         DVL9LDL0RQQB5Z7vGQ9YsQ+5oifxuY2wTigkBcHKVW9UziKq17oRYf32DhWX4Ic+g2Wi
         XnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWufpa0jk+S6oDPEdkK7fTpwp0fLPR4DRd9Z4NxqtBmaf8nsCQeacGqBB+m61CD6OfcW9Px1wmb0k=@vger.kernel.org, AJvYcCXp1b7aRk5TTFcmYYkaNYiS99CQsr93El1A49aUX7v/R8qlbFVn2i2BJX9v/QypRn5N6gvWUNnJH7pDjZXf@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjawAcetTLEqYJIxEx8/dWfec95mrpyZ11h4b+UbDX7fuuinZ
	0HsdtRtcRKL/3G6aQ5YCe51Yz2kuL+KXGz4OrV/A/sVgsw5LQbuJ
X-Gm-Gg: ASbGncux46FnAPG0iRRx/iDTumf4MgDVCxajgEMDbh/iDBRLUKy/fA7CBQa5/BSGJyi
	BIVrccMDQ8IKyt+6zT69X7zIiehddS+AdXxuqR+knoycISIOokYFcsPkpb7AYnYwe3m8D2vC1dK
	F3hr/p4rDISxvEmRlKo3yTlvEZEN/eCUNY5K7cSNh6j8guAGDE/t5a5RY60fRpuRCekpLzwG6h+
	6pkMEpy0viB7nTa6voX41aXwp8trK0cWQUOc5jPTaDxEMZc0PQTQj2Axxme3Z8Pf2Jka8DjXLU5
	1b/x7b1l4isgbYmltwpS96AYe+L0mdHpveHY0N1kWnFnZxapAAvZ44LLH7w/fZe/R+4=
X-Google-Smtp-Source: AGHT+IHki7ShufRc/+mLRaRFpcSEEBCw2ddAwS8jdGUz9J+ZzZ65k/5pC+uvdENqjh5WVZu9OPw+ag==
X-Received: by 2002:a17:902:f610:b0:21f:b483:2ad5 with SMTP id d9443c01a7336-223f1c98d11mr76302455ad.20.1741221094679;
        Wed, 05 Mar 2025 16:31:34 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:857:3077:7768:d8a9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e825311sm1940306a91.44.2025.03.05.16.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:31:34 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: marcelo.schmitt1@gmail.com
Cc: danascape@gmail.com,
	dragos.bogdan@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	jic23@kernel.org
Subject: Re: GSoC Proposal 2025
Date: Thu,  6 Mar 2025 06:01:30 +0530
Message-Id: <20250306003130.1555755-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z8U4mr1vO-TWz91c@debian-BULLSEYE-live-builder-AMD64>
References: <Z8U4mr1vO-TWz91c@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you very much for the initial pointers,
I will try my best to contribute initial patches into IIO.

Regarding proposal, I wanted to ask, how to get a draft reviewed.
Shall I send it here in the same thread, or do I need to send it
somewhere else.

I also CCed Jonathan Cameron here, I hope it's not an issue.

Thank you,

Sincerely,
Saalim Quadri

