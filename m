Return-Path: <linux-iio+bounces-4407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FE68ABCB3
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 20:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419AF1F21409
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374923B299;
	Sat, 20 Apr 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="QrTzmTdK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1265625
	for <linux-iio@vger.kernel.org>; Sat, 20 Apr 2024 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713637682; cv=none; b=tSOl4Alni2t8Oipezt6lguGickPfwXogpLPrSTWcPWvs12vhYawVLK5rExYEC695eJxo2PneBd49CpzbJdNvYRiw+4ckxfpiK+hEFaqPwISSrlsnI0cxlFBMtEfUIXhM7apL1F4ZhriRPNrgSdYi5KuQ178UvAzHragGp0lxqSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713637682; c=relaxed/simple;
	bh=IFgkP86jzFBozufZkl7lqb9jJUOpxaku8hlWX0G2Beg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WKv7VT2l8r5UHnjRjXqDO2bP2PRL0fNfp/Oml5kZmO5jQP8LfiV+DB5Ezqc9WIjURDc0oWueulwoFl31UlVp3foq2CeILOE4W6noYJKzJEcJSNnyAW/2wKkRXU2MYjFxpulaIoTa97ko+tM+dqMdvGixzlYuOu0pwYRmKdcm9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=QrTzmTdK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so2616992b3a.0
        for <linux-iio@vger.kernel.org>; Sat, 20 Apr 2024 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1713637678; x=1714242478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jFQ1BB5sgvQLE5Kd1TnY+r3HL+hNwoMg1+1Wn0Y3/+Q=;
        b=QrTzmTdK6vSPXrgKRLzYD/wuzRWZ47bDiGw/BsCGTok5AuS7Mjm6Eo9W9Yl0OvHSc3
         edyu8RF16lnZC6su4Si9lTaTicgo+Wyi+a6QTGOy6jbvRcuLM24JCXSmc4AKVcIvamly
         DAqNShVdw+QQglzMaM0UJM8Iqi/7V//TUcvKNFJMhl0+xjgdYPk20HLDlDemFQukux+T
         KPv3nbVJo4/y9/yZEBPvRKNDpAEnqBxObU9EXK5X6K7o6NIzE248oDmXeCBwQKfEH10/
         RDCrw/KxFgVmrnfITy58LWsZLFQ8Dvk1x8WKlMg1Bo1CAZ/Qg2z5vNDajfd7mAKDQofh
         ctTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713637678; x=1714242478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFQ1BB5sgvQLE5Kd1TnY+r3HL+hNwoMg1+1Wn0Y3/+Q=;
        b=CcqoUe5QCoHmplAoLRo7hjCAGyvVFHYLyHqvfsIKnExa5zjmLavfkDZui7BZB0FJs8
         H6DvZcXFFbmXl2KiSqCCWdgCj8ngrnzJ0eLzMcPpv88GCJHfrF7IqxdPHOD9eA/QBntU
         hkBG9i/4xicvAo8kmP9jJZ6qz8S4skMEaBsE2RV6ufMIvgWXD6lD+Lpm+bmiGwiF1/OO
         2TDD1bCoyUK8WqPPRjT7yDg3foIcgEw6540W/EuPF0dWgq/ebe0kGDxftEcGggMTEz1B
         P0rns5GDxmWC1fSesDLZLesyrvGAJmoBEmluNsq2+aQ2sRNWUdQKJF9W/OB7vAMHSen4
         ZorQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl6/sz1t+WklKFGkZIlGqcUDE/z8GdNvvYgEqcdU2gTQuxNrP6W+8b+fDPEogM0I+pviL8PUiisDWLENqQ6e5ndZRvc2xh1cOD
X-Gm-Message-State: AOJu0Yw0vcBly2Q9QH+SEw5vYiKLFtgxBwCe5P7BMO9ovRktssU5kX3P
	Eqhw3vVCCOG95udEupQfgfpYmZ8tUAl4IKbb2zF1HNyNY4tlN1J7WWrhKjr3Sxfh8JkSdIXqgm1
	SmOM=
X-Google-Smtp-Source: AGHT+IH67RCpem4sDZL0LU2226lrcHWnX+LbPYckrEU1b1QorSAGVU0qwGCBMQvZLzByGd+8o0cBlg==
X-Received: by 2002:a05:6a21:33a5:b0:1a9:11e6:8e03 with SMTP id yy37-20020a056a2133a500b001a911e68e03mr7788945pzb.40.1713637678001;
        Sat, 20 Apr 2024 11:27:58 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7c7:8fac:7a0b:df1b:26da:f824])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78494000000b006ecbcbd2293sm5325268pfn.173.2024.04.20.11.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 11:27:57 -0700 (PDT)
From: Lorenzo Bertin Salvador <lorenzobs@usp.br>
To: jic23@kernel.org
Cc: Lorenzo Bertin Salvador <lorenzobs@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH 0/2] IIO: Use of device_for_each_child_node_scoped() in ti-ads131e08
Date: Sat, 20 Apr 2024 15:27:42 -0300
Message-Id: <20240420182744.153184-1-lorenzobs@usp.br>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is making use of device_for_each_child_node_scoped() to avoid
the need to remember to call fwnode_handle_put() in early exits from
loops over the child nodes. It is also correcting a minor style problem
in drivers/iio/adc/ti-ads131e08.c

Lorenzo Bertin Salvador (2):
  iio: adc: ti-ads131e08: Use device_for_each_child_node_scoped() to
    simplify error paths.
  iio: adc: ti-ads131e08: Fix a style problem in struct declaration.

 drivers/iio/adc/ti-ads131e08.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.25.1


