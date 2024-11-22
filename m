Return-Path: <linux-iio+bounces-12511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F689D6375
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 18:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFCE16171C
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079221DFD95;
	Fri, 22 Nov 2024 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ib3eqHXi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED92FC23
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297373; cv=none; b=bYNyjmgrBIdfVOJnaSI5W39182HBihCgRoZCNMhvGzlKpBEnnK0dTWzUfdc9AeXvf+EI7GNmP1SVnMIhPkM2GEG0n3DPMFkkTsDp03eI6APuSy9ot3HsaXO/sKwk9xCplRSDgCLoNMKadI1JqlQtkXTJqvXVkzjMc4QK/UkkQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297373; c=relaxed/simple;
	bh=eKyvRR8qmIXJGqCoV3OEYHsTxVk2cZZJeAxKAchNSTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EipAvj5+6J24sDAwm9quLHZ8MOH7sWvlb97pClpGUFW/bNyTnByFC72kXu80S7UpNMQ+f+ppvDJntUxzMUQuXCeVUMRq+CNAUyF/wOB1Fwd627pveLMoRge2mZnzSLk3Or+4ReZ5N262ZXCsUoXw0sZBNTK5nZX0EglXjDeFJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ib3eqHXi; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e606cba08eso1244853b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 09:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732297371; x=1732902171; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Um2hT3kFq+soHaE5X1XflsUeLzBKxyA/p1C27ZLrq0=;
        b=Ib3eqHXik6b1jBbYnZAHPMfqaAFNjTDnf3LvwPJ1PWWzaYB5GKmbtEPQSJQ/EYtDaD
         odzSgzn8I7u5sMGCWHXpCGKIuwI7LQRgmN33zbmeTM6OBqjMlLJuZOZt1UhIKSvjB+MD
         Z3azWLybrhN048z3KW69kZsLPMKiup3Gia+JvhAEFODQNAnpgf7nqykyU8B/VYUlkuDH
         r/SE+XPU/YNkoKzq7hBnPCvSrpWc+Auj3NItWGVRM6BhY3ttBt/pt0vVfXLCgvY6lYui
         uh6WAySU4DUF0LjdC9u4s5DFNtPSm6O4RoTJtNs2k2mh8V36xDyzeM64PJ0cDDk0/amP
         mCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297371; x=1732902171;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Um2hT3kFq+soHaE5X1XflsUeLzBKxyA/p1C27ZLrq0=;
        b=Xy+1GDEYQ23+nnNJCwzYST1Lg9hdMPyhKlytz/WVeixL6Ek6NF0hBU4mykYFAkzt/F
         Hd9HJjYbAD1oFNHJi4oqXmdTlVb/piuh1IkEMWIbo06LudPUINvaAKwwowMZMoOkeD71
         d8J4FcnNIVUX1vmM+ynPcMQKnEf6XBXJNJm4KBxZ1Z91YjhQd9fMAexIAkNWrrWCKUYK
         lee+HNcfbrviEvUUbe5pP+Uop0CdrsgExq4QeZJ/S8go9APZ+WU63Q2n5iYzPAQAJYbO
         5vWss5bJ5o4vAerR8h2pM6kY5Qh8HROCDm5PY0v3KsQkHzQc4FhVZ6N3V/IEh2ptimvD
         xDXg==
X-Gm-Message-State: AOJu0Yyxrx2bpjBRn2qmLDnP0LlhxRGqFYIi/khXO+/H/dbuXEdio+BO
	sYpBmKakBrq1UBa1+NkrHtJaTIJr/Lu2Te3Gy5BpEJQkwSZ36Cc8NTgXsXYp1Dg=
X-Gm-Gg: ASbGncvvRrVtio+Jy3YJfC2js8HUV8xLfIr9G1xQxJuKEq6+fDKqxsURO79VO4IWc17
	ZoBMroXnKLcww/tYs1JBNB5K4C2QjWv5S122JfTwfg824oGZPy3UW0a897Fo6fngTwwLAbnsrAL
	/IpSg1613sUrFjg83A7HIx79DOXpcudsevlmkbQU0Bgam486uV3hfVkL6qqSZDHXrOOXeZwM27H
	CP1c+6dSUG6iqBTu0Mmp6k3UCRgyi/ERGMCXm0lCCdijfVpO8Gfq7tvMIetB9cdFxqz+jK34z3L
	msmb2A==
X-Google-Smtp-Source: AGHT+IF4XKHXIAUncfA5T8WPmI6EvAz8ghg0mf7E8F45FWNwiH6q4kjk7athXN/kygbcQaeReyAz2Q==
X-Received: by 2002:a05:6808:e8c:b0:3e6:773:c99e with SMTP id 5614622812f47-3e915878247mr3786611b6e.21.1732297371333;
        Fri, 22 Nov 2024 09:42:51 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e914e5ab31sm487450b6e.9.2024.11.22.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:42:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 22 Nov 2024 11:42:48 -0600
Subject: [PATCH] iio: adc: ad_sigma_delta: add tab to align irq_line
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-iio-adc-ad_signal_delta-fix-align-v1-1-d0a071d2dc83@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJfCQGcC/x2NwQqDQAxEf0VyNuBGKbS/UkTSTWoDyyq7IgXx3
 w0e5vDmwcwBVYtphVdzQNHdqi3ZIbQNxB/nWdHEGaijIQQiNFuQJXqmanPmNImmjfFrf+TkDZI
 SPeURu14+4DtrUZf3x3s8zwsWAkg5cwAAAA==
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Align the irq_line field in struct ad_sigma_delta with the other fields.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/adc/ad_sigma_delta.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index f8c1d2505940..1851f8fed3a4 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -96,7 +96,7 @@ struct ad_sigma_delta {
 	unsigned int		active_slots;
 	unsigned int		current_slot;
 	unsigned int		num_slots;
-	int		irq_line;
+	int			irq_line;
 	bool			status_appended;
 	/* map slots to channels in order to know what to expect from devices */
 	unsigned int		*slots;

---
base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
change-id: 20241122-iio-adc-ad_signal_delta-fix-align-2e229d6c03db

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


