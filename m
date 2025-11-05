Return-Path: <linux-iio+bounces-25910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61346C352A7
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 11:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 560154EC2CC
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 10:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385863081DD;
	Wed,  5 Nov 2025 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q4GTdxZt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7AB309EED
	for <linux-iio@vger.kernel.org>; Wed,  5 Nov 2025 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339426; cv=none; b=dR2md6EUGsTiyytHJQiz+fFYPrfSCp21f68CO27g+ZONHmQ07tUlcOX8VZtotctveAwguyTD7m1WPhh4kTmckBjknmivpvzYIRHRUAoM6y5+iDgXPcdx1KIq+KNf3rHyKN46S1YeZ6ZPztrK1fyEli2qRWcoeDpQ7NvhKf7f00U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339426; c=relaxed/simple;
	bh=5ncYwZOdDAa7zp4r3G0JNN9+yFlDyFnmUr7zh5/4c8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6gYZHAeZQhOonnfdhfw4bQv9m0orhqW3rFKQO+hVghUWLqb0LXPe6RvSO9ZSYaceSpeCXKCE0oERWglmB2FuHIdB25O5FFRzzYiuPQwbcpw2dwNcVkTYowXPRRzIwjXkNpeYn0en8ASOJkh0igCimjbpsymSOCWCMNsA/L9Hjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q4GTdxZt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-421851bca51so5468409f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Nov 2025 02:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762339422; x=1762944222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HOg575q+25ayG10zmWcUoW+NcCmP37KI1gSHHkg0YZc=;
        b=Q4GTdxZt/bgvQc3yh4X2sgbJGl/+pXAD25HcaRn9C0PnpY1PVQS8ySWWqbRyCz8dVO
         rq+lLbrA2jzqiIdhV0nVkL8nEC/fdWESypshVB35P76hLnJHATeahbwmIlCBEgzdP94P
         E9WSYAG8FZwlyH1eJGk+J6ObODsmgEuQn77bkhcBUOEVw+ONugB0niMEmR9g29HQT2nz
         4UiafZwslxx6yAohDu1H1zifKoC5cWkk/ikcZna0lx55pXoRsO7E01S4KemTdGjh2VZj
         0S8cWWWTcl9LC8AD37C9TliO36kGfK+7twrL1ZmQLTYRmYk8jIZkZkv4SUllrEvZ/Sk8
         R7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762339422; x=1762944222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOg575q+25ayG10zmWcUoW+NcCmP37KI1gSHHkg0YZc=;
        b=uw9y3oOvezrQU8V04JFY5me6Pd5zu0xg5E7IAVC2o/IiDg7JchW4jNBLsEAfsG2Q9E
         ip482l/1SjFb0ym4PA/rCsoIQerqLAK7VN+abKcL8EVxGhdG9k75EMcOtoZKj5hTGHHs
         PnjLsZ8I+Npv29QS8QpI8FAQXQLJjESpAkESLsGCF3TnHRTaUNzEwgokJfxy8xkli3de
         EqOsWWcryGlLAZWp+AXn9t7Q/X33DB6hHeKSnCXwi4csgRqfjhQ2rjxxfbWPEFiLyyw4
         PkXFtXMaF6cwZma7UQBjYhEe/FQnUpnu7Chho36BfTHaqFaRJS17EbX3/aZnxfPQYpdK
         ACog==
X-Forwarded-Encrypted: i=1; AJvYcCXFnpegYBmD8zlsidKlpQG/bs0ZhtoKzt6g5EBrwgqXAwdYubm+q2T2MbNVb6yOgYq883kfbYUPD5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVnXEOAcMFuBo5AI0IWZon6cBziTDpL3pIznvVH95MlPMypz7
	eP6G1t/Hw7Fy+PwRofmW07QPnyuoLwSW1lf71AVduHG5VyXYIA//9JckDIad7I0jeLU=
X-Gm-Gg: ASbGncuHmUKROt/d9jWjoqh5FV4EB0/jOKdA2gEDZH5aOz+/m2F2vWhAP28s7Jboi1j
	CNk4TFQ7Ae/lXoLGKuX7skZ/oP+66WnLF6PFHZ8Ic1Wa8QAH2W/8ogxmTV0PBKP3TzO8VY1A1cd
	y2R6wVNzHLLjw5ZiMmOxCdoEOqI8KHRwAjrO5fH+sJ1Qx3h+/b99kvlrtcyAyAyDZ0Ul4G8OY+N
	uXBd6W9r0fjPMk3nrHkVbcLKkbrKiBTw3zXw/lBxURIVG9NZKFHf0z8Z/6eUw0uG3BoTF3jdB7x
	oQ5nl1COxIFhRiNYa8M2TX/MboTMXAoN/11y74sle1odQCJ/313AA2d+yF56f4rMkrV9s9coHD6
	Xy0cieDTk07+urG0szfwZikoEMWWZnPDrdbOW+ymuu73+LHXjwLEQHKPuGECTjt45nrwslAfvJl
	7GbFdWcrozhJrWwcDCIZABPDop
X-Google-Smtp-Source: AGHT+IFRYEzSqZ0DH3kYBMuibsFe+SQOCxQZR0nK3Bmb8zKZRQYwkg39p8gfm+b/51wl7qdNrlNrHw==
X-Received: by 2002:a05:6000:1acc:b0:429:cf88:f7aa with SMTP id ffacd0b85a97d-429e32cc368mr2084506f8f.9.1762339421745;
        Wed, 05 Nov 2025 02:43:41 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5a7fsm9976206f8f.24.2025.11.05.02.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:43:41 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio/adc/pac1934: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 11:43:30 +0100
Message-ID: <20251105104330.111057-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

system_percpu_wq replaced system_wq, so change the wq in iio/adc/pac1934.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/iio/adc/pac1934.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 48df16509260..ec96bb0f2ed6 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -768,7 +768,7 @@ static int pac1934_retrieve_data(struct pac1934_chip_info *info,
 		 * Re-schedule the work for the read registers on timeout
 		 * (to prevent chip registers saturation)
 		 */
-		mod_delayed_work(system_wq, &info->work_chip_rfsh,
+		mod_delayed_work(system_percpu_wq, &info->work_chip_rfsh,
 				 msecs_to_jiffies(PAC1934_MAX_RFSH_LIMIT_MS));
 	}
 
-- 
2.51.1


