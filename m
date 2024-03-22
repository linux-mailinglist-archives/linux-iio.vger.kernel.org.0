Return-Path: <linux-iio+bounces-3683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0083288749F
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 22:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C8E283B16
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 21:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE53A81AC5;
	Fri, 22 Mar 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qGfcP3pd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A40D8062D
	for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144346; cv=none; b=L1vrMp8zZ0UZKMNCnHsDSRHZg8TZ4fewgTXyzeFv7T1HC0B0AWfWl3oxdxzSyFXBOjyOtoNu7ODOWOGsR84ULRl9edM9Lc6vmT7ET3rwTyt0mhVmlmDfaTFkm7gm+kLSctawL2HF2BySCPGIjISddtZqaatGGe61tpfrnQdv9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144346; c=relaxed/simple;
	bh=jYLrs9FzuD/uXocxQfXfUA+/zRjYUAxdEYngmXiXnyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ft7+jAIWUSyrwjufssJwnaVGZwcs0fIghHyzqI1JQIMvUZYAxz74pPWgRB0Ou5IrI9bNAKRm8xeZ3BpCSP2sTz77EKis+RwQQVRLQnCtuAvFFnv0HBYphLB0tXaX/6pi0cDKed82hykJW4cvqko9VvmIZpIhHqmoDU8tWdmYHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qGfcP3pd; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c3acf4b0e1so1422073b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 14:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711144342; x=1711749142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CLFi25Vmi0M7L3CTPnrBRviDBPZHtDLMk3xJ3WKq50=;
        b=qGfcP3pdGzPbVUM6MX5aqub9ODSGWjOLNM7B90eT6jj40PCXGffzYtRh7LmMlMt+gS
         LrU+2kJVL0khCEJny/iBdM8z8MoR9ctF3u/+LHxoUgG5UCMrdvQpBjKngOn045MpbNJY
         RF0I6T64nkxW8KlnjLrF6hlLhrThUTvQTQVcRJV8eaSFTbCuXtWmxUX2jr5TVp10qJdB
         UFOoRgC1ShAAfqmgfM3ENcfuEI3QhYlGGCPuWHUZlZw3Kx+4tls6MS/VX9Z73QcTKMm9
         N9m+nDKPv6mloQ8/RMh09ushB/QNIf7kjIaDEovWRs2wqCsJAYe5rlAGGCEKtDwBcIYZ
         AbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711144342; x=1711749142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CLFi25Vmi0M7L3CTPnrBRviDBPZHtDLMk3xJ3WKq50=;
        b=FcETEz/v7tLe36kZga/xJU6vKbiEu8tCbOhxVeoljZAUy2qKurlrzQAvj1AkBeGnbI
         hbAEnl6k8hdyZ7NY4HtZrxSvl+FuvpBDfrdxsLnfESVYNNj/55UDkxamnkUvmZ82ijGO
         YAdYwsmWlySMIlz7sXYLkNhzMSDvB7QIhgxyFEK29EZ3BrmN7Z/9QYDvxZJE0MhoI/RZ
         49sgTq4rQuMiQbdRWfuvhqt/kpQ7VMFdgXzjHo5cHIXhYibPDsMRr4hgsIX60rpz4x9Z
         ToXVTPlg5aidLPYzGNveXe7tvTLVu2GXuh5o73RdHGDtjBSZAgo838r/tfmNWiJC9O1B
         macg==
X-Forwarded-Encrypted: i=1; AJvYcCVF2QC6/sx2ujFnBP5C7xHB9dBU+i0HvGSREub49OScluES9oy+vK+lft89nAwXHlJa41kqxKTt6Iyhsn1oGwcuUKPgJiXj7g7m
X-Gm-Message-State: AOJu0YwZY+hGDiPE1H5Z/i9tZAKGMkrxRsnZAJ3TcmaV3BLInTJbrrH1
	tgeMx1cATnVyJ+zpVqs3BGOPUMEL1nA7VaidBPXfqj98wfiIv1oy/P1gV8rM6yoEW1a487SP1WG
	O
X-Google-Smtp-Source: AGHT+IEhahZJfwf604IZtu7lbi/ax/6vF+wMAUo1Iyn5jinQ4p2xQd4Vs3Su3pPg/PcBO2WOIiErLw==
X-Received: by 2002:a05:6808:3c98:b0:3c3:9949:b457 with SMTP id gs24-20020a0568083c9800b003c39949b457mr1256083oib.22.1711144342078;
        Fri, 22 Mar 2024 14:52:22 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id x20-20020a544014000000b003c37b3571d3sm88254oie.8.2024.03.22.14.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 14:52:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] MAINTAINERS: add Documentation/iio/ to IIO subsystem
Date: Fri, 22 Mar 2024 16:52:13 -0500
Message-ID: <20240322-mainline-ad7944-doc-v2-1-0923d35d5596@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240322-mainline-ad7944-doc-v2-0-0923d35d5596@baylibre.com>
References: <20240322-mainline-ad7944-doc-v2-0-0923d35d5596@baylibre.com>
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


