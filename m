Return-Path: <linux-iio+bounces-11571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D654B9B4EFB
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 17:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D4D1C22905
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65F0197556;
	Tue, 29 Oct 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dybgzy/R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69D195B18;
	Tue, 29 Oct 2024 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218320; cv=none; b=RaqL9i6wDeVMs0zB3RTePDRnM3aezUhWtp19GZwBkhcgD/VL0RC4UqDdaPxZgtQ2GFz4P7f6Ee0IBMIr9Ma2v9wD9Akspfh/42R95WJMtngf7Wcu9T4fYq6gpKQeKSdyjMVwnGlim2uPcP3oMUmJ1pppf17lyKabssJKG7LFYCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218320; c=relaxed/simple;
	bh=gsgmjLEXJ6bu6q7DD1pAjajrD7nZ89er/aPYjIIBnuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bRStNJEpxTmLtxqYwJwAvfX7Mb5y8mIBd0V5H1qgXYyRdOSiJsgoBQER1cUUdYxaWcyefqfkAmkEfDP5dQdkOODRhYIbGTRE5Bas4ov1bggJuFqhlQSI7Tnh54DXkV2rhe1kd4SAGRfWYHHe4Twy/y7O5EmbFQv3D97cc52Ta34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dybgzy/R; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43163667f0eso53652925e9.0;
        Tue, 29 Oct 2024 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730218317; x=1730823117; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqoX7WULKFt/bfeT2IWdP3wKqQiwnx8qpOnus2RNe7k=;
        b=Dybgzy/RRlpre9tavmSmcG/pEfSAOTzR7ChiD7shgXDEXS9lc1kaWs7uAhD8+IWOHm
         rzrUvZQ1hYz1dJyUWqLniAdGB06m4nfXgjuyw/EXao2jWYd+Fydzj79sPcw9EjXtyZqc
         DoJCtHuW59UppM44xZ0PxEK5ybRdLNzlXs7N7iCrXYluBBeDKSmn/kZ66MOynA9Ec6Sv
         8WYw48/P9qIb+1r7FrkcL8DCqlg62hiLCqAsF1MB7MlUxjDT6Br8ZO16nl4pYR/YmdnJ
         YQyJC8Zkjpsrrynk7xhsBuVH48rBqiBvmWHhxi5pMFbNKpreHQXfZZF2HNFI7fNeVHhK
         44FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730218317; x=1730823117;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqoX7WULKFt/bfeT2IWdP3wKqQiwnx8qpOnus2RNe7k=;
        b=F6P44okzBFvM7EIjTCuMj6OTUlP4LR9vhTI8myjbcFOXitGvuumcqmjvbdP88+b2/O
         p0ycs1lK8Mql6FD87b2LFZaLfyXSESqx398U7djSP0+G+hXxTObLw9+kZuxo0t76oJx8
         zUJ/9QKWIEJ/pi/y+zGJlpUtXpw2e6amtb2UPkuZmIz+rVrOK1ag1v4K8aq/lLoIEOPk
         0NKgAeldLLB8xDfRD7Fh+E/O6sU+tUsW6LDBEeFI7pH8wIW4L3TFodNbaXROOxQ2SWJ/
         Y/KmvQj8m23Rw/qnk721i+fvjb7mIaKLuJsZlPf4txbPqGLIfFKKY5QFIat8Ayf6i9Rt
         tsTA==
X-Forwarded-Encrypted: i=1; AJvYcCWsuSTetQgG+LESkNWa/vmnQn/SWIYUgqGyhXDmjbBEUul0rdcZXB9zImEqW751FWMDp8X298R0q//LZyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypUn2FywWA46xnM/qBLPRJRwnw5nCMkM2J9+5beTfCjYl9hGFI
	5DeN1gyqoZ+fsY9YO+ZB8sYYVPPRA3dghGzRlaJuBVh5YuVqBTJJr4OnxgjF
X-Google-Smtp-Source: AGHT+IFUF7lfCCfkKUOBUcSlJGyctZ9PbyWmCZzP6RQkRXhKHmDTyIBjw9RToKSubYCqgpXUxYo4Hw==
X-Received: by 2002:adf:f4cf:0:b0:371:9360:c4a8 with SMTP id ffacd0b85a97d-380610f81e7mr9368425f8f.6.1730218316664;
        Tue, 29 Oct 2024 09:11:56 -0700 (PDT)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b0ea58sm13002569f8f.15.2024.10.29.09.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 09:11:56 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Tue, 29 Oct 2024 17:11:54 +0100
Subject: [PATCH] iio: core: add docs for read_avail_release_resource
 callback
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-iio-read-avail-release-docs-v1-1-36919fbd1869@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEkJIWcC/x3MQQqEMAxG4atI1hOwRax6FZlFtL8aECsNyIB49
 ynu3rd5Nxmywmiobsq41DQdBe5T0bzJsYI1FpOvfeNq37Nq4gyJLJfoXnKHGDim2Vj81HYOIYS
 +oXI4Mxb9vffx+zx/0QzSc20AAAA=
X-Change-ID: 20241029-iio-read-avail-release-docs-a2b681e77794
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

The read_avail_release_resource function was introduced in
commit 8a63e3033e72 ("iio: core: add read_avail_release_resource
callback to fix race") without its description. Add it now.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
Link: https://lore.kernel.org/lkml/20241029155022.5f777572@canb.auug.org.au/
---
 include/linux/iio/iio.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 747e89975d369f3c76aa49a96a7dc09f185e2557..3e5c1c3d8f7165f3185ae7893d922e42e930853f 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -434,6 +434,10 @@ struct iio_trigger; /* forward declaration */
  *			type and the number of vals is returned in length. For
  *			ranges, there are always three vals returned; min, step
  *			and max. For lists, all possible values are enumerated.
+ * @read_avail_release_resource: function to release the available values
+ *			potentially allocated during a read_avail() call. Input
+ *			arguments should match those provided in the
+ *			corresponding read_avail() call.
  * @write_raw:		function to write a value to the device.
  *			Parameters are the same as for read_raw.
  * @read_label:		function to request label name for a specified label,

---
base-commit: 9b4071ab8cbe28bd1bc4c533ab944771731fe5f8
change-id: 20241029-iio-read-avail-release-docs-a2b681e77794

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


