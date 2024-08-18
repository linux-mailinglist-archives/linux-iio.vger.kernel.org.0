Return-Path: <linux-iio+bounces-8570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C7955D16
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 17:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FC728196B
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 15:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AD877113;
	Sun, 18 Aug 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh3GjTmR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB8EADB;
	Sun, 18 Aug 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723993792; cv=none; b=li7avLyruIJBwCB7e0M3hWOlh+9wEvp7GlmHjqRO38uQpwjpD29DZdlMAo+JVXVZd+P2ScPGafplvBz3AQknWFpQ36bIxMSP/7EJpy2SXXdGJEgJlLyl4BoD218COXoLXHEUAooUAEkMkoLO+6OAm7yxj9z/5PB+unhQeeThWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723993792; c=relaxed/simple;
	bh=430pbFzmLCcEsH8FB/IpfjMG1990TAXpyk7SHHd++Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bW0zbGLXQ6+oFGMPcyrnVEXljMmQrGxGzZCM0jrzkdPpBfKRK8/mx90b8aj3pt+bibLg0706z5Pzfr3pmZBy8it3HlJJIqCGeWv9RboNw0MIfYyXBg+ylycntQAG1iHcw/qhFdzw/PR+ywCmUdjyZNw0NFcu3EA1kg7HPqesBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh3GjTmR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so26940615e9.2;
        Sun, 18 Aug 2024 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723993789; x=1724598589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5/4BkzNMxDBQ6gWDAbt6rtimqyIgbJuwJHucZAPva8=;
        b=Mh3GjTmRbyLx+jFCT92GrmYQKPat6ZqAk7/qC7Ss1pSYe+Z1+I9hEtc457PA+3Hwaw
         xqXTqr+W/ZWjt3zTUTdX9z/hTb03ZnULj8J7V+jrD6u44E7MExUVf/as9UHtdvTAUkfl
         KTI2UPfQZDHi2c+hlDqOYnEzpMMwKlErhGomy7n8zJeoq92J6JHeGOM5x+Kwa8Tx7SBF
         AGZ2G5sEmRqglJURS3OFoxopW31NhYuyd2WFa5onpgTjTwIX69dTJMmFnzOt/nv0EvSQ
         U9Q0LlMw9CLEkfpgVLfj9HLva30it9lljAWbqlWBNktIiYytrc7TRY+YJifuqMFKL8IF
         WuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723993789; x=1724598589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5/4BkzNMxDBQ6gWDAbt6rtimqyIgbJuwJHucZAPva8=;
        b=ZmPY3Hx8IrHEvE+OsLsQynVl2Zk3zRQITXSK96DXSQIfpoRQl83ZQoN7WiurPSgRmL
         AqKr0fvgVdrfojmiCUNWVHj0RnMVBqnRVz6SSxmlxJ8gRRFLiKdHuu3U5RL1t6rPNXnN
         DOpex1op9jFQM8lz2HBWOKEusl+Wd7gA2ppgC/VTgvW3XTJ2zVb3qL5uCkf3w1FyU9n5
         c8OJm0vEQfudP9kes5rChxAtJg77lszyduK3YVeGBrkSe2bbefgGKY2CmEqXxFg/mK/v
         ja3rbuSQFZew0a/miDB1dcYd0Xki/UjGFLEwgM6T9qawhis6ddijFaIPihK2zJ4aqV6/
         +LJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9LqXPjJQbVPd5kBY47T4gMFC137jJz7Yj8vr1N9X6Bs3Zjr7izOEAoSiZtG0p8OrP26UFyH+yRdfOk+Qf@vger.kernel.org, AJvYcCXrgHDddCMYg4E/U1gjxVrAcpm0nykB51FGNKsuqwt+fRRLmDm3iZ83PvissK5w54QgOA/CgkiRj8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2v4yOjJ6HQ/ouQvaFwWtm1Hyy8ifIPISBX2kV8IsWRmUg14u4
	4MmH43fcgu++j2U121wieneElZ8K9cprvVZ+/9Ed51bFrdkkVtit
X-Google-Smtp-Source: AGHT+IGKqTgFJK8bszPlyxFGO6k4oIG/0kVUfIKFVf5KZARcjWG04UI5HD2JfALy7E0TSh4zwXORSA==
X-Received: by 2002:a05:600c:1e0c:b0:426:6f17:531 with SMTP id 5b1f17b1804b1-429ed79dda1mr57176645e9.13.1723993788902;
        Sun, 18 Aug 2024 08:09:48 -0700 (PDT)
Received: from localhost.localdomain ([151.95.42.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877f234sm141972345e9.1.2024.08.18.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 08:09:48 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v2 0/1] iio: bmi323: have the peripheral consume less power
Date: Sun, 18 Aug 2024 17:09:22 +0200
Message-ID: <20240818150923.20387-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240817134911.6043c798@jic23-huawei>
References: <20240817134911.6043c798@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bmi323 chip is part of handhelds PCs that are run on battery.

One of said PC is well-known for its short battery life, even in s2idle:
help mitigate that by putting the device in its lowest-consumption
state while the peripheral is unused.

Have runtime-pm suspend callback save used configuration registers
and runtime-pm resume callback restore saved registers to restore
the previous state.

Changelog:
- V2: patch 1:
	+ change patch commit message
	+ drop removal callbacks and use devm_add_action_or_reset
	+ split bmi323_init in two functions
	+ separate regs to save and relative value
	+ drop unhelpful consts ptr modifiers
	+ add a comment to explain why BMI323_FIFO_CTRL_REG is
	  being used in runtime resume

Previous patches obsoleted:
https://lore.kernel.org/all/20240811161202.19818-1-benato.denis96@gmail.com

Signed-off-by: Denis Benato <benato.denis96@gmail.com>

Denis Benato (1):
  iio: bmi323: peripheral in lowest power state on suspend

 drivers/iio/imu/bmi323/bmi323_core.c | 219 ++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 2 deletions(-)

-- 
2.46.0


