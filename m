Return-Path: <linux-iio+bounces-20921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0007EAE4D21
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 20:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F7D3A9D7A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 18:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6573F246BCF;
	Mon, 23 Jun 2025 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GrF3CUAp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C792627A12D
	for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704718; cv=none; b=LJGU6RbZFfwJ9cr41uz2v1BOtdOdEhYgu7/QMTA1XmpGlN9+0FfAjaTBth9yqnRlvyw2N28XPglfz6Hh2UrioTah9vq+gDBCAkYHy6/np1u4E8riliXINm2w63rr4gVoiKlJCRWvTggO4hNEnVlsMR8+qg6EW5QfpAk+eNL3mao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704718; c=relaxed/simple;
	bh=q9A/v/AoElE4bRp3rvOFK7egX7qzgKAtVpuAnaal8V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oC1b5poFKi+WtoknzbUZ7CyeGd6U9HJsecRutwTU4MlNcb8x9Y8ky40Fp1WAkSAaNNTUcOjh9ObzKwHAvXC/VnUNSvHmGhr/RT9o9H1zy9O6vI678xSkrcGCHtgRTb4OQ0p2D9AX/qhxWYV1450SgGcvW7NEUhSKQOT2o8Texhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GrF3CUAp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-748e63d4b05so2709633b3a.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750704716; x=1751309516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=98QCoYuCDq3/lBJQY34bvYbqds2nKyh0mPMn5M3JKis=;
        b=GrF3CUApkhExv8WLULA1grdkDHyvPTk3Hfkm9j/VfJ8fqAE8jHxeABvAKk2wfOIFkR
         f7d0vos2vcKoDi6qGk7PNNIbrEwpG9NsiUo1ADZDBsBJnbpC9dwZWw3sltVJypkaqpLE
         ydLNBmTL7oWhvjTST44g9E3WYjcLdCZRzgiZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704716; x=1751309516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98QCoYuCDq3/lBJQY34bvYbqds2nKyh0mPMn5M3JKis=;
        b=PD5LDpIFZJRbtKUYEik5wsrCLE7st3OFKPdSWqKgScQ24Em3vmsz74kc+iZImEpSil
         ryeYP0R97lx98kdQTEFKxIXaidDNBuCJNFq6QChC2TEOGVDvt7F7a04oRA322EeKGlxY
         NorcdWYlXqZww53jUySZ6GzakcHLuBTQi3KDdwH8Z9Ei5jtArK0ue0cy1AebEYHRUqob
         a0pxuI7X47vDzievc3OmUwDZ1sN+85WdCS6sNCnhlATqvNGypetEfFvBdnTmJZOSkv4U
         jZxyC+b5WY3pPsfc+VZ0qlFrGBlhSCbPLqDIYifKIiHmwikl/TQuQdAYTZb3GObZ+7ui
         1irw==
X-Forwarded-Encrypted: i=1; AJvYcCWhg7UtsXZymdiC7n0Eu+LXkF5FRzX8jriCkI/+8spu7reqptpj+B6hsuX9Zes2JoTXKlb51tQo99s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFoNlDLOOSW1rU0ks05gbUcsPWkYO37gK3aSgLSE3D/YxUNEUB
	8CIvL9B4fx8EE0C/pJDxk/PoTxrKiZqpcFRxwK2z7gtWabDnsYEIiA4zqQGAmFLHYg==
X-Gm-Gg: ASbGnctHW3sJOMXizy3n8fpkkVH0fPlYALr7A6kKxpANkzEaujNZwPhSyNVIeLY73q8
	0Vbc4DQ8vhQ1LcC9XY/AvwzvFaZEJGchk76gkTqX8j+5U0zhhI+W9XUDIfjlZkgylT6b+WuFgtx
	3ctYZCbseO0P/0WTu5R+TJQMqmWSKoEZHG6z21DSNimilRu78aRdGRgHY3ETf0jMJPjkrw9llDS
	DnuhkIrSl/82GVSb+nTEfP1pgkJFeiXhlzegWhWG2aYgbyW/M32z60sXr+lnaIfGGgvisr0euoC
	IJ56AwMiERV1x9Q5UPQtdINgOQLv9Ix6ubTg4rWta9WVtTkKgCTOSmQ=
X-Google-Smtp-Source: AGHT+IEF8Sm0SHzFfIUbEEOSZ9z1ni05xWFtMXFS0ZJv9jrAt0vbsNLlUl7oXBh9c0RO3vvqnqGBdA==
X-Received: by 2002:a05:6a00:3c8f:b0:747:b04e:941a with SMTP id d2e1a72fcca58-7490d72439bmr18466630b3a.17.1750704716008;
        Mon, 23 Jun 2025 11:51:56 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:eabe:52f4:36e6:5c0d])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7490a64ab09sm8909287b3a.118.2025.06.23.11.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 11:51:55 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
X-Google-Original-From: Gwendal Grignou <gwendal@google.com>
To: jic23@kernel.org
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] iio: cros_ec_activity: Fix function casting error
Date: Mon, 23 Jun 2025 11:51:52 -0700
Message-ID: <20250623185153.222714-1-gwendal@google.com>
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

.write_event_configwrite_event_config expects |state| to be an int not a
bool:
```
drivers/iio/common/cros_ec_sensors/cros_ec_activity.c:203:24: error:
incompatible function pointer types initializing
'int (*)(struct iio_dev *, const struct iio_chan_spec *, enum iio_event_type, enum iio_event_direction, int)'
with an expression of type
'int (struct iio_dev *, const struct iio_chan_spec *, enum iio_event_type, enum iio_event_direction, bool)'
...
[-Wincompatible-function-pointer-types]
```

Fixes: 9ad446870236 ("iio: cros_ec_sensors: add cros_ec_activity driver")
Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_activity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
index 6e38d115b6fe8..1d97a68e6ce11 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
@@ -122,7 +122,7 @@ static int cros_ec_activity_write_event_config(struct iio_dev *indio_dev,
 					       const struct iio_chan_spec *chan,
 					       enum iio_event_type type,
 					       enum iio_event_direction dir,
-					       bool state)
+					       int state)
 {
 	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
 
-- 
2.50.0.rc2.761.g2dc52ea45b-goog


