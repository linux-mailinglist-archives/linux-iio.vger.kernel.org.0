Return-Path: <linux-iio+bounces-4738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CF98B9131
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2024 23:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9991F24626
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2024 21:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2987E165FCC;
	Wed,  1 May 2024 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="nv40e7/u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668484D5BF
	for <linux-iio@vger.kernel.org>; Wed,  1 May 2024 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714600668; cv=none; b=BRGFZGQP2GwYUJ/PsuJxIv1pcKeVsSlDq4ubA5+Vn/7oDu4g6/lxsfkpykVuZfLRTzVBEzyWIXKgE81i6H5FZr1126zW+2Qi6UHwHh9Al6eeDlBSHqmelzdNBuDwNouwAPkXlSOqb2rPxjVwIoPGI6GeZOygQpqxka3GYCxgyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714600668; c=relaxed/simple;
	bh=d/e5nP83VueCg2mWl0yErcWwdakVtDtK8TSYEA+MwPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=osfEWHlB4YHrkBglpRGuo8JPA6RfBLy9cUDdQvojKJq5tmVo/BR0aNEu6Bh8qkW2sEWBjTXYPox+tJojdtjjF8FyIb44mIO8WofGy3nfkXDJbkmPsMpTIey0JU5UHEAdS9zWbIy5hvbt+oS9HNjl0hAk6RWZ4r6wHwfBwq7iRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=nv40e7/u; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f43015b763so144215b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 01 May 2024 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714600664; x=1715205464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hP245gdXnGpNLaUitQ/lap52SDc0+cCTqDy2+pZv91Y=;
        b=nv40e7/uel3O8gaIorQ6MGb2wLuxDMg366EM0MOrxud72BBHM91T6GiwOw/fg4xVje
         jnGF+b6Sg0y48253gj4Chm1RDjmr5JMHtkpTZb/rfxTu+H6+WyfVLnwrAfx9SOSrl5tf
         mp6L1TIaiza20P2MCQPip+nYb3b3k+Pn1v4NL8zx1Qh/46rSONGrn4HQkkNctvC8GKyq
         a9NciHnhRX+1nIBWp9Krnjmx4dS3sC5ZkJtlxTx8OINMiWlMM58cAjdPhyS/ei7ynjzD
         rECQYPMLjN7aYkSNEPWTlQwkMlgH4uRL+A3CNdunYE/L/MFAHub9gVImIuTuOqOevWFZ
         W6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714600664; x=1715205464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hP245gdXnGpNLaUitQ/lap52SDc0+cCTqDy2+pZv91Y=;
        b=nD8sJ7EaYm3jYCFes3Gkjclw5p0Z9WDYKeMTybRLlI4EMg4dQMwxHBcSebKPewT8Od
         plK7N/aHhSg2LKSmvbeC+KTL5HIiHvqXwjMUk1AVeQKF7PFXtt0wtFffXiir/PUoeewc
         hmo7udxoX20oIbuNfUJ68Q1KjMSL0kZhoHFmrltV4C+I4dVY5uwa+py7cThW3AKPe8xv
         PE+eJP/bELkUoUVQqDmFbK1P3Tnjy9fMHHM/svvENyW7ivV7lwxhnqv/9Dh3U0RsqEJJ
         4cIyk3+JBGlB1nRmTCMOvkK+np78rZVZyRuYgsQK6EOqJK19NIhnUxVmgQRFh31WJ5+E
         buaw==
X-Forwarded-Encrypted: i=1; AJvYcCUfC+WSr+wnZXstzucy77/+TFU+EI01Brhlg8PRPCmJIG1UyMmbADS0XaXUVYPiJV+AV5u4RTC1gTjlpCZQv+sTNkWOokPrQCez
X-Gm-Message-State: AOJu0YySmPdaom9qoi2PzrVOkheMfbau6CzW4FyVs9qLLVAx6w/J/6Vz
	0yEumcoARlLlJNnK6AuEwLRtu2B7O9R4kTca4KJIdob9AznEquK3qsFQ88b7ub0=
X-Google-Smtp-Source: AGHT+IHDRhsZBlVUffW9yGXinCpWII0es/0nHZPUs+brAMNXKkW8gIT4uNBBoC6oY2uv9aaMO2EBIA==
X-Received: by 2002:a05:6a20:1019:b0:1ad:7f1e:eac9 with SMTP id gs25-20020a056a20101900b001ad7f1eeac9mr1035114pzc.30.1714600663672;
        Wed, 01 May 2024 14:57:43 -0700 (PDT)
Received: from Rigel.pinscher-bonito.ts.net ([2804:14c:34:2097::6c7])
        by smtp.gmail.com with ESMTPSA id y5-20020a63fa05000000b005cf450e91d2sm22919843pgh.52.2024.05.01.14.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 14:57:43 -0700 (PDT)
From: Jorge Harrisonn <jorge.harrisonn@usp.br>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Jorge Harrisonn <jorge.harrisonn@usp.br>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	laisnuto@usp.br
Subject: [PATCH 0/2] Use of `claim_direct_scoped` for improved error handling
Date: Wed,  1 May 2024 18:57:22 -0300
Message-Id: <20240501215724.26655-1-jorge.harrisonn@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of `claim_direct_scoped` in two modules, in order to make error handling
more natural and simple than the former call to `claim_direct_mode` and
`release_direct_mode`

Jorge Harrisonn (2):
  iio: adc: ad7606: using claim_direct_scoped for code simplification
  iio: adc: ad7923: using claim_direct_scoped for code simplification

 drivers/iio/adc/ad7606.c | 19 ++++++++-----------
 drivers/iio/adc/ad7923.c | 30 ++++++++++++++----------------
 2 files changed, 22 insertions(+), 27 deletions(-)

-- 
2.34.1


