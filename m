Return-Path: <linux-iio+bounces-12663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 473209D8DDC
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C668EB2B5EA
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EBC1D45EA;
	Mon, 25 Nov 2024 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmzpGgDv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE4E1D416E;
	Mon, 25 Nov 2024 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569404; cv=none; b=ZBl6Huv0I1yQgholyXB4ceixmpIc5V0Rfhy+iBF8FoHw7csHW+oq0g0mX5VQk8f//nsksIiDYycLtCo3KytVCXFeqXr554FLHm/WGbJBPGhmrlKowE8dSOoT1MADylmPyGX7EYILTSsrxAZgfcLgQTEv940cFlN2Zj11RLtSWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569404; c=relaxed/simple;
	bh=jtXAVyyBRdegS3Ln5CG9DMcyt51iY4DFohUa5RDJWUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B2JWFpqxzqo7udvQizrVD2sIPN/GfxrT3dl0U4VslcjxMm9boSSfaDaO4kIQQ4mSZYZsacuX9z5uRa0PpRsBNluL5FRwKw72EENjZ06BwXV8xYg6n09jfU9cvSQKUoCu46MwztI/QpV1mnZpPcxVuPaNLkir8W1uy+f6wrUCn1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmzpGgDv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3823f1ed492so3308652f8f.1;
        Mon, 25 Nov 2024 13:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569400; x=1733174200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDpYzw8j/kTAN6No6AZGY7FwWe7q/xbx/0O05mcvG5g=;
        b=CmzpGgDv138HG+mrnv0KnJx3tvKZL5MEQj40hxJjemwl8z1mKefgIDl8pJuHBgfc4W
         hvNja/Ndm4XcG9gOkMymgnv54vpzahWGhRF06ebtwOJBXVrYH4K1TUMPV7z+aPQbZMiZ
         Cnwo2udjvu62QsPDoY47AJYB5UPme+UiP1hKjwDaOOWau1nW85niXeB4JdPhpVryVnkt
         lvvKn24J6Zm9NZKzkKib+bpjz39xc1cnyvhTMstG18LNGfUFmeYnciXhkEfXhXrL2yx7
         xAO43flXPcuG80szF1LpC+d0HaMaVJ9nfutdyyhpWlrY2i2qZ6f2qYfy+lQKAtRyeOga
         y62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569400; x=1733174200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDpYzw8j/kTAN6No6AZGY7FwWe7q/xbx/0O05mcvG5g=;
        b=IUmFZnfDYykroISESlw93iYV8cLsdGgJu3Et7oEQhElufrP/bXS9/OAnuoQqglSpDv
         sngbdzN/weoAbuVaUWWAc2uTFvLKrJgcgmFcQS+EQEc1yY65QeHV7kjHVtUhRQr5MM+H
         +5p6cS/H4AhAUKvRvWJMs4LunBWj/WViBEBUMxgcVn0VneVBtdkzjcm9TUU+20a2XSTO
         EG9lFcqlT1EecUkf/Aepi3f1DdkQbJ1qBGrmJb5KV4Gz+1tGzceJEhLM4qevIagx94eQ
         sI5IFC76RFd0OXudzr+/RT4vSBF6Ea36n3ehu5lmA6jHAMAl5aFAhKLd5iiMoVbqTaP0
         ccdg==
X-Forwarded-Encrypted: i=1; AJvYcCVJBU4Yf23TyzByB9ztj+KkDqPw06pBm+SaHT59+Rrq5k7hGnkQJN3bqMC0K329xIjVDKpQWEA/c3BWntiY@vger.kernel.org, AJvYcCWgXGAUN6nwkb5kO35wwXRgPOTXdLUeDLHTvYRhhoP/feLj/y2ZKAHMrEZ1SknA/Q1MFGMVdr5I@vger.kernel.org, AJvYcCXOH0/+ZLtmKIivakDzXf0xhMeA2kdLO1qnPUVLIEwpKVKrt3zANQAA6P2JyFKGcgZ4LBlk1ZLPYqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4W2yRApG4n7Dv3QkVBYGKfYheGo8BvolxOaPaNgbpiqcA3DKv
	stzsiF7E1jXH0ReiH2uqyLtVzMYdh5Il1uFRyb+ENapqiM4R27Z//JlfQA==
X-Gm-Gg: ASbGncteFPPNyidjZ7nTMImRY0jXLnamt9hzrh1eCEDXVmkqFjuic7f4Bes9woGWtLr
	kq+ipVzcLBR69Byts6/EoLv3Hlou1MUXe+gFkmffGHZe5j6uYiWtd/24KdCdmFOfyXjXtG0AnXq
	Sxyg55e5uhljw8tZsYLIxpKLe1J8FOuTYpk2OcvAe0Ozwd/NjeQO6X/PQeUxvQw5tTyW+KnvrGv
	3YtPDk/7Tw4ie+VoYOPQMPCO1UhXs71z1/ZRMgeNniWFpdvut8lGg3s8lEdtMguj/bvt9qcf6Tk
	OoB+suBY2YnEpIqx5yu3T/U/xqmFrDJkC9MNp+K7bgPpMwvOsqUnHahWiKVIyaxorGXv5iQN
X-Google-Smtp-Source: AGHT+IGzyx3Cw7LjdhvmIFBKwru+lK0DGhO/zbiIQucQWbr9SWMIRfIlCpPvo0ULy/gqYTOFbl6ncg==
X-Received: by 2002:a5d:47a9:0:b0:37d:47eb:b586 with SMTP id ffacd0b85a97d-385bf9ee1c5mr747324f8f.4.1732569399802;
        Mon, 25 Nov 2024 13:16:39 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-eff8-ad65-1bf6-3f21.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:eff8:ad65:1bf6:3f21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349ca82957sm75236295e9.33.2024.11.25.13.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:16:38 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Nov 2024 22:16:18 +0100
Subject: [PATCH 10/11] iio: light: as73211: fix information leak in
 triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-iio_memset_scan_holes-v1-10-0cb6e98d895c@gmail.com>
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
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732569377; l=1066;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=jtXAVyyBRdegS3Ln5CG9DMcyt51iY4DFohUa5RDJWUA=;
 b=WZ1QAn5UXThH/3PVorwsqsfc+8c8tznJl6iyhPVJTfjR69q4XK13euee5HATAt3WGtSpBj0Tl
 PccTq5N1HMYB1+Cf6AfQYER716DInkyrcn3viEWjAAYo3Zifxt6EuuY
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'scan' local struct is used to push data to userspace from a
triggered buffer, but it leaves the first channel uninitialized if
AS73211_SCAN_MASK_ALL is not set. That is used to optimize color channel
readings.

Set the temperature channel to zero if only color channels are
relevant to avoid pushing uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: 403e5586b52e ("iio: light: as73211: New driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/as73211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index be0068081ebb..99679b686146 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -675,6 +675,9 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
 		if (ret < 0)
 			goto done;
+
+		/* Avoid leaking uninitialized data */
+		scan.chan[0] = 0;
 	}
 
 	if (data_result) {

-- 
2.43.0


