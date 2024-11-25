Return-Path: <linux-iio+bounces-12664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 788A29D8DDA
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E35E16A80E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D121BDAAF;
	Mon, 25 Nov 2024 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiQD8U6e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E81C8FD6;
	Mon, 25 Nov 2024 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569405; cv=none; b=ij3wlPCuBKGnDOd0jUipAPNgJw9GYXzVKegFcIOOcgpmcQFTDBExaz2JqSVUL2T91MtLbp7Iq6D4hok58o3mYMVB8no2gNMzHTvShyvcpnGn+c9rbNeMhi8kWah3S2kaP4stzH0RQOTUqIZ/5viKq4+jWO+x7Sn6OHKLJkeDzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569405; c=relaxed/simple;
	bh=vADNLN/wWfKGqJvUQhd1pUc2e9QB++sN3+4D9NpumMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ef9u841F97G7JhkwVRWQ8v+CR/UFtsDFzlIkz0gwodsW4mtDWQ79z2aUeaThM1wJ/kn9GGJiEHz3z8zushk1cFPuNuCiGme+wV0DEIQDEEy+rqLFERtBIrsnIEdE/5xpw/evk4WoAWrUkvvk9ROMQdHDUW21pw/N/rxvl1rKc9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiQD8U6e; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a1639637so8972555e9.1;
        Mon, 25 Nov 2024 13:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569402; x=1733174202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=As5aGrkOK7DaKpc42A89d6jJu2byOcemsiDPjw3sqGE=;
        b=WiQD8U6emvyPlnetcqSEX7aTJFS09NQMf0+di9G9KLfHxRiz4y4MAH6Sy3BeQyq5qS
         FfsGslsqKml0Jx+cS5VimZAyYFbVUmg8gwGSzSWCcvzmDDgrfJ8wG1nrvABS3SUYgsX0
         0xO229KI7W+3rumWNRdHROTMWxRKybTliiKz80gXPj2vxVx1beyKspU5u28LQ4EbNI9M
         WD5cEQ2Xs7OiPamHND45z9I4y0z5em4iqxg5soTrxWV2lpACQARUS3ULzS43mkt1RHVl
         hFIKl2XcYyhhpdxmRRZY+e6ym/fhk8aSbYgSAMYE6CZ5i0aZoI7TWogad3tBc7qEN6E5
         miFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569402; x=1733174202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=As5aGrkOK7DaKpc42A89d6jJu2byOcemsiDPjw3sqGE=;
        b=uVdvYXFPMAeo3wOgCpk61zJ1aSqM66y9ItCXbU+KvD8JUblDVTWVrPp/caHiSM5UAf
         TZIMf4ONo8ysb2cGt56tCah3Q6bpPT4EmPqnkc7t29iaBOfUXAMuNrt/emNXdbSIoFcP
         txYNuio7UQuHO6rRm40xhs+0do2bG7IKXa09h+BqNn3YV9ZWp7VZMBa+A9L8ja0oCHi8
         IeynFXSpvIIB8nM2T+wFcChI/iNUatg99XXjC7qGfFAHIXObj39vqYcFqWB6gHPjpK9q
         6Oy4/gpdTUQb13Vqfv1mIChE7tLUS+yAe0O5qASsBYtnCOVSTxeC2YsXO+Pltu2ysOZy
         2eug==
X-Forwarded-Encrypted: i=1; AJvYcCVvj5jXzK7A9BobKj8xdNT3Ng7oGpABLZAq3Pwrxi3R1fMJPeNZWE9bs07+yjI0p2NV/eUKDwY1Wms=@vger.kernel.org, AJvYcCW9WixQ+Xh0kMFjRG19omOAUtOM3iQiLKi4LKiZT2fZ7uu5T4A2D5KWipOT3BdGlLxP2AZnbtpq5OYyNchH@vger.kernel.org
X-Gm-Message-State: AOJu0YzHiHjduNZHcTPOhifEPUbCZog3wwP0Je9PJwnz+j/MqEasuNiP
	y42YyDc1G8/0ysA9DhDb2zCa5wSK7UmSEwpw/V8TT15aN1p/9UrD3CapxA==
X-Gm-Gg: ASbGncs4N51j145J3MhXqKBGSc6lxYjE66LsOdspNstLc9VwUMroXNWnFk6Eu6LIACY
	dEjLNwa3juBOqhZapkvLh1UXEKdAfhcaMMrC4olmJWpt5YPki7co5ObjcGC6NAdEQA5zOWWPS8d
	07+zLcMT3vliRAXdC0R8i3pMLk0Q2mM4erTwZSCpR2T797EPauiOMo5QPxLn8F3/4AJ5yNUtNs2
	5+peRRQOfrTbKGPYMrtheVm8FSXMGqbWRqw36pfkQXjynV04aV9w43s1eiDyPXuCOMEBrxzN+8H
	mTl43kDczjAUPdfdS57hpHmZ2CgHX0fbWUijZibTB1J+6fzLPXDiBpoc7uaJ9R0nMc77T1du
X-Google-Smtp-Source: AGHT+IFCQe2WG8DRFVTvJX9L4rRafxyiHPzi/YeizB89q0StbLa8q5BTHKw3hYRSoxjtr3jp5/pqWQ==
X-Received: by 2002:a5d:47ad:0:b0:382:359f:5333 with SMTP id ffacd0b85a97d-38260b690bfmr10083144f8f.22.1732569402126;
        Mon, 25 Nov 2024 13:16:42 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-eff8-ad65-1bf6-3f21.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:eff8:ad65:1bf6:3f21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349ca82957sm75236295e9.33.2024.11.25.13.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:16:41 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Nov 2024 22:16:19 +0100
Subject: [PATCH 11/11] iio: core: fix doc reference to
 iio_push_to_buffers_with_ts_unaligned
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-iio_memset_scan_holes-v1-11-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Antoni Pokusinski <apokusinski01@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Gregor Boirie <gregor.boirie@parrot.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732569377; l=1058;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=vADNLN/wWfKGqJvUQhd1pUc2e9QB++sN3+4D9NpumMA=;
 b=Fuhif70f+6JCU6NRL4OZ9jm1XleTzwxMqu9NwKEs7A2m/kQZgS95Z04emW61s1kJkYCujfCZM
 fV0hM7ZvWSSCbVwAGYTLeR98ERKKkwDwECUFy9wMQQgvhw2LYdMdmLv
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use the right name of the function, which is defined in
drivers/iio/industrialio-buffer.c

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 include/linux/iio/iio-opaque.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index a89e7e43e441..4247497f3f8b 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -28,7 +28,7 @@
  * @groupcounter:		index of next attribute group
  * @legacy_scan_el_group:	attribute group for legacy scan elements attribute group
  * @legacy_buffer_group:	attribute group for legacy buffer attributes group
- * @bounce_buffer:		for devices that call iio_push_to_buffers_with_timestamp_unaligned()
+ * @bounce_buffer:		for devices that call iio_push_to_buffers_with_ts_unaligned()
  * @bounce_buffer_size:		size of currently allocate bounce buffer
  * @scan_index_timestamp:	cache of the index to the timestamp
  * @clock_id:			timestamping clock posix identifier

-- 
2.43.0


