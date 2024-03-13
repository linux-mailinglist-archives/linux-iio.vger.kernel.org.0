Return-Path: <linux-iio+bounces-3496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED787B2E2
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 21:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D421F25385
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 20:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5D25337E;
	Wed, 13 Mar 2024 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U8vz1Gii"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274E50A62
	for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361706; cv=none; b=NgRNqZtcr+Te7nwm1eAZBfHHgiJ39BBRzcFyxvYp2/gAfZ10YTf044DXbXMJb0T7c0w/hWPDBpvhEnX1AbIRYm7f2epCgIOxNnpFT+/zBnvJQwqFPy8RqchII0Kw5a9Gv3Ul04T7XoLbw/K+VUQI3uIG2jQfeLAKbVgjccfCC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361706; c=relaxed/simple;
	bh=jYLrs9FzuD/uXocxQfXfUA+/zRjYUAxdEYngmXiXnyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qN5ZOpSd/kTTIF6IijdaJ6lyaqBeG20CVYb0uK60WNWjHqba87kN0vtZ2XXWqfBuNlxCFYuusdlWyEkKRMhcXIuYL+YtEqsGrSrXcc14yJzM0JGWtuzgsAn9l85thD3atyKLkPQf7tXmLbj5zebk+J+2SWxltWYv7ntAjpAaLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U8vz1Gii; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c25eaad717so171109b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2024 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710361703; x=1710966503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CLFi25Vmi0M7L3CTPnrBRviDBPZHtDLMk3xJ3WKq50=;
        b=U8vz1Gii+mpp2oQkq44YI/KakIh2DgAYDtrryuv6od6Efd/OL1+8JEmwF+zSSF2aTO
         6MR6De2Qb/r0ASsTzlvw8YniL3CHhCHrp64GPRbAceVgo71nrsiUc5h9iswy2h6m3VxZ
         S1lt23IuK5tc9QiC07GOmUfbSHcdMSyRuAtJUkkRPsi2bi6D+FSBuxo4ZrZrf2vDJL17
         9JK0baPgqsUQoBAO4K1NJBY0tJfne48NCpZFnvTP+rZjdPEvE5gPGPQJw7+zMWNZv+qz
         uArrDQS5Tm+AKAYkV8Zf3GEzFXO8bwHgK5ucwaYnJwczz8+JT5DTvri4mnmUdRAZyZGh
         A1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710361703; x=1710966503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CLFi25Vmi0M7L3CTPnrBRviDBPZHtDLMk3xJ3WKq50=;
        b=pCbmNRPd4abTAOOiVkS46kHddAzrUfvLyFj0sFhMnjBnrJzhMbPUvjH3EE4gvw5YFl
         VY6cZdrBluMeKo4S9vTyR1XZaHV+dqame2rnKOxZNFj7fsiDceo/WAsLUIx/m1p73yMt
         JpYzJlvpuRho5mNFJc4WybJnVOpsc2KCvo8WoPbBKy+jQkqm0XsSjuaUXlWraaqsCkkD
         53UdwJ37HKHV9OOWe87EgSfVMOtFiwpdH/n937dUzvuliepBz87M9xx8hESabcAiP/Rq
         v0WxZ/romMe1nLubm34arcdh78CgC+2WULYo4/5wfDhchWjIsYoXISJtsHWApqVWJalt
         6ZiA==
X-Forwarded-Encrypted: i=1; AJvYcCU5hezKDSAbt6y5jdHluvLLom2sqOvLPw5OJhLnpPLYe5UUytlLwcL94fe/w1zpgA5RiUr5PTnIP9aCyEoMAIpo1PddJhMSpcJL
X-Gm-Message-State: AOJu0YzZLUar9F1edk37sMZD3bjKX/eW3NJdsN2y+6jgcpl6VFDsAO+o
	6O/pkJnzjdpCDC95ww7lfuy1m8po6hW1BCpy/jsH9sO0U7bLEzLQEWECzaYPXWE=
X-Google-Smtp-Source: AGHT+IGDSFxjduSuPwDmDtjTbGOtbt606z3slx4WCA0+AShK30IMsbb7bUCPojEYu+ofYCX6R1NNLQ==
X-Received: by 2002:a05:6808:11c5:b0:3c1:db9c:543b with SMTP id p5-20020a05680811c500b003c1db9c543bmr1005885oiv.16.1710361702866;
        Wed, 13 Mar 2024 13:28:22 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id s8-20020a9d58c8000000b006e4eaa4ba7esm21520oth.61.2024.03.13.13.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 13:28:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: add Documentation/iio/ to IIO subsystem
Date: Wed, 13 Mar 2024 15:21:51 -0500
Message-ID: <20240313-mainline-ad7944-doc-v1-1-7860416726e4@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313-mainline-ad7944-doc-v1-0-7860416726e4@baylibre.com>
References: <20240313-mainline-ad7944-doc-v1-0-7860416726e4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Patches touching the IIO subsystem documentation should also be sent to
the IIO mailing list.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b1a6f2d0c9c..fb2377bad376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10466,6 +10466,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
 F:	Documentation/ABI/testing/configfs-iio*
 F:	Documentation/ABI/testing/sysfs-bus-iio*
 F:	Documentation/devicetree/bindings/iio/
+F:	Documentation/iio/
 F:	drivers/iio/
 F:	drivers/staging/iio/
 F:	include/dt-bindings/iio/

-- 
2.43.2


