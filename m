Return-Path: <linux-iio+bounces-10255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EF6991F25
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 16:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1718B21508
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8C13A27E;
	Sun,  6 Oct 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO08lV3D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA7C1F94A;
	Sun,  6 Oct 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226555; cv=none; b=k+CWY1EkmZ5xWUPV5z8LnMLWz4dmjV+EkOI8WBPblL07cyU02AZ121sRzT9NS8u6eraFC3VIPCjlc/LlzaHuO287CkLoc4L9IFMekNV7/mCEUxYf/+ocsVH77KWIqVF2EB1za0K6oND+LsIHoTfyM/xQw9vMbtoVJBKOdhJAB5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226555; c=relaxed/simple;
	bh=hyeUl8qlF3Z7C6eivJxLHpza75g+oT2s5O2m91EgqcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKFzK2Qq13SKrRvB6Y00hNvhxjnA8pbouKXRGNiGOiMX0Ua752jpGDVmWi04TUDbGqThgcmSmrF4BWTjS3ccoyhvr2X/HqHn/hCLjkup0vSsY63pKM4TOAwWZqsHn5iknSlNbbZjONy5CkCjX8vqufD+2ufR8N3e557DPPPjSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO08lV3D; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so3065582a12.0;
        Sun, 06 Oct 2024 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728226553; x=1728831353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyeUl8qlF3Z7C6eivJxLHpza75g+oT2s5O2m91EgqcY=;
        b=jO08lV3D/+2tj5bXrhk2hNFgqvSwEHLLA2q4nkYD/EbaIilXlkkmvNV+V+VWo/Y2Ck
         mBskQ3czJJk9T9k13u4t56xmFSs/FKdFNNgh5C1bcEw/aGXJvE0rJKewipppMJYRpLHk
         cC1EuMsTF7ERLFbrsFs/71yvJZk+qJyJnOBj52QeeUW+cByVH1i8yGsEuqURT/ZstDkG
         J2c2q9dLLehaq77ixPsMW98QAc0TGnL2jRoXxXexIE8aeYfqJ0IIuzgaMGWPYR4/p1Hi
         gMb6wPy/aY5hRyvVssF2e4D7qtIiAJ03m9y/fsOHML0s29mnb4ypSU1Egd8y/tzuIHWx
         8gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728226553; x=1728831353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyeUl8qlF3Z7C6eivJxLHpza75g+oT2s5O2m91EgqcY=;
        b=gEPLjlenSiw7+pf5+Fw1LGh4snKGPMcm8gS2ihEyGVqHCU+5AWm6jaDA/PNUyM5q4w
         TlYvfJI5OMXr44u2n+Q46v58j5QwNqtixKrbgDxdwofgWmaEoL8Hz49oc7Ak69eiXi7P
         g8HR3uam2OZJCsXwVh/dr6IDDKpb/Wtq73Rr4lE5/Jn7YUHWRFVQ+uLQlk+0NlAjETTW
         uzGU+XmDqY8Ib6JxhBEHW65a2CkJG56h0UepGVciw/2U5d6CVlPmgTQtX3i3u3qfpT1i
         dp6ihprtMdL8kSwoTJOBGx9RlvuAbEh6NV8ZroO6mBIzsSah/3M/vs/EYVjUiys7MkVV
         bkGg==
X-Forwarded-Encrypted: i=1; AJvYcCUbDT7BJdCMsRj0SdURK3/QnG0+UiF6nEjiYQxiqx6HOBg+quicV68LlRbJo6eYCXZD0TwxlbZUt0w=@vger.kernel.org, AJvYcCXX9xQpMjAPRlAmlgkH+mrcnNGMbJNzr7JejZ/GWNNMMiirQ0Xucsm+MObiJXDHa+YOPubWEW5pFhOd34de@vger.kernel.org
X-Gm-Message-State: AOJu0YymdVTYefRq3iH2SdVdvujIA5zCUgRYINZU4y/i1oTULYu2PvXr
	+E9cTfeOwDfLD2xe5mTHxP6Feb/7tv9cL14ptWSjO/xNPtgd7mKd
X-Google-Smtp-Source: AGHT+IFgKQH5EeLz/DgEmfdUTh0IsUxIBSju78Ha6hoon5VhICckLmYdLrXxNePP9joRSO4btn0fPw==
X-Received: by 2002:a17:90a:3482:b0:2d8:85fc:464c with SMTP id 98e67ed59e1d1-2e1b38c6e58mr19287081a91.11.1728226552980;
        Sun, 06 Oct 2024 07:55:52 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e1e85cacafsm5211685a91.24.2024.10.06.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 07:55:52 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: jic23@kernel.org
Cc: kimseer.paller@analog.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	pvmohammedanees2003@gmail.com
Subject: Re: [PATCH v2] iioc: dac: ltc2664: Fix span variable usage in ltc2664_channel_config function
Date: Sun,  6 Oct 2024 20:25:14 +0530
Message-ID: <20241006145514.11208-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241006154253.1a7824bf@jic23-huawei>
References: <20241006154253.1a7824bf@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey thanks Jonathan! Christophe helped me rectify the previous patch.

Thanks for all your help!

