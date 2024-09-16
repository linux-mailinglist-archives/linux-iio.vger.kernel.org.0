Return-Path: <linux-iio+bounces-9613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F5A97A3DA
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 16:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FDF0B2A4E0
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B627E4087C;
	Mon, 16 Sep 2024 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKtpv3ks"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD502155C83
	for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495751; cv=none; b=uNtrRzXXRWis7LR6gjxl7q+WWvoph64zhJ7kw0V1829pS/SJGcYA3V9hIbCNtBhl60YAF3xAQ1KAfxBcFwYrB7dr1kPAiyLRcjuw3CC3OX1THOCSpUiJ60hX4PvA11J+yS+9aIAeUXyDcwUYUgP2SQZv04qy//NSwlkjugFYj8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495751; c=relaxed/simple;
	bh=HmAK7CniaJQtMmxMwrtBOeKPih2cvAldTIyclY21mRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eLIXugb1TbPNYIvWApxZNKeYWPSB0AkCveU/DHJ9xbfz04kJHlK0+g+AVgJT0jLJlbzb3TpmvEY7g2hv4iB4nLdogAohvDIBK366wd2lK7xazotfwZZua6UEmzLvbSl5DxmmiIaNaQ/Jblhf0nVmFWMHcPAo3eZR4O7fFT0MavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eKtpv3ks; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so735153766b.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2024 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495748; x=1727100548; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1Z+SmDWQl+ToljrRXHidOzvuWiHEmYlCJkt0VHonRE=;
        b=eKtpv3ksAYZmDex8k5JLNxRPf+lqwwl3CvLK/kW5fuRyfURT7vbMBlF98J9J64VGa7
         uxU9A8YuMJCxGuT6NED4mfO0z3JxgILPSQxOXfXxhSayHf9PFilm8B8l6VtHyQc6VoRC
         sQKiQlIAzSB1ApZa4x6T3klDPQUMdRyYbG7esqiazVxLhAOaMthCK07KpCn72Qf/aGPh
         LySCZi+yPfctRdyEiD7rB1BpbGP/kGfuyvoJu/ejG07EJnJ1mTBs4sb4c2ZJdi+djNKc
         LxrYO5S7SVqkzuxdULnQDUCSmsH0uTKJM7efq7G96ClNl5hVAqueZZbBdBukRQECmwhd
         z6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495748; x=1727100548;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1Z+SmDWQl+ToljrRXHidOzvuWiHEmYlCJkt0VHonRE=;
        b=Mbh+SWkMigq1orKThIQkbNdD1xQmET+GVNbTlJxkTfZLM1R/vuVFCUKxFgQijuqePM
         I/tlWp8zkeTRf/6Lp01+1e6ReXBkxSnw5hAM3A5xT4g+BYw6jNK9qIcQFMm73uzyyy6S
         NKAi8IfAirFSfQdvPtmpVMQ1b+SGV94VhK+2W1cpwUmOnaZ6IS/3DBMaXQ+dHqda6b5o
         a55kWsawU83IkpJMUjnToPwtyZCwqBpl1rmrNjYLsEfg8QxFyO57h+Phdz+enPrDIs91
         KRiz120Q4O6jv0+GjTIxrlLb1J24mDWELWjS9IjAdKX5YA5oewiKYo/WVa9lrfIx+G3Z
         KaTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWls+yTOmUUtkX8znFrwKp7vH/LVult83fOJge9MeqOIeZzzYPT73SOTncIj1iXwA4R+5R8PpAcgwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDK5WPrqZH8vDzw+knTIdtHgWwayvAhDRwwQrVE0iTs7ZRfQTi
	y/146QAGEtIV56gKYbaJmzVM12qlcoJQo++ilm7FJi7ohJ5514x31QXk0qaQgAI/iAVPpBvuphx
	a
X-Google-Smtp-Source: AGHT+IGTIuoTiYSqzwlejafPpW/Fd3fLJblO19bLyEiOs75IO8kJfKTL0OQanRC2moMSY/TIko+L/A==
X-Received: by 2002:a17:906:f5a9:b0:a86:7924:11bd with SMTP id a640c23a62f3a-a90296178c9mr1737460966b.41.1726495747986;
        Mon, 16 Sep 2024 07:09:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610966aasm322014566b.26.2024.09.16.07.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 07:09:07 -0700 (PDT)
Date: Mon, 16 Sep 2024 17:09:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: bmi323: Fix some bugs in suspend resume
Message-ID: <e5a7bfc4-7c30-4d68-a522-1d780e910da1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These were a couple bugs I found using static analysis.

Changes in v2:
Added an error message in patch 2.

Dan Carpenter (2):
  iio: bmi323: fix copy and paste bugs in suspend resume
  iio: bmi323: fix reversed if statement in bmi323_core_runtime_resume()

 drivers/iio/imu/bmi323/bmi323_core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.45.2


