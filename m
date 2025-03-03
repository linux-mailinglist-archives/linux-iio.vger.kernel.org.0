Return-Path: <linux-iio+bounces-16306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EFBA4CE09
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 23:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 736267A9100
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 22:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823ED2163A0;
	Mon,  3 Mar 2025 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU4R4+C6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AB91E9B12;
	Mon,  3 Mar 2025 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040136; cv=none; b=YufDgcFDCU7mwcyMfdwII1A2iBqOiv02jDYrE8WMpTUC35+7pR/teZLw9aK4eOL5ryRqB7Eq+BGXaNi8ecGyQHCdJUijlr+PxofZi63bFR42IY8T2pddigP9E319quA7mmxrWBW71jxwBqEONYNd5zPe+5qvAF+x+hEuoJaR5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040136; c=relaxed/simple;
	bh=IZpDwxvIz6DxvmWHj8fUJpQVS3Kqnbxep5cixkk7/hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jaqGugg+PEymsLpdI4p0nKb1+lujqctjq4uIQnSOUrpxMoSR5daDpCe5UaBdA1LCn4vJ7hZlgmG2BB7qn5FxICVPJB5JjiwYk5i/uIX/OVqi9vqw6qevgGNaOv/rLJPdUKeGm9iL4Ig6ou7kv6zlZhVT/xbzlSTmea9t4oTlAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WU4R4+C6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-219f8263ae0so91910585ad.0;
        Mon, 03 Mar 2025 14:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741040134; x=1741644934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZpDwxvIz6DxvmWHj8fUJpQVS3Kqnbxep5cixkk7/hg=;
        b=WU4R4+C6AjV+Tr55mc+zOTi2QFxIj4UK5LzCCyoeg6IChljC81Y2/8Q4udtoUUWBpg
         bMFDiiofwdVo06G9Cx1NXtIrAbVWQRhzWAeoAqVYz73/GMgxfp9nrSEQoSHuOCuhG5XW
         yMT5bN0FTrIHbms1j82lOzjMZNjEROqB1nLrbNLPmpQkkWsgbo1aPADR+dfS0wxLt1eA
         ki5huqQ/JCDdLO93pMpS/BZJj42pmcd45xAB3rrrbhywDj4cS4vR3FX+tv0Ph4OPQLhV
         DTLM0eaLLZArpaa+/juBPGdFyNP/0nFhBc+ozr8XQFdyh3nIAbum+SqX/5zFTzWsR/uD
         ZBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741040134; x=1741644934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZpDwxvIz6DxvmWHj8fUJpQVS3Kqnbxep5cixkk7/hg=;
        b=Z3fo672fTg7psA9xRWiLHvfHkiFaqYqMAoQE3Q10AAch3niO9YR/JcnZflxR3wEpx7
         XrIKY9xIg3RAi+m6KyL5AC2TdiEL9chosg8nudl5/6zkHq3t7qw9/Lw8W4h7SABJra+P
         3F2T65TeU+rrCA/9yvp4idmwSpSPxFhvi6OGrSmyMcK2W09m1Wap6c8YuCp5r59lkEYI
         wQxIbCOOMrZWcT60fBNYUq3LB6lMcAuVhTSgvQp/ze/Xbgqs04emdbZFvL4v8+uCMbb0
         b0+Agny4jPY8bZfnZe62GRs0CQyciwyhq/+2yuvYrfcN0t0YO8QPEr/2C4uq4LxvBKKu
         tVkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3HBP9p4f9svF4Gz9Sk7uHLFG33YLwn8SR+adBgCo12Uptkr4bahn1QkNrbFFF3GywzYVcbGUbHwvxFN1c@vger.kernel.org, AJvYcCXXnX4MA2yhzGs+R7+mL9p424agcCRul/XraN+ijxm0Cyj3ogEKEQVLnGZ9ZdA2zshffGF8wdEszuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOI/xhStS9QxP1xqtUuNXBZuDDsCociCtazPa6eq8xM2Tv+bY
	JokKLsYwGoORAWy/hDSmqKvdVBiZAM+Wtsg66MIRKqI06NsoJ/uD
X-Gm-Gg: ASbGncvp+bRktESUIMsbeZwIaT63fnNmkHwDA8HhxPlcu9QhidmofHX51S457zkEZT8
	M9vONPAVKnhjDSQ8BVwfApNUp+J+xYAkgZYnSXgPT6/w8eXgZU9gYWN6tQxmoVJeHvwximNp3Lh
	XT4pW6DrQ5WODgJMoII/S5uI473MkBjTlTYTlSJpXaBPzLdFwT5v2qcJELzhJw9LBc+5knpx1ZJ
	llQBURPhovGxMEF+qh7b9zbZ1/X5N4omFJaTBm/3nwag4UB7Pg+8RxXlPl1PGBhvFBzbH+PqXJF
	qsW6v1BJgXDLJsoAYKXaJy8YxViZIMsnxl23RDy1XXJWo/L14MkHEuESPDBLnyUU+Syj
X-Google-Smtp-Source: AGHT+IFNqmjqz1COtK+C2fcfRO8OdpVR4SgcV4rDelIRPY3vO/qJitu3N0K4RCEFeU0jlTv5N22kRA==
X-Received: by 2002:a17:903:244d:b0:210:fce4:11ec with SMTP id d9443c01a7336-22368f6a5f1mr214828215ad.1.1741040133969;
        Mon, 03 Mar 2025 14:15:33 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:7b03:1e42:d492:fb71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003dcafsm9670438b3a.132.2025.03.03.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 14:15:33 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: marcelo.schmitt1@gmail.com
Cc: Michael.Hennerich@analog.com,
	danascape@gmail.com,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [RFC] staging: iio: ad9832: Use devm_regulator_get_enable_read_voltage()
Date: Tue,  4 Mar 2025 03:45:29 +0530
Message-Id: <20250303221529.31204-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z8YoM4ycB0qMQwOG@debian-BULLSEYE-live-builder-AMD64>
References: <Z8YoM4ycB0qMQwOG@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I sent the patch in a separate thread, if that is alright.

Sincerely,
Saalim Quadri

