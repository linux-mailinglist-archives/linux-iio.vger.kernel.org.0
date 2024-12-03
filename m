Return-Path: <linux-iio+bounces-13062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE89E302B
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 00:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D28628429D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 23:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237F20B219;
	Tue,  3 Dec 2024 23:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jARTwjEf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7186920A5F5;
	Tue,  3 Dec 2024 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270152; cv=none; b=NXcOBasmgaJPVGU+lcAWwH/BUsM0hAmE42islSrOno+d9vjBmgvMBQ1Ben3VjxzSeZ7eyfL2crVvlyUIeYTVHxlKMKpD67Iz/4l20db9GEHcZP0s07TKBjd2uKxk572UIngljjA7hP+Hv966DJ5rJIALr98BGFM9G92t1W12yBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270152; c=relaxed/simple;
	bh=cyBeaQMPDUmjguYiw+l5uyptd3ou1PYxJOynjAFQjc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XohSoxGt2vrRIZX2RQDq5jOqD9EdilCsO+cmtvVWaAaZnmnXuMWlFGCwFdPPbjLh1ZHgQKTvM7sZCuQRRXoSYm9YjLh+NOQlO1GMosWNaVMxWqd994a9wuo8RulpGvVVmHls2Rxq+/uq6YKLTX/MGvlaXtPbYUPsTikdGYVQ798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jARTwjEf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so1896405e9.0;
        Tue, 03 Dec 2024 15:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733270149; x=1733874949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADRD2BHODBZiky8Gh1dqilnT9fbY5WGuqoJtO3/r8Kc=;
        b=jARTwjEfVEjS6G+7BAXwrJeUpxY+rVzNo+vm2QL9Hd7OmGNZamVdcZmJhEjlwSgmgA
         PqIjic/Oe3O+Uls48qiY3zYMvfoTT4cT/dF6khHJEd+mQ13h7vZWH0xIg76SSgWVzEYE
         mtgzdFIeIxPp4FnEcLa9aKtK4kP8R7s+BTJBcQJZGvKGMvpiUXWFAdxBDDQJLjuwOOMO
         uIEQSI0lFQfcBBU38MVreSMJwWeNIfwSvQ87cgwTSRj7OQGqgiiDC4oUEryoO1TXWO9A
         6qXZCbaNeGUZYzROp70qzGHX7gOxLHyWmTCrcgGbbjlOZNorb/Y8lmS4kueKpDjEAQ7Y
         n/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733270149; x=1733874949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADRD2BHODBZiky8Gh1dqilnT9fbY5WGuqoJtO3/r8Kc=;
        b=oJYBuPDEJGZIEfNLeTq0GdqaROWpwP9z1L5LOq7LmfVSIRp0Ww8aikdpDg8C/vSLBr
         tJyWhHeKEFKGisiPiojLwt4C9EN03biWciFUjmqD4/3mz7fdd8jr3sy/5CgiE82mfjMa
         Qjnqw3V7BFuNfQZIfo+jaPQkjrm+aje680wjC/KkubNrJo9g95cvOrhFH0x5UNd3uqxj
         Mb3a3Cm2HStaXxPickcOFcgXq5If3Dh0c/+Xu03wpZRFkl0++UPyKCGZgMe/5mLLC6tl
         B7D3godIwkzplHqwsPBW8bIeQb41Lk0qX0qhXZyC36572T15E1T3M/OmnOVmT3LzgSQ5
         8dPw==
X-Forwarded-Encrypted: i=1; AJvYcCUfBoXsnoRFAdlAP9SPUPo38LmD1rSFzrQf9muxac1vdpcE5wT/79IdzgnNCisTPuU81nSMR6teyNQ=@vger.kernel.org, AJvYcCVfBigFv/bR8UmBog/CJHZTqxzBTmwE3Wa8ejM+da6jAHLrJi9lXUUTpnN1NXYmMZLZia0Zj1zZ@vger.kernel.org, AJvYcCWoDAJ1ipU3FuVP+puN0LxaUmUXDSTKw4RKqn/GdIvogB7YKgHim5MGZrC0efziyUTDfm2+SEc/m8zDHNGt@vger.kernel.org
X-Gm-Message-State: AOJu0YyMmTMrv5PqNNxcXRu2f06gCEfslQUsTMLcszVN3WBVDZOIOEW3
	rP3r4lhycXhxFOhgp26MABstLcYcS3Lo6jEXZmlj8Ij2Z+Ov3GK7K0DO7A==
X-Gm-Gg: ASbGncv5XPHkiqvwn/QwSr/iKIx3usU06YdDxoAxY91akbu0K82XGFIPBP4NtZalgDy
	yoEZjh+7avWmY9bO/LtgcYDtdPRF69S/DxPMso7lPQ3TCLSixn5oTBU9ZW5tFXNGZr9sEyr3Clo
	U06Ubs9/1IOZdv2kg//XA3dGj4jOBX25o4Jmhr1pouvGg4pQ5WtSpll+KyZSLGzWIdhP3MTdnam
	o3Bw2maslegouzONGdTr/4A1HH8PzVqNiqnKzYB/bh5ZsUVxR4x31uKOdENLOf1mdoIdli7wKt2
	n8cj5mu13wAD0SwZU8/+6318vtq6lP0wNNTUxxQQtnitkSswN06og8CLDh/eHw8piGjq7fz2
X-Google-Smtp-Source: AGHT+IFU39qknHn01rcDVQAYlVtkPZT77XX0Jfij9OIsdSSF3rWVtaAzVi5nCJCpMx4tWYoIJwiJEg==
X-Received: by 2002:a05:600c:6c8a:b0:434:8e8a:d4ec with SMTP id 5b1f17b1804b1-434afc3b6e1mr228606085e9.13.1733270148440;
        Tue, 03 Dec 2024 15:55:48 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-5e3a-77ab-7b2b-a993.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:5e3a:77ab:7b2b:a993])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e287sm3871025e9.12.2024.12.03.15.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:55:48 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 04 Dec 2024 00:55:31 +0100
Subject: [PATCH v2 1/2] iio: temperature: tmp006: fix information leak in
 triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-iio_memset_scan_holes-v2-1-3f941592a76d@gmail.com>
References: <20241204-iio_memset_scan_holes-v2-0-3f941592a76d@gmail.com>
In-Reply-To: <20241204-iio_memset_scan_holes-v2-0-3f941592a76d@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Antoni Pokusinski <apokusinski01@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Christian Eggers <ceggers@arri.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733270145; l=1016;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=cyBeaQMPDUmjguYiw+l5uyptd3ou1PYxJOynjAFQjc8=;
 b=GBhemKYOcWyRnKqstLEI96tDGi0Fushqy/PxeqkgN+El+4LbqkMb8Ss6ObyHLfh7MoV2Nb7ZU
 WU+5PmQOnIXDZN3FhEiKGLhFQKdb/oyETby3CmyNEr8FE9lpj3dNLlK
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'scan' local struct is used to push data to user space from a
triggered buffer, but it has a hole between the two 16-bit data channels
and the timestamp. This hole is never initialized.

Initialize the struct to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/temperature/tmp006.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 0c844137d7aa..02b27f471baa 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -252,6 +252,8 @@ static irqreturn_t tmp006_trigger_handler(int irq, void *p)
 	} scan;
 	s32 ret;
 
+	memset(&scan, 0, sizeof(scan));
+
 	ret = i2c_smbus_read_word_data(data->client, TMP006_VOBJECT);
 	if (ret < 0)
 		goto err;

-- 
2.43.0


